Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46F7CA0FFC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C3210EA15;
	Thu, 28 Aug 2025 15:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NlZ9Do/1";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B20310EA0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:17 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45b627ea685so8584735e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393876; x=1756998676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7AHenepZl2ULGYTeBjZC4LPeXPmJGAQRDJ5P02MzHM=;
 b=NlZ9Do/16kIqBKvRfw+RmPlC4VFbMgpxVoHaD6aqoDLsf0ufxOWcBWXPQTI+F9lePQ
 V1SoZfTtS3zGATompd7KUmb78iW9qmJs1YkU18OFLDXeQJ3ly//BovO0nxjtzlB/Il9N
 eX/Estu3uw7G13EUTw+8nW1agccMds8PgB6C/saSdwv7nT9ATXwEz6EWFBVcd15IVPoL
 oeZZXxZyPUUqLY8TZTU9TQbjm2KjQWksCQRzM2rUWA6gmgObZO9B/QDeAIBFH4njm0xV
 a5niYKJlp3M4qG10OPLFIAvWk7fUOpnbfQnQobqiFvxtTmAqpCmA0QtLoyzUD0RHf9CS
 b0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393876; x=1756998676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7AHenepZl2ULGYTeBjZC4LPeXPmJGAQRDJ5P02MzHM=;
 b=iVW+HvMHFSQebp+3kh37bWL5nsXdP2gMdWmNhSNq6g1oYLbxBy/p6GP+wJp16eYUjj
 B9ky2dXqncaOHKh3faTll4w2NRNA3vCU4I5ZDQNakoW2RV4Ll0PeYUDLCW/b9Xp0erKD
 1i+ETn8h33GWNScnBpWzzbVSypC+yaKRv60wl94DqGiipZAYsGLeWt65EBNJc2B0T9sM
 TCBXI/atNQ5aLH7jwoHuvZkeSXtutxmrypB3EkoEkWufUMo55S6WUTLk9fQmmBvt8wJV
 MhpW3TUDFgiOi6Ke8SHssFOEoG4t2+kaZ5TrP9pxyZ234WIewcicYnwNcUNhTIKe1Xd0
 AMhQ==
X-Gm-Message-State: AOJu0Yzehq9OJF/CfAOOLmgo3Hnz/QqcAii2ePJsaiulYZG8MGq7oJWp
 kFDActSJg8wGaR4xPsWArMewymjhuYUohOdEZCL2MWf13bK4b6qJpGpYPJHXuQ==
X-Gm-Gg: ASbGncu5IHEiSFQyZ+0hz/fEcRLDf7+wiCGkvg6tmy4wLNKhPhzklzzOETyu9s8GORS
 EAU6phZ59uC1NLL+MpkHmb+70MJQCP5Zsp+JQXSVai8gy+Uk5gHI37px8mfo6znFdb9TmqiOhsq
 Ivz6pBNTYzU+HceHru8UAcOTXC2Vf6b7F5ItfX3iJYQ63NoFRP+X4O5f91YzptKFlAsVpeJOWDR
 JXc9TTcgmu3r3dLB3/PJ17OiVRMZG3VXHvShrtCeNT8cRWad2wcdTK7AadrCoKRix5paR6tiiNx
 DEroejbVEyYTyVPDjZ8f5Lxeb1N+QFa/L95QgfTM6CY2glaJmT39K3gFy1E3Dl5LtC/e6oTxQXo
 3x/HV67L2KK/KDmvlrvcWWnjJo5kDOEM8BWbEFa7GAlNtpBrV6YcEP2FnoKCLgO4pkwjhcqPfSN
 PGt/xeAWg0FEc6VXexgtphR/qY3Q==
X-Google-Smtp-Source: AGHT+IGhjt+ese3JdgL5SlSb2EPZj9MV/KSPidxmdb8jCjYkJSP2gdHD60nsueJUegsSiZBYnGPLLg==
X-Received: by 2002:a5d:5d81:0:b0:3b7:735f:25c9 with SMTP id
 ffacd0b85a97d-3c5daa2bec1mr16526306f8f.21.1756393875734; 
 Thu, 28 Aug 2025 08:11:15 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:15 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/10] drm/amdgpu: Power up UVD 3 for FW validation (v2)
Date: Thu, 28 Aug 2025 17:11:03 +0200
Message-ID: <20250828151112.15965-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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

Unlike later versions, UVD 3 has firmware validation.
For this to work, the UVD should be powered up correctly.

When DPM is enabled and the display clock is off,
the SMU may choose a power state which doesn't power
the UVD, which can result in failure to initialize UVD.

v2:
Add code comments to explain about the UVD power state
and how UVD clock is turned on/off.

Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 29 +++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5dbaebb592b3..2e79a3afc774 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -623,7 +623,22 @@ static void uvd_v3_1_enable_mgcg(struct amdgpu_device *adev,
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * Initialize the hardware, boot up the VCPU and do some testing
+ * Initialize the hardware, boot up the VCPU and do some testing.
+ *
+ * On SI, the UVD is meant to be used in a specific power state,
+ * or alternatively the driver can manually enable its clock.
+ * In amdgpu we use the dedicated UVD power state when DPM is enabled.
+ * Calling amdgpu_dpm_enable_uvd makes DPM select the UVD power state
+ * for the SMU and afterwards enables the UVD clock.
+ * This is automatically done by amdgpu_uvd_ring_begin_use when work
+ * is submitted to the UVD ring. Here, we have to call it manually
+ * in order to power up UVD before firmware validation.
+ *
+ * Note that we must not disable the UVD clock here, as that would
+ * cause the ring test to fail. However, UVD is powered off
+ * automatically after the ring test: amdgpu_uvd_ring_end_use calls
+ * the UVD idle work handler which will disable the UVD clock when
+ * all fences are signalled.
  */
 static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
@@ -633,6 +648,15 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	uvd_v3_1_mc_resume(adev);
+	uvd_v3_1_enable_mgcg(adev, true);
+
+	/* Make sure UVD is powered during FW validation.
+	 * It's going to be automatically powered off after the ring test.
+	 */
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_uvd(adev, true);
+	else
+		amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
 
 	r = uvd_v3_1_fw_validate(adev);
 	if (r) {
@@ -640,9 +664,6 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	uvd_v3_1_enable_mgcg(adev, true);
-	amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
-
 	uvd_v3_1_start(adev);
 
 	r = amdgpu_ring_test_helper(ring);
-- 
2.51.0

