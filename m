Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0A8C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E451510E568;
	Tue, 25 Feb 2025 06:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQIaY4/b";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF83E10E568
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJZvebAsEk1K7S/FN21lmM9fg22RT7VhMQYv0+1eTwdSWidOAmZMe7YWyUluPiREYEdCiEVQySuKV8eItcKsCfQ+qye5Nwu2nzorpLLapYwlxttVHXe8MyNt60MhOyPjXIZSJPxh3h5ot9GM6vYUc/v9mhCl65Qk4XrzkX9LZWSEFQsY+uALWtaF5IEgGwGOCs4i7mbLB33VLVW4rri2a748B6ALWWktq+yGmXpSF0Zf9eVHDIasvLd101OndhY4vEKnsk1xbF+WYUBtIR7gf0QYhOd5+SDfiuvbb3zNoI5ARjF3QNw5KkjveKH0UGIIsEHoLgdXxv3Zr00sOuYktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw+KUkMbYCokLneRc+lCyHO3vBncS8/Gs574p4yUAQs=;
 b=mp4bo3oOd+QbFsiFjahPDSQ41dyJYdOS8mBZOnKcE2XkPMNKNIPGEk8jlEmtXUGRkmJPetRydQG5EmAJWlRD0XAxxFtevy/s65mMmP8pLGlKcFScEVkElON2nEBoP6Py1QQeFc9MLL00zoxXO4Y1AVnQCSZjSzGv4HPpddTfWnK+Ms9i7TQsw3sAz1f+5aprZKtYpZUeU2Hfbzf+eLFBgW3yCiIMkwCnJEmbzlFZXCqF6qWNcInv9UFByKUtdOzLtXvqKBA6LsLQiK1cGHlMMLspCskKgXSB7oonmFEUm+dKTAfLdITJudaBWKRIsHKq1k3K8gKro1QWZZn/73gk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw+KUkMbYCokLneRc+lCyHO3vBncS8/Gs574p4yUAQs=;
 b=uQIaY4/b5uX1vFlV50t5lFF+4hQ6ZElqssTDwMtOZ1wvlHpbHTDaUe4Q/rZ1Al1BjF37dGasWLMhbu1CHyX0ZQqlS5DGddDahMWAnSBtBt0IZZ0+8us/75wobmnrkp9xY84S58DVLMaSbiuM9IcOv47xA7nqUDFurFVxXuuF+IY=
Received: from MN2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:208:1a0::18)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:37:58 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::93) by MN2PR07CA0008.outlook.office365.com
 (2603:10b6:208:1a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Tue,
 25 Feb 2025 06:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:56 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:52 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 17/27] drm/amd/display: Use _free() macro for
 amdgpu_dm_commit_zero_streams()
