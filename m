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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689F1C54FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D434206BF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljTBRXdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D434206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77BA6E2D5;
	Mon, 27 Apr 2020 13:55:20 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34E56E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 13:55:19 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id t9so7556507pjw.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wODvq8BxeLZKL70a9EZQqFDzbgZmByYn0CdYr+g8v4k=;
 b=ljTBRXdm5u1CvbVaFu57PAO9l3E0xjVPRboPAJRScPGDnLYY3d/dYyJUPzdGVrTDGQ
 i4ZW6+NpwuhGvrbz8bBUYtskc6sD/m9WfKEtA7hnUl8o96tsiJipYpEr1GWQN+rqYHYZ
 HHTB36NtxngYzoB75L254z2xvEuW1lZsUBw+8RiWfAuq9OWdCNGNNO1PMQSuYjw0c+qf
 S2RGGwdNgldjTJSDQpTOp0eu2Yr/B8RHhmAGBuJsPZMbBN9CETVpAPzoMOis0iXB/QB3
 2xbsOlkNG1vDZ1+l+43IsoLCM0YGtlNGKHJXE/KAYI2/2/xC+MJXGzrxtFKln4Lps0Eb
 i9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wODvq8BxeLZKL70a9EZQqFDzbgZmByYn0CdYr+g8v4k=;
 b=V1R+ESIhMIKzJUBJZjDFGAQ1Zcc0Y/M2rUSbHvshVpoRrtTGOG7u6JnFS3MJLYS17b
 7EHpIwR6EcdAfk7ZAc0zNKqMAaRYdPHdkc8j5S0Om7anlC+x7TbRD2rY0RJW2gl1hRyR
 mVeeWPz+b2UemsMD3BfNtwhhfB4614m16Kyme5G7jtHBdIyZ5kdCclKC0pTbd3oKxahj
 GFBEXAwkNh0Gs+2vGUnGLn4freVxh8kJkkGpnHRqQxCJ0wCJpBeB5lB/FhQueeeiv3p9
 QCGoAsCZtQ4Y6MBOffeHHXAR1HPcMLcxbdPGwMUBp1/SYyFL8uf5vBFwBrQyN5Ps0Bvr
 HEzw==
X-Gm-Message-State: AGi0PuZ3ELr27sL4ulW1ccCIobbZ17QF9B7PGA9Hwlr4ftv37mFKDYPY
 x0Hh/3pCW89MUp61OmSDq4pzoZn6yhVlDZLB/dE=
X-Google-Smtp-Source: APiQypL6nf39Tsd4/P3U8zxwe8L61K99h+YyXdV2vCaUj565dYXCYz6rVEr9aGB3gX+atOdHdCK+Rmp8zbcGZdhAJss=
X-Received: by 2002:a17:902:b617:: with SMTP id
 b23mr24588588pls.194.1587995719492; 
 Mon, 27 Apr 2020 06:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A64Z91LiB9FduJf-8OO3He+1gZ9sxDfD+BVwc+-9Z7BnA@mail.gmail.com>
 <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
 <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>
 <328ea10b-1453-371e-7392-54e1a4051715@gmail.com>
 <MN2PR12MB448809E68050B9A61B1CC7FAF7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448809E68050B9A61B1CC7FAF7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 27 Apr 2020 09:54:43 -0400
Message-ID: <CAAxE2A50b_+oX9wmF2D6LZs9GvG9Rhug8AQU40aeDbMDm_kFqw@mail.gmail.com>
Subject: Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too
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
Content-Type: multipart/mixed; boundary="===============0223631443=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0223631443==
Content-Type: multipart/alternative; boundary="000000000000c3e92c05a446108c"

--000000000000c3e92c05a446108c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PAL requested it and they are going to use it. (it looks like they have to
use it for correctness)

Marek

On Mon, Apr 27, 2020 at 9:02 AM Deucher, Alexander <
Alexander.Deucher@amd.com> wrote:

> [AMD Official Use Only - Internal Distribution Only]
>
> Do we have open source code UMD code which uses this?
>
> Alex
> ------------------------------
> *From:* Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Sunday, April 26, 2020 4:55 AM
> *To:* Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>; Koenig, Christian <
> Christian.Koenig@amd.com>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx mailing
> list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute
> IBs too
>
> Thanks for that explanation. I suspected that there was a good reason to
> have that in the kernel, but couldn't find one.
>
> In this case the patch is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com> <christian.koenig@amd.com>
>
> We should probably add this explanation as comment to the flag as well.
>
> Thanks,
> Christian.
>
> Am 26.04.20 um 02:43 schrieb Marek Ol=C5=A1=C3=A1k:
>
> It was merged into amd-staging-drm-next.
>
> I'm not absolutely sure, but I think we need to invalidate before IBs if
> an IB is cached in L2 and the CPU has updated it. It can only be cached i=
n
> L2 if something other than CP has read it or written to it without
> invalidation. CP reads don't cache it but they can hit the cache if it's
> already cached.
>
> For CE, we need to invalidate before the IB in the kernel, because CE IBs
> can't do cache invalidations IIRC. This is the number one reason for
> merging the already pushed commits.
>
> Marek
>
> On Sat., Apr. 25, 2020, 11:03 Christian K=C3=B6nig, <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
> Was that patch set actually merged upstream? My last status is that we
> couldn't find a reason why we need to do this in the kernel.
>
> Christian.
>
> Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1k:
>
> This was missed.
>
> Marek
>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook.=
com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-g=
fx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e=
9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&sda=
ta=3D%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&reserved=3D0>
>
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook.=
com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-g=
fx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e=
9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&sda=
ta=3D%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&reserved=3D0>
>
>
>

--000000000000c3e92c05a446108c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>PAL requested it and they are going to use it. (it lo=
oks like they have to use it for correctness)<br></div><div><br></div><div>=
Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Apr 27, 2020 at 9:02 AM Deucher, Alexander &lt;<a h=
ref=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:rgb(0,120,215);margin:15=
pt" align=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Do we have open source code UMD code which uses this?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Alex<br>
</div>
<div id=3D"gmail-m_-4239586701017450887appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_-4239586701017450887divRplyFwdMsg" dir=3D"ltr"><font sty=
le=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>Fro=
m:</b> Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gm=
ail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Sunday, April 26, 2020 4:55 AM<br>
<b>To:</b> Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" ta=
rget=3D"_blank">maraeo@gmail.com</a>&gt;; Koenig, Christian &lt;<a href=3D"=
mailto:Christian.Koenig@amd.com" target=3D"_blank">Christian.Koenig@amd.com=
</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; amd-gfx mailing li=
st &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">a=
md-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compu=
te IBs too</font>
<div>=C2=A0</div>
</div>
<div style=3D"background-color:rgb(255,255,255)">
<div>Thanks for that explanation. I suspected that there was a good reason =
to have that in the kernel, but couldn&#39;t find one.<br>
<br>
In this case the patch is Reviewed-by: Christian K=C3=B6nig <a href=3D"mail=
to:christian.koenig@amd.com" target=3D"_blank">
&lt;christian.koenig@amd.com&gt;</a><br>
<br>
We should probably add this explanation as comment to the flag as well.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.04.20 um 02:43 schrieb Marek Ol=C5=A1=C3=A1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"auto">It was merged into amd-staging-drm-next.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I&#39;m not absolutely sure, but I think we need to inval=
idate before IBs if an IB is cached in L2 and the CPU has updated it. It ca=
n only be cached in L2 if something other than CP has read it or written to=
 it without invalidation. CP reads don&#39;t
 cache it but they can hit the cache if it&#39;s already cached.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">For CE, we need to invalidate before the IB in the kernel=
, because CE IBs can&#39;t do cache invalidations IIRC. This is the number =
one reason for merging the already pushed commits.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Marek</div>
</div>
<br>
<div>
<div dir=3D"ltr">On Sat., Apr. 25, 2020, 11:03 Christian K=C3=B6nig, &lt;<a=
 href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig=
.leichtzumerken@gmail.com</a>&gt; wrote:<br>
</div>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div>Was that patch set actually merged upstream? My last status is that we=
 couldn&#39;t find a reason why we need to do this in the kernel.<br>
<br>
Christian.<br>
<br>
Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div>This was missed.</div>
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
%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&amp;sdata=3D%2B95wpb=
jY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&amp;reserved=3D0" rel=3D"noreferre=
r" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
</a>
</pre>
</blockquote>
<br>
</div>
</blockquote>
</div>
<br>
<fieldset></fieldset>
<pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&amp;sdata=3D%2B95wpb=
jY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&amp;reserved=3D0" target=3D"_blank=
">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<br>
</div>
</div>
</div>

</blockquote></div>

--000000000000c3e92c05a446108c--

--===============0223631443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0223631443==--
