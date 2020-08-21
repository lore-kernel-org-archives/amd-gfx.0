Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52DC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 14:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBBD2078B
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtYRsq52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBBD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FE56E9BF;
	Fri, 21 Aug 2020 14:32:46 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6846E992
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 14:32:45 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id i10so2100594ljn.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JcUMJ9UGKLnvFXH+CjdMZ8e/TFAT9AHxotCTJsnIXeQ=;
 b=LtYRsq52JocK6N5k2Tp0Xkf70uLYZmqsW6DIx5yjz++1MIaPF8h6Ii0GO68ApZrITp
 bmoulcV9kvfe1OzBPt0yv4Jy6PWac/jex7CTubkWDdXzn4ryJLTIoWZqmWuhOknoFFLi
 t9wjOx4Iiw0Z70p4Y4NwJdwGfQIg3dji1tsTxrbRs+gQhDBgqQ5LyUcYCccp88YMk+9F
 WmCGSS8cR+TQ+0tWUR6/Sh4VaQqe6V0+PFcGndRaoCz/U4Kywj9owxRjSikMniEa1tkx
 I8ZjQ2oR3wkUPvJman7Nu5tTwYtbSdfKwNwN+RX6usCBTx9rh0kHTxuaWqxnlBWc4tVT
 DVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JcUMJ9UGKLnvFXH+CjdMZ8e/TFAT9AHxotCTJsnIXeQ=;
 b=Tv0pQq6aYOotyVhMj8rCfe1gq60j9NrfVVJPQFeUegoNfRT8qlrfMxgGN0a3MqXbuK
 HGwXyjRfElpBbnGAskvhhwSu0OoeGlNfNeObchedAot/uilrAQZoI6v/XQe4va4SYxyE
 a/sf0/8A5IRW8QUdQxru50ThJgQte5Pltd09E74g2brwwcumPAeW+PgPfdqnT4oksOmK
 wGIJov28efVHZo+TBwhMY4gc9b7z04kZ64MJKwkEK8q62/Ji3ZLhMeYRk0L8UuLa1UMR
 4tDoaOn3YpAkAj0hFX1LmsHVEw4Ej7pAlQNajpdOjJMcQOBqUEgT7T37CRA0Ci1hp7Ok
 A7WQ==
X-Gm-Message-State: AOAM533d3EeP8h5O0Z3QLjQUE/se1vkV0oROI/kSjtkIgwouR+d2nQhy
 QVOZqV9fcj4030lHqzAOhNjA5u9AnOAx91npmow=
X-Google-Smtp-Source: ABdhPJwIkvsrC2++EkzYHO9bUVjFhQaWqagSdvLLwSyC8rsOHW3z0bRpzzny5bgHB02jvCaRnzxqRvKeqJYXwpdlPmY=
X-Received: by 2002:a2e:320c:: with SMTP id y12mr1558180ljy.399.1598020363651; 
 Fri, 21 Aug 2020 07:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <376916b5.1ca1.173eac3f3c4.Coremail.erdong2018@163.com>
In-Reply-To: <376916b5.1ca1.173eac3f3c4.Coremail.erdong2018@163.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Fri, 21 Aug 2020 10:32:32 -0400
Message-ID: <CAAzXoRKDBHB2n-4ewjzrz=SP3YJkBc9ofgc5ghhYsqzrdZA9fg@mail.gmail.com>
Subject: Re: Fix a memory leak bug for umr tool.
To: =?UTF-8?B?5byg5LqM5Lic?= <erdong2018@163.com>
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
Content-Type: multipart/mixed; boundary="===============0125415226=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0125415226==
Content-Type: multipart/alternative; boundary="0000000000001e8fe505ad641ced"

--0000000000001e8fe505ad641ced
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry I missed this.  I've applied it (with whitespace fixes) and pushed it
out to main yesterday.

Cheers,
Tom

On Thu, Aug 13, 2020 at 10:57 PM =E5=BC=A0=E4=BA=8C=E4=B8=9C <erdong2018@16=
3.com> wrote:

> Hi:
>        The function umr_pm4_decode_ring_is_halted call umr_read_ring_data
>
>     to get ringdata, umr_read_ring_data will alloc memory to store ring
>
>     data and return the memory pointer to umr_pm4_decode_ring_is_halted, =
So
>     the memory should be free in umr_pm4_decode_ring_is_halted.
>
> Thanks.
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000001e8fe505ad641ced
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry I missed this.=C2=A0 I&#39;ve applied it (with white=
space fixes) and pushed it out to main yesterday.<div><br></div><div>Cheers=
,</div><div>Tom</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Aug 13, 2020 at 10:57 PM =E5=BC=A0=E4=BA=8C=E4=
=B8=9C &lt;<a href=3D"mailto:erdong2018@163.com">erdong2018@163.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div sty=
le=3D"line-height:1.7;color:rgb(0,0,0);font-size:14px;font-family:Arial"><d=
iv style=3D"margin:0px">Hi:=C2=A0</div><div style=3D"margin:0px">=C2=A0=C2=
=A0 =C2=A0 =C2=A0 The function umr_pm4_decode_ring_is_halted call umr_read_=
ring_data</div><p style=3D"margin:0px">=C2=A0 =C2=A0 to get ringdata, umr_r=
ead_ring_data will alloc memory to store ring</p><p style=3D"margin:0px">=
=C2=A0 =C2=A0 data and return the memory pointer to umr_pm4_decode_ring_is_=
halted, So</p><div style=3D"margin:0px">=C2=A0 =C2=A0 the memory should be =
free in umr_pm4_decode_ring_is_halted.</div><div style=3D"margin:0px"><br><=
/div><div style=3D"margin:0px">Thanks.</div></div><br><br><span title=3D"ne=
teasefooter"><p>=C2=A0</p></span>__________________________________________=
_____<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000001e8fe505ad641ced--

--===============0125415226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0125415226==--
