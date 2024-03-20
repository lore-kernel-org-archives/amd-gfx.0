Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348DAC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C179810EEED;
	Wed, 20 Mar 2024 06:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JnEwop96";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9D910EEED
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8q+ME5macbG6CXaqllUhzQLAMevIEmeinoIW5BzSgKk9rUiY/GygHh8Sd1MXNwc2b/QOY/iw/vK3vP6iP0OdTeIJOUGbBrIrtz3273s/lwWE8KRkSJdKUaegRT1ywtq4SonC9WpwD2iqyNWDqY2//8cOW14EO+UC/vrVsfOKmVMBRppwgA/jZ1cxWU9okZlZC2bmZu3y6B3zT+XbRzXjpVFf6diXq4DDYdE0Li5MTzluEQxiCJpO05Ovcs4ZIwv+dPOiwEo8zhzNXvQjK2jA6wjfdU5i8k4hKJu/wr8gWRbu0jwBRaYLWOvbzkWn/sqd4/njcUKr71QzJC099O2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBicRjia6mWMyQk2nvP5kvOwMhohAcrwEINj/DYuFe0=;
 b=VXwA8/ervRqB+7fLcDCdC4qWDZHeC0915AGw4J9VVv1+sFDi8XiybhbaL50zIKpbXmvVdEeu+FILsCyeOS+0KrjesX2U0j/YKNINBqVe2r7jL2vEsPymeTelDVLpi6cUAkvNlOumw9GO9/+BnPNN53M28LUdoFhUvst0S5K4ISpSiwF9oj2w/x5WHrigP8M3ubrG25MM5CefsciI/WrIVNTmOxeZbOvVTvJxHG1iicSJADKPGdm7iNwLoZTmWhrOV8klv52crS7ceIQSE8zVqSFCGvuRfZfotpwY3nyvUvYzdKYauQhr8AJxwZq3q0LFS8HZJr+QrNfw0rHJavdVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBicRjia6mWMyQk2nvP5kvOwMhohAcrwEINj/DYuFe0=;
 b=JnEwop96pm84EnEITMdGWBKiVia9JMwi3beQg4+fnsT34wCso2OLq3H8dTmu/t3Q4d4+Ctik6cKVVpjhg3/BqhQ4EqE78RfVJV0ggfsZ5HYwErFO2SGsw7bJHqqOgqkgIC3pxN7n7Rr7NV1dyh3EEmxy+e06twEgUcWvLm9xSLE=
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Wed, 20 Mar
 2024 06:37:33 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::b7) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 23:37:28 -0700
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Muhammad Ahmed
 <ahmed.ahmed@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 21/22] drm/amd/display: Skip pipe if the pipe idx not set
 properly
Date: Wed, 20 Mar 2024 14:35:55 +0800
Message-ID: <20240320063556.1326615-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: de9d719c-f0ea-46cb-60cd-08dc48a83978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUdMQQraKN7wENMkvQmcuwAd+3ZChkAHAwwcoW+qKe1tt0YL9zuE8QIp/BhTMYVrpvaQ1gggAiVrzHb/xreSMQbOI2ofUSGd72Bops8hLsZBIWH/RbC906HRhCcS1Wff7LxFC/lbqsdhN+NMBUwZaG87DoaAk9EK8AuIAa5vDDqn/IZu1ftcm4NN2s3ZQk4nbDrx+S4R1hH1WaYwtSHgB/RV30Hej+QH2hTEjm+76vKh0u5ryECjjL1aZ3w4gbIn77K58z4ZbOSVYOzHbSzWPoftWMJaLzIb0vOj54aQzQ2PSOpVSymu37B9v6dpRaS1n9FnVdLTaP0VV3yMZrdH5TQfPakJJXqPRgKfbiwj+SRVZbsrydg6wNybOYJs2MgjS/oSsywCw+XB/2DR6xJeV2GxdY6I4VLInFtvO0zOQgLsGT8jrDF+45Wh7UFcNWPxIcV9JRt9DQommnOWbaiqOWsz/yholMVDLTYBjuMKCwcjLVHfM7VBP/VnTxTtbXXnG1AWFQoINX1IhTPtC53DFHapmPbbHOA479qziA73s4iItfeFD1vKPNN/a2cQQWuwnGn6ZXq6p8JCKcu25A7kRGXzIiTlxpQ2pbIoojFEyt4JI29YAU4R0jqidPaSb0ovutcCS2gR++SA3TmVVup9jKnEBmGMB6ZESj//Jel83cubT3+Yw//rh+t/AuiDYhKUAK+NtLhyNuRkHMKWTcAL6x4pQ7QTS14gXoyrQAnksGxsQy4vaf0C7qtpGgfRoGz+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:33.5195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9d719c-f0ea-46cb-60cd-08dc48a83978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[why]
Driver crashes when pipe idx not set properly

[how]
Add code to skip the pipe that idx not set properly

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index ac2676bb9fcb..bedf1cd390df 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -327,6 +327,8 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id);
 		}
 
+		if (dml_pipe_idx == 0xFFFFFFFF)
+			continue;
 		ASSERT(in_ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[dml_pipe_idx]);
 		ASSERT(in_ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[dml_pipe_idx] == context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id);
 
@@ -474,6 +476,9 @@ bool dml2_verify_det_buffer_configuration(struct dml2_context *in_ctx, struct dc
 			dml_pipe_idx = find_dml_pipe_idx_by_plane_id(in_ctx, plane_id);
 		else
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, display_state->res_ctx.pipe_ctx[i].stream->stream_id);
+
+		if (dml_pipe_idx == 0xFFFFFFFF)
+			continue;
 		total_det_allocated += dml_get_det_buffer_size_kbytes(&in_ctx->v20.dml_core_ctx, dml_pipe_idx);
 		if (total_det_allocated > max_det_size) {
 			need_recalculation = true;
-- 
2.34.1

