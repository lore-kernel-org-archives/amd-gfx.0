Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F49C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 05:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832FD10E063;
	Tue,  7 Nov 2023 05:33:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A341110E063
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 05:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+IrUvMud4iF+y/1tMOeeA9u4q/3tjGqSk0TxgvqiDek0PpH87HZ7cPkVpPzOt3cvzspj3f96BpglVm/TDAzNtpilTZ/ADT6yhRr6V5a+zKFd89hUkhXr4SFVmZf6isGHf394q9b3L2tfppzfokCXg5mAJ9iVSaEmGyovKrTURu2zupIYCa5ncNyIqtq8rro+M94HLIpcfmjBFbH5CyMExYU2eWn/CaYsBk+DUqQQd54I/IePqsVJjW1yIZDJiHKQmXE3YiFoPpMXSZYRyruntkXRzpcphn6kMq5t3yl80Lg3VfBYucKW8K4ifVXnFF94KySdFCWdDKoWwCKq55QBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nB4MOVDbdP14hVBmq9HBoe/QaBe8QrkDoGrzTXKkxRg=;
 b=QZ3dnH4ZvsR8gVpKu+R7yt9/CFpTZi6PKe4OuCtWWtqyHJiAtAI+hkiXX2aTQhu5hj4pyn2Tni/7t388XVTTS+ygFIWH7m8bCCslHpazg7xiRKBj5ykRK0KZLyT1AFYtzCJJnX1bkrgIqodaOEzXyesCUi5BplbL1ZKP96uEfU8S0gMbs7Fa+2L3b7l58Styk5GvnStXQpIo/9L9KLO93YMoLAyhjeX65GpzV/qAoZL/PFuF1G348KeichofZz2k2SAU8ar6xMIVdVvzFPlALl8f/0f57CCPLR1z5sGFFWURi/AEjUlqxGZR8KDdpNC8WhpyszQSpXbHhbmk9dkecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB4MOVDbdP14hVBmq9HBoe/QaBe8QrkDoGrzTXKkxRg=;
 b=JJSZ7mhccL1dLJGPxoRKPRBRhwvZFNOElh+ltGOrPv/uP5khb4UbhgiGtzJPst6o0TQCRLLfCI5FktwD34d5/2fLXrDjtbex3tYncXPQeoFObKMti1r1DTHdvU0iHeeRPWUft88u1meq538WyFbkeksV33ntkSPF1HD24r4OMqs=
