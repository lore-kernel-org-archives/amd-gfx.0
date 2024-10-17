Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253A9D3748C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B822310E82E;
	Thu, 17 Oct 2024 13:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0p/mPHPL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDD810E82E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNee/BFdGBxDfZlUnzld8iED4jiH1GX834ISHeecwCs7itkKaqu0io1G2PgvfM/jdv3GBfNZOw1MHNE4g/WYyVPkhYsFh6p+4HN/JWVOIyMl7ECsXPxOUTxsZtQeyZfWJeThcbDPwMYeRDt5ZUaGx3NY7dEcTnj6MV9qQNFjYlo1m3h/rJqLr7ddkYF9G7NxZJ+ZvJLCwCmOa5+noo4gAAN0ffcGywATHb3sPJ8B24BvUyqZBuYm8gr4bGRnlxCc1UPjtmZZ7entRse1xe44yVYKiIETu5jQpKyGVfV/6K7vv0Z8J+ZgrZXL3/7En6pdKIrsFom514GbkUoFaQKteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr2kBb4NZ98nwKNyfqdHwLKnX2Kze8OTBHQNYurJhp4=;
 b=Wttre1QB6EC6sozMYwff6S15S0fHZ/paqK7jgKAxs/uPlrcGnfEQSFnQ2TTct9j4l4eN1PmgFxCJTE3Cnme0PyfJBJ5B33tYj3ASBot5AZh1t9Y46UNybKlReYMExvOMDBPDR9MVoSrKnj8MgRRfa4v8/JfuQRNcCmt4INncM1e4Kc+2ESTlOBJTAdlN/J85oIxCcN4VO+a34x1t+NFA7f2RPQpRcY+bKrXkloXbSkZgbEu1Ta1yprUq52KhdSUzXLKjGgwZqWQjucisnvyDnWRq/vdGzPsemY+nQaej1N3YtrNHSsBDeNNlG4U/VrVPrPYjWlLwyd3pqHOE/im6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr2kBb4NZ98nwKNyfqdHwLKnX2Kze8OTBHQNYurJhp4=;
 b=0p/mPHPLyd93S2PZkT3McUNFkCxjfbVDu3Se/OG/TXWIaMaoD09/PYUjX9iVrvBwb8UdUGffQPdbm7lWKOhLQzxvN3o/UzNqTtTt6BobqCG42cFhcrsPUtIN4ifCK3NWMKxYnqAwCCKh5yn1vv4RfAIwy8j7jenHgJx6eAwEURw=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 13:21:30 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::b4) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:27 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 20/32] drm/amdgpu: early_init for each vcn instance
Date: Thu, 17 Oct 2024 09:20:41 -0400
Message-ID: <20241017132053.53214-21-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd0bd76-486d-4ccb-6cf1-08dceeae9cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4I7kwXjxoK11SMd5vwxNcLrCUDczgRHzy02uPG0IrOecqghr54Lo8zhGU8w2?=
 =?us-ascii?Q?4AovOFZBxLI+naugft/QJZdeNy8g8iDatqTd+MZAQax6v7ZJ7ABmPMXXK9vS?=
 =?us-ascii?Q?Keo0AlDbRZLrgUSlLhe3aF7aajBVDYHZUxiT3cd1oetR64Aq1SOXd0NqaWap?=
 =?us-ascii?Q?6OJv5+hOVqNVsdfzAVsu/QzBcbrVjB3b+HXHvz+6UE+N8HhoqnCY2jjWj2HH?=
 =?us-ascii?Q?6D+V5msDkdGhwIWGslubOq5BL4GKZFQPsegmr2c+iGZLnwL+S3vv47D7aV0s?=
 =?us-ascii?Q?lqrE6Yw9aNwwLLRYKHwXbHF2+dne1QhdvamXMY2MY0UYOo+SjXQlNrDweu22?=
 =?us-ascii?Q?eJqPjZDpOv24APbizB5pOpAW0eT/W+4NzmZ/no3NZ0y5tYBQTGIOBY414R3W?=
 =?us-ascii?Q?aDMJrFCcust4T3OW18D0VhsR5YvkCydklgql3X4p2V5lbk/VWtVJMQS0G45O?=
 =?us-ascii?Q?VgpRS997zxoQoumNQ+xrDkykwTUSl2jJSwGfWbwo5T+fkvkpEUgQ+RbarQoZ?=
 =?us-ascii?Q?+++JgpOLijKdetlvWnLNOEjDEYzTn1nENclayD7nRNIJmhlGNMdgs5uDOYia?=
 =?us-ascii?Q?Xl8QqWa0DU7kcVNW0OyupO+RJ1uRj82fWTOBotm/9wIinD620bhzjfRBjbyg?=
 =?us-ascii?Q?sWMgDCHaQAeg9KEg4aRbjO9JZ493Y3bC4PB6kGiLAombf8L6z730r633zzDW?=
 =?us-ascii?Q?RVsvjMFefbhMfyQj1aqxWM/vIwR7buyHQDSw9LhZAw5ku37Pm4yPrA2Xo9Lg?=
 =?us-ascii?Q?sPAWyeqPv9n/VTLF59LGOA4gXiLFg/UaqnO+lcU0xS8N1hC+eFX7ZkCRkHB2?=
 =?us-ascii?Q?owoW+jAgA1gijlhTWS5MOyIFk5QmYmDpMgE1LnveMDPy81ZJUWdktmfaM8uq?=
 =?us-ascii?Q?4iHGMlYHJImOUr+5ngRuDv7FjMw+ql422BZJgFdFdoQzyWoyOd4HbgjgJa48?=
 =?us-ascii?Q?X/g8jjEEj6WWOPRt6iMrcb5+MaHQ8nPvpMZ/q0hYjOkQ4HycYhsSMOXlTVR8?=
 =?us-ascii?Q?VRo0dTRPCYTP4TfRHP4I6kDy28+HMIrgnaN9EQDxUrV0XoEwiHcKkACpikp+?=
 =?us-ascii?Q?QaKKn0daRkdn5uBCLRIN3Yv4Oeuba+IXo+DXHXbaEv156p++ysfPN4zgE8Oi?=
 =?us-ascii?Q?ePK5zQqZEmiyAwsfEBhU096+vN+0cgg3YeWumQzyp51gTwBsmtAMEGr7fOui?=
 =?us-ascii?Q?CKcZnGA9CL57zuTbUOzJFxYLRIGTEenFbsdc2wIUDfJZ3Bk3a0rtpN19VUSe?=
 =?us-ascii?Q?NRASs/YjpKNbO8oJgg/iVhFTDr2WB7bGNfm7BUARit/vFO2GIvKznCq0+7t6?=
 =?us-ascii?Q?ZX3bdMR1ojsBq9mUXnNGnlp3pfFNy9ayPWP1BAjVCN98d7jGtWEYQ4ZS4fUO?=
 =?us-ascii?Q?xQNRaeJCoeiiFPQu16hAkfSUJj9klJbw8rjklDn1Eu99c+4LAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:30.1637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd0bd76-486d-4ccb-6cf1-08dceeae9cce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_early_init(), and perform
