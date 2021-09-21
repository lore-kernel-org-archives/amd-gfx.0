Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1335FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C8161184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6C8161184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3426EA97;
	Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A326EA7D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6m5dtuDsJRjvZPxT+hTKvlb1Ocaly6KPhwJk4KrGUCid7WjseLAoTRB2Ikr9S9CEpXXdKQbfdb0UUbcgfHhkZd1RdBlrLOqywZFymVgqFT4fmc8tIh0dmn4w3rEeqShE9v++7b3VNybwlcKi+O+7fPovHp+B0D9XUJAangkUUKPRwc7Owk99CrGQQJPLxXoh5Ap1mOm84WKmcVDUcW0C5pRP7IeTAiSjreoi3Vv5X8YiTYQcn/7pwQFtDSsRKGaHxSPe5F6YgfKug2WrY6mXxqnAT7GTEJL+sJPja2MAW6hGHuQ5/AzfPNlcjKAyIt2/PQWEdWb3O7t5ZRVd33rgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=uKJcGo9fy278GJezlSmZeA3i30ofGswJZeKMK/ZbKHE=;
 b=hKbyYLn5OKxqJ39hJ0UD40lBZlD2DGMTyJySb3U2ywQ7Wgc8dtCqvm3XqgMs/p1S2qfubDya5B/82xLD7/j7VmJj/VwEOWWNnloPcUZnu0yBeFoNISBLetZPwiZZYX5RnfawzZUbROWYovte1KGfcenYwogDnt/iMWS0cFNhQmT5IWW0FWuDxNP424K9dn9w9VSnhFj0BuA+yfv6TxSgwBhjDQTeuJlCKQH6pEThZUA54+KshELIIIqHBOo0tbaw+rG70dzuxZHyG5n0KShxXPAs0FuHIiYguwfsklKs6Kb/1gGOA8eNQQ0M9M0ksHiOU3A0ZpHUGfySpvYK1j1sEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKJcGo9fy278GJezlSmZeA3i30ofGswJZeKMK/ZbKHE=;
 b=nQnt9pP00QtHct+0Qqc2OKjIqvM6aVJCh3nXOPUjfn6z1vxclrAO3Pv66fDzjjrLOsoZx5Yfgv+Fpa35WxadMStxZH6Oj7oykCYhd+z3XeRsm4JQadKg//WjiMAxFCRfAT1z404fwaGTs/i3Vf5df/TIDMLBpaKwrAhmbGBBCH8=
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:54 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::aa) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/66] drm/amdgpu/navi10_ppt: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:44 -0400
Message-ID: <20210921180725.1985552-26-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b5ac97b-e486-4b47-e23f-08d97d2abba9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3502:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3502D046F05413110EC515BDF7A19@MN2PR12MB3502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/an42Bx+fIq9huXKlPWGmJ5PfJM7eoRFnAXytZebctsxQu3OBPfM9Sy0hyd/pe1CZ08dctOy8EXV3n73wp4FpMwtFBBQIV6+6+gJRjMTxBBgPc07UrU8Kfj8vBowJvpZJmyU0ytsqVInE2QbsqJT7Lo/IvZ1xcqY8oXDMAaePEXvEs9KXOjeD3BlWvgVXJ6uGqO4e84j6QvSYrqLLWR9CtuEtfZ2fmeF0nbVheJ711MkuvL+XmEgHv+UB3FoTvzXTQxTwaAcMElZdU+HAmUY0ONjXNE/YJVb7yVXefINNRv7pNdUJxWm79MCEp7NOIasNRHEGCq6TrfNI6pBPBKd7yqCm0qizKI3GjjULFsELFJ8/7ZDe6sCl1UxDBanbyTga9myA9uuX/mWmAmSCugUQdp9arqvkLvv2HNk/KXhPZxt8ft1ooUaZC4IGjj3uWIwmEJ1N8CgoMiNX/R8SssUeuewRxpgDKo7XOYqWciJyhrdD4ckij/C7bhPhZEx+ujE8nER8mA1cX154LxfLtyTY8FCwT/DyVud36qsjIAT+VuknBzmOCPoAhDDTunzRSxU84A14zHWv/ogFD+JvRp3kIXJDWYxpalUIq+Mjvrdul2jyNtbRIaLMUZuczstJGuqLikT+9EQByQm780vvgwTy5g2l3vq82RwpAfhmG10wKFha5ERhnHG/Xxc3tyq0ykktMhlnoDccZH0nM2N3PI/cNgvdoMhy19ztJAtLpybp4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(1076003)(36860700001)(86362001)(36756003)(186003)(8936002)(426003)(356005)(70206006)(16526019)(336012)(81166007)(2906002)(508600001)(5660300002)(6916009)(7696005)(83380400001)(4326008)(82310400003)(316002)(26005)(2616005)(6666004)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:53.9388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5ac97b-e486-4b47-e23f-08d97d2abba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
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
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ae11f5ed7a97..d96f904a765b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -345,7 +345,7 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 
 	/* DPM UCLK enablement should be skipped for navi10 A0 secure board */
 	if (!(is_asic_secure(smu) &&
-	     (adev->asic_type == CHIP_NAVI10) &&
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) &&
 	     (adev->rev_id == 0)) &&
 	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
