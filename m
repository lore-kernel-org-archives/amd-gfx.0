Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECA4C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C737891B8;
	Thu, 27 Aug 2026 15:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WwHttygE";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5685891B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:36:49 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84e4efb18c9so13123b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 08:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787845009; cv=none;
 d=google.com; s=arc-20260327;
 b=gMfMbpzhlJZReLbrvisBE1RYnYewfeO6u04+7ehaEQo0aIoEqmCmhn0LyGY7w4GplX
 VQ2arNQhEpFuznF1M2ThWoKvQl/BnPfCsjETvnrKmd5zp2hBCjfuJK6WNJxG09+4FCH9
 HxpFMrhKmaqgltbBINVx71xWsA3ErEU7HgbmIkG+3YlAb0Ae06Btohdd22xzy6gVZIoF
 GolDmBOfgYQpqrUv5oqLPVul9SsKefVb4po8PpaaSQQUjcv0bVhopztFbuHy/bS35IKq
 2SDjvS1kHWBuf5McrQQTdXT2iVBl5HT8eFjq6hJUWlWPSQ+hCu8X6c4h1UVBawcOREBG
 WlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yUTUZ4snv7ay4iUiWOk4eA1NX3NVlv4dihabIUfvBFQ=;
 fh=gtPBvqqZQc9vu1W3SkLRDbKpZl/NHv3U7GLMyd+qIqo=;
 b=ZBTYcXtQMCTwQR1kk9ttSC05DNhhr8pFoxY+6oXVzsj8Yew9zAUZ+yhtXohsZ9A/TS
 3WuxjWFL5hi9frY+ZM0UecxGaWtx1OZliVKKQyFxSFROkoxMJx/v5nkc7R8btRexUP/g
 YdksVZ527/0Mgitb7QRkJ30f9pvgjAJmT/4oYmHOruVAsQi7DeetEn2pUASUd/QY9E1W
 zKSeNrv8uH+FoH6qVRIu42QhTex1XXwq1cUCG7giTWRzLBJhtml2mQiJkm4fYkxgCryi
 ih6hQyTMOqL/EbOnRuHsHcACBdmIPumVPxx1Ig4jm2SUDknyzpUn1a00d56YYj3tjuWS
 6aFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787845009; x=1788449809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yUTUZ4snv7ay4iUiWOk4eA1NX3NVlv4dihabIUfvBFQ=;
 b=WwHttygErZZ27B7YcCimAnMYCD/JnQNLxSlvH5VjOvSrAC0dGQN56Bp1A3QqukTMhO
 SomD5kZXh0DLraxfAPvkiFoSPOCmZLY2si0GJuT/IW0A5zUHeHXxHXwDZDOUiD3WeLmP
 P+u1be85aAArqLvxHNnCOuLnF+v05W44Bp5SarRMxc/4DdZnWlTmWNEFugde5aTk/ZFV
 ePDcr6WhstmHKFVGCZhIoBW2P9ZamfMCzDUOf4iqo08XTBfzDjo6aedlGCw7jwoqHDG6
 3LS9U0bOUnqxDiwQX9yT26y6CqzxSrswjLMOmXp33H2HyoSBZ3D4iiPrCiVYb1k/Eht6
 x1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845009; x=1788449809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yUTUZ4snv7ay4iUiWOk4eA1NX3NVlv4dihabIUfvBFQ=;
 b=ekoDC6tCBM7msu7h/4Y6l/j36G9MJvsHkoLTaAXqpvq2BSTUT6LxBffM/ngWlsJieu
 WifmDM0JCutwU9NDAm3p1RK2HeQ/K8WOlkX7M96eEvB/GQC0pEg2XO6o2gAa4ZCOr6wr
 00A/LuI+mED9oF/b5WPZCVALgR0G20+SB7X7TU/a+reKrkD5aDScosHBKb/HaZyvKalb
 +Eoewht9yWcfknw96tfsVKV7JbmDjCJOSChVSIJPZVg+ljFcfjeZAJfZutCBNlVY6aH3
 F747TXxFaH5/7mB+JKS5Mzze35/lOATrx6OMI7VeXl9uzD6tMnmcfxuz/8akhbOXYSMj
 jpNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMl8n1RCln3mhpH0R9MglY2sI3ij1mm9Xl1xQYcINZd7ybFMJvTaVHqNnVOWe+dtM/cyCVEFRK@lists.freedesktop.org
