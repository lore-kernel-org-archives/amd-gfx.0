Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A7606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=usDCqEUF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD4410E4BE;
	Tue,  3 Nov 2026 14:35:48 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5487310F61E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:35:42 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3550dd02c9cso360168eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 06:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793716542; cv=none;
 d=google.com; s=arc-20260327;
 b=Ws/7KYciqc3PBDw51x1pR4sWHlaE07BOLNgsGvFn5gIWpwYP5BhLogxWBTwpBMZjT7
 Cq34mJ9lekdXtEWtBLwPM3tMlaAnxW9OlYhvdjD60NhxRRj66Y+KnKbMAyISmJkNGEwH
 s55MPiKzgpNzzo9sOmshy37fW2+VlK3qLni8tdAShk94FdwB3eMBGHWKPW3AREWu9mjs
 BXQlNuElRn58+GxXWjl/em9iTKDLQMYp1jsWnOP4j5jx+A/cFckXMB6uIcy+oOxMXwyY
 jliCF0cjQh7a373dmt5vpe0hxqBvygCoaoCNdQiTp2ZCVSLvWJfi127RTDzMj3oQOO45
 9eag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
 fh=uaMjc875/uE/NCcyPXgYLwUHAXGAtfOdADObQC1LDtc=;
 b=CIIqCfoqn8w2UONTtxGMLxqaUtPK6VYgBTkkg5n/NGCPkB3ZS4R85o+IPNiRHsGyZk
 Rv7mcKsfAb0PWluxa5eVEIIu0pLlUzv9Le9SLfIVttdN/roTEolHFMqqonwqHHYA4547
 5AdbYpHA3DH70xi5n4OsBtQIzmo2RReTATEpuKBzUc58ywVDYwnUN95TbhsrNkS++F1A
 57rr0Nj6/XJGtp1D2jZsIYYVfp4XGorFkye0LAkFEWdaEOTVT/3TDQZzQUmYzh2689JA
 SKay/NCPgwn3hxK9JYlVLRP7WZoXb03G4x2AU6daDE59HjSl56GJ39f1TvwP3hcuBU0o
 KNKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793716541; x=1794321341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
 b=usDCqEUFWoXzQ6/hwKyMl5x9sYpKumcMZfpxKptr1aizHdkSFDQ8PG5gYCvQyy9q6h
 3KaqdpPlxeTD50ZSWw4PCCriGt+p0i66QM1NNWF8bWvzuSTOrZ8quOpIJDv9hAzv5pX1
 8clg75QZjYIrgWqHe08KpW+gOXNXeckws4JMLJOC3BQA2qe5dX3+tdRFN96KQmmCE8Fg
 7k5IwjhRXW4C6ukRZUmwEegeJg+iMpA3wZ/bkVD5sWd93tTDckdVc/Wkzw7dKYGbhx7H
 qzogHrHa0wlCuMzGWBdQGUoGJG5RsWwt6caqmCBF6QWH8PxM6WEd9IviTE/52PdxuzfK
 MZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716542; x=1794321342;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
 b=wYHeYap8HWVue1RjW2ty+hvhMrgiFC2WlaC9wzYeh7yK3nVIihT7dKlj5PwsEIxF8P
 XdcQU71BE66MaF0SKH/TcPnGXwhshk9QyZdOVKIBk5kAodupLMntBkLn42NlbkwnPUmf
 cgScRiBcti4QdIi3G5I04ZEmGK66ukLj9QImasgCvR1w+EZ9Io1+PHPUAY8vy+/F7DJV
 qHhfW7Po4ZFf85Ih99HYMgDXZWouU8XNzcj7pc3mzMpBHgZ+Z9qlav8Q/mMkwCznChN1
 43XOR7zYiIJdAPNCly3R4Nc0qtn3hfiLyf5JiKbUym+ljM/dgc7iMvSZz2dwHmgBWgWI
 o8bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBypbJ12H8Hx6kO9+T3n8ecrrrj1s2JCjjFm/ytA4CmHFHSdekzEzLF78KIqMpKkOGVLsShem++q@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kg0teiz78fRypqRM0L8CGUcqUEsBBeXjOEdqseA8IvtFf+WeO
 NuITAnlG9e6cZk3DqMbEJw0VYOT0A0pbt5Hvv1FZQ8Q+bcZzjz5oeZ6gBYhHKYWRdq26yLZNPfN
 667s5m+KjmNmaviCRyb/k5XAeYspHmak=
