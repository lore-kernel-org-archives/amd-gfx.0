Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79DFCCF9EB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 16:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407A310E4EF;
	Mon, 27 Oct 2025 16:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3a3vD517";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FBE10E4EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 16:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNuASRKLKuGQO63EkTBAGvmFTDbfNLaLZtk3y0DVKg2OoPVreAxMH+6T2TB7IWkI0++2Vi5/W0q/XuWdQCutW24jaaApXWpXe8oejQEzIP32F5C4EMyyKUIjpXUHftxWSNUN06YikBYa/cIMxJsOjlIZ9IFw+SbijBzXpAOvAvn35fsBYAge+5mLO7UrYF7ZdrAtuVIQ7eFJ46EAKwUvmikTse3cHB4Qnou30BtojiW4vW++BJc8L611BiE0X90DUpWi5eUoqcld20Tu3nJhxP9zP2HfZPCUKws56w8tJohHQ6nX4Z3eEE5PioikzL9Da+M34+t9rQlovSgDlRrD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjfNAvzS7KoIKzEffJMmRJrZzBx/cOQzgw3y6Rg4zkM=;
 b=x4Z/q83t81xSWuoe8vKhKVsJpjHRkpw6JIlTa4tZ9xqkbFNCM/fVMqwkovwacE2bKDoLeOXaRnLTVnVepgjt71o0ojSRpj1LuzEvblhefQHoOVqsk3/0wnWqLD6/Fe9Qa2WmUwb6mOe8A90bmtCvNB4fIK4KJj3kCw72i1UFM+jrcQa/OoSxHAJfJtTfADstUj60/WJ6t1pJGNuBbWVKh5WSwT83t/FQA3XlzzDyx6cekxbnz6Ee4eEMhP0l+ArNkNFo4H7C+XOlQFwCwoFOMMDDlOZCfbAj4KB7IeWyNZ/yGNjdND+iMI+BhzD3G/3WEyAhobjs/SffeXt14R58mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjfNAvzS7KoIKzEffJMmRJrZzBx/cOQzgw3y6Rg4zkM=;
 b=3a3vD517jXHNDl/gtzuY7MiUFeOciooVyWppQhXWPog9iDf2gb44dS2UEv0MCUg1qavGQnfceS3W8rj1WKKL7Edfcg9HRjoR6STG0pNjnr+z4GmGEhWKd9e3dEzOGq1EHftLX0s9dt16itm3B6GMtqL78s0o5CzLRF6jlEIHZw4=
