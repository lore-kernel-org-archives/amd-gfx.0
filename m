Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1D9E7DEF2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 14:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F07A10E2C3;
	Mon,  2 Feb 2026 14:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UGnMOc2O";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BAF010E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 14:58:36 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b71e7dab12so231690eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 06:58:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770044315; cv=none;
 d=google.com; s=arc-20240605;
 b=S2V7YlLxxGLpLJB93+vX7wz0KiTNYOasV9PfF1Idx/mAn3YKrzroYcDfEoVijW672C
 ujy0SMnMPnNzh7wg+HZDqQKJ+nhAC4wFC9NQ6FJ68JfJh722ItWED1gvoYzP53DAv/8f
 QWRe1ATe4vQ1I1HinY9VB2145uqtGu5BkeI+y5gAU4BZNp8Lwsp8i33Iy2F3SCosI5XF
 KEM5z/7YnvvHrwr4OiynSK0t4vUPhZza3Uk6Tzy0ko3DZredW6dAW0DVCfDs+03uqY85
 yM8nvBeAeU3HiemMv3WtOQEsOrp3RWNXh1yW71ZeIfEd/S4+58Dxxkp9aKawRSbl428I
 aJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y8+k+DGcAe1gDTlJAG9djuDxYhynbUvFBC9pBD/2cLU=;
 fh=a4+FQPtBJMIN6fxKtLBA7A1K8pzbxR81Fdr0y1V0WQg=;
 b=aSq3nDAxQYUOowy46PJk6p57XKfXJRP5Yjm/MMtZaEmB8OZJIXJ38EKjab0/wyzsGM
 oqyGNqzRL5rjPsUmWY7KRmU16jbR5Brj5THmdVc0AzgHFY6rTDNso9fDFJSFwF7YV55F
 SrLIKL/aF/2AM3xIPuXbKVZw8npoJr1lJU1bw0OLuIgjC0ErDR9Y/WYISz6S9xbKIaZx
 fwX1okDk1R+Bv66FpW4ob8Efv15WfDbeGMUqsNzR6I2J1YL6fzC6JVet+3auv6TJ2Tm3
 4UqGGXz9Hbgt3+cAl1xzoUig4l+t9K6vAGUxZuCV0JQlk3a9oNcbxzV/yrFJs78KVZWF
 sWOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770044315; x=1770649115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8+k+DGcAe1gDTlJAG9djuDxYhynbUvFBC9pBD/2cLU=;
 b=UGnMOc2O+AIxkFJ047jSwAIhSAKtp3x0r4tpr9cOAWKZT2XrjXYkr28UyF1WB12cKf
 pLfPmUBPHpLMwrz2JD5417yDlY+pU0sOvpX18QmKC8CEuiOSrT6/XPb7vd2Z7hiO76jn
 IUkEyfufZ4H4nKS0t/oFl8e9NrYE37MBUh3gJNLjukpT9g/hLfNqNhl4LR34Y1F6m+X3
 KSvP/EDbFqybfzfeAwlcvlQXHcBeb+Sz5hHePpan3I6JcDpHKZ0P8Jit3bnuR0NCkMJW
 CL+rVxQIqG8bAXjx1yMxhN6lmip5mIDVISohpdlcAfKF4uw+gTUYsyNdvZgluSsQhrBb
 Ag8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770044315; x=1770649115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y8+k+DGcAe1gDTlJAG9djuDxYhynbUvFBC9pBD/2cLU=;
 b=UBgC7Tor5+/uHdm4RnahtAYUA0Br3jrFxSWL9Az826wchCeNI6WyDURodB5BTR4Sa8
 VQgeyPmnAamakkXHbosEDbFJadi6SmvvYz5A4xLkRGcMhzz1B+k3rIhyjGztOKcpk3mZ
 Nd1guxbcjKBi5fHoCvmLkEurJrHtPcXyh1Lb7B3DrIMNfRaUUqIqR4nnHJn9/1xaqctq
 sDGbttC8MJ+ASAjwJN3tsdr0Gtr+asoF0Z1uC4N18hsUqTp2S0vXGm2pM/7EHz68MVIu
 LLyHXl62SoGdD4ll3KqWYCRIfWsVF2b0DaW1xp/+atqB7jUJYymPpvNYwt95qLToYTR+
 nsPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6c9xFi0vWx4xFlOkLv3EEwwKxqiZsdgGiF55aJyeq13SN+3VCJL7igjJ5fnui2JSYetGz0wcE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2ygVIz33Ag5VF1w2cOCU14AeQYRdKeRjhbPOM4iGliSCKbSov
 M01VxKFbUiDVCr6btaLh7OrrWE8SWv/EDjv2MNKALimCT2pEKc3Fuvgqo5yxl39mJ53dCoNQpK6
 sC2h4164CM+2YbU33wwlvmXGJ2cVMg94=
