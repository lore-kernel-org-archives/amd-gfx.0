Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A416FC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7678F60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7678F60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837E36EA9C;
	Tue, 21 Sep 2021 18:08:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252BD6EA75
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C72vjwekXIxHgY0Lvq0vj7V3448CyMTPqSy2wYHxsI7xiq6XlKh/8gBRtZmwCtEwSMu7Zy8NZ9bLkSOFD9j0ur6rBsUqfjj0vQFadu1l0qZrG++CRLs080efJkHVshlYdQvHTP5m1PfrR9skOCck9SMZ1mhqaSsQdQxcTTe382TCgWgOqt7m4+cgJZ0MWPlbgPEZrdKqexkIekQ84I6wrCFufOE24Blw0H1LZMlamAZa7zV3p2lc3RbLF92zKma4oW8r0VAT9a+Y64H2zIA4IUx0TpWYokBLywkYoeq9b230ky0y3AWKIiVkeJAL1cVSFqF3CEFp/CM3r/wxss9e3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wwqFdnSy5Z4qknPo62VNgjabFkEG/vrwEAWpSehXFtw=;
 b=N7yDjnSPwY9eitjSNen4/4aWr6Snz3Lq7NmhriC+5zyy+8I1FI+DPLAW8/KF59nKofB9Hp1c9OJQeQOzXkApRRkz9SavmjRL8sMB8o52xwImNA6WWPD29zpVO6DzEbHTiB66ythVKAUhXdlJeo5TRPWIXlpD0QGYMM5vzbnzXT0tgtXa3RrPZALjVX/FKwvF98DenaDOwZ6AzepDFXynRzeTQGriCAp6BbdbBPmfsyjD//OWH6Hlvg5mBxyLgLslSwnqvnvtIGHDas+QlMttxDCq/loc/usdpKgsS71CIeOKup8BHy6LLWNwikWC8HKLR7p8tTUPkAo0cwicdXnDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwqFdnSy5Z4qknPo62VNgjabFkEG/vrwEAWpSehXFtw=;
 b=nEnTtUstA9i8hjx5Szb7V+8KT9pAASENWj+glOBswztELYWnCckbouLaDvNdbVejZDJc9/PV8FK+2KeRBXNkVLkvMyklT7+Uv8tp+EQJVc+or7plUtuC7StK5Jex7G6p8k9EZDnGq0nAn+0euXckZvgJr7szOPsL3Wh7K86SUbs=
Received: from DM6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:5:174::12)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:07:54 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::59) by DM6PR21CA0002.outlook.office365.com
 (2603:10b6:5:174::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.6 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/66] drm/amdgpu/sienna_cichlid_ppt: convert to IP version
 checking
Date: Tue, 21 Sep 2021 14:06:45 -0400
Message-ID: <20210921180725.1985552-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad5bf9c9-9e99-453f-d5bd-08d97d2abbfa
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52632250ED570A039010ECF3F7A19@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpSPPXruFXR9fCthyENPKAwtK6Ljt7ZxTl/dYsIrG/U3WjJTcaapS6R+dnRFW383XERPh0oxtS8Rlz/vVL8EjlKBlPbSKd+tyAVWI9a3HHrxmRKT35PJ7YZ9904uc8yF7RJe0ZWnp5VHdwqcRrP7SlIj/Pon3WrUjoP3t5Y00DUVmhs96sZukYb1Emuhgc19CuH8ANyPrz5dLT1/Y7hm/d8sx+Lc27BBSIebqAoc7v0XxdDt6UY4bVAuRS31ZIj3t87C6uqROu9sPyR9gb+SrV33lYpdroZSecNZppD7+2hQNZv7ucS3Didc1b+Tij8zIx9xV+Ssbjt83G/eKg46H2t3Ymt35KU3YdSw0LaJI8fRoWXjBTRNXB6qKL+G8pgBsPo0UYJ4aFv6H/pMdR9SFgcYs3XahCHTThlvKrKwNCDBjsTJ9uwJ+0bw3ELZh/YLc45jIAa8BeJmhg9F8LQSMSGDfR580w+NvrWUrERzpYDdVkGzlAuJX9q4VUNvn+HJGAn3hGfQeU6OdEFhdSnaenmOdteKWU+5KOR6OWT67jseCn7jNpLznVbMHEJshPUnh70CNAlfe4xG1I6UcEoqgLPAg8iAiO0Kxb0BE5ndhN7AyHbumqm3GceERQlxjKvV5MW3OAHu+tqWWNarxZGLoFZi9E+p50mLkfOuwHYUv/XKUoG9xSu6nNsz1ZvuPIWw9hPqk3hKtOWMxYqHXsgGGOZ1kEKgIHx1cIwMI8hqXqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(26005)(16526019)(186003)(316002)(70206006)(70586007)(81166007)(7696005)(8936002)(356005)(508600001)(36860700001)(86362001)(4326008)(6916009)(36756003)(2616005)(426003)(336012)(82310400003)(6666004)(2906002)(83380400001)(8676002)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:54.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5bf9c9-9e99-453f-d5bd-08d97d2abbfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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

