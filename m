Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18133C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D0810E878;
	Thu, 25 Jul 2024 15:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2PpqqilT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A021610E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnwjWp6rvi9CHrGCkwJbBYu23Fjbko45S8CAvV/YN0nfsLPPyzK/JK17A8D2VCv5OCjVby05ApOrytJcCTVvndW/IH4o/NbvymhyoKqH+2QSeeREd+PZjXjW9JYJo05EFJylIdI1uW15ivwBS5Jd0u1q5HWqmyuN1DbjV6dt57Ihq109J+g8v+80HUFui7VXkUQJpL2YtSRHrM4wEZUruvv+MERfNbuUKFK+RnDNroUTa27H/OHZ7AxFkGwuJNPkndkwgqvn98rtlzuhxfNo+zpdr3ZvQRHbGP/NIlWS3zJoOrHat7dbfYJ+LM/m8b30u41KVi1G4xUFii3hIt1uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1jMaErMGjhugHhfUqPCgyyEWbUAzwQGQDOW8Wh/AYs=;
 b=aBehnc28W82rcEwZZsDU9t4Yshqgb+Vx5todSrNtNYaX2ndK89Sh29Jm5ZwKXTfLqLy0/YWrBzTQJYS1Xz7q45bxF7H1FofmXSHNGprfAkJLJnPqyfGyldJwOV5dbdyVoa1v9+mGU9TP3OEAKUfxIwS6q+a5Vei6mTTcNvvI68RHu6zh7dV7GfGzOT3GkQ2HxSEzSn6IVGqAapUe73IwG9ZFgr0Z54QNB31rmj6AJtMWypk0DKpkMsNydg/KrWJcFyOh7CYSUGYn9nPgkjgsWwhF+hMLg82Sz0rCBDIBvjnaf1FtgxCzClDaQpy/vjDg255lACIDVmSSEeiLfJ9idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1jMaErMGjhugHhfUqPCgyyEWbUAzwQGQDOW8Wh/AYs=;
 b=2PpqqilTVqJZ3F9NzntjQ61SnTJ9ut3M8TnGw5TfidaJsqyAthHpF5Vg4SGiqW4kOdYc8Ina0qK6yyqADZS19Gr1n+y+JTmOY1AX8MxXdS5hckM2PiMpPQSQqM7kd5j1Kwr7QTV7Q3Wb4nVSTEE1DOAVKGa5WUF98ONnV3MBV+0=
Received: from CYZPR10CA0018.namprd10.prod.outlook.com (2603:10b6:930:8a::29)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:37 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::f7) by CYZPR10CA0018.outlook.office365.com
 (2603:10b6:930:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 49/53] drm/amdgpu/gfx12: use rlc safe mode for soft recovery
Date: Thu, 25 Jul 2024 11:00:51 -0400
Message-ID: <20240725150055.1991893-50-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: bac8174d-c7ae-4452-7486-08dcacbaaec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XnGNbXs7i/aKZY65/a3TvrRw9SJ2Le+X9JtEGVLHIzurf04saNwoLm1rEz+Y?=
 =?us-ascii?Q?ICtTEaKPt02UzEIhx2gT73Ae7sTVZx2lnhHuMMR7IC8+tqNMbv5WOVnMCwac?=
 =?us-ascii?Q?qQE04awQ11GbmwRfUKk2AY1rcLLR0W+J4tnHZg5Jmdw7zbt54wcWO1Q+WxGV?=
 =?us-ascii?Q?ZfP0Nl6BimRFeIRhM4ky3/8p/7AIFUAtmPRV6dMP/IaZi51cO2Enrf7uwmeb?=
 =?us-ascii?Q?xQJnRJcl8TudW2d5+ad2MLLFTn9SfFyQBPq4FvexxCeo03YOFO/n740TqbpB?=
 =?us-ascii?Q?91JdDyYFH3JmpjVExYTdTMN1IThfTjLMvNCgHvYYiDME00oSan5GK4keFu08?=
 =?us-ascii?Q?jOUV845Xpz6aPU3dIYsqk93FHJxpl6oo8uPyiGNqzVUIKo1QlFZxNpyeGj0C?=
 =?us-ascii?Q?GHcqTmymtcSq4NCCz9q0xOWHnxN7osY9sI/jOk/0NVSUC40C0Lx86SdhyunZ?=
 =?us-ascii?Q?WnGoQfii9BaO2ak0hGQ2GSmfK/ys1kGPmXy9SYjHCwndgJoZHw6fgS1ZH7ge?=
 =?us-ascii?Q?kHOIOCvqk10E5E8YCSxXAZY0L5BmjmDXEPl1l9DkOIHc+p1hOb/GEMe9XROi?=
 =?us-ascii?Q?ixv+kYstqCyLxHvL7hDDPCZnpIwxiK1z/j1OGeUfiuX3RBzzL5EFiSPzg9zc?=
 =?us-ascii?Q?4aeK9nVcXJB6m5qTgv/KjrpUI0E+i+BhWtDFVOxjGvLQ5phGbzCCHeBUQ3fF?=
 =?us-ascii?Q?D8w9gjWbxl5pctKIgqk92l5ugvswWaOBlxN5sD9sGSnfAqNclJYVZQ5y9lO9?=
 =?us-ascii?Q?CKpjC2MZOy0KuY7bmpItSHFb98Z4oUOmkx04oSVyerm7GobraUJAj7Lhh+q6?=
 =?us-ascii?Q?jj07M8MKzYCBTsqJde1CQoPgZjyq1E389QEzsxZZ+MY56RkmHSfHN1JZ18Ex?=
 =?us-ascii?Q?QOQElVCfTwiP6Qu2zI+WKYHDfVOJ4lGTDNukURBeqDvlScirxFplnPM/Myfj?=
 =?us-ascii?Q?PZGCtz7NOwcM36N9tnZniye7pXKtBUoq3VK/1p6Ky/9U9aFY2FgUv+MO+ltC?=
 =?us-ascii?Q?ixPzzMNvc3W1sGFg99GRuTqpafeFiAbziel9FnQxLJ63Id8+VBCKIEMgP6gu?=
 =?us-ascii?Q?Dt3JLBSGVA0W1aD1BCC+qNTBSlmACg3ANDbs6aVAIZBgaYjs0Cf6mgIxjDTw?=
 =?us-ascii?Q?Xz7du6TMhXloGcP7mZDB6OQ2qp2gUMVSCTxF9NIfUa8emgL7yoOqs/jLJBE6?=
 =?us-ascii?Q?wB4X4USzlyS4JgZY2xisH9LA2czMmjqI+0hmA8YlwsULnY7cXNgsDQc9o8/6?=
 =?us-ascii?Q?blSrPDGMKpVeMlf2w6qlr3yKREEPj9LhkjQcP6i3JT2HdV74AcHQ7IYc2Chu?=
 =?us-ascii?Q?8lZzbvZlUSAcRIjt5T0DOLoYgMJyV7FYihBlYNAlEEbQMT4rnGZkk8Gbqc42?=
 =?us-ascii?Q?qzA6KIS4aLH/5CwFFif3BkGK8n+ZvSuK5Gh6JoVjXT7vtO4cE6hcB615uO6r?=
 =?us-ascii?Q?LmtsgN842xzx3JImT3CZyIEF7MCM/w+5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:37.4185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac8174d-c7ae-4452-7486-08dcacbaaec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

Protect the MMIO access with safe mode.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 4984df3a0b75..89262bb2258d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4615,7 +4615,9 @@ static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, regSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.45.2

