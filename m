Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D72C44507
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 02:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED87D10E28B;
	Thu, 16 Jul 2026 02:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3XogPT84";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34C010E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 02:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ82LdSmUeBjAnBrGi/EMv6LSlA1s6MNzuLbjY7dHRD+L2qalK5+rFQ63C6RUtqFpMBv9PxGSkQY0xjpS2cp8jEHupUF9Dcpp28wAtMNKx7l8TGjqpkLBvKyiRdlfw2r0AzRjM/ZIohYgSzK6UIbPBGwljjHm2+lf7fMqQMA1UY3fipcZfUWUsxz/HbDKb00ue+1xm1vkrr7udzRgv9zs1fN9TrEbFM7pI+nZ997kYFvGqBqU3IamnVv1hGyeA9dP75Qxsubj35EnW58J4VouU0symZV37bfis5GVUQj0L9T5QGSAcIwUwMumh+epKIvCJ/t8XW0lzMx+4bNXcw0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PItCHXVCaKrrPUwo7Ry3yHMBSyJ6TBZEpxzGmPy7b/s=;
 b=hBohYnktUGTU8gAvx7YId09x/GiJ7Ig5HmUZh2lT1k9yP7MLbDu2I8xZXTXi4EyklSaki21/WEhwslKgZdn+i7IJqsVb4QlqWwsghNCkCO9FC2RJwpeWZBGRUmCOYvsLr9eKIfLK13+cF+xvdFpWIsDe3oRe3R0vMApotl6CiAzJl3YXZAGoLDfKQpho40U9RlBfh3gGqMYvmeyOtBoZxto6FfNDhC12Spd7VbicACy2xxCAM0SKUq5QsMmIxdwT31FSbJUSdJXPvLRCREVui6wwL9G1mRnE2LfVaDoyIxtqwHqtzYjckM9I+O25vYUQaVy6Y021gGAFZD6aOHBeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PItCHXVCaKrrPUwo7Ry3yHMBSyJ6TBZEpxzGmPy7b/s=;
 b=3XogPT84BtDiMw8Gn1cg8GcXWJc0zC59xEGqqVsdkZO5ElCvA7goID+MkBla+duyjBoKOA5iz58cuLTTXSHWFW0cWaKsVUv+6HGW+EOwEKBHZrOFRP2ppTPmE7FngTYWwWYAhpcInJYkenaj7DNbdo26STgMAsBRUdg6uC46+dU=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 02:35:32 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::92) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 02:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 02:35:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 21:35:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 21:35:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: recover gfx user queues on priv-fault
Date: Thu, 16 Jul 2026 10:35:08 +0800
Message-ID: <20260716023527.2073603-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716023527.2073603-1-Jesse.Zhang@amd.com>
References: <20260716023527.2073603-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7871c9-4d47-4b61-ae53-08dee2e2e810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: Kq63q1ZXruLuztfFnuduY4bsa00rMJS7In3g/iCtWHPvuYB/hWd80hgPUZvIj2TQV0dwrnhqvpcs2QsQnvEP15bUTjkznwpEW89WhDO+BbiPD0TWaUWpOa3orn+P/AtKhoYVBVr3j7ldxOECAV5V7JsCpAsz1OZVihjCMkkjblOy6iY0VPSBsYTwvJaz6zwQnvWMr96CE1D5v7J0/SPdVVEJQbFN5md5eJX/6pRQQ5PVIjKYvphU7M+Y1+ugGg3B1yqdfmGvAUIys5tdWLQAnFI/tPtepRaVkaVLdiT6H0w8VmlOI1Ij/2OCY+6H+Q4FSvdrcEufRpUF/gXogOrqJHpC59SyElQtBaUr133LWiqQGjvJiEeVroEfvJWyC7YTv2+lk0sltBIHb1nkCrFBZjYahTTX7z5F1dTBM5Uf6VLxtr8o+r09xIy33M7YR0mjWszEzz3wJAJt0SGzj3gyOsB2avzX/qyo9qasTR/F4tj9/RqsHE4wPA9wgki3EhxRwz70ddt9jgvc0NO0NmtVeykgnQHyZeiZhiabEMP7G5jHPQ++9p3HqziDT7dG3Om/Al/A5laYpbKXtjEbGxZWjSrxemQbBiAtD2ilGnQcwCXyMjbC7GTlsqlYbfHzcGhJfvZOJE0aCxe96QHmIJHpM9KAPNtUGy+Rj0G9+LoYDBUVXtb6HNLFDYQnM3Knm0LqXcb0hqAuoSUtbsRvt9knJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gt85HY9oLKNzNQOwe53Rz/snBKhGgejT5+kGR3EdHDEDCM1IOuOJLUEfLnHV+rGMb9xfi2IhwFEJuuqCeB/vrl01lWymR3Bx4Ik/aa0YI7kq58LpBD343miFkFKD1FOr4gDRGgZ8wnlvIIPRppSgpytJYQh0i9LvpQNs6BjX3YS4h8SDe5HiGNvc/buQJeZ85fln5gh4wo37w4oML474weVkCV+amP3BiO4gvQbqs/eBBuwFbKvRpyDKWJ81CVdR8E8d1a6kgtGWCHlSchm4+UrNbcoKbcWkmn9SCH0XiA2SARYV72eKkkvkQoweM8Xq2bo5w5s51MaV23gYdykeu4evCtr4HqOM53nTXSId3GzXtnOBKPE9fsqz1JQe8TfY/VYP9xslj+WvzdutwKOrWlpSKQacDeA98oHzqTvNAjWU7oR5/pd8NJHJ6L5WsYDN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:35:31.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7871c9-4d47-4b61-ae53-08dee2e2e810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
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

