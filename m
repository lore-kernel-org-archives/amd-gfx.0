Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E17C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8959A10EAFE;
	Thu,  6 Jun 2024 21:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ga1UkEZB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2163010EB07
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCn78F+evwDQUMG7C8r+rctWBxi0ZpUb0YOtEVTzBBTmowZic3OUQrsUc3jk1qFvfYW+5R/aPKRY53z0WlHloxdnnK5jWCzf90aASUqxHj4z3ugMvzRwpJWOnbpUTNsRChsebHa7Mrm35R2D2Tnlk43tHBlKpwhEi/hkyEXLDx1TV8TiUOHJFAB0Dan8Pwuaeuwg0R6FmnERFer08OOsTXBsnUQP4eObie44iivPBRMdvPw3gj9OZYUAD1d4T66ObeXU+6aOpAYIAESW6wIMnOfm41aJ3M8Vrz1z2Snf/lpz9uCj85RKzcPJCygAhQB4pDPq9M0jrS5CaN3kq0hR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7wNRhqEK5oP50au3h2/Xuau+7X9N2iy7JJuQIDFucY=;
 b=mPn6F2WOYw03q0I+6WSjEoIo1LCSB0OXfVKQ2caXVuGNl5g9IWp1rdZphoaNGACQFO440HcaOKuZVPKavg5VBaBS6ChgeJ9EfOlTA6Sr7UN79oJ4w146F2PnMD3ZBOYySNntRfMK2kWJiHaM4t1K+6geK40IwV+FemhJ/BeK6iXhgZyoBSeljwmfppS8Ce7KTy/xVM3inx3o+0cwswFO19o9choh5z8Cr2Ia0JGHb/ceaOmxYCFXEiebn9ad20woJ8kJw+MfWrWlzrrXpifIbqzp9/N4W3ntCg5tcD0GWFxc5B+ulpdlV6BNuAdZF3gETa2gWQt0BFSNuvvPcDEN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7wNRhqEK5oP50au3h2/Xuau+7X9N2iy7JJuQIDFucY=;
 b=ga1UkEZB8l1TtS5Tj44plpFUpJx0qa0Nikxl1k34hWmrUoPkc0HDwD99cDsNDrNyKZb0pn0XzBuCNJeXPMTqYrMcFyq2G6F4LJrCCGDfBGmfZ+RB8y5wGIr2u1BXHUaFl+9dzJzZfro4ydr1SYZ9TC70sVLxi2rSQ+0G2TnS+wc=
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:59:01 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::56) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:01 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:58:59 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sung-huai Wang <danny.wang@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 52/67] Revert "drm/amd/display: Handle HPD_IRQ for internal
 link"
