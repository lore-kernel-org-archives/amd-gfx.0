Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F790C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055A760F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 055A760F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4C96E8E4;
	Tue, 19 Oct 2021 21:15:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7221D6E8E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMiKvNUtfni2wvy74wIuzHHFdQPr96tLeqzENmh4zA2Bld2dzV15iJWlFfu9l+74/cLKpYugIO/eIMd/ksXohVLyIxAEeEJNMj2akcLtcdRDrfr9BRa+K7CZNRUiIJptWYykngX8ZeiEq87hmtq2joxx8EwzH+c255cPpQX34E0aSgtJjD2S6fLOLuvxDLNLcNklDcS1x/dNMAKf71kqOrrKnwj3JTCNbsN188/inn+rQPk5ZkbS9hGWZNyJB9oygYNdCg27b8eFwxPiC965Jo4gxLubd6YHgmhwwcXIXpRTJ6N97mCKwZK4QCis3P/E45S63yRfLvgTm4jAtLAwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yodi2oBC9ks5h3WMhgNN6WyBMNjPs38eZYoREgZjPPQ=;
 b=JcJHdAKSLxACj/4TpIFthNVkA5F8y2T+Nw3Dxny1MCh7OdcDFjSUvHY5g1co6ZY1OiSt2aCaqRO3MRr8J1S/cnjnU9qK7SB4Q7G4hxlMOWM7uBWLGo22Bm9MdLrwMh4bkCbJlGRkcQCiQYLGWWrKjl2gZiUiaR6vTq5ljfu9aW4UYdgZ3XY/Rq+ZxwFyAmf80LjXRSl45fchqSIq7GfDG3gQb6+z6aWN1JTX9fTBh/6MQB+2dNh+6jzabd+mETL4IPHa1e+IIF93ShMCrms6vmqHtvxkW9rqHng2OLE+A6wFNm1Jbvc5bDHfzDyjRTDWBCPdStCO+Fi4k8HGUDZHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yodi2oBC9ks5h3WMhgNN6WyBMNjPs38eZYoREgZjPPQ=;
 b=g1ofCduJgzsKpJ9A69q97LsBjOrWafn8hCiSvV+1AANOr8kIirid6NYC+n4y+2YNrelnzls6uonDLFq663wuPhwA0zBUg+xR693ha+de/RYenUPDV6S3+8AA3h8Fbu8nNZSPLUhG5lGE9/NESFPncKQYHGkAAjWh7fQgwRArA2k=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by BYAPR12MB2902.namprd12.prod.outlook.com (2603:10b6:a03:12f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 21:15:02 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::15) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Tue, 19 Oct 2021 21:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:15:02 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:59 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 11/13] drm/amdkfd: replace kgd_dev in gpuvm amdgpu_amdkfd funcs
Date: Tue, 19 Oct 2021 17:13:32 -0400
Message-ID: <20211019211334.1552825-11-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f476dd7-d180-4aad-ca6a-08d9934583bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2902:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2902FC76783EC1A49B950ADA8ABD9@BYAPR12MB2902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yByvpQctbFDPDO5CSVXU0T9jnTNe2RQR8kvNROGH4x+XRDM2qQORDZ0nTXbhWTjoN6XWbe5OuHbJuBNcE3XehUd4qKI5N1Dy1jMP09F0nI1xmX8JLQzicNFzAVxDwzbTzKD/lB4Z/598SPE1BDaN9BV276wDCSq1GnZor9KwG1D04wz9Fq2I4vkWa+OsoF+1ymwm80rVPUw3GwA+DQtCF4dYfCADDGcPOcuMuK44MUQ0cTZI4QwQmWG+QU9g3bYWBjzSZLjPwk+gAKnXbOd3w4z3GpyshTvOyXrbuwa9uSuiYVG5IGP0f+vIokxrmegIWXK/lJoWidQuFYWdkoiwAjs//cCcaLxS7AlGfSBvBGV8qhHE2IES2tI9uGZijExi8qKRkN2bMcSy2dM34oP2BIVHACoZ0DKsv5wJWzeLipJfi3idWcYWVb8awec2tX+lFNbnt7l58OAkR3FLQqpCm1VOu6hAwZXf7U8EDzXxeUIklfiiqE0W4HYXGFIdpoq/1o8uEcT+fOf6nYSNY85eMLlnSpN5By4NdpN54F6g5gUvGSDTJSo0amx0cIUUjkab/qZ7/WTH4t3Kdk3P5lrwYYOjXBBlxmLAPwu+V8iovB6FXthDIkxGuekTsFfQwHunup0oK/d7aXU3yd+SGqAArcDj/mVgtPSVtMSRrpXYJzl+GpamZJNxAwsAskfuyGd5PKqy1HR5Veijyxnw32at9XR+zsOGS9BFdoQSmGxH168=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(83380400001)(336012)(1076003)(8936002)(47076005)(356005)(36756003)(8676002)(81166007)(508600001)(426003)(4326008)(316002)(30864003)(6916009)(82310400003)(6666004)(36860700001)(26005)(186003)(16526019)(7696005)(5660300002)(70586007)(70206006)(54906003)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:15:02.1475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f476dd7-d180-4aad-ca6a-08d9934583bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2902
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