Received: from MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Tue, 7 Nov
 2023 05:33:36 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::6e) by MN2PR11CA0021.outlook.office365.com
 (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 05:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 05:33:35 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 23:33:33 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Remove redundant function members of pptable_funcs
Date: Tue, 7 Nov 2023 13:33:06 +0800
Message-ID: <20231107053306.3452343-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: e5617cbe-028f-4bfb-b1db-08dbdf5316ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu2qULLimByTHiBpBnWawm/RVGjezjieJ+f/sXbW9l/HZ+cW1eODPz20FmDV4DCCWDS9/u+lCxRGXhh7o+6P4uT4Vt8DHb0mr/IYSE6CNyCXDxrCNX7H14WSRZaKSsDUsGlth7m6goxAdeMpWTeKs98mNd6SvMuEUuwB2JYlmglz0VJClVBoyxvBVGpOb789r+pM/Y4REtSI0ooIBp+nGBNWqmOi7PqhkSsDpG5PXVjCB22JtulsZvq5xQnjUx4tvNGJoF/pwFmkYR2nqfxENOaDwSb2P/5mkeru7VdrXBPjuy9KbnWSpA75nXVO5YLfjricKob9nPP73joATb8Pb3m6gqYR02evVGuNjZoeOz1QXoSyoYp0XxN8rUTrg6l614zdZOQ+bPEyfH28+yept+SfWjE6OUKjVTRdJM5KVBuhy0GgU+cM60Nf2YlGDnGBA5caR1xKv2aFPb4FBW0scpUM17FTD/cWz602Zgtbbba/Z5wRpg1itLka7uDaxk0PE2pF278RvjaK3dcteU9vvrR1aP9NfqYDNsC8RhRVU2Vs6WhjuFVMm8i8nR0L6D9zPvYDyUHhxTtVLN3AmEoxQ4iLlmhTG954EEFogbuKbfa7XRR3jONsW0H0tQynpC8/ktrY8WbxQWYAV7oPFQ4uIConaw83hs5DBjt96mOXeAYnSXxKqzTiKpmp5uYf4BHil5XlExveZdkvj4jeZmsLUc39mV1JFAnPnLGdRJ1bU/W1xsPT9Tqu6CH5Divrhh4oVxT5I/IZ1qtQv9S8xl8+3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(2906002)(36860700001)(47076005)(70206006)(70586007)(110136005)(81166007)(82740400003)(86362001)(356005)(6666004)(83380400001)(7696005)(2616005)(478600001)(336012)(1076003)(426003)(16526019)(26005)(5660300002)(4326008)(40460700003)(8936002)(316002)(6636002)(36756003)(8676002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 05:33:35.8218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5617cbe-028f-4bfb-b1db-08dbdf5316ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant functions members of pptable_funcs and change
the function type as static because they are not called by other
files.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 --
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 -
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 41 +++++++++----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 -
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 -
 7 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 95cb919718ae..f307a7965941 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -215,10 +215,6 @@ int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
 
 bool smu_v13_0_baco_is_support(struct smu_context *smu);
 
-enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu);
-
-int smu_v13_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state);
-
 int smu_v13_0_baco_enter(struct smu_context *smu);
 int smu_v13_0_baco_exit(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 2cb6b68222ba..4cd43bbec910 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2407,8 +2407,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
 	.baco_is_support = smu_v11_0_baco_is_support,
-	.baco_get_state = smu_v11_0_baco_get_state,
-	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index a38233cc5b7f..8d1d29ffb0f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3537,8 +3537,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
 	.baco_is_support = smu_v11_0_baco_is_support,
-	.baco_get_state = smu_v11_0_baco_get_state,
-	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = navi10_baco_enter,
 	.baco_exit = navi10_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 8cb5b71c09d1..f2f401f00ed1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4428,8 +4428,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
 	.baco_is_support = smu_v11_0_baco_is_support,
-	.baco_get_state = smu_v11_0_baco_get_state,
-	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = sienna_cichlid_baco_enter,
 	.baco_exit = sienna_cichlid_baco_exit,
 	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1f42befcc213..9172d5d431f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2220,33 +2220,14 @@ int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
 	return 0;
 }
 
-bool smu_v13_0_baco_is_support(struct smu_context *smu)
-{
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-
-	if (amdgpu_sriov_vf(smu->adev) ||
-	    !smu_baco->platform_support)
-		return false;
-
-	/* return true if ASIC is in BACO state already */
-	if (smu_v13_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
-		return true;
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
-	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
-		return false;
-
-	return true;
-}
-
-enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu)
+static enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
 	return smu_baco->state;
 }
 
-int smu_v13_0_baco_set_state(struct smu_context *smu,
+static int smu_v13_0_baco_set_state(struct smu_context *smu,
 			     enum smu_baco_state state)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
@@ -2280,6 +2261,24 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 	return ret;
 }
 
+bool smu_v13_0_baco_is_support(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+
+	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
+		return false;
+
+	/* return true if ASIC is in BACO state already */
+	if (smu_v13_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
+		return true;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
+	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
+		return false;
+
+	return true;
+}
+
 int smu_v13_0_baco_enter(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d715ca2ec121..4a5f3cc44e98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3030,8 +3030,6 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.deep_sleep_control = smu_v13_0_deep_sleep_control,
 	.gfx_ulv_control = smu_v13_0_gfx_ulv_control,
 	.baco_is_support = smu_v13_0_baco_is_support,
-	.baco_get_state = smu_v13_0_baco_get_state,
-	.baco_set_state = smu_v13_0_baco_set_state,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f5596f031d00..2909ec06b1cb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2594,8 +2594,6 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.baco_is_support = smu_v13_0_baco_is_support,
-	.baco_get_state = smu_v13_0_baco_get_state,
-	.baco_set_state = smu_v13_0_baco_set_state,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
-- 
2.34.1

