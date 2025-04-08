Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E26C369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 17:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ADF10E2A4;
	Tue,  8 Apr 2025 17:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X+9XUUop";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DD410E2A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 17:28:03 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso1105009a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744133280; x=1744738080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pUqaDPkafY2Au3O+IXkgdTsLgkfbZZZwmd1bQSDnyE=;
 b=X+9XUUopg21WSQDZmdmTHQO96GuiclIZvZBMXOqNPkE+4CgMdZpvqESOpczf8Fmy/X
 qGWaXgSfTz7M8fHTzuKVko8lwicZBnCHLHhyrbHUhW+tl82wH8ulFcOXiNNl2KzEs4FP
 m/3WCTIypRs8Q/x2O6B1Bny+ckq4Hmbvl7WwdmcjTPU7pRjr/36RWHUJ1Rt1jYkeWibS
 c/UQIEhAK+Q8zlDdpaAQapDzovoURdhBWf00AtsQsWmvK4zY4zVOwAsXdW1ElRLqBwvf
 7LCcLuKCr+hqrg9FBCe9HVfkCnDnRKznVuBNs/tMFjNmhyp1l2WFuIWXRGAcpBhIuxjl
 BQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744133280; x=1744738080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pUqaDPkafY2Au3O+IXkgdTsLgkfbZZZwmd1bQSDnyE=;
 b=UlUAMQiv3Nb21wa+LFGNbuZmg+05LzMJ7VrhvKJrsUk2kJpIK/he50zNZTMuRG51r8
 MOblyDjNgAJNMdFreS2hYsFO09QJMVjm8idOkBf62vLRJZ3aaiyBJv0j6vIjOnBG5z5x
 DF9QpSuqNrn5yw+ZSNhNSVYmlcJQAGN/8Kx0MkBNcT3r1BBXQbtGiPYXWnaciVmeipMz
 N980616guZfvikQWGKUaK/5T91xh+EUYy9b342aAETgaHNf+u74Uvo5Uf/elZr176DU9
 I13oTAqJI2MV/tU1kPWcM11h3Iu3SQY5oz2GbRwU8wMqUhiiiSwkPYRafBYlfJ9pVCkh
 nrfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQcD1A08gYZ4nxfAoX507BDVHGpVAE8VoWf6RtwZfgjf3x7bzTZ0pLpP7txnP5/bp3ASp92ioa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyB7YNvM/PeDXXLdeaxjccCzx/EIWo2DfnPlQK3U5mWQvU6VOCg
 L+mUvDoYe3PX4c+OSFUnT+KTLSIwe3t8ln88rgUdSrwrriTewlP2Dc5q8RqWKgFqg9UanLV3JvX
 hx+JyOEYKoMvKkYjHFjiw6e2o9TklSQ==
X-Gm-Gg: ASbGncsp1USoLrh+SvArdNVSKHR8qdrHQc78TlKfnD0QNKfk3ngRTwBhVb64b68EhvN
 PbRZiEObGTpLVHh4+/rdu/NytNTB1DXn4BMXYXaUw496DlWWF6+WNlIc3ysHdydCHP6YXSpQue6
 53SDXC7xfl7CkKOgFkjs+9cgeq8A==
X-Google-Smtp-Source: AGHT+IH0xCUWWTmowtGU+2sAsyukANjRzbU1Ljx8miDI9qP1EG2fyQFyOqPcKwxyDmD9e3axUXaOG7ee8SLsi/KcJRw=
X-Received: by 2002:a17:90b:3ec2:b0:2fe:b2ea:30f0 with SMTP id
 98e67ed59e1d1-306dbc0ebe0mr34800a91.4.1744133280207; Tue, 08 Apr 2025
 10:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250408082343.207648-1-zhenguo.yin@amd.com>
 <704617ed-7821-4154-891b-50de9e34a103@amd.com>
In-Reply-To: <704617ed-7821-4154-891b-50de9e34a103@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Apr 2025 13:27:48 -0400
X-Gm-Features: ATxdqUE5j0n4jkyVVXLvn-9PqJNjnKVvIwO-2mUNdRaKmsKwhdP-uGATghAhI8I
Message-ID: <CADnq5_MHuPDVht1M1Rkd_Wj9QsNewdNKtGkn3onXK_m5CpGrog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org, 
 shashank.sharma@amd.com, yuliang.shi@amd.com, 
 Alex Deucher <Alexander.Deucher@amd.com>
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

On Tue, Apr 8, 2025 at 5:53=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 08.04.25 um 10:23 schrieb ZhenGuo Yin:
> > Kernel doorbell BOs needs to be freed before ttm_fini.
> >
> > Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
> > Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
>
> At least from my point that patch seems to make a lot of sense, so feel f=
ree to add Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
>
> But I would at least give Alex a chance to take a loop and double check.

Looks correct.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index d4b01ef00025..ff48096c1d80 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3508,6 +3508,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_de=
vice *adev)
> >                       amdgpu_device_mem_scratch_fini(adev);
> >                       amdgpu_ib_pool_fini(adev);
> >                       amdgpu_seq64_fini(adev);
> > +                     amdgpu_doorbell_fini(adev);
> >               }
> >               if (adev->ip_blocks[i].version->funcs->sw_fini) {
> >                       r =3D adev->ip_blocks[i].version->funcs->sw_fini(=
&adev->ip_blocks[i]);
> > @@ -4851,7 +4852,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *=
adev)
> >
> >               iounmap(adev->rmmio);
> >               adev->rmmio =3D NULL;
> > -             amdgpu_doorbell_fini(adev);
> >               drm_dev_exit(idx);
> >       }
> >
>
