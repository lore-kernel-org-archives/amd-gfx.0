Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89071D12D5C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2249A10E7B2;
	Wed,  3 Dec 2025 13:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBPEJ5//";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B858B10E7B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+st5hRHj/pG6vdvGON2NxEvBM6VXVhW10TblpUt0Nz4N/5/qAn9b1g1yx9MKEG3AmXCzVDcFp7e4hc4QXbJ2SMGPbGM/dWBAmxHUCvw5QxyEgyayjPGiShE3uIcD7cAStWWAVNIM1oOxDm+pRiDret0dnGIhDM0YNck4IVX+6Gy5ZKXn1D7LavZJDeVvSs4sWjKZ+XlRgH2wGURU8hNr9YZZTCjro2HsgEFFtQSVZgGwrk2+i/MuPd0OLpL7FZTvVp6sB95IOUuku4/xYzm+hCSJBqdfoOtO1xF2u281V9Ykx8OMh+w4dw+PvViqj8zkyHCvzquPNAB3Aisi045OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yHzq8JWlKvyVsjp9YV3TpA5NOT3I69K9Qu+3fi7wwA=;
 b=Ro4k9FvePio3y5ybIN4DPRcj/lG7hV6TS7LJG0Lb5M5E9pcgZgJnZGKEEPDiQxk8XM7Xxfblvz+CrrwZdm30Vz/7b3MsqLBIMEwPTQD59nNIha0IsDowyi4TRwRFQH+Dgr5Fk3HMnjxN8Pgj8HAPkdbi0XVC4xXJlzIsF3QRyGKYDxWn+KjK0sd4SRmto4KkcjzOlsLcAdVlIPDmrSTxPDf6hiOAawJldh7vhhZ8lHhAdHf3sbUUCGKUIf9bKFIY6dLRTTgGk/5zSquvFmUajtq0QprpGgbtTWfcpGTvPtVWK92dDWFSgSoGT1icIcGraA1rDLB/vlpmlyi9NdOkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yHzq8JWlKvyVsjp9YV3TpA5NOT3I69K9Qu+3fi7wwA=;
 b=LBPEJ5//+twbJ1kTlg1iScZzuUR22SMg4AJn1WesmDkjsjpPgjvtjIn201Nugm8sqvaQvmJFAtzg6SEVrk4UezIg9tUQ0RP8/PeF3rlztA3hBfSrHZFmeBzRtA/9rPYzia9TzwT3tuKAg+fVJPBrvaqlXZcIC+Jbi62vrOzEus8=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:05:11 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::36) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:10 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:08 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 06/10] drm/amdgpu: Add first level cwsr handler to userq
