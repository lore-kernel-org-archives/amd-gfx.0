Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3FECA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 06:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DABB10E2D7;
	Tue, 26 Aug 2025 06:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u6WkC2FK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8412010E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIl1PfGy5egsmUxAL0sSMK77m3PdCD1jYaR1qom4cMnOVie3s7qf94l47wBxILuD3Cpxw6Bp42bhFARUHWCjOGIciT9EIue/ytFwP/TEoEoW72+/kgAVz5Mz0M2951YW9O3olbj3s7JPQJsGSEkfUdCa2GWcN0c7YKwXjuoLUMwUnkrYoNnJAeMyk6KXEmraYChDBOhVFgWa+oAq9XwJqzy6kKFmYltOoSEHVQ+jAgt9q5AEB2ExilTslCeTAywREiTCRtZY58sgK+Iv9wUxQQIH7tdq9qv7uXR56edLIRmJ9jISq1LucMsVV/bIAaaYqaOT6blbVY/vu8g7t72Igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW5jKTtb+2E4XB/ek0q5x73VsRVfz+ZDi+mtJyApFHE=;
 b=wvrDzd+BF5udBSkIyx17D88iSBtPTU6+vTHFFJwrTEaiRl1P+tJ44+Qet9ZAeP09VTTW+KZlanPk4Qh17/7BfDMTfAODFPdYlfLmoLbBb9QZjNGd2V8l23qtBkFuZLsO8InGXPVmgOoXKjuSvrOdP6bKzjMANbqs3tf4PTR9tkrXD30S8fSV8L2Dkkg0yKj7qPQLtnb94gC6iRMg8kuH866wXKq5RyCmOMt9VMBH4+IefKudNe5O9sY5ud17K2auRL+5HeOC8l7z/2DU1HcTw/vWzQp+28Kp1ncCZDnjn9j2AJz/1tkwHfhG5DGj/QEuYCcKS2rWAY3yIHxz8yGXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW5jKTtb+2E4XB/ek0q5x73VsRVfz+ZDi+mtJyApFHE=;
 b=u6WkC2FKcUnz23P4TB7kCo0hMxCIVoAcPMVt5EL61ElErQbKU8XcDGCKbS5tyda7YICPoC5l00c81HKYhqOpxCouxRwWBvoDoQrWdX2oRfHBpFE9ZK7uvaV3IzLo5QIN8S5jZunqJomYrBs4svk7pLIYNPK0kGwkA5TZzu/J7oA=
