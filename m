Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72141CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 10:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D67011A70E;
	Fri,  5 Jun 2026 10:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRkLIC3k";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6E311A70E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 10:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqspjHb2sG6b1VNUMgJ9o2DqN2gBYO9m3m68Ch8KJfHhrPToMg/yMzesPXlycYXOwftw4TD753Pm1CAdLH5CWXP0Ls+qYuF8gMPMPFksWSABZJyki9c/kKJclC6/rE7y0ZhZy3O8af1f10CrYoyBDNrSPG9pe6ua7mNgD515P2TjoSyW2nBdmPIlGdwWR3ryo6arCskYH4tS6qPEE65mOf1oCDxO/JJXSueXbo88nYd+F0q3Ed1f0HqiMul5eyjkDOtsewIFIDzGmk8I6rER5YlfRDo20h+5K31cr4bQwyKkt2UuuXwz7Qqj3rRsA4Vg4WfHKpiYjXHpH1d3mDVOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVDicN9EuPAWI1/pNp/kF5rR6LKwWe2H6jwsqXxWPFU=;
 b=MvBpFSPa6aUNTaYSrRPWgRkzA0ArrFtmRb8jxw88rZD+TstO85MO0zZSQW4bUIwzik2fiJVoJxeAdhI+uAQv84pCKppzUdCtapsiJvnWeu88fXdh7gtkL+pesfMz4xdmXe6tzYOXOo7ZGFqeWcuKgms8eBesHRVicxXvHge13TegkXETbEIqWsk5bbXUnJQy6JB9F67Z7sS3rdLP8oPO7LywKN5JT8HmHkNx3pnnIur/qURTTlf3/lEvOXPD0B1I6nhlWS/8Xy5m+nsiyX7CbgLT0xG8rn0JFf2Jm2MnDc92oDqGWP5e/lNVWct2oRqR3/RZv9OMRQeUsPtKEgo5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVDicN9EuPAWI1/pNp/kF5rR6LKwWe2H6jwsqXxWPFU=;
 b=MRkLIC3kS/VfqN1/hAfTKmpiYUWkyqmXvLy609cofay+Vl32OTnMlrKMyDqm+kQWbC3A7Ygz335f49mmpPL6NoD1vO95RN7rwFqj8qa9jFasTEFZ3gyePDR9MGHl9o+m0O/aOUknyks7ZYkDMpv5V8cJbqSkTnftnKgNQj5wbnE=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:32:19 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::81) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 10:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:32:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:32:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:32:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 05:32:12 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx11: try KQ ring_id match before user-queue
 lookup
Date: Fri, 5 Jun 2026 18:30:51 +0800
Message-ID: <20260605103144.2537331-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
References: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ed698f-4690-49df-0397-08dec2edb880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HwWLmBG4XwNdM6U5oqu9FBkxruQVl9+/R9lw5WKTqKVirvGm/982dwIwnQtrb52SfttHHl5iAGSBqEHr7wI4sK8TEWmszH94h26QeP/9rjWFVIaNegPmdImsTxWkbjDhVKbx5EedFfpFHLwCVRq/uB7ik0Ou6FxMR4wCZrPF3rb01daJV6gz0ZMHH74CWPc2I0B5ikG+U1ss4QnjPktx/DnKzyj/tAX9kf2urpIz8joBZIBUJTT9/K51aFNApTofHhHMzFlJNYN/vZFEbin3Ht2OHoIbLh5VqUoIzbwCHIkxD9d7Osdc23f1t/dN4WrUR9o5HVs1SMTTzszil/kuF83D7RPi+BAXyD+y54caHrRJ9NSX54Ct2yk0PogIMUrvop1NvTlPjSpvpZw+uJP1fIDAQwjGkWNSdgLjnstfSsPn8u8+P+xcQIBqAW27yvHk5RjXrMp7NIlJESvAqj8hvpEzJXyh93R4dd4+OLZ+m1NVvWYe/EOGssEN9KaAdeKTyuQbNwY6IrhfLv3aPPZhZekbC5OTabCDAW1ppKGmLons2QhYGr4FcfnpWNmxOFY9p1eoF9naNvzxfSKoMyOIY2E2R7fQ234qwrfamLjFFWOA5dnpEQDuZBWbOzHJLBb4rcFYLO60TtJA6Xhn9Hk2D1WZqDy2OyVjdPb9aERiTDxxdBqYBFtWjSaBoaO692+L7GI/7GN9xq+5TtgCMBE1JGvnI8X3YduMicfjZbGbiZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ReZ767Q300K78FJPQxoF9XSKylDMki5StwBUjGjVxQD7F/NfwL/vKl8nR1efSwp36HAEIcF/9tPn4GovEyAZC4ps/2ZxR18JPzFpGk5YDZrZOS4rz2aeeSNUz5P/aFT83/WMDPx5Ip73Co0TsOo3syol4w+KWwyBFmX3Es+pkA1+NUL2ZL+XuHpOOcyGrdkqdJ/D5Cuy4vSiavRaLwAzxViD4hM5wtuScY6jVvvtmTIg7Y6EIFcnpJEYnXZoVM431+JVgo4EOAnvGMdb52/9tvoJWZx1cQADBq2NNMthpVIUJTQ0hlFqA7xIjzM9/+55oVvgT7tv4VA7DxMjoIZZItk0zswT7fqIFDvoVkDvrAQDb8LssHZjrlGpGo+GaGxRRUWd41gn9bA8NByqz+WtC02bwAzM8TqZAPhntHFtPV0n5VprNg6nbRi/2QaHftNb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:32:19.0817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ed698f-4690-49df-0397-08dec2edb880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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

KCQ and user queues never share a HW slot, so a KQ ring_id hit is
authoritative. Match KQ first; only call into the userq path when
no KQ owns the faulting slot.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 27d0a3dbfce8..1f159c9333a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6688,10 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 	 */
 	u32 doorbell_offset = entry->src_data[0] & 0x3ff;
 
-	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_reset_irq(adev, entry->pasid,
-					       doorbell_offset);
-	} else if (!adev->gfx.disable_kq) {
+	/*
+	 * Try KQ first by ring_id (HW slot is authoritative). The MES <->
+	 * KMD compute_hqd_mask contract guarantees KCQ and user queues
+	 * never share a HW slot.
+	 */
+	if (!adev->gfx.disable_kq) {
 		u8 me_id = (entry->ring_id & 0x0c) >> 2;
 		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
 		u8 queue_id = (entry->ring_id & 0x70) >> 4;
@@ -6703,8 +6705,10 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
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
@@ -6712,8 +6716,10 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
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
@@ -6721,6 +6727,11 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 			break;
 		}
 	}
+
+	/* No KQ matched: HW slot is a MES-scheduled user queue. */
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

