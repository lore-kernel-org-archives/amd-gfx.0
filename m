Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D327CD2502E
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Jan 2026 22:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 426A110E032;
	Sun, 11 Jan 2026 22:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EWo3+GzS";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE09B10E032
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Jan 2026 22:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAVwHIciSMYfkaDr5xdhcfS1sMHiz5BwxSyI2c1UUmYhOcio6sfCYwDnCYQf9VCyHDsk7uzb00WvIe2n/Jcdtw+4OPU5obyJ6ZL6XrF1+V71FV1ZwZ6vSIN6QlrzDENBodNM1VlcBGwAKPHJLv0QJyLxUfxluiNC4zYQTaT34kZEz2dweUH/MmWrxfVbDd3uNbgiKg1CG4hLP8aMjWPLV4EWpOI/sdCwuA0fhyA5lCmGK8S21dXN4koHde5XfGPBqEzWj80mLlV7zvAayw6Tg80PoEk5bTokgF1pmaFVXEb9PS9KXCN+THr/Uyu5dex/XsGUjAzCkI3mBtwq42k4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aogwfpNITzfaN4kAzHXYajpIda73wYKvf3IG0tEI7WU=;
 b=nthZEbtJ7K0salWTCiCN492YkCKlbmU/nsyc+3T6Etjkgnf/cVR9C5nQQ/9KBDxNKx7AyuDvBIrcY96isa0l/RkOFVfKHQ4vjiYX/ht8FQbv3u3+ZH+o8vVcmW0oddYGAi6kWwamXAezBbCRh7WYl07mmInk/Emw52/5J6+xUWDnbuqiNKxu87CpqRykh38hZF4LxWv+g8B/wMw2HwPc7SBfcZnzFBFhiKWBmCwekDy+quHd/VdhuxZvA48v9Vn5Go3nuLk0v2I83OwIApc2wXSaAPcdHSlF1UOyHTk4qUCv6ZNLupk9Z5DdBSVENjI/8G1usSv6Vd24b5Z0qrxuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aogwfpNITzfaN4kAzHXYajpIda73wYKvf3IG0tEI7WU=;
 b=EWo3+GzSV5dbpO7ut46KDcAhPUKkpSu/rFvRByJ+7eAWoeL0MjuRY2xoGjv3gW8u8tjRHxORm1iy6Hg4DvH+aXHmNHO5l3AuxQTyxsAL75u/pxKeY3dOutiqq+vYenO/QhIlI6fRf1DNtKL9R7d8okCllQws46trvv/UuN/F6ek=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Sun, 11 Jan
 2026 22:55:23 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::b4) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 22:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 22:55:22 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 11 Jan 2026 16:55:22 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Philip.Yang@amd.com>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix double deletion of validate_list
