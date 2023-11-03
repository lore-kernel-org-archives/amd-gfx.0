Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8C9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 08:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D0310E0A6;
	Fri,  3 Nov 2023 08:21:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F44310E0A6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 08:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq0uFlmwxanTPbjfJc12QNajz4jwPsD12gAM2z3JI9iPI/SVe1Ds0Q/K2RaEFClPme8VQcjH0aMiU6KnQJYt+Fgm7gzUo2XqLrali7hWa4rx10JDTtjHAemm3GSaIifAdp103HViTp2c6MCzVWPr/cS6CRfPZj7TRmdNVL1Yf4VYjUYdCValQn63nzP3Hdwvsd2KfaVy5qH/Nj6/OgWmEcHrBkP1LqTF9o3HigSqsfHffK/ln4fSfV+IGXmgFW2XBZdLuS/Dp2eBCJLFHijy3fTiwGMd+qH3PlRg9t6e9FV/P3+p32pCv/8KwHCQXDuXOmjmLW8hOB+38KlXrWagKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPowpsGcxkWJRihOdZP/3Gio5BBALMeXivfPIKW2olI=;
 b=QDyZfVjPNnyvieUDzwSACRCK44XFZGeS+gLVrk1+0O1vY+1eP7pJfci4+rwtBZ7Taqrihn9Y7Hl0CZdfqcgRNTPq0d5zI0vs1JhgvRWGpGM25ZfWK9SOllD95cHNskboN8DnKv/XNyFA03f447fejkjyS4A7ftK+9vRx4Odce5GxaOiA9d6Np8R37NhstjYI9jvBgIJVGb24uDnfep1zLC5JVUya7gni4llEEOu8RNIUwwPD08vxIOVLpmlp9PSbrQUA5zJZoBuLELm/czuO1j2OEqC+TxylGmAapYdubHyNs4hsYJ4UHnW4nHV2A8bvbQ5WzvUV7X/S7oFRGu3fVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPowpsGcxkWJRihOdZP/3Gio5BBALMeXivfPIKW2olI=;
 b=ujMi4Id/WcbUFKBHUpi8laJlI6FGeYTDryLFVjanNWDC9iT3GHpE/t+KLOFdXUrcQllphU6oLgeJpJUxZhifvSxQVe1at47sq4CMOU1xq8tjijvRDiivrLTOEsMQAjSUO3jhoVBbMzWRjJserKENAAMz87hqM3klwHuPGUNcG30=