Modified definitions:

- amdgpu_amdkfd_gpuvm_acquire_process_vm
- amdgpu_amdkfd_gpuvm_release_process_vm
- amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu
- amdgpu_amdkfd_gpuvm_free_memory_of_gpu
- amdgpu_amdkfd_gpuvm_map_memory_to_gpu
- amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu
- amdgpu_amdkfd_gpuvm_sync_memory
- amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel
- amdgpu_amdkfd_gpuvm_get_vm_fault_info
- amdgpu_amdkfd_gpuvm_import_dmabuf
- amdgpu_amdkfd_get_tile_config

Remove:

- get_amdgpu_device

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 24 ++++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 41 ++++++-------------
 .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 22 +++++-----
 5 files changed, 49 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 7e3697a7a5cd..35f703dda034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -265,37 +265,39 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
 	(&((struct amdgpu_fpriv *)					\
 		((struct drm_file *)(drm_priv))->driver_priv)->vm)
 
-int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					struct file *filp, u32 pasid,
 					void **process_info,
 					struct dma_fence **ef);
-void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *drm_priv);
+void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
+					void *drm_priv);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
-		struct kgd_dev *kgd, uint64_t va, uint64_t size,
+		struct amdgpu_device *adev, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
 		uint64_t *offset, uint32_t flags);
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv,
+		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
 		uint64_t *size);
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv, bool *table_freed);
+		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
+		bool *table_freed);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv);
+		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
-		struct kgd_dev *kgd, struct kgd_mem *mem, bool intr);
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
+		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 		struct kgd_mem *mem, void **kptr, uint64_t *size);
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
-int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					      struct kfd_vm_fault_info *info);
-int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 				      struct dma_buf *dmabuf,
 				      uint64_t va, void *drm_priv,
 				      struct kgd_mem **mem, uint64_t *size,
 				      uint64_t *mmap_offset);
-int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
+int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
 #if IS_ENABLED(CONFIG_HSA_AMD)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cdf46bd0d8d5..d632484b209e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -60,12 +60,6 @@ static const char * const domain_bit_to_string[] = {
 
 static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work);
 
-
-static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
-{
-	return (struct amdgpu_device *)kgd;
-}
-
 static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
 		struct kgd_mem *mem)
 {
@@ -1269,12 +1263,11 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					   struct file *filp, u32 pasid,
 					   void **process_info,
 					   struct dma_fence **ef)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_fpriv *drv_priv;
 	struct amdgpu_vm *avm;
 	int ret;
@@ -1350,12 +1343,12 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 	}
 }
 
-void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *drm_priv)
+void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
+					    void *drm_priv)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm;
 
-	if (WARN_ON(!kgd || !drm_priv))
+	if (WARN_ON(!adev || !drm_priv))
 		return;
 
 	avm = drm_priv_to_vm(drm_priv);
