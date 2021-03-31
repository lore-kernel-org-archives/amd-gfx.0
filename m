Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7696C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802BB61008
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802BB61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DEB66EAB1;
	Wed, 31 Mar 2021 14:41:02 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B119D6E1F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 14:33:57 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id g8so29465810lfv.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nGOz5MO9cmPK8VT5b/KFPU2MX5HuBe/eh4ugjn19dew=;
 b=r384KC6RzsxWkGINKmNh0cyNnaWHodGhhsRYm6NtDS6ENN2PKQE3aotxd2c3xL2N8g
 DQ1mAfO2qaOc9onbTPbOqJGBMI+ZQcaFYX297A0bF2i/PYpKeR8MdfNrkZl3+KMRJROq
 vNb2reFRWE7sef+xAvL+CBwvYz4WBohlGgU5aCuWvsGUgQUqq2afjimsI15K/wUYVAlv
 /ixNsTCUcSDMrBGZUGNU2GBrA+o16qx9X4IeIIU6nfYmJYkwU8o8lWRi6dXVOtPRr1hx
 322gLITybD6zYJv4w1c/uGnzs9kLd9gGwBxkWH8UavANrIYjT9R1Mo/+PxbOmZbOttrE
 dLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nGOz5MO9cmPK8VT5b/KFPU2MX5HuBe/eh4ugjn19dew=;
 b=CYRyZvy5Iw0YGDI4Qw7cu4MF58uwc86HC1VaiVA7KwrlTKqjAXtRo+Ahef4gMLN5Np
 l4pkM9NiFqpVG9Pqr9mN8uX9THlA2EPmIhPT1etVOV11uX3QJNjzRBbBOCmmG2x6o3R8
 I3vh/mEaur0SrbsP0ITv1sbWi8d4PMRIdhZTZ3Aic4JOLuKeAx/9Yc76mGaVNL2n3+KN
 fCuX0lrhUTRuggoDabK9jnN3MxguGg2ZHXzD9tNXzO+ZNUJcqSM56PlY0+sDhG6AMPuq
 EOvvvApbvyPwS1JFbHiWPoOb5R4DbuWJXn94qHY9bAXWYnatg0KNJBc2/pmAF2hluMrN
 CGkQ==
X-Gm-Message-State: AOAM532GbuKQohXsvlu+T/kcL9kneAFkproCfgQbkCPffwcNHF2Z9wsQ
 MneDz8w63kiTSoYihDk6FvqqoT3tnsvnwnOjvWY=
X-Google-Smtp-Source: ABdhPJzVGjs3OwglbAlPR+0TWWpmQxKpQzFNKK7TqDoKjmdEw0FM+xkDR4LkblZ3R7PIsdqyu7KGqejT0BaQyaKAqY4=
X-Received: by 2002:a05:6512:370f:: with SMTP id
 z15mr2433778lfr.562.1617201236158; 
 Wed, 31 Mar 2021 07:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
 <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
 <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
 <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
 <7914f67b-e011-36ec-3f6d-1614ce96e3c4@amd.com>
 <CAHJvkbvQ3jTyoHfQjOkSqierLQfFTb7kqZwdfxs86yunvCvj6g@mail.gmail.com>
 <f000cbf3-cea2-c574-2b93-6c5f45ca28e2@amd.com>
In-Reply-To: <f000cbf3-cea2-c574-2b93-6c5f45ca28e2@amd.com>
From: Alberto Salvia Novella <es20490446e@gmail.com>
Date: Wed, 31 Mar 2021 16:33:44 +0200
Message-ID: <CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Wed, 31 Mar 2021 14:41:01 +0000
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
Content-Type: multipart/mixed; boundary="===============1814394021=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1814394021==
Content-Type: multipart/alternative; boundary="000000000000362eaa05bed6018f"

--000000000000362eaa05bed6018f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

- The computer still replies to *ping*.
- The *journal* shows no errors, but a few warnings
<https://bin.privacytools.io/?5a0bf22220398549#D8SPwPEh8A5BuKN6TkU78gAgEPgr=
Uok4fCjcaucSEnyy>
.
- The *mouse* doesn't freeze.

On Wed, 31 Mar 2021 at 10:09, Christian K=C3=B6nig <christian.koenig@amd.co=
m>
wrote:

