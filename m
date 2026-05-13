Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95D3CD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 17:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B9510EFA5;
	Wed, 13 May 2026 17:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqiL+mMQ";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F67010EFA5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 17:51:52 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso69950465e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778694711; x=1779299511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54Ie5r3QHxLslJ3vW+glMB3SFMCYIwRmWO8tC2E6l2w=;
 b=dqiL+mMQaaXDnyeKUxVzlApaajDh5xvy815wLQ8MgriP5CWggwrfmVbj/IcxhmIaAR
 VWvY4GR1ARRVz4Ye2MmMY5y4DElBZe45m3zImdKKD3XIoqqPn4Vni7QqS6WKePEEtMky
 ii3JEUyFggVg+ZGrxTA//ePvoQ969LZgyarx2RO0QtTmGlauyJwvrDMPGWagSTgUwZpv
 7bbg4A+Ri5vFonoQrUCqAxVwg5i7ky0zarZxuRVErcDdxWDNhW+u1BO1GYNMfG0ORmNd
 gKv0G2UsjbPR7G6j5Ohtc8xnahJAv98AZg1dxFLxxGQbA9YKkDkWsqN67zjdWEb6ahuG
 /sKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694711; x=1779299511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=54Ie5r3QHxLslJ3vW+glMB3SFMCYIwRmWO8tC2E6l2w=;
 b=ffBUl86bzdZ+tbKc9Lgd0W6AgAhMfLiN8si+UwkrVrI9P5kjxeLgR7jkqvc7Jo2FLi
 pG/V+ceELbg00KwwZJ3rGRrd3y/jfrIrx8l1mhPBJCVbOZa0SkjoppAaLoe9NRIO/cJ4
 nTS/onATjN0aMGBdmvyT8VJ87op8GXasRYCjEo/czrcaf/AiDdfOsZ+3SddfIsNAqlY/
 tQ7pdBSWYJtAjQkg4IYiAOJ3bPUTenZPXoIYYprQFJ5Jk7fg1hX9/ekMinuzFcxSlsaB
 Loyrwt1bUvRC6v7y7r0qjRPMFnSYYY0plXhROrSOvcwSODbaT0dQw/uCbyr4g+Jv64Ty
 jXCg==
X-Gm-Message-State: AOJu0YwyhO74LS8M8kNW0WJQAL702zJ0OdkcCtXrpJOhxyR6b1LYt8OI
 vUD7393CfBzba37jMOGFxtYVfio8mJqAXt2rEsGQ5/wDbYeFdZ8yUi7s
X-Gm-Gg: Acq92OFzdtPgivuMQJP9Jue28FuSfW2LrScdPiy3bCHJbqrmgtErCgDCzLPGXBUDuaB
 senmoYZftS8qz4szNzW6usWe09Lq8hQBTDGlI0QjaYCMpOhy5ad2V1RxdJlKS5JFNdTl1heTwRx
 y+mKEkhcagz+ALaJIN90sVKgF0f24qW4FSPNMh4L6qVT4ZJACYKzrJ7hH8A350VXejMwL325rl3
 F7KH/DAGzTHs8zQg+2T044P59zjo/Kab39041l0dqwcKOjfBPKlpjVzYwMHD7VHjO/+rTGQqEfk
 AMAJFwfb7pjfaQVCJhU+79qEpY1GHNwU8o1G1/W0HceCox2Ytk9TY3MFg+ajBKWSoilRHCeZ9s9
 HENjuDbge0B0RB6cmo2GriYA0iE8ebIpMdGSPX82Z6874iev+rVZ0MR/u3rvxqFifKuAsyZS0Sa
 2zvGcivyR95YGofsW9er58bIe8m8s5F88TwX7tDzYB6vPvc2PU3/llDBwIq6+7vhoEUgtGjg==
X-Received: by 2002:a05:600c:3109:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48fce9ef234mr55501655e9.13.1778694710785; 
 Wed, 13 May 2026 10:51:50 -0700 (PDT)
