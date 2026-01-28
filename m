Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C880D3F08E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 16:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7B010E2CB;
	Wed, 28 Jan 2026 16:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hd+4LLSl";
	dkim-atps=neutral
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2457E10E72F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 16:07:02 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-5ed0b8b171eso347137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 08:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769616421; cv=none;
 d=google.com; s=arc-20240605;
 b=MAUZ5+ga2aOEfCsjRBQCsosCfQUTwBu4X3unV4Xfwg5Kklg9PihuMZNCVfCZiFwkQD
 escc3m8thwf29sTSMdLFvDBeu6blf3lYxGeXKcGZDMH/dgMzNOj0dQIxLnTYUyhZk3SR
 ITBTfJTYaSuPNzlSGZzdT9sMvdlDKiXReTCFD+IuLEJe+4STGCtq5ly1+Hktqg/Xds1k
 E8ZjUV7lGuZQmo0Xb8i7sAZPr1yalLfvf055F3fJwWtJQBmvlXhaK9fSDvyAXy9SE9oP
 CifYwKqKxUUPM50ZaABpyKmv3mgTWIQHiwSNmzeVJ8bwJ/qMs9kHt+0x61TAzbuR4YOd
 2QbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OSznLjfIPPwL1Ziygy9uHRPGlube/K5UX48QHb9j58Y=;
 fh=qh5iMRR6ZLA8GwVi/StNo0D9R4bZUIU2AfPCpn8JcOo=;
 b=g8NBpDSp51FNi+5o4vAtkLuHOB495WBZX7Kz/E+vSZBMcuODmZWT2k7yMHeqQ2SW5U
 ljwuODzHjQ6kz45JdqtwEfaj0UgyftHjelioYFlLBC6RONpSSmX+cEFrXYLbZnfkh6Ed
 cbp5Uvm6RoXCrYvx33Gj8tdVBWsC5ZsL7oTdj86NTTLjcWn0z2U9A0T3BygU7dd7UFm5
 URotq9fas0QzbnoDc6eV7wVqQm+LNYtwuXQwWIlhTx3lRE15UeglJ8wzsNv27E1uXsPa
 1TMUQ5rY6zIbvJzdNZ/b6AC3K1WgtZkMu8xKxbi2BMB9zjIAGPrDijG7V8mIZHeHlvX3
 gUSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769616421; x=1770221221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSznLjfIPPwL1Ziygy9uHRPGlube/K5UX48QHb9j58Y=;
 b=Hd+4LLSlIsJ25ZNpWo6BG7undm8MGPrUurm4WVwWTT5CIXuXEIOcjwHdaC9he64b1Y
 ZQFyNDWfsSbejfQJtCxDqFKT9HFXw+ildsBGa8SqvYkM7q9KsYhYjOe49Ly64aJ17xuV
 LFXwlag97iE1SeJHgvtWWMe7OTMBz9gWTCZ4xItqoLmLhSW/6WHuca0raqPfLCWAQ0vP
 mUpBoaWeDkYELROhCpNN2pGwk5mEuw+frlhqukSCxxKrBirhUUXXx9tKmdt3/cfisnmI
 hSDrmb9ybW7+WQ9J1j7afflj9ziphsb6Lo8HpdhpwCriENt8TsSS96DppV7m4UMnXs/M
 MC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769616421; x=1770221221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OSznLjfIPPwL1Ziygy9uHRPGlube/K5UX48QHb9j58Y=;
 b=JYoqKiPyJRpnA6MdYgqqn/fPYuDZ9HLYwFfnQSTem+3nfsAp8HV2RN3HCHMn3qXguz
 hmp1bapi4uFyan4VwlxQu/FtFAgY5f3LuQgNtIzAXmu0sN9MM3v67hWX1beg1FDwTV1X
 EBjtQ6SD1gT1xQ6/LpAZSF60RRmdJFLEl2S98QsycMrR6ZWLSop9+qbmZFmwM4VPxb1M
 Sj7iUcbLoGGmekL8/T6MDMFc2d1WMpO9JFoVbZv6Y29LGCFMHEaJIfWsAMEM9BuovjoH
 j7Im/BAaPmWKryKyF4qEkmv30dxxnFT1g+n4nrzZOblv66ITKHGNQ8R+zBd3MBSc5Jwr
 PRHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDO/OjBJDZTI6uwpO6epFJ9mOYcy7iGldFwCIbXQR5d1qhI6wHVN44UV66e2vsXxrX6A3NcYUs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbLBJnfuX7i36RvXL3GCM+kPpoiNyc4R/F3FwaBSrk47Bf6Unm
 +ucQc3np6VyMO1aZ5xnKOjX9oaWz0T+P9EyKBy3MOUtaiGpsGOER1lydCauxS5sYDuXqEAa+TtB
 iHDtn3kZbbemgev2+RDWrFWuray9fcTc=
X-Gm-Gg: AZuq6aLzlRYEUpiuibr/XZznZ3B9Lap+khJpmFpJDeLmllwMCXNCNu/Ysj4xcPmH/TC
 XlVbMghWXRARjtDDt7Q4qORcB9hhEU7f5QGSk3wVdW2DArihtY3M+8pxvrz5739WrLqn7IRifiU
 xvYmP54gWvr+2ulZH2MsrbtRlIxIrVp4E20CAgjJte/GZenZFCgT9wov7hbdGnZPY/kylk0vo0O
 yg4lOhayUU8WFuzM11xQP3UlRyGW3Lo6W5e+ref8hXbMSCHyDHe5mXBZwIEyehpFu/tZw1MN5Ws
 Y8LOQFA=
