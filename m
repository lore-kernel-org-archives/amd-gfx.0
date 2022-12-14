Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E5CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 15:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CC310E424;
	Wed, 14 Dec 2022 15:43:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3012A10E424
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 15:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSUcjpPt4BjB7u9oXp3q8rO/osoaknp/qEw+So04jNENTIh3coBWynyIfQVBeK37ExkeyQhRU072aP8S67edmzd7e+r+xjY+FGI7wqCd3w6D6O2lQH3QT83BbJ57wMHEFNM6Qkwyi6lqLbkqbmLJKdLQeihLGrlBxkrArDgZL+v+eGMWBtSY+D2MksEayaKYmS8g9vzU7Mn1KARahGXiVZKS7xz8zu7ZBSguNiITCZnMmfd4WlvCaGZeV+t0SPx1ht4+hqn+NgHJTYGbQ2hj9V279BqRl726LdpyUnLFNUtMNnPnug4r+o5zpmSP38XVT6zdPOFmPJiBD2iUdO2gSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfZ5qiIRPyf+J9DnsilFKGsHIUfwmh+6gl9XhGWVsD4=;
 b=mzNKWSmtUOAnQ8QLfp0MiKDY7v+RrJXrkrSim015DZqKA1WyiewiYbtkXjV7IusQ+uvtF05kN3UY3BkR9a3yVo+boAMffQvkp8eRlBPTQoC2WiB2OY9eFA9YdsoOYstNGnlNd+e8Gvf+TScjrQM2zBqNFvkVqSkWhoFJHzrFi+gCn7qOYvySj6Jz9cYC6fBt7QkoYUfPcUeoomFoBxKdTi/7rs0fremmLl55LVeggL37bDBDRAcyAdSIiQOx6GhJnS/bUuk2dAn6NlUhRmr8qtAw8s4IJcCktNrW6xlmXmMuGesLMaxGNi112N8wdmRV42Cgw5yXcyfTyahLXK/mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfZ5qiIRPyf+J9DnsilFKGsHIUfwmh+6gl9XhGWVsD4=;
 b=Mfim0uEaE9JAL9+/GhRt44DbuQM7qYqouc+KRkffsN51DR7L7Y9N4hcsXSqNc6nPIoEUORxrU7APzBQECrdn8EiX5kxSSP2D4UHtA1egtMta0yJVWkPtxoVneVkfaTwta/9RGcGiyXnn3grtLT7F5EsYD19RBOaIr1DnXefy7/Y=
Received: from DM6PR10CA0004.namprd10.prod.outlook.com (2603:10b6:5:60::17) by
 DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 15:43:26 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::ab) by DM6PR10CA0004.outlook.office365.com
 (2603:10b6:5:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Wed, 14 Dec 2022 15:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 15:43:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 09:43:25 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Fix double release compute pasid
Date: Wed, 14 Dec 2022 10:42:49 -0500
Message-ID: <20221214154249.2981-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214154249.2981-1-Philip.Yang@amd.com>
References: <20221214154249.2981-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 629cb33e-dc86-4faa-63d7-08dadde9f0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skviqaifF9oVSlemPgWNFn9xcEsVYcLWTRyrrv4cPu2GmWWTwCP/cNkl3fzDdy8hXC9D3GX86iFDAyB9+IJR8jIJwgofk7hILsCZh+Rz+nQX3rQgNerHIEJ6zrHGogvtSGrQKDkWwNwctKmhPhwB9RSjpswc7u6FbND3XUDIVCyL2ENEvNeNwmkhFsWqxPmFd54Cv8bA1D1adIynOYp+ASsZ7wQohiWh36TQg6rX6gIjPL8KicrMFmsISm1wOevETFUuD2CuuSeSf3Chr8xhcI1fzFwxcDlRPdXuQ9YdyEYYLWU8c2BIhSCp+tztQSERWaILuJfx1erXmplSW322yd7ErCnuGzemuo8LOfjrfM6wXX4SHppX5X3Nife0lkcwm+SKy/C0uQVtatw5GMULnVCiWqdO/bZDxBithb/Nyy3gIzciMVkD8s1zOvGAHGImktnYHkVJXFdRJmmcloZf1W0txMT+vJOYwkIsHMBrTOV98CpRxUrvNAeoqmaBRIlfuwLBeFF+JfoPGSANhdZyKVHWR/ROmyoRxOYp2jmpoU5pTTrVXAUK1WfUbrPygSKQ5/4Kxa0BtVtll+nciREsIIGN+e7g/99eovbl5iA77cNPqTF7QV5ctFH1Zhjlm3kX4TWHkn7Le7fMP6P2B8sAWXejv/i41xbj67z9w84mNNqMTXSKCFGgCq9GWflaSnQQJBZMMzFVRsktJQRWGB5uSZ6nyUkwSA5W4ekL239bLqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(1076003)(86362001)(82740400003)(83380400001)(426003)(47076005)(81166007)(356005)(2906002)(8936002)(336012)(36860700001)(40460700003)(5660300002)(40480700001)(82310400005)(26005)(41300700001)(16526019)(6666004)(70586007)(70206006)(478600001)(8676002)(4326008)(7696005)(186003)(316002)(6916009)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 15:43:26.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629cb33e-dc86-4faa-63d7-08dadde9f0ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If kfd_process_device_init_vm returns failure after vm is converted to
compute vm and vm->pasid set to compute pasid, KFD will not take
pdd->drm_file reference. As a result, drm close file handler maybe
called to release the compute pasid before KFD process destroy worker to
release the same pasid and set vm->pasid to zero, this generates below
WARNING backtrace and NULL pointer access.

Add helper amdgpu_amdkfd_gpuvm_set_vm_pasid and call it at the last step
of kfd_process_device_init_vm, to ensure vm pasid is the original pasid
if acquiring vm failed or is the compute pasid with pdd->drm_file
reference taken to avoid double release same pasid.

 amdgpu: Failed to create process VM object
 ida_free called for id=32770 which is not allocated.
 WARNING: CPU: 57 PID: 72542 at ../lib/idr.c:522 ida_free+0x96/0x140
 RIP: 0010:ida_free+0x96/0x140
 Call Trace:
  amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
  amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
  drm_file_free.part.13+0x216/0x270 [drm]
  drm_close_helper.isra.14+0x60/0x70 [drm]
  drm_release+0x6e/0xf0 [drm]
  __fput+0xcc/0x280
  ____fput+0xe/0x20
  task_work_run+0x96/0xc0
  do_exit+0x3d0/0xc10

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 RIP: 0010:ida_free+0x76/0x140
 Call Trace:
  amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
  amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
  drm_file_free.part.13+0x216/0x270 [drm]
  drm_close_helper.isra.14+0x60/0x70 [drm]
  drm_release+0x6e/0xf0 [drm]
  __fput+0xcc/0x280
  ____fput+0xe/0x20
  task_work_run+0x96/0xc0
  do_exit+0x3d0/0xc10

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 12 ++++--
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 589939631ed4..0040deaf8a83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -270,8 +270,10 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
 	(&((struct amdgpu_fpriv *)					\
 		((struct drm_file *)(drm_priv))->driver_priv)->vm)
 
+int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
+				     struct file *filp, u32 pasid);
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
-					struct file *filp, u32 pasid,
+					struct file *filp,
 					void **process_info,
 					struct dma_fence **ef);
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0a854bb8b47e..b15091d8310d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1429,10 +1429,9 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 	amdgpu_bo_unreserve(bo);
 }
 
