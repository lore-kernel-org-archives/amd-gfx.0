Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069B8CD98E7
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BC610E777;
	Mon, 15 Jun 2026 23:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CVStQeR5";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4049810E76F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEz1aTxup7bNKu3HhrCwhxbH+XZQkvkSXYbkmP/qnbCqdUx0lwCe8FzLaf2tdMGL3u+2PbEiX33F2hybCykSTBYl0zq+zCG8DDv03V7MJ+oc8oMvI4q1nsrJv1irPEB34aC7UmYcY+OFEpvwvzYsBuvUHYXflInBJJq4/l54xHD0gm6gMf3FXm3DwfEEg+Lka6kTBs2uJXxQTKrqcDSXU7n8OoUwFHPyZR+5qUMMLP21nRmF1iZO6jiHyg9uNkK26KWOsTdrC4xZhVxANtHmzxhEIEnEFGZKzW+knxcXbxCQzRpB4qvee1V/rA8caRxtgdrj0VWBGlfXdFMJwmM8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nspf7nrf5GBnUg+q9LYr7ZehlwByL+dTtgyRbs3KFyk=;
 b=Eupx06Hq2SC5UDKa/EMtayzv3izwPZLaYK8thVycoesoFuRF8VePPjdun8kLwnMtuCN3w+u7/uhNcWKnLAkkErCP0OxgOiTrHSY0yUvQXq/v88rIdT8dA4aLdfqLCyMlnJ2J3PCySFO5OsAHSKIHrTuDk1mNPD23m+KOJ0Pd7yphOQ97KhH2/IH2h4vDajULE/yb2xdTpoNTrv+qdYLeIkU0WlYS9sQu4mCg1mYRRYYmxMz4ZlTsq2XnE63PhGlNbHbsM7OJBAmhZKkXNfeAAQQPOjvn3W2yWRkXSZwVsL2aPp1+NfdzfmfFWV7XJuW0BkVj2AmGXdz0WzFcaKbVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nspf7nrf5GBnUg+q9LYr7ZehlwByL+dTtgyRbs3KFyk=;
 b=CVStQeR59X2NS5/esuCoBHcVIDM+DpMfoNxY6hWWrltabr1TTl1FT3K8T7RRFpcu+sA9A+mVsP8CqBVd9P8hx+zDYKpWUAWAxWFlZn7aNK/0pHIwpWR8BT2C2YvMiXdxBngUwOLgy/fyzsNUZMJXG0zXAlx2NvKBZ2x+2CuddS4=
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by PH0PR12MB999114.namprd12.prod.outlook.com (2603:10b6:510:390::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 23:57:13 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::4f) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Mon, 15
 Jun 2026 23:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/43] drm/amdgpu/mes12: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:31 -0400
Message-ID: <20260615235645.737189-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH0PR12MB999114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1f5b47-10b5-40f8-10d6-08decb39d20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yjiAoC4SC2IUAA3dNGT3hFuOWg+XJFZbEJ2pxxAEJlNkRcHcatYFpeq4BfzmCdOiaraguU4vN14RkqOu4w/RE0OpK2IPSWyQOAZzB9t0woU1Kv8ck+9fbIJhsb+HrHABRHjPAkkY96q5TaZtX559K1MYXm9qrw0s60n89DhVZfYoXsOvgYMphXVv4rndzC6gU1jZuju4bS42ovjUAeysxij2wyDQsg7WklsbZ0s4SXj9vNx6yrgT5l72rOdL5fW76wMC0b7z0xmnCDjgJuClMj1w4kxAOcMxPknIijdmvfzl8bPZm1DYlFoXw7c/kTu/MtMUiYTk7kS6aqLrNosA2YAuebIgOCgwiDXWAYgDnVS93giV7KuJPn9NF/RdiFPrWNInxzv2XHfvLaLfmcH9vGWrAwGVBPtc1+iAd/mSoSdGG9coU9NNZSfhFOu0lmT7qCf9HSPkhAZVSxfUzLHBX1KQoXFSnCWFdvh9EqFVRW7Y2C+CxqJnLmZO7i24tU3tYUTmfude82QhksWqvys02DGKW7zujinCTJn/Y9fPoO2zPUW/tBLQhAgoJXVAAeMYxx8/F2k/IMaIbnwHOEVOBCcosng7LTWlYS5VjeVUUAXff8FU3rxTplw1Vq7qeVoPbxXoEPHEH83DXx7E97UUSnliTBBcPgw9xCX+VtTSTXq1Dtn0eZ+suELxSVclPzZm/YJ7NvCOBsjLEez60KwxMgW22W1vCp+8BGye50QFcBI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GlHGx+UDx0zgsXSw5zhuTZc59P0L6KTcfiIRr6obuHZptBW2D4YrDcfXc3NLo2NZB1ICc9O5QRb+uYKs/HMD03NUBsdrzHMJT/ORwf3mddtaUuHMAewW7qHlXQkhN/a0Pt9F8pSr9aRv87Zafy7QdYWhsLCXtQaeuooX/XIkQU4TG85J/WsI3qyw6Tf764GcU1yJUcM5OiS8bvV4khO6CTxQM4lyyH4G+jHYDv1mzOxC9nZocd/VUw+uLN9n0S7jzgnU+EftFoMW0zkTKL7MjgG9GHt7p2MXxQsXCFN6+0Gxt/zP3xAb+UmkGHSvVYOJ5pzTEQpCieoECiLkQzBd3diJ3/yXD3ZT01H57wNoXLKjPPOPnWvd/2YB+2urYrY8UEIRxJU0xVcGgVaeCoNsd/d9Z22/wfGjMM+Rtg5TNOzg6YCx1IaabnihLX3OHRnd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:13.0327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1f5b47-10b5-40f8-10d6-08decb39d20f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999114
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
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index d80a983b1b6c3..eaeeaacdf3e02 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -59,7 +59,7 @@ static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG();
+		dev_warn(adev->dev, "mes_v12_0_ring_set_wptr() requires doorbell!\n");
 	}
 }
 
@@ -70,12 +70,15 @@ static u64 mes_v12_0_ring_get_rptr(struct amdgpu_ring *ring)
 
 static u64 mes_v12_0_ring_get_wptr(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "mes_v12_0_ring_get_wptr() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -279,7 +282,7 @@ static int convert_to_mes_queue_type(int queue_type)
 	else if (queue_type == AMDGPU_RING_TYPE_MES)
 		return MES_QUEUE_TYPE_SCHQ;
 	else
-		BUG();
+		WARN(1, "Invalid queue type %d\n", queue_type);
 	return -1;
 }
 
-- 
2.54.0

