Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA73C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DFE10E8D3;
	Fri,  8 Aug 2025 06:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4uDXDr+t";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967C810E4CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DghV2HalvTIncOBpRZ+Mx87Bnt1g//KF/JmtC9hmXBnhtygcEtcQGMLNhMNJZbU/+mau3ww02Y07sxzxBGH7B0NcoTDwiWClrSdhi/Ox3XeIDgcfi/IDwa7ermPuEfA3BwyeSC8v0npCcKtiGykDHARse1rUe0LgozjVtve83W0McuxKcmNYoVNyMQmpYOPBf+mlijOICAipK0yCArRy7Rb3B9YKC5NCdur9355b000bnHxzvJZA5foI4KC3H/36HGwi1h+64+Hnu7EWQAcTDrkXzodzVNLlZ1EpousP5Do7JPq14LuLjFNs0Nh4wLTQ/TGryqjphbA3tD5FKmD6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPALdh66dXoy8VFLg7ainu0zPimuoiY3WR8f9XFGtmU=;
 b=irj4dBbBqbiQ7Jq/ckokzRUM3sNZqWLBuNKOslp6OoDKR8yv5Oe6Ka4Atf35fC0u1InpgPAg69CtSjz92twrU+9OT7t7E68WaRWh+zUJ3DPCRZS3NCxmYjZ1913myJCnhMNvy+SyJjJfp/3A0kZyvyVUTLHTiUE+MZfRifIUGSLnCJFGpXq2LBCmQf3PtUd83JeLRyX8/8jbIT21J4YL4i9SN6dNZ4oJFKOdgptRH3VmA2MF4NtetIMjoJd5Go67txJWc1/vKjONoFIaBP0l4X0OlhSNBvS/HdFPj5sAqm3GGRhBN0jh4/1X5adi7Lhlym2m/Om47ztLtv4+pgYzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPALdh66dXoy8VFLg7ainu0zPimuoiY3WR8f9XFGtmU=;
 b=4uDXDr+tKH1Hs74sawaosPGr5gmQ7xt5kuOqDFLsI9SnwV1MjLJhq761NaM3Q9gZQC5svng64ZYfoTWQk5cNBgwW/ITxn5G5X39vSpOXJtmbOq8NNm+WwKm5X2z9E8wE7KPdKkNRGDAe71HmdXt98Jjw5qpgF/mQOPgscpww688=
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:29:51 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::cc) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Fri,
 8 Aug 2025 06:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:51 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:48 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v8 14/14] drm/amdgpu: validate userq va for GEM unmap