Received: from timur-hyperion.localnet (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39ff1sm622347f8f.10.2026.05.13.10.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:51:50 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 "Shetaia, Amir" <Amir.Shetaia@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 0/6] drm/amdgpu: Improve retry fault handling
Date: Wed, 13 May 2026 19:51:49 +0200
Message-ID: <10056920.eNJFYEL58v@timur-hyperion>
In-Reply-To: <PH8PR12MB688984F5D361A30D77FB046E87062@PH8PR12MB6889.namprd12.prod.outlook.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
 <2795714.vuYhMxLoTh@timur-hyperion>
 <PH8PR12MB688984F5D361A30D77FB046E87062@PH8PR12MB6889.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Amir,

Thanks for the quick response!
See my replies below.

On Wednesday, May 13, 2026 7:28:41=E2=80=AFPM Central European Summer Time =
Shetaia,=20
>=20
> Thanks for looping me in. Yes, we've been deep in NV4 (gfx1201) XNACK for
> the past few weeks and what you're describing on NV48 lines up closely wi=
th
> what we've seen
=20
> Quick highlights from my work:
>=20
> 1. IH retry CAM ACK doesn't actually free the slot when written via
> WDOORBELL on NV4 .. we have to use MMIO
> (WREG32_SOC15(OSSSYS, 0,
> regIH_RETRY_CAM_ACK, cam_index & 0x3ff)).

I agree. That's my conclusion as well and that's exactly what I'm doing in =
my=20
series for Navi 31, see the following patch:
"drm/amdgpu: Enable retry CAM on Navi 3 dGPUs"

> "fault never resolves" is exactly the symptom you'd see if the
> CAM never gets cleared.=20

Not exactly.

When the CAM never gets cleared, the first page fault is still resolved, bu=
t=20
subsequent page faults (that belong to the same CAM entry) will cause a han=
g=20
because the IRQ handler is not called (because the IRQ is filtered out).

That's not what I see on Navi 48. Instead what I see is that the IRQ is fir=
ed=20
repeatedly and amdgpu_vm_handle_fault() is called repeatedly, but just does=
n't=20
resolve the fault.

> 2. gfx12 needs its own retry-fault detection path ..
> amdgpu_gmc_handle_retry_fault on gfx9-era constants
> (AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY on src_data[1]) never matches on
> gfx12. We added a gfx12-native handler that reads from src_data[2] for NV=
4.

Interesting. Could you share what bits you checked on src_data[2]?

The gfx9-era constants worked for me on both Navi 31 and 48 for detecting=20
retry faults; however I needed to program some extra register fields in the=
=20
gfxhub code to actually enable retry fault interrupts.

>=20
> 3. TLB flush making it worse is a known trap .. on NV4 we see the same. T=
he
> flush adds more pressure on the same UTC L2
> already saturated by the retry
> storm; the GCR can't drain. We have UMR captures showing GCVM_L2 stuck bu=
sy
> on the user VMID with SDMA parked on a GCR ack.

I am pretty sure this is what I saw.
Do you have any clue about what can be done about this?

> 4. Up to ~512 MiB our patches resolve faults cleanly;

That's pretty impressive! Nice work!

> at 1 GiB we see random
> hangs that we've isolated to an SDMA ->
> GCR -> GC-cache deadlock when the
> BO-clear runs in ih_soft_work context.=20

Actually something I forgot to ask: on Navi 4x is it possible to use the IH=
1=20
ring? On my machine it seemed that the retry fault interrupts always come i=
n=20
on the IH0 ring even though the IH1 is enabled and configured upstream alre=
ady.

> Could you reply with your series? I tried searching the inbox but couldn't
> find it. Once I have it, I can diff against ours to see what overlaps and
> what's net-new on each side.
=20
You can view it on patchwork or the mailing list arcives:
https://patchwork.freedesktop.org/series/166522/
https://lists.freedesktop.org/archives/amd-gfx/2026-May/thread.html#144500

Or if that's more comfortable for you, here is my GitLab branch:
https://gitlab.freedesktop.org/Venemo/linux/-/commits/ven_retry_faults

Thanks & best regards,
Timur



