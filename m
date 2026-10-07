Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EF0CA6010
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9859410FCE8;
	Thu,  8 Oct 2026 07:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lla2iTPO";
	dkim-atps=neutral
Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB9C10F5C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:33:01 +0000 (UTC)
Received: by mail-lr2-f3.google.com with SMTP id
 38308e7fff4ca-3a77df9781eso23132491fa.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379979; x=1791984779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sXzba+xG1WBG1R2U3C2ihk+Wr/g1fNt8Yr32nUgb40w=;
 b=lla2iTPOI41HBQ5muN4w5MxFVDVuMqSEFMvTi/VQbPFNsbrJTTmsL2enbSz7Z6GpTS
 I2KxrFAkR0MQUHo/lWziylgB8JOHPnorqdky0MrYGZwovKxxYl6lz4fn9b9yuKeJoFsb
 U8i9ogM1safnja8VHyTVRHsRrJEXhTlIEdZfAlaFjf1YwyYWSkslrt+s3/N93iZo6jB9
 qIVPyx0mHEVVR6DKtWwtzMHlM37l+KvINZH1ZhSrIIC+48r0SnJG5uN7n2sR836+848w
 maxDcfpc186qrM+gvMpkB1mPW79F2OonwK5CQUqQ/Vd/mb9hvP+DyMmlvYwRsONhLK9O
 uzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379979; x=1791984779;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sXzba+xG1WBG1R2U3C2ihk+Wr/g1fNt8Yr32nUgb40w=;
 b=KZENM1nTvF0yO+w+FEcxA6G9SI7j6IlMsjgG33mO6P27AQpKdW4Hki1Kp6WPCH6W5R
 MF4gqbNGDZ6x/mb8gC7gkmf+VcBrvdTmBFS+5vOsnC2K8WnFKRFMxz0sKB5WjDtKP2d+
 C/9i/lLZrebF5gTE0+UhqcCPOBjdubjw+gCYKryb8cpBmKIwMs0/GSMhqByEQudmyUAc
 lBX4Lzq+T/mMZOv5QNXtAF/uCgppoLz7ViqJzbG4ahv3yGizu7DskxFsMF4KgITCXwGe
 JYioJ7lhhTK/6IH7O4Pz+3pVgVJWmPkYT5iM4vjuBNHOYodcWqvwiUFPSNgorOJyB5JA
 gxWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1vz+OuJHdXmoDQrteqwWBpnCRal+O0WN6OUPE5vPUiEJfzBcMcPLTCGoyL/uC2JnSnKXOmk7P@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2qPhWJm+93ZBtSG7mAUCwHIW3ZCpY5ZEbnBtCsrR4ww3aPE9S
 ST1sw6Vot1S8tv0Lth1lCWGtIXmLeM0skjQjUglZtIl0J2iBI2fF8+CA
X-Gm-Gg: AYBFou2cFLCB317ByKT9CxtVe+se7RiBVQktXxVS5StWQBPYs5xUtRk8r8voR33PjhF
 unAwZxeDDgcTSP/vCR/FLujh+Q0IgLw7LKAtD9MdncIui8l2XUZJ6N/DXAO7bmlK+mszSrlypRG
 Gh1qg99mfHYOBI6nvtG0B7oYBpiq/OmdoM0lycyE2M0idTBB6EH709nQcECTWrj+DNabd1McBG4
 XOVmMQHXID4OUoKxhH8DkcvlKji+tfHPzhYblRWrXuJeiLnJeLLGi3Ispz3TMq2zj0Ibgn1JhhW
 w4O2Yn4z6hOA4ngRyniH2wzEkGFxnN3Uwb9pxmoxlKHIMETAsxf/s7ciMIkM0Zjh4FjYsKRiphR
 xKYnEXSFd6K0xPB9EXpJkfVG/7/QG7AvKVtWSTT/SFRFrq0LD34pYPT8J+M0GGmWkUb6wz9VmCb
 CVHhpp+E0MWGceD9Ot7GKSmdCdYFRbKzOPK4fXIFT0Hiv898LGGiUunjtJcyMRCcFqjG09aB2lQ
 GU/QpeAuink61t/
X-Received: by 2002:a05:6512:68c:b0:5bb:7b2a:5b2d with SMTP id
 2adb3069b0e04-5bcd0708cd9mr821802e87.35.1791379979145; 
 Wed, 07 Oct 2026 06:32:59 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd30a474csm33636e87.80.2026.10.07.06.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:32:57 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Yinjie Yao <yinjie.yao@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10/5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG
 v3.0 ring
Date: Wed,  7 Oct 2026 16:32:43 +0300
Message-ID: <20261007133244.121787-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:43:00 +0000
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

From: Yinjie Yao <yinjie.yao@amd.com>

commit a2baf12eec41f246689e6a3f8619af1200031576 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: dfd57dbf44dd ("drm/amdgpu: add JPEG3.0 support for Sienna_Cichlid")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d7d774f100efb5089c86a1fb8c5bf47c63fc9ef)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63846

 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 323d68b2124f..f1957d4fa7a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -560,6 +560,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
-- 
2.53.0

