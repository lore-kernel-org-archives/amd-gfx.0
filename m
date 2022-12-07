Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88834C63705
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 20:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B4D10E41A;
	Wed,  7 Dec 2022 20:54:17 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7714810E41A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 20:54:14 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-12c8312131fso22798635fac.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Dec 2022 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kjrcM99rD1bwiPFWIWxejNzvatvUoeiOyAYoYpF19vc=;
 b=VayCt2oByyl43/gTQwHtmFnQIaQjl/yLu8/5qlAtm1O7xhp4JQVrCAx9/BEqXmjjcn
 1SAKG7AY/NJH3y2FTyde9B9XdwVufGZgvK5ATKFFUgss7OZCcplw0SKAmqpNbP50Dxsk
 ahpvIGo5WVRKh/+FBqPVsYm+rC+stPmT0fpLGfrpOTnFGg1dLDFeRHJzu+XRIv1GdGGs
 SD76OG0cOlHtyiMSbNaXfx9esyv6TzVXqMs7gnIkIeA4FqoZiAk/K62JyIpsUUYrO/n2
 iHPZyejsH/uLbqUYo2NntSp+bjukMXcHU5svO5BQbjRKRYy8xNjOMvMeqEkNIRC3PMlf
 c6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjrcM99rD1bwiPFWIWxejNzvatvUoeiOyAYoYpF19vc=;
 b=gyC9d73e3i1yPejz0zpP7FlUPkzYOV59nKJ15yFea2gJn88gfSA7j5Br02Nl369eC6
 2qqjC56XKGTVcQP+X9WAfReRLjlFtMawiFOxmf11TTbuVA628DiRV897CRlyirK8IwnL
 NAi1kcSwVUWSBaT64oT4v71iOjjNy8axh/zeUgHimYl3MPYuoEzvOSEkBt86lBUYzUmj
 s5LNDGN/OIzH68v9nLhY29zr8GYz+o2/8K3FVj1m/av8h3D4EayFvBjsIRF7Tfw793xn
 xG5dSbu+YMGOSj/s/4WMhRVjD7BvE7xLf4G8U2juRfewDR6jtTBF/JpN6lDxn5FzIQBl
 nCdA==
X-Gm-Message-State: ANoB5pnxGMgyDDbLrDZZtR2q6DaVEdjnsw+HorZjOsYrGkvj6nVOAeey
 80HWmJlhFcRwWdE2iYcDuoNX9YgXZqYwNVC20ww=
X-Google-Smtp-Source: AA0mqf46MOOoAV+1nDklHeG7l8qQrMOzBMHUXEmpgjjI9o/cdtUZyqm/KvTTAsRCTC2hsCd6Lbmd90Iu4sS3uXhjtN8=
X-Received: by 2002:a05:6870:7a0c:b0:143:8a81:116c with SMTP id
 hf12-20020a0568707a0c00b001438a81116cmr29364844oab.96.1670446453735; Wed, 07
 Dec 2022 12:54:13 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsM7jMMomy_=oNN236LfLJzMJbcNR=YWWJ74TgNO_16PWQ@mail.gmail.com>
 <CADnq5_PUCRGZoUu3RHrbD6+Dr_RHWdqkJKDBD2cWenWhQQiyKw@mail.gmail.com>
 <CABXGCsO-GLzahLgNtbzsM-HiPk7cZvHu56ckSMLD7XeUvf28hw@mail.gmail.com>
In-Reply-To: <CABXGCsO-GLzahLgNtbzsM-HiPk7cZvHu56ckSMLD7XeUvf28hw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 15:54:01 -0500
Message-ID: <CADnq5_NMuc=moNDgL1bx9riUtkfuPvj4sLM-i3Qmf-rtAHV+=Q@mail.gmail.com>
Subject: Re: [bug][vaapi][h264] The commit
 7cbe08a930a132d84b4cf79953b00b074ec7a2a7
 on certain video files leads to problems with VAAPI hardware decoding.
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Leo Liu <leo.liu@amd.com>,
 Thong Thai <thong.thai@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, James.Zhu@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Leo, Thong

