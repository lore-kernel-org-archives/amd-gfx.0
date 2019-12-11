Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35131C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 10:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE192073B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 10:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="OPECLPbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE192073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62B16EAF3;
	Wed, 11 Dec 2019 10:27:16 +0000 (UTC)
X-Greylist: delayed 366 seconds by postgrey-1.36 at gabe;
 Wed, 11 Dec 2019 10:27:15 UTC
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2656EAF3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 10:27:15 +0000 (UTC)
Date: Wed, 11 Dec 2019 10:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1576059665;
 bh=MB9qzFETuH+dvOBsYAODBg1oWyqswPFdtMae5ZQ7tf8=;
 h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
 b=OPECLPbkaZEPAOGwedIsXV9WuZ11XSPolsyDp1WHfT0F3rJ4Mn7JzM6mPX2vgQEhh
 vPszYJEMZ0CRqXL01ZnWhYQ91+JEknkbXkdoKXY9p7Nc0hYdOkcbeJWCp0qE/IW9FJ
 qYDZcd68MYcpIsuRnVf7oKkQA6aw8LTLFLNwD0QE=
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/amdgpu: log when amdgpu.dc=1 but ASIC is unsupported
Message-ID: <UPyARDn3GLmg4q9nl7gAuUjBHqg6GfvZOTyyRlyU1U-X-I1HD4Bo2AxZmmXWbRS3g35B_bD8Hm5WcJAqlwAsd-jcAz4Dij4AO0iA0Jpnjv8=@emersion.fr>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This makes it easier to figure out whether the kernel parameter has been
taken into account.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a6c837c0a85..10618353383f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2525,6 +2525,9 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 		return amdgpu_dc != 0;
 #endif
 	default:
+		if (amdgpu_dc > 0)
+			DRM_INFO("Display Core has been requested via kernel parameter "
+					 "but isn't supported by ASIC, ignoring\n");
 		return false;
 	}
 }
--
2.24.0


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
