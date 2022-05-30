Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66768C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 20:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E877811218E;
	Mon, 30 May 2022 20:16:54 +0000 (UTC)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525C4112183
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 20:16:53 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id 2so12260156iou.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c7s1JR54FeXGpZ2vzEInLDB+hcSDWkMLrLy8UlS3F60=;
 b=qjEeIy0D2aNraW63dzqz9Qffn/mz98aDgUj594VUf0QRzTV1gIy0ccW6jxWcrQXB0N
 j6Tf31sRx44Yp/WWqg8frVIB5jRq1smqiVQwCSuA1oj88FWLwJG8ZU6A6ODS5D3GTzrz
 VnDix9B6P3AliBzmekx9zFLVqkwLGi1MgVJZjBkJ60l0xqWkGMUv8FXeO7iCxV+m8GdB
 VyOqVCGYxOmkSzFI8FAT1XoYL87oMYh9OC5dl2ZnPZ8pwFpuvd2bkvIS6AA3QUd7+P71
 2eTHS1nakZYg8xDJMN1XimyCBHBE94LzYrt0Bznyefk9nXS3DHGLpwMCK4E5kwhAxkRW
 RfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c7s1JR54FeXGpZ2vzEInLDB+hcSDWkMLrLy8UlS3F60=;
 b=vy8Q6LgqS7955OSuIljFe1qvx9Vygna8mJVwh7v/OX4/z02kYE+JvYDaZyybziFKa9
 shR73eNp/wkIgDzoYsBlTiXiDYl4Fhi/ANPBH5MmBfKLTbHWZo3Ye/5D4kzdrnMKnQzA
 yC0ivuUBuY1PsEK+5s+hZJ4ud+ENvJ1SYe/7qf/sHbvdjnZHhm1hK++Dpl/7DWqTvP2i
 RDFWZpEnuTvOztlrqJ9LuF3uVmby8bJhWkBYl2JpO2flg+V0NWFgF6MNJLpslxzV3bBc
 iphGc5I5JLh0kAp0Q7OIOi1jc9N8xpMfLN2b3j1Wo8jWpoB8gmeA27+/UCmqG3vLaJ/7
 9l2A==
X-Gm-Message-State: AOAM530TdMEdEykEjIun0uQ1+xYW7/DKLJVYV87xz8+5V/iadS01VyQJ
 VOjsstD6GAVwPdQ8tzAQg+AMFN4bXrsQWDx3WXhFj/Ox
X-Google-Smtp-Source: ABdhPJzTfNi40BRuvRDywL0NPB5V1Tzd7W6hkdF2dXpCQ489/BNmf/kP36nhOE95/HU6weUvKMhPUzXpZIaXDqMnew0=
X-Received: by 2002:a05:6638:250d:b0:330:a268:e76 with SMTP id
 v13-20020a056638250d00b00330a2680e76mr15409697jat.115.1653941812696; Mon, 30
 May 2022 13:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220530180233.2447918-1-sunil.khatri@amd.com>
In-Reply-To: <20220530180233.2447918-1-sunil.khatri@amd.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 30 May 2022 22:16:41 +0200
Message-ID: <CAD=4a=XJJYbsswfrBMpWi14gKJmE9DJzYAj-BJtH5A7totUtXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable tmz by default for skyrim
To: Sunil Khatri <sunil.khatri@amd.com>
Content-Type: multipart/alternative; boundary="000000000000399c9e05e040566b"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000399c9e05e040566b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Skyrim is maybe not the best code name ever for a GPU, perhaps not include
it upstream if it's not official?

Regards
//Ernst

Den m=C3=A5n 30 maj 2022 kl 20:03 skrev Sunil Khatri <sunil.khatri@amd.com>=
:

> Enable tmz feature by default for skyrim
> i.e IP GC 10.3.7
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 798c56214a23..aebc384531ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -518,6 +518,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(9, 1, 0):
>         /* RENOIR looks like RAVEN */
>         case IP_VERSION(9, 3, 0):
> +       /* GC 10.3.7 */
> +       case IP_VERSION(10, 3, 7):
>                 if (amdgpu_tmz =3D=3D 0) {
>                         adev->gmc.tmz_enabled =3D false;
>                         dev_info(adev->dev,
> @@ -540,8 +542,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(10, 3, 1):
>         /* YELLOW_CARP*/
>         case IP_VERSION(10, 3, 3):
> -       /* GC 10.3.7 */
> -       case IP_VERSION(10, 3, 7):
>                 /* Don't enable it by default yet.
>                  */
>                 if (amdgpu_tmz < 1) {
> --
> 2.25.1
>
>

--000000000000399c9e05e040566b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Skyrim is maybe not the best code name ever for a GPU, =
perhaps not include it upstream if it&#39;s not official?</div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-s=
erif">Regards</div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif">//Ernst<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Den m=C3=A5n 30 maj 2022 kl 20:03 sk=
rev Sunil Khatri &lt;<a href=3D"mailto:sunil.khatri@amd.com">sunil.khatri@a=
md.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Enable tmz feature by default for skyrim<br>
i.e IP GC 10.3.7<br>
<br>
Signed-off-by: Sunil Khatri &lt;<a href=3D"mailto:sunil.khatri@amd.com" tar=
get=3D"_blank">sunil.khatri@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 798c56214a23..aebc384531ac 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -518,6 +518,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_VERSION(9, 1, 0):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RENOIR looks like RAVEN */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_VERSION(9, 3, 0):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* GC 10.3.7 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IP_VERSION(10, 3, 7):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_tmz =3D=
=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 adev-&gt;gmc.tmz_enabled =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_info(adev-&gt;dev,<br>
@@ -540,8 +542,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_VERSION(10, 3, 1):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* YELLOW_CARP*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_VERSION(10, 3, 3):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* GC 10.3.7 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case IP_VERSION(10, 3, 7):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t enable=
 it by default yet.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_tmz &lt;=
 1) {<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--000000000000399c9e05e040566b--
