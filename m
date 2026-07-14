Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40627C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 20:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA27D10E0C6;
	Tue, 14 Jul 2026 20:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKMmk1IS";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F4610E0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 20:18:05 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cb2513ec378so40756a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784060284; cv=none;
 d=google.com; s=arc-20260327;
 b=o8jMlhHFSx2A4M7V1E0LeAN/GD3r7FdPKY63gvkbfJ5UR7imDawHS8XNAuN6y01gXU
 YB6Ej6yH/PNHTufDiJWRdzfrl7tWaBQllmIZNwf4gePYA+AnRgf0eMipgWxoC3feRMI+
 2Sixn2h7nA8OHQLRO3FbOfOpwD9ZL2Lipk8U6eaxlpw9rJHTaGA7h/Hz8WMr9zOqHHRa
 p6r15IKOAi5/9Ved5UPo2gmYgVpInMLarWGjS6j38ldPzk9zzBSZmzr/PFi8/NYfyUpf
 UD0hZoaH00RSJsIZ6BexjNjbaQI15y+EVuz2FMriJSPxBAHFWvq3SpJDxWbU5njDJ8s8
 HxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NsO7TGUCtDgPQX8R6DTCu9VScHAdML9Kd8O0ZONKQos=;
 fh=IAcva+MWpDdGsT4JXC3vEHPqfv9BkotdqBMMbkH7GNM=;
 b=pWHlWsnrBn4OSzY4HS9ww5oSMr5cvkd8MzudN5wOJNGBOSPoDwfpNYH2vFlv3ZV7vR
 tETZwOShtNVjAFo0aj6827IsOuUGAzzzC+HPCfY+ahCi8oIIwEDg6oPJWw6MZmVL8xp5
 s4fdIrPcExfC+GC1T5B/eH4XpXalUTIHWiFcB+WM88lSZg2k/tltkBL6k8SjIAaEyVrh
 RQkN9ljl+FYlzw4sb0WuArrdTuOU0zzmY50jGw42yASSX3DqrT9aRUG6/5DXQCKex7oQ
 0vaAjLrd2vibyJqWAF8BS1lzYQBfeI3e6mFrIUM/QNQkoyIMxMitx/7LoqW6VqpA5rek
 3rmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784060284; x=1784665084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NsO7TGUCtDgPQX8R6DTCu9VScHAdML9Kd8O0ZONKQos=;
 b=VKMmk1ISzrOeJIyI9OH02P0+BWwacwyVd7hU/PSCw2uQGLrTZrIbgsi/SOjl+pCxWw
 P94UVJ4jKYoYYG9yQ7COOfW3OcR6DE838VyzKx1IeKgjRvXrNOkf1Xr1c++K19BcvbQN
 BKo7eeqiV4UBU5Uh3/ygyTYb7huLvrgQUBrbn10cJ1eZqW9LsxI1tMO1NvBSyagnAorr
 fGbzXWO2rYB8zepV0NnCWbSaybUJuHHmpojMITVUGtsKIA1rEtWIcRmRy8FcnhARl/hs
 XJQGiFtsinMXX0B0oI1fx1ECJ58z6B4263dJDv4/9OieZHGuhZ7BGRf391TG5mpYRWGv
 8mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784060284; x=1784665084;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NsO7TGUCtDgPQX8R6DTCu9VScHAdML9Kd8O0ZONKQos=;
 b=qNVVMT90eA9A3vsNiSEhtHl7h5Ba8U1MjJFANEylLYm/lzeo4k+N15n22XPyx0OZog
 srQYEKYXKQyhH1nsjla/wIkcoJo4Ii3Lvq29hjduT34z1GBth1wNzsSzkIy7P9O9u/3U
 C0b3tPCMcITfWJn/kSMDexngxeSpJ6TTjM8nVNl3t8IUAud+Wajlcz8QXj31uTsDMBdD
 5BpJDTDpMJd+sY8mjerkn6buST7tXOmbsIqy9GW36M8oXq3ZivaaUWAY5DCC7nA8jXcw
 bJhDFSkxPlMIqcGCejkr8Xon+Sxwwcv+3xq4zJV310AwY8iHE56b4rhMG/QvCnunJ5FX
 pwlQ==
X-Gm-Message-State: AOJu0YyTIWqUKQtDopj1UdcGwODLxRkppj83TZxmxXKC94lq+fJ66S0K
 2W5ga5hR5ZySqzuthdgnyWGnkT6uYz+/+qjQHm8yKPAvm40puENjHFJcNU0lIWC5u3y3vi3cDPg
 r4hotMcGsgyRvsOSKyghkAaWRFN39cw8=
X-Gm-Gg: AfdE7cl5hgNZO/K6Y7AUw21BuBCiixpzFi71iTIsCCKwqr6Xs1K0Q5P6DOlJ3Otr3Ss
 8hxqqQcwmzjR7gxfcoM2kgkWEtWFa4wUul0OfAzGlWeziibGBV+4dMgXrLmbypcrEuBFMteWNSE
 z4KkHiNkFKiyIOhFhVb/IFRYQ4/lC+P8ucI9xI1RGavp1wL6RwT/LKqC1ZYtAUpwwhncLLTL3Tb
 f3iZNQD6Xa1iiMim1G7lb101TkyW+rQ/dMhFOOgD4Q2lYFKXgvISknOevY3OiaUcw/to4n0cYEx
 ZTmCngSfERb7TKCwGg36U0kpbBpfUaxcZFCRd9lx2vKTaEnxZC0kelGMQSVGas9mgFrLlA==
