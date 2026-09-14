Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275E1C88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31D110EC5A;
	Mon, 14 Sep 2026 13:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBnJAceA";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993D210EC5A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RciC02atudP/c1/H1cIIUBxzNYAs54lcOWMtk6vAppv+tlztTAo/uXwS3S4SupCLe83IgSKe7V9T8HH/Cal+hmquHMpPRwkKm/Pj2ni+p1n+ApzhtHU5+Q0bApr8wtsPghCY5YLnd4mbWLOUUnJyHhfC5OHPwbcEogn8zgHI+dRyp+T1lW3I47c3XyAOAwVPgHSpMQSURlglXBCpis/v9ovL031ZkYfQjxYDeALhlIQ1Xdz/428yclVvbyWwEeToOlqdU12M09P6j8Csb1Wlqe/IKrcAvdGHN8W+2ariHstVfTDj34Eq3IG6vRxo4fUCUln0PT+YlpRvWc4tPvZjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97B38uJBFUcLaKqpT8DZmZHyBDxkDiAb2RtIXmL9Fq0=;
 b=K580JC7sQePTwq1j1cflb/jdjZwyJcoq+2Per+5bx6hjUza5WvEzKnjLtFQNGdTPZOQYhqP76Mr4pPZ1Lib/MUvPa+4ldommVTp0rOFvhjpfL71KueWexXb9eVQln+5tr4b8452yzNWzYFWWwD7T97dSP93lVSBxCCMDZmTw7CmqSeQNYznXj/x89btfriGyLMQk8+dxpBaIFwfibaAK2zTP7kiNEOLJLZcCK67eeRvdYPbg0mbvRpfr+hymdMV9iOeC4+TC8fnnIy4vCtyiYgAaQFJaoZAn4R1R8TEWkFZSCbtCgY5uTpEjzGWG/7KRlz9jOYdLT/jTiwx03fdMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97B38uJBFUcLaKqpT8DZmZHyBDxkDiAb2RtIXmL9Fq0=;
 b=zBnJAceA8P6j7o5RQa20JolIjvZMGG2rwqS9uvCII4BE16FnVFCHqhjvaG3jVXNcy9NqNdtc7jMeVagcDYVU4Ea7F/4KTgEsdoR+yjx6sI/syqoHcWDJJGC9q+ZPh2rFc08LAGgbbqLJO6Zt21oUD87o2TnReVz3ZbtCwXmTWy4=
Received: from BL1PR13CA0111.namprd13.prod.outlook.com (2603:10b6:208:2b9::26)
 by DS2PR12MB741322.namprd12.prod.outlook.com (2603:10b6:8:3c0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:05 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::72) by BL1PR13CA0111.outlook.office365.com
 (2603:10b6:208:2b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 13:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:04 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:02 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
Date: Mon, 14 Sep 2026 21:07:15 +0800
Message-ID: <20260914130724.130794-2-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS2PR12MB741322:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a45d021-ce38-4ee3-fac3-08df126112b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QRAqPifLPfgb5Tw0aU8TxZkxWMPrkLj2sQTDZqjShCEGXkAqD/OqEXpsym0X3LJbAJMRYCIUt9X8ggsYK2WdNrXGFY9cb87mqv9Mf1X10BvcfWyB2IZF992dL6LdxACLDyjBtCvkUaJGt7UwuEw/gdwuyWDs5OUC39GlxgK76Iuc/IBtU/MV9sulKBXLTbTsNpi7mzXmtzzMu/6sIAQq5Z0WQaF3AG8ngrGj6w2mef1Y008naVBxuN2oMJXK1uXKkP/t0Gt/5kU/2LK4T4lEAPSOLijNHH+aWclxqqNyZQGeTKz66BAyBWoUB/xmI8CJKngyKLyaK5m2hSzBdbHvp9h6ZZ7lkck4SIFWuNLB45Tx82NnD6Idq+kcox+FXBByW5E14kJppZt7i5bmY1Uh9HvxCtE43E0h4xXPGd4w2JbF+n2VkiGupxBaUYR7ni04oF6trQN6pOSJ+RXMdDkiufRseHZebupcWysYvFc7gL2qq2ki78oGZZk8GFFB3Zu2+xaJq5XHIegRvEVXdSxZ3iS/ImhrUu+IUH1viZlDpfP4njNNGq4mfvS+OPS686Vb7bwKjbmro4S9oVHdWfKObOiUV2MS04oRdueqJaJn2vBvWMWJ5Aa6fkvk51hWsfTdH+szUWR1lciQ4WiOavrddBLrgUjIET/7uxZh1I9bSMacsQOcxBkZBv1+/fL5OvvUIyMdVx23rMxwptZ52uER6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fY4e/GoEP/glr9+LF9pxn8xJ8ijsFBLp8GGStbIkeCTMqzETrUIHmwrx6CWvE2HOnOLx4lQ7HN6am96hUEhisiPivFWuh0vV6+5nGOIyXNq4Jr+/ck3uS4EuU5oiE9YryyymDQ3/BFlgOm7s2j4bfzpORkW4brvBgzxtkepcqlmr1xLkf6EsrFWq+albdHTRf5yYAxL4GsrocdBbQBY+YGPdrDG8NXl+EgFtcG4iU219aspuJ5Ic5TJCB1P9R9pWr5Uq4oxsTyhs/9C1teT4YE5w1AH36qxmt/L1uXTOXAlZ01VMVLpvRbZ6owsh+QBePr/FZSMJO6l/SXxG/5U6ksCDahSG+kg+btCQ6jmc8sTu2yltKo4RrTIfJrTkQYXY+sORQdY89Mp6Qr/Fg4dUvkzjkc8PTAsYyo6tXJDH8qhzXxeoZH6fzf7K67CBD1mh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:04.4185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a45d021-ce38-4ee3-fac3-08df126112b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB741322
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

This commit introduces a new helper
amdgpu_lookup_queue_by_doorbell which helps
look up a user queue with the given doorbell id
in a xarray.

This function takes a kref of the user space queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5ff9..e0639f844a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
 	return queue;
 }
 
+/**
+ * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
+ * @xa: user queue XArray indexed by doorbell
+ * @doorbell: doorbell index
+ *
+ * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
+ *
+ * This function increases kref of the queue, the caller
+ * must release the reference with amdgpu_userq_put().
+ */
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_load(xa, doorbell);
+	if (!queue)
+		goto out_unlock;
+
+	if (!kref_get_unless_zero(&queue->refcount))
+		queue = NULL;
+
+out_unlock:
+	xa_unlock_irqrestore(xa, flags);
+
+	return queue;
+}
+
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..8fc73862f64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -151,6 +151,8 @@ struct amdgpu_db_info {
 };
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-- 
2.53.0

