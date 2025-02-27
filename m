Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D192C19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 14:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA1010EAF7;
	Thu, 27 Feb 2025 14:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUK4Lykn";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EB510EAF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 14:37:55 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22348051cf7so2260455ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740667075; x=1741271875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipfGiv8DJS6Nh0G3rH4u4Gcom1HU5AKMdYfIGbsmjTE=;
 b=XUK4LyknXwrTc1ws6fR2uZRQyTSd30qBFIMf1QDaXbvAvnhiBR83HcWlSYrIuoll/i
 UxTEdPQzOIVnNf32R5y+jQNaNo62h7vLGIaS8Cn8tfmZtNpYWda71SpVIu1B1hSDzauh
 TS273SN9VliIwM9Z/xD5PTnjuqa3oDyoi3fx8WLCzHmp9OcOBD/aBge3foZlkkodKSPO
 rri2SiY6w8W2rrOP0EHIrUkmdw/ci10/mIXI+enDN1FhR1N44rFjAGCQ9/UenerUXOAq
 js2jqgk7P/WaY+c6BRyfitYYOaL61fhjZcNJMTl/+Vrn2kJQtVoKYX14X26+/OcG44Vu
 AtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740667075; x=1741271875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipfGiv8DJS6Nh0G3rH4u4Gcom1HU5AKMdYfIGbsmjTE=;
 b=ZX8n4BlgDhRQIVO8olSg09o+eto1K+8jg2aimgetgCIZdPFRqbSIO6kvGYYnOLOlPU
 ag0Te1h+A3p4N551+T9CvPNyjoBrCuBy8QmF5IeQGbYiza37MuIEmITbvP8rSEDgb37J
 2LHBjCswjafGFVak8/JDrOzzgCthIJO6ltTOnHeceOvj/F3sAQqlABZTf7qU29tKFyRb
 i+uhusBUnpUPXM6orsdIYK0n1v6hRFXZ3qqx6AaLZGW972sFM+HyoYSZil68qS5zP2lb
 k9Mp9Ns6cBq41epuPG+quzuD1W9/Lgoyf+t992VIP6MkBhVe0fcTR7A1NUVIBW6jUoMd
 lTSw==
X-Gm-Message-State: AOJu0YyCS/kjnjAs/9QprytKn4liYz1F8Wg5X0S4G8tX+sbp2Ii+qLRY
 5wC83hn41l19rqcAke/9doLSgMwWL/WRcCiyKUFrKAK4N0PnPh6yvcrps+mdpjLO4oZySV+kkan
 XcLlGlXV2eSVmpbPf/eP3ZSMyoWtrFhot
X-Gm-Gg: ASbGncv89qDJ3KdubSekbIVSWKYG42J+6d9xGYKVGxgmyAQAVV+eoAXJOiqgLE9o6o7
 L/r3G+eWK4DlHDz12BlkDKP+i4kcSOgmu9wIf29609qFkeUDQayehHDapXAa8Wz+WkEnq8EoFDL
 iBJFD8Qyk=
X-Google-Smtp-Source: AGHT+IGo/gr0XzpA7lX1vi9EWOgZWS+ifR/YlVLEEZGERbqIOqUVTuaPpQTRT9sPn4yOjMuXviHDwC8kQ++R2nqjL1w=
X-Received: by 2002:a17:902:ec81:b0:21f:7a9:48b2 with SMTP id
 d9443c01a7336-221a0001b5emr154952005ad.13.1740667074904; Thu, 27 Feb 2025
 06:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
 <20250221130030.3703750-4-Prike.Liang@amd.com>
 <DS7PR12MB6005EFC45E880B99D77781BCFBCD2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005EFC45E880B99D77781BCFBCD2@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 09:37:43 -0500
X-Gm-Features: AQ5f1JqwW3ITi7iAzsnu33kfxVkPyWm3YvS3zqm_1DcJqdUMjTu9nXvRmz2BT0g
Message-ID: <CADnq5_OoqZcLoO+p7MseA9zG8hvXS85JRYpJZ9M=dT9sJMXcWg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe
 reset
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Thu, Feb 27, 2025 at 7:36=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Please review the series patch to catch up the gfx latest base and to avo=
id the commit merged problem.

