Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059CC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B8861008
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B8861008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D3066EAB8;
	Wed, 31 Mar 2021 14:55:20 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECACD6EAB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 14:55:18 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id e7so22635700edu.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=LG5Z+pf6W+0TpXFThQhlzzLeTF7/xPApxs2S6mpSiQU=;
 b=UqVs8WzbdJ+Rbg4951tmRhYJOKifSIGpHg8rCeiMsS5bxa4kxfDR9cS2zuR4yEEABR
 1yPQrPY5PQH5aF9ghDFvzEgSI8At0xMpI50bm1/CzhTe3yIiNlkD7wBjK9vyw44aLqtP
 MHqJC3voXzmdrhueEUOy1EHvRZF+cTvak9mdyhg7aMgj2Ut21zELonP7y6rYG0HJF3Ow
 2CySVnomTIc0iPYwMqd4jhmH/skK6C8PexPWudl3wz7CDZqJmUXFUvAgym4X0QGOu2yV
 d3K9Vvt/kaVpuvPUEAop9iRjRLYEDK5DJlu41q1K/Jx2ovjvRPRSvyhbIdZxsjK74JMq
 eBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=LG5Z+pf6W+0TpXFThQhlzzLeTF7/xPApxs2S6mpSiQU=;
 b=PFlvreMLHKiqs5r/9Xff0dq4YLIR0ByGko2jYoJe2ZaU2IZVCCd0T07XCizHAZNoie
 +w0rNQeEQdQybv8Xpmc8W72KBFtI0fF3IGDRKLyMea7TCoP2ZFsoMWzayTAtvhBSme+o
 fC1D59IBWyzsecYeunVMVwLcCjOejuQpAGWMkhgtkeyiB6o6J1Cv6aGXGRysRv5OxIqc
 wK0poYxFEnKb1YYmqKkumLxEG79MSSTOmizxSwhvc0XANPJY3tjHfkouaV/EzlzyqAkG
 axrhS0640SGMd8i0Q6dBpNmQPZS9loHVfwtjF1ILxI7LbEU2ELl8dP7jaueVFgfe/goZ
 ufKg==
X-Gm-Message-State: AOAM532yDELujm3FaX0LWL3+HjQyz3haRC3vP4D46P8hn0ClgR784J2N
 Fu1qDi+aZJkjFDNceYqOs63CzBiERFw=
X-Google-Smtp-Source: ABdhPJxCOAkI4VHHm+L2SkMuq0JSmKP2VG7MgDv33a7JOe+pQf7x1xLGYvYNIW0uKAofg9EsT03qeg==
X-Received: by 2002:a05:6402:5189:: with SMTP id
 q9mr4253322edd.168.1617202517590; 
 Wed, 31 Mar 2021 07:55:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:46d6:1b43:479c:c70b?
 ([2a02:908:1252:fb60:46d6:1b43:479c:c70b])
 by smtp.gmail.com with ESMTPSA id w18sm1363278ejn.23.2021.03.31.07.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 07:55:17 -0700 (PDT)
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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
 <CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com>
 <0eee8e42-5da8-1ce3-bff7-fe6e2ab18cde@amd.com>
 <CAHJvkbvH+yf-O04Jj9CURjaFfaYE9CSzqBQPe5oPuy5U_f3hag@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6a71add4-d2d0-c17a-de8a-6e2b6e248483@gmail.com>
Date: Wed, 31 Mar 2021 16:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHJvkbvH+yf-O04Jj9CURjaFfaYE9CSzqBQPe5oPuy5U_f3hag@mail.gmail.com>
Content-Language: en-US
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
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0832924249=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0832924249==
Content-Type: multipart/alternative;
 boundary="------------A2C718B6979DEA0712FB4E49"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A2C718B6979DEA0712FB4E49
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Well the hardware is working fine as far as I can see.

Can you try to kill the X server over SSH and see if you then get some 
screen update?

Regards,
Christian.

