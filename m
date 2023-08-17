Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A57C2FC14
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 13:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BBB10E4A3;
	Thu, 17 Aug 2023 13:58:25 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16B010E4A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 13:58:24 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-56ced49d51aso529429eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692280704; x=1692885504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/79o/WPNFhpjM33aSD2DFRdKV0l2wqkIt5CmYssd+w=;
 b=MR6FYrbFjRFxi29rKjrjzpfmt26DpV4XYcCroXhT6/XaAawbqasJpon3nNlJlNFYI2
 TBq7erPttUp7kCBclDlC1X0IXrT1bVBCS0Z7OOQxhMBEM9yekJmnIKtjXRwOCBBdBX1z
 fyTBU8qdrfVR+MXfEDWz4AzX+Py8oVul5vl1ZNiPPnP2VWDcBDKMs0NXVe/meWp4tKx4
 I4CKsBdSBEeA7+vuMspf2kDktLO8qJV2/4L2xo5mSBu2eRNaW2nWzJradB5s0NGkIb1p
 ooVG/jJ0OU6KLAcmcaYpvDtNqcYDN5pmi4oUoFndSt5s8t2278FfeXDDZnAi0vdWQvAH
 s/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692280704; x=1692885504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/79o/WPNFhpjM33aSD2DFRdKV0l2wqkIt5CmYssd+w=;
 b=bALlXSaNknzLBEQXs7zYRJNA9tOJAVxfcHJNsCjes3OIkz2/WZfqFUGXmbayPRUxz8
 0SaJm/p+26oI1eYQ3n6AmbP0nzdkWBgZrE68IkjthD4O2vcU87IiIvKV2zQkuFXck6vm
 fwb8pgVsV4Ra0m7XRl6U1zo23bE8/0qFH0bm6VEHmaXYkJnO7OvMowUUZY9kjy4a2Te/
 c/v5/eNWTi12cwEK4oTfOwE8ZpDrJLLyY2rfc23ykQySV5kufbTMnMXgnrET6CV/lnnt
 Krs+xqzB7RirfZ6xgvKwDZJvlusbCj8KdsacRuveIIABeTLEiEFKLAbWQjUHBdNCrROs
 rxyw==
X-Gm-Message-State: AOJu0YwUo9qPJQ9WNh9TdwO57CNwKF/RtaOqsPSGHSKSraVaOYvuo9oM
 ITGsEzkVqaj4Cv9Tm89ULtno6u+yXJJ16dWlDXo=
X-Google-Smtp-Source: AGHT+IHAVOiIvfIl9E+kLljjX5Q/OVaYE+wuOc+4m9RHShbNtbcNhupV3M3EfBjIV+bi+TELGYcjyKp+kSQL/jeVFw8=
X-Received: by 2002:a05:6871:a3:b0:1c3:2a5a:ebea with SMTP id
 u35-20020a05687100a300b001c32a5aebeamr2101653oaa.8.1692280703742; Thu, 17 Aug
 2023 06:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-3-alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-3-alex.hung@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Aug 2023 09:58:12 -0400
Message-ID: <CADnq5_OD1Q_QOM38-JrYUFjkbQmH0rjww3p-fS36u_sn3_4=wg@mail.gmail.com>
Subject: Re: [PATCH 02/18] drm/amd/display: Create one virtual connector in DC
To: Alex Hung <alex.hung@amd.com>
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 17, 2023 at 8:45=E2=80=AFAM Alex Hung <alex.hung@amd.com> wrote=
:
>
> From: Harry Wentland <harry.wentland@amd.com>
>
> [WHAT]
> Prepare a virtual connector for writeback.

I presume the main point of virtual connectors in DC is for writeback?
 Would there be a case where the virtual type would be mis-interpreted
in DC as something else?

Alex

>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 11 +++++++++--
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |  3 ++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b1245b732cc9..00254fdfa1f7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1675,6 +1675,10 @@ static int amdgpu_dm_init(struct amdgpu_device *ad=
ev)
>         init_data.dcn_reg_offsets =3D adev->reg_offset[DCE_HWIP][0];
>         init_data.nbio_reg_offsets =3D adev->reg_offset[NBIO_HWIP][0];
>
> +       /* Enable DWB for tested platforms only */
> +       if (adev->ip_versions[DCE_HWIP][0] >=3D IP_VERSION(3, 0, 0))
> +               init_data.num_virtual_links =3D 1;
> +
>         INIT_LIST_HEAD(&adev->dm.da_list);
>
>         retrieve_dmi_info(&adev->dm);
> @@ -4385,6 +4389,11 @@ static int amdgpu_dm_initialize_drm_device(struct =
amdgpu_device *adev)
>                         continue;
>                 }
>
> +               link =3D dc_get_link_at_index(dm->dc, i);
> +
> +               if (link->connector_signal =3D=3D SIGNAL_TYPE_VIRTUAL)
> +                       continue;
> +
>                 aconnector =3D kzalloc(sizeof(*aconnector), GFP_KERNEL);
>                 if (!aconnector)
>                         goto fail;
> @@ -4403,8 +4412,6 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
>                         goto fail;
>                 }
>
> -               link =3D dc_get_link_at_index(dm->dc, i);
> -
>                 if (!dc_link_detect_connection_type(link, &new_connection=
_type))
>                         DRM_ERROR("KMS: Failed to detect connector\n");
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> index 2a7f47642a44..65e8504e6063 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> @@ -96,7 +96,8 @@ static void enable_memory_low_power(struct dc *dc)
>         if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stre=
am_enc[0]->vpg->funcs->vpg_powerdown) {
>                 // Power down VPGs
>                 for (i =3D 0; i < dc->res_pool->stream_enc_count; i++)
> -                       dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powe=
rdown(dc->res_pool->stream_enc[i]->vpg);
> +                       if (dc->res_pool->stream_enc[i]->vpg)
> +                               dc->res_pool->stream_enc[i]->vpg->funcs->=
vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
>  #if defined(CONFIG_DRM_AMD_DC_FP)
>                 for (i =3D 0; i < dc->res_pool->hpo_dp_stream_enc_count; =
i++)
>                         dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->v=
pg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
> --
> 2.41.0
>