Date: Sun, 11 Jan 2026 17:55:05 -0500
Message-ID: <20260111225505.437415-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3c9abd-61c2-48db-24be-08de51648096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rYt5hL8AbWGHMP5JsT08cidodDuX5zurJel7h5IwtfaI1GmcGqIFGg9oHw9I?=
 =?us-ascii?Q?uS5XMzx2PFgk9DLA5y4F/dCHX/ZT8bQ+b3KOGhFkHWNi63EJlJPkGOaHUBcS?=
 =?us-ascii?Q?vvRX8LYgXw15Faypgryo4vGZZZof56L1JpaNbRjsnkyNBrGWD1B4sn0Jalsa?=
 =?us-ascii?Q?ez1g0jLRiVTVeXlrSOLuyjrO9DIBAYvmZkOi6oBNf9PgMQoBV+vU2rH1yvTE?=
 =?us-ascii?Q?90VCZOvD5kARrQkN1+/stPOD1i0b3dCjlYT2hAEvOC8DxawodV3Sy68m7v/f?=
 =?us-ascii?Q?Ry+HaicFcBOKVPuJ2sAJyI/QO84lBF0eMd5w4xbvRo96d2EbPPTYF6XTzOeK?=
 =?us-ascii?Q?JmEbC0rsUixMb+gJ+Ag7X2HdYCSieLkjLzhFsMHAxisNDjilsuON01JIUaKK?=
 =?us-ascii?Q?Fopgi7swELylbkWcsE4W86IyPBYJpNpkXKh4GOOdNdvuPa5nHedGG3U+RPsO?=
 =?us-ascii?Q?yw1ZSbaKyVVDmGiIKzKOvD0msEhHfXejiPX1gpfR75V/MWQIFsLb4vA+AQsM?=
 =?us-ascii?Q?Uo5WdKhI1sedUFmCys1l81eIxNXjzXb/5FEhlZQFUXTwAd9b+/3n2uF8TzNM?=
 =?us-ascii?Q?pLHDY2FJjkt7KRbnwma/yxM9QjOPgsau84dVBH1l5oJfKNjWfMp00C/KphTq?=
 =?us-ascii?Q?G2CQQYpRq6IaRIduV7TZ9mx4p0shzXbKsiRmtVZzymYe/oCMTN66iqMmwGmp?=
 =?us-ascii?Q?3L5S6kbl/TE9O0aiEpZMiJhKphyKIKqZxkflmfX3N4FuaeMiO/E33WA42EYy?=
 =?us-ascii?Q?NuZrxE55eYQg1Rk3YbMy2Ve5UHWT96nENhXoIFgt4nrGCzbtb7sEylME/jHo?=
 =?us-ascii?Q?Eh7kRwJm4ki8+dpS3m0klTgsnssx3JLu2YbuuDFBtrI/nP4M5UBFiI2wt5Xx?=
 =?us-ascii?Q?M8twMKRyIZgXmKF33xfq+ali/sIRgdiT797uRL17sfOMOCjU7Tguicoosnmx?=
 =?us-ascii?Q?EA6tQahIAd2+VuvkkINCTxZYUv1L1GyaNnkms7HWqc8fkHhhyOpjlNBmYS8R?=
 =?us-ascii?Q?ZlJRhQV7fYJiRJIEzLdZCIuWGm9UgJNaTsKaYx5QC3zj2CS1YwVbHlLyzG/L?=
 =?us-ascii?Q?jk4qmDnkR7kFo+xuDDO9FRyR0M7duiT/QLqWR2YjkOJ63E77W8rOdrFZnPog?=
 =?us-ascii?Q?A6V07J8kLOuIAfWxYDFmHhSQew6/aABEiHpfZKa7rkeFz8StfFbe3IWHVu3/?=
 =?us-ascii?Q?NaLpZdTu2viKw4EkQfs9Fq99l8XFrhPv2Y8xcEmnwtKuuuXj4/Ef0/bPODoo?=
 =?us-ascii?Q?81s909BCie8aFCBpTy9nqQGA+eq5S71cQCWAzqKZobSYN9IDzCWDpxIyMS/J?=
 =?us-ascii?Q?c46ibAyWwFMnz4ALFEmsA1qlSl/8Xpmwb6zawywMhCDt9nuf8br+rtNs4ich?=
 =?us-ascii?Q?ZSIUWqIiPrzEgcoHdYT0i/CPTMog0wSh8ezk3fJ1bMN5h/uK91anSiVnxCNF?=
 =?us-ascii?Q?nDHFewHfXh9PDfpJx9rKnaea8Cp5SXG2KpzejVu90qEMnpUaMo6ZlR/hHO6M?=
 =?us-ascii?Q?oxJD75yH/IITHsNwXD0FlsnVI/fXZSadK6ApCW3iCjYlo7a5rRCWCOTQKNkH?=
 =?us-ascii?Q?iSYUzwRxtmVErt6YS+I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 22:55:22.8652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3c9abd-61c2-48db-24be-08de51648096
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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

If amdgpu_amdkfd_gpuvm_free_memory_of_gpu() fails after kgd_mem is
removed from validate_list, the mem handle still lingers in the KFD idr.
This means when process is terminated,
kfd_process_free_outstanding_kfd_bos() will call
amdgpu_amdkfd_gpuvm_free_memory_of_gpu() again resulting in double
deletion.

To avoid this -
 (a) Check if list is empty before deleting it
 (b) Rearragne amdgpu_amdkfd_gpuvm_free_memory_of_gpu() such that it can
     be safely called again if it returns failure the first time.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 88fc430b9425..ff0f80483b1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1924,21 +1924,21 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 	/* Make sure restore workers don't access the BO any more */
 	mutex_lock(&process_info->lock);
-	list_del(&mem->validate_list);
+	if (!list_empty(&mem->validate_list))
+		list_del_init(&mem->validate_list);
 	mutex_unlock(&process_info->lock);
 
+	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
+	if (unlikely(ret))
+		return ret;
+
 	/* Cleanup user pages and MMU notifiers */
 	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
 		amdgpu_hmm_unregister(mem->bo);
-		mutex_lock(&process_info->notifier_lock);
 		amdgpu_hmm_range_free(mem->range);
-		mutex_unlock(&process_info->notifier_lock);
+		mem->range = NULL;
 	}
 
-	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
-	if (unlikely(ret))
-		return ret;
-
 	amdgpu_amdkfd_remove_eviction_fence(mem->bo,
 					process_info->eviction_fence);
 	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
-- 
2.43.0

