Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F66EB64D9
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 02:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E0F10E069;
	Sat,  8 Jul 2023 02:26:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1730B10E069
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 02:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVvIF1Si+V67F02DNNbqdr1D+c2AwWKVJHNFKLAVeTqGHAp4h2KUQUPOUPta5pmTaZIoGigkcjyQjPRquHW+bQlpxr4THORvoDTurGK6nFeeI800BEhFWgK2WJlT9K+Sni9Y0NgorxYVFs1y9obtfljEjQk0E7SpAZi8mXvsZhBBoSAMpmcZiLMnF/rf1+7Wyng5uzO/q35oJh1ko8VM6ghU06I+pOPbSOp+B2lqWmXzfr+/N8koLsk/xtMFKd0j7z2ILD9S90qkx95jsMf6731opvHhEQgMK6mfT8xPRykK+icGJrbZThpaXugW1s9NHzwCglucSWLPi6vI+iKN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dlo9/IGLPODfSQ1yRW2SEafZfcI8L75zTL8tlnHHiE=;
 b=RqXcmmpaEJKDKNqCZxF2jrgtyBzxfE1COf/xA/1vKRUICZYY0a9sk2xScYLdOLJWLLFt5SeVpwUJEkCzyNcim+8JbXcLKgO0ZwhnhmnEaZDHPSCWe+UM/4nOUeWpnxklWE34HLr/DAGy/lVQJwH/juv5oeYvR5bQ/8GKqnAlTYLtb1evfScrBBHKNwJIRTWbeSccF6IqH1csrYxRdxAgs45AsHQk+hs6aR6KRWGwkbQfCXuiM1Vd8F9vgNjbu3UQeF/bVxrhHq2hZjlsa9jy6/bDvovZIjtX5H4DF198c9rHzOY34LUBSShtZecHxxY6bTIDZVozIjB+w+ZbhXeuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dlo9/IGLPODfSQ1yRW2SEafZfcI8L75zTL8tlnHHiE=;
 b=lm6cIBjnu5tXT8ARnScwkifXD8v8y5k8aszQ/Ovazz9OYnNoZHN3UhtoN93WaCtvSvOeaLlPD2l2HLvXz131zfLuJ4eZWvKfTCzHPFCO5u2eGzLueX1W9nV0qvTwfgjpSF30rXuYC8xk/uxUOh8If/5BApaKjuD6FwacQwek8sQ=