early init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  3 ++-
 10 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e93d3ef2fdd1..e2986871f3a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -91,22 +91,23 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev)
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
 {
 	char ucode_prefix[25];
-	int r, i;
+	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
-			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
-		else
-			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
-		if (r) {
-			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
-			return r;
-		}
+
+	if (inst == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s_%d.bin", ucode_prefix, inst);
+	else
+		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s.bin", ucode_prefix);
+
+	if (r) {
+		amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
+		return r;
 	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 38488194a1e7..acf4b88e2797 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -483,7 +483,7 @@ enum vcn_ring_type {
 	VCN_UNIFIED_RING,
 };
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev);
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f093d66df1a0..1a3907295e36 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -104,6 +104,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
 static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	adev->vcn.num_enc_rings = 2;
 
@@ -113,7 +114,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_early_init(ip_block);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 15c498b2b0de..d14062e1dd31 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -108,6 +108,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
 static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev))
 		adev->vcn.num_enc_rings = 1;
@@ -118,7 +119,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_0_set_enc_ring_funcs(adev);
 	vcn_v2_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 880dc4790a96..5d145adbe932 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -118,6 +118,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = 2;
@@ -125,13 +126,11 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.num_enc_rings = 1;
 	} else {
 		u32 harvest;
-		int i;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
-			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-				adev->vcn.harvest_config |= 1 << i;
-		}
+		harvest = RREG32_SOC15(VCN, inst, mmCC_UVD_HARVESTING);
+		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+			adev->vcn.harvest_config |= 1 << inst;
+
 		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
 					AMDGPU_VCN_HARVEST_VCN1))
 			/* both instances are harvested, disable the block */
@@ -145,7 +144,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_5_set_irq_funcs(adev);
 	vcn_v2_5_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 464394989dd6..464a502a7cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -124,6 +124,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
@@ -147,7 +148,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v3_0_set_enc_ring_funcs(adev);
 	vcn_v3_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 2994328982ce..58fdc07d9641 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -114,15 +114,13 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
-				adev->vcn.harvest_config |= 1 << i;
-				dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", i);
-			}
+		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
+			adev->vcn.harvest_config |= 1 << inst;
+			dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", inst);
 		}
 	}
 
@@ -133,7 +131,7 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_set_irq_funcs(adev);
 	vcn_v4_0_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 166e86fa7daf..4641534bb768 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -105,6 +105,7 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
 static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
@@ -113,7 +114,7 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_3_set_irq_funcs(adev);
 	vcn_v4_0_3_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 26de66ac0af3..d5ef1b0bcf54 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -112,13 +112,14 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 	vcn_v4_0_5_set_unified_ring_funcs(adev);
 	vcn_v4_0_5_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 5987a8af22cc..88248fcfa138 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -95,6 +95,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
@@ -102,7 +103,7 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_0_set_unified_ring_funcs(adev);
 	vcn_v5_0_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
-- 
2.34.1

