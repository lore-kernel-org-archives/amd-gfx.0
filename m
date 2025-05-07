Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E816C3ABBE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37FE10E73C;
	Wed,  7 May 2025 02:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQpkSfKb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A5310E73C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6iXlVd9JKYxWFYY6YgTGDdlhe8L+fROqWLaPM1Oci/nvHOCmXE+dvssG+6MbwjI95v09r4lppJy2DiblSc6jF7Xq6S8d8TA2ovK6OITLDVOVaEIL88vPcu/N1tJMTXk0eW01stpMSRmQZtGJjyGWF5j5vKKoGiVur1QbQxmlxSDdnJQAlfkzB+pKX5MJQxUNZleh3CAap+aUi6yM5WJw0fqXiHQ2HE9Gfnh4vVOBZ/NdfXA2W8KC4FVOKf3NCh/9388XAHtR72cT4/vpR2LTdo668LzhtTBnt7stw22ztEPR8sRaun8BkROglc9nFMtnnxKLmtiFxIjVx2+xiG4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHEvUME4yNeuHTpQfFKGMXc0jg07/rCYRfcD5yr9ZLQ=;
 b=dbkcu6ydWzUNIlQXPcFqYKkF1+E2W9b7q4FEnLXkmuXGxicBgMdbLkW+7GHqkMb9T7Pl6fwavccV95C+342nKgRiOjg7pUOmOX0V+fCEsjB3teuJuF+2tUX+V5diJDJ8CB0GbpDfoQEa+o0U8WJWDvqAHKgujpIN8WQcFTcZi730HUDJcL4P6je8b16W68RGdYANnlEOWRw5IlKjThsl+CCj0CLluWWjQ4cblg7Eex8mkJoso/otvxuKEfeDwq83YGpai0MRLoiATzmvw0TqrnoxBzmxbhkonzGbb1QT8HWe2yIHX+FAdLwuLf6ykVV4JLbv1q71XGgnrBo04IW5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHEvUME4yNeuHTpQfFKGMXc0jg07/rCYRfcD5yr9ZLQ=;
 b=eQpkSfKb92z2iDfyxq46WYFk0LNIuIR+5TeMxpdoIGX8b8Au5+Sl/xu246TRJUFcGcqTNzIYPRzLZlX0ZFMKJSf0nEQPh6sFZ6z/j9YWj7RYcw3TpTBDA6U2PCQLvkXXBXnJ+al7j5fIHa8/RMXjsXg1PDBg4lRrjj+xcWhhteo=
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.31; Wed, 7 May
 2025 02:43:33 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::93) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 7 May 2025 02:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:31 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:28 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "John
 Olender" <john.olender@gmail.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/14] drm/amd/display: Defer BW-optimization-blocked DRR
 adjustments
