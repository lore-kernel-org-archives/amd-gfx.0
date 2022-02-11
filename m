Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25681C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE62010EA03;
	Fri, 11 Feb 2022 07:52:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A499310EA03
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ1HLs22VBWIIaxyGXqGAQDPNfR0dqASCbqUUFycTGx7QAdre3UgeWGUZpUNmeZavsDb6Z5iEE4LS7YMiIwGm6O8toi46Jx8rnxGu5REuDSLSNjPpvdXUtSi5bChDX9zXHBTQW5RdM4+L4hpKFu4xb6FUP6nlywiUmmFJ3IWzRzWVTreldqbbKmfNPMJL/ZrUNv+z2NmELKeAq95AfJ0jKXiJI8stx7vENqEcIyRc5pNvfZPU8Z08z65sHUyWoAxaLWzxLKnmiKSmeSSqCOgircXZnDNOBUNBusRWuzKDFWYtDZHIJE3Ez7yg464ijbs0LNt0nJnZlm5ldGhX1dugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J7zGcpm9sX5pm5D4smY0qN3RSPL7Uit5StnFIjkNnE=;
 b=UC70k+pyvsaES6svaFHuCQkCVHpAsJSdP7STIdjTv6NAJx/lpyKGOsQ+vG6gScm/UZVOkyqg0FS1qjJopiaMZ0zbmliiA8CCmUV3+E9l1YY1S4DCOm2W57AXRCybXbIpN0ZlsP+nVyq3ZEtqzDgM/SJlnQwp+CsV9Vycj8wwquEjtquvz/5sqED5eFUh3Pd8MEXYuQ4BceG//+AC4B364VHzDoYfyrEoKBz1BZTm3yXp8tpmarfMqFC5CHU12t2hmAnVHhYBgoYa1e0qtlStkozyiBVHIlgcwTzMqq/SqcxC7rSMq0Aq5uuO0TSSpWHPFba4GHvSTmYY3PxyWGvA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J7zGcpm9sX5pm5D4smY0qN3RSPL7Uit5StnFIjkNnE=;
 b=cYHQS2MUlG5qV6ZXqz6Ua4ksMz4sbj/tMErVNzr3kiNW1BQFMhsSMy1jxjGb76CQfwuB8q9AnU046z+FAofZ42vgvgjA5Zjbs4tcuU0Y9o5lhbdAR9I2qJ3SqOIiGsiwwpAry+5odcLVUqlkxuelET9f2aAFxqwUW3Dl7px1gJs=
