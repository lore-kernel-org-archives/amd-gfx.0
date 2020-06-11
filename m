Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B985C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 07:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7222074B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 07:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqSBTYkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7222074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE60389F2A;
	Thu, 11 Jun 2020 07:19:27 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DAB89F2A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 07:19:26 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id s23so2289180pfh.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cfWeobx+2/2JbDEvCxlUmPknTkhJ6B2uIyydLGvFqr4=;
 b=HqSBTYkONNKapUWFY5NRHxJaNSEQz6/X7qFzT6VJUijjDNOWB+3ChhWUPoTHCovjZc
 e8m4iSqTGRq0+U+9biU8RMuzZb/G/iIITFww8phiWvOCeY8H2o8Akk9e+w2ePwNLRZHr
 rI7DdBFgH6MGxyh2Jl9dZsQkEjYHFE8ENYlRzERkStMzwCukKe+fQOPXyBlelUanWcCC
 QISWjrgflsKsL8dpFLpOspAlP74RYJadC6L/8q/aiJr5nskJeutr44PWOYlwrTK2E077
 z0RQzCX9L23Q34CQSoHfApnz0R+xm8R3BNfPvo6YCheSIS50Vgq4DPNB8AiXv2Sp6Q94
 RQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cfWeobx+2/2JbDEvCxlUmPknTkhJ6B2uIyydLGvFqr4=;
 b=EduvAWh4Ocg2nJqy92sOHHTvvQiJWWhhzU9t/o8HRIkPZ1+D79G203fAqjB48SUtri
 K5R6LsqVyltkclkEzhpRAnv4w+Qab2yiqj81nZok/3z0PtmFaBKf3xpYyxTCzkFtsBja
 xx79DOdxlQjCVQwyV2ph+bf70w9KYIEn79a85Sg+VlBS6ITy8VYciQwm4nrQwpiox3bs
 jXzdLIOLz0zP+gg6Hys2Gq7pK3xjvTjwWRKntUyR5IU3jtYt3IlILQL4BOjWimLELS78
 b8hBySrWkWDJEPTWfeO4HMlX7JqR50Z+6MJnnt8QUp7ULkE8gwbgb4isYMVfkFfnYfYs
 U55Q==
X-Gm-Message-State: AOAM533gjwqXikDvdPQYUy4pX40L48DDBvOMBokNzDZbirOIdH0d7tpB
 4+tbZl1noiGnAVHcbC/6OHRxjQah8GT1FA0UkS8=
X-Google-Smtp-Source: ABdhPJyydS8Uw4pIQHjTXMIZZhZmgrHqwWQECuadjVFiwts7/IGliIwnSbb/iIK6Du7p/XM+6pmmk4rbDH06tr/YIFU=
X-Received: by 2002:a62:7a89:: with SMTP id v131mr5985855pfc.38.1591859965981; 
 Thu, 11 Jun 2020 00:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
 <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
 <b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com>
 <82cfde02-d2e4-35fe-f790-7ce63145aacc@amd.com>
In-Reply-To: <82cfde02-d2e4-35fe-f790-7ce63145aacc@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 11 Jun 2020 03:19:12 -0400
Message-ID: <CAAxE2A4JsmQL8kUA1Z0aq3sK86D3oJ54YkRe=yEo1AXJ1MT-yg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
To: Chunming Zhou <zhoucm1@amd.com>
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
Cc: "Zhou, David\(ChunMing\)" <david1.zhou@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1901215873=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1901215873==
Content-Type: multipart/alternative; boundary="000000000000cdf92905a7c9c7d2"

--000000000000cdf92905a7c9c7d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Explicit sync has nothing to do with this. This is for implicit sync, which
is required by DRI3. This fix allows removing existing inefficiencies from
drivers, so it's a good thing.

Marek

On Wed., Jun. 10, 2020, 03:56 Chunming Zhou, <zhoucm1@amd.com> wrote:

>
> =E5=9C=A8 2020/6/10 15:41, Christian K=C3=B6nig =E5=86=99=E9=81=93:
>
> That's true, but for now we are stuck with the implicit sync for quite a
> number of use cases.
>
> My problem is rather that we already tried this and it backfired
> immediately.
>
> I do remember that it was your patch who introduced the pipeline sync fla=
g
> handling and I warned that this could be problematic. You then came back
> with a QA result saying that this is indeed causing a huge performance dr=
op
> in one test case and we need to do something else. Together we then came =
up
> with the different handling between implicit and explicit sync.
>
> Isn't pipeline sync flag to fix some issue because of parralel execution
> between jobs in one pipeline?  I really don't have this memory in mind wh=
y
> that's realted to this, Or do you mean extra sync hides many other
> potential issues?
>
> Anyway, when I go through Vulkan WSI code, the synchronization isn't so
> smooth between OS window system. And when I saw Jason drives explicit syn=
c
> through the whole Linux ecosystem like Android window system does, I feel
> that's really a good direction.
>
> -David
>
>
> But I can't find that stupid mail thread any more. I knew that it was a
> couple of years ago when we started with the explicit sync for Vulkan.
>
> Christian.
>
> Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
>
> Not sue if this is right direction, I think usermode wants all
> synchronizations to be explicit. Implicit sync often confuses people who
> don=E2=80=99t know its history. I remember Jason from Intel  is driving e=
xplicit
> synchronization through the Linux ecosystem, which even removes implicit
> sync of shared buffer.
>
>
>
> -David
>
>
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
> <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *Marek Ol=C5=A1=C3=
=A1k
> *Sent:* Tuesday, June 9, 2020 6:58 PM
> *To:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org>
> *Subject:* [PATCH] drm/amdgpu: remove distinction between explicit and
> implicit sync (v2)
>
>
>
> Hi,
>
>
>
> This enables a full pipeline sync for implicit sync. It's Christian's
> patch with the driver version bumped. With this, user mode drivers don't
> have to wait for idle at the end of gfx IBs.
>
>
>
> Any concerns?
>
>
>
> Thanks,
>
> Marek
>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook.=
com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-g=
fx&data=3D02%7C01%7CDavid1.Zhou%40amd.com%7C47e97eb8e3654708f7ff08d80d11bcf=
7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637273717119277965&sdata=3DE=
Fq2J33HIOiIS3bok2ZcIz%2FhE%2FVs9T0HPy0UFi92Nf4%3D&reserved=3D0>
>
>
>

