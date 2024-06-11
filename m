Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B28EC27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514EE10E6D7;
	Tue, 11 Jun 2024 16:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9n+aLSm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE3D10E6CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG+9bcinqaIxyatUaxZRdIpQc8xzfBzWMY2KQYxmWS25bNk1Vam171n3FSHgGiaoBWYxismJ/zbiPAuFUdjjVbiGtYjz+7W2Hg02e/Ikvc1+J55nVrEKE+WRAAZFGETckQqTu9cb7iSCteFgn0F+mT4r2qnidBoVcIKlT96VitZJDuVyzOhDkLOdo/YbJsV59mYZroppxWPgtCaapmJ0j2trwmk8+EAxZKXCUZ9beHtEKlBOU1XFT9HBZSLrsu43mH5oKlce7+4pIqQp2X8H8Zm28Vz5RQQVZ0SV5LS24nNE1raP9SZRkuEm/bmVE40qWaW5/pYVgMvgHq2FvUVBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqvhJAu9Kt2RXMvQIxe5iUBEQoT6vmJUlvY8rVxCbsg=;
 b=BJgu1cL1H7DSoLLxvYAteSZwEkfnFo2bXuneCjb5vn+hMOEu2uwnv/OSG6jU/KHa8U6pLFFdI9hqZO4CupzKowhzIkI8RQ5RiZ0/HraHix7gFta5tLRH5XY1rHtNX0zKKaczj5bmD7twpXNbz+aPVTmTmFyoy/l94Ely+38mhtJz9J6gxxF7eIJVVj+3zQQ7OGo8movg0+mXfbUlUKylUL+VQb/7A/6gPPOCAxrBqS8Av7kwftpIPvoFWI2GwPqZ0vo/Em98+ig9WIAnLdW+CbYyfGQK0rvyyGUrtaX6kGedN8liteHV1IYn/Zl8vHu/UTEc7fyEDrjAdYBC60kbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqvhJAu9Kt2RXMvQIxe5iUBEQoT6vmJUlvY8rVxCbsg=;
 b=G9n+aLSmhIWBPNwaDDJqtDML5LXUIvSYYU5epxaxV0e5tlWQQezI7VDh/AimHicIpapGCQQq/sMSrMi3xiqFwyHj2/w1Cxno2HsxOavZW5LO7Fim/Xg755Hd+ZLEutIVlyCQgTSFwGLoX8997V+KCdKpd74eByMeId3Avdc1Xkk=
Received: from BN8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:ac::19)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:33 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::19) by BN8PR07CA0006.outlook.office365.com
 (2603:10b6:408:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:32 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:28 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Sung Joon Kim <sungjoon.kim@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 12/36] drm/amd/display: Send message to notify the DPIA host
 router bandwidth