If a priv/bad-op fault does not match a kernel queue slot, it belongs to
a MES-scheduled user queue. Compute IVs carry the doorbell and use the
existing path; gfx IVs do not, so record the faulted slot and let a
worker read the doorbell back from the HQD (regCP_RB_DOORBELL_CONTROL),
look up the user queue and reset it.

Suggested-by: Mario Sopena-Novales <Mario.Novales@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 60 +++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0cbbdc3694f4..a802b0ac1544 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1601,6 +1601,8 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
+static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+
 static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id;
@@ -1931,6 +1933,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
+	INIT_WORK(&adev->gfx.userq_priv_fault_work, gfx_v11_0_userq_priv_fault_work);
+
 	return 0;
 }
 
@@ -1968,6 +1972,8 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->gfx.userq_priv_fault_work);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -6707,10 +6713,47 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * A gfx exception IV carries no doorbell. For each faulted slot, read the
+ * doorbell back from the HQD (left in place by the fatal fault), look up the
+ * user queue and kick its per-queue reset.
+ */
+static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, gfx.userq_priv_fault_work);
+	unsigned long slots = xchg(&adev->gfx.userq_priv_fault_slots, 0);
+	unsigned int id;
+
+	for_each_set_bit(id, &slots, BITS_PER_LONG) {
+		u8 pipe = id & 0x3;
+		u8 queue = (id >> 2) & 0x7;
+		struct amdgpu_usermode_queue *q;
+		u32 db_ctrl, doorbell;
+
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, 0, pipe, queue, 0);
+		db_ctrl = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
+
+		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+		q = xa_load(&adev->userq_doorbell_xa, doorbell);
+		if (q)
+			amdgpu_userq_start_hang_detect_work(q);
+	}
+}
+
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+	u8 me_id = (entry->ring_id & 0x0c) >> 2;
+	u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+	u8 queue_id = (entry->ring_id & 0x70) >> 4;
 
 	/*
 	 * Try KQ first by ring_id (HW slot is authoritative). The
@@ -6718,9 +6761,6 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 	 * never share a HW slot.
 	 */
 	if (!adev->gfx.disable_kq) {
-		u8 me_id = (entry->ring_id & 0x0c) >> 2;
-		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
-		u8 queue_id = (entry->ring_id & 0x70) >> 4;
 		struct amdgpu_ring *ring;
 		int i;
 
@@ -6752,10 +6792,20 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 		}
 	}
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
+	/* No KQ matched: the faulting slot belongs to a user queue. */
+	if (!adev->enable_mes)
+		return;
+
+	if (doorbell_offset) {
 		amdgpu_userq_process_reset_irq(adev, entry->pasid,
 					       doorbell_offset);
+	} else {
+		/* GFX IVs lack the doorbell; record the slot and let the
+		 * worker read it back from the HQD.
+		 */
+		set_bit(pipe_id | (queue_id << 2), &adev->gfx.userq_priv_fault_slots);
+		schedule_work(&adev->gfx.userq_priv_fault_work);
+	}
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