Received: from SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 16:21:38 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::39) by SN6PR16CA0039.outlook.office365.com
 (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 16:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 16:21:37 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 09:21:34 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Update invalidate and flush hdp function
Date: Tue, 28 Oct 2025 00:21:13 +0800
Message-ID: <20251027162113.3284600-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4748c5-2f44-4676-a306-08de1574e7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Svto7zoB1CBUQjv6t0I8Z/YjYvtn1UZtNHFAv6ooFTuwUjpgvr5DJROM/qJ/?=
 =?us-ascii?Q?nR7ssWTPlr1WhbItSIWwTVnxrl7BPmpfQufyCz22yl8kEk+6kwABdkRolVlm?=
 =?us-ascii?Q?IfMo4E5bbcDYX68Qud7DLMaVqvDfb2rmadERZ3YyNU7B1xEgqXv3IBODiV5J?=
 =?us-ascii?Q?gyOfj9cCYcArYXRyNBe+90husiCM1tp00Y+K82FolBXNrR/Udml0zYwuaP5r?=
 =?us-ascii?Q?iPYEQCOcYEgvA4hqopmOKTJOUNlj62IBXnsjtqKnj+I6riVOkjbGr88wcvRW?=
 =?us-ascii?Q?EmRQ8HWw51upVpMfwL65FaUde49rKGJffTECsHWtdURcngPeC1SVDL1LT5wd?=
 =?us-ascii?Q?Io54hGcKtloyGLC8lVrwtqMbS7V5NvohLedVSbTVzo0RC045LMkWAP9vwFcf?=
 =?us-ascii?Q?COKcVbsez5piBxoHNzr2iy+UNo9WZzfdUDrkfvKK9qNMwHUV3+SwtemO/fpZ?=
 =?us-ascii?Q?t1Ms1cIPmF0eIoCn0GOSVzFg8pVIwHSeBOG6rnvNyqxndg7szHUIQXKapoKq?=
 =?us-ascii?Q?RVF4pMVxRSFn/DfC8BzFu3eEMUUtEUYObKLtedB2DVRjM23oz/HUiRmh0PVz?=
 =?us-ascii?Q?VPzfRteNFEk+uXpJaE7nsFfjyBK2hPQ0A3OZ3hRG+6yVXEM56/8r7Q1GE/so?=
 =?us-ascii?Q?7rWWmvSjMbj5j+Iprdm2gQj5kWVbF3ssIFKs0B13hT6HisgIFF8luMQ9q9I1?=
 =?us-ascii?Q?Yz7mPQ5/LUqCjFa4gfZIwFNU9RTr7Q136L6/1TcSMiZvGdVDa3SO5z85PtjR?=
 =?us-ascii?Q?ICPFF2EHOEGqivhFQ7vxiNwhI5fwAI7RqMkh2/owKO5DOKy1r7CnOK+sy3vX?=
 =?us-ascii?Q?nzunYuv7sWI8q96e8L6biI9v0P9OHCYzuzzslmYkqCaI31LxABcBKotVlgM+?=
 =?us-ascii?Q?QCCcbo38qeAmgad4oau+Y9VTdxMvc+2pfOTUv0ktk6xzYGDIK/DYRKf3PPeT?=
 =?us-ascii?Q?5btVE/mmo4agEE6CVEsGX0bGSOnXuV9eInt3IHiyr9uG3KN463SPc4qY7WiQ?=
 =?us-ascii?Q?bz96neAvqkVAqcaTOiW134EERGWy5RXrq796lWnPX/uCL2Bf+E00wlV5W7mF?=
 =?us-ascii?Q?tF25pSewNbgXR+jpTMUSamNPUTiQlCHErqvbccoRFrWGHpWKNnyfcdXrcySL?=
 =?us-ascii?Q?ib5lVscckHXK8S4mYHieMXUZiT19GkqOVW3cNKjhSu/rgAiGydG80Hj0TTju?=
 =?us-ascii?Q?OIs6wQ68zxFJdGKHdSS092400lxt421yaeylEEzSPiIgVYz6A6JlfIKC/Z6s?=
 =?us-ascii?Q?lIBwxqkq5Fx7HNDx0Ace+EtfqKgNd/E/4OcIqJ6IW8aIRwqssWkoEIE/xvrU?=
 =?us-ascii?Q?uFvrEOIg0OIv1QLmojcJM1GBIW9oOI4qSOdJg/yYVgD8k1koYrgfJRsA1YaK?=
 =?us-ascii?Q?un+hIB97Cdx3pI6B6GNW2mOVxStY95cFmQgPKd6ftKNWP/inYO2s9E7eHULf?=
 =?us-ascii?Q?xJ62GQeWC3++Jhe2IopfDIRuSOzJU1fBjAJ85bYw8t/HchIKRSwaSXL900Gn?=
 =?us-ascii?Q?iPZKb/rHShAWVXU9mM2KNEQRarYr4OuRWxYM3DUULZ/MflWdDuk9kTsBaRDC?=
 =?us-ascii?Q?01VTHSyxfyHqNa0uRmg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:21:37.8905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4748c5-2f44-4676-a306-08de1574e7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

Update asic_invalidate_hdp and asic_flush_hdp function to check if ip
function exist, if not return void

v2: Use else/if (Kevin)
    Update function name (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  4 ++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 50079209c472..d1137d8beca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1539,11 +1539,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
 #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
 #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_flush_hdp(adev, r) \
-	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
-#define amdgpu_asic_invalidate_hdp(adev, r) \
-	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : \
-	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs->invalidate_hdp((adev), (r)) : (void)0))
+#define amdgpu_asic_flush_hdp(adev, r) amdgpu_hdp_flush(adev, r)
+#define amdgpu_asic_invalidate_hdp(adev, r) amdgpu_hdp_invalidate(adev, r)
 #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 6e02fb9ac2f6..5a60d69a3e1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -66,3 +66,19 @@ void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
 				      0);
 	}
 }
+
+void amdgpu_hdp_invalidate(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	if (adev->asic_funcs && adev->asic_funcs->invalidate_hdp)
+		adev->asic_funcs->invalidate_hdp(adev, ring);
+	else if (adev->hdp.funcs && adev->hdp.funcs->invalidate_hdp)
+		adev->hdp.funcs->invalidate_hdp(adev, ring);
+}
+
+void amdgpu_hdp_flush(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	if (adev->asic_funcs && adev->asic_funcs->flush_hdp)
+		adev->asic_funcs->flush_hdp(adev, ring);
+	else if (adev->hdp.funcs && adev->hdp.funcs->flush_hdp)
+		adev->hdp.funcs->flush_hdp(adev, ring);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 4cfd932b7e91..d9f488fa76b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -46,4 +46,8 @@ struct amdgpu_hdp {
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
 			      struct amdgpu_ring *ring);
+void amdgpu_hdp_invalidate(struct amdgpu_device *adev,
+			   struct amdgpu_ring *ring);
+void amdgpu_hdp_flush(struct amdgpu_device *adev,
+		      struct amdgpu_ring *ring);
 #endif /* __AMDGPU_HDP_H__ */
-- 
2.46.0

