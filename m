Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CA0CCFA19
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F6D10E811;
	Thu,  6 Nov 2025 06:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJeRCygt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED88910E811
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3wiOXABNKDw3xd/65WoXdROOZwvdoJEH39avw148UDVa2QgQYjG5sYuvV4j8Whi7rt9fCs447tF7fu0kLtUvqt2hoazyemIHBnMXYZDNtJkBie/FK9kzzHJLC2rAFgsY/5NpxOaz4gZqF12xcADyqnMvEiJtkm9W+HbmYzMF9nsuf89aHTs+luh5c11qXdBYpFeIxiv+DJMI+vr9E4MrFp35iqUU54ORAs3nyJ26zRpd5E53CMxhLCtwk7GNFiu8RTCwL9o7XM29pcUO2FFp2mz+oXTvUBKfSng7ligq2MnKQBgYs++2BeVPMPh9tadLYyFjPOhd+QaBeeQRa1W2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpuOT87mGRJkr3LUk+Pf0bO90r3kzEP/FFchV6JhHhQ=;
 b=yiORvwARbVz0kl4K69sulmzrc4wnTsdosVzCljntAit7bzKOFPdv70FyRTpYVtFoNUuoJV3+2y8gO32dZjT5jfdd9Z3DGTE6/k7DRJ0YGKzD5D/HX4PoDDlTg9K1fnr9V6e1BeW+wDtXy80+kiXwURKp5Hfp6b9Yu6uM2XTJEkpHJo0FUc1p3TAMJ2fS0Tf0trokLDKvLBMwyF7yi8FphvGXaUgSslMxqlzPSZy47Mvu5Chiw7Kdq8sjI/Xl6CPpQKO+jU5KOKxdIKk1kjTFP0GjD1URSYOUiRn8KWihoLksB1I2888hUUYW3jXueG993tc5pEB77e5yqe+iu8T4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpuOT87mGRJkr3LUk+Pf0bO90r3kzEP/FFchV6JhHhQ=;
 b=AJeRCygtHEuWIwlwUS7CHXmTxsYz36fjC687fkm+MEF1Te7Na7bZuKRsvboOJvZ91B0u6rrXrBOdZDmxw7CODclvI3YwZu6/yNUYWmgoRcHeD+Rk1nlvfRO6Ozrpht60C3X4lkkE7DuHTVB3wP4YRwbxkfPOsgPl5Bwh/+zZiEo=
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:08:33 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::8b) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Thu, 6
 Nov 2025 06:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:33 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:31 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 16/18] amdkfd: fence handler evict and restore a kfd
 process by its context id
