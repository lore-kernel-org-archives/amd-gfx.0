Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26C9E77182
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF7810F07E;
	Fri, 13 Dec 2024 15:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVnQrc1s";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E68D10F07E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDI6UOwKUFCNIoVx1RnIuQkls8sGIKA54gYPirttX/qE8VWYPwt3Et/OvFPLwNDHuhvRaqvJBE+7wdCubGTKpz5IhdAuFdtL0+TxIKhY7f+bb1XkZqPHa8fpAyuTfqa7PjPVk4n22uYMSm+1UWoNSu9H1uh1tKuBDAmwUGs6gUYHeGl3gizemqOcurD4m3WZ1zzC81Qlr0iUoDyNKRpdIi7hAZRVwTminZCRQf9suZD1OsPslNm1pJS9/kWFr5+krFIrC/NT49Nw3fllljH5eShzlLgPedFf08TWW+nk82DFweFajXhufjT7Zwky5iwyqv02O/0Myytuw4xmkW7eXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUpL4ObjJr/qdds+nwQd9me5b7Nn5XklwN6pzrRkz3s=;
 b=m5gvX6FJHdfFElWNpifpmnTv49Bp7NZpZeqwN0dIQLanOxsYWF9XOlmGnDp/MvHLO4hf4ebl0+ZNSaSgjjkSds0C5hhkpqXjlsR8ZMcnJ9jvtT1vDFJz2VPsuKyXGO2pYVv18UyG4Y/4Q2jZ3+a4kjt8bvDZuD9CnLqdOacJXkOPKAhkzV43ciNyYrCaC8YdNoskj5x1Q2/lYHZUP3Q2+ycA0n1FmRmHRqNbpSdlJCaWCIJhiSowuJ4eAANGPx2C8tgZiDX6eRhe8W8jhzeadqJgvXHmkteGiovXn8Jvyw+etPbhIhBjtu5aDXjtqlwDJwKxeHdd9lftRW/pMrhTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUpL4ObjJr/qdds+nwQd9me5b7Nn5XklwN6pzrRkz3s=;
 b=dVnQrc1snEgwTYf7MOqfobNt6pUsknXgX20jx3GH6YBPhpV1zSb0fpUO1nzwNnGKv13fEn2xue7i+dYkOtFfC4TRsZs/MQuzUAMmHmYDFABx0IzeA4/BfDi+q+mpPHXrKO02MO2lcrisgfdJskmASyO4xhVadrsCx7neJorqP9g=
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:55:10 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::bc) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 15:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:55:04 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Rodrigo
 Siqueira" <Rodrigo.Siqueira@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 12/17] Revert "drm/amd/display: Fix green screen issue after
 suspend"
