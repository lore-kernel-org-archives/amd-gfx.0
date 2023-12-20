Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593A2C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D604410E5D5;
	Wed, 20 Dec 2023 16:37:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7506310E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxXNivfjP+DnsooR27z7JLQxfskri1vo6vyKL1jN1DqTIzvs+jSjX7Nc9LIw65wWNcnUNIgJgB0Sf4rvsDlrzmvNwtLl4g6+P1DYOXVIn5JBF46kFbWutsKYuxUfwVWFAzUSecUuPaa33STe8+UTtWnxe41PbLsbkoA3DpdJSTuRakLzDRewI0igAStRAO466BiGLML4Kd4ODpZ1DB21VosjelYUB7HP4QKf/GHs78pNip6+CiHrqjWIT0wrfOg7y2mWgEePGr8roXfDK84YRQ8YpL5KxiKTIhVqcbfMO1vggupkPeiilrRkmxe3pSZuhhsIVpdEOhf6LTUQZhCNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDK/YMgH/CqY+xCAWKqAhoF2TrDJlVhzY4QIQoAko4I=;
 b=agHbpBCnIteST0jeGFaoJ64JUdqxPvl7C0uHzva0VP1Hg4o3S4GrSsBUh0xdDXxel4EMCJUYU6EKcBWr4X6GtzYxOhHXz37KXXmFjbajHJwjbKKoq3ht6+L8dvLc6v55D6XXQ8VNAie8H+8PCzaprB/EnHqaKIPPFCfbj9TdQA/mJN/DSO9yXZWmOwS5Z+H+DAfn+mV+bW2szyAHZ3vhaaeYNeO2I4DHXcOQgrx8Hc7CSHzI2ruj+UCi9gsfbO1VDdCLEMb07YVOIbTyCfQJuRkeaGqyrACjJFTv9KNM7HL42dlubp4HAyNs/lTo90SQZAMoQR1S/Qmf8j8kTk+OWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDK/YMgH/CqY+xCAWKqAhoF2TrDJlVhzY4QIQoAko4I=;
 b=QHtWrc+Jb+KZJBnIYFBsCYElt8F1uP+okhMCpHfB8Gmv5Vs7uPaN7QBrMylbYte1E+1RTTxteJkGqGx4+tcudPKhFN2bRzxAFSHopwoDe2KRDIca4AVPJR7BewPC9fHBob+/c/+j0wcqoZgxbYsm2aFYBdGVklTrCJwAACpJTlQ=
Received: from MN2PR15CA0062.namprd15.prod.outlook.com (2603:10b6:208:237::31)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:36:52 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::5d) by MN2PR15CA0062.outlook.office365.com
 (2603:10b6:208:237::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:50 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/20] drm/amd/display: Fix minor issues in BW Allocation
 Phase2