X-Gm-Gg: AYBFou1njjElnSb7YQRB2tKIO2Oj4iy0mj7YCFy30lJKjSSBalg1w++/bOJRdESQVWr
 l0EYeUzUcfI4lSrU8PEBED+yCpzTUXLHUU45kMSP50b0hoM0U1eH6wvZRZzKeuC+L1w1IJ4WRmk
 AlAOePOzXMwbepC3izFGxQCIC13Sys+trihKde8JwnB+eWcxhEy6qy/LMj063AvV88MihsrKIb/
 ZbO+bsMG64s3S1RcU+dS6rZWYg3W9AxoQFKERjqWfFkQy7c6TXKQOlO1l6CCu64Yr58nEEcdhCD
 Muh4LBAKuQTkFIedXwidBdCsZHouxausEJvD37C9BmGr0ATM3nX9dVR1QaPwEPMCdxktp3vePhE
 aQX9gkjJk0i1D5eQ78iLcvHf9KJXWeAi+hHyc3qJVgOW+FrwmfTyUplzH7GPQrvUPMO0H+41Zgv
 GhDGLxRnWq53/M1gmtQ4aZITA=
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr32546852c88.0.1793716541521; Tue, 03 Nov 2026
 06:35:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024162109.307247-1-dev@deq.rocks>
 <20261102232450.61301-1-jahs@jahs.net>
In-Reply-To: <20261102232450.61301-1-jahs@jahs.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 09:35:29 -0500
X-Gm-Features: AclHuK8qKEQ3sadc6FgPVgIka6386fD7xEODSenxCq71uFCEpk0SM6ipVCbP90w
Message-ID: <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
To: James Skillen <jahs@jahs.net>
Cc: Andre Eikmeyer <dev@deq.rocks>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 3:21=E2=80=AFAM James Skillen <jahs@jahs.net> wrote:
>
> On Sat, 24 Oct 2026 18:21:09 +0200, Andre Eikmeyer wrote:
> > The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
> > 1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU message=
s
> > as soon as UCLK switches into its third level.
>
> This is the hang reported in drm/amd issue 6005, which has the
> umc_info analysis and test results from both boards:
>
>   https://gitlab.freedesktop.org/drm/amd/-/work_items/6005
>
> Could v2 carry a Closes: tag for it?
>
> I tested the patch on a MacBookPro16,1 with the Pro 5300M (1002:7340
> rev 0x43, 106b:0210, VBIOS 113-D32207P1-019), on linux-t2 7.2.11 (Arch
> v7.2.11-arch1 plus the t2linux patches) with this patch on top. The
> userspace pp_table upload from the issue was disabled for these boots,
> so the corrected levels came from the patch alone.

Can you try this patch instead:
https://patchwork.freedesktop.org/patch/765668/?series=3D174386&rev=3D2

Alex

>
> All at DPM auto unless noted:
>
>  - both "UCLK level ..." lines at boot and again after every resume,
>    pp_dpm_mclk 95/496/598/736
>  - forced pp_dpm_mclk switches through every level transition, idle
>    and under memtest_vulkan load (57 switches, every 3 s): all landed
>  - UCLK pinned at level 2 (598 MHz): llama.cpp benchmark and 180 s of
>    memtest_vulkan, no errors
>  - 60 min soak of llama.cpp runs with idle gaps, and 30 min of normal
>    desktop use with the soak running
>  - 8 deep suspend/resume cycles (rtcwake, lid, systemctl suspend)
>
> I ran these with the internal panel on the iGPU and again with the
> Radeon driving it (apple-gmux force_igd=3Dn). No "SMU: No response", GPU
> reset, ring timeout or DC errors in any of them. With the stock driver,
> level 2 hung within seconds.
>
> For the runs with the Radeon on the panel I also had
> amdgpu.dcdebugmask=3D0x1. That is for a separate DC issue (the MPC pipe
> split on the 3072x1920 eDP plane makes DRAM clock change unsupported,
> so UCLK stays at the top level). It is not related to this patch and
> I will report it separately.
>
> Tested-by: James Skillen <jahs@jahs.net> # MacBookPro16,1, Pro 5300M (106=
b:0210)
>
> The testing above and this reply were prepared with help from
> claude-opus-5-5; I have checked the results and the text.
>
> Thanks,
> James
