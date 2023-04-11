Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4956DC77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 13:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E831010E55E;
	Tue, 11 Apr 2023 13:49:20 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24C210E0FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:07:12 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-24677293d0fso372421a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681204032; x=1683796032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DOW4sOwMTiwK/cdEQqGB1XYQrQYGzE9sU0p5049ZEeY=;
 b=Yo6BQPGqrOzA8ezxNPcROxmQJwPxcmZgU6bBOBHXlKVteH7tYgEniXbm+xSTrn2HoI
 JsHAzcGxy8G49MhJn5DoBbOA4yDv1cpEoc7N1CCpercIXO8JNEr9IGL6OMiLy8moOBGY
 vtf6GqylgBjvPh/dqvzJlfZInOjrxXFTidz+59yeQByRjE6xDfGHIVcJsw8UP4HEhm74
 H2L6dodXyG0VvbmZq92m/0lKdrA3BPuoa6VyZjdSM10AhpLcAbK8Np/o693NydsGyHfj
 j3aeVsyMcWoA8J4yXjh7vhP6EKHTjItzgYSO3Jiv2lYKUV7yjbzbinrQl1K9ZMYyyuyR
 gRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681204032; x=1683796032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DOW4sOwMTiwK/cdEQqGB1XYQrQYGzE9sU0p5049ZEeY=;
 b=K65EKnbuK/jcYX0409dcW7anByij6rKV1GLOzmOc6bqsf2rlr8YzL2tePQJM1QMdQD
 97mR6vW9N6DTAJPF6pYLSlCGb7WOwMrMyTU+33uPrSLhh2YB5SIsZPg/HQRT9bUbYDxb
 yDEtUQjUr/MAleS0ZrQq5pyda1G4bpD/QtVRXJl1uTPIgeY6tRzTZXaFF6+ZI8YsujJB
 /6a/ZgQjtCUFmknT83bvGsP7ONCUSRfxcpi/bMmM0zQbDrJims33QK3d3MqXIDyaRS06
 V2+FIFWJfhBR071lbXuM0nM91zB08vGtTSdbVEs5o6hgkybQygEaUGdI94iKuzQDvMi0
 pfyA==
X-Gm-Message-State: AAQBX9e5/33DUjcAl41J9UeUX3/GvMx24BY94JE5ET4wt/iJe0AO1wb1
 WFcN+xKuwyCR4s1MuZ6d8oVCWgedLwQxDvjrSXc=
X-Google-Smtp-Source: AKy350aMjsRjQXIMITVaCn3nKSKSPHeSxfOTUDN3zHPl8i4KCYnncPeU4XgDsxXI2cYZAtQ+19MecD0fr0rzkmNu/+4=
X-Received: by 2002:a05:6a00:18a8:b0:638:d331:f85a with SMTP id
 x40-20020a056a0018a800b00638d331f85amr1086172pfh.0.1681204031631; Tue, 11 Apr
 2023 02:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
 <20230409185956.725016-3-bas@basnieuwenhuizen.nl>
 <698f4bbc-6253-2b61-ba82-68f6e7164ef6@amd.com>
 <CAP+8YyHKxEPYqr2NwnGZ3vEf_+7NeFH7FPXCvSwdzOLrUGgdDw@mail.gmail.com>
In-Reply-To: <CAP+8YyHKxEPYqr2NwnGZ3vEf_+7NeFH7FPXCvSwdzOLrUGgdDw@mail.gmail.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Tue, 11 Apr 2023 11:06:57 +0200
Message-ID: <CAFF-SiXXvAHYGet9MQ1-UXvpX-O4ncDPRdKuOppyFsw8ESeXdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v2)
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="00000000000019b5f905f90bd13c"
X-Mailman-Approved-At: Tue, 11 Apr 2023 13:49:19 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000019b5f905f90bd13c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl> ezt =C3=ADrta (id=C5=91pont: 20=
23. =C3=A1pr.
11., Ke 10:25):

> On Tue, Apr 11, 2023 at 10:10=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:
> > > We need to introduce a new version of the info struct because
> > > libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
> > > so the mesa<->libdrm_amdgpu interface can't handle increasing the
> > > size.
> > >
> > > This info would be used by radv to figure out when we need to
> > > split a submission into multiple submissions. radv currently has
> > > a limit of 192 which seems to work for most gfx submissions, but
> > > is way too high for e.g. compute or sdma.
> >
> > Why do you need so many IBs in the first place?
> >
> > You can use sub-IBs since R600 and newer hw even supports a JUMP comman=
d
> > to chain IBs together IIRC.
>
> Couple of reasons:
>
> 1) We can't reliably use sub-IBs (both because on GFX6-7 there are
> indirect draw commands that cannot be used in sub-IBs and because the
> Vulkan API exposes sub-IBs, so we can have the primary IBs be sub-IBs
> already)
>

