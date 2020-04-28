Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C9C83004
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 05:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAED0206A1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 05:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4I2b09v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAED0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77DF289C3B;
	Tue, 28 Apr 2020 05:16:36 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9B989C3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 05:16:35 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id n24so7872376plp.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fcZcu3cIEAWOqdrohqQfoHWhfQaMwr3TNdoDT1SfkMM=;
 b=U4I2b09vWmodV9M26fC0C+UnS3HNY7FeSJ8ra80BuCC67frS53ulh0Mog3Qg2jDFUS
 ir7Gn5Sp5Q01D8LTAFkZErCBBg5RZsIfePuZIoYXT2/5p6jWA3dfgoZ4eB9Z0y98PQ8T
 UqO+bchKemQ1cothIDJKGIyX+8c5tnG/+UBPgWEovkWftBkEg6QlHS8FOdUoORKOvmoH
 QXXNH01U3bQQKjaRBYnN+cs7EQg7uRUYIxy1zKj61UgxhN1vbqKIwJnhTOj6BhrdVCgh
 OQcAlyoHHzTIY8IJNQBzz/OcGlBwTf2LQsi/U3vxJan1+0/KbNZhalhBC5So/fiN/++m
 N/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fcZcu3cIEAWOqdrohqQfoHWhfQaMwr3TNdoDT1SfkMM=;
 b=KUpxEhy+5qMV3TXmwEB0c7Zzx6FDBCRLiiuP4ugPnq8lNotETKsZxhNT0KJSR3OvSi
 vnKIBQZLOY59SASpv+nKAJmStQD+buEZTGyJ57isDkC6nxzBCvme4bRTRGOO13xzqsRn
 iZ6Y1HcmOr+KWr8h2KLr3mD6AdsVldP+mRiJBc60BOTgOz1tTYsveosZXvUhWMQ/brI9
 jx+5EjaG61zIDV5sFEeZK+Dj0f00qA9nCK2rS7cwTc0W2CU7J8Czn5zrWKL/JTZnKJOb
 QF+yAX+BJ3uFeSeEDHooXILKqFgTsubEu5u0w6zSdTYWjz5N0TXVPLPgomqF98ZFH02n
 A+FQ==
X-Gm-Message-State: AGi0PuYI5vS/nWiAC0mqpJql9Ho5acH4LDooL2lMTerFRBnrpMZe9qZg
 ddIqo+KX11iMCHI59XW4U72FYmCOQ14zmEncRsNlFEYd
X-Google-Smtp-Source: APiQypLHyVFXmKd6Ksy9K/otmSwZlF2giBbfqDSdWxuPRRuS9PtRym+zlPQc9aNh0mCsLM5/8TLQ6FqZncy6Ue3Y6GE=
X-Received: by 2002:a17:90b:3443:: with SMTP id
 lj3mr2882889pjb.38.1588050995014; 
 Mon, 27 Apr 2020 22:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A64Z91LiB9FduJf-8OO3He+1gZ9sxDfD+BVwc+-9Z7BnA@mail.gmail.com>
 <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
 <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>
 <328ea10b-1453-371e-7392-54e1a4051715@gmail.com>
 <MN2PR12MB448809E68050B9A61B1CC7FAF7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CAAxE2A50b_+oX9wmF2D6LZs9GvG9Rhug8AQU40aeDbMDm_kFqw@mail.gmail.com>
 <217db438-608d-d28c-6678-4173a6291d8b@gmail.com>
 <CAAxE2A5ZoQjWw+8JjHe5j-_-ABtEc_kE4BRL0CNS3kzhbVe0Xg@mail.gmail.com>
In-Reply-To: <CAAxE2A5ZoQjWw+8JjHe5j-_-ABtEc_kE4BRL0CNS3kzhbVe0Xg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 28 Apr 2020 01:16:23 -0400
Message-ID: <CAAxE2A4Wo7foY3xM_q-F8s4j7wD1FdS1mA3qG5gYOEV=OhopjQ@mail.gmail.com>
Subject: Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1367216329=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1367216329==
Content-Type: multipart/alternative; boundary="00000000000071716a05a452ef0a"

--00000000000071716a05a452ef0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's possible that what they really needed was the SDMA fix, so I don't
know if they need this flag anymore.

Marek

On Tue., Apr. 28, 2020, 01:12 Marek Ol=C5=A1=C3=A1k, <maraeo@gmail.com> wro=
te:

> No, Mesa won't use it. It's only necessary for the constant engine. My
> understanding from various discussions with the PAL team is that they nee=
d
> it, but I don't know if they even understand what the MEM_SYNC flag does.
>
> Marek
>
> On Mon., Apr. 27, 2020, 10:53 Christian K=C3=B6nig, <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Yeah, but is Mesa going to use it?
>>
>> Christian.
>>
>> Am 27.04.20 um 15:54 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> PAL requested it and they are going to use it. (it looks like they have
>> to use it for correctness)
>>
>> Marek
>>
>> On Mon, Apr 27, 2020 at 9:02 AM Deucher, Alexander <
>> Alexander.Deucher@amd.com> wrote:
>>
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>> Do we have open source code UMD code which uses this?
>>>
>>> Alex
>>> ------------------------------
>>> *From:* Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>>> *Sent:* Sunday, April 26, 2020 4:55 AM
>>> *To:* Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>; Koenig, Christian <
>>> Christian.Koenig@amd.com>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx mailing
>>> list <amd-gfx@lists.freedesktop.org>
>>> *Subject:* Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to
>>> compute IBs too
>>>
>>> Thanks for that explanation. I suspected that there was a good reason t=
o
>>> have that in the kernel, but couldn't find one.
>>>
>>> In this case the patch is Reviewed-by: Christian K=C3=B6nig
>>> <christian.koenig@amd.com> <christian.koenig@amd.com>
>>>
>>> We should probably add this explanation as comment to the flag as well.
>>>
>>> Thanks,
>>> Christian.
>>>
>>> Am 26.04.20 um 02:43 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> It was merged into amd-staging-drm-next.
>>>
>>> I'm not absolutely sure, but I think we need to invalidate before IBs i=
f
>>> an IB is cached in L2 and the CPU has updated it. It can only be cached=
 in
>>> L2 if something other than CP has read it or written to it without
>>> invalidation. CP reads don't cache it but they can hit the cache if it'=
s
>>> already cached.
>>>
>>> For CE, we need to invalidate before the IB in the kernel, because CE
>>> IBs can't do cache invalidations IIRC. This is the number one reason fo=
r
>>> merging the already pushed commits.
>>>
>>> Marek
>>>
>>> On Sat., Apr. 25, 2020, 11:03 Christian K=C3=B6nig, <
>>> ckoenig.leichtzumerken@gmail.com> wrote:
>>>
>>> Was that patch set actually merged upstream? My last status is that we
>>> couldn't find a reason why we need to do this in the kernel.
>>>
>>> Christian.
>>>
>>> Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> This was missed.
>>>
>>> Marek
>>>
>>> _______________________________________________
>>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedesk=
top.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd=
-gfx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d=
7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&s=
data=3D%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&reserved=3D0>
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedesk=
top.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd=
-gfx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d=
7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&s=
data=3D%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&reserved=3D0>
>>>
>>>
>>>
>> _______________________________________________
>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskt=
op.org/mailman/listinfo/amd-gfx
>>
>>
>>

--00000000000071716a05a452ef0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It&#39;s possible that what they really needed was the SD=
MA fix, so I don&#39;t know if they need this flag anymore.<div dir=3D"auto=
"><br></div><div dir=3D"auto">Marek</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue., Apr. 28, 2020, 01:12 Mare=
k Ol=C5=A1=C3=A1k, &lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto">N=
o, Mesa won&#39;t use it. It&#39;s only necessary for the constant engine. =
My understanding from various discussions with the PAL team is that they ne=
ed it, but I don&#39;t know if they even understand what the MEM_SYNC flag =
does.<div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon., Apr.=
 27, 2020, 10:53 Christian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.leicht=
zumerken@gmail.com" target=3D"_blank" rel=3D"noreferrer">ckoenig.leichtzume=
rken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div>Yeah, but is Mesa going to use it?<br>
      <br>
      Christian.<br>
      <br>
      Am 27.04.20 um 15:54 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>PAL requested it and they are going to use it. (it looks
          like they have to use it for correctness)<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 27, 2020 at 9:02
          AM Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd=
.com" rel=3D"noreferrer noreferrer" target=3D"_blank">Alexander.Deucher@amd=
.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">
            <p style=3D"font-family:Arial;font-size:10pt;color:rgb(0,120,21=
5);margin:15pt" align=3D"Left">
              [AMD Official Use Only - Internal Distribution Only]<br>
            </p>
            <br>
            <div>
              <div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;=
font-size:12pt;color:rgb(0,0,0)">Do
                we have open source code UMD code which uses this?</div>
              <div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;=
