Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC908C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 00:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6737F64E20
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 00:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6737F64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291E36E4A2;
	Mon,  1 Mar 2021 00:13:06 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C229C6E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 00:13:04 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id k22so8803574pll.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 16:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qo7vQhQCJd56TYBYwxBejw72UywV/1h6sfj8NvY0xPU=;
 b=tGhQwbSoOnhbk/ffRD/xKKwIDAPeOv/5hIqTBDW67xIzWbPDQ6SKZITxcEnITpJ8mM
 ayCtgtRVYyrMnRqavNhhf2YkLGyaaeHafOZIxnj+j41CupvwyMw7JM7qgrFRGMQqdczy
 qT9Witxym4oxA4pj0uSIez+oNat81SfbvWv1KPOk+hdqLLqA1BhOAT65k1CMTRF1p/MS
 5ZPGdqmeKbCa7BorHSgs1S3P2ggdia38n/RzNAszCidS2RbXX80p1IgE4luoXDmv2Ih5
 kYrwKbzwIPPQywg6LslvS8l/RY2a97w55801VK/L3ezEt5btRWvfAjiOrw9oJlbaxGJM
 hIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qo7vQhQCJd56TYBYwxBejw72UywV/1h6sfj8NvY0xPU=;
 b=CbzARbkDV8PswReg2Kuk7e4xhX6TLYyO+yASN8Bi9CxYuVtHnehfaJgKx4D0+tEI7t
 +vQ/N84Cri56+RjeNpW3IT3C2qg86DCFb02ptwpaX7+gOFBahAKP75tAuLwxLGo1uL42
 bCmeGVTEpPtkQDxZiIaZIVY1l9iZJDo54WjwN1KhRVS9KAlQS2pik1+8eLKNjaQ3TkY1
 PyPw2Fjr71lb4rraIZGpvhIn5Yq2PFOcRdXZbaOkrNJhC6+ONKiPXgYW2INEY79jWWge
 iMi3UZdPgXeJ+UAzHdXvtzxuCTBbDGSk5ZZQhQCMqsT5Pf+PRqG7YO1tCh2bzSJT2ywn
 B6HQ==
X-Gm-Message-State: AOAM533p1z736L+266TnioJM3tBAvRfqpGZmGhglphzpRrQKenCLUhan
 EHSe1QJZg0PbwM4pH6H5bogQKWMmGpRDwwDxyWE=
X-Google-Smtp-Source: ABdhPJwUC9BvwRu9mCNChfpZBUtCNQcoXRc/IS9BlrXnifDfGBDLkAW7ETkthmRLONZ9cx9BT4zF3B3gtVj3W1l+m6I=
X-Received: by 2002:a17:902:ac82:b029:e3:bca2:cca7 with SMTP id
 h2-20020a170902ac82b02900e3bca2cca7mr12621220plr.43.1614557584290; Sun, 28
 Feb 2021 16:13:04 -0800 (PST)
MIME-Version: 1.0
References: <CA+gx7UpBhKc0uwLhtN6ZVjWbMJuJYSJ9mQwk_fHtEikh6t3oRQ@mail.gmail.com>
 <CAD=4a=U0JqDAuA-U2BD6=Rp3eLBFkSNTsFNy+cQnUX9aJVfmOQ@mail.gmail.com>
 <CA+gx7UqiRXc8j8Ns=fV1bpqfCZnbadcStLVxA6muEFaDCDr1ww@mail.gmail.com>
In-Reply-To: <CA+gx7UqiRXc8j8Ns=fV1bpqfCZnbadcStLVxA6muEFaDCDr1ww@mail.gmail.com>
From: Adolfo Rodrigues <adolfotregosa@gmail.com>
Date: Mon, 1 Mar 2021 00:12:53 +0000
Message-ID: <CA+gx7Uqx4tzY5TB4tsKH+XWteaHh33qDm_KUTuwRWah-rmMKUA@mail.gmail.com>
Subject: Re: 6900XT HDMI 2.1 -> Missing 4K120Hz
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1838066045=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1838066045==
Content-Type: multipart/alternative; boundary="00000000000047f70105bc6e7b76"