> Can you access the system over the network and see if there is anything i=
n
> the system log?
>
> It sounds like the display stack has crashed, but when the sound keeps
> playing the system is most likely still responsive over network.
>
> Thanks,
> Christian.
>
> Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:
>
> What happens is this simple: after a few minutes, about 6 or so, the
> entire content of the screen stays still. In some minor situations only t=
he
> applications panel of KDE Plasma.
>
> If music is playing it continues playing, so only graphics are hung. Yet
> in most cases the power button won't shut down the computer, as it usuall=
y
> does.
>
> At least this is the case using kwin on x11, and not on wayland. It only
> happens on "radeon" and not on Intel or "radeonhd".
>
> On Wed, 31 Mar 2021 at 09:48, Christian K=C3=B6nig <christian.koenig@amd.=
com>
> wrote:
>
>> Correct, but a TV is intended for videos only. That's why it implements
>> only the lower HDMI standard.
>>
>> Interlaced transmits only halve the lines with each frame, so a 60Hz mod=
e
>> effectively either becomes a 30Hz mode, halving the vertical resolution =
or
>> adaptive motion compensated which the know visual artifacts. Depending o=
n
>> what the deinterlacing setting on your TV is.
>>
>> You could just add a progressive 1920x540@60 or 1920x1080@30 mode
>> manually and would have the same effect with probably better quality. Se=
e
>> https://de.wikipedia.org/wiki/Deinterlacing
>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fde.=
wikipedia.org%2Fwiki%2FDeinterlacing&data=3D04%7C01%7Cchristian.koenig%40am=
d.com%7Ccf4929c9c3024efb7c4608d8f41bc0d0%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637527747331540923%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3D7dTqbjDCQaDTGc=
XA3yt8jKzSnT%2BrqcdkMhukqyOGwg0%3D&reserved=3D0>
>> for reference.
>>
>> If you can give us some more information what is happening when the
>> system freeze we could try to narrow this down, but we can't spend much
>> time on a very specific use case in a driver which is in maintenance mod=
e.
>>
>> Regards,
>> Christian.
>>
>> Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
>>
>> 24fps is intended for video only. Anything interactive at 24fps, as just
>> moving the mouse around, is extremely choppy.
>>
>> No way anyone would prefer that over an interlaced resolution or a lower
>> resolution. That is, by far, the worst option.
>>
>> Just try it on your screen, set it to 24Hz or alike, and tell me your
>> experience. You can't even tell where the mouse is going to go.
>>
>> On Wed, 31 Mar 2021 at 08:44, Christian K=C3=B6nig <christian.koenig@amd=
.com>
>> wrote:
>>
>>> Hi Alberto,
>>>
>>> well a frame rate of 24Hz is perfectly reasonable for a TV and desktop
>>> usage.
>>>
>>> This is probably caused by the TVs limited HDMI bandwidth and a refresh
>>> rate of 30/25 Hz for the interlaced mode isn't much better either.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
>>>
>>> The frame-rate at 24Hz is extremely poor for normal desktop usage.
>>>
>>> If the highest resolution, aka 1080p, uses that refresh rate then the
>>> desktop will default to that frame-rate.
>>>
>>> Other progressive modes don't exhibit any issue.
>>>
>>> On Tue, 30 Mar 2021 at 18:26, Christian K=C3=B6nig <christian.koenig@am=
d.com>
>>> wrote:
>>>
>>>> Hi Alberto,
>>>>
>>>> I think the driver should only support resolutions that are
>>>> *progressive*, but also at least of *50Hz*.
>>>>
>>>>
>>>> Why do you think so?, the 24Hz resolution seems to be the native one o=
f
>>>> the display.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>>>>
>>>> This is why I'm using interlaced:
>>>>
>>>> $ *xrandr*
>>>> Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
>>>> DisplayPort-0 disconnected (normal left inverted right x axis y axis)
>>>> HDMI-0 connected primary 1920x1080+0+0 (normal left inverted right x
>>>> axis y axis) 16mm x 9mm
>>>>    1920x*1080i*    60.00*+  50.00    59.94
>>>>    1920x1080     *24.00*    23.98
>>>>    1280x*720*      60.00    50.00    59.94
>>>>    1024x768      75.03    70.07    60.00
>>>>    832x624       74.55
>>>>    800x600       72.19    75.00    60.32    56.25
>>>>    720x576       50.00
>>>>    720x576i      50.00
>>>>    720x480       60.00    59.94
>>>>    720x480i      60.00    59.94
>>>>    640x480       75.00    72.81    66.67    60.00    59.94
>>>>    720x400       70.08
>>>> DVI-0 disconnected (normal left inverted right x axis y axis)
>>>>
>>>> I think the driver should only support resolutions that are
>>>> *progressive*, but also at least of *50Hz*.
>>>>
>>>> On Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig <
>>>> ckoenig.leichtzumerken@gmail.com> wrote:
>>>>
>>>>> Mhm, no idea why an interlaced resolution would cause a crash. Maybe
>>>>> some miscalculation in the display code.
>>>>>
>>>>> But apart from that if you just connected your PC to a TV I also
>>>>> wouldn't recommend using an interlaced resolution in the first place.
>>>>>
>>>>> See those resolutions only exists for backward compatibility with
>>>>> analog hardware.
>>>>>
>>>>> I think we would just disable those modes instead of searching for th=
e
>>>>> bug.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>>>>
>>>>> I guessed so.
>>>>>
>>>>> The GPU is a Radeon HD5870, and the screen is an old Telefunken TV
>>>>> (TLFK22LEDPVR1).
>>>>>
>>>>> Since my real display got into repair I used this TV meanwhile, and t=
o
>>>>> my surprise it froze the system.
>>>>>
>>>>> On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <
>>>>> christian.koenig@amd.com> wrote:
>>>>>
>>>>>> Hi Alberto,
>>>>>>
>>>>>> well what hardware do you have?
>>>>>>
>>>>>> Interlaced resolutions are not used any more on modern hardware, so
>>>>>> they
>>>>>> are not well tested.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>>>>> > The entire desktop hangs after some minutes when using the module
>>>>>> > "radeon" with an interlaced resolution.
>>>>>> >
>>>>>> > Easier to trigger by playing a video on Firefox, at least on
>>>>>> kwin_x11.
>>>>>> > Wayland didn't exhibit the problem.
>>>>>> >
>>>>>> > Other display drivers, from different computers I have tried,
>>>>>> didn't
>>>>>> > allow those interlaced resolutions all together. It seems they kno=
w
>>>>>> > there will be problems.
>>>>>>
>>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freede=
sktop.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outl=
ook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fa=
md-gfx&data=3D04%7C01%7Cchristian.koenig%40amd.com%7Ccf4929c9c3024efb7c4608=
d8f41bc0d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527747331550917%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C1000&sdata=3D5BcOM0IHbXdYbWjy1a7VQOFgbkFGoV0FMzbDmZe94l0%=
3D&reserved=3D0>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>
>

