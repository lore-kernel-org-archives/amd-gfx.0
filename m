Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F67C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 20:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A2B10E011;
	Mon, 23 Jan 2023 20:31:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B297710E55C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 20:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674505859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvUFT3kV4hOrH8BWbPQYPcqX1gmhS+oL3sA9caAYEgg=;
 b=YcYGWEDqXxqn379VJkaQD9lq9GSCdp5DlF60VhGGci4yxIvPXmSq0NLc8Q2ZurkiZwyRKC
 ZWsn9Zd3kqKp71K3lHjQOYUpX6gapPGz/A5vvt7dRh10706wWce1yRT+Rl/XjCD+YJqfxH
 py0m/+pNiPZAa7ONG+OqRM1LSZo26Tk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-CKdOrymTONm5peajVBCt1A-1; Mon, 23 Jan 2023 15:30:58 -0500
X-MC-Unique: CKdOrymTONm5peajVBCt1A-1
Received: by mail-lj1-f199.google.com with SMTP id
 bx38-20020a05651c19a600b0028bcbe5dd69so2153461ljb.21
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 12:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uvUFT3kV4hOrH8BWbPQYPcqX1gmhS+oL3sA9caAYEgg=;
 b=AVvJ8RUkGxIAkiLmw7vrrpX6IrUA2fGc7Fg5EfgnahH2ai3fXBZe3b9KPitiVuV9w+
 x9Y73eBHOx1JvgUn9xSa7U0KT3DqZ60dhlwNHyJYU5zIAd5E43Nno8OvAAYbe5y3AzgU
 ZvaK43PxadckRNKASd1WGDR0VvjLwK1v8Y7kRvvPZDawtHIbS8X1a1NSde6Vt5M4lZby
 +VMhs0DAtBU81Fvyp/7wN5rz+BJ1ea1TuxIcbSKSSsAfKVqL6pfPR0TYLWBHvZIfUdJc
 KeQlW2baaqMuJfpySALyz2W6s+CI/45sMLrjogFeKiX5jVm+cfG9nGy6O6kxMREWWiCH
 kf6Q==
X-Gm-Message-State: AFqh2krzfn+3F4c/Et1L7dbhQ2iDFEK5G6ihcdscb6aNi4KydBovtfJ0
 Yz1BQKu5RWla/jI8HdCXxRc4SBPwfJsg5MZ1cxYY5LkB9I0vVWabdYcoI06lsXpfN390yCk4car
 fvB1+kbXsJDHhtCulJ60qi+nNpUIzdjR4Bos9LjzahQ==
X-Received: by 2002:ac2:5451:0:b0:4cc:971c:b3f6 with SMTP id
 d17-20020ac25451000000b004cc971cb3f6mr2729376lfn.77.1674505856607; 
 Mon, 23 Jan 2023 12:30:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsFYBYAL9y60IeorNFy250ZZasB8/QgVaF6tMPDxWwgf8FxW/qYJrUCfop49dKr4nz/GHs7XtNBQms1GfDA7DM=
X-Received: by 2002:ac2:5451:0:b0:4cc:971c:b3f6 with SMTP id
 d17-20020ac25451000000b004cc971cb3f6mr2729373lfn.77.1674505856429; Mon, 23
 Jan 2023 12:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20230113162428.33874-1-harry.wentland@amd.com>
 <20230113162428.33874-19-harry.wentland@amd.com>
In-Reply-To: <20230113162428.33874-19-harry.wentland@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Mon, 23 Jan 2023 21:30:45 +0100
Message-ID: <CA+hFU4xHKNSWO21Swq_b2VPPxtYGdeo4e3rPEVo44OPmB+opZw@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] drm/amd/display: Fallback to 2020_YCBCR if the
 pixel encoding is not RGB
To: Harry Wentland <harry.wentland@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

A new property to control YCC and subsampling would be the more
complete path here. If we actually want to fix this in the short-term
though, we should handle the YCC and RGB Colorspace values as
equivalent, everywhere. Technically we're breaking the user space API
here so it should be documented on the KMS property and other drivers
must be adjusted accordingly as well.

On Fri, Jan 13, 2023 at 5:26 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> From: Joshua Ashton <joshua@froggi.es>
>
> Userspace might not aware whether we're sending RGB or YCbCr
> data to the display. If COLOR_SPACE_2020_RGB_FULLRANGE is
> requested but the output encoding is YCbCr we should
> send COLOR_SPACE_2020_YCBCR.
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Sebastian Wick <sebastian.wick@redhat.com>
> Cc: Vitaly.Prosyak@amd.com
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: dri-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f74b125af31f..16940ea61b59 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5184,7 +5184,10 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
>                 color_space = COLOR_SPACE_ADOBERGB;
>                 break;
>         case DRM_MODE_COLORIMETRY_BT2020_RGB:
> -               color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
> +               if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB)
> +                       color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
> +               else
> +                       color_space = COLOR_SPACE_2020_YCBCR;
>                 break;
>         case DRM_MODE_COLORIMETRY_BT2020_YCC:
>                 color_space = COLOR_SPACE_2020_YCBCR;
> --
> 2.39.0
>

