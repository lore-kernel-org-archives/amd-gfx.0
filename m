Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9005C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820676127A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 820676127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193576E8CF;
	Tue, 28 Sep 2021 16:44:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF946E8CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5s87qxbLsRhRqJC+TqsWpSgWBICeQDM/9qH42eBKHnC/7j2q1i2MxE7AAlh1B2IzN8kF5fOtWUZzwu1jJA68DktHyt+dD/w6LFCsBbmx1T1klpoBYJikibWV+bxmIw6joaMqOsTxE5YwPAjiPX+8HKy+J7tJyQRTvWQ/kXCGF7xYeT9BY8RTdGBCbZOQdzIIDU8f7Jievs55++hQeO26GzkAM+DuVPeAjnwIk48WbyAFQ37aFUamZJwajp7ueXUJKN+EV2lRSU/zrNB2Grru7xvshduvWPvGGMJZPlyReBKcoa1l4VxMjmu0U4UaC02J86zreQGB7xwjaxLYLNgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dshOBj0OKFd7G6O1X/yyo+Vog/DTI0YIFnPi47LPIGE=;
 b=ZnTD2eAudU2Ltmckv778o0jtAd5i8/VchloVS2LCavDbcgI2xbWSbmkLT0n3PYS2nU/vfrxiejORCMrNNviVGBgKM5WeeDXKRZT5Eos3ucWcqWdtAvBY6NyXkuhD7wn+On2+PMz9Lr/ffwnf3AMvGYQy2pRYzJRQISFengaXGjehc3euQ0Cpt4oPgYZJ5eQjCW+sV6y2pm2GwbXQaodPhbYvLCj/uVkZWOC5myf39AVXxc69v52oMyIViFRQhvghs0c/vNAqM2BvCcO/+3fIYdwSznJsbuA9vfPcBVbPBxHdD+cOtegjMLuIXbBJnv0Yyp5NUq4XZLSVKIG1N59uSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dshOBj0OKFd7G6O1X/yyo+Vog/DTI0YIFnPi47LPIGE=;
 b=TTMZrPH2EL8I8B790EDHm7nc+UYDOdQXMhJxMB8AZ1O9n7jMpyX1lK3OSItIu3JK1B5rbGNHaicNqARQB2tflztBWLsUd84unJC7Q1z/uQ/Hyetu+KLYUQel39tzbfkjtvQ6U4C6R/m4GhLRJXNpF8GYuVsNDNe8Bv6NsFxZ2iM=
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:44:35 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::dc) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 26/64] drm/amdgpu/sienna_cichlid_ppt: convert to IP version
 checking
Date: Tue, 28 Sep 2021 12:41:59 -0400
Message-ID: <20210928164237.833132-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47c5e80f-7814-4ca7-1ac0-08d9829f40e8
X-MS-TrafficTypeDiagnostic: DM8PR12MB5495:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5495B27E80FD407E3BE5A931F7A89@DM8PR12MB5495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZLaRldaUKqFPwjj9MdqT1XAVdl67dWWQAtmUwskZAGnJBWjWxkSeP+AdjE6ObqEOBUShy8APVDfnqEfCVG91FJAqIVquSZM2oDz/CLt0EZFaQz2LXhBvQOkosZAIOatLe5rR8QfoupR7cNObnRT+EOtqDywjYTg/dcyDQt90mSdz2jZwRRMC9RqM6iFDIc6rheKGVfp0aLRgNdtlwwnVxuLZUATMK8ULwPtG1Z7pdDiCpqT7iaYJFFTacjwYiNAybmy5BTjGZBNykeq+TgNNUz/fJTh+DrBGDKz8MukMGJA1bxiEzW3yPzGibvgFKlPeMXTNWg2y8xTN20XMD4UIBdVGkMfys09LPThnwtMHa4M4KXykPQzqbP/xLQ8zIrs7TkebYl29418b37GFAILO9WJgvxlFZ9EflGVpvv5IShoHl6wqt9VqcUfEVIMKdS40a5FCLwG9NoaTbLg7m2uyxFV55ggDJ1uBu79cymxn73wi7sGF0ClHRMQEttPeW9eZGx27MKzeUFM/mNYob5AkJxv8kalNdycXdn6AZWVy9I/Ks8Wk9U6GetdSJkUNKVRpHIAhXrhR/UvXum+NktV1rm9LOrKcyjCjwGr/N7VDiIP2BNm9ENYJGa0JbDZtdC0AEjxC/RoGePdqIP+fCZOksNl6cPQkTZPN7BUt0FCkGjYvb8C8nMKoWJN7wQKWHno9ZAoKszzfrjGpnadl9haO9vhBZ6EO2IRsGx2tL4/Deg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(4326008)(6666004)(1076003)(8676002)(8936002)(426003)(336012)(2616005)(54906003)(316002)(47076005)(186003)(36860700001)(83380400001)(86362001)(81166007)(36756003)(2906002)(66574015)(5660300002)(70586007)(82310400003)(508600001)(70206006)(26005)(356005)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:34.9190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c5e80f-7814-4ca7-1ac0-08d9829f40e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index ca57221e3962..6a0fed5e33d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -74,7 +74,7 @@
 #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
 
 #define GET_PPTABLE_MEMBER(field, member) do {\
