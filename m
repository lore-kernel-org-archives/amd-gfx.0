Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E70C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26A210E563;
	Tue, 25 Feb 2025 06:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RsAGQ111";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5EA10E563
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkHANzY2KZJ6meuT1rEOcgxvpmhQjZ+yjJ5h6lBqnIGfEjVgv0SXQTVtzH78jBYsTMpgzK60uiToA39hU7V6mcDh2AOH4WZWtNXWowsM+mSUkXVteqiQ3iXGI5pZHbVIKbj7YNFiQrqyX4i7BZUXzkxfGBPjKHaPtUN35wVpHkK/ZkdLcoo85gwhzVl1o9OQkeiuRQ2FOIbljwwI9p/ZBhajWq+zij0Rp87lMDOD2W0g1X3WB+sJ9JDW1x91n0VwVSpEmKBIg7lFErnq7CZxe332UZ1kWDiAkt/ZILtecYdcvVIJ6z1hZEVlQGiOe9VsRnAOjTcaFo95KEboLVgSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEvjhMzAUJBoiF86p7vYWchbvWSyYLwQhTUz4e1UIFM=;
 b=XZem6xUnH2dyB/tSVhbAwO4ZIY7YU0KI1uR52DjiF1lCro+fckgz6SwoBLBqQ0PBn6h3gFyBsbvv7OEyzlVbI9Tdr1AwCaZYGMfrKXRxW0fVjoBuBLA4ypBmaLBy7W05Ex/9DZ2pYICe/VR8d7XROcpQgqJ7lkpK53aavJu++FA7MF0bZoXSgaWWY2K5DGhoG/efn1zoW2/GR1sSBQdjRIR978ncEV2A6GBVVmvXNiRLz0OSuzosolHIPTOTexMfuUbn7TB+LwlTm43KF3SHZn8nMYjpoFWmvX6arEOpSVEHxwu8qp3GpjdPKkBECaY25T0GNFMGdl2vAj/DqzkhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEvjhMzAUJBoiF86p7vYWchbvWSyYLwQhTUz4e1UIFM=;
 b=RsAGQ111neVkrCBFJ65oZ7OTkm3pbYR8NfDzhTRm2RmcDf4VOaevjFFRVre2htZlaiMCiemAsYqVo9pG+h5hvxKcDcwhmyFdabPZJ1ds9l+V06eAxVtAptaJ6BXl+HRfP1lSh+OfCrTfH5bUI1B4luM76gdO43TdQujDClwXIq0=
Received: from BYAPR02CA0043.namprd02.prod.outlook.com (2603:10b6:a03:54::20)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Tue, 25 Feb
 2025 06:37:38 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::c6) by BYAPR02CA0043.outlook.office365.com
 (2603:10b6:a03:54::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:37 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:32 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 13/27] drm/amd/display: Add tunneling IRQ handler
