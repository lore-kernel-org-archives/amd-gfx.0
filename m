Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134B2C98338
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 21:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C8310E6C0;
	Sun, 27 Sep 2026 21:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pq7iMiNm";
	dkim-atps=neutral
Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com
 [74.125.230.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018B510E2E9
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 21:17:32 +0000 (UTC)
Received: by mail-qk2-f41.google.com with SMTP id
 af79cd13be357-93bfc58ed04so112400385a.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 14:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790543852; cv=none;
 d=google.com; s=arc-20260327;
 b=roxbK7vGMefHr/qPw76OPkWnZQKu4OFBuOANzEHUf4bXJS4ZZQrL5qYcJVo2VEeD19
 T8jx+r2cJGtPXThUextYhE49HYGI2tulVD0unQtsw2EW3bSug+p68xZCIFDOwMSOQrHb
 navY51GZcrORYei4brCfsj2I++4itHj+oToFMPXfQgILKOFP4nE73btzyOimQ+hiSfRA
 DpYlB9fmvaoJWvlyBE9tg2FsQhMv+Az5jAKZJ+8lDT7Cpd9seJUozlwQ6231G1axy4LH
 2hY7U3u/1H/LmViyWM303Ox6eS7xg7VH+wW14tKBacfY6F494efQ/jD51SuFEyeihSds
 wxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aMhTNMHCy/W9QF11i6so/5746wOL4VdliI9v6lvtqLo=;
 fh=Lgr2HNDMnv4KGZvynsqn3Ke9Xm7TJcQrHLocgGGD1IA=;
 b=YBCMZT4VdpR0y9qPINuCLIRqPKvsnGzeWdo4J8JhQ/SHD8EPfzoZetnrVBtMsCMcYE
 9OTSTUmzQHOkpCt00U4tuRC4TKeKueCjGotlNmcYqWsG6F71vOw/7qvkr5ig8NdqNV8Z
 DUfu04uWvIF3Irndt5zx5RPV0+pvF18TWKLJxJgjEPZlaaRy+jGGCNq9WtA999Km4kpw
 RH277Djm+oF42nye97oJXyKZX9BhltVT5tpdDE3E0xv7ONB/E5uUUf03gshBRNcb/ceC
 3c2lXzgBZZo3AhgqUMGUy3XH6AEjSD/brVzKKV6lxT1Ie44irRUi0kFl0NHLq9fULUPF
 sn5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790543852; x=1791148652; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aMhTNMHCy/W9QF11i6so/5746wOL4VdliI9v6lvtqLo=;
 b=pq7iMiNmmqDgvqQUw5qWWTF3P2G7YZfD6nuP5qmRvC+Mf+JLseJSFEaobitpspsPsk
 VkZsjlEh9u0a2yrgB4Hpqe/+NG1WRL6Ritj8Z9Ed9vYVn5MXt5661VlHnFF578U9DERA
 R8hcTFImfTgCExYfJTZO8I/pgDjEgkd86fjGN2nMYjoen3S6p38qu9f30k+Qt7Wkbu2r
 uSyJYEOXpt1vy+WH2JeCtva4Nczbm/U1K+pwVWYGvU/LAYLRSNl2wGTYm1BzuKnyR2z4
 3mA3SHWuiAyuPq2mSFgYXiDRjAzKwDqsPxzku5Uy5gQmWLIwfhYfeohdjevtTJWLRrBf
 mWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790543852; x=1791148652;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aMhTNMHCy/W9QF11i6so/5746wOL4VdliI9v6lvtqLo=;
 b=fw0eLeYkD5yXyyzEhO+CxJnBavsfrlMkb+39ipJRjwjyHa5kGTsRNCkos81mPa332H
 zj0Z0ccfXP6yge+R53UipD7lUEuerf8qIHBZXY4Kv0wEFHO6Drj6gnd+i0wzeseCq2uV
 g8UWpUgs0FLiyBWyD9KibE4OV6v4iRXq4lz1uGtl76RzD9ZqIiBAk8TODnpSWKx0KVAc
 NpJq4+JnsmttSMMR1aXl5ZOuNmOTb6GwOaIGnHvzTR+soYO/wbxKvQkm70k0037bwuOl
 sOysrmutincyLvRe8bjXgRYMUTQsqtdyNnluWDnQ1q0rNiqrOTduKeRfQjc3bDdPFbCM
 XbKQ==
X-Gm-Message-State: AFuF++kXjMV7Wo7pEdHN8+jKHrsk/8rieZ48WrutstN+9D8CmqLf1ZeG
 kcCCRCSwK7iDdfHfsX9NU8yzi+l54Ge6AS7BgO+0AmBiBli3AlcPxZFk/mvRSQhXJYxRBqWiwDz
 6fvpjBRs1wC5Lq+1/qcQhDA8TLr91FcM=
X-Gm-Gg: AYBFou0CoIohkg+9OVU2mGM0tGteSUT/VNk+gvzzEo6yRFd8M5+lIe5RYQOSgFwT+hR
 xEkE1OzE8h2s/TwFYDmR947t6Uaah1ZtM1AjderZ0LNF2ykyBPL7cjuqhWGUSkzrQxuB6ECKGih
 ZAUrR/vUN98hhFo3+Rn4Wvrsd0APbwQgvmjA5r5KhggGJCNgnDsJbrf1Xn1RhdFxEtffpk2pdVs
 8oIODAh5mt8ir+C4YWK6P2cH1m51ypln8oJD2/iHmaXdaVIpeblLglZ0mBsjOESw70VWoiq3cxc
 rTphkc6Tat5H1v8Yvz+FJM2SNhyj096gX58OcXFCaAbmK4vZUzewLBUjzlXI1fkUyWLhKzYDChM
 +GHHVrYL5TH5l3P1EJTD56A7iyuzKeLukuv7TvyLM
X-Received: by 2002:a05:620a:26a8:b0:93c:2670:2c28 with SMTP id
 af79cd13be357-93c43c3b302mr1594003485a.10.1790543851808; Sun, 27 Sep 2026
 14:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260821195224.809173-1-alexander.deucher@amd.com>
In-Reply-To: <20260821195224.809173-1-alexander.deucher@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 28 Sep 2026 07:17:20 +1000
X-Gm-Features: AclHuK9j_ZBnHU5bftvT0-bNJR4EDTfTOCkhRiQMtodvJ4ebzPkWhQxMxMAITPU
Message-ID: <CAPM=9tzfOiFBHKRVPjmde0gcFY+C=AQh-+-VvNTb5ZuAhvqG7A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add UALink infrastructure series 2
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Felix.Kuehling@amd.com
Content-Type: text/plain; charset="UTF-8"
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

> https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L1036
>
> Alex Deucher (1):
>   Documentation: add initial UALink Documentation
>
> Mukul Joshi (2):
>   drm/gem: Add callback for when handle count goes to 0
>   drm/amdgpu: Add ioctl infra for exporting/importing UALink handles
>
>  Documentation/gpu/amdgpu/index.rst         |  1 +
>  Documentation/gpu/amdgpu/ualink.rst        | 74 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  9 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 44 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  2 +
>  drivers/gpu/drm/drm_gem.c                  |  5 +-
>  include/drm/drm_gem.h                      | 11 ++++

This gem patch is kinda sneaking in here, I'd have preferred to have
more discussion on the list around this sort of addition to the gem
code.

Dave.
