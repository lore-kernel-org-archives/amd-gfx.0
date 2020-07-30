Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE43C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEA822B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bxpCjNQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEA822B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577576E84D;
	Thu, 30 Jul 2020 03:29:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188746E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Otxzko7FlZdcqTIpvft0lrloYe9xPdj1iA50gX9bxGzzI5EoCMLR8xv9hOBlcmUhTOhWiko1p29ev5PmkgVYD9R5OVwu5mvSUOn07X03b+C1jBWRhJLanHlK6jI7EMMa13I7E4Unmzdc4VclFD9fW231R0tWP/Yt/4b5OE3x6THfXSG6nSRskC7hxCOKcFx3RZkUB52OQ/fouVgDhwkFauoLhuIgtCYKgKR55prx4WFybIkftWVQmODpMnq8IHQr0wWxoePCzQbATprcAWoAk+AWOyaWx0giNFLM0CXl3fg0IreEXDets5qCi8BaZ9+hEjKWlXUdocX8kotuiNVmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuPtuHcCXn+Ewy3tyuwV0aNhNADAgng5KPCGFhhg8pg=;
 b=H168qT1Senxfzcp1IuRDM7+SXH4d8jE4uikkWCCmRpXNVr1/D89tOgKIkeOn2FIbJAF9/nnG2UTG+/XJEA65lKjMqXH4iftszPFoc996vjnJwPnIlUtX9RDxitkwbzMfH9m9MGwglll9s4ZQhtaUC5WgWbInlG7ogs/HJgMdwHucnaagQGPdaWjKbJS4mkM6Inntuj/XnA3sPB+tAKJdHjEd4NaSXRxAXrScZ0PUymg56HJjTUW+5uWXuhAjYM994Sga0v2RQraf+d9SknNgFNPam6t2C2uiTd66qBQ/3ubZuBHLH8t/HyfycMsq9CiUu7zZ2/FIe/cHpUB75rcmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuPtuHcCXn+Ewy3tyuwV0aNhNADAgng5KPCGFhhg8pg=;
 b=bxpCjNQmSWrf230kWJGDH/GBaY//6UGUMhhunLd3mTP4McI51qH2wWCw1YbzPJEOrEOUv8OvtDKlJb4nqKQqwu9Kr44in+4Cf0W35iRYSJn86btZuNBWL3sHd55YpkVDddjYuz4HnuhZiHRR1R7eCo64WuTjmFRwofdyxBINeFg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:29:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:29:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amd/powerplay: implement SMU V11 common APIs for
 retrieving link speed/width
Date: Thu, 30 Jul 2020 11:28:34 +0800
Message-Id: <20200730032839.2517-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730032839.2517-1-evan.quan@amd.com>
References: <20200730032839.2517-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:29:18 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1244d57-e4f4-4e53-efb1-08d83438be9d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355D6DC22693C2DDDB3E530E4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMOexDwuUfjFx57UwU/fMb7GPiyivbEX48LixQoF8U3ulTNHtxKrJk6RHUwwyH7OK8UFSg/S2T2EmhyzmPJlD7sClBzdFZ5ECbqq/YRIV76qeaLldIXEtpv9q1kF6rj0fKwq5g8B9woFw4Ny/909XIeap1wG8JRbPRLyaRqa6Jjiu4ye4XUF5MnxK9hd1dBTrim5Otmt8cr/0O8iPon6/Q6/12lCcmzQlIXU9tQvs2dtyqd779rnoUsuTF/E6JWiWMBFsbu0OziWxs6+odUOXIPu2MgH0Q8ViR/zlePHZhA0UIskC+Q27vyTLL022zSB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6666004)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: u+YrJoveA7k+r3z4hw5kcnhSc+xSmXcyH9+79bSMhSGz5hzAKGAHgRNjMc1dlvtSNCxoqPLaLk6eMbIP8VI67xE8+HTEx3/9yBs17bGGxqdd5AERLd71wRnD422zzyb9HXfPjLS40WBEBNX+7vIdvAXrCHKpp69JJzDCEjulcg/t+t/VT+/iWsSx2CYRhQmlA9DbdBUss4T/dGG/e/P7kpBqQN+FPdMg+T2e54cEebC2+25GZvR9v8ejurLT6z9wPJsAJ9CuLWQ+ic758nT9YB/XTb+mk5Y9iN7sAeSpLIaNkNh8HWYU/Gg4W7ZpHwn3R9NLxzWoA7W6EsFC10HqxBFlYSLyrIza+d7tMdbLRVoVGbhHJMCoo8qoMP/pay1B/HCVq7EwyhbZLc9ADADzLT02S4ZRl4mo3dNqaDrIxTh8Aw81gDFED1w1TUxxkQGKuV9r6U5wU5jK1kYE6JgkxzkyT+ircFjZ+RJ8b2ml6iI8fWdmUtEuZZd4fpYSeH2TV8Z/ceAUVEzVShPX0O7aRKAD5DJdVO4YO4+T6RrXcYmhNkWX9XYKg61cS0G5DIQ7z38d2mDcdoToWq6poE6MeeviN9ZDVHPcPxM4covSMm8hX+hcW9Imw4x2MNYpFoJKodBqGz2aUBu1R8AwhcCwZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1244d57-e4f4-4e53-efb1-08d83438be9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:29:19.6498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 662j7fjAvyCEoc2WNMelSs8wmqPyhBPgatO5KysgWEtYaNd9ubt5Lt3WwQbRAH4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will be shared around all SMU V11 asics.

