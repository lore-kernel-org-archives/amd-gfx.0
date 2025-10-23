Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDD2CCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 18:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A9A10E0AD;
	Thu, 23 Oct 2025 18:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l7pJht97";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE1A10E08C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 18:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqAtggG2dnKjQ4k4F1mhINFImt2LJj6nSxLimpccr25J3J6knpQqvfb9kAMmLy9EgO8//o2o46y6Kmj60JCwQx4mYHkqkNxvlq5vDfSe6zoGZswWelPnQE877Mmxxd9jW5mDORQwkX6DGQM8JskgIsi/80wWBMuvB5RLFhMnhaPvM6KM/OJfJcnULN03ey+ZPxAUAGBf43B9AS8EzjJpzSZmp5C7zDwueT+/L26Yj8Axo5dnKXFsdKy53SSYbPIipjoguFhZxnHuqS94N74NwS3+Zjrq/MQsngZyp2jLiyLZuGsPqGzF1MdCNCvgnjCJVAgO/ngW/5yyJ2zwjnIS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuoKCUO27e3Kt0TWWDfab8iV/ULxogYapMh/Z5BbDYo=;
 b=w2VjPD4eCR1SfDvLILQ+0kMarnPpdy64oueWWThgKjh8D04l0CNrqdxfcoY3pAIhNicB9n7uew6U1airTAZYvX+8uvAQPgJmO5dLl/37OF3GJjMZcv74SPAaSV0NbJ+IB2eDKchd2TujsscwWzbicWeD3DgZnluDClblQZpztefspZv0WUjXK3HxuqmLi/mlS7Ql78+t7KwQqFurJKrn57zDtVLkrDUfJuRTgq2WpHqCa1KtBGF8E7Ovd1urEj/q3vF7uI9ejSdn43Qh+tY+CejxF316Bd2lnG+07Zx8PJDO4D/04jaBomMatgyYgWCvAj0M8Vs1LiZS37/yrsyYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuoKCUO27e3Kt0TWWDfab8iV/ULxogYapMh/Z5BbDYo=;
 b=l7pJht97MzVgwYBccWRaexfUwl5+1tBxhM/t79Cr6Hfxw6NrGAA59Uny50nWSs5uLc3drcZLPex9ki6T5vqf0juK8BROLr39xIXuGEWtsupjIb4RGyUojmIT4aofC+Mxh6xq170d8FBfPh1HgDjl6HHikAjz9oi9A54EhyyheWg=
