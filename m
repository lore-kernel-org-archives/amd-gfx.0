Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78140C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30B410E6C9;
	Fri,  3 Mar 2023 15:44:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503B910E6C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUFqImNwlcAJXBGQu9Z/hKHRoIgtBmt33h2sNWZau92V27dq/Lo+udsmkIAZanV/NG3XbCgZMhAyZ7SGgs1U5m5wWDD5gomEHrsDDy2BIpBuvRbKRvpZZXA3Uh6Z2LFYR8wQPQy7hX6y5o+DGlOdujPhzuzcubMaiIsTWFIF2cOd6QRCzas1uQ86OCnWlbEIIIyWbsRtpeRlcNYEYEvkbGJdpULyBbGVx6Q6E5/1e6tQSwe6j1X222vM7SVsLiz6plcyebdkztFWnGSRxynvZRQcZIGsuhPCXDDagJpLg1kRpk2fXMvEWCX1LBQj4pfW96F0kLIUz99Sqihuf+amPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWSem2SThJGSvzLbcwAV0F6ZJWGYqmhUX8j7ERJ8oao=;
 b=CZ/pwc9g/PNAXHQ5Hm7E4FiPOKge4cgUtSZT9E7UzTZgtKaWE2Q5K0F6mr+WirmtvqDY1luXddLrX3T18XoYKT+NwJm4jsZykzV60124x577GeOEM3cigYTThELtAHxLHP9ZF9Hxj2IkzfTHQIoZQ7qsq9t8p/H4MGJ6NVoMt8fReGI+AcDCpokxi3y1uJZz2bXBRk3jWsff9tAo9UyEgJpSRmNWaqpKEpXyPvZgxZwsTHeANPj+42YWj0KWEzzuQqG3yxmmkJGwDark5CFmrr7a188yjB1krd41YjgKSqwxH8zbKd7QsCT7B3O4NFNghyS+eRyA3L8NvnCHMhbwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWSem2SThJGSvzLbcwAV0F6ZJWGYqmhUX8j7ERJ8oao=;
 b=miXouaFeVV1TLib8nmqN6xFE75SfbxyYL2sPkA34w0hQ/wo6TpzZDOFTFf8mg/kUKG8PuIG4tFPLSmDscVCoG4Uhb0jIqRJOHt1PMJBFGpKstSjKKWQFE8jsF/71kIxjpFtuDN3Krwu5pO+W8wDevmyihdaR8+Z/I6lMW0TMGVg=
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 15:44:26 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::8) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.21 via Frontend Transport; Fri, 3 Mar 2023 15:44:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:44:03 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/33] drm/amd/display: Unify DC logging for BW Alloc
Date: Fri, 3 Mar 2023 10:39:51 -0500
Message-ID: <20230303154022.2667-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e5c314-7e9d-4eef-2c9b-08db1bfe2ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ib7M/cJ7QKAZLhGihJnM74B0aw38HwTSzK5wKoLQe2cBaQzuX+r6zRYeus+tU8L7005nNpAgpSryxnPDSldILKGQT7VU89K9OtiHFWaeK+vNUvLoqKUmWgo/ILoVZHh8AiNWnjC0PO/b9M9+V5gJSuCYuiZWNU2M6bk5oB279OfqCA6g36/ULNt4jz1KR7Y2B+8tKuYU+V7NlrAYemZSK2uxSYaupX+iCV0xZMN1kN2dZy888vQaveoX5aI9tDeEDzhc5DwEOH0cO2cAy5dVVdRBYLWEFBRIakxR2BotZCiCgpo2X8YldiO9u/WJBtnmBzPlSLl9q8dYRFZ4Yx0L8sP5l/gw/OkcSDIuU6ivo7MoE0OE534LU5lL9M487vMZHfDOo3Ofn9E98uwHbVSBcT0CNjqYa6YBDBE62n7ZtTrtorzKj8FgvfkBfHhpYaTCa3drKuL3V9N9mAI6GLjFC7ivvyl37MKqXZtcNtWK7mhID2nynjA4GDeAtfwIeqZKfve/5oTSnU2ac3QEpGTHOd5E8+aFlI2lsGDP7IxFIJmBj1FXftftgea9BulPTwVJvJWkeKmf0O9FMRxAuNBdjsTQHq5CRkoxGcrkx+QjJotfnrx+F9j4FaDeDHC8MUtAn0F5HXB+s7KtwmqaYy0l/gOzkIJNi2+nlV2BZDntdKGvWePLuh0ge6vKcH0soAkTdG9W2qns44AwAbDPl5Ka+1Fb7XrUgiiuBJpISDkX99M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(66574015)(40460700003)(47076005)(6666004)(8676002)(1076003)(186003)(16526019)(336012)(2616005)(26005)(6916009)(316002)(41300700001)(54906003)(4326008)(70206006)(70586007)(2906002)(5660300002)(8936002)(81166007)(82740400003)(478600001)(40480700001)(44832011)(86362001)(82310400005)(356005)(83380400001)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:44:25.6800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e5c314-7e9d-4eef-2c9b-08db1bfe2ae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Meenakshikumar
 Somasundaram <Meenakshikumar.Somasundaram@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
To keep all logging within DC unified

