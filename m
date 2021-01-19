Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB17CC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F64B23107
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F64B23107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E2E6E10D;
	Tue, 19 Jan 2021 20:39:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482026E10D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 20:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU1CXyXu44k6xWmNR9Y/9a33ZT1kpKhrD/pcfeh5XDvkb/YZgjjpTOqgUicqt8E01W5ywFkjGbWvNF0EnOJHi3kPd36wxc6I9JZPfE9EYX+wSxvf5MsA18bqBLrgfJfSWjm7sILblaZzuQthu4Ja5Z/PNSillAEPcSlgCzgVnO7nDDy0PANe+2ICiUPSfb8sCQvV3C9nSpGFrzWqYQd+MfaK5UMyAkcrCV9AsR4zTCxwYy+aqu3mWgsPEZIGri2C1mI1I2MNLc/8t6x2KA9TK1DK6r8IyCypGm3SIVojplIHMMp5ngkuXdlnIGng4iUh5/hTNZOuK23Vpso2jHNeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHIDVrh7roE5fvBrj9kSR90O1vCFKHojMHQCyzTae20=;
 b=aTcibgsNSSVW3qywqBU/uW7ybuq2yW1S3vQAx455ONs06/KlPFkL+sDVXOmeGafCxZtU28wBybBWynex4UHGjP9fOZOdRVF9E6C1Vet5RYDeJcNQSIopSsVFcyNY0IsjTYDtQduF/Ks9rwkqZc2/nKJUauc0fUkgUtzRnT42PjZ0fmnJS8Z0Z6BfJ+mB8kTPr/HB8ZFAPlQI/naF6iee6mspGEPUhgJslpMZrSMQHfIDYNdj/cWBZykcBu+ijX/ZDAl0X4m65/p9cACL3PDf5fq+NCE5b0m7u4InfCS6sTvtTKq4nM5bBg2gkM3dpd3ZOBvQLapWHcQokeNrP3XG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHIDVrh7roE5fvBrj9kSR90O1vCFKHojMHQCyzTae20=;
 b=Sab6qpi7eA/AaeQnH4488fncjzpnw1DFbRfKMJi/kb98U4979tMai0o10eQSf+NUpYU8ASn77FEUL6ajfWmuQq2DCVUNpByl45mkL37VheA55aT0BVjS8fvDaFWtXBsEfStfWGl8c/jw/Sz4A6EuDdMpGsYyCKY3hwc34YHS1GA=
Received: from BN8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:ac::34)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 20:39:48 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::87) by BN8PR07CA0021.outlook.office365.com
 (2603:10b6:408:ac::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Tue, 19 Jan 2021 20:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Tue, 19 Jan 2021 20:39:46 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 14:39:41 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 19 Jan 2021 14:39:40 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amd/display: Dynamic cursor cache size for MALL
 eligibility check
Date: Tue, 19 Jan 2021 15:38:09 -0500
Message-ID: <20210119203810.2667860-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
References: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1452133-1888-48f1-9b0c-08d8bcba5bf8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3817A2B7EB8973F57E570569F9A30@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGDrgloRsamCwieRVlE0ne5bVZG31Qb9Nu0haqSSYzHsJeA0ESBViNL/za85jueUxnURF7NtpqzjYAqfpnpIbBGOaEupPD6VyNW5LO9BRUL+eQpVUncuPgtzTfXU3CMhosAx6fa+BCUhAjmepciB/UL6g3S1Y8qWvEYQKyxUJUyuSEuCydH7dI2aKH+crsIsrNYP4+xXgKCmRPg8r0rws1AKjRVbNT8RfkmOPGfXb6Mom9Ud6EEm/Ots2MikD9F/ilTLEDt362I7CLgH3bsABZZWrJFiVJt8E9qulxS+fqb4z0YkVFIfgRpsCTsvXqQE6YsJUA4fb6rqTgg/CCRqJtOd9hj4E9K8G5tw+1Mm+PKGMnd2Vyh9ncWcyTp8lHVV+kgnjjV8263z0EhX6bslgdMJf2m+tbtEsoT2VQybe/62Ud2b2QhOWz36XSAzobTP75W1b2qjGMginX4o/hxFkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(136003)(346002)(396003)(46966006)(70586007)(47076005)(336012)(70206006)(8936002)(8676002)(186003)(83380400001)(5660300002)(426003)(4326008)(82310400003)(82740400003)(316002)(6636002)(54906003)(81166007)(478600001)(110136005)(36756003)(86362001)(2906002)(1076003)(6666004)(356005)(2616005)(26005)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 20:39:46.5453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1452133-1888-48f1-9b0c-08d8bcba5bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Aric
 Cyr <aric.cyr@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently we use the maximum possible cursor cache size when deciding if we
should attempt to enable MALL, but this prevents us from enabling the
feature for certain key use cases.

[How]
 - consider cursor bpp when calculating if the cursor fits

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 ++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 25 +++++++++++++++++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  3 ++-
 .../amd/display/dc/dcn302/dcn302_resource.c   |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  3 ++-
 6 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 89e8e3e11862..1efc67befad4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3156,11 +3156,11 @@ void dc_lock_memory_clock_frequency(struct dc *dc)
 			core_link_enable_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]);
 }
 
