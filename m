Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F675CF887F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 22:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE79F10E08A;
	Thu, 20 Nov 2025 22:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xL41CUqq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177CA10E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 22:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTwtd1wHaq6V+ChevKZA9q24XzkpkIX3vBFRz8dZtsWmgMtKFWlcCsxJNbtSLrX+z06hdM9VoL2b/5npQrSjhF/Q8gdrd8hu9ZkYy/146Os0abZHg+P/N1Bte8/fa8wQ9Vu/JnZufMJ+b8MOJC2hHazjKxeEl/FDlUJGc+6YC+K68OmVdNStsQfCa8CyybD+sIwetiJ13j7jrc0hZy18Bcz5nClVsAUwUbnOX16Ia2eqzuG7DwbW3+fE3uuOcFI1ejXsExT/FnN2qKZOLZqSPsCz1ctUnNtjhzsSWE8YC1zprh2tHipvjPxK5sD7Wqt0oxGihdTvxpxbGEKnQxxL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2EaGm953MXc9NEqloooFPvj7M5WpiNgq+FyJEk9F1g=;
 b=BxpjE/oAvbDaubFUD1iPBCqX7BSSc17HHfYDiLYD24ona81Nz3RvusueOJECw2KcZDaz0LPdub8RQRNUgWn5MdyztwwMJJTlOu037mMpYN47fSK3RNHg1BObxcX5FEPfT+MgnQJt9LZJXw0KY0aOT/+a5oWiH6xvGFMW9i8mO4xY0O3nPzDpKNUEiyWBKtxToJMuDs3Z/ZPg4Rv5YI/NiSSIS4ESqTOGG+5VZbXi8yew/z8gJqU+AzZjvC7hmi5n6D0zXaKdm2coD8coxpXh1I1agm2CHzxuPnrUbM2SHe3noCcerrA+jy7pEkBNC6aBXLRCKqg58zP0kJmfvhJ4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2EaGm953MXc9NEqloooFPvj7M5WpiNgq+FyJEk9F1g=;
 b=xL41CUqqaAWY9yI7kv0O71N7k4iBsRDx8b7aLCrWkEafLfkwMLLoCJiTJ3m7ZhC6PLSlvO4OjlDGWYhNkELKiU4odJs87Mkv6HvtMUTfeZwjaJP9+Uax+iM4AwNHSVbZ5l3VHPInju0S2dHZXKalsQtZKgXFZNeSH/6Fwqh42Oo=
