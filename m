Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA99EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 14:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825AD10E3D7;
	Thu, 29 Jun 2023 14:04:13 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E1810E3D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 14:04:11 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a0642e4695so370326b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688047451; x=1690639451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98d/topu5FAaj5tt6b4OfS+nUwThxzO/mqYy2A1wpbU=;
 b=OuBsGJcPpc3qi4QbEisOeyMT3i0dSviIiH9IlIIOx/mKo17YYR3MhdmklaAbnMFsQl
 rdvJFs/1xhwyE+vKW6IbQg7q2cP/hsFJJD6YsVNgemNy/ktQOTZFrONA0BaCQjL6m9aq
 1UPRFylCvGtqTRMdkM7lNxRSKx0P0+sGoLFbfEykyNYbNBKyFIvmkU8f1Nrpq1fKG08d
 1pOhVe8arahIRBUfqfnlKGStrMmvWx2hLnxPvk9FqOKbsnZDKEkVt9aROD1ZMaHJ0Lxr
 nsifzX1h9UiyE3nVt9sOZOr+viRNbxDJQA+2H0P3/gh5JxcCzyLrhgDZ+ZA8BGvcr4py
 sEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688047451; x=1690639451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98d/topu5FAaj5tt6b4OfS+nUwThxzO/mqYy2A1wpbU=;
 b=fY8xhL93ZQmw7Pqo6TnQROIQbaLiSBYyPA33aguhsZwGm0SjtJccJWGumUjiH2cNF5
 SsFmViEMqXtLJOoz21f/uizQ969tLWTArWCE9KYZgkESB1xAinSqcnS6IbYqhsfXYxH9
 8lwPlRdxouHX7pGH4BNJknpVYsseGCsDVhpATep1erZCJLCHZ7IQ85hJVLegORFkp8FU
 q7sTH3n0T+4efPIyL9JG3jGsn0Ir/1Gogs0MT7n2/fezBgb5jSCXnWXIznabVJDf0vly
 VoxbrHW5jVVScBYm7SlvVEYtVk+3MBVcJJX56K34OVs7stjVZ22r1L8GKnxbwC2gVIJC
 RSdg==
X-Gm-Message-State: AC+VfDzNbueCTOmkSkjQBBtd+OkVFOBotCBOxmyqSRdBYEkV4XS2Z4rX
 QvPJH372cmR44a0iGZ0R1WVBlWVHCwdgN+ImaNc=
X-Google-Smtp-Source: ACHHUZ7kxo+WN91Xex1M9p7Yl2pVdjAaxC2zVagGT+YC9jpB/Gg4LY7WW6nvGrvo8xyTRHgo9P/M+Rtn0EtYXRy4wQo=
X-Received: by 2002:a05:6808:1987:b0:3a1:9540:feb1 with SMTP id
 bj7-20020a056808198700b003a19540feb1mr21017455oib.14.1688047450758; Thu, 29
 Jun 2023 07:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
 <20230629044635.2266729-6-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230629044635.2266729-6-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jun 2023 10:03:59 -0400
Message-ID: <CADnq5_PHQs4uuoVuFzApOjuqe-2dXXg3P8dFsZirE-YbzrMGsA@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/amd/display: Clean up warnings in amdgpu_dm
 _mst_types, _plane, _psr.c
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jun 29, 2023 at 12:47=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix the following warnings reported by checkpatch:
>
> WARNING: Missing a blank line after declarations
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     | 4 ++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c       | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 46d0a8f57e55..95eefa6b4f2f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -296,6 +296,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *=
connector)
>
>         if (!aconnector->edid) {
>                 struct edid *edid;
> +
>                 edid =3D drm_dp_mst_get_edid(connector, &aconnector->mst_=
root->mst_mgr, aconnector->mst_output_port);
>
>                 if (!edid) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 322668973747..de1c7026ffcd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -164,7 +164,7 @@ static bool modifier_has_dcc(uint64_t modifier)
>         return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier)=
;
>  }
>
> -static unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
> +static unsigned int modifier_gfx9_swizzle_mode(uint64_t modifier)
>  {
>         if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)
>                 return 0;
> @@ -581,7 +581,7 @@ static void add_gfx11_modifiers(struct amdgpu_device =
*adev,
>         int pkrs =3D 0;
>         u32 gb_addr_config;
>         u8 i =3D 0;
> -       unsigned swizzle_r_x;
> +       unsigned int swizzle_r_x;
>         uint64_t modifier_r_x;
>         uint64_t modifier_dcc_best;
>         uint64_t modifier_dcc_4k;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index 4f61d4f257cd..08ce3bb8f640 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -166,6 +166,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *str=
eam)
>          */
>         if (vsync_rate_hz !=3D 0) {
>                 unsigned int frame_time_microsec =3D 1000000 / vsync_rate=
_hz;
> +
>                 num_frames_static =3D (30000 / frame_time_microsec) + 1;
>         }
>
> --
> 2.25.1
>
