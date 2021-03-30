Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE5C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA74619C2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA74619C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72806E931;
	Tue, 30 Mar 2021 16:06:40 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2239C6E925
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 15:37:31 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id o16so6346826ljp.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IKyTitQqgO7kZVcOkmTEADx60gINZjY0v50Zw0MS/mc=;
 b=u4rCNAtgE+GOLpZje5KfSIM/3kR1xo++uYnXKVBTwVyRddf4Iu9Pm4upKEuehNcZNU
 A4nBdpn5ehRGFzOT4+TfqeS8NxZdj/oAK5YDcUKhG7qleWLxGW2OWvbl4y+x9N9Nh3hU
 jiF8m/vo0Iws98jNlJ8mkhI3MlYdi8JyRECrk3Kf2YxNVQMOF3h+zX5EuASvQTHrPRgx
 HxQuw6NcisburhQcJwUwOGnyET1kt9uQLvShXs8nJ0ytZp1HoRFmzWeo5lgHlfERhP89
 vEkmAJFxjFROwqdHM5dgeGPdCli3/hhD9CzTHrmKc3xEorN3ZECDMqs+7O54wxvspwY/
 choA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IKyTitQqgO7kZVcOkmTEADx60gINZjY0v50Zw0MS/mc=;
 b=WPpr08kIpbOHrYAC5i9x0rbhdIC0CZ7uDhwvNCjsHCXyRJ45zNNGxDNV/bdYl+W6WN
 yPius4XgpWvwY/l5hWq5upqZocZ8T4W6O4vBzjtY5Mj7AkTQYaetA1tUjOksAKz5wNm7
 rSTK2R3xCDmWZUjHn+7PK5l7cESH2ei6Fke1yVuEIa2+sVV/ZSHEXqzaHIPAfc/KSOAY
 MH42Cg6GI/zWvSukmGsyTfanOUa1WMZ2GL0TFfCHfL7LHZMIeMl3DHMBN3HH75cD0IMt
 qLwg6JFSu1nFBI5XdgDzh1O9UyMV9ex4WwnpcqqFOfsUFQKofyVnOPLcWqY9bIBhx8Iw
 eEwg==
X-Gm-Message-State: AOAM533lN0gBSGgWQodle3bxfFOPykH3sTL7QR2n0icbCfxIgP06iT1l
 6278QybakAEu+xp53zyayGbtt79mFpDEZ37rUB0=
X-Google-Smtp-Source: ABdhPJySuWi8mmDoJLwQs1JCICeRXhFTkVxotN/qMN4LK6/6uaVaM91tA/Wrb/O7UzC7CDjDw0T3K7zCNMz56+niwtY=
X-Received: by 2002:a2e:6e1a:: with SMTP id j26mr21478492ljc.171.1617118649520; 
 Tue, 30 Mar 2021 08:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
In-Reply-To: <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
From: Alberto Salvia Novella <es20490446e@gmail.com>
Date: Tue, 30 Mar 2021 17:37:18 +0200
Message-ID: <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
X-Mailman-Approved-At: Tue, 30 Mar 2021 16:06:40 +0000
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
Cc: alexander.deucher@amd.com, benh@kernel.crashing.org,
 linux-fbdev@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1448688380=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1448688380==
Content-Type: multipart/alternative; boundary="000000000000aa132005bec2c624"

--000000000000aa132005bec2c624
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is why I'm using interlaced:

$ *xrandr*
Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
DisplayPort-0 disconnected (normal left inverted right x axis y axis)
HDMI-0 connected primary 1920x1080+0+0 (normal left inverted right x axis y
axis) 16mm x 9mm
   1920x*1080i*    60.00*+  50.00    59.94
   1920x1080     *24.00*    23.98
   1280x*720*      60.00    50.00    59.94
   1024x768      75.03    70.07    60.00
   832x624       74.55
   800x600       72.19    75.00    60.32    56.25
   720x576       50.00
   720x576i      50.00
   720x480       60.00    59.94
   720x480i      60.00    59.94
   640x480       75.00    72.81    66.67    60.00    59.94
   720x400       70.08
DVI-0 disconnected (normal left inverted right x axis y axis)

I think the driver should only support resolutions that are *progressive*,
but also at least of *50Hz*.

On Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Mhm, no idea why an interlaced resolution would cause a crash. Maybe some
> miscalculation in the display code.
>
> But apart from that if you just connected your PC to a TV I also wouldn't
> recommend using an interlaced resolution in the first place.
>
> See those resolutions only exists for backward compatibility with analog
> hardware.
>
> I think we would just disable those modes instead of searching for the bu=
g.
>
> Regards,
> Christian.
>
> Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>
> I guessed so.
>
> The GPU is a Radeon HD5870, and the screen is an old Telefunken TV
> (TLFK22LEDPVR1).
>
> Since my real display got into repair I used this TV meanwhile, and to my
> surprise it froze the system.
>
> On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <christian.koenig@amd.=
com>
> wrote:
>
>> Hi Alberto,
>>
>> well what hardware do you have?
>>
>> Interlaced resolutions are not used any more on modern hardware, so they
>> are not well tested.
>>
>> Regards,
>> Christian.
>>
>> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>> > The entire desktop hangs after some minutes when using the module
>> > "radeon" with an interlaced resolution.
>> >
>> > Easier to trigger by playing a video on Firefox, at least on kwin_x11.
>> > Wayland didn't exhibit the problem.
>> >
>> > Other display drivers, from different computers I have tried, didn't
>> > allow those interlaced resolutions all together. It seems they know
>> > there will be problems.
>>
>>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--000000000000aa132005bec2c624
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This is why I&#39;m using interlaced:<br></div><div><=
br></div><div>$ <b>xrandr</b><br>Screen 0: minimum 320 x 200, current 1920 =
x 1080, maximum 8192 x 8192<br>DisplayPort-0 disconnected (normal left inve=
rted right x axis y axis)<br>HDMI-0 connected primary 1920x1080+0+0 (normal=
 left inverted right x axis y axis) 16mm x 9mm<br>=C2=A0 =C2=A01920x<b>1080=
i</b> =C2=A0 =C2=A060.00*+ =C2=A050.00 =C2=A0 =C2=A059.94 =C2=A0<br>=C2=A0 =
=C2=A01920x1080 =C2=A0 =C2=A0 <b>24.00</b> =C2=A0 =C2=A023.98 =C2=A0<br>=C2=
=A0 =C2=A01280x<b>720</b> =C2=A0 =C2=A0 =C2=A060.00 =C2=A0 =C2=A050.00 =C2=
=A0 =C2=A059.94 =C2=A0<br>=C2=A0 =C2=A01024x768 =C2=A0 =C2=A0 =C2=A075.03 =
=C2=A0 =C2=A070.07 =C2=A0 =C2=A060.00 =C2=A0<br>=C2=A0 =C2=A0832x624 =C2=A0=
 =C2=A0 =C2=A0 74.55 =C2=A0<br>=C2=A0 =C2=A0800x600 =C2=A0 =C2=A0 =C2=A0 72=
.19 =C2=A0 =C2=A075.00 =C2=A0 =C2=A060.32 =C2=A0 =C2=A056.25 =C2=A0<br>=C2=
=A0 =C2=A0720x576 =C2=A0 =C2=A0 =C2=A0 50.00 =C2=A0<br>=C2=A0 =C2=A0720x576=
i =C2=A0 =C2=A0 =C2=A050.00 =C2=A0<br>=C2=A0 =C2=A0720x480 =C2=A0 =C2=A0 =
=C2=A0 60.00 =C2=A0 =C2=A059.94 =C2=A0<br>=C2=A0 =C2=A0720x480i =C2=A0 =C2=
=A0 =C2=A060.00 =C2=A0 =C2=A059.94 =C2=A0<br>=C2=A0 =C2=A0640x480 =C2=A0 =
=C2=A0 =C2=A0 75.00 =C2=A0 =C2=A072.81 =C2=A0 =C2=A066.67 =C2=A0 =C2=A060.0=
0 =C2=A0 =C2=A059.94 =C2=A0<br>=C2=A0 =C2=A0720x400 =C2=A0 =C2=A0 =C2=A0 70=
.08 =C2=A0<br>DVI-0 disconnected (normal left inverted right x axis y axis)=
</div><div><br></div><div>I think the driver should only support resolution=
s that are <b>progressive</b>, but also at least of <b>50Hz</b>.<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig &lt;<a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Mhm, no idea why an interlaced resolution would cause a crash. Maybe
    some miscalculation in the display code.<br>
    <br>
    But apart from that if you just connected your PC to a TV I also
    wouldn&#39;t recommend using an interlaced resolution in the first
    place.<br>
    <br>
    See those resolutions only exists for backward compatibility with
    analog hardware.<br>
    <br>
    I think we would just disable those modes instead of searching for
    the bug.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div>Am 30.03.21 um 11:07 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>I guessed so.</div>
        <div><br>
        </div>
        <div>The GPU is a Radeon HD5870, and the screen is an old
          Telefunken TV (TLFK22LEDPVR1).</div>
        <div><br>
        </div>
        <div>Since my real display got into repair I used this TV
          meanwhile, and to my surprise it froze the system.<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Mar 2021 at 10:15,
          Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.c=
om" target=3D"_blank">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi
          Alberto,<br>
          <br>
          well what hardware do you have?<br>
          <br>
          Interlaced resolutions are not used any more on modern
          hardware, so they <br>
          are not well tested.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:<br>
          &gt; The entire desktop hangs after some minutes when using
          the module <br>
          &gt; &quot;radeon&quot; with an interlaced resolution.<br>
          &gt;<br>
          &gt; Easier to trigger by playing a video on Firefox, at least
          on kwin_x11. <br>
          &gt; Wayland didn&#39;t exhibit the problem.<br>
          &gt;<br>
          &gt; Other display drivers, from different computers I have
          tried, didn&#39;t <br>
          &gt; allow those interlaced resolutions all together. It seems
          they know <br>
          &gt; there will be problems.<br>
          <br>
        </blockquote>
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

--000000000000aa132005bec2c624--

--===============1448688380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1448688380==--
