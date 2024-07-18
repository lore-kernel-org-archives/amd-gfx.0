Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD37C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61C010E920;
	Thu, 18 Jul 2024 14:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSd6aj4A";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D4610E91D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnIQbaX8bT3FfhmbBottybJUKWBaBQxFiPhYLgchaM1pNbydGGLk1v5FKyegqK5haS5bwwIimS+tqFDD2QT9+rVqSclrY9bm4lLq2PChzRF63XiEXllntYloOfYMNytt5ID2Q9OjTokYiMbm433iIPBxS58MT6M1V/O+xlhUp5KgSj8GhHpMLtstm7ENdSPL5a1TI6khmcBHOyWlbYHzIVBgbYOsNfbEnlsqzzy02UA82c4k0OF2Gk4YPiiUh1h8/cDbvY/2mOjc/bfRgYvLUQWAxvdnx4+0rwJ+h1IwyhA8/J+VUqzY+pL3vKtd6ImwV02IqhrD6Ilk19z4t5BfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny6TP7u1sYrlq75679Cfq5Eo5wLhWlqtR6/nMD84hs0=;
 b=OFwqDMnp9vCFKN6asM2/ChJ2h1m4bYMJIU0ff0Mq+ZYMkb0UG7fIHA6oaJc7WcYvwracozhpjtMxTiBCMiL1koOIig4FmfSnBJUh/8/LvoyG61HiHZHj2xm0gNjhS/i7n/O1CvZGbAFtpnD1qovjyUZBq0dfwfiPWbxokeanB4xjd9lQ8idrnbw2+QRTQFltngN7cnH1Ox/lxF1Wpq9O2cVm6MI/dZ+V+94YpsRKplSomS3aE+6D8tb2CdPDa8euwSBbu40YhouTu+M3toZCQVU1Q6F8YLp69iqlIJ8Wv4ADjjN9hl775q8J2U1GwlVp16PSKrMiFUATvPWX/WZNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny6TP7u1sYrlq75679Cfq5Eo5wLhWlqtR6/nMD84hs0=;
 b=uSd6aj4AabliaJ6lIgHHxoOUHkxKNZLmvJwmeNLdhoc0Bf1TbWh34uINhjanr2OXe/MMSW1/2wF+DHFOybJ3rM1wbqKOIMI3F8CR+qZP43Hn7fACdjhhL1bThAsxu8TvBXWgrg44RwpXuMTHYshm+CvAyuAVCeDe5Z7fQGQ39PI=
Received: from BL0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:207:3c::28)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 14:08:11 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::a8) by BL0PR02CA0015.outlook.office365.com
 (2603:10b6:207:3c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/34] drm/amdgpu/mes: modify mes api for mmio queue reset
Date: Thu, 18 Jul 2024 10:07:28 -0400
Message-ID: <20240718140733.1731004-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5c46e0-2f6a-4bb6-6934-08dca7330d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nXtzjM9PTTzAN8iNTO+WK9ahVea+C1lJQvbWkYaxrWTBjFYenUJT7lo6NoJZ?=
 =?us-ascii?Q?6hdTXheJcSUnKRp6UYtZ5mKvbFiemGELeRQCTfwxKy1sQ4i1nrXTJPPKcibC?=
 =?us-ascii?Q?g9patAHE3h3xnb99Qus+n/JoKZdKbCa3LbU+EbWlVTXqnmQUJeUREmF2MN0n?=
 =?us-ascii?Q?weI8D4mdkYpoxLbSJQiQd+msvcY22aRkuwlenF5j6ikQ1Q/iw7vQH51YAX/A?=
 =?us-ascii?Q?bO3i020hARk3cj0aAdaov7jtsM4nxE9sKI+K+tWfclUCfoe/MQw7hB8ttbqX?=
 =?us-ascii?Q?MTH1gHm3SiXcDjwf9wV2WKwFwF35QfbXWpN4xvdqeXByJxK2garfmWhHpVIL?=
 =?us-ascii?Q?siQx6KZHKmhcvjbY7qx15AJN+R49gWmH9SKJ/v6RxUnA66Th/Ei61I9byGDE?=
 =?us-ascii?Q?zwbsdWRBPis7hw7cD/xw46N1GP7cLE1o42OrDzVraccs1U6e7vRDqBQEdQWi?=
 =?us-ascii?Q?FLbEK/5RXBcEEqLkU8x7RWDqocJh9t70Hx760r8Y1saT6e7QVzyh0pSFxpHl?=
 =?us-ascii?Q?Q5nWYBXjsrQePEqycMDXWTCMMu2hWumZ7454o6WmABJeuafm+XaWB2v3m67Y?=
 =?us-ascii?Q?qUrIeqzdsTvB4fX6WBmYLDnH6LKVnfyBfP0kQ1lpOh54Xz0iQ4yuQ0OH+Zqy?=
 =?us-ascii?Q?JF/apKwvDDhL1g14z2J45r/JkX7KdbZYTdes2s4zlDfd0b0mVuBPMMsYb9UA?=
 =?us-ascii?Q?30hkerrCHSuo3uZREyGx1B9Qsx6woZa91tfR3BRzGHqCJ50diz6yxWTVqFFK?=
 =?us-ascii?Q?ehM+dfulYyApIiiBL0v2Gzsq4Zmi0wlKCh8gTWZn0QO/BDP6Gpu97neAeMyW?=
 =?us-ascii?Q?+PO49xK5LY2nMNdBk8eyUYtgOZe8v4yswet+kEEn86VLyVQewz3DC5Ro8rUy?=
 =?us-ascii?Q?UIEraBYE6iZBf1vgaMWihWmohBYlx+W6O4WmB2EeKGx4P3GWruYWLZ6f9xiK?=
 =?us-ascii?Q?Le3ZE5m+e8dFNGHlTwtarr9GHNgvmypka1/pKTD95BLyskGgyBAgGaHX6tkx?=
 =?us-ascii?Q?AGVL+wESGnsW2OGw5O50oqIvb40Ncbw/fTUy9z2fZepBW91Kg7Vfrjij98OM?=
 =?us-ascii?Q?BEWhmt5FJ+K96CQP62ALYdlNbsQg7rPNTHmWQJ0Wsu3biP+E3czhMa6RSJya?=
 =?us-ascii?Q?w61K8tY5B/eTKV9qmBhbYSrxmpKdvnQ6iPXkM40KHREIF0PWFD4ACuSheqhq?=
 =?us-ascii?Q?iclnf+i7Z5hcNyPPLGUtMfAjNHeqSALBq0Jcmq1hTFxb1RqVZJ2OljRpuTQ8?=
 =?us-ascii?Q?zushXka3YYsG3X4DdKdfDOMa7W10vMv4IVr7qb9G7rl6uOoXbTKtxRZKaGLX?=
 =?us-ascii?Q?eAQxgJBUZ17UYmKrRgeMp5pSOnDIYdZ7FGiEl/2ERFH3jm9Y/iFtJMkurwxY?=
 =?us-ascii?Q?QXCsSmJj755QhtIr6Dl2HJPNez0suYmOLuO46MLp44rnydwGUxeHNEcqvI4z?=
 =?us-ascii?Q?US9XOaDtBvcOnQX0cSaTOMipv/lja9qp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:08.6310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5c46e0-2f6a-4bb6-6934-08dca7330d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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
index 1b2de8e81ccd..348bc1b1784a 100644
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
index c4193fa2fea4..ba121491f5a7 100644
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

