Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099F21073CBD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C37210E663;
	Wed,  8 Apr 2026 13:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eghmqgA8";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891B610E663
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZgrAvoCLmJnkCQYfI/vW41/62GZIUTD6JK4arFoaf6oNcoxaM80MdIiofBu17VYESmu4sxGbbI+fru7r5fi2NMNzyCr7CWjs2rLXhNsk9IKntiZyHv2xNCsjvgRrzlxVXsOh9CvQvqMPLFW1Nt1GN6aqCyF7bdeKNNbPAsqacB4BFm/HDw8I72x21dzmP7FS/3Pu805lufa5WAK9yIuWCxzbqgldYqt62so1+5EACDZ6mjwwKEv4dO8h5tqPIgfn8hD4Fpt2QVJu4oLu3MR1nF+8gfg6DPjS4KAuDWl3LQMdArSnx+BYMc74gzcDC+Ho3+szpXO5wcoK+hTeO1NEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bzqa9WorYxNjkHJcKdMpTSj+9ImTvpPOp+XIoc3ve8=;
 b=ln1ALXRW2YIxcr7Fy5AdYPtmRvSxi+vQs1H1JIOOkgHvmbB3/CujId78ZUss7Q64QVOPMdp4F3wgiadaO2uHWEJWZ8XMCVz8MJ8XEkzhQ1PcKBNXchSzXT2sYKOd5GbMvW6y58YRKu1URWoV6NYjVmOoFySiMTk+XOI+OL0K/hL7L3+Y0pbSQjPydNq/DN4zYoU9/80ejqG4cFcaC3K15aqWeqkrCgsrznrzK/dF6b4HDZx7bb5LFXf5iVquOvwegIj7WQjpYz7i5EXIyhESCamGedBGjZxH8RiyAu2vxJ0RnxmYf389ANAT0QSfM79ig7fgkjCAQ0lBOhU2COgYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bzqa9WorYxNjkHJcKdMpTSj+9ImTvpPOp+XIoc3ve8=;
 b=eghmqgA8tmWXAZ9F4vcwv1iyxIrj5zPKC5xkSpUA/gvz0rRJu/YdmSVzpXxCciKZBiSw9AA7PimK5UK2o+AkMdz+WUCBCer1FITcXbMaPwgeBqH2ESavKFL4xVg5DiJBfkcTYk/STfdc7n2MQ9kSx6GYY2LQKq83ysFz4TXivnQ=
Received: from SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 13:42:46 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::25) by SJ0PR13CA0032.outlook.office365.com
 (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Wed,
 8 Apr 2026 13:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 13:42:44 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 08:42:43 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Felix.Kuehling@amd.com>,
 <Alexander.Deucher@amd.com>, <Chenglei.Xie@amd.com>, <jeffrey.chan@amd.com>,
 <zhigang.luo@amd.com>, <Christian.Koenig@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Victor.Zhao@amd.com>,
 <David.YatSin@amd.com>, <Lokesh.Dhinakararam@amd.com>
Subject: [[PATCH v6]] drm/amdgpu: gate VM CPU HDP flush on reset lock;
 force-complete KIQ before VF reset
Date: Wed, 8 Apr 2026 09:42:37 -0400
Message-ID: <20260408134237.459380-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1183a801-a04d-4550-11ff-08de9574b6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OUE3j/oTjxwIbESbBPnP3fk38KRwhswDCs7YlSUhpmSnTxIyuUOMQWyIXbv2synFAKv+D7/8hxYeqDe8M+Dg7GwkCLYol7F0g6vxa0sM5ZZCNxKfY4+p71viBFxmTxzWJ5PCcUW+FWbUNZFE1TY+OgGwUu7yBo81z72SrMc87PHGao1T41kNPDUUuRtR4yVgc6iQE3dJ1v38FSzSXUrwJR63Dam+All+g9CjXRAyLYyLk9VWCUR9dxzdbdILI0ZNP1si3xJMJ+P8sFToHKTkrc0tYtKIy+kumwxHGHypdbYhLTH8vYmN46E0M1DRtWGPEjFgTpjK4CFGDuiXN1rbd3SZqj01Ut2sHioJdh3E1rxBEmk8cnpV+iDw+YTLeaWXbZfl/6SWx0F73GE39UrabxMDTtarT8JBv5lZLXyLsZ0FFaDUaPx8AYM8MFDR/zdn+fT+xxGNi6dgoH8hdmKHdEXCjt0ctVXNZr2h9GBtMqD2042L4zl0TN3jCaTMG4PijVPEIrhdn9uZ93zESVzU9aYAhVhjOGFO/9lNBzs2PXy8xsVLk5OcUxGVTrCb5ZYlnNLeJPNOxKc1gD/fCksiQ5c/AQpCDbg0x1Ipw+4r/Halz0Xw7EBy4s7MXXS1HXbfIZpmxhRIY2CNGQe1c+vgJRTJxc+wnrszc4OaWKDmmwLlahLPRHPHtDz1ww1hqiZUGcrMcQpSeWR+vXK8HTL4yvNpFYe6chNsdEzAA4dQHifYedI68CzTx/LE0VmRziOhO4ZbrcVHG0Mi0Gc6RZMO5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CmmKXZ613AnjXXRR2AKWm4nO3nrfn7B98vX+a14TAGCrWu/tCMPfX1H4VZq606pSzM5DTdTiGBFlZUpaSYGW4/EIcX6byvs5c0iFH21Z5axUuOqChabylBeyMrtvaa/GusGVaJee+utP0HMoMFrS3twIlICu9EZ1GjfANUcJo0AVFh5qX1LeFupMihYu3kxyYBXOTXcire1oIPArvCO23ltx08LxSyyMnAXwp+mYFjzhm6i+4DRgh6eCYBmBwreXzVqOz45FWnhVdi+1+nKiPO8SZnc9dpU30y8XbBv5+j149o+QBd0Ol4kJNl3Y7c0G8Q6oClTIUhrNAstveggcQjE+aOZQ15uBzKCVKG3Pv7YZxk69ENLu55+gqBfafpdBFpj/KcxRSRXiX34tjfCoasbKug3/9zzBWlwffpflV1Tk4q0VX7GVKhisqgWs7r2B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:42:44.6369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1183a801-a04d-4550-11ff-08de9574b6bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

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
index 22e2e5b473415..a9e33b7e87406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,8 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
 
@@ -108,11 +110,23 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
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

