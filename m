Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393A6C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB46F10E94B;
	Wed, 22 Mar 2023 14:08:29 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8829410E94B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:08:28 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id ew6so10508376edb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679494107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LM6M22z/r67yze3bMluUS0Pwt5BlQvO5dph0nKopHzc=;
 b=SIJVDFNnXNoDSrDPWOYnhH6bnpajeWwT4whMilBK7QdJ0F0zTIvnWpwRtVDmYWvOyR
 xGhuEHBDlnQDIH2gol8qc3OtV0s1F1BwSghKqht/n4arcXaocjCQeT6fL+/JR7qMJjf6
 g/u4qkNQDm0Vr9+n9mIEOYEdCACNZA8Wn7/tHOn1bU1fF6WTp6B/njj78rD30aVgzSYV
 U2Zc0DQBdAUpfLifLCeRkEjYcR7Wv35OZ7HUFPCTImvpHjzN5FfpPlvv17Tob2LBT32n
 CG7q9gAYCMUY+1WAxRYujD3E8g9biMdnWtNGMxe/hnA1GXx5ezK95IIt12JX7SkY2Z/D
 Uiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679494107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LM6M22z/r67yze3bMluUS0Pwt5BlQvO5dph0nKopHzc=;
 b=RJFqaZkUu5srT+7JJR1ApIiZPcbqHM5sWLmRpuJ/umg6jKUmiRJ6vZCrBCJ4D8bytX
 B8iYIp2A2XElK8D0cv5xdGaJKM8WKPQIjBfNZlMMN9hfw3CfGqH0f3IiCMzrewPAWS+m
 6mFnvw1hZz4ohbEtdjmNlDuTjqagqc0CtN1mOMa+HhCnNU1QMjocE9fpOFvHUw8rI/wb
 Ax5fCNascX9vVtyDP381i41PDV1eGk/xnx8npsJ/vIM+FT9aEGhgRdM7SNRs1CO2GXt0
 BcMtffgWkfBwe5DF5vfsLRNfu7K29+W+m4HhDRAhJCEN9nrZm1NRuAOHak/D2eREnMOK
 BJbw==
X-Gm-Message-State: AO0yUKWlmYq48ll/hLZI0zYR3ZtUW1RE/xHT5MwdFfRf/Jncek5Dm13M
 NVpUOttLM+89jXurJ2aODmjKQFjaXtaEiuQANzs=
X-Google-Smtp-Source: AK7set/wP9qYuocrLozb0ZuCPxDuz5BmXojobrHxAcBQ7dodPEKzwaxAo61rN/35apE/gz+B4+iAcZpoy/bGzayjbPw=
X-Received: by 2002:a05:6402:5212:b0:4af:6e95:85e9 with SMTP id
 s18-20020a056402521200b004af6e9585e9mr1744086edd.4.1679494107089; Wed, 22 Mar
 2023 07:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
 <CAAxE2A7enKdyE_cBsCwCFZJjSWQZgOGZYCfUT5ShZN2DGa+Qbw@mail.gmail.com>
 <CADnq5_Or8QGhBwoB-rc8_gY2g3gaX-4Fvz8VaGKnaRXfJZMCNQ@mail.gmail.com>
In-Reply-To: <CADnq5_Or8QGhBwoB-rc8_gY2g3gaX-4Fvz8VaGKnaRXfJZMCNQ@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 22 Mar 2023 10:07:50 -0400
Message-ID: <CAAxE2A6YoHEvRt_zYKmn4U5976s7tWC+TYaZA9K5V7j_Ew3rpQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a7cdbc05f77db1ea"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000a7cdbc05f77db1ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 3:54=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Mon, Mar 20, 2023 at 8:31=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com> wrote:
> >
> > On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com>
> wrote:
> >>
> >> Add UAPI to query the GFX shadow buffer requirements
> >> for preemption on GFX11.  UMDs need to specify the shadow
> >> areas for preemption.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> >> index 3d9474af6566..19a806145371 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >>         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
> >>         /* Subquery id: Encode */
> >>         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
> >> +#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE         0x22
> >
> >
> > Can you put this into the device structure instead? Let's minimize the
> number of kernel queries as much as possible.
>
> I guess, but one nice thing about this is that we can use the query as
> a way to determine if the kernel supports this functionality or not.
> If not, the query returns -ENOTSUP.
>

That should be another flag in the device info structure or the sizes
should be 0. There is never a reason to add a new single-value INFO query.

Marek

--000000000000a7cdbc05f77db1ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Mar 21, 2023 at 3:54=E2=80=AFPM Alex Deucher &lt;<a href=3D"=
mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon=
, Mar 20, 2023 at 8:31=E2=80=AFPM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mail=
to:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher &lt;<a href=3D"ma=
ilto:alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com=
</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Add UAPI to query the GFX shadow buffer requirements<br>
&gt;&gt; for preemption on GFX11.=C2=A0 UMDs need to specify the shadow<br>
&gt;&gt; areas for preemption.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deuche=
r@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 include/uapi/drm/amdgpu_drm.h | 10 ++++++++++<br>
&gt;&gt;=C2=A0 1 file changed, 10 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdg=
pu_drm.h<br>
&gt;&gt; index 3d9474af6566..19a806145371 100644<br>
&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; @@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#define AMDGPU_INFO_VIDEO_CAPS_DE=
CODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Subquery id: Encode */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#define AMDGPU_INFO_VIDEO_CAPS_EN=
CODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt;&gt; +#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x22<br>
&gt;<br>
&gt;<br>
&gt; Can you put this into the device structure instead? Let&#39;s minimize=
 the number of kernel queries as much as possible.<br>
<br>
I guess, but one nice thing about this is that we can use the query as<br>
a way to determine if the kernel supports this functionality or not.<br>
If not, the query returns -ENOTSUP.<br></blockquote><div><br></div>That sho=
uld be another flag in the device info structure or the sizes should be 0. =
There is never a reason to add a new single-value INFO query.<br></div><div=
 class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Marek<br></div>=
</div>

--000000000000a7cdbc05f77db1ea--
