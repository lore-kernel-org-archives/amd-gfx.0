Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DED7D33995
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 15:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F3110E234;
	Mon, 28 Oct 2024 15:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YrbI57Xd";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6347A10E234
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 15:15:11 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-71e617c3e9bso224243b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730128511; x=1730733311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjOEuh/LIUTD+bJAK0MnwuvBqbkO+GLJ7UEtJcsv52M=;
 b=YrbI57XdqPwfLrQA2LGKnn57o+w4r+C9ebhBzJPia2CWO290hYFQvdXKJ4Nu9L6wY4
 VHWwLCLqScadt/16yZB3GqKIRkwOPui5RCE+cpVhVo/clzaJys7IBKgQm2XY0KOBOMgq
 xeCV3Dsalna79cw7UZ4nRybalH1YOMfV2pskCJVOutivgrNHR4m0sdI+fXM/P6WyzzUq
 Wbe07pvNfBjEa0na/avnPgSobvElAJS/t9uci/RBTCMR4L/LrWgOlXQV7q7LhSW8Tk3u
 c1Y9DXD/cn81l1XwXHMJBGqVbp02nLUZoEx91ZVpQLl7iku7pf/IxFS2Coz4NKp3TAY9
 y30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128511; x=1730733311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjOEuh/LIUTD+bJAK0MnwuvBqbkO+GLJ7UEtJcsv52M=;
 b=QPBaBAYZ9G6qpo8JWZ0pJj190DpwPFyJ66/eDrmC+77h3lQpwrJ8MUSFHGGpag4GpP
 cLgOWU/dT1s/B0DCcKOahh0JOMq5RTirPdgduT71pu97WbRbHr/8h2ZVOxiq6ZFAkq+i
 oNnvbLP4bsGbPT/7Eyyp6DWZSbW+fHYD88Z6fam2N5D+Jd34muxOn8HnQYKkIWnlbEPS
 X33sVU3qBndvsXTPmqVwMCynmpXf2ZvFQRAViO4ZZkWGqTU+hCOEbH3HJdVgjIzy1Kx2
 13zQUEpai/3MBoCdM1g/HWl2V5z1d2aPyQa8gkK7EtQdjGku9d+DTIkRT5dB30GMom2g
 6hPA==
X-Gm-Message-State: AOJu0YxZzst2n20kiX7f3tLkOCWJTK5eG5IzBQxcX8p3I4k8d6a3s9L3
 /dKhFWDMvGXZCdmGeU+iFwI1zZUGm6QqCuVgPJgnFeb03fGcbIe5lQArWXwvWO4hyfT5RgTaHmC
 wDiW0DEgMn1C+g4xPp9Tzn/2zTxRYCw==
X-Google-Smtp-Source: AGHT+IEzTRy52sysgEvXdVeAynZkGyE4XnryDtxcHU4bvJWvNZY3TIBuq0D7EAgqSSR/xhZ5U4+zp8ogK38lM7b/LvM=
X-Received: by 2002:a05:6a00:22c7:b0:71e:4bda:71ec with SMTP id
 d2e1a72fcca58-72063028ed7mr5034132b3a.4.1730128510620; Mon, 28 Oct 2024
 08:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060219.1811607-1-jiadong.zhu@amd.com>
 <20241016060219.1811607-3-jiadong.zhu@amd.com>
In-Reply-To: <20241016060219.1811607-3-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 11:14:59 -0400
Message-ID: <CADnq5_N_SoSm+=jgvZ=iqD346vteRwZVNG19L2n2WOBW6M4gcQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/amdgpu/sdma4.4.2: implement ring reset
 callback for sdma4.4.2
To: jiadong.zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 lijo.lazar@amd.com
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Oct 16, 2024 at 2:28=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback via SMU interface.
>
> v2: Leverage inst_stop/start functions in reset sequence.
>     Use GET_INST for physical SDMA instance.
>     Disable apu for sdma reset.
> v3: Rephrase error prints.
> v4: Remove redundant prints. Remove setting PREEMPT registers as
>     soft reset handles it.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 90 +++++++++++++++++++-----
>  1 file changed, 72 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index c77889040760..29e2066a59ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_r=
ing *ring, uint32_t rb_cntl)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
> + * @restore: used to restore wptr when restart
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned =
int i)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned =
int i, bool restore)
>  {
>         struct amdgpu_ring *ring =3D &adev->sdma.instance[i].ring;
>         u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_de=
vice *adev, unsigned int i)
>         WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
>         WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
>
> -       ring->wptr =3D 0;
> +       if (!restore)
> +               ring->wptr =3D 0;
>
>         /* before programing wptr to a less value, need set minor_ptr_upd=
ate first */
>         WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>
>         /* Initialize the ring buffer's read and write pointers */
> -       WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> -       WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> -       WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> -       WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +       if (restore) {
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->w=
ptr << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring=
->wptr << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->w=
ptr << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring=
->wptr << 2));
> +       } else {
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +       }
>
>         doorbell =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>         doorbell_offset =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
> @@ -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_devi=
ce *adev, unsigned int i)
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned=
 int i)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned=
 int i, bool restore)
