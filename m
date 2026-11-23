Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F6606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgUmxHWR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40AB10EF13;
	Mon, 23 Nov 2026 15:39:18 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D51B10EF13
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 15:39:12 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-71ac8129d95so149382eaf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 07:39:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448351; cv=none;
 d=google.com; s=arc-20260327;
 b=qJkIRscDOPRCVA8thOnEQm2bPkQMZmfj21vbbuYLnfiLGOjpftVZlz5AUAlkm6HFJO
 lY8aWHETYbm1z+qFmN1eUHeheDpV5L5Bh06b+qMOPaPf56D00CNhRyQdxOBoB1LC/Gff
 4Rxmgc/tZNrNNkybECCo4euvHg/YJDDBmSBvg3unw6Vp1J2ytpjHKKltz7spf/KhGT0Y
 RMUZbnr0FZiQKy8Hiz9GcLFXmhaKblUwDqOIdngFWN3U/olQT04t1KQ2/F06Da2Umuoa
 zUpt26af9GQCruscSYFS6Zy8daTaq0E5XXQye7axYHRnXJFjsm5Ldwk5wsnZ0KEXqol6
 tVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K6ido+StLJBGyGYwc4ztUpb4rgBVK55iYSgalHwRB+8=;
 fh=LfhjTNv397zgfavAwjtcPPMEYm8bvuUibtTbQVXQ47M=;
 b=VfE5fEn2bYEzyocgevAg0NdTdSyWr7bR7ydo6Yq1ikPeYGro57ggRdnFQkKi3P/giu
 AjpjDZQV8+drkgg68obzfgcF1S38UeIoQMY7eK59GWNHL1JrZyDFebQFG/DEBObPAqg3
 tPQ7VZ5h0f+J6WDEnCDJjv3AQ+fIDQ37dCRViLxz/LhEPAPBu/WkYFUPODbecIFGNR0+
 ybBeTk8KWj1YdJZ6zRlbtxXH1nW9yMRrjxdeyi3PjMumAtvClrVHixV/7xv8RQAWULWI
 n1w3gP1Mws2aAnP8dLI0gP/81XVOcQEIKx+TBRtyp2SMF4M30Xy44oWkXXVFSp01WBWp
 cFpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795448351; x=1796053151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K6ido+StLJBGyGYwc4ztUpb4rgBVK55iYSgalHwRB+8=;
 b=ZgUmxHWRdlhXgytUlucLDdOM0cc5dxJktVYEovzoaqPsikBKm7ma/LjJlv+bt3qi4I
 IPSWjbkW4XCI5x/KX85uUqGooXq33vVtGVIDnE3z10Xa/DF0eo5I1WeK6xIJPvkXlKwA
 ssB9oK4AsKGHXJ0Ymqnh3E3HlJVmK7G/9AZ1yOPWeMoJGg2DUHRYhGNcDSM6b1bC8c0h
 1Vb2CoGFz+WAruysCYhs/rUeH9EnIa6K52XYU4TSzVACuXbzBkj7YhphfYDjPBrLa6dY
 UF0dLc/EsA+hjtQuoPOH6f1qSpgAZMgWbltJRGybBtoEcChGgKQ8fsb0QrcP84lDlT1T
 Mfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448351; x=1796053151;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K6ido+StLJBGyGYwc4ztUpb4rgBVK55iYSgalHwRB+8=;
 b=wsi2UavQxs/WjPmvjwA/Y8DppnRe5+yGIxdt8/cH4I0POjPumQPGwPh280kysCuddA
 Uan/bcU+1sBRbBdnklJVDuxL2alexbOLtEwGu5wvmdrLa7CJWBx4JwnbaOj25Ci71W15
 5a4nIDr3XiCAnT/K1iKoZPwuV3ZQXWG8lfhlBRvt7sNZXYmvqsKUpCKCcQHDoI9JfRoj
 9mIv8L2c+sgFkOJkesNH2itLXSEjoAobrNZ0HKGKrvl3lj6Zdr87UryHvfaOPJVSMEd1
 CCmStj3cSeCRFxbpbbCoXPD5110sEo1pcUCUD6FvCJXKOgdN1GPNDmDHEBjBYC3V1kTM
 nGWQ==
