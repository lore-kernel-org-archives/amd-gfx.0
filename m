Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D33CD4F54
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 22:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6149F10E3F4;
	Tue, 19 May 2026 22:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nHoVd5az";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB99F10E3F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 22:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyhkSmaKF6885HyVBJQACrpRlnWsQOQ/2MlcdRcv079JYFEwV7nlo5iEYDJ2Qj+/EDaJXp2pdOGWCy/iDC1Kka71BorwKu2AkkRpEoLwU6i0z166bvSigrK2Bkn4vVetDpTf8A11xqSN6dFd043QKO+mGgafsVCpmrcw6rpDVhjG9OSfQ+dCutVH12X+dC7yHtV3n/kJU7b6b62tenqtiaWrQhLt/jVXdYYZh2M1xhMeRr6qDnoPGfbk96XMc+35Lh5843BddBaJbykoijdXgxSbIgGeWquXgtUjER5QpwfZ0NwJLbBunEL5Uzn4Du/CY1ozTSn0G7WZccefnn+dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oK50i7T+6QTXVBEyuGFGmua/p7zLo3GpwNEuIz8Bjs=;
 b=U31Jo92EbaVL87/f/Y8TX8ftO/RayHRn5uj35pvQlm26jLLL8/oV9RbcwrVc17dtJyV6xkZUlAosTB6w2uzq+fZBF0eqTOUPn6p/VpLE1EVEJ3DADGu82eb1KeiyRKeWMdCJ8e1WZu/dY4oOAvVXw7ny22Z/SR3sulGRhSCNyGQn5qn4Bb877AiZPMUwnejb+347zpYABYFk1lgVQB6RGwqPcyzLVxy0YYPoI1NxUV9IwoKyVsz/JLODSAixWUL6s1vhO4YPP83Nx97cC2wPoQ9e6D97ZtxBTbhvnow9Oo98ZjRNZsylAHQC0BmGgdcReu3u3kokpVP5bFKvO9NEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oK50i7T+6QTXVBEyuGFGmua/p7zLo3GpwNEuIz8Bjs=;
 b=nHoVd5azrHV/qOCw5TMKeke1Gzd3WrK0LkD+hK7vKewOApBfzGD4ZLqV7kP8btgjyhpUMsks3S7vcaSmRpf4TxrN63hcpKp6560y+FpfTDXyrQlPlfhT/JwGXicmBKfoJOMsRHgkaYLPJWvFKhEV0O+3Ib5Elg+Vptt4uvd7ZeM=
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by BN7PPF02710D35B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 19 May
 2026 22:06:05 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::ae) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 22:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Tue, 19 May 2026 22:06:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 17:06:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 17:06:04 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Tue, 19 May 2026 17:06:03 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Li <sunpeng.li@amd.com>, <Harry.Wentland@amd.com>,
 <Aurabindo.Pillai@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <michel.daenzer@mailbox.org>, <alexander.deucher@amd.com>
Subject: [PATCH v2 0/3] Fixes for flip_done timeouts
Date: Tue, 19 May 2026 18:04:41 -0400
Message-ID: <20260519220529.202096-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: b291fee7-4dd4-4437-69d5-08deb5f2d25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|32650700020|82310400026|1800799024|18002099003|56012099003|13003099007|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: PXJeCJT7fquctTaVheXwZm+ITs9evCHvk2CF+7+hUA+tb9zpKVFMr0mBarA0GNObVV8WS1mUteSp7F5kVFFcTN3Zx75G0/j87Cth9xXWpvklult8uvC6z4sM/KS5USpHcV5y56H9wkxFAGysr6GDgHBTwwk/veYF0IOivDe5wF31kCbgAwKRp7A/KbhoTVJWcFE8nkonnMPFAeTEk/88LUIoG8NDP+67/kDrHOwW8aB/PZR1AZIZYk1kSELCG6DoBe4LE9HGF+UVPjNxF899pkxAqXUWsPHt3y0SGnoc4E8Y4xIn1YSXjJm4MZDM0vDb+uj+VZQbCJBFE5VD2Udx4LhcB//FU7SXE7n9ZMQGUEfb9BQD2girTnpy9EJCM4XlCb1/QHbOKvJMVZ1rBXuXCHpU++XDQHYAjLoK8HyuwI1/LQdL89JWnbQPKfJ21dR8/UpQmlBf9mMJuMzOes7azHIcl0WlFOC9ufCpXY33Zv+gHK7dOzUP9o0+ahr70JOGvsK6XBdKt0rnieDTt5qykZSnqPNJxjMIOHmNZ09D6iYQJpWi2gPOJesYGlmFWOb1xod0nQZkr7PM871qwlPqHlrpGUeHQulWZPfeMbnGqk7k0EVeqfHM9jOqWiuuWkov8ar/athj9znzMiWP6MSVl4E0zDracXotUh6C4hdX8o+D0U5Q+XuZffWeloUIrnfB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(32650700020)(82310400026)(1800799024)(18002099003)(56012099003)(13003099007)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P5PzCuDOK6veksrnTfiEeCCt3lvAViMTz7zRuYEitYgHr8wsYJ+kr8Fxjsm/wxlyzqCjypv81T1qTq5qIuCUj0oJkH60ZQm9N7sMy4YlEzYuvN77U9MMKh2coJfJiXf4ts7gZSfLhjP/IMsv7Vw4DjWkkRg43UyelTOtJ+GQMyZjeQlHKyu3so+1hkM1gwmMSjMk9+A5FOurNL2pBZRbzZ3aNctdDLLgUpgLE5OwdMGu2XWFSAqdVQ+uZF0qnKYTGhWkK5t7oGJGTWwhyD521U7I4t1ghw4nkVydI2vSL1uzd2nQGQhHnG9btuWMC46XsryB9KGnoC5GThH/QX1V4+EvSw247Rou/x511kpqRR2D8wlamYvKqs7GIzJzNw3d0vpieYUCD5gnkE7RS985oElZGWljX4ZMO7Me8+UciwaV75cYYkSfSwqnbcRpClLJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:06:04.8407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b291fee7-4dd4-4437-69d5-08deb5f2d25c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B
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

