Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85A60A262F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W6iTIKEj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364E710EE60;
	Tue, 10 Nov 2026 07:44:22 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1CE10E2CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 07:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNek+j9YNHgBlP5IKoxBFjOAI+ED/Gwgxboc/5sYCuH/ZhGg68OoFHCwkKjVExep4LDybE2S4afbxbS7qQ8w8gGm+utPWJTA0WNvWLh27Ufvp3DysBXpjzJx6KrYrqvO3NZa8+8n6ZXTDSrsqcbtQBZ6LZ6pF/sE81XQfXHyjQeW2002V5LsKqa8GV/B7wihSe6TFyMsAb8OiysH0KS+BOTfTTbwiOzBHk1sj3NakoZtVeJa5Lls7FUjjSRx6c9a6n24SKcL+07BBnn7CTe9IHAhJEnzFVYeWhQO9vIdO+/+XXfQ89A7EQSaFa6dcRhmCivuf+AwLG4zyHKcUtO2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkD4vOj0if6UTayZq6f+Ro6g+J90QR05GAiYE6oT/8Y=;
 b=SK8UVbQsR1OEyYDHDBpm755YqJBdVy7WpY6E+0VhdQX2yV25rOOqx49UDvrVen0IXJ7Us0ALBy8tK6f7EskFHAKpc1e7Wm5i1cs3sErag8infdHPk2SdhEgrkz9poePPlUwZlRUwppZTnuN4GDdwF+8lL9DOW9acOvlAeuL7xhnIj/CMMPtId3tS4hqTr4yLPUL/7l/MDCbCKZAheh7QMaLzSyhwQ6ZAnfOLJM1hWEVU4LdGB9vrJA2g2DhKQhpreLnvb6lqrecL7gaKlk/yqhorJmV3M6z7RwpNCnAqHs/Y970CYH0pkiIxwm0Wmod4EBIScn4lkCj3TtPR6ckbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkD4vOj0if6UTayZq6f+Ro6g+J90QR05GAiYE6oT/8Y=;
 b=W6iTIKEjWkIoxU7KZW3NMTUTjJ6WmhV6blotcey6T/yRmnqyLB+XiDkYDkcQurLmNnfqMsdczh7pFEDv9uvqwPAeHQeCVoRp+UJHCnibx+Ehq3RLrrHJIWdrPFK51Guv81Dg4u562XtNRdEVJRinU43shywpdXaU60m7ccI8pHk=
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 07:44:11 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9b) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 07:44:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 07:44:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 01:44:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 01:44:10 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 01:44:09 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, <philip.yang@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: keep the DMA addresses of a range intact if
 splitting fails
Date: Tue, 10 Nov 2026 15:43:37 +0800
Message-ID: <20261110074407.3360908-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261110074407.3360908-1-Jesse.Zhang@amd.com>
References: <20261110074407.3360908-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 19eb5fd6-0f0b-4a04-9933-08df3efe692b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|10067099003|261028144727099003|11063799006|56012099006|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 8wpakgSD4CSJ5kaB7iNnST9yWWUNlXbZiLmTLPM8lR37RolVfri5dHwIjDMNcqUlYRNOMOfXOt9SHKGSZvH31xRzH5YlvNQVAQTFQXR/ZHAj7daslH170kwEacah38TPvWSls9SF31fTZ0aisxfwrMLXYO0umPZk/cf0fjkSrcYUzU6iok+rUs9RjiqkTQ/9Wj1xew9tVfyBa/AN1za4ATv8KezoYSgkP2k4hpzXWvQqVhzbBOC3ZJewXi8ECP3XSZiltW4jP1vx3d8XIOEVt5+5DmPLseoInjzF81fVUDXDgCmp2TbhDcqgHEtU0D4oGBt045dDcGoBKVsFCDD4vRFzhra0nKgRuaoPgIbjE+oOTcksVyRvXUz5kjWbCULtWTTsXFVxCUoiNgygj2MQEsemgY8lySXj8UUlJdwreZS1HhIka4tai40yZGQ6+mSirH1GfuxAZ1cfJe+OKO9nsY4fujACoqLe49aoTAirDTQ5wl4BWGaueKxmENWkW3CEqYpSBIRgZATiRmA3+VEa4sZ0XS/6BWVFG/IdlJ7lfIQBAGRUJWJw/Ee8PcsLP0iRZEwsVBR+IqMcDb3qQLbptgeA4YevyEmmqj5roBkdle3nn43GM5uGQaU1EgeMMdWAtZm0gU8b5d0KgMLPzwmafuVR9g/VIW4gVusqRZMQzbz1Hcp1Iw6L/xfaYPTpsj18MwL4oI01Z9BaJwj6bt//ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(261028144727099003)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IB5/tvenE82dNjFgU0tif/TpfWoRJp+UlzNvZytsOFlOfD4iUuK7W5uhNb/XpGig9mVLKIr+rbJQvjhXCQF1EWsXuoCBxVCFKHB5EAcn1JH6TXiox2v94gzmMz8x+p9uobflCjMkXBbaabfJimXOA6htPJubDUcay+FyjzM8gPnWYEFXI5VGUOUED9uVC+Be7BOJm2OcaMoXANDsZYZzpK+PPqDYhGSmtKK6gNRZrirPJD0a1d9lobho9LlqTEIAlrNyqdKmT1VNJ9B539cVw5nx1QcUTZNhrrjOjIKI/YPu/X8cOxBfooDNZjt6IYcH1LXSzsqOVDDe1+FMFvCiGfxRBXpREU1bfFMzK5H126q8MZqI86K2Om+TTh3Lldosz4jI48r7fisYBiDjN0q212scnCwNb6FUZXCV0rCu+eUFptM7rw31S3N5G9k6dJTJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:44:11.6612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eb5fd6-0f0b-4a04-9933-08df3efe692b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737
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

