Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09FC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 19:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BA520786
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 19:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoYboUnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BA520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A217E6E8D7;
	Tue,  3 Nov 2020 19:19:35 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232F66E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 19:19:34 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id y14so15095905pfp.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RyTUHv4YPLTNqL42MTqa/fFS08HR2dajcyLQhdo9vRs=;
 b=LoYboUnHFQ3lxhuQT6RRR/I/kiFa6P1380rLhwUGdHscqd75CFuNDxUwo46/P1QYRO
 kX2dtjRF/Lfs70NWS1UlHiyh/a4EgKZpJq8LBrJheRjh4dWbOmN9r7d6rdXK0kKygIFV
 vG01bgpQGk2sGuu9rbEdeqPY8X/CZ4eVUHDREeOpE5+Vq4+f2i4hi/DrvyhjYBnneT+g
 pwCyBxGvmYfSB6W+mXDw1n7r50Nou9jQS2LuO8qnuVoEgc8g0CKa2Ifz289fe9pRBu1v
 9v/XfxkFbA+ETHQ83acEr23zBclzMESJgpUxVS4emEr6p0ZectaduvuAC5lQeU78DZFP
 re6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RyTUHv4YPLTNqL42MTqa/fFS08HR2dajcyLQhdo9vRs=;
 b=iF6VZMl9MQQV06+Wn7kzPDATP+0CnfCH0UKxv7s8tNtsF/DroBCaArL3ns/3xjR/PY
 z9GssfXUhTBvJ+zTu9iU82bRcIaUFNwFfdgnUlL4B1z0e9lvU35t/Y94Zgqlb3CwfIcf
 EbVS5nHKz1lZO/6iQEXgJcaQOioC6oX/jAY1nLqdmudxtlV0mvzgkEsqWZxz4Htc3Z9p
 k1qzAaOsuSa2YeXTCpP8UREmG0qohKLM4zOUhFpzeGEqzdymSkKfLWxNSbUqtkZLG04/
 zY6qtKM7KxP2xQ1JcrKBuck1kTpGGkW+uSQu5UDOJA9a84mDXJ3+trzAYfAh0GNvKxAH
 aDTQ==
X-Gm-Message-State: AOAM532EZxDm3ZPEdPmC7hh36Af13xSB/wqlBh7sSMuKyDipwi7Edkx7
 JNcdufL6Xx9Xhi1s/NdA44Zb5QXgFmHUvW0QU26sUUayIJBpaAk1
X-Google-Smtp-Source: ABdhPJyS5KGX9mdkfbE1gtYPEJ7SMa69KuVYRRcH1stREUhbeiEnctTzXjnI+hsOhH4oDKqG2vLQpMQT7LtdOXPDG1M=
X-Received: by 2002:a62:5f83:0:b029:18a:e039:4908 with SMTP id
 t125-20020a625f830000b029018ae0394908mr11860139pfb.23.1604431173654; Tue, 03
 Nov 2020 11:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20201007152355.2446741-1-Kenny.Ho@amd.com>
 <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
 <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
 <CAADnVQKuoZDB-Xga5STHdGSxvSP=B6jQ40kLdpL1u+J98bv65A@mail.gmail.com>
In-Reply-To: <CAADnVQKuoZDB-Xga5STHdGSxvSP=B6jQ40kLdpL1u+J98bv65A@mail.gmail.com>
From: Kenny Ho <y2kenny@gmail.com>
Date: Tue, 3 Nov 2020 14:19:22 -0500
Message-ID: <CAOWid-czZphRz6Y-H3OcObKCH=bLLC3=bOZaSB-6YBE56+Qzrg@mail.gmail.com>
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

On Tue, Nov 3, 2020 at 12:43 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon, Nov 2, 2020 at 9:39 PM Kenny Ho <y2kenny@gmail.com> wrote:
> pls don't top post.
My apology.

> > Cgroup awareness is desired because the intent
> > is to use this for resource management as well (potentially along with
> > other cgroup controlled resources.)  I will dig into bpf_lsm and learn
> > more about it.
>
> Also consider that bpf_lsm hooks have a way to get cgroup-id without
> being explicitly scoped. So the bpf program can be made cgroup aware.
> It's just not as convenient as attaching a prog to cgroup+hook at once.
> For prototyping the existing bpf_lsm facility should be enough.
> So please try to follow this route and please share more details about
> the use case.

Ok.  I will take a look and see if that is sufficient.  My
understanding of bpf-cgroup is that it not only makes attaching prog
to cgroup easier but it also facilitates hierarchical calling of
attached progs which might be useful if users wants to manage gpu
resources with bpf cgroup along with other cgroup resources (like
cpu/mem/io, etc.)

About the use case.  The high level motivation here is to provide the
ability to subdivide/share a GPU via cgroups/containers in a way that
is similar to other resources like CPU and memory.  Users have been
requesting this type of functionality because GPU compute can get
expensive and they want to maximize the utilization to get the most
bang for their bucks.  A traditional way to do this is via
SRIOV/virtualization but that often means time sharing the GPU as a
whole unit.  That is useful for some applications but not others due
to the flushing and added latency.  We also have a study that
identified various GPU compute application types.  These types can
benefit from more asymmetrical/granular sharing of the GPU (for
example some applications are compute bound while others can be memory
bound that can benefit from having more VRAM.)

I have been trying to add a cgroup subsystem for the drm subsystem for
this purpose but I ran into two challenges.  First, the composition of
a GPU and how some of the subcomponents (like VRAM or shader
engines/compute units) can be shared are very much vendor specific so
we are unable to arrive at a common interface across all vendors.
Because of this and the variety of places a GPU can go into
(smartphone, PC, server, HPC), there is also no agreement on how
exactly a GPU should be shared.  The best way forward appears to
simply provide hooks for users to define how and what they want to
share via a bpf program.

From what I can tell so far (I am still learning), there are multiple
pieces that need to fall in place for bpf-cgroup to work for this use
case.  First there is resource limit enforcement, which is the
motivation for this RFC (I will look into bpf_lsm as the path
forward.)  I have also been thinking about instrumenting the drm
subsystem with a new BPF program type and have various attach types
across the drm subsystem but I am not sure if this is allowed (this
one is more for resource usage monitoring.)  Another thing I have been
considering is to have the gpu driver provide bpf helper functions for
bpf programs to modify drm driver internals.  That was the reason I
asked about the potential of BTF support for kernel modules a couple
of months ago (and Andrii Nakryiko mentioned that it is being worked
on.)

Please feel free to ask more questions if any of the above is unclear.
Feedbacks are always welcome.

Regards,
Kenny
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
