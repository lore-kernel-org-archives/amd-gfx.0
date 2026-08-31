Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F144AC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5602610EAA8;
	Mon, 31 Aug 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuHiO4pJ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C96510EA92
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+wUG31S5VvsYEHrkY4B2JoCuocv4c8c6vidPXdmqs2hs4jJ0+IB7P5tA1KGzbYzecMQ2Ajed6YJ56cbMk3rioEuP+yw9LsrFZsS/S+ItJL0SKDL0xbKrenQN6I6/t4IcTHUsj0LotE4KX+/sAr/E7/9b7EWgPB70Php7TITfjsFUqN/reZIoZm6ZR+/9NL9hueh0g64X0ECWqFNyrJdpq8pYrwrWQcuNiSYd3Mk9X2iaXjCV9d9NiovRmrEFCDMm+cGHxKHLZZUbXlg1iHpNWDAb+o5X19nVLZ3K5/2pom0jzfNM+qEVyGaiB2T45IofOHkPG7Oloy50nWsvY85Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBZNNXHEr0VmrhCplEuzWUNu1hjdEc1w/JYbDxdBqCs=;
 b=f1FrP7E6cySlUDUY3RNSjfCyBkihEabxgr4+27QMFNwtH76BHk/A/mgTBmu8Nz06/623BISnvQoz9C80m7+RZWndIDJyDQY+YXdhnF8O8T5i6rdJP2YqIq61B3xHViII9FFs39sH9oMdZmI57eiALFbLswJp7j9GmxspK4bdUdZXJOaB5yJiU1QWfBxZQeFB08TeUWK9hIHcQ2LJDKihEbZ3O5egOyY/9sw5ygg+stJgvkIsvGZSBBK0qCWNKJ93Yyya8wayZUQ3oLB8iyyTOkDHkLHIfPWRHbmDtP7K6VFiXsUxCfRiqD01EvWaA4flo7msfMgkxqnAwtqWNY70Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBZNNXHEr0VmrhCplEuzWUNu1hjdEc1w/JYbDxdBqCs=;
 b=tuHiO4pJXeyusXmKEha+GN5t49s5SX1/pR35pNNSlgkOeBANONUlynUHXkF5MuVswTVXi77scw5M/o6JiHx6AR7XVry+IdvIn53MXOFeMF7kPVske6huTSaRaz5kn/RnKgBjQ/piY6yg3V/QcSe3U/Ndf/zBDeQ+E0bxa0SOp2s=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:18 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::18) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 93/95] drm/amdgpu: create UALink NPA import BO directly in the
 NPA domain
Date: Mon, 31 Aug 2026 14:27:52 -0400
Message-ID: <20260831182754.1089811-94-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: a650db8e-a5c3-4bf6-40e8-08df078dc4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XKm7Gios3v2wM6QtVOVzq4RqVo0oV3GDGXqVMvLDzHfX6Miw1bH029Zu4rPH33EeHd0WWOLw8W4sa/9yBR2o+WORJ/C2fEnId6qSE/tnotrniqUDheEoENcyzlfcBAbaRv8/1lthdPHEyfHE3cENksb7vgECDI2AZdxal88Y/ZGdyCrj7WCkPxhfJBmWuQbhmlWtOYFzGYhljwK8dbKlC8foqYSZIhDHYEZieEF26gYEOZEEm12/7x5a6yVzlb/MDy7MtC8sRuNrstcYTiOMkJli0+lsYhB75MKX9K9JffL9cLI6dWsL07wniFgWW7AfqqBf9EkUYuPYjkIX+ZRZGFxQNG3vJw1PuCJnhvL7i5QV3lge6/vzJdTG2yNLRd6CBBVmyjyNfhxCUF5JBvVLnGFQwA0fLz54qsVhstjfY00ifegc+szJ38qbKfzxjpiH2irn2zKtlXEoJAwRZoZPV/PV/zWwiDsEBaWEvRhO8y3p62wy8BIbW6NONnTfBs43lwH5quqQNMyfubLFYfgAvRqBuKSRDuH+ogcdaSKYUNLBurnZxX+OSCd/3SJNXVm081DKIUo/t+0kL8Q9DWQOJK0oCV3qvAzHBQpjWmEQ0QjlMzYeZebmtmOJjddBwwdEUMv4gcW09UcqAzpYxuzbh/lkSO2aDfKFCeXcO7bP00CiTh6AvZqgEPShb7Fue1RIFJLHH+P/QzScdKgcDeja3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ngE0JUQrHaSxmpmbv5hc52TublHQiI61xWgvWqMQf83+HrxWT+5f1To2pNz/pVLuQZARoLooHk465Rit7Bff6zoh6C+EuSe8FYXkAJlXt4f4cBdSNh8l2t/nk9YEgF3QXrXMv940ZMQjl3nshoBXZlCueTmq9Qav3Y29uot7QifYTHclziYAAZrkvDXXRbd+cfb78Ic+Ss2lVD8WyBaxWowuyrNNCPHUMAlqrz8YDMneh8w3IxAKnqozRIBBzOcSjHWsOVpa3dahZJqtMvyWLtYIZXEnjeCYoWL48iq0y0PS+q7DQHE8N1G/4wBtndUOy8zxhFmVHiODC3Th+/jszxPi7YJ/ByANlszafvhGb7UqZHnGafIRxtDqngpvLSjJvdDlhx/rM7eeLpjgoPJdnuo+fliR83MWFHiOpZT4y+VhigO+1w6q1qBOieWFD1ov
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:18.2130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a650db8e-a5c3-4bf6-40e8-08df078dc4bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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

