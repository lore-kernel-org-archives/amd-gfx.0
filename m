Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B5BC25B07
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4888391E3A;
	Fri,  5 Aug 2022 18:00:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDB4B939D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7jl/39XXATGY1CeuD6xTiuuFGJL49LfcL659zBsWMPIZZgqXUn+l94VGpaQY/uYln5pjB/2UolrPDyObcF3Nh2KtOeUmMKjUbSXJLC9mLAhjMVFdGws2l+83tP9ezX9x+qwqLSMbnWsiVQa0bIWxVN4oTFKPXB4kn7Yp8KBWPzOlkGeRUps23c1ip+8jCeGyDuXgUPWpOWjA3SrAtQmHuKrtD38okZbQNtBJfUFPm0rqHK8LdFDJH+sbseaESA6v8FZFdz9vVa5f7BeSF00gCCypfoxXlxYjrtRXlxSbWjEychFIuU9RLl3YtMYlctG4jFi2vu1VZ3+AyhE9I/3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCjkmI+6h/dNsAhTec9npp0PdMU0D3KD5vXXn6Ohs/s=;
 b=aM2TDPubvUNA07YjmEWE0nVljIoZJm23A154c4IZJPqAh2LMRvPPVKmG+8eSf/c/viHd//3r0KAoawGks7rJcVQnsiMS9XFE8NGkHnlUn8dBbasL2QtUQQtllyVn6Bp5uACTsOpHl/hhvSVp8RfjRLGbKXmuf3nWRZ/f5Jnd9/hVsnxqQaoxWaL4TqOAlLXEmf1aUrh4bEImxKpRMTAqf0oz+w1OkcfE29tuI6Oj5VneWZfwzv1qr5Qh1Of8u6vnI8lE3VnpezA/ShWDCR8KUoVDfjuiAzM8+ORKki95XfxqErR1EVE6vf/9/uj917lafC+7EcDlWIOUgTHcbWefZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCjkmI+6h/dNsAhTec9npp0PdMU0D3KD5vXXn6Ohs/s=;
 b=kvhvO+nt6xFPe6D1M+1nIQKRDTx7tNCNWIRPr2pCZecwINYxiFcf9da7rCuDaIKTGDGeP2l+/NlryHLULyMLXlVLwhAwLs2RoqnSCfHHtyoEzZ56DFRsBUG+9vqe3uPzrRgn4mPz+QpBr9hwDzBm1wJ/vVzDldIyx7iFyHJDYOg=
Received: from MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30) by
 MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Fri, 5 Aug
 2022 18:00:19 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::2b) by MW2PR16CA0017.outlook.office365.com
 (2603:10b6:907::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:16 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:11 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/32] drm/amd/display: Add basic kernel doc to CRC code under
 DC
