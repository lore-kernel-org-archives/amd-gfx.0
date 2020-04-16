Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BFC352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB52D21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AO8cEY35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB52D21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94D78912F;
	Thu, 16 Apr 2020 23:41:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFE589010
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAtm5jfzWFmlaToIPUEjlIx6rpDvwhBSQgeOdbxrmxWwR29eEYyXBd/KkCmiZvOnz6sYCufDKNj9EdEgsMBIVpKrEfRGp/pxtPbJHXg1ma+/A/A0J16W74ZwLa6RLZnS+LrJkIKkribrmaMo6PLk2DxoXyfYNp9ZH713aF1qqZl150cqobYqD7qbtIdcGkOtdIwxgQ9CdQLN7JrWLSMijfzt8Y5ZhQ3RF0q3rbDXfkPR7wtuTdxzSeIS8f9dcONr64kpmAuwMl67VBiUuU2zup8EqCgaucxroQzlkn6/dIgPv/OA6P1Wgivwz8/71xuSJWt9k9qled9h4n1UdMLiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IywmLys8BrnO3G8ZlTl7ckIzVd0FVvZVEYIoUlqT664=;
 b=FMBEjbKlDhvcNWkXreBZVzoT3e0sq3+vsc7BjOPKmS0zPfYFCGuIOJHUiIX+FTCGH8kmNi5ONdGPIqE36XRAHD4gqKB8wzKkVekfu3GcKiGH6nGQpCHAwtqwg/oll/U3Ay8kxkHSXw0lRGGIxmGqVsAS7VlBynl+h01yZVr9/T0W/4Yy/RojpxjnmSB9Wc7zHHhspjDdFZJB0krG1EbWiopaQoKpV3aKiWfwc4BbRbD9hYZ4NLifvrKB8QHgN4iZpaePoru9UhzdN5kYJWZOybMJ3r73H5/E6ajGGm+/I1VNOOfPOh/IsK/pfyon6ecjagTN4Ixd/Zjmqp9+v9dK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IywmLys8BrnO3G8ZlTl7ckIzVd0FVvZVEYIoUlqT664=;
 b=AO8cEY35Lou3cptrXbIfF8/tyZg9nL0bCj2jQw5q+3rEwPd0uOjW1BWj3DRXZLBkVhLXbAUbusxe/JMV7DwlQW+reSCbw1nUNyCVbeFWro6zUL18cABmvIwPrF57iEYbDtyWUSBjGXtr83rzQR/F1KoCguy754NU+kEJbplYsVE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:19 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:19 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/35] drm/amd/display: Unify psr feature flags
Date: Thu, 16 Apr 2020 19:40:17 -0400
Message-Id: <20200416234044.2082886-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:18 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: baf52ecb-a071-4176-402e-08d7e25fa9c3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245913859F27C47809B2E58898D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(30864003)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77iRaGnztiM+skA3Wh5chLbn1fZ1zOm+8pDhd7fMdj8s/WVoYuKpNKiLfWYJ8qtPx2WFSddleHi/WYMPjZp0bptXESakrygtuKvt3DXkBCE8P784ur4Y0YCoS8I/KV4y+j28WjIMkbUeX4YmW6RywTidoZUmfaS/xLNL4O63EOz7cyZzipcFZoXg+gn23adOPkxSZojjGF+JaTd62Esx8XFGADH0W2P/n7NSs6DWRdzzj4x6YX4C6QGIWVqEyDW6vvNJrUkXe0Z5TOBFANK6DmH29l9D94Dyj9A1rQS8bAcnsw3VHc8qqODXovB69XpGkHkbcB+TveYnVFjdqS07gutlJTN3eVViQx25TxKqHnwLxTt0Or6f5oFAmfqFuqramSskY1gNt8ejva7s5nfUm06gTdqTtM07XpxFHfhv9yt3ruBMq+azgRNQOPIPe5OT
X-MS-Exchange-AntiSpam-MessageData: glXtzZbgxhJtyoHC43Gt2QonBOZ40EkDGl3pMocMVjQPqovtbPEuP2x6uLQrSJh7XeDduNazJnS//yUGPQwOvZpe2xF7ZN3bYXKJMAZqUVRlQB1N6gcTHKAT+mj1DQZMIzlVnZMtXwKqpkjKYi4ap2lrmbb8lUnAbwJNMpDQwC0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf52ecb-a071-4176-402e-08d7e25fa9c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:19.7258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnK730k1eIuXOc5IkXw+F9kd1c7DE8pKQ6UqlwU+vJ+lbUJGy32y7Wfzskpz0IavfOZ0io+gCSQHyZUW50uvJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
As it stands, psr has feature flags in dm, stream, and link. Most are
not defined well enough, and different dm layers have different uses for
these same flags.

