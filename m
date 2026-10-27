Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762D606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rCF0WpLx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CDC10E48C;
	Tue, 27 Oct 2026 19:59:43 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8194410E46A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZmanEURDUT9E22pDW7PexvAfaonkluTzunm3yQtLR4tTT9svpvu/pPVZC+1LcHTf/vdBcvnBr/zUzpeNP6MVO3F1ywB3Ye5kzOMwOu0P9VWzHvrCf7ZNUw8UkyDQQwhpR7XVTddsDbnV2Rl5mQHC7VTfAIPXGSorMCJN+PUEXkKQyKc9HV7pEhdA0F1qAhl7gEggR6Xx6fqPnNiFRMtau7jVOuVIg2u1SkyuUGRuiWt/kUA99jjNE9YQ0oK71fRjuYPrJ07IkzLPqhSIzOoiXy7q2sqNaN10Ap50fETcIlgOj2K1yhxHRMXuvFbLNUCRt33zSau1Asr9JK2kJBZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XQad+vOnvAqOGyb4OwzVOQHjTx0EeLxab02IzWorPM=;
 b=fKGEBr1p4k1bMBQRbSgFesYaGlmXOEda7L4ZLazU4BkMctz/JNBwAfAFr/3zfBt0r2BITJs5mzv48V7E4gXnomt374be7U0Lk05Am39FmrdkZ9sgvuNrld4GTzOlFlhL0Q0FHt9/i62vuivgGbOCqux9hmnkPj5FeZYYVvylBstEOoACDgL2ISTKqOaN3FPluq/lCr764cV+E7ZIyaiAfDVD2Nps3OHYwWqXuuoJrVzEYsOdAwPB6slnlAxAscCsGyVGpA3aQTwJmtm4FtWcfxr5QpSUoL5WqrJrHR4wq/Kki/Gr0Pf7DkYauOUhhYDVx2R0T3NNnVs3SUjy3KP7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XQad+vOnvAqOGyb4OwzVOQHjTx0EeLxab02IzWorPM=;
 b=rCF0WpLxqFlHbq0ztvfoZAfZaHkRYMq2ye1jY+XtvIvLmNOSUZJr1nT+FhZ5BeW/+u0JWWqyF5B12h2fzA1WBFgKL5qrFxplou4VosbMQHNpdxjEJvWSX4YVGsBBjihRuGNY4zgFAKnP4WCpPsNsAHz95pg0zA5h3zTrF1wEezE=
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:33 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::18) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002E.mail.protection.outlook.com (10.167.243.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:32 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:30 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 3/8] drm/amdgpu: Emulate exporter->importer UALink messages
 in loopback
Date: Tue, 27 Oct 2026 15:54:16 -0400
Message-ID: <20261027195913.1794477-4-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027195913.1794477-1-mukul.joshi@amd.com>
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd14deb-fdf4-4ce8-9125-08df3464d162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|261026121527099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: jvUoUW4t8B+3tzqChfBavydIOqZcO5MVOXOp4v9bcdaozE0GCar7mzCw5bGEwtDMCs/lY8Qf1L75DO2NvbptAPYIxlhUJXjBKBQ/pmh/r1KIqQsZ7Lf20yBZ9f4kPTOjKosp5yIwfV2BEPJArsLN0uwaayW61VWWCxqL5ARIui0cyJJ46/P94SASrFAfffkg8U7Qcu4NyN869E+U2j2d1nHopPx+qbZPpEQPxTdnjp/olH7gLvKoEbuVb++uj+rTb0S8unTzNejBBxnqJcInIALs1kZnhR/2xBCwijGA1A56+1is9cQE7XOZ9f+xcRWR74rlgzCIIJl41N7Uh1vd6B33mfP2IWVyaNXYJIHJdvvZ/m5eYOUMAu1QaoVM0M4hAeellw/yMPRPBjP/9hkWGECJDcse+Ekg/Xq+h52dMR4IZCqLJLSIPoMo9Sggn5XOA5pmtRE7+QZhYTZ7UvVfuGos1I/WcqA7K1S1kQE+2DCBVsvR1Lfc9z9ljzMvZ7FE9xZ6U/C8ePBrquDelIGt449SYxij881nxCnV6X/GVJurgCqa/4IGE8sH/AewQlOM0ao7ldQ/uh4LehXHLX7U2RTzYUe6g0gb+Evi8EjHV2l/cwVsRNJJkSLyfg6UW3snP+/FNJDq2mHIO/nLfAmbFcg11kqM7GlH0TwIxNVQJ6m6KtvlWF6JLS5B8LrBhrkdBjOhtTd0yEBEnWtx6703Zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2LJCqyCR0FSmLGNNxDvoEMg9eUZ1DXbxDE3ArGi01Dp4FJYPe3/xQybZKVqx6ZhxLIicnpNv+qjFXUXTM2KtDklalFzqY+OTTSqoPUD7ZSn0R2re6sE+1SR3qBO1tDnhSYSk0tzTuKWP2pfzEm1/Xph9yqwXCdxj/lC2pdoXr9RUrDSTo6NXiJKf1xxKkxYyZYJx7vtZCIANFLPHX/ZmOr1WaQiEXNV9iJQiqxjBndtCZ3/Z7xIYLrlf5FVwqK9vl5n8PqSk7Jty4By5GFWf/zWk/5FXymv3COnSL39bL+8y0iewTBO+tTferCy5KBHIrUlq9QU0NJ9+5yYZX3Lx7jj+kGYLNGsedxURxu1C9znZHLWUSqD7Hngb/Fsq1cgqGLKgDMsZEfFrLMhnUvhLkk8hpbHvT2FMwwj+4hWSabiuCt04nfuQJ3p8Y3smpyPj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:32.3021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd14deb-fdf4-4ce8-9125-08df3464d162
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v1->v2:
- Use wrapper functions in amdgpu_ualink_remote_interrupt() (Lijo).
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a186859dee3c..6c70be7badec 100644
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
@@ -6209,6 +6212,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
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
 
@@ -6630,6 +6644,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
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
2.55.0

