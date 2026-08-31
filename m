Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE371C624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE85510EA66;
	Mon, 31 Aug 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GofAVACf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00F010EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDqiNGPeImcfZ+yUsTXxs+BTVtGahcTwlS/V1kNK5qBFHcY7dhJH4bee9EecC21Rcx4Evgg9sWZgeoJhkCOiO6ZykT9vL64yJJiAXl8uqzSxKFLu7R9JY7/VmG+qilxw8bTS5opyNy64GuJ94YbgmKX5zhsZYhkrQQNZGg05k/WmlzbPHiEr7Q0rGbS/+QtI0F1voQDfAfYwpMT5OV8O1DorkVbDRSPgZ8hFRbBeDQw7VrR5KfpzZDsR1Sjvq09X9TzkmeoTOLYxjWFJzGCTZgQ3SPz8R/kh5seYzLPDXchauwLzhWg5+ajXb2LBV0pIlFH/7B0eheM6R58uAyIfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1sAn0Yd8goCSxjJzpTU+p+6mcrY1f/OWuhpBpiFM4o=;
 b=f2l5+urcl5yLWCkowvPpBu/yexwrEBTiOCX5aUXo7KJzFXmZpSHVIkooOk8g8Ov+b32kjLXia1yx7qLdYOUyNKmBtvDtLij0uaP3eL3+NksFx8LGWYRuwL3YnL3TzZD/d2gIqd21iEijITFDcL0FXfSgjl5WtOmGW7N5IcphdtFumqX+15CFycV3/F+9uxc0ZZhDyD+XbIbzKDyDHayF3a42Ny8langGVuD8cOV0cSLpBE97ntZ0agHpaK6ZazGSyRt4M9EF0FJxxdeA48lhPXKAB19l499k3y48FX33XtQ8KpPoOl0Njy8NC+WbUXPdUKb8lNr/ou+sKNc8/nYvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1sAn0Yd8goCSxjJzpTU+p+6mcrY1f/OWuhpBpiFM4o=;
 b=GofAVACfKt8ILxo85qzWf4gMhzYeJvTTUu3MNLAJaXmoUyJKREU43fycQn5tm1+mEoV/mIBu+BXC+8hSP1BoGthYMJbB7YrFJ1MzNocKSSLLTKSHPg7TLHVuGARsfymOORZZNzOnBwabdzzWCBGk1nTSPQpQffQDWIMpF5GuhUQ=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by CH8PR12MB9743.namprd12.prod.outlook.com (2603:10b6:610:27a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:56 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::38) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 56/95] drm/amdgpu: Add handling for remote interrupts
Date: Mon, 31 Aug 2026 14:27:15 -0400
Message-ID: <20260831182754.1089811-57-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH8PR12MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cae8f23-abb9-402c-8dde-08df078db7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0fjmRJfBHIyuh2Kk2SbDh1jq1HuOX1k6J/5d9TzGhgKGChCDxtScLHUxkSS3jHvvNBeP/XKICh6wRSIpratzBv7zK62vZSnTBtXRw0xJOBHfo5BcjeCRsDbMPDK9U3w8zY6bvcOpjhZqf5jPiEupy1Ke5JUAKH0uVirKEQMAX9R/VRySCj9oTERfiL7R3qbLH5Ke5RJt2N5cScW7YVH14rd2rigpTf9AxH/OlhQnh/ak0FEZayuTAkDlm66Z6aZKUGOpTz/7N8ARSEGMYi9SQ/SHOej7wvZYPEyVgG7tCnVOH+zB2I892UNLNZ9VcutjRgGwJikVSt6ZZX4nrhoOSJv7NUmHA/myNe6BLkUKzjcLkBF23fX3FxM6Mw7ZrVK3v1n4GWHHqcw+Zt+nTAeVTDypp2bd55DnDydBCIqMnU1CpelgvjRRrb3FusNHpVWLXC++gM60omqalnxMPK6pOgTcIvaSzAOHQnLUZMMx35dZye8Xon5D+j8X4u35UpvaBdmbvBaJD3v54ZewHhBZV0pzmvD6tcqeDONk1rXoPiHPQiAVGKD4LaeZS51QED2K2UCetF0f0noB95zV14UJMX7gjOrog3YoLCseEeYFJTnkwvi2i0+jcF5js/pf5RAde+HcMPERXlLtt0+aKHAuuCP6g1tp5r4QIrUgRH18ju3SX91fWMIEeihblb1+gPRwjD3NQXsX2PFVX/RMfsIj7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E6fmSjb8YOpoQkcL2FLHQCnyrSalArVRDdD4k9jjwGMoAlPr+OMGdJG1NftA30cR0OGbGu27fKOqf2NougUxeN0Deap8KhBc/BZ0olEeFuDfvtapK/Tx8isElOXVMnPgA9sgm0NJSuUZ4/1zmETDvc060AzpOAp/o3iOPCKFUvtXgRJtDwqUghbJVmMIYjh9z6LPjDAOn9vgMQ4gyCsHByQ2Laf65XjgVu4tOG5SnpYExmRCn8VneMxL6SMN9qIRXi8VsiU/RQHYu06a8gHvU2562ZN3guZ2do3/RAkHt78VmcGAXv7W5cFz1hIBvYX762vUX4S1O8pxT5zVbDWaEOoUICOf4KDeRUr5X65CKbPUiqNF9jDJVrJkHpv4Usf+FA+28ptmVYy8UfhBmxg9wX0p1aCNCHxlEmuWcTlON3nv5ErdVQpKUijExspCM7Au
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:56.8090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cae8f23-abb9-402c-8dde-08df078db7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9743
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

