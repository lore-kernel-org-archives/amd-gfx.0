Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43286CA1014
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48C910E3F0;
	Thu,  4 Sep 2025 03:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V5d7q19V";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB9910E3E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 03:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB1DkLM2E7UqnPYCTOZN2bKonoQcXNUGuCZTY/GE4ScNh6KPK7cOMeD+EMsfQDZkWOGASFBLyI9P/n//mZryxpGb8lxYCgzkVuH0IhxemMjp7ojmmgV0L1/KLwsWynKmvvMlXHvStChEmsjdGYPqIjFWs6MPUltoTcQwFpRw9Qlbf5Tc56sBMBeSfGrkpu3rUsrBl6Ux+sA/Yw8POWrw2WlmYr9nob1IkgW1Zsvs5MwmVvi4jIPzPJWf/6rgFOhG7xm54i7mZKrB7FdhshiMlX2eVBDggygFpjFSpVWtTG+tKZkyxx3fOmD5U+VmLDRcyuPTObb0p32faL6owohQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn96ovTaNNUtogL4xv3Vznbbc2FIa0K4Vm2ksoUmBAE=;
 b=nizSd9U9MPO95ri2LdULTB1r0NE3qrvrZWfiE20+NiNMQ7qcoCl3mtbmEM+rF4LPyhnYixn9yUzyuzK7mJWhbx0/d88xyTsUY/jRRznf8zDF3jyLXyfTc/TpKkLy8utscZqo2nRNirzKck5K4otJS5KThIWucMoYVnMM6101ycOEFBdkHn6RlY63U9+8JIHQGPH6HzM7mK4mvmwVE0NUQDX/YPH0G/dIS7sNR4vhQ7nPcc5PmFqQkQVxsZ0MrWgz7Smz4j4BIPUkhT7Pk/E2r+6vSnZeXvBd+dfXZre6Z4/G8QqFvZat9GMfWSISuUZ45BPMqxvvU33cbZ9Jt68ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn96ovTaNNUtogL4xv3Vznbbc2FIa0K4Vm2ksoUmBAE=;
 b=V5d7q19VTGWU1bn87qdoew7PNq6vq2gCj6ErhuHhQrqy1hpuNAQEw8Zho540Zfdfk4zPRkIcuJlEZSb7WIekRtqrE1ZdQaTIWbitQFBikywigce+ZSKbCH6iYWXe+43u99kl2djJbjeFDCuj91dk6JXbxQVe2678KchJT/tz96s=
