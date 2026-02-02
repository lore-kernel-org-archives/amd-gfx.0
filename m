Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35A6E7FDD8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 21:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E94010E45C;
	Mon,  2 Feb 2026 21:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CVQD8k8s";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA99510E45C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 21:25:55 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so207153c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 13:25:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770067555; cv=none;
 d=google.com; s=arc-20240605;
 b=OVoh39NB+gKMX4XNfTSPhHwbpXKVR5d1h+LIB0ix9SFeYmhMReXW8GM9yuQCe6kNnA
 epCIZ2nRT7253u/mbZ8mt9kgH8Y0l3Amg+IbiYxXFyXb0u9Oo/89yTvaWhid6mAEZcyw
 BN3T/wdo4IK7SjPP3Hof0mVfg2aCXhepWV0UEAWOdUUIWoINjqA1BaAwohf9yOp9fql2
 UjCbsEcC+f5VAot//3KRO0HWYNtidbpzZ4JRJxwApinP0333xNhLn/bma84fW6JKNhik
 LkUbIO9Xd1r2ZjVB/ZFYoey5HgqlyKaBFFphYYTkP78CMvDuHbrk2h165CbsRF2PW0if
 eaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LQFd+zRUPnSyNzkZO7lsbPXA6Il2rqJUAo7MPuJn8X0=;
 fh=8DZmM85xuvbXmFbHcbzFCeFE+SfOOzQf8BT8uIXhUtY=;
 b=dwnFflDApvUrV2FmVSlCtjRtOvWtLEIsE6hxAiDewJEIp6Mg+Xery3Q/bk4ZPE0r32
 sXKenHsPRvKz0+dGf/Sa+Y15SRvJ0VrgXV5sRrT/XHyeiVc9gqBG8FewOc0noTARiIyN
 8RTNnN5D9MTYxM016rTSTDZ2usDD/0izVy/QlDmBwkI9bY094/nH78kh//abtjg24+Ni
 Rl0KZ8qMXyDb2xKR8DZj5FSymuyxg+tbR7IgetvayZs7Rmd9kSoR/5kD6wWQxD0KPFil
 KdTkyuBjv0CIHYvI6QHmjk22Pkgzc4af5ZpKPjgWkAhh6b7JsABQOXIVFKGYIq4k5++t
 f8XQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770067555; x=1770672355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQFd+zRUPnSyNzkZO7lsbPXA6Il2rqJUAo7MPuJn8X0=;
 b=CVQD8k8srYYWcd2J5/oGOKnm2p8Q6GSS5om8++HoyplIbnY6aBQe6+6ftoeRE2jPOo
 4e51DtFZGUoeA52oKH/gmOUwJqS33JoQoQmfhTdsEB2M3w8vduruBX9gVRrYZ9T7g+AI
 DioBX6E+7LIl5rU6GBkuQtrL537ZLoqqifRBvHkphI1MvSv858NymEootqA0KFbtpoAF
 ZpuDQh2T+diM7Lm6BiuzBDtgIjX7dxr60kNzHlISkiJXVFSk4J+/Ji03udz/7m6mhW7A
 2NgDoN+ylnYWhk97xw7tkOo0swLHllxw2/baRHdVpWfA3iXcDlZVERuHumD2Z56Lt/Wl
 8TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067555; x=1770672355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LQFd+zRUPnSyNzkZO7lsbPXA6Il2rqJUAo7MPuJn8X0=;
 b=iO+njpo/r12NcMHUhi2JYaF/+3ZBAE4ldU1AVwS0YML2HQ0U3mG0Bvn0HTIQ4qIK2Q
 3ivHOhPyn/4wAAzTm3E6A3Ll05wj+NkoACLYyNbt6la/LJFTFvTsAaEvSBwp3Zbunq3Q
 /uZIqzwuuena98NxyDjgbxyG6D1Iv4915k/LL9qsweGbie9EJMOKL5O1G25D6HtW8ajJ
 jYrqektYKRzT65rjnxiZXomiRO/vjaXbDfpxUrdaL2T6YnDQhiz5Hi2KmTRjZtYUwl6F
 DAqO0o8f5ddoSldfulW0z6Tb6R2FfVmkbkHkX6ENTWR2HutsZUAa3K1WdMqWeMKXRlhl
 pw7w==