Date: Thu, 6 Jun 2024 17:56:17 -0400
Message-ID: <20240606215632.4061204-53-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c3849d-c202-46c9-9c6d-08dc8673dffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k7bRn6S333GPUQMys7xsHjHeKFFSCEHwMMeF3W4i1z5WCe4CJpi0N7XpbvxG?=
 =?us-ascii?Q?dHcie+DPcCbb7oPZ4zhoPCHQ1RhJx0VmFYglfTXxz4q9priTNyaGIzpP2rCU?=
 =?us-ascii?Q?5QEmZ60q97X2SzmcpuFgNDhOuJN9FWcziEAW/KlF9zL/s683yRx+GB776/cj?=
 =?us-ascii?Q?jzpqWIoSJ0SfgQE1U8GWYqMt7GGPzn5/R6QUc3tzaU9Zf+bRU/0DEIzIy5vc?=
 =?us-ascii?Q?uCF+VGBiJWyDT8v70gehf8xJP9yCisFqpppuw+JmBB0emflSA/ehSlPYYs6J?=
 =?us-ascii?Q?aeMPoO7xiXVp6E6DqfbK4+1gEP5MuPLN8TQ+8WQfz8xlSiCzsjB+bC7h5kWz?=
 =?us-ascii?Q?g/tASLlz8hPOmyVNEN/FUiKv4SUxUFECFX2yVvrtltSAa+i8+jsLBMBP6mBf?=
 =?us-ascii?Q?FAwA+Ul9IK+oN4GidY5sQbXwBXwdp4kB0AthkLz3CyYuuu8gakvjzk65ao1b?=
 =?us-ascii?Q?SkMWufm1/S/rOILfxBHvEOEE9u3GhMcbtMnwMY5BvgZvTOjYyFOb0FluLhJI?=
 =?us-ascii?Q?C29sOpH6LeJajmkuAhPyJ9cBM/+TTJqASTVse1qXyYaguJH5MK+Z/L1oILqd?=
 =?us-ascii?Q?WlUIqns+gJUN1Iq2VjhDbhjjyC7lo0pR3pGSixXBTCpC7iDDaH/oJZxtvFeV?=
 =?us-ascii?Q?myD94cgSmySPO6ofPht3enSTaY9Pna3PmjkQoi4PtWNx7zQrKVBZpcpuRkt7?=
 =?us-ascii?Q?jqqcWe7IYQY3rj5+Eq8V0tY+qPRfslk8y9G5gMQ0lzORCfBASujOGffAksGM?=
 =?us-ascii?Q?NwTdQH1LBzLppFDCUVjh4Tni5fwXsowPwyiQ0DLaVi9H3QPQYL09d9RbekFn?=
 =?us-ascii?Q?/SXwWTsGGY3MekY4Cse/J3Q6Vg7r62B8GUV7P7oWGWOxfwsupobtGhEcG+UA?=
 =?us-ascii?Q?RW8fuLFeXsUOhcjJnqcZWfH0GpZml730DcG/qUCGb4Vh1JKQAXezsQrD+MTH?=
 =?us-ascii?Q?ml+ds2K6oISOA370CQMziksqpoIRR0wnJwEZLtEkFVIr9LB8JH+4g7/Vt3Lo?=
 =?us-ascii?Q?bvmZW6ERtGKgPDy1lFatwt3jMdMRivv+/34zWC+VJ3xuO8gvsjXulOJAD4wt?=
 =?us-ascii?Q?7kpDnUYtJPrFLB2w1FmRUVI0ZgEFVn/PbSNoNt89hynLSjJMwktHNU0Oti3X?=
 =?us-ascii?Q?3vAhLRVZ5dMGGUwVkhuw6BrOMFeQKdhH68pEUHrFMDwIkUsqpH+wNoEYWrpx?=
 =?us-ascii?Q?VghgniqOCF7GO337e1H/Nzif/3NiZBSyusv80lailMWGw/62A0mu2GpJfp3Y?=
 =?us-ascii?Q?NM1a9FSgD0iPNozkUrJb8Qe35suObN5PHiYEOh/UcJgjqOcubL/g48Y7aLjf?=
 =?us-ascii?Q?62bIrGM9oVMU30yPAu8H9BW5zKk7srSTlwIah6I3g4N7taFL/Ys6JwZVhGXS?=
 =?us-ascii?Q?HCU9Gw+uf6wCTdzojse+ATexAdHc5ra+DvGnZr7R2S5tUGegRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:01.6287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c3849d-c202-46c9-9c6d-08dc8673dffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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

From: Sung-huai Wang <danny.wang@amd.com>

[How&Why]
This reverts commit a410234a0e13. Due to the it effects Replay resync.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Sung-huai Wang <danny.wang@amd.com>
---
 .../dc/link/protocols/link_dp_irq_handler.c   | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 5f087e930cb6..96bf135b6f05 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -387,7 +387,6 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	union device_service_irq device_service_clear = {0};
 	enum dc_status result;
 	bool status = false;
-	bool allow_active = false;
 
 	if (out_link_loss)
 		*out_link_loss = false;
@@ -442,6 +441,12 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		return false;
 	}
 
+	if (handle_hpd_irq_psr_sink(link))
+		/* PSR-related error was detected and handled */
+		return true;
+
+	handle_hpd_irq_replay_sink(link);
+
 	/* If PSR-related error handled, Main link may be off,
 	 * so do not handle as a normal sink status change interrupt.
 	 */
@@ -463,8 +468,10 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	 * If we got sink count changed it means
 	 * Downstream port status changed,
 	 * then DM should call DC to do the detection.
+	 * NOTE: Do not handle link loss on eDP since it is internal link
 	 */
-	if (dp_parse_link_loss_status(
+	if ((link->connector_signal != SIGNAL_TYPE_EDP) &&
+			dp_parse_link_loss_status(
 					link,
 					&hpd_irq_dpcd_data)) {
 		/* Connectivity log: link loss */
@@ -473,11 +480,6 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 					sizeof(hpd_irq_dpcd_data),
 					"Status: ");
 
-		if (link->psr_settings.psr_feature_enabled)
-			edp_set_psr_allow_active(link, &allow_active, true, false, NULL);
-		else if (link->replay_settings.replay_allow_active)
-			edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
-
 		if (defer_handling && has_left_work)
 			*has_left_work = true;
 		else
@@ -490,14 +492,6 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		dp_trace_link_loss_increment(link);
 	}
 
-	if (*out_link_loss == false) {
-		if (handle_hpd_irq_psr_sink(link))
-			/* PSR-related error was detected and handled */
-			return true;
-
-		handle_hpd_irq_replay_sink(link);
-	}
-
 	if (link->type == dc_connection_sst_branch &&
 		hpd_irq_dpcd_data.bytes.sink_cnt.bits.SINK_COUNT
 			!= link->dpcd_sink_count)
-- 
2.34.1

