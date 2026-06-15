Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37422CD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BED10E776;
	Mon, 15 Jun 2026 23:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eW0pHHV5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF7D10E784
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6KB/PsAbB+rB7tQfJmU6e6GugyOFj1AhG+SFCP9qKNsLsSaPBDobXGCVafPCBZiggNcuW6xR+ikQmzULmQJnicuEjk5hPCm+l9Qxn3s17Rq69+uxDfEg+jk92aObu+YU9KebtcEsr3zqoMm+mWdNrva9V9BbwfRVK2o/M9qRth3NiVWQdsnZ21XYSmioOZ2pUTWPE6U5829taCLx/jYR5vBbddXtv0vztLVuO5aIRGCyfdqBLO/mLxh6afT+9tLwqsmnexkbX52lcbFZ25myY5yZujPD+PMYq3iV++jfij4HTPlXdToCDZD3DtGEFKFCQblbA48nprqbP58PL31KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alCcRbdqBUW88L85mrDmHxtwOe9EV7fuubGdj1xlaeE=;
 b=dyi0+9E/3v0JscW8mS7i3TWBLS4Q8QbCI7pARg3VaYlkr5dw/4xoX0l/W5MwRb/4cL57rJWoQrFzLjmJFlI/nsoRbuLkgP6kZ8PISBJdQJRdEWXvuMdxFN1zEbx15+2nA2u5Y4kgmYUF2BFEkTYEj1BS00fz2pLiXrMfWTWkUte5P516RLnPxuaqwZDZXAJZ3ODpYOEKZzUqLDxm6/NTzx5W2NOwvMHtPbz32V+j5Bvg5Yjhw+DcmbsX2CAQe2znM6Hz0ENPE799uBzqYhxkhKvseIJexqAVSnlUvhMioogmmCK7Jhf3LkPaSxj2FwPiDEX8W51Iu1hTLlKcbHweJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alCcRbdqBUW88L85mrDmHxtwOe9EV7fuubGdj1xlaeE=;
 b=eW0pHHV5g86d/xyTCsjmxP7wBukdrYrwy0TDSRw1fm2CsKTP+ZqD0VdK5rIJrWbE1YDx1KlBvOMVIaoa+NhdHIXJEjDFxO3WpW7KG2pYSuAumx4dEbDlgaDDFpMZaMBTlRD12kt6n5Q8xsOdCXjYo4a15wUcRFdwv23bSJ37kcA=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Mon, 15 Jun
 2026 23:57:18 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::20) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/43] drm/amdgpu/gfx10: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:42 -0400
Message-ID: <20260615235645.737189-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b05021a-d635-4e9f-206e-08decb39d564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: KYB73GBy9xDdL4sPrW3z1YrT1UHU73cXJat8xoKk4hI5ZzfY5GmpaqqXP9zkX3/5M5Dizn6o5GtVoy8QVKr2Yz7WFVOCW7elrIWKNwSZwraoIqz593c3A0B7N6dPeiv7Er3LEo7S43FW8xtpjlJo7nkXG3VVqunXtU9dnAo3iT1hSmIfb0BtmyRgT2rTf6wXcd13LpSxtFyMPgL6nmQJkquSIBJ+Pn7doA2yWargmaR6R2vjEnn+KiIiU/Hs/a5DgTMovptpJsRzXOyGPgifW3Cni+yZD/uXDD9tZS1NSCcF5bdMJi3lwcN6BgqvMFgYfhjar7GCJ2AbdAtVP+3rwg+XTb8QPLF+7vB01FAPzTtJ5BuPY8pKbnPwPPnCdIBHUtMS+6atTwu90GOhU/Hj3fHWoT1MV4YXdkecirjGtCPV751jZhuiuxbiCsC/A571aab8nOThFZOqR8+OOFoirQdC7Bl8CDt9nYFm6RPKpUio+brjWE3TdEo8fEovPR68tM/AHdOheifQ2ds0NUMZ0qNxyYwV4yzw4MjWsSEolYdDA8eBgiHcvTpBzcvxGWcke5PU5XY+JBJkLu5zICirydn//Hy6bw0AFltua5Urq8lhMIcPmcECDX27BfRBE8hkYNF3EhCWoZlMGz7ybqO7eLkLsjZOhEuhqUeo96oHeFzOP5+i56c9YgMfGVVTUf+rnC9b24YQZIsltqY5Pl96w2HUccCNaZUuSNT6M7WP+Io=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ogAO6nd4usm9ZizoAsjKHSFsPRLLjwTuiqB1jB9Kz6IrL3tDxG2y/k/J7uKA2LfqYB4Wj8lsbYbMZvYpqELdU+C77CZI1HCoWG/9Mqb9HcZNtqFgReTVNzzgSLp0C3jTrVbjyMpCdd1Min/HvcCleZnGlgs76o6bIEVHGBLIq27suZpi/69DvB45IpJU5WiVuQWItRBObZkzkqO2s14xQelB5PrXmiAvhTy8U5HF0fxWNGLh2BQs9HGQj5kqKd4BFTl/hbXMioo34x/BBCLMtKpohy/xquMMJWl35zdusva46tWL06X2nXwxfReIua+N6gbhgX0rc3xWACotOwtLSsLlhM7BURQcwSrUmcB/tcjtKttGzqdssATkOZK5qK4mcTkHZQRYbthZVr7mwLdGdyssp/hkpvMyPNQ8/H4REP/TQezAqXfopLPHFigPIi/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:18.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b05021a-d635-4e9f-206e-08decb39d564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 544d6aafb11a5..fc27d099bafc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4580,7 +4580,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 
 static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 {
-	u32 gb_addr_config;
+	u32 gb_addr_config = 0;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 1, 10):
@@ -4620,7 +4620,6 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config = CYAN_SKILLFISH_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	default:
-		BUG();
 		break;
 	}
 
@@ -8594,13 +8593,16 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v10_0_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -8613,7 +8615,7 @@ static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx10 now */
+		dev_warn(adev->dev, "gfx_v10_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
@@ -9371,7 +9373,7 @@ static void gfx_v10_0_handle_priv_fault(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		BUG();
+		break;
 	}
 }
 
@@ -9441,7 +9443,7 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		BUG(); /* kiq only support GENERIC2_INT now */
+		/* kiq only support GENERIC2_INT now */
 		break;
 	}
 	return 0;
-- 
2.54.0