--000000000000362eaa05bed6018f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>- The computer still replies to <b>ping</b>.</div><di=
v>- The <b>journal</b> shows no errors, but a few <a href=3D"https://bin.pr=
ivacytools.io/?5a0bf22220398549#D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEny=
y">warnings</a>.</div><div>- The <b>mouse</b> doesn&#39;t freeze.<br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Wed, 31 Mar 2021 at 10:09, Christian K=C3=B6nig &lt;<a href=3D"mailto:ch=
ristian.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">

 =20
  <div>
    Can you access the system over the network and see if there is
    anything in the system log?<br>
    <br>
    It sounds like the display stack has crashed, but when the sound
    keeps playing the system is most likely still responsive over
    network.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div>Am 31.03.21 um 10:05 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>What happens is this simple: after a few minutes, about 6
          or so, the entire content of the screen stays still. In some
          minor situations only the applications panel of KDE Plasma.</div>
        <div><br>
        </div>
        <div>If music is playing it continues playing, so only graphics
          are hung. Yet in most cases the power button won&#39;t shut down
          the computer, as it usually does.<br>
        </div>
        <div><br>
        </div>
        <div>At least this is the case using kwin on x11, and not on
          wayland. It only happens on &quot;radeon&quot; and not on Intel o=
r
          &quot;radeonhd&quot;.</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Wed, 31 Mar 2021 at 09:48,
          Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.c=
om" target=3D"_blank">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Correct, but a TV is intended for videos only. That&#39;s
            why it implements only the lower HDMI standard.<br>
            <br>
            Interlaced transmits only halve the lines with each frame,
            so a 60Hz mode effectively either becomes a 30Hz mode,
            halving the vertical resolution or adaptive motion
            compensated which the know visual artifacts. Depending on
            what the deinterlacing setting on your TV is.<br>
            <br>
            You could just add a progressive 1920x540@60 or 1920x1080@30
            mode manually and would have the same effect with probably
            better quality. See <a href=3D"https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing=
