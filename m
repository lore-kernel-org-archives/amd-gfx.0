Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8C3CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA7F10E669;
	Thu, 18 Sep 2025 08:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N8Y04WCn";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C29B10E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LosqSu49DH1+GYHfxWkJpQEkqDkXMC5nrLTTsHrsYlR8YlRxpsyr5codrUBg+bmgF/hZadqxFHZ6ACxcNhd4hv/HoX45Vg8vEtBsE/mAAyhAcXNXs5eyEuSjz63ZfI1M0uJe4GhTHtmn0WAnPJCtDRzG1MjvsKpfMOS+eT2TnNZs+MNmT3M8FSa7m6MqhH16ZA/zwCjeRbWVz13bv0GDg7oKRnRpDGASWQ8oquWGrfQypJqekFwXTX09+cI5qrTBEl8f4iIJW/0FPg11XNpdulZmAW7XO1JAY9wxPS8mEI2/aB4T4JLBeXiOxffW2KHS+2x3sRTjgLeejXMLko6zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F+e4KJQeqkD0AI1kWUmz8R9ueF16ebKQe23oGuKco8=;
 b=U/4SdaJcySQ3wAexoAFh+kDMfZDbyNmfV7GrczrKOP5eV4T54V9nLX0iJRmC0AT9KBvoxfk/EAx7f9dCDWvISIUwWWk87M/ycjFiAzqAc4T/8YPqFf7jF6ayYghd/XapLMtkiAl30kE33Ue8uj7Jbf4kfQTgL6lUZ1IPIObxzDQPS8as3JgDoz+o3c05UDH7/kAOuRO0vF0eduAwxaqa0Y5A53/plXBtqeMwTbZ3nPIRKo6u3Yaf5LpPC3QYIUnPUY/KtPhEG1PEgJG/ZTdExNwXv4RuEIvEqAtxLSvJVFHt1whZNjhAyjy3U8whwqGR4Co56mGgP6dVrCHJVx9DdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F+e4KJQeqkD0AI1kWUmz8R9ueF16ebKQe23oGuKco8=;
 b=N8Y04WCnE+r/FHm/ZXpOuOaKrpSHE8BwE6REQ/P1+m+fEM2QtlbmId3evUIGq5BKyFM7OV2E6aLF7lpyZDOUNiBkQYUFJ1v/qFm2s1oJ2hIS8efSEuTIvtEmFKO+fStPuRlcPPN13J96r6Y1lyzEEGPr1/dUirP2GCpXDzipiXU=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:18:55 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::e0) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 08:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:54 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:40 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v3 10/10] drm/amdgpu: validate userq va for GEM unmap
