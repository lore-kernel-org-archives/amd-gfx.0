Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FBDCA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 06:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7791110E077;
	Thu,  8 Oct 2026 06:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lVPouZFU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1377610E077
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 06:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvltqDrIVaBNPdT4AJyu1YEb+f2sXjyy3cRyPmeZh7CDvAj0rZi1KGmf+xomiBW9sII5+Mx8VaJID61vgKkEfvZh0N1v2bEXvexbecfjV6EvjIG4F0xM+UklSZXqQK5T9eGef8NdU/g+nTCZnRnKf4caI8Mb5bN0naP+1mxFCGtkxvsvXhDUY27JsLA6THEN0qLjSxE79W+iwLFm6K63SooP1Iwn1EpLQ4Um+4tu3Wln2F1STfZO7zTgM3dT3Obc2leqnay13fC3EIP2G30apnVuAZkIAHnOguMTzbAQE14ypTTD98Hk8R3aEMOvyXYqieeywdxPR+1rMu4CVA9EsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBR8YGs9MsYY3FQp0MdLcrIHdwYElgdikKgvfxChqmg=;
 b=uHH6TmVRzL7qQwJAM3IphilrQ1ig1jWRorDw7G90Bt01k3j/YOQM1uCfVFYXNd5MRlOBLIP8MyHmGGyk8MXFWSxoofoFBZVRc88XhvBrRo/qWTrETJ76aEm2MLbeQtigusGaxdzjzSTMiCB5FuLbiaRx2WP906F8uot6YiidsZbfpsJWudfp6S3ku7HVFkeyC9FhPuai0W8RbCbrCxUknqKLeQo/7BQppFR0DpYcbnZSduhEPIVg0n7IfgRMUKWLysUemEOCzZXNwRW9AuwqlRmEVDoOJAeGR/OkeYd9spKp17tJWZje6Y5OZB6vUs2nXlPPbYok/680siG6sjeLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBR8YGs9MsYY3FQp0MdLcrIHdwYElgdikKgvfxChqmg=;
 b=lVPouZFUFTlVg9cocSWHyMjLA1qMeWtfRQJm9zA7NUeAGyLew9PCngAKjlGKMgmeFboFz2Zxy3Mk4TTt+0Ug7JI2EkPiQQNafGJem2vzywTXO+SePGfvYdrcwNOYnA7KquqSZRYcZji25anCAeeatOcF/qpuFvAFjLehug86mAg=
Received: from PH7P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::25)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 06:54:06 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::6) by PH7P223CA0009.outlook.office365.com
 (2603:10b6:510:338::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 06:54:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 06:54:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 01:54:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 01:54:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: reject imported dma-bufs as WPTR BO
Date: Thu, 8 Oct 2026 14:53:54 +0800
Message-ID: <20261008065400.3608540-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 1728bd74-2dc3-4b4a-5352-08df2508f238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: zx3uK/6px6Ukwxh0eHep+x1E85EEU3CMfin0B12ZFTHvCsNhqym0JfIoisZU7xJGJSptdWKBT6HttvQJFqre3TlYvKPHI9sL+5cnIXm782nt4dXbuCEesAvD9kBosVcHVQGzKj8aK/5vgUZL2VQB6oK7vlTTeBDp9sr22eChOOk25OmP9R8Te1y+jy47jh3rCNke+kv/xOc5HgAVCgJbFlPwHA79J6aSY8zdCfO6Oqj4rTpXj30UlZOO7icU+wRNzjNdKWqhCYALmEhjjPmlMA/0aNBw/CyoPqp95mQRM/7c2C8Rk770RC1v2xaIqXmNTYAwf5nCAbqUCyhV/BrV8OnERhcUOwMEL/RxkVcGJ2zVCWH/W/aCn2SSwaVhmd6rLahVIcB1U7xcmJ9VqEINA5dz41Y9LimeVTonpkohGO0qbq8Azxri/35OyXGI4tfcJe+hZTpOnZgEyrECOhAOFoWHebKrQsWG5+tP0NsdQhQhloAjycPhW1/c2heUGuCJHjNpEWrHxyp+uF+Ylw2N+27LUCz83TFFr6Uw5C2hA4rAuFhjYFi+yBZGkUTsbxNO7NLx7NqydQBpsMyiAbd50yutMAZvg/E4SI2m87egh9W3l/9hsuYlv6YVMxl88zt9EdN/s7b9VwLX1lpKDzyffB1uvkZasZidOyym3HygUQRltJe7GjFM819XMlBGhmc3IZj7BxUgKiZOeelHJRkrkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6yx4r4Uo635j9cQ7LIDn7ZbFaQIvxLbB+AwNAmybdaCjEMdsZhpsZHPAkEoag/EaPBWGov7rYWdV4/mEmns262YKvHYvIHXq+RdRaZFm/yJlhVtYeOT/WfIdBRKFypIJSzuu6eqVUeyApeWg+AWN6w2qzsuL1CX+rMOE2CzD08Zuq9PHdJmQl6lX+HwUQ5w5YlGaWtN+JDySA9Yz3nyKxhyQLMHWaEo1+n7kFsMjMmFJ7mFDG92hlaQbSAqye6+hG/B2IyypQrY5MQNMhT+Mhllx2R8g1B70KPC5uw8n5k9lpz6O2qKodWrPgaEASJQdjz61DLaMZ/COh7TjLZHGA3mjztdlcvqoNCUnF3stetsCWVjQ6WF2N+hKpYkgXnQ3lTDPf/UgyHKyvlfluzDCFGiGFCqLm8CiOvnZlmuRFskWzanq7k853zqEEaunqSMe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 06:54:06.2349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1728bd74-2dc3-4b4a-5352-08df2508f238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
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

USERQ_SIGNAL reads the WPTR through amdgpu_bo_kmap(). A dma-buf from
another exporter (e.g. udmabuf) is imported as an sg BO without a page
array, so ttm_bo_kmap() dereferences a NULL ttm->pages:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
  Call Trace:
   amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
   amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
   amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]

Queue creation accepts such a BO too, and warns in amdgpu_bo_gpu_offset()
because the BO is still in the system domain when its GART address is
taken.

Reject imported BOs when the WPTR mapping is set up at creation time and
when the WPTR is read in USERQ_SIGNAL, since userspace can replace the
mapping under the WPTR VA after the queue was created.

Fixes: 5fb2f7fc21a3 ("drm/amdgpu: map wptr BO into GART")
Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 118db0306559..a2fa59a9609e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -386,7 +386,9 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 			goto lock_error;
 
 		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr);
-		if (!mapping || !mapping->bo_va->base.bo) {
+		/* Imported dma-bufs can't be CPU mapped with amdgpu_bo_kmap(). */
+		if (!mapping || !mapping->bo_va->base.bo ||
+		    drm_gem_is_imported(&mapping->bo_va->base.bo->tbo.base)) {
 			ret = -EINVAL;
 			goto lock_error;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1b76c10d1ac2..7abb9d95ef59 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -54,7 +54,12 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 			goto fail_lock;
 
 		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr);
-		if (!wptr_mapping || !wptr_mapping->bo_va->base.bo) {
+		/*
+		 * The WPTR is read through a kernel CPU mapping, which imported
+		 * dma-bufs don't support.
+		 */
+		if (!wptr_mapping || !wptr_mapping->bo_va->base.bo ||
+		    drm_gem_is_imported(&wptr_mapping->bo_va->base.bo->tbo.base)) {
 			ret = -EINVAL;
 			goto fail_lock;
 		}
-- 
2.50.1

