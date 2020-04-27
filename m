Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC318C54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EAA2064A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8XER+Eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EAA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6126E2D5;
	Mon, 27 Apr 2020 13:53:45 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E0E6E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 13:53:43 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id fu13so6876621pjb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6szZhgyjnmkFBKYFpC3eFpf3XKWlJBfKX0ymXbIlxDc=;
 b=G8XER+EuAwI97ZZZBkCf7jH7wnFgF67OIvisLnRRyjTVGveq/bQTVFreUDQ6Pe4etJ
 UcPsFnQayM947mAfuueNTbu/gTRD1cx5J5kghOMNHx0snvT6FOYICati1nXj9ixQQEU/
 6m0PXu3TXBu63u11+LgK0Ob2X2Ev5JAjKb2V66t0AanFPNjCPsC6VEDvsS6vUmzxCKkb
 hsJtW6HWLwWnghF/nyMb3T+vs/EfEK9S578lOwkPYxmqpYGWX7pNWnXFtW59PUt9KBkx
 dvn7QLxxTpSFFB2rjFxEgUj2YlteI013Z3uXOwKcq/XZKaA//Dz1mJ5KW7OMfya8BRtG
 gCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6szZhgyjnmkFBKYFpC3eFpf3XKWlJBfKX0ymXbIlxDc=;
 b=oGfNGaAwHbg6W9pDheyNU9Qt927zi1Zm/zO16E7PJCetHgLJPeZrLmSuhMs5wYLmj1
 o+ib+jHD/ggPRqsD38ws/UqxGwA7orx0j4T1UUxP3iVPnYFITFNObMBoC8RwrjTrf2cy
 3ryqEcZwEFibHPTnLDUZ+rC/mdnbkLspME44gbVGZHHCSsIGOsLReiTQ5RM8bFL/JRhm
 wsYjTe9SYgwhO4xxVEHTjf9orMWy/Qwi6dM/XSH8GEYtZLOt1orSgeoeyYklPeY7OgCH
 MrWlX4ZP1QJ1ikY5R6SNLTOouuNIp6ckRWMquwwQHuWocoNQW08quUVjZwLAy0OUjpio
 eKvg==
X-Gm-Message-State: AGi0PuZtyCAjYW91GA+IlSmLPCeDfCP0CidswoFyUzf/wPqRVohDTCnX
 ahNjnGdmkN31p0E7uWncKoT8In+c8fGUaPPO1dIPm1Ln
X-Google-Smtp-Source: APiQypLc7J757Fpj1IX5LbqO/bJOp/TT/fIk8IrVRJ18ht5tC2EjzVQyenruVkbve7uMFCb6/1lNUxtmyht4UDOLbIk=
X-Received: by 2002:a17:902:a50d:: with SMTP id
 s13mr13607507plq.5.1587995622598; 
 Mon, 27 Apr 2020 06:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
 <71c2f3e9-a734-5887-b5ce-7fa8b011d372@gmail.com>
 <CAAxE2A67RM1e0Xs2fTcDPm0eTyd4EvdH2vqPsVXWEODL=Dk4zw@mail.gmail.com>
 <659c4b65-764e-85a8-6ac6-0a9daaa6437e@amd.com>
 <MN2PR12MB4488629455EEFE9590402250F7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488629455EEFE9590402250F7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 27 Apr 2020 09:53:06 -0400
Message-ID: <CAAxE2A6fWJ+Dnq4HWKSqi8FQ6aCXNgLa9ombJGB8v0ffLFkV+Q@mail.gmail.com>
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1106559039=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1106559039==
Content-Type: multipart/alternative; boundary="000000000000fd6b6e05a4460ac8"

--000000000000fd6b6e05a4460ac8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've already pushed the patch and marked it for stable.

I added a note into the commit message to discard the version bump for
stable.

The GCR packet is always supported in the ring regardless of firmware.

Marek

On Mon, Apr 27, 2020 at 9:01 AM Deucher, Alexander <
Alexander.Deucher@amd.com> wrote:

> [AMD Official Use Only - Internal Distribution Only]
>
> Please split the patch into two, one to update the emit IB sequence, and
> one to bump the minor version.  That way we can make sure older kernels g=
et
> the new sequence.  Also do we need an sdma fw version check for the new
> packet in the emi IB function?
>
> Alex
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> Christian K=C3=B6nig <christian.koenig@amd.com>
> *Sent:* Sunday, April 26, 2020 4:52 AM
> *To:* Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
> *Cc:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
>
> Thought so, we should try to get this get it committed ASAP. And maybe ad=
d
> a CC: stable tag as well.
>
> Patch is Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> <christian.koenig@amd.com>.
>
> Thanks,
> Christian.
>
> Am 26.04.20 um 02:28 schrieb Marek Ol=C5=A1=C3=A1k:
>
> Not without a mandatory firmware update. The gcr packet support for IBs
> was added into the sdma firmware just two weeks ago.
>
> Marek
>
> On Sat., Apr. 25, 2020, 11:04 Christian K=C3=B6nig, <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
> Could we do this in userspace as well?
>
> Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1k:
>
> This should fix SDMA hangs on gfx10.
>
> Marek
>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook.=
com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-g=
fx&data=3D02%7C01%7Calexander.deucher%40amd.com%7Cc88f73e068bb483bb21f08d7e=
9bf2cd4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234879980330283&sda=
ta=3DLZ2GMq0a0n6cm74ulhIkMq%2Fyj6XlG1lj9AH0InU1%2BdQ%3D&reserved=3D0>
>
>
>
>

--000000000000fd6b6e05a4460ac8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ve already pushed the patch and marked it for s=
table.</div><div><br></div><div>I added a note into the commit message to d=
iscard the version bump for stable.</div><div><br></div><div>The GCR packet=
 is always supported in the ring regardless of firmware.<br></div><div><br>=
</div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Apr 27, 2020 at 9:01 AM Deucher, Alexande=
r &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>




<div dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:rgb(0,120,215);margin:15=
pt" align=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Please split the patch into two, one to update the emit IB sequence, and on=
e to bump the minor version.=C2=A0 That way we can make sure older kernels =
get the new sequence.=C2=A0 Also do we need an sdma fw version check for th=
e new packet in the emi IB function?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Alex<br>
</div>
<div id=3D"gmail-m_-8939609776142340197appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_-8939609776142340197divRplyFwdMsg" dir=3D"ltr"><font sty=
le=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>Fro=
m:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org"=
 target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf =
of Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com" tar=
get=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
<b>Sent:</b> Sunday, April 26, 2020 4:52 AM<br>
<b>To:</b> Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" ta=
rget=3D"_blank">maraeo@gmail.com</a>&gt;<br>
<b>Cc:</b> amd-gfx mailing list &lt;<a href=3D"mailto:amd-gfx@lists.freedes=
ktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)</f=
ont>
<div>=C2=A0</div>
</div>
<div style=3D"background-color:rgb(255,255,255)">
<div>Thought so, we should try to get this get it committed ASAP. And maybe=
 add a CC: stable tag as well.<br>
<br>
Patch is Reviewed-by: Christian K=C3=B6nig <a href=3D"mailto:christian.koen=
ig@amd.com" target=3D"_blank">
&lt;christian.koenig@amd.com&gt;</a>.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.04.20 um 02:28 schrieb Marek Ol=C5=A1=C3=A1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"auto">Not without a mandatory firmware update. The gcr packet s=
upport for IBs was added into the sdma firmware just two weeks ago.
<div dir=3D"auto">
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Marek</div>
</div>
</div>
<br>
<div>
<div dir=3D"ltr">On Sat., Apr. 25, 2020, 11:04 Christian K=C3=B6nig, &lt;<a=
 href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig=
.leichtzumerken@gmail.com</a>&gt; wrote:<br>
</div>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div>Could we do this in userspace as well?<br>
<br>
Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div>This should fix SDMA hangs on gfx10.<br>
</div>
<div><br>
</div>
<div>Marek<br>
</div>
</div>
<br>
<fieldset></fieldset>
<pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferrer" target=
=3D"_blank">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Calexander.deucher%40amd.com%7Cc88f73e068bb483bb21f08d7e9bf2cd4%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637234879980330283&amp;sdata=3DLZ2GMq0a=
0n6cm74ulhIkMq%2Fyj6XlG1lj9AH0InU1%2BdQ%3D&amp;reserved=3D0" rel=3D"norefer=
rer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-g=
fx</a>
</pre>
</blockquote>
<br>
</div>
</blockquote>
</div>
</blockquote>
<br>
</div>
</div>
</div>

</blockquote></div>

--000000000000fd6b6e05a4460ac8--

--===============1106559039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1106559039==--
