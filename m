Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF0C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA62A20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JK6QFjoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA62A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350916ED22;
	Fri, 15 May 2020 18:13:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F696ED20
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIRJE41je1VEPbuuibuGO5r91JVJX8cXu/Zg9fe3KvuHRux+LKhef7Th73atUf75pnul9LTmY1cg6f9S8f50nmF1zkQsWuborJ//EhBzROIDzR4H3Qn50vBnrXUjQSfby4aqupjCPoy/g1+tQcPOMGc8XRKbMjQLbzgWTV57CmLw/e9DpvNqhDYt/yaG9Jjp2Y2aM1ClhEx7UaOYMS7QGeYcih6n+o2TS+DvYpU2sZfuC4UIuIiiHjv13lShNxWiWK3Rg0NSWB8pbKBO0iln0JNjn/KFXhgfIrrPgDlBt9PK6PUQvPOpmM0VLsYRnM+iicLdxf2JWQVH6rQ5qwcdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M0auT/sTo2TQrpi0HtRLlipx2otI82aRUVP/BZI8W4=;
 b=THbFh+Ti2pt4uDZ8wVMBHbJer4Caov9dm0lGfL9I38MaLDcPreXm9Ajf0X7AfLuAVCVEyW/Togrl3cKd6kjk8wdKruJEpYb5Prrwns5tMADTpahNr0Eze0b7H+5CVcofLYq7FeB81hWqDg7OSlRu1Ni5/43FGoS8r0Wlm+AF1bfmUtWoF9TSnwPfsRsNV+UZ19CYiqshxy7UYXHeKotzh08L9824pUqA3IEavPv1FygaQLvT31lTbwLpvQQh/3s9+TnJOu4Ymt1hfo0Bc6mtinpRtwSeDvhCspdORAg3ydrghxgWrvV6RmVatwriCA8As490+zArQWhKKzorQsgXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M0auT/sTo2TQrpi0HtRLlipx2otI82aRUVP/BZI8W4=;
 b=JK6QFjoZAsUT05OOl1VXZrA3sJhGzXll5FhuQ++63mv+tUJFolrl8gB+HxLgF+MAEhmHLYES1aLQutbfoeIX6tl1yJJoV5WIWKS/glnXAZAKuaCB4QUUTB9u7QN5fSN/1iHfTYDK2k7TfMXSjR6HOLuu+c1HMKB6ODDFSQarYnQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:52 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/27] drm/amd/display: update dml interfaces and variables
Date: Fri, 15 May 2020 14:13:01 -0400
Message-Id: <20200515181315.1237251-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:50 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70960df5-9bf3-4820-f357-08d7f8fbb8b2
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848FE928C60B23A79608DA398BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0r/qcOSdkswfZTNRq+ibuQymAmsn3X4mIp2WacD8/1NJ6iunqqKPT4aTMveATSdtbnGSJrBBwt/xOE9VHQNO4DxzEB9BcE4RkbFvPy/79fBoBBc7BhJXYiu6uMilEgvOQhXtp707EO6nsu8TfpkfIsm8ioCWCXCB1tvDh6SE7X4vHCsSXgt96Z//Pfb4xbPQb5d8kqgjOmN3C5JMiYEQwM3TqsZE7ZlLI9L9BRUlB+tODA6vpFgL/W6MXODbjrXvVxcZds40ahbT1k4FMDnBTO+biIqHkl+U6nBe3skXLALIooh7+vr1+eX4U4a9LIERYWRLSVs5HCRGgDXb/PnqIdoZV5GpUutV3T9Z8kTI4C2u7J8OrTu51y5tK3KIMgLg7LpS1RlhlWPgBSEippJSqnkAIiHVmMGGJPXvtvcr75Hd+Lw6cVtmEEjfV192U2e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(30864003)(2616005)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PjPddNGtme6sK8R2ceSXj4awU9Gmuh3X3MmO4gXs6kr3xdaeZVRIKh0GgE04RAUJBpgxeK1D695WPmYEIHeim2+QNE28IDet87S4QQSMyxpsuuT8mE0hZu2ponXn8UB3SB4PZx1AB/ReMarEUvPjiyFDLZX+WVbk4y8xa85jbIoYyJxjjne4HLo4oQvwupFvb17gVAx6t8BQkTdyffMsxrqa8EpxVUd9rbAu7nNZIBPgI9PBFU1GdhVqpwQPInVv7pMdJ8ZBxc1pBK7mTU8Fj+Ty6L3NS67gdZDNbddkvmiNmbtrlxQGrzruL/xGmKZxyJnMDp0mVSmzKDXVGvEfqje+zsSTlw1w7L6qPl/LqUYKloEoiwRiC1xxrsqkgHs8EXNlHICHsiGe7x5rLxIj206DBRHnbh3phl5V9rgJ9icdReckJsx75xkc+nalIk9EucmTAkGKN5FxsrwMBgkNE92dxF4Or3TajfawCu1AB/UK1/q01WpOZiHN6ZPQjWraBx8wkn6WJyaiW/YR++iP6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70960df5-9bf3-4820-f357-08d7f8fbb8b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:51.8257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0IL8cfQVmnCxSuui4jFHQbIG75fyqZkydQmXvIIYmqk9kSXRnHrWdnrOOoaUVlPl0EO5S8Fe9T1PTgpbZmwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Preparation for new asic support.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  33 +--
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  33 +--
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  36 +--
 .../amd/display/dc/dml/display_mode_enums.h   |   8 +-
 .../amd/display/dc/dml/display_mode_structs.h |  11 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  54 +++--
 .../drm/amd/display/dc/dml/display_mode_vba.h | 227 ++++++++++--------
 7 files changed, 186 insertions(+), 216 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index ca807846032f..72423dc425dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -890,11 +890,6 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	double refcyc_per_req_delivery_c;
 
 	unsigned int full_recout_width;
-	double xfc_transfer_delay;
-	double xfc_precharge_delay;
-	double xfc_remote_surface_flip_latency;
-	double xfc_dst_y_delta_drq_limit;
-	double xfc_prefetch_margin;
 	double refcyc_per_req_delivery_pre_cur0;
 	double refcyc_per_req_delivery_cur0;
 	double refcyc_per_req_delivery_pre_cur1;
@@ -1344,22 +1339,6 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 		ASSERT(refcyc_per_req_delivery_c < dml_pow(2, 13));
 	}
 