X-Gm-Message-State: AFuF++mK0yS+JBGGRt1Gy2yBdgG8CiQyNVyxZdquH12U/MqBjJHCnby1
 lsYOGX1bMy55Z4mo6bzZErqYS3bXDVBrTcDrb5RKqKlbiuTvPDV+m/lUCBhumJqcjgiyje7W3Lc
 DX+FsoM7K3LDuky4ol+hjx8G6OuD5/R3i1g==
X-Gm-Gg: AR+sD12Scd4UC86yljlmIwcyKwKlKnSJcvKhqQxX18/JUkLNiCSEhYDDwVjNjcGJONh
 R9JUimKFFG1gZ3ePRKQLF6qqWc4OzMWZnMrM1IOFKfM6zmfQDx0yNTBlCyOKK4VPEqhm2pcPXFe
 zoQYn4CR2bwS2Sx4Rz6TXkTtc78uCDZ+FDSbxIK1OXBmlUynR2ZrB3B4avzoz8A+r5PUzgKsbrd
 95rXltRsgNBrSfzJOCkhoo/GcqPNXV7YsiOa/Bg5r/Ed1MJmYD9BYbN96bWEP5lrq4mkLWrFhw5
 Wvg3mFPGdQL2FvQzVaoglFqmK0EsBoAelNTmTulcumduA1V38HQjy48OpdP6L7yVBtQPn3A/rPP
 QcHs6xqGfQI/H44wCKYC1kcCtSrzrv8s=
X-Received: by 2002:a17:90b:4fcc:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-396d0f70ba2mr31353a91.2.1787845008869; Thu, 27 Aug 2026
 08:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com>
 <CADnq5_MNFZfbvkgQ6JYjBZOb5+E+kezXDphFHshaaw7h7yVk0w@mail.gmail.com>
 <CH0PR12MB52689AE98C9044860F3FB914FFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
 <CADnq5_NL1vec9Xp=6EjUupmJb8DkkUu2dz44URLL5gf+f9bKxg@mail.gmail.com>
 <CH0PR12MB5268E3922230EB424FAEB36DFFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
 <CADnq5_On3OffA8-eqe7wmuhxmqafw_hd-uWN_DTttefyt8ATVg@mail.gmail.com>
 <CH0PR12MB52681EA03CE63F6935D08047FFA32@CH0PR12MB5268.namprd12.prod.outlook.com>
 <66dffb9e-559c-406e-8d09-b3165020efed@amd.com>
In-Reply-To: <66dffb9e-559c-406e-8d09-b3165020efed@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Aug 2026 11:36:35 -0400
X-Gm-Features: AcwNN1VlEbAT4mAn4wFMOAdOXM1LwaaE_Q5LKuKxQApxLvHnUtn2QOP3kJ0G53I
Message-ID: <CADnq5_Oqhhsdsatex144-BmKFeyN_U5y1m5wK1pQuumoAE2o2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device
 padding for 32bit compile
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

We discussed this today and currently today 32 bit kernel + 32 bit
userspace and 64 bit kernel and 64 bit userspace work.  Mixed 64 bit
kernel and 32 bit userspace is currently broken.  Since 32 bit kernel
and userspace is probably pretty rare these days and the data affected
by this is not critical, I think we can go ahead with this.  Please
write this up in the commit message.

Alex

