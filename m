Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA3AC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 13:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F6C10E54B;
	Tue, 11 Apr 2023 13:49:20 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963F810E080
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 11:07:07 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id e13so7159076plc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681211227; x=1683803227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ooG8ko8G3RhdS0daM88J3WJWMd0lNdkSQ08bShZlpRM=;
 b=DAy9jsiRzKw/iYM4OiMTk8o/BiyOQbJc/LSw0wU13j7IQ8VGzbJ40u2W1G9ihXtklw
 MNunLuRhZS3F2uQ4SuCo64iglw0Y0Yc6Yb05uHwf1FcPcwf+4oeCaK/Tl9NKVslgN/Od
 xlh+CV0hs0fTasui5nbgye+1mOyhFAI6DtupaRj4a9dDCDq3qNnwfP9L4h6XUryzccUe
 NxXpSzLoxzg6VXJzfvwDnrZRNrohwcfD5feLlHkPfRFLVqHNz3DsnSqZvgWr1Z4GZMYg
 EE84QIcvKN2aO28bQge9rz852RTA+6UV5ofvEvSB4X/R/41FlH3OAITceg6jej6xBYT/
 kg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681211227; x=1683803227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ooG8ko8G3RhdS0daM88J3WJWMd0lNdkSQ08bShZlpRM=;
 b=mBzZA8Mo2T0gsYPWZfbXzjhNOWKCdktFQdpOMw40OSd134qqteyYwnLAFSCdrCeDm+
 w6XREoJN+YzM+HFs6nmDFEZPlzLo3267aFTJN/YouZ91cGeLoPEC8mIWvZnKTPPFmPA3
 OfRWGcI5FuwfI5zy5Ntu7TKXjq5cqr7zA3IYEmmFvi7UTCn7CxOpsH2fE0VbCmZY/jx2
 aSCyf/USEbKDZMckESpR8caXkDP40+w95RgJQ1Z6aLcZleNqVwsaBgoj+txKCLgu5eM3
 XzcJ7iNjc9xOmWlYKERz+LZmyyB29rDxR3MVAqgG45P+hHDunFDvgs/QZDltVUtV8jaK
 RPUQ==
X-Gm-Message-State: AAQBX9dG0JKwZf3nsCBJWmxney0ytDjdvdor0XNhzPoHNUiVPgrknxWi
 anwrPvigJ1ij5d5wO4DqIjbIthM4zgrGNJmKiR4=
X-Google-Smtp-Source: AKy350azIib8NGtW4LEUfYrcmdHXXjLI3+rIsQ/ydsx9RDV7KjsnEvHzHzJ63Mk40Ghi/M98ZfGqqi870mOGKiX5VKs=
X-Received: by 2002:a17:90a:5c86:b0:246:9231:f0fd with SMTP id
 r6-20020a17090a5c8600b002469231f0fdmr2172829pji.8.1681211226508; Tue, 11 Apr
 2023 04:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
 <20230409185956.725016-3-bas@basnieuwenhuizen.nl>
 <698f4bbc-6253-2b61-ba82-68f6e7164ef6@amd.com>
 <CAP+8YyHKxEPYqr2NwnGZ3vEf_+7NeFH7FPXCvSwdzOLrUGgdDw@mail.gmail.com>
 <CAFF-SiXXvAHYGet9MQ1-UXvpX-O4ncDPRdKuOppyFsw8ESeXdw@mail.gmail.com>
 <7804aefb-bc7d-78ae-92b6-f361df2d8da2@amd.com>
In-Reply-To: <7804aefb-bc7d-78ae-92b6-f361df2d8da2@amd.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Tue, 11 Apr 2023 13:06:51 +0200
Message-ID: <CAFF-SiXc3-D5CZG+H7hbHnFm8wrFe++QnUgAMW=7agNbnp87Gw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="000000000000f2d3ce05f90d7d90"
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000f2d3ce05f90d7d90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian K=C3=B6nig <christian.koenig@amd.com> ezt =C3=ADrta (id=C5=91pont=
: 2023. =C3=A1pr.
11., Ke 11:23):