Received: from BN9PR03CA0969.namprd03.prod.outlook.com (2603:10b6:408:109::14)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 02:26:34 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::65) by BN9PR03CA0969.outlook.office365.com
 (2603:10b6:408:109::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Sat, 8 Jul 2023 02:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Sat, 8 Jul 2023 02:26:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 21:26:33 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters
 implementation with SMU13
Date: Fri, 7 Jul 2023 21:26:09 -0500
Message-ID: <20230708022611.50512-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230708022611.50512-1-mario.limonciello@amd.com>
References: <20230708022611.50512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 9667eaf9-fabc-48b0-9db3-08db7f5abfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mS2k/IXEZFY52eVkW933lh83d3x4H3sU3aeT/QdBE0VdYnl+dxP94AQ13kpgucDJ+O7wOFClcBZWnSjb0b2egta47YFjPHx58K8iji+OF6+fzYXWoY8yukhgElopEAC4Wp60LZ7Uq487+0ERHlED73qiEHlIrIWWsrBsWxdLQaTK23NjrId9lyNecQDGKZBleuLSFkHvJlX5ruHcHa+sZa6Uo7m1Z1SsBzQtcZrdQl39HDECTOwnANUTIui+yJjegDi3G2uAKf4vtRFCN1Z1JYVx7D9OWGqh2KC+JEewg4n71dYsDoRks91CZZnpe+sIJvnF0A707gKbmvV/JxIKCmOX8DgT0j9DkOtd3LhjzcXKErtYUCbgrtlZ2OFEfhWTSXfEAVgjhFWjgtMJGJsx6imkN41sVgtx8NUqY+iKUIMwzSgxci2CMPxkwXudt5q79LCiU37HzceAs/dp+GuMAN6mqyvYCcCVAax3w58awMgfCFNyaw3q4tFA1jtpyr2LUypHK27b4YsA7v7E5YHwxpcqFVRM3/8L6mvec59Ai4mOJbmpKrwa1whNkmEbMir4gOfOomXUnHiBaWx7SDB6JVCTA0qJ4th8WrT5Ln8tfoWU+DyrvcUZAvHQg67bL+FF3JkeodX3KgaeLH2o8g3cvoRftMQFfalBp94/eyHXlwvC2Xv2g9BuvQXcGOh1GROEofiRRR5xCaPQ1J7zkrh35MD3GjZ0v/ZydRerUiQRNPL8V7Y8tFijwlsyTUgnm1pmvGYPRvY55BKJJ9ylGtKxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(2906002)(478600001)(6666004)(54906003)(8676002)(44832011)(36756003)(4326008)(6916009)(8936002)(316002)(41300700001)(70206006)(70586007)(336012)(426003)(47076005)(83380400001)(82740400003)(81166007)(356005)(40460700003)(36860700001)(86362001)(1076003)(7696005)(5660300002)(16526019)(186003)(40480700001)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 02:26:34.1634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9667eaf9-fabc-48b0-9db3-08db7f5abfa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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
Cc: Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU13 overrides dynamic PCIe lane width and dynamic speed by when on
certain hosts. commit 87c617c72628 ("drm/amd/pm: conditionally disable
pcie lane switching for some sienna_cichlid SKUs") worked around this
issue by setting up certain SKUs to set up certain limits, but the same
fundamental problem with those hosts affects all SMU11 implmentations
as well, so align the SMU11 and SMU13 driver handling.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 89 ++++---------------
 1 file changed, 18 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 8fe2e1716da4..f6599c00a6fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2077,89 +2077,36 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
-static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
-						      uint32_t *gen_speed_override,
-						      uint32_t *lane_width_override)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	*gen_speed_override = 0xff;
-	*lane_width_override = 0xff;
-
-	switch (adev->pdev->device) {
-	case 0x73A0:
-	case 0x73A1:
-	case 0x73A2:
-	case 0x73A3:
-	case 0x73AB:
-	case 0x73AE:
-		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
-		*lane_width_override = 6;
-		break;
-	case 0x73E0:
-	case 0x73E1:
-	case 0x73E3:
-		*lane_width_override = 4;
-		break;
-	case 0x7420:
-	case 0x7421:
-	case 0x7422:
-	case 0x7423:
-	case 0x7424:
-		*lane_width_override = 3;
-		break;
-	default:
-		break;
-	}
-}
-
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
-
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
-	uint32_t gen_speed_override, lane_width_override;
-	uint8_t *table_member1, *table_member2;
-	uint32_t min_gen_speed, max_gen_speed;
-	uint32_t min_lane_width, max_lane_width;
-	uint32_t smu_pcie_arg;
+	u32 smu_pcie_arg;
 	int ret, i;
 
-	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
-	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
-
-	sienna_cichlid_get_override_pcie_settings(smu,
-						  &gen_speed_override,
-						  &lane_width_override);
+	/* PCIE gen speed and lane width override */
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
 
-	/* PCIE gen speed override */
-	if (gen_speed_override != 0xff) {
-		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
-		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
-	} else {
-		min_gen_speed = MAX(0, table_member1[0]);
-		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
-		min_gen_speed = min_gen_speed > max_gen_speed ?
-				max_gen_speed : min_gen_speed;
-	}
-	pcie_table->pcie_gen[0] = min_gen_speed;
-	pcie_table->pcie_gen[1] = max_gen_speed;
+		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
 
-	/* PCIE lane width override */
-	if (lane_width_override != 0xff) {
-		min_lane_width = MIN(pcie_width_cap, lane_width_override);
-		max_lane_width = MIN(pcie_width_cap, lane_width_override);
+		/* Force all levels to use the same settings */
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	} else {
-		min_lane_width = MAX(1, table_member2[0]);
-		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
-		min_lane_width = min_lane_width > max_lane_width ?
-				 max_lane_width : min_lane_width;
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	}
-	pcie_table->pcie_lane[0] = min_lane_width;
-	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16 |
-- 
2.34.1