&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7Ccf4929c9c3024efb7c4608d8=
f41bc0d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527747331540923%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;sdata=3D7dTqbjDCQaDTGcXA3yt8jKzSnT%2BrqcdkMhukqyOG=
wg0%3D&amp;reserved=3D0" target=3D"_blank">https://de.wikipedia.org/wiki/De=
interlacing</a>
            for reference.<br>
            <br>
            If you can give us some more information what is happening
            when the system freeze we could try to narrow this down, but
            we can&#39;t spend much time on a very specific use case in a
            driver which is in maintenance mode.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>24fps is intended for video only. Anything
                  interactive at 24fps, as just moving the mouse around,
                  is extremely choppy.</div>
                <div><br>
                </div>
                <div>No way anyone would prefer that over an interlaced
                  resolution or a lower resolution. That is, by far, the
                  worst option.</div>
                <div><br>
                </div>
                <div>Just try it on your screen, set it to 24Hz or
                  alike, and tell me your experience. You can&#39;t even
                  tell where the mouse is going to go.<br>
                </div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Wed, 31 Mar 2021 a=
t
                  08:44, Christian K=C3=B6nig &lt;<a href=3D"mailto:christi=
an.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  <div> Hi Alberto,<br>
                    <br>
                    well a frame rate of 24Hz is perfectly reasonable
                    for a TV and desktop usage.<br>
                    <br>
                    This is probably caused by the TVs limited HDMI
                    bandwidth and a refresh rate of 30/25 Hz for the
                    interlaced mode isn&#39;t much better either.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <div>Am 30.03.21 um 22:59 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type=3D"cite">
                      <div dir=3D"ltr">
                        <div>The frame-rate at 24Hz is extremely poor
                          for normal desktop usage.<br>
                        </div>
                        <div><br>
                        </div>
                        <div>If the highest resolution, aka 1080p, uses
                          that refresh rate then the desktop will
                          default to that frame-rate.</div>
                        <div><br>
                        </div>
                        <div>Other progressive modes don&#39;t exhibit any
                          issue.<br>
                        </div>
                      </div>
                      <br>
                      <div class=3D"gmail_quote">
                        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Ma=
r
                          2021 at 18:26, Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd=
.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                          <div> Hi Alberto,<br>
                            <br>
                            <blockquote type=3D"cite">I think the driver
                              should only support resolutions that are <b>p=
rogressive</b>,
                              but also at least of <b>50Hz</b>.</blockquote=
>
                            <br>
                            Why do you think so?, the 24Hz resolution
                            seems to be the native one of the display.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            <div>Am 30.03.21 um 17:37 schrieb Alberto
                              Salvia Novella:<br>
                            </div>
                            <blockquote type=3D"cite">
                              <div dir=3D"ltr">
                                <div>This is why I&#39;m using interlaced:<=
br>
                                </div>
                                <div><br>
                                </div>
                                <div>$ <b>xrandr</b><br>
                                  Screen 0: minimum 320 x 200, current
                                  1920 x 1080, maximum 8192 x 8192<br>
                                  DisplayPort-0 disconnected (normal
                                  left inverted right x axis y axis)<br>
                                  HDMI-0 connected primary 1920x1080+0+0
                                  (normal left inverted right x axis y
                                  axis) 16mm x 9mm<br>
                                  =C2=A0 =C2=A01920x<b>1080i</b> =C2=A0 =C2=
=A060.00*+ =C2=A050.00
                                  =C2=A0 =C2=A059.94 =C2=A0<br>
                                  =C2=A0 =C2=A01920x1080 =C2=A0 =C2=A0 <b>2=
4.00</b> =C2=A0
                                  =C2=A023.98 =C2=A0<br>
                                  =C2=A0 =C2=A01280x<b>720</b> =C2=A0 =C2=
=A0 =C2=A060.00 =C2=A0 =C2=A050.00
                                  =C2=A0 =C2=A059.94 =C2=A0<br>
                                  =C2=A0 =C2=A01024x768 =C2=A0 =C2=A0 =C2=
=A075.03 =C2=A0 =C2=A070.07 =C2=A0
                                  =C2=A060.00 =C2=A0<br>
                                  =C2=A0 =C2=A0832x624 =C2=A0 =C2=A0 =C2=A0=
 74.55 =C2=A0<br>
                                  =C2=A0 =C2=A0800x600 =C2=A0 =C2=A0 =C2=A0=
 72.19 =C2=A0 =C2=A075.00 =C2=A0
                                  =C2=A060.32 =C2=A0 =C2=A056.25 =C2=A0<br>
                                  =C2=A0 =C2=A0720x576 =C2=A0 =C2=A0 =C2=A0=
 50.00 =C2=A0<br>
                                  =C2=A0 =C2=A0720x576i =C2=A0 =C2=A0 =C2=
=A050.00 =C2=A0<br>
                                  =C2=A0 =C2=A0720x480 =C2=A0 =C2=A0 =C2=A0=
 60.00 =C2=A0 =C2=A059.94 =C2=A0<br>
                                  =C2=A0 =C2=A0720x480i =C2=A0 =C2=A0 =C2=
