Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD1FC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 08:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBFB619D3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 08:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBFB619D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127356EA07;
	Wed, 31 Mar 2021 08:11:23 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFF46E9FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 07:21:56 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id f16so22690432ljm.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T9mpbG0LKZeMMuNxWV0NvqO5oakAI5+YdJkkB+P+Me4=;
 b=MDrbEILXDKu2WlNoJD551OFsm7EvtqFjcZ5nPAcYjOeckOotOm3ZH4U0mNa5cyV0HG
 ZS6opq53KVIWaKdrHa5Wd9mWOGrUuImwpw+UAI1aYIZpOk/0o8H3pnQs74cV5irTb+zD
 I09qYRZ2anghNE5l/IsnjHljdbth1PlV8PqwCENorEjgY2PuZhPuvRFKoec5T9aKsCJ2
 RV+xO7wylAYq+o9l7AxptA5fmX+fawaqmVXfSxv9wn5kDev6X5APIq2FQkVLf8rQRT2o
 mx0HX/bJ0JDBMhQj2yOKa0GFyJB9OJ+hSOSh7x6Dwh/whFo8MVaw+92aVWkQpGshkezp
 3i3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T9mpbG0LKZeMMuNxWV0NvqO5oakAI5+YdJkkB+P+Me4=;
 b=AmJ53140WRGBOtb6eSjWD1+9XaW5o5AXorkUzr2O9xLXBveB9pQb7+pz8o1tvuNEiN
 DHte2Jb8GtI2UnhZKiPBpsHEBto2weU24CsnxIoyDcJSPB1clUnO9U8/CP1GFEvybVU9
 NMqQvybXTXIAoBWRdDBKX97mIB6Y9y6y1pnWT2BoFQpo+QcLBP4t39+8oz+klWBbOmn+
 DWG5AFoIaBw4lur+JgOgAlh6h7uF6EK5q1KJueWlTqlPOdDJ/P5rx8ZgUerv2pFgryMx
 kNsF3vEEb9NATgJ+zxgpIldq94Omi9xogpfLMr072CnPXAlpl91yJFboDWCTFUBpZOmk
 5hUw==
X-Gm-Message-State: AOAM530106ccFx3i5smXT1QZPATskFCn7dInKJAM7m56/Nv3edUPT82L
 /0dPkPzzFHGGURw1yr4ITC13rmAawGu6xOyBlLM=
X-Google-Smtp-Source: ABdhPJx2EDlEK4QHeRPZOf+JKH6JApS1oFfLSNIIj1JszBHpvMET1hMcHqwYjZSGqvmRikv6y8bumN+YSXIJilXxmV8=
X-Received: by 2002:a2e:8591:: with SMTP id b17mr1196244lji.230.1617175315043; 
 Wed, 31 Mar 2021 00:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
 <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
 <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
In-Reply-To: <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
From: Alberto Salvia Novella <es20490446e@gmail.com>
Date: Wed, 31 Mar 2021 09:21:43 +0200
Message-ID: <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Wed, 31 Mar 2021 08:11:22 +0000
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
Content-Type: multipart/mixed; boundary="===============0706022565=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0706022565==
Content-Type: multipart/alternative; boundary="0000000000003159a105becff844"

--0000000000003159a105becff844
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

24fps is intended for video only. Anything interactive at 24fps, as just
moving the mouse around, is extremely choppy.

No way anyone would prefer that over an interlaced resolution or a lower
resolution. That is, by far, the worst option.

Just try it on your screen, set it to 24Hz or alike, and tell me your
experience. You can't even tell where the mouse is going to go.

On Wed, 31 Mar 2021 at 08:44, Christian K=C3=B6nig <christian.koenig@amd.co=
m>
wrote:

> Hi Alberto,
>
> well a frame rate of 24Hz is perfectly reasonable for a TV and desktop
> usage.
>
> This is probably caused by the TVs limited HDMI bandwidth and a refresh
> rate of 30/25 Hz for the interlaced mode isn't much better either.
>
> Regards,
> Christian.
>
> Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
>
> The frame-rate at 24Hz is extremely poor for normal desktop usage.
>
> If the highest resolution, aka 1080p, uses that refresh rate then the
> desktop will default to that frame-rate.
>
> Other progressive modes don't exhibit any issue.
>
> On Tue, 30 Mar 2021 at 18:26, Christian K=C3=B6nig <christian.koenig@amd.=
com>
> wrote:
>
>> Hi Alberto,
>>
>> I think the driver should only support resolutions that are *progressive=
*,
>> but also at least of *50Hz*.
>>
>>
>> Why do you think so?, the 24Hz resolution seems to be the native one of
>> the display.
>>
>> Regards,
>> Christian.
>>
>> Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>>
>> This is why I'm using interlaced:
>>
>> $ *xrandr*
>> Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
>> DisplayPort-0 disconnected (normal left inverted right x axis y axis)
>> HDMI-0 connected primary 1920x1080+0+0 (normal left inverted right x axi=
s
>> y axis) 16mm x 9mm
>>    1920x*1080i*    60.00*+  50.00    59.94
>>    1920x1080     *24.00*    23.98
>>    1280x*720*      60.00    50.00    59.94
>>    1024x768      75.03    70.07    60.00
>>    832x624       74.55
>>    800x600       72.19    75.00    60.32    56.25
>>    720x576       50.00
>>    720x576i      50.00
>>    720x480       60.00    59.94
>>    720x480i      60.00    59.94
>>    640x480       75.00    72.81    66.67    60.00    59.94
>>    720x400       70.08
>> DVI-0 disconnected (normal left inverted right x axis y axis)
>>
>> I think the driver should only support resolutions that are *progressive=
*,
>> but also at least of *50Hz*.
>>
>> On Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig <
>> ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>> Mhm, no idea why an interlaced resolution would cause a crash. Maybe
>>> some miscalculation in the display code.
>>>
>>> But apart from that if you just connected your PC to a TV I also
>>> wouldn't recommend using an interlaced resolution in the first place.
>>>
>>> See those resolutions only exists for backward compatibility with analo=
g
>>> hardware.
>>>
>>> I think we would just disable those modes instead of searching for the
>>> bug.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>>
>>> I guessed so.
>>>
>>> The GPU is a Radeon HD5870, and the screen is an old Telefunken TV
>>> (TLFK22LEDPVR1).
>>>
>>> Since my real display got into repair I used this TV meanwhile, and to
>>> my surprise it froze the system.
>>>
>>> On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <christian.koenig@am=
d.com>
>>> wrote:
>>>
>>>> Hi Alberto,
>>>>
>>>> well what hardware do you have?
>>>>
>>>> Interlaced resolutions are not used any more on modern hardware, so
>>>> they
>>>> are not well tested.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>>> > The entire desktop hangs after some minutes when using the module
>>>> > "radeon" with an interlaced resolution.
>>>> >
>>>> > Easier to trigger by playing a video on Firefox, at least on
>>>> kwin_x11.
>>>> > Wayland didn't exhibit the problem.
>>>> >
>>>> > Other display drivers, from different computers I have tried, didn't
>>>> > allow those interlaced resolutions all together. It seems they know
>>>> > there will be problems.
>>>>
>>>>
>>> _______________________________________________
>>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedesk=
top.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd=
-gfx&data=3D04%7C01%7Cchristian.koenig%40amd.com%7C24d157e6250d4979c5fc08d8=
f3beb949%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527347790767402%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&sdata=3DefPyW%2BUl4PhnDWqghsRmaE7DKAUYoylzMP529%2BWrHD=
U%3D&reserved=3D0>
>>>
>>>
>>>
>>
>

--0000000000003159a105becff844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>24fps is intended for video only. Anything interactiv=
e at 24fps, as just moving the mouse around, is extremely choppy.</div><div=
><br></div><div>No way anyone would prefer that over an interlaced resoluti=
on or a lower resolution. That is, by far, the worst option.</div><div><br>=
</div><div>Just try it on your screen, set it to 24Hz or alike, and tell me=
 your experience. You can&#39;t even tell where the mouse is going to go.<b=
r></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Wed, 31 Mar 2021 at 08:44, Christian K=C3=B6nig &lt;<a href=3D"m=
ailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">

 =20
  <div>
    Hi Alberto,<br>
    <br>
    well a frame rate of 24Hz is perfectly reasonable for a TV and
    desktop usage.<br>
    <br>
    This is probably caused by the TVs limited HDMI bandwidth and a
    refresh rate of 30/25 Hz for the interlaced mode isn&#39;t much better
    either.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div>Am 30.03.21 um 22:59 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>The frame-rate at 24Hz is extremely poor for normal desktop
          usage.<br>
        </div>
        <div><br>
        </div>
        <div>If the highest resolution, aka 1080p, uses that refresh
          rate then the desktop will default to that frame-rate.</div>
        <div><br>
        </div>
        <div>Other progressive modes don&#39;t exhibit any issue.<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Mar 2021 at 18:26,
          Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.c=
om" target=3D"_blank">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Hi Alberto,<br>
            <br>
            <blockquote type=3D"cite">I think the driver should only
              support resolutions that are <b>progressive</b>, but also
              at least of <b>50Hz</b>.</blockquote>
            <br>
            Why do you think so?, the 24Hz resolution seems to be the
            native one of the display.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>This is why I&#39;m using interlaced:<br>
                </div>
                <div><br>
                </div>
                <div>$ <b>xrandr</b><br>
                  Screen 0: minimum 320 x 200, current 1920 x 1080,
                  maximum 8192 x 8192<br>
                  DisplayPort-0 disconnected (normal left inverted right
                  x axis y axis)<br>
                  HDMI-0 connected primary 1920x1080+0+0 (normal left
                  inverted right x axis y axis) 16mm x 9mm<br>
                  =C2=A0 =C2=A01920x<b>1080i</b> =C2=A0 =C2=A060.00*+ =C2=