Date: Tue, 11 Jun 2024 12:51:15 -0400
Message-ID: <20240611165204.195093-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: f388da15-51d8-435a-f5c4-08dc8a36e376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZPaTcHxDOsQBrPOP+RzGPmTWAmuV2G2Rk70+r+ibTm41q8p8dASJtMErgpc9?=
 =?us-ascii?Q?KNkX06TYrEnweetfKFlIPadm6IUBbDkTLKwdd0lTiSRGJevT5+9jPqH+VnnV?=
 =?us-ascii?Q?exwa4Xa3F3/3FZmMuS8JTTZY3acVPp+st0EXxazWBgwAGtK46xBo+OCAS0qP?=
 =?us-ascii?Q?VCfQ1+liOeq+y6OFkE9p7lVhFxSyXn0HQVgsnWmdEDLfNDl6jB+YLqGmpRuS?=
 =?us-ascii?Q?i5xzRzA55O7vl9Nrqzo3OxirApNB5UdJDYPKNXWl8UpW3CjtpRr59JBBJlkw?=
 =?us-ascii?Q?pYFrBCSl9Zqo9MQyqwXSBrlrBg4FDE31bYxaj9vWJFWvqTi64aB74WcgwxEY?=
 =?us-ascii?Q?iDYIBV8Yl1rQ+aJa/VHO74PwcaQfOv5qNxmA5cdQOj8zr5IxNdug6LvhHLRp?=
 =?us-ascii?Q?aGl9DDSKK4q8u+8FWTQtFbT1KPGPEgEWrdFVYZ35/NPITYegO8ajCog9d6+e?=
 =?us-ascii?Q?13M+j/+Ny8ZrA1tNZtoEBNyTuiO012buNpSfOSQy+p71aHsvePVduh4Vl5/2?=
 =?us-ascii?Q?QdYfvfUK2WCQMWbxTApLCPpIojPTNDK/k1fNbQ5bS6+/usmPqlhAYNz713lP?=
 =?us-ascii?Q?GL/cvbXxTjn8xwNZbCgtol+PJ0SiYA5p5kq1SeU99FwHd1PCtEwEIAUEex+E?=
 =?us-ascii?Q?4aMEl+Nroq3jjP83Kjs/ypb7u2WdRBVHBrrNfl0EEXLA306BaQcEWFW+1/NI?=
 =?us-ascii?Q?wXZup6Xb0cJXIFFSh1wCMyRU9s2W6fEBWOo4iAKfTOKYydn7LLVMUSX5luW0?=
 =?us-ascii?Q?htKmnevLbxk17FH49jUjHYDZTJmt6qm4ERlTiV8jmzw7Jmju03W/ovhvcv9Q?=
 =?us-ascii?Q?jd/Xh9N0dQL0vZArViUPplVXy689jv8l8qJ5LDaQF3lVVx7fZYkuYG5Eux6S?=
 =?us-ascii?Q?TUpwQm4n/Oun+z1AFEUOd4umpaTSWrDoOdcGyxSAnWZnD4nMURJyyC4ijB8O?=
 =?us-ascii?Q?+x4ntK1UoV4CIMxQb/HAJ7zga+QDVKVPZXHo3mimqRS845VlTqyAHomkdh/F?=
 =?us-ascii?Q?vhkWCTUACX4LwI7fi6vTv9GNlvTRAh0GcjUVgXMzXkTklJgQBZuw/FiNd5RT?=
 =?us-ascii?Q?//gdWPK6xdInEndjgjY5kuohmFOKGzRwvm5mmLtf/kOB1mF5ujYc8vPDLsV5?=
 =?us-ascii?Q?BbhtNVKIv81OIY5ur9genmYuiTGldS+hJkRFh+xbL2SfalqeDZQlfuiDUhnX?=
 =?us-ascii?Q?p1K/ppWp2wzO00EZFSo2aAzW1kthxZcKcpubmeAbkLodauoGGb9ImnN6tF2/?=
 =?us-ascii?Q?A2RNaS0SydmK9g9+iBLOMp/ntY7Uw/DYJdr1LRrU5xMWp59ufza5001amW8W?=
 =?us-ascii?Q?EjHKsL9gbHWULcyXDYs2S2GuPUiObvZzQMi1cXueyKdVKYmCSepo5qEvZmk4?=
 =?us-ascii?Q?EnJKIGQFUZtntV7DtwkKoCE3mhwaTVxv9snWAhRIIDhat7UuBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:32.8234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f388da15-51d8-435a-f5c4-08dc8a36e376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
Tell the system about the current host router bandwidth to be used to
measure and calculate the right voltage to be used.

[how]
Send SMU message of each DPIA host router bandwidth.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 55 +++++++++++++++++++
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 21 ++++++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +
 .../dc/resource/dcn351/dcn351_resource.c      |  1 +
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 6c9b4e6491a5..9a414f49f15a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -218,6 +218,57 @@ static void dcn35_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		}
 }
 
+static uint8_t get_lowest_dpia_index(const struct dc_link *link)
+{
+	const struct dc *dc_struct = link->dc;
+	uint8_t idx = 0xFF;
+	int i;
+
+	for (i = 0; i < MAX_PIPES * 2; ++i) {
+		if (!dc_struct->links[i] || dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+			continue;
+
+		if (idx > dc_struct->links[i]->link_index)
+			idx = dc_struct->links[i]->link_index;
+	}
+
+	return idx;
+}
+
+static void dcn35_notify_host_router_bw(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+					bool safe_to_lower)
+{
+	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t host_router_bw_kbps[MAX_HOST_ROUTERS_NUM] = { 0 };
+	int i;
+
+	for (i = 0; i < context->stream_count; ++i) {
+		const struct dc_stream_state *stream = context->streams[i];
+		const struct dc_link *link = stream->link;
+		uint8_t lowest_dpia_index = 0, hr_index = 0;
+
+		if (!link)
+			continue;
+
+		lowest_dpia_index = get_lowest_dpia_index(link);
+		if (link->link_index < lowest_dpia_index)
+			continue;
+
+		hr_index = (link->link_index - lowest_dpia_index) / 2;
+		host_router_bw_kbps[hr_index] += dc_bandwidth_in_kbps_from_timing(
+			&stream->timing, dc_link_get_highest_encoding_format(link));
+	}
+
+	for (i = 0; i < MAX_HOST_ROUTERS_NUM; ++i) {
+		new_clocks->host_router_bw_kbps[i] = host_router_bw_kbps[i];
+		if (should_set_clock(safe_to_lower, new_clocks->host_router_bw_kbps[i], clk_mgr_base->clks.host_router_bw_kbps[i])) {
+			clk_mgr_base->clks.host_router_bw_kbps[i] = new_clocks->host_router_bw_kbps[i];
+			dcn35_smu_notify_host_router_bw(clk_mgr, i, new_clocks->host_router_bw_kbps[i]);
+		}
+	}
+}
+
 void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -342,6 +393,10 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		dcn35_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 	}
 
