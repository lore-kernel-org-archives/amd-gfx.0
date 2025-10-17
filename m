Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D03CCD19A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6484810EB70;
	Fri, 17 Oct 2025 08:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAsg/l2Y";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C23410EB71
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUSj6u0Az+eAYuY7GbK+tF+bfHczyKwknBcwW0eSBAFZwZaBGwk4XdIb7bmfbRcefXDEhMHsksrzDGOD1pjTJEE+Bb4wKt8Ous58d/Qs4kWOxvKRoslgyRTxPNbp2U3DJ/JkaluQj3tRLluEWchMpMXXd5u3q6uyXkN9318D1v+jO7s3zbIADlPU++pYgpoAY0DuGUJVyjT2xxJ3ndf2526joqEFSeVXOdhiXuXju/o3tbES/hlSDHjjygdhs007PIMCq8U/0uEElUHCO5YYPdUwuICMePdcbLFjCwbK1jE9osC8UGr1iyoz+UHWiGCGOCJLjYFDxGkdvkejS1bmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IsxeJkmA4jPUrpxVjEfUbEDEhxa/1d1Rkzj8m1EpvY=;
 b=W8NTYnk0C1gaWBsX+Ohkc18+iPU4iwgi1AGM1+Xk/QWBjBpWiemJW9oVKDKD3agOviypQkhdAJUWnc1y/Ik5+IaGFjbeXih1KO10f6zzceJppbF4+0KEqZgB4UrNzCTZ2trdRLrwkWOVwAhQ8zdilkYVS+o35IXgbvkJHDhXPDWuZ3XRFPI9Y8SBMP42a8Sa58Xo/9j5u27gcIl5xzUbbTem7LONUDI57Hi7w7AdFFbgasWDYyvMeVgxc+nKiO8ZnTrj5sJiueGIPei8eth/N3gOSkvw4TE6W2AkPMxYO83gnvrlDVvRo+QM69IPeeexcBMnzrRwAtiyd7b67L2nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IsxeJkmA4jPUrpxVjEfUbEDEhxa/1d1Rkzj8m1EpvY=;
 b=fAsg/l2YSYbro7xos7GmkGtHQLR04Kim9f09547pW70gaLboHljCg3dEAlCi5xWd0NMLR+fOZX9JmpIKFNBoe8KLJkvyK5dpgxL2RYo3CBjgr9RTzW7jsG4Jn+oIc4AQE+iXF7c09pA9pteQsXBctzuv13rLsenh6inTSoqLqJ4=
Received: from DS7PR07CA0016.namprd07.prod.outlook.com (2603:10b6:5:3af::18)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 08:43:36 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::12) by DS7PR07CA0016.outlook.office365.com
 (2603:10b6:5:3af::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 08:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:36 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:34 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 16/18] amdkfd: fence handler evict and restore a kfd
 process by its context id
