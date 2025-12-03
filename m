Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB261D12D50
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C5010E7B0;
	Wed,  3 Dec 2025 13:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R6DlgAo1";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E65A10E7B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0U4FISk81jPJuTEhVbTdF403RqyYTHf959SyMUGawsbRh3NXTRscV+bWMakEFZaCE9iWOgJ/cC50JXda2s/EnjFuFBAP2XfgcltyF+bEREVUmKvvhMGGuNYORN2fOek4LiNfDzV/8BgPYD34PNBlSn3FuF/9egKHuLXjtYEJBwgEFNPThTBH2/trY+MfIWILOj43BH1Lr3DsmHQVsytHOqIbETTKPc2quIrJtUp27AG8S5upJPF4XXXJIxZqZc/vVY4SyykOSml8bfxoTDUo1hJNhlkUAgKw/ApG3mI8GxadPzvrl8CJZV5+ssBedp6lFLRs/b9RrzxkEm1TVGkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1gUQKLKAL2igyY5fQH3wctEOMFmSF3VSyYFpTxiY44=;
 b=O9XrQqGMahNZhmF/OB/nkNRhz1T8aXw1kCGuTlQcojWvhO+d9g+xHC1Axy64pwTYEy3RrPUu97/J5Zt4u8jsBu4ld0UcMDvVVpoYVUk6QCnWxQbULhWB8j0Q8ppcaUYZIJg2pVv59g/9dQi9dIXk+sZ1nD4eZp5rJ2FWT8saSrPsNRFEVC+6bzZxx3f1zAoiU156lp4AODx9UhAXy50L/FxtVASmzh+NW3ihCiA9q/ZC5fl1MUEqrfbJG0cBmOj9KzTJCEL7RfLOyGSNiQkw/uJe27s1BaM/tBWu8fh3+XnMfpYf+Wwo5hZdlMXEdCorVPIAg6Hms9gMwfQm6BXxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1gUQKLKAL2igyY5fQH3wctEOMFmSF3VSyYFpTxiY44=;
 b=R6DlgAo1/RCCaOMIXRW7F+9gQH1yH+yXaSP/4zi6DM5kyisBQApTOKLW1cyu+QnNGAro0bTYi8K/KKgUzgVchUT+mfdLiHluKuo83UnwNqeD1wKbQjCQ+it0e1cRF1ud/UaLCx/gq5SdF8v4JUMT8d4ABDXczsRV6K0SqE29yV4=
Received: from BN9PR03CA0159.namprd03.prod.outlook.com (2603:10b6:408:f4::14)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 13:05:13 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f4:cafe::d4) by BN9PR03CA0159.outlook.office365.com
 (2603:10b6:408:f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:12 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:10 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 07/10] drm/amdgpu: Add user save area params to mqd
 input
