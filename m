Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FE4C79FAD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6866D10E688;
	Mon,  7 Sep 2026 07:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYTnlyKb";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B12610E27C
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 13:34:24 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-836c4474028so21100667b3.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Sep 2026 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788615263; x=1789220063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9QXsz0fC9wZ+JNlekr0mg4nAz0vKv90Qs6khri27jlc=;
 b=AYTnlyKb2whZffi4izozoY7wGmRp70h2LOtgQMMCjguBMDF/n2fngrqhOq+353zvNO
 moPlGBNoQp1hvTSJ499MOklhnUEvn39zCzOVpjIaISC+4ew+qFL1MyI4IhcqjQd1sO9c
 hydJe3KEqhCbooVY3O4aRdx8zX6TY0cuC+wbITT1rzkeVZ/tvTzqQvNPQY5kytRs6oUm
 E4Ids6nZijB7tyEa0sl6J7BemLzJxrpM9MTng5XTd0Z1cTniD13oVJ3u6wWJ1/NJmzdY
 wh+n6IwFv/o5GbxQ297wXURxJD+jcOnUcm9gTEgfDIpGNEELM8ZCa5/1sDuaThniYgrO
 RHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788615263; x=1789220063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9QXsz0fC9wZ+JNlekr0mg4nAz0vKv90Qs6khri27jlc=;
 b=IPKSiOi6j5hpAESrwS7TegrddA9b1cILxHTC5VtmHya5X5uLdV00hcVHLU+QfNqFkl
 xEJbqm5gd6ayZm/8Y4gm8biLPRwpZSbupVhGMB/O4nz/uCQrknbsXER4PtHLJEI59zVL
 wodbsvp6NnrLL3atynOWSNr30+rr3olyI3wHTrpDR3qZr6jKEM2DhHYOGc4L3moG3Poe
 6KUAK3nMTyJUsowmkYPPx9W2LR3GcCssrKvdlnqqoLNPmEU7GSRP9LEU4vWguzHzOmnl
 6wq5s001yEGdNQQzHjzrHzS+DS87nt+YEV/TEqdBGi6a6VV3a95Tkeq//iIq5CXQivon
 hfzA==
X-Gm-Message-State: AFuF++lDOYmn+lqDzR181hYmwS/qkbzYH77qQ8jv3X+Sb7OpqAKQ27Zn
 5ETVK1AD1Z2vwD9eHaVdX4QlPDUpMi5Un6dCmnO2TUOpPqw/0tJ5FVcB
X-Gm-Gg: AYBFou1o3oaZzGeke93r//bO1xIFcHs6BWc/SeMibkfdt7QfBTjppiINBK8gG6tNC1d
 kgzGKS3zOFT1/LNf62MR/A98ZiLoo+XwDIu91M2gQpcOvF/YqY9qjYuhzqNpMZw0tMxjhvj9w5z
 WsthIdlhath+X1EjKm8egzLwaYUBjAymeDnHYqGNzWwWfrd54tTlTV2ep3FAdBAASr8Trctu/RE
 AfAAp36Krjwb8XjdU86ZR65JbxeOn8oex5w/+NQZBficOKe+zNBUFWKrsix2f4ybnil8fPGeHYV
 lg9PMX9JT2x1X71OqOxFXIQd9rmwaVf4PeEoLvm64E89HAQkvMpAYCgabu7ViEV1Bn8dMAF4wz9
 xgIjHlSAX527OEwmrFOOVvUllb/YvPRTYgJtb6vtQfpP8Q9s7OGVQTqV8LKomfH+mEu9NDXKQHH
 CmEHfoyYo3u/MJfloqtGemd9R+kKvXTRCwdoAtaZdLazo+sOyNiGKW3TG6uOe9Ev7lHcu2QFV16
 zeAlpfJ0YUMLxNVYKpXCWDME9TgKw==
X-Received: by 2002:a05:690c:c1a:b0:854:d9d0:467b with SMTP id
 00721157ae682-87126aa91b3mr51195547b3.22.1788615262799; 
 Sat, 05 Sep 2026 06:34:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:5698:103f:d00:26b6:2d03:3cc6:9121])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714b62bc77sm38919807b3.39.2026.09.05.06.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 06:34:22 -0700 (PDT)
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx8: fix register_list_format leak in
 gfx_v8_0_init_microcode
Date: Sat,  5 Sep 2026 10:34:05 -0300
Message-ID: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:01:06 +0000
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

gfx_v8_0_init_microcode() allocates rlc.register_list_format before
loading the MEC firmware.

If loading one of the subsequent firmware files fails, the function
returns through the error path without freeing register_list_format.

Use gfx_v8_0_free_microcode() in the error path so all previously
allocated firmware resources, including register_list_format, are
released.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7f91186ef1d1..b213870ecb96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1211,12 +1211,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		dev_err(adev->dev, "gfx8: Failed to load firmware %s gfx firmware\n", chip_name);
-		amdgpu_ucode_release(&adev->gfx.pfp_fw);
-		amdgpu_ucode_release(&adev->gfx.me_fw);
-		amdgpu_ucode_release(&adev->gfx.ce_fw);
-		amdgpu_ucode_release(&adev->gfx.rlc_fw);
-		amdgpu_ucode_release(&adev->gfx.mec_fw);
-		amdgpu_ucode_release(&adev->gfx.mec2_fw);
+		gfx_v8_0_free_microcode(adev);
 	}
 	return err;
 }
-- 
2.47.3

