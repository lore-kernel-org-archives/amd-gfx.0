Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C843CC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF0510E6D9;
	Fri,  3 Mar 2023 15:49:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4296710E6D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPqC8SVRQWWgaQHvuVo0LY8GQavNYTA0aDVhP32Hxnha8CAE8y22O5OXgdBvqw6yj6H97rl0cdqtg7ePTIqtMrk568KxEqAbmVS834gXpcPFvaA6tSqvCBppEkvZnYyqF+6PEpdJfg7b1PVgdoxCS8e6Czb/6xXJpnrGqideamdstbVWHdysl6QoUz2Xlyp5hADTNv0Omu3lewJEOoGFo69o/3v8Gq5UrqB03BONx3NMluTMbqz4tz8Tv6EKlhMRrK49eS04MNt+cRS2kNjSuKV9sKuLu8uuxnRn3ifMWWdGnTahheRKZsq9liGr/6feYzbjeBKbSUkhA5Jx+W+ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMiQXBCwLmEs5tnAru8xeSdt8sAepwZIzndrXGUQq1A=;
 b=LjVUFehuWZ0y2WxBNm2emjn6L8+l3UYNdHcYvjxA6fYqG+ebdcgowmxfWIxjlVQMaNqtMJkqNXgUvEkKNV5PRw2uamKfrSoRsEs41VHKItty4k52b4ujwfud8jsxhFOkvgF1TYOfYZhus8sWMj3Ca7x0gYxY9dhYe8In73OnLqf7IPvPJ2z3T2QLEDiG2kONknw71BPc7u6TEW5UxyLe72TQyQxWAPe29Jx3QdwQp9tHNAeBjZ+SN9L2lq0AzDE9RZ4VkB1HOs9Un3aRAb6x4XXFaP+o947ELB7ovHzHwpBhihNcuV8Dr9EpNbbDHHaiI+nGLGy2UsSKqFQdfdwRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMiQXBCwLmEs5tnAru8xeSdt8sAepwZIzndrXGUQq1A=;
 b=2NIk6BS45/12QCoI/ctgRT0J6m907/uYKoD2d+gqJWloVjyfDD/kCtwj5JC8/yARVeC7tT4SqiI2q3JG4g6Jb+QaTYFDTxfn3Ivzl3vp4dao4vQNl1Hq7Vq5NeIqSjMiZ++3VPTGcD6GKnNEkBXxchLzBVqdWPetKbWaa/a8MDI=
Received: from DM5PR07CA0079.namprd07.prod.outlook.com (2603:10b6:4:ad::44) by
 PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.22; Fri, 3 Mar 2023 15:49:09 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::ed) by DM5PR07CA0079.outlook.office365.com
 (2603:10b6:4:ad::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:49:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:48:36 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/33] drm/amd/display: move dc_link functions in protocols
 folder to dc_link_exports
Date: Fri, 3 Mar 2023 10:40:05 -0500
Message-ID: <20230303154022.2667-17-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: ad36c9e3-d653-4f08-2974-08db1bfed3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzufc2uLERN+fhTWO+U1sPzDruGNNpzj/Nviq0ysYgqbnir12uVQLf5JpY3fkab/akNXfUadt+po0XK0LuuygHBuqSgiyxaLtnEXW/mI8fmGk+BSGIlw36X0QUiCBWW/4/wyADGcRjGOsgzdGuFwyQWz/uEnt3qifWCENQ6mWRZYvZ8k0WVQv3g595CaKqkTUc5oP/BwB0/+OvHylfSqUFodIS8eIRhB4NLoiiioiovh78j4seY2T4TT4BJq4g7/6rBmVqkcMOAwIj8fyvjp4K4NT8JV734f5Dn7lANnDA9LN7PUu6HkJDOemMAvoFBDrR10qEilSznCdnp+wBtDFxkzBLrxv/S8Vt2Lb0BFFPuckYyFQ4mMtaUtpakj6YuWAtDQ3mbpPYGnAkAF45eSyQJWX32q7KfVaaP0QFvLruu0zhLkSkjpZEbS26DPZDYBS5H2O0v4/Ys61tbRtVq/zUu7Zi6C4UWWqLnIlVzPci266SLc3vXEBMeXkvR9O6D7DQhfe1nDcXW5rfHpHRPET2XhP/Gsewv3O/bxLodHwgfzz78Kro/HB2K06A6BnqqrbBcpl1MJAoqkBNJcKLuxctgnjF9meEWzbcObnBGjZvwbSjxcEmH7Ce9Jz1uJfmnStUDmIbemB1TLF/lYK4zm1+jeuoi/zB1Fv88FC9vVMcXJgzhBTguCUMlSQWuYVqbrbGnN/y+gYebQ9wrN3BN09tx7wbsDscitKLROqsnWbZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(426003)(36860700001)(66899018)(47076005)(6666004)(40460700003)(36756003)(82740400003)(2906002)(8936002)(5660300002)(81166007)(478600001)(356005)(86362001)(40480700001)(82310400005)(2616005)(16526019)(26005)(186003)(336012)(1076003)(6916009)(4326008)(8676002)(70206006)(30864003)(44832011)(316002)(70586007)(41300700001)(54906003)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:49:08.9063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad36c9e3-d653-4f08-2974-08db1bfed3aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
link component should only have one interface serving dc.

