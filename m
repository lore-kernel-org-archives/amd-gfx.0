Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A66C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 21:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6459BF04;
	Wed, 13 Jul 2022 21:51:32 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFDB9BEDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 21:50:43 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-31c8a1e9e33so126654307b3.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X2pu4moFR6OZfbNnmmlWYDiflwcBu9QRadHD8oHB0DA=;
 b=Wl/S4XdDh6uSlJZCE6qwqiRw7llHQunIS/4w+LANKgOkbCXNk5VswazBrrHx/8VCEs
 EHUTnoMTA7WOv9rEsprogenqBEcHP83ulXJP/mwKgT66InOiiZ3tpsbVG8998rw0ZUB+
 JA2FTd3HgIGTfMy8VKne1C7AJ9qbFB+bG79+sOEvFkixQwYQD5PoiKisfjJKfwOJjCsz
 ZPpCFwsXpZdIfZek2Yq91hXx8HBCc4HMSfLKs505z8xYEew8D2PEkhDubK2IRkiNODSu
 4kftXkS8XGm2WcrJ3veaREUcsQI+2Qm4zaeBTSFSbVXvfZ8N3CM28kNKAqdBmIsBfZ97
 QKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X2pu4moFR6OZfbNnmmlWYDiflwcBu9QRadHD8oHB0DA=;
 b=AaKmZwKfbSjUAnsNIwqADXLTLUo2xtVu8IvPWpBcgGeaQtJ0LhbuW/77fdLPtcNQLh
 ZMSzXiK3/Q5N/T2lFb3r2zHcm62B6KKyHT9yKMWWJ1WeJo+4NH7XXfxBAdO7D785LI1G
 BPD+OgSP1LOXMNnY4A0g6fcfirNJQEkYDVXTtyhsS8mArMymNMHK2tCTcigJyfGKGw1e
 z4S8qhxcLkWwN/FwwjvyuONfWxWWURVf0RX8eP2JDO47wALKdYIx/MgnL3pPtcQNSgLK
 Mqli95YGksKWDszHFuamjl1spbPRUH1WG7r2FuWGM+cHfyV68A1kBjggYlRGvk6BaEON
 loSg==
X-Gm-Message-State: AJIora88EMTf8DcnPYClUZz0d6xOUSyuBhIrX3yJu+DeGJl28bCbPKbm
 H59eYejSvnIMOYELWKJmLpPBzM98cYbpjOMTBE4=
X-Google-Smtp-Source: AGRyM1s5vhr8Crl//JQCBry1DQg8dljPCkZtXw8TlEZ3/E1XNcAEAeOVweBVFcYiYz9kJcDuAJQhHhXTlVM7/K40IOg=
X-Received: by 2002:a0d:f602:0:b0:31d:a033:3438 with SMTP id
 g2-20020a0df602000000b0031da0333438mr6551634ywf.39.1657749043210; Wed, 13 Jul
 2022 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
In-Reply-To: <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 13 Jul 2022 22:50:06 +0100
Message-ID: <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 21:51:31 +0000
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

On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > > >
> > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > >
> > > That patch looks sane to me, but I guess Guenter would need to check
> >
> > I still see the failure in my builds with this patch. But surprisingly
> > I dont see the build failure (with or without this patch) with gcc-12,
> > only with gcc-11.
>
> Arrghs. "build failure"?

Uhh.. no, sorry.. I meant the same problem which Guenter reported with
powerpc64-linux-ld, hard float and soft float.
But I dont see this problem with gcc-12, only with gcc-11.


-- 
Regards
Sudip
