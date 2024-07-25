Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2691C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7006710E83F;
	Thu, 25 Jul 2024 15:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S7t4Cem7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34B810E83F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3zLyapF73VR/IuwGQOacg8wuiz1V+8OxK4ud1Muhk1CD0tr1fjTySxppPQNNLAzz3TraC6F2A7JT/Lc8+EM/Xqv74bWDwt/lyhrMpo/8RhI58JkF1j0NW4vC2mnGxGFRIL5HkYNx9HYAAYLztylJyjnzWTLb9RXDZlt5swU7jYcwJL9LHiePECAlpEbZZQRwuRZuU5o9YJNr16BiYuYqrdoD3EXOHhmvZR2OjAl9biWnhs/W3TlRkVJrK1rPUhBXbmYM3aRFItI8Del+6VSn8SQCD+H3oaBIXH3cabB9roIs0IOzLKV5yTxXDgJ4k3r6tav1z88oshDLvTKpGCckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdqJPbihdp+v8FXfE6Yxf0fKmjMZ6H1G/8QkBRYoz7c=;
 b=vFlJTzLhDMmce/uDz1cAcmJMrKRUyExBZ0wxeH1k6vi3A3KTJn5ypKvGjDVfN/drp+cSu7FbgpBUCQ6p88CyPZB0hTyPa72Bbs49hevRiX48iqLk+lZ9JGrA6bTYBn0Ak7n+f8Cu92uNdMSxI3s83gwRNu26c9D5urPNNgjnHibLlAoz2gBDRVVlEotdP5volgTqUSamWtVr1qK+7LrObDE6qzHqlr2t6Nq9ll2pHcdgmOL1UxvCrHtJ7hLDr3LprkSHi0JMqlFJcwW/rOOQ0wuO/Ubis5sEdf6uxkTCGmTwKeVNZFx/UyFi+UJfxhcR458Lndq27RKJUVc0LNg8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdqJPbihdp+v8FXfE6Yxf0fKmjMZ6H1G/8QkBRYoz7c=;
 b=S7t4Cem7sUB+L9T3PxmrrZ/goyq42LEYar/1J1fV1U5vVGKd+r1v798+5Agvx1ggrRaZM7awphWtfO6hWV9+dVSDajdyw4V3x+/d69a6cTutu8FbcrZV57xZPWU4PXaFg4HLqm9aFEotZQv4UpJJRUQiUDhvqfc3IKPjNKNv35I=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Thu, 25 Jul
 2024 15:01:11 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::18) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 00/53] GC per queue reset
Date: Thu, 25 Jul 2024 11:00:02 -0400
Message-ID: <20240725150055.1991893-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ece2ddb-4cd5-45fb-80de-08dcacba9ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FU9thIGo9aIwtn7LceI+7rAERAt3kdo3ml3pZdap+prfYqk46haHhEaVAnSf?=
 =?us-ascii?Q?jl6KAaAFI3u2L8CMVCW8ghUNnol3cDVic4B4ay9UMZVdPY3ZvYxv2Gg2SlWI?=
 =?us-ascii?Q?zicJzIxpcFVH6yy0lzZGtmx/lVKk4FEWZKvFeeUWZ2L+W+nvsHdtLn08I3LW?=
 =?us-ascii?Q?/WKihc/CyFxtMRCGcDyFC5HBTdDyNsA2zZQpUA3KR5TgUXuo1FJLwmJnAWvm?=
 =?us-ascii?Q?EhA0ouhXW5f/e57+uy37AiEhjpynUEbrJiIEKj/1h+Ylm/qA+KXiwQ9G23J0?=
 =?us-ascii?Q?3ryzrfmrBtPpwp9nMpodEGeHBqcy7DtJ2fmb/6Oz27EhjuHXJcwTwIPJslp6?=
 =?us-ascii?Q?CA+0G0bP6dbOzxfRfYLAH6kX98/TIPF7KlEua0Vh8VGgGGXjKPGULzetAPnj?=
 =?us-ascii?Q?m3wUwNzhHrAhaRFG9ub3dEci7WUJtRxRcOMN2it8mvfmg33zHJV7PvuJZ75J?=
 =?us-ascii?Q?rO5cF49l6DJj4fF+apAEN1GkiaORi1eOZfLF++izZjq0PaACIQJuR+8egRSL?=
 =?us-ascii?Q?3n8a5ym365a/5bFVB2kOipLJcKQ0SI553ImDIT5RvjLYM5caPNbImWy6VO3I?=
 =?us-ascii?Q?fRiX/Ejcd1neLHPVPTP38ip00/NDW8ggKGW0kKDoLNrnU9y75qt0ovxeuV4b?=
 =?us-ascii?Q?emnOSKcRMRLhAFsJX4OdkQMSEcbDkr9fRq1XqJ6G7s9mbI1ZVKHanWeHGiOp?=
 =?us-ascii?Q?b6iOyuadxT10Do4i2dqzQYKNiVr2a0j3TSqg0rHNxNMvCIO3x2eGoeme0Lua?=
 =?us-ascii?Q?lQFcsxTs/LfDp2Xu+zXj3ahTfb2gMzskdP+EywNOKmwQBBTM12WU+9doprp6?=
 =?us-ascii?Q?OHFeWqNXT2ROLqyxjHqscy//z4iTcw91KiUmjlnY6wEbqF9C578UCKwfLXZn?=
 =?us-ascii?Q?asRn/9UWCELFhh0uZfKyDo7GWXlwKtjiPZ4NaH6aaax5NPH8VKLDxii8YZOD?=
 =?us-ascii?Q?Fge5xiToUvyHqZxqDoasjRLUX4nNIxNH09U6IT3fGD1mNZnW5xmvuDlXHHnL?=
 =?us-ascii?Q?2gPz0gReMBSRls9VfxpuN7tx+wciUATrvFLQwvhfgRjIRA4SWnLhvKzjuwWL?=
 =?us-ascii?Q?2MA9+VDAsFGbPVd4WsVlCmXYkgmZs6wYwbNVSuQlsB43u4Gj8yRFvmfOnJu8?=
 =?us-ascii?Q?RUk/dBjfS6yc3/YRrqwImK9sAChyDYI5GTIVC3kc5DCJZ57W8dk6cqHsLeNw?=
 =?us-ascii?Q?9C0vwNZpHn8SplZSSh1qTumFLBHG4T0ZUZP5IupEfw/Exqf0aZwd0e7fQHVJ?=
 =?us-ascii?Q?v9YY1jvaYT8swxCTe77p7dgf2675Fq/JJ5/LEoQWjJfFhMuk2bxlF+wkufGR?=
 =?us-ascii?Q?s7Zrl37s6/A8RY6VnemKHHjMrWO38+Sez0rr6FoyN4bZMW4yIXUCN5ie1dqm?=
 =?us-ascii?Q?FRNsrHs/LhYQpVJ3nz0JnjF+QsH8telOuxqT9yseq5JWut5JiWmV3wrnnsUv?=
 =?us-ascii?Q?/GFv3pHpZcoRDrYEw+5dMDrOZ0P+gl1Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:10.6024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ece2ddb-4cd5-45fb-80de-08dcacba9ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

