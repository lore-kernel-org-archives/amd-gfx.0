Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B8BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560E660EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 560E660EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBD26E1B2;
	Mon, 25 Oct 2021 17:56:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8B96E1B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a09idO27yt2aWhYSGp4SvQ4/YVGRGGt7e5w/hBDFGPXikHqWs2FjIZvUdOuSv0tgqRvZ+ipJV2HEpSnqSmQ8EA6HyDZ2lFasbNshfLYRVODIkYbU6Q1bHOmyIrrC9ns58lNkT4IvUmQAiQNYTXQejgjRrOsPAng/iE4IXolHD8q6m1hC5q+fwCgiHET10kxALRi1hJjtMJFNUhjAfJQHj1lat9g0+i3l070sRwfyTNA0lVj28FF7QZpKvPLqvvqb3V19Q/EE+PUJrvskQG8N6T0Shus0GHAvcjBESnv2l0d9DSqXrOhknJI4uJ7xz5YfNQCGj3f+1VlApvCqjG6SfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wisMLzjMSwMtzF2Fx0uEprhSwyg0NkSmVEPJar8D9SY=;
 b=COqRS9DEnYhT+LtAyfR1IVoxdASupHaLgy9gp/0G39pNAJkMpkI88J56zPcZDek6w49wAPeSsr8DP1oMYO5qxkedni0cm03K3iXJgtt7/0p+p+Qq0WQ9iNcyDi8O0AScjMGAmsDxbGPkhESaic2BGcQJQUNSsj5v3cMl2X0p+O5qys5FU/QkWWhgfle6+uSg2w0Magyb86HIJeYo4wUiBwl5tJm7MtpIqPg2jzMbicBDi+B+JfJeftavU381/KRMZebiGdqyOzOSykfTifTigzHJFUNdXc0B6tEOM0VCnEuAfjsNfsSel07feHqSr5MFDWY2grmnjdRPspOjjduHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wisMLzjMSwMtzF2Fx0uEprhSwyg0NkSmVEPJar8D9SY=;
 b=3cRyLN9mDEyEUFyJ1qGrBRnICNg9VUL6b6VfoDhqclAewI1xstos2aAarH6SfPHYtUuddjStOrK5S25QF8WygE/526W+vy1g5RmKOi4xXQz3A3kRrG5n7KqfR75PfrYvRWH6Ylzsm01ND2ijSvTVmmWiigHaA9CAI+asUMmq5Is=
Received: from MWHPR19CA0015.namprd19.prod.outlook.com (2603:10b6:300:d4::25)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 17:56:13 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::77) by MWHPR19CA0015.outlook.office365.com
 (2603:10b6:300:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 17:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:56:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 12:56:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 10:56:11 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Mon, 25 Oct 2021 12:56:10 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Aurabindo.Pillai@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jun Lei <Jun.Lei@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 4/5] drm/amd/display: MST support for DPIA
