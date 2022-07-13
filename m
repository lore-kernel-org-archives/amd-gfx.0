Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B656CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 00:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62332ADCE;
	Thu, 14 Jul 2022 00:59:12 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB679F2AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 23:02:30 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 q5-20020a17090a304500b001efcc885cc4so485485pjl.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3DTffoizvAtkAXY7UkJCahcmR2dJ0DU6CtEuKHCRq9o=;
 b=k7/ZW/Sdqy4R6zQJQ1ct1EO+pB3HgV5W6cnvjNo06ybO0jIfWwv1AQJo2P9gm9dK7r
 rdacX3XXknIHJE/YghqOYhzAFcIHXvoqSW/7Zkwfycpq7njz6tX20Bop0OOIlu+JvkI9
 PFrBIhPVnvsnMFgv71usju89docCmUEJr+JBRp2n2dXoqcJIVf/YSkygQCrILg72xlHx
 11+ODprynW00kWeuM9v/sFjHnvZkuHVnJcwb1cMdYCgdvcK4SGccAgd1BSlly1eQsZV+
 imNH+UyzeroXK1g2nUCfbuxiFTUufJi+TzTt0ek2ucTViceMOe8gAWgIUYMI/qBUsBi8
 uV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=3DTffoizvAtkAXY7UkJCahcmR2dJ0DU6CtEuKHCRq9o=;
 b=VcTenlxF4IgT0kGuTy5e2wogtu4rfobRLsPEOji7+99IQPiDAYfOWFmjBEERXjLzUb
 G1NTf116IvGfaQNkYizYepbuzXvh+tpAPKC1INEFYkKzbcCFAqwy4z0s6bgJfzW8+1r/
 ruar+WZJLJxqjWlg57PckIVQkLzJ9YSmQEPmokKbt9b1lZfRiee0k9tn1+8a2hT+eGVU
 cjeFV3k3p80Zhh4Z5Lwf7aSqLue3zl7cPJ6IqR+EqIVdI/Pm9y5MNeMlexaLNqhS34QG
 vzVoAEahApO4RC/Tf91tmCNbbd1fWKDQOijmxDYimmCzlgoHJakCvUWoBaOVh3ddK3yH
 6OKg==
X-Gm-Message-State: AJIora9L+QUd3QKHPj8XqAEl8YEJIxxlr2tNUcohTvKQsjrUOLJtEe8j
 1Mz4jszY/bQypPvvCKkzTro=
X-Google-Smtp-Source: AGRyM1tAukgwSUDLM2s8DTW1z2VMC3B4PF4X7AJrrp22zHg8TsoXCbl0m15KHsB1DfqgJB4DtXOqoA==
X-Received: by 2002:a17:90a:e58a:b0:1e2:fe75:dd5f with SMTP id
 g10-20020a17090ae58a00b001e2fe75dd5fmr12829460pjz.138.1657753350426; 
 Wed, 13 Jul 2022 16:02:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z22-20020aa79596000000b00525373aac7csm83390pfj.26.2022.07.13.16.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 16:02:29 -0700 (PDT)
Date: Wed, 13 Jul 2022 16:02:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Linux 5.19-rc6
Message-ID: <20220713230227.GD32544@roeck-us.net>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
X-Mailman-Approved-At: Thu, 14 Jul 2022 00:59:04 +0000
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > > >
> > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > >
> > > > That patch looks sane to me, but I guess Guenter would need to check
> > >
> > > I still see the failure in my builds with this patch. But surprisingly
> > > I dont see the build failure (with or without this patch) with gcc-12,
> > > only with gcc-11.
> >
> > Arrghs. "build failure"?
> 
> Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> powerpc64-linux-ld, hard float and soft float.
> But I dont see this problem with gcc-12, only with gcc-11.

I am wondering ... you say "my builds". Is this possibly not
allmodconfig ? It may well be that there are other configurations
which still have a problem after my patch has been applied.

Guenter
