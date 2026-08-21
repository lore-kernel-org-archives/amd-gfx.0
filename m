Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8DAC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B230710F4BB;
	Fri, 21 Aug 2026 19:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ryKITkE/";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F2210F4A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQxBPlvNQxeiQTSww/HEO5J3PyqkICXXHJQqx4T9uf+X5S+8IQ8VrZxQlIK8TwpLwyY6c62Op22MLaz6lnWOvOTRV6PgDjglrE9K8X0fjhZBWGCpfMUPyta1t7y7tLWyhS7HeqmgkLAw3arObqiCHwvt8z66MIElRbrLGlmjRfNyoRLkn7ckJNp3CXmTEH4fDC/iHAISEf7XNZxuK/mwGpdZDuBfnVgIzBeI3etPoKGuOQdziSPvBk0NiKBg31wR5h4kQtC5zvQIe+ceoSE1AalqG0oTXFVleVUSMV4tF1DmRUtEky94UXxCdPdZvUcaFifKKDFZRea/3hgWwD2Ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHVhyWqauLP7pH5ny6W3GQIU4JOEMpzhENkNf/rt8n8=;
 b=WVuif25yot+xUpIcjU2kuC/iw55VJCYncJ4AZsVwyJu//AWnLaCU9MwlbW4kwcPOA5kUdiCoKi5pTaJ7XXdpqJtsy6orpVjPZ6VvzJ2tZJuJoZbjiptRiZGobAq1NaLbDiNMHvDm4Zkzqnjur9c7YW96JUctNJSepKCa6EgLMIjYF32zlcSxc65DJVc+gcNZ726SLhMBUOO9oMYeA0e2xhNn3yo4KkQSVNer/MHnPWXW/8LkYapRk0Xb7rAukKusz1WyRcmEALsh0kU0vTQrFLPOaoyAIB5bmm7CLAlNNiW1OWU3a4HXLYT6rOGrMLIiwLt1HeyhDKvsc4IJe+c77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHVhyWqauLP7pH5ny6W3GQIU4JOEMpzhENkNf/rt8n8=;
 b=ryKITkE/F2FUJMnu6pAuW8xd8RKYNW8AqQ6pEsyygBrKj28Gh9VPCS3a3rfz0lKl66JgksGn2bBpIBnGWWQx+yEKpQMh4ZtRrtNhnxhToX+KGQK2gcRNGyRMH4MbLQayc2v8FrIydNEhb86UkTA0xXron//Q5sujKIjM1d5fRYs=
Received: from CH0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:76::28)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:49 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::30) by CH0PR04CA0023.outlook.office365.com
 (2603:10b6:610:76::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 49/95] drm/amdgpu: Implement UALink handle import ioctl
Date: Fri, 21 Aug 2026 15:34:12 -0400
Message-ID: <20260821193458.808626-50-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebf58ab-f73f-4742-c0c0-08deffbb67ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|3023799007|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eG4cXBMgHrKMR95I8FAfwO2cWGx/oj+q6csJynZtehQ/zxfNtLwoAiItHQsTt79c0kfPmRrKkx+OIvOqXD2xhSI0yxxirBEjO+QU12tTqFIXUFuFq8IHY5QSKisbkMgOXHsrzxk1KZ3EMQcRU7fzqxZZxavUJJbXttPyuhPSSEVLXZ5GtP/yM9oO/NTTLtCce6F5BqD4zyo5qSo4AdeiuEP28gXUonCUkeYQYzc0PjgHPL2UbSA1JxaYnJ7ykqPkQlKgSFSyOyh6jjYwzFj6QL+9WrB/DnnMO5kKFKXlwKEsS/hIRHud/FJ7Z7D3WMhjCM5EK94pPGxIvxIdoHrrx+HQpCFsY8A7MAc7qb+D25j7LCR5k6cuRYbwy/cT0hQpUQCxwN8SS4AMbTFDvyTQSHCz5ngztuJSZf31SQQgstJ3BwPFUpDZB789aUWVKNwVftApQ1a8qcmZx8kG6imroPfc34Gxp+AeypVrJS0GFA1h4ivuzj3avRnAxJYEXP/S9wk+GcWCkam6hdhQ3e3YUWPGwLEtPgJsqPHgHhzMlKCgZ8ZaMZkTXMusWAo2XHmtmBjqXe6sgsKu6eDFTvlOh1eFspA3rvrmpTYJ6LUldN00U+3ELE7EgnJPrwF+mK7Fb1vvD192NHxCJoiXMgd4bryZlX9aFYWA5bKa23snKxqyukMXON32KddMc4CTYuEny+NJ0M1Is7RucA31mn5Nyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +837St57+08G1k2K61Oqw484cVSIE4s+kryymo2AtIri4nvTab/Dw+LONx9GR1GJEMbNCzw2agL15Lc4xyP8hmZGkqyV+NQyvbHzxbEPQMGAxl6c/nW6y0tygTLKXrWdeG+r+IgaP6z0VDf6h3B373NQKSovaSl0xpRmcl/WHMZyCVbzVKLwaeyT3au/VW7qOyjeEIJ5ExT85zrn+yUTvjXbc4LlezeaoSnuNzlFVXItFbjkX9d63bWe3VW2XKOIfowiays0GMVKmkDmc1rL1Co0NFIA6t64Q1woaXgm/jXmBnJL15NRpCD1PewTg+ZYkleq1Fua3b2bMyijLyIB21IWKRWqOyf8zcLqNdYRPkkMRD8V9cHDD9CROxf0P97zuXiNz3EGbbo9gNoh21SJwMqSwXmmkDgL0bQM0GTAG4X7/UtsgrcW6jbayzA3o+tg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:49.6190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebf58ab-f73f-4742-c0c0-08deffbb67ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602
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

The ualink handle import process involves NPA protocol
message exchange between the exporting and the importing
GPUs in the rack scale setup. The process is as follows:
1. On the importing GPU, check if connection is already setup
   with the exporting GPU. If not, then exchange HELLO/HELLO_ACK
   messages to setup the connection.
