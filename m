Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5494CCD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60F010E78E;
	Mon, 15 Jun 2026 23:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/OVZ9ME";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1ED10E77F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY5d6KuHrjM7cK812RdSS4TvyddhQ3jgRbDWf4fI6RM+m/kcXYr1DLtLSIO9OsCuhJSwgShOoarozrQ4u2HZvprvNCxy9ydjUwuc/8KWgWzBI9yktXC2a492m+y/ZJX5QCaPs2Wx/SVHIM1TVAMCB4EdmRAGmVAnekDaQS735Bl1f8toKswjUvwijcUCpFjRsHG+/WInKxRGpSvUOV8xpl3hlB3qRXpgPbstb2GIgdiOtMIyHQwonNtsShPyDFMlFZe91xQWwiAzIOQga2Yfoxz5vFDEEiPXxVt3yJYtxgMjwMDGoVjFiTPRCXyk6Q8poly/Yg4pa7vcg5ty+fG9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC+eFxgw7AhN1sDPoN2F8k/0x62Fc/KJenffJZHNybg=;
 b=JtTcMDQi6o8BNjT8vNpzqt6on4r7ltrCPWYRV8sAesP17+dfAsgzGAXsI4Pbf3Q//WZnveOs8gZ9h6QKVZwIrSagKu2qhYHkKgH81qPkaLIjIECh17TJQXMXRDDUGxTdg5bpOJZT9APZZlNN+bgQvwWeBzdgufEJx0ae2EkmwchSEd7YEY1wmVq8PR1CuNDNekrWy0HfWkccCqtB59nvhX3vOi8RrJvK+XAQD9SKmm2jQvhXDeRguwrDOh4EtBOGWbnlNs1EcyIROU0byvnyZ1ZkDSV/LK2POX4xsU4Yfrmi1Lrw5Jm0KnDJi5iEhtKVrdP5p95OBvq77383DsWPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC+eFxgw7AhN1sDPoN2F8k/0x62Fc/KJenffJZHNybg=;
 b=2/OVZ9MEkImbbZIwCatEiHZ4w0R4uhhxGct06touQFrrKKl/RG1pqheSEbQI6pfsLMURgJ+NeUqGvXKzNGElRTnyOeMmbygSZfPbd7ZpOB9+OiCWOxlQM7TGDX7yRZKwj1+hPURMHPcEy9wVB2aW9sTjTfwUd+qmR0Yu6OJLIvs=
Received: from SN7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::11)
 by IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:16 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::4a) by SN7P220CA0006.outlook.office365.com
 (2603:10b6:806:123::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/43] drm/amdgpu/gfx9: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:40 -0400
Message-ID: <20260615235645.737189-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa25a76-6670-4556-6ba5-08decb39d3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: unA4QY4dJVqAk/eMs8+WuL1oaiVISTpp4Zn4iDRa6D5G0Ff2WoBRyejo5Jifuz5LIMn/bqwwkD3Q4o02QuLBSxa0/A88Bfhy1BA7xt012in6YpY1CLm1S+ufRxNxXdXS+AKdnHVxETN0elaV6rsSiXo3VzUWuXZGDbGHJh43KesFY96QoPygQRHJh21fqedGlU+xuSvwrJxYO5nbjuD6BMcjUYc0eVm7I5CX5ZtM7vONGZI5zrmV2ydTvbP7hY1fzfhtY8xSKoAFnI9EcA6g3nqGFbI1+fue5/ApZe+FYpXSKzHFH5RRzNMysdEN3uucdd3KV53AuoH/i5J1e1sfj9XdmlEm0BG4AlmMtcRqFlP7hoNujm3zS0hCU25kHmMyq2OU4gz4FfHKoFIBVV/ZdHZut6k6Fxk0UAENSgXQGurE/lCR6fKbKBxrqu26D+kR0PGRz54HQoEoUjK33r45GnSkBMghKGeJIki3AeU2IU7eEKNBXSga3U7Z0hFmJ6Up+Gbg9rYAvqhvtgO1fuVKzH/ebDWxyFklEa6uxJwksUmJxyalhWshX+vIMCgO+83rHyxfjiVdxeooUTrLuaeQ149kpVwTm4I9aIDy3g/U4/sPX0XB86v1c3/AbTUnpQvv9kK6J1hzRRln4ay58aBORAykHI0AuJepub3dwE7xM6GYKpwEWD8o6jZ97Mzoa04gGQiL6XHDgrwEzhEgKHtJVwf9fLnscU2HVC3vIwIJxDE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PlcbEjH8YMFdxYCvPUaeW4brAo4dEISgPSpxP15+/1KYT9ANMmPn1WTOMQdHW5wFAx5M3u/TKf34x+FafqhSxDD+InmtJu7nyP6jeV7iVpNr4LBrBy7mFP8tsHHfuiiYboEA6BDQ5nbh+aq7REx9gm+1Tjyio2Ga7PM2MUi/NVSa+OUsVkVEb6QRW1B4KYHefsJbRTG+I5Tda2rvJ7GT4BBQLo2YpYNvYKr+BJY9VRrgxCX+iLk176w6JYObFVhS8OzviiGotmg4J8YjmfWHeZRVvpHqnKvarBqazYCUEqpDwKpC5+F1ELxWahvfiDkn1upzfVikASkxU7DPwpm7vKeum6xj3uPTaw2ZC0ue0QA5Xv/76wg2HRApKgPfetx8makul/UZu5qhyO0XGv8KKzD2h9zW3+b7gqKMd9+Ws3LE0jK5ov/FpZL/Vxf7bGIo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:16.0475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa25a76-6670-4556-6ba5-08decb39d3db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 570dc90c187ec..3e00983e30937 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2107,8 +2107,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			return err;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
@@ -5640,13 +5639,16 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
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
+		dev_warn(adev->dev, "gfx_v9_0_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -5658,8 +5660,8 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else{
-		BUG(); /* only DOORBELL method supported on gfx9 now */
+	} else {
+		dev_warn(adev->dev, "gfx_v9_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
-- 
2.54.0