@@ -354,7 +354,7 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 
 	/* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
 	if (is_asic_secure(smu) &&
-	    (adev->asic_type == CHIP_NAVI10) &&
+	    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) &&
 	    (adev->rev_id == 0))
 		*(uint64_t *)feature_mask &=
 				~FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
@@ -925,18 +925,18 @@ static int navi1x_get_smu_metrics_data(struct smu_context *smu,
 		return ret;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 9):
 		if (smu_version > 0x00341C00)
 			ret = navi12_get_smu_metrics_data(smu, member, value);
 		else
 			ret = navi12_get_legacy_smu_metrics_data(smu, member, value);
 		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
 	default:
-		if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
-		      ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00))
+		if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) && smu_version > 0x00351F00) ||
+		      ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) && smu_version > 0x002A3B00))
 			ret = navi10_get_smu_metrics_data(smu, member, value);
 		else
 			ret = navi10_get_legacy_smu_metrics_data(smu, member, value);
@@ -1509,8 +1509,8 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 	uint32_t sclk_freq;
 
 	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 0):
 		switch (adev->pdev->revision) {
 		case 0xf0: /* XTX */
 		case 0xc0:
@@ -1525,7 +1525,7 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 			break;
 		}
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 5):
 		switch (adev->pdev->revision) {
 		case 0xc7: /* XT */
 		case 0xf4:
@@ -1548,7 +1548,7 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 			break;
 		}
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(11, 0, 9):
 		sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
 		break;
 	default:
@@ -2562,8 +2562,8 @@ static bool navi10_need_umc_cdr_workaround(struct smu_context *smu)
 	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
 		return false;
 
-	if (adev->asic_type == CHIP_NAVI10 ||
-	    adev->asic_type == CHIP_NAVI14)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0) ||
+	    adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5))
 		return true;
 
 	return false;
@@ -2671,8 +2671,8 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 	 * - PPSMC_MSG_SetDriverDummyTableDramAddrLow
 	 * - PPSMC_MSG_GetUMCFWWA
 	 */
-	if (((adev->asic_type == CHIP_NAVI10) && (pmfw_version >= 0x2a3500)) ||
-	    ((adev->asic_type == CHIP_NAVI14) && (pmfw_version >= 0x351D00))) {
+	if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) && (pmfw_version >= 0x2a3500)) ||
+	    ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) && (pmfw_version >= 0x351D00))) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_GET_UMC_FW_WA,
 						      0,
@@ -2691,13 +2691,13 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 			return 0;
 
 		if (umc_fw_disable_cdr) {
-			if (adev->asic_type == CHIP_NAVI10)
+			if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0))
 				return navi10_umc_hybrid_cdr_workaround(smu);
 		} else {
 			return navi10_set_dummy_pstates_table_location(smu);
 		}
 	} else {
-		if (adev->asic_type == CHIP_NAVI10)
+		if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0))
 			return navi10_umc_hybrid_cdr_workaround(smu);
 	}
 
@@ -3151,18 +3151,18 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
 		return ret;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 9):
 		if (smu_version > 0x00341C00)
 			ret = navi12_get_gpu_metrics(smu, table);
 		else
 			ret = navi12_get_legacy_gpu_metrics(smu, table);
 		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
 	default:
-		if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
-		      ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00))
+		if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) && smu_version > 0x00351F00) ||
+		      ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) && smu_version > 0x002A3B00))
 			ret = navi10_get_gpu_metrics(smu, table);
 		else
 			ret =navi10_get_legacy_gpu_metrics(smu, table);
@@ -3180,7 +3180,7 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 	uint32_t param = 0;
 
 	/* Navi12 does not support this */
-	if (adev->asic_type == CHIP_NAVI12)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 9))
 		return 0;
 
 	/*
-- 
2.31.1

