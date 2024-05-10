Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49675C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 09:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B93D110E881;
	Fri, 10 May 2024 09:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iyu9jJVg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82E610E881
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 09:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggfZPtHAhJv4/Ivm+oLfb2jlH5g5NnhjzO1sp6we7EsCfw2VIkKqaW1Yvys6xTwXCzB7GQH4whIV/3h8Ege/WYowmnXoFc2M5xETzXX9Ly8MO8k0ndiSe1UTGDd/Bjv2/E0ZRhepu9BdtOTo858f89wg4MtA/jH5kTVV5zHMHkTUn5+HJEuFMuWcbT76zozR1Y84Z3auqOnnKTWjT0ALtIER7c7Y8g/0xoJbgBMIo/K0q4cD777jqbGbn5a1folz0NGtUZjLU9JDVLmfoU1TXYd4NU66cz0S77d+kQCrlFMqxWep7MVxBTJoPGOkTsTWA2v90ByGUGSroQCJCWJZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBgTdsOAavdyE1nlvPLkvQ3sIfG1MWoguKFTuOYWD0c=;
 b=QDWGN9YCntaTfz0YwkLIUzoF/8kVsbY8AISzclWc36QVfJPhB+ocr9xiOQH+hJsEtIqQyR2H4eB/PI2Kxg7I+msD06mXhosuKHl0XPHU+Neekgmzn19qpMW1cJbc9bGu+OrFWCdII99girESPFwntPTagShJRmtTKDSpqmsnv1lnV473oUDSBJnjKRqoaD1fRLDbifA1i03MWddI14mdm9xZDx8q3+sW0GvyFmvfX4x/OZZb+AyMB+W7gJEauHwJOysKJ6arLb5Rs+Mkks9fu4Vavulf6J+LZ9gLF0I+0GoZQSP3UqntQvto5xz2N1/RqpjuBpFO0JwYw2PXguRZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBgTdsOAavdyE1nlvPLkvQ3sIfG1MWoguKFTuOYWD0c=;
 b=iyu9jJVg5ep7rbRZFX4qsxC6lkbfvuJJ3MAttx0LvpTqkiSiw+x7Ijbw6jt1yLvuedFc4ZMEhgpV+KfeezFhLil330YdhBkh6x6ou26/ZpssOfjjdz8+t3IxQug9w91EGbHQuV+DjO9BIK5ll8AWZlABPS94zeiNI98VQHU7/WE=
