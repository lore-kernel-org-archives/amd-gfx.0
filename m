Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625CDC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 22:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA33322403
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 22:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tr5vPjWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA33322403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3806E8D6;
	Tue,  3 Nov 2020 22:58:00 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5306E8D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 22:57:59 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id h6so14893609pgk.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 14:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p1h/LKIjKhwCaZN5JW6lQr8X/bwNTpcCZCyLALzsZSg=;
 b=tr5vPjWUjAouhWvPxTC7MBVgGO79ny7u55kLEr8RCRj6bxH1t3gSkiC71IMTkzC2Uq
 tewnvHi/iikOF9VEI0TnR6StnqdbjbcTMYc6+bRCLaFZGXkz4lp/gubVHAELLmPwekr7
 BapanDlC20YtC+zgNpcKEiddgqI3Ntl0Ls3ZK5Syh2j22luIaJbsj1n0Uqzu0HPkpUPt
 O0Pb9O+WEsZTY/rpInmKULg+gW42UB3akBmakChPrjkaO2R6R4dUk4LKibSeEkN7M48u
 9pptgIOUotK2/wmU0/izcuCDPjwnCTvHUgEX3lwdm/fQMdUMM4mb3ZNR+cZV0CP1Bxnr
 wD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p1h/LKIjKhwCaZN5JW6lQr8X/bwNTpcCZCyLALzsZSg=;
 b=gpwUWZZCpudRvW2ULnYo4jMfizBjj5duEKLvcdrHHax4he74DgzrWZLEtTBfffDM7g
 CCPefa/PEBXNyTJtVFntatDt2/VToOwmrgAESCegvrOSfY2u/v+HvwOF4cAf9FjuIs9O
 EXVG/GJs9h7Uz55o8PefqgGVwUcRwcikQ4E7nT8KMxVlFIJT/Eh6oHyDT3pYTXgQNHtz
 o93DyJpzlLq/ZZaWnAL/Gf6UBZqQMG6+kkxOnjPBvYFpiOkcCSfVfc+FIDDH56nZUPp7
 VB4s5E/5ZXQyR8lL423/TS/4MJ9ujIcC/YqgOi+11QGgGwBkR9hgTP9o51DqzRZv5ZDP
 63Nw==
X-Gm-Message-State: AOAM5314Bz05VVjsKlCaewGITB6cGWOHo/lUEunqv8QJoI/pTLTY/jFL
 D7KsV+VXVaaLrmClzQd9nfc2BxYUesGDZ55LqfU=
X-Google-Smtp-Source: ABdhPJwkXme79PXXaAAJZqprDS/IXxVAL1qJl21a7ycKClcO4oEFYkx0WsiNs9Cv6sHUdW9jMxDhxoZdQCzEH6J6Q4E=
X-Received: by 2002:a63:fb11:: with SMTP id o17mr19448546pgh.109.1604444279120; 
 Tue, 03 Nov 2020 14:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20201007152355.2446741-1-Kenny.Ho@amd.com>
 <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
 <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
 <CAADnVQKuoZDB-Xga5STHdGSxvSP=B6jQ40kLdpL1u+J98bv65A@mail.gmail.com>
 <CAOWid-czZphRz6Y-H3OcObKCH=bLLC3=bOZaSB-6YBE56+Qzrg@mail.gmail.com>
 <20201103210418.q7hddyl7rvdplike@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201103210418.q7hddyl7rvdplike@ast-mbp.dhcp.thefacebook.com>
From: Kenny Ho <y2kenny@gmail.com>
Date: Tue, 3 Nov 2020 17:57:47 -0500
Message-ID: <CAOWid-djQ_NRfCbOTnZQ-A8Pr7jMP7KuZEJDSsvzWkdw7qc=yA@mail.gmail.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Kenny Ho <Kenny.Ho@amd.com>,
 "open list:CONTROL GROUP \(CGROUP\)" <cgroups@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Network Development <netdev@vger.kernel.org>, KP Singh <kpsingh@chromium.org>,
 Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 3, 2020 at 4:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 03, 2020 at 02:19:22PM -0500, Kenny Ho wrote:
> > On Tue, Nov 3, 2020 at 12:43 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Mon, Nov 2, 2020 at 9:39 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> Sounds like either bpf_lsm needs to be made aware of cgv2 (which would
> be a great thing to have regardless) or cgroup-bpf needs a drm/gpu specific hook.
> I think generic ioctl hook is too broad for this use case.
> I suspect drm/gpu internal state would be easier to access inside
> bpf program if the hook is next to gpu/drm. At ioctl level there is 'file'.
> It's probably too abstract for the things you want to do.
> Like how VRAM/shader/etc can be accessed through file?
> Probably possible through a bunch of lookups and dereferences, but
> if the hook is custom to GPU that info is likely readily available.
> Then such cgroup-bpf check would be suitable in execution paths where
> ioctl-based hook would be too slow.
Just to clarify, when you say drm specific hook, did you mean just a
unique attach_type or a unique prog_type+attach_type combination?  (I
am still a bit fuzzy on when a new prog type is needed vs a new attach
type.  I think prog type is associated with a unique type of context
that the bpf prog will get but I could be missing some nuances.)

When I was thinking of doing an ioctl wide hook, the file would be the
device file and the thinking was to have a helper function provided by
device drivers to further disambiguate.  For our (AMD's) driver, we
have a bunch of ioctls for set/get/create/destroy
(https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c#L1763)
so the bpf prog can make the decision after the disambiguation.  For
example, we have an ioctl called "kfd_ioctl_set_cu_mask."  You can
think of cu_mask like cpumask but for the cores/compute-unit inside a
GPU.  The ioctl hook will get the file, the bpf prog will call a
helper function from the amdgpu driver to return some data structure
specific to the driver and then the bpf prog can make a decision on
gating the ioctl or not.  From what you are saying, sounds like this
kind of back and forth lookup and dereferencing should be avoided for
performance considerations?

Having a DRM specific hook is certainly an alternative.  I just wasn't
sure which level of trade off on abstraction/generic is acceptable.  I
am guessing a new BPF_PROG_TYPE_CGROUP_AMDGPU is probably too
specific?  But sounds like BPF_PROG_TYPE_CGROUP_DRM may be ok?

Regards,
Kenny
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
