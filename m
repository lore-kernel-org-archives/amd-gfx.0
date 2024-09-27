Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC86CDD1CE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CD010ECF2;
	Fri, 27 Sep 2024 17:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d+KbjvF9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB8610ECF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgHgvLpnU5DxpEKxY5GCoEhaJ0iJJJ4yhAsi/lhpSZde0YoEh5Ks5lma8IZOCYnYz4LBPAfmls+v7SGaEIM4ZydURQIXyypOpW0XuAFp4+RKzivk13fd/0Y1fqcuHXsjQcxigdJ3OCHo0rvLVn17nF7ED3rhAu1U4Wt7oOpQO9Mz7+PDRFxTHviL9OV4pHMXPzHC2Dmlh9P2c9N4kJet8eTnJaZ1Exf2ntzfFQ3waVl6zKwbufaTiy0qCTXZJCl8fVtdOZsSQ90F7c0hydENvdI1GfW3/Z8ZwOOvxzLogiyUCouibzA+npHt406v+DzIvh0UDsa38EjYp9EttM+ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKIh9oCsPOlFsGdQHANRa9TYmXlBjAAcNJhMtZs2Xqo=;
 b=YRETPKT8XJe8ryQ/8ypYKnet2a8ycdPeiNeNYLUJDLNdosgyHs2i2fqtMnBuv8r+MjeyBWvw6d3tKlN+dt8yr8w6BFGm3A7HMtMsBE6yD7s9SefTyRDE52dH33LjdxcqFBhZ5tLrkoTBkxV8QU96nUPq88wYg0t4vTHFXB15w+vqmIuJ22YAaIZBpBOA0FQhE+bFtBMPUVIrK1PdSFFvGxWXGzcxmSCe8MLIN18kTK3A0kx9Vuv2nzqz1D7wZEldr+eoQohBz1PT7EwGiI4jtTrQ5P+sgFgU0dtrdAJDjszErCBvC1eZfSii+gje+PfWMS++bySXkswQ7IYQGqvtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKIh9oCsPOlFsGdQHANRa9TYmXlBjAAcNJhMtZs2Xqo=;
 b=d+KbjvF9T/jLyzkheJZ6dFKsnfdFqN65QoZRBw/BA7Klf2D5weqhX0oWOZPWj0OtIfySg0uGt3egWdRlReuuiohE1apKkfAPxkZJ8jPJWl8EmXlNvLXQPQ/FIvJYlQIgHShsriv7XMz9gKdvOxBqhr9M6vh2dPWOG0+GdHsX5dM=
Received: from PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::27)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 17:01:45 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::ae) by PH0P220CA0029.outlook.office365.com
 (2603:10b6:510:d3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:42 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:42 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, "Liu Xi (Alex)" <xi.liu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 04/13] drm/amd/display: add more support for UHBR10 eDP