This adds preliminary support for GC per queue reset.  In this
case, only the jobs currently in the queue are lost.  If this
fails, we fall back to a full adapter reset.

V2: Fix fallbacks to full adapter reset
    RLC safemode cleanup
    Preliminary support for older GPUs

Alex Deucher (38):
  drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap
  drm/amdgpu/mes11: handle second gfx pipe
  drm/amdgpu/mes: add API for legacy queue reset
  drm/amdgpu/mes11: add API for legacy queue reset
  drm/amdgpu/mes12: add API for legacy queue reset
  drm/amdgpu/mes: add API for user queue reset
  drm/amdgpu/mes11: add API for user queue reset
  drm/amdgpu/mes12: add API for user queue reset
  drm/amdgpu: add new ring reset callback
  drm/amdgpu: add per ring reset support (v5)
  drm/amdgpu/gfx11: add ring reset callbacks
  drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
  drm/amdgpu/gfx10: add ring reset callbacks
  drm/amdgpu/gfx10: rework reset sequence
  drm/amdgpu/gfx9: add ring reset callback
  drm/amdgpu/gfx9.4.3: add ring reset callback
  drm/amdgpu/gfx12: add ring reset callbacks
  drm/amdgpu/gfx12: fallback to driver reset compute queue directly
  drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
  drm/amdgpu/gfx11: add a mutex for the gfx semaphore
  drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
  drm/amdgpu/gfx9: per queue reset only on bare metal
  drm/amdgpu/gfx10: per queue reset only on bare metal
  drm/amdgpu/gfx11: per queue reset only on bare metal
  drm/amdgpu/gfx12: per queue reset only on bare metal
  drm/amdgpu/gfx9: add ring reset callback for gfx
  drm/amdgpu/gfx8: add ring reset callback for gfx
  drm/amdgpu/gfx7: add ring reset callback for gfx
  drm/amdgpu/gfx9: use proper rlc safe mode helpers
  drm/amdgpu/gfx9.4.3: use proper rlc safe mode helpers
  drm/amdgpu/gfx10: use proper rlc safe mode helpers
  drm/amdgpu/gfx11: use proper rlc safe mode helpers
  drm/amdgpu/gfx12: use proper rlc safe mode helpers
  drm/amdgpu/gfx12: use rlc safe mode for soft recovery
  drm/amdgpu/gfx11: use rlc safe mode for soft recovery
  drm/amdgpu/gfx10: use rlc safe mode for soft recovery
  drm/amdgpu/gfx9.4.3: use rlc safe mode for soft recovery
  drm/amdgpu/gfx9: use rlc safe mode for soft recovery

Jiadong Zhu (13):
  drm/amdgpu/gfx11: wait for reset done before remap
  drm/amdgpu/gfx10: remap queue after reset successfully
  drm/amdgpu/gfx10: wait for reset done before remap
  drm/amdgpu/gfx9: remap queue after reset successfully
  drm/amdgpu/gfx9: wait for reset done before remap
  drm/amdgpu/gfx9.4.3: remap queue after reset successfully
  drm/amdgpu/gfx_9.4.3: wait for reset done before remap
  drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
  drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
  drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
  drm/amdgpu/mes: modify mes api for mmio queue reset
  drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
  drm/amdgpu/mes11: implement mmio queue reset for gfx11

Prike Liang (2):
  drm/amdgpu: increase the reset counter for the queue reset
  drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  20 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/cikd.h          |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 251 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 127 +++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 103 ++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  76 ++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  75 +++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 179 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 132 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 134 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++
 drivers/gpu/drm/amd/amdgpu/nvd.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/vid.h           |   1 +
 19 files changed, 1243 insertions(+), 49 deletions(-)

-- 
2.45.2