Received: from BN1PR12CA0027.namprd12.prod.outlook.com (2603:10b6:408:e1::32)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 06:17:40 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::21) by BN1PR12CA0027.outlook.office365.com
 (2603:10b6:408:e1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 06:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 06:17:40 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 01:17:38 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Stanley.Yang@amd.com>,
 <Tao.Zhou1@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Avoid jpeg v5.0.1 poison irq call trace on
 sriov guest
Date: Tue, 26 Aug 2025 14:17:16 +0800
Message-ID: <20250826061716.2350635-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a71f48b-7e9b-45e4-e928-08dde46842ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ooJ5kihIcWmx10h0MsaX5nfJdYww79oZj1YySE4l1428nTH7MyFJGz8oABZl?=
 =?us-ascii?Q?zVwzRwbnFkyU9u8i/r9SFVEhJeOOfCdK9g3N0FnPrVO7LErIIl29V3xqVK45?=
 =?us-ascii?Q?+8wHfUtWH+wMNcj/gH2JjeCTU2eTYYIsRTzGxEVlj73Rg/WLs76ntDWB06AT?=
 =?us-ascii?Q?BzQWoFk3WVHSbxi4HWlb24MVCsvsoJWha0LW1ePk4AmBfwMQIKByEbPRYMPL?=
 =?us-ascii?Q?9kmN86+T00N8IYmBV8JtcbDu7MvOm/jDOrFzkTAIyARJpp0OBNu6s9HuwuAr?=
 =?us-ascii?Q?8VO5eez62Gniy/H5zedr720zIK4/QY+R3y1BjKvKZkhyz4pDbbSCE10nl2xO?=
 =?us-ascii?Q?zdEEN7ZJmlabCUbPdu0mJhcc9VTTQwLiJ8jJQ+Z4AsMvTRgYmmeCWiJicjzx?=
 =?us-ascii?Q?r4zqF9o5AJzEgAfItSebsOOyO428BVH81nwJQ5/2BnjUyHrWdETIf4SjjU+t?=
 =?us-ascii?Q?pH0yDV04j7ch1xUa24LuqTCulLXn52pefVb7DPVkef8kltsNs0R/h2963spK?=
 =?us-ascii?Q?zTtq3ZQU9Leg9SIruPjasGuFhdnu59zqCF90Be1ee2XEmMT8mHqQdj8prjzR?=
 =?us-ascii?Q?j79S7WmxDTxC9fVE7LjK8P1IsehKXE0NB43MdruWH5IWZ74gPW76c9C/S3zH?=
 =?us-ascii?Q?tFNHbAsw+/wGK15p7vr5Lccl+ud3Q7CHpO4KO65s04ouq8eqLB2/K1ICG4AG?=
 =?us-ascii?Q?GZ4SWzFchKh+ceStVEmSWZUGkiCjjr2w/0aTjArfbiZOuFoXJfL8Vqjw4gE0?=
 =?us-ascii?Q?6IzuM8jwi6pugnOQVrLRxFNDDMPhF+Igp5cPF+MQb914C0jihkJkia0tGyu0?=
 =?us-ascii?Q?sPMymHsPemA//b8trVv1sYAo+sprf/9VjiY373botYvqAfJ1giQL/pRPixS5?=
 =?us-ascii?Q?B1lRRGWv1Fz+38jBuY3tLgjibZb6rQWvsfUpbcQ5oxaNXg0Bak9MzfMfw5C4?=
 =?us-ascii?Q?0+9wHLTXbAKdLKXBsA5w86G1Sh6DLXM1X8c2prMNxvl3JOCSeYJxj2yWFhuM?=
 =?us-ascii?Q?ntuVGmakSCqSPVOdYk/EVlrWfTSAsj6Kj1nSssjwvhhpqubvUWGzs3FdZko/?=
 =?us-ascii?Q?25Q0p0kqoNHnxrHybCjYUgPUpnjtnAXipdwpvzjzZE4VDaCtTRtIAPQGua76?=
 =?us-ascii?Q?1HSJdf8csY4XlHKkTboLMtSM4fbqQZfzDMFD5HS1ogNSNh2HQxRqBWJmmW9B?=
 =?us-ascii?Q?nmvkradm85igXI5Za7ZOaAwJ22rtYaVhjseph6sveRCfF0u7LP+Vg9ikZyVI?=
 =?us-ascii?Q?szjI0Do+2x52wQBt4tWrbMot3s6zTuEYsSqdOS+/2fxUb88E/AnkkfEz7ZqB?=
 =?us-ascii?Q?vWpaIZpxhPINyS5p6OVGnf/xKKJ1dE+O2KJL/+FPsIXbb3BMQFik/+mj+FXQ?=
 =?us-ascii?Q?cVC8EU4Cv7zaBUrbTg27NsdSuyB8SDFAz/R8WnCxXAB2iWQuKzmmFWKMHdB5?=
 =?us-ascii?Q?nTUe5/IxoBteUEW1gqP4LPD5URDPNm8topho1tsY2veb817oG0f32sdwghNb?=
 =?us-ascii?Q?eTuuy4N9ohNeqlmSEXk8tF3YAt3t+94pxk6k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 06:17:40.6738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a71f48b-7e9b-45e4-e928-08dde46842ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1
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

Sriov guest side doesn't init ras feature hence the poison irq shouldn't
be put during hw fini

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index a2d781898767..47bde62b3909 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -315,7 +315,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 			ret = jpeg_v5_0_1_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG) && !amdgpu_sriov_vf(adev))
 		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
 
 	return ret;
-- 
2.34.1

