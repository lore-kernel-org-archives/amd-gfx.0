Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90F606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5kq0WkYy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D56910FF84;
	Wed, 18 Nov 2026 19:03:19 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F0110FF84
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjzmAtyZFSQskq96/IED6+thqAvxnCkl2LZ+HmgM7RH/4WlcH9GrKIm6YWaoRIbkXKpYDatjQKQtmCv5qzQy7BWMLh+Gxxfo/LAf3Qm+isXgVgZH3jdFEZj747IKUP81M/1hXPmNMQbs17YYBtjJodRa5uTy+aAdSha55Dcrp3nPTdG3k10556K9uQHWoB7BeSuJcJidr+jV30h0kZ2s3jhbhCLirRsuclXnpxYWguhi11z9U/BKMaLK0kGiAgCEEOy5DT4dfQpEYOiuMEtVBhxiQqiHiBAq7jC9ZIigvrIAY9+4JNZvJhX2s8zen4D3PXS9DGay18+cc5zYkq66Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+ePw6gVVn5meLhvYxw3ZTxS9fcGEZVpRiVVbvs9GP0=;
 b=Cdo+kOc9NNoVd7j+esLbuP/xevbD8q85G0lR5DuYo9yXjC0mBc00WyS6MytnUTv345Ifiz2bJKO6H60lbfoChxTN6pnbxZSJKmOmZzEf2XGyWyp7/m6/akeCOIPVymfNoG9lwLzYSJ3x8n8kyUBPO2asGJass5eothn1Bmyj9kC5yptpBNIeLhGbDwIDnuRSPI+8A/AgMWnG2/H9Z1BFzklt0Q5GSMucEzoOM924KdHpkDHJCViglMYtSnBVVqZejOfgfa0L3wBJO7D02PkPVk7JDKAG6iPy5FZ/5Eg30tc/7EOYG8V3yLSQZ1OEy5xorZs9g8yT5A/GROuDip1Eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+ePw6gVVn5meLhvYxw3ZTxS9fcGEZVpRiVVbvs9GP0=;
 b=5kq0WkYyFnPE0yjxMUNonntv3gbmN9h5d0KQn/fj52C9iblunhSQbX6DOax9uJl/GVutqqjZAYpaF/J7wwoBc/M6rzWcB1EylJcIFkgl5bY0LG+ninK0zmLB6QYRsuW4kp1az08+l8tplWMLlqpZGFCYUdSBw2cV/bKN0OxDokk=
Received: from CH0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:610:e6::16)
 by DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:03:06 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::25) by CH0PR03CA0281.outlook.office365.com
 (2603:10b6:610:e6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 19:03:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:03:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:03:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 18 Nov 2026 13:02:59 -0600
Subject: [PATCH v2 1/3] drm/amdgpu: unwind TTM on amdgpu_ttm_init() failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-superm1-amdgpu-memory-leak-v2-1-38365f37bd5a@amd.com>
References: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
In-Reply-To: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|DSVPR12MB827618:EE_
X-MS-Office365-Filtering-Correlation-Id: 66284b0f-1340-40b8-9b05-08df45a6940a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|5023799004|261021123027099003|10067099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: ajMD5ggIXNS56y8h4td+7KryI/5UKr3kqbVc7pC29MSJM9HPqxlwlWpCg0x0FABlTZZk+oGZyxWwu/RTU/90wFn78oNPegNINq5wyrdaSjBMXAph9tJ+KmmfaLnb9q97uFTLGsHKujLxnzSePve1Q2YQRQLUmOVBJMiI4tPGM8+69jVLa8iQrR3Priuclt8p/cPYRexdrmSshINKiOYqC4DdW/uMgwkFubF4vUWP33PgSm72y4IhOKTUuEXyRYIKZjESMf9cPDoRAmr1fTa5WyFhfI7LM4IIo8FHEAf5F61LNm6w0IpgpNSEplerfrtgc/anRPTkPbWEIBCVTERtXj6DqJnju3VkVWjUm9135505JTIiuMT235ha9tjmpj8OIW+ayC+n41Z1wBrxzNObrpW1V+0NoyNoXsaqde3wiZJf4lCSNRCREFzWi3L4CRtlR0cDzL+wgNdUfhMza8S+f8G1B8B9s/u27viUCn7YxTFYBDlAiwPAkehhYol4Jlsbw3H45MxkvyRWeidy1z5C6uDTXKyDTxomjG2ok7CTBWQrr7zLh+k3W+q5imA9acTBkqpAowMjKP8w3BBWsJ8DtRxIRymMMDN6A7q1vT2vpzbPxu4+wI1RVxsLBp59dBIyINg8rOnXdR5+iZAhnVtUy55U7zr6kBXeV26Lqvl6VK5/2aoKHpmeoN07aiA7/0qroPnATXQHnn3EPbifeWh3mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(5023799004)(261021123027099003)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uZY/taCfw7M81/2XoWyAsSe1v2vN8faKsjFuKJ3fYVLeZ05l0dWd0n/eo2LFhZhO9tnwSoXVieC3NIpmI++6UVXrrRw5t763WUYqsGXBhMnFmQ0X3yNHc3kGjsIKWlJt2F3oFZZQty5FeY2Mpp9KLVV1naueJk/KEPKmXCFQWVj2S5A5TaMUqEdTO3FftKuPRjNiXqteAYh+5Kfqy8xp8oMQBt4KzdFnGvbskF0yDgWph0FbNCOez9JxgOHGz9QSfdjufvhWExuS95pebumbAmdKXjvNYqvmA1sxA1+9ZPAqH+PsCLv4Rqvun64ZwmQ+ZgaZLdM5G6SLKeV+ji1EXkWbDlTQzQ3IYYt+g8wOqfv3Mq8AIpfl4pf1qKPNw54swsqgxRZJccHezW6o5FetQh8BvjiegDmGDvB3zZnteDXlkYNqlTJYeuF4DhvsDA2l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:03:06.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66284b0f-1340-40b8-9b05-08df45a6940a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB827618
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

If amdgpu_ttm_init() fails after ttm_device_init() succeeded, the error
paths just return. Nothing later calls ttm_device_fini() because the GMC
IP block never reaches sw_fini, so the freed amdgpu_device stays linked
on ttm_glob.device_list. The next ttm_device_init() or
ttm_global_swapout() then walks freed memory. The MMIO_REMAP BO created
in amdgpu_ttm_init() is also leaked, which shows up as "Memory manager
not clean" on the following bind.

Route every error after ttm_device_init() through amdgpu_ttm_fini(), and
mark the manager initialized as soon as ttm_device_init() succeeds so the
unwind also covers a pool init failure. Make amdgpu_ttm_fini() skip the
VRAM, GTT and PREEMPT managers when they were never registered, as it can
now run on a partially initialized device.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 43 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8dfa92967b630..7828caf8aba0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2153,20 +2153,21 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 			"failed initializing buffer object driver(%d).\n", r);
 		return r;
 	}
