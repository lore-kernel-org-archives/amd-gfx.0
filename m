Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65EEC8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD3D10E9FF;
	Fri, 11 Jul 2025 09:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IPEyJpRy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5428510EA01
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6VlZivNGcgWHF2acqjp6UYdJMnqhdkCuRsW1niFpsARVXN+uWOF3ja2iXArtw7/mQaVa1fzLeUrZZ3B8yF7bISJbZMUJtbmiP53+bvclIghXHQbWlvTqK+bQlmOy5+XhoRDRoPGw4rLbc/CQW4s8IclJKfuy2s62ntnVixskLvAav2P+AVO6UKCmJkkx4wzQMIXOPuRe7NBW7bYZoFOhylWUgqOga4TprTgSFyfmaY22W0miMJjSENavo9Owq/uReceC72tBC2vPuDBelwldQeXrTFeFgzaNHEHBttnP/R5bmpA6bNjdTBVYwxzAfnPo07jmyPC1fn7z2RpIrGt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/cjazp9j7bKWSwW2RiXcQ0tLMBi95CanERIE0KNQrI=;
 b=lTDqC+x4fOz5aPyJQrrvEmrk7xldohvAxmzF/A1f0WBFpTypWonKQTbDYvyDDY1QJn1I4Bx7PmHrYlFQzK15UqbaLX2E2VlQtG8q06ItxxIRajnX3sHCrHed58HpRs///hm+59dihGH9d/juiowLtNY/6TR7F8VJacP48pO4NpPJSafRxXPq5XLnHLCaFrZFFbCTvx5gy4eMJs0HncdYYXhpjDaLgJP2WLE9fk6U/4zNbu3B+iicyZVwymra0kt2qQv3t768buiaQA0R43Fq+Ba7GEXiPpXDy1R3J5quZhxPddktH3kLn+jB/CZX3UBvWrq05vnDKkyZWvgmVZOv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/cjazp9j7bKWSwW2RiXcQ0tLMBi95CanERIE0KNQrI=;
 b=IPEyJpRyKyy4j5O0N8bajLeds+6F2uwRjnp90TsXgXCn/8E4LcMU5rTApOCYKMsXk2epiXZaEPDt2xcl1ugW5Uc0nCOqniq1GGA6ZJDSQZvub3IxJetaf0tZOEEDCqXD3ZfpmG3QRMGjG8Ddm4Ydxm21CwYIA25urop5x1i4k5I=
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 09:39:59 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::5c) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:58 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:56 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v6 11/11] drm/amdgpu: validate userq va for GEM unmap
Date: Fri, 11 Jul 2025 17:39:30 +0800
Message-ID: <20250711093930.1411470-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: ef224db5-0919-4604-4a2e-08ddc05ee6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXdWKzZ2MDJOSU9icU01S2FrSjc5bytPTXFWTXgyazVQZmZFcEtOSWxWUTQ2?=
 =?utf-8?B?dXN2bnRJcHFzcFZNNHZ1Qm1TK0RIdmVPNXRETW91ZXg3bEVqaWlRTXRWeDhJ?=
 =?utf-8?B?bVBvdjdBeTFkVG5JK1luVmZiVFZ2ZTdFY3JjdFNRTzhrbXRJQXQ0RWU3OHdm?=
 =?utf-8?B?clVFVWFsZE9Odk1LckpMcVJLZ0hEUTBNSStlOGdmaXUrRURFWWJtRXhOZkR3?=
 =?utf-8?B?eTFDa3ZCM0ZySmZHS1VPalA1TDRmbVFLR3M3NnY5RmpnemIwWENVTlo4Qzhh?=
 =?utf-8?B?ZGFCNC9VYmY2cXAwZEJkSCtzdmk2cE9vSi9mMk5saEk1WlVWYnBDalZLaWgv?=
 =?utf-8?B?K0NQTVBUMTdTZmtzbVlVRmhxcGs5bjhDeHB3UVUwSitSVFRTTUk5TnU5S2Vt?=
 =?utf-8?B?dFJ3Vld2ZGRVK09ySHcxTjFnenNTT1RFTk4wTlhZZDlGMVdjQ3VHbVdBdW4z?=
 =?utf-8?B?dUplUVo3cmNXNTBjektod2FwUGR4QWdlNm1qZ1ljWFRRajVsZTBlVkdEdzEr?=
 =?utf-8?B?YmM2eThoQTloUHg0U0x0TUVuQUhPZ1JwNkpSK0c3c2RYWUpRMzVYNnI5dldQ?=
 =?utf-8?B?UUtxek5kSjhYdUpCVlFQUWdiTHN5Qm51bGpXdGtxOU9FTGx0NkI2c25ORVRR?=
 =?utf-8?B?MGVvcTdLb3JVOERtdnBrT1lYdzVBb3pBYUNNaSs5MlJsTmlUSjhJdUZyTElp?=
 =?utf-8?B?b3JzbzFRbU80TjJ4bnFOWWdxOXpNQzJqU05CMkxFcmVDQ1lUQUVvMDN3SXFq?=
 =?utf-8?B?T2g4dEZja2xyN2Ntc1VUQ2k2MDljRVBDaUNtaXp1cHVYbFZjWmxVMitLdXVO?=
 =?utf-8?B?cEM5a0VKUjF4NzFrclVuREFQVHVFTTJhUzMrS3FzZERUb0IxU0JaK29FUDVl?=
 =?utf-8?B?dEtwcTdzTEhTNjJaMHljdUZjRmx4Wmd5czhtK1hTWmY4blZQTnliRlhJTVpC?=
 =?utf-8?B?R2ZGdkxLRWxybHozVzlpakw0aFJ6T0daTUZRREo1TFliRTBoa1liak8xa0hI?=
 =?utf-8?B?YSt4dEJjUXp5alFUYm9WQlAzRnNkQnNSZzNyNi9GQ1BVTXgybHN2M1c4SG1G?=
 =?utf-8?B?RUtFRzVHNVBFSXJmUzNRTWdaTENEODlPUnpQWHcyL0lRdDl4WTg2SFUydC8z?=
 =?utf-8?B?cGI0dzY5V1NQK21CK2hiV0N5VHRGTlhCOW1nTnZFdlBqU0JKaDlxMVBGaWZx?=
 =?utf-8?B?ZnRBd3RlMGRDaE5xcDd3NGRjdlU3bjdReVNjN3VkdDJDNmVJcE9jak5QL1VK?=
 =?utf-8?B?V1pRUlJJeUJQVDExV3l3Ti82aFpTUENXZmlSWUU4bkNpS3lVK1A1alhreHRY?=
 =?utf-8?B?VHdGM09MTVdJMWdSNVNUS1RjeTQ2MlVMSDhqcUthZk02UEN5TTNFU1BjVHBS?=
 =?utf-8?B?bDlsb1UxbXF2c1orRm9sbCtFYUJaZUdidmpuTG1oS1Jhbk9XM2ZCemdzd2ov?=
 =?utf-8?B?VS9TUTBSY0toZzdYZStZQjhkS1huME9KdG9ETVFROTdYWTJnZUIya0lUdlV3?=
 =?utf-8?B?cC81ajZiV01XRHlRclVjR2REM1J2c1lBYjNJbSs5cHN6S2pEajhBNXpPU093?=
 =?utf-8?B?WmNiQ3N3aEtDSWFJTXZUNmVKZmMrcVhwQkxSMWR1VzNxaUs4QVQvUmxLQ25o?=
 =?utf-8?B?eldDWFZSSnVocGJHRUZpRDg4TU5QNmlyOVQ5aDZteWtSUDFnaFR5ejA3TlNL?=
 =?utf-8?B?c0RtNmtqVnRiOTRqTEVvdVp5UGhZNGdXNWxRa1UvZHlNWThyYVB1RlUzME93?=
 =?utf-8?B?WjFyU040bGhSdld4bWdOV3Iyd1BSQnBTa2xmbDBXVDlCbTc4dCs5bEtrR0cx?=
 =?utf-8?B?WWVwUld2QzhyYlRiVXNlNUVOWDVWYy82dzcvbUhLQXdTckJ0ZzNFSGZkWmhG?=
 =?utf-8?B?bVdoY1hGZlg5VkZieDMyc1FncmZmay9Id0FUR1Y1L25RNEkzZllraGZ0azhp?=
 =?utf-8?B?QW4vUFhIS0VyWVZoUTZkWUVhRy9NcjRRTDJ5aW9MeUdpUDJZQjJCTWsxYjdI?=
 =?utf-8?B?ekRlRDQ4dDFwcFRVU09PdFlac2g4VU9uK29lN2gzRU5BREF4cEZsU2sxRnFM?=
 =?utf-8?Q?C16pbv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:58.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef224db5-0919-4604-4a2e-08ddc05ee6f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 119 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  10 ++
 3 files changed, 131 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 54f44fc834fe..491a65e746b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1175,3 +1175,122 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
+				if (amdgpu_userq_wait_for_last_fence(uqm, queue)) {
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
index ca6ede32b260..2aad5317b678 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -146,4 +146,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				uint64_t va);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a574effdd3ec..a34b96f2cedb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1946,6 +1946,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1966,6 +1967,15 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
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

