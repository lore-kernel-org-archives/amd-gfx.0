Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9817EC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D968810E9E1;
	Fri, 10 Mar 2023 09:33:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB8210E9D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzX0wjjJ0Axg3htUiKasEv8Bj+7HXLoOpOcmbCL8rUCFG3/i2z8gXxihvzTMTjO6bZeGwIpDwevZ4s4vi0JJn9EHb/GGC753sOqrl8KFZlOCFdmh5sCC8wJyp3yekCM4OsvcST9QWz1PpvVUvuHUlrqviCwyz/WIb9BeERNg3ar3JNSPWnMCsRb9F8rSxEjQgv4ICEdtV2defGcVj+7FqH/xM1rYfzHopfEM/2Q6GK5i0sD8DzN3UUNFVvsMdxoFZGVM+3dCEp005qCR5lYO6HlBrLZJmUj68Wf0emeBQ3Mpx0Boqe2VhDPDq58dpIYNES2UKhGpfCwzzKjxEZZNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9YBnAJQKOiAiOlbaiVHg9iuIH9rrEfSKE8jmWa3cao=;
 b=NbDUOPIldlWglr3spoWIBGhQQJsYFWyZPvtOYaHxjURTFXETfvS//TqjntgbioVGQtIOwjCg8IwBy+hmi1wLZUO958uSj8BJIF9d/rPE4CUDvP1A7niLEksKr4pp3wUnJy1JD/SVyY8evZRtLa+PCZVE1Evxmwiv+8gHLF87+aET73yOOl3yD0eT+zAozkJLg2i6x2EqHhkn1jIPqQhuGo8nIt0UK0G/yJvWnF1jiX+gO1aEfcH8aEfI+baevLwpYbmG0r/BhzQf3TLxBhJ4TTaQhyJgo9su81Wygncjz4HH3t/w+mLZpSm7sqOruNCggAsIwzbJR7A9Q1XnFo0g5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9YBnAJQKOiAiOlbaiVHg9iuIH9rrEfSKE8jmWa3cao=;
 b=z/oTTiifS+uCDgb8fAtf1sP/5OaiucP8zX34lK9qqjSPLkS7ta6GIA1jkjRjB1cGrBidc9Zb5VecQYOXqFHqvPDaVt4zQsW0P4sSa6tiQXV+2h+OMsLLJfGIDjK1WEIv8/QoYNeV+V0R3+ktnHHmLMrwdVEjf2ksvLWqZVvmvIY=
Received: from CY5PR19CA0132.namprd19.prod.outlook.com (2603:10b6:930:64::29)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:33:02 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::27) by CY5PR19CA0132.outlook.office365.com
 (2603:10b6:930:64::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:33:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:32:55 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: disconnect MPCC only on OTG change
Date: Fri, 10 Mar 2023 04:31:11 -0500
Message-ID: <20230310093117.3030-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a4fc6c-5140-40d4-275d-08db214a71bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnxto/LY20woso3yPVjf8IDlGGGjUVw+EBAlC0SKoBE15I79/sBl6I2lGpBf/HcNGt/m1iOPX0StxSQj1USnN/jtbc3563QxqyUH+6oh7bpRFSHDXfbawo/r/Fwa0Fla+6PxHhVA7LdH6YnvgFTDDkLB43faJZBVbzoC2cKVtlyCjVij/u1duviFsCqjMMkw7fpoJKXmoamEA39OT2NtBexBEkkk453aE8J+hYkXZ8EWnNEdH1W3/LpvcGhi+uYOFR/R7qsWkcPP6iNGPzNEQUZB7uF2mJM6PIR3aomlg3NgY9UrIvKV0ZDERl0t6FtRf9GMf6Vz6w1Zixfb2z6sfx9NcqQDxY5K2TJcZtM+0A+DzDb/Z9gsV4/osA7qfGgs1DdxcYXXLwmUJLkjUCuTFX7t/Q+vJsKT90ncoYOLqMH60mYOx2ibk6rMSEaqG2nx3U2x1BPhjVFW4hgaTIO+qe4IRctNKmf7+7i90ZuA7vmjCFMBbV+FCVQzwOffq/5asQOjg4a678No0AobukceYEt0mZpUDY8HeOK+jIA2e284ccT7p0M/WB+jl956ElAPKVi8fX6tIExMvbZNtApdSN0ixViIM5ITZmBUPEKufd+8H/Fo5B7mmiBVl4lCwKmVE65bE2sTuwKtOBfAHRgNMzOtvKt4Ji1x3xt4459zLeB8qWANRRtX0iXrm8P46ZTUtMIH+QYLETC74isEb3iAiyHMylFbbDLDgbMKn3e1oJs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(81166007)(82740400003)(83380400001)(5660300002)(36756003)(40460700003)(44832011)(70206006)(4326008)(40480700001)(70586007)(8936002)(41300700001)(356005)(316002)(6916009)(8676002)(54906003)(86362001)(36860700001)(478600001)(426003)(82310400005)(47076005)(2616005)(16526019)(1076003)(186003)(336012)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:33:02.1350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a4fc6c-5140-40d4-275d-08db214a71bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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
 stable@vger.kernel.org, Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 wayne.lin@amd.com, Ayush Gupta <ayugupta@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ayush Gupta <ayugupta@amd.com>

[Why]
Framedrops are observed while playing Vp9 and Av1 10 bit
video on 8k resolution using VSR while playback controls
are disappeared/appeared

[How]
Now ODM 2 to 1 is disabled for 5k or greater resolutions on VSR.

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ayush Gupta <ayugupta@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f6f72e7c9e86..633491331722 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1914,6 +1914,7 @@ int dcn32_populate_dml_pipes_from_context(
 	struct pipe_ctx *pipe;
 	bool subvp_in_use = false;
 	struct dc_crtc_timing *timing;
+	bool vsr_odm_support = false;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
@@ -1931,12 +1932,15 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		vsr_odm_support = (res_ctx->pipe_ctx[i].stream->src.width >= 5120 &&
+				res_ctx->pipe_ctx[i].stream->src.width > res_ctx->pipe_ctx[i].stream->dst.width);
 		if (context->stream_count == 1 &&
 				context->stream_status[0].plane_count == 1 &&
 				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
 				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
 				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
-				dc->debug.enable_single_display_2to1_odm_policy) {
+				dc->debug.enable_single_display_2to1_odm_policy &&
+				!vsr_odm_support) { //excluding 2to1 ODM combine on >= 5k vsr
 			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
 		}
 		pipe_cnt++;
-- 
2.34.1

