Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EB0C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054D82083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ygi6dAEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054D82083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22BA6E994;
	Fri, 31 Jul 2020 02:43:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6737F6E994
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrN3h5RRaUpu3IwTRLwJW2PP0XRS4bp8j5BSXPxldjpq4rzJywJsQ0GPgMyjJ9qO1Go6xsgmuwoR345zqJOQmqCGza8Rkf5zdgi+wzbkoPxzlXKySyP6kaCxTQ9CrrIvePcP0k6JINrgsg/DH/gsOsW9wjgcmw1KznPTaohZ7tJQtI8oXsk+BxUFFvKlFf72XUDRTo7CvWjzyqLnaR2Akh4w1AKWC3QQNLl43TgQ6jJ0Ybdztu9rD0gKLKekl/ZbXmGhML660a2u4x7/zzQC0lt68KAG1tHsTuTtvmrAXLqmXj+HNDKTrVk6bTu3cWTBydKdNp1sLaL7MBMrjR2F6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuPtuHcCXn+Ewy3tyuwV0aNhNADAgng5KPCGFhhg8pg=;
 b=YkR67zb+E2fqThTAfMcun9U7IrAc4crSyEpHpsq2NK+qwzalta4LunL5fZPdOypJ6jEeQcbEMpIJZ1B2N/zeRtAouCDkiwpsGhJqF5UX8hybXLW7QrQ8nhVUUq+vXJUTm1Q5rblPQ3Qr34HTX/nHVBYvoHG4tPnbqE8ZiSiCjEm/2/OBgA9IYsw5eTvoE8pjJAZdbvlIN5iQRmcjGojnp0BdSiBG41ldwDafxnlojkxGgbYIyBvRQLUENNrBg4V0FcYxNT8/rWFDaZaaZ7dt59Z/6fphouscZx5wFZp5WbwCDZ34DLFjGk37o3RyCceV6NlGNFlHiYgxyrdVsF2znA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuPtuHcCXn+Ewy3tyuwV0aNhNADAgng5KPCGFhhg8pg=;
 b=Ygi6dAEOq4LRukI0RszPCCnxqPe+k9qZeg9L85zImGATaF/3TpGHAVmhkk+x5XLXHXxDIcFu4g/f9GisfnNJiSbcIfC6liwNhWDzzwDfj7MfTXUwG4/ZoGASh9NJ/6+Qx1nr5wzOcQkFHxk+p2P/KiBzZ2Z6tlEp+rLcIIBWMXw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:43:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:43:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/17] drm/amd/powerplay: implement SMU V11 common APIs for
 retrieving link speed/width
Date: Fri, 31 Jul 2020 10:43:02 +0800
Message-Id: <20200731024316.28324-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:43:47 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e0bf2b0-16ff-4218-949a-08d834fb8dda
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435ED176F60093D3555F0CBE44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPWIrsMwXfhfq5i+/jWe1/jVO52q7LXBGViOk83Y4iJOmuBVUjMeeqAQULu1DKDZNgiYoIek8DWjcK2MVloN9N0EtIStXJTYXuyq/eenxfKHRfAmlyMFq53GBVDBOe3i89SDQ3rO9XFAYlqO9IC4NOJne//ZeH2MJ1+2EhgKlsGj70gho6LRGnCMYfTyN2cU3zdMvFgZFuf5BrogcMbMOKtXfdMn5lfFrkE5mMJoXe/xjEkU42tPXexHizll5P0pF8aSUR3ht+BV7yphE/Bivu66HMkCHWRbg2oA79U0kpJi+vi2g1FyxS7Ol9kweFsz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4XDf6VJht7PKhNkZ7siKXF0Oc0OIEooHQNF/Zl2hC6bliXffkfWts3OCYfjdT5M6BILfec0MDA67v6K3IbrJnLE+6sdp2CxXEOQrAdoj6wM8SouPrmLnMgal0NwVzB8aShQW7GjFRoo0oudpjTdkmPJYOMpW9ppcZftXfyMmeHrCBF1KNa5jCKhoGztMB+C+H5gtw9k2p7lEFKTjyhsxiIQMXr+nu2orhoU3PpTuC+2tMdrJrwYQyLdUxFefL6kvhhL2Mr84duxD8uluHVrnRIEYdGwoE7hNDmXIvJDiyzfZSysWzm8xRZy9va1DEcZmEaajTEtsffhKVGMajhOiYx81nqhF+GBGocWPBOAaOd+H4nFD0JCuWg173Akl7kfLahAz8WL43AQyZoCR+VI/lfLQm91SfAiq17nASu0jzX+bgVE2/VNx8fTGPu+E+meIYHLv2IvUFhzCJS7nxC2ox/Sp10sqA9oliX4D3e/T0NQFU5V8RLnvBXSGdNEkrkczr1RxcnhLssHBXF/GRo57zRrwP98Wc12T4QZlGJNn3deOd3UnYqg5ltvjwmMEAQ6vuuo+yVrI6sVOEnQugizWzq9xgiJzxZeRiZxhcjQ98Tk1UlIR2+fukwy04QJLw7VX0JUsZ4zaM8/0InhkJNPeDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0bf2b0-16ff-4218-949a-08d834fb8dda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:43:49.5872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y5E8J+ehgXu4BocedXLxCrs3cA7HQtOgX/jRwDxHhSGjfJZiGjTwo5nbbKnogyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
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