=A060.00 =C2=A0 =C2=A059.94 =C2=A0<br>
                                  =C2=A0 =C2=A0640x480 =C2=A0 =C2=A0 =C2=A0=
 75.00 =C2=A0 =C2=A072.81 =C2=A0
                                  =C2=A066.67 =C2=A0 =C2=A060.00 =C2=A0 =C2=
=A059.94 =C2=A0<br>
                                  =C2=A0 =C2=A0720x400 =C2=A0 =C2=A0 =C2=A0=
 70.08 =C2=A0<br>
                                  DVI-0 disconnected (normal left
                                  inverted right x axis y axis)</div>
                                <div><br>
                                </div>
                                <div>I think the driver should only
                                  support resolutions that are <b>progressi=
ve</b>,
                                  but also at least of <b>50Hz</b>.<br>
                                </div>
                              </div>
                              <br>
                              <div class=3D"gmail_quote">
                                <div dir=3D"ltr" class=3D"gmail_attr">On
                                  Tue, 30 Mar 2021 at 15:41, Christian
                                  K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.=
leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.co=
m</a>&gt;
                                  wrote:<br>
                                </div>
                                <blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
                                  <div> Mhm, no idea why an interlaced
                                    resolution would cause a crash.
                                    Maybe some miscalculation in the
                                    display code.<br>
                                    <br>
                                    But apart from that if you just
                                    connected your PC to a TV I also
                                    wouldn&#39;t recommend using an
                                    interlaced resolution in the first
                                    place.<br>
                                    <br>
                                    See those resolutions only exists
                                    for backward compatibility with
                                    analog hardware.<br>
                                    <br>
                                    I think we would just disable those
                                    modes instead of searching for the
                                    bug.<br>
                                    <br>
                                    Regards,<br>
                                    Christian.<br>
                                    <br>
                                    <div>Am 30.03.21 um 11:07 schrieb
                                      Alberto Salvia Novella:<br>
                                    </div>
                                    <blockquote type=3D"cite">
                                      <div dir=3D"ltr">
                                        <div>I guessed so.</div>
                                        <div><br>
                                        </div>
                                        <div>The GPU is a Radeon HD5870,
                                          and the screen is an old
                                          Telefunken TV (TLFK22LEDPVR1).</d=
iv>
                                        <div><br>
                                        </div>
                                        <div>Since my real display got
                                          into repair I used this TV
                                          meanwhile, and to my surprise
                                          it froze the system.<br>
                                        </div>
                                      </div>
                                      <br>
                                      <div class=3D"gmail_quote">
                                        <div dir=3D"ltr" class=3D"gmail_att=
r">On Tue, 30
                                          Mar 2021 at 10:15, Christian
                                          K=C3=B6nig &lt;<a href=3D"mailto:=
christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt=
;
                                          wrote:<br>
                                        </div>
                                        <blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hi
                                          Alberto,<br>
                                          <br>
                                          well what hardware do you
                                          have?<br>
                                          <br>
                                          Interlaced resolutions are not
                                          used any more on modern
                                          hardware, so they <br>
                                          are not well tested.<br>
                                          <br>
                                          Regards,<br>
                                          Christian.<br>
                                          <br>
                                          Am 30.03.21 um 10:04 schrieb
                                          Alberto Salvia Novella:<br>
                                          &gt; The entire desktop hangs
                                          after some minutes when using
                                          the module <br>
                                          &gt; &quot;radeon&quot; with an
                                          interlaced resolution.<br>
                                          &gt;<br>
                                          &gt; Easier to trigger by
                                          playing a video on Firefox, at
                                          least on kwin_x11. <br>
                                          &gt; Wayland didn&#39;t exhibit
                                          the problem.<br>
                                          &gt;<br>
                                          &gt; Other display drivers,
                                          from different computers I
                                          have tried, didn&#39;t <br>
                                          &gt; allow those interlaced
                                          resolutions all together. It
                                          seems they know <br>
                                          &gt; there will be problems.<br>
                                          <br>
                                        </blockquote>
                                      </div>
                                      <br>
                                      <fieldset></fieldset>
                                      <pre>________________________________=
_______________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Cchristian.koenig%40amd.com%7Ccf4929c9c3024efb7c4608d8f41bc0d0%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637527747331550917%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3D5BcOM0IHbXdYbWjy1a7VQOFgbkFGoV0FMzbDmZe94l0%3D&amp;reserved=
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
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000362eaa05bed6018f--

--===============1814394021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1814394021==--
