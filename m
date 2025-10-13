Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428CCCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 16:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE14B10E494;
	Mon, 13 Oct 2025 16:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s6gzfOFc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7819A10E494
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMXJIJ2NVuBFShXQExjzbuXsQkDeTFbkrWakQkDvwNdBdgnhpS29Syj9lQjjs6dlmwZuNR6uLXYKe9Qpbd2kk3mYUjMHxriLxQIZbSo++FexB3nzuNrp73YMc+BxbZquYFLT3jrzyJPGlL7nIrEvnoP4P1gQW0TtD7MUI9/rjUMnJaiA3YKmYDpnLcfcbhfj30Xq8ngmMegHzDRjAjtB4ypqgvBjLkkigQ8bATytpb9jgN7JsLsc6u6RLJRU/oTZdsjisMpJHzYGMn0HMBLgkGp4uWd7xWIYeoq99UzvHNRfkv+dqLBpfE5K1+81nZao/pIUeqHMXYelxK+c9UQryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfVHkqL3nhhsukZ7/P8hz6m3MpYTYflwnTecmRC6q84=;
 b=Ge81s1hG2rFMSwXR8kY/emxAXh3uCtENbnpnDqY/tvMuqezq7iTRgOE5/41Qlob5j8VDvkbcRT4oiHPqrOP2zVR0PgO7WoNqy4piGg5xKWBwmwxhcfWUnq9iPH/LY2YwYSQVY6hvsAPq13uo2gHJ4BnID3ktbbUVhv4LMn0gh3qtZIQrak+oCXEEInQ88sGUmAYmBm7e1Q3RDoeMO7YRtKy6DJwY1djyKlnyDpXLuopXNGVwaW1Pkc+kOoQuUOrfLDxmqg091GwKbQjc9UG/oxfBl4DxIQRvvzWP+sd7XkztBBZQrAYac5Cr/XF8t8oNiP9pqATJgS6P+EQLxOihHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfVHkqL3nhhsukZ7/P8hz6m3MpYTYflwnTecmRC6q84=;
 b=s6gzfOFcnyGMxez//T+4iAp0593Ngf4h9a9NMsXoYWi9nrCaN2esKYxdnxLNwA62Klm+xpfhDcl/gUNMdtPrXDRWDw/ca/GIu9HFcdKJ6kRqEjTt19jmvriUXzrivrmj+np7dEC50hrKxWpjBzyEzjDbP2vBwrTJ4aK/6q1FCMk=
