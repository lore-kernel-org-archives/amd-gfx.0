Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71254C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 21:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BD410E102;
	Mon, 27 Mar 2023 21:15:49 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5B3B10E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 21:15:48 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id y4so41786944edo.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679951747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7x8dR54kFbaKXgT2PvjpCCg9qt2D82lU1ztMQzvJaLM=;
 b=Phh0gD47ZxEaq7+HhySzUAzuqR0XBaKgsw8vT87iOOcScAjNmoDovsD/h1jwDVLwn4
 4Zst3Pw202bUJxS+lzpXwKZ2bWJSuWQW0z6Rq5K/upClLG5cn/2zHuhRPmK9VrcnThSi
 7jo3tB7tkonqk4Qrl511DQkVWm6al6MHidi7XHRwfvwjPuUL3U+5XiDaDg3mh4XaNbYO
 TCWokgwYAhCQcMjQkZXmlzwl8bvR7nAt5NUDB/6XdcSJnZdJPbXHt4m6GMPjh3ygt47H
 PUJeBmO0B66ne+MdC26LZlbtQ/YCAFEIU/8crHRV/HxE0o97Zc9x+/2ozbcUlWrY+wEi
 P/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679951747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7x8dR54kFbaKXgT2PvjpCCg9qt2D82lU1ztMQzvJaLM=;
 b=Z3bedkhQYM8Fr+KeD4/3Igfx4Jh6XvOh6aVO+cS69ioUoAaegZslgmZyhcgSv0gWdU
 UW1JHo7SSHIEdEZqCbrqbPlSPZnzQe9nZrlcqWmxYgsuo3ehM+jeDQ09dWgLBOSK8Ufh
 s4N7a8JkLd0DdYdwJh7+ZR79+x0OyBJ6UdHDlpJ3OQ0Tz7WuRlu0YU8z29+zcll9TH8d
 pLppSDG8DPFIPAN9+iEIyFZk14h/I8c+tpSFWxLEWIppzh4FXCsTaJQiWfdJa/QVsbyN
 zGaHYJeG22T8WWTNW2mbROoo0gBEMvuRerWs+mc3j3mRQLq++Z/IkhTlUqS2seyK5fQP
 yF8A==
X-Gm-Message-State: AAQBX9dmAwqh24i5HZ+bqhzm5I4Ftd6vJ8ZkvVpvUE+Z9Xv9ZnDqaJ5F
 eg1Jg2bKT5C+z+pdHzDgX9LoIEDG0OQrjkpZwXE9WKwq
X-Google-Smtp-Source: AKy350YI+U4SniWyl65fDq2Qv/7pxQ58Ge7IslnrwI3+3vQAMTQn4QDxwPPKqwoR1dzTzxdqI6CNYuEBlX1W9lXVhWE=
X-Received: by 2002:a17:906:c315:b0:8eb:27de:447e with SMTP id
 s21-20020a170906c31500b008eb27de447emr5924879ejz.7.1679951746796; Mon, 27 Mar
 2023 14:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
 <20230323214034.1169310-8-alexander.deucher@amd.com>
In-Reply-To: <20230323214034.1169310-8-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 27 Mar 2023 17:15:10 -0400
Message-ID: <CAAxE2A7m0ERp_8+++ytWcqJgtN_EuJEApu89cjGw23BYBuOuzQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] drm/amdgpu: add UAPI to query GFX shadow sizes
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="0000000000001b917205f7e83faf"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000001b917205f7e83faf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

On Thu, Mar 23, 2023 at 5:41=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com>
wrote:

> Add UAPI to query the GFX shadow buffer requirements
> for preemption on GFX11.  UMDs need to specify the shadow
> areas for preemption.
>
> v2: move into existing asic info query
>     drop GDS as its use is determined by the UMD (Marek)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 3d9474af6566..3563c69521b0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1136,6 +1136,14 @@ struct drm_amdgpu_info_device {
>         __u64 mall_size;            /* AKA infinity cache */
>         /* high 32 bits of the rb pipes mask */
>         __u32 enabled_rb_pipes_mask_hi;
> +       /* shadow area size for gfx11 */
> +       __u32 shadow_size;
> +       /* shadow area alignment for gfx11 */
> +       __u32 shadow_alignment;
> +       /* context save area size for gfx11 */
> +       __u32 csa_size;
> +       /* context save area alignment for gfx11 */
> +       __u32 csa_alignment;
>  };
>
>  struct drm_amdgpu_info_hw_ip {
> --
> 2.39.2
>
>

--0000000000001b917205f7e83faf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:m=
arek.olsak@amd.com">marek.olsak@amd.com</a>&gt;<br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 23, 2023 at =
5:41=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.co=
m">alexander.deucher@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Add UAPI to query the GFX shadow buffer require=
ments<br>
for preemption on GFX11.=C2=A0 UMDs need to specify the shadow<br>
areas for preemption.<br>
<br>
v2: move into existing asic info query<br>
=C2=A0 =C2=A0 drop GDS as its use is determined by the UMD (Marek)<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0include/uapi/drm/amdgpu_drm.h | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 3d9474af6566..3563c69521b0 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -1136,6 +1136,14 @@ struct drm_amdgpu_info_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u64 mall_size;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* AKA infinity cache */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* high 32 bits of the rb pipes mask */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 enabled_rb_pipes_mask_hi;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* shadow area size for gfx11 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 shadow_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* shadow area alignment for gfx11 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 shadow_alignment;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* context save area size for gfx11 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 csa_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* context save area alignment for gfx11 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 csa_alignment;<br>
=C2=A0};<br>
<br>
=C2=A0struct drm_amdgpu_info_hw_ip {<br>
-- <br>
2.39.2<br>
<br>
</blockquote></div>

--0000000000001b917205f7e83faf--
