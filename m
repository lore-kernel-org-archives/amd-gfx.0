Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FD0C83F12
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA87F10E523;
	Mon,  7 Jul 2025 19:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Om9vblvw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B4810E538
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZHQ9sgEKWXvEuQ9xBeUwMThFFA5kyqQ5N6ysjcH2r0JRt9QYGxvF/hwd6qFlEQ/ar2U0p/d5MkPK208GEf0NXKAwJ0zRKYdO3s+Nxs5K5LXd4bm5+w73gV/wVlJ9LFm/zdNQAJhtQ/CjMBJXnWPrn6CaQGU6KcXvcj4QZM0q/0QN5hVwR6ApA1bcfF3wg7qxcNDrG7MIKVp1nAK1lOiDkEv4YuulKMhMsts7RXHEvRB0QK4zQL52fWBWsCO1puKv3NmM7pcBbzj/3JP2Oggrwi076RP3nh8dw6H7pLps7nnFAwhqInsSZWRHmOB2n/RwnRdtN/4ho8SR29mX8lqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=N7YJCglhuoTFy5SJDCdjFQTx+/CMtUsMIYeMlCZn25zkU8gbkoWOLGCrWlYjMoSxqdaLZjI1pUaHNQBIcjkjHL7vhM+mRIfAgmZvOuUV7yBo405vNU/LDkcansuD+kI+NSXjh+Wu/6wEtgKCvMNs4bkkD3FX4Hvh7kipjiBlCTSs/ZN7o/4RKvRXs2LK81yZOfNLTDocWAxzqRJBX7d5jRy0LTBwkLPxmoF3NMwu2BNo+784CJ+YY7kkqYk9ZQKDByiawbcc/15BqNu9ki8FvF6It28eTRuxzcVoTRY68zHnrmDq1yDW2K4ZKAVVfCJRLivQmP5RbZeSZzPCJOXwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=Om9vblvwnO9dzOSwu72muF3W+DShuq2wUQplBOQfejaTmoPdtCgiv2Zo6l8pb1PngFpmGGH3m+PCvbkPsgIrioqqbTmD39C53jfMZpw0EkRgJdLZvK3AGIwnuBn1XMQ64b1LJtglHEVWWagOzTv5vsCQbE/fAU/RAW4MHPadDWE=
Received: from PH7P221CA0072.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::10)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 7 Jul
 2025 19:04:28 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::25) by PH7P221CA0072.outlook.office365.com
 (2603:10b6:510:328::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 25/36] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:44 -0400
Message-ID: <20250707190355.837891-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: dda3d344-f31a-4688-76b1-08ddbd89188a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oR98EOwY+yF3ynUu3Jn7b1cpyrr+dBeqjKqeNlmHByd6RIskjbZQQhwE8DHQ?=
 =?us-ascii?Q?h8VmKZQ+DCoxUqFXt0WqnItvH6uLTi5lVlBHmWGNegVMgU5DM/BUNZjsDd1R?=
 =?us-ascii?Q?5gcgG5oaAd9ZAH9JXJ9yVvFwraZkOFX8mLd00KC4/Pxq8ig3cAuUnknoAP5V?=
 =?us-ascii?Q?BsGRtzaZeVl85ToDkXYcCvEEhbakeo/NVfctFsMgCRMPNuJDygUwRVPWcSoY?=
 =?us-ascii?Q?NB+kd8iMMInYzfXGoVCm4yppwAsN8MLLfocePRh4ADmP1VsRM9DaSvx/dxMw?=
 =?us-ascii?Q?JEsf8T5CauWgRd0wIQDSTYXIBBrfLHFe6TuGM+z9V3SEmCjTnXJifdaVS+Fw?=
 =?us-ascii?Q?+fYAZ7DyfPfd51afsCuRuN0/Cd2RsgoPb1vwbBCozDA8ACGQvJis8rRByU34?=
 =?us-ascii?Q?O7LgOiEUrgjh9/8QoQn+2huv26CmdAyBivOs59WYD3v0X0k5wRGfzBDuPZNd?=
 =?us-ascii?Q?PcV0DzigRAlr3H/kivUJTqFtMXEodwO3EJvSdaqmH2wuxBIhFAwv/rlRD/Zr?=
 =?us-ascii?Q?2V1s1XI5NYgXs21IJ8h+9A3k/kurfWmV2njpd97LGYAtwCilnmIGjjqIOAg+?=
 =?us-ascii?Q?lJ586VBzmdBt2atFUuYXMAoSS9nNRbx6MLGw74ediJjSqgUc0IN6fByVz4o8?=
 =?us-ascii?Q?JfiW4aN2nFHi02eD14o6EpVk4hzk6zkDW5mjCMnHK3+vxcWXExx1SyICczZq?=
 =?us-ascii?Q?qgUo6TRvUOU1ibIdi8mA7GyYdYqutO2wToYdh8yekCmwVCEyENxJ2Rbv7jD9?=
 =?us-ascii?Q?oIMFD+6LyuaEERkCBiU1BUiLp2eKnCc5OIp65hiWtHKl7lKM5me75BAJK5If?=
 =?us-ascii?Q?Ss0WLcdnPNJKA1ejWI8KpefuSZNux3R6bgmhi+NO8q4asHQatlfI5W8T9eBh?=
 =?us-ascii?Q?Q2LkpDYQhWK80bo79EsADCY/P9esj9ujhGYErOFbnII4rui5Wqann8OntyJo?=
 =?us-ascii?Q?XYrOiYm9JIxPcHu/HIADYrV0kQAjAMrS+eV8UGaS7UNZh8SxYKsfv+OnwOrb?=
 =?us-ascii?Q?kOAxwdtRfYdZTo/yK0AzxtRKXLVld6N2LuGKlo1sJXd/KLzfLlhKuZR/W0RB?=
 =?us-ascii?Q?nnsJ2IYEx6rBK4h0GOf83QrKzDv7uKbp1Nl8Q4FccpagsAZGBDK8jHsOHzxp?=
 =?us-ascii?Q?fyFiaLapPUUim520ORzh9UzkuBCtXoMZRnucFTxnq8EkF4qypxVia9bVRJKM?=
 =?us-ascii?Q?bxAbe4Ek1n1iy4zBiHx0YCLqkP7DvU4dryBqUajgguGoCwJTU02ua2a3wzqX?=
 =?us-ascii?Q?WPumhQY0DS8HkakDh7s2F7SvUWvSOfshpfnTWKzEVu+3J6a31XcgcKNa32Lg?=
 =?us-ascii?Q?HKOwxNSD89Qj+lCAZQE7TTpWWgvS1IlFXNZmQ9ppSjYjOmhZnVxNGEM9eTi2?=
 =?us-ascii?Q?S5nXozMr1NYyyXHWu7Vsz8Bi1xe/fwpu7+XsbVhP139XLFp3WXks5l/bkO0L?=
 =?us-ascii?Q?347YeRx7rrgT1JDvtlI3RSHeoBQL39w3MiWMJAKyDGCMuugLUbhPQe3OrTQb?=
 =?us-ascii?Q?k24pqjURyh0chKhj2q4U7ozYZGFzJrkMlhqI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:27.5488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda3d344-f31a-4688-76b1-08ddbd89188a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 78441f8fce972..c3f73a2a911b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,20 +1147,13 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.50.0