Date: Wed, 20 Dec 2023 09:33:38 -0700
Message-ID: <20231220163538.1742834-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|BN9PR12MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fa9ec8-7d24-4de2-7f2d-08dc0179df0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBdR6dX5Oqj5YUIEeFZlSgvDJEqfi0hgkoYdC6ktHAWha7ZRF8mte319GcXKB2c1FflnhLTzwh+FR/Tm9FwkZqj0yCWi7jGnqXgAKmbH6ikckjMGTUmaumc6xy3LNC/ab0YZwXA01y9M+AiftZzlglI7NScZLWSjAUfHdC6Sh37ahNskcwNavBwHIGa6U7278SV4P1Ie6nSrR1dFPN3Ub7kkOMggbKnkwJZGuLPOSs9ebjczoify+QJ8/5hHkqp3YhUJyXJEAuvBEGlzy5QTTEiH7nW/z857OJDpQNYRwkhQmErIXEuTsia8sbkQOXrJ2YCBXfQ69yzyb3IiJ9mlL634VR6NRdeoMVBen48VnAZgHJJ+po5lBrKi7D161OEoKJ/EPgGhyIz3KEfba7SJa2ePMWTMww1/GLN1lre36A7Gl8H+j9aOKzI+DQhAeuql5lpXuHXBgTedTpGXRHswU96+ioJonl4d5Abr066Nz7AAWW1QLFJFZjA5+G9KDlWXextrdFa86cYYxcaWwiaqGVublHZDkJWuWKIjydqo8/Q3NbE3Ksdj+mtgW3wR0fkVrW4uOFJFNZysjgKv/DG3NofNKl8bqqKaHPWGYeYPOYbtn/DvEoLPD3RSMzi1p7kxWIphmQiJF16PDVmOMLzsg4o2VJUbT9zZQtvgwjMTh7AUAXuv/6GmnKmkEJxFEbFxpHjeX/VPYwWZ6SiKhLhzfnOyG1khUEWHbD/DmuJ7mrulpGWEIrlFj43PoyCxpB4qgV13GZ4N31uhtErfM+PGGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(66899024)(1076003)(4326008)(66574015)(16526019)(426003)(336012)(26005)(83380400001)(30864003)(5660300002)(8676002)(8936002)(54906003)(6916009)(70586007)(70206006)(478600001)(2616005)(316002)(36860700001)(36756003)(81166007)(356005)(82740400003)(6666004)(47076005)(2906002)(86362001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:52.4173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fa9ec8-7d24-4de2-7f2d-08dc0179df0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, PeiChen
 Huang <peichen.huang@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Fix minor issues in BW Allocation Phase2.

[How]
- In set_usb4_req_bw_req(), link->dpia_bw_alloc_config.response_ready
  flag should be reset before writing DPCD REQUEST_BW.
- Fix the granularity for value of 2 in get_bw_granularity().
- Removed bandwidth allocation support display fw boot option as
  the fw would read feature enable status from bios.
- Clean up DPIA_EST_BW_CHANGED and DPIA_BW_REQ_SUCCESS cases in
  dpia_handle_bw_alloc_response().
- Removed allocate_usb4_bw and deallocate_usb4_bw.
- Optimized loop in get_lowest_dpia_index().
- Updated link_dp_dpia_allocate_usb4_bandwidth_for_stream() and
  set_usb4_req_bw_req() to always issue request bw.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 .../dc/link/protocols/link_dp_dpia_bw.c       | 221 ++++++++----------
 .../dc/link/protocols/link_dp_dpia_bw.h       |   4 +-
 2 files changed, 101 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 7581023daa47..d6e1f969bfd5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -50,6 +50,7 @@ static bool get_bw_alloc_proceed_flag(struct dc_link *tmp)
 			&& tmp->hpd_status
 			&& tmp->dpia_bw_alloc_config.bw_alloc_enabled);
 }
+
 static void reset_bw_alloc_struct(struct dc_link *link)
 {
 	link->dpia_bw_alloc_config.bw_alloc_enabled = false;
@@ -59,6 +60,11 @@ static void reset_bw_alloc_struct(struct dc_link *link)
 	link->dpia_bw_alloc_config.bw_granularity = 0;
 	link->dpia_bw_alloc_config.response_ready = false;
 }
+
+#define BW_GRANULARITY_0 4 // 0.25 Gbps
+#define BW_GRANULARITY_1 2 // 0.5 Gbps
+#define BW_GRANULARITY_2 1 // 1 Gbps
+
 static uint8_t get_bw_granularity(struct dc_link *link)
 {
 	uint8_t bw_granularity = 0;
@@ -71,16 +77,20 @@ static uint8_t get_bw_granularity(struct dc_link *link)
 
 	switch (bw_granularity & 0x3) {
 	case 0:
-		bw_granularity = 4;
+		bw_granularity = BW_GRANULARITY_0;
 		break;
 	case 1:
+		bw_granularity = BW_GRANULARITY_1;
+		break;
+	case 2:
 	default:
-		bw_granularity = 2;
+		bw_granularity = BW_GRANULARITY_2;
 		break;
 	}
 
 	return bw_granularity;
 }
+
 static int get_estimated_bw(struct dc_link *link)
 {
 	uint8_t bw_estimated_bw = 0;
@@ -93,31 +103,7 @@ static int get_estimated_bw(struct dc_link *link)
 
 	return bw_estimated_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 }
