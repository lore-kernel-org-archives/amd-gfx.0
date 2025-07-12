Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D468C83F10
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Jul 2025 04:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804B410E154;
	Sat, 12 Jul 2025 04:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4B3dda7a";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7924E10E154
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Jul 2025 04:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKLnYfVmnHc/o5qHn6ClkBfiKDffO28RxsVRJEeciw4FHc6+VpfP9Hh9/MuWeNRA/+Zxe47J+8jE6FRmH2/jeWutPKQsMOUZhYpHgsGjEuhuvLFDBibIw0almHq3tpkx7FaKf/sQjdK/ektC586si3DnZrcR08F+8uYv7TFrTS5CdrkRUoZGivNXpSvlvXmxNY1KytA/HaZ9da5Ey4mD+apCpdv3/uQUD6IalNYutNZWsFJK3aFqUKwwsqRW141AMzEi9ETSSn/RbpdhNBF48JUAdmm1RzPKX2f6SO54tGiw/GrctWjkJbzgY5kopKwjVdTJrcgAJuCEdXlWm9jaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVb9e6JBYWuKKhB5+MkQzab9lLLSOFBx+upmMI8eF+I=;
 b=qT8Kqveea36K6E6xGN0U5pWgHyuOhXk/SpTQ/aR/Ze+5CV0MHE1zZUpVfHx/ErNx6WUvsotPJoxsHd7D7fIx6OHv6gFgk7nUpDY9yUHgLLp6irxzI0LiCJsG9GDok1XukPCwC3P5JyHF5pTR7A1oeAl2lL9+o2r9nOjc9Vqf6UdUlWHYOp8GaXRWfmBT7h0nbFjKZS1RS4hpNdX0DJ//DBar7XlbJu1IQL6CVCf3ErIycmLsRlsgG8+TGllhvGWNjrD7VLZTgnZY/pB9Xmf1reZCL1+vtNkT12rOUo89hfjWVFPXWjCi0/EbSZjJFr13n59tmCZEWhWk2ZTvo63e5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVb9e6JBYWuKKhB5+MkQzab9lLLSOFBx+upmMI8eF+I=;
 b=4B3dda7at++BwJtQzt72NhLRy0Tl+5muI6v+lIyHrZ8ZmfoF7OJ8df8O9nwnDCoakpu53yRxC2PCNHpisr/BERr4rmOkiE3YIVLAoP53BKKXR3B0HMnHh9HSxtwnylBK/tJqhuTGjsQvkvKzk5MFUdkZXSgmIV6nasA8QcpoK5I=
