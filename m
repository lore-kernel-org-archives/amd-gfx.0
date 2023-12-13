Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C38DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 19:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA8510E846;
	Wed, 13 Dec 2023 19:07:36 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2553B10E838
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 19:07:35 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b844357f7cso5581492b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702494454; x=1703099254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWZvUQiMUj9wWQRkLxqz/Ab84kILDb5lncpxeH+FCXI=;
 b=YyVEaf6hMYO8ruKjoEeRo/pjLcWC8JnuSx8PBcwpkfmP8/+2tL+HusBSz7sbELbwg8
 qULwXS6mDHXXf9sLTjGlUYC+tmC7FQuP4UgOlH1AVHs8lKktFU+iAs/CQadkYmquFFO/
 5guereP7w+auW2gMCDCEOH9YwHtW8i5HIG+RPgdew65wf8J+epju8XRkpNOd8AasAKVG
 dMe0iYc9CuewEbO5g5XXePo8VTewS3OBUIdrAOmHuB0h2DTFtpQqY/sYwqXxXnhIYHEu
 6T9ZG4h3CwycUvmTv04R9ukk0or9dv3e3bhqD7BEyADNhm2nbYmKwfRTug1PR+iEQe0v
 AHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702494454; x=1703099254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWZvUQiMUj9wWQRkLxqz/Ab84kILDb5lncpxeH+FCXI=;
 b=Ln25XOXQXBO3onshkaZbIvj84CIDTlJglW+aHCKuhhT2XxLzCl6CWeO2Ve/ueN7Nni
 xEfjf8o6xkKbxxmtkIwT786jphGxNrb2l54bb56Y2g+4OpwJ8mFNSFunzE2KrMQM4OYM
 2B2x8vDeAbDqDWaHv3tN+p9UekY6suOmhOgfxYlqu3ZpYEfYZnZhGoCzxDSgrUGp0j3B
 FFBF9Bb3384wy3dFLEi9mLsjLe58p08lsU/9ck3RUKiiJt0U75fHa9wxkaNbzjYsmcXj
 ignukJ0L1c/AwZszfkSzvF/1fNdVjG1RUyUmVv3cKMqTYjZOXenqtl/gKWlZrCDKc1H1
 m3uw==
X-Gm-Message-State: AOJu0Yy9SPY1jU7CG74WSacZXimzu7r0Mv7qtAWWVQ8BoXaQ0T1gRPJJ
 36y4uQzTU3Oht/v5qHWl6iibS8MR8YXobgbn8zEn/zpph0Q=
X-Google-Smtp-Source: AGHT+IHpZLZL3KjAn2wQmcUbL4nb3I2FsR36CxWld7M8/bet+QxqEZDCp3ulpU1QcGaLsI+R1INA4uQ9NHFkU8mgZrI=
X-Received: by 2002:a05:6870:c0cd:b0:203:28c6:5f6a with SMTP id
 e13-20020a056870c0cd00b0020328c65f6amr1516216oad.24.1702494454249; Wed, 13
 Dec 2023 11:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20231213170454.5962-1-mario.limonciello@amd.com>
In-Reply-To: <20231213170454.5962-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Dec 2023 14:07:22 -0500
Message-ID: <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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
Cc: Tim Huang <Tim.Huang@amd.com>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 13, 2023 at 1:00=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
> causes the first MES packet after resume to fail. This packet is
> used to flush the TLB when GART is enabled.
>
> This issue is fixed in newer firmware, but as OEMs may not roll this
> out to the field, introduce a workaround that will retry the flush
> when detecting running on an older firmware and decrease relevant
> error messages to debug while workaround is in use.
>
> Cc: stable@vger.kernel.org # 6.1+
> Cc: Tim Huang <Tim.Huang@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>  4 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 9ddbf1494326..6ce3f6e6b6de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_devi=
ce *adev,
>         }
>
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> -       if (r)
> -               DRM_ERROR("failed to reg_write_reg_wait\n");
> +       if (r) {
> +               const char *msg =3D "failed to reg_write_reg_wait\n";
> +
> +               if (adev->mes.suspend_workaround)
> +                       DRM_DEBUG(msg);
> +               else
> +                       DRM_ERROR(msg);
> +       }
>
>  error:
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index a27b424ffe00..90f2bba3b12b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>
>         /* ip specific functions */
>         const struct amdgpu_mes_funcs   *funcs;
> +
> +       bool                            suspend_workaround;
>  };
>
>  struct amdgpu_mes_process {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 23d7b548d13f..e810c7bb3156 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct amdgpu_devic=
e *adev)
>                 false : true;
>
>         adev->mmhub.funcs->set_fault_enable_default(adev, value);
> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
> +
> +       do {
> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
> +               adev->mes.suspend_workaround =3D false;
> +       } while (adev->mes.suspend_workaround);

Shouldn't this be something like:

> +       do {
> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
> +               adev->mes.suspend_workaround =3D false;
> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
> +       } while (adev->mes.suspend_workaround);

If we actually need the flush.  Maybe a better approach would be to
check if we are in s0ix in

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb():
index 23d7b548d13f..bd6d9953a80e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
amdgpu_device *adev, uint32_t vmid,
         * Directly use kiq to do the vm invalidation instead
         */
        if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.read=
y) &&
-           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) ||
+           !adev->in_s0ix) {
                amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
                                1 << vmid, GET_INST(GC, 0));
                return;

@Christian Koenig is this logic correct?

        /* For SRIOV run time, driver shouldn't access the register
through MMIO
         * Directly use kiq to do the vm invalidation instead
         */
        if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.read=
y) &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
                amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
                                1 << vmid, GET_INST(GC, 0));
                return;
        }

We basically always use the MES with that logic.  If that is the case,
we should just drop the rest of that function.  Shouldn't we only use
KIQ or MES for SR-IOV?  gmc v10 has similar logic which also seems
wrong.

Alex


>
>         DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>                  (unsigned int)(adev->gmc.gart_size >> 20),
> @@ -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
>         int r;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 4):
> +       case IP_VERSION(13, 0, 11):
> +               /* avoid problems with first TLB flush after resume */
> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
> +                       adev->mes.suspend_workaround =3D adev->in_s0ix;
> +               break;
> +       default:
> +               break;
> +       }
> +
>         r =3D gmc_v11_0_hw_init(adev);
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 4dfec56e1b7f..84ab8c611e5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>                       timeout);
>         if (r < 1) {
> -               DRM_ERROR("MES failed to response msg=3D%d\n",
> -                         x_pkt->header.opcode);
> +               if (mes->suspend_workaround)
> +                       DRM_DEBUG("MES failed to response msg=3D%d\n",
> +                                 x_pkt->header.opcode);
> +               else
> +                       DRM_ERROR("MES failed to response msg=3D%d\n",
> +                                 x_pkt->header.opcode);
>
>                 while (halt_if_hws_hang)
>                         schedule();
> --
> 2.34.1
>
