Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB777C55186
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 00:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A354206DD
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 00:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4WgPkaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A354206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F496E28E;
	Sun, 26 Apr 2020 00:28:59 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E81C6E28E
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 00:28:57 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id h69so6706715pgc.8
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2020 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/QJQvON39fOo05U+yuXZXnfw1eX3Ddo+30MPLY813D4=;
 b=R4WgPkaQb9q7ihEKvpAD2RSVHYqRF0TdSbAGInlMkGvP4JEyL9Yz0erhAjuxbgNtKm
 S8ySiXwJhqWgvfpE0zIkbXDCB2ez2h6d3B9iqNjPAr1PDGWAUjmenNT5AfsfiyB2PpNB
 gf/xm6FYZLw/gAySrD1+Jnnywpb1jCxVTwDgIjDAa4praBssY9xAfMg37UXt7yTlAu5W
 NtMI4WGHlrEjFCGMIZZR4dCtcs2pC/x3HM59FNsEcEXGpb3XKoQcYTqo550W3HNngf2N
 ueU04FT7JYDDhEw9LjO8U6EeyJ6CkfBoRc8CiEI399hpG6Ek9x5c3nnPx9sa9YFCAU2s
 ypZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/QJQvON39fOo05U+yuXZXnfw1eX3Ddo+30MPLY813D4=;
 b=YYMJh5HEIko0q/oaZWYIL2cLQSThJs2Gb7vzR+zYGfDhNDbfKi/I6cEl+aaDnNp3aE
 hLqPsgI+z/WtWCNI4IbJ7NDYWOzWcqiHP7QKcaNqMU6xRmBm/F9mwQcrX/Np2nplNQ7Q
 STvP7KCYaKtD7YbugYoa2otSyUGRux8PYT/uabZyfZhJzwV1J8FTQ7sCkUBVnDgm4I5I
 oeITI92onBeLNKS5MZt/8smKVptkZv7fRrAf4ShLMwvhb9/jRiqcPr35UHy+bCeR0nFW
 edUBabOBGXJr9DZplw7YfvtFcEE3w/yEOGWYWyXlDHfiQeCl98ew79rinZWXCidqFlSE
 10xw==
X-Gm-Message-State: AGi0PubNQ54IyPY7mO2ZFLCB3y5HkS+70IBwZ471gQP07mxkt7AhuIs3
 PkCJdtrAEi+VzcFPEOkPFO9igWyBLgO4ClwC19g=
X-Google-Smtp-Source: APiQypKjJd0V8zfDvb/aTT/z9mp12qOg3N4JpkWPdLm9Ws7ODUFc3626FVGTOWgBqXTALn+jr/e/xIo90LJphd9Dkrg=
X-Received: by 2002:a63:da10:: with SMTP id c16mr16413430pgh.208.1587860936897; 
 Sat, 25 Apr 2020 17:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
 <71c2f3e9-a734-5887-b5ce-7fa8b011d372@gmail.com>
In-Reply-To: <71c2f3e9-a734-5887-b5ce-7fa8b011d372@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 25 Apr 2020 20:28:45 -0400
Message-ID: <CAAxE2A67RM1e0Xs2fTcDPm0eTyd4EvdH2vqPsVXWEODL=Dk4zw@mail.gmail.com>
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0273096494=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0273096494==
Content-Type: multipart/alternative; boundary="00000000000018b7f605a426afe9"

--00000000000018b7f605a426afe9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not without a mandatory firmware update. The gcr packet support for IBs was
added into the sdma firmware just two weeks ago.

Marek

On Sat., Apr. 25, 2020, 11:04 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

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
p.org/mailman/listinfo/amd-gfx
>
>
>

--00000000000018b7f605a426afe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Not without a mandatory firmware update. The gcr packet s=
upport for IBs was added into the sdma firmware just two weeks ago.<div dir=
=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Sat., Apr. 25, 2020, 11:04 Christian K=C3=B6nig, &lt;<a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div>Could we do this in userspace as well?<br>
      <br>
      Am 25.04.20 um 10:52 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
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

--00000000000018b7f605a426afe9--

--===============0273096494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0273096494==--
