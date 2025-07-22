Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B759DC83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C26310E71D;
	Tue, 22 Jul 2025 22:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRENxEac";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F8C10E325
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSTZCtTqyHptZssoyCkh0B6uOUasuxsXvBQ25znOBhB+qMC3HMpR1cH5KfhjdkhqRzRmJ+aMXksU+KNr1m2blsV6obInvFQLEqAKpyHvyYOxcFLbQ2Bd1HPhoAspENNgIu4MdDuuEfWZFn3j/LFc0LFmTR9gd46C+1UkTmrie4+t8WvRHkgmMeF+ySG5wlFlN4rEMV0gutFV3QBb92sob/IOdbTzLIEMsdPoQ1RJEN1+U5iLKi+boQMUWDXCj91BcKy2FNI97gsCudxAWvcMd8luNcLw/G4n5yP112NBsMiy97L7KKhJ3X9dSxwdH+hnI872k8pWwnxukljVvWulDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RwsQi082cYAAVxuALXvH+mdJ8DQbDk3EskgQm5tZWw=;
 b=FAfUQBlfqRAyizkyliJBWaSrVZ1nGY2bMGShTTif5UxFK1PW8BVilYKUF7WhAe+po+ZirzfYxflCdUEfqUWuPSR9sP3MeM0pyiHC3jZS6XuAlJbe7Nqy7Q9TDMBIc5a2sNKFL2TjxeoUUgs9VKOmIdoUPeHxX+rjaqiL+XZekXFluwYR9uW7IRVyMZEBsEfXS1A0VGz2GHAxfyqUrjPiEJZSQkP7Yym5P84xT420IM2Fatw5QPAiGCOzbKuDg1Hsiak3cYJZQzk90TFds9XCgVajWd/TEfdKind5IQ60bx4MV9gOcm6wmAm1UOjxZC114mLXLFi3WjAkDDkA12tjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RwsQi082cYAAVxuALXvH+mdJ8DQbDk3EskgQm5tZWw=;
 b=BRENxEacAuzUicD1Pz7DvOfdfFWro67+xggx67hGIwsPmjPef9d3iqgKfvZDaxV1ZV0tBqNodE8uVX9tnPPYtx5Rt6LeU3g7Ojeq4KWe4Hfuf7L8CKSqVQUQcaS0oBdEwwIeVQAdLfSjmdKucXZccQOoRADNtCizMm1fsNScbx0=
Received: from BYAPR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:74::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:39:18 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::fa) by BYAPR05CA0049.outlook.office365.com
 (2603:10b6:a03:74::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:15 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:15 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 02/25] drm/amd/display: Remove check DPIA HPD status for BW
 Allocation