> Am 11.04.23 um 11:06 schrieb Timur Krist=C3=B3f:
>
>
>
> Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl> ezt =C3=ADrta (id=C5=91pont: =
2023. =C3=A1pr.
> 11., Ke 10:25):
>
>> On Tue, Apr 11, 2023 at 10:10=E2=80=AFAM Christian K=C3=B6nig
>> <christian.koenig@amd.com> wrote:
>> >
>> > Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:
>> > > We need to introduce a new version of the info struct because
>> > > libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
>> > > so the mesa<->libdrm_amdgpu interface can't handle increasing the
>> > > size.
>> > >
>> > > This info would be used by radv to figure out when we need to
>> > > split a submission into multiple submissions. radv currently has
>> > > a limit of 192 which seems to work for most gfx submissions, but
>> > > is way too high for e.g. compute or sdma.
>> >
>> > Why do you need so many IBs in the first place?
>> >
>> > You can use sub-IBs since R600 and newer hw even supports a JUMP comma=
nd
>> > to chain IBs together IIRC.
>>
>> Couple of reasons:
>>
>> 1) We can't reliably use sub-IBs (both because on GFX6-7 there are
>> indirect draw commands that cannot be used in sub-IBs and because the
>> Vulkan API exposes sub-IBs, so we can have the primary IBs be sub-IBs
>> already)
>>
>
> Furthermore, only the GFX queue supports the "IB2" packet that is used to
> implement sub-IBs.
>
> (The same packet hangs the compute queue and is documented as not working
> in the PAL source code. Other queues don't seem to have a packet for this
> purpose.)
>
> 2) We believed GFX6 may not support chaining. (Then again, it turns
>> out the GFX7+ packet may just work on GFX6?
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406)
>>
>
> I was actually quite surprised when I found this out. Mesa developers see=
m
> to have believed that this is not possible on GFX6. I'd love to get some
> more context on this, did it always work or was it added in a FW update?
>
> 3) Chaining doesn't work if the IB may be in flight multiple times in
>> a different sequence.
>>
>
> Additionally, chaining also doesn't work on any queue other than GFX and
> compute. As far as we know, SDMA and the various encoder/decoder queues
> don't have a packet for chaining.
>
> Christian, please let us know if we are wrong about this.
>
>
> I'm not an expert for this either. Marek and Pierre-eric know more about
> that stuff than me. On the other hand I could ping the firmware people as
> well if our UMD guys can't answer that.
>

Thanks, I'm looking forward to hearing more about it.


> It's just that last time we discussed this internally somebody from the
> PAL team commented that this isn't an issue any more because we don't nee=
d
> that many IBs any more.
>

It is true that the typical game would only submit a few IBs: either 2 (1
preamble + 1 IB that has all the command buffers chained) or 8 for gang
submit (4 preambles, 1 ACE IB, 1 GFX IB, 2 postambles), but we would like
to ensure that the less common use cases that can't use chaining work well
too.

We also have an increased interest in using the other HW queues in RADV
these days: video encode/decode queues for the Vulkan Video API, and of
course SDMA which we are considering for transfer queues in the future.


> libdrm defined that you shouldn't use more than 4 IBs in a CS, on the
> other hand we dropped checking that long ago and exposing the numbers of
> IBs the UMD can use is just good design.
>

Yes, I agree.

Can we remove that old (and confusing) define from libdrm? Or does anyone
still depend on that?


> Bas what do you think of adding an AMDGPU_INFO_MAX_IBS query instead of
> extending the drm_amdgpu_info_hw_ip structure?
>
> Background is that the drm_amdgpu_info_hw_ip structure is actually not
> meant to be used for sw parameters (which the maximum number of IBs is) a=
nd
> we wouldn't need to dance around issues with query size parameters becaus=
e
> that function takes the size as parameter.
>

