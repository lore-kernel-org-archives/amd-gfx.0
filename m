Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFF4F34C5D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D33388CE4;
	Mon, 13 Apr 2026 14:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MLvaVN/8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C6110E095
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXpWcQ6YMu63Hb74+GB7CWwlxeWvdBXJ0S9InAIT2zCjBr4FvE3bQqOaqkGGkUKVqmR33cvQ8OhX5bfBlqzClw6KkdzI6INUYfF7XePIVlCn1dbfjolj2EMQZlBNh4qPkOwaCHNKagyaCgj/1H+Euxmi8JWHev5YFWXyvPyyA4nKlPaYkjKiXw98ptJ/HBoWSfVrPRkDF2BdbCPhi/iH0JUPOpMzzcYFgW+2ZlCnU/1qKWBg3WdYcPrwNdx/HJ1QJBjnboAkpLitS9Vso+oELy17yjW/Q4vqDMJFZ0EK4uxHX61d4jDE6dvKsiipomPRdvosWkH9ZC98AvrYmhjwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWYvLvT0P95PfqpEUhdm9iYQSyvFp9FRvKOvGcHrEE4=;
 b=T6yGj9Yri651F0FeNopnNCb/2jWXjW5lm0yc+QeRAdt0rxTwqjD4XWCOBqBKSN6brXSsZRrasd8BBMcWth+DEWr/ZXajhEptYtd/6Zi1ddV55AxDmlIP+6J+huy7OzqgnAs/urjiZZQ/P2eLhaY9lblWZgAM2njIJ9t2zv3+DvR93LfOVG0EZ9gA4XPq5H3HXdIEhOe1urD1P8BlIynP2U3+qRWgFc0P/qcXOj19dNH0o9NdKGL6sF3Ruqv1eEGSA3Sea0dWVKZlAtmVLXAY6AoEIhJlBIO026vE5GcArVg4+hBCOwVrhbC7JQvzduJzk+ag2ptP/44+c62jwxwbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWYvLvT0P95PfqpEUhdm9iYQSyvFp9FRvKOvGcHrEE4=;
 b=MLvaVN/85yillsYH+dHkW6oEA2kzHS+9nmcmHLVq0dBwdjKOQVfQIgViw1bD0fyTh7eXR9R//ina5OGLuHBdCjSGPy7nPX2iCzr8V8jDAowhpFVNydnpPTS1tTsPFmhHcdgtyzOTZurJBVCCWArIbiOvuP0hkIDJdZ4ya7rUnao=
