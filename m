Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0ACCD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 18:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D3C10E82D;
	Tue, 16 Jun 2026 18:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bbka80Jt";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1594110E82D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 18:42:07 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bca8ef052so17791eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781635326; cv=none;
 d=google.com; s=arc-20240605;
 b=bAvHyDpI9P9JlLkMOqlQwEipZE/e/G1yQ8CnSNfxjf/e20xJ7p1RSAoCrYxhr1ihzU
 tN1UgaGOFE8Wsy3Qw8X22N3CKSUIOtZDWsEJ2t1yJM8cRbLUVh7rfyI/gTxUqe3OzIcD
 ChCD2wpZYrqChFDzejXVcJRiC74UoItFxXlcx24XVO2Tasg4P36guLP5bVUoWdjQzGiU
 taDGNs1h2dzv56yvyev2p8QGvHWyUew59miKcdPW/la4qFasQ+xznqDAKeftrUVaoirX
 gDEMjdFdBjXFyT9QjUJ73Pzf+toGG9Etccs6e/aW9MLHxNrohWrbAnFaXI1fnHVWwpLc
 R12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xmPMTeJS/xt/8mX+0OpU5PUYi7ifD0AyLPnnk6Y9dWg=;
 fh=cv1FzeVZXCbMHmfVuZLczL/+ob1y9pdOhdAlfvtOVdk=;
 b=XA9127XRd9nJtlPrUoOPvtm5CC6N6GcA0pp86PrHNVNkJgPauYuv5OK2ZpP4n8Gf8C
 9gFiufLWYle0h8K/Zo//lMMhw52NS1cOm2b5rt7lry7LiZ0ZLHn77idZOuCm5sPmew+u
 zsrVpqY0FBcfOQHrdM8q0qStD5T5lAZyUZKjQq1feNhLqHdWKixj1enZmR6XJEbDkKkp
 c+sFeSQwTVOO/oLg2rFwmoEbKXfnpt7E00UFSJEmXO9LNEyeca9sEAU1Kyl0sy7OP++v
 6SXcNC95AzO2wfLtIqs3G+Vf8RYnw7M1tiKIsRtent5nSXFkl1fD5LBd4K6+ymaWea09
 RiyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781635326; x=1782240126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmPMTeJS/xt/8mX+0OpU5PUYi7ifD0AyLPnnk6Y9dWg=;
 b=Bbka80JthwStve0tPciUCEx143WIpoJeE48kvr6pGEENMbaW4JnIquX/BZiyKt+QU9
 iLP/vv89092t/8FFZtkq5a58CWiswUIUFV0THPuTlGs8WdSwcdRhB1oVViRBi86MtRv8
 7ETYFPW9wKnikNV72ATTB1QrYoG1YF65QKX+LO967CG/hcXUSBSigNeZ9gZ0komKBOoG
 3TKpQnGHd39HFSiUsECBNg5pF/5YlCtIiMhRuX0oPbV+CV3Pwh9lADNOAsmmGTn1o0jX
 3It853D1Jti4enpJJxaDeECYCADK08NQeRgzAx4vTGrLTdhIVmfZElJKC6GcAvt1dyA1
 h1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635326; x=1782240126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmPMTeJS/xt/8mX+0OpU5PUYi7ifD0AyLPnnk6Y9dWg=;
 b=URrSc8gONU0Mn7QRxBJGF1eTqkPQ5f9KhbHcarnusjYp6G4LF8CQoNOxBmPeBUVc+f
 8yJ3bEAfZCi5h+usafhmSPGblO87zcoT7wYV4pNAZocgOVlcDfu3KtZ+El553ib1FUlU
 N9ne/bhGgO4Vw+u7+uDI4ZGr1HDcyELK1ujCtntT9PzJnVXtT/MkGgsXUmF/jwQ1Z1zK
 SxWNyFwS1Lw//jTeMnCs8JfqmV+O7q+x/sDZPjsYTUIXJu6aWY+Lm6MFGLRKW71yr4Xk
 Wuu1T/ODc1HfkRHhntqQOrETh7WTfMxYtuHnI4esJsQjRJ7I/jnUu8q329YbWw9eBvk3
 sFvw==
