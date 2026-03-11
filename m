Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655A51125875
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 19:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E9110E3EF;
	Wed, 11 Mar 2026 19:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iZmuE1xi";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6F210E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 19:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSqp9X1TPoXGEFdx9MpRQaIbZ+xNSNvEDuRXjuxNlZwO81ajUXLwZR55rCX/JqZOnS2lQbIIXggiX6p8FfWgbe2MTTfN7eNZs8bu0Wx6kJe2EpW3g15ZMMMhMnu8nVqXFQJUMK3jqMxinHI7ahQ4Ty8DMgS5SD8ohxbWkEHLVZS/4dlmOuzHmB6czVQYNUxkTOBgqI9PP8JyfQW2WVylKynWtmX8L2UkpTtOgc3qsmsuA4pH2/dRG1MyL5arsr6061ja/Rw/Sb7GDlFmL6hHTS53RkZlgphLlj5RjAeOFR+UD6gK7M576wJLERGsdVU3TXIuHecVg4W0ppARp4IohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo9vBAKtUdu0yG0C+q+UnuBLkIkPoY+dSdS3dOOOSPs=;
 b=BzhRVpoLOs4r+GDtZljEjrc4Xyhm0nriQchdxIMA0uP+wEtA2kMHRdCLPXT44OTvyfqcYUdAzEMUWSegg1KdzR30OJMtwzKh+CV5WJ1rI2eY9oAZJLRTj7Y8mu5uKPh1k44qe6AZv9bHebxvZeYWA/az/ZA6meddLsMfTG+vXbsfaRdTmnAV22iTZHTz4hrDaviycoeoI8X8IZfcdN+U4UzudwKl5pKlDZc2zxrnFJ6FaDieJ9yGTCuVREH5xWG03A9CV20PHzre9ZtCUce2Q0Q2hrr4A2x7VjdY2h2/sR150B22tYjcIbeM1FfdLfg1mItm+/G2YBC1E6bdpvcWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo9vBAKtUdu0yG0C+q+UnuBLkIkPoY+dSdS3dOOOSPs=;
 b=iZmuE1xi6ONYi8c6RHYeibI851+Xdjcf0fYPrNujfs1OJPqRKlZysBCvB3hXtT9Vb0XhdWWz9XSPoCmJI3PN5Rg+V49XnxADtJ/Mz0eD9o8hgE8d0lsNN9Z2KjL2i8NxkGu7BnUM3Jxfhem841dLf22hThhJYNnDGvwskjyXK0s=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 19:31:30 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:5:3ba:cafe::16) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 19:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 19:31:29 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 14:31:29 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <lijo.lazar@amd.com>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <chenglei.xie@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit during
 reset
