Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3599FE74ADB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55AA10EB54;
	Tue,  3 Dec 2024 21:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uqwDgKR9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6FC10EB4F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyHBEutrXKyagkkcwRqkUAm0UbjBxxt/DPBCsIiheK/nIleEgQeklg++wD6CT9zKbRWS1JCfzuQSaD4wC1BvNXtbPtcXO4YV2DDsdTfvrNjj0uCFACMuQvRnF6LVxm0PLDtfL19YjUgWy3c0AH/ceMUtvFL4xJhMW93gHUOkNDvi9B8xFJPp8FKn7zcuOemszUqJyT6a6bCnrE/bCI95nuf/CvEPeyIZRZsN/a4sMx5SM9pEDNvue81UvFpAdunSTBbKPUAXrydLY9Cz5nSMEgJgS0OvgDeVtZDb/WqbgfCIqb5tdJIavqDtDb64omF8wx1rKNXx3Ak5CG6DVL18Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YJmAS9aZcKpFU/yOwnCWadxzEWvld5sWGhmYcNUuSo=;
 b=YWhZCm2TZI1N52Yp6r6AQZ7/WJl6fdD1eG0veiM42WKbENOmPiFc8R9V6NTSM1eGBEeWEn6nPTaPQsBo8FIQHtHdjp2NlYXLEnpMFa4u5U3fMriHCM6BW/SFqOLSsmmioWX4bETkF3kd3krQ3VLMkh4ffxKh3bf3i5GbXJigrLe+76Xh3Jne3yiW0FBDKG1y6FMe/pAd3HpYWZn40IQYApLLsJJ5prpXcyAnUfKckI5A9Aupcji9sOWC7diGC5MZrQmD6H8KeB0CddboL3hdkwMYFo1fX0rU2a1KNI4WH5+XfhtV3Bi3isgOXJKnnAGFjTdyIeb4HBRfbLWaJ7jCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YJmAS9aZcKpFU/yOwnCWadxzEWvld5sWGhmYcNUuSo=;
 b=uqwDgKR98ckBeDPiTaLPuy399RIsK3KlCPO9pR52ZsnaRrsd9H4zrK8cfypfhZoKSpyhuSmnbXHNPQdD3kHVlcfzaa1l0uGffI6muG5X7MdRGL0IA2+u/CbdP9JFiNCOC3B/WNiqhokdorsPpmTivcCcu8VVh02pENmv4wGuGxM=