See my comment on patch 1:

#define RS64_FW_UC_START_ADDR_LO 0x3000

Will this potentially change in future firmware versions or is it
fixed?  If it will change, then let's just read it back from registers
and store it in adev->gfx.rs64_fw_use_start_addr_lo so
that it will be correct if the user has a mix of GPUs in the system.
Other than those comments, the series looks good to me.

Alex


>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Friday, February 21, 2025 9:01 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe
> > reset
> >
> > Implement the GFX12 KCQ pipe reset, and disable the GFX12 kernel comput=
e
> > queue until the CPFW fully supports it.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 90 +++++++++++++++++++++++++-
> >  1 file changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > index 79ae7d538844..103298938d22 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -5352,6 +5352,90 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_rin=
g
> > *ring, unsigned int vmid)
> >       return amdgpu_ring_test_ring(ring);
> >  }
> >
> > +static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring) {
> > +
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> > +     int r;
> > +
> > +     if (!gfx_v12_pipe_reset_support(adev))
> > +             return -EOPNOTSUPP;
> > +
> > +     gfx_v12_0_set_safe_mode(adev, 0);
> > +     mutex_lock(&adev->srbm_mutex);
> > +     soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> > +
> > +     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> > +     clean_pipe =3D reset_pipe;
> > +
> > +     if (adev->gfx.rs64_enable) {
> > +
> > +             switch (ring->pipe) {
> > +             case 0:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE0_RESET, 1);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE0_RESET, 0);
> > +                     break;
> > +             case 1:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE1_RESET, 1);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE1_RESET, 0);
> > +                     break;
> > +             case 2:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE2_RESET, 1);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE2_RESET, 0);
> > +                     break;
> > +             case 3:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE3_RESET, 1);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_RS64_CNTL,
> > +                                                MEC_PIPE3_RESET, 0);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> > +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> > +             r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR)
> > << 2) - RS64_FW_UC_START_ADDR_LO;
> > +     } else {
> > +             switch (ring->pipe) {
> > +             case 0:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                        MEC_ME1_PIPE0_=
RESET,
> > 1);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                        MEC_ME1_PIPE0_=
RESET,
> > 0);
> > +                     break;
> > +             case 1:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                        MEC_ME1_PIPE1_=
RESET,
> > 1);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                        MEC_ME1_PIPE1_=
RESET,
> > 0);
> > +                     break;
> > +             default:
> > +             break;
> > +             }
> > +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> > +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> > +             /* Doesn't find the F32 MEC instruction pointer register,=
 and
> > suppose
> > +              * the driver won't run into the F32 mode.
> > +              */
> > +     }
> > +
> > +     soc24_grbm_select(adev, 0, 0, 0, 0);
> > +     mutex_unlock(&adev->srbm_mutex);
> > +     gfx_v12_0_unset_safe_mode(adev, 0);
> > +
> > +     dev_info(adev->dev,"The ring %s pipe resets: %s\n", ring->name,
> > +                     r =3D=3D 0 ? "successfully" : "failed");
> > +     /* Need the ring test to verify the pipe reset result.*/
> > +     return 0;
> > +
> > +}
> >  static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int =
vmid)  {
> >       struct amdgpu_device *adev =3D ring->adev; @@ -5362,8 +5446,10 @@
> > static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int v=
mid)
> >
> >       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true)=
;
> >       if (r) {
> > -             dev_err(adev->dev, "reset via MMIO failed %d\n", r);
> > -             return r;
> > +             dev_warn(adev->dev,"fail(%d) to reset kcq  and try pipe r=
eset\n", r);
> > +             r =3D gfx_v12_0_reset_compute_pipe(ring);
> > +             if (r)
> > +                     return r;
> >       }
> >
> >       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> > --
> > 2.34.1
>
