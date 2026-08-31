Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B1FC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A213310EA97;
	Mon, 31 Aug 2026 18:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hwrzXrHZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39E710EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViN9FCe7RbmdqIoBWlSPjyBx/OVzij/HJ+ixo8LEczDWVi0zR8g8s4AsA228G9F7HvNS++2gEwgIsVEnKBVZ4dOA/nBGWjNPIhRzhH5WU9UuAFLQKhoXGpMKqaTcZQUYf/NCXCcJp1uVCWocenzE2H83/nOv7ICftFUjkqJAto8gn2lvYxHReTpXtYWklz8HQScCVuUcuTYFvvldp54e37gWCWZRYk198UFY0mSSFXCALYB3RF4PrNi90pZqGwwZWzBrskaFibOaYVDyzKlE2/3/FBRXQfTLYuOLoPJ5kAlVMgcxA2lYlI2Pin02nnzbUqXaEllzB0yhi/JyqWBEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s+k+NS+sDToctYdbBFk2gnus4IHDo1t1CJLrZxYZjs=;
 b=Jzv++heoYlW9dFS4HnPY9cNVGv3G7lIJwj3aBOb6QOZpaHTWO4DVY8xuV8HjnXm3uoc8a4RpFgRik2g/hedziU+wWbZeiVekeQqUrEx96SUwMlD3WsiyqtxRlZZzYF30K0WiWjlS5c6+PnSKXG5Dm5ywR91JIpsVcjXKltxtyozkQqpmqzw8n70fJBSu4m/vYJ4HSAvxp1UDSlAqcRFFMslBkrwsV+eLsHrBzpFUw4uW/fxreoJcFcSYwGBBPRWnaSo3mk21PGdKEAMfQ/zubpZiP6ge1sw+VUAtdhM8Q9Id0S+NlCiqqaoku6dPfSzTDxNy+x6gJ8nkbE8g1ucLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s+k+NS+sDToctYdbBFk2gnus4IHDo1t1CJLrZxYZjs=;
 b=hwrzXrHZ5OojM5VfEXf525NdIRBxystqsTjbJdRPGL7BKeSZ2ASjU/cEkNp5ZXz8yKzreK5dE+wbX/sFPLmi0AVmglKozsZvRYiSy1ACVNmZGiEQAYKjgnHQQ+aCDPPGr17FmOJqfgLzksF2htXN50RAwczTSaHXwPyapKAjSPs=
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:54 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::90) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 54/95] drm/amdgpu: Handle connection reset
Date: Mon, 31 Aug 2026 14:27:13 -0400
Message-ID: <20260831182754.1089811-55-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 20577d3f-17b7-4aef-8199-08df078db539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: kB/bx8z+Q6qiWluXdtBYlDE7OIILGx8I5Dphs8z9gb+Ejb7aCRNuP2QGVv5rnY+3iEU4yrSvmaT1pLlljcOCjxQ4fJcYSuAL82j8fjRgU4vsLuzEFdOqwG6ZILU+8CoDNs+Ntd77uprKAYAGYjmAbvd4S62G5SSocItaGTRBxqUW3y0+anLrTw2swJzq1R3ySLDNLVrqt9Foyltop0j3KXHSU5BjwdIFhe4QyMyX/F1GunarpRbDMf4CF6g0fqWk00JT4Kg92gpkuUhbK3AEf0uAU9mR2Sq1zsvtEC3gNo2Jdo0zPOOcDqJc1uLGhUU08VkFSh5EGHmlSgdHG9RMU+Q7Vy20GHEI0zJaxe4rDYAVHionoQRvoRfCOFs2yNwYE5LgYYuJrkB9ds8X1Zu8eKVI0C0A3ImsQungY2tNDMsEv/b/uOmv5wjBLIfLn2NzoisC9QJDDRGs2AdPLs0ktNZTmnmSH8XAJIj2vG+107eTHXbOEdgSJiXBR34bBgelhDdRn8JTRmCxgG2Ukz/9S6+ZHUa1ypZZDTzWqVGIl/Y1ZYbTCRIHMx2zJrOoXI9OCadoJ6JpCKPR4p81sYpLWGB2U/qAfyqACS4IBlbJ7v7Qw82+2lgY3F+cq3fe4GJ3AF+UjpUWT6EWRrL1gLBCvIrqBRKjT/ePB6PA5QBWkHSqZYIaM85E5EbG/XYta3/fEyeadSSUqWo3G0S2p4T9CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RfcfW2mZgOG3JlJLntOdbH4+Np4cFjy5HcXc7hQPH8p32JKf3azfcRjLu733l1Mm0VNRvIoZJFfdfLkGGKKojr/61A5HjSvbVOaflylHNjyHm81xBATF2UFLh3Ldkob/cJn8FUKuGAXONH++T361qudDDeyKipNhw8Y1p2vliEjFEmhaMqO1TvPoVqDWIS2QZzLx8O/ScF8opANznY2G9cNamiuUaXggoNW9e7mL2e9CIBJ2FOOeEzZaHf1/Jbg1ZVD/o/JRGsHnbf4UYn0Jg6Y7eQagybQ4z0SxAoOH3W3HMfdT/3znSx5Xr8joP+I7tojyPi3qqg1bfCivGbyeB3y3wHEFVqdhWWCIxecL6Vhe7Rwq6DuUzN2litnQT0QgoXcdIoJzq1IOfSeTfsyx3AVb3T/Z7mnW3ymMggmE1I8IfFSde5uevfPtT+UeDKEA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:52.1676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20577d3f-17b7-4aef-8199-08df078db539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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