Received: from BL1PR13CA0175.namprd13.prod.outlook.com (2603:10b6:208:2bd::30)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:45:27 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::83) by BL1PR13CA0175.outlook.office365.com
 (2603:10b6:208:2bd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 18:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 18:45:27 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Oct
 2025 11:45:18 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: set default gfx reset masks for gfx6-8
Date: Thu, 23 Oct 2025 14:45:03 -0400
Message-ID: <20251023184504.5643-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a8ab05-a2cc-4440-ba63-08de126455b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/bdjXzEfLBXLcIop6ahHRelcDO5TG9eaqmOQAgU+h4gOpfxpGSF0zgxNORBD?=
 =?us-ascii?Q?QAD5kB2dATI4GQgGxHBSd8MXY7iomMiqi/XdKmwFdFqhVSo3DC5LqlawFtYY?=
 =?us-ascii?Q?21Wbl0X0zSODu/hik/4gZbQ7C0JPyZnL/NAGiYAjhvOIHNCK0A9mULXKM2IF?=
 =?us-ascii?Q?NtxyhL2vKA7RKfNhYB53kb1JUi/bvGWjrT+1JlTgjQDuatHNHpEb5v7RXazn?=
 =?us-ascii?Q?2Ea/PIYyRO3PaoqlbDtb8/DYIsyTzT4pmALCSUvIB+4W/q9l152wroOZ2g70?=
 =?us-ascii?Q?xgJaBazEDOAYErofY7/oQxyNTdsdhQZvP6Z8TIZSWbdKGzXwfgTkX7aFplSe?=
 =?us-ascii?Q?wrg1tMILAXy9oQIaS3Fh9r45093tHxagnWEtiEsfkvd30V9IOjn1L9jFSkCz?=
 =?us-ascii?Q?3ZQGvqlDEYClLjd0w65ng+Wjrq9ZvYTzGxygCIK59FzzvLRyoaqicmKZGYXc?=
 =?us-ascii?Q?Xm0YjicSKqNHK58jCqvMLuJSV9GnTtAXhuHffIws/a++w5hmyyNpDAHrUQF3?=
 =?us-ascii?Q?GLjghvOxv0ProAwFgYENyUNTsTLD2dAFTeTF010BCyiK0Mnyn+u79wI3UTVJ?=
 =?us-ascii?Q?tNFGhbF2QeQhCBer+I2CLtZm+rsrkUht1pLZLc956wxpOfAawfkiNTsG6KLU?=
 =?us-ascii?Q?fadXJwefRUyaprIr8y0a1Dq3hfiX/bRC1Cg5nLhuR4Fnz33ponnhduU6hv/e?=
 =?us-ascii?Q?hBT23aNltgjsNoOc13qzht89RaxAUQj9DD9klGISSyY80gzjFjDW/QvmBGVy?=
 =?us-ascii?Q?Ae5LpjufbDs9j0JwEtEfPMmp08B5hSAyBtNWeER67FdIUxk9wAs7fufmUVVr?=
 =?us-ascii?Q?YiTzULL6YX4BUKyJXvlXUFlRHDetUlmzKE7yBp1oeF8y9v71sIbvQZyzNZtR?=
 =?us-ascii?Q?M8pNwYKs3Z16HuUsk6oPB1x+9JnoLopd+AwhwNPQJb8pv1Wl7yJ5SOhZGE1m?=
 =?us-ascii?Q?3dY0nXt4L1I7UJGY6pIzIR0WRU2hu76CDlbWOALmE0PaSLUx1IhBpHkf209Z?=
 =?us-ascii?Q?cpN2LWy2BX9s23j4lnNuFzAkW1G8xtL8DBh4iJ73+0AtIFa5QNhd1819c0t9?=
 =?us-ascii?Q?S3YPMxCoAiVnmMQXrE3dTAxFrcLY/AupYN2mvfl2rRLA63U8vAjj6v1u3g+p?=
 =?us-ascii?Q?ZTjW47MGbQAZ7I0ZEZBHnPz8lpUloaH8jEcKe9UzqPUqWHZ7fli9lxjA+dRD?=
 =?us-ascii?Q?iwzYvBrC+WVUhvfNGWEDHt44NqIXui1m+8nZQKfeOHCkUwF8iAgveVf+aZQu?=
 =?us-ascii?Q?7SIPoPJSUtzSuw2sIcORB7ch56KKqdgc4pu4KfgSMwdqxxoEa2lw2K19QxpE?=
 =?us-ascii?Q?cRO8F+mvgETGQc8fJoNd+a0S4372qKUzbn/WEePPjzDdg3Mg7A41FB9VGKsk?=
 =?us-ascii?Q?szz4TqF6LoZ5+AaJfGhHNbJOVonuQBPP8pPzNtWOQzM+8O0wSQUrzXyj9Iaj?=
 =?us-ascii?Q?ELlRSQs0tyThDVlN5SeMZ6Y0E5fMDpSYyiRbmj9j//q9U/CHCdE1SsjEVxBT?=
 =?us-ascii?Q?8kpL1NpdCNiEj8uE6IX9j8pGFYfq4FUn5xi5LinCvNyVu7YMh9RLCIBBsfnO?=
 =?us-ascii?Q?HFTcFOWACSnAryLKzJU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:45:27.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a8ab05-a2cc-4440-ba63-08de126455b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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

These were not set so soft recovery was inadvertantly
disabled.

Fixes: 6ac55eab4fc4 ("drm/amdgpu: move reset support type checks into the caller")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 7693b79534267..80565392313f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3102,6 +3102,11 @@ static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 5976ed55d9dbd..2b7aba22ecc19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4399,6 +4399,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v7_0_gpu_early_init(adev);
 
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index d3d0a4b0380cf..1c87375e1dd58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2023,6 +2023,11 @@ static int gfx_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	return 0;
 }
 
-- 
2.51.0