[How]
We define a new structure called psr_settings in dc_link that will hold
the following psr feature flags:

psr_feature_enable - psr is supported
psr_allow_active - psr is currently active
psr_version - internal psr version supported
psr_frame_capture_indication_req
psr_sdp_transmit_line_num_deadline
The last two flags were moved out of the power module
for the purposes of consolidating psr flags.
Their use is already well-defined.

Psr caps reported by sink will also be stored in dc_link,
in dpcd_caps.psr_caps.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 +++++++++++--------
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 19 +++++-----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  6 ++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 21 +++++++++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 --
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 13 ++++---
 .../display/dc/dce110/dce110_hw_sequencer.c   |  4 +--
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  1 +
 .../display/modules/info_packet/info_packet.c |  3 +-
 13 files changed, 72 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 47d12c38bc71..671741713b04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4412,14 +4412,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
-	if (stream->link->psr_feature_enabled)	{
+	if (stream->link->psr_settings.psr_feature_enabled)	{
 		struct dc  *core_dc = stream->link->ctx->dc;
 
 		if (dc_is_dmcu_initialized(core_dc)) {
-			struct dmcu *dmcu = core_dc->res_pool->dmcu;
-
-			stream->psr_version = dmcu->dmcu_version.psr_version;
-
 			//
 			// should decide stream support vsc sdp colorimetry capability
 			// before building vsc info packet
@@ -6919,7 +6915,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		}
 		mutex_lock(&dm->dc_lock);
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_allow_active)
+				acrtc_state->stream->link->psr_settings.psr_allow_active)
 			amdgpu_dm_psr_disable(acrtc_state->stream);
 
 		dc_commit_updates_for_stream(dm->dc,
@@ -6930,12 +6926,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 						     dc_state);
 
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-						acrtc_state->stream->psr_version &&
-						!acrtc_state->stream->link->psr_feature_enabled)
+				acrtc_state->stream->link->psr_settings.psr_version != PSR_VERSION_UNSUPPORTED &&
+				!acrtc_state->stream->link->psr_settings.psr_feature_enabled)
 			amdgpu_dm_link_setup_psr(acrtc_state->stream);
 		else if ((acrtc_state->update_type == UPDATE_TYPE_FAST) &&
-						acrtc_state->stream->link->psr_feature_enabled &&
-						!acrtc_state->stream->link->psr_allow_active) {
+				acrtc_state->stream->link->psr_settings.psr_feature_enabled &&
+				!acrtc_state->stream->link->psr_settings.psr_allow_active) {
 			amdgpu_dm_psr_enable(acrtc_state->stream);
 		}
 
@@ -7249,7 +7245,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
 			/* i.e. reset mode */
 			if (dm_old_crtc_state->stream) {
-				if (dm_old_crtc_state->stream->link->psr_allow_active)
+				if (dm_old_crtc_state->stream->link->psr_settings.psr_allow_active)
 					amdgpu_dm_psr_disable(dm_old_crtc_state->stream);
 
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
@@ -8699,8 +8695,17 @@ static void amdgpu_dm_set_psr_caps(struct dc_link *link)
 		return;
 	if (dm_helpers_dp_read_dpcd(NULL, link, DP_PSR_SUPPORT,
 					dpcd_data, sizeof(dpcd_data))) {
-		link->psr_feature_enabled = dpcd_data[0] ? true:false;
-		DRM_INFO("PSR support:%d\n", link->psr_feature_enabled);
+		link->dpcd_caps.psr_caps.psr_version = dpcd_data[0];
+
+		if (dpcd_data[0] == 0) {
+			link->psr_settings.psr_version = PSR_VERSION_UNSUPPORTED;
+			link->psr_settings.psr_feature_enabled = false;
+		} else {
+			link->psr_settings.psr_version = PSR_VERSION_1;
+			link->psr_settings.psr_feature_enabled = true;
+		}
+
+		DRM_INFO("PSR support:%d\n", link->psr_settings.psr_feature_enabled);
 	}
 }
 
