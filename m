Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8665BCA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E85810E49B;
	Mon,  8 Sep 2025 08:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nV97cdGy";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5359910E49B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgavEJ82Mt2wMxGccVcfwugLEoEF9p1hXKu85ZoSXW972eypINJnmucEY2GBBHkw000m7AixKKafwtT4wikJfKxTs781irKGqv/njJBHbZKV73+hw78987jWWj9wyoVmrE7URAWkyQHnmaxYOHgyDxXmKslgqcGj4YazkAaoG60UrV6YYaJeEM7wZyT+u6YGfEtr+7h3mWVgF9fPcAR7aViNc0cavNvCeiBHaAHATMNZpJrlTImVmXz5gOn55mBTQDETKkKkX5rZ966NGBPeX9Lxs7M/gLv5qXUFOnDFMvbspfN5HEZaqfxKDptfHtX/rAOsyI8FCqvGdPjdnxFAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBSV7vv4Oq2CdGpsaGtw32SiK/iMJLVBDSC7GNQH56U=;
 b=rOsNBhdpQ7B2PMBUDp3hAB8a+IF2vbgALBws9yntcDWyP2h2JUZp15anqH6Ar/ne/Bc0wEtPmd1LLskoPusVSoWdkeJbP1iY8Ln8/rXJ9GtMhkJEvA07/S37YV5MbsPVKqhdpvodHslKAMQJd43Rg2aMdhuMlsqfLVsqyn3UBkS/lg2ubJozFoDjpO4RLLDAF3iMcZLuFpBxSlihiw5bNh1/dA0Z5WwV21Z7JZMtSY/qxmPrHqDOMggSdVMuuLGp9tNwT4jgYV5ZCjkmeWHs20jtn1DbgYF90Eg/RNncqz7L9RsVmKA68yUXp1MyFj72UiAnjd4McF8jUCkHNLoulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBSV7vv4Oq2CdGpsaGtw32SiK/iMJLVBDSC7GNQH56U=;
 b=nV97cdGyeSYKCyPhZxDpkdOT7U2ypEMBvUgQ6my9KknTngmWt4xQVOFVdBDm38dkMtCKnXyevImaUVVOhhv4s/VKXxuARlLfjNnef+5MlX/q3zn6cEuJAESD8dJGqT14pRqth/vV98vC24Vm9Ii4KbOfjZIv9iu3ASzCo/V05Ek=
Received: from CY5PR19CA0071.namprd19.prod.outlook.com (2603:10b6:930:69::17)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 08:49:30 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::44) by CY5PR19CA0071.outlook.office365.com
 (2603:10b6:930:69::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:30 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:20 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 14/14] drm/amdgpu: validate userq va for GEM unmap
