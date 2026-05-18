Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBCCCD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039C610E5DC;
	Mon, 18 May 2026 14:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RaPQdn8w";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6493010E889
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:23:31 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-13246a5110bso119150c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114211; cv=none;
 d=google.com; s=arc-20240605;
 b=cLBFhGc361GUO8xkvqPWEH/h48H9RuxIngSukkJhGnPG7uGZ+exaCeyNvssPSP4QPq
 fJ9iGfHT3fXXEI4T9aWG3vY58a62+pARXC6vyGhEZzbjWAWkJHLzGTFUaKP2/MY7Rsm+
 zu6yPdAbkbcrrlzpjXBFDp45oo94gtFpl2HuCUwkwi0lMyockSE9QjACIjfLGAsV5V66
 QJyoSx4Z+osEvNGMHFclgkbHC/fQH6oRZ/O5odV8qEFRTlaRFa6C+wI/ugwJjnVku1Wy
 yvRWiaih3ELILLdo67afW2lYliCAm+9qT/dXxVTsveYO3N2HKhDgVzsn5EPO6FYww7Ni
 f6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6W+8Ad/Vtfal8Be2r/swqERUNXyi4XnkwGbJNcr36fc=;
 fh=U/YQKX3V1t5FVDNeogPwy4yT5N/E4cBFORx0ly2TYiY=;
 b=BQKN3+Qa94+XdxorT3UOesWKQWu7N0vTmhQjsybnWqpKSaaJjgvij/2gp4lv1gGcXP
 TocJz7yFKch5xTLH8S74Fy98ZQoQ8mixCgoSKF6frh6mHJFKBGz/XzKJllokbglDny4D
 UKG9KOGvX9Bp+kbfy9R7EY5ePVJyKI8QI92HtTqNYYQyPPByUVbzeQKxD8r+9QKYm9Nf
 NtPIxjhmENeQuA3k/9VXZ2E/zlQpTz3chlHtOxGpWLo6BTg7egi5J6ZDqe0nraeGqKxR
 8mgBfAWzaAiYVNE7RojkKDvTiw620+FfXNx2HPCvCSUazkA9LFPd7vQaEB4gyfzgL3Oo
 4IEQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114211; x=1779719011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6W+8Ad/Vtfal8Be2r/swqERUNXyi4XnkwGbJNcr36fc=;
 b=RaPQdn8w0x4qz0OnbApQ5oZflFqQ1iTsW/XqrBjx1ubMdmoThpuQyBfhLg4keEP4rE
 FY0FKC1tL5zKGrwP/lMoKBBGCWJE0r8veXVMsMJ4MvuhNFNVJlr2eVitLWW5SjzzvkjF
 6oSSiWVAsQbnB+khclh25x4gHMipMO7SVjSg6WnUYnxUvFGyeaEQYeowPoKlfAJMrL4/
 M7Bbhn1bgD6IhmnRfrag/dwUET7TZ6+ACzqaHzA2l0NUMlqRxI+ClcrmoEsHcMjgyQTc
 K66LS5Q002C2ot2MdylHKfqtx5DuW6iZ9ZNn/dZPW+UGbYLUd92wZS62+LbMndVUbA6k
 WF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114211; x=1779719011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6W+8Ad/Vtfal8Be2r/swqERUNXyi4XnkwGbJNcr36fc=;
 b=oifn+xS2S8GL1ByRXmRbyA0iYKoWf9Pxiv/gw0g0DskiG61lCAbMOWrskvf9zVJSrJ
 0M2tzQijZOX79EZ4AyNw70DqNayZYpHbzV8LrcOT2UmA46brg/R58G+jutnN/Qv83s9c
 0pjSADLk7ZoAu6OdFyExYDQEVkKkKC2xbreEa9jDgnRsGp/1TpANAD4xeAKFSWf93cN1
 FUsRUjztqO73vFHL8w0gPFpMRlDPoYDwVx97VTNhZZKdaZbD//9cz7740h+ypBED0MBD
 5KAVE9cvNAgr5HieoljO6i/LeDQA2M0tzBFvoiPVd2EAnkq7tukAlG+G1kaOG6aR2bAN
 N4Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+p1T++7IozB6vSWhSLw7+uci48XXrAqFIrxpwS6DWJX57FxQJB6JI8QDldrBpeRJFen6TxSkpL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhZYpHzl3/QwrellXo0g+4LjE/gOKlPfDvUVrTOgvcDrZXS4gE
 C3IMWdFUQ8SaCg97Ms7gkvUNVckiyMUpdoxObggs3Y1Vc4HRfk+fnYPK7yJYxWh1DZpW3tR3mS0
 aPwdbTlI78PMt1x2bF8ulCaNAW6LTXdI=
