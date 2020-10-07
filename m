Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC81C4727E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591152064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tecp9o9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591152064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49C36E97D;
	Wed,  7 Oct 2020 16:32:58 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817B66E97D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:58 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id y198so3512629qka.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EgLGx1WUpecRPvgGvIx0AImlDj2PYr/ScDUXwcRpSSo=;
 b=tecp9o9yifycOYEM/oimVgOm5IpbwPfGcfqFRaQ1Ig/Pg8B9/4JGudj5y7wl1V7VtQ
 oynvJKUpw/wQtNgGDS1+vo8f/FBTx/W6C2Ww1oZUoa81TJKUBQgW4+fHC7SiMvVjyul+
 ftMwpQu899zDI6IkdmFCnDUXjQd6Vi+hUKbej6HcYkdpDCGbiA9cUrYICat/8Njnhb7B
 Hjadkuzzlp+xR88a56R9pDPKTgtfY4zqWZj3QqgyN5tJAvYHwBnabrDUXAqGlfqg+HWL
 H5JcJ7KhAt6BDHNM1ewS/f8KTqrx+Dip6QQUA3HzIMS84YvwNiuqU4eMNgFGKYTLHP5J
 gIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EgLGx1WUpecRPvgGvIx0AImlDj2PYr/ScDUXwcRpSSo=;
 b=OdfRWwdE9gI9QujaF+dApg+p4nQ00bZQWyCxj34CLqKI7ua9N6zyFODLmYUs5t0TL9
 vIf3LfvoEW6ZxaiTG6RLFrSjHSi3yn5Ko3abhAoSekAnsibvjuBYNIvWYGfEh7bG/Odv
 arWbLbXip4sUoxO1KXjdS93MMg+tr5xITqBgMNzNSHxkhkEEgzzK3RNMbLwWm+C8mhHu
 dbRsoo1xhAipUlodyT9ve0hlDg6lYpl3iof0zNE623I/nKHZ3dfYJly5CrByXP1o6T82
 aKDJoEp4wYC8YU1S2EJiaE3DwW6s7BNDAAfJm0mzjoWjGhcKuQ9lIlPpkuDB1/IOMkxL
 LTKg==
X-Gm-Message-State: AOAM53391Gbo5XB+DvSCwzcxBgW5oLEr4te7e5Dzct6iKcj9usgnxdat
 MDgpPhGMch0kLpIXU8FRiDJXxreH06E=
X-Google-Smtp-Source: ABdhPJyGu6AjzxBUdXSaCqz19hKF7CaPoqBKnCDX5adCoScxRGoX0rnyaeCldFCzKY5G30UVUz0Ksg==
X-Received: by 2002:a37:54a:: with SMTP id 71mr3412944qkf.407.1602088377441;
 Wed, 07 Oct 2020 09:32:57 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 50/50] drm/amd/display: Add DCN302 support in amdgpu_dm (v2)
Date: Wed,  7 Oct 2020 12:31:35 -0400
Message-Id: <20201007163135.1944186-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Handle CAVE_DIMGREY_CAVEFISH in amdgpu_dm

v2: fix rebase typo (Alex)

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3cf4e08931bb..f45f9baec156 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -104,6 +104,10 @@ MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
 #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
+#define FIRMWARE_DIMGREY_CAVEFISH_DMUB "amdgpu/dimgrey_cavefish_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
+#endif
 
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
@@ -1140,6 +1144,9 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
+	case CHIP_DIMGREY_CAVEFISH:
+#endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
 	case CHIP_VANGOGH:
 #endif
@@ -1255,6 +1262,12 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		fw_name_dmub = FIRMWARE_VANGOGH_DMUB;
 		break;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
+	case CHIP_DIMGREY_CAVEFISH:
+		dmub_asic = DMUB_ASIC_DCN302;
+		fw_name_dmub = FIRMWARE_DIMGREY_CAVEFISH_DMUB;
+		break;
+#endif
 
 	default:
 		/* ASIC doesn't support DMUB. */
@@ -3376,6 +3389,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
+	case CHIP_DIMGREY_CAVEFISH:
+#endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
 	case CHIP_VANGOGH:
 #endif
@@ -3633,6 +3649,9 @@ static int dm_early_init(void *handle)
 		break;
 #endif
 	case CHIP_NAVI14:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
+	case CHIP_DIMGREY_CAVEFISH:
+#endif
 		adev->mode_info.num_crtc = 5;
 		adev->mode_info.num_hpd = 5;
 		adev->mode_info.num_dig = 5;
@@ -3952,6 +3971,9 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 		adev->asic_type == CHIP_SIENNA_CICHLID ||
 		adev->asic_type == CHIP_NAVY_FLOUNDER ||
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
+		adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
+#endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
 		adev->asic_type == CHIP_VANGOGH ||
 #endif
@@ -3976,7 +3998,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
 		if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-		    adev->asic_type == CHIP_NAVY_FLOUNDER)
+		    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+		    adev->asic_type == CHIP_DIMGREY_CAVEFISH)
 			tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 #endif
 		ret = fill_plane_dcc_attributes(adev, afb, format, rotation,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