Date: Wed, 3 Dec 2025 18:24:58 +0530
Message-ID: <20251203130436.745633-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcb7901-2e88-45cb-1822-08de326c984f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6r+oPA0m/9drlKqXFgv/9e7FuhXGmc96eoLCO8gjkgwC47LEynPPXip39Fsn?=
 =?us-ascii?Q?ON9+bcCy8e55HE3g3Agic6/C6Y8pj2YGSng/rH61CyeKPcwstCnGqdETenPU?=
 =?us-ascii?Q?Aoj/nuJT6gwsoM1na2OapslQZO42k4CrCCbb/1o+AtmG/kdvIn6vCZ9VrrHp?=
 =?us-ascii?Q?OIuLmNtd/uc+re0jF2KKO56hANg8D3yeyzcX+IP/ekpPstFJv3N6a+TSJRPa?=
 =?us-ascii?Q?NJ+gEg3/tWWWDOynMF9iAtq92/rQK3CJ6+VjFpAlvJc58tRvo1bO1n9Lj0Ya?=
 =?us-ascii?Q?/wnDW6E936rkwDOicJRTftsp9IwHzc2h2Jz2mmBOua5aSyU6SBx3NIrPJ2eq?=
 =?us-ascii?Q?1vb39GIKjqj8ckz171uGTJusdfMMlF3Fg1b3F2PvYAAVwLXsXAAL7fEp6D2r?=
 =?us-ascii?Q?Zju0FWlGq4UuVMZQRIXUadESrfOz2BVWfmlzKS5NQEF0WihGShkuc3BXyVdj?=
 =?us-ascii?Q?zkxtWrbTgHzlGKPm5n9dpZkMjEIPRBBvql65U/TMNMp6lUTt/0CrRq+uTX1u?=
 =?us-ascii?Q?xwTvMGyZHjWoQ5fQUOVaSpLxWUQUY/3vVlAUbCh2DXvGV4YEwKUK3zShBSWu?=
 =?us-ascii?Q?vAWZ2XfutXi8z8h4UruQePiMey/7a61RyPFFxvDfxeRKWYuH1AnJCSGTTGKQ?=
 =?us-ascii?Q?1HZ/TRLe2MRpCnysVkgxd8CIgI7C2tv5wRTfX5Gvp9gdsIcED2SODZ60yOtb?=
 =?us-ascii?Q?S+XqXm+xihExU0SwgVyhAkqB8LnTQlcQDjslymL8p5rpXVq6tzMQR3kQjIO7?=
 =?us-ascii?Q?OBzcAb9GIbyNoGEYE16ImkWYPlH1U5UP1Lu5SwqdCIoHbSX0D8XcxLvfSYde?=
 =?us-ascii?Q?Soz7c1sCHnkhqTowlcoA/UFftGpigfAyhZ+McIqEVjfsEcBwcwBeLLpJKxIw?=
 =?us-ascii?Q?STXLqd/4DCQKkD2YLMMbH/isqQoLQtApiDoROv8jOb126rbzfdZ/Q+IPnOl8?=
 =?us-ascii?Q?2qSnmAYdNNS3b7d9YOvSMss6pCFCIbuTUmoxICu/qoOWn+zPJXmEGwJeMOuy?=
 =?us-ascii?Q?J1LpgEdBkqp/jGH0kVUbmRKOb/f2+/1GcZcS0Hd1xQPbd6PkkufmQIUkm3iR?=
 =?us-ascii?Q?FxxYQF5je+vIw/qqCBX4FtZbwe4+jKGIKQazwtn6OJQvV7leE8DRT/NuIZTt?=
 =?us-ascii?Q?9mUHp3ZW4bQaKMOdSEbngLXANzXSJ257AJHbBK1RU/RSu3CS8zwPaqCfKZbc?=
 =?us-ascii?Q?WIvtM59I2ocEMA1RUbXL5ROMrNeLf/zTukf+wTxGpCfBpNbDrPCOXjQSVNac?=
 =?us-ascii?Q?3K+UlHcG2IGkkE278TG1M0yEaW0cyNQw4JkchRwyvJp/7BSZNxcktZP9LqT0?=
 =?us-ascii?Q?p9nfkiY4j3wtcW2VfzerrwnYwp4bzQL6+q3wJaSL7E11GTpQmuvXs1seRVyg?=
 =?us-ascii?Q?YEPe61meZamUa5vNVlO3E/UHhdbKqxmJorz2utNCAe+aTuq8CMMDWEbshYyD?=
 =?us-ascii?Q?T2fvbIAyRj0M9vtxN2uhJiAMURf3by+TSvb/dh+UfduvfTd8Ak+oksYRQMnV?=
 =?us-ascii?Q?VavBgFRPr/Rqbesb1ESdmjywNCCufLt7C2NAnm6DkLD1ylstAqjw4abkYui2?=
 =?us-ascii?Q?LXEf22bG1F2Ff+rlySY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:12.5937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb7901-2e88-45cb-1822-08de326c984f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

Add user save area parameters to mqd properties for queue creation.
Validate the parameters before using for mqd initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 14 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 +++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ec2919a9c636..1fb9539f8aca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -904,6 +904,10 @@ struct amdgpu_mqd_prop {
 	uint64_t fence_address;
 	bool tmz_queue;
 	bool kernel_queue;
+	/* cwsr params*/
+	uint64_t ctx_save_area_addr;
+	uint32_t ctx_save_area_size;
+	uint32_t ctl_stack_size;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2f97f35e0af5..49794b0989ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_cwsr.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -202,6 +203,29 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	uint32_t cwsr_size;
+	int num_xcc;
+	int r;
+
+	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
+					num_xcc);
+	if (r)
+		return r;
+	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
+	if (!cwsr_size)
+		return -EOPNOTSUPP;
+
+	return amdgpu_userq_input_va_validate(
+		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size);
+}
+
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 1eaa94f8a291..0eeea9fad0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_cwsr_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -153,4 +154,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 				       struct amdgpu_bo_va_mapping *mapping,
 				       uint64_t saddr);
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f9cae6666697..ad39b33d292a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3239,6 +3239,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
 
+	/* If non-zero, assume cwsr is enabled */
+	if (prop->ctx_save_area_addr) {
+		mqd->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		mqd->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
+		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
+		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 480f4806e951..0ac87618a86a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -293,6 +293,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_cwsr_params cwsr_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -318,6 +319,21 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_cwsr_is_enabled(adev)) {
+			cwsr_params.ctx_save_area_address =
+				userq_props->ctx_save_area_addr;
+			cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
+			cwsr_params.ctl_stack_sz = userq_props->ctl_stack_size;
+
+			r = amdgpu_userq_input_cwsr_params_validate(
+				queue, &cwsr_params);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+		}
+
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
-- 
2.49.0