[HOW]
Use the standard DC Logging functions

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 .../dc/link/protocols/link_dp_dpia_bw.c       | 56 +++++++++----------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 7b32fd010f11..c950857ef02c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -31,6 +31,9 @@
 #include "drm_dp_helper_dc.h"
 #include "link_dpcd.h"
 
+#define DC_LOGGER \
+	link->ctx->logger
+
 #define Kbps_TO_Gbps (1000 * 1000)
 
 // ------------------------------------------------------------------
@@ -83,12 +86,11 @@ static int get_estimated_bw(struct dc_link *link)
 {
 	uint8_t bw_estimated_bw = 0;
 
-	if (core_link_read_dpcd(
-		link,
-		ESTIMATED_BW,
-		&bw_estimated_bw,
-		sizeof(uint8_t)) != DC_OK)
-		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, ESTIMATED_BW);
+	core_link_read_dpcd(
+			link,
+			ESTIMATED_BW,
+			&bw_estimated_bw,
+			sizeof(uint8_t));
 
 	return bw_estimated_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 }
@@ -226,9 +228,7 @@ static void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 		link,
 		REQUESTED_BW,
 		&requested_bw,
-		sizeof(uint8_t)) != DC_OK)
-		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, REQUESTED_BW);
-	else
+		sizeof(uint8_t)) == DC_OK)
 		link->dpia_bw_alloc_config.response_ready = false; // Reset flag
 }
 /*
@@ -256,22 +256,18 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 		goto out;
 
 	if (core_link_read_dpcd(
-		link,
-		DP_TUNNELING_CAPABILITIES,
-		&response,
-		sizeof(uint8_t)) != DC_OK)
-		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, DP_TUNNELING_CAPABILITIES);
-
-	bw_support_dpia = (response >> 7) & 1;
+			link,
+			DP_TUNNELING_CAPABILITIES,
+			&response,
+			sizeof(uint8_t)) == DC_OK)
+		bw_support_dpia = (response >> 7) & 1;
 
 	if (core_link_read_dpcd(
 		link,
 		USB4_DRIVER_BW_CAPABILITY,
 		&response,
-		sizeof(uint8_t)) != DC_OK)
-		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, DP_TUNNELING_CAPABILITIES);
-
-	bw_support_cm = (response >> 7) & 1;
+		sizeof(uint8_t)) == DC_OK)
+		bw_support_cm = (response >> 7) & 1;
 
 	/* Send request acknowledgment to Turn ON DPTX support */
 	if (bw_support_cm && bw_support_dpia) {
@@ -281,15 +277,15 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 				link,
 				DPTX_BW_ALLOCATION_MODE_CONTROL,
 				&response,
-				sizeof(uint8_t)) != DC_OK)
-			dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n",
-					"**** FAILURE Enabling DPtx BW Allocation Mode Support ***\n",
-					__func__, DP_TUNNELING_CAPABILITIES);
-		else {
+				sizeof(uint8_t)) != DC_OK) {
+			DC_LOG_DEBUG("%s: **** FAILURE Enabling DPtx BW Allocation Mode Support ***\n",
+					__func__);
+		} else {
 
 			// SUCCESS Enabled DPtx BW Allocation Mode Support
 			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
-			dm_output_to_console("**** SUCCESS Enabling DPtx BW Allocation Mode Support ***\n");
+			DC_LOG_DEBUG("%s: **** SUCCESS Enabling DPtx BW Allocation Mode Support ***\n",
+					__func__);
 
 			ret = true;
 			init_usb4_bw_struct(link);
@@ -308,7 +304,7 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 
 	case DPIA_BW_REQ_FAILED:
 
-		dm_output_to_console("%s: *** *** BW REQ FAILURE for DP-TX Request *** ***\n", __func__);
+		DC_LOG_DEBUG("%s: *** *** BW REQ FAILURE for DP-TX Request *** ***\n", __func__);
 
 		// Update the new Estimated BW value updated by CM
 		link->dpia_bw_alloc_config.estimated_bw =
@@ -328,7 +324,7 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 
 	case DPIA_BW_REQ_SUCCESS:
 
-		dm_output_to_console("%s: *** BW REQ SUCCESS for DP-TX Request ***\n", __func__);
+		DC_LOG_DEBUG("%s: *** BW REQ SUCCESS for DP-TX Request ***\n", __func__);
 
 		// 1. SUCCESS 1st time before any Pruning is done
 		// 2. SUCCESS after prev. FAIL before any Pruning is done
@@ -369,7 +365,7 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 
 	case DPIA_EST_BW_CHANGED:
 
-		dm_output_to_console("%s: *** ESTIMATED BW CHANGED for DP-TX Request ***\n", __func__);
+		DC_LOG_DEBUG("%s: *** ESTIMATED BW CHANGED for DP-TX Request ***\n", __func__);
 
 		int available = 0, estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 		int host_router_total_estimated_bw = get_host_router_total_bw(link, HOST_ROUTER_BW_ESTIMATED);
@@ -397,7 +393,7 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 
 	case DPIA_BW_ALLOC_CAPS_CHANGED:
 
-		dm_output_to_console("%s: *** BW ALLOC CAPABILITY CHANGED for DP-TX Request ***\n", __func__);
+		DC_LOG_DEBUG("%s: *** BW ALLOC CAPABILITY CHANGED for DP-TX Request ***\n", __func__);
 		link->dpia_bw_alloc_config.bw_alloc_enabled = false;
 		break;
 	}
-- 
2.34.1

