Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2159FC77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 16:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F6410E816;
	Fri, 26 May 2023 16:40:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF28510E812
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685119248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w75dA4F6241A+HRi4qQsDvhEG9Ymk+yOcSdz/MwUoD0=;
 b=LKDTh2LRRP8PaCbFHtmE0pecTV0XtnWxfK8eLR1i4gwqMGD1+dtwXJB3K7iKb5ozljHZid
 0ZdMzvuAyN2G4gb20iWCSh7CZcRIKj9xgab8eILhVcPCjNoGUAg/ZjkqHXioVpPfIJ8Qeq
 UK2vC3KTgXFE7+oT3MAH1lqTp/1sJhE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-z-s6mkmXNxOPklh-o7oMkw-1; Fri, 26 May 2023 12:40:46 -0400
X-MC-Unique: z-s6mkmXNxOPklh-o7oMkw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af2f0b7331so4086381fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 09:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685119244; x=1687711244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w75dA4F6241A+HRi4qQsDvhEG9Ymk+yOcSdz/MwUoD0=;
 b=IZLRX9SfeK+0sVyuOgNNCwdBc31mzTzE3I4mul1OChs34+jrgsYsoGr9WV9IYXSUKj
 HD3b+0/Jw895mDp34ve2pue3hn4r5ND8/6JCQMg1myrY61aammSnDnVwor/e/qQ63oER
 CWFRCEw3aKR7rQY2dms3vnRmOIHUM3XxlvdaKdGf4uyzbs9F48O6ukP0rK7d08qmRsH6
 DrsuM/CeWOpaBYkmWHufcjEB5sUclP89SJK56BiMfNpFjfSg+C684w9Vbck4N+2FW6MB
 7y4YoFl63WWRbtr1D4exz96ShEmbLHRi61rtNYImJvwc8q8fBvZaN2CQKKyCTMchOjEL
 F1jA==
X-Gm-Message-State: AC+VfDzIj+G5MNSlzntjizjt6u6ybC6c6xmRI3RTXJIfiV9o5x3I0hqh
 pw/oabXMDbTVDl+2pm2XOQFxX1Q1BUGaK2UCmItBziZEJNGABHRreGeDcCSJWW1H28GF4tX6b0u
 rFaMyGBn54qYUR7x0jbFFgJs0eSVx6PSscCaZXJzajUnNw96dUHj5xPQ1ZA==
X-Received: by 2002:a2e:9ec8:0:b0:2af:1817:26e1 with SMTP id
 h8-20020a2e9ec8000000b002af181726e1mr808646ljk.30.1685119244274; 
 Fri, 26 May 2023 09:40:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7jVUpzD1GyLxEFAk+PsM0QiyoZLcXZrV7pBvn/Z0+lnTqiys+uI/NveXsG/9zpq4xvnpLia5Fh83Oq5PO9iNo=
X-Received: by 2002:a2e:9ec8:0:b0:2af:1817:26e1 with SMTP id
 h8-20020a2e9ec8000000b002af181726e1mr808638ljk.30.1685119243974; Fri, 26 May
 2023 09:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230525191809.3524-1-harry.wentland@amd.com>
 <20230525191809.3524-9-harry.wentland@amd.com>
In-Reply-To: <20230525191809.3524-9-harry.wentland@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Fri, 26 May 2023 18:40:32 +0200
Message-ID: <CA+hFU4w3yeXFNvxfFTRmzq25C5K5PMJZR_KJDT8W4wwvOaiXig@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] drm/amd/display: Register Colorspace property
 for DP and HDMI
To: Harry Wentland <harry.wentland@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, dri-devel@lists.freedesktop.org,
 Joshua Ashton <joshua@froggi.es>, Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 9:18=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> We want compositors to be able to set the output
> colorspace on DP and HDMI outputs, based on the
> caps reported from the receiver via EDID.

This commit message seems wrong for multiple reasons. The Colorspace
property documentation explicitly says that user space has to check
the sink EDID for support:

> The expectation from userspace is that it should parse the EDID and get s=
upported colorspaces.

The code doesn't seem to care about EDID at all. Instead it exposes
the variants it knows how to support with e.g. the appropriate YCC
transform when necessary, independent of the sink support.

> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Sebastian Wick <sebastian.wick@redhat.com>
> Cc: Vitaly.Prosyak@amd.com
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ca093396d1ac..dc99a8ffac70 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7238,6 +7238,12 @@ static int amdgpu_dm_connector_get_modes(struct dr=
m_connector *connector)
>         return amdgpu_dm_connector->num_modes;
>  }
>
> +static const u32 supported_colorspaces =3D
> +       BIT(DRM_MODE_COLORIMETRY_BT709_YCC) |
> +       BIT(DRM_MODE_COLORIMETRY_OPRGB) |
> +       BIT(DRM_MODE_COLORIMETRY_BT2020_RGB) |
> +       BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
> +
>  void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>                                      struct amdgpu_dm_connector *aconnect=
or,
>                                      int connector_type,
> @@ -7318,6 +7324,15 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>                                 adev->mode_info.abm_level_property, 0);
>         }
>
> +       if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
> +               if (!drm_mode_create_hdmi_colorspace_property(&aconnector=
->base, supported_colorspaces))
> +                       drm_connector_attach_colorspace_property(&aconnec=
tor->base);
> +       } else if (connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort |=
|
> +                  connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +               if (!drm_mode_create_dp_colorspace_property(&aconnector->=
base, supported_colorspaces))
> +                       drm_connector_attach_colorspace_property(&aconnec=
tor->base);
> +       }
> +
>         if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
>             connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
>             connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> --
> 2.40.1
>