Furthermore, only the GFX queue supports the "IB2" packet that is used to
implement sub-IBs.

(The same packet hangs the compute queue and is documented as not working
in the PAL source code. Other queues don't seem to have a packet for this
purpose.)

2) We believed GFX6 may not support chaining. (Then again, it turns
> out the GFX7+ packet may just work on GFX6?
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406)
>

I was actually quite surprised when I found this out. Mesa developers seem
to have believed that this is not possible on GFX6. I'd love to get some
more context on this, did it always work or was it added in a FW update?

3) Chaining doesn't work if the IB may be in flight multiple times in
> a different sequence.
>

Additionally, chaining also doesn't work on any queue other than GFX and
compute. As far as we know, SDMA and the various encoder/decoder queues
don't have a packet for chaining.

Christian, please let us know if we are wrong about this.


Best regards,
Timur




> We try to chain when we can but (2) and (3) are cases where we
> fallback to submitting multiple IBs.
>
> >
> > For the kernel UAPI you only need separate IBs if you have separate
> > properties on them, E.g. preamble or submitting to a different engine.
> >
> > Everything else just needs additional CPU overhead in the IOCTL.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Because the kernel handling is just fine we can just use the v2
> > > everywhere and have the return_size do the versioning for us,
> > > with userspace interpreting 0 as unknown.
> > >
> > > Userspace implementation:
> > > https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
> > > https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejectio=
n
> > >
> > > v2: Use base member in the new struct.
> > >
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> > > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > > Cc: David Airlie <airlied@gmail.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31
> ++++++++++++++-----------
> > >   include/uapi/drm/amdgpu_drm.h           | 14 +++++++++++
> > >   2 files changed, 31 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index 89689b940493..5b575e1aef1a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct
> drm_amdgpu_info_firmware *fw_info,
> > >
> > >   static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> > >                            struct drm_amdgpu_info *info,
> > > -                          struct drm_amdgpu_info_hw_ip *result)
> > > +                          struct drm_amdgpu_info_hw_ip2 *result)
> > >   {
> > >       uint32_t ib_start_alignment =3D 0;
> > >       uint32_t ib_size_alignment =3D 0;
> > > @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
> > >               return -EINVAL;
> > >       }
> > >
> > > +     result->max_ibs =3D UINT_MAX;
> > >       for (i =3D 0; i < adev->num_rings; ++i) {
> > >               /* Note that this uses that ring types alias the
> equivalent
> > >                * HW IP exposes to userspace.
> > > @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
> > >               if (adev->rings[i]->funcs->type =3D=3D
> info->query_hw_ip.type &&
> > >                   adev->rings[i]->sched.ready) {
> > >                       ++num_rings;
> > > +                     result->max_ibs =3D min(result->max_ibs,
> > > +                                           adev->rings[i]->max_ibs);
> > >               }
> > >       }
> > >
> > > @@ -452,36 +455,36 @@ static int amdgpu_hw_ip_info(struct
> amdgpu_device *adev,
> > >       num_rings =3D min(amdgpu_ctx_num_entities[info->query_hw_ip.typ=
e],
> > >                       num_rings);
> > >
> > > -     result->hw_ip_version_major =3D adev->ip_blocks[i].version->maj=
or;
> > > -     result->hw_ip_version_minor =3D adev->ip_blocks[i].version->min=
or;
> > > +     result->base.hw_ip_version_major =3D
> adev->ip_blocks[i].version->major;
> > > +     result->base.hw_ip_version_minor =3D
> adev->ip_blocks[i].version->minor;
> > >
> > >       if (adev->asic_type >=3D CHIP_VEGA10) {
> > >               switch (type) {
> > >               case AMD_IP_BLOCK_TYPE_GFX:
> > > -                     result->ip_discovery_version =3D
> adev->ip_versions[GC_HWIP][0];
> > > +                     result->base.ip_discovery_version =3D
> adev->ip_versions[GC_HWIP][0];
> > >                       break;
> > >               case AMD_IP_BLOCK_TYPE_SDMA:
> > > -                     result->ip_discovery_version =3D
> adev->ip_versions[SDMA0_HWIP][0];
> > > +                     result->base.ip_discovery_version =3D
> adev->ip_versions[SDMA0_HWIP][0];
> > >                       break;
> > >               case AMD_IP_BLOCK_TYPE_UVD:
> > >               case AMD_IP_BLOCK_TYPE_VCN:
> > >               case AMD_IP_BLOCK_TYPE_JPEG:
> > > -                     result->ip_discovery_version =3D
> adev->ip_versions[UVD_HWIP][0];
> > > +                     result->base.ip_discovery_version =3D
> adev->ip_versions[UVD_HWIP][0];
> > >                       break;
> > >               case AMD_IP_BLOCK_TYPE_VCE:
> > > -                     result->ip_discovery_version =3D
> adev->ip_versions[VCE_HWIP][0];
> > > +                     result->base.ip_discovery_version =3D
> adev->ip_versions[VCE_HWIP][0];
> > >                       break;
> > >               default:
> > > -                     result->ip_discovery_version =3D 0;
> > > +                     result->base.ip_discovery_version =3D 0;
> > >                       break;
> > >               }
> > >       } else {
> > > -             result->ip_discovery_version =3D 0;
> > > +             result->base.ip_discovery_version =3D 0;
> > >       }
> > > -     result->capabilities_flags =3D 0;
> > > -     result->available_rings =3D (1 << num_rings) - 1;
> > > -     result->ib_start_alignment =3D ib_start_alignment;
> > > -     result->ib_size_alignment =3D ib_size_alignment;
> > > +     result->base.capabilities_flags =3D 0;
> > > +     result->base.available_rings =3D (1 << num_rings) - 1;
> > > +     result->base.ib_start_alignment =3D ib_start_alignment;
> > > +     result->base.ib_size_alignment =3D ib_size_alignment;
> > >       return 0;
> > >   }
> > >
> > > @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d
> *data, struct drm_file *filp)
> > >               }
> > >               return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAUL=
T
> : 0;
> > >       case AMDGPU_INFO_HW_IP_INFO: {
> > > -             struct drm_amdgpu_info_hw_ip ip =3D {};
> > > +             struct drm_amdgpu_info_hw_ip2 ip =3D {};
> > >               int ret;
> > >
> > >               ret =3D amdgpu_hw_ip_info(adev, info, &ip);
> > > diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> > > index b6eb90df5d05..6b9e35b6f747 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
> > >       __u32 enabled_rb_pipes_mask_hi;
> > >   };
> > >
> > > +/* The size of this struct cannot be increased for compatibility
> reasons, use
> > > + * struct drm_amdgpu_info_hw_ip2 instead.
> > > + */
> > >   struct drm_amdgpu_info_hw_ip {
> > >       /** Version of h/w IP */
> > >       __u32  hw_ip_version_major;
> > > @@ -1144,6 +1147,17 @@ struct drm_amdgpu_info_hw_ip {
> > >       __u32  ip_discovery_version;
> > >   };
> > >
> > > +struct drm_amdgpu_info_hw_ip2 {
> > > +     /** Previous version of the struct */
> > > +     struct drm_amdgpu_info_hw_ip  base;
> > > +     /** The maximum number of IBs one can submit in a single
> submission
> > > +      * ioctl. (When using gang submit: this is per IP type)
> > > +      */
> > > +     __u32  max_ibs;
> > > +     /** padding to 64bit for arch differences */
> > > +     __u32  pad;
> > > +};
> > > +
> > >   struct drm_amdgpu_info_num_handles {
> > >       /** Max handles as supported by firmware for UVD */
> > >       __u32  uvd_max_handles;
> >
>

--00000000000019b5f905f90bd13c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwen=
huizen.nl">bas@basnieuwenhuizen.nl</a>&gt; ezt =C3=ADrta (id=C5=91pont: 202=
3. =C3=A1pr. 11., Ke 10:25):<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue=
, Apr 11, 2023 at 10:10=E2=80=AFAM Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank" rel=3D"no=
referrer">christian.koenig@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:<br>
&gt; &gt; We need to introduce a new version of the info struct because<br>
&gt; &gt; libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_in=
fo<br>
&gt; &gt; so the mesa&lt;-&gt;libdrm_amdgpu interface can&#39;t handle incr=
easing the<br>
&gt; &gt; size.<br>
&gt; &gt;<br>
&gt; &gt; This info would be used by radv to figure out when we need to<br>
&gt; &gt; split a submission into multiple submissions. radv currently has<=
br>
&gt; &gt; a limit of 192 which seems to work for most gfx submissions, but<=
br>
&gt; &gt; is way too high for e.g. compute or sdma.<br>
&gt;<br>
&gt; Why do you need so many IBs in the first place?<br>
&gt;<br>
&gt; You can use sub-IBs since R600 and newer hw even supports a JUMP comma=
nd<br>
&gt; to chain IBs together IIRC.<br>
<br>
Couple of reasons:<br>
<br>
1) We can&#39;t reliably use sub-IBs (both because on GFX6-7 there are<br>
indirect draw commands that cannot be used in sub-IBs and because the<br>
Vulkan API exposes sub-IBs, so we can have the primary IBs be sub-IBs<br>
already)<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Furthermore, only the GFX queue supports the &quot;IB2&quot; pack=
et that is used to implement sub-IBs.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">(The same packet hangs the compute queue and is documented as=
 not working in the PAL source code. Other queues don&#39;t seem to have a =
