Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF56C44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF83B10F6DB;
	Thu,  9 Jul 2026 21:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nHtHSTX1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3265C10F6D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHrFH2sZhI/3MIIicKiWG9qn3F4Vj8/t2o7CLZzuou8/iAXMep2nCRV8bemn3Kvw1YQVKbHYV6WEiGwNa+Xz2u6VuNK6kjhVXZRAWe7Y/KESHShl0uJUlMA0c0mJ3pCWhimky4GJfbk76C2UijKep69Q4tP2AJe4aDG2zclU8Tc3GFsUs2dfSgDuaPKxpTzYwR53HMOuMSrPtrX5nroBokFIL9OFXFNS6e/HPMxABlPX8VMlTLMEjaL9A73lZLa712n1STorBh0cpbHJq7vBbJZBylliNC8ac8Gl4xKZ3DKv6B1VskUVmiNWcHVZaBe+6aJlFcpAi5A2pePHsfl6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WbLtEGAUZfsy86tBRg3ERai5BPmzwxaY+YIR/ZA2YU=;
 b=NaXSYATTvJ0AYYrZV3g7RJvG8foZXD46tNmtw2I/3liCWfLTDxIUVXLHtcBxkMaG/RHTymsWT6yKaUblgiT4WfyhyeObobFMnxl761yhzqNxEJx2wGKsAiu5sgsSxr3Jvj5fD/ef4Ps5rD1ONAzS4c2O+AKV6R8u+hgSThvRgoSRN1JLBkFK8UPvvHD3rAP6mdbnG5PFA8vmFqMTyeP91iXopIzJ646FNg87qLsTuXQISK9eSOFQWhxcC5ZCPKEmk+VZ5zsHkFw+jOTKtkfXvIR3FhexQ4OLh+FynGEQBZih4ZL1aPSE26WOqqn7tk6OjzMGOv/dCzFQ+QK6kcdtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WbLtEGAUZfsy86tBRg3ERai5BPmzwxaY+YIR/ZA2YU=;
 b=nHtHSTX1bWUqQInejn0fkiX9gARJ6gbDCL89LZUeiZMZjAMTzD3+iSQArA9RKY/BEiDGJe1iseyAubkqs0zZXIFSugRNe5hkC9ROdQBlSpt1ZPytr/WcWaiwhejXbrfIPmnusdg9cOthTcBMi91JUmH6bBXzIjfG8H1r//aclys=
Received: from BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::8)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:16 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::6e) by BL1P223CA0033.outlook.office365.com
 (2603:10b6:208:5b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:15 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:53 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 23/80] drm/amd/display: Re-evaluate cursor mode on plane
 position/size change
