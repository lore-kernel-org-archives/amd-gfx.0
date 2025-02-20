Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4EEC021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 14:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC45310E971;
	Thu, 20 Feb 2025 14:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBb5KM2D";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF2910E971
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 14:18:09 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2fc288da33eso248083a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 06:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740061089; x=1740665889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqAmCWUXdok3O1IdqJYJ+RHrQNC4smm0AifxVuukkbg=;
 b=IBb5KM2Dqkl847XN6+9Nd/4kl6XHwxN6CzRR6FgbzyUe9+1Vlar9xfRP807gAS3gYN
 T9qbSqc7Hm6vRs+RIvsWQW3YFAMVvi9OoX5v9Fjun3s8cf0Hs4315ja1ysZKzPwtzHIT
 mtKlcDFagxY454XCnnqZ4Ze05+M72zbHmHhpE081jGAjO3xEE387ZkZ1BbRBLDekmhvK
 Vqei/kXxtoqsRyyuR2jGVmg9nca/RRpJhK1MxVosOPiLwez1JTDnnB4EYD0TBQIz4F9u
 xtCApk3JyLtHLi1FLy9OEQiEqD8cCESJ9C8oL2or5RC3yRRZo4P3ospmykrYnbxTAyCa
 SulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740061089; x=1740665889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqAmCWUXdok3O1IdqJYJ+RHrQNC4smm0AifxVuukkbg=;
 b=BBDpky1jXEnjUQql5O7GijDzGWrjdEefMJZaG60sw+H4aevPscKbto6Itdxf6WSrIy
 7Ui7/x3Q+fW9SVBzUpP9f+fvylIFrYhu1pS0mlRRYRJqE5A+zXvQFQQOxF/AgpGca1OA
 X+dNR74UW1EMSfZS5ibB+vFOYtfefrAC7mw7m4tSqV4MCI/fkNmLv5IyG25wJSjjke9d
 yXcyGooW1xe3NyZHhU1Ag2Ddg5rdGQ2OM/bLenI8QV85ljlnKcnraOOCbtYeIVRfxO7s
 Q5iYXJrepOL6fGfeSsWn5OOImoTde32Zc62dOmb2Yluy+JJLnCvJ6nzn0BtVXwfcteIe
 PFYQ==
X-Gm-Message-State: AOJu0YwRgSyxpMdi7Qje7XplzF6+1kaiBQl9biCqAzqmlHLH4nVEkvtk
 TX3W7EpfaWcI/klRQNjUu8eKvh0ZJFcirFoZk/1KjVIkCEBUZPxxXqKshf0G6Zh42cIBDqLMyun
 FIZovmiIsXN4nz5kkjXAwIgROa60=
X-Gm-Gg: ASbGncuodWbnDOwMGGpfPutBXJhIcqQRlFNheUHbADdS8rYKrYxTiCejbTtBwUhKREJ
 dKsnSiv37UwJrFmrUirUICQ1k2f+Qz+5ox79TVcQnSrP+7y2Gjx3/ATszQvdNeGY93P3HgtFT
X-Google-Smtp-Source: AGHT+IEZ9RCU1vCYLS4GMcOIOAwWRG4Bv5AnOO0mXuNYgOUgWuS82OxuJfjxnyJrdYD8OlQUjYiYHFe/DbNs/c5YUSU=
X-Received: by 2002:a17:90b:3504:b0:2fc:f63:4b6a with SMTP id
 98e67ed59e1d1-2fc4078f0a1mr13657059a91.0.1740061089233; Thu, 20 Feb 2025
 06:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20250126083733.3331474-1-Prike.Liang@amd.com>
 <CADnq5_PEMn-K9APP6dtRXz-xVcU_Zx21b27J0Z0m+TJKVBTmbw@mail.gmail.com>
 <DS7PR12MB6005DDEF2B0D2DB8854BA048FBC42@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005DDEF2B0D2DB8854BA048FBC42@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Feb 2025 09:17:56 -0500
X-Gm-Features: AWEUYZmkWoNSDeKc1azxuLl6FkC6Lh0OQ3NkslVLyJM1bdodGYkwhjvcIQ8mu1U
Message-ID: <CADnq5_OcueKfUP_ot0vh31c7pheUR3HFMGdL-=HkfQXUY75RSQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe reset
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
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

On Thu, Feb 20, 2025 at 4:39=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> The various gfx11/gfx12 systems share the same start PC value, but it see=
ms better to use the specific register CP_ME_PRGRM_CNTR_START to get the st=
art PC value.

Why not store the value per device?  Or if it's always the same, just
use a macro.

Alex


