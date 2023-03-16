Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04CDC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 00:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EE610EA3B;
	Thu, 16 Mar 2023 00:37:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F6710EA45
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 00:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678927061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZGtUmmSwegvnSpt+LkTwc0U1bNplB2nqM1fOGP4KKw=;
 b=Rgs4JKGBJArbaqW1A2AxmB+gcUbMfdzj3iQViIaRA3+8YEmqqCNc6DWCRWqpiwZXhPz+Rm
 WW0tBwJG8NI6nlF3boYKHCa5QNqicwMSstZaU0e0HzB4LlfLT6Uj7MLjIavS1pXtm8iGQv
 2BktpqUiSk3FCjJyG6lAMVYKJxQkq7A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-hfP6URynMjKQhvV6S4nBqQ-1; Wed, 15 Mar 2023 20:37:37 -0400
X-MC-Unique: hfP6URynMjKQhvV6S4nBqQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 p8-20020a056512234800b004dda0f69233so91945lfu.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 17:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678927056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZGtUmmSwegvnSpt+LkTwc0U1bNplB2nqM1fOGP4KKw=;
 b=zGKzJwl9OwbVAbQr2tgGwjYOE1W5PBICNms4+fSDtsZiJNxEVgHjvTJO9YQB644kui
 DsztB5wJa68H59tGeUC1OpdFcrY8JkvS5jz9ymeanGMCIDqAchlMjkrZX5sWeR+ry9no
 1OZxm6jmQkgSDWzvpEpKYDWxjI5Tnic1s+6mBxWnDmgDfQfU6qzC7AV71lfWRJ6qNWoa
 5m9R8lpcAd3mbVMyegNyEIIyrr3STp+KctAISB1WTh8yYJtu5+zNPnaqWldLWH7dGgMB
 oWYuMmGTWXyZY9uwL12pLxheadlp3CvvXdhcFkfQSS9um6FtWh76HREb0nB+NNYa9+lV
 bILQ==
X-Gm-Message-State: AO0yUKVEzaNTWIC2H0mSVfnSZJ+o0YsbgRNRNxLJRV/70/HClk+5Laao
 6cOJPeqxe4Y8B6OI/H/nyrSVrGeJclzH8LpRo0yRcIQXHBEkhVNGzoMa6vh8Cwao8WQWvgW3k5W
 kufEUJfoq7kjVH8rAH4D4v6HmybwO1jKr9xYDrJOQdA==
X-Received: by 2002:a2e:9b8a:0:b0:298:b337:c127 with SMTP id
 z10-20020a2e9b8a000000b00298b337c127mr929190lji.1.1678927056160; 
 Wed, 15 Mar 2023 17:37:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ob8956XPzyOyB9AnsVyodoU7LE5U4DSy09na/EyTxhZ/WZvNgxE6Poz/JzPCkEBmm9TDvSSN1gIrUga69EVg=
X-Received: by 2002:a2e:9b8a:0:b0:298:b337:c127 with SMTP id
 z10-20020a2e9b8a000000b00298b337c127mr929184lji.1.1678927055861; Wed, 15 Mar
 2023 17:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230307151107.49649-1-harry.wentland@amd.com>
 <20230307151107.49649-10-harry.wentland@amd.com>
In-Reply-To: <20230307151107.49649-10-harry.wentland@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Thu, 16 Mar 2023 01:37:24 +0100
Message-ID: <CA+hFU4yiniJdxWOxDKnD7bTGw3QA8uSLyG5sbeiQ5oWqitTZcQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] drm/amd/display: Register Colorspace property
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
Cc: Joshua Ashton <joshua@froggi.es>, Pekka Paalanen <ppaalanen@gmail.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 7, 2023 at 4:12=E2=80=AFPM Harry Wentland <harry.wentland@amd.c=
om> wrote:
>
> We want compositors to be able to set the output
> colorspace on DP and HDMI outputs, based on the
> caps reported from the receiver via EDID.

About that... The documentation says that user space has to check the
EDID for what the sink actually supports. So whatever is in
supported_colorspaces is just what the driver/hardware is able to set
but doesn't actually indicate that the sink supports it.

So the only way to enable bt2020 is by checking if the sink supports
both RGB and YUV variants because both could be used by the driver.
Not great at all. Something to remember for the new property.

> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Sebastian Wick <sebastian.wick@redhat.com>
> Cc: Vitaly.Prosyak@amd.com
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: dri-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Reviewed-By: Joshua Ashton <joshua@froggi.es>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f91b2ea13d96..2d883c6dae90 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7184,6 +7184,12 @@ static int amdgpu_dm_connector_get_modes(struct dr=
m_connector *connector)
>         return amdgpu_dm_connector->num_modes;
>  }
>
> +static const u32 supported_colorspaces =3D
> +       BIT(DRM_MODE_COLORIMETRY_BT709_YCC) |
> +       BIT(DRM_MODE_COLORIMETRY_OPRGB) |
> +       BIT(DRM_MODE_COLORIMETRY_BT2020) |
> +       BIT(DRM_MODE_COLORIMETRY_BT2020_DEPRECATED);
> +
>  void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>                                      struct amdgpu_dm_connector *aconnect=
or,
>                                      int connector_type,
> @@ -7264,6 +7270,15 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
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
> 2.39.2
>

