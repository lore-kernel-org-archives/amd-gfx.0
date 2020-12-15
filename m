Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347CC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AFE20721
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AFE20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132656E40B;
	Tue, 15 Dec 2020 16:19:01 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE6D6E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 16:19:00 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id d8so19905388otq.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aCkVEQ4DfY7UEiZxhpJyqTIgP64jvnjvzg8WB3+ib4Q=;
 b=fDYN9e7tBQaSyAPOS4Fv588nJRsMBJ9TiTm431rZ2LeTIWgt+LVC7SiKsZe6OfQQ+s
 g6SBv92kZMlmJdD34d0nQZySHoxykZzGUf20FpANe+XRyIVQi6QxAKDhlaDNqSRZEbXk
 aVUioDMG+8hTyrhhMNFRRLlQmmU4jI4AX2LDfAP9Zg7AgUZC6IMRcVYVqdvISDwC4j7Q
 Xjw98qo7liSZKcVvxx7QC+r1D3/5hcNSzoufc5vdGwc3gM5NDGkgss903JSrvmXu4oIO
 U+nEezyydUZ3RDaRpnt4ulTngIiryjyF7UfxVJ684hotdALHK6aQQPvrm3sR980sdwSN
 P7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aCkVEQ4DfY7UEiZxhpJyqTIgP64jvnjvzg8WB3+ib4Q=;
 b=DeJE+S4nqF19ntO9s8A+vub62thDZKvxs+cdXADwfn9M6RuPzbqr8rgdYM8twU0bR2
 rwRKIrmnp9k4Vi2nsQktXDE2nQmo1QBBP2iBtiki/fPYyQbLYevfrRyMFDn7I20q8C94
 jRTd+VyIHBFfZyzuZitCbfkNXCTRj0q75cz/DHi8d9FgPSDbfIH4QER8D9IdBvOFrsME
 t2Hy2aTJbpBo/CBtqpSH8+C8aecrcG5dWggLKGqbEAuI9S3D52mHSCArVZfC5R7eGrvj
 CL42r9Ju7AFlry/OJSi5ZBv5vTiuY93k89iXU7J4ccEp8NJHKgjDU4HnsORZWrknmPN3
 Fhwg==
X-Gm-Message-State: AOAM533nddUxMSHLy8LHNFQktZTYkYi9oR3UWcexGP9rnn2kaM4wXh3S
 AerWeu7tnonECST2UWJ/+xocuxa2nHkIlYeHUCawD7LU
X-Google-Smtp-Source: ABdhPJz0OCQxpufG1tSCB+YfaAwzuotWyePhGP+Neea8fyEu5pwz26NwbvPMEuMpzUrTScWLakssk8wPCu3bud2UyCM=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr24460356ote.132.1608049139341; 
 Tue, 15 Dec 2020 08:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic>
 <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
In-Reply-To: <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Dec 2020 11:18:48 -0500
Message-ID: <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Chiawen Huang <chiawen.huang@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Borislav Petkov <bp@alien8.de>,
 Alex Deucher <alexander.deucher@amd.com>, Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 15, 2020 at 11:07 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> Hi,
>
> Could you try on Alex's repo?
>
>  git://people.freedesktop.org/~agd5f/linux
>  branch: amd-staging-drm-next
>
> My patch should apply without any issue on top of this branch.

Can you help me identify what patches we need to backport to 5.10?
Depending on the patches, it might be easier to just revert this for
5.10 and apply the proper fix for 5.11.

Alex


>
> Thanks
>
> On 12/15, Borislav Petkov wrote:
> > On Tue, Dec 15, 2020 at 10:47:03AM -0500, Rodrigo Siqueira wrote:
> > > Hi Boris,
> > >
> > > Could you check if your branch has this commit:
> > >
> > >  drm/amd/display: Fix module load hangs when connected to an eDP
> > >
> > > If so, could you try this patch:
> > >
> > >  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F84965%2F&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7C1f7ff595746543f597a708d8a111fbdd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436445910587407%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PESE3uBZeNjdWtIFRP6l07AyfhASpXCfaZa03l%2FFi6s%3D&amp;reserved=0
> >
> > So I did a bisection between
> >
> > git bisect start
> > # bad: [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
> > git bisect bad 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> > # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> >
> > and the patch in $Subject came in in 5.10-rc1.
> >
> > I can test any tree you want me to so just tell me on which tree to
> > apply this patch and I'll run it.
> >
> > In any case, it doesn't apply on v5.10 though:
> >
> > $ test-apply.sh /tmp/rodrigo.siqueira
> > checking file drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > Hunk #1 FAILED at 120
> >
> > You can push a tree of yours somewhere which I can try directly,
> > alternatively.
> >
> > Lemme know.
> >
> > Thx.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7C1f7ff595746543f597a708d8a111fbdd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436445910587407%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kiGm0%2B2d2nXiEwUs0omOYv3ZtyfwTtoD9OhrT59Dv5c%3D&amp;reserved=0
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
