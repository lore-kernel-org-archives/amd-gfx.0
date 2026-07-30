Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FE3C5516D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B217610F189;
	Fri, 31 Jul 2026 06:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D3OGIGjx";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E7610EF1A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 13:52:26 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-6651abddd5bso257460d50.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 06:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785419545; cv=none;
 d=google.com; s=arc-20260327;
 b=coLZ2LQtyOUp7EJluGg8yY79QapAeWq6l8VRPn0M4iF9rW7gjXRt/zTnF5XfW7L8Mh
 /aZRnvYD1+VUVcDw9pO/A/7CUKAxrI77FB2AttcSWjVEZzUZxR1DeURyCshnhJ/HuoL1
 FLeFSPouGe8zcPjuXiMc0nTi+c6LxuaRBMAeq/ugBkjWmNlbkOGmVLKsBT4WkeY3B/Iu
 KzTmXM9Xu5xsMpDc+a0uaVjiFt61SgjzqhrZE00VVn+xsJ5HXPq2PgOFGIFpTisXx64a
 84OksApg5t7nMvA33BU53OEFyUkawcjCECRzyzjBB65IVcTHTY9KbvmqFJ1h/jbu6CMA
 33rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=k+QTaNRAeyAIgXPM6mVW8ocsbG6VlzRzT4YbG+xZn/8=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=bZJNYqfEVFtQTJGOKUUr/Dd0UEIS0Hs3QLneVKe7sNj4C+RPF5Dwj0oWLjsjJXY3+z
 xFPoAw7kDHJ66/adh1N0aRQw6CRf7p4EYwMCjtjxLBULNckCrbJ/OQVZuWXpOPbiCFpQ
 jv+1M5oI5z/ppz9VqQv/CL/ROmmlikQyYjOPLtCwcybREJkvOovpSn+Yi4RGr7xZrN4a
 gTEStuFY0xiUAxqeweUnOZ53Q5+uhQ7H7r6LhW39EHTHyH+RP3Cuov9scnjVop4KNgZX
 2014lj30bQawzbyoHZWK9N1CXcyqSvRY/e3KH7GaMxaO74KnAgk0CPyFQwdCgbbnbsVy
 OpAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785419545; x=1786024345; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k+QTaNRAeyAIgXPM6mVW8ocsbG6VlzRzT4YbG+xZn/8=;
 b=D3OGIGjx58eILccY9j+K8o7a6faMqA3u9QnhSIeegojsjGvjq3tJFt7qWAg8tYD9XL
 niL8UdkyrYl9CW9EjdPNl6gOPSaXqT+OS0Ei58BFFAiy66VZqdlCOD+SAaJHaJ7Nhciw
 A5RWglHmAknBDdhUxJI3chBHeSNc2mgTvNl7m4l4vIz3mFsTLza6sZopsIOCvvw3a58l
 A80OpnidGMTkTNUhOETzOVuGzgh0Run+vnpdMiJ9I0H7hCcFWF/nRPgZcsf+AP3GJzmE
 42vFImhMUN2RdkfFdya/f92Jbbq6ObhLtNrI4KGcmCE/4wlDG+KGhlYHipo3x+wzsRkc
 6Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419545; x=1786024345;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k+QTaNRAeyAIgXPM6mVW8ocsbG6VlzRzT4YbG+xZn/8=;
 b=kuDhrn+sLInx2cncBqCY6VDZMBFg3SSTLvn3n2i+FdthHA7WZmF2jQNUVNEyCzBY5l
 6Jb/ioggD2HbfTxzYLfz2CNwpejFmEVcLzJ1LuJubgCGGbjMJSIyTxhEM2KXhBZ2hRcl
 A+i9aDBPFyjw1MhvvGEJ8gwzXVXtgiof/XDcPdi53Ec0tLiMXVak8rVqONkGu64cRii8
 31N8DwD2lL/FRSXI3VCY+AvRehjfCP7Xsi+VO5J49OwxHtHylIZ09cZRjI63XcRuV9IT
 wfNbMNaGEu8Opl1rX+bM5AmML2BtHLtZiTWrNTamJiV1Mv5mNdh4eYDiC1GYzaibXdAK
 iQ2g==
X-Gm-Message-State: AOJu0YyIY7u9onBUxsUwbuot7+mIXhX2CbTZEaVIDbnsz0ECWP8YH3YE
 oNQKQ3WtJyEDtBdDWJHWp/vXvcdlBMFAjSAho8DlQLTm9asmv92vd03EeWseLznkZ0XF1UmGt/K
 bSvPvG0lF2Km7kbOAirAD0uABA9CS4LMuFJdv
