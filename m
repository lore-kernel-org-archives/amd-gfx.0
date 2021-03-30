Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1344EC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 21:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B886199A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 21:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B886199A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F456E97D;
	Tue, 30 Mar 2021 21:00:39 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AFC6E97D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 20:59:35 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id b4so25824739lfi.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BiwUrX3sWAEN6DFI8USaGCyWSc9iwGCLu50LWDaaVS0=;
 b=evlKS4gp5I5yTnyAnygac3GqKtsk2iCg1Q6RL/r349hTobMT3HtEl6SlrI11LW0IFT
 qhy6KCZOkET1WcJQCv3jQcgthLM22ly18nMtjtTaLPBH8dgDXfsRXfQe84VZeIgWzaY2
 ifAfcXQtav2krKneBN2OV5cNxKyA5vW8S4o4AkqdFAWc/gM70f0Cde1cTXM8LYlQdFW9
 BarUdQLJWW5Jz4J0+snve5vv03Qnzcx2Rw0Pj6iotpEQMCiMEvK1qTV1SyCRdChGXShd
 lNcGCaJuuuEYFeI6JYwVudfrrrzFRWUKpDdbAim3H2aKq29LqPaUe4JOrPQUNoNRcoAO
 R/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BiwUrX3sWAEN6DFI8USaGCyWSc9iwGCLu50LWDaaVS0=;
 b=KajINPYygVbPvnUD8+fvPTc4rcTFZ2xXSmTiVHRr73nOdUXrls7zJ1Ero+EzMU6Eh3
 jg5l3tzZi87WBxRsbL3LaMPjwrSAzMzO5IQ3vyuVCVg3rFGd6yMzwr6vDWODYFGJXHsi
 +iOndhGkW2fZY61kEUIB+8b49Kr/C/izFRwLa/g1m0z79MbxABEKd4rU62aBIM20Ou7G
 9oEvFJvLP2oksnQy9F7922xXvw3NaZGGuQmx1ZDKy/1Y/lIE6Gdj1E6Ed/ZSQtQYRp21
 FKpT5dRzF6DhE3aCosoPg6s1S1yNSNTSlFtRD+bYucz2GqZyDm7sKYliMNXq1MtW6VjL
 0CZg==
X-Gm-Message-State: AOAM530bIi3eI3ibQMxwMnzZEn72lcQaKFitCjum31hfTcCO4tMRCVyZ
 /LpnZzZ1Rk9GwFVqfAuUj31rYYKtBpMmtSiLo0o=
X-Google-Smtp-Source: ABdhPJwhoNMq42xjvs6GcnlqrlLGsFqj94Olz1b3Y06dRPPNyU5wwJUVepv4XVwZxRgnX067va/drrK093AR6EGQjJc=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr21312427lfd.547.1617137973586; 
 Tue, 30 Mar 2021 13:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
In-Reply-To: <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
From: Alberto Salvia Novella <es20490446e@gmail.com>
Date: Tue, 30 Mar 2021 22:59:22 +0200
Message-ID: <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Tue, 30 Mar 2021 21:00:37 +0000
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 benh@kernel.crashing.org
Content-Type: multipart/mixed; boundary="===============1964602205=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1964602205==
Content-Type: multipart/alternative; boundary="00000000000077ec9d05bec7462e"

--00000000000077ec9d05bec7462e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The frame-rate at 24Hz is extremely poor for normal desktop usage.

If the highest resolution, aka 1080p, uses that refresh rate then the
desktop will default to that frame-rate.

Other progressive modes don't exhibit any issue.

On Tue, 30 Mar 2021 at 18:26, Christian K=C3=B6nig <christian.koenig@amd.co=
m>
wrote:

> Hi Alberto,
>
> I think the driver should only support resolutions that are *progressive*=
,
> but also at least of *50Hz*.
>
>
> Why do you think so?, the 24Hz resolution seems to be the native one of
> the display.
>
> Regards,
> Christian.
>
> Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>
> This is why I'm using interlaced:
>
> $ *xrandr*
> Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
> DisplayPort-0 disconnected (normal left inverted right x axis y axis)
> HDMI-0 connected primary 1920x1080+0+0 (normal left inverted right x axis
> y axis) 16mm x 9mm
>    1920x*1080i*    60.00*+  50.00    59.94
>    1920x1080     *24.00*    23.98
>    1280x*720*      60.00    50.00    59.94
>    1024x768      75.03    70.07    60.00
>    832x624       74.55
>    800x600       72.19    75.00    60.32    56.25
>    720x576       50.00
>    720x576i      50.00
>    720x480       60.00    59.94
>    720x480i      60.00    59.94
>    640x480       75.00    72.81    66.67    60.00    59.94
>    720x400       70.08
> DVI-0 disconnected (normal left inverted right x axis y axis)
>
> I think the driver should only support resolutions that are *progressive*=
,
> but also at least of *50Hz*.
>
> On Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Mhm, no idea why an interlaced resolution would cause a crash. Maybe som=
e
>> miscalculation in the display code.
>>
>> But apart from that if you just connected your PC to a TV I also wouldn'=
t
>> recommend using an interlaced resolution in the first place.
>>
>> See those resolutions only exists for backward compatibility with analog
>> hardware.
>>
>> I think we would just disable those modes instead of searching for the
>> bug.
>>
>> Regards,
>> Christian.
>>
>> Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>
>> I guessed so.
>>
>> The GPU is a Radeon HD5870, and the screen is an old Telefunken TV
>> (TLFK22LEDPVR1).
>>
>> Since my real display got into repair I used this TV meanwhile, and to m=
y
>> surprise it froze the system.
>>
>> On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <christian.koenig@amd=
.com>
>> wrote:
>>
>>> Hi Alberto,
>>>
>>> well what hardware do you have?
>>>
>>> Interlaced resolutions are not used any more on modern hardware, so the=
y
>>> are not well tested.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>> > The entire desktop hangs after some minutes when using the module
>>> > "radeon" with an interlaced resolution.
>>> >
>>> > Easier to trigger by playing a video on Firefox, at least on kwin_x11=
.
>>> > Wayland didn't exhibit the problem.
>>> >
>>> > Other display drivers, from different computers I have tried, didn't
>>> > allow those interlaced resolutions all together. It seems they know
>>> > there will be problems.
>>>
>>>
>> _______________________________________________
>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskt=
op.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook=
.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-=
gfx&data=3D04%7C01%7Cchristian.koenig%40amd.com%7C71c42210b976438bfbb908d8f=
391bb3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527154536688236%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C1000&sdata=3DjfWL5eoMUhK5phoM1Xs6Nv7SLsKCst7wWwq5URYNazk%3D&=
reserved=3D0>
>>
>>
>>
>

--00000000000077ec9d05bec7462e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The frame-rate at 24Hz is extremely poor for normal d=
esktop usage.<br></div><div><br></div><div>If the highest resolution, aka 1=
080p, uses that refresh rate then the desktop will default to that frame-ra=
te.</div><div><br></div><div>Other progressive modes don&#39;t exhibit any =
issue.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, 30 Mar 2021 at 18:26, Christian K=C3=B6nig &lt;<a h=
ref=3D"mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">

 =20
  <div>
    Hi Alberto,<br>
    <br>
    <blockquote type=3D"cite">I think the driver should only support
      resolutions that are <b>progressive</b>, but also at least of <b>50Hz=
</b>.</blockquote>
    <br>
    Why do you think so?, the 24Hz resolution seems to be the native one
    of the display.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div>Am 30.03.21 um 17:37 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>This is why I&#39;m using interlaced:<br>
        </div>
        <div><br>
        </div>
        <div>$ <b>xrandr</b><br>
          Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192
          x 8192<br>
          DisplayPort-0 disconnected (normal left inverted right x axis
          y axis)<br>
          HDMI-0 connected primary 1920x1080+0+0 (normal left inverted
          right x axis y axis) 16mm x 9mm<br>
          =C2=A0 =C2=A01920x<b>1080i</b> =C2=A0 =C2=A060.00*+ =C2=A050.00 =
=C2=A0 =C2=A059.94 =C2=A0<br>
          =C2=A0 =C2=A01920x1080 =C2=A0 =C2=A0 <b>24.00</b> =C2=A0 =C2=A023=
