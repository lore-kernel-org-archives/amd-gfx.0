Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE26C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8784510E3B0;
	Thu, 20 Oct 2022 15:47:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0033D10E252
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn0gguDSaHz2r4P4JtmJJkxhnbVhiVfePgfe1GnwaWTe8XASbueavyeRMz/q0elDIfqLmsQZXGqdnTIcU5UsCcAUM23PJkKGAao+OotKt6PwFr0gFeGBm5QWvHS4IaXgHLzaTLW2sEcdrBMd+qkoDD+eRAK0xUUX95zt24NQXpnooqBe0pDheHALyeXowfnRYNOB99SbnQkobIOSgl8tuvT3JHGZOcrdPPW1qANEDtZFV+6gSE+QqiB3Poab7AymNVSD2FN10BkfTjeFdZ1qdSu+oa9AWuaQB+pw/V4oYruNECbZwdqXRulwwnirReZVDSCueFQGp6VGUtYcXnoZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMYYlftOqTBJRmVwAqOnQxslI8IfvmCjV0xd0F/zBio=;
 b=mJkqp7wZCVbn+EBX+ajynkGG53dmffrHT4S9auV261LuEaRBzXikNm1l1R5Jg2LuZw/+a4n/0gnlR1OSvbobRhZw89a0v8cXGeC1vGGu6j+h8kZz6aaQdgissFBi3jk7srFvTnh8hiAAE7ZJdtJGBeo3yv3bv86TNXLbc7wnlBeeRQPc31whJ4Rb6gHGP9Pcp6S/DGL/5JMsfsdgLHPd/696tYeFzIBP38wMD4D3zK0gEeypJHi7MPSzECjmyEi1NmkyzzZBaQCA4BNdu2eNFmjq8CcJATi5ye8elFPeZwFUpq9JyxtEzZqfu3VsPliKSDk2WI6Xa6Pwdi4YkEOw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMYYlftOqTBJRmVwAqOnQxslI8IfvmCjV0xd0F/zBio=;
 b=w0MyExfLKv6upWqNxUWF2qkf239okSxgrDlTSIv8bE6WUaUu/x2G+vBtZBqk09xW5bLbi3hnwdhml10p7gOYHfufRX4/iLZj9Q/1B6hiSlH5SikIcgyKJZ3t6J96BINLLmbwOKfyVMGstiIVaHYOXNJzpUqF1DYSFCNUdHuVdjs=
Received: from DM6PR12CA0020.namprd12.prod.outlook.com (2603:10b6:5:1c0::33)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 15:47:44 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::5e) by DM6PR12CA0020.outlook.office365.com
 (2603:10b6:5:1c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:44 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:42 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/33] drm/amd/display: Convert documentation to a kernel-doc