-int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
-					   struct file *filp, u32 pasid,
-					   void **process_info,
-					   struct dma_fence **ef)
+int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
+				     struct file *filp, u32 pasid)
+
 {
 	struct amdgpu_fpriv *drv_priv;
 	struct amdgpu_vm *avm;
@@ -1443,10 +1442,6 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 		return ret;
 	avm = &drv_priv->vm;
 
-	/* Already a compute VM? */
-	if (avm->process_info)
-		return -EINVAL;
-
 	/* Free the original amdgpu allocated pasid,
 	 * will be replaced with kfd allocated pasid.
 	 */
@@ -1455,14 +1450,36 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 		amdgpu_vm_set_pasid(adev, avm, 0);
 	}
 
-	/* Convert VM into a compute VM */
-	ret = amdgpu_vm_make_compute(adev, avm);
+	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
 	if (ret)
 		return ret;
 
-	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
+	return 0;
+}
+
+int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
+					   struct file *filp,
+					   void **process_info,
+					   struct dma_fence **ef)
+{
+	struct amdgpu_fpriv *drv_priv;
+	struct amdgpu_vm *avm;
+	int ret;
+
+	ret = amdgpu_file_to_fpriv(filp, &drv_priv);
 	if (ret)
 		return ret;
+	avm = &drv_priv->vm;
+
+	/* Already a compute VM? */
+	if (avm->process_info)
+		return -EINVAL;
+
+	/* Convert VM into a compute VM */
+	ret = amdgpu_vm_make_compute(adev, avm);
+	if (ret)
+		return ret;
+
 	/* Initialize KFD part of the VM and process info */
 	ret = init_kfd_vm(avm, process_info, ef);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6caa9dd57ff1..51b1683ac5c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1576,9 +1576,9 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	p = pdd->process;
 	dev = pdd->dev;
 
-	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(
-		dev->adev, drm_file, p->pasid,
-		&p->kgd_process_info, &p->ef);
+	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, drm_file,
+						     &p->kgd_process_info,
+						     &p->ef);
 	if (ret) {
 		pr_err("Failed to create process VM object\n");
 		return ret;
@@ -1593,10 +1593,16 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	if (ret)
 		goto err_init_cwsr;
 
+	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, drm_file, p->pasid);
+	if (ret)
+		goto err_set_pasid;
+
 	pdd->drm_file = drm_file;
 
 	return 0;
 
+err_set_pasid:
+	kfd_process_device_destroy_cwsr_dgpu(pdd);
 err_init_cwsr:
 	kfd_process_device_destroy_ib_mem(pdd);
 err_reserve_ib_mem:
-- 
2.35.1