Sounds good to me but I'll defer to Bas's judgement on this.




> Regards,
> Christian.
>
>
>
> Best regards,
> Timur
>
>
>
>
>> We try to chain when we can but (2) and (3) are cases where we
>> fallback to submitting multiple IBs.
>>
>> >
>> > For the kernel UAPI you only need separate IBs if you have separate
>> > properties on them, E.g. preamble or submitting to a different engine.
>> >
>> > Everything else just needs additional CPU overhead in the IOCTL.
>> >
>> > Regards,
>> > Christian.
>> >
>> > >
>> > > Because the kernel handling is just fine we can just use the v2
>> > > everywhere and have the return_size do the versioning for us,
>> > > with userspace interpreting 0 as unknown.
>> > >
>> > > Userspace implementation:
>> > > https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejectio=
n
>> > >
>> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
>> > >
>> > > v2: Use base member in the new struct.
>> > >
>> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
>> > > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> > > Cc: David Airlie <airlied@gmail.com>
>> > > ---
>> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31
>> ++++++++++++++-----------
>> > >   include/uapi/drm/amdgpu_drm.h           | 14 +++++++++++
>> > >   2 files changed, 31 insertions(+), 14 deletions(-)
>> > >
>> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > > index 89689b940493..5b575e1aef1a 100644
>> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > > @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct
>> drm_amdgpu_info_firmware *fw_info,
>> > >
>> > >   static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>> > >                            struct drm_amdgpu_info *info,
>> > > -                          struct drm_amdgpu_info_hw_ip *result)
>> > > +                          struct drm_amdgpu_info_hw_ip2 *result)
>> > >   {
>> > >       uint32_t ib_start_alignment =3D 0;
>> > >       uint32_t ib_size_alignment =3D 0;
>> > > @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_devic=
e
>> *adev,
>> > >               return -EINVAL;
>> > >       }
>> > >
>> > > +     result->max_ibs =3D UINT_MAX;
>> > >       for (i =3D 0; i < adev->num_rings; ++i) {
>> > >               /* Note that this uses that ring types alias the
>> equivalent
>> > >                * HW IP exposes to userspace.
>> > > @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_devic=
e
>> *adev,
>> > >               if (adev->rings[i]->funcs->type =3D=3D
>> info->query_hw_ip.type &&
>> > >                   adev->rings[i]->sched.ready) {
>> > >                       ++num_rings;
>> > > +                     result->max_ibs =3D min(result->max_ibs,
>> > > +                                           adev->rings[i]->max_ibs)=
;
>> > >               }
>> > >       }
>> > >
>> > > @@ -452,36 +455,36 @@ static int amdgpu_hw_ip_info(struct
>> amdgpu_device *adev,
>> > >       num_rings =3D min(amdgpu_ctx_num_entities[info->query_hw_ip.ty=
pe],
>> > >                       num_rings);
>> > >
>> > > -     result->hw_ip_version_major =3D adev->ip_blocks[i].version->ma=
jor;
>> > > -     result->hw_ip_version_minor =3D adev->ip_blocks[i].version->mi=
nor;
>> > > +     result->base.hw_ip_version_major =3D
>> adev->ip_blocks[i].version->major;
>> > > +     result->base.hw_ip_version_minor =3D
>> adev->ip_blocks[i].version->minor;
>> > >
>> > >       if (adev->asic_type >=3D CHIP_VEGA10) {
>> > >               switch (type) {
>> > >               case AMD_IP_BLOCK_TYPE_GFX:
>> > > -                     result->ip_discovery_version =3D
>> adev->ip_versions[GC_HWIP][0];
>> > > +                     result->base.ip_discovery_version =3D
>> adev->ip_versions[GC_HWIP][0];
>> > >                       break;
>> > >               case AMD_IP_BLOCK_TYPE_SDMA:
>> > > -                     result->ip_discovery_version =3D
>> adev->ip_versions[SDMA0_HWIP][0];
>> > > +                     result->base.ip_discovery_version =3D
>> adev->ip_versions[SDMA0_HWIP][0];
>> > >                       break;
>> > >               case AMD_IP_BLOCK_TYPE_UVD:
>> > >               case AMD_IP_BLOCK_TYPE_VCN:
>> > >               case AMD_IP_BLOCK_TYPE_JPEG:
>> > > -                     result->ip_discovery_version =3D
>> adev->ip_versions[UVD_HWIP][0];
>> > > +                     result->base.ip_discovery_version =3D
>> adev->ip_versions[UVD_HWIP][0];
>> > >                       break;
>> > >               case AMD_IP_BLOCK_TYPE_VCE:
>> > > -                     result->ip_discovery_version =3D
>> adev->ip_versions[VCE_HWIP][0];
>> > > +                     result->base.ip_discovery_version =3D
>> adev->ip_versions[VCE_HWIP][0];
>> > >                       break;
>> > >               default:
>> > > -                     result->ip_discovery_version =3D 0;
>> > > +                     result->base.ip_discovery_version =3D 0;
>> > >                       break;
>> > >               }
>> > >       } else {
>> > > -             result->ip_discovery_version =3D 0;
>> > > +             result->base.ip_discovery_version =3D 0;
>> > >       }
>> > > -     result->capabilities_flags =3D 0;
>> > > -     result->available_rings =3D (1 << num_rings) - 1;
>> > > -     result->ib_start_alignment =3D ib_start_alignment;
>> > > -     result->ib_size_alignment =3D ib_size_alignment;
>> > > +     result->base.capabilities_flags =3D 0;
>> > > +     result->base.available_rings =3D (1 << num_rings) - 1;
>> > > +     result->base.ib_start_alignment =3D ib_start_alignment;
>> > > +     result->base.ib_size_alignment =3D ib_size_alignment;
>> > >       return 0;
>> > >   }
>> > >
>> > > @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev,
>> void *data, struct drm_file *filp)
>> > >               }
>> > >               return copy_to_user(out, &ui32, min(size, 4u)) ?
>> -EFAULT : 0;
>> > >       case AMDGPU_INFO_HW_IP_INFO: {
>> > > -             struct drm_amdgpu_info_hw_ip ip =3D {};
>> > > +             struct drm_amdgpu_info_hw_ip2 ip =3D {};
>> > >               int ret;
>> > >
>> > >               ret =3D amdgpu_hw_ip_info(adev, info, &ip);
>> > > diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h
>> > > index b6eb90df5d05..6b9e35b6f747 100644
>> > > --- a/include/uapi/drm/amdgpu_drm.h
>> > > +++ b/include/uapi/drm/amdgpu_drm.h
>> > > @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
>> > >       __u32 enabled_rb_pipes_mask_hi;
>> > >   };
>> > >
>> > > +/* The size of this struct cannot be increased for compatibility
>> reasons, use
>> > > + * struct drm_amdgpu_info_hw_ip2 instead.
>> > > + */
>> > >   struct drm_amdgpu_info_hw_ip {
>> > >       /** Version of h/w IP */
>> > >       __u32  hw_ip_version_major;
>> > > @@ -1144,6 +1147,17 @@ struct drm_amdgpu_info_hw_ip {
>> > >       __u32  ip_discovery_version;
>> > >   };
>> > >
>> > > +struct drm_amdgpu_info_hw_ip2 {
>> > > +     /** Previous version of the struct */
>> > > +     struct drm_amdgpu_info_hw_ip  base;
>> > > +     /** The maximum number of IBs one can submit in a single
>> submission
>> > > +      * ioctl. (When using gang submit: this is per IP type)
>> > > +      */
>> > > +     __u32  max_ibs;
>> > > +     /** padding to 64bit for arch differences */
>> > > +     __u32  pad;
>> > > +};
>> > > +
>> > >   struct drm_amdgpu_info_num_handles {
>> > >       /** Max handles as supported by firmware for UVD */
>> > >       __u32  uvd_max_handles;
>> >
>>
>
>

--000000000000f2d3ce05f90d7d90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.k=
oenig@amd.com">christian.koenig@amd.com</a>&gt; ezt =C3=ADrta (id=C5=91pont=
: 2023. =C3=A1pr. 11., Ke 11:23):<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

 =20
  <div>
    Am 11.04.23 um 11:06 schrieb Timur Krist=C3=B3f:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">
        <div><br>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">Bas Nieuwenhuizen &lt;<a =
href=3D"mailto:bas@basnieuwenhuizen.nl" target=3D"_blank" rel=3D"noreferrer=
">bas@basnieuwenhuizen.nl</a>&gt;
              ezt =C3=ADrta (id=C5=91pont: 2023. =C3=A1pr. 11., Ke 10:25):<=
br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Tue,
              Apr 11, 2023 at 10:10=E2=80=AFAM Christian K=C3=B6nig<br>
              &lt;<a href=3D"mailto:christian.koenig@amd.com" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">christian.koenig@amd.com</a>&gt;
              wrote:<br>
              &gt;<br>
              &gt; Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:<br>
              &gt; &gt; We need to introduce a new version of the info
              struct because<br>
              &gt; &gt; libdrm_amdgpu forgot any versioning info in
              amdgpu_query_hw_ip_info<br>
              &gt; &gt; so the mesa&lt;-&gt;libdrm_amdgpu interface
              can&#39;t handle increasing the<br>
              &gt; &gt; size.<br>
              &gt; &gt;<br>
              &gt; &gt; This info would be used by radv to figure out
              when we need to<br>
              &gt; &gt; split a submission into multiple submissions.
              radv currently has<br>
              &gt; &gt; a limit of 192 which seems to work for most gfx
              submissions, but<br>
              &gt; &gt; is way too high for e.g. compute or sdma.<br>
              &gt;<br>
              &gt; Why do you need so many IBs in the first place?<br>
              &gt;<br>
              &gt; You can use sub-IBs since R600 and newer hw even
              supports a JUMP command<br>
              &gt; to chain IBs together IIRC.<br>
              <br>
              Couple of reasons:<br>
              <br>
              1) We can&#39;t reliably use sub-IBs (both because on GFX6-7
              there are<br>
              indirect draw commands that cannot be used in sub-IBs and
              because the<br>
              Vulkan API exposes sub-IBs, so we can have the primary IBs
              be sub-IBs<br>
              already)<br>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Furthermore, only the GFX queue supports the
          &quot;IB2&quot; packet that is used to implement sub-IBs.</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">(The same packet hangs the compute queue and is
          documented as not working in the PAL source code. Other queues
          don&#39;t seem to have a packet for this purpose.)</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">2) We
              believed GFX6 may not support chaining. (Then again, it
              turns<br>
              out the GFX7+ packet may just work on GFX6?<br>
              <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_r=
equests/22406" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">h=
ttps://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406</a>)<br>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">I was actually quite surprised when I found this
          out. Mesa developers seem to have believed that this is not
          possible on GFX6. I&#39;d love to get some more context on this,
          did it always work or was it added in a FW update?</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">3)
              Chaining doesn&#39;t work if the IB may be in flight multiple
              times in<br>
              a different sequence.<br>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Additionally, chaining also doesn&#39;t work on a=
ny
          queue other than GFX and compute. As far as we know, SDMA and
          the various encoder/decoder queues don&#39;t have a packet for
          chaining.</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Christian, please let us know if we are wrong
          about this.</div>
      </div>
    </blockquote>
    <br>
    I&#39;m not an expert for this either. Marek and Pierre-eric know more
    about that stuff than me. On the other hand I could ping the
    firmware people as well if our UMD guys can&#39;t answer that.<br></div=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Tha=
nks, I&#39;m looking forward to hearing more about it.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div>
    <br>
    It&#39;s just that last time we discussed this internally somebody from
    the PAL team commented that this isn&#39;t an issue any more because we
    don&#39;t need that many IBs any more.<br></div></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">It is true that the typical=
 game would only submit a few IBs: either 2 (1 preamble + 1 IB that has all=
 the command buffers chained) or 8 for gang submit (4 preambles, 1 ACE IB, =
1 GFX IB, 2 postambles), but we would like to ensure that the less common u=
se cases that can&#39;t use chaining work well too.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">We also have an increased interest in using the=
 other HW queues in RADV these days: video encode/decode queues for the Vul=
kan Video API, and of course SDMA which we are considering for transfer que=
ues in the future.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>
    <br>
    libdrm defined that you shouldn&#39;t use more than 4 IBs in a CS, on
    the other hand we dropped checking that long ago and exposing the
    numbers of IBs the UMD can use is just good design.<br></div></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, I agree.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Can we remove that old (=
and confusing) define from libdrm? Or does anyone still depend on that?</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>
    <br>
    Bas what do you think of adding an AMDGPU_INFO_MAX_IBS query instead
    of extending the drm_amdgpu_info_hw_ip structure?<br>
    <br>
    Background is that the drm_amdgpu_info_hw_ip structure is actually
    not meant to be used for sw parameters (which the maximum number of
    IBs is) and we wouldn&#39;t need to dance around issues with query size
    parameters because that function takes the size as parameter.<br></div>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Soun=
ds good to me but I&#39;ll defer to Bas&#39;s judgement on this.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"auto">
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Best regards,</div>
        <div dir=3D"auto">Timur</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <br>
              We try to chain when we can but (2) and (3) are cases
              where we<br>
              fallback to submitting multiple IBs.<br>
              <br>
              &gt;<br>
              &gt; For the kernel UAPI you only need separate IBs if you
              have separate<br>
              &gt; properties on them, E.g. preamble or submitting to a
              different engine.<br>
              &gt;<br>
              &gt; Everything else just needs additional CPU overhead in
              the IOCTL.<br>
              &gt;<br>
              &gt; Regards,<br>
              &gt; Christian.<br>
              &gt;<br>
              &gt; &gt;<br>
              &gt; &gt; Because the kernel handling is just fine we can
              just use the v2<br>
              &gt; &gt; everywhere and have the return_size do the
              versioning for us,<br>
              &gt; &gt; with userspace interpreting 0 as unknown.<br>
              &gt; &gt;<br>
              &gt; &gt; Userspace implementation:<br>
              &gt; &gt; <a href=3D"https://gitlab.freedesktop.org/bnieuwenh=
uizen/drm/-/tree/ib-rejection" rel=3D"noreferrer noreferrer noreferrer" tar=
get=3D"_blank">https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-=
rejection</a><br>
              &gt; &gt; <a href=3D"https://gitlab.freedesktop.org/bnieuwenh=
uizen/mesa/-/tree/ib-rejection" rel=3D"noreferrer noreferrer noreferrer" ta=
rget=3D"_blank">https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/i=
b-rejection</a><br>
              &gt; &gt;<br>
              &gt; &gt; v2: Use base member in the new struct.<br>
              &gt; &gt;<br>
              &gt; &gt; Link: <a href=3D"https://gitlab.freedesktop.org/drm=
/amd/-/issues/2498" rel=3D"noreferrer noreferrer noreferrer" target=3D"_bla=
nk">https://gitlab.freedesktop.org/drm/amd/-/issues/2498</a><br>
              &gt; &gt; Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mai=
lto:bas@basnieuwenhuizen.nl" rel=3D"noreferrer noreferrer" target=3D"_blank=
">bas@basnieuwenhuizen.nl</a>&gt;<br>
              &gt; &gt; Cc: David Airlie &lt;<a href=3D"mailto:airlied@gmai=
l.com" rel=3D"noreferrer noreferrer" target=3D"_blank">airlied@gmail.com</a=
>&gt;<br>
              &gt; &gt; ---<br>
              &gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c=
 | 31
              ++++++++++++++-----------<br>
              &gt; &gt;=C2=A0 =C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14
              +++++++++++<br>
              &gt; &gt;=C2=A0 =C2=A02 files changed, 31 insertions(+), 14
              deletions(-)<br>
              &gt; &gt;<br>
              &gt; &gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
              &gt; &gt; index 89689b940493..5b575e1aef1a 100644<br>
              &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
              &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
              &gt; &gt; @@ -360,7 +360,7 @@ static int
              amdgpu_firmware_info(struct drm_amdgpu_info_firmware
              *fw_info,<br>
              &gt; &gt;<br>
              &gt; &gt;=C2=A0 =C2=A0static int amdgpu_hw_ip_info(struct
              amdgpu_device *adev,<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct
              drm_amdgpu_info *info,<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct
              drm_amdgpu_info_hw_ip *result)<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct
              drm_amdgpu_info_hw_ip2 *result)<br>
              &gt; &gt;=C2=A0 =C2=A0{<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ib_start_alignme=
nt =3D 0;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ib_size_alignmen=
t =3D 0;<br>
              &gt; &gt; @@ -431,6 +431,7 @@ static int
              amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -EINVAL;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              &gt; &gt;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;max_ibs =3D UINT_MA=
X;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; adev=
-&gt;num_rings;
              ++i) {<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Note that this uses that ring
              types alias the equivalent<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 * HW IP exposes to userspace.<br>
              &gt; &gt; @@ -438,6 +439,8 @@ static int
              amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if
              (adev-&gt;rings[i]-&gt;funcs-&gt;type =3D=3D
              info-&gt;query_hw_ip.type &amp;&amp;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
              =C2=A0adev-&gt;rings[i]-&gt;sched.ready) {<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_rings;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;max_ibs =3D
              min(result-&gt;max_ibs,<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0adev-&gt;rings[i]-&gt;max_ibs);<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              &gt; &gt;<br>
              &gt; &gt; @@ -452,36 +455,36 @@ static int
              amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num_rings =3D
              min(amdgpu_ctx_num_entities[info-&gt;query_hw_ip.type],<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_rings);<br>
              &gt; &gt;<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;hw_ip_version_major=
 =3D
              adev-&gt;ip_blocks[i].version-&gt;major;<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;hw_ip_version_minor=
 =3D
              adev-&gt;ip_blocks[i].version-&gt;minor;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.hw_ip_version_=
major =3D
              adev-&gt;ip_blocks[i].version-&gt;major;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.hw_ip_version_=
minor =3D
              adev-&gt;ip_blocks[i].version-&gt;minor;<br>
              &gt; &gt;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type &g=
t;=3D CHIP_VEGA10)
              {<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0switch (type) {<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case AMD_IP_BLOCK_TYPE_GFX:<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;ip_discovery_version =3D
              adev-&gt;ip_versions[GC_HWIP][0];<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;base.ip_discovery_version =3D
              adev-&gt;ip_versions[GC_HWIP][0];<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case AMD_IP_BLOCK_TYPE_SDMA:<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;ip_discovery_version =3D
              adev-&gt;ip_versions[SDMA0_HWIP][0];<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;base.ip_discovery_version =3D
              adev-&gt;ip_versions[SDMA0_HWIP][0];<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case AMD_IP_BLOCK_TYPE_UVD:<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case AMD_IP_BLOCK_TYPE_VCN:<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case AMD_IP_BLOCK_TYPE_JPEG:<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;ip_discovery_version =3D
              adev-&gt;ip_versions[UVD_HWIP][0];<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;base.ip_discovery_version =3D
              adev-&gt;ip_versions[UVD_HWIP][0];<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case AMD_IP_BLOCK_TYPE_VCE:<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;ip_discovery_version =3D
              adev-&gt;ip_versions[VCE_HWIP][0];<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;base.ip_discovery_version =3D
              adev-&gt;ip_versions[VCE_HWIP][0];<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0default:<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;ip_discovery_version =3D 0;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;base.ip_discovery_version =3D 0;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
sult-&gt;ip_discovery_version =3D
              0;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              =C2=A0result-&gt;base.ip_discovery_version =3D 0;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;capabilities_flags =
=3D 0;<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;available_rings =3D=
 (1 &lt;&lt;
              num_rings) - 1;<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;ib_start_alignment =
=3D
              ib_start_alignment;<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0result-&gt;ib_size_alignment =
=3D
              ib_size_alignment;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.capabilities_f=
lags =3D 0;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.available_ring=
s =3D (1
              &lt;&lt; num_rings) - 1;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.ib_start_align=
ment =3D
              ib_start_alignment;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;base.ib_size_alignm=
ent =3D
              ib_size_alignment;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
              &gt; &gt;=C2=A0 =C2=A0}<br>
              &gt; &gt;<br>
              &gt; &gt; @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct
              drm_device *dev, void *data, struct drm_file *filp)<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return copy_to_user(out,
              &amp;ui32, min(size, 4u)) ? -EFAULT : 0;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_INFO_HW_IP_IN=
FO: {<br>
              &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct drm_amdgpu_info_hw_ip ip =3D
              {};<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct drm_amdgpu_info_hw_ip2 ip =3D
              {};<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int ret;<br>
              &gt; &gt;<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D amdgpu_hw_ip_info(adev,
              info, &amp;ip);<br>
              &gt; &gt; diff --git a/include/uapi/drm/amdgpu_drm.h
              b/include/uapi/drm/amdgpu_drm.h<br>
              &gt; &gt; index b6eb90df5d05..6b9e35b6f747 100644<br>
              &gt; &gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
              &gt; &gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
              &gt; &gt; @@ -1128,6 +1128,9 @@ struct
              drm_amdgpu_info_device {<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 enabled_rb_pipes_ma=
sk_hi;<br>
              &gt; &gt;=C2=A0 =C2=A0};<br>
              &gt; &gt;<br>
              &gt; &gt; +/* The size of this struct cannot be increased
              for compatibility reasons, use<br>
              &gt; &gt; + * struct drm_amdgpu_info_hw_ip2 instead.<br>
              &gt; &gt; + */<br>
              &gt; &gt;=C2=A0 =C2=A0struct drm_amdgpu_info_hw_ip {<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Version of h/w IP */<=
br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 hw_ip_version=
_major;<br>
              &gt; &gt; @@ -1144,6 +1147,17 @@ struct
              drm_amdgpu_info_hw_ip {<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ip_discovery_=
version;<br>
              &gt; &gt;=C2=A0 =C2=A0};<br>
              &gt; &gt;<br>
              &gt; &gt; +struct drm_amdgpu_info_hw_ip2 {<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0/** Previous version of the st=
ruct */<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_info_hw_ip=
=C2=A0 base;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0/** The maximum number of IBs =
one can
              submit in a single submission<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * ioctl. (When using gang sub=
mit: this is
              per IP type)<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 max_ibs;<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0/** padding to 64bit for arch =
differences
              */<br>
              &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 pad;<br>
              &gt; &gt; +};<br>
              &gt; &gt; +<br>
              &gt; &gt;=C2=A0 =C2=A0struct drm_amdgpu_info_num_handles {<br=
>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Max handles as suppor=
ted by firmware
              for UVD */<br>
              &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 uvd_max_handl=
es;<br>
              &gt;<br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div></div></div>

--000000000000f2d3ce05f90d7d90--