Date: Mon, 25 Oct 2021 13:55:56 -0400
Message-ID: <20211025175557.148601-5-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
References: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e340cce-f61a-4c42-79ee-08d997e0bc14
X-MS-TrafficTypeDiagnostic: CH2PR12MB4117:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41172A36371D9C04C38BD877EC839@CH2PR12MB4117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTaAbLybb2NIqFx7Z2ZyZA6oB6oBS48X26le2CgaOIBYgmvmTc8OQU6eb51gpHbnfPd0jKpacQf4uhoVoJdbBJw2fdXGiaenAiG36aWNmvUhbkUmvwOkWmKqaLB6wYzyOJSvg2trQ830byylphtHdYY1ko7xktb7GCf/w1/kKsxd8yqExwoLpool25OgHAgoAxdk3O1E3cs0tqepeKnkhV2kYBemGrbg/hYZPWx29NN3b67RRZuvbv6DxEUw88bkFCpVR2wKf1a+gs8z46cmiKcD5xqiV1Wjiu8hp99g7lLD9yyWhItnR4EG8uiOPfXO5RfvxBHRzPOpm8npg/ASrroaYczqmhAhM0pASrIxwrGpTH/Gn07Kh0zeoWhWwzXh+dqE06RC6vZcVw++H9jDYCopw8aobCX8nN4Bnaeh6bfVF9m56F6J32xCZFfI+jNH5vqDAbpuGx+EqexyTIPzMH0/GA/aMGw6fMZ1Pzu7TkQJjcpCufyr8GJx6VU8dScR0BRNPSZeNTGzOD+wgiV/vfHY9716Ou+3g/WauX20usfegXDBfDRUwBFVgZHTEqN7RnxrtIeJpGR39IER4O/zX5HPDSRDbnaLeYDE4v0cWP6UDTIOa3jIuEoDBfTXrDDwBweIoJdSX3sngbTh72sgeRVZLSD4ymj5c2lB3COILoUykecBn+1SNnjuZHSo6yifu8voibLB/RSrOAmn95ZH9OlKAE++SCd8e9pnqEYE3Lw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(6666004)(70206006)(8936002)(44832011)(2616005)(54906003)(86362001)(1076003)(81166007)(6916009)(5660300002)(36860700001)(36756003)(82310400003)(26005)(70586007)(8676002)(316002)(356005)(426003)(336012)(186003)(4326008)(83380400001)(2906002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:56:13.1723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e340cce-f61a-4c42-79ee-08d997e0bc14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
- DPIA MST slot registers are not programmed during payload
allocation and hence MST does not work with DPIA.
- HPD RX interrupts are not handled for DPIA.

[How]
- Added inbox command to program the MST slots whenever
  payload allocation happens for DPIA links.
- Added support for handling HPD RX interrupts

Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 54 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 28 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 23 ++++++++
 4 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9d33b00b7e27..12e5470fa567 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3750,6 +3750,60 @@ bool dc_process_dmub_set_config_async(struct dc *dc,
 	return is_cmd_complete;
 }
 
+/**
+ *****************************************************************************
+ *  Function: dc_process_dmub_set_mst_slots
+ *
+ *  @brief
+ *		Submits mst slot allocation command to dmub via inbox message
+ *
+ *  @param
+ *		[in] dc: dc structure
+ *		[in] link_index: link index
+ *		[in] mst_alloc_slots: mst slots to be allotted
+ *		[out] mst_slots_in_use: mst slots in use returned in failure case
+ *
+ *	@return
+ *		DC_OK if successful, DC_ERROR if failure
+ *****************************************************************************
+ */
+enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
+				uint32_t link_index,
+				uint8_t mst_alloc_slots,
+				uint8_t *mst_slots_in_use)
+{
+	union dmub_rb_cmd cmd = {0};
+	struct dc_dmub_srv *dmub_srv = dc->ctx->dmub_srv;
+
+	/* prepare MST_ALLOC_SLOTS command */
+	cmd.set_mst_alloc_slots.header.type = DMUB_CMD__DPIA;
+	cmd.set_mst_alloc_slots.header.sub_type = DMUB_CMD__DPIA_MST_ALLOC_SLOTS;
+
+	cmd.set_mst_alloc_slots.mst_slots_control.instance = dc->links[link_index]->ddc_hw_inst;
+	cmd.set_mst_alloc_slots.mst_slots_control.mst_alloc_slots = mst_alloc_slots;
+
+	if (!dc_dmub_srv_cmd_with_reply_data(dmub_srv, &cmd))
+		/* command is not processed by dmub */
+		return DC_ERROR_UNEXPECTED;
+
+	/* command processed by dmub, if ret_status is 1 */
+	if (cmd.set_config_access.header.ret_status != 1)
+		/* command processing error */
+		return DC_ERROR_UNEXPECTED;
+
+	/* command processed and we have a status of 2, mst not enabled in dpia */
+	if (cmd.set_mst_alloc_slots.mst_slots_control.immed_status == 2)
+		return DC_FAIL_UNSUPPORTED_1;
+
+	/* previously configured mst alloc and used slots did not match */
+	if (cmd.set_mst_alloc_slots.mst_slots_control.immed_status == 3) {
+		*mst_slots_in_use = cmd.set_mst_alloc_slots.mst_slots_control.mst_slots_in_use;
+		return DC_NOT_SUPPORTED;
+	}
+
+	return DC_OK;
+}
+
 /**
  * dc_disable_accelerated_mode - disable accelerated mode
  * @dc: dc structure
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 27b9ff98a569..2796bdd17de1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3499,6 +3499,20 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 
 	ASSERT(proposed_table.stream_count > 0);
 
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+		static enum dc_status status;
+		uint8_t mst_alloc_slots = 0, prev_mst_slots_in_use = 0xFF;
+
+		for (i = 0; i < link->mst_stream_alloc_table.stream_count; i++)
+			mst_alloc_slots += link->mst_stream_alloc_table.stream_allocations[i].slot_count;
+
+		status = dc_process_dmub_set_mst_slots(link->dc, link->link_index,
+			mst_alloc_slots, &prev_mst_slots_in_use);
+		ASSERT(status == DC_OK);
+		DC_LOG_MST("dpia : status[%d]: alloc_slots[%d]: used_slots[%d]\n",
+				status, mst_alloc_slots, prev_mst_slots_in_use);
+	}
+
 	/* program DP source TX for payload */
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	switch (dp_get_link_encoding_format(&link->cur_link_settings)) {
@@ -3842,6 +3856,20 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 #endif
 	}
 
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+		enum dc_status status;
+		uint8_t mst_alloc_slots = 0, prev_mst_slots_in_use = 0xFF;
+
+		for (i = 0; i < link->mst_stream_alloc_table.stream_count; i++)
+			mst_alloc_slots += link->mst_stream_alloc_table.stream_allocations[i].slot_count;
+
+		status = dc_process_dmub_set_mst_slots(link->dc, link->link_index,
+			mst_alloc_slots, &prev_mst_slots_in_use);
+		ASSERT(status != DC_NOT_SUPPORTED);
+		DC_LOG_MST("dpia : status[%d]: alloc_slots[%d]: used_slots[%d]\n",
+				status, mst_alloc_slots, prev_mst_slots_in_use);
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	switch (dp_get_link_encoding_format(&link->cur_link_settings)) {
 	case DP_8b_10b_ENCODING:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 33c4f74a0add..a5339796902a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1428,6 +1428,12 @@ bool dc_process_dmub_set_config_async(struct dc *dc,
 				uint32_t link_index,
 				struct set_config_cmd_payload *payload,
 				struct dmub_notification *notify);
+
+enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
+				uint32_t link_index,
+				uint8_t mst_alloc_slots,
+				uint8_t *mst_slots_in_use);
+
 /*******************************************************************************
  * DSC Interfaces
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a73fed7f7502..6a79818337a1 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -698,6 +698,7 @@ enum dmub_out_cmd_type {
 enum dmub_cmd_dpia_type {
 	DMUB_CMD__DPIA_DIG1_DPIA_CONTROL = 0,
 	DMUB_CMD__DPIA_SET_CONFIG_ACCESS = 1,
+	DMUB_CMD__DPIA_MST_ALLOC_SLOTS = 2,
 };
 
 #pragma pack(push, 1)
@@ -1072,6 +1073,24 @@ struct dmub_rb_cmd_set_config_access {
 	struct dmub_cmd_set_config_control_data set_config_control; /* set config data */
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__DPIA_MST_ALLOC_SLOTS command.
+ */
+struct dmub_cmd_mst_alloc_slots_control_data {
+	uint8_t mst_alloc_slots; /* mst slots to be allotted */
+	uint8_t instance; /* DPIA instance */
+	uint8_t immed_status; /* Immediate status returned as there is no outbox msg posted */
+	uint8_t mst_slots_in_use; /* returns slots in use for error cases */
+};
+
+/**
+ * DMUB command structure for SET_ command.
+ */
+struct dmub_rb_cmd_set_mst_alloc_slots {
+	struct dmub_cmd_header header; /* header */
+	struct dmub_cmd_mst_alloc_slots_control_data mst_slots_control; /* mst slots control */
+};
+
 /**
  * struct dmub_rb_cmd_dpphy_init - DPPHY init.
  */
@@ -2594,6 +2613,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__DPIA_SET_CONFIG_ACCESS command.
 	 */
 	struct dmub_rb_cmd_set_config_access set_config_access;
+	/**
+	 * Definition of a DMUB_CMD__DPIA_MST_ALLOC_SLOTS command.
+	 */
+	struct dmub_rb_cmd_set_mst_alloc_slots set_mst_alloc_slots;
 	/**
 	 * Definition of a DMUB_CMD__EDID_CEA command.
 	 */
-- 
2.25.1

