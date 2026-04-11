Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24799F45A1D
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2026 04:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7227A10E179;
	Sat, 11 Apr 2026 04:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mN6Pe+27";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B98810E179
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2026 04:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7kOQ+Sv4Nxm3e+qiFS9Pl6SVQL72ZSzYAxunf9crvJ0O1JSQyL8rq7cT4LUPok5yJZ/MI48oFOgLWGans9kT8Fy8yXl2W96FGIujTgEE+ONVuUK4JLg9VTdzlV4eXZacLqFHxBkBu+kSOttjJCyqN22U1wAd5xCIJA+butOqqFoJX/iH+M/nczghuxQffAq+PiwepDneZrFQQALY/Apg2nOxRq3Yh/azmCeNsapzam9M6k+EHWPyUhQHJBXd1Hi49As+xwTGoZ1LTwDBjtszFQjB+R/LZqQSytZ128hjAdMQPXxAMKO/kN+8FIf+xi472EZMGhtkH0cu3h786gs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/Afz1AfEIMeu1daDsgcpa2B5F7Y8Cz4GXtZd2VxRQQ=;
 b=VxAOGPOSCc+AbT6Ou/DW5ZfoufcoOweoLTuEza8xO6nLwPrJjEgoeYEzC55v0NQz7yle1l6tdQfm5OQP/EBXK5BG0qY/m7zjdUkhcetKRTYzG05A+Z7kTYufw3RGAUywc3pmDJqqA5+A4r2G8F3/qiTB/xBGw02ZH7F6xZyp7P7wqaEKBOXrtL9JHlHsEA0WDLNMKUdwpt1oalu8ZmUahVjS/YeWkUt12jDwHylpBGPRX/Sswqdi6efwzxgGM3ACnEkwBhs21X6aT2JKzm7qveTO8y6qSqZBjy5CC731JQRE70t8M/E8iUcQh4HzfJjL0/3066B7MTQN1tFV+B0ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/Afz1AfEIMeu1daDsgcpa2B5F7Y8Cz4GXtZd2VxRQQ=;
 b=mN6Pe+27mH1Cjc8rpBvvzkzOkOnIBSI1/sBJCqbaifDHJ+INsUQ6sThlzu8jsm0AEbSLGYLB3mwM0ORRuTw3q0mhB3eMdhMv7c1PCkN+F7WqAjzhYGQeHqPrsgrIWtDkmt3amhO9C8IRF+h2Ck9Ex9rEIb72jPEwhCE3+XSBrCo=
Received: from SN7PR04CA0029.namprd04.prod.outlook.com (2603:10b6:806:f2::34)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Sat, 11 Apr
 2026 04:36:17 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::ba) by SN7PR04CA0029.outlook.office365.com
 (2603:10b6:806:f2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Sat,
 11 Apr 2026 04:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 11 Apr 2026 04:36:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Apr 2026 23:35:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ray Wu <ray.wu@amd.com>, Roman Li
 <roman.li@amd.com>, Leo Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH] drm/amd/display: Fix crash due to NULL dc dereference in ISM
 during teardown
