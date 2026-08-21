Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7795DC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB93110E347;
	Fri, 21 Aug 2026 19:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/MrwYdw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E0310E347
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgvKyH4VS/DL5Feqgf/oLeqpy6wDwoXw7lFyDBu3Jktot04YsePEqwdDGQNnrATwcT0OPkCsBWpx06FDnm+6ZIslBZIZXlwcKUTOGIc3HXLzE4QfBXPBDzedFqtr3oKI4Ec/TTQYxV/Sf/Lrq7rarbOLHEGJS2eL+rc/OXJzAj/iFPMGkzcuJx+heynkAuniOtSImOl7MRJeL1k9MA4HV7T5SP9qxF03NNuhHHSsHgq80Jg1v5TBdejkM+hZwdUYVuDNsPBKfsDWDb+qh55kQJ9f/v2cliqGMVm0i5CtLv9pk9l1k1ijwZnaAasrFVKdUeHjQjk/3jDz0WwzHWdNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQordwsBKt5JeDezaMhmWaeDKLe7qyCgdRDnHsPOGvw=;
 b=Fk+uktIEsVGHUTAyPbqTsdHg294JAUH6kP8hOziVSNqH5XWMnqGpK8+Nk9ApsC1FKvDJPD6+ozmBPDkWrd5BamPDxNSnHOGXQNxfih6qO260tK8mk4ayIoXV/lGmwTwiQYasIyUuMiKn6myyCvyGwitzPK4x+4ZWmdIxoi5YbhmkZAVKHurP2l8BF5aPYR7HmYnNx5V71m030X1QJjyoz3gL+y1iyLI+Yi0INdU7jKe5eXtST8kd8x9KH1K2RRO9ECPynSR1nT+HFNSAMzepP0IHAmPEgI8sn7afLZ94vco3dmub8kPFOaRe1TjKgiFmW/cMsZmieX8kzdkgOQTqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQordwsBKt5JeDezaMhmWaeDKLe7qyCgdRDnHsPOGvw=;
 b=M/MrwYdwWYguY36bigtHnWcP5LY4lEouXvLKciGEOGnJaIPiRvvc2xUvBxDAC3DXaDDb4hi92Bj3mCG4oav2qQDzUCK4rRmnvHDfRVzBE9yNZR7KBdNgmbUo11PPLeqqD45SI/2pjJWWQbwHVl2/MMSEnMjeTwc6KYQ4VDoLP6E=
Received: from CH2PR12CA0002.namprd12.prod.outlook.com (2603:10b6:610:57::12)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:11 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::71) by CH2PR12CA0002.outlook.office365.com
 (2603:10b6:610:57::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 88/95] drm/amdgpu: Cleanup UALink XA entries on manager stop
Date: Fri, 21 Aug 2026 15:34:51 -0400
Message-ID: <20260821193458.808626-89-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f83f6e-7345-4243-79a3-08deffbb7420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|22082099003|3023799007|10067099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gD4IHY+uK+IEzH1GhBihMx3Cb24mJ/GqVcyUWQvc5HoVabT83+sKLbIwjbbwlP7f++JzjDN2+e+tQiRpYrTMLT3eHDGvcu3+tvdP//vy/iEhlsw6UEX5iwlKjAWH9CE0cvZdC1NNCok0ZCYFHx4zo0nrWi95wiCpfTBcza4aViZfZMOjUcyK9VPTcIW1I1Se+lHBU+E4L6GLS1PXvzr/7WkJz2WgUn5sVF+vzQoCCnfDJyxwsiQkmD3YY+8am/Vpg0WyGhWpZ5Wd0KgPPvWHwyY8ro5WHHKCqG7SHu7p7fHmVbkF7+ABwTexDS/e9RUYJnc4eBH1h0X5SMamklOpHHScZTRrGJuQ0ofHaHGfUz22Bg0lOGjqsvbVw0t5HrvzLfAwZjPRlJ48apCDnFUmvWYgh7kRgpPeiYbF+Tf/V1QSCD6Earh0v3cw5zspibdrLgrmAZH+jDruyrn/3dV+5j0/K5pCv+p86uPoS6bwEIiXO2kH0mw8wpSA1xBvki06T1IGIxLp9/Ytu8zDA4qPUzS5dvK3e/gy5NYT+JO17Qn9EvFgc0Y3E/WLT4F/qAVUQ+K3KnYJ53oLYbjVndTy5DYqQbEuF6pRX9sH2vsGy/erRe0Pmy4lqqutDrQgxLtbHDUrEjWfrIZwnH3W79UAsUdV4HMA5DhNZjOI2idlS9iBUxEsNCB9oW9sCiS4HK5QnPT53WQxgoGbOTStmlLQLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(3023799007)(10067099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7d+5glb0tSgQLP1g5LAPYeTZuPUjMzgcI6yEI1D2HnfTr4wq+zBqspwkK6kO5CzDeYUWrMt1WgdkluP6xTVfkExNVSJU7ZUTiNEZMmAtTQlWt1jzwSRXkHsv2unLgAiQg5FBuCJ7ZcrAzs/LXvfG2dSnmxfixBr+/Y2bu0KZLPnQcXmsqBRS0QMY2On0iBYT59iT00kIIDDgXfq6vQBmC7P+glXkJOpjghZheO9UCdLzitXYVYeLluYGCbgKneTPx5FB1NNxjL2Hl9WPeomKsjnoYnIipqCFc0tQavLKaOODGSokfFNriYKok7bM/CHn8C7sBoxvKdmYKvprqiAVIpRjL5+fLPd7ZjEVbt9M/gfCq7Ms9Q/UBz9fXSasQ8D3EYMsR9Tv4g4iy3OXu4HgjAy9c0Yg6gKHb2UNQWHy+5qArh67padG46T3nAqWEly+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:10.5208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f83f6e-7345-4243-79a3-08deffbb7420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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