Date: Thu, 6 Nov 2025 14:07:37 +0800
Message-ID: <20251106060739.2281-17-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c75fbe-058b-4fe5-cbcd-08de1cfaea83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75Ehg997/5IrD20Al+mGRrjIhaeG84Scshb06g2/+xyNK0zb7OgLRtEnx/Mw?=
 =?us-ascii?Q?HJKOosCmb4IxusN2JDo5Hp4oQb3gomLA/VAsUb7Xb/bFsIBvVYQP3evPyDWt?=
 =?us-ascii?Q?6+9vCpoM3Is3h02pRBhpdrNlR5jjs+sNdzlhWTlKyVK0SabqtzXEqOn54gwb?=
 =?us-ascii?Q?6lToUdbpJo9n5aTEYndesf4nPBJ0/cWlerlskhPDGFkpRX6iq2qtwuoMzwdM?=
 =?us-ascii?Q?ILGuBuYE+L5/1WqPXcHNTGUfJUgSigw5Xik47RUQLBBQ8e2oVJGa4cQpeOjX?=
 =?us-ascii?Q?FnVDjnhk09HHUewH46BRmxhr2qqQYsnHMORq3ck+flDo5vYiP+c0Cojmv9TJ?=
 =?us-ascii?Q?RBWbA2UrUaymdcytt6ES4QtUg1dZaXAqnU5mv2Y+0fjvk3ARESNt9bL7Dnz8?=
 =?us-ascii?Q?JxRRTUbHppgTHN+r4BqMr4OQLyGb9CiTG56hiRcugSAZ5/CIO4M0Jvx27q6L?=
 =?us-ascii?Q?XLLEL5x9gWbL4uRTyJUXtJvAQ+n7AOLokYGkLldQ11JvP2GBeP3LF0UHLaJC?=
 =?us-ascii?Q?iH//P4FC0W9r+Pi6ScVKcO490L8hiQseMxEI9TSmzn9QZVI4u/ZwbC53jsf3?=
 =?us-ascii?Q?vhqqtz6gZ6ajaaHtyLEEWQmnJ8hCKrjN5xUDhqM8vz1Y1DMOx+nNwdl+vkQK?=
 =?us-ascii?Q?l4k2Oh6/XxnqSag62TOZji44yb2CTa3lpjZlhizQwyQx+uSs08Ik+9vZCo4D?=
 =?us-ascii?Q?6nDHR9ZwP6ZmQ2NPTLPTAxc/xg0J4WxkUfaqa8KY+SEppswPpYbmRFjDXkcY?=
 =?us-ascii?Q?GNeBSh1DlkSOmMMD13tDbzklo1JKBdH4ONRycrKvfSbdU+qufFviD9ZN56LB?=
 =?us-ascii?Q?O03gEkr9RLzOfSVBqHBvprlxhWMhJ96p34GTr4Y8PQmQBt6CX9aUt/axGf4A?=
 =?us-ascii?Q?VamEJlLm9ahwPr0W+hY6rXNLTPcvYI847SJfedeyH7D9hl0MLO1Pf7hIuXlM?=
 =?us-ascii?Q?eO1XLECNC+Ae8qscaXwGGjddjQE1vZhNgfFQyL4NPN1KmASlLj69M9tOjylD?=
 =?us-ascii?Q?l8+IjtFv9azOAFTWWJzBH5wy5+KrrehYsGpgtBM/3ixMb7royDe72Ehsj6ci?=
 =?us-ascii?Q?yXGtB+RmDoD8ZLF7VNYdy0A51MOkt8Vs1HhVnhUhESqMaJRH0NEvCgG+a3P2?=
 =?us-ascii?Q?bgL+YMf0vrJviqvo10+7g+qEuomGKvmL8laUXNRIsXVsQhHQzx1i829wRBSb?=
 =?us-ascii?Q?YTrDmahmdEBgZtCNgkWMow9B4o8UUBb0ffLlk+i/ibBcz2E/zkhJ1sRaL+fV?=
 =?us-ascii?Q?PGsUvO6wwVwgRXydUEVQxbAtKexFCrNPCvkl3UH2fzbMyqzXsVvzHw8aMIhy?=
 =?us-ascii?Q?LOQNXxuf2ADgzgWXu/xG1OTSy/tZ63akzE7mtxUD1nk5BnAdp1d4m2tO8Qme?=
 =?us-ascii?Q?jKddxUUecJ/G3vabf8iP2757jdYOE92k54NGycoY8ZleZkUkYn+3sSR6vU7b?=
 =?us-ascii?Q?WFkQOEFjiiJxe6zFUuk5UoQZB4mNrRkHnk5+YI/yJ3g0GTmpj909y3zBHwsX?=
 =?us-ascii?Q?vKoAhM+gbSSZvai1jOUkELerXkOCGvR3qkg1vkgVyQlW4Ya0Bqapfkbtk8Vl?=
 =?us-ascii?Q?I2KRjvx+JJsI4mznGCg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:33.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c75fbe-058b-4fe5-cbcd-08de1cfaea83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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

In fence enable signaling handler, kfd evicts
and restores the corresponding kfd_process,
this commit helps find the kfd_process by
both its mm and context id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 7 ++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 087e8fe2c077..321cbf9a1528 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -411,7 +411,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
-						struct dma_fence *fence);
+					       u16 context_id, struct dma_fence *fence);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 4119d0a9235e..193ed8becab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -128,8 +128,12 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 	if (dma_fence_is_signaled(f))
 		return true;
 
+	/* if fence->svm_bo is NULL, means this fence is created through
+	 * init_kfd_vm() or amdgpu_amdkfd_gpuvm_restore_process_bos().
+	 * Therefore, this fence is amdgpu_amdkfd_fence->eviction_fence.
+	 */
 	if (!fence->svm_bo) {
-		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, f))
+		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))
 			return true;
 	} else {
 		if (!svm_range_schedule_evict_svm_bo(fence))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e9cfb80bd436..0b9a3c198c14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1202,12 +1202,13 @@ int kgd2kfd_resume_mm(struct mm_struct *mm)
  *   prepare for safe eviction of KFD BOs that belong to the specified
  *   process.
  *
- * @mm: mm_struct that identifies the specified KFD process
+ * @mm: mm_struct that identifies a group of KFD processes
+ * @context_id: an id that identifies a specific KFD context in the above kfd process group
  * @fence: eviction fence attached to KFD process BOs
  *
  */
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
-					       struct dma_fence *fence)
+					       u16 context_id, struct dma_fence *fence)
 {
 	struct kfd_process *p;
 	unsigned long active_time;
@@ -1219,7 +1220,7 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 	if (dma_fence_is_signaled(fence))
 		return 0;
 
-	p = kfd_lookup_process_by_mm(mm);
+	p = kfd_lookup_process_by_id(mm, context_id);
 	if (!p)
 		return -ENODEV;
 
-- 
2.51.0

