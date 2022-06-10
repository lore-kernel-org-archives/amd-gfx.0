Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18513C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8422A113FD4;
	Fri, 10 Jun 2022 20:53:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D95113FD1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLfpq44D09AB9kaC+1qmMpe8PhQl9NF4iXhXfWRga9T8/YeDOj5zXKaBF+94+xRwS8HAjunvmwYWtjy3Srt+v8kYMCOHrBdLx8O4fc8UBBk2d0y8k7Z97O5SSYkC8yLEIiedxc4kgt+9I6e5NslJjhYGO5HD/uDyZpKQJUKGWN4Dg6ZI5PCcycIkNhlLNcsXZNZQ1eNGEC6KJoOkNQA2acMhAvf2PZdinE/c9vgITp9IXTO66FPdHWDdOzkLPwdSzZyfRkY6EYbq5FDNCy9AW5OrWT8BRL6RBg9MZhhVTTwjM9uj/Fq0Oy3z2U+cuBbHhwJ1UrE74Few+0Q5lKndKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STNWfNyakbMYpVU8MGyQsZH8w/GjpVrHCHEZE7mz0lw=;
 b=diX070ThpdjPsPLZaNIs7xCTEq3BfZDg2KAh+fGc/GSADgHYsLfztB17aAHVTfM8Z+aEnhtBDVsLq0HV814A1OKhTknaIutBtYCf+PseDYToh7hslK3RwMMOtrQ6RsiSXtnsedB2v1uBvUpOt45mR7SXYEW/4olgEtokoZenHK3cK5Gg05uieM/24CFaj8mMuCv5UxJYRbaspODnj4DpU5BQ8yQa/JbKoF/cqqvsxMLYZfdkE6zHI7j0OZ5jAI4wEaG8/XXqkBmKxIaO84/MNz/CU7T3u2U1NgBKaxG4iDthkTGBms9jQdKUrPJGL7RaptUa1atY/OyyuR/JMY8N2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STNWfNyakbMYpVU8MGyQsZH8w/GjpVrHCHEZE7mz0lw=;
 b=1PW5AqwpYKmhKWqiwNL6PwaaeSfaPypS5+IDoy0UK6QvAYu061A3DA27B0SNRJIUZG1oxw4fp1FvPj6iEAe4dzYRBsMAA2V6j5cfWhILZZYGB67MiUP4yY7D8uKdzWOw7wBBgs8w2irpeMehTpKtUZ4R7R8P9gvNoyZz0WyQ8R0=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 20:53:19 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::83) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:18 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:16 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/23] drm/amd/display: update topology_update_input_v3 struct
Date: Fri, 10 Jun 2022 16:52:32 -0400
Message-ID: <20220610205245.174802-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b75407-c610-49ad-5877-08da4b233f7d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB325701BCC9B07006C489D924F4A69@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXrgchFmEKb1ukmrqBsdEbIEE1LNBE9QWSXJopKYo0WPez5uyTS61aamIqFLxGarM3hGSHUHDvm6NhccUZRkAaRTyIzkhJWycm///l1Gmklpa3vdQNHLFgR+IdqskHG/3LJbyeBjetykV8wvuCqBDuAQLp3idkRduBjB2B6TpkFDNwOXUhm71WnZoWmHiH2sGYa3v5zQuUzaEXw2Kh+8DfDjJYZAtBKUvtbmoJqBRwtWl48ioKx9WV6R6GPzrVn2KakH2TmYLI3SnMiZEvVsIUdTFimouLG57RYwMZ/AEQAfutr2DufUupVYPt05crnCemhgY5pb/8Y8i+iFhVnDVD/poGaz+JPUEdmVvLgEoMVoy8lALCtHDgbeBHV2TRPg3sYlmGs8uBOGpPiaLHi+GSqRngcUp/onHi3mzDGO68dFzWU1fnLa1+q5TvUXje4MArh9/8V3DRgELUht8qHajpP1KDQyEgqT6FeDaPDmuyUq5j5nJ7raK7nQFT5Zjeo/3Nk9W+deqVRhscnHcLUAX1wbGmfZoJo93c3bzbuOfrNkGHPKDryXzBaeXAsPTg8VRK0KIBBugn8rlGx8JmR0g1VzoC40NaVeM5KDmdTAV4l6n2fCeEtNoTKIppGzXp15fJx0p46b79K5eyx8RmniDklqGuooIclImi3nfwLSBhkudOICqr2g5+n3jq/qN20XGFK1CM13TXRgS/qtSHRhAPlV7pl05ycbpHoloGFl//fVdna9S7bUSuXY4/CTFVd0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(36756003)(54906003)(82310400005)(8936002)(8676002)(70206006)(316002)(4326008)(70586007)(508600001)(7696005)(6666004)(6916009)(44832011)(15650500001)(2906002)(86362001)(26005)(2616005)(83380400001)(356005)(426003)(36860700001)(47076005)(336012)(186003)(81166007)(40460700003)(1076003)(16526019)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:18.5589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b75407-c610-49ad-5877-08da4b233f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
DIO parameters were missing in topology_update_intput_v3 struct.

