Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF81CC4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B91720709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pY5eGQ0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B91720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91136E1D2;
	Fri, 20 Mar 2020 17:21:23 +0000 (UTC)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3205089650
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:21:29 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id h8so6349480iob.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oHe2EPIf9l8Ynr628oSDUTLbngyd2BsgIH02FtuZ6ME=;
 b=pY5eGQ0/lF+jndw9zrKS7VekA4qVf3vUE9QsU+MX1ZSHW+QeOsLEIrsodZzvZE5FVI
 qZr/zvQSWmvB63e5QAZUCzU+SPbDKGvy9LD0kvYwdKl/OwF+/2WyWb45tkn4SvxEFujA
 SIlTFySLxZQLkyZTiVTZZcNXy4gZDD3KMLfEveD6Dv7Yudb9op5IANyKBETqp7t9NaWr
 ZcG3AGMvRIMdX7sCmzhRRGl5DWzqRpW+BzNsAaBWCU5w2DOdP5pT+xYTgN8jcDZojYT+
 kb6XPCijW80DmZtYpI0gIXPfcRAiCs3XBigJ8HgtSESOV+QWUXEts35ZjuffV5dRC0A8
 l/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oHe2EPIf9l8Ynr628oSDUTLbngyd2BsgIH02FtuZ6ME=;
 b=G8TmqYqPSBRoecEwPBlzGFPUXE1hsz/exmqPuxk/VEx760jVQAC4k6C3E0yDg+y4dE
 pyj/9LSb+w9Hl45r2tWdNDwkUmKLqaRy+kn/p615nslc5azqPz/lM37mKpJxa7/4IkA3
 lPFgoy4LulqBKXRDgxvG+ZZorzfGixU70sCYBYuwT1vte6LDEPpnKN3gg2ydJIkrGbdV
 wcNa2WbnzOHoN0ZkrtdR6vFzqB3Z5kOLiInWSYcWM9Rh412zwZkU6MpaFyNnhQ7uQ5IG
 z8BfCG0ump8i+PzxkiYs/jAd4kQV6KG3+9wFD7kfv0Wyn//EAsaNpIZ8fLYuprVMv9yP
 eqgg==
X-Gm-Message-State: ANhLgQ31k/AJl0GDvrtVQHW3FpXMlr+ifMNf+FMk2FOQEkxemUzyK3Vz
 GGgT6ywB9edEgfry95YIeb07IIrjEzbPAFGLA0c=
X-Google-Smtp-Source: ADFU+vuXDicWC8OWd0xrrKcdYutAD6kkivAvEisP/dT59Fdz/nGwJpT9D/ztXsBO/Jp3NXwA2hO6OW7PLm0zSNY+mFI=
X-Received: by 2002:a5d:8744:: with SMTP id k4mr8006890iol.106.1584717688590; 
 Fri, 20 Mar 2020 08:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAETxV2a+OdyQ_tB0jFHA6n1Ci7kPH6ATBSuHNo4Uq_AuZEFEqg@mail.gmail.com>
 <CADnq5_PryLuSMHW_NuJHq7RKDxNR5-8+qEdK7WfxAg-1YNSE5w@mail.gmail.com>
In-Reply-To: <CADnq5_PryLuSMHW_NuJHq7RKDxNR5-8+qEdK7WfxAg-1YNSE5w@mail.gmail.com>
From: Tristan Vroom <tristan.a.vroom@gmail.com>
Date: Fri, 20 Mar 2020 11:21:18 -0400
Message-ID: <CAETxV2bUaxGJbrx9NjSBG3FUJu0BMJS_wVrVL+vMQ5ng+HsvHw@mail.gmail.com>
Subject: Re: amdgpu kernel oops?
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Fri, 20 Mar 2020 17:21:22 +0000
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
Content-Type: multipart/mixed; boundary="===============1784838465=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1784838465==
Content-Type: multipart/alternative; boundary="000000000000e5d4a105a14ad621"

--000000000000e5d4a105a14ad621
Content-Type: text/plain; charset="UTF-8"

Yes, it worked.

Thanks!

Tristan

On Wed, Mar 18, 2020 at 9:53 AM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Tue, Mar 17, 2020 at 6:24 PM Tristan Vroom <tristan.a.vroom@gmail.com>
> wrote:
> >
> > I don't have a lot of experience reading kernel logs, so I apologize if
> I misread something, but it seems like I'm having some trouble with amdgpu
> in kernel 5.5.9.
> >
> > Here's the gist of the bug.
>
> Does this patch fix the issue?
>
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next&id=6c62ce8073daf27ae3fd03b6929d6cea3887eeb2
>
> Alex
>
> >
> > Thank you for your help.
> >
> > Tristan
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000e5d4a105a14ad621
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, it worked.=C2=A0<br><div><br></div><div>Thanks!</div>=
<div><br></div><div>Tristan</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 18, 2020 at 9:53 AM Alex Deuch=
er &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue=
, Mar 17, 2020 at 6:24 PM Tristan Vroom &lt;<a href=3D"mailto:tristan.a.vro=
om@gmail.com" target=3D"_blank">tristan.a.vroom@gmail.com</a>&gt; wrote:<br=
>
&gt;<br>
&gt; I don&#39;t have a lot of experience reading kernel logs, so I apologi=
ze if I misread something, but it seems like I&#39;m having some trouble wi=
th amdgpu in kernel 5.5.9.<br>
&gt;<br>
&gt; Here&#39;s the gist of the bug.<br>
<br>
Does this patch fix the issue?<br>
<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next&a=
mp;id=3D6c62ce8073daf27ae3fd03b6929d6cea3887eeb2" rel=3D"noreferrer" target=
=3D"_blank">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next&=
amp;id=3D6c62ce8073daf27ae3fd03b6929d6cea3887eeb2</a><br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Thank you for your help.<br>
&gt;<br>
&gt; Tristan<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--000000000000e5d4a105a14ad621--

--===============1784838465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1784838465==--