Date: Tue, 25 Feb 2025 14:36:00 +0800
Message-ID: <20250225063610.631461-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be2e787-6d93-4b8b-14c6-08dd5566f14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gSrh1VPlIb+xlhMDZfmir9+J62FgIPWVwF31nbG41IhJ9bdAsVq7GO5Xlhdn?=
 =?us-ascii?Q?xvN2hj8S4UcaYgwmJ8w7aAE0E35kN+UsizQVUD1u0Y0CDqigGHxxGS9fo3/0?=
 =?us-ascii?Q?BJcwrC6y1CTse7eHTilrGitxygWbkTw52ur4fq9BrMDgNc3oSaTK0fK50dwF?=
 =?us-ascii?Q?XDXA+oU01E6Eym702U2JOSzJfjb4TH6DntV92+QPQmCqE0dokPHw2Ix/nSBR?=
 =?us-ascii?Q?8kHhTBkWrcN8CG5+a8S0RXdqRexkANxpwB7UmvCOI/XCfCzQY+WOdivu5XB3?=
 =?us-ascii?Q?c4DvJ6Mi/2D+XbkMKe0Mgc2p/mqiCNW3PBvSjHAd1GtNLRV3u9rbIcispkoa?=
 =?us-ascii?Q?X3X05tK+yX9JbxJncDSSKvf5nl07pTJuHQdkt/LMjWCJ5oXy4uK5YyMiPjht?=
 =?us-ascii?Q?hKjYqHSoz7q7ROUZTtQZ3mTdyGeXJBbakkt3DruEoGJrQWZFhjeFMdgSdEw0?=
 =?us-ascii?Q?MiateroILAeEUn3YXEIlsRZ33nhfGdsKwwAYn5WQIMnF+Q3dNv7BtIpD1xdi?=
 =?us-ascii?Q?JoVP7A8Zud2+FM0TaRkR2PdWuvblvcqFIzgE3HNA6uXl0kodDhi8WuWVkU+G?=
 =?us-ascii?Q?YFFI51OXN/pu++hVfB/l0mqwxMtgNPCWEOO8aDAkFis0xL1w9WLMS+1m0ihX?=
 =?us-ascii?Q?M78//RdiBylrKCNXoNe3TR6TjwTKrIx659w9v4bY2pHxrRXYb7KHuBJ3nA3y?=
 =?us-ascii?Q?QK46WDtkpkugJHSRmJ3okYqJ6r69YhEwCm6/1wVv2ipkII5k3bt7kruSwU80?=
 =?us-ascii?Q?pYKHfzZo3cyfS2DPHeCXDwRwB4Fa4cI/uGk98EgSMiXhlEeNWNrnt26Y13WV?=
 =?us-ascii?Q?zKBqzu2Vm1NIUwJggM2w9lh0FhynWVLC/E0cbLYNRGobgr0cNlSD9F2KODKy?=
 =?us-ascii?Q?xrKyH5AAEydSadpCnat3SZr1KMgA060Z+idyYHh4gYZBr7yjOqlZadMQLPZr?=
 =?us-ascii?Q?JxGh6EE6bBta4BT0vPebtLkhwNDMDoRn8En+ppd95IgZvCRYaS/yOk+kgYcA?=
 =?us-ascii?Q?UzjCvzVsaiKxL+/TyEC3JpooSfKosVqsBZo9fHdNSqE55CuMh2oM/F/bAPBv?=
 =?us-ascii?Q?kgG+6V26KfePTx7U+68AQPWESp+48t/Vfz8nJfhcf7goTshljpUA7rZepl67?=
 =?us-ascii?Q?6GErpU5V8TDupcPRS0aaXVANVPrIeiksSlDE0/1UYj4X72QXHxC7SGQ+XZOf?=
 =?us-ascii?Q?T/KZJEofW/p0XoG7QDEp7v8ha/aKuR3FupD3LDGDcJPY/vxlpUEqBRLpRXkO?=
 =?us-ascii?Q?6LY6of9MPn6E/Z27kx84mjs3mPAd96BV6JCndddQdumCqVh860+Z0NbdTj/S?=
 =?us-ascii?Q?f3NRb13VlAcEgUyJiQuVFtoXk+dW4HZVnORstvbhK0LTbhHNOuccvre1wUZM?=
 =?us-ascii?Q?0q0TucyaIxljiBePFsxE9FpWG09uFEv3KyhvXlIZTe0GcjDxXn0Wwu2JsHUo?=
 =?us-ascii?Q?+UTlqcYZQPOdZaBZDI6HYj/nNMBdoVsaV/897nOLs9wLipeYKBjgswfY1TWl?=
 =?us-ascii?Q?F1Mo9AjKDvaTaG8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:57.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be2e787-6d93-4b8b-14c6-08dd5566f14e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
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

From: Mario Limonciello <mario.limonciello@amd.com>

All cases except a failure to create a copy of the current context will
call dc_state_release() on the copied context.

Use a _free() macro to free the context and then adjust the error handling
flow to drop the unnecessary use of goto statements.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fbeb3e89675b..6e218e69f039 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3083,10 +3083,11 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 
 }
 
+DEFINE_FREE(state_release, struct dc_state *, if (_T) dc_state_release(_T))
+
 static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 {
-	struct dc_state *context = NULL;
-	enum dc_status res = DC_ERROR_UNEXPECTED;
+	struct dc_state *context __free(state_release) = NULL;
 	int i;
 	struct dc_stream_state *del_streams[MAX_PIPES];
 	int del_streams_count = 0;
@@ -3096,7 +3097,7 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 
 	context = dc_state_create_current_copy(dc);
 	if (context == NULL)
-		goto context_alloc_fail;
+		return DC_ERROR_UNEXPECTED;
 
 	/* First remove from context all streams */
 	for (i = 0; i < context->stream_count; i++) {
@@ -3107,25 +3108,20 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 
 	/* Remove all planes for removed streams and then remove the streams */
 	for (i = 0; i < del_streams_count; i++) {
-		if (!dc_state_rem_all_planes_for_stream(dc, del_streams[i], context)) {
-			res = DC_FAIL_DETACH_SURFACES;
-			goto fail;
-		}
+		enum dc_status res;
+
+		if (!dc_state_rem_all_planes_for_stream(dc, del_streams[i], context))
+			return DC_FAIL_DETACH_SURFACES;
 
 		res = dc_state_remove_stream(dc, context, del_streams[i]);
 		if (res != DC_OK)
-			goto fail;
+			return res;
 	}
 
 	params.streams = context->streams;
 	params.stream_count = context->stream_count;
-	res = dc_commit_streams(dc, &params);
-
-fail:
-	dc_state_release(context);
 
-context_alloc_fail:
-	return res;
+	return dc_commit_streams(dc, &params);
 }
 
 static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
-- 
2.37.3