Received: from SA9PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:6e::18)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 03:13:27 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::4c) by SA9PR11CA0013.outlook.office365.com
 (2603:10b6:806:6e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 03:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 03:13:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 22:13:25 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 20:13:24 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: unified smu feature cap interface
Date: Thu, 4 Sep 2025 11:13:05 +0800
Message-ID: <20250904031309.2035678-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 7327db94-d142-46f6-c285-08ddeb6103bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mjSl9iQbazWNekfyEvqWFPmzolZK52PXeIa5U7v8/UQTBplJlAhSySwc0K2J?=
 =?us-ascii?Q?RYsVswvcRVYIbD8jBQ5A8dz6X23Iei58WJWvsCfHfYzOmnrlH441hp6A/0YZ?=
 =?us-ascii?Q?IGJWl48Pu8Srax+jQp7sueyo/ntg2Z1wsWB5xSDmHek8GoduHqZlrfQKqmR4?=
 =?us-ascii?Q?mCv3milS2OJz9LC4gCx66iLpt6XFifakGsWVqLRDZF6BLcJY5RaJyKvllTP6?=
 =?us-ascii?Q?4WbxSjDkFFr/QRwva4b5uecvlLjfkYbFtDaDtLWV1hCwDmWM+GV344vzwQwr?=
 =?us-ascii?Q?MGqkotNaGq9zbsbgPsoHdt2phhi0LwoN37uuapLd4ykO9D88BwYD9qWbBIEX?=
 =?us-ascii?Q?RmEQ7W7kSN7WrvR5TAOAEXP2ZJ/iTNhfgNU2D0sP61ZHF/jBZrzSUY7xeocz?=
 =?us-ascii?Q?WtFpYY61m/TbkA/xhAImlDp/2vFwFCGP6uzTGv8vND3oHY03qRDyn9iZcjuy?=
 =?us-ascii?Q?nuOF93Wc/4NwL43NjBgX71FECAVcWbepfpCIMhclDMq90SQvfcrFi80O0Iuq?=
 =?us-ascii?Q?Z6mO5MR9vx3EIbYPVqFLE7OJxqJzU/K/ecIdQYC9LM2M3UqD/JNr5x93MKO/?=
 =?us-ascii?Q?wIKzwTEM4y1d5xfoLTfoWslCzpIUaSXJ/34EWEVHILLXqSzV8mTqjeQw52+g?=
 =?us-ascii?Q?qvhEDHMETpjQN98sw3kJ1ZLYOfTjY7DkIZtaUaBRLmbXsQGmi14vNtrNl0S+?=
 =?us-ascii?Q?4r4MqbwCGxNP0kt3qmCKuiOpPjt4/qMrUQYh1RZ/NGFQ8EdXDQjo33ZhPtbn?=
 =?us-ascii?Q?+FSaItV2waMlh4AoFpPD5kaoWVuBpeGwoLdnO9AOWAlQK4BJvBvSpSAqD63a?=
 =?us-ascii?Q?2ZOviNR8tLqkGvgxZl5dRPFrSOPbXDx4X+ao+uZXDAK+hmPB6dHypSEmwD0G?=
 =?us-ascii?Q?vOSk7SZEb6wH6KpHpKLJBN44q4HR8USSa8Cd+xb8rYutOC7KjT0hWELfqdn2?=
 =?us-ascii?Q?Y3Qj6Cmwom+9fDhYAY23ajsNDaHuLAf2jcNvySnsyoMN71mQopi6laPTDEig?=
 =?us-ascii?Q?UqLodMkSiesQ51LJT0Syjfo3vQ92mFSwFy3RKw+N4mZXDVDXVYwAOiuXGDdS?=
 =?us-ascii?Q?LgSIlOMP0Vesq+yyhWNZ5StccZ/JNdMIcnWa0GbUoUAcSDbLFxAlTBN5UFbT?=
 =?us-ascii?Q?wB77itTeH8TpYf2e2WmBeR5qcQEY6xuyhi9SNnd7SazY8R5PF3YFduAQNCXH?=
 =?us-ascii?Q?de9wlmI+16Xzd+EZdU9sZWjmECD4si56nJ36n5UJIPtO1d3ZewMofgTO1fx6?=
 =?us-ascii?Q?vnsxQGPzBF939e9ldeNKb4ALBEb8pALu3yFnNhNsc0dnzbouCRr+oFaRq98U?=
 =?us-ascii?Q?kFcN8ZEKbQ+sTHB7uCFoknTq2LvXwCHJ8nC1SMETOnOxwShPmq4RZLDk8c0W?=
 =?us-ascii?Q?WGDuY6Uh/+4Y0pKujwStv+qgFIWMreeOqqZSXKV+exLHu6ImhVImrIM2LmBl?=
 =?us-ascii?Q?6QeiSbd1yOIu46e2cc8LniYbMkUDwJep3KopQYCnFesqhLv514Koxt7Z1N5g?=
 =?us-ascii?Q?jrYaxgog4eZTXf/QUHvOzFPuBJdNpDMJ/XEn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 03:13:26.3051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7327db94-d142-46f6-c285-08ddeb6103bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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

add a unified interface to provide smu feature cap set.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 12 ++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c5965924e7c6..52b93642a26e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1316,6 +1316,33 @@ static void smu_init_power_profile(struct smu_context *smu)
 	smu_power_profile_mode_get(smu, smu->power_profile_mode);
 }
 
+void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id)
+{
+	struct smu_feature_cap *fea_cap = &smu->fea_cap;
+
+	if (fea_id >= SMU_FEATURE_CAP_ID__COUNT)
+		return;
+
+	set_bit(fea_id, fea_cap->cap_map);
+}
+
+bool smu_feature_cap_test(struct smu_context *smu, enum smu_feature_cap_id fea_id)
+{
+	struct smu_feature_cap *fea_cap = &smu->fea_cap;
+
+	if (fea_id >= SMU_FEATURE_CAP_ID__COUNT)
+		return false;
+
+	return test_bit(fea_id, fea_cap->cap_map);
+}
+
+static void smu_feature_cap_init(struct smu_context *smu)
+{
+	struct smu_feature_cap *fea_cap = &smu->fea_cap;
+
+	bitmap_zero(fea_cap->cap_map, SMU_FEATURE_CAP_ID__COUNT);
+}
+
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1348,6 +1375,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	INIT_DELAYED_WORK(&smu->swctf_delayed_work,
 			  smu_swctf_delayed_work_handler);
 
+	smu_feature_cap_init(smu);
+
 	ret = smu_smc_table_sw_init(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to sw init smc table!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 5dd49eca598d..b0f5790051d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -527,6 +527,14 @@ enum smu_fw_status {
  */
 #define SMU_WBRF_EVENT_HANDLING_PACE	10
 
+enum smu_feature_cap_id {
+	SMU_FEATURE_CAP_ID__COUNT,
+};
+
+struct smu_feature_cap {
+	DECLARE_BITMAP(cap_map, SMU_FEATURE_CAP_ID__COUNT);
+};
+
 struct smu_context {
 	struct amdgpu_device            *adev;
 	struct amdgpu_irq_src		irq_source;
@@ -549,6 +557,7 @@ struct smu_context {
 	struct amd_pp_display_configuration  *display_config;
 	struct smu_baco_context		smu_baco;
 	struct smu_temperature_range	thermal_range;
+	struct smu_feature_cap		fea_cap;
 	void *od_settings;
 
 	struct smu_umd_pstate_table	pstate_table;
@@ -1787,4 +1796,7 @@ ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
 
 #endif
+
+void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id);
+bool smu_feature_cap_test(struct smu_context *smu, enum smu_feature_cap_id fea_id);
 #endif
-- 
2.34.1

