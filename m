Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C70EC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD12610F441;
	Tue,  3 May 2022 20:37:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C29310F45F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtoeuJXGNYRtbglTIibYZBvlVabBBcfYxuPjHzGwtraOPPJqjyExkuwztIg1QD0aVrMCLuVh6H+WDu8bhaTDY1ShrSQCFnYa9p+VvAF2z6Zi+uiYbQw6fnNbnVZdYhXm6NiR+Mj3IWpNbIjC3oB0nHY+Kjh0asTNODrHgrw1DopCkvWepP88m4hfsxMJQwxQnQ42Gl687i35grlU7uFA/17sSjb2gd40dVvWQbnZBcdtM/lZJQt7Uiijguj0mnvVZ2AgSE/OpOY8BZzuhu+FrVziZjGFqPfkxuyezIQLb6zKRkgYE3l1iFsUoszWwQDx6XWJVEi5J0f5qEyIEG1NdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7cU8SNlqx7ky5SQJyRwO/5Nn+8NJ7Kq2QLBtbOctuo=;
 b=Pcc50pIVTHwkQR1Gktr8reX4CyIVKeXynp33++vkXGyGEK1EYO0ia45WgGsvls+qjcfukHW/EPYCS6QtNibx9cHI1XdhG6xu6Vx2eLsY8BrjDkmwBV0lN0t8h4d59kuq+JwjUEcB1DAhs+YArXykkvBZWIAOKS+wcTgj75gLABZzl1bAkutWLdQ+BXQoEH4xbip2J9Rf7MQefXLicE1oIArR6Zvcp5XhG+RlyMmIo8jgh7KyUx7aiDE+BYovqKrTjs7JoRsfUAVsiET08ebt1ncUCzQt4GfA6qyiOJ+vWq+DkVd5k1VGP1+ZgvDAnLpxbbxYYtWNgekTC3dcBBpfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7cU8SNlqx7ky5SQJyRwO/5Nn+8NJ7Kq2QLBtbOctuo=;
 b=Zk/BKLROaqTwUENk5tyAKaZos+Q8oI5JLbizp3iodDBwEdnCG5d9OpYSV2GPz6iOzk/EAFORBXuCalimSmUKHiVrbb/u77otnZkb67sREYUR52asBPwEhFrsZ3CmggjP1Z0ijP8B7eVL235jZpY6Gg8n/ubIAVzNTJCIMgLAr3I=
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by CY4PR12MB1557.namprd12.prod.outlook.com (2603:10b6:910:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 3 May
 2022 20:37:40 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3c) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/26] drm/amd/pm:add UMD Pstate clock settings for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:05 -0400
Message-ID: <20220503203716.1230313-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3755f57-cb4a-48cb-c41b-08da2d44c46f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1557:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1557A773917FD857E357F88CF7C09@CY4PR12MB1557.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p80lRhO1s0gcSB1WKeDhXdeBxHw5UET3mmPR3sJp+qtecLWx446BiEJqwcjvlj4mBQluIlVb4E/zfE63ZoR6nvhnXJBU6NizjJI2rxIvCjXVXrjemkSiyc0iEuZXOMU88uFADt31MIanpTYrVKNv5TUYTEKNmjXYTopolbd8ph1hd6uI1DzEcuBGaWO6x5/L8dQvO9mzHKnwXQAZJyxjKVpwMaJIt2pGlsTrFOQVGX4wZPC+6z/UThJM+N4dzy74+cik6etiGPKoZRyKOY4ntIU4oL4p4OKFmn4zRzq7M59NRu4IFZba8KSGgied7xUw8CYip0mp/J3NwQkKXnawivqcBUOavJU/5vvVA6CpqaMjikMFIAzfNSrxxbd8uXIBT0vUik6Z5824g8cPpUucgweg+Nt76wEnTf1ta/frpYxYMtMtS0112AcMghSqyxwlROKhfLb9qSaFJE/Rd+t0/n5E8NAVN/dKblPGsVPv5cX7R4HsLOigtuhkKW16RGAtUVeBUL8AsUjKS0ad9VMft96cNHicFenDK1Ynq0nyjPfGeSe6uTB8AMVTwowEHp/olNqiycfYlfC8cUvbf5aNlf9phTtWzGSi1IGCbH5TWm9x1iuiTPV8dWfru+WWFPQLjCGGx16b4Z755EC6FPb+cvRSljIpd9SxJ8JJltvX+FXEVTIYVR/h3b5jnoZSUS4HE36jBX/NF/b5Di1pX9uTSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(83380400001)(508600001)(36860700001)(8676002)(6916009)(4326008)(54906003)(70206006)(70586007)(5660300002)(316002)(8936002)(2616005)(6666004)(16526019)(426003)(186003)(336012)(1076003)(26005)(47076005)(2906002)(40460700003)(86362001)(356005)(82310400005)(81166007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:40.1156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3755f57-cb4a-48cb-c41b-08da2d44c46f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1557
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

add UMD Pstate clock settings for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 9e5ea20f2342..4c7154f9b80b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1226,6 +1226,57 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
+{
+	struct smu_13_0_dpm_context *dpm_context =
+				smu->smu_dpm.dpm_context;
+	struct smu_13_0_dpm_table *gfx_table =
+				&dpm_context->dpm_tables.gfx_table;
+	struct smu_13_0_dpm_table *mem_table =
+				&dpm_context->dpm_tables.uclk_table;
+	struct smu_13_0_dpm_table *soc_table =
+				&dpm_context->dpm_tables.soc_table;
+	struct smu_13_0_dpm_table *vclk_table =
+				&dpm_context->dpm_tables.vclk_table;
+	struct smu_13_0_dpm_table *dclk_table =
+				&dpm_context->dpm_tables.dclk_table;
+	struct smu_13_0_dpm_table *fclk_table =
+				&dpm_context->dpm_tables.fclk_table;
+	struct smu_umd_pstate_table *pstate_table =
+				&smu->pstate_table;
+
+	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+
+	pstate_table->uclk_pstate.min = mem_table->min;
+	pstate_table->uclk_pstate.peak = mem_table->max;
+
+	pstate_table->socclk_pstate.min = soc_table->min;
+	pstate_table->socclk_pstate.peak = soc_table->max;
+
+	pstate_table->vclk_pstate.min = vclk_table->min;
+	pstate_table->vclk_pstate.peak = vclk_table->max;
+
+	pstate_table->dclk_pstate.min = dclk_table->min;
+	pstate_table->dclk_pstate.peak = dclk_table->max;
+
+	pstate_table->fclk_pstate.min = fclk_table->min;
+	pstate_table->fclk_pstate.peak = fclk_table->max;
+
+	/*
+	 * For now, just use the mininum clock frequency.
+	 * TODO: update them when the real pstate settings available
+	 */
+	pstate_table->gfxclk_pstate.standard = gfx_table->min;
+	pstate_table->uclk_pstate.standard = mem_table->min;
+	pstate_table->socclk_pstate.standard = soc_table->min;
+	pstate_table->vclk_pstate.standard = vclk_table->min;
+	pstate_table->dclk_pstate.standard = dclk_table->min;
+	pstate_table->fclk_pstate.standard = fclk_table->min;
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1246,6 +1297,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.init_pptable_microcode = smu_v13_0_init_pptable_microcode,
+	.populate_umd_state_clk = smu_v13_0_7_populate_umd_state_clk,
 	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.read_sensor = smu_v13_0_7_read_sensor,
-- 
2.35.1

