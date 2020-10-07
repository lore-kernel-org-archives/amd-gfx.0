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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3AAC4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DEC2064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkChN3xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DEC2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3415E6E96B;
	Wed,  7 Oct 2020 16:32:27 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB726E95F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:26 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id b19so1478138qvm.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YrogeNJukCiR4ZDs88dbmbQphgwb7SDW5MRv3Oo/l58=;
 b=UkChN3xQalDA+8+RgxWVd8zMXjKl5vTcEt8k3pWJllm4K0kPMTjWYIkFlLEhUHx0m2
 F59ME1rgLDDCe2sE/sOLtqQ9sR3bphK24UyPLFreL9mcr7+cxyRFPtqtonPv+X3hpQkg
 y+BZXGvFaBl+oyYxkDVC5w2YFnS1aiXHAn0v0MmyXvPWJlydf/pgz+hJdVh0znWYNQIb
 TX8Ft4PwJcsGUASy13gn85BF8TcDHTef44nfV695ZPLbo35m7rDQsbKsrXYHPk6rfIWd
 1XhX+XE7vMH3e1kPBC5IOWEcKlqgyFWVV0n0YZ/bcqDn5nGPOHKt4wtG1wNFcvVTco58
 K3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YrogeNJukCiR4ZDs88dbmbQphgwb7SDW5MRv3Oo/l58=;
 b=lUj0gQPzfjUGH651nVnSMBNq3xFXziLsnX9DLQR5ShVya2UkT3+LmYIVGBD3UuJtTV
 T4WQqcHJer+dCdWziHC8tCRAS59zGdsujm/XS29M1OeiPEmjhSlxqmqyUKfkRRo8K5Je
 pqXf1F6XYElWWxFND1z59e4azCEa58CTpms52DyXqaCKV2JUJsRuqvl5Azoti49CUtjB
 m3CKIg9fMbztxqy/+m3VIk11z1zRX2os0ORsJYJCnZcbvzTwGpEN/wGgiFQcpQoIyuJB
 ftg4Hjsj3APO/muBM3i2GVryO4bZriL805yEOdeeRhBNywvsYH2OGp35Yya5p00aKlSl
 E8ow==
X-Gm-Message-State: AOAM5337qGUJFCYnXH+a1ZFIMnNiNUMJ4YdC3nZbZZo12XzrSSnNx0TC
 hbA0kIEpEBTi68HygQmMbbAEu6BgvgI=
X-Google-Smtp-Source: ABdhPJwUqgBV1plLW5T5uxspzjVsl7/iOqdaQZZY5fQ6e3irjBahqouhTdTqZF++cqx1DJZqsTy86g==
X-Received: by 2002:a05:6214:184c:: with SMTP id
 d12mr4168205qvy.11.1602088345055; 
 Wed, 07 Oct 2020 09:32:25 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:24 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/50] drm/amdgpu: add psp support for dimgrey_cavefish(v2)
Date: Wed,  7 Oct 2020 12:31:10 -0400
Message-Id: <20201007163135.1944186-26-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

General psp support for dimgrey_cavefish.

v2: remove the checks for asd load and reroute ih.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 13 +++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d91d951d018e..cad4767ca2bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -101,6 +101,7 @@ static int psp_early_init(void *handle)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		psp_v11_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
@@ -1968,8 +1969,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 			continue;
 
 		if (psp->autoload_supported &&
-		    (adev->asic_type == CHIP_SIENNA_CICHLID ||
-		     adev->asic_type == CHIP_NAVY_FLOUNDER) &&
+		    (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+		     adev->asic_type <= CHIP_DIMGREY_CAVEFISH) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1d417367ffac..1a69c212ce68 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -61,6 +61,8 @@ MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_asd.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_toc.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sos.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_asd.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -110,6 +112,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	case CHIP_VANGOGH:
 		chip_name = "vangogh";
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		chip_name = "dimgrey_cavefish";
+		break;
 	default:
 		BUG();
 	}
@@ -194,6 +199,14 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		err = psp_init_sos_microcode(psp, chip_name);
+		if (err)
+			return err;
+		err = psp_init_asd_microcode(psp, chip_name);
+		if (err)
+			return err;
+		break;
 	case CHIP_VANGOGH:
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
