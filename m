Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE1AC63709
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 20:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A798910E128;
	Wed,  7 Dec 2022 20:43:36 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987AA10E128
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 20:43:33 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id p18so10899778qkg.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Dec 2022 12:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ScTS5EO4RI+wHQaEvVboJSOll8Yj4SEKFZieyaf6tWM=;
 b=e6ANsgu5T0XqCmy1fAbvkQsz9evIICWg3HYWWncqhGVnSttp8J0Qn7vY4ApMhD9nps
 a8nTugv/WofZaRxX808GbjL53jTARCYb6hIjTWzfPU4xuJ4oDFLqoYXoSdaqQvcYLGdT
 XKBZBntLkvu4SBCNiCNUXWeaCfTYkPi9TaG3nG9ENz1cCjBjqkxl4qnzjEJQ20keZYty
 VVXULQyuzpINeNKDKMjfVuRBpU3Y3UPpBGIX3w1NOyab/q3jAIqo2jSECH4P6gaQ1tGA
 pkzGp2TstL4J7RFS1ouAoBFmtaKpaFo/Eun/O+9IsyVoSsPbQEVqZph7B/K//Tr0E6Ig
 ia3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ScTS5EO4RI+wHQaEvVboJSOll8Yj4SEKFZieyaf6tWM=;
 b=yBlX94Ioi39207Y6msWGqm4gVG+LtW+IvFm8bSLLgp1aQyE6xad/h1x7ncw3UpzVgP
 IDcA+1mli5i3yNf6AeWAlfJY8GWNndNCbtLtPwgXWDxbwJA/1j7r/ZnXMy7UwYZJFbfL
 AT5jYtSb8j8KV4T5IQNe2jo36aHtbNY6dBAyJ1q2kHjMFMUGBP/NqrvIa4BWgU2kY/sh
 0zsmCseLXw5RWjfu87YbGBBBZbapjsMPM7FFMgKi8LMVwC45LMQe4mxSzU55Me4ZwR9k
 RrlCeoW/n4r7SC1r3QJpuU0H/KPi9nj2dW0WXxwy/I6HvLqCIfNMsUaik6kzm6yciMgn
 qTiA==
X-Gm-Message-State: ANoB5pmpYYbX+fTt/3NMjKIHjQ+9t+hgUDpi/vepVGRp1J3KwEcAe2S7
 6Inz8dN7iBuNm9P2xXYVLe1b27FnKm0Qtsd5+8U=
X-Google-Smtp-Source: AA0mqf41KBH8kikVVv7h2I82XVSoxRADSwaOZypzDTrQXR8UrvQ5A7z4V1/OngOzRTi5sJGxUQuBih7uDLCnutJ5Dc4=
X-Received: by 2002:a05:620a:215c:b0:6fa:937f:61d4 with SMTP id
 m28-20020a05620a215c00b006fa937f61d4mr65715000qkm.280.1670445812137; Wed, 07
 Dec 2022 12:43:32 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsM7jMMomy_=oNN236LfLJzMJbcNR=YWWJ74TgNO_16PWQ@mail.gmail.com>
 <CADnq5_PUCRGZoUu3RHrbD6+Dr_RHWdqkJKDBD2cWenWhQQiyKw@mail.gmail.com>
In-Reply-To: <CADnq5_PUCRGZoUu3RHrbD6+Dr_RHWdqkJKDBD2cWenWhQQiyKw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 8 Dec 2022 01:43:21 +0500
Message-ID: <CABXGCsO-GLzahLgNtbzsM-HiPk7cZvHu56ckSMLD7XeUvf28hw@mail.gmail.com>
Subject: Re: [bug][vaapi][h264] The commit
 7cbe08a930a132d84b4cf79953b00b074ec7a2a7
 on certain video files leads to problems with VAAPI hardware decoding.
To: Alex Deucher <alexdeucher@gmail.com>
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

On Wed, Dec 7, 2022 at 7:58 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
>
> What GPU do you have and what entries do you have in
> sys/class/drm/card0/device/ip_discovery/die/0/UVD for the device?

I bisected the issue on the Radeon 6800M.

Parent commit for 7cbe08a930a132d84b4cf79953b00b074ec7a2a7 is
46dd2965bdd1c5a4f6499c73ff32e636fa8f9769.
For both commits ip_discovery is absent.
# ls /sys/class/drm/card0/device/ | grep ip
# ls /sys/class/drm/card1/device/ | grep ip

