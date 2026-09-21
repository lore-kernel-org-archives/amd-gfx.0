Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E6CC982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE7B10E515;
	Mon, 21 Sep 2026 07:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VQS2pEGY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E948C10E515
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3NCt5mXxeml/I+A9g6oYaOghYAiy1FxPgNp6trcxCAhGkOruBwVMN8hsFVGS1OY4j4y43dnn8vcgT5TIcn/aAnGUR3d0bHnLiQHZWGzvDAmc6+9II9k295zXL2owWMCTQFIiftIWyno9KweiAI5ItNmgPxEMbx/f4W/uf4dVn7L8bBT2mb7/ASa4cdWIhPqw0FOB/f/duUVyIC7/xLB8CJwBC33iTZTF+MQ6R+PUq/pvuClySC+uXH7ilaaBgcNcctyhU+POlYA2N9b0P83ALimkPmUsKiaIbf5UlZvgj0vd/auC7gPe8pMScOUthw8JwiT8VnzUMKarj+9aiidtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJs39cC3b3yqMCWtNrtFndJODx/iHYlaBORIKiyV2Io=;
 b=MJoDx4AsCRzYnTB97SMfW9PDAxz4n3FOSBCkPEcU9evH2zGEM1nV6N8zAu96RaYN3KXqKSXh3lr5Nh+7yihXdmq782aC4Gs2omObow9910/92n6yoCGSPsAsMHDafZo/zt4798EMW92xzblqYQrECClDSgtwEH1XhYT+cR16HXvtoCGJVWEeHwnR4nz4htPnPAjOmFTTa1JX04oQ+/88mxYgYZRDDMfJmih3XZwyVgRFVOqwatwIay/VKrBHh4NNfCJTE9hyD6GY/Uq1ZYMVm9Jvo1S9F4a0ZD0YtQv0PY2Da7zp5h+TI7CAMSr9f7EBk+fHZl2/+j3Krughi7S+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJs39cC3b3yqMCWtNrtFndJODx/iHYlaBORIKiyV2Io=;
 b=VQS2pEGYCNI1M3tl0lGxSJmIxH0a7NVxnwFc0zEoM86sya0rZSRfyUBZy60Z/RTSc70ZhYaaRXSq0rnlaLWXk+VrrYlLxZt9m8m0a5ARvCntjzJrSzeE34oX4vOfoNxetM+I+y7Bq9PqoKI45jugxUwOq9etnSeyAlLnB0VQyWQ=
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:55 +0000
Received: from BY1PEPF0002695B.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::44) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695B.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 12/21] drm/amdgpu: fix empty fence backup and replay intervals
Date: Mon, 21 Sep 2026 15:51:19 +0800
Message-ID: <20260921075326.2409021-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695B:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: b28d6906-2b27-4f89-7a53-08df17b57c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: sZDrF8HnOeJKrtTsOl8R/fOZQ62D8gdIhl5zYyer/P7/g8ie9HqFwdqYlh5/+nkEWRdOw8siKzKokDtMRzWMgXDq4LaOk5fL9oPGnjYkusUfn9gT+nLmLgA4T7C+jTcvFRzKwcaEv+nQF7ZZqKdg0Gy1ADvP5vT30rAmV2RbCE8dd1tGjeHqU7i4zSnBOvrol0cCOJL7k78zQd5M669D7f+04BgnNBmzgPRtRJkBDC0+3V3Cyy0qeqzJKq5j4wdQP3mF1O1JJ86AqhRC+upNUoNXo/kJoQM0qGbsLk6oQ1iMCBx5Tj9MTdeJxRpAObAVX2DIGZkdL6JkQen3iaAVpaYrGQTD6FX2w1jP9IVZlQAShDcxUFz/eXy+fBIM/nyW3+tRKu2RHiHb0CVAXbOtMhhggBMVLd9mBCkE/cLRdbQPpKYlHmHPZ04RKcNlNT2/u4cVUOpyVJCd22ygbp5JFBl4Cf8f5+vxpzsxInEV5gQ6vd7M/r7TqKDiL0DyJOUz9S7xtOaqvpy91+xhNs9OqkMilsU0iEgljtmyaY4r/jCe4UcbSqNL0G3Tt/noSBdhncsDyMk81OLBcHrOpc7hidlsahBG9cQ2NtFkNjYKZiqRKffOkhnU1G1NHyIcGovkZa3DXl6s75Q2JcfTohYxRWM8ZnNV88wTGlCraEiv2Zo1buoAf8CpiAgu/5QzhcdCcg0iVWgdgcNlPWqLJ5Swxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q7Q8PTj15FM+zvPkj6spyOAGzMG6UhUh29hLpXRDOhALEgNWPgcBeyPIoU5g5uwyiHeO+ZsH09zxpyk/BZ8aeApR5sq+V9ukPY5pp4CTLVcSPUvhhBuO1bhvhYB1nBY9KbEwdw0HpvKMCdveISMOhNf6lSOw5td4Y5BSmfUny6DR75WRjwToOy4G8ILxucGIOLA33Bny2t7iy+YD6qL4fI8S+OGuPJ10aShDNHPgicpiUluj5PjYIBFSKu1C08kfefxLbgq0uIhKNgFT5C1pgZCadf5SkNKZseuIYecZPmq2JFMzLLuybHTWDiH5T2l46YQR2F+Do1hZBZ4GcuECrWP0llivaKWWHU2zBjoyj8VrwbzpvVpAD+5BNIjKr3fHrBoxJAlIRlFDadNG+mRxS+/kPAjWPvp6HrgoeHHVyEDkMphGbTnsD0mTYIGA1zSc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:55.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d6906-2b27-4f89-7a53-08df17b57c5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF
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

