Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B5CC77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 14:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D2E10E20D;
	Mon, 15 May 2023 14:53:17 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBAB10E1F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 14:42:22 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3078d1c8828so9717176f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684161740; x=1686753740;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mbrnFaoPoV6auTnbAVlCpOChJelNMoaQ+2iKpw9ZQo8=;
 b=WDeApaIrAr+nh2FVyb9Z6WeHppbkgOb2aoo76JB8r2GU2gpn+xDvf7iEja0Uj0t0sq
 zz0SGP3rV8EL7vCCnmHRoibOo1wwNfGhKLNX6fXr7gM+0pHjPzO006kxoI+hIkXfmz5c
 NznoxgDGdmZD13gTlnhlFeDdUhiCFnqKSxYiKicqCHNTCElJKDOAZe/CEr5kiOuHifN1
 lza/YD10Z1BKY+HNIwjR6juaMTHLKcbCnJfk3+ZWTnOv0TORHgQ5tG9z2Ut+ruizi+3+
 QXLO1JoIOQenBxAoHqQprCf0TyWBUfSby8bdxjv03ewsdWp1wFbq2QMJEv9nEuPxDcPy
 Uweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684161740; x=1686753740;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbrnFaoPoV6auTnbAVlCpOChJelNMoaQ+2iKpw9ZQo8=;
 b=VRekGQ0JslHFxMhmu0rynXfngaR7MkkMgJz/JzJv1fDPeQFopxSNKPW5V1Y1skp2PQ
 BLqIWgGLeiTJNQFU3M0IOtYDZBV3aUqQ0HgNkvauOaCZeZbE4/NfrN6i0gwUh/jyBN/U
 gc/yUsl5wMfD+IEEkSgVmtr3dPUmdzG+YL6El5ZVGM5zmS+zxoZ2a6swssSZSPzTy6uc
 E4WUJN65o9mR6Oba0YkvSEAW0NOll1y9t+CeAHmB0pYGq5CoTZo2lwg2bLhdQA6mnXua
 42mkgmGy7I7VyYcow1zB4CVw14wgKKkNoWKfj4l2IKaLu6IFgKgsza79G2UZRVMt5fjS
 MbVw==
X-Gm-Message-State: AC+VfDwfFDGhxla/DX9cMGx33o/ffbDV7NpPxbsntCHCyDLBsw8y76NV
 e+WmojeWfQ7fze7oDuHP+ztgdA==
X-Google-Smtp-Source: ACHHUZ4ZdYo0QmdipmTJhbkhtqheg8LHZCjI5dchfxlFIwk6dZAR0+yhLfsv/+iAKWWM7rlClTMNrQ==
X-Received: by 2002:a05:6000:1191:b0:306:462a:b78d with SMTP id
 g17-20020a056000119100b00306462ab78dmr21924023wrx.53.1684161740075; 
 Mon, 15 May 2023 07:42:20 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 i6-20020adfdec6000000b002c70ce264bfsm32690343wrn.76.2023.05.15.07.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 07:42:18 -0700 (PDT)
Date: Mon, 15 May 2023 17:42:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unnecessary (void*) conversions
Message-ID: <be331480-4ea1-4798-81ec-540cb662c8b7@kili.mountain>
References: <20230515013428.38798-1-suhui@nfschina.com>
 <ebe9d98c-148d-4694-8f97-96bacd0b9f7d@kili.mountain>
 <CADnq5_Nei-XHsD8DQkpUGZwZAik5X-S1R3znOJGD1X2jAxD6_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Nei-XHsD8DQkpUGZwZAik5X-S1R3znOJGD1X2jAxD6_g@mail.gmail.com>
X-Mailman-Approved-At: Mon, 15 May 2023 14:53:14 +0000
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
Cc: Su Hui <suhui@nfschina.com>, Xinhui.Pan@amd.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 15, 2023 at 10:11:39AM -0400, Alex Deucher wrote:
> On Mon, May 15, 2023 at 3:17 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Mon, May 15, 2023 at 09:34:28AM +0800, Su Hui wrote:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > index f60753f97ac5..c837e0bf2cfc 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > @@ -1470,7 +1470,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
> > >
> > >  static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
> > >  {
> > > -     struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> > > +     struct amdgpu_device *adev = m->private;
> > >       struct drm_device *dev = adev_to_drm(adev);
> > >       int r = 0, i;
> > >
> >
> > This declaration block was originally written in reverse Christmas tree
> > order:
> >
> >         long long long variable name;
> >         medium length name;
> >         short name;
> >
> > So you probably want to change the order now that the lengths have
> > changed.  Same in the other places as well.
> 
> I don't think it's possible due to the variable dependencies unless
> you separate the declarations and assignments which doesn't seem like
> a net win to me.

Gar.  I'm dumb.  Sorry for the noise.

regards,
dan carpenter