-static bool allocate_usb4_bw(int *stream_allocated_bw, int bw_needed, struct dc_link *link)
-{
-	if (bw_needed > 0)
-		*stream_allocated_bw += bw_needed;
-
-	return true;
-}
-static bool deallocate_usb4_bw(int *stream_allocated_bw, int bw_to_dealloc, struct dc_link *link)
-{
-	bool ret = false;
-
-	if (*stream_allocated_bw > 0) {
-		*stream_allocated_bw -= bw_to_dealloc;
-		ret = true;
-	} else {
-		//Do nothing for now
-		ret = true;
-	}
 
-	// Unplug so reset values
-	if (!link->hpd_status)
-		reset_bw_alloc_struct(link);
-
-	return ret;
-}
 /*
  * Read all New BW alloc configuration ex: estimated_bw, allocated_bw,
  * granuality, Driver_ID, CM_Group, & populate the BW allocation structs
@@ -128,7 +114,12 @@ static void init_usb4_bw_struct(struct dc_link *link)
 	// Init the known values
 	link->dpia_bw_alloc_config.bw_granularity = get_bw_granularity(link);
 	link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+
+	DC_LOG_DEBUG("%s: bw_granularity(%d), estimated_bw(%d)\n",
+		__func__, link->dpia_bw_alloc_config.bw_granularity,
+		link->dpia_bw_alloc_config.estimated_bw);
 }
+
 static uint8_t get_lowest_dpia_index(struct dc_link *link)
 {
 	const struct dc *dc_struct = link->dc;
@@ -141,12 +132,15 @@ static uint8_t get_lowest_dpia_index(struct dc_link *link)
 				dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
 			continue;
 
-		if (idx > dc_struct->links[i]->link_index)
+		if (idx > dc_struct->links[i]->link_index) {
 			idx = dc_struct->links[i]->link_index;
+			break;
+		}
 	}
 
 	return idx;
 }
+
 /*
  * Get the Max Available BW or Max Estimated BW for each Host Router
  *
@@ -186,6 +180,7 @@ static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
 
 	return total_bw;
 }
+
 /*
  * Cleanup function for when the dpia is unplugged to reset struct
  * and perform any required clean up
@@ -194,42 +189,50 @@ static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
  *
  * return: none
  */
-static bool dpia_bw_alloc_unplug(struct dc_link *link)
+static void dpia_bw_alloc_unplug(struct dc_link *link)
 {
-	if (!link)
-		return true;
-
-	return deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-			link->dpia_bw_alloc_config.sink_allocated_bw, link);
+	if (link) {
+		DC_LOG_DEBUG("%s: resetting bw alloc config for link(%d)\n",
+			__func__, link->link_index);
+		link->dpia_bw_alloc_config.sink_allocated_bw = 0;
+		reset_bw_alloc_struct(link);
+	}
 }
+
 static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 {
 	uint8_t requested_bw;
 	uint32_t temp;
 
-	// 1. Add check for this corner case #1
-	if (req_bw > link->dpia_bw_alloc_config.estimated_bw)
+	/* Error check whether request bw greater than allocated */
+	if (req_bw > link->dpia_bw_alloc_config.estimated_bw) {
+		DC_LOG_ERROR("%s: Request bw greater than estimated bw for link(%d)\n",
+			__func__, link->link_index);
 		req_bw = link->dpia_bw_alloc_config.estimated_bw;
+	}
 
 	temp = req_bw * link->dpia_bw_alloc_config.bw_granularity;
 	requested_bw = temp / Kbps_TO_Gbps;
 
-	// Always make sure to add more to account for floating points
+	/* Always make sure to add more to account for floating points */
 	if (temp % Kbps_TO_Gbps)
 		++requested_bw;
 
-	// 2. Add check for this corner case #2
+	/* Error check whether requested and allocated are equal */
 	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-	if (req_bw == link->dpia_bw_alloc_config.sink_allocated_bw)
-		return;
+	if (req_bw == link->dpia_bw_alloc_config.sink_allocated_bw) {
+		DC_LOG_ERROR("%s: Request bw equals to allocated bw for link(%d)\n",
+			__func__, link->link_index);
+	}
 
-	if (core_link_write_dpcd(
+	link->dpia_bw_alloc_config.response_ready = false; // Reset flag
+	core_link_write_dpcd(
 		link,
 		REQUESTED_BW,
 		&requested_bw,
-		sizeof(uint8_t)) == DC_OK)
-		link->dpia_bw_alloc_config.response_ready = false; // Reset flag
+		sizeof(uint8_t));
 }
