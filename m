Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1593606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fm6qEM8n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D0510E3C2;
	Thu, 29 Oct 2026 21:42:06 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9404711258F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 21:42:00 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-14f0e9c6543so789c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793310120; cv=none;
 d=google.com; s=arc-20260327;
 b=mBRI4BsNfhCc2xCno2HZJ078xpduukKqzxda8so+y0AL9OfGFrydla4dqTK701w7Mn
 pts7UbEYJMreduq8QGEMacGPwkOuCm7NoRPTHy8XrFc1DsbRpJS4Nvzk0mnSEt1tzohp
 mPrJb0TOOgRcwBmFuAcHUbRBbhgzvaVmz07UF0CH57eL7aQNTvla4zh5uG7CHhkAUq7x
 wMp54cpDww/97jOfNmODGxOQ1ROdH/2VeFeb9N9R3zNVrLHKOWqOQBMXogBKDEsAk8nH
 uraYFNd6b/SUbNAfdIyHVTrw5wfuJ+3SGyDYLzEpnZTWfEDmer3daOnAe4dUFhC+c8r8
 MhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dk5h0DQeljLWku1pXTL5ktRbDQ+VRspmfS/vq5HKCFk=;
 fh=X4mUfjZVgvK6OABXLMbrCgBBJmiAn97ZZje7MPVuzbk=;
 b=B6CVc9GLnaJJu6dcWHAKUOJiZ4vKFTVm7IadDbFHd1x6FxFIaS7xB5Cb3/WFORikPM
 jhX0To5fKleCvoUNY2PPFjha31fcGgzR6IyN8/XANddY2eKU2AMBj1nn4P9Y2W355kYC
 h2EXcRgjP6iKuGZQK3h0MoRNzJpwIGHXtYASSS5z1vDp2wvyW48dG85Iv3io5L9dpYzM
 Gyrpjx2bc2Jxd+iTY5TvsUrY/FJymK6jmxXepREK38n3QM4kNdYmg8e9/3HDY3gip0yS
 PUb9wOKVZOFoCpuAudLL89OerMKCA+32MjpBaEb8DtAo3AuamOPhxTzbZPvb/JKzmu/m
 y9Ng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793310120; x=1793914920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dk5h0DQeljLWku1pXTL5ktRbDQ+VRspmfS/vq5HKCFk=;
 b=fm6qEM8nRbVXBJat8IVkKQl5MONaqiRYfStUNBS7wEK8CCcE+XjNJYLtSDPVnNCQy8
 t88e3JErOY4tlo8ZMjROyfs7ZT53nIjkq0xHHX6Hx60ZLM6PFK4NOh84eB73ez+TkTWv
 /nWxCSYSpJBGqswtyxwlqjeRpSW4JqbU956kXJWhTob/IkQ3EI60Jg6mwKvCuL2nA9aZ
 jUUuhGCjf+sa3x8L1ehrzlnAUo0ZjzDxeMulVVlq5xJNtJgW7+3yuvJDZ7KDogUtLPXi
 nz8O3oLCNgoNTIxrVkeic3y1GeKpPEGj+J9e/iGAuTqe3JBBrcnMwgeH5XUz3D4b3IOp
 EPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793310120; x=1793914920;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dk5h0DQeljLWku1pXTL5ktRbDQ+VRspmfS/vq5HKCFk=;
 b=VZL48cAYva+RnizdVUlCu241OLZzT3O1wWiKF4SQAqYwNFtJ3JbpfzvMmndBCR0crz
 tG5lfme42IrCxzpyZvEWR+Qmxjwbi0qv9Fm9Gg7JLjDeiznY+qW78t+RFR3oqE7nCDxa
 Ak6Y/XsWd/gwbyxWGnEmobegQDZ2rBIuoBKrtEpV8RBv1BKmf3cUv2RotpWg+sUnk7ZQ
 xpdVIY0tCcXPgGo3EOAvsi2KfGc1JP0fWHsh8OSk4s3lUjaDHOzt1aEeYyqyomkgRD3X
 PdqPP+zLCPD28OBZsys0IlaWXH7uCFn09jVKzEfpnLBL3uK5qnhLK2KDelZv+acR7uys
 NIuw==
X-Gm-Message-State: AFq9FYIPxBuy8vHHQ06Y1ZIwqgvJ6UARH2drSO+5FfCOvh3B3hhqzds/
 ct97pdkZwdeC3vCZI4Kdfu3tWwuOfSG03N6ApyRiAVj1s/0l6fcoztVq2AD/7TIWwi+ADMInIBU
 Zni9PsalNUJdXjIdqHvNsYiLB0tNODyAxcxhu
X-Gm-Gg: AYBFou0FGvQJBQAs4n+ysCsbOBmg9e8/zn2/EGG/xwL3i3Y9/rZacXKmwzXiYUS5JM5
 KHSGei+mkfA6I2CFy3oQZwi4Q6uwYVfd4870u8oB9APIb3dL/m4U7rcW7rH+m79GiQdLlg2rfe4
 GIGETmtYmDexdTOiOWr5RYhefDGTJ4AsVIIRKdxVRLWl0q92wMbVo5yxAP+onA6O95iBsjlawwH
 XG/Ox8aPIjWHKdzYRrdKB5PHFgbFVZsrOfYzaXaO3vOA3wa9imRTn3x5UK9+/ZEPdp7lE5A4M4r
 ose4KI9xLVO8H0+wfQvImBRvS1wbecgCmAbBjiCbaOObEcjQT7I5BP/VPsuXfkX/dgBb68kW8dZ
 fcBOA9acG0ES01e5BRdhpCgaVuAYjY/eSTckl2FWB8T23wgTuCZg05m1tSozNKmtc/oQsM6kqTt
 LuXpb9EwmeqwIXVTRjIQ9eB4o=
X-Received: by 2002:a05:701b:2710:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1ac58e573b8mr594592c88.1.1793310119707; Thu, 29 Oct 2026
 14:41:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016131604.2198664-1-alexander.deucher@amd.com>
 <CADnq5_N20qUbmob=zD0QTurtxPGboR7BRj6dKPsjGKpa+wXqVw@mail.gmail.com>
In-Reply-To: <CADnq5_N20qUbmob=zD0QTurtxPGboR7BRj6dKPsjGKpa+wXqVw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 17:41:48 -0400
X-Gm-Features: AclHuK_8kCA4vzZ1te-D_PWFxKSwderaYW4drk_TH1KMxCwAe03rXALG8Y8pehQ
Message-ID: <CADnq5_PU97WP=qPjnsv_h3G-Sz2nxq6Hwapk3WCmhs5jkeuc5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: allow dispatch tunneling on GFX12
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping again?

On Wed, Oct 21, 2026 at 9:48=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping on this series?  This just fixes gfx12 to align to previous generati=
ons.
>
> Alex
>
> On Fri, Oct 16, 2026 at 9:16=E2=80=AFAM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Was implemented for older gfx generations, but got missed
> > on gfx12.
> >
> > Suggested-by: Jakub Oko=C5=84ski <jakub@okonski.org>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 1ac0d33e62e26..c9e091ea8c5e2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -3168,7 +3168,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdg=
pu_device *adev, void *m,
> >         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> >                             (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1=
));
> >         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1=
);
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, =
0);
> > +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> > +                           prop->allow_tunneling);
> >         if (prop->kernel_queue) {
> >                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STAT=
E, 1);
> >                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE=
, 1);
> > --
> > 2.56.0
> >
