Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D507C982DB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8AA10E8E2;
	Fri, 16 Jan 2026 16:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gO+eV+B5";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877CC10E8E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:34:42 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1233ad1b4cdso137066c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 08:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768581282; cv=none;
 d=google.com; s=arc-20240605;
 b=gfnJJ6slKXeviPNDv/Qvv8Q9VdpsstKQFbChvooBR1wDuIG6B+if5NLRgU7cefx4W5
 ajW1TYkWo1iEP33lw33+dSB4EjM6iEoLue+Od8+OvE/IiTD3ctIm1n4d5TcPCsj4MpOg
 3AIAiQjLIT3qjE6llCm2ETtzXLlQYImEEIcEBAss4+IQ43G+X4YNxD5VuFHXRJbg0PBe
 PG2abYClMSAQYe0eP7CotriN4+f8A6CGJK93WiFckjqDS9hUxN4a6d8tRV6eXfG4+FRw
 OlgVauP2A2z52aZqYN8pBKN2VsTcYfjnL4ndtKPc57mTORhg37mS+JKyd7lOMFIshwfS
 42zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wnK2bP+3Pr1wMiipE80iqIEMs9r8L8vPxOxX7OXtlZc=;
 fh=wCNi0baCF7yZDR2lAa2n5pD1KSzsH4IXkM0+d/k03x8=;
 b=I0ByDft1ewyfvMdPkf+ToodAoDeVjj+stttPi65RIWjytITyuzAvttkMatPhDlLfMw
 vz97SdKz5/N80/LbmfjzITI/wcEuZNt2t6RfCaOppET6UOpPRx26T6veaAyb3Ay12t7F
 1wqHNcTtNK0lB8COA2hJyZ+DuSgJvdJXfPjqd1ULuwL6wjEe2OYwb/PVn1aq9yD3AHpl
 gFvMgobNkIpIHt01xkiszbAclp8vEhat8B4wKL3SxufTVUig18RKqD9TZuPDMLQUSdGe
 tI6SUzBoDTE7svzNVNw8LqdMiDOCX5v/a0Hhu0sjP67uwI62t1QiXDQsZQUJV+WqpBn/
 PxLg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768581282; x=1769186082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnK2bP+3Pr1wMiipE80iqIEMs9r8L8vPxOxX7OXtlZc=;
 b=gO+eV+B54ZQmp5txL/Gej3ZtNDtF1vrp/DyS7lpM03vvHRFAZn81yOFKqzIIpYwk9c
 PaAUalTJsbYYcv9NXF+YEustSckJ9Q8DlAFFibymhJtEL1DhUwoIbtPDaewLzoICFOGL
 5aBqWS81OWhQkqKfbDQhbv46Ymf+zSIs6yiv809RvkcKjEuzlZWy0BwBYFBgHuc7+rya
 bAPJg9Ua19sygU/D1+Z3d7Cb/li1CzbpJeGpmpg5IWMYRKFb+yd4JTGvKBkRPGAdmkBY
 zyXw8rh1B1vqw/oA3eys2JJxBnl7VGD5tE/P4DDBMpaQ94PCXQZAt0nabZSy8sIPxjMj
 AjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768581282; x=1769186082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wnK2bP+3Pr1wMiipE80iqIEMs9r8L8vPxOxX7OXtlZc=;
 b=loNcolHORkoOpVyWctTQ1HnkDDUwwGPBEIr7HvQGjgfVNKyybNH5Eo37VFZS89Gz7f
 drzymIgJYRoKHLlKnPR9WNZu8x6ZZ2+jve7DArJYUK09+pTib7BhCWTNd1cqc7EmwA4a
 l17geT+WqHBJF2D8Twv0YHr3Ui0P0g9zcgDjZtZyHqy4aSGg/4HbEtUxQHCWlolkYizw
 szOzmHpTev3BoNVoza7XfV2S8LawlcKpRezfflvIGFEigW9ccJPXj10gvI7H8LlhUKFH
 p2GMbEfbkJWAvg8YIbVlQc+uBEKHnFkHSC2+W31igl/biEhaawVDmNzs2BrYNXQCrkkl
 VnuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6uoy/NQXY4XG+YEVC/p4/n34OkuXSlg+ru7p7gllyGKyQwMCVjW9Hb4nNv86IpbGMayYF8N6P@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZkltEZV3ArUjtn1GxNH2JMh99Sk4lzSbEw8iSUBsBmibA0vdt
 jUiJ60934l1V/K21zu5sNrwHvn1ivaU8VWrR6QuB7I/7I7Pd87NfvoBlxjJhdzhpARZtNI4fdvD
 vDUoP1ONflkt8iAqETKRCx41Hyz+Gnxw=
