Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD12C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 08:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F2410E031;
	Mon, 10 Apr 2023 08:05:28 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BC310E1C3
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 15:50:54 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id la3so2558011plb.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681055454; x=1683647454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kprKULrwU639Uf3sPEtSBCjbIfUFH5rRhBZRMRWCsxc=;
 b=Zdua5ny+GP6JyASKV3azQ9jBX0wvSbiOqCeehK9t/NnKFmLu5/wvaJ0mlR2SQYEuSR
 8Nc8MCfA7BbPrAMP0ESIRGvMKZNgtEsUSBVvgcVEiiXSwdeS37sWHWqZmIC8p/8mN+pj
 S6HGvG4YN0cdrFEXx2m9rcb2H5GLfl4khCrlAvP2aLbq3/YqwRmVzL5Ncam0wnwMSswd
 L6AvKpbvO3L7wSE2+f8O9BTeISt6kzbMjY15wgUBRyYjx7RHK69FsVOC8AIvBpDzwcDV
 Cbcz+mclVJSyNJ0PyYHV3LD2L61/T6ZhHnmUCMuZ4csGBSnAV6JAfShGqblf9AGYydwQ
 RKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681055454; x=1683647454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kprKULrwU639Uf3sPEtSBCjbIfUFH5rRhBZRMRWCsxc=;
 b=kDNBNpp+hsA+3B6RYe3bHcyZH7mBuWLcQ7wO87sUiOfaM4mDuaIZG+/5x7/tU6X8j9
 LaL82Fd9woj7axmU8y02N7Wofggqoa3ihLpnQDIl/N3xRl4OoZZs6Kc2zQKVNI9/xCf/
 IfAlkDq8oMEVljw3F1jgYPoUwWIGNA9bfUnejjVIw+6veVpzrRiFqNPmUYAbeOgHDUul
 XXfH5Xp4fNY0XdisYnFwRIIKg/z3+P1XAaYUx9VLffeO/ldY9iqxNP7e40wNo/nUwH1x
 YqbPXB+oLyxnpk6kmbvNe0WNteJSEIsklF6XHsMvd+9Y3xfK5lzE5OvWSK9xOPw5eiAN
 OMrA==
X-Gm-Message-State: AAQBX9cvqpRDkqYn3GlFriHJlfUzx4LTzmNGShSdicZAaDxbgFMxSkcz
 cO6jYyacooFmD5oNWmfy5hXSSDHXDyYYHZ2cb35AEI+n
X-Google-Smtp-Source: AKy350YWwtLB5zqaSSSgEctTnhqE8exLXym57sbbgB7h7KNmsJiuvzXuN9H/dVtzwWwrZ2llNXVX0mhts907389GBYY=
X-Received: by 2002:a17:903:445:b0:1a0:5402:b17b with SMTP id
 iw5-20020a170903044500b001a05402b17bmr1355499plb.0.1681055453687; Sun, 09 Apr
 2023 08:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
 <20230409144445.374816-3-bas@basnieuwenhuizen.nl>
 <99dad825-894a-bc00-7a26-6b1b917477d4@gmail.com>
 <CAP+8YyF8-5aVoLBmAUy0rS6rturFk0GMYy6Y6wLA2p9U1P7iAw@mail.gmail.com>
 <7d5bb5e5-91a7-71ba-8fa4-6d1cbcb00b26@gmail.com>
In-Reply-To: <7d5bb5e5-91a7-71ba-8fa4-6d1cbcb00b26@gmail.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Sun, 9 Apr 2023 17:50:41 +0200
Message-ID: <CAFF-SiWRNMZazGazpbanW1kzjKFWhzUpbcErn6fKyGB8Q63rsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002a34a705f8e9393e"
X-Mailman-Approved-At: Mon, 10 Apr 2023 08:05:26 +0000
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000002a34a705f8e9393e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com> ezt =C3=ADrta (id=
=C5=91pont: 2023.
=C3=A1pr. 9., Vas 17:38):

