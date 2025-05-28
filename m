Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EC3C5AE59
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF7B10E57A;
	Wed, 28 May 2025 04:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gMK0uDYd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A944C10E56E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXoZljRhPWHeuu7xvP3zIr36k11BorRTelhjMLcvr+fChkuwJsCGBEV2i5nqHd8K6VycIrXD4KZcd4XSsA9ZEM1s6z3Oakmx4bXD+mCeZG1Z6o+bfftl8hX9zN3uCRm4mH4SeJA9P/zsSte8vNEyr2vTbtJxTox1LBR6+EwPEXbp5BQ42e97c8uIbS62JcsBNXf55Is08HZMydbAAEItSaK4nO9MeqHZOBzjGRk4frVLQtgQcnp25mTbHD3LfeE53jXkwYS0X73GqYUkOA2wE5IwGZilR6Wk8Hyp3VJ9EWIQUqZCPBC2lCbDGAsMwc9o6LflmRlGl94oYqQbCWn7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwqjzUJ6MR3lUBanpmhNd0CbCwz+ztgDOjrbCrnkoGM=;
 b=Ik7dHVVfbAGhdp5Uskkk9GQKARPRsSh3kDPRxS0b9v9ChrQnokpyLiTjQMPSXNvcfJJGjWLRPBWgwMkKGmWQfEqGOrsyb3ZSZ5A2BV1pD2OURR4XGjuKDbu+j29fTn/lbDRs9LcQvQ6eaQrWeOKFcpesFaG27z5ag98Y9nm9bTOt80z2eZTiReRrAZmPSUQu3yS2kGULO0VtvHkyY54xYQb5H2tO01owSC2jao+O2jedp/d3AXvayf6vZXc9EgiaUrz3BnepttWvKrXnMnob1MGr2fm+sy2DxE0QgnyrYMYnglr+jKfapzJyR5ivdetUvQS79EqWEEHY1SfpBpd99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwqjzUJ6MR3lUBanpmhNd0CbCwz+ztgDOjrbCrnkoGM=;
 b=gMK0uDYdnOuGrNFIITYZ5tInJxdyri9+XJG7n0UELEGoA2eVgnkWTzhWVygA7m/fV4zuWodsVEayR2qDnfftUqUt05uUKAqEF3jSn/BHOTHTyfYrIuxMJ4NipZmbLawkqMdzTF1b8CdwsO+7F4pgRX6NGq/7OsgNI6B7D69c5/o=
Received: from DS7PR05CA0047.namprd05.prod.outlook.com (2603:10b6:8:2f::26) by
 PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 04:19:38 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::e4) by DS7PR05CA0047.outlook.office365.com
 (2603:10b6:8:2f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.10 via Frontend Transport; Wed,
 28 May 2025 04:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/19] drm/amdgpu/gfx10: re-emit unprocessed state on kgq reset