packet for this purpose.)</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">2) We believed =
GFX6 may not support chaining. (Then again, it turns<br>
out the GFX7+ packet may just work on GFX6?<br>
<a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.freedesktop=
.org/mesa/mesa/-/merge_requests/22406</a>)<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">I was actually quite surprised wh=
en I found this out. Mesa developers seem to have believed that this is not=
 possible on GFX6. I&#39;d love to get some more context on this, did it al=
ways work or was it added in a FW update?</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>3) Chaining doesn&#39;t work if the IB may be in flight multiple times in<=
br>
a different sequence.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Additionally, chaining also doesn&#39;t work on any qu=
eue other than GFX and compute. As far as we know, SDMA and the various enc=
oder/decoder queues don&#39;t have a packet for chaining.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Christian, please let us know if we are w=
rong about this.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Best regards,</div><div dir=3D"auto">Timur</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
We try to chain when we can but (2) and (3) are cases where we<br>
fallback to submitting multiple IBs.<br>
<br>
&gt;<br>
&gt; For the kernel UAPI you only need separate IBs if you have separate<br=
>
&gt; properties on them, E.g. preamble or submitting to a different engine.=
<br>
&gt;<br>
&gt; Everything else just needs additional CPU overhead in the IOCTL.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Because the kernel handling is just fine we can just use the v2<b=
r>
&gt; &gt; everywhere and have the return_size do the versioning for us,<br>
&gt; &gt; with userspace interpreting 0 as unknown.<br>
&gt; &gt;<br>
&gt; &gt; Userspace implementation:<br>
&gt; &gt; <a href=3D"https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tr=
ee/ib-rejection" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gi=
tlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection</a><br>
&gt; &gt; <a href=3D"https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/t=
ree/ib-rejection" rel=3D"noreferrer noreferrer" target=3D"_blank">https://g=
itlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection</a><br>
&gt; &gt;<br>
&gt; &gt; v2: Use base member in the new struct.<br>
&gt; &gt;<br>
&gt; &gt; Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/=
2498" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.freede=
sktop.org/drm/amd/-/issues/2498</a><br>
&gt; &gt; Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnie=
uwenhuizen.nl" target=3D"_blank" rel=3D"noreferrer">bas@basnieuwenhuizen.nl=
</a>&gt;<br>
&gt; &gt; Cc: David Airlie &lt;<a href=3D"mailto:airlied@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">airlied@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31 ++++++++=
++++++-----------<br>
&gt; &gt;=C2=A0 =C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 14 +++++++++++<br>
&gt; &gt;=C2=A0 =C2=A02 files changed, 31 insertions(+), 14 deletions(-)<br=
>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; &gt; index 89689b940493..5b575e1aef1a 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; &gt; @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct drm_am=
dgpu_info_firmware *fw_info,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_info *info,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_info_hw_ip *result)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_info_hw_ip2 *result)<br>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ib_start_alignment =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ib_size_alignment =3D 0;<br>
&gt; &gt; @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_de=
vice *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;max_ibs =3D UINT_MAX;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; adev-&gt;num_rings=
; ++i) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Note tha=
t this uses that ring types alias the equivalent<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * HW IP ex=
poses to userspace.<br>
&gt; &gt; @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_de=
vice *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&g=
t;rings[i]-&gt;funcs-&gt;type =3D=3D info-&gt;query_hw_ip.type &amp;&amp;<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0adev-&gt;rings[i]-&gt;sched.ready) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0++num_rings;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;max_ibs =3D min(result-&gt;max_ibs,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0adev-&gt;rings[i]-&gt;max_ibs);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; @@ -452,36 +455,36 @@ static int amdgpu_hw_ip_info(struct amdgpu_=
device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num_rings =3D min(amdgpu_ctx_num_entiti=
es[info-&gt;query_hw_ip.type],<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0num_rings);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;hw_ip_version_major =3D adev-&gt;=
ip_blocks[i].version-&gt;major;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;hw_ip_version_minor =3D adev-&gt;=
ip_blocks[i].version-&gt;minor;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.hw_ip_version_major =3D adev=
-&gt;ip_blocks[i].version-&gt;major;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.hw_ip_version_minor =3D adev=
-&gt;ip_blocks[i].version-&gt;minor;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type &gt;=3D CHIP_VEG=
A10) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (typ=
e) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP=
_BLOCK_TYPE_GFX:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[GC_HW=
IP][0];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;base.ip_discovery_version =3D adev-&gt;ip_versions[=
GC_HWIP][0];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP=
_BLOCK_TYPE_SDMA:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[SDMA0=
_HWIP][0];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;base.ip_discovery_version =3D adev-&gt;ip_versions[=
SDMA0_HWIP][0];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP=
_BLOCK_TYPE_UVD:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP=
_BLOCK_TYPE_VCN:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP=
_BLOCK_TYPE_JPEG:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[UVD_H=
WIP][0];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;base.ip_discovery_version =3D adev-&gt;ip_versions[=
UVD_HWIP][0];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_IP=
_BLOCK_TYPE_VCE:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;ip_discovery_version =3D adev-&gt;ip_versions[VCE_H=
WIP][0];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;base.ip_discovery_version =3D adev-&gt;ip_versions[=
VCE_HWIP][0];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br=
>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;ip_discovery_version =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0result-&gt;base.ip_discovery_version =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;ip_di=
scovery_version =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;base.=
ip_discovery_version =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;capabilities_flags =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;available_rings =3D (1 &lt;&lt; n=
um_rings) - 1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;ib_start_alignment =3D ib_start_a=
lignment;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;ib_size_alignment =3D ib_size_ali=
gnment;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.capabilities_flags =3D 0;<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.available_rings =3D (1 &lt;&=
lt; num_rings) - 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.ib_start_alignment =3D ib_st=
art_alignment;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.ib_size_alignment =3D ib_siz=
e_alignment;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev,=
 void *data, struct drm_file *filp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return copy=
