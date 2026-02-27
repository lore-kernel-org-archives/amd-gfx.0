Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A223FEFB7C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 19:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE8110EC14;
	Fri, 27 Feb 2026 19:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j9eh3+sH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F4010E1A5;
 Fri, 27 Feb 2026 19:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mhk4vQeFKjMxUAdvDUrOja/16Y3WDIiCd7SvUC/j7kHnpTCqi9D6rats/+Tl19wbjM37NlBRIYsm3bcPqd5PEmDIA/RGMKEsYrjumb2JiDdH4+THRmkdC2vEMsPuj3ElWj7flJHRAAXrZ6AKJ3PexRJcZzL45bdEcezdGmMQ1K/WtAEUrvNIz8wf3F96DNMKJB0iKp6LzCJ5U86GqzTT58TF79UFyDzOUlej/LC9OCcNNCfgzATMfXTCrG250kMsWhJSIzISM4uVo70yw6UywWQ1jDMkt8TQNMRClzUhiJdc9qrzUIRGmuvdx4sRqi3EIsmcC7VnvXBK0zs9j+IHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhV57elcP3VcrAjYCpBCBIT6E8IiEoqpfjcpr6kq7iw=;
 b=l/TgCrH31aLpgAIoUnYF50YJYexGDrKyQStu/rwTbaD4hSWKlWeZ8Hdy0tkt6D0FpNpuY/uq+U+bdm9393SjqNQUqmYICt937R2QNxsh4YOC5VIVco/cBosNC57KX69i59HhN7qFW/2kFb5XMck/tTPvTRe09stqkaA1hapTnqKYKPSpjgs1jpaVd7zgqlKTn3StIwKQl7qHnIKgET4zjlIU0ROapApWdvDPvNf9C1dgquMr6bL/3pMErJE2OEB7qNuUAvJwEZ3gmzC+oUYiOVdzhRewdbqlKpSod7KaJUQ+H6jFn6G8dcVE7MLix8FxIrXi8p9eYWfhMEF4soW7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhV57elcP3VcrAjYCpBCBIT6E8IiEoqpfjcpr6kq7iw=;
 b=j9eh3+sHn5tUJELtgzy2JjWv58E81g5bpN3mRhIDE13W76BvQxE9yEFmJqXpfWk5qrjNtUi5BC9xS7dx0xFvZesw2m4TFg8RubAdvkkIp97nkHME4MrQCSqVIKe/+Nh3mfDb9BvNwq7uF2wYaZoiMhC7ypeMG77nWAfN4/rb2+Q=
Received: from PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::39)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 19:26:54 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132F4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 19:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 19:26:53 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Feb
 2026 13:26:51 -0600
From: Alex Hung <alex.hung@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <siqueira@igalia.com>, <christian.koenig@amd.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <alex.hung@amd.com>,
 <contact@emersion.fr>, <daniels@collabora.com>, <mwen@igalia.com>,
 <Alvin.Lee2@amd.com>, <mario.limonciello@amd.com>,
 <chaitanya.kumar.borah@intel.com>
