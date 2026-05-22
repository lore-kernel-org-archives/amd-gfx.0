Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB90BCD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C63410F488;
	Fri, 22 May 2026 00:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLZagLdA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE0310F481
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPK1qFXbqv5GN/FpaPHmb08ZOmF+neYDk58rD/GvvHZUoYSbWirKBHmdJsirqQVcYy9kNLUeKdaj1c7uGohkdSPm85JzpXo3ZdX15Ua5g5k+iQdqgTcU8qfCtux5Sbo5CCzF4oCKH+7LHFWX5fcCHy4l+1cYACuBUe/SEZivx1muav1g2mFaHmzAagnMl7808DSkoenBvVrng0/R97FS7zGlxMlQK6kGDuw1lB7gKVq9TinjcmLYzEg7Dy+UhjkLSkny2cFIuiETCZJ7pgodza9LJTgIGwQbcCl952et/GzjoTzI9SLcnkfZAMYmlvWHGzoMTtzLUnbTfWDYdTvv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI2ie7oC4tHPQVzJthCWhc6PGjVcBvKu+hnytM+0U3s=;
 b=TTjSJM9x6umqjipSgrklPjSWQqdMoEvHM1+RSC6N9k98C2dG3DaeSRmHc0LHKNGKoz7xczXRR194LQvdx93ZO+QvtqLPoANmXfFYZwRXyoUWBIQax2oiEQvHNueCtqZC6Ao4FVtFsvN7hZAidQoRi2C5JEzXcOucdn6xumyGol65ZOq8IGL0UVm3Gt8GM0s8x45tp+PJo3BbseV9Yx86NQsZF0/dRQ6CHXow7sviHo2y+d/ZkQYwnaIQNdwevTpOUCrzQt7pej5kBerWhVAd9yEKBQMV6G/dFvfwfPWDAsWx7POovQjyicnmxOrMcWhaaZzR605i/kW6T4Mr5InQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI2ie7oC4tHPQVzJthCWhc6PGjVcBvKu+hnytM+0U3s=;
 b=FLZagLdA/X9LNJHvJWsnWzIsRrXXxQDLfs8Ssl2kRHmu3J5IXEygdZ3LKUTbRF3oza5++1ChZC61R6O1S0dMgG6GXQwILuBeJbOHcSMWF4EncvxxXjgXfySUeGv87Y9yo59wUMU44sLIFFbbjRt3YdnSg83K1NxEk1+VOlsaEy8=
Received: from CH2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:610:51::29)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:22:16 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::9f) by CH2PR15CA0019.outlook.office365.com
 (2603:10b6:610:51::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/42] drm/amdgpu/gfx12: unmap the queue via MES on reset for
 MMIO path
Date: Thu, 21 May 2026 20:20:37 -0400
Message-ID: <20260522002048.98506-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 3029999b-0c02-4914-2701-08deb7982dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rJN7Rhb6iv6wAz8f4seS98PnyLWt060LzuaP6hrXEzg5RGeh8SD7qpuU0XNA8rUHqnGOW7XopeswUC7Yek2bSN7I6Qn+skk4a//ll6lQFMDTXRB1JOVlvyM0oThCjBd0LZ18SUw+VL/p8DGdORH30UqFsNfaTJZ6ky81N2OKH9nHTf2XKt+oeVQ8fd/3EwW5yjWmOxRBWivATQCCtgWmorrKoMKj3IWbFbNDQp2hzN4boSu+g2E+bti8vqbnpflGN/BDp8SGedvArGEqKXmEDeirvk+oqqIy+z9isw4p+xsK50PMj1GOnAnn+MZUuiJIZCgasBscMMLXpcikp3qGZ3pGHZfFHs6NIaVoemaWMxQUL/Vb4CibZMyP7Ndbgbq9d7U1XA8mJ9KoN0YFRwVED2o6HSgN8tpni3FOjV9Lai2EgT6JTgquTYbL8S7b9xZ0pfhLGklD3wFIEFSCwRQjGpKS6+7u9AL5t613ApFvgGMIrl9W7in+xlwHy/s5dUnlwOYGHZJfcMtU4Axg2bI9cDFYIAiu93pXWTdXGPspo6giz7kX88WVRMhlIbZKIq2XLE8jZuJdn6RuT1FKYaAOXOInZ2JzrZNuVc+zZ8/OEUM397lA5FBTBxnb3O1woKcn8PxwZrJkFrVnFXBbvYMRFEvJkNBbQjbhZ3H/gd0zdv8rzgazNbaktnUYoVmk5OfouZstxjHwwgCXkqV4+cuVSC7OaIpX0HYPUOg9yQ/bksk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dTu6ewVM5ZbP3DO5a3zkDLnXggc4L6/ar2Fvf2DtRi8O4rdr3Br+ddLG4TGxqad7RdGYmnmHirT7o+NI3zoZ1YO2lJt2CTPXvYhQ1svV7UXWdxAXSWvEm+kHGCt3j/UzldSvtB30ZGCuowY8A6VFkX/8+DM6ROfihvw2uq9ZP/s4JxuUcGcGRj48g48W+7/5DtzU74ETcC08m1wBG6mBqkaF1A6YHYj8K8Dka3cWRL4+K31JiVU97WI9kOheXqG+1GTuWKeuyQ4V3lSAccqXZm8DKsPKrR8ekXQ65mSGDu1tihXB0+KKMGchztJ/7uuSQZtfEUeXu4A5Q+psDX1uFQb2Tqh3zrGxQsKIRANrRF8ZICpbN1eDIMYHlv5SzjdzshZe3EyWwmHmNyKg1Z43LoPeCSAwjSShAaRn0YaE1J/CkTRNoVrilAPVvImyRZ9G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:16.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3029999b-0c02-4914-2701-08deb7982dba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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

To keep MES in sync.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 375621f657bc5..3c6f234cfb29d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5226,6 +5226,10 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
@@ -5253,6 +5257,10 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-- 
2.54.0

