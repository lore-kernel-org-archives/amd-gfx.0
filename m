Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE6F0180A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F75D10E3C7;
	Fri,  6 Mar 2026 08:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="o7LJexqE";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C28810E3BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1772786279; bh=gRMn4FBWQbryR85Nj/powRyobU07gtp86A0sKteMVQA=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=o7LJexqEA/gHZZRo1iIkSF7agRfggNt21ThLue7AnwAQXhwXXlS7jNP2Zw9EGx5jS
 BTtTv1jmVp+fnDYpz+0g7Ph5AU+M0cdiEeGKGFzIHUyfTRtXQHLzn/skbDXQcUEFhl
 2Ch0KSi5YS6BSiQ85EqqW0Vti09DsJtxzVc/rrfq8Mw7/kujleuo6piAXORF2mLnsw
 Gex+j4zkYnOv70DmA1NtwlK1OmGRibB4REVjm0G8jlYPYhzqCe4maC70OEKjB1qMdy
 bufjf5brXVGjBvju3Cmbfk1el5OkIc68ftgHqVTTZjmMaTyJGp+gd8i9HGBdQCYeSf
 qqQSS6nPP1Otg==
Message-ID: <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
Date: Fri, 6 Mar 2026 09:37:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
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
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
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

On 3/5/26 23:30, Leo Li wrote:
> 
> 
> On 2026-03-04 09:20, Leo Li wrote:
>>> So far i could not reproduce with your tracing patch applied, i could try to use bpftrace instead but it will take some time, i am quite busy these days.
>> Understood. If you haven't tried already, maybe dropping the stack trace (-T) flag is worth a shot.
>> - Leo
> 
> Hi Michele,
> 
> Since this issue is fairly widespread, and we're heading towards *a* fix,
> I sent a reworked version of this where we save cursor-only vblank events
> in a separate member in struct amdgpu_crtc, and deliver it in
> amdgpu_dm_crtc_handle_vblank():
> 
> https://lore.kernel.org/amd-gfx/20260305222131.160914-1-sunpeng.li@amd.com/
> 
> Let me know if you get a chance to try it out! I'll also add your
> Co-developed-by when merging -- I forgot to add it when sending it out.
> 
> - Leo

Reproduced today with a minimal bpftrace active but prepare_flip_isr is 
inlined by the compiler so was unable to track the event ARM side (stil 
have to try the offset approach)

Trace around the timeout:

142642747  commit_hw_done [tid=778834]
142642747  WAIT_FLIP ENTER [tid=778834]
   10279ms silence for tid=778834 on CRTC 0
   CRTC 1 continues normally throughout
142653026  WAIT_FLIP TIMEOUT waited 10278ms [tid=778834]


No dm_pflip_high_irq or DELIVER for that specific commit. CRTC 1 kept 
flowing normally the entire time.

Your new patch is an approach i already tried, and in my previous 
testing i still had flip timeouts, so while i think separating the 
cursor events makes sense and is correct, the root cause could be 
different from what i initially assumed and sending the cursor events 
immediately was masking it by relieving pressure.
