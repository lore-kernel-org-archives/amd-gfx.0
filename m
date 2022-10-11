Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C7FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 18:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2387D10E64E;
	Tue, 11 Oct 2022 18:12:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91AC10E470
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 18:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmjxzhEB+B2dYZKMsd4yUlyyxwib0CQe363NwtPDtIwI6c5C7EtYS/FTS9ANKprLCgaxJOV8D6Bl0vwEWRlA0YZYMRkRqSjcb5wGpvTc+V5CokAg8xrq5h/2dB0EMRjdD3X0ZKs009TlsHZXnL0sgH253pSmBNVo1B1pxOHQVZoiaWztZ5uHCFoBivJt8xzm3G1TDX34hAQIYLH7N00BSZbI5i5VeTtfQgUiFMQNDIk01I9HdFFbsP8e8XqtLwht9rHFCpnT5dyPcJkMKQXmgNWizj2uHg0T3xVteM61xnkT4nKVFogGGhoyJ73NF81Wm5plgxqUdyyAByq93sgiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvNNt88pA/q2zpPW5A/yg5AwhJoJ9bMTrYK5idEPW00=;
 b=gJQ8SkGyAJKaUKoa0MU17vRKDajQfNpU8ch0HbG/YpDFJZFFIajV1kllwXoEoWgohWJNjjEapLACiNRG7VkIc6GbajL0CuKOgmTjlPug4NsRbXGvSGvDTqT2HfFaN+TYmifkNJ9Z8OShQruRQK7h0ew1tNk5ESJ+CyjH1eait3tQ3HSA+BV12rCtNhtl1kGsy9/vA1i9hQK++KCbhQbUXH9/t83TtFrZGiqodMHwSV+HYec7WZQfHvK7bw/5dNj63n/D1Nub5hX1s3pfPxYmr+4qRipyFqA/7q1Vp/oKiWv9/eijdHBKh4/FJRk57q+zSwIzm3FhP7onMou37PYAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvNNt88pA/q2zpPW5A/yg5AwhJoJ9bMTrYK5idEPW00=;
 b=evHaPdxOfgjYJeF92NHY7qkvaiQiHIe+X+exSaxj8ItH63tpltc64aRpfdJveO8DaXYs+r3cJNqXCyZPVbvLRgo1o9F3i5rL4zZiEqsNQUb5fUzD+tpT0nJ5xcYySPEwdIMTEEFWRlASoPdoM5ygdI1tRLHfZxvjcV1FDUzrGJw=
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 18:11:53 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::41) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 18:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 18:11:52 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 13:11:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/display: Add functions for new DC commit sequence
Date: Tue, 11 Oct 2022 14:11:38 -0400
Message-ID: <20221011181140.94595-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
References: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c089b5e-4900-439a-d1d4-08daabb41305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysuVuEdaUoW0KNdQtQJgvLKXigDotGYWz/plngVyBf/wdRjHUqF8aQMjITsg4ZiuQloloTEIaKf54S5T5xUHU5AcUQwefXi/1nhyVpi5TUXl0J6qrjAF59yi5IdmWXrRWxpXhkhyGOs510m03t4wr3hgAh+CU15iitYi4FWPOMmYoisz+9PE5mzQyTzKCCZGeUlLdffOwBb5+/3yKmSKAQfDVfvpcG4ar9EGbqoKU6vn/BHxrrN4Zl+DyjJlwfB2UTZgSzkpuM5Ipspt/x0fqclG8vL6wLWb4J61mIQ7TACWlrDg8ZpXnZ16wnX5dlWgEpnptgvM9u2JaDX2p1VgC58tDMSqDPkuTYrtJ/fg1M3J2Sk/AfbkungWybpYBIqhWJo9sqw2PApu6nesmfKn44RQezKLfJ2SQa3Nn7NehmKHVRQppcSp/ta4wXgLO3DgX8ACoy8C4GBNiYemCqLGP6/LJpdrEZAar8OXP0GR1GubepVrch20kzy4m1v7zRgXY0Cv+5T0nWpKRHg36koq1+1GS4+CgdKba4yXQ3o0RLHc6B/dvxZq/+OhiZV0wBwjI0xhdJCNEICS1KvpzFVbM3y04pqp5hkG+B2N/ux3uAlgeK9nlIRYdJK0mfdP5avzNsEp+PIronAup7yMcq9Mlww/xk3APp/gZ3Lx2WYurqk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(7696005)(26005)(70206006)(82740400003)(316002)(8676002)(86362001)(70586007)(4326008)(36860700001)(81166007)(40460700003)(36756003)(40480700001)(356005)(83380400001)(186003)(1076003)(16526019)(6666004)(478600001)(2616005)(2906002)(47076005)(54906003)(336012)(5660300002)(426003)(8936002)(6916009)(30864003)(41300700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 18:11:52.7645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c089b5e-4900-439a-d1d4-08daabb41305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since DCN32, our DC commit become more complex and requires more
adjustments to work well with some features. This is a preparation work
for replacing dc_commit_state and dc_commit_updates_for_stream with
dc_update_planes_and_stream and dc_update_planes_and_stream
respectively.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  92 ++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 204 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +-
 4 files changed, 308 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 660316a536f7..ad3aafb73cba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -59,6 +59,7 @@
 
 #include "dc_link_dp.h"
 #include "dc_dmub_srv.h"
+#include "dc_stream.h"
 
 #include "dsc.h"
 
@@ -1505,6 +1506,25 @@ static bool context_changed(
 	return false;
 }
 
+static bool streams_changed(struct dc *dc,
+			    struct dc_stream_state *streams[],
+			    uint8_t stream_count)
+{
+	uint8_t i;
+
+	if (stream_count != dc->current_state->stream_count)
+		return true;
+
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		if (dc->current_state->streams[i] != streams[i])
+			return true;
+		if (!streams[i]->link->link_state_valid)
+			return true;
+	}
+
+	return false;
+}
+
 bool dc_validate_boot_timing(const struct dc *dc,
 				const struct dc_sink *sink,
 				struct dc_crtc_timing *crtc_timing)
