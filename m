Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED7C6369E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 22:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8253020709
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 22:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8253020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DC06EB1A;
	Wed,  2 Dec 2020 22:21:49 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7306EB1A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 22:21:48 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id x16so90254oic.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Dec 2020 14:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K9IcPT9elW7IXGekB7OG9x+MANShRcligm+a+0R2g+s=;
 b=nSlkwZRBmyaqBQBoxGbj/hYZGCxqapjkm68qKfQzAoES9ZasuJIKzDzY8775+68iq3
 YaA87A5pvJVjDzry5X0oFInDmXHsys7gGYnEdgqx7fdlVhllRP9DjuGKZ5rCHEzhOPVj
 66Wgf1mP0ldQsT865Fp3aUcJD3f8lD91ZwqJqeTxatVTle3jphq4rnQFmjpufkMPhUZx
 OwFVGtXGHNq9Nlz9HoCs6dYlD2JLWBN0h0+RNz/qL6hmlWnIgpxqsUf6Ecjx5dbOUJ5+
 Cr0v4LLstre/s89PClJyymH5jfdop3XrHO/OmmCQT94PWSw79XDXeUCv1fb9B7Qzdxz9
 7ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K9IcPT9elW7IXGekB7OG9x+MANShRcligm+a+0R2g+s=;
 b=KwKU4Dd2kX/+odz/ta08ULuB3xCqibA8Gsa3MeTONlkvRyRcJ9waAAumHva7yWlCaf
 iGk1AnCUX731O2KxBrXQ9h3cpST5i5u6sSDLfzLGxgrGE9nFhIP1FukNKPmoi9aJTGJp
 0DdiMw9MmdRiQqwif/bVFF1dpx5goe8RFl3LDi3yA9ayNGvAX1Cju37njg8m7whTpZEi
 qLxJubQT2q3RzPRUM6iGeg80CNofm9Nsu3qLQmkBtVRYIzEOU1OjKZtr+wNW1afBNlX2
 sVpUoPGKp6scIcFNmtCVKQ68qStsYcrx++HXBZ9X2xtplt8NR3BKaPe3BC/RuotMPfJr
 FGTA==
X-Gm-Message-State: AOAM531DXvckgGYpMCbIRirqxW2XKvRFBcGCTDnxmNV/d8i6lGb1YAxE
 Qy2YcSSVPM1za+tGww6g33xGoccEQu8DQ5GmojI=
X-Google-Smtp-Source: ABdhPJyFp1v7q/RGz0Auf5TrDnNFpyrK398A2/YbHvqF+VzEyeEYg63mQcCzNwTQsqPXZmEik33auKSQE8RzI6piJzs=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr453398oib.123.1606947708085; 
 Wed, 02 Dec 2020 14:21:48 -0800 (PST)
MIME-Version: 1.0
References: <VGhcmyoWBxsf46kzlRFgLgfPcSdrSwiANl9PJpNE2o@cp4-web-038.plabs.ch>
In-Reply-To: <VGhcmyoWBxsf46kzlRFgLgfPcSdrSwiANl9PJpNE2o@cp4-web-038.plabs.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Dec 2020 17:21:36 -0500
Message-ID: <CADnq5_NdSMbDv-=Sf7TZekK=DhhNAmuT4kfkjKsuyCb-fMY8eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add debug logs for
 dm_crtc_helper_atomic_check
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 2, 2020 at 4:06 PM Simon Ser <contact@emersion.fr> wrote:
>
> Instead of silently failing the atomic check, explain what happened via
> a debug log. This makes it easier for user-space to figure out why
> something failed.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 862a59703060..313501cc39fc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6068,8 +6068,10 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
>          * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
>          */
>         if (crtc_state->enable &&
> -           !(crtc_state->plane_mask & drm_plane_mask(crtc->primary)))
> +           !(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
> +               DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
>                 return -EINVAL;
> +       }
>
>         /* In some use cases, like reset, no stream is attached */
>         if (!dm_crtc_state->stream)
> @@ -6078,6 +6080,7 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
>         if (dc_validate_stream(dc, dm_crtc_state->stream) == DC_OK)
>                 return 0;
>
> +       DRM_DEBUG_ATOMIC("Failed DC stream validation\n");
>         return ret;
>  }
>
> --
> 2.29.2
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
