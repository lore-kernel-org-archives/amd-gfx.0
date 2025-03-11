Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E21C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734F610E2E2;
	Tue, 11 Mar 2025 21:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zr2snopV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3719010E2E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4qyjTwkiwERfGYHIA+R10ONWzP/n/LGA5oO/JqPazqYZoJXnYP0oJMiMfTjEAqIPudKxT0I2UaQPispzc85KM4xba3AQ0jVz/TwiMhnWiWR5oSnqEPKNOxJCg33SmUcLG+Jmw9vqLVH+1zQ9FwQ0NKghWGKuLOD7QaW051U2d8V2/EpptzpUBPc0+iZIASsHwgoKdgK+Xa7Mdf+bXMAX/6VPz8q3eiPB9NRRot/iJpGt5XA+jKGwifkBstUy9nZGBM1PppsoYrERVhX+BZhyVKorIjQljuXb9ya7vetEKd9+MdzduWt9uN8QenNxDYar1Gat2qO9rgM7xY5wx3YPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vs6NIdoj2nBnNT1cxZ6T4l4MueF9ngc6KttjRf+b68=;
 b=CV6s5SMC1kDfvZlMuuGN5qIXiIflQ+H0nRIezfcNjMFlk4JVOJ2noDxea/Avvc1Bwq1htuT57+mRB2PV5sS6Y8e9DGXC8QW7xvSrZPaZdriAwLDx/gmSWZbHp64X9eDGPuDr3Q+S5Bgx9OaSJODYRWpCLM+k82tFCZjq1NxKn9YWyG//uplQbSUEP/sr1ft7zUf9mJ/0mwcdUikwVDhtUjGJ+zYz4tr/bK+zNMcYUpqSYJdWt/+Ho/O6OMOydxloDQPE0WfuY3isfVPjYEQgGzqM674nwxFOmSzQ1PgFj5WqVh07fw6/dLrgRnzee+iaLO6Co+Fi1OiEk7tQ8VdxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vs6NIdoj2nBnNT1cxZ6T4l4MueF9ngc6KttjRf+b68=;
 b=Zr2snopVOqwRuRGEhBZlFyWVSVFDxed73fztiqcq93PhoZ+2PYWqbDkYBJBFXawK8o/PCo3Tw+0BWQXXnaJoSnpXvI+rhtskCfeNIJtSvzELNUm1qRlF+fSJUA7TmgRUnX419gXeOP3u3Owm484Y2V3s0VWQubPp06Rnpmk9XEQ=
Received: from BN9PR03CA0458.namprd03.prod.outlook.com (2603:10b6:408:139::13)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:50:01 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::da) by BN9PR03CA0458.outlook.office365.com
 (2603:10b6:408:139::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 21:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:50:00 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:49:57 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 05/11] drm/amd/display: Change notification of link BW
 allocation
