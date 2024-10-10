Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B2BCF11FC
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 15:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD98710E95E;
	Thu, 10 Oct 2024 15:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cwtR/q+r";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5278110E95D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 15:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws/HXS3TTFDVwQ1zvkEFb44yOr20QNmThrk0Edj7tCpYUTzFCZ+8XypxpyWrcCdxv3HYcUYLR/315ge9txnZ8a+94Wjfz3smdoXRvwIBnJoOyfLwwtqKZBcId+pjRwm1/VFnctY3KkK8R+FegGJlaLu35foyAA6XkHZuUG3Poin4PM4xSmlFYhpZhlNuyfo46iyNG+nAnlqa1aTeJTIxaBfuDlONBjwtaOpA3/HtzeKjwKOaRATktmRYs166guolVx/dBfAdLe2qAdolpbwgOt7HUjj0NbzIAx4oM5pjH04dE6JhS51iu8ZEE1Vrf31YEuEFIKkURGrjrpc7Tf9Mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q8od9v9cEy16h1l3ffoBloejWV4Yf7x2C42TndhT5c=;
 b=NgccNjFjfNK6O+WtdiBtu8fbp2b04Z6yZbh2/afnp2jucrVj/zREK2ka3szeaOkHfHDYJLQhUrv637zvgb74nnhVxkWw/+tlHnbbGS6LJH2cu8q0tbv+w92o+85x5kSGRAVdUZ82krx0h6LTBzu+rfmKkGsywOZiDo+FOSm2V+Wynr4L1iHSVuI+1U16zhPr9dFjpdsWJiGACWUq2R76byDOTZTe3zKjkSmYVH03VhhO5QhYqj2PKZ9fTSUH/Mh4riD1Na00/KXNbQh+9krObdGJ+TM/0aUVjk/Q5Kh1yIIEULPblJOVO/ozKxeCNrvWJkF+zw+Pbd0WSPmy2xxb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q8od9v9cEy16h1l3ffoBloejWV4Yf7x2C42TndhT5c=;
 b=cwtR/q+r3YeinIN2Au1x2BsTZMpoXlqnrW62ImHsmSKbA4Q9sUKSAC+UhPIYcfWPWD5/qZeIlm/lGwQhNpBpBgczVa839CcFkAigQNVu5hR5sXD6P9I2k/51qkOXRgQMKJtbNjEcTLets12zSrAV75D5faraIdFEAELccqeyHg8=
