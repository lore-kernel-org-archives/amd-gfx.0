Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89ADC388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFCC21556
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmZVUoU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFCC21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C82D6E917;
	Tue,  3 Nov 2020 23:36:09 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A61FF6E90C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 23:28:09 +0000 (UTC)
Received: by mail-pg1-x542.google.com with SMTP id g12so14941874pgm.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eRl//7At+Wm2EvC4VlJ9A50IgrwQOr/jqI3Y/MXhPxg=;
 b=kmZVUoU/Ml29s2vai8g/wNXjAaEbkI2ty7/6v1tIWH/TsVrRa4VJjMGFgMG6+GfqOd
 9YUZ70jBPbJJsjQW/+jbVP+kYL/cKNZnzawk7FKkjXECBfHU0twg+Y03hcoyYt1HAV4r
 dwuVHNxylpag7OCuMJnFlLe/C1x/Gtlnr/dRj2KKStNq7iQecKuIkiwlgblsw44EQOCi
 +u/IO3JItZUNB9dcbEqwcJ6zSBEnqh3W7zEq03ns+7jyjKspZ61r4pdJQZGsqvvgg8Rt
 oeJ/OCsatIzsx20LV3rXcQ4JRKe03TqSXJu1lX8dMm4zOhLKyK9wt7RGo0qAPkfiqv6S
 cdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eRl//7At+Wm2EvC4VlJ9A50IgrwQOr/jqI3Y/MXhPxg=;
 b=Y+Er2bwmPvslR8gwcckr5TmmpZ65VFxFx492ZQFYe4/GFS3tfXIs1cLWpIoVXpOO93
 A4i2w42UwKiVsTCc19nVq2fS0rW71nFHM91q8X9YJhjREyQNgbBJq4/2zShaXhNPud5I
 NyO8yp7qhJnxBrtqooBBwO0MF/Yo5GbZCb77NmKv5Q/chpwE6rd70XTfYw4zSSdpEep7
 q+cUXkjOaWGMj6cMJaOUdD911XVaLGKTuxLjRh0LGl0WUvVS3Pog+AYof8iFZup1rXWo
 hNZPX+5M/SuDAylCEzaFDl22J4hkLDx63JdGA3CkocSKvV34aNg3yZMNTmcy5ZaOOFe5
 tlvQ==
X-Gm-Message-State: AOAM531xMZgFKjwNtReiW/NOYPN/5ySCwg3B4QNSbJx7zfECcCknf778
 DOJ95rMNSrVk40kZSUiXImg=
X-Google-Smtp-Source: ABdhPJwA1Y3V3bXAbq5RWgN0tRPA1Lm5ZwU9tdZvWFuGd5NX2rWIgARC5HkbuwN5Li8owzB81DvZcw==
X-Received: by 2002:a63:5153:: with SMTP id r19mr18783989pgl.130.1604446089195; 
 Tue, 03 Nov 2020 15:28:09 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4055])
 by smtp.gmail.com with ESMTPSA id w19sm209327pff.6.2020.11.03.15.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 15:28:08 -0800 (PST)
Date: Tue, 3 Nov 2020 15:28:05 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kenny Ho <y2kenny@gmail.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
Message-ID: <20201103232805.6uq4zg3gdvw2iiki@ast-mbp.dhcp.thefacebook.com>
References: <20201007152355.2446741-1-Kenny.Ho@amd.com>
 <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
 <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
 <CAADnVQKuoZDB-Xga5STHdGSxvSP=B6jQ40kLdpL1u+J98bv65A@mail.gmail.com>
 <CAOWid-czZphRz6Y-H3OcObKCH=bLLC3=bOZaSB-6YBE56+Qzrg@mail.gmail.com>
 <20201103210418.q7hddyl7rvdplike@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-djQ_NRfCbOTnZQ-A8Pr7jMP7KuZEJDSsvzWkdw7qc=yA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOWid-djQ_NRfCbOTnZQ-A8Pr7jMP7KuZEJDSsvzWkdw7qc=yA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 23:36:07 +0000
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

On Tue, Nov 03, 2020 at 05:57:47PM -0500, Kenny Ho wrote:
> On Tue, Nov 3, 2020 at 4:04 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 03, 2020 at 02:19:22PM -0500, Kenny Ho wrote:
> > > On Tue, Nov 3, 2020 at 12:43 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Mon, Nov 2, 2020 at 9:39 PM Kenny Ho <y2kenny@gmail.com> wrote:
> >
> > Sounds like either bpf_lsm needs to be made aware of cgv2 (which would
> > be a great thing to have regardless) or cgroup-bpf needs a drm/gpu specific hook.
> > I think generic ioctl hook is too broad for this use case.
> > I suspect drm/gpu internal state would be easier to access inside
> > bpf program if the hook is next to gpu/drm. At ioctl level there is 'file'.
> > It's probably too abstract for the things you want to do.
> > Like how VRAM/shader/etc can be accessed through file?
> > Probably possible through a bunch of lookups and dereferences, but
> > if the hook is custom to GPU that info is likely readily available.
> > Then such cgroup-bpf check would be suitable in execution paths where
> > ioctl-based hook would be too slow.
> Just to clarify, when you say drm specific hook, did you mean just a
> unique attach_type or a unique prog_type+attach_type combination?  (I
> am still a bit fuzzy on when a new prog type is needed vs a new attach
> type.  I think prog type is associated with a unique type of context
> that the bpf prog will get but I could be missing some nuances.)
> 
> When I was thinking of doing an ioctl wide hook, the file would be the
> device file and the thinking was to have a helper function provided by
> device drivers to further disambiguate.  For our (AMD's) driver, we
> have a bunch of ioctls for set/get/create/destroy
> (https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c#L1763)
> so the bpf prog can make the decision after the disambiguation.  For
> example, we have an ioctl called "kfd_ioctl_set_cu_mask."  You can

Thanks for the pointer.
That's one monster ioctl. So much copy_from_user.
BPF prog would need to be sleepable to able to examine the args in such depth.
After quick glance at the code I would put a new hook into
kfd_ioctl() right before
retcode = func(filep, process, kdata);
At this point kdata is already copied from user space 
and usize, that is cmd specific, is known.
So bpf prog wouldn't need to copy that data again.
That will save one copy.
To drill into details of kfd_ioctl_set_cu_mask() the prog would
need to be sleepable to do second copy_from_user of cu_mask.
At least it's not that big.
Yes, the attachment point will be amd driver specific,
but the program doesn't need to be.
It can be generic tracing prog that is agumented to use BTF.
Something like writeable tracepoint with BTF support would do.
So on the bpf side there will be minimal amount of changes.
And in the driver you'll add one or few writeable tracepoints
and the result of the tracepoint will gate
retcode = func(filep, process, kdata);
call in kfd_ioctl().
The writeable tracepoint would need to be cgroup-bpf based.
So that's the only tricky part. BPF infra doesn't have
cgroup+tracepoint scheme. It's probably going to be useful
in other cases like this. See trace_nbd_send_request.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