Change-Id: Iaa4554fb0e011b9f565d89375ac7b6a7eb525420
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  8 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  9 +---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.h    |  3 --
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  8 +--
 .../drm/amd/powerplay/sienna_cichlid_ppt.h    |  3 --
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 53 +++++++++++++++++++
 6 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 6a42331aba8a..aeb12654257e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -264,5 +264,13 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 				  uint32_t *min_value,
 				  uint32_t *max_value);
 
+int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
+
+int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
+
+int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
+
+int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6aaf483858a0..3a3c555f0e82 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -917,7 +917,6 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	uint32_t gen_speed, lane_width;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	struct amdgpu_device *adev = smu->adev;
 	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
@@ -971,12 +970,8 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		}
 		break;
 	case SMU_PCIE:
-		gen_speed = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
-			     PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
-			>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
-		lane_width = (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
-			      PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
-			>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
 			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
index 2abb4ba01db1..84dc5a1b6830 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
@@ -49,9 +49,6 @@
 
 #define NAVI10_VOLTAGE_SCALE (4)
 
-#define smnPCIE_LC_SPEED_CNTL			0x11140290
-#define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
-
 extern void navi10_set_ppt_funcs(struct smu_context *smu);
 
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index f64a1be94cb8..c15496aea50f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -960,12 +960,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		}
 		break;
 	case SMU_PCIE:
-		gen_speed = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
-			     PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
-			>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
-		lane_width = (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
-			      PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
-			>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+		gen_speed = smu_v11_0_get_current_pcie_link_speed(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width(smu);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
 			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
index 8078886e4cbc..57e120c440ea 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
@@ -31,7 +31,4 @@ typedef enum {
 
 extern void sienna_cichlid_set_ppt_funcs(struct smu_context *smu);
 
-#define smnPCIE_LC_SPEED_CNTL                   0x11140290
-#define smnPCIE_LC_LINK_WIDTH_CNTL              0x11140288
-
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 26b4fff9e0d9..7f1229a0e8db 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -67,6 +67,19 @@ MODULE_FIRMWARE("amdgpu/navy_flounder_smc.bin");
 
 #define SMU11_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
+#define LINK_WIDTH_MAX				6
+#define LINK_SPEED_MAX				3
+
+#define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
+#define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
+#define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
+#define smnPCIE_LC_SPEED_CNTL			0x11140290
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
+
+static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static int link_speed[] = {25, 50, 80, 160};
+
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1917,3 +1930,43 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+		PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+}
+
+int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
+{
+	uint32_t width_level;
+
+	width_level = smu_v11_0_get_current_pcie_link_width_level(smu);
+	if (width_level > LINK_WIDTH_MAX)
+		width_level = 0;
+
+	return link_width[width_level];
+}
+
+int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+}
+
+int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
+{
+	uint32_t speed_level;
+
+	speed_level = smu_v11_0_get_current_pcie_link_speed_level(smu);
+	if (speed_level > LINK_SPEED_MAX)
+		speed_level = 0;
+
+	return link_speed[speed_level];
+}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
