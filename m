Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9231EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 15:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F724113564;
	Wed, 22 Jun 2022 15:38:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B14113565
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 15:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJAKtzXknu4mpNtlWvZYRFOnHSyc/F/KPrHmZen+rDvU3TDNyYIGn8TJ2fwZbQVWu2XepPjiSBTyKEqSVP3xntoHC8Kw24sveN1305l06sXhMdik/iFUhG9RO0iyBlgaMv5jahH86SVDDlop/qJaHdyjSA44bo/G0JAsT9o42Fyabci+fT6ae1AZEn+ZjlpgL5b/I6zNX4/WIv08QcnemhIcoPsuhGbhsZ9zZJHVeM3PY1y+1G4zmDMDR+RLQh6M5RrzotBlVX1Wkkbu6ca6iMRk4/CxbprQZh20KNDzXb7rQ6QQmITxLZB45H8I9YBV7FwvL+8pXNCmG5ka/g5C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5DMc189+PkVmiN+3uwDCfSrZcHUPnqdTAwFeXlo4dk=;
 b=MiudXSSLA7XRFpN2DGngcMSVkAaCbQ9vyPqVXHEDWHDwdmn6wtgd4K8oRz16NRgllTkBAAlYKjkwZcBWiK/XvgaCTUmvayHOERJoSbY1JUTCGnvjnZqt4HiaxUIkrsjfXqqwWZJtt+5Fw8dLUv7qT63HYAwhzomBFGrBhfsnY9lwNKJf9YO49j0MNMr4BerhuiEAfzYkMMBvrCmJQPYYMevr4v2l3KuRmQM1zXODckQfS3q6zqy7ukGUQ8TT08EgUdS8gjmFmwnSCMWm8ObZjH7sjiScJfxUrFWAMAp6PPRZv2RQNnG1u21s/xeWRYHJOg1Iq2yhlQms9j/T5VG9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5DMc189+PkVmiN+3uwDCfSrZcHUPnqdTAwFeXlo4dk=;
 b=Yl7lH/dZqUUT+IXw+5m175sq6kJXoToVzreRIlRxx22XH7H/nU1BFDgJWqq2F2gc1sK99CND2rNn5XQXP1M6bzVA6ARlWIcWb9npvu4YTpsJghZMpYW/67MdVokNsz2exWE1B1UeSyDWkqlZWVEM8dSX7gANiZcAZRkcIlCrL5Y=