>  {
>         struct amdgpu_ring *ring =3D &adev->sdma.instance[i].page;
>         u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_d=
evice *adev, unsigned int i)
>         WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
>
>         /* Initialize the ring buffer's read and write pointers */
> -       WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> -       WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> -       WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> -       WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +       if (restore) {
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->w=
ptr << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring=
->wptr << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->w=
ptr << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring=
->wptr << 2));
> +       } else {
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +       }
>
>         /* set the wb address whether it's enabled or not */
>         WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
> @@ -792,7 +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_dev=
ice *adev, unsigned int i)
>         WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
>         WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
>
> -       ring->wptr =3D 0;
> +       if (!restore)
> +               ring->wptr =3D 0;
>
>         /* before programing wptr to a less value, need set minor_ptr_upd=
ate first */
>         WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
> @@ -916,7 +933,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amd=
gpu_device *adev,
>   * Returns 0 for success, error for failure.
>   */
>  static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
> -                                 uint32_t inst_mask)
> +                                 uint32_t inst_mask, bool restore)
>  {
>         struct amdgpu_ring *ring;
>         uint32_t tmp_mask;
> @@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_devic=
e *adev,
>                 sdma_v4_4_2_inst_enable(adev, false, inst_mask);
>         } else {
>                 /* bypass sdma microcode loading on Gopher */
> -               if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP &&
> +               if (!restore && adev->firmware.load_type !=3D AMDGPU_FW_L=
OAD_PSP &&
>                     adev->sdma.instance[0].fw) {
>                         r =3D sdma_v4_4_2_inst_load_microcode(adev, inst_=
mask);
>                         if (r)
> @@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_devic=
e *adev,
>                 uint32_t temp;
>
>                 WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -               sdma_v4_4_2_gfx_resume(adev, i);
> +               sdma_v4_4_2_gfx_resume(adev, i, restore);
>                 if (adev->sdma.has_page_queue)
> -                       sdma_v4_4_2_page_resume(adev, i);
> +                       sdma_v4_4_2_page_resume(adev, i, restore);
>
>                 /* set utc l1 enable flag always to 1 */
>                 temp =3D RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1477,7 +1494,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
>         if (!amdgpu_sriov_vf(adev))
>                 sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>
> -       r =3D sdma_v4_4_2_inst_start(adev, inst_mask);
> +       r =3D sdma_v4_4_2_inst_start(adev, inst_mask, false);
>
>         return r;
>  }
> @@ -1566,6 +1583,42 @@ static int sdma_v4_4_2_soft_reset(void *handle)
>         return 0;
>  }
>
> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned in=
t vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int i, r;
> +       u32 inst_mask;
> +
> +       if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
> +               return -EINVAL;
> +
> +       /* stop queue */
> +       inst_mask =3D 1 << ring->me;
> +       sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
> +       if (adev->sdma.has_page_queue)
> +               sdma_v4_4_2_inst_page_stop(adev, inst_mask);
> +
> +       r =3D amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me))=
;
> +       if (r)
> +               return r;
> +
> +       udelay(50);
> +
> +       for (i =3D 0; i < adev->usec_timeout; i++) {
> +               if (!REG_GET_FIELD(RREG32_SDMA(ring->me, regSDMA_F32_CNTL=
), SDMA_F32_CNTL, HALT))
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i =3D=3D adev->usec_timeout) {
> +               dev_err(adev->dev, "timed out waiting for SDMA%d unhalt a=
fter reset\n",
> +                       ring->me);
> +               return -ETIMEDOUT;
> +       }
> +
> +       return sdma_v4_4_2_inst_start(adev, inst_mask, true);
> +}
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>                                         struct amdgpu_irq_src *source,
>                                         unsigned type,
> @@ -1948,6 +2001,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_r=
ing_funcs =3D {
>         .emit_wreg =3D sdma_v4_4_2_ring_emit_wreg,
>         .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> +       .reset =3D sdma_v4_4_2_reset_queue,
>  };
>
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs =3D {
> @@ -2160,7 +2214,7 @@ static int sdma_v4_4_2_xcp_resume(void *handle, uin=
t32_t inst_mask)
>         if (!amdgpu_sriov_vf(adev))
>                 sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>
> -       r =3D sdma_v4_4_2_inst_start(adev, inst_mask);
> +       r =3D sdma_v4_4_2_inst_start(adev, inst_mask, false);
>
>         return r;
>  }
> --
> 2.25.1
>
