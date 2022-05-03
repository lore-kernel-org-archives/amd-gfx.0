Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F5CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5012E10F46D;
	Tue,  3 May 2022 20:37:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E67610F45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6VrRCV2uBdfwiTlPiRCEL23Bud3PxYB0R8eh+T7WbiayK4AoIqt7K4jET70VopB6MFjdfuItGwoMhny7kmf7M35u5ktcCg7YfqRXnZurQMSUA97aFnm2t/3Pz3yZvxQ6iKcKYkx/e0gmr5TA2CwSKqgLSUxBZLG26E6KU8F437cIsHpkutelOdrKWgKF7VVjq6k/jY/n3O/2Ahb01PL4QXv0Uc7cgQEr3lMlopw+jo98/2zZfnqTQPWWpgZvHMOt9GaUDMUjTffoOMxXsDhF+LC1GrbTYmKC8h/+/SEeIe15IRh3U60qYai1IlEW0J5lDsiN7cMOShTCzGQ3X3UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ildGjStcbJOXylB3HVLvudBjDzt6m6kadCmN+Q8BIRg=;
 b=bSvuAWmmCAK/aQ59QQG+xoFHtaf/PJ38ntp5B+CnGFDVRl1r4CeArhANuy9D2G905fWUIcV649+dKcnvVgW3BrP/ViKV1Zb98hKCZMWgpHW0xWNjzuYWpgRvMmMKZIrH0b/N0TGHYbjXpMci54I57pYfEHBq/bxjlwm94ZDdyr9BtuUEQVYBTNJeoip/hjzjsxhHTzx6RDhhgRIpBANRi6PcUQHEu2P6DFW3lu7gKOCQ1M8eAthGKWizF45cU/4cmaC5YE1xxPjFS6cPKvO/UYJsEpdy9ADFchnhpPpgAWP8NYeBmZkNmbNQr1qGqNyT5m9eZoFLFn09WH9H8ur26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ildGjStcbJOXylB3HVLvudBjDzt6m6kadCmN+Q8BIRg=;
 b=xJybr56xCcfIdOMt7xJlWoBJyeAesyLbBMdPLJTnQvR4TfsnvslZ+EEXWsXbgOX9yTGeetLzZ1PhwEllzFYk6hQKqC9sPrUzGTiV9JjKV2ARItrqqFO0GfO40OZf8Oa+OM4FuxblF34LqF77f/Jq/xAIx7GjMdrO4O2OimhltRU=
Received: from MW4PR04CA0150.namprd04.prod.outlook.com (2603:10b6:303:84::35)
 by BY5PR12MB3857.namprd12.prod.outlook.com (2603:10b6:a03:196::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:37:39 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::30) by MW4PR04CA0150.outlook.office365.com
 (2603:10b6:303:84::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/26] drm/amd/pm: add SCPM support in smu v13_0_7