Date: Fri, 8 Aug 2025 14:29:10 +0800
Message-ID: <20250808062910.1613453-14-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: cd92c8b7-25b8-497d-a633-08ddd644fb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlZRM3BmZ1FRS2NLRHFQbStNRHBRVWErbzIxbE1VQjBpVWV6MmhSS2dKbkhG?=
 =?utf-8?B?bFo5NXNGaWxMYVhpa0dzM0JCclY3ZlR4cXBBL1VuNTZLbGJlNWZVeTh1MEli?=
 =?utf-8?B?WmxBOFBlMW5VSHFzOFFjUndwVWZrUWU1R3MrcXpCSjNOYUg0c1o5Nmc0aDBa?=
 =?utf-8?B?UW1sczlNQjhvMlhGcGZ1ZVhmYmJSdTVtVkNFdHNTNlYrNml0NytCaTBZaUx0?=
 =?utf-8?B?QWFtZ1FIZWpyWDZXZG5jY005bHdmMi9YZFEvcVVaQjNnbEE0UWhMMTZyNy9w?=
 =?utf-8?B?Z0ZaVFIwNTU4a1dHVkxlYjgrWmFTVEJTVWpvdmF2clVsQWFzK2E5Y1FmWk1I?=
 =?utf-8?B?Sjc1b3luQ2N0WVFCZ0xNY3gxMU9HeGd0ZUlFRTFhK2NNUnBKUUt4QUNPRkJi?=
 =?utf-8?B?TEE5RkJTNlR5bXRnWWNMVnVDT3l1WG0vbXRkQVhRZTQzcThOSEVXNzJXaWV1?=
 =?utf-8?B?cU9jdTBZSUZ0cDJVVlRhTzBmODVBMmVlSktoSS9HSDBkYWtsNm5QczA5dHB5?=
 =?utf-8?B?UDdPL1VtM3lJYWZlN1VIWGNnR2lNZkFDT2xXRTBqTURQZ3RVZTd0dnhBeXdV?=
 =?utf-8?B?czBQRFZvN0JoRXpkdVhtMlVkYzVDMGo1cFJwQTRWSG1PS1IxUzhDR1dxL1Vr?=
 =?utf-8?B?MnJsZDlkbDRlOVVieUZDb3l6Sko3alVuYlhOT3IwZVI1WnJtRlFIcFVUbG03?=
 =?utf-8?B?U1ZzeW9VRzFZOWQ5bWxIRlUvQ0ZiMjZlOXhNVy92R1laeGRNUnpyaFNpK1Zi?=
 =?utf-8?B?VitxUWwxNG1ZR3BldEdjTFFMT1grQ3JWcDB6S2FIckZuS0gxOC91NmpvWWRT?=
 =?utf-8?B?bHp4dGJwVXMwK1ZlVTZJcm9rbGNkckE4UE14cXA4Rlg2bTFzbzFtdk5oeG1O?=
 =?utf-8?B?eUxOeHo0NTVaYldGRmZNck9wSkYrcXg0NzBZTWN4L0xHamxqeE9ybWlEZUQ0?=
 =?utf-8?B?NXh3dzJqUUF6N1FBWEMvNXpnTy9TT1lzd1BMaFlPcmNQMjNOUmZNc1hQY3U3?=
 =?utf-8?B?c1dIVzF6OGNSQUZkMUpxZm00UzhTMDREUTZjY0tZRGxtU0Y2eUlVbFc4WTl6?=
 =?utf-8?B?cytERVlHYW0zTHltRldZdWZNc0haWWxtdWcxUXhjM2RRL0VqKzBMMTJQclJI?=
 =?utf-8?B?NE90UzI5MWxvRDVXamRxbEZTOEdDZWRjUFBqZVRYc2o3Q2hDWjFGT0FTZ3Ax?=
 =?utf-8?B?TTJlTUJWQWVkeTZQUUJQWGNEVFBLb2hFY1FGeDlja2V4ZFVRZXZOUDM5MEZn?=
 =?utf-8?B?M2N3dkZuRzhJUU1idXB3R29ObVVtcVBrZVlVZ09sNExZVnZ2YU9OdlEzNGM2?=
 =?utf-8?B?ZUtvT1E5ZDVZRDBzcVVlMExacVFNS3R5THJwejVOQWFkT3RndDhZRTZtWExX?=
 =?utf-8?B?RCs3Z3lSNG1GYkVrMmFzblpDd01aS2VnUTJOV3hSb29rSm12cmlsU1A5SVBB?=
 =?utf-8?B?ZUVqT3kzSnVzajVKd1pETFJKMFppLzl6Y1RFNC9KNjJhZnhITHhIR0VnMzJq?=
 =?utf-8?B?aXVzbEdXL0NsSFF1b2RMNmowT0VFWXRZNHdCZkRaR24vUkpUcHc4VWplK0dY?=
 =?utf-8?B?SVY5L3lIdFpoKyt0YXZmeCtNTUR0OEhleFRuR2N3b0Q1MG43YWV0YTlaT1pN?=
 =?utf-8?B?MVBaRWh3Si8zWkF1Wm1Hc0JKNUlvM1Q2dExtVkJHVUtvWVA3MW1LclU1SmZR?=
 =?utf-8?B?RGE5eG15NlNuR2VZdHdPMnh3a3pVQm5sWTY4blhydDNJamxva2dPY3owK3VB?=
 =?utf-8?B?TXRheFI5OE13TFpldU9nMFB0VjZkLzdxb1ZHRDJCY0hoVkRYOEF0VW9tZkxj?=
 =?utf-8?B?Z3lxTm5CemZRRk5uL05nV0hTaVpucFFvVzBMNGdOcGM3MWNROG54RndDbnZt?=
 =?utf-8?B?VUZzOUY0anFmY09xem9Qa0tSQVRUUDhDTTBQTENWNVpCb1NuajZJVGdDZS9J?=
 =?utf-8?B?MzFWL3BIelFkdndkR3g1SWlaRUduRklZNDF0ODhXQnMvcUFNb0hVRGtkVzJC?=
 =?utf-8?B?YUpjZ3NNU1l4bHZQaE9aOXJ0OVV3VlYrQnN6eTdIUi91TlpnVDFFQStFZUZx?=
 =?utf-8?Q?EcG5um?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:51.3823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd92c8b7-25b8-497d-a633-08ddd644fb16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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

