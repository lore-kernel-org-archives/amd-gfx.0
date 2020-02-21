Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86923C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFD42067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qItXcrHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFD42067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2916F4AB;
	Fri, 21 Feb 2020 16:04:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9D86F4A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGdrhNUN6LneEOv1OFuwoZCt/ZVuAh1LQe9qgYD+7yQMXSPDfJFLwSpXfbJOcRhk3+AE3mjH3O49MUcFH5A1iYc105yesnXeR27BW/8H8iNEADlE4DYI87sj/7UM3Qvp8DEUpHlbMg/fsL8eTqhFyQ1LVSbXqPuEq+jas97flcToJ+dE9YKCDyENulZnCc0Wc1zJODgyQK9pfh2xe36FACRhjnFcG2nTGwdI9TuUSho4/d6US2ba3C1SSrrLiJbq616rS6MwIZdyumFw6SbAd9nqq3obqXWWOEpMiYm/Oh/feOPHxavTPgB76PVWcQmax90BZWcsqqnk4w5HGJb6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQISLCRrCfzcKr65CBBpRk8oQTDzcDO+a9nWxTJiIBU=;
 b=NQTyj3V7MFTk7M3uWlb+8+KWFjhTnSugPGY8DLT6zPLRiOXEK01wSNLFEPA7hwSCU8SbpjAgZLlM7nckos7zwEWbqlgDuuhYV40qXWo1j78XDpxlQGZ9GNJ4PHrUqXb81ZyRa3vnru9R/hBA2V/x7/KmhVQZFhm3hSPJ/NvMB0ZgAVXtLX91ssaA4dNs5kkcS88GZ+FXNXmuyz909uxLLrdVYGXptA23+Jqkbj6eoDsnDxRkZWScD1ytnKzfKPe14HPNhstK+sdSgkq0kp8p1K8Kn17lt2GOKzbwWbey+Xb1uFRZDA76cigJ7mLbRxVX21xGKh7sdJ2jYk9DL7osBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQISLCRrCfzcKr65CBBpRk8oQTDzcDO+a9nWxTJiIBU=;
 b=qItXcrHjmos8LBfXnxYWU9t3vFNKX3jzHgb+sa4m4+FyWWjrT8VQEWBP8iQqQ1CP+d4bEjHxyIaFhn1qqzuNdZLa+1T3vTifujslcjOQgNjKdJ10YTDhTVqQsPscHzSbHvoB6/DggjxsaoQELspCz6bmqyWeg/G6+ls1KDnLhTU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:59 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/35] drm/amd/display: make some rn_clk_mgr structs and funcs
 static
Date: Fri, 21 Feb 2020 11:03:05 -0500
Message-Id: <20200221160324.2969975-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:58 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f6f1a42-e69e-49f9-a4da-08d7b6e7a922
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24091C0684801732268B558498120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T88SQ8bnAZuXSJDd4p9hMHgdcagysVqSer5FQK6ICX07U29hGwixq8SJvWeh9xJX3t85sLJBcULmz3ezlvqx4JnVDfqOSjHjR9Dv96UzsB15yTHE61NyIeuJsGCWF3VGWU3v96hRmj+p5Hm8BwFY6q5MPu6UT0Zg/lKMLmUaRxp2XiiLrv04uPjb8lTGS1Eac2vGXy50wPP3TF/6z3Md9g9FDfMCdE+mKhaoGwelxleZx3YoT56NxooJtY209vmA+17bHzZi2MvRY66t7WQvJCxoVlXvp4v7xRV9GeT57QkGMNDaoDxzoXJqkKmk31WVXGpTcDn0Pex3kILlzx2KXFVZl2mReXux3ADm99Hu7tZWHWTdQcS6bGfaPqJlY5OGcgPaT7oSCHs1Ou0j2GsHNkyDGR7FmyeWqzRctdZv+0U4Fz91HQNK2oNJUENcJnut
X-MS-Exchange-AntiSpam-MessageData: +qv7JX4DWyCcp2Wq6jIvR1j8XHtNSuagE0FSNvi/oJOLaYC8LIMSlBKPK7QcfeFubVoEvA58SUEjigYnYEymBKdZogZmG6MHcG5fW4XpuToUqoqgTdxN+8tTsm31OnO9rMspocac983nBImF3EcMrg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6f1a42-e69e-49f9-a4da-08d7b6e7a922
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:58.9923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1WXX7PFBNrir7c2SDvrG/ztdJUfG03PKYsp1GNl49Bh+4Myyp2q6eZ0ldsDThrXiA0BpJF3Zyf3gn12nypr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
There are some structures and functions meant only to be used in the
scope of that single rn_clk_mgr c file.

[How]
Make structs and funcs static if only meant to be used within
rn_clk_mgr

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 5d82ec1f1ce5..64cbd5462c79 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -405,7 +405,7 @@ void rn_init_clocks(struct clk_mgr *clk_mgr)
 	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
 }
 
-void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_smu_wm_range_sets *ranges)
+static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_smu_wm_range_sets *ranges)
 {
 	int i, num_valid_sets;
 
@@ -503,7 +503,7 @@ static struct clk_mgr_funcs dcn21_funcs = {
 	.notify_wm_ranges = rn_notify_wm_ranges
 };
 
-struct clk_bw_params rn_bw_params = {
+static struct clk_bw_params rn_bw_params = {
 	.vram_type = Ddr4MemType,
 	.num_channels = 1,
 	.clk_table = {
@@ -543,7 +543,7 @@ struct clk_bw_params rn_bw_params = {
 
 };
 
-struct wm_table ddr4_wm_table = {
+static struct wm_table ddr4_wm_table = {
 	.entries = {
 		{
 			.wm_inst = WM_A,
@@ -580,7 +580,7 @@ struct wm_table ddr4_wm_table = {
 	}
 };
 
-struct wm_table lpddr4_wm_table = {
+static struct wm_table lpddr4_wm_table = {
 	.entries = {
 		{
 			.wm_inst = WM_A,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