--00000000000047f70105bc6e7b76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

xrandr --newmode "3840x2160_120.00" 1188.00 3840 4016 4104 4400 2160 2168
2178 2250 +hsync +vsync
xrandr --output HDMI-A-0 --mode "3840x2160_120.00"

output -> xrandr: Configure crtc 0 failed

HDMI output does not seam to be running at 2.1 specs...

On Sun, Feb 28, 2021 at 11:12 PM Adolfo Rodrigues <adolfotregosa@gmail.com>
wrote:

> atm, 5.10.0-14-generic (latest ofered by kubuntu 21.04 daily) but I did
> try 5.11.0-051100-generic from
> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11/ and no change.
>
> On Sun, Feb 28, 2021 at 11:06 PM Ernst Sj=C3=B6strand <ernstp@gmail.com> =
wrote:
>
>> Which kernel version are you running?
>>
>> Den s=C3=B6n 28 feb. 2021 kl 23:48 skrev Adolfo Rodrigues <
>> adolfotregosa@gmail.com>:
>>
>>> Hi.
>>> I cannot find a way to enable 4K @ 120Hz over hdmi 2.1. It seams limite=
d
>>> to HDMI 2.0b.. is it ?
>>>
>>> Under Windows 10 it works fine but not under linux. Why ?
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>

--00000000000047f70105bc6e7b76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:monospace"><span style=3D"color=
:rgb(0,0,0)">xrandr --newmode &quot;3840x2160_120.00&quot; 1188.00 3840 401=
6 4104 4400 2160 2168 2178 2250 +hsync +vsync</span><br>
</span><span style=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0=
)">xrandr --output HDMI-A-0 --mode &quot;3840x2160_120.00&quot;</span><br><=
/span><div><span style=3D"font-family:monospace"><span style=3D"color:rgb(0=
,0,0)"><br></span></span></div><div><span style=3D"font-family:monospace"><=
span style=3D"color:rgb(0,0,0)">output -&gt;=C2=A0</span></span>xrandr: Con=
figure crtc 0 failed</div><div><br></div><div>HDMI output does not seam to =
be running at 2.1 specs...</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 28, 2021 at 11:12 PM Adolfo Rod=
rigues &lt;<a href=3D"mailto:adolfotregosa@gmail.com">adolfotregosa@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr">atm,=C2=A0<span style=3D"font-family:monospace"><span st=
yle=3D"color:rgb(0,0,0)">5.10.0-14-generic (latest ofered by kubuntu 21.04 =
daily) but I did try=C2=A0</span></span>5.11.0-051100-generic from<font col=
or=3D"#000000" face=3D"monospace">=C2=A0</font><a href=3D"https://kernel.ub=
untu.com/~kernel-ppa/mainline/v5.11/" target=3D"_blank">https://kernel.ubun=
tu.com/~kernel-ppa/mainline/v5.11/</a>=C2=A0and no change.<br></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 2=
8, 2021 at 11:06 PM Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail=
.com" target=3D"_blank">ernstp@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmai=
l_default" style=3D"font-family:arial,helvetica,sans-serif">Which kernel ve=
rsion are you running?<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Den s=C3=B6n 28 feb. 2021 kl 23:48 skrev Ad=
olfo Rodrigues &lt;<a href=3D"mailto:adolfotregosa@gmail.com" target=3D"_bl=
ank">adolfotregosa@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr">Hi.<div>I cannot find a way to enabl=
e=C2=A04K @ 120Hz over hdmi 2.1. It seams limited to HDMI 2.0b.. is it ?</d=
iv><div><br></div><div>Under Windows 10 it works fine but not under linux. =
Why ?</div><div><br></div><div><br></div></div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--00000000000047f70105bc6e7b76--

--===============1838066045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1838066045==--
