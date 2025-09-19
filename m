Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454B9CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D08610E963;
	Fri, 19 Sep 2025 08:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVqBwA8A";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D665510E960
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZX5PByfhi4QnPxJlNlLqOONDIdc+MCT4xgg8daTx/U1UEBSQnNEN2D4xhYkQO6zTOwxXcp2xwk2volrG9CJuxekgrJDK+t1v3GGl1eK3vKndxm2jO/L5qztJafUeB2krKIJiv1HjSH+fJKVURop/x5oHV4+HlFwR7Tv8zTsYS/+nQ/DoIGXwLXKHVvfC4nZfw4IfF3NOI6ZvIbwXlf2mTLc/BG+GY3tLFaq1Jym/owb5a9FZVhQXvcMK1Qvblir119P1aEw/mmzQab/2Exo4cxBFBVYi3pU00Xstrr0d+uOAUbfxApjfhQL5L8HzXpe9S9F5hpenvArXKnKZcG5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=senFySvyWf/CyhXTS9u5+J1zjNIb/ms/aY/lFTptHh4=;
 b=bGSmJKutvlGpH6tBdo0j5HEbdEY82n95kAg/7v8sJOT+pWnx2K5pShGGERtdxMK9zkdFP2jbcP8bqUM9cR6Z5pLH6B4LsYzZHAAWPrspx9nVVd4I1+MOwUqaqNV+VYBCnqELbNyBXkI1V2VEgR0+SEikfKIAKyPJb0pKotfGj7eicc8y4It9ySFMY4NOyaVCVCCn9TgvavWi+qVxhTSOivd307xQKSnKQPyKERbtq0ubCC+iVoA0uIKVdVaRO259V/I1PcA5bxXWzerUd0tGjI77MnyjQODeGP8hEl+5m9Aw/57sZCR7ROHPM/9r8w6WGyQ9XJEoysSecu39XibGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=senFySvyWf/CyhXTS9u5+J1zjNIb/ms/aY/lFTptHh4=;
 b=gVqBwA8AGjDkB8HAweYxIsPt498RL0200qH7Zfuj7bHpzO0v89eN4bkc5lCL76Yv4j1Vzvt+Kntl35r8W/bpG6H11kRn9CDnseQzhxGN6toRnJp/0uY7WP/siaCG6fD9uSALCJym4TJ7UQz2U2hxZQ5llVPOks/ZUuLeOnSWE2M=
Received: from SA0PR11CA0090.namprd11.prod.outlook.com (2603:10b6:806:d2::35)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Fri, 19 Sep 2025 08:11:33 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::8e) by SA0PR11CA0090.outlook.office365.com
 (2603:10b6:806:d2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 08:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:33 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:31 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v4 06/10] drm/amdgpu: validate userq va for GEM unmap
