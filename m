Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB47C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013DA207EA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwC2DPM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013DA207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FAE6E4EC;
	Wed,  2 Sep 2020 18:16:53 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7606E489
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:16:50 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id b14so608271qkn.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oXDkbDb7/MrZZZPm2nGJ/eHwUuQBS/Iev3kWaBcqR4M=;
 b=rwC2DPM2mPEn5clDsCNvc9qn1xlci1iqxdjH7Gy6vDaMEYAH3XazrwHiECFK3r5EnP
 QpJJXcmOs0OOqtE+XTDVT0ws+COnA3qJ5x17Soe/TOJufi5V/nlDul6h8F3fuJCz+kK/
 Qah5qF6ox6vtKFuwDNBie8tB/j/GikSuxhgDfbk3FhBfH/Yfnhj0MEe2z+/V87J7YqnO
 Ozt+cLigGJd/2aqPHq4BGEIW+Q/oFVDRZce5xRCjpNaIyzLtRjMptG2i83QZCd9+yUs3
 HBHWDDfYK7QHI7FcVla5ou+KbY6q4S90kMGgl785NjkO7l7CoyP3HabfIqMbHCuVrWc8
 YlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oXDkbDb7/MrZZZPm2nGJ/eHwUuQBS/Iev3kWaBcqR4M=;
 b=jwCXe/jZ1+QSSdOovxpUxEaBqKY8MgIqb9VaLTfJbMWUwJhv5MeuW537csgmWYJKcD
 fzCveGVjbxKoFzdS5YotRgdaIIQFvgCyACG8qizN0Y/18y7P5dtAyAHFRTwvnT6SenIK
 tUZPlmfhMeegxJngAcuKk7E9LJ5HZFy0dPBmC3vI+fFJtbAZZSoQyCNux6tU9epI1NOu
 Pkglvh4/xwAxq7VKex9QzUg3cMp8fuASwq9+sMjNf4mgi6AuZ7hy8aKphXst0WwXiSQg
 tquZqRZ2CZgoK4liwWi/MFotjSoqEDOm3bn7rc63XmSc6PGbSt5ewHlFP4vZKl65yYmw
 9Prg==
X-Gm-Message-State: AOAM530faTVJ8vdwDJpq482FtXThRjLytn/DV3XGifDgsY5tNAuVUIun
 tI4POIMpig2cm/UfFfofBbi9VG1oPSA=
X-Google-Smtp-Source: ABdhPJwsfkJBAkqxQmRpEInC9uR/a81ahcq+bKUVHU7/nX6QExWABTSKrnzgH5v89J0u3u0yTA4heQ==
X-Received: by 2002:a37:c4b:: with SMTP id 72mr8029322qkm.176.1599070609211;
 Wed, 02 Sep 2020 11:16:49 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id l19sm160569qtu.16.2020.09.02.11.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 11:16:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gmc9: print client id string for mmhub
Date: Wed,  2 Sep 2020 14:16:39 -0400
Message-Id: <20200902181640.1559269-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the name of the client rather than the number.  This
makes it easier to debug what block is causing the fault.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 239 +++++++++++++++++++++++++-
 1 file changed, 230 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7e86aee60c64..f9e810126124 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -87,6 +87,203 @@ static const char *gfxhub_client_ids[] = {
 	"PA",
 };
 
