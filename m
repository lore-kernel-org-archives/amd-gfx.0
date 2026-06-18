Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82122CD98F8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 04:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1161510EBF3;
	Thu, 18 Jun 2026 04:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5ymHSsc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012035.outbound.protection.outlook.com
 [40.93.195.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97BC110EBF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 04:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZYkRXYaW4E5ZFUcWqAX2tJLLT21btkr8q7kqJlo5eWKAA4HVqJzaxCYvXRVOvkrQIuaZP7W5Md3JENQwK0UYOJptRVie1rvCOqkRcBChRnscpYZ6qdzfLd61Tt4KyJlDq+KPlg5dO9BX1dP+S36tE8wM9DRmkbe3rhvjiGU5446W5abZiZXxrRtdZsgsr3CwjzDkNUAIer8/kJ45rFcipPt2n/73YwrUHiLDl1psa7OyIGk5c1Aqb8by5yfkyGUExEYIkaBGp1bVCd2m4e9KiKWG807O94+1/l8uPWuC9hng1RM/WPkJSgpqV1lHZzBe71Oy82r6SZ7qXa/xID/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2GxXOHe/oZ9rCK+CAX2E87InGgwrmPBtQT9C+fN15A=;
 b=iztXfp3T58TCHfItDY+4a1SxGmSyLUR3/JA7E02am+cXuLmBjg4mfKFqkNC3+ghyNc/hMYVp1wtxVyflODG7r9CyZetqbhY43j4IoQbxQQe4wz7iUU7wD/+RrfMHh0eE6uV6gD2e8ABoI8xUwEBw3RbUABYQPyz+zg1xJwEWY0dOysoFqNFxXixxLVeIS2wCeSO1D8h1rKq05ybDDWstc7EzUPs/xIHWjL6Vfs6zowSSLYBt+jtLT96MFzfQst9uzsz/vz9p9pC4lRhW06pT3HjAofY4CeqbAQWJaTr1Y0Ztpwj2urcuFgIpKKuPqPkTC2yer+K31E1thWhNUIvjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2GxXOHe/oZ9rCK+CAX2E87InGgwrmPBtQT9C+fN15A=;
 b=m5ymHSscqrxcj3mogO3c7sSJJcddmRzeDlGLjp5RsURZ0IuUNm1CwoLF97+4SsCJt9+q/uTMGYjmjdPJO+5Re09+Jw36FtxmQR52sqZN9cq9F2yRkRt1yYTubf5UpAY6tTt3csVsDCglw+X0tu482k6dtNbvZ2FL8XAVDlpt7lw=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 04:44:44 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::78) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 04:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 04:44:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 23:44:42 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 23:44:30 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 3/5] drm/amdgpu/gfx12: handle error interrupts for userqs
Date: Thu, 18 Jun 2026 12:43:38 +0800
Message-ID: <20260618044405.1724370-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
References: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: c052102f-187e-445c-4e86-08deccf450dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TgCOUkqmYb3JPnuCh3Jy3XYfkf7mX+wG2zu7eoi8IFnQ60//0q9d48z4ttQ1J+EBRtW9/7hPVYStWpo65akf48n1QCoA4c6ZUSHT2vb6THsNC71cge0dhQmoJIKoEEgkmoxfivKY0x8JiFeBjebHeiLZex/epf6JoDzRtC5+iqSh7gFSNXVhFBrNaa69TG0waTJ+rVHoLE9tw6caiC5YJbm5xFbdUWUHxXBTyK/KbQTX9Dh0Zcd9Cnc3DHYGvsbdI6bzd/tPeLX/ATT9+E3r3Iu6NKw5ZQsbkkKMelUw3pin2pUC0x66i1WiNX2oFe0aA0HVKkEjhvI8v3+tI+T8N5TrA8FHPAR1vM9YFnz6wS8cbrsmToHH5C8/NU+aZUSbUVD4ved6AuZp8CdcuWGUWhnTbiWM2nAROjdfqVg9l2wTTUrXZr8qGHwF9KqYf6svuBBef0nTF8iSYjv8zLGCtgn8oxb85QNpi87HWQNczzvamor77dcUr03GdzFGAjFktl3Zs2lA8XnlgfFlhI98Cz3Dkl8VOpPmKFLXEZgczDGRVcIjCzO7gyOspatPZSU9bpOfIa7d+7vwg/sfJxgyxedJo/93nBoHmYUn9DD09acQ6O9hcnbeDiQ91p1nJt2lQux4sTvmL2ytCguucblE5S1ITOZ0YqCtiZw6YiRM9bknN3TUUXWXhiH0p7rJnJLfvBJSOx6q0XNbvx1YsckNiwPl+wyV5CwFOVApHJFVHxw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F6S8R5cGt2OqSXUG5dIHBAVOp3m/Ao4u2HQqm2ddP3dhI4qar+RVYtoXQ9DFKhrZCCYlc9HMs0lMA6i5IaxuVIS3MuCwYS6T8AoMNtCgRBni1PXxdqQa3fQQS7Qn8ZwWygxMAtlkgSwQtJxTM3inMTD+Kf0teqLdIUKttNyJInEXwDUCbbeXgKWv5IGUZIXHy2gYiz1Je+jStAg0CGII426vA9GbtoZ84l86GsTV/5EpUkdW9cPC7CwfTuv+GxDEp8bGevAtpWkc27KsRiIVqP6NEX5pTN1fD2rt32ScCh3RC0scKnYLButAMXfzy55a3kWY1AcpP/2uVKleOWB401pxcnmUNFJvM9XULoRjzpwMhP0FJ73ne3BSFKRLmAwIRzqV99uqs9IaUYJDHeXtZef9gL4Rn5u6uGcVryQ2ttaZ2Z/d2PzOk0xJ7uMD17Yt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:44:43.3562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c052102f-187e-445c-4e86-08deccf450dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557
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

Call the new userq reset helper, and dispatch KQs first by ring_id
before falling back to the user-queue lookup.

v2: squash in fixes

Co-developed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 +++++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f8280cc81a66..3d8975a32e4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5011,22 +5011,30 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
+	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
 
+	/*
+	 * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never share
+	 * a HW slot (compute_hqd_mask contract).
+	 */
 	if (!adev->gfx.disable_kq) {
+		u8 me_id, pipe_id, queue_id;
+		struct amdgpu_ring *ring;
+		int i;
+
+		me_id = (entry->ring_id & 0x0c) >> 2;
+		pipe_id = (entry->ring_id & 0x03) >> 0;
+		queue_id = (entry->ring_id & 0x70) >> 4;
+
 		switch (me_id) {
 		case 0:
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 				ring = &adev->gfx.gfx_ring[i];
 				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
+				    ring->queue == queue_id) {
 					drm_sched_fault(&ring->sched);
+					return;
+				}
 			}
 			break;
 		case 1:
@@ -5034,8 +5042,10 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 				ring = &adev->gfx.compute_ring[i];
 				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
+				    ring->queue == queue_id) {
 					drm_sched_fault(&ring->sched);
+					return;
+				}
 			}
 			break;
 		default:
@@ -5043,6 +5053,11 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			break;
 		}
 	}
+
+	/* No KQ matched: HW slot is a MES-scheduled user queue. */
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

