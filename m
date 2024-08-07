Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B337C52D7B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9598C10E4A7;
	Wed,  7 Aug 2024 09:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n+KPiuWa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC0810E4A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpssVtnPsAuui5M2u6dlhw3hEh3//VE7X0BjVFSAhvoFr5iimWrUoFKwPaZi2W+WRghQA+Go/IWoLWP0n6MYXjJWiaBQGOwDBSxLyK08cYpID2KIdyaMPbvQVWl5jm239TYcKnpYyaPVL/WWEfR5DKBTBTSi1aOhqKs//d4qktozPX5ZYwXOky28U2v/1YFKLv2ayp9LWvfybxjqxXGJyqLKqusmRDvIrR4BmwALFJefm3FkjCx0Nq+oAMkex/oZjs8C7i0r5HaXWajm5ki6Dafq4VqJSzbrDlTpmVgvVtvm53hebepRhFrdESEm6B6ZPfQjKq4wIM2xHM6e70ijLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cfU0xSHG7ikJQZdK44phNUVEHbF0zDdvBHkdwoSTAQ=;
 b=Ts/MzoTU4HVIJXkoRLS0ABtLQ8SgPeyKA8TKcv57S/GQ9fviQmiVqpFfrgO/hV4QGAqLZ2QnE7244K2t09txFO90+Xh87s7+6enU1uIotgeDwakr8LHHwDxFsN4nXob3iosv8YSE4qzJrtKfrnTy96AwWnQhk0PhUK4uep3NEROkpEJnHKV+tTzVwfeQ0Y3fZbdXBcZcJEQ68frM+z7FWIfaV+7BMIofSYyhHsmKnusqG9H1qHUOYtrIuZgcVLCEPFuxLCjJdKjXzWG7q845YsJtrfd/kKlHXeHABWaxE13YxWTplV2IP5/WOF6VklKsI4HdCMhzIfKjcWs80r4d9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cfU0xSHG7ikJQZdK44phNUVEHbF0zDdvBHkdwoSTAQ=;
 b=n+KPiuWaNclRWmf+7oKRMlHYkp7LI5JtDf535vNCgztggYrQ9AvfpEh7EMaHLuQqrNj4p4eWNG9DlaxrYEOhn1BubgR/g4soPdLat0YbsWox9i02NbU9iy1VMgUKLBZ/TqMMyDBV6XUsm2T4Im4v7J6GKXf+guGHT2zv0OLqpUA=