X-Received: by 2002:a05:6a21:32a2:b0:3bf:d1f9:b1e5 with SMTP id
 adf61e73a8af0-3c110b6c280mr11945290637.8.1784060284346; Tue, 14 Jul 2026
 13:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260706172950.1586506-1-kent.russell@amd.com>
 <BL1PR12MB589858F4A8DA255797CD710385F92@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB589858F4A8DA255797CD710385F92@BL1PR12MB5898.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 16:17:52 -0400
X-Gm-Features: AUfX_mytOmqPwr5Ug51sALztXOPu9yhsac4v_K60eKzbPUWXlYRPhO_Hg8LOmm8
Message-ID: <CADnq5_NxhQjurNz0NwFVkbCCoUW0NWGg6AHaTMr3D-K7DYtD1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Clean up debug runlist printing
To: "Russell, Kent" <Kent.Russell@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jul 14, 2026 at 4:14=E2=80=AFPM Russell, Kent <Kent.Russell@amd.com=
> wrote:
>
> AMD General
>
> Non-critical ping
>
>  Kent
>
> > -----Original Message-----
> > From: Russell, Kent <Kent.Russell@amd.com>
> > Sent: July 6, 2026 1:30 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; Russell, Kent
> > <Kent.Russell@amd.com>
> > Subject: [PATCH] drm/amdkfd: Clean up debug runlist printing
> >
> > Having single lines with random hex codes really doesn't help a user to
> > know what's going on. Give it a title, and print 8 8-length hex values
> > per line, instead of a single 2-length hex value per printed line.
> >
> > Previous output:
> >
> > ...
> > amdgpu: 0x20000010
> > amdgpu: 0x3000
> > amdgpu: 0x12E6E00
> > amdgpu: 0xFF
> > amdgpu: 0x207008
> > amdgpu: 0x 0
> > amdgpu:
> >
> > New output:
> >
> > amdgpu: Runlist dump:
> > amdgpu:    0: 0xc00ea100 0x14008008 0x0f4fffc0 0x00000000 0x20002000
> > 0x00000338 0x00000020 0x00080017
> > amdgpu:    8: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
> > 0x03400000 0x00000000 0x00000000
> > amdgpu:   16: 0xc005a200 0x20000010 0x00003030 0x012ed000 0x000000ff
> > 0x00252008 0x00000000 0xc005a200
> > amdgpu:   24: 0x20000010 0x0000302c 0x012ec800 0x000000ff 0x0024c008
> > 0x00000000 0xc005a200 0x20000010
> > amdgpu:   32: 0x00003028 0x012ec000 0x000000ff 0x00246008 0x00000000
> > 0xc005a200 0x20000010 0x00003024
> > amdgpu:   40: 0x012eb800 0x000000ff 0x00240008 0x00000000 0xc005a200
> > 0x20000010 0x00003020 0x012eb000
> > amdgpu:   48: 0x000000ff 0x0023a008 0x00000000 0xc005a200 0x20000010
> > 0x0000301c 0x012ea800 0x000000ff
> > amdgpu:   56: 0x00234008 0x00000000 0xc005a200 0x20000010 0x00003018
> > 0x012ea000 0x000000ff 0x0022e008
> > amdgpu:   64: 0x00000000 0xc005a200 0x20000010 0x00003014 0x012e9800
> > 0x000000ff 0x00228008 0x00000000
> > amdgpu:   72: 0xc005a200 0x20000010 0x00003010 0x012e9000 0x000000ff
> > 0x00222008 0x00000000 0xc005a200
> > amdgpu:   80: 0x20000010 0x0000300c 0x012e8800 0x000000ff 0x0021c008
> > 0x00000000 0xc005a200 0x20000010
> > amdgpu:   88: 0x00003008 0x012e8000 0x000000ff 0x00216008 0x00000000
> > 0xc005a200 0x20000010 0x00003004
> > amdgpu:   96: 0x012e7800 0x000000ff 0x00210008 0x00000000 0xc005a200
> > 0x20000010 0x00003000 0x012e6e00
> > amdgpu:  104: 0x000000ff 0x00207008 0x00000000
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > index b1a6eb349bb3..85bf1790a6c8 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > @@ -269,9 +269,19 @@ static int pm_create_runlist_ib(struct packet_mana=
ger
> > *pm,
> >       }
> >       pm->is_over_subscription =3D !!is_over_subscription;
> >
> > -     for (i =3D 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
> > -             pr_debug("0x%2X ", rl_buffer[i]);
> > -     pr_debug("\n");
> > +     pr_debug("Runlist dump:");
> > +     for (i =3D 0; i < alloc_size_bytes / sizeof(uint32_t); i +=3D 8) =
{
> > +             char buf[128];
> > +             int j, len =3D 0;
> > +
> > +             /* Dump 8 entries per line with an index for each line */
> > +             len +=3D scnprintf(buf + len, sizeof(buf) - len, "%4u:", =
i);
> > +
> > +             for (j =3D 0; j < 8 && (i + j) < alloc_size_bytes / sizeo=
f(uint32_t); j++)
> > +                     len +=3D scnprintf(buf + len, sizeof(buf) - len, =
" 0x%08x",
> > rl_buffer[i + j]);
> > +
> > +             pr_debug("%s\n", buf);
> > +     }
> >
> >       return retval;
> >  }
> > --
> > 2.43.0
>
