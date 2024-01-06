Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EB3C47074
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jan 2024 06:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1B110E19D;
	Sat,  6 Jan 2024 06:48:20 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E1B10E19D
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jan 2024 06:48:19 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e7e55c0f6so279178e87.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jan 2024 22:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704523697; x=1705128497; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FVk7hWTgzYxOSve/M83Fgrm7/rESL5SpmcXsZd2fj/Q=;
 b=Ewqy1bG/pC2A7RVLAvw52/gEuFd1pEQq+Gg5tRoBw5suOz2q/fL32Qr8C2z2DNhZ79
 OvaoU4jMEzDiQ5azgC44XyJ+jjiP/hhM3ueHwzjIGq6FKunPPbVzSAb2PzBMIe4o/ubx
 dZjA5f2rvk8eflohF6yqn8yOX5l1KkKIbbRi1ZidtNk+X5Lut4enlO5pkUrNhj4Kdh6v
 ZZfVxH0IN7mlFkyVYt+n69TWnx6JgLS5OS5NkKzryNUWIh8KZxQOcKUyEjpzMiln1Mb8
 hdt9dyWqmRWIvT6QN0suyqlZ21nlPO7LMkcWMKR1IhTqjuudU9vT1J/K+as/m6qdTI0I
 x+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704523697; x=1705128497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FVk7hWTgzYxOSve/M83Fgrm7/rESL5SpmcXsZd2fj/Q=;
 b=Dcl+2Ixb4w2HqJxmhbLOqDldIGOHSUfGqCcRhg5m4j3wo4vV0cV7ZpLFKYNjcE9q+q
 EvtxSmqNWlir4u0pCGP3Y5RrmfrnQ7gE3OhJu3XJ9bzx4xhoZ7byHRtyQwkxDfNx3cIW
 Vpv8b/BUQcTWWrmrvkX3FiWRlE+lRmxLoDvHpsQ1Zv2LFhku/9uD+72A1gg1RDLfPv0g
 W+hGp/syKbWnD+9m29aV8xxyEFkSOfr8S9WQae7O5y7YO6t6NuZQR51VXcvvpJNeupJI
 UC4IYhbO245nbK8ScZuTj5ZsogtR93Zr9x9rvez+hlwVdKHg7Ex/0RyLiD2qM3Jhthup
 wtDA==
X-Gm-Message-State: AOJu0YyP47P79T3KkD+XuM2SoWku8fBSmPXH6sCcRMLcHW4T2eTqWR06
 fenw0CPnJDDMhLlwkv9dQyOubdSCt161Vy57xKc=
X-Google-Smtp-Source: AGHT+IEmvG4rH9k+l19Vz/WzNRPH/eXq98hL6S4Z8BCBTOfBpsqVUzJN+ocpchfuKfgIXEuFrLYLDjVHkMy50PFqqro=
X-Received: by 2002:a19:5f14:0:b0:50e:9132:5105 with SMTP id
 t20-20020a195f14000000b0050e91325105mr86394lfb.181.1704523697233; Fri, 05 Jan
 2024 22:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
 <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
 <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
 <CAAxE2A6YdbbC0EKWTdAMLQK9tKmO3v17+yPvhqfby2P_bfH1pw@mail.gmail.com>
 <285317c2-4236-4a22-a6ba-26e2100dde54@amd.com>
In-Reply-To: <285317c2-4236-4a22-a6ba-26e2100dde54@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 6 Jan 2024 01:48:04 -0500
Message-ID: <CAAxE2A7+bJm7g+8S_Z3z99vinnSr_8CwjJs+YZVizOS94CekoA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
To: Felix Kuehling <felix.kuehling@amd.com>
Content-Type: multipart/alternative; boundary="0000000000007c2601060e4159e6"
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
Cc: Alex Deucher <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>,
 Jay Cornwall <jay.cornwall@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000007c2601060e4159e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The 32-bit address space means the high 32 bits are constant and
predetermined and it's definitely somewhere in the upper range of the
address space. If ROCm or KFD occupy that space, even accidentally, other
UMDs that use libdrm for VA allocation won't be able to start. The VA range
allocator is in libdrm.

Marek

On Fri, Jan 5, 2024, 15:20 Felix Kuehling <felix.kuehling@amd.com> wrote:

> TBA/TMA were relocated to the upper half of the canonical address space.
> I don't think that qualifies as 32-bit by definition. But maybe you're
> using a different definition.
>
> That said, if Mesa manages its own virtual address space in user mode,
> and KFD maps the TMA/TBA at an address that Mesa believes to be free, I
> can see how that would lead to problems.
>
> That said, the fence refcount bug is another problem that may have been
> exposed by the way that a crashing Mesa application shuts down.
> Reverting Jay's patch certainly didn't fix that, but only hides the
> problem.
>
> Regards,
>    Felix
>
>
> On 2024-01-04 13:29, Marek Ol=C5=A1=C3=A1k wrote:
> > Hi,
> >
> > I have received information that the original commit makes all 32-bit
> > userspace VA allocations fail, so UMDs like Mesa can't even initialize
> > and they either crash or fail to load. If TBA/TMA was relocated to the
> > 32-bit address range, it would explain why UMDs can't allocate
> > anything in that range.
> >
> > Marek
> >
> > On Wed, Jan 3, 2024 at 2:50=E2=80=AFPM Jay Cornwall <jay.cornwall@amd.c=
om>
> wrote:
> >> On 1/3/2024 12:58, Felix Kuehling wrote:
> >>
> >>> A segfault in Mesa seems to be a different issue from what's mentione=
d
> >>> in the commit message. I'd let Christian or Marek comment on
> >>> compatibility with graphics UMDs. I'm not sure why this patch would
> >>> affect them at all.
> >> I was referencing this issue in OpenCL/OpenGL interop, which certainly
> looked related:
> >>
> >> [   91.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009bba4692 va
> 0x0800000000-0x08000001ff conflict with 0x0800000000-0x0800000002
> >> [   91.769141] ocltst[2781]: segfault at b2 ip 00007f3fb90a7c39 sp
> 00007ffd3c011ba0 error 4 in radeonsi_dri.so[7f3fb888e000+1196000] likely =
on
> CPU 15 (core 7, socket 0)
> >>
> >>> Looking at the logs in the tickets, it looks like a fence reference
> >>> counting error. I don't see how Jay's patch could have caused that. I
> >>> made another change in that code recently that could make a differenc=
e
> >>> for this issue:
> >>>
> >>>      commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
> >>>      Author: Felix Kuehling <Felix.Kuehling@amd.com>
> >>>      Date:   Fri Oct 27 18:21:55 2023 -0400
> >>>
> >>>           drm/amdkfd: Run restore_workers on freezable WQs
> >>>
> >>>           Make restore workers freezable so we don't have to explicit=
ly
> >>>      flush them
> >>>           in suspend and GPU reset code paths, and we don't
> accidentally
> >>>      try to
> >>>           restore BOs while the GPU is suspended. Not having to flush
> >>>      restore_work
> >>>           also helps avoid lock/fence dependencies in the GPU reset
> case
> >>>      where we're
> >>>           not allowed to wait for fences.
> >>>
> >>>           A side effect of this is, that we can now have multiple
> >>>      concurrent threads
> >>>           trying to signal the same eviction fence. Rework eviction
> fence
> >>>      signaling
> >>>           and replacement to account for that.
> >>>
> >>>           The GPU reset path can no longer rely on
> restore_process_worker
> >>>      to resume
> >>>           queues because evict/restore workers can run independently =
of
> >>>      it. Instead
> >>>           call a new restore_process_helper directly.
> >>>
> >>>           This is an RFC and request for testing.
> >>>
> >>>           v2:
> >>>           - Reworked eviction fence signaling
> >>>           - Introduced restore_process_helper
> >>>
> >>>           v3:
> >>>           - Handle unsignaled eviction fences in restore_process_bos
> >>>
> >>>           Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >>>           Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>           Tested-by: Emily Deng <Emily.Deng@amd.com>
> >>>           Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>
> >>>
> >>> FWIW, I built a plain 6.6 kernel, and was not able to reproduce the
> >>> crash with some simple tests.
> >>>
> >>> Regards,
> >>>     Felix
> >>>
> >>>
> >>>> So I agree, let's revert it.
> >>>>
> >>>> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
>

--0000000000007c2601060e4159e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">The 32-bit address space means the high 32 bits are const=
ant and predetermined and it&#39;s definitely somewhere in the upper range =
of the address space. If ROCm or KFD occupy that space, even accidentally, =
other UMDs that use libdrm for VA allocation won&#39;t be able to start. Th=
e VA range allocator is in libdrm.<div dir=3D"auto"><br></div><div dir=3D"a=
uto">Marek</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Jan 5, 2024, 15:20 Felix Kuehling &lt;<a href=3D"ma=
ilto:felix.kuehling@amd.com">felix.kuehling@amd.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">TBA/TMA were relocated to the upper half of=
 the canonical address space. <br>
I don&#39;t think that qualifies as 32-bit by definition. But maybe you&#39=
;re <br>
using a different definition.<br>
<br>
That said, if Mesa manages its own virtual address space in user mode, <br>
and KFD maps the TMA/TBA at an address that Mesa believes to be free, I <br=
>
can see how that would lead to problems.<br>
<br>
That said, the fence refcount bug is another problem that may have been <br=
>
exposed by the way that a crashing Mesa application shuts down. <br>
Reverting Jay&#39;s patch certainly didn&#39;t fix that, but only hides the=
 problem.<br>
<br>
Regards,<br>
=C2=A0=C2=A0 Felix<br>
<br>
<br>
On 2024-01-04 13:29, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have received information that the original commit makes all 32-bit<=
br>
&gt; userspace VA allocations fail, so UMDs like Mesa can&#39;t even initia=
lize<br>
&gt; and they either crash or fail to load. If TBA/TMA was relocated to the=
<br>
&gt; 32-bit address range, it would explain why UMDs can&#39;t allocate<br>
&gt; anything in that range.<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
&gt; On Wed, Jan 3, 2024 at 2:50=E2=80=AFPM Jay Cornwall &lt;<a href=3D"mai=
lto:jay.cornwall@amd.com" target=3D"_blank" rel=3D"noreferrer">jay.cornwall=
@amd.com</a>&gt; wrote:<br>
&gt;&gt; On 1/3/2024 12:58, Felix Kuehling wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; A segfault in Mesa seems to be a different issue from what&#39=
;s mentioned<br>
&gt;&gt;&gt; in the commit message. I&#39;d let Christian or Marek comment =
on<br>
&gt;&gt;&gt; compatibility with graphics UMDs. I&#39;m not sure why this pa=
tch would<br>
&gt;&gt;&gt; affect them at all.<br>
&gt;&gt; I was referencing this issue in OpenCL/OpenGL interop, which certa=
inly looked related:<br>
&gt;&gt;<br>
&gt;&gt; [=C2=A0 =C2=A091.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009=
bba4692 va 0x0800000000-0x08000001ff conflict with 0x0800000000-0x080000000=
2<br>
&gt;&gt; [=C2=A0 =C2=A091.769141] ocltst[2781]: segfault at b2 ip 00007f3fb=
90a7c39 sp 00007ffd3c011ba0 error 4 in radeonsi_dri.so[7f3fb888e000+1196000=
] likely on CPU 15 (core 7, socket 0)<br>
&gt;&gt;<br>
&gt;&gt;&gt; Looking at the logs in the tickets, it looks like a fence refe=
rence<br>
&gt;&gt;&gt; counting error. I don&#39;t see how Jay&#39;s patch could have=
 caused that. I<br>
&gt;&gt;&gt; made another change in that code recently that could make a di=
fference<br>
&gt;&gt;&gt; for this issue:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 commit 8f08c5b24ced1be7eb49692e4816c191623=
3c79b<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Author: Felix Kuehling &lt;<a href=3D"mail=
to:Felix.Kuehling@amd.com" target=3D"_blank" rel=3D"noreferrer">Felix.Kuehl=
ing@amd.com</a>&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Date:=C2=A0 =C2=A0Fri Oct 27 18:21:55 2023=
 -0400<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm/amdkfd: Run restor=
e_workers on freezable WQs<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Make restore workers f=
reezable so we don&#39;t have to explicitly<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 flush them<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in suspend and GPU res=
et code paths, and we don&#39;t accidentally<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 try to<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0restore BOs while the =
GPU is suspended. Not having to flush<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 restore_work<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0also helps avoid lock/=
fence dependencies in the GPU reset case<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 where we&#39;re<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not allowed to wait fo=
r fences.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A side effect of this =
is, that we can now have multiple<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 concurrent threads<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trying to signal the s=
ame eviction fence. Rework eviction fence<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 signaling<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and replacement to acc=
ount for that.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The GPU reset path can=
 no longer rely on restore_process_worker<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 to resume<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queues because evict/r=
estore workers can run independently of<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 it. Instead<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0call a new restore_pro=
cess_helper directly.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is an RFC and req=
uest for testing.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v2:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Reworked eviction fe=
nce signaling<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Introduced restore_p=
rocess_helper<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v3:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Handle unsignaled ev=
iction fences in restore_process_bos<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Felix K=
uehling &lt;<a href=3D"mailto:Felix.Kuehling@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Felix.Kuehling@amd.com</a>&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Acked-by: Christian K=
=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank"=
 rel=3D"noreferrer">christian.koenig@amd.com</a>&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tested-by: Emily Deng =
&lt;<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank" rel=3D"noreferr=
er">Emily.Deng@amd.com</a>&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Alex De=
ucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" target=3D"_blank" re=
l=3D"noreferrer">alexander.deucher@amd.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; FWIW, I built a plain 6.6 kernel, and was not able to reproduc=
e the<br>
&gt;&gt;&gt; crash with some simple tests.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Felix<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; So I agree, let&#39;s revert it.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Reviewed-by: Jay Cornwall &lt;<a href=3D"mailto:jay.cornwa=
ll@amd.com" target=3D"_blank" rel=3D"noreferrer">jay.cornwall@amd.com</a>&g=
t;<br>
</blockquote></div>

--0000000000007c2601060e4159e6--
