Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5963EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 17:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D73619E2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18D73619E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A4C6EC36;
	Thu, 30 Sep 2021 17:34:13 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C762D6EC36
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 17:34:12 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id u7so5598116pfg.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mfa7ucchAWzF4UqtlfHlJqP7e5aJ0v35iti1fJik59g=;
 b=NtD0fIyrFlRI5rv5bGYUYEcj/dcz5PVuGt+PORcNdNmFh5/gQhCaZwPtd//NbP5ryQ
 wbl3u/S7+Funvepp4U5C9g+yu4RZSWXaXuaYRrOcWFwGkm+bN6ttJLY5b/+NIMRd0Lwg
 9Ut6bguQFDcf6uPc4606cle3sk7X/ErJSRcQ9F2STBu5z+x7FCGZZ0d5sFmZodT71zWb
 /UsIUqhxMIMYjX42rq04820Z99nrjUibf3TnFePOn9WqIBU8ToP5veO15ZYI4Q3Rdcd4
 UpMbVuMWMzg6zTUP6I/cnZt1aQBF487n+dyJSanZL/AYcoAq91DgP7/U1qksBfcVcfd5
 gM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mfa7ucchAWzF4UqtlfHlJqP7e5aJ0v35iti1fJik59g=;
 b=qgE6aMKtipiqK+TMQnnizARFlzC0tJLqqTVKnKh8B60f9yjndHB+evONXkfZ/RlrVZ
 /WCTvncLDq4upTedivSpWFPsENwj5RtDxc8LQVYLku39UIhwp+D3ECMVdU6oru2+Ia9h
 MdOrufJh3h/MHsX+Hg4V11ETs+94FhxieNUFGapTW/PJ9Jb4NvONXZbTAAEWi9/xFJmt
 xsPtLvRc3KzQrj/0NorSSz/2AZuzMcF9bIfpGs1lXv6tOjUx07HzPZirDHStYdaMO4lN
 Y8fxvbPertDIV4zXL3qNY8TdfEYe9QnIyFbZ6IP2xYt/01U+mXqlTH5y/N6FWWHscZVL
 BHog==
X-Gm-Message-State: AOAM531rvQ/3pez82LkmKExgOMY7AP7639xC1Iesvk9Zqz3n67WHXkyU
 6sFMvML7lT+seHs0q98bISPHPOsXNafPjldWZkbQl4q/
X-Google-Smtp-Source: ABdhPJwwEQYkYqY8QXSaEHxl/ZbbJXxormUylCNLm4AEUCTwU05Ng32k8BEbyg0Nsk0FalWDjh9tAAJvnF0dlTPgr9A=
X-Received: by 2002:aa7:9807:0:b0:44b:28b0:747e with SMTP id
 e7-20020aa79807000000b0044b28b0747emr5513036pfl.42.1633023252143; Thu, 30 Sep
 2021 10:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6a45Vebk4FhH__FG66zDn0m6GbJgK3Bz3o8obePW5P_w@mail.gmail.com>
 <CADnq5_Ps0j20jOkEuU3xJi=v6Qbvp66dFdZOdYrCSn6Q6uknSQ@mail.gmail.com>
 <CAAxE2A6mjGL27dGpq1GCGspsa7CffSGO9MhW8LmFmbZ=JzTr_g@mail.gmail.com>
 <63cbb603-88d4-c1ac-0ead-fd4e0132aa1c@froggi.es>
In-Reply-To: <63cbb603-88d4-c1ac-0ead-fd4e0132aa1c@froggi.es>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 30 Sep 2021 13:33:36 -0400
Message-ID: <CAAxE2A7d4gsSiGv+JSnfrK4RudRKzmLd86gjLZkMJcjzoGXzXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix DCC settings for DCN3
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000daa23a05cd39dab0"
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

--000000000000daa23a05cd39dab0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The name is kind of correct. It means "64B with no 128B cache line
straddling", which really means just 64B independent blocks with a small
modification to support DCC image stores.  They are not true 128B
independent blocks.

Marek

On Thu, Sep 30, 2021 at 12:35 PM Joshua Ashton <joshua@froggi.es> wrote:

> Can we please add documentation for this enum?
>
> This was not necessarily a typo, but me misunderstanding and stuff it
> working in my testing.
>
> I guess I don't understand why hubp_ind_block_64b_no_128bcl is for 64b
> && 128b when it specifically says "no_128" in the name.
>
> Is there something about it I am missing or is it just misleading naming?
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
> On 9/30/21 17:14, Marek Ol=C5=A1=C3=A1k wrote:
> > I've also amended the version bump that I forgot to do:
> >
> > -#define KMS_DRIVER_MINOR       43
> > +#define KMS_DRIVER_MINOR       44
> >
> > Marek
> >
> > On Thu, Sep 30, 2021 at 12:06 PM Alex Deucher <alexdeucher@gmail.com
> > <mailto:alexdeucher@gmail.com>> wrote:
> >
> >     Acked-by: Alex Deucher <alexander.deucher@amd.com
> >     <mailto:alexander.deucher@amd.com>>
> >
> >     On Thu, Sep 30, 2021 at 11:50 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com
> >     <mailto:maraeo@gmail.com>> wrote:
> >      >
> >      > Hi,
> >      >
> >      > Just discovered this typo. Please review.
> >      >
> >      > Thanks,
> >      > Marek
> >
>
>

--000000000000daa23a05cd39dab0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The name is kind of correct. It means &quot;64B with =
no 128B cache line straddling&quot;, which really means just 64B independen=
t blocks with a small modification to support DCC image stores.=C2=A0 They =
are not true 128B independent blocks.<br></div><div><br></div><div>Marek<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Sep 30, 2021 at 12:35 PM Joshua Ashton &lt;<a href=3D"mailto=
:joshua@froggi.es">joshua@froggi.es</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Can we please add documentation for this=
 enum?<br>
<br>
This was not necessarily a typo, but me misunderstanding and stuff it <br>
working in my testing.<br>
<br>
I guess I don&#39;t understand why hubp_ind_block_64b_no_128bcl is for 64b =
<br>
&amp;&amp; 128b when it specifically says &quot;no_128&quot; in the name.<b=
r>
<br>
Is there something about it I am missing or is it just misleading naming?<b=
r>
<br>
- Joshie =F0=9F=90=B8=E2=9C=A8<br>
<br>
On 9/30/21 17:14, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; I&#39;ve also amended the version bump that I forgot to do:<br>
&gt; <br>
&gt; -#define KMS_DRIVER_MINOR =C2=A0 =C2=A0 =C2=A0 43<br>
&gt; +#define KMS_DRIVER_MINOR =C2=A0 =C2=A0 =C2=A0 44<br>
&gt; <br>
&gt; Marek<br>
&gt; <br>
&gt; On Thu, Sep 30, 2021 at 12:06 PM Alex Deucher &lt;<a href=3D"mailto:al=
exdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">=
alexdeucher@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexan=
der.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:alexander.deucher@amd.=
com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Sep 30, 2021 at 11:50 AM Marek Ol=C5=A1=C3=
=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail=
.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:maraeo@gmail.com" targ=
et=3D"_blank">maraeo@gmail.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Just discovered this typo. Please review.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Marek<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000daa23a05cd39dab0--