Date: Sat, 11 Apr 2026 10:05:38 +0530
Message-ID: <20260411043538.2304235-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH1PPF93AB4E694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9526c394-d404-4a72-8d87-08de9783dece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: A/Qr/C1BOuC6SLvV56djtD1h1EJ5aR8KVH4w6ooL/soR+vyv12HWrgfSARf12CaxVDYqeQeHnZ9R+t9CAxlJlK7SpwvsXL6CWfQOnBZVnLrE3FwjYqr4M1vbFzTav717VS84wdwalLpWe5m27v4o4/c21fCxHKqMsyQVBPe7j6QgQyobwvQZftpT3iCymMZFjaDvfhdpBhKVR1xMB1kGM9BsnmAlX7P3AyaH7EvdsGxODQbHeFAfmb3//+REXgzqwEIDh/9kH9/El49X+R4kzausEjrwVqF+lgWpWICL/uyIVr/qdT7RHv4+E7gIEZz3gCD1fwnyQ9NTtTRtG5KwU+BNO276P+cnbsSGiNjGaQsra6rX6atiV5eoxhAFxz847J3TW/GkDJL9q5lZWPDbgOSOdOnrrtqpTSZhsjzXoSJ3Hn1x7j6PzT/H2ycsckvse0ELQF6bQ/PTjrEJCj4MyPEjF0KSY1mL4nQO0Airz4N/ug/ELjIAxEqcF3LW+1sSX+xNmpDm4061FGBNRUhqekiZ0ODd8gvfaBXGnDuCOoFrOFWmti4PvQ2vCZsYi2O8tVMYr/8p/yzAvFlli0gu/jzIdVW1Fvk7b0B2F/KxXpvptRv2Q7XJ081gaR3PrT++zW6VsA6Ib2rDmcey7lbm7gyIuVwF4f/26slP4Z0FydWlchVPBnPD+Rjd4VkUya0fl152GjuBwFRdM06siJ7KmWu7Tv7afI3fM3T5ObnUPKc9R3YmJcQcuTCOEWg1QCRYk/A9KpiYplOzas1KxIfdGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xgX7odntsuWRHPEjd2JpySDZ+eqL+PtmxBjcoCYEW1HRxYy/EEtlYMorM49dvyVvrHyMzIF5Aeq3CKGQFK3WEI13+uCtaVZwOaDWHqUZOP8FsnkZaa0ivCu3UTtX4MEWKz7jViqja3JXWeXnuC4WClNz4J0LeBzydyLZl6DVNL5OekdqyAnhAuU7TkYn4g97IzKJEAJkZ6bOhnKso6XVugGyluLLVvCbamhDzG/O9emjGTL0nJiAoolg3Z4Y5VQ276uSGVfV93urB0GM/j0Bq+r8UeLCJY7VN8Ks1qZRjLC1h7lvrBIEt1tcKfP4dABM7CDrO6SzxoM8q5kTaj1FCvjXSYdZSrslW1csH9/rgwl6JI9i0v9oAiDD0xeHcm//igjlzupCfIB4IlDunriXz2TLBLbFYF3EWcbtRCtBzjdV8Y7ChqFo7pzQAvt4PF6l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 04:36:16.7427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9526c394-d404-4a72-8d87-08de9783dece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694
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

The Idle State Manager (ISM) uses delayed work to apply display idle
optimizations later, instead of immediately. This helps avoid rapid idle
transitions that can hurt power or performance.

A crash was seen during driver teardown. The system boots normally and
the driver loads successfully. Later, when the GPU is being stopped,
the log shows:

  amdgpu 0000:0e:00.0: finishing device.
  Workqueue: events_unbound dm_ism_sso_delayed_work_func [amdgpu]

After this, delayed ISM work still runs and reaches:

  dm_ism_sso_delayed_work_func()
    -> amdgpu_dm_ism_commit_event()
    -> dm_ism_commit_idle_optimization_state()
    -> dc_allow_idle_optimizations_internal()

The crash report showed:
  KASAN: null-ptr-deref in range [0x690-0x697]

GDB resolved dc_allow_idle_optimizations_internal+0xa6 to:
  struct dc_state *context = dc->current_state;

The matching disassembly showed:
  mov %rdi, %r12
  mov 0x690(%r12), %r13

where r12 holds the dc pointer. A GDB layout dump of struct dc also
showed:

  /* 1680 | 8 */ struct dc_state *current_state;

Since 1680 decimal is 0x690, this confirms that current_state is at
offset 0x690. The crash address (~0x690) shows that the access was:

  dc + 0x690

This means dc was NULL at the time of the dereference.

So the issue is:

  delayed work runs after dm->dc is cleared during teardown
  -> dc becomes NULL
  -> dc->current_state is accessed
  -> crash