Received: from DM5PR20CA0019.namprd20.prod.outlook.com (2603:10b6:3:93::29) by
 CY4PR12MB1687.namprd12.prod.outlook.com (2603:10b6:910:3::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Wed, 22 Jun 2022 15:37:20 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::36) by DM5PR20CA0019.outlook.office365.com
 (2603:10b6:3:93::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Wed, 22 Jun 2022 15:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 15:37:20 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 10:37:19 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Date: Wed, 22 Jun 2022 11:36:55 -0400
Message-ID: <20220622153656.174491-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51ed756c-ec55-40da-64a3-08da54651894
X-MS-TrafficTypeDiagnostic: CY4PR12MB1687:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB168730E05D88731B630EB9418AB29@CY4PR12MB1687.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq7LdCOPuNc3P3OuZeKxbGP8cUYZy2VzWgmV4ZEgLOz/MPb+JvDj4lwlQeG4WyS//Y4/MO6OQh+FAZg6a06KXeoV3EB8aveMSQrOWcaTgD9aMPEgzUc9AlSaUpqVv1e+/29KDPH5kkf5pGfR2qeHvhYhMT8b40+n/rkS0gGUMaLC8kRVORTzsJ6PAgXVIkIvLOWn0LMUHWov2s0IuJGDTFnuC/JSBbxrnRotk7JBUey4LfcEhrfjLB/M1STdbjSQ1iopVx0aW/z2i/YRCBeKvSWKpGH8FC3V77h0US2svPyDcqhlA8HnyhABlVEi433CjlI2L1orFw2iDCnY9ATw5hdZn36HwaQrJT23TyocdmwhhkLqHyfOf4ECiqGMN3q2K8f847caLfBzmHup63SUxl551d2DlON6fw9Qo+7YhAC9ffTUktrJmJSTVgxKDUErBGxl+7ZjxlILoyB9Orztn7wc+T4WPhY6ZcnnkLAh4BXYS0G/1SMlpwMZNOGBBx1jVYRa0l1h9TEBduG45+NxbofWGz1gkJxqvKtEKYDNDRrjaKpNoGOxsY2GRP0johx35FpCR09b23fnJjLILQGph2ttxkWYewlJeC7d8hx4cX9mnZvA6pch6mjEZkmBvc+LMBx3xAXQvTZ3QQ72zmI/znQrcEAMxq4rbaBNu1lIYolvx0J3DcT6J1qbsVCxSU9Ve/YEdwIavU0fVfcP19jX6ZRU1XTlhBkukoydRBYnrtFDMBTgTnaZb8YTVorGbSNr81EufLzs/yOtl+P7tNrqKz74f7Db756eXiaHmNsrXE0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(36840700001)(46966006)(41300700001)(82310400005)(186003)(1076003)(81166007)(16526019)(83380400001)(40480700001)(426003)(2616005)(36860700001)(336012)(356005)(47076005)(82740400003)(70586007)(40460700003)(4326008)(26005)(5660300002)(2906002)(8676002)(8936002)(7696005)(54906003)(6916009)(316002)(70206006)(30864003)(86362001)(478600001)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:37:20.6217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ed756c-ec55-40da-64a3-08da54651894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1687
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Christian.Koenig@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
GART for usermode queues in order to support oversubscription. In the
case that work is submitted to an unmapped queue, MES must have a GART
wptr address to determine whether the queue should be mapped.

This change is accompanied with changes in MES and is applicable for
MES_API_VERSION >= 2.

v3:
- Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
- Move wptr_bo refcount increment to amdgpu_amdkfd_map_gtt_bo_to_gart
- Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
- Cleanup/fix create_queue wptr_bo error handling
v4:
- Add MES version shift/mask defines to amdgpu_mes.h
- Change version check from MES_VERSION to MES_API_VERSION
- Add check in kfd_ioctl_create_queue before wptr bo pin/GART map to
ensure bo is a single page.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 48 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45 ++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 20 +++++---
 8 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 648c031942e9..b25b41f50213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -286,6 +286,8 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 					     void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
+
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index afd6e6923189..615ac2895d62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2148,6 +2148,54 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
 
+/**
+ * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
+ * @adev: Device to which allocated BO belongs
+ * @bo: Buffer object to be mapped
+ *
+ * Before return, bo reference count is incremented. To release the reference and unpin/
+ * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
+ */
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		pr_err("Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	if (ret) {
+		pr_err("Failed to pin bo. ret %d\n", ret);
+		goto err_pin_bo_failed;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (ret) {
+		pr_err("Failed to bind bo to GART. ret %d\n", ret);
+		goto err_map_bo_gart_failed;
+	}
+
+	amdgpu_amdkfd_remove_eviction_fence(
+		bo, bo->kfd_bo->process_info->eviction_fence);
+
+	amdgpu_bo_unreserve(bo);
+
+	bo = amdgpu_bo_ref(bo);
+
+	return 0;
+
+err_map_bo_gart_failed:
+	amdgpu_bo_unpin(bo);
+err_pin_bo_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+
+	return ret;
+}
+
 /** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
  *
  * @mem: Buffer object to be mapped for CPU access
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index be4b51a5b5c7..137a2cc2e807 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -32,6 +32,13 @@
 #define AMDGPU_MES_MAX_GFX_PIPES            2
 #define AMDGPU_MES_MAX_SDMA_PIPES           2
 
+#define AMDGPU_MES_API_VERSION_SHIFT	12
+#define AMDGPU_MES_FEAT_VERSION_SHIFT	24
+
+#define AMDGPU_MES_VERSION_MASK		0x00000fff
+#define AMDGPU_MES_API_VERSION_MASK	0x00fff000
+#define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
+
 enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_LEVEL_LOW       = 0,
 	AMDGPU_MES_PRIORITY_LEVEL_NORMAL    = 1,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 625e837f0119..a0246b4bae6b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -299,6 +299,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	struct kfd_process_device *pdd;
 	struct queue_properties q_properties;
 	uint32_t doorbell_offset_in_process = 0;
+	struct amdgpu_bo *wptr_bo = NULL;
 
 	memset(&q_properties, 0, sizeof(struct queue_properties));
 
@@ -326,12 +327,49 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
+	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
+	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
+	 */
+	if (dev->shared_resources.enable_mes &&
+			((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
+			>> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
+		struct amdgpu_bo_va_mapping *wptr_mapping;
+		struct amdgpu_vm *wptr_vm;
+
+		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
+		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+		if (err)
+			goto err_wptr_map_gart;
+
+		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
+				wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
+		amdgpu_bo_unreserve(wptr_vm->root.bo);
+		if (!wptr_mapping) {
+			pr_err("Failed to lookup wptr bo\n");
+			err = -EINVAL;
+			goto err_wptr_map_gart;
+		}
+
+		wptr_bo = wptr_mapping->bo_va->base.bo;
+		if (wptr_bo->tbo.base.size > PAGE_SIZE) {
+			pr_err("Requested GART mapping for wptr bo larger than one page\n");
+			err = -EINVAL;
+			goto err_wptr_map_gart;
+		}
+
+		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
+		if (err) {
+			pr_err("Failed to map wptr bo to GART\n");
+			goto err_wptr_map_gart;
+		}
+	}
+
 	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
 			p->pasid,
 			dev->id);
 
-	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL, NULL,
-			&doorbell_offset_in_process);
+	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
+			NULL, NULL, NULL, &doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
 
@@ -363,6 +401,9 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	return 0;
 
 err_create_queue:
+	if (wptr_bo)
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
+err_wptr_map_gart:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 213246a5b4e4..299927a4959b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -177,6 +177,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
 	int r, queue_type;
+	uint64_t wptr_addr_off;
 
 	if (dqm->is_hws_hang)
 		return -EIO;
@@ -196,7 +197,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.mqd_addr = q->gart_mqd_addr;
-	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
+
+	if (q->wptr_bo) {
+		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
+		queue_input.wptr_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
+	} else
+		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
+
 	queue_input.paging = false;
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4e0387f591be..b8e14c2cc295 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
 	m->sdmax_rlcx_doorbell_offset =
 		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 91e5fa56f0a2..59ba50ce54d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -570,6 +570,8 @@ struct queue {
 	void *gang_ctx_bo;
 	uint64_t gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
+
+	struct amdgpu_bo *wptr_bo;
 };
 
 enum KFD_MQD_TYPE {
@@ -1205,6 +1207,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 99f2a6412201..8db58348de98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -180,7 +180,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 static int init_user_queue(struct process_queue_manager *pqm,
 				struct kfd_dev *dev, struct queue **q,
 				struct queue_properties *q_properties,
-				struct file *f, unsigned int qid)
+				struct file *f, struct amdgpu_bo *wptr_bo,
+				unsigned int qid)
 {
 	int retval;
 
@@ -210,6 +211,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 			goto cleanup;
 		}
 		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
+		(*q)->wptr_bo = wptr_bo;
 	}
 
 	pr_debug("PQM After init queue");
@@ -226,6 +228,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
@@ -288,7 +291,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * allocate_sdma_queue() in create_queue() has the
 		 * corresponding check logic.
 		 */
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -309,7 +312,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		}
 
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -435,10 +438,15 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pdd->qpd.num_gws = 0;
 		}
 
-		if (dev->shared_resources.enable_mes)
+		if (dev->shared_resources.enable_mes) {
 			amdgpu_amdkfd_free_gtt_mem(dev->adev,
 						   pqn->q->gang_ctx_bo);
-		kfd_procfs_del_queue(pqn->q);
+			if (pqn->q->wptr_bo)
+				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+
+			kfd_procfs_del_queue(pqn->q);
+
+		}
 		uninit_queue(pqn->q);
 	}
 
@@ -844,7 +852,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
+	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
 				NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
-- 
2.25.1

