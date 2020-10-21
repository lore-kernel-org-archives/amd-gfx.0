Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A354C55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE0922283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MB0GA8R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE0922283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D654F6EDD3;
	Wed, 21 Oct 2020 14:23:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AA56EDD1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxyXQZmZTqifTxtQbts1PEzzNtFeIZMfUrg9FCZEiFWZ+vpjpmxIxw41tWPJLp6VxzI1pOYHjOoJrAf68pwzKGsJcy0tHfHFWYndEKLoYygk5CyKURoOSQRIxmRNMhnw4pQsv5ZBd/JYT5BD7Jd1bclhwpvYasVDYAndmUuQ4w35cEwqrDHlkM+qD7K+/wwIj54+80LnpgWc6G8cebo5z/GJSTXK7S/MnzSXNhjCHQV4bdIzageVpplDgjOVk6EV4knz1m9mP+1Z4xN5F3eqxtrFoxxE7AnJ9hcnG4rqlOPS2NStGxIghflDVoES33AVNKzjKfYL31uO+Q6oSiswMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD8imedllPaovrloIJKnvPp3P/VRwe/UoFLHxVAaC3g=;
 b=exlHrx8NSVr0phtDPvuDvF5QCUFwT+KL8lnP2uSH0eVX1cpc3H+uCSU0yXCJKxoWP/1Wfyp0ttjoiwY+v6Jn1GsT1IBdE8BHsteQ8MtJR1WhAgVCKkEx9gp6pyDOUREBwrikcXIUba0KqHvn5Gnspnjo064Y2wzcfW0zZEu8hUL5Ew6ijM7Slp7hOF+kxbN5v7EEQjIn6j/8/DIPltGJtP1jCq+4X7tWbBGcYkOUmix0GQ07DWzJGmoFyS5cwk/Zvkv3ZZdDZpAvnVqduesFr0jm+NmFbYEj+5+qhIv8JACjC3myV9y3sDzWlmRiy/drOPkvj5JQ5PQGLsmyr53QKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD8imedllPaovrloIJKnvPp3P/VRwe/UoFLHxVAaC3g=;
 b=MB0GA8R1X5g4mJy+DAZnWeXjnKmltPYNIik1jRjpstYenK19SW5MHQ3ePnd6CMCO1KZAKZDY8stiOHE8xuV4vyDgYsRDKVREYfId6JVIm9EkouTSqc4GMVA4CWss0znevOG+dltmy40UeTiU6eUGPcrrwBwesIrnUwCtoA0ATAg=
Received: from DM5PR16CA0042.namprd16.prod.outlook.com (2603:10b6:4:15::28) by
 BYAPR12MB3223.namprd12.prod.outlook.com (2603:10b6:a03:138::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:23:27 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::32) by DM5PR16CA0042.outlook.office365.com
 (2603:10b6:4:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:26 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:26 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/33] drm/amd/display: Add tracepoint for amdgpu_dm
Date: Wed, 21 Oct 2020 10:22:51 -0400
Message-ID: <20201021142257.190969-28-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ede7cc3-1870-48eb-2f9e-08d875cce06a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3223:
X-Microsoft-Antispam-PRVS: <BYAPR12MB32234C335DB941C9E49E76CB8B1C0@BYAPR12MB3223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNdGHtZ5hypQNq6GQjKncd4ErbgwnVuL9N4ADFGBFUyyg0LogZdpdEciWJ1yFh0sePN4ZB9028RtNhm3u4XV95eF1nux99/vP9ijm+mW+tMBNji8Ap35eEs1382nGNcKEk9cVS88cieSsMY8UDuYeonPKTCRz2ILAF3wINdFw91ZA5ho3+LtXrelFf4WSscTvPOyaDiJWPc8+DKPoAHn9tOUXrAAO/5PRY2PYO5+mE1LcDRA6xCS0mKGK0OsCUVF+xDitGqPssYNKU3eZPZAhdRpz99netx/9s9u8vXxTCjzgxqEVYoaKW3t73fC9eiaJQcYslNdTXsqbxxwH0cemfUdJawNhfLfJUIYydvF5hc17y27/uAt1KrJXg3Aondbc414U3E5SuEvjY3rMy1Xkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966005)(54906003)(44832011)(186003)(316002)(2616005)(336012)(83380400001)(81166007)(1076003)(70586007)(36756003)(30864003)(5660300002)(70206006)(6666004)(8936002)(82740400003)(6916009)(82310400003)(8676002)(47076004)(2906002)(478600001)(426003)(86362001)(4326008)(7696005)(356005)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:27.0759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ede7cc3-1870-48eb-2f9e-08d875cce06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3223
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Debug amdgpu_dm could be a complicated task, therefore, this commit adds
tracepoints in some convenient functions such as plane and connector
check inside amdgpu_dm.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 287 ++++++++++++++++++
 2 files changed, 304 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1a9aa4d3d7ae..9728d03a8cb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5548,6 +5548,8 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 	struct drm_crtc_state *new_crtc_state;
 	int ret;
 