Am 31.03.21 um 16:52 schrieb Alberto Salvia Novella:
> Output 
> <https://bin.privacytools.io/?0f3d7caa23b99655#CvUAikkFYSdQ9XixPHvBe7ebfaQ7nXcFVBhXAotYMPrG>.
>
> On Wed, 31 Mar 2021 at 16:36, Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Mhm strange.
>
>     Can you get me the output of "sudo cat
>     /sys/kernel/debug/dri/0/radeon_fence_info" when the problem happens?
>
>     Thanks,
>     Christian.
>
>     Am 31.03.21 um 16:33 schrieb Alberto Salvia Novella:
>>     - The computer still replies to *ping*.
>>     - The *journal* shows no errors, but a few warnings
>>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F5a0bf22220398549%23D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy&data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=1jQLb8pO7eJYTORNisjequdWSCoKPsrrv7y%2F4U%2BojLM%3D&reserved=0>.
>>     - The *mouse* doesn't freeze.
>>
>>     On Wed, 31 Mar 2021 at 10:09, Christian König
>>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>
>>         Can you access the system over the network and see if there
>>         is anything in the system log?
>>
>>         It sounds like the display stack has crashed, but when the
>>         sound keeps playing the system is most likely still
>>         responsive over network.
>>
>>         Thanks,
>>         Christian.
>>
>>         Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:
>>>         What happens is this simple: after a few minutes, about 6 or
>>>         so, the entire content of the screen stays still. In some
>>>         minor situations only the applications panel of KDE Plasma.
>>>
>>>         If music is playing it continues playing, so only graphics
>>>         are hung. Yet in most cases the power button won't shut down
>>>         the computer, as it usually does.
>>>
>>>         At least this is the case using kwin on x11, and not on
>>>         wayland. It only happens on "radeon" and not on Intel or
>>>         "radeonhd".
>>>
>>>         On Wed, 31 Mar 2021 at 09:48, Christian König
>>>         <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
>>>         wrote:
>>>
>>>             Correct, but a TV is intended for videos only. That's
>>>             why it implements only the lower HDMI standard.
>>>
>>>             Interlaced transmits only halve the lines with each
>>>             frame, so a 60Hz mode effectively either becomes a 30Hz
>>>             mode, halving the vertical resolution or adaptive motion
>>>             compensated which the know visual artifacts. Depending
>>>             on what the deinterlacing setting on your TV is.
>>>
>>>             You could just add a progressive 1920x540@60 or
>>>             1920x1080@30 mode manually and would have the same
>>>             effect with probably better quality. See
>>>             https://de.wikipedia.org/wiki/Deinterlacing
>>>             <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=UTefQjeEYVrJto%2FqBlna%2FQKihbJe2HQG%2BczlZViFPDY%3D&reserved=0>
>>>             for reference.
>>>
>>>             If you can give us some more information what is
>>>             happening when the system freeze we could try to narrow
>>>             this down, but we can't spend much time on a very
>>>             specific use case in a driver which is in maintenance mode.
>>>
>>>             Regards,
>>>             Christian.
>>>
>>>             Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
>>>>             24fps is intended for video only. Anything interactive
>>>>             at 24fps, as just moving the mouse around, is extremely
>>>>             choppy.
>>>>
>>>>             No way anyone would prefer that over an interlaced
>>>>             resolution or a lower resolution. That is, by far, the
>>>>             worst option.
>>>>
>>>>             Just try it on your screen, set it to 24Hz or alike,
>>>>             and tell me your experience. You can't even tell where
>>>>             the mouse is going to go.
>>>>
>>>>             On Wed, 31 Mar 2021 at 08:44, Christian König
>>>>             <christian.koenig@amd.com
>>>>             <mailto:christian.koenig@amd.com>> wrote:
>>>>
>>>>                 Hi Alberto,
>>>>
>>>>                 well a frame rate of 24Hz is perfectly reasonable
>>>>                 for a TV and desktop usage.
>>>>
>>>>                 This is probably caused by the TVs limited HDMI
>>>>                 bandwidth and a refresh rate of 30/25 Hz for the
>>>>                 interlaced mode isn't much better either.
>>>>
>>>>                 Regards,
>>>>                 Christian.
>>>>
>>>>                 Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
>>>>>                 The frame-rate at 24Hz is extremely poor for
>>>>>                 normal desktop usage.
>>>>>
>>>>>                 If the highest resolution, aka 1080p, uses that
>>>>>                 refresh rate then the desktop will default to that
>>>>>                 frame-rate.
>>>>>
>>>>>                 Other progressive modes don't exhibit any issue.
>>>>>
>>>>>                 On Tue, 30 Mar 2021 at 18:26, Christian König
>>>>>                 <christian.koenig@amd.com
>>>>>                 <mailto:christian.koenig@amd.com>> wrote:
>>>>>
>>>>>                     Hi Alberto,
>>>>>
>>>>>>                     I think the driver should only support
>>>>>>                     resolutions that are *progressive*, but also
>>>>>>                     at least of *50Hz*.
>>>>>
>>>>>                     Why do you think so?, the 24Hz resolution
>>>>>                     seems to be the native one of the display.
>>>>>
>>>>>                     Regards,
>>>>>                     Christian.
>>>>>
>>>>>                     Am 30.03.21 um 17:37 schrieb Alberto Salvia
>>>>>                     Novella:
>>>>>>                     This is why I'm using interlaced:
>>>>>>
>>>>>>                     $ *xrandr*
>>>>>>                     Screen 0: minimum 320 x 200, current 1920 x
>>>>>>                     1080, maximum 8192 x 8192
>>>>>>                     DisplayPort-0 disconnected (normal left
>>>>>>                     inverted right x axis y axis)
>>>>>>                     HDMI-0 connected primary 1920x1080+0+0
>>>>>>                     (normal left inverted right x axis y axis)
>>>>>>                     16mm x 9mm
>>>>>>                        1920x*1080i*  60.00*+  50.00  59.94
>>>>>>                        1920x1080 *24.00*    23.98
>>>>>>                        1280x*720*  60.00    50.00  59.94
>>>>>>                        1024x768      75.03    70.07    60.00
>>>>>>                        832x624       74.55
>>>>>>                        800x600       72.19    75.00    60.32  56.25
>>>>>>                        720x576       50.00
>>>>>>                        720x576i      50.00
>>>>>>                        720x480       60.00    59.94
>>>>>>                        720x480i      60.00    59.94
>>>>>>                        640x480       75.00    72.81    66.67
>>>>>>                      60.00    59.94
>>>>>>                        720x400       70.08
>>>>>>                     DVI-0 disconnected (normal left inverted
>>>>>>                     right x axis y axis)
>>>>>>
>>>>>>                     I think the driver should only support
>>>>>>                     resolutions that are *progressive*, but also
>>>>>>                     at least of *50Hz*.
>>>>>>
>>>>>>                     On Tue, 30 Mar 2021 at 15:41, Christian König
>>>>>>                     <ckoenig.leichtzumerken@gmail.com
>>>>>>                     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>>>>
>>>>>>                         Mhm, no idea why an interlaced resolution
>>>>>>                         would cause a crash. Maybe some
>>>>>>                         miscalculation in the display code.
>>>>>>
>>>>>>                         But apart from that if you just connected
>>>>>>                         your PC to a TV I also wouldn't recommend
>>>>>>                         using an interlaced resolution in the
>>>>>>                         first place.
>>>>>>
>>>>>>                         See those resolutions only exists for
>>>>>>                         backward compatibility with analog hardware.
>>>>>>
>>>>>>                         I think we would just disable those modes
>>>>>>                         instead of searching for the bug.
>>>>>>
>>>>>>                         Regards,
>>>>>>                         Christian.
>>>>>>
>>>>>>                         Am 30.03.21 um 11:07 schrieb Alberto
>>>>>>                         Salvia Novella:
>>>>>>>                         I guessed so.
>>>>>>>
>>>>>>>                         The GPU is a Radeon HD5870, and the
>>>>>>>                         screen is an old Telefunken TV
>>>>>>>                         (TLFK22LEDPVR1).
>>>>>>>
>>>>>>>                         Since my real display got into repair I
>>>>>>>                         used this TV meanwhile, and to my
>>>>>>>                         surprise it froze the system.
>>>>>>>
>>>>>>>                         On Tue, 30 Mar 2021 at 10:15, Christian
>>>>>>>                         König <christian.koenig@amd.com
>>>>>>>                         <mailto:christian.koenig@amd.com>> wrote:
>>>>>>>
>>>>>>>                             Hi Alberto,
>>>>>>>
>>>>>>>                             well what hardware do you have?
>>>>>>>
>>>>>>>                             Interlaced resolutions are not used
>>>>>>>                             any more on modern hardware, so they
>>>>>>>                             are not well tested.
>>>>>>>
>>>>>>>                             Regards,
>>>>>>>                             Christian.
>>>>>>>
>>>>>>>                             Am 30.03.21 um 10:04 schrieb Alberto
>>>>>>>                             Salvia Novella:
>>>>>>>                             > The entire desktop hangs after
>>>>>>>                             some minutes when using the module
>>>>>>>                             > "radeon" with an interlaced
>>>>>>>                             resolution.
>>>>>>>                             >
>>>>>>>                             > Easier to trigger by playing a
>>>>>>>                             video on Firefox, at least on kwin_x11.
>>>>>>>                             > Wayland didn't exhibit the problem.
>>>>>>>                             >
>>>>>>>                             > Other display drivers, from
>>>>>>>                             different computers I have tried,
>>>>>>>                             didn't
>>>>>>>                             > allow those interlaced resolutions
>>>>>>>                             all together. It seems they know
>>>>>>>                             > there will be problems.
>>>>>>>
>>>>>>>
>>>>>>>                         _______________________________________________
>>>>>>>                         amd-gfx mailing list
>>>>>>>                         amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>>>>                         https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411082891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=5HXXJnOGGnEYSV%2BY%2FyWu031sE4CxFTKS2QqcKvlhhPs%3D&reserved=0>
>>>>>>
>>>>>
>>>>
>>>
>>
>


