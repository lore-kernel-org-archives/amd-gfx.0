Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2034D597AB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 21:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D6D10E66C;
	Tue, 12 Nov 2024 21:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="teqgm8yd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E1A10E66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMH92RnaK88PGL54HpQBtC1fKyg1zsvLhjlfEPks/UeYBJWgEHqbrvp9XYesYooxg0BJ0ZqMhC6D5SPo1Yg7oJWqN72HgKcJ9i0UWgFx6sutfRUVPqt6gNCx/7vDFiPyV6Ui7ZoCHXmE7yY/niOGclaRNF+dLtThAwvRbjZbFvdnUl4ZboLd9gRBTxN3mMeVsyOmtVX0IRDdgwVu4tmPBhxkrR/IrHjaHvCYbzv7C29AoVk+uAj/DT+joZo0u1NTWu4V5/MiGdz+EG21xkyimmryGdl5xdbdg3sdr/GSjwbRhrjJUdHLRB7WyuZIj57lDtnbriYVS54/TLcQ5+dzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSZUqwp4gAKocWGM4i2mREjlSKi2tURZuZ47d5DoNPI=;
 b=W6jcdpiaTcM8Y1b2vUP3EaL+oUPtfp++NMIzcA7muNAHsH5u4bcjS4v05uyEL1DeTg+VfCL97EJ2nNpVTtEdB/5jKwesCRXIZNuC3panZoMNE7mEHAuu8kt2qDpMwShzB3vJlbZNWYlVQmCTusHS3vuOLG2cDFB/DKv8QaXk7rpTMNpvLFAzu5Yk4jDJ7C1HcegASYZDjkWESuYHcFy3I7NEF8+MLvYWZAyzxCarC9hG/jjVvN4r3rzYGXwnNtSdcTB1osETezZQeeVLaACOFhgudRxPfkvqHS6zfqFqSrMPNzOp+k+yuCeODFcTSx2R+Hq27FwNMr63bf9r1oH/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSZUqwp4gAKocWGM4i2mREjlSKi2tURZuZ47d5DoNPI=;
 b=teqgm8ydHUkqC+a3fXVdfrMXnp81p8ursLHrmsQFJmlk0ruIKMeeGglA8aXAJNH0x1kc/hX5/6mN4VeHNAWURxuAPfANxB1B3+mhwGgCqt+LkzSwkT5gpTvAWmxjQlEnBPZe660SP+BCk4NNjAW79yAwmDuoFLbDXdeegbsPwvQ=
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 21:37:38 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::dd) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 21:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 21:37:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 15:37:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amd/display: add non-DC drm_panic support
Date: Tue, 12 Nov 2024 16:37:16 -0500
Message-ID: <20241112213716.49355-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112213716.49355-1-alexander.deucher@amd.com>
References: <20241112213716.49355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: e6aaa888-9a0c-4768-033a-08dd03623ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yBe3fLcBAQCnc3E8ENXWNCRvGEhJRngLdzwDGeBMQRv3txSeKY04oLS+ZC/E?=
 =?us-ascii?Q?k62354AEVIbrXka62mNWT0Vz2mnfRy3pDJkBijYEzS11P3fRMguNQeRR/Rbu?=
 =?us-ascii?Q?UTtbCtvTGAHySTp/qIX9xTJizTjjwYNuUee1RENbhi+QtOQS9xw9zWJfboOK?=
 =?us-ascii?Q?xuBj1pjGgUUtHPOWQ8MvTbnhWkgM8+B6uSrvLAdYDwb2fl0eubmJQ3WE7ZPi?=
 =?us-ascii?Q?xgvTA7iPuaKmKBDllqG9OvPk8IV7OTuzGHbKdGjkwT39AHk5PnL/GsIUORpO?=
 =?us-ascii?Q?6MZAUKvaZx0vfdrWqOlDVE12uCxD1l1Murhy5T2R5jvQYDVkXVrtSL5akMTr?=
 =?us-ascii?Q?SdpPFr3iZAIb9D/2Z/qZhZFLLeRpKJv/SYi30KmO+t5A7hemCoYslUmKLZ/x?=
 =?us-ascii?Q?P/ub25Gg62cshMOn94dscS55RMvC/oBoglwpHhgeG2UqWFalnExP7An+AHNL?=
 =?us-ascii?Q?dxiNRJn8wtkyQ47zuXuQxpFiYaAWC7yjptYbNWIq1sVxod5SWPD7xOaa2LNm?=
 =?us-ascii?Q?E16Z88A6cUf+tjfiYee+J7DFTh/LxdUZY5dUdq8n0tatdmdOUhiqcQIWl42f?=
 =?us-ascii?Q?8Jui0ZEy+XBV/EA90yYCed2Yyt/vEqTFYn9M8xWXOb3HLFUFbO1j8eSWYMuY?=
 =?us-ascii?Q?bXc8K/m3krXcUDN0O8iNtAWPtNLXG1ZYhtUGAgaRqBvnm+GkOYKFBh6Dnh1T?=
 =?us-ascii?Q?KnQiVShd8GrFneMPUstgbFzBfmFngh655AIi6nHL30gu4qrNofrCL6ZFmB3r?=
 =?us-ascii?Q?KfhdvsTSwhc4NsddkB+43lhnZ8u8eUySKY+kpHfbpWbuT9bKIIEgOiHdZarU?=
 =?us-ascii?Q?6YeZ4Mau+R4bMXEXs1hn74DZdmXikKrN1cyYVaadItJ2U6sYcrUBrh0M7Row?=
 =?us-ascii?Q?zZCbXadV98dox3I6Qm3SDc2wOLwRGMQpx+6pQ4CjbNxvsOM508OHDUj9orko?=
 =?us-ascii?Q?quu2nyt0E91CH7FhkvLK+a12h+6UFQboWEouPnXH3stJm5ic6bP6lXMMqa+3?=
 =?us-ascii?Q?xN9Ebm4YxZnSU0LIQPABbHjKFT74XgMI1LDIRSV/sVFjM2eRqDwzCCKi4uG6?=
 =?us-ascii?Q?yL5cVnKGfS5l+QLZNPg1sUXFOo4udBWWwxjceDfvvGU5mgmgD6GwvQIjB0i8?=
 =?us-ascii?Q?yhWQtR3cqlA2P00p811rXdWVhO0MRhzbuY4FRucnzid1k9UzpiDR3Kr1DtL3?=
 =?us-ascii?Q?xK90Oonk+BU1M5dZ4Xo9sOcXM1qF2iQA7m9v5AK7PnRvwnaJLgztg6XR+rx/?=
 =?us-ascii?Q?axYjPY3YsKSkRO0qFXwJRvimagYcXTnCMdVD/kIytCHgGwptLQrQFvKhK9VD?=
 =?us-ascii?Q?KZpt7GzWIlI7IutzG0RWrXZdeqCw3QoOHY/Oz2p2udyZ00xJMreI9epsXEtR?=
 =?us-ascii?Q?zPcw64KSekL6iCcfZBNVKGZwFIEXTjuOs+ih35C2foblsrBa5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:37:38.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aaa888-9a0c-4768-033a-08dd03623ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

