Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DADC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 00:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A949018A85F;
	Thu, 14 Jul 2022 00:59:05 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956E59EF5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 22:56:29 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 v4-20020a17090abb8400b001ef966652a3so6138564pjr.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ALmsjo20iDq07XHHp8hpMGpJ3WDhp0g9JmzUyOXBoCM=;
 b=JHtzZWeUscDe/NjfuYFmLnY1UjC/BzmUB4H+A2+N3HrOgtyNPI0iG5FaA1VaXxybCp
 mHZVBAhRW9cXndUaawFFIXstvQ6oojNbyZmEvvWPXCd9nxggREDJlDVQk+1aDN6Bq5Vc
 Ej/MBMxV71S3F1TZqh5POlcnQRkVcg6haDsv8est59YY8SzzTsQEZ9rFPxnY6oZMZI7O
 maJ4x/HoxSBZbupP2IkXd0WPHa3PWS4JfuyMJmxl6x0iu+xHWGSQZh4CSHlQZsBQJdlS
 stuDk4v/KIZv1gMLII6nxGLnx8L4iAWUr68vzt/G9+pQfpsQHTZW/UWyEQwZfXthBpVf
 q/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=ALmsjo20iDq07XHHp8hpMGpJ3WDhp0g9JmzUyOXBoCM=;
 b=3ngUvZGoW9n0Vkl2PvnsYCc6jSgQ6Og9lwgtwG1YrtWbLjX6Jva8+se3hodz0Vobrc
 ZabfauZE0lO/Kg6kAqIa1mWejG/Lf9lN3aFHn0Q27JLtQNMeUpQaKanH/jQFNgRGDkJj
 rqbR1d0mmmp/rTxmBkb0IVbUqEIZI9f1JvzWZkUO67LZVBqLxuGLQzeqBBNKSL6nPuUv
 ENfQW1Lk0MH75B95W/GyZpbLcefPsqYw3y+VRmV9zA3rO6Yo5wrpfWmnGLxLLrsLp4eZ
 rnmeQDrvfPMYIE1OgazsLtsJtP9sipfkU4pTxjk4EKHKDrNAA7YtNQ4cAEA14i/Ho8MQ
 QKXw==
X-Gm-Message-State: AJIora9/riVQpZuCPtuF1OcXu1GQDVfVi8CPxBOifPA/tHZb9LNpZq45
 J09HtWQ995Bf5knSn2HW3CQ=
X-Google-Smtp-Source: AGRyM1ssTP6Thy3UB20epNnuCWSDPBTNSUJXlSgGX6sg8IBzM8ZlJakJTn9/vCXGS5PpybokpfWpXA==
X-Received: by 2002:a17:90a:590e:b0:1f0:1dd9:bf6c with SMTP id
 k14-20020a17090a590e00b001f01dd9bf6cmr6148501pji.15.1657752989217; 
 Wed, 13 Jul 2022 15:56:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 y20-20020aa79af4000000b00518764d09cdsm59039pfp.164.2022.07.13.15.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 15:56:28 -0700 (PDT)
Date: Wed, 13 Jul 2022 15:56:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Linux 5.19-rc6
Message-ID: <20220713225627.GC32544@roeck-us.net>
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
> 

Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
gcc 11.2.0 / binutils 2.36.1.

Guenter
