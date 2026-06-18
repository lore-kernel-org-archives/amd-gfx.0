Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC8ECD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 17:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3B910EE32;
	Thu, 18 Jun 2026 17:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pmx7n2Pz";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB89010EE32
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 17:39:25 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1365eb2a773so74698c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 10:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781804365; cv=none;
 d=google.com; s=arc-20240605;
 b=fJKpJ2hYvUN5SLZC2EQLF3YIcr+R+8n1K6bMzf5I2i3TPRwpaMMQ4FOVUjUSuVQeAK
 PMG1Pg8TIvG8YwE5H6EIJB8vzsOfIYN7H2jfPMRbi4xlTqKDuHv6j2wPLa6AmHJzfYzD
 qrt+kBRqAuyqt91FGL85TeACBURDrSzXDTqf6ImnBmC2PL+1AL6u4SeuOwuiGDmA40XR
 1WVkeex07ZkwjkEta5SfrA/gTRUHv+4TDr2lpKV+43elGRmmuQSsGv9cPuRjErDlRlLd
 JYfQir1E9KgSxkUH4eWqtm4r5bNkd8hktBaqWAG/ftqtpnqLgGf9NWcOvkQb8+DPIp5Q
 DDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DRH+AshDMnI1IvDVnbVj1Hgdy9W83NBaI/yPLRF3oxY=;
 fh=RCSoOfsQ7/t4OGnYwSG9fVKqs1ibSTvhqaA38393n4A=;
 b=ekGbpbNYWhNFutVXyTbnnqpMsg8OFOQnzDUuGYvv3fCIn+ZiERsMyxvSthpTyOEsb8
 fJO97qRBTibf+t/SYgXS6anJfy0OOlt//BkHWKfcOjkTNSJTbCjLVBesreGrSGA+vhTg
 ZCE0Y2/w2PFm95gLGqb44IX16VpoSa3fmtl8XSmuzibBcfW474kkUnNqNN5XXfJrKlpt
 VrxnyWLe7GeyUvO01ibxR3CJOBW49C4yONlPO6RFFI31A/n3N5FasnEsZhlRPrsq1Lys
 ECnEZ5/AQDDnIEsw0G/87a48NMtSzOcLS2MGh+n4dCSbExvJBSAxUsjyYUbw0ySBBdKN
 BHvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781804365; x=1782409165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRH+AshDMnI1IvDVnbVj1Hgdy9W83NBaI/yPLRF3oxY=;
 b=Pmx7n2PzHQ73lsK6RQJw4ocD+wOZjffZyNgrqdaYTY/0g/yxACSfLY6kushz8AnhRr
 /ZU5mYpwO5Jb9deEPXUwB0CqrBa4snT7BG1/K8nosKuz9UEWFgTaaS0OVAxtQRxbZv+w
 AOIi7gA/ROX1GrciEyjQJFJ9fzTPxfCBsiQZgQNB0yyps7/ewVwzN1AJcIU+Dv1HH/tJ
 Ochblc71O61hNRJ0U6yEAoECWeBDVSc8Wtf3dk6hUYQX9aZrsr+znquZLa6NZSSzRl2i
 emmWr+6A+Z0Smj5wde/JQtY8GmaaLl6HRyX/aABBjNLUZfm7ei/yMttJJKIyiqJBLmGR
 u+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781804365; x=1782409165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DRH+AshDMnI1IvDVnbVj1Hgdy9W83NBaI/yPLRF3oxY=;
 b=PLF6c9DlqO5PEhOsayS4aLfi/4IDbWOXav2dBA/lWKPTdM5SKSR2WxxTEtXcW/Immy
 smH9C3tkjSDJ7J1dvyCPUVZlIUN5kir19h35jGzY7Omu8QrD8/FBa1018aES/8amjzy0
 XOcadQkbY3aBF3sykww1a09Q2a6q5yyRJAXpO9aUXYaD1fDSkw6qJbDET59MmLPbm6tK
 VQfbVzJo6EYluO4ZlDAMRRQinAgkAhwonnc45XlYhrSGuuWtA2E5XZtAYxPACWkQ+3Oa
 DRfZwgHogD6AxBU780Ji7KApQEMCJa41HENojPd8xYZMhvHUf5M9xh4vEhd9i3BWknHj
 VWNg==
X-Gm-Message-State: AOJu0Yz/T+V4Wv1gkftOHg6CSl6W9V1I0wgRpZcDu1CXV6xmLD6kTBJ/
 VcYqsyWgF6xYlOkQilwawjL/tX2wizbS21hZjd4PZym3G+smoXqEKIEeO6H1HOgzKslxHRJkios
 2CLL7GhTZBpcoApVrnf6+gRcgFxTRApFbTg==
X-Gm-Gg: AfdE7cmcRjKHc1J4s6sHrFMLrGXiE8FANCs+KbMeXAYw8VcWOnVcILSR51ohzfHDdqf
 RcH0v56fsLJcerXp2PMXRML/TnWwfPON4vrZESNwF4mAgY9gLcysGFOC/nlnIe45bH9o9nQIeJd
 eyeAgDxTEimXMddFpwrt+hz+caoFoWf9SqldbW+qzcXLZCyJRbUVPqJWn6Tt+nqXcHm/XJ/XayQ
 XVF0vrC6WvcXMFEwVrs9WOFBNmxDyc3bLwbN2WFpbGwbyO3u6spQosbSvj3NYUiZZjxGVHvQGfS
 T5LOD5gnAmmKzbhTSM4c/AmY1HhJGN425NfgeFLEmwhwkWakGsg2kCd48hY=
