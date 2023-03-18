Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C3EC61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE7210E32E;
	Sat, 18 Mar 2023 07:57:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0357410E32E
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpWOziXuE7aDszcXNv3UHpFXiyyWTZ+6TU+ud+KG758c6pSMTEDfazzF+zMu/+r+ganasHaKSjCBf6ctoU7F9cUYZm9bYwq8bP2cJjsEd9hwvzTefinGPggRc4TqhsReiJm15zNzYOztxw+KPihfQKsE0DULjaoPULXweYlqfHdkx4h6+kTkG6GtGApLKvnMIEK2fs2rJgQZMoOPpvMxLnYogjsbkOGck/4zqbIBwJFXlEaPgpYZrdwolX9kBscxnxKdpBVMHi7/M0iZrlOH77N13O6jTpA1Q+60vfY+oJJQdYDpT7KrJYNZl6su7B8w6UbsJz80gLbo3BJ9NHxRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXP2VrFWGOJBeFWjQJqVbUmri4QpEKtYt5chSVhQxD0=;
 b=S7Ty3YQ9Ujq0w5+6WF/yN4rSh6T993Q98owVUfrIusAiMEddG/Z1yIAXC6YsapZTzzuvDHHmclNXLFIqzWOf58dm2G2DCUXitOTbEzlgbRDLGI6foNg18Km3VsMWAPTGLHHrLR13yGd5NtDi6wwkmSAevQZU4yF1R53e6g6oal5oYJpePXli60FdkrfOaRIaCW6XYrDTT4OFUwrRjLzSc+Vhw7yqX//H0BBXkyvlQLVIrJKZB3L+7ek1A3i9O/XCsRKava2fJ68YIib7nJ8hP5LDsgmx7lQQ/j8KfAdrZLkgA9tEgyPnomvMKdIO13SZX3eRPrvPhx2Zwe37efemqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXP2VrFWGOJBeFWjQJqVbUmri4QpEKtYt5chSVhQxD0=;
 b=D2oz6A9duwuBCiSRNQBsfoiFADQHNbK+8bWzC720qcrJx7zYmPsGqk//4zEI3+V2nifTH3KF2vD/XTAQUTcx3x2ly+0ghMVirPTIktHZqsEzV9frNFofPczJfwKc9RjtSFlVPcvEBvP6crLSRl83CmrwXrJt2G+z0H5YGgRr990=
