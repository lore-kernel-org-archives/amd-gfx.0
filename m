Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E6BC2BBC7
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C6C20678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1lLLMr5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C6C20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331FC6E419;
	Mon, 13 Apr 2020 08:24:47 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620396E056
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 08:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJbcCDV17TUduj2Uw4uF7jZFAxi+DDZJRAuClwrdM/zBH840TZ177nO65MV7P8ltK6izeN+LTQJFvb9FVCGBQ6MksCK34c5G1VmXRAmIsHrQWs8uROuhPErk6l0xecPk4SuPgDRvpOXeVBjHBXgGHPidGIrh5MOVSJ2ymf1bpDPK2a1JBxoJ7pVcZeu1Jkoa9DpDapWbIu5xXeYa+3S67JehxptNyxRq/yZTITPQUcvehzerMpqUfUH1cfE5wybKRsM4oWOzl3PWretgwRmM5GMqH+/YLblHrDTeFN4ApegtVR2Q4deoj4BWagwC5c8rv5zhPpq9ZFb4voUD1L9ZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90v8S/FIx5KOdaTtKb7EULvcoI4ctGJ+NgFBGxzvFOY=;
 b=JQehtAnjwiiw3pQuFwe3I6tI/w01fj32GG0xPSEh41JEYGwrj+CA6MrPlBJxyQ3GI16rAahP9NTHZzJEb3Sop6qWe6n+U9OwBHBBheaRXZaC19cl10e7Zf6aTCHBlOpXR7uqrWxXxhM6zHYD042sZtiknKKFbd2OWrT5WGEme8m/pzVN52mvwFMU/tgqLxxDXbgsHZ954WnsKBy5EjEIDmxARCabO6CIo9fUHwlQOZKqJRN8JM+h00kQCq3xE3f0om0sT+peO9PR/VDx1BaYOeMiLXHeeABavt5PGYKYS29AChUN19wTSJS/W534bMsGJJDLW1ULlJPJBGHANN2OVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90v8S/FIx5KOdaTtKb7EULvcoI4ctGJ+NgFBGxzvFOY=;
 b=1lLLMr5ikTOiHNqikuer1/OoTmp1vJFCkDjUzVtzQZP9HR/iVA8XdmT9wXAqd6rDEZKOGTbcE8IZOy4KiEndmaqYEjlsR/CaCjI2frYtOY6rLZQevp6e+TVnCfHtzR7u6KWTQMzbeE1sr5pmXvFV1If41rebl8BrWcHuxGgbvf8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3723.namprd12.prod.outlook.com (2603:10b6:5:1c8::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Mon, 13 Apr 2020 08:24:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 08:24:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: properly set the dpm_enabled state
Date: Mon, 13 Apr 2020 16:24:22 +0800
Message-Id: <20200413082422.31786-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413082422.31786-1-evan.quan@amd.com>
References: <20200413082422.31786-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Mon, 13 Apr 2020 08:24:42 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 362e7158-6a71-4d22-b11e-08d7df841e8a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3723:|DM6PR12MB3723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3723B39B6352833EFD71A4F5E4DD0@DM6PR12MB3723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(36756003)(2906002)(66946007)(52116002)(316002)(26005)(66556008)(66476007)(7696005)(478600001)(16526019)(44832011)(2616005)(956004)(8936002)(6486002)(4326008)(8676002)(1076003)(81156014)(86362001)(30864003)(6916009)(5660300002)(186003)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEjpWEUsMebC4Tg53yTMKOnJspKuDDEgT5LcSM1bmMxZcgtSnGg6Fu+HtoR9CQ0rmV98p9Hxzj1cJ/0LdF1+xoKskvhrQPJouvSj0ST14XOraqXtQHmFj2/DmSd4kOIRWDnHncgTb9utU13BPQ2ZrFVR7I92yJzvGH4DOrsQ9LvHZpjhTCStGMGDnNuOq3rVYCffWRoEkO3ucJPvW978/BuZGssxb+C+vu+NRpoS9/Z9nv8FiPJLY+HfhfPRlLhg18/qrrepw13EVnwdIYC3gVhDT2s7HiLrGgAGwQa71zxAj9nc51lXe0r5ly6YFBaGESaB60k4IpmQygTVzUlEk0yoSKpCb6PV7GCn5PhUxDBxb81ZmdAPQgkflEQgFvd6W5bJBph26H0QG0qmE2om47/pdLv7drUNZhWT3Cn5JQ1sNYFEkposSkwNxcvdZPGn
X-MS-Exchange-AntiSpam-MessageData: JHAnxpyN2UADxycIDm6IJQ9D+7tb99cS9IfSVelKG55ONvLwWpCQTcjFVJYpvtlNZgFbVf8NgwgoNBcpMT5QpUXSiqYz84muGvwc8NGh7qDfO+rZCBD1KLclXVrURR+QWugpxT8f8sUbjVkzB9sK8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362e7158-6a71-4d22-b11e-08d7df841e8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 08:24:44.6871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhfkEuiLyJFgfWzA5+T8jdZGGEb+wr/iOH4Jmg70l2aW2OjtU8tkJZpf0joJmGGU
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On the ASIC powered down(in baco or system suspend),
the dpm_enabled will be set as false. Then all access
(e.g. df state setting issued on RAS error event) to
SMU will be blocked.

Change-Id: I128c681b6f520d24d4247e438773b2b4b497d43b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 250 ++++++++++++++++---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c |  10 -
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c   |   2 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    |  20 --
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c   |   4 +-
 5 files changed, 220 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b69e8d6c0a96..561f7b77398a 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -62,6 +62,7 @@ const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask
 
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
+	struct amdgpu_device *adev = smu->adev;
 	size_t size = 0;
 	int ret = 0, i = 0;
 	uint32_t feature_mask[2] = { 0 };
@@ -70,6 +71,9 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 	uint32_t sort_feature[SMU_FEATURE_COUNT];
 	uint64_t hw_feature_count = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
@@ -110,9 +114,6 @@ static int smu_feature_update_enable_state(struct smu_context *smu,
 	uint32_t feature_low = 0, feature_high = 0;
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
 	feature_low = (feature_mask >> 0 ) & 0xffffffff;
 	feature_high = (feature_mask >> 32) & 0xffffffff;
 
@@ -155,6 +156,10 @@ int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask)
 	uint64_t feature_2_enabled = 0;
 	uint64_t feature_2_disabled = 0;
 	uint64_t feature_enables = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
 
@@ -417,8 +422,12 @@ bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type)
 int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 			   bool gate)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 		ret = smu_dpm_set_uvd_enable(smu, !gate);
