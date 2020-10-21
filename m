Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C89AC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5D22224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f4ui4dp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5D22224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78DF6EDDC;
	Wed, 21 Oct 2020 14:23:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B356EDBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jypIDdNJDKWkLQu2O4B/YL1yAO63zoD2Y4TdLMvmt6jGvn9IWqAMNLAxKkLdq25XmlYlgVx88cVCJP34qdivq59iXovfvBfsKr3I3FZ1RyqJrUCPNSyDGJURkcRHkTa62J2WdrYhmZJ95KXW66tSD3FsLNO47PG2luVxydFZHSYNqbrCCkPzpI21RPVuoF6RTNJ4rGdEBzTeHFEkvNEBKIQALTL1icjcNHAEA4pHbklaCAoVatxk8KniGsbYzzk2iPQS6EFKx+GK352UuQ1SuJploEIIuVcQ98x01M+uqC4yyDUt+DUifdTKt7R6xQhBv7N2t4UmPrT8fXfDF93v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awqdYuhTv0jIQDhd0psF+cIMqKVIE118AV4mgpQcLig=;
 b=W9don3IDAC6U4lU/xOsHhHoXRpskPyBzvumV99Ake+F5HMeLazZOdlhXlZg/7Pkj3nA9aXk9jp7582pFF9HJFiIQrcgcjhjxOirr7wCzyYhUWj/iQH1IcHgHBN7ydXHtRtrOE/ZV0U/AbbMtTkwWxFa5lkEhkFMOU52Fj+QybxVobwGJGNxq3HJCXIFMEB3Sz5x0N/7REuwsVMxzSP9Zai5gw9do9BKmv7sYYe4QgTCFUq+rJjpduSsp6TRGFITD1gTyvkK8fKw3Z/QkLUhnEDyLGEWJGg2ChyYb0+wueGWnjbFjvtMFF/jL9KjiIeWWIW0vsOR7rrD9UtS3F94QHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awqdYuhTv0jIQDhd0psF+cIMqKVIE118AV4mgpQcLig=;
 b=f4ui4dp6sw2ZzqOFTwP/bGtEHFfSa3H4FgW8qFDSaZNgkixxd3DHoSFdCkL/auRsKXmZr7M/cYtSMQv7zU3X8LM/wrMJfW6d7QrD19sVcrDlTqQHO2ca5xIcl4k/gAlUbJ4vszre9N1y7swlpTNaLEsS31/pADQ28H3TRtPedZU=
Received: from BN4PR11CA0023.namprd11.prod.outlook.com (2603:10b6:403:1::33)
 by MN2PR12MB3247.namprd12.prod.outlook.com (2603:10b6:208:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 14:23:28 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:1:cafe::7e) by BN4PR11CA0023.outlook.office365.com
 (2603:10b6:403:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:27 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/33] drm/amd/display: Add tracepoint for capturing clocks
 state
Date: Wed, 21 Oct 2020 10:22:53 -0400
Message-ID: <20201021142257.190969-30-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 867b8e7e-7bf5-48a1-4634-08d875cce139
X-MS-TrafficTypeDiagnostic: MN2PR12MB3247:
X-Microsoft-Antispam-PRVS: <MN2PR12MB324722FE98D6A68208DA068B8B1C0@MN2PR12MB3247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XZ5lkQ6X2DAMgF7jEzK2aXRkRie8JfsnTU1kVhvKgy7aGRoVrOYCzgsAEfcw8rtvApMIrDUiA4v9NK6IUAtfxd7hKlMAnMCP9PtaY/HcJ0o41itKXoDQI7ABdBGSmryWBgiIv9OvrPAJeSTWy+Yhon+Nj9mKMfYq4qlLlYjBfeBoShaYDyuarV/HauzHo546u3VNomRjHxApoYSnkhpSCE2tzamnMpEHYQafHlGnUvuJ2KRFIUAS7tkEdQ8mobAzZc7E+0ph72193rCXipVaLy1meH184PMrCXPbJVqe2GVSRXWmT6MExX38dKwoXjR30jzZ8fPWT06S2qWiW/1YjrSNWfje8svPfJ6A/YRSqwjKjBtE+Otm/bCHP2v/QWlBznErikN+dQfQ0gEY61iuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(316002)(82740400003)(70206006)(47076004)(86362001)(478600001)(26005)(1076003)(6916009)(2906002)(44832011)(7696005)(36756003)(356005)(70586007)(8936002)(2616005)(4326008)(54906003)(8676002)(336012)(83380400001)(81166007)(426003)(186003)(82310400003)(5660300002)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:28.4890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867b8e7e-7bf5-48a1-4634-08d875cce139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3247
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

