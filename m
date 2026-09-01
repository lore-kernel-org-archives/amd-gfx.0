Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D094C624D6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C935D10EF06;
	Tue,  1 Sep 2026 20:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZQoY1JO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFCB10EEFD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRHSeU+eNwyHeRqWyHJh7gLQ5Y6Zdm5MSDaonDqG3hegkdDJ2T2EFOn5ErLvWDN3RMTI0ymEzKamkxUQ978wJ5TIQ38BzTs8hCcB37DruALRmGY2xTkifg7jSOkKKj8UlFEF8y/Y3r5V0Qn6PG3LxND3EqQl1u8qxDWznGoX66AGc7S7991LQ8eThGxQbZsptV1eeT3+zxIeHeIzCYGhO15BxTcJtsuj3gNw8cL8kOVPaF3m1lO2Y2D3GHKLrvTd8B8tg8PWNa3tv8IIVzp1ddNMwsqosmotBVGJqRGitNqGsw6jrb3TfHV6RZzLI/48Ecr1hJPplIpBwyrSmm+KRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1jDpVzs3+nh8raMoJYcVslHwK+aAwOwz3IOhW02mzA=;
 b=ZrKQ1jC+R/YaeFXxs+IoTJgo81ITSujp+G7w6Qr/k/dksXxLoc0PqSP6ndxPzPQQ+X4eyE0fsLPLDpHknCdfUpSz6Jthx75SYB4Z4isTgyMHid+q/DiW9NeNoGeTaGuWjNmqVCiCbmw2bKzTTUGCUekulmnWtt8ZV1+ULwtDe07q6OGN12p2pc8WXOPuHbt0nrBVxCi6O6jApBy7qaKrUQ01OeEF5qBvBExzUuwkaIDCwV4jrC8g/FXD2HRAQHhj4mQvuyV2vsF064ebvUlmLxnZd8BTrVxiEd9jKE0cmGtY8MIYa/RWqVphiHRV+9F0LvNrDQx36vsGBhSv596RTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1jDpVzs3+nh8raMoJYcVslHwK+aAwOwz3IOhW02mzA=;
 b=BZQoY1JOsuraPz6RkZH4SeuzHsgrs8PbEm1VF8C6WEfXNrGOKJ/0edHFPJtp9gf3rC8hxRh36oKVcMBiXPspuS5+SHhtp55kcapP29TfW/Hu6k2pdJ13XRgo0EiKUeYmkiEy+9m7uy5zi/G1VLdIyEvVLclM2Al5nmqlzqbYwAc=
Received: from PH7PR02CA0028.namprd02.prod.outlook.com (2603:10b6:510:33d::32)
 by SA5PPFE494AA682.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:58 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::9f) by PH7PR02CA0028.outlook.office365.com
 (2603:10b6:510:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/31] drm/amdgpu: plumb tlb inv method in
 amdgpu_gmc_flush_gpu_tlb_gart()
Date: Tue, 1 Sep 2026 16:10:21 -0400
Message-ID: <20260901201034.2960437-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf6dbd8-3230-46ff-b909-08df08652329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: V/VwauSvgFr1iHyqJyx2QPIQddMl77N6iEw3I+p/5XOMvNBGzY8nwjaMcSm1ELtcs76tvC2qwlTA9nny1O8CKSc62UuPwYeRBU3QZ2Mb+CNavlyKVKIH2QTSwaVWBEJDsfVj+TeiV7zEHD9dgMf/DlNQGJog57bdeBrW/xRgHbECvc94v958F7O6AEp8Si50RjZXBLZM5//MYvbvB5EHFQZmZMexiQpG3K51tqb+lyo/1uRmVLmym18Zi0hLwSGxtbs1PaR/9ReyqQQoPTWQWUQcgYTcLgmC1peaBM5wKRLXM2zFnPCT/p15Tb5UiPzHpUY5yb+TScBGBnrW02gbSQTYDdo7iKf4RsYxu364dkyu5cPe4nkIYtAq3LT7G/WG4MZ9gOv06FYdM7hBTuwZJDLorxoyqMD0aTjbv03yNtsEvEZP+4PDQ/igPo6aeyd8n+SG1nwI7gAK7aULtkG06qDMpBBXEsp/PKCQLetQRNuyD/0sw1im9nl6REdm1flzauuztRf8AoIiiGybsvOXlwgxv9XGCmvon85HwTWs0tZxXtJ0ME3lkL9kJnXx0piVaXkOr3s1fVRuZ68VaZ2tsqff0oyzs/G3ps5FkxNHvgCp6q3MfS30R+OC2iISNTw3Vu3DbN+3WlJGYPyWxDV+0KY0y4Ctp4NbcF+3rbMdRUfaFyTvKAdF+itf5Hyi0g4BkeTGyNIxAjYDOnU/Nak4Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UwnMzMpAw76E/0NfLjt71J0Q1u18lpx9LlTGdPYL3tWiq4h4Ke6Jb3i4o+gkqyahe8ZhuHaEE8xla6IcvZ+Jt+wArfZdsFGfkiTxzEhkSBPECOdz05wVpchKBBoC/qtmW6j/JyWfxHLUG/l0ruiKkWuZ9XdUzo2IrqmQHK+E1Ry1K85XcWrDx7ybtImP+yeSnlKzfO+1O7Lefw/yPeR1yVucXm9vXxj8eDY7VeNgz72WFkPwwfr1V6jClbzFTUTNj/EbHIU3u5Z0tPF9MF+b8Qm/9x0snZts5Ft7eebAUaMyD1VOZrWfhzxglL/g7q3CyAk0X2crR4EbB4i2W+aZcHhEoO2Wq62F6nwcbL+0LOcjMyoKZY0PAHvA2Q/aFhmSIixV8knu+Gcy8Egm+4CUDIGYeF9uO+W5bnyJGKY/LucLiD2eQpdIhS4ZQCVpMnpf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:58.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf6dbd8-3230-46ff-b909-08df08652329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682
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

Plumb the invalidation method into amdgpu_gmc_flush_gpu_tlb_gart().
Keep the current behavior.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 6af4ed2170b06..779f9b0974d2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -719,15 +719,25 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	bool use_mmio;
 	struct dma_fence *fence;
 	struct amdgpu_job *job;
 	int r;
 
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
-	if (!hub->sdma_invalidation_workaround ||
-	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
-	    !ring->sched.ready) {
+	switch (adev->gmc.gart_inv_method) {
+	case AMDGPU_TLB_INV_METHOD_MMIO:
+	default:
+		use_mmio = !hub->sdma_invalidation_workaround;
+		break;
+	case AMDGPU_TLB_INV_METHOD_SDMA:
+		use_mmio = false;
+		break;
+	}
+
+	if (!adev->mman.buffer_funcs_enabled ||
+	    !adev->ib_pool_ready || !ring->sched.ready || use_mmio) {
 		/*
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
-- 
2.55.0