@@ -569,8 +578,12 @@ bool is_support_sw_smu_xgmi(struct amdgpu_device *adev)
 int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_device *adev = smu->adev;
 	uint32_t powerplay_table_size;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
 		return -EINVAL;
 
@@ -591,11 +604,13 @@ int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_device *adev = smu->adev;
 	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret = 0;
 
-	if (!smu->pm_enabled)
+	if (!adev->pm.dpm_enabled)
 		return -EINVAL;
+
 	if (header->usStructureSize != size) {
 		pr_err("pp table size not matched !\n");
 		return -EIO;
@@ -636,8 +651,6 @@ int smu_feature_init_dpm(struct smu_context *smu)
 	int ret = 0;
 	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
 
-	if (!smu->pm_enabled)
-		return ret;
 	mutex_lock(&feature->mutex);
 	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
 	mutex_unlock(&feature->mutex);
@@ -1360,10 +1373,7 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		goto failed;
 
-	if (!smu->pm_enabled)
-		adev->pm.dpm_enabled = false;
-	else
-		adev->pm.dpm_enabled = true;	/* TODO: will set dpm_enabled flag while VCN and DAL DPM is workable */
+	adev->pm.dpm_enabled = true;
 
 	pr_info("SMU is initialized successfully!\n");
 
@@ -1397,6 +1407,8 @@ static int smu_hw_fini(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	adev->pm.dpm_enabled = false;
+
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
 	if (!amdgpu_sriov_vf(adev)){
@@ -1538,6 +1550,8 @@ static int smu_suspend(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	adev->pm.dpm_enabled = false;
+
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
 	if(!amdgpu_sriov_vf(adev)) {
@@ -1594,6 +1608,8 @@ static int smu_resume(void *handle)
 
 	smu->disable_uclk_switch = 0;
 
+	adev->pm.dpm_enabled = true;
+
 	pr_info("SMU is resumed successfully!\n");
 
 	return 0;
@@ -1605,10 +1621,14 @@ static int smu_resume(void *handle)
 int smu_display_configuration_change(struct smu_context *smu,
 				     const struct amd_pp_display_configuration *display_config)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int index = 0;
 	int num_of_active_display = 0;
 
-	if (!smu->pm_enabled || !is_support_sw_smu(smu->adev))
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
+	if (!is_support_sw_smu(smu->adev))
 		return -EINVAL;
 
 	if (!display_config)
@@ -1670,12 +1690,16 @@ int smu_get_current_clocks(struct smu_context *smu,
 			   struct amd_pp_clock_info *clocks)
 {
 	struct amd_pp_simple_clock_info simple_clocks = {0};
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_clock_info hw_clocks;
 	int ret = 0;
 
 	if (!is_support_sw_smu(smu->adev))
 		return -EINVAL;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	smu_get_dal_power_level(smu, &simple_clocks);
@@ -1738,7 +1762,7 @@ static int smu_enable_umd_pstate(void *handle,
 	struct smu_context *smu = (struct smu_context*)(handle);
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
-	if (!smu->is_apu && (!smu->pm_enabled || !smu_dpm_ctx->dpm_context))
+	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
 
 	if (!(smu_dpm_ctx->dpm_level & profile_mode_mask)) {
@@ -1780,9 +1804,6 @@ int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	long workload;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
-	if (!smu->pm_enabled)
-		return -EINVAL;
-
 	if (!skip_display_settings) {
 		ret = smu_display_config_changed(smu);
 		if (ret) {
@@ -1833,8 +1854,12 @@ int smu_handle_task(struct smu_context *smu,
 		    enum amd_pp_task task_id,
 		    bool lock_needed)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	if (lock_needed)
 		mutex_lock(&smu->mutex);
 
@@ -1868,10 +1893,11 @@ int smu_switch_power_profile(struct smu_context *smu,
 			     bool en)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;
 	long workload;
 	uint32_t index;
 
-	if (!smu->pm_enabled)
+	if (!adev->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
@@ -1902,8 +1928,12 @@ int smu_switch_power_profile(struct smu_context *smu,
 enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;
 	enum amd_dpm_forced_level level;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
 
@@ -1917,8 +1947,12 @@ enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu)
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
 
@@ -1941,8 +1975,12 @@ int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_lev
 
 int smu_set_display_count(struct smu_context *smu, uint32_t count)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 	ret = smu_init_display_count(smu, count);
 	mutex_unlock(&smu->mutex);
@@ -1956,8 +1994,12 @@ int smu_force_clk_levels(struct smu_context *smu,
 			 bool lock_needed)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
 		pr_debug("force clock level is for dpm manual mode only.\n");
 		return -EINVAL;
@@ -1975,20 +2017,19 @@ int smu_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+/*
+ * On system suspending or resetting, the dpm_enabled
+ * flag will be cleared. So that those SMU services which
+ * are not supported will be gated.
+ * However, the mp1 state setting should still be granted
+ * even if the dpm_enabled cleared.
+ */
 int smu_set_mp1_state(struct smu_context *smu,
 		      enum pp_mp1_state mp1_state)
 {
 	uint16_t msg;
 	int ret;
 
-	/*
-	 * The SMC is not fully ready. That may be
-	 * expected as the IP may be masked.
-	 * So, just return without error.
-	 */
-	if (!smu->pm_enabled)
-		return 0;
-
 	mutex_lock(&smu->mutex);
 
 	switch (mp1_state) {
@@ -2025,15 +2066,11 @@ int smu_set_mp1_state(struct smu_context *smu,
 int smu_set_df_cstate(struct smu_context *smu,
 		      enum pp_df_cstate state)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	/*
-	 * The SMC is not fully ready. That may be
-	 * expected as the IP may be masked.
-	 * So, just return without error.
-	 */
-	if (!smu->pm_enabled)
-		return 0;
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
 
 	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
 		return 0;
@@ -2067,6 +2104,10 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
 	void *table = smu->smu_table.watermarks_table;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
 
 	if (!table)
 		return -EINVAL;
@@ -2091,8 +2132,12 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 
 int smu_set_ac_dc(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	/* controlled by firmware */
 	if (smu->dc_controlled_by_gpio)
 		return 0;
@@ -2151,8 +2196,12 @@ const struct amdgpu_ip_block_version smu_v12_0_ip_block =
 
 int smu_load_microcode(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->load_microcode)
@@ -2165,8 +2214,12 @@ int smu_load_microcode(struct smu_context *smu)
 
 int smu_check_fw_status(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->check_fw_status)
@@ -2179,8 +2232,12 @@ int smu_check_fw_status(struct smu_context *smu)
 
 int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_gfx_cgpg)
@@ -2193,8 +2250,12 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 
 int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_fan_speed_rpm)
@@ -2210,10 +2271,15 @@ int smu_get_power_limit(struct smu_context *smu,
 			bool def,
 			bool lock_needed)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (lock_needed)
+	if (lock_needed) {
+		if (!adev->pm.dpm_enabled)
+			return -EINVAL;
+
 		mutex_lock(&smu->mutex);
+	}
 
 	if (smu->ppt_funcs->get_power_limit)
 		ret = smu->ppt_funcs->get_power_limit(smu, limit, def);
@@ -2226,8 +2292,12 @@ int smu_get_power_limit(struct smu_context *smu,
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_power_limit)
@@ -2240,8 +2310,12 @@ int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->print_clk_levels)
@@ -2254,8 +2328,12 @@ int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, ch
 
 int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type type)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_od_percentage)
@@ -2268,8 +2346,12 @@ int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type type)
 
 int smu_set_od_percentage(struct smu_context *smu, enum smu_clk_type type, uint32_t value)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_od_percentage)
@@ -2284,8 +2366,12 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->od_edit_dpm_table)
@@ -2300,8 +2386,12 @@ int smu_read_sensor(struct smu_context *smu,
 		    enum amd_pp_sensors sensor,
 		    void *data, uint32_t *size)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->read_sensor)
@@ -2314,8 +2404,12 @@ int smu_read_sensor(struct smu_context *smu,
 
 int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_power_profile_mode)
@@ -2331,8 +2425,12 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 			       uint32_t param_size,
 			       bool lock_needed)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	if (lock_needed)
 		mutex_lock(&smu->mutex);
 
@@ -2348,8 +2446,12 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 
 int smu_get_fan_control_mode(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_fan_control_mode)
@@ -2362,8 +2464,12 @@ int smu_get_fan_control_mode(struct smu_context *smu)
 
 int smu_set_fan_control_mode(struct smu_context *smu, int value)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_fan_control_mode)
@@ -2376,8 +2482,12 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_fan_speed_percent)
@@ -2390,8 +2500,12 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 
 int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_fan_speed_percent)
@@ -2404,8 +2518,12 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 
 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_fan_speed_rpm)
@@ -2418,8 +2536,12 @@ int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_deep_sleep_dcefclk)
@@ -2432,8 +2554,12 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 
 int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	if (smu->ppt_funcs->set_active_display_count)
 		ret = smu->ppt_funcs->set_active_display_count(smu, count);
 
