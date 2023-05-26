Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A22FC7EE2C
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 16:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CE410E80A;
	Fri, 26 May 2023 16:27:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865C110E7FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685118468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLGWYvt/AG+suCZwZTxUSu1+8DySrAKPlVf+EbWxioE=;
 b=NJSQnS0uf8Q2iw1OsVbTN0ogxOBg+5aElf9AbFyZH2S4xzrg6RmHvcGKJ5CmW4z6dI4rL/
 v56oUXovFamSsh1i6ZYrx4zgvL14PDkTSgnKo/0Laly4LWwdZ2z07aOLx7HoyHYMjtLsNp
 un7vBgPRehUWztQifRO5ARFF/hqmWjQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-ICbMAOFHP9CmtxQ1f30uWA-1; Fri, 26 May 2023 12:27:46 -0400
X-MC-Unique: ICbMAOFHP9CmtxQ1f30uWA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b0227e61c1so4459711fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 09:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685118465; x=1687710465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLGWYvt/AG+suCZwZTxUSu1+8DySrAKPlVf+EbWxioE=;
 b=Qi40PeXUz33I34c/w1B7Z4CbLX7kb+g7TAfHnJzr9DYnPU9fvsrCaMi09zP9uj+wmQ
 v565EVNZALQHg5Ewfso6lKJvfbyobQnRtsIp2Bf1sLE2ZIiav2Po2jlcZC70tD4goAyp
 XzvoztU8WmLTju8nkTW6MNNBkk2sd3WvE0tNVk4/AFP7br8esD5OCx5TArTiN1X+CQdO
 JNRTGnpeaoa8H7laM7uNNhaAa2C1/4D5lpKI54GIWFcPMegZtSoXTJuePt3adohgMkPe
 0LgJb9IY/Iz0momXuhKYzwoYOEUqZzqU1mGwVYP/omg/8f7lpV7ot+GFszxMI2sQad2M
 3q6w==
X-Gm-Message-State: AC+VfDw42E2vwDvrhQSk4iBfvkfk/YFfW+epumIFDzzGG5RRXeat6WHM
 83oSklrpDsAe5wKOS+GSKRHfEaTSVzCXW09sf4FbX2qeFwKMyqJ5jnHg/Xldlwq+rX4gh+Mhy3c
 //396k1sGvEndIK1FeF/Wa3LBZNTbX3urHIX1wicDyg==
X-Received: by 2002:a2e:9d44:0:b0:2a8:c858:fb9 with SMTP id
 y4-20020a2e9d44000000b002a8c8580fb9mr833843ljj.29.1685118465271; 
 Fri, 26 May 2023 09:27:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EfMM3R3AP/sdg4PC8zxFRuLJWcuwGxr84H1bYZeWNx1HybTepkJAZlgBUedXa8jaWPcBfvhi6C3QMZJKBB40=
X-Received: by 2002:a2e:9d44:0:b0:2a8:c858:fb9 with SMTP id
 y4-20020a2e9d44000000b002a8c8580fb9mr833833ljj.29.1685118464987; Fri, 26 May
 2023 09:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230525191809.3524-1-harry.wentland@amd.com>
 <20230525191809.3524-3-harry.wentland@amd.com>
