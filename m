Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D1606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z9c8HIH/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2D610E7DE;
	Fri, 13 Nov 2026 14:41:54 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC1E10E7A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFgz/v/hPzBXfciRbuGOWqEYJ6fcSwOiyfmCzSKmGz7ftig5ykiynlhd91qY55pflHNJuV/nbCuI7Wsj3eyVW5qln3qiYO8CLpL6U39lLHhUVsPM8+KjbcR7K2vGd0/+9/e+rb6KrKPdew3W7K0157ywMNYujaksbPSnQQE8JG8mdsISqHAnpY57dUzUjyIPgeFgrmxQGcqNdAXchZoBIww7K5U/D9h38xbELElOiTBXYwIMXWSlDXdLnrTECvfC46VAUJpYJ31IfCmk8I845H5XBhtM5FcrkPjpysD4PokQZKXgrgQjIIU/WifSMW88F9qopsmAE6vJn2AbaCyJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+ePw6gVVn5meLhvYxw3ZTxS9fcGEZVpRiVVbvs9GP0=;
 b=vIBObhaFzkqmkiblsmcAAPt6XQpauxijius1whkRuYw0O/5J2zX8lxBrwFYAHoNF2JbfueDveeoX8v1j2XeJYVDyqUoInwDstKDYyAci0djCgXsbdISp86OnBeTaC2RbysEmPAFGs9PsQZTHo5oDwDJqxhoRC9pttRR6Ku0oA+6sJc3ER9eirnA0atAVUTO+9bp2BZZKcI8MJp9xdxD31KAV+u+2s4YUDgRePvgYQIcFATDVSNO7jKYyjtv904PcMQc9K6JdVIdcLheK5dxlFNs0pABETKdH8+D4hNOGe8oqCejrGzxA3OX8q4REC6gYGceNuSqHCpWMR56NLuIvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+ePw6gVVn5meLhvYxw3ZTxS9fcGEZVpRiVVbvs9GP0=;
 b=Z9c8HIH/lZdGbXYwXjriLqa4hm7N2y+rOQEam6J07Ag+1GklPKvXuBj7sef6tE5DO19dd9S8/tD9W1MZye+FweeTINqy2iTEq+TXVrK+7VhfOhzJiPn72UR0m/i81rwQcouSLnNNiTPYXHlodz0l3kZy/6qXB52KM2nUS0qi9go=
Received: from BN9PR03CA0434.namprd03.prod.outlook.com (2603:10b6:408:113::19)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:41:39 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::84) by BN9PR03CA0434.outlook.office365.com
 (2603:10b6:408:113::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:41:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:41:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:41:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 13 Nov 2026 08:41:32 -0600
Subject: [PATCH 1/3] drm/amdgpu: unwind TTM on amdgpu_ttm_init() failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-superm1-amdgpu-memory-leak-v1-1-4a495cfc2c92@amd.com>
References: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
In-Reply-To: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: cd43656a-4189-4e3b-492a-08df419439fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|5023799004|11063799006|56012099006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JSYUqoi/SPisRwyKUNKsv2h9par6nLDNnQcQN82PN1hewESesHRETpNOHy1+UjGsGFy1HI92YELKYvPPCVr2+AFyRSiZ6GuST/wh9WKTQrYS1MZjUQo6B/vRBQ4lLDJZ2iGAUIVwSZAUaubFH/ZJJlMjSVyDuPdVruOV7CdEewnI42uftbZ4YIVPYV19D/jgOYdgDXUSWuxqvegfrq/UhNh93jtj19nGQhVPpCkwc0tqqfWgV0LzwJwGfCaqC+Z2ddr+CqRsbCQs2s6j5flBrfRgfQMOj8E0nsPCC8kMSgVMvJOWIsuAf4ZI/lcSh+wYhn8Zrz+1gJd1KHn9GPG6KOfiG2jvJtQmtyTojwALUJkQLZdT5x1HUf+/fNgpJ9nZv1QqUGGTi3ldNLEAwYFFN/UmFPmT7uuaOaK/dZAADWUcMUrQcNUeVQAp/7jfWdex4jbbOfJggXh+PyaqbErLS5h7R5EtSNEiPDjjgT/qi5AAR9J19szM0VvPcflVMgba1qiEnEnl9y8SE6hS9GbzJozzj6i2VmqzoTCYvBqwxWQRV1EpLa/8Qj79quOqc7xxV2EaFZRcedMEiLgrZ7fhc98DtlLP7HhKd3kvtbD5vevXbLRW5DqUmLjdM05b8k0TEcHuED9SZN1O6kflL6CPJiFo5Sok8p5AV7rzwxPwSdMjnwQ2RbfD3Z5uifriD6Gi28sVYB70v4zqieRpxsjSAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g3rQRwdLLlBUujVLxgd3uI21BMdUl8U3Q7l+ywuvtMhT6WavzKWzXDufD/3utxvRBWElWj14s+ptuziUNOvFwKW3k7ZNc8yatw6wt5WLrGd5P3zzy5OnZ980INfln4HMKTRJa1JXgB/7uZq3N89pEssrDdYNSiNLB5m3oZTMTBkQ0DwVT9z76FsgajMAOWBIsnk1QEMrDD1f/0Ga6Eg+stlXb8uL/+3l/TEMc42CmkOVH8s0y08m7fTjIz5fQhrcIGhIf7GVkavsMKY1urHBme6RE1bxqnYDi7Ty9xuuvB2hdWhFl0cZ3bRB76zkEz8+ahTWYTQ0c7q2KAlPLlekXwTIcKI7R0mvPFXwLzJiKiJ1JOORu0lISTWBBPC0f1j8/i8S74Eny/9VzYsUtXZxikEU0rMLkCVrvvbYYMqhfQumzYXtdGwLGtnd3K9J0JAj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:41:39.3190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd43656a-4189-4e3b-492a-08df419439fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

