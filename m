Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48179CCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A2110E876;
	Mon, 19 Oct 2026 08:34:24 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F00110E877
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUHbdbWAimnQHIy/b32BEsYNKbE/suoK5pRRI7UoujDzODIMElYoRbRC09yAyRm/k9j7k/KcSsOnmBQ3LNjtsQSCunur4R9vyHy2DGYepZIITk9D9V8+DuM/CBoBOAFfchtjDIUqpR7/E2wquefwLncHKdBY5jFsuJMTsM7HLd3GWhMucSHv0micrAjPCj00gKwriWIWXOy8f48gEt/RHmq6irl/SCD2WIXnSr1p41EttXKl494i1+56LF3PJfkgw3e4LVbFqzcbRG5v8xEqtO5h0VJboGQbwaIOBzwSJp6ANS2XeYyHIfyf+WdvnDNHzHY3fpSUK7LRsVkS26BO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOgGcZJWjo82qADkB2wCxh0/Jw/aaZvyj1RLKGhF7iw=;
 b=r3Dmxok5q4IbnbQfaV/nNfg9oP4RQLPEYcF6vwTx8LITSr+n9j7yBwlbNsMmghl36Y/PVxFQiK85zwpNNa3Gxotjywl541U2C0DKhEssrMJ7u0uaHCfU+u8notYndrBK9NPGbR4fbC9qrEdZq8Vcz9farzP3A75znhSH737+ZeOis8Nw8rtFTWU8f4FZQyTCvCUx6/4aLcTR7eZw8Jd9xqurFuASAydle3jlG7gQ6dGat0RnZDzsGP0S+F91b6vo0rfPgC6MCR6s3lOAzf2qOcbf5mhhgEqwnekc1hfh4DVrAU1FOLh+pipbrDdkAAooDocQoCFqi2cB5hyckmOQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOgGcZJWjo82qADkB2wCxh0/Jw/aaZvyj1RLKGhF7iw=;
 b=2PkekkW4VUtdgzh1ZrFNTtyQbNxb7Lu6MMAVN93qx/tnWxDhuFAYX5OTfvLKuppp2+sERwo9PE4pW0ZIWwsYG4d0ae6dAVRez4LKB7qk2k40DDKhUYmcTMECM6VSlYVXEmD/GgsWUQE/vV9m1pinYwyrjK2DCTVwA/1vRZGZHWg=
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:12 +0000
Received: from MW2PEPF00014673.namprd04.prod.outlook.com
 (2603:10b6:303:114:cafe::a0) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 08:34:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014673.mail.protection.outlook.com (10.167.249.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:04 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:02 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 05/13] drm/amdgpu/userq: add a walk over the user queues of
 one type
Date: Mon, 19 Oct 2026 16:33:05 +0800
Message-ID: <20261019083402.2033724-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014673:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a02c1e1-c847-41e9-e952-08df2dbbc06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: WT3f83DlROnksIATGc7lnkqMmsHPU5JOY65EG6+Gs09OIBk3ys8iA0Ai2B4OGN4K4HuGEaHBFGfK6gvTkifedKIwA6ilGbpnjz0YtdQDEjjiTFJ6nPfsJbJcA3B/vhF5qj1Nx/a+h3Q7YDm59mbL/pAY2gXW4pqqQNN3rSudvpi02Z0YRw2wS98MmpmWLnvdQoXVjWUaHHiigqoqP3OVxQ89Qj2R2I80fut3xZYp9yHuDo3d+jdIIWyKJYgtMD7mU/9M8G+8HIydbU/8t4B837FtJPwtOWRV8HAo/F3ICMMN+XqEn/9jXxO6m1IDaD4mgAop+cHn8YmuFxOV76ufU9mmjXMxyjpwXUmyPPofhx26JiWI9YsEQHxacGT+xxBqRdTRCBWRugDdjV+bAs+ALCkXAgkljij7hEWMp0MG+uSb4LrOPQoHJHjhNvedCAZ9BezOiz7GAVZNcmP0inwuUqCZ7tM8aIK1mAw9xYms9ZeHxhRsYlVnzYeZBHSwyJmuDUgOcbVPVLb25C2Z2MB+wV8y9WbNqpSPWtjAfzH+ov5GNjiUfJ/DB/KZqAljYnXhaDlmlgNFN5M5TaLatAZ1u963kXJlxw5tLxVkpNwGzETJhtKGFc+8QJM67hFDgLKuBHkglY56WbU2TJjaPF29ebQaif3LZt17qc4EBldUnXlzBkfOvE6iy7Z2qINxIzAO9mP0CPH0u0JWRDN1F7KGqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F3bz/wylFDo+gfgpG65Q/NMRpPw1Wey+nHNNuLQS/NTmETBs1E7kvhtLdgbEij9+h8eKelW/sUfNe9sM1+r2m2p9Kx8+10FjruumQCjxrgUaZICuk+81cE0LlBv7+DkSmFNiLH9YYzTd+c1bOIgpkTUPc5WTiJg0XjBkdIAlg6ZgT3sGNjaqNt5ZazEccK3PhxdyEixc1WCfndt+99YxZ3xulQQDCZPsWQu1yDKywzOZvrYv/8BzPNqUD6u+C83BmpZo6Yn2+Up90jsrYkoRa7B2H8RYMYTUP5E6VePbYRD75SfSgynxAIXFsBPf5z0/rm3SZWqv88dT3oBePncy5WjL/eoZVDjaUQonGFNIFQYdNvkp4d8P3oLO1TKOp6O24pYkSiA9TwB9KF61gep3kq2FEb0XNUS36NR7ZkFLrsSysFZys9k95/lA8IXPKm5j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:11.9468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a02c1e1-c847-41e9-e952-08df2dbbc06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014673.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
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

A reset of the queues of one engine of the GFX IP only holds the reset
lock of that engine: the user queues of the other engines can be freed
meanwhile, and their type can't be read then.

Add amdgpu_userq_next_of_type() and for_each_userq_of_type(), which
check the type of a queue under the xarray lock, before it can be freed.
A queue of the walked type is kept from being freed by the reset lock of
its engine, which the caller holds.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cbad1fa1d2b5..2097d7c0bfd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1591,6 +1591,28 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 			      false, MAX_SCHEDULE_TIMEOUT);
 }
 
+/*
+ * The next user queue of @queue_type at or after *@index. An engine reset
+ * only keeps the queues of its engine from being freed: check the type of
+ * the others under the xarray lock, before they can be.
+ */
+struct amdgpu_usermode_queue *
+amdgpu_userq_next_of_type(struct amdgpu_device *adev, unsigned long *index,
+			  u32 queue_type)
+{
+	struct xarray *xa = &adev->userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	xa_for_each_start(xa, *index, queue, *index) {
+		if (queue->queue_type == queue_type)
+			break;
+	}
+	xa_unlock_irqrestore(xa, flags);
+	return queue;
+}
+
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 {
 	const struct amdgpu_userq_funcs *userq_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..a56cb9fa8684 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -179,6 +179,14 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 void amdgpu_userq_reset_work(struct work_struct *work);
+struct amdgpu_usermode_queue *
+amdgpu_userq_next_of_type(struct amdgpu_device *adev, unsigned long *index,
+			  u32 queue_type);
+/* Walk the user queues of an engine while the queues of others get freed. */
+#define for_each_userq_of_type(adev, index, queue, queue_type)		\
+	for (index = 0;							\
+	     (queue = amdgpu_userq_next_of_type(adev, &index, queue_type));	\
+	     index++)
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
-- 
2.50.1

