Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86938C52CD8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0370C10E875;
	Thu, 25 Jul 2024 15:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cORgA+qM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8239E10E862
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8qC4aOS3BESDkWFfrqUIiAVU/80dlwdGCBdSDjSDvUfEqYNQYl+RLTjjVwywQ59DNqFWvHY9WuQBRn0TNg7yRJkvMbkSYuLQGiAWZaKu6UjtPYlV5urNrjA6KXc/euxWGUc5Hnh3BiXQHN9QPt+rEVgfoaJLTkcMqynB9hQ0YXPPMbbfVDiswORdVqMYpbvYZNReXo0MU+bcpKKTakov+qapvOnGlbxcOzTyAPyPGu1YSgkwcysKFcRPx23mrC3FgFoQ7IpGtZjp+wAeI5h/uEoHK1di//Yf0PcF5ImAq/nX32O1vC5hJQkrA6oTnvVqw6PawvNbn+C5sDIucxszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPwjOPl2NyXEM2qXEiuElJUC6Rxw3IuNzlKvoL5TWwI=;
 b=BLBczDWvmt97zeKvT7nzBsQGoR7SIs8FOekaK8QtqPfUDaCaL1qodRInZRF33fyuXAU1QHZs87KEicL20u3nYo0/n2yTMuyj2h3BdSRn5gkX0YQmqsORveLw22U7ajgCdW2d8led1M31mK0MsJO+xttChdKz8i1nffKsMX5pDac2hbjMs+oj2Al9ZgRlAPPQ79X6qZodyp1450kZNRjcg9ZRJ5p+LXxP7y+BNpvMb5cS5pgT9pCH9EQ9NEyWe028zw2ugHoBu3M6rvYYW4CMsQzB5aQ/3DjiA8WSrHYddCuE+yQlyRtD0hKtr7kUJ1ba3Ct1LV2kgueENB2F4AMpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPwjOPl2NyXEM2qXEiuElJUC6Rxw3IuNzlKvoL5TWwI=;
 b=cORgA+qMT62rZ6c+7BXYirvV35Ies8YfZdR1lEGWwZybdogDLkVV2t6ENwdPFi22OcRjzsg1dwjSkOfCc367Q6ETkw9tcQy4J9utAIFyyxHyNNoTDz25CHy23l90uZP1kV5Y7KgJGssr6bIgq8Rl3DkFct9rIzS73/eO96eA4Ck=
Received: from PH7P220CA0046.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::10)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 15:01:28 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::68) by PH7P220CA0046.outlook.office365.com
 (2603:10b6:510:32b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/53] drm/amdgpu/mes: modify mes api for mmio queue reset
