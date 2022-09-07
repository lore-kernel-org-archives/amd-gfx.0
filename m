Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD16C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 02:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548AD10E1A9;
	Thu,  8 Sep 2022 02:05:01 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2B110E444
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 23:47:35 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 a5-20020a17090aa50500b002008eeb040eso2054355pjq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Sep 2022 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
 b=ZLBdFbRl5paMgO0B2nkuSUB92aTwmtmqanZFesgw5UFus70dkXrDyjCNdhChN3pJI2
 t8e2tFazYgcQ2/I+HCWkNpNnhTL+sGFQ2IQmiy8gFk422S7/bBjOweZRLDXszByhh4xi
 VaMpTtbZBDMm4nqrs2mAgMKZ9VkS11Y3DZbhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
 b=ARidr9kwYB3cfeQWIR54emN7fUKF2xmgkilx70QfLuXlTmN+nYe1bAj0q2fhJnLPUZ
 EZ9qu8u00237RSsYLPJ1r5uyT5dM2LknEMvWimjYaNbQ/63wciVf5teUEgFmAx0oSq24
 f5B7S3xJg5GdXJxJfl2C86Ev5fdg7hcXS45xGLMffpAJ4YpvbwNCiQuVYOpGul2ESAPE
 K82hqizGhig7t9zHZ1wI2y0AONtLVQ+/i+bdccLplVF594zdBPpSpqyJRKVsioQSh5xT
 F835SLekkIP4WaXehI4jB2mjs+4YwWarDXW1qTbvw9MBG5ZkStiXi8+ROWp39yssHNhR
 QJ1w==
X-Gm-Message-State: ACgBeo2U29yMt/adIRS7e2jxbVrV4R6i/BjzsPpzyvyf3CgrACscF4eG
 IOU4HaPNmIra9Es099cD5NwJ7k9FlnI5Ow==
X-Google-Smtp-Source: AA6agR6FxJPicYC0Cds/ZMsA1yhEHsGrUHcNbVNraLL0wYnkuXuYdtKZvewZkYvWfNoqDsOEyKfeIg==
X-Received: by 2002:a17:903:556:b0:176:84c9:df3 with SMTP id
 jo22-20020a170903055600b0017684c90df3mr6335255plb.98.1662594455557; 
 Wed, 07 Sep 2022 16:47:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 r28-20020aa79edc000000b0053e38ac0ff4sm4585765pfq.115.2022.09.07.16.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 16:47:34 -0700 (PDT)
Date: Wed, 7 Sep 2022 16:47:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v6.0-rc4
Message-ID: <202209071646.A95761A@keescook>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905071915.2312316-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
X-Mailman-Approved-At: Thu, 08 Sep 2022 02:04:57 +0000
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
Cc: linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-sh@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 05, 2022 at 09:46:01AM +0200, Geert Uytterhoeven wrote:
> On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
> >  - build errors: +3/-16
> 
>   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> sh4-gcc11/sh-allyesconfig (-Werror)

Sent a patch for this:
https://lore.kernel.org/linux-hardening/20220907234345.96798-1-keescook@chromium.org/

>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25
> 
> s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

This error appears to have vanished?

> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b90cb1053190353cc30f0fef0ef1f378ccc063c5/ (all 135 configs)

Status	Date/time	Target
OK	Sep 7, 13:54	linus/s390-allyesconfig/s390x-gcc11

-- 
Kees Cook
