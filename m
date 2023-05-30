Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB9BC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 15:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE0910E3A8;
	Tue, 30 May 2023 15:27:36 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D484A10E3A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 15:27:33 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-19fa4346498so184329fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685460452; x=1688052452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+poVcQMEHLIJTBBc3VFp1k+5jFG7qC2k2x7v7mTjJA=;
 b=I6WJ3fBk3vNBJhU4KSP968mxs/XXkezSElQTdcklfgQ/+NA3dRsv6X93Pcw75SAj/v
 8Gl0grjeLHbGV3nbQ+Y+7vqH6cHoVh4OLxUrmopaxBR73j+CQKswmd0ax5glmBa3rGVF
 YUZp3sB8NIWxSLCs9zvovbbQ+cgWlplhbciERyeloKmSCQS4rPUfb5Phl44XHhSruwQG
 Z8TsWelFVXUL9hAfGDacckPwIZ/WdmAowB8eBU1QS9OreIPtWn+5xvVTaaKjtJ/zI1tV
 t78utcvNCBWuyjYhoADtzXjhGh7hVvsU2lDVce0mDsUs8VX07I+Xo71AeOP0MLY8DdU3
 wx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460452; x=1688052452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+poVcQMEHLIJTBBc3VFp1k+5jFG7qC2k2x7v7mTjJA=;
 b=CgaAf8inMuIXFD4Rn7e+72E6W9B/e1+ETRhB9q5u1sLDjDWsXMVk9do/K1Rif7jfxL
 Frm9L9ncrjvmCqiHg8tJwy/aQHwL3NM4ZbjgK0EUUu1BO5vd7uqI83O2hkaKwgDown0E
 E90uPy9U7+hpA/r4FduxczQpz8cwCNbR3lt6ER/2DnzFOdUNtMKzIPTTzK7Pkwp1wg2l
 x4hB1Tipovv7XoM2owmIwkzmZLxwpdk/3kv3MnQAGtvr0GWbzUiHrT2KYK49xW37aLQA
 y342gwDPQ/UmHFYIbbUjGyTJ/20SIDP14gm02szodGFSK9jmSjmCl5Ts1TxtYV/dWMm8
 9FaQ==
X-Gm-Message-State: AC+VfDyBzxJBLBqPLG4HE7kuJbc8wsq7k163BdZywrWu1XY0b8197Ojh
 6HV+RBVM5FgyT0GInC3mEw83LDV+hgHcxcfETbyByDMz
X-Google-Smtp-Source: ACHHUZ5x76j6tfXyyVlS82EETZo1GeZuK+Tw5hv+2byWC/FEFooGct9VyfyYyMmTjRX8dE0bVeGin2bfICjiUa1W+j0=
X-Received: by 2002:a05:6870:1942:b0:18e:7e69:a6d4 with SMTP id
 m2-20020a056870194200b0018e7e69a6d4mr1166892oak.43.1685460451781; Tue, 30 May
 2023 08:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230529141011.1896710-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230529141011.1896710-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 May 2023 11:27:20 -0400
Message-ID: <CADnq5_PT=5_tvKVpaOEo1p-n9dyKBmsf=R0BZ+sSB3adHCx4WQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix missing parameter desc for 'xcc_id' in
 gfx_v7_0.c & amdgpu_rlc.c
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

On Mon, May 29, 2023 at 10:10=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix these warnings by adding 'xcc_id' arguments.
>
> gcc with W=3D1
> drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:1557: warning: Function parameter o=
r member 'xcc_id' not described in 'gfx_v7_0_select_se_sh'
> drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c:38: warning: Function parameter o=
r member 'xcc_id' not described in 'amdgpu_gfx_rlc_enter_safe_mode'
> drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c:62: warning: Function parameter o=
r member 'xcc_id' not described in 'amdgpu_gfx_rlc_exit_safe_mode'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_rlc.c
> index d3bed9a3e61f..35e0ae9acadc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> @@ -31,6 +31,7 @@
>   * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
>   *
>   * @adev: amdgpu_device pointer
> + * @xcc_id: xcc accelerated compute core id
>   *
>   * Set RLC enter into safe mode if RLC is enabled and haven't in safe mo=
de.
>   */
> @@ -55,6 +56,7 @@ void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_devic=
e *adev, int xcc_id)
>   * amdgpu_gfx_rlc_exit_safe_mode - Set RLC out of safe mode
>   *
>   * @adev: amdgpu_device pointer
> + * @xcc_id: xcc accelerated compute core id
>   *
>   * Set RLC exit safe mode if RLC is enabled and have entered into safe m=
ode.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 0f0c12bbe228..7b3f13221c0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -1548,7 +1548,7 @@ static void gfx_v7_0_tiling_mode_table_init(struct =
amdgpu_device *adev)
>   * @sh_num: sh block to address
>   * @instance: Certain registers are instanced per SE or SH.
>   *            0xffffffff means broadcast to all SEs or SHs (CIK).
> - *
> + * @xcc_id: xcc accelerated compute core id
>   * Select which SE, SH combinations to address.
>   */
>  static void gfx_v7_0_select_se_sh(struct amdgpu_device *adev,
> --
> 2.25.1
>