Date: Tue, 25 Feb 2025 14:35:56 +0800
Message-ID: <20250225063610.631461-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: fe81323a-1a69-437d-8228-08dd5566e5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WFuUwHxjt0XU9kbbx5aIlUAZmnRhqpIUDqy4hIR14VE1q1dO+LmmIL4OroXa?=
 =?us-ascii?Q?FrKVv68/cUOQ7n+F5aC/C0tqis9N1dhLNaPE9WqR1NQnEru6yqIW4FpvS2PH?=
 =?us-ascii?Q?x/WqhwNhkd5GLTNjDodqr1jRHRWnaCBRYgKluh6/4juEahHCRIbQDBwVWFYs?=
 =?us-ascii?Q?Z6s/9oV7qJTR4qRENlqheqTq8Q78t3uQdvV8q0w/yXvfowS02AaWuCmtWOfW?=
 =?us-ascii?Q?fgRO1oi8zTsA2gKnQVWxK9d/QcnOv8eNnA1bTSI7DHRTfUqdD/D3ZZ88rSuU?=
 =?us-ascii?Q?gT7eqtgTSTsYFT6qikVtw5EUvGg+mtdI335lacC+m87IGoL2Y47aG0xSRmcY?=
 =?us-ascii?Q?e8sIP2f6IY/JU1stT9J8K/LSZFpiQelv5tf8ab0vCJ7MmED2uXHJDsseTq2/?=
 =?us-ascii?Q?QTQVdv4rljDSLKgl4/CHtZy7sO5u0mySXKccMUXRXcLu5O7fq3PoNTTybJxZ?=
 =?us-ascii?Q?6sYlgWUfq+l7BCYPioT0caUrMdBnQ3lYZte8S/ZuH5bf2mZxgebIVGEp9rr7?=
 =?us-ascii?Q?LAMPWbn9MLwBKNRlMdVFONy5L+XA+9MAtTQcrMImC6u1i7cTsxddMXUClMiU?=
 =?us-ascii?Q?7eq3puH5an43lW3X1nP+LDXu2DwwlmxOsyvhnzv5m8FaLI+OgRq4lGaVDSqj?=
 =?us-ascii?Q?3SRVgIpHKc9ZwPA/f/cWkV5FIYgiPil7BqybRUdhEJPh4fX6rWnqTttfjuQg?=
 =?us-ascii?Q?cqpTVZsMtigsHVx0tczuU3YhanHTsYxBOcI5NBmPUBxOQ9Ia/7Fy/fJ57vqK?=
 =?us-ascii?Q?hVXsu/bqsVJQ/+QzBN5hROulZzZuXW2hPHMEOrd1BOZ/BGi9ov10ZpAt4p2q?=
 =?us-ascii?Q?3yiq07vxYKqUPSnoLZ4PaQW+IcSlUzALX93Z6NZ5LSq7JyLJl0h0mz9tnjAN?=
 =?us-ascii?Q?+2fmYlQOMm5QpJKQsRoDrqMD9TBTffBblOR9LOkBBYm7XRrm9ZD3RjLVEBjJ?=
 =?us-ascii?Q?vVrZUC7D+bFCajEPteAo8B79bH4iLxlYyUKOuH7Y/ZcQoYmliVHEVv9DKCFN?=
 =?us-ascii?Q?muKCMQkqb7AiZNqDyaxAQu58Lb045CPYY84q+Xu//cC7rUzg/wIO6sAomlAN?=
 =?us-ascii?Q?x+f3a5DXGHeisE3xn8sz3v/H+f6fx9RxM5zOH6m2TLa0sc8h5YnjBDZ/j98t?=
 =?us-ascii?Q?6gQamwB5ETDpCYnR7PQ4O8CgP2z9frvwz8vEJGdmBxNK2MFrMhekRpnJ6u8I?=
 =?us-ascii?Q?fYO5OBdamHlC6QHYAbV+uORgxtUJ4c2teL3Qd7rWMbBKlJsR4h3nd5bdiLt8?=
 =?us-ascii?Q?ngp/rqpcK1VkEa/o/PX0yLihcu6TmtHxAOl3Kmq8q/7nj7eihZJAB9H6I5mI?=
 =?us-ascii?Q?O29tgReNgraEA7sm7/OHS4H0A9vpLxuyIPB7DqZA2gQNCB+yU+W4hSbodyJ4?=
 =?us-ascii?Q?d0Bgw5AqiqKRXkh/JGc5pGa45dY59mYwLpLEfZkJomTOAPG9dOg11St6RpCa?=
 =?us-ascii?Q?EgDVxcl+G4ynUiV9CxCsGeVD/tXgTbJlor1SvfoLcljVaCYqfzBMofi/vzxD?=
 =?us-ascii?Q?CmLBoKuR8IWkIq8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:38.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe81323a-1a69-437d-8228-08dd5566e5bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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

USB4 DP BW Allocation uses DP_TUNNELING_IRQ to indicate the status update.
The DP_TUNNELING_IRQ is defined in LINK_SERVICE_IRQ_VECTOR_ESI0. When
receiving DP HPD IRQ in USB4, read the LINK_SERVICE_IRQ_VECTOR_ESI0.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 40 +++++++++++++++--
 .../dc/link/protocols/link_dp_dpia_bw.c       | 26 +++++++++++
 .../dc/link/protocols/link_dp_dpia_bw.h       | 10 +++++
 .../dc/link/protocols/link_dp_irq_handler.c   | 43 +++++++++++++++++--
 4 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index d988c00f5ca4..1f4f11adc491 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -300,6 +300,19 @@ union lane_align_status_updated {
 	uint8_t raw;
 };
 