_to_user(out, &amp;ui32, min(size, 4u)) ? -EFAULT : 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_INFO_HW_IP_INFO: {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgp=
u_info_hw_ip ip =3D {};<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgp=
u_info_hw_ip2 ip =3D {};<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br=
>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D amd=
gpu_hw_ip_info(adev, info, &amp;ip);<br>
&gt; &gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amd=
gpu_drm.h<br>
&gt; &gt; index b6eb90df5d05..6b9e35b6f747 100644<br>
&gt; &gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; &gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; &gt; @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 enabled_rb_pipes_mask_hi;<br>
&gt; &gt;=C2=A0 =C2=A0};<br>
&gt; &gt;<br>
&gt; &gt; +/* The size of this struct cannot be increased for compatibility=
 reasons, use<br>
&gt; &gt; + * struct drm_amdgpu_info_hw_ip2 instead.<br>
&gt; &gt; + */<br>
&gt; &gt;=C2=A0 =C2=A0struct drm_amdgpu_info_hw_ip {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Version of h/w IP */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 hw_ip_version_major;<br>
&gt; &gt; @@ -1144,6 +1147,17 @@ struct drm_amdgpu_info_hw_ip {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ip_discovery_version;<br>
&gt; &gt;=C2=A0 =C2=A0};<br>
&gt; &gt;<br>
&gt; &gt; +struct drm_amdgpu_info_hw_ip2 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/** Previous version of the struct */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_info_hw_ip=C2=A0 base;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/** The maximum number of IBs one can submit=
 in a single submission<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * ioctl. (When using gang submit: this is p=
er IP type)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 max_ibs;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/** padding to 64bit for arch differences */=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 pad;<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0struct drm_amdgpu_info_num_handles {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Max handles as supported by firmwar=
e for UVD */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 uvd_max_handles;<br>
&gt;<br>
</blockquote></div></div></div>

--00000000000019b5f905f90bd13c--
