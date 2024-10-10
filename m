Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C90CFC5E4
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 16:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBD710E998;
	Thu, 10 Oct 2024 16:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U6sAI2R7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138BE10E998
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 16:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9UPKnQ/eguvxaFcFb6IU8K1voL9xgG8ThFq3Qc2pIfkuBs6BXSs0FByuLiYLXMszMvDtnLMxlYIMw/xeZhguRymh9ACKAVLRQhPdnl83Izsd0L6Qpmg0I2wCjri11VONAkxlp0XKmh2oNaEzabVky4sdBNSsRJUu6zKdmF93h94xZARbQb2uf+prDcLe9+5xRyUzkn59jnu+Tb9BovCk061bPS4AhaLH7puojszNVSSmandtSt4LbGBbBUnGgunbtx3IBgmp7UnmXnkDQV79LRpKGsQ4l185PXU/UXjaasiC/B6mE9BxfsoigvTKH+NLwF9pJPdvvsYBkMtIux9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNXPLHBYLk+wmQTKbimRppImz5KV/Wo/Y8rU+LLXhlI=;
 b=Csv+/Q3V7NedKAFTcPkJX61FqxQVQcatXuBLVR7kEkaNCAzf0qhxdbBWmHYGX7L8DV08ZQQoR2ePM1v3aHjPFhzUNN0uHyCAJK/2ZgUYNfvgs3Sj/4jjsWQue553b32IrBVOW0g8KOiVeXGHhZD4u+ZeEpAKYsfVix9zxNTiLXc5WF8Qbu/m6BB8pkSCduUibW+YAmpYtPHHF0/S31T5GvvB0bQhHtqdaF9kvuJS1AVWgtDpeLe6Vhv0NyCLZ3mu6CY4zm3XNLkJgLA3iqs5yRbjWMAKghm8mZ63FzUCBF9QDX95ry4pMoIz2sgQwv1SVKNgLThTxCMUY7dtcnPbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNXPLHBYLk+wmQTKbimRppImz5KV/Wo/Y8rU+LLXhlI=;
 b=U6sAI2R7fn7S/YKVEARprwI48TcxEdxO86v+4YF/y00SpDPHhXqVdz7jzuOLvl2ohlnVEzZSXug909nfWH+8dF28N+nBrsv9ocJIbhGvax1h0fToOiJNq6jRATSkbM/aoVfPxQvkUM+tmGsRvaW7Umqn+8nHx1HR39+1WuHnlI8=
