Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37568C54FCF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC3A2145D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuvwOleY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC3A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7474E6E25E;
	Mon, 20 Apr 2020 06:59:09 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8366E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 04:12:56 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id l78so9250499qke.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2020 21:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=UCj3MLuMgzaXE31fB7aSsaxDeH4YNlAukucTnvVfVlA=;
 b=fuvwOleYD/g8IbIvSExzCHVa/wQ/adLTYo0DZdCrwyq9fqpVg4RzzEBREbPTW2JTRm
 +7XrlV+inc1mdDarn9Gqtl3hAK45ofUImYlrgLt/VOR6HiFC2E3ZX90qWKzdRBtS6isG
 r0OUUzRnhElImU8tzEkARv7GpRngU/E85I+SHAWcRFICFuzX9nWEknK0vAaxRBB0Eno2
 V4sk/ABY8h/M5wqWlY2cKj6mCuo40XGdavMkdFwdBfXderpd4e3nRBlESP8x+k6ijCOm
 ODjsl+dBSXJ0NQnV9X05dqeXXmXR8jFc3WqywqhK1GbvY3KAoGSd4arvdYBalS1qTqSe
 yxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=UCj3MLuMgzaXE31fB7aSsaxDeH4YNlAukucTnvVfVlA=;
 b=pcNr+pmJQ65wAZV+ui6mkFUYyABzdoSshNW7XjK2eFT3VQzY+T0Pv0s+Xyp9gZ+nFe
 mweYFy4xrR4BxBsYPJta7C5AKLxGciRwNjceXKGP589Qc7jZpgkP3OwKLkI6hDRg/cvh
 JvAD/HFC4GW24eAjhaatBMFUNkp5Xp6UaIcFgzd28upm9/OWGSUOu5eLMQ6jqS6jXZJD
 Rws+VlJF55juke4jOzAfqMX3+PZlKJYS8L9ZWZwLiFJJB5Af8p8IsWJ3+RWa3xKCbW0K
 US8auB1jPOdObNnZDNm938r2E2aKXrHzgpYLjHJSgVIXXkm15jVeeliilTFtn49cSmGU
 Khag==
X-Gm-Message-State: AGi0Puae7HTSAIv8aPJmXA4NxkRrvYaMW5EkJvhB6at+fNNcbzfDxmbY
 ES9Bh0xSdB5pbEekVRgFIK6LIG2HQZDwR8KTIiN9BY0/
X-Google-Smtp-Source: APiQypJp74KVfk91n0KlrA8GWNvyJFPLfXCD39ih1ljQgDS4GJM8/99sj5DKkPwl6Lu8n+MRzJ4wKJqppjm/GtjzIyI=
X-Received: by 2002:a37:6287:: with SMTP id w129mr14110565qkb.34.1587355975088; 
 Sun, 19 Apr 2020 21:12:55 -0700 (PDT)
MIME-Version: 1.0
From: uday kiran pichika <udaykiran.pichika@gmail.com>
Date: Mon, 20 Apr 2020 09:42:43 +0530
Message-ID: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
Subject: Reg. Adaptive Sync feature in xf86-video-amdgpu
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Mon, 20 Apr 2020 06:59:07 +0000
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
Content-Type: multipart/mixed; boundary="===============0885286471=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0885286471==
Content-Type: multipart/alternative; boundary="00000000000006fdf005a3b11d5c"

--00000000000006fdf005a3b11d5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Team,

I'm working on adding Adaptive Sync feature in Xserver/modesetting. When
understanding the existing AMD's implementation, I've few doubts regarding
the vrr property being set on the Window from MESA.

I have made the modifications in xserver/modesetting but when i launch the
application(DOTA2), below condition gets failed
https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/-/blob/master/=
src/amdgpu_kms.c#L110


As per the code, i had a confusion that this condition will never met.

*I had analysed the code and here is the analysis made when the flip
happens in xserver When full screen gaming application is opened,
variable_refresh property is being set in MESA and xserver will get
notified with amdgpu_change_property() method(Same method we registered
with the client during AMDGPUScreenInit_KMS()). *

*Below actions will happen in ms_change_property() *

*1. Create Local WindowPtr and copy the data from Stuff->window to this
WindowPtr*

*2. Call amdgpu_vrr_property_update() based on the property set in Stuff by
passing the WindowPtr to it.*

