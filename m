Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFE8C48BF8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 10:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5D210E883;
	Thu, 22 Feb 2024 10:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ansiq7ZT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE51010E883
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 10:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg6f+t5ewCJVdlX8GQZilCsOsqN6f0YK7SJHL/DxphnqkDrZis1iuhaChKSwa8EZYJwS4DxMIFWgc7DOEsvN5dFB+riy/W6LTaxciwbNI+9BMXMmHsQ4XW/3toFpw4kbTCoSqwBkhbuSmd+Dvd3XPotrvyHfJ8JIElipl3x081yxptwDZFcVybcnFvnbWxds4VfCMMqyc9ZcEDmIwZres0xBdFqnM0J+wwHlvqUa3sgxuTwtqa+RI/tUUWtmcOB4YzZGNmRNfE3hpXmpouP5r4Nczy5402kksQmDM0R06KGi8cXHmHJrvuXOvdNmuGs15oEOo5QehN77t88XbM+L2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsbiizcILMVFgCToT5kJTNX27yN1UWZW6IMBdaWPdYI=;
 b=nMYuAVZakt4XBHigHlBhlAVMLeKUAK/37YoUAzC2vukCds5v4Dxxy8H3WNtWkalNWDIMK8qyb4WgzFKq6yXl/sqffcTRkE1wqaY06pDHCVfq5an06Ta8AVNEx8o5ZH3wchDpUWmr/HXuvgk9Sd7VyOSwl+chK4E702f+SBcHoIRUm6wR7gm/NfRgB+0LaLbpFvSRmLQo55CeFTsKJMuxXpwJYoDr28QQFLI+J+pYX8mm6TXGu0IpNMk+CE4Huz0fEspBdMiCuxNgzCtFA9D5cx7hUN8XgizRDHX6Ww0gNzB8bxdnwlxQo0oBdKUPnsjKsgqTTrSC3akK+zkSv+tPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsbiizcILMVFgCToT5kJTNX27yN1UWZW6IMBdaWPdYI=;
 b=Ansiq7ZTx11zdTkbpHyUmgB7/3K3WtFFSyEJ55m2gPrACxsltRI1hqr8D3aPDX9a2iSLZYl9phBkIn6jo9QD/R2IgVW6wCZGAmw9eJTDQwg3uutLpN22DdRQJgtQTuTCdqajcB1XDh7XUNLyrviKdwVHFw9nb4msBkuUW6rwXEc=
Received: from DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15) by
 CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 10:17:48 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::72) by DM6PR01CA0010.outlook.office365.com
 (2603:10b6:5:296::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42 via Frontend
 Transport; Thu, 22 Feb 2024 10:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 10:17:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 04:17:46 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <mukul.joshi@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/2] drm/amdkfd : Skip packet submission on fatal error
Date: Thu, 22 Feb 2024 15:47:28 +0530
Message-ID: <20240222101728.135595-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222101728.135595-1-lijo.lazar@amd.com>
References: <20240222101728.135595-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 717bba92-e670-46f1-3f9a-08dc338f8518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1g9jnPvSezYrKOO8ZuxGiuP5K4VsTwXatZeh/Kw0Q6sO2KRMcHJ6o4rWlTrDvhvx2YxUNzCCON2TbSmRE6Dtmmgpmt9mSS5/LrHhk5WHYu9uyKYzPaKtpWbKt1thYwy0BM+Wj2snV3UI+gBhKUtc3omQAOJbaoOHppzJm9bRKuSzDWpLj6UO+IGdDyrMsTphj9QnDUzZwEfLKW+3nShJNNvzOjb3dfllHkEvx2x7oiHKh4+D/8xBQ0DvWd/2x31a8TnAjjqYSZv7lZeadN/p+3WMScN0xpcSeOSfK5tSVckddEfRLKyLULuGTo77P9GKBoAI1clu+f++1tmHf8hFyTmbN1p02Wek+YiIlJrIOyeuZhDzV7mpydIqTj8fCx1f4aV44BbhqKSHsGnffFcp+Dt8Lqkzzfmg9SayFlKpYT+xz92aIsJeu3DJ3XlOobhd/ZxDJUFZtWLodb6oTJph46XVs9NtrevMYps6CLdK5XYgDuSL2oltb2EMy2l/6Ia1qldU1ZEjyNm46VekLXf45/xnhKsdZzJjczZX06bnnb7JyahswqV1DqrIZGjqAwxeUvtOtSIpCHvGP6TfeMspLUc+v9Ymksvwf/NeURF0m3sNCC8ilgi5Af4kJJe/4xfOhNMyKfT8+OG8dWo/vzY006ZmYbcWuvLIhRPJsoUGTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 10:17:48.5129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717bba92-e670-46f1-3f9a-08dc338f8518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