+	trace_amdgpu_dm_connector_atomic_check(new_con_state);
+
 	if (!crtc)
 		return 0;
 
@@ -5653,6 +5655,8 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(state);
 	int ret = -EINVAL;
 
+	trace_amdgpu_dm_crtc_atomic_check(state);
+
 	dm_update_crtc_active_planes(crtc, state);
 
 	if (unlikely(!dm_crtc_state->stream &&
@@ -6028,6 +6032,8 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
 	struct drm_crtc_state *new_crtc_state;
 	int ret;
 
+	trace_amdgpu_dm_plane_atomic_check(state);
+
 	dm_plane_state = to_dm_plane_state(state);
 
 	if (!dm_plane_state->dc_state)
@@ -6068,6 +6074,8 @@ static void dm_plane_atomic_async_update(struct drm_plane *plane,
 	struct drm_plane_state *old_state =
 		drm_atomic_get_old_plane_state(new_state->state, plane);
 
+	trace_amdgpu_dm_atomic_update_cursor(new_state);
+
 	swap(plane->state->fb, new_state->fb);
 
 	plane->state->src_x = new_state->src_x;
@@ -7635,6 +7643,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	int crtc_disable_count = 0;
 	bool mode_set_reset_required = false;
 
+	trace_amdgpu_dm_atomic_commit_tail_begin(state);
+
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
 	dm_state = dm_atomic_get_new_state(state);
@@ -8721,6 +8731,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	int ret, i;
 	bool lock_and_validation_needed = false;
 
+	trace_amdgpu_dm_atomic_check_begin(state);
+
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret)
 		goto fail;
@@ -9017,6 +9029,9 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	/* Must be success */
 	WARN_ON(ret);
+
+	trace_amdgpu_dm_atomic_check_finish(state, ret);
+
 	return ret;
 
 fail:
@@ -9027,6 +9042,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	else
 		DRM_DEBUG_DRIVER("Atomic check failed with err: %d \n", ret);
 
+	trace_amdgpu_dm_atomic_check_finish(state, ret);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 11941c69c420..6f07c43ef794 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -30,6 +30,12 @@
 #define _AMDGPU_DM_TRACE_H_
 
 #include <linux/tracepoint.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_atomic.h>
 
 DECLARE_EVENT_CLASS(amdgpu_dc_reg_template,
 		    TP_PROTO(unsigned long *count, uint32_t reg, uint32_t value),
@@ -89,6 +95,287 @@ TRACE_EVENT(amdgpu_dc_performance,
 			(unsigned long)__entry->write_delta,
 			(unsigned long)__entry->writes)
 );
+
+TRACE_EVENT(amdgpu_dm_connector_atomic_check,
+	    TP_PROTO(const struct drm_connector_state *state),
+	    TP_ARGS(state),
+
+	    TP_STRUCT__entry(
+			     __field(uint32_t, conn_id)
+			     __field(const struct drm_connector_state *, conn_state)
+			     __field(const struct drm_atomic_state *, state)
+			     __field(const struct drm_crtc_commit *, commit)
+			     __field(uint32_t, crtc_id)
+			     __field(uint32_t, best_encoder_id)
+			     __field(enum drm_link_status, link_status)
+			     __field(bool, self_refresh_aware)
+			     __field(enum hdmi_picture_aspect, picture_aspect_ratio)
+			     __field(unsigned int, content_type)
+			     __field(unsigned int, hdcp_content_type)
+			     __field(unsigned int, content_protection)
+			     __field(unsigned int, scaling_mode)
+			     __field(u32, colorspace)
+			     __field(u8, max_requested_bpc)
+			     __field(u8, max_bpc)
+	    ),
+
+	    TP_fast_assign(
+			   __entry->conn_id = state->connector->base.id;
+			   __entry->conn_state = state;
+			   __entry->state = state->state;
+			   __entry->commit = state->commit;
+			   __entry->crtc_id = state->crtc ? state->crtc->base.id : 0;
+			   __entry->best_encoder_id = state->best_encoder ?
+						      state->best_encoder->base.id : 0;
+			   __entry->link_status = state->link_status;
+			   __entry->self_refresh_aware = state->self_refresh_aware;
+			   __entry->picture_aspect_ratio = state->picture_aspect_ratio;
+			   __entry->content_type = state->content_type;
+			   __entry->hdcp_content_type = state->hdcp_content_type;
+			   __entry->content_protection = state->content_protection;
+			   __entry->scaling_mode = state->scaling_mode;
+			   __entry->colorspace = state->colorspace;
+			   __entry->max_requested_bpc = state->max_requested_bpc;
+			   __entry->max_bpc = state->max_bpc;
+	    ),
+
+	    TP_printk("conn_id=%u conn_state=%p state=%p commit=%p crtc_id=%u "
+		      "best_encoder_id=%u link_status=%d self_refresh_aware=%d "
+		      "picture_aspect_ratio=%d content_type=%u "
+		      "hdcp_content_type=%u content_protection=%u scaling_mode=%u "
+		      "colorspace=%u max_requested_bpc=%u max_bpc=%u",
+		      __entry->conn_id, __entry->conn_state, __entry->state,
+		      __entry->commit, __entry->crtc_id, __entry->best_encoder_id,
+		      __entry->link_status, __entry->self_refresh_aware,
+		      __entry->picture_aspect_ratio, __entry->content_type,
+		      __entry->hdcp_content_type, __entry->content_protection,
+		      __entry->scaling_mode, __entry->colorspace,
+		      __entry->max_requested_bpc, __entry->max_bpc)
+);
+
+TRACE_EVENT(amdgpu_dm_crtc_atomic_check,
+	    TP_PROTO(const struct drm_crtc_state *state),
+	    TP_ARGS(state),
+
+	    TP_STRUCT__entry(
+			     __field(const struct drm_atomic_state *, state)
+			     __field(const struct drm_crtc_state *, crtc_state)
+			     __field(const struct drm_crtc_commit *, commit)
+			     __field(uint32_t, crtc_id)
+			     __field(bool, enable)
+			     __field(bool, active)
+			     __field(bool, planes_changed)
+			     __field(bool, mode_changed)
+			     __field(bool, active_changed)
+			     __field(bool, connectors_changed)
+			     __field(bool, zpos_changed)
+			     __field(bool, color_mgmt_changed)
+			     __field(bool, no_vblank)
+			     __field(bool, async_flip)
+			     __field(bool, vrr_enabled)
+			     __field(bool, self_refresh_active)
+			     __field(u32, plane_mask)
+			     __field(u32, connector_mask)
+			     __field(u32, encoder_mask)
+	    ),
+
+	    TP_fast_assign(
+			   __entry->state = state->state;
+			   __entry->crtc_state = state;
+			   __entry->crtc_id = state->crtc->base.id;
+			   __entry->commit = state->commit;
+			   __entry->enable = state->enable;
+			   __entry->active = state->active;
+			   __entry->planes_changed = state->planes_changed;
+			   __entry->mode_changed = state->mode_changed;
+			   __entry->active_changed = state->active_changed;
+			   __entry->connectors_changed = state->connectors_changed;
+			   __entry->zpos_changed = state->zpos_changed;
+			   __entry->color_mgmt_changed = state->color_mgmt_changed;
+			   __entry->no_vblank = state->no_vblank;
+			   __entry->async_flip = state->async_flip;
+			   __entry->vrr_enabled = state->vrr_enabled;
+			   __entry->self_refresh_active = state->self_refresh_active;
+			   __entry->plane_mask = state->plane_mask;
+			   __entry->connector_mask = state->connector_mask;
+			   __entry->encoder_mask = state->encoder_mask;
+	    ),
+
+	    TP_printk("crtc_id=%u crtc_state=%p state=%p commit=%p changed("
+		      "planes=%d mode=%d active=%d conn=%d zpos=%d color_mgmt=%d) "
+		      "state(enable=%d active=%d async_flip=%d vrr_enabled=%d "
+		      "self_refresh_active=%d no_vblank=%d) mask(plane=%x conn=%x "
+		      "enc=%x)",
+		      __entry->crtc_id, __entry->crtc_state, __entry->state,
+		      __entry->commit, __entry->planes_changed,
+		      __entry->mode_changed, __entry->active_changed,
+		      __entry->connectors_changed, __entry->zpos_changed,
+		      __entry->color_mgmt_changed, __entry->enable, __entry->active,
+		      __entry->async_flip, __entry->vrr_enabled,
+		      __entry->self_refresh_active, __entry->no_vblank,
+		      __entry->plane_mask, __entry->connector_mask,
+		      __entry->encoder_mask)
+);
+
+DECLARE_EVENT_CLASS(amdgpu_dm_plane_state_template,
+	    TP_PROTO(const struct drm_plane_state *state),
+	    TP_ARGS(state),
+	    TP_STRUCT__entry(
+			     __field(uint32_t, plane_id)
+			     __field(enum drm_plane_type, plane_type)
+			     __field(const struct drm_plane_state *, plane_state)
+			     __field(const struct drm_atomic_state *, state)
+			     __field(uint32_t, crtc_id)
+			     __field(uint32_t, fb_id)
+			     __field(uint32_t, fb_format)
+			     __field(uint8_t, fb_planes)
+			     __field(uint64_t, fb_modifier)
+			     __field(const struct dma_fence *, fence)
+			     __field(int32_t, crtc_x)
+			     __field(int32_t, crtc_y)
+			     __field(uint32_t, crtc_w)
+			     __field(uint32_t, crtc_h)
+			     __field(uint32_t, src_x)
+			     __field(uint32_t, src_y)
+			     __field(uint32_t, src_w)
+			     __field(uint32_t, src_h)
+			     __field(u32, alpha)
+			     __field(uint32_t, pixel_blend_mode)
+			     __field(unsigned int, rotation)
+			     __field(unsigned int, zpos)
+			     __field(unsigned int, normalized_zpos)
+			     __field(enum drm_color_encoding, color_encoding)
+			     __field(enum drm_color_range, color_range)
+			     __field(bool, visible)
+	    ),
+
+	    TP_fast_assign(
+			   __entry->plane_id = state->plane->base.id;
+			   __entry->plane_type = state->plane->type;
+			   __entry->plane_state = state;
+			   __entry->state = state->state;
+			   __entry->crtc_id = state->crtc ? state->crtc->base.id : 0;
+			   __entry->fb_id = state->fb ? state->fb->base.id : 0;
+			   __entry->fb_format = state->fb ? state->fb->format->format : 0;
+			   __entry->fb_planes = state->fb ? state->fb->format->num_planes : 0;
+			   __entry->fb_modifier = state->fb ? state->fb->modifier : 0;
+			   __entry->fence = state->fence;
+			   __entry->crtc_x = state->crtc_x;
+			   __entry->crtc_y = state->crtc_y;
+			   __entry->crtc_w = state->crtc_w;
+			   __entry->crtc_h = state->crtc_h;
+			   __entry->src_x = state->src_x >> 16;
+			   __entry->src_y = state->src_y >> 16;
+			   __entry->src_w = state->src_w >> 16;
+			   __entry->src_h = state->src_h >> 16;
+			   __entry->alpha = state->alpha;
+			   __entry->pixel_blend_mode = state->pixel_blend_mode;
+			   __entry->rotation = state->rotation;
+			   __entry->zpos = state->zpos;
+			   __entry->normalized_zpos = state->normalized_zpos;
+			   __entry->color_encoding = state->color_encoding;
+			   __entry->color_range = state->color_range;
+			   __entry->visible = state->visible;
+	    ),
+
+	    TP_printk("plane_id=%u plane_type=%d plane_state=%p state=%p "
+		      "crtc_id=%u fb(id=%u fmt=%c%c%c%c planes=%u mod=%llu) "
+		      "fence=%p crtc_x=%d crtc_y=%d crtc_w=%u crtc_h=%u "
+		      "src_x=%u src_y=%u src_w=%u src_h=%u alpha=%u "
+		      "pixel_blend_mode=%u rotation=%u zpos=%u "
+		      "normalized_zpos=%u color_encoding=%d color_range=%d "
+		      "visible=%d",
+		      __entry->plane_id, __entry->plane_type, __entry->plane_state,
+		      __entry->state, __entry->crtc_id, __entry->fb_id,
+		      (__entry->fb_format & 0xff) ? (__entry->fb_format & 0xff) : 'N',
+		      ((__entry->fb_format >> 8) & 0xff) ? ((__entry->fb_format >> 8) & 0xff) : 'O',
+		      ((__entry->fb_format >> 16) & 0xff) ? ((__entry->fb_format >> 16) & 0xff) : 'N',
+		      ((__entry->fb_format >> 24) & 0x7f) ? ((__entry->fb_format >> 24) & 0x7f) : 'E',
+		      __entry->fb_planes,
+		      __entry->fb_modifier, __entry->fence, __entry->crtc_x,
+		      __entry->crtc_y, __entry->crtc_w, __entry->crtc_h,
+		      __entry->src_x, __entry->src_y, __entry->src_w, __entry->src_h,
+		      __entry->alpha, __entry->pixel_blend_mode, __entry->rotation,
+		      __entry->zpos, __entry->normalized_zpos,
+		      __entry->color_encoding, __entry->color_range,
+		      __entry->visible)
+);
+
+DEFINE_EVENT(amdgpu_dm_plane_state_template, amdgpu_dm_plane_atomic_check,
+	     TP_PROTO(const struct drm_plane_state *state),
+	     TP_ARGS(state));
+
+DEFINE_EVENT(amdgpu_dm_plane_state_template, amdgpu_dm_atomic_update_cursor,
+	     TP_PROTO(const struct drm_plane_state *state),
+	     TP_ARGS(state));
+
+TRACE_EVENT(amdgpu_dm_atomic_state_template,
+	    TP_PROTO(const struct drm_atomic_state *state),
+	    TP_ARGS(state),
+
+	    TP_STRUCT__entry(
+			     __field(const struct drm_atomic_state *, state)
+			     __field(bool, allow_modeset)
+			     __field(bool, legacy_cursor_update)
+			     __field(bool, async_update)
+			     __field(bool, duplicated)
+			     __field(int, num_connector)
+			     __field(int, num_private_objs)
+	    ),
+
+	    TP_fast_assign(
+			   __entry->state = state;
+			   __entry->allow_modeset = state->allow_modeset;
+			   __entry->legacy_cursor_update = state->legacy_cursor_update;
+			   __entry->async_update = state->async_update;
+			   __entry->duplicated = state->duplicated;
+			   __entry->num_connector = state->num_connector;
+			   __entry->num_private_objs = state->num_private_objs;
+	    ),
+
+	    TP_printk("state=%p allow_modeset=%d legacy_cursor_update=%d "
+		      "async_update=%d duplicated=%d num_connector=%d "
+		      "num_private_objs=%d",
+		      __entry->state, __entry->allow_modeset, __entry->legacy_cursor_update,
+		      __entry->async_update, __entry->duplicated, __entry->num_connector,
+		      __entry->num_private_objs)
+);
+
+DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_commit_tail_begin,
+	     TP_PROTO(const struct drm_atomic_state *state),
+	     TP_ARGS(state));
+
+DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_commit_tail_finish,
+	     TP_PROTO(const struct drm_atomic_state *state),
+	     TP_ARGS(state));
+
+DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_check_begin,
+	     TP_PROTO(const struct drm_atomic_state *state),
+	     TP_ARGS(state));
+
+TRACE_EVENT(amdgpu_dm_atomic_check_finish,
+	    TP_PROTO(const struct drm_atomic_state *state, int res),
+	    TP_ARGS(state, res),
+
+	    TP_STRUCT__entry(
+			     __field(const struct drm_atomic_state *, state)
+			     __field(int, res)
+			     __field(bool, async_update)
+			     __field(bool, allow_modeset)
+	    ),
+
+	    TP_fast_assign(
+			   __entry->state = state;
+			   __entry->res = res;
+			   __entry->async_update = state->async_update;
+			   __entry->allow_modeset = state->allow_modeset;
+	    ),
+
+	    TP_printk("state=%p res=%d async_update=%d allow_modeset=%d",
+		      __entry->state, __entry->res,
+		      __entry->async_update, __entry->allow_modeset)
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