[how]
We are moving dc_link functions exposed to DM to dc_link_exports
and unify link component interface in link.h with function pointer
to match the style of other dc component. This is the third step to move
dc_link functions under protocols folder to dc_link_exports.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c | 199 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../display/dc/dce110/dce110_hw_sequencer.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  83 +++++++-
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |  53 +++++
 .../amd/display/dc/link/protocols/link_ddc.c  |  24 ++-
 .../amd/display/dc/link/protocols/link_ddc.h  |   3 +
 .../dc/link/protocols/link_dp_capability.c    |  30 ++-
 .../dc/link/protocols/link_dp_capability.h    |  19 ++
 .../display/dc/link/protocols/link_dp_dpia.c  |   2 +-
 .../display/dc/link/protocols/link_dp_dpia.h  |   4 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |  12 +-
 .../dc/link/protocols/link_dp_dpia_bw.h       |  24 +++
 .../dc/link/protocols/link_dp_irq_handler.c   |  13 +-
 .../dc/link/protocols/link_dp_irq_handler.h   |  12 +-
 .../display/dc/link/protocols/link_dp_phy.c   |   2 +-
 .../display/dc/link/protocols/link_dp_phy.h   |   3 +
 .../dc/link/protocols/link_dp_training.c      |   6 +-
 .../dc/link/protocols/link_dp_training.h      |   3 +
 .../link/protocols/link_dp_training_auxless.c |   2 +-
 .../link/protocols/link_dp_training_auxless.h |   2 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   2 +-
 .../dc/link/protocols/link_dp_training_dpia.h |   2 +-
 .../link/protocols/link_edp_panel_control.c   |  20 +-
 .../link/protocols/link_edp_panel_control.h   |  20 ++
 .../amd/display/dc/link/protocols/link_hpd.c  |  14 +-
 .../amd/display/dc/link/protocols/link_hpd.h  |   4 +
 28 files changed, 486 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index b1fedef193a0..217c80db190d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -279,3 +279,202 @@ void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
 	link->dc->link_srv->remove_remote_sink(link, sink);
 }
 
