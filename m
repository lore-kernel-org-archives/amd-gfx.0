Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B70CE7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 17:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B9010E403;
	Wed, 11 Dec 2024 17:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOGhB15i";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0A910E403
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 17:32:56 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2162f968cd7so6024505ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733938376; x=1734543176; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94WM8fCyV1AVoEqupGN2jDEnkZmdK3s9QAWISLhJrAw=;
 b=SOGhB15iB/nVIykeItoyOlg2ytTNj9lnxehLR2W8Ge65wJei6UobCIVN4bu8LZF10G
 CH1F4HZf64GOOyBF+9WCGqhu3Afw4yqLIte46XVHC4ElR0Dt0kIXM8Pz4jZHxfaLWzK8
 xkvx/QwKpF05Q6c5yjcAl7UKPEqtxlW8tPfGqUsm19YFgOQLBAsrlqzRRPKYOeJgiU2f
 W0LCT7OuqNycBm6ewsr7nrnXo21xxNsE4C4lU38nY4C8B2lFZJy38JAmvMS9oKdLSwUf
 9cwIpczwhPnfHM3c1F5sdnNHGTJ+vlVuuewer6Cp0wjivC3WisRZ/4bOxeYFIPdHynDq
 NOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733938376; x=1734543176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94WM8fCyV1AVoEqupGN2jDEnkZmdK3s9QAWISLhJrAw=;
 b=UcOJfMBz+FyVfd+XWOc7uATszeH2QJ6wNuIZ48/fPfJS4AwMAvbCk8TpJ8w530RzUm
 AdMW+SH9SMbbxKzqLp/+Coxua/A9YRQOzg6LSESjlRsI7YoQnsOdO9IvCNz1kR3HcdAo
 9Ceggetctt2xkbbiKNPQ+mCTu6HGEkrZF7JU5Rlax7NarkmDD8wsHjLtXwMd2oQM2APm
 77uz17CAEVGFdbjQIcHfOXBmdLP8AWFGErbjQbnlwA4bXfd6u9/GvzspblUkbqFi2aJG
 ynzTmLfzK4OcYqtTpXE4GyPhnw+fY59ciJ0Puca65wjQUchsJyL7MIMd1RRLMmngtiAI
 C6uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQJgXInIw4qSO/wYrCW1bQDXlXPISCgDoe77jzM9hOzFr8EWy7dKjogjUNw4L/Q8X4GEquIxpd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKAb8sOGSKR5GSEt0GE6IxSvrAeTDT7RFUQ5YsGSV7tf4SeIAB
 hw2a67CxOEGmt4NS4D+nTUFE2xAScVoTHuSkFAfyKMjsoyCw9/+VppgILtSf47t4IcS1KescdnU
 NgNgll9dlz39Q7h2Y/k53m9YDa1k=
X-Gm-Gg: ASbGnctM8cqSDlqUifn8OBh9x/KwsimOlX77MQE90Toalc/9uHYfBe+qWZVcdY1auAm
 fbNe19akfFJ8oawDtsUYsVAjn1EnZfqPW2sk=
X-Google-Smtp-Source: AGHT+IFwIXLhtX4m258sV2q+WxeFfOu6Vk/KWPb7MnFKg8s5KrACACHiHtXqBzxi3HBmsSyDh3GGIxs4ZvptpqVRHiw=
X-Received: by 2002:a17:902:d4c2:b0:215:a81b:42e1 with SMTP id
 d9443c01a7336-217783c26bdmr21494455ad.8.1733938376021; Wed, 11 Dec 2024
 09:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20241210225337.75394-1-alexander.deucher@amd.com>
 <20241210225337.75394-44-alexander.deucher@amd.com>
 <893c7427-2d06-477e-8249-b5cf3ad22a11@amd.com>
In-Reply-To: <893c7427-2d06-477e-8249-b5cf3ad22a11@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2024 12:32:44 -0500
Message-ID: <CADnq5_OaJPWPE_YN5q-6=EyVH9fHgDkkbpCb818RvmoE4yKc=Q@mail.gmail.com>
Subject: Re: [PATCH 43/48] drm/amdgpu: add a helper to get the number of
 instances
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Dec 11, 2024 at 2:10=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 12/11/2024 4:23 AM, Alex Deucher wrote:
> > Add a helper to get the number of instances of an IP type.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 0ef598aac05c9..c3be17835f103 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -410,6 +410,9 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device =
*adev,
> >  int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
> >                              const struct amdgpu_ip_block_version *ip_b=
lock_version);
> >
> > +int amdgpu_device_ip_get_num_inst(struct amdgpu_device *adev,
> > +                               enum amd_ip_block_type block_type);
> > +
> >  /*
> >   * BIOS.
> >   */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index b5208a16d7d41..fcd8a1e8ae351 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2371,6 +2371,43 @@ int amdgpu_device_ip_block_add(struct amdgpu_dev=
ice *adev,
> >       return 0;
> >  }
> >
> > +/**
> > + * amdgpu_device_ip_get_num_inst - get number of instances
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> > + *
> > + * Returns the number of instances of the IP block type.
> > + */
> > +int amdgpu_device_ip_get_num_inst(struct amdgpu_device *adev,
> > +                               enum amd_ip_block_type block_type)
> > +{
> > +     int i;
> > +
>
> Patches 43 - 48
>
> Now respective ip blocks know about adev-><ip> and use that in one way
> or the other. Instead of a straight forward usage, now iterating over
> multiple blocks to find the same information seems a bit too much. If
> adev-><ip> is already abstracted, then this makes sense, but that's not
> the case now.

These last few patches were more of a proof of concept to hide the IP
specific details from other IPs and core code.  I agree that we can
probably skip the iteration in this function for now since it's not
necessary and add it later if we do split instances to IP blocks.

Thanks,

Alex

>
> Thanks,
> Lijo
>
> > +     for (i =3D 0; i < adev->num_ip_blocks; i++) {
> > +             if (!adev->ip_blocks[i].status.valid)
> > +                     continue;
> > +             if (adev->ip_blocks[i].version->type =3D=3D block_type) {
> > +                     switch (block_type) {
> > +                     case AMD_IP_BLOCK_TYPE_UVD:
> > +                             return adev->uvd.num_uvd_inst;
> > +                     case AMD_IP_BLOCK_TYPE_VCN:
> > +                             return adev->vcn.num_vcn_inst;
> > +                     case AMD_IP_BLOCK_TYPE_SDMA:
> > +                             return adev->sdma.num_instances;
> > +                     case AMD_IP_BLOCK_TYPE_JPEG:
> > +                             return adev->jpeg.num_jpeg_inst;
> > +                     case AMD_IP_BLOCK_TYPE_VPE:
> > +                             return adev->vpe.num_instances;
> > +                     default:
> > +                             return 1;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * amdgpu_device_enable_virtual_display - enable virtual display featu=
re
> >   *
>
