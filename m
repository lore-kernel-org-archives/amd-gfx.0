Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64957E95A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7FF10E2E7;
	Tue, 10 Oct 2023 10:18:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F29310E332
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD8wuwnUk+lVNtxmozT9hh5KebU5spOP+BXQj/fKzB/i7rfOV2ood8iKyjuuV4E/jkLV1/fUSHWRTU2l8/PBuxjWTa1xNIEkNnNtFml/ik7CD1L1DOS14LZTyRLsHnyKCqmlhCJInCNB49c2Xp3Kqm4iNoMOhfcgLyob5/lJHBtw+jXBS8v9a5jnvlm4SwE/dRpBdOymoMPNmy4b+N/Qsa9omnuQAAuhLgXiuiRIKrjOaSwwYWD8RBWBHnany3NgGgb0ldAcwQtD/0ya+bzcJEU+9BvfdiV4iYRwWtEVAwIJhu4p9FulB62Rtla55A98x8trYCn1WhgLU9nrG2l8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKeAo9HV9A6qYoAT/S71uNdl1thviVi6dzViyFldE2c=;
 b=gal0aTnEwj6bq/QM13FWgGDwiwjpxB/B1k4Gntc4jPT8CK3044FjHYJr2u3OndtCIwLzOEvpHPJubZKCcR3hQGt3L9WcL65ooX+iTKgydhSY7imvnx0f0C9fHTCL7THLhCyVRhjv24E2ekGccwsNX3s4nYgDgpHw45tcJWQO0RzU5WY55kzrO/dGi0imUNXBb6xN2cysE7v5YPNIOOR/O5AH9y9H+dtQKMrypVDGlMX/2Ae8ZR28ntK2qlPGQ/qnZ3bKFuqIusQA18SbV3k2/uhQYG7Qe/Ds+I5LCoIOoFot+H9xpM7Q+ZrWXgNfpj06I80nMy875kzksQTcbyOoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKeAo9HV9A6qYoAT/S71uNdl1thviVi6dzViyFldE2c=;
 b=yuzDgm6iFQmP02p5XIjMKL1m+mQ9lx5DOKMkX48oXVGGDmsljJyw3aR03SxMJ7M5yxDuRFksgHwdwBmvYxXDjiE2G6cEv6RfRR3exTEqZGsBLGqTGM7EC3n5+4ScDn3OiPi4IEWO5juaEnL9/15j4EvSApSnuSxvTaXVG3epEfw=
Received: from PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::9) by
 DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 10:18:45 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::96) by PH0P220CA0021.outlook.office365.com
 (2603:10b6:510:d3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:40 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 07/12] drm/amdgpu: map usermode queue into MES
Date: Tue, 10 Oct 2023 12:17:47 +0200
Message-ID: <20231010101752.1843-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f80a4a9-842b-4638-2ba9-08dbc97a48e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbHvJ5EHWuQUyaiASuNpkyLzp5sczW/Af39zFvOdm3GA/LJbkoRdoZkCuBt0CFZXpb1VeFuICDqmibD1Kth7t1JErf5DEXofLsf3DVSBANC1vTphd6KsHS91l1EXqxNpsYWgVDmciHg6CnazkBb0RfBhmeRQovs5qEu91Dx+vFQTE9x8hmPmmPGy2rV6g5Pv/jn720xvezyCznWkS2/2tt7wnT3FsH+FYTSxsAvqdnhWbf4AzaOCVtIv4qyQk2gtzw27ueV+UsyvqpWkgkiUmMWxvdiBR76IcbhPCO2EU4nCUQ5PuVMEiPwOW85kr0xizC9wxmDxCOMkS2CwEAa2XNBpM4UmwrLUOtD6OTmU8PZX4H8jJIsHtrfXZVWZcwZ9Te4KXpuUn2Q/qxz/eG6u9CPwEqhRF1/B+9Ltx3eqAWKd0xOaQGVkiw3jroRJJo+SBmTH5KdAmm05a17irXLxXrSheoOksz2RETl2AsT9C0WxbliiQOGaFLda6jZCNTuPMrLAf8vXctcXF7/UFN9AcpHz85xHePKhS9Dn3bTMB3eAV0e5YYDltz6DBfABtgAqqR9UXMoTj2oM74R9YzcnlMKWfPyrb4d+71v6Fxa304Y1/3j+Nzo7c41TdaBEMrlVf/slRa5B9kG4xkZUVQyjgDH/0sSunxXUhIjWJK89AwZmr3M1kiF8DgicKd/3abmIez5lM3m4nKOjWlrbfbUk6hlpCMKPpzAN46YlyYBW6wfdNQgmOejyHzg/njyecSc6Nxb7MBrRXbavywDEspG+ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(4326008)(8676002)(5660300002)(44832011)(41300700001)(8936002)(6916009)(316002)(70206006)(54906003)(70586007)(40460700003)(2906002)(356005)(83380400001)(47076005)(82740400003)(40480700001)(81166007)(16526019)(26005)(2616005)(426003)(1076003)(336012)(86362001)(36860700001)(36756003)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:44.8472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f80a4a9-842b-4638-2ba9-08dbc97a48e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds new functions to map/unmap a usermode queue into
the FW, using the MES ring. As soon as this mapping is done, the
queue would  be considered ready to accept the workload.

V1: Addressed review comments from Alex on the RFC patch series
    - Map/Unmap should be IP specific.
V2:
    Addressed review comments from Christian:
    - Fix the wptr_mc_addr calculation (moved into another patch)
    Addressed review comments from Alex:
    - Do not add fptrs for map/unmap

V3: Integration with doorbell manager
V4: Rebase
V5: Use gfx_v11_0 for function names (Alex)
V6: Removed queue->proc/gang/fw_ctx_address variables and doing the
    address calculations locally to keep the queue structure GEN
    independent (Alex)
V7: Added R-B from Alex

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4b0c3fc63411..d7d374822352 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6405,6 +6405,67 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_mqd_prop *userq_props)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct mes_add_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
+
+	queue_input.process_va_start = 0;
+	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+	queue_input.process_quantum = 100000; /* 10ms */
+	queue_input.gang_quantum = 10000; /* 1ms */
+	queue_input.paging = false;
+
+	queue_input.process_context_addr = ctx->gpu_addr;
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+	queue_input.process_id = queue->vm->pasid;
+	queue_input.queue_type = queue->queue_type;
+	queue_input.mqd_addr = queue->mqd.gpu_addr;
+	queue_input.wptr_addr = userq_props->wptr_gpu_addr;
+	queue_input.queue_size = userq_props->queue_size >> 2;
+	queue_input.doorbell_offset = userq_props->doorbell_index;
+	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
+		return r;
+	}
+
+	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
+	return 0;
+}
+
+static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
+				  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_remove_queue_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
+}
+
 static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 					    struct amdgpu_usermode_queue *queue,
 					    struct drm_amdgpu_userq_mqd_gfx_v11_0 *mqd_user)
@@ -6490,8 +6551,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Map userqueue into FW using MES */
+	r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
+	if (r) {
+		DRM_ERROR("Failed to init MQD\n");
+		goto free_ctx;
+	}
+
 	return 0;
 
+free_ctx:
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
+
 free_mqd:
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 	kfree(mqd_user);
@@ -6501,6 +6572,7 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 static void
 gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
+	gfx_v11_0_userq_unmap(uq_mgr, queue);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 }
-- 
2.42.0

