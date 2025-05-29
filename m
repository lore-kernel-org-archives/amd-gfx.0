Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EE3C5B543
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0761A10E76E;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yqVcbyB2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D049C10E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=touI2FOlBL0TH9GmbSFN36Oc3pk5j0pm1LFtF0HNxa6NutwgHe3nUtl+36iJx2UnzDTk008hgrY7m+jsgMWl3yO27sPKctTIQ8pB0kQDuriIA0x3SmZGGiS+bO+oPTBrssuxcDlt52VO7JJA/s11bE8NHU1keS+wQviGpzZqYKKEsiYr8ld4q3mWhzyDqRhArbEttaRuImfgzAfH5wVT2r2u2JokON0JiiHByfonFGOHtZpUH7ShdP1lYOmQ3kigBgyzOwNFKNvBcvoXsBkauf3E3T5Kh3TZclAyWrqFZYNpwWJ9IRQa3o1ltooKOw5N7WmtEtPbyZD7yT8eBSMGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4hGaAp9RncHSnC6qi8FJ/DUhNpT4x0n6TZ8NmQNmD0=;
 b=EV5jpzDmkPZ9AaC3iaw+u4q/nGmSZG8qe8SMI+apxotVKQim2qi9GjQkAm1geTz8AqdXJE7SIZJ7kHSP5MtoY5GuIJBZcch+pHCKnuPiKflcMjj84ECST73ZJtasLhrVvW9Zs5ZFIzvFdHeB6AvRo0uGjGPFksbnsLLPyPY3LkthGy9l7jgafjqHvS1dqgq2iGTwGR3I5SZGW21MvbTTiQtX2GR7JOvHpHWKXq2mDMk3FW5vhyEsYYsXXf3IXcz9eI2DY3HSpc5FVHp/fa8VNDunTg91iE79MDPzabAgP0G3x5olQx7Au5fbeWgus3Qz/rApLYET0uFKIB8qywAMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4hGaAp9RncHSnC6qi8FJ/DUhNpT4x0n6TZ8NmQNmD0=;
 b=yqVcbyB2PAneV0E8hFwjSv2KV8W4qW26f0gdggfuuqptCZHfdgLvYpKEiyMZsqSgkPqr0aoZh48nZnsMATbRVel56hKF18m8gaRveVDsOSNm1T7TrUMEgT/VL3ExDx8v+WXt5WzwmBft1KGDAo09lkG5u8QXC4PuWqO0S/I/YHs=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 29 May
 2025 20:08:31 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::ee) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Thu,
 29 May 2025 20:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/28] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:49 -0400
Message-ID: <20250529200758.6326-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3b2371-9c9d-4fdd-d6fc-08dd9eec9567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kn93I0sdq3sMd3czUch/lZ2p8RXeJRXNjo2TSGjSXi4oFZ2zA3Ek6bMshm6g?=
 =?us-ascii?Q?Uv5JtpXVxUkxGlUmqvQ3VZLps/EStvncPLWvHK0e7II/M7KNQRYxqCzuNa2G?=
 =?us-ascii?Q?mm9fR4pIVNJkqQtwl81IxMx9U4nweNVdlULPHLvALwyu6dzkmEgzgrixjBJ2?=
 =?us-ascii?Q?oPGfEe9dy7d8ihylxyS82/FiPJrEEsfBwsY0ONa7tqDzbXpTteX6mlpJHv6y?=
 =?us-ascii?Q?hiN2LjNqMTDSKVSyyGEMnOvB6l58iKU2dNtGXarurXN0lUdhLMfV1F9sYDRN?=
 =?us-ascii?Q?5M89NIVuhot1Pz4s8xht8ehVs1W6ZPXhD7HgaGYsocWu5X2ONxUwH9u48Bjo?=
 =?us-ascii?Q?OzRUHIv5wmtmieZPnXLo7mx3WiZiq3Gwd3jP1vKRqqemRLcrlQhffSYO8Ec2?=
 =?us-ascii?Q?7p3gC5SHrhoR+m6HVKoq86gHimrRJXvUU7+gg1PrbfuluY/HOkJ34GYNpsTj?=
 =?us-ascii?Q?JJasQ48ySUL9vYCIbawD3livxisksYdFf0x07E7n7LWp5huSyRZnhOjibvQk?=
 =?us-ascii?Q?i3Vbk2Ewz/uTP5Mpg3bsuvVZUP7lTBnituZ7suScGLrXKaUNidZ4OoJU7BJi?=
 =?us-ascii?Q?FvpidPhf7AbMCWEGLyBC43keqYFSGvzEfCwjFxqDyGHP77R+JKAalkuVcsk1?=
 =?us-ascii?Q?+dNnj7M9H2CSD6LmlRYNCoN0S7s3ebJbxrEg8cRD/BcqX5G8z6gl4OljWkki?=
 =?us-ascii?Q?v/hwfKa4uuu11UZ/j4NvCwOYGW/wuejB/IxMlP9HFxx/rVTNQ7M/jV9/2sfb?=
 =?us-ascii?Q?vSadfFoFRtsh3O7wrUmHoh78N8+PaqsrLV7Dozh/TgyncxYWeM/3vWsfppdb?=
 =?us-ascii?Q?S5siRdymdorCTHDiAQV2Ikg75FvLPbbYSPDB6kPodswa58Tda1kwylgYDCU6?=
 =?us-ascii?Q?MbKh/k5QR5mzjNDAKO/EWsZMl16cw1zrwY3Lb57OaWzmBmqotb0+IDk3knTz?=
 =?us-ascii?Q?nI2MXpnP32mEsVhfuDvzF2dZGj6pxVRCmbioG2tgRPwkamGk98XYUyKF7fL1?=
 =?us-ascii?Q?lbKIXp1F+R24/sDFHSMfcvp77m7OCL9CNSekrf3Xztp6BA1k51EpbUM2gNGF?=
 =?us-ascii?Q?H/7GzbCQ7iYcqg/6c4CLWSiY6EbaIcA5Nja6iv4TDsmjE+05RwNzvcKo1FAl?=
 =?us-ascii?Q?BRG+kQEEO3gFzcDKSXqgcbNhhPCHAwR7xgVyNWr+bGNCeaOp+gT7RZxhoLvZ?=
 =?us-ascii?Q?a+0a5beHzRDdh4X7v6SWReNo2gZGyVsP3yiXWGAVpRKDMahI1kRwy34TdDnM?=
 =?us-ascii?Q?FDk8uKDOlZQUASyqEU8TPbwQyWUwFRg4cuzdzRTANWYyNqPleiUzJVkSUQgR?=
 =?us-ascii?Q?OavaT+NlhJh437mI8gJaIQz7kHes4keLYhhKOnw3hqUJPUWy1C4QC6JPlUw4?=
 =?us-ascii?Q?i5fX9roglDU7s3Nl90rqXmU2FQPRZYdQthHZfB9U76i2WN90GSWPXxWH6D8Z?=
 =?us-ascii?Q?8cfjvdO+Mx6wXhAcyZQSueou1nG6MnUPI+x65//NdwBjK6cpfaBZO36JrLcc?=
 =?us-ascii?Q?EfLoKLhfPweNsp5/nwhB0RqJgWBVRogHGELx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:31.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3b2371-9c9d-4fdd-d6fc-08dd9eec9567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 7974d04c15e92..382126f3caae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,8 +559,8 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.49.0

