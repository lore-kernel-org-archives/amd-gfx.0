Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1AFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 00:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E6318B6B2;
	Thu, 14 Jul 2022 00:59:10 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DE09F72F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 23:44:31 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 o3-20020a17090a744300b001ef8f7f3dddso607145pjk.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nEpopK4UqdCsWpP9r3ONplAh1+GQjBsglG0fcXtt8QQ=;
 b=PYOvbkCD2kkCKw/qs4dayUervf53wtMirvtAQj6YBM0hYSlGEev7kM9cK9iUpVq1Ku
 TGLwYqWeq7xoIzWX2qelfvw/UUNbSgoM6s2vYKpXmwHmNyycgo42XQdbV40MZ+2tyVPR
 id7FYmjUlW0a7awFHwSkG7yLKk6PkqcXYbIpQHpJ8THG/6VTuxYb9zqrkA2cXhhamUCq
 sJC5VakmtUdmw98trEs4wXKSq0IPoSIx4POpGEKJjceoMwUkBzz+V+MV7cNxjBTwLJb8
 FJGPJPr73kPPhCWXAehrJXTw76HWeiMgKDPsW2f36RHWLyRdMqgL2p3QT6MRgA99QY7U
 /ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=nEpopK4UqdCsWpP9r3ONplAh1+GQjBsglG0fcXtt8QQ=;
 b=f2wBK6rw4LkUSojOSshdTmPR/OmGFQezMGZeqkjYLs/rRcmP5UcwqO7Jf2RLC9ifGJ
 a0cBxTzb5H6jVf1ahrwBq2iP2otKGVfoUdWyTR42oCQ52oSbYdqjmcm6x1qP1YeU2g83
 NdiJO/HqHGli5SYmh4tm+aH4Miai14kx3JneGfcO9kXK/7lHUvMRQ6E1I8vHWBNiV7/k
 E4yEtR70OTrtCzVW2hob92VpHGdB/aa+5rxqobMuWCosGu1kHVYxUd4jBsK/zu0yaMRV
 DMszlH8pHu4/i6qL8AkFDFkBTC6zqDsgDQh0Qhty4m5dWKcfJnySZFQyAOIJdS4ZKVgk
 SVOw==
X-Gm-Message-State: AJIora94zpumgd7oBmZXnMuID50cB+w1JDEMuSMCsntKIorNI6MScP4c
 yL2QwTOhgla50+g2B+yLFQsNyKkqJfnUkg==
X-Google-Smtp-Source: AGRyM1tIVeKezL6A/OiJfHg4JYqkq2JBMtxq2DNyYJX41gD2nIJZLYUgmYXK0jU93EFrZuaXlNNNwQ==
X-Received: by 2002:a17:902:6b8c:b0:168:fee5:884 with SMTP id
 p12-20020a1709026b8c00b00168fee50884mr5558467plk.105.1657755870965; 
 Wed, 13 Jul 2022 16:44:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a170902f35100b0016bf803341asm9323467ple.146.2022.07.13.16.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 16:44:28 -0700 (PDT)
Date: Wed, 13 Jul 2022 16:44:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Linux 5.19-rc6
Message-ID: <20220713234426.GA609291@roeck-us.net>
References: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
 <20220713225627.GC32544@roeck-us.net>
 <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
 <20220713231211.GF32544@roeck-us.net>
 <CADVatmOAnoiZ1WE7iDBYCXVSiMo8RvC_P6mBhR_F75asfDWr4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmOAnoiZ1WE7iDBYCXVSiMo8RvC_P6mBhR_F75asfDWr4w@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 12:26:27AM +0100, Sudip Mukherjee wrote:
> On Thu, Jul 14, 2022 at 12:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Jul 14, 2022 at 12:09:24AM +0100, Sudip Mukherjee wrote:
> > > On Wed, Jul 13, 2022 at 11:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> > > > > On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> > > > > <torvalds@linux-foundation.org> wrote:
> > > > > >
> > > > > > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > > > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > > > >
> > > > > > > > >
> > > > > > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > > > > > >
> > > > > > > > That patch looks sane to me, but I guess Guenter would need to check
> > > > > > >
> > > > > > > I still see the failure in my builds with this patch. But surprisingly
> > > > > > > I dont see the build failure (with or without this patch) with gcc-12,
> > > > > > > only with gcc-11.
> > > > > >
> > > > > > Arrghs. "build failure"?
> > > > >
> > > > > Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> > > > > powerpc64-linux-ld, hard float and soft float.
> > > > > But I dont see this problem with gcc-12, only with gcc-11.
> > > > >
> > > >
> > > > Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
> > > > gcc 11.2.0 / binutils 2.36.1.
> > >
> > > Its entirely possible that I have messed up, there are references to
> > > many patches in this thread. :)
> > > Can you please paste the link of the patch that you say is working for
> > > you. I will try a clean build with that.
> > >
> >
> > The patch is at:
> >
> > https://lore.kernel.org/lkml/20220618232737.2036722-1-linux@roeck-us.net/raw
> 
> Thanks, that works. tested with gcc-11.3.1, and binutils 2.38 on top
> of latest mainline (4a57a8400075bc5287c5c877702c68aeae2a033d)
> 
> When I said I still had the problem, I tested with
> https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/

Makes sense. That was the patch fixing the runtime problem.

Guenter
