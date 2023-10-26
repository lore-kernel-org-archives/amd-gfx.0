Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D18C25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 20:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B94B010E88D;
	Thu, 26 Oct 2023 20:08:56 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3ED810E88D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 20:08:54 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1ead2e6fab7so875030fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698350934; x=1698955734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/RAajdI04xb4FiwLUgc3cdSF3eXLG31eCoN1duUxqE=;
 b=ldVRvEXMdI6Ay2axu5vXwlvzeNHdesSX/Ij+kDtFYIjXWfemiOK7NyzkcZDeE1saHc
 FSkJDsfZWmx1bSGYqYfhmggMxykdHaIBrjpcr8yDN6PMOXW400Hwb75MgMJ2gn3AOSbg
 MBIl/uUYNTr2TI0lhqm07DRYN8gcBZJxV2tLqcXmCWC9xUqOi6jwAXC/f7otkbeMYfl3
 0d7pXjkzH2jKMpiKwF9PD/loECK43pyyqzAwIFEDSqKMgLqr/eMXEbLXT8i62go1Zqs4
 Lwoy5CW+pbyy1LboX07hwISaTHgVVjKuiRphYk7CbkcF9IhRL4YOK/Ud7biZxog+WgZb
 3WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698350934; x=1698955734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/RAajdI04xb4FiwLUgc3cdSF3eXLG31eCoN1duUxqE=;
 b=JHrxCh30ys+WuCDwMFS3fUljtH9marWqfVniD5MM/LAQYt6qtitaqwemNH7vyjZfyO
 kmqhWtoJEgqYMVjw7ki5BrveqIcz3EbA8ZmGwQW628YIhwSlNuh6nl+Vy9q8nJTmp3xz
 X8WM8HMGBwG+3nBgwR1s04O9ylRnRPsaJlxGVx2euvuF1f5StbO7zYPHllI8jR8jjIMp
 3DiufbqeYvbUtrD5h+Llq/3PLHt4fM4sFsUQp0C2txyXGvncUKLH0z8m720zbtMLBctc
 XmfuruyYYW3SV0rN/2B9s8HVzrO2keZIEDN6vvL34pbuGD3gTPSb/RPq7vtJ9jldW5Um
 ltbw==
X-Gm-Message-State: AOJu0YzbWhodGgqcsJDVnfHedF5X/y0AXbNfii+EB8WgY6FR/d+7pGZD
 BrcU4oc4obswx9p80ReeA/4H5KppLcwc2tOU88o=
X-Google-Smtp-Source: AGHT+IHgg+d+y+e22SDHRV9dGJffROoDsG0uElr2GRxeTGjs/0wuCmqHpdHqGYMN3fyi+HX5vPwbKtJwIxi497hiqWo=
X-Received: by 2002:a05:6871:7505:b0:1e9:fd9b:735 with SMTP id
 ny5-20020a056871750500b001e9fd9b0735mr756373oac.56.1698350933920; Thu, 26 Oct
 2023 13:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231026102402.206783-1-Arunpravin.PaneerSelvam@amd.com>
 <382f8b84-f889-4899-b17a-0989a771b7c2@amd.com>
In-Reply-To: <382f8b84-f889-4899-b17a-0989a771b7c2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Oct 2023 16:08:42 -0400
Message-ID: <CADnq5_ONvw7iL1OYo=sdeC31kZtkk2GyNE5OBrDb49CaUewk2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove the seq64 map sequence temporarily
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I've gone ahead and pushed this.  Thanks!

Alex

On Thu, Oct 26, 2023 at 8:37=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 26.10.23 um 12:24 schrieb Arunpravin Paneer Selvam:
> > Temporarily remove the seq64 mapping sequence.
> >
> > Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.co=
m>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Please push to amd-staging-drm-next ASAP and ping Kenny when that's
> merged (or if it doesn't merge automatically).
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ------
> >   1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 55fea7564758..b5ebafd4a3ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1365,12 +1365,6 @@ int amdgpu_driver_open_kms(struct drm_device *de=
v, struct drm_file *file_priv)
> >                       goto error_vm;
> >       }
> >
> > -     r =3D amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va,
> > -                          AMDGPU_SEQ64_VADDR_START,
> > -                          AMDGPU_SEQ64_SIZE);
> > -     if (r)
> > -             goto error_vm;
> > -
> >       mutex_init(&fpriv->bo_list_lock);
> >       idr_init_base(&fpriv->bo_list_handles, 1);
> >
>
