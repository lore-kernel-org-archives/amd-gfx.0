Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC1C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 10:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA10360F5C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 10:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA10360F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D246F402;
	Fri, 30 Jul 2021 10:26:39 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53AB6F402
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 10:26:38 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 g23-20020a17090a5797b02901765d605e14so13637925pji.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9uiZu+Xa4ABGC8vQ2DT5hSjptEP92tF+c3MqMBE2IqE=;
 b=Afx354brk6ZYJksnYkYDHb46U3fDOrjTjRdgMjLKM9GmysWEz5hhHQThqitax1GOSP
 Sdv0tCm36yvmXMbNbOjoslucYrxcCD+pDO6jAgrn+kuqIJoD1Crz3YjebfGbcuOtgEqe
 opgAV9tDku0UcB0aIgtAL4zIpO3fQjkVWXLlPVMfno/jPuSlgjFZZs98Ctfl2v3/c1up
 1FgvO9yHYiWi5IO+1K5b7AsVWYXLPy1aTzoU6ZbcPb/9VV8WjSl1HovJiIqwMpPN+y3q
 FCUZRS1o0hh438Zr1p4SB5CrOyg1Fhdox9IXdg7E7ShREvdGyIExR9WTBA+RTGpD7R+q
 woCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9uiZu+Xa4ABGC8vQ2DT5hSjptEP92tF+c3MqMBE2IqE=;
 b=lfPMcHLCdR55w/vjYbJlJBGOVqX4AJdK2r1xPfBkmAtn3Klx1snMAxdnjhJJhn9boT
 87/nabJRkiRJ6gSPwWm9zkVbUdP/Kc6uHveWJjeEZv32moogrAo72XfrPidXvqvuA8VG
 wXd0h905DyMDBTrNtOu3pPrkgGMctaRMj5OlwySeym6WWxafr7TeIV1FEONjSFGqwsuE
 2+5eKxlJF3+8+8766Jp18OqDtRgLhphEX2qrtDtJ84LBR+SBUdD7qNktRJzYlc3ef18v
 jor8s42pJ9Ky76+tum2q7gOjUobugbr6h4STvs3jbA3ChHQHeJRntmmxWiyvDWPza7t4
 hbuw==
X-Gm-Message-State: AOAM531SeBUtdt1L+HiPA1UhcaweSicmiaaXG73VxCQPifdiC2uAx/V3
 Cp5iRmz63cuXgESzWA8zU/qsJMwqIYeS9p/I+XtRL1RhiFg=
X-Google-Smtp-Source: ABdhPJysn42rHf04Z095k7d4vm2RFH1FlOnHEjphElCXcgzPDol7QDjSv0jBwMagnCWRd94y536Q3kOlTy3BffW2LJ4=
X-Received: by 2002:a17:90a:4bcf:: with SMTP id
 u15mr2358330pjl.62.1627640798327; 
 Fri, 30 Jul 2021 03:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=4a=WfpGqCD-kapdDCFOLVkdUo_Brb-UfnG==5T0ScSoiihw@mail.gmail.com>
 <d23e0c4d-7439-0c7a-32f9-7b13390bae5e@daenzer.net>
In-Reply-To: <d23e0c4d-7439-0c7a-32f9-7b13390bae5e@daenzer.net>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Fri, 30 Jul 2021 12:26:27 +0200
Message-ID: <CAD=4a=XRAAa7OFQB0qJxxmvKhoMVBGyRVbGPQgFtrhpZWrCmHg@mail.gmail.com>
Subject: Re: Gmail throws all mailing list mails from amd.com in spam
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: multipart/alternative; boundary="0000000000009b381d05c854a780"
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000009b381d05c854a780
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm no I think it's something with the domain. It specifically says
"Be careful with this message
Gmail could not verify that it actually came from amd.com. Avoid clicking
links, downloading attachments, or replying with personal information."
in a big yellow warning box.
daenzer.net doesn't seem to be affected though! :-D


On Fri, Jul 30, 2021 at 11:11 AM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:

> On 2021-07-30 10:48 a.m., Ernst Sj=C3=B6strand wrote:
> > Hi,
> >
> > I noticed that this has been going on for some time. I guess this is
> because of DKIM?
> > Not sure what can be done about it. Gmail is quite persistent about it.
> >
> > Regards
> > //Ernst
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> One possible reason is the footer above, which was added to the e-mails
> sent out from the list to subscribers.
>
> I've now disabled this footer, fingers crossed this will help.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               https://redhat=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--0000000000009b381d05c854a780
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hmm no I think it&#39;s something with the domain. It s=
pecifically says</div><div class=3D"gmail_default" style=3D"font-family:ari=
al,helvetica,sans-serif">&quot;Be careful with this message<br>Gmail could =
not verify that it actually came from <a href=3D"http://amd.com">amd.com</a=
>. Avoid clicking links, downloading attachments, or replying with personal=
 information.&quot;</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif">in a big yellow warning box.</div><div class=3D=
"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><a href=3D=
"http://daenzer.net">daenzer.net</a> doesn&#39;t seem to be affected though=
! :-D</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetic=
a,sans-serif"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jul 30, 2021 at 11:11 AM Michel D=C3=A4nzer=
 &lt;<a href=3D"mailto:michel@daenzer.net">michel@daenzer.net</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2021-07-30 =
10:48 a.m., Ernst Sj=C3=B6strand wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I noticed that this has been going on for some time. I guess this is b=
ecause of DKIM?<br>
&gt; Not sure what can be done about it. Gmail is quite persistent about it=
.<br>
&gt; <br>
&gt; Regards<br>
&gt; //Ernst<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
<br>
One possible reason is the footer above, which was added to the e-mails sen=
t out from the list to subscribers.<br>
<br>
I&#39;ve now disabled this footer, fingers crossed this will help.<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"https://redhat.com" rel=3D"noreferrer" target=3D"_blank">https://redhat=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div>

--0000000000009b381d05c854a780--
