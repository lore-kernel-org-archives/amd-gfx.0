Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F36ECD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 22:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06EA10E00D;
	Tue, 19 May 2026 22:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtHsaW/3";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDACA10E00D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 22:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktbyKRDYC3O7vkmVvNHcrXMrbKCWoCK5zQYMfDdngQp46NtRtT5qhH2ioaBRWqyTuaWrhNozopak/jqZtZAaoPjEJo/qk+Lo00W0v7MkTXjcFSBrQuVKRLxz3UcpRi7d6kv4/Zn6A0uCMH9ofI/dTxBPoz0kc2oj4jtiFIWa8vD44H/rt7WsZhKw6fQBtHRZPoskeXUqr3YYwP0AYqR6g7XdC5o5y66YKvvBPqjJzu1yQjqRIQvrhJ5kUvekZFteVUb2uuebAxjFW3j+yMRYj596eWy1fmRKal24lTJI6xvtHbIU51YRhW4mJmJm0T9B3gaMeDEFIuLJx+h3kXWGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhRH/OgPUA9Jk4YhO2eGAtgXIHtYVgoeGLOpkgWPbeY=;
 b=NClNhpu6qujlqj1HWp9PNmNcJrvx/CEsaUi3vULS7z2zrTGuak/2uwd7NOfNvFCWxrR6Qkl4R5j2kAbN8eftZYcHZEBpORv4BI3LmfhKd/p8poMI8D3RCiiA8PrU6CFhrHumemmzas0IDLlAnT2cVwAqiYtW6+uHIMkKDR6PMvrBejYT1akhenTWjSMhvnxXzyIIWKYzIIzl8jJiVNNzzZyHyU5CGS/LEojIucujkqBqexAgn+/ixOp4ZmzZK7Vb4ovEwozS8nI8x8/O+V27EZOKZjyaCG3zEwhS9fVdmIj4U9LvarkghuHhMYXvBo9oyhC4kFx8wfwnwkSzE3VWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhRH/OgPUA9Jk4YhO2eGAtgXIHtYVgoeGLOpkgWPbeY=;
 b=JtHsaW/3TEOgw8hVlxDsF78SlgQzOZf7g+Ed9YfAJHb70KuhpwoTd0hx3DyOh04Q400n4LFqHlPThnRbIW5ZqpmL5J3k4fD4vsCsYq46cwgAaPC0PdarOF1KUsTgj7/16CKUN5WiHGBDBToPCvIkBjD9ZT4Kh2JO88DtX8KNre0=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 22:26:01 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a6) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 22:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 22:26:01 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 19 May 2026 17:26:00 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: drm/amdgpu: Set correct DMA mask for
 gfx12.1
Date: Tue, 19 May 2026 18:25:24 -0400
Message-ID: <20260519222524.204872-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519222524.204872-1-Harish.Kasiviswanathan@amd.com>
References: <20260519222524.204872-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: b57aecbd-95e3-4b12-e882-08deb5f59b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: M0HCAiTd2M0Ok2AxbSIsYvbQUgKNyWBIlqAgce3Ar6S9VQ4c0n4OWrCo6RklaYpOTtaE6QFKDPEtYnWuVXiZNpfZh9HGHKMpFBYt1UExRkR5svVP6z+v8SQ1lw+mSfPiK/EiyeQFpdn7nlER60ri4IzF8wxAzV31z2e43Vp3LLeTGkBz35Y1Aii3Fjo5MrxslH1UuxU596a7Fqpy02dWlxW+b69eGuPlKXrjENuX+rSJrYdXSJyQhOTBkfnwnshkXbii8ZM/oNfS4DXhHfTpZTOuRizzDsaf8pUsCYzP5uc2KT0bNzjI4T/CQnxjY/f7Nmv7eSz/fDyHTq1lB8ha8iRFSmbfHk1KE62F9KebTclDYuinpvNXH2Ge7RNX91IIBfNphw8Ohwoqtki4rmiZGCOTEhApVNxbtW4qE4J8bPav8mPnj79TXBoC0gAh9sfbQ9ld6zmdx1EWQOz0bj9k1UCwIYi3S2TtzFuQQ7i973Ur/+DIkB6kllBjwyexVxoelWtGwYnMc9B8IMS/Prvj3FzwDbqYhk9eRfhPuTkkeJc5mDVLfTWB1l/6WvJuF/urKC9s02joFPZat1zn+5AomM7bhp6LIvp+KIDZ4bppdjILYxkC+TW5/pUb5QLp6Jk130C+hxwuKzy3tSBWgTtO7kMKOlDJx2IwVoOAm0DMWJlx/kkT7qG63SKjPC4ScYrjjtsqtn9mC28FvhzOANkWXz9ipIbpUs9XPvpTAQZncR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7sVlrXfniSqKWTq7FvCKOp++kDd9jgo3rBIlsYzloccvo0HiXMCCIB8TcCMdldQyzBWQRHpl0g3ETx2/vIDVnwOU9YCJpYmHmsncP2boWWDImR5OPG07VwgJKW0kl24XU2P4U7A182huSKqKBBt8MupRVo0Q0iZ1Cl9ECUqnKunbifAgOLuXgPUsSX9aypql5J0R4W7W9VWwVTprhrTl4aMenq8ivGN7Y4wDmzcSo3QRXj6GL/TNZAzbfhKWdGY1FXhXO8KZiKrjhnFOCndSxye66SV6qj5zkEShNIyVO0W1anM+N2+esWddM9rAwFBzOQfZEdUN8PVMtMwmBkQ+aQKXB4wozLHzAfyzbpy7HcK8T1veYcEI4KI88j8BvhCF7AevjwzBbpWHGmzIY8ZEvnn3I3pcVRIYjAEwRvUMCwrdjeEdMLHZp6p/TyHRm84h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:26:01.0977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57aecbd-95e3-4b12-e882-08deb5f59b67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
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

Set correct DMA mask for gfx12.1

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 0052a40214a4..eaa1d821a9e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -811,7 +811,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 
 static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
+	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block->adev;
 	uint64_t pte_addr_mask = 0;
 	int i;
@@ -844,6 +844,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
+		dma_addr_bits = 44;
 		break;
 	case IP_VERSION(12, 1, 0):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
@@ -857,6 +858,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 */
 		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
 		pte_addr_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
+		dma_addr_bits = 52;
 		break;
 	default:
 		break;
@@ -915,13 +917,13 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
 	adev->gmc.pte_addr_mask = pte_addr_mask;
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
 	if (r) {
 		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
 		return r;
 	}
 
-	adev->need_swiotlb = drm_need_swiotlb(44);
+	adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);
 
 	r = gmc_v12_0_mc_init(adev);
 	if (r)
-- 
2.43.0