+
 /*
  * Return the response_ready flag from dc_link struct
  *
@@ -241,6 +244,7 @@ static bool get_cm_response_ready_flag(struct dc_link *link)
 {
 	return link->dpia_bw_alloc_config.response_ready;
 }
+
 // ------------------------------------------------------------------
 //					PUBLIC FUNCTIONS
 // ------------------------------------------------------------------
@@ -277,27 +281,27 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 				DPTX_BW_ALLOCATION_MODE_CONTROL,
 				&response,
 				sizeof(uint8_t)) != DC_OK) {
-			DC_LOG_DEBUG("%s: **** FAILURE Enabling DPtx BW Allocation Mode Support ***\n",
-					__func__);
+			DC_LOG_DEBUG("%s: FAILURE Enabling DPtx BW Allocation Mode Support for link(%d)\n",
+				__func__, link->link_index);
 		} else {
 			// SUCCESS Enabled DPtx BW Allocation Mode Support
-			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
-			DC_LOG_DEBUG("%s: **** SUCCESS Enabling DPtx BW Allocation Mode Support ***\n",
-					__func__);
+			DC_LOG_DEBUG("%s: SUCCESS Enabling DPtx BW Allocation Mode Support for link(%d)\n",
+				__func__, link->link_index);
 
 			ret = true;
 			init_usb4_bw_struct(link);
+			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
 		}
 	}
 
 out:
 	return ret;
 }
+
 void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
 	int bw_needed = 0;
 	int estimated = 0;
-	int host_router_total_estimated_bw = 0;
 
 	if (!get_bw_alloc_proceed_flag((link)))
 		return;
@@ -306,14 +310,22 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 
 	case DPIA_BW_REQ_FAILED:
 
-		DC_LOG_DEBUG("%s: *** *** BW REQ FAILURE for DP-TX Request *** ***\n", __func__);
+		/*
+		 * Ideally, we shouldn't run into this case as we always validate available
+		 * bandwidth and request within that limit
+		 */
+		estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 
-		// Update the new Estimated BW value updated by CM
-		link->dpia_bw_alloc_config.estimated_bw =
-				bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+		DC_LOG_ERROR("%s: BW REQ FAILURE for DP-TX Request for link(%d)\n",
+			__func__, link->link_index);
+		DC_LOG_ERROR("%s: current estimated_bw(%d), new estimated_bw(%d)\n",
+			__func__, link->dpia_bw_alloc_config.estimated_bw, estimated);
 
+		/* Update the new Estimated BW value updated by CM */
+		link->dpia_bw_alloc_config.estimated_bw = estimated;
+
+		/* Allocate the previously requested bandwidth */
 		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.estimated_bw);
