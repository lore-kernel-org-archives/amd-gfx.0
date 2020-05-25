Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FCAC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 06:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E81B2075F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 06:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3fVXDeKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E81B2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046BB896C7;
	Mon, 25 May 2020 06:38:16 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C11896C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 06:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK4Q9oAmIpIwACbIrf2ktuxO5zdicP7yo1wKqVccNSykG4RxEIY9ftpFbaRt2ncnR6Eo7WTJn5biSjL7NMOeJK/fu+oWod/Br7Te/rcDC/YGUyLX9Mk3Sn9GneHEel5moCqtgqIllUXAu0t8aV41NIR+49/+lI+kOzFbtCTBZwa1X87ArVpWTZnqace0rXZcZRRwxJjMO/duG9QJzJTpEDijDjDE7pfD3fRETGsrW4Tq1+40MhSWNW+fmz+fFmqj06QRFoAaaHWPT9gBk/OCVRdXTorM0zarBkefOtC50nK1QH14JaZfrpg6SiMY5b6wlcYYpddWeXaaRqm3U0gw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMXU8g2MGeNiInNtDaSCHJKHlW8Arubxq9laSMMhV3M=;
 b=g0lGYgHBzvt+tEoqu4m+2hDUhBo2psl1RIwH/c589NOLNYFJSHEtKRMP85FwoKagx7rnqi7cEj4lFXIZJAKy62jImxpoD95qyocM2ULL11diBw1f6Ouz9TpMX1XAeVThZhP4nNGlXZaacwVF2YNNrA4X+FVWOcwK/1/4flxAvonITNQ+IO1YQxK3XEEBfijvHnFU6n8/yP/V4mb8/93/4dzbrsVwFCcWh8gapnyobh9ggoB6U0SYDRcOna4HAlxm+caPZpFmS9ITf+lo5ocCPNPoYN71zSpNtTFxiyqxL9gClcBFxUl1Zi6Fm8cZAv+XaO1znkRMWz0MBsJNPuanwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMXU8g2MGeNiInNtDaSCHJKHlW8Arubxq9laSMMhV3M=;
 b=3fVXDeKlzBRuCZ56MrnOL5bQuYsb+6Tgv4pR94Y5JhU1MwqQtNJJz10Lz3eyNFK8A/PlpLrNYMDKrEdKGvBBKAwJt50eeUcgQd+4PlPFijqsPDFBJCidrtHm5zEmvgXvC4BRNnNzNc3Um+QMgwjzL/h7WGZwCBsditH3WXrqNKc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3723.namprd12.prod.outlook.com (2603:10b6:5:1c8::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.26; Mon, 25 May 2020 06:38:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 06:38:12 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: check whether SMU IP is enabled before
 access
Date: Mon, 25 May 2020 14:37:51 +0800
Message-Id: <20200525063751.19222-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0059.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 06:38:10 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ea7c37a-8f22-4d03-4af3-08d8007631d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3723C12A014A55681BD1CEDAE4B30@DM6PR12MB3723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0CXKnIQaVniGLlGaQIqAoo4vUrFgOkoA6j77CPsYaJgfq4SN2cHGPf5nRRdsXh6q3vJI0BS/dcYxk0dhrgJixd1kNyqYuTtdPyHOLp22IrmshWwJHXb4uIX7WOIhbx5LKlgUEj3p75jewYOOE5xZEboPaG+ZLnUMZ8J6ddoWsk5nbFygAtjyVIw2KziP0gw9uIDcmp57AIqlIgAaxqGNFWo5+TzVU9fl7F2P9SVBEDYSleECUqvwcgN0lOhkF7q5gailSp0gVJJ0V7En2vBpFMhXqTTGGE3nz7fhLTZb8S288cOKjghvvhJlhyCtTdd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(2616005)(956004)(44832011)(6916009)(52116002)(7696005)(478600001)(86362001)(186003)(16526019)(26005)(36756003)(8936002)(66556008)(66946007)(66476007)(8676002)(5660300002)(6486002)(2906002)(30864003)(6666004)(1076003)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kjbjIiM8gKzgkbhE/0bWKTzbz/XWb4fAoX22GRn6GxXVg7ft1GOw47T9Oqo+o1+xG+DP+PnWe/6B+0wog08x3dg1JJ3tJ0XSjIPGTfvDZUhlbOXnk4Ga3iUIZ3ZaVoQ58+iQtWso2aaDIw5DYn5madbyOPxWE5xH22DLoJ6KrYPsqqMe9pk7MdWH+/LrAMwEzenU9i77HoxRcTpGzWwyDadqrNQKWKABhJTagiDiF8WVs1B3EBcsXY5n7QArUEeIm2/1uQjDx7waIkZCGSWrgElN2S4eIEFAiwXEDJICaZT3FEGUPstIzjMjCIRPde7UvrbRA2listQCCrLU7ddt06iWtihLx+lx+zqTqlDUYZ0WOozFKGl3r0j/3ZDAXar/RyjvUt+YOIsumoT9QfoFE3M8Kyo9stBYPoErqiQu9l5B0z489BvsrJRAOHqXjmPymRj8TfA+r8B+QzCCXcg9lS0PzUzIdkC4HBc74LXIHkaorouXXUn3DEwkrkcZKCtZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea7c37a-8f22-4d03-4af3-08d8007631d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 06:38:11.9144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/oCsoFyw5ezp4bVEnRFYXuOUxTb/qi0QW3RCg7/9ifOxe1I/UGSGorLmn7qQfgU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
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
Cc: alexander.deucher@amd.com, Yong.Zhao@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since on early phase of bringup, the SMU IP may be not enabled or
supported. Without this, we may hit null pointer dereference on
accessing smu->adev.

Change-Id: I644175e926cd4fef8259f89002d6f8eda04fe42c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 266 +++++++++------------
 1 file changed, 113 insertions(+), 153 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index a78a1f542ea9..f7428996cc74 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -61,7 +61,6 @@ const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask
 
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
-	struct amdgpu_device *adev = smu->adev;
 	size_t size = 0;
 	int ret = 0, i = 0;
 	uint32_t feature_mask[2] = { 0 };
@@ -70,8 +69,8 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 	uint32_t sort_feature[SMU_FEATURE_COUNT];
 	uint64_t hw_feature_count = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -155,10 +154,9 @@ int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask)
 	uint64_t feature_2_enabled = 0;
 	uint64_t feature_2_disabled = 0;
 	uint64_t feature_enables = 0;