X-Gm-Gg: AZuq6aIkN9ujgSGHTAidGIafNgysjRO14ptftfCNFpoBwUnl8WDAt6gYaN4wcEhlGY/
 AvQEsI6aK+KYKjvooF5BCwq2SVWg57mfoC6qJ/V6q8j2wdq7oukt/SIxfDR2fjjjJtXL2Fo4D/u
 7bxHe8O5NGaDEITgmpEOiJFVLa+HCewsQVvlg5FFoCeOuTmRYGfn5CMzHV8M95b464STXLTpptS
 7J7b46k3lXB83OOHZhLkt/Kgzx760mmfL5f9l8j8gFOP/v6eI2Wtxo6Wf3bTefmo2Dxfvew
X-Received: by 2002:a05:7022:6b82:b0:11e:3e9:3ea5 with SMTP id
 a92af1059eb24-125c100a594mr2795816c88.7.1770044315352; Mon, 02 Feb 2026
 06:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20260129083515.886112-1-zilin@seu.edu.cn>
 <PH7PR12MB8796F7F06A2F1DEC1FDAD683B09FA@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796F7F06A2F1DEC1FDAD683B09FA@PH7PR12MB8796.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 09:58:23 -0500
X-Gm-Features: AZwV_QjdSskZltGpn-Lxc9ZyLeeFo3MJpk3n6GdqUfo_LpdyViGB3DrIoz_5Tm8
Message-ID: <CADnq5_Oc5bqtnjMyOgZOaSfK8uuNyZnY6MxYxCr6qo0he=cfZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_ras_init()
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Cc: Zilin Guan <zilin@seu.edu.cn>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "simona@ffwll.ch" <simona@ffwll.ch>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>, 
 "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
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

Applied.  Thanks!

On Thu, Jan 29, 2026 at 10:37=E2=80=AFPM Zhou1, Tao <Tao.Zhou1@amd.com> wro=
te:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks for the catch,
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
> > -----Original Message-----
> > From: Zilin Guan <zilin@seu.edu.cn>
> > Sent: Thursday, January 29, 2026 4:35 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; airlied@gmail.com;
> > simona@ffwll.ch; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie,
> > Patrick <Gangliang.Xie@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> > amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org; jianhao.xu@seu.edu.cn; Zilin Guan <zilin@seu.ed=
u.cn>
> > Subject: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_ras_init()
> >
> > When amdgpu_nbio_ras_sw_init() fails in amdgpu_ras_init(), the function=
 returns
> > directly without freeing the allocated con structure, leading to a memo=
ry leak.
> >
> > Fix this by jumping to the release_con label to properly clean up the a=
llocated
> > memory before returning the error code.
> >
> > Compile tested only. Issue found using a prototype static analysis tool=
 and code
> > review.
> >
> > Fixes: fdc94d3a8c88 ("drm/amdgpu: Rework pcie_bif ras sw_init")
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 2a6cf7963dde..8de9f68f7bea 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -4343,7 +4343,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
> >        * to handle fatal error */
> >       r =3D amdgpu_nbio_ras_sw_init(adev);
> >       if (r)
> > -             return r;
> > +             goto release_con;
> >
> >       if (adev->nbio.ras &&
> >           adev->nbio.ras->init_ras_controller_interrupt) {
> > --
> > 2.34.1
>