Received: from DS2PEPF00004553.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51b) by PH7PR12MB7234.namprd12.prod.outlook.com
 (2603:10b6:510:205::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Mon, 13 Apr
 2026 14:44:08 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::378) by DS2PEPF00004553.outlook.office365.com
 (2603:10b6:f:fc00::51b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9818.20 via Frontend Transport; Mon,
 13 Apr 2026 14:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 14:44:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:44:06 -0500
Received: from [10.254.92.104] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 09:44:05 -0500
Message-ID: <5276d674-96a1-4650-8224-bb29cd1bd009@amd.com>
Date: Mon, 13 Apr 2026 10:44:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix crash due to NULL dc dereference in
 ISM during teardown
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Ray Wu <ray.wu@amd.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Mario Limonciello <superm1@kernel.org>
References: <20260411043538.2304235-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260411043538.2304235-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 0029206a-c9cb-431b-f53e-08de996b1d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|42112799006|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IiV25Q9huIldiXPeLXmQsFwa2J2qWQzDZLjsgG4GOa2jiLR8r2ss5oTTGPlMS+gaYQdaGyK1cSFHXvvyvQIBnTJStDJmxtPJjI0KH03+3UOKnOGV29YdlokLjiXrB4fzg/W/yXVcU3+CkRo3AaXfOAiVEfEXfyD2GGNgUgWwD9Q2r8nq91hxw7BnJRVwLoN/hyw2/gPZgwQL/wN49lt5J5S6nr9ee/FJL6z2Pn05NJ6Z3h9cA/JZYCFP/4VgQ2UERfIe4u+nVcTyr8HQpjJkEEjj3pBsOFIRXiwjTt96mU53FZLXfwOqkiaNHtJvEg8kXrh8ov9+HGr4njV0YJsYGJcxHjJZn7halzH04D4yjRvVdwkBOsyGGh1FHZPVt6rxKgk89hkEp62UlArnh5R8b58xWdCJCZHwpRhmV36Vqx2Q0PJ7zDd6jlqjg/metGI4IvnWAE3kUxIh3Mhy6H8BNZd/afDeAAzJrAhJbLTV61gRGrQ1Ez5k5QPqugCRMPFiH1S5Fs5dkjXO77sw93NzeNgv1vGVY0rfGBo/UkLKao9CQxltDIY+Y/qcy7mJCouG7bo1TpAx73LwetsWtTjmMuPc9Cv98jzVAYkpE12xbUlIPW9jvguwigP1B/8SAmAiS2jRhdB1ZqpUcCWmjVA+oD5EnoDUqDQSv4hwGpWAPm2/QMzQLGLFBI7Y2uHo4Y1klrprYCcp8IssKypoU4YCqbqXyL3MrVy3maV5ca7VupntIYPBOFnhyLxF/YDG4FDfVnJf449m9TRGr5I5/MYrVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(42112799006)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RxBFq2HVVbjeXymxbq7xZn8NVPm17z3Yukks+Dwe6plZ2Y+4ajcsJToo+NHgeh63Mxy3tm+Q+DkLhnHoHBG7YNxwuhLEIVWg4ZLg4KhprrtRz0GS8tdoafvdgP00WS3fPmwV2Ab2e8x61DsMAx6PJYg9ANQ2bE5hShryVx3G0b+umIjeg1BNkRCSkMEAx4xTqtf+9gsXLcaRiS6vQjbHD+b4X8QCpjHm1pXIi+8VVkxG6Q8VDqzRs6Bf3uquC/GzxQL9eM+EPzDJqopwchNuSOQuMD/L+UMCj1gNZez48PSU3BIMyEpokSz2UlPkrys31v3d9Il6HZcEDBIkHMu+F9HQBYiYFW7yJNlUHyT78O2GW5JuxBdstntJ4derDmUqlfRNjPfut88fmmw9/MJiCjR4N7nVbJbEFdFTUdU8tBKznOfTUasa5TZYeOK2kf1k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:44:06.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0029206a-c9cb-431b-f53e-08de996b1d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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



On 2026-04-11 00:35, Srinivasan Shanmugam wrote:
> The Idle State Manager (ISM) uses delayed work to apply display idle
> optimizations later, instead of immediately. This helps avoid rapid idle
> transitions that can hurt power or performance.
> 
> A crash was seen during driver teardown. The system boots normally and
> the driver loads successfully. Later, when the GPU is being stopped,
> the log shows:
> 
>   amdgpu 0000:0e:00.0: finishing device.
>   Workqueue: events_unbound dm_ism_sso_delayed_work_func [amdgpu]
> 
> After this, delayed ISM work still runs and reaches:
> 
>   dm_ism_sso_delayed_work_func()
>     -> amdgpu_dm_ism_commit_event()
>     -> dm_ism_commit_idle_optimization_state()
>     -> dc_allow_idle_optimizations_internal()
> 
> The crash report showed:
>   KASAN: null-ptr-deref in range [0x690-0x697]
> 
> GDB resolved dc_allow_idle_optimizations_internal+0xa6 to:
>   struct dc_state *context = dc->current_state;
> 
> The matching disassembly showed:
>   mov %rdi, %r12
>   mov 0x690(%r12), %r13
> 
> where r12 holds the dc pointer. A GDB layout dump of struct dc also
> showed:
> 
>   /* 1680 | 8 */ struct dc_state *current_state;
> 
> Since 1680 decimal is 0x690, this confirms that current_state is at
> offset 0x690. The crash address (~0x690) shows that the access was:
> 
>   dc + 0x690
> 
> This means dc was NULL at the time of the dereference.
> 
> So the issue is:
> 
>   delayed work runs after dm->dc is cleared during teardown
>   -> dc becomes NULL
>   -> dc->current_state is accessed
>   -> crash
> 
> The current ISM code calls into the DC idle optimization path from the
> delayed work handlers and from amdgpu_dm_ism_commit_event() without
> checking whether dm->dc is still valid. In addition,
> dm_ism_commit_idle_optimization_state() calls
> dc_allow_idle_optimizations(dm->dc, ...) unconditionally.

Hi Sirini, thanks for catching this.

Regarding dc==null, I'd prefer the ISM to throw an ASSERT rather than failing silently,
since the ISM should never run after dc is destroyed. If it does, it should be fixed
as a bug.

In addition, we only need to ASSERT(dc) in amdgpu_dm_ism_commit_event(), as the other
functions (in regards to the ISM) are static and only reachable from
amdgpu_dm_ism_commit_event().

> 
> Also, amdgpu_dm_ism_commit_event() requires dc_lock to be held, but
> amdgpu_dm_ism_disable() calls it without taking that lock.

We're expecting the caller to hold the dc_lock, so maybe an ASSERT(dc_lock) should
also be added in ism_disable() to make that clear. (Only the workqueue workers
need to acquire their own dc_lock)

> 
> Fix this by:
> - checking dm->dc in delayed work paths
> - checking dm->dc in the commit path
> - checking dm->dc before entering the idle optimization path
> - adding a defensive NULL check in
>   dc_allow_idle_optimizations_internal()
> - taking dc_lock in amdgpu_dm_ism_disable() before calling commit
> 
> This prevents delayed ISM work from accessing an invalid dc pointer
> during or after driver teardown.

I was expecting the amdgpu_dm_fini > amdgpu_dm_ism_fini callpath to wait on any remaining
work before destroying dc. But perahps there were additional items queued between
amdgpu_dm_fini and dc_destroy.

Could you give the below diff a try to see if it fixes the npd for you?

- Leo

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 09121152b980a..0d10e048b6754 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2237,8 +2237,6 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
 static void amdgpu_dm_fini(struct amdgpu_device *adev)
 {
 	int i;
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *acrtc;
 
 	if (adev->dm.vblank_control_workqueue) {
 		destroy_workqueue(adev->dm.vblank_control_workqueue);
@@ -2256,11 +2254,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	}
 
 	/* Finalize ISM for each CRTC before dc_destroy() sets dm->dc to NULL */
-	drm_for_each_crtc(crtc, adev_to_drm(adev)) {
-		acrtc = to_amdgpu_crtc(crtc);
-		amdgpu_dm_ism_fini(&acrtc->ism);
-
-	}
+	scoped_guard(mutex, &adev->dm.dc_lock)
+		amdgpu_dm_ism_disable(&adev->dm);
 
 	amdgpu_dm_destroy_drm_device(&adev->dm);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index a3ccb6fdc372e..3baee7aa71a9d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -545,6 +545,8 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 	struct amdgpu_crtc *acrtc;
 	struct amdgpu_dm_ism *ism;
 
+	ASSERT(mutex_is_locked(&dm->dc_lock));
+
 	drm_for_each_crtc(crtc, dm->ddev) {
 		acrtc = to_amdgpu_crtc(crtc);
 		ism = &acrtc->ism;


> 
> Crash signature:
> [22601.113316] KASAN: null-ptr-deref in range [0x0000000000000690-0x0000000000000697]
> [22601.113330] CPU: 4 UID: 0 PID: 46099 Comm: kworker/u97:2 Tainted: G     U     OE       6.19.0-asdn06042026dut #13 PREEMPT(voluntary)
> [22601.113348] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [22601.113357] Hardware name: Gigabyte Technology Co., Ltd. X570S GAMING X/X570S GAMING X, BIOS F7 03/22/2024
> [22601.113368] Workqueue: events_unbound dm_ism_sso_delayed_work_func [amdgpu]
> [22601.113930] RIP: 0010:dc_allow_idle_optimizations_internal+0xa6/0xc40 [amdgpu]
> [22601.114452] Code: 00 00 00 f3 c7 40 08 f3 f3 f3 f3 48 89 f8 48 c1 e8 03 48 c7 45 98 00 00 00 00 48 c7 45 a0 00 00 00 00 48 c7 45 a8 00 00 00 00 <80> 3c 10 00 0f 85 8f 08 00 00 49 8d bc 24 b4 00 00 00 4d 8b ac 24
> [22601.114469] RSP: 0018:ffffc90007857ad8 EFLAGS: 00010216
> [22601.114481] RAX: 00000000000000d2 RBX: 1ffff92000f0af64 RCX: 0000000000000001
> [22601.114491] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000690
> [22601.114500] RBP: ffffc90007857ba8 R08: 0000000000000000 R09: ffff8881a0dc7d30
> [22601.114510] R10: ffff8881c16ca000 R11: ffff8881a0dc6838 R12: 0000000000000000
> [22601.114519] R13: 0000000000000000 R14: ffffc90007857b80 R15: ffff8881a0d80010
> [22601.114529] FS:  0000000000000000(0000) GS:ffff888417dfb000(0000) knlGS:0000000000000000
> [22601.114542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [22601.114549] CR2: 000056558b543b5c CR3: 00000001c0efe000 CR4: 0000000000750ef0
> [22601.114556] PKRU: 55555554
> [22601.114561] Call Trace:
> [22601.114566]  <TASK>
> [22601.114572]  ? srso_alias_return_thunk+0x5/0xfbef5
> [22601.114582]  ? update_load_avg+0x1b6/0x20b0
> [22601.114593]  ? __pfx_dc_allow_idle_optimizations_internal+0x10/0x10 [amdgpu]
> [22601.114932]  ? psi_group_change+0x4ed/0x8d0
> [22601.114942]  dm_ism_commit_idle_optimization_state+0x214/0x570 [amdgpu]
> [22601.115268]  amdgpu_dm_ism_commit_event+0xe1d/0x15a0 [amdgpu]
> [22601.115588]  ? srso_alias_return_thunk+0x5/0xfbef5
> [22601.115595]  ? __kasan_check_write+0x18/0x20
> [22601.115603]  ? srso_alias_return_thunk+0x5/0xfbef5
> [22601.115610]  ? mutex_lock+0x83/0xc0
> [22601.115620]  dm_ism_sso_delayed_work_func+0x64/0x90 [amdgpu]
> [22601.115955]  process_one_work+0x647/0x1030
> [22601.115968]  worker_thread+0x6d6/0xea0
> [22601.115982]  kthread+0x38f/0x800
> [22601.115992]  ? __pfx_worker_thread+0x10/0x10
> [22601.116002]  ? __pfx_kthread+0x10/0x10
> [22601.116011]  ? __pfx_kthread+0x10/0x10
> [22601.116020]  ? srso_alias_return_thunk+0x5/0xfbef5
> [22601.116030]  ? calculate_sigpending+0x88/0xa0
> [22601.116041]  ? __pfx_kthread+0x10/0x10
> [22601.116051]  ret_from_fork+0x4c5/0x5c0
> [22601.116060]  ? __pfx_ret_from_fork+0x10/0x10
> [22601.116067]  ? srso_alias_return_thunk+0x5/0xfbef5
> [22601.116074]  ? __switch_to+0x383/0xd70
> [22601.116082]  ? __pfx_kthread+0x10/0x10
> [22601.116090]  ret_from_fork_asm+0x1a/0x30
> [22601.116100]  </TASK>
> 
> Fixes: 0b572a6bf04a ("drm/amd/display: Add Idle state manager(ISM)")
> Cc: Ray Wu <ray.wu@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 29 +++++++++++++++++--
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  7 ++++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index a3ccb6fdc372..7e7b3cac80bb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -272,6 +272,13 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
>  	struct amdgpu_display_manager *dm = &adev->dm;
>  	int r;
>  
> +	/*
> +	 * Delayed work can race with DM teardown. Do not enter the
> +	 * DC idle optimization path after dm->dc has been cleared.
> +	 */
> +	if (!dm->dc)
> +		return;
> +
>  	trace_amdgpu_dm_ism_commit(dm->active_vblank_irq_count,
>  				   vblank_enabled,
>  				   allow_panel_sso);
> @@ -472,6 +479,13 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
>  	/* ISM transitions must be called with mutex acquired */
>  	ASSERT(mutex_is_locked(&dm->dc_lock));
>  
> +	/*
> +	 * DM teardown may already have cleared the DC object while
> +	 * delayed work is unwinding.
> +	 */
> +	if (!dm->dc)
> +		return;
> +
>  	if (!acrtc_state) {
>  		trace_amdgpu_dm_ism_event(acrtc->crtc_id, "NO_STATE",
>  					  "NO_STATE", "N/A");
> @@ -514,6 +528,9 @@ static void dm_ism_delayed_work_func(struct work_struct *work)
>  
>  	guard(mutex)(&dm->dc_lock);
>  
> +	if (!dm->dc)
> +		return;
> +
>  	amdgpu_dm_ism_commit_event(ism, DM_ISM_EVENT_TIMER_ELAPSED);
>  }
>  
> @@ -527,6 +544,9 @@ static void dm_ism_sso_delayed_work_func(struct work_struct *work)
>  
>  	guard(mutex)(&dm->dc_lock);
>  
> +	if (!dm->dc)
> +		return;
> +
>  	amdgpu_dm_ism_commit_event(ism, DM_ISM_EVENT_SSO_TIMER_ELAPSED);
>  }
>  
> @@ -557,8 +577,13 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
>  		 * When disabled, leave in FULL_POWER_RUNNING state.
>  		 * EXIT_IDLE will not queue any work
>  		 */
> -		amdgpu_dm_ism_commit_event(ism,
> -					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
> +		{
> +			guard(mutex)(&dm->dc_lock);
> +
> +			if (dm->dc)
> +				amdgpu_dm_ism_commit_event(ism,
> +							   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
> +		}
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 63f51c69919b..f92007342a31 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -5770,7 +5770,12 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
>  	int idle_fclk_khz = 0, idle_dramclk_khz = 0, i = 0;
>  	enum mall_stream_type subvp_pipe_type[MAX_PIPES] = {0};
>  	struct pipe_ctx *pipe = NULL;
> -	struct dc_state *context = dc->current_state;
> +	struct dc_state *context;
> +
> +	if (!dc)
> +		return;
> +
> +	context = dc->current_state;
>  
>  	if (dc->debug.disable_idle_power_optimizations) {
>  		DC_LOG_DEBUG("%s: disabled\n", __func__);

