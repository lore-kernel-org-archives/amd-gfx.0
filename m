Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9894CC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9662310F725;
	Wed, 13 Mar 2024 09:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cdUSZTMs";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D311610F723
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Elxv44ncxHdMn8Cn0GxVMEm4UWaMU/GsEZutwR5gtu8pW0FdS/r9tIK6cd1aIy2LVf4Hzk6hQuMoMtQZOfMhbs/+AoCcQx8y+lmmUyaPvNVgS7rzkAYrRX0DCZT6s5qAWWTPe9G3jPxXvent+3F/vkJHGFg8j+cPO16aUIoUwkV8YhB+UJ0GjZgCRrDqHcQMs2nMC/fDsL7l1hCwpTQf+hRZOTCcZJXxEQTI25X2S2zjaFfv6Dxur7M8CYB++uNAOlpsML3p669SEulPIHWxGTcXJzt1fIlQMlIeYQgxuYG1G++tFXDigqt2LJ1gcDixD9xVtbfkFWtDJ/p5rpEJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WtW28Hv5BgBWTDMm7kyGs2zpL0WjUx6ws2BuH4Ot9w=;
 b=OvrUxPlmSeUqUikHOIDGBv4SC3VWFUqFaiUBmBvOlos2BXUW3WY4FH1y67mIoLsrrj9gmBC9gj72n2S/I5aWC0SH5i5OUyhZ6dBy/Z3YyZkjcw0igT/EdizyuRMqRAgVghqSKc1/7df0/w8PqamhVOlfJlPZiUN/HeUBCXJp8mLAn9rm1A8SqiCMh1H+DsAGm6Yw00kIkCxry2REdbLk2a352xhu8+o/62sf+vS200p20ihMNIF6JCTUGpQeqBI2ddZ2bMndh/UcJ+FybXWW/1j138GnQDSRAMXN9u57akoE41VBnSeKHa+h/DU1ti1T8i8URYnelXF/4MUNTvAU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WtW28Hv5BgBWTDMm7kyGs2zpL0WjUx6ws2BuH4Ot9w=;
 b=cdUSZTMsDjP0pswbAH1DUlMbdHfNUHSU4J1WYyB/66Adt3WF12Pogi6EsCpQyMaYWTe8K47wY1fdOcWJKueJWsBKzCetQNfgnV90ape/T14dS73WHRv8vYT/oc9QMT2d1Ow/PUVi991AR1+9vLVL+ln1S8BnlvCeXKo+L5q3Rco=
