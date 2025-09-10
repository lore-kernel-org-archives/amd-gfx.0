Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82ABCAC583
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFB410E8F7;
	Wed, 10 Sep 2025 11:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UjddND4O";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D49210E8F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0jCCZVfZdLn+/xgo+6I1zP7Kl3FnqPrgQBKHKo6tGFheyzbv4P09jzgIFW2j0wbS68AF03mP2SQgvycwBPoi397ip/3UBcdfKEqYNT0vcvGwLS76fm0FYoEdnkecFb7rerCdtANCyjszU4Gr8xCgmk/PtRDmp8KPhgfJsatkxFoYGnGqUf2+aULg160p1goClparbW9k8mu+95gXGQuFD5Yzq4Qzx2RovnaA6/4GJy+0twrOrUiZBdtaDSCbTkGol2rcxqPC7ojUKBuJdU8lshCQHeNzqtXfUHxjTW2FzQJToTFhr+Or+kTwUHuAMZXldboFCL+Ga2Ha/P6kXgc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQ3u4FtBw2V1TVsYCpioyRaAwExQ/KE3nSeNfCfrbGQ=;
 b=Cq/P32yGFgyQEriryzvPqXs+ic5Oiesj+FvyXq4zs4tj7B/pG74a4tu+E/70rD/cuvQ4WyiQQTvRE194Mft6vOyEn+eoNwVCEUJrqlAsJ/f1b3wrq90eil68/cnHK0gd8/jHJvXSM1vfxvjG2x3Chkq8cf0EGs0Rb5EOWVpPoax0eYqbWggHTnZhOw87zVJOm1rDDqJe0Orc2N1bs7u5gA425aPiEPMHFHKlP52tje102kYyMB7uxc+8Ca/RtRX9sEoUkiqAMEYq74ZHY4AwPOZy0oktby49UaxEiITDJymSmKD6MNwjvlvYlGzH0Xk8lGqy7ypyoKGESxLyzC7mBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQ3u4FtBw2V1TVsYCpioyRaAwExQ/KE3nSeNfCfrbGQ=;
 b=UjddND4O6Us28Jfsmklg6wXtSFJUmF9R6TlWa+zrzOptVULgDUvrNQwfBOtC/8zvvrTw3+Lr4efOYYZJZUTHanur6QSQHd5GG/5xhQ4XSKDdXLa4EiFbbbWc1QPC98KYe862x+7hvlHF9DyaofN9J5V3WSVTyJ7iEpWWf0M5Xhw=