Date: Thu, 25 Jul 2024 11:00:33 -0400
Message-ID: <20240725150055.1991893-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ec4b4f-9a42-4f6b-6d3d-08dcacbaa899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eRKBucqCfSH3VXuCowb4poK0MJ+O+Z03SPB+dJjL5c+ZJTL9spYZgeDKziSX?=
 =?us-ascii?Q?QTuxs6k2oN6UzU2hs3TrBPcpLiUICg9bCtNlYmsTvjJdzTOw+H0qqnmTWdfE?=
 =?us-ascii?Q?tGsrpl2heJdKfK6hOCVxrpuSXDdw+6rWvgOlyt1CY+poTV8ZnyOsUk9wrYuN?=
 =?us-ascii?Q?P0+m0w6m/lwV9WZXJnIKTHx7fo1lsgdquoheVSPCIw3UU5ji5SCBHfOi+z4s?=
 =?us-ascii?Q?rmtU2IgIjp1UXFtU/2fdwYBEDx97ztUGJLn/goWU4KexfSsYREFCpRvTigOj?=
 =?us-ascii?Q?E0fShQJ468ezLhclPSaAB5JmuJN4wrhGGpJD0VdnmagsRk7Sri4JlC7MALyN?=
 =?us-ascii?Q?4HhPQroaKlx+gg6ovye5qbGcAQuradfFR1rmE3T6b5/UKu7V/SEdDc/31M9c?=
 =?us-ascii?Q?8JYW5jJHfm5tMz1ssaS714GxggdScPJjaEkLYxNBsLBzXeWOflUeDBC59uEF?=
 =?us-ascii?Q?+TUs2KvlurX7YuMYXdVabAzYL6KD5kGIpDSY7PYiO7il0Su6/miJWXH0hg3X?=
 =?us-ascii?Q?SsVTIU7jHZlWErlX86t4QALZW46lTqkCpEJfCZT6PZJSL1Qd8FtZ3agoxVAO?=
 =?us-ascii?Q?Uj3Ja/oydiog+iY0QMdy3QHF/llCXR5pH1qAXfUNxgnTOv0UWnTZLklqmkMB?=
 =?us-ascii?Q?R+cXwdAqnQvBocz7y91fn951GjAQo8FVwr+Em5FHgQFmrcsdmcZW9nndJnks?=
 =?us-ascii?Q?+8qEfdBCvBRVS0s8z1hg78b91agmh5y1LsT8Nrfz5WMiDFOYwpjduvAbKPRv?=
 =?us-ascii?Q?QjJts4aAoKKmEz97jDYgAxWsGdUEkQE+sZG7tVKf4gKXMiR634ny8NIherc3?=
 =?us-ascii?Q?B832/HaA3wdz9186lQcMLFtfr/7GbzLqx3j74tZkPcOSuSrUbDOhUCvqY7UY?=
 =?us-ascii?Q?8H3EIdn83779ZKViJuw4lmaIn4H1VtgilN9gEk52BdmHOeQK4sqACv4Gsk7y?=
 =?us-ascii?Q?LMhKMIHnY93CIE/anaxXh6ZuzVpLuYH7dS3p1iqzTdXy2L8MGztJyd0Se3Xn?=
 =?us-ascii?Q?sOTR48lzhR5UvHgbWilsFxJusye47TW9H1n1VZu4gxHgonJ2yhE9kqRC029m?=
 =?us-ascii?Q?UptchTONaS7lHxcCggr+BDPTfEzhvLrAKY5CHfjzfL5AmXHIKOwn8yMC5fZw?=
 =?us-ascii?Q?cv7uid8H/5ifVkQXB14KXhrLVtmioMZUzulN1u5Lv3pXydf0IsMzVwlVCeRR?=
 =?us-ascii?Q?sMw34MDT44qv/kuQNvuDLs2A4Q8qJWYGATxFazwWHuTsiEg6t1wDEtf6aHI9?=
 =?us-ascii?Q?7wSGAtXqNGT3pHW3+MXICMsTNICDKZfBZ2Ml6c9Jof7SbOEbjChE24pocfCq?=
 =?us-ascii?Q?5pGijeWe9efCclBU+eUVB9huLysqOgZ3IpqNxyCAP3KL16lOuFzKGDoF27Lh?=
 =?us-ascii?Q?BzzbAIAbrqM3UVZXBIyf0XiaByYeYgvI3VeMiqzlhWMapB0zsftNvxCaGkDq?=
 =?us-ascii?Q?5Kk65Poki6aIZ/6oZo33UV9dkXDgRbsD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:27.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ec4b4f-9a42-4f6b-6d3d-08dcacbaa899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Add me/pipe/queue parameters for queue reset input.

v2: fix build (Alex)

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b3d6a9fa6775..950c26ee3fb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -864,7 +864,8 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 
 int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
-				  unsigned int vmid)
+				  unsigned int vmid,
+				  bool use_mmio)
 {
 	struct mes_reset_legacy_queue_input queue_input;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 771b63db1846..e6a4ef643967 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -251,6 +251,13 @@ struct mes_remove_queue_input {
 struct mes_reset_queue_input {
 	uint32_t	doorbell_offset;
 	uint64_t	gang_context_addr;
+	bool		use_mmio;
+	uint32_t	queue_type;
+	uint32_t	me_id;
+	uint32_t	pipe_id;
+	uint32_t	queue_id;
+	uint32_t	xcc_id;
+	uint32_t	vmid;
 };
 
 struct mes_map_legacy_queue_input {
@@ -287,6 +294,8 @@ struct mes_resume_gang_input {
 struct mes_reset_legacy_queue_input {
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
+	bool                               use_mmio;
+	uint32_t                           me_id;
 	uint32_t                           pipe_id;
 	uint32_t                           queue_id;
 	uint64_t                           mqd_addr;
@@ -396,6 +405,8 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 			    int *queue_id);
 int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id);
 int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);
+int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
+				   int me_id, int pipe_id, int queue_id, int vmid);
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring);
@@ -405,7 +416,8 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  u64 gpu_addr, u64 seq);
 int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
-				  unsigned int vmid);
+				  unsigned int vmid,
+				  bool use_mmio);
 
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a54455859f6..c047e92471af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6525,7 +6525,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index db5550449872..02efb0a2e625 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5140,7 +5140,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 		dev_err(adev->dev, "reset via MES failed %d\n", r);
 		return r;
-- 
2.45.2