X-Received: by 2002:a05:6102:3746:b0:5d4:927:5e0 with SMTP id
 ada2fe7eead31-5f8cbc75944mr154708137.7.1769616419359; Wed, 28 Jan 2026
 08:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-5-lijo.lazar@amd.com>
 <CADnq5_N4SwVA_RXjPqQVV2ERsnOjCzGKXGfS-2xaHShNxee8=A@mail.gmail.com>
 <d7e73dbe-fa0d-42ed-8b16-fee352e8b662@amd.com>
 <CADnq5_P243kbtXDgv0JqgjmB9taA+2uMUbYtR90aVzPU4APXUw@mail.gmail.com>
 <2c920279-0245-4b66-9604-7333b00b9983@amd.com>
 <a00342a1-951b-4909-9d5f-48141917a522@amd.com>
In-Reply-To: <a00342a1-951b-4909-9d5f-48141917a522@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Jan 2026 11:06:47 -0500
X-Gm-Features: AZwV_QivyZDCUKnJR89Hg1MMMoxnTo-m312PwW_0PfbUYfzLqmPOoG3JY6Ak3aI
Message-ID: <CADnq5_NaVN4s5_kFRE1xf7ZEZzXb3vA4xNWQUq05qNNONG1ijQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] drm/amdgpu: Add user save area params validation
To: Lancelot SIX <Lancelot.Six@amd.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 Jesse.Zhang@amd.com, "Yat Sin, David" <David.YatSin@amd.com>, 
 "Kim, Jonathan" <jonathan.kim@amd.com>, "Morichetti,
 Laurent" <Laurent.Morichetti@amd.com>
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

On Wed, Jan 28, 2026 at 7:30=E2=80=AFAM Lancelot SIX <Lancelot.Six@amd.com>=
 wrote:
>
> >>>>> +       /*
> >>>>> +        * Only control stack and save area size details checked.
> >>>>> Address validation needs to be
> >>>>> +        * carried out separately.
> >>>>> +        */
> >>>>> +       if (cwsr_params->ctl_stack_sz !=3D
> >>>>> +           (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
> >>>>> +               dev_dbg(adev->dev,
> >>>>> +                       "queue ctl stack size 0x%x not equal to
> >>>>> node ctl stack size 0x%x\n",
> >>>>> +                       cwsr_params->ctl_stack_sz,
> >>>>> +                       num_xcc * cwsr_info->xcc_ctl_stack_sz);
> >>>>> +               return -EINVAL;
> >>>>> +       }
> >>>>> +
> >>>>> +       if (cwsr_params->cwsr_sz < (cwsr_info->xcc_cwsr_sz *
> >>>>> num_xcc)) {
> >>>>> +               dev_dbg(adev->dev,
> >>>>> +                       "queue cwsr size 0x%x not equal to node
> >>>>> cwsr size 0x%x\n",
> >>>>> +                       cwsr_params->cwsr_sz, num_xcc * cwsr_info-
> >>>>> >xcc_cwsr_sz);
> >>>>> +               return -EINVAL;
> >>>>> +       }
> >>
> >> cwsr_params->cwsr_sz has no upper bound check.  Can this cause an
> >> overflow elsewhere?
> >>
> >
> > We could restrict to a max limit of 2 * cwsr size required. Adding
> > David/Lancelot as well.
> >
> > Thanks,
> > Lijo
> >
>
> Hi,
>
> The CWSR size should allow room for userspace to choose the amount
> allocated for use by the debugger.  I am not sure what limit would make
> sense, as I can't really predict what will be needed in the future, but
> I=E2=80=AFreally don't see how we could need more than the cwsr size (whi=
ch
> itself can contain the entire state of what is running on the queue).
>

We can always make it bigger in the future if we need it.  Unbounded
seems ripe for an overflow somewhere.

Alex

> Best,
> Lancelot.
>
> cc Jonathan/Laurent
>
> >> Alex
> >>
> >>
> >> Alex
> >>
> >>>>> +
> >>>>> +       return 0;
> >>>>> +}
> >>>>> +
> >>>>>    void amdgpu_cwsr_free(struct amdgpu_device *adev, struct
> >>>>> amdgpu_vm *vm,
> >>>>>                         struct amdgpu_cwsr_trap_obj **trap_obj)
> >>>>>    {
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/
> >>>>> gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> >>>>> index 3c80d057bbed..96b03a8ed99b 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> >>>>> @@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
> >>>>>           uint32_t xcc_cwsr_sz;
> >>>>>    };
> >>>>>
> >>>>> +struct amdgpu_cwsr_params {
> >>>>> +       uint64_t ctx_save_area_address;
> >>>>> +       /* cwsr size info */
> >>>>> +       uint32_t ctl_stack_sz;
> >>>>> +       uint32_t cwsr_sz;
> >>>>> +};
> >>>>> +
> >>>>>    int amdgpu_cwsr_init(struct amdgpu_device *adev);
> >>>>>    void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> >>>>>
> >>>>> @@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct
> >>>>> amdgpu_device *adev)
> >>>>>           return adev->cwsr_info !=3D NULL;
> >>>>>    }
> >>>>>
> >>>>> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int
> >>>>> num_xcc);
> >>>>> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> >>>>> +                               struct amdgpu_cwsr_params
> >>>>> *cwsr_params,
> >>>>> +                               int num_xcc);
> >>>>>    #endif
> >>>>> --
> >>>>> 2.49.0
> >>>>>
> >>>
> >
>
