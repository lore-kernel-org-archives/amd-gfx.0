Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CB6C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 17:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E507510E3FF;
	Fri, 31 Jan 2025 17:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dL3FrdGP";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D5110E061
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 17:13:12 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ee94a2d8d0so454626a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 09:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738343592; x=1738948392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPyN8BDB5GQU4vPWJB0OBQnInKcdthn4d5rYQBDY+6A=;
 b=dL3FrdGPiiZXNkBAsAiIhn57ZMGVliDUVX4A2B/QlKs8e+NWSPqN2DEYWK7piR1RR8
 yzcNA77Mk7A73I0gKkXkBf0H55sAEBg80MvSej953RCzYyl+fttWHb1UW49lU0IGUM7D
 Jn52vi8+iykhm7XpF2wiQwGZgrRmUiDnSsotKBSrAz5Ipo6fMHVsE3IjgxxtDv30LKDn
 TNxerWOqf4Jx/PSqWk0pcXgv07jcakY35tH3GeSjEistMP5ICKEjy5rFedNmY/EVOk6d
 ly2bxtN+2pvWt9Ynqv5wRyi/G/mkeoFBVomIstNGLh4Wi4V4uhAdmUIvFIiLVN008TH7
 NXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738343592; x=1738948392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPyN8BDB5GQU4vPWJB0OBQnInKcdthn4d5rYQBDY+6A=;
 b=ASB3xO25iPQHfuXLtg6+VMoScz5zdthtL+sKd/ZKKt9FHT1N9XBPu4hXBbKUMIOcuW
 9L2+YaRBkpP3da2EdO2m0WwA17sPofyeMWNqgQ7ky1QbuqpYKYsUcfv1w79sRmti5hRw
 pRTxAJTaZf2JFAKu8yqhLR/qltL/t3mAsctlfXEr/GWsy7HcAXT7TADKECLjsaRfdUwA
 4U+FUQOpedkx4g/00bror2h7taaj9mS/rodVQAvvXDuCeTAVukqTxFBvFIdqxjUtDct8
 aabJjHWWc5G7+ArJAEh4XTnWYkmpitWVdcZQakvEiQSkxH4Znae3f1drXV/nNvHVflH0
 Hn7Q==
X-Gm-Message-State: AOJu0YxedquVYfBj9flzurjddFXUc+JjhU2hhaMaPlQ2Wpix09fisF9E
 OTezCPYL0Vtjaea9iKLMO57VV3yhE611NEwmzNl/7lXI0Zdfo0pzOO2XLtLy594Nbr0Y9MY1j/0
 f0B2tRF3MIHx8milzchYB6g1aXF2h9g==
X-Gm-Gg: ASbGncuDECB03I8vYThZpJUeDL7GA9WLJ851Wi6+HBVIMigWlBvd/TvP3CI75sVupHR
 tYLKoDS8C1DeyJYWUlvW89HyElspEXWRjzf3inLtYofR02pNSGcheuauteWgsK3Y5OWFbY3N+
X-Google-Smtp-Source: AGHT+IGSOJnCyXXCqBl0McF9IyXoYjy2P+Qf1SGqyP6XlJJ5l+ZVjaf6SLXUQvimwBk+7500TDyOenmo+/BGYm4JIgM=
X-Received: by 2002:a17:90b:4ec7:b0:2ea:c2d3:a079 with SMTP id
 98e67ed59e1d1-2f845d6419amr4790370a91.3.1738343591106; Fri, 31 Jan 2025
 09:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Jan 2025 12:12:57 -0500
X-Gm-Features: AWEUYZk6l9jeEydDginujmU-_vlmiAwPiLGHiKPykoIqCe2RJjo37gfK-V12s7A
Message-ID: <CADnq5_OTt63z4unFJAcKCwztJYAMYrPgvp1hOWVRZfhg3=1S+A@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Leo Liu <Leo.Liu@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>
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

On Fri, Jan 31, 2025 at 11:32=E2=80=AFAM Sathishkumar S
<sathishkumar.sundararaju@amd.com> wrote:
>
> Add ring reset function callback for JPEG4_0_3 to
> recover from job timeouts without a full gpu reset.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 ++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.c
> index be0b3b4c8690..62d8628dccc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 return r;
>
> -       /* TODO: Add queue reset mask when FW fully supports it */
> -       adev->jpeg.supported_reset =3D
> -               amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_=
dec[0]);
> +       adev->jpeg.supported_reset =3D AMDGPU_RESET_TYPE_PER_PIPE;
>         r =3D amdgpu_jpeg_sysfs_reset_mask_init(adev);
>         if (r)
>                 return r;
> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>                 return r;
>
>         amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +
>         r =3D amdgpu_jpeg_sw_fini(adev);
>
>         return r;
> @@ -1099,6 +1098,60 @@ static int jpeg_v4_0_3_process_interrupt(struct am=
dgpu_device *adev,
>         return 0;
>  }
>
> +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       struct amdgpu_ring *r;
> +       int ret, j;
> +
> +       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +               r =3D &adev->jpeg.inst[ring->me].ring_dec[j];
> +               r->sched.ready =3D false;

I think you want to call drm_sched_wqueue_stop(&r->sched); here
instead to stop further submissions to the other rings.  Note that
drm_sched_wqueue_stop() is already called from amdgpu_job_timedout()
for the queue that kicked this off.  You'll need to start them again
after the reset.


> +       }
> +       /* publish update */
> +       smp_rmb();
> +       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +               r =3D &adev->jpeg.inst[ring->me].ring_dec[j];
> +               if (r->pipe =3D=3D j)
> +                       continue;
> +               ret =3D SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ri=
ng->me),
> +                                               regUVD_JRBC0_UVD_JRBC_STA=
TUS,
> +                                               jpeg_v4_0_3_core_reg_offs=
et(j),
> +                                               UVD_JRBC0_UVD_JRBC_STATUS=
__RB_JOB_DONE_MASK,
> +                                               UVD_JRBC0_UVD_JRBC_STATUS=
__RB_JOB_DONE_MASK);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int=
 vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       struct amdgpu_ring *r;
> +       int ret, j;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return -EINVAL;
> +
> +       jpeg_v4_0_3_wait_for_idle_on_inst(ring);
> +       jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
> +       jpeg_v4_0_3_start_inst(ring->adev, ring->me);

Is JPEG pipelined or can each engine only process one packet from one
queue at a time?  If it's the latter, then when you reset the engine,
you'll need to save the current rptrs and wptrs from all of the queues
on that engine before you reset it so that you can restore those after
you reset and kick them off again where they left off.  That way we
don't lose any jobs running on other queues.  SDMA has similar
limitations for chips where we can only reset the entire engine.

Alex

> +       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +               r =3D &adev->jpeg.inst[ring->me].ring_dec[j];
> +               jpeg_v4_0_3_start_jrbc(r);
> +               ret =3D amdgpu_ring_test_helper(r);
> +               if (ret)
> +                       return ret;
> +               r->sched.ready =3D true;
> +       }
> +       /* publish update */
> +       smp_rmb();
> +       dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
> +       return 0;
> +}
> +
>  static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs =3D {
>         .name =3D "jpeg_v4_0_3",
>         .early_init =3D jpeg_v4_0_3_early_init,
> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_d=
ec_ring_vm_funcs =3D {
>         .emit_wreg =3D jpeg_v4_0_3_dec_ring_emit_wreg,
>         .emit_reg_wait =3D jpeg_v4_0_3_dec_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> +       .reset =3D jpeg_v4_0_3_ring_reset,
>  };
>
>  static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
