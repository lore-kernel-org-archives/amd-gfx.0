Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF56AD6DDEA
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 08:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACD810E3BD;
	Fri, 15 Nov 2024 08:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TtV3FBwn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1367710E3BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 08:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnE5wIP8w1DOFBrcrnuidLx9GGl45uPdLfmLDBQBY/6P/iFz4yqAowvLWUtu0VATELduKdKNlk1XxYmUEj/UcY3rPR2EuqnH+0HgUYopNIK8tFt8UToLcUZDuJZzY0sVgfsbHZd53tXbna+yb7ON9lFeITFB1IbRJpiJcYwqvqKgtXSJvxbP1HBIDTRB6nOY34JAn3nntMqLtSwllrNcwqh8BmGc/9oR4DmT7yfUoDsB5jBzwfeoO8OfmPiqnVyB8oKcBoZNfD5xyTD8C8DSDnxTMcyy+aO+aesdLxDJFNvEnDqT5jNAaj7RUZGqtVXPl6bH0MJTVlfE6PCFODyl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRDS4r4476BbLmVk7ee+rN2S3T01NnCvZUOfaepr36Q=;
 b=Neao2wdkEWqZAYaKpi+nQjje1Pm4Mr4LdQu6j36QiYhEDOIA2OyhdGvK/qEDpPFSwilahLAUN/Bl2Jeqm77vaV4PZRWD/JKBVk67kWhpXVRtwOzwpB6Oh7/SShAyDz0AH9EslsWLT+uc2KGzmtMge8qKvuRWlmuRGYW2cq0pyZn/9Zx3apz3Qh0laJBCiPHpoAw7FmZeHSd1ctCP1/fkazpvcB+azmxFPScNZo5UDj+TipVukprscpXkYVpPmzbx4DiJLIYMH4c/7p5r/a85vXP8sz7F4c+wzbzBLpnbu+sO0GoCqAXysTba1Kg6h/U9PeMrHHtVKuxpJc2dC4+NAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRDS4r4476BbLmVk7ee+rN2S3T01NnCvZUOfaepr36Q=;
 b=TtV3FBwnecS3VubVkcQRervLUk9AI/RCmnh4c6QKF0nWRgfcS3Tbb+L65LPlGpRdFbGMRywjXr9TaraJlOevgyia0UxyrazAnKm+rq+OBvmZB0FbKxvXNqwpeXWO1lCh6qjqHbjJknphe4S/YBdYPKwM9+051V1SK13N86QqIXY=