Received: from BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::24)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 22:52:07 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e2) by BL1P223CA0019.outlook.office365.com
 (2603:10b6:208:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 22:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 22:52:07 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 14:52:04 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Update Generate PTE/PDE SDMA packet for SDMA
 7.1
Date: Thu, 20 Nov 2025 17:51:46 -0500
Message-ID: <20251120225148.23345-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120225148.23345-1-alexander.deucher@amd.com>
References: <20251120225148.23345-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 2446f31a-1e8c-4bb4-6c52-08de28876e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ECNLe8hHRY28HJ+/KDCsF8CV4SuUln78JYW8p/1riDF/yBrZwBBmd8gv9QoU?=
 =?us-ascii?Q?h6kQsr39xAbIp5RxqWuDWwOkqyWVas+3IPeVwbCv4jSIFoSnMbsosGMGdBIg?=
 =?us-ascii?Q?BrAG+zMzduCl9tC+aZUUMgOa3+UlGBGKeZzy8j3A/H03jxBLKU4mXB5Tk+Da?=
 =?us-ascii?Q?O1UbD4UJMba7t6k8cpqvIPVjW7H9Tuv0+zZChYSMImQmQBYMP+eDvBddbScD?=
 =?us-ascii?Q?1isL/Ywf6E7NdUGl4ep7cfIl/6G2aQWcC8z56AjeCQ4EkHTa3D8HnLdeqh8n?=
 =?us-ascii?Q?y464egDBqpP5b3Id1eDFLu3fLS0xqdv71b9qyHvxtsZbgX/pcYXk/Ltl+tCh?=
 =?us-ascii?Q?nNbZWSTPwcff87+axYNgY27zNHxkG0/0xGwlYx/uHCyT8KCeiFTLYp7xNNir?=
 =?us-ascii?Q?xZtj1+OKnaL96KtBG/AjZ0VVUa+hJwgF5Pw9w9bRXQc6E/HVluYSu1o4hSTk?=
 =?us-ascii?Q?yjGq3eMR2mBQRBZ4vO4AqTGqZkHxwbpUskD9D7FnGqsmoIAPQY51TRi1O/vf?=
 =?us-ascii?Q?mzMnNsZchZKqwe3lqFIv1+BEYob9cxUTLBJwpFpacw8u7RGyoeH3WjmsKkS5?=
 =?us-ascii?Q?W4604EjWgZpfvb3EQdNZzQRbXD/dyGOnMwFxa+0Vm7E+dNBw9ruSYATrmpSA?=
 =?us-ascii?Q?AoV06o04bZpZk5YWhOlZVuP+UcIfpxSRrJVfFyDBKav1G6wQxjccA0RMXSvo?=
 =?us-ascii?Q?A0y88QMdfAYT1T/hNLQ2ZlkB3pFdMYQPalxER51jC4tzSwA74OUTgMgwhMip?=
 =?us-ascii?Q?xseG+4ur7GwCsNG4AuHzvaMkSLTfIy92W+uwUXAV/os0iDu8LGloa3QbGnb7?=
 =?us-ascii?Q?5fsXVaXg51T80DPUWtdi8zWnS7g01sMD8DHdq56t4kqAb1qpa9bbtDxqOIBB?=
 =?us-ascii?Q?oECetwlPCE7JMCjQ87aYx+tWrXzMF46704wfsVJgtJf6oAGbPEFO20l+uXz0?=
 =?us-ascii?Q?2NZKOxcdhrYlz5Q34HmUHMrPwvBb/MgPfZIFfCw+dJBrfE3pslWkVhqv9SaU?=
 =?us-ascii?Q?+VKzzlIASPB7Rj7yecg1SyRDiiRCemrj/sAka4hmlZxwYjcnvEeVlAsZ4XzT?=
 =?us-ascii?Q?325e7NMwhSj6947ULXL9m4WQ/rv0jz0x8syY/S2EnbX6xS+Si1ItkJVOqeLm?=
 =?us-ascii?Q?1UKv0LcnswTm4uVjofuxPZzsie8KRoUv2GGQZ/1AZF37tn4dyKWNK2E9dnqP?=
 =?us-ascii?Q?f7ekG5oWbG0QkBJBqmmsnAp9QwQ97QoRbymj4HXO50jbnQjyeD7WwyYAoEP/?=
 =?us-ascii?Q?4DdymOR9H8QgAQBcGCSUElaPQBWxbBUIhb7UZkNLaglH0+Odi40E6IT5cpmG?=
 =?us-ascii?Q?2TX9F7cRkzGdgWxd8ECaFqbsAJGCeoenHMCAFGr6p7Zog7MVFd/epAJdRRyE?=
 =?us-ascii?Q?kER3EstmH95e/mHkYHfgIfeHdgNxbODkcN0wBH+8vjhzVubJP3Idz9bdf0Dw?=
 =?us-ascii?Q?QzeSE+GiiyAORr/3yAzFFiFDvc7ugT6EJBvVwg8IdmOprqyCkWLlE6ro0ae3?=
 =?us-ascii?Q?CcGsozRrFvDaYZqWfHLbJBztlhksRiIxmI2OFdofRJYZgm8UxPoGgyhGDJUs?=
 =?us-ascii?Q?dYBcA6PFTbQci26xZrk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:52:07.1362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2446f31a-1e8c-4bb4-6c52-08de28876e71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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

Update the Generate PTE/PDE packet fields for SDMA 7.1.

v2: squash in mtype fix (Mukul)

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        | 11 +++++-
 .../gpu/drm/amd/amdgpu/sdma_v7_1_0_pkt_open.h | 34 +++++++++----------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 2cdb6def010e3..89ce07ae18b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1155,7 +1155,16 @@ static void sdma_v7_1_vm_set_pte_pde(struct amdgpu_ib *ib,
 				     uint32_t incr, uint64_t flags)
 {
 	/* for physically contiguous pages (vram) */
-	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_PTEPDE);
+	u32 header = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_PTEPDE);
+
+	if (amdgpu_mtype_local)
+		header |= SDMA_PKT_PTEPDE_COPY_HEADER_MTYPE(0x3);
+	else
+		header |= (SDMA_PKT_PTEPDE_COPY_HEADER_MTYPE(0x2) |
+			   SDMA_PKT_PTEPDE_COPY_HEADER_SNOOP(0x1) |
+			   SDMA_PKT_PTEPDE_COPY_HEADER_SCOPE(0x3));
+
+	ib->ptr[ib->length_dw++] = header;
 	ib->ptr[ib->length_dw++] = lower_32_bits(pe); /* dst addr */
 	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
 	ib->ptr[ib->length_dw++] = lower_32_bits(flags); /* mask */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1_0_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1_0_pkt_open.h
