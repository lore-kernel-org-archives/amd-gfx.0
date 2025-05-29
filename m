Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBFEC5B543
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD13810E24D;
	Thu, 29 May 2025 20:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mVvugayi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0854410E755
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5X38qjKtpGP1XrEMxjmG+QAYOwVURTZaef5hjpplmB40nY+1uDMc/uwkn6bjdoOEFshXeVW13qt77/kjSnJq8HgxH8ImWtGA2sRf7MuTh8pcpwpxB7G/9idvQsN9C3d3UQW1xln6mT9FpeDi4yTIpL2pIOQ5Dvq3esjBOar2e6gxJrcw8ZHOj0WEZiy+/FIvjvTFbXXCB0cJBv+DFmvhTLNo2iK/rZMEpmKPRwSdsDVzles5RQY0IKGIGNQzE2mLIC/wO6jB0CJy08rf/CeRqPT3CsQ7naBHCeTqhQt//Xm39gvEgDNWdNdIDaaHVatlI1pVpckYzN5ZMrIKvfpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32xxT1S6bEssbQgTNfTJ5cmiNQPIjcWgKz/9D8CXFkA=;
 b=rTQ6snJyMzT0QlYqbUaQsBkQdF6yV7/TIuodSXM3ZDD98RlB4xFxxeYHzHxZJwaB3jYkt0Bx/F/zZmHu159Y/kjPm5NyIYyF8S0inxcE8f/88tk73IFVKLN+KnzIwBuKzJsC+DnGqRzcstd7tRcWcUO6psiNsaV4CwJRJ59S4osGsAEIkoJVpci6iWS3iY7QmnMLHpeoCQGYxIb/dnbOt7tQxuuDmrWetQ++qDzX+aVUWfpnYyN7pnT0QZdRmSa8yJNYi7ACppC1J3PCiJ6jUj1fNbtX+03HU9kdhtvDEQ5mFxv7JDOYNvDdN/FmzAvbT9XbyOUt5F0rN9FW8fxOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32xxT1S6bEssbQgTNfTJ5cmiNQPIjcWgKz/9D8CXFkA=;
 b=mVvugayiIeWtpdVsSBv21m8SC4HmVMxS7+SaZl6yQwO17KAkLGz3uKUDIUhLc247PT/KDJ3VGB7WM5jLdbuVcruE/r3pfc+W5RCTjft7e9NjwN/HcuVbeY+c7bOgz5H7/uclMxuPIe5mjk5tNMhDD4K++myb8+BTJxFXWtleO38=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 20:08:26 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::19) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Thu,
 29 May 2025 20:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/28] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:40 -0400
Message-ID: <20250529200758.6326-11-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: ef062736-73f0-4b8f-ff2e-08dd9eec9216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OOE5kId8RhlYTjI4164aPGPiUoKPywYSzS5LWMxpyo97ep6ns350vAxzmsuN?=
 =?us-ascii?Q?4ND5NSgm2MsDdOCYQII6t+1sD5cNrq4MrjfNz14jkLv5jUxHFTdlBkXIrgjJ?=
 =?us-ascii?Q?s/UpmS2M7WkeAABgYFWrwdH2g2z94C7QTldu9UVrig99w9uDQTATKUDE0cGq?=
 =?us-ascii?Q?N7eMEArUDPqbPTvWxIz7aRd06pUY4206+ZWN2LqcxjuLH4KtX2WAxLNeMpZ/?=
 =?us-ascii?Q?yxxUIN05CR9AjjnTjjtte0tKj3QG3yguiFD2FJxpMnBs0g72hH322hpYwrM9?=
 =?us-ascii?Q?VJrlbvA2wItNDEj9l7NzhreJ4jY8jaBQJ5e/mZN3Fuz2o17EklqPt2QmqiH6?=
 =?us-ascii?Q?4OfkbIInk9YBmy8B0qhtnuVd4bPNHzz0Y1ZVldXVYGp9DeQ5RUk/NzNqCif/?=
 =?us-ascii?Q?eCMk/WDzN7pFt5wi8TNRUyTUNLaUTxau6apRZTnCrKnaXf+E8taPmNSDD8bI?=
 =?us-ascii?Q?0vwHL9bS4cPvaTK9uoc/QsI92bsGGsZnF2Z1V87ELKEd7dPyrYsodtVNYz4v?=
 =?us-ascii?Q?jVNc+ITC7yM1jrWTExaQq6JWgjo+AqOYOyCJ5NjuKLdYhdC0MJBTNK5Q5D1g?=
 =?us-ascii?Q?fdUYQa5pYrI0V7NIHIMEnS3uskYecUl+2iv3gg3QJ21cgYp7br+VcwNSStxs?=
 =?us-ascii?Q?h8XoIns8RfvEbo7nCcm7E1nRxUVsb6ZRwzHsbJiSwRpn/buj7PzQ4uTD34sm?=
 =?us-ascii?Q?8uPeJ2DwxadaTzhOVsRKxXUMK1PGguWOfLXRZDbhvT2FDkgAFKH/hZ1Mof+X?=
 =?us-ascii?Q?7Afwz5VN7pI3y4N38kxUQ8Sup2wxICHvi2qozPZz1/wG462srw+JBIPqDtHB?=
 =?us-ascii?Q?wgux2z7wNTFwZK7eiM3FqM9HNID/o+zj0ZATRiZe4QvDe7mGA+IcoEXEzp4k?=
 =?us-ascii?Q?q1y7jUX3KTNWEr6/OaU7MRHXEVtNX+F4JE5ZisUm2duDsd8DtUK3h9oszzlR?=
 =?us-ascii?Q?N8I33hAn3eXh4SlEdeMSo9qGrK9aXzHqqWQCGF9wlFHUQ7OuamJcvoDG9eIB?=
 =?us-ascii?Q?Yf/LvkH0Ny/YkZTfAQKUia4vkUEWPOO31UH50wovPb4Sfa1Nawx6BjaYWqeR?=
 =?us-ascii?Q?mdYqpsh0dLkTHU7NJ3rXFkY9sgIUGhB4b3ok7KdHIjbCwSpdKOBkiyci1e+9?=
 =?us-ascii?Q?Uxa0hixrZbHPtG9SSvlMSv6YtDvFGUmy3zH1zve9YpzXD1kCVbqz4bUxJvGv?=
 =?us-ascii?Q?QdsLV8lGp0TB9kjeWrKU6sRyW1XUjnStu/F/Vrsd8MC8yhtWAZO5TlbgFx5c?=
 =?us-ascii?Q?C5f6g86UpPbyWj9Fxr8Kewbbw9KR8KD1ZMcqSu/jEBSDlSDnzJQkbTYkWpA5?=
 =?us-ascii?Q?mA+OArqGo/SDigGXNAX2AVq2aaUmZev5Q2hm6+pcSJAho2+wBJaFOH6XmpuH?=
 =?us-ascii?Q?ZSATpa8xDtuQFJLmArbeSkCLCNLbsnBZQvBmhURnoE6536Z8rTTha5DvXzze?=
 =?us-ascii?Q?sM8hG8rh1a/0qe+fI2dRLH+6nOihshvDmC8j03EWG9uYujwWLlBWREIjW5+n?=
 =?us-ascii?Q?JLp7uzPmaj9rN8qYhs/h6BwSaOQ+00SNq/nn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:25.5658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef062736-73f0-4b8f-ff2e-08dd9eec9216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f09d96bfee16d..50352b966f4ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4690,21 +4690,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
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
@@ -5335,7 +5320,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5448,7 +5433,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5526,7 +5511,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5565,7 +5549,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

