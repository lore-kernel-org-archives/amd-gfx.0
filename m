Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B36C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 20:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B8F10E0C4;
	Tue, 20 Dec 2022 20:36:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043D010E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 20:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRO3qi3Xgn7D7vuhb+IdZ52lgeXhyB9oKDV4htqKXdOVb/Isj6TCgCicwb6tWZSEvyjgjJvexZ3cco1mNwnjq2vyRxZoT8AMLBOnNycpUrT4kJFp6RylFGCkuW6v7mFo0DLoH/NIqNr6jE+WNbsZNM77jewDYa4jCBiGYyCKE9Nu3xm4hBFFSoAb5gXwigEyadZMSFeFlN1Ax2rrsgW5nf2arD2x3sNa9iKR16kNGw7E7bPq56UHwGfRXjLZB6X+Ao/Qdt5vm8WiKsNAOs8dvqQ490bz8HGex/uvnyaYhMz7YqXcaUpFKsBpegYlXl2o2x6N5paiEGBV3tLrHV4Vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0M+8PtLn+G0oCKdD17TQRvxTDOXm+ZFAkT/r62wXqM=;
 b=hb/wwWg3lJD9PdDtUbNhBLSqe9+56d6g/+0lJdpla49sToTDHCCJqiEsZ8fQ5TNUXyale/VVeu4bJVc99Ie0HBP6eMH7VXdYdyll7wKk+g6xuTghDvbFm8sR0QEBNVujdgglRrYSabdi7Mm8ZZCL0h1dhLXh6WoqSnfhY2ygXGat9m8E+yhOueumeM4qHn4kca3XsTp6V1OKdcRbXXwoqOMzcvqloKUf4wn824/eQwzcD+ZLaWQK54JGLVipNMbwYTXpxD6GFSG+AAmeBTVkEjzOfeSm6lCKu+jkFOYDxydcJL8kJ9SAtP/r2aY5VZBCZ/EyKEYHADDB+pStUPawJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0M+8PtLn+G0oCKdD17TQRvxTDOXm+ZFAkT/r62wXqM=;
 b=Si55NqUlg0t+UoCJ6k/3IrMAqUzfdgqwcFTeisyjErZyzPHGC/Do722rhiiW3MM8RpVTdosZ69A0Lm1iBUWwPxNcmcd33el3Le0Ferg7Y9hEHHDq/oUfBrpUPLRSpGivRPeWNXGdRCZlJoQ9NwclXZqG9dQFGigkXhiyV4mAKOc=
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 20:36:17 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::14) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6 via Frontend
 Transport; Tue, 20 Dec 2022 20:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Tue, 20 Dec 2022 20:36:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 14:36:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Cleanup vm process info if init vm failed
Date: Tue, 20 Dec 2022 15:36:04 -0500
Message-ID: <20221220203604.27260-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aca9b4a-c2f6-45bc-ce18-08dae2c9d834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIaTBPy3k/P/EFB9nhY5nYJHkmjbtQYPyPu/2haoS0cheG8+SLIegg94UI5yA9HfQo85XHR3NvQwKQcukfxgkesMtMa4IxB0Cfj/Vy0aeFugNDQDd0LiReb/EALduqQYaKGIieR2m/Wz2cJ/9jdSp1LdzJEL4lC6MzNfriMhlZ63eFnw9a8xF1mDCjYRfxKKKPUv2/7FgKJgM/D9SU9lft/VMOHp8pSOAeKO2LvC0FipFxWMNT5R9Q0oo6s8Ow4EALT2J26uenjKllBb4NkueDbr61kNFAoIzVPm4b+JcIbKQOe47cCXz2McZcGofWkqU/zJjaBKwUf7421h4nJKHHcgexAkjlV4Nu2J5I4UXfTQwzSHYAWiUqO+D0guMHDg/L/nInslMDGX9bVbWco9ZRxqAqqOCvE914gFN5KyWlO2CY0QGGbQphN2wrJDA/sBO2HB2V7x+9SC/gZJ9JEKRupUrbuPvUggIrlMRD461v0m2B2Bj08PZpusPHR0VP4+kkT7dP0PGBgZmAnx5Jufe20IXU1nWWX0Sue50cjTO0q4DFj4VqqZd/dNfKlAk6CVzxlLDkE47AGX5kF5i4hGM92AJfLkyvam8JqWbggOEJ2nck05wLS4rye4aZfSQcIuYLzRgJ81I/eYvW0hFj65z61d8gk64BnoOaMoEhP+/QPuGQypOGe6E7a1/PKvbfjc0OR+a6xI1n6I8E/7pX61P2TWKOU49A6ZXZZRd/6H3UE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(426003)(5660300002)(47076005)(36756003)(82310400005)(40480700001)(81166007)(356005)(2906002)(82740400003)(83380400001)(36860700001)(86362001)(1076003)(41300700001)(336012)(8936002)(2616005)(16526019)(7696005)(70206006)(40460700003)(8676002)(4326008)(186003)(26005)(316002)(54906003)(6666004)(478600001)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 20:36:16.9208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aca9b4a-c2f6-45bc-ce18-08dae2c9d834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If acquire_vm failed when initializing KFD vm, set vm->process_info to
NULL and free process info, otherwise, the future acquire_vm will
always fail as vm->process_info is not NULL.