index b4fe046d2a06e..b051e4f920884 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1_0_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1_0_pkt_open.h
@@ -3445,23 +3445,23 @@
 #define SDMA_PKT_PTEPDE_COPY_HEADER_sub_op_shift  8
 #define SDMA_PKT_PTEPDE_COPY_HEADER_SUB_OP(x) (((x) & SDMA_PKT_PTEPDE_COPY_HEADER_sub_op_mask) << SDMA_PKT_PTEPDE_COPY_HEADER_sub_op_shift)
 
-/*define for tmz field*/
-#define SDMA_PKT_PTEPDE_COPY_HEADER_tmz_offset 0
-#define SDMA_PKT_PTEPDE_COPY_HEADER_tmz_mask   0x00000001
-#define SDMA_PKT_PTEPDE_COPY_HEADER_tmz_shift  18
-#define SDMA_PKT_PTEPDE_COPY_HEADER_TMZ(x) (((x) & SDMA_PKT_PTEPDE_COPY_HEADER_tmz_mask) << SDMA_PKT_PTEPDE_COPY_HEADER_tmz_shift)
-
-/*define for cpv field*/
-#define SDMA_PKT_PTEPDE_COPY_HEADER_cpv_offset 0
-#define SDMA_PKT_PTEPDE_COPY_HEADER_cpv_mask   0x00000001
-#define SDMA_PKT_PTEPDE_COPY_HEADER_cpv_shift  28
-#define SDMA_PKT_PTEPDE_COPY_HEADER_CPV(x) (((x) & SDMA_PKT_PTEPDE_COPY_HEADER_cpv_mask) << SDMA_PKT_PTEPDE_COPY_HEADER_cpv_shift)
-
-/*define for ptepde_op field*/
-#define SDMA_PKT_PTEPDE_COPY_HEADER_ptepde_op_offset 0
-#define SDMA_PKT_PTEPDE_COPY_HEADER_ptepde_op_mask   0x00000001
-#define SDMA_PKT_PTEPDE_COPY_HEADER_ptepde_op_shift  31
-#define SDMA_PKT_PTEPDE_COPY_HEADER_PTEPDE_OP(x) (((x) & SDMA_PKT_PTEPDE_COPY_HEADER_ptepde_op_mask) << SDMA_PKT_PTEPDE_COPY_HEADER_ptepde_op_shift)
+/*define for mtype field*/
+#define SDMA_PKT_PTEPDE_COPY_HEADER_mtype_offset 0
+#define SDMA_PKT_PTEPDE_COPY_HEADER_mtype_mask   0x00000003
+#define SDMA_PKT_PTEPDE_COPY_HEADER_mtype_shift  16
+#define SDMA_PKT_PTEPDE_COPY_HEADER_MTYPE(x) (((x) & SDMA_PKT_PTEPDE_COPY_HEADER_mtype_mask) << SDMA_PKT_PTEPDE_COPY_HEADER_mtype_shift)
+
+/*define for snoop field*/
+#define SDMA_PKT_PTEPDE_COPY_HEADER_snoop_offset 0
+#define SDMA_PKT_PTEPDE_COPY_HEADER_snoop_mask   0x00000001
+#define SDMA_PKT_PTEPDE_COPY_HEADER_snoop_shift  22
+#define SDMA_PKT_PTEPDE_COPY_HEADER_SNOOP(x) (((x) & SDMA_PKT_PTEPDE_COPY_HEADER_snoop_mask) << SDMA_PKT_PTEPDE_COPY_HEADER_snoop_shift)
+
+/*define for scope field*/
+#define SDMA_PKT_PTEPDE_COPY_HEADER_scope_offset 0
+#define SDMA_PKT_PTEPDE_COPY_HEADER_scope_mask   0x00000003
+#define SDMA_PKT_PTEPDE_COPY_HEADER_scope_shift  24
+#define SDMA_PKT_PTEPDE_COPY_HEADER_SCOPE(x) (((x) & SDMA_PKT_PTEPDE_COPY_HEADER_scope_mask) << SDMA_PKT_PTEPDE_COPY_HEADER_scope_shift)
 
 /*define for SRC_ADDR_LO word*/
 /*define for src_addr_31_0 field*/
-- 
2.51.1