Date: Tue, 22 Jul 2025 18:36:08 -0400
Message-ID: <20250722223911.2655505-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d1b3a9-69fd-47c2-c824-08ddc97097ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ll26cu8TkBAxCQqSTSUDaGvxlym5Cu7tFkqj8TLUQlHaXAUfuUDkILkoto+d?=
 =?us-ascii?Q?6eKrbeo8NDTDXfyFvELgxPMbLJmUGjgtn1cWxG9thyDqYIblQQv73in72Bx4?=
 =?us-ascii?Q?4UEG+TK1wmsJe8jKxNr7On/wj6HJqx0X3Iz646rhyaVppVjQjmjmT1hoU8XH?=
 =?us-ascii?Q?j5ay1y47RHzoEbK13wqb8Ih21O0hlIJXaJuwyXFPWR1iPfU1WbFW+1+Mjxhr?=
 =?us-ascii?Q?cSOetl4cBPtpx1BKbQR8F2yR/8Jhd6BEsudL0j+q7wkps2vi5FhTO7AYG53h?=
 =?us-ascii?Q?9sBbMDLTxH5jdsCQytJ6ptDCCPbkKsz1FbsYP5OJkMhFUcnPDDS+aaArUGqp?=
 =?us-ascii?Q?/YUVcCJbGlb1Hex69+8LewLlU2+SquIOnBEGmymlK0cLBXh8xCXqYqFhfmKu?=
 =?us-ascii?Q?QxpUWYbeLZ5nHoLs7s2n5/zjaJV2+2NYJqOhWAqgZz6KUGbZR9/yFTXOdqOh?=
 =?us-ascii?Q?Uk2dyeUnD11hArcRtfKY+WcFwV1SeEhfIN8sFUOGqPKj7U9Jn/3YmzcGQnpK?=
 =?us-ascii?Q?5/w3NalOgCuLgByg4/ngW3TYQqb7uxmKOubQNPA9fB/bxI9EbKh5gjgPrahI?=
 =?us-ascii?Q?E0+9AzXKY1Qoi1rdCMQbzpmMqEfcyHI24XCIyWvdFbTfWgUmLVqyyDbqzO+s?=
 =?us-ascii?Q?8is31NBWAq/PQXUsA5PmqiJ0L1oZMTOcjSYg4xLG49LZ8DEPfa0I7mZyiSbI?=
 =?us-ascii?Q?Lua5UT1gKj8GLnM7go9s8lZmCa02S4YAsOn19WCj9SmhdIUF4wvy+TWLFGAx?=
 =?us-ascii?Q?IcUa9kThgYgqXd4QxSa2tjSqWn1zgnsXRd4yUKaZrN3v14qVGswg/khK+JU1?=
 =?us-ascii?Q?NIbEzenMRrGReZoos1Qn77HdbnwjEcKYUQeCRfLl80hc30THfKLWp9xacm2S?=
 =?us-ascii?Q?FC0jQXRg0tFLueIU94UQvq2G364tP6Ac0HPkEx58xP8nF6q7msYYSF+huy0J?=
 =?us-ascii?Q?wXCCqt9ttF2KYATpQxoT7ywwzHo2/daqgHrK9OkFFVb6qwyQBZBxb43ZPMGm?=
 =?us-ascii?Q?eMLlpdIf5/Y/FXmty2zhsDdtJsQrRvKgNZY50mRQPc5SapafyOjc326bBp2y?=
 =?us-ascii?Q?Pk1b6M2iB5dNgjzz/MT1J9H68IhZOfVFSDfb1QFZzJXdO5gA5esezK+0Tstk?=
 =?us-ascii?Q?VuwVtItH/cKI7CflFwQp+B3QkuEnrlxcvPtOXQVa8OCSAHqIJgOzEiZ9cWT+?=
 =?us-ascii?Q?CxHov888tUOElUfGGWOzdjGYhStefdDdCUFC4X19qTm3covGOV3zjLCLGRJM?=
 =?us-ascii?Q?1zL6XF21tetUJjxsb2nV2UMnUm3DXDQdU44j0lpv1G6dfYUxZRBzQ1DnTtPm?=
 =?us-ascii?Q?Hg1dW2dzCW2K7HbVeysaz+mIwp1xD28wLQJRIcyVflS8VxHPlTtLLtCgXyVA?=
 =?us-ascii?Q?y9SU35NmnVWH6yO3O7bawJJt3NrWv8l2ScYmLG8PW5kpIiSu27Mu7yIRmNix?=
 =?us-ascii?Q?0r1DHioDGXLsZwavzkgnN2LnjjRC34SSoRtNbY43jhduCvNPCjZsWc0kgbog?=
 =?us-ascii?Q?e89IriTqYNhTPpscUjAshrBHAZ2i6Ge/VDQ3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:17.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d1b3a9-69fd-47c2-c824-08ddc97097ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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

[Why & How]
Link hpd_status is for embedded DPIA only.
Do not check hpd_status for BW allocation logic.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/link/link_validation.c |  6 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       | 60 +++++++++----------
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index aecaf37eee35..acdc162de535 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -408,8 +408,10 @@ enum dc_status link_validate_dp_tunnel_bandwidth(const struct dc *dc, const stru
 		link = stream->link;
 
 		if (!(link && (stream->signal == SIGNAL_TYPE_DISPLAY_PORT
-				|| stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
-				&& link->hpd_status))
+				|| stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)))
+			continue;
+
+		if ((link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) && (link->hpd_status == false))
 			continue;
 
 		dp_tunnel_settings = get_dp_tunnel_settings(new_ctx, stream);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 819bf2d8ba53..906d85ca8956 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -48,8 +48,7 @@
  */
 static bool link_dp_is_bw_alloc_available(struct dc_link *link)
 {
-	return (link && link->hpd_status
-		&& link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling
+	return (link && link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling
 		&& link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc
 		&& link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.bits.driver_bw_alloc_support);
 }
@@ -226,35 +225,35 @@ bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link)
 	bool ret = false;
 	uint8_t val;
 
