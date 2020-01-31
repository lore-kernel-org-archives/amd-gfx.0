Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F69C3F68F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 08:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937C520CC7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 08:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937C520CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rixotstudio.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C616FAA8;
	Fri, 31 Jan 2020 08:05:40 +0000 (UTC)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1056E117
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 04:09:33 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id d16so6911251wre.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 20:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=c6KXQp1olSWs6rmXKSLeZSRLhfl3cgMGYIyGaTVMUdE=;
 b=WZMxYGZwzwhXpLT0P/W+xL8Iwng/qBhPg4WFfOiZHgxVVwMLE7L7KjmRYSw9wYj2CM
 R/lWVxKNPfLjBIRWPHQzeWOwFLkT8Xv8l4UmR0g6hEO+tt2fKGENRangBTDpJTdstvVV
 /mlFW5HmAmPN708OeCC0AHteCYpqBS/FENW0Gj/zyzJLJJVv3Y0uLYR16UPN+25589TV
 aebwMsYVrMpb4aLRrnrOsmr7RTqkMJHwcelMRDd5k19hC/0CKHgnYhppoD1e5dQnEatC
 UXDEdEscuU9NsVFeSh7OT+MMhsJMp+1aX9uk83P3Rs48dGa4lxJCFEnV1vlDtzv004LI
 x2Gg==
X-Gm-Message-State: APjAAAVQUdLif6xFn5DxYIC87enRlgRysnDZnr08Mad9534XFBTtPTMD
 N+jUSytOR/HbU8h3+V2QtjHT55Z8jr5Ctl1ILEfzp9sDwi/siw==
X-Google-Smtp-Source: APXvYqxeWeqxUPX8VRdkVhha6nnmYYPsLyjLQoXoBqn+sq2QUNy2p61Kd7K66xgFzBmnpI4SWSKIRaeRDxfmqECq6aY=
X-Received: by 2002:a05:6000:50:: with SMTP id
 k16mr8877281wrx.145.1580443772503; 
 Thu, 30 Jan 2020 20:09:32 -0800 (PST)
MIME-Version: 1.0
References: <CAPA_gs6evUkUbPipQ4=BTH9R9ZWDZimZpTYbOBus+i=AZZDnyw@mail.gmail.com>
 <DM5PR1201MB25540C0A23067345E620DA6C9E040@DM5PR1201MB2554.namprd12.prod.outlook.com>
 <CAPA_gs7yCq3zg-wosrnczLCcAoRm2NX6ymM3mXxbErqX3EKahw@mail.gmail.com>
 <DM5PR1201MB2554429ADF4DE4158495D8029E070@DM5PR1201MB2554.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB2554429ADF4DE4158495D8029E070@DM5PR1201MB2554.namprd12.prod.outlook.com>
From: Jacob Hrbek <kreyren@rixotstudio.cz>
Date: Fri, 31 Jan 2020 05:09:06 +0100
Message-ID: <CAPA_gs4adDCrotY52-gLO_MVMv_b=q-Ax0b3rgT1+b89M+Jdgw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2037561857=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2037561857==
Content-Type: multipart/alternative; boundary="000000000000a5e2de059d67bda6"

--000000000000a5e2de059d67bda6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm sorry for the wrong link, this one should work
https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7

I've manually compiled kernel-5.5 which results in this dmesg -
https://gist.githubusercontent.com/Kreyren/2fa75d30e0632d73311a13c2e872cfe6=
/raw/78d367f890eb64026e64597091a2a2f40bdbe46a/gistfile1.txt

If relevant i've used this config
https://gist.githubusercontent.com/Kreyren/7b20ad875ca42381d4a0a8e5b1b26a2c=
/raw/171747682e49fe28cb653b2e45ee42390ca59338/gistfile1.txt
(grabbed from debian)

Regards,
- Jacob Hrbek
<https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7>

On Fri, Jan 31, 2020 at 2:57 AM Liu, Zhan <Zhan.Liu@amd.com> wrote:

