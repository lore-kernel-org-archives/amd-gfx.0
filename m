Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B3BCCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 10:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3EC10E0F5;
	Thu, 30 Apr 2026 10:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QqEAwXKA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C64610E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 10:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/MIeC7fRDYY2qTW1t/WMUUMdd6HEx3Dg7SHS4rrr3VY/wuvJNYK9ScDZMTbQ4YjsESebrJS1V6H5Eyc9CWxIdTke0kV6mUxpc6ZAZ8WksjLd6HtbPTsJ/VdJ8yn0UuBVK90nKKADqYat9EUf9QNpo7ygtqbqZObs2rmYNCNr2HtPO3hsGHsuCh1Hvi3GoQ051MgqpCHUAuKKrT1tbMhGPudIYnh95jz4/sTLTpo+PaK8cBe0l9JnassK+7QS4PZq1l2rtetusUM5kCb/qugVKQy0Heb2R11PNfl5rtABRBBF7Y+5h5Gaiiog/J21/vMg7bQgvxkHbUT/a2Bxi2AIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc7UhW0G6gHVOWqpBYFseuD/Q8Z28YyYp4iWbdxfzN0=;
 b=CUJNNQ4e1+nZn2cOAIFctPUiVhJGmRp2DzaTw/2rBB5v9aC7HFKq0mh8oeTW8gWgJ5CqO7gZlONyOWLki65rpqZB0E2LnyQRk5Uuhh3Vc9aOQOdqt4im8vtWOF3VMsUC5g/CUIsJnD2xu9AbKyoZqBskZdp/p2Owp/9WniYRr6q+2ZoWeO9Yus0TC2jPSXM+FKuwWuMr7qaffxwmgxxueUbmRsP2Ht9VTBlAh6cNxa4xKIKhkm103nfN9JpL587NmebbljmMdj6Qlg/qFhTVdzwERa2DybeCULOQG8LLl4vBjwH43n1/pND532bhvWkLOBy7XTtIfPtTzI02dWNmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc7UhW0G6gHVOWqpBYFseuD/Q8Z28YyYp4iWbdxfzN0=;
 b=QqEAwXKAFuX+9/j4z2buCW8vj7LRTIpnoPhV6MGdYrqUb3IEepEzTnVN4IB0pYQ4kBZi3xUQqxDnWZDMF8rDld1DZ3O6ZC4nnMDG6xoI6p0YXotccGAsiyZqjmjW1T9MBNk30lgJJQCG4riv5/esJuB5lLh1KsUB7PA/+FPj3c4=
Received: from BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30)
 by LV0PR12MB999070.namprd12.prod.outlook.com (2603:10b6:408:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 10:21:13 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::81) by BYAPR07CA0053.outlook.office365.com
 (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 10:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 10:21:12 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 05:21:09 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Relax manual min/max clock check
Date: Thu, 30 Apr 2026 18:20:57 +0800
Message-ID: <20260430102057.4186555-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|LV0PR12MB999070:EE_
X-MS-Office365-Filtering-Correlation-Id: b078304b-1100-4edb-36e6-08dea6a23418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1UWhfNlX7uy4zXXN76GND1Sa5w/Yb7fS19Wb2JjRhFk0wy7oIMrVFO965TTcULDccjmxlik8pBkEZgG7eIrJjx4P93LPj9V0O7pTDWll59Kh2P21ef88B4pRD4lld2RCUxshd9LMNNagKKh8B4pKZXuOa0VJXwPYb/rc+OSII+oi6CuSXfyWFPQ1dQOeAo8dAdwqeDfuB+JV0iMvFhagI7k4GmB2pbqtUwwozPC/pWNVhJ7I9eg1N3g/a8sIHyPesqeycPX03Qum9vOSSbqnkKD4axAho6WCejFveDSXQbHPVvBDb2JxeLKjV9XeD8QqYQU0dIsdFVkdP9aS3tCJ7P6NXHFzDxTpE9ddLScZcQPplADgRIq7qEmk3eAP6FtuwfvlyJcZFYfeM9nIyIAAA8EeR8zLSChD1dj3PKhlZD2HhvJ/w6uyj9rmd4e0QyjZHEiOTVLTGJczg7CS0sshTBmkwApBF4jwBJuh+PlPlCKTtHOoo970r3n+RorytN1eALLDLUc+2fmdLWi4tF3dxFmlxMIHtaWH6nNsiG2l9iWKYqqf93Qy6UMeQcjfTDhGEzJPb+LYJ16nTovHcLBddhIx/75aAeNVSwecmrablE1h5zVpcHGu8/83XImPoJOPzpyRBP70FBv+C5SRQVbmfWqofgaydHxBPjyekf5T55mSpetWB1zzz3UXUi1su84py1C5eyk3ib1Rb0VP6eVYoChqmJyVdCjR05xau8uI64yN78CBSfqod/4/F2zUHbC7sndUKGTrGA2i7Adar5KmKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wAAnudOzitltUNfOmjXDDSjWYbtoK+bbITv2ibuj3tliIPt8UMOgfKKp7O0KxSmFON4qkiZ/lqSjtbRilro50FZxeiVlJhZo2XGpICW4R1gh41wysOdtOgg8SQbjXttnuHVVI32M62RNdVsFBH5wMvP9PXtKDyFmUY4fglZmR3/pFonaQqO3/O813GgEEG3NQTJILSq0GGINw+EufRCtYcB1C7ROLCk32OMRVsC3t1h48u8bc9pyVyaF6Q/fCoJaYjr85AlJacAK9TfrBJCQ8Oxp3HrrD07GE1eKgF/uJXYZWOs2dB2J2R8fDXv92vPCVCsNYxVi9OmmHeojwxQbhERD8/Aused27qT6e2O3+Xu41DbTUoQOX0Wdp4T0tjFTYvb8+rm8EpVU1fHrZ2otGxSnUVhkmqCiF+Wx3a16ZOue2LQZFZkWYpfAIJ2Bvf9N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:21:12.1003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b078304b-1100-4edb-36e6-08dea6a23418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999070
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

Allow min == max for the soft frequency limit when
AMD_DPM_FORCED_LEVEL_MANUAL is used on SMU v13.0.6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8d04f6e73fd7..ce520f43ab94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2075,9 +2075,9 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 		return -EINVAL;
 
 	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-		if (min >= max) {
+		if (min > max) {
 			dev_err(smu->adev->dev,
-				"Minimum clk should be less than the maximum allowed clock\n");
+				"Minimum clk should be less/equal to the maximum allowed clock\n");
 			return -EINVAL;
 		}
 
-- 
2.46.0

