Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060BAC61DBE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 15:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9107210EACA;
	Tue, 25 Aug 2026 15:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f0NwN9lZ";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E7D310EACA
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 15:36:32 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cf49dc28ccso6620445ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 08:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787672192; cv=none;
 d=google.com; s=arc-20260327;
 b=D1yx1roa8iKipernK/uvjqnGys2POcCHOMXixw/umdQGKwe3N+hrhkE7GvlO99AnrI
 BCN16X/oNiqpXTwZnysmg44q2+FNNJlvSvjI3/DrezbgijvFlZflYTJs+hYXg2k14N0M
 +iNqKBrUcMI8dFIZt6sF1zEFeVw4AqsxRkEyderRV3hzPyx/O6otFX4Qk3MJuhMW//89
 AB++LODLBxiNjxrVy1rswRF4plM8e195shdLhrLYkdVb6J1R9oZgGga4LF+1jbseaT5l
 BCjOsY01dN+uZKMP4TdnFv9HdjbEMvpY5ISPw4Pf7TEyfUMVFOzdF2OPOL5OhmXNLiu/
 fpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/2J95Po7AEWPPv9EZLHrd6vFi/tH8XCddSmZD/Qvyq8=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=UgpFlAInVGm7tH3S1u5ybHiO0vEfdcUCaHH78z5/aDZICEniWFParZM+GeQb3nMiqk
 isd34XYeVDahgvyS1PreijvaH/vu64D/kK+QLBuvxVU6/11wPzC3QcLMwEYFPmScl4oi
 6s/YRRtc5FrjPC3IFsUhb6xUvqwsXwa1NIhanuHZ+R0WJSs7878JZolHrD5QXl6mZtb1
 81I3sFnA1jNy8oG2JntySony1lFTI4b5He4KNPxhN707Fo2OJcWxaE5xU97Y++VtNg9D
 H3/08G9EeK4c1Uxxg4fuzTWuQOsv3rPfr/vLZ4WcGwPXIAGQ5JLi3e8BfXYW/cN71xl5
 kb5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787672192; x=1788276992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/2J95Po7AEWPPv9EZLHrd6vFi/tH8XCddSmZD/Qvyq8=;
 b=f0NwN9lZknAZgCT7aiVTZviDYqqKtXxht3FQuRJBvaKnWTvqC2LWcpd4jN8jA/ryvu
 /PbtsoosdARSp82QJTeVdONqNlVVLcVQRoySy+iB81FHeva4x3wYGxRJM7YyWpQDAzRa
 t9FlcSZJwIelSM2g5FFZWrq68gCKYkSTTPiw6upGuOEdnRt4iopwCezXh9gCdkm2ZAK1
 +zRkvKbvE0HJwJSrPsTYJQIif9FnJnBSo/JH5GOPx8UOhRO40swHomKAdSO9Qhkjakjt
 dXdvlZVK98xQvTfaLG8ehfdSJpZ/Esrpu6ihI6RlIkIMdF7FvL7BeHoUY0MuvYsR8Nwr
 h/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672192; x=1788276992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/2J95Po7AEWPPv9EZLHrd6vFi/tH8XCddSmZD/Qvyq8=;
 b=UtM2EMHsvebEg2p4QD7UK1V3unEIRfyp43dy4VFYp8j1lcYJv+fM9Nm2Mey93ETnKH
 T68GQCMBu2YJ0+YIdBvSOlTcxDvP/jcjxZtpLkkUC9TjqzqUfWB0dFzbqhqk5yypQmo0
 erYiJcLI32dO3bOrPpA2LpkiljT5eLin9F3ACma0/FkXBgX/k/2507AYLFLhvvrqGp/r
 0E4qqIAbNh6T13DKTzKxzI3gVZ2zxUZYDUFZXgsAUldvOzLaCJPPRfrbn+09vA0qxOt7
 rII3IjcGIcFaIAPJPCDjVXwr3IJQ1vhzRXs2vUCXDc4WjGdQB4G5AgX7pCLMH+Zk3oDQ
 DWaA==
X-Gm-Message-State: AFuF++ltpT+YsrA7AlUvc9smuuAItYbSCpodM8Nk9lpHTHpFaV2QA0i6
 OHY8CdTR8B6s+8LUAFlvH3JYtD7AlBHqHM/kB++/GOYKreYg/wZzbumvuYgJUPB9elIP+p0OJ3t
 bURQetxZzWikEgbWUrXPjD7dGsG3N1D4=
