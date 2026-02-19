Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3C5E9A04A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE2010E6FF;
	Thu, 19 Feb 2026 16:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oxLG8LbA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE9710E700
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVUPmwv/89If4iquSM0IURZu/yZUzz/RWRLkoj92rFk1LUC37Qb2kpM3dgdE7BGapc7AJv7J6xPhp4yz18F5Iwf6btQ7ldKbdGePeVAxjTyGHw8AMT2XAKJwRTURQh4gkaFqYVvLum10T2XC1YM5RszSktHhc3F1QxDCNkXzoT4GVvpMQIQtMLRa/W56pLk4V7AI2ReDMNsHpH6VHQqLwjNY+C21ls2ndjapfVgqjbQDyShCwUVmvn4KxvA3eXhNdUlh0zKem+qIrwcByL0JNQv6ZrI1yWQNjIOJPw2kZmKIf76LyqWUGYHq0Hzu3Xsy/YSFIqoSAbSCdpWzPFkfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT6QpaIdA9zR5mALbtjcVD8IjQ5FjjhnPvsQi49a5+Q=;
 b=xlq2ANGFpxFc8Nbo2EjuWSjBfUzai/f/UPf8IKUdx856JT1xNn/t7+F0dXAR7MPNuPWIVEzV3WqDV7S5rgvaH5fNnM0I3qsdmvAWseRPm7hNfREUwSgSX8/2lKoRv0rywKAOsUoE++JuCz3g2yWD8O7jvrgyZ6twzvzEVwEV+qlVP0nPCaqwWGawlQj11Af7UmZ7MvyeO0IwmG/tfnG8/LdF6c2PNF9B0mT5XFMF5U2pMhtkV2QFCG4YrRD6LdIr6LTud8J3FuFtEKXgZ0Y9XCxtrQscu66RsMPRlrULgb0h7SqmM6zjMood9DAv8WfxaySOj5L4Ea7Z9KHKZM3ndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT6QpaIdA9zR5mALbtjcVD8IjQ5FjjhnPvsQi49a5+Q=;
 b=oxLG8LbAcMtLsd5Mju8LISPcLDvkXV6PxSHpnZ41GNumS93gTnqrOgtXRq/2sXZPrsq89ek+HhyEHeXSQGWsCztIYJlb0NFl8MHphNwKwtOSEU1ziU8yd22950NkUt2fFuIZHn3LQ8aTTFj45rfQtEE+0nb07VgDlCArCK/olQY=
