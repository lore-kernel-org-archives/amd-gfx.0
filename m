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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E6C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1FA206BE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRlVAc02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1FA206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C9C6E947;
	Wed,  7 Oct 2020 16:31:52 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBE56E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:31:51 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id o21so2417187qtp.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z7zHTUXR2G5NT4SJTWlmMGba2kLacD1xDCShLGBAhJg=;
 b=JRlVAc02M3WMeOFf4uQZHE/NA0c/jRIxXkulwMZCWHKQckUk+QDRJAm7LmDNayLfEf
 yMBkd1sFzO/57ndNFe9tzCt9IAHdl5PKIh3XqAkaade4CsdLPlPN0QNr6DqUOBU+uTP0
 B7ieCufiZvyo1WQIOAZbElry3Jvlsw3703VeUtpTe0e+xOmUiRIagnRm6uWYLxYYCltT
 iSMEn2w8A6TpSFWdLQg0wB2p5AA/IZtnfSZg+0hLyo8E8q4uRWbHDxMKXaYGnWlcydLc
 1cerkCGzYPqKeMabYBNBGbm9wOp1gb49Jy1SHIUXNCbXUaTvhua+jROnJS9POL3rortj
 /ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z7zHTUXR2G5NT4SJTWlmMGba2kLacD1xDCShLGBAhJg=;
 b=blxfcr1AH6Filzt5oYdMexDnzfOQqcpnqoqOrPJMbMskN5ql/B5WiZcuKO6DuPxf6x
 W2vL/mD2tpAXdHbFTarJLEWygyQr+FdXTXq/mbiyjG/gz9ReoWMAXPEhobPc+NyvMMGc
 UCR9Tkx9WzY498QUFwak5fuvHH8p3MsXseY2hYGkZxem9siPyrjBa/1Bp3LftDRjTvAr
 ufvROc/1kLhfjytBVivEqwoZAibOaoRDAbjjaawJBr2e+17hz2sULcH0xUHWY8gtEmT8
 F2xSfBtjExPZjjwGiD7pbr80isytEfswjpeJhwqEe03ond+RMSqZhn3RDbKQJqhgm4AW
 bMXw==
X-Gm-Message-State: AOAM530my8iYz+EcDIzISnkUwBPGu1O0w2zoiHPa+rcxYwEmOmMLm5mN
 8UzrIMo3eelaF2teZrszNL+da2yR4D8=
X-Google-Smtp-Source: ABdhPJw/eOPDQp+HADblYNzERxUUm9JRx6rzqr235Jq0QnL7iXtmj0sgmI37BwnQr1Pf4SbiifqaFQ==
X-Received: by 2002:ac8:c44:: with SMTP id l4mr4115192qti.2.1602088310805;
 Wed, 07 Oct 2020 09:31:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/50] drm/amdgpu: add support for dimgrey_cavefish firmware
Date: Wed,  7 Oct 2020 12:30:50 -0400
Message-Id: <20201007163135.1944186-6-alexander.deucher@amd.com>
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
 Jiansong Chen <Jiansong.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add support for dimgrey_cavefish cp/rlc firmware.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9a8d3f7b7b15..79c02e8281f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -176,6 +176,13 @@ MODULE_FIRMWARE("amdgpu/vangogh_mec.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_mec2.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_ce.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_pfp.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_me.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_mec.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_mec2.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_rlc.bin");
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -3715,6 +3722,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		chip_name = "vangogh";
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		chip_name = "dimgrey_cavefish";
+		break;
 	default:
 		BUG();
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