Date: Wed, 11 Mar 2026 15:31:23 -0400
Message-ID: <20260311193123.2531557-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8738adb8-9c4a-45d3-b515-08c7cfbc5b29@amd.com>
References: <8738adb8-9c4a-45d3-b515-08c7cfbc5b29@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3bfe39-a5a9-43a9-8c22-08de7fa4cb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vrdpr4n2D0m/eKxKfpJoBPO0AgqhZJ3YbTtseIrBvmOTvR3r011UGEOUgu9EgFlGMqraX4pE5mfRo+BD8eIwNbA67Eij7kcUTjVzJoRbOkqYmAJTOwYW9G8IS+7HTO9IrDXEIwI9ssQUw3B6jZuvyBo2iDOD3rdzZUJPy4Bv/IX8Zb49uBwYUwNZzv/RO9eHjJyZFP/F3BMUOhkoRvk0MXSrfBGCV4vxpW1EbhvXQVU5wLoOeQ8QemI1fyIuhk2DIpayL9wdeZNwKCcinsPpX2JCosmhNS0O6WU7WALS+rpZrCwaa42jhly13FafZoJWxXit2eXhQz9H/nogpSYY8gRL4VlM4eVG3LlGL5Xl2YfVrRWdO3+bXbqe8Mgei/wFeWM4IHVj6W7KTwJsTcJZUjlb0hlWW+z5zvV8DKcQZn1CTbl5SjTkOK7Tah3sl3yWLgjoyzLEPCmeQSPejHhiRfuMJq+Ns7Pp7wbhnogeio3VSOJ1I/QHe03yMr6z5jZeqkwmj7EVih7rrSu2JBWKw6xNwDdaK42Ld0CNZdQ6PgWpqhGuPOKRWHQsi6njJWor/g6k3i5W74r3NIMCSAJscgl6nKDVqaAv/MaBl2AAXJoGwgGQ/MmF5GG+viw0XXSopEkA4upAg/F3pGjusAE9e9PY2yTRoUfWkfoFv5iPFaVMi43x1GaCSz1/DN5CnAMrZTbZoziv/8vbSFzAvy7cKON8AbSU1SFX+jdsStNZPyuwKQV1CUdPBZq6AcrcoxMrNMV9QU2Rh79QrsVTAX4Ndw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PAIBhrO8BfbzRUwImSCHWfnHBCH6HfYi0gntv/i4flaEq0DBoqGkW6oOGgVPXl1xPmRcDURVmfwWx421C8UNvbsW+jRry8+WSKLW4V7HlpxBlWiPan5rlDV/3tG4bby1Me8FhC6PVufA1ZBn4h5MJh8/xAvRJLSS/RFt3OVd15VUxIefTnLAvgMe+6lp/thQ3sA5pNXeaJC034FlXIGYarnzbtj97MYSd604u9EFxOwsAAznBve+9kQ1FLY+1S+6+QXZt6isF2htLBTlw+COXhVtVB9wVLWXX2DfPPLbW1tahCN2WG3ZwDIh0RgaJPy9C8hguLiIs5CjAHClBbDXSyiROctGg5zlG07IdnGN22PHs8s+mKk+2k4bngcm4dPKziDIm8bq0K8qGRb6Z0mL7gYyVLtZz3zCwmZJiDcATo+Fl8wEJCONjWMl736g/eV2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 19:31:29.8827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3bfe39-a5a9-43a9-8c22-08de7fa4cb8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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

During GPU reset (SR-IOV), amdgpu_vm_cpu_commit() is called repeatedly for
VM page table updates. Each call uses amdgpu_device_flush_hdp(adev, NULL),
which on SRIOV runtime takes the KIQ path and submits a fence to the KIQ
ring. That floods the KIQ ring while the GPU is resetting. After reset,
hardware has cleared the queue and those fences are lost, but fence writeback
memory and sync_seq are out of sync, so amdgpu_fence_emit_polling() can hit
-ETIMEDOUT and block further KIQ use.

Fix:
- In amdgpu_vm_cpu_commit(), when the device is in reset,
  use the non-KIQ HDP flush path (amdgpu_hdp_flush) instead of
  amdgpu_device_flush_hdp so VM updates during reset do not submit to the
  KIQ ring.
- In amdgpu_virt_pre_reset(), force completion on all KIQ ring fences so any
  pending fences are signalled before reset. The other rings were handled in amdgpu_device_pre_asic_reset()

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I95404ce348ad546ddff1ea3b95a3f790299eb7aa
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c |  7 ++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f01f385091083..5998e0a04d760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1191,9 +1191,20 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 
 void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
 {
+	int i;
+
 	/* stop the data exchange thread */
 	amdgpu_virt_fini_data_exchange(adev);
 	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
+
+	/* Force completion on KIQ ring fences so pending fences are signalled. */
+	for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
+		struct amdgpu_ring *ring = &adev->gfx.kiq[i].ring;
+
+		if (!ring->fence_drv.initialized)
+			continue;
+		amdgpu_fence_driver_force_completion(ring);
+	}
 }
 
 void amdgpu_virt_post_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 22e2e5b473415..50ab9f9604834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,7 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
 
@@ -112,7 +113,11 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 		atomic64_inc(&p->vm->tlb_seq);
 
 	mb();
-	amdgpu_device_flush_hdp(p->adev, NULL);
+	/* Avoid KIQ during reset; use non-KIQ HDP flush */
+	if (amdgpu_in_reset(p->adev))
+		amdgpu_hdp_flush(p->adev, NULL);
+	else
+		amdgpu_device_flush_hdp(p->adev, NULL);
 	return 0;
 }
 
-- 
2.34.1