Add support for the drm_panic module, which displays a pretty user
friendly message on the screen when a Linux kernel panic occurs.

Adapt Lu Yao's code to use common helpers derived from
Jocelyn's patch.  This extends the non-DC code to enable
access to non-CPU accessible VRAM and adds support for
other DCE versions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 26 +++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 8bc997b66424..c5e3d2251b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2687,6 +2687,32 @@ static const struct drm_crtc_helper_funcs dce_v10_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v10_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v10_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v10_0_panic_flush,
+};
+
 static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2734,6 +2760,7 @@ static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v10_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v10_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 504939e3c0c3..ea42a4472bf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2800,6 +2800,32 @@ static const struct drm_crtc_helper_funcs dce_v11_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v11_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v11_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v11_0_panic_flush,
+};
+
 static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2847,6 +2873,7 @@ static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v11_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v11_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index a33e33743a93..915804a6a1d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2602,6 +2602,32 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v6_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_ARRAY_MODE(0x7);
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v6_0_panic_flush,
+};
+
 static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2629,6 +2655,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index aff58d56864a..f2edc0fece5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2613,6 +2613,31 @@ static const struct drm_crtc_helper_funcs dce_v8_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v8_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+}
+
+static const struct drm_plane_helper_funcs dce_v8_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v8_0_panic_flush,
+};
+
 static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2640,6 +2665,7 @@ static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v8_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v8_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
-- 
2.47.0

