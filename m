Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C74C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 17:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D9210E0E5;
	Mon, 24 Jul 2023 17:13:16 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B32110E0E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 17:13:14 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-565db4666d7so2861035eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690218793; x=1690823593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+a7vCZ5y+bb6yB4AcNUSfSsGfNaO64rPfQp5O5maidw=;
 b=eAf3IqZrSmnX1VUhzfc3uaOQEjdxg7VNON6Xt6/+ELvdd7fG2/P0UX7jfRfSLov9oO
 nZo9mKkSpVimki9XIsIExX60nu4PahunBnOcL/05Cp7PVr1h+A+EZlU5p9/pFAAyEy35
 v7BW7SyTiBZeoEvFzT6pLHS8DEIi2sTnq7i2hwLeA+pSJN4sq9z1cJ4pf00DU4hjTyIJ
 /KOxsuiyaU3x5Yy/uc6R1YaTGaKdeyjJdphpMWw6ZUQT1Fr3V8acZBrIte23NcFsY+yt
 is00ApZonq1GSnUlpddXnvXRwNanbhH5Pql0TqQfeSwzyDNaMiKpv0ioAubkUAwgHIF1
 xO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690218793; x=1690823593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+a7vCZ5y+bb6yB4AcNUSfSsGfNaO64rPfQp5O5maidw=;
 b=AgySbnBLP0HNj7g0g69wLsadHvpg9INHwDqWwNa/Z8+gzqcQgfzXZUPUgNN/iXfiIV
 ijSX3W/C/A5d7MS7f3GrImRDhsUK5NoY5djqD++EvDg3UmjcWTh1pi8k/qY+X4bT5Yf5
 j1TAnN9qhvRZLGRvukpMkcgIYuQscbFhL9rqh8N52e7QOr/IyudH5voxnsBq2YgneyP3
 xnMSHWf1cBNj4zPKgLn3sbjFq9F1LBBq6Sd6Yx9H4MfwBCXNftp2YyTqYXgy8hoN6tZ1
 BATYBFN9WXcuTopX3U6IuW3sEYFjsbihWvhvHQAiNyGvy/QYXvUmut8lxiCyGOynYkCT
 eodQ==
X-Gm-Message-State: ABy/qLbgqgmQboIWYmr1hTxY8kiIeKOx0tNA3nQUftsdsbeO3ZwdL0xN
 Eu7xSjOOQlU1eRndP2+ejJ876WZBwjyytLvLV5k=
X-Google-Smtp-Source: APBJJlFHpueaNg/wn5o+jyKL4QiqnG2CYIRPt+P8iPyoB/+WIbiSkEcGbkneBl50RqlevEzdAkYrlylAcFKo+8/FOP8=
X-Received: by 2002:a4a:7544:0:b0:563:625b:e02e with SMTP id
 g4-20020a4a7544000000b00563625be02emr6627883oof.9.1690218793515; Mon, 24 Jul
 2023 10:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230724155418.2179209-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230724155418.2179209-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jul 2023 13:13:02 -0400
Message-ID: <CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove volatile from 'wb' & from 'ptr' in
 amdgpu.h
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 24, 2023 at 11:54=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following from checkpatch.pl:
>
> WARNING: Use of volatile is usually wrong: see Documentation/process/vola=
tile-considered-harmful.rst
> +       volatile uint32_t       *wb;
>
> WARNING: Use of volatile is usually wrong: see Documentation/process/vola=
tile-considered-harmful.rst
> +       volatile uint32_t               *ptr;
>
> 'wb' field from 'amdgpu_wb' struct & 'ptr' field from
> 'amdgpu_mem_scratch', is not used to access h/w directly, neither they
> are shared variables, so volatile is not necessary

How did you come to that determination?  Both are GPU accessible
memory allocations.  The writeback (wb) allocation happens to be in
GTT so it's system memory, but the the mem_scratch allocation can be
in device memory.

Alex

>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a046160b6a0e..06f79a84ff4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -502,7 +502,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct am=
dgpu_fpriv **fpriv);
>
>  struct amdgpu_wb {
>         struct amdgpu_bo        *wb_obj;
> -       volatile uint32_t       *wb;
> +       u32                     *wb;
>         uint64_t                gpu_addr;
>         u32                     num_wb; /* Number of wb slots actually re=
served for amdgpu. */
>         unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER=
_LONG)];
> @@ -621,7 +621,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *de=
v, void *data,
>  /* VRAM scratch page for HDP bug, default vram page */
>  struct amdgpu_mem_scratch {
>         struct amdgpu_bo                *robj;
> -       volatile uint32_t               *ptr;
> +       u32                             *ptr;
>         u64                             gpu_addr;
>  };
>
> --
> 2.25.1
>
