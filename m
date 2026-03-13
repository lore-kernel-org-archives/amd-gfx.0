Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75326105F7A7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 13:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0814010EBEE;
	Fri, 13 Mar 2026 13:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R5rdQI2F";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837D310EBF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:12:43 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-128d600ad25so74964c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773407563; cv=none;
 d=google.com; s=arc-20240605;
 b=Dny9xF7BqF4bPCWEi3LLcsiSTql1hEbOtqqs4iCer3L7+W1PZX+5ABLoE3TJsnTK1h
 ik1t6SVFb975x1PLUHOtQy9oFdDGqpOt1MvaWRDf2UiomGaAJSmscfZ3TYtsMsCaMeaQ
 PPIL1JL0wyN4t+qrgHGLtQtBC5db9buDIljYUzQpX3qAcHpjyr5/KGCCvaD5P3J+IOE6
 UcpkzF9hPEiFDqFN7iQRCLm3ImmFNxuexCF/Yh2nKIpQB2Py/78pM+EPvpoN5cfwi9p7
 8u7kWlvl3WLYDVmfDqzS2PKqHyt1rlIadU1MytqGnlKgKLbohWGyVUz4iunB6mQ5cJwe
 khIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M85EOD44jj2u4q2d8ZQcp3IIBuwFC+deYsig5LhF9Nc=;
 fh=fasvwilDChx2LBSACOUm3ctf2ae331Efn8LfWtvfums=;
 b=YlkDfoddQ3d6VC0ex26qkIcS2VQZPRA2+fEX1xcO61NhqZoM8NHKzoq65er12OY5A3
 q/0Y9ojUdcsI2LJDg9bT05j4xwaWd6k3MMdIZZBlXkNkeZCXjx6cRSYa20V20A1Bsx89
 F8ORZAvl4gAelu9NCzsM6FVn2Ss0ZsS8gf40SpM9ycxuERgj3fNA1zWiBZMuwrx9q+NN
 2JWa/2DKrdPO6IanADCElzKasNH3Fxdl+kgmuybt+9PH3wE6UK6YC9A06UdHbnSReOCq
 OV3YFBLLvEkRuSbDefOp9CL2TNOeo/U91NZ7xYcjovr2dEkHiAVgvl6ISgb/96pOQwEC
 T+9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773407563; x=1774012363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M85EOD44jj2u4q2d8ZQcp3IIBuwFC+deYsig5LhF9Nc=;
 b=R5rdQI2FWr4+GEUxnhKaAV1lw2H53B8WRRRjgTJtHMx1aDSBj0pWWUzpQU91gMYi9W
 KRO5EPHKyF+JPB4WeS+PIeQuYX94Eu4h2NEKda4/YtU27oFeK/tfosHj5VosSp9WNp2N
 9XiSprAkCV3laqmoWCpuw4mujZjG0X1kGqNSuDrKgcixPP6+BwkoTOfEvJNFFEFsJBJg
 EpokEtWQ9sp+f/jYWG9LQgEZzdYVp+PKyeYjvL5/AAcnMrWZrq9v4ZolA1Mv5ID0nUtv
 qlzO6vjqqGk0RCkg9A4RmQO82K9WsERteltazR9Mp7DQKsIRqzASIlBJ4nJUrbw4ZqI+
 tkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773407563; x=1774012363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M85EOD44jj2u4q2d8ZQcp3IIBuwFC+deYsig5LhF9Nc=;
 b=ickvxq2Y6EQHWln1Lq8ddWw9sVcisNQPdBTdgmK+BxlkijOLrhR7WcMwsrU/p4D4yC
 lpPm3gTMaD1ZHishQERUuK9vDaBE3f0n4zP7uvl5stULCBiyGp8NLrCLT7TTI8R2h2SD
 95FIUiARZJDldKcEhhs72svlJL11yfIHKv+RE6XtVcPx/dX+6LIz9gSPtvigI+yFZdeO
 o1/ZVve5P2BVrUhLueXzKtt10V4FarCfn0X/2tRLBo+UDAMnOcvzJzQUhWfUxkhdvvsC
 3cvvOp1ok0SFpzLH8c8vEd/RVYcsRIhH0vJJuIRzAoIxiyD7nIjfKN0/4nf591yvQbue
 CHtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBhxDjjMuPW4igGwIA64F+CCGEa2rffHhVVMTVSSKDPaMvgvDls3qRjAEqxXQ+xn4daEodJErc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfMCiweMVhNyNStZNhdORBt7ntrcaO7ivfTXdpozppx4GwlO5Z
 bi+EDc6VkF+PDtye06UDOZ1tHoiI8BCmYG3BtrdtJdgqT9aYozwRmpzWpi3SyC03RPDWKGBwB26
 xPTrj9YpRi4PfqKyKJeuqZ5pV1UM7MEM=
X-Gm-Gg: ATEYQzzJ8UXk9nqNaPIV719BYKFO8bkxAbCXLZoXjRRnMABHn3qlS8DD74WC2McSpOU
 ya7IWUdXTXloyNd4zRFiahyJ3zGytUpJhaIB0AC1HkEmIySKs3ph8UvDcJCgWFGA4GbHbq5bcek
 aN+QWzuLNSoTyilzvJIWgEvIJMRzIQF82TCL0Vm9Ym29boloTPOqSxB7Q9tLDKNmlEEvQYxsWB3
 W8n4QnG6P01SiFI8jMxhoP08kLLrHfJ+17MoTq76lQYfOl0TtSTeUOUkQ7D8M21Si8OPTa5drlP
 5Z8HvquV52hZrz/OzL/tPLFlWO+uwNo5YGyKx6L7ZbK7cDaQResDL4Tt5cJaLRCrsYY3Vw==
