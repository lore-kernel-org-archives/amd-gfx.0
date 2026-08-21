Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7321C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E48710F4F4;
	Fri, 21 Aug 2026 19:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MyoYWpJb";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3E410F4F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctSAmJdU3AGvXM1N3zXieXXQTQvR4YQQgnQa8lT2OJX+7BpUrY185EZa0pvNP34xjC4at9FegM6NA99Qqjsc5cBdcYdO0msZKNyyL8NEThXqZs7Wj2hz4rYjWprgcV9HA8HVkEvzeyoHXVEAIZeZ3wqq/ZGMIcVhy2pM/Pt4Wpy609oFu9KQZg+a5ysSV9i5LwkNdTNC1J2OPJ4/Ppx5ulmtR6WQLaQsr+KILczqCEPYHxTyW9jcwCTBAuv4oeu0klecXMSsVEZJ1xmtDeujpuoQdv5MuWD1VxuR3kdoxPLOjEujzdQXfaAWIGReK1A0Dwy1w69NULYGXhNQTBk4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m8bMv/18Gp/E5huZxI1TtT5VbVWgjZRxdVhJjLCKUA=;
 b=qP/yhZmXAYrulkSKC2NC33JqAyd4hjApXIkNybZwv8mqVt6dt6ichD6tER8yvaeL1lIGNWJ7iUHEJTkauP7ynH6tIMUB+/01yoCRU7Xx1ctaVSb8YFmPmRF9fTnIUw9xz6bIjalymr0OKFF9Z4kYjHtbgE9ZQydIEM/IL50IZXA6St5UfvS5J/Lz3WuwpxGNUTlD3B4qYCTcZaAaFFyCw6rM8zIel/sCY43s+tko64NNgh28lB6D4kc6IICHZKmidpr157he+bPmV4ilFbc5ixmRB6/eypzXNpa/RB/7By0/uhxkmZgoon/Bd7F4y3sIIlejMDR2WFupYmEar5UK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m8bMv/18Gp/E5huZxI1TtT5VbVWgjZRxdVhJjLCKUA=;
 b=MyoYWpJbvxMt/CVtTiAEv5BNNB8mKs9nWkxcWtdTmLgkK6fzlLTjr+ItYxRpzT7EnbTpSjXJT/+uiV+Y4KkAsL7PxM/csRikyM4PKvf4eXjL2utWO9iejUQCPwlkLq3X2K4yPVRUZnCsnYRRJPVvN8d4ZmbRHF702dKZIlKobqM=
Received: from CY5PR19CA0071.namprd19.prod.outlook.com (2603:10b6:930:69::17)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 19:35:54 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::6d) by CY5PR19CA0071.outlook.office365.com
 (2603:10b6:930:69::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 59/95] drm/amdgpu: Add debugfs to drop UALink protocol messages
Date: Fri, 21 Aug 2026 15:34:22 -0400
Message-ID: <20260821193458.808626-60-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bafdd9-3095-4ed1-c832-08deffbb6a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|3023799007|10067099003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MR8PddK5qQQDx1DBTsURHMdpFaigZEG+vpKqd++zJkHutZeVfEq704SDXAv/e8Pp8aaai4ydmC76Ay2hUnbbsdcG1axGmezx7aoFnf5DEW5GBuELsTc32pCjJFJy8bd8lwAdDlO+nfbfX4Qm7J+LeRvIxzBIL0yWlr9/pl9hAT96fbUflo9ql4q99aRxnocDoNsV+DsbbPoMytcRNCXa1fECZ1YYgcONh1yB9/nsm+4wwEjfbHh6T6dIDQa1uDf50A23ZrGu+uNBYdWCixvalDrcdi5fVnOM7w4tLgTEHfDympwo+eyAQcWdtP1c/B6Wm4lcCR+iQ8IQ5ttBatOKmJ2PxmUj0DKRYFzA+PQnVhJr4EMUMz//Q7Dueoailvv3K+E8+gxGNWoA4vti23Q555ipEMyKmgq8zeE/hlLIonXWwpN9orGyQPAvE2OdsXnauj0Yd9hq9k0i+GxOLE+3v4i8X5+59EaFKMQmgyWpf8TFqPg/qyb6lvA2m29zp4aeuEUkkl09EkSJqko2pHnLb9YStAYAWL1dz4cXG0991R0zXRDdLdFDGuJ510VSpWQrs1Ko53TPcvVKV49LFqM7s9bBg3tegt8YhX70R9Rq11ZJuc00+uAc+vZy6BROtCv3I9DHde+rSgvX7flTO2p8LsojhFPevtMDMnBCV3xyJo9K3ywrst2Su3YXtLgOkizMZpYSTisZykKFIWSBO5xaPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(3023799007)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nw348KltLhB4UZ8vlxwpwL2t0Qpz+qHlBT3neQO1Xzt2pxR75EZKZRUWH/yMfYsfg2045q9vwYEZp9UBo8CKpPDpaQA/TIVwhUNPUdkBg8XaLeh1TDUNXpMmMXqe9OkBG7i1cfY0FlGQ0XgMCUdgrH65AHRpALEcRuQUrOG5zhn/kao3u1SBn90EULQ5QnOg8uxInZ6jykXG4jomarcQife6HyCV7w7l4XIKegPwD4NtkKmIoiEYBpRvkr+FH0TtBHim1Zx8RFwzpIqWx3zlnWBe+4FICKWqcS7IrtzJtxNXphIglsFjJ0WyfbFd/69On9F7F9NqqOwoRSq08l4M9kHYWbqg36jUVd7bunlYxKF6dzXsHOhLnY+riBzWxcqCE5yJIbtVdtR+S6N8L9fj2LixSdhXL1+p7Xi5k2dzAbWGX2PdXYDMyTwIifDIfygg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:54.4694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bafdd9-3095-4ed1-c832-08deffbb6a98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
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