This change validates the userq to see whether can be
unmapped prior to the userq VA GEM unmap. The solution
is based on the following idea:
1) Find out the GEM unmap VA belonds to which userq,
2) Check the userq fence fence whether is signaled,
3) If the userq attached fences signal failed, then
   mark it as illegal VA opt and give a warning message
   for this illegal userspace request.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 107 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  10 ++
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 771f57d09060..314d482849c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -676,7 +676,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		}
 	}
 
-
 	args->out.queue_id = qid;
 
 unlock:
@@ -1214,3 +1213,109 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+/**
+ * amdgpu_userq_gem_va_unmap_queue_retrieve - find out userq by gem unmap va
+ * @queue: destinated userq for finding out from unmap va
+ * @va: the GEM unmap virtual address already aligned in mapping range
+ * Find out the corresponding userq by comparing
+ * the GEM unmap VA with userq VAs.
+ */
+static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_usermode_queue *queue,
+                                                       uint64_t va)
+{
+	va = va << AMDGPU_GPU_PAGE_SHIFT | AMDGPU_GMC_HOLE_END;
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		if (queue->queue_va == va ||
+		    queue->wptr_va  == va ||
+		    queue->rptr_va  == va ||
+		    queue->shadow_va == va ||
+		    queue->csa_va  == va)
+			return true;
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		if (queue->queue_va == va ||
+		    queue->wptr_va == va ||
+		    queue->rptr_va  == va ||
+		    queue->eop_va  == va)
+			return true;
+		break;
+	case AMDGPU_HW_IP_DMA:
+		if (queue->queue_va == va ||
+		    queue->wptr_va == va ||
+		    queue->rptr_va == va ||
+		    queue->csa_va == va)
+			return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				uint64_t va)
+{
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret;
+
+	if (!ip_mask)
+		return 0;
+
+	/**
+	 * validate the unmap va sequence:
+	 * 1) Find out the GEM unmap VA belonds to which userq,
+	 * 2) Check the userq fence whether is signaled,
+	 * 3) If the userq attached fences signal failed, then
+	 *    mark as invalid va opt and give a warning message
+	 *    for this illegal userspace request.
+	 */
+
+	if (mutex_trylock(&adev->userq_mutex)) {
+		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+
+			if (!mutex_trylock(&uqm->userq_mutex))
+				continue;
+
+			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+
+				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
+					dev_dbg(uqm->adev->dev, "va: 0x%llx not belond to queue id: %d\n",
+						va, queue_id);
+					continue;
+				}
+
+				if (queue->last_fence && !dma_fence_is_signaled(queue->last_fence)) {
+					drm_file_err(uqm->file, "an illegal VA unmap for the userq\n");
+					queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+					ret = -ETIMEDOUT;
+					goto err;
+				}
+				/*
+				 * At here still can't suspend the userq since here just one kind of
+				 * VA unmapped, and some other VAs of userq may still be mapped. After
+				 * this point this VA mapping will be deteled and the VA will be unmapped
+				 * so will not resume the userq when its VA unmapped.
+				 */
+			}
+			mutex_unlock(&uqm->userq_mutex);
+		}
+	} else {
+			/* Maybe we need a try lock again before return*/
+			return -EBUSY;
+	}
+
+	mutex_unlock(&adev->userq_mutex);
+	return 0;
+err:
+	mutex_unlock(&uqm->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index cf35b6140a3d..27ab8a6a7be6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -149,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				uint64_t va);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..533954c0d234 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1949,6 +1950,15 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+
+	r = amdgpu_userq_gem_va_unmap_validate(adev, saddr);
+	if (unlikely(r && r != -EBUSY))
+		dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