.98 =C2=A0<br>
          =C2=A0 =C2=A01280x<b>720</b> =C2=A0 =C2=A0 =C2=A060.00 =C2=A0 =C2=
=A050.00 =C2=A0 =C2=A059.94 =C2=A0<br>
          =C2=A0 =C2=A01024x768 =C2=A0 =C2=A0 =C2=A075.03 =C2=A0 =C2=A070.0=
7 =C2=A0 =C2=A060.00 =C2=A0<br>
          =C2=A0 =C2=A0832x624 =C2=A0 =C2=A0 =C2=A0 74.55 =C2=A0<br>
          =C2=A0 =C2=A0800x600 =C2=A0 =C2=A0 =C2=A0 72.19 =C2=A0 =C2=A075.0=
0 =C2=A0 =C2=A060.32 =C2=A0 =C2=A056.25 =C2=A0<br>
          =C2=A0 =C2=A0720x576 =C2=A0 =C2=A0 =C2=A0 50.00 =C2=A0<br>
          =C2=A0 =C2=A0720x576i =C2=A0 =C2=A0 =C2=A050.00 =C2=A0<br>
          =C2=A0 =C2=A0720x480 =C2=A0 =C2=A0 =C2=A0 60.00 =C2=A0 =C2=A059.9=
4 =C2=A0<br>
          =C2=A0 =C2=A0720x480i =C2=A0 =C2=A0 =C2=A060.00 =C2=A0 =C2=A059.9=
4 =C2=A0<br>
          =C2=A0 =C2=A0640x480 =C2=A0 =C2=A0 =C2=A0 75.00 =C2=A0 =C2=A072.8=
1 =C2=A0 =C2=A066.67 =C2=A0 =C2=A060.00 =C2=A0 =C2=A059.94 =C2=A0<br>
          =C2=A0 =C2=A0720x400 =C2=A0 =C2=A0 =C2=A0 70.08 =C2=A0<br>
          DVI-0 disconnected (normal left inverted right x axis y axis)</di=
v>
        <div><br>
        </div>
        <div>I think the driver should only support resolutions that are
          <b>progressive</b>, but also at least of <b>50Hz</b>.<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Mar 2021 at 15:41,
          Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken=
@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Mhm, no idea why an interlaced resolution would cause a
            crash. Maybe some miscalculation in the display code.<br>
            <br>
            But apart from that if you just connected your PC to a TV I
            also wouldn&#39;t recommend using an interlaced resolution in
            the first place.<br>
            <br>
            See those resolutions only exists for backward compatibility
            with analog hardware.<br>
            <br>
            I think we would just disable those modes instead of
            searching for the bug.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>I guessed so.</div>
                <div><br>
                </div>
                <div>The GPU is a Radeon HD5870, and the screen is an
                  old Telefunken TV (TLFK22LEDPVR1).</div>
                <div><br>
                </div>
                <div>Since my real display got into repair I used this
                  TV meanwhile, and to my surprise it froze the system.<br>
                </div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Mar 2021 a=
t
                  10:15, Christian K=C3=B6nig &lt;<a href=3D"mailto:christi=
an.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Albert=
o,<br>
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
                  &gt; The entire desktop hangs after some minutes when
                  using the module <br>
                  &gt; &quot;radeon&quot; with an interlaced resolution.<br=
>
                  &gt;<br>
                  &gt; Easier to trigger by playing a video on Firefox,
                  at least on kwin_x11. <br>
                  &gt; Wayland didn&#39;t exhibit the problem.<br>
                  &gt;<br>
                  &gt; Other display drivers, from different computers I
                  have tried, didn&#39;t <br>
                  &gt; allow those interlaced resolutions all together.
                  It seems they know <br>
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
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Cchristian.koenig%40amd.com%7C71c42210b976438bfbb908d8f391bb3f%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637527154536688236%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3DjfWL5eoMUhK5phoM1Xs6Nv7SLsKCst7wWwq5URYNazk%3D&amp;reserved=
=3D0" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>
</pre>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--00000000000077ec9d05bec7462e--

--===============1964602205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1964602205==--