This patch adds connection reset handling. There can be
two case which signal connection reset:
1. Receiving a HELLO message from a remote GPU, when the
   connection state is already setup, signals the remote
   GPU underwent a reset.
2. If no response received for a NPA-REQ/NPA_REVOKE
   message.

In either of the two case, we cleanup all exported and
imported ualink handles exchanged with the remote GPU.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 207 ++++++++++++++++++++-
 1 file changed, 202 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 9ece8c71c0627..17d64c222c0d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -43,6 +43,11 @@ static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
 						bool interruptible);
 static void amdgpu_ualink_unreserve_npa_vm_and_bos(struct amdgpu_device *adev,
 						   struct drm_exec *exec);
+static void amdgpu_ualink_handle_connection_reset(struct amdgpu_device *adev,
+						  u32 remote_accel_id, u32 state,
+						  u32 generation_count);
+static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo);
+
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
 
@@ -1648,6 +1653,7 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
 					   u32 src_acc_id)
 {
 	struct amdgpu_ualink_connection *conn_state;
+	u32 generation_count;
 	int r;
 
 	if (receiver_acc_id != adev->ualink.info->ppod.accel_id) {
@@ -1691,10 +1697,15 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
 	} else {
 		/* Set the connection state back to In Progress and revoke
 		 * all exports and release all imports corresponding to the
-		 * sender GPU. Added in later patches.
+		 * sender GPU.
 		 */
 		conn_state->state = AMDGPU_UALINK_CONN_PENDING;
+		generation_count = conn_state->generation_count;
 		mutex_unlock(&conn_state->lock);
+
+		amdgpu_ualink_handle_connection_reset(adev, sender_acc_id,
+						AMDGPU_UALINK_CONN_PENDING,
+						generation_count);
 	}
 
 	r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
@@ -1789,6 +1800,177 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 	return r;
 }
 