Received: from DM6PR02CA0072.namprd02.prod.outlook.com (2603:10b6:5:177::49)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 09:39:14 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::d1) by DM6PR02CA0072.outlook.office365.com
 (2603:10b6:5:177::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:13 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:12 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/mes12: load unified mes fw on pipe0 and pipe1
Date: Wed, 7 Aug 2024 17:38:42 +0800
Message-ID: <20240807093847.2084710-4-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cecdfaa-5775-4435-c293-08dcb6c4cc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJpIuWKA5IMNOU3ZV/tDSZZNxK8f7aU6xk+bNZi0PF0IFszDyRU/gCqkeiSs?=
 =?us-ascii?Q?QqZiTpN+SayS20o6MXYifNHqVAqEK/XjMJriAWqTjavW3IjUfHcpY7X9OxNX?=
 =?us-ascii?Q?NW9O/i8O74u35qDHTNzYp6MiDJTp6mmr7jhvjyKt1r22Fs8E5oJakQKTiCBI?=
 =?us-ascii?Q?6GKr5D1FM6E/J1L2UEVOaUN7XBjyYmCwtxQ/HJImLES64oUDAslhI1vuW2OT?=
 =?us-ascii?Q?57/CGA+NlAyy92lrgDRmzcyLLGT66FiGCuGfkUi6Gca/6iYOQHIczWevmR8m?=
 =?us-ascii?Q?g4VnTlXoEjlXZH3Jl1QcLx+UfDsF1X9HrnU+S8eQaUQoI21ZVpuTUBHD0qD6?=
 =?us-ascii?Q?GuMksPXCrXplTJ9IpJCc8Ldm5PNb0acIPfxmSC7gT+OJw10zxP+Ku1M7SWX0?=
 =?us-ascii?Q?vjz2QLvGtO7NGveMBRqOE//wLxbFxOgrClZmaRMEZIXccXSiJG6vdOL2XTA7?=
 =?us-ascii?Q?Dorkk+KvJTrtVo4Qh0g4BbTEsPDu84I7NF4zmP24/zy6e7HBTARl5evs1b9Y?=
 =?us-ascii?Q?830VUSeyupJDzykKuow5st//kJI/RRt1vBIKtDLFY1odvRDNKhrBlUj3pBOH?=
 =?us-ascii?Q?W4ABzS3th3NVbVsWhGaJDYfexEH+E2lcdppWpi8i6p/P3n1lwktfzSgMCMSl?=
 =?us-ascii?Q?yj2PzrMYwQLHX0TYRBUND2rVldIYJM6nzJb/fC2ssDgWltRAJRoqWEEHl8Y3?=
 =?us-ascii?Q?PbwfM2DXi79/98zNhQ99lmWVQzZI056ZzEejNzwUG3MLosADIvJnzFnmoxHR?=
 =?us-ascii?Q?mqLXS7lb9VUknAvclOpLoZCBZZNC5MiV83xypU28RabTNhKMNeiTE/k+qqSz?=
 =?us-ascii?Q?QD+1X4R9djYn8QMqCvozzgcJyRYRJ1cJmMDH5VHteKWnKprtXgII2B9ybvng?=
 =?us-ascii?Q?27gDzVSJmsbctFkFuY2c4TiMaZvNOS1HWaD/aHE0UlTzDS0yNQ46f4Md0x4S?=
 =?us-ascii?Q?O1udBfT+bB/4bOHFJyqVdnj7hGO8j1WtLx6vvoIrwg/iElAu6YU0i7pKV0Wy?=
 =?us-ascii?Q?lTPUgtKr3VCeDIsJx4wv8GyRsA3gV6TS+TCVQiZWIyhDbNTe4Gkldf+iYhSL?=
 =?us-ascii?Q?VbMHU129892SlDW3083hVFbMYnG7ykbewNNPQ3mMAEAGkmtu1UbBMPqGdFAV?=
 =?us-ascii?Q?B2SLYUrpjQRXEgz3d6ouHzbWJGWylNkMbjLEXKICWgeVvG3VeSQ6Cyk3Pqcf?=
 =?us-ascii?Q?rdE+XeMmrA4W1THetlwMhona0YuAu6PTpXusxnXV+Aqeko7UiRUH9e/NIkwE?=
 =?us-ascii?Q?5Ulnt4ZoAOAOWOHf+qfqVWiuhY1/4eQl8l8C4VDcn4BpeEX94SXfpJ/eM91E?=
 =?us-ascii?Q?9705u5L0sMWQx5AirJ4uQMvvwDjnASFc0sxJABaiTjMyjh/A+b7oNwyZxodH?=
 =?us-ascii?Q?DpdDyiAEUA2+DaSiWjnBHvTJjhRwSlyPlozbl90SOGPpapVdVJoiihv/nt7i?=
 =?us-ascii?Q?VnIz/0wlYw+ZYGeussExYmS4t2/bmEaj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:13.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cecdfaa-5775-4435-c293-08dcb6c4cc64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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

Enable unified mes firmware to load on pipe0 and pipe1.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 27 +++----------------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f3437a2d2d2b..52277129ea5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1500,7 +1500,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-	if (adev->enable_uni_mes && pipe == AMDGPU_MES_SCHED_PIPE) {
+	if (adev->enable_uni_mes) {
 		snprintf(fw_name, sizeof(fw_name),
 			 "amdgpu/%s_uni_mes.bin", ucode_prefix);
 	} else if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 65f2d33978db..932629e47c9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -742,16 +742,11 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 	if (enable) {
 		data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
-		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET,
-		       (!adev->enable_uni_mes && adev->enable_mes_kiq) ? 1 : 0);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET, 1);
 		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 
 		mutex_lock(&adev->srbm_mutex);
 		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
-			if ((!adev->enable_mes_kiq || adev->enable_uni_mes) &&
-			    pipe == AMDGPU_MES_KIQ_PIPE)
-				continue;
-
 			soc21_grbm_select(adev, 3, pipe, 0, 0);
 
 			ucode_addr = adev->mes.uc_start_addr[pipe] >> 2;
@@ -765,8 +760,7 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 
 		/* unhalt MES and activate pipe0 */
 		data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, 1);
-		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE,
-		       (!adev->enable_uni_mes && adev->enable_mes_kiq) ? 1 : 0);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE, 1);
 		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 
 		if (amdgpu_emu_mode)
@@ -782,8 +776,7 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 		data = REG_SET_FIELD(data, CP_MES_CNTL,
 				     MES_INVALIDATE_ICACHE, 1);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
-		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET,
-		       (!adev->enable_uni_mes && adev->enable_mes_kiq) ? 1 : 0);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET, 1);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_HALT, 1);
 		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 	}
@@ -798,10 +791,6 @@ static void mes_v12_0_set_ucode_start_addr(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->srbm_mutex);
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
-		if ((!adev->enable_mes_kiq || adev->enable_uni_mes) &&
-		    pipe == AMDGPU_MES_KIQ_PIPE)
-			continue;
-
 		/* me=3, queue=0 */
 		soc21_grbm_select(adev, 3, pipe, 0, 0);
 
@@ -1521,17 +1510,7 @@ static int mes_v12_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int pipe, r;
 
-	if (adev->enable_uni_mes) {
-		r = amdgpu_mes_init_microcode(adev, AMDGPU_MES_SCHED_PIPE);
-		if (!r)
-			return 0;
-
-		adev->enable_uni_mes = false;
-	}
-
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
-		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
-			continue;
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
 			return r;
-- 
2.41.0

