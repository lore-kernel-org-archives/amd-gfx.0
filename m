Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD008C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5961B10F351;
	Fri, 21 Aug 2026 16:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RXSZYE/n";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B9F10F350
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWcjpMcOfuMeYg1wn5FtLgyvIEopgEVgekbhIfJjrtFceTZNd93sMV9gSAmJPyxJFoettBw4S17lsfy9codBY/3CGXdkukx14uol6onK+R//oqQMh119UdWXVLU9e4/RoGV2s6aQEbaeLPD3c+AcwoODdwX9hTL9f+BlrndNxuavUQMFixiiL46m7GruDqVtc5ijWjZ9Qv3bGrJ37EVwddfEwbS6DzOuUFiwZqWmmPxCamTMQp/rg3oGr71ua/HvL/wjUhgj5R/P/OevvqF4oc27UVkHWsbIrCl6H5adhMcdcHu32IINdOJUTeyHPZMBfRqmZpFxjAslI2R3fr2gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEzR1i6IN7QvLqv86m4Wj0NDLArUSRM5Aro0Zoqa1b4=;
 b=GNlQ2ts7dZlrW5p0xr2E6YsjpwofyaNy2+6jpCtJG2REG8/h2qBSKC8FU2hMSvffRgQI/9H2j+pJBZHUPHB+J47iZ3xksZoStvts/RgFNk3k7EPe0bKVBHruZKaYQsov3wJ8d5fBblNR1cnRuSvs+/bXcNKuOKj5kgyYykXY7TVNq7jHAErTxi04UmrAD3e0Hf990VfIjdLfQKt8H42aPuUgyuF7QiuExcBdE8JcPjhXkQAftIDh4Xe4hhEumznRCpczloSxXLwY5MB54i6JMXn9hkgk1DtKhDqzPB9h8Rh2w7R4++JI823nbX49o2yNxvPEP59Tn1EaIZjpr/kkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEzR1i6IN7QvLqv86m4Wj0NDLArUSRM5Aro0Zoqa1b4=;
 b=RXSZYE/netZ1jmZaleO0BdG/woDwrthmTseqLmRt/Joky9+Bqnfky6DkIcPgJIPQ4ZUWqbarDfpm1dK4PWwhRuwaQ0O0XlDWNc6FrUItJBsTTmc0yXvH5Kf2yXdFo1XYhxA4d9ed2A3mYqGfQyODM5QCgpfIZIU8Wa+YP9uc0yQ=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 21 Aug
 2026 16:07:25 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::77) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 16:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/15] drm/amdgpu: retire tcc info and tcp harvest from gfx
 v12.1.0
Date: Fri, 21 Aug 2026 12:06:59 -0400
Message-ID: <20260821160710.752459-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: c39eb311-f584-42f3-d438-08deff9e4ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: CNkPB0KgAB5y7sLdb+FWLqPoiMzjS13z5J0WndAOfpIZ8xwgofJzMe7bJIWRx2HQigeJ2Ojwh+oBY6tJOSUchLeQI7TrnObr85bdehs8CpBqi50GsS2hkOTar6XGdF0/04QVkV7as+sm+xFH/eFXAcfNCxuaeroSSOdiYbi+AnUbPF7TMVYhCgD4ANVtDsI9JvEFxJUIeiGwDq3zixTUBy93oOSO+ywE5u3hd1Q/+WnCnIlxdqTpgpl4jEUcX+qkj3hnWqkWF1Jx7UrmbloDbQPYftVZByONl6hqjn9M429swiYm/0cS7omT4CjnuSr5yuDJAK3SD36L8EcODt6OL+0y24Zub73/Bmq3GQFHrBsKt+vFuvdeF2tlsGeId+yEVWspJqMdjdBiHvdU7Pry973vXsTcYeKjqOCVED1/ohMgLgB0YaxvZvy2LrCOyhoEmyMG+qwqNXV4kkStx8cDMNjliKpA03YVxdB1uJGRaDvyEg/LY0Dh4KpDPXrKzg6fn4vUaJlso5XpInyJnfvbP/wzGEA5oFBYxK16mF4j21D618UUlL5IrB6ZZUKzjPELucIjcikWAdLJPzqaJFzTWp/bqrxqgtbsiPsLCkNKZTs57tsRYaXWxmSW21nCDD9l0AWxe+j5pLthRWsi6XWoyy86D6HmRHAqCy9N5hkO0K/vct73tvzbR8U4eRNJm90Ni1186QD1jIuZhmKD/Pe+Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dPW14L/nDXtur4dpG9/xNMq81wIvfQ/iq0y53OV+4aljNDLRAQ2O/1jkSkctww8MdikUsQgs5d+Pi9pJCS4jIzfeMMkg6mnCWd1Ddq5rUHYpRu6jKNgLFpquyrfdfNNPHPCRvbXqjC8Lhezy7IiSxa6kM7wnv4M00MGm3mfkOjO604XAiXbfzfBmuGDt7PSY4cfNLGPhZ9En3iSdZiA55nagX8goHPSO7tIqWifdSG+1Bav4F/PcykiITJXi4EIDVoU3a570XmjEkY2fKq1YsQnBXCadnTvJg8tidg/Kr32tfr4ziNAihrtdKpl23DQVjCQWXrQhRZjIx2ztp0vuXxz8B+PpoyV+IgJpp7UOPAF8Fbh6in41fvZZfwTIXvOlhwUx0v/u4NCbH1RtdULQAQrXBWTA1QO8xY8aEa4Wco3Kd4MAwU4ESwZVMLKywbmK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:25.5604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39eb311-f584-42f3-d438-08deff9e4ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

Both of them are not required for gfx_v12_1.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4192e49fbb291..93d8aec4a4a10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1686,15 +1686,6 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static void gfx_v12_1_tcp_harvest(struct amdgpu_device *adev)
-{
-	/* TODO: harvest feature to be added later. */
-}
-
-static void gfx_v12_1_get_tcc_info(struct amdgpu_device *adev)
-{
-}
-
 static void gfx_v12_1_xcc_xnack_set_chicken_bits(struct amdgpu_device *adev, int xcc_id)
 {
 	/* NOTE: COMPRESSION_ENABLE is used a chicken bit to enable/disable xcc xnack */
@@ -1746,7 +1737,6 @@ static void gfx_v12_1_constants_init(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	gfx_v12_1_get_cu_info(adev, &adev->gfx.cu_info);
-	gfx_v12_1_get_tcc_info(adev);
 	adev->gfx.config.pa_sc_tile_steering_override = 0;
 
 	for (i = 0; i < num_xcc; i++)
@@ -3065,12 +3055,6 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/*
-	 * init golden registers and rlc resume may override some registers,
-	 * reconfig them here
-	 */
-	gfx_v12_1_tcp_harvest(adev);
-
 	r = gfx_v12_1_cp_resume(adev);
 	if (r)
 		return r;
-- 
2.55.0