Date: Fri, 13 Dec 2024 08:52:44 -0700
Message-ID: <20241213155405.393252-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5ef9f5-4c41-4cc4-7e5b-08dd1b8e852d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BNPRCb1MVxt8yZCdft874sjbUbfjFtGumz90yPMmgsV8KtH0NftQLxJz3+Yn?=
 =?us-ascii?Q?EhyFuwzWcgQjz/A1/I78IBhA/tQYY/Y4dk4/zbaN8AnFKbYUImozhhxUA6h9?=
 =?us-ascii?Q?CAEbXHsuZ8CL9xkOSrulblqL/+GRnP4wP0Eua+7fp6O8ok0IvmlfovNvIHGE?=
 =?us-ascii?Q?j8bOQ0e2yK5eq2YDf+eYSCVqPsDbNZQRTmSBF6W/TIWlWSDrVGRJF4ORly+F?=
 =?us-ascii?Q?4V3MHdVMyKBKOIFlGL1iFNbALscu9y6hV472TD8vmYosTIx2LXCFMoF7Xw24?=
 =?us-ascii?Q?KcOYLxuBCH/qT40trx4SFrWIQyfdxmx0hhLijJdf9/39Sb7i4vqDkQBv22Bz?=
 =?us-ascii?Q?02GyONdgAMHVTdQQfJT58D5yvqdsBj23XQRbrDCe0KNYXPtvPXrhTcTlTou8?=
 =?us-ascii?Q?jShCSS0a5O2ZZu7XfS3OY4PZQ5EcO/0SX5BwcgV+dhG4Eh+OPmQvIwvAJPRq?=
 =?us-ascii?Q?0lCLff4Zdrcw2Ec+kvai4x+7991BLQ6biU6MFZc0WcRmiDcIM8Qh50LbN2/I?=
 =?us-ascii?Q?u8YTKaP5o000sQ3sMWwRHjIgwjAe/vwWPnhBMfTQzPguLNnGKB+cKhzHHKZX?=
 =?us-ascii?Q?TSZK6pHlJuBHNdb0F4q78amiOCQJrTyKKOyTDM420HfHDS20E7WKTNcVCJ5B?=
 =?us-ascii?Q?zJXAMCvIInlFt8GbDtyAk9A7adoldnuL3sgOU0CuAbRlcTuieUIrhJGzwL2m?=
 =?us-ascii?Q?LEvrB8nRfqHYOtjjmphQmmDUEi3CyZXzGUfNBApg+RVtzM+ipDNhMsdi1lwi?=
 =?us-ascii?Q?JyYIfO8MicInjyzOuEvGPtl/RhTEcX8Yw9uLk/bk04MB68jMmrZP+3oePaa6?=
 =?us-ascii?Q?Hi9krVUnx2IVrXoz2qyQuaR3rMptWx3uyt3TpOI1Ci/Bj41Zfp0kbk9h8x50?=
 =?us-ascii?Q?IxI24ft8u2W7o2/+cn9EDI7e1dmC34s20ubhLUwJ5wvMVNatiJOiXx+O2QNq?=
 =?us-ascii?Q?ha9rggDHM3rmlA+Z4jdfo239JZJ48/yBYxvpB4uurOE7Ikpu+Y5Xc0w324Oh?=
 =?us-ascii?Q?SNtvuD37I/syb/uoLgubl6n/M23v+vW7M9TknVMMoVZbh3iJVjtgQgbJZt1m?=
 =?us-ascii?Q?xJ9vFdxptc1HY2eXdTaoObCOYigRKjslsCxX4sc3OPoJzYMMh+cC3be+3Qit?=
 =?us-ascii?Q?JkfruNhIzcbQq9Ef6y1UTAu4FvFLjgfWnf7oZipOUGo9w+YLs/DDizJ9cS/L?=
 =?us-ascii?Q?/45NRAdbQDOAf/LW+sSWpIByceoUkh+g7Hkkgh+FDX/SviONNNWVjcwWldY/?=
 =?us-ascii?Q?Feh5g43u6OHEXRqzU6e1JBfuM9jL+r38u+H6bxxgZPegysjwpq05W61pqgyV?=
 =?us-ascii?Q?1iOhU1nrEFYjoT6HWumnOmH6R4h0FoGTXc7tLtcTwIGJ54LoZPksYGtM0HTz?=
 =?us-ascii?Q?c68vh4udopobzw8BFB5WpCaPSYQwb5mjxZTXCeTsgUQx1UhuYc5TKrx9A4PC?=
 =?us-ascii?Q?yCVnq+ypm1aNQ1F7k86zNUJ14VwH5lcy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:08.9510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5ef9f5-4c41-4cc4-7e5b-08dd1b8e852d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

This reverts commit 87b7ebc2e16c14d32a912f18206a4d6cc9abc3e8.

A long time ago, we had an issue with the Raven system when it was
connected to two displays: one with DP and another with HDMI. After the
system woke up from suspension, we saw a solid green screen caused by an
underflow generated by bad DCC metadata. To workaround this issue, the
'commit 87b7ebc2e16c ("drm/amd/display: Fix green screen issue after
suspend")' was introduced to disable the DCC for a few frames after in
the resume phase. However, in hindsight, this solution was probably a
workaround at the kernel level for some issues from another part
(probably other driver components or user space). After applying this
patch and trying to reproduce the green issue in a similar hardware
system but using the latest kernel and userspace, we cannot see the
issue, which makes this workaround obsolete and creates extra
unnecessary complexity to the code; for all of this reason, this commit
reverts the original change.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 22 +++++++------------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  3 +--
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3407741152f7..4f0267b2d5ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5524,8 +5524,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
-			    bool tmz_surface,
-			    bool force_disable_dcc)
+			    bool tmz_surface)
 {
 	const struct drm_framebuffer *fb = plane_state->fb;
 	const struct amdgpu_framebuffer *afb =
@@ -5624,7 +5623,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 					   &plane_info->tiling_info,
 					   &plane_info->plane_size,
 					   &plane_info->dcc, address,
-					   tmz_surface, force_disable_dcc);
+					   tmz_surface);
 	if (ret)
 		return ret;
 
