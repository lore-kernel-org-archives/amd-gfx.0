Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ED8104BEDB
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 10:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0982B10E88A;
	Wed, 11 Mar 2026 10:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="eZaCsP13";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E5FF10E88A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 10:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1773225497; bh=r3OFWgRDu/cLflUfNzKahbam4+HNBHy/vduhEUFLSCc=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=eZaCsP13da9EdYNG466EeCtyfmOStND5Y1DEfXtgrk9T63RfPg8UFU8Pg84DDKYwF
 Rs50VqjEpm0J55DkiUuLMnk1ZwUASj5ClToM+QRILZp9EANBLcGERJkcmjg9YVwAlF
 7FpH8IEhRQEG0pCXrh2/lJ570GdkmZ6zz8d0MzvnpD8LKDPdFAyUBk0ZgWcbebiO8B
 amA0lYGCv176OJ9VYVF4SKTMgYGkXmA+/QRSEg+4/XhyjV9AndHqNPYCTNM+IvpsRc
 MYEdSbAPR488rn9oCKnIjpkZMCTjT8jcWI3QfyxUIJWi3kk4ST8d91Nat4wgTAY8zj
 RIgvc1NYWfetg==
Message-ID: <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
Date: Wed, 11 Mar 2026 11:38:16 +0100
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
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
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

On 3/11/26 00:50, Leo Li wrote:
> 
> Hi Michele, no dm_pflip_high_irq firing makes sense, since there's no new fb
> addresses being programmed on CRTC 0 due to the timeout.
> 
> Did you see any dm_crtc_high_irq() or dm_vupdate_high_irq() on crtc0 after the
> timeout? An easy way to check would be to enable DRM vblank debug once you hit
> the flip_done timeout. The drm_dbg_vbl prints will start outputting to dmesg:
> 
>      echo 0x20 > /sys/module/drm/parameters/debug
> 
> I'm also curious what the acrtc->event and ->pflip_status end up being when the
> timeout is hit. This debug diff should dump that without masking the issue:
> https://pastebin.com/u7hGR7L4
> 
> Thanks,
> Leo


Applied your debug diff on clean v6.19, reproduced with bpftrace running 
(dm_crtc_high_irq and dm_vupdate_high_irq probes added).

dmesg:

[drm] *ERROR* [CRTC:283:crtc-0] flip_done timed out
[flip_done timeout] crtc-0 event 00000000baf6917e status 0
[flip_done timeout] crtc-1 event 0000000000000000 status 0
[flip_done timeout] crtc-2 event 0000000000000000 status 0
[flip_done timeout] crtc-3 event 0000000000000000 status 0

crtc-0 has a non-NULL event with pflip_status=0 (AMDGPU_FLIP_NONE).
Note: %p hashes the pointer so can't directly correlate with the 
bpftrace output.

bpftrace:

8301644  dm_pflip_high_irq [tid=0]
8301644  DELIVER event=ffff8b87186d5a80 crtc=0 [tid=0]
8301644  WAIT_FLIP EXIT 1ms [tid=36993]
8301649  ARM cursor event=ffff8b87186d5480 acrtc=ffff8b84958f7000 [tid=176]
8301649  commit_hw_done [tid=176]
8301649  WAIT_FLIP ENTER [tid=176]
            ...
            10252ms, CRTC 1 continues normally
            ...
8311902  WAIT_FLIP !!!TIMEOUT!!! waited 10252ms [tid=176]
Between the ARM cursor at 8301649 and the TIMEOUT at 8311902:

692 dm_crtc_high_irq fired, all on CRTC 1 (zero DELIVER with crtc=0 in 
the window)
0 DELIVER for event ffff8b87186d5480
0 ARM or DELIVER referencing acrtc ffff8b84958f7000 (CRTC 0)
drm_vblank_disable_and_save continued firing (on CRTC 1)
no dm_vupdate_high_irq fired at all during the entire trace
acrtc ffff8b84958f7000 = CRTC 0

If this is not enough i can retry to have the proper correlation using %px