-		link->dpia_bw_alloc_config.response_ready = false;
 
 		/*
 		 * If FAIL then it is either:
@@ -326,68 +338,34 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 
 	case DPIA_BW_REQ_SUCCESS:
 
-		DC_LOG_DEBUG("%s: *** BW REQ SUCCESS for DP-TX Request ***\n", __func__);
-
-		// 1. SUCCESS 1st time before any Pruning is done
-		// 2. SUCCESS after prev. FAIL before any Pruning is done
-		// 3. SUCCESS after Pruning is done but before enabling link
-
 		bw_needed = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 
-		// 1.
-		if (!link->dpia_bw_alloc_config.sink_allocated_bw) {
-
-			allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw, bw_needed, link);
-			link->dpia_bw_alloc_config.sink_verified_bw =
-					link->dpia_bw_alloc_config.sink_allocated_bw;
+		DC_LOG_DEBUG("%s: BW REQ SUCCESS for DP-TX Request for link(%d)\n",
+			__func__, link->link_index);
+		DC_LOG_DEBUG("%s: current allocated_bw(%d), new allocated_bw(%d)\n",
+			__func__, link->dpia_bw_alloc_config.sink_allocated_bw, bw_needed);
 
-			// SUCCESS from first attempt
-			if (link->dpia_bw_alloc_config.sink_allocated_bw >
-			link->dpia_bw_alloc_config.sink_max_bw)
-				link->dpia_bw_alloc_config.sink_verified_bw =
-						link->dpia_bw_alloc_config.sink_max_bw;
-		}
-		// 3.
-		else if (link->dpia_bw_alloc_config.sink_allocated_bw) {
-
-			// Find out how much do we need to de-alloc
-			if (link->dpia_bw_alloc_config.sink_allocated_bw > bw_needed)
-				deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-						link->dpia_bw_alloc_config.sink_allocated_bw - bw_needed, link);
-			else
-				allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-						bw_needed - link->dpia_bw_alloc_config.sink_allocated_bw, link);
-		}
-
-		// 4. If this is the 2nd sink then any unused bw will be reallocated to master DPIA
-		// => check if estimated_bw changed
+		link->dpia_bw_alloc_config.sink_allocated_bw = bw_needed;
 
 		link->dpia_bw_alloc_config.response_ready = true;
 		break;
 
 	case DPIA_EST_BW_CHANGED:
 
-		DC_LOG_DEBUG("%s: *** ESTIMATED BW CHANGED for DP-TX Request ***\n", __func__);
-
 		estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-		host_router_total_estimated_bw = get_host_router_total_bw(link, HOST_ROUTER_BW_ESTIMATED);
 
-		// 1. If due to unplug of other sink
-		if (estimated == host_router_total_estimated_bw) {
-			// First update the estimated & max_bw fields
-			if (link->dpia_bw_alloc_config.estimated_bw < estimated)
-				link->dpia_bw_alloc_config.estimated_bw = estimated;
-		}
-		// 2. If due to realloc bw btw 2 dpia due to plug OR realloc unused Bw
-		else {
-			// We lost estimated bw usually due to plug event of other dpia
-			link->dpia_bw_alloc_config.estimated_bw = estimated;
-		}
+		DC_LOG_DEBUG("%s: ESTIMATED BW CHANGED for link(%d)\n",
+			__func__, link->link_index);
+		DC_LOG_DEBUG("%s: current estimated_bw(%d), new estimated_bw(%d)\n",
+			__func__, link->dpia_bw_alloc_config.estimated_bw, estimated);
+
+		link->dpia_bw_alloc_config.estimated_bw = estimated;
 		break;
 
 	case DPIA_BW_ALLOC_CAPS_CHANGED:
 
-		DC_LOG_DEBUG("%s: *** BW ALLOC CAPABILITY CHANGED for DP-TX Request ***\n", __func__);
+		DC_LOG_ERROR("%s: BW ALLOC CAPABILITY CHANGED to Disabled for link(%d)\n",
+			__func__, link->link_index);
 		link->dpia_bw_alloc_config.bw_alloc_enabled = false;
 		break;
 	}
@@ -409,11 +387,11 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.sink_max_bw);
 
 		do {
-			if (!(timeout > 0))
+			if (timeout > 0)
 				timeout--;
 			else
 				break;
-			fsleep(10 * 1000);
+			msleep(10);
 		} while (!get_cm_response_ready_flag(link));
 
 		if (!timeout)
@@ -428,37 +406,36 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 out:
 	return ret;
 }
-int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
+
+bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
 {
-	int ret = 0;
+	bool ret = false;
 	uint8_t timeout = 10;
 
+	DC_LOG_DEBUG("%s: ENTER: link(%d), hpd_status(%d), current allocated_bw(%d), req_bw(%d)\n",
+		__func__, link->link_index, link->hpd_status,
+		link->dpia_bw_alloc_config.sink_allocated_bw, req_bw);
+
 	if (!get_bw_alloc_proceed_flag(link))
 		goto out;
 
-	/*
-	 * Sometimes stream uses same timing parameters as the already
-	 * allocated max sink bw so no need to re-alloc
-	 */
-	if (req_bw != link->dpia_bw_alloc_config.sink_allocated_bw) {
-		set_usb4_req_bw_req(link, req_bw);
-		do {
-			if (!(timeout > 0))
-				timeout--;
-			else
-				break;
-			udelay(10 * 1000);
-		} while (!get_cm_response_ready_flag(link));
+	set_usb4_req_bw_req(link, req_bw);
+	do {
+		if (timeout > 0)
+			timeout--;
+		else
+			break;
+		msleep(10);
+	} while (!get_cm_response_ready_flag(link));
 
-		if (!timeout)
-			ret = 0;// ERROR TIMEOUT waiting for response for allocating bw
-		else if (link->dpia_bw_alloc_config.sink_allocated_bw > 0)
-			ret = get_host_router_total_bw(link, HOST_ROUTER_BW_ALLOCATED);
-	}
+	if (timeout)
+		ret = true;
 
 out:
+	DC_LOG_DEBUG("%s: EXIT: timeout(%d), ret(%d)\n", __func__, timeout, ret);
 	return ret;
 }
+
 bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
 {
 	bool ret = true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 7292690383ae..981bc4eb6120 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -59,9 +59,9 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link);
  * @link: pointer to the dc_link struct instance
  * @req_bw: Bw requested by the stream
  *
- * return: allocated bw else return 0
+ * return: true if allocated successfully
  */
-int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
+bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
 
 /*
  * Handle the USB4 BW Allocation related functionality here:
-- 
2.42.0