Received: from CH2PR05CA0067.namprd05.prod.outlook.com (2603:10b6:610:38::44)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:56 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::8a) by CH2PR05CA0067.outlook.office365.com
 (2603:10b6:610:38::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Wed,
 10 Sep 2025 11:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:54 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: validate userq va for GEM unmap
Date: Wed, 10 Sep 2025 19:37:31 +0800
Message-ID: <20250910113731.2688320-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: db3fec32-b601-45dc-5808-08ddf05e7c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YytMYU9KYnk0Qit1S3lyYXNJRXRwSm5jT0I1anVydDhHUkM3RTRsNmxKVC8v?=
 =?utf-8?B?VDA2MlhKVFM0NDY5RW40QVYrUUNPVHdNajIyTXpoKzBXMXB4VVJOQ3Z5UUxp?=
 =?utf-8?B?T3dUV1lJcFBqemNYUnlJcHd1YkYzakE3bW51dEx3ZGhHWm02OXFtWUdOY0tk?=
 =?utf-8?B?a3E5UFJwa3hwZ3pkMWVDS2FXWU1MS0kzdUNzNE9PS2lpR1NIY3lNVEg5aWdV?=
 =?utf-8?B?eVY1Qm43YTkxaVFXRkFiajJFMUh6RklCOTFPa2ZHOFRKNWFEYlVON2JEeG9U?=
 =?utf-8?B?SE0yZ3N5UHNUa3ZESFNFWklvenFlMHQ4NlhWOTdRa3k5SnFmZlphdDZXYjRC?=
 =?utf-8?B?elpWWkI3V01LQVNpN0JER1hmandhSUFlMUl4Nzc3citmYU5FRTFIU25Yb2lB?=
 =?utf-8?B?eFpCemhIWkhoWGZwRkViK1MrSlFVQUVVTGFkYmhkY0NQUUJ3MHpocUtFd2Vk?=
 =?utf-8?B?SUZ0U3g0bGVpQXNCVlVKOUVlcWlxQ2JLRWpvbWUxanVOQjdyYlRXTlhNR2NJ?=
 =?utf-8?B?SGlzakZaWjJrNkZrYjR5RU16SFE4WStDZFZNcmtZNklSNzJ3WWpkQ2I2dzdR?=
 =?utf-8?B?VGJHS2RyS3c0VS8raWc2WjlFRTJKbHM4NHJVTjgwYTJqWUcyQVM4emQ4RVU1?=
 =?utf-8?B?Yk1qMzZvaEZJSk42ZFkrdjNVRWlUZ2hRT1NSNnpTbFUvK1o3WTEyOXJHUlkw?=
 =?utf-8?B?S0dtL3lETjZUeHFsbWZNY1hpOGhheGp2VWxLNVVEa09aNU9ua0NvMDZjNkIv?=
 =?utf-8?B?UldJZGFCWThXZldaL2kxZDgvTkgzZW5jWmQrVTU5SCsxVExMMkh0aTlrSGl4?=
 =?utf-8?B?MW83dVVEeHQ3L3pxM05IaEtsc2d1aVFDWk1nWVM5TCt2T1F5RU9KdlU0bXNJ?=
 =?utf-8?B?M1g1M2JoaG45anV5Q0xYKzZ6U1FLNmppNVFQTnkydTZjbFVha1d0NUxZYjNj?=
 =?utf-8?B?QnowWDNNa3JocTR1aUZMQVNXa0FTc2ZNeVNNeEg0WUxQaVZMR2pWQzZDdm9q?=
 =?utf-8?B?TGRwWHN6SkxHSTVxdVpUbDBGTzlpOEFNZ1IvSTdNcTZEbGJEakUwVjVFcFhU?=
 =?utf-8?B?OCs0TGMrcUliTFhRYm45ZVRCTkwyWmxKZDI4TkF0Njk0ellRVFg0cDR1VnF4?=
 =?utf-8?B?UThyR05yWE1ZT0NuYUJLL3Q1VDJXbFkyWU01REgwaDFTVFgwRzV1UHJTLzhO?=
 =?utf-8?B?UXVIWW5sNFFhL2NMejllWWdLUWhHRWNFSTI5L0w1K0dzUFM3UUw3dC8veUc4?=
 =?utf-8?B?RGI4RWZSK2dSbkovNEt1MTJYc0dTNDRxaEFYRm40d0JzZERlWFdFdlBpZW92?=
 =?utf-8?B?cVZmYldMRWRXN0FURjE1Zi9oWFNJSURyMGcycHV4SVVVek9BTldPWnQvOVN1?=
 =?utf-8?B?V1NqTXNSUGprRC83WGg1QW5oRjRXTWJWWEhtaG14Q1JQbDA2MzJ2czZpUVRV?=
 =?utf-8?B?Tzh2NW9mTXZnbHY1N05scU01MmMrMTNFNlRGRDVaTFdtL1RvZ3QvTU43K2pq?=
 =?utf-8?B?YlJLa0ZKVlB1OEV2amdkNW8wcWJBd1hRVHl0d1VjZWk3UkZtMEp4NzZ4TEJI?=
 =?utf-8?B?c1hzM3d6L0tySGhGWTByZzZjSmlVVm5ZcHVQU3BNK2tQZWMxQlFpTlJRU1VO?=
 =?utf-8?B?cHZ5V3ZTRk9ERFhHdnFiRXZaU0FtZW9WbnF5VGszWXpoeTV0MDN0YVA2bnh5?=
 =?utf-8?B?ZUY1RUcrSHFSTUIyMTF4TGNkTzExRE1rUGJwT2o1alhuUHhhaW1GZmlYZTd3?=
 =?utf-8?B?dzVyZHlZLzN0ZE5GRy9hWVpzQ2RhcFQrS1NZd29QTzFDTE1UWUY0OUNUUU9h?=
 =?utf-8?B?WmJaVldOOHdESkxqTFJNZXhTeWRMZVYzMXg3RVoyclJTRm1IdHV1elBCNmNz?=
 =?utf-8?B?dEtFeVlqY0J1eU4ydnQ4Z2JUaWU4NnFkNGRDd2JMSmNNN2RyVElvNmpVWkRF?=
 =?utf-8?B?SUxQQjBFengwaFY3aStTUFFRRGJqMWVsODZRdFhtQi95anVKUkJCejVrTUpp?=
 =?utf-8?B?eFRoc1UrMjFudmdnUm56ckREZ3lYN3pETVRBbWJvUDhsOVRMVmprZXF4dUI1?=
 =?utf-8?Q?uS+ZV+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:56.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3fec32-b601-45dc-5808-08ddf05e7c9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 29 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 +++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fa44a47b2734..7976951c1a87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1188,3 +1188,32 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
+	dev_warn(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
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
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index cd63f7d79a95..65a8b750e664 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -159,4 +159,7 @@ int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
 				struct amdgpu_usermode_queue *queue);
 bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 				    struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a4..ccde1f040cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1941,6 +1941,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1961,6 +1962,16 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
+		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
+		if (unlikely(r == -EBUSY))
+			dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+	}
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

