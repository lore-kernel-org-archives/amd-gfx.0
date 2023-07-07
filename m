Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0FCEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 20:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B2010E01F;
	Fri,  7 Jul 2023 20:14:24 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CBA10E01F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 20:14:22 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a1ebb85f99so2076693b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Jul 2023 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688760862; x=1691352862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7MGBPvaDFS4ZqHihwhivXiHenO9erLkh9HU9xAV9oI=;
 b=dzDPjb/yvSe/qWo7DkkKjG3/9mU/sSQ9gKk2CQjeVhk5zwnMpBey43ezRPSiqzLNLB
 QIEiGgd3n0uS9R5Y/SnzyPoU102/95AGTSyBkKo1zQ+0kBmQK0qu9pt0JB4xOtyyDU7L
 ODQOCHMvJT6T+m7zjSZJ9kw2nDm+WBqUC0BuC51v7Rthir9oLFKIU1mBSJtPaQgTRm02
 IaH76zoUKqMSKCydpBanAOtxDK79emcYlRd5cYTlGZQ7xa4DfMj3BLeJHpNznG+G71XI
 yDaJrXneQHFdRiNrLO8/w21/AcMdlK8mF6TnDnNHNqhvaZChzjGMBLv+Q+2gfMI8evsr
 xmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688760862; x=1691352862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7MGBPvaDFS4ZqHihwhivXiHenO9erLkh9HU9xAV9oI=;
 b=KRy5Hegzxol+eVMqrOfZRoq5K5yjcM1Rx4/hWXvCbzZqeHtIdv45fnWHu90sode1I6
 hdB/19HK3jPt4fDjq86N0aA9OyjtP7GBcHO5WYJNEMHHlA/Nn4qNO6FwAK57PGNNumit
 9+hreEAXHTaxIH2X1aOtKVWC3FG9ycQP7wF7cPdzUbJJp7dxsLsNC2ZYx6Ciw73HLmgX
 kvALsACyTv4N1VSygvD4nqYeSRbZ4CUJJ5XrH6cnSZssQJraEVkU2FGwW8wjJPHddAsT
 pyFmwYvVuotb0+Ehq27kcChB909Evz9IAlFmgRvdv+OBeD8qDgUehtQLjrTiW37nGCTA
 WyeQ==
X-Gm-Message-State: ABy/qLZSdeep4+BhG5nbb3jfpra+7BOACnkBvqRNCX0VkXTI7FWV0aA3
 DG8wOfnvHyNb/vvw3OFeGcwFSy+MF0ag7iqQjow=
X-Google-Smtp-Source: APBJJlGTlK1qNgdTrj3aV+UsqujYmBTltElaa/HLl7zNzVLxR4oMjDBLF2+nDNKIpY2DIqgKABKEyIESqngA//22CYY=
X-Received: by 2002:a05:6808:221a:b0:3a2:ee9b:4232 with SMTP id
 bd26-20020a056808221a00b003a2ee9b4232mr6579760oib.58.1688760861825; Fri, 07
 Jul 2023 13:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230707193135.16716-1-mario.limonciello@amd.com>
In-Reply-To: <20230707193135.16716-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Jul 2023 16:14:10 -0400
Message-ID: <CADnq5_Mz6PmTCioRqQUW5ZG0bGLBgnzQcT-zC59xpyAcp77Nhg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Disable dynamic switching for SMU13 on Intel hosts
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 7, 2023 at 3:32=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When ASPM is enabled, DPM is used to perform dynamic switching.  When
> connected to an Intel PCIe controller this causes malfunctions.
>
> Identify this combination and disable dynamic switching in SMU13.
>
> This series superceeds my other series [1] and fixes it in a cleaner way.
>
> [1] https://patchwork.freedesktop.org/series/120245/
>
> Evan Quan (1):
>   drm/amd/pm: share the code around SMU13 pcie parameters update
>
> Mario Limonciello (1):
>   drm/amd/pm: conditionally disable pcie lane/speed switching for SMU13

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

We should also fix up the smu11 code in sienna_cichlid_ppt.c
similarly.  We implemented a similar, but more limited fix there
recently.

Alex


>
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 ++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 67 +++++++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 +--------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 +--------
>  4 files changed, 73 insertions(+), 64 deletions(-)
>
> --
> 2.25.1
>