Date: Fri, 19 Sep 2025 16:11:09 +0800
Message-ID: <20250919081113.2797985-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4f3488-1f79-44c7-aba0-08ddf7542581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0ppZUpQV1p4c0RaQjlwdFUzVnhGWHVLMnIzSThvT3J2a2l4UmJMUE44Q2ZL?=
 =?utf-8?B?dXExeEI4ZElFbmRHc0VLYlRzd01uUEJJdk51N1lNb3FSMldZUDc1NFF3Q2Z2?=
 =?utf-8?B?Rm5ycEtVSE9jUXZ2YiszTEo2QzY1QWZrV2xROHBsanpMVnN5S1ZMTUZtMWtp?=
 =?utf-8?B?NHl5QXIray9RRFBnZ1F6eFRBRGxhVFlQV29XVDQ3c1ErT1dsdzlDdUFSN2FO?=
 =?utf-8?B?NTJnVVJ1Q0N6cGk4RW5qM1kvUXpYSFFsSXdBQXByMzlZeDB5UldURjIvRnlR?=
 =?utf-8?B?TTNkQU1Fdm5LbDMyeE9md2QxZjFvMzRvY1hNVlZBVjI5bnF0ek10M0xRWFgy?=
 =?utf-8?B?ZU5xcG5UV0E1SDQ5K3QxOUplcGhLVDVlOXRocjFrK3VHTkNiNnVmQUtpUDVP?=
 =?utf-8?B?OUNlYlNCNFFYK1JpcUxPVjJHWEVBMGtOZW4wUXBIQnlON21TNGl0Y0tmZ1pO?=
 =?utf-8?B?Qm9IcGk4UGtzRWVKaWwvMnVaMk9rckRleFhBTTFOdG5kVFFVWS95bHVxRzBz?=
 =?utf-8?B?RHRocDVIem5WR20rK1JYOTU5NXlUU0N4aTNoSUFIMmYzQjZDQUN3eW1CRWdJ?=
 =?utf-8?B?ODFjenlyelhSTUt2UGhiQ3RUR2xuWFJLQTF2emwwMGNXQlp6VVl1WUp2S25n?=
 =?utf-8?B?Tm10cFZnS1FFSE4xaEREaElPeXhBeWtPNk1nejcvMHVJdU5aakRwR1l0TTJW?=
 =?utf-8?B?YXN1WlBFNEdhVVRwOCtha1FxSmpaOTdkWFdBeFpyV1EwR1VHdGFMUTlVdTZz?=
 =?utf-8?B?Y0N0em1xQngzcmdXM1RTeXVXTk03emx6YTVudzJhSzNCOXFrdHk3eHVzNVRJ?=
 =?utf-8?B?c2ZUMG4ySlJOY2NRK01BSTlRM0oyTE5pYURpK1QrMEZ5RTJ4RGY4RnRobWhQ?=
 =?utf-8?B?NU9kY082Q0dSdmFXaDhtbDRUamxHSVM5RXNlWWxUQVY1NnA2SWlpS0l2SkJm?=
 =?utf-8?B?WDhyN2FMaDNOY1RuaTQ5dzNRclhtcDJNajJSeDhzVThvTjU0dEluV0ZkUzVI?=
 =?utf-8?B?TFpCdE9FQ2o2aU1NTXBtdThnL2k0NVMyT2JPdmQ1WUpoN3hJNjBUOCs3UzRI?=
 =?utf-8?B?MHIrcW1GNmJNYy8rRlRGWmYzUUc4eW8zYVZsUlkwdGpKdVBWS1k4djRkMVBQ?=
 =?utf-8?B?YzMzazdBSUlud1d4UnRmaDNhdTFGYUlqS01NZjZvVFBOQ0dyak95YXFEKytR?=
 =?utf-8?B?Z3MrWHBBallwbmFaWmdCcEF1bmJVNXJ5OXFZNUhhYWdNeWRmZHVKU3FBQ1FJ?=
 =?utf-8?B?K29udDhKazM3bm1XRkZzdjQ4ZGZ6OVBkaUtGMnZtWUU2QVVNcFB6MEJFMG1I?=
 =?utf-8?B?M2M1Z2RFOXlKY3IrK3JFN2s1VTVpUXBYTlNvUmtQbW1nLzFFWERaT2E3V1dQ?=
 =?utf-8?B?VkxKRlR0QTMzOEpPclJKeFdyS2VsUlN6SENxWEhBSU41cHhONXhtajFJNWlp?=
 =?utf-8?B?VzBqL1JhRUhpUzJMVzl4WHNuRTIvRHBrcFRXT21mc2t6dmNsZkthYzFlZ29I?=
 =?utf-8?B?MGMvT3JUMkptd0w2WitQbWw1SjByemtFZjN4eWJBOUxXL1BVK2FnT2NXZmt4?=
 =?utf-8?B?SmI0V0tRc2VrbENmcTZ6YlZ3aVYzTXJQOXlqZEFUUG16SzIzODhYWExJWXg5?=
 =?utf-8?B?cjJ2aCtBMHNzSFBIcGdGWDNIU1NHZlB3WG5nNGRKVXYwOU9YUmFCS1M1aTZ6?=
 =?utf-8?B?a0I4aFduUEtWV0ZXcHBMK2ZrUGJxQ3hoOGsrdGFqMkM3ank0cUViSEl4ampH?=
 =?utf-8?B?K1FpQnVDTU5YcVNnaHUyekdIMWVQMEN2Kyt1L0lmUDdhY3RuVXJPMDVQRFox?=
 =?utf-8?B?NmxFZWZkY1YvYmVJNHBseUJNZEcxN3BaWW1KVURTR1gyelF1ekhwVkVacGt0?=
 =?utf-8?B?V1EzTEk0Z3JaSDZ0bmtMeE5Pb0gwaUlBdjU5VCtrMVN4bjVxMTh4S3BOWmRL?=
 =?utf-8?B?eGJUaUk5VDJPVEtreHBQdjFUNXV1QTZHblhwUVNmWklwdGpXWUVUMHk2dXJN?=
 =?utf-8?B?b21xVVZEbTRaNHZCeVQwVU1FZGxWRFdEMllSakpJMDBTWnI2UExGMU9yQW5y?=
 =?utf-8?Q?s0G9n7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:33.4418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4f3488-1f79-44c7-aba0-08ddf7542581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 31 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 12 +++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 402145d64714..224d09019997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1195,3 +1195,34 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr)
+{
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
+	struct amdgpu_bo_va *bo_va = mapping->bo_va;
+	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
+	int ret;
+
+	if (!ip_mask)
+		return 0;
+
+	dev_warn_once(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
+	/**
+	 * The userq VA mapping reservation should include the eviction fence,
+	 * if the eviction fence can't signal successfully during unmapping,
+	 * then driver will warn to flag this improper unmap of the userq VA.
+	 * Note: The eviction fence may be attached to different BOs, and this
+	 * unmap is only for one kind of userq VAs, so at this point suppose
+	 * the eviction fence is always unsignaled.
+	 */
+	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
+		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
+					    MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0)
+			return -EBUSY;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index f19416feb7ef..7bbbb5988fc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -146,4 +146,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1ccd348bf48b..e12a314d27a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1966,6 +1966,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1986,6 +1987,17 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
+		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
+		if (unlikely(r == -EBUSY))
+			dev_warn_once(adev->dev,
+				      "Here should be an improper unmap request from user space\n");
+	}
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

