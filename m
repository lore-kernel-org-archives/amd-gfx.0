Return-Path: <SRS0=lmwh=5G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C47C4332B
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 10:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428CC2072C
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 10:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2RrNjZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428CC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD176E2E2;
	Sat, 21 Mar 2020 10:08:24 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00816E2E2
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2020 10:08:23 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id z72so4396063pgz.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2020 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Zd50zph/DVCHGwO7MQoDZUqDKLF5Me8P8SPvJd1kNlM=;
 b=l2RrNjZj1NsQEqvtV/MnqAYDknUPTUc5jtseIAdOYGrbGVu//ychOs32h2S97PVOTy
 1v7i0wqMsYI+Ypi+zkCPtN9cgFM3KXLfGFnjA/JSsbVRvYa2aVZ3spzr1qJFfzUa/NKK
 Ug/P0meFmOiN63TxBS2PmJ1ZcphA27EbMUCXlHu3y5TsvU1rgEiTwBXgOPmOHgFTRNKW
 fICA6hqXgQmBpZZgR3feJ7i8brUJkWPUElhQecCcsnntG0hJN7pVAp6HM8wAl4IGEoKL
 jUIdwf7OwK7W+aauz/Wvo6zeVM9QOkhCLP5bVTvCrh6zDVs+Ddvijs+RWQAoXFpPyCmI
 mvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Zd50zph/DVCHGwO7MQoDZUqDKLF5Me8P8SPvJd1kNlM=;
 b=GTJV+YHJqQErlb+zSq9LTYtkuf3s1X/RZxSsnpJgddIFaAPd1ZSwJnXouHJ+hWxdcO
 KWGcfUCy5ru+ChtOuSN2z8WZodYyFNCHwSNu89ZOnmBy7bSVYSRhoSUb1r48iRSs/yG5
 MIPdfkjjpfT9NPFTMbvLAlADYKfG5kKf3FsZM6ZfbcsDwHLQDIXSeWz93wo4fWy1zpth
 G9iIP87Vh6o+CC032eW+G8KB41EOSDXt94gqxCx9IAcC+1/BYP+9hoGfEhsc0LDzSiqk
 5rwFy0Z9IhNnMZwJIV1EHYnsW3LknQVJ9cP6VUWlcyrZYmGddHMoyOXvFI7bQ9IWkwwh
 KpNA==
X-Gm-Message-State: ANhLgQ0891sSupU60aZtrjRkM6vHtNhDVW7X5n7byBN0CvQJZ/PSivUz
 Tgqcr7ERkntSG2KDuKBF+BM3C8jmyc3R5l/w4XlsEAv8
X-Google-Smtp-Source: ADFU+vs2T7Ac7aY8d908/fbiGqrKmF97hdIik9mdQY+yL5K7BKYWXCF2UXOsm8JSzOOaNuYgzYJJqd2Ola+JQECCSXs=
X-Received: by 2002:a63:4555:: with SMTP id u21mr12865121pgk.66.1584785303386; 
 Sat, 21 Mar 2020 03:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFvQSYQqneGVka+uyZjs1RsFNFkXZqYmz9pTP6=8uhUP0ddHAQ@mail.gmail.com>
 <DM6PR12MB30977EA10F8FDF64778C18CAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>
 <DM6PR12MB309791830A01031827FE2DCAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>
 <CAFvQSYTm0ivSvTrFGUQ3S81+Q_SvbhZxaAQScOX3-kySWJPYUg@mail.gmail.com>
 <DM6PR12MB3097728439238BA34015B087E8FE0@DM6PR12MB3097.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3097728439238BA34015B087E8FE0@DM6PR12MB3097.namprd12.prod.outlook.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Sat, 21 Mar 2020 11:08:12 +0100
Message-ID: <CAFvQSYQbwnpGL13-pwY959yAiPXaE85teROVhiFoCOs+K86S8Q@mail.gmail.com>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
To: "Bridgman, John" <John.Bridgman@amd.com>, amd-gfx@lists.freedesktop.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi John,

> >I know RX570 (polaris) should stay at PCI3 as far as I know.
>
> Yep... thought I remembered you mentioning having a 5700XT though... is that in a different system ?

I am using a RX570, the guy from reddit changed from R600 to an 5700XT
and it seems it did solve his reboot problems.

As the system is rock solid with windows-10 and others seem to
experience similar behaviour I've decided to file a bug at the
kernel's bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=206903

Thanks for your suggestions & best regards, Clemens


>
> ________________________________
> From: Clemens Eisserer <linuxhippy@gmail.com>
> Sent: March 9, 2020 2:30 AM
> To: Bridgman, John <John.Bridgman@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE) with Ryzen 3700x?
>
> Hi John,
>
> Thanks a lot for taking the time to look at this, even if it doesn't
> seem to be GPU related at first.
>
> > OK, that's a bit strange... I found mce log and MCE-Ryzen-Decoder as options for decoding.
> Sorry for omitting that information - indeed I was using
> MCE-Ryzen-Decoder, thanks for pointing to mcelog.
> The mce log output definitivly makes more sense, I'll try to
> experiment a bit with RAM.
>
> Thanks also for the link to the forum, seems of all the affected users,
> no one reported success in that thread.
>
> > For something as simple as the GPU bus interface not responding to an access
> > by the CPU I think you would get a different error (bus error) but not 100% sure about that.
> >
> > My first thought would be to see if your mobo BIOS has an option to force PCIE
> > gen3 instead of 4 and see if that makes a difference. There are some amdgpu module parms
> > related to PCIE as well but I'm not sure which ones to recommend.
>
> I'll give it a try and have a look at the pcie options - but as far as
> I know RX570 (polaris) should stay at PCI3 as far as I know.
> Disabling IOMMU didn't help as far as I recall.
>
> Thanks & best regards, Clemens
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