Received: from SN7PR18CA0030.namprd18.prod.outlook.com (2603:10b6:806:f3::7)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 08:39:55 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::61) by SN7PR18CA0030.outlook.office365.com
 (2603:10b6:806:f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 08:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 08:39:54 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 02:39:53 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting
Date: Fri, 15 Nov 2024 16:39:43 +0800
Message-ID: <20241115083943.284924-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8c08f0-2c6c-431b-c32d-08dd05511474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Muf955S1erR/sp/4CXwIHfJG9wvgxIa88eENKSYTeHcFiJ+AWpsqO1KXTFU8?=
 =?us-ascii?Q?yrMn7v69LsPL4oRQezWYqTRjaO7cPL1au28/GXa8odKtKmwt3kua9SU46efG?=
 =?us-ascii?Q?wdYY70WmEFjWfKDoYTAo8gRcRDbFAKkzOY2kCND2WnQY1SlCpx0ZS3DxyhcF?=
 =?us-ascii?Q?vwMrgG+MKAAKyo0f3mdiVMiYacYCZDqBNHd9rW/rA9+IyajdkZo9PsvJnR+L?=
 =?us-ascii?Q?wJ0CdKZH7br8CCxW/D9iwQpK8aQc04WbXzVH911bF479TPYeUZErkCX2u39a?=
 =?us-ascii?Q?p+LFB589Q/3zEb8xmdfgEQk+I3nvgV96w07MIo0HsTHlWB/AT1YqIB0l3VV1?=
 =?us-ascii?Q?gNTzpzDq++lVAkYHgvx3V4cMxEC5WcWSlj3reuQ0yHi61v7hHUoianThLPoA?=
 =?us-ascii?Q?bJKqmmlRNGYM2mGxrRg/5Miubm0SRisCgfvkJ7ldPSgFfkzjHBZgps0CWG0h?=
 =?us-ascii?Q?wFUk3uYqTGDtJ/b/KnxOe/f0nmIJ6mjt2kfAdj57ERyshA94YG3Vt2b1urG1?=
 =?us-ascii?Q?EyKaFHz+MfG8ypCdP8D0m+tImcCyBQQ0dXQC0ZKqnHqDmSSw4Gc7To6FD6fI?=
 =?us-ascii?Q?JPBuJh8cdJmWQrwkbGv5BYbGzoaYY0CPNbuieY8zyJFFVmooOEJLJOdCDZFj?=
 =?us-ascii?Q?VaumINSv0mK3t0mNyg57YeimWTOqA9tDB/h1hLwdTatqGExN6Ag4Qq+3/CfB?=
 =?us-ascii?Q?DlIJi34QgMlHlP7zWpW2W10VPdpJzuRnAzo3Op2SwchxGzFKtP/phW4DkWZB?=
 =?us-ascii?Q?HIuhIbqQnsy9WxPeBEHtzcRM9/3lan09ytGFimxfFm4V7ca9UKf7B15AWJm0?=
 =?us-ascii?Q?SHpTAo5rLLk39+YJ2H+SMlJe5X2kHqO42dnJQHJp0kEETb5nqlwUYkcnUTix?=
 =?us-ascii?Q?6Y4iWIs5ZxIHSIq/jLx3zIFpnkwZrwqwJJx6ArRspd2dXRWPglPX7VTPMS+Y?=
 =?us-ascii?Q?lNn1VDUCXG6q6Tv2sDr3K9X92xoBN4toapOvYL6bYNHqqrl8iE9Sy4vYxp3J?=
 =?us-ascii?Q?gfdjyE977RYjxEmagvCmuC7unAkcLU02sFt2Y/ct4ehZVnlHhXF2R7nweGTr?=
 =?us-ascii?Q?2neVMDOuXWAOVXeFmj06+hlhdpGJ7jGx5+YHhC1bi1zWuf/56LALJiv2g32y?=
 =?us-ascii?Q?To0lbsPYSj0WU2U1xM3FRoKlJHU0g5Dvzvlx+wVv6sleIox2ADjbOxtd3k7j?=
 =?us-ascii?Q?uYLyoz4c9y5nMQWElqTPMZXDAV4ITWePosPm+EK8CJfeT6hWzicluw7u8skr?=
 =?us-ascii?Q?qo9Zb7nJfHxwE9MiJbjrsKvcY3IDzp//uL89BrZUcYWbgKZ56IGz99E459cy?=
 =?us-ascii?Q?ezc2SgfO10h2gbJxy4w47v9bZUT5C0+Wv5VuVwcVj1N1QcuNBgKHYRxmC8JZ?=
 =?us-ascii?Q?+mXpKMSwV/ud7k3aKQwrZq4uYnZtjP/v24qcB4jCofineXe9tA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:39:54.9071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8c08f0-2c6c-431b-c32d-08dd05511474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

There's no need to perform the two MMIO writes in the KIQ
Setting registers programmed period, and reducing the MMIO
writes will save the driver loading time.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 8 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 +---
 8 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..ffd3c45b4ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6593,17 +6593,13 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
 		tmp &= 0xffffff00;
 		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
-		tmp |= 0x80;
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp | 0x80);
 		break;
 	default:
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
 		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-		tmp |= 0x80;
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);
 		break;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..a2aedcabae65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3890,9 +3890,7 @@ static void gfx_v11_0_kiq_setting(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
 static void gfx_v11_0_cp_set_doorbell_range(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..c61d383c45c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2826,9 +2826,7 @@ static void gfx_v12_0_kiq_setting(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
 static void gfx_v12_0_cp_set_doorbell_range(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 480c41ee947e..d465c3ea6e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4304,9 +4304,7 @@ static void gfx_v8_0_kiq_setting(struct amdgpu_ring *ring)
 	tmp = RREG32(mmRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32(mmRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32(mmRLC_CP_SCHEDULERS, tmp);
+	WREG32(mmRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
 static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e9248a855ba7..a6cb30558f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3482,9 +3482,7 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
 static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..ae3c8645633b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1771,9 +1771,7 @@ static void gfx_v9_4_3_xcc_kiq_setting(struct amdgpu_ring *ring, int xcc_id)
 	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
 static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8ca137313961..3b818441c7ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1491,9 +1491,7 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
 static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 9d0e342a2f81..44b0d0f76944 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1453,9 +1453,7 @@ static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
 static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
-- 
2.34.1

