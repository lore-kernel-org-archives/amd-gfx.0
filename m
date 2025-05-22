Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA78C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF1210E70A;
	Thu, 22 May 2025 21:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M0CRslhP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF36E10E144
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nq7xvTUZ8wxeDPQL7UHiIQLgXNh9UB2pVBVf5YqmUGd8DfMcRsA/SFn1tTmuVEIk5KfOOX+0wJetIgjQb3RPw+Mu5QYDaMtsEXIRt9SVLHNRR7BYFWAC2W6Z1S6jTK/pSOFpsF5TjEgu6MoAkLLADP8OMY/VLV69+UZP5cA5i1L0of7zs1Fpt/UpcxlhQrTrWiTVzPurimZFLZzHrIG1SmK5RIL2CwOLDqEMivxQUHZebZ6mCQW/rekJMd3aNFYQ+UlXrM7YpIiZzSv9VLB/vJmsAdufgIcXeqlHQccyKQwzMFMegYTTXDJEskj2rtpRem2OQ/4/71/S2ECWmjK0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caVpBILAhv/I38guE4/VNe42JbcEWtSCbAmr9luQ4Ag=;
 b=LWY80wVJlCQxAP7k8odOSv/go1nYT0HHAZCVf+44E3vQpq/8PpCrjTx5CVDrDUVErIr0SZkrpeuivgTC1woK9tgJsZsVHOikF3rrGBNf5ScOkjKXAhua/G2rXLXTueOPlFsu909nESmGiwSGAhrr9xZBemFp9OQtseRCWJbj8AFyrLk9Xq/YwnJzyAO6VQl6ez8364VP5CTSsz+b2rEYVTN8IboQn6HS6ltQ8clu+YRKo85BMJVoL8+F0Lu88AU0mgrf2NbqEHAHf9FPKswQVe+4bbzw4oasCd+0nZ1Ld//p+0gSA6XfrYc60GTTWIDr7XuXBvqiikuQtsimmBoBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caVpBILAhv/I38guE4/VNe42JbcEWtSCbAmr9luQ4Ag=;
 b=M0CRslhPAr13Thh0xGYdixH+p0/ETuPlrynejuzayZ4qx4AYtA0imRo9Pg0J8qswiqTkI0DVjzGM/ldPV1YHFMMedUyBzHhHJeMpn1ZYXQw68BPE2nIe8T6caVfMULShoaF/COE88i2q7R8f8zquKN2srHTP3y4l6Ub3KmaLX7k=