Received: from BN9PR03CA0371.namprd03.prod.outlook.com (2603:10b6:408:f7::16)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Sat, 12 Jul
 2025 04:28:32 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::3b) by BN9PR03CA0371.outlook.office365.com
 (2603:10b6:408:f7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Sat,
 12 Jul 2025 04:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sat, 12 Jul 2025 04:28:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 23:28:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use cached data for min/max clocks
Date: Sat, 12 Jul 2025 09:58:11 +0530
Message-ID: <20250712042811.1495850-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 002d63c3-2a0f-4ecb-73f4-08ddc0fc8ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LOnU1wf+klVxUmRy7XgDe2ImnjkGfvmu9j7XwvGjmXKUeNW4zGmY9ac97+v8?=
 =?us-ascii?Q?TuKUL1N+jbZbXXi4VdbrAjS4Jj26XAxdcMD3aYZPxx+P8JuLU6iAj7mL+U6K?=
 =?us-ascii?Q?6zQBaZdME9eknD/lfrhg2FnA9fFzsCjeRrU/qUKTgZWiWWhmjfrGmTmNnAx8?=
 =?us-ascii?Q?vghMG3J1dyYsDfI7B2bj6//bOfAsB/gZ4o9KJ0KfETKNUmIhBQrKadBFsQyV?=
 =?us-ascii?Q?eL4atE8AgokjmW+OFkd9YnslzwKVAi7t23faUOYLi3RiYEcGnGXq21JfX1YW?=
 =?us-ascii?Q?8LxQVnNWGwqp+kaoSK2c1Mytis23C+fj3uFjvs8k30sdRjJHCoXQkS9sCSzq?=
 =?us-ascii?Q?7N7M0dTeC0EJ6eVoHklphJsdKZGMcQ98NoSkGyT8f5M8rRAdYDGW5hQVcvhp?=
 =?us-ascii?Q?nfP+SBFMvFFDvtfLfKtT/fLLlD1S66dkAuh44rtR2rlwVk2rrvNVC8gyUDKl?=
 =?us-ascii?Q?vK6gGiwDpzQrpT+5Ru9oJQ0hlhhrLM+0CeQqA02WkojVBAjXN1GAcoZ/DQbg?=
 =?us-ascii?Q?bGZpenPJU/vbD273zKr2nxxHP9l/FnHrImzj33EA+OwI/MlI1uZW3IIb23Jl?=
 =?us-ascii?Q?7Ye9xX0uzIs4vBxNHDWHoMJliY5yXULmKblUZ2IdP02Sc9qBhk9eN/Mz8bEw?=
 =?us-ascii?Q?lxbXi83UIBO1BlzzfjOVt/Sd1wdHUj5glFhApkXxBRGZp4X+zRgDryRsC2Fb?=
 =?us-ascii?Q?xT3pL3Fog1y/SkwD+Z2VYxseFAbSF0py4FLJImClDZhWwAQ3+gpvyw9Xk3FA?=
 =?us-ascii?Q?atBbK4Lg/kSRRcNPiyCnepCXsnuDGfnGLxjp4kBlkvDSWQyAhJaLSCHxVs02?=
 =?us-ascii?Q?llGvedtBuPQz3u8o4GvyPMwK7/rdbAuX+t64DzEx5x/mkTvP28A2PWEAC1aV?=
 =?us-ascii?Q?twtPOW4Hu7r/8L85bLq3To5/VkiskLUY+Pm4XUVwR0ZbxWsLLB1LQe6JACCe?=
 =?us-ascii?Q?IjcfATjsL90JhZ3Exp2xCxvklu5qj2imO7uXoKrBUvs5YMpZKWm/jtR05XAh?=
 =?us-ascii?Q?5noGK/K7J0WCkj1Hys+YlROG/Z7I2Sjp8nSKY0qIY7EHu7whAib1utuK+qTt?=
 =?us-ascii?Q?oBsTK0we4OZCYRsPQXG1krUCNc+rPdbiPzDvVFTbeLkosz1LOYbiS0zUxC0v?=
 =?us-ascii?Q?iSTbyYHB2lHUwpESnE/U4VK5cfCZpFLxYu06ruWzf6C5gG88k7qDUY6dA1dJ?=
 =?us-ascii?Q?+gC4MARM9ZTW8vovU0/EWTnoa9gkJkb5kByAjL8auBrcXUl5gAMJ8GJGIM/3?=
 =?us-ascii?Q?7tdmNZ4Sxz2EfNtsohyFHDO+DM//1D45Bo3vgbPAnbc/1KB94ZTHC/4fUQDs?=
 =?us-ascii?Q?eT1EJaSSqPoRuGJKFnwnDXkedKET5WW37xgVdAcirKasiqCQUX1USKlSfn/R?=
 =?us-ascii?Q?euzezoBtb58sv0wTP2lloVOc5l7gTqy6gPi1iZeHNoqj37NSHI85mNyoPKes?=
 =?us-ascii?Q?xwnwyzlsatFk0wexsfA+PJ0+lK63KDJTbyzb4KtTcNr+Aax7/7FXI9LGj/Ai?=
 =?us-ascii?Q?zqYHHjs2Gq5FBCsBsQIdyG9Dy6+X04UCtFM+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 04:28:31.5633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002d63c3-2a0f-4ecb-73f4-08ddc0fc8ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
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

If dpm tables are already populated on SMU v13.0.6 SOCs, use the cached
data. Otherwise, fetch values from firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 68624afe7d83..3d092fcd77b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -881,51 +881,51 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 					     enum smu_clk_type clk_type,
 					     uint32_t *min, uint32_t *max)
 {
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_13_0_dpm_table *dpm_table = NULL;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	uint32_t clock_limit = 0, param;
+	uint32_t min_clk = 0, max_clk = 0, param;
 	int ret = 0, clk_id = 0;
 
-	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
+	/* Use dpm tables, if data is already fetched */
+	if (pptable->Init) {
 		switch (clk_type) {
 		case SMU_MCLK:
 		case SMU_UCLK:
-			if (pptable->Init)
-				clock_limit = pptable->UclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.uclk_table;
 			break;
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			if (pptable->Init)
-				clock_limit = pptable->MinGfxclkFrequency;
+			dpm_table = &dpm_context->dpm_tables.gfx_table;
 			break;
 		case SMU_SOCCLK:
-			if (pptable->Init)
-				clock_limit = pptable->SocclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.soc_table;
 			break;
 		case SMU_FCLK:
-			if (pptable->Init)
-				clock_limit = pptable->FclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.fclk_table;
 			break;
 		case SMU_VCLK:
-			if (pptable->Init)
-				clock_limit = pptable->VclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.vclk_table;
 			break;
 		case SMU_DCLK:
-			if (pptable->Init)
-				clock_limit = pptable->DclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.dclk_table;
 			break;
 		default:
-			break;
+			return -EINVAL;
 		}
 
-		if (min)
-			*min = clock_limit;
+		min_clk = dpm_table->min;
+		max_clk = dpm_table->max;
 
+		if (min)
+			*min = min_clk;
 		if (max)
-			*max = clock_limit;
+			*max = max_clk;
 
-		return 0;
+		if (min_clk && max_clk)
+			return 0;
 	}
 
 	if (!(clk_type == SMU_GFXCLK || clk_type == SMU_SCLK)) {
-- 
2.49.0

