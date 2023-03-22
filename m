Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10C7C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968F910E383;
	Wed, 22 Mar 2023 14:12:29 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9451110E37A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:12:28 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id cy23so73440533edb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679494347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fj5yk9QUG1F410IuHhBY2QcEIlK0uz0iT4899RRrJ2c=;
 b=Dgh0K1QnD02cZXcZleYVEvnJ6KAK74/T9OjIOGLDE7Gjq8VpncDdEIFe91kDBgq4G7
 Bjk/iRuFX+AxlFgG+fGdVxsbI0kCnK5Ezj94ca2abf4PX5LTkRCp/TWzpNmB8bBaXZtE
 ev820FriOQXgvfrsvJX7O8uodYB2Oyd3MlWwoZyQpjN+w3QVpvWQ1mBa3ZTDhoy47DCu
 gdrBFIt0uUIZwt2tfdeI6Jxt8el53v3aLXfwvuxRPmIcRCRFcw9FOXN0cPxj75ExRGil
 CIbY88TJgzH9JUfsCeCarX6oenezO5MQHb7O/zh8dAotN5ZqPx9ipvq3GsnA6Kzkc/3Z
 pH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679494347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fj5yk9QUG1F410IuHhBY2QcEIlK0uz0iT4899RRrJ2c=;
 b=1rX8A43utZ3BSPcR6hMzb6m+QFfUZ+eQGWXsdgpCT4NK+8GbuggE+vXPU31e20bJ5n
 cpXCfmc7tliSD7aA4XivwNCj2qv2DwmwBclPbvuEji0Pg1YST7dXFZJTdqV+yjJkove9
 IZmx0NhIUhWTJPVhId1uCf8RWEGbjBj8m0T1PaijMW15RT8Tofq0MpMq0ZmvujHDjTrh
 pWD7weDN1CpMHwp1RVATC5a6100tgYCv/1hsfBIq6F9x+yIOfYDhnPa46IpV1eCCSiku
 wxKZRr8s0Aau8cZEfmgs2wKku/QbR4lYoGwsLC+KVdaafmBw+iUBOREfWpMYuF2qATCy
 KC1g==
X-Gm-Message-State: AO0yUKXFQsVsn4LCJdNJOhZgZ2TW5gRdBGDn0z+oVhIm7dmATijMPqoR
 m3Jzk/gWkkV9M135Ldc8KzXFwI5mqnCIhvB3VOHPqyM2
X-Google-Smtp-Source: AK7set+q+bXtey4WEX/RO5Tl/6DzrIC4qWiIcF/VZoQQA5sdZsp+IoJpumRUT0bNs1Z3Ii/KjY2NptAw9lOZ1r86+I4=
X-Received: by 2002:a50:c384:0:b0:500:547b:4e1b with SMTP id
 h4-20020a50c384000000b00500547b4e1bmr3687119edf.6.1679494346999; Wed, 22 Mar
 2023 07:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
 <CAAxE2A4oPbDtZfCg=PQhT8Et_KN2Wrs0Dz7jiLv-raeH2u9AEQ@mail.gmail.com>
 <CADnq5_N+KZrpaPL8=N+70r6dtwZywC5WmEO00a_1jEBTCmA5zg@mail.gmail.com>
In-Reply-To: <CADnq5_N+KZrpaPL8=N+70r6dtwZywC5WmEO00a_1jEBTCmA5zg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 22 Mar 2023 10:11:50 -0400
Message-ID: <CAAxE2A5m+xACjfbBA+GZF7wWss38B5=Dy_jW9sLzBf8XV_8wbA@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f48b8c05f77dbfd3"
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

--000000000000f48b8c05f77dbfd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 3:51=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Mon, Mar 20, 2023 at 8:30=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com> wrote:
> >
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
> >>
> >>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
> >>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> >> @@ -1203,6 +1204,15 @@ struct drm_amdgpu_info_video_caps {
> >>         struct drm_amdgpu_info_video_codec_info
> codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
> >>  };
> >>
> >> +struct drm_amdgpu_info_cp_gfx_shadow_size {
> >> +       __u32 shadow_size;
> >> +       __u32 shadow_alignment;
> >> +       __u32 csa_size;
> >> +       __u32 csa_alignment;
> >> +       __u32 gds_size;
> >> +       __u32 gds_alignment;
> >
> >
> > Can you document the fields? What is CSA? Also, why is GDS there when
> the hw deprecated it and replaced it with GDS registers?
>
> Will add documentation.  For reference:
> CSA (Context Save Area) - used as a scratch area for FW for saving
> various things
> Shadow - stores the pipeline state
> GDS backup - stores the GDS state used by the pipeline.  I'm not sure
> if this is registers or the old GDS memory.  Presumably the former.
>

1. The POR for gfx11 was not to use GDS memory. I don't know why it's
there, but it would be unused uapi.

2. Is it secure to give userspace write access to the CSA and shadow
buffers? In the case of CSA, it looks like userspace could break the
firmware.

Marek

--000000000000f48b8c05f77dbfd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Mar 21, 2023 at 3:51=E2=80=AFPM Alex Deucher &lt;<a href=3D"=
mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Mar 20, 2023 at =
8:30=E2=80=AFPM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.co=
m" target=3D"_blank">maraeo@gmail.com</a>&gt; wrote:<br>
&gt;<br>
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
&gt;&gt;<br>
&gt;&gt;=C2=A0 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0<br>
&gt;&gt;=C2=A0 #define AMDGPU_INFO_MMR_SE_INDEX_MASK=C2=A0 0xff<br>
&gt;&gt; @@ -1203,6 +1204,15 @@ struct drm_amdgpu_info_video_caps {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_info_video_code=
c_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];<br>
&gt;&gt;=C2=A0 };<br>
&gt;&gt;<br>
&gt;&gt; +struct drm_amdgpu_info_cp_gfx_shadow_size {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 shadow_size;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 shadow_alignment;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 csa_size;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 csa_alignment;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 gds_size;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 gds_alignment;<br>
&gt;<br>
&gt;<br>
&gt; Can you document the fields? What is CSA? Also, why is GDS there when =
the hw deprecated it and replaced it with GDS registers?<br>
<br>
Will add documentation.=C2=A0 For reference:<br>
CSA (Context Save Area) - used as a scratch area for FW for saving<br>
various things<br>
Shadow - stores the pipeline state<br>
GDS backup - stores the GDS state used by the pipeline.=C2=A0 I&#39;m not s=
ure<br>
if this is registers or the old GDS memory.=C2=A0 Presumably the former.<br=
></blockquote><div><br></div>1. The POR for gfx11 was not to use GDS memory=
. I don&#39;t know why it&#39;s there, but it would be unused uapi.</div><d=
iv class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">2. Is it secu=
re to give userspace write access to the CSA and shadow buffers? In the cas=
e of CSA, it looks like userspace could break the firmware.<br></div><div c=
lass=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Marek<br></div></=
div>

--000000000000f48b8c05f77dbfd3--
