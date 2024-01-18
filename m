Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DABBC47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D0F10E81B;
	Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54D010E81B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnWDAtqTiAl9+ShEKw/oIv9mYMUwQP6rewV/3P1+eZdiVYy2geCyXsqo50vM/hFmXKFh8HPMeS4qiH5aKZu7MhIPSMxWoIqrSf6DZA1hZCe4Bbsh+GciZxtda8id0d/A4u364tzeDB8vtm8oFsk0xBZXiFMmCY96JPgj/b255WTVEVxi2tYxvDZtMwl01KqzOpXMKu/zrp18uhSpOv+m4nGvHoH8PIHdUUmyLtAi3bscpWtElmseFla49CGfrrKvJdnjmkRCDFjVk6z89KYS8iq0GSJLmXPu9Ofgh0osW0hRX98q9sFSM14gDZ/7CCPYzRcP7bkx63mEafJ7rHsFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EujIlW+Ik7a2whfRgSG53kcLuevvIir6rKM4ZJ/y9nI=;
 b=UNuOG60cVPxuEn4Zq5SKJogKvXp7CcLTX9OHifBk+T6GLruP8oVOyweEfNsksJzrLWRZJHrk2FN2UXVtH9ALLmjsUvgFUClDNI5tiTRLG6fGF5Wjn2U4IobVNZm+RzaBujVFVafaYJzF6TPA7TSvSKhkzHiBmv88FsFbm0HbBcgtc7rfBv9xx0YuEXm2LpfzJviG00gYh0JMKiHwlao1x7v/OLy/hsJW3q7CQDVba/iaoB4j1QdKWgbdaFChxI4S4d9MJSW6tmpOo9Fv7JqKbnEdYWRKVGfUt/C6twl2via/IVhYCOWdsg219a8BxaHIhDo6hLFlZYH34L3/XJ6Nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EujIlW+Ik7a2whfRgSG53kcLuevvIir6rKM4ZJ/y9nI=;
 b=mVUaxeAkthQYgG3bQdTTfvaM5N4kC4IMOF7ofxrPqCK5jGO/U809DTgz5KC2jrrwCrz5l1/h0P9tHE46PI20v51y2EhcaIxpHKNtrzCsINc8ZqVQXGhdcWn2Lp6dJ/UnFb5mJhlWHyPuxSu3PnMyj49nkXGaFWVFr9O1tUkDMmA=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Thu, 18 Jan
 2024 14:34:48 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::26) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:41 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:40 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Add NULL-checks in dml2 assigned pipe
 search
Date: Thu, 18 Jan 2024 09:33:52 -0500
Message-ID: <20240118143400.1001088-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ad27c8-770c-41e1-bd62-08dc18329f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pMLOlTOq1usvxWu9hw2+6DIuqEun4GiIxi6yA1I8kgPIuF1bIotl9xtOJeEPp10ugD24qeB3AURb3HCS12jW901w2XV+Hqhbxw3hnnwfIqIh0MBXO5+deTpgTwdbD5biQleMFfWSNGgJl0tb3ikJSd1Q2QDnusYmVK7ItQ7XYsmbsus6ET7Exc1uz+FHH84Wj2IHShLt0523r8ZisxohEkyMIBcU9+8mq/zMCAmNB70uknVTmBDRlGWZPYG2wluMx1WkbpeXOfHivI4dYoGEBCjV0eCltE+jbxLqYV84PrliJ/CP9MFxOPTJE1rvJYdvgbtRGc2jqRPCRd5USbGezjVWYTMeauxAk5EqN+ojld1j4Uuc/jklyz6TGTyTn6Qar3Zmi+6GynCG+aRIEAs/K3TrwZs5cmvJDjED7NjMLPUce1EdcjaOCOOXD6vqCaaQYxC109wDP8mMEudUlJI+E5WqSys1uSD27id4I5+cmXo7Aw/xJtv/FxIMb/2K300a0FGDOYKrM3RNUlMZGYR1ZQQ5c3UAXNmLOHW/CJ5X3raRQYWli1ayLzLpd2OG7dZ+oj4Fepbqa05XVfZU+cmC4T0U2v7F4oe6I5dTmLDsxouFNtwgQ6FJ0QhtRIowo1rs/74moOZINL9ruGdHQY89/D6ImCMRpniFfFsC9QEdaFkD00cnEYtEDVa3rJG6BpY8G/jFwAu2VClRxo/l8WdxP+D0+x/7DV0LZP1aBR3A3O3jxEgpgaTNGW4jTlijFLLCr2YauK8gyDMRAsmguujOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(82740400003)(336012)(1076003)(47076005)(83380400001)(36756003)(2616005)(426003)(26005)(36860700001)(70206006)(6916009)(5660300002)(6666004)(54906003)(7696005)(4326008)(2906002)(478600001)(2876002)(70586007)(8936002)(316002)(8676002)(356005)(86362001)(81166007)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:47.4795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ad27c8-770c-41e1-bd62-08dc18329f15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Allen Pan <allen.pan@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Gabe Teeger <gabe.teeger@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Allen Pan <allen.pan@amd.com>

[Why]
NULL-deref regression after:
"drm/amd/display: Fix dml2 assigned pipe search"

[How]
Add verification for potential NULLs

Fixes: 133e813d5044 ("drm/amd/display: Fix dml2 assigned pipe search")

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index a0ce681b26c6..a52c594e1ba4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -146,19 +146,24 @@ static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx,
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
+		if (!pipe->plane_state || !pipe->stream)
 			continue;
 
 		get_plane_id(ctx, state, pipe->plane_state, pipe->stream->stream_id,
 					ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[pipe->pipe_idx],
 					&plane_id_assigned_to_pipe);
-		if (pipe->plane_state && plane_id_assigned_to_pipe == plane_id && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+		if (plane_id_assigned_to_pipe == plane_id && !pipe->prev_odm_pipe
+				&& (!pipe->top_pipe || pipe->top_pipe->plane_state != pipe->plane_state)) {
 			while (pipe) {
-				struct pipe_ctx *mpo_pipe = pipe;
-
-				while (mpo_pipe) {
-					pipes[num_found++] = mpo_pipe->pipe_idx;
-					mpo_pipe = mpo_pipe->bottom_pipe;
+				struct pipe_ctx *mpc_pipe = pipe;
+
+				while (mpc_pipe) {
+					pipes[num_found++] = mpc_pipe->pipe_idx;
+					mpc_pipe = mpc_pipe->bottom_pipe;
+					if (!mpc_pipe)
+						break;
+					if (mpc_pipe->plane_state != pipe->plane_state)
+						mpc_pipe = NULL;
 				}
 				pipe = pipe->next_odm_pipe;
 			}
-- 
2.34.1