+union link_service_irq_vector_esi0 {
+	struct {
+		uint8_t DP_LINK_RX_CAP_CHANGED:1;
+		uint8_t DP_LINK_STATUS_CHANGED:1;
+		uint8_t DP_LINK_STREAM_STATUS_CHANGED:1;
+		uint8_t DP_LINK_HDMI_LINK_STATUS_CHANGED:1;
+		uint8_t DP_LINK_CONNECTED_OFF_ENTRY_REQUESTED:1;
+		uint8_t DP_LINK_TUNNELING_IRQ:1;
+		uint8_t reserved:2;
+	} bits;
+	uint8_t raw;
+};
+
 union lane_adjust {
 	struct {
 		uint8_t VOLTAGE_SWING_LANE:2;
@@ -462,8 +475,10 @@ union sink_status {
 	uint8_t raw;
 };
 
-/*6-byte structure corresponding to 6 registers (200h-205h)
-read during handling of HPD-IRQ*/
+/* 7-byte structure corresponding to 6 registers (200h-205h)
+ * and LINK_SERVICE_IRQ_ESI0 (2005h) for tunneling IRQ
+ * read during handling of HPD-IRQ
+ */
 union hpd_irq_data {
 	struct {
 		union sink_count sink_cnt;/* 200h */
@@ -471,9 +486,10 @@ union hpd_irq_data {
 		union lane_status lane01_status;/* 202h */
 		union lane_status lane23_status;/* 203h */
 		union lane_align_status_updated lane_status_updated;/* 204h */
-		union sink_status sink_status;
+		union sink_status sink_status;/* 205h */
+		union link_service_irq_vector_esi0 link_service_irq_esi0;/* 2005h */
 	} bytes;
-	uint8_t raw[6];
+	uint8_t raw[7];
 };
 
 union down_stream_port_count {
@@ -1430,4 +1446,20 @@ struct dp_trace {
 #ifndef REQUESTED_BW
 #define REQUESTED_BW					0xE0031 /* 1.4a */
 #endif
+# ifndef DP_TUNNELING_BW_ALLOC_BITS_MASK
+# define DP_TUNNELING_BW_ALLOC_BITS_MASK		(0x0F << 0)
+# endif
+# ifndef DP_TUNNELING_BW_REQUEST_FAILED
+# define DP_TUNNELING_BW_REQUEST_FAILED			(1 << 0)
+# endif
+# ifndef DP_TUNNELING_BW_REQUEST_SUCCEEDED
+# define DP_TUNNELING_BW_REQUEST_SUCCEEDED		(1 << 1)
+# endif
+# ifndef DP_TUNNELING_ESTIMATED_BW_CHANGED
+# define DP_TUNNELING_ESTIMATED_BW_CHANGED		(1 << 2)
+# endif
+# ifndef DP_TUNNELING_BW_ALLOC_CAP_CHANGED
+# define DP_TUNNELING_BW_ALLOC_CAP_CHANGED		(1 << 3)
+# endif
+
 #endif /* DC_DP_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 0f1c411523a2..a5541b8fc95b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -356,6 +356,32 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 	return ret;
 }
 
+/*
+ * Handle DP BW allocation status register
+ *
+ * @link: pointer to the dc_link struct instance
+ * @status: content of DP tunneling status DPCD register
+ *
+ * return: none
+ */
+void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status)
+{
+	if (status & DP_TUNNELING_BW_REQUEST_SUCCEEDED) {
+		DC_LOG_DEBUG("%s: BW Allocation request succeeded on link(%d)",
+				__func__, link->link_index);
+	} else if (status & DP_TUNNELING_BW_REQUEST_FAILED) {
+		DC_LOG_DEBUG("%s: BW Allocation request failed on link(%d)  allocated/estimated BW=%d",
+				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
+	} else if (status & DP_TUNNELING_ESTIMATED_BW_CHANGED) {
+		DC_LOG_DEBUG("%s: Estimated BW changed on link(%d)  new estimated BW=%d",
+				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
+	}
+
+	core_link_write_dpcd(
+		link, DP_TUNNELING_STATUS,
+		&status, sizeof(status));
+}
+
 void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
 	int bw_needed = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 3b6d8494f9d5..1b240a2f6ce0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -108,4 +108,14 @@ bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, const unsigned
  */
 int link_dp_dpia_get_dp_overhead_in_dp_tunneling(struct dc_link *link);
 
+/*
+ * Handle DP BW allocation status register
+ *
+ * @link: pointer to the dc_link struct instance
+ * @status: content of DP tunneling status register
+ *
+ * return: none
+ */
+void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status);
+
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index a08403c022ea..5be00e4ce10b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -37,6 +37,7 @@
 #include "link/accessories/link_dp_trace.h"
 #include "link/link_dpms.h"
 #include "dm_helpers.h"
+#include "link_dp_dpia_bw.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
@@ -286,6 +287,30 @@ void dp_handle_link_loss(struct dc_link *link)
 	}
 }
 
+static void dp_handle_tunneling_irq(struct dc_link *link)
+{
+	enum dc_status retval;
+	uint8_t tunneling_status = 0;
+
+	retval = core_link_read_dpcd(
+			link, DP_TUNNELING_STATUS,
+			&tunneling_status,
+			sizeof(tunneling_status));
+
+	if (retval == DC_OK) {
+		DC_LOG_HW_HPD_IRQ("%s: Got DP tunneling status on link %d status=0x%x",
+				__func__, link->link_index, tunneling_status);
+
+		if (tunneling_status & DP_TUNNELING_BW_ALLOC_BITS_MASK)
+			link_dp_dpia_handle_bw_alloc_status(link, tunneling_status);
+	}
+
+	tunneling_status = DP_TUNNELING_IRQ;
+	core_link_write_dpcd(
+		link, DP_LINK_SERVICE_IRQ_VECTOR_ESI0,
+		&tunneling_status, 1);
+}
+
 static void read_dpcd204h_on_irq_hpd(struct dc_link *link, union hpd_irq_data *irq_data)
 {
 	enum dc_status retval;
@@ -319,13 +344,19 @@ enum dc_status dp_read_hpd_rx_irq_data(
 	 *
 	 * For DP 1.4 we need to read those from 2002h range.
 	 */
-	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_14)
+	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_14) {
 		retval = core_link_read_dpcd(
 			link,
 			DP_SINK_COUNT,
 			irq_data->raw,
-			sizeof(union hpd_irq_data));
-	else {
+			DP_SINK_STATUS - DP_SINK_COUNT + 1);
+
+		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+			retval = core_link_read_dpcd(
+					link, DP_LINK_SERVICE_IRQ_VECTOR_ESI0,
+					&irq_data->bytes.link_service_irq_esi0.raw, 1);
+		}
+	} else {
 		/* Read 14 bytes in a single read and then copy only the required fields.
 		 * This is more efficient than doing it in two separate AUX reads. */
 
@@ -346,6 +377,7 @@ enum dc_status dp_read_hpd_rx_irq_data(
 		irq_data->bytes.lane23_status.raw = tmp[DP_LANE2_3_STATUS_ESI - DP_SINK_COUNT_ESI];
 		irq_data->bytes.lane_status_updated.raw = tmp[DP_LANE_ALIGN_STATUS_UPDATED_ESI - DP_SINK_COUNT_ESI];
 		irq_data->bytes.sink_status.raw = tmp[DP_SINK_STATUS_ESI - DP_SINK_COUNT_ESI];
+		irq_data->bytes.link_service_irq_esi0.raw = tmp[DP_LINK_SERVICE_IRQ_VECTOR_ESI0 - DP_SINK_COUNT_ESI];
 
 		/*
 		 * This display doesn't have correct values in DPCD200Eh.
@@ -488,6 +520,11 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		dp_trace_link_loss_increment(link);
 	}
 
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+		if (hpd_irq_dpcd_data.bytes.link_service_irq_esi0.bits.DP_LINK_TUNNELING_IRQ)
+			dp_handle_tunneling_irq(link);
+	}
+
 	if (link->type == dc_connection_sst_branch &&
 		hpd_irq_dpcd_data.bytes.sink_cnt.bits.SINK_COUNT
 			!= link->dpcd_sink_count)
-- 
2.37.3

