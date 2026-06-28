Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B340EC43458
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2026 06:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF0C10E580;
	Sun, 28 Jun 2026 06:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fzQGm3cV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5632010E580
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jun 2026 06:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypH49QS7nz0DTr6pjhWfHyLKyMeaBkzgc9C52Y7TEZrKZdfeJFtpiYJWNCGHsL1HLrxmRIFHQYE6JKtfpbSyiyQzIh10pgZsbABNYnLaKK6zCPs+gMbJHGtc/YUJYXjAAsWeSTjp/YYMOsedN+Z5OTG1pCHhsSgvNEsIdP58cYZ6O1YuvtobTPDkfIzxNHJFa8g7LTvoi3U3rF6ZuPozOGAAjnrM4yKm9a9opJJdwEJ9wFBfqLG0bHxr1WXXoS/9yAjv4T03J9Xr92RFZJ9LIj/ynaC0tK4DxguTDhN6qQZxY74b9/Lnce1bDu3hsW1dLt4dQh86rDd0ECjTRXrr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3gxVcbTnuNp5UDolhn76c0ipFYCaxDIWYOTLPwQb/U=;
 b=WK/VTtpqWZUO0RdCwTkN/auP+yOGNuynwoF6vVP06Z3APsqx8zBcvEjKvrvvCHrnqU1EYKnF2nMDAZg9zARi6Xa6KgGbjNz913CglDJ+lGa6sdhyU5b2r+IwmZJxuFO2GfIi+nlURVygzRct2g7njXWKoOv+OQg9/VvrlWTVfB7bXv8u9OHnHimeoZKwPzEDmSjc69Wc/UMWjc1g27GMjFLzj9pzEB6gCpWn4c+c/E0YV1eQAgyAS5NwUQ7aEFJzUcIPN2iI6nLJXPeobblLYjmn/y7XHNKV/Pmu9svuUciZV3SBFnriV/88UXfB+hWj4UyvFIAQTwXu9xym6sVvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3gxVcbTnuNp5UDolhn76c0ipFYCaxDIWYOTLPwQb/U=;
 b=fzQGm3cVidgMQA0UtqSj3ivBWGGG3bPV+tPte5xYtOQ5GiCOp93PFMAzkosafYMwJTCLMR9nKa0U742Aw77rYgkgcxZcLmRRxEIDmHDHw+c4XNX4brHyS0xZNK6Cyo4ynhOvcoL0KFK8oMSy/MDFPOQy8LR5yczuUuiBENw39eE=
Received: from DS7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::14) by
 LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 06:20:06 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:259:cafe::81) by DS7P220CA0084.outlook.office365.com
 (2603:10b6:8:259::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Sun,
 28 Jun 2026 06:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 06:20:05 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 01:20:03 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH] drm/amdgpu/mes: Add NULL check for mes_hung_db_array
 allocation
Date: Sun, 28 Jun 2026 16:19:51 +1000
Message-ID: <20260628061951.1562536-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ce4054-54e7-4343-d233-08ded4dd4be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /pJWfkMP3Ipc5V3ubmopsAajh/BpHbNBa9KxAHSoFlWdTHPYxEFCGfAtIBgje23cC85F4kY5979No16sMq4KKSFKGd8Dc2O55r+XJ9tVQZLNb9nfmovFt69+qFOzRvpQzRkh2qx5VK7ACzsqM3iuyxwrz5UGcD2LmbGy271d9HEr/iwoNna+UFdAyk1w005boUhLjplbSus6c+BBFXMHl5zt0fJdHOIOT7/oM/+T3+ZtYZka9sN9LcdepZhpIZoqR/i8PJAuD/UT9DeR9SeQQbN21tzv23C5Edqsuv7Gj7uX7RFa2maEg9VyqjW3/ofz28RuifDEmqxOlxntQWHhcrhEk8CK5WEVCBL99InBKXSbOz5Ra2zSIw2HqXzpW3fzswwNzhlaecjTDA4l/cWivwYlMKnJgeOTki0Z0Uv8YkRRzVr04dXsbfmv78VuEnNLxzIFir/hePmxEko9cx3trlFf+scDRAGIMbmvq+Mtcc+P8c0ya5nc56K26cEX+I75PJvKCILAZ4ATA5NJE7dR1ATTarXitU3EJmW66LKLlIkPrr40f1HB7nCbwiLutNeRcvvHzmMots/JRoDwGa6tOA8SSKXgHHR7OlSta22SIHrTX8GO+Au9Nn5lfinGYSLuhS+f49KvK5W8lR/vPkSILWBki9ye8ciem5jkuZLvLs6y8U5z2IaS195dydsfym9+y7cscrPNUllOr0SxzCn1gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sSqjW4dD8TiVDPGDmzAbJ9p3Uo6cfHOs474OZRBJiFi84/NaxeH4ljrhzT49k+gptSKKYOWK+U6g5QF8O59SXgwdxlbgvoLUpChk36QFHxlRJkCwnuiuJjPY6dxKlpzEfM7AzicbM1V0EhkYW0iREjWB0V7YTyj07dsW/LvWu/2kM/3HArHCscbV6QdoDWg8zD+HDILGkGiLU3Bz3+/DuqQK/NqTAnKkQSdpTEKABjIK6hjQJo9IqNGO5XQ9coWP/aC/FiFh14d0paESdIeMgKpqgm6kqLGUnKqWgkpeyzsFqkGL7LpMFhAXzpr84XywSAX2S5FSyrEJG01WhMgk/PRfT8jOSwjw/Cp6y5SkOXVQRlKPJ97iOcNWqCHKl+bPWlUZYxbyJ3WquQZt6MfxPLe1lCD2yREJT1seY5cq21ORLZgcVI2hK8ljEsU6l1fN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 06:20:05.8343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ce4054-54e7-4343-d233-08ded4dd4be1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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

kcalloc but does not check for failure. If the allocation fails, the
pointer remains NULL but the function returns success. Subsequent code
using this buffer will dereference a NULL pointer, causing a kernel
oops. Add a check to return -ENOMEM if the allocation fails.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6c0dde3786e3..261ddc19c840 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -250,11 +250,16 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 				goto error_doorbell;
 			}
 		}
-	}
 
-	adev->gfx.mec.mes_hung_db_array =
-		kcalloc(amdgpu_mes_get_hung_queue_db_array_size(adev),
-			sizeof(u32), GFP_KERNEL);
+		adev->gfx.mec.mes_hung_db_array =
+			kcalloc(amdgpu_mes_get_hung_queue_db_array_size(adev),
+				sizeof(u32), GFP_KERNEL);
+
+		if (!adev->gfx.mec.mes_hung_db_array) {
+			r = -ENOMEM;
+			goto error_doorbell;
+		}
+	}
 
 	return 0;
 
-- 
2.43.0

