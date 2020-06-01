Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF90AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EEC2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n125pLoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EEC2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799586E2F3;
	Mon,  1 Jun 2020 18:21:20 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250176E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:19 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id er17so477780qvb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W8fZRLNnAnkT+4ZOrI7VWm3M8Ce1IyX/TgbdxRXlnjE=;
 b=n125pLoB/+AswzdcHbJBrRgXLdV1I3IlVMrVk7pyjrKFYJDQJBGEX+a5MAgF0AvYRA
 jJqZ1xBsldkV46i52bLnsyLEH/zmtk8WRM82wWqU7VaioKfF2LAzrAtrPcebrd/HMGq9
 ATX5IhTOToNF7nsKoNFUR0MDvLYh0DfD2g3AUcQ13siu1zuhHyz+RKzT6VgYYJ0Duuqo
 nbyE9yWwsfwECPPwVvjPASoRss5Zvf53MC3yn5ZfQpmN1yAO1+co6pbBofQ3eTRICSQO
 /xmA4DFdn7HNtgJCNyhlYX/BvuKvIc0TKdVdO7MbsJKhuD15J498yaBn9wZoWLcg+3AV
 6yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W8fZRLNnAnkT+4ZOrI7VWm3M8Ce1IyX/TgbdxRXlnjE=;
 b=dr5nwohpw45m6cClI346PW3zXSnuOLfQkzg3pT4OSI6OpMAwQFI1Ud0ZftYTISaj3o
 NkQVDaKaXierzRXI5F8YZg7/8Cx32SNwOWtWGPRGkDDTl07ntMQJKwgOVdl71V2bL+Cp
 vRwZqUpWxzm5VaHUA+lDeE5AidBRNo8CNvd7HOVMP3we0xITHT5sPGmDug2wByoQWplW
 Lq6/f8k0vnMNBNY9YnTpAsf2e0DwUkKNe+aO4icQvh/H8ZG+Xio4nJ8oD6gshq0+wGK0
 pdpkgySI0OJkVAJAY5dznl/8mofKoj3rXd0q2f07OZZv2eO2/K727VGlmHNdTNG3rXCN
 f7pw==
X-Gm-Message-State: AOAM531nwxKAxhPOKcuJ8JDirbMRhCVg3BEZKTKaWb6z9ge7TeRwfZMk
 crO3FMRyeHf858djKwIpptA/GNT2
X-Google-Smtp-Source: ABdhPJyBJ5osYbntkuY9FNAUdrrObR20eh9etQwppdXrx6C2B0i2iWY08blqGZpPZZWGzgQ3ssxalw==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr5636323qvo.136.1591035678140; 
 Mon, 01 Jun 2020 11:21:18 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 100/207] drm/amdgpu: add atomfirmware helper funciton to query
 reserved fb size
Date: Mon,  1 Jun 2020 14:19:07 -0400
Message-Id: <20200601182054.1267858-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

fw_reserved_size_in_kb is introduced for driver to query
the TMR region reserved by PSP BL in Sienna_Cichlid and onwards

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 659d845dbebe..a9adccfda4c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -325,6 +325,9 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 
 union firmware_info {
 	struct atom_firmware_info_v3_1 v31;
+	struct atom_firmware_info_v3_2 v32;
+	struct atom_firmware_info_v3_3 v33;
+	struct atom_firmware_info_v3_4 v34;
 };
 
 /*
@@ -590,3 +593,38 @@ int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
 	adev->fw_vram_usage.mem_train_support = true;
 	return 0;
 }
+
+int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
+{
+	struct atom_context *ctx = adev->mode_info.atom_context;
+	union firmware_info *firmware_info;
+	int index;
+	u16 data_offset, size;
+	u8 frev, crev;
+	int fw_reserved_fb_size;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+			firmwareinfo);
+
+	if (!amdgpu_atom_parse_data_header(ctx, index, &size,
+				&frev, &crev, &data_offset))
+		/* fail to parse data_header */
+		return 0;
+
+	firmware_info = (union firmware_info *)(ctx->bios + data_offset);
+
+	if (frev !=3)
+		return -EINVAL;
+
+	switch (crev) {
+	case 4:
+		fw_reserved_fb_size =
+			(firmware_info->v34.fw_reserved_size_in_kb << 10);
+		break;
+	default:
+		fw_reserved_fb_size = 0;
+		break;
+	}
+
+	return fw_reserved_fb_size;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 434fe2fa0089..3a5ed339903e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -36,5 +36,6 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_sram_ecc_supported(struct amdgpu_device *adev);
+int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev);
 
 #endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