From: Leo Li <sunpeng.li@amd.com>

This series collects a few fixes targeting the intermittent flip_done
timeouts that have been reported on a range of DCN systems (most notably
NV3x+ DGPUs and some PSR-capable platforms).

The investigation pointed at two distinct root causes:

1. Cursor vblank events are delivered from the vstartup OTG interrupt,
   which HW can mask (see [2/3] for details). When that happens, no
   vblank event reaches userspace and the commit eventually times out.

2. PSR-capable systems can engage dynamic power-gating on HUBP, the HW
   block responsible for delivering the pflip interrupt. Programming a
   flip before HUBP fully exits DPG can mask the interrupt.

Patch 1 reverts the 5s vbl offdelay workaround that was added for NV3x+
DGPUs, since the underlying issues are now addressed by patches 2 and 3.

Patch 2 switches DCN vblank delivery from vstartup to the vline2 generic
OTG interrupt. Unlike vstartup, vline interrupts cannot be masked while
the OTG is active, so they are a reliable signal for delivering vblank
events.

Patch 3 adds a backup path for masked pflip interrupts on the newly
introduced vline2 handler.

Many thanks to the reporters who collaborated on these issues [1][2][3];
the bug seems to avoid driver devs. Your help with testing patches and
collecting debug data was critical to these fixes!

[1] https://gitlab.freedesktop.org/drm/amd/-/work_items/4141
[2] https://gitlab.freedesktop.org/drm/amd/-/work_items/3787
[3] https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/

Changes since v1:
* Include a revert [Patch 1/3] of the change that restored the 5s vbl
  offdelay
* Fix vline2 irq_source [Patch 2/3] to map from crtc to otg index
  correctly
* Add a fix [Patch 3/3] to address PSR exit race with flips

Thanks,
Leo

Leo Li (3):
  Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
  drm/amd/display: Use vline2 interrupt on DCN instead of vstartup
  drm/amd/display: Check for flip completion in OTG interrupt handlers

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 248 ++++++++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 103 ++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   7 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   8 +
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |  44 +++-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |  43 ++-
 .../dc/irq/dcn201/irq_service_dcn201.c        |  24 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  44 +++-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |  44 +++-
 .../dc/irq/dcn302/irq_service_dcn302.c        |  43 ++-
 .../dc/irq/dcn303/irq_service_dcn303.c        |  24 +-
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |  44 +++-
 .../dc/irq/dcn314/irq_service_dcn314.c        |  44 +++-
 .../dc/irq/dcn315/irq_service_dcn315.c        |  44 +++-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |  26 +-
 .../display/dc/irq/dcn35/irq_service_dcn35.c  |  41 ++-
 .../dc/irq/dcn351/irq_service_dcn351.c        |  43 ++-
 .../display/dc/irq/dcn36/irq_service_dcn36.c  |  41 ++-
 .../dc/irq/dcn401/irq_service_dcn401.c        |  25 +-
 .../display/dc/irq/dcn42/irq_service_dcn42.c  |  26 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |  18 ++
 24 files changed, 744 insertions(+), 271 deletions(-)

-- 
2.53.0

