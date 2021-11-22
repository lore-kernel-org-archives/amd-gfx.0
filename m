Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DF9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 15:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1C889B51;
	Mon, 22 Nov 2021 15:48:04 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12A789B51
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 15:48:03 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 h19-20020a9d3e53000000b0056547b797b2so29410578otg.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S20s0QBjo0OaA1+//y4F69UCFE/r5+TeDr1z2dpiXTA=;
 b=jaR2+3uvx6tMQ1IZtYDsoc73uBSeSUM5hAJ3sr7dqAqvmmI4er4t+sB3Lo5frPgvW5
 kIdpVwUYxeHBH4zShWss0pFiTmMKDCBQSF0JF7dKpS3jVlyVO/PRHtkebFPs5juNR+Hu
 yQ8BWMFfnqqMHiiVyuqD4F+Oe4OybdwbShTcTvmrltiwNe0UfTT827NXT9tdWLoj5ZUV
 alsG2VJJ7j5BwMCGITpRHEzbK91Nsv/qvARdfvQLSlHvOKcVzckVLS+QnCRqRWkFx6jk
 dzd8rxw9Mr+e6BOSLhZq3a5rQjyG6B83Hv8RD94r4L6XXAoO/elxJzxxPB+x5HLbNmN0
 ve5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S20s0QBjo0OaA1+//y4F69UCFE/r5+TeDr1z2dpiXTA=;
 b=drqYFWg4DYPi1Frv7m5Y8m8ytu9E6jAzj79Y5VqyZI3p6AEfLdTSlRDCXdX/SVI2Qm
 sqEZr6aE8at5SLd6r9JWNzIcgb2TcNGc0YLGZm3ZHTq0+IDJXYJBY8+Lw4+zB80pgr51
 buJjRqYzQ0WLZlD+CnZZZrA2J5HMnPVQuFKpdIhpdjrADj93qa9204sO1Ba8mJmziSWo
 RTVhIzG+B+nMVwUKBqBRlL+e4vqa+hovbPdBinGoLUg2FV1F2m0emaXrAjwb/MIvUGM7
 iGCtnNph3e5BEtmgYRMb7wyxXD/Rp5E43s1Vw8aaYwAzYWRVdsBazyL+aka9SHYSRKBb
 Xhvw==
X-Gm-Message-State: AOAM533FwkDkPPoZqbh1D0wWX6U8jtIs9Dm7117I5H8JzBZkXSQJTxW6
 SK6suhaSrDZmhodMPJGlfGQbf9PmNjhFZjOp218=
X-Google-Smtp-Source: ABdhPJw3it0N7x5wfnDBS06SgDjHebzs17783bt3+ls90R9lcmcFMuuIv0xz9PXt5RtqKymvAd+Mhb40ZGAxZPQK+6g=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr26091785ota.200.1637596083058; 
 Mon, 22 Nov 2021 07:48:03 -0800 (PST)
MIME-Version: 1.0
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
 <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
 <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
 <14cd6274-c967-ba7d-71d7-ccf332c30494@amd.com>
 <DM6PR12MB3930D33025C01706AE0F258F979B9@DM6PR12MB3930.namprd12.prod.outlook.com>
 <CADnq5_MbghaKafhQ0cQZPoL4FNHap=53kCDGP4X99rxe7Du-eg@mail.gmail.com>
 <MN2PR12MB3246251ECB6905B242B29379FB9F9@MN2PR12MB3246.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3246251ECB6905B242B29379FB9F9@MN2PR12MB3246.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Nov 2021 10:47:51 -0500
Message-ID: <CADnq5_MGrr7h8e00U6y9uiONuTgpQ0eNDzntKLNA7=AqDVsApA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
To: "Liang, Prike" <Prike.Liang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 22, 2021 at 9:23 AM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, November 19, 2021 12:18 AM
> > To: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Christian K=C3=B6ni=
g
> > <ckoenig.leichtzumerken@gmail.com>; Liang, Prike <Prike.Liang@amd.com>;
> > Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend
> > aborted
> >
> > On Thu, Nov 18, 2021 at 10:01 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote=
:
> > >
> > > [Public]
> > >
> > >
> > > BTW, I'm not sure if 'reset always' on resume is a good idea  for GPU=
s in a
> > hive (assuming those systems also get suspended and get hiccups). At th=
is
> > point the hive isn't reinitialized.
> >
> > Yeah, we should probably not reset if we are part of a hive.
> >
> > Alex
> >
> For the GPU hive reset in this suspend abort case need treat specially, d=
oes that because of GPU hive need take care each node reset dependence and =
synchronous reset? For this purpose, can we skip the hive reset case and on=
ly do GPU reset under adev->gmc.xgmi.num_physical_nodes =3D=3D 0 ?

Yes, exactly.  For the aborted suspend reset, we can check the value
before doing a reset.  I think you want to check if
adev->gmc.xgmi.num_physical_nodes <=3D 1.

Alex

>
> > >
> > > Thanks,
> > > Lijo