@@ -2444,8 +2570,12 @@ int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
 			  struct amd_pp_clocks *clocks)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_clock_by_type)
@@ -2459,8 +2589,12 @@ int smu_get_clock_by_type(struct smu_context *smu,
 int smu_get_max_high_clocks(struct smu_context *smu,
 			    struct amd_pp_simple_clock_info *clocks)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_max_high_clocks)
@@ -2475,8 +2609,12 @@ int smu_get_clock_by_type_with_latency(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       struct pp_clock_levels_with_latency *clocks)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_clock_by_type_with_latency)
@@ -2491,8 +2629,12 @@ int smu_get_clock_by_type_with_voltage(struct smu_context *smu,
 				       enum amd_pp_clock_type type,
 				       struct pp_clock_levels_with_voltage *clocks)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_clock_by_type_with_voltage)
@@ -2507,8 +2649,12 @@ int smu_get_clock_by_type_with_voltage(struct smu_context *smu,
 int smu_display_clock_voltage_request(struct smu_context *smu,
 				      struct pp_display_clock_request *clock_req)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->display_clock_voltage_request)
@@ -2522,8 +2668,12 @@ int smu_display_clock_voltage_request(struct smu_context *smu,
 
 int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disable_memory_clock_switch)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = -EINVAL;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->display_disable_memory_clock_switch)
