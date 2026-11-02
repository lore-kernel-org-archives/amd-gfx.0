Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437F606A32D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2P8ZK2r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5DE10EEFD;
	Mon,  2 Nov 2026 14:16:03 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D73A10ED97
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 12:37:43 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a56e05568aso12563285e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 04:37:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793623061; cv=none;
 d=google.com; s=arc-20260327;
 b=YD14tXLyOYKUjexyCOGf6dkkztEOTEZCUKeQ7I+kt0i3sZc9YOSNbazajWljxrdE3C
 5+sD6O6DbPbf2lssgJLow5p4yuZrb+fe1BnDvA3XSuvk3pLUJL+DlfxpZ34BD0toB3Dw
 1oZvt5c/Z5oGK+HxhcnewK32K1Qf+k4cmQxcWhvm6dXewh0QbmIZFiNnuXxBIfG3krhk
 gkwsDeUu08T8KSTCdaIX9GxkgZi3aqIA9mZXczUtRJXBI0nF4+t1SmeZ5ZOeBDbGD+Lu
 w4x8Qh17YlP+OIQ/KpjwsK96/b7C9Wa34Wi0G5AanntJd3II7aMnVzBvAj+b4jjgj+lq
 iFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P9Xe5ApGw7AVptOI+b4XC9GSYWhLs3jwBpvKf/2EdnM=;
 fh=y417zpNOsOh+m0otZZgofsLK7wQZkKaRvNPr6IG0q3c=;
 b=swaO2FLOg3L9+xA3nSvHib5seRirMMsuO9CUTHcgyGnBJB+HGJwnNUo0KkqEEgK5hs
 x7PWs5D1oFmtxT5UlM8lAAdJUOR3RNoctQxnqkb9cGfJOsoI8gAz1nmd8m0XpgV5gbXO
 DRJgIQy2Nw+UQBrNiRXpsnW5qTq88QI8C2pxRnofGPeV9V6C+SwL94yu4NdozNT1lC4e
 RoG97yGfqsTBllVL6jUFUBGDauAaLMhNqkSpaWD1BlG2ODbrfRDEd27RUfmYMsQ7P6y6
 8cSCENxx9v9B2HfZ/gohhys2+//rZuTKb8rgDPyTm2tsLtn/AAZUw3hvxy1vjl0Zs5iu
 mxBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793623061; x=1794227861; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P9Xe5ApGw7AVptOI+b4XC9GSYWhLs3jwBpvKf/2EdnM=;
 b=Q2P8ZK2rIrPwhhE5lCBeZs1v3FZCPmGE3D5ZdYvy19dcbb5C01H60vX62SqzKA4prS
 c+tRLA4Z8cRpcz6h/zUSEhJnjszOQBoGhAe3fh1LNqXp4IVhIAdzrAS/e4bRrNlrtN4h
 v1hxEUJ8lgsdCcsomxZ9ZyI68rx+NrJOWbMEKwGQ/JcVo4Rv2zYM7eM5VgoiwTsGPt1A
 iDUMvKSdS5xWqS77MDMAeRRW2RkpZpHNTp3W7JAvWhzrEXDRoZk8GZ/KyfZ0IxJIbkeb
 QgsYZTFAF8UGQbL6+Vt6WxgR5a/ZGeBkXgTjAPxkTzzQemcdp/ThgqmxkwrkvbQDbDg6
 Yd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793623061; x=1794227861;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P9Xe5ApGw7AVptOI+b4XC9GSYWhLs3jwBpvKf/2EdnM=;
 b=TRV8VXb2ZGL0t9w/7gFjGpOccS4NI78rgBbvS5m124k3DXKfDRK6nTG5q/f1trp5Az
 lWymQ2LvVH5BVpM1S1mWOhJ2L+MI8zwo3mI1z1vppQ/Jb7vsoX99sVdJmbhH8juWc+i8
 C2tqGUomaIt6w8Y5mmSJ6Bhy6NrbLYGuba3VhPXonV6PvdIQhf74I9i4Tt14kykiu+p3
 RfCzcwDBrHj3ClPFpS0D6XetFKy6rrEU2QKhx07nyHxD2JgV7aCZKIz5XWknJ816KG7W
 d7Jeir1PDU/NK7HYiPMWLkIXjiDfiQvm0qtD8wxnKKFDxYP9zU4naH6hl925KjEIWLKj
 EW0w==
X-Forwarded-Encrypted: i=1;
 AKwUvByyCVOiHQsQpThjNKZxpgLA4PF0rFjGSghLOIQoUwyj2gXGI3TGTUyi4edHef98JwQDApOuA3NY@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Q8jCT/apJ96SaoUCaxkNMFo/SCl56aX8PNYBlZ/oFLF5lldN2
 yGzDQhNDGDrHUGkn6N0/PJH59fFVUgpjherMfyGAg3TqrP/7ri09qHmiVQZaTbuHMyUB0ryIqDn
 rySxz/xbjdU1JJLe1/WEurPcrXlo6ZhI=
