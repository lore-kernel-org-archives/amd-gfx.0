Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0521C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E7E60C51
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75E7E60C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1BF6E8E2;
	Fri, 27 Aug 2021 06:55:13 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE356E8E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1630047309;
 bh=LvaJixWq5KkQfhOsPBJD8EIQbvqgURaK18ncWcuaxAw=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=gJ2oVLNuLkV+E1maqYaOXaSR3/0lzYB8ZumdcUrJG1IIIG+7DghrslEYXYMooKKWY
 oKC6qoGaxlrDQgYLQ+MMwW7rEjnTod7kTFVrT/5QbRi8g1+bHIIXirkBzUL1YrBcJp
 FdonrmUUtgRwuSO0cszyLP8soWIIXPh2BNAAAHpY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.100] ([95.91.0.137]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1nDosi1I2X-00z2FN for
 <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 08:55:09 +0200
Subject: Re: Set video resolution and refresh rate at boot?
To: amd-gfx@lists.freedesktop.org
References: <36cacbd4-8240-9713-6cea-68209757ed0b@gmx.de>
 <CADnq5_PrkEQCpKKWY8QhOqWZ_jxK3vabSjxwRW-+MFnm3Rgs2w@mail.gmail.com>
From: Paul <pb.g@gmx.de>
Message-ID: <49ceabbf-a59f-85e4-003d-4a9b20a798f1@gmx.de>
Date: Fri, 27 Aug 2021 08:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_PrkEQCpKKWY8QhOqWZ_jxK3vabSjxwRW-+MFnm3Rgs2w@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------FC0B0A97C4604C5D981DB62F"
Content-Language: en-US
X-Provags-ID: V03:K1:+FHlFNFk+874R74bbC2el5+4UKKfjp3eadx5nIiUQx6uHWuN5JM
 denoR/SqoN7M9des2Sg1obCUeJpCbDOPxiWgTZDtVGVy+tysWGiVXMdSIBGJ9flxaCHNAmP
 82Q1RflCaGzAzT3nipX4DjAggkmYKuu990jEF4FRIUBXc06MUG6QY/Y0Effpqa0jEfwNtsd
 CLe1iiB3z2S/Ohk4OZsGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zZf7eCUv/5c=:IKwhEeFZYQXmWhp+kFo7tt
 PAmpPl33UT+VXV6rF0090YXD6ADgoodReqYb6li9ciiXkr+BhLFZlzfoPTq9YEHSxs0ytakyM
 uwUFP8CKAZ38nvIRpWi2k1yL84gMeQoFgDBf8yuGwEUoriihEPr3NKBGfMDqQBbaP1hXvHFqb
 F7LKJEw0ug49UcR3iE54Pe+YO1ds143eushwNh9NuN62NQmHbLk1KH3VhAyZPkLPqgPCZ1kvt
 2br5BvWprT8kHCzIhixRJigVzvU+cqwgsG1zRFsow50ekz+k5G2eIO6aBO8Ho4hYMbLq8ftgw
 6AmulHqAhG2QcVeXgQTwMTQxmE0uHms/V4/5Z97KaAEn9ZaywYysVCuOb4MPTnuIXDIobOkxq
 04YmTNcR2MIFvgenkDSZBWZVUC/pHS+earYp0p88xCVWkywKVjcjK5jZ4WX1vuMuVns1gT2yI
 pXQlljyTJyFIe1ymxK62Nku+al7oyvFEhYdwLa9WhkHqqxP8//iNcu0JH3dFVfO2G5Wh8R1lY
 UbreQR2iSzmO2Our/WR2pSBvoBnVRB2uglUCDaJb9HanCAvb8eG+i1AsRaaL42aQEdeLN/+AF
 9CGppprOmlBVgStxvIWzMkKql+uRx8AJs7wMoB95l7ElNIvWzvv5AKpgMQJLQX4BfJRbUocPf
 5tbMsMc9TZfG7pIKnks1QbgNFKdgRcT+quUoc04g/+y6JjEXM+VP6nx9v0iruqxXSJLppC1sx
 ys1A8oAvEo8ksMH+5ODnD1dsPC41vuB3/JO6nXpdLIStXVvqudHFEzheoqp9c67cOqCbC0kwO
 FevK6UHvXga6WW1Ft5l6mCGjHNXcfpqOlB0pNMW8OokQJc4I4zI1vw7u8nvIVQE0ipFeebajP
 yJi203RmTcAF3NLtX+KZhilw/f/T+VolX1jMR0svMKZzjoocyeWWWz5Ck51vrLeWXhfHl4/dC
 iBdU+uL9b+71A+0OS9MfbrKeK1eUunTQ8ALvry0+tOabX5Jid9y+BVp5t3pDSuRzA1sWAo1mj
 qkDn5HkjsQIEv2/9XSb5hjhPrUm3X2eHO9w2Y6+1uk8uq1yKmauukTgERfTTUklGP6itQYlCY
 qRFhffAdKsIz1BXFsMTyFYzP/WwpS3lgw8H
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------FC0B0A97C4604C5D981DB62F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



Am 26.08.21 um 18:45 schrieb Alex Deucher:
> On Thu, Aug 26, 2021 at 12:35 PM Paul<pb.g@gmx.de>  wrote:
>> Hi there
>>
>> Out of curiosity I would like to ask if it is possible to set a kernel =
command line parameter for my Radeon 6900XT
>> that sets a specific resolution and refresh rate of a specific connecte=
d monitor.
>>
>> Ideally this parameter is set to the monitors used desktop (X11, Waylan=
d) resolution/refreshrate.
>>
>> I did this for years with my Intel IGP's. I appended:
>>
>> video=3DHDMI-A-1:1920x1080@50
>>
>> to the kernel command line. This worked beautifully and the result was =
my monitor was preconfigured to a specific resolution and refresh
>> rate from the first lines of the kernel to the desktop (X11) and it did=
 not had to switch to anything else in between.
>>
>> Another nice side effect is when in X11 one switches to the console, or=
 vice versa, via STRG+Fx, pretty much everyone has this annoying delay bec=
ause
>> the monitor has to switch between refresh rates again. With that precon=
figured settings at boot this gave a very satisfying feeling, especially i=
f one frequently
>> switches between console and X11 (or wayland maybe).
>>
>> Is this kind of parameter implemented in the kernel/amdgpu driver?
> It works the same for all drivers.  Just make sure the connector name
> is correct.
>
> Alex

Thank you, it works.
I just want to mention that I had to look in "/sys/class/drm/" for the
correct connector naming. Connector names shown by xrandr are different:

ls /sys/class/drm/ | grep card0-
card0-DP-1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # DP-1
card0-DP-2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # DP-2
card0-DP-3=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #=
 DP-3
card0-HDMI-A-1=C2=A0=C2=A0=C2=A0=C2=A0 # HDMI-A-1

vs.

xrandr | grep connected | awk '{print $1}'
DisplayPort-0
DisplayPort-1
DisplayPort-2
HDMI-A-0

--------------FC0B0A97C4604C5D981DB62F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">Am 26.08.21 um 18:45 schrieb Alex
      Deucher:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CADnq5_PrkEQCpKKWY8QhOqWZ_jxK3vabSjxwRW-+MFnm3Rgs2w@mail.gmail=
.com">
      <div class=3D"moz-text-plain" wrap=3D"true" graphical-quote=3D"true"
        style=3D"font-family: -moz-fixed; font-size: 12px;"
        lang=3D"x-unicode">
        <pre class=3D"moz-quote-pre" wrap=3D"">On Thu, Aug 26, 2021 at 12:=
35 PM Paul <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:pb.g@gmx.de" =
moz-do-not-send=3D"true">&lt;pb.g@gmx.de&gt;</a> wrote:
</pre>
        <blockquote type=3D"cite" style=3D"color: #007cff;">
          <pre class=3D"moz-quote-pre" wrap=3D"">Hi there

Out of curiosity I would like to ask if it is possible to set a kernel com=
mand line parameter for my Radeon 6900XT
that sets a specific resolution and refresh rate of a specific connected m=
onitor.

Ideally this parameter is set to the monitors used desktop (X11, Wayland) =
resolution/refreshrate.

I did this for years with my Intel IGP's. I appended:

video=3DHDMI-A-1:1920x1080@50

to the kernel command line. This worked beautifully and the result was my =
monitor was preconfigured to a specific resolution and refresh
rate from the first lines of the kernel to the desktop (X11) and it did no=
t had to switch to anything else in between.

Another nice side effect is when in X11 one switches to the console, or vi=
ce versa, via STRG+Fx, pretty much everyone has this annoying delay becaus=
e
the monitor has to switch between refresh rates again. With that preconfig=
ured settings at boot this gave a very satisfying feeling, especially if o=
ne frequently
switches between console and X11 (or wayland maybe).

Is this kind of parameter implemented in the kernel/amdgpu driver?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">It works the same for all d=
rivers.  Just make sure the connector name
is correct.

Alex
</pre>
      </div>
    </blockquote>
    <br>
    Thank you, it works.<br>
    I just want to mention that I had to look in "/sys/class/drm/" for
    the correct connector naming. Connector names shown by xrandr are
    different: <br>
    <br>
    ls /sys/class/drm/ | grep card0-<br>
    card0-DP-1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 # DP-1<br>
    card0-DP-2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 # DP-2<br>
    card0-DP-3=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0 # DP-3<br>
    card0-HDMI-A-1=C2=A0=C2=A0=C2=A0=C2=A0 # HDMI-A-1<br>
    <br>
    vs.<br>
    <br>
    xrandr | grep connected | awk '{print $1}'<br>
    DisplayPort-0<br>
    DisplayPort-1<br>
    DisplayPort-2<br>
    HDMI-A-0<br>
  </body>
</html>

--------------FC0B0A97C4604C5D981DB62F--
