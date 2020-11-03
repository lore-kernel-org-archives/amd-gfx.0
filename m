Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6D9C4742C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 21:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E15720757
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 21:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqKpwE9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E15720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CCFD6E8F4;
	Tue,  3 Nov 2020 21:15:38 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122756E8F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 21:04:35 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id z3so9003736pfz.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wrUBzqixMNGges3Fm8LEqTkGr+7Sx/OVd1FP+l0kdS0=;
 b=tqKpwE9c1XvzM26lsALNljg7czgItn9B2SFh1tA3jWE/ITdxfbUKdt+lGHvc4AqZJG
 DZ38w2G0ZCOMhepTm9Eowqe4LBfWPO8ILx0Ol+dgIFIwxdAiNzD1wA/i8yt6fsVNOptw
 SaiYvqBnxP3BX8+Vb8wu9Rwugz6FWLSJfUcENjTtu4V78jIYi59xfrDLTeLYUuG5oxAl
 NTgLN9RaB/G1pfPbVdSsuGof6GiB/WaIyBDaEjrF7Ha1Z98pSiyS5oXgB6h/IXv9HV1w
 sOAJhdJr5OPTpCg0tsq/C68T5BgQKFWAUoPDQTzUaXS7gzIxvEKvR4YiROniyFWZyWC3
 0Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wrUBzqixMNGges3Fm8LEqTkGr+7Sx/OVd1FP+l0kdS0=;
 b=BInqTv1yTpNHfEA9GZIjJPFI4+r51lVIb20fuV4rzsvP9aNlZaxnSeF7WHM17GqL8C
 4g2K6uexcHjh40/804Fgn6tUdw4lq5uokaZBaCyC1XLRU9qMNiiIlKUWkXHddbqQRqX1
 /nVmlSWPMBCNrMNsdCuKjd4irAD2JqI8Hyhi2bcPVLOeVJAd+/u6uhPYLJG6WgTM7iL3
 TaCLaIPhBNVifyseUcLEyt7qADHUDlKPbKrAEWiYmbdLB0jwVtjIppAnCWKLgaKm8YoB
 aY13Uwysbr1hK9nU1ZYOD3HdgTe681+apv4yd0dRIwx/rhBzW8psEm3pjmEftDntiOga
 xwZA==
X-Gm-Message-State: AOAM533jBX6IPx/0RI1bum/jTldR6M+TFNxW0/3vVrlfPSgh3zP+mO5F
 nJPedQ6RTtrbyWV5+g+To+k=
X-Google-Smtp-Source: ABdhPJwKd9ujaje9lKYp2d86AtKj6fAx/PpwqjE7Ypjdq7qZld+7Ol6iwwjneB60m1H6WrfRfHbdnA==
X-Received: by 2002:a17:90b:f85:: with SMTP id
 ft5mr1161462pjb.86.1604437474559; 
 Tue, 03 Nov 2020 13:04:34 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4055])
 by smtp.gmail.com with ESMTPSA id y22sm29035pfr.62.2020.11.03.13.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 13:04:33 -0800 (PST)
Date: Tue, 3 Nov 2020 13:04:18 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kenny Ho <y2kenny@gmail.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
Message-ID: <20201103210418.q7hddyl7rvdplike@ast-mbp.dhcp.thefacebook.com>
References: <20201007152355.2446741-1-Kenny.Ho@amd.com>
 <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
 <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
 <CAADnVQKuoZDB-Xga5STHdGSxvSP=B6jQ40kLdpL1u+J98bv65A@mail.gmail.com>
 <CAOWid-czZphRz6Y-H3OcObKCH=bLLC3=bOZaSB-6YBE56+Qzrg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOWid-czZphRz6Y-H3OcObKCH=bLLC3=bOZaSB-6YBE56+Qzrg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 21:15:37 +0000
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

