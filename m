Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D653606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G+Ak5TE7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC6F10F1C5;
	Mon, 26 Oct 2026 23:03:14 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49CB10E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv9vj5NEZhQnXEi/ihrN18HS2CFScUCQtwc+KVQygljorRMoVwysKy3Hqr7r5Zl0x8JSk7RRt+aokPcFllO7qOrjDqE6bH7iO3sV/jJsx6ULTmvTwZMiswPTF8+nBwDFsF/DB52GRxr3ldT/aacBmi6Lgh6v/9NLlkXhcecp00GNaGPZQlD9jxCCbwqJqXqa2Y6P1JOOwSxeh57dsYzZ+osrJd88opzrjCCKOIf1m1Pj/OKl9mB9R8WT1NppJAScUjIWeOOHc/2w5wRvS5C3YuJ1nIlaUhfHprfelMfG6ufMKSNWiidfZjhvJ0uJ7bdGYj/p/pX+omgjqfhmvSdRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iCS5TehcnKw9FvnkG272WqY0z5V1FH7e4C6QVGa/sc=;
 b=yx0jeKlM3oi05YW+qwmpnXybthgu8wXHTUbLg2zhIj7uRyuMeSfw9HADNJ3dpm5/yEqgegRE81PJpj8NIkl/sVjGYWFcyFll5ZB7dZ4nfGNw2H+7tkR4RSXnw2U08j9dqlfXvyAjJplh+I/t93EiD6MeQPvIvHMFJaag1Cpp+uGrETFnpC3P8UaOe/7EnGT9PkytQt3ibZ4iJqrDXvO/pVpvODczbWdYezHSGX27NCUJaLAdf38FB2HW2NwN0lDqQ/GbJyaAAL4h4BSuXfsm7NG+NcXKve0eJ1V3l22EmG5CAqLIp+f/NP4gxbHcNFBZsqCxpvC7Asn7LIl6r+AqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iCS5TehcnKw9FvnkG272WqY0z5V1FH7e4C6QVGa/sc=;
 b=G+Ak5TE7WYNWyuXhkVl7vKb5eokCOUK2XFxIBYvDHWT5DBcTKjOcejfOGRNyApzO6rCk4dPZ2A1ATX2VhadqnU6cbUE83704xr4iIloMzvwvof3r/7wP/ZmGY4YMj1+BOvTHHfaZ0TR0tTeS6agZK7flA/dbawtozzUOzINK3Ig=
Received: from BN0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:141::28)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:04 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::37) by BN0PR07CA0025.outlook.office365.com
 (2603:10b6:408:141::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:03 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:02 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: Support VMID 0 GPUVA completion WB address
 for UALink
Date: Mon, 26 Oct 2026 18:59:24 -0400
Message-ID: <20261026230248.1597606-3-mukul.joshi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dba365-47dd-4c58-90ca-08df33b54a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|261026140227099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: HDo0R/MjNKIwBshY2H+la6muvOIRLjSO0wKJ81v6xiRCbMFC1XNBaL2rzaegW1BwupMYpGPRgvwF0UqTCCmmPGYoDlvS8vsa8XntGqz6myx707s2+D7/BTln3T31DWb/WZlrltt9pB0PqZ511LQYMRpC13y6oG1rdgcZp3vF/Wow+ED12LosFF+ApBf6OfuwCJD9kpsruU2ATi3tmsu++OJ03Eyf+YR+7WYqLA0j3HTVZzcvkT62owvjnZwQaiVmkT3r70FOswLk7pyq2cy+mliZGHQ8lFXKL5d9Nm/u0uT8GY7lTNI9MhhhaZ9gmpcU44qbwBaXuhYj/CHGorwA8mUGR/0Xfx9AsRk0ZA1bBJ9tzFL/dHA1xVnn+EfQPTUmRovLzxeOP07a8Obm6OsMHACqqRAAKgLnPf2rc1l4jrhqF1xq1Uo0kRTFgrZeyh21aj92ncdh+zIifENNhsxnvXf+pTTw0gvsjl1eA1dtUx+iOoegie/7km3TFyjZe1R0Aq63z+0FDVaMgdF9y4/Zod72DTYyTA+wY1feLwMKl8Wf4XCFZaEAE6tr33qajs1Ork/Q72guWlstQXOo2gMteTP49bNRD6FRDt+h1RTKxiipQl2ZUfpKeMtTNlTkH59yM1O0uorGTtOh2IwVgIAao+Sk8aTg3cH0h/03qe0LsS9V5PV1dw0T09qnSO3fiMuOapZyJPHQk5ymmZK+Az4n5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AzlDUQAURDVUuTIurevk3Oc4awU/hW7VzYq7yvyTVZOrDbBG2qVgatqf4oEuvpXXh0cAehadovKxxlpx6MDwPPzPQYxnM61BOhdBazi5yLHTiaJaV/0MXvEFVK+ps+ryWQPN3TufLHBgh3XLpYRUc6D6SEdzkmE92W+zThsj2us7nnWpd5YCkeswjCMnWRAehkW24LqHE0pht78pyAecqLjifspbQNCrzZDrjwLPfFM66Wm4o0xTVtu0eZgUuagcoXYommPq3eHsY1ZsB6Dei79qtiDASQs+6RPExprfwMPrHOMqWSAOVS8t2McmgPzbUDU40QQfaiAXm6ZisA9bFrsTBxGlTHOsB8K/iQ9fq4oYoITXYGhUBIIlELwb9aXFbzquWapnRopeIUBTeCedNuOYm4T/WS0KOVwRhGm/RlluSjd9/EK0VNPJVru2i73u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:03.4664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dba365-47dd-4c58-90ca-08df33b54a17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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

The UPDATE_WB_ADDR remote command hands the MP nHT FW the address it
writes command completions back to. So far that has always been an NPA.

The FW can also take a VMID 0 GPUVA, selected by setting DW4 of the
command to 1. Return the VMID 0 GPUVA of the writeback slot from
amdgpu_ualink_get_wb_addr() alongside the NPA, and use it in
UALink loopback mode. There the HW only carries importer -> exporter
traffic, so the FW cannot write the completion back over NPA.

Outside loopback the NPA is still used and DW4 stays 0.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 48 +++++++++++++++-------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 288c07274254..64a051242367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5654,9 +5654,9 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
 
 	*cpu_addr++ = cmd;
 	*cpu_addr++ = wb_data;
-	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb_npa */
-	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb_npa */
-	*cpu_addr++ = 0;
+	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb address */
+	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb address */
+	*cpu_addr++ = dw2;		/* 1: wb address is VMID 0 GPUVA, 0: NPA */
 	*cpu_addr++ = 0;
 	*cpu_addr++ = 0; /* metadata */
 	*cpu_addr++ = 0; /* metadata */
@@ -5867,7 +5867,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 				      u32 remote_accel_id,
 				      struct amdgpu_ualink_wb **wb_cpu,
-				      u64 *wb_npa, u32 type)
+				      u64 *wb_npa, u64 *wb_gpu, u32 type)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	/* The GPUID encoded in the write-back NPA address is the routing target
@@ -5879,15 +5879,17 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 	 */
 	u32 accel_id = ualink_exp_accel_id(adev);
 	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