But from verbose info I see that player for
7cbe08a930a132d84b4cf79953b00b074ec7a2a7 use acceleration:
$ vlc -v Downloads/test_sample_480_2.mp4
VLC media player 3.0.18 Vetinari (revision )
[0000561f72097520] main libvlc: Running vlc with the default
interface. Use 'cvlc' to use vlc without interface.
[00007fa224001190] mp4 demux warning: elst box found
[00007fa224001190] mp4 demux warning: STTS table of 1 entries
[00007fa224001190] mp4 demux warning: CTTS table of 78 entries
[00007fa224001190] mp4 demux warning: elst box found
[00007fa224001190] mp4 demux warning: STTS table of 1 entries
[00007fa224001190] mp4 demux warning: elst old=0 new=1
[00007fa224d19010] faad decoder warning: decoded zero sample
[00007fa224001190] mp4 demux warning: elst old=0 new=1
[00007fa214007030] gl gl: Initialized libplacebo v4.208.0 (API v208)
libva info: VA-API version 1.16.0
libva error: vaGetDriverNameByIndex() failed with unknown libva error,
driver_name = (null)
[00007fa214007030] glconv_vaapi_x11 gl error: vaInitialize: unknown libva error
libva info: VA-API version 1.16.0
libva info: Trying to open /usr/lib64/dri/radeonsi_drv_video.so
libva info: Found init function __vaDriverInit_1_16
libva info: va_openDriver() returns 0
[00007fa224c0b3a0] avcodec decoder: Using Mesa Gallium driver
23.0.0-devel for AMD Radeon RX 6800M (navi22, LLVM 15.0.4, DRM 3.42,
5.14.0-rc4-14-7cbe08a930a132d84b4cf79953b00b074ec7a2a7+) for hardware
decoding
[h264 @ 0x7fa224c3fa40] Using deprecated struct vaapi_context in decode.
[0000561f72174de0] pulse audio output warning: starting late (-9724 us)

And for 46dd2965bdd1c5a4f6499c73ff32e636fa8f9769 commit did not use
acceleration:
$ vlc -v Downloads/test_sample_480_2.mp4
VLC media player 3.0.18 Vetinari (revision )
[000055f61ad35520] main libvlc: Running vlc with the default
interface. Use 'cvlc' to use vlc without interface.
[00007fc7e8001190] mp4 demux warning: elst box found
[00007fc7e8001190] mp4 demux warning: STTS table of 1 entries
[00007fc7e8001190] mp4 demux warning: CTTS table of 78 entries
[00007fc7e8001190] mp4 demux warning: elst box found
[00007fc7e8001190] mp4 demux warning: STTS table of 1 entries
[00007fc7e8001190] mp4 demux warning: elst old=0 new=1
[00007fc7e8d19010] faad decoder warning: decoded zero sample
[00007fc7e8001190] mp4 demux warning: elst old=0 new=1
[00007fc7d8007030] gl gl: Initialized libplacebo v4.208.0 (API v208)
libva info: VA-API version 1.16.0
libva error: vaGetDriverNameByIndex() failed with unknown libva error,
driver_name = (null)
[00007fc7d8007030] glconv_vaapi_x11 gl error: vaInitialize: unknown libva error
libva info: VA-API version 1.16.0
libva info: Trying to open /usr/lib64/dri/radeonsi_drv_video.so
libva info: Found init function __vaDriverInit_1_16
libva info: va_openDriver() returns 0
[00007fc7d40b3260] vaapi generic error: profile(7) is not supported
[00007fc7d8a089c0] gl gl: Initialized libplacebo v4.208.0 (API v208)
Failed to open VDPAU backend libvdpau_nvidia.so: cannot open shared
object file: No such file or directory
Failed to open VDPAU backend libvdpau_nvidia.so: cannot open shared
object file: No such file or directory
[00007fc7d89e4f80] gl gl: Initialized libplacebo v4.208.0 (API v208)
[000055f61ae12de0] pulse audio output warning: starting late (-13537 us)

So my bisect didn't make sense :(
Anyway can you reproduce the issue with the attached sample file and
vlc on fresh kernel (6.1-rc8)?

Thanks!

-- 
Best Regards,
Mike Gavrilov.