> Am 09.04.23 um 17:32 schrieb Bas Nieuwenhuizen:
> > On Sun, Apr 9, 2023 at 5:30=E2=80=AFPM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 09.04.23 um 16:44 schrieb Bas Nieuwenhuizen:
> >>> We need to introduce a new version of the info struct because
> >>> libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
> >>> so the mesa<->libdrm_amdgpu interface can't handle increasing the
> >>> size.
> >> Those are not forgotten, but simply unnecessary.
> >>
> >> The size of the input output structures are given to the IOCTL in byte=
s
> >> and additional bytes should be filled with zeros.
> > At the ioctl side, yes, but it is libdrm_amdgpu filling in the size,
> > while passing in the struct directly from the client (mesa or
> > whatever). So if we have new libdrm_amdgpu and old mesa, then mesa
> > allocates  N bytes on the stack and libdrm_amdgpu happily tells the
> > kernel in the ioctl "this struct is N+8 bytes long" which would cause
> > corruption?
>
> WTF? This has a wrapper in libdrm? Well then that's indeed horrible broke=
n.
>
> In this case please define the new structure as extension of the old
> one. E.g. something like:
>
> struct drm_amdgpu_info_hw_ip2 {
>      struct drm_amdgpu_info_hw_ip    base;
>      ....
> };
>
> This way we can make it clear that this is an extension.
>


Can we solve this in userspace by letting mesa pass the struct size to
libdrm as well? Or would that create other compatibility issues?