X-Gm-Gg: AR+sD13GSLHy1/95pBOx3oR/Wuw7soGhNjSgGpawkYYJuSdvLfiTVAZxCowTCDpkWpo
 HSytySmHx6efjQXbzyUOGWf7yDpHMODz2QbzTvCRU+reJkGraLrGbTDOOtcibd6W0iRQej4M9Ki
 7bBozxg/uIJWmnmdZEwuwZcHOtiWTpXJXbKrqoCsbgtzpx+hUymNZnfCSU1dB9eHKAIk1EZcKL+
 rtNAqh09sbGbXGfL+kAP/mUausUcZuvZvNoPbgmkXI+S2s6J+1hhkwr6Uf91SDR5266Hv/nIdBe
 tOUIL90r4JDSg2bdaFyYHFb5ru40xg4AHcaUGYEy1wwNMg8kKIG2aJM1Z6Ha+IQK7kp8AfKDEq+
 8jsVZj7QxHrsX
X-Received: by 2002:a05:690e:144d:b0:668:430b:a928 with SMTP id
 956f58d0204a3-6693a0f5afdmr471039d50.0.1785419545192; Thu, 30 Jul 2026
 06:52:25 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Lima <danieldelimafrancisco5504@gmail.com>
Date: Thu, 30 Jul 2026 10:52:13 -0300
X-Gm-Features: AUfX_mwU_Ibu24frHy1tsCUi-9Ss9OcIV36IXmlPEPzmbiUoKO9hh1W9qOhs3MQ
Message-ID: <CALnZc=SfhdmF_YzAcG5A7=NfgTVUB6Mc2FFY-jkZ2sXWjPPj+g@mail.gmail.com>
Subject: AMD BC-250 (Cyan Skillfish, gfx1013): can the VCN 2.0.3 power domain
 be brought up?
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:58:24 +0000
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

Subject: AMD BC-250 (Cyan Skillfish, gfx1013): can the VCN 2.0.3 power
domain be brought up?

Hi,

I'm working with an AMD BC-250 (ASRock mining blade, PCI 1002:13FE, Cyan
Skillfish / gfx1013, GC 10.1.3) on Fedora 44 with the stock 6.19.10 kernel.
Hardware video decode is unavailable, and I would like to ask whether that is a
firmware limitation or just an untested configuration.

The short version: in amdgpu_discovery_set_mm_ip_blocks(), UVD_HWIP
IP_VERSION(2, 0, 3) has an explicitly empty case, so neither vcn_v2_0_ip_block
nor jpeg_v2_0_ip_block is ever registered. Is that intentional because the
SMU 11.8 PMFW has no VCN power management, or is it simply that this ASIC was
never validated for video?

What I measured, in case it is useful:

- The IP discovery table does report the block.
  /sys/class/drm/card1/device/ip_discovery/die/0/12/0/ gives
  major.minor.rev = 2.0.3, harvest = 0x0, base_addr = 0x00007800. The
  HARVEST_INFO table in the discovery binary is empty.

- The whole UVD register aperture is unreadable. Through debugfs amdgpu_regs,
  both segments return 0xFFFFFFFF: mmCC_UVD_HARVESTING, mmUVD_POWER_STATUS,
  mmUVD_PGFSM_CONFIG, mmUVD_PGFSM_STATUS, mmUVD_STATUS, and the JPEG registers
  in the 0x7800 segment. mmGRBM_STATUS through the same read path returns
  0x00003028, so the access method itself is fine.

- Writing the value that vcn_v2_0_disable_static_power_gating() would write
  with pg_flags == 0 (0x00055555 to mmUVD_PGFSM_CONFIG) is accepted but has no
  effect; PGFSM_STATUS stays 0xFFFFFFFF. The PGFSM itself therefore appears to
  sit inside the unpowered domain.

- nv_common_early_init() sets cg_flags = 0 and pg_flags = 0 for GC 10.1.3, and
  cyan_skillfish_ppt_funcs implements no .dpm_set_vcn_enable, so nothing ever
  requests a VCN power-up. smu_v11_8_ppsmc.h has no VCN-related message, and
  smu_v11_8_pmfw.h has no VCN feature bit; the clock level fields cover
  LCLK / MP0CLK / FCLK / SOCCLK / DCEFCLK only.

- From the platform firmware (AGESA!V9 RBNBDK-BL5 46.1.2.220426): the PMFW is
  PSP directory entry type 0x08 / 0x12, version 0.58.7.1, and it contains the
  string "AMD BC-250", so it looks board-specific. I could not find any VCN,
  UVD or JPEG reference anywhere in the UEFI image.

My questions:

1. Is IP_VERSION(2, 0, 3) deliberately unhandled because the PMFW on this SOC
   cannot power up the VCN domain?

2. If a power-up path does exist -- an SMU message, or something the ABL /
   AGESA is expected to do -- could you point at it? I am happy to test
   patches.

3. Could the block be disabled in a way the harvest table would not reflect?

I am not asking for support on an unsupported product. A factual answer either
way would help: the community documentation for this board currently attributes
the missing decode to a signed-firmware restriction, which does not match what
I see -- the VCN 2.x ucode is present in linux-firmware and this ASIC uses
AMDGPU_FW_LOAD_DIRECT -- and I would rather correct that than let people keep
chasing it.

Thanks for any pointer,
Daniel
