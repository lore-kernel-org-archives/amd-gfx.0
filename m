Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C3C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 07:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039B610EF58;
	Fri, 12 Apr 2024 07:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rxGiqVjw";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3530E10F133
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 14:31:37 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1e5792ac18dso25275ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712845896; x=1713450696;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wFLtQzA7ODFlmIEc8GT1ddmG/9DPyIikCfzW++q04BU=;
 b=rxGiqVjwfyMGpFcnGyF+o/UlZTbUGpYFnaL4CA5hoC9N4c6VyyBPBG7wsI87w23JO9
 V+5rWCRDiO0kJyxRolBJoo0nk5UjObmKKOrjRyf/rHL/743cPD9QLh7+aoeeTJxEp6L1
 1lWHJ6SmrOBwHX1tWguUuVcTuV9WgJWknftgpg21kMwdcAM8ILV6u0g87eFqxTn3+w2S
 DYPSrilQrpjEkboLw8is2qx1RS5PeE8COfZJuPjc7OLzcLtXesd9AP7lMzINfj2ACwgO
 FIRilgdmokOSUJx6s+TfYpJoL8a3oGPJY/5CAoTN6fQcSzfnsWn5Ocf0WdyKIz51B2SU
 LMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712845896; x=1713450696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wFLtQzA7ODFlmIEc8GT1ddmG/9DPyIikCfzW++q04BU=;
 b=tGUT7gTxoelSlg1onV0PXBKVCf3Lw3fSgEjE+m8FdF3gZtnbbJpRlRI5eqoqLDHDJt
 zKuINjsi3lUMCQxbxKkfCDRHF6aEke6lHgn9snwk2W1SGWv8JY4SoP3L6I6cBWzTVcz0
 B3t6OAw5ZltRkRymDymZJc2ofNAp/CGhweWkaNzz2QnR/m6vudmDI+tHIbrxMZblfQXz
 qE1z7MJ1t2h5LTgXnyHxt01Izs9mh3OclPxZYFsY01EQVqWHQZpfdzMYzGjIlQ07rPU4
 DN4zv3gFuv1bnUX5LJf9ymUjxGrVOGPgZw61Sm/viMiDs8svY39mm2NlAfaRecax/23A
 6Pxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi4JagVGGPEETNqOq2pGuM95qBlIgCB2Den/5y02dfbz8LQzvJpGOw7bkLUwpFLhhL0lTMVWNrJZtGPyqvP2BkBanKAVl7RLaAQWIXUA==
X-Gm-Message-State: AOJu0YzPntB5mOq8vu7S7QY0d3WNnxVrc7JZypSyYMecejAdubvjNwqL
 y+rlQ/RvxjF41M2KWQMk1kfreI64ve0+Wqi3aA1No/pS19pNTBz7qt72VTT3wFM3+33aihyflcS
 RGfjAzxQRIQDb+VJV2QPpjzg4IC4LyUmjYJIa/15omgrYUARsMw==
X-Google-Smtp-Source: AGHT+IF8jHrPGqTKc/EHc/CkhCORRROxvPH6LLbwAqoXKk1zRI695pJkZWumRlV5+VQrWvFfK8dlvFS4deVkbaQgSvw=
X-Received: by 2002:a17:903:2307:b0:1e5:5cce:7eca with SMTP id
 d7-20020a170903230700b001e55cce7ecamr94942plh.8.1712845895905; Thu, 11 Apr
 2024 07:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240411032844.41839-1-xinhui.pan@amd.com>
 <81623e99-58d0-4ab8-9e8e-6b75351a6729@amd.com>
In-Reply-To: <81623e99-58d0-4ab8-9e8e-6b75351a6729@amd.com>
From: Vlad Stolyarov <hexed@google.com>
Date: Thu, 11 Apr 2024 16:31:21 +0200
Message-ID: <CAK50MR62ix+XRsBU0Rp=BqUPqZFs0-F6aJXTWyp32FpWEpA2kg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of
 amdgpu_vm_bo_clear_mappings
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jann Horn <jannh@google.com>
Cc: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com
Content-Type: multipart/alternative; boundary="0000000000002edd960615d3033a"
X-Mailman-Approved-At: Fri, 12 Apr 2024 07:44:36 +0000
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