On Tue, Nov 03, 2020 at 02:19:22PM -0500, Kenny Ho wrote:
> On Tue, Nov 3, 2020 at 12:43 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Mon, Nov 2, 2020 at 9:39 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > pls don't top post.
> My apology.
> 
> > > Cgroup awareness is desired because the intent
> > > is to use this for resource management as well (potentially along with
> > > other cgroup controlled resources.)  I will dig into bpf_lsm and learn
> > > more about it.
> >
> > Also consider that bpf_lsm hooks have a way to get cgroup-id without
> > being explicitly scoped. So the bpf program can be made cgroup aware.
> > It's just not as convenient as attaching a prog to cgroup+hook at once.
> > For prototyping the existing bpf_lsm facility should be enough.
> > So please try to follow this route and please share more details about
> > the use case.
> 
> Ok.  I will take a look and see if that is sufficient.  My
> understanding of bpf-cgroup is that it not only makes attaching prog
> to cgroup easier but it also facilitates hierarchical calling of
> attached progs which might be useful if users wants to manage gpu
> resources with bpf cgroup along with other cgroup resources (like
> cpu/mem/io, etc.)

Right. Hierarchical cgroup-bpf logic cannot be replicated inside
the program. If you're relying on cgv2 hierarchy to containerize
applications then what I suggested earlier won't work indeed.

> About the use case.  The high level motivation here is to provide the
> ability to subdivide/share a GPU via cgroups/containers in a way that
> is similar to other resources like CPU and memory.  Users have been
> requesting this type of functionality because GPU compute can get
> expensive and they want to maximize the utilization to get the most
> bang for their bucks.  A traditional way to do this is via
> SRIOV/virtualization but that often means time sharing the GPU as a
> whole unit.  That is useful for some applications but not others due
> to the flushing and added latency.  We also have a study that
> identified various GPU compute application types.  These types can
> benefit from more asymmetrical/granular sharing of the GPU (for
> example some applications are compute bound while others can be memory
> bound that can benefit from having more VRAM.)
> 
> I have been trying to add a cgroup subsystem for the drm subsystem for
> this purpose but I ran into two challenges.  First, the composition of
> a GPU and how some of the subcomponents (like VRAM or shader
> engines/compute units) can be shared are very much vendor specific so
> we are unable to arrive at a common interface across all vendors.
> Because of this and the variety of places a GPU can go into
> (smartphone, PC, server, HPC), there is also no agreement on how
> exactly a GPU should be shared.  The best way forward appears to
> simply provide hooks for users to define how and what they want to
> share via a bpf program.

Thank you for sharing the details. It certainly helps.

> From what I can tell so far (I am still learning), there are multiple
> pieces that need to fall in place for bpf-cgroup to work for this use
> case.  First there is resource limit enforcement, which is the
> motivation for this RFC (I will look into bpf_lsm as the path
> forward.)  I have also been thinking about instrumenting the drm
> subsystem with a new BPF program type and have various attach types
> across the drm subsystem but I am not sure if this is allowed (this
> one is more for resource usage monitoring.)  Another thing I have been
> considering is to have the gpu driver provide bpf helper functions for
> bpf programs to modify drm driver internals.  That was the reason I
> asked about the potential of BTF support for kernel modules a couple
> of months ago (and Andrii Nakryiko mentioned that it is being worked
> on.)

Sounds like either bpf_lsm needs to be made aware of cgv2 (which would
be a great thing to have regardless) or cgroup-bpf needs a drm/gpu specific hook.
I think generic ioctl hook is too broad for this use case.
I suspect drm/gpu internal state would be easier to access inside
bpf program if the hook is next to gpu/drm. At ioctl level there is 'file'.
It's probably too abstract for the things you want to do.
Like how VRAM/shader/etc can be accessed through file?
Probably possible through a bunch of lookups and dereferences, but
if the hook is custom to GPU that info is likely readily available.
Then such cgroup-bpf check would be suitable in execution paths where
ioctl-based hook would be too slow.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