Date: Thu, 9 Jul 2026 16:47:51 -0400
Message-ID: <20260709205936.5719-24-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dad8e52-a8d0-4ab3-0bfc-08deddfd5adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2qERU9ZygQDr6ImkBStIvjUfaYm+jkgtLL2bvKblAd/hOYD/UsMOs/nT1dILEcLh8kq9Umq203ijpZrTsiKmiYY6QX6BSd6AN4HssIsMsZN32shh1nJmx3DBSKBxuJerYOLZK2fIquOIgHXNpMQ6D92yvYcKWsSHeqJXtWRftsn/DiPET5ITFt4eZczLU7ibGz/Ld0IrrMBsVM1nutFilg1T8af+vuHMN24GX9SZalOfGDOZOx0GK0RhqsGKjFuq7xADu+0zcJX6cVh0o06LVXlKXnXONNprOcuam22m9GMe2Klt9PCM+jL3bNP/FH9j0SE+h9T6jbwhNZmBCeEJbET2eLCmwgrPplLn4j3u7FCeGsk4z3N8NOX4OY0FSKo5hObqcjLQ/dTR8z8qiDNKulsGUe7VgFWrDmVIcgZPQmhpnA5qkvg6zUPCWK4KXdzowt3F7Yc4rstId0P3wMVhquiSMasrWu+tr6HLBNjbvnuq5rU40AIA6jitKEsfAroC2h3pSXGta1Diq+vG0wboUMS6nTJ1jOhMNh9bJEQAm488W8KG86LyasesWuxEOCaCH+jpAQjhQmdIx4Nahkn7/tQq0ZsY9IGaG8cDifaXY6v+SY47vw64pYQzHj09ao1RqNwnR22NGX7atHqTBklmjSL67jL2JyGesBpivX7b0drX6t3XOB9wagViRmVzuEtC8QJpYqUwyuJeWB0+0jzpsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i//NV6pfi6tQAs9hNnVkCHiXvjh4HT53plopQW8XUxIfS9O8d8AjFkqK0Cx7KrTB14FbdTC3SNljw+hwa0+gCBkwfTxURmwLK/gEWry9b8nnhh69E+D+q38zql41U22m8tVi3YV00zSwXhGnkvziI6ffJL5EA9D0kD9Tfk3DTylXVccTzV323sxz50BBifMHTUn+c/6B9TAlBpMQ3jvR13KZR/TWsxzWqLbCqnKubvcg0yYwyX7bEKx/JiCDb9xZ+UO+A7GASmlq8IoK9rDJyGK7C+6j5uRV/WhvB0Q4Foh6Vs5njq4yWR1UCt6TvmCo3pmmHhbqzE4sIXHZ8f+Hcy4jLimb2oQJ2wTw9GGauyCAuZll8H79mPslSjF+aGacrjRslGam5N17OreUV9UhxpT7nnz+3LBpdIBjr/MkRq5jW2Ep08N7HLBC//0MlgVM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:15.3552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dad8e52-a8d0-4ab3-0bfc-08deddfd5adc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

From: James Lin <PingLei.Lin@amd.com>

[Why]
dm_crtc_get_cursor_mode() only re-evaluates the required cursor mode
(native vs overlay) when a top plane changes its scale, pixel format,
enable state, or zpos/color pipeline. It does not re-evaluate when a
plane changes only its destination rectangle (crtc_x, crtc_y, crtc_w,
crtc_h) at a constant scale. A pure move/resize can create or remove a
hole under the cursor, which changes whether the native cursor is valid.
When a primary plane shrinks and no longer covers the cursor region, the
cursor mode stays NATIVE and the cursor is not rendered over the
uncovered area, so it becomes invisible there. This is caught by
igt@amdgpu/amd_cursor_overlay@non-full, where the test CRC was a constant
black value across all cursor positions instead of tracking the
reference.

[How]
In the per-plane loop of dm_crtc_get_cursor_mode(), set
consider_mode_change when any of crtc_x, crtc_y, crtc_w or crtc_h differs
between the old and new plane state, so a plane move/resize forces
re-evaluation of the cursor mode. The driver then correctly promotes the
cursor to OVERLAY mode when the primary stops covering the cursor region.

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b97ceabe6173..d67dcaa3fa8f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6647,6 +6647,20 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 			break;
 		}

+		/*
+		 * A plane moving or resizing (without a scale change) changes how
+		 * much of the CRTC it covers. This can create/remove holes under
+		 * the cursor and thus flip the required cursor mode (native vs
+		 * overlay), so the destination rect must be re-evaluated too.
+		 */
+		if (old_plane_state->crtc_x != plane_state->crtc_x ||
+		    old_plane_state->crtc_y != plane_state->crtc_y ||
+		    old_plane_state->crtc_w != plane_state->crtc_w ||
+		    old_plane_state->crtc_h != plane_state->crtc_h) {
+			consider_mode_change = true;
+			break;
+		}
+
 		if (dm_plane_color_pipeline_active(state, plane, true) !=
 		    dm_plane_color_pipeline_active(state, plane, false)) {
 			consider_mode_change = true;
--
2.55.0

