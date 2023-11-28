.class Lcom/example/patch/PatchActivity$CopyAssetsTask;
.super Landroid/os/AsyncTask;
.source "PatchActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/example/patch/PatchActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "CopyAssetsTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field private final context:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 57
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    .line 58
    iput-object p1, p0, Lcom/example/patch/PatchActivity$CopyAssetsTask;->context:Landroid/content/Context;

    .line 59
    return-void
.end method

.method private copyAssets(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 19
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "path"    # Ljava/lang/String;
    .param p3, "relativePath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 79
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    .line 80
    .local v2, "assetManager":Landroid/content/res/AssetManager;
    invoke-virtual {v2, v1}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 82
    .local v3, "assets":[Ljava/lang/String;
    if-nez v3, :cond_0

    .line 83
    return-void

    .line 86
    :cond_0
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v4

    .line 88
    .local v4, "outputDir":Ljava/io/File;
    array-length v5, v3

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v5, :cond_4

    aget-object v7, v3, v6

    .line 89
    .local v7, "asset":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 90
    .local v8, "fullPath":Ljava/lang/String;
    invoke-virtual {v2, v8}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v10

    .line 91
    .local v10, "subAssets":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Ljava/lang/String;->isEmpty()Z

    move-result v11

    if-eqz v11, :cond_1

    move-object/from16 v12, p3

    move-object v9, v7

    goto :goto_1

    :cond_1
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v12, p3

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 93
    .local v9, "newRelativePath":Ljava/lang/String;
    :goto_1
    const-string v11, " to "

    if-eqz v10, :cond_3

    array-length v13, v10

    if-nez v13, :cond_2

    move-object/from16 v13, p1

    goto :goto_2

    .line 105
    :cond_2
    invoke-static {}, Lcom/example/patch/PatchActivity;->access$000()Ljava/util/logging/Logger;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Copying directory "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v13, v11}, Ljava/util/logging/Logger;->warning(Ljava/lang/String;)V

    .line 106
    move-object/from16 v13, p1

    invoke-direct {v0, v13, v8, v9}, Lcom/example/patch/PatchActivity$CopyAssetsTask;->copyAssets(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v16, v2

    move-object/from16 v17, v3

    move-object/from16 v18, v4

    goto :goto_3

    .line 93
    :cond_3
    move-object/from16 v13, p1

    .line 95
    :goto_2
    invoke-virtual {v2, v8}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v14

    .line 96
    .local v14, "in":Ljava/io/InputStream;
    new-instance v15, Ljava/io/File;

    invoke-direct {v15, v4, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 97
    .local v15, "outFile":Ljava/io/File;
    invoke-virtual {v15}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/io/File;->mkdirs()Z

    .line 98
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v15}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 99
    .local v1, "out":Ljava/io/OutputStream;
    move-object/from16 v16, v2

    .end local v2    # "assetManager":Landroid/content/res/AssetManager;
    .local v16, "assetManager":Landroid/content/res/AssetManager;
    invoke-static {}, Lcom/example/patch/PatchActivity;->access$000()Ljava/util/logging/Logger;

    move-result-object v2

    move-object/from16 v17, v3

    .end local v3    # "assets":[Ljava/lang/String;
    .local v17, "assets":[Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v4

    .end local v4    # "outputDir":Ljava/io/File;
    .local v18, "outputDir":Ljava/io/File;
    const-string v4, "Copying file "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->warning(Ljava/lang/String;)V

    .line 100
    invoke-direct {v0, v14, v1}, Lcom/example/patch/PatchActivity$CopyAssetsTask;->copyFile(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    .line 101
    invoke-virtual {v14}, Ljava/io/InputStream;->close()V

    .line 102
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 103
    .end local v1    # "out":Ljava/io/OutputStream;
    .end local v14    # "in":Ljava/io/InputStream;
    .end local v15    # "outFile":Ljava/io/File;
    nop

    .line 88
    .end local v7    # "asset":Ljava/lang/String;
    .end local v8    # "fullPath":Ljava/lang/String;
    .end local v9    # "newRelativePath":Ljava/lang/String;
    .end local v10    # "subAssets":[Ljava/lang/String;
    :goto_3
    add-int/lit8 v6, v6, 0x1

    move-object/from16 v1, p2

    move-object/from16 v2, v16

    move-object/from16 v3, v17

    move-object/from16 v4, v18

    goto/16 :goto_0

    .line 109
    .end local v16    # "assetManager":Landroid/content/res/AssetManager;
    .end local v17    # "assets":[Ljava/lang/String;
    .end local v18    # "outputDir":Ljava/io/File;
    .restart local v2    # "assetManager":Landroid/content/res/AssetManager;
    .restart local v3    # "assets":[Ljava/lang/String;
    .restart local v4    # "outputDir":Ljava/io/File;
    :cond_4
    return-void
.end method

.method private copyFile(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    .locals 4
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 112
    const/16 v0, 0x400

    new-array v0, v0, [B

    .line 114
    .local v0, "buffer":[B
    :goto_0
    invoke-virtual {p1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    move v2, v1

    .local v2, "read":I
    const/4 v3, -0x1

    if-eq v1, v3, :cond_0

    .line 115
    const/4 v1, 0x0

    invoke-virtual {p2, v0, v1, v2}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    .line 117
    :cond_0
    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 53
    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/example/patch/PatchActivity$CopyAssetsTask;->doInBackground([Ljava/lang/String;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected varargs doInBackground([Ljava/lang/String;)Ljava/lang/Void;
    .locals 4
    .param p1, "paths"    # [Ljava/lang/String;

    .line 64
    :try_start_0
    iget-object v0, p0, Lcom/example/patch/PatchActivity$CopyAssetsTask;->context:Landroid/content/Context;

    const/4 v1, 0x0

    aget-object v1, p1, v1

    const-string v2, ""

    invoke-direct {p0, v0, v1, v2}, Lcom/example/patch/PatchActivity$CopyAssetsTask;->copyAssets(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 67
    goto :goto_0

    .line 65
    :catch_0
    move-exception v0

    .line 66
    .local v0, "e":Ljava/io/IOException;
    invoke-static {}, Lcom/example/patch/PatchActivity;->access$000()Ljava/util/logging/Logger;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error copying assets"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/IOException;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->severe(Ljava/lang/String;)V

    .line 68
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .line 53
    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/example/patch/PatchActivity$CopyAssetsTask;->onPostExecute(Ljava/lang/Void;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/Void;)V
    .locals 4
    .param p1, "unused"    # Ljava/lang/Void;

    .line 73
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    .line 74
    invoke-static {}, Lcom/example/patch/PatchActivity;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    const-string v1, "Finished patching. Launching..."

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->warning(Ljava/lang/String;)V

    .line 75
    iget-object v0, p0, Lcom/example/patch/PatchActivity$CopyAssetsTask;->context:Landroid/content/Context;

    new-instance v1, Landroid/content/Intent;

    iget-object v2, p0, Lcom/example/patch/PatchActivity$CopyAssetsTask;->context:Landroid/content/Context;

    const-class v3, Lcom/example/sgf/MainActivity;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 76
    return-void
.end method
