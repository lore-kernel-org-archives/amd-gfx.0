Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6205CD8C9D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 20:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406C010E292;
	Thu, 11 Jun 2026 20:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pRKSzX51";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011031.outbound.protection.outlook.com
 [40.93.194.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCA010E292
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 20:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+MppBvRHzYk0m/45iPo+hrquPzYskYtijtbgixhXIXMQEu8Z3g8GYNcpBL+C74S9bC4Sd8F4R+yQwmQeMvNg8ggbP1cs9brZ5GdT0paAhdrB302VeMXckBhJK1imohIA/+6oDq/9Yolwwq/Fpgma/1wzW5ytaqxNkIRSYgaflwGMRPiOZddGlUYzANlydK/m7KWReu04veLlLfKEj05zL6AWp0G7EWgfiNvVxC/sarYdmaSv4jJrYTF7vf7u98j3LyesOl31zyn2IZTVEqHhkD0tqc6HJYyjpDWL0H1u3rMJQ1MlMiGiP+huZhEy6GDAUhnM4xI1cu8EXslc9CM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OboOsZAhOdZUVf/c9koYzYzYbyjvsX5hbh/xaQDOcJ4=;
 b=C5oPbkd4c3Yl07H8RvZF7n6FT4prilX3kvAqozo2qaDoMS/kDtBE8xJv3lmayDyDg74FzGMTBxcsHYcQ0EVuMn2r9ogJW50aMmVFwVWzeOZPZIX83Hqtn45zo0PBAWZ45TQRExrR+uvSyyQ3pfNy0ikjUbFBcYZmnQARxVKSHjFKT6AlKLk/JWhErOL3lTboEq5jxD+Z2nlwHoPEAwTKNmgsjJBiwqrop8idhrcMe0f6NTH7O44iimXj+dfGaXC+J1UAEybmiyDhnCRPeCc9oroLGX5JaNxFEKKvDR5taqNdk4jeRMHrwdQpj0t4fRUj49WcKIA5Q3aNcol/93w2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OboOsZAhOdZUVf/c9koYzYzYbyjvsX5hbh/xaQDOcJ4=;
 b=pRKSzX51yOMNcJdm31WSUBPsuU+UmHB83TI/LoNxVfyNeB4doR8zhsON5dEHD13oBiKONJ49UkVwMH3R/sF8mSLDqkeF1V8wSfkMSMssSuyyF8N4KWGp94P6ZBHtLNNhnvSmuUXuz/ipesz72Iw508ahlr7Hd1Z0l77LXlAsLgw=
Received: from DS1P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::11) by
 SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.13; Thu, 11 Jun 2026 20:06:24 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:242:cafe::8d) by DS1P221CA0027.outlook.office365.com
 (2603:10b6:8:242::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 20:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 20:06:23 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 15:06:23 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: remove obsolete events page mmap support
Date: Thu, 11 Jun 2026 16:06:10 -0400
Message-ID: <20260611200610.320178-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 02af6ba8-7cc7-4714-75dc-08dec7f4e9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: EFCVtTWZRUqquCsR5RcSPA/L55Xg8ykCwZFJtmgPJ8jSaB2gpYgTWhe9XQg0NL71RoNjKVnPjcuQtgu7DNGi9nHgmLEf5JzA15Vg/pM/W13Hgh6Scpcf24mjcqrAPYQThOBzXa2KrUjzVuxq653EmBFuWKGqlu+AASt+K1TsM37jcoh9eqPeQz7zOOY06YpA/0ECdq27BTB287I+98EOjoppHRy/ugCKeU1MQpSfvkM3Zn7C31+T5bn5gGhGDA7bn5KLj0B3toXzOgAz4c2GL/WpjtiMsF8FdjaQC5k4A+Mx0GVJzdjYGQ1fOvEeVk9iT+CC4nyg6aE6oH5CFY0RACf5plUaTxd5PEobGtMzVuL/Nfg/W8lZX0J+0pJ2sx+OuA6hT678xWmvNdeP2tVitcBUnyBSh/rUAdxs0vGl8xu8IFrK3JaUdemEtI1thBsUo4v2lyNfKf4xL+36vr+wjpkuTN5aM0BBXGR6xKNcZ5RgVXOUIR53T1dpfCeyu+tRGnQ8ydWlF9XS8sJxJc4dfb2ae/Ff0JX+O7E1A81ROm+xePL+ZvrniFpRNDf0wJkv6fCHP5RW0B49X7EGmwZpf226/m4JNOdh32AktK0C6D05vO83bZT+ciBhXBV+WjjeJnAnd4b8KmGLyPpKw/w2A6nGwZaUvUCb1a3wOUSjYixTVtYvIG1LDrFOMI0HPH9wXPxEBMSO5CsGnUqj+dXOt52KS18ly9mNet+bvTMCkT0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tn20wWzA6Xr8vAmBeuPpK6Au0BjyPs3Ppk1QejhCt9q8V89vGmytUR1Ys+pcrigUxpcw9/VWw66Na1puk8YC1j9eqHhBXcc/Scik3wmwVWk00iyrDpCprcwAL+g6AartuZhFxAE99Yc6Y0kAt7qn8f+YImIrdAaG1ED3PBbHjdQ0r3aDAIlg8JXV1RwPfSHAHwU8tBi4u50i/ulSwGr4Gs0+IGCTmlgmEGC3SlQXimdvvffn6ivXq8GO6TEnRWLrQPrWB/AGJ2HyiSMe0sV23XWlLi8IIlJjpGviDDeCe85pabLVJ/xEDZdjsy9KHYj1eZQ8sXWexl7dxR5YmpCh3XccKUcFc2WElqvFVfW6UZ8OakhrNQvxRJJAO6KS1lPpJalGGVKiWkYfyj05gnxr1JZS5WcSbHuPWU0KD6477PE7zdJj6ubNbwgas7BWcBkA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 20:06:23.9880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af6ba8-7cc7-4714-75dc-08dec7f4e9b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

The mmap of the events (signal) page from /dev/kfd via
KFD_MMAP_TYPE_EVENTS was only needed on APUs using IOMMUv2, which is no
longer supported by the kernel mode driver. For dGPUs (and modern APUs)
the events page is allocated in user mode and mapped to the kernel
through the event_page_offset of the create event IOCTL
(kfd_kmap_event_page), so the KFD_MMAP_TYPE_EVENTS mmap path is no longer
functional.

Remove kfd_event_mmap() and reject KFD_MMAP_TYPE_EVENTS in kfd_mmap,
similar to the recent removal of KFD_MMAP_TYPE_RESERVED_MEM. This also
removes a way for user space to abuse KFD_MMAP_TYPE_EVENTS of kfd_mmap.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 45 ------------------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 -
 3 files changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 349e462f8ee9..c322cec9e216 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3762,7 +3762,8 @@ static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 		return kfd_doorbell_mmap(dev, process, vma);
 
 	case KFD_MMAP_TYPE_EVENTS:
-		return kfd_event_mmap(process, vma);
+		pr_warn("KFD_MMAP_TYPE_EVENTS is no longer supported\n");
+		return -EINVAL;
 
 	case KFD_MMAP_TYPE_RESERVED_MEM:
 		pr_warn("KFD_MMAP_TYPE_RESERVED_MEM is no longer supported\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 9d717303c8ab..e44f1d1bc516 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1070,51 +1070,6 @@ int kfd_wait_on_events(struct kfd_process *p,
 	return ret;
 }
 
-int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
-{
-	unsigned long pfn;
-	struct kfd_signal_page *page;
-	int ret;
-
-	/* check required size doesn't exceed the allocated size */
-	if (get_order(KFD_SIGNAL_EVENT_LIMIT * 8) <
-			get_order(vma->vm_end - vma->vm_start)) {
-		pr_err("Event page mmap requested illegal size\n");
-		return -EINVAL;
-	}
-
-	page = p->signal_page;
-	if (!page) {
-		/* Probably KFD bug, but mmap is user-accessible. */
-		pr_debug("Signal page could not be found\n");
-		return -EINVAL;
-	}
-
-	pfn = __pa(page->kernel_address);
-	pfn >>= PAGE_SHIFT;
-
-	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE
-		       | VM_DONTDUMP | VM_PFNMAP);
-
-	pr_debug("Mapping signal page\n");
-	pr_debug("     start user address  == 0x%08lx\n", vma->vm_start);
-	pr_debug("     end user address    == 0x%08lx\n", vma->vm_end);
-	pr_debug("     pfn                 == 0x%016lX\n", pfn);
-	pr_debug("     vm_flags            == 0x%08lX\n", vma->vm_flags);
-	pr_debug("     size                == 0x%08lX\n",
-			vma->vm_end - vma->vm_start);
-
-	page->user_address = (uint64_t __user *)vma->vm_start;
-
-	/* mapping the page to user process */
-	ret = remap_pfn_range(vma, vma->vm_start, pfn,
-			vma->vm_end - vma->vm_start, vma->vm_page_prot);
-	if (!ret)
-		p->signal_mapped_size = vma->vm_end - vma->vm_start;
-
-	return ret;
-}
-
 /*
  * Assumes that p is not going away.
  */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3a8bd3eaf12b..13a021b0e6e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1540,7 +1540,6 @@ extern const struct kfd_device_global_init_class device_global_init_class_cik;
 
 int kfd_event_init_process(struct kfd_process *p);
 void kfd_event_free_process(struct kfd_process *p);
-int kfd_event_mmap(struct kfd_process *process, struct vm_area_struct *vma);
 int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t num_events, void __user *data,
 		       bool all, uint32_t *user_timeout_ms,
-- 
2.43.0

