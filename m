Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D987C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FF710EEAE;
	Fri,  8 Apr 2022 17:27:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC08210EEAE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqBmswwrQRG/s8zlR8dWS8HcFcgW0P65fZzNBN5xhvluf86zlyNx0+c/Z8IdZIhmUlnxlOOfBodUr+APujZxud5rG+gayOXaNn86K9zJ67KqclrUkWpx4OeUwihy8PUH4TMHBnOkEkettqvIYwUJ0CT6kawpM+4ocb64iyusjz06kTY4tLRTo5dLDBW8nIaHkLVGoA0rkJFMgoRmHTHLzNgUVYSxCIBk3Mhdm9v/Q0ayFjNgZr9wX/+0Y0fGmRFAMh3x7Ftmi2+DXeMInSw4AlcyaZ4bcuQkUIfKUl+2iAoc3mP52U1+9740y+1/3mRLKwF2j5kP6nJZ6zTiRdepPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwcAx/GYpsyzee5Ytw+QeVJBseDaQOMH/C2x4EPbib0=;
 b=WukTHKe0Jx9KPSdrBxB4ryBRJisw7PNQbLEUjQS7jwBnLgOarOxvvz/LSM+2uXkvVbN+hhiY27cvFAncVZcFJ4AVd/nleJLRuNe9z0ReUY7hcxnmQYsrQpxr5jwD2nC51xrTC5JZYZOS5F6//mYkQZUwfhGKE1cKeHTcnREXhRi8gV+eH00gwphl6qx8139gazjNesT/kus0lzRhjaChHOMqH/a46BIsGpAZ0R+8bpJnDg5nOWypm07NXtrJ35ci/mdSCzK38yVH8TKGb7o0OVUBD3yPm8IvHgSAZ9ciHYW3h4zMMJj1ZFRTfPNrGqZaj1VQl8mp1CDzFsVS6ANLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwcAx/GYpsyzee5Ytw+QeVJBseDaQOMH/C2x4EPbib0=;
 b=d4dlXg998+iW3CjyVrb3WExiulDWpRb8fUFE+56mxNZ6MGIl56ZkJzOmFrcUeqEAE6u7lUulXTXiDkVx7M4ziEd8BNYvOfoaJdPbMdeDPQDryItvH2Wl6hu5OldTxBB/yun/P72y0lLvr4WNgGBUXUGu0RNmPeGR4/FWbXXanIs=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:27:19 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::58) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:18 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:16 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/20] drm/amd/display: Fix crash on setting VRR with no
 display connected
Date: Fri, 8 Apr 2022 13:18:57 -0400
Message-ID: <20220408171911.601615-7-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b104fa24-95f2-4bfb-1d58-08da19850836
X-MS-TrafficTypeDiagnostic: BY5PR12MB4241:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42415DA807D737579FA1BC56FCE99@BY5PR12MB4241.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJAa8hZkvXOFr0XFGpVaDhu/80YSdS0vdPxvzCjw9OA6qhLoTv8ROuK+X9QlH48UpV4OGaAQae+6CIicPG2L5IGlIvdieSMkyqV8TdXdpmI2HxtqSTkMKXYGPTck+o1gKcoMSQFE/qK9skl8hZuIPk7Vu+4G/feKAdcg1uI7EaYB45UTFNQOywN7YkvqzqPA8Vf9f7DZ925q8vhOlbzZPX/EbxEN5yEIU0McS3Be4n3J4EBwTLLnuYlC4CSpB6+RNZt/EN7nC0CYnXDLD6GHYGJ7vMEDHbNB++4yqOuHFUigOPauE1nA/G4FRV7KmBiNkF81r3be1LPEPE5pRvZurzWUdMaHNZrtiEfKl3z6112PHwWsIwE3Unlu87SZPbPBaFE0RuIoHBBKOAh62qqKiVAi9BGb/c7tXaYXD2nYpxDqo/Uw5NickuqMoOuvhX2con4aaoWE78t5RrVXag8eXOrz9uz3OVgsj3Joil3uWi8P1U8xRpUlcmbGhdzp6ySF8VgvOBBnEdmgLtD84Fv8K93R8k6/wMTwaJN/Q4BncXVqoRoJx4EZez7XtCaUkRZz4se7a8+DlmN6khhHOyWnuot3DaiAIV9Hth+Jp9Da3jgNVLOlIjp+vUtnavmlejUN9Smry1pECYMUUzyYiNYN+n3//JtKNHODetkWdVLraipVsqxOxLL//5y5Ou29rkd6n2EowCEOCMO7flXpOZTB7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(2616005)(16526019)(186003)(26005)(54906003)(36860700001)(36756003)(316002)(82310400005)(1076003)(336012)(426003)(83380400001)(47076005)(7696005)(8676002)(70206006)(356005)(4326008)(2906002)(70586007)(81166007)(6666004)(5660300002)(508600001)(86362001)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:18.4361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b104fa24-95f2-4bfb-1d58-08da19850836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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
Cc: stylon.wang@amd.com, Harry VanZyllDeJong <hvanzyll@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>,
 Harry Vanzylldejong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[HOW&WHY]
VRR was getting set at the same time
the timing generator would be null when there was no display
connected. Added null check to the timing generator variable
so it does not get referenced if it is null.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Reviewed-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
Reviewed-by: Nicholas Choi <Nicholas.Choi@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 2d3d870f0bea..328569ad2bd6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3049,12 +3049,16 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 	 * as well.
 	 */
 	for (i = 0; i < num_pipes; i++) {
-		pipe_ctx[i]->stream_res.tg->funcs->set_drr(
-			pipe_ctx[i]->stream_res.tg, &params);
-		if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
-			pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
-					pipe_ctx[i]->stream_res.tg,
-					event_triggers, num_frames);
+		if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs) {
+			if (pipe_ctx[i]->stream_res.tg->funcs->set_drr)
+				pipe_ctx[i]->stream_res.tg->funcs->set_drr(
+					pipe_ctx[i]->stream_res.tg, &params);
+			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
+				if (pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control)
+					pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
+						pipe_ctx[i]->stream_res.tg,
+						event_triggers, num_frames);
+		}
 	}
 }
 
-- 
2.32.0

