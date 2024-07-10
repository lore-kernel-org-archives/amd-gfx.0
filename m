Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D108C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64F710E8AB;
	Wed, 10 Jul 2024 19:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="07DubY3D";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C456510E8AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG4eX+Jkkk2wlOMEjcLvQSq8ssi8KhQbXUrLkMAhBEfGKxgaUS/fGpWNAt+e2yiNAvtwNqvL9yNBSBlKiEpg5bxRhp4aOuc1XF2raXzA5vtpsOK9z+g5muLa8wK8ounCJipaXIc0PC9A0RNhGyAEZP+KbJ6Tny1HQnsV+tcon3ixdrK7cjbAoWPMqTmMiiiiOmvT+v5tpILsLxLDqjYQQreIN8z58zylaExALQeLmv790V2HAetyLxy1eJs6XBac9zw2JraHJNdmBXmfjww7OhpXmD8Te3mVeRvXs9/fC2xEeF9+CeLUoYMX1qnaXOc54aUsjQwWL4NPihvABOoW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0Vro/vC3hJlufi5zjr51xK3zlvfyXtHPjm1gttspjA=;
 b=PFNB0qxZc98c9mgXrbkwSMzOYMWah4DN2psv8Nz/DMZ1p6Zxl6EnhD8CpwXacEI0lfLZnv90GXxDYlmEQLu+kUOpj7nj1yEHgJtWrrsJT8vm3bpjUPyZ8i0iffzTh/Usdo+Q6jWIdMKjo8lhaBoaWgrmUe4eGQjBvuwWqV15LoqA4tVv5g1SzLRE6nr4cDP79cJVjBP41nZWnW/G0IeQKxZQmbaYGNadA3c7tjxN1BXkzTTcG/xEvf8UFTrv0gw3hFGIuFdontRXjhsd3Ug3+kiJqr56LygjJCeBlOMl6dETUKxOTv6fYZVWIqnxI3eljm8K47zrKpMp1D1jjqAmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0Vro/vC3hJlufi5zjr51xK3zlvfyXtHPjm1gttspjA=;
 b=07DubY3DI5CdzN72UT9spFH70Hph7Jc4o1hOQpRYlzMAQEboR31rZcfYUcSygKotKgnUes20Fan4BcFxlQoPpGC0oJPjFeOK6iREn6a4HzDzy7YQtqA7YcLjsgWueh3a4pHqmiXsHoQFVCNac2hMo30D/m6Y4t/Bt6RJttYJjL0=
Received: from BLAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:32b::30)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 19:38:14 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::16) by BLAPR03CA0025.outlook.office365.com
 (2603:10b6:208:32b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:12 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:11 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 14/50] drm/amd/display: Disable subvp based on HW cursor
 requirement