@@ -8724,7 +8729,7 @@ static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 	link = stream->link;
 	dc = link->ctx->dc;
 
-	psr_config.psr_version = dc->res_pool->dmcu->dmcu_version.psr_version;
+	psr_config.psr_version = link->dpcd_caps.psr_caps.psr_version;
 
 	if (psr_config.psr_version > 0) {
 		psr_config.psr_exit_link_training_required = 0x1;
@@ -8736,7 +8741,7 @@ static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 		ret = dc_link_setup_psr(link, stream, &psr_config, &psr_context);
 
 	}
-	DRM_DEBUG_DRIVER("PSR link: %d\n",	link->psr_feature_enabled);
+	DRM_DEBUG_DRIVER("PSR link: %d\n",	link->psr_settings.psr_feature_enabled);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 8ec2dfe45d40..a5c2114e4292 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -90,7 +90,7 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 		dc->hwss.exit_optimized_pwr_state(dc, dc->current_state);
 
 	if (edp_link) {
-		clk_mgr->psr_allow_active_cache = edp_link->psr_allow_active;
+		clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
 		dc_link_set_psr_allow_active(edp_link, false, false);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8489f1e56892..9bde05547b30 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -66,6 +66,8 @@
 
 #include "dce/dce_i2c.h"
 
+#include "dmub/inc/dmub_cmd_dal.h"
+
 #define CTX \
 	dc->ctx
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ef8184296a7e..44b8efa3510b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -46,6 +46,7 @@
 #include "dmcu.h"
 #include "hw/clk_mgr.h"
 #include "dce/dmub_psr.h"
+#include "dmub/inc/dmub_cmd_dal.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1529,6 +1530,8 @@ static bool dc_link_construct(struct dc_link *link,
 	 */
 	program_hpd_filter(link);
 
+	link->psr_settings.psr_version = PSR_VERSION_UNSUPPORTED;
+
 	return true;
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
@@ -2521,12 +2524,12 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
 
-	if (psr != NULL && link->psr_feature_enabled)
+	if (psr != NULL && link->psr_settings.psr_feature_enabled)
 		psr->funcs->psr_enable(psr, allow_active);
-	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_feature_enabled)
+	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
 
-	link->psr_allow_active = allow_active;
+	link->psr_settings.psr_allow_active = allow_active;
 
 	return true;
 }
@@ -2537,9 +2540,9 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
 
-	if (psr != NULL && link->psr_feature_enabled)
+	if (psr != NULL && link->psr_settings.psr_feature_enabled)
 		psr->funcs->psr_get_state(psr, psr_state);