X-Gm-Message-State: AOJu0Ywms4w5g0/nhi5SLnAPgWoVXzebWSk6fN0BqqHCp3nXhm4H7TJD
 wnDMAuzl5pPxvlFZxrXyTXDDU6zAjm78M4hga6L36Gbx7SvU8A0ZMeLxV9380m1PSG9a3V2FSFT
 ktJt9zamr181++rbF+2o14HZUWD6ohuc=
X-Gm-Gg: Acq92OHPFQu38mcu9WMO5gYiIybnVxDdfWKAVR1qNJl5pKaSnwKDpCC/gz2V6YJhXPS
 jpX+JR/q8WxFLYYsF8b8JPi9uMWtJ/0R9Pi5Wcr+6tuZ/dmqwy3k6EX17xCy1sTwodwBy02wrE4
 /zy18Z0/Pnj9PX+tFH4PQqy7QfGzWMnApVJJffShib0YPR2ODILmgsfoi0yymLrCtBirZKR6kEg
 2vhboaINa1JQr/8jyY57PkWiWwNaT0il999LWUWvfgRe+TNN9Og79u7PCdXm8viAsCnOwg+bfoG
 NUW3/hYxFnjEf6s/a0CVLqDUTAixmgIhYB/moDeXpeVbc+1v5A+BIOpID7wym9WSXAYSeA==
X-Received: by 2002:a05:7022:2204:b0:136:b71d:a90b with SMTP id
 a92af1059eb24-1398f5a71f5mr46360c88.0.1781635326150; Tue, 16 Jun 2026
 11:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260525113321.17953-1-timur.kristof@gmail.com>
In-Reply-To: <20260525113321.17953-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 14:41:54 -0400
X-Gm-Features: AVVi8Cf1j0Gn5PbD2qkGdAwpIH5qyNneDjxVyCP4jAnrTeZeUh3Ij-UzaBRfMj4
Message-ID: <CADnq5_NEqAxn18D51i85YvHwXpMZ3y3_VE1DxuRYAfW-_4vvgA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu/uvd: Fix UVD BO memory placement issues
 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>, 
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
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

Applied.  Thanks!

Alex

On Mon, May 25, 2026 at 7:39=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> UVD 4.x and older have two requirements for CS BOs:
> 1. All BOs must not cross 256M segments
> 2. MSG and FB BOs must be located in the same segment as the VCPU BO
>
> The amdgpu_uvd code attempts to solve those requirements,
> but unfortunately it has hit various limitations:
>
> * VCPU BO may be placed in a different segment
> * GTT manager doesn't respect placement requirements
> * GTT allocations may cross 256M
> * GTT->GTT moves are not implemented
>
> Let's solve these issues by fixing the GTT manager,
> making sure that GTT allocations are placed in 256M segments.
> Also fix forcing MSG and FB BOs to the UVD segment
> when the UVD segment isn't the first segment, which can be
> the case when resizable BAR is enabled.
>
> This series should be backported to 7.0 and 7.1 because
> technically this may have been a regression for some users
> caused by switching to amdgpu by default.
>
> Changes in v2:
>
> * Fix GTT->GTT moves instead of specifying a placement in
>   the amdgpu_ttm_alloc_gart() function.
> * Move MSG and FB BOs to the VCPU segments, leave all other
>   BOs in segment 0 like before.
>
> Timur Krist=C3=B3f (4):
>   drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
>   drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
>   drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
>   drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when it
>     isn't at 0 (v2)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 30 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 18 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     | 50 ++++++++++++++-------
>  3 files changed, 81 insertions(+), 17 deletions(-)
>
> --
> 2.54.0
>
