Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE57C83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A49110E618;
	Tue, 22 Jul 2025 07:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XwPZImL1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0067310E616
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFjHCdfxxvNI9OI+vGuA5yybrWS8rEoKYHb9aP/a/coTGpgv+N2NG12LfbCcTFpmY0b3qdWExBT3UVQUpNIUp7GCHQAES+GHIWl4iKhfuudsRslaqjgMxS621M4H49s8YLHIhJNirJEFGYYWQb05zWMQZrlc+jm5piGoZ+hK036b3SX9jAbdKMWfpco7lz0A2TGIJN/B+T1FMmEKNl9Zip5gZ7c4Qp4dBuGn9A0vQEH7ttHhLFtLeKSMauusxuILizBizzxNM5Nsu4mRNNeh9AJW8eCzr9QwhI4HpVu6c2xGMa4x18T6Y5rKubQJrTIeDUywRGz/iUoOlNl6mHrS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/aTYEPz5EOnvOgdLqj9WCtu4E3XME95MFIrLMIiHTg=;
 b=lNQbpPc3Lhc3GzrTWfvf8AQYZoF0xog2umvjKY95rr6Tmr8Cij1u1fV28rkGEN7n5x4LjS5AjFsCXawgnMrjJci3YETWxnq0/quDI3WHhTba4WXKkhfyM5RbyNQRAo4TufHHXd+mY3Uztgv4DmgJbMJfiYAC6QWaIovw5IQbxPNRcZYQaAO/iSwsLzIkmrkshPfVvYY3KTsyv8mOFd52BgrbwJWRlT2Lf19/UykzMYa+Kcztufz/cHSJySUkh6XCLD9QTATmzFHR9S5YqrRrbk7IHhvQLT3TJsIF5u6/teIINxJPqFwpnej3vOa1VkDInfrZGoVlHJaPO5ms/MPjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/aTYEPz5EOnvOgdLqj9WCtu4E3XME95MFIrLMIiHTg=;
 b=XwPZImL1C9eK6nyAjH1qTMymaFtKfkgikXMuxtlkgS/YchezfHFl/TbT+JnLzzaBOiOFHLyspk1ASUKJXBDP3AcgoaIibDpJthU3rEa39EbaUFDlxkC1VyTgPWx6lMYM2HOPHCX1A1ehv32NovksCS9BEanN4GmuhwWzeojcflI=
Received: from MN2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:208:23b::20)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 07:47:02 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::b1) by MN2PR11CA0015.outlook.office365.com
 (2603:10b6:208:23b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:47:01 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:58 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v7 14/14] drm/amdgpu: validate userq va for GEM unmap