Date: Sat, 6 Aug 2022 01:58:10 +0800
Message-ID: <20220805175826.2992171-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 290cb139-2562-47fd-e562-08da770c5bcf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUdYvXRAgq//sb6Z7pIIoCGB86fqkQLwsoOp4elXVcQwtPyN2ldxWAGrt7b0oU+vRIsGWX53uMV2mzeJtSO+QhGfbnXkO9Q/1vkTUfb+cO9AR8kJNAODT7hmTDTJFfIyhQbQXJxWU+RDgcNRSe/UtTFa7gRG4NDR21HLpA0oTyzoczqL8jDiUOXnRJBPoKOMxR+NI8w+WjLK68A9GyTia864yG3Y3GAX2FVj8pPqx/OtUKvgGgOiY28bASYPyHLWWER9FX6/fbuvPfS08hVN9hUt5qSR7j3GdQBqgY6jpSLP1yltWFS3MqgAF6/vHfYtddHJBo7JGzIbtqs/ywSojSiebZalZdZKj7oT42onU3RocKWkSjVb9wpY8rYCOGPAgu39etEkN6NwTpsNiI9rVLGdOkS0UPZHaYpKZojkI7SKVCygagYJGiluoIZhuEdRhdZtax1RAE84rWVacVqdm7ZtfpIrzxsmiHf6AUZcMKsSSAWjmhkdJF2++k107g2bqefRsf/GkhzIN62xrDAdznWRNnxVkEzdbnniFbhdI27kVk3X9ZtFQzKc0smi8BEDtx/k3+U11m2eq1gdCkYvuQA2gtgnPOJKQ853tGAXR/TDLZFzrTFP7D80WpB/wuSuJ5oKQw/qLVTrr+mDyVklzxSDPAJ1oqcY+R7RV2u/aOMRWPJHoXug/DMPiqugUkGjCMcXUivkWsl6jNk+OzhfDRvglCW0FHVW1AT8z/w7iL55sWhTdqDLx3ujcgljmHWKR4D1bFbHG3wyNs/5A382/GiU5gGiflVP7d9acjBbgq7+ZxWyPM3rc8uaqc/I5IKmCbgBXFPZTKw3xb2EX9YOxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(7696005)(6916009)(4326008)(36860700001)(1076003)(82740400003)(8936002)(70586007)(40480700001)(70206006)(86362001)(26005)(81166007)(186003)(336012)(47076005)(316002)(426003)(8676002)(54906003)(478600001)(82310400005)(356005)(41300700001)(40460700003)(5660300002)(2906002)(36756003)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:18.8135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290cb139-2562-47fd-e562-08da770c5bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 +++++++------
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 25 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  4 +++
 .../amd/display/dc/inc/hw/timing_generator.h  | 14 ++++++++---
 4 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e42f44fc1c08..6f5a7e4378a7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -638,14 +638,17 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 
 /**
  * dc_stream_get_crc() - Get CRC values for the given stream.
- * @dc: DC object
+ *
+ * @dc: DC object.
  * @stream: The DC stream state of the stream to get CRCs from.
- * @r_cr: CRC value for the first of the 3 channels stored here.
- * @g_y:  CRC value for the second of the 3 channels stored here.
- * @b_cb: CRC value for the third of the 3 channels stored here.
+ * @r_cr: CRC value for the red component.
+ * @g_y:  CRC value for the green component.
+ * @b_cb: CRC value for the blue component.
  *
  * dc_stream_configure_crc needs to be called beforehand to enable CRCs.
- * Return false if stream is not found, or if CRCs are not enabled.
+ *
+ * Return:
+ * false if stream is not found, or if CRCs are not enabled.
  */
 bool dc_stream_get_crc(struct dc *dc, struct dc_stream_state *stream,
 		       uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
@@ -4271,8 +4274,8 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
 /*
  *****************************************************************************
  * Function: dc_is_dmub_outbox_supported -
- * 
- * @brief 
+ *
+ * @brief
  *      Checks whether DMUB FW supports outbox notifications, if supported
  *		DM should register outbox interrupt prior to actually enabling interrupts
  *		via dc_enable_dmub_outbox
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index e1a9a45b03b6..1b14250d1b33 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1493,8 +1493,23 @@ bool optc1_configure_crc(struct timing_generator *optc,
 	return true;
 }
 
+/**
+ * optc1_get_crc - Capture CRC result per component
+ *
+ * @optc: timing_generator instance.
+ * @r_cr: 16-bit primary CRC signature for red data.
+ * @g_y: 16-bit primary CRC signature for green data.
+ * @b_cb: 16-bit primary CRC signature for blue data.
+ *
+ * This function reads the CRC signature from the OPTC registers. Notice that
+ * we have three registers to keep the CRC result per color component (RGB).
+ *
+ * Returns:
+ * If CRC is disabled, return false; otherwise, return true, and the CRC
+ * results in the parameters.
+ */
 bool optc1_get_crc(struct timing_generator *optc,
-		    uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
+		   uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
 {
 	uint32_t field = 0;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -1505,12 +1520,14 @@ bool optc1_get_crc(struct timing_generator *optc,
 	if (!field)
 		return false;
 
+	/* OTG_CRC0_DATA_RG has the CRC16 results for the red and green component */
 	REG_GET_2(OTG_CRC0_DATA_RG,
-			CRC0_R_CR, r_cr,
-			CRC0_G_Y, g_y);
+		  CRC0_R_CR, r_cr,
+		  CRC0_G_Y, g_y);
 
+	/* OTG_CRC0_DATA_B has the CRC16 results for the blue component */
 	REG_GET(OTG_CRC0_DATA_B,
-			CRC0_B_CB, b_cb);
+		CRC0_B_CB, b_cb);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b3d0a4ea2446..8919a2092ac5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -399,6 +399,10 @@ struct pipe_ctx {
 	struct dc_stream_state *stream;
 
 	struct plane_resource plane_res;
+
+	/**
+	 * @stream_res: Reference to DCN resource components such OPP and DSC.
+	 */
 	struct stream_resource stream_res;
 	struct link_resource link_res;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 62d4683f17a2..828e5c6ad1cf 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -137,7 +137,13 @@ struct crc_params {
 	bool enable;
 };
 
+/**
+ * struct timing_generator - Entry point to Output Timing Generator feature.
+ */
 struct timing_generator {
+	/**
+	 * @funcs: Timing generator control functions
+	 */
 	const struct timing_generator_funcs *funcs;
 	struct dc_bios *bp;
 	struct dc_context *ctx;
@@ -148,7 +154,9 @@ struct dc_crtc_timing;
 
 struct drr_params;
 
-
+/**
+ * struct timing_generator_funcs - Control timing generator on a given device.
+ */
 struct timing_generator_funcs {
 	bool (*validate_timing)(struct timing_generator *tg,
 							const struct dc_crtc_timing *timing);
@@ -273,8 +281,8 @@ struct timing_generator_funcs {
 			       const struct crc_params *params);
 
 	/**
-	 * Get CRCs for the given timing generator. Return false if CRCs are
-	 * not enabled (via configure_crc).
+	 * @get_crc: Get CRCs for the given timing generator. Return false if
+	 * CRCs are not enabled (via configure_crc).
 	 */
 	bool (*get_crc)(struct timing_generator *tg,
 			uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb);
-- 
2.25.1

