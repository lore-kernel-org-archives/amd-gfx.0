Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAB606A598
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mA2Evh5p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C88210F041;
	Mon,  2 Nov 2026 16:02:29 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C4510E64B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCQzZfrcUIAhelIRR3xT9ziSU64XW6YG/BrMUmpBDY5IVOFrtP+fix1DDNF1nc88GxNTsz8lCPFY15qhakqndGe7DWT+9dRHF7cmPJ2xNPUhFQVbtUvRdVeD4exfz0XPYvwsyY3zz5rLycResBNL+RbCqi8JPV8i+4USLOnEO0XUx/xHV4g+Y4yBr8V7mrHBDMvM9Zkz+dHnnMd1nL16STXGw1y8X0nKfzKotJ3Z5YiuYRnZc5cFNq2+zcX9KgagsYvz3FkNb6oGro2s57UafMqC9g2IwhJiTFZSYfCXKW6YC9VoiKHDPhW0UUmQYFbhJiaV9Jw24xW71RKbWE8mIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ecc4fbbD+FtXy9zj1rxxvYEwRF7hXDPUJe9t7XtTCg=;
 b=oPxzPlWYtvX8G8iYP8viWQlol6LnEPHkahu7tqmRrKOaCOrClqvNrvRcgNifvFBdfMAjOL8iB43G01Pn+L70FPWfnXtnv9YisN/DKNDkMRDfQLLu6ItI5UMrOnKWDhZZqsQjhiGTQPQgxdt7k08twFnB0gpVoyOQsXV/Nav5R4Z4no3eh7PCZLq/+YTX5+Af9vzaSB2Z0f4/JQBNxwIw6qwwJYpmv3TYs4fDcKl/hhF8oecGThprIiRCegBZTZ1CpyhpVR9xc6kOTs4YJSF8Juyd4yrye/7MTXrJZ3x7na2V9tyd2Q2tJ9nSWslEgoDMJF9/RBdgup4gmUNNXumz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ecc4fbbD+FtXy9zj1rxxvYEwRF7hXDPUJe9t7XtTCg=;
 b=mA2Evh5pxYT4VEporSZPVpKsXGmf3Gf9pq01oLKoCr47i87hk9KWsXFO/mE+W0haU0CRnZB00QLsoqhts17ileTbYdX4F1xiRWihm90dz/1SFLsHwsG+98pBF1MCTnrBZTgg9NSulwxUgCVSedSTYOyhDxT1vWATd+uuzCkjygo=
Received: from PH7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::23)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 16:02:11 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::65) by PH7P222CA0009.outlook.office365.com
 (2603:10b6:510:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 16:02:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:09 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:08 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv3 3/8] drm/amdgpu: Emulate exporter->importer UALink messages
 in loopback
Date: Mon, 2 Nov 2026 10:47:49 -0500
Message-ID: <20261102160125.2743750-4-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102160125.2743750-1-mukul.joshi@amd.com>
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a7204e-ad42-4dab-99a6-08df38faa655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261102123227099003|261102130727099003|56012099006|261009223027099003|261028144727099003|261022105027099003|261026121527099003|261021123027099003|261021121427099003|10067099003|261026140227099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6u/Gos0oGQ8ZOeYfoHmlwiJCHKPHSoWaXQN5QETMrV4scdgiGHPeRqVKAQWOfGL0pvzQIzJSf9xGRdY6mr78/K07g2AOODSjNJEOY6MxAnyg0rvjIZL3YWYuTMbmEohtIOtb+G8PyrkVFwNtm2KDmsJy1tGUXBo6PMReXj1HXS9KKPSzeGkemXeWhCTQLNvx9o4q5cbaM00GUdxIeUtHcXCZlgDLu99JJjYtoKHHcYG34Lv+NsFIf8bSRDZs1oU15OChUzwYlq/+vHbbPQnWkN86U+CqTYnXJUASWckrgxjiyOVDijM3VKa38zAWAci693ZwDleBklyfkq38/cmop8Z1WI9df6oYeYoJF2b2g/QlLpOHCXWJ+BFE2ZdTea6vCe3/6BiZ3GHtlTkzGj6YqxWEY89Ud4dlxq8+51WDrBZcPn1GsmhBVXqqJWDOQBIOIIe8pbT0FHeqGYB86fcAhGihyfREsGBgL+06MqNL6OiPogmVo01CBY0P9wqU+OO5VOgaa3d2Cszo4TbetCkIdXG3gFkPMmlUKYAwIFvtYzViWTbjXrMFn8G2BZ1zPmfOkxFfWj0p06iMr3zTJg6nNklS45lXOYzno0kw5dB00mRwZMdVQikyELjwuNAXK0J2kE7KAoQvhgR6GJIFr8bQMl7Ga5hFCYJYDFuLrwQuX5l3y/JsY0MQ+ALlqUqY1DFj0w0/ACHXlBDnO2NZSCBlog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261102123227099003)(261102130727099003)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(261026140227099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fHN5rO728T/J6x0iYfXzsecoAN50SlWkrbn/AQdx9nLXY3KSv+/OsdktNUuaHxPavt7+hGz7gwPBGwZI7RP5kTkDEJ/vEECf6nekj/Z/hQ0gFPi+WPVlLmoinwIoSqL7zPIZqb92efLJaw4NEjeIO008HaQeGnFjwUhH4qxwXPUeWaqfJZDzfOUzSjTE4cqgDnOQnUp9n5vnNP08SvDD+gMcdzTMAySvWVPjKh4IvrwW2YXg0H5MPuuqW+lD5IyomS+6mvlcKubsyt24bG/PmocOcLOw6EGd3VV7N36e+cqsthN5nmUNlm2MJVTYvuY0Fxc85aJR7VLkXZt0ZrNR+YPmF7WNVp+pQPOHmy7YKt0DrV91rTvZsPHN+vksUZ5lFCJ6smxqSng2np0wijT5sN/tcz5mtUg5ioUyFKfoLz7V4FHPgc2daX4LNKMzGOdy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:09.2668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a7204e-ad42-4dab-99a6-08df38faa655
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In UALink loopback mode a single GPU acts as both the exporter and the
importer. The exporter is the one physical station, so the only path
the HW serves is importer -> exporter. A message the exporter sends to
the importer cannot be delivered by the MP nHT.

Emulate that direction in SW: when loopback is enabled and a remote
interrupt is addressed to the importer, queue it on the loopback
ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
as if the exporter had sent it. The ordered workqueue keeps successive
messages in order and runs the (possibly sleeping) handlers outside
the sender's context.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 29a787979af2..ef133c60bb9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
 					   u32 remote_accel_id);
 static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 					  u32 remote_accel_id);
