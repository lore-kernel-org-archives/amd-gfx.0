Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF7BC2BA83
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37531222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcxvn85S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37531222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6219B6E28B;
	Thu, 13 Feb 2020 11:59:37 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE846E28B;
 Thu, 13 Feb 2020 11:59:36 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p9so5914639wmc.2;
 Thu, 13 Feb 2020 03:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RYO9pjI3MdTVDV1Nsqy7e4qmWd8htYw1F2u1Jn0Byl8=;
 b=vcxvn85S8kaFPZRQ/qKocspVRND+cfMakDQGVIIHa0OMKqdDnbeb2oED8pIU0Ru8yA
 TXR2rU94ug75NsLWddf/bjcmbEImUqzgnXoXdlEiPVYkOROt2N3/ELtnNg2zhfmMlrRW
 bMzseZ8mQuK6kRcLMUKRvQp56CGQD74i33iY3v4Kq9Po+0UEQoA/ZCZd8TzK7V5n5BA9
 COQWaAqXL74w5O1V8T9NQbXurK/taNtks1tNC7vCxlAHXxdjCCQlS0hhuHPID1AFO/Hs
 04auTWa3goHldG3HDqjkf0wll/lRrJ1oT1x4WvXnwfvACtGE/qVUzVpurljk6bJCpNjs
 v+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RYO9pjI3MdTVDV1Nsqy7e4qmWd8htYw1F2u1Jn0Byl8=;
 b=KzVp4AB8MwVFg7FuGuq4bc2pVVurbbZwPlvP5lkGeKwgxKOCN6U3yQ9u8/B/klZhgA
 T1jCG1DjngL/6Rzf/zebo9RjoTOsOMQlZXjbn2e5/qaZSr+gIFOlCmyBAf0DjXibJ4+n
 TWNcQ9BxSr9HWqrC5KbK4U3EMLvTBU+jyUyFotpcr2sco1JVqtkHByW8akC4s5sKuOWZ
 ++pjANAkg/8cHzOh0V0yN1gO+aY3+Pz/ru0+zpu9Pv5wMbanDjG9MQimJfyLOLbvWDxa
 ia+iwbpT6oWyqP8Ex3hOmwREzpa8rzlDg40tss1jLnTnYFFdg1Jz7l6GngeC1zI8AwQd
 ldSQ==
X-Gm-Message-State: APjAAAUBJxyjWgyi+/vOiUEifO7ImP49Muf3+03a4Hh5/fKg7z0NIcmD
 ROBrFPCvAkU4dTMW59AT8/f5pKeReD+1SQ==
X-Google-Smtp-Source: APXvYqywz0FBVtqeBiY690I9UiZ7XkCu9RgR6oGtTsPOORRUEnGsm93Eh/lBt7PhYNduciKUdrx39w==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr5766938wmf.105.1581595174509; 
 Thu, 13 Feb 2020 03:59:34 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2A5E004DB99F42976E8A13.dip0.t-ipconnect.de.
 [2003:c5:8f2a:5e00:4db9:9f42:976e:8a13])
 by smtp.gmail.com with ESMTPSA id y131sm2803985wmc.13.2020.02.13.03.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 03:59:34 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 2/6] drm/radeon: don't use ttm bo->offset
Date: Thu, 13 Feb 2020 13:01:59 +0100
Message-Id: <20200213120203.29368-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213120203.29368-1-nirmoy.das@amd.com>
References: <20200213120203.29368-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/radeon/radeon.h        |  1 +
 drivers/gpu/drm/radeon/radeon_object.h | 16 +++++++++++++++-
 drivers/gpu/drm/radeon/radeon_ttm.c    |  4 +---
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index d59b004f6695..97cfcc2870af 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2823,6 +2823,7 @@ extern void radeon_ttm_set_active_vram_size(struct radeon_device *rdev, u64 size
 extern void radeon_program_register_sequence(struct radeon_device *rdev,
 					     const u32 *registers,
 					     const u32 array_size);
+struct radeon_device *radeon_get_rdev(struct ttm_bo_device *bdev);
 
 /*
  * vm
diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/radeon/radeon_object.h
index d23f2ed4126e..4d37571c7ff5 100644
--- a/drivers/gpu/drm/radeon/radeon_object.h
+++ b/drivers/gpu/drm/radeon/radeon_object.h
@@ -90,7 +90,21 @@ static inline void radeon_bo_unreserve(struct radeon_bo *bo)
  */
 static inline u64 radeon_bo_gpu_offset(struct radeon_bo *bo)
 {
-	return bo->tbo.offset;
+	struct radeon_device *rdev;
+	u64 start = 0;
+
+	rdev = radeon_get_rdev(bo->tbo.bdev);
+
+	switch(bo->tbo.mem.mem_type) {
+	case TTM_PL_TT:
+		start = rdev->mc.gtt_start;
+		break;
+	case TTM_PL_VRAM:
+		start = rdev->mc.vram_start;
+		break;
+	}
+
+	return (bo->tbo.mem.start << PAGE_SHIFT) + start;
 }
 
 static inline unsigned long radeon_bo_size(struct radeon_bo *bo)
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 098bc9f40b98..b10654494262 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -56,7 +56,7 @@
 static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
 static void radeon_ttm_debugfs_fini(struct radeon_device *rdev);
 
-static struct radeon_device *radeon_get_rdev(struct ttm_bo_device *bdev)
+struct radeon_device *radeon_get_rdev(struct ttm_bo_device *bdev)
 {
 	struct radeon_mman *mman;
 	struct radeon_device *rdev;
@@ -87,7 +87,6 @@ static int radeon_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 		break;
 	case TTM_PL_TT:
 		man->func = &ttm_bo_manager_func;
-		man->gpu_offset = rdev->mc.gtt_start;
 		man->available_caching = TTM_PL_MASK_CACHING;
 		man->default_caching = TTM_PL_FLAG_CACHED;
 		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEMTYPE_FLAG_CMA;
@@ -109,7 +108,6 @@ static int radeon_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	case TTM_PL_VRAM:
 		/* "On-card" video ram */
 		man->func = &ttm_bo_manager_func;
-		man->gpu_offset = rdev->mc.vram_start;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED |
 			     TTM_MEMTYPE_FLAG_MAPPABLE;
 		man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