--0000000000002edd960615d3033a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Jann Horn <jannh@google.com> for his thoughts

On Thu, Apr 11, 2024 at 12:25=E2=80=AFPM Christian K=C3=B6nig <christian.ko=
enig@amd.com>
wrote:

> Am 11.04.24 um 05:28 schrieb xinhui pan:
> > Ensure there is no address overlapping.
> >
> > Reported-by: Vlad Stolyarov <hexed@google.com>
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 8af3f0fd3073..f1315a854192 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1852,6 +1852,12 @@ int amdgpu_vm_bo_clear_mappings(struct
> amdgpu_device *adev,
> >       LIST_HEAD(removed);
> >       uint64_t eaddr;
> >
> > +     /* validate the parameters */
> > +     if (saddr & ~PAGE_MASK || size & ~PAGE_MASK)
> > +             return -EINVAL;
>
> Well as general rule: *never* use PAGE_MASK and other PAGE_* macros
> here. This is GPUVM and not related to the CPUVM space.
>
> > +     if (saddr + size <=3D saddr)
> > +             return -EINVAL;
> > +
>
> Mhm, so basically size is not checked for a wraparound?
>
> >       eaddr =3D saddr + size - 1;
> >       saddr /=3D AMDGPU_GPU_PAGE_SIZE;
> >       eaddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> If that's the case then I would rather check for saddr < eaddr here.
>
> But that actually shouldn't matter since this code here:
>
>          /* Now gather all removed mappings */
>          tmp =3D amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
>          while (tmp) {
>
> Then shouldn't return anything, so the operation is basically a NO-OP the=
n.
>
> Regards,
> Christian.
>

--0000000000002edd960615d3033a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=
=3D"mailto:jannh@google.com" tabindex=3D"-1">+Jann Horn</a>=C2=A0for his th=
oughts<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Thu, Apr 11, 2024 at 12:25=E2=80=AFPM Christian K=C3=B6nig &lt=
;<a href=3D"mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 11.=
04.24 um 05:28 schrieb xinhui pan:<br>
&gt; Ensure there is no address overlapping.<br>
&gt;<br>
&gt; Reported-by: Vlad Stolyarov &lt;<a href=3D"mailto:hexed@google.com" ta=
rget=3D"_blank">hexed@google.com</a>&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinhui.pan@amd.com" ta=
rget=3D"_blank">xinhui.pan@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 8af3f0fd3073..f1315a854192 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -1852,6 +1852,12 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_d=
evice *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0LIST_HEAD(removed);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t eaddr;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* validate the parameters */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (saddr &amp; ~PAGE_MASK || size &amp; ~PAGE_MA=
SK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
<br>
Well as general rule: *never* use PAGE_MASK and other PAGE_* macros <br>
here. This is GPUVM and not related to the CPUVM space.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (saddr + size &lt;=3D saddr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
<br>
Mhm, so basically size is not checked for a wraparound?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0eaddr =3D saddr + size - 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0saddr /=3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0eaddr /=3D AMDGPU_GPU_PAGE_SIZE;<br>
<br>
If that&#39;s the case then I would rather check for saddr &lt; eaddr here.=
<br>
<br>
But that actually shouldn&#39;t matter since this code here:<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Now gather all removed =
mappings */<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D amdgpu_vm_it_iter_=
first(&amp;vm-&gt;va, saddr, eaddr);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (tmp) {<br>
<br>
Then shouldn&#39;t return anything, so the operation is basically a NO-OP t=
hen.<br>
<br>
Regards,<br>
Christian.<br>
</blockquote></div>

--0000000000002edd960615d3033a--