The current ISM code calls into the DC idle optimization path from the
delayed work handlers and from amdgpu_dm_ism_commit_event() without
checking whether dm->dc is still valid. In addition,
dm_ism_commit_idle_optimization_state() calls
dc_allow_idle_optimizations(dm->dc, ...) unconditionally.

Also, amdgpu_dm_ism_commit_event() requires dc_lock to be held, but
amdgpu_dm_ism_disable() calls it without taking that lock.

Fix this by:
- checking dm->dc in delayed work paths
- checking dm->dc in the commit path
- checking dm->dc before entering the idle optimization path
- adding a defensive NULL check in
  dc_allow_idle_optimizations_internal()
- taking dc_lock in amdgpu_dm_ism_disable() before calling commit

This prevents delayed ISM work from accessing an invalid dc pointer
during or after driver teardown.

Crash signature:
[22601.113316] KASAN: null-ptr-deref in range [0x0000000000000690-0x0000000000000697]
[22601.113330] CPU: 4 UID: 0 PID: 46099 Comm: kworker/u97:2 Tainted: G     U     OE       6.19.0-asdn06042026dut #13 PREEMPT(voluntary)
[22601.113348] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[22601.113357] Hardware name: Gigabyte Technology Co., Ltd. X570S GAMING X/X570S GAMING X, BIOS F7 03/22/2024
[22601.113368] Workqueue: events_unbound dm_ism_sso_delayed_work_func [amdgpu]
[22601.113930] RIP: 0010:dc_allow_idle_optimizations_internal+0xa6/0xc40 [amdgpu]
[22601.114452] Code: 00 00 00 f3 c7 40 08 f3 f3 f3 f3 48 89 f8 48 c1 e8 03 48 c7 45 98 00 00 00 00 48 c7 45 a0 00 00 00 00 48 c7 45 a8 00 00 00 00 <80> 3c 10 00 0f 85 8f 08 00 00 49 8d bc 24 b4 00 00 00 4d 8b ac 24
[22601.114469] RSP: 0018:ffffc90007857ad8 EFLAGS: 00010216
[22601.114481] RAX: 00000000000000d2 RBX: 1ffff92000f0af64 RCX: 0000000000000001
[22601.114491] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000690
[22601.114500] RBP: ffffc90007857ba8 R08: 0000000000000000 R09: ffff8881a0dc7d30
[22601.114510] R10: ffff8881c16ca000 R11: ffff8881a0dc6838 R12: 0000000000000000
[22601.114519] R13: 0000000000000000 R14: ffffc90007857b80 R15: ffff8881a0d80010
[22601.114529] FS:  0000000000000000(0000) GS:ffff888417dfb000(0000) knlGS:0000000000000000
[22601.114542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22601.114549] CR2: 000056558b543b5c CR3: 00000001c0efe000 CR4: 0000000000750ef0
[22601.114556] PKRU: 55555554
[22601.114561] Call Trace:
[22601.114566]  <TASK>
[22601.114572]  ? srso_alias_return_thunk+0x5/0xfbef5
[22601.114582]  ? update_load_avg+0x1b6/0x20b0
[22601.114593]  ? __pfx_dc_allow_idle_optimizations_internal+0x10/0x10 [amdgpu]
[22601.114932]  ? psi_group_change+0x4ed/0x8d0
[22601.114942]  dm_ism_commit_idle_optimization_state+0x214/0x570 [amdgpu]
[22601.115268]  amdgpu_dm_ism_commit_event+0xe1d/0x15a0 [amdgpu]
[22601.115588]  ? srso_alias_return_thunk+0x5/0xfbef5
[22601.115595]  ? __kasan_check_write+0x18/0x20
[22601.115603]  ? srso_alias_return_thunk+0x5/0xfbef5
[22601.115610]  ? mutex_lock+0x83/0xc0
[22601.115620]  dm_ism_sso_delayed_work_func+0x64/0x90 [amdgpu]
[22601.115955]  process_one_work+0x647/0x1030
[22601.115968]  worker_thread+0x6d6/0xea0
[22601.115982]  kthread+0x38f/0x800
[22601.115992]  ? __pfx_worker_thread+0x10/0x10
[22601.116002]  ? __pfx_kthread+0x10/0x10
[22601.116011]  ? __pfx_kthread+0x10/0x10
[22601.116020]  ? srso_alias_return_thunk+0x5/0xfbef5
[22601.116030]  ? calculate_sigpending+0x88/0xa0
[22601.116041]  ? __pfx_kthread+0x10/0x10
[22601.116051]  ret_from_fork+0x4c5/0x5c0
[22601.116060]  ? __pfx_ret_from_fork+0x10/0x10
[22601.116067]  ? srso_alias_return_thunk+0x5/0xfbef5
[22601.116074]  ? __switch_to+0x383/0xd70
[22601.116082]  ? __pfx_kthread+0x10/0x10
[22601.116090]  ret_from_fork_asm+0x1a/0x30
[22601.116100]  </TASK>