Received: from CH5P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::10)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 08:21:31 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::37) by CH5P221CA0013.outlook.office365.com
 (2603:10b6:610:1f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 08:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 08:21:30 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 03:21:28 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Move some functions to smu_v13_0.c as generic code
Date: Fri, 3 Nov 2023 16:21:13 +0800
Message-ID: <20231103082113.3038890-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a3347d-2603-4a87-f258-08dbdc45e23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhLMMc7S7xrCQSq7EzUtTXxW+zfg1Mjba/FNu91Wgs/29kGEbZHEY1rTptHXN+Q1IcRtB7Y5QNxx18kCPXsrjQHTVlQY54tZZLw50iZ9ZGPizPS2AHWj6Oi3HBVfwApHYSVOEGEkXVuvZGA7mh96vVM7DdOz06/4UzRvA7R2NeOwBIfKbBuLE8LOtUT9F0yLjDtN8O1eswNQLO6/dJU4NwnBlYw2KG6xuuBzylBsE9JAX8OcbK67BMbrMyKnJjQEbbWhM869eHh+j4qXmBD3u5E9bDMjx57dAFhiggS9lEVmIgpFQfux5K72TzofxDsLuQhIZkNlf9jNKgRwVb+uj8o4O+b9973wCBEsFCmWtGdWus5WlyBwhTeuOACRtPa40hJmAuRzISeupkR8AUN1+8F6DrxzlyrfAzDG4B2KgEOSfpmGR+gfjQWwWa9+QXFVnsEXTEmh+O+RhvRa8M0/WpWC2pNAh8QZw7Sz1TMqcUZQ+gyzyoNRJSbVNPCnTAkNAekoHJqY9YdESicNEcKIRwWBT90HaHoprlA/8WnS/1euPcP5xU1eFKDLRzCWWGgVq+hI3keYHh/dE2pKSJzhl8kFhhVdVYnUJem607u9dJOfr/lDnKJk6XcofE+8arYKIcgniv0E0/a6DOjvz/AOEs5FRhDgtBw62gZRNSggjdgE4LYgnzZIJRSkYoayxShj0PvyDmYdJBKcSbyINAvyECp7iSqxaxrCIWtUaRCcWzn7ev9apRrGbsTtFYxx0haPEUetagbo5ei3pMy9mk5JNKaG6t4B7dOgJ1R3C1qgg1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(4326008)(8936002)(2906002)(478600001)(356005)(36756003)(36860700001)(5660300002)(86362001)(41300700001)(8676002)(70586007)(81166007)(70206006)(316002)(110136005)(40460700003)(6636002)(40480700001)(26005)(47076005)(1076003)(82740400003)(6666004)(16526019)(336012)(2616005)(426003)(7696005)(83380400001)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 08:21:30.8906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a3347d-2603-4a87-f258-08dbdc45e23e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

Use generic functions and remove the duplicate code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 38 ++++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 36 +-----------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 36 +-----------------
 3 files changed, 32 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 281c3cb707a5..1f42befcc213 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2282,22 +2282,40 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 
 int smu_v13_0_baco_enter(struct smu_context *smu)
 {
-	int ret = 0;
-
-	ret = smu_v13_0_baco_set_state(smu,
-				       SMU_BACO_STATE_ENTER);
-	if (ret)
-		return ret;
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
-	msleep(10);
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
+		return smu_v13_0_baco_set_armd3_sequence(smu,
+				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+	else {
+		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
+		if (!ret)
+			msleep(10);
 
-	return ret;
+		return ret;
+	}
 }
 
 int smu_v13_0_baco_exit(struct smu_context *smu)
 {
-	return smu_v13_0_baco_set_state(smu,
-					SMU_BACO_STATE_EXIT);
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		/* Wait for PMFW handling for the Dstate change */
+		usleep_range(10000, 11000);
+		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	}
+
+	if (!ret)
+		adev->gfx.is_poweron = false;
+
+	return ret;
 }
 
 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4d3076fe37a1..d715ca2ec121 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2586,38 +2586,6 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					       NULL);
 }
 
-static int smu_v13_0_0_baco_enter(struct smu_context *smu)
-{
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	struct amdgpu_device *adev = smu->adev;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
-					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-	else
-		return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_0_baco_exit(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-		/* Wait for PMFW handling for the Dstate change */
-		usleep_range(10000, 11000);
-		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
-	} else {
-		ret = smu_v13_0_baco_exit(smu);
-	}
-
-	if (!ret)
-		adev->gfx.is_poweron = false;
-
-	return ret;
-}
-
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3064,8 +3032,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
-	.baco_enter = smu_v13_0_0_baco_enter,
-	.baco_exit = smu_v13_0_0_baco_exit,
+	.baco_enter = smu_v13_0_baco_enter,
+	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_0_mode1_reset,
 	.mode2_reset = smu_v13_0_0_mode2_reset,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 81eafed76045..f5596f031d00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2515,38 +2515,6 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_7_baco_enter(struct smu_context *smu)
-{
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	struct amdgpu_device *adev = smu->adev;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
-					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-	else
-		return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_7_baco_exit(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-		/* Wait for PMFW handling for the Dstate change */
-		usleep_range(10000, 11000);
-		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
-	} else {
-		ret = smu_v13_0_baco_exit(smu);
-	}
-
-	if (!ret)
-		adev->gfx.is_poweron = false;
-
-	return ret;
-}
-
 static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2628,8 +2596,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
-	.baco_enter = smu_v13_0_7_baco_enter,
-	.baco_exit = smu_v13_0_7_baco_exit,
+	.baco_enter = smu_v13_0_baco_enter,
+	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
-- 
2.34.1