X-Gm-Gg: AR+sD112M18vIVzq9iLpX+p9QLZKeT4Mpere3Ic0XqvY6ft0jUh6SmdK+I42UNhZxvs
 T5dEUxbiEVpF066EX7qgiSHGImBnyyft1xAgnQexuojss4aveLfq1oFb82wvoADfONlafZqMGKx
 sk70m9nCg74qisdmsAJkR9KWYIruna/bYLFkI+HJcty5/aRHYiMl2VN3LT8S3szfApE2umgx0m8
 ZzmFiErOZgWQZaKWTjz1DnZwSxXloMYXlmx3KCA3utlTQwXoIvxSEMUqiqQoAo6YHYo+9xq+DeY
 9lZJ/ZjgK0MocXGAlk7dV015UgTsfYbUb7/DPCp7K9KNxEkgafv8zC8y2gRZnqqD9OJiu1teS7G
 jppLzPKsDvU+Zx+emUNrTs4M5IY+SsG0=
X-Received: by 2002:a17:902:f709:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d64b047823mr333624385ad.2.1787672191437; Tue, 25 Aug 2026
 08:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Aug 2026 11:36:19 -0400
X-Gm-Features: AcwNN1WZJQ5dg7QXja89iEQIVYAsRvPx-iavAfBKqZMntcpX8mICHJApOX-gB6w
Message-ID: <CADnq5_MvKATHdjOzzgVLvdUG2j4=V+wddkuY=ApDOYEDmTzJHg@mail.gmail.com>
Subject: Re: [PATCH 00/30] Rework GPU TLB invalidation
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Aug 24, 2026 at 6:20=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO which w=
ould
> require disallowing GFXOFF.  KIQ and MES are management queues however an=
d if
> they hang, they cannot be recovered by a queue reset since they are the
> mechanisms which handle queue resets.  Since using KIQ or MES will exit G=
FXOFF
> anyway, explicitly disallow it on the MMIO path and use that. Next, switc=
h to
> using SDMA for TLB invalidations.  SDMA 4.4.x and newer have special pack=
ets
> specifically for this purpose.  If SDMA hangs while doing the invalidatio=
n for
> some reason, it's easier to reset the SDMA queue than KIQ or MES.  Finall=
y,
> most of the TLB invalidation code between GMC 9 through 12 was identical,=
 so
> move it to common GMC helpers and remove the IP specific code.  If the SM=
DA
> and MMIO pathes prove to be stable, the KIQ pathes can be removed in the =
future
> to further simplify things. SDMA 4.x could also be updated to support PAS=
ID
> invalidation via SDMA using either the new packet (SDMA 4.4.x) or via
> REG_WRITE/REG_WAIT packets (SDMA 4.0.x).

Some older gfxhubs and mmhubs will also need this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/a1f1823a8ecd80bee660244=
def5f20179926fe8c

Updated patches with that included here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_typ=
e=3Dheads

Alex


>
>
> Alex Deucher (30):
>   drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
>   drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
>   drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
>   drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
>   drm/amdgpu: add a gmc flag for using MMIO for TLB flush
>   drm/amdgpu/gmc9: use MMIO for TLB flushes
>   drm/amdgpu/gmc10: use MMIO for TLB flushes
>   drm/amdgpu/gmc11: use MMIO for TLB flushes
>   drm/amdgpu/gmc12: use MMIO for TLB flushes
>   drm/amdgpu: add a buffer funcs callback for TLB invalidation
>   drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
>   drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
>   drm/amdgpu/sdma6: add tlb invalidation buffer func callback
>   drm/amdgpu/sdma7: add tlb invalidation buffer func callback
>   drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
>   drm/amdgpu: add tlb invalidation method enum
>   drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart()
>   drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart()
>   drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
>   drm/amdgpu: add a gmc callback for the inv semaphore
>   drm/amdgpu/gmc: rework pasid flushing
>   drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
>   drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
>   drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
>   drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
>   drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
>   drm/amdgpu/gmc: add helpers for various tlb inv functions
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 114 +-----
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
>  16 files changed, 747 insertions(+), 995 deletions(-)
>
> --
> 2.55.0
>