Received: from MN2PR02CA0035.namprd02.prod.outlook.com (2603:10b6:208:fc::48)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 09:12:06 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:fc:cafe::7) by MN2PR02CA0035.outlook.office365.com
 (2603:10b6:208:fc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 09:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 09:12:06 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 04:12:04 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: support utcl2 RAS poison query for mmhub
Date: Wed, 13 Mar 2024 17:11:54 +0800
Message-ID: <20240313091155.347161-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313091155.347161-1-tao.zhou1@amd.com>
References: <20240313091155.347161-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: b310bcf7-d61f-4828-7515-08dc433da77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMf2qUdFWFkEtNzFjz4svtV1aQ96aQfTFY0KIr1epmBLh5tTaRlX8Pc+3ndtgSZOEq4sUFT7mEmWqDP40ti77iOyjPKT2oWzyp4NPl+XdRVONgBu3iLShlAuzazH4ebss0ddAmtz6B750l+kyKPuAWxLpZeAg7dnfVCbDrhIxj/IPMtcF7PM/wwGf4LxLjazy2WACfOkGqRJX7nVtdroMtyX6piXnIr9r3Kq3Sovo8KzjK75o/oMViDodKrg0himO8MQIUDBvu/KFU+w/3HtpQIokZ3WvgVZYJ7+6+8sGgsk+SYWAKYJgTERoTarStfUPbHFVk4RkqRKyhI1GRA7kTkD7z0URjPz4fwnTRjFaBlSr0/zXg2aKfFrQdXJO/Q6VqmdbQdLzUNbW+wjs73DFhZHZGbjJdg5wjZGz4CAe5D6YQF8fPoeiF/tlfajlDYGJw5G0OpKgzybTX56BtkVcEBmkUzQRGUVBJVp7oed4tVgaJFKpNQxfyT2p0MEA1vDY8vhaHC2v4O+FUt+IPafol4pGr7J5tJqrYNDZW787XBYrcoB8MJ1q1BoRbfpybIL3xNKs6lE/6U4Nwpq9e6Rd19Gh7sC2830lCLUg5YY1hQlOP2Q+njIzbokuWV4+k+Eu3EQYC18KTGT2lL2Yfr3aNq0BqXlyWHR6kiyyzNHn1kY40KxrA2Tmu9qpslyn0Te3t2666mAPxaS5OzOg0akdB0ZWQWhg4qTaWDHf8bh4kxOpSYRaZKSNbHTVm9t77sc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:12:06.1316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b310bcf7-d61f-4828-7515-08dc433da77c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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

Support the query for both gfxhub and mmhub, also replace
xcc_id with hub_inst.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 17 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c           |  3 +--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c    | 17 +++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 17 +++++++++++------
 5 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index fa958cbc603a..9687650b0fe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -782,12 +782,19 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 }
 
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
-			int xcc_id)
+			int hub_inst, int hub_type)
 {
-	if (adev->gfxhub.funcs->query_utcl2_poison_status)
-		return adev->gfxhub.funcs->query_utcl2_poison_status(adev, xcc_id);
-	else
-		return false;
+	if (!hub_type) {
+		if (adev->gfxhub.funcs->query_utcl2_poison_status)
+			return adev->gfxhub.funcs->query_utcl2_poison_status(adev, hub_inst);
+		else
+			return false;
+	} else {
+		if (adev->mmhub.funcs->query_utcl2_poison_status)
+			return adev->mmhub.funcs->query_utcl2_poison_status(adev, hub_inst);
+		else
+			return false;
+	}
 }
 
 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 73b7fa7c5116..03bf20e0e3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -406,7 +406,7 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
-			int xcc_id);
+			int hub_inst, int hub_type);
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fb19b88e5522..d615d0fc2c6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -672,8 +672,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 	/* for gfx fed error, kfd will handle it, return directly */
 	if (fed && amdgpu_ras_is_poison_mode_supported(adev) &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)) &&
-	    (vmhub < AMDGPU_MMHUB0_START))
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)))
 			return 0;
 
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index a8e76287dde0..650da18b0d87 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -369,18 +369,23 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
-		int xcc_id = 0;
+		int hub_inst = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
+		/* gfxhub */
 		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			xcc_id = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
+			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
 				node_id);
-			if (xcc_id < 0)
-				xcc_id = 0;
+			if (hub_inst < 0)
+				hub_inst = 0;
 		}
 
-		if (client_id == SOC15_IH_CLIENTID_UTCL2 && !vmid_type &&
-		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, xcc_id)) {
+		/* mmhub */
+		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
+			hub_inst = node_id / 4;
+
+		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
+					hub_inst, vmid_type)) {
 			event_interrupt_poison_consumption(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index ff7392336795..11641f4645e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -415,18 +415,23 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
-		int xcc_id = 0;
+		int hub_inst = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
+		/* gfxhub */
 		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			xcc_id = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
+			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
 				node_id);
-			if (xcc_id < 0)
-				xcc_id = 0;
+			if (hub_inst < 0)
+				hub_inst = 0;
 		}
 
-		if (client_id == SOC15_IH_CLIENTID_UTCL2 && !vmid_type &&
-		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, xcc_id)) {
+		/* mmhub */
+		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
+			hub_inst = node_id / 4;
+
+		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
+					hub_inst, vmid_type)) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
-- 
2.34.1

