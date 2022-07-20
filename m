Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C49EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 02:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62C610F010;
	Wed, 20 Jul 2022 02:09:27 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D6010E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 02:09:26 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id 72so15155846pge.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 19:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1G92lHn28NzyB9r6MMJvNCTtg28ZRkhnMF1IDknZpXo=;
 b=cO0W0wYxVww4Kau2/mG5XFzEbwffH86N33Ko2sIxlCPDsMhP+SqUw13oV9V7Tf0nK0
 4SEO4GFzL2wicwdT4XOZsolzoW2jJ4m5Fp0rd/JWwNItbyBe/Tbn4E1WZdgbaWm5+soc
 y8CaYVSqdjXpKua9Q9P2z1hXQVsFkmm8xf0tabf7wuu93+lbo5GR6X6lCvW7H/pBmeBK
 bkODFh+UsIBdm81/h0pOS7vUL0+z7mAIftn7maOINwq9X+JmoWFyNIt9LKcjGAzmxZH5
 sXCBA2MUm/cO6QAdtblqt3UoQqjTfYcqHeqAaUE1d2xNiwAwuZ8esFxMdoAleKMsYsLj
 shHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1G92lHn28NzyB9r6MMJvNCTtg28ZRkhnMF1IDknZpXo=;
 b=D8fzvzG4bh0ywW8XcnCFa4cy4dfRHTHU0TztZcA7RFFyxgjGj8uHsHlMG4qAte5RKY
 CA8XRWgquShfXnyGnx3zDuJvFADqbMyYiKIuWFRs7h+P++8ggNIccAoYt5zgqY9fyACn
 cW777e639ny1DlE2OyxlO2AUWdfk17fCeiie7gRd4imgcpVvj+PpUCxoX2wC9vN4qWie
 6Iq747hAj8nlLNA2TR1GE5epTWdbNH2iuZuXlgMSxfhKreuZ79+UlQuHuYf0chiad6rU
 7IwlF6+Phm7cF5rMGiU/zrVCOB+TrucJXSz/j5DtFpneK6UnK42QzhiyCcNQhvEFD9MZ
 Zb0A==
X-Gm-Message-State: AJIora8mrsn3B9Bfl4uAWPHUcIgvJLSo4qO9yvlRCWoGM7WqI/wseGG3
 BL5eJVGMwcQ1Vd6/+Xu2cX5E3g3ixog3oGeEcL8=
X-Google-Smtp-Source: AGRyM1vo2RpjPr5ACJE1Yf9J7KdwKW+/8D4rXBG0A03yViOB4q5ZBnG0Rh1JWZaNu5hSCtL1VukDTem4lDvInF//8Dg=
X-Received: by 2002:a63:6c42:0:b0:3fe:465:7a71 with SMTP id
 h63-20020a636c42000000b003fe04657a71mr31171827pgc.101.1658282965595; Tue, 19
 Jul 2022 19:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220708225549.2061140-1-alexander.deucher@amd.com>
 <CADnq5_PFtZPHkUWUNa-iBofmZV=dVj4MMuEC8NYkDKMtgen-7g@mail.gmail.com>
In-Reply-To: <CADnq5_PFtZPHkUWUNa-iBofmZV=dVj4MMuEC8NYkDKMtgen-7g@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 19 Jul 2022 22:08:49 -0400
Message-ID: <CAAxE2A5+h8hC47eyHK_1LXPbgq6JUgWVpvD5SR3Qbqt8tEFs1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add the IP discovery IP versions for HW
 INFO data
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000019fd7105e4331718"
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
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000019fd7105e4331718
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

for the series.

Marek