> Okay I see. From your attached dmesg.log, issue comes from here:
>
>
>
> [   26.265638] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
> timeout, signaled seq=3D1, emitted seq=3D2
>
> [   26.265764] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> information: process  pid 0 thread  pid 0
>
> [   26.265771] [drm] GPU recovery disabled.
>
>
>
> There was a very similar issue that=E2=80=99s recently fixed and merged i=
n 5.5
> kernel. I=E2=80=99ve noticed that you are using 5.4 kernel, so you can gi=
ve 5.5 a
> spin to see what happens.
>
>
>
> As for these =E2=80=9CGreen Dots=E2=80=9D at BIOS initialization stage, t=
he main amdgpu
> driver was not loaded yet, so it shouldn=E2=80=99t related to amdgpu.
>
>
>
> BTW, your new findings (
> https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7) gives
> me 404. Please fix the link. Good luck!
>
>
>
> Warm regards,
>
> Zhan
>
>
>
>
>
>
>
> *From:* Jacob Hrbek <kreyren@rixotstudio.cz>
> *Sent:* 2020/January/30, Thursday 5:55 PM
> *To:* Liu, Zhan <Zhan.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: Suspecting corrupted VBIOS after update of AMDGPU on
> AMD7870
>
>
>
> *Hello Zhan,*
>
> Here is it:
>
> https://gist.githubusercontent.com/Kreyren/e35587d8710e63e511e69d8653fd99=
6b/raw/628df1c76ff99adab1d2161e6a20f631de101d5c/gistfile1.txt
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgist=
.githubusercontent.com%2FKreyren%2Fe35587d8710e63e511e69d8653fd996b%2Fraw%2=
F628df1c76ff99adab1d2161e6a20f631de101d5c%2Fgistfile1.txt&data=3D02%7C01%7C=
Zhan.Liu%40amd.com%7C2fe63c116bbd4cacddc008d7a5d79126%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637160218197534666&sdata=3DCGBp3z6G8KJXT9cyfaJxlDlk=
paDF36qTsj228KYo1bk%3D&reserved=3D0>
>
>
>
> Note that I'm updating previous gists with new findings (
> https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7).
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgist=
.github.com%2FKreyren%2F3e55e9a754e58956e1690e38b1888de7).&data=3D02%7C01%7=
CZhan.Liu%40amd.com%7C2fe63c116bbd4cacddc008d7a5d79126%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637160218197544657&sdata=3DC8pB8txk8a9du6ulzG%2FA1=
5VBF8vTXfjZ%2BG9vU9%2FFkCw%3D&reserved=3D0>
>
>
>
> If relevant i'm also getting these 'Green dots' at the initialization of
> bios (https://linx.li/s/8j3poh2z.png
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flinx=
.li%2Fs%2F8j3poh2z.png&data=3D02%7C01%7CZhan.Liu%40amd.com%7C2fe63c116bbd4c=
acddc008d7a5d79126%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63716021819=
7544657&sdata=3DZuobmBcSLCHK97ta%2FLG5txQCf0vN%2BS47UGRNAlPZu2s%3D&reserved=
=3D0>
> ).
> These dots are not present anywhere else and were not present before said
> update.
>
>
>
> *Thanks,*
>
> - Jacob Hrbek
>
>
>
> On Thu, Jan 30, 2020 at 8:10 PM Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
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
.github.com%2FKreyren%2F3e55e9a754e58956e1690e38b1888de7&data=3D02%7C01%7CZ=
han.Liu%40amd.com%7C2fe63c116bbd4cacddc008d7a5d79126%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637160218197554652&sdata=3DgoaR7sDaBxHkmG%2Biln%2Fsx=
EZfSqQ7KTqwbxc9FRxGGMs%3D&reserved=3D0>
> and i would appreciate any help in excluding VBIOS corruption from the
> diagnostics.
>
> *Thanks,*
>
> - Jacob Hrbek
>
>

--000000000000a5e2de059d67bda6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif;font-size:large;color:rgb(0,0,0)">I&#39;m sorry for the wrong lin=
k, this one should work <a href=3D"https://gist.github.com/Kreyren/3e55e9a7=
54e58956e1690e38b1888de7" target=3D"_blank">https://gist.github.com/Kreyren=
/3e55e9a754e58956e1690e38b1888de7<br></a></div><div class=3D"gmail_default"=
 style=3D"font-family:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)"><=