amdgpu_ualink_map_npa_to_dmabuf() created the NPA import BO in the
CPU/SYSTEM domain and then moved it to NPA. SYSTEM is use_tt=true, so TTM
attaches a host-page ttm_tt that the null move to NPA leaves behind. On
dma-buf export, ttm_bo_populate() then fills that ttm_tt with system
pages, spiking host RAM by the entire NPA window size.

Create the BO directly in the NPA domain (use_tt=false) so no ttm_tt is
ever attached, and relocate it to the exact remote window.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 29 ++++++++++++++--------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 68c156c1d281b..3f96044a3d54f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3032,10 +3032,10 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
 static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 				struct amdgpu_ualink_imp_xa_node *imp_xa_node)
 {
-	u64 alloc_flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS, npa_addr, size;
 	struct ttm_operation_ctx ctx = { false, false };
-	u32 initial_domain = AMDGPU_GEM_DOMAIN_CPU;
+	u32 initial_domain = AMDGPU_GEM_DOMAIN_NPA;
 	struct drm_gem_object *gobj = NULL;
+	u64 alloc_flags, npa_addr, size;
 	struct dma_buf *dmabuf;
 	struct amdgpu_bo *bo;
 	u32 handle;
@@ -3047,21 +3047,19 @@ static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 	dev_dbg(adev->dev, "Create NPA BO addr 0x%llx size in pages 0x%llx\n",
 		npa_addr, size);
 
-	/* TODO: Check if this needs to be on a xcp_id basis */
+	/*
+	 * Create the BO directly in the NPA domain.
+	 */
+	alloc_flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	r = amdgpu_gem_object_create(adev, size * AMDGPU_GPU_PAGE_SIZE, 1,
 				     initial_domain, alloc_flags,
 				     ttm_bo_type_device, NULL, &gobj, 0);
 	if (r) {
-		dev_err(adev->dev,
-			"Failed to create NPA BO in CPU domain. ret %d\n", r);
+		dev_err(adev->dev, "Failed to create NPA BO. ret %d\n", r);
 		return r;
 	}
 
 	bo = gem_to_amdgpu_bo(gobj);
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_NPA);
-
-	bo->placements[0].fpfn = npa_addr;
-	bo->placements[0].lpfn = npa_addr + size;
 
 	r = amdgpu_bo_reserve(bo, false);
 	if (unlikely(r != 0)) {
@@ -3069,11 +3067,20 @@ static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 		goto err_reserve_failed;
 	}
 
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	/*
+	 * Drop the arbitrarily-placed NPA node and re-create it at the exact
+	 * remote window, mirroring amdgpu_bo_create_kernel_at().
+	 */
+	ttm_resource_free(&bo->tbo, &bo->tbo.resource);
+
+	bo->placements[0].fpfn = npa_addr;
+	bo->placements[0].lpfn = npa_addr + size;
+
+	r = ttm_bo_mem_space(&bo->tbo, &bo->placement, &bo->tbo.resource, &ctx);
 	amdgpu_bo_unreserve(bo);
 	if (r) {
 		dev_err(adev->dev,
-			"Failed to validate BO in NPA domain, r: %d\n", r);
+			"Failed to place NPA BO at 0x%llx, r: %d\n", npa_addr, r);
 		goto err_validate_failed;
 	}
 
-- 
2.55.0