--------------A2C718B6979DEA0712FB4E49
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Well the hardware is working fine as far as I can see.<br>
    <br>
    Can you try to kill the X server over SSH and see if you then get
    some screen update?<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 31.03.21 um 16:52 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAHJvkbvH+yf-O04Jj9CURjaFfaYE9CSzqBQPe5oPuy5U_f3hag@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr"><a
href="https://bin.privacytools.io/?0f3d7caa23b99655#CvUAikkFYSdQ9XixPHvBe7ebfaQ7nXcFVBhXAotYMPrG"
          moz-do-not-send="true">Output</a>.<br>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at 16:36,
          Christian König &lt;<a href="mailto:christian.koenig@amd.com"
            moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Mhm strange.<br>
            <br>
            Can you get me the output of "sudo cat
            /sys/kernel/debug/dri/0/radeon_fence_info" when the problem
            happens?<br>
            <br>
            Thanks,<br>
            Christian.<br>
            <br>
            <div>Am 31.03.21 um 16:33 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>- The computer still replies to <b>ping</b>.</div>
                <div>- The <b>journal</b> shows no errors, but a few <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbin.privacytools.io%2F%3F5a0bf22220398549%23D8SPwPEh8A5BuKN6TkU78gAgEPgrUok4fCjcaucSEnyy&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1jQLb8pO7eJYTORNisjequdWSCoKPsrrv7y%2F4U%2BojLM%3D&amp;reserved=0"
                    target="_blank" moz-do-not-send="true">warnings</a>.</div>
                <div>- The <b>mouse</b> doesn't freeze.<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Wed, 31 Mar 2021 at
                  10:09, Christian König &lt;<a
                    href="mailto:christian.koenig@amd.com"
                    target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Can you access the system over the network and
                    see if there is anything in the system log?<br>
                    <br>
                    It sounds like the display stack has crashed, but
                    when the sound keeps playing the system is most
                    likely still responsive over network.<br>
                    <br>
                    Thanks,<br>
                    Christian.<br>
                    <br>
                    <div>Am 31.03.21 um 10:05 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>What happens is this simple: after a few
                          minutes, about 6 or so, the entire content of
                          the screen stays still. In some minor
                          situations only the applications panel of KDE
                          Plasma.</div>
                        <div><br>
                        </div>
                        <div>If music is playing it continues playing,
                          so only graphics are hung. Yet in most cases
                          the power button won't shut down the computer,
                          as it usually does.<br>
                        </div>
                        <div><br>
                        </div>
                        <div>At least this is the case using kwin on
                          x11, and not on wayland. It only happens on
                          "radeon" and not on Intel or "radeonhd".</div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Wed, 31 Mar
                          2021 at 09:48, Christian König &lt;<a
                            href="mailto:christian.koenig@amd.com"
                            target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote"
                          style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div> Correct, but a TV is intended for videos
                            only. That's why it implements only the
                            lower HDMI standard.<br>
                            <br>
                            Interlaced transmits only halve the lines
                            with each frame, so a 60Hz mode effectively
                            either becomes a 30Hz mode, halving the
                            vertical resolution or adaptive motion
                            compensated which the know visual artifacts.
                            Depending on what the deinterlacing setting
                            on your TV is.<br>
                            <br>
                            You could just add a progressive 1920x540@60
                            or 1920x1080@30 mode manually and would have
                            the same effect with probably better
                            quality. See <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fde.wikipedia.org%2Fwiki%2FDeinterlacing&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411072897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UTefQjeEYVrJto%2FqBlna%2FQKihbJe2HQG%2BczlZViFPDY%3D&amp;reserved=0"
                              target="_blank" moz-do-not-send="true">https://de.wikipedia.org/wiki/Deinterlacing</a>
                            for reference.<br>
                            <br>
                            If you can give us some more information
                            what is happening when the system freeze we
                            could try to narrow this down, but we can't
                            spend much time on a very specific use case
                            in a driver which is in maintenance mode.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            <div>Am 31.03.21 um 09:21 schrieb Alberto
                              Salvia Novella:<br>
                            </div>
                            <blockquote type="cite">
                              <div dir="ltr">
                                <div>24fps is intended for video only.
                                  Anything interactive at 24fps, as just
                                  moving the mouse around, is extremely
                                  choppy.</div>
                                <div><br>
                                </div>
                                <div>No way anyone would prefer that
                                  over an interlaced resolution or a
                                  lower resolution. That is, by far, the
                                  worst option.</div>
                                <div><br>
                                </div>
                                <div>Just try it on your screen, set it
                                  to 24Hz or alike, and tell me your
                                  experience. You can't even tell where
                                  the mouse is going to go.<br>
                                </div>
                              </div>
                              <br>
                              <div class="gmail_quote">
                                <div dir="ltr" class="gmail_attr">On
                                  Wed, 31 Mar 2021 at 08:44, Christian
                                  König &lt;<a
                                    href="mailto:christian.koenig@amd.com"
                                    target="_blank"
                                    moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                  wrote:<br>
                                </div>
                                <blockquote class="gmail_quote"
                                  style="margin:0px 0px 0px
                                  0.8ex;border-left:1px solid
                                  rgb(204,204,204);padding-left:1ex">
                                  <div> Hi Alberto,<br>
                                    <br>
                                    well a frame rate of 24Hz is
                                    perfectly reasonable for a TV and
                                    desktop usage.<br>
                                    <br>
                                    This is probably caused by the TVs
                                    limited HDMI bandwidth and a refresh
                                    rate of 30/25 Hz for the interlaced
                                    mode isn't much better either.<br>
                                    <br>
                                    Regards,<br>
                                    Christian.<br>
                                    <br>
                                    <div>Am 30.03.21 um 22:59 schrieb
                                      Alberto Salvia Novella:<br>
                                    </div>
                                    <blockquote type="cite">
                                      <div dir="ltr">
                                        <div>The frame-rate at 24Hz is
                                          extremely poor for normal
                                          desktop usage.<br>
                                        </div>
                                        <div><br>
                                        </div>
                                        <div>If the highest resolution,
                                          aka 1080p, uses that refresh
                                          rate then the desktop will
                                          default to that frame-rate.</div>
                                        <div><br>
                                        </div>
                                        <div>Other progressive modes
                                          don't exhibit any issue.<br>
                                        </div>
                                      </div>
                                      <br>
                                      <div class="gmail_quote">
                                        <div dir="ltr"
                                          class="gmail_attr">On Tue, 30
                                          Mar 2021 at 18:26, Christian
                                          König &lt;<a
                                            href="mailto:christian.koenig@amd.com"
                                            target="_blank"
                                            moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                          wrote:<br>
                                        </div>
                                        <blockquote class="gmail_quote"
                                          style="margin:0px 0px 0px
                                          0.8ex;border-left:1px solid
                                          rgb(204,204,204);padding-left:1ex">
                                          <div> Hi Alberto,<br>
                                            <br>
                                            <blockquote type="cite">I
                                              think the driver should
                                              only support resolutions
                                              that are <b>progressive</b>,
                                              but also at least of <b>50Hz</b>.</blockquote>
                                            <br>
                                            Why do you think so?, the
                                            24Hz resolution seems to be
                                            the native one of the
                                            display.<br>
                                            <br>
                                            Regards,<br>
                                            Christian.<br>
                                            <br>
                                            <div>Am 30.03.21 um 17:37
                                              schrieb Alberto Salvia
                                              Novella:<br>
                                            </div>
                                            <blockquote type="cite">
                                              <div dir="ltr">
                                                <div>This is why I'm
                                                  using interlaced:<br>
                                                </div>
                                                <div><br>
                                                </div>
                                                <div>$ <b>xrandr</b><br>
                                                  Screen 0: minimum 320
                                                  x 200, current 1920 x
                                                  1080, maximum 8192 x
                                                  8192<br>
                                                  DisplayPort-0
                                                  disconnected (normal
                                                  left inverted right x
                                                  axis y axis)<br>
                                                  HDMI-0 connected
                                                  primary 1920x1080+0+0
                                                  (normal left inverted
                                                  right x axis y axis)
                                                  16mm x 9mm<br>
                                                     1920x<b>1080i</b>  
                                                   60.00*+  50.00  
                                                   59.94  <br>
                                                     1920x1080     <b>24.00</b>
                                                     23.98  <br>
                                                     1280x<b>720</b>    
                                                   60.00    50.00  
                                                   59.94  <br>
                                                     1024x768      75.03
                                                     70.07    60.00  <br>
                                                     832x624       74.55
                                                   <br>
                                                     800x600       72.19
                                                     75.00    60.32  
                                                   56.25  <br>
                                                     720x576       50.00
                                                   <br>
                                                     720x576i      50.00
                                                   <br>
                                                     720x480       60.00
                                                     59.94  <br>
                                                     720x480i      60.00
                                                     59.94  <br>
                                                     640x480       75.00
                                                     72.81    66.67  
                                                   60.00    59.94  <br>
                                                     720x400       70.08
                                                   <br>
                                                  DVI-0 disconnected
                                                  (normal left inverted
                                                  right x axis y axis)</div>
                                                <div><br>
                                                </div>
                                                <div>I think the driver
                                                  should only support
                                                  resolutions that are <b>progressive</b>,
                                                  but also at least of <b>50Hz</b>.<br>
                                                </div>
                                              </div>
                                              <br>
                                              <div class="gmail_quote">
                                                <div dir="ltr"
                                                  class="gmail_attr">On
                                                  Tue, 30 Mar 2021 at
                                                  15:41, Christian König
                                                  &lt;<a
                                                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                                                    target="_blank"
                                                    moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                                                  wrote:<br>
                                                </div>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0px 0px
                                                  0px
                                                  0.8ex;border-left:1px
                                                  solid
                                                  rgb(204,204,204);padding-left:1ex">
                                                  <div> Mhm, no idea why
                                                    an interlaced
                                                    resolution would
                                                    cause a crash. Maybe
                                                    some miscalculation
                                                    in the display code.<br>
                                                    <br>
                                                    But apart from that
                                                    if you just
                                                    connected your PC to
                                                    a TV I also wouldn't
                                                    recommend using an
                                                    interlaced
                                                    resolution in the
                                                    first place.<br>
                                                    <br>
                                                    See those
                                                    resolutions only
                                                    exists for backward
                                                    compatibility with
                                                    analog hardware.<br>
                                                    <br>
                                                    I think we would
                                                    just disable those
                                                    modes instead of
                                                    searching for the
                                                    bug.<br>
                                                    <br>
                                                    Regards,<br>
                                                    Christian.<br>
                                                    <br>
                                                    <div>Am 30.03.21 um
                                                      11:07 schrieb
                                                      Alberto Salvia
                                                      Novella:<br>
                                                    </div>
                                                    <blockquote
                                                      type="cite">
                                                      <div dir="ltr">
                                                        <div>I guessed
                                                          so.</div>
                                                        <div><br>
                                                        </div>
                                                        <div>The GPU is
                                                          a Radeon
                                                          HD5870, and
                                                          the screen is
                                                          an old
                                                          Telefunken TV
