Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD75C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 15:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF3B10F92E;
	Tue, 11 Jan 2022 15:00:29 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4E410E296
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 02:23:03 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id i5so7712869edf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 18:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VDFF6vcwE/TPS4Bt0jt6DdR/lz4gZprEiARRzw5a6Io=;
 b=dJDgY15gVyHjJT/hG1Aj8S+rnxUuUkTSco0i4Zn3r+05ajdLaK9tNqk0tN5/w79pm4
 TVTwm7UzrvGzsqw1IHEx42V1ZvgeO26COuPrXlqA/Ap7orFBU4WfHPAqYCWNVlJPYMmo
 9BuDDZRgWcpPZH1lr19ZH6e6VF87hE6uN/Ewg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VDFF6vcwE/TPS4Bt0jt6DdR/lz4gZprEiARRzw5a6Io=;
 b=swl++LEIWFvRsgr8gJIfjsZicUbHIg1pBETeMRi+6y5JIp1uwYD8EX+mLFMHX0IiOv
 mw6BBtvWL2G32LRAVF5ABEsm9b69tN5nt3s2OU2KoJtL/Rdn+9yV/PGwpoo0WkleeG5I
 C6YH264dGXlUIIzqKN8ylKQ2VVVl5pfXc4yuDUJwX0/pIidAdfe813aGP5o2Qgfe5pZt
 4qpSEf5RsZjw5gYYpr5geSFRYAOlCxvKks4RppyvMzvVDzhQ8PDyI9Tcy/5jkH+hTXu9
 KTNsB+wO0eQDvJdSLnPfGVy7CbO1JbG3uVHZmnhP3oLEofaym/GGdiq/B0JvawXblN1L
 a08A==
X-Gm-Message-State: AOAM531W1HlKA9E7n2w6scM/NtgJdvDoHOxNGczFOhHnV+ldyhdTKYJ7
 Ehfy0HWHMKiMvhRgGk/AL+e1ZN3U8XKA6IOIUm8=
X-Google-Smtp-Source: ABdhPJz2BNYONasnhdbisxKBOmxyao5Wd/coY+sVlQ/elCM4r9dn/lRtCLvXRNRVkap9zC+tlGevsQ==
X-Received: by 2002:a05:6402:486:: with SMTP id
 k6mr2408226edv.330.1641867781792; 
 Mon, 10 Jan 2022 18:23:01 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45])
 by smtp.gmail.com with ESMTPSA id hs8sm3031222ejc.186.2022.01.10.18.23.01
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jan 2022 18:23:01 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id k18so30201041wrg.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 18:23:01 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr1838192wrp.442.1641867780948; 
 Mon, 10 Jan 2022 18:23:00 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
 <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jan 2022 18:22:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com>
Message-ID: <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Jan 2022 15:00:28 +0000
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <harry.wentland@amd.com>, Dave Airlie <airlied@gmail.com>, "Koenig,
 Christian" <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 10, 2022 at 5:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll see if I can bisect it at least partially.

It seems to be very reliable. I can see the flickering even at early
boot before gdb has started - the graphical screen where you type the
encrypted disk password at boot already shows it as you type.

Right now it is

  bad: 9602044d1cc12280e20c88885f2cd640ae80f69e
  good: 3867e3704f136beadf5e004b61696ef7f990bee4

so it's going to be one of these:

  9602044d1cc1 drm/amd/display: Fix for the no Audio bug with Tiled Displays
  a896f870f8a5 drm/amd/display: Fix for otg synchronization logic
  aba3c3fede54 drm/amd/display: Clear DPCD lane settings after repeater training
  9311ed1e1241 drm/amd/display: add hdmi disable debug check
  6421f7c750e9 drm/amd/display: Allow DSC on supported MST branch devices
  ebe5ffd8e271 drm/amd/display: Enable P010 for DCN3x ASICs
  c022375ae095 drm/amd/display: Add DP-HDMI FRL PCON Support in DC
  50b1f44ec547 drm/amd/display: Add DP-HDMI FRL PCON SST Support in DM
  81d104f4afbf drm/amdgpu: Don't halt RLC on GFX suspend
  fe9c5c9affc9 drm/amdgpu: Use MAX_HWIP instead of HW_ID_MAX
  370016988665 drm/amdgpu: fix the missed handling for SDMA2 and SDMA3
  6c18ecefaba7 drm/amdgpu: declare static function to fix compiler warning
  94a80b5bc7a2 amdgpu/pm: Modify implmentations of
get_power_profile_mode to use amdgpu_pp_profile_name

and I guess I'll do the few more bisections to pick out the exact one.

             Linus