br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-seri=
f;font-size:large;color:rgb(0,0,0)">I&#39;ve manually compiled kernel-5.5 w=
hich results in this dmesg - <a href=3D"https://gist.githubusercontent.com/=
Kreyren/2fa75d30e0632d73311a13c2e872cfe6/raw/78d367f890eb64026e64597091a2a2=
f40bdbe46a/gistfile1.txt" target=3D"_blank">https://gist.githubusercontent.=
com/Kreyren/2fa75d30e0632d73311a13c2e872cfe6/raw/78d367f890eb64026e64597091=
a2a2f40bdbe46a/gistfile1.txt</a></div><div class=3D"gmail_default" style=3D=
"font-family:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;font-si=
ze:large;color:rgb(0,0,0)">If relevant i&#39;ve used this config <a href=3D=
"https://gist.githubusercontent.com/Kreyren/7b20ad875ca42381d4a0a8e5b1b26a2=
c/raw/171747682e49fe28cb653b2e45ee42390ca59338/gistfile1.txt" target=3D"_bl=
ank">https://gist.githubusercontent.com/Kreyren/7b20ad875ca42381d4a0a8e5b1b=
26a2c/raw/171747682e49fe28cb653b2e45ee42390ca59338/gistfile1.txt</a> (grabb=
ed from debian)<br><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)">Regards,<br></div><=
div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;font-siz=
e:large;color:rgb(0,0,0)">- Jacob Hrbek<br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)"=
><a href=3D"https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de=
7" target=3D"_blank"></a></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Fri, Jan 31, 2020 at 2:57 AM Liu, Zhan &l=
t;<a href=3D"mailto:Zhan.Liu@amd.com" target=3D"_blank">Zhan.Liu@amd.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div>
<p class=3D"MsoNormal">Okay I see. From your attached dmesg.log, issue come=
s from here:<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 26.265638] [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* ring sdma0 timeout, signaled seq=3D1, emitted seq=3D2<u></u=
><u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 26.265764] [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* Process information: process=C2=A0 pid 0 thread=C2=A0 pid 0=
<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 26.265771] [drm] GPU recovery disabled=
.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">There was a very similar issue that=E2=80=99s recent=
ly fixed and merged in 5.5 kernel. I=E2=80=99ve noticed that you are using =
5.4 kernel, so you can give 5.5 a spin to see what happens.<u></u><u></u></=
p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">As for these =E2=80=9CGreen Dots=E2=80=9D at BIOS in=
itialization stage, the main amdgpu driver was not loaded yet, so it should=
n=E2=80=99t related to amdgpu.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">BTW, your new findings (<a href=3D"https://gist.gith=
ub.com/Kreyren/3e55e9a754e58956e1690e38b1888de7" target=3D"_blank">https://=
gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7</a>) gives me 404.=
 Please fix the link. Good luck!<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Warm regards,<u></u><u></u></p>