=A050.00 =C2=A0 =C2=A059.94 =C2=A0<br>
                  =C2=A0 =C2=A01920x1080 =C2=A0 =C2=A0 <b>24.00</b> =C2=A0 =
=C2=A023.98 =C2=A0<br>
                  =C2=A0 =C2=A01280x<b>720</b> =C2=A0 =C2=A0 =C2=A060.00 =
=C2=A0 =C2=A050.00 =C2=A0 =C2=A059.94 =C2=A0<br>
                  =C2=A0 =C2=A01024x768 =C2=A0 =C2=A0 =C2=A075.03 =C2=A0 =
=C2=A070.07 =C2=A0 =C2=A060.00 =C2=A0<br>
                  =C2=A0 =C2=A0832x624 =C2=A0 =C2=A0 =C2=A0 74.55 =C2=A0<br=
>
                  =C2=A0 =C2=A0800x600 =C2=A0 =C2=A0 =C2=A0 72.19 =C2=A0 =
=C2=A075.00 =C2=A0 =C2=A060.32 =C2=A0 =C2=A056.25 =C2=A0<br>
                  =C2=A0 =C2=A0720x576 =C2=A0 =C2=A0 =C2=A0 50.00 =C2=A0<br=
>
                  =C2=A0 =C2=A0720x576i =C2=A0 =C2=A0 =C2=A050.00 =C2=A0<br=
>
                  =C2=A0 =C2=A0720x480 =C2=A0 =C2=A0 =C2=A0 60.00 =C2=A0 =
=C2=A059.94 =C2=A0<br>
                  =C2=A0 =C2=A0720x480i =C2=A0 =C2=A0 =C2=A060.00 =C2=A0 =
=C2=A059.94 =C2=A0<br>
                  =C2=A0 =C2=A0640x480 =C2=A0 =C2=A0 =C2=A0 75.00 =C2=A0 =
=C2=A072.81 =C2=A0 =C2=A066.67 =C2=A0 =C2=A060.00 =C2=A0
                  =C2=A059.94 =C2=A0<br>
                  =C2=A0 =C2=A0720x400 =C2=A0 =C2=A0 =C2=A0 70.08 =C2=A0<br=
>
                  DVI-0 disconnected (normal left inverted right x axis
                  y axis)</div>
                <div><br>
                </div>
                <div>I think the driver should only support resolutions
                  that are <b>progressive</b>, but also at least of <b>50Hz=
</b>.<br>
                </div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Mar 2021 a=
t
                  15:41, Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig=
.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.c=
om</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  <div> Mhm, no idea why an interlaced resolution would
                    cause a crash. Maybe some miscalculation in the
                    display code.<br>
                    <br>
                    But apart from that if you just connected your PC to
                    a TV I also wouldn&#39;t recommend using an interlaced
                    resolution in the first place.<br>
                    <br>
                    See those resolutions only exists for backward
                    compatibility with analog hardware.<br>
                    <br>
                    I think we would just disable those modes instead of
                    searching for the bug.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <div>Am 30.03.21 um 11:07 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type=3D"cite">
                      <div dir=3D"ltr">
                        <div>I guessed so.</div>
                        <div><br>
                        </div>
                        <div>The GPU is a Radeon HD5870, and the screen
                          is an old Telefunken TV (TLFK22LEDPVR1).</div>
                        <div><br>
                        </div>
                        <div>Since my real display got into repair I
                          used this TV meanwhile, and to my surprise it
                          froze the system.<br>
                        </div>
                      </div>
                      <br>
                      <div class=3D"gmail_quote">
                        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Ma=
r
                          2021 at 10:15, Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd=
.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i Alberto,<br>
                          <br>
                          well what hardware do you have?<br>
                          <br>
                          Interlaced resolutions are not used any more
                          on modern hardware, so they <br>
                          are not well tested.<br>
                          <br>
                          Regards,<br>
                          Christian.<br>
                          <br>
                          Am 30.03.21 um 10:04 schrieb Alberto Salvia
                          Novella:<br>
                          &gt; The entire desktop hangs after some
                          minutes when using the module <br>
                          &gt; &quot;radeon&quot; with an interlaced resolu=
tion.<br>
                          &gt;<br>
                          &gt; Easier to trigger by playing a video on
                          Firefox, at least on kwin_x11. <br>
                          &gt; Wayland didn&#39;t exhibit the problem.<br>
                          &gt;<br>
                          &gt; Other display drivers, from different
                          computers I have tried, didn&#39;t <br>
                          &gt; allow those interlaced resolutions all
                          together. It seems they know <br>
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
%7Cchristian.koenig%40amd.com%7C24d157e6250d4979c5fc08d8f3beb949%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637527347790767402%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3DefPyW%2BUl4PhnDWqghsRmaE7DKAUYoylzMP529%2BWrHDU%3D&amp;reserv=
ed=3D0" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/am=
d-gfx</a>
</pre>
                    </blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--0000000000003159a105becff844--

--===============0706022565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0706022565==--