On Tue, Aug 25, 2026 at 4:17=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi guys,
>
> if it looks like this means that the UAPI is broken since:
>
> commit cf21e76a6005016474623a375ae2e90364a02168
> Author: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> Date:   Tue Sep 24 17:53:25 2019 -0400
>
>     drm/amdgpu: return tcc_disabled_mask to userspace
>
>     UMDs need this for correct programming of harvested chips.
>
>     Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>     Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> It's just that nobody really noticed.
>
> *sigh* this is exactly one of the reasons why I don't wanted to extend th=
e drm_amdgpu_info_device structure. If I'm not completely mistaken we have =
messed things up massively now.
>
> This currently works with 32bit kernels / 32bit userspace and 64bit kerne=
l / 64bit userspace, but breaks as soon as you have 64bit kernel / 32bit us=
erspace combination.
>
> We have now the choice to apply this patch and essentially break 32bit ke=
rnel and 32bit userspace combination or use some other hacky workaround.
>
> Alex and Yogesh let's discuss that on my Thursday meeting.
>
> Regards,
> Christian.
>
> On 8/21/26 05:51, Mohan Marimuthu, Yogesh wrote:
> > AMD General
> >
> > Hi Alex,
> >
> > With 32bit Kernel + patch and older userspace will be broken. It will n=
eed userspace to be recompiled.
> > The current situation is "64bit Kernel + 32bit userspace" already broke=
n. It can be said that the current Kernel "struct drm_amdgpu_info_device" i=
s broken.
> >
> > Though "64bit Kernel + 32bit userspace" is already broken but it has no=
t been noticed until now, it was noticed with userq_ip_mask variable retuni=
ng zero.
> >
> > I think we have only two options,
> >
> >  1.
> >     Probably "32bit Kernel + 32bit UMD" combination is not used and hen=
ce picking this patch might not trigger any compatibility issue.
> >  2.
> >     Create AMDGPU_INFO_DEV_INFO_2 version 2 for DRM_AMDGPU_INFO ioctl t=
o pass the fixed data structure, but this would keep the older structure th=
at is already broken still broken.
> >
> >
> > Thank you,
> > Yogesh
> >
> > -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------
> > *From:* Alex Deucher <alexdeucher@gmail.com>
> > *Sent:* Thursday, August 20, 2026 11:00 PM
> > *To:* Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> > *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; De=
ucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > *Subject:* Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_dev=
ice padding for 32bit compile
> >
> > On Thu, Aug 20, 2026 at 11:28=E2=80=AFAM Mohan Marimuthu, Yogesh
> > <Yogesh.Mohanmarimuthu@amd.com> wrote:
> >>
> >> AMD General
> >>
> >> Hi Alex,
> >>
> >> I am not changing the layout.
> >>
> >> For 64 bit gcc, default alignment for __u64 is 8bytes.
> >> For 32 bit gcc, default alignment for __u64 is 4bytes.
> >>
> >> For 32 bit gcc, I have manually padded 4bytes so that it is 8bytes ali=
gned for __u64. This will make 64bit kernel compatible with 32bit mesa comp=
iled using gcc.
> >>
> >
> > Won't this break 32 bit kernels?
> >
> > Alex
> >
> >> Thank you,
> >> Yogesh
> >>
> >> ________________________________
> >> From: Alex Deucher <alexdeucher@gmail.com>
> >> Sent: Thursday, August 20, 2026 8:51 PM
> >> To: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deu=
cher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.K=
oenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> >> Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_devi=
ce padding for 32bit compile
> >>
> >> On Thu, Aug 20, 2026 at 11:18=E2=80=AFAM Mohan Marimuthu, Yogesh
> >> <Yogesh.Mohanmarimuthu@amd.com> wrote:
> >> >
> >> > AMD General
> >> >
> >> > Hi Alex,
> >> >
> >> > In 32bit mesa, I did not get the correct userq_ip_mask value.
> >> > I checked for variable alignment and tcc_disabled_mask was not on 8 =
byte alignment. This patch fixes it.
> >> >
> >> > Can you please tell how it would break UAPI. What did I miss.
> >>
> >> You are changing the layout of the structure that existing apps expect=
.
> >>
> >> Alex
> >>
> >> >
> >> > Thank you,
> >> > Yogesh
> >> >
> >> > ________________________________
> >> > From: Alex Deucher <alexdeucher@gmail.com>
> >> > Sent: Thursday, August 20, 2026 7:23 PM
> >> > To: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> >> > Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; D=
eucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian=
.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> >> > Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_de=
vice padding for 32bit compile
> >> >
> >> > On Thu, Aug 20, 2026 at 12:55=E2=80=AFAM Yogesh Mohan Marimuthu
> >> > <yogesh.mohanmarimuthu@amd.com> wrote:
> >> > >
> >> > > need to pad before __u64 tcc_disabled_mask variable.
> >> > >
> >> > > Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.c=
om>
> >> >
> >> > This will break UAPI.
> >> >
> >> > Alex
> >> >
> >> > > ---
> >> > >  include/uapi/drm/amdgpu_drm.h | 2 +-
> >> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdg=
pu_drm.h
> >> > > index 0a113529b..5beef3eaa 100644
> >> > > --- a/include/uapi/drm/amdgpu_drm.h
> >> > > +++ b/include/uapi/drm/amdgpu_drm.h
> >> > > @@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
> >> > >         __u64 high_va_max;
> >> > >         /* gfx10 pa_sc_tile_steering_override */
> >> > >         __u32 pa_sc_tile_steering_override;
> >> > > +       __u32 pad;
> >> > >         /* disabled TCCs */
> >> > >         __u64 tcc_disabled_mask;
> >> > >         __u64 min_engine_clock;
> >> > > @@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
> >> > >         __u32 csa_alignment;
> >> > >         /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
> >> > >         __u32 userq_ip_mask;
> >> > > -       __u32 pad;
> >> > >  };
> >> > >
> >> > >  struct drm_amdgpu_info_hw_ip {
> >> > > --
> >> > > 2.43.0
> >> > >
>
