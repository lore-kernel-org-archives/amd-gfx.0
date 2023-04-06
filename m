Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6190C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 07:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC5B10EAF9;
	Thu,  6 Apr 2023 07:37:04 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A4810EAFB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 07:37:01 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-935558f9f01so82453866b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Apr 2023 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680766619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gbsDqbSBHQwXTlRUAiPKDxp0WVbtKCmJGITby+obRwc=;
 b=T5F+oPR/8Te/q6DB43f2csrYX+28CfiWFPP8ZD1Az328X0K2y492+LCEvkRlmxp0nH
 5Z2+G/rGDrsv26vfWbZuVwmaMFxeAzLEmILyGwlc3aVxOr1SQTqLvFNKb6KKrF/Xh3et
 iE8ZxYFkKT3RdiLG/NBb6tU9DtA6yUHvcDHjGvUm7SJSRc5LBT90au38fdkjArhCqrsK
 jcGUQBpE9Df/evEUA2P2XRDWc5bFoMEnqQfynKXdZAQ3guuLKQY+/8AE0rJ1NNQYTmnV
 0zWgVKz5pEYBkB1LYE2egyFir91ALRnNWgYKKCzWlu0mBtXjI2MEjhsdmgkAdzUrjxEa
 oJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680766619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbsDqbSBHQwXTlRUAiPKDxp0WVbtKCmJGITby+obRwc=;
 b=2UMsrLQpa/RkclcPy7h0x5viUXg0E9D9IF5Tc6XU9mpiLPSRrK7qSvDfGNAz5XwS+T
 5KyWYn3gDbWVSeUvT0HKUCBZBiyMIKk2m2t9UN4RjlEw624m3Yu4lrGHHgEzaxnckhTx
 2UZ31ugWC5X911M/v8+DTOFroiGGACrFj30x+zBy5IxpDCshmyHRcHnuCgOlr8vDbI1n
 W8ASfG+aYA7bdJa6hVUuInAcUbDIw4FAFSt2YK/RqSJ9XwGrMAck4RcQVktcyfRfdZdT
 92Lcfbq9FTIKvFnR/7ugXjboL8cN/MlsfqPeK5L2GCLeh3W2zULKaTHHjU2Y7pczqy7V
 Rnpw==
X-Gm-Message-State: AAQBX9fdkY04G6vzTyIc1FxF8otxC8pfDx8mJW8PBvmEAlB/jEjMXHKD
 HYMWDfWXrN3tuj1xyYdyTGiAnZ7olrOv7hz5dEpmcUFg
X-Google-Smtp-Source: AKy350Z6DnplH1dB8wFu4RmR05L5lWe6PwlmX8IRlPGk5Ze8zCqjQ2KKdtOS9rncnZmQlkoZ52/s8rZu6zsK5GfBzDU=
X-Received: by 2002:a50:9f2d:0:b0:501:c965:33bd with SMTP id
 b42-20020a509f2d000000b00501c96533bdmr2561828edf.6.1680766619426; Thu, 06 Apr
 2023 00:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
In-Reply-To: <20230330191750.1134210-4-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 6 Apr 2023 03:36:22 -0400
Message-ID: <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="0000000000004d24a905f8a5f943"
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000004d24a905f8a5f943
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

gds_va is unnecessary.

Marek

On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com>
wrote:

> For GFX11, the UMD needs to allocate some shadow buffers
> to be used for preemption.  The UMD allocates the buffers
> and passes the GPU virtual address to the kernel since the
> kernel will program the packet that specified these
> addresses as part of its IB submission frame.
>
> v2: UMD passes shadow init to tell kernel when to initialize
>     the shadow
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index b6eb90df5d05..3d9474af6566 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>  #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>
>  struct drm_amdgpu_cs_chunk {
>         __u32           chunk_id;
> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>         };
>  };
>
> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
> +
> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> +       __u64 shadow_va;
> +       __u64 csa_va;
> +       __u64 gds_va;
> +       __u64 flags;
> +};
> +
>  /*
>   *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>   *
> --
> 2.39.2
>
>

--0000000000004d24a905f8a5f943
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>gds_va is unnecessary.</div><div><br></div><div>Marek=
<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher &lt;<a href=
=3D"mailto:alexander.deucher@amd.com">alexander.deucher@amd.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">For GFX11, t=
he UMD needs to allocate some shadow buffers<br>
to be used for preemption.=C2=A0 The UMD allocates the buffers<br>
and passes the GPU virtual address to the kernel since the<br>
kernel will program the packet that specified these<br>
addresses as part of its IB submission frame.<br>
<br>
v2: UMD passes shadow init to tell kernel when to initialize<br>
=C2=A0 =C2=A0 the shadow<br>
<br>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0include/uapi/drm/amdgpu_drm.h | 10 ++++++++++<br>
=C2=A01 file changed, 10 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index b6eb90df5d05..3d9474af6566 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {<br>
=C2=A0#define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
=C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT=C2=A0 =C2=A0 0x08<br>
=C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL=C2=A0 0x09<br>
+#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW=C2=A0 =C2=A00x0a<br>
<br>
=C2=A0struct drm_amdgpu_cs_chunk {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
hunk_id;<br>
@@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0};<br>
<br>
+#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x1<br>
+<br>
+struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 shadow_va;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 csa_va;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 gds_va;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 flags;<br>
+};<br>
+<br>
=C2=A0/*<br>
=C2=A0 *=C2=A0 Query h/w info: Flag that this is integrated (a.h.a. fusion)=
 GPU<br>
=C2=A0 *<br>
-- <br>
2.39.2<br>
<br>
</blockquote></div>

--0000000000004d24a905f8a5f943--