Date: Tue, 3 May 2022 16:37:02 -0400
Message-ID: <20220503203716.1230313-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f544cd1f-19d7-444c-78e1-08da2d44c3a4
X-MS-TrafficTypeDiagnostic: BY5PR12MB3857:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38572E3F1DCAB7203A049DE2F7C09@BY5PR12MB3857.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjdPaVDszcrvnQznrvnlFdMfORT8W+CyiJ4uE287q+fmJV/gCLs8SqzPuWoAqXfVJlovY+xuMEvZpC1nA9JmZ7z0rlELVNwzVg+vPyf1OODtWV9SyYgvaHDBqKG87mhIGjHF+ZCuY3mi39gMb4SXo2FSh9XVULNEJyfheO5+RtVwwo7PFz+pk1zIMGbAjKAn73Cl9seVeAYq4S7qZpm51+zhcZkKd47mRNI+PLvs0UGq7EoG35G/TpCvMUfcTDCB2dMVbIwduAuIt3vaUl0KZts2dpRz9GtkgKb6bDFIwjJW6IQFj0xFVM2WihF5J4zXNon7kV6CXKw2FHWMUUyNzSbyKA+BKVIRj8zqcykwUCie2WygJDCpWrPUne1HV7OsD1dc+I4fpyb/YRo6+SEQVhsPcLwCKb03PFRFTr/ms7mpsutz3N2NGd8aqPrvgrsImPb4VEw687FkfXt8zH5J/Mq8bc1PDprajQQ9dcIkaVK3wNdHGGHA/rXSbApK/PAapajFXqXE95zObdUt4d9LN4IBE92YDuJRQJcYNMM1OOo83ptaiygEZ6lHBpdWVKqJdls5dPdL7j3dWEKnrDinBk1iTbWwZnbBvqrkwFGl+cVAwyqae+pMh12qiR5qV4V+1QPZPPlo4OuMtTa69nQUDRIUH0PBq8DVh3bDig2u2qMTNfA0PtHCq7ivEOArOroQArxUGDss3X6kQ/bVB+mWHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(8936002)(70586007)(5660300002)(316002)(70206006)(4326008)(6666004)(426003)(47076005)(336012)(36756003)(86362001)(356005)(7696005)(2906002)(81166007)(2616005)(36860700001)(82310400005)(186003)(16526019)(40460700003)(54906003)(6916009)(508600001)(83380400001)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:38.7833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f544cd1f-19d7-444c-78e1-08da2d44c3a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3857
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
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

port the SCPM change from smu_v13_0_0 to smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  3 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 41 ++++++++++++++++---
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8946df456a95..65ff98a18699 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -445,6 +445,9 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 		 */
 		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0))
 			pptable_id = 9999;
+
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7))
+			pptable_id = 8888;
 	}
 
 	/* force using vbios pptable in sriov mode */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 145ecfe040f9..f899cd483ca8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -69,6 +69,8 @@
 
 #define smnMP1_FIRMWARE_FLAGS_SMU_13_0_7   0x3b10028
 
+#define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
+
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -128,6 +130,7 @@ static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(SMU_METRICS),
 	TAB_MAP(DRIVER_SMU_CONFIG),
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
+	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -286,19 +289,42 @@ static int smu_v13_0_7_append_powerplay_table(struct smu_context *smu)
 
 static int smu_v13_0_7_setup_pptable(struct smu_context *smu)
 {
+	struct smu_table_context *smu_table = &smu->smu_table;
+	void *combo_pptable = smu_table->combo_pptable;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	ret = smu_v13_0_setup_pptable(smu);
-	if (ret)
-		return ret;
+	/*
+	 * With SCPM enabled, the pptable used will be signed. It cannot
+	 * be used directly by driver. To get the raw pptable, we need to
+	 * rely on the combo pptable(and its revelant SMU message).
+	 */
+	if (adev->scpm_enabled) {
+		ret = smu_cmn_get_combo_pptable(smu);
+		if (ret)
+			return ret;
+
+		smu->smu_table.power_play_table = combo_pptable;
+		smu->smu_table.power_play_table_size = sizeof(struct smu_13_0_7_powerplay_table);
+	} else {
+		ret = smu_v13_0_setup_pptable(smu);
+		if (ret)
+			return ret;
+	}
 
 	ret = smu_v13_0_7_store_powerplay_table(smu);
 	if (ret)
 		return ret;
 
-	ret = smu_v13_0_7_append_powerplay_table(smu);
-	if (ret)
-		return ret;
+	/*
+	 * With SCPM enabled, the operation below will be handled
+	 * by PSP. Driver involvment is unnecessary and useless.
+	 */
+	if (!adev->scpm_enabled) {
+		ret = smu_v13_0_7_append_powerplay_table(smu);
+		if (ret)
+			return ret;
+	}
 
 	ret = smu_v13_0_7_check_powerplay_table(smu);
 	if (ret)
@@ -329,6 +355,8 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 		       sizeof(DpmActivityMonitorCoeffIntExternal_t), PAGE_SIZE,
 	               AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
+			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -493,6 +521,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
+	.init_pptable_microcode = smu_v13_0_init_pptable_microcode,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