Date: Thu, 18 Sep 2025 16:18:15 +0800
Message-ID: <20250918081815.2755437-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: a8912261-3c06-4953-218b-08ddf68c01ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em44bm90UWZyYXlLK0NGT1JSem9HNkxFQjJ5QTF2Tmh4cjU5SFVTWG0vSVZQ?=
 =?utf-8?B?TFlWK1lzUUswV05mZHRpVG1qTXhJZ2xWUVJ5ZnVrc0o2NlJlSExBVjdMQmF4?=
 =?utf-8?B?RSthRGN6KzFsZ29YQVhXRGFrTEUvOXN0c0RpWHJvOU9ZZGJjTkhJSkZic292?=
 =?utf-8?B?YVBWencwcTBMampGZ0xuUUV3VDlwVHNYL212UGFyaHFoNUxyV1hzT3I1RGtM?=
 =?utf-8?B?YXprZ2lXSkdNbHFFY04xYXdrN1VpWElBQnZ3ZW1XNVdzQ2ZwNllmVlZmMmFw?=
 =?utf-8?B?b1RkYTh2SUhNcFFHTVlvd0QzU2g4RE1wc2xZMU55Tlg5YldxRUl4T29zSTBF?=
 =?utf-8?B?Wkk0Y2UrcnN6YzhQejd3WkI3bVFIelFUbXJ5L05FZE8vd0xXZWp3ejNUY25h?=
 =?utf-8?B?L0NQUU83dGVXV2hNcENtSEM4N3A1OHpsaWhHaWJtYTBtK1poZ2xpNG1RWDBX?=
 =?utf-8?B?Slk0cTc5TXNGUFlkMFM1dzdiT0xHSm4wVUlyQU1CRG44NXlTdkhKZXlFSVQr?=
 =?utf-8?B?Y3MzekF2cE9lT3ZtM0Q3TVNITXFyT2NwdHlMSStpS3FJNm45T0hyZWtiRHRQ?=
 =?utf-8?B?dndjTHhJaTJ5ZlBPS1p2ZnYzTHEzRU1lNXNzclRvQitFVWp0VTcySDg1UzVl?=
 =?utf-8?B?eTdIRWkyNUp3S29kR2NvOE1wM296VTZmcW9QVUs1WEk1bEwyZUc1cE50R1lk?=
 =?utf-8?B?WmF6djM1bG5TWTdHYUFPblhITXRhQVUzdThFdzJ5UmNGRGNBUldlSXZGa2I0?=
 =?utf-8?B?eURWMGpqWHkxVXJGZHJZbzFaWmE1S0p1d2s4Z3ZvQ1ZYazdNNFRnalF6cU5k?=
 =?utf-8?B?bU44bm8wRmZKckgvRzhRR2llR09Eamt2ald4bkRJVmYzMk5jdGZMeGJrWVkr?=
 =?utf-8?B?anExeDdIb0ZrcTVDa2h0UytTMFBvMHUyTjh6bThEMkVkR01id2RwYnM5aWJk?=
 =?utf-8?B?Vkp0UW9HQWRqOGVXODZRenhmc0hTcndnWWU1N0trL1cycFBGYnJUM2ZTa2xh?=
 =?utf-8?B?SGpYc3I5VUVic2VtT0owUmlSNk5scHdad0U4Z2tjUnozcGQyMU9EKzhudTha?=
 =?utf-8?B?ZFpsUUU3ODVOVUFiZ1MrZnU4aDB3MzBucUdrTlpIRm54RXl6VDE2aVE0LzRY?=
 =?utf-8?B?Rzlud2syWUV5cTJ4WEhFaVpPZGhCb29tTTk0Y1VHdzl5RUdjOCtCeis5bnV6?=
 =?utf-8?B?MTZRa3lqdnV4alJGcGluKzUrOTZZM1hHL2xranBHZ0lQN05tWlFteE1laHhS?=
 =?utf-8?B?T24rMnA4RTVjWFJSQ3JQR3Q1V3owdUtTVk1EWUxHQzJZNXhBVDNhd1cvTFY5?=
 =?utf-8?B?a0lteENhazN5VWJTcVp3ZXVLMXlWTnA3elV3ZHBlNnl5cGNWeE81dWcvVDJ3?=
 =?utf-8?B?dzVsTGsvaDdrSm1kTW80L20xQk5XWVVnSjYzaHRyWEU4eFIxN0JwTXZqZ1E5?=
 =?utf-8?B?SGNkQSsyWm9semZFZi9mNGZGL3VnTzFER0I2bVZmbFVmbzdlcUV5OFRRb0gw?=
 =?utf-8?B?dXdRb0RDdFZlRGg1ZXc5alZJTi92N216U2RTcGRya3c2cHkzM3lBREhlNmJZ?=
 =?utf-8?B?QmxXTzJuVHZQay9nZk5KYmtGajdicG8zbndWZG5mNHI2WUQxTmxuOStITmdo?=
 =?utf-8?B?TXNoL1hWcDFKZmZhTWdxeDRTemZFUTErcWRIOTlkbkhrZnBna3ZHQm9UczUw?=
 =?utf-8?B?VE1IeXVHbmp5TkprV1NVb3VoeFAwSS9tcHpzSndhRnE2Y2sxaWp2WEpXTXA2?=
 =?utf-8?B?VVBpMXBCUmVxcWRVS1dTM3pjNDFWcUFGd1hTa29mOHdPUU55eDBrdkFKMEtn?=
 =?utf-8?B?R1FnK3AxMFRKd2hBcHFoRFFvaGcvL0NWT2s1MVZtZWUwWFpsNnZHL3A1Vlgv?=
 =?utf-8?B?Zkkyc1dzbUZOL1l2NzZJWittblpFbXpEdXAybDJveW5rNHhpQkNzQk43ZEhL?=
 =?utf-8?B?c2dOUVVhblp5NnJXa25rUWk5L24rNXBMZmRKalVoRldIeGNyYm1RVHM0M1lP?=
 =?utf-8?B?aTVMaEo1VkdIRnNWNzNlbmtXM0xMYWdsbFVWYTkwV1dmamdQeDcvaXNEZ29i?=
 =?utf-8?Q?/K4GjP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:54.3367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8912261-3c06-4953-218b-08ddf68c01ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

When an user unmaps a userq VA, the driver must ensure
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
index 6d21d02d7647..7fdedbb40f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1182,3 +1182,32 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
index 2cb17d47d30a..973f8901904a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -153,4 +153,7 @@ int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm, u64 addr);
 bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a4..b3632f7b72d2 100644
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
+			dev_warn_once(adev->dev, "Here should be an improper unmap request from user space\n");
+	}
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