X-Gm-Gg: AY/fxX54t8bz0K63rTSel4cSrV3UkbJLW6z+nrHqff/IXA5FXS4My/yCjpBFYFlU43E
 mQ28cH8QGHUwW64Hufe1f6rl2jtGtjdFUWF2BeSP8YFM5SrKDDOF5AISlvab7prC1bl7gGh3o0I
 eFFJBn7liNTUG9NHjgLLRZuIpj/+hOQ6V/FjMiG6jnmgEWtmgo3OIqCSz6nDhA0yojwmdObTXFC
 yaJQl+6ZTk6ATSpaoCdfvwmGvqVe7xXLwknHkdAr7BoEqc5AhpAVb5rK2sdRHCpwz4wAor8
X-Received: by 2002:a05:7022:221b:b0:123:34e8:aea0 with SMTP id
 a92af1059eb24-1244a72605cmr2084351c88.1.1768581280166; Fri, 16 Jan 2026
 08:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20260115012830.31182-1-yangtiezhu@loongson.cn>
 <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
 <0afdb83a-d2db-53d9-3b1b-253e466a5cc3@loongson.cn>
 <1673a119-838f-455e-88fb-528bbd72e1ea@amd.com>
In-Reply-To: <1673a119-838f-455e-88fb-528bbd72e1ea@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jan 2026 11:34:28 -0500
X-Gm-Features: AZwV_QjdR70ih8Aiw_v_jUGPPk8dl1ByJpLkZdswkCl7KkIpeY5N_5Ki66GUbu8
Message-ID: <CADnq5_MZ9Bk+nMEuA0sfLofHy1+0SmRHTutX-yDR9OzFxbqYmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jan 16, 2026 at 5:42=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 1/16/26 02:20, Tiezhu Yang wrote:
> > On 2026/1/15 =E4=B8=8B=E5=8D=889:47, Christian K=C3=B6nig wrote:
> >> On 1/15/26 02:28, Tiezhu Yang wrote:
> >>> Currently, there are many Call Traces when booting kernel on LoongArc=
h,
> >>> here are the trimmed kernel log messages:
> >>>
> >>>    amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed=
 -110