Subject: [PATCH] drm/amd/display: Use mpc.preblend flag to indicate 3D LUT
Date: Fri, 27 Feb 2026 12:26:04 -0700
Message-ID: <20260227192604.1377163-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 733fcfa8-c436-4bf9-0d73-08de76362a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: Xe9jiVhWxQpOOqOBHRPgzS9j1RZeUVegXcVb22K8GB1W+C3VC0C8r9BMm0xPNukR0SBP0AY+ot2BrIJsCg0zT9EfdIWNInF5W0rp38Yb7kuJFS7EqFHd7R2OpHsi/J4gkDAlDskFF8Bl6fPKvEqE+UtQXrxjhgw+gpTzSityy3UNUmuqdFZIBwLGtCsVhQPncsclEXxchH2m6mtTUJkqNj4np28ec4VsPsuSxbCeChW/EDEcs7rDK0Atojd+XvqsuXcwVEz+ttGSiDMJEnnL8QfKitq9je272REg7/pL5m8NcM8sbN9rrJndwSd5GrSNe3AvxqIlRmVHlgxenXweJ6gERdz+tdP2o9JmmoXi6KLo1p6w6WPlPZybzPolkp/qy90d70P5S48eCMKr7AEE2Uyck1EEYXQoKOYCRgXRSiG6AcgZ7tqRapl4FgqyuKcDnFRC2XU7W5OA8+nMR3pEgg+l1rhEN0J4H9tAuScDu/iMjVJh4kEchBUFzG+G1djcb5/SstMc/BnWlW3cA2Ph65ocU5OGzNFjajX+dhwzLIU02gBJVexe6JtaDPpwpyjQs2YiFGX4MG3RtRe9tZV6ZIpD6tHBumu9/hGUG2vJRwLm3gbXrYEtaEY5kyoLvsfNsxNB8BD5UOpAYPBp7lR2Q68WO6qaQlNwdbxeexghd7o9JjltFUf8vVM645HwKDQLtMk1GPQnjaE7/fKvy0+kmi8m56hEHJjhNoCYWU1EZuhGxf63b2IYrAUHNUNkQM1AqhyTqENVfhAdypYG++QqxE8mS3AIVLgb8m4UFUHewH0GrVqxG1tGts6mDGpkhZxQNWmKWlL3wD0MpXAr+3yt9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +maPjzTPjoPqEAPrPyVcEwYDfLefYwfKHWVAh9OPsR+r1dZYfAJib/3pMvVPID5jP8In2HzrCgEsO1IsI22ZGG3TdX0gMw/+U+3dUMxeJ3+Odihb9MFrGINrHAJszw6ne6C15F1w/eNodzHy6DK6B6jfW3zxJFo4XPXbwXH/25xjYm9s0KINSOQh+9B8Lv9pKV5/eV8eVpPlbaBb7EKnfvqrVkGndaY3hrKDSAZh29+zV2W0CW/poPsxPiPoKIVELTf7sk0KNiUSHwcqeTxcnnCpo1LsGmSBmemadCG2DhUiaYeV03bQMeWo4tAOW46IsPSAWV/zhvqJJJXfmuQmmlrWN66S1XNceqroolUO63hTIOH5E8fdmIrk3GQSvbmcFb1B7nPLRU37/Tad5Vatm5fhsl9fbWOhQXZxR+/dr60vtJKFJxf3l1i5fjOAD+38
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:26:53.8088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733fcfa8-c436-4bf9-0d73-08de76362a0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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

[WHAT]
New ASIC's 3D LUT is indicated by mpc.preblend.

Fixes: 0de2b1afea8d ("drm/amd/display: add 3D LUT colorop")
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c   | 6 ++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 2ba98f384685..cd1e58b8defc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1706,6 +1706,7 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 	struct dc_transfer_func *tf = &dc_plane_state->in_shaper_func;
 	struct drm_atomic_state *state = plane_state->state;
 	const struct amdgpu_device *adev = drm_to_adev(colorop->dev);
+	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	const struct drm_device *dev = colorop->dev;
 	const struct drm_color_lut32 *lut3d;
 	uint32_t lut3d_size;
@@ -1722,7 +1723,7 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 	}
 
 	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_3D_LUT) {
-		if (!adev->dm.dc->caps.color.dpp.hw_3d_lut) {
+		if (!has_3dlut) {
 			drm_dbg(dev, "3D LUT is not supported by hardware\n");
 			return -EINVAL;
 		}
@@ -1875,6 +1876,7 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 	struct drm_colorop *colorop = plane_state->color_pipeline;
 	struct drm_device *dev = plane_state->plane->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 
 	/* 1D Curve - DEGAM TF */
@@ -1907,7 +1909,7 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 	if (ret)
 		return ret;
 
-	if (adev->dm.dc->caps.color.dpp.hw_3d_lut) {
+	if (has_3dlut) {
 		/* 1D Curve & LUT - SHAPER TF & LUT */
 		colorop = colorop->next;
 		if (!colorop) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index f25c0ede7199..d59ba82d3d7c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -60,6 +60,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
 	struct drm_device *dev = plane->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 	int i = 0;
 
@@ -112,7 +113,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 
 	i++;
 
-	if (adev->dm.dc->caps.color.dpp.hw_3d_lut) {
+	if (has_3dlut) {
 		/* 1D curve - SHAPER TF */
 		ops[i] = kzalloc_obj(*ops[0]);
 		if (!ops[i]) {
-- 
2.43.0