@@ -2536,8 +2686,12 @@ int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disabl
 
 int smu_notify_smu_enable_pwe(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->notify_smu_enable_pwe)
@@ -2551,8 +2705,12 @@ int smu_notify_smu_enable_pwe(struct smu_context *smu)
 int smu_set_xgmi_pstate(struct smu_context *smu,
 			uint32_t pstate)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_xgmi_pstate)
@@ -2565,8 +2723,12 @@ int smu_set_xgmi_pstate(struct smu_context *smu,
 
 int smu_set_azalia_d3_pme(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_azalia_d3_pme)
@@ -2577,6 +2739,14 @@ int smu_set_azalia_d3_pme(struct smu_context *smu)
 	return ret;
 }
 
+/*
+ * On system suspending or resetting, the dpm_enabled
+ * flag will be cleared. So that those SMU services which
+ * are not supported will be gated.
+ *
+ * However, the baco/mode1 reset should still be granted
+ * as they are still supported and necessary.
+ */
 bool smu_baco_is_support(struct smu_context *smu)
 {
 	bool ret = false;
@@ -2648,8 +2818,12 @@ int smu_mode2_reset(struct smu_context *smu)
 int smu_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					 struct pp_smu_nv_clock_table *max_clocks)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
@@ -2664,8 +2838,12 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 			    unsigned int *clock_values_in_khz,
 			    unsigned int *num_states)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_uclk_dpm_states)