Add interrupt handling to process the NPA remote interrupts.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 114 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 17d64c222c0d9..762713194bb6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5239,10 +5239,31 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev->ualink.remote = NULL;
 }
 
+int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
+}
+
+/*
+ * The low bits of handle_lo carry the message-header field on the wire.
+ * Strip those bits and splice in @acc_id to recover the
+ * fully-qualified handle_lo value.
+ */
+static inline u64 amdgpu_ualink_reassemble_handle(u64 handle_lo, u32 acc_id)
+{
+	return (handle_lo & ~AMDGPU_UALINK_MESSAGE_HEADER_MASK) |
+	       (acc_id & AMDGPU_UALINK_HANDLE_ACCID_MASK);
+}
+
 static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 				     struct amdgpu_irq_src *source,
 				     struct amdgpu_iv_entry *entry)
 {
+	u32 sender_acc_id, receiver_acc_id, msg_type, src_acc_id;
+	struct amdgpu_ualink_handle handle;
+	u32 size, npa_addr, fail_reason;
+	u32 dw0, dw1, dw2, dw3;
+	u32 local_acc_id;
 	int handled = 1;
 
 	dev_dbg(adev->dev, "%s client_id 0x%x src_id 0x%x ih\n",
@@ -5256,10 +5277,95 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		return handled;
 	}
 
-	/*
-	 * Call amdgpu_ualink_interrupt handler
-	 * amdgpu_ualink_interrupt(adev, entry);
-	 */
+	/* ContextID 4 dwords */
+	src_acc_id = entry->pasid;
+	dw0 = entry->src_data[0];
+	dw1 = entry->src_data[1];
+	dw2 = entry->src_data[2];
+	dw3 = entry->src_data[3];
+
+	dev_dbg(adev->dev, "src accel_id %u context id 0x%x 0x%x 0x%x 0x%x\n",
+		src_acc_id, dw0, dw1, dw2, dw3);
+
+	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
+	local_acc_id = adev->ualink.info->ppod.accel_id;
+	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
+		src_acc_id, msg_type);
+
+	switch (msg_type) {
+	case AMDGPU_UALINK_HELLO_MSG:
+		receiver_acc_id = (dw0 >> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT) &
+					AMDGPU_UALINK_HELLO_MSG_ACCID_MASK;
+		sender_acc_id = (dw0 >> AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT) &
+					AMDGPU_UALINK_HELLO_MSG_ACCID_MASK;
+		dev_dbg(adev->dev,
+			"Got HELLO MSG: src acc_id %u receiver_acc_id %u sender_acc_id %u\n",
+			src_acc_id, receiver_acc_id, sender_acc_id);
+		amdgpu_ualink_process_hello_msg(adev, receiver_acc_id, sender_acc_id,
+						src_acc_id);
+		break;
+	case AMDGPU_UALINK_HELLO_ACK_MSG:
+		dev_dbg(adev->dev,
+			"Got HELLO-ACK MSG: remote acc_id %u\n", src_acc_id);
+		amdgpu_ualink_process_hello_ack_msg(adev, src_acc_id);
+		break;
+	case AMDGPU_UALINK_NPA_REQ_MSG:
+		memcpy(&handle, entry->src_data, sizeof(struct amdgpu_ualink_handle));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   local_acc_id);
+		dev_dbg(adev->dev,
+			"Got NPA-REQ MSG: remote acc_id %u handle %llx:%llx\n",
+			src_acc_id, handle.handle_hi, handle.handle_lo);
+		amdgpu_ualink_process_npa_req_msg(adev, src_acc_id, handle);
+		break;
+	case AMDGPU_UALINK_NPA_RSP_MSG:
+		memcpy(&handle.handle_lo, entry->src_data, sizeof(handle.handle_lo));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   src_acc_id);
+		size = entry->src_data[2];
+		npa_addr = entry->src_data[3];
+		dev_dbg(adev->dev,
+			"Got NPA-RSP MSG: remote acc_id %u handle_lo %llx size 0x%x npa_addr 0x%x\n",
+			src_acc_id, handle.handle_lo, size, npa_addr);
+		amdgpu_ualink_process_npa_rsp_msg(adev, src_acc_id,
+						  handle.handle_lo,
+						  npa_addr, size);
+		break;
+	case AMDGPU_UALINK_NPA_FAIL_MSG:
+		memcpy(&handle.handle_lo, entry->src_data, sizeof(handle.handle_lo));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   src_acc_id);
+		fail_reason = entry->src_data[2] &
+				AMDGPU_UALINK_NPA_FAIL_MSG_FAIL_REASON_MASK;
+		dev_dbg(adev->dev,
+			"Got NPA-FAIL MSG: remote acc_id %u handle_lo %llx fail_reason %u\n",
+			src_acc_id, handle.handle_lo, fail_reason);
+		amdgpu_ualink_process_npa_fail_msg(adev, src_acc_id,
+						   handle.handle_lo,
+						   fail_reason);
+		break;
+	case AMDGPU_UALINK_NPA_REVOKE_MSG:
+		memcpy(&handle, entry->src_data, sizeof(struct amdgpu_ualink_handle));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   src_acc_id);
+		dev_dbg(adev->dev,
+			"Got NPA-REVOKE MSG: remote acc_id %u handle %llx:%llx\n",
+			src_acc_id, handle.handle_hi, handle.handle_lo);
+		amdgpu_ualink_process_npa_revoke_msg(adev, src_acc_id, handle);
+		break;
+	case AMDGPU_UALINK_NPA_RELEASE_MSG:
+		memcpy(&handle, entry->src_data, sizeof(struct amdgpu_ualink_handle));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   local_acc_id);
+		dev_dbg(adev->dev,
+			"Got NPA-RELEASE MSG: remote acc_id %u handle %llx:%llx\n",
+			src_acc_id, handle.handle_hi, handle.handle_lo);
+		amdgpu_ualink_process_npa_release_msg(adev, src_acc_id, handle);
+		break;
+	default:
+		dev_err(adev->dev, "Unknown message type (%u)\n", msg_type);
+		break;
+	}
 
 	return handled;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 8aee16ad39e9a..b143a496b4dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -39,6 +39,7 @@ struct amdgpu_device;
 
 #define AMDGPU_UALINK_HANDLE_ACCID_MASK			GENMASK_ULL(9, 0)
 #define AMDGPU_UALINK_MESSAGE_HEADER_MASK		GENMASK_ULL(9, 0)
+#define AMDGPU_UALINK_HELLO_MSG_ACCID_MASK		GENMASK_U32(9, 0)
 #define AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT	10
 #define AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT	20
 #define AMDGPU_UALINK_NPA_FAIL_MSG_FAIL_REASON_MASK	GENMASK_U32(7, 0)
@@ -344,6 +345,8 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
+int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_init(struct amdgpu_device *adev);
-- 
2.55.0