Received: from DM5PR1401CA0004.namprd14.prod.outlook.com (2603:10b6:4:4a::14)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 07:52:42 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::3a) by DM5PR1401CA0004.outlook.office365.com
 (2603:10b6:4:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:42 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:39 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/pm: drop unneeded !smu->pm_enabled check
Date: Fri, 11 Feb 2022 15:52:00 +0800
Message-ID: <20220211075209.894833-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a2a5ee8-2905-4da4-4a16-08d9ed337bba
X-MS-TrafficTypeDiagnostic: PH0PR12MB5467:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB546741AAAEF4FE79AE2DE3B2E4309@PH0PR12MB5467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSBI6CNHvrLKatQvhpuf3R6GhxMdfeIW8Wb9j2lS14KiTmOl93Qe/mDfhj032L/IxmHPHSJOLEoZqxjGOsWu+7bV9TrhGacZJb97BXADuXmE+OXBVDHjr/Q9kNK7lHAFrh6TY01IIt9v9MgitiQELSc2ROr79obXcKyKwUnILLP6DAGUrHWJE4em0KegGjqo4vYGs5Ppr1mHDaMCGM14zSNClPx9qIJA5wc+ZZpwhAnQGCm79HBrTfsGBTtRWkBOVoVe44UUDRsWLjM3uawWzv19ANktuJ0xmZ6JCOKKKjXLqYh1GJU3U3D1r+bFHVYTDW4m5tcObbWbhFgc0pkliyOANVcCtvIEb+HE3+kLuQ4qjwS96L+UvD3c5qAdQqm7lc2Z+yh1PunrxjK01shElIW7u2tLjZsBXauKGwy1TzXva8CSsVLskVO8gTBsOcTGwSLZXgq1aU7xwkUDxaHW/ZS5taGcee1a9TokHodYH/P44JnfQTMpPZhqmTxsFaFdCa2krugLfOF90WYNbilWbDCc8YHVpiua7UcrOIidTqTkJKxs6cL9k2MZtX0t8C20pV4oGouJqmFP7CTxsRYM+q1btayBej+aOZVa+R9bUltiY3So0Ak25YYcjw4PoOUsL5EEr1e5GrgdzWcGOh9W5EmbPxW3iG5wtkw4pgNwkvj1K8KlJASfHYHY+oItXYa831l+vnIjURHFYYJlWW9ksw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(36756003)(36860700001)(8936002)(6666004)(40460700003)(508600001)(54906003)(2616005)(6916009)(47076005)(1076003)(316002)(5660300002)(83380400001)(70586007)(426003)(336012)(8676002)(16526019)(186003)(70206006)(82310400004)(4326008)(26005)(86362001)(44832011)(356005)(30864003)(81166007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:42.3463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2a5ee8-2905-4da4-4a16-08d9ed337bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As smu->pm_enabled is a prerequisite for adev->pm.dpm_enabled.
So, with adev->pm.dpm_enabled set, it can be guarded that
smu->pm_enabled is also set. Thus the extra check for
"!smu->pm_enabled" is totally unnecessary.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I6ff67137d447e6a3d8cc627b397428fed22753f3
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 84 +++++++++++------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c3a5ccd100c..96a3388c2cb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -68,7 +68,7 @@ static int smu_sys_get_pp_feature_mask(void *handle,
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	return smu_get_pp_feature_mask(smu, buf);
@@ -79,7 +79,7 @@ static int smu_sys_set_pp_feature_mask(void *handle,
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	return smu_set_pp_feature_mask(smu, new_mask);
@@ -219,7 +219,7 @@ static int smu_dpm_set_power_gate(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+	if (!smu->adev->pm.dpm_enabled) {
 		dev_WARN(smu->adev->dev,
 			 "SMU uninitialized but power %s requested for %u!\n",
 			 gate ? "gate" : "ungate", block_type);
@@ -315,7 +315,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	if (!smu->adev->in_suspend)
 		return;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return;
 
 	/* Enable restore flag */
@@ -428,7 +428,7 @@ static int smu_sys_get_pp_table(void *handle,
 	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
@@ -451,7 +451,7 @@ static int smu_sys_set_pp_table(void *handle,
 	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (header->usStructureSize != size) {
@@ -1564,7 +1564,7 @@ static int smu_display_configuration_change(void *handle,
 	int index = 0;
 	int num_of_active_display = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!display_config)
@@ -1704,7 +1704,7 @@ static int smu_handle_task(struct smu_context *smu,
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	switch (task_id) {
@@ -1745,7 +1745,7 @@ static int smu_switch_power_profile(void *handle,
 	long workload;
 	uint32_t index;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
@@ -1775,7 +1775,7 @@ static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
@@ -1791,7 +1791,7 @@ static int smu_force_performance_level(void *handle,
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
@@ -1817,7 +1817,7 @@ static int smu_set_display_count(void *handle, uint32_t count)
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	return smu_init_display_count(smu, count);
@@ -1830,7 +1830,7 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
@@ -1917,7 +1917,7 @@ static int smu_set_df_cstate(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
@@ -1934,7 +1934,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
@@ -1949,7 +1949,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
 
 int smu_write_watermarks_table(struct smu_context *smu)
 {
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	return smu_set_watermarks_table(smu, NULL);
@@ -1960,7 +1960,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->disable_watermark)
@@ -1973,7 +1973,7 @@ int smu_set_ac_dc(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	/* controlled by firmware */
@@ -2083,7 +2083,7 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->set_fan_speed_rpm)
@@ -2126,7 +2126,7 @@ int smu_get_power_limit(void *handle,
 	uint32_t limit_type;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	switch(pp_power_type) {
@@ -2199,7 +2199,7 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 	uint32_t limit_type = limit >> 24;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	limit &= (1<<24)-1;
@@ -2230,7 +2230,7 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->print_clk_levels)
@@ -2319,7 +2319,7 @@ static int smu_od_edit_dpm_table(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->od_edit_dpm_table) {
@@ -2340,7 +2340,7 @@ static int smu_read_sensor(void *handle,
 	int ret = 0;
 	uint32_t *size, size_val;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!data || !size_arg)
@@ -2399,7 +2399,7 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
+	if (!smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
 	if (!buf)
@@ -2414,7 +2414,7 @@ static int smu_set_power_profile_mode(void *handle,
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
+	if (!smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
@@ -2426,7 +2426,7 @@ static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->get_fan_control_mode)
@@ -2445,7 +2445,7 @@ static int smu_set_fan_control_mode(void *handle, u32 value)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->set_fan_control_mode)
@@ -2478,7 +2478,7 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->get_fan_speed_pwm)
@@ -2497,7 +2497,7 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->set_fan_speed_pwm)
@@ -2524,7 +2524,7 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->get_fan_speed_rpm)
@@ -2542,7 +2542,7 @@ static int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	return smu_set_min_dcef_deep_sleep(smu, clk);
@@ -2556,7 +2556,7 @@ static int smu_get_clock_by_type_with_latency(void *handle,
 	enum smu_clk_type clk_type;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
@@ -2590,7 +2590,7 @@ static int smu_display_clock_voltage_request(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->display_clock_voltage_request)
@@ -2606,7 +2606,7 @@ static int smu_display_disable_memory_clock_switch(void *handle,
 	struct smu_context *smu = handle;
 	int ret = -EINVAL;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->display_disable_memory_clock_switch)
@@ -2621,7 +2621,7 @@ static int smu_set_xgmi_pstate(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->set_xgmi_pstate)
@@ -2722,7 +2722,7 @@ static int smu_get_max_sustainable_clocks_by_dc(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
@@ -2738,7 +2738,7 @@ static int smu_get_uclk_dpm_states(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->get_uclk_dpm_states)
@@ -2752,7 +2752,7 @@ static enum amd_pm_state_type smu_get_current_power_state(void *handle)
 	struct smu_context *smu = handle;
 	enum amd_pm_state_type pm_state = POWER_STATE_TYPE_DEFAULT;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->get_current_power_state)
@@ -2767,7 +2767,7 @@ static int smu_get_dpm_clock_table(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->get_dpm_clock_table)
@@ -2780,7 +2780,7 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
 	struct smu_context *smu = handle;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->get_gpu_metrics)
@@ -2794,7 +2794,7 @@ static int smu_enable_mgpu_fan_boost(void *handle)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->enable_mgpu_fan_boost)
-- 
2.29.0

