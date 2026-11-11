Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87763606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l3xxZvUy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B7210F8E0;
	Wed, 11 Nov 2026 01:43:39 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724F410F8E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omU/DCQLG1aQzkIccLqO/2rvE4EOnGnr3Oo+zO7JpR+4WMva5GVrspXohom1jwh23Nk+C1+7w1U5CoVzt0Yg9JX3d5RS9fc1Bs7kLbuilyI8bZG3bxUKdmHtf6KM2q9eKyxKe1IuYLdrxd0JhL/saCMm5qteY5L891/DMZjhp+lKR38zFulxvAKHX6Joqlv3e/XlZfNH+bNiSe/uIlaOeD1rZIe8C49+rUCcJ0V8Dg2dWCTnuTV96dCQC5tWFzV+E5YIOoh8+3/asZaaemlMB33q73PcwKByB2SYyzsDVZ/V+j7UBjfAvHTgK7GewwLuOsKcOs5gCcqi/QYgUJ/TTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP8laOzOcVHs2T4eo/RnSnuCioPGYIFtOvC0jM80aNQ=;
 b=c5KvcEJcyR7bvEQ85rSTLo0OkRbXwskKDWBBZHkaKDdJZorCNlDtW8blJqmAspAddvsu5gN29mTWPX/6vJyBedCZrWtIS/oqVHAi6maXYrYiabhySBN81RvaCpWlZy8WGJgLzGbMDWQozx/1ZmNcBXLDJ3I96KpHa/HJQ5i0p4+ruFvgjGTF/34ikEh8JVaCMh+FuYbr9a33rLYcI+2WwbNg5tHbc8LxQpQN1qIeamA6zPCwM8Vl/1qtJ7Zr6VTwx28EK2WdqjytclF6ZzQOOebhFkjoIF4aiGlUgjTP/kCGlCKuYMwXxz2TRxCpVCg6VQBBvj5aUDMiM8XfoS7ZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP8laOzOcVHs2T4eo/RnSnuCioPGYIFtOvC0jM80aNQ=;
 b=l3xxZvUyGjxYyv/YXYsCoXt+oBpaKsIU8DMe2Jd4kPntr2EjT0LkDpbJw3jYSzu7dCYIYqr+mSfgS/remX2QYLn1/rLNWiXxiqa4NYbqE+ECO0wx9J7vtSmlBh6LNHsLuEy0Ao1Jny0lgnkSoVEfPwxOiDeoQjkeR3LTSlmV8L4=
