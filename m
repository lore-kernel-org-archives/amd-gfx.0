Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B39C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8C910E586;
	Wed,  9 Nov 2022 06:17:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC4110E582
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJMfDWIssmM0w1vk3vKVgeUcwEdkrQxaVt1LCnesz7U2lOUu/VEZtZYUQ7y9wBctpI2UWB4DWTAJRdmpONh5Hm/g5q26j4R4q4TUXRAr/nCf46AgDKTO3NAw3M0rG+J2HLQrjtHk7QzS5HhHMl8LKAChKYQsgDPgvXUrEG/EFOl8t2RCa3eztn4z19nhSvzRG8KzQoJiDMB7m2sBhPJic4IOcuh2t0wnJI/ksKT61H1cxLM0/zw5hLVTd+jthVKTVE9HM39YRUyVJGHPVHJ4YTmlogEBJQUBXCoJdicliAE7TRTyU1QwLnFri+w0bjyiggG6RCdVqmpFKATMTdE1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppAgk4rwU+iorx8O34voIAbl5u+QoCZnLbfvwXKemyA=;
 b=F96Hi76ApzlR7WuD+DrZebs4xky3rnbzY4kucgiftcWf6kMV9+s1FlpduPI+rETCkEOIhFpxZi681pIw4Ts9wXYhNe4r+4Et37VCjtFc5VF5lEPVbOE9aX3B+E6G358yhEe/dGDNdKTF65NP475uLUdldM/PcSn8LybUgj1ESE0fEl2gY4hta5zLTB1xugZKNoHgigMUoThKS32wyH3wNKicOqHPgvxsdGDjQu4yEbsBSGwtiQ3W9KFwNDF3dUz7mDGdST3V5YAk4ckWfKzZzccMqQogji//sqXkLvzKcigjzKVLblgHwZXixEp5C5CYlSG4gXmvP0HYnA8Bk3zCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppAgk4rwU+iorx8O34voIAbl5u+QoCZnLbfvwXKemyA=;
 b=1mZ1ZhvPtqPNOjznN8bYlTVinj0UTyL8QvMvpGAdicbwBDAE9VJNMD7QzfcwwlW0/9qgRsAT5FkfAiGQQZtEcKFzCQZs8TLqIg1HsOAEvykuDyvL6rsCQjK6vwNbxG1/NyhbMIu99K5JUC3LwiIpx8Sase7ta3ZeMPPP9C7Cil4=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:17:33 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f2) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:16:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:16:12 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:16:07 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/29] drm/amd/display: Align phantom pipe dst/src scaling
 with main for subvp
Date: Wed, 9 Nov 2022 14:13:05 +0800
Message-ID: <20221109061319.2870943-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fac1de-3a13-4bc3-0a47-08dac21a168d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fS7wwbU44XfALUcEZGuKVfGcVCXp7ZRlmvn6SwO8LHM5uv5ZLORXdG7LdsE7wMEBwGEqsZsZUKwxiy+UtSG/8bPU3bvPF25qOOG9v6Hg5c9F9kSRc2LMXYNbCzWS42EnY8qTH3b0KtHOAgw4xMTzWr56dyx4I/GX5O5Q+Grl/+5rNYto77TSsyvbCE8NXC/VL/4TWCo4N+KkIIYhhJo5JSqNW2zoRzcGvoAPeoKDB5AkXTF3eL1qBaEw8x/niozT4dBEgUGowDSUTWpMNiFdc/134B0DjqgEG8XOoAQ6BRaMRmT6Q/pWD1q1Q7y8P6Td52ivw2XByleO6IjS4k2VLwwrEd0E6MHWc0HJ7KCMtRbUQ/P2oNT+xDL33Z8zNDyqjKX0UhALQXdqW9A5wpXCBc09LsX7mnjueDnniIj7f+HyKlKOrmyvzMr+IpHL8dzM4FVXnw6Oiag2+0Mhv/IUqX9xEtLigMDIXluLLKvh4osT7uBWIxxIKGUeX+IssIIiyzp+PJVMxu41PmzWIm8WcwTJxbrOx1QNJB8kci/F267khVcHtsdIiaXn/xH2LBHrmekS1CrwGXdpIOpkx5VVPa0SO1RoblZRmwoUBt6jKZDRIv+y1e4GGcB88mn6h0tu/ny1F6FyxVaNLmw6VQ5gOnBy7Bp1UQRKW9EqkccvtIPYvxr0fmA8hxE7AMU/j5+t6ZIvG1PWt6nhuVlaqLuY2y0jw4qRj6QsTIqdZybw+ZHTy2X49UO/YcS4CYESHksxLWXX6nYyDoJrUw8AQ8ikpKgj3m2SlhaRTDEKFoS9c1h35bjQopdNFawgB0/wFYKo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(86362001)(36756003)(356005)(36860700001)(82740400003)(5660300002)(2906002)(47076005)(426003)(26005)(83380400001)(7696005)(186003)(336012)(1076003)(2616005)(316002)(70586007)(70206006)(81166007)(40480700001)(82310400005)(6916009)(40460700003)(8676002)(4326008)(8936002)(478600001)(54906003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:32.8220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fac1de-3a13-4bc3-0a47-08dac21a168d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Subvp src/dst stream rectangles are not being created with the same scaling
factors as the main stream.

[HOW?]
Make sure subvp stream src rectangle scales its height to have the same src/dst
ratio as the main stream.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 08d3c9d9b251..f6c3a2f7a228 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1679,7 +1679,7 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 
 		/* Shadow pipe has small viewport. */
 		phantom_plane->clip_rect.y = 0;
-		phantom_plane->clip_rect.height = phantom_stream->timing.v_addressable;
+		phantom_plane->clip_rect.height = phantom_stream->src.height;
 
 		phantom_plane->is_phantom = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f359f3edaf36..51b4b1d0ba99 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -536,6 +536,7 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 	unsigned int dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 	unsigned int socclk = context->bw_ctx.dml.vba.SOCCLKPerState[vlevel];
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+	struct dc_stream_state *main_stream = ref_pipe->stream;
 
 	dc_assert_fp_enabled();
 
@@ -581,8 +582,13 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 
 	phantom_stream->dst.y = 0;
 	phantom_stream->dst.height = phantom_vactive;
+	/* When scaling, DML provides the end to end required number of lines for MALL.
+	 * dst.height is always correct for this case, but src.height is not which causes a
+	 * delta between main and phantom pipe scaling outputs. Need to adjust src.height on
+	 * phantom for this case.
+	 */
 	phantom_stream->src.y = 0;
-	phantom_stream->src.height = phantom_vactive;
+	phantom_stream->src.height = (double)phantom_vactive * (double)main_stream->src.height / (double)main_stream->dst.height;
 
 	phantom_stream->timing.v_addressable = phantom_vactive;
 	phantom_stream->timing.v_front_porch = 1;
-- 
2.25.1