(TLFK22LEDPVR1).</div>
                                                        <div><br>
                                                        </div>
                                                        <div>Since my
                                                          real display
                                                          got into
                                                          repair I used
                                                          this TV
                                                          meanwhile, and
                                                          to my surprise
                                                          it froze the
                                                          system.<br>
                                                        </div>
                                                      </div>
                                                      <br>
                                                      <div
                                                        class="gmail_quote">
                                                        <div dir="ltr"
                                                          class="gmail_attr">On
                                                          Tue, 30 Mar
                                                          2021 at 10:15,
                                                          Christian
                                                          König &lt;<a
                                                          href="mailto:christian.koenig@amd.com"
target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                                                          wrote:<br>
                                                        </div>
                                                        <blockquote
                                                          class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid
                                                          rgb(204,204,204);padding-left:1ex">Hi
                                                          Alberto,<br>
                                                          <br>
                                                          well what
                                                          hardware do
                                                          you have?<br>
                                                          <br>
                                                          Interlaced
                                                          resolutions
                                                          are not used
                                                          any more on
                                                          modern
                                                          hardware, so
                                                          they <br>
                                                          are not well
                                                          tested.<br>
                                                          <br>
                                                          Regards,<br>
                                                          Christian.<br>
                                                          <br>
                                                          Am 30.03.21 um
                                                          10:04 schrieb
                                                          Alberto Salvia
                                                          Novella:<br>
                                                          &gt; The
                                                          entire desktop
                                                          hangs after
                                                          some minutes
                                                          when using the
                                                          module <br>
                                                          &gt; "radeon"
                                                          with an
                                                          interlaced
                                                          resolution.<br>
                                                          &gt;<br>
                                                          &gt; Easier to
                                                          trigger by
                                                          playing a
                                                          video on
                                                          Firefox, at
                                                          least on
                                                          kwin_x11. <br>
                                                          &gt; Wayland
                                                          didn't exhibit
                                                          the problem.<br>
                                                          &gt;<br>
                                                          &gt; Other
                                                          display
                                                          drivers, from
                                                          different
                                                          computers I
                                                          have tried,
                                                          didn't <br>
                                                          &gt; allow
                                                          those
                                                          interlaced
                                                          resolutions
                                                          all together.
                                                          It seems they
                                                          know <br>
                                                          &gt; there
                                                          will be
                                                          problems.<br>
                                                          <br>
                                                        </blockquote>
                                                      </div>
                                                      <br>
                                                      <fieldset></fieldset>
                                                      <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C48392451d33d4b63e5f208d8f45204d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527980411082891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5HXXJnOGGnEYSV%2BY%2FyWu031sE4CxFTKS2QqcKvlhhPs%3D&amp;reserved=0" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
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
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------A2C718B6979DEA0712FB4E49--

--===============0832924249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0832924249==--