+static void amdgpu_ualink_cleanup_imp_xa_entries(struct amdgpu_device *adev,
+						 u32 remote_acc_id)
+{
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	struct list_head *imp_handles_list;
+	struct amdgpu_bo *bo;
+
+	dev_dbg(adev->dev,
+		"IMP-RESET: Cleaning up all XA entries for remote:%u\n",
+		remote_acc_id);
+
+	imp_handles_list = &adev->ualink.imp_handles_list[remote_acc_id];
+
+	xa_lock(&adev->ualink.imp_xa);
+	while (!list_empty(imp_handles_list)) {
+		imp_xa_node = list_first_entry(imp_handles_list,
+					struct amdgpu_ualink_imp_xa_node, list);
+		list_del_init(&imp_xa_node->list);
+		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+		xa_unlock(&adev->ualink.imp_xa);
+
+		dev_dbg(adev->dev,
+			"IMP-RESET: remote:%u handle:%llx:%llx npa:%llx size:%llx\n",
+			remote_acc_id, imp_xa_node->handle.handle_hi,
+			imp_xa_node->handle.handle_lo,
+			imp_xa_node->npa_addr, imp_xa_node->size);
+
+		bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
+		/* Invalidate the imported mappings */
+		amdgpu_ualink_invalidate_import_mappings(bo);
+
+		/* Drop the refcount for the node */
+		amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+		xa_lock(&adev->ualink.imp_xa);
+	}
+	xa_unlock(&adev->ualink.imp_xa);
+}
+
+static void amdgpu_ualink_cleanup_exp_xa_entries(struct amdgpu_device *adev,
+						 u32 remote_acc_id)
+{
+	struct amdgpu_ualink_importer_entry *importer_entry;
+	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	struct list_head *exp_handles_list;
+	struct drm_mm_node *mm_node;
+	u64 npa_addr, size;
+
+	/* Get the list head for the list containing all the handles
+	 * exported to this remote GPU.
+	 */
+	exp_handles_list = &adev->ualink.exp_handles_list[remote_acc_id];
+
+	dev_dbg(adev->dev,
+		"EXP-RESET: Cleaning up all XA entries for remote:%u\n",
+		remote_acc_id);
+
+	xa_lock(&adev->ualink.exp_xa);
+	while (!list_empty(exp_handles_list)) {
+		importer_entry = list_first_entry(exp_handles_list,
+					struct amdgpu_ualink_importer_entry, list);
+		list_del_init(&importer_entry->list);
+
+		exp_xa_node = importer_entry->parent;
+		if (!amdgpu_ualink_exp_xa_entry_get(exp_xa_node))
+			continue;
+
+		xa_unlock(&adev->ualink.exp_xa);
+		/* Clear the bit corresponding to this remote GPU in
+		 * the importer bitmap.
+		 */
+		if (!test_and_clear_bit(remote_acc_id,
+					exp_xa_node->importers_bitmap)) {
+			amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+			xa_lock(&adev->ualink.exp_xa);
+			continue;
+		}
+
+		mutex_lock(&exp_xa_node->node_lock);
+		size = amdgpu_bo_ngpu_pages(exp_xa_node->bo);
+		/* Unpin the BO */
+		if (likely(!amdgpu_bo_reserve(exp_xa_node->bo, true))) {
+			amdgpu_bo_unpin(exp_xa_node->bo);
+			amdgpu_bo_unreserve(exp_xa_node->bo);
+		} else {
+			dev_warn(adev->dev,
+				"EXP-RESET: BO reserve to unpin failed handle:%llx:%llx\n",
+				exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo);
+		}
+
+		dev_dbg(adev->dev,
+			"EXP-RESET: handle:%llx:%llx pin_count:%d, importers:%d\n",
+			exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
+			exp_xa_node->bo->tbo.pin_count,
+			bitmap_weight(exp_xa_node->importers_bitmap,
+			AMDGPU_UALINK_ACCEL_MAX));
+
+		WARN_ON(exp_xa_node->bo->tbo.pin_count <
+			bitmap_weight(exp_xa_node->importers_bitmap,
+			AMDGPU_UALINK_ACCEL_MAX));
+
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
+			npa_addr = importer_entry->npa_addr;
+			mm_node = importer_entry->mm_node;
+			mutex_unlock(&exp_xa_node->node_lock);
+
+			dev_dbg(adev->dev,
+				"EXP-RESET: Unmap NPA:%llx size: %llx remote:%u handle:%llx:%llx\n",
+				npa_addr, size, remote_acc_id,
+				exp_xa_node->handle.handle_hi,
+				exp_xa_node->handle.handle_lo);
+			amdgpu_ualink_unmap_npa_addr(adev, exp_xa_node->bo,
+						     npa_addr, size);
+			amdgpu_ualink_npa_free_va(adev, mm_node);
+			kfree(mm_node);
+
+			/* Reset the NPA addr and mm_node */
+			mutex_lock(&exp_xa_node->node_lock);
+			importer_entry->npa_addr = 0;
+			importer_entry->mm_node = NULL;
+		} else if (bitmap_empty(exp_xa_node->importers_bitmap,
+				AMDGPU_UALINK_ACCEL_MAX)) {
+			/* In Source-Aliasing mode, if there are no importers
+			 * for this handle, then we can unmap and free the
+			 * NPA address.
+			 */
+			mm_node = exp_xa_node->importer_entries[0].mm_node;
+			npa_addr = exp_xa_node->importer_entries[0].npa_addr;
+			mutex_unlock(&exp_xa_node->node_lock);
+
+			dev_dbg(adev->dev,
+				"EXP-RESET: Unmap NPA:%llx size: %llx handle:%llx:%llx\n",
+				npa_addr, size, exp_xa_node->handle.handle_hi,
+				exp_xa_node->handle.handle_lo);
+			amdgpu_ualink_unmap_npa_addr(adev, exp_xa_node->bo,
+						     npa_addr, size);
+			amdgpu_ualink_npa_free_va(adev, mm_node);
+			kfree(mm_node);
+			mutex_lock(&exp_xa_node->node_lock);
+			exp_xa_node->importer_entries[0].npa_addr = 0;
+			exp_xa_node->importer_entries[0].mm_node = NULL;
+		}
+
+		mutex_unlock(&exp_xa_node->node_lock);
+		xa_lock(&adev->ualink.exp_xa);
+		amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+	}
+	xa_unlock(&adev->ualink.exp_xa);
+}
+
+static void amdgpu_ualink_handle_connection_reset(struct amdgpu_device *adev,
+						u32 remote_acc_id, u32 state,
+						u32 generation_count)
+{
+	struct amdgpu_ualink_connection *conn_state;
+
+	conn_state = &adev->ualink.conn_state[remote_acc_id];
+
+	mutex_lock(&conn_state->lock);
+	if ((conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) &&
+	     (conn_state->generation_count == generation_count)) {
+		conn_state->state = state;
+		mutex_unlock(&conn_state->lock);
+
+		amdgpu_ualink_cleanup_imp_xa_entries(adev, remote_acc_id);
+		amdgpu_ualink_cleanup_exp_xa_entries(adev, remote_acc_id);
+	} else {
+		mutex_unlock(&conn_state->lock);
+	}
+}
+
 /* Set PTE.X = 1 for all importer entries to retry RPCs. */
 static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
