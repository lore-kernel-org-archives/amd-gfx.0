Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C8CC9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 09:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF4310E174;
	Fri, 25 Sep 2026 09:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7Mwjjy5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46F310E174
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 09:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4ug6rIm0pzesu5XRBA2KT3HtXmn3BKNEhZ0O6Ep90i0v1FDsvK+NCo1qCwMuY54L+ibQZhj/MThFmRg0V0Zx2y61bJN18TA/W2XxnIVBWNbo9C+rmAQl4TYA6L9w5KuqMOv/NXDppk2/nV+Iisr0V+b8TupVWbFEGaGbAfNBvnw5nsQzh+7oIjmSvcW02tmhRsJdssAxIqYUYYjtCaFvNWFpo37HlAObYsQ6V+TXKTNQ+RyMHQHG1u9oFOPYzCTuLh1jmghGhvn4zqtT+NKjil1R5U4RJfa1eJrFtQpIrROKIP5jgcOvr4nVD3NIPyFz9I1GUKVM3cPWtvDtcmjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lROSEx4NpFwUAwXm+HmSZIToSdboEcqboHA8MVokZqk=;
 b=sAjgvOsLpr7O+VQxTxHFrVjcIglSg0H4C+aphZJRiyTaxx3XrAGbCloLqzkMHfzJeiznuB+GoAokMSI2cNvp5FsMoyaWt5s3zTp+9fuZKKW6e8wXJyvKdy6YO4TDo0my7K8j4bA8UcihKXfMfXPuPDsBgTk655N1XKNE3oL31IrcL6q3p53zm90pnJYtpeScRTZQw6O+TnFNNOHD5c5doalmwHvjYnH3ELsciQlFJFXJWyUu4RzpF7sZ65bE8e5TPP6CaqCjdViiedMn4zeGHxlgcH1b/Z1TXZ4yD5XPOsT0Z3Kvs3aba2Oth4iRSc5oEZir85ClwsYoBtth+NlMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lROSEx4NpFwUAwXm+HmSZIToSdboEcqboHA8MVokZqk=;
 b=v7Mwjjy5g4ExMKwjTZoI3xw1MnUw83yYyw8qV7c05X2dswmkcnursHHQxIHjmaVO2NF8BkqS7OijhNn5fsIjCgVK/EUOuwNrX1BJKmqFGF4sDHYIcry2I40niKwX4JUIwqbyzKFlCdmGpQ4XI5gAp2Y1YUooAledS7ob2IlaryA=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 09:37:39 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:334:cafe::28) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Fri,
 25 Sep 2026 09:37:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.5 via Frontend Transport; Fri, 25 Sep 2026 09:37:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 04:37:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <James.Zhu@amd.com>, <Bing.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
