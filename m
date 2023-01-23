Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABE8C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 12:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D48289304;
	Mon, 23 Jan 2023 12:34:50 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3ABC89304
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 12:34:47 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id s66so10203045oib.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 04:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G3rQqGHw0Jqqq/ijPJ2bBZwqfvHf9oKa4/Q7+rIGJts=;
 b=P6AxIo+0fHvVtWbFgMnSLXo56j7Gooq+ZJyuiUa2ytMf0Ff5IZY8VvOmSJ41NBSvV+
 wsJ47VFqEhom785BmomxNpcsMQjINUR1zpa7C4zl2o1YlgVP1xqusC1nw/GmyFZmNInl
 6B6NXXSk6wc/lxG5Y7L5/HzbuVEdRvgJMceY2TFSkfiqfnjnNaGRRXc7/Lx1m45ieq23
 Wp9o/+QlvO7c1b1mwl7J356SjrSh71zsnrpAQcuYrypVo9hZwcQe3dlXADurWYzOVizw
 M/T2zkPB3eNYQTb6n3V/kLcChwO5yy+jGT1R+fMGAnUJRMgs7iARqpoEHTV+YN1SmtjR
 YKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G3rQqGHw0Jqqq/ijPJ2bBZwqfvHf9oKa4/Q7+rIGJts=;
 b=OvJmYlSROTUnfmduFFf+ar/xJf8QCQ/ajBj1QyanXWkbZCpPdMAnquYGCHtyM6MTIN
 iBW9Tlbl5qtgN3hHp19CgGhTVDeHplWsbBOgfwdLUcmrqA8VLBYtwC9i90gz+7oKWtno
 75rwNTFOOnb7jqVsjBLVwqwvMgi25FsHbG8I2aHFY5OqLHGhMKOg6Q5jh0BPCUwn+UDs
 woBHrauvXtpWOLozv1pPMW/VmQCuHm3wem3XlCGdTem28/zs7S3i4UBmUofvDuwxEqF0
 cjjOe8Mp3KWQIdzqyAJY1Xmz3D31sAoCnqqRp88tWwTa18pAiHlFui9u1LHt0rrWjWIF
 aiAA==
X-Gm-Message-State: AFqh2koCBYE5pRmmFp3D+GBa7P1R2BrdWtYI56/yldSXqQEfVezhYRHf
 vaQPZNmqJRUG9LyZaZsmltaP6vfE3pf+DW0K32w=
X-Google-Smtp-Source: AMrXdXtIN5ckjS4CVnOwSJ6MZi0LxYsagO8Mk2831aZRWgj8UdCfDK+Wz/WshcsWofiLEPidF02s3u2dG9ZThnvcRls=
X-Received: by 2002:a05:6808:91:b0:363:ea5c:6d40 with SMTP id
 s17-20020a056808009100b00363ea5c6d40mr1183160oic.273.1674477286819; Mon, 23
 Jan 2023 04:34:46 -0800 (PST)
MIME-Version: 1.0
References: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
 <CAD=4a=WuexXdWwRQXby0KnG=AQnR0fXsJAu=dNABU4irNgTdBg@mail.gmail.com>
 <0bca54ad-3626-a3f6-fdfd-09b1d0718564@tilda.center>
In-Reply-To: <0bca54ad-3626-a3f6-fdfd-09b1d0718564@tilda.center>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 23 Jan 2023 13:34:35 +0100
Message-ID: <CAD=4a=V3bbhU_QOqF5r9Yzg-OUq0t3uX2eS=qZHWFsm6ain6_g@mail.gmail.com>
Subject: Re: Minimal kernel version for 7900XT
To: =?UTF-8?B?R29yYW4gTWVracSH?= <meka@tilda.center>
Content-Type: multipart/alternative; boundary="000000000000dd8cc705f2ed9f13"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000dd8cc705f2ed9f13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah you were looking at the packaged driver installer (usually called
"Proprietary" even though most of it is not).
It will install extra modules so it works with "any" kernel.

For the upstream Torvalds support I guess you end up in the
CHIP_IP_DISCOVERY clause, it's a new method for new cards.

//Ernst

Den m=C3=A5n 23 jan. 2023 kl 12:47 skrev Goran Meki=C4=87 <meka@tilda.cente=
r>:

> On 1/23/23 12:28, Ernst Sj=C3=B6strand wrote:> 6.0 should be enough:
>  > https://www.phoronix.com/review/rx7900xt-rx7900xtx-linux
>  > <https://www.phoronix.com/review/rx7900xt-rx7900xtx-linux>
>  >
>  > The firmware files is maybe the most complicated part right now...
>  >
>  > //Ernst
> I found that article, too, but what is confusing are two things:
> * SLES 15 SP 4 doesn't run on 6.0 but 5.14.21
> * Why is there no PCI ID in the kernel source?
>
> Hence my request for help understanding how it even works.
>
> Regards,
> meka
>

--000000000000dd8cc705f2ed9f13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Ah you were looking at the packaged driver installer (u=
sually called &quot;Proprietary&quot; even though most of it is not).</div>=
<div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-seri=
f">It will install extra modules so it works with &quot;any&quot; kernel.</=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">For the upstream Torvalds support I guess you end up in=
 the CHIP_IP_DISCOVERY clause, it&#39;s a new method for new cards.</div><d=
iv class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"=
><br></div><div class=3D"gmail_default" style=3D"font-family:arial,helvetic=
a,sans-serif">//Ernst<br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Den m=C3=A5n 23 jan. 2023 kl 12:47 skrev Gor=
an Meki=C4=87 &lt;meka@tilda.center&gt;:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 1/23/23 12:28, Ernst Sj=C3=B6strand wrote:&gt; =
6.0 should be enough:<br>
=C2=A0&gt; <a href=3D"https://www.phoronix.com/review/rx7900xt-rx7900xtx-li=
nux" rel=3D"noreferrer" target=3D"_blank">https://www.phoronix.com/review/r=
x7900xt-rx7900xtx-linux</a><br>
=C2=A0&gt; &lt;<a href=3D"https://www.phoronix.com/review/rx7900xt-rx7900xt=
x-linux" rel=3D"noreferrer" target=3D"_blank">https://www.phoronix.com/revi=
ew/rx7900xt-rx7900xtx-linux</a>&gt;<br>
=C2=A0&gt;<br>
=C2=A0&gt; The firmware files is maybe the most complicated part right now.=
..<br>
=C2=A0&gt;<br>
=C2=A0&gt; //Ernst<br>
I found that article, too, but what is confusing are two things:<br>
* SLES 15 SP 4 doesn&#39;t run on 6.0 but 5.14.21<br>
* Why is there no PCI ID in the kernel source?<br>
<br>
Hence my request for help understanding how it even works.<br>
<br>
Regards,<br>
meka<br>
</blockquote></div>

--000000000000dd8cc705f2ed9f13--
