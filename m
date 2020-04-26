Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD2DC55185
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 00:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D1220700
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 00:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX4mqzC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D1220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F836E28E;
	Sun, 26 Apr 2020 00:43:13 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711B36E28E
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 00:43:12 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id h11so5371516plr.11
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2020 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CxtWe8NLyKxpB5jq9Z/Xk/8YoBJ2lbDxQRrXU04tC+M=;
 b=EX4mqzC8HnjrHqyt1HewTgg+ZZD2cWS+GcD82XdUo61fXVbvtyO8B83D0tvCgzvQrr
 G6oWDsCMtqL3O6JLNdQWiHhNA0Dqy+Rlsbo6CeIqKfvXnuN1pskqLaM6GnkqbSDMHQX4
 ziOEQV9xi3JuLOkVDnRQ1jaww8DPZasqWPBHHnvHgaWpLGfCymT1FfawmNdw9t2bpF/1
 oq7vYy1k1EEMSwS9MDd9qRnnZ9PDlFihB12gc22MX0mv7QQh8yShBlW/12byvKqUbPAg
 Iy7P/chjcimq8Tr23DrZ4H7jL71Rciznl58gXdgXHNEhD7ycqRC3+AQOGSO439l0lQwA
 DdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CxtWe8NLyKxpB5jq9Z/Xk/8YoBJ2lbDxQRrXU04tC+M=;
 b=g0ZmA9it4C/W5A19P4AzvmmfJvEQvOBI93hVZu5sOqmfqfTGkdma+l9fS3FO6+ockx
 AAHMjdPxiXqy2q6EOjrhGnU03vo7VjZrBkaxtHLM25jjomXoASIh2MIV5iidMUVM+gKq
 cgc4DG2hnHSetGzRNHoVP35zbJjYC50ZS9xOl5Pol8wA1Hsc+fqrKLWvlJGn2IFWOsTc
 Nm4p7JCVJo0Iu+qcmISWDRuuUWsnxF02LjxYCV4uxujo78Lp6idlqHw/U9o7qnTp5MoL
 cnGtpVQkmtsDG7z5fYoUWAONaIbizf4ldqMqgW8gQxmZqUEBjl5Ir7ddH+CUQH0N70ld
 tzeQ==
X-Gm-Message-State: AGi0Puaravb0xLUedwIrV1dRcnK2gfCVeETNYhkcM8Y6HUgjONq6DXbF
 aihtdnacEaZGlcpzWwJIla0g+OsJI0Tgv1vib1s=
X-Google-Smtp-Source: APiQypLc/e23hIS41GO9HedcuocqE1brJq+UvUIzc7EOKnNyIc3E6ja9HjqvUyo88FQYY7wTfz7te0khLInCdTXIMa0=
X-Received: by 2002:a17:90a:1998:: with SMTP id
 24mr15818059pji.0.1587861792031; 
 Sat, 25 Apr 2020 17:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A64Z91LiB9FduJf-8OO3He+1gZ9sxDfD+BVwc+-9Z7BnA@mail.gmail.com>
 <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
In-Reply-To: <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 25 Apr 2020 20:43:00 -0400
Message-ID: <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2090685347=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2090685347==
Content-Type: multipart/alternative; boundary="00000000000011075405a426e26f"

--00000000000011075405a426e26f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It was merged into amd-staging-drm-next.

I'm not absolutely sure, but I think we need to invalidate before IBs if an
IB is cached in L2 and the CPU has updated it. It can only be cached in L2
if something other than CP has read it or written to it without
invalidation. CP reads don't cache it but they can hit the cache if it's
already cached.

For CE, we need to invalidate before the IB in the kernel, because CE IBs
can't do cache invalidations IIRC. This is the number one reason for
merging the already pushed commits.

Marek

On Sat., Apr. 25, 2020, 11:03 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

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
p.org/mailman/listinfo/amd-gfx
>
>
>

--00000000000011075405a426e26f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It was merged into amd-staging-drm-next.<div dir=3D"auto"=
><br></div><div dir=3D"auto">I&#39;m not absolutely sure, but I think we ne=
ed to invalidate before IBs if an IB is cached in L2 and the CPU has update=
d it. It can only be cached in L2 if something other than CP has read it or=
 written to it without invalidation. CP reads don&#39;t cache it but they c=
an hit the cache if it&#39;s already cached.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">For CE, we need to invalidate before the IB in the ker=
nel, because CE IBs can&#39;t do cache invalidations IIRC. This is the numb=
er one reason for merging the already pushed commits.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Marek</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Sat., Apr. 25, 2020, 11:03 Chri=
stian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">c=
koenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div>Was that patch set actually merged
      upstream? My last status is that we couldn&#39;t find a reason why we
      need to do this in the kernel.<br>
      <br>
      Christian.<br>
      <br>
      Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
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
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank" rel=3D"noreferrer">https://lists.freedesktop.org/mailman/listin=
fo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--00000000000011075405a426e26f--

--===============2090685347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2090685347==--