-	if (link->hpd_status) {
-		val = DPTX_BW_ALLOC_MODE_ENABLE | DPTX_BW_ALLOC_UNMASK_IRQ;
+	val = DPTX_BW_ALLOC_MODE_ENABLE | DPTX_BW_ALLOC_UNMASK_IRQ;
 
-		if (core_link_write_dpcd(link, DPTX_BW_ALLOCATION_MODE_CONTROL, &val, sizeof(uint8_t)) == DC_OK) {
-			DC_LOG_DEBUG("%s:  link[%d] DPTX BW allocation mode enabled", __func__, link->link_index);
+	if (core_link_write_dpcd(link, DPTX_BW_ALLOCATION_MODE_CONTROL, &val, sizeof(uint8_t)) == DC_OK) {
+		DC_LOG_DEBUG("%s:  link[%d] DPTX BW allocation mode enabled", __func__, link->link_index);
 
-			retrieve_usb4_dp_bw_allocation_info(link);
+		retrieve_usb4_dp_bw_allocation_info(link);
 
-			if (link->dpia_bw_alloc_config.nrd_max_link_rate && link->dpia_bw_alloc_config.nrd_max_lane_count) {
-				link->reported_link_cap.link_rate = link->dpia_bw_alloc_config.nrd_max_link_rate;
-				link->reported_link_cap.lane_count = link->dpia_bw_alloc_config.nrd_max_lane_count;
-			}
+		if (
+				link->dpia_bw_alloc_config.nrd_max_link_rate
+				&& link->dpia_bw_alloc_config.nrd_max_lane_count) {
+			link->reported_link_cap.link_rate = link->dpia_bw_alloc_config.nrd_max_link_rate;
+			link->reported_link_cap.lane_count = link->dpia_bw_alloc_config.nrd_max_lane_count;
+		}
 
-			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
-			ret = true;
-
-			if (link->dc->debug.dpia_debug.bits.enable_usb4_bw_zero_alloc_patch) {
-				/*
-				 * During DP tunnel creation, the CM preallocates BW
-				 * and reduces the estimated BW of other DPIAs.
-				 * The CM releases the preallocation only when the allocation is complete.
-				 * Perform a zero allocation to make the CM release the preallocation
-				 * and correctly update the estimated BW for all DPIAs per host router.
-				 */
-				link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
-			}
-		} else
-			DC_LOG_DEBUG("%s:  link[%d] failed to enable DPTX BW allocation mode", __func__, link->link_index);
-	}
+		link->dpia_bw_alloc_config.bw_alloc_enabled = true;
+		ret = true;
+
+		if (link->dc->debug.dpia_debug.bits.enable_usb4_bw_zero_alloc_patch) {
+			/*
+			 * During DP tunnel creation, the CM preallocates BW
+			 * and reduces the estimated BW of other DPIAs.
+			 * The CM releases the preallocation only when the allocation is complete.
+			 * Perform a zero allocation to make the CM release the preallocation
+			 * and correctly update the estimated BW for all DPIAs per host router.
+			 */
+			link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
+		}
+	} else
+		DC_LOG_DEBUG("%s:  link[%d] failed to enable DPTX BW allocation mode", __func__, link->link_index);
 
 	return ret;
 }
@@ -297,15 +296,12 @@ void dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pe
 {
 	if (link && link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling
 			&& link->dpia_bw_alloc_config.bw_alloc_enabled) {
-		//1. Hot Plug
-		if (link->hpd_status && peak_bw > 0) {
+		if (peak_bw > 0) {
 			// If DP over USB4 then we need to check BW allocation
 			link->dpia_bw_alloc_config.link_max_bw = peak_bw;
 
 			link_dpia_send_bw_alloc_request(link, peak_bw);
-		}
-		//2. Cold Unplug
-		else if (!link->hpd_status)
+		} else
 			dpia_bw_alloc_unplug(link);
 	}
 }
-- 
2.43.0