svm_range_split_pages() splits the DMA address array of one GPU after
the other, and each split replaces the old range's array by a shorter
one. If a later GPU's array can't be allocated, the old range is left
with the arrays of the earlier GPUs already shortened, but with its old
size. Unmapping it then walks past their end.

On navi31 with its iGPU, an SVM range accessible by both GPUs, and
unmapping a page in its middle with allocations failing in turn through
failslab:

  BUG: KASAN: slab-out-of-bounds in svm_range_dma_unmap_dev+0x13f/0x170 [amdgpu]
  Read of size 8 at addr ffff88819ac32800 by task kworker/8:1/171
   svm_range_dma_unmap_dev+0x13f/0x170 [amdgpu]
   svm_range_dma_unmap+0x119/0x2c0 [amdgpu]
   svm_range_free+0x312/0x520 [amdgpu]
   svm_range_handle_list_op+0x326/0x500 [amdgpu]
   svm_range_deferred_list_work+0x338/0x790 [amdgpu]
  Allocated by task 2749:
   svm_range_copy_array.constprop.0+0x55/0x190 [amdgpu]
   svm_range_split+0x388/0x17b0 [amdgpu]
   svm_range_unmap_split+0x254/0x370 [amdgpu]
   svm_range_cpu_invalidate_pagetables+0xb29/0x11d0 [amdgpu]
  The buggy address is located 0 bytes to the right of
   allocated 2048-byte region [ffff88819ac32000, ffff88819ac32800)

Split the arrays of all GPUs first and only replace the old ones once
all succeeded. With that the 2759 unmaps of the same sweep give no
report.

Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0879e37faa71..3dbf8002da76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1008,7 +1008,7 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		kvfree(new);
 		return -ENOMEM;
 	}
-	kvfree(pold);
+	/* The caller frees pold once all arrays of the range are split */
 	*(void **)ppold = old;
 	*(void **)ppnew = new;
 
@@ -1019,19 +1019,36 @@ static int
 svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		      uint64_t start, uint64_t last)
 {
+	dma_addr_t *old_dma[MAX_GPU_INSTANCE];
 	uint64_t npages = last - start + 1;
 	bool has_dma_addr = false;
 	int i, r;
 
+	/*
+	 * Split the arrays of all GPUs before replacing any of them, the old
+	 * range must stay intact if one fails.
+	 */
 	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
+		old_dma[i] = old->dma_addr[i];
 		if (old->dma_addr[i])
 			has_dma_addr = true;
-		r = svm_range_split_array(&new->dma_addr[i], &old->dma_addr[i],
+		r = svm_range_split_array(&new->dma_addr[i], &old_dma[i],
 					  sizeof(*old->dma_addr[i]), old->start,
 					  npages, new->start, new->npages,
 					  old->actual_loc ? &new->vram_pages : NULL);
-		if (r)
+		if (r) {
+			/* new->dma_addr[] goes with the new range */
+			while (i--)
+				if (old_dma[i] != old->dma_addr[i])
+					kvfree(old_dma[i]);
 			return r;
+		}
+	}
+	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
+		if (old_dma[i] == old->dma_addr[i])
+			continue;
+		kvfree(old->dma_addr[i]);
+		old->dma_addr[i] = old_dma[i];
 	}
 	if (old->actual_loc) {
 		/*
-- 
2.50.1

