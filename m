Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE7AEB3637
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 22:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741BD10E092;
	Mon,  2 Mar 2026 22:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+Yd6KL/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0762810E092
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 22:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1MvX0aQ3NPSdDLKLWB7wf5nsua4I7uVZWvJ9m/jgCN097BAsHlpvkXxz5jjBbwzMadmsqhmqIfFJ9ObPof5DF/oouOXp1dd/ygQWEXqBqdDJUdjv9NIR3MFLxSM0G9yrQq6GjAAtMgF1VYaSo6Xmog2YoQmxbQqGH3/sBsRxn0y/yICchdonzddpYfvj53EnSsAsC3wyZ03IrTwxMnz017nVG9LTDEIe1t5RSa5VVSMR2TwKu10Td4b95nmpc9cBP8w4zUBFXMOBwfSak4iIkwgqjOrgs52AwWAx3LnFh+BNQNMiP/WuIq7bgeJVGgdfRiAJv6z/H4VB9MPsLFRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNc3mE85vcCXwQpAsWj8XAC4DCJu76pz13zEA/VGkA0=;
 b=ybYixGlh3+piSO7UDmPumrqxIPE37uyapvJUJ9KHWM9tByweqQREvHTXi5f4R1Y7/CZhfF5V3ixYHxg03U8dJXXBWGsKlLs/LLqF0Cn6HtKOUmZLSIP/tvfYBEWndNknJQOI+LgEnls7BUal6YYwW4UyRIh0RGLv8TRt8poz9QebSu7QTByKyBsELUtYK4YH9KeDT6yA8gyROHzrUCLn0Nb7+ERTT841T7o78fK569fo0OLtQDy6tOrIR8gHob6utWEKMXzLxuWOaKPrUzGRQezz8c3uvFO1m4C6l9PXdWL3Uvyrg98Qjf66WFGxYO4ugPJsC/pp2gmEVMj9r7cufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNc3mE85vcCXwQpAsWj8XAC4DCJu76pz13zEA/VGkA0=;
 b=u+Yd6KL/7pnwIqgv3JVob9U5nTK9wfzxv4O4syQH1uBbIAGyJAn7ZRkCQ4KVgTWH+YjCiZClw/+FfN9j0hI3/7jyDHueMIXavgve/R0lG4EwRnUoYvz1frXJGAeN1e9U5eOh57bGYlnc2XT9NlG9yuyPVJ2QsS7ZV8QITOFFz5g=
