Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC4C4727D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9633020708
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhmQdqRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9633020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AD46E9B6;
	Fri,  2 Oct 2020 15:10:04 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B703D6E9B6
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 15:10:03 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id w12so1652454qki.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qCdTKGVr26VDKXPmoXRqI8QGQrHFzqqtiUbqDrNpB+Y=;
 b=YhmQdqRDwB+4jZmyiBuTlS/fs5XHdX8O1zatkkuRkI/my19GAb3lNTRvMafokIECYq
 UFFL+NXQQibD/txTnGMJF3ayOZ5dchNa/HaFIWZ7KVSEi5Aj+O4pAYqsZq6g6zpNpXr+
 uRk6Neh2wPEi/zgEAVAJojFZYDqlx9kgkZEf9y+7klTCGmHIecvjHhtPVP7Q31jcCsZy
 p8XMu05mQpD1uTh3GhDQPJUCo78FAjjMLNazzdGkFwre3n3thPBagkSxnQWpH9JpWtYc
 zBeeP8hyev6rj0V4S+q43VTMHayPvLOUIhVNpQ3yac91ImSHZgxb55HtdlYxweG9HPkz
 PaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qCdTKGVr26VDKXPmoXRqI8QGQrHFzqqtiUbqDrNpB+Y=;
 b=k795h6dzgrrtjevvCuZdKSloDzAOHgVoSiafUFD5XlNd/4TeiqM+Vc/oVRcD6IECA/
 VVFQ1MPz+P4GG1FVqoMn9osLNnRqvlXMh/BUSFV+UC6Hyt6AIBYY9a6SO0Zb/+VjHmTg
 g883DfkfVUXrZ6DaIbKjf8bmUDhn1temVnp/AIWDBcUkKAaRqoLPIU31PRYw+QE6pcuV
 D9N/UZHGvhZ32tHFukKoyUQA8gWdf3WiTIVYHiiHIdudckUyuTw4q+bV3YF0toCMdQXo
 z/CuwWRT7dy0lujjPT/gccXGZ40JxKURv4CKlncLNPc+21E6Yts8l8UIvzT8I2al35b/
 /E6g==
X-Gm-Message-State: AOAM5330MGEsGhHIatH6RGN/TFl3P+THbY7MhoUKtIQzze59uKyi7AC6
 DI9BkB76pypfVAnNv+ZGeOArH/3Yyz8=
X-Google-Smtp-Source: ABdhPJyLABS53D/kmc6bJbqNzkGmbqciBalCAkiAAdcVxux9cBBXWYtQkKtBSOyk2HUzAc/Qmh48JQ==
X-Received: by 2002:a37:38c:: with SMTP id 134mr2410901qkd.193.1601651402543; 
 Fri, 02 Oct 2020 08:10:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm1248435qkf.98.2020.10.02.08.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 08:10:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu: enable vcn support for green_sardine (v2)
Date: Fri,  2 Oct 2020 11:09:40 -0400
Message-Id: <20201002150940.1103949-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201002150940.1103949-1-alexander.deucher@amd.com>
References: <20201002150940.1103949-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Thong Thai <thong.thai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Thong Thai <thong.thai@amd.com>

Enable Green_Sardine VCN support and VCN firmware loading

v2: use apu flags

Signed-off-by: Thong Thai <thong.thai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 81102598cde7..075dd43ca8f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -39,6 +39,7 @@
 #define FIRMWARE_RAVEN2		"amdgpu/raven2_vcn.bin"
 #define FIRMWARE_ARCTURUS 	"amdgpu/arcturus_vcn.bin"
 #define FIRMWARE_RENOIR 	"amdgpu/renoir_vcn.bin"
+#define FIRMWARE_GREEN_SARDINE 	"amdgpu/green_sardine_vcn.bin"
 #define FIRMWARE_NAVI10 	"amdgpu/navi10_vcn.bin"
 #define FIRMWARE_NAVI14 	"amdgpu/navi14_vcn.bin"
 #define FIRMWARE_NAVI12 	"amdgpu/navi12_vcn.bin"
@@ -51,6 +52,7 @@ MODULE_FIRMWARE(FIRMWARE_PICASSO);
 MODULE_FIRMWARE(FIRMWARE_RAVEN2);
 MODULE_FIRMWARE(FIRMWARE_ARCTURUS);
 MODULE_FIRMWARE(FIRMWARE_RENOIR);
+MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE);
 MODULE_FIRMWARE(FIRMWARE_NAVI10);
 MODULE_FIRMWARE(FIRMWARE_NAVI14);
 MODULE_FIRMWARE(FIRMWARE_NAVI12);
@@ -90,7 +92,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			adev->vcn.indirect_sram = true;
 		break;
 	case CHIP_RENOIR:
-		fw_name = FIRMWARE_RENOIR;
+		if (adev->apu_flags & AMD_APU_IS_RENOIR)
+			fw_name = FIRMWARE_RENOIR;
+		else
+			fw_name = FIRMWARE_GREEN_SARDINE;
+
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