@@ -1383,11 +1376,10 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
 }
 
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
-		struct kgd_dev *kgd, uint64_t va, uint64_t size,
+		struct amdgpu_device *adev, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
 		uint64_t *offset, uint32_t flags)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
 	enum ttm_bo_type bo_type = ttm_bo_type_device;
 	struct sg_table *sg = NULL;
@@ -1520,7 +1512,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv,
+		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
 		uint64_t *size)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
@@ -1608,10 +1600,9 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem,
+		struct amdgpu_device *adev, struct kgd_mem *mem,
 		void *drm_priv, bool *table_freed)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
 	int ret;
 	struct amdgpu_bo *bo;
@@ -1738,7 +1729,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv)
+		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
 {
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
 	struct amdkfd_process_info *process_info = avm->process_info;
@@ -1799,7 +1790,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_sync_memory(
-		struct kgd_dev *kgd, struct kgd_mem *mem, bool intr)
+		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr)
 {
 	struct amdgpu_sync sync;
 	int ret;
@@ -1815,7 +1806,7 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 		struct kgd_mem *mem, void **kptr, uint64_t *size)
 {
 	int ret;
@@ -1871,12 +1862,9 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					      struct kfd_vm_fault_info *mem)
 {
-	struct amdgpu_device *adev;
-
-	adev = (struct amdgpu_device *)kgd;
 	if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
 		*mem = *adev->gmc.vm_fault_info;
 		mb();
@@ -1885,13 +1873,12 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
 	return 0;
 }
 
-int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 				      struct dma_buf *dma_buf,
 				      uint64_t va, void *drm_priv,
 				      struct kgd_mem **mem, uint64_t *size,
 				      uint64_t *mmap_offset)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *bo;
@@ -2511,11 +2498,9 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
 }
 
 /* Returns GPU-specific tiling mode information */
-int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
+int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	config->gb_addr_config = adev->gfx.config.gb_addr_config;
 	config->tile_config_ptr = adev->gfx.config.tile_mode_array;
 	config->num_tile_configs =
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 3073361bb714..e31ea107e998 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -113,7 +113,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 		kfd_process_vm_fault(dev->dqm, pasid);
 
 		memset(&info, 0, sizeof(info));
-		amdgpu_amdkfd_gpuvm_get_vm_fault_info(dev->kgd, &info);
+		amdgpu_amdkfd_gpuvm_get_vm_fault_info(dev->adev, &info);
 		if (!info.page_addr && !info.status)
 			return;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 47acfef1aebd..11d917e18b38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1039,7 +1039,7 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
 		}
 		mutex_unlock(&p->mutex);
 
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->kgd,
+		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->adev,
 						mem, &kern_addr, &size);
 		if (err) {
 			pr_err("Failed to map event page to kernel\n");
@@ -1151,7 +1151,7 @@ static int kfd_ioctl_get_tile_config(struct file *filep,
 	if (!dev)
 		return -EINVAL;
 
-	amdgpu_amdkfd_get_tile_config(dev->kgd, &config);
+	amdgpu_amdkfd_get_tile_config(dev->adev, &config);
 
 	args->gb_addr_config = config.gb_addr_config;
 	args->num_banks = config.num_banks;
@@ -1314,7 +1314,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	}
 
 	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
-		dev->kgd, args->va_addr, args->size,
+		dev->adev, args->va_addr, args->size,
 		pdd->drm_priv, (struct kgd_mem **) &mem, &offset,
 		flags);
 
@@ -1346,7 +1346,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	return 0;
 
 err_free:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem,
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, (struct kgd_mem *)mem,
 					       pdd->drm_priv, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
@@ -1383,7 +1383,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		goto err_unlock;
 	}
 