-bool dc_is_plane_eligible_for_idle_optimizaitons(struct dc *dc, struct dc_plane_state *plane)
+bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
+		struct dc_cursor_attributes *cursor_attr)
 {
-	if (dc->hwss.does_plane_fit_in_mall && dc->hwss.does_plane_fit_in_mall(dc, plane))
+	if (dc->hwss.does_plane_fit_in_mall && dc->hwss.does_plane_fit_in_mall(dc, plane, cursor_attr))
 		return true;
-
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 28e0b6ac1f50..e21d4602e427 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1272,8 +1272,8 @@ enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32
 void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_config *clock_cfg);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 
-bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc,
-						 struct dc_plane_state *plane);
+bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
+				struct dc_cursor_attributes *cursor_attr);
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index e5cc8f8c363f..5c546b06f551 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -814,17 +814,38 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	return true;
 }
 
-bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane)
+bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane, struct dc_cursor_attributes *cursor_attr)
 {
 	// add meta size?
 	unsigned int surface_size = plane->plane_size.surface_pitch * plane->plane_size.surface_size.height *
 			(plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4);
 	unsigned int mall_size = dc->caps.mall_size_total;
+	unsigned int cursor_size = 0;
 
 	if (dc->debug.mall_size_override)
 		mall_size = 1024 * 1024 * dc->debug.mall_size_override;
 
-	return (surface_size + dc->caps.cursor_cache_size) < mall_size;
+	if (cursor_attr) {
+		cursor_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size;
+
+		switch (cursor_attr->color_format) {
+		case CURSOR_MODE_MONO:
+			cursor_size /= 2;
+			break;
+		case CURSOR_MODE_COLOR_1BIT_AND:
+		case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+		case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+			cursor_size *= 4;
+			break;
+
+		case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+		case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+			cursor_size *= 8;
+			break;
+		}
+	}
+
+	return (surface_size + cursor_size) < mall_size;
 }
 
 void dcn30_hardware_release(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 1103f6356e90..3b7d4812e311 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -65,7 +65,8 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx);
 void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx);
 
-bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane);
+bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane,
+		struct dc_cursor_attributes *cursor_attr);
 
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 22ba0be88faf..b96b32a37178 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1317,6 +1317,7 @@ static bool dcn302_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 
+	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 48378beb71c0..0586ab2ffd6a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -218,7 +218,8 @@ struct hw_sequencer_funcs {
 	/* Idle Optimization Related */
 	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
 
-	bool (*does_plane_fit_in_mall)(struct dc *dc, struct dc_plane_state *plane);
+	bool (*does_plane_fit_in_mall)(struct dc *dc, struct dc_plane_state *plane,
+			struct dc_cursor_attributes *cursor_attr);
 
 	bool (*is_abm_supported)(struct dc *dc,
 			struct dc_state *context, struct dc_stream_state *stream);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