Date: Tue, 22 Jul 2025 15:46:23 +0800
Message-ID: <20250722074623.1464666-14-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 17728342-a5a0-467b-b813-08ddc8f3f1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1VpU2hXd1pvdCtmdUh2b3d0eTZWUG9VcnFFZ3ZpZUI5MHI4TzlFdVJrVGl2?=
 =?utf-8?B?TUErQnBydk1uaGJKek5TK245eXdSWDcxT3FpVFYzNTNZOFhFUmhib3F4dHk5?=
 =?utf-8?B?ckRpd0o0elBQK25rZ2JCcy9CK1pQbEExdjM3OFR0Mjh6YXpuVDBZbEdYUlQ0?=
 =?utf-8?B?QXo5VnlWTUFGMm9hcE9lM1BzWTZsUmhMS0M3YXdKM0V6aFQ1cFd6dkoydlVN?=
 =?utf-8?B?cjE2WWNxdzNmMjlNYzRuelU1NWs3M0NiV1NjWEozWitvWUUyVTc4UEhBOUVZ?=
 =?utf-8?B?VDV3RHBYRzIrTFhseG8yeS9SaDhoOTBmbGtQRktuK3lYZGoyRWV4VVc1QVVr?=
 =?utf-8?B?aFp0WXlCdzNSMytoLytsZjJSTzE4RkpMTTBRZDV2U0U3dWx5blBFVGlYYXB2?=
 =?utf-8?B?bDE0NUxQSHAvTHdKZUZtYW1qSEFJR2M4YkcrTFcvaTYzYUFBWEttWGo1MHBU?=
 =?utf-8?B?UmM0ZGJBckhCVVU5eStTY2FGZmF3WERKaWROZnpUenZVbHlwS1M3RUNYazF1?=
 =?utf-8?B?T1NoZDdFa2dDUm4xd01sQnRRY3phd0lTUzFKYXh4UGh4TWVtZEk4WVlVYVVx?=
 =?utf-8?B?eGZpRXEwRkhUZHI4Q3ExbjRYeXk2ZktYaGJ4LzBwTWNoVWk5Q3VKM3NMZmxH?=
 =?utf-8?B?WE9jVWM1ZTEzVWY0clBjT3JKQjgzSmpBbUIyQmdJMmNHK21QckEwZDhPYWVY?=
 =?utf-8?B?MFVlTmc2NHFGSkk4VUo4TmVISXJIcXV4QVJjQmtGL24xNTdKR3VBTEd4UkRG?=
 =?utf-8?B?WFQ5b0o0Ym9EYzhGNlRhN01LWU9SMHU2WGhZNEdUMUZkbDBGaDRtZWlvK01j?=
 =?utf-8?B?d0xOejZFbHcxQ1hLSGNQZUR0clFLV1RnMkJra2RkNFlQcEhEYTF0QlB1Zmow?=
 =?utf-8?B?T0E3K2lwSjBkcWZPcFpsZ2ZHQUNVR1hNbGhxbW1qK2ZJYjlTdUlUZTQvQlhO?=
 =?utf-8?B?NWRQMDFMOHhRY1BkQnR6ZzJrS1FIT094RU5UTnZ3RVhzM3pudWQ1Qks3czdy?=
 =?utf-8?B?RkhXeDcwSHdleGh4Mnlhcmdxd21qOHp3eVRPakxYYytVaFpIcE1ubmlxOUtS?=
 =?utf-8?B?ZTB4MFozaFFnamtnMVplNDNxMlIyczY3NXEveDdlWFF5K0VTMXhyNEJXMm9j?=
 =?utf-8?B?MDlPMmJVSDFRUEFWQWdXazNZWkNlRStMOVU3dkdEWnFaTDd3L1ZwaUtCL25E?=
 =?utf-8?B?YnVtVlFoSmtvNVhiZDUzNDlWeURBOWE0WnlRdlNIalpCdTN4Um5kRUJMZGRs?=
 =?utf-8?B?ZlZUTjFvTFNUbGpBWVVrYjZoUk1XRk5oeXhXblFzeUkzako4U3RKK2k2VG84?=
 =?utf-8?B?Nno3cWRIVlljUGJQZzQwbm1hTWZnQnNZemI0UFppS2M4Q0U3UlV5VjM4MFcv?=
 =?utf-8?B?Z3RueTNwTW1wOW1rZk5zelM3eUVyaHZ6aURtLzVOUTRvUVVMMnkrakNaVUh0?=
 =?utf-8?B?c015dWJvdnk4MXhtVjk3aWl5UHlDS3FyakptOEt5MEwzSHR0ckkrcURkTzly?=
 =?utf-8?B?OU9KWExyYjBkTk1GZFpiMEI4QmkzK2ovcXJ6NWphNXhiVmRIUWR0TDRzbUh3?=
 =?utf-8?B?YStYZjA3NklPVW1Ca1VVbXJJcG1ibUpMclljdjdXVU1NLzgzeUZZQ3pIaEtp?=
 =?utf-8?B?MVJMK2d0cFRHZTIwbWY2MkNWaktNZXh1amNjTnNGU2sydDFHek0zQXZnOWZ4?=
 =?utf-8?B?Z3BSYXFNTDNvaW03YnE2MDl3ajNuY09RaFpTVUhNdDI4YnRyOEtvbzdremFv?=
 =?utf-8?B?VDdMKy9UTERJVWdFTVdvTFB5a1Q0TTF3S1FJcWtpdjNPdzc2WUorUDFKZW5S?=
 =?utf-8?B?dGZOQmVPMHNJQkd2SlozRWR3UVl6UFBPZWdxT3REdjVzTWFqUzgwYU1FdGRr?=
 =?utf-8?B?OHZuOUdocUVRS0FzTGlzOUo5dFIveWNkdmNtOHN0c2JHS1lSV2JkMnRPcmRJ?=
 =?utf-8?B?cENDdFNOQVZ5WGZ4QndkSlcvK3UrMFMxeHBZUUw5QS9KVHdhL3h6RWF3amJ0?=
 =?utf-8?B?bXdpblYrZVh3Z1UwNU0zVnVNVGZnVktkc1VxL3lzQ2k5NXNDdjNPYWdNWXZN?=
 =?utf-8?Q?xOFQKK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:47:01.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17728342-a5a0-467b-b813-08ddc8f3f1fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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
2) Wait the userq fence and eviction fence signal,
3) If attached fence signal, then suspend the userq
   to avoid reusing by userspace,
4) If the userq attached fences signal failed, then
   return an error code and give a warning message
   for this illegal userspace request.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 121 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  10 ++
 3 files changed, 133 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 77a2f12c8dcc..a2c3caf382fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1212,3 +1212,124 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
+	 * 2) Wait the userq fence and eviction fence signal,
+	 * 3) If attached fence signal, then suspend the userq
+	 *    to avoid reusing by userspace,
+	 * 4) If the userq attached fences signal failed, then
+	 *    return an error code and give a warning message
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
+				struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uqm);
+				struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+				struct amdgpu_eviction_fence *ev_fence;
+
+				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
+					dev_dbg(uqm->adev->dev, "va: 0x%llx not belond to queue id: %d\n",
+						va, queue_id);
+					continue;
+				}
+
+				queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+
+				if (amdgpu_userq_wait_for_last_fence(uqm, queue) == -ETIMEDOUT) {
+					drm_file_err(uqm->file, "userq fence signaled failed during unmapping its va\n");
+					ret = -ETIMEDOUT;
+					goto err;
+				}
+
+				spin_lock(&evf_mgr->ev_fence_lock);
+				ev_fence = evf_mgr->ev_fence;
+				spin_unlock(&evf_mgr->ev_fence_lock);
+				if (ev_fence && !dma_fence_is_signaled(&ev_fence->base)) {
+					ret = dma_fence_wait_timeout(&ev_fence->base, true, msecs_to_jiffies(100));
+					if (ret <= 0) {
+						dev_dbg(uqm->adev->dev, "the userq eviction fence signaled\t"
+								"failed during unmapping its va\n");
+						ret = -EBUSY;
+						goto err;
+					}
+				}
+				/* Here needs to deactivate and prevent reusing it*/
+				amdgpu_userq_unmap_helper(uqm, queue);
+			}
+			mutex_unlock(&uqm->userq_mutex);
+		}
+	} else {
+			/* do we need a try lock again before return*/
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