@@ -1923,6 +1943,78 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	return (result == DC_OK);
 }
 
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count)
+{
+	int i, j;
+	struct dc_state *context;
+	enum dc_status res = DC_OK;
+	struct dc_validation_set set[MAX_STREAMS] = {0};
+
+	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
+		return res;
+
+	if (!streams_changed(dc, streams, stream_count))
+		return res;
+
+	DC_LOG_DC("%s: %d streams\n", __func__, stream_count);
+
+	for (i = 0; i < stream_count; i++) {
+		struct dc_stream_state *stream = streams[i];
+		struct dc_stream_status *status = dc_stream_get_status(stream);
+
+		dc_stream_log(dc, stream);
+
+		set[i].stream = stream;
+
+		if (status) {
+			set[i].plane_count = status->plane_count;
+			for (j = 0; j < status->plane_count; j++)
+				set[i].plane_states[j] = status->plane_states[j];
+		}
+	}
+
+	context = dc_create_state(dc);
+	if (!context)
+		goto context_alloc_fail;
+
+	dc_resource_state_copy_construct_current(dc, context);
+
+	res = dc_validate_with_context(dc, set, stream_count, context, false);
+	if (res != DC_OK) {
+		BREAK_TO_DEBUGGER();
+		goto fail;
+	}
+
+	res = dc_commit_state_no_check(dc, context);
+
+	for (i = 0; i < stream_count; i++) {
+		for (j = 0; j < context->stream_count; j++) {
+			if (streams[i]->stream_id == context->streams[j]->stream_id)
+				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+
+			if (dc_is_embedded_signal(streams[i]->signal)) {
+				struct dc_stream_status *status = dc_stream_get_status_from_state(context, streams[i]);
+
+				if (dc->hwss.is_abm_supported)
+					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, streams[i]);
+				else
+					status->is_abm_supported = true;
+			}
+		}
+	}
+
+fail:
+	dc_release_state(context);
+
+context_alloc_fail:
+
+	DC_LOG_DC("%s Finished.\n", __func__);
+
+	return res;
+}
+
 bool dc_acquire_release_mpc_3dlut(
 		struct dc *dc, bool acquire,
 		struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fd8db482e56f..0c58a19e9115 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2593,6 +2593,208 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
 	return dc->res_pool->res_cap->num_dsc > 0;
 }
 
