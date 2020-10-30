Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC791C00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 08:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4D020739
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 08:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgIk3kQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4D020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611B76ED0F;
	Fri, 30 Oct 2020 08:35:50 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BB36E95D;
 Fri, 30 Oct 2020 07:57:23 +0000 (UTC)
Received: by mail-pg1-x544.google.com with SMTP id z24so4540523pgk.3;
 Fri, 30 Oct 2020 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=muDviu7LdHJg+SSfbczNSfqTYUnVpBS3s+/TDHUMTTw=;
 b=jgIk3kQqh6b5u8IMVHEg6AdHPuuke3JzirHkuNrOCCNKpeMK257DsLUoeFprqFh8Sz
 U+jweagDc8j2KnmzKdNbiv9B/CABxAw8RwQf2qsGFlB8ClYhnXz/4xTlrrK82ReaaXCY
 FyF8uYsKUx+Jsg+bWsN1VQ2OguKv7klzVR3JjwRuXzccW0KIzLmXlexdRAiUVePEvg44
 K27mHToHsf5LnJ4r4314ZbAbDvHCgXXPKKlXuyksDHrUVcrenfOVSAOwGtxPk6Z7MgKb
 3S6OHQKikdKPcJdpZz8QZYr2keQGpGGu2LplB/t9syqbHEhtrSYrpkZLRBg5RjmtI/cC
 djBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=muDviu7LdHJg+SSfbczNSfqTYUnVpBS3s+/TDHUMTTw=;
 b=c0LQi/+FqoGzuQNoAEP1/pMSn+OF2utgCblf/iuGueoGXiauMPZt+pw9NhtOEZCx+D
 VTyY69Hj16QTLGPpL1PfIgy8A+r9A6EK5gBAsypkjG6Hpp1j8gUVKtPHpkVCUb8tEJ7N
 jAQvBEKJpj4szMjoHM4krPCOx6dzj3ulleyvwHMu8CJcTlhAqChVXeihYnDmLiPp89uJ
 srR46Ub9BfDH/sn9xEHZ4+2vdl0e63phKthlxuxPPBqzcBeT1VHAry1l3HFvX/RtSyFx
 y6tMTKIO6gyKt4SIE+PCj43kzCz0OErQSpyCbvJbkwvlgRguC/CXgqP61LUJ9z8mgWSZ
 Jggg==
X-Gm-Message-State: AOAM5329ykLvFaYgYRgeUbJOFnhmWtMuG0Yw2eoko5WS/CWBvjQ+PiEF
 Ge/lS0FZiigxV5T06GmjcKo=
X-Google-Smtp-Source: ABdhPJwwwhxE17Pk9mRvLaqPyLH8sC+zCszqpz892ul4ZfDWukCR0/BGEj8gA3lcqvZDIxcwXH53LQ==
X-Received: by 2002:a62:6044:0:b029:151:1a04:895 with SMTP id
 u65-20020a6260440000b02901511a040895mr8132347pfb.34.1604044643581; 
 Fri, 30 Oct 2020 00:57:23 -0700 (PDT)
Received: from my--box ([103.98.79.70])
 by smtp.gmail.com with ESMTPSA id j5sm2253085pjb.56.2020.10.30.00.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 00:57:23 -0700 (PDT)
Date: Fri, 30 Oct 2020 13:27:16 +0530
From: Deepak R Varma <mh12gx2825@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030075716.GA6976@my--box>
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030071120.GA1493629@kroah.com>
X-Mailman-Approved-At: Fri, 30 Oct 2020 08:35:49 +0000
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
Cc: mh12gx2825@gmail.com, David Airlie <airlied@linux.ie>,
 daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, melissa.srw@gmail.com,
 outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> > function in place of the debugfs_create_file() function will make the
> > file operation struct "reset" aware of the file's lifetime. Additional
> > details here: https://lists.archive.carbon60.com/linux/kernel/2369498
> > 
> > Issue reported by Coccinelle script:
> > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > ---
> > Please Note: This is a Outreachy project task patch.
> > 
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 2d125b8b15ee..f076b1ba7319 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
> >  	return 0;
> >  }
> >  
> > -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> > -			amdgpu_debugfs_ib_preempt, "%llu\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> > +			 amdgpu_debugfs_ib_preempt, "%llu\n");
> 
> Are you sure this is ok?  Do these devices need this additional
> "protection"?  Do they have the problem that these macros were written
> for?
> 
> Same for the other patches you just submitted here, I think you need to
> somehow "prove" that these changes are necessary, checkpatch isn't able
> to determine this all the time.

Hi Greg,
Based on my understanding, the current function debugfs_create_file()
adds an overhead of lifetime managing proxy for such fop structs. This
should be applicable to these set of drivers as well. Hence I think this
change will be useful.

I will wait for comments from other experts for driver specific
consideration / behavior.

Thanks,
drv


> 
> thanks,
> 
> greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
