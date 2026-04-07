Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706E4FF511F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 16:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72B110E242;
	Tue,  7 Apr 2026 16:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ZCX7WeB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8002210E242
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 16:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2RVNy5V8y4Upc7jZiVtnmcejOeWxIsrV657MHNP7DJnYvi5EXooECf1TME7bxOp71UDWJsarbls1LsOWrciMA7X/rixmkm3n65qCpNWLTj3bNC77TVocl3sLZQ0shzC+dE3hivS8s9ksPS0wqjoXloGqYagihnlFM1RNs7qb4+Iap4WdcK0NoWbg6ddS+qFk8a3GpfZeJ4EANP04Qrm/iGPiVF/JpxvWSUQV7odkvcZQFSuT4JuC/naXjl1OpC1gn1PmyZebeeMG0C8eNnWl/WXd0rpf7yg2QQNzgPSVWH0UjWNonK8V7oNzXU1SG5vIBzd/Of3En1UHAYHHjeGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kIy4fM3Qeu9KU25DOFZO8gOXXsMPE4ayGQTvc4A4OQ=;
 b=gDa/wa9+S19OcnYw7HqGTLbBc4TpRXHDaEbIDQwqomW3SbP2PNRg98T2y9hEwDBeEDBmNqeX1hMW55WSJauYd4PqbFev6kQ5mFn3k3jJRokdqqyVAjtMm1M817i5rgtFW+I/+lNuaRqCROKWtSNFb7HHIDCNkB+VDNqO/5rqhLPXTFyeYQ73gmUQJgxPSPCrorarwPfGvcHHwmKaBq0kaEj39DxnGhA8BPghjeAEx3F80V3Cb4Wip+bicnsxv7we3pECR/cv4Yl2PC8p6JcOnR1053SI6r0l/IDktp4bdlEjcU/FlwRCVotNWeqOHKfMhGhY9Cuhru3HTzuJuQR+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kIy4fM3Qeu9KU25DOFZO8gOXXsMPE4ayGQTvc4A4OQ=;
 b=5ZCX7WeBs5Ik8Wh9Gduh/AIdoTLmR1qq7OyTvS2mgdOXu22xxDIUSdEUwhGPStzcwXcm6y/8+DmM2wFAR1tZakwkqB7JoN0EuVhmAnQvzm/jybqfjPqz4D2KisZsNL0RAnkM+ncY06/mYFI/KS1hLywFW9y0pA757ZVeOEIQrG0=