X-Gm-Message-State: APuU4Z9Xy6NNb/1ytGxyLQXu4D1cj/2iUTL8GTj0X3awGOmyIJ2GDk++
 cAsd1wbmknh1v6KJgLnx7BVxsqxLo4Ijro3u5MGCajrlAw4yIBsWoABp7jd3eZD66GISggRK1Vn
 KQpo1HWkIcLq26RC8RnEhGR8xlp7T8JX1Yw==
X-Gm-Gg: AZFdTZcPuIUMY83uLhz5v0Wl1YLz9baQO7HiUsGko7CSEaVQO1wg6EiFCWIk8qpHKoc
 0mDGYvor66sXZg0nZDOkzhtLB524dSjjgIGt2NQXFvuhIwbKpefIX6RmaAMOZKVtx9H9Ys1zG9F
 SKR39ojvx0IPQMGt+HWH8CrG2Yvbql1uDa6w0iv7/fpHulPRsZlJhftjx4KURpcBVqF+r+9tVvc
 /znrNba/PNvCPRCMi2duTs3GfmfOdGq48SUYN1c469GMcNhlGTNhuiXuaHxL20H4A4agbC4ZG19
 JiJACGQnW5AXvcVUgLj6MNCLUKBEaLeOaH6TDfNCg789UXbYQABHFml1mVw5DI+U1doiUEPWyAH
 GJC6KpPx8oR2ojauxaJ8D57GgVPR/8Pjy9+MuaBFxNPVgWxWgvi+rUDxBl8OKKPtGiSKHhJ7agL
 qKRjoVZtfvH5Ot/ozyW3NJ+wRASUMWbOFoAZgwP5WoOXKU9rei2+fjgo4JJko=
X-Received: by 2002:a05:6820:3504:20b0:71a:fbe0:a6d4 with SMTP id
 006d021491bc7-71b39325f06mr10561944eaf.1.1795448351052; Mon, 23 Nov 2026
 07:39:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121064605.8721-1-caberliner@gmail.com>
In-Reply-To: <20261121064605.8721-1-caberliner@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Nov 2026 10:38:58 -0500
X-Gm-Features: Aa3M54rAbGcauq-yf7zE5smcqmpq_1cEIyBkQCclnHLUpFENhcsH9_j8yozNq6Q
Message-ID: <CADnq5_MjcV0Zg1a=ud0rTmdfmPueu9aokn_fewgU47104UJwJg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gfx9: deactivate all compute HQDs before
 MODE2 on APUs
To: Christoph Berliner <caberliner@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Jiqian.Chen@amd.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.

Thanks!

