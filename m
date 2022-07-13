Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DDCC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 21:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAAB12AF98;
	Wed, 13 Jul 2022 21:38:08 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37269BD95
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 21:36:50 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-31bf3656517so126095497b3.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rWB63dsRjVMLiI6k8qFmu5fPSbSPX3yFx1MpCLPsplc=;
 b=EDEl2+JJ8ZJz2gfKTa41oqiDbCoX/M7v9hXiGo3TCOOvsltDHVulVEezz5iZd/A9Bw
 /NaGm/I1nQ8ZJplBN4uln1tLXdrR4t8qPNqE84Ot35exgKkWFduhO5P0Xk27Yq4ovqAv
 NR+3DSKaAz7i5/3ypkQXy5VxMO7As4RiwqvUpV8uUNeDm4hC/dzb9IGPKOjHBf0o2tZ9
 Ml8M3PsccDBSLWBwhcOdRjNt11K/50bar3VEepDSvqGp6V61s13tNKxGeWdEzQ8iQxDP
 7tC18xP0QwxYPZkQa9Tk4PEclTb2OxUzf7uvdi4WuW54MLtX44HVjVysGsd71HhziK//
 Haeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rWB63dsRjVMLiI6k8qFmu5fPSbSPX3yFx1MpCLPsplc=;
 b=WcFZ60q2JyWOlTLzvezo2ciGtwqT77O162VqlNrvbzjKaxNKFupC9BRUtpyAfjPvOQ
 842TqVg/C1gwPF9YzZFTC0GbgQI9maAFWBjwr23qaPFRM1tivPK+Gz55nnO5vir5GTpu
 ZgIE8F5SycKw2XFc9iqybinzYW6ULsHloG2t7L8lpjd+U/2bCePy1jHhw5BrofbLTgiG
 /Hpqv/RSI8NcBdoKs3MiAdWQvHHqbgmwSZxDyZ5vC9v5i4Z5CD2Oy7//XCF/09wq7pUE
 MgCBOzcsLVwrq4T+denYWWapnblETz1RCpPEydDI+CvmRh7fc4ZXx4QEaG9vTmO/iOka
 wOiQ==
X-Gm-Message-State: AJIora9OmXBPu8PI30wV8zEnqVcBfwMTQWGS8HFiwr4HSDOe1YbOkW7H
 jhcJgqYOH4wia+mpS58yf2l7EjVtMSpOobgP4Mw=
X-Google-Smtp-Source: AGRyM1sgQ9PXyOubPn9V8k34Wsc2PRu6NEBc1R5DcWdoaa9DCTE4fhIgYxZSbwv45hqcdg+gdjjp10PN5hXe0VPo4FM=
X-Received: by 2002:a0d:db50:0:b0:31d:83a4:cbba with SMTP id
 d77-20020a0ddb50000000b0031d83a4cbbamr6650997ywe.478.1657748209838; Wed, 13
 Jul 2022 14:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
In-Reply-To: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 13 Jul 2022 22:36:13 +0100
Message-ID: <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 21:38:07 +0000
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
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 9:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > There may be a patch that solves that, but it's never been submitted to
> > my patch system:
> >
> > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
>
> That patch looks sane to me, but I guess Guenter would need to check

I still see the failure in my builds with this patch. But surprisingly
I dont see the build failure (with or without this patch) with gcc-12,
only with gcc-11.


-- 
Regards
Sudip