In-Reply-To: <20230525191809.3524-3-harry.wentland@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Fri, 26 May 2023 18:27:33 +0200
Message-ID: <CA+hFU4xpYguvZi7n48xB3BS-dONShUvDOwBqpM2aZXRAH_DGwQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] drm/connector: Add enum documentation to
 drm_colorspace
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
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 dri-devel@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 9:18=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> From: Joshua Ashton <joshua@froggi.es>
>
> To match the other enums, and add more information about these values.
>
> v2:
>  - Specify where an enum entry comes from
>  - Clarify DEFAULT and NO_DATA behavior
>  - BT.2020 CYCC is "constant luminance"
>  - correct type for BT.601
>
> v4:
> - drop DP/HDMI clarifications that might create
>   more questions than answers
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Sebastian Wick <sebastian.wick@redhat.com>
> Cc: Vitaly.Prosyak@amd.com
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  include/drm/drm_connector.h | 62 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 77401e425341..ee597593d7e6 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -363,13 +363,71 @@ enum drm_privacy_screen_status {
>         PRIVACY_SCREEN_ENABLED_LOCKED,
>  };
>
> -/*
> - * This is a consolidated colorimetry list supported by HDMI and
> +/**
> + * enum drm_colorspace - color space
> + *
> + * This enum is a consolidated colorimetry list supported by HDMI and
>   * DP protocol standard. The respective connectors will register
>   * a property with the subset of this list (supported by that
>   * respective protocol). Userspace will set the colorspace through
>   * a colorspace property which will be created and exposed to
>   * userspace.
> + *
> + * DP definitions come from the DP v2.0 spec
> + * HDMI definitions come from the CTA-861-H spec
> + *
> + * @DRM_MODE_COLORIMETRY_DEFAULT:
> + *   Driver specific behavior.
> + * @DRM_MODE_COLORIMETRY_NO_DATA:
> + *   Driver specific behavior.

TBH this is still confusing me. Is DEFAULT really just driver specific
behavior? What's the difference to NO_DATA? Is NO_DATA actually not
driver-specific but display-specific? I.e. the default colorimetry of
the display?

> + * @DRM_MODE_COLORIMETRY_SMPTE_170M_YCC:
> + *   (HDMI)
> + *   SMPTE ST 170M colorimetry format
> + * @DRM_MODE_COLORIMETRY_BT709_YCC:
> + *   (HDMI, DP)
> + *   ITU-R BT.709 colorimetry format
> + * @DRM_MODE_COLORIMETRY_XVYCC_601:
> + *   (HDMI, DP)
> + *   xvYCC601 colorimetry format
> + * @DRM_MODE_COLORIMETRY_XVYCC_709:
> + *   (HDMI, DP)
> + *   xvYCC709 colorimetry format
> + * @DRM_MODE_COLORIMETRY_SYCC_601:
> + *   (HDMI, DP)
> + *   sYCC601 colorimetry format
> + * @DRM_MODE_COLORIMETRY_OPYCC_601:
> + *   (HDMI, DP)
> + *   opYCC601 colorimetry format
> + * @DRM_MODE_COLORIMETRY_OPRGB:
> + *   (HDMI, DP)
> + *   opRGB colorimetry format
> + * @DRM_MODE_COLORIMETRY_BT2020_CYCC:
> + *   (HDMI, DP)
> + *   ITU-R BT.2020 Y'c C'bc C'rc (constant luminance) colorimetry format
> + * @DRM_MODE_COLORIMETRY_BT2020_RGB:
> + *   (HDMI, DP)
> + *   ITU-R BT.2020 R' G' B' colorimetry format
> + * @DRM_MODE_COLORIMETRY_BT2020_YCC:
> + *   (HDMI, DP)
> + *   ITU-R BT.2020 Y' C'b C'r colorimetry format
> + * @DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
> + *   (HDMI)
> + *   SMPTE ST 2113 P3D65 colorimetry format
> + * @DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
> + *   (HDMI)
> + *   SMPTE ST 2113 P3DCI colorimetry format
> + * @DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED:
> + *   (DP)
> + *   RGB wide gamut fixed point colorimetry format
> + * @DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT:
> + *   (DP)
> + *   RGB wide gamut floating point
> + *   (scRGB (IEC 61966-2-2)) colorimetry format
> + * @DRM_MODE_COLORIMETRY_BT601_YCC:
> + *   (DP)
> + *   ITU-R BT.601 colorimetry format
> + *   The DP spec does not say whether this is the 525 or the 625
> + *   line version.
>   */
>  enum drm_colorspace {
>         /* For Default case, driver will set the colorspace */
> --
> 2.40.1
>

