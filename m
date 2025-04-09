Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E205FC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 05:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794FF10E043;
	Wed,  9 Apr 2025 05:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SU3mXUFA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770F610E043
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 05:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo/pg2c/sJH5wsQnNG0VKkiyNxlDglFAyAy2fcoEi5W/+2/pKt1txf473PdjyEn0DH0YugdtAktOBocnSH0w5YJNrBQw4/aPKEaBLOEWHD8Ke+F+9nsPy0lWpjP6c2p4+aOUrzneP7ch6xGJ7X3gF1/+Bhwt7yIk4HyCEUVBknWzIl/Ulm6469IGVHYgJWHixNWxSs4n2F39550FMvS+Ys8B+FzjCZ404c7JJr2K2jxtJ3MQXxdVS1G3ALNFEn98Zv1BZ/GPFE5G47/hL5vOhc8jWqrMzX3xYOPYhO5dWP6mPiveFH6q/CV0N19jyQHe4qaWunDdpTOn8jiNMQByFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB3gAD3AHCI9Z2IAWHYgAW2koPneNydsAvgvueAwjJ0=;
 b=OYo3CplT6U4ydgQC8sgTOj6399p+TMJQAUp2i0B17YA+YBE2ZlTbHZOq5diqm8JUdNUpvAIDO9MOBDRIOAge8HyyU+dzQSAWNwm0H1PHRT0hBzCoBxt/Wk5IKiKrfQRqDwv/c23QaX5r469Glze1Bg00oAYVeSm01SSmrMHYajtKqTAJwqf5KyrdabrkzJ83WaugTCC2lb+Zi/jv535ds8bWqMIBtMQRoRtcQExU6bbawg7pcfwIB102gXvhtAqJ4xUATJghU6tcwZ5gRuMSrWO77mfdFNoX2PNFU9xCI0Wu26iSYPPgyuSOXxdg+TYuXZTCkWsP2u2gSmZ7vqWLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB3gAD3AHCI9Z2IAWHYgAW2koPneNydsAvgvueAwjJ0=;
 b=SU3mXUFABfmOf+waTE7ya1ZH8olB2uFPybG94zxeW4CtOs+gax4EtoiHhHFyFZvQ2m4D1hC6A4Vo61ZoQICR1vwSXowI6Hgucnhz0uNfZzfT/aZyh7nAJypufA3FV3Ae3xjxpiHEyD9+9CVrJ//ZAHTqfQVMcHqyHjC0UGYkA98=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 05:49:15 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::f2) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 05:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Wed, 9 Apr 2025 05:49:14 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Apr 2025 00:49:11 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/userq: Fix lock contention in userq fence
Date: Wed, 9 Apr 2025 11:18:26 +0530
Message-ID: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: e671d98d-5f0c-45c1-5dad-08dd772a427b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IRoUy5mcp5PfUc9eVtklw5FHVP239IwHWj3PkUySvDUdWObyCENjaeAPOxhn?=
 =?us-ascii?Q?X36OPza3KLUmg+TylmxygNPDaVWPVerDsF0YBYjWcm+IS3/XnTo6HJ7UGjNq?=
 =?us-ascii?Q?aQcWfcvqZX0BoxFhSUbBha+52vZ1mNAFmeaRBW242pLviHpVRRosc7rn1Dpl?=
 =?us-ascii?Q?s66K0EG/RHNonYZaK1XXbisksxK3GOMGuY7WWtACzZvsC8hNsFQgvHQb4uYn?=
 =?us-ascii?Q?gK3fbcQz6XAqwNUN3/k+6QPdaWYrtwrj0IZil9FFlARTbiIzpoPF5CfdN+rL?=
 =?us-ascii?Q?yBEQ0rB6ZEubuxZtyqd05hsG1StDW83X6UIVw/sT6JYRW9eoDEnONeD9P5tA?=
 =?us-ascii?Q?zKNBNVv/u3uOXxEITSer3hcP35R4SBnRy2uRqXgtsk71YUhWYQo4c3owgmgI?=
 =?us-ascii?Q?76lCTscGxhK+x5iP35bADpT4JNe4UL0Z70Zh5gt5fsgSDNPU2LHkQDq30sYn?=
 =?us-ascii?Q?xdcghxcTD6hAvrNqnKCVbYWSiGzrCFVSmdIOYCiVKETB+lvZPt3hjClZgi6y?=
 =?us-ascii?Q?QF5EiSRsnq/7vNiluFJhMZM/KibHMDHSKS0Xd4VKEmJrTJO+BgglCJVOnfql?=
 =?us-ascii?Q?Ig+jGQzsfXrVlAFcc86RDEk3l1eZTz6juq1C9/36XsQZ3g4OjKOZNz9IpCIb?=
 =?us-ascii?Q?GfpdgQPXu4Cg0T96iLkUiTJFr6sLZX7u+96yw7Au1U6En0wCuC8cY24Gcw/u?=
 =?us-ascii?Q?sC+msffSSs5Sdg5uhM/V8E2vPaJNRpfUnkTSc42AlmUc8Z9+C3Aruq3DZqcI?=
 =?us-ascii?Q?ArKw8svYBMapCd1L4mY531CE0s3MyRXJLz1KKkTZnqApfzPDoaINMbWl8U9m?=
 =?us-ascii?Q?EgkGXFQ52A6fXihB0XUL14RGtAwt96W0Jb8q2U/9AFgwvZXah2mX9GAEabOr?=
 =?us-ascii?Q?LXBgAqoWLn4m5bbmCVgtTJaR28kmf23+7VoDl1wGGvHJ15GUon7ML6lKTIgZ?=
 =?us-ascii?Q?4bVhVOxc9qRrl2X2UBwt1pLgxCjrAH3HAfiEf7JFdumN2M1orRGVben8kqfm?=
 =?us-ascii?Q?YY4x1QPvCQR/ltxpVzSVeeHItSKXRKH3y2ehDJifGcLp+VjDoTkOTXg1Rb+u?=
 =?us-ascii?Q?qXCgqvKgmCQ0BMXdwU0Wo7RTqzj4XEZIql5PYmWraBxgiIptdEUzwx4JKmkN?=
 =?us-ascii?Q?OQbUeX9q9AND1rbjeUOQKP60feXLuiXxoYlpCf/+X97wxwngJ/10wwFgArCv?=
 =?us-ascii?Q?l0W5qtQTqVH5QJNNcywQPF5gmvf6RZSfEZ1yAydfIfWX4aBxqu6BOWOTKn7r?=
 =?us-ascii?Q?imPl6Cp8hKISJOkf69JDNLhb0wP3y9OGHrNisj9x+lU2YQQwrTv5F/nN7tmu?=
 =?us-ascii?Q?58q/XUf7nEm8DmbP0BnnN3MlABiPN/oKBPRY6LG6vIGUsG7fUlLu/mADbYpQ?=
 =?us-ascii?Q?QRN1KtxMQnSMsNu31UyUaqvqYfIIRw8A3GBjnHosljMReDmx0i3i496zhufG?=
 =?us-ascii?Q?jypnxNWG8Y23qCbbHWZ7aVIpzVEco98lyJNi0ICfnSEfQ3ME9lfzJ4+/gPHM?=
 =?us-ascii?Q?an+REKpAjgbWgyY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:49:14.2643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e671d98d-5f0c-45c1-5dad-08dd772a427b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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