2. Once the connection is setup, then exchange NPA-REQ/NPA-RSP
   messages with the exporter GPU to get the NPA address and size
   of the BO associated with the ualink handle.
3. On the exporter GPU, upon receipt of NPA-REQ message, do basic
   validation to check the ualink handle is valid. If not, send a
   NPA-FAIL message back. If its valid, then using the address
   allocator, allocate a NPA address, map it into the NPA VM and
   send back the address and size in the NPA-RSP to the importing GPU.
4. On the importer GPU, upon receipt of NPA-RSP message, allocate a NPA
   BO at the NPA address received in the NPA-RSP message.
5. Finally, generate the corresponding DMABuf for the NPA BO and return
   the dmabuf to user-space.
6. We are using refcount to keep track of the importer/exporter xarray
   entries. The cleanup functions for these are added in the subsequent
   patches.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 900 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  73 ++
 2 files changed, 973 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 9ef67d10aa963..60080271b3bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -35,6 +35,20 @@ static void deactivate_accelerator(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 				u32 remote_accel_id, u32 dw0, u32 dw1,
 				u32 dw2, u32 dw3);
+static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
+				    u32 flush_type);
+static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
+						struct amdgpu_bo *bos[], u32 n_bos,
+						struct drm_exec *exec,
+						bool interruptible);
+static void amdgpu_ualink_unreserve_npa_vm_and_bos(struct amdgpu_device *adev,
+						   struct drm_exec *exec);
+#define STRIP_NPA(addr)						\
+	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
+
+#define GENERATE_NPA(addr, remote_acc_id)			\
+		((u64)(((u64)(addr)) |				\
+		 ((u64)(remote_acc_id) << AMDGPU_UALINK_NPA_ADDR_GPUID_SHIFT)))
 
 static const struct drm_client_funcs ualink_client_funcs = {
 	.unregister	= drm_client_release,
@@ -1209,6 +1223,222 @@ static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
 		handle->handle_hi, handle->handle_lo);
 }
 