Date: Tue, 11 Mar 2025 15:42:06 -0600
Message-ID: <20250311214618.3106637-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d5ba3c-2fbc-4970-7199-08dd60e6ac85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CwlTXXQnggYC2Nn7ALuUMRNg8nrqXNlB5EWJiboRrKy7YtoJjv5cf6pxASa4?=
 =?us-ascii?Q?sWXYR+X9Krjw9V86Tokg2LAmovcJ1ZzylQgC4mxypjOSDtjjOv6j+fvPNcEU?=
 =?us-ascii?Q?xZlYXKlf/ive1uvZjh+LCQOhQjQdYzPLjyyJOydcIKrRDdUHKYM5F264xy8b?=
 =?us-ascii?Q?YHWLsxyduZY7u9EXcBuC8GgbkjSDcvJCbJEt3RGtnTEypREFaiG5STjEswaR?=
 =?us-ascii?Q?NQnVcwl/4FBQx4A4D1yGOlOKMOJQRV93OPtH26em09p9VRi9SOlzJ2HsefGZ?=
 =?us-ascii?Q?HKc7UqaRFSv0bouR4L3x5lXNL+KCMwFZTnqJkGwNnids2Uhy8GBdAp+znAPm?=
 =?us-ascii?Q?uMrJOq982n7vrzkFqFOigLMz7Ns/JB89vKJR/9m9VdVWEtIXr3llCy2QZIFs?=
 =?us-ascii?Q?zwtS/2U+wfgLr66UZB6qpdAV0M1IFqecQ6A7wEZpNYeCZFF/7+qOLBtsRUUt?=
 =?us-ascii?Q?R3URvziKPRANjI4ORJTCAy/+93WPIky4DESpvV5yXuW0eD7RWG3Y5rvKfGVt?=
 =?us-ascii?Q?Tb0FTIgMVN8quWPf/YojcBwBEoKvN370L09Fz33QIP4FhxsT5+uWM/h6HbYE?=
 =?us-ascii?Q?WHlU7uRRpJIUSmlifIbvGhU6UXy5S1ldl88U6DLe+2d2z3nxwbW5Wns5wsSl?=
 =?us-ascii?Q?SubRgpPVvW1Dz38+vHj+koSz1kMx1N/HmAcIUr/UeJ8wwc/b0nbO8UKBKnJY?=
 =?us-ascii?Q?2qKrz1+NfMYUF0wcXWrb0aqFFImmSqQPHic9AiEEDMrWjqFGN7TRLtMpH5ky?=
 =?us-ascii?Q?0ZoLiBswC1BgaLocq24Vtl4KUS8Bg6W4O5ECPfP0xIV2IxElh5uWRwIN+lV6?=
 =?us-ascii?Q?FqWbH3gXb89ZIh4jKdD6ESvVpfrJoSZ/jJyqJ3Df0xLK2aJZ6zG18xmYYeJ8?=
 =?us-ascii?Q?nOKDoc6+g0eprCFRaR1BDd3HN61s1FdhqheLunZ1Tus82EkOqksbwYU3YSz1?=
 =?us-ascii?Q?LwTMBfNPs+34HIDazjb9o4HZz63j/1FDnE3hnTSePVbU+RDOslTDlnWhzUYL?=
 =?us-ascii?Q?fNh8rMCoAoTrIaYKzx4CY6/Jmbe+S/fziZ0Hog2e621lVFM6lTYbIuq8Cx6L?=
 =?us-ascii?Q?jNL0rIa8ivfaoN5Xsg3i19DrIC/OVG+Dyr4cgzM5awB/DrWNCpPpfUUhlqfN?=
 =?us-ascii?Q?KsM1fuO7dUjXus1Ja3SBdKOOzCDPxFWaOD3LqLexXC5lgRbP9MmctsvURWRR?=
 =?us-ascii?Q?yDWzugS2gYCFLbah+3imM3uVALvO5lQs+pdfPf1Qfi5dU9iKrzqkH/aNDV82?=
 =?us-ascii?Q?F2p0UyDJbbnTlPPiSi269BUaoqLmoqP1OCBzEBEi0mWto1Oi2HusWgHDsxWp?=
 =?us-ascii?Q?Uk11eXdidJ2qrnDSIrJTpK0OsfgStgTsJVN381ZtQ0cYNvLAO2TuOV/qSDcU?=
 =?us-ascii?Q?Az6z77xgdMozAUfBlD0e20ifAemHEnWWkhdYZL1YLsEK4XuUfVEsokPD8D4w?=
 =?us-ascii?Q?tQnwN7mpRoar84IJVvKBTYAJB4p17Ifq6kWa1pxCG9pzPXwgV/mnAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:50:00.9024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d5ba3c-2fbc-4970-7199-08dd60e6ac85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
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

From: Cruise Hung <Cruise.Hung@amd.com>

[WHY & HOW]
The response of DP BW allocation is handled in Outbox ISR.
When it failed to request the DP BW allocation, it sent another
DPCD request in Outbox ISR immediately. The DP AUX reply also
uses the Outbox ISR. So, no AUX reply happened in this case.
Change to use HPD IRQ for the notification.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 -
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  17 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 -
 .../dc/link/protocols/link_dp_dpia_bw.c       | 193 ++++--------------
 .../dc/link/protocols/link_dp_dpia_bw.h       |  18 +-
 8 files changed, 46 insertions(+), 213 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 261c3bc4d46e..71e15da4bb69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -370,15 +370,10 @@ bool dc_link_should_enable_fec(const struct dc_link *link)
 	return link->dc->link_srv->dp_should_enable_fec(link);
 }
 