-	if (smu->adev->asic_type == CHIP_BEIGE_GOBY)\
+	if (smu->adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13))\
 		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_beige_goby_t, field));\
 	else\
 		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_t, field));\
@@ -82,7 +82,7 @@
 
 static int get_table_size(struct smu_context *smu)
 {
-	if (smu->adev->asic_type == CHIP_BEIGE_GOBY)
+	if (smu->adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13))
 		return sizeof(PPTable_beige_goby_t);
 	else
 		return sizeof(PPTable_t);
@@ -298,7 +298,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	}
 
 	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
-	    (adev->asic_type > CHIP_SIENNA_CICHLID) &&
+	    (adev->ip_versions[MP1_HWIP] > IP_VERSION(11, 0, 7)) &&
 	    !(adev->flags & AMD_IS_APU))
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
 
@@ -496,7 +496,7 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
 	uint32_t throttler_status = 0;
 	int i;
 
-	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	if ((smu->adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) &&
 	     (smu->smc_fw_version >= 0x3A4300)) {
 		for (i = 0; i < THROTTLER_COUNT; i++)
 			throttler_status |=
@@ -517,7 +517,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
 	SmuMetrics_V2_t *metrics_v2 =
 		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
-	bool use_metrics_v2 = ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	bool use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) &&
 		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
 	uint16_t average_gfx_activity;
 	int ret = 0;
@@ -1170,7 +1170,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		 * and onwards SMU firmwares.
 		 */
 		smu_cmn_get_smc_version(smu, NULL, &smu_version);
-		if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+		if ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) &&
 		     (smu_version < 0x003a2900))
 			break;
 
@@ -1937,7 +1937,7 @@ static void sienna_cichlid_dump_od_table(struct smu_context *smu,
 							od_table->UclkFmax);
 
 	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (!((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	if (!((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) &&
 	       (smu_version < 0x003a2900)))
 		dev_dbg(smu->adev->dev, "OD: VddGfxOffset: %d\n", od_table->VddGfxOffset);
 }
@@ -2161,7 +2161,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 		 * and onwards SMU firmwares.
 		 */
 		smu_cmn_get_smc_version(smu, NULL, &smu_version);
-		if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+		if ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) &&
 		     (smu_version < 0x003a2900)) {
 			dev_err(smu->adev->dev, "OD GFX Voltage offset functionality is supported "
 						"only by 58.41.0 and onwards SMU firmwares!\n");
@@ -2865,7 +2865,7 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	PPTable_t *pptable = table_context->driver_pptable;
 	int i;
 
-	if (smu->adev->asic_type == CHIP_BEIGE_GOBY) {
+	if (smu->adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)) {
 		beige_goby_dump_pptable(smu);
 		return;
 	}
@@ -3625,7 +3625,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_V2_t *metrics_v2 =
 		&(metrics_external.SmuMetrics_V2);
 	struct amdgpu_device *adev = smu->adev;
-	bool use_metrics_v2 = ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	bool use_metrics_v2 = ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) &&
 		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
 	uint16_t average_gfx_activity;
 	int ret = 0;
@@ -3706,8 +3706,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
 
-	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu->smc_fw_version > 0x003A1E00) ||
-	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu->smc_fw_version > 0x00410400)) {
+	if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) && smu->smc_fw_version > 0x003A1E00) ||
+	      ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) && smu->smc_fw_version > 0x00410400)) {
 		gpu_metrics->pcie_link_width = use_metrics_v2 ? metrics_v2->PcieWidth : metrics->PcieWidth;
 		gpu_metrics->pcie_link_speed = link_speed[use_metrics_v2 ? metrics_v2->PcieRate : metrics->PcieRate];
 	} else {
-- 
2.31.1