-	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd,
+	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev,
 				(struct kgd_mem *)mem, pdd->drm_priv, &size);
 
 	/* If freeing the buffer failed, leave the handle in place for
@@ -1468,7 +1468,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 			goto get_mem_obj_from_handle_failed;
 		}
 		err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-			peer->kgd, (struct kgd_mem *)mem,
+			peer->adev, (struct kgd_mem *)mem,
 			peer_pdd->drm_priv, &table_freed);
 		if (err) {
 			pr_err("Failed to map to gpu %d/%d\n",
@@ -1480,7 +1480,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 
 	mutex_unlock(&p->mutex);
 
-	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
+	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev, (struct kgd_mem *) mem, true);
 	if (err) {
 		pr_debug("Sync memory failed, wait interrupted by user signal\n");
 		goto sync_memory_failed;
@@ -1577,7 +1577,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			goto get_mem_obj_from_handle_failed;
 		}
 		err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
-			peer->kgd, (struct kgd_mem *)mem, peer_pdd->drm_priv);
+			peer->adev, (struct kgd_mem *)mem, peer_pdd->drm_priv);
 		if (err) {
 			pr_err("Failed to unmap from gpu %d/%d\n",
 			       i, args->n_devices);
@@ -1588,7 +1588,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	mutex_unlock(&p->mutex);
 
 	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
-		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd,
+		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
 				(struct kgd_mem *) mem, true);
 		if (err) {
 			pr_debug("Sync memory failed, wait interrupted by user signal\n");
@@ -1742,7 +1742,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 		goto err_unlock;
 	}
 
-	r = amdgpu_amdkfd_gpuvm_import_dmabuf(dev->kgd, dmabuf,
+	r = amdgpu_amdkfd_gpuvm_import_dmabuf(dev->adev, dmabuf,
 					      args->va_addr, pdd->drm_priv,
 					      (struct kgd_mem **)&mem, &size,
 					      NULL);
@@ -1763,7 +1763,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	return 0;
 
 err_free:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem,
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, (struct kgd_mem *)mem,
 					       pdd->drm_priv, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 704f07be2b3f..3db9433f7aa5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -689,8 +689,8 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 {
 	struct kfd_dev *dev = pdd->dev;
 
-	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd, mem, pdd->drm_priv);
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem, pdd->drm_priv,
+	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->adev, mem, pdd->drm_priv);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, mem, pdd->drm_priv,
 					       NULL);
 }
 
@@ -709,17 +709,17 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	int handle;
 	int err;
 
-	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->kgd, gpu_va, size,
+	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, gpu_va, size,
 						 pdd->drm_priv, &mem, NULL, flags);
 	if (err)
 		goto err_alloc_mem;
 
-	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, mem,
+	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->adev, mem,
 			pdd->drm_priv, NULL);
 	if (err)
 		goto err_map_mem;
 
-	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, mem, true);
+	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->adev, mem, true);
 	if (err) {
 		pr_debug("Sync memory failed, wait interrupted by user signal\n");
 		goto sync_memory_failed;
@@ -738,7 +738,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->kgd,
+		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->adev,
 				(struct kgd_mem *)mem, kptr, NULL);
 		if (err) {
 			pr_debug("Map GTT BO to kernel failed\n");
@@ -756,7 +756,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	return err;
 
 err_map_mem:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem, pdd->drm_priv,
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->adev, mem, pdd->drm_priv,
 					       NULL);
 err_alloc_mem:
 	*kptr = NULL;
@@ -938,10 +938,10 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
 			if (!peer_pdd->drm_priv)
 				continue;
 			amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
-				peer_pdd->dev->kgd, mem, peer_pdd->drm_priv);
+				peer_pdd->dev->adev, mem, peer_pdd->drm_priv);
 		}
 
-		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem,
+		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, mem,
 						       pdd->drm_priv, NULL);
 		kfd_process_device_remove_obj_handle(pdd, id);
 	}
@@ -967,7 +967,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		if (pdd->drm_file) {
 			amdgpu_amdkfd_gpuvm_release_process_vm(
-					pdd->dev->kgd, pdd->drm_priv);
+					pdd->dev->adev, pdd->drm_priv);
 			fput(pdd->drm_file);
 		}
 
@@ -1496,7 +1496,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	dev = pdd->dev;
 
 	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(
-		dev->kgd, drm_file, p->pasid,
+		dev->adev, drm_file, p->pasid,
 		&p->kgd_process_info, &p->ef);
 	if (ret) {
 		pr_err("Failed to create process VM object\n");
-- 
2.25.1

