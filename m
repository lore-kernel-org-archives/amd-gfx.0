Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D26DC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF21B10E3F5;
	Wed, 17 May 2023 11:39:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04DE10E3F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBczzPMuJdMqgxw/ZzGgiZhfBcKkB9090YtiIbY8E0KxBXG50f0hmI6PzzDM3UWSrGFLQOBHrDuz3a3HiFwmVBDQdopEb0LKVd05StaX0SHKUhZDThlBiD/9XTkN/qt6ghIaFKIm0NsV75jQEMbcpF9UeXfXLuTBDoWkJZYvmBivpvH0t+ymU4JZNv5M7GH3tBNptNCkcwocGicVKeLzvO1QgLjF3e5nMiUxPW4imF4ysv6chBV38moZW5WumiaC1mySLsvLio0jXJ1JKp3/g1ZIF1P8mJWx9DzEL1ZcO29n2NUpqLlnI6fKHjFh0TD10XlGpV8Pxbf3qQvmD4CkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATjKLqScaqzHGNVPYIdggEUaeVWF6R6YA7B6ryL2wUo=;
 b=nzzW0H8mtPuVLZ6H961vQL7DI0y1niq2didWq+hcHvrt19xCbaTa9ZEjZZDTFHxO09VK6VmorVbZcEMbtVrDO10c+g1hYaxZDad4tRyv3n8Y+1K7xNOM3k/3ZRQrH8PNT9lene5dqywsr6nf9ny1yQH8BegAJWvqlwM3Spk85vVcYO2Wu7BsScSQJCqfqxtjZTGQdx6ggSZKzzkjM1nBXdqO+Q7fMQ+K/GlT0+XCdVTVnXy7jBjUhkqmbzbbtM7y/aPLB3SlKX+P59Jhg/8C1qwtRDGiCoI3Vt90fYGasRu6Znxa4gKPKLUTvv2H1XYkMfsgVinnmFBX+xyECGl4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATjKLqScaqzHGNVPYIdggEUaeVWF6R6YA7B6ryL2wUo=;
 b=hn5ADKadFu6u8ceWUboYd4zPCK0Jz32RCqr1Le2k8WaZ1JgRx9paEV1NMYudsohBbFSODp+v8TOboshwQUjVzVJVZsSywBg5M8ejURKxV/1q9Fr16MV3o4agEOqeACSCgGNKYrd3TPKsl2rd/Pl3NLAfBpm8NPnQJnK87+3ChqU=
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 11:39:20 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::1c) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.16 via Frontend Transport; Wed, 17 May 2023 11:39:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:18 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:39:13 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/18] drm/amd/display: fix dcn315 pixel rate crb scaling check
Date: Wed, 17 May 2023 19:37:12 +0800
Message-ID: <20230517113723.1757259-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: f51fc38a-0164-403d-c3a4-08db56cb5a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKHdkrc3z1DpC/oWbYYzZbL463d+nlZu6AofoHjiuWQLLGJbNRw6n8/Ysl7aBHxhjWNCQGDuXuwcEmi1sHw8wNKIOwE315wljcthxf2veqYO85clQg0dks2b1P/NsVOXJTIXKEoHbMU745M/G/yQ9mUtURSK0Q8U0nmde0DhCk5Bt3CZRPE/WTqxcqet2aeNO1TNtKYgVPqrrnvkV6INZcuMTpPaXZmGx3YNWyZe/L/B0qV5zGiaDIsusvH/7/7sKzTb7ZmG9bPm39yrS/uWMT2itl8qvMQfXPBWrqhdeWVH1V8PSir2jXwNZSBsSp28zE3UblQREhxUzLvmlANxrodLscRtOVHEABWXUVVFMhrOHd0Ned9cQLeQTd2EFg4EScd0Fu1zRN3zQ4tMtt1+WLlwOmrRbSML3I+zYaZtFQuUMMkOV5LJKmhfld4EzRgiy5y9jbv6haXR4I/GGAv8YDbhI2IVlHpcAtrkqBPsgBECV0vYzwpxcBEPDVyb2INtsIug0lNNCgg/sQefmi1dTQ5exWlA1fwQ7WPGe8GezH1t52cPZDo5OkMd5ycn6TM1b3lqIJOSpkrTYZOR8S/zLlb41pMwLzmSMuziIWwutj6DPiG3AfY2g/Syf4ElKkahR4dH1bgsZ1DDBp9ABSvVXzKQxZjXtaYz5krCGltCBj4/P9rzg/IN+vsEN8YNYL/aKT0oAnAxBWIhjfeeaqEY4ze3JzQxb52dutkx821+xqoIkMb5kCU1iSdNW8dh31oQDDTVSw1sgvFy6+6t3nQipg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(40460700003)(41300700001)(47076005)(2906002)(336012)(36756003)(83380400001)(2616005)(36860700001)(426003)(81166007)(86362001)(356005)(82310400005)(82740400003)(26005)(186003)(1076003)(8676002)(8936002)(40480700001)(70586007)(70206006)(478600001)(7696005)(54906003)(316002)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:39:20.0264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51fc38a-0164-403d-c3a4-08db56cb5a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

fix dcn315 pixel rate crb scaling check error

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index c6bc2d603ab8..95fd3d087ea3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1669,10 +1669,10 @@ static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
 		/*Don't apply if scaling*/
 		if (res_ctx->pipe_ctx[i].stream->src.width != res_ctx->pipe_ctx[i].stream->dst.width ||
 				res_ctx->pipe_ctx[i].stream->src.height != res_ctx->pipe_ctx[i].stream->dst.height ||
-				(res_ctx->pipe_ctx[i].top_pipe->plane_state && (res_ctx->pipe_ctx[i].top_pipe->plane_state->src_rect.width
-														!= res_ctx->pipe_ctx[i].top_pipe->plane_state->dst_rect.width ||
-					res_ctx->pipe_ctx[i].top_pipe->plane_state->src_rect.height
-														!= res_ctx->pipe_ctx[i].top_pipe->plane_state->dst_rect.height)))
+				(res_ctx->pipe_ctx[i].plane_state && (res_ctx->pipe_ctx[i].plane_state->src_rect.width
+														!= res_ctx->pipe_ctx[i].plane_state->dst_rect.width ||
+					res_ctx->pipe_ctx[i].plane_state->src_rect.height
+														!= res_ctx->pipe_ctx[i].plane_state->dst_rect.height)))
 			return false;
 		/*Don't apply if MPO to avoid transition issues*/
 		if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state != res_ctx->pipe_ctx[i].plane_state)
-- 
2.25.1