Pass avm as parameter to remove the duplicate code.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h     |  4 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 ++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c       | 12 ++++++++++--
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 0040deaf8a83..fb41869e357a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -271,9 +271,9 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
 		((struct drm_file *)(drm_priv))->driver_priv)->vm)
 
 int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
-				     struct file *filp, u32 pasid);
+				     struct amdgpu_vm *avm, u32 pasid);
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
-					struct file *filp,
+					struct amdgpu_vm *avm,
 					void **process_info,
 					struct dma_fence **ef);
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b15091d8310d..2a118669d0e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1430,18 +1430,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 }
 
 int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
-				     struct file *filp, u32 pasid)
+				     struct amdgpu_vm *avm, u32 pasid)
 
 {
-	struct amdgpu_fpriv *drv_priv;
-	struct amdgpu_vm *avm;
 	int ret;
 
-	ret = amdgpu_file_to_fpriv(filp, &drv_priv);
-	if (ret)
-		return ret;
-	avm = &drv_priv->vm;
-
 	/* Free the original amdgpu allocated pasid,
 	 * will be replaced with kfd allocated pasid.
 	 */
@@ -1458,19 +1451,12 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
 }
 
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
-					   struct file *filp,
+					   struct amdgpu_vm *avm,
 					   void **process_info,
 					   struct dma_fence **ef)
 {
-	struct amdgpu_fpriv *drv_priv;
-	struct amdgpu_vm *avm;
 	int ret;
 
-	ret = amdgpu_file_to_fpriv(filp, &drv_priv);
-	if (ret)
-		return ret;
-	avm = &drv_priv->vm;
-
 	/* Already a compute VM? */
 	if (avm->process_info)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 51b1683ac5c1..71db24fefe05 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1563,6 +1563,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 			       struct file *drm_file)
 {
+	struct amdgpu_fpriv *drv_priv;
+	struct amdgpu_vm *avm;
 	struct kfd_process *p;
 	struct kfd_dev *dev;
 	int ret;
@@ -1573,10 +1575,15 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	if (pdd->drm_priv)
 		return -EBUSY;
 
+	ret = amdgpu_file_to_fpriv(drm_file, &drv_priv);
+	if (ret)
+		return ret;
+	avm = &drv_priv->vm;
+
 	p = pdd->process;
 	dev = pdd->dev;
 
-	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, drm_file,
+	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
 						     &p->kgd_process_info,
 						     &p->ef);
 	if (ret) {
@@ -1593,7 +1600,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	if (ret)
 		goto err_init_cwsr;
 
-	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, drm_file, p->pasid);
+	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, avm, p->pasid);
 	if (ret)
 		goto err_set_pasid;
 
@@ -1607,6 +1614,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	kfd_process_device_destroy_ib_mem(pdd);
 err_reserve_ib_mem:
 	pdd->drm_priv = NULL;
+	amdgpu_amdkfd_gpuvm_destroy_cb(dev->adev, avm);
 
 	return ret;
 }
-- 
2.35.1