Date: Fri, 17 Oct 2025 16:42:20 +0800
Message-ID: <20251017084222.54721-17-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6731b2-9983-441a-58ef-08de0d594328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WLyEbABJ4XhhmuFQvCUFUluDAITbTiE29QF3nxvua7k8s2xS5XAIyBxdR4DB?=
 =?us-ascii?Q?sUjd4ebXfvbvsHylyAyK3324zcGqW3ONGpNBHDZ4lbCEMEIDPz5D8a5ly4KI?=
 =?us-ascii?Q?0Gw6MfI89vPvEr+WixxL6jeLmv4S+q+d3U5/WkU3LU348Y174LlSCzBMqJUf?=
 =?us-ascii?Q?z96sg/iabRcyP+aYET3fPf3uN9NrIsdvfSX2K/pjMGUYFYKSn+FfnhVQGf7r?=
 =?us-ascii?Q?R3OSOZM5sOD350Zs9RdPyXc6Su9BU1MUQWCKeWccoyJ4pqfzrpEb+zmfGaHh?=
 =?us-ascii?Q?gqOW9jdjiZ3JOtkZT2jcbjq8KEB964qIPmuRZEjs/7/rj1IBc6GbDXmZ+YW+?=
 =?us-ascii?Q?1FefqglUxagNiGdgUWPX7TS5QtRUevkLts4xb0ifHNggSzk7urFG/f1z0K08?=
 =?us-ascii?Q?LDIeoDbtOowdmUyURDSEBWcJVM5/N+v6fbJxdeHA7jTMPyRXtQqC4aiW7gyo?=
 =?us-ascii?Q?Af+udyBsfkAfqfW1bHxhQQlQMGIn+7mnrkicE79jPKW+uIBDlc/RVIn2ravn?=
 =?us-ascii?Q?MpAuhFexixGbdCexCZAA2CoyDFdSeJfuc5N8ZrLNR0y0VlbbQwNRWqTSjboi?=
 =?us-ascii?Q?QtYBtpjA8Q2+LITmBg7vH51TG4Dz58eNhLA2d50u5hIfaFaBW6eQlZvZdHLh?=
 =?us-ascii?Q?IzIT1jDJx6F34u+L34QK4sVqpaYzwC1XkAi0nWiqlLvhA94qlVeY1P6S+g8H?=
 =?us-ascii?Q?iAVJEMDmzQyFsBI+8RgBXcTrXtNPP4vtV+aFhz6oC26ifWPAgvN5USKyRv0z?=
 =?us-ascii?Q?DF0sWkMG4+pgzpcqlZGtM3SS3P4LS11IhrCgJz40ktCOGNVWeexv7I8grRxk?=
 =?us-ascii?Q?RpDuWzn149YfsKPoIX/J/GfotBCD96P93qDhJAWmawG0vf6Ksys9d4pMgo/5?=
 =?us-ascii?Q?lU5rZ0juLDMOXxJ4Xit/2yDfWXmzAJYyZZvvV5oPmM2UM8gZ81OgL9sqw3Hq?=
 =?us-ascii?Q?pOhe2ymehYVDaK7Q+vj2dilCrnw/yAZsgOFton4Wm5UdZvHbvPGuxgpmjzc/?=
 =?us-ascii?Q?BMini16csllTfT16SyvY05k8SIhgOXy0j0Kixr+odR2Lxekvh5JW17p2yGVA?=
 =?us-ascii?Q?iNvQkrvIlTEBTpjOruLyPNYWoAGcvyzqn2i8RUKpSfFNLb9UXw70Q5EwB0q7?=
 =?us-ascii?Q?vDwHmVCsiE6DH8tenRo7cpIk1+59TZXBzQXMLJlEhKP265etkGjL+aQ733R5?=
 =?us-ascii?Q?faig9aCIkyKQLH+IiboGiKWRh7rytPzQ7DhQuKNHPTc7mkXz78v8cIUv1j/8?=
 =?us-ascii?Q?DH9q/x8yhaLjkKDPVfOf9GLBlNquVe5Hql9zRr1+CqrCZHMFhw+IT1tSahmF?=
 =?us-ascii?Q?5cBegA/q18j0FkI8HAuJXePGdWnNc4Q6jf5wjmoOels5c9A2ix0xOzfiM57m?=
 =?us-ascii?Q?z/cKWf2UayQeRiXYj6hzf5i3hTP9pN2OxPakdMtYVvbDUcis2EHS9i/unyd4?=
 =?us-ascii?Q?SL5ANB+jlzWRg5e9Fb48fH8dF3F/Hc8UlZ5bSGUhgjO8ao7ZzWneUdlj1eCo?=
 =?us-ascii?Q?/WGxo/3qmISTh3KS+moy4wTPNpotRqxJ4fxNSdW1A+MVKs6D8Kkx3VhDrhk2?=
 =?us-ascii?Q?zYsaqeFYgNCy614u4mw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:36.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6731b2-9983-441a-58ef-08de0d594328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549
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

