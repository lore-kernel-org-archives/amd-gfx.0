Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2E7CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD57C10E4CB;
	Mon,  3 Nov 2025 22:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="komlqTx0";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B25410E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:21 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-640c48b3b90so2087640a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208660; x=1762813460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nwk4KPjUYp+CBSdPH6KAp3lpg809vuCnYnaJadT1aG8=;
 b=komlqTx0Eqidcv0mIkd92oyBbjEV1hnhnaXK4cQRePc8pC3UmAiVwiwsDqISgBux1k
 F36dJk3WScCiDzkoYSmTuemitdQVnI6N8iyoFt8b8krKLvJymh8PoJkE8ljacPDVIR/a
 VKYYt1+Ehr1YBitGe8HPTbVDvkmiFBUBZ1fOlkxZ9Y23OxBOK4hkTiS7U5rm01EHOjoT
 23fMt5XZRrJ7TdSeyzDdUmRUCpZqbRlcs0vA13m+DDYjKRfDlLk9sGWDnwRrt16dCWto
 FajzLH7HQoeL7DnUF2tk50bJYns/wHVoVOq7A1UrNYMfVKIEEL+kSggXLJwhT+YZrAyo
 ZCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208660; x=1762813460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwk4KPjUYp+CBSdPH6KAp3lpg809vuCnYnaJadT1aG8=;
 b=MyTWwCeDkPEAQHkuk1/9TyFty7TAfpRU0VSkpKJZdcwjBG4ysJVvrBuu0mVnOVmBho
 dAFfm+AdYFSNlZMLMYswYWg3CF7C7G/9xnm6MZIcMrcEMITQEozferZ1LOZ/LlnfPwi4
 3KVIQMnYukWqxWUXCbh3JKX5GRJfKSrYjGaPD5BS4T+98EOcYKyD4fdoqnFIYesrJ5gP
 JIy51lfgcF0S3FfNOw8g8HoUapbR6Usi5OlTWat+iaogBG7Ocoy/2Pgb5qTOAvSG+9ap
 +o5pdOfLHCT5MHVfIf/VafEWzG9raEzWtoPZQ3sUXH3HHbQe6cFTHBRNN6qRP6cv49Nc
 mP5Q==
X-Gm-Message-State: AOJu0YyTyF25U0dRPh0JBnyxy/xRBHwf67QVtE40YXrgxVLW/uFT9wDK
 +mxTtUUl9X3KzX8rJKDMAG+TbUOH66JeKFbwoRpzl9Igi+0dUTbrPbER5dwgxFe3
X-Gm-Gg: ASbGncsXI7SLuLGqO+jzY10PtL2HMqSItWgUcWamzVpUK097ktsV6tJIiyik3F5S9ms
 oft5S1Ka8NqX/oqNmgLqmx2Tvxne+849QXfLLkYc8nTwsigve+QgmRjOHcQlvyaJmK/2t4BLU9/
 WW/grHe4+FjQhPgseTPkafTqQsPNbSeukiOAVxZQ/2NaQ8EBOdWF4SXXuWe1P3XL2LjbbQDO9lt
 xGiLdKRn+8N9Xv/GnHX3TVK3yyfTF8yus6p0X4Qdc+3JmtR0xnWWbszlHdUb0UmzBDYLlYSAP1h
 rtIHnPwJ0aBmGXh9OKo/1+/76FwDRmv3DiZOfr5ax4Nugt76Ad8TvVnUtHkV8iU6HFm4yKAmQAZ
 NTiGqh/2nOR8Q+j7hgJHakvdfqYu7jPyYgp4X6+STGns5OkWRmY3qSaycHy8pYs85kdaUesd0+t
 sf9nIbssycToy/I4pVhyc=
X-Google-Smtp-Source: AGHT+IGEJWm2EdoS2Yqgb2ovHM8IEoHPA8rkYPcQsNM4V6gWADbMUXKv8knyHkDBijIKKgaYkIJI5w==
X-Received: by 2002:a05:6402:51c8:b0:640:931a:7c2f with SMTP id
 4fb4d7f45d1cf-640931a7eabmr9147839a12.7.1762208659844; 
 Mon, 03 Nov 2025 14:24:19 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:19 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 15/16] drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn,
 Cape Verde GPUs
Date: Mon,  3 Nov 2025 23:23:32 +0100
Message-ID: <20251103222333.37817-16-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

Add the VCE1 IP block to the SI GPUs that have it.
Advertise the encoder capabilities corresponding to VCE1,
so the userspace applications can detect and use it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 9468c03bdb1b..f7b35b860ba3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -45,6 +45,7 @@
 #include "dce_v6_0.h"
 #include "si.h"
 #include "uvd_v3_1.h"
+#include "vce_v1_0.h"
 
 #include "uvd/uvd_4_0_d.h"
 
@@ -921,8 +922,6 @@ static const u32 hainan_mgcg_cgcg_init[] =
 	0x3630, 0xfffffff0, 0x00000100,
 };
 
-/* XXX: update when we support VCE */
-#if 0
 /* tahiti, pitcairn, verde */
 static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
 {
@@ -940,13 +939,7 @@ static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
 	.codec_count = ARRAY_SIZE(tahiti_video_codecs_encode_array),
 	.codec_array = tahiti_video_codecs_encode_array,
 };
-#else
-static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
-{
-	.codec_count = 0,
-	.codec_array = NULL,
-};
-#endif
+
 /* oland and hainan don't support encode */
 static const struct amdgpu_video_codecs hainan_video_codecs_encode =
 {
@@ -2723,7 +2716,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
-		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
+		amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block);
 		break;
 	case CHIP_OLAND:
 		amdgpu_device_ip_block_add(adev, &si_common_ip_block);
@@ -2741,7 +2734,6 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
-		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
 		break;
 	case CHIP_HAINAN:
 		amdgpu_device_ip_block_add(adev, &si_common_ip_block);
-- 
2.51.0