>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, February 20, 2025 3:56 AM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> > Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe
> > reset
> >
> > On Sun, Jan 26, 2025 at 3:38=E2=80=AFAM Prike Liang <Prike.Liang@amd.co=
m> wrote:
> > >
> > > Implement the kernel graphics queue pipe reset,and the driver will
> > > fallback to pipe reset when the queue reset fails. However, the ME FW
> > > hasn't fully supported pipe reset yet so disable the KGQ pipe reset
> > > temporarily.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 76
> > > +++++++++++++++++++++++++-
> > >  1 file changed, 74 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > index 89d17750af04..395872bb1401 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > @@ -65,6 +65,8 @@
> > >  #define regPC_CONFIG_CNTL_1            0x194d
> > >  #define regPC_CONFIG_CNTL_1_BASE_IDX   1
> > >
> > > +static uint32_t me_fw_start_pc;
> > > +
> > >  MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
> > >  MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
> > >  MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
> > > @@ -2932,6 +2934,9 @@ static void gfx_v11_0_config_gfx_rs64(struct
> > amdgpu_device *adev)
> > >         tmp =3D REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL,
> > MEC_PIPE2_RESET, 0);
> > >         tmp =3D REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL,
> > MEC_PIPE3_RESET, 0);
> > >         WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
> > > +
> > > +       /* cache the firmware start PC */
> > > +       me_fw_start_pc =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> > > + regCP_GFX_RS64_INSTR_PNTR1));
> >
> > You can't use a global variable.  It won't work if you have multiple GP=
Us in the
> > system.
> >
> > Alex
> >
> > >  }
> > >
> > >  static int gfx_v11_0_wait_for_rlc_autoload_complete(struct
> > > amdgpu_device *adev) @@ -6654,6 +6659,68 @@ static void
> > gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
> > >         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */  }
> > >
> > > +static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev) {
> > > +       /* Disable the pipe reset until the CPFW fully support it.*/
> > > +       dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset =
yet.\n");
> > > +       return false;
> > > +}
> > > +
> > > +
> > > +static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring) {
> > > +       struct amdgpu_device *adev =3D ring->adev;
> > > +       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> > > +       int r;
> > > +
> > > +       if (!gfx_v11_pipe_reset_support(adev))
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       gfx_v11_0_set_safe_mode(adev, 0);
> > > +       mutex_lock(&adev->srbm_mutex);
> > > +       soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0)=
;
> > > +
> > > +       switch (ring->pipe) {
> > > +       case 0:
> > > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > > +                                          PFP_PIPE0_RESET, 1);
> > > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > > +                                          ME_PIPE0_RESET, 1);
> > > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > > +                                          PFP_PIPE0_RESET, 0);
> > > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > > +                                          ME_PIPE0_RESET, 0);
> > > +               break;
> > > +       case 1:
> > > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > > +                                          PFP_PIPE1_RESET, 1);
> > > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > > +                                          ME_PIPE1_RESET, 1);
> > > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > > +                                          PFP_PIPE1_RESET, 0);
> > > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > > +                                          ME_PIPE1_RESET, 0);
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +
> > > +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
> > > +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
> > > +
> > > +       r =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> > regCP_GFX_RS64_INSTR_PNTR1)) - me_fw_start_pc;
> > > +       soc21_grbm_select(adev, 0, 0, 0, 0);
> > > +       mutex_unlock(&adev->srbm_mutex);
> > > +       gfx_v11_0_unset_safe_mode(adev, 0);
> > > +
> > > +       dev_info(adev->dev,"The ring %s pipe reset to the ME firmware=
 start
> > PC: %s\n", ring->name,
> > > +                       r =3D=3D 0 ? "successfuly" : "failed");
> > > +       /* FIXME: Sometimes driver can't cache the ME firmware start =
PC
> > correctly, so the pipe reset status
> > > +        * relies on the later gfx ring test result.
> > > +        */
> > > +       return 0;
> > > +}
> > > +
> > >  static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned in=
t
> > > vmid)  {
> > >         struct amdgpu_device *adev =3D ring->adev; @@ -6663,8 +6730,1=
3
> > > @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned =
int vmid)
> > >                 return -EINVAL;
> > >
> > >         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, f=
alse);
> > > -       if (r)
> > > -               return r;
> > > +       if (r) {
> > > +
> > > +               dev_warn(adev->dev,"reset via MES failed and try pipe=
 reset %d\n",
> > r);
> > > +               r =3D gfx_v11_reset_gfx_pipe(ring);
> > > +               if (r)
> > > +                       return r;
> > > +       }
> > >
> > >         r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> > >         if (unlikely(r !=3D 0)) {
> > > --
> > > 2.34.1
> > >