Date: Thu, 20 Oct 2022 11:46:37 -0400
Message-ID: <20221020154702.503934-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|BL1PR12MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: e31a16ad-cbcb-458f-4c04-08dab2b26db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brrno0pqKj3elV3bYl6syrxXLgNYSliRsLLgJKP/i0VkVHKaXD/u8cZoEzSxIbLAfGo1K7um86J/+/6mCa6jANqUMkrWs/h/7ty9n4zJXwC2EkfBiSLjudS/92sAiFIq1CKB7m2MuG5nqnpJ+jETYTtEoTvfz7e40bsjpLPHLby/s+zHemwtmQ8Er4DA0CUXcUVNKTRcaFu0smtpqE2eC2KZWss3bFLy6Axb/hjq1FPRWFpxC/3h9LMc1rZ51KXFEJfyrF8+mElzXzCt9qquzbgJacyQEq+gVakWfu1DuvATTWdLzbFAdwcBbj7F6SzZUMuSbiH1yKQ04N/5ULcgLKLwt3D2xEdfRDqB7dpDKKgxqJR6JMd71WD42EmTWoDOFm6c8Nhy1y8gIXM1qopbQBThUfgdpb+48xKCp2Tit9NurImKH0m44kmBlj7tne7FzRhJbjl49zceMJ1NyMjougNQf8CBVYDeN0xuaf8vSV/mMMuwJ8PsHfua1upipyEeLSMIcJRerMo2Ib2W8uctys73mXJFq9DdyAwdZ5lvpsjAmlGKlhO9JK4OS/3APtdEIOACWRS+XcrYTJvWmkydPEGxSzqprsfSGN71oADd6Q+KuMbJMYjrKbhqZSRAKCV3tkReqIWIFomubR3hOKbtailKZVdv6zOV5IlPvRQtTVidvlJ29Hvm7uP13wPiqVaqedunR/Rh5AmYeWm8fLMdtWVMejOTRUQL/XyDY/0ypqZ91Yx98kZKy83g8oFi45Qu310TwfB2318BFEI2FjGxSE/u0jITS1HHwdja+xTTlhTwSqv7ES9WD25AnttSmnx9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82740400003)(356005)(81166007)(36860700001)(83380400001)(316002)(82310400005)(2906002)(336012)(54906003)(186003)(40460700003)(16526019)(1076003)(47076005)(426003)(7696005)(70586007)(70206006)(40480700001)(6666004)(26005)(478600001)(6916009)(2616005)(4326008)(5660300002)(8676002)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:44.0111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31a16ad-cbcb-458f-4c04-08dab2b26db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The dc_dmub_srv file has a lot of documentation associated with SubVP
that could be converted to a kernel-doc. This commit just changes the
comment style to a kernel-doc.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 124 +++++++------------
 1 file changed, 48 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0541e87e4f38..774e06936661 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -423,25 +423,20 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 
 #ifdef CONFIG_DRM_AMD_DC_DCN
 /**
- * ***********************************************************************************************
- * populate_subvp_cmd_drr_info: Helper to populate DRR pipe info for the DMCUB subvp command
+ * populate_subvp_cmd_drr_info - Helper to populate DRR pipe info for the DMCUB subvp command
  *
- * Populate the DMCUB SubVP command with DRR pipe info. All the information required for calculating
- * the SubVP + DRR microschedule is populated here.
+ * @dc: [in] current dc state
+ * @subvp_pipe: [in] pipe_ctx for the SubVP pipe
+ * @vblank_pipe: [in] pipe_ctx for the DRR pipe
+ * @pipe_data: [in] Pipe data which stores the VBLANK/DRR info
+ *
+ * Populate the DMCUB SubVP command with DRR pipe info. All the information
+ * required for calculating the SubVP + DRR microschedule is populated here.
  *
  * High level algorithm:
  * 1. Get timing for SubVP pipe, phantom pipe, and DRR pipe
  * 2. Calculate the min and max vtotal which supports SubVP + DRR microschedule
  * 3. Populate the drr_info with the min and max supported vtotal values
- *
- * @param [in] dc: current dc state
- * @param [in] subvp_pipe: pipe_ctx for the SubVP pipe
- * @param [in] vblank_pipe: pipe_ctx for the DRR pipe
- * @param [in] pipe_data: Pipe data which stores the VBLANK/DRR info
- *
- * @return: void
- *
- * ***********************************************************************************************
  */
 static void populate_subvp_cmd_drr_info(struct dc *dc,
 		struct pipe_ctx *subvp_pipe,
@@ -493,22 +488,18 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 }
 
 /**
- * ***********************************************************************************************
- * populate_subvp_cmd_vblank_pipe_info: Helper to populate VBLANK pipe info for the DMUB subvp command
+ * populate_subvp_cmd_vblank_pipe_info - Helper to populate VBLANK pipe info for the DMUB subvp command
  *
- * Populate the DMCUB SubVP command with VBLANK pipe info. All the information required to calculate
- * the microschedule for SubVP + VBLANK case is stored in the pipe_data (subvp_data and vblank_data).
- * Also check if the VBLANK pipe is a DRR display -- if it is make a call to populate drr_info.
+ * @dc: [in] current dc state
+ * @context: [in] new dc state
+ * @cmd: [in] DMUB cmd to be populated with SubVP info
+ * @vblank_pipe: [in] pipe_ctx for the VBLANK pipe
+ * @cmd_pipe_index: [in] index for the pipe array in DMCUB SubVP cmd
  *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
- * @param [in] cmd: DMUB cmd to be populated with SubVP info
- * @param [in] vblank_pipe: pipe_ctx for the VBLANK pipe
- * @param [in] cmd_pipe_index: index for the pipe array in DMCUB SubVP cmd
- *
- * @return: void
- *
- * ***********************************************************************************************
+ * Populate the DMCUB SubVP command with VBLANK pipe info. All the information
+ * required to calculate the microschedule for SubVP + VBLANK case is stored in
+ * the pipe_data (subvp_data and vblank_data).  Also check if the VBLANK pipe
+ * is a DRR display -- if it is make a call to populate drr_info.
  */
 static void populate_subvp_cmd_vblank_pipe_info(struct dc *dc,
 		struct dc_state *context,
@@ -551,22 +542,18 @@ static void populate_subvp_cmd_vblank_pipe_info(struct dc *dc,
 }
 
 /**
- * ***********************************************************************************************
- * update_subvp_prefetch_end_to_mall_start: Helper for SubVP + SubVP case
- *
- * For SubVP + SubVP, we use a single vertical interrupt to start the microschedule for both
- * SubVP pipes. In order for this to work correctly, the MALL REGION of both SubVP pipes must
- * start at the same time. This function lengthens the prefetch end to mall start delay of the
- * SubVP pipe that has the shorter prefetch so that both MALL REGION's will start at the same time.
- *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
- * @param [in] cmd: DMUB cmd to be populated with SubVP info
- * @param [in] subvp_pipes: Array of SubVP pipes (should always be length 2)
+ * update_subvp_prefetch_end_to_mall_start - Helper for SubVP + SubVP case
  *
- * @return: void
+ * @dc: [in] current dc state
+ * @context: [in] new dc state
+ * @cmd: [in] DMUB cmd to be populated with SubVP info
+ * @subvp_pipes: [in] Array of SubVP pipes (should always be length 2)
  *
- * ***********************************************************************************************
+ * For SubVP + SubVP, we use a single vertical interrupt to start the
+ * microschedule for both SubVP pipes. In order for this to work correctly, the
+ * MALL REGION of both SubVP pipes must start at the same time. This function
+ * lengthens the prefetch end to mall start delay of the SubVP pipe that has
+ * the shorter prefetch so that both MALL REGION's will start at the same time.
  */
 static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		struct dc_state *context,
@@ -608,22 +595,17 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 }
 
 /**
- * ***************************************************************************************
- * setup_subvp_dmub_command: Helper to populate the SubVP pipe info for the DMUB subvp command
+ * setup_subvp_dmub_command - Helper to populate the SubVP pipe info for the DMUB subvp command
  *
- * Populate the DMCUB SubVP command with SubVP pipe info. All the information required to
- * calculate the microschedule for the SubVP pipe is stored in the pipe_data of the DMCUB
- * SubVP command.
+ * @dc: [in] current dc state
+ * @context: [in] new dc state
+ * @cmd: [in] DMUB cmd to be populated with SubVP info
+ * @subvp_pipe: [in] pipe_ctx for the SubVP pipe
+ * @cmd_pipe_index: [in] index for the pipe array in DMCUB SubVP cmd
  *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
- * @param [in] cmd: DMUB cmd to be populated with SubVP info
- * @param [in] subvp_pipe: pipe_ctx for the SubVP pipe
- * @param [in] cmd_pipe_index: index for the pipe array in DMCUB SubVP cmd
- *
- * @return: void
- *
- * ***************************************************************************************
+ * Populate the DMCUB SubVP command with SubVP pipe info. All the information
+ * required to calculate the microschedule for the SubVP pipe is stored in the
+ * pipe_data of the DMCUB SubVP command.
  */
 static void populate_subvp_cmd_pipe_info(struct dc *dc,
 		struct dc_state *context,
@@ -703,19 +685,14 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 }
 
 /**
- * ***************************************************************************************
- * dc_dmub_setup_subvp_dmub_command: Populate the DMCUB SubVP command
- *
- * This function loops through each pipe and populates the DMUB
- * SubVP CMD info based on the pipe (e.g. SubVP, VBLANK).
- *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
- * @param [in] cmd: DMUB cmd to be populated with SubVP info
+ * dc_dmub_setup_subvp_dmub_command - Populate the DMCUB SubVP command
  *
- * @return: void
+ * @dc: [in] current dc state
+ * @context: [in] new dc state
+ * @cmd: [in] DMUB cmd to be populated with SubVP info
  *
- * ***************************************************************************************
+ * This function loops through each pipe and populates the DMUB SubVP CMD info
+ * based on the pipe (e.g. SubVP, VBLANK).
  */
 void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 		struct dc_state *context,
@@ -962,19 +939,14 @@ static void dc_build_cursor_attribute_update_payload1(
 }
 
 /**
- * ***************************************************************************************
- * dc_send_update_cursor_info_to_dmu: Populate the DMCUB Cursor update info command
+ * dc_send_update_cursor_info_to_dmu - Populate the DMCUB Cursor update info command
  *
- * This function would store the cursor related information and pass it into dmub
+ * @pCtx: [in] pipe context
+ * @pipe_idx: [in] pipe index
  *
- * @param [in] pCtx: pipe context
- * @param [in] pipe_idx: pipe index
- *
- * @return: void
- *
- * ***************************************************************************************
+ * This function would store the cursor related information and pass it into
+ * dmub
  */
-
 void dc_send_update_cursor_info_to_dmu(
 		struct pipe_ctx *pCtx, uint8_t pipe_idx)
 {
-- 
2.35.1