Received: from BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sat, 18 Mar
 2023 07:57:20 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e5) by BN9PR03CA0984.outlook.office365.com
 (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:57:20 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:15 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amd/display: Add function pointer for validate bw
 usb4
Date: Sat, 18 Mar 2023 03:56:05 -0400
Message-ID: <20230318075615.2630-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca49c5c-325e-48fd-6254-08db2786669a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzUsoMhMcGQ+nFTfzERVb15Yn25pu9VIS9olIC9yfY5waW1xkX+D4TIZtKSiRI+oRrxxqFSLIM+10jL0n7PF0yyK1CHUJ3T5yT75QJ0hEbOXDyHNgz91pLekMpwsIt/pA7mHkCBVXALAgWdE3OPY5ZV7exYll7wleiDZiM6TGaI6SCC1TTICGEuJ90T0Za6bq8zTQPxV1itettqN4mkPZLh2EO+nikRl7jiyrKho6QLXaOeC0StQTdOsfaXT2fqW8OOtvnH9mjUp2+GuIb5RM7EpI1NrPGCDoWBEwHeHg94uI3U3Z/cFy0oTX5hcw6nCoSQqXoM5GB1RE4nKd9ntctxMPNe4DYvAff+mqhNqAnS9URcxyVpqPdmK5Y/ljKjIUtVRVk2ESAdyLLagguiQzXagNIfAPglvCQhKe+wORS2x+XNgAdh/jGRKVEpZeKlZAk4LYdUM0/ySB3LG03KAyD33sfW0RVuv/YedS9dJ8oQAN+4VwB+R5stFxUmtS015eOdOV8UIY7DsmNqv+ZiKsQq0sa5CcK/pACNM6yFHLVvmQZR8VPqqMLEkidsCdrj+bCuDx7u6vINh4mwVh1palEnhMRcpSa+jVlntwmb8AePQNs4nwegc8kzHsFoyTGBenii5YhKTSxZPD5LCkZWsxFoTDXUVdrD6w5HLVcIEoq79r2Ezeg5oyHs6tVE2LTemMymZRDy3m8ya1WqpN70IzgVKFNcMPMVMNQ+6N0xSAP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(15650500001)(81166007)(47076005)(316002)(41300700001)(83380400001)(8936002)(66574015)(36756003)(40460700003)(356005)(5660300002)(86362001)(70206006)(6916009)(8676002)(186003)(70586007)(82740400003)(4326008)(16526019)(40480700001)(54906003)(44832011)(36860700001)(478600001)(426003)(82310400005)(1076003)(2616005)(6666004)(336012)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:20.3083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca49c5c-325e-48fd-6254-08db2786669a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
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
Cc: stylon.wang@amd.com, Kshitij Bhardwaj <kshitij.bhardwaj1@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
In order to follow the new protocol of calling link functions

[HOW]
Add the function pointer to the link_srv

Reviewed-by: Kshitij Bhardwaj <kshitij.bhardwaj1@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c  |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h            | 13 +++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/link.h      |  3 +++
 .../gpu/drm/amd/display/dc/link/link_factory.c |  1 +
 .../drm/amd/display/dc/link/link_validation.c  | 18 ++++++++++++++++++
 .../drm/amd/display/dc/link/link_validation.h  |  4 ++++
 .../dc/link/protocols/link_dp_dpia_bw.c        |  9 ++-------
 .../dc/link/protocols/link_dp_dpia_bw.h        |  7 ++++++-
 8 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index d24bc0a0b1d4..18e098568cb4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -473,3 +473,8 @@ void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
 {
 	link->dc->link_srv->enable_hpd_filter(link, enable);
 }
+
+bool dc_link_validate(struct dc *dc, const struct dc_stream_state *streams, const unsigned int count)
+{
+	return dc->link_srv->validate_dpia_bandwidth(streams, count);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 624acd402eae..1e6fa2d387f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2028,6 +2028,19 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link,
 int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
 		struct dc_link *link, int peak_bw);
 
+/*
+ * Validate the BW of all the valid DPIA links to make sure it doesn't exceed
+ * available BW for each host router
+ *
+ * @dc: pointer to dc struct
+ * @stream: pointer to all possible streams
+ * @num_streams: number of valid DPIA streams
+ *
+ * return: TRUE if bw used by DPIAs doesn't exceed available BW else return FALSE
+ */
+bool dc_link_validate(struct dc *dc, const struct dc_stream_state *streams,
+		const unsigned int count);
+
 /* Sink Interfaces - A sink corresponds to a display output device */
 
 struct dc_container_id {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 11aaa7a9518a..f839494d59d8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -144,6 +144,9 @@ struct link_service {
 	uint32_t (*dp_link_bandwidth_kbps)(
 		const struct dc_link *link,
 		const struct dc_link_settings *link_settings);
+	bool (*validate_dpia_bandwidth)(
+			const struct dc_stream_state *stream,
+			const unsigned int num_streams);
 
 
 	/*************************** DPMS *************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 3951d48118c4..1515c817f03b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -99,6 +99,7 @@ static void construct_link_service_validation(struct link_service *link_srv)
 {
 	link_srv->validate_mode_timing = link_validate_mode_timing;
 	link_srv->dp_link_bandwidth_kbps = dp_link_bandwidth_kbps;
+	link_srv->validate_dpia_bandwidth = link_validate_dpia_bandwidth;
 }
 
 /* link dpms owns the programming sequence of stream's dpms state associated
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 9a5010f86003..139012ab20e3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -30,6 +30,7 @@
  */
 #include "link_validation.h"
 #include "protocols/link_dp_capability.h"
+#include "protocols/link_dp_dpia_bw.h"
 #include "resource.h"
 
 #define DC_LOGGER_INIT(logger)
@@ -394,3 +395,20 @@ enum dc_status link_validate_mode_timing(
 
 	return DC_OK;
 }
+
+bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const unsigned int num_streams)
+{
+	bool ret = true;
+	int bw_needed[MAX_DPIA_NUM];
+	struct dc_link *link[MAX_DPIA_NUM];
+
+	if (!num_streams || num_streams > MAX_DPIA_NUM)
+		return ret;
+
+	for (uint8_t i = 0; i < num_streams; ++i) {
+
+		link[i] = stream[i].link;
+		bw_needed[i] = dc_bandwidth_in_kbps_from_timing(&stream[i].timing);
+	}
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.h b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
index 2191d3a4950c..4a954317d0da 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
@@ -29,7 +29,11 @@ enum dc_status link_validate_mode_timing(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
 		const struct dc_crtc_timing *timing);
+bool link_validate_dpia_bandwidth(
+		const struct dc_stream_state *stream,
+		const unsigned int num_streams);
 uint32_t dp_link_bandwidth_kbps(
 	const struct dc_link *link,
 	const struct dc_link_settings *link_settings);
+
 #endif /* __LINK_VALIDATION_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 2e251dcbb022..ac7166f600a8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -33,10 +33,6 @@
 #define DC_LOGGER \
 	link->ctx->logger
 
-/* Number of Host Routers per motherboard is 2 */
-#define MAX_HR_NUM			2
-/* Number of DPIA per host router is 2 */
-#define MAX_DPIA_NUM		(MAX_HR_NUM * 2)
 #define Kbps_TO_Gbps (1000 * 1000)
 
 // ------------------------------------------------------------------
@@ -377,9 +373,8 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 		// 1. If due to unplug of other sink
 		if (estimated == host_router_total_estimated_bw) {
 			// First update the estimated & max_bw fields
-			if (link->dpia_bw_alloc_config.estimated_bw < estimated) {
+			if (link->dpia_bw_alloc_config.estimated_bw < estimated)
 				link->dpia_bw_alloc_config.estimated_bw = estimated;
-			}
 		}
 		// 2. If due to realloc bw btw 2 dpia due to plug OR realloc unused Bw
 		else {
@@ -462,7 +457,7 @@ int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int re
 out:
 	return ret;
 }
-bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, uint8_t num_dpias)
+bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
 {
 	bool ret = true;
 	int bw_needed_per_hr[MAX_HR_NUM] = { 0, 0 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 382616c8b698..7292690383ae 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -28,6 +28,11 @@
 
 #include "link.h"
 
+/* Number of Host Routers per motherboard is 2 */
+#define MAX_HR_NUM			2
+/* Number of DPIA per host router is 2 */
+#define MAX_DPIA_NUM		(MAX_HR_NUM * 2)
+
 /*
  * Host Router BW type
  */
@@ -92,6 +97,6 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
  *
  * return: TRUE if bw used by DPIAs doesn't exceed available BW else return FALSE
  */
-bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, uint8_t num_dpias);
+bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, const unsigned int num_dpias);
 
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
-- 
2.34.1