*    a. Read Private Keys for WindowPtr in amdgpu_vrr_property_update(). *

*    b. Compare info->flip_window and this WindowPtr and make a call to
amdgpu_present_set_screen_vrr().  =E2=86=92 But this method will never gets=
 called
due to the condition mismatch every time. Why ? *

*Why ?*

*info->flip_window gets updated with window (WindowPtr)
in amdgpu_present_check_flip() when amdgpu_present_flip() method gets
called from DIX. This pointer will never same as the WindowPtr created in
amdgpu_change_property() and variable_refresh flag is being set for in
amdgpu_change_property() WindowPtr only. *

Can  you please help me in understanding on this ?

JFYI, I have used DOTA2 application to verify this feature.

Thanka
Uday Kiran

--00000000000006fdf005a3b11d5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Team,<div><br></div><div>I&#39;m working on adding A=
daptive Sync feature in Xserver/modesetting. When understanding the existin=
g AMD&#39;s implementation, I&#39;ve few doubts regarding the vrr property =
being set on the Window from MESA.=C2=A0</div><div><br></div><div>I have ma=
de the modifications in xserver/modesetting but when i launch the applicati=
on(DOTA2), below condition gets failed=C2=A0</div><div><a href=3D"https://g=
itlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/-/blob/master/src/amdgp=
u_kms.c#L110">https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/=
-/blob/master/src/amdgpu_kms.c#L110</a>=C2=A0</div><div><br></div><div>As p=
er the code, i had a confusion that this condition will never met.=C2=A0</d=
iv><div><br></div><p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0=
.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><b>I had analysed th=
e code and here is the analysis made
when the flip happens in xserver When full screen gaming application is ope=
ned,
variable_refresh property is being set in MESA and xserver will get notifie=
d
with amdgpu_change_property() method(Same method we registered with the cli=
ent
during AMDGPUScreenInit_KMS()). </b></p>

<p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.0001pt;font-size:=
11pt;font-family:Calibri,sans-serif"><b>Below actions will happen in ms_cha=
nge_property()=C2=A0</b></p><p class=3D"gmail-MsoPlainText" style=3D"margin=
:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><b>1.
Create Local WindowPtr and copy the data from Stuff-&gt;window to this
WindowPtr</b></p><p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.=
0001pt;font-size:11pt;font-family:Calibri,sans-serif"><b>2. Call
amdgpu_vrr_property_update() based on the property set in Stuff by passing =
the
WindowPtr to it.</b></p>

<p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.0001pt;font-size:=
11pt;font-family:Calibri,sans-serif"><b>=C2=A0 =C2=A0 a. Read Private Keys =
for WindowPtr in amdgpu_vrr_property_update(). </b></p>

<p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.0001pt;font-size:=
11pt;font-family:Calibri,sans-serif"><b>=C2=A0 =C2=A0 b. Compare info-&gt;f=
lip_window and this WindowPtr and make
a call to amdgpu_present_set_screen_vrr().=C2=A0 =E2=86=92 But this method =
will never gets
called due to the condition mismatch every time. Why ? </b></p>

<p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.0001pt;font-size:=
11pt;font-family:Calibri,sans-serif"><b>Why ?</b></p><p class=3D"gmail-MsoP=
lainText" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calib=
ri,sans-serif"><b>info<span style=3D"font-size:11pt">-&gt;flip_window gets =
updated with window (WindowPtr) in=C2=A0</span>amdgpu_present_check_flip<sp=
an style=3D"font-size:11pt">() when amdgpu_present_flip() method gets
called from DIX. This pointer will never same as the WindowPtr created in a=
mdgpu_change_property() and variable_refresh flag is being set for in amdgp=
u_change_property() WindowPtr only.</span><span style=3D"font-family:Arial,=
Helvetica,sans-serif;font-size:small">=C2=A0</span></b></p><div><br></div><=
div>Can=C2=A0 you please help me in understanding on this ?=C2=A0</div><div=
><br></div><div>JFYI, I have used DOTA2 application to verify this feature.=
</div><div><br></div><div>Thanka</div><div>Uday Kiran</div><div><br></div><=
div><br></div><div><br></div></div>

--00000000000006fdf005a3b11d5c--

--===============0885286471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0885286471==--
