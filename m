Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12167C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D250860BD3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D250860BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BB26E3AC;
	Fri, 15 Oct 2021 18:39:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1040B6E3AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmZk0U0TOIiqlgSydQosRvsvRHEziU9jLw3G1frFc2yh1GGIEIDehXxO3/2PSMigfwN1gvFk75POjBg8Bx1inOwNE2reCvZr1T7AWQ34QrtUrNkyJr559OdUwFKn9NWFnZ59rW/UtA6QXrO90Srr0U3CHf3jhLJxvGgH074HzPq4AyW0YC8IXxYM6Cdekr3PDVZ63iyhiMkcTDJAkn9+VqrWtUFXT5DZsupGtZB1yt6KecD2AmqnVxxzlQ1HbDbGZOQRrP6okuhtD0i2pODufyrFZMbYz/2X4V+ddki2FHq6ztB+fKp9U3QBmuvxtzaBdfrNLA1AzOk6eD84cOFtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGg7eW3szUnYyOtn4a0INy4g+yv8qgUIG+UqeKcnzno=;
 b=FXJGfaCHiAPwpgEvbJeenWa3EUluZX7+tGuSlXzruxfC9eOQ9BuIB/4Ta0B58Brg/FNtSa+rpNwYjoui56xW1mfqj4wuDaCxBmqrP5vFyC6WrggijiQ4+2Mhvqtij1HSZv7tnU1ePuybgnOAOTm/0MxtwMw66jo5nAXNvCBs9E1YLdtrMc0AOUojswDwjDQZJ1Jx0UFG/8XDjbGlfLFWL3ftuMeAY4B0FCwXOgmcQqu0kgsQwC4a38iDlSlL6Xv4TKN/WCYd5IeKBURjJFHoR5VSJNULDbFwJzuxNEVs0bfFtgVOo81HWAexgwBi6sqspFSBkRuMSEAbyWnBolABWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGg7eW3szUnYyOtn4a0INy4g+yv8qgUIG+UqeKcnzno=;
 b=cUbsgfgppyO3riNLHuHCjPGCIm6fwkW4Sm2OA8BXtvRa8JZ+3eCUWi9wL2+7WkgJz4y6FoXcRPc+/edvUX3Rp2E6dB0LrBYLa31kc6ySV8k+aXiLRLIu9EqxlXLZa/n0am2z7rSrJTV6Ps1bdc4jHfohSptPrsxc8vukr4ApcCY=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 18:39:15 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b8) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:15 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:12 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Josip Pavic <Josip.Pavic@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>
Subject: [PATCH 06/27] drm/amd/display: do not compare integers of different
 widths
Date: Fri, 15 Oct 2021 14:38:24 -0400
Message-ID: <20211015183845.220831-7-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427579dc-f2a9-4b4d-ac38-08d9900b170b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4476:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4476616B3C2D63CC18698697F5B99@MW3PR12MB4476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iom9aKYq6GD5BxYfMDAiGdUaQW2cETYWuDbc5g9KzlRLVaE9tMrIwEa+7yXCBiMOtitW9FMHHCPovQykzjZ2hAcKdUvZewM2BHzSCslB10Z9dTBybg3iItqwy4iUNEgYdO5Oja2UydYuT5LYzev+/6RYYfOziL3Gmyxehs9ObouvsSHR94cj93D8YJjOqr3TpytUBvmQzzuBLuX9nS71sjUfpNKiA3+R6Mk6HPirZqn3kbqI77PbzA/cqsncLRIEnPb4d5GMj2LhinsjFiC6OJoC4u7y6zUeH3TUXyV9iOwRX9BtKAfHsJ4o0Z7MAyFQEv5Fa8V1onUwXYdLukBtEXGvsCnuY5pdyRH9iNgc/zgGAuC7z2U/f1uHzipaudB+edwTRM5g0n704BUaLqqr6y8nSB38aAlsVIBZKi/b3wU+et3v/BPtyLjYCfpOlZ+Qef3+lC0wrPs67b0xV3TtyqWwsZyWxchH4gebWvpqdVQQhaLXqQYrRJO3P4hKT9WGTxWVIvpQXaOIKBC5FK1wFUFd1rC+KF26Wn2iV+FXhjeevteX69Xg/RmGOxZNb+j7CgeZtQEh5OZYbA08TaycO8Dk3WhqkxfEWuIYFh8mFu9Nh94k+eqLlHp4JykCAa+wsgUg/qP8WGnIrp8Uho8dGNKY+EYfqxIf314WP7yibaN/heEqrv5YRlYi1iyAndgBmFnp82kwZNXdj4L4X1ms4gbB6xxzyVKAf8pDR2BZTPk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(54906003)(36756003)(70586007)(82310400003)(6666004)(316002)(70206006)(47076005)(8936002)(4326008)(186003)(36860700001)(26005)(336012)(6916009)(5660300002)(8676002)(83380400001)(426003)(2616005)(44832011)(1076003)(356005)(86362001)(81166007)(508600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:15.3689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427579dc-f2a9-4b4d-ac38-08d9900b170b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fa11a2b094ba..d54592b573e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3439,7 +3439,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
-	uint8_t i;
+	int i;
 	enum act_return_status ret;
 	DC_LOGGER_INIT(link->ctx->logger);
 
@@ -3531,7 +3531,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
-	uint8_t i;
+	int i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
 	DC_LOGGER_INIT(link->ctx->logger);
 
-- 
2.25.1