@@ -2679,6 +2857,10 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu)
 {
 	enum amd_pm_state_type pm_state = POWER_STATE_TYPE_DEFAULT;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
 
@@ -2693,8 +2875,12 @@ enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu)
 int smu_get_dpm_clock_table(struct smu_context *smu,
 			    struct dpm_clocks *clock_table)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (!adev->pm.dpm_enabled)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->get_dpm_clock_table)
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1ef0923f7190..1c66b7d7139c 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2226,12 +2226,8 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
 static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct smu_context *smu = &adev->smu;
 	int res;
 
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
@@ -2247,12 +2243,6 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 
 static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct smu_context *smu = &adev->smu;
-
-	if (!smu->pm_enabled)
-		return;
-
 	i2c_del_adapter(control);
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 95eb44515e36..d9e1365eeafe 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -847,7 +847,7 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
 
-	if (!smu->pm_enabled || !buf)
+	if (!buf)
 		return -EINVAL;
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 655ba4fb05dc..751b5c5a9787 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -479,8 +479,6 @@ int smu_v11_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu->pm_enabled)
-		return 0;
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
@@ -497,8 +495,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu->pm_enabled)
-		return 0;
 	if (!smu_power->power_context || smu_power->power_context_size == 0)
 		return -EINVAL;
 
@@ -783,8 +779,6 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
 
-	if (!smu->pm_enabled)
-		return 0;
 	if (!table_context)
 		return -EINVAL;
 
@@ -835,9 +829,6 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
 	return ret;
 }
@@ -932,8 +923,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return ret;
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
@@ -948,9 +937,6 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 	int ret = 0;
 	int clk_id;
 
-	if (!smu->pm_enabled)
-		return ret;
-
 	if ((smu_msg_get_index(smu, SMU_MSG_GetDcModeMaxDpmFreq) < 0) ||
 	    (smu_msg_get_index(smu, SMU_MSG_GetMaxDpmFreq) < 0))
 		return 0;
@@ -1205,9 +1191,6 @@ int smu_v11_0_start_thermal_control(struct smu_context *smu)
 	struct smu_temperature_range range;
 	struct amdgpu_device *adev = smu->adev;
 
-	if (!smu->pm_enabled)
-		return ret;
-
 	memcpy(&range, &smu11_thermal_policy[0], sizeof(struct smu_temperature_range));
 
 	ret = smu_get_thermal_temperature_range(smu, &range);
@@ -1321,9 +1304,6 @@ smu_v11_0_display_clock_voltage_request(struct smu_context *smu,
 	enum smu_clk_type clk_select = 0;
 	uint32_t clk_freq = clock_req->clock_freq_in_khz / 1000;
 
-	if (!smu->pm_enabled)
-		return -EINVAL;
-
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) ||
 		smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		switch (clk_type) {
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 3f1044326dcb..61923530b2e4 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1796,7 +1796,7 @@ static int vega20_get_power_profile_mode(struct smu_context *smu, char *buf)
 			"PD_Data_error_rate_coeff"};
 	int result = 0;
 
-	if (!smu->pm_enabled || !buf)
+	if (!buf)
 		return -EINVAL;
 
 	size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
@@ -1887,8 +1887,6 @@ static int vega20_set_power_profile_mode(struct smu_context *smu, long *input, u
 
 	smu->power_profile_mode = input[size];
 
-	if (!smu->pm_enabled)
-		return ret;
 	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		pr_err("Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