amdgpu_ualink_manager_stop() only called xa_destroy() on the exporter,
importer and handle-invalid xarrays, which frees the internal tree but
not the node objects. Entries still present at teardown thus leaked the
nodes, left NPA addresses mapped and kept exported BOs pinned.

Free the entries in all three xarrays explicitly, without exchanging any
NPA protocol messages (the F/W is already halted by
amdgpu_ualink_sw_fini()): mark connections down so the drained workers
and teardown take the message-free path, drain in-flight exporter
cleanup work to empty handle_invalid_xa, then free the remaining
importer and exporter entries before the NPA allocator is torn down.

Also factor the shared importer-node release into
amdgpu_ualink_release_imp_xa_node(), drop/drain stale remote interrupts
in the IRQ handler when the accelerator is not ACTIVE, and refuse outbound
messages in amdgpu_ualink_send_command() when not ACTIVE so an in-flight
cleanup worker cannot emit onto torn-down peer/SDMA state or block
waiting for a response that will never arrive.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 153 +++++++++++++++++++--
 1 file changed, 141 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index c4f253a7cb417..63164f83342b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2160,12 +2160,33 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 	return r;
 }
 
+/* Invalidate an importer node's mappings and drop its last ref (frees the
+ * node, dma-buf and GEM handle). Caller must have unlinked it from the
+ * per-remote list and must not hold the imp_xa lock.
+ */
+static void amdgpu_ualink_release_imp_xa_node(struct amdgpu_device *adev,
+				struct amdgpu_ualink_imp_xa_node *imp_xa_node)
+{
+	struct amdgpu_bo *bo;
+
+	dev_dbg(adev->dev,
+		"IMP-CLEANUP: handle:%llx:%llx npa:%llx size:%llx\n",
+		imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo,
+		imp_xa_node->npa_addr, imp_xa_node->size);
+
+	if (imp_xa_node->dmabuf) {
+		bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
+		amdgpu_ualink_invalidate_import_mappings(bo);
+	}
+
+	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+}
+
 static void amdgpu_ualink_cleanup_imp_xa_entries(struct amdgpu_device *adev,
 						 u32 remote_acc_id)
 {
 	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
 	struct list_head *imp_handles_list;
-	struct amdgpu_bo *bo;
 
 	dev_dbg(adev->dev,
 		"IMP-RESET: Cleaning up all XA entries for remote:%u\n",
@@ -2181,18 +2202,8 @@ static void amdgpu_ualink_cleanup_imp_xa_entries(struct amdgpu_device *adev,
 		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
 		xa_unlock(&adev->ualink.imp_xa);
 
-		dev_dbg(adev->dev,
-			"IMP-RESET: remote:%u handle:%llx:%llx npa:%llx size:%llx\n",
-			remote_acc_id, imp_xa_node->handle.handle_hi,
-			imp_xa_node->handle.handle_lo,
-			imp_xa_node->npa_addr, imp_xa_node->size);
-
-		bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
-		/* Invalidate the imported mappings */
-		amdgpu_ualink_invalidate_import_mappings(bo);
+		amdgpu_ualink_release_imp_xa_node(adev, imp_xa_node);
 
-		/* Drop the refcount for the node */
-		amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
 		xa_lock(&adev->ualink.imp_xa);
 	}
 	xa_unlock(&adev->ualink.imp_xa);
@@ -3815,13 +3826,114 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	return r;
 }
 
+/* Free every importer entry left in imp_xa at manager stop. */
+static void amdgpu_ualink_teardown_imp_xa_entries(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	unsigned long index;
+
+	xa_for_each(&adev->ualink.imp_xa, index, imp_xa_node) {
+		list_del_init(&imp_xa_node->list);
+		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+		amdgpu_ualink_release_imp_xa_node(adev, imp_xa_node);
+	}
+}
+
+/* Free a single exporter node at manager stop. This is the message-free
+ * portion of amdgpu_ualink_exp_cleanup_worker().
+ */
+static void amdgpu_ualink_teardown_exp_xa_node(struct amdgpu_device *adev,
+				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
+{
+	DECLARE_BITMAP(importers_bitmap, AMDGPU_UALINK_ACCEL_MAX);
+	struct amdgpu_bo *bo = exp_xa_node->bo;
+	u32 remote_acc_id;
+
+	bitmap_copy(importers_bitmap, exp_xa_node->importers_bitmap,
+		    AMDGPU_UALINK_ACCEL_MAX);
+
+	dev_dbg(adev->dev,
+		"EXP-STOP: handle:%llx:%llx importers bitmap: %*pbl\n",
+		exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
+		AMDGPU_UALINK_ACCEL_MAX, importers_bitmap);
+
+	if (!bitmap_empty(importers_bitmap, AMDGPU_UALINK_ACCEL_MAX)) {
+		amdgpu_ualink_unmap_all_npa_addr(adev, exp_xa_node);
+
+		/* Unlink importers and unpin the BO once per importer. */
+		if (likely(!amdgpu_bo_reserve(bo, true))) {
+			bo->ualink_handle_lo = 0ULL;
+			for_each_set_bit(remote_acc_id, importers_bitmap,
+					 AMDGPU_UALINK_ACCEL_MAX) {
+				list_del_init(&exp_xa_node->importer_entries[remote_acc_id].list);
+				amdgpu_bo_unpin(bo);
+			}
+			amdgpu_bo_unreserve(bo);
+		} else {
+			dev_warn(adev->dev,
+				"EXP-STOP: BO reserve to unpin failed handle:%llx:%llx\n",
+				exp_xa_node->handle.handle_hi,
+				exp_xa_node->handle.handle_lo);
+			for_each_set_bit(remote_acc_id, importers_bitmap,
+					 AMDGPU_UALINK_ACCEL_MAX)
+				list_del_init(&exp_xa_node->importer_entries[remote_acc_id].list);
+		}
+
+		amdgpu_ualink_free_all_npa_va(adev, exp_xa_node, importers_bitmap);
+	}
+
+	/* Release the export dma-buf and drop the BO ref. */
+	dma_buf_put(exp_xa_node->dmabuf);
+	amdgpu_bo_unref(&bo);
+	exp_xa_node->bo = NULL;
+
+	mutex_destroy(&exp_xa_node->node_lock);
+	kfree(exp_xa_node);
+}
+
+/* Free every exporter entry left in exp_xa at manager stop. These were
+ * exported but never revoked, so no cleanup worker was queued for them.
+ */
+static void amdgpu_ualink_teardown_exp_xa_entries(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	unsigned long index;
+
+	xa_for_each(&adev->ualink.exp_xa, index, exp_xa_node) {
+		xa_erase(&adev->ualink.exp_xa, index);
+		amdgpu_ualink_teardown_exp_xa_node(adev, exp_xa_node);
+	}
+}
+
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 {
 	int i;
 
 	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid, 0);
+
+	/* Mark connections down so the drained workers and the teardown below
+	 * take the message-free path in amdgpu_ualink_check_conn_ready().
+	 */
+	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++) {
+		mutex_lock(&adev->ualink.conn_state[i].lock);
+		adev->ualink.conn_state[i].state = AMDGPU_UALINK_CONN_NOT_READY;
+		mutex_unlock(&adev->ualink.conn_state[i].lock);
+	}
+
+	/* Drain in-flight exporter cleanup work so revoked nodes in
+	 * handle_invalid_xa free themselves and empty that xarray.
+	 */
+	drain_workqueue(adev->ualink.npa_wq);
+
+	/* Free live entries before the NPA allocator is torn down, so NPA
+	 * addresses can still be unmapped and freed.
+	 */
+	amdgpu_ualink_teardown_imp_xa_entries(adev);
+	amdgpu_ualink_teardown_exp_xa_entries(adev);
+
 	amdgpu_ualink_npa_mm_fini(adev);
 
+	/* All three xarrays are empty by now. */
 	xa_destroy(&adev->ualink.exp_xa);
 	xa_destroy(&adev->ualink.imp_xa);
 	xa_destroy(&adev->ualink.handle_invalid_xa);
@@ -5132,6 +5244,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	u64 src;
 	int r;
 
+	/* Refuse sends unless active */
+	if (adev->ualink.info->accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
+		return -ESHUTDOWN;
+
 	peer = &remote->peer[remote_accel_id];
 
 	/*
@@ -5686,6 +5802,7 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 				     struct amdgpu_iv_entry *entry)
 {
 	u32 sender_acc_id, receiver_acc_id, msg_type, src_acc_id;
+	enum amdgpu_ualink_accel_state accel_state;
 	struct amdgpu_ualink_handle handle;
 	u32 size, npa_addr, fail_reason;
 	u32 dw0, dw1, dw2, dw3;
@@ -5698,6 +5815,18 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		return handled;
 	}
 
+	/* Only handle interrupts while ACTIVE. Otherwise (e.g. during teardown)
+	 * consume stale ring entries but drop them, so they don't touch state
+	 * being freed.
+	 */
+	accel_state = adev->ualink.info->accel_state;
+	if (accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
+		dev_dbg(adev->dev,
+			"Dropping stale UALink interrupt, accel_state %d\n",
+			accel_state);
+		return handled;
+	}
+
 	dev_dbg(adev->dev, "%s client_id 0x%x src_id 0x%x ih\n",
 		entry->ih == &adev->irq.ih ? "ring" : "ualink soft ring",
 		entry->client_id, entry->src_id);
-- 
2.55.0

