Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD672606C3C8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FaFneCjJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C91C10E62D;
	Mon,  2 Nov 2026 16:02:17 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3431A10E62D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Np3jVE2abF26qw+K7dqJZYbh5EY+1fnlwr5dpMHrfxqYsZpOfbB2IzQ8u9B/zJz8S4f2fCU+cCjEAh2ynpbquRewgk2arfW1DvHOirfoo2EskwAhgj5lAqI8ZnfNs6sKBuPDjxyAmS8mgir58G5TDTXO3UmKUR//5wjtKaJn0/6d6xzkn3SzmdIxQH2R5J2wg9apb+fgM8BQ+e6/TVu6P1lvnZ/QjWnMN2gDRVLGuJ5/Kzk1fmm1I5cg60etwmh3kMgYf4M4huicXpAZ7t2YeaOx4Hi2WffPg1nwn+Hm9EsflzBpjhoIMgbNAVBH5AM2FdkOJhS31KU9/WAkLWaLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y3R7pScMRZD92jyJXswFbyiI0+jlFtSl6gd1RUvXBc=;
 b=qKuz5zUSLF/GdhKLo1pxiqTpSmza+wGUb+6geVhRSZERDN4NmAcrpquq6ua0bElqUg9qnce4K55yDArRd8drWTIdg5l3VOkEBYAtbYvRqA80296wKPdG1InU8t27/kF2gERSqjNb4EWLmWcsevpF5HCRgWXbrF/fMMgxA+ZxoOpBYYRFTAN10capo7vHEl98o5ZShMR7IaxX1LCCGyiJ0IsBbrqtnC2ZxK+BNMxCkBjUb+ILLeFrxO0NtoEdCSrEQQnRIfi99VS4cmktWnTLA8sTEzYqP75tCjkzJ0vsjZnl+IeeTcp4ofez/OkruZ6mhcIl5LnXuu8YSuOSGxM2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y3R7pScMRZD92jyJXswFbyiI0+jlFtSl6gd1RUvXBc=;
 b=FaFneCjJ3V4FFGlCL0BAzfzBb4Z0nGXQ80+4oVsP1/2VEyNAk+zBORt4aeCJN8JHEYFVb2aEsDk0xbi44mF+zBdpUEWRcyxzMLOZ90UGNOk5SEU7TfzW/0FWOXbrmaHlFLhnKW64w8CoGbHW0bG4X/TkOysUWc7BlCpNFKxXvQ0=
Received: from BY1P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::11)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:02:07 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::8b) by BY1P220CA0043.outlook.office365.com
 (2603:10b6:a03:59e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 16:02:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:06 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:06 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCHv3 2/8] drm/amdgpu: Support VMID 0 GPUVA completion WB address
 for UALink
