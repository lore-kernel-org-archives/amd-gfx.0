Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2793C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A1E10E4CA;
	Wed, 16 Nov 2022 16:01:24 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A871D10E4C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:01:16 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so45104046ejb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Me88OlyUL6R6SVrsVozNhy3pnhRGlmW19xI4YzTYQ6o=;
 b=mnhFbD02hLugHSFV3zmfL2hrGY3zDSfaI3m4cQYXpf0HBWM2jPG/CmoiYw3gjn+aNz
 0bKg8aAhKkXVXjBpBHlLIKbusphr+jx0wqiY671oCUB7lF5yXDZyGXT2/UmMOLvFYTA2
 353f6+ZrFRbHqy/dcFDrCJ2qhGiR96SiE9I2DL8pinU7IS1Rt1AOLX5YEuYi/YLOJQaX
 pLTj1jXnxhCivtDS2aoy0cBJgUE1n+pC4sqTHcZ2uIyoFtaRXpXRocz34emChfSAMIpw
 c/Hn8Rez8Yl/PmqPomFosGP7o+Lx+ArsmrO7Lix0emhBLCE4MC2QQGqYGNYtxo8XdhLA
 sLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Me88OlyUL6R6SVrsVozNhy3pnhRGlmW19xI4YzTYQ6o=;
 b=KleyeE41BYlJSprIWk0uu/w5UpC8gTgOQAk3zEKzx7OTR7fHOiNHMyvUd4DCIdwZVk
 GHOMPrPZ/FE38m6xw4oFF5uA9der/nLlDUgvfumUG937c/S6JtPQ43Lg8DT42wpDiVfP
 yoCYYi6335ppoHVIs5Ko/xs5Lk5JRr6sL9NMzPT8n0W/FD5X++Y8LfyBMQsXXH4QhXYs
 8VlfAufXMSMhT6JZXVFJv44KN93/U3JDAj3YHoIGOKoqrkRu8xGy918eigrsqnhpklh2
 Ig5zncOyKRfiE5IpzwcsaFDD51HryBv/pGBojQ6FaqcN2zLdR0yZD9YoXxFc8EbXAaJa
 LjZg==
X-Gm-Message-State: ANoB5plP1zFqWZQFXYXjOHYaDMAKLASAx4sUhckHeqCf82adJkf7RiWY
 bgNmUC1sUvnQMwUHe/5PSOOMUR/ha3A=
X-Google-Smtp-Source: AA0mqf5k6GprPQeO4wlXhVq8BNo/EnGb0+SxrxuwJL1cAczXfMp+ntDuHBr9qIRnTNIFfhr4FWDFqA==
X-Received: by 2002:a17:906:b30d:b0:799:a731:b44d with SMTP id
 n13-20020a170906b30d00b00799a731b44dmr18185382ejz.405.1668614474938; 
 Wed, 16 Nov 2022 08:01:14 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 lb17-20020a170907785100b00734bfab4d59sm7139097ejc.170.2022.11.16.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 08:01:14 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com,
 alexdeucher@gmail.com
Subject: [PATCH 2/3] drm/amdgpu: stop freeing PSP buffers during suspend
Date: Wed, 16 Nov 2022 17:01:10 +0100
Message-Id: <20221116160111.3226-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116160111.3226-1-christian.koenig@amd.com>
References: <20221116160111.3226-1-christian.koenig@amd.com>
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

That the PSP code tries to free the memory during suspend is quite
broken and leads to problems during resume.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 30 ++++++++++---------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0a8c30475dda..470cd660c450 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -511,11 +511,10 @@ static int psp_sw_fini(void *handle)
 	kfree(cmd);
 	cmd = NULL;
 
-	if (psp->km_ring.ring_mem)
-		amdgpu_bo_free_kernel(&adev->firmware.rbuf,
-				      &psp->km_ring.ring_mem_mc_addr,
-				      (void **)&psp->km_ring.ring_mem);
-
+	psp_free_shared_bufs(psp);
+	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+			      &psp->km_ring.ring_mem_mc_addr,
+			      (void **)&psp->km_ring.ring_mem);
 	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
@@ -2635,8 +2634,6 @@ static int psp_hw_fini(void *handle)
 
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 
-	psp_free_shared_bufs(psp);
-
 	return 0;
 }
 
@@ -2651,7 +2648,7 @@ static int psp_suspend(void *handle)
 		ret = psp_xgmi_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate xgmi ta\n");
-			goto out;
+			return ret;
 		}
 	}
 
@@ -2659,40 +2656,40 @@ static int psp_suspend(void *handle)
 		ret = psp_ras_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate ras ta\n");
-			goto out;
+			return ret;
 		}
 		ret = psp_hdcp_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate hdcp ta\n");
-			goto out;
+			return ret;
 		}
 		ret = psp_dtm_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate dtm ta\n");
-			goto out;
+			return ret;
 		}
 		ret = psp_rap_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate rap ta\n");
-			goto out;
+			return ret;
 		}
 		ret = psp_securedisplay_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate securedisplay ta\n");
-			goto out;
+			return ret;
 		}
 	}
 
 	ret = psp_asd_terminate(psp);
 	if (ret) {
 		DRM_ERROR("Failed to terminate asd\n");
-		goto out;
+		return ret;
 	}
 
 	ret = psp_tmr_terminate(psp);
 	if (ret) {
 		DRM_ERROR("Failed to terminate tmr\n");
-		goto out;
+		return ret;
 	}
 
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
@@ -2700,9 +2697,6 @@ static int psp_suspend(void *handle)
 		DRM_ERROR("PSP ring stop failed\n");
 	}
 
-out:
-	psp_free_shared_bufs(psp);
-
 	return ret;
 }
 
-- 
2.34.1

