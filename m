Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B56C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680FF10EA0C;
	Fri, 11 Feb 2022 07:53:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029B410EA0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5cgszWShjHtF86C2xAHv2qOjxBEa8soGeipMwEoee+fIWW7tc5M+OfVAmZYKwQbUnmjAc5ZxHh8eUPFupRCevtshvnpsKgksBohuQQyMfvVcmeLz3EVZ/HJ1K5SQb5n43Jb5ywZ3tSo4ybHy+HDmVoo344YU3wMBXsMJwui5zYSb3ZcQnyvnUp+Jx9+xmf0gh4lZiWWDMcmxUDczEDBkFkar0fSw/Gjl3AnOpIUAGOni4ANuecc+hGvBZiisafVNKotxhRrlZcrkFHht6hHhNfyerwoY/fVKKXnoTs3RuZj2PBYAPJJ5mEI4AadBjuU+8A6mHfVIfkiPWXg38ITAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5crDTgOoML6ckAj1uOCY8+FlVKkbJGJiJerHsKAYNc=;
 b=Mn1/Cbp20FVwo3ng3fqyFOe0pmscnYXys7Sb6Lb5qa2eAku9nDccB4GN9lYIqtn+YFMW1yIxdHLcoFrJF2MniqtuklnjBbViemZDXrrGitXZw2b/am9jXpKOt7x74Jjnj/JjNZcPK173YRpldVUYqoJFaE9tJEEKNRNwSeRchO53JCt4uGs2N1s7snLyUf5XjO1tFCzqw+cmYLduh+Gb37DqoQYs0fiqjerR83L3U6qyJmrvuIDN/c3crTVaWlyA7VWNzzwz9irSeS69KtbEQJiUVnp0JtpcyrGhWyyHveYONky1dMv7Ye4xPCXpGP1+OX+WbatfHRWDMonaNo0dKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5crDTgOoML6ckAj1uOCY8+FlVKkbJGJiJerHsKAYNc=;
 b=iZ5md1iaRVsLQqWmAP10UOxGiu59AJMUwnH1IGEswSKuX7NoXPnc9lWGsY06XkxxLGo48XwZxIkkBsMzYyTY0kw2HKaLiWE1eaAHzxHWRNvlYcTuRsZAiZL0AY5Tu52GKMJwWtvGyNx8PtXHq8shsRCi/tUPIGDN997wsjS4LrI=
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by BYAPR12MB3253.namprd12.prod.outlook.com (2603:10b6:a03:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 07:52:58 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::b1) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:58 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:55 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/pm: drop nonsense !smu->ppt_funcs check
Date: Fri, 11 Feb 2022 15:52:07 +0800
Message-ID: <20220211075209.894833-10-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77a6fc68-47bb-49e8-06a3-08d9ed338518
X-MS-TrafficTypeDiagnostic: BYAPR12MB3253:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3253E6D1C12F9F0AA6288DB4E4309@BYAPR12MB3253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbbtVyiEHbq23e0GdHGL9DnnPLi3b4AOxN1nlJxXJpaz6msRZokhnr9+oJwwpEiWBU3w86KdZIU/XbeMVtsbU12R+JLx4gjyhV+fWwyG0aoef3KhTk8oKYH7yerPy7xndiUpWvm2NxWcloMqLJxoPiy2hw16F+w6vSCIXEt76BgkVOKM5JWwwT7UGNPMMqNv30LfVqSDJ+pwISP/yRNOGuQYFk4WBQQZddnIUyZg3USdCqPTVlmQ995RHxmjrVaTpjBMGgxdUzq2976GlSx69AASoFTSF5HC0655h13b4GInwBnf4q5g3D9Ih/jPpIHkBcDvMgCQx8kwAoz2etDk+WhKgWH6ClzFbWft4n/xn3wgsWByQa598jSlymtS58DjC8yh4kKSsdphnthobo/jgFzmwlwEO2+RmhzRhzvJvU4JkNgyKtw4G++u8F9ZGjtCGbXzci2BItDXoFuffJlUMoC3UjSyIK9q8kX6GJXeCdb0enlOG+gKqoLtTEhsNsg98gxa6RljxZcbidwzxnc3aCzsPERb879tJ5s+K3Rh6m7GrOA8VgQ8K3foAdVx29wV3tWtbXSf429wd0Nmbu1kAJ0Xzkkq4xXHwu2x9KSkqVt61F7in/D61S1SaV0AKyUm5qk1C3rvUkgxUqVNe9ZpO5ohOmy36FElS/LZA+GZSqd8U8i/FDpXhZ0ojij0PhO4XzN4AiGOSc7qor+MiAVLxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(2616005)(316002)(6916009)(70206006)(4326008)(8676002)(36756003)(70586007)(54906003)(82310400004)(8936002)(16526019)(5660300002)(426003)(336012)(26005)(44832011)(186003)(81166007)(83380400001)(6666004)(86362001)(40460700003)(2906002)(36860700001)(47076005)(508600001)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:58.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a6fc68-47bb-49e8-06a3-08d9ed338518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3253
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

