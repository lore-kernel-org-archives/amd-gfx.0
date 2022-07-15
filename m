Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DCBCCA479
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DECD113693;
	Sat, 16 Jul 2022 14:38:13 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667B611A822
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 09:34:32 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-31c89111f23so42227947b3.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ayS4WjR+67psD2vTxMdscs9JVmSfKJeEmETeoMNiN74=;
 b=J6oftZ4YxvHxMDEtCHluswHh++rLfXFf+1FzpUgaz43eq2rFUpNuRIaNourLloq0S4
 be9eBJSeqJBq8yGaa4hSbg3hs4WwMxrMs6AbOpkyMbKbLNABk7Xii69kvbsanz/Qz4sc
 Voq1pm1J8SI2X8V5MbesKFBE/DM1vIiv3cn/jW+Jc95Kgxc9qpaKByLJZDsGacVl8rm6
 KYzycacvwK7kDhlVE3kgF6De7T8KtOSJwKRhzVjZc5zitcb/Tjk5Y9QedjXAchbbasRw
 HbSqzfK759z5tCGudcTatK3/lcXOLQMF1w9Q0+ql+SY6Ji/JpTMJ/7j+rH4SS+jiszkD
 eTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ayS4WjR+67psD2vTxMdscs9JVmSfKJeEmETeoMNiN74=;
 b=R7ZcmDG0rN4Jv8r4pTQH0dYTM07hpXItkWg2FZ7I2sVPW7MTqzt+fUcnrMKqHyii9g
 +KEZmWJKDDylGTjlrJfTX8uNe3F1N07HSKfloIRRkvhlVcMKCedGu3FsdXhMH7NhxBc9
 coWRfrfPXmbSTvgq+c43IuwkPKuRDI4SmgGDzE0DM5K6NwhPglSpX4c0JsHudtbh/bap
 Cpi/Cl2GnihLZOlru69e1LIOBgl8z9pstLWBWmiNQlf9Fjl/uW5nMwwo/SFT7fL1ksMb
 lA53Txy2lLF88gltXZGzdxuxCMsi41CHUkq3+i1Cpd8fHQq/+GayoghLpErQHg4BojR0
 8idg==
X-Gm-Message-State: AJIora+jh9BKMXrN3y14AA7xeTt3u9wsfUF3Vl+yGpo/WjY0u9b6KWhT
 +Pw866Ss2IqGDv0cgenlqjAYA3lgHz6/OnHHIHU=
X-Google-Smtp-Source: AGRyM1smyXtSVObDs+Zf7m/60pxrCys9dxGjP2XzE8Pi+TP3J+a4xmssY21qpiOE/VP9OPJH8jkSMkOLprWTuHC2x7g=
X-Received: by 2002:a0d:db50:0:b0:31d:83a4:cbba with SMTP id
 d77-20020a0ddb50000000b0031d83a4cbbamr15062685ywe.478.1657877671544; Fri, 15
 Jul 2022 02:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <9d18166d534dc30d83f2255d4512619aa6b3b517.camel@russell.cc>
In-Reply-To: <9d18166d534dc30d83f2255d4512619aa6b3b517.camel@russell.cc>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 15 Jul 2022 10:33:55 +0100
Message-ID: <CADVatmPHN6+5G0oMLEebhrCsHiF_kExTbCT2VivKRcs0M2Ng0Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Russell Currey <ruscur@russell.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 15 Jul 2022 13:56:14 +0000
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Russell,

On Fri, Jul 15, 2022 at 12:34 AM Russell Currey <ruscur@russell.cc> wrote:
>
> Hi Linus,
>
> On Wed, 2022-07-13 at 14:32 -0700, Linus Torvalds wrote:
> > On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com>
> > wrote:
> > >
> > > If you want to apply Guenter's patch original patch:
> > > https://patchwork.freedesktop.org/patch/490184/
> > > That's fine with me.
> >
> > Honestly, by this time I feel that it's too little, too late.
> >
> > The ppc people apparently didn't care at all about the fact that this
> > driver didn't compile.
> >
> > At least Michael Ellerman and Daniel Axtens were cc'd on that thread
> > with the proposed fix originally.
> >
> > I don't see any replies from ppc people as to why it happened, even
> > though apparently a bog-standard "make allmodconfig" just doesn't
> > build.
>
> I believe Michael Ellerman has been on holiday for some time, and
> Daniel Axtens no longer works on powerpc (and wasn't the one that
> submitted the patch, it was submitted by Paul Mackerras, who wasn't on
> CC).
>
> The proposed fix didn't get sent to linuxppc-dev either, so it's
> unlikely many ppc people knew about it.
>
> We certainly should have noticed allmodconfig was broken, and should
> have more than just Michael keeping an eye on all his automated builds.

Not sure if I have added the correct people in my another mail, but
thats also ppc allmodconfig with gcc-12.
https://lore.kernel.org/lkml/Ys%2FaDKZNhhsENH9S@debian/



-- 
Regards
Sudip
