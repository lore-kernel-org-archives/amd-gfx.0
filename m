Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0410C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F988613BC
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F988613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1886E8A6;
	Thu, 13 May 2021 14:32:58 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7626D6E8A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 14:32:57 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id w22so11617475oiw.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nEuGTZXx01IWdu5muG47EcBsb9Sbqb79hygStbbAehs=;
 b=KPnuGGuE+Lpm1YyJQWCY19i3aU56Cw/eDYdeXlMBeIa6WJKgJBkc2P+t2my7QZ6+ey
 gtnaz/9jiqv0XBrb7ang/9nDFY4EYjBK0fZEKNVneCfzUgs36sO4IcoTWL+Rp6CzlxUB
 UJbtAmFjzJuVy34blDU7SqUt5gl5lWiQL1jJwDk946yq9waKTHh2CTA+D1hZIJQHmPX9
 Ym04jzn/EKOSHjTu8QYfB/+p5T6a9Ql64jvu8P1Bms9M7Cnrwan324k0fdpYDWwg61Eh
 D8cDm21gTmH4I9txbSKBaMqRAcVC1q13Xk6PypJkM1S6BarMqS7SPveX1oxNsi3hUUMC
 bAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nEuGTZXx01IWdu5muG47EcBsb9Sbqb79hygStbbAehs=;
 b=I4EecA5fK0ycWxNRCpPIleXcU5i4MEsVYKXtWz4rksLInDNe9c2qWTmHOv7PKphWS5
 OGeVl6UioVLrr/Fofitj3J0y+2prO4nLGmodYpj7Ouf4azgHJN2T/Cqe7frC2KFbELdg
 ExrzlCPTuAD3UQrfCa/dbZxKkl7tjuM2G7R5IeWcs+hQnKY2NyVmK+BgVubu08IgT9eg
 WzE6IapGiA7gZ3kWIEk29s4Lq8kONih8IeI+HQTX8oWAzO/V1iRZrfdmMomnqu5vIq79
 hYCRZMUTtAEOvEDjzwchHzNbtjVeVtOZRNQcTZdTlTvxa15mTM8lKdN5B0/Fp4s9+PKb
 qVRw==
X-Gm-Message-State: AOAM532iYLvasbuUDh05S3TeApRwl6qJKBhP5EUknkL+y7ohqnT42J6u
 5rJyY01VoAqtW0mqQg+TOofircPvK0IFVEbKLGk=
X-Google-Smtp-Source: ABdhPJzU1//9leZjuMF7o12hQw9Wcnj0phspDotWiYdLUlVGeVMkWdmQwYRDa7eXWzHluTRABN7IjfOMTKW35K7Pjxw=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr30053815oig.120.1620916376680; 
 Thu, 13 May 2021 07:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
In-Reply-To: <YJ04D8a6LaVRMuGH@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 May 2021 10:32:45 -0400
Message-ID: <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
To: Borislav Petkov <bp@alien8.de>
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, x86-ml <x86@kernel.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 13, 2021 at 10:30 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 13, 2021 at 10:17:47AM -0400, Alex Deucher wrote:
> > The bad pages are stored in an EEPROM on the board and the next time
> > the driver loads it reads the EEPROM so that it can reserve the bad
> > pages at init time so they don't get used again.
>
> And that works automagically on the next boot? Because that sounds like
> the right thing to do.

Yes, or driver reload, suspend/resume, etc.

>
> So practically, what happens to a GPU in such a case where the VRAM
> starts going bad? It might get exhausted eventually and the driver will
> say something along the lines of:
>
>   "VRAM bad pages: 80%, consider replacing the GPU. It is operating
>   currently with degrated performance."
>
> or so?

Right.  The sys admin can query the bad page count and decide when to
retire the card.

>
> Yap, from a RAS perspective, that makes good sense as you're prolonging
> the life of the component while still remains operational as good as it
> can and the only user interaction you need is she/he replacing it.
>
> Sounds good.

Yes.  That's the idea.

Alex


>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
