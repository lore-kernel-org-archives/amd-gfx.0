Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD37E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A5810EB84;
	Tue,  3 Dec 2024 21:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXzZjlT0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F106B10EB89
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9DBjawbP4DuS92OtcXt3UmgtpukNN7PVxkRvMso8yi/BA4lNiczKukBvvMiKMapAIJW9obyeA15g/NfrK2s72DSypmBJXYvJZLs5O3kg6esCS8pWvBuCUPcSm/p7C6NREFr3dpYcE7n4Zad32IYliNWIt3vr+HuXMfAvehNk26PmmEJd6obUIfxyHf4ERQqIehtVaCNr5Vs6dAj+yLIrtSGobQfU3+Cw5YuMRkk8rJ8n31rmY6rQ5CPZFn2jg02sgf8dv1q16dyCI4DrOJlWICkcfzIcKm6WPGSpeCOv8SwuHB2ixRolpiJLIIoEfqBT0jElo2qs/Ih17wgBGGiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85lgA8ADp3UQnE0OaclieK/Kqn3f98qgPUYffZmLyco=;
 b=gVN5a5r20uNqidmIII25OI7OojKE7Z71OL7TjwLtC1FrQU95cbVEZmjK6LKe0hnUGywmKzpQDKETysyx7zIXwCt4U0kDUhwZTV2EuXRZ06Ob0o/XbIAaQL85Z5kcJsihFT9Q3t8673R2MEzbHhIJLhZSngFRsmqrVSL10aGXCJrnUDTNyJ5Hh5GZbPuncUN5dUJTyoTK5bpPlokUAqHjU5rOkA4HVDouhkZP0t0BBuWjLNQoO+cz6US5jeQq9V7ENAJS3mRh8BR6u1Fbq5jKbF7oHD3/C+32VCADcYyh2JBY0ab0exyOgX8rCGDM2D5yHZw+DHxY6E4XqdG2wObCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85lgA8ADp3UQnE0OaclieK/Kqn3f98qgPUYffZmLyco=;
 b=cXzZjlT0JluXw2JGlYHbrRiGxErVf7+QWniaSEqQy350YsCmY36rHIdPVWqZzX+W0ExPk7WbDBKVUe8hQjk8jOe6f6JQcQK3fJdIBZlQz2wwNIabO6E3LZhG6Qi/PMhLyrXBx1mXtYYODjgq/SW7KVQJ2/pquGVAnc5uuKGvBlk=