Received: from CY8PR10CA0020.namprd10.prod.outlook.com (2603:10b6:930:4f::10)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 09:42:23 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::ed) by CY8PR10CA0020.outlook.office365.com
 (2603:10b6:930:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Fri, 10 May 2024 09:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 09:42:18 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 04:42:16 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/pm: Fix the null pointer dereference in
 apply_state_adjust_rules
Date: Fri, 10 May 2024 17:41:17 +0800
Message-ID: <20240510094117.493726-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510094117.493726-1-Jun.Ma2@amd.com>
References: <20240510094117.493726-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f2f994-5f54-4462-6d2e-08dc70d57ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pHsbSXBAQ3NlxLah8vjNmKZkcUPHDNtYVwpk9VWbpdsd684/N+A/ycIw+SOf?=
 =?us-ascii?Q?9GS9KDtXfclSwJi3HhAiurnlbGAAuXYw3qxRWyEIpTfGwuBDRsPTHQUUrYnb?=
 =?us-ascii?Q?a/cOb6fR0ggoo/J7kQlYVLontCuT/Ag/k/M84Gvykir+wAGJOPSZmy9s9GXZ?=
 =?us-ascii?Q?I1kxjNtk3l7P59VRzyiiDiTtaALB8j4kxApVKuumHhqetaeDjB2pr3crTQ9f?=
 =?us-ascii?Q?/3XoatEGo4r+DBha69VdOV/XEYlWTrLHLzjkg2w3RlKVMwDA+NXH1irmCGSM?=
 =?us-ascii?Q?KSWnFwg5CZFvB8i+dF1ckR1niCdqTr6C19qG6IIepgov7FRNta2peBoFhOSF?=
 =?us-ascii?Q?Np9Qrly4RIYs14W73uCQGF+XPq5ZYDhdOuxvLzStGCdNDNc8BsYzQ7PuxLT8?=
 =?us-ascii?Q?yjY06mWkESMK+3sFyN+2WWy0Q22n/mC0DmvmeVK5GO9s1mtHfcVdGXwRPxam?=
 =?us-ascii?Q?AaCnVgG9+mYjLE0h5r8nflRTURCfQw49VKEm2sqXguRFlLKqlAqDQBHcP4tb?=
 =?us-ascii?Q?IOj3uRA3LWOMHvV0lJJ4en05YiwKoFjMk4oEpa62VhMVxkzRSlV6zi+6ncyH?=
 =?us-ascii?Q?qDPFaYvsxn54Ja4mlYUB7sS9N5EhyPGw34wBcjQmu/sHpk/BePeKvZkmKvde?=
 =?us-ascii?Q?yX7KbLKBAeJA9L8OCqU9UwxVDdIU1hokhAUEzyhuhjguLGBrPET26uwaCL7X?=
 =?us-ascii?Q?eXVm18BnL1Icr78KHF935YWRDxxg8I2sZXsO/MBG7N7qhTZvGk+x1TAMFZs/?=
 =?us-ascii?Q?Mk4qI79QlmNOQA+v2UThRrXcOhB9nWmlAQeva5cm1j7/HjxLUbCkgi4vTPBM?=
 =?us-ascii?Q?sTK5fZrRfbNeceqWrA2EVwze1Z0iy3hBWuKnoTbYDAMt1gTU537UQqoCZEj0?=
 =?us-ascii?Q?e4WQSz1aXFHvc+vDTh5O9qHvdu5NdXuAs3uVv50s6Y0gSsm+f3Hc3/6x/zcG?=
 =?us-ascii?Q?jNCRdU4x1r8IcYI2Kk6FNGQUIhKp1t6+Szn2MKSkZFYzkTvHTbjNI+wsl2Pc?=
 =?us-ascii?Q?p0Suk3Y7lkhof9l4JchaKxhlx88xHh3DqCssA9HlW5MwJ+CzmvQ/cjVHX1ts?=
 =?us-ascii?Q?yKW9+HSh/yO0A0eAcRXtY3ojT5pZ/FbxYMyAPX1kcXCMoi4ZCOy8u+yq5ZqO?=
 =?us-ascii?Q?5vPFwVQnfVlYvJ3TIixuneB8S9y4HouPlTLzqfuZv0KlcofHjTPARRNy4Yl/?=
 =?us-ascii?Q?unhozq0NnGrj6aTDleMNOxkjxbpg9j1JcCjxCm33XuxR72ShSE5aa4/nWwqX?=
 =?us-ascii?Q?NG8+MdbNB9mak2DB2dQvoK+L93r1Y2lSwU+wOccLA+403JkszaEsZYnpGBlC?=
 =?us-ascii?Q?GMIS++8QDHtjQ4+6ynGgAmMaFtuFUCqTk6KHuuJUwQk528T+njc869xJR3y1?=
 =?us-ascii?Q?LRQes/l5UgSdiOdQXYtsn66GXTQu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:42:18.3326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f2f994-5f54-4462-6d2e-08dc70d57ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

Check the pointer value to fix potential null pointer
dereference

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  7 +++++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 14 ++++++++------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  7 +++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9301e65ff13c..632a25957477 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3314,8 +3314,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct smu7_power_state *smu7_ps =
-				cast_phw_smu7_power_state(&request_ps->hardware);
+	struct smu7_power_state *smu7_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -3332,6 +3331,10 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	uint32_t latency;
 	bool latency_allowed = false;
 
+	smu7_ps = cast_phw_smu7_power_state(&request_ps->hardware);
+	if (!smu7_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 	data->mclk_ignore_signal = false;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b858cc2a5c9e..7e1197420873 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1074,16 +1074,18 @@ static int smu8_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				struct pp_power_state  *prequest_ps,
 			const struct pp_power_state *pcurrent_ps)
 {
-	struct smu8_power_state *smu8_ps =
-				cast_smu8_power_state(&prequest_ps->hardware);
-
-	const struct smu8_power_state *smu8_current_ps =
-				cast_const_smu8_power_state(&pcurrent_ps->hardware);
-
+	struct smu8_power_state *smu8_ps;
+	const struct smu8_power_state *smu8_current_ps;
 	struct smu8_hwmgr *data = hwmgr->backend;
 	struct PP_Clocks clocks = {0, 0, 0, 0};
 	bool force_high;
 
+	smu8_ps = cast_smu8_power_state(&prequest_ps->hardware);
+	smu8_current_ps = cast_const_smu8_power_state(&pcurrent_ps->hardware);
+
+	if (!smu8_ps || !smu8_current_ps)
+		return -EINVAL;
+
 	smu8_ps->need_dfs_bypass = true;
 
 	data->battery_state = (PP_StateUILabel_Battery == prequest_ps->classification.ui_label);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 3b461c07344b..6524d99e5cab 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3280,8 +3280,7 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct vega10_power_state *vega10_ps =
-				cast_phw_vega10_power_state(&request_ps->hardware);
+	struct vega10_power_state *vega10_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -3299,6 +3298,10 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	uint32_t stable_pstate_sclk = 0, stable_pstate_mclk = 0;
 	uint32_t latency;
 
+	vega10_ps = cast_phw_vega10_power_state(&request_ps->hardware);
+	if (!vega10_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 
-- 
2.34.1

