Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14042C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 13:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D1E10E338;
	Tue,  6 Jun 2023 13:12:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342DC10E348
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 13:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf9W5o8ciT79J2J1SwHdj/SkA4v/8AJnwgscz3v1+uRWvwA/z2xlJGTLE1UQ1FZ4Td5CXKUWmrjWs1g66f6Ln0Csq/A3Qc1ibZuGUH1oaoQjxZovGzDEMEteRbPM+LpJ8/V0OAD12F0rA3uKzc1YM2CCU6go9QSHGAgun13Cu7QT10bIlXtZD4D9PT0YbpEFVvAzcJO6V7IX2TRrjRo31AvbnqHWvLGqim66Ni+M92XMwlq9h63gKXDdFnsimp+IsaFk3g7Wj18KxwynYJK19vXySlUETas2MdodFUUfST0d/W+wpkMHdlvivsC+zUpNTvL72wJQ4tYsmRTo7PZ0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYgtFzvRuBJmdOMJrto03l6NBj0qBqyS9feVMeIU/bc=;
 b=ZyTrZJMaF/LlKxCN8KlsIxQq+khmZa4166+63HOKWR5we6tgUxCXloP08FRj0fZROYm0hCSX9xeiyA0Dax3gunsFOag8Nn523bIyWUUcRRkUr/b67q92ED2y7r5/nyD5LqEThVyBDdWK+0CXcCjUNv1Wwn7OCSx8K9lRu52q2cmdvM2GUfF2Qm82nSd1NHxf7CT+tfyCDgznnYwApI0JK7hkcLQ51DZosryxSolgJT9Wo/FtpEIF8YS4abkOCcDuQAzXe0hpDMDMOtAlNtmt6KGDdD7GlrIr3VEKqX8fOxNy+3Q3TRwpURuA4L2fn/Hst5t68JMTVhPjHaZ8C3A4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amdcloud.onmicrosoft.com
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYgtFzvRuBJmdOMJrto03l6NBj0qBqyS9feVMeIU/bc=;
 b=vUYYVDlAVG4bOjgcj7RMAcnVQ1I4xMkJ77suzsuaMa834oqdLyWcj+D25wD5W/PFK19amomdbX0ISn8KF1aQc4CYDlGQGQdbpymr2cCPDua3NqNxuyoOa+Kr3E/zKdOAMafPpht+uqpJrsJTLgHhS4bA9gET9npeuSaIDWoyk3s=