Received: from MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16)
 by DSVPR12MB999284.namprd12.prod.outlook.com (2603:10b6:8:41d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:28 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::7c) by MW4PR04CA0341.outlook.office365.com
 (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:27 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:26 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:23 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Samson Tam
 <samson.tam@amd.com>
Subject: [PATCH 47/74] drm/amd/display: Don't shrink zero-area recout in full
 viewport visual confirm
Date: Wed, 11 Nov 2026 09:28:53 +0800
Message-ID: <20261111014100.3596072-48-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|DSVPR12MB999284:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e8d673-0ca9-4443-4605-08df3f952ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|261009223027099003|11063799006|261102123227099003|261028144727099003|261026140227099003|10067099003|56012099006|261021123027099003|261022105027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 6p/rpehivGvT1r0lhDwqmK+WcuOw8VjUwt5RoBSNMDpPpSGTecCq9DeWN2pQxO2bvfJKAuNiB6mFzz5nQFAxp6Brc+nfrRM0B7PXx6CTpILIU9cL63ylgaMmCIsjywnU9j1HIKRatDvB7H1UfopXPwu720gFn+CkK18CiXHEfxnvrFiWOEXVkYbtFfyJ8eSaFu5tf5gBI+W5CA+q5CfRwxNPwfD1D8E+TdImF12kKLgGKAGwhXBz+wFnZ50DqOoZgZKT8nIVCQDnZByR9+RXPfRV6cCTrrCPjgpdbyueXvbz0rVvDJ1332sTn9S4yFmrfe2fKkTwu0OE7riHcf+dv3XaP5H9t1TcpZxgJVAUocQjKTnJ/XEEi4SKEwa+KjdTwS1VTGyUSBprxkG4Guv8FY0PF50JEY1WvLfBhB1GMikL/M5CMEARm3gW6h7nK7jfv6js/2L/qEpetaSuzYymTLwQ6qZOYARfGNx2G70uV9gjxanGVbc1qBRI0NdoRP5bQG7ADGqaPCKjaV75/tSmhIDBqwTagMsZo4qycmDUuts36YAHclNpLozx5eFQvAaQkuSKghbkTbK25KWUmMkQNFxhmLpmljq9ubpG7K+Wo5DzmvwkpBdh1FqM+bupzpmPlLQRanV68ge7OB88/GLgnbpnBsavR8IYDpi/i2cW9ea+9g/OLrg34ZzaRfxo0iLzBmO9MpbhZgsXOdJxqW1N2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(10067099003)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BR4/42SVV0YlNJ3zj0n2wH6iACShV7JheL7eRYJBbrEahh91hiA516jOF0526dV7CkwAfUYj2OzSUBWhsKC3U/tZkhuiNtrDvb3y91RApBSKMBFi/HX11SUIcJSi1jjBI68d/LSGZr8/6dUBwTkefAlos+dSV71ZVacNCpWOr3eW7OAoDipIX3oZVMa0FH+XIs8wGK/DIvYqDoqGDvdAQDyzkSFxUmyCkRqKF83B+5Umreoa6LoWNMMMmDHw2OIl0Bqq51cEUZ+vkGAFRQXWyrNzuLLI1dJsSPM2ttWxYCAOnPjV45Mio58NWNxQt57CvxDpIZbg0woY81m3D/CUt0UBuAr9vPJzDMdLe4+TjgnnWgchF0UUM/1NLk0qSJLhRAzB15oyNgXpJYcAUHFPkuM/kl0YSMKQML+U2OCybzA/9o8AOPEM1HLjrSJn20A7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:27.8925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e8d673-0ca9-4443-4605-08df3f952ef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999284
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

The visual confirm overlay shrinks the recout height by a base/dpp offset.
Prior to visual_confirm_full_viewport, this shrink ran only inside the
overlap > 0 branch of calculate_recout; a pipe with no overlap on its ODM
slice (e.g. an MPO window entirely on a single slice) had its recout zeroed
and was left untouched, so both RECOUT_WIDTH and RECOUT_HEIGHT programmed 0.

The full viewport path moved the shrink to a common tail that runs
unconditionally for every pipe. For a disabled pipe the recout is {0,0,0,0},
so subtracting the height offset drove RECOUT_HEIGHT negative (non-zero)
while RECOUT_WIDTH stayed 0.

Only apply the visual confirm shrink when the recout has real area
(width > 0 && height > 0), for both scl_data.recout and the SPL
dscl_prog_data.recout, preserving the zeroed disabled-pipe behavior.

Cc: Samson Tam <samson.tam@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 832286f0c0b1..3e87ec8ad6a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1747,11 +1747,19 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	 * recout before the viewport was computed.
 	 */
 	if (pipe_ctx->stream->ctx->dc->debug.visual_confirm_full_viewport) {
-		adjust_recout_for_visual_confirm(
-				&pipe_ctx->plane_res.scl_data.recout, pipe_ctx);
+		/* A zero-area recout is the disabled-pipe sentinel (no overlap with this
+		 * ODM slice); only shrink a recout that actually draws, else the height
+		 * offset drives it negative and the pipe no longer reads as disabled.
+		 */
+		if (pipe_ctx->plane_res.scl_data.recout.width > 0 &&
+				pipe_ctx->plane_res.scl_data.recout.height > 0)
+			adjust_recout_for_visual_confirm(
+					&pipe_ctx->plane_res.scl_data.recout, pipe_ctx);
 		/* SPL programs the HW recout from dscl_prog_data, not scl_data.recout */
 		if (pipe_ctx->stream->ctx->dc->config.use_spl &&
-				!pipe_ctx->stream->ctx->dc->debug.disable_spl)
+				!pipe_ctx->stream->ctx->dc->debug.disable_spl &&
+				pipe_ctx->plane_res.scl_data.dscl_prog_data.recout.width > 0 &&
+				pipe_ctx->plane_res.scl_data.dscl_prog_data.recout.height > 0)
 			adjust_recout_for_visual_confirm((struct rect *)
 					&pipe_ctx->plane_res.scl_data.dscl_prog_data.recout,
 					pipe_ctx);
-- 
2.43.0