The clock state update is the source of many problems, and capturing
this sort of information helps debug. This commit introduces tracepoints
for capturing clock values and also add traces in DCE, DCN1, DCN2x, and
DCN3.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 113 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  13 +-
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |   6 +
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index dd7a879c0ec6..86960476823c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -484,6 +484,119 @@ TRACE_EVENT(amdgpu_dm_dc_pipe_state,
 	)
 );
 
+TRACE_EVENT(amdgpu_dm_dc_clocks_state,
+	    TP_PROTO(const struct dc_clocks *clk),
+	    TP_ARGS(clk),
+
+	    TP_STRUCT__entry(
+			     __field(int, dispclk_khz)
+			     __field(int, dppclk_khz)
+			     __field(int, disp_dpp_voltage_level_khz)
+			     __field(int, dcfclk_khz)
+			     __field(int, socclk_khz)
+			     __field(int, dcfclk_deep_sleep_khz)
+			     __field(int, fclk_khz)
+			     __field(int, phyclk_khz)
+			     __field(int, dramclk_khz)
+			     __field(int, p_state_change_support)
+			     __field(int, prev_p_state_change_support)
+			     __field(int, pwr_state)
+			     __field(int, dtm_level)
+			     __field(int, max_supported_dppclk_khz)
+			     __field(int, max_supported_dispclk_khz)
+			     __field(int, bw_dppclk_khz)
+			     __field(int, bw_dispclk_khz)
+	    ),
+	    TP_fast_assign(
+			   __entry->dispclk_khz = clk->dispclk_khz;
+			   __entry->dppclk_khz = clk->dppclk_khz;
+			   __entry->dcfclk_khz = clk->dcfclk_khz;
+			   __entry->socclk_khz = clk->socclk_khz;
+			   __entry->dcfclk_deep_sleep_khz = clk->dcfclk_deep_sleep_khz;
+			   __entry->fclk_khz = clk->fclk_khz;
+			   __entry->phyclk_khz = clk->phyclk_khz;
+			   __entry->dramclk_khz = clk->dramclk_khz;
+			   __entry->p_state_change_support = clk->p_state_change_support;
+			   __entry->prev_p_state_change_support = clk->prev_p_state_change_support;
+			   __entry->pwr_state = clk->pwr_state;
+			   __entry->prev_p_state_change_support = clk->prev_p_state_change_support;
+			   __entry->dtm_level = clk->dtm_level;
+			   __entry->max_supported_dppclk_khz = clk->max_supported_dppclk_khz;
+			   __entry->max_supported_dispclk_khz = clk->max_supported_dispclk_khz;
+			   __entry->bw_dppclk_khz = clk->bw_dppclk_khz;
+			   __entry->bw_dispclk_khz = clk->bw_dispclk_khz;
+	    ),
+	    TP_printk("dispclk_khz=%d dppclk_khz=%d disp_dpp_voltage_level_khz=%d dcfclk_khz=%d socclk_khz=%d "
+		      "dcfclk_deep_sleep_khz=%d fclk_khz=%d phyclk_khz=%d "
+		      "dramclk_khz=%d p_state_change_support=%d "
+		      "prev_p_state_change_support=%d pwr_state=%d prev_p_state_change_support=%d "
+		      "dtm_level=%d max_supported_dppclk_khz=%d max_supported_dispclk_khz=%d "
+		      "bw_dppclk_khz=%d bw_dispclk_khz=%d ",
+		      __entry->dispclk_khz,
+		      __entry->dppclk_khz,
+		      __entry->disp_dpp_voltage_level_khz,
+		      __entry->dcfclk_khz,
+		      __entry->socclk_khz,
+		      __entry->dcfclk_deep_sleep_khz,
+		      __entry->fclk_khz,
+		      __entry->phyclk_khz,
+		      __entry->dramclk_khz,
+		      __entry->p_state_change_support,
+		      __entry->prev_p_state_change_support,
+		      __entry->pwr_state,
+		      __entry->prev_p_state_change_support,
+		      __entry->dtm_level,
+		      __entry->max_supported_dppclk_khz,
+		      __entry->max_supported_dispclk_khz,
+		      __entry->bw_dppclk_khz,
+		      __entry->bw_dispclk_khz
+	    )
+);
+
+TRACE_EVENT(amdgpu_dm_dce_clocks_state,
+	    TP_PROTO(const struct dce_bw_output *clk),
+	    TP_ARGS(clk),
+
+	    TP_STRUCT__entry(
+			     __field(bool, cpuc_state_change_enable)
+			     __field(bool, cpup_state_change_enable)
+			     __field(bool, stutter_mode_enable)
+			     __field(bool, nbp_state_change_enable)
+			     __field(bool, all_displays_in_sync)
+			     __field(int, sclk_khz)
+			     __field(int, sclk_deep_sleep_khz)
+			     __field(int, yclk_khz)
+			     __field(int, dispclk_khz)
+			     __field(int, blackout_recovery_time_us)
+	    ),
+	    TP_fast_assign(
+			   __entry->cpuc_state_change_enable = clk->cpuc_state_change_enable;
+			   __entry->cpup_state_change_enable = clk->cpup_state_change_enable;
+			   __entry->stutter_mode_enable = clk->stutter_mode_enable;
+			   __entry->nbp_state_change_enable = clk->nbp_state_change_enable;
+			   __entry->all_displays_in_sync = clk->all_displays_in_sync;
+			   __entry->sclk_khz = clk->sclk_khz;
+			   __entry->sclk_deep_sleep_khz = clk->sclk_deep_sleep_khz;
+			   __entry->yclk_khz = clk->yclk_khz;
+			   __entry->dispclk_khz = clk->dispclk_khz;
+			   __entry->blackout_recovery_time_us = clk->blackout_recovery_time_us;
+	    ),
+	    TP_printk("cpuc_state_change_enable=%d cpup_state_change_enable=%d stutter_mode_enable=%d "
+		      "nbp_state_change_enable=%d all_displays_in_sync=%d sclk_khz=%d sclk_deep_sleep_khz=%d "
+		      "yclk_khz=%d dispclk_khz=%d blackout_recovery_time_us=%d",
+		      __entry->cpuc_state_change_enable,
+		      __entry->cpup_state_change_enable,
+		      __entry->stutter_mode_enable,
+		      __entry->nbp_state_change_enable,
+		      __entry->all_displays_in_sync,
+		      __entry->sclk_khz,
+		      __entry->sclk_deep_sleep_khz,
+		      __entry->yclk_khz,
+		      __entry->dispclk_khz,
+		      __entry->blackout_recovery_time_us
+	    )
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 764cae604203..36f9bba4a321 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1435,6 +1435,11 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.optimize_bandwidth(dc, context);
 	}
 
+	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
+		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
+	else
+		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
+
 	context->stream_mask = get_stream_mask(dc, context);
 
 	if (context->stream_mask != dc->current_state->stream_mask)
@@ -2737,9 +2742,15 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		}
 	}
 	/*let's use current_state to update watermark etc*/
-	if (update_type >= UPDATE_TYPE_FULL)
+	if (update_type >= UPDATE_TYPE_FULL) {
 		dc_post_update_surfaces_to_stream(dc);
 
+		if (dc_ctx->dce_version >= DCE_VERSION_MAX)
+			TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
+		else
+			TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
+	}
+
 	return;
 
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_trace.h b/drivers/gpu/drm/amd/display/dc/dc_trace.h
index 783256914596..d2615357269b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_trace.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_trace.h
@@ -31,3 +31,9 @@
 						      pipe_ctx->stream, &pipe_ctx->plane_res, \
 						      pipe_ctx->update_flags.raw); \
 	}
+
+#define TRACE_DCE_CLOCK_STATE(dce_clocks) \
+	trace_amdgpu_dm_dce_clocks_state(dce_clocks)
+
+#define TRACE_DCN_CLOCK_STATE(dcn_clocks) \
+	trace_amdgpu_dm_dc_clocks_state(dcn_clocks)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
