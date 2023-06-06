Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C40CC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 12:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F4510E232;
	Tue,  6 Jun 2023 12:35:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F139E10E232
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 12:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlOvC33hu7ZGa04g225IZy0gZNEGJG59u7mB8cMg8PkaLKQXPB8V9MmLxgP6MbtR4lyxPg8f6fX1Vn2bpJdrWCV2ThcBK6DV5nvtZVs5XBXyMGNovdb30RtoCpNcm8LD7VUmP6SnHecKlom2D7ChQnjEEH0vt7i2LZsno130FtOcprMrhG71xlhWHK3IxHbdBPv5R9SqnyAlu0lq651smF6s4jfJzV2p78Khif1egJ4MyT0Qc3vrW4qjqjQBGI473Rs5HZ4q5J1kKaji2cpzBCxzTobrD3XRxmFgWhh/KhWgZDS0GV0ewQBzNwDaT82guINKzLlB5LXrd8Fagfy8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9IBgQR5LFtJTmELB2gVHxKygQtkjNYX3sQ9v7Ki62Q=;
 b=PzJtdrgLQp2OkbXa9L7MbT+meIV+pJ7yqXF70/0t9Zmq6XMYIJqaGvnnrPv+/veGVwxOs8QjfoaU4/UMlNdq8jn8iHI4JOd9h6W/vXsZMTBaMtKA5sSPtRs6TnLDHjmWrLym+90tNKWmpSGeEUJxtKJ9YOQUizHAOAJBuyt/nv/gbFLr7qnzFQViU4gAIdh0/iTrsF/OyQUkFLv/Ku8T8Gw3JFmQ2YcdvtjOr45SirmCTEYlByIrOex3KudA2bLK0uLDCZFD5E20uuy1XaI1tVOe9Z4MH08gXUMNR9fbpk0fx2afea0yFzgTLAyw/NkwtG7xvzPW9He0QKqUbrvt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amdcloud.onmicrosoft.com
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9IBgQR5LFtJTmELB2gVHxKygQtkjNYX3sQ9v7Ki62Q=;
 b=ahm7E2mYhRYuzrZdesCME8m+XgSypqbnPNmsUE+K+YRbNk8fDnr9yN2mHcVYX7ccB5F9n9j1gEt0Xe8ALNEnYHZytztIOP9g3XhdLpTDeB2Ug9yDWPBfgwN3FxK9DIurdgVTZsqZVj8Z7BSP5cvw+CnbnNVtTcPmWnAVoN+8LZc=
Received: from BYAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:c0::14)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 12:35:39 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:c0:cafe::65) by BYAPR05CA0001.outlook.office365.com
 (2603:10b6:a03:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18 via Frontend
 Transport; Tue, 6 Jun 2023 12:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.34 via Frontend Transport; Tue, 6 Jun 2023 12:35:38 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 07:35:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH] drm/amd/display: Fix guarding of 'if
 (dc->debug.visual_confirm)'
Date: Tue, 6 Jun 2023 18:05:18 +0530
Message-ID: <20230606123518.2636457-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ff0fa8-b4ff-4551-2586-08db668a884f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uxFtV+v2AJJGT8xY8beO80mo5zEc5NVzaggmvVR9EILQiaieBvk2ZJH2bkR5tRu0wB7u4Ab4tNKH25LZmzNAvsS58PYOA1VZ2vrxlSwJzDAR9yyzWrtJM1XqETTDNt+XdpZbkQhh4VRIZRYGk2PFAyXZt/Q9kvYcl+iubrso0v72HJiiZivz6ULQIAIqe22SblBaYy9pzY2E1LYGiA20La8mOV9kRGpAy2WNc36rIWxVi/P8fk+XxwMHM/llxPAC2ZoDXHjJqC82F3NW5uWzXmFLaThPjrXVrnHDO0EdT8xRIHgZggNW66zkWF+m9lCTK6W+euw+HOnMSIg8/b4lyjfzozXpuXqAa/3gG/Uoytp0M3ZOEhYLbhwFjKuVXlD0PEQASc63mxzLyAhjp8s+UG0lJTIHf4UzkkQ8+vBiN9dbAQ7GEYK227njqlIIL5YMT92LuMp124bL5CAp1cZ95/sUIpAIETvXdk36Vx+gCb7Fc1ESXglY2Zyqi9PGzVCMGmMw9WXILgwbwZ9PATX9wWXpefx8k4QFmJoHO0kufi3h+dos7Jn1mAmrw7z3Xmjwk/XpDNI3WN706JjIFEn4wpgrdZeKXHIvNSqj+KC9Y1qeRLwWlLQ4r1ZYKIv36lcCtxbEIoGHOZQKrTbU8bbLogRHulcpoRNDQcG04i/Wo+ChOk/1KhAUVY02Y3xDaSWXmlIMy8NVUMkrhgnVQ1ESYYVCmQES8qVvtF4T4iQmX18YIpb0xTMNXpIokucEU2g0Cs0Plp6xLbMcEkb4mXBdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(16526019)(186003)(26005)(2616005)(426003)(336012)(83380400001)(47076005)(36756003)(6666004)(36860700001)(54906003)(82310400005)(7696005)(2906002)(8676002)(8936002)(40480700001)(44832011)(110136005)(82740400003)(478600001)(40460700003)(5660300002)(86362001)(6636002)(4326008)(41300700001)(316002)(70206006)(70586007)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:35:38.0684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ff0fa8-b4ff-4551-2586-08db668a884f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Presumably the author intended to guard both the for loops with
condition 'dc->res_pool->pipe_count' & 'surface_count' under 'if
(dc->debug.visual_confirm)' so that's what I'm changing the code to.
Hopefully to do the right thing.

Fixes the below compilation error:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3546:3: error: misleading indentation; statement is not part of the previous 'if' [-Werror,-Wmisleading-indentation]
                for (i = 0; i < surface_count; i++) {
                ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3538:2: note: previous statement is here
        if (dc->debug.visual_confirm)
        ^

'Fixes: 25e1a6115fc2e ("drm/amd/display: Refactor fast update to use new
HWSS build sequence")'
Cc: Stylon Wang <stylon.wang@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Jun Lei <jun.lei@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5e18fc0c79d6..abab9ae5e07c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3534,7 +3534,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		}
 	}
 
-	if (dc->debug.visual_confirm)
+	if (dc->debug.visual_confirm) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
@@ -3560,6 +3560,8 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				}
 			}
 		}
+	}
+
 	build_dmub_cmd_list(dc,
 			srf_updates,
 			surface_count,
-- 
2.25.1

