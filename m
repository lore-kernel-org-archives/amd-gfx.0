Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C082C1B0D9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225F510EA41;
	Thu, 27 Feb 2025 05:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NAz4A4k/";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1C010EA32
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:23:02 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7c0ac2f439eso67536885a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740633781; x=1741238581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zxNZKH8rv33VuAVvOQfYuxXBYk/RW4e10OvSFHfmB08=;
 b=NAz4A4k/cpzDkFunJR26zcyUoqmMIat0ZRpuQezqEhfIWDGqkgZv3WgM3+d/sRSpJW
 Ao5Pno7WQz8JSGTtvm9ki9OmpInUvlf3EBQouZ0CD+LnPwa27yfz7yzsDJGwj8YI+Mzp
 MQog4Utl0aVNEGtmDgV0v4RhDW2p22JmO2OSMpXtoYgMuDbfZmpffav3tW180jJbG/1a
 x677YLkED2RFeA7JzPsuIZQmBr/TGhYhRGK4U78o1H8gNgnO2I585ZsTdjMjq6Z8bf46
 Rh2gMvUpaBPQvm6LJEzWQJYkyKZCH9N7zHyvkkob75i3B2rhWgCrg0ti1B5iCTLY52i1
 oBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740633781; x=1741238581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxNZKH8rv33VuAVvOQfYuxXBYk/RW4e10OvSFHfmB08=;
 b=wulV6SQHjd/IQ0+3B2W1yHA4I1dxhmOmWHoKkVRVeI3OvdTjOT01bL1T5n8sKwYJyq
 KVDaqU+iaq/rsISxc8SIv2f3/pWeYTSg9y/2EmCsc3jjne6pUEw4lxLExXxoay2jTrfb
 shWwS04nd2Zs/fua6BJy0fBwEblrrg8RvwzlM0qfkNl4Xoe5nW4a60HwnKsVbokMeoAc
 3YFY9J8wpJtPnhzzDLeiVWS2ynnkMMavToLt6gklXjT+WFMIFbz69MogdXQsWK0COfJg
 JVSqBUsE1+OXAP2j8MDJp7wjxizdAVan9tzhEXHKamYFIxcQD4bn4RK3t6gnp2eIKx3F
 RcZA==
X-Gm-Message-State: AOJu0Yy1btIUxOIO3Og1g8mKNlja1vrPQk1YubRSAHsPKhr4/iUn+S5i
 bf+JppLRZeBZ2y0mZrjxWWwnTQGLTeJnul2ira2JxKtxEv1hAaa6R1bkBw==
X-Gm-Gg: ASbGncttlh5v/dX5O8Che31KHM71VjsjZrdbBwUdGHOb4VoavvFEuDPJy8WP5nqrkbi
 xkMEWmSVHcb/BQyoADPQl+SqKQ3/bx9aWAt4GNaPCph7LpQSaSSZ7+sys72OY4a/DWVomcKV4WL
 dVGCeYetFUaWxE9VVTj+ZTPCX/7ktsR4Oc1+2T9EaEAXOAAdFcXLOp0VZR9aVPxQ7gdIWgCVUYw
 0LhK8Ng0WfB0avJ61TpkULC0srFmulBKo6ibLJSkBZk999t9xU1YZMMMza05LNbNLfuy3wOj3kD
 yv6v11/bPiFSgeAp7ZprSkisHgD1/dYijqIb3CwiJD/5pdPd
X-Google-Smtp-Source: AGHT+IHs0s3tjC+6J6L71D2NrsUbjzKB1Hhy8lwdXTFp4HAk1MPxjJ9YQgFzgHQyIug/YY41r1VZvw==
X-Received: by 2002:a05:620a:28ca:b0:7c0:ae2e:630c with SMTP id
 af79cd13be357-7c0ceef980cmr3618278385a.22.1740633781070; 
 Wed, 26 Feb 2025 21:23:01 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dab64asm65670085a.100.2025.02.26.21.23.00
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:23:00 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] dmr/amdgpu: fix style in DCE6
Date: Thu, 27 Feb 2025 00:22:40 -0500
Message-ID: <20250227052241.171102-6-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

A few returns not where they should be.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index fd2eb454a5d8..4c3539e4960a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -243,7 +243,8 @@ static bool dce_v6_0_hpd_sense(struct amdgpu_device *adev,
 	if (hpd >= adev->mode_info.num_hpd)
 		return connected;
 
-	if (RREG32(mmDC_HPD1_INT_STATUS + hpd_offsets[hpd]) & DC_HPD1_INT_STATUS__DC_HPD1_SENSE_MASK)
+	if (RREG32(mmDC_HPD1_INT_STATUS + hpd_offsets[hpd]) &
+	    DC_HPD1_INT_STATUS__DC_HPD1_SENSE_MASK)
 		connected = true;
 
 	return connected;
@@ -451,7 +452,6 @@ void dce_v6_0_disable_dce(struct amdgpu_device *adev)
 
 static void dce_v6_0_program_fmt(struct drm_encoder *encoder)
 {
-
 	struct drm_device *dev = encoder->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -927,8 +927,8 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 		wm_high.dram_channels = dram_channels;
 		wm_high.num_heads = num_heads;
 
-		if (adev->pm.dpm_enabled) {
 		/* watermark for low clocks */
+		if (adev->pm.dpm_enabled) {
 			wm_low.yclk =
 				amdgpu_dpm_get_mclk(adev, true) * 10;
 			wm_low.sclk =
@@ -3232,7 +3232,6 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device *adev,
 	}
 
 	return 0;
-
 }
 
 static int dce_v6_0_set_clockgating_state(void *handle,
@@ -3365,8 +3364,7 @@ static void dce_v6_0_ext_commit(struct drm_encoder *encoder)
 
 }
 
-static void
-dce_v6_0_ext_mode_set(struct drm_encoder *encoder,
+static void dce_v6_0_ext_mode_set(struct drm_encoder *encoder,
 		      struct drm_display_mode *mode,
 		      struct drm_display_mode *adjusted_mode)
 {
@@ -3378,8 +3376,7 @@ static void dce_v6_0_ext_disable(struct drm_encoder *encoder)
 
 }
 
-static void
-dce_v6_0_ext_dpms(struct drm_encoder *encoder, int mode)
+static void dce_v6_0_ext_dpms(struct drm_encoder *encoder, int mode)
 {
 
 }
@@ -3450,7 +3447,6 @@ static void dce_v6_0_encoder_add(struct amdgpu_device *adev,
 			amdgpu_encoder->devices |= supported_device;
 			return;
 		}
-
 	}
 
 	/* add a new one */
-- 
2.48.1