Fix lockdep warnings.

[  +0.000637] ================================
[  +0.000004] WARNING: inconsistent lock state
[  +0.000004] 6.12.0+ #18 Tainted: G        W  OE
[  +0.000004] --------------------------------
[  +0.000004] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[  +0.000004] Xwayland/1952 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  +0.000005] ffff8884636f4740 (&fence_drv->fence_list_lock){?...}-{2:2}, at: amdgpu_userq_fence_driver_destroy+0xb8/0x540 [amdgpu]
[  +0.000208] {IN-HARDIRQ-W} state was registered at:
[  +0.000004]   lock_acquire.part.0+0x116/0x360
[  +0.000005]   lock_acquire+0x7c/0xc0
[  +0.000005]   _raw_spin_lock+0x2f/0x60
[  +0.000005]   amdgpu_userq_fence_driver_process+0x75/0x400 [amdgpu]
[  +0.000185]   gfx_v12_0_eop_irq+0x29f/0x420 [amdgpu]
[  +0.000210]   amdgpu_irq_dispatch+0x2a4/0x7b0 [amdgpu]
[  +0.000191]   amdgpu_ih_process+0x1e1/0x3d0 [amdgpu]
[  +0.000185]   amdgpu_irq_handler+0x28/0xc0 [amdgpu]
[  +0.000183]   __handle_irq_event_percpu+0x1bb/0x590
[  +0.000005]   handle_irq_event+0xab/0x1d0
[  +0.000005]   handle_edge_irq+0x1fd/0xc10
[  +0.000005]   __common_interrupt+0x83/0x190
[  +0.000004]   common_interrupt+0xb1/0xe0
[  +0.000005]   asm_common_interrupt+0x27/0x40
[  +0.000004]   cpuidle_enter_state+0x2ba/0x530
[  +0.000005]   cpuidle_enter+0x4f/0xb0
[  +0.000006]   call_cpuidle+0x46/0xd0
[  +0.000005]   do_idle+0x367/0x430
[  +0.000004]   cpu_startup_entry+0x58/0x70
[  +0.000005]   start_secondary+0x224/0x2b0
[  +0.000005]   common_startup_64+0x13e/0x141
[  +0.000005] irq event stamp: 88271
[  +0.000004] hardirqs last  enabled at (88271): [<ffffffffad9ca7a1>] _raw_spin_unlock_irqrestore+0x51/0x80
[  +0.000005] hardirqs last disabled at (88270): [<ffffffffad9ca424>] _raw_spin_lock_irqsave+0x74/0x80
[  +0.000005] softirqs last  enabled at (87858): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000005] softirqs last disabled at (87849): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000005]
              other info that might help us debug this:
[  +0.000004]  Possible unsafe locking scenario:

[  +0.000003]        CPU0
[  +0.000004]        ----
[  +0.000003]   lock(&fence_drv->fence_list_lock);

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a4953d668972..24d19b920100 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -159,10 +159,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
 	struct xarray *xa = &adev->userq_xa;
+	unsigned long fence_list_flags;
 	unsigned long index, flags;
 	struct dma_fence *f;
 
-	spin_lock(&fence_drv->fence_list_lock);
+	spin_lock_irqsave(&fence_drv->fence_list_lock, fence_list_flags);
 	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
 		f = &fence->base;
 
@@ -174,7 +175,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 		list_del(&fence->link);
 		dma_fence_put(f);
 	}
-	spin_unlock(&fence_drv->fence_list_lock);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, fence_list_flags);
 
 	xa_lock_irqsave(xa, flags);
 	xa_for_each(xa, index, xa_fence_drv)
-- 
2.43.0