+	/* from here on amdgpu_ttm_fini() is responsible for unwinding */
+	adev->mman.initialized = true;
 
 	r = amdgpu_ttm_pools_init(adev);
 	if (r) {
 		dev_err(adev->dev, "failed to init ttm pools(%d).\n", r);
-		return r;
+		goto err_fini;
 	}
-	adev->mman.initialized = true;
 
 	if (!adev->gmc.is_app_apu) {
 		/* Initialize VRAM pool with all of VRAM divided into pages */
 		r = amdgpu_vram_mgr_init(adev);
 		if (r) {
 			dev_err(adev->dev, "Failed initializing VRAM heap.\n");
-			return r;
+			goto err_fini;
 		}
 	}
 
@@ -2190,7 +2191,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 
 	r = amdgpu_ttm_alloc_vram_resv_regions(adev);
 	if (r)
-		return r;
+		goto err_fini;
 
 	/* RAS loads and reserves bad pages */
 	amdgpu_ras_mgr_early_init_service(adev);
@@ -2239,7 +2240,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
 	if (r) {
 		dev_err(adev->dev, "Failed initializing GTT heap.\n");
-		return r;
+		goto err_fini;
 	}
 	dev_info(adev->dev, " %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
@@ -2253,52 +2254,52 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
 	if (r) {
 		dev_err(adev->dev, "Failed initializing doorbell heap.\n");
-		return r;
+		goto err_fini;
 	}
 
 	/* Create a doorbell page for kernel usages */
 	r = amdgpu_doorbell_create_kernel_doorbells(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to initialize kernel doorbells.\n");
-		return r;
+		goto err_fini;
 	}
 
 	/* Initialize MMIO-remap pool (single page 4K) */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
 	if (r) {
 		dev_err(adev->dev, "Failed initializing MMIO-remap heap.\n");
-		return r;
+		goto err_fini;
 	}
 
 	/* Allocate the singleton MMIO_REMAP BO if supported */
 	r = amdgpu_ttm_alloc_mmio_remap_bo(adev);
 	if (r)
-		return r;
+		goto err_fini;
 
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed initializing PREEMPT heap.\n");
-		return r;
+		goto err_fini;
 	}
 
 	/* Initialize various on-chip memory pools */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_GDS, adev->gds.gds_size);
 	if (r) {
 		dev_err(adev->dev, "Failed initializing GDS heap.\n");
-		return r;
+		goto err_fini;
 	}
 
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_GWS, adev->gds.gws_size);
 	if (r) {
 		dev_err(adev->dev, "Failed initializing gws heap.\n");
-		return r;
+		goto err_fini;
 	}
 
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_OA, adev->gds.oa_size);
 	if (r) {
 		dev_err(adev->dev, "Failed initializing oa heap.\n");
-		return r;
+		goto err_fini;
 	}
 
 	if (adev->ualink.npa_size) {
@@ -2306,7 +2307,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 					    adev->ualink.npa_size);
 		if (r) {
 			dev_err(adev->dev, "Failed initializing NPA heap.\n");
-			return r;
+			goto err_fini;
 		}
 	}
 
@@ -2318,6 +2319,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				"Debug VRAM access will use slowpath MM access\n");
 
 	return 0;
+
+err_fini:
+	amdgpu_ttm_fini(adev);
+	return r;
 }
 
 /*
@@ -2352,10 +2357,14 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		adev->mman.aper_base_kaddr = NULL;
 	}
 
-	if (!adev->gmc.is_app_apu)
+	/* may be called on a partially initialized TTM, skip unregistered managers */
+	if (!adev->gmc.is_app_apu &&
+	    ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM))
 		amdgpu_vram_mgr_fini(adev);
-	amdgpu_gtt_mgr_fini(adev);
-	amdgpu_preempt_mgr_fini(adev);
+	if (ttm_manager_type(&adev->mman.bdev, TTM_PL_TT))
+		amdgpu_gtt_mgr_fini(adev);
+	if (ttm_manager_type(&adev->mman.bdev, AMDGPU_PL_PREEMPT))
+		amdgpu_preempt_mgr_fini(adev);
 	amdgpu_doorbell_fini(adev);
 
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);

-- 
2.43.0

