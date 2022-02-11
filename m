Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65508C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011D510EA0D;
	Fri, 11 Feb 2022 07:53:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4EF10EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FulEG188uws9WFaNMKXQazafeTF4nMZ6CWLR/cnb2AVeAI1lssmDyb0vNkW3/EsFEMhxEuwoR/lX857yZhyo9h7BGuyhzVTZTkdYd6zHDwh7vD08u93pMt+DatJErDWinl5vUFN0WEDLwcRTOr9GBf913HDWyTO3qgRyLGghOXz85yMmV09HwAIlznZmGhPsK60AqY3B2KaPIfWvmVowi7tQaVQ5epqgWwJGttHyV0nvM69wrgCC2+pW1VMFspbiSdOqs+MPWRDVhQatIkhsJLNnHAzggHb5egL56E/cL+YO9JzVe6TQma4cLXBGDYImDLxBx3Oo08VTt/R9BlccCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W5ZF1DFZtXY8XKkcxGVDwHY/qStLrgo44TJYNEn5Rc=;
 b=YYYoY/R+T0zS4D2BglhspL1fY/SVVPsCYzaLiRW3awAneU+825IG7dR/zOHAuGc6GdfjzYpvWNaSbk25RsVMGEuZriF3pBLeivhaP/FKMGzi68HtE/QCxSsqj/d2oJv9CIL1qH7SNW7GhxxTocHOR059FwysHOGOXy/O79qBVFpkmQDLt78iLek4a+OJUnpkkCMSHWUUUKEz4w3uWPhC0lc0zd/v0Yrmf3SJA1tJAd++QRUkCmOKd9HfIZsVWuzMINRS5KlN1tXDyFtCuqBZxbrCaD6w7iYsWHPe2vNGYYya9ae5R/lfLKXpK2V3K99lekQz2e5rhcchuehbcMJ3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W5ZF1DFZtXY8XKkcxGVDwHY/qStLrgo44TJYNEn5Rc=;
 b=XE2W+QmvOsy2NriLoE/Kx3gnoLqrFRpTeGB+oYpfdU5YzNGUAPrquP6VOYxn/K2c8HJzQgh+Oc9xGNtjx8qycZ8QiQHXGIXgw+WOe/04hTJB8ppg/UuL1yfb2/gm1sYiF4h/ylP+54cf3+V1fnOavFmwrmSVAcjN+3qKOQOOiA4=