Received: from CYXPR03CA0031.namprd03.prod.outlook.com (2603:10b6:930:d2::22)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:14:08 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::c0) by CYXPR03CA0031.outlook.office365.com
 (2603:10b6:930:d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 16:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 16:14:08 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 09:14:07 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx: add eop size and alignment to shadow info
Date: Mon, 13 Oct 2025 12:13:48 -0400
Message-ID: <20251013161352.1628044-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013161352.1628044-1-alexander.deucher@amd.com>
References: <20251013161352.1628044-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba5cb22-3f1f-4e6c-a7a1-08de0a738a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Zse5F4u+OweXO/0SSn0XDkuoExrc8jsiEsR5myFCy22xbJIbs+gPM6JusR5?=
 =?us-ascii?Q?N91KJSS9+Li4duQCxp/2Pi7cYOw42HRcrDB4AnWDSEE0+3+u3/ElAHwLOaZa?=
 =?us-ascii?Q?udYgdxlSCq10Q4jiPGG2qESUVK1WSLEniBt7iwuZH8+gwTvT7rJ8BdPVUuP0?=
 =?us-ascii?Q?W2iEbm56io6L+7hzd11AFnebaCktewf1fxDtGkC6UWEyBiD16F2YMM4YpjRK?=
 =?us-ascii?Q?Dx3wHR5ikTTK7zxBUpPzlYRsAhz/JKH8ArJ8GjPJjDj9kudNwBUUfaKMq7a2?=
 =?us-ascii?Q?5jQ+gxlzVd9M7XmHkfks0yquJouM6Q/7UEy0WOxjGg9anzhEH9FX/jYTUVWZ?=
 =?us-ascii?Q?w3rvMnKbEzM7TduRpoBaU1A5pNoaR82laKGwL6Hi6VX09elIa8x5YAcU/RyG?=
 =?us-ascii?Q?N/R2ORKqpymyOJTCs7j0Q7PQH5cFj7ORIc9KbJTbY2Dn93XxaHln9OVOrnl+?=
 =?us-ascii?Q?L8SJWXpYNeLtQ7z+ver+jGx1GXK6nWR/fwgukI62nXlB4IkCEFVO1m7sCBJl?=
 =?us-ascii?Q?W+3YZd9Iu6nyH+2Z6I0AVfQsSyXk1eEQa9Dw+O+mXdyFHDz0O9U4mkHJqrZQ?=
 =?us-ascii?Q?E8RmI4ddDGihSQ4u8P0GkMt3BGLX4JgjAuFIM0ot/9VS5PnpYQ9X7bW8ff5t?=
 =?us-ascii?Q?iJ3TW0ofUokKuCNIQMAHoUdd/6lo78tVTKUqbeP8L9IhHjLl3KoujS8bk/lW?=
 =?us-ascii?Q?u33ZsuV5Hv4sOjM48/oOvhUbamA9az+DLNCC34PkE+R7H6b2IqzkVwpHWUcb?=
 =?us-ascii?Q?XoAtJGWLSilM1cVjvs0X2+705olLFZVRyV7yHa3JOvGf7ekaAKYifAAqxKqu?=
 =?us-ascii?Q?+bh1Jk+bc/z67W/1XE1up2dLO5BH5VZzNgcYEKcSxC/S0FaEBG5XVLbkpv7E?=
 =?us-ascii?Q?tfuQZ4IW4h5iaLXC1ifjFSmeINgmO8A/296duM9rkItoY1cbALJTxopdAXzb?=
 =?us-ascii?Q?zyqT/aUUm+3edEXInWZW4XB/6l1EuanZbpZg3inrfMnUZDk2tG4ksEASlUXq?=
 =?us-ascii?Q?s71jM+s6yQqN5rqQdneBjlAZwkkqqAOeZpltNsdzSJfvNa1klemvuOu+PeF+?=
 =?us-ascii?Q?ZhQSFlMDFga6srXjqGOPb3Ai7zRt/RmTZ0Vx1ljW0PdD5n516AuHfnxJmDCt?=
 =?us-ascii?Q?amSmqk9N9MBKWCCIIsZg0qae9LMd9qWc7RcUXzlI/7GXntjkEXeSZ05yykuH?=
 =?us-ascii?Q?RsjAg868QQDx8QpeSvo7Ur3Wjau1MTXZo4p9yxDlMKgPHpo8+yB3zJ0hYT30?=
 =?us-ascii?Q?+PxC2XGu6gcGIh9aKO/TvOxrEMykPxqhI8w2pphyhf2gkG7dkEBV42dhnmVe?=
 =?us-ascii?Q?lpLr7V+/qYF+ce3AkqtmAWVf22krGZ05QDZJrag55S5eTT5N1PDXk9ciD1JK?=
 =?us-ascii?Q?fPiV/Q85vKdaWZsiYVBRbPQxHG9ILWRzLj/Z/9WOeBMiHeAkAPb4EzRAjhkv?=
 =?us-ascii?Q?llibTiUeq9ZB6xQIHS8bhgkLUrKqctbnlWBolBo7CTsesBsqnQ7Oh3xzG2EB?=
 =?us-ascii?Q?Cg/Cy7tHh5LVI8GMOPFfsPQ3dVrHX4hLrVR2pG9z5J+UJLuZFJHyg8/DJEKq?=
 =?us-ascii?Q?Rvn5x9GOhDpJ0Pl+yvU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:14:08.5710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba5cb22-3f1f-4e6c-a7a1-08de0a738a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

This is used by firmware for compute user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fb5f7a0ee029f..7109a2ad9ec36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -328,6 +328,8 @@ struct amdgpu_gfx_shadow_info {
 	u32 shadow_alignment;
 	u32 csa_size;
 	u32 csa_alignment;
+	u32 eop_size;
+	u32 eop_alignment;
 };
 
 struct amdgpu_gfx_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d61eb9f187c64..001ffe3820be2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1052,10 +1052,14 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 static void gfx_v11_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *adev,
 					 struct amdgpu_gfx_shadow_info *shadow_info)
 {
+	/* for gfx */
 	shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
 	shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
 	shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
 	shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+	/* for compute */
+	shadow_info->eop_size = GFX11_MEC_HPD_SIZE;
+	shadow_info->eop_alignment = 256;
 }
 
 static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 93fde0f9af87f..f067ad4146454 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -909,10 +909,14 @@ static void gfx_v12_0_select_me_pipe_q(struct amdgpu_device *adev,
 static void gfx_v12_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *adev,
 						  struct amdgpu_gfx_shadow_info *shadow_info)
 {
+	/* for gfx */
 	shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
 	shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
 	shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
 	shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+	/* for compute */
+	shadow_info->eop_size = GFX12_MEC_HPD_SIZE;
+	shadow_info->eop_alignment = 256;
 }
 
 static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
-- 
2.51.0

