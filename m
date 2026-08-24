Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59DDC5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6E810E857;
	Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n8ua1OnV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C13710E867
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXQxmWQIV0gDAR59N3EnxJ3wy9D1cdrE3kYO16f6y5cz0ybb7VGGn5rfhaGkEhDM4+b26duGApHbv1o2ShbiIH1vsI66k5XXYtfcYtIZZFQz+IBA8dZfwC9z0xrBZS7ySWsbxKrnWBKftqcYQ5Y64pfE7FEKT+09xTleXcBpN6lYptzXCgjCoObvUPatZIdaRomBaa+dAC2f96PsyHKQLnCyVNSFinoph7L7c/O71nqcICiJ1kE9ulYy1ldA7vzbCfVIIQGYfnrkFFrZVTmVmOmAdiI1XhnG2FI+LrsSg5cjFeytghie/put2KyzsznH7cC1HyqEoOZPb7IGjqELHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MAF8EnS2n11vV9k+8X0JMF6pNF8GevizhGT1W30uv4=;
 b=lLBTO0fZr2/4TGZ7w/fTlAB2sCRpPzY4jcYpAWqIPgqxR0L4eT50xFPNtxUuhD8Xv8yFR4i9vQ3dZBqUHD2ozIiNpIRjO75+L/9m51xG5pk5o6WeCbMr8tcPVS3mcounzPhAosYChPqSIyMVzbBSM16ECO11ZhumBdVeSPrlzcvjVb19lmn620bWPZwuVW6rsu2SOa9ggEruUUOnfhfwzMDsH3GZeC2NR82hqEVQo8JClfMENFcbsjw7+cdkx7lVC43nb1dC09078NRwOJIV0tQgzzyE1WqcY1WybfkkU4YwNK7NdteHUl7UKQwie3QxA1ir7ekjcUuKDgYylpqmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MAF8EnS2n11vV9k+8X0JMF6pNF8GevizhGT1W30uv4=;
 b=n8ua1OnVNMb/RWau6Z14xMIQNs3SFNha/2rJhizFVMM/0b6JnuFhqfxIcDirFoRt8n4EHCtsORKlheWjA8xCwo1WZkxswBdAKWsWqbH5pBabVdPVeDAJ0cf9oJqt9fKEmdh2X9y2tAD0s7pgSqzV+jDIcERENyNEsyhpan8ErTM=
Received: from PH0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::23)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:14 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::59) by PH0P220CA0023.outlook.office365.com
 (2603:10b6:510:d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/30] drm/amdgpu: add tlb invalidation method enum
Date: Mon, 24 Aug 2026 18:13:38 -0400
Message-ID: <20260824221352.1793542-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b44386-30dc-4c59-42b5-08df022d07e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lBSRLui9XJqM39lCS0K2Mb3F8o0+6TbkyTgZNq6pbdqU2V5N+cIIUp7nWLX26DqElIK7rq3jBkTYDUwXPpPE5nihBxjJEdmqTvn11oCjrOMVRnuchCV44OlKOLUpCncqb1tPv7D8dS1fypNqoF+xoVO8cxZNsvl6bPIsHCVo97JIfXbzDn97jVOc2sLNFwfgBs2qTdKvWEeAS0rJrhk4mPCOSQvB6x/oivuPvbRMgGOvgO0M1g5QXXiuzFtVYMuafZfaQcL338JJiab9IKoXATwR9LN9YdaB/mD4A8DX2kReiwd+mmgkD9hqK1fuZ+ioGAXdlloU7hQfjG7GQAa1nrxVK41g9apW3bpk02aU3oqIHmd5XkSSqjuP+GaRMKFHV5wYLDRm0XSNFoDHQBznFLCPsDkkVEdNFy0j0cawcMulG0l3Xba0EAVZyfji/Iz9t7N9mCbF4vdq9ovCxmRApCtJ3Pfj6QShjzbcNQtn1zbLnl/ToPETYprJZl726shz8cXOP+hMuvcgweNhmzIutzMmOdfJKPZtanh04Gk5Of+HMFqVaenrRAEXM3LZ2lu2rsQA3urXnyir46V4MCpLU7ogWYVxwQtTBVzv4JvlXvkKTj0xyJ+8PMr9N6Zrcq0gaNGzBbgptKvdjGkpXNEggklIa2mvkCw+sYNmmh4sc4W1dQejylro6eLtr7G82L9inJJyJGZSgKROG+ZOs+SEIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: psMgwVkArUE+zCF+Ebj6JkJ4YDCdfQvdUWHunYpXHWcp21oz42YxS+UKngUTRSIO6NWdc1Irsw//JW0XGA9VsYr/MUobta4Ok1nA5DFTGVdTl9JIF9VZQhQoAOYJ+hLfU5IQrvqwbV6lpbhD9/QbngFtM4LkVZRB+FSNpQ7sqKNDNg7PSgMK3d0DfFn7X3LK7MeD4j2njkuHIKb+YFOv5/kw8KsT/IT3pvZ9Yw/vkwISIqPDFst9HOqUC+pnRd1kDRcy2z0pIuQDiRG3S5chiRZff2dc2Y3IEO7EpNU9W2fY9ke0FG9MoKair7TBWWv2Fwci7p2u/4dhdZCrx3ALwGpFyJi9U0sU+YeeZZPFdjC7Azwmxj6Eio8CcEAFXYcfIhkXJxY5Y8fXSf8F/4NABZUEltbk5cMFob3IJ+efLadRvI2jFUmQCJaLXOWIVqzG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:13.8514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b44386-30dc-4c59-42b5-08df022d07e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

Use it to track invalidation method.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 23954e3180a8c..204cf1c360896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -98,6 +98,13 @@ enum amdgpu_memory_partition {
 #define AMDGPU_GMC121_FAULT_SOURCE_DATA_WRITE 0x200000
 #define AMDGPU_GMC121_FAULT_SOURCE_DATA_EXE   0x100000
 
+enum amdgpu_tlb_inv_method {
+	AMDGPU_TLB_INV_METHOD_MMIO = 0,
+	AMDGPU_TLB_INV_METHOD_SDMA,
+	AMDGPU_TLB_INV_METHOD_KIQ,
+	AMDGPU_TLB_INV_METHOD_MES
+};
+
 /*
  * GMC page fault information
  */
@@ -369,6 +376,9 @@ struct amdgpu_gmc {
 	bool override_pte;
 
 	bool use_mmio_for_tlb_flush;
+
+	enum amdgpu_tlb_inv_method gart_inv_method;
+	enum amdgpu_tlb_inv_method pasid_inv_method;
 };
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
-- 
2.55.0