<p class=3D"MsoNormal">Zhan<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-color:currentcolor currentcolor currentcolor blue;bord=
er-style:none none none solid;border-width:medium medium medium 1.5pt;paddi=
ng:0in 0in 0in 4pt">
<div>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b>From:</b> Jacob Hrbek &lt;<a href=3D"mailto:kreyr=
en@rixotstudio.cz" target=3D"_blank">kreyren@rixotstudio.cz</a>&gt; <br>
<b>Sent:</b> 2020/January/30, Thursday 5:55 PM<br>
<b>To:</b> Liu, Zhan &lt;<a href=3D"mailto:Zhan.Liu@amd.com" target=3D"_bla=
nk">Zhan.Liu@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.o=
rg" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Re: Suspecting corrupted VBIOS after update of AMDGPU on AM=
D7870<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0.25in"><b><span style=3D"fon=
t-size:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black">Hello Zh=
an,</span></b><span style=3D"font-size:18pt;font-family:&quot;Tahoma&quot;,=
sans-serif;color:black"><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:18pt;font-family:&quot;Taho=
ma&quot;,sans-serif;color:black">Here is it:<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgist.githubusercontent.com%2FKreyren%2Fe35587d8710e63e511e69d8653fd996b=
%2Fraw%2F628df1c76ff99adab1d2161e6a20f631de101d5c%2Fgistfile1.txt&amp;data=
=3D02%7C01%7CZhan.Liu%40amd.com%7C2fe63c116bbd4cacddc008d7a5d79126%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637160218197534666&amp;sdata=3DCGBp3z6=
G8KJXT9cyfaJxlDlkpaDF36qTsj228KYo1bk%3D&amp;reserved=3D0" target=3D"_blank"=
>https://gist.githubusercontent.com/Kreyren/e35587d8710e63e511e69d8653fd996=
b/raw/628df1c76ff99adab1d2161e6a20f631de101d5c/gistfile1.txt</a><u></u><u><=
/u></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:18pt;font-family:&quot;Taho=
ma&quot;,sans-serif;color:black">Note that I&#39;m updating previous gists =
with new findings (<a href=3D"https://nam11.safelinks.protection.outlook.co=
m/?url=3Dhttps%3A%2F%2Fgist.github.com%2FKreyren%2F3e55e9a754e58956e1690e38=
b1888de7).&amp;data=3D02%7C01%7CZhan.Liu%40amd.com%7C2fe63c116bbd4cacddc008=
d7a5d79126%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637160218197544657&=
amp;sdata=3DC8pB8txk8a9du6ulzG%2FA15VBF8vTXfjZ%2BG9vU9%2FFkCw%3D&amp;reserv=
ed=3D0" target=3D"_blank">https://gist.github.com/Kreyren/3e55e9a754e58956e=
1690e38b1888de7).</a><u></u><u></u></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:18pt;font-family:&quot;Taho=
ma&quot;,sans-serif;color:black">If relevant i&#39;m also getting these &#3=
9;Green dots&#39; at the initialization of bios (<a href=3D"https://nam11.s=
afelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flinx.li%2Fs%2F8j3poh2z=
.png&amp;data=3D02%7C01%7CZhan.Liu%40amd.com%7C2fe63c116bbd4cacddc008d7a5d7=
9126%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637160218197544657&amp;sd=
ata=3DZuobmBcSLCHK97ta%2FLG5txQCf0vN%2BS47UGRNAlPZu2s%3D&amp;reserved=3D0" =
target=3D"_blank">https://linx.li/s/8j3poh2z.png</a>).<br>
These dots are not present anywhere else and were not present before said u=
pdate.<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
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
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Thu, Jan 30, 2020 at 8:10 PM Liu, Zhan &lt;<a hre=
f=3D"mailto:Zhan.Liu@amd.com" target=3D"_blank">Zhan.Liu@amd.com</a>&gt; wr=
ote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-color:currentcolor currentcolor currentcolor rg=
b(204,204,204);border-style:none none none solid;border-width:medium medium=
 medium 1pt;padding:0in 0in 0in 6pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal">Hi Jacob,<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Thant you for your bug reporting.<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">I saw you attached xorg.log, which is great. Could y=
ou also grab dmesg.log via SSH?<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
<p class=3D"MsoNormal">Zhan<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div style=3D"border-style:none none none solid;border-width:medium medium =
medium 1.5pt;padding:0in 0in 0in 4pt;border-color:currentcolor currentcolor=
 currentcolor blue">
<div>
<div style=3D"border-style:solid none none;border-width:1pt medium medium;p=
adding:3pt 0in 0in;border-color:currentcolor">
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
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0.25in"><b><span style=3D"fon=
t-size:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black">Hello,</=
span></b><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0.25in"><span style=3D"font-s=
ize:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black">I believe t=
hat system update that included amdgpu on debian testing (but i am on LFS) =
corrupted my VBIOS on AMD7870
 (+- 4 hours after the update the GPU using AMDGPU/Radeon drivers resulted =
in no output).</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0.25in"><span style=3D"font-s=
ize:18pt;font-family:&quot;Tahoma&quot;,sans-serif;color:black">i&#39;m sen=
ding this email to inform about possible bug with my findings on
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgist.github.com%2FKreyren%2F3e55e9a754e58956e1690e38b1888de7&amp;data=
=3D02%7C01%7CZhan.Liu%40amd.com%7C2fe63c116bbd4cacddc008d7a5d79126%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637160218197554652&amp;sdata=3DgoaR7sD=
aBxHkmG%2Biln%2FsxEZfSqQ7KTqwbxc9FRxGGMs%3D&amp;reserved=3D0" target=3D"_bl=
ank">
https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7</a> and i =
would appreciate any help in excluding VBIOS corruption from the diagnostic=
s.</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:18pt;font-family:&quot;T=
ahoma&quot;,sans-serif;color:black">Thanks,</span></b><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:18pt;font-family:&quot;Taho=
ma&quot;,sans-serif;color:black">- Jacob Hrbek</span><u></u><u></u></p>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</div>
</div>

</blockquote></div>

--000000000000a5e2de059d67bda6--

--===============2037561857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2037561857==--