Received: from BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::17)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 16:21:52 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::26) by BL1P221CA0039.outlook.office365.com
 (2603:10b6:208:5b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 16:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 16:21:50 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 11:21:49 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Felix.Kuehling@amd.com>,
 <Alexander.Deucher@amd.com>, <Chenglei.Xie@amd.com>, <jeffrey.chan@amd.com>,
 <zhigang.luo@amd.com>, <Christian.Koenig@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Victor.Zhao@amd.com>,
 <David.YatSin@amd.com>, <Lokesh.Dhinakararam@amd.com>
Subject: [[PATCH v5]] drm/amdgpu: gate VM CPU HDP flush on reset lock;
 force-complete KIQ before VF reset
Date: Tue, 7 Apr 2026 12:21:43 -0400
Message-ID: <20260407162143.63623-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 52663753-d424-43a8-b67a-08de94c1c646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: FIl/TL3Xqs6qcKYzTWjlDZ6JLBB0c3oceu7gXoecPjwJgPDBDAimPD1HJgBE0PERjOUOLZFlh+fMYsBSf4YfAcMbtwxFYE5vhGM/5mH7iXyOrXAXMy74CXrjDXBr/7CCQjRaitMm+V5cF1FXcbKuhwErRS2He8XELHkVWIYUSfBgzQzmp2lk9DSc5q7K3qKQC/KmPExuW3C3mXrnJzYxqs96GKseX6MMGVf4zf2Ct6k1yiCJusXknNJLxLwXzcm1s6sjncPoI9BSI4AvNWBM2M28+cPAFl5wn2TrbWjAJBRppCoAOAzmiLCDcCdEQGy2WudCHNUth/SCEcuAiQCg6Ebd/wbEZSPNXoQ+o1RkdYZzDGf8u83XKSfLQZPrJEX/TCf1hrJnsbGZO7i/n10Z1tQHpwyaoQb8lQgH5M2rJv48K3L6gOliBXVJ3ZOdIcQavvQdzOamZ42IqP5exiZyz0dqDVcB3ccEFLOOBpUh4J2eUlavVJZu+1vxAYnx0isD03Jl8yCeBV0Vcoj1jhfWhzRf3XEVNwQ3Hw0gpTGw8LICyhZvUxM/+WZ45FQcWTEWcr2q5OpfSFKwR7pgCBNXaNISzXa9cI94Lk3sNlYmbnWS10LI+DvF/GeoowTXTIPDKT6UqbDgIgX1loJ9DEJzsuAUdzJFqIQr0JP1tTF7VDrX5SyyNK1GbSPF/k294Lq78fTJCa9VhlyKfVI/BW2KGeHK28EYCMhAfa7E4WfUHT/BD7bWuo4YUfup6/BWDnuVdxsEnuou1VZPQomfqq9S6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5GuYZcevAxPnh3ChjSWDMa+IDK6o51l62VVoNHSgfrMMnTQ1YA13D+pNBxDi8IgGLmrE5CQ1cmMmwonkT/F9HbQgHML4T7eflV+fkQi9F2272E12iOHagyd+qx8QV4gbKooThbMHCgSceWSG/oox+80S3TvUZVKzlezGlPOfMoa5RnGtKfpetqd0b5Ev2JpqtlLnTsZv0lqHvUXyYvpEWFAenyxz9ErYg0Mfq9uk5FU2z24qtmDSLFHtTftcHWFncUURT3d6QtpgsIJ+/m6nYOAFrI2g/9TR6yt7RcmKPEgc9inQc8/lbz8OtdFoA5NxbkSoMdUDyHPMRJD+mF6Ly/obUYVvh31MyBhmHJrXSCsLK1zGBlBQIEapPQKdbGNQCyF5jg956rWziIVc+MB9sOtWIW/Y4A+yms8z1z7+IQLZkMLXq53yzTBT+S31a/bj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 16:21:50.8857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52663753-d424-43a8-b67a-08de94c1c646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

During GPU reset, the application could still run CPU page table updates. Each commit called
amdgpu_device_flush_hdp(), which on SR-IOV sends work through the KIQ ring.
That can advance sync_seq while the GPU is being reset,
leaving fence writeback out of sync and causing amdgpu_fence_emit_polling()
to time out on later KIQ use.

Fix:
amdgpu_vm_cpu_commit():
  Take reset_domain->sem with down_read_trylock() before amdgpu_device_flush_hdp().
  If the reset path holds the write lock, skip the HDP flush so no HDP-related HW
  access (including KIQ) runs during reset; state is re-established after reset.

amdgpu_virt_pre_reset():
  After stopping the data exchange thread and setting MP1 FLR state, call
  amdgpu_fence_driver_force_completion() on each initialized KIQ ring so pending
  fences are signalled and writeback is aligned before reset proceeds.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I938bce0cab93a794dbdb02fe3ca9e041f9ac1424
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 15 ++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..0127b0d6c7277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1188,9 +1188,20 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 
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
index 22e2e5b473415..f0a9bce66f10f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,7 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
 
@@ -108,11 +109,23 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
+	struct amdgpu_device *adev = p->adev;
+
 	if (p->needs_flush)
 		atomic64_inc(&p->vm->tlb_seq);
 
 	mb();
-	amdgpu_device_flush_hdp(p->adev, NULL);
+	/*
+	 * While GPU reset holds reset_domain write lock, skip HDP flush entirely so
+	 * no HDP-related HW access runs during reset;
+	 * reset re-establishes consistent state afterward.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+
+	amdgpu_device_flush_hdp(adev, NULL);
+	up_read(&adev->reset_domain->sem);
+
 	return 0;
 }
 
-- 
2.34.1

