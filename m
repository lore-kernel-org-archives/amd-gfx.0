Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9B6F41807
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 16:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382F510E55F;
	Mon,  9 Mar 2026 16:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="c57Pob76";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A7B10E55F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1773074981; bh=74B3NzFQv+A4w8+1UiNG2mHF+Tm88not012t3gStCtM=;
 h=Subject:From:To:Cc:References:In-Reply-To;
 b=c57Pob76Blqog59T8QvqSJUCYrPu5iQLuETg7+6Zk19A0kro+6o87AZdMahfxck5r
 FARhiWK43v/+yi6TrThJ5W/ukzczniQF2TdEiIOiBOYV4wKtM9BoG4PrRCEFq7wv/6
 oC4hBOTL3/ksQ8Qy3Tn8sRdtaBvwK1pO1GvWHULtWa7PWo5XFWkabSds1QaRW9+7/U
 LKMzoClh0JN56EjLFgeX3gNhuMfhCSSs0/BMdktJRpCcrFICm6EyxfjCuCVppsCcRW
 EgBOldG7Mtgk4kYfP5mEUhRHE3sZk/jjc6puVe7ikzKTPSjHuFfF2v0LfAdb6jJSNd
 h+B6zli46SK6g==
Message-ID: <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
Date: Mon, 9 Mar 2026 17:49:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
From: Michele Palazzi <sysdadmin@m1k.cloud>
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
Content-Language: en-US
In-Reply-To: <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/6/26 09:37, Michele Palazzi wrote:
> 
> Your new patch is an approach i already tried, and in my previous 
> testing i still had flip timeouts, so while i think separating the 
> cursor events makes sense and is correct, the root cause could be 
> different from what i initially assumed and sending the cursor events 
> immediately was masking it by relieving pressure.

Leo i finally reproduced with a bpftrace that tracks event ARM (flip vs 
cursor) and DELIVER using kprobe offsets into the inlined prepare_flip_isr.

The hung commit is a cursor-only update on CRTC 0:

31088420  dm_pflip_high_irq [tid=0]
31088420  DELIVER event=ffff8b519225c580 crtc=0 [tid=0]
31088420  WAIT_FLIP EXIT 2ms [tid=203071]
31088421  ARM flip event=ffff8b4f26184c00 acrtc=ffff8b4ed1ddd000 
[tid=203071]
31088421  commit_hw_done [tid=203071]
31088421  WAIT_FLIP ENTER [tid=203071]
31088422  dm_pflip_high_irq [tid=0]
31088422  DELIVER event=ffff8b4f26184c00 crtc=1 [tid=0]
31088422  WAIT_FLIP EXIT 1ms [tid=203071]
31088425  ARM cursor event=ffff8b519225ce00 acrtc=ffff8b4ed1dde000 
[tid=203071]
31088425  commit_hw_done [tid=203071]
31088425  WAIT_FLIP ENTER [tid=203071]
31088428  ARM flip event=ffff8b4f26184480 acrtc=ffff8b4ed1ddd000 
[tid=208580]
31088428  commit_hw_done [tid=208580]
31088428  WAIT_FLIP ENTER [tid=208580]
31088429  dm_pflip_high_irq [tid=0]
31088429  DELIVER event=ffff8b4f26184480 crtc=1 [tid=0]
31088429  WAIT_FLIP EXIT 1ms [tid=208580]
            ...
            10036ms silence for tid=203071
            no dm_pflip_high_irq, no DELIVER, no 
drm_vblank_disable_and_save on CRTC 0
            CRTC 1 continues normally throughout
            ...
31098462  WAIT_FLIP !!!TIMEOUT!!! waited 10036ms [tid=203071]
acrtc ffff8b4ed1dde000 = CRTC 0 (confirmed from ARM+DELIVER correlation) 
acrtc ffff8b4ed1ddd000 = CRTC 1

Event ffff8b519225ce00 was armed as cursor on CRTC 0 and never 
delivered. No dm_pflip_high_irq fired for CRTC 0 during the entire 10s 
wait, and vblank was not disabled (no drm_vblank_disable_and_save in 
that window). CRTC 1 kept flowing normally throughout.

The complete bpftrace is here https://pastebin.com/Xiju44Cy
Note that i did this on tag v6.19


