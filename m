Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2DAC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 06:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D062072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 06:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCSn1Sag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D062072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CE96E417;
	Mon, 17 Aug 2020 06:24:24 +0000 (UTC)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1674B6E051;
 Mon, 17 Aug 2020 06:24:24 +0000 (UTC)
Received: by mail-pl1-x644.google.com with SMTP id t10so6988986plz.10;
 Sun, 16 Aug 2020 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yhMUZwHvzHAv9CIz2t0G10KDW+iimqS/zlmv/v2XyYE=;
 b=iCSn1SagUarZr4wq1Jf8h92lVujYcuAEGfxmUAdMq1SNM26URdX30wH/7plEjmS0UQ
 68e3lhWJmu2Gd+Ib5PdT5jwttqZ7e1gc46NCTli1xBzJWHN8LesXBfKlWoUoKAX5sxt1
 HY+Eel1j240ZOBQGnjR4nZJ6uiKWYTVz4Dp77C0PBzCZaIwxgxniwchZaLK1qe1J27ot
 HkQzcdoMUQCN6k72sCuoqd+GvJFSJZwDpHkO5lEjzVPhqLrwRLR8h4030YEHDplSCjyO
 l+r0eIcSJMJHouId6opU9CEwkVNMMq5Cn8zVgrAVjnW3JUGALbm1svwn+vsXX7El/Fhj
 vAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yhMUZwHvzHAv9CIz2t0G10KDW+iimqS/zlmv/v2XyYE=;
 b=dQ4dfALhRj+0M5M02DfjkgelAOolHWt1AndTK2nfsZjB1D+7JzVKt1azyWT1e3tMOQ
 DNLfrQofmQ1/lGu12axMwyI5PxtY8KSOpQqx75c1oqaTIlH87Egb8Vc37cFahISFqVtQ
 4wlK9afoaPkakSEGztd8RlJQMJDxweyIXSzSukcjMSHOqWylGt/9jhKc1JVz6Ehh/0h7
 /zWlt1KtMxm5kIyZ1/OOPc8vVsGPYULxx1WqUs0CihHS6UqulrtCoiajBhv0i0/mXNjr
 fmh8lu12n3oIAvGZEfdUCB/8KyiYnXmdAOl+xVgYLrLvWHMDoP0viyuXTlQY4WMbq22K
 eQgg==
X-Gm-Message-State: AOAM531Uk0uNftKJvYNOpti1XaesXV6xvDRjVUfp1skAiGo3e8U+3Cpu
 v3fOSwufSWXJWoXdO1UyQQhzx8imdQ3hH1cuocrvIVSTuPQ=
X-Google-Smtp-Source: ABdhPJx52BDbB8cseHb0WtAYM9pgtTY3aQUO+QL4TNlXK6yV/acmqwyTnMRxa1Xmzw8WXzirV+wHFHf5NkTgD8DWSFc=
X-Received: by 2002:a17:90b:391:: with SMTP id
 ga17mr11253204pjb.75.1597645463565; 
 Sun, 16 Aug 2020 23:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200730203642.17553-1-nicholas.kazlauskas@amd.com>
 <20200730203642.17553-4-nicholas.kazlauskas@amd.com>
 <20200807083041.GL6419@phenom.ffwll.local>
 <4117cdee-2f5d-a8bd-1e80-1c550c9d9af3@amd.com>
 <20200810122553.GI2352366@phenom.ffwll.local>
 <9fc38b52-6b46-fec8-e511-3fc3e9d2c151@gmail.com>
 <CAAxE2A5BXVJ9xQ=C6F=Df1MCGUKTjV7yR=6x5hu6vfARp1SD7Q@mail.gmail.com>
 <20200812135447.GF2352366@phenom.ffwll.local>
In-Reply-To: <20200812135447.GF2352366@phenom.ffwll.local>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 17 Aug 2020 02:23:47 -0400
Message-ID: <CAAxE2A7TC14u9_kkJnpG7-_rLG-q_vkyjhh6=pCDmL0NcfBWaQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Avoid using unvalidated tiling_flags
 and tmz_surface in prepare_planes
To: Daniel Vetter <daniel@ffwll.ch>
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0664673270=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0664673270==
Content-Type: multipart/alternative; boundary="00000000000055399205ad0cd24d"

--00000000000055399205ad0cd24d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 9:54 AM Daniel Vetter <daniel@ffwll.ch> wrote:

> On Tue, Aug 11, 2020 at 09:42:11AM -0400, Marek Ol=C5=A1=C3=A1k wrote:
> > There are a few cases when the flags can change, for example DCC can be
> > disabled due to a hw limitation in the 3d engine. Modifiers give the
> > misleading impression that they help with that, but they don't. They
> don't
> > really help with anything.
>
> But if that happens, how do you tell the other side that it needs to
> sample new flags? Does that just happen all the time?
>
> Also do the DDC state changes happen for shared buffers too?
>

I thought we were only talking about shared buffers.

If the other side is only a consumer and the producer must disable DCC, the
producer decompresses DCC and then disables it and updates the BO flags.
The consumer doesn't need the new flags, because even if DCC stays enabled
in the consumer, it's in a decompressed state (it has no effect). Only the
producer knows it's disabled, and any new consumer will also know it when
it queries the latest BO flags.

It doesn't work if both sides use writes, because it's not communicated
that DCC is disabled (BO flags are queried only once). This hasn't been a
problem so far.

Is there a way to disable DCC correctly and safely across processes? Yes.
So why don't we do it? Because it would add more GPU overhead.

Marek

--00000000000055399205ad0cd24d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Aug 12, 2020 at 9:54 AM Daniel Vetter &lt;<a href=3D"mailto:=
daniel@ffwll.ch">daniel@ffwll.ch</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, Aug 11, 2020 at 09:42:11AM -0400, =
Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; There are a few cases when the flags can change, for example DCC can b=
e<br>
&gt; disabled due to a hw limitation in the 3d engine. Modifiers give the<b=
r>
&gt; misleading impression that they help with that, but they don&#39;t. Th=
ey don&#39;t<br>
&gt; really help with anything.<br>
<br>
But if that happens, how do you tell the other side that it needs to<br>
sample new flags? Does that just happen all the time?<br>
<br>
Also do the DDC state changes happen for shared buffers too?<br></blockquot=
e><div><br></div><div>I thought we were only talking about shared buffers.<=
/div><div><br></div><div><div>If the other side is only a consumer and the =
producer must disable DCC, the producer decompresses DCC and then disables =
it and updates the BO flags. The consumer doesn&#39;t need the new flags, b=
ecause even if DCC stays enabled in the consumer, it&#39;s in a decompresse=
d state (it has no effect). Only the producer knows it&#39;s disabled, and =
any new consumer will also know it when it queries the latest BO flags.<br>=
</div><div><br></div><div>It doesn&#39;t work if both sides use writes, bec=
ause it&#39;s not communicated that DCC is disabled (BO flags are queried o=
nly once). This hasn&#39;t been a problem so far.</div><div><br></div><div>=
Is there a way to disable DCC correctly and safely across processes? Yes. S=
o why don&#39;t we do it? Because it would add more GPU overhead.<br></div>=
<div><br></div><div>Marek<br></div></div></div></div>

--00000000000055399205ad0cd24d--

--===============0664673270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0664673270==--
