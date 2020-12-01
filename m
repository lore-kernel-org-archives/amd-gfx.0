Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F4C64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 11:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E7620705
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiqU41up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E7620705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF9F6E530;
	Tue,  1 Dec 2020 11:28:41 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5836E530
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 11:28:40 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id e25so4269216wme.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 03:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5wmkCLBXa3aOfd7n/TWZxVYpMUnl3yIaDOcs4kM0Ypo=;
 b=OiqU41up+qhyFEgim7DeNeHc8bm7z7CqRfeBL09Egp59h3s3jBYaF0HoJSRdUJH8Yp
 H+d3+gqyZpo3KRt1aFah12INi/9IWP5aLl7TdLBg/qr93/9mAfDeYk51qtnxSQFti6kg
 tAz2tGP1jYRBlhqKf8bGq0CrRbRb+zGd4mASDwfbwCyNenRxjT96ezGxDaMwTGVM0etd
 J8mjsHRzTsZOdz5oMRQSkX5bmovr06aEouDfToUaEGHncCstciVA9zGaUEjydCbiPyDU
 Qoxt6LmIeZfU8vkYiygK48NmGF8ugTIUrBN28r1cDDCOknw2nsOSKNyxKGU/D2ex911h
 D9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5wmkCLBXa3aOfd7n/TWZxVYpMUnl3yIaDOcs4kM0Ypo=;
 b=TvKVWblkITC4GTyFnpYCxbAcjgoTOJL0Vd012LQOvP7BvlDtaBducssQ57cfGfdhzK
 mPlVc1W20Ad94ol2WcTk8GVU8IqvbVpvCjLL0Cdm1W7IuE47J1y0bdliZ3ZOhiTOTFar
 tztyVq5QyimjRDv9UFjQvVNbQTW6ZhUrbZZriZE8vujcusIbHBx85pABGksSb5tmuTXH
 Z2sGX5gHWNuF65Zi9mFa7y3N1rmSKHx8STZrVRirnP7tPUuzGyWUIeHt+uD1wM29uPfx
 D7+QKZV8rWTmK6CvsKd/35Q8Bd0xmo0GQphs8ONAAYMeoEdSSXQ/NFKwfaIFjUBnso3G
 bZ9w==
X-Gm-Message-State: AOAM5303wt59N9g5LtsjmY2ozKfw5qSchn+1vIuHe54H8dM3AKDeWP9x
 Bpjj+pWGm897z5aURK7U9KFHVgn/tu0TT93OjZevqjkt7RY=
X-Google-Smtp-Source: ABdhPJztaMJTo2fTvSuYNHXrhwhksSOqz572z3my30a792yqGskrVHk93MYIxFkKm6ccODO7ej5Y42cyQCwphSZu6VE=
X-Received: by 2002:a1c:4802:: with SMTP id v2mr2220354wma.13.1606822118887;
 Tue, 01 Dec 2020 03:28:38 -0800 (PST)
MIME-Version: 1.0
References: <CAGztBWUy6a8oB9PuF3YmqKN0DdqXixTmxThyK0+BwTMFWYtTww@mail.gmail.com>
 <ee60c997-1c5c-cda1-74da-ed40c3ce6dcf@gmail.com>
In-Reply-To: <ee60c997-1c5c-cda1-74da-ed40c3ce6dcf@gmail.com>
From: Smith John <ls.cat.kth@gmail.com>
Date: Tue, 1 Dec 2020 19:28:27 +0800
Message-ID: <CAGztBWVOhbMnjo7vGmCAa6LPN0USK9GneWyw8LaDJPeeK_x66g@mail.gmail.com>
Subject: Re: [amdgpu] Is it possible to disable page tables and use the
 physical address directly in amdgpu
To: christian.koenig@amd.com
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0058697925=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0058697925==
Content-Type: multipart/alternative; boundary="0000000000009d16b805b5656dc7"

--0000000000009d16b805b5656dc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Christian,
Thanks for your reply. I agree with you that the VMID0 is special and
remapping is important. I was not sure if different VIMDs could have
different settings, such as enable/disable page tables.
Or to put it another way, I was wondering if the hardware supports purely
physical addressing like the real mode in CPUs, or page tables are
essential for the hardware.
More specifically, assuming it supports "real mode", to copy things from A
to B, one could allocate rings which are accessible by MMIO and fill sdma
packets using physical address to transfer data.

Regards,
Smith

Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com> =E4=BA=8E2020=E5=B9=
=B412=E6=9C=881=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:50=E5=86=99=
=E9=81=93=EF=BC=9A

> Am 01.12.20 um 07:58 schrieb Smith John:
>
> Hello!
> I was trying to figure out the impact of gpu page tables on applications'
> performance. I noticed that there are 16 vmids supported by the hardware =
*Vega
> 10*. Is it possible to use physical address directly in some vmids, or
> use physical address globally?
>
>
> No. VMID0 is used by the kernel for jobs like copying things from A to B
> and even there we use the VM remapping functionality.
>
> Regards,
> Christian.
>
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--0000000000009d16b805b5656dc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0Hi Christian,<div>Thanks for your reply. I agree wit=
h you that the VMID0 is special and remapping is important. I was not sure =
if different=C2=A0VIMDs could have different=C2=A0settings, such as enable/=
disable page tables.=C2=A0</div><div>Or to put it another way, I was wonder=
ing if the hardware supports purely physical addressing like the real mode =
in CPUs, or page tables are essential for the hardware.</div><div>More spec=
ifically, assuming it supports &quot;real mode&quot;, to copy things from A=
 to B, one could allocate rings which are accessible by MMIO and fill sdma =
packets using physical address to transfer data.</div><div><br></div><div>R=
egards,</div><div>Smith</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Christian K=C3=B6nig &lt;<a href=3D"mailto:ck=
oenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; =
=E4=BA=8E2020=E5=B9=B412=E6=9C=881=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=
=8D=885:50=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <div>Am 01.12.20 um 07:58 schrieb Smith
      John:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">Hello!
        <div>I was trying to figure out the impact of gpu page tables on
          applications&#39; performance. I noticed that there are 16 vmids
          supported by the hardware <i>Vega 10</i>. Is it possible to
          use physical address directly in some vmids, or use physical
          address globally?</div>
      </div>
    </blockquote>
    <br>
    No. VMID0 is used by the kernel for jobs like copying things from A
    to B and even there we use the VM remapping functionality.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
      </div>
      <br>
      <fieldset></fieldset>
      <pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--0000000000009d16b805b5656dc7--

--===============0058697925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0058697925==--