> >>>    amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
> >>>    amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
> >>>    amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
> >>>    ------------[ cut here ]------------
> >>>    WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq=
_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
> >>>    ...
> >>>    Call Trace:
> >>>    [<90000000047a8524>] show_stack+0x64/0x190
> >>>    [<90000000047a0614>] dump_stack_lvl+0x6c/0x9c
> >>>    [<90000000047cef34>] __warn+0xa4/0x1b0
> >>>    [<90000000060a4884>] __report_bug+0xa4/0x1d0
> >>>    [<90000000060a4a88>] report_bug+0x38/0xd0
> >>>    [<90000000060df330>] do_bp+0x260/0x410
> >>>    [<90000000047a6bc0>] handle_bp+0x120/0x1c0
> >>>    [<ffff8000028bff40>] amdgpu_irq_put+0xb0/0x140 [amdgpu]
> >>>    [<ffff8000027b1a8c>] amdgpu_fence_driver_hw_fini+0x12c/0x180 [amdg=
pu]
> >>>    [<ffff800002f2c04c>] amdgpu_device_fini_hw+0xf0/0x3fc [amdgpu]
> >>>    [<ffff80000279e2ac>] amdgpu_driver_load_kms+0x7c/0xa0 [amdgpu]
> >>>    [<ffff800002791128>] amdgpu_pci_probe+0x298/0x810 [amdgpu]
> >>>    [<90000000054d04a4>] local_pci_probe+0x44/0xc0
> >>>    [<90000000047f4ab0>] work_for_cpu_fn+0x20/0x40
> >>>    [<90000000047f93e0>] process_one_work+0x170/0x4e0
> >>>    [<90000000047fa14c>] worker_thread+0x3ac/0x4e0
> >>>    [<9000000004806824>] kthread+0x154/0x170
> >>>    [<90000000060df5b4>] ret_from_kernel_thread+0x24/0xd0
> >>>    [<90000000047a62a4>] ret_from_kernel_thread_asm+0xc/0x88
> >>>
> >>>    ---[ end trace 0000000000000000 ]---
> >>>    amdgpu 0000:07:00.0: probe with driver amdgpu failed with error -1=
10
> >>>    amdgpu 0000:07:00.0: amdgpu: amdgpu: ttm finalized
> >>>
> >>> This is because amdgpu_irq_enabled() is false in amdgpu_irq_put(), th=
en
> >>> the condition of WARN_ON() is true.
> >>>
> >>> In order to avoid the unnecessary Call Traces, it can remove the chec=
k of
> >>> amdgpu_irq_enabled() and only check atomic_read(&src->enabled_types[t=
ype]
> >>> for three reasons:
> >>>
> >>> (1) The aim is to prevent refcount from being less than 0, it was add=
ed in
> >>> commit 1fa8d710573f ("drm/amdgpu: Fix desktop freezed after gpu-reset=
").
> >>> (2) There are already many useful failed log before the Call Trace, t=
here
> >>> is no need to WARN_ON().
> >>
> >> Well completely disagree. The call trace here is absolutely intentiona=
l.
> >
> > If so, since the call trace is same, is it enough to use WARN_ON_ONCE()
> > here?
>
> I also don't see a justification for that.
>
> >> That you get a lot of other backtraces because the driver doesn't init=
ialize at all isn't a good rational to remove this one here.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> (3) The following checks in amdgpu_irq_put() are same with the checks=
 in
> >>> amdgpu_irq_enabled(), there is no need to do the redundant operations=
.
> >>>
> >>>     if (!adev->irq.installed)
> >>>         return -ENOENT;
> >>>
> >>>     if (type >=3D src->num_types)
> >>>         return -EINVAL;
> >>>
> >>>     if (!src->enabled_types || !src->funcs->set)
> >>>         return -EINVAL;
> >
> > Is this reasonable? Only check atomic_read(&src->enabled_types[type]?
>
> No, absolutely not. That are two completely different things.
>
> > That is to say, does it make sense to do the following change?
>
> The warning can basically only be triggered by two conditions:
> 1. A fatal problem while loading the driver and the error handling is not=
 100% clean.
> 2. A driver coding error.
>
> And we really need to catch all of those, so there is no real rational to=
 limit the warning.
>
> I mean when you run into any of those they should potentially be fixed at=
 some point.

The problem is there are a lot of error paths which don't get this
right that no one has fixed for years.  I'm not sure if there is much
value anymore; most people just ignore them.

Alex

>
> Regards,
> Christian.
>
> >
> > ----->8-----
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.c
> > index 8112ffc85995..d10d6fcc525e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -636,7 +636,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, stru=
ct amdgpu_irq_src *src,
> >         if (!src->enabled_types || !src->funcs->set)
> >                 return -EINVAL;
> >
> > -       if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
> > +       if (WARN_ON_ONCE(!atomic_read(&src->enabled_types[type])))
> >                 return -EINVAL;
> >
> >         if (atomic_dec_and_test(&src->enabled_types[type]))
> >
> > Thanks,
> > Tiezhu
> >
>
