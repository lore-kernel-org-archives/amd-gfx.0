Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5324DF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5A210E2F4;
	Fri,  6 Mar 2026 03:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QAHULNse";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7488410E2F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTwjjZZOp0dpfGAKSu/Ho916QlRd6pTHrOfrOic4+ozSMCftqxUEcX6ll5inL3S3xDH0FY29h3LEfXzmuYJvePycdRAyY5dGoSpxj3Znfqx6VJ43PLxme/mBuyshqGj0ex44kMa4EwKY0ElEL9/QBADXuQCtemupGepOBpyxyzheXZz0Z74U907iAmlmuUGyWVrtCv1P/XOUdT3EhDr3rd23kCrmQd7A7sCiqP+NszNqk00qDSaH7XSaNJfiRG2rGtdk6AQiSvwsbe9VeOaudJnZphze1mgkkqD9Z4InNvXVIe8qN3NNjxRuZj3rAYrJ7EU7vd5c5TQ+vSJx7CGnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZnnxxnQnTnt8Pj6SJcLSxX9haPDhVLdmKPlk5Gdv2E=;
 b=iwRvsqHPRInTk/z3bgflk0djglP8TKWAL10h+lKzivAOW7gmzRDsxxUcbhLJoiP0b3IZGX3/VoEHHDSpQvhqRQ9NCydXMKs5MdvPNA9kVPE6zf6yRo2H5nXIYAbF2arWPFcC5wpyJOkRG3nJX49GkuW1B3hnI1jqxLYmt8NKE92NIWL64BlO+35BJmNQhdH4zevLcbDd4xiFk+C0S8fRit81tqmqbxA+LQjBoEgjUOS8LzrVYs2AV1WmBKb3ybQKQvGrncFfD1iBZJ5vpKH32ezga+vLVrA8OdH7CdmrWpA+iPAh9PcqiXk8+B2FE9dfSAUoEj3yTpHJ7XHN8naESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZnnxxnQnTnt8Pj6SJcLSxX9haPDhVLdmKPlk5Gdv2E=;
 b=QAHULNse0rPIWx/mYkMVDr+4azI476AbK5biUyaU4LIHO11T5J7ZnvQSNUarkWiZNfpSWp0hAvQj3ibVp5I8YzvTnfeJQ9JxUxMjzrpJ6sw3vPLbW02fEV1xGWyHoRtULAoRBQXy3QTEnh6AlGR3WtY/p3ZO2hnTjpJkOTAMrPE=
Received: from BYAPR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:40::30)
 by IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 03:24:17 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::b5) by BYAPR04CA0017.outlook.office365.com
 (2603:10b6:a03:40::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:24:16 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:24:11 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 02/21] drm/amd/display: Return early from vesa replay enable
 function
Date: Thu, 5 Mar 2026 20:13:28 -0700
Message-ID: <20260306031932.136179-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 73be7fe9-fd38-4735-678b-08de7b2fd8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: bYW9OBBF5J7WWNQ76LmQ67EUVLdgq2ZoIBcdodwMjCH/O5Tr4xklNNGivdJ4QlxbMPEKyffQRIw0lcQGWnsbTDrbC188IAjWK8nZ4N86NLerF/XucurLcB4lyn5tqIvtMgF6SUYNJNnUhI+sSqka9cs98Sk7wIzQxpRWEWTJ8+6e7Jc4EAoANnt4bhW54GleChPFxnMhI8hKvzpFaRwvxrxXLfInBKN9Gh6wwf2Ntb0qAjVohl8J9cKpkWgWtHRrZxpRLFh9D9YY2CLF/W8CNoS5XElk9QoR2N92ex0PHClVuuqhMwOwAp+iNgPizTB23IdPVOgflxNTdmkoaXcUk14l1E38y/B89P4L5GD8UPoa/eAFhXug3lrQ70Wkf2yvmcMWkQxrUKx1oxI+44R+9MlN8uINoNs784GcT6Mpc5q2lOtxQofjP2uoIZsMlu565I6NyNf69KC+vruJ05KdL22/OR1wGrJMdKQOjcStAodBClV3W3Rmux3HtWWIrDPfp5pkSA/VQAh9833xxaFGF/B9U2vR7sE+Ix8sk0qs7an0mE0JtBCKUvtEyvDeYH1Qjt+yCmBcEhr2bCVMSg4e4XBrDgtp9F1VRYqzsrW432kZdwoL8tEvBidj5T/wGFewKa+k1JMGfDKv0fkEtf8GUG3ZSneQq8yFrAW6cwmIkz9QkU/MAl9L1wcfVqiwD+SY6XQ+56Fw93TQ05ZAhcKWqeVQdWK4tRw5TzESkQ01Fa4uNl/jd4TXhpmU5HlsZc6ikGwWhYEtgau8UefoSRS2Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ewfckLWm0abLKU4l7+f+qPQqztif/GvBRXdgS5K6uQs2DHhGHPDclNtQiWH2cFXY3rtQB1xe0WrsGm+LkmFj5h6NxOxArDPli8VU9i/yuSp9dnYMSGfWohB5Wj2/nfuTcdveVtNHsCnyhPaiDAucLLbBd3lp7pG3gfTHVdTVHiBjzn1+Y4otEOCl3uhtJyjnz84iiTJMNNsHW2etmv86oGYiH8CI5IuB1lRQgCiDlXPdDfoaOFsQRmHVZVCNuDOFYRRpAfEknYK5PPFTsC9m85YM8lACB80cXT7kgItdg6BwhaeO7WNLmdmn2kPKUGP8S01oUaSL9KfTEnvc0vj6AMmO9I8CO9MJ+zuOxPV1Xh/MPrGMDpJVfyl9Y23xLEYDGlAM0p1Wa41vOabjVjZGEqODkv8xUoLDKnJQADk+VVkjUuaSNjJkeNJJ00C6Aolc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:24:16.5392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73be7fe9-fd38-4735-678b-08de7b2fd8f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY & HOW]
If the enable state is already as expect then just return.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/link/protocols/link_dp_panel_replay.c  | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 6661078c0241..96afce4ffbfa 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -252,23 +252,24 @@ bool dp_pr_enable(struct dc_link *link, bool enable)
 	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
+	if (link->replay_settings.replay_allow_active == enable)
+		return true;
+
 	if (enable && !dc_is_embedded_signal(link->connector_signal))
 		dp_pr_set_static_screen_param(link);
 
-	if (link->replay_settings.replay_allow_active != enable) {
-		//for sending PR enable commands to DMUB
-		memset(&cmd, 0, sizeof(cmd));
+	// for sending PR enable commands to DMUB
+	memset(&cmd, 0, sizeof(cmd));
 
-		cmd.pr_enable.header.type = DMUB_CMD__PR;
-		cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
-		cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
-		cmd.pr_enable.data.panel_inst = panel_inst;
-		cmd.pr_enable.data.enable = enable ? 1 : 0;
+	cmd.pr_enable.header.type = DMUB_CMD__PR;
+	cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
+	cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
+	cmd.pr_enable.data.panel_inst = panel_inst;
+	cmd.pr_enable.data.enable = enable ? 1 : 0;
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
-		dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	link->replay_settings.replay_allow_active = enable;
 
-		link->replay_settings.replay_allow_active = enable;
-	}
 	return true;
 }
 
-- 
2.43.0