Received: from MN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:208:530::7)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Thu, 22 May 2025 21:56:19 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::2d) by MN0PR02CA0026.outlook.office365.com
 (2603:10b6:208:530::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/gfx12: drop soft recovery
Date: Thu, 22 May 2025 17:55:57 -0400
Message-ID: <20250522215559.14677-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: deb7d806-1f3c-4ec9-672f-08dd997b7ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zuCiowm6tLTmk99IgTrL88euE/6ZlP9OaOHLjWioR5qxjN51HEBfkri6TofM?=
 =?us-ascii?Q?OlE0Yaxc7WI70f7L47kJDe+StqtZqbIZpcNZFRX9oYtG2HlqCOETa7YCkDbq?=
 =?us-ascii?Q?+vgWjAnV02TNbjE7wJpbepaDrqCsgjh2lDlXEcnTswlgTjL5l6ahkvUjfbgD?=
 =?us-ascii?Q?5t5RkR+HWdUJvMpWyMiddx59tQsyAfNwrFR217S4c1oVpvfWhF5onYSBu9uW?=
 =?us-ascii?Q?GVcJcXafjpQibJZg9aT4avYr2Z6mBXTChMVl0+ZHQCiCr95KemZgM0XEoaCG?=
 =?us-ascii?Q?pBY8TXyBaA2vg1pO3QVWcuqDpPE8taJoByhzSrgHCrCRJmfz4A8BPbkYGeiS?=
 =?us-ascii?Q?BwKdN01O07dgTerWRokBm/WGJMR3N7nI3df9izhxNzXWBSESMPQXRv9em7d1?=
 =?us-ascii?Q?FWAnwc/19diOR2mrwibajGA/HtcqaAxr23P9xO20sOl0CilNIzQDG8fPT3Ah?=
 =?us-ascii?Q?OrNvyd8t8LEudzOJKPYoHYbYhh3kvnng12gNsldDVDDeuNu6s+dMIs7e2oGh?=
 =?us-ascii?Q?e5PC/E6wiTxfbfCmIA9PeAaCEj6OGzNUWKqF5x+twmS1JQt9aVnu8/4QQTar?=
 =?us-ascii?Q?gEd2ojcjxNTqvk+4K8pSV10PYLd63uBWCmFGrA8Z8QWM0vuYYcbauI9EwtC0?=
 =?us-ascii?Q?ESRgrbko2/w9smQbboT7zvHEcASaAAh/dOQPiWZZHq8m1raz+96JgPXsXd1g?=
 =?us-ascii?Q?5Mkcx4A1Y4nkGLXMfSA5bS2LiLILl0+eEurvXRkzNwIjH6ymwjjyfT5t8UWk?=
 =?us-ascii?Q?KT/6Xu2f0GI3Yqtf3wofTmWCcPW0PGR3CQ57k1XJ8RCSOP+crJ1KFR9wOg5z?=
 =?us-ascii?Q?4zVPYcCGDqR2hRaV492aMfU6KECwdYXgAaMNmic9LPRtVoEf+km9nF+wjwrC?=
 =?us-ascii?Q?/06BgbIXYCWTOiqld0R4dAJFv03/WSvxfNVhtxpnztvfmg/lkkd6vRDAMQgi?=
 =?us-ascii?Q?rTnO9ctGEAYAl8e1++Im/zLbfdInQWluO/blFgbQwEvDHF8ieXW/w9xzKW/K?=
 =?us-ascii?Q?DkF5qRPvPSLHnVO18TC9bR+CQQasl7XdSQ8U6g4KeRhanypO8F4n9xtVHxDd?=
 =?us-ascii?Q?C2Za4OrPifTD0tgH2wGHDyZ3hFOs9yGNfh08IiOzlIpbcldVZLF/8mn/laTa?=
 =?us-ascii?Q?KzZ2PTjQL3C1CvNnfqZWNhDyHbxkCUxtDcoCU4br5xasoBp//Bt7/X6sw/xS?=
 =?us-ascii?Q?hvjUYW2k/5UkSI4/cUROVdbaGpmLDnymZiKrmZ0ooifBMyDkugsQc4m7/EnL?=
 =?us-ascii?Q?A72kfkt81BGlFbwrY5ZEJJ4zhYRdwyfjRtkss8lL1u9a/9y+XcsxocQJhBrb?=
 =?us-ascii?Q?t7b1wc7+Wgv8BnpZk5vqTJlFMQN3P+hrRWoJG/vjKfy/k6DpxXHmHy0UKjUI?=
 =?us-ascii?Q?CSPdWmi2sqGZc+gRLSMGpInup3TLR2FOdZEg++rzya5q10YHjdkF/6p/5rod?=
 =?us-ascii?Q?S4yh4eRhEg0FSpNQbktkTU/zxYuTai9FfpvwqomtaoAf7jkzaS/K17RJ0l+X?=
 =?us-ascii?Q?lMjwcckmaCIGgQmgqd2L9/Rf6F9c3VyTlyBs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:19.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb7d806-1f3c-4ec9-672f-08dd997b7ba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

Drop wave vmid kill in favor of queue resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index c52669fb987b1..a89702f9fdd66 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4692,21 +4692,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v12_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -5528,7 +5513,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5567,7 +5551,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