-int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
+void dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
 		struct dc_link *link, int peak_bw)
 {
-	return link->dc->link_srv->dpia_handle_usb4_bandwidth_allocation_for_link(link, peak_bw);
-}
-
-void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
-{
-	link->dc->link_srv->dpia_handle_bw_alloc_response(link, bw, result);
+	link->dc->link_srv->dpia_handle_usb4_bandwidth_allocation_for_link(link, peak_bw);
 }
 
 bool dc_link_check_link_loss_status(
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 67e1bb6fa335..7932d8f99d22 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2353,19 +2353,6 @@ unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link);
  */
 void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
 
-/*
- * Handle function for when the status of the Request above is complete.
- * We will find out the result of allocating on CM and update structs.
- *
- * @link: pointer to the dc_link struct instance
- * @bw: Allocated or Estimated BW depending on the result
- * @result: Response type
- *
- * return: none
- */
-void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link,
-		uint8_t bw, uint8_t result);
-
 /*
  * Handle the USB4 BW Allocation related functionality here:
  * Plug => Try to allocate max bw from timing parameters supported by the sink
@@ -2374,9 +2361,8 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link,
  * @link: pointer to the dc_link struct instance
  * @peak_bw: Peak bw used by the link/sink
  *
- * return: allocated bw else return 0
  */
