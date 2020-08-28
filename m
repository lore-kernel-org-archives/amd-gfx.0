Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBEFC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 12:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2017C2078A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEXF7p+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2017C2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4ACE6E4A1;
	Fri, 28 Aug 2020 12:41:59 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D8D6E4A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:41:57 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id h19so1106901ljg.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+AXyLde/McwZE68yzUwRnxRscooo0bLcFKX0N91aaRk=;
 b=hEXF7p+9K4QDhtHlKh49Sw65dqUnt6qCnG0PA4YdxW6Y8k8VgCEB7kVYyd5XuYrzrJ
 m8Xu6HlO+ReqDwW0WoE/VH/1topdu9qcEOSxhivAS3TDw14rHlqnB6Ys0cKtM0GZDBwp
 rfADTuWukF8QkErKfvA4lQsBm3DhWMS7Yw1CD0xn5eV4djKQyFsD9PVKRNq0Z0JCYJNU
 YkAylksl4GBQXwUiSOdHJ02jepSLL+4oxMuhFHJe9nNdr+RE7vKGELWDWJ0WU0711yU4
 9UZwn36G5R522hdkxyvpyO6xavVuEqyc2Y0cmYq0r+cL0FD7MD6WF/p76Df+RbQR+5sG
 Eh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+AXyLde/McwZE68yzUwRnxRscooo0bLcFKX0N91aaRk=;
 b=PLJZ7sahY8x4DsQZR6vYOlMr634WbzkGaFg3T4myThtzrGlac/mKffbLoSeFFAONYf
 Rc7OaZ9kbHg4NucAftbw4N2JRkCLRruuGXTOzKjM2m6HNo8HC+dy41y3Ru6dHNIK5f50
 Tkr8vnZIL5HbaMMsjtmCddoAbA33qakPCowi9yzME+DfojY2K5bTwH+dqgtugRS489iG
 BYmk2h5DSVj5tABOdEp/XZ00iLPl4tccZdtMkiriBRJRgdmjWZ9ZB4jStkaUZ1bR2FlL
 BpdSKTLu/tLr4UseO4Eeu2aXJ692GyX2xdoTX5uanihND0dJU7LnIRXdyPzScr2uXb70
 r0wQ==
X-Gm-Message-State: AOAM533pleyXbv6xBOLNnudB+n++lmVGXYJaj3rIo923EYmxHt3pZ6Db
 YhfA9xWl3dMNvFDrRWQHR8JiUb8LCDykC4aV+ys=
X-Google-Smtp-Source: ABdhPJyvt6gVEBUmJd76B/h25INpBxuVQIJEQvtfmi8LrtnT9wsh3AsHRqGy8qC223pkAR7ruUa45uVvdI7nYuQLIW4=
X-Received: by 2002:a2e:86d9:: with SMTP id n25mr882405ljj.444.1598618516247; 
 Fri, 28 Aug 2020 05:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <5eb9e79.42da.1742ef91f76.Coremail.erdong2018@163.com>
 <CAAzXoRJ+S6qaE_UaN0gNtkHPQcp+toMcUA1-8fLhU37rDdHyRQ@mail.gmail.com>
 <3ffa3550.11d0.17432bbbc3a.Coremail.erdong2018@163.com>
In-Reply-To: <3ffa3550.11d0.17432bbbc3a.Coremail.erdong2018@163.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Fri, 28 Aug 2020 08:41:45 -0400
Message-ID: <CAAzXoR+Lx9C1X9MGnGjnNjV1u8ExEdwE9OiSja2XenqqC71vdA@mail.gmail.com>
Subject: Re: Re: 0001-Fix-a-array-bound-overflow-bug-in-function-umr_clock
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
Content-Type: multipart/mixed; boundary="===============0823467338=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0823467338==
Content-Type: multipart/alternative; boundary="000000000000cad95905adef6061"

--000000000000cad95905adef6061
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, applied!

In future patches can you please add a Signed-off line (e.g. use "-s" with
git when forming the commit).

Tom

On Thu, Aug 27, 2020 at 9:43 PM =E5=BC=A0=E4=BA=8C=E4=B8=9C <erdong2018@163=
.com> wrote:

> Yes, you are right. New patch is in attachment.
>
> thanks.
>
>
>
>
>
>
> =E5=9C=A8 2020-08-28 01:14:02=EF=BC=8C"Tom St Denis" <tstdenis82@gmail.co=
m> =E5=86=99=E9=81=93=EF=BC=9A
>
> isn't a better fix to simply delete the line?  The print seems redundant
> to me.
>
> Tom
>
> On Thu, Aug 27, 2020 at 9:27 AM =E5=BC=A0=E4=BA=8C=E4=B8=9C <erdong2018@1=
63.com> wrote:
>
>>
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
>
>

--000000000000cad95905adef6061
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, applied!<div><br></div><div>In future patches can =
you please add a Signed-off line (e.g. use &quot;-s&quot; with git when for=
ming the commit).<br><div><br></div><div>Tom</div></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 27, 202=
0 at 9:43 PM =E5=BC=A0=E4=BA=8C=E4=B8=9C &lt;<a href=3D"mailto:erdong2018@1=
63.com">erdong2018@163.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div style=3D"line-height:1.7;color:rgb(0,0,0);fo=
nt-size:14px;font-family:Arial"><div style=3D"margin:0px">Yes, you are righ=
t. New patch is in attachment.</div><div style=3D"margin:0px"><br></div><di=
v style=3D"margin:0px">thanks.</div><p style=3D"margin:0px"><br></p><p styl=
e=3D"margin:0px"><br></p><p style=3D"margin:0px"><br></p><p style=3D"margin=
:0px"><br></p><div style=3D"zoom:1"></div><div id=3D"gmail-m_87353949788937=
09641divNeteaseMailCard"></div><p style=3D"margin:0px"><br></p><p>=E5=9C=A8=
 2020-08-28 01:14:02=EF=BC=8C&quot;Tom St Denis&quot; &lt;<a href=3D"mailto=
:tstdenis82@gmail.com" target=3D"_blank">tstdenis82@gmail.com</a>&gt; =E5=
=86=99=E9=81=93=EF=BC=9A</p><blockquote id=3D"gmail-m_8735394978893709641is=
ReplyContent" style=3D"padding-left:1ex;margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204)"><div dir=3D"ltr">isn&#39;t a better fix to si=
mply delete the line?=C2=A0 The print seems redundant to me.<div><br></div>=
<div>Tom</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Aug 27, 2020 at 9:27 AM =E5=BC=A0=E4=BA=8C=E4=B8=9C=
 &lt;<a href=3D"mailto:erdong2018@163.com" target=3D"_blank">erdong2018@163=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div style=3D"line-height:1.7;color:rgb(0,0,0);font-size:14px;font-fami=
ly:Arial"><p style=3D"margin:0px"><br></p></div><br><br><span title=3D"nete=
asefooter"><p>=C2=A0</p></span>____________________________________________=
___<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>
</blockquote></div><br><br><span title=3D"neteasefooter"><p>=C2=A0</p></spa=
n></blockquote></div>

--000000000000cad95905adef6061--

--===============0823467338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0823467338==--