Received: from SA9PR13CA0007.namprd13.prod.outlook.com (2603:10b6:806:21::12)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:18:47 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::bd) by SA9PR13CA0007.outlook.office365.com
 (2603:10b6:806:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Thu, 10 Oct 2024 15:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 15:18:46 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 10:18:44 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jack.gui@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference chains
Date: Thu, 10 Oct 2024 11:18:30 -0400
Message-ID: <20241010151831.10859-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: f31c9546-ef4e-48d5-0b52-08dce93ed5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/lmJjmmFakaGSY7RtDZn0piBgHOyshYv7B7b34IvxKHWuLd4ckrnCiIyNquo?=
 =?us-ascii?Q?ymChdFTGfR3z6tVpZhYw9gTZCtkKgj4x/je674J+7WiO0t9i5l42g+jo5QKD?=
 =?us-ascii?Q?586wO2JiIZjlUq2N0wpNBAVwUuY1ggzcujUiOOgl++tn+k5yUnNXkTd9FvJP?=
 =?us-ascii?Q?fdhZtRFYk4FfaRhF7pAk6aj0EOpShNCqapyz89fFNeKNhLbLhUWwUbQumhEe?=
 =?us-ascii?Q?JazjbVwwJBZhG86sTkxTKOl64CaO81vxGHR0UXrGiU+oeMzHZj0P56IXjWeG?=
 =?us-ascii?Q?hPplcKNGfwYuqMv+lW8gcIF8ZTqzcOQYJirQH6lOqTbet1b8OPZO4N/IyjSI?=
 =?us-ascii?Q?wjUfM2kiSACx75aVNoUHzOLnILq4wqp07v9Kx/kr0/bE002lvLO6rce/aVqd?=
 =?us-ascii?Q?nHbUiJpv+y8rBMrpuUkWlGDmPP/QCzWJ4mc4GZKo53oFOSF7NZ31KXTGPxdt?=
 =?us-ascii?Q?YTBSCDLG82Yn/hv39thxc/lI3VzhUBUUAkSuyocL3GSGmBfL+G+jRKa5KGV5?=
 =?us-ascii?Q?qNrih+x//1mpZPl2ieB2IjTqJUTlhufzSinSrXdXKjXj6vW9yjlcs6lgMSRm?=
 =?us-ascii?Q?D1EVrWHtZ9xgVdd4fayaaj3UIvpnosBXx0RBMo+g2YYxH3zjNpNE7RmnzLPr?=
 =?us-ascii?Q?Qc4bFxO51srMcfhIDfYIHN7XGxCIoC140X+eojVcFI1eAvoLH2nxt4OZqELv?=
 =?us-ascii?Q?KhiwEEqKbBRGcjsunWknArriF2QzvaqWueD48pe442HZikCLKrTq0kc0pRxK?=
 =?us-ascii?Q?ZXo1qmFDWy/ZOsoN9+H9nvb6kBRhUVwNHnVOG8E2wb7zQIIU6U5bSYbt+x06?=
 =?us-ascii?Q?ygslKaj/OsAmBFM5VZOfhbigptyCumfGH38Ldqv/cbwJSfvjKOHz/dQmlEk/?=
 =?us-ascii?Q?CnXI4DN3zYMq7b4ooydBmuFaTqqnqVt8Derdb11jD5wTAmA1L//v9/HIiWro?=
 =?us-ascii?Q?H/WoxHbCJ/4EOAWU0fIWpLlFnIIRAqCsb7nCML1ChKFkZ1NLIgrj0AUv2uXC?=
 =?us-ascii?Q?GpeMTPl00pTTz57daHROWI3P4SlpZPBTrTAaDG/rpEcV8C7DWIORu6nJV2gc?=
 =?us-ascii?Q?hif/h+h1cyc8Y1/Nb6jKv0f6mWvOr2ambcOBpOvolxt3+m3DdrxM3HpXEfWR?=
 =?us-ascii?Q?5bxCHtUn335++wlSoEaoKhIQJ3w4J9+dJ0LKAe8kPBOT7z0yJ2VYLVIviS5P?=
 =?us-ascii?Q?OFimDADkErJiRXMf3D+XT5naHU9yZMr9nVaIs3DRoJf0YyCBPYgmCoofsWK0?=
 =?us-ascii?Q?LUxHQlT6rxWZPoZJQOraKB2K6C6hoIH3xZ5r/WFXcjEH79j61cAbgRjNh1XV?=
 =?us-ascii?Q?WaRnC7RfGl8qiaJl1jCWq2v3fw+fhnJyjmzyHwnu5VCukelJsaJHY2lYAnEY?=
 =?us-ascii?Q?Y5uftD6+Zzj9HSexWcdnYtZvRLl2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:18:46.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c9546-ef4e-48d5-0b52-08dce93ed5e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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

Pull out some duplicated dereference chains into variables, and in some
cases grab struct device pointer directly from amdgpu_device instead of
via drm_device.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 32 +++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d665ecdcd12fc..c334432e55b14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1051,6 +1051,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
+		struct amdgpu_device *adev = pdd->dev->adev;
 
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
@@ -1059,8 +1060,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_process_device_destroy_ib_mem(pdd);
 
 		if (pdd->drm_file) {
-			amdgpu_amdkfd_gpuvm_release_process_vm(
-					pdd->dev->adev, pdd->drm_priv);
+			amdgpu_amdkfd_gpuvm_release_process_vm(adev,
+							       pdd->drm_priv);
 			fput(pdd->drm_file);
 		}
 
@@ -1073,15 +1074,14 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_free_process_doorbells(pdd->dev->kfd, pdd);
 
 		if (pdd->dev->kfd->shared_resources.enable_mes)
-			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
-						   &pdd->proc_ctx_bo);
+			amdgpu_amdkfd_free_gtt_mem(adev, &pdd->proc_ctx_bo);
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
 		 */
 		if (pdd->runtime_inuse) {
-			pm_runtime_mark_last_busy(adev_to_drm(pdd->dev->adev)->dev);
-			pm_runtime_put_autosuspend(adev_to_drm(pdd->dev->adev)->dev);
+			pm_runtime_mark_last_busy(adev->dev);
+			pm_runtime_put_autosuspend(adev->dev);
 			pdd->runtime_inuse = false;
 		}
 
@@ -1606,6 +1606,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 							struct kfd_process *p)
 {
 	struct kfd_process_device *pdd = NULL;
+	struct amdgpu_device *adev = dev->adev;
+	struct device *bdev = adev->dev;
 	int retval = 0;
 
 	if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
@@ -1631,14 +1633,17 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	atomic64_set(&pdd->evict_duration_counter, 0);
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+		retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
 						AMDGPU_MES_PROC_CTX_SIZE,
 						&pdd->proc_ctx_bo,
 						&pdd->proc_ctx_gpu_addr,
 						&pdd->proc_ctx_cpu_ptr,
 						false);
+		retval = amdgpu_amdkfd_alloc_gtt_mem(
+			adev, AMDGPU_MES_PROC_CTX_SIZE, &pdd->proc_ctx_bo,
+			&pdd->proc_ctx_gpu_addr, &pdd->proc_ctx_cpu_ptr, false);
 		if (retval) {
-			dev_err(dev->adev->dev,
+			dev_err(bdev,
 				"failed to allocate process context bo\n");
 			goto err_free_pdd;
 		}
@@ -1647,10 +1652,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 
 	p->pdds[p->n_pdds++] = pdd;
 	if (kfd_dbg_is_per_vmid_supported(pdd->dev))
-		pdd->spi_dbg_override = pdd->dev->kfd2kgd->disable_debug_trap(
-							pdd->dev->adev,
-							false,
-							0);
+		pdd->spi_dbg_override =
+			pdd->dev->kfd2kgd->disable_debug_trap(adev, false, 0);
 
 	/* Init idr used for memory handle translation */
 	idr_init(&pdd->alloc_idr);
@@ -1750,11 +1753,12 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 							struct kfd_process *p)
 {
 	struct kfd_process_device *pdd;
+	struct device *bdev = dev->adev->dev;
 	int err;
 
 	pdd = kfd_get_process_device_data(dev, p);
 	if (!pdd) {
-		dev_err(dev->adev->dev, "Process device data doesn't exist\n");
+		dev_err(bdev, "Process device data doesn't exist\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1767,7 +1771,7 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 	 * pdd is destroyed.
 	 */
 	if (!pdd->runtime_inuse) {
-		err = pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
+		err = pm_runtime_get_sync(bdev);
 		if (err < 0) {
 			pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
 			return ERR_PTR(err);
-- 
2.34.1