Received: from PH8P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::14)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 22:13:18 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::a9) by PH8P220CA0042.outlook.office365.com
 (2603:10b6:510:2d9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 22:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 22:13:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 2 Mar
 2026 16:13:17 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Mar
 2026 16:13:17 -0600
Received: from [10.254.95.21] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Mar 2026 16:13:16 -0600
Message-ID: <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
Date: Mon, 2 Mar 2026 17:13:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>, <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <siqueira@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: ceba6a62-595d-4ba0-4cee-08de78a8e81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: yeRHbQaIwfCXyC2EfzNxBMFD6CZPkTbkNvu+W4YikfSC/BQW/DsHhkHoibsJxUVTLLgFvYoSZ8lcQ4zEXKL6HVSyH15YqMmGwxEEBD1bzakET1O6tli944NeTWmqu/52TWklqNL5DnwkLFynB+V3x72ugnzuWayYdPf1U4vDDE3uQggxiJeEWI45PmeSHe3tPhGIdYxnai0RDdnByjH9f9D39KLb6HpWCaxNiDOj43SK1vLnBi0IcBX1f+QIfx7YVJYfD4FZ3To15/Elk9n6BCBq7XDUMZRlWSHVsQz2Kko69fzS5ZDHj+zR79mTk3CHHGk1xD7emeKV8caDaJswSo6Y0RXf9KnQ5HLaPnbMcvC+sZzx7nWHRVciwc7X022hscPejfJkWBdobWbsfvxQZF4QKdiu9tlbDbQU4UwoFxhDANNbtfUBQVV9dtav5+xDwEXw3Goz6Hk2/yIZsbEwiVm0PwEq2VD7mZpj3mTOOXM2uudKIZ9CZvbNNCTDEniXq4y2aC/tDO2vI+mXU0P8vrOW0cNLIU0D7JlhaRQuGmwbB4mbv6+TisNGQu1usQoPZ3HdyCwcdTTe0xR9xKpCbJ4wLvk30av5MU7OSDkxbQ4OaQ9vpRq/X/Q6NZ+ZuBXyi7WXAmxlDpUznQnMMOG6dQqc1UguF8pUMJrt6bKVqzng0gE4XlanVfDKHHENkSoih6KbsGNiTRtKK/yYrJ1SJZdyKel2i2a0K1pZMwwCc5+p/YATuybIWqZy1l5s2OHv4GlUEqFHtpxT0iX+AIjEKy6PVvFoPoIo/u1RsniopY/ZBV2YluLs6w17SWZBZ23iC5bLZeDDbDovgzmgFT0y1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FSRrozpR51DunrnbkzXNzWYYfwiL0yhfwzdf7/snQ5y39xy5FJHSR+qZFydd0+5/zvbZEHGf2GQBHC11hg+70vkidg0B4veWEDpakGdsjdgJWlohjxG8JkI8HW+ONsVNkqDuJgPnNhEeV2c9YCcr9kI5SvLo2cKf1Kt5nxn0Kmx2YqlIcaLOCgWa+ut26tTHs9fRlzgliYZ5ZN9WBVQnM6R6xQ3n0pkfiiqnkOMWIFlRH44pKFBSV9qxhtciHSma9w2lL104ggM37eyLzWTc4rg3bTJDLcsgwSyKlhXVvdqyuoJAXa48Php3aVM7KgAT26eD2qJxjwoMfUaFRtoJz9MDiwvJPSVUAAQAOhH/K+NvQvQ3OMoaNiJ5GL+QSWZaf6uiYCrFsfYsFd1qgxXCg1UqHg62lTRlHy+r7eRvBdas4zFjLSK4YzP2NQqfLD6o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 22:13:17.6531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceba6a62-595d-4ba0-4cee-08de78a8e81c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
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



On 2026-02-27 03:58, Michele Palazzi wrote:
> On 2/27/26 09:53, Michele Palazzi wrote:
>> On 2/23/26 16:27, Leo Li wrote:
>>>
>>> Really nice debuging work, thanks for catching this!
>>>
>>> Ideally, the cursor event should be delivered when hardware latches onto the new
>>> cursor info and starts scanning it out. The latching event fires an interrupt
>>> that should be handled by dm_crtc_high_irq().
>>>
>>> dm_pflip_high_irq() handles an interrupt specifically for when hardware latches
>>> onto a new fb address; I don't think it actually fires when there's a
>>> cursor-only update. I think if we really want to do it right, we can have
>>> another "acrtc_attach->cursor_event" just for cusror-only updates, and deliver
>>> the event in crtc_high_irq().
>>>
>>> In any case, I don't foresee any major issues with delivering the event early.
>>> And since it fixes an ongoing issue:
>>>
>>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>>>
>>> Thanks!
>>> Leo
>>
>> Thanks for the review. Further testing confirms that both this patch and increasing the dGPU vblank offdelay (from 2 frames to ~50 frames) independently eliminate the flip timeouts in my testing. Both work by reducing the frequency of vblank disable/re-enable cycles, basically either could be an interim fix.
>>
>> Your deferred vblank enable/disable series https://lore.kernel.org/amd- gfx/20260224212639.390768-1-sunpeng.li@amd.com/T/#t looks like it could be the proper solution going forward instead (haven't tested it).
>>

Looking at this a bit more, I'm not sure if we're understanding the trace
correctly.

Let's first assume the cursor update is not an legacy_cursor_update: In both
non-blocking and blocking atomic commits, there should be mechanisms in place
that limits the number of in-flight atomic_commit_tail()s per crtc to 1 (see
drm_atomic_helper_wait_for_dependencies()). IOW, After each independent cursor
**or** fb update, there should be one flip_done completion from
drm_crtc_send_vblank_event(), before the next update is allowed to continue.
Since the event is "armed" as part of atomic_commit_tail(), and "completed" in
either pflip_high_irq or crtc_high_irq, racing "arms" of acrtc->event should not
be possible.

A combined cursor **and** flip update should use a single event and flip_done
completion, since it's one atomic_commit_tail to update both.

Now if it is a legacy_cursor_update, DRM core first checks if the driver can
commit it asynchronously, and set state->async_update=true if it can. If
async_update==true, drm_atomic_helper_commit() skips setting up the event
entirely. Otherwise, drm_atomic_helper_setup_commit() will check if
legacy_cursor_update==true. If it is, it completes flip_done early *and* skips
setting up the event. So either way, there's no event to send, nor flip_done to
wait on.

But evidently in the trace, something awry is going on. Though I'm not sure if
it's because of the race condition as described. It would be interesting to
trace the events at the point that they're created, armed, then completed, and
see if there's some mismatch going on.

Here's a patch that inserts a few trace events.
https://pastebin.com/dpLnVSbu

Could you try to reproduce the hang again while recording these trace events?
Using trace-cmd (with stack trace enabled '-T'):

    trace-cmd record -e amdgpu_dm_event_arm -e drm_vblank_dbg* -T
    trace-cmd report trace.dat

The timeout can be found by searching 'remaining_wait_ms=0'.

Regarding the deferred vblank patchset, if the issue is indeed racing writes of
amdgpu_crtc->event, then I don't imagine that patchset would help. It's
intended to solve a different race.

Thanks,
Leo 


> 
> fixed siqueira@igalia.com cc

