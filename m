Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978ACC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D80A20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1zNKv2qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D80A20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16076E48C;
	Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE1B6E48B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCGVURieX2PB8bJcM6Wh2LFIuZLemaCPxfLKyqKFMPYOWffPJAB1P+cmsQkVmr3MIP8lMLBDWZbZ7LlCckYPLekJfCBTzBGPJ8D+chRwfzRYWan/C9bu5NSPqrqztwU7MxZIgBPGNUGGxJ3bTv2tvryZG5ApdwR5u4d5DnMz0G8uqSqL5cmjqTRTD8IYfrs7DpZ2A5ZCL8HvLMiCYiGfXoawedpNkG4mz6bVusrRioDdWo5vEeM4FzZK1bMSasKLEGzTq0JsR2vYGtLU6ZFjb4lrskJo5N+R7JBQZl/xvtY1k9Iuq/xoDyY31FgEiCXbk8yG2D60Uq20wvXM1PeTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xPURiVgyqb+2fFvNDfY4qfdUMH1gqXGRoDGA/iRGSQ=;
 b=fD7mwmzGeA8Z7E1/5vuFcatUU4FXE+BHcqxMp8fIKHoh0JqU7/v192C4lz4m9CPbj27oyGHxqZSuewU47anGuAOgGaemC3DsMdjE1XF8CT+fkh1LY3ypMo7NhTa8qrE88H6R6+eo9UjSexZKT9hFOh4vDEA51hD2hgh6DCuKBceS7dFOo5Qbh7L+uuCnAX6Nn0HbII7IsVWWESvSm8KuM7gfgtj/GBd5ognpswf2XRj0dZcjL3KNaCxbcw+G1CUWxC3ToN/VbizYmtDi9FsrDcl4WWzmYuS8KvUjY7cO7YAnmxoOgIJuDN2ek/p/GCU6IJ2AsJuDnUXxsi6oir1RMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xPURiVgyqb+2fFvNDfY4qfdUMH1gqXGRoDGA/iRGSQ=;
 b=1zNKv2qzyEQX6BNQOWAQZLvCOR0O2VXYARxoAxKMcVCb5zAETxxns8BoxHyIOJNhiZf/F/0LRwQhTsp3xJmV6/hqV5H/G6JQrktnh7gkHHXPQItlytUNUPJHURgo8ZRUZUHATNijBQFvgE9UNI6JND3ClQ5StbcR+EcIIF2ss00=
Received: from DM6PR11CA0019.namprd11.prod.outlook.com (2603:10b6:5:190::32)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:42 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::c2) by DM6PR11CA0019.outlook.office365.com
 (2603:10b6:5:190::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:37 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:37 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/28] drm/amd/display: remove unnecessary mpcc updates
Date: Mon, 8 Jun 2020 00:59:14 -0400
Message-ID: <20200608045926.17197-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(81166007)(82310400002)(356005)(478600001)(4326008)(47076004)(82740400003)(8676002)(8936002)(83380400001)(1076003)(426003)(44832011)(2616005)(336012)(86362001)(2906002)(54906003)(186003)(5660300002)(26005)(316002)(15650500001)(6666004)(70586007)(70206006)(36756003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a8b1f9-2378-438a-ab4d-08d80b68c164
X-MS-TrafficTypeDiagnostic: MW3PR12MB4425:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44252D7BE260DAF69A2DC502FB850@MW3PR12MB4425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOi+e9Uld0mvQypyH8nm9fXKs2SmxnyrATUtxjYsKKZ3rTiYB0WRR/NYJQ7lziXg7quPHGICBFsYQ3+KGkH06issPjLeWZqvxkV7cwErzpLPLxLH7ceBLqeHtV4MM0AbSpa34JV7d8mHmzlSJi6cYh1C7vck6zMXj4hgUM+SXFHZJbAu9M5/ieY1It7jvv/KWNFKymQefxl7d1ZQhiLV4shN33MmX3uNvpDRGYwz0xerb+f3oXvnvX+XO90rgdBN3BmGxO4wwk198aXocBwGxiPtR6PJvse7iX2p3IhGyvODGynfXFNCqdgG25XKmcljsqDulZNUVgFqXQlDQECZwlV0yLEnehc2V3SZGGe17vX2NMHJJ+u3KpPb6HxMTGfObvtQ4lQzYS9gd6cx9Qr/6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:42.1200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8b1f9-2378-438a-ab4d-08d80b68c164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

We were updating mpcc if there were tree changes which
is unnecessary since any mpcc being added or removed
will automatically update the tree.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 65e83fdd7b44..db57cb619a0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1265,14 +1265,13 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 	if (old_pipe->stream_res.tg != new_pipe->stream_res.tg)
 		new_pipe->update_flags.bits.tg_changed = 1;
 
-	/* Detect mpcc blending changes, only dpp inst and bot matter here */
+	/*
+	 * Detect mpcc blending changes, only dpp inst and opp matter here,
+	 * mpccs getting removed/inserted update connected ones during their own
+	 * programming
+	 */
 	if (old_pipe->plane_res.dpp != new_pipe->plane_res.dpp
-			|| old_pipe->stream_res.opp != new_pipe->stream_res.opp
-			|| (!old_pipe->bottom_pipe && new_pipe->bottom_pipe)
-			|| (old_pipe->bottom_pipe && !new_pipe->bottom_pipe)
-			|| (old_pipe->bottom_pipe && new_pipe->bottom_pipe
-				&& old_pipe->bottom_pipe->plane_res.mpcc_inst
-					!= new_pipe->bottom_pipe->plane_res.mpcc_inst))
+			|| old_pipe->stream_res.opp != new_pipe->stream_res.opp)
 		new_pipe->update_flags.bits.mpcc = 1;
 
 	/* Detect dppclk change */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