Received: from BLAPR03CA0079.namprd03.prod.outlook.com (2603:10b6:208:329::24)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:24 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::b5) by BLAPR03CA0079.outlook.office365.com
 (2603:10b6:208:329::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 21:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:23 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:23 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:22 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Joshua
 Aberback" <joshua.aberback@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 03/19] drm/amd/display: Refactor dcn31_panel_construct to
 avoid assert
Date: Tue, 3 Dec 2024 16:39:41 -0500
Message-ID: <20241203214120.1161810-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 33de139c-ecf4-4d7e-3019-08dd13e33bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ex+xO+LAMpKQ8sV95pKPueqSar9vbD70NwRjTAqs723bSOMaglaLGIb//Qqf?=
 =?us-ascii?Q?MavCy8TrEORCo4oGbhAqitm9sp5VQ0M+XlF/5WslzykTNQ2ogDElYSLrHINH?=
 =?us-ascii?Q?iXW48WDDU+XiJ4MubXn8rvzboo+VsCjMzy9Zs6P2CMMAQrR4y33jr2zbvoKO?=
 =?us-ascii?Q?LY5Q4uDYfh4Ew4yNV8m9GkIDg+14LBkQbHLA4e/aHikxGJUBZAnwegft8ABK?=
 =?us-ascii?Q?FJbu4BzRBRv+9ZyAtQTwjeJprfFTM1hqLeBWT/mlrfNBKNTxiKBT2MjG4u6f?=
 =?us-ascii?Q?9rCJFSkkFikP4qlii593BerrDTu80vIilqsHiYVmH7yjFFp8JWxltwC3HPUp?=
 =?us-ascii?Q?FnHzx0+4/GJD7p9SnBh3WDv6a3p4FZjmxFlgyjUfBuVSGLfFao5LtQwiyD3G?=
 =?us-ascii?Q?wcmhw7zrP8B9E6Y3rcItw8llXwz63aI/3UPagedf5IFsAU21pBofyXb8Bib0?=
 =?us-ascii?Q?JTQ5GTRZElvfQeUhD/4WY0h2HCu+UI1VLe26Sa4aLu1QN2Cxn12oPjbkc+OP?=
 =?us-ascii?Q?BfztnjMlQI4y1BWFVYw+9mEKwHuimDyl4HH0n4JWXBNd5vn+YASOhspxj7dH?=
 =?us-ascii?Q?T+vF0ybaijTJhx9y4Bp/zNpTk/YuqGYJabmkreBObO1V9nCJK6Q2MofkLWW9?=
 =?us-ascii?Q?qIZNKVbU6GXh2fzit+1HQGjsTYswtv8pWRqiDnkrbLdRbiiYy/m/jizd97UD?=
 =?us-ascii?Q?xj4Kep2MFfv7XcRXTqblo2aAuk8XP18unT6mqt+g+SmLtVysA/1lbE69+9JL?=
 =?us-ascii?Q?OfF3Nd5DVbxqqv1vfP5D8FbmRVlVvQGaUXNnw96v/u2VP+O/zsl9GKP6BcuM?=
 =?us-ascii?Q?IV713PBFA/I7cUVlje1DzJpVYiBuPWDdxpfqofOE3EZDyDwfaU+DXkiIKpB+?=
 =?us-ascii?Q?Qs6KSGQv5xQHuV/etgpTun+m3C9Z93/wuNgkErlpRSNavHmM0HB69VHlQ7mD?=
 =?us-ascii?Q?c9xRzsvPer0rOH9cEFv9O7GNUNljh2HxR5x9M+ofpmH+7kNLmrua1ZtrjRtp?=
 =?us-ascii?Q?gm/s97SBQHkyJYndv3aJ1V8ZG1CQXNVJeP7XwTko4OKSBM95LmttaZtdahcw?=
 =?us-ascii?Q?O8MUnW6C4Z5zvOKxDvDFL4+NdEniI2rY5ZHOISROO8tHRGIcLTFLqG8lyR6l?=
 =?us-ascii?Q?7CF9mw4HOuo8XySNDwi27XBp85EqaZR1QAZtsL/3YbKFK+bo5rRGjeF57fzX?=
 =?us-ascii?Q?sdxYjDlj6yqF4pex1SxwK7yGdjSNt5lkuTABUXf4UIL01MEA76aG2xG0XvRR?=
 =?us-ascii?Q?KST5xd5P4j0CCnuy/d2yBXj4M9VldjJM6B92EIdhyua4XFzEIU3Drc9il11C?=
 =?us-ascii?Q?yV5aoaCLblBSsOLiBmwQBmUgkfjFVM8OTwChvh8RMYL7ZE+UfSTB1tgO2H34?=
 =?us-ascii?Q?CcCDuGvL0Sdx+RBcvmdT46s5qntwVq8I3gHqNG6R+LrBYXGiHy+oSBi8tk7w?=
 =?us-ascii?Q?SAdh9DQBJzqaJ2jyOVRDI+fJNyRuCTWl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:24.0085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33de139c-ecf4-4d7e-3019-08dd13e33bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
We want to avoid unnecessary asserts, one of which is hit in
dcn31_panel_construct when booting on a DCN32 asic that has an eDP
connector on a different DIG than A or B. The DIG-based mapping only
applies when edp0_on_dp1 is supported, therefore the check for valid
eng_id can be moved within the appropriate section of the if statement.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 34 ++++++++++---------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 573898984726..f9961a6446f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -168,31 +168,33 @@ void dcn31_panel_cntl_construct(
 	struct dcn31_panel_cntl *dcn31_panel_cntl,
 	const struct panel_cntl_init_data *init_data)
 {
-	uint8_t pwrseq_inst = 0xF;
 
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
 
-	switch (init_data->eng_id) {
-	case ENGINE_ID_DIGA:
-		pwrseq_inst = 0;
-		break;
-	case ENGINE_ID_DIGB:
-		pwrseq_inst = 1;
-		break;
-	default:
-		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", init_data->eng_id);
-		ASSERT(false);
-		break;
-	}
-
-	if (dcn31_panel_cntl->base.ctx->dc->config.support_edp0_on_dp1)
+	if (dcn31_panel_cntl->base.ctx->dc->config.support_edp0_on_dp1) {
 		//If supported, power sequencer mapping shall follow the DIG instance
+		uint8_t pwrseq_inst = 0xF;
+
+		switch (init_data->eng_id) {
+		case ENGINE_ID_DIGA:
+			pwrseq_inst = 0;
+			break;
+		case ENGINE_ID_DIGB:
+			pwrseq_inst = 1;
+			break;
+		default:
+			DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", init_data->eng_id);
+			ASSERT(false);
+			break;
+		}
+
 		dcn31_panel_cntl->base.pwrseq_inst = pwrseq_inst;
-	else
+	} else {
 		/* If not supported, pwrseq will be assigned in order,
 		 * so first pwrseq will be assigned to first panel instance (legacy behavior)
 		 */
 		dcn31_panel_cntl->base.pwrseq_inst = dcn31_panel_cntl->base.inst;
+	}
 }
-- 
2.47.1

