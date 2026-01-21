Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520E1C44536
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E617710E891;
	Wed, 21 Jan 2026 22:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hgBCgOCW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F5610E88F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7XKkMdVfFZgJ4opHTPEMpFh7On/zmqhEPG3ZEOZ0vKAabMvH8qrqosbVWiF3MKvcIg1AZMF4OCzeUL4v/BowjNOPj5N4SrIkH39x3S4KGc+hedupFx9u53qR6crH2jjJkuI8kxSskipzR3+Uab1NYoLlUvUUTGJt0NqfdlvTYW7J+vWq4st2uckurkALU7io4UHpTZImvMY+aycrqBupVrRwisiQG/eg/XGfHqMQAMUfwH6snzlDxQq2KJKjTjT7K1m1+KVaJ15fnh9R41WvUv98vAQXoudCAUaDvCUe1i7dT8QvpBI2aYEW3tn2s2kiayQfS7W14pYSRlUDfv47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKaicnpXzVFT92eL98NMKhu2I6GAEJM3V1sXLZ8eqYM=;
 b=CNM99FNBvTuXsZ5opcgMO1tyYajDVcCfeJmpNkHIAjswZ8OQ/ZfOIqL5V/7c+d6gXtlKP+1Bu56pEnAGcgTGG6R1TxSxSiKud5yvyD2OHNc8F2p2UVAllY0oOyvYpI+aM6C10a265pYO+GW4NMaWHatyhnbEVG4mxeqtU+SIbyLaXLxodZ6FMG9HF+wOU5IfMssMmuljchTevkU+ZRGr+J7D/7ssPjn1CggaJthWGiZG23+OiReB8MIzqqGi9tybQTi5hOHnlvYhQcmnltQS28Uq0XNUo2ZaiMgzylmlFEterE82Z2ShxIqnGugeTMmMLqx4bN//7TYOEY7+3jJB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKaicnpXzVFT92eL98NMKhu2I6GAEJM3V1sXLZ8eqYM=;
 b=hgBCgOCW+dlah36fRibsnWXRDQ2NrReBwUqlMjhb/ulox2TltnyO/F2Pg2C1OgRMDtuWJVAC63zeXJzpCX2Z6sI1WjuN7wA3IBrPJFBfYitQcNoDgPhetUyeGyzCpRl+o2l6t2bC7pfwNfy0wbSo4ZTt52M2PCSaEBV+9OHZ6xI=
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:01 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::c4) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:32:54 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:32:54 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Fix GFX12 family constant checks
Date: Wed, 21 Jan 2026 17:31:38 -0500
Message-ID: <20260121223247.186241-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c807e6-5b03-47cb-d72a-08de593d08d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8uu/a6e+VIZ6qPZ/69v3jZqrf2uGNnWgQ6unfKTPHoCaEVVgHrB5OsT/ks9?=
 =?us-ascii?Q?sRwQiJ000HrM0dtWqUj28fLlBXeXLW2Snbsn2UqSHZhj3PmiwexvdTsukBP5?=
 =?us-ascii?Q?Vprf4zkhXER7HgcrjNbzEzjD7NyXVWIUDyprNn1E29/HBEsLEe54HgacD57R?=
 =?us-ascii?Q?zN9fAUic9zz+60FK9TivjH77DvMNn6xbdSh6qLW1DfM7LAHOxSLnp4p777yD?=
 =?us-ascii?Q?0Fl/+GwmNObmqWTEDdP2XALM+rLkRbmgspKN5xf+RolZ1VFHaZprTg+nsNK/?=
 =?us-ascii?Q?1wVw+m/H1wWKrj+djEc6vBXVAo3E+BFzGLjh+Y9WH7PF96QKpQzGZWGGYWAE?=
 =?us-ascii?Q?z8Bm42M0duyK7C03kJbgl8YEzAFd51dDTQvHCBHntIdMBaoV0wqkCuBA4VuJ?=
 =?us-ascii?Q?HqKcpLx7WUgBmE2H9MKvuNF749slDhKcH261yoVOuffUkdKzUElNUb1niikY?=
 =?us-ascii?Q?8uWmZqa6Pxbfx5OgiCan5wE1/YCELGsvPO9Ci0NR1ftLplcYtXW6gc0P7/gU?=
 =?us-ascii?Q?HvJUtaasTorV+rR2vz4k0AjNK7fLFd/H2d7yWjhAZS/P7X4RbRwxBtR+fp6+?=
 =?us-ascii?Q?BirLNsL8YHQ9/C8s6X840i0k5g9Uf5AE7BcgCZ+q43hoVNoB/4pg/KaF44cs?=
 =?us-ascii?Q?EQhOT9NlLg78sFpiWqD+Gkg5GT4ZwbJLhuBHYqVOB67BrLubTfNz9IdYzinS?=
 =?us-ascii?Q?8jVG6RWczZ25yavMr/YsllIZx9PaWznCqrw50QWfQrojmKVf/0OhFxCTI/AK?=
 =?us-ascii?Q?AM1HnnRQKJqJcMtglkaIb5o8AZAe91A4vjk/fVUEpuZWraX1m81m8JAM+fUq?=
 =?us-ascii?Q?45iV8o4ScqTW4SYGUOJzR+VQdPbt/tVO7Rr7zcwfaH2U+4iH0OnB0/qctzL7?=
 =?us-ascii?Q?efbIKnM3fPVGH+qUMgy+vhaW6EN+Bb3fwuCPGGs/x0BR345iUypFxqkGvTmZ?=
 =?us-ascii?Q?IPFjzvK1e1Km8eiGJQiuf+4rhHVPT1WRAFPYC9DZ/PBBQqVJ+rgjaerILrcl?=
 =?us-ascii?Q?0QMlBLh4d0j8grYr5gd3BX5NZEhS+s0WpOL5kGbFjqYyHks5KDY+ZLg7StE8?=
 =?us-ascii?Q?7++DXtKO2DAa1dpX+KoIBzxZGaTKeyD+5/VAtfuaJ41MNtHvS0N6CGSpHFTb?=
 =?us-ascii?Q?d16lxE1cc8o+/IUTSRpuj1Hf8hBV86UAAJXbl5/z4+/C66e1oznwzoadU9Sw?=
 =?us-ascii?Q?r4rapblw0twnDR8ee93XDLOv5akDdkK4lIx87Bj8rgvWgEwyhX+TfdtCfwLD?=
 =?us-ascii?Q?MWhYUEv9VQ6gC+E8mszSkaarANIH8RuoeM+7r83dy/cDFOMa/A9KdD9XRONi?=
 =?us-ascii?Q?dQHHI/6tDFsGBbKDpkRSgHnRE0Zunr80aoI0RNUiIhTB1hkKhaJx3TMMh6C/?=
 =?us-ascii?Q?6Nw0utUs208loyQlq5GZV+HubKGV2Rly9UUvlMKCV1u75vYdlES8TlLWv7mx?=
 =?us-ascii?Q?171nPPupHFHXnPd7sZjC7/kPdQhYDMG3jmaesoZgV3q//ljuAjY4nhh4OH0h?=
 =?us-ascii?Q?QfwqYlVL2sCSRWGPyAU3SxPlrufF629Z/iMwt9M4DMIu1HYeNyPOCDPLD5rd?=
 =?us-ascii?Q?rLrxAzQSgmb59ABT0wDFsK3BOn0aVBMssaA6GP82s4qWUbP9Hzr49lYlNSRB?=
 =?us-ascii?Q?qOVctKKwLbI07xTBS4oYKswJmxMnV4EbA3YOx8AfEPH9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:00.8861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c807e6-5b03-47cb-d72a-08de593d08d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

Using >=, <= for checking the family is not always correct.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b4c45ac3c05..38a8ec694fed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11842,7 +11842,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	 * check tiling flags when the FB doesn't have a modifier.
 	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-		if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
+		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
 		} else if (adev->family >= AMDGPU_FAMILY_AI) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 56cb866ac6f8..5e5e1382934a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -277,7 +277,7 @@ static int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 	if (!dcc->enable)
 		return 0;
 
-	if (adev->family < AMDGPU_FAMILY_GC_12_0_0 &&
+	if (adev->family != AMDGPU_FAMILY_GC_12_0_0 &&
 	    format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
 		return -EINVAL;
 
@@ -900,7 +900,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			upper_32_bits(chroma_addr);
 	}
 
-	if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
+	if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
 		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
 										 rotation, plane_size,
 										 tiling_info, dcc,
-- 
2.52.0