--000000000000cdf92905a7c9c7d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi David,<div dir=3D"auto"><br></div><div dir=3D"auto">Ex=
plicit sync has nothing to do with this. This is for implicit sync, which i=
s required by DRI3. This fix allows removing existing inefficiencies from d=
rivers, so it&#39;s a good thing.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Marek</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed., Jun. 10, 2020, 03:56 Chunming Zhou, &lt;<a hr=
ef=3D"mailto:zhoucm1@amd.com">zhoucm1@amd.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">

 =20
  <div>
    <p><br>
    </p>
    <div>=E5=9C=A8 2020/6/10 15:41, Christian K=C3=B6nig =E5=86=99=E9=81=93=
:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div>That&#39;s true, but for now we are stuck
        with the implicit sync for quite a number of use cases.<br>
        <br>
        My problem is rather that we already tried this and it backfired
        immediately.<br>
        <br>
        I do remember that it was your patch who introduced the pipeline
        sync flag handling and I warned that this could be problematic.
        You then came back with a QA result saying that this is indeed
        causing a huge performance drop in one test case and we need to
        do something else. Together we then came up with the different
        handling between implicit and explicit sync.<br>
      </div>
    </blockquote>
    <p>Isn&#39;t pipeline sync flag to fix some issue because of parralel
      execution between jobs in one pipeline?=C2=A0 I really don&#39;t have=
 this
      memory in mind why that&#39;s realted to this, Or do you mean extra
      sync hides many other potential issues?</p>
    <p>Anyway, when I go through Vulkan WSI code, the synchronization
      isn&#39;t so smooth between OS window system. And when I saw Jason
      drives explicit sync through the whole Linux ecosystem like
      Android window system does, I feel that&#39;s really a good direction=
.</p>
    <p>-David<br>
    </p>
    <blockquote type=3D"cite">
      <div> <br>
        But I can&#39;t find that stupid mail thread any more. I knew that
        it was a couple of years ago when we started with the explicit
        sync for Vulkan.<br>
        <br>
        Christian.<br>
        <br>
        Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):<br>
      </div>
      <blockquote type=3D"cite">
       =20
       =20
        <div>
          <p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078d7">[AMD
              Official Use Only - Internal Distribution Only]</span><u></u>=
<u></u></p>
          <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
          <p class=3D"MsoNormal">Not sue if this is right direction, I
            think usermode wants all synchronizations to be explicit.
            Implicit sync often confuses people who don=E2=80=99t know its
            history. I remember Jason from Intel =C2=A0is driving explicit
            synchronization through the Linux ecosystem, which even
            removes implicit sync of shared buffer.<u></u><u></u></p>
          <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
          <p class=3D"MsoNormal">-David<u></u><u></u></p>
          <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
          <div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:=
3.0pt 0in 0in 0in">
            <p class=3D"MsoNormal"><b>From:</b> amd-gfx <a href=3D"mailto:a=
md-gfx-bounces@lists.freedesktop.org" target=3D"_blank" rel=3D"noreferrer">=
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
              <b>On Behalf Of </b>Marek Ol=C5=A1=C3=A1k<br>
              <b>Sent:</b> Tuesday, June 9, 2020 6:58 PM<br>
              <b>To:</b> amd-gfx mailing list <a href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org" target=3D"_blank" rel=3D"noreferrer">&lt;amd-gfx@lists.=
freedesktop.org&gt;</a><br>
              <b>Subject:</b> [PATCH] drm/amdgpu: remove distinction
              between explicit and implicit sync (v2)<u></u><u></u></p>
          </div>
          <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
          <div>
            <div>
              <p class=3D"MsoNormal">Hi,<u></u><u></u></p>
            </div>
            <div>
              <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
            </div>
            <div>
              <p class=3D"MsoNormal">This enables a full pipeline sync for
                implicit sync. It&#39;s Christian&#39;s patch with the driv=
er
                version bumped. With this, user mode drivers don&#39;t have
                to wait for idle at the end of gfx IBs.<u></u><u></u></p>
            </div>
            <div>
              <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
            </div>
            <div>
              <p class=3D"MsoNormal">Any concerns?<u></u><u></u></p>
            </div>
            <div>
              <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
            </div>
            <div>
              <p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
            </div>
            <div>
              <p class=3D"MsoNormal">Marek<u></u><u></u></p>
            </div>
          </div>
        </div>
        <br>
        <fieldset></fieldset>
        <pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CDavid1.Zhou%40amd.com%7C47e97eb8e3654708f7ff08d80d11bcf7%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637273717119277965&amp;sdata=3DEFq2J33HIOiIS3=
bok2ZcIz%2FhE%2FVs9T0HPy0UFi92Nf4%3D&amp;reserved=3D0" target=3D"_blank" re=
l=3D"noreferrer">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
  </div>

</blockquote></div>

--000000000000cdf92905a7c9c7d2--

--===============1901215873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1901215873==--