-int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
+void dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
 		struct dc_link *link, int peak_bw);
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index acd3b373a18e..83ffaae9f439 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1224,7 +1224,6 @@ struct dc_dpia_bw_alloc {
 	int bw_granularity;    // BW Granularity
 	int dp_overhead;       // DP overhead in dp tunneling
 	bool bw_alloc_enabled; // The BW Alloc Mode Support is turned ON for all 3:  DP-Tx & Dpia & CM
-	bool response_ready;   // Response ready from the CM side
 	uint8_t nrd_max_lane_count; // Non-reduced max lane count
 	uint8_t nrd_max_link_rate; // Non-reduced max link rate
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index fd1f9d3db039..2948a696ee12 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -218,10 +218,8 @@ struct link_service {
 
 
 	/*************************** DP DPIA/PHY ******************************/
-	int (*dpia_handle_usb4_bandwidth_allocation_for_link)(
+	void (*dpia_handle_usb4_bandwidth_allocation_for_link)(
 			struct dc_link *link, int peak_bw);
-	void (*dpia_handle_bw_alloc_response)(
-			struct dc_link *link, uint8_t bw, uint8_t result);
 	void (*dp_set_drive_settings)(
 		struct dc_link *link,
 		const struct link_resource *link_res,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 321fd1785370..268626e73c54 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2291,22 +2291,7 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 	link->dpia_bw_alloc_config.dp_overhead = link_dp_dpia_get_dp_overhead_in_dp_tunneling(link);
 	req_bw += link->dpia_bw_alloc_config.dp_overhead;
 
-	if (link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, req_bw)) {
-		if (req_bw <= link->dpia_bw_alloc_config.allocated_bw) {
-			DC_LOG_DEBUG("%s, Success in allocate bw for link(%d), allocated_bw(%d), dp_overhead(%d)\n",
-					__func__, link->link_index, link->dpia_bw_alloc_config.allocated_bw,
-					link->dpia_bw_alloc_config.dp_overhead);
-		} else {
-			// Cannot get the required bandwidth.
-			DC_LOG_ERROR("%s, Failed to allocate bw for link(%d), allocated_bw(%d), dp_overhead(%d)\n",
-					__func__, link->link_index, link->dpia_bw_alloc_config.allocated_bw,
-					link->dpia_bw_alloc_config.dp_overhead);
-			return false;
-		}
-	} else {
-		DC_LOG_DEBUG("%s, usb4 request bw timeout\n", __func__);
-		return false;
-	}
+	link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, req_bw);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 		int i = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index a7877d57a00f..f6b6b19e7481 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -175,7 +175,6 @@ static void construct_link_service_dp_phy_or_dpia(struct link_service *link_srv)
 {
 	link_srv->dpia_handle_usb4_bandwidth_allocation_for_link =
 			dpia_handle_usb4_bandwidth_allocation_for_link;
-	link_srv->dpia_handle_bw_alloc_response = dpia_handle_bw_alloc_response;
 	link_srv->dp_set_drive_settings = dp_set_drive_settings;
 	link_srv->dpcd_write_rx_power_ctrl = dpcd_write_rx_power_ctrl;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index a5541b8fc95b..a254ead2f7e8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -24,7 +24,7 @@
  *
  */
 /*********************************************************************/
-//				USB4 DPIA BANDWIDTH ALLOCATION LOGIC
+// USB4 DPIA BANDWIDTH ALLOCATION LOGIC
 /*********************************************************************/
 #include "link_dp_dpia_bw.h"
 #include "link_dpcd.h"
@@ -36,7 +36,7 @@
 #define Kbps_TO_Gbps (1000 * 1000)
 
 // ------------------------------------------------------------------
-//					PRIVATE FUNCTIONS
+// PRIVATE FUNCTIONS
 // ------------------------------------------------------------------
 /*
  * Always Check the following:
@@ -44,11 +44,11 @@
  *  - Is HPD HIGH?
  *  - Is BW Allocation Support Mode enabled on DP-Tx?
  */
-static bool get_bw_alloc_proceed_flag(struct dc_link *tmp)
+static bool link_dp_is_bw_alloc_available(struct dc_link *link)
 {
-	return (tmp && DISPLAY_ENDPOINT_USB4_DPIA == tmp->ep_type
-			&& tmp->hpd_status
-			&& tmp->dpia_bw_alloc_config.bw_alloc_enabled);
+	return (link && link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA
+		&& link->hpd_status
+		&& link->dpia_bw_alloc_config.bw_alloc_enabled);
 }
 
 static void reset_bw_alloc_struct(struct dc_link *link)
@@ -60,7 +60,6 @@ static void reset_bw_alloc_struct(struct dc_link *link)
 	link->dpia_bw_alloc_config.estimated_bw = 0;
 	link->dpia_bw_alloc_config.bw_granularity = 0;
 	link->dpia_bw_alloc_config.dp_overhead = 0;
-	link->dpia_bw_alloc_config.response_ready = false;
 	link->dpia_bw_alloc_config.nrd_max_lane_count = 0;
 	link->dpia_bw_alloc_config.nrd_max_link_rate = 0;
 	for (int i = 0; i < MAX_SINKS_PER_LINK; i++)
@@ -243,20 +242,20 @@ static int get_host_router_total_dp_tunnel_bw(const struct dc *dc, uint8_t hr_in
 static void dpia_bw_alloc_unplug(struct dc_link *link)
 {
 	if (link) {
-		DC_LOG_DEBUG("%s: resetting bw alloc config for link(%d)\n",
+		DC_LOG_DEBUG("%s: resetting BW alloc config for link(%d)\n",
 			__func__, link->link_index);
 		reset_bw_alloc_struct(link);
 	}
 }
 
-static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
+static void link_dpia_send_bw_alloc_request(struct dc_link *link, int req_bw)
 {
 	uint8_t requested_bw;
 	uint32_t temp;
 
 	/* Error check whether request bw greater than allocated */
 	if (req_bw > link->dpia_bw_alloc_config.estimated_bw) {
-		DC_LOG_ERROR("%s: Request bw greater than estimated bw for link(%d)\n",
+		DC_LOG_ERROR("%s: Request BW greater than estimated BW for link(%d)\n",
 			__func__, link->link_index);
 		req_bw = link->dpia_bw_alloc_config.estimated_bw;
 	}
@@ -271,32 +270,17 @@ static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 	/* Error check whether requested and allocated are equal */
 	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 	if (req_bw && (req_bw == link->dpia_bw_alloc_config.allocated_bw)) {
-		DC_LOG_ERROR("%s: Request bw equals to allocated bw for link(%d)\n",
+		DC_LOG_ERROR("%s: Request BW equals to allocated BW for link(%d)\n",
 			__func__, link->link_index);
 	}
 
-	link->dpia_bw_alloc_config.response_ready = false; // Reset flag
-	core_link_write_dpcd(
-		link,
-		REQUESTED_BW,
+	core_link_write_dpcd(link, REQUESTED_BW,
 		&requested_bw,
 		sizeof(uint8_t));
 }
 
-/*
- * Return the response_ready flag from dc_link struct
- *
- * @link: pointer to the dc_link struct instance
- *
- * return: response_ready flag from dc_link struct
- */
-static bool get_cm_response_ready_flag(struct dc_link *link)
-{
-	return link->dpia_bw_alloc_config.response_ready;
-}
-
 // ------------------------------------------------------------------
-//					PUBLIC FUNCTIONS
+// PUBLIC FUNCTIONS
 // ------------------------------------------------------------------
 bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 {
@@ -370,9 +354,15 @@ void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status)
 		DC_LOG_DEBUG("%s: BW Allocation request succeeded on link(%d)",
 				__func__, link->link_index);
 	} else if (status & DP_TUNNELING_BW_REQUEST_FAILED) {
+		link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+
 		DC_LOG_DEBUG("%s: BW Allocation request failed on link(%d)  allocated/estimated BW=%d",
 				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
+
+		link_dpia_send_bw_alloc_request(link, link->dpia_bw_alloc_config.estimated_bw);
 	} else if (status & DP_TUNNELING_ESTIMATED_BW_CHANGED) {
+		link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+
 		DC_LOG_DEBUG("%s: Estimated BW changed on link(%d)  new estimated BW=%d",
 				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
 	}
@@ -382,141 +372,36 @@ void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status)
 		&status, sizeof(status));
 }
 
-void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
+/*
+ * Handle the DP Bandwidth allocation for DPIA
+ *
+ */
+void dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw)
 {
-	int bw_needed = 0;
-	int estimated = 0;
-
-	if (!get_bw_alloc_proceed_flag((link)))
-		return;
-
-	switch (result) {
-
-	case DPIA_BW_REQ_FAILED:
-
-		/*
-		 * Ideally, we shouldn't run into this case as we always validate available
-		 * bandwidth and request within that limit
-		 */
-		estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-
-		DC_LOG_ERROR("%s: BW REQ FAILURE for DP-TX Request for link(%d)\n",
-			__func__, link->link_index);
-		DC_LOG_ERROR("%s: current estimated_bw(%d), new estimated_bw(%d)\n",
-			__func__, link->dpia_bw_alloc_config.estimated_bw, estimated);
-
-		/* Update the new Estimated BW value updated by CM */
-		link->dpia_bw_alloc_config.estimated_bw = estimated;
-
-		/* Allocate the previously requested bandwidth */
-		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.estimated_bw);
-
-		/*
-		 * If FAIL then it is either:
-		 * 1. Due to DP-Tx trying to allocate more than available i.e. it failed locally
-		 *    => get estimated and allocate that
-		 * 2. Due to the fact that DP-Tx tried to allocated ESTIMATED BW and failed then
-		 *    CM will have to update 0xE0023 with new ESTIMATED BW value.
-		 */
-		break;
-
-	case DPIA_BW_REQ_SUCCESS:
-
-		bw_needed = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-
-		DC_LOG_DEBUG("%s: BW REQ SUCCESS for DP-TX Request for link(%d)\n",
-			__func__, link->link_index);
-		DC_LOG_DEBUG("%s: current allocated_bw(%d), new allocated_bw(%d)\n",
-			__func__, link->dpia_bw_alloc_config.allocated_bw, bw_needed);
-
-		link->dpia_bw_alloc_config.allocated_bw = bw_needed;
+	if (link && link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->dpia_bw_alloc_config.bw_alloc_enabled) {
+		//1. Hot Plug
+		if (link->hpd_status && peak_bw > 0) {
+			// If DP over USB4 then we need to check BW allocation
+			link->dpia_bw_alloc_config.link_max_bw = peak_bw;
 
-		link->dpia_bw_alloc_config.response_ready = true;
-		break;
-
-	case DPIA_EST_BW_CHANGED:
-
-		estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-
-		DC_LOG_DEBUG("%s: ESTIMATED BW CHANGED for link(%d)\n",
-			__func__, link->link_index);
-		DC_LOG_DEBUG("%s: current estimated_bw(%d), new estimated_bw(%d)\n",
-			__func__, link->dpia_bw_alloc_config.estimated_bw, estimated);
-
-		link->dpia_bw_alloc_config.estimated_bw = estimated;
-		break;
-
-	case DPIA_BW_ALLOC_CAPS_CHANGED:
-
-		DC_LOG_ERROR("%s: BW ALLOC CAPABILITY CHANGED to Disabled for link(%d)\n",
-			__func__, link->link_index);
-		link->dpia_bw_alloc_config.bw_alloc_enabled = false;
-		break;
+			link_dpia_send_bw_alloc_request(link, peak_bw);
+		}
+		//2. Cold Unplug
+		else if (!link->hpd_status)
+			dpia_bw_alloc_unplug(link);
 	}
 }
-int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw)
-{
-	int ret = 0;
-	uint8_t timeout = 10;
-
-	if (!(link && DISPLAY_ENDPOINT_USB4_DPIA == link->ep_type
-			&& link->dpia_bw_alloc_config.bw_alloc_enabled))
-		goto out;
-
-	//1. Hot Plug
-	if (link->hpd_status && peak_bw > 0) {
-
-		// If DP over USB4 then we need to check BW allocation
-		link->dpia_bw_alloc_config.link_max_bw = peak_bw;
-		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.link_max_bw);
 
-		do {
-			if (timeout > 0)
-				timeout--;
-			else
-				break;
-			msleep(10);
-		} while (!get_cm_response_ready_flag(link));
-
-		if (!timeout)
-			ret = 0;// ERROR TIMEOUT waiting for response for allocating bw
-		else if (link->dpia_bw_alloc_config.allocated_bw > 0)
-			ret = link->dpia_bw_alloc_config.allocated_bw;
-	}
-	//2. Cold Unplug
-	else if (!link->hpd_status)
-		dpia_bw_alloc_unplug(link);
-
-out:
-	return ret;
-}
-bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
+void link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
 {
-	bool ret = false;
-	uint8_t timeout = 10;
-
 	DC_LOG_DEBUG("%s: ENTER: link(%d), hpd_status(%d), current allocated_bw(%d), req_bw(%d)\n",
 		__func__, link->link_index, link->hpd_status,
 		link->dpia_bw_alloc_config.allocated_bw, req_bw);
 
-	if (!get_bw_alloc_proceed_flag(link))
-		goto out;
-
-	set_usb4_req_bw_req(link, req_bw);
-	do {
-		if (timeout > 0)
-			timeout--;
-		else
-			break;
-		msleep(10);
-	} while (!get_cm_response_ready_flag(link));
-
-	if (timeout)
-		ret = true;
-
-out:
-	DC_LOG_DEBUG("%s: EXIT: timeout(%d), ret(%d)\n", __func__, timeout, ret);
-	return ret;
+	if (link_dp_is_bw_alloc_available(link))
+		link_dpia_send_bw_alloc_request(link, req_bw);
+	else
+		DC_LOG_DEBUG("%s:  Not able to send the BW Allocation request", __func__);
 }
 
 bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
@@ -567,7 +452,7 @@ int link_dp_dpia_get_dp_overhead_in_dp_tunneling(struct dc_link *link)
 {
 	int dp_overhead = 0, link_mst_overhead = 0;
 
-	if (!get_bw_alloc_proceed_flag((link)))
+	if (!link_dp_is_bw_alloc_available(link))
 		return dp_overhead;
 
 	/* if its mst link, add MTPH overhead */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 1b240a2f6ce0..6df9b946b00f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -59,9 +59,8 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link);
  * @link: pointer to the dc_link struct instance
  * @req_bw: Bw requested by the stream
  *
- * return: true if allocated successfully
  */
-bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
+void link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
 
 /*
  * Handle the USB4 BW Allocation related functionality here:
@@ -71,21 +70,8 @@ bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int r
  * @link: pointer to the dc_link struct instance
  * @peak_bw: Peak bw used by the link/sink
  *
- * return: allocated bw else return 0
  */
-int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw);
-
-/*
- * Handle function for when the status of the Request above is complete.
- * We will find out the result of allocating on CM and update structs.
- *
- * @link: pointer to the dc_link struct instance
- * @bw: Allocated or Estimated BW depending on the result
- * @result: Response type
- *
- * return: none
- */
-void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result);
+void dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw);
 
 /*
  * Handle the validation of total BW here and confirm that the bw used by each
-- 
2.43.0

