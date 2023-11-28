.class public Lcom/example/patch/PatchActivity;
.super Landroid/app/Activity;
.source "PatchActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/example/patch/PatchActivity$CopyAssetsTask;
    }
.end annotation


# static fields
.field private static final logger:Ljava/util/logging/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 23
    const-string v0, "PatchActivity"

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lcom/example/patch/PatchActivity;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic access$000()Ljava/util/logging/Logger;
    .locals 1

    .line 20
    sget-object v0, Lcom/example/patch/PatchActivity;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 27
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 28
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 29
    .local v0, "layout":Landroid/widget/LinearLayout;
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 31
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 34
    .local v1, "textView":Landroid/widget/TextView;
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 37
    invoke-virtual {p0, v0}, Lcom/example/patch/PatchActivity;->setContentView(Landroid/view/View;)V

    .line 46
    const-string v2, "Patching...\nIf this is your first time running the mod, make sure to restart it after the ingame download, or else the mod won't take effect :)"

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 47
    sget-object v2, Lcom/example/patch/PatchActivity;->logger:Ljava/util/logging/Logger;

    const-string v3, "Patching"

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->warning(Ljava/lang/String;)V

    .line 48
    new-instance v2, Lcom/example/patch/PatchActivity$CopyAssetsTask;

    invoke-direct {v2, p0}, Lcom/example/patch/PatchActivity$CopyAssetsTask;-><init>(Landroid/content/Context;)V

    const-string v3, "mods"

    filled-new-array {v3}, [Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/example/patch/PatchActivity$CopyAssetsTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 51
    return-void
.end method