Date: Mon, 8 Sep 2025 16:48:46 +0800
Message-ID: <20250908084846.1873894-14-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: b3910fa7-d1c0-4e4e-338c-08ddeeb49fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3BCZXRKNkIzeHZRa1RpbWhNMTlwTG85VzFIZVhZUGhsNEVkQk9NdU5nTTJ5?=
 =?utf-8?B?SXgrdnBIQVNNc3Y2aEFXNHBVVnNrN1prbmRQODJ6djdTK3ExTmI3SmkrWllx?=
 =?utf-8?B?S1UwNHd3aUhrOFdmeGJCNlMvaFppSEdrK3l6UTgvN2FSUis1TjdvSE04QWRW?=
 =?utf-8?B?SUszMWtlQkp4ZjNRYVB2Q3hPVElFcDE0cU91alZuU2ltOVV3ZWljejJHY2dp?=
 =?utf-8?B?NE9qZ2tYeWtXMTBIUG50bTZqVVB3OVE1TVA3MFNrRjZQdU9PdDRudWRvRXZJ?=
 =?utf-8?B?QjNnQ2JodkhadnJpc0hGNGx1RmZYb1pSZ3QyeE1zUzAvS2NlcHp6clBGL3ND?=
 =?utf-8?B?cWkwRkJkUkd4ZTFYT1ZpZVFEakk2TSt2emN4Q1NTcm9Zam1hcmdLNUFPd2dz?=
 =?utf-8?B?RUx0bE40akw0ajlpL3Rib0NxYkpiNTR4Q001OUtRLzdBSDJaaFVQbmFyejlG?=
 =?utf-8?B?MTdNcXJKME5IRUI4Q2pFTzJSUUQremtPdTRjU1VyOWRzNitwUVBtdVFvM09l?=
 =?utf-8?B?SkhNYlRJd0VNQWJ5RE12clY3M3RDWU4vaE5OSUpuZlNMWlNIeXRpT0FabDg3?=
 =?utf-8?B?SHlUSjNPWVZ2RmlRUSs4U3dzUTVTVzExSG1BQjVzeTEwQTFKMjZTMFBKK2Jv?=
 =?utf-8?B?N1k5cjVnSG1neEcxSmE4djE4ckZRV083TFlGRFdIQzFDMXNSVWF1dDNiUEdr?=
 =?utf-8?B?RDNRTjVBYW81YklpaUhBZE5XZzNNNzd5MEZWeUtRR1I5S0Q0QjROWk1mWDRo?=
 =?utf-8?B?dWErcWF5S204cUFPTllTMTFEWXBSalJKUUVKSnNsNUdNRllaUEh6S2lLWTAv?=
 =?utf-8?B?dmJURm5kMUw5dFUxMVYxMzNzSktPYXk0MmFvT3BPdldLQ0YwKy9UdWowWjho?=
 =?utf-8?B?R2lWaDd3QnQwc2p4MzdYdUtuNHEycWQxTDR2WjErcWFLNWl5ek4zNVZzejFY?=
 =?utf-8?B?UnpJN1ljMkRNRFNVOVRQeHBjdUJSbHltcHRHTTI0UzIxZkRPU3BJSEIyd3dl?=
 =?utf-8?B?R2MvaDB6a1UzKzkza0k4Q2tGQ3FHazlLbmE3ZTZtUGJYaXkrQ3lhaFRuMVdL?=
 =?utf-8?B?cTZOcmlVNjMxa2ZnVGtieDdsWEtTTndpUEIzUERpU21hdzFLWS9QVDZCdGsw?=
 =?utf-8?B?M0VDZkoyNURyQUx4SXoxeU92bXNHY0NMd0dwNnN2SDlVVTBleFAzTlZXN1Ny?=
 =?utf-8?B?YlpPSXkzWFJUSVgzd1ozN3lpMC93TVRaa0VtRTBHR3hKa1NOYlUweG4wWEk5?=
 =?utf-8?B?dHR2OGNvZ2JOWWdsSkV3Z2VqV3dYSEtvZTJpZndpejhkMVdnTElJVzg1dlNJ?=
 =?utf-8?B?SS9ZVWZiN3FtZHFzSkZpQ0p4ekY5U3creFc4T3VidWxCa2xOb1JldStnZkFR?=
 =?utf-8?B?Y1liRHBCdy9BcStTUTUyRXJpeUtyNEZ2NDNwRU5VZEh4SFpQZEtCODVJRnJo?=
 =?utf-8?B?L3Q1OE4rc3JXNjJhQm5SdVhVenE5bmFZUHlOZE9xZ1JYVlE1cXR5R3Z0Wk1w?=
 =?utf-8?B?aHBqaHFOeHJNbDRqRzkwcDZYNFhSQUYyVjdrSisrY3FOTGVZYXJ1SHpUeGFF?=
 =?utf-8?B?Q2NvKzNIMVQ2SXliSS9ITm1XcTJHTW44K0k2NksxRmJMVDVKTk1aUGlTSVNx?=
 =?utf-8?B?d1R6SjhtckdzZ1poQzRxbDRyS2ZKK09EdGoxbGl3WVU4bkxhYlNSQS9vQ3hH?=
 =?utf-8?B?WXVzVUVERklabDIyV2hTWENnNlRtdVRqL3YxdUJCMjFDblJkdW9YV2hVNFR2?=
 =?utf-8?B?SVFJOUl4Nm1pNklXUzBzV3k0dFhFMlRCYXNhektDZ3dCMk9uekZtaURaVUd6?=
 =?utf-8?B?QlJROXRGZ0NUZlZLQ2VmeklzbTF4WDFaTk1rSU1jTVFkSkh5ZXRVZWRKSFQ1?=
 =?utf-8?B?Q0gwN0VEV2xzMWkyeEptUFhWRU0xbWRRd09uRTNLY3FXem16N3l4bkhZUHA5?=
 =?utf-8?B?eEY0MVJvYVppdXR0eGJZcmVpQVFlY2xDWS9hVW5kcUZKeTR0WUwzTldONGVU?=
 =?utf-8?B?UG1tM2w5Mjdac1h6aEQ3cm5GOGRNcUZBNHgxS2lwM0tKbHJWRU9mMlhvTUU2?=
 =?utf-8?Q?PSPqVj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:30.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3910fa7-d1c0-4e4e-338c-08ddeeb49fff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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

When a user unmaps a userq VA, the driver must ensure
the queue has no in-flight jobs. If there is pending work,
the kernel should wait for the attached eviction (bookkeeping)
fence to signal before deleting the mapping.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 29 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 +++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f90f384d55b6..fb838651c91b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -675,7 +675,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		}
 	}
 
-
 	args->out.queue_id = qid;
 
 unlock:
@@ -1212,3 +1211,31 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				struct amdgpu_bo_va_mapping *mapping)
+{
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
+	struct amdgpu_bo_va *bo_va = mapping->bo_va;
+	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
+	int ret;
+
+	if (!ip_mask)
+		return 0;
+
+	/**
+	 * The userq VA mapping reservation should include the eviction fence, if the eviction fence
+	 * can't signal successfully during unmapping, then driver will warn to flag this improper unmap
+	 * of the userq VA.
+	 * Note: The eviction fence may be attached to different BOs, and this unmap is only for one kind
+	 * of userq VAs, so at this point suppose the eviction fence is always unsignaled.
+	 */
+	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
+		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0)
+			return -EBUSY;
+	}
+
+	return 0;
+
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 27066906526a..865e5d4f61b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -148,4 +148,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				struct amdgpu_bo_va_mapping *mapping);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..c04eef1e7451 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1949,6 +1950,16 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+	if (bo_va->queue_refcount) {
+		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping);
+		if (unlikely(r == -EBUSY))
+			dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+	}
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

