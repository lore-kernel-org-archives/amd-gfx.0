Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCBBC4452D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 03:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4BF10E3F4;
	Wed, 22 Jul 2026 03:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yU8LiJVv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C5210E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 03:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtKNZL/2zG0gH41ETWcCEMzzwhYB/YsjCVLvKAMjpv+8Vu/oFEV6035i34aptbxBC4BcUMhlni7G4Urr1K8NV0YluSDz8iQ1m7Ri08eL/ctKd2A4fQwQ+c6LqogGZyniXZ8x8oW9fMDlod1SGhg46vVu5qgaP+5bnNIjmcrQus1CHNrqZx6l8r+RXRJWnwz8suSkWQaOqE4Z+7gBSpkiaeKZgcgDY7AZdRb/TBG1HVc4yHAKmvC19PKuhq/6AMyWm87+TCStulNVA5yZOn7ePzw5rl+CKqPmFqzUQDuZd9vYvRHEiYolgue4YLQExMOg/oi6LorjCANKjoKoGpLC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PItCHXVCaKrrPUwo7Ry3yHMBSyJ6TBZEpxzGmPy7b/s=;
 b=Y8OMBoORCyDOVqPkmwTwsu4DFFuazpKudQNwA2SItDxoJwIhjim0i0lROIWTNXeLa9ioe5Gu/UjlwRJ6aZGjEMz0JVnapq1uUQijiYrYX+3yNHAltF8Ao8vEOKiwa6+LGMZLWdetyKp1VP1yUwhdXm+sSINPtlJUbF9P7bDDBXA8oS/VsFAqovoOFcmLpKh4q9ErgCaJ9+iahTmjU7f5hR4Zn0DVHlt4a5T8lSoW+u2INqwyE/mnn0U1CcvaUYzgJy7oKXmg/V+0aRSziH8ZGakDLK9K5DI4lQ1TsIz794fu1Rg4Yzeni5TG3u76cOaTpLAdLOJZk9eXbTu6LBMvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PItCHXVCaKrrPUwo7Ry3yHMBSyJ6TBZEpxzGmPy7b/s=;
 b=yU8LiJVv3afZDT1EphxEyOlfI7kA9lT9vbQEmOeTyIMKBL9hS3OSMZvDlPZFdsjGnJLxRLeAqGioTNIfvzxOlKduuTZGFxPw961r7RZbr1AxHSikmG2Wtsy0vaynauw1CL/dgNgmozYAe6fD+AyvwRCRA2wu6mwejepqwaG0RDI=
Received: from DM6PR02CA0138.namprd02.prod.outlook.com (2603:10b6:5:1b4::40)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 22 Jul
 2026 03:21:57 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::8e) by DM6PR02CA0138.outlook.office365.com
 (2603:10b6:5:1b4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 03:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Wed, 22 Jul 2026 03:21:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 22:21:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 22:21:56 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 22:21:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu/gfx11: recover gfx user queues on priv-fault
Date: Wed, 22 Jul 2026 11:21:14 +0800
Message-ID: <20260722032152.2904563-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
References: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 9262ffd4-a962-4e03-6fb0-08dee7a062a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|10067099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Kdy+kbZVCPSFc/HU6BkzWebBsiuXUI3VGrvl4r4sgOx01o4q3KIA63jznRzvxOnJf2nSzUzSr8WLdfszyxrmkoKNUJEElUFIDWolwPu5nAjFLEytyv7A6xN9PWPva2EccqNJKMEj/CkkqtDp9IAKcBCdirP1e7V4m4wuiQItoz1MD3/24e6JbqkKwnLwU0MfooPTNAwmYJK9hxpJoEXe3vkX+n/ihIApFSNhWQk4TJsv4aJu+18a3X3rrTfvlFMyxWBYDxsSe6/9guJXnnJzqQBX1ifD+Ppic7cGTVnttokyFpDz+9lRh/k1yU1AxISaJpvnEfegyMhs+UqIS7u0mbYRJZ4AzhVPRKPzDZTBfJQ1IAdws2e3IOLyIY+IQS6sMxTRqN9NsI5V3UXytArDITpoKSFgr97NJQujBD7Tfe0g5Rn5OVq/hKwRlAyaynK4530LxASTmvN3Om5eg261Ql7oCNbvVvz1phBBF386D3MWRtVVpFKAve7v54bFAgtSlGmDbx8a4y9m+a6xNOJXogXoOJYI6GFXgWA9fza3EMfCpZIS04fIk22ED4LtZL006GcCX6JrbpHqlwXng3SEzwldgYGsYT9z1ExAFT3goFJPNZ5tj8p+sybSCwSfuTyLObyUB7dDWEXGpLxkaohmrqd9nvB9GVyXuqFvafDRIwBtNHLqvawVwiQOCriAW0Yow8yMVLE6807pJEygko1jNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /lNiidXjNwvhybgJHgpXCclzez+UqTZRGEKyOTpnDN+nhlwJSh3Ewhmsy9oQE1K9IamF+b0wTUyv7VdxoFt/kL4CkDaeGTncRH3cvLq48LuTxhZDx/tIp7Od9c8hZRu3OeZbPySCwNTm1zZlmND6pI7S77cwuha01s9KjIXicrkRIGdMulKZv+hi3Na9EGTVxQnbfqm1BONbbAyXwGp4UnGKa8wZN/ZmlMo7lml9kG8WfYriSF0vvA2KZ3UJcCoffpcFMEOMa9N1bdnAGHRRPusP8FaSAnneDsatrkbMQKubkE3NtI5my8u85bEx9jvZY+ceI+xB0mQxwdWSYLDujPeGTwT1LdD5DfzKmNyoWF4WHsuQWqbkghQtqpz/NzUyTQqKkOMzHIVO6QHb6Odt4A1YQQ+5N9IDT0Npo6POlqueK8h2ptWKxDfYGk1z2heI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:21:56.8431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9262ffd4-a962-4e03-6fb0-08dee7a062a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664
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