Date: Mon, 2 Nov 2026 10:47:48 -0500
Message-ID: <20261102160125.2743750-3-mukul.joshi@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8707e2-a249-4a6b-0050-08df38faa4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|3023799007|6133799003|10067099003|18002099003|22082099003|261102123227099003|261102130727099003|56012099006|261026121527099003|11063799006|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: UD3Y60R4cc5tVm3w6l0L8zIL3hpy9eWUw5RSuqsDSdzq5KWf9S7SHJu4ozSkG20MvdOo+iF42dCW7N9sL9OZ2Jus9JGj1FwlPMh+KlcLDFf/7l5df/ckxo4l1/NHioZDNBQAudV3j4he1epYW15n0+EMazdIAhJw1PDRv5CfH70EfepxRkp7Km6rGtjf+4rh9yEszLzD8tdjM7MEwkwbn1IKkdvqX3s1aNDg35Z5AazSqLYZTFfmBM5IzQMEcBckLXwLPe5EDtdiMd9IscJYxWIRRs6nbHtD05mghNBHMuWxW9FDTc+bQ71pOle4xWuPNsWY6n7o4XrAuT2IcVahqh4F2RDL78d9Q2x4opO8PXey+BGclRJGNh6J7dumvg+xXOBQmigSPF6neaq5lFGesYol9n/GzTFhYo2zEohPGlC8v9BtbUzBXL16ZZVwYDhYuiyOgXbLQKxCQxcE5B2PhmXMLufOGXSg7EFQeuz0J0TuLEWwVth20+QZ7SFrPNzio6pWd5SHnYum2yxq5DiMMhYjXIg4Srhy8rg6gp1/pFVDNQvSJ4mPqQeb1bi3Mu1DIuEnWVJl1RqTEP6eY4EGUD75tfe8OK2AKo/QfWQU8MCz7VmsII9cRvDD7xX0SruMTPkkqJA5vZtPKLRDXHsMTlMZbEPPVjgsTX144qXr4l0RyF8vGFgSUduKheLpACPEMLzzt7v09MxOVb8u70yO4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(56012099006)(261026121527099003)(11063799006)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3VRcsTsVBTlKHrpSwjXbgjmTII9Wywn1wVDHOnCZV0gBJelLycZNBvFdWQeLVMSEYJqx0fSdldLQuDmGLUyNl1PAUKgjdHeuh29fPdeKuRLGJYQTedY0c53E03s9KSwCXgu6skfNlCW9flb9gdkjPJLn/vEhRHU8eWDzjCigjQAaMLaVVJ89u7L0X5pZQIEZR1Jp39BuKWT3bWwiqoG+aBnEXS2p6Ugk2ZzrFTTj14JYFaDw2aPLnsuh8Ajr5wdbHxSnIKwHO8SzBa9BdM7f/j/73k0iAMwK9C/M+EfuHLaLpwSDwG2wMgXxX3iSIlvJQjE6lGxd2y8jy+4CbSINfRt6eA0PtTZVFXSLaAcMLMqDQUu/3IKstmd/9CD523ixLOI/dEKvfwWLqki2gRwGshXHLIT0I4gkLaRWBcbMUHEnq4VkUYa48HYVTnd6XXOt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:06.8165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8707e2-a249-4a6b-0050-08df38faa4e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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

The UPDATE_WB_ADDR remote command hands the MP nHT FW the address it
writes command completions back to. So far that has always been an NPA.

The FW can also take a VMID 0 GPUVA, selected by setting DW4 of the
command to 1. Return the VMID 0 GPUVA of the writeback slot from
amdgpu_ualink_get_wb_addr() alongside the NPA, and use it in
UALink loopback mode. There the HW only carries importer -> exporter
traffic, so the FW cannot write the completion back over NPA.

Outside loopback the NPA is still used and DW4 stays 0.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 48 +++++++++++++++-------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a98d5bbf0622..29a787979af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5652,9 +5652,9 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
 
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
@@ -5868,7 +5868,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 				      u32 remote_accel_id,
 				      struct amdgpu_ualink_wb **wb_cpu,
-				      u64 *wb_npa, u32 type)
+				      u64 *wb_npa, u64 *wb_gpu, u32 type)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	/* The GPUID encoded in the write-back NPA address is the routing target
@@ -5881,15 +5881,17 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 	u32 accel_id = ualink_exp_accel_id(adev);
 	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
 	uintptr_t wb;
-	u64 npa;
+	u64 gpu, npa;
 	u32 offset = 0;
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
 		wb = (uintptr_t)remote->rb_cpu_addr + rb_size * remote->num_accel;
+		gpu = remote->rb_gpu_addr + rb_size * remote->num_accel;
 		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
 					     remote_accel_id, accel_id);
 	} else {
 		wb = (uintptr_t)remote->rptr_cpu_addr;
+		gpu = remote->rptr_gpu_addr;
 		npa = remote->rptr_npa;
 		npa |= (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
 	}
@@ -5902,9 +5904,11 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
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
@@ -6068,9 +6072,9 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
 		remote_accel_id, int_wptr, tlb_wptr);
 
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL, NULL,
 				  RB_TYPE_REMOTE_INTERRUPT);
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL, NULL,
 				  RB_TYPE_TLB_INV);
 
 	peer->interrupt.wptr = int_wptr;
@@ -6104,7 +6108,8 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
 	struct amdgpu_ualink_wb *wb_cpu;
-	u64 wb_npa;
+	u64 wb_npa, wb_gpu, wb_addr;
+	u32 wb_vmid0;
 	int r;
 
 	peer = &remote->peer[remote_accel_id];
@@ -6116,13 +6121,28 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
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
2.56.0