amdgpu_ring_set_fence_errors_and_reemit() and
amdgpu_ring_backup_unprocessed_commands() masked last_seq and sync_seq to
fence-array indices before the loop, then walked a do/while until the two
indices met. When hardware completed every command before the driver
signalled the fences, last_seq == sync_seq, but the masked-index do/while
could not tell that empty interval from a full table and walked the whole
fence array, backing up and replaying already-completed commands.

Read the raw sequence numbers, return early through amdgpu_fence_process()
when they are equal, and mask only at the array index. Guard the
force-completion against a NULL guilty_fence so a non-guilty backup does
not dereference it.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 24 +++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 6537e8845fb6..3017ddcefbe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -724,8 +724,14 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	bool is_guilty_fence;
 	bool is_guilty_context;
 
-	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
-	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+	last_seq = amdgpu_fence_read(ring);
+	seq = ring->fence_drv.sync_seq;
+
+	/* Hardware completion can precede the interrupt which signals fences. */
+	if (last_seq == seq) {
+		amdgpu_fence_process(ring);
+		return;
+	}
 
 	/* If there is nothing to reemit, return early and set an error on the fence
 	 * if applicable. If all of the fences are siganlled, this will be a nop.
@@ -743,9 +749,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
-		last_seq &= ring->fence_drv.num_fences_mask;
 
-		ptr = &ring->fence_drv.fences[last_seq];
+		ptr = &ring->fence_drv.fences[last_seq & ring->fence_drv.num_fences_mask];
 		rcu_read_lock();
 		unprocessed = rcu_dereference(*ptr);
 
@@ -802,8 +807,8 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct amdgpu_fence *fence;
 	u32 seq, last_seq;
 
-	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
-	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+	last_seq = amdgpu_fence_read(ring);
+	seq = ring->fence_drv.sync_seq;
 	ring->ring_backup_entries_to_copy = 0;
 
 	/*
@@ -816,11 +821,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	}
 	ring->guilty_fence = guilty_fence;
 
-	do {
+	while (last_seq != seq) {
 		last_seq++;
-		last_seq &= ring->fence_drv.num_fences_mask;
 
-		ptr = &ring->fence_drv.fences[last_seq];
+		ptr = &ring->fence_drv.fences[last_seq & ring->fence_drv.num_fences_mask];
 		rcu_read_lock();
 		unprocessed = rcu_dereference(*ptr);
 
@@ -830,7 +834,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			amdgpu_ring_backup_unprocessed_command(ring, fence);
 		}
 		rcu_read_unlock();
-	} while (last_seq != seq);
+	}
 }
 
 struct amdgpu_fence *
-- 
2.49.0

