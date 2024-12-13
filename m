Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8478AE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E4810F075;
	Fri, 13 Dec 2024 15:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xVlXZ6+O";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6AC10F075
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3t80nB9hjkNtZN6Z+7BTm8KUE7wu6ICD51uzCP/qMGvU8t01lXIDlKSaMUE19PC9Ap34Jr+67da+OPVwXVu5+8NR8KvXhh7OBuT/HZT1Ny2QWUPoT5ynr97zsPbWuZEU+CS0I7ldVH8+6r0P49aXDCLaqTPUALLrMfSoWQhgcRu2a+/5eArjDxL15NAynoBRasKzz1FHiUhHuY8YjJZ+ZRvr3/dFGQAd3XsqZqi0fERn3mE56G6D45cFOaG55Q/9yV8F96OvH0TCMK9MLDM7UBsL2S4H0pb7zgRrpHHu2kBLpoXP4dhVD6jfUu9ysQXWXMtm7txFuE2qKWCTpGGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4YSgGB3usQxrFx1TQZGpDAbut6VuK4savmrDSKpeLY=;
 b=nrXTjPX+eILp6EyiLNEQDabw2fXB1FD9KnAd+YzxqF3QflL6WgTgVHuwrGLOxA85lKEukIRmPKlul5bENvXUjUWdfnkcDul15IqZA7i0pWL/9jIC4Hjopo+y4GuedYGDQ8r+Q6kMidqxWo4QTe55CdUr1vMaaP36B++tpjjMoHHjL7pYWUYqcT3jLOme3msglM0L1Fqd16bYtR4as2w5vKln1SjJKnH/GrPy2VmNJKzskIEe3aM2krvQyDYq0u022kpbreXSfwc1EcwBDsqV5jSSmkRklPaGTMNBDF6MQOL03HkJ6JUA1KYnJ99e5Asg778zTE58uZIVJ07Yo+g3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4YSgGB3usQxrFx1TQZGpDAbut6VuK4savmrDSKpeLY=;
 b=xVlXZ6+OzcF+EruWaWNwChxpiEycul1/Zeldhu62egu6ZzJSkDFyPCsUfeZsRXEIOp+LDdNSTwmjQlm2B0bOs/vvBCmdAlRLQnHHeJo6vp58M1XMAxx8CJn2z6JvolHMmUmeKckEDDfGvzKt71Jq5pWe1luLCWHm0ei6qgm1FAI=
Received: from DS7PR03CA0255.namprd03.prod.outlook.com (2603:10b6:5:3b3::20)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:55:02 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::75) by DS7PR03CA0255.outlook.office365.com
 (2603:10b6:5:3b3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:02 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:59 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/17] drm/amd/display: Apply (some) policy for DML2
 formulation on DCN35/DCN351