On Tue, Jul 19, 2022 at 3:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> Ping on this series.
>
> Alex
>
> On Fri, Jul 8, 2022 at 6:56 PM Alex Deucher <alexander.deucher@amd.com>
> wrote:
> >
> > Use the former pad element to store the IP versions from the
> > IP discovery table.  This allows userspace to get the IP
> > version from the kernel to better align with hardware IP
> > versions.
> >
> > Proposed mesa patch:
> >
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/17411/diffs?com=
mit_id=3Dc8a63590dfd0d64e6e6a634dcfed993f135dd075
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++
> >  include/uapi/drm/amdgpu_drm.h           |  3 ++-
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 4b44a4bc2fb3..7e03f3719d11 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -473,6 +473,30 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
> >
> >         result->hw_ip_version_major =3D adev->ip_blocks[i].version->maj=
or;
> >         result->hw_ip_version_minor =3D adev->ip_blocks[i].version->min=
or;
> > +
> > +       if (adev->asic_type >=3D CHIP_VEGA10) {
> > +               switch (type) {
> > +               case AMD_IP_BLOCK_TYPE_GFX:
> > +                       result->ip_discovery_version =3D
> adev->ip_versions[GC_HWIP][0];
> > +                       break;
> > +               case AMD_IP_BLOCK_TYPE_SDMA:
> > +                       result->ip_discovery_version =3D
> adev->ip_versions[SDMA0_HWIP][0];
> > +                       break;
> > +               case AMD_IP_BLOCK_TYPE_UVD:
> > +               case AMD_IP_BLOCK_TYPE_VCN:
> > +               case AMD_IP_BLOCK_TYPE_JPEG:
> > +                       result->ip_discovery_version =3D
> adev->ip_versions[UVD_HWIP][0];
> > +                       break;
> > +               case AMD_IP_BLOCK_TYPE_VCE:
> > +                       result->ip_discovery_version =3D
> adev->ip_versions[VCE_HWIP][0];
> > +                       break;
> > +               default:
> > +                       result->ip_discovery_version =3D 0;
> > +                       break;
> > +               }
> > +       } else {
> > +               result->ip_discovery_version =3D 0;
> > +       }
> >         result->capabilities_flags =3D 0;
> >         result->available_rings =3D (1 << num_rings) - 1;
> >         result->ib_start_alignment =3D ib_start_alignment;
> > diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> > index 18d3246d636e..3a2674b4a2d9 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1093,7 +1093,8 @@ struct drm_amdgpu_info_hw_ip {
> >         __u32  ib_size_alignment;
> >         /** Bitmask of available rings. Bit 0 means ring 0, etc. */
> >         __u32  available_rings;
> > -       __u32  _pad;
> > +       /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
> > +       __u32  ip_discovery_version;
> >  };
> >
> >  struct drm_amdgpu_info_num_handles {
> > --
> > 2.35.3
> >
>

--00000000000019fd7105e4331718
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak@amd.com">marek.olsak@amd.com</a>&gt;</div><div><br></div><d=
iv>for the series.</div><div><br></div><div>Marek<br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 19, =
2022 at 3:53 PM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">a=
lexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Ping on this series.<br>
<br>
Alex<br>
<br>
On Fri, Jul 8, 2022 at 6:56 PM Alex Deucher &lt;<a href=3D"mailto:alexander=
.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt; wrote=
:<br>
&gt;<br>
&gt; Use the former pad element to store the IP versions from the<br>
&gt; IP discovery table.=C2=A0 This allows userspace to get the IP<br>
&gt; version from the kernel to better align with hardware IP<br>
&gt; versions.<br>
&gt;<br>
&gt; Proposed mesa patch:<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/1=
7411/diffs?commit_id=3Dc8a63590dfd0d64e6e6a634dcfed993f135dd075" rel=3D"nor=
eferrer" target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/merge=
_requests/17411/diffs?commit_id=3Dc8a63590dfd0d64e6e6a634dcfed993f135dd075<=
/a><br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 +++++++++++++++++++=
+++++<br>
&gt;=C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 2 files changed, 26 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c<br>
&gt; index 4b44a4bc2fb3..7e03f3719d11 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -473,6 +473,30 @@ static int amdgpu_hw_ip_info(struct amdgpu_device=
 *adev,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;hw_ip_version_major =3D ad=
ev-&gt;ip_blocks[i].version-&gt;major;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;hw_ip_version_minor =3D ad=
ev-&gt;ip_blocks[i].version-&gt;minor;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type &gt;=3D CHIP_VEGA10=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (type) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP_BL=
OCK_TYPE_GFX:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[GC_H=
WIP][0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP_BL=
OCK_TYPE_SDMA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[SDMA=
0_HWIP][0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP_BL=
OCK_TYPE_UVD:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP_BL=
OCK_TYPE_VCN:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP_BL=
OCK_TYPE_JPEG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[UVD_=
HWIP][0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP_BL=
OCK_TYPE_VCE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[VCE_=
HWIP][0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0result-&gt;ip_discovery_version =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;ip_=
discovery_version =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;capabilities_flags =3D 0;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;available_rings =3D (1 &lt=
;&lt; num_rings) - 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;ib_start_alignment =3D ib_=
start_alignment;<br>
&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h<br>
&gt; index 18d3246d636e..3a2674b4a2d9 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -1093,7 +1093,8 @@ struct drm_amdgpu_info_hw_ip {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ib_size_alignment;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Bitmask of available rings. Bit 0=
 means ring 0, etc. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 available_rings;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 _pad;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/** version info: bits 23:16 major, 15:8 m=
inor, 7:0 revision */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ip_discovery_version;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct drm_amdgpu_info_num_handles {<br>
&gt; --<br>
&gt; 2.35.3<br>
&gt;<br>
</blockquote></div>

--00000000000019fd7105e4331718--