@@ -5645,7 +5644,6 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	struct dc_scaling_info scaling_info;
 	struct dc_plane_info plane_info;
 	int ret;
-	bool force_disable_dcc = false;
 
 	ret = amdgpu_dm_plane_fill_dc_scaling_info(adev, plane_state, &scaling_info);
 	if (ret)
@@ -5656,13 +5654,11 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	force_disable_dcc = adev->asic_type == CHIP_RAVEN && adev->in_suspend;
 	ret = fill_dc_plane_info_and_addr(adev, plane_state,
 					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
-					  afb->tmz_surface,
-					  force_disable_dcc);
+					  afb->tmz_surface);
 	if (ret)
 		return ret;
 
@@ -9099,7 +9095,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
-			afb->tmz_surface, false);
+			afb->tmz_surface);
 
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index c10cabb8b42b..1ec4e4b9ea94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -310,8 +310,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 								     const struct plane_size *plane_size,
 								     union dc_tiling_info *tiling_info,
 								     struct dc_plane_dcc_param *dcc,
-								     struct dc_plane_address *address,
-								     const bool force_disable_dcc)
+								     struct dc_plane_address *address)
 {
 	const uint64_t modifier = afb->base.modifier;
 	int ret = 0;
@@ -319,7 +318,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
 	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
 
-	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
+	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
 		uint64_t dcc_address = afb->address + afb->base.offsets[1];
 		bool independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
 		bool independent_128b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_128B, modifier);
@@ -361,8 +360,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
 								      const struct plane_size *plane_size,
 								      union dc_tiling_info *tiling_info,
 								      struct dc_plane_dcc_param *dcc,
-								      struct dc_plane_address *address,
-								      const bool force_disable_dcc)
+								      struct dc_plane_address *address)
 {
 	const uint64_t modifier = afb->base.modifier;
 	int ret = 0;
@@ -372,7 +370,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
 
 	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
 
-	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
+	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
 		int max_compressed_block = AMD_FMT_MOD_GET(DCC_MAX_COMPRESSED_BLOCK, modifier);
 
 		dcc->enable = 1;
@@ -840,8 +838,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
 			     struct dc_plane_address *address,
-			     bool tmz_surface,
-			     bool force_disable_dcc)
+			     bool tmz_surface)
 {
 	const struct drm_framebuffer *fb = &afb->base;
 	int ret;
@@ -901,16 +898,14 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
 										 rotation, plane_size,
 										 tiling_info, dcc,
-										 address,
-										 force_disable_dcc);
+										 address);
 		if (ret)
 			return ret;
 	} else if (adev->family >= AMDGPU_FAMILY_AI) {
 		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
 										rotation, plane_size,
 										tiling_info, dcc,
-										address,
-										force_disable_dcc);
+										address);
 		if (ret)
 			return ret;
 	} else {
@@ -1001,14 +996,13 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	    dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
 		struct dc_plane_state *plane_state =
 			dm_plane_state_new->dc_state;
-		bool force_disable_dcc = !plane_state->dcc.enable;
 
 		amdgpu_dm_plane_fill_plane_buffer_attributes(
 			adev, afb, plane_state->format, plane_state->rotation,
 			afb->tiling_flags,
 			&plane_state->tiling_info, &plane_state->plane_size,
 			&plane_state->dcc, &plane_state->address,
-			afb->tmz_surface, force_disable_dcc);
+			afb->tmz_surface);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 6498359bff6f..2eef13b1c05a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -51,8 +51,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 				 struct plane_size *plane_size,
 				 struct dc_plane_dcc_param *dcc,
 				 struct dc_plane_address *address,
-				 bool tmz_surface,
-				 bool force_disable_dcc);
+				 bool tmz_surface);
 
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 			 struct drm_plane *plane,
-- 
2.45.2