+static const char *mmhub_client_ids_raven[][2] = {
+	[0][0] = "MP1",
+	[1][0] = "MP0",
+	[2][0] = "VCN",
+	[3][0] = "VCNU",
+	[4][0] = "HDP",
+	[5][0] = "DCE",
+	[13][0] = "UTCL2",
+	[19][0] = "TLS",
+	[26][0] = "OSS",
+	[27][0] = "SDMA0",
+	[0][1] = "MP1",
+	[1][1] = "MP0",
+	[2][1] = "VCN",
+	[3][1] = "VCNU",
+	[4][1] = "HDP",
+	[5][1] = "XDP",
+	[6][1] = "DBGU0",
+	[7][1] = "DCE",
+	[8][1] = "DCEDWB0",
+	[9][1] = "DCEDWB1",
+	[26][1] = "OSS",
+	[27][1] = "SDMA0",
+};
+
+static const char *mmhub_client_ids_renoir[][2] = {
+	[0][0] = "MP1",
+	[1][0] = "MP0",
+	[2][0] = "HDP",
+	[4][0] = "DCEDMC",
+	[5][0] = "DCEVGA",
+	[13][0] = "UTCL2",
+	[19][0] = "TLS",
+	[26][0] = "OSS",
+	[27][0] = "SDMA0",
+	[28][0] = "VCN",
+	[29][0] = "VCNU",
+	[30][0] = "JPEG",
+	[0][1] = "MP1",
+	[1][1] = "MP0",
+	[2][1] = "HDP",
+	[3][1] = "XDP",
+	[6][1] = "DBGU0",
+	[7][1] = "DCEDMC",
+	[8][1] = "DCEVGA",
+	[9][1] = "DCEDWB",
+	[26][1] = "OSS",
+	[27][1] = "SDMA0",
+	[28][1] = "VCN",
+	[29][1] = "VCNU",
+	[30][1] = "JPEG",
+};
+
+static const char *mmhub_client_ids_vega10[][2] = {
+	[0][0] = "MP0",
+	[1][0] = "UVD",
+	[2][0] = "UVDU",
+	[3][0] = "HDP",
+	[13][0] = "UTCL2",
+	[14][0] = "OSS",
+	[15][0] = "SDMA1",
+	[32+0][0] = "VCE0",
+	[32+1][0] = "VCE0U",
+	[32+2][0] = "XDMA",
+	[32+3][0] = "DCE",
+	[32+4][0] = "MP1",
+	[32+14][0] = "SDMA0",
+	[0][1] = "MP0",
+	[1][1] = "UVD",
+	[2][1] = "UVDU",
+	[3][1] = "DBGU0",
+	[4][1] = "HDP",
+	[5][1] = "XDP",
+	[14][1] = "OSS",
+	[15][1] = "SDMA0",
+	[32+0][1] = "VCE0",
+	[32+1][1] = "VCE0U",
+	[32+2][1] = "XDMA",
+	[32+3][1] = "DCE",
+	[32+4][1] = "DCEDWB",
+	[32+5][1] = "MP1",
+	[32+6][1] = "DBGU1",
+	[32+14][1] = "SDMA1",
+};
+
+static const char *mmhub_client_ids_vega12[][2] = {
+	[0][0] = "MP0",
+	[1][0] = "VCE0",
+	[2][0] = "VCE0U",
+	[3][0] = "HDP",
+	[13][0] = "UTCL2",
+	[14][0] = "OSS",
+	[15][0] = "SDMA1",
+	[32+0][0] = "DCE",
+	[32+1][0] = "XDMA",
+	[32+2][0] = "UVD",
+	[32+3][0] = "UVDU",
+	[32+4][0] = "MP1",
+	[32+15][0] = "SDMA0",
+	[0][1] = "MP0",
+	[1][1] = "VCE0",
+	[2][1] = "VCE0U",
+	[3][1] = "DBGU0",
+	[4][1] = "HDP",
+	[5][1] = "XDP",
+	[14][1] = "OSS",
+	[15][1] = "SDMA0",
+	[32+0][1] = "DCE",
+	[32+1][1] = "DCEDWB",
+	[32+2][1] = "XDMA",
+	[32+3][1] = "UVD",
+	[32+4][1] = "UVDU",
+	[32+5][1] = "MP1",
+	[32+6][1] = "DBGU1",
+	[32+15][1] = "SDMA1",
+};
+
+static const char *mmhub_client_ids_vega20[][2] = {
+	[0][0] = "XDMA",
+	[1][0] = "DCE",
+	[2][0] = "VCE0",
+	[3][0] = "VCE0U",
+	[4][0] = "UVD",
+	[5][0] = "UVD1U",
+	[13][0] = "OSS",
+	[14][0] = "HDP",
+	[15][0] = "SDMA0",
+	[32+0][0] = "UVD",
+	[32+1][0] = "UVDU",
+	[32+2][0] = "MP1",
+	[32+3][0] = "MP0",
+	[32+12][0] = "UTCL2",
+	[32+14][0] = "SDMA1",
+	[0][1] = "XDMA",
+	[1][1] = "DCE",
+	[2][1] = "DCEDWB",
+	[3][1] = "VCE0",
+	[4][1] = "VCE0U",
+	[5][1] = "UVD1",
+	[6][1] = "UVD1U",
+	[7][1] = "DBGU0",
+	[8][1] = "XDP",
+	[13][1] = "OSS",
+	[14][1] = "HDP",
+	[15][1] = "SDMA0",
+	[32+0][1] = "UVD",
+	[32+1][1] = "UVDU",
+	[32+2][1] = "DBGU1",
+	[32+3][1] = "MP1",
+	[32+4][1] = "MP0",
+	[32+14][1] = "SDMA1",
+};
+
+static const char *mmhub_client_ids_arcturus[][2] = {
+	[2][0] = "MP1",
+	[3][0] = "MP0",
+	[10][0] = "UTCL2",
+	[13][0] = "OSS",
+	[14][0] = "HDP",
+	[15][0] = "SDMA0",
+	[32+15][0] = "SDMA1",
+	[64+15][0] = "SDMA2",
+	[96+15][0] = "SDMA3",
+	[128+15][0] = "SDMA4",
+	[160+11][0] = "JPEG",
+	[160+12][0] = "VCN",
+	[160+13][0] = "VCNU",
+	[160+15][0] = "SDMA5",
+	[192+10][0] = "UTCL2",
+	[192+11][0] = "JPEG1",
+	[192+12][0] = "VCN1",
+	[192+13][0] = "VCN1U",
+	[192+15][0] = "SDMA6",
+	[224+15][0] = "SDMA7",
+	[0][1] = "DBGU1",
+	[1][1] = "XDP",
+	[2][1] = "MP1",
+	[3][1] = "MP0",
+	[13][1] = "OSS",
+	[14][1] = "HDP",
+	[15][1] = "SDMA0",
+	[32+15][1] = "SDMA1",
+	[32+15][1] = "SDMA1",
+	[64+15][1] = "SDMA2",
+	[96+15][1] = "SDMA3",
+	[128+15][1] = "SDMA4",
+	[160+11][1] = "JPEG",
+	[160+12][1] = "VCN",
+	[160+13][1] = "VCNU",
+	[160+15][1] = "SDMA5",
+	[192+11][1] = "JPEG1",
+	[192+12][1] = "VCN1",
+	[192+13][1] = "VCN1U",
+	[192+15][1] = "SDMA6",
+	[224+15][1] = "SDMA7",
+};
+
 static const u32 golden_settings_vega10_hdp[] =
 {
 	0xf64, 0x0fffffff, 0x00000000,
@@ -319,9 +516,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 {
 	struct amdgpu_vmhub *hub;
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
-	uint32_t status = 0, cid = 0;
+	uint32_t status = 0, cid = 0, rw = 0;
 	u64 addr;
 	char hub_name[10];
+	const char *mmhub_cid;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
@@ -358,6 +556,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		cid = REG_GET_FIELD(status,
 				    VM_L2_PROTECTION_FAULT_STATUS, CID);
+		rw = REG_GET_FIELD(status,
+				   VM_L2_PROTECTION_FAULT_STATUS, RW);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 	}
 
@@ -380,13 +580,37 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			dev_err(adev->dev,
 				"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 				status);
-			if (hub == &adev->vmhub[AMDGPU_GFXHUB_0])
+			if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
 				dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 					cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 					cid);
-			else
-				dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%x\n",
-					cid);
+			} else {
+				switch (adev->asic_type) {
+				case CHIP_VEGA10:
+					mmhub_cid = mmhub_client_ids_vega10[cid][rw];
+					break;
+				case CHIP_VEGA12:
+					mmhub_cid = mmhub_client_ids_vega12[cid][rw];
+					break;
+				case CHIP_VEGA20:
+					mmhub_cid = mmhub_client_ids_vega20[cid][rw];
+					break;
+				case CHIP_ARCTURUS:
+					mmhub_cid = mmhub_client_ids_arcturus[cid][rw];
+					break;
+				case CHIP_RAVEN:
+					mmhub_cid = mmhub_client_ids_raven[cid][rw];
+					break;
+				case CHIP_RENOIR:
+					mmhub_cid = mmhub_client_ids_renoir[cid][rw];
+					break;
+				default:
+					mmhub_cid = NULL;
+					break;
+				}
+				dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+					mmhub_cid ? mmhub_cid : "unknown", cid);
+			}
 			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 				REG_GET_FIELD(status,
 				VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
@@ -399,10 +623,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 				REG_GET_FIELD(status,
 				VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-			dev_err(adev->dev, "\t RW: 0x%lx\n",
-				REG_GET_FIELD(status,
-				VM_L2_PROTECTION_FAULT_STATUS, RW));
-
+			dev_err(adev->dev, "\t RW: 0x%x\n", rw);
 		}
 	}
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
