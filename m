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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C33C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA62206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXsGNGbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA62206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11DF6E2CD;
	Mon,  1 Jun 2020 18:04:34 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E786E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:33 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id f89so464760qva.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=woxvDGkTwqPtNfTOb8aMeyI+2CHw0ivA9xaKUu4T6JM=;
 b=jXsGNGbPS92W6Ig9roCoAosnS+s1oCPQCy1YDlSE1th/vDbB/LAhz9yZYgT38FJ/oG
 1jvxb24KcIJEIoUOzGcuOB55jMI3+PsRc5qt6ksZ2KAAnSZry5ir8HqqCmJMSQXPTEfO
 7FylpTrSQW/N37KwpQNLVOUr6xw+Xvd9/heT9CEXfqDwmZk2/NBPOIoOMdcKc0CEH+bc
 TaNcFP7QZpXJvc1GhL3czLrikDBDFJMcneacmDtTc+Ky7e5nhOpwbtfAsfzirb5seBci
 7XTjdrboOfQvN8JjS17d0O1gzN/ByhQnaecXKZvjcgHtpAfo+AfwxE1WzhqHoKAkC9OL
 tgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=woxvDGkTwqPtNfTOb8aMeyI+2CHw0ivA9xaKUu4T6JM=;
 b=KPCf8yia4Ey4A7sW74b+L1FEavDqrJWnxx3UgmjT+9ss0INbpqQaq97+FxSFbsSHxS
 bAAzTYkNzFpTZRtmnatKH4NnGs9q0KcRYdp715zGSno16bhLuv3c33RSBBU//5Vhgf4W
 nbwtGDQVcxeO41vbcWITM3pJYYnPdCC9EpNmlmC+UcHX80EMcmQ9d7fHblGmR7zisQUR
 6aPCNHEaN2Edcf3dxtmfcrbkqIdEyC1plf/CxwTa4p2Jn7YnrZTnhLmG7GasnfHLXT/6
 o55x4Aid/n4DCox73gxkh50UawtpdD3wS1osM8HykM7I74qyWdFTyzKEP684N9ESseP8
 InIA==
X-Gm-Message-State: AOAM532ASa66+2HcC5zirFhnMiDFksQSyFJAIw74SOp1Egoo3HT8SO0J
 WqgwUrVebtZF1E8bmSKVxUiotoME
X-Google-Smtp-Source: ABdhPJwy1PetMcg96hoRx5V0XwlnE2MKssdLv+OtiiP2NlZGVquKB/LPMUfv+kwN0+Fcp+ezEOXmHA==
X-Received: by 2002:a0c:aa4b:: with SMTP id e11mr21623924qvb.14.1591034672597; 
 Mon, 01 Jun 2020 11:04:32 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 074/207] drm/amdgpu/mes10.1: copy mes fw info into global fw
 array
Date: Mon,  1 Jun 2020 14:00:26 -0400
Message-Id: <20200601180239.1267430-71-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Copy mes firmware info into into global fw array, preparing
for fw front door loading.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index a6a96cf96b22..a0fd3c3c7397 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -271,6 +271,7 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev)
 	char fw_name[30];
 	int err;
 	const struct mes_firmware_header_v1_0 *mes_hdr;
+	struct amdgpu_firmware_info *info;
 
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
@@ -306,6 +307,22 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev)
 		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
 
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MES];
+		info->ucode_id = AMDGPU_UCODE_ID_CP_MES;
+		info->fw = adev->mes.fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
+			      PAGE_SIZE);
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MES_DATA];
+		info->ucode_id = AMDGPU_UCODE_ID_CP_MES_DATA;
+		info->fw = adev->mes.fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
+			      PAGE_SIZE);
+	}
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