@@ -2114,14 +2296,18 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 				      orig_importers_bitmap);
 
 	/* Warn about all importers that didn't respond back with
-	 * NPA-RELEASE message. This will trigger connection timeout
-	 * handling which is added later.
+	 * NPA-RELEASE message and trigger connection timeout handling.
 	 */
 	for_each_set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap,
-			 AMDGPU_UALINK_ACCEL_MAX)
+			 AMDGPU_UALINK_ACCEL_MAX) {
 		dev_warn(adev->dev,
 			"EXP-CLEANUP: handle:%llx:%llx NPA-RELEASE timeout from remote:%u\n",
 			handle.handle_hi, handle.handle_lo, remote_acc_id);
+		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+		amdgpu_ualink_handle_connection_reset(adev, remote_acc_id,
+						AMDGPU_UALINK_CONN_NOT_READY,
+						imp_entry->generation_count);
+	}
 
 free_node:
 	xa_erase(&adev->ualink.handle_invalid_xa, handle.handle_lo);
@@ -2793,6 +2979,7 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 				u32 remote_acc_id)
 {
 	struct amdgpu_ualink_handle handle = imp_xa_node->handle;
+	u32 generation_count;
 	int r;
 
 	/* First check if the connection is setup with the
@@ -2831,7 +3018,8 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 		dev_warn(adev->dev,
 			"IMPORT: NPA-RSP timeout from remote AccId:%u\n",
 			remote_acc_id);
-		return -ETIMEDOUT;
+		r = -ETIMEDOUT;
+		goto reset_conn;
 	}
 
 	/* If the NPA addr/size isn't filled with valid values, then either
@@ -2871,6 +3059,15 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 	xa_unlock(&adev->ualink.imp_xa);
 
 	return 0;
+
+reset_conn:
+	dev_dbg(adev->dev,
+		"IMPORT: Resetting connection for remote:%u\n", remote_acc_id);
+	generation_count = amdgpu_ualink_check_conn_ready(adev, remote_acc_id, 0);
+	amdgpu_ualink_handle_connection_reset(adev, remote_acc_id,
+					      AMDGPU_UALINK_CONN_NOT_READY,
+					      generation_count);
+	return r;
 }
 
 int amdgpu_ualink_import_handle(struct drm_device *dev,
-- 
2.55.0