Date: Wed, 3 Dec 2025 18:24:57 +0530
Message-ID: <20251203130436.745633-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 58de8e63-1b17-428f-1a5b-08de326c9735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cz/f3RkFySI8OR6MLj/OHr5IFjIc13LccMJkZhUcS8rGlbZTIDFHr/gBhKW0?=
 =?us-ascii?Q?GnPcguPLQ8IvCgJ7Of5OlKXCURIo72gVv+OFJEk282kIy+/ZL0BM7v/3T82a?=
 =?us-ascii?Q?imqpQBuGPPB8LSMDpPxWnxDV4gpfMcaaYAZehvTngwRWEGKfYcIVpjosf+6b?=
 =?us-ascii?Q?96oO6IZsx9Le6qAaY2nPBvpdGv2WbQXEuy74Sc7BqQ/E4WexL4goTt8HnHH6?=
 =?us-ascii?Q?x8YVAhc18zK/Bmy6ztA41SCJs8+HD3zAvGSlYUz/VqpdAwmJoHaML13AdwNL?=
 =?us-ascii?Q?k8XcFxVLgNdP5Pw2vj4Sxl8L+w/ZmArHqz/T0pHlTo1V39u/X2vfB4JEfTcO?=
 =?us-ascii?Q?nD5HQCMiiCSGiTETf4DoSHF+OENytxyeJZP7PZplQ3MFHrQX9s3rSiyRBJPQ?=
 =?us-ascii?Q?jHRd56pvlNeEiACCYMfVVpmbq9y30lwHcxOU75WI0qQspj3FIWOlLke5nl6W?=
 =?us-ascii?Q?GC48E2AoJK8jHGrIsCqpH2R/spQaG2UDbW58XSOOtZY8ZZhgudgf8mDmrWfA?=
 =?us-ascii?Q?3+6f/1z5vXa08y2MLkgpb6NtGFN3pk2Im91Ydr3rjDmRHyf/FsmmQpo3SMm5?=
 =?us-ascii?Q?A0B9DftvT2hJmZbdSrjNAQtcKiPbKxsQll/Fr9a3WNng0mrp/RbCcsZUzl2J?=
 =?us-ascii?Q?LPWBlw2NCvmMrEifUjvuCPeX33f3D+fPvT8m82LCr/hpE5HjHZbvNp1OutWf?=
 =?us-ascii?Q?CN6ud1Xfvx+mDXnAehMl0SXOkY1x4f4u00WAkk8CNzpjS6LNAYFYFEdLmzDl?=
 =?us-ascii?Q?p1hqpFhFp/06uXTyrqwPL80K+Gj7XINPzunp2lcusuuI3OGzGKC2+kP1/HOC?=
 =?us-ascii?Q?/LHmBZ95H8ooPlxbKGqHypiYKO44lskq3tlFYGpUVkPzANa2dt5ebHR+tuuS?=
 =?us-ascii?Q?J2ARS3rIn3N4HP8fuY3wZ4EMsNuqVYf46gzQZwekdAFnCjM5Hd2sgSgZNSu7?=
 =?us-ascii?Q?qohrkiK6BvaMz+DklK1eBITAic5NtqiYyMHWCsWoLWhuoLG+xBdF2QnLhPYl?=
 =?us-ascii?Q?ew/lVGip05qRyj18v1w4KvMtBPmn4OHQ1Y2XMlXa0lgoyj9z1ErJwyBryAMi?=
 =?us-ascii?Q?+2yG9GltnK3w6LDDMDDOqQOg/eqjZi+1eMSrvUBkDUAfowl5fLTwlhpTw5bm?=
 =?us-ascii?Q?vB7f96OYhNuMAN98BfSHWUTVS3FwDmpXBOQauLscqL/WnaGh3kYMKES1+mDJ?=
 =?us-ascii?Q?Rl/f6EiFtfC0UCJQjEIW4A6d4FWAaCHzAVP41uyXhkCoiBbKG8m1Ia40RZFF?=
 =?us-ascii?Q?/+LNUKO1OkTj3iKU4/k4eIVnUC/ekO6YLt6tEC6nqryQjiyIommYE1ghFoya?=
 =?us-ascii?Q?pSuanVPBtNZ7XqVItG5+EwmOkNAN1eR2wk1rD3zw+mk2J5fJvJw0xpb9MqUj?=
 =?us-ascii?Q?2pNF2oXVZ+jV1dQcHDy/u3nG7gBUnnibNdOsMbPvCypfg7akELZWlEK7PsjJ?=
 =?us-ascii?Q?/TcROh9SKnld6v6oERBY+YUIJDQebHpP1NdUUqK4LTOXs5beQKqK0jikZ5A0?=
 =?us-ascii?Q?OxTbiDGqgSjQ4Iz30h/zcs3j0p7T32FNIFlVVTyC4AwshV4gg6/b7UX9rIS7?=
 =?us-ascii?Q?3oDQmOrJFN2LNglaG6g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:10.7456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58de8e63-1b17-428f-1a5b-08de326c9735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
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

Add cwsr_trap_obj to render file handle. It maps the first level cwsr
handler to the vm with which the file handle is associated. Use
cwsr trap object's tba/tma address for the userqueue.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b9920cab5d31..ec2919a9c636 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -332,6 +332,7 @@ struct amdgpu_hive_info;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_cwsr_isa;
+struct amdgpu_cwsr_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -505,6 +506,7 @@ struct amdgpu_fpriv {
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
+	struct amdgpu_cwsr_trap_obj *cwsr_trap;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b3e6b3fcdf2c..398d6c8d343c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -46,6 +46,7 @@
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_cwsr.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1452,6 +1453,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (r)
 		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
 
+	if (amdgpu_cwsr_is_enabled(adev)) {
+		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
+		if (r)
+			dev_dbg(adev->dev, "cwsr trap not enabled");
+	}
+
 	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
 	if (r)
 		goto error_vm;
@@ -1524,6 +1531,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
+	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
 	if (pasid)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 8b0aeb89025a..480f4806e951 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -116,6 +117,7 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -145,6 +147,10 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
+	if (fpriv->cwsr_trap) {
+		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
+	}
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
-- 
2.49.0

