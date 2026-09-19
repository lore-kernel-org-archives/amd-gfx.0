Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA379C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F9C10E3EC;
	Mon, 21 Sep 2026 07:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kz2wbrII";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7CD10E1BD
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 16:50:18 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b910bdf2eso1194941a91.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789836618; x=1790441418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4Qqo2m5lZfr3OAGZ6npJ+URqdVjHxYgzHywKwbEg8A=;
 b=kz2wbrII9z4hQd8AqYrFSHyanA/rz2aJlRvvt2+MpiSSDUc2gDPBF5zqxAxJ8UQWRa
 yjzTq7HCQsty/x6c4fPCV3kEHB7JnWQeGYwbfGwtQbAuGwHuMxxPIDZwdjcG64OkHQJG
 xNQKqcJLTbErt3FYiHNchgswVQY12zWRefrBft3smzrHGroqGEdo1mQjhxk4qP1Ys7eM
 eWkaZPS2h9UOcycwBDWYT5L7/5v7Ne+iFHPhn1QNXin8S+YZhSGdlaaBIOKEpdZ/NAie
 RA7E32fRGhGRwe3DPJMlqo4CNOxTRAPio4CMQMxWuCdifELlgUQS5RZ52hL9XJpGS379
 7g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836618; x=1790441418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+4Qqo2m5lZfr3OAGZ6npJ+URqdVjHxYgzHywKwbEg8A=;
 b=vbNq5LZTdSQk/E/qT545Fim6oGikXtMAp/bucLAIRIx8XKP0SxEJvUYBPu/KiV9FIH
 4fbkVTZCvesxF6ADc1xm/Z5C35BkbajMF16POEfrddBaSl88yaoPXqtL+r2l8fWOF+IM
 C+hlzyPsADYbbZyfTS4y7Nk5MmksxgZX5zDvZ5NW3cLUcp4c9Z6VLwyDocpMbCpqS6rx
 dm1uEBzzIhZHcLxrr6KAN+2m/aKseD0CZ7pS2DfxGC52h8F/VDLLzEUW3JGRmUMtGpsj
 vwlcEjVHP8KdGcTU+hyoEblpP1lhWmJY2XkTFi42aw7x+pKqHm4wOUIyo/3XPLOF9PO8
 IHvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLTIKMHKUv7AMlDfoJ1bM7n0K+kZmeeV6Uh24RRKnToVjhUFtuS0Juu10bamQGWeLYGFsTj58M@lists.freedesktop.org
X-Gm-Message-State: AFuF++kz/wzQB4Z+1y5Gly8w2mU9ybWwf+IZgtBnC4Jn6FaR8sFKKuhg
 52K6A3So51+gGG9QuWo+YmpevX8In8VF/lezBQpjyKbt4od5CBN3TZJF
X-Gm-Gg: AYBFou2RFReKzICr/t2gYhNijsSI7hgjmPQ84TRPOWRTDT01dfqg86IhmX/O73kH+UR
 ZZN+Mpeg2FeQBA5TZ0T/6SCpTYT7zgcMYct/qabHcqXQWfGfWLojiyQG+e4dp6C8Rc1HeZyL/59
 UmcixW8UGthSmWYVORPPxBZP2DKvVOin/BgaTaA2jTbYaC3NODI4ocXrG30jCT9wwl1UKPh+gUU
 gOqKn2jyL0wB38vOnI9UGYnyG0byneWv4GL0A+CX1eU1vjPJknxcA10ImNTaEIIrbc1BULf0s3X
 AK+ALDPI51/jSQTzDLrAUhfo6fPZDtJ10D7fVbKLtQUgjTkMT0oACdoCWRq0zRgqeRm7LjB6wlu
 ZCDZKa/mDOaBauzIYAZf2QfJlP4YjPo8lE/Umrp0MuIWFp5zh+YtQOfl0kLgxNqFpS+shormslC
 +/RaNaSyMBKcpdSPTjhnhZfQdnnxG/iYIQcR3ZkQEs3RqCq3sPmLVjPLlwEF36knhxOxs4hJmQ0
 A==
X-Received: by 2002:a17:90b:52cf:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39e54bd0941mr10914911a91.15.1789836618094; 
 Sat, 19 Sep 2026 09:50:18 -0700 (PDT)
Received: from G15-5520 ([103.206.144.198]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55cef9bsm7531914c88.10.2026.09.19.09.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:50:17 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] drm/amdgpu: replace deprecated function strcpy() with
 strscpy()
Date: Sat, 19 Sep 2026 16:49:59 +0000
Message-ID: <20260919165000.36173-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:11:54 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prefer using strscpy() over the deprecated strcpy() function to
populate ras_block.ras_comm.name.

No functional change.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a6f95ff47d24..8bd91314d0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1132,7 +1132,7 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "gfx");
+	strscpy(ras->ras_block.ras_comm.name, "gfx");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->gfx.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 5a60d69a3e1f..3fa533d5b18c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -39,7 +39,7 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "hdp");
+	strscpy(ras->ras_block.ras_comm.name, "hdp");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__HDP;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->hdp.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 363b99168478..969ebc9d5a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -328,7 +328,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "jpeg");
+	strscpy(ras->ras_block.ras_comm.name, "jpeg");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
 	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 9a7f7d2b2767..42a05b5a2d30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -87,7 +87,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -112,7 +112,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -137,7 +137,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 0f6b1021fef3..9796428e44e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -36,7 +36,7 @@ int amdgpu_mmhub_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mmhub");
+	strscpy(ras->ras_block.ras_comm.name, "mmhub");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->mmhub.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index e4c8e98725f0..785bf29d2c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -37,7 +37,7 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "pcie_bif");
+	strscpy(ras->ras_block.ras_comm.name, "pcie_bif");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__PCIE_BIF;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->nbio.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..4e520d16e550 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -327,7 +327,7 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "sdma");
+	strscpy(ras->ras_block.ras_comm.name, "sdma");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->sdma.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 71d34fd09385..69fdd075e14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -315,7 +315,7 @@ int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+	strscpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->umc.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 17db7264269e..bc7b5733f581 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1333,7 +1333,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "vcn");
+	strscpy(ras->ras_block.ras_comm.name, "vcn");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
 	adev->vcn.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 45e31b3daf06..5babcba1907e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1341,7 +1341,7 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl");
+	strscpy(ras->ras_block.ras_comm.name, "xgmi_wafl");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__XGMI_WAFL;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->gmc.xgmi.ras_if = &ras->ras_block.ras_comm;
-- 
2.53.0

