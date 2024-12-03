Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA6EE64AB4
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 14:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B5E10EA2E;
	Tue,  3 Dec 2024 14:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LhS/+DDe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A24E10EA2D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 14:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnRr+fIjaVTSe3s8AXBsBTsJohN7+W8A/UO2aoXTBwdx3tcX8hq8hsbFn5Q6Yr0QWhIja6Z6jUUUuOCgimd7JJxWBnNCE9emGg1Y9gBNtXDkP3/qLRtYTl2RsqvseShWcg9uCo4K0LhHYSTLfTQHBAl+gfJ0sfZleWtA+bcYu+KrTjKIqbjNwQpd5NQDKdPDvNWaAMcT/kZtKrWjiE49JZVjsyLDO+2oYksw747D862TBs25N5DSiIk7khCR8J7m2fRO+70cXTsYCJctAAA/KH8WfEYpsCa25G6hKiN6ed8Lyl5sztP8eOgzZ/z4L3fUm1x/7KG0ujF33pIjmnqPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FObn9VOU07GWSlrdJSH1x0ygBj6Dg3bIa2JehGe8F9A=;
 b=HsNgca2rIh9VO5Ya+kShFdOUKLgu8XAmmseCeMMQJlcNkRjGCyr9sq2Ra68JctTBiaNSvz5q80iCPUIi7yBEhIM8kK070FL4D7pnDMfpRKtUba25N7oS6Lf6n2sGQAhv64MNsm5DkgysRmjT6kLnDCeD8U2+iOCqIBlwLBji3UNOVmR2IOKfVxehmYOPCBgf99kJAncAtqR/gkDZ57A8NTFucxruqK3hRu9n9VwwMB5/loDTF4kEtLcvsGUvKUnOdzdXqVZwnwmI/hFleXKpEhBbVs+K2zpSnPeovOwrl1buF8GKeBBbgRxYZ4/ZB0p66VosAfSXj9qf8qEm8Mq5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FObn9VOU07GWSlrdJSH1x0ygBj6Dg3bIa2JehGe8F9A=;
 b=LhS/+DDe2vFRlVFTNJXh8ZvJ7VCrTDrevab3obI1PAbgmrYUxeHhvD/bS+df7JolrOLPVNlrZyZSIugpZL7wOvkMt3Uir9dAFD3tiiDLp+AP27o2SEROcu23HPoPxiYVud04/1/e8jIlSEKfLxoCLjth4eDLCfSRK7W48Tc9DWE=
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:31:01 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::d2) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:31:01 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 08:31:00 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <mukul.joshi@amd.com>, <Felix.Kuehling@amd.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 1/2] drm/amdkfd: cleanup device pointer dereference chains
Date: Tue, 3 Dec 2024 09:30:45 -0500
Message-ID: <20241203143046.3643-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: cc188fc2-7df6-49e6-aca5-08dd13a71c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xnek3Aey6cBM8vaArh/gkO1BLD2v54P+F29akTjbUDdlh+dU8KLVHvtPGVH2?=
 =?us-ascii?Q?TyN8NNwCmYjwbgacbfCdyCiv6no2SMb1mgMWclP4twif01bKRVTIfXzmellu?=
 =?us-ascii?Q?oSg7Xs1A/cgLP+ykWO9ao2Rnkn5HTbgF1JHNAVUeMi4zmPYWhgSroKYYDmOM?=
 =?us-ascii?Q?lpAmDMxQfx4Bjlw8iPcufClq8zY52eb2bd8A4lhfpebSB8o2f+WTu9yonQqn?=
 =?us-ascii?Q?0zqRvLgaquBuGvFcQq7jq3aRgowILMYEa8WSDc+1OzASfaDet1OCXH/OKxAP?=
 =?us-ascii?Q?giP4VK4AeCdTmxhgiFoaRoQrt6uj+rYgGGZTE2mYIUH/II36b414y9h3gLwo?=
 =?us-ascii?Q?Q5OFKUciRhO1fTEUWOAu8dabl0UEAqgA57RZrkP8ZOD2fNBTyLi0qB3CPaSG?=
 =?us-ascii?Q?MDFVv4uRztwoggHFzJMtHOC+o0+uOVU/JK0hn+47QEDAcFpVuoCiR3O1QRv9?=
 =?us-ascii?Q?+ZMGR3hKPZP873WwqNtFSSPaGzTTln7QbUAeCYRq+YZCh1ewolxOA3tVE2mQ?=
 =?us-ascii?Q?17/g93EmTKw6k7fLnoE7qk2E8N6GoAaNr+gSktswQIKksObDUgKKqbgg/AcC?=
 =?us-ascii?Q?RhwFZFCo2xps70Gh0I2xrHn4bDcrAbhxKQilNcT3jxx0voV1MzTa3IsfBadn?=
 =?us-ascii?Q?qmr/rVPUNVR5hAsWm3/c8XXd2qJxmp9TBsgyJmkoDJYeipYn+XTTRyVZbB3m?=
 =?us-ascii?Q?xG6yUBoncTjKjMxN22Y4Uz3/G3xHZDsFCvmyVSZ0w/be2k6zzX3EJUXAy0n2?=
 =?us-ascii?Q?kVMty0rj4ApjFGmpgf2x1au2BTK4y0Tfs+2LFyuG7BBScOPAa2RdJNlY4XNs?=
 =?us-ascii?Q?goAt6eOqhmnJchL5obllIQUPM3S0rPzjiGqSvLvhdN5o4f6IC0/wKW8FQEqk?=
 =?us-ascii?Q?ic32s6PuAz+fiVanj6F/AEaAS1TTXSs5glvLr3eF9/a7qxcQaQVEfiXt/O2m?=
 =?us-ascii?Q?bsPB7SiHrTpnbLpTID0+YhVPDv1JRq3G2I19QoE9WMmS7Ctc23pYWp+47q2e?=
 =?us-ascii?Q?XP3JPDHwqUkzpkMX7cA4hQS43NqniSj833zQGerIWwoRfLb30MyiByKiGkX3?=
 =?us-ascii?Q?Zs1ZO7i7F2XDd44D7CBdZQ1dzj8RSvnxBcqoMwBuRzfMr3znkz4Rpk2+Jayz?=
 =?us-ascii?Q?XTUKv6KmtwbChjEgMLKhYJ775vPBuNICVbxzK+rKdtYt0ZAtn90craT4SZa6?=
 =?us-ascii?Q?vwzYPzywcTqiKeE8g1IecFUDXAa9XL3u4AZtrH24VDSStHPJyMJ2yZdI4c/x?=
 =?us-ascii?Q?lTFPwGc7p7RmNJYXD+2WVtTpNGHTwuUA2aHdzxcMvTVFOtgYhWqAdo4Vq1oj?=
 =?us-ascii?Q?H6h7MVQMj8rSktMs3seRM5cMxzWkSHtYZ0bTPYFhwty9mIZ8tFHFKumKCnPz?=
 =?us-ascii?Q?KawBkfLQ1JK1CMRM2CPAT+cJtSwMBAZIUVwfV9/0Elg9tSbZmEjt075lJ7iO?=
 =?us-ascii?Q?tJDcYB3KkARGdQJPCZTYbyk+dLTbCCrf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:31:01.3465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc188fc2-7df6-49e6-aca5-08dd13a71c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
---
v3: no change

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 29 ++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 87cd52cf4ee99..555a892fcf963 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1055,6 +1055,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
+		struct amdgpu_device *adev = pdd->dev->adev;
 
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
@@ -1063,8 +1064,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_process_device_destroy_ib_mem(pdd);
 
 		if (pdd->drm_file) {
-			amdgpu_amdkfd_gpuvm_release_process_vm(
-					pdd->dev->adev, pdd->drm_priv);
+			amdgpu_amdkfd_gpuvm_release_process_vm(adev,
+							       pdd->drm_priv);
 			fput(pdd->drm_file);
 		}
 
@@ -1077,15 +1078,14 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
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
 
@@ -1608,6 +1608,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 							struct kfd_process *p)
 {
 	struct kfd_process_device *pdd = NULL;
+	struct amdgpu_device *adev = dev->adev;
+	struct device *bdev = adev->dev;
 	int retval = 0;
 
 	if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
@@ -1633,14 +1635,14 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
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
@@ -1649,10 +1651,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 
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
@@ -1752,11 +1752,12 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
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
 
@@ -1769,7 +1770,7 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
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