X-Received: by 2002:a05:7023:a88:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-128f3e1775emr640675c88.4.1773407562590; Fri, 13 Mar 2026
 06:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135531.3954691-1-sunil.khatri@amd.com>
 <3d80b2b5-4d1d-4435-8418-f59e2b905ed7@ursulin.net>
 <563d4978-6e84-4059-80bf-5b5d6d5699e5@amd.com>
 <3e393a12-be1f-4fa9-9024-35661cabb29a@ursulin.net>
 <f5053ac5-868b-4b3c-82e1-62db57b0c588@amd.com>
In-Reply-To: <f5053ac5-868b-4b3c-82e1-62db57b0c588@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 09:12:31 -0400
X-Gm-Features: AaiRm52-gYESMhP7RE9gMsY2z-KMrRudiBrJNbaN3GDmZFMKO1zlmj1gB0wQuYk
Message-ID: <CADnq5_OnEFqaNwBx57_ANcHo9vK4AZ5-o_pKo80=m1cJHEUipw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: Only look up for gem objects
 when count is non zero
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, "Khatri, Sunil" <sukhatri@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Mar 13, 2026 at 8:24=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 3/13/26 09:53, Tvrtko Ursulin wrote:
> >
> > On 13/03/2026 08:45, Khatri, Sunil wrote:
> >>
> >> On 13-03-2026 02:09 pm, Tvrtko Ursulin wrote:
> >>>
> >>> On 10/03/2026 13:55, Sunil Khatri wrote:
> >>>> In function amdgpu_userq_wait_ioctl, call function drm_gem_objects_l=
ookup
> >>>> only if the count is valid i.e non zero.
> >>>>
> >>>> In case of object count is 0 set the pointer to NULL for proper clea=
n
> >>>> up.
> >>>
> >>> Hasn't this been discussed already with the conclusion that nothing i=
s broken? Or I am missing something?
> >>> Regards,
> >>>
> >>> Tvrtko
> >> Issue was seen again since Alex pulled 6.19 fixes from DRM and the drm=
_gem_objects_lookup again got reverted to old and we started to see the iss=
ue. With that in mind Alex too suggested that nothing wrong if we explicitl=
y check in driver too. Also i thought its only when handles are Zero case w=
hen the problem is actually seen and why not that have a check targeting th=
at and not to invoke the function drm_gem_objects_lookup itself for that sp=
ecific case.
> >
> > Yes nothing wrong with checking, thanks for clarifying. I was just worr=
ied I again missed something in the code.
>
> I'm clearly against adding those checks. It adds additional complexity be=
cause of an issue somewhere else.
>
> So we should probably just cherry pick the correct fix over into amd-stag=
ing-drm-next instead.

My concern was if someone pulls these changes into some other distro
or stable kernel and the drm fix is missing.  Then they'll run into
this issue again and someone will have to debug it again.  We already
ran into this twice in our trees, seems likely to repeat itself.

Alex

>
> Regards,
> Christian.
>
> >
> > Regards,
> >
> > Tvrtko
> >
> >>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>>> ---
> >>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++++++---=
----
> >>>>   1 file changed, 20 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ driv=
ers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> index 76f32fd768fb..a4fff90b190a 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> @@ -665,19 +665,27 @@ int amdgpu_userq_wait_ioctl(struct drm_device =
*dev, void *data,
> >>>>           goto free_timeline_handles;
> >>>>       }
> >>>>   -    r =3D drm_gem_objects_lookup(filp,
> >>>> - u64_to_user_ptr(wait_info->bo_read_handles),
> >>>> -                   num_read_bo_handles,
> >>>> -                   &gobj_read);
> >>>> -    if (r)
> >>>> -        goto free_timeline_points;
> >>>> +    if (num_read_bo_handles) {
> >>>> +        r =3D drm_gem_objects_lookup(filp,
> >>>> + u64_to_user_ptr(wait_info->bo_read_handles),
> >>>> +                       num_read_bo_handles,
> >>>> +                       &gobj_read);
> >>>> +        if (r)
> >>>> +            goto free_timeline_points;
> >>>> +    } else {
> >>>> +        gobj_read =3D NULL;
> >>>> +    }
> >>>>   -    r =3D drm_gem_objects_lookup(filp,
> >>>> - u64_to_user_ptr(wait_info->bo_write_handles),
> >>>> -                   num_write_bo_handles,
> >>>> -                   &gobj_write);
> >>>> -    if (r)
> >>>> -        goto put_gobj_read;
> >>>> +    if (num_write_bo_handles) {
> >>>> +        r =3D drm_gem_objects_lookup(filp,
> >>>> + u64_to_user_ptr(wait_info->bo_write_handles),
> >>>> +                       num_write_bo_handles,
> >>>> +                       &gobj_write);
> >>>> +        if (r)
> >>>> +            goto put_gobj_read;
> >>>> +    } else {
> >>>> +        gobj_write =3D NULL;
> >>>> +    }
> >>>>         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> >>>>                 (num_read_bo_handles + num_write_bo_handles));
> >>>
> >
>