On Wed, Dec 7, 2022 at 3:43 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Wed, Dec 7, 2022 at 7:58 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> >
> > What GPU do you have and what entries do you have in
> > sys/class/drm/card0/device/ip_discovery/die/0/UVD for the device?
>
> I bisected the issue on the Radeon 6800M.
>
> Parent commit for 7cbe08a930a132d84b4cf79953b00b074ec7a2a7 is
> 46dd2965bdd1c5a4f6499c73ff32e636fa8f9769.
> For both commits ip_discovery is absent.
> # ls /sys/class/drm/card0/device/ | grep ip
> # ls /sys/class/drm/card1/device/ | grep ip
>
> But from verbose info I see that player for
> 7cbe08a930a132d84b4cf79953b00b074ec7a2a7 use acceleration:
> $ vlc -v Downloads/test_sample_480_2.mp4
> VLC media player 3.0.18 Vetinari (revision )
> [0000561f72097520] main libvlc: Running vlc with the default
> interface. Use 'cvlc' to use vlc without interface.
> [00007fa224001190] mp4 demux warning: elst box found
> [00007fa224001190] mp4 demux warning: STTS table of 1 entries
> [00007fa224001190] mp4 demux warning: CTTS table of 78 entries
> [00007fa224001190] mp4 demux warning: elst box found
> [00007fa224001190] mp4 demux warning: STTS table of 1 entries
> [00007fa224001190] mp4 demux warning: elst old=0 new=1
> [00007fa224d19010] faad decoder warning: decoded zero sample
> [00007fa224001190] mp4 demux warning: elst old=0 new=1
> [00007fa214007030] gl gl: Initialized libplacebo v4.208.0 (API v208)
> libva info: VA-API version 1.16.0
> libva error: vaGetDriverNameByIndex() failed with unknown libva error,
> driver_name = (null)
> [00007fa214007030] glconv_vaapi_x11 gl error: vaInitialize: unknown libva error
> libva info: VA-API version 1.16.0
> libva info: Trying to open /usr/lib64/dri/radeonsi_drv_video.so
> libva info: Found init function __vaDriverInit_1_16
> libva info: va_openDriver() returns 0
> [00007fa224c0b3a0] avcodec decoder: Using Mesa Gallium driver
> 23.0.0-devel for AMD Radeon RX 6800M (navi22, LLVM 15.0.4, DRM 3.42,
> 5.14.0-rc4-14-7cbe08a930a132d84b4cf79953b00b074ec7a2a7+) for hardware
> decoding
> [h264 @ 0x7fa224c3fa40] Using deprecated struct vaapi_context in decode.
> [0000561f72174de0] pulse audio output warning: starting late (-9724 us)
>
> And for 46dd2965bdd1c5a4f6499c73ff32e636fa8f9769 commit did not use
> acceleration:
> $ vlc -v Downloads/test_sample_480_2.mp4
> VLC media player 3.0.18 Vetinari (revision )
> [000055f61ad35520] main libvlc: Running vlc with the default
> interface. Use 'cvlc' to use vlc without interface.
> [00007fc7e8001190] mp4 demux warning: elst box found
> [00007fc7e8001190] mp4 demux warning: STTS table of 1 entries
> [00007fc7e8001190] mp4 demux warning: CTTS table of 78 entries
> [00007fc7e8001190] mp4 demux warning: elst box found
> [00007fc7e8001190] mp4 demux warning: STTS table of 1 entries
> [00007fc7e8001190] mp4 demux warning: elst old=0 new=1
> [00007fc7e8d19010] faad decoder warning: decoded zero sample
> [00007fc7e8001190] mp4 demux warning: elst old=0 new=1
> [00007fc7d8007030] gl gl: Initialized libplacebo v4.208.0 (API v208)
> libva info: VA-API version 1.16.0
> libva error: vaGetDriverNameByIndex() failed with unknown libva error,
> driver_name = (null)
> [00007fc7d8007030] glconv_vaapi_x11 gl error: vaInitialize: unknown libva error
> libva info: VA-API version 1.16.0
> libva info: Trying to open /usr/lib64/dri/radeonsi_drv_video.so
> libva info: Found init function __vaDriverInit_1_16
> libva info: va_openDriver() returns 0
> [00007fc7d40b3260] vaapi generic error: profile(7) is not supported
> [00007fc7d8a089c0] gl gl: Initialized libplacebo v4.208.0 (API v208)
> Failed to open VDPAU backend libvdpau_nvidia.so: cannot open shared
> object file: No such file or directory
> Failed to open VDPAU backend libvdpau_nvidia.so: cannot open shared
> object file: No such file or directory
> [00007fc7d89e4f80] gl gl: Initialized libplacebo v4.208.0 (API v208)
> [000055f61ae12de0] pulse audio output warning: starting late (-13537 us)
>
> So my bisect didn't make sense :(
> Anyway can you reproduce the issue with the attached sample file and
> vlc on fresh kernel (6.1-rc8)?
>
> Thanks!
>
> --
> Best Regards,
> Mike Gavrilov.
