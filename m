Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F146C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D89206E3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3TNMnNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D89206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C436EBA3;
	Tue,  3 Nov 2020 08:15:03 +0000 (UTC)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4366E027
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 05:32:48 +0000 (UTC)
Received: by mail-pl1-x644.google.com with SMTP id u2so2091891pls.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 21:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UZv2P1PlpxDMiV1uaU5trzoljWOaeGRNHFFhjSzWpT0=;
 b=R3TNMnNAlQI5nJk2Z1ytvhVYBiVwW4jJCzEMwcWSeKfdU8/TYHNzwU4h334zUfqlAe
 mHCFPEyqYmaSVAwtm4y51iDoEh8042L5KYyHyUhFTSAlyy+hMU/xrAQKyzJwYX4VnzY/
 iE8tNHVgpwLT/jMYHQsx5ybz5lHoksD6NSsy0MSePcuduroaMKYFbVvgW1xZKieDS9lu
 +H7Z8F3R0qGNzKYTn0otbJ2e/0geFcV4wmzmJDU9UjVnY4rPzBlWMIQ73tesAEtd8lfn
 PjHuJcRwkXtJZwlMFWzh3EB/mBDdmII/6RDf51vpqb8IRd+IX+sb+rewRDnT7Plim/nj
 YIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UZv2P1PlpxDMiV1uaU5trzoljWOaeGRNHFFhjSzWpT0=;
 b=h6ceGEH6diXjg6lBRzma3Kv30w6hucshU9HAI38qYPvQEFhDxbJtiQvxayf5qv3ugs
 wkSvpauJ2YbxHPr070T8072USULq8jsvYw/IVdEjVyHZy4mynP6eWp58CrHxK179K0fp
 vS/CNM18AqaiL4U4VwbpgJq7pVdz2Ocb3wuWZzXG6h3cu9/DnGaCW52WZLzCUI5yh11w
 6SrNLnSF0f0YvUsBPKMC8BpU5Zq7SABJBFO3k6Cu0stgEJLINMLx9z9dbJUe4D8w7EVb
 NV7kB4HpBXj9NHkx/0MKK5VAIL/S7cBcgIufG669osWPPKHXcLcd59acikGsld7PPjd4
 +Tyw==
X-Gm-Message-State: AOAM532mWTsgWXyfWLWjeXaTy0gVy/rWy3PTNd+skiRwjflfoZIr1tvi
 gk5f0adCcxbhsJ8vOgT56tc=
X-Google-Smtp-Source: ABdhPJwVwHxTBpJRDKlFrvmNcUTQ70oA9jZz+ScZQugs3f1VEc0nyAyXVJbJRJc5m/C9NiFao8dyaw==
X-Received: by 2002:a17:902:ed01:b029:d6:bb79:d46a with SMTP id
 b1-20020a170902ed01b02900d6bb79d46amr12801660pld.76.1604381568335; 
 Mon, 02 Nov 2020 21:32:48 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4055])
 by smtp.gmail.com with ESMTPSA id q5sm1400422pjj.26.2020.11.02.21.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 21:32:47 -0800 (PST)
Date: Mon, 2 Nov 2020 21:32:44 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kenny Ho <y2kenny@gmail.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
Message-ID: <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
References: <20201007152355.2446741-1-Kenny.Ho@amd.com>
 <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:15:01 +0000
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

On Mon, Nov 02, 2020 at 02:23:02PM -0500, Kenny Ho wrote:
> Adding a few more emails from get_maintainer.pl and bumping this
> thread since there hasn't been any comments so far.  Is this too
> crazy?  Am I missing something fundamental?

sorry for delay. Missed it earlier. Feel free to ping the mailing list
sooner next time.

> On Wed, Oct 7, 2020 at 11:24 AM Kenny Ho <Kenny.Ho@amd.com> wrote:
> >
> > This is a skeleton implementation to invite comments and generate
> > discussion around the idea of introducing a bpf-cgroup program type to
> > control ioctl access.  This is modelled after
> > BPF_PROG_TYPE_CGROUP_DEVICE.  The premise is to allow system admins to
> > write bpf programs to block some ioctl access, potentially in conjunction
> > with data collected by other bpf programs stored in some bpf maps and
> > with bpf_spin_lock.
> >
> > For example, a bpf program has been accumulating resource usaging
> > statistic and a second bpf program of BPF_PROG_TYPE_CGROUP_IOCTL would
> > block access to previously mentioned resource via ioctl when the stats
> > stored in a bpf map reaches certain threshold.
> >
> > Like BPF_PROG_TYPE_CGROUP_DEVICE, the default is permissive (i.e.,
> > ioctls are not blocked if no bpf program is present for the cgroup.) to
> > maintain current interface behaviour when this functionality is unused.
> >
> > Performance impact to ioctl calls is minimal as bpf's in-kernel verifier
> > ensure attached bpf programs cannot crash and always terminate quickly.
> >
> > TODOs:
> > - correct usage of the verifier
> > - toolings
> > - samples
> > - device driver may provide helper functions that take
> > bpf_cgroup_ioctl_ctx and return something more useful for specific
> > device
> >
> > Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
...
> > @@ -45,6 +46,10 @@ long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >         if (!filp->f_op->unlocked_ioctl)
> >                 goto out;
> >
> > +       error = BPF_CGROUP_RUN_PROG_IOCTL(filp, cmd, arg);
> > +       if (error)
> > +               goto out;
> > +

That's a bit problematic, since we have bpf_lsm now.
Could you use security_file_ioctl hook and do the same filtering there?
It's not cgroup based though. Is it a concern?
If cgroup scoping is really necessary then it's probably better
to add it to bpf_lsm. Then all hooks will become cgroup aware.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