+static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
+						 u32 sender_accel_id, u32 dw0,
+						 u32 dw1, u32 dw2, u32 dw3);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -6220,6 +6223,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_ualink_ring *ring;
 	int r;
 
+	/* UALink loopback: the single MP nHT can only deliver messages addressed
+	 * to the exporter accelerator. Messages addressed to the importer
+	 * (exporter->importer direction) cannot be delivered by HW, so emulate
+	 * them by feeding the message back into our own IRQ handler.
+	 */
+	if (adev->ualink.loopback.enabled &&
+	    remote_accel_id == ualink_imp_accel_id(adev))
+		return amdgpu_ualink_loopback_self_interrupt(adev,
+				ualink_exp_accel_id(adev),
+				dw0, dw1, dw2, dw3);
+
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->interrupt;
 
@@ -6649,6 +6663,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	return handled;
 }
 
+/* Work item used to emulate an exporter->importer UALink interrupt in
+ * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
+ */
+struct amdgpu_ualink_self_irq_work {
+	struct work_struct work;
+	struct amdgpu_device *adev;
+	u32 sender_accel_id;
+	u32 dw[4];
+};
+
+static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
+{
+	struct amdgpu_ualink_self_irq_work *job =
+		container_of(w, struct amdgpu_ualink_self_irq_work, work);
+	struct amdgpu_device *adev = job->adev;
+	struct amdgpu_iv_entry entry = { };
+
+	/* Build an IH entry as if the message had been delivered by the MP nHT
+	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
+	 * the sender accel_id from entry->pasid and the four context dwords
+	 * from entry->src_data[]. entry->ih must differ from adev->irq.ih so
+	 * the message is processed here instead of being delegated to the
+	 * UALink soft ring.
+	 */
+	entry.ih = NULL;
+	entry.pasid = job->sender_accel_id;
+	entry.src_data[0] = job->dw[0];
+	entry.src_data[1] = job->dw[1];
+	entry.src_data[2] = job->dw[2];
+	entry.src_data[3] = job->dw[3];
+
+	amdgpu_ualink_process_irq(adev, &adev->ualink.irq, &entry);
+	kfree(job);
+}
+
+/*
+ * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
+ *
+ * Used in loopback mode for the exporter->importer direction, where there is
+ * no HW path. The message is processed asynchronously on an ordered workqueue
+ * so ordering between successive messages is preserved and the (potentially
+ * sleeping) message handlers do not run from the caller's context.
+ */
+static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
+						 u32 sender_accel_id, u32 dw0,
+						 u32 dw1, u32 dw2, u32 dw3)
+{
+	struct amdgpu_ualink_self_irq_work *job;
+
+	if (!adev->ualink.loopback.wq)
+		return -ENODEV;
+
+	job = kzalloc(sizeof(*job), GFP_KERNEL);
+	if (!job)
+		return -ENOMEM;
+
+	job->adev = adev;
+	job->sender_accel_id = sender_accel_id;
+	job->dw[0] = dw0;
+	job->dw[1] = dw1;
+	job->dw[2] = dw2;
+	job->dw[3] = dw3;
+	INIT_WORK(&job->work, amdgpu_ualink_self_irq_worker);
+	queue_work(adev->ualink.loopback.wq, &job->work);
+
+	return 0;
+}
+
 static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					u32 type,
-- 
2.56.0