Date: Fri, 27 Sep 2024 13:00:54 -0400
Message-ID: <20240927170103.102180-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ad5c1e-08e2-492c-6d09-08dcdf161183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IADG8OeDfEIhh9o/F6nGD/cGcBDU6dlLupzIG9H88VDCd3nxTStc5qBPEeuY?=
 =?us-ascii?Q?x9ce4wj7BpsHu7zpc1KjLPhK85qIdM774huAcr/Vt+5AMtxoHktZuX78mXz/?=
 =?us-ascii?Q?LcOJ+dxPTrQvrwNxPZOtb7ZHSwBa+l7UOowwIB8XdJn43JgAqSfDRdaHn3M+?=
 =?us-ascii?Q?M4MMx1fCw83g8iXx4UNzGB7/6qWE2k+VN8FHheSfdhr6NvSldMJWJ+3IER8S?=
 =?us-ascii?Q?4N64UVyXRkeK7p+onkR6gHEoiQq86LOIJt8k5ZSvFmjF1CcVjRqmJWolA07y?=
 =?us-ascii?Q?3S4+K9Vfredn51h+Ul4eGs2xYWbDpMqiLba8zJUlOwdZk15sbr9NECjKw4Sh?=
 =?us-ascii?Q?2lRthIEaC4zxq6+CJGNPkv7aBAYpbfl8CFb30iq9mebx3KCQsoNvvFx42F3w?=
 =?us-ascii?Q?ZQnpmh1NpGeKWp3khb58sQKZi5XmL8pplTpPLvsckeByiy4YTU/+PiobjwVg?=
 =?us-ascii?Q?y6EuuQNTC0yrYFAu3CsDsMFMb+XbsNjUwN7EangS84hdgSxpj7VjqFh5+O6Z?=
 =?us-ascii?Q?n1CSSTIpxe2hMD5BDDMzeBirfkccXMWylOpaYf7eikaWwwfOCKcPrw0nX7WY?=
 =?us-ascii?Q?So0kvxw8wwsyZ8giSkNXW22e/yQduGjQSeD4SBbvE8F+I+k2k4xZXFWYEUCg?=
 =?us-ascii?Q?B6QYJE9wn11ldY0vWqJYQN5kh4nDwOOvKm2+IF2vGw9e7aqSl2TDSlwTsz/y?=
 =?us-ascii?Q?B10CMV/m/z0RRZsXthYpdepHlCU3UICJ72QRFrXO854DMzOoV0q82R36tmLD?=
 =?us-ascii?Q?jltavDWw35pnAZryPt7KSlC20sND8kBuX5DywDqb8LPRjqiJ69EAHl56DF24?=
 =?us-ascii?Q?KtYtljOsM1Y9UBBhY0GIJfh4SIj1BSDwl0WVGhAS06ckoJco0nOtsZ4+kAkn?=
 =?us-ascii?Q?qbzmiW/Vmy7xhmpIj/yvcSB6WFeZcmfcgU1EqXa3cS6/v8g3QaS54uDoQUgP?=
 =?us-ascii?Q?BQoH6KKk/0ybAszoCizyBxyHsQNw0sSbzt4rbx+DXvTKDKi7Mn18mE3zp3Qu?=
 =?us-ascii?Q?jmOFiQIXgYimjy6YKG3FAW6mDDwZ6ozH4DunmrFNiDY6U4U1c8ocHaQqy68m?=
 =?us-ascii?Q?cC0tXsIyGLjhVBqH6/LM1VrrmwmVpgxh14tGMMV1F4QLbt5EITwHnoMywI0W?=
 =?us-ascii?Q?BcI8sKhENWmNOjpTfcCVR7ymsKA14Dnf2vpqnILKgNyxOpN6XCvhbZztgfYw?=
 =?us-ascii?Q?eOJAjsCLYKmRazSy8jZX7oPsJS81BlFgKFqGwO28gvz9PaocjKjIq6ZtX2Jz?=
 =?us-ascii?Q?/NYQMAta4gme/+r4BunksMQQeD3VSksI4yU+Yy3mmQWRl/oYcaNmJF373WhA?=
 =?us-ascii?Q?y3eGIZlMtTfQdDuyll/r4/JoUQhS96U7NBdnDK9Wlv7X2RSrCIx2pDcpqPMU?=
 =?us-ascii?Q?aUKhC0AabG68KCFSztDaqag/h+kV/sOEij80fLMRo6kTKGu8b9IOx/EE2yNe?=
 =?us-ascii?Q?5/oeGsL/kB5a/9MujSLUe3nogY+QudyH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:45.3993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ad5c1e-08e2-492c-6d09-08dcdf161183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

From: "Liu Xi (Alex)" <xi.liu@amd.com>

[Why and how]

The current UHBR10 eDP panel has new security feature update. Add support for the new FW

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Liu Xi (Alex) <xi.liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 -
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 51fdc0085935..8878a770c376 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1771,7 +1771,6 @@ struct dc_link {
 		bool dongle_mode_timing_override;
 		bool blank_stream_on_ocs_change;
 		bool read_dpcd204h_on_irq_hpd;
-		bool disable_assr_for_uhbr;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 3aa05a2be6c0..070b6c8c1aef 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1168,9 +1168,6 @@ static void edp_set_assr_enable(const struct dc *pDC, struct dc_link *link,
 	link_enc_index = link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 
 	if (link_res->hpo_dp_link_enc) {
-		if (link->wa_flags.disable_assr_for_uhbr)
-			return;
-
 		link_enc_index = link_res->hpo_dp_link_enc->inst;
 		use_hpo_dp_link_enc = true;
 	}
-- 
2.34.1

