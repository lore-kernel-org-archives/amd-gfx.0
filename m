Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0757606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3WzvHHoK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C10010E478;
	Tue, 27 Oct 2026 20:00:11 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6914A10E478
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSNZKsMNE7jd4JLQ33ujg7XzWnk6spOh6di9sDXGEhyWQP3c/68MwlX3eYsybDh0WTVNCQS2KeOQ50g+b5m17sHQXlyxbX0RpCgKy1O8NyluKoGrNm3kuppTRW8Y9nq99TVO6E06twVqPGuCZOQAx5/KyipVILCSxcknobS/grNntf0ZWVtVUdng3CZlGTshj97q4jX/N8DropeDf44H08qQNa75OiRcConpaJ05Jdy0aXxuxBX4GKkrW75PNFiG10wobcVmhyczIJ1FLK50F88kl8SfANQSqE1zj70dr/VSeWh/F72gAjhLh7+IKCwHCkBgJH6/cKteYgIkx3AaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl/XoC08ri35EYHJFuaYT/dR52o7b8NgvdIBQuRD9CI=;
 b=mviG0Y5SED4Zw2dSTtYD5P44nCeGnCyVb18SNtDAk5UsI6ltl5rZPPCVeuKtrsjkcQkKV1SvT2Bp6rujT+hXVrNQUyDBC4QVp7+5S8UkC2dbpvTbvF6PzXxYJBcfObbOvcjwn3AF4XzUMmUTQhj4FfeIjrv2k44XwjqHp3cZzXbsXgyZk5kBl2RBtCfinn3LrZLEwYXdH/yLzQXPNpLdYDxrxOXC6rwdCT9mBW9jDwu2ZXQBlGFE1B1j+d+MB+bAs8tLSZzTnwmQZeSOYTw+f37S29k9yGj5AigDNtFyyCRORgPk8g2wgka+THTv5/8inVQYSNJjj16ngOqJ8d68CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl/XoC08ri35EYHJFuaYT/dR52o7b8NgvdIBQuRD9CI=;
 b=3WzvHHoKm8kEMdpALm4cpbNLo45EKczRvBZvEupuUz7C55wIPJ0gkA0qhAbUxTWJGdrWSEmc2LiYbbEaQbu7phEYJleSGVZIDQXi1GLFPiny3sDuWtYfHM9GKPTPvUXCpUkWGjMqcP91hwAXQFDZkyiG323O12R6mLUp4XKLb/M=
Received: from SJ0PR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:332::16)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:32 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::87) by SJ0PR05CA0071.outlook.office365.com
 (2603:10b6:a03:332::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:31 +0000
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
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:31 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:29 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 2/8] drm/amdgpu: Support VMID 0 GPUVA completion WB address
 for UALink
Date: Tue, 27 Oct 2026 15:54:15 -0400
Message-ID: <20261027195913.1794477-3-mukul.joshi@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: a94e5e4a-b03b-4d7f-ac8a-08df3464d112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|3023799007|6133799003|22082099003|261026121527099003|10067099003|261021123027099003|56012099006|11063799006|261021121427099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: wkvp/LPzhrxkE/Bwpodo4q/qlQzYASErE7AkCno3Oc1oVV0if02mssrVgx8c5pufFI/tcrZoC1uT9N9m1oI8nvofTHYPKpKQU7lLsMACcQZqIMZ8Wmk/HQzLHOMhBEhSo49g4+2M3WuCfYX0A0jAMn/r+OSEKRVEkE9yPPJ5r9Hcx/pJPg7Aq4Ex4JY24TWh50bnUA5dL+ByptGz9pOfnazket7xoan7PWaNAZJQsMxVhMF2B9kgucvQugexCnB7Clj/NRDe95JaA6MpLcJzgerbp6G/cZy/vWTpMQ0TMNpFC+vO2UST3JNtclJY7H6SilJHPjqmPb9I04+uryg5iL+cV6oZMA50T0novM2fptydU3sEdqPdYP3VNyrbYsep9QkNSuQbw51Y0j83fSN/EAt1un8UWQAJmtx5N8WShE7V/Wipr9gdNyVhnM0CVKR5pNLK3zowtpI/ldZ7rkP9RGgdvf41PhozyzDTOU+f3HOA+YiIiJNI5LwYQa2NlB3SS1by8JI0eGXQGzA769k/kmRNucAs/kIlRsivqgk8kb8CEb1sAJVQYbCPuTIBoir6Gk7VKVHMEexKoEShJjqVdjUnprLZp799g6zfJ4QKYl2Ac/f5SVZwH/jK/XIu8ZMokTzDg5YxasLnK+HruP76WKQFyowSIn+Net0Dm6HhoUpXWM0NEzdN+nL77O7PwDgXgfLUR/iXSWaIzpAZo1RQaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(3023799007)(6133799003)(22082099003)(261026121527099003)(10067099003)(261021123027099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jScwNipVLU4N9Af4GmPWBhmTLjzEnBdstfuY/gISqZO2x0w90hszEokDcfEUzVKj0x1mAiy4pJP/eij1zUImTwxI6vJPFdPTHaGoNKAA9vK735NocAyWsImexg5v4PDWwjiIdCKt6ACbxvhYJg/BPE9+uy9Q+qgoZiBRJorc2sWjKCVkObZjaOYX+wo4knP8hj47BPER6I4Lx3k7+Dw0ug4I0T+eqtyGaqNcj3qr9oij13lKJofazDvOEmz9ZowcCboDcCm/H44ppZ61Uhf9UWDGRLaUuX1G2Br2NxAm8jw7nXhVlwGlwl+KZdkLodhcWe+um8lyop3uRvkulr8f+L/Hu3DSP0ypTHP6/nF2OrPZ71MAu70pdCaKRq6gSvshqag3HzjcwctFhS3CCQaHFbXEVABlww3dv3izpCPJ0MI6m8TkT4vK/uFOP7SLgGPJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:31.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a94e5e4a-b03b-4d7f-ac8a-08df3464d112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
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
index 2cd6dc71ab9f..a186859dee3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5641,9 +5641,9 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
 
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
@@ -5857,7 +5857,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 				      u32 remote_accel_id,
 				      struct amdgpu_ualink_wb **wb_cpu,
-				      u64 *wb_npa, u32 type)
+				      u64 *wb_npa, u64 *wb_gpu, u32 type)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	/* The GPUID encoded in the write-back NPA address is the routing target
@@ -5870,15 +5870,17 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
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
@@ -5891,9 +5893,11 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
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
@@ -6057,9 +6061,9 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
 		remote_accel_id, int_wptr, tlb_wptr);
 
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL, NULL,
 				  RB_TYPE_REMOTE_INTERRUPT);
-	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL, NULL,
 				  RB_TYPE_TLB_INV);
 
 	peer->interrupt.wptr = int_wptr;
@@ -6093,7 +6097,8 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
 	struct amdgpu_ualink_wb *wb_cpu;
-	u64 wb_npa;
+	u64 wb_npa, wb_gpu, wb_addr;
+	u32 wb_vmid0;
 	int r;
 
 	peer = &remote->peer[remote_accel_id];
@@ -6105,13 +6110,28 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
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