Date: Fri, 25 Sep 2026 15:07:18 +0530
Message-ID: <20260925093718.2737342-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cd5963-ce0e-4ecd-d005-08df1ae8a365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ir4AdzHY0OgAqvxJyNgKGLlJTEat6Z9bHWI+VMDFP0fOHstm2NHUQKqSVz8wLeOHcU71t5PXBIImonjAVNG8RXCKy3ntDm8Q6PVGGYYRvbYDDrc8FszSKe4q+Z9b57RibDJoq06gnLvPKISb3DUS6etA3+sXwL9P707zERUoFuuHFHzzBq7rYaTZ2Ol+3thsIXT9Rs6WmvHLQkDPCj0ymuxrisud9BfFar28+bMLvDqy6D6gwZqnlMn9gIkepW6Zs8wXXDKWAIhrM9B3AOzV0ILFQXCQGjDwEsTBVTmyt6QDdmTZhRC2d0uHAqSb2Xg++bSP2IVNeN0izqbb2jjZdAgHMrE3FHUeQDyJhF+bLU+WpRQDDfbdzjz5LbIQPekbuTIhN+MBPcOsQHXwUz4T0m0+KOGsW0tHYycDHD/WUKTUNrKLWfFpCpTU5IADBU+uBaUL6UHgvLNvdxZMtVkGZehCT5wXPsTzXSI/sB3mFIZbnyWFUowpxurXar+AlvkI3ISpl/nsh08+naCwwGJAgE167+qg0fMeh6dxZW1RVYicbZDjrP3yQVNmC13s2EeDwRsxN9M6qbSlxUy+eYbHoCj+RnRR6EnJ60TK8cc+veaxSWs65T3pKyypLR71KRzv1lpfjAENSltDTpvvS+/EV/X4qe/WQa8sl3CWmUZodaagaSoPnfOlGf6WnDLRG8IDgglU0Yf5QT6UnyPMbxp4BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w+iFxWlJ4fDIddFu6EuJXgO22eNtaRfW4jE3tjPEKSJkzjxZW5BE9qCjlO8/EBHG21Uxhpge25WI7I7whPtyJHUS91eLgPmFYJMx/Gu6Q7yzRAoTpq27oKiLfBqOZH0ZVp1eTVbrZHnAc5Wa+xCxXYd6ARGJUuY3UBvHBmly5ar5FEcBkQQrKKGkjpMaV7F451aFdVPV1FdHEjO/V0q6qljyX89C70HFT/9nhz+6SF3aYCqxFZ7H+0tcp4fhlr6Zb349xs87rE2j5mLbKffoAtzwrI4zvMLpqDC+As9BY2vIg30F6LM6PMPkZCAd/d1n9ZC68fDsBCRWdysYkhOMXvltgrqHUYbJ/aoGpRizM3PHyKo8d2rJ3vUmdJwZ3QiFDxBSaBR14VmogUNwLlaOUGcDC6SlZuFxVSGMqVYKlg/gRwjnF81oot8et4My/sSo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:37:38.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cd5963-ce0e-4ecd-d005-08df1ae8a365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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

RLC SPM is updated for GFX subsystem related performance counters. Only
jobs on rings that use GFX subsystem need to be updated. Some rings like
SDMA could be inside/outside of GFX subsytem based on SOC. Identify the
rings using GFXHUB assignment and use hub id assigned to find the right
GC rather than relying on xcc id. xcc id may not be necessarily assigned
properly for all rings.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 31 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 0f8b097001e3..6ea73ef6e672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -212,7 +212,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_pipeline_sync(ring);
 
 	if (emit_spm_needed)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
+		amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
 
 	if (emit_gds_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 002fae3c380e..f791e1bcbf17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -27,6 +27,37 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"
 
+/**
+ * amdgpu_gfx_rlc_update_spm - update RLC SPM VMID
+ *
+ * @adev: amdgpu_device pointer
+ * @ring: ring the VMID got assigned to
+ * @vmid: VMID to program
+ *
+ * RLC SPM counters are used only for GFX and GFX Cache subsystem. Only jobs submitted to
+ * rings in GFX subsystem need to update RLC SPM counters. Derive xcc_id from ring->vm_hub.
+ */
+void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int xcc_id, num_xcc;
+
+	if (!adev->gfx.rlc.funcs->update_spm_vmid || !ring)
+		return;
+
+	if (!AMDGPU_IS_GFXHUB(ring->vm_hub))
+		return;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		if (AMDGPU_GFXHUB(xcc_id) == ring->vm_hub) {
+			adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, ring,
+							     vmid);
+			return;
+		}
+	}
+}
+
 /**
  * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 959d60c90dcd..1410954da5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -370,6 +370,8 @@ struct amdgpu_rlc {
 	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl[AMDGPU_MAX_RLC_INSTANCES];
 };
 
+void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring, unsigned int vmid);
 void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id);
 void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29a66e39f3d6..dc8f85176b8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -865,7 +865,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
 	if (spm_update_needed)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
+		amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
 
 	if (gds_switch_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
-- 
2.49.0