X-Gm-Message-State: AOJu0Yw8UMg1B7TW/lf8rFD3VirITGr0yBGrbBWD1W64dbAuvS5ylOAX
 Rih/YCAoOQ9pmUArKGOOwpB1r8+Fs6MKPPPVF6Gzu3wL4O7m0hN1/ZRLVuJta5BL0t+YlFYilnt
 Q2mHT18XNkBiUq+0+7aH2DpLmyS7rM+E=
X-Gm-Gg: AZuq6aIfpB12i6U+r/9lkuB9K1YQUrF2x8Jsw5UdwCgMAJ3oS6XpxtOpffM5yEyV9CG
 nLt6dycRgq8jfVcT7N1OjkjDMIxKpzvJp9N4R3hIh2x5J0/dlL7GQSRcpZQHu4AIgFNVH9LYPCJ
 Aq313uZS9lYoyODQeEwZpsNO3AuvIpMF5Uuu6CkE783md4F0XUFVyDjcsGr88Xj9rZJwXKDiKtS
 HFgWcxVsMZdzX3pOFW3Sm9o3GFHYjNq7V+I0mmoC6ti+BTHK+u5OJklOOhmFfPpvmJRjUy26p1h
 Ya1Fdzw=
X-Received: by 2002:a05:693c:300c:b0:2b7:24a1:865d with SMTP id
 5a478bee46e88-2b7c86502famr3494311eec.3.1770067555015; Mon, 02 Feb 2026
 13:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20260202112508.43000-1-timur.kristof@gmail.com>
In-Reply-To: <20260202112508.43000-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 16:25:43 -0500
X-Gm-Features: AZwV_QhR1beVi08zaYBlNhp2cLC4Cj7tXOyyGkwVbCB5giXDRK2tRbYY3C_BWX4
Message-ID: <CADnq5_OKvYO6ibNLmzuK3tW_sEaaCB82FgoLUc+NPb2asuck=w@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/amd/display: Fix and cleanup analog encoders
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com, 
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com, 
 Mauro Rossi <issor.oruam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 2, 2026 at 7:17=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> Fix a "black screen" issue with analog connector support in DC.
> The Radeon HD 7790 series seems specifically affected.
> I recommend backporting the series to 6.19 to avoid regressions.
>
> The series also makes the analog connector support more consistent
> with the rest of the DC code base so it doesn't feel like a hack
> anymore, ie. it brings analog connectors a bit closer to other
> connector types.

Series looks good to me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
I assume Alex Hung or Harry will pull this into the DC promotion testing.

Thanks,

Alex

>
> Timur Krist=C3=B3f (8):
>   drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
>   drm/amd/display: Fix disabling fastboot on DCE 6-8
>   drm/amd/display: Don't call find_analog_engine() twice
>   drm/amd/display: Turn off DAC in DCE link encoder using VBIOS
>   drm/amd/display: Initialize DAC in DCE link encoder using VBIOS
>   drm/amd/display: Set CRTC source for DAC using registers
>   drm/amd/display: Enable DAC in DCE link encoder
>   drm/amd/display: Remove unneeded DAC link encoder register
>
>  .../drm/amd/display/dc/bios/command_table.c   |  3 +-
>  .../drm/amd/display/dc/dce/dce_link_encoder.c | 58 ++++++++++++++-----
>  .../drm/amd/display/dc/dce/dce_link_encoder.h |  8 ++-
>  .../amd/display/dc/dce/dce_stream_encoder.c   | 23 ++++++--
>  .../amd/display/dc/dce/dce_stream_encoder.h   | 12 +++-
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 58 ++++---------------
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 +
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   | 14 ++++-
>  .../drm/amd/display/dc/link/link_factory.c    |  1 -
>  .../dc/resource/dce100/dce100_resource.c      |  8 ++-
>  .../dc/resource/dce60/dce60_resource.c        | 11 ++--
>  .../dc/resource/dce80/dce80_resource.c        |  8 ++-
>  13 files changed, 127 insertions(+), 81 deletions(-)
>
> --
> 2.52.0