Fixes: 0b572a6bf04a ("drm/amd/display: Add Idle state manager(ISM)")
Cc: Ray Wu <ray.wu@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 29 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  7 ++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index a3ccb6fdc372..7e7b3cac80bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -272,6 +272,13 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	struct amdgpu_display_manager *dm = &adev->dm;
 	int r;
 
+	/*
+	 * Delayed work can race with DM teardown. Do not enter the
+	 * DC idle optimization path after dm->dc has been cleared.
+	 */
+	if (!dm->dc)
+		return;
+
 	trace_amdgpu_dm_ism_commit(dm->active_vblank_irq_count,
 				   vblank_enabled,
 				   allow_panel_sso);
@@ -472,6 +479,13 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 	/* ISM transitions must be called with mutex acquired */
 	ASSERT(mutex_is_locked(&dm->dc_lock));
 
+	/*
+	 * DM teardown may already have cleared the DC object while
+	 * delayed work is unwinding.
+	 */
+	if (!dm->dc)
+		return;
+
 	if (!acrtc_state) {
 		trace_amdgpu_dm_ism_event(acrtc->crtc_id, "NO_STATE",
 					  "NO_STATE", "N/A");
@@ -514,6 +528,9 @@ static void dm_ism_delayed_work_func(struct work_struct *work)
 
 	guard(mutex)(&dm->dc_lock);
 
+	if (!dm->dc)
+		return;
+
 	amdgpu_dm_ism_commit_event(ism, DM_ISM_EVENT_TIMER_ELAPSED);
 }
 
@@ -527,6 +544,9 @@ static void dm_ism_sso_delayed_work_func(struct work_struct *work)
 
 	guard(mutex)(&dm->dc_lock);
 
+	if (!dm->dc)
+		return;
+
 	amdgpu_dm_ism_commit_event(ism, DM_ISM_EVENT_SSO_TIMER_ELAPSED);
 }
 
@@ -557,8 +577,13 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 		 * When disabled, leave in FULL_POWER_RUNNING state.
 		 * EXIT_IDLE will not queue any work
 		 */
-		amdgpu_dm_ism_commit_event(ism,
-					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+		{
+			guard(mutex)(&dm->dc_lock);
+
+			if (dm->dc)
+				amdgpu_dm_ism_commit_event(ism,
+							   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 63f51c69919b..f92007342a31 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5770,7 +5770,12 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 	int idle_fclk_khz = 0, idle_dramclk_khz = 0, i = 0;
 	enum mall_stream_type subvp_pipe_type[MAX_PIPES] = {0};
 	struct pipe_ctx *pipe = NULL;
-	struct dc_state *context = dc->current_state;
+	struct dc_state *context;
+
+	if (!dc)
+		return;
+
+	context = dc->current_state;
 
 	if (dc->debug.disable_idle_power_optimizations) {
 		DC_LOG_DEBUG("%s: disabled\n", __func__);
-- 
2.34.1