Received: from BN9PR03CA0360.namprd03.prod.outlook.com (2603:10b6:408:f6::35)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 21:41:49 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::10) by BN9PR03CA0360.outlook.office365.com
 (2603:10b6:408:f6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:46 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:46 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, 
 Yihan Zhu <yihan.zhu@amd.com>
Subject: [PATCH 15/19] drm/amd/display: Fix DML2 out_states to match in_states
 for DCN35/DCN351
Date: Tue, 3 Dec 2024 16:39:53 -0500
Message-ID: <20241203214120.1161810-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a7ace2-0cd3-4da7-e38f-08dd13e34aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oPSJGgBia9k8pC437c0tInm40vHCTUyQuAntvDi+4t/MWfpK6KeO9wqzJw1B?=
 =?us-ascii?Q?XeLdA7gWehH5hvcuMjtwyZUDejXoDnhZV6YoIpLtfRwc6ISeBbxn46BHPOiY?=
 =?us-ascii?Q?c1MdkpZ+HEoUjjvGEd+Rb30nSffZXPPw1BhWHH7ygoQrSzynNt35p3T78J+9?=
 =?us-ascii?Q?GemWNbulmbkEJ0UBzRsiBhHDa5ksahMTe3P1nNRE6Op5X4BfG6kY7squTkH/?=
 =?us-ascii?Q?+BgaFHNHrC6AqNttuVAmxY2oS1M5VeV3yzHVmFOzMOaSgVZhP1oSz7L2bJYn?=
 =?us-ascii?Q?j7XL+1P1nCKFF6YZ3m27TocVwmp1t4HUq7TWyZrEjHAYSZKh9gGjtbNNVARi?=
 =?us-ascii?Q?5oWrppXSup7Gbsp4ZI+RDfj4AfWdGVw7iMi4QCuVP4pfmEWQA9aKspO949/M?=
 =?us-ascii?Q?lvy+V/LevX1v5B5KGoMDSVoGA8NmIiupHJkwtQqDvdC9WkMwzpoOmk9FHM2P?=
 =?us-ascii?Q?SK/Q5JPlKMEhpQasD8wyktmabVlpyNwj00SvwXbteTqFbju2FdkIPe6zy0eV?=
 =?us-ascii?Q?jiF2Y8MslATkN2caw3D8xLsmBoR1OlPr30Ns6gOxNE+/OFr/+3THjgV5g8/O?=
 =?us-ascii?Q?qbFJWo4ZLFL4yjLkoi1eZqt5faR9+4Wp3I9wwD5reQE5KR2frcDfO5hJXkXs?=
 =?us-ascii?Q?ueWzSAHEb2h9/ojoSX+ffAnVQZ7+3uj/vMadGBBF5tQ+O82OkXi3iCm3Va1t?=
 =?us-ascii?Q?PsncgoEOk33tG8TCTw3IZjgmNf/urcPkWJ7lpvQsgXI0MlVUfMWdNv1cbxbr?=
 =?us-ascii?Q?5EHFoSCsR9jYKU2trtxNIRxV4BDAk3LVbNp4XMYI+JTDxpKvpeA44LftLLvJ?=
 =?us-ascii?Q?c1Z5A3fTqQynQZp1SkgQls6ZW28XgbgrJURY4r6FPEH2TuD02lIiglcxalX7?=
 =?us-ascii?Q?/15j+qV2QqodWnpa2gdBAs50hE1KY//le5XxGfdG5cUecfo3RHAgjBFRfy3e?=
 =?us-ascii?Q?OSKgY1xSbvnbFwAP+lE5DgGcAET+ZWRZKjunC4NAu6E/xFn+zoKwiVyYRiv1?=
 =?us-ascii?Q?O/rQ6YmkLZH5aONoBHJjth4y8PsOTbINDjKUx2yTnJSTIM9PI2p7JsJEUToq?=
 =?us-ascii?Q?+Gr+fIiJ/ArQ0E6gJ4aE9YObkiorHXFpl5L2ZWT6hAjbzm0LpFLgKty1qgFw?=
 =?us-ascii?Q?3KTB7M3vtjA7LNPQVisCqsY+WIEX8Qcv3BRwSTlxYiDCGf06mOX7t6dlcUrk?=
 =?us-ascii?Q?5FCyBX0coRJ8OzPGlMzUcerLC05j/LmslscE34Gv87eMWtxseZ1GPFtiNYYm?=
 =?us-ascii?Q?rvrsE1FGw5tqmbnDtvQo+QEgMpaWHljdre0kWjHNOo5CvqHDZ2Py6tTTawzs?=
 =?us-ascii?Q?QFSlb/IWQjRd8GRTxkTVuWL72YgpIfaYbvqyX3uxUL14D0faH3fQTaa2ge9c?=
 =?us-ascii?Q?RWm4tdnVtXaN+g2Os/q4QMyuSsNK89N/yWAn5WplppeuYmI/+eXjIXShwxUY?=
 =?us-ascii?Q?F3bk8oht/WVf54mDCbR7WhTJFzyDckSf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:49.1396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a7ace2-0cd3-4da7-e38f-08dd13e34aec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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
The synthetic policy overrides the policy we already ran to formulate
this in dcn35_clk_mgr and causes some levels to be dropped along with
FCLK being lower than what can actually being supported per state.

[How]
Just copy in_states to out_states, the synthetic policy is not
applicable and causes many display states to run at max pstate
unexpectedly due to the only valid states being the first and last.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dml2/dml2_translation_helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index bde4250853b1..4a34cfd334cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -553,13 +553,14 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
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
+		// Copy input states to output states - no synthetic policy applied.
+		p->out_states->num_states = p->in_states->num_states;
+		for (i = 0; i < p->in_states->num_states; ++i)
+			p->out_states->state_array[i] = p->in_states->state_array[i];
+	} else {
+		dml2_policy_build_synthetic_soc_states(s, p);
 	}
 }
 
-- 
2.47.1