> Thanks,
> Christian.
>
> >
> > - Bas
> >
> >> So you should be able to extend the structures at the end without
> >> breaking anything.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> This info would be used by radv to figure out when we need to
> >>> split a submission into multiple submissions. radv currently has
> >>> a limit of 192 which seems to work for most gfx submissions, but
> >>> is way too high for e.g. compute or sdma.
> >>>
> >>> Because the kernel handling is just fine we can just use the v2
> >>> everywhere and have the return_size do the versioning for us,
> >>> with userspace interpreting 0 as unknown.
> >>>
> >>> Userspace implementation:
> >>> https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
> >>> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejectio=
n
> >>>
> >>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> >>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >>> Cc: David Airlie <airlied@gmail.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++++--
> >>>    include/uapi/drm/amdgpu_drm.h           | 29
> +++++++++++++++++++++++++
> >>>    2 files changed, 34 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>> index 89689b940493..c7e815c2733e 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>> @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct
> drm_amdgpu_info_firmware *fw_info,
> >>>
> >>>    static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> >>>                             struct drm_amdgpu_info *info,
> >>> -                          struct drm_amdgpu_info_hw_ip *result)
> >>> +                          struct drm_amdgpu_info_hw_ip2 *result)
> >>>    {
> >>>        uint32_t ib_start_alignment =3D 0;
> >>>        uint32_t ib_size_alignment =3D 0;
> >>> @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
> >>>                return -EINVAL;
> >>>        }
> >>>
> >>> +     result->max_ibs =3D UINT_MAX;
> >>>        for (i =3D 0; i < adev->num_rings; ++i) {
> >>>                /* Note that this uses that ring types alias the
> equivalent
> >>>                 * HW IP exposes to userspace.
> >>> @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
> >>>                if (adev->rings[i]->funcs->type =3D=3D
> info->query_hw_ip.type &&
> >>>                    adev->rings[i]->sched.ready) {
> >>>                        ++num_rings;
> >>> +                     result->max_ibs =3D min(result->max_ibs,
> >>> +                                           adev->rings[i]->max_ibs);
> >>>                }
> >>>        }
> >>>
> >>> @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d
> *data, struct drm_file *filp)
> >>>                }
> >>>                return copy_to_user(out, &ui32, min(size, 4u)) ?
> -EFAULT : 0;
> >>>        case AMDGPU_INFO_HW_IP_INFO: {
> >>> -             struct drm_amdgpu_info_hw_ip ip =3D {};
> >>> +             struct drm_amdgpu_info_hw_ip2 ip =3D {};
> >>>                int ret;
> >>>
> >>>                ret =3D amdgpu_hw_ip_info(adev, info, &ip);
> >>> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> >>> index b6eb90df5d05..45e5ae546d19 100644
> >>> --- a/include/uapi/drm/amdgpu_drm.h
> >>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>> @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
> >>>        __u32 enabled_rb_pipes_mask_hi;
> >>>    };
> >>>
> >>> +/* The size of this struct cannot be increased for compatibility
> reasons, use
> >>> + * struct drm_amdgpu_info_hw_ip2 instead.
> >>> + */
> >>>    struct drm_amdgpu_info_hw_ip {
> >>>        /** Version of h/w IP */
> >>>        __u32  hw_ip_version_major;
> >>> @@ -1144,6 +1147,32 @@ struct drm_amdgpu_info_hw_ip {
> >>>        __u32  ip_discovery_version;
> >>>    };
> >>>
> >>> +/* The prefix fields of this are intentionally the same as those of
> >>> + * struct drm_amdgpu_info_hw_ip. The struct has a v2 to resolve a
> lack of
> >>> + * versioning on the libdrm_amdgpu side.
> >>> + */
> >>> +struct drm_amdgpu_info_hw_ip2 {
> >>> +     /** Version of h/w IP */
> >>> +     __u32  hw_ip_version_major;
> >>> +     __u32  hw_ip_version_minor;
> >>> +     /** Capabilities */
> >>> +     __u64  capabilities_flags;
> >>> +     /** command buffer address start alignment*/
> >>> +     __u32  ib_start_alignment;
> >>> +     /** command buffer size alignment*/
> >>> +     __u32  ib_size_alignment;
> >>> +     /** Bitmask of available rings. Bit 0 means ring 0, etc. */
> >>> +     __u32  available_rings;
> >>> +     /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
> >>> +     __u32  ip_discovery_version;
> >>> +     /** The maximum number of IBs one can submit in a single
> submission
> >>> +      * ioctl. (When using gang submit: this is per IP type)
> >>> +      */
> >>> +     __u32  max_ibs;
> >>> +     /** padding to 64bit for arch differences */
> >>> +     __u32  pad;
> >>> +};
> >>> +
> >>>    struct drm_amdgpu_info_num_handles {
> >>>        /** Max handles as supported by firmware for UVD */
> >>>        __u32  uvd_max_handles;
>
>

--0000000000002a34a705f8e9393e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; ezt =C3=ADr=
ta (id=C5=91pont: 2023. =C3=A1pr. 9., Vas 17:38):<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Am 09.04.23 um 17:32 schrieb Bas Nieuwenhuizen:<br>
&gt; On Sun, Apr 9, 2023 at 5:30=E2=80=AFPM Christian K=C3=B6nig<br>
&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_bla=
nk" rel=3D"noreferrer">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Am 09.04.23 um 16:44 schrieb Bas Nieuwenhuizen:<br>
&gt;&gt;&gt; We need to introduce a new version of the info struct because<=
br>
&gt;&gt;&gt; libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip=
_info<br>
&gt;&gt;&gt; so the mesa&lt;-&gt;libdrm_amdgpu interface can&#39;t handle i=
ncreasing the<br>
&gt;&gt;&gt; size.<br>
&gt;&gt; Those are not forgotten, but simply unnecessary.<br>
&gt;&gt;<br>
&gt;&gt; The size of the input output structures are given to the IOCTL in =
bytes<br>
&gt;&gt; and additional bytes should be filled with zeros.<br>
&gt; At the ioctl side, yes, but it is libdrm_amdgpu filling in the size,<b=
r>
&gt; while passing in the struct directly from the client (mesa or<br>
&gt; whatever). So if we have new libdrm_amdgpu and old mesa, then mesa<br>
&gt; allocates=C2=A0 N bytes on the stack and libdrm_amdgpu happily tells t=
he<br>
&gt; kernel in the ioctl &quot;this struct is N+8 bytes long&quot; which wo=
uld cause<br>
&gt; corruption?<br>
<br>
WTF? This has a wrapper in libdrm? Well then that&#39;s indeed horrible bro=
ken.<br>
<br>
In this case please define the new structure as extension of the old <br>
one. E.g. something like:<br>
<br>
struct drm_amdgpu_info_hw_ip2 {<br>
=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_amdgpu_info_hw_ip=C2=A0=C2=A0=C2=A0 bas=
e;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 ....<br>
};<br>
<br>
This way we can make it clear that this is an extension.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Can we solve this in userspace by letting mesa pass the struct si=
ze to libdrm as well? Or would that create other compatibility issues?</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
Thanks,<br>
Christian.<br>
<br>
&gt;<br>
&gt; - Bas<br>
&gt;<br>
&gt;&gt; So you should be able to extend the structures at the end without<=
br>
&gt;&gt; breaking anything.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt; This info would be used by radv to figure out when we need to<=
br>
&gt;&gt;&gt; split a submission into multiple submissions. radv currently h=
as<br>
&gt;&gt;&gt; a limit of 192 which seems to work for most gfx submissions, b=
ut<br>
&gt;&gt;&gt; is way too high for e.g. compute or sdma.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Because the kernel handling is just fine we can just use the v=
2<br>
&gt;&gt;&gt; everywhere and have the return_size do the versioning for us,<=
br>
&gt;&gt;&gt; with userspace interpreting 0 as unknown.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Userspace implementation:<br>
&gt;&gt;&gt; <a href=3D"https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-=
/tree/ib-rejection" rel=3D"noreferrer noreferrer" target=3D"_blank">https:/=
/gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection</a><br>
&gt;&gt;&gt; <a href=3D"https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/=
-/tree/ib-rejection" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issu=
es/2498" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.fre=
edesktop.org/drm/amd/-/issues/2498</a><br>
&gt;&gt;&gt; Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@bas=
nieuwenhuizen.nl" target=3D"_blank" rel=3D"noreferrer">bas@basnieuwenhuizen=
.nl</a>&gt;<br>
&gt;&gt;&gt; Cc: David Airlie &lt;<a href=3D"mailto:airlied@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">airlied@gmail.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |=C2=A0 7=
 ++++--<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 29 +++++++++++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 2 files changed, 34 insertions(+), 2 deletions(-)=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt; index 89689b940493..c7e815c2733e 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt; @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct drm=
_amdgpu_info_firmware *fw_info,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 static int amdgpu_hw_ip_info(struct amdgpu_device=
 *adev,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_info *info,<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_info_hw_ip *result)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_info_hw_ip2 *result)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ib_start_alignment =3D 0;<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ib_size_alignment =3D 0;<b=
r>
&gt;&gt;&gt; @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu=
_device *adev,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
-EINVAL;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0result-&gt;max_ibs =3D UINT_MAX;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;num_r=
ings; ++i) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Note=
 that this uses that ring types alias the equivalent<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=
 HW IP exposes to userspace.<br>
&gt;&gt;&gt; @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu=
_device *adev,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ade=
v-&gt;rings[i]-&gt;funcs-&gt;type =3D=3D info-&gt;query_hw_ip.type &amp;&am=
p;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 adev-&gt;rings[i]-&gt;sched.ready) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ++num_rings;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0result-&gt;max_ibs =3D min(result-&gt;max_ibs,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0adev-&gt;rings[i]-&gt;max_ibs);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *d=
ev, void *data, struct drm_file *filp)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
copy_to_user(out, &amp;ui32, min(size, 4u)) ? -EFAULT : 0;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_INFO_HW_IP_INFO: {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_am=
dgpu_info_hw_ip ip =3D {};<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_am=
dgpu_info_hw_ip2 ip =3D {};<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret=
;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D=
 amdgpu_hw_ip_info(adev, info, &amp;ip);<br>
&gt;&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/=
amdgpu_drm.h<br>
&gt;&gt;&gt; index b6eb90df5d05..45e5ae546d19 100644<br>
&gt;&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;&gt; @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 enabled_rb_pipes_mask_hi;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 };<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +/* The size of this struct cannot be increased for compatibil=
ity reasons, use<br>
&gt;&gt;&gt; + * struct drm_amdgpu_info_hw_ip2 instead.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 struct drm_amdgpu_info_hw_ip {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** Version of h/w IP */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 hw_ip_version_major;<br=
>
&gt;&gt;&gt; @@ -1144,6 +1147,32 @@ struct drm_amdgpu_info_hw_ip {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 ip_discovery_version;<b=
r>
&gt;&gt;&gt;=C2=A0 =C2=A0 };<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +/* The prefix fields of this are intentionally the same as th=
ose of<br>
&gt;&gt;&gt; + * struct drm_amdgpu_info_hw_ip. The struct has a v2 to resol=
ve a lack of<br>
&gt;&gt;&gt; + * versioning on the libdrm_amdgpu side.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +struct drm_amdgpu_info_hw_ip2 {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** Version of h/w IP */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 hw_ip_version_major;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 hw_ip_version_minor;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** Capabilities */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u64=C2=A0 capabilities_flags;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** command buffer address start alignmen=
t*/<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ib_start_alignment;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** command buffer size alignment*/<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ib_size_alignment;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** Bitmask of available rings. Bit 0 mea=
ns ring 0, etc. */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 available_rings;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** version info: bits 23:16 major, 15:8 =
minor, 7:0 revision */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ip_discovery_version;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** The maximum number of IBs one can sub=
mit in a single submission<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 * ioctl. (When using gang submit: this i=
s per IP type)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 max_ibs;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/** padding to 64bit for arch differences=
 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 pad;<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 struct drm_amdgpu_info_num_handles {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** Max handles as supported by fir=
mware for UVD */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 uvd_max_handles;<br>
<br>
</blockquote></div></div></div>

--0000000000002a34a705f8e9393e--