From: Mukul Joshi <mukul.joshi@amd.com>

Introduce a debugfs-controlled bitmap, amdgpu_ualink_drop_msg_bitmap,
where each bit corresponds to a value from
enum AMDGPU_UALINK_PROTOCOL_MESSAGES (e.g. NPA-REQ, NPA-RSP, NPA-FAIL,
NPA-REVOKE, NPA-RELEASE).

When a bit is set, the next incoming message of that type is dropped
in amdgpu_ualink_process_irq() and the bit is atomically cleared via
test_and_clear_bit(), so subsequent incoming messages are processed
normally. This allows exercising the UALink connection reset and
recovery paths (NPA-RSP timeout on the importer, retransmit/teardown
on the exporter, etc.) by injecting a single packet loss from
userspace, e.g.:

    # drop one NPA-REQ
    echo 0x08 > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap
    # drop one NPA-RSP
    echo 0x10 > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap

The bitmap lives in struct amdgpu_ualink_mgr and is exposed via
debugfs_create_ulong() next to the existing amdgpu_ualink_test entry.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  | 16 ++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 132d054900b5b..d80fe17556dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2229,6 +2229,20 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file("amdgpu_benchmark", 0200, root, adev,
 			    &amdgpu_benchmark_fops);
 
+	/* Debug-only: bitmap of incoming UALink protocol messages to drop.
+	 * Each bit position corresponds to an enum AMDGPU_UALINK_PROTOCOL_MESSAGES
+	 * value. Setting a bit causes exactly one matching incoming packet to be
+	 * dropped, after which the bit auto-clears and traffic resumes. Used to
+	 * exercise the connection reset paths.
+	 *
+	 * Examples (drop one NPA-REQ):
+	 *   echo 0x8  > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap
+	 * (drop one NPA-RSP):
+	 *   echo 0x10 > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap
+	 */
+	debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
+			     &adev->ualink.drop_msg_bitmap);
+
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index cd9ee0484f9c2..1b8f0a6162b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5344,6 +5344,19 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
 		src_acc_id, msg_type);
 
+	/* Debug hook: if the bit corresponding to this msg_type is set in
+	 * drop_msg_bitmap, drop this single packet and clear the bit so that
+	 * any subsequent incoming messages are processed normally. Used to
+	 * exercise the connection reset/recovery paths via debugfs.
+	 */
+	if (msg_type < BITS_PER_LONG &&
+	    test_and_clear_bit(msg_type, &adev->ualink.drop_msg_bitmap)) {
+		dev_warn(adev->dev,
+			 "DROP MSG (debugfs): src acc_id %u msg_type %u dw[0-3] 0x%x 0x%x 0x%x 0x%x\n",
+			 src_acc_id, msg_type, dw0, dw1, dw2, dw3);
+		return handled;
+	}
+
 	switch (msg_type) {
 	case AMDGPU_UALINK_HELLO_MSG:
 		receiver_acc_id = (dw0 >> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT) &
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index a1fd5fe953115..407220710d9b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -338,6 +338,22 @@ struct amdgpu_ualink_mgr {
 
 	/* Sequence number to track the need for TLB flushes */
 	atomic64_t last_flushed_tlb_seq;
+
+	/* Debug-only: bitmap of incoming UALink protocol messages to drop.
+	 *
+	 * Each bit position corresponds to a value from
+	 * enum AMDGPU_UALINK_PROTOCOL_MESSAGES:
+	 *   BIT(AMDGPU_UALINK_NPA_REQ_MSG) drops one incoming NPA-REQ.
+	 *   BIT(AMDGPU_UALINK_NPA_RSP_MSG) drops one incoming NPA-RSP.
+	 *
+	 *   On reception of a message whose corresponding bit is set, the bit
+	 *   is atomically cleared and the message is silently dropped. This
+	 *   means at most one packet per set bit is dropped; any further
+	 *   incoming packets of the same type are processed normally. This is
+	 *   intended to exercise the connection reset / recovery paths from a
+	 *   debugfs handle.
+	 */
+	unsigned long drop_msg_bitmap;
 };
 
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
-- 
2.55.0

