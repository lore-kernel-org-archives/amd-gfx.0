Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034C4106F2E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BADD10E987;
	Thu, 26 Mar 2026 07:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqKky7Il";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B283F10E986
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH5VZEjmdfBjKVnole896hXgZ+OUn7BgMTkFtfm/utH16QlKXnDOOAmw6V4l+rG48+Pntprf3d4SL8pSaLUjxiFB8fWTQoJ4ojzCyL3OzmSSFjbViqpwWwk2HPurEFlQBYOIkU9zNSCXrRD/ToUUBrTt8n/d94E0iXAsJ0whcYMOo1nDnFr3Nk63Gxs/UQHUgsnX7BUvLbxn0EthhCOj0DFF5BF39TkDkuXURDj0wih/HgEkLUg3/HIxYBQ959dJEcOsahU5eZ7ckrNyWzNSWmXKgDAfVtAMNQXBm+nVafliO+KO9MksJj6bQy/zGSOQh19iG5XgvPW7KAB+mo4JMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSeuGpBYlwlM5mGnPyt1vSeaVZ4druInJsl+vPBHHgY=;
 b=IAP4m/Ml/RwiVrmVIYLNMimZlXOwFUCgAvXamLK08gLPgwZj7YefFxJWdvUndcND0r7Kw3P/xzqPp5xoeo4BTMJumm3wQe5I10iO5y2Invc4H/cuRm33nTDedwLuRfHnXujcoy/THr2iUAmIbusajQD6jK8AHlqc4b9YeFnTxSUJ9qyUCncnX23MTxXgmiqP8nlAoJvQXMaCNKoIcU8pYddQbOkVpjgU/hXpAKTYSAfpTNMwvgJYIY19snXwcVrPTaBUohydI0wEBrC16lFM+Nr7u62lrAuBuMILZTpZuOMgt59APFyMdP/eCu70/aWkf8K0uwwXL0ZR4bwRn9RqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSeuGpBYlwlM5mGnPyt1vSeaVZ4druInJsl+vPBHHgY=;
 b=iqKky7IlsDBRzXdW1/p/pi2l1NbtBsuQA7HW3579y5e5ALU4vmON+meLiNg8lJEsL1brK3gd6B/ApMZOom9D+O4X9buPMg4QPE4QZWE/XflSdzszdtVk4iirbUt1w41T85y8y/bcpLCkc2dzPsurMW/W3C2KoZGc7sCoCRnJg3o=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:55:07 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::84) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 07:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:55:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:55:05 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 11/14] drm/amdgpu: Add function to fill fw reserve region
Date: Thu, 26 Mar 2026 13:15:32 +0530
Message-ID: <20260326075412.1378411-12-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 57015695-28f8-4ec1-2655-08de8b0cff6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RbCC0wEXNfqdcXxRkcMOzCwTFwyqY1xjMgcj527C3O01lb6g5ZXWHKBoPbgom0+FVecf/Sn38deK3ZHiqOhQXi/ZYe8odu1SSt9tOQ06e0OYxcjf/zNoqZ3obV0NaFWUFIp3SeEXEtaO2rGXHms0e1ibfqV4WA3mnt2OW2l191oubWz9AEzuzYwZjF2uP7s1RkceyGRa1E7XEMyI54ZfQwRPCRCj1Bx+JRk2qsSkZ+kwgwRWXOHhBBNKhU4V7aJyOWVaIkMGyS8uo//we6LgdMVZ/7zQPxUgUOtBPh8VxGqmTzcOmRLbu4uXODYiptVUsJ4wf6Pu9Fk5OlW7pz8cxq3LU5cNUBSr2FjtJnmDuevuy6+T5MhWLmK8BgfvixVLBb9CXda9wk5LMH16Le0/9ip8+X9/T7vS/gLviar0MGvYOq9c367zVjHCFgif3fhlysjKZjFug2pG2mAbQXD5+VXiLdvtJJgrtFVLLPccZlnEu4ZwhwrOZC+53b6JkAvtNxA9aVVRMtqvs/8/u2+e/+0VU8ZpOnzWCb2LVgpmQ8p+twmbk46f9zU70oI5i74HMq1dH7IZhtfhVqN7wijAtq4pXFbI9USkUKOIn3Xs5S6vc4VxwVuB6ir5bNyNBky9g8Rq2tA4MJJrgNQMs0YpZa7SHcwzUf7lyGC+0jCtVYSn9EZpwbGRJr4M6NqZOrEXWuL0qQG46JLfVhoED2DM8ooB+zSYsUMfb3WtgM771YII1dOfmih9cpKXlhLKNFfRoR36AkkF6q9B77k33SyuIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E8x1zhbVJdBHVRgtPxruIKrPpRqF3qMBc1d2qlMC08t/zxIt0/IH80CMnNkP1t/J9y5NAqyN3xtIpSEjMY8szKqyDp8ZokIun4zK8JhCmrId+xnQZrfLsYFMy+Vh9BIdydlVlhr92V7IUN4cji1lgZ+SdRa/I22CGDCxZU+dnjv/dYI0fJ8kkN0HDT9IQ+PoY1QbMn6MtnjUvAtVhyEtb1H5oRXACyDV2PXmyIMH4TwEijCEPGiq0HDQVu9NGiDcQFrReJWSSYT1pTcyn3uWYIHOsdsWD8D6/VRTMigItk5OCpdm+dSkRcYPpeZEF5Ytw6rabjo5Y0teQa7KDp7lHEbfnK5tRqZFCOty6jI7mCxYRJyh2LDaZA5bgz/PT1KrjEqJa8fHA4VMs+BtLPCaQWkFYogrhzzu7oCB6BB2ovpmmWudhrQadvDyGd6xHDC7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:07.3995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57015695-28f8-4ec1-2655-08de8b0cff6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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

