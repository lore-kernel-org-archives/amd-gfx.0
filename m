Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B072EC33CB2
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 08:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC30206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 08:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC30206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rixotstudio.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DE26FAA7;
	Fri, 31 Jan 2020 08:05:40 +0000 (UTC)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD356FA4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:55:56 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id g17so6286267wro.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 14:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=J48ABnNjaJM7BdxTPawSLkh6cVcS/95Y5aLqXkJpQIo=;
 b=ercz3B/JO+lQn/txpAKGzH4Z6ZPMtiptPJ6VBRgzHaS0pe08+3e8dgvabE4H6bkUF3
 MLTb/Er3AqumU6YiFm7FSklbQrdqBjGEuAKDylwRkpj2UYwoyBNaNTJCODNR6pV0aLO6
 M0dk4z3TeLqJOnzAM9TsIzkGc5Jw+AYFr70d4ljHHhA19NyioH8FPu6bsTGGaVIbqtPM
 EGEHeE9uBSknaeQS+Nm/8Ck0L3OzAt2JBvd5htciPVP7Oz1syvnL85W3Jv6UlWbCcYKm
 jK5hNMR6k9R12dSr7v0+4GIWIhW0WgiD6Z/rl97NyEnOhGAmE6TQ/OY0xw3Sb/sXIJ3t
 +pGg==
X-Gm-Message-State: APjAAAWFtsaFwCypQ2B4+b4hFLu47HA2Wpmck8puOTnMqf6Eh79YaJ6v
 RxcYCNKZwNfM4XWwAzSuPe7nqn7FfmsQpVI5IYUAQg==
X-Google-Smtp-Source: APXvYqxetxuSNpE0xIf9QuRiIA6pwjE8FMy80qJsvfrP309zWQ+73IbGW3qwSqZSm9Zb7qMyuCHsVGu7Xdc2PM789iw=
X-Received: by 2002:adf:8b19:: with SMTP id n25mr2962498wra.164.1580424955058; 
 Thu, 30 Jan 2020 14:55:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPA_gs6evUkUbPipQ4=BTH9R9ZWDZimZpTYbOBus+i=AZZDnyw@mail.gmail.com>
 <DM5PR1201MB25540C0A23067345E620DA6C9E040@DM5PR1201MB2554.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB25540C0A23067345E620DA6C9E040@DM5PR1201MB2554.namprd12.prod.outlook.com>
From: Jacob Hrbek <kreyren@rixotstudio.cz>
Date: Thu, 30 Jan 2020 23:55:28 +0100
Message-ID: <CAPA_gs7yCq3zg-wosrnczLCcAoRm2NX6ymM3mXxbErqX3EKahw@mail.gmail.com>
Subject: Re: Suspecting corrupted VBIOS after update of AMDGPU on AMD7870
To: "Liu, Zhan" <Zhan.Liu@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Fri, 31 Jan 2020 08:05:39 +0000
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
Content-Type: multipart/mixed; boundary="===============1113310707=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1113310707==
Content-Type: multipart/alternative; boundary="0000000000000a6fa4059d635c64"

--0000000000000a6fa4059d635c64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

*Hello Zhan,*

Here is it:
https://gist.githubusercontent.com/Kreyren/e35587d8710e63e511e69d8653fd996b=
/raw/628df1c76ff99adab1d2161e6a20f631de101d5c/gistfile1.txt

Note that I'm updating previous gists with new findings (
https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7).