-	// XFC
-	xfc_transfer_delay = get_xfc_transfer_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
-	xfc_precharge_delay = get_xfc_precharge_delay(mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-	xfc_remote_surface_flip_latency = get_xfc_remote_surface_flip_latency(mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-	xfc_dst_y_delta_drq_limit = xfc_remote_surface_flip_latency;
-	xfc_prefetch_margin = get_xfc_prefetch_margin(mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-
 	// TTU - Cursor
 	refcyc_per_req_delivery_pre_cur0 = 0.0;
 	refcyc_per_req_delivery_cur0 = 0.0;
@@ -1510,17 +1489,7 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	disp_dlg_regs->chunk_hdl_adjust_cur1 = 3;
 	disp_dlg_regs->dst_y_offset_cur1 = 0;
 
-	disp_dlg_regs->xfc_reg_transfer_delay = xfc_transfer_delay;
-	disp_dlg_regs->xfc_reg_precharge_delay = xfc_precharge_delay;
-	disp_dlg_regs->xfc_reg_remote_surface_flip_latency = xfc_remote_surface_flip_latency;
-	disp_dlg_regs->xfc_reg_prefetch_margin = dml_ceil(xfc_prefetch_margin * refclk_freq_in_mhz,
-			1);
-
-	// slave has to have this value also set to off
-	if (src->xfc_enable && !src->xfc_slave)
-		disp_dlg_regs->dst_y_delta_drq_limit = dml_ceil(xfc_dst_y_delta_drq_limit, 1);
-	else
-		disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
+	disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
 
 	disp_ttu_regs->refcyc_per_req_delivery_pre_l = (unsigned int) (refcyc_per_req_delivery_pre_l
 			* dml_pow(2, 10));
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 287b7a0ad108..9c78446c3a9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -890,11 +890,6 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	double refcyc_per_req_delivery_c;
 
 	unsigned int full_recout_width;
-	double xfc_transfer_delay;
-	double xfc_precharge_delay;
-	double xfc_remote_surface_flip_latency;
-	double xfc_dst_y_delta_drq_limit;
-	double xfc_prefetch_margin;
 	double refcyc_per_req_delivery_pre_cur0;
 	double refcyc_per_req_delivery_cur0;
 	double refcyc_per_req_delivery_pre_cur1;
@@ -1345,22 +1340,6 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 		ASSERT(refcyc_per_req_delivery_c < dml_pow(2, 13));
 	}
 
-	// XFC
-	xfc_transfer_delay = get_xfc_transfer_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
-	xfc_precharge_delay = get_xfc_precharge_delay(mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-	xfc_remote_surface_flip_latency = get_xfc_remote_surface_flip_latency(mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-	xfc_dst_y_delta_drq_limit = xfc_remote_surface_flip_latency;
-	xfc_prefetch_margin = get_xfc_prefetch_margin(mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-
 	// TTU - Cursor
 	refcyc_per_req_delivery_pre_cur0 = 0.0;
 	refcyc_per_req_delivery_cur0 = 0.0;
@@ -1511,17 +1490,7 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	disp_dlg_regs->chunk_hdl_adjust_cur1 = 3;
 	disp_dlg_regs->dst_y_offset_cur1 = 0;
 
-	disp_dlg_regs->xfc_reg_transfer_delay = xfc_transfer_delay;
-	disp_dlg_regs->xfc_reg_precharge_delay = xfc_precharge_delay;
-	disp_dlg_regs->xfc_reg_remote_surface_flip_latency = xfc_remote_surface_flip_latency;
-	disp_dlg_regs->xfc_reg_prefetch_margin = dml_ceil(xfc_prefetch_margin * refclk_freq_in_mhz,
-			1);
-
-	// slave has to have this value also set to off
-	if (src->xfc_enable && !src->xfc_slave)
-		disp_dlg_regs->dst_y_delta_drq_limit = dml_ceil(xfc_dst_y_delta_drq_limit, 1);
-	else
-		disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
+	disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
 
 	disp_ttu_regs->refcyc_per_req_delivery_pre_l = (unsigned int) (refcyc_per_req_delivery_pre_l
 			* dml_pow(2, 10));
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 90a5fefef05b..edd41d358291 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -936,11 +936,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double refcyc_per_req_delivery_c;
 
 	unsigned int full_recout_width;
-	double xfc_transfer_delay;
-	double xfc_precharge_delay;
-	double xfc_remote_surface_flip_latency;
-	double xfc_dst_y_delta_drq_limit;
-	double xfc_prefetch_margin;
 	double refcyc_per_req_delivery_pre_cur0;
 	double refcyc_per_req_delivery_cur0;
 	double refcyc_per_req_delivery_pre_cur1;
@@ -1412,25 +1407,6 @@ static void dml_rq_dlg_get_dlg_params(
 		ASSERT(refcyc_per_req_delivery_c < dml_pow(2, 13));
 	}
 
-	// XFC
-	xfc_transfer_delay = get_xfc_transfer_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
-	xfc_precharge_delay = get_xfc_precharge_delay(
-			mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-	xfc_remote_surface_flip_latency = get_xfc_remote_surface_flip_latency(
-			mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-	xfc_dst_y_delta_drq_limit = xfc_remote_surface_flip_latency;
-	xfc_prefetch_margin = get_xfc_prefetch_margin(
-			mode_lib,
-			e2e_pipe_param,
-			num_pipes,
-			pipe_idx);
-
 	// TTU - Cursor
 	refcyc_per_req_delivery_pre_cur0 = 0.0;
 	refcyc_per_req_delivery_cur0 = 0.0;
@@ -1621,17 +1597,7 @@ static void dml_rq_dlg_get_dlg_params(
 	disp_dlg_regs->chunk_hdl_adjust_cur1 = 3;
 	disp_dlg_regs->dst_y_offset_cur1 = 0;
 
-	disp_dlg_regs->xfc_reg_transfer_delay = xfc_transfer_delay;
-	disp_dlg_regs->xfc_reg_precharge_delay = xfc_precharge_delay;
-	disp_dlg_regs->xfc_reg_remote_surface_flip_latency = xfc_remote_surface_flip_latency;
-	disp_dlg_regs->xfc_reg_prefetch_margin = dml_ceil(
-			xfc_prefetch_margin * refclk_freq_in_mhz, 1);
-
-	// slave has to have this value also set to off
-	if (src->xfc_enable && !src->xfc_slave)
-		disp_dlg_regs->dst_y_delta_drq_limit = dml_ceil(xfc_dst_y_delta_drq_limit, 1);
-	else
-		disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
+	disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
 
 	disp_ttu_regs->refcyc_per_req_delivery_pre_l = (unsigned int) (refcyc_per_req_delivery_pre_l
 			* dml_pow(2, 10));
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index bfc2f39bd1ef..5baaefd29ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -177,8 +177,14 @@ enum odm_combine_policy {
 };
 
 enum immediate_flip_requirement {
-	dm_immediate_flip_not_required,
 	dm_immediate_flip_required,
+	dm_immediate_flip_not_required,
+};
+
+enum unbounded_requesting_policy {
+	dm_unbounded_requesting,
+	dm_unbounded_requesting_edp_only,
+	dm_unbounded_requesting_disable
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 439ffd04be34..dbd766a4342b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -82,6 +82,7 @@ struct _vcs_dpi_soc_bounding_box_st {
 	double pct_ideal_dram_sdp_bw_after_urgent_pixel_only; // PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly
 	double pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm;
 	double pct_ideal_dram_sdp_bw_after_urgent_vm_only;
+	double pct_ideal_sdp_bw_after_urgent;
 	double max_avg_sdp_bw_use_normal_percent;
 	double max_avg_dram_bw_use_normal_percent;
 	unsigned int max_request_size_bytes;
@@ -125,6 +126,7 @@ struct _vcs_dpi_ip_params_st {
 	bool use_min_dcfclk;
 	bool gpuvm_enable;
 	bool hostvm_enable;
+	bool dsc422_native_support;
 	unsigned int gpuvm_max_page_table_levels;
 	unsigned int hostvm_max_page_table_levels;
 	unsigned int hostvm_cached_page_table_levels;
@@ -143,6 +145,7 @@ struct _vcs_dpi_ip_params_st {
 	unsigned char pte_enable;
 	unsigned int pte_chunk_size_kbytes;
 	unsigned int meta_chunk_size_kbytes;
+	unsigned int min_meta_chunk_size_bytes;
 	unsigned int writeback_chunk_size_kbytes;
 	unsigned int line_buffer_size_bits;
 	unsigned int max_line_buffer_lines;
@@ -158,6 +161,7 @@ struct _vcs_dpi_ip_params_st {
 	double writeback_max_vscl_ratio;
 	double writeback_min_hscl_ratio;
 	double writeback_min_vscl_ratio;
+	double maximum_dsc_bits_per_component;
 	unsigned int writeback_max_hscl_taps;
 	unsigned int writeback_max_vscl_taps;
 	unsigned int writeback_line_buffer_luma_buffer_size;
@@ -219,11 +223,14 @@ struct _vcs_dpi_display_xfc_params_st {
 
 struct _vcs_dpi_display_pipe_source_params_st {
 	int source_format;
+	double dcc_fraction_of_zs_req_luma;
+	double dcc_fraction_of_zs_req_chroma;
 	unsigned char dcc;
 	unsigned int dcc_rate;
 	unsigned int dcc_rate_chroma;
 	unsigned char dcc_use_global;
 	unsigned char vm;
+	bool unbounded_req_mode;
 	bool gpuvm;    // gpuvm enabled
 	bool hostvm;    // hostvm enabled
 	bool gpuvm_levels_force_en;
@@ -324,6 +331,8 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned int vblank_end;
 	unsigned int htotal;
 	unsigned int vtotal;
+	unsigned int refresh_rate;
+	unsigned int vfront_porch;
 	unsigned int vactive;
 	unsigned int hactive;
 	unsigned int vstartup_start;
@@ -333,6 +342,7 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned char interlaced;
 	double pixel_rate_mhz;
 	unsigned char synchronized_vblank_all_planes;
+	unsigned char synchronize_timing_if_single_refresh_rate;
 	unsigned char otg_inst;
 	unsigned int odm_combine;
 	unsigned char use_maximum_vstartup;
@@ -469,6 +479,7 @@ struct _vcs_dpi_display_dlg_regs_st {
 	unsigned int refcyc_per_vm_req_vblank;
 	unsigned int refcyc_per_vm_req_flip;
 	unsigned int refcyc_per_vm_dmdata;
+	unsigned int dmdata_dl_delta;
 };
 
 struct _vcs_dpi_display_ttu_regs_st {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index b19988f54721..2d549736f9b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -91,15 +91,13 @@ dml_get_attr_func(wm_stutter_exit, mode_lib->vba.StutterExitWatermark);
 dml_get_attr_func(wm_stutter_enter_exit, mode_lib->vba.StutterEnterPlusExitWatermark);
 dml_get_attr_func(wm_dram_clock_change, mode_lib->vba.DRAMClockChangeWatermark);
 dml_get_attr_func(wm_writeback_dram_clock_change, mode_lib->vba.WritebackDRAMClockChangeWatermark);
-dml_get_attr_func(wm_xfc_underflow, mode_lib->vba.UrgentWatermark); // xfc_underflow maps to urgent
 dml_get_attr_func(stutter_efficiency, mode_lib->vba.StutterEfficiency);
 dml_get_attr_func(stutter_efficiency_no_vblank, mode_lib->vba.StutterEfficiencyNotIncludingVBlank);
+dml_get_attr_func(stutter_period, mode_lib->vba.StutterPeriod);
 dml_get_attr_func(urgent_latency, mode_lib->vba.UrgentLatency);
 dml_get_attr_func(urgent_extra_latency, mode_lib->vba.UrgentExtraLatency);
 dml_get_attr_func(nonurgent_latency, mode_lib->vba.NonUrgentLatencyTolerance);
-dml_get_attr_func(
-		dram_clock_change_latency,
-		mode_lib->vba.MinActiveDRAMClockChangeLatencySupported);
+dml_get_attr_func(dram_clock_change_latency, mode_lib->vba.MinActiveDRAMClockChangeLatencySupported);
 dml_get_attr_func(dispclk_calculated, mode_lib->vba.DISPCLK_calculated);
 dml_get_attr_func(total_data_read_bw, mode_lib->vba.TotalDataReadBandwidth);
 dml_get_attr_func(return_bw, mode_lib->vba.ReturnBW);
@@ -119,6 +117,7 @@ dml_get_pipe_attr_func(dsc_delay, mode_lib->vba.DSCDelay);
 dml_get_pipe_attr_func(dppclk_calculated, mode_lib->vba.DPPCLK_calculated);
 dml_get_pipe_attr_func(dscclk_calculated, mode_lib->vba.DSCCLK_calculated);
 dml_get_pipe_attr_func(min_ttu_vblank, mode_lib->vba.MinTTUVBlank);
+dml_get_pipe_attr_func(min_ttu_vblank_in_us, mode_lib->vba.MinTTUVBlank);
 dml_get_pipe_attr_func(vratio_prefetch_l, mode_lib->vba.VRatioPrefetchY);
 dml_get_pipe_attr_func(vratio_prefetch_c, mode_lib->vba.VRatioPrefetchC);
 dml_get_pipe_attr_func(dst_x_after_scaler, mode_lib->vba.DSTXAfterScaler);
@@ -127,18 +126,37 @@ dml_get_pipe_attr_func(dst_y_per_vm_vblank, mode_lib->vba.DestinationLinesToRequ
 dml_get_pipe_attr_func(dst_y_per_row_vblank, mode_lib->vba.DestinationLinesToRequestRowInVBlank);
 dml_get_pipe_attr_func(dst_y_prefetch, mode_lib->vba.DestinationLinesForPrefetch);
 dml_get_pipe_attr_func(dst_y_per_vm_flip, mode_lib->vba.DestinationLinesToRequestVMInImmediateFlip);
-dml_get_pipe_attr_func(
-		dst_y_per_row_flip,
-		mode_lib->vba.DestinationLinesToRequestRowInImmediateFlip);
-
-dml_get_pipe_attr_func(xfc_transfer_delay, mode_lib->vba.XFCTransferDelay);
-dml_get_pipe_attr_func(xfc_precharge_delay, mode_lib->vba.XFCPrechargeDelay);
-dml_get_pipe_attr_func(xfc_remote_surface_flip_latency, mode_lib->vba.XFCRemoteSurfaceFlipLatency);
-dml_get_pipe_attr_func(xfc_prefetch_margin, mode_lib->vba.XFCPrefetchMargin);
+dml_get_pipe_attr_func(dst_y_per_row_flip, mode_lib->vba.DestinationLinesToRequestRowInImmediateFlip);
 dml_get_pipe_attr_func(refcyc_per_vm_group_vblank, mode_lib->vba.TimePerVMGroupVBlank);
 dml_get_pipe_attr_func(refcyc_per_vm_group_flip, mode_lib->vba.TimePerVMGroupFlip);
 dml_get_pipe_attr_func(refcyc_per_vm_req_vblank, mode_lib->vba.TimePerVMRequestVBlank);
 dml_get_pipe_attr_func(refcyc_per_vm_req_flip, mode_lib->vba.TimePerVMRequestFlip);
+dml_get_pipe_attr_func(refcyc_per_vm_group_vblank_in_us, mode_lib->vba.TimePerVMGroupVBlank);
+dml_get_pipe_attr_func(refcyc_per_vm_group_flip_in_us, mode_lib->vba.TimePerVMGroupFlip);
+dml_get_pipe_attr_func(refcyc_per_vm_req_vblank_in_us, mode_lib->vba.TimePerVMRequestVBlank);
+dml_get_pipe_attr_func(refcyc_per_vm_req_flip_in_us, mode_lib->vba.TimePerVMRequestFlip);
+dml_get_pipe_attr_func(refcyc_per_vm_dmdata_in_us, mode_lib->vba.Tdmdl_vm);
+dml_get_pipe_attr_func(dmdata_dl_delta_in_us, mode_lib->vba.Tdmdl);
+dml_get_pipe_attr_func(refcyc_per_line_delivery_l_in_us, mode_lib->vba.DisplayPipeLineDeliveryTimeLuma);
+dml_get_pipe_attr_func(refcyc_per_line_delivery_c_in_us, mode_lib->vba.DisplayPipeLineDeliveryTimeChroma);
+dml_get_pipe_attr_func(refcyc_per_line_delivery_pre_l_in_us, mode_lib->vba.DisplayPipeLineDeliveryTimeLumaPrefetch);
+dml_get_pipe_attr_func(refcyc_per_line_delivery_pre_c_in_us, mode_lib->vba.DisplayPipeLineDeliveryTimeChromaPrefetch);
+dml_get_pipe_attr_func(refcyc_per_req_delivery_l_in_us, mode_lib->vba.DisplayPipeRequestDeliveryTimeLuma);
+dml_get_pipe_attr_func(refcyc_per_req_delivery_c_in_us, mode_lib->vba.DisplayPipeRequestDeliveryTimeChroma);
+dml_get_pipe_attr_func(refcyc_per_req_delivery_pre_l_in_us, mode_lib->vba.DisplayPipeRequestDeliveryTimeLumaPrefetch);
+dml_get_pipe_attr_func(refcyc_per_req_delivery_pre_c_in_us, mode_lib->vba.DisplayPipeRequestDeliveryTimeChromaPrefetch);
+dml_get_pipe_attr_func(refcyc_per_cursor_req_delivery_in_us, mode_lib->vba.CursorRequestDeliveryTime);
+dml_get_pipe_attr_func(refcyc_per_cursor_req_delivery_pre_in_us, mode_lib->vba.CursorRequestDeliveryTimePrefetch);
+dml_get_pipe_attr_func(refcyc_per_meta_chunk_nom_l_in_us, mode_lib->vba.TimePerMetaChunkNominal);
+dml_get_pipe_attr_func(refcyc_per_meta_chunk_nom_c_in_us, mode_lib->vba.TimePerChromaMetaChunkNominal);
+dml_get_pipe_attr_func(refcyc_per_meta_chunk_vblank_l_in_us, mode_lib->vba.TimePerMetaChunkVBlank);
+dml_get_pipe_attr_func(refcyc_per_meta_chunk_vblank_c_in_us, mode_lib->vba.TimePerChromaMetaChunkVBlank);
+dml_get_pipe_attr_func(refcyc_per_meta_chunk_flip_l_in_us, mode_lib->vba.TimePerMetaChunkFlip);
+dml_get_pipe_attr_func(refcyc_per_meta_chunk_flip_c_in_us, mode_lib->vba.TimePerChromaMetaChunkFlip);
+
+dml_get_pipe_attr_func(vupdate_offset, mode_lib->vba.VUpdateOffsetPix);
+dml_get_pipe_attr_func(vupdate_width, mode_lib->vba.VUpdateWidthPix);
+dml_get_pipe_attr_func(vready_offset, mode_lib->vba.VReadyOffsetPix);
 
 unsigned int get_vstartup_calculated(
 		struct display_mode_lib *mode_lib,
@@ -293,8 +311,10 @@ static void fetch_ip_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.MaxPSCLToLBThroughput = ip->max_pscl_lb_bw_pix_per_clk;
 	mode_lib->vba.ROBBufferSizeInKByte = ip->rob_buffer_size_kbytes;
 	mode_lib->vba.DETBufferSizeInKByte = ip->det_buffer_size_kbytes;
+
 	mode_lib->vba.PixelChunkSizeInKByte = ip->pixel_chunk_size_kbytes;
 	mode_lib->vba.MetaChunkSize = ip->meta_chunk_size_kbytes;
+	mode_lib->vba.MinMetaChunkSizeBytes = ip->min_meta_chunk_size_bytes;
 	mode_lib->vba.WritebackChunkSize = ip->writeback_chunk_size_kbytes;
 	mode_lib->vba.LineBufferSize = ip->line_buffer_size_bits;
 	mode_lib->vba.MaxLineBufferLines = ip->max_line_buffer_lines;
@@ -425,9 +445,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		/* TODO: Needs to be set based on src->dcc_rate_luma/chroma */
 		mode_lib->vba.DCCRateLuma[mode_lib->vba.NumberOfActivePlanes] = src->dcc_rate;
 		mode_lib->vba.DCCRateChroma[mode_lib->vba.NumberOfActivePlanes] = src->dcc_rate_chroma;
-
-		mode_lib->vba.SourcePixelFormat[mode_lib->vba.NumberOfActivePlanes] =
-				(enum source_format_class) (src->source_format);
+		mode_lib->vba.SourcePixelFormat[mode_lib->vba.NumberOfActivePlanes] = (enum source_format_class) (src->source_format);
 		mode_lib->vba.HActive[mode_lib->vba.NumberOfActivePlanes] = dst->hactive;
 		mode_lib->vba.VActive[mode_lib->vba.NumberOfActivePlanes] = dst->vactive;
 		mode_lib->vba.SurfaceTiling[mode_lib->vba.NumberOfActivePlanes] =
@@ -648,10 +666,12 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 
 	// TODO: ODMCombineEnabled => 2 * DPPPerPlane...actually maybe not since all pipes are specified
 	// Do we want the dscclk to automatically be halved? Guess not since the value is specified
-
+	mode_lib->vba.SynchronizeTimingsIfSingleRefreshRate = pipes[0].pipe.dest.synchronize_timing_if_single_refresh_rate;
 	mode_lib->vba.SynchronizedVBlank = pipes[0].pipe.dest.synchronized_vblank_all_planes;
-	for (k = 1; k < mode_lib->vba.cache_num_pipes; ++k)
+	for (k = 1; k < mode_lib->vba.cache_num_pipes; ++k) {
+		ASSERT(mode_lib->vba.SynchronizeTimingsIfSingleRefreshRate == pipes[k].pipe.dest.synchronize_timing_if_single_refresh_rate);
 		ASSERT(mode_lib->vba.SynchronizedVBlank == pipes[k].pipe.dest.synchronized_vblank_all_planes);
+	}
 
 	mode_lib->vba.GPUVMEnable = false;
 	mode_lib->vba.HostVMEnable = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 3f559e725ab1..d281a6f933f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -41,9 +41,9 @@ dml_get_attr_decl(wm_stutter_exit);
 dml_get_attr_decl(wm_stutter_enter_exit);
 dml_get_attr_decl(wm_dram_clock_change);
 dml_get_attr_decl(wm_writeback_dram_clock_change);
-dml_get_attr_decl(wm_xfc_underflow);
 dml_get_attr_decl(stutter_efficiency_no_vblank);
 dml_get_attr_decl(stutter_efficiency);
+dml_get_attr_decl(stutter_period);
 dml_get_attr_decl(urgent_latency);
 dml_get_attr_decl(urgent_extra_latency);
 dml_get_attr_decl(nonurgent_latency);
@@ -61,6 +61,7 @@ dml_get_pipe_attr_decl(dsc_delay);
 dml_get_pipe_attr_decl(dppclk_calculated);
 dml_get_pipe_attr_decl(dscclk_calculated);
 dml_get_pipe_attr_decl(min_ttu_vblank);
+dml_get_pipe_attr_decl(min_ttu_vblank_in_us);
 dml_get_pipe_attr_decl(vratio_prefetch_l);
 dml_get_pipe_attr_decl(vratio_prefetch_c);
 dml_get_pipe_attr_decl(dst_x_after_scaler);
@@ -70,14 +71,36 @@ dml_get_pipe_attr_decl(dst_y_per_row_vblank);
 dml_get_pipe_attr_decl(dst_y_prefetch);
 dml_get_pipe_attr_decl(dst_y_per_vm_flip);
 dml_get_pipe_attr_decl(dst_y_per_row_flip);
-dml_get_pipe_attr_decl(xfc_transfer_delay);
-dml_get_pipe_attr_decl(xfc_precharge_delay);
-dml_get_pipe_attr_decl(xfc_remote_surface_flip_latency);
-dml_get_pipe_attr_decl(xfc_prefetch_margin);
 dml_get_pipe_attr_decl(refcyc_per_vm_group_vblank);
 dml_get_pipe_attr_decl(refcyc_per_vm_group_flip);
 dml_get_pipe_attr_decl(refcyc_per_vm_req_vblank);
 dml_get_pipe_attr_decl(refcyc_per_vm_req_flip);
+dml_get_pipe_attr_decl(refcyc_per_vm_group_vblank_in_us);
+dml_get_pipe_attr_decl(refcyc_per_vm_group_flip_in_us);
+dml_get_pipe_attr_decl(refcyc_per_vm_req_vblank_in_us);
+dml_get_pipe_attr_decl(refcyc_per_vm_req_flip_in_us);
+dml_get_pipe_attr_decl(refcyc_per_vm_dmdata_in_us);
+dml_get_pipe_attr_decl(dmdata_dl_delta_in_us);
+dml_get_pipe_attr_decl(refcyc_per_line_delivery_l_in_us);
+dml_get_pipe_attr_decl(refcyc_per_line_delivery_c_in_us);
+dml_get_pipe_attr_decl(refcyc_per_line_delivery_pre_l_in_us);
+dml_get_pipe_attr_decl(refcyc_per_line_delivery_pre_c_in_us);
+dml_get_pipe_attr_decl(refcyc_per_req_delivery_l_in_us);
+dml_get_pipe_attr_decl(refcyc_per_req_delivery_c_in_us);
+dml_get_pipe_attr_decl(refcyc_per_req_delivery_pre_l_in_us);
+dml_get_pipe_attr_decl(refcyc_per_req_delivery_pre_c_in_us);
+dml_get_pipe_attr_decl(refcyc_per_cursor_req_delivery_in_us);
+dml_get_pipe_attr_decl(refcyc_per_cursor_req_delivery_pre_in_us);
+dml_get_pipe_attr_decl(refcyc_per_meta_chunk_nom_l_in_us);
+dml_get_pipe_attr_decl(refcyc_per_meta_chunk_nom_c_in_us);
+dml_get_pipe_attr_decl(refcyc_per_meta_chunk_vblank_l_in_us);
+dml_get_pipe_attr_decl(refcyc_per_meta_chunk_vblank_c_in_us);
+dml_get_pipe_attr_decl(refcyc_per_meta_chunk_flip_l_in_us);
+dml_get_pipe_attr_decl(refcyc_per_meta_chunk_flip_c_in_us);
+
+dml_get_pipe_attr_decl(vupdate_offset);
+dml_get_pipe_attr_decl(vupdate_width);
+dml_get_pipe_attr_decl(vready_offset);
 
 unsigned int get_vstartup_calculated(
 		struct display_mode_lib *mode_lib,
@@ -229,8 +252,7 @@ struct vba_vars_st {
 	unsigned int OverrideGPUVMPageTableLevels;
 	unsigned int OverrideHostVMPageTableLevels;
 	unsigned int MetaChunkSize;
-	double MinPixelChunkSizeBytes;
-	double MinMetaChunkSizeBytes;
+	unsigned int MinMetaChunkSizeBytes;
 	unsigned int WritebackChunkSize;
 	bool ODMCapability;
 	unsigned int NumberOfDSC;
@@ -344,8 +366,8 @@ struct vba_vars_st {
 	unsigned int EffectiveLBLatencyHidingSourceLinesLuma;
 	unsigned int EffectiveLBLatencyHidingSourceLinesChroma;
 	double BandwidthAvailableForImmediateFlip;
-	unsigned int PrefetchMode[DC__VOLTAGE_STATES + 1][2];
-	unsigned int PrefetchModePerState[DC__VOLTAGE_STATES + 1][2];
+	unsigned int PrefetchMode[DC__VOLTAGE_STATES][2];
+	unsigned int PrefetchModePerState[DC__VOLTAGE_STATES][2];
 	unsigned int MinPrefetchMode;
 	unsigned int MaxPrefetchMode;
 	bool AnyLinesForVMOrRowTooLarge;
@@ -393,16 +415,16 @@ struct vba_vars_st {
 	unsigned int MaxNumWriteback;
 	bool WritebackLumaAndChromaScalingSupported;
 	bool Cursor64BppSupport;
-	double DCFCLKPerState[DC__VOLTAGE_STATES + 1];
-	double DCFCLKState[DC__VOLTAGE_STATES + 1][2];
-	double FabricClockPerState[DC__VOLTAGE_STATES + 1];
-	double SOCCLKPerState[DC__VOLTAGE_STATES + 1];
-	double PHYCLKPerState[DC__VOLTAGE_STATES + 1];
-	double DTBCLKPerState[DC__VOLTAGE_STATES + 1];
-	double MaxDppclk[DC__VOLTAGE_STATES + 1];
-	double MaxDSCCLK[DC__VOLTAGE_STATES + 1];
-	double DRAMSpeedPerState[DC__VOLTAGE_STATES + 1];
-	double MaxDispclk[DC__VOLTAGE_STATES + 1];
+	double DCFCLKPerState[DC__VOLTAGE_STATES];
+	double DCFCLKState[DC__VOLTAGE_STATES][2];
+	double FabricClockPerState[DC__VOLTAGE_STATES];
+	double SOCCLKPerState[DC__VOLTAGE_STATES];
+	double PHYCLKPerState[DC__VOLTAGE_STATES];
+	double DTBCLKPerState[DC__VOLTAGE_STATES];
+	double MaxDppclk[DC__VOLTAGE_STATES];
+	double MaxDSCCLK[DC__VOLTAGE_STATES];
+	double DRAMSpeedPerState[DC__VOLTAGE_STATES];
+	double MaxDispclk[DC__VOLTAGE_STATES];
 	int VoltageOverrideLevel;
 
 	/*outputs*/
@@ -413,11 +435,11 @@ struct vba_vars_st {
 	bool WritebackLatencySupport;
 	bool WritebackModeSupport;
 	bool Writeback10bpc420Supported;
-	bool BandwidthSupport[DC__VOLTAGE_STATES + 1];
+	bool BandwidthSupport[DC__VOLTAGE_STATES];
 	unsigned int TotalNumberOfActiveWriteback;
 	double CriticalPoint;
 	double ReturnBWToDCNPerState;
-	bool IsErrorResult[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	bool IsErrorResult[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	bool prefetch_vm_bw_valid;
 	bool prefetch_row_bw_valid;
 	bool NumberOfOTGSupport;
@@ -425,7 +447,7 @@ struct vba_vars_st {
 	bool WritebackScaleRatioAndTapsSupport;
 	bool CursorSupport;
 	bool PitchSupport;
-	enum dm_validation_status ValidationStatus[DC__VOLTAGE_STATES + 1];
+	enum dm_validation_status ValidationStatus[DC__VOLTAGE_STATES];
 
 	double WritebackLineBufferLumaBufferSize;
 	double WritebackLineBufferChromaBufferSize;
@@ -443,7 +465,7 @@ struct vba_vars_st {
 	double OutputLinkDPLanes[DC__NUM_DPP__MAX];
 	double ForcedOutputLinkBPP[DC__NUM_DPP__MAX]; // Mode Support only
 	double ImmediateFlipBW[DC__NUM_DPP__MAX];
-	double MaxMaxVStartup[DC__VOLTAGE_STATES + 1][2];
+	double MaxMaxVStartup[DC__VOLTAGE_STATES][2];
 
 	double WritebackLumaVExtra;
 	double WritebackChromaVExtra;
@@ -470,7 +492,7 @@ struct vba_vars_st {
 	double RoundedUpMaxSwathSizeBytesC;
 	double EffectiveDETLBLinesLuma;
 	double EffectiveDETLBLinesChroma;
-	double ProjectedDCFCLKDeepSleep[DC__VOLTAGE_STATES + 1][2];
+	double ProjectedDCFCLKDeepSleep[DC__VOLTAGE_STATES][2];
 	double PDEAndMetaPTEBytesPerFrameY;
 	double PDEAndMetaPTEBytesPerFrameC;
 	unsigned int MetaRowBytesY;
@@ -488,47 +510,47 @@ struct vba_vars_st {
 	double FractionOfUrgentBandwidthImmediateFlip; // Mode Support debugging output
 
 	/* ms locals */
-	double IdealSDPPortBandwidthPerState[DC__VOLTAGE_STATES + 1][2];
-	unsigned int NoOfDPP[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	double IdealSDPPortBandwidthPerState[DC__VOLTAGE_STATES][2];
+	unsigned int NoOfDPP[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	int NoOfDPPThisState[DC__NUM_DPP__MAX];
-	enum odm_combine_mode ODMCombineEnablePerState[DC__VOLTAGE_STATES + 1][DC__NUM_DPP__MAX];
+	enum odm_combine_mode ODMCombineEnablePerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
 	double SwathWidthYThisState[DC__NUM_DPP__MAX];
-	unsigned int SwathHeightCPerState[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	unsigned int SwathHeightCPerState[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	unsigned int SwathHeightYThisState[DC__NUM_DPP__MAX];
 	unsigned int SwathHeightCThisState[DC__NUM_DPP__MAX];
-	double VRatioPreY[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double VRatioPreC[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double RequiredPrefetchPixelDataBWLuma[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double RequiredPrefetchPixelDataBWChroma[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double RequiredDPPCLK[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	double VRatioPreY[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double VRatioPreC[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double RequiredPrefetchPixelDataBWLuma[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double RequiredPrefetchPixelDataBWChroma[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double RequiredDPPCLK[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	double RequiredDPPCLKThisState[DC__NUM_DPP__MAX];
-	bool PTEBufferSizeNotExceededY[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	bool PTEBufferSizeNotExceededC[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	bool BandwidthWithoutPrefetchSupported[DC__VOLTAGE_STATES + 1][2];
-	bool PrefetchSupported[DC__VOLTAGE_STATES + 1][2];
-	bool VRatioInPrefetchSupported[DC__VOLTAGE_STATES + 1][2];
-	double RequiredDISPCLK[DC__VOLTAGE_STATES + 1][2];
-	bool DISPCLK_DPPCLK_Support[DC__VOLTAGE_STATES + 1][2];
-	bool TotalAvailablePipesSupport[DC__VOLTAGE_STATES + 1][2];
-	unsigned int TotalNumberOfActiveDPP[DC__VOLTAGE_STATES + 1][2];
-	unsigned int TotalNumberOfDCCActiveDPP[DC__VOLTAGE_STATES + 1][2];
-	bool ModeSupport[DC__VOLTAGE_STATES + 1][2];
-	double ReturnBWPerState[DC__VOLTAGE_STATES + 1][2];
-	bool DIOSupport[DC__VOLTAGE_STATES + 1];
-	bool NotEnoughDSCUnits[DC__VOLTAGE_STATES + 1];
-	bool DSCCLKRequiredMoreThanSupported[DC__VOLTAGE_STATES + 1];
-	bool DTBCLKRequiredMoreThanSupported[DC__VOLTAGE_STATES + 1];
-	double UrgentRoundTripAndOutOfOrderLatencyPerState[DC__VOLTAGE_STATES + 1];
-	bool ROBSupport[DC__VOLTAGE_STATES + 1][2];
-	bool PTEBufferSizeNotExceeded[DC__VOLTAGE_STATES + 1][2];
-	bool TotalVerticalActiveBandwidthSupport[DC__VOLTAGE_STATES + 1][2];
-	double MaxTotalVerticalActiveAvailableBandwidth[DC__VOLTAGE_STATES + 1][2];
+	bool PTEBufferSizeNotExceededY[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	bool PTEBufferSizeNotExceededC[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	bool BandwidthWithoutPrefetchSupported[DC__VOLTAGE_STATES][2];
+	bool PrefetchSupported[DC__VOLTAGE_STATES][2];
+	bool VRatioInPrefetchSupported[DC__VOLTAGE_STATES][2];
+	double RequiredDISPCLK[DC__VOLTAGE_STATES][2];
+	bool DISPCLK_DPPCLK_Support[DC__VOLTAGE_STATES][2];
+	bool TotalAvailablePipesSupport[DC__VOLTAGE_STATES][2];
+	unsigned int TotalNumberOfActiveDPP[DC__VOLTAGE_STATES][2];
+	unsigned int TotalNumberOfDCCActiveDPP[DC__VOLTAGE_STATES][2];
+	bool ModeSupport[DC__VOLTAGE_STATES][2];
+	double ReturnBWPerState[DC__VOLTAGE_STATES][2];
+	bool DIOSupport[DC__VOLTAGE_STATES];
+	bool NotEnoughDSCUnits[DC__VOLTAGE_STATES];
+	bool DSCCLKRequiredMoreThanSupported[DC__VOLTAGE_STATES];
+	bool DTBCLKRequiredMoreThanSupported[DC__VOLTAGE_STATES];
+	double UrgentRoundTripAndOutOfOrderLatencyPerState[DC__VOLTAGE_STATES];
+	bool ROBSupport[DC__VOLTAGE_STATES][2];
+	bool PTEBufferSizeNotExceeded[DC__VOLTAGE_STATES][2];
+	bool TotalVerticalActiveBandwidthSupport[DC__VOLTAGE_STATES][2];
+	double MaxTotalVerticalActiveAvailableBandwidth[DC__VOLTAGE_STATES][2];
 	double PrefetchBW[DC__NUM_DPP__MAX];
-	double PDEAndMetaPTEBytesPerFrame[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double MetaRowBytes[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double DPTEBytesPerRow[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double PrefetchLinesY[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double PrefetchLinesC[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	double PDEAndMetaPTEBytesPerFrame[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double MetaRowBytes[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double DPTEBytesPerRow[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double PrefetchLinesY[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double PrefetchLinesC[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	unsigned int MaxNumSwY[DC__NUM_DPP__MAX];
 	unsigned int MaxNumSwC[DC__NUM_DPP__MAX];
 	double PrefillY[DC__NUM_DPP__MAX];
@@ -540,12 +562,12 @@ struct vba_vars_st {
 	double SwathWidthYSingleDPP[DC__NUM_DPP__MAX];
 	double BytePerPixelInDETY[DC__NUM_DPP__MAX];
 	double BytePerPixelInDETC[DC__NUM_DPP__MAX];
-	bool RequiresDSC[DC__VOLTAGE_STATES + 1][DC__NUM_DPP__MAX];
-	unsigned int NumberOfDSCSlice[DC__VOLTAGE_STATES + 1][DC__NUM_DPP__MAX];
-	double RequiresFEC[DC__VOLTAGE_STATES + 1][DC__NUM_DPP__MAX];
-	double OutputBppPerState[DC__VOLTAGE_STATES + 1][DC__NUM_DPP__MAX];
-	double DSCDelayPerState[DC__VOLTAGE_STATES + 1][DC__NUM_DPP__MAX];
-	bool ViewportSizeSupport[DC__VOLTAGE_STATES + 1][2];
+	bool RequiresDSC[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
+	unsigned int NumberOfDSCSlice[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
+	double RequiresFEC[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
+	double OutputBppPerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
+	double DSCDelayPerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
+	bool ViewportSizeSupport[DC__VOLTAGE_STATES][2];
 	unsigned int Read256BlockHeightY[DC__NUM_DPP__MAX];
 	unsigned int Read256BlockWidthY[DC__NUM_DPP__MAX];
 	unsigned int Read256BlockHeightC[DC__NUM_DPP__MAX];
@@ -560,7 +582,7 @@ struct vba_vars_st {
 	double WriteBandwidth[DC__NUM_DPP__MAX];
 	double PSCL_FACTOR[DC__NUM_DPP__MAX];
 	double PSCL_FACTOR_CHROMA[DC__NUM_DPP__MAX];
-	double MaximumVStartup[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	double MaximumVStartup[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	unsigned int MacroTileWidthY[DC__NUM_DPP__MAX];
 	unsigned int MacroTileWidthC[DC__NUM_DPP__MAX];
 	double AlignedDCCMetaPitch[DC__NUM_DPP__MAX];
@@ -574,8 +596,8 @@ struct vba_vars_st {
 	double DestinationLinesToRequestVMInImmediateFlip[DC__NUM_DPP__MAX];
 	double DestinationLinesToRequestRowInImmediateFlip[DC__NUM_DPP__MAX];
 	double final_flip_bw[DC__NUM_DPP__MAX];
-	bool ImmediateFlipSupportedForState[DC__VOLTAGE_STATES + 1][2];
-	double WritebackDelay[DC__VOLTAGE_STATES + 1][DC__NUM_DPP__MAX];
+	bool ImmediateFlipSupportedForState[DC__VOLTAGE_STATES][2];
+	double WritebackDelay[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
 	unsigned int vm_group_bytes[DC__NUM_DPP__MAX];
 	unsigned int dpte_group_bytes[DC__NUM_DPP__MAX];
 	unsigned int dpte_row_height[DC__NUM_DPP__MAX];
@@ -595,7 +617,7 @@ struct vba_vars_st {
 	double DisplayPipeLineDeliveryTimeChroma[DC__NUM_DPP__MAX];                     // WM
 	double DisplayPipeRequestDeliveryTimeLuma[DC__NUM_DPP__MAX];
 	double DisplayPipeRequestDeliveryTimeChroma[DC__NUM_DPP__MAX];
-	enum clock_change_support DRAMClockChangeSupport[DC__VOLTAGE_STATES + 1][2];
+	enum clock_change_support DRAMClockChangeSupport[DC__VOLTAGE_STATES][2];
 	double UrgentBurstFactorCursor[DC__NUM_DPP__MAX];
 	double UrgentBurstFactorCursorPre[DC__NUM_DPP__MAX];
 	double UrgentBurstFactorLuma[DC__NUM_DPP__MAX];
@@ -604,7 +626,7 @@ struct vba_vars_st {
 	double UrgentBurstFactorChromaPre[DC__NUM_DPP__MAX];
 
 
-	bool           MPCCombine[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	bool           MPCCombine[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	double         SwathWidthCSingleDPP[DC__NUM_DPP__MAX];
 	double         MaximumSwathWidthInLineBufferLuma;
 	double         MaximumSwathWidthInLineBufferChroma;
@@ -619,6 +641,7 @@ struct vba_vars_st {
 	double         dummy6;
 	double         dummy7[DC__NUM_DPP__MAX];
 	double         dummy8[DC__NUM_DPP__MAX];
+	double         dummy13[DC__NUM_DPP__MAX];
 	unsigned int        dummyinteger1ms[DC__NUM_DPP__MAX];
 	double        dummyinteger2ms[DC__NUM_DPP__MAX];
 	unsigned int        dummyinteger3[DC__NUM_DPP__MAX];
@@ -631,6 +654,9 @@ struct vba_vars_st {
 	unsigned int        dummyinteger10;
 	unsigned int        dummyinteger11;
 	unsigned int        dummyinteger12;
+	unsigned int        dummyinteger30;
+	unsigned int        dummyinteger31;
+	unsigned int        dummyinteger32;
 	unsigned int        dummyintegerarr1[DC__NUM_DPP__MAX];
 	unsigned int        dummyintegerarr2[DC__NUM_DPP__MAX];
 	unsigned int        dummyintegerarr3[DC__NUM_DPP__MAX];
@@ -639,9 +665,9 @@ struct vba_vars_st {
 	bool           SingleDPPViewportSizeSupportPerPlane[DC__NUM_DPP__MAX];
 	double         PlaneRequiredDISPCLKWithODMCombine2To1;
 	double         PlaneRequiredDISPCLKWithODMCombine4To1;
-	unsigned int   TotalNumberOfSingleDPPPlanes[DC__VOLTAGE_STATES + 1][2];
+	unsigned int   TotalNumberOfSingleDPPPlanes[DC__VOLTAGE_STATES][2];
 	bool           LinkDSCEnable;
-	bool           ODMCombine4To1SupportCheckOK[DC__VOLTAGE_STATES + 1];
+	bool           ODMCombine4To1SupportCheckOK[DC__VOLTAGE_STATES];
 	enum odm_combine_mode ODMCombineEnableThisState[DC__NUM_DPP__MAX];
 	double   SwathWidthCThisState[DC__NUM_DPP__MAX];
 	bool           ViewportSizeSupportPerPlane[DC__NUM_DPP__MAX];
@@ -765,6 +791,7 @@ struct vba_vars_st {
 	double FinalDRAMClockChangeLatency;
 	double Tdmdl_vm[DC__NUM_DPP__MAX];
 	double Tdmdl[DC__NUM_DPP__MAX];
+	double TSetup[DC__NUM_DPP__MAX];
 	unsigned int ThisVStartup;
 	bool WritebackAllowDRAMClockChangeEndPosition[DC__NUM_DPP__MAX];
 	double DST_Y_PER_META_ROW_NOM_C[DC__NUM_DPP__MAX];
@@ -785,12 +812,12 @@ struct vba_vars_st {
 	unsigned int ImmediateFlipBytes[DC__NUM_DPP__MAX];
 	unsigned int LinesInDETC[DC__NUM_DPP__MAX];
 	unsigned int LinesInDETCRoundedDownToSwath[DC__NUM_DPP__MAX];
-	double UrgentLatencySupportUsPerState[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	double UrgentLatencySupportUsPerState[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	double UrgentLatencySupportUs[DC__NUM_DPP__MAX];
-	double FabricAndDRAMBandwidthPerState[DC__VOLTAGE_STATES + 1];
-	bool UrgentLatencySupport[DC__VOLTAGE_STATES + 1][2];
-	unsigned int SwathWidthYPerState[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	unsigned int SwathHeightYPerState[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
+	double FabricAndDRAMBandwidthPerState[DC__VOLTAGE_STATES];
+	bool UrgentLatencySupport[DC__VOLTAGE_STATES][2];
+	unsigned int SwathWidthYPerState[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	unsigned int SwathHeightYPerState[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	double qual_row_bw[DC__NUM_DPP__MAX];
 	double prefetch_row_bw[DC__NUM_DPP__MAX];
 	double prefetch_vm_bw[DC__NUM_DPP__MAX];
@@ -838,7 +865,7 @@ struct vba_vars_st {
 	double DCCRateLuma[DC__NUM_DPP__MAX];
 	double DCCRateChroma[DC__NUM_DPP__MAX];
 
-	double PHYCLKD18PerState[DC__VOLTAGE_STATES + 1];
+	double PHYCLKD18PerState[DC__VOLTAGE_STATES];
 
 	bool WritebackSupportInterleaveAndUsingWholeBufferForASingleStream;
 	bool NumberOfHDMIFRLSupport;
@@ -847,7 +874,7 @@ struct vba_vars_st {
 	int    AudioSampleLayout[DC__NUM_DPP__MAX];
 
 	int PercentMarginOverMinimumRequiredDCFCLK;
-	bool DynamicMetadataSupported[DC__VOLTAGE_STATES + 1][2];
+	bool DynamicMetadataSupported[DC__VOLTAGE_STATES][2];
 	enum immediate_flip_requirement ImmediateFlipRequirement;
 	double DETBufferSizeYThisState[DC__NUM_DPP__MAX];
 	double DETBufferSizeCThisState[DC__NUM_DPP__MAX];
@@ -855,26 +882,26 @@ struct vba_vars_st {
 	bool NoUrgentLatencyHidingPre[DC__NUM_DPP__MAX];
 	int swath_width_luma_ub_this_state[DC__NUM_DPP__MAX];
 	int swath_width_chroma_ub_this_state[DC__NUM_DPP__MAX];
-	double UrgLatency[DC__VOLTAGE_STATES + 1];
-	double VActiveCursorBandwidth[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double VActivePixelBandwidth[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	bool NoTimeForPrefetch[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	bool NoTimeForDynamicMetadata[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double dpte_row_bandwidth[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double meta_row_bandwidth[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double DETBufferSizeYAllStates[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double DETBufferSizeCAllStates[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	int swath_width_luma_ub_all_states[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	int swath_width_chroma_ub_all_states[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	bool NotUrgentLatencyHiding[DC__VOLTAGE_STATES + 1][2];
-	unsigned int SwathHeightYAllStates[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	unsigned int SwathHeightCAllStates[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	unsigned int SwathWidthYAllStates[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	unsigned int SwathWidthCAllStates[DC__VOLTAGE_STATES + 1][2][DC__NUM_DPP__MAX];
-	double TotalDPTERowBandwidth[DC__VOLTAGE_STATES + 1][2];
-	double TotalMetaRowBandwidth[DC__VOLTAGE_STATES + 1][2];
-	double TotalVActiveCursorBandwidth[DC__VOLTAGE_STATES + 1][2];
-	double TotalVActivePixelBandwidth[DC__VOLTAGE_STATES + 1][2];
+	double UrgLatency[DC__VOLTAGE_STATES];
+	double VActiveCursorBandwidth[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double VActivePixelBandwidth[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	bool NoTimeForPrefetch[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	bool NoTimeForDynamicMetadata[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double dpte_row_bandwidth[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double meta_row_bandwidth[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double DETBufferSizeYAllStates[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double DETBufferSizeCAllStates[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	int swath_width_luma_ub_all_states[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	int swath_width_chroma_ub_all_states[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	bool NotUrgentLatencyHiding[DC__VOLTAGE_STATES][2];
+	unsigned int SwathHeightYAllStates[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	unsigned int SwathHeightCAllStates[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	unsigned int SwathWidthYAllStates[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	unsigned int SwathWidthCAllStates[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
+	double TotalDPTERowBandwidth[DC__VOLTAGE_STATES][2];
+	double TotalMetaRowBandwidth[DC__VOLTAGE_STATES][2];
+	double TotalVActiveCursorBandwidth[DC__VOLTAGE_STATES][2];
+	double TotalVActivePixelBandwidth[DC__VOLTAGE_STATES][2];
 	double WritebackDelayTime[DC__NUM_DPP__MAX];
 	unsigned int DCCYIndependentBlock[DC__NUM_DPP__MAX];
 	unsigned int DCCCIndependentBlock[DC__NUM_DPP__MAX];
@@ -898,6 +925,8 @@ struct vba_vars_st {
 	enum odm_combine_policy ODMCombinePolicy;
 	bool UseMinimumRequiredDCFCLK;
 	bool AllowDramClockChangeOneDisplayVactive;
+	bool SynchronizeTimingsIfSingleRefreshRate;
+
 };
 
 bool CalculateMinAndMaxPrefetchMode(
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
