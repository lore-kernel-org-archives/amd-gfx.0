Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50C5D116F9
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 15:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568E310E17B;
	Tue,  2 Dec 2025 15:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cz3Jxhm7";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DB810E0A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 15:12:46 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b7380f66a8bso855520166b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Dec 2025 07:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764688365; x=1765293165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BXk4axJ50IKniCYDAnoyzvv4NWDxDGZqCipWm988sG0=;
 b=cz3Jxhm736205BiAleGCSIXUzSjB7Zl2mSEA1PsL4MDTDdb65U03amGjK51upqWdUJ
 Qcg8fkFbr7737uTAHmXI9gS9SeBZEJOdUHsUeuPUIs9goNJPaW6LsOcedpsX4i+gE5MD
 2PWUpvfaVDRLEBQZfAGejQ88kb/BeW6v4OuJcT9MTG3QHDqgiz+Rz5gx9IrX2vYHimRJ
 PvN1SnjNF+I3l4aEb2SOp+UePcivWk9UE0dRE80GvT5O9/aTS3KlIKzOuXG2Fg8m8zfG
 avXfDmraBVwtlEbfdMtXV5P2HAJ3NoRrK2Jvly0kdflgagqaQ9VxZLeQzjVfZur0lOc0
 lYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764688365; x=1765293165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BXk4axJ50IKniCYDAnoyzvv4NWDxDGZqCipWm988sG0=;
 b=f/8T90ETxmpDCT8Ayi2ce7c6WkkCCZeu/VQlgJMJTjkgoLi2w9wEXl3abRKmRRDAmP
 a65Y4+cZxkmGxrRDxrE6A4Vu+kEbxeXbpTq6hZ0gec8RRS5kM7jFE2DRQflMBUWrvh3o
 722evmanR8pYK3THMuj5UuuuJbYMDPFVOhbvqMJXVwgsoy/FQxGiE6u6hvuXWD4aRgZV
 Pa9ifBD51ktkcdVxLm7QjSSRTuekVPdSLxoMvobcP0Cn4tp+2CuKmNLuuLdgy8XihkBh
 oV1+WslGr0pjn/uUdxq8z2kn42h4k3I82wOTlenJnJLIIiq5BbNG/4q5z2rE6WAXV9ol
 bq/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgt50Mv003KKGUbIe+huhK/LRJ+Yi4TII0E80h0urJUzquy5EnYcF2FjDq9wmKCL2S5UzBHgcy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZnHsCSY6edGLk/5Q3Vk1xrbuVtx8C4yuAe7eSTHVn3Bpy4nAv
 qA4rIbkt6fqCQC07pAPGP8fK+NCpi6MEoCqGDz4J9Eiwqx9+9CXslHSV
X-Gm-Gg: ASbGncsfljRuKYdmXqwsDD8y+tKWs48viEXnMc2/+2RT6APQkQ63SpUkdZWyF1yrsXT
 qJIKNsSs+HqELQZ85C4pYWMVfAEdMpMGOVV+kHqlH5Myh161mAq0zdCjXSzwgH+VWjhwylfaTpK
 UVTPTUi+xCdjpBzitC1sf/8E2hO9TVggOOK4zaqIuOK6bZwQdqwLZXt0YapwiOfPPEZRseP7k58
 TqQRW5qrCfzz9Y0uT8NlzjyG0ai8CfJsSM9HhEjPJY0U3ExcWvbYBcamkQx2ienGdY1gQ4SYNEV
 TLoxH7iW9TtloTsrDXF55JRSdYzp1hMIFiwP9SqJSeVRMFtoxIkFyn+mRpxIx8ZFYulqm7UgsLb
 AOs6u5AO70kfe4TzieTErXu+GkHa/0jY8Dk0l2cXTxmmTo2ao6EZHR04z8Obmb+bEMrV8CnUXtV
 GZlDwFGJQxzZNR3MihIfKS/jn0
X-Google-Smtp-Source: AGHT+IHKKv7t8v4hvtQfa6Voi+OgogKmD+BR0cnpwLz5zPPKtuLa2PT4AkW9IPsDM9crGfP45zXt7w==
X-Received: by 2002:a17:907:7287:b0:b76:4c16:6afa with SMTP id
 a640c23a62f3a-b767170bfb8mr4999585866b.28.1764688364430; 
 Tue, 02 Dec 2025 07:12:44 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1566:ae00:9ed7:ba17:59d5:1db2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751035c3bsm15520882a12.19.2025.12.02.07.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 07:12:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com, srinivasan.shanmugam@amd.com, Leo.Liu@amd.com,
 Ruijing.Dong@amd.com, amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 3/3] drm/amdgpu: remove AMDGPU_GEM_DOMAIN_DOORBELL
Date: Tue,  2 Dec 2025 16:12:41 +0100
Message-ID: <20251202151241.2212-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202151241.2212-1-christian.koenig@amd.com>
References: <20251202151241.2212-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Never activated as UAPI and it turned out that this was to inflexible.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
 include/uapi/drm/amdgpu_drm.h              |  6 +-----
 4 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9e9b94dcb699..4fd8121f9d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -458,9 +458,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
-		return -EINVAL;
-
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fe51087a54a9..0584c7383c19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,14 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
-	if (domain & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
-		places[c].fpfn = 0;
-		places[c].lpfn = 0;
-		places[c].mem_type = AMDGPU_PL_MMIO_REMAP;
-		places[c].flags = 0;
-		c++;
-	}
-
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -1566,8 +1558,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
 		return AMDGPU_PL_OA;
 	case AMDGPU_GEM_DOMAIN_DOORBELL:
 		return AMDGPU_PL_DOORBELL;
-	case AMDGPU_GEM_DOMAIN_MMIO_REMAP:
-		return AMDGPU_PL_MMIO_REMAP;
 	default:
 		return TTM_PL_SYSTEM;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 52c2d1731aab..912c9afaf9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -168,8 +168,6 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
 		return AMDGPU_GEM_DOMAIN_OA;
 	case AMDGPU_PL_DOORBELL:
 		return AMDGPU_GEM_DOMAIN_DOORBELL;
-	case AMDGPU_PL_MMIO_REMAP:
-		return AMDGPU_GEM_DOMAIN_MMIO_REMAP;
 	default:
 		break;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 6927c864a6d1..0d743fe92146 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -105,8 +105,6 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
  * signalling user mode queues.
- *
- * %AMDGPU_GEM_DOMAIN_MMIO_REMAP	MMIO remap page (special mapping for HDP flushing).
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -115,15 +113,13 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
-#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
 					 AMDGPU_GEM_DOMAIN_OA |	\
-					 AMDGPU_GEM_DOMAIN_DOORBELL | \
-					 AMDGPU_GEM_DOMAIN_MMIO_REMAP)
+					 AMDGPU_GEM_DOMAIN_DOORBELL)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.43.0

