Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06701C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F6B10EF9A;
	Thu, 30 Mar 2023 19:05:42 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F98710EF9A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:05:40 +0000 (UTC)
Received: by mail-ua1-x935.google.com with SMTP id r7so14590491uaj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680203139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9SnHJdSfGdbQECZWpWn41ZMujZP05AmpHVMzsiMKWY=;
 b=EQ/XeSXd4Li6e36v0Kpp7f4Bnq35+NrWkEK1Q7NDkacMi2gifsMHA34GujHiCYAtVA
 FUqMXiwaVdWvHUQKLDsCtZYgnROztqJ9zVGA8yJjFaHTipSg1IMeOuqZOjfr7REnSEyp
 mdEzNavgr3gXPQkFgvKcIm9kpddCVKtsJJIDLjglQp8xEeXQce9VFq/NA6gwJSqWboFL
 ibBHGUtZ/qci7BvOzwowdKSCx50Muns2HKx8cym4ScAlmeUhoBAzhSla6wLmxlTF2UHv
 CmZZL7PAZWgNEmXAyHx08Rr3zr8VPFUSASjRp2G/ofQ1qSDXj53Ypz1oupc7n2ixbAXV
 Wajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680203139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9SnHJdSfGdbQECZWpWn41ZMujZP05AmpHVMzsiMKWY=;
 b=SkA1F18rrig/qwi0JAP0ZRMpqr0nSYPPsAF7CsvwRy8xb/Zs+pWs8aZZQ/XdiMTcy+
 mJgfGT4A9dCPhbuDVSxGA9SnG2VOAGWOV5C4Zs2rIsI5gnkobM548XXoEvq5yT1h6it4
 3ZNTiosLbnztQWIFH622SNyMgUn0LGsK95dWNwvL7OCThqLLQFzkRUXKT+86DLi9+8if
 yXBL6r45VaBMA2sE1Sf2rEYBln+IbJyMC7eTnOyXPWgxv55Ee0FjWK4hdE1FjdC4+jrH
 XJMPMVgIupb13Dgq8nNUhRxH1/R+bqXBjydFEdm/B4ZFMDISWe+jzQiq9X+xP1jhZ97B
 4NWg==
X-Gm-Message-State: AAQBX9fOyHGASxFOy5tG65YLWFcl+h0asvHRDDg3+bStCweeMo1lQy6Z
 45GnzPyVQqoaN4x1gWJsymWtuuuuKOTHWetD/ow=
X-Google-Smtp-Source: AKy350YLZEmRLqVttzNSwBro9gtUEJz3vfq14IQST7XFKNWDDt2csTDV29gosAXf0A4t8ZZ7CzZaMkcdYiIHBshnpEY=
X-Received: by 2002:a05:6130:215:b0:688:d612:2024 with SMTP id
 s21-20020a056130021500b00688d6122024mr19312525uac.2.1680203139450; Thu, 30
 Mar 2023 12:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-11-alexander.deucher@amd.com>
 <33ad3215-55d5-723d-f1f5-65bb6d3d1d75@gmail.com>
In-Reply-To: <33ad3215-55d5-723d-f1f5-65bb6d3d1d75@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 15:05:27 -0400
Message-ID: <CADnq5_ME1iUCxHVpD5TGQuQ5YaR194_ftGg5LwELCFXYFHJ+qQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/amdgpu: add support for new GFX shadow size
 query
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 30, 2023 at 2:17=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
>
> Am 29.03.23 um 17:25 schrieb Alex Deucher:
> > Use the new callback to fetch the data.  Return an error if
> > not supported.  UMDs should use this query to check whether
> > shadow buffers are supported and if so what size they
> > should be.
> >
> > v2: return an error rather than a zerod structure.
> > v3: drop GDS, move into dev_info structure.  Data will be
> >      0 if not supported.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 0efb38539d70..90738024cc1a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -876,6 +876,20 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
> >               dev_info->gl2c_cache_size =3D adev->gfx.config.gc_gl2c_pe=
r_gpu;
> >               dev_info->mall_size =3D adev->gmc.mall_size;
> >
> > +
> > +             if (adev->gfx.funcs->get_gfx_shadow_info) {
> > +                     struct amdgpu_gfx_shadow_info shadow_info;
> > +                     int r;
>
> We can probably use the ret variable here instead of declaring a new one.

Will fix it up.

Thanks,

Alex

>
> Christian.
>
> > +
> > +                     r =3D amdgpu_gfx_get_gfx_shadow_info(adev, &shado=
w_info);
> > +                     if (!r) {
> > +                             dev_info->shadow_size =3D shadow_info.sha=
dow_size;
> > +                             dev_info->shadow_alignment =3D shadow_inf=
o.shadow_alignment;
> > +                             dev_info->csa_size =3D shadow_info.csa_si=
ze;
> > +                             dev_info->csa_alignment =3D shadow_info.c=
sa_alignment;
> > +                     }
> > +             }
> > +
> >               ret =3D copy_to_user(out, dev_info,
> >                                  min((size_t)size, sizeof(*dev_info))) =
? -EFAULT : 0;
> >               kfree(dev_info);
>
