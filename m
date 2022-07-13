Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5332C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 00:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A5418A804;
	Thu, 14 Jul 2022 00:59:05 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE129F4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 23:12:16 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 i8-20020a17090a4b8800b001ef8a65bfbdso548720pjh.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 16:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pjvd38sMQ0s3XmHKT3cdWb0EkqYt/fWbMQjoxI+K9uc=;
 b=W6tKMLRIBvc6bvqVQFAHIge/0Ft/PiMVC0pIdzLaYsiLwrxDBGrm4gSwcJ/RAm1Bmx
 RkfHRmutCtraFJYBEeG683xsTgMHIhoJAA3KKsxgC7Lqz+Hiha5QEppoDtCnwND2ntv2
 pga2kH8CNoBqOJxIzsuepklAU7HIZXCM3KAZqPIpFCRl7AdGA+HhsDCxhFPbIfm/oFez
 8u+vZYdSI7OVGBfeFMsaUxcDkrDSPIlW3sBMd1xesuhjhs2L4b+kISqQJvz0Ckrabku7
 /+/uU3JH8tjEEXHS7eyym6tlwI4QKho1Rd7G2kqtppxzUzN/jxTvLMJEjFue6eWdGevn
 6niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=pjvd38sMQ0s3XmHKT3cdWb0EkqYt/fWbMQjoxI+K9uc=;
 b=Pudyl7Q17WTnti6z+lEDvQx7ZUnTDnzcFFTuobs/SJV/sTqYRyQmajHC0uYf8S165I
 Wo+jOZcPAXzn86YThqSUXoRa4u6SGYtVyYwAFw71sC58x6jYhfyKFvRtLZCQsBvn/wi4
 BS2u2RcDtwvXst8QS3oFBpCzQuBg15Ua/7E2P7ILS/hCtCtUhgfPzJuvE42S3ugFjUxR
 yETZafKxKLPGDpDnJNtdPe+4CRmRuZnITNPuEpy2ZPEbbB+ypAGtDm1SRkcb3TsVlJDq
 2vrWNNJSAZpHuLsUzEfbO3FT0Cn3GsWmP88TMIhqi7hnK+KrHjD1TElfhVpLiykXi3KN
 Orzg==
X-Gm-Message-State: AJIora+amTyJ0l4XIIZOh6G+LuSui7xrRZlerARkPpMzJ5Dn+rXuvYkL
 P3xLxPJg6iYGOOf3jOPFnwU=
X-Google-Smtp-Source: AGRyM1u/CjJvF4vni4UIvSLlxLYhxu00JSEBts6bQ8UdOb4GRNyhtdb+lRlBjvTI+kX84b9MLYyFyQ==
X-Received: by 2002:a17:90a:e00c:b0:1ef:81e6:9044 with SMTP id
 u12-20020a17090ae00c00b001ef81e69044mr12664161pjy.169.1657753936028; 
 Wed, 13 Jul 2022 16:12:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 b30-20020aa78ede000000b005289eafbd08sm96382pfr.18.2022.07.13.16.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 16:12:12 -0700 (PDT)
Date: Wed, 13 Jul 2022 16:12:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Linux 5.19-rc6
Message-ID: <20220713231211.GF32544@roeck-us.net>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
 <20220713225627.GC32544@roeck-us.net>
 <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 12:09:24AM +0100, Sudip Mukherjee wrote:
> On Wed, Jul 13, 2022 at 11:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> > > On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > >
> > > > > > >
> > > > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > > > >
> > > > > > That patch looks sane to me, but I guess Guenter would need to check
> > > > >
> > > > > I still see the failure in my builds with this patch. But surprisingly
> > > > > I dont see the build failure (with or without this patch) with gcc-12,
> > > > > only with gcc-11.
> > > >
> > > > Arrghs. "build failure"?
> > >
> > > Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> > > powerpc64-linux-ld, hard float and soft float.
> > > But I dont see this problem with gcc-12, only with gcc-11.
> > >
> >
> > Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
> > gcc 11.2.0 / binutils 2.36.1.
> 
> Its entirely possible that I have messed up, there are references to
> many patches in this thread. :)
> Can you please paste the link of the patch that you say is working for
> you. I will try a clean build with that.
> 

The patch is at:

https://lore.kernel.org/lkml/20220618232737.2036722-1-linux@roeck-us.net/raw

Guenter