If fatal error is detected, packet submission won't go through. Return
error in such cases. Also, avoid waiting for fence when fatal error is
detected.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c            |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h            |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c         |  8 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       | 10 +++++-----
 6 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 190039f14c30..f5f2945711be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -742,6 +742,11 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev)
 	amdgpu_device_flush_hdp(adev, NULL);
 }
 
+bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)
+{
+	return amdgpu_ras_get_fed_status(adev);
+}
+
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 	enum amdgpu_ras_block block, bool reset)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e60f63ccf79a..4fb32d86cd0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -337,6 +337,7 @@ int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 			enum amdgpu_ras_block block, bool reset);
+bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c0e71543389a..f4d395e38683 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1903,6 +1903,10 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
 	uint64_t *fence_addr =  dqm->fence_addr;
 
 	while (*fence_addr != fence_value) {
+		/* Fatal err detected, this response won't come */
+		if (amdgpu_amdkfd_is_fed(dqm->dev->adev))
+			return -EIO;
+
 		if (time_after(jiffies, end_jiffies)) {
 			dev_err(dev, "qcm fence wait loop timeout expired\n");
 			/* In HWS case, this is used to halt the driver thread
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 1bea629c49ca..32c926986dbb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -286,7 +286,7 @@ int kq_acquire_packet_buffer(struct kernel_queue *kq,
 	return -ENOMEM;
 }
 
-void kq_submit_packet(struct kernel_queue *kq)
+int kq_submit_packet(struct kernel_queue *kq)
 {
 #ifdef DEBUG
 	int i;
@@ -298,6 +298,10 @@ void kq_submit_packet(struct kernel_queue *kq)
 	}
 	pr_debug("\n");
 #endif
+	/* Fatal err detected, packet submission won't go through */
+	if (amdgpu_amdkfd_is_fed(kq->dev->adev))
+		return -EIO;
+
 	if (kq->dev->kfd->device_info.doorbell_size == 8) {
 		*kq->wptr64_kernel = kq->pending_wptr64;
 		write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
@@ -307,6 +311,8 @@ void kq_submit_packet(struct kernel_queue *kq)
 		write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
 					kq->pending_wptr);
 	}
+
+	return 0;
 }
 
 void kq_rollback_packet(struct kernel_queue *kq)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
index 9a6244430845..e24ee50acdf0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
@@ -47,7 +47,7 @@
 int kq_acquire_packet_buffer(struct kernel_queue *kq,
 				size_t packet_size_in_dwords,
 				unsigned int **buffer_ptr);
-void kq_submit_packet(struct kernel_queue *kq);
+int kq_submit_packet(struct kernel_queue *kq);
 void kq_rollback_packet(struct kernel_queue *kq);
 
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 401096c103b2..d6f65f39072b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -288,7 +288,7 @@ int pm_send_set_resources(struct packet_manager *pm,
 
 	retval = pm->pmf->set_resources(pm, buffer, res);
 	if (!retval)
-		kq_submit_packet(pm->priv_queue);
+		retval = kq_submit_packet(pm->priv_queue);
 	else
 		kq_rollback_packet(pm->priv_queue);
 
@@ -325,7 +325,7 @@ int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues)
 	if (retval)
 		goto fail_create_runlist;
 
-	kq_submit_packet(pm->priv_queue);
+	retval = kq_submit_packet(pm->priv_queue);
 
 	mutex_unlock(&pm->lock);
 
@@ -361,7 +361,7 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 
 	retval = pm->pmf->query_status(pm, buffer, fence_address, fence_value);
 	if (!retval)
-		kq_submit_packet(pm->priv_queue);
+		retval = kq_submit_packet(pm->priv_queue);
 	else
 		kq_rollback_packet(pm->priv_queue);
 
@@ -392,7 +392,7 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 
 		retval = pm->pmf->set_grace_period(pm, buffer, grace_period);
 		if (!retval)
-			kq_submit_packet(pm->priv_queue);
+			retval = kq_submit_packet(pm->priv_queue);
 		else
 			kq_rollback_packet(pm->priv_queue);
 	}
@@ -421,7 +421,7 @@ int pm_send_unmap_queue(struct packet_manager *pm,
 
 	retval = pm->pmf->unmap_queues(pm, buffer, filter, filter_param, reset);
 	if (!retval)
-		kq_submit_packet(pm->priv_queue);
+		retval = kq_submit_packet(pm->priv_queue);
 	else
 		kq_rollback_packet(pm->priv_queue);
 
-- 
2.25.1