Received: from IA1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::16)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 16:17:46 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::39) by IA1P220CA0012.outlook.office365.com
 (2603:10b6:208:461::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 16:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 16:17:46 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 11:17:45 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jack.gui@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: cleanup device pointer dereference chains
Date: Thu, 10 Oct 2024 12:17:29 -0400
Message-ID: <20241010161730.13416-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010151831.10859-1-Yunxiang.Li@amd.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 48750d40-d961-4a59-5490-08dce94713e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f2K3Y1+mkHjYNweG2PDDCtQH5zDuCSx799mCsNKYIfpwl+YNBf6PkgIIEazb?=
 =?us-ascii?Q?e7DqmAo/oDj8fxSyIDz4EbYYHzTBUyaR9w60n/u3xDgLbwW5Abw8p6/tmJ7s?=
 =?us-ascii?Q?D0X0Zn9k5TCsAbKYudCZedfdSGwwy664VJ2m6siUPmOQX4hs6gbqy/WlvgzV?=
 =?us-ascii?Q?drUQuJKykPs1DNOUC5EYaDRgZVlmKiYbEA5+aW6626KkQ3CKr0uTbP8TTXOb?=
 =?us-ascii?Q?HLZs8iGe//78T9kmX4NlG7WcrsNW66ghIvNSewE5kB8/gjvE96l/lq77HEJF?=
 =?us-ascii?Q?7Vt+ZYwmP2idObSzPi/gATyP8vgL0Kze71t5yC9GSiYZ8YxlDW6SkkXjla05?=
 =?us-ascii?Q?Ymz+XwfAMSuu5Dwrgb7hP2PATLstaaL/Ny9QOZT9HmzKtMJ7O5O9us4nBbNG?=
 =?us-ascii?Q?0uRx/Pd/eYsjL87IaMhJP1RyOCo/4TgB0b9LOKct0BKiERseuhso0SxUF/mV?=
 =?us-ascii?Q?NHtYwbMVDuHkrQi9YpyW/GPVbgcqwSoFIOLDceA37Xn8VhxnWCoQGizd9YTH?=
 =?us-ascii?Q?0aPx6WW3kKK826PPjiuOZUkF6bCtbXwfdm8Gn+4E/sK8pOsKIx5yvH49Z+BE?=
 =?us-ascii?Q?q/qfvzOJPEbQ9offeM1I/yql/FgartM2QNJXqjp9DFrUVHnD0CdLdLk+IKZS?=
 =?us-ascii?Q?jf/XohXV1CSgI+Z9O8g+jI8HeGK4K39Ssq1zDD7lOeNN2FCBK40Aaua9jDMv?=
 =?us-ascii?Q?UjZPRZQocKDqTYE8BGbbZu8vim15hQ/dJtzbgv+BQmcqAWRKAaTFFlBlBKHl?=
 =?us-ascii?Q?HHWc2hJcYMGK9NKu3P4pHs2QVEngmV57kb3c6EIgtxI6fMpt+4bTtREQ3lJs?=
 =?us-ascii?Q?aCLNC/LOOkF7tf589sQOSPt3TkyjyG0mEVjYB+I2tvtLastawXzl6k/LzSeQ?=
 =?us-ascii?Q?ONLsGAGJ2nXG8JXY7AxD40xPGCqW1g/rRQbLOVpwRtG6mpClUgqWU2jHvFwM?=
 =?us-ascii?Q?kX+umO6nPJUWYBlp5ZnLS8f9wKFAhoMqhiTO4m5ZjKUoXmteQ0bz1Y4dS0jr?=
 =?us-ascii?Q?Ej/AjXqVkp4njVqdsGL+yKZDkOOfy3kAO3xQS9nQfUmvgsx6oc04KBb+SSm4?=
 =?us-ascii?Q?eOkkyty8ot6YKYyTnpRKRSnGEYbu4pnsnh4HefFU67hZxUp+U7x6pW63Ow/H?=
 =?us-ascii?Q?NS4YxvMVLovrErSc3KQe1NNdS8pBSt1I43/m3ZgnzhO+GAHt0K+PerAojQlk?=
 =?us-ascii?Q?ZYIBK+iZdAS9B/g9kokidWYtfY+vtjHPhw/wtOiu3T4Y5CU5ebFStIf1lpbT?=
 =?us-ascii?Q?0jBSQ4gI2zL4e+AtdW0HY2qtW2m325EmrplzRHPRHgg8WDTOWWJzIKTvE1Zn?=
 =?us-ascii?Q?jxewM4sUn2PTBLNbMVm4kvaLgkf9pqpCwdAqyoUQfM36p352neTbt6119LAU?=
 =?us-ascii?Q?GrsFhVY+uOkUtYLKDCi0Ir9FqfBg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:17:46.4823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48750d40-d961-4a59-5490-08dce94713e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 29 ++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d665ecdcd12fc..c9ce95bc3ec8e 100644
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
@@ -1631,14 +1633,14 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	atomic64_set(&pdd->evict_duration_counter, 0);
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+		retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
 						AMDGPU_MES_PROC_CTX_SIZE,
 						&pdd->proc_ctx_bo,
 						&pdd->proc_ctx_gpu_addr,
 						&pdd->proc_ctx_cpu_ptr,
 						false);
 		if (retval) {
-			dev_err(dev->adev->dev,
+			dev_err(bdev,
 				"failed to allocate process context bo\n");
 			goto err_free_pdd;
 		}
@@ -1647,10 +1649,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 
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
@@ -1750,11 +1750,12 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
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
 
@@ -1767,7 +1768,7 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
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