Received: from BL1P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::7)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 16:03:01 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::52) by BL1P221CA0042.outlook.office365.com
 (2603:10b6:208:5b5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 16:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 16:02:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:40 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 10:02:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/sdma7.1: adjust SDMA limits
Date: Thu, 19 Feb 2026 11:02:24 -0500
Message-ID: <20260219160224.1976043-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219160224.1976043-1-alexander.deucher@amd.com>
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad3815a-b851-47af-9951-08de6fd05a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZTNmqJYsAJLd+wYtKSB0aNndmA2fVz+3IegNUONX8bFU+ke5YZHIJmoqiPZc?=
 =?us-ascii?Q?sL3BtcHlgB744EJh6UGqOWy4KhIsG9Zdw2ke4DDXt6m8wRlsqZa2YhyJDERJ?=
 =?us-ascii?Q?MMwgGTw3Zpo4AqHc0aXZZnYVSCa5SZqUuKUB6ZybqnLbk/bxevsYYvHgOjuW?=
 =?us-ascii?Q?jHXrO/tGGpljhaNXt1uRFTEjrjuYoPc/9N0bDh+qvBnTW7fWV0tFxPWWMGGK?=
 =?us-ascii?Q?L7+7pVYNH20xjRrmaUynl2BBpP7CqKFyLCxBc1/qZe9K4YoIbsOy0bU8mifW?=
 =?us-ascii?Q?nWrf9nfE5ESUcAjEyzRLEM4XIEuzzdfA1x5aTTYSVLbssTqM/IZ3cUhaV0+b?=
 =?us-ascii?Q?KLa54/I2r74trDq/7ZMFnwWbYHgnExotSCh9S4L1i5XeBZaBSiMgrX0s5uJw?=
 =?us-ascii?Q?tiXIHnx7rBgrlA7y23rhTgl1GK49iNxl07cXpsjz8ITh++hdhJ5zS31K6sgK?=
 =?us-ascii?Q?hfSjYna1DKx1yz7tGyNXF09vX/hPXskyCBG2UaGLltzLDeaf9YHUREaFf9O9?=
 =?us-ascii?Q?B1jsolt+JNZ6arLpegvBWZ4/YqUmB81cuuG+98wPEdgve3M22LuHMaOTFO5E?=
 =?us-ascii?Q?VmkHreuM0gFreOKCaJcnwXa1nFlWHEDyztLKDkkTwH3Y4qVVo9mEkxN/463C?=
 =?us-ascii?Q?NjgLZh5Q0i/+Ty37jYXtF9o2oO2q6tm58wa/dxvdsb2pb6YjLoIKSxX0pDmt?=
 =?us-ascii?Q?yl1rGjT4fBuNFq7015cnXUYI5cSuUhIaF7z3ooZzM0NpMB3O+sNZtriPnR/I?=
 =?us-ascii?Q?1uIlBzp9vYwhafe6T7GrFjd4kj58hdLiYQifTGtzkGgCqHEXZzZiiaSEVeAt?=
 =?us-ascii?Q?ZcvkI/11eb+ptwOrYw1rG/oIqH7fmTEvq9dMEQOnTeblA/96vNkytGr+PGMM?=
 =?us-ascii?Q?9CK9URzSmCrBqiIwH4mASeqZ/HKznBnQiOR5GlDyfLY5balxDmVJ2D2mkCX6?=
 =?us-ascii?Q?j4MTm8iadx2rttI9KEagYaxU306wmTnh1h0TKwHiCJ8am9WIYbckmm4lLFsg?=
 =?us-ascii?Q?8ozoyoWa6Nc4ydde2BA9n3VFKxrsvtN2r5jcYyLuVureYSQ9KNCd91cKcc3I?=
 =?us-ascii?Q?M62D/8yY3pdp9aDsRly92eWT52yRYTwKygbuXl0bkAwU7NnEZxninHcgj1/I?=
 =?us-ascii?Q?FJZirJHlmdHbVC6SHfdClX7f2vowdxYO1jR+HtsLB1u/xo2jz4i0vy+RhzAR?=
 =?us-ascii?Q?W6rho4KxIuGL/Udj+gKDSAe1NlESaYBviVmOV56MC8KjA1ZP3RzKH6PH62ve?=
 =?us-ascii?Q?yII8wcJtwnr1l61TCjeUCOaSuJabQogtuWlnlv2HWYd5PghkbtM99uJAvH+D?=
 =?us-ascii?Q?DafWI/eq03nt/1L5xEe8VndMXspM5FGeNuyqeidUzFQngvcL/1t20U76MyZ1?=
 =?us-ascii?Q?4+EmUa/PQmDl4pd9zoggCi59qgWlaC9+g6VBgty/Gah3Mx37MDmUHPFkzupa?=
 =?us-ascii?Q?7XGOjpvRFPy1Z7EzeHVutbg53Hme/m2gU8QUuQ9mmgmNevb3LuZlWukKNhfY?=
 =?us-ascii?Q?meyJh+rJxeWA7bQm17CYziAz+1jXoxVQYTwTwG71hDK3/ZcAQ3LNSiYu8YUP?=
 =?us-ascii?Q?OYQX0xvfrSeGsDlba1izBoYAJ5jHF24jAl7trwvsUHIByTusjTryKHPVLdDS?=
 =?us-ascii?Q?g3ZVcL6nSjhaBH5B5OKDuOuWhqbLR2BPIwZRce8vM3nH7Bqe47kBUqnKJr5d?=
 =?us-ascii?Q?uXdwWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J6E8cue7/Rhiiuwlbh85UII6VmqWEH5Cmgg9nw4OpT/ulBAS+aeYh0cNWPZFKHT/4RjIfWb+uzFU3/KuPVO46b18JHqR42LzCe6YbfvDCO8oU18ak3/tJaU8lsYigSIr8e2gYQX0wB2b8lwgSFg60K4ueSc/p4bH/kmOQn/w79pdYpdyjatM6pRegWvIyiLR7UrIofkEELP2gxTu+CHlOFyVfR5rdGbzXQ5OAOVMWJbNTdaSj2gRunR1DQFNpA+1J5jLtAI3yyrIdcsjuZ0xYf/YofMZAfd3WfJSxryZE4/TDMCZaxzjgS2BVlum0OXOTlpngT6wCcFyk4wHMgeX3flQkDVU21LphpV8VmAhGj3+mPAAgVwilr5whDNzETFLlGoeo1fFU6jqwGZBGcTsHLZz7UqwNJq47Jp6xWS7QWya9Dx78siSnBh1oEAopwHC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:02:59.5607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad3815a-b851-47af-9951-08de6fd05a89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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

SDMA 7.1 has increased transfer limits.

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 3de76afe3e454..03bf1f86098f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1745,10 +1745,10 @@ static void sdma_v7_1_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v7_1_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 8,
 	.emit_copy_buffer = sdma_v7_1_emit_copy_buffer,
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_1_emit_fill_buffer,
 };
-- 
2.53.0