+static bool planes_changed_for_existing_stream(struct dc_state *context,
+					       struct dc_stream_state *stream,
+					       const struct dc_validation_set set[],
+					       int set_count)
+{
+	int i, j;
+	struct dc_stream_status *stream_status = NULL;
+
+	for (i = 0; i < context->stream_count; i++)
+		if (context->streams[i] == stream) {
+			stream_status = &context->stream_status[i];
+			break;
+		}
+
+	if (!stream_status)
+		ASSERT(0);
+
+	for (i = 0; i < set_count; i++)
+		if (set[i].stream == stream)
+			break;
+
+	if (i == set_count)
+		ASSERT(0);
+
+	if (set[i].plane_count != stream_status->plane_count)
+		return true;
+
+	for (j = 0; j < set[i].plane_count; j++)
+		if (set[i].plane_states[j] != stream_status->plane_states[j])
+			return true;
+
+	return false;
+}
+
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate)
+{
+	struct dc_stream_state *unchanged_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *add_streams[MAX_PIPES] = { 0 };
+	int old_stream_count = context->stream_count;
+	enum dc_status res = DC_ERROR_UNEXPECTED;
+	int unchanged_streams_count = 0;
+	int del_streams_count = 0;
+	int add_streams_count = 0;
+	bool found = false;
+	int i, j, k;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	/* First remove from context all deleted streams */
+	for (i = 0; i < old_stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+
+		for (j = 0; j < set_count; j++) {
+			if (stream == set[j].stream) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			del_streams[del_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/* Now add new streams */
+	for (i = 0; i < set_count; i++) {
+		struct dc_stream_state *stream = set[i].stream;
+
+		for (j = 0; j < old_stream_count; j++) {
+			if (stream == context->streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			add_streams[add_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/*
+	 * Build array of unchanged  streams, it is needed to handle
+	 * planes only changes (added/removed/updated)
+	 */
+	for (i = 0; i < set_count; i++) {
+		for (j = 0; j < del_streams_count; j++) {
+			if (set[i].stream == del_streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			for (j = 0; j < add_streams_count; j++) {
+				if (set[i].stream == add_streams[j]) {
+					found = true;
+					break;
+				}
+			}
+		}
+
+		if (!found)
+			unchanged_streams[unchanged_streams_count++] = set[i].stream;
+
+		found = false;
+	}
+
+	/* Remove all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!dc_rem_all_planes_for_stream(dc,
+							  unchanged_streams[i],
+							  context)) {
+				res = DC_FAIL_DETACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	/* Remove all planes for removed streams and then remove the streams */
+	for (i = 0; i < del_streams_count; i++) {
+		/* Need to cpy the dwb data from the old stream in order to efc to work */
+		if (del_streams[i]->num_wb_info > 0) {
+			for (j = 0; j < add_streams_count; j++) {
+				if (del_streams[i]->sink == add_streams[j]->sink) {
+					add_streams[j]->num_wb_info = del_streams[i]->num_wb_info;
+					for (k = 0; k < del_streams[i]->num_wb_info; k++)
+						add_streams[j]->writeback_info[k] = del_streams[i]->writeback_info[k];
+				}
+			}
+		}
+
+		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
+			res = DC_FAIL_DETACH_SURFACES;
+			goto fail;
+		}
+
+		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+	}
+
+	/* Swap seamless boot stream to pipe 0 (if needed) to ensure pipe_ctx matches.
+	 * This may change in the future if seamless_boot_stream can be multiple.
+	 */
+	for (i = 0; i < add_streams_count; i++) {
+		mark_seamless_boot_stream(dc, add_streams[i]);
+		if (add_streams[i]->apply_seamless_boot_optimization && i != 0) {
+			struct dc_stream_state *temp = add_streams[0];
+
+			add_streams[0] = add_streams[i];
+			add_streams[i] = temp;
+			break;
+		}
+	}
+
+	/* Add new streams and then add all planes for the new stream */
+	for (i = 0; i < add_streams_count; i++) {
+		calculate_phy_pix_clks(add_streams[i]);
+		res = dc_add_stream_to_ctx(dc, context, add_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+
+		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
+			res = DC_FAIL_ATTACH_SURFACES;
+			goto fail;
+		}
+	}
+
+	/* Add all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, set_count, context)) {
+				res = DC_FAIL_ATTACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	res = dc_validate_global_state(dc, context, fast_validate);
+
+fail:
+	if (res != DC_OK) {
+		DC_LOG_WARNING("%s:resource validation failed, dc_status:%d\n",
+			       __func__,
+			       res);
+	}
+	return res;
+}
 
 /**
  * dc_validate_global_state() - Determine if HW can support a given state
@@ -3734,4 +3936,4 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
 	}
 
 	return true;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bfc5474c0f4c..2753d9eabd16 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1286,6 +1286,12 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
 
 void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info);
 
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate);
+
 bool dc_set_generic_gpio_for_stereo(bool enable,
 		struct gpio_service *gpio_service);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 9e6025c98db9..d5b3c80635ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -378,10 +378,9 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 				  uint32_t *h_position,
 				  uint32_t *v_position);
 
-enum dc_status dc_add_stream_to_ctx(
-			struct dc *dc,
-		struct dc_state *new_ctx,
-		struct dc_stream_state *stream);
+enum dc_status dc_add_stream_to_ctx(struct dc *dc,
+				    struct dc_state *new_ctx,
+				    struct dc_stream_state *stream);
 
 enum dc_status dc_remove_stream_from_ctx(
 		struct dc *dc,
@@ -445,6 +444,10 @@ enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
  *   Phy, Encoder, Timing Generator are programmed and enabled.
  *   New streams are enabled with blank stream; no memory read.
  */
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count);
+
 /*
  * Enable stereo when commit_streams is not required,
  * for example, frame alternate.
-- 
2.35.1

