Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA7C4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516FF611C3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 516FF611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A070589231;
	Fri,  6 Aug 2021 16:27:01 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8771A6E0C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:26:58 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id o20so12777587oiw.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Aug 2021 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3YjIabaOh+LHbYOUviUxA3Dxl0fseoSWaqEQTRS2PA0=;
 b=HXFXSiuOTANtXmpmEBaDnz7iitDfgpmgaRK9MqTJYmTI6f2nu0dEgX2ga6W+ErHB6H
 843UIIP3LUBLP3syvR4scNzI4h5HUP48LxMg92jU9qFF/7DUysyKh7w2w9MugbVrt6W7
 PbILUs5ZcXHvtrUlYwxg+jn7KFbgr/sxb/U7bHRigFiiVnaRtLkV8bqVn1ZIpoI5mEhq
 sDh4AWsNVQPPQmJ9Xh8CHy8p2/4WOmkkiGBL+KvIReoZYwQrcY1iclUZUxPMX2U4ON9i
 B7hNA1RxvGL9mGtBnkZ6CVhIalO8kAYioVqM/Mlh6otyDS9IsNASj2S9lLAOS8A+iKn7
 Ec1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3YjIabaOh+LHbYOUviUxA3Dxl0fseoSWaqEQTRS2PA0=;
 b=UH0I67NeppmJP108ZsQez06uKUuGBBOo70RYOLeGQfatRvNEfSWOlKzFGZDYcP8uPO
 hf0IyeE8RTp5BTYuwzI5ooW/FB95Lg2z9K92P9wZVHO/Bos0pIQCrQiEqkgV0CmOo3Z3
 6nuQ0QutWfxdmcQuQv25TmLzD32CfV7UjWbz9bdXkXuyKx4iUctKoKaG1zYiXtSiA0+9
 KTk4OtCzZYLB8ijSai1IS+LbJbbO6g07cc45g3KW7YpjwiwV7M5xBF/S6xMib1FMWA2e
 IyX5wkzPC6pQNlTTiLFGjGpmyaNKB5P0wYAVt5dKmnc70IkE52PJFI3DtQb6yM1b62EE
 QUZw==
X-Gm-Message-State: AOAM530A35z6utahxpg1fvO/PzJr6o8ave3MamqT5ZuHWiU9CyCCV+Sp
 aZWRjWAmu1W4jIgajy4L8M9imeZ4l3m7GfJTA18=
X-Google-Smtp-Source: ABdhPJxTEJH3TMv6W0nTVecCTG/E9hfgsiPS2ewg46VbxkXvwtVKbiv6Cx0+Il1Mlgl60tS4aMV2IFLu2PDY6zuEqJk=
X-Received: by 2002:aca:1313:: with SMTP id e19mr9186152oii.5.1628267217878;
 Fri, 06 Aug 2021 09:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <36ccfc64de628c060a736b8e05ae076246b686fc.camel@hadess.net>
 <CADnq5_NdfbJ9RAqMMxLYfvC70QPyuTQ8ggRZM2uYZAOuQx_vSQ@mail.gmail.com>
 <3524e3fb29d40003e59645a9ee5364ac62d34879.camel@hadess.net>
 <CADnq5_ORyFoNHk0Zng_6Ei6NEm557bpdtR6o5zE=3fpBp3qddw@mail.gmail.com>
 <38ddd7e5b2056d6efbf0267eb74ace4245d09ea8.camel@hadess.net>
 <CADnq5_MQq3BYiJTb6YMVZ3pPzfgLrQYXFncohYdThGrNmJXuKw@mail.gmail.com>
 <c49e9e5350e98a78d99cb99f244ba6805847aba2.camel@hadess.net>
In-Reply-To: <c49e9e5350e98a78d99cb99f244ba6805847aba2.camel@hadess.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Aug 2021 12:26:47 -0400
Message-ID: <CADnq5_MGBdHgnxs0PXggrWHXM-oid7Gg74f8uOvopgMPRBNz1Q@mail.gmail.com>
Subject: Re: Power-saving/performance toggles for amdgpu
To: Bastien Nocera <hadess@hadess.net>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 6, 2021 at 12:20 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2021-08-06 at 11:45 -0400, Alex Deucher wrote:
> > You could set one of the profiles which sets more or less aggressive
> > clocking, but you still get the advantages of the SMU being able to
> > dynamically adjust the clocks.  If you manually force the clock to low
> > or high, you end up forcing all clocks, even if a particular engine is
> > not in use.  E.g., if you are not using video decode, there is no need
> > to force the decoder clocks high as well.  Also, if the userspace tool
> > dies for some reason, that will leave the clocks in the forced state.
>
> This looks like the best option for that use case. I've documented it
> here:
> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/3#note_1021578
>
> Thanks very much for your help!

No problem.

Alex