Received: from DM5PR07CA0133.namprd07.prod.outlook.com (2603:10b6:3:13e::23)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 07:53:01 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::d8) by DM5PR07CA0133.outlook.office365.com
 (2603:10b6:3:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 07:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:53:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:57 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/pm: drop extra non-necessary null pointers
 checks
Date: Fri, 11 Feb 2022 15:52:08 +0800
Message-ID: <20220211075209.894833-11-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dfb638fc-5fe4-4d92-9284-08d9ed338690
X-MS-TrafficTypeDiagnostic: MN0PR12MB5834:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58345059BA8E2CA6DB97821CE4309@MN0PR12MB5834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfIXshBhNzbv/TkzmV9XptWS0EBwZmaweTq5MEBppGqkK5NsDtVRyYX3MJPq4K8kf5cRSPOgQT1TPyqn7BePYDsuIGilCZZ7FCsTe5dZ0hh+AVcGZCO7qOta2OMhBb8DddcgKlYFiP5i/MUx5P8iSbIjBsEMbB7AZDxpq6kyXk1P/XB9sXizOUPDDuIl0BzcOJka/60DQbqNcg6siuRiDaOg/SiYYXTTKSW9IeLLu9apJ2n4mt0QO5dQqRvZS4eJwvW1rx+vcsYGH9ta9bVk2OVv5D3W6g+7eeji4b8iJfxRSZq9ZZ7gI0Hek4+uoIKojCbJa0elyFwYUAKuGCL5eCfQA+z1qalCveVFDpcUYRZoHgNRpaXLO+yWPUI5yeMCddisM2IZgM3AUnXnvs0KeaxLvUTy/R2eyhf28k9QD7oCiKiKZRCvtCrkILN9ZqMz3n0Q3+z6tJ7UdEKfPlMPsJvY34mo2R/IlI/OMdPmyseoTYzRr+BYxv5kmntWiA9O0ZpdlWruKKMU58ZX4G5kY0J6XWo+4Elyt4WY76XEGubbt7daFHr7FJo2F/moxJ7nj4rvdh2kCACqj7aojDft7i3qvJRlcmM1fGdftZ9VzVKDr+IPG13WeEHHsDN5q5zu6dJImZB0Q9ZIPbIeVzXoYRy/OTDrScEttFVVNlbbe09EOPhBuFSbNh0ciYUECEk1rYt7agtYSffpyEuxV/rQEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(8676002)(36756003)(4326008)(83380400001)(86362001)(7696005)(54906003)(2906002)(16526019)(5660300002)(2616005)(426003)(186003)(26005)(1076003)(336012)(81166007)(6916009)(47076005)(36860700001)(30864003)(40460700003)(316002)(356005)(8936002)(70586007)(70206006)(82310400004)(44832011)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:53:00.5278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb638fc-5fe4-4d92-9284-08d9ed338690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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

They are totally redundant. The checks before them can guard
they cannot be NULL.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9f31734f49a8093582fc321ef3d93233946006e3
---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 182 ++----------------
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  42 ----
 .../gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c    |  17 +-
 .../amd/pm/powerplay/hwmgr/processpptables.c  |   2 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/smumgr.c  |   6 +-
 5 files changed, 22 insertions(+), 227 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index e95893556147..81ec5464b679 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -40,9 +40,6 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 {
 	struct pp_hwmgr *hwmgr;
 
-	if (adev == NULL)
-		return -EINVAL;
-
 	hwmgr = kzalloc(sizeof(struct pp_hwmgr), GFP_KERNEL);
 	if (hwmgr == NULL)
 		return -ENOMEM;
@@ -281,7 +278,7 @@ static int pp_dpm_load_fw(void *handle)
 	if (!hwmgr->pm_en)
 		return -EOPNOTSUPP;
 
-	if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->start_smu)
+	if (!hwmgr->smumgr_funcs->start_smu)
 		return -EINVAL;
 
 	if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
@@ -301,9 +298,6 @@ static int pp_set_clockgating_by_smu(void *handle, uint32_t msg_id)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->update_clock_gatings == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -341,9 +335,6 @@ static int pp_dpm_force_performance_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (level == hwmgr->dpm_level)
 		return 0;
 
@@ -359,9 +350,6 @@ static enum amd_dpm_forced_level pp_dpm_get_performance_level(
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	return hwmgr->dpm_level;
 }
 
@@ -369,9 +357,6 @@ static uint32_t pp_dpm_get_sclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return 0;
-
 	if (hwmgr->hwmgr_func->get_sclk == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -383,9 +368,6 @@ static uint32_t pp_dpm_get_mclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return 0;
-
 	if (hwmgr->hwmgr_func->get_mclk == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -397,9 +379,6 @@ static void pp_dpm_powergate_vce(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return;
-
 	if (hwmgr->hwmgr_func->powergate_vce == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
@@ -411,9 +390,6 @@ static void pp_dpm_powergate_uvd(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return;
-
 	if (hwmgr->hwmgr_func->powergate_uvd == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
@@ -426,9 +402,6 @@ static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	return hwmgr_handle_task(hwmgr, task_id, user_state);
 }
 
@@ -438,7 +411,7 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
 	struct pp_power_state *state;
 	enum amd_pm_state_type pm_type;
 
-	if (!hwmgr || !hwmgr->current_ps)
+	if (!hwmgr->current_ps)
 		return -EINVAL;
 
 	state = hwmgr->current_ps;
@@ -468,9 +441,6 @@ static int pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EOPNOTSUPP;
-
 	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
 		return -EOPNOTSUPP;
 
@@ -486,9 +456,6 @@ static int pp_dpm_get_fan_control_mode(void *handle, uint32_t *fan_mode)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EOPNOTSUPP;
-
 	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
 		return -EOPNOTSUPP;
 
@@ -503,9 +470,6 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EOPNOTSUPP;
-
 	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
 		return -EOPNOTSUPP;
 
@@ -519,9 +483,6 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EOPNOTSUPP;
-
 	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
 		return -EOPNOTSUPP;
 
@@ -535,9 +496,6 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EOPNOTSUPP;
-
 	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
 		return -EOPNOTSUPP;
 
@@ -551,9 +509,6 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EOPNOTSUPP;
-
 	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
 		return -EOPNOTSUPP;
 
@@ -571,7 +526,7 @@ static int pp_dpm_get_pp_num_states(void *handle,
 
 	memset(data, 0, sizeof(*data));
 
-	if (!hwmgr || !hwmgr->ps)
+	if (!hwmgr->ps)
 		return -EINVAL;
 
 	data->nums = hwmgr->num_ps;
@@ -603,7 +558,7 @@ static int pp_dpm_get_pp_table(void *handle, char **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->soft_pp_table)
+	if (!hwmgr->soft_pp_table)
 		return -EINVAL;
 
 	*table = (char *)hwmgr->soft_pp_table;
@@ -631,9 +586,6 @@ static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size)
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = -ENOMEM;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (!hwmgr->hardcode_pp_table) {
 		hwmgr->hardcode_pp_table = kmemdup(hwmgr->soft_pp_table,
 						   hwmgr->soft_pp_table_size,
@@ -661,9 +613,6 @@ static int pp_dpm_force_clock_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->force_clock_level == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -682,9 +631,6 @@ static int pp_dpm_print_clock_levels(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->print_clock_levels == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -696,9 +642,6 @@ static int pp_dpm_get_sclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->get_sclk_od == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -710,9 +653,6 @@ static int pp_dpm_set_sclk_od(void *handle, uint32_t value)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_sclk_od == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -725,9 +665,6 @@ static int pp_dpm_get_mclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->get_mclk_od == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -739,9 +676,6 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t value)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_mclk_od == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -754,7 +688,7 @@ static int pp_dpm_read_sensor(void *handle, int idx,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !value)
+	if (!value)
 		return -EINVAL;
 
 	switch (idx) {
@@ -780,9 +714,6 @@ pp_dpm_get_vce_clock_state(void *handle, unsigned idx)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return NULL;
-
 	if (idx < hwmgr->num_vce_state_tables)
 		return &hwmgr->vce_states[idx];
 	return NULL;
@@ -792,7 +723,7 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->hwmgr_func->get_power_profile_mode)
+	if (!hwmgr->hwmgr_func->get_power_profile_mode)
 		return -EOPNOTSUPP;
 	if (!buf)
 		return -EINVAL;
@@ -804,7 +735,7 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->hwmgr_func->set_power_profile_mode)
+	if (!hwmgr->hwmgr_func->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
@@ -819,9 +750,6 @@ static int pp_set_fine_grain_clk_vol(void *handle, uint32_t type, long *input, u
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_fine_grain_clk_vol == NULL)
 		return 0;
 
@@ -832,9 +760,6 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *input, uint3
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->odn_edit_dpm_table == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -847,9 +772,6 @@ static int pp_dpm_set_mp1_state(void *handle, enum pp_mp1_state mp1_state)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_mp1_state)
 		return hwmgr->hwmgr_func->set_mp1_state(hwmgr, mp1_state);
 
@@ -863,9 +785,6 @@ static int pp_dpm_switch_power_profile(void *handle,
 	long workload;
 	uint32_t index;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -903,9 +822,6 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 	struct pp_hwmgr *hwmgr = handle;
 	uint32_t max_power_limit;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_power_limit == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -935,7 +851,7 @@ static int pp_get_power_limit(void *handle, uint32_t *limit,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr || !limit)
+	if (!limit)
 		return -EINVAL;
 
 	if (power_type != PP_PWR_TYPE_SUSTAINED)
@@ -968,9 +884,6 @@ static int pp_display_configuration_change(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	phm_store_dal_configuration_data(hwmgr, display_config);
 	return 0;
 }
@@ -980,7 +893,7 @@ static int pp_get_display_power_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !output)
+	if (!output)
 		return -EINVAL;
 
 	return phm_get_dal_power_level(hwmgr, output);
@@ -994,9 +907,6 @@ static int pp_get_current_clocks(void *handle,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	phm_get_dal_power_level(hwmgr, &simple_clocks);
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
@@ -1038,9 +948,6 @@ static int pp_get_clock_by_type(void *handle, enum amd_pp_clock_type type, struc
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (clocks == NULL)
 		return -EINVAL;
 
@@ -1053,7 +960,7 @@ static int pp_get_clock_by_type_with_latency(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !clocks)
+	if (!clocks)
 		return -EINVAL;
 
 	return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
@@ -1065,7 +972,7 @@ static int pp_get_clock_by_type_with_voltage(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !clocks)
+	if (!clocks)
 		return -EINVAL;
 
 	return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
@@ -1076,7 +983,7 @@ static int pp_set_watermarks_for_clocks_ranges(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !clock_ranges)
+	if (!clock_ranges)
 		return -EINVAL;
 
 	return phm_set_watermarks_for_clocks_ranges(hwmgr,
@@ -1088,7 +995,7 @@ static int pp_display_clock_voltage_request(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !clock)
+	if (!clock)
 		return -EINVAL;
 
 	return phm_display_clock_voltage_request(hwmgr, clock);
@@ -1100,7 +1007,7 @@ static int pp_get_display_mode_validation_clocks(void *handle,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr || !clocks)
+	if (!clocks)
 		return -EINVAL;
 
 	clocks->level = PP_DAL_POWERLEVEL_7;
@@ -1115,9 +1022,6 @@ static int pp_dpm_powergate_mmhub(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->powergate_mmhub == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -1130,9 +1034,6 @@ static int pp_dpm_powergate_gfx(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return 0;
-
 	if (hwmgr->hwmgr_func->powergate_gfx == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
@@ -1145,9 +1046,6 @@ static void pp_dpm_powergate_acp(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return;
-
 	if (hwmgr->hwmgr_func->powergate_acp == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
@@ -1160,9 +1058,6 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return;
-
 	if (hwmgr->hwmgr_func->powergate_sdma == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
@@ -1211,9 +1106,6 @@ static int pp_notify_smu_enable_pwe(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->smus_notify_pwe == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -1228,9 +1120,6 @@ static int pp_enable_mgpu_fan_boost(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->enable_mgpu_fan_boost == NULL)
 		return 0;
 
@@ -1243,9 +1132,6 @@ static int pp_set_min_deep_sleep_dcefclk(void *handle, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk == NULL) {
 		pr_debug("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -1260,9 +1146,6 @@ static int pp_set_hard_min_dcefclk_by_freq(void *handle, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq == NULL) {
 		pr_debug("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -1277,9 +1160,6 @@ static int pp_set_hard_min_fclk_by_freq(void *handle, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_hard_min_fclk_by_freq == NULL) {
 		pr_debug("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -1294,9 +1174,6 @@ static int pp_set_active_display_count(void *handle, uint32_t count)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	return phm_set_active_display_count(hwmgr, count);
 }
 
@@ -1305,8 +1182,6 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	struct pp_hwmgr *hwmgr = handle;
 
 	*cap = false;
-	if (!hwmgr)
-		return -EINVAL;
 
 	if (!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
@@ -1320,9 +1195,6 @@ static int pp_get_asic_baco_state(void *handle, int *state)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (!hwmgr->hwmgr_func->get_asic_baco_state)
 		return 0;
 
@@ -1335,9 +1207,6 @@ static int pp_set_asic_baco_state(void *handle, int state)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (!hwmgr->hwmgr_func->set_asic_baco_state)
 		return 0;
 
@@ -1350,7 +1219,7 @@ static int pp_get_ppfeature_status(void *handle, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !buf)
+	if (!buf)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_ppfeature_status == NULL) {
@@ -1365,9 +1234,6 @@ static int pp_set_ppfeature_status(void *handle, uint64_t ppfeature_masks)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->set_ppfeature_status == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -1380,9 +1246,6 @@ static int pp_asic_reset_mode_2(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->asic_reset == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -1395,9 +1258,6 @@ static int pp_smu_i2c_bus_access(void *handle, bool acquire)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->smu_i2c_bus_access == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
@@ -1410,9 +1270,6 @@ static int pp_set_df_cstate(void *handle, enum pp_df_cstate state)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (!hwmgr->hwmgr_func->set_df_cstate)
 		return 0;
 
@@ -1425,9 +1282,6 @@ static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (!hwmgr->hwmgr_func->set_xgmi_pstate)
 		return 0;
 
@@ -1440,9 +1294,6 @@ static ssize_t pp_get_gpu_metrics(void *handle, void **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (!hwmgr->hwmgr_func->get_gpu_metrics)
 		return -EOPNOTSUPP;
 
@@ -1453,9 +1304,6 @@ static int pp_gfx_state_change_set(void *handle, uint32_t state)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (hwmgr->hwmgr_func->gfx_state_change == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 981dc8c7112d..f1d6b4b174b6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -30,16 +30,8 @@
 #define TEMP_RANGE_MIN (0)
 #define TEMP_RANGE_MAX (80 * 1000)
 
-#define PHM_FUNC_CHECK(hw) \
-	do {							\
-		if ((hw) == NULL || (hw)->hwmgr_func == NULL)	\
-			return -EINVAL;				\
-	} while (0)
-
 int phm_setup_asic(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
-
 	if (NULL != hwmgr->hwmgr_func->asic_setup)
 		return hwmgr->hwmgr_func->asic_setup(hwmgr);
 
@@ -48,8 +40,6 @@ int phm_setup_asic(struct pp_hwmgr *hwmgr)
 
 int phm_power_down_asic(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
-
 	if (NULL != hwmgr->hwmgr_func->power_off_asic)
 		return hwmgr->hwmgr_func->power_off_asic(hwmgr);
 
@@ -62,7 +52,6 @@ int phm_set_power_state(struct pp_hwmgr *hwmgr,
 {
 	struct phm_set_power_state_input states;
 
-	PHM_FUNC_CHECK(hwmgr);
 
 	states.pcurrent_state = pcurrent_state;
 	states.pnew_state = pnew_power_state;
@@ -77,7 +66,6 @@ int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = NULL;
 	int ret = -EINVAL;
-	PHM_FUNC_CHECK(hwmgr);
 	adev = hwmgr->adev;
 
 	/* Skip for suspend/resume case */
@@ -98,7 +86,6 @@ int phm_disable_dynamic_state_management(struct pp_hwmgr *hwmgr)
 {
 	int ret = -EINVAL;
 
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (!hwmgr->not_vf)
 		return 0;
@@ -118,7 +105,6 @@ int phm_force_dpm_levels(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_level level
 {
 	int ret = 0;
 
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->force_dpm_level != NULL)
 		ret = hwmgr->hwmgr_func->force_dpm_level(hwmgr, level);
@@ -130,7 +116,6 @@ int phm_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				   struct pp_power_state *adjusted_ps,
 			     const struct pp_power_state *current_ps)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->apply_state_adjust_rules != NULL)
 		return hwmgr->hwmgr_func->apply_state_adjust_rules(
@@ -142,7 +127,6 @@ int phm_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 
 int phm_apply_clock_adjust_rules(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->apply_clocks_adjust_rules != NULL)
 		return hwmgr->hwmgr_func->apply_clocks_adjust_rules(hwmgr);
@@ -151,7 +135,6 @@ int phm_apply_clock_adjust_rules(struct pp_hwmgr *hwmgr)
 
 int phm_powerdown_uvd(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->powerdown_uvd != NULL)
 		return hwmgr->hwmgr_func->powerdown_uvd(hwmgr);
@@ -161,7 +144,6 @@ int phm_powerdown_uvd(struct pp_hwmgr *hwmgr)
 
 int phm_disable_clock_power_gatings(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (NULL != hwmgr->hwmgr_func->disable_clock_power_gating)
 		return hwmgr->hwmgr_func->disable_clock_power_gating(hwmgr);
@@ -171,7 +153,6 @@ int phm_disable_clock_power_gatings(struct pp_hwmgr *hwmgr)
 
 int phm_pre_display_configuration_changed(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (NULL != hwmgr->hwmgr_func->pre_display_config_changed)
 		hwmgr->hwmgr_func->pre_display_config_changed(hwmgr);
@@ -182,7 +163,6 @@ int phm_pre_display_configuration_changed(struct pp_hwmgr *hwmgr)
 
 int phm_display_configuration_changed(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (NULL != hwmgr->hwmgr_func->display_config_changed)
 		hwmgr->hwmgr_func->display_config_changed(hwmgr);
@@ -192,7 +172,6 @@ int phm_display_configuration_changed(struct pp_hwmgr *hwmgr)
 
 int phm_notify_smc_display_config_after_ps_adjustment(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (NULL != hwmgr->hwmgr_func->notify_smc_display_config_after_ps_adjustment)
 			hwmgr->hwmgr_func->notify_smc_display_config_after_ps_adjustment(hwmgr);
@@ -202,7 +181,6 @@ int phm_notify_smc_display_config_after_ps_adjustment(struct pp_hwmgr *hwmgr)
 
 int phm_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (!hwmgr->not_vf)
 		return 0;
@@ -215,7 +193,6 @@ int phm_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 
 int phm_register_irq_handlers(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->register_irq_handlers != NULL)
 		return hwmgr->hwmgr_func->register_irq_handlers(hwmgr);
@@ -272,10 +249,6 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 
 bool phm_check_smc_update_required_for_display_configuration(struct pp_hwmgr *hwmgr)
 {
-	if (hwmgr == NULL ||
-	    hwmgr->hwmgr_func == NULL)
-		return false;
-
 	if (hwmgr->pp_one_vf)
 		return false;
 
@@ -291,7 +264,6 @@ int phm_check_states_equal(struct pp_hwmgr *hwmgr,
 				 const struct pp_hw_power_state *pstate2,
 				 bool *equal)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->check_states_equal == NULL)
 		return -EINVAL;
@@ -305,7 +277,6 @@ int phm_store_dal_configuration_data(struct pp_hwmgr *hwmgr,
 	int index = 0;
 	int number_of_active_display = 0;
 
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (display_config == NULL)
 		return -EINVAL;
@@ -339,7 +310,6 @@ int phm_store_dal_configuration_data(struct pp_hwmgr *hwmgr,
 int phm_get_dal_power_level(struct pp_hwmgr *hwmgr,
 		struct amd_pp_simple_clock_info *info)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (info == NULL || hwmgr->hwmgr_func->get_dal_power_level == NULL)
 		return -EINVAL;
@@ -348,7 +318,6 @@ int phm_get_dal_power_level(struct pp_hwmgr *hwmgr,
 
 int phm_set_cpu_power_state(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->set_cpu_power_state != NULL)
 		return hwmgr->hwmgr_func->set_cpu_power_state(hwmgr);
@@ -361,7 +330,6 @@ int phm_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw_power_s
 				PHM_PerformanceLevelDesignation designation, uint32_t index,
 				PHM_PerformanceLevel *level)
 {
-	PHM_FUNC_CHECK(hwmgr);
 	if (hwmgr->hwmgr_func->get_performance_level == NULL)
 		return -EINVAL;
 
@@ -386,7 +354,6 @@ int phm_get_clock_info(struct pp_hwmgr *hwmgr, const struct pp_hw_power_state *s
 	int result;
 	PHM_PerformanceLevel performance_level = {0};
 
-	PHM_FUNC_CHECK(hwmgr);
 
 	PP_ASSERT_WITH_CODE((NULL != state), "Invalid Input!", return -EINVAL);
 	PP_ASSERT_WITH_CODE((NULL != pclock_info), "Invalid Input!", return -EINVAL);
@@ -415,7 +382,6 @@ int phm_get_clock_info(struct pp_hwmgr *hwmgr, const struct pp_hw_power_state *s
 
 int phm_get_current_shallow_sleep_clocks(struct pp_hwmgr *hwmgr, const struct pp_hw_power_state *state, struct pp_clock_info *clock_info)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->get_current_shallow_sleep_clocks == NULL)
 		return -EINVAL;
@@ -426,7 +392,6 @@ int phm_get_current_shallow_sleep_clocks(struct pp_hwmgr *hwmgr, const struct pp
 
 int phm_get_clock_by_type(struct pp_hwmgr *hwmgr, enum amd_pp_clock_type type, struct amd_pp_clocks *clocks)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->get_clock_by_type == NULL)
 		return -EINVAL;
@@ -439,7 +404,6 @@ int phm_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 		enum amd_pp_clock_type type,
 		struct pp_clock_levels_with_latency *clocks)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->get_clock_by_type_with_latency == NULL)
 		return -EINVAL;
@@ -452,7 +416,6 @@ int phm_get_clock_by_type_with_voltage(struct pp_hwmgr *hwmgr,
 		enum amd_pp_clock_type type,
 		struct pp_clock_levels_with_voltage *clocks)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->get_clock_by_type_with_voltage == NULL)
 		return -EINVAL;
@@ -464,7 +427,6 @@ int phm_get_clock_by_type_with_voltage(struct pp_hwmgr *hwmgr,
 int phm_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
 					void *clock_ranges)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (!hwmgr->hwmgr_func->set_watermarks_for_clocks_ranges)
 		return -EINVAL;
@@ -476,7 +438,6 @@ int phm_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
 int phm_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
 		struct pp_display_clock_request *clock)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (!hwmgr->hwmgr_func->display_clock_voltage_request)
 		return -EINVAL;
@@ -486,7 +447,6 @@ int phm_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
 
 int phm_get_max_high_clocks(struct pp_hwmgr *hwmgr, struct amd_pp_simple_clock_info *clocks)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (hwmgr->hwmgr_func->get_max_high_clocks == NULL)
 		return -EINVAL;
@@ -496,7 +456,6 @@ int phm_get_max_high_clocks(struct pp_hwmgr *hwmgr, struct amd_pp_simple_clock_i
 
 int phm_disable_smc_firmware_ctf(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (!hwmgr->not_vf)
 		return 0;
@@ -509,7 +468,6 @@ int phm_disable_smc_firmware_ctf(struct pp_hwmgr *hwmgr)
 
 int phm_set_active_display_count(struct pp_hwmgr *hwmgr, uint32_t count)
 {
-	PHM_FUNC_CHECK(hwmgr);
 
 	if (!hwmgr->hwmgr_func->set_active_display_count)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index c0c2f36094fa..10f9b8fb93f2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -79,9 +79,6 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	hwmgr->usec_timeout = AMD_MAX_USEC_TIMEOUT;
 	hwmgr->pp_table_version = PP_TABLE_V1;
 	hwmgr->dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
@@ -195,7 +192,7 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 
 int hwmgr_sw_init(struct pp_hwmgr *hwmgr)
 {
-	if (!hwmgr|| !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->smu_init)
+	if (!hwmgr->smumgr_funcs->smu_init)
 		return -EINVAL;
 
 	phm_register_irq_handlers(hwmgr);
@@ -207,7 +204,7 @@ int hwmgr_sw_init(struct pp_hwmgr *hwmgr)
 
 int hwmgr_sw_fini(struct pp_hwmgr *hwmgr)
 {
-	if (hwmgr && hwmgr->smumgr_funcs && hwmgr->smumgr_funcs->smu_fini)
+	if (hwmgr->smumgr_funcs->smu_fini)
 		hwmgr->smumgr_funcs->smu_fini(hwmgr);
 
 	return 0;
@@ -275,7 +272,7 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
 
 int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)
 {
-	if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
+	if (!hwmgr->pm_en || !hwmgr->not_vf)
 		return 0;
 
 	((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled = false;
@@ -297,7 +294,7 @@ int hwmgr_suspend(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 
-	if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
+	if (!hwmgr->pm_en || !hwmgr->not_vf)
 		return 0;
 
 	((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled = false;
@@ -318,9 +315,6 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 
-	if (!hwmgr)
-		return -EINVAL;
-
 	if (!hwmgr->not_vf || !hwmgr->pm_en)
 		return 0;
 
@@ -362,9 +356,6 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr, enum amd_pp_task task_id,
 {
 	int ret = 0;
 
-	if (hwmgr == NULL)
-		return -EINVAL;
-
 	switch (task_id) {
 	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
 		if (!hwmgr->not_vf)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 182118e3fd5f..991fc4633e0b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1484,7 +1484,7 @@ static int get_cac_leakage_table(struct pp_hwmgr *hwmgr,
 	struct phm_cac_leakage_table  *cac_leakage_table;
 	unsigned long i;
 
-	if (!hwmgr || !table || !ptable)
+	if (!table || !ptable)
 		return -EINVAL;
 
 	cac_leakage_table = kzalloc(struct_size(cac_leakage_table, entries, table->ucNumEntries),
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
index b6921db3c130..f2ec9282aff6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
@@ -131,8 +131,7 @@ int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg, uint32_t *resp)
 {
 	int ret = 0;
 
-	if (hwmgr == NULL ||
-	    hwmgr->smumgr_funcs->send_msg_to_smc == NULL ||
+	if (hwmgr->smumgr_funcs->send_msg_to_smc == NULL ||
 	    (resp && !hwmgr->smumgr_funcs->get_argument))
 		return -EINVAL;
 
@@ -159,8 +158,7 @@ int smum_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
 {
 	int ret = 0;
 
-	if (hwmgr == NULL ||
-	    hwmgr->smumgr_funcs->send_msg_to_smc_with_parameter == NULL ||
+	if (hwmgr->smumgr_funcs->send_msg_to_smc_with_parameter == NULL ||
 	    (resp && !hwmgr->smumgr_funcs->get_argument))
 		return -EINVAL;
 
-- 
2.29.0

