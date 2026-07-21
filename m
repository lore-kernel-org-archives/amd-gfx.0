Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C05C44529
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0146A10E968;
	Tue, 21 Jul 2026 11:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ipsq+fEk";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AA010E97C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:39 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-69eae037da1so4433360a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634218; x=1785239018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B07sKwvX/hjwiUDOOjpR8gixvw+OrdA4sLxGt5eGMSA=;
 b=Ipsq+fEkeqrLTZfM0wcgsOcCz2oevT2v+VP2UgHMS4bu/PTOLzUgWLvQgu70+noIcd
 wkJv2Qci6ZBG3m+hxM11hQ+ZHTn1ifkDhDznYxZHVfOCjw5o76QEun8pw17Eo8i8gr3d
 F6rwaNwdOyire82ZFH25EojLjDGsBXl3V8zBNYBczg8oGJjyqAv9WmsHz6MkkUGq3sJB
 4WKfpJHsZlWba8uAo0JHGDO2ontrhG8moqk7fg6fVhv502tUp9iURF+QMyKd4eocUaUd
 Iu3wHI9DJB1Z5CSkkyw6aEnhjPj0QAafCNVqcOS9C+9zUZt44Z2hsBb2CRBHXVj14M1p
 XQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634218; x=1785239018;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B07sKwvX/hjwiUDOOjpR8gixvw+OrdA4sLxGt5eGMSA=;
 b=p2wV7xcCNt7DsAXEwGc8k3WhdJv5zcFc81bGzl4O3K8Mfp0jdqd5FUqhHG3CKc5tR5
 Xya+wjRcm8KUrNCMuggzzSmb3rKkBKGB+6y/2qh1II4Qk1gZuWPBMoOwfvP8xQOymqJg
 yTXY2iE3+eIDR6fBWx8j5/7j08W7J+vKITQYSTyWhLOW5r4HqxvB+06VcaoczP/+Gxhz
 GfMQ+TODcYufNv17aVonylEEvQ9CCo/hE79fIy4uAWn4DTtoNndO1fwLUDbt6G0YAZSh
 muKIX6m9M3fF/46WJ153dkCfd45wMF17J+U8al6VKF6tbgb/X2kqomSiLrngZSqgydb8
 YEDw==
X-Gm-Message-State: AOJu0YwJY4ptMJGo581Nauu59huSCVyVs4mChNF9ACb0QvE0iFj4TPbD
 u7FZnBxEke1lKPLuEpyigf2RUrf3O8Ns+4jwKLgnLL8HNFGcQVHBvjucXNQ2fFum
X-Gm-Gg: AR+sD11LHZ0/FJI4mx3vLWxr7X7h7EKG9UqhI3ViHfiLunKP4rZOVqsnUrRX0WQE+qW
 91pYGIgnmFPMioh7hG2Dg7ZaEzrTwn1qC3Wmk1sDucUmsKlM7XMUlM3g0GLf3+q1auEiJrvurb6
 c7ddRVHbkxxkyna8i99LLuAm0UPpwo03GGhtEsOtdK8s2eKfW8oLIjV0J1Kmp2iOA2YJdND6/JD
 /sLFmNmqpByOKDN5decIVNT9cSaeeDipIS4hRtLlY3PngYQLhQdSqJ5U80pMmArlTqQBiK/Obdv
 5B2m58f1Fh1I68YFvz+biHyvUH0F8iPF/4oqQYXhADSUMxj6pkG2kHNgB8NXo51qZ31oqgmhhDr
 Q4+OavS+/OEMHLEpxdExYTrx9zrrP/8boo8kOt+jvR/RPoVOFy88pj2HiMB5JNcXImu0oTofLbP
 1YxdMcqi7+v7c5u5u+Ad+M3wOrTfhksxfW+tlbF/9nI2k=
X-Received: by 2002:a17:907:940a:b0:c10:256:3d6a with SMTP id
 a640c23a62f3a-c16b47368damr689559266b.31.1784634217655; 
 Tue, 21 Jul 2026 04:43:37 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 9/9] drm/amdgpu/gfx7: Enable IP block soft reset as a GPU
 recovery method
Date: Tue, 21 Jul 2026 13:43:22 +0200
Message-ID: <20260721114322.17535-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
References: <20260721114322.17535-1-timur.kristof@gmail.com>
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

Enable IP block soft reset as a GPU recovery method for GFX7
graphics and compute rings.

This improves current user experience on all GFX7 chips:

* On Kaveri and Kabini there is currently no working
  GPU recovery method so those chips currently require
  the user to manually reset the computer when there
  was a hang.

* On Hawaii and Bonaire, the current GPU recovery method
  always clears the contents of VRAM, which means that
  a buggy (hanging) app can crash the whole graphical
  session, which is less than ideal.

Using GFX IP block soft reset means that we can now
have a working recovery on GFX7 APUs and we can also
move on from GFX hangs on dGPUs without crashing the
whole system.

Tested with the "hard_reset_cp_wait" test case from the
Hang Test Suite created by Natalie Vock and Konstantin Seurer.
This Vulkan testcase waits for an event that never occurs,
effectively a WAIT_REG_MEM packet that intentionally hangs.
IP block soft reset can resolve that hang and allow
the rest of the system to move on and keep functioning
without needing a full ASIC reset.

Tested on the following chips:

Bonaire (Radeon HD 7790)
Hawaii (Radeon R9 390X)
Kaveri (A10-7850K)

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index e31a2101f308..bf5595db6d74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4432,6 +4432,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
 
+	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_ip_block_soft_reset) {
+		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+	}
+
 	return r;
 }
 
-- 
2.55.0