Date: Fri, 13 Dec 2024 08:52:42 -0700
Message-ID: <20241213155405.393252-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bc0410-ae15-44bc-33f6-08dd1b8e8172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gxcEjrrj09nz3BEBapejJ8PdLkdt7hkxx1jO5FSb3zBCwJNc4/J9IKm5AmTv?=
 =?us-ascii?Q?mgDAe6bbOzYQGto7WA4gRfGFXcLv8PydR0Ojf3ejn4zvZtJmIhMvSOllWEb9?=
 =?us-ascii?Q?GX/r4rjfLG9B4NLhhVf96pbeAwXPYdNCK0/3UXmLP58OFGi1Hm7Op34LPKM9?=
 =?us-ascii?Q?L+a15tWERhjVIscPBdQYsx9/ZGrY1D/ap2g+TB7RHTi33vq+i8hDlbyLimxt?=
 =?us-ascii?Q?yt0Tnbcwh1bEVha/a4HbAI4NRAEMolN+/3P75VW70n1ixtWo4AvI+R9mkKCr?=
 =?us-ascii?Q?RQi4ZknEKR1t6qVubpL3/jUAlh4ErGVoGnj/HPDCCvqAlaSmKL8a8MrNkApW?=
 =?us-ascii?Q?V8+6aYuQ/S7F4y5BZ5PW/lthG2K9zSM9fuw2dbvlPgS8eSMKP9NrC27DVGo0?=
 =?us-ascii?Q?vQT3qECNS9VVok0KKImsbInDrPGV8zY56cf8P+iddnpUoqbzOQi7hn4yEcuD?=
 =?us-ascii?Q?U+XYAEWTcCFRwGJyrkzH5WkzJbY3dDUba3OEf5lF8tIDlfhcQkkqr+r0EIyw?=
 =?us-ascii?Q?S1tZM6juaMUdSxN2aPmfAl23bmpEwg17zT2h/QRyaqyQgcUfQ4E4P6xEU6/p?=
 =?us-ascii?Q?+JVW0bqyUmcPBE8chCJB6vLF+9EERDojQFnZI1czI+uOiTjuY3ANLDoW/mFR?=
 =?us-ascii?Q?VkcxHdg2Tjvjl6gQ+hvdWP9dO/uXboCSAn2TUEoI4T+sNZnFNsIHVnMdgHFE?=
 =?us-ascii?Q?cEU0T42sd3O4Z3GvQa4fn0aykgFiqxWASo0M48dOauQNov4CaXjo/DvmikOC?=
 =?us-ascii?Q?io292T4lYgGbeCvcm+hm2vs0zhvYZo6Hd+XDuzIOlFa9HvWr0ugKFaxiqZIh?=
 =?us-ascii?Q?bgGNyp2Qop5AiDuHGnC2UicCatCu867Xlu5e9KkDAykbheQbSCXxvt3XcvXF?=
 =?us-ascii?Q?y6bKA7azv5lB+lUyWuD8Eh2pFLvvKcP5la2roIkQdp1djC3SNhFOfnJJey4u?=
 =?us-ascii?Q?OcQ/VYFw2KUJZG0iHErtm6et/yntQPqlIIVZJqgd/09BVMd+Fz/Gx53DAtJL?=
 =?us-ascii?Q?pK9fc4AtE36GwGN+RMPTDrqQcf8c3LFwfqbZbmGqamK0t9qzr0MTuO8hvppb?=
 =?us-ascii?Q?VOrJtuwIx6yj8J8/BbweJsyc2xUSU+NhkJ5enQVD7EyHtg/wKycHN/BaTssh?=
 =?us-ascii?Q?B4kvH/eYi7wOvO3iwJEsJ+yRwgWUfo3SPjZNFI9PGJHZKWaPpY6OEzNyjQNi?=
 =?us-ascii?Q?e8L/TNrB8j0WRUxFzfdnPLE3w8vMDIPVSlcAH+Zb11SHt+7xoEVUk1MHACFw?=
 =?us-ascii?Q?pDrTHn7ds9qjBTXNvMBth0GPfxQhxvk5hRe87f49NsLEpQA1YutXTE/gmkPW?=
 =?us-ascii?Q?Mg/Uh53u3dz0ySBRZvtUs5tQb+ip872grvS8vXfLCa/GdTT5rp3Yp/fccD1D?=
 =?us-ascii?Q?p8fKGrN5VP0NNjJZ9SQnJl5GEB25LLHBlPk2Ff/SEvYVEVqUM60gakBqhDuf?=
 =?us-ascii?Q?U0/UuwZ/6J0naIg2cF6UPuaRVPoDFKgl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:02.6279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bc0410-ae15-44bc-33f6-08dd1b8e8172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Dropping the entirety of dml2_policy_build_synthetic_soc_states exposes
an issue for states that cannot be filled via bbox_overrides and rely on
the default parameters that may or may not be present depending on the
DM.

For amdgpu_dm this results in missing parameters for most of the struct
in higher states:

- sr_exit_time_us
- sr_enter_plus_exit_time_us
- sr_exit_z8_time_us
- sr_enter_plus_exit_z8_time_us
- urgent_latency_pixel_data_only_us
- urgent_latency_pixel_mixed_with_vm_data_us
- urgent_latency_vm_data_only_us
- dram_clock_change_latency_us
- fclk_change_latency_us
- usr_retraining_latency_us
- writeback_latency_us
- urgent_latency_adjustment_fabric_clock_component_us
- urgent_latency_adjustment_fabric_clock_reference_mhz
- dscclk_mhz
- phyclk_mhz
- phyclk_d18_mhz
- phyclk_d32_mhz
- use_ideal_dram_bw_strobe

[How]
Copy from the first state, applying a minimal policy to set max clocks
for SOC independent values.

Then copy the SOC dependent ones from the states modified by
bbox_overrides.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c | 54 ++++++++++++++++---
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index bde4250853b1..b416320873e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -553,13 +553,53 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		}
 	}
 
-	dml2_policy_build_synthetic_soc_states(s, p);
-	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35) {
-		// Override last out_state with data from last in_state
-		// This will ensure that out_state contains max fclk
-		memcpy(&p->out_states->state_array[p->out_states->num_states - 1],
-				&p->in_states->state_array[p->in_states->num_states - 1],
-				sizeof(struct soc_state_bounding_box_st));
+	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35 ||
+	    dml2->v20.dml_core_ctx.project == dml_project_dcn351) {
+		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0,
+			max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0, max_socclk_mhz = 0;
+
+		for (i = 0; i < p->in_states->num_states; i++) {
+			if (p->in_states->state_array[i].dcfclk_mhz > max_dcfclk_mhz)
+				max_dcfclk_mhz = (int)p->in_states->state_array[i].dcfclk_mhz;
+			if (p->in_states->state_array[i].fabricclk_mhz > max_fclk_mhz)
+				max_fclk_mhz = (int)p->in_states->state_array[i].fabricclk_mhz;
+			if (p->in_states->state_array[i].socclk_mhz > max_socclk_mhz)
+				max_socclk_mhz = (int)p->in_states->state_array[i].socclk_mhz;
+			if (p->in_states->state_array[i].dram_speed_mts > max_uclk_mhz)
+				max_uclk_mhz = (int)p->in_states->state_array[i].dram_speed_mts;
+			if (p->in_states->state_array[i].dispclk_mhz > max_dispclk_mhz)
+				max_dispclk_mhz = (int)p->in_states->state_array[i].dispclk_mhz;
+			if (p->in_states->state_array[i].dppclk_mhz > max_dppclk_mhz)
+				max_dppclk_mhz = (int)p->in_states->state_array[i].dppclk_mhz;
+			if (p->in_states->state_array[i].phyclk_mhz > max_phyclk_mhz)
+				max_phyclk_mhz = (int)p->in_states->state_array[i].phyclk_mhz;
+			if (p->in_states->state_array[i].dtbclk_mhz > max_dtbclk_mhz)
+				max_dtbclk_mhz = (int)p->in_states->state_array[i].dtbclk_mhz;
+		}
+
+		for (i = 0; i < p->in_states->num_states; i++) {
+			/* Independent states - including base (unlisted) parameters from state 0. */
+			p->out_states->state_array[i] = p->in_states->state_array[0];
+
+			p->out_states->state_array[i].dispclk_mhz = max_dispclk_mhz;
+			p->out_states->state_array[i].dppclk_mhz = max_dppclk_mhz;
+			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
+			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
+
+			p->out_states->state_array[i].dscclk_mhz = max_dispclk_mhz / 3.0;
+			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
+			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
+
+			/* Dependent states. */
+			p->out_states->state_array[i].dram_speed_mts = p->in_states->state_array[i].dram_speed_mts;
+			p->out_states->state_array[i].fabricclk_mhz = p->in_states->state_array[i].fabricclk_mhz;
+			p->out_states->state_array[i].socclk_mhz = p->in_states->state_array[i].socclk_mhz;
+			p->out_states->state_array[i].dcfclk_mhz = p->in_states->state_array[i].dcfclk_mhz;
+		}
+
+		p->out_states->num_states = p->in_states->num_states;
+	} else {
+		dml2_policy_build_synthetic_soc_states(s, p);
 	}
 }
 
-- 
2.45.2

