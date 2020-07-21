Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B96C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B412077D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmlFFLRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B412077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF086E34D;
	Tue, 21 Jul 2020 16:17:41 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A586E34D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:17:39 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a14so6930258wra.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=co2+LX72SSExlNqlQqvZJcXU04U3TVySaBwB2NwlQ+s=;
 b=nmlFFLRKK+FCiVisTUGBShCTdeoISzeU1OGPjDzv2zKTsIaHE3pGtjQ3WDHSHV5wH3
 /r0AMtMm1MHHAebZwtC2bM3yHG8nPtabYKm7i8f1izvGmaIcfyPQVwK2zQ/XJ/RdQpkJ
 WKUGGygH2A39v11T6tbS+7cjb8/n+2JyJhwCcwgJrAncuA8W58SzepTH6Cxql9aQjf04
 IEvpPbcWpt01HYnTIBFdQWxs0laozXVYEXuHCZchR6WEJU+sHSr/SMBY29tTvD2m2oCS
 ZDj5D1o91O0pj9pQyusPmqvrBoU4OrT/JDlb/FsIpyr42jFsCP9aSm2x728aqHyr+Hb2
 6gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=co2+LX72SSExlNqlQqvZJcXU04U3TVySaBwB2NwlQ+s=;
 b=jetHR+ug7GTRZ/fCML0HmS6wwJGIz2anHe2SFQqdP8XgIxs1nc33aajd4NLG2NRnoh
 z6HhCBWRmZ6dRXrJ3Cf4toe1jqj/KjI+CRnK6O8Gu+mOIomE/IcaYsHZ77E2TMJv2d/T
 4DFqaDWdCyfhCVN/U9Tcpyr4ggmri6GlJCKDB827L40jgKhg1LqruLJhaQDmZtQmYCYX
 as9ZxwVGCjp8Po975Tq+WQ5qWnPRdRwjR5+m4ucvpG22mCWLwl8bD20jDoZ07fLSYhQi
 VaTB4r2tkZW81zENxKTJdASpn7MlxlL8JD9Ku+CNIann8cuHX08SV94PZz5mn7wSva1Q
 s1sA==
X-Gm-Message-State: AOAM531CMBpRNPvywteRV/X+rEHlf5CILISHTgvjIWi12NFdO3DMJeB9
 zfWakSPdywsuOqjmYnfVpBbYzgCakDjZKPjJ7rY=
X-Google-Smtp-Source: ABdhPJzg0JH7FBcHd0Ttww4VItZkD69i7nk6csuhJIgZ/AmFa7V+CidRd574tAfybhssQzUBc48SVwN8P00AyMWghos=
X-Received: by 2002:a5d:5549:: with SMTP id g9mr29068937wrw.419.1595348258682; 
 Tue, 21 Jul 2020 09:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
In-Reply-To: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jul 2020 12:17:27 -0400
Message-ID: <CADnq5_PcEo7sXFpEoKLj5q4J52ehtGjMvQzUFPHLcHObR3Q94A@mail.gmail.com>
Subject: Re: Amdgpu kernel oops and freezing graphics
To: harv@gmx.de
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 20, 2020 at 4:22 AM Harvey <harv@gmx.de> wrote:
>
> Hello,
>
> this is my first post to this list so please be patient with me ;)
>
> The facts:
>
> it is now one week that I own a new laptop, a MSI Bravo 17 A4DDR/MS-17FK
> with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M. I installed
> my beloved Archlinux but I can't start any graphics withpout kernel oops
> on it beside the normal console, even calling 'lspci' on the console is
> provoking errors.
>
> I am using linux kernel 5.7.9 and linux-firmware 20200619.e96c121
>
> (FWIW: I even tried with a self-cmpiled kernel 5.8-rc5 and
> linux-firmware directly from the git repository - no changes)
>
> The following is only part of the information I can provide but I didn't
> want to make this mail bigger than it already is.

Does appending amdgpu.runpm=0 on the kernel command line in grub help?

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
