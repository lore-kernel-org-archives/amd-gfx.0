Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22352C388F2
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCBC2227F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2AklAvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCBC2227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA9889F07;
	Tue,  3 Nov 2020 05:39:42 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9D589F07
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 05:39:41 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id a9so17047143wrg.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 21:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6C1TddxGZ0d1C85NySMzJA5NrgJ86kaMDvlk9LRzkyE=;
 b=n2AklAvwP4/fcdo+i/2fc9mZ6k8H5UKcX7DnjoynfxwW2cGSAiXmmmv6QRVRqMm3GT
 Qs4H+7sA+/utS7+pg3ScIu8hjO7RJdSpK6pOHrk32QdTt13Iy00a82UWD2iSmlvdVF5d
 mVP7mPciRHJmHaWX8zErMZexWJF6aAcK/5vvmjGCj2kE1TzLTDOozUos0fJHuvurT7i1
 /HA+XLm91nJ5I7CADFUOaiGcQJ7wSSb2upTmZQKcs4bU3wfvA8NdSS0GBO/GbMxGWptQ
 tN10B55HLmapm2QvRBMaDxWAa2uHDRV4kXgPTXk6lPTAM958Je4nwgSuUsNJ85rtjTUC
 t3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6C1TddxGZ0d1C85NySMzJA5NrgJ86kaMDvlk9LRzkyE=;
 b=UiW5XRtFim1OF28XG6q/ZQwT0p0iJ1sfs8Ey+qoXRtPAYATAvQ9AeNHk8BBW9c1fg0
 E820eohzfJoxrjsp+CmjtuSH7Io7oo7ubPIgiIISuNRr+Znkcsk8mDrwJbafKDZDkrM9
 2lgJAuZGDcoSo9sOBJpfEA8moKZOuDbz6EyR7gfFiUdfHm2QTKTTOl05JGBQPGWMJAGS
 zAffBd90L3FdGty3ki/Da/jIhFLFJjxa2hN6WPQL/kxEqGMO4M121zjKHaiIqkP6iyfJ
 GNybHzhze0ejdvM7FJTE5Du169xxNzgrN+S7JN3pMib8LV0q7AogeDhqSMRxbG5318ZI
 avTg==
X-Gm-Message-State: AOAM531RSG8kr7YvyaLTFQYJMD90LXuVWtCtwZ/Ek40XMMyYxyopGZTR
 mVbisYLa+xcM4ZrHVNwihj4Wekg5DB0FNWQBGgw=
X-Google-Smtp-Source: ABdhPJxl2fyP6H4Ckfcblm4W3ysXznnjOu273I6HMBCs7HZg2+3bhOixkyuBsxDq0UlHPwnyP0E32xGegpqQeZr/ekM=
X-Received: by 2002:a5d:6287:: with SMTP id k7mr23777512wru.402.1604381980020; 
 Mon, 02 Nov 2020 21:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20201007152355.2446741-1-Kenny.Ho@amd.com>
 <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
 <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
From: Kenny Ho <y2kenny@gmail.com>
Date: Tue, 3 Nov 2020 00:39:28 -0500
Message-ID: <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
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
 Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 KP Singh <kpsingh@chromium.org>, Yonghong Song <yhs@fb.com>,
 bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the reply.  Cgroup awareness is desired because the intent
is to use this for resource management as well (potentially along with
other cgroup controlled resources.)  I will dig into bpf_lsm and learn
more about it.

Regards,
Kenny


On Tue, Nov 3, 2020 at 12:32 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 02, 2020 at 02:23:02PM -0500, Kenny Ho wrote:
> > Adding a few more emails from get_maintainer.pl and bumping this
> > thread since there hasn't been any comments so far.  Is this too
> > crazy?  Am I missing something fundamental?
>
> sorry for delay. Missed it earlier. Feel free to ping the mailing list
> sooner next time.
>
> > On Wed, Oct 7, 2020 at 11:24 AM Kenny Ho <Kenny.Ho@amd.com> wrote:
> > >
> > > This is a skeleton implementation to invite comments and generate
> > > discussion around the idea of introducing a bpf-cgroup program type to
> > > control ioctl access.  This is modelled after
> > > BPF_PROG_TYPE_CGROUP_DEVICE.  The premise is to allow system admins to
> > > write bpf programs to block some ioctl access, potentially in conjunction
> > > with data collected by other bpf programs stored in some bpf maps and
> > > with bpf_spin_lock.
> > >
> > > For example, a bpf program has been accumulating resource usaging
> > > statistic and a second bpf program of BPF_PROG_TYPE_CGROUP_IOCTL would
> > > block access to previously mentioned resource via ioctl when the stats
> > > stored in a bpf map reaches certain threshold.
> > >
> > > Like BPF_PROG_TYPE_CGROUP_DEVICE, the default is permissive (i.e.,
> > > ioctls are not blocked if no bpf program is present for the cgroup.) to
> > > maintain current interface behaviour when this functionality is unused.
> > >
> > > Performance impact to ioctl calls is minimal as bpf's in-kernel verifier
> > > ensure attached bpf programs cannot crash and always terminate quickly.
> > >
> > > TODOs:
> > > - correct usage of the verifier
> > > - toolings
> > > - samples
> > > - device driver may provide helper functions that take
> > > bpf_cgroup_ioctl_ctx and return something more useful for specific
> > > device
> > >
> > > Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> ...
> > > @@ -45,6 +46,10 @@ long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > >         if (!filp->f_op->unlocked_ioctl)
> > >                 goto out;
> > >
> > > +       error = BPF_CGROUP_RUN_PROG_IOCTL(filp, cmd, arg);
> > > +       if (error)
> > > +               goto out;
> > > +
>
> That's a bit problematic, since we have bpf_lsm now.
> Could you use security_file_ioctl hook and do the same filtering there?
> It's not cgroup based though. Is it a concern?
> If cgroup scoping is really necessary then it's probably better
> to add it to bpf_lsm. Then all hooks will become cgroup aware.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