-	u64 wb, npa;
+	u64 wb, gpu, npa;
 	u32 offset = 0;
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
 		wb = (u64)remote->rb_cpu_addr + rb_size * remote->num_accel;
+		gpu = remote->rb_gpu_addr + rb_size * remote->num_accel;
 		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
 					     remote_accel_id, accel_id);
 	} else {
 		wb = (u64)remote->rptr_cpu_addr;
+		gpu = remote->rptr_gpu_addr;
 		npa = remote->rptr_npa;
 		npa |= (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
 	}
@@ -5900,9 +5902,11 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 	*wb_cpu = (struct amdgpu_ualink_wb *)(wb + offset);
 	if (wb_npa)
 		*wb_npa = npa + offset;
+	if (wb_gpu)
+		*wb_gpu = gpu + offset;
 
-	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx\n", accel_id,
-		remote_accel_id, npa + offset);
+	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx gpu 0x%llx\n", accel_id,
+		remote_accel_id, npa + offset, gpu + offset);
 }
 
 struct amdgpu_ualink_wptr_fence_cb {
@@ -6066,9 +6070,9 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
 		remote_accel_id, int_wptr, tlb_wptr);
 
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL, NULL,
 				  RB_TYPE_REMOTE_INTERRUPT);
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL, NULL,
 				  RB_TYPE_TLB_INV);
 
 	peer->interrupt.wptr = int_wptr;
@@ -6102,7 +6106,8 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
 	struct amdgpu_ualink_wb *wb_cpu;
-	u64 wb_npa;
+	u64 wb_npa, wb_gpu, wb_addr;
+	u32 wb_vmid0;
 	int r;
 
 	peer = &remote->peer[remote_accel_id];
@@ -6114,13 +6119,28 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &wb_cpu, &wb_npa,
-				  ring_type);
+				  &wb_gpu, ring_type);
+
+	/* UALink loopback: HW only carries importer -> exporter traffic, so the
+	 * MPNHT FW cannot write the completion back over NPA. Hand it the VMID 0
+	 * GPUVA of the writeback instead and flag it in DW4 of the command.
+	 */
+	if (adev->ualink.loopback.enabled) {
+		wb_addr = wb_gpu;
+		wb_vmid0 = 1;
+	} else {
+		wb_addr = wb_npa;
+		wb_vmid0 = 0;
+	}
+
+	dev_dbg(adev->dev, "remote %u ring type %u wb %s 0x%llx\n",
+		remote_accel_id, ring_type, wb_vmid0 ? "gpuva" : "npa", wb_addr);
 
 	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, wb_cpu,
 				       amdgpu_ualink_emit_update_wb_addr,
-				       upper_32_bits(wb_npa),
-				       lower_32_bits(wb_npa),
-				       0, 0);
+				       upper_32_bits(wb_addr),
+				       lower_32_bits(wb_addr),
+				       wb_vmid0, 0);
 	if (!r) {
 		ring->wb_cpu = wb_cpu;
 		ring->ready = true;
-- 
2.55.0