[How]
Add DIO parameters in v3 struct and update in functions perspectively.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  2 ++
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c   |  4 ++++
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h   | 11 +++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index bf0d50277f8f..c76b628e6791 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -476,6 +476,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->ddc_line = aconnector->dc_link->ddc_hw_inst + 1;
 	display->stream_enc_idx = config->stream_enc_idx;
 	link->link_enc_idx = config->link_enc_idx;
+	link->dio_output_id = config->dio_output_idx;
 	link->phy_idx = config->phy_idx;
 	if (sink)
 		link_is_hdcp14 = dc_link_is_hdcp14(aconnector->dc_link, sink->sink_signal);
@@ -483,6 +484,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
 	link->dp.mst_enabled = config->mst_enabled;
+	link->dp.usb4_enabled = config->usb4_enabled;
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 3;
 	link->adjust.hdcp1.disable = 0;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index be61975f1470..ee67a35c2a8e 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -202,6 +202,10 @@ static enum mod_hdcp_status add_display_to_topology_v3(
 	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
 	dtm_cmd->dtm_in_message.topology_update_v3.phy_id = link->phy_idx;
 	dtm_cmd->dtm_in_message.topology_update_v3.link_hdcp_cap = link->hdcp_supported_informational;
+	dtm_cmd->dtm_in_message.topology_update_v3.dio_output_type = link->dp.usb4_enabled ?
+			TA_DTM_DIO_OUTPUT_TYPE__DPIA :
+			TA_DTM_DIO_OUTPUT_TYPE__DIRECT;
+	dtm_cmd->dtm_in_message.topology_update_v3.dio_output_id = link->dio_output_id;
 
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 	mutex_unlock(&psp->dtm_context.mutex);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
index 2937b4b61461..5b71bc96b98c 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
@@ -94,6 +94,15 @@ enum ta_dtm_encoder_type {
 	TA_DTM_ENCODER_TYPE__DIG        = 0x10
 };
 
+/* @enum ta_dtm_dio_output_type
+ * This enum defines software value for dio_output_type
+ */
+typedef enum {
+    TA_DTM_DIO_OUTPUT_TYPE__INVALID,
+    TA_DTM_DIO_OUTPUT_TYPE__DIRECT,
+    TA_DTM_DIO_OUTPUT_TYPE__DPIA
+} ta_dtm_dio_output_type;
+
 struct ta_dtm_topology_update_input_v3 {
 	/* display handle is unique across the driver and is used to identify a display */
 	/* for all security interfaces which reference displays such as HDCP */
@@ -111,6 +120,8 @@ struct ta_dtm_topology_update_input_v3 {
 	enum ta_dtm_encoder_type encoder_type;
 	uint32_t phy_id;
 	uint32_t link_hdcp_cap;
+	ta_dtm_dio_output_type dio_output_type;
+	uint32_t dio_output_id;
 };
 
 struct ta_dtm_topology_assr_enable {
-- 
2.36.1