Since the "smu->ppt_funcs" was already well installed at early_init phase,
the checks afterwards make nonsense.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I07a945035a87b23032e4911bba768edacbd5e65a
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 20 +++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h |  2 +-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 27a453fb4db7..3773e95a18bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -934,7 +934,7 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 	struct smu_context *smu = container_of(work, struct smu_context,
 					       interrupt_work);
 
-	if (smu->ppt_funcs && smu->ppt_funcs->interrupt_work)
+	if (smu->ppt_funcs->interrupt_work)
 		smu->ppt_funcs->interrupt_work(smu);
 }
 
@@ -1782,7 +1782,7 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
+	if (smu->ppt_funcs->force_clk_levels) {
 		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 			smu->user_dpm_profile.clk_mask[clk_type] = mask;
@@ -1845,8 +1845,7 @@ static int smu_set_mp1_state(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (smu->ppt_funcs &&
-	    smu->ppt_funcs->set_mp1_state)
+	if (smu->ppt_funcs->set_mp1_state)
 		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
 
 	return ret;
@@ -1858,7 +1857,7 @@ static int smu_set_df_cstate(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
+	if (!smu->ppt_funcs->set_df_cstate)
 		return 0;
 
 	ret = smu->ppt_funcs->set_df_cstate(smu, state);
@@ -1872,7 +1871,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
 	int ret = 0;
 
-	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
+	if (!smu->ppt_funcs->allow_xgmi_power_down)
 		return 0;
 
 	ret = smu->ppt_funcs->allow_xgmi_power_down(smu, en);
@@ -2510,7 +2509,7 @@ static int smu_get_baco_capability(void *handle, bool *cap)
 
 	*cap = false;
 
-	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
+	if (smu->ppt_funcs->baco_is_support)
 		*cap = smu->ppt_funcs->baco_is_support(smu);
 
 	return 0;
@@ -2542,7 +2541,7 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 {
 	bool ret = false;
 
-	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
+	if (smu->ppt_funcs->mode1_reset_is_support)
 		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
 
 	return ret;
@@ -2667,8 +2666,7 @@ int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
 {
 	int ret = -EOPNOTSUPP;
 
-	if (smu->ppt_funcs &&
-		smu->ppt_funcs->get_ecc_info)
+	if (smu->ppt_funcs->get_ecc_info)
 		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
 
 	return ret;
@@ -2881,7 +2879,7 @@ int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size)
 {
 	int ret = 0;
 
-	if (smu->ppt_funcs && smu->ppt_funcs->send_hbm_bad_pages_num)
+	if (smu->ppt_funcs->send_hbm_bad_pages_num)
 		ret = smu->ppt_funcs->send_hbm_bad_pages_num(smu, size);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 5f21ead860f9..a91967b31eeb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -28,7 +28,7 @@
 #if defined(SWSMU_CODE_LAYER_L1)
 
 #define smu_ppt_funcs(intf, ret, smu, args...) \
-	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->intf(smu, ##args) : ret) : -EINVAL)
+	((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->intf(smu, ##args) : ret)
 
 #define smu_init_microcode(smu)						smu_ppt_funcs(init_microcode, 0, smu)
 #define smu_fini_microcode(smu)						smu_ppt_funcs(fini_microcode, 0, smu)
-- 
2.29.0

