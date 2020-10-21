Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE47C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 13:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A8D22249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 13:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwZuNRSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A8D22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0615C8800A;
	Wed, 21 Oct 2020 13:01:59 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000CA8800A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 13:01:57 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id n6so2909788wrm.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hRGgJ7P3zUo8UFMOyzuXDssyEMJD/L72WwV2dWHJKn0=;
 b=uwZuNRSjNJYEALzmdTssmIzH0ZR7F6gp1PhZ4nN3E8iKZ0tcPLr3l96Rp5S3XEWKtK
 HwjCnoH5qCKFPzLKOtZTEUo1j8RWx2lCs9PXpa0ZDr7xELygvEaA5GsgoYrYJdBKPCHo
 1/y3DDHMguBsxqjK5MeHTOxZrMI3wj2wl5QtyFfCbVht5BGvFKsoidZS67JP2AwtIZ8U
 PoaevKnlsf8F3H1SCELnk2SZZc+zoAens9hnanB8Pu+Bn0u3/ZCUpmt39MN4CesBI8Qv
 BDSTbefOkmJXA7CA/I2Nnvv6TllAjbVzZbmCrkRkl46fFbtagphOwnczLPaOXygJSCoj
 LjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hRGgJ7P3zUo8UFMOyzuXDssyEMJD/L72WwV2dWHJKn0=;
 b=bAC9HHkQImCRwum2UwBoGPmxz4ueBtkxvaEfT4/3sJ8266Wn6hibaInv4t6lh5eulT
 oIokjNM/n3veR29JYrGPaCNWA1q+ofafaNdO3JjqgRc2i7rUs7o2PQKU0lx9B2WP+dK1
 skJQRM5eXBCkUbMs3Qp1By7m/CkaX+vOyja0OI8vt38Ry1ty7bqd62hRQFJLZ+WqwrQ9
 AOrdMXV+Z0SRrIUcJpVTL9WPeIcErc1ChTiTiQsGu87cJO/EksirnCeIpYqtwVDI3Thk
 3hBjqh/DG0wR1y12IYox0/H7+xeQTlclrwQgwddlJLwmCZWyhX0dETTLm1Wk1h4k4Wrk
 INQA==
X-Gm-Message-State: AOAM5309S0KBuolCj9hd5cIcLJhl84Noz1sGXEN2vkAYDLds88QJOUqi
 KoNLl8bRO12ZRkQDcZUYS4e8n6mWx7s2Q5VqNs8hvHzX
X-Google-Smtp-Source: ABdhPJw7FH7Q87j1I2qJ/fGlIjgX38uAeUB3hL0jLjpPOouvGJy9V3rv2La1aXn7MuKMlOxjJ1TDLcV0LKKuGkmaVyg=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr4585216wrn.362.1603285316577; 
 Wed, 21 Oct 2020 06:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201021064455.14935-1-kenneth.feng@amd.com>
In-Reply-To: <20201021064455.14935-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 09:01:45 -0400
Message-ID: <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: Likun Gao <likun.gao@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> fix the wrong fan speed in fan1_input when the fan control mode is manual.
> the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> since the fan speed in the metrics table always reflects the real fan speed,we
> can fetch the fan speed for both auto and manual mode.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

NACK.  At least on the navi boards I have, the metrics table fan speed
reads back 0 when the fan is in manual mode.  That's why I changed
this in the first place.

Alex


> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 496abc31b07e..27b6cade9ade 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
>         if (!speed)
>                 return -EINVAL;
>
> -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> -       case AMD_FAN_CTRL_AUTO:
> -               return sienna_cichlid_get_smu_metrics_data(smu,
> -                                                          METRICS_CURR_FANSPEED,
> -                                                          speed);
> -       default:
> -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> -       }
> +       return sienna_cichlid_get_smu_metrics_data(smu,
> +                                               METRICS_CURR_FANSPEED,
> +                                               speed);
>  }
>
>  static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
