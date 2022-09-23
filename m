Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C86C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 06:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CEB89854;
	Fri, 23 Sep 2022 06:24:02 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF1889854
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 06:23:59 +0000 (UTC)
Received: by mail-ua1-x92e.google.com with SMTP id f12so4513309uam.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=dgy3+0OuY6j7oNReQtMlNQ6m6PnY9PkHIM7luT9AUSI=;
 b=S1XVI4JDJZy+V7/ToD2ilxx4i3hmTgUVdj2hbgUgcpECl82Yck7mH+HwtWGEL+WbG0
 iEvW1Xet3TVt1t16qVcNuy2fD8Y/SO+JGqlGBd8Na7sOecQlIzgRbg1XUukQY3jkU1D+
 dJAUCtvTn6khOtkokzlrhvVfSYBy2gLaWVwHijKLdpvOe5a0B66TA8NjdY6Av2KUhRsG
 YKHu9dWyXahFe0ZK7SIcQCoOOo8rq9tE9IYT4ihzQ3XXgHoXkTdZj0gI+F2bscn9vKjP
 kIfolDLPMBDBcGebYHT/qnnjyp1zASM51PYIpG2EQbtzO/dN1AtUbzjrB66wV+BNaNKY
 au2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=dgy3+0OuY6j7oNReQtMlNQ6m6PnY9PkHIM7luT9AUSI=;
 b=w6QzK3cGkeXlMgy4GETYmobXmKIbEGtdHAy3zPeJKrkwxBGh2m2VovJmcanibXhtd5
 qH/bHpEYSjmzeKSIq/s8BP3coVwTlRG4qEAG0kLNQ4VYEXQY/n8alpY9dAFcxCxXOkju
 CAEpxEcMbgOMOCUEw8yvD8M6xCRi28i3mZFFi5sUk+jLMCgrjgMyp52RfNqNv9OeO7XD
 XYArTdVu024g8/Hulf4epAzjH6wRguVBUzbOBH1uWWU95fokXxWEnhJIm+rTZCp1e4r0
 DDu5ML+P3Z+Qo++0TAPu2Iaz9px4xz+vNTwMDsUDYjKjnqjIzfkrGlbeAxTegbkpO/oG
 kKiQ==
X-Gm-Message-State: ACrzQf2eqhcj7km3MThMrtG5MGtKK+ZIpQv9Cu8xdUBQaypAnaOJv4pB
 zlnZKDBWZOzRub2u9gkJetZ7uqFggDS4KRsvEBM=
X-Google-Smtp-Source: AMsMyM5rj+4P20bAeBq/BjBuzJgaKCRHXSHdVm8s73D8ZZPjxyudlhNTA3jLJSTifZKDs1zDNso+O2ZpSSSDZkhOca0=
X-Received: by 2002:ab0:14ad:0:b0:39f:255c:2ea9 with SMTP id
 d42-20020ab014ad000000b0039f255c2ea9mr2844699uae.52.1663914238691; Thu, 22
 Sep 2022 23:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220922230452.3903316-1-ytht.net@gmail.com>
 <7526e4ba-1022-d921-9138-257c369cc172@amd.com>
 <CALqoU4y-3dWJ-gR8RxUFry9KpT+FMNDfb4WmvEoK5bc56ueUvw@mail.gmail.com>
 <8fd109a0-bf1d-befd-a9b5-c02c2104df25@amd.com>
In-Reply-To: <8fd109a0-bf1d-befd-a9b5-c02c2104df25@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 23 Sep 2022 02:23:22 -0400
Message-ID: <CAAxE2A7jgTq_TiqK+V7aYPMd7rW2xATJSyVRcyRXpXreo3o4eQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Always align dumb buffer at PAGE_SIZE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="000000000000224e6b05e9523928"
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 lepton <ytht.net@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000224e6b05e9523928
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The kernel could report the true alignment from the ioctl instead of 0.

Marek

On Fri, Sep 23, 2022 at 1:31 AM Christian K=C3=B6nig <christian.koenig@amd.=
com>
wrote:

> Am 23.09.22 um 07:28 schrieb lepton:
> > On Thu, Sep 22, 2022 at 10:14 PM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 23.09.22 um 01:04 schrieb Lepton Wu:
> >>> Since size has been aligned to PAGE_SIZE already, just align it
> >>> to PAGE_SIZE so later the buffer can be used as a texture in mesa
> >>> after
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcgit.=
freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%3Df7a4051b8&amp;data=3D05%7C=
01%7Cchristian.koenig%40amd.com%7C645f6878a7bd487588b708da9d246c4c%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637995077041120091%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3=
000%7C%7C%7C&amp;sdata=3DNMEAl8TByDLQFWW1d%2FaJfiGrXc4mpwL5dxNH0M0QH84%3D&a=
mp;reserved=3D0
> >>> Otherwise, si_texture_create_object will fail at line
> >>> "buf->alignment < tex->surface.alignment"
> >> I don't think that those Mesa checks are a good idea in the first plac=
e.
> >>
> >> The alignment value is often specified as zero when it doesn't matter
> >> because the minimum alignment can never be less than the page size.
> > Are you suggesting to change those mesa checks?
>
> Yes, the minimum alignment of allocations is always 4096 because that's
> the page size of the GPU.
>
> > While that can be
> > done, I still think a kernel side "fix" is still
> > useful since it doesn't hurt while can fix issues for some versions of
> mesa.
>
> No, we have tons of places where we don't specify and alignment for
> buffers because it never mattered. I certainly don't want to fix all of
> those.
>
> Regards,
> Christian.
>
> >> Christian.
> >>
> >>> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> index 8ef31d687ef3b..8dca0c920d3ce 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> @@ -928,7 +928,7 @@ int amdgpu_mode_dumb_create(struct drm_file
> *file_priv,
> >>>        args->size =3D ALIGN(args->size, PAGE_SIZE);
> >>>        domain =3D amdgpu_bo_get_preferred_domain(adev,
> >>>                                amdgpu_display_supported_domains(adev,
> flags));
> >>> -     r =3D amdgpu_gem_object_create(adev, args->size, 0, domain, fla=
gs,
> >>> +     r =3D amdgpu_gem_object_create(adev, args->size, PAGE_SIZE,
> domain, flags,
> >>>                                     ttm_bo_type_device, NULL, &gobj);
> >>>        if (r)
> >>>                return -ENOMEM;
>
>

--000000000000224e6b05e9523928
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The kernel could report the true alignment from the i=
octl instead of 0.</div><div><br></div><div>Marek<br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 23, =
2022 at 1:31 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig=
@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Am 23.09.22 um 07:28 schrieb lepton:<br>
&gt; On Thu, Sep 22, 2022 at 10:14 PM Christian K=C3=B6nig<br>
&gt; &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">chri=
stian.koenig@amd.com</a>&gt; wrote:<br>
&gt;&gt; Am 23.09.22 um 01:04 schrieb Lepton Wu:<br>
&gt;&gt;&gt; Since size has been aligned to PAGE_SIZE already, just align i=
t<br>
&gt;&gt;&gt; to PAGE_SIZE so later the buffer can be used as a texture in m=
esa<br>
&gt;&gt;&gt; after <a href=3D"https://nam11.safelinks.protection.outlook.co=
m/?url=3Dhttps%3A%2F%2Fcgit.freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%=
3Df7a4051b8&amp;amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7C645f6878a=
7bd487588b708da9d246c4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637995=
077041120091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DNMEAl8TByDLQFW=
W1d%2FaJfiGrXc4mpwL5dxNH0M0QH84%3D&amp;amp;reserved=3D0" rel=3D"noreferrer"=
 target=3D"_blank">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Fcgit.freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%3Df7a4051b8=
&amp;amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7C645f6878a7bd487588b7=
08da9d246c4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63799507704112009=
1%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DNMEAl8TByDLQFWW1d%2FaJfiG=
rXc4mpwL5dxNH0M0QH84%3D&amp;amp;reserved=3D0</a><br>
&gt;&gt;&gt; Otherwise, si_texture_create_object will fail at line<br>
&gt;&gt;&gt; &quot;buf-&gt;alignment &lt; tex-&gt;surface.alignment&quot;<b=
r>
&gt;&gt; I don&#39;t think that those Mesa checks are a good idea in the fi=
rst place.<br>
&gt;&gt;<br>
&gt;&gt; The alignment value is often specified as zero when it doesn&#39;t=
 matter<br>
&gt;&gt; because the minimum alignment can never be less than the page size=
.<br>
&gt; Are you suggesting to change those mesa checks?<br>
<br>
Yes, the minimum alignment of allocations is always 4096 because that&#39;s=
 <br>
the page size of the GPU.<br>
<br>
&gt; While that can be<br>
&gt; done, I still think a kernel side &quot;fix&quot; is still<br>
&gt; useful since it doesn&#39;t hurt while can fix issues for some version=
s of mesa.<br>
<br>
No, we have tons of places where we don&#39;t specify and alignment for <br=
>
buffers because it never mattered. I certainly don&#39;t want to fix all of=
 <br>
those.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Lepton Wu &lt;<a href=3D"mailto:ytht.net@gmail.=
com" target=3D"_blank">ytht.net@gmail.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-<br=
>
&gt;&gt;&gt;=C2=A0 =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt;&gt; index 8ef31d687ef3b..8dca0c920d3ce 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt;&gt; @@ -928,7 +928,7 @@ int amdgpu_mode_dumb_create(struct drm_fil=
e *file_priv,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;size =3D ALIGN(args-&gt;si=
ze, PAGE_SIZE);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 domain =3D amdgpu_bo_get_preferred_=
domain(adev,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_display_supported_d=
omains(adev, flags));<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_gem_object_create(adev, args=
-&gt;size, 0, domain, flags,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_gem_object_create(adev, args=
-&gt;size, PAGE_SIZE, domain, flags,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttm_bo=
_type_device, NULL, &amp;gobj);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
-ENOMEM;<br>
<br>
</blockquote></div>

--000000000000224e6b05e9523928--