Date: Wed, 28 May 2025 00:19:07 -0400
Message-ID: <20250528041914.5844-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 203f737f-ce68-4d2c-d0fb-08dd9d9edb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4MpcgMmTDBKPFgYPxlXN3U9vwLxnDffZzISy4SPkYiA1gLVSBy1lPCRDbdFm?=
 =?us-ascii?Q?5buazHWhIwgxKcDGzDSun10KpjoTeermvCsZBTOK1CQJ401ssAeerAg02eqc?=
 =?us-ascii?Q?dW63TX21zgfv8JH9jxcxbL37HVNawhlVvpkBbkIibaI3YxULCOvBpxtuzI9Y?=
 =?us-ascii?Q?eF63aH+sf/ItVNsrAjL2+2rDlscBkatoKJX4LvFwiDoqFhMkLOdAmU7CeR+l?=
 =?us-ascii?Q?jFYqxQmC4unb9xSIwLtoHoob4XWwukNH5sZvdsM9N6JpmO2qtIUJk0rxaerv?=
 =?us-ascii?Q?7h1/ukLBAHdLAZD/pXS80Po8W7ypuW99ZnFouctKM1G24NoWyIlNpp9iKXv3?=
 =?us-ascii?Q?eWskK1S3Bhh8LCKn2zD1aBwe/ueeQN5AR/VGc8rpS3MjWp3fZ23DgIyUd+6e?=
 =?us-ascii?Q?jyH5ydTeJMy/vE7gHafLhls1lADOH6M9wTE5OaCh2KY2NzwOB2neVg+n0QNw?=
 =?us-ascii?Q?mX1rapUszP+TORScERezir6Y8vAwFKEvNQ/at3nVQ/IQTSkZDjK0P79vJVlz?=
 =?us-ascii?Q?WVerKaU4Znw/XaS0MlngIhToOzmK9DmUjxonT6WkZNAFtI859hRnbUD+yFAy?=
 =?us-ascii?Q?IudXyj79XVpSylWIrIcBLpx9wmtHMcmEypthPx5x+Soeq9q2Vz1p4upxhHJy?=
 =?us-ascii?Q?s0lNLbeNK/ViwcEKNtnq7X4iZ/9RFMYMeBuL8NjTJACbKACdEO79//kSPKqz?=
 =?us-ascii?Q?MpntdDzpnsIZ/IGnV6Xskn+v2W/GSZybbm2z/WGMckPI9XF/xkEDGATXL9NZ?=
 =?us-ascii?Q?5kRpUhaYNtjpCpRwjQs4ys//lCkJS8d2GtKtDI87HPMbbdS0U0IY7FOmFptF?=
 =?us-ascii?Q?eYQQ//D3eEz5rPPfOFRPzp4z29NNSmC3oxxrVm9sr+Bf6kQezn1u680I7QZ9?=
 =?us-ascii?Q?WTWPioChvi7skO9n8ORxmzIpIGA/i35iOATQ964I7V+dD3GMNISYXQ4lYqtl?=
 =?us-ascii?Q?N/YeoU/vDSqGUaq0p/wP3TtNnuP4WNEVcqdqEXG+e+R6nWUzcVlGSwfgEULj?=
 =?us-ascii?Q?3/p+JjCIiYWs9vpBdP2PZmf9OFDvVIUM+P0jUOfNpFjL1sVo6+47T4toulUe?=
 =?us-ascii?Q?HsK0tD7iYmwTP2wN59sPy/GBOMJSWDtWY6lws9A5jpbepfCzvnaIaXaoaQ0l?=
 =?us-ascii?Q?pHP33PDDsil+fGhkSVz+AZou0vNWZ1gzYRPJ9zw8Opl4tzXYFFtEVsLIm9iX?=
 =?us-ascii?Q?dAypzIoNFhix62fXl7TLijS88ovKDmanqZiMaPxl/VA4cSsUrPlr7lcnmgC7?=
 =?us-ascii?Q?NfM8Tm/uIE8aVQtDzsPwUlTmlGPdif4nZZfAXSyJyINJ2nngq9pA+mTPl2UU?=
 =?us-ascii?Q?A9tgfyKAOnrZtj0vg60RoHVWFKwif1TVTv2ShRKgkw8WuVkCg5kHHTfeBZCJ?=
 =?us-ascii?Q?0bqoO8fM42ihQF0VtM5vML2G6Ppe0qpg+rAosehs1CAsqu4MN2R8SiOdK1+O?=
 =?us-ascii?Q?LOwjGZopuDIyWGVp0jsO63D1inH4gpqwnCMCOXuOwVto0LMWqLAVHSnXt/iT?=
 =?us-ascii?Q?htcQAClpdUnjbPa4cgRdHIbSl2lRJNe1QIDw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:36.9376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 203f737f-ce68-4d2c-d0fb-08dd9d9edb8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3193eb88b6889..f6e04cf21abcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9537,6 +9537,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
+	unsigned int i;
 	u32 tmp;
 	u64 addr;
 	int r;
@@ -9571,10 +9572,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9584,7 +9583,15 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9612,9 +9619,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9891,7 +9897,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