+static void amdgpu_ualink_cleanup_exp_xa_node(struct kref *ref)
+{
+}
+
+static void amdgpu_ualink_cleanup_imp_xa_node(struct kref *ref)
+{
+}
+
+static int amdgpu_ualink_exp_xa_entry_get(struct amdgpu_ualink_exp_xa_node *exp_xa_node)
+{
+	return kref_get_unless_zero(&exp_xa_node->refcount);
+}
+
+static void amdgpu_ualink_exp_xa_entry_put(struct amdgpu_ualink_exp_xa_node *exp_xa_node)
+{
+	kref_put(&exp_xa_node->refcount, amdgpu_ualink_cleanup_exp_xa_node);
+}
+
+static int amdgpu_ualink_imp_xa_entry_get(struct amdgpu_ualink_imp_xa_node *imp_xa_node)
+{
+	return kref_get_unless_zero(&imp_xa_node->refcount);
+}
+
+static void amdgpu_ualink_imp_xa_entry_put(struct amdgpu_ualink_imp_xa_node *imp_xa_node)
+{
+	kref_put(&imp_xa_node->refcount, amdgpu_ualink_cleanup_imp_xa_node);
+}
+
+static int amdgpu_ualink_send_npa_fail_msg(struct amdgpu_device *adev,
+				    u32 remote_acc_id,
+				    struct amdgpu_ualink_handle handle,
+				    u32 fail_reason)
+{
+	u32 dw0, dw1, dw2, dw3;
+
+	dw0 = lower_32_bits(handle.handle_lo);
+	dw0 &= ~AMDGPU_UALINK_MESSAGE_HEADER_MASK;
+	dw0 |= AMDGPU_UALINK_NPA_FAIL_MSG;
+
+	dw1 = upper_32_bits(handle.handle_lo);
+	dw2 = fail_reason & 0xFF;
+	dw3 = 0;
+
+	dev_dbg(adev->dev, "SEND NPA-FAIL: remote_acc_id %u handle 0x%llx:%llx dw[0-3] 0x%x 0x%x 0x%x 0x%x\n",
+		remote_acc_id, handle.handle_hi, handle.handle_lo, dw0, dw1, dw2, dw3);
+
+	return amdgpu_ualink_remote_interrupt(adev, remote_acc_id, dw0, dw1,
+					      dw2, dw3);
+}
+
+static int amdgpu_ualink_send_npa_rsp_msg(struct amdgpu_device *adev,
+					  u32 remote_acc_id,
+					  struct amdgpu_ualink_handle handle,
+					  u32 npa_addr, u32 size)
+{
+	u32 dw0, dw1, dw2, dw3;
+
+	dw0 = lower_32_bits(handle.handle_lo);
+	dw0 &= ~AMDGPU_UALINK_MESSAGE_HEADER_MASK;
+	dw0 |= AMDGPU_UALINK_NPA_RSP_MSG;
+
+	dw1 = upper_32_bits(handle.handle_lo);
+	dw2 = size;
+	dw3 = npa_addr;
+
+	dev_dbg(adev->dev, "SEND NPA-RSP: remote_acc_id %u handle %llx:%llx dw[0-3] 0x%x 0x%x 0x%x 0x%x\n",
+		remote_acc_id, handle.handle_hi, handle.handle_lo, dw0, dw1, dw2, dw3);
+
+	return amdgpu_ualink_remote_interrupt(adev, remote_acc_id, dw0, dw1,
+					      dw2, dw3);
+}
+
+static int amdgpu_ualink_send_npa_req_msg(struct amdgpu_device *adev,
+					  u32 remote_acc_id,
+					  struct amdgpu_ualink_handle handle)
+{
+	u32 dw0, dw1, dw2, dw3;
+
+	dw0 =  lower_32_bits(handle.handle_lo);
+	dw0 &= ~AMDGPU_UALINK_MESSAGE_HEADER_MASK;
+	dw0 |= AMDGPU_UALINK_NPA_REQ_MSG;
+
+	dw1 = upper_32_bits(handle.handle_lo);
+	dw2 = lower_32_bits(handle.handle_hi);
+	dw3 = upper_32_bits(handle.handle_hi);
+
+	dev_dbg(adev->dev, "SEND NPA-REQ: remote_acc_id %u handle 0x%llx:%llx dw[0-3] 0x%x 0x%x 0x%x 0x%x\n",
+		remote_acc_id, handle.handle_hi, handle.handle_lo, dw0, dw1, dw2, dw3);
+
+	return amdgpu_ualink_remote_interrupt(adev, remote_acc_id, dw0, dw1,
+					      dw2, dw3);
+}
+
+static int amdgpu_ualink_send_tlb_shootdown(struct amdgpu_device *adev,
+					    u32 remote_acc_id)
+{
+	return 0;
+}
+
+static u64 amdgpu_ualink_get_export_pte_flags(struct amdgpu_device *adev,
+				       struct amdgpu_bo *bo,
+				       u64 mapping_flags)
+{
+	u64 pte_flags = adev->gmc.init_pte_flags;
+
+	pte_flags |= (AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE |
+		      AMDGPU_PTE_WRITEABLE);
+	mapping_flags |= AMDGPU_VM_MTYPE_DEFAULT;
+
+	amdgpu_gmc_get_vm_pte(adev, &adev->ualink.npa_vm, bo, mapping_flags,
+			      &pte_flags);
+
+	return pte_flags;
+}
+
+static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
+					struct amdgpu_bo *bo,
+					u64 npa_addr, u64 size)
+{
+	uint64_t pte_value = adev->gmc.noretry_flags;
+	struct amdgpu_bo *bos[] = { bo };
+	struct dma_fence *fence;
+	struct drm_exec exec;
+	int r;
+
+	amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+
+	r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false, false, true,
+				false, NULL, npa_addr, npa_addr + size - 1,
+				pte_value, 0, 0, NULL, NULL, &fence);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
+		goto out;
+	}
+
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed %d to update page directories during unmapping NPA: 0x%llx\n",
+			r, npa_addr);
+		goto out;
+	}
+
+	if (fence) {
+		r = dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		fence = NULL;
+		if (r)
+			goto out;
+	}
+
+	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+out:
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+
+	return r;
+}
+
+static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
+				u64 size, struct amdgpu_bo *bo, u64 offset,
+				u64 pte_flags)
+{
+	struct amdgpu_vm *vm = &adev->ualink.npa_vm;
+	struct amdgpu_bo *bos[] = { bo };
+	struct dma_fence *fence = NULL;
+	struct drm_exec exec;
+	int r;
+
+	amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+
+	r = amdgpu_vm_update_range(adev, vm, false, false, true,
+				false, NULL, npa_addr, npa_addr + size - 1,
+				pte_flags, offset, adev->vm_manager.vram_base_offset,
+				bo->tbo.resource, NULL, &vm->last_update);
+	if (r) {
+		dev_warn(adev->dev,
+			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
+		amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+		goto out;
+	}
+
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r) {
+		dev_err(adev->dev,
+			"failed %d to update page directories for NPA: 0x%llx\n",
+			r, npa_addr);
+		amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+		goto unmap_npa;
+	}
+
+	fence = dma_fence_get(vm->last_update);
+	if (fence) {
+		r = dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		fence = NULL;
+		if (r) {
+			pr_debug("failed %d to dma fence wait\n", r);
+			amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+			goto unmap_npa;
+		}
+	}
+
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+
+	/* TLB flush may be needed after updated page directories */
+	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+
+	return 0;
+
+unmap_npa:
+	amdgpu_ualink_unmap_npa_addr(adev, bo, npa_addr, size);
+out:
+	return r;
+}
+
 static int amdgpu_ualink_send_hello_ack_msg(struct amdgpu_device *adev,
 					    u32 remote_acc_id)
 {
@@ -1436,6 +1666,676 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 {
 }
 
+static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
+				struct amdgpu_ualink_imp_xa_node *imp_xa_node)
+{
+	u64 alloc_flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS, npa_addr, size;
+	struct ttm_operation_ctx ctx = { false, false };
+	u32 initial_domain = AMDGPU_GEM_DOMAIN_CPU;
+	struct drm_gem_object *gobj = NULL;
+	struct dma_buf *dmabuf;
+	struct amdgpu_bo *bo;
+	u32 handle;
+	int r;
+
+	npa_addr = imp_xa_node->npa_addr;
+	size = imp_xa_node->size;
+
+	dev_dbg(adev->dev, "Create NPA BO addr 0x%llx size in pages 0x%llx\n",
+		npa_addr, size);
+
+	/* TODO: Check if this needs to be on a xcp_id basis */
+	r = amdgpu_gem_object_create(adev, size * AMDGPU_GPU_PAGE_SIZE, 1,
+				     initial_domain, alloc_flags,
+				     ttm_bo_type_device, NULL, &gobj, 0);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to create NPA BO in CPU domain. ret %d\n", r);
+		return r;
+	}
+
+	bo = gem_to_amdgpu_bo(gobj);
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_NPA);
+
+	bo->placements[0].fpfn = npa_addr;
+	bo->placements[0].lpfn = npa_addr + size;
+
+	r = amdgpu_bo_reserve(bo, false);
+	if (unlikely(r != 0)) {
+		dev_err(adev->dev, "Failed to reserve NPA BO, r: %d\n", r);
+		goto err_reserve_failed;
+	}
+
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	amdgpu_bo_unreserve(bo);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to validate BO in NPA domain, r: %d\n", r);
+		goto err_validate_failed;
+	}
+
+	r = drm_gem_handle_create(adev->ualink.client.file, gobj, &handle);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to get handle for NPA GEM object, r: %d\n", r);
+		goto err_validate_failed;
+	}
+	drm_gem_object_put(gobj);
+
+	dmabuf = drm_gem_prime_handle_to_dmabuf(&adev->ddev, adev->ualink.client.file,
+						handle, DRM_CLOEXEC | DRM_RDWR);
+	if (IS_ERR(dmabuf)) {
+		r = PTR_ERR(dmabuf);
+		dev_err(adev->dev,
+			"Failed to generate DMABuf for NPA GEM object\n");
+		goto err_dmabuf_failed;
+	}
+
+	imp_xa_node->dmabuf = dmabuf;
+	imp_xa_node->gem_handle = handle;
+
+	return 0;
+
+err_dmabuf_failed:
+	drm_gem_handle_delete(adev->ualink.client.file, handle);
+	return r;
+err_validate_failed:
+err_reserve_failed:
+	drm_gem_object_put(gobj);
+
+	return r;
+}
+
+static void amdgpu_ualink_process_npa_fail_msg(struct amdgpu_device *adev,
+				       u32 remote_acc_id, u64 partial_handle,
+				       u32 fail_reason)
+{
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	int r = 0;
+
+	if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id, 0)) {
+		dev_warn(adev->dev,
+			"NPA-FAIL: no connection with remote AccId:%u\n",
+			remote_acc_id);
+		goto conn_setup;
+	}
+
+	xa_lock(&adev->ualink.imp_xa);
+	imp_xa_node = xa_load(&adev->ualink.imp_xa, partial_handle);
+	if (!imp_xa_node) {
+		xa_unlock(&adev->ualink.imp_xa);
+		dev_warn(adev->dev,
+			"NPA-FAIL: imp XA handle not found:%llx\n",
+			partial_handle);
+		return;
+	}
+
+	imp_xa_node->fail_reason = fail_reason;
+	/* Signal completion done to signal response received for NPA-REQ
+	 * message.
+	 * If the node is in NOT_READY state, then set the node state to
+	 * PENDING and signal the completion. If the node is not in NOT_READY
+	 * state, then it is an unsolicited NPA-FAIL message and we
+	 * log a debug message.
+	 */
+	if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_NOT_READY) {
+		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_PENDING);
+		complete(&imp_xa_node->npa_done);
+	} else {
+		dev_dbg(adev->dev,
+			"NPA-FAIL: unsolicited for handle:%llx:%llx from AccId:%u\n",
+			imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo,
+			remote_acc_id);
+	}
+	xa_unlock(&adev->ualink.imp_xa);
+
+	return;
+
+conn_setup:
+	r = amdgpu_ualink_setup_connection(adev, remote_acc_id);
+	if (r)
+		dev_warn(adev->dev,
+			"NPA-FAIL: connection setup failed with remote AccId:%u\n",
+			remote_acc_id);
+}
+
+static void amdgpu_ualink_process_npa_rsp_msg(struct amdgpu_device *adev,
+				      u32 remote_acc_id, u64 partial_handle,
+				      u64 npa_addr, u64 size)
+{
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	int r = 0;
+
+	/* Check if the connection is established. If it is not, then start
+	 * connection setup.
+	 */
+	if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id, 0)) {
+		dev_warn(adev->dev,
+			"NPA-RSP: no connection with remote AccId:%u\n",
+			remote_acc_id);
+		goto conn_setup;
+	}
+
+	xa_lock(&adev->ualink.imp_xa);
+	imp_xa_node = xa_load(&adev->ualink.imp_xa, partial_handle);
+	if (!imp_xa_node) {
+		xa_unlock(&adev->ualink.imp_xa);
+		dev_warn(adev->dev,
+			"NPA-RSP: imp XA handle not found:%llx\n", partial_handle);
+		return;
+	}
+
+	/* NPA addr received in NPA-RSP is page aligned and without the remote
+	 * GPU-id in Bits 41-50. Assemble back the NPA address before storing
+	 * it.
+	 */
+	imp_xa_node->npa_addr = GENERATE_NPA(npa_addr, remote_acc_id);
+	/* Size is in number of GPU pages granularity. */
+	imp_xa_node->size = size;
+
+	/* Signal completion done to signal NPA_RSP received.
+	 * If the node is in NOT_READY state, then set the node state to
+	 * PENDING and signal the completion. If the node is not in NOT_READY
+	 * state, then it is an unsolicited NPA-RSP message and we
+	 * log a debug message.
+	 */
+	if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_NOT_READY) {
+		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_PENDING);
+		complete(&imp_xa_node->npa_done);
+	} else {
+		dev_dbg(adev->dev,
+			"NPA-RSP: unsolicited for handle:%llx:%llx from AccId:%u\n",
+			imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo,
+			remote_acc_id);
+	}
+	xa_unlock(&adev->ualink.imp_xa);
+
+	return;
+
+conn_setup:
+	r = amdgpu_ualink_setup_connection(adev, remote_acc_id);
+	if (r)
+		dev_warn(adev->dev,
+			"NPA-RSP: connection setup failed with remote AccId:%u\n",
+			remote_acc_id);
+}
+
+static void amdgpu_ualink_process_npa_req_msg(struct amdgpu_device *adev,
+				      u32 remote_acc_id,
+				      struct amdgpu_ualink_handle handle)
+{
+	struct amdgpu_ualink_importer_entry *importer_entry, *npa_addr_entry;
+	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	u64 range_start, range_end, pte_flags;
+	struct drm_mm_node *mm_node = NULL;
+	int r = 0, fail_reason = 0;
+	bool send_npa_fail = true;
+	u64 npa_addr = 0, size;
+	struct amdgpu_bo *bo;
+	u32 gen_count;
+
+	/* Check if the connection is established. If it is not, then start
+	 * connection setup.
+	 */
+	gen_count = amdgpu_ualink_check_conn_ready(adev, remote_acc_id, 0);
+	if (!gen_count) {
+		dev_warn(adev->dev,
+			"NPA-REQ: no connection with remote AccId:%u\n",
+			remote_acc_id);
+		goto conn_setup;
+	}
+
+	/* Check entry exists in Exporter XA. If yes, increase the refcount
+	 * for the node.
+	 */
+	xa_lock(&adev->ualink.exp_xa);
+	exp_xa_node = xa_load(&adev->ualink.exp_xa, handle.handle_lo);
+	if (!exp_xa_node  || (handle.handle_hi != exp_xa_node->handle.handle_hi) ||
+	    !amdgpu_ualink_exp_xa_entry_get(exp_xa_node)) {
+		xa_unlock(&adev->ualink.exp_xa);
+		dev_warn(adev->dev,
+			"NPA-REQ: exp XA handle not found handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+		fail_reason = AMDGPU_UALINK_NPA_FAIL_INVALID_HANDLE;
+		goto handle_invalid_fail;
+	}
+	xa_unlock(&adev->ualink.exp_xa);
+
+	bo = exp_xa_node->bo;
+	size = amdgpu_bo_ngpu_pages(bo);
+
+	/* Pin the BO */
+	r = amdgpu_bo_reserve(bo, true);
+	if (unlikely(r)) {
+		dev_warn(adev->dev,
+			"NPA-REQ: BO reserve failed handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+		fail_reason = AMDGPU_UALINK_NPA_FAIL_ERROR;
+		goto bo_reserve_fail;
+	}
+	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
+	amdgpu_bo_unreserve(bo);
+	if (r) {
+		dev_warn(adev->dev,
+			"NPA-REQ: BO pin failed handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+		fail_reason = AMDGPU_UALINK_NPA_FAIL_ERROR;
+		goto bo_pin_fail;
+	}
+
+	if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
+		mutex_lock(&exp_xa_node->node_lock);
+		importer_entry = &exp_xa_node->importer_entries[remote_acc_id];
+		npa_addr_entry = importer_entry;
+		mutex_unlock(&exp_xa_node->node_lock);
+		/* Check if NPA address is already allocated for this importer.
+		 * If yes, then send the NPA-FAIL message back to the remote GPU.
+		 */
+		if (importer_entry->npa_addr) {
+			fail_reason = AMDGPU_UALINK_NPA_FAIL_DUPLICATE;
+			goto npa_duplicate_fail;
+		}
+
+		range_start = ((u64)remote_acc_id << AMDGPU_UALINK_NPA_ADDR_GPUID_SHIFT) |
+				AMDGPU_UALINK_NPA_ADDR_RANGE_RESERVED;
+		range_end = range_start | AMDGPU_UALINK_NPA_ADDR_RANGE_MASK;
+	} else {
+		/* We store NPA-address in importer_entries[0] in
+		 * Source-Aliasing mode.
+		 */
+		mutex_lock(&exp_xa_node->node_lock);
+		npa_addr_entry = &exp_xa_node->importer_entries[0];
+		importer_entry = &exp_xa_node->importer_entries[remote_acc_id];
+		/* Check if NPA address is already allocated for this importer.
+		 * If yes, then set the corresponding bit in the importers_bitmap,
+		 * set the generation count and send the NPA-RSP back to the remote GPU.
+		 */
+		if (npa_addr_entry->npa_addr) {
+			npa_addr = npa_addr_entry->npa_addr;
+			set_bit(remote_acc_id, exp_xa_node->importers_bitmap);
+			importer_entry->generation_count = gen_count;
+			mutex_unlock(&exp_xa_node->node_lock);
+			dev_dbg(adev->dev,
+				"NPA-REQ: NPA:%llx size:%llx handle:%llx:%llx\n",
+				npa_addr, size, handle.handle_hi, handle.handle_lo);
+
+			goto send_npa_rsp;
+		}
+		mutex_unlock(&exp_xa_node->node_lock);
+
+		range_start = 0;
+		range_end = 0;
+	}
+
+	mm_node = kzalloc(sizeof(*mm_node), GFP_KERNEL);
+	if (!mm_node) {
+		dev_warn(adev->dev,
+			"NPA-REQ: mm_node alloc failed handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+		fail_reason = AMDGPU_UALINK_NPA_FAIL_NOSPACE;
+		goto mem_alloc_fail;
+	}
+
+	/* Allocate NPA address */
+	r = amdgpu_ualink_npa_alloc_va(adev, mm_node, 0, range_start,
+					range_end, size);
+	if (r) {
+		dev_warn(adev->dev,
+			"NPA-REQ: NPA addr alloc failed handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+		fail_reason = AMDGPU_UALINK_NPA_FAIL_NOSPACE;
+		goto npa_alloc_fail;
+	}
+	npa_addr = mm_node->start;
+
+	pte_flags = amdgpu_ualink_get_export_pte_flags(adev, bo, 0);
+	dev_dbg(adev->dev,
+		"NPA-REQ: Allocated NPA:%llx size:%llx PTE:%llx handle:%llx:%llx\n",
+		npa_addr, size, pte_flags, handle.handle_hi, handle.handle_lo);
+
+	/* Map the NPA address into NPA VM*/
+	r = amdgpu_ualink_map_npa_addr(adev, npa_addr, size, bo, 0, pte_flags);
+	if (r) {
+		fail_reason = AMDGPU_UALINK_NPA_FAIL_ERROR;
+		dev_warn(adev->dev,
+			"NPA-REQ: NPA addr (%llx) map failed handle:%llx:%llx\n",
+			npa_addr, handle.handle_hi, handle.handle_lo);
+		goto map_npa_fail;
+	}
+
+	dev_dbg(adev->dev,
+		"NPA-REQ: Mapped NPA:%llx size:%llx pte:%llx handle:%llx:%llx\n",
+		npa_addr, size, pte_flags, handle.handle_hi, handle.handle_lo);
+send_npa_rsp:
+	/* Send NPA-RSP back to the remote GPU */
+	r = amdgpu_ualink_send_npa_rsp_msg(adev, remote_acc_id, handle,
+					   STRIP_NPA(npa_addr), size);
+	if (r) {
+		dev_warn(adev->dev,
+			"NPA-REQ: send NPA-RSP failed remote:%u handle:%llx:%llx\n",
+			remote_acc_id, handle.handle_hi, handle.handle_lo);
+		send_npa_fail = false;
+		goto send_npa_rsp_fail;
+	}
+
+	dev_dbg(adev->dev,
+		"NPA-REQ: Sent NPA-RSP with NPA:%llx size:%llx handle:%llx:%llx\n",
+		npa_addr, size, handle.handle_hi, handle.handle_lo);
+
+	/* If this is the first time we are setting the bit for this importer,
+	 * then store the NPA address, mm_node and generation count.
+	 */
+	mutex_lock(&exp_xa_node->node_lock);
+	if (!test_and_set_bit(remote_acc_id, exp_xa_node->importers_bitmap)) {
+		npa_addr_entry->npa_addr = npa_addr;
+		npa_addr_entry->mm_node = mm_node;
+		importer_entry->generation_count = gen_count;
+	}
+	mutex_unlock(&exp_xa_node->node_lock);
+
+	dev_dbg(adev->dev,
+		"NPA-REQ: BO pin_count:%d, importers:%d, handle:%llx:%llx\n",
+		bo->tbo.pin_count, bitmap_weight(exp_xa_node->importers_bitmap,
+		AMDGPU_UALINK_ACCEL_MAX), handle.handle_hi, handle.handle_lo);
+	WARN_ON(bo->tbo.pin_count < bitmap_weight(exp_xa_node->importers_bitmap,
+						   AMDGPU_UALINK_ACCEL_MAX));
+
+	/* Add this node to the exported handles list for the remote GPU,
+	 * but only if the node is still in exp_xa. If revoke already erased
+	 * it, skip the list_add to avoid a dangling list entry. The cleanup
+	 * worker is guaranteed to run after we drop our ref, so it will see
+	 * this importer in the bitmap and send NPA-REVOKE.
+	 */
+	xa_lock(&adev->ualink.exp_xa);
+	if (xa_load(&adev->ualink.exp_xa, exp_xa_node->handle.handle_lo) == exp_xa_node)
+		list_add(&importer_entry->list, &adev->ualink.exp_handles_list[remote_acc_id]);
+	xa_unlock(&adev->ualink.exp_xa);
+
+	amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+
+	return;
+
+send_npa_rsp_fail:
+	mutex_lock(&exp_xa_node->node_lock);
+	clear_bit(remote_acc_id, exp_xa_node->importers_bitmap);
+	mutex_unlock(&exp_xa_node->node_lock);
+	if (mm_node)
+		amdgpu_ualink_unmap_npa_addr(adev, bo, npa_addr, size);
+
+map_npa_fail:
+	if (mm_node)
+		amdgpu_ualink_npa_free_va(adev, mm_node);
+
+npa_alloc_fail:
+	kfree(mm_node);
+mem_alloc_fail:
+npa_duplicate_fail:
+	r = amdgpu_bo_reserve(bo, true);
+	if (likely(!r)) {
+		amdgpu_bo_unpin(bo);
+		amdgpu_bo_unreserve(bo);
+	} else {
+		dev_warn(adev->dev,
+			"NPA-REQ: BO reserve to unpin failed for handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+	}
+
+bo_pin_fail:
+bo_reserve_fail:
+	amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+
+handle_invalid_fail:
+	if (send_npa_fail) {
+		r = amdgpu_ualink_send_npa_fail_msg(adev, remote_acc_id,
+						    handle, fail_reason);
+		if (r)
+			dev_warn(adev->dev,
+				"NPA-REQ: send NPA-FAIL failed remote:%u handle:%llx:%llx\n",
+				remote_acc_id, handle.handle_hi, handle.handle_lo);
+	}
+	return;
+conn_setup:
+	r = amdgpu_ualink_setup_connection(adev, remote_acc_id);
+	if (r)
+		dev_warn(adev->dev,
+			"NPA-REQ: connection setup failed with remote AccId:%u\n",
+			remote_acc_id);
+}
+
+static int amdgpu_ualink_translate_npa_fail_reason(struct amdgpu_device *adev,
+						   u32 fail_reason)
+{
+	switch (fail_reason) {
+	case AMDGPU_UALINK_NPA_FAIL_NOSPACE:
+		return -ENOSPC;
+	case AMDGPU_UALINK_NPA_FAIL_INVALID_HANDLE:
+	case AMDGPU_UALINK_NPA_FAIL_DUPLICATE:
+	case AMDGPU_UALINK_NPA_FAIL_ERROR:
+		return -EINVAL;
+	default:
+		dev_err(adev->dev,
+			"IMPORT: invalid NPA-FAIL reason:%u\n",
+			fail_reason);
+		return -EINVAL;
+	}
+}
+
+static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
+				struct amdgpu_ualink_imp_xa_node *imp_xa_node,
+				u32 remote_acc_id)
+{
+	struct amdgpu_ualink_handle handle = imp_xa_node->handle;
+	int r;
+
+	/* First check if the connection is setup with the
+	 * remote GPU. If yes, then initiate the NPA protocol to
+	 * get the NPA address.
+	 * If not, then initiate the HELLO protocol to first setup
+	 * the connection and once the connection is setup, then
+	 * initiate the NPA protocol.
+	 */
+	r = amdgpu_ualink_setup_connection(adev, remote_acc_id);
+	if (r) {
+		if (r != -EAGAIN)
+			dev_warn(adev->dev,
+			"IMPORT: connection setup failed with remote AccId:%u\n",
+			remote_acc_id);
+		return r;
+	}
+
+	/* Send NPA_REQ message */
+	r = amdgpu_ualink_send_npa_req_msg(adev, remote_acc_id, handle);
+	if (r) {
+		dev_warn(adev->dev,
+			"IMPORT: NPA-REQ send failed to remote AccId:%u\n",
+			remote_acc_id);
+		return r;
+	}
+
+	/* Wait for the NPA_RSP to come back */
+	r = wait_for_completion_interruptible_timeout(&imp_xa_node->npa_done,
+				msecs_to_jiffies(AMDGPU_UALINK_RESP_TIMEOUT));
+	if (r == -ERESTARTSYS) {
+		dev_err_ratelimited(adev->dev,
+			"IMPORT: NPA-RSP wait interrupted by signal\n");
+		return r;
+	} else if (r == 0) {
+		dev_warn(adev->dev,
+			"IMPORT: NPA-RSP timeout from remote AccId:%u\n",
+			remote_acc_id);
+		return -ETIMEDOUT;
+	}
+
+	/* If the NPA addr/size isn't filled with valid values, then either
+	 * we got a NPA_FAIL or something bad happened. In either case, we
+	 * return the error back to user-space.
+	 */
+	if (imp_xa_node->fail_reason) {
+		dev_warn(adev->dev,
+			"IMPORT: NPA-REQ failed with fail_reason:%d handle:%llx:%llx\n",
+			imp_xa_node->fail_reason, handle.handle_hi, handle.handle_lo);
+		return amdgpu_ualink_translate_npa_fail_reason(adev,
+						imp_xa_node->fail_reason);
+	}
+
+	if (!imp_xa_node->npa_addr || !imp_xa_node->size) {
+		dev_warn(adev->dev,
+			"IMPORT: invalid npa:%llx or size:%llx\n",
+			imp_xa_node->npa_addr, imp_xa_node->size);
+		imp_xa_node->npa_addr = 0;
+		imp_xa_node->size = 0;
+		return -EINVAL;
+	}
+
+	r = amdgpu_ualink_map_npa_to_dmabuf(adev, imp_xa_node);
+	if (r) {
+		dev_warn(adev->dev,
+			"IMPORT: dmabuf creation failed npa:%llx size:%llx\n",
+			imp_xa_node->npa_addr, imp_xa_node->size);
+		imp_xa_node->npa_addr = 0;
+		imp_xa_node->size = 0;
+		return r;
+	}
+
+	/* Add this node to the imported handles list for the remote GPU */
+	xa_lock(&adev->ualink.imp_xa);
+	list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
+	xa_unlock(&adev->ualink.imp_xa);
+
+	return 0;
+}
+
+int amdgpu_ualink_import_handle(struct drm_device *dev,
+				const struct amdgpu_ualink_handle *ualink_handle,
+				int *fd_out)
+{
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_ualink_handle handle = *ualink_handle;
+	u32 remote_acc_id, node_state;
+	int r = 0, fd;
+
+	remote_acc_id = (handle.handle_lo &
+			AMDGPU_UALINK_HANDLE_ACCID_MASK);
+
+	if (remote_acc_id >= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev->dev,
+			"IMPORT: invalid remote AccId:%u\n", remote_acc_id);
+		return -EINVAL;
+	}
+
+	xa_lock(&adev->ualink.imp_xa);
+	imp_xa_node = xa_load(&adev->ualink.imp_xa, handle.handle_lo);
+
+	if (imp_xa_node) {
+		/* If node state is Not_ready/Pending, then some other
+		 * thread is already trying the NPA protocol for the same
+		 * ualink handle. Back off and let the thread finish.
+		 * If the node state is Teardown, then it means this
+		 * node is about to be removed. So let user-space know
+		 * that this handle is invalid.
+		 */
+		node_state = READ_ONCE(imp_xa_node->node_state);
+		if (node_state == AMDGPU_UALINK_NODE_NOT_READY ||
+		    node_state == AMDGPU_UALINK_NODE_PENDING) {
+			xa_unlock(&adev->ualink.imp_xa);
+			r = -EAGAIN;
+			goto out;
+		} else if (node_state == AMDGPU_UALINK_NODE_TEARDOWN) {
+			xa_unlock(&adev->ualink.imp_xa);
+			r = -EINVAL;
+			goto out;
+		}
+
+		/* Increase the refcount while we are processing the request */
+		r = amdgpu_ualink_imp_xa_entry_get(imp_xa_node) ? 0 : -EINVAL;
+		xa_unlock(&adev->ualink.imp_xa);
+
+		/* If the refcount has become 0 but the entry is not yet
+		 * removed from the Xarray, then return error to user-space.
+		 */
+		if (r)
+			goto out;
+	} else {
+		xa_unlock(&adev->ualink.imp_xa);
+		/* if the partial handle doesn't exist in the Importer xarray then
+		 * initiate the NPA protocol and generate the DMABuf corresponding
+		 * to the NPA address.
+		 * First store the entry in the Xarray.
+		 */
+		imp_xa_node = kzalloc(sizeof(*imp_xa_node), GFP_KERNEL);
+		if (!imp_xa_node) {
+			r = -ENOMEM;
+			goto out;
+		}
+		imp_xa_node->adev = adev;
+		imp_xa_node->node_state = AMDGPU_UALINK_NODE_NOT_READY;
+		imp_xa_node->handle = handle;
+		init_completion(&imp_xa_node->npa_done);
+		kref_init(&imp_xa_node->refcount);
+
+		/* Take an extra reference to store in the Xarray. The error
+		 * handling paths will drop both these references, while a
+		 * successful path will drop only one reference to the Xarray
+		 * entry.
+		 */
+		amdgpu_ualink_imp_xa_entry_get(imp_xa_node);
+
+		/* Check if another thread created a node for the same handle while
+		 * we were trying to create and initialize the node.
+		 */
+		r = xa_insert(&adev->ualink.imp_xa, handle.handle_lo,
+			      imp_xa_node, GFP_KERNEL);
+		if (r) {
+			kfree(imp_xa_node);
+			dev_err(adev->dev,
+				"IMPORT: XA insert failed for handle:%llx:%llx err:%d\n",
+				handle.handle_hi, handle.handle_lo, r);
+			goto out;
+		}
+
+		r = amdgpu_ualink_do_import_handle(adev, imp_xa_node, remote_acc_id);
+
+		/* If error is returned, then cleanup the xarray entry before returning
+		 * the error back to user-space
+		 */
+		if (r) {
+			amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+			if (r != -EAGAIN)
+				dev_err(adev->dev,
+					"IMPORT: XA import failed for handle:%llx:%llx\n",
+					handle.handle_hi, handle.handle_lo);
+			goto cleanup;
+		} else {
+			WRITE_ONCE(imp_xa_node->node_state,
+				   AMDGPU_UALINK_NODE_READY);
+		}
+	}
+
+	/* dma_buf_fd consumes a reference and assigns it to the fd.
+	 * Therefore take an extra reference to be consumed. It will be
+	 * released when user mode closes the fd.
+	 */
+	get_dma_buf(imp_xa_node->dmabuf);
+
+	fd = dma_buf_fd(imp_xa_node->dmabuf, O_CLOEXEC | O_RDWR);
+	if (fd >= 0) {
+		*fd_out = fd;
+	} else {
+		dma_buf_put(imp_xa_node->dmabuf);
+		r = fd;
+		dev_err(adev->dev,
+			"IMPORT: dma-buf fd creation failed handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+	}
+
+cleanup:
+	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+out:
+	return r;
+}
+
 int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 				u32 gem_handle,
 				struct amdgpu_ualink_handle *handle_out)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index c8c37d4ee4b48..9d5d24a2a1106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -34,12 +34,44 @@
 #define AMDGPU_UALINK_RESP_TIMEOUT			5000 /* 5s timeout */
 
 #define AMDGPU_UALINK_HANDLE_ACCID_MASK			GENMASK_ULL(9, 0)
+#define AMDGPU_UALINK_MESSAGE_HEADER_MASK		GENMASK_ULL(9, 0)
 #define AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT	10
 #define AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT	20
+#define AMDGPU_UALINK_NPA_FAIL_MSG_FAIL_REASON_MASK	GENMASK_U32(7, 0)
+
+/* GPU-ID is stored in bits 41-50 of the NPA address. However, we
+ * store NPA address is GPU PAGE aligned so bottom 12 bits are not used.
+ * As a result, we need the GPU-ID shift to be 41 - 12 = 29.
+ */
+#define AMDGPU_UALINK_NPA_ADDR_GPUID_SHIFT		29
+#define AMDGPU_UALINK_NPA_ADDR_GPUID_MASK		GENMASK_ULL(38, 29)
+/* Reserve 2M in each 2TB range for ring buffer allocations for
+ * remote interrupts. In terms of GPU pages, this is 2M / 4K = 512 pages.
+ * So we reserve 512 pages in each 2TB range.
+ */
+#define AMDGPU_UALINK_NPA_ADDR_RANGE_RESERVED		(1U << 9)
+#define AMDGPU_UALINK_NPA_ADDR_RANGE_MASK		GENMASK_ULL(28, 0)
+
+enum AMDGPU_UALINK_NPA_FAIL_REASON {
+	AMDGPU_UALINK_NPA_FAIL_NOSPACE			= 1,
+	AMDGPU_UALINK_NPA_FAIL_INVALID_HANDLE		= 2,
+	AMDGPU_UALINK_NPA_FAIL_DUPLICATE		= 3,
+	AMDGPU_UALINK_NPA_FAIL_ERROR			= 4,
+};
+
+enum AMDGPU_UALINK_NODE_STATE {
+	AMDGPU_UALINK_NODE_NOT_READY			= 0,
+	AMDGPU_UALINK_NODE_PENDING			= 1,
+	AMDGPU_UALINK_NODE_READY			= 2,
+	AMDGPU_UALINK_NODE_TEARDOWN			= 3
+};
 
 enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
 	AMDGPU_UALINK_HELLO_MSG				= 1,
 	AMDGPU_UALINK_HELLO_ACK_MSG			= 2,
+	AMDGPU_UALINK_NPA_REQ_MSG			= 3,
+	AMDGPU_UALINK_NPA_RSP_MSG			= 4,
+	AMDGPU_UALINK_NPA_FAIL_MSG			= 5,
 	AMDGPU_UALINK_MAX_PROTOCOL_MSG
 };
 
@@ -144,6 +176,44 @@ struct amdgpu_ualink_handle {
 	};
 };
 
+struct amdgpu_ualink_imp_xa_node {
+	struct amdgpu_device		*adev;
+
+	/* 128-bit handle for the BO */
+	struct amdgpu_ualink_handle	handle;
+
+	/* Use to signal NPA-RSP arrival */
+	struct completion		npa_done;
+
+	/* NPA address received in the NPA-RSP message */
+	u64				npa_addr;
+	u64				size;
+
+	/* GEM handle for the NPA BO */
+	u32				gem_handle;
+
+	/* Fail reason received in NPA-FAIL message */
+	int				fail_reason;
+
+	/* Node state to signal if node setup is in progress
+	 * or is already completed. Node state goes back to
+	 * in progress if a HELLO message is received in
+	 * response to NPA-REQ message.
+	 */
+	enum AMDGPU_UALINK_NODE_STATE	node_state;
+
+	/* Used to connect all importer XA nodes from a particular
+	 * exporter.
+	 */
+	struct list_head		list;
+
+	/* Dmabuf corresponding to the NPA BO */
+	struct dma_buf			*dmabuf;
+
+	/* Refcount to track lifetime of this node */
+	struct kref			refcount;
+};
+
 struct amdgpu_ualink_npa_mm {
 	struct drm_mm			mm;
 	u64				va_start;
@@ -277,4 +347,7 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 				u32 gem_handle,
 				struct amdgpu_ualink_handle *handle_out);
+int amdgpu_ualink_import_handle(struct drm_device *dev,
+				const struct amdgpu_ualink_handle *ualink_handle,
+				int *fd_out);
 #endif
-- 
2.55.0