-	else if (dmcu != NULL && link->psr_feature_enabled)
+	else if (dmcu != NULL && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->get_psr_state(dmcu, psr_state);
 
 	return true;
@@ -2710,14 +2713,14 @@ bool dc_link_setup_psr(struct dc_link *link,
 	psr_context->frame_delay = 0;
 
 	if (psr)
-		link->psr_feature_enabled = psr->funcs->psr_copy_settings(psr, link, psr_context);
+		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr, link, psr_context);
 	else
-		link->psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
+		link->psr_settings.psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
 	/* psr_enabled == 0 indicates setup_psr did not succeed, but this
 	 * should not happen since firmware should be running at this point
 	 */
-	if (link->psr_feature_enabled == 0)
+	if (link->psr_settings.psr_feature_enabled == 0)
 		ASSERT(0);
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 74cf06aacd6c..3408c36ace48 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2417,7 +2417,7 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 {
 	union dpcd_psr_configuration psr_configuration;
 
-	if (!link->psr_feature_enabled)
+	if (!link->psr_settings.psr_feature_enabled)
 		return false;
 
 	dm_helpers_dp_read_dpcd(
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8560032a66ba..1b30804f56db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -990,6 +990,7 @@ struct dpcd_caps {
 	union dpcd_fec_capability fec_cap;
 	struct dpcd_dsc_capabilities dsc_caps;
 	struct dc_lttpr_caps lttpr_caps;
+	struct psr_caps psr_caps;
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index bb2730e9521e..af177c087d3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -740,5 +740,11 @@ struct dpcd_dsc_capabilities {
 	union dpcd_dsc_ext_capabilities dsc_ext_caps;
 };
 
+/* These parameters are from PSR capabilities reported by Sink DPCD */
+struct psr_caps {
+	unsigned char psr_version;
+	unsigned int psr_rfb_setup_time;
+	bool psr_exit_link_training_required;
+};
 
 #endif /* DC_DP_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index e131dc99f283..34c6527c7c3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -29,6 +29,7 @@
 #include "dc.h"
 #include "dc_types.h"
 #include "grph_object_defs.h"
+#include "dmub/inc/dmub_cmd_dal.h"
 
 enum dc_link_fec_state {
 	dc_link_fec_not_ready,
@@ -66,6 +67,22 @@ struct time_stamp {
 struct link_trace {
 	struct time_stamp time_stamp;
 };
+
+/* PSR feature flags */
+struct psr_settings {
+	bool psr_feature_enabled;		// PSR is supported by sink
+	bool psr_allow_active;			// PSR is currently active
+	enum psr_version psr_version;		// Internal PSR version, determined based on DPCD
+
+	/* These parameters are calculated in Driver,
+	 * based on display timing and Sink capabilities.
+	 * If VBLANK region is too small and Sink takes a long time
+	 * to set up RFB, it may take an extra frame to enter PSR state.
+	 */
+	bool psr_frame_capture_indication_req;
+	unsigned int psr_sdp_transmit_line_num_deadline;
+};
+
 /*
  * A link contains one or more sinks and their connected status.
  * The currently active signal type (HDMI, DP-SST, DP-MST) is also reported.
@@ -130,10 +147,10 @@ struct dc_link {
 	struct hdcp_caps hdcp_caps;
 #endif
 	enum edp_revision edp_revision;
-	bool psr_feature_enabled;
-	bool psr_allow_active;
 	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
+	struct psr_settings psr_settings;
+
 	/* MST record stream using this link */
 	struct link_flags {
 		bool dp_keep_receiver_powered;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index a5c7ef47b8d3..49aad691e687 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -167,8 +167,6 @@ struct dc_stream_state {
 
 	/* TODO: custom INFO packets */
 	/* TODO: ABM info (DMCU) */
-	/* PSR info */
-	unsigned char psr_version;
 	/* TODO: CEA VIC */
 
 	/* DMCU info */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 31a9b12ff880..ccd40cffc26c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -53,16 +53,15 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 
+	if (stream->link->psr_settings.psr_version == PSR_VERSION_UNSUPPORTED)
+		return false;
+
 	cmd.psr_set_version.header.type = DMUB_CMD__PSR;
 	cmd.psr_set_version.header.sub_type = DMUB_CMD__PSR_SET_VERSION;
+	cmd.psr_set_version.psr_set_version_data.version = stream->link->psr_settings.psr_version;
+	cmd.psr_set_version.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_version_data);
 
-	if (stream->psr_version == 0x0) // Unsupported
-		return false;
-	else if (stream->psr_version == 0x1)
-		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_1;
-	cmd.psr_enable.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_version_data);
-
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_enable.header);
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_set_version.header);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index c279982947e1..78240db90004 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1432,7 +1432,7 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != 0;
 
-	pipe_ctx->stream->link->psr_feature_enabled = false;
+	pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
 
 	return DC_OK;
 }
@@ -1838,7 +1838,7 @@ static bool should_enable_fbc(struct dc *dc,
 		return false;
 
 	/* PSR should not be enabled */
-	if (pipe_ctx->stream->link->psr_feature_enabled)
+	if (pipe_ctx->stream->link->psr_settings.psr_feature_enabled)
 		return false;
 
 	/* Nothing to compress */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
index cb52ebad0ef9..e42de9ded275 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
@@ -41,6 +41,7 @@ enum dmub_cmd_psr_type {
 
 enum psr_version {
 	PSR_VERSION_1				= 0,
+	PSR_VERSION_UNSUPPORTED			= 0xFFFFFFFF,
 };
 
 enum dmub_cmd_abm_type {
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index cff3ab15fc0c..22a5484d9f28 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -29,6 +29,7 @@
 #include "mod_shared.h"
 #include "mod_freesync.h"
 #include "dc.h"
+#include "dmub/inc/dmub_cmd_dal.h"
 
 enum vsc_packet_revision {
 	vsc_packet_undefined = 0,
@@ -144,7 +145,7 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 
 	/*VSC packet set to 2 when DP revision >= 1.2*/
-	if (stream->psr_version != 0)
+	if (stream->link->psr_settings.psr_version != PSR_VERSION_UNSUPPORTED)
 		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