If relevant i'm also getting these 'Green dots' at the initialization of
bios (https://linx.li/s/8j3poh2z.png).
These dots are not present anywhere else and were not present before said
update.

*Thanks,*
- Jacob Hrbek

On Thu, Jan 30, 2020 at 8:10 PM Liu, Zhan <Zhan.Liu@amd.com> wrote:

> Hi Jacob,
>
>
>
> Thant you for your bug reporting.
>
>
>
> I saw you attached xorg.log, which is great. Could you also grab dmesg.lo=
g
> via SSH?
>
>
>
> Thanks,
>
> Zhan
>
>
>
>
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *Ja=
cob
> Hrbek
> *Sent:* 2020/January/30, Thursday 12:18 PM
> *To:* amd-gfx@lists.freedesktop.org
> *Subject:* Suspecting corrupted VBIOS after update of AMDGPU on AMD7870
>
>
>
> *Hello,*
>
> I believe that system update that included amdgpu on debian testing (but =
i
> am on LFS) corrupted my VBIOS on AMD7870 (+- 4 hours after the update the
> GPU using AMDGPU/Radeon drivers resulted in no output).
>
> i'm sending this email to inform about possible bug with my findings on
> https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgist=
.github.com%2FKreyren%2F3e55e9a754e58956e1690e38b1888de7&data=3D02%7C01%7Cz=
han.liu%40amd.com%7C01e9bc8278a74c4d215d08d7a5ab67d0%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637160028350519449&sdata=3DpIqR4bR1m50HNG8QSVBJyp75Z=
2PtoUgNBbLjklilvRs%3D&reserved=3D0>
> and i would appreciate any help in excluding VBIOS corruption from the
> diagnostics.
>
> *Thanks,*
>
> - Jacob Hrbek
>

--0000000000000a6fa4059d635c64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)"><b>Hello Zhan,=
</b><br><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,=
sans-serif;font-size:large;color:rgb(0,0,0)">Here is it:<br><a href=3D"http=
s://gist.githubusercontent.com/Kreyren/e35587d8710e63e511e69d8653fd996b/raw=
/628df1c76ff99adab1d2161e6a20f631de101d5c/gistfile1.txt" rel=3D"nofollow" t=
arget=3D"_blank">https://gist.githubusercontent.com/Kreyren/e35587d8710e63e=
511e69d8653fd996b/raw/628df1c76ff99adab1d2161e6a20f631de101d5c/gistfile1.tx=
t</a><br></div></div><div><br></div><div><div style=3D"font-family:tahoma,s=
ans-serif;font-size:large;color:rgb(0,0,0)" class=3D"gmail_default">Note th=
at I&#39;m updating previous gists with new findings (<a href=3D"https://gi=
st.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7)." target=3D"_blank"=
>https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7).</a><br>=
</div></div><div><br></div><div style=3D"font-family:tahoma,sans-serif;font=
-size:large;color:rgb(0,0,0)" class=3D"gmail_default"></div><div style=3D"f=
ont-family:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)" class=3D"gma=
il_default">If relevant i&#39;m also getting these &#39;Green dots&#39; at =
the initialization of bios (<a href=3D"https://linx.li/s/8j3poh2z.png" targ=
et=3D"_blank">https://linx.li/s/8j3poh2z.png</a>).<br>These dots are not pr=
esent anywhere else and were not present before said update.<br></div><br><=
div style=3D"font-family:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)=
" class=3D"gmail_default"><b>Thanks,</b><br></div><div style=3D"font-family=
:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)" class=3D"gmail_default=
">- Jacob Hrbek</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jan 30, 2020 at 8:10 PM Liu, Zhan &lt;<a href=3D"ma=
ilto:Zhan.Liu@amd.com" target=3D"_blank">Zhan.Liu@amd.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div>
<p class=3D"MsoNormal">Hi Jacob,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thant you for your bug reporting.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I saw you attached xorg.log, which is great. Could y=
ou also grab dmesg.log via SSH?<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
<p class=3D"MsoNormal">Zhan<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-color:currentcolor currentcolor currentcolor blue;bord=
er-style:none none none solid;border-width:medium medium medium 1.5pt;paddi=
ng:0in 0in 0in 4pt">
<div>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org" target=3D"_blank">amd-gfx-bounces@lists.freed=
esktop.org</a>&gt;
<b>On Behalf Of </b>Jacob Hrbek<br>
<b>Sent:</b> 2020/January/30, Thursday 12:18 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Suspecting corrupted VBIOS after update of AMDGPU on AMD787=
0<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0.25in"><b><span style=3D"fon=
t-size:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black">Hello,</=
span></b><span style=3D"font-size:18pt;font-family:&quot;Tahoma&quot;,sans-=
serif;color:black"><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0.25in"><span style=3D"font-s=
ize:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black">I believe t=
hat system update that included amdgpu on debian testing (but i am on LFS) =
corrupted my VBIOS on AMD7870 (+- 4 hours after
 the update the GPU using AMDGPU/Radeon drivers resulted in no output).<u><=
/u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0.25in"><span style=3D"font-s=
ize:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black">i&#39;m sen=
ding this email to inform about possible bug with my findings on
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgist.github.com%2FKreyren%2F3e55e9a754e58956e1690e38b1888de7&amp;data=
=3D02%7C01%7Czhan.liu%40amd.com%7C01e9bc8278a74c4d215d08d7a5ab67d0%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637160028350519449&amp;sdata=3DpIqR4bR=
1m50HNG8QSVBJyp75Z2PtoUgNBbLjklilvRs%3D&amp;reserved=3D0" target=3D"_blank"=
>
https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7</a> and i =
would appreciate any help in excluding VBIOS corruption from the diagnostic=
s.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:18pt;font-family:&quot;T=
ahoma&quot;,sans-serif;color:black">Thanks,</span></b><span style=3D"font-s=
ize:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black"><u></u><u><=
/u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:18pt;font-family:&quot;Taho=
ma&quot;,sans-serif;color:black">- Jacob Hrbek<u></u><u></u></span></p>
</div>
</div>
</div>
</div>
</div>

</blockquote></div></div>

--0000000000000a6fa4059d635c64--

--===============1113310707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1113310707==--
