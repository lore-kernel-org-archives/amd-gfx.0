Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32943D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 19:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA7010E475;
	Mon,  1 Dec 2025 19:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f3A7YJuD";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4745A10E475
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 19:59:26 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7baa5787440so242187b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 11:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764619166; x=1765223966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oT2xrfYYa0bfXZdPCFwnZPyZssCPyPaSddoKhPT1g0k=;
 b=f3A7YJuDS/ryA74brxdnLvHYGH0IcFrfh/1kztwNbJXDlQnNP7P0C1aGpOgYDPfjPP
 vVoaztXz8e7LsviHNXV/Ayy1TBArU/Ho6sy+TKnyFrGNNHQ6uxt9bg+GWmIyFIbAkD+r
 eWtsiT0vrcZL09WUmWpccG9ZT9x2qcrAUB1ocgc7J0XmLjH2Y7PqR8N7ThJk6mS4PDIx
 SqT25ylSiFhLPvqRSZfxUSk+lnm6zXcLqwhjACr7nxcHkPZ6Aeh7lf4Y55pfl1YzPhZP
 vQ81OE/QyL8xGZ1F7GH7efRt8U0UBfMZeIKOAQNqMoMFFc2ldBZ02WRSUT0Es/1mOv86
 DqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764619166; x=1765223966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oT2xrfYYa0bfXZdPCFwnZPyZssCPyPaSddoKhPT1g0k=;
 b=IN9gJDFG40h2naVaRz9LIo52qJ0nByQVRp0eCFwYc2Ue+393LiQgYR5qWYpRXFC4TQ
 b44P0kxoTtOEjrZaQQE18KI/QRGEJo/krkV9r8HWAUBIG4ZR5KZeo2d43SxrOvtzAJAY
 qA5iOXXxg4yPnxEIeNct+b4YnQuXJfLQrGSHIpfmwDOH/f3anBsG1gVfvhgsG0SnRlgn
 b+Mppi1DRIWpkLzJ6aC6PcFm+bzbDApBdLQyy8seqbUFx2gbje0PrVqeuxoQBVHeqPQk
 Bdl1LM/dfynZU/bDmB1jhIgxXbrsaNMEPY8F3bZN08aAGMpnzuwdQNevCAukqpccafun
 bDHw==
X-Gm-Message-State: AOJu0YwDUXerzjeAgzAGmFux8sSLjOx/f6510Op0oYH3aBUxugiQcC1B
 imZCz17zmESx9mMPaVsddzXnhMVw0CIXT+qP5MckL7EDWyuwqo8Bd6zOZbwjBSADnjLtEoWYmem
 u/8t9oWRFG4BEn4a2bUSRnE68jmDe0Rg=
X-Gm-Gg: ASbGnctHJznGWc56loOBIh7qvjepROu2QfaOvW7Buc9OLRKsWwobV96mhmSfkZEZGxR
 r/FPcUP2KXa/boNgqLoh3wD8a0zXWC+pugsgmO0GGOU4E5BHwmqKfQVfQqR/K4pc/hGnzjCHxWX
 fjZD+SpL1OnKtYCR1QtfbmQZ6dHhcJR0z4KkJWhyOcB75JO+RYhy1wlLHxjUvq8p6xDkCOi1+dS
 hLIuo1Pu1dWdwNJLHJayT2YHLlSRPZb5Hvtl71bz7wr8YcRMv69ekRArQ4X+D0wcRXuTOR0QyWN
 e3STXg==
X-Google-Smtp-Source: AGHT+IFKhQzBH2lXt76tDRKRfjLucMGMzTiz/tnV8Al8zSYTmnfop9LsP9m9aHbgXT8+YNPmnmv1YbHtRiFwA1MCnHA=
X-Received: by 2002:a05:7022:4414:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-11c9d71a68cmr22643743c88.2.1764619165457; Mon, 01 Dec 2025
 11:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20251201101331.101584-1-lijo.lazar@amd.com>
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 14:59:13 -0500
X-Gm-Features: AWmQ_blalXPKc3xDSSXzNsqKsaeoNNluR7DDG8N8GwK6NcxQWsBcu_Gar_XPX3I
Message-ID: <CADnq5_P316BZLL3JvQD2h_pR6-g4gT_k8mm6uROH4YvdKqz8-w@mail.gmail.com>
Subject: Re: [PATCH 00/17] Use common function to print dpm table
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com
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

On Mon, Dec 1, 2025 at 5:24=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> This is a follow-up to the series which keeps only emit_clock_levels to p=
rint dpm table. This series
> moves the print dpm table to a common helper. Presently, each IP version =
is maintaining separate dpm
> table structure which is really not required to represent dpm tables. A c=
ommon dpm table structure
> is used across IP versions. Pcie dpm table follow a different format, hen=
ce it is kept separate. A
> helper function is used to print the clock tables in pp_dpm_*clk interfac=
e. The function takes the
> common dpm table and current clock. It helps to keep some uniformity in p=
p_dpm_*clk interface across
> IP versions.

Nice cleanup.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> APUs currently don't use dpm table for printing pp_dpm_*clk, hence they a=
re not moved yet to use the
> helper function.
>
>
> Lijo Lazar (17):
>   drm/amd/pm: Add clock table structure
>   drm/amd/pm: Use generic dpm table for SMUv11 SOCs
>   drm/amd/pm: Use generic dpm table for SMUv13 SOCs
>   drm/amd/pm: Use generic dpm table for SMUv14 SOCs
>   drm/amd/pm: Add generic pcie dpm table
>   drm/amd/pm: Use generic pcie dpm table for SMUv11
>   drm/amd/pm: Use generic pcie dpm table for SMUv13
>   drm/amd/pm: Use generic pcie dpm table for SMUv14
>   drm/amd/pm: Add a helper to show dpm table
>   drm/amd/pm: Use common helper for arcturus dpm
>   drm/amd/pm: Use common helper for navi10 dpm table
>   drm/amd/pm: Use common helper for sienna dpm table
>   drm/amd/pm: Use common helper for aldebaran dpm table
>   drm/amd/pm: Use common helper for smuv13.0.0 dpm
>   drm/amd/pm: Use common helper for smuv13.0.6 dpm
>   drm/amd/pm: Use common helper for smuv13.0.7 dpm
>   drm/amd/pm: Use common helper for smuv14.0.2 dpm
>
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  31 ++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  49 +--
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  47 +--
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  47 +--
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 188 ++++------
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 200 ++++------
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 197 ++++------
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  40 +-
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 249 ++++--------
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  86 ++---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 205 ++++------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 353 +++++-------------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 205 ++++------
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  81 ++--
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 215 ++++-------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 118 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  10 +
>  17 files changed, 857 insertions(+), 1464 deletions(-)
>
> --
> 2.49.0
>
