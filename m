Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B9FC02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 21:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E4510E1CF;
	Fri, 24 Jan 2025 21:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F9C6847W";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B8810E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 21:34:25 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-3eb9b58fbb5so402153b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737754464; x=1738359264; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WhPFzAI2YA1APOCeM6B1P3wPkrN6cXjWPr/k8PUWALE=;
 b=F9C6847WeJLKpDjJUNpDwTInf+LtTZq5lb2QUYiQ9ORgvLgoLjh7iSfSZVdmhT/8la
 6ZATsHZ/VeEEEYpGdgPjkjsNQkayGG3FRWZNSptdrXqIr5s5tgESSsZ7W+vp4CLmk//o
 sCCPYINtgPAODYRpVWoez/RQG+GH1ohq3s/Jy5Eq4UKE64dbvyFK+Za6Px7zMOK1WQ3V
 5ZMIccXiex6m6IYkvf9xTlPEbwTKDRvomb+btFE6Qe/P5JVhkn9oTn9/ZsXb0ffxhGvE
 Bpy2C5SZPaQySFlZNqkIT3Tq0TKPQuymnKpD001cU/0L3fKOyZ6dT3wdJpLhzgLiiaiL
 /Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737754464; x=1738359264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhPFzAI2YA1APOCeM6B1P3wPkrN6cXjWPr/k8PUWALE=;
 b=DNnJBZY8tSAA6x7ywd3AJSYIGVJwGlnK/YEidwOlOe+GgWBjea2DN6ZqCrwkq95IEe
 0cq/36wsNFzZO1kXR3aY0GGzPZkzWwxqjB2c2AmkFCfGo3rPOU5H3LPVQso4LeCGErt9
 TzlsLBthcclB0ogrvHt/LcTfQ+LhHy8tyEJ1pO9ZVhGToNOwo8nJUzM/4VKoXerfNqhb
 ZzEpAhmREO8x8KoEMRObTF6ooGdQbDYvs/2UP40GykcLeEoBmUwZEEGTw8yJEfx+YVZB
 jtcYI8iP71mI3DTuX2KjvvQLWWGEDPgoJ5JRq0OvRl4OaIQbNZg5Q84tZ/6cAGyVL0x+
 7kUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQkGAAhhBSzkCdpsUV750ZNLiXF3BO2dT2N3PXF0nLXNCGYUVBF82BH2Hk/rABxjmjFr13lj8q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFAwr5zYFvl6p3OJyttVcxI4APjiES04NWuMqYyhspJGv3Mbw1
 mGEcSyJM02OsFA505dpnp9p1z/aAOuEUJ9A3t/jhanCK2AJ3A50w+w2e6ygavgCGPrc4km1BgvY
 l0/FHolT4sw7MjNQEmLc5tiYDvZP99g==
X-Gm-Gg: ASbGncvfWGjgceKgYC0kyzC6HtFJY0emA2jjOkBLN5Ew7XN7kNdC0Kx/JwxGE7sHqkw
 yazlX1KjnTCAc5Kl9NV9FO7avFeDUfvkHqW2O9xkEAbP+fnvnye/75TRkzi+7804=
X-Google-Smtp-Source: AGHT+IFHpmZDmqPB70bgNLyVYLzcTVpgIEckkPHtkaYvjL7HzcHLnJRdpRcQoqJIlrbNlKdUclJRnibb93XHyycocWs=
X-Received: by 2002:a05:6808:2104:b0:3eb:75b2:1e1c with SMTP id
 5614622812f47-3f1d7ecb240mr3186722b6e.0.1737754464321; Fri, 24 Jan 2025
 13:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
 <CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com>
 <91fb8f7c-f252-40fa-85ca-e77c04a6fd31@amd.com>
 <CADnq5_NY8JLhjWV522u30iY-C90un8cNEgvryHfuZ+moR5vf5A@mail.gmail.com>
In-Reply-To: <CADnq5_NY8JLhjWV522u30iY-C90un8cNEgvryHfuZ+moR5vf5A@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 24 Jan 2025 16:33:47 -0500
X-Gm-Features: AWEUYZn3goKGWLMIV-eCWKaFYXfPZWXASx_-Wpf4X_M9nEvAxFLXxS833Ej5BQE
Message-ID: <CAAxE2A6kgb0A8j1H4Cv3EwV-cCV5Pz=sBTReW-RfM9TjxWDreg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.1.1/10.1.2 GPUs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000008d867a062c7a7d09"
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

--0000000000008d867a062c7a7d09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So it's implemented but not enabled by default, right?

Marek

On Fri, Jan 24, 2025 at 12:40=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:

> On Fri, Jan 24, 2025 at 12:38=E2=80=AFPM SRINIVASAN SHANMUGAM
> <srinivasan.shanmugam@amd.com> wrote:
> >
> >
> > On 1/24/2025 10:01 PM, Marek Ol=C5=A1=C3=A1k wrote:
> >
> > Does this commit really enable it though? Or is it just for sysfs?
> >
> > Yes it enables cleaner shader support not only sysfs.
>
> It enables the functionality in the kernel.  It can be turned on or
> manually run via sysfs.
>
> Alex
>
> >
> > Best regards,
> > Srini
> >
> > Marek
> >
> > On Fri, Jan 24, 2025 at 1:42=E2=80=AFAM Srinivasan Shanmugam <
> srinivasan.shanmugam@amd.com> wrote:
> >>
> >> Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data
> >> isolation between GPU workloads. The cleaner shader is responsible for
> >> clearing the Local Data Store (LDS), Vector General Purpose Registers
> >> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
> >> prevent data leakage and ensures accurate computation results.
> >>
> >> This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,
> >> previously available for GFX10.1.10. It enhances security by clearing
> >> GPU memory between processes and maintains a consistent GPU state acro=
ss
> >> KGD and KFD workloads.
> >>
> >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> index 1878c83ff7e3..938f7d60a0ee 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct
> amdgpu_ip_block *ip_block)
> >>         }
> >>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> >>         case IP_VERSION(10, 1, 10):
> >> +       case IP_VERSION(10, 1, 1):
> >> +       case IP_VERSION(10, 1, 2):
> >>                 adev->gfx.cleaner_shader_ptr =3D
> gfx_10_1_10_cleaner_shader_hex;
> >>                 adev->gfx.cleaner_shader_size =3D
> sizeof(gfx_10_1_10_cleaner_shader_hex);
> >>                 if (adev->gfx.me_fw_version >=3D 101 &&
> >> --
> >> 2.34.1
> >>
>

--0000000000008d867a062c7a7d09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>So it&#39;s implemented but not enabled by default, r=
ight?<br></div><div><br></div><div>Marek<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 24, 2025 at 1=
2:40=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" t=
arget=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Fri, Jan 24, 2025 at 12:38=E2=80=
=AFPM SRINIVASAN SHANMUGAM<br>
&lt;<a href=3D"mailto:srinivasan.shanmugam@amd.com" target=3D"_blank">srini=
vasan.shanmugam@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 1/24/2025 10:01 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt;<br>
&gt; Does this commit really enable it though? Or is it just for sysfs?<br>
&gt;<br>
&gt; Yes it enables cleaner shader support not only sysfs.<br>
<br>
It enables the functionality in the kernel.=C2=A0 It can be turned on or<br=
>
manually run via sysfs.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Srini<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
&gt; On Fri, Jan 24, 2025 at 1:42=E2=80=AFAM Srinivasan Shanmugam &lt;<a hr=
ef=3D"mailto:srinivasan.shanmugam@amd.com" target=3D"_blank">srinivasan.sha=
nmugam@amd.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide dat=
a<br>
&gt;&gt; isolation between GPU workloads. The cleaner shader is responsible=
 for<br>
&gt;&gt; clearing the Local Data Store (LDS), Vector General Purpose Regist=
ers<br>
&gt;&gt; (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps=
<br>
&gt;&gt; prevent data leakage and ensures accurate computation results.<br>
&gt;&gt;<br>
&gt;&gt; This update extends cleaner shader support to GFX10.1.1/10.1.2 GPU=
s,<br>
&gt;&gt; previously available for GFX10.1.10. It enhances security by clear=
ing<br>
&gt;&gt; GPU memory between processes and maintains a consistent GPU state =
across<br>
&gt;&gt; KGD and KFD workloads.<br>
&gt;&gt;<br>
&gt;&gt; Cc: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt;&gt; Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" =
target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Srinivasan Shanmugam &lt;<a href=3D"mailto:srinivas=
an.shanmugam@amd.com" target=3D"_blank">srinivasan.shanmugam@amd.com</a>&gt=
;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/=
drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; index 1878c83ff7e3..938f7d60a0ee 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_i=
p_block *ip_block)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (amdgpu_ip_version(adev, G=
C_HWIP, 0)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IP_VERSION(10, 1, 10):<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case IP_VERSION(10, 1, 1):<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case IP_VERSION(10, 1, 2):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-=
&gt;gfx.cleaner_shader_ptr =3D gfx_10_1_10_cleaner_shader_hex;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-=
&gt;gfx.cleaner_shader_size =3D sizeof(gfx_10_1_10_cleaner_shader_hex);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (a=
dev-&gt;gfx.me_fw_version &gt;=3D 101 &amp;&amp;<br>
&gt;&gt; --<br>
&gt;&gt; 2.34.1<br>
&gt;&gt;<br>
</blockquote></div>

--0000000000008d867a062c7a7d09--