Add a function to fill in details for firmware reserve region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 70 +++++++++++++++----------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d5bd6f1a307f..f5aa4fecb1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1693,6 +1693,43 @@ void amdgpu_ttm_init_vram_resv(struct amdgpu_device *adev,
 	resv->needs_cpu_map = needs_cpu_map;
 }
 
+static void amdgpu_ttm_init_fw_resv_region(struct amdgpu_device *adev)
+{
+	uint32_t reserve_size = 0;
+
+	if (!adev->discovery.reserve_tmr)
+		return;
+
+	/*
+	 * Query reserved tmr size through atom firmwareinfo for Sienna_Cichlid and onwards for all
+	 * the use cases (IP discovery/G6 memory training/profiling/diagnostic data.etc)
+	 *
+	 * Otherwise, fallback to legacy approach to check and reserve tmr block for ip
+	 * discovery data and G6 memory training data respectively
+	 */
+	if (adev->bios)
+		reserve_size =
+			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
+
+	if (!adev->bios &&
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)))
+		reserve_size = max(reserve_size, (uint32_t)280 << 20);
+	else if (!adev->bios &&
+		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
+		if (hweight32(adev->aid_mask) == 1)
+			reserve_size = max(reserve_size, (uint32_t)128 << 20);
+		else
+			reserve_size = max(reserve_size, (uint32_t)144 << 20);
+	} else if (!reserve_size)
+		reserve_size = DISCOVERY_TMR_OFFSET;
+
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW,
+				  adev->gmc.real_vram_size - reserve_size,
+				  reserve_size, false);
+}
+
 static void amdgpu_ttm_init_vram_resv_regions(struct amdgpu_device *adev)
 {
 	/* Initialize memory reservations as required for VGA.
@@ -1701,6 +1738,7 @@ static void amdgpu_ttm_init_vram_resv_regions(struct amdgpu_device *adev)
 	 * and driver.
 	 */
 	amdgpu_gmc_init_vga_resv_regions(adev);
+	amdgpu_ttm_init_fw_resv_region(adev);
 }
 
 int amdgpu_ttm_mark_vram_reserved(struct amdgpu_device *adev,
@@ -1794,9 +1832,11 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 {
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
 	bool mem_train_support = false;
-	uint32_t reserve_size = 0;
+	uint32_t reserve_size;
 	int ret;
 
+	reserve_size = adev->mman.resv_region[AMDGPU_RESV_FW].size;
+
 	if (adev->bios && !amdgpu_sriov_vf(adev)) {
 		if (amdgpu_atomfirmware_mem_training_supported(adev))
 			mem_train_support = true;
@@ -1804,31 +1844,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 			DRM_DEBUG("memory training does not support!\n");
 	}
 
-	/*
-	 * Query reserved tmr size through atom firmwareinfo for Sienna_Cichlid and onwards for all
-	 * the use cases (IP discovery/G6 memory training/profiling/diagnostic data.etc)
-	 *
-	 * Otherwise, fallback to legacy approach to check and reserve tmr block for ip
-	 * discovery data and G6 memory training data respectively
-	 */
-	if (adev->bios)
-		reserve_size =
-			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
-
-	if (!adev->bios &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)))
-		reserve_size = max(reserve_size, (uint32_t)280 << 20);
-	else if (!adev->bios && 
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		if (hweight32(adev->aid_mask) == 1)
-			reserve_size = max(reserve_size, (uint32_t)128 << 20);
-		else
-			reserve_size = max(reserve_size, (uint32_t)144 << 20);
-	} else if (!reserve_size)
-		reserve_size = DISCOVERY_TMR_OFFSET;
-
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
 		amdgpu_ttm_training_data_block_init(adev, reserve_size);
@@ -1843,9 +1858,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW,
-				  adev->gmc.real_vram_size - reserve_size,
-				  reserve_size, false);
 	ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW);
 	if (ret) {
 		dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
-- 
2.49.0