X-Gm-Gg: AYBFou3P6o+rsGnqPaDUenTLszqgjneF6lEHFbkY7st8i8W+HjHm1DJAaxHrclNKLYW
 VdxPnk5noAH4wKU8i2jyCX5JJzifVFnIY/26KeWpzE1XytpBtMueE3FGUCGw5Oj9utJkyANEnuC
 qIEZsV4vuO+ERI1uHLeKD3bepyNO7ZHj1DnvmKT9mvb3YKqPFwh54pxTgQNzk6ZAOv1uX0F/6Ii
 FlD/eT+BmLDZyJq+/PpSpBLUv9Kky7t9xI0bhVaoZ7U0/004xB/oFnlb7hmiuiCuQizxgGvqkzY
 AfwDjnysA8jnUlPqnRfFRGVqlE39jupnG4UDIp5MIEJkOD4nF1767Mv/YesrWeHWNSYZs4dMUMH
 xVLISpfXB54nS6/d31KTHib1tYToIVgj+mFwyAHUxTGaGPurs2LQU5CVeOSuktvhpF7h91nSwYy
 Uh/9xhjk904DQN0Rc=
X-Received: by 2002:adf:e708:0:b0:48a:f41d:83c with SMTP id
 ffacd0b85a97d-48e6e262d4amr20344295f8f.0.1793623061185; Mon, 02 Nov 2026
 04:37:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CACOV87VBmya0PKjni5xEYxUaEczk9X_UoUHXSR_HDS2kSJnM2g@mail.gmail.com>
 <00da317f-ec33-4084-a48a-1a6b4e10dfc8@leemhuis.info>
In-Reply-To: <00da317f-ec33-4084-a48a-1a6b4e10dfc8@leemhuis.info>
From: Nathan Blomquist <nblomquist@gmail.com>
Date: Mon, 2 Nov 2026 07:37:30 -0500
X-Gm-Features: AclHuK-Bb80BdPxE_BV90SywTLD5EIBW_cZcuIJ-QheO2IIocit-nkZxgYaYNVg
Message-ID: <CACOV87VsAxi_xY2Zghysv7hjqL8ppmpaut7S0JEnDHvH8HuKEQ@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: Navi 23 passthrough fails after ef5fcf2a6c32
To: regressions@leemhuis.info, amd-gfx@lists.freedesktop.org
Cc: regressions@lists.linux.dev, alexander.deucher@amd.com, 
 christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Nov 2026 14:15:56 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thorsten,

On Mon, Nov 2, 2026, Thorsten Leemhuis wrote:
> Have you tried if 7.3 is affected as well? You also might want to check
> if 7.4-rc1 might have fixed it.

Thanks for pointing this out. The original regression reproduces on
unmodified upstream 7.3.1. I also attempted 7.4-rc1, but an earlier host
GPU initialization failure prevented testing the handoff.

For 7.3.1, I used the signed kernel.org release source, corresponding
to commit:

    79a907609d53d5cd645b42c11550d295d43abf99

The trace shows BACO supported=1 but enabled=0, followed by
amdgpu_device_baco_exit() returning -524 without ULPS re-arming. Both
functions subsequently undergo VFIO D3/resume and have valid PCI IDs
immediately before secondary-bus reset, but both read 0xffffffff
afterward and the reset helper returns -25.

This happens with all guest CPUs held at their reset vectors. The
trace contains 9,716 events with no lost events or missed probes;
kernel taint remains zero throughout.

For 7.4-rc1, I built Linus's signed tag at:

    6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

That attempt failed during host GPU initialization:

    AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
address=0xffa00000 flags=0x0007]
    PSP load kdb failed!
    PSP firmware loading failed
    hw_init of IP block <psp> failed -22
    Fatal error during GPU init

Failed-probe cleanup then emitted amdgpu_irq_put() warnings, leaving
taint 512/W. I stopped before starting the VM, so this attempt is
inconclusive for the original handoff regression. I have not established
the cause or repeatability of this initialization failure.

Neither build included downstream patches, my candidate correction,
reset-timing changes, or external modules. Userspace, firmware and guest
configuration were held fixed between the attempts. Configs and logs
are available.

Is the 7.4-rc1 initialization failure a known issue, or should I report
it separately?

Thanks,
Nathan



On Mon, 2 Nov 2026 10:01:54 +0100, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
> On 11/1/26 21:05, Nathan Blomquist wrote:
> >
> > I can reproduce a Navi 23 / RX 6600 (1002:73ff) passthrough failure on
> > unmodified upstream Linux 7.2.10. It happens during the amdgpu-to-VFIO
> > handoff, before any guest code runs.
> >
> > Revert/add-back tests on Proxmox kernels isolate ef5fcf2a6c32
> > ("drm/amdgpu: fix autosuspend cleanup during removal") as the trigger.
> > Removing its added call from -20 works; adding it to working -19 fails.
> > [...]
>
> ef5fcf2a6c32 is a 7.3 commit, but you only specify that 7.2.y is
> affected, which might be caused by a failed backport. And 7.2.y is EOL,
> so it won't be fixed anyway. Hence:
>
> Have you tried if 7.3 is affected as well? You also might want to check
> if 7.4-rc1 might have fixed it.
>
> Ciao, Thorsten