On Mon, Nov 23, 2026 at 3:30=E2=80=AFAM Christoph Berliner <caberliner@gmai=
l.com> wrote:
>
> MODE2 does not reset the CP HQD registers on gfx9 APUs. Commit
> c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2")
> deactivates the HQDs of the kernel compute queues before MODE2, but the
> HQDs owned by KFD stay active as well:
>
> - the HIQ is never destroyed during a GPU reset, because
>   kq_uninitialize() skips destroy_mqd() when it cannot take the reset
>   domain semaphore, which amdgpu_device_gpu_recover() holds for write
>   before calling amdgpu_amdkfd_pre_reset(), and kgd_gfx_v9_hqd_destroy()
>   bails out with -EIO while amdgpu_in_reset() anyway;
> - user queues mapped by the HWS stay active when the preceding unmap
>   failed (which is the usual reason for the reset).
>
> After MODE2 the MEC is unhalted with the stale HIQ. The reset reports
> success and graphics/KCQs work again, but the HWS no longer answers:
> the next KFD queue creation runs into
>
>   amdgpu: qcm fence wait loop timeout expired
>   amdgpu: The cp might be in an unrecoverable state due to an unsuccessfu=
l queues preemption
>   amdgpu: process pid ... DQM create queue type 0 failed. ret -62
>
> which triggers another reset, and KFD stays unusable until reboot.
>
> Deactivate every active HQD of all MECs before MODE2 instead of only
> the KCQs, except the KIQ, which gfx_v9_0_kiq_init_register()
> reprograms on resume. The KIQ is also identified by its MQD address,
> because at least on Renoir the HQD registers of MEC2 pipes 2/3 read back =
as
> those of pipes 0/1 and the KIQ would otherwise get a dequeue request
> through the alias. amdgpu_gfx_kiq_acquire() already avoids MEC2 pipes
> 2/3 for the KIQ, so this is likely not Renoir specific.
>
> While at it, fix the timeout check of the dequeue loop: it polled for
> adev->usec_timeout iterations but compared the counter against
> AMDGPU_MAX_USEC_TIMEOUT. Both are equal by default, but with
> amdgpu_emu_mode usec_timeout is 10x larger and the manual
> CP_HQD_ACTIVE=3D0 fallback was never reached.
>
> Tested on Ryzen 5 5600G (Cezanne, gfx90c, GC 9.3.0), MEC firmware
> 0x1e3, HWS enabled, amdgpu.noretry=3D1. An instrumented build used the
> old path for the first MODE2 and the new one afterwards (same boot):
> with the old path the HIQ was still ACTIVE with its old MQD/PQ after
> the reset and the next HIP program hung the GPU; with the new path
> only the KIQ was active at resume and HIP/rocBLAS tests passed. Loaded
> at boot, a requested reset deactivated 9 HQDs (8 KCQs + HIQ), skipped
> the KIQ seen through the pipe alias, and HIP/rocBLAS tests passed
> before and after the reset. Not tested on other gfx9 APUs.
>
> Fixes: c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after mo=
de2")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6177
> Assisted-by: Claude Code
> Signed-off-by: Christoph Berliner <caberliner@gmail.com>
> ---
>
> Notes:
>     v2:
>     - squash the two patches into one (Alex)
>     - deactivate the HQDs on all gfx9 APUs instead of only Renoir, replac=
ing
>       gfx_v9_0_deactivate_kcq_hqd() (Alex)
>     - v1: https://lore.kernel.org/amd-gfx/CADnq5_OsKujx3VgWDNDYF_ANocTs0a=
swFaC3uGwZhp7fE+SBCQ@mail.gmail.com/
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 98 +++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 9d87ebbc4..2d8ab438c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4076,39 +4076,79 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         return r;
>  }
>
> -static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
> +/* caller must hold srbm_mutex and have selected me/pipe/queue */
> +static bool gfx_v9_0_deactivate_hqd(struct amdgpu_device *adev,
> +                                   u32 me, u32 pipe, u32 queue)
>  {
> -       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -       for (int i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               u32 tmp;
> -               struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
> +       int j;
>
> -               mutex_lock(&adev->srbm_mutex);
> -               soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue=
, 0, 0);
> -               tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
> -               /* disable the queue if it's active */
> -               if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
> -                       int j;
> -
> -                       WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
> -                       for (j =3D 0; j < adev->usec_timeout; j++) {
> -                               tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTI=
VE);
> -                               if (!(tmp & CP_HQD_ACTIVE__ACTIVE_MASK))
> -                                       break;
> -                               udelay(1);
> -                       }
> -                       if (j =3D=3D AMDGPU_MAX_USEC_TIMEOUT) {
> -                               DRM_DEBUG("comp_%u_%u_%u dequeue request =
failed.\n",
> -                                                       ring->me, ring->p=
ipe, ring->queue);
> -                               /* Manual disable if dequeue request time=
s out */
> -                               WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
> +       /* disable the queue if it's active */
> +       if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIV=
E_MASK))
> +               return false;
> +
> +       WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
> +       for (j =3D 0; j < adev->usec_timeout; j++) {
> +               if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) &
> +                     CP_HQD_ACTIVE__ACTIVE_MASK))
> +                       break;
> +               udelay(1);
> +       }
> +       if (j =3D=3D adev->usec_timeout) {
> +               dev_dbg(adev->dev, "comp_%u_%u_%u dequeue request failed.=
\n",
> +                       me, pipe, queue);
> +               /* Manual disable if dequeue request times out */
> +               WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
> +       }
> +       WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
> +
> +       return true;
> +}
> +
> +/*
> + * MODE2 does not reset the CP HQD registers on gfx9 APUs. Besides the K=
CQs,
> + * the HQDs owned by KFD (HIQ and the user queues mapped by the HWS) als=
o stay
> + * active, because KFD cannot unmap/destroy them while the reset domain =
is
> + * locked. After MODE2 the MEC then resumes with stale HQDs and the HWS =
no
> + * longer answers (qcm fence timeout on the next KFD queue). Deactivate =
every
> + * active HQD of all MECs except the KIQ, which is reprogrammed on resum=
e.
> + */
> +static void gfx_v9_0_deactivate_all_hqd(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[0].ring;
> +       u64 kiq_mqd_addr =3D kiq_ring->mqd_gpu_addr & ~0x3ULL;
> +       u32 me, pipe, queue, n =3D 0;
> +       u64 mqd_addr;
> +
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +       mutex_lock(&adev->srbm_mutex);
> +       for (me =3D 1; me <=3D adev->gfx.mec.num_mec; me++) {
> +               for (pipe =3D 0; pipe < adev->gfx.mec.num_pipe_per_mec; p=
ipe++) {
> +                       for (queue =3D 0; queue < adev->gfx.mec.num_queue=
_per_pipe;
> +                            queue++) {
> +                               if (me =3D=3D kiq_ring->me && pipe =3D=3D=
 kiq_ring->pipe &&
> +                                   queue =3D=3D kiq_ring->queue)
> +                                       continue;
> +                               soc15_grbm_select(adev, me, pipe, queue, =
0, 0);
> +                               /*
> +                                * At least on Renoir the HQD registers o=
f MEC2
> +                                * pipes 2/3 read back as those of pipes =
0/1, so
> +                                * the KIQ shows up a second time. Skip i=
t by its
> +                                * MQD address instead of sending it a de=
queue.
> +                                */
> +                               mqd_addr =3D ((u64)RREG32_SOC15(GC, 0, mm=
CP_MQD_BASE_ADDR_HI) << 32) |
> +                                          RREG32_SOC15(GC, 0, mmCP_MQD_B=
ASE_ADDR);
> +                               if (mqd_addr =3D=3D kiq_mqd_addr)
> +                                       continue;
> +                               if (gfx_v9_0_deactivate_hqd(adev, me, pip=
e, queue))
> +                                       n++;
>                         }
> -                       WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
>                 }
> -               soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> -               mutex_unlock(&adev->srbm_mutex);
>         }
> +       soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
>         amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +
> +       dev_dbg(adev->dev, "deactivated %u active compute HQDs before MOD=
E2\n", n);
>  }
>
>  static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
> @@ -4136,8 +4176,8 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
>         }
>
>         if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
> -               amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_MO=
DE2)
> -               gfx_v9_0_deactivate_kcq_hqd(adev);
> +           amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_MODE2)
> +               gfx_v9_0_deactivate_all_hqd(adev);
>
>         /* Use deinitialize sequence from CAIL when unbinding device from=
 driver,
>          * otherwise KIQ is hanging when binding back
> --
> 2.56.1
>
