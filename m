Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C86606A32C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JvoU+Mw8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B189310F1AC;
	Mon, 26 Oct 2026 23:03:16 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA5C10F1AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdqBkiTJUlIaSVsaJcm9XF1HJ8oVaL7F1WsxRL1d0UQMQbegNlMkX0rgToOQ+8FWdUcxA/KtO99y++dOdlmMa8vO8NGhHBM5699zLplCAbJWz/L/NDGgf7RFlLbWx1Jev6J8CZYbSZpf6jC8qH5dnMrSs/qbLQQA/m7WJI7eM2vXuJIbmknQUklAB06cxYqSIfkoOWPZuFZ149e/4shwqGp4nI0ubt2pb8ofqLjDqGG8NrR0rBRRwL2gIqAimJajBg62HPoWu21r+8y9XE8beZEBolV3g5XVk2f4dlIofqZCKCdpPCJpFBXIwED81t+am2UJBR2aHBYIqomUGxER8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcHkQ5yS8GIfrrGp0Fg6MPJ9QCJJpOjHrmxUiFl9p+w=;
 b=Z1BemR2e6MpUyleI0l3II56HkqYa9T+sM1leEcPxZ08Hrt/HmhypMFyK/UJHpytRpQWYIu8pJV/xjk8B8CmMD10aJjsp+3iklqKVsNIS01hCgg5+tQz5n8MhYFGNd78KlH4qiUlc4L4lWExzzy7PukH7kWY/GulZpnvsaOGTGpphJQV9drmWOmIL5yZDLhrHhRR6OOM6UDrSIwdXHJSGX0xKCh33toKfvlAUgS94CbflhR0sUppqNJfYgEtPLtdkhx+d9sgnWyuP9CF7sPV05ELX37Ue3SKoxtMVxXndSoljaA9uIV45ivU4teb/XtBXJndcEtnbkj+wGQG8TT/N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcHkQ5yS8GIfrrGp0Fg6MPJ9QCJJpOjHrmxUiFl9p+w=;
 b=JvoU+Mw8QkjORKkVg5ZBav1/EfHwv480TL1Vvjvb/rAVsNVroriiIclKlFsuby8ENzG75hmu2ihMJ9imwz2AR0miDN3EmORiH1uno9uPb0Q8qZLwH4J2g6vi0KmGpGiFN6Ca3MZY6rWyOBnPYQZSnhFgTdWS43krigGilhjAUVI=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:05 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::82) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:04 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:03 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: Emulate exporter->importer UALink messages in
 loopback
Date: Mon, 26 Oct 2026 18:59:25 -0400
Message-ID: <20261026230248.1597606-4-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026230248.1597606-1-mukul.joshi@amd.com>
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c1722e-ce58-408a-3277-08df33b54a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|10067099003|56012099006|261026140227099003|18002099003|22082099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: KeT8EEfATGWZiqM4hViF1FH/SQ52yGNdbBxQ6n1Yx+Mw0839OEbCIsfL6U3waQHg0A4jUIhVGNU2llC13IgcaYH9U5PCu8i/QoQ59/LnAaxQC4KajZqpMBRFrRd9HMPRV0lausCu/AT9B6mlXXfZ3sVcPLp2aTPZy4Bp3Et4ehVnScPJGHtmxPtJgVA0Yma8HZLpDW4POhX17abwG214X8w4fwTeaHfA0oS4eQSN90hy6A35zWaeSLKPRj8uKLwGs7zieAhWRaY+WWFTWoIKU7IijCxMuf7Be19Rl08YTy//KXM+Sz3ptGs1vjDVMUhmH9/AMmAKxgAWsdUCNvGUdoi7c6hqX6my6Oitxd/4E0rOiWW12whhXUxyuiwgV1Ymz/bB6WIGnNg39CmMlH2q9uWKSBcgWKj/bQGJoEQGKC57TNsK4ek6eKg4J5SwvAeOODG/UuA/ffbUUQwA4oa2DT95nsJHmDiP4dqD2pab8jOQl8scQ/MO6MoxSN7n9lygRVUU2y1T5ZLqq15ONKWCxb5DBtOfaQO1WFhI9+qsnGAkoJ1Hwcse8qLrD5aYrFa9fwYaKinSSHDNOj1xvtOHvQkZk35+Gjn2ETyIiSQqZxo6BawwTgTt9G8zwwodC+nVgoklk1uoyExWTpM2scP9YN2MqawXKIS3+vuDYTwcksRTbeXhgjh4UaaEYypwRGKFJsz98/fCDryTpD0xvM2q5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(18002099003)(22082099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iMuNJ0Sv9/fK8fhgNeeIg4BPGtIr1whzH+SV4KKYbOWmQvm7Z80koEHSzStehRdeUwzHadid61f+72u9fc0t0La2Du7QrMUiU5uXpv48b/x40KnOd+LvXKxJLQP1rlsj2sqW7gqw2/XPC3CswibY0j3NreUQw8mNc3dxpeSvKOCxhd1QunPBJRAJ8d2NDxPj8nxmeC6QKYoeV54cYDTNetqoVKmdDa1PTTT8NgNV++1U2/IZe1q/H8rA9BVJ3+oytYrTW9e2i+bJqWLuDXDzhqHrcxtzOtC+WInt1iQE8l31IsW9EK/L9xnwuR8CdejTNjV7Sq160IwoEpfl9eUT99shJlL//VifzcpILX13NNgYrK5ThapFXfidn59kgvzfgb7zZ8LDfEVX5l0xy8VQVCXL7cZRevly7z22oB5HcHgJunlEH148Bjr/8k+fDith
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:04.1488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c1722e-ce58-408a-3277-08df33b54a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 64a051242367..e40433bd79df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -59,6 +59,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
 					   u32 remote_accel_id);
 static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 					  u32 remote_accel_id);
+static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
+						 u32 sender_accel_id, u32 dw0,
+						 u32 dw1, u32 dw2, u32 dw3);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -6218,6 +6221,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_ualink_ring *ring;
 	int r;
 
+	/* UALink loopback: the single MP nHT can only deliver messages addressed
+	 * to the exporter accelerator. Messages addressed to the importer
+	 * (exporter->importer direction) cannot be delivered by HW, so emulate
+	 * them by feeding the message back into our own IRQ handler.
+	 */
+	if (adev->ualink.loopback.enabled &&
+	    remote_accel_id == adev->ualink.loopback.importer_accel_id)
+		return amdgpu_ualink_loopback_self_interrupt(adev,
+				adev->ualink.loopback.exporter_accel_id,
+				dw0, dw1, dw2, dw3);
+
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->interrupt;
 
@@ -6639,6 +6653,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
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