font-size:12pt;color:rgb(0,0,0)"><br>
              </div>
              <div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;=
font-size:12pt;color:rgb(0,0,0)">Alex<br>
              </div>
              <hr style=3D"display:inline-block;width:98%">
              <div id=3D"m_890681371629926529m_-6677784358645779172gmail-m_=
-4239586701017450887divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11p=
t" face=3D"Calibri,
                  sans-serif" color=3D"#000000"><b>From:</b> Christian
                  K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">ckoenig.leichtzum=
erken@gmail.com</a>&gt;<br>
                  <b>Sent:</b> Sunday, April 26, 2020 4:55 AM<br>
                  <b>To:</b> Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:ma=
raeo@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">maraeo@gmai=
l.com</a>&gt;;
                  Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@=
amd.com" rel=3D"noreferrer noreferrer" target=3D"_blank">Christian.Koenig@a=
md.com</a>&gt;<br>
                  <b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexa=
nder.Deucher@amd.com" rel=3D"noreferrer noreferrer" target=3D"_blank">Alexa=
nder.Deucher@amd.com</a>&gt;;
                  amd-gfx mailing list &lt;<a href=3D"mailto:amd-gfx@lists.=
freedesktop.org" rel=3D"noreferrer noreferrer" target=3D"_blank">amd-gfx@li=
sts.freedesktop.org</a>&gt;<br>
                  <b>Subject:</b> Re: drm/amdgpu: apply
                  AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too</font>
                <div>=C2=A0</div>
              </div>
              <div style=3D"background-color:rgb(255,255,255)">
                <div>Thanks for that explanation. I suspected that there
                  was a good reason to have that in the kernel, but
                  couldn&#39;t find one.<br>
                  <br>
                  In this case the patch is Reviewed-by: Christian K=C3=B6n=
ig
                  <a href=3D"mailto:christian.koenig@amd.com" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">
                    &lt;christian.koenig@amd.com&gt;</a><br>
                  <br>
                  We should probably add this explanation as comment to
                  the flag as well.<br>
                  <br>
                  Thanks,<br>
                  Christian.<br>
                  <br>
                  Am 26.04.20 um 02:43 schrieb Marek Ol=C5=A1=C3=A1k:<br>
                </div>
                <blockquote type=3D"cite">
                  <div dir=3D"auto">It was merged into
                    amd-staging-drm-next.
                    <div dir=3D"auto"><br>
                    </div>
                    <div dir=3D"auto">I&#39;m not absolutely sure, but I th=
ink
                      we need to invalidate before IBs if an IB is
                      cached in L2 and the CPU has updated it. It can
                      only be cached in L2 if something other than CP
                      has read it or written to it without invalidation.
                      CP reads don&#39;t cache it but they can hit the cach=
e
                      if it&#39;s already cached.</div>
                    <div dir=3D"auto"><br>
                    </div>
                    <div dir=3D"auto">For CE, we need to invalidate before
                      the IB in the kernel, because CE IBs can&#39;t do
                      cache invalidations IIRC. This is the number one
                      reason for merging the already pushed commits.</div>
                    <div dir=3D"auto"><br>
                    </div>
                    <div dir=3D"auto">Marek</div>
                  </div>
                  <br>
                  <div>
                    <div dir=3D"ltr">On Sat., Apr. 25, 2020, 11:03
                      Christian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.l=
eichtzumerken@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">ck=
oenig.leichtzumerken@gmail.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
                      <div bgcolor=3D"#FFFFFF">
                        <div>Was that patch set actually merged
                          upstream? My last status is that we couldn&#39;t
                          find a reason why we need to do this in the
                          kernel.<br>
                          <br>
                          Christian.<br>
                          <br>
                          Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1=
k:<br>
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
                          <pre>____________________________________________=
___
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferrer noreferr=
er noreferrer" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&amp;sdata=3D%2B95wpb=
jY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&amp;reserved=3D0" rel=3D"noreferre=
r noreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx</a>
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
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferrer noreferr=
er" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&amp;sdata=3D%2B95wpb=
jY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&amp;reserved=3D0" rel=3D"noreferre=
r noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listi=
nfo/amd-gfx</a>
</pre>
                </blockquote>
                <br>
              </div>
            </div>
          </div>
        </blockquote>
      </div>
      <br>
      <fieldset></fieldset>
      <pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferrer noreferr=
er" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div>
</blockquote></div>

--00000000000071716a05a452ef0a--

--===============1367216329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1367216329==--
