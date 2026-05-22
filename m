Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303DECD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18B510F481;
	Fri, 22 May 2026 00:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgQWX90J";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D83910F48B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuRlB8P/+5PHKseiybla1r100mb/45ROE3lhfhbHzjM44IKW0HvO+6R8WHWFl3bp3YOhzNnh9oePOFcZ6orHDwSmNs7pGYrxCIkhy4evxhOYY32mHPK5fIfzAsYi0E8u+YqzfGTQjsIKedLKta2ePLvMLHUqCSh3VpqFY6I1qN92yOTk37m7Nn0r59rYrsG2hpPO99yTwDa7i/Ku1nYpjm/YIphn9TkUFJvuHUmLBVmvxVR7z8V4vr5B97T+vkvjpTT/wfjURGOBCfdxzM+zI3scUOpbekJ6AIsRtHTWdPsMS+Qgfl6W8eots5WGn5NH2Af4v8DWhTd2zeQ8AZaHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1l5D9Co62dhnsiT1HMSmFm0kcKKPEy//FiTZ+6KRmc=;
 b=UHeikrc9l4YEDPLJi8U8DhFLZvR7xUT3r55Pz1aotfkroFJOHwCbXwN9B9XJA0gzCzud8ywpUcaQoRmdtjnFlPKCvzqvLFuCPulJ+KVcbjCaqVNCFBgInVQSHbhS11P8R31if8K7IklTFbhWLgAYbxUqhxIdu0LX69j2mrG8kTxcjyZvKUzDa9cJZRqDZ/IxKHPnE+SkgT75NWBFL43vR3fTWnwi7MXLec802ZJiau3pk/OzElt1B1keEHGr2iuDPFs97JOMLdNctTX5ksuFPe4ij46Nxz66MYYffrt52DJEp1rbZ9o37shae6cQSBtEBdKKFu/Qxyocj2vVKmkk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1l5D9Co62dhnsiT1HMSmFm0kcKKPEy//FiTZ+6KRmc=;
 b=GgQWX90JmmQGwN62aefN5HnNqZZSfPU3l7JijhUZZBG+jMipw0V2GXeVHtLpfOLsrbCQFq5TOl4spoXsVXj+fknz7HhrQG8ZOUkGrY/ITYspfw9Jpuok1LrEQrlM0MLhdOOKGCwzd0yNfS07CoaUvQSjXAVreuhZ8zDq4WZIC14=
Received: from DS7P220CA0062.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::34) by
 DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 00:22:20 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::21) by DS7P220CA0062.outlook.office365.com
 (2603:10b6:8:224::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/42] drm/amdgpu: store whether to use MMIO or MES for reset
Date: Thu, 21 May 2026 20:20:38 -0400
Message-ID: <20260522002048.98506-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6956772b-d07f-424d-c893-08deb798304b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Dh73iXkBxLWBnnn2DbEc5WcFN8LhIQcxBnF/VHXd9OT6PlBba4yrKe9gVNQqYCHEM2H92NAdlsGHICHMd3sQyqylkCq97hV/LWRytkGo/zP+YOgU8vQ0LWt0SA2b2hEbn7IwfFsinGvMMhOcOBZHyDARsI145zp+WQefo1AeFLccUthNpJPNJwn/8uylLQZVxE57yTy4GXYp7qxJSJjXOIbTVJAAS4aXWV4OxQz/Gneh+8NXx5YU0I6kkbWzrUH6CNkg3w1NekgrnPlXYxxBZozHv5LAGTK4TKEE5X4L409DrZ4xA3yMU7RUJNyvvB1CpIQJPk3LG6AT8FR4idw2ENbHG72b02TwOysVOxuqY2ps4TDRwb0/Y9zAKwmKNmXhhODG8+nO0ucfNqg2TNfI7uRPTQeFM1Xqeu36Peo8rOuW31FUuFk9Eeh1rG52cZE8LEN89MR7uM9ILWN6UsupkcbvtvyHETWqzEdIEPTIyNsTx/juF4a5/giTqK+9JsTCCMKtttK+ZfAN7u+WynDwA/lx7ziVVflxu4sVDt3FIvfPTa5QpwNwpts3ZGM8f1qma5R1gX5nO49JAdm5chAk7f/nPPIebgwFzcdH0DrANXXx/edFkKIMSMXINV6ks/YwgZ/0J3oQ+U92R82PlpW1aeKDLS3y1wM3FrHmOtk2T8IFliLfcotTRbommgwkvKUSjs3nd17wHKhl3WDTuy1DaLYnFru9bapV4yE+AkHhSWc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 906zsLhw5qlzPjDXgkIRHrnN9VrliRIjU/qHe7lkCf9NVp8d6EFayE6OXbhJIVhg9JaO2X5DkCjUK3dOKlKemEm/jjkGPjdAoEivnQ8cF9vVjkGeux+SnF0lXHJGIHjkb/sWMv9zxkrnnbROpqqCw+lWlskmwYc9I//PAleZ/AksZVlqsoROLjFehmJEWLWnOUcW/99hHkfUZzuC0CSWRswAx/kLuAweiQz2ZFbFRnZPPnMZE53TFhSPtkNwooTBxShFM5hsYN5lqbHSd/8vkPYKGyBcNJbMLbiMxrRDt/SpmARcOesvzTd16AsYQrUgHMG1dAYWrcez4Y+vdRJ2R50IAtCfQg7uhdEXoMiUhJ+JRAog6ZjhAnI7Kv6F1BOm2KwDvQwzcCY7jKs11qmLFszV2NfyHNi29SYyLoHPd869fJ9H57SnOBQv5HAIL49z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:20.6027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6956772b-d07f-424d-c893-08deb798304b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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

Separate settings for gfx (ME) and compute (MEC).
Use this rather than explicitly specifying it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 7 +++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 2a548b22725fe..22fb90e229dd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -116,6 +116,7 @@ struct amdgpu_mec {
 	u32 num_pipe_per_mec;
 	u32 num_queue_per_pipe;
 	void			*mqd_backup[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
+	bool use_mmio_for_reset;
 };
 
 struct amdgpu_mec_bitmap {
@@ -401,6 +402,7 @@ struct amdgpu_me {
 	uint32_t			num_pipe_per_me;
 	uint32_t			num_queue_per_pipe;
 	void				*mqd_backup[AMDGPU_MAX_GFX_RINGS];
+	bool				use_mmio_for_reset;
 
 	/* These are the resources for which amdgpu takes ownership */
 	DECLARE_BITMAP(queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 455fe4b3c2055..50d3990a00c30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1905,6 +1905,9 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gfx.me.use_mmio_for_reset = false;
+	adev->gfx.mec.use_mmio_for_reset = true;
+
 	return 0;
 }
 
@@ -6780,7 +6783,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = false;
+	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
@@ -6811,7 +6814,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = true;
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	int r = 0;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3c6f234cfb29d..03b1fcc046552 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1603,6 +1603,9 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gfx.me.use_mmio_for_reset = false;
+	adev->gfx.mec.use_mmio_for_reset = true;
+
 	return 0;
 }
 
@@ -5216,7 +5219,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = false;
+	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
@@ -5247,7 +5250,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = true;
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-- 
2.54.0