+	// notify PMFW of bandwidth per DPIA tunnel
+	if (dc->debug.notify_dpia_hr_bw)
+		dcn35_notify_host_router_bw(clk_mgr_base, context, safe_to_lower);
+
 	// notify DMCUB of latest clocks
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.notify_clocks.header.type = DMUB_CMD__CLK_MGR;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index 1399b41dfd1c..f6f0e6a33001 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -89,7 +89,8 @@
 #define VBIOSSMC_MSG_DisableLSdma                 0x1A ///< Disable LSDMA; only sent by VBIOS
 #define VBIOSSMC_MSG_DpControllerPhyStatus        0x1B ///< Inform PMFW about the pre conditions for turning SLDO2 on/off . bit[0]==1 precondition is met, bit[1-2] are for DPPHY number
 #define VBIOSSMC_MSG_QueryIPS2Support             0x1C ///< Return 1: support; else not supported
-#define VBIOSSMC_Message_Count                    0x1D
+#define VBIOSSMC_MSG_NotifyHostRouterBW           0x1D
+#define VBIOSSMC_Message_Count                    0x1E
 
 #define VBIOSSMC_Status_BUSY                      0x0
 #define VBIOSSMC_Result_OK                        0x1
@@ -98,6 +99,14 @@
 #define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
 #define VBIOSSMC_Result_CmdRejectedBusy           0xFC
 
+union dcn35_dpia_host_router_bw {
+	struct {
+		uint32_t hr_id : 16;
+		uint32_t bw_mbps : 16;
+	} bits;
+	uint32_t all;
+};
+
 /*
  * Function to be used instead of REG_WAIT macro because the wait ends when
  * the register is NOT EQUAL to zero, and because `the translation in msg_if.h
@@ -487,3 +496,13 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 	//smu_print("%s: VBIOSSMC_MSG_QueryIPS2Support return = %x\n", __func__, retv);
 	return retv;
 }
+
+void dcn35_smu_notify_host_router_bw(struct clk_mgr_internal *clk_mgr, uint32_t hr_id, uint32_t bw_kbps)
+{
+	union dcn35_dpia_host_router_bw msg_data = { 0 };
+
+	msg_data.bits.hr_id = hr_id;
+	msg_data.bits.bw_mbps = bw_kbps / 1000;
+
+	dcn35_smu_send_msg_with_param(clk_mgr, VBIOSSMC_MSG_NotifyHostRouterBW, msg_data.all);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 06cd3cc6d36e..3fae13c73934 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -198,4 +198,6 @@ int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr);
+void dcn35_smu_notify_host_router_bw(struct clk_mgr_internal *clk_mgr, uint32_t hr_id, uint32_t bw_kbps);
+
 #endif /* DAL_DC_35_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b9c67bac7beb..fa4e6b09409e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -62,6 +62,7 @@ struct dmub_notification;
 #define MAX_STREAMS 6
 #define MIN_VIEWPORT_SIZE 12
 #define MAX_NUM_EDP 2
+#define MAX_HOST_ROUTERS_NUM 2
 
 /* Display Core Interfaces */
 struct dc_versions {
@@ -594,6 +595,7 @@ struct dc_clocks {
 	bool prev_p_state_change_support;
 	bool fclk_prev_p_state_change_support;
 	int num_ways;
+	int host_router_bw_kbps[MAX_HOST_ROUTERS_NUM];
 
 	/*
 	 * @fw_based_mclk_switching
@@ -1045,6 +1047,7 @@ struct dc_debug_options {
 	unsigned int force_easf;
 	unsigned int force_sharpness;
 	unsigned int force_lls;
+	bool notify_dpia_hr_bw;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 30b40ba0c324..4c5e722baa3a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -765,6 +765,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.ips2_entry_delay_us = 800,
 	.disable_dmub_reallow_idle = false,
 	.static_screen_wait_frames = 2,
+	.notify_dpia_hr_bw = true,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.45.1