-	struct amdgpu_device *adev = smu->adev;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -436,11 +434,10 @@ bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type)
 int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 			   bool gate)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
@@ -577,11 +574,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct amdgpu_device *adev = smu->adev;
 	uint32_t powerplay_table_size;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
 		return -EINVAL;
@@ -603,12 +599,11 @@ int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct amdgpu_device *adev = smu->adev;
 	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (header->usStructureSize != size) {
 		pr_err("pp table size not matched !\n");
@@ -1622,15 +1617,11 @@ static int smu_resume(void *handle)
 int smu_display_configuration_change(struct smu_context *smu,
 				     const struct amd_pp_display_configuration *display_config)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int index = 0;
 	int num_of_active_display = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
-
-	if (!is_support_sw_smu(smu->adev))
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!display_config)
 		return -EINVAL;
@@ -1691,15 +1682,11 @@ int smu_get_current_clocks(struct smu_context *smu,
 			   struct amd_pp_clock_info *clocks)
 {
 	struct amd_pp_simple_clock_info simple_clocks = {0};
-	struct amdgpu_device *adev = smu->adev;
 	struct smu_clock_info hw_clocks;
 	int ret = 0;
 
-	if (!is_support_sw_smu(smu->adev))
-		return -EINVAL;
-
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -1855,11 +1842,10 @@ int smu_handle_task(struct smu_context *smu,
 		    enum amd_pp_task task_id,
 		    bool lock_needed)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (lock_needed)
 		mutex_lock(&smu->mutex);
@@ -1894,12 +1880,11 @@ int smu_switch_power_profile(struct smu_context *smu,
 			     bool en)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	struct amdgpu_device *adev = smu->adev;
 	long workload;
 	uint32_t index;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
@@ -1929,11 +1914,10 @@ int smu_switch_power_profile(struct smu_context *smu,
 enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	struct amdgpu_device *adev = smu->adev;
 	enum amd_dpm_forced_level level;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
@@ -1948,11 +1932,10 @@ enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu)
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
@@ -1976,11 +1959,10 @@ int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_lev
 
 int smu_set_display_count(struct smu_context *smu, uint32_t count)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 	ret = smu_init_display_count(smu, count);
@@ -1995,11 +1977,10 @@ int smu_force_clk_levels(struct smu_context *smu,
 			 bool lock_needed)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
 		pr_debug("force clock level is for dpm manual mode only.\n");
@@ -2031,6 +2012,9 @@ int smu_set_mp1_state(struct smu_context *smu,
 	uint16_t msg;
 	int ret;
 
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
 	switch (mp1_state) {
@@ -2067,11 +2051,10 @@ int smu_set_mp1_state(struct smu_context *smu,
 int smu_set_df_cstate(struct smu_context *smu,
 		      enum pp_df_cstate state)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
 		return 0;
@@ -2089,11 +2072,10 @@ int smu_set_df_cstate(struct smu_context *smu,
 
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
 		return 0;
@@ -2127,10 +2109,9 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
 	void *table = smu->smu_table.watermarks_table;
-	struct amdgpu_device *adev = smu->adev;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (!table)
 		return -EINVAL;
@@ -2155,11 +2136,10 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 
 int smu_set_ac_dc(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	/* controlled by firmware */
 	if (smu->dc_controlled_by_gpio)
@@ -2219,11 +2199,10 @@ const struct amdgpu_ip_block_version smu_v12_0_ip_block =
 
 int smu_load_microcode(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2237,11 +2216,10 @@ int smu_load_microcode(struct smu_context *smu)
 
 int smu_check_fw_status(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2269,11 +2247,10 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 
 int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2290,12 +2267,11 @@ int smu_get_power_limit(struct smu_context *smu,
 			bool def,
 			bool lock_needed)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (lock_needed) {
-		if (!adev->pm.dpm_enabled)
-			return -EINVAL;
+		if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+			return -EOPNOTSUPP;
 
 		mutex_lock(&smu->mutex);
 	}
@@ -2311,11 +2287,10 @@ int smu_get_power_limit(struct smu_context *smu,
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2329,11 +2304,10 @@ int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2347,11 +2321,10 @@ int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, ch
 
 int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type type)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2365,11 +2338,10 @@ int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type type)
 
 int smu_set_od_percentage(struct smu_context *smu, enum smu_clk_type type, uint32_t value)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2385,11 +2357,10 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2405,11 +2376,10 @@ int smu_read_sensor(struct smu_context *smu,
 		    enum amd_pp_sensors sensor,
 		    void *data, uint32_t *size)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2423,11 +2393,10 @@ int smu_read_sensor(struct smu_context *smu,
 
 int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2444,11 +2413,10 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 			       uint32_t param_size,
 			       bool lock_needed)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (lock_needed)
 		mutex_lock(&smu->mutex);
@@ -2465,11 +2433,10 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 
 int smu_get_fan_control_mode(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2483,11 +2450,10 @@ int smu_get_fan_control_mode(struct smu_context *smu)
 
 int smu_set_fan_control_mode(struct smu_context *smu, int value)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2501,11 +2467,10 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2519,11 +2484,10 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 
 int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2537,11 +2501,10 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 
 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2555,11 +2518,10 @@ int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2573,11 +2535,10 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 
 int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	if (smu->ppt_funcs->set_active_display_count)
 		ret = smu->ppt_funcs->set_active_display_count(smu, count);
@@ -2589,11 +2550,10 @@ int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
 			  struct amd_pp_clocks *clocks)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2608,11 +2568,10 @@ int smu_get_clock_by_type(struct smu_context *smu,
 int smu_get_max_high_clocks(struct smu_context *smu,
 			    struct amd_pp_simple_clock_info *clocks)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2628,11 +2587,10 @@ int smu_get_clock_by_type_with_latency(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       struct pp_clock_levels_with_latency *clocks)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2648,11 +2606,10 @@ int smu_get_clock_by_type_with_voltage(struct smu_context *smu,
 				       enum amd_pp_clock_type type,
 				       struct pp_clock_levels_with_voltage *clocks)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2668,11 +2625,10 @@ int smu_get_clock_by_type_with_voltage(struct smu_context *smu,
 int smu_display_clock_voltage_request(struct smu_context *smu,
 				      struct pp_display_clock_request *clock_req)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2687,11 +2643,10 @@ int smu_display_clock_voltage_request(struct smu_context *smu,
 
 int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disable_memory_clock_switch)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = -EINVAL;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2705,11 +2660,10 @@ int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disabl
 
 int smu_notify_smu_enable_pwe(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2724,11 +2678,10 @@ int smu_notify_smu_enable_pwe(struct smu_context *smu)
 int smu_set_xgmi_pstate(struct smu_context *smu,
 			uint32_t pstate)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2742,11 +2695,10 @@ int smu_set_xgmi_pstate(struct smu_context *smu,
 
 int smu_set_azalia_d3_pme(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2770,6 +2722,9 @@ bool smu_baco_is_support(struct smu_context *smu)
 {
 	bool ret = false;
 
+	if (!smu->pm_enabled)
+		return false;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
@@ -2796,6 +2751,9 @@ int smu_baco_enter(struct smu_context *smu)
 {
 	int ret = 0;
 
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->baco_enter)
@@ -2810,6 +2768,9 @@ int smu_baco_exit(struct smu_context *smu)
 {
 	int ret = 0;
 
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->baco_exit)
@@ -2824,6 +2785,9 @@ int smu_mode2_reset(struct smu_context *smu)
 {
 	int ret = 0;
 
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->mode2_reset)
@@ -2837,11 +2801,10 @@ int smu_mode2_reset(struct smu_context *smu)
 int smu_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					 struct pp_smu_nv_clock_table *max_clocks)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2857,11 +2820,10 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 			    unsigned int *clock_values_in_khz,
 			    unsigned int *num_states)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2876,10 +2838,9 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu)
 {
 	enum amd_pm_state_type pm_state = POWER_STATE_TYPE_DEFAULT;
-	struct amdgpu_device *adev = smu->adev;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2894,11 +2855,10 @@ enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu)
 int smu_get_dpm_clock_table(struct smu_context *smu,
 			    struct dpm_clocks *clock_table)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!adev->pm.dpm_enabled)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