+int dc_link_aux_transfer_raw(struct ddc_service *ddc,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result)
+{
+	const struct dc *dc = ddc->link->dc;
+
+	return dc->link_srv->aux_transfer_raw(
+			ddc, payload, operation_result);
+}
+
+uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(
+		struct dc *dc, uint8_t bw)
+{
+	return dc->link_srv->bw_kbps_from_raw_frl_link_rate_data(bw);
+}
+
+bool dc_link_decide_edp_link_settings(struct dc_link *link,
+		struct dc_link_settings *link_setting, uint32_t req_bw)
+{
+	return link->dc->link_srv->edp_decide_link_settings(link, link_setting, req_bw);
+}
+
+
+bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link,
+		struct dc_link_settings *max_link_enc_cap)
+{
+	return link->dc->link_srv->dp_get_max_link_enc_cap(link, max_link_enc_cap);
+}
+
+enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(
+		const struct dc_link *link)
+{
+	return link->dc->link_srv->mst_decide_link_encoding_format(link);
+}
+
+const struct dc_link_settings *dc_link_get_link_cap(const struct dc_link *link)
+{
+	return link->dc->link_srv->dp_get_verified_link_cap(link);
+}
+
+bool dc_link_is_dp_sink_present(struct dc_link *link)
+{
+	return link->dc->link_srv->dp_is_sink_present(link);
+}
+
+bool dc_link_is_fec_supported(const struct dc_link *link)
+{
+	return link->dc->link_srv->dp_is_fec_supported(link);
+}
+
+void dc_link_overwrite_extended_receiver_cap(
+		struct dc_link *link)
+{
+	link->dc->link_srv->dp_overwrite_extended_receiver_cap(link);
+}
+
+bool dc_link_should_enable_fec(const struct dc_link *link)
+{
+	return link->dc->link_srv->dp_should_enable_fec(link);
+}
+
+int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
+		struct dc_link *link, int peak_bw)
+{
+	return link->dc->link_srv->dpia_handle_usb4_bandwidth_allocation_for_link(link, peak_bw);
+}
+
+void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
+{
+	link->dc->link_srv->dpia_handle_bw_alloc_response(link, bw, result);
+}
+
+bool dc_link_check_link_loss_status(
+	struct dc_link *link,
+	union hpd_irq_data *hpd_irq_dpcd_data)
+{
+	return link->dc->link_srv->dp_parse_link_loss_status(link, hpd_irq_dpcd_data);
+}
+
+bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link)
+{
+	return link->dc->link_srv->dp_should_allow_hpd_rx_irq(link);
+}
+
+void dc_link_dp_handle_link_loss(struct dc_link *link)
+{
+	link->dc->link_srv->dp_handle_link_loss(link);
+}
+
+enum dc_status dc_link_dp_read_hpd_rx_irq_data(
+	struct dc_link *link,
+	union hpd_irq_data *irq_data)
+{
+	return link->dc->link_srv->dp_read_hpd_rx_irq_data(link, irq_data);
+}
+
+bool dc_link_handle_hpd_rx_irq(struct dc_link *link,
+		union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
+		bool defer_handling, bool *has_left_work)
+{
+	return link->dc->link_srv->dp_handle_hpd_rx_irq(link, out_hpd_irq_dpcd_data,
+			out_link_loss, defer_handling, has_left_work);
+}
+
+void dc_link_dp_receiver_power_ctrl(struct dc_link *link, bool on)
+{
+	link->dc->link_srv->dpcd_write_rx_power_ctrl(link, on);
+}
+
+enum lttpr_mode dc_link_decide_lttpr_mode(struct dc_link *link,
+		struct dc_link_settings *link_setting)
+{
+	return link->dc->link_srv->dp_decide_lttpr_mode(link, link_setting);
+}
+
+void dc_link_edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd)
+{
+	link->dc->link_srv->edp_panel_backlight_power_on(link, wait_for_hpd);
+}
+
+int dc_link_get_backlight_level(const struct dc_link *link)
+{
+	return link->dc->link_srv->edp_get_backlight_level(link);
+}
+
+bool dc_link_get_backlight_level_nits(struct dc_link *link,
+		uint32_t *backlight_millinits_avg,
+		uint32_t *backlight_millinits_peak)
+{
+	return link->dc->link_srv->edp_get_backlight_level_nits(link,
+			backlight_millinits_avg,
+			backlight_millinits_peak);
+}
+
+bool dc_link_set_backlight_level(const struct dc_link *link,
+		uint32_t backlight_pwm_u16_16,
+		uint32_t frame_ramp)
+{
+	return link->dc->link_srv->edp_set_backlight_level(link,
+			backlight_pwm_u16_16, frame_ramp);
+}
+
+bool dc_link_set_backlight_level_nits(struct dc_link *link,
+		bool isHDR,
+		uint32_t backlight_millinits,
+		uint32_t transition_time_in_ms)
+{
+	return link->dc->link_srv->edp_set_backlight_level_nits(link, isHDR,
+			backlight_millinits, transition_time_in_ms);
+}
+
+int dc_link_get_target_backlight_pwm(const struct dc_link *link)
+{
+	return link->dc->link_srv->edp_get_target_backlight_pwm(link);
+}
+
+bool dc_link_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
+{
+	return link->dc->link_srv->edp_get_psr_state(link, state);
+}
+
+bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
+		bool wait, bool force_static, const unsigned int *power_opts)
+{
+	return link->dc->link_srv->edp_set_psr_allow_active(link, allow_active, wait,
+			force_static, power_opts);
+}
+
+bool dc_link_setup_psr(struct dc_link *link,
+		const struct dc_stream_state *stream, struct psr_config *psr_config,
+		struct psr_context *psr_context)
+{
+	return link->dc->link_srv->edp_setup_psr(link, stream, psr_config, psr_context);
+}
+
+bool dc_link_wait_for_t12(struct dc_link *link)
+{
+	return link->dc->link_srv->edp_wait_for_t12(link);
+}
+
+bool dc_link_get_hpd_state(struct dc_link *link)
+{
+	return link->dc->link_srv->get_hpd_state(link);
+}
+
+void dc_link_enable_hpd(const struct dc_link *link)
+{
+	link->dc->link_srv->enable_hpd(link);
+}
+
+void dc_link_disable_hpd(const struct dc_link *link)
+{
+	link->dc->link_srv->disable_hpd(link);
+}
+
+void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
+{
+	link->dc->link_srv->enable_hpd_filter(link, enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 555d3aa65889..c1e69fdd5020 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1600,7 +1600,7 @@ bool dc_link_detect_connection_type(struct dc_link *link,
  * return - true HPD is asserted (HPD high), false otherwise (HPD low)
  *
  */
-bool dc_link_get_hpd_state(struct dc_link *dc_link);
+bool dc_link_get_hpd_state(struct dc_link *link);
 
 /* Getter for cached link status from given link */
 const struct dc_link_status *dc_link_get_status(const struct dc_link *link);
@@ -1775,7 +1775,8 @@ void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
 bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx);
 
 /* translate a raw link rate data to bandwidth in kbps */
-uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
+uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(
+		struct dc *dc, uint8_t bw);
 
 /* determine the optimal bandwidth given link and required bw.
  * @link - current detected link
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
index 394d83a97f33..08028a1779ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
@@ -71,8 +71,6 @@ void dce110_optimize_bandwidth(
 		struct dc *dc,
 		struct dc_state *context);
 
-void dc_link_dp_receiver_power_ctrl(struct dc_link *link, bool on);
-
 void dce110_edp_power_control(
 		struct dc_link *link,
 		bool power_up);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 9c05333f62aa..45cdf3bce2d3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -28,14 +28,10 @@
 
 /* FILE POLICY AND INTENDED USAGE:
  *
- * This header declares link functions exposed to dc. All functions must have
- * "link_" as prefix. For example link_run_my_function. This header is strictly
- * private in dc and should never be included in other header files. dc
- * components should include this header in their .c files in order to access
- * functions in link folder. This file should never include any header files in
- * link folder. If there is a need to expose a function declared in one of
- * header files in side link folder, you need to move the function declaration
- * into this file and prefix it with "link_".
+ * This header declares link functions exposed to dc. All functions must use
+ * function pointers. This header is strictly private in dc and should never be
+ * included by DM. If DM needs to call a new link function, it needs to be
+ * translated by dc_link_exports.c.
  */
 #include "core_types.h"
 
@@ -49,12 +45,81 @@ struct link_init_data {
 };
 
 struct link_service {
+	/* Detection */
 	struct dc_sink *(*add_remote_sink)(
 			struct dc_link *link,
 			const uint8_t *edid,
 			int len,
 			struct dc_sink_init_data *init_data);
 	void (*remove_remote_sink)(struct dc_link *link, struct dc_sink *sink);
+	bool (*get_hpd_state)(struct dc_link *link);
+	void (*enable_hpd)(const struct dc_link *link);
+	void (*disable_hpd)(const struct dc_link *link);
+	void (*enable_hpd_filter)(struct dc_link *link, bool enable);
+
+	/* DDC */
+	int (*aux_transfer_raw)(struct ddc_service *ddc,
+			struct aux_payload *payload,
+			enum aux_return_code_type *operation_result);
+
+	/* DP Capability */
+	bool (*dp_is_sink_present)(struct dc_link *link);
+	bool (*dp_is_fec_supported)(const struct dc_link *link);
+	bool (*dp_get_max_link_enc_cap)(const struct dc_link *link,
+			struct dc_link_settings *max_link_enc_cap);
+	const struct dc_link_settings *(*dp_get_verified_link_cap)(
+			const struct dc_link *link);
+	bool (*dp_should_enable_fec)(const struct dc_link *link);
+	enum dp_link_encoding (*mst_decide_link_encoding_format)(const struct dc_link *link);
+	bool (*edp_decide_link_settings)(struct dc_link *link,
+			struct dc_link_settings *link_setting, uint32_t req_bw);
+	uint32_t (*bw_kbps_from_raw_frl_link_rate_data)(uint8_t bw);
+	bool (*dp_overwrite_extended_receiver_cap)(struct dc_link *link);
+	enum lttpr_mode (*dp_decide_lttpr_mode)(struct dc_link *link,
+			struct dc_link_settings *link_setting);
+
+	/* DP DPIA/PHY */
+	int (*dpia_handle_usb4_bandwidth_allocation_for_link)(struct dc_link *link, int peak_bw);
+	void (*dpia_handle_bw_alloc_response)(struct dc_link *link, uint8_t bw, uint8_t result);
+	void (*dpcd_write_rx_power_ctrl)(struct dc_link *link, bool on);
+
+	/* DP IRQ Handler */
+	bool (*dp_parse_link_loss_status)(
+		struct dc_link *link,
+		union hpd_irq_data *hpd_irq_dpcd_data);
+	bool (*dp_should_allow_hpd_rx_irq)(const struct dc_link *link);
+	void (*dp_handle_link_loss)(struct dc_link *link);
+	enum dc_status (*dp_read_hpd_rx_irq_data)(
+		struct dc_link *link,
+		union hpd_irq_data *irq_data);
+	bool (*dp_handle_hpd_rx_irq)(struct dc_link *link,
+			union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
+			bool defer_handling, bool *has_left_work);
+
+	/* eDP Panel Control */
+	void (*edp_panel_backlight_power_on)(struct dc_link *link, bool wait_for_hpd);
+	int (*edp_get_backlight_level)(const struct dc_link *link);
+	bool (*edp_get_backlight_level_nits)(struct dc_link *link,
+			uint32_t *backlight_millinits_avg,
+			uint32_t *backlight_millinits_peak);
+	bool (*edp_set_backlight_level)(const struct dc_link *link,
+			uint32_t backlight_pwm_u16_16,
+			uint32_t frame_ramp);
+	bool (*edp_set_backlight_level_nits)(struct dc_link *link,
+			bool isHDR,
+			uint32_t backlight_millinits,
+			uint32_t transition_time_in_ms);
+	int (*edp_get_target_backlight_pwm)(const struct dc_link *link);
+	bool (*edp_get_psr_state)(const struct dc_link *link, enum dc_psr_state *state);
+	bool (*edp_set_psr_allow_active)(struct dc_link *link, const bool *allow_active,
+			bool wait, bool force_static, const unsigned int *power_opts);
+	bool (*edp_setup_psr)(struct dc_link *link,
+			const struct dc_stream_state *stream,
+			struct psr_config *psr_config,
+			struct psr_context *psr_context);
+	bool (*edp_wait_for_t12)(struct dc_link *link);
+
+	/* DP CTS */
 	void (*dp_handle_automated_test)(struct dc_link *link);
 	bool (*dp_set_test_pattern)(
 			struct dc_link *link,
@@ -71,6 +136,8 @@ struct link_service {
 			struct dc_link_training_overrides *lt_overrides,
 			struct dc_link *link,
 			bool skip_immediate_retrain);
+
+	/* DP Trace */
 	bool (*dp_trace_is_initialized)(struct dc_link *link);
 	void (*dp_trace_set_is_logged_flag)(struct dc_link *link,
 			bool in_detection,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 2a248ee0d70e..a51f761ba018 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1205,7 +1205,7 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 
 	/* Link may not have physical HPD pin. */
 	if (link->ep_type != DISPLAY_ENDPOINT_PHY) {
-		if (link->is_hpd_pending || !dc_link_dpia_query_hpd_status(link))
+		if (link->is_hpd_pending || !dpia_query_hpd_status(link))
 			*type = dc_connection_none;
 		else
 			*type = dc_connection_single;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index e37f271a6c72..d9ce83f0bbef 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -32,6 +32,12 @@
 #include "accessories/link_dp_trace.h"
 #include "accessories/link_fpga.h"
 #include "protocols/link_ddc.h"
+#include "protocols/link_dp_capability.h"
+#include "protocols/link_dp_dpia_bw.h"
+#include "protocols/link_dp_dpia.h"
+#include "protocols/link_dp_irq_handler.h"
+#include "protocols/link_dp_phy.h"
+#include "protocols/link_dp_training.h"
 #include "protocols/link_edp_panel_control.h"
 #include "protocols/link_hpd.h"
 #include "gpio_service_interface.h"
@@ -44,12 +50,59 @@
 		__VA_ARGS__)
 
 static struct link_service link_srv = {
+	/* Detection */
 	.add_remote_sink = link_add_remote_sink,
 	.remove_remote_sink = link_remove_remote_sink,
+	.get_hpd_state = link_get_hpd_state,
+	.enable_hpd = link_enable_hpd,
+	.disable_hpd = link_disable_hpd,
+	.enable_hpd_filter = link_enable_hpd_filter,
+
+	/* DDC */
+	.aux_transfer_raw = link_aux_transfer_raw,
+
+	/* DP Capability */
+	.dp_is_sink_present = dp_is_sink_present,
+	.dp_is_fec_supported = dp_is_fec_supported,
+	.dp_get_max_link_enc_cap = dp_get_max_link_enc_cap,
+	.dp_get_verified_link_cap = dp_get_verified_link_cap,
+	.dp_should_enable_fec = dp_should_enable_fec,
+	.mst_decide_link_encoding_format = mst_decide_link_encoding_format,
+	.edp_decide_link_settings = edp_decide_link_settings,
+	.bw_kbps_from_raw_frl_link_rate_data = link_bw_kbps_from_raw_frl_link_rate_data,
+	.dp_overwrite_extended_receiver_cap = dp_overwrite_extended_receiver_cap,
+	.dp_decide_lttpr_mode = dp_decide_lttpr_mode,
+
+	/* DP DPIA/PHY */
+	.dpia_handle_usb4_bandwidth_allocation_for_link = dpia_handle_usb4_bandwidth_allocation_for_link,
+	.dpia_handle_bw_alloc_response = dpia_handle_bw_alloc_response,
+	/* DP IRQ Handler */
+	.dp_parse_link_loss_status = dp_parse_link_loss_status,
+	.dp_should_allow_hpd_rx_irq = dp_should_allow_hpd_rx_irq,
+	.dp_handle_link_loss = dp_handle_link_loss,
+	.dp_read_hpd_rx_irq_data = dp_read_hpd_rx_irq_data,
+	.dp_handle_hpd_rx_irq = dp_handle_hpd_rx_irq,
+	.dpcd_write_rx_power_ctrl = dpcd_write_rx_power_ctrl,
+
+	/* eDP Panel Control */
+	.edp_panel_backlight_power_on = edp_panel_backlight_power_on,
+	.edp_get_backlight_level = edp_get_backlight_level,
+	.edp_get_backlight_level_nits = edp_get_backlight_level_nits,
+	.edp_set_backlight_level = edp_set_backlight_level,
+	.edp_set_backlight_level_nits = edp_set_backlight_level_nits,
+	.edp_get_target_backlight_pwm = edp_get_target_backlight_pwm,
+	.edp_get_psr_state = edp_get_psr_state,
+	.edp_set_psr_allow_active = edp_set_psr_allow_active,
+	.edp_setup_psr = edp_setup_psr,
+	.edp_wait_for_t12 = edp_wait_for_t12,
+
+	/* DP CTS */
 	.dp_handle_automated_test = dp_handle_automated_test,
 	.dp_set_test_pattern = dp_set_test_pattern,
 	.dp_set_preferred_link_settings = dp_set_preferred_link_settings,
 	.dp_set_preferred_training_settings = dp_set_preferred_training_settings,
+
+	/* DP Trace */
 	.dp_trace_is_initialized = dp_trace_is_initialized,
 	.dp_trace_set_is_logged_flag = dp_trace_set_is_logged_flag,
 	.dp_trace_is_logged = dp_trace_is_logged,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 5269125bc2a4..0fa1228bc178 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -53,7 +53,7 @@ struct aux_payloads {
 	struct vector payloads;
 };
 
-static bool dal_ddc_i2c_payloads_create(
+static bool i2c_payloads_create(
 		struct dc_context *ctx,
 		struct i2c_payloads *payloads,
 		uint32_t count)
@@ -65,16 +65,24 @@ static bool dal_ddc_i2c_payloads_create(
 	return false;
 }
 
-static struct i2c_payload *dal_ddc_i2c_payloads_get(struct i2c_payloads *p)
+static struct i2c_payload *i2c_payloads_get(struct i2c_payloads *p)
 {
 	return (struct i2c_payload *)p->payloads.container;
 }
 
-static uint32_t dal_ddc_i2c_payloads_get_count(struct i2c_payloads *p)
+static uint32_t i2c_payloads_get_count(struct i2c_payloads *p)
 {
 	return p->payloads.count;
 }
 
+static void i2c_payloads_destroy(struct i2c_payloads *p)
+{
+	if (!p)
+		return;
+
+	dal_vector_destruct(&p->payloads);
+}
+
 #define DDC_MIN(a, b) (((a) < (b)) ? (a) : (b))
 
 static void i2c_payloads_add(
@@ -364,10 +372,10 @@ bool link_query_ddc_data(
 		struct i2c_command command = {0};
 		struct i2c_payloads payloads;
 
-		if (!dal_ddc_i2c_payloads_create(ddc->ctx, &payloads, payloads_num))
+		if (!i2c_payloads_create(ddc->ctx, &payloads, payloads_num))
 			return false;
 
-		command.payloads = dal_ddc_i2c_payloads_get(&payloads);
+		command.payloads = i2c_payloads_get(&payloads);
 		command.number_of_payloads = 0;
 		command.engine = DDC_I2C_COMMAND_ENGINE;
 		command.speed = ddc->ctx->dc->caps.i2c_speed_in_khz;
@@ -379,20 +387,20 @@ bool link_query_ddc_data(
 			&payloads, address, read_size, read_buf, false);
 
 		command.number_of_payloads =
-			dal_ddc_i2c_payloads_get_count(&payloads);
+			i2c_payloads_get_count(&payloads);
 
 		success = dm_helpers_submit_i2c(
 				ddc->ctx,
 				ddc->link,
 				&command);
 
-		dal_vector_destruct(&payloads.payloads);
+		i2c_payloads_destroy(&payloads);
 	}
 
 	return success;
 }
 
-int dc_link_aux_transfer_raw(struct ddc_service *ddc,
+int link_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
index aaa5064408ba..f002fa01508e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
@@ -57,5 +57,8 @@ void set_dongle_type(struct ddc_service *ddc,
 
 struct ddc *get_ddc_pin(struct ddc_service *ddc_service);
 
+int link_aux_transfer_raw(struct ddc_service *ddc,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result);
 #endif /* __DAL_DDC_SERVICE_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 0f2c59807079..97856c4d0904 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -155,7 +155,7 @@ uint8_t dp_parse_lttpr_repeater_count(uint8_t lttpr_repeater_count)
 	return 0; // invalid value
 }
 
-uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw)
+uint32_t link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw)
 {
 	switch (bw) {
 	case 0b001:
@@ -309,7 +309,7 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
 		link->wa_flags.dp_keep_receiver_powered = false;
 }
 
-bool dc_link_is_fec_supported(const struct dc_link *link)
+bool dp_is_fec_supported(const struct dc_link *link)
 {
 	/* TODO - use asic cap instead of link_enc->features
 	 * we no longer know which link enc to use for this link before commit
@@ -325,7 +325,7 @@ bool dc_link_is_fec_supported(const struct dc_link *link)
 			!IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment));
 }
 
-bool dc_link_should_enable_fec(const struct dc_link *link)
+bool dp_should_enable_fec(const struct dc_link *link)
 {
 	bool force_disable = false;
 
@@ -679,7 +679,8 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 	return false;
 }
 
-bool dc_link_decide_edp_link_settings(struct dc_link *link, struct dc_link_settings *link_setting, uint32_t req_bw)
+bool edp_decide_link_settings(struct dc_link *link,
+		struct dc_link_settings *link_setting, uint32_t req_bw)
 {
 	struct dc_link_settings initial_link_setting;
 	struct dc_link_settings current_link_setting;
@@ -948,7 +949,7 @@ enum dp_link_encoding link_dp_get_encoding_format(const struct dc_link_settings
 	return DP_UNKNOWN_ENCODING;
 }
 
-enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc_link *link)
+enum dp_link_encoding mst_decide_link_encoding_format(const struct dc_link *link)
 {
 	struct dc_link_settings link_settings = {0};
 
@@ -1121,7 +1122,7 @@ static void get_active_converter_info(
 						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
 
 						link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
-								dc_link_bw_kbps_from_raw_frl_link_rate_data(
+								link_bw_kbps_from_raw_frl_link_rate_data(
 										hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
 
 						// Intersect reported max link bw support with the supported link rate post FRL link training
@@ -1216,7 +1217,7 @@ static void apply_usbc_combo_phy_reset_wa(struct dc_link *link,
 	dp_disable_link_phy(link, &link_res, link->connector_signal);
 }
 
-static bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
+bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
 {
 	uint8_t dpcd_data[16];
 	uint32_t read_dpcd_retry_cnt = 3;
@@ -1278,12 +1279,6 @@ static bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
 	return true;
 }
 
-void dc_link_overwrite_extended_receiver_cap(
-		struct dc_link *link)
-{
-	dp_overwrite_extended_receiver_cap(link);
-}
-
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
@@ -1972,7 +1967,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 			sizeof(link->dpcd_caps.alpm_caps.raw));
 }
 
-bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
+bool dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
 {
 	struct link_encoder *link_enc = NULL;
 
@@ -1995,7 +1990,7 @@ bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_
 	return false;
 }
 
-const struct dc_link_settings *dc_link_get_link_cap(
+const struct dc_link_settings *dp_get_verified_link_cap(
 		const struct dc_link *link)
 {
 	if (link->preferred_link_setting.lane_count != LANE_COUNT_UNKNOWN &&
@@ -2181,10 +2176,9 @@ bool dp_verify_link_cap_with_retries(
 }
 
 /**
- * dc_link_is_dp_sink_present() - Check if there is a native DP
- * or passive DP-HDMI dongle connected
+ * Check if there is a native DP or passive DP-HDMI dongle connected
  */
-bool dc_link_is_dp_sink_present(struct dc_link *link)
+bool dp_is_sink_present(struct dc_link *link)
 {
 	enum gpio_result gpio_result;
 	uint32_t clock_pin = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
index f79e4a4a9db6..62980ae17d41 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
@@ -34,32 +34,47 @@ void detect_edp_sink_caps(struct dc_link *link);
 
 struct dc_link_settings dp_get_max_link_cap(struct dc_link *link);
 
+bool dp_get_max_link_enc_cap(const struct dc_link *link,
+		struct dc_link_settings *max_link_enc_cap);
+
+const struct dc_link_settings *dp_get_verified_link_cap(
+		const struct dc_link *link);
 
 enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link);
 
 /* Convert PHY repeater count read from DPCD uint8_t. */
 uint8_t dp_parse_lttpr_repeater_count(uint8_t lttpr_repeater_count);
 
+bool dp_is_sink_present(struct dc_link *link);
+
 bool dp_is_lttpr_present(struct dc_link *link);
 
+bool dp_is_fec_supported(const struct dc_link *link);
+
 bool is_dp_active_dongle(const struct dc_link *link);
 
 bool is_dp_branch_device(const struct dc_link *link);
 
 void dpcd_write_cable_id_to_dprx(struct dc_link *link);
 
+bool dp_should_enable_fec(const struct dc_link *link);
+
 /* Initialize output parameter lt_settings. */
 void dp_decide_training_settings(
 	struct dc_link *link,
 	const struct dc_link_settings *link_setting,
 	struct link_training_settings *lt_settings);
 
+bool edp_decide_link_settings(struct dc_link *link,
+		struct dc_link_settings *link_setting, uint32_t req_bw);
 
 bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		uint32_t req_bw,
 		enum dc_link_rate max_link_rate);
 
+enum dp_link_encoding mst_decide_link_encoding_format(const struct dc_link *link);
+
 void dpcd_set_source_specific_data(struct dc_link *link);
 
 /*query dpcd for version and mst cap addresses*/
@@ -76,4 +91,8 @@ bool dp_verify_link_cap_with_retries(
 	struct dc_link_settings *known_limit_link_setting,
 	int attempts);
 
+uint32_t link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
+
+bool dp_overwrite_extended_receiver_cap(struct dc_link *link);
+
 #endif /* __DC_LINK_DP_CAPABILITY_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index cbfa9343ffaf..4626fabc0a96 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -78,7 +78,7 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 	return status;
 }
 
-bool dc_link_dpia_query_hpd_status(struct dc_link *link)
+bool dpia_query_hpd_status(struct dc_link *link)
 {
 	union dmub_rb_cmd cmd = {0};
 	struct dc_dmub_srv *dmub_srv = link->ctx->dmub_srv;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
index 98935cc10bb7..363f45a1a964 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
@@ -37,7 +37,5 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link);
 /* Query hot plug status of USB4 DP tunnel.
  * Returns true if HPD high.
  */
-bool dc_link_dpia_query_hpd_status(struct dc_link *link);
-
-
+bool dpia_query_hpd_status(struct dc_link *link);
 #endif /* __DC_LINK_DPIA_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 65f43572011b..f14217cc16fd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -200,7 +200,7 @@ static bool dpia_bw_alloc_unplug(struct dc_link *link)
 	return deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
 			link->dpia_bw_alloc_config.sink_allocated_bw, link);
 }
-void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw)
+static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 {
 	uint8_t requested_bw;
 	uint32_t temp;
@@ -291,7 +291,7 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 out:
 	return ret;
 }
-void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
+void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
 	int bw_needed = 0;
 	int available = 0;
@@ -311,7 +311,7 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 		link->dpia_bw_alloc_config.estimated_bw =
 				bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 
-		dc_link_set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.estimated_bw);
+		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.estimated_bw);
 		link->dpia_bw_alloc_config.response_ready = false;
 
 		/*
@@ -399,7 +399,7 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 		break;
 	}
 }
-int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw)
+int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw)
 {
 	int ret = 0;
 	uint8_t timeout = 10;
@@ -413,7 +413,7 @@ int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *li
 
 		// If DP over USB4 then we need to check BW allocation
 		link->dpia_bw_alloc_config.sink_max_bw = peak_bw;
-		dc_link_set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.sink_max_bw);
+		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.sink_max_bw);
 
 		do {
 			if (!(timeout > 0))
@@ -448,7 +448,7 @@ int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int re
 	 * allocated max sink bw so no need to re-alloc
 	 */
 	if (req_bw != link->dpia_bw_alloc_config.sink_allocated_bw) {
-		dc_link_set_usb4_req_bw_req(link, req_bw);
+		set_usb4_req_bw_req(link, req_bw);
 		do {
 			if (!(timeout > 0))
 				timeout--;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index e869e5e36568..cfb255b63dd1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -56,4 +56,28 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link);
  */
 int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
 
+/*
+ * Handle the USB4 BW Allocation related functionality here:
+ * Plug => Try to allocate max bw from timing parameters supported by the sink
+ * Unplug => de-allocate bw
+ *
+ * @link: pointer to the dc_link struct instance
+ * @peak_bw: Peak bw used by the link/sink
+ *
+ * return: allocated bw else return 0
+ */
+int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw);
+
+/*
+ * Handle function for when the status of the Request above is complete.
+ * We will find out the result of allocating on CM and update structs.
+ *
+ * @link: pointer to the dc_link struct instance
+ * @bw: Allocated or Estimated BW depending on the result
+ * @result: Response type
+ *
+ * return: none
+ */
+void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result);
+
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 9d80427520cf..6611d0767bd4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -39,7 +39,7 @@
 
 #define DC_LOGGER_INIT(logger)
 