Date: Wed, 10 Jul 2024 15:36:31 -0400
Message-ID: <20240710193707.43754-15-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e048e12-71c9-4a9a-3fa7-08dca117d6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yNNpBsYh050oEMqtVlk2TlcARE9Ml866qXbtycjlYZZtJ+H+tJlegW6XDvaj?=
 =?us-ascii?Q?MNYs03kVB/SwzARpNjhfCj3/1IFDjpA9y5iKuA2UyPCTgt9f/EE2N6jsn2dm?=
 =?us-ascii?Q?CrlCmbJwJnQbBWsAJWwDJdjzprkAQUkuOHI+bfIGJwD6MH/J+alt6O8qje/0?=
 =?us-ascii?Q?yutWIaGYlyJI2014JZYoyWbbVhNm3ftFq6Y96wX6pk/kjRkjQ1UQp+UPdMlM?=
 =?us-ascii?Q?1KaxjMNbweW+EDptwjQkwaN0ZnOM6DCHfdClFihuAJGVptl7WB7Ij3Pdbat1?=
 =?us-ascii?Q?Gm9swDmyu4DxJzNZDAeu8X1Vm1CymLe0AZGGKe193mGLERMZmK/77iuCpij0?=
 =?us-ascii?Q?BeWKVQWXeIUoqhRtqLOqKJkqEfPtpaBKcGiHbR7mPLGVPsTzWVQZiT4V4yRe?=
 =?us-ascii?Q?UFrsxgHkD+5RorFUL9wBRM4diav3Xp55OR0Cnpj/+rqz8sFA30fudAjkqfuO?=
 =?us-ascii?Q?KhWEjatqo7x1/l2f1NGSeLlihIBavv6fviehve11pb2D2WIX3Okk8qTP7y7l?=
 =?us-ascii?Q?eFZGn3/02jahlolLWnh/ZyjstNfQ4uzsU/U6f0+3W/FPPe2B+OJG/bSFeEej?=
 =?us-ascii?Q?AetBCy2XQtoxxi9RF/+PD7h1d5LfKM0K+yFlzJaJ19VkIC1jm23rcUWDuD79?=
 =?us-ascii?Q?HXiLoPWYpvyECTxHdQolhY1av83sWelj6bvUvLUMoSRk8rV4/a5b6B++fxot?=
 =?us-ascii?Q?0HO/H8QoKwlPxZwXQvpNRD57V3sTdoxXZOcKVGscqVffAx1rH4NyArMHmmkF?=
 =?us-ascii?Q?twLIvxfbscNRj5c5Fv5f85RmpZo2cpP3mSd4itdegdJAGknz9iZwJ76IRKmM?=
 =?us-ascii?Q?ys+L8pvCoIMuOElcqu8Rtfo7h4+Ci5UFUnVTDt+IZQiOtlu21O7neU526lo2?=
 =?us-ascii?Q?q5555RrkVZb5Mt1lsKn1NanRt0YbClU8I8tWsYZWGeU5aLk4LisKFEzZfa91?=
 =?us-ascii?Q?HQPbFmcKmcpZEqSZ13FgbBeJvDmS5tFnqn18MhRzNQ+9/m0/ZdQDwSPb54Oc?=
 =?us-ascii?Q?fQVGRb5MbqdiRCrQnRKH97mubxqoXpKQ2t9wrMK9QNv3vb9tcETRO7dEqg+7?=
 =?us-ascii?Q?ugQfWX+1ffUjloEC/BUOMQ8eY4sqT6TWaqagVoTfTlrRIABErp8gRBrRnKab?=
 =?us-ascii?Q?Sv/HLQ1Cw55xYHyQVOMZznwd4obg+T2I2K5g1VhRN4U1N1mP1sCH3jORVhOv?=
 =?us-ascii?Q?RmLz5NSkgaRSjqOK0l2VGEIK47N2XmEsbyLKfNflwjE0OVLzJWeyEK2nkIAw?=
 =?us-ascii?Q?p/geJb/XY8SNmNfKgsjOMkfLidWmYlO0lHr/Sdd791xNzZ9J/jVzogXFsfWz?=
 =?us-ascii?Q?SuWD9ET+MI2JWbrVoXvavg5CH2VC05P2ZQ10hP09XaeyTUTRUlZed9OxnjaU?=
 =?us-ascii?Q?iuB7zfZLTzHPXTiERqSpyekHqvPFK2FH+/CeQ8GFXi7HnnXTNJuDmA/J2KDZ?=
 =?us-ascii?Q?hiRZcMMfcgJZNSBrQ4HtdQI80DOMNU1P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:13.9772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e048e12-71c9-4a9a-3fa7-08dca117d6ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- There are situations where HW cursor is required
- In these scenarios we should disable subvp based on the HW cursor
  requirement

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                   | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h                 | 3 +++
 .../amd/display/dc/dml2/dml21/dml21_translation_helper.c   | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c35029c65223..9897e322e2d5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2717,6 +2717,10 @@ static enum surface_update_type check_update_surfaces_for_stream(
 		overall_type = UPDATE_TYPE_FULL;
 	}
 
+	if (stream_update && stream_update->hw_cursor_req) {
+		overall_type = UPDATE_TYPE_FULL;
+	}
+
 	/* some stream updates require passive update */
 	if (stream_update) {
 		union stream_update_flags *su_flags = &stream_update->stream->update_flags;
@@ -3012,6 +3016,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_infopacket)
 		stream->vrr_infopacket = *update->vrr_infopacket;
 
+	if (update->hw_cursor_req)
+		stream->hw_cursor_req = *update->hw_cursor_req;
+
 	if (update->allow_freesync)
 		stream->allow_freesync = *update->allow_freesync;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 3d9ee4da7056..de9bd72ca514 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -266,6 +266,8 @@ struct dc_stream_state {
 
 	struct dc_cursor_attributes cursor_attributes;
 	struct dc_cursor_position cursor_position;
+	bool hw_cursor_req;
+
 	uint32_t sdr_white_level; // for boosting (SDR) cursor in HDR mode
 
 	/* from stream struct */
@@ -350,6 +352,7 @@ struct dc_stream_update {
 
 	struct dc_cursor_attributes *cursor_attributes;
 	struct dc_cursor_position *cursor_position;
+	bool *hw_cursor_req;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 7c73efe19525..405544920f3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -516,7 +516,7 @@ static void populate_dml21_stream_overrides_from_stream_state(
 	if (!stream->ctx->dc->debug.enable_single_display_2to1_odm_policy ||
 			stream->debug.force_odm_combine_segments > 0)
 		stream_desc->overrides.disable_dynamic_odm = true;
-	stream_desc->overrides.disable_subvp = stream->ctx->dc->debug.force_disable_subvp;
+	stream_desc->overrides.disable_subvp = stream->ctx->dc->debug.force_disable_subvp || stream->hw_cursor_req;
 }
 
 static enum dml2_swizzle_mode gfx_addr3_to_dml2_swizzle_mode(enum swizzle_mode_addr3_values addr3_mode)
-- 
2.34.1