Received: from MW4PR03CA0238.namprd03.prod.outlook.com (2603:10b6:303:b9::33)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 13:11:56 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::97) by MW4PR03CA0238.outlook.office365.com
 (2603:10b6:303:b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 13:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 13:11:55 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 08:11:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix guarding of 'if
 (dc->debug.visual_confirm)'
Date: Tue, 6 Jun 2023 18:41:38 +0530
Message-ID: <20230606131138.2709041-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|BL1PR12MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f24705a-4c98-4e16-18b9-08db668f9a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5LkDs1unt0MT40IxKHHBr5BgPrJvYH/6hvJDFrhE6kwdW++Bj4yxbYQRrBAZqUMXS3CGD68VDdZP9/JUrRVryd3V7f3ti903rpj0QU9jAeOvDSal7jMUER1yq8gksvkyu9733cLrugISEaqZc2V7WIGQrQg67AXmvQjQmmC16oJYRUUj2ril9+W1rlHHLwPoBfBBmJIoj09dVo9/DZ/Qb7660sCm0lgAOogvU/31yCx9GC+7oPzK54Pe2Bq7ddkpzESySgeg5lDXJkNSSSXCAHRFIjl4fevCLkPyZKATPvx9mOQD+XN/LFuX5Ts6G0AQ0r9ZWR+w+WckWzh4g0MQu66j9n/Jh8AKPkuOW+9PtmFnpGkuDkWe7bwjWFrThu6qd6p+urg4tKSi48Txd+9Wj/sPz9BwPmWpcLXVDRERYm+Tu0XGvFdOyj3YqbQwI7KswLUUJbBMbEMzh73dz9YEiIKiXJNDoBZNRcOI3SPqbR/WVO0r5wyXfD6EjeyiFUcbdlv5bGzxWZga3GQm/Nha1uH8aQpVhxgqtoDLsP00ZFBA7xSitG8IZli6Qvb92XDA2YFBCB85TQ+9byLr8qKNKoEWOyEeC87qcpM0flYhqY5hh5wiTpALuA9CvGTVzVUSJn211gkGPPwqjKFcAOhnVwM5CthY4zjvfALIJ4vKqGk+GC9IHerjMOU68dSLD4A/+KKZnLUthwzRY5CSgw09WopOY3VUhL7XFIZKms8cctQlFQ43/O/IOf6Am0qF93TupzQpxXJ7NWxZbVOObkUBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(26005)(110136005)(70206006)(1076003)(7696005)(82740400003)(356005)(4326008)(81166007)(70586007)(6636002)(82310400005)(36860700001)(47076005)(336012)(83380400001)(478600001)(2616005)(426003)(6666004)(36756003)(44832011)(2906002)(40460700003)(41300700001)(316002)(8676002)(54906003)(40480700001)(16526019)(8936002)(186003)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 13:11:55.9569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f24705a-4c98-4e16-18b9-08db668f9a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
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

Presumably the author intended to guard the for loop with
condition 'dc->res_pool->pipe_count' under 'if (dc->debug.visual_confirm)'
so that's what I'm changing the code to. Hopefully to do the right thing.

Fixes the below compilation error:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3546:3: error: misleading indentation; statement is not part of the previous 'if' [-Werror,-Wmisleading-indentation]
                for (i = 0; i < surface_count; i++) {
                ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3538:2: note: previous statement is here
        if (dc->debug.visual_confirm)
        ^

'Fixes: 25e1a6115fc2e ("drm/amd/display: Refactor fast update to use new
HWSS build sequence")'
Suggested-by: Alvin Lee <alvin.lee2@amd.com>
Cc: Stylon Wang <stylon.wang@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Jun Lei <jun.lei@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Guard only 'dc->res_pool->pipe_count' under 'if
   (dc->debug.visual_confirm)' (Alvin)
 - Fix indentation issues for forloop with 
   condition 'surface_count'

 drivers/gpu/drm/amd/display/dc/core/dc.c | 37 +++++++++++++-----------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5e18fc0c79d6..51fbf04a9901 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3534,32 +3534,35 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		}
 	}
 
-	if (dc->debug.visual_confirm)
+	if (dc->debug.visual_confirm) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 			if (pipe->stream && pipe->plane_state)
 				dc_update_viusal_confirm_color(dc, context, pipe);
 		}
+	}
 
-		for (i = 0; i < surface_count; i++) {
-			struct dc_plane_state *plane_state = srf_updates[i].surface;
-			/*set logical flag for lock/unlock use*/
-			for (j = 0; j < dc->res_pool->pipe_count; j++) {
-				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
-				if (!pipe_ctx->plane_state)
-					continue;
-				if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
-					continue;
-				pipe_ctx->plane_state->triplebuffer_flips = false;
-				if (update_type == UPDATE_TYPE_FAST &&
-					dc->hwss.program_triplebuffer != NULL &&
-					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
-						/*triple buffer for VUpdate  only*/
-						pipe_ctx->plane_state->triplebuffer_flips = true;
-				}
+	for (i = 0; i < surface_count; i++) {
+		struct dc_plane_state *plane_state = srf_updates[i].surface;
+		/*set logical flag for lock/unlock use*/
+		for (j = 0; j < dc->res_pool->pipe_count; j++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+			if (!pipe_ctx->plane_state)
+				continue;
+			if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
+				continue;
+			pipe_ctx->plane_state->triplebuffer_flips = false;
+			if (update_type == UPDATE_TYPE_FAST &&
+			    dc->hwss.program_triplebuffer &&
+			    !pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
+				/*triple buffer for VUpdate  only*/
+				pipe_ctx->plane_state->triplebuffer_flips = true;
 			}
 		}
+	}
+
 	build_dmub_cmd_list(dc,
 			srf_updates,
 			surface_count,
-- 
2.25.1