Date: Wed, 7 May 2025 10:34:49 +0800
Message-ID: <20250507024242.1928299-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: f69948a0-d10f-4409-5725-08dd8d10f517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1izUZ5K3rETFN6wnNxKbF6pSEkNmL/pgFTaKvyxsqxExb5NLMy9RkhijbMbL?=
 =?us-ascii?Q?gOC07QNzF16AN+TsV9IJPdySKiNesKxbJzr1/balrR/H1VG8YBT83hMapWVR?=
 =?us-ascii?Q?1SY7KuuO9PN39KhpLKzN2XdO9Ydt05wtc6L3OBUrSQj8dvxRW2tkmw8yaltI?=
 =?us-ascii?Q?lqOraLeGMG2d6u8PtPDnzFwN27xzyrzf4UWPrhq6LLQ9DTyyvPLgXgpwg2Ip?=
 =?us-ascii?Q?5UHktPaRO2SY0Ji0NgHYvTv6a4a8vIwdZSEfYqPRLkGgRaQ7NaWpZZAj3iQ/?=
 =?us-ascii?Q?XqIp/SPAP6yxxBHGEd8IbWbV0CkrOfIz9ixswnV5rCzoM2z6TeEoTkKKh72Y?=
 =?us-ascii?Q?2YC9S/RqGfj0JpEYA9snQuA93IeS7Cn9/C01B0l2b1xg5T3mYoVFYGxZklZ7?=
 =?us-ascii?Q?utVpr1perhbL2fFt+d+esqE5D/ZqNa+qVHARarIUix1UGP+aPtQXfJxhtMJq?=
 =?us-ascii?Q?AKipcndTKuHbOlLyyEtQKYOEnBmWKMTN9mexc2lhOvswX3zLgi+M2GOXtoiI?=
 =?us-ascii?Q?4TmKfQxJ3iIqHIbWePYmBngSvTcC8qnsh0F5Agsaohk5Td+DsTsY+AFTrdMS?=
 =?us-ascii?Q?KfDck/lrhlf2pk04sfdLAhM5BkfA5EIdChhp/PXl+LM8wUNLQqdHj3W4bfTU?=
 =?us-ascii?Q?drFGjxBMPpRRjcRdPTMdjuElP7duUrtLJ/eSlqTQkVRT1glYowMi8RNoD45e?=
 =?us-ascii?Q?b5IWDDTDGQyeL4Av4Tw48TQBcwSIICSvWBVtl22oFmmP0qMPIIR602rye3UZ?=
 =?us-ascii?Q?ZjlHkyFrBI/8sxPYMAVDWu23BUgLCm73xS0gG7P95VlIdGAvj3RbFw/SWXhp?=
 =?us-ascii?Q?mymdcfSdQkAWrChVa0+Eeg9aRJBYtVLQwjynZiE0U+EJr28fZdXDh3CvQ3n4?=
 =?us-ascii?Q?22kjWcL8Vxbj8JQr3DxJThsibi25p72c6I5iap7qNF2hoKk6gKxcZiQF2H5I?=
 =?us-ascii?Q?COQ9qjPHSyRu1LS4WWe0+OdQxU7LMId3zKKtJIohbKRvZakv0QowoijwbcGD?=
 =?us-ascii?Q?mO/QsS9FKJfaGkxyrpZzy1d5BhH0BKrUYZ0/GZ/xz8IhJtsFUvNw6U1uzEPx?=
 =?us-ascii?Q?V/CNeR5PDtfeKuOlVz+a88DotlU3gIcIO3IBhaEfrRM0AlRmLI1BRcOg8q5W?=
 =?us-ascii?Q?4KNlOBvBXTsF//ccPCukh8bRFIjcS/Iv/BFyPNT6Ktstu5SPLNkUGJcUkoQ1?=
 =?us-ascii?Q?fQHkClpxm6QayZJZzV/XzGiiQiCYzPfXh4AsieCd86HsFtmekLFQZfgXDr6K?=
 =?us-ascii?Q?CODrvb/OXFjMDehMAaFKOqQbF4xWGCb33rkQP3k/RhHlLNnipQm13XmaMqSM?=
 =?us-ascii?Q?5QP+GMzqkmZL6xJ8tWDGnMgu7yrtFRqzUnoD0FmoFCTOBzG4NvoTq0HSbNjH?=
 =?us-ascii?Q?x77gzPJBp+I8Gqu7Z3+/sGR/xoF9Rf1rx7H9YmjWLWdywToTJC2DI57SANNF?=
 =?us-ascii?Q?PaDOGmp2nRSw5wMxGBRSSZC6qUgLfseXaha6il8fghq6/bi7enKs/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:32.6001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f69948a0-d10f-4409-5725-08dd8d10f517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

From: John Olender <john.olender@gmail.com>

[Why & How]
Instead of dropping DRR updates, defer them. This fixes issues where
monitor continues to see incorrect refresh rate after VRR was turned off
by userspace.

Fixes: 32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations pending")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3546

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: John Olender <john.olender@gmail.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 36c16030fca9..5a38748703b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -374,6 +374,8 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
 static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 					      struct dm_crtc_state *new_state)
 {
+	if (new_state->stream->adjust.timing_adjust_pending)
+		return true;
 	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
 		return true;
 	else if (amdgpu_dm_crtc_vrr_active(old_state) != amdgpu_dm_crtc_vrr_active(new_state))
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 528e6fd546c5..6ec22c0d5b97 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -441,9 +441,15 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * Don't adjust DRR while there's bandwidth optimizations pending to
 	 * avoid conflicting with firmware updates.
 	 */
-	if (dc->ctx->dce_version > DCE_VERSION_MAX)
-		if (dc->optimized_required || dc->wm_optimized_required)
+	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
+		if (dc->optimized_required || dc->wm_optimized_required) {
+			if (!stream->adjust.timing_adjust_pending) {
+				stream->adjust.timing_adjust_pending = true;
+				DC_LOG_DEBUG("%s: deferring DRR update\n", __func__);
+			}
 			return false;
+		}
+	}
 
 	dc_exit_ips_for_hw_access(dc);
 
@@ -3241,7 +3247,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
 
 	if (update->crtc_timing_adjust) {
 		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
-			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
+			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max ||
+			stream->adjust.timing_adjust_pending)
 			update->crtc_timing_adjust->timing_adjust_pending = true;
 		stream->adjust = *update->crtc_timing_adjust;
 		update->crtc_timing_adjust->timing_adjust_pending = false;
-- 
2.43.0