X-Gm-Gg: Acq92OG8AVqbHuXc6YgcQVwtAteD7yo6HraofWgYzrzOcRUgzkZOAZP7rw3pWgSVIH1
 CSG3fodHYTp9RzOThL7IRjsr4dz/Jwu8bzvu2aRxNzLzRgDFvJPAYdQQ1rRMcrOfCOwdo+CVXx4
 T3HQ/i3GOufIuWL2MOrdV10XUNTYzNBPtkzFz9L3d7Dg6ZdTtvRsfPRiQfEcpaTNPa6AAwQLBDB
 k2UeW5qIzZXAft5SMB2bPRhUaU1wKbiIcXM1v7pCHsnM3KIhR7MqBJDESRX8XoXAvmjVJtjq99W
 k2QEZI1cSvdzoKT7b9ku/8QN1hGmncDRyqYgbngOdp+8IwjSEpVT9LmjtCmWkJupTwCr3w==
X-Received: by 2002:a05:7022:128c:b0:12c:900b:9dee with SMTP id
 a92af1059eb24-1350440ae3fmr2758383c88.1.1779114210581; Mon, 18 May 2026
 07:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260517131742.3435209-1-michael.bommarito@gmail.com>
In-Reply-To: <20260517131742.3435209-1-michael.bommarito@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:23:18 -0400
X-Gm-Features: AVHnY4IjvymyISKz9AQ3FMuidJRAKWnZZII8h8xQPSu6xFoDXnu8vnz8wJD7U3Y
Message-ID: <CADnq5_PP00biS-F6fG2Zp2Md7_ECS7A6zAdWz8YzcnuWir1Tdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix lock leak on ENOMEM in
 AMDGPU_GEM_OP_GET_MAPPING_INFO
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 David Francis <David.Francis@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Ziyi Guo <n7l8m4@u.northwestern.edu>
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

On Sun, May 17, 2026 at 9:24=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> The AMDGPU_GEM_OP_GET_MAPPING_INFO branch of amdgpu_gem_op_ioctl()
> holds three cleanup-tracked resources before calling kvcalloc():
> the drm_gem_object reference from drm_gem_object_lookup(), the
> drm_exec lock on the looked-up GEM via drm_exec_lock_obj(), and
> the drm_exec lock on the per-process VM root page directory via
> amdgpu_vm_lock_pd().  All three are released by the out_exec
> label that every other error path in this function jumps to.
> The kvcalloc() failure path returns -ENOMEM directly, skipping
> out_exec and leaking all three.
>
> The leaked per-process VM root PD dma_resv lock is the
> load-bearing leak: any subsequent operation on the same VM
> (further GEM ops, command-submission, eviction, TTM shrinker
> callbacks) blocks on the held lock.  DRM_IOCTL_AMDGPU_GEM_OP is
> DRM_AUTH | DRM_RENDER_ALLOW, so this is an unprivileged-local
> denial of service against the caller's GPU context, reachable
> by any process with /dev/dri/renderD* access.
>
> Route the failure through out_exec so drm_exec_fini() and
> drm_gem_object_put() run.
>
> Reproduced on stock 7.0.0-10, Ryzen 7 5700U / Radeon Vega
> (Lucienne): the failing ioctl returns -ENOMEM and a second
> GET_MAPPING_INFO on the same fd then blocks in
> drm_exec_lock_obj() on the leaked dma_resv.  SIGKILL on the
> caller does not reap the task; the fd-release path during
> process exit goes through amdgpu_gem_object_close() ->
> drm_exec_prepare_obj() on the same lock, leaving the task in D
> state until the box is rebooted.  The patched kernel was not
> rebuilt and re-tested on this hardware; the fix is mechanical.
> Tested on a single Lucienne / Vega box only.
>
> Ziyi Guo posted an independent INT_MAX-bound check for
> args->num_entries in the same branch [1]; the two patches are
> complementary and can land in either order.
>
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioct=
l")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260208000255.4073363-1-n7l8m4@u.north=
western.edu/ # [1]
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 9ef80bca4102..8224fb499fdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1091,8 +1091,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
>                  * be retried.
>                  */
>                 vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_ent=
ries), GFP_KERNEL);
> -               if (!vm_entries)
> -                       return -ENOMEM;
> +               if (!vm_entries) {
> +                       r =3D -ENOMEM;
> +                       goto out_exec;
> +               }
>
>                 amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
>                         if (num_mappings < args->num_entries) {
> --
> 2.53.0
>
