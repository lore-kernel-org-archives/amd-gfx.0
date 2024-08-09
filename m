Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F68BC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 17:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD4710E9CC;
	Fri,  9 Aug 2024 17:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b="UbKuItWV";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257C610E9CC
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 17:59:34 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a7a8553db90so292006766b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Aug 2024 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gfxstrand-net.20230601.gappssmtp.com; s=20230601; t=1723226372; x=1723831172;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v+e2pUhCX02+mLU0L35+455NtrZPmWPoZC4zHRvbgQY=;
 b=UbKuItWV0G1qz7weFMzCm+Uc6DJsAZG0vKXVLsVkmVDSBf8bs5jcjUAyGmVnqHTUsK
 0uoNxoGoy2n+lHkMJj+67DTZYiu0XfnWt9/EDlTxq8qVPXGR5yUH3OEkmbuQhMzTZJ/+
 rRyS+itks0PwMqEglTKhAWpbAaTPaftuNmgog9oZHHbE8Wwq5XE4TgMfAiZsfnPHu06L
 V0pelmZUfdCWASXWRGq603ZkWVY5b+tqOs0BABGJO+WW95OTfk1zZnKo0eHSH2EUPI/l
 np4BxtGrfZamgeKGnjKfa8xULWrpavnjT15T469kSb1VE9SseQ7uw/m9TILM8TlnFJmH
 OPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226372; x=1723831172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+e2pUhCX02+mLU0L35+455NtrZPmWPoZC4zHRvbgQY=;
 b=sJ1E7ZjCN27uU8DCJmD3GJ9DjZ6MONGjEtY86ZOerwxuIrMJc4R3l3n+m07MlyX+Qb
 sI2RlarxT1pyRUWCVt+HE875t7gx7W9eNTM5ml2YbnEAZrzJB5uK5UZv7Cyj8A5zHzMV
 +9V4Pv9SgTg93a8aDj+EK4f5jzrQZNah07y2puX2ttYionvUwqd3QyxrxqJd6AgwgjHh
 jaQaEnNGLgjy31J8RJ/I9Nag6xEAfOeW720WEVXPK3OLDLjwsnwKgEi5OXBM62WHHKUA
 /ZMWu8G64lwyA4jV/3CBuBYgrdsz7MQaxoMf8pBfma6tu05CIhDvf1kN/rXoOYbCkgVl
 2qpg==
X-Gm-Message-State: AOJu0YzmpH5ItXfnVxtemuCeWkahYGEReA4JX0J8ZTTgKuI+HUQ4zcsG
 Mga+5sYJehxB0rQ5CsbJbjUeCc4piDdQGlvmvn6XzC9chhjp0dUDnVaktkedlPzpn4woiR83pBo
 kuv5Zz/3a7uXlPg6UqGXCRca7LYTMs7Fh/ayqyLbMLawFM28w
X-Google-Smtp-Source: AGHT+IFsWUBdq4RkzKaJV73EsqpiUqTrgOQMaX3dx+mqheZMI0oEf151+uez2kwHdSy5NmUgqwDiH/a9wuBHAwlDij4=
X-Received: by 2002:a17:906:bc11:b0:a7a:af5d:f312 with SMTP id
 a640c23a62f3a-a80aa65fe58mr181647666b.46.1723226371284; Fri, 09 Aug 2024
 10:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
 <20240808010905.439060-5-bas@basnieuwenhuizen.nl>
In-Reply-To: <20240808010905.439060-5-bas@basnieuwenhuizen.nl>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Fri, 9 Aug 2024 12:59:19 -0500
Message-ID: <CAOFGe97aeYNXCXDj99irH0==yBe-kPQZZFu1OXNDSee8ng3pNw@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: Add UAPI for disabling implicit sync per
 submission.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, airlied@gmail.com,
 friedrich.vock@gmx.de
Content-Type: multipart/alternative; boundary="000000000000ba7c64061f43e789"
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

--000000000000ba7c64061f43e789
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:09=E2=80=AFPM Bas Nieuwenhuizen <bas@basnieuwenhui=
zen.nl>
wrote:

> Per submission flag because:
>
> 1) Slightly simpler & more flexible than per context flag.
> 2) We'd need to extend the per-BO struct if we want to put
>    it there.
> 3) Doing it per BO is annoying implementation wise as we
>    disassociate it from the BO list before doing the fences.
> 4) I don't really anticipate an usecase for doing it per BO.
>    (e.g. I don't think we need to selectively do implicit in
>     radv and I don't see radeonsi tracking READ vs. WRITE at
>     this point.)
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  include/uapi/drm/amdgpu_drm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 96e32dafd4f0..d91fa707575c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -610,6 +610,12 @@ struct drm_amdgpu_gem_va {
>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>  #define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>
> +
> +#define AMDGPU_CS_FLAGS_MASK       0x1
> +/* Disable implicit sync on BOs wrt other
> + * submissions. */
> +#define AMDGPU_CS_NO_IMPLICIT_SYNC 1
>

In my UAPI patch, I also threw a comment on the BO flag documenting that
it's not a great thing to use.  Some sort of documentation for future
generations would be nice

Otherwise, the UAPI is

Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>


> +
>  struct drm_amdgpu_cs_chunk {
>         __u32           chunk_id;
>         __u32           length_dw;
> --
> 2.45.2
>
>

--000000000000ba7c64061f43e789
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Aug 7, 2024 at 8:09=E2=80=AFPM Bas Nieuwenhuizen &lt;<a href=
=3D"mailto:bas@basnieuwenhuizen.nl">bas@basnieuwenhuizen.nl</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Per submission f=
lag because:<br>
<br>
1) Slightly simpler &amp; more flexible than per context flag.<br>
2) We&#39;d need to extend the per-BO struct if we want to put<br>
=C2=A0 =C2=A0it there.<br>
3) Doing it per BO is annoying implementation wise as we<br>
=C2=A0 =C2=A0disassociate it from the BO list before doing the fences.<br>
4) I don&#39;t really anticipate an usecase for doing it per BO.<br>
=C2=A0 =C2=A0(e.g. I don&#39;t think we need to selectively do implicit in<=
br>
=C2=A0 =C2=A0 radv and I don&#39;t see radeonsi tracking READ vs. WRITE at<=
br>
=C2=A0 =C2=A0 this point.)<br>
<br>
Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen=
.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
---<br>
=C2=A0include/uapi/drm/amdgpu_drm.h | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 96e32dafd4f0..d91fa707575c 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -610,6 +610,12 @@ struct drm_amdgpu_gem_va {<br>
=C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL=C2=A0 0x09<br>
=C2=A0#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW=C2=A0 =C2=A00x0a<br>
<br>
+<br>
+#define AMDGPU_CS_FLAGS_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x1<br>
+/* Disable implicit sync on BOs wrt other<br>
+ * submissions. */<br>
+#define AMDGPU_CS_NO_IMPLICIT_SYNC 1<br></blockquote><div><br></div><div>I=
n my UAPI patch, I also threw a comment on the BO flag documenting that it&=
#39;s not a great thing to use.=C2=A0 Some sort of documentation for future=
 generations would be nice</div><div><br></div><div>Otherwise, the UAPI is<=
/div><div><br></div><div>Reviewed-by: Faith Ekstrand &lt;<a href=3D"mailto:=
faith.ekstrand@collabora.com">faith.ekstrand@collabora.com</a>&gt;<br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0struct drm_amdgpu_cs_chunk {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
hunk_id;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l=
ength_dw;<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div>

--000000000000ba7c64061f43e789--