X-Received: by 2002:a05:7023:b89:b0:134:cf44:5fa9 with SMTP id
 a92af1059eb24-139a1f29addmr201690c88.0.1781804364880; Thu, 18 Jun 2026
 10:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jun 2026 13:39:11 -0400
X-Gm-Features: AVVi8CfJk8rUeKPp6SYQQi5hzjMvlYiT_FD4-urm6LxgD-PvlRf5qKKMI809QUk
Message-ID: <CADnq5_OCthNrpHENqrWLtpxRsFKkmknJrORpqkX3msvR=J9pVA@mail.gmail.com>
Subject: Re: [PATCH 00/17] drm/amdgpu: Rework IP block soft reset on GFX8
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>, 
 Martin Roukala <martin.roukala@mupuf.org>
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

On Wed, Jun 17, 2026 at 3:24=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> IP block soft reset is a way to reset just one IP block
> in a GPU without resetting the whole GPU or losing the
> contents of VRAM. Currently this is implemented for various
> IP blocks, but actually only used on Carrizo and Stoney
> as part of the ASIC reset code, and it fails.
>
> Let's rework that.
>
> Delete the defunct code from the ASIC reset code path.
> Also delete check_soft_reset() and pre/post_soft_reset()
> which were quite useless and redundant (see the commit
> messages for details).
>
> Add IP block soft reset as a GPU recovery method instead.
> This works similarly to ring reset, but will affect all
> rings that belong to the IP block. For example, a GFX
> IP block soft reset will affect all graphics and compute
> rings. It is called when a job is timed out. Attempt
> to minimize the effect on non-guilty jobs, then back
> up the contents of all affected rings, perform the HW
> specific soft reset, then restore the rings.
> For this, I am also including some patches from Alex
> which were written for pipe reset and solve some
> problems also for IP block soft reset.
>
> Finally, let's fix up the soft reset implementation
> on GFX8 to make sure it works on every GFX8 chip.
> Specifically, fix an issue with compute rings hanging
> after the reset, and fix an issue with increased power
> consumption after the reset, among others.
> With those issues gone, enable the new GPU recovery
> method on GFX8.
>
> Tested with the "hard_reset_cp_wait" test case from the
> Hang Test Suite created by Natalie Vock and Konstantin Seurer.
> This Vulkan testcase waits for an event that never occurs,
> effectively a WAIT_REG_MEM packet that intentionally hangs.
> IP block soft reset can resolve that hang and allow
> the rest of the system to move on and keep functioning
> without needing a full ASIC reset.
>
> Tested on the following chips:
>
> Polaris 10 (Radeon RX 570)
> Polaris 11 (Radeon RX 560)
> Polaris 12 (Radeon RX 550)
> Fiji (Radeon R9 Nano)
> Tonga (Radeon R9 380X)
> Carrizo (A8-9600)

Nice work.  Patches 1-6, 11-17 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

I'll pull these in today.

Thanks!

Alex

>
> Alex Deucher (4):
>   drm/amdgpu: don't reemit if there is nothing to reemit
>   drm/amdgpu: track guilty fence for queue reset
>   drm/amdgpu/fence: add helper to extract the guilty fence (v2)
>   drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit() handle NULL
>     fence
>
> Timur Krist=C3=B3f (13):
>   drm/amdgpu: Clarify name of soft recovery to avoid confusion
>   drm/amdgpu: Clean up defunct soft reset from ASIC reset code path
>   drm/amdgpu: Delete GMC 8 soft reset
>   drm/amdgpu: Delete soft reset code from legacy display driver
>   drm/amdgpu: Delete check_soft_reset() from amd_ip_funcs
>   drm/amdgpu: Delete pre/post_soft_reset() from amd_ip_funcs
>   drm/amdgpu: Add IP block soft reset as a GPU recovery method
>   drm/amdgpu/gfx8: Stop CP and RLC during reset
>   drm/amdgpu/gfx8: Return error when testing all rings
>   drm/amdgpu/gfx8: Support COND_EXEC on compute rings
>   drm/amdgpu/gfx8: Adjust EDC GPR workaround
>   drm/amdgpu/gfx8: Fixup IP block soft reset
>   drm/amdgpu/gfx8: Enable IP block soft reset as a GPU recovery method
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 179 +-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  54 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        | 154 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 171 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   8 +
>  drivers/gpu/drm/amd/amdgpu/cik.c              |   7 -
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  66 ------
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  57 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  57 -----
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  36 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 224 +++++-------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 125 ----------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |   3 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      |   3 -
>  drivers/gpu/drm/amd/amdgpu/nv.c               |   6 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  62 -----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  18 --
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  18 --
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  18 --
>  drivers/gpu/drm/amd/amdgpu/si.c               |   7 -
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |   9 -
>  drivers/gpu/drm/amd/amdgpu/soc21.c            |  12 -
>  drivers/gpu/drm/amd/amdgpu/soc24.c            |  11 -
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  10 -
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |  40 ----
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  45 ----
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |  69 ------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |   3 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c       |   3 -
>  drivers/gpu/drm/amd/amdgpu/vi.c               |  22 --
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 -
>  drivers/gpu/drm/amd/include/amd_shared.h      |   3 -
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 -
>  39 files changed, 487 insertions(+), 1058 deletions(-)
>
> --
> 2.54.0
>
