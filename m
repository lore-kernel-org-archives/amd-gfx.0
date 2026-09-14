Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3FCC88E70
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5895910EE1C;
	Mon, 14 Sep 2026 13:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qTLsNONI";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D051410EDFC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2sfe78O3Sx7sUw9/W9cFOFluZ/eVyGzBCEptFqns2+o61FBUH63HbkToQWdIbQh/axdBwwHCUhUamO1gsbwzTGvVmLyrHHb5vVYm50FbEvTO9GSrckgK0bptiZy/vw/2cqGx6ADvF9HwxM2ehacnIDY5yQZmwaMtoelu5g9GQvgdHpzTR7pcx8Yl6xSReStBu/I+8LyXQ9u/JIjyEJlZLifTKfc+3iEZVXEZhq/1Nli17FBHVEMkoPW9/4hjDPDUJm+1btwfzk+A84+hPiNb7+zHuYkC7A0DsFxL2jHzISAzohl5SpNdUw4oAS/DOQbe+haxCrI66zxgx/zqSrihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXT+glQd78gF6KOaDA28kqFWX4Z/8cfCdFZKnMErVAI=;
 b=A3mwtQeU0Ap+n1wfeiqSJJbtRtjUIVDnXd0N9w9wXD3KhJex0PNj53t9osEmvl9xjTcBL3oGiBTCrz9JY59V1viVW+BI5LejXoE87PghdjdpqYpeA+OTr/nCc25a4OjFv+Iw5YrXFNMl5WkHJhyP23li2FcrCKhmRxVqNr2PbN8CSHSa7YMxR1LCOZ82L+vsjomViqy4U3Os4jIedjGvgE565KReVHBOg1w8GpmyTmrnu/2dIgm9tTdivfarssXH98pA4wL64dR1ch+Nn06Vosl2HFFDHid/sxJyAG6b7As7vYap1kUQQOpuTeCKWMcW68tj1Ki+e1uZvLujD2hizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXT+glQd78gF6KOaDA28kqFWX4Z/8cfCdFZKnMErVAI=;
 b=qTLsNONIlbmcw3HKIZO+AowvPagROpcFbyUxShh1h19xQV/xzBowAPSYo8hUoMBruFoXAiZU5i5QGnKu6KFLLCGfz+roYXIe3BmjR9Y1TdoMnTqu0hgjsnRBreQ9Tq9srAqf1jMjOkvzBPBdGVFWPki1ecFvAwLcCHxFC6iwGs8=
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:16 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::64) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 13:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:16 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:15 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 08/10] drm/amdgpu: hold userq kref during suspend and
 resume
Date: Mon, 14 Sep 2026 21:07:22 +0800
Message-ID: <20260914130724.130794-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f742f63-32aa-45bd-9006-08df12611a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5Wt5ZX+AqD6jsCTS2iJUi/tCcfH7Yd3Zwz7GQJM+qSKe944tTWcGtqgBXxanX1xVxX66Qx+f58CP2qlg01WvI8N4hAes9Rw7z22sAuGSkb9XdpNRuS+6705qaGEB7nIAFfB+kMIIcZh93LoHuwZsrwBpRMXr/gtIrTUvG4KYQ7k/1tOkkqdPzKaYTDkWaPYbQMcg1KS8WOwFkd/jn7Tl1cob8vd5aH2xKKgfn0rTlqvAXqM1R0v47+YQxeWN6MUFjDOwEjZnJUU0JFD4wrqfConqpL8baFnf6R3JKFowV5MpdiSNAF60PGeKOxUy2L0PeLPvI54CR7iSwZ57GKmUqj43L1SmtNKY9v/2QZPmqDOHSjtSZoQsmkvkU7V5OWv2bkwOEDA83r3iupy1UzlgxaJ3pJddMt1YAxPmC0qPAhbXNCtikiO5ToUzH8xvIn3JRtPsp9zg1QbPyKdYMvi/VHjQblgNrg5dJZvjffPYCzYyNM9dAmjL3JXRSLB/c9kzVeF5Kuo1Mi0S2+pDIgo2VU+MV7tusTEp9Id2EgJ6tWsmZhQ6aA0shbj5FRzS1BsfJimXjU8WrsojCD28I+3Q63SfZr/l7uXwxQ+FnfJMPUn96VhzwUBLU/fxsIBrOttSsajB8xDhoajOG82JCxpEpaIXwekv/Z2xHa5XZdMMhNByYv6G4D6oagPEuMn6F+9gLvAIEsa+PWJ7UhbaY7LUng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CjPx/tesr4H0GR1azbbQz1n4L9pzOeckWMvOfSdWByOFyop2PAXLTy94RJ0lYGMdE+Gj3LXadnykxSJ4lqSjJwB6+PTYxXygKKmxsq7wLr874yAuJfqFH8UoWANrCdEKhFHEGmIEnnDWuj5RKtBRIphMOoC9JwnM//O/+RKglFMunuw6cLrOcLUxn3OibFfsfw/pSmwNavsXWmGrPjNiCcfK82ZW1vMDOdtrsI7udBj4anUgQMSveKdpxV8Kq99TLeujmy4OOStUiF9t/e+CtHmrY0bgl6EgUjs7Do7yEEbJeyf/iwUWwMi1q3wUmp51Lb5esUhjO4Lv4pniHX+2LlZj3UqBKrHwWgG1D8XXO/SL3ld8D0eR0ymF2M+vvIb8HfQ4MxlwYC3M/l5/FBuJjNvfOMz81cDN6ZPy19Sd5nRk3uHguP+p2OVNFAHiCRPA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:16.7408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f742f63-32aa-45bd-9006-08df12611a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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

The userq suspend and resume handlers walks the doorbell XArray
but process a user queuewithout holding its kref.

Therefore, a concurrent queue destruction process can free
a queue before these handlers finish their work, causing
an use-after-free problem.

This commit fixes this problem by using
amdgpu_userq_xa_find helper which properly holds the
kref of a queue in a loop of searching for queues.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1427ff175dab..0dab395ef0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1493,23 +1493,35 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
-		guard(mutex)(&uqm->userq_mutex);
+		mutex_lock(&uqm->userq_mutex);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_preempt_helper(queue);
 		else
 			r = amdgpu_userq_unmap_helper(queue);
+		mutex_unlock(&uqm->userq_mutex);
+		amdgpu_userq_put(queue);
+
 		if (r)
 			return r;
+
+		if (queue_id == ULONG_MAX)
+			break;
+
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
 	}
+
 	return 0;
 }
 
@@ -1518,21 +1530,32 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
 		uqm = queue->userq_mgr;
-		guard(mutex)(&uqm->userq_mutex);
+		mutex_lock(&uqm->userq_mutex);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_restore_helper(queue);
 		else
 			r = amdgpu_userq_map_helper(queue);
+		mutex_unlock(&uqm->userq_mutex);
+		amdgpu_userq_put(queue);
+
 		if (r)
 			return r;
+
+		if (queue_id == ULONG_MAX)
+			break;
+
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
 	}
 
 	return 0;
-- 
2.53.0