-bool dc_link_check_link_loss_status(
+bool dp_parse_link_loss_status(
 	struct dc_link *link,
 	union hpd_irq_data *hpd_irq_dpcd_data)
 {
@@ -174,7 +174,7 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 	return false;
 }
 
-void dc_link_dp_handle_link_loss(struct dc_link *link)
+void dp_handle_link_loss(struct dc_link *link)
 {
 	struct pipe_ctx *pipes[MAX_PIPES];
 	struct dc_state *state = link->dc->current_state;
@@ -200,7 +200,7 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 	}
 }
 
-enum dc_status dc_link_dp_read_hpd_rx_irq_data(
+enum dc_status dp_read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
 {
@@ -247,7 +247,7 @@ enum dc_status dc_link_dp_read_hpd_rx_irq_data(
 }
 
 /*************************Short Pulse IRQ***************************/
-bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link)
+bool dp_should_allow_hpd_rx_irq(const struct dc_link *link)
 {
 	/*
 	 * Don't handle RX IRQ unless one of following is met:
@@ -262,8 +262,9 @@ bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link)
 	return false;
 }
 
-bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
-							bool defer_handling, bool *has_left_work)
+bool dp_handle_hpd_rx_irq(struct dc_link *link,
+		union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
+		bool defer_handling, bool *has_left_work)
 {
 	union hpd_irq_data hpd_irq_dpcd_data = {0};
 	union device_service_irq device_service_clear = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
index 39b2e51ea79d..ac33730fedd4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
@@ -27,5 +27,15 @@
 #define __DC_LINK_DP_IRQ_HANDLER_H__
 
 #include "link.h"
-
+bool dp_parse_link_loss_status(
+	struct dc_link *link,
+	union hpd_irq_data *hpd_irq_dpcd_data);
+bool dp_should_allow_hpd_rx_irq(const struct dc_link *link);
+void dp_handle_link_loss(struct dc_link *link);
+enum dc_status dp_read_hpd_rx_irq_data(
+	struct dc_link *link,
+	union hpd_irq_data *irq_data);
+bool dp_handle_hpd_rx_irq(struct dc_link *link,
+		union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
+		bool defer_handling, bool *has_left_work);
 #endif /* __DC_LINK_DP_IRQ_HANDLER_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index cd9fb8126bcf..92c2aa104eb5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -40,7 +40,7 @@
 #define DC_LOGGER \
 	link->ctx->logger
 
-void dc_link_dp_receiver_power_ctrl(struct dc_link *link, bool on)
+void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
 {
 	uint8_t state;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
index 831ffd456291..207bff2ec32e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
@@ -46,6 +46,9 @@ void dp_set_hw_lane_settings(
 
 enum dc_status dp_set_fec_ready(struct dc_link *link,
 		const struct link_resource *link_res, bool ready);
+
 void dp_set_fec_enable(struct dc_link *link, bool enable);
 
+void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on);
+
 #endif /* __DC_LINK_DP_PHY_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index cb0049cd1133..2948319b06f8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -777,7 +777,7 @@ enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
 	return pattern;
 }
 
-enum lttpr_mode dc_link_decide_lttpr_mode(struct dc_link *link,
+enum lttpr_mode dp_decide_lttpr_mode(struct dc_link *link,
 		struct dc_link_settings *link_setting)
 {
 	enum dp_link_encoding encoding = link_dp_get_encoding_format(link_setting);
@@ -1587,12 +1587,12 @@ bool perform_link_training_with_retries(
 		dp_set_panel_mode(link, panel_mode);
 
 		if (link->aux_access_disabled) {
-			dc_link_dp_perform_link_training_skip_aux(link, &pipe_ctx->link_res, &cur_link_settings);
+			dp_perform_link_training_skip_aux(link, &pipe_ctx->link_res, &cur_link_settings);
 			return true;
 		} else {
 			/** @todo Consolidate USB4 DP and DPx.x training. */
 			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-				status = dc_link_dpia_perform_link_training(
+				status = dpia_perform_link_training(
 						link,
 						&pipe_ctx->link_res,
 						&cur_link_settings,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
index a04948635369..7d027bac8255 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
@@ -119,6 +119,9 @@ enum dc_dp_training_pattern decide_cr_training_pattern(
 enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
 		const struct dc_link_settings *link_settings);
 
+enum lttpr_mode dp_decide_lttpr_mode(struct dc_link *link,
+		struct dc_link_settings *link_setting);
+
 void dp_get_lttpr_mode_override(struct dc_link *link,
 		enum lttpr_mode *override);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c
index e50ec5012559..4c6b886a9da8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c
@@ -30,7 +30,7 @@
 #include "link_dp_phy.h"
 #define DC_LOGGER \
 	link->ctx->logger
-bool dc_link_dp_perform_link_training_skip_aux(
+bool dp_perform_link_training_skip_aux(
 	struct dc_link *link,
 	const struct link_resource *link_res,
 	const struct dc_link_settings *link_setting)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.h
index 413999cd03c4..546387a5f32d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.h
@@ -28,7 +28,7 @@
 #define __DC_LINK_DP_TRAINING_AUXLESS_H__
 #include "link_dp_training.h"
 
-bool dc_link_dp_perform_link_training_skip_aux(
+bool dp_perform_link_training_skip_aux(
 	struct dc_link *link,
 	const struct link_resource *link_res,
 	const struct dc_link_settings *link_setting);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index 7711fda42261..0f56db4018e1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -985,7 +985,7 @@ static void dpia_training_abort(
 	core_link_send_set_config(link, DPIA_SET_CFG_SET_LINK, data);
 }
 
-enum link_training_result dc_link_dpia_perform_link_training(
+enum link_training_result dpia_perform_link_training(
 	struct dc_link *link,
 	const struct link_resource *link_res,
 	const struct dc_link_settings *link_setting,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h
index 0150f2916421..b39fb9faf1c2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h
@@ -32,7 +32,7 @@
  * DPIA equivalent of dc_link_dp_perfrorm_link_training.
  * Aborts link training upon detection of sink unplug.
  */
-enum link_training_result dc_link_dpia_perform_link_training(
+enum link_training_result dpia_perform_link_training(
 	struct dc_link *link,
 	const struct link_resource *link_res,
 	const struct dc_link_settings *link_setting,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index da7f83835f78..2f7e0f464144 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -139,7 +139,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 	return DP_PANEL_MODE_DEFAULT;
 }
 
-bool dc_link_set_backlight_level_nits(struct dc_link *link,
+bool edp_set_backlight_level_nits(struct dc_link *link,
 		bool isHDR,
 		uint32_t backlight_millinits,
 		uint32_t transition_time_in_ms)
@@ -171,7 +171,7 @@ bool dc_link_set_backlight_level_nits(struct dc_link *link,
 	return true;
 }
 
-bool dc_link_get_backlight_level_nits(struct dc_link *link,
+bool edp_get_backlight_level_nits(struct dc_link *link,
 		uint32_t *backlight_millinits_avg,
 		uint32_t *backlight_millinits_peak)
 {
@@ -299,7 +299,7 @@ bool link_is_edp_ilr_optimization_required(struct dc_link *link,
 	return false;
 }
 
-void dc_link_edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd)
+void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd)
 {
 	if (link->connector_signal != SIGNAL_TYPE_EDP)
 		return;
@@ -311,7 +311,7 @@ void dc_link_edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hp
 		link->dc->hwss.edp_backlight_control(link, true);
 }
 
-bool dc_link_wait_for_t12(struct dc_link *link)
+bool edp_wait_for_t12(struct dc_link *link)
 {
 	if (link->connector_signal == SIGNAL_TYPE_EDP && link->dc->hwss.edp_wait_for_T12) {
 		link->dc->hwss.edp_wait_for_T12(link);
@@ -422,7 +422,7 @@ static struct pipe_ctx *get_pipe_from_link(const struct dc_link *link)
 	return pipe_ctx;
 }
 
-bool dc_link_set_backlight_level(const struct dc_link *link,
+bool edp_set_backlight_level(const struct dc_link *link,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
 {
@@ -453,7 +453,7 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 	return true;
 }
 
-bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
+bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
 		bool wait, bool force_static, const unsigned int *power_opts)
 {
 	struct dc  *dc = link->ctx->dc;
@@ -502,7 +502,7 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
 	return true;
 }
 
-bool dc_link_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
+bool edp_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
@@ -557,7 +557,7 @@ transmitter_to_phy_id(struct dc_link *link)
 	}
 }
 
-bool dc_link_setup_psr(struct dc_link *link,
+bool edp_setup_psr(struct dc_link *link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context)
 {
@@ -803,7 +803,7 @@ static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 	return abm;
 }
 
-int dc_link_get_backlight_level(const struct dc_link *link)
+int edp_get_backlight_level(const struct dc_link *link)
 {
 	struct abm *abm = get_abm_from_stream_res(link);
 	struct panel_cntl *panel_cntl = link->panel_cntl;
@@ -822,7 +822,7 @@ int dc_link_get_backlight_level(const struct dc_link *link)
 		return DC_ERROR_UNEXPECTED;
 }
 
-int dc_link_get_target_backlight_pwm(const struct dc_link *link)
+int edp_get_target_backlight_pwm(const struct dc_link *link)
 {
 	struct abm *abm = get_abm_from_stream_res(link);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 7f91a564b089..4439598f9f7d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -30,4 +30,24 @@
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool set_default_brightness_aux(struct dc_link *link);
+void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
+int edp_get_backlight_level(const struct dc_link *link);
+bool edp_get_backlight_level_nits(struct dc_link *link,
+		uint32_t *backlight_millinits_avg,
+		uint32_t *backlight_millinits_peak);
+bool edp_set_backlight_level(const struct dc_link *link,
+		uint32_t backlight_pwm_u16_16,
+		uint32_t frame_ramp);
+bool edp_set_backlight_level_nits(struct dc_link *link,
+		bool isHDR,
+		uint32_t backlight_millinits,
+		uint32_t transition_time_in_ms);
+int edp_get_target_backlight_pwm(const struct dc_link *link);
+bool edp_get_psr_state(const struct dc_link *link, enum dc_psr_state *state);
+bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
+		bool wait, bool force_static, const unsigned int *power_opts);
+bool edp_setup_psr(struct dc_link *link,
+		const struct dc_stream_state *stream, struct psr_config *psr_config,
+		struct psr_context *psr_context);
+bool edp_wait_for_t12(struct dc_link *link);
 #endif /* __DC_LINK_EDP_POWER_CONTROL_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
index 5f39dfe06e9a..e3d729ab5b9f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
@@ -33,18 +33,18 @@
 #include "link_hpd.h"
 #include "gpio_service_interface.h"
 
-bool dc_link_get_hpd_state(struct dc_link *dc_link)
+bool link_get_hpd_state(struct dc_link *link)
 {
 	uint32_t state;
 
-	dal_gpio_lock_pin(dc_link->hpd_gpio);
-	dal_gpio_get_value(dc_link->hpd_gpio, &state);
-	dal_gpio_unlock_pin(dc_link->hpd_gpio);
+	dal_gpio_lock_pin(link->hpd_gpio);
+	dal_gpio_get_value(link->hpd_gpio, &state);
+	dal_gpio_unlock_pin(link->hpd_gpio);
 
 	return state;
 }
 
-void dc_link_enable_hpd(const struct dc_link *link)
+void link_enable_hpd(const struct dc_link *link)
 {
 	struct link_encoder *encoder = link->link_enc;
 
@@ -52,7 +52,7 @@ void dc_link_enable_hpd(const struct dc_link *link)
 		encoder->funcs->enable_hpd(encoder);
 }
 
-void dc_link_disable_hpd(const struct dc_link *link)
+void link_disable_hpd(const struct dc_link *link)
 {
 	struct link_encoder *encoder = link->link_enc;
 
@@ -60,7 +60,7 @@ void dc_link_disable_hpd(const struct dc_link *link)
 		encoder->funcs->disable_hpd(encoder);
 }
 
-void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
+void link_enable_hpd_filter(struct dc_link *link, bool enable)
 {
 	struct gpio *hpd;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
index 3d122def0c88..bd471b63476e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
@@ -44,4 +44,8 @@ bool program_hpd_filter(const struct dc_link *link);
  */
 bool dpia_query_hpd_status(struct dc_link *link);
 bool query_hpd_status(struct dc_link *link, uint32_t *is_hpd_high);
+bool link_get_hpd_state(struct dc_link *link);
+void link_enable_hpd(const struct dc_link *link);
+void link_disable_hpd(const struct dc_link *link);
+void link_enable_hpd_filter(struct dc_link *link, bool enable);
 #endif /* __DC_LINK_HPD_H__ */
-- 
2.34.1

