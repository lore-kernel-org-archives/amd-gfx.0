Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF23C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFE810E423;
	Fri, 10 Dec 2021 23:05:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A7710E423
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkAkp7WEPcQEftOc5r1CB4v7QlWj0RLf4e0Lba7B79AyuA/lCI2pPzFzmOaEtWVZFp+eDEoiVFjnc/T+HNiXtBUR8wRi2GW+LjXC0p3wqOnBV0bbm6YZdQWrDBPUv3g1kp8BaSI38TGi3Yx7VUTxQa9P/VS51RImoTm77+ZBk1u2vb7sajD639165HQRwW4L49p9WdOSZsALchHfKoCDffQN2Dk7/4l9uJb0bqX8HrJbEIG6UoY6UioGw2c7btYxrYzrtCDAdp6NpsDLhcWCIy4njc/dKzkN6CNRwpOyGpalRbPKz9en3uZkd4SdIjSaT1kqD7oP5Q4qJjHfwDd6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXHQPVPwbke+bx0Lsk+mzv4CmFkXPhLuPEUKTs/xsrY=;
 b=dk3KrXhmyKnc8jYkpyq/dwkkbnV0wcVLb3F7Mj84KnWt2RwtWL6R0tuZamh/LNq8eSL1ZG3q4aLDvRZifrMW09FFcjOwWg3gafr9kl9BlYAj+TAaQB8VwKltRVyw0G94UqUrgmgCx1lbNEJsWME/1Op5cnBuAFLnjywS31u8pBVBBZCHljz/Muwy6vlk8/iGcXry1b8iUkhMYWpvVgpwUXoenKEfqxUYbRqpbzxAaOhaja5B3ShSt9daQgfgKrkSV8T2m2lAi4F5IhgBtbVn4Ebe4K+R2o69PLX03xS1zyNChPjttwq4R/ZI6L4weIOUgJqtoGl5egPcFcC67UccWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXHQPVPwbke+bx0Lsk+mzv4CmFkXPhLuPEUKTs/xsrY=;
 b=xdpQMvzqg2TVimPglEiu4NHirZMNLASF+Ysa4tu7EUknA+IjJarIJui3dQF7RkuUw2R5xaUD70o18PbPKsHlv3XR1qmszAn0qWetq+2q/jLXxkiw1VeCgU1+mWukJuWlyvs2rXmqrSY2hYh7DhWeneCs7QTWCkzhRuq4Pa9XuU4=
Received: from DM6PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:40::44) by
 CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22; Fri, 10 Dec 2021 23:05:19 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::c7) by DM6PR03CA0031.outlook.office365.com
 (2603:10b6:5:40::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:19 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:16 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amd/display: Force det buf size to 192KB with 3+
 streams and upscaling
Date: Fri, 10 Dec 2021 15:04:03 -0800
Message-ID: <20211210230408.619373-6-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeccfe12-962d-4e93-4270-08d9bc31895a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4056:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4056BF595165C1ACE3394336FC719@CH2PR12MB4056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LtreTv6gHYBb67qsY4/YMj8tXpK01gua59hRp84EbSlgi2e1koYVyI9LMApFULQYgvzS9EGE14eKY/NGoMYoLC1Nl6uSMlr1rq621sm6JKxDdbyYbDXMxvSy7c1aucXU/rePWxF9hxD3OtLRL8Kulr8TevVQp4C68WbDCF2I4Myb2Y6iez3tHruhW2gbKPReTCJIgTR1oQKLovkleouA2wA6gikFK4kz8S5JcvTgkXceqz3Za61KP+LWhP8Y5xX6EC7wF/bZRI0mrCA5waEUsBQGPeo4b1J2bspUtqN+ZMCTRBqMns4FOBSSxVDRb2COkjAV5MC730HTOSVK49wF660Mh2yx+tKCV98tIloCcCHj7uEs+e1JRvqplgz92/f0xwu1Fn2fhmIIxwx/u8FXsKJPZdr5i2hTA7gSOBS1sf+EIOi/Jt7vCdhiAOyP/r+dIZHSu7wwTOzCfm2RxWdVzhgVgILjAVJqY0gc4E5bYjK0mrGpY7vfLnuelAPQ/qs63nFt3Ot4pNDYkEFSTQVwXD/i3Pyqe8+cXrUksbmQG+T14d4BSLBE0VAFvA8tP4aB0/vLeqYREU01OEU0RzpdZBjChY82blGLpEkysTWLpq0NO7yVTxjSLVkBrK+HLJxgLp4fb0B4v81ApgG1XWYsmXlMgbrqNSbje/1YGMTC0T2lP6dnNbP+nlpPGznt84r3gBpy2fnm1aoBXL6bNBiYNgUUNkW4DTkEft54fIaOcfs/fPLTQ8zVdaHlI0/foiHPE0KD6KrA1gIBWYl+q2Vpzc9enPkOBsnGU+eYBinYnmBLpojRci39bN7vGgSxs/kqXHXLnZkczWk+ytRc9OToA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(186003)(2906002)(8936002)(83380400001)(336012)(2616005)(54906003)(6666004)(316002)(86362001)(70206006)(16526019)(1076003)(82310400004)(47076005)(508600001)(8676002)(7696005)(36756003)(6916009)(4326008)(40460700001)(5660300002)(36860700001)(426003)(356005)(81166007)(70586007)(188633002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:19.2667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeccfe12-962d-4e93-4270-08d9bc31895a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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
Cc: stylon.wang@amd.com, Eric
 Yang <Eric.Yang2@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
This workaround resolves underflow caused by incorrect DST_Y_PREFETCH.
Overriding to 192KB DET buf size until the DST_Y_PREFETCH calc is fixed.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 04b52c9d18da..a99800146c9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1770,6 +1770,7 @@ static int dcn31_populate_dml_pipes_from_context(
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
+	bool upscaled = false;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
@@ -1781,6 +1782,11 @@ static int dcn31_populate_dml_pipes_from_context(
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
+		if (pipe->plane_state &&
+				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
+				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
+			upscaled = true;
+
 		/*
 		 * Immediate flip can be set dynamically after enabling the plane.
 		 * We need to require support for immediate flip or underflow can be
@@ -1828,6 +1834,8 @@ static int dcn31_populate_dml_pipes_from_context(
 	} else if (context->stream_count >= dc->debug.crb_alloc_policy_min_disp_count
 			&& dc->debug.crb_alloc_policy > DET_SIZE_DEFAULT) {
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes = dc->debug.crb_alloc_policy * 64;
+	} else if (context->stream_count >= 3 && upscaled) {
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 	}
 
 	return pipe_cnt;
-- 
2.32.0

