Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA37C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4A261165
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B4A261165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67F36EA7A;
	Wed, 13 Oct 2021 18:21:24 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98ED66EA7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 18:21:23 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id u69so5032840oie.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fR/SUijdUJWtDRcZQQ0j2OvvyB27M09prKwAn1mE2x4=;
 b=GbgfflEMdEDHaQYtf+xEt4jnpSu1t7OMqjg93UnTetZnmMUVp6y3W00IQWf1hE0Rr2
 Bdo/IWtZwBEennIg0d9nA4T0L0pupEjtCQhvFDkXVv4SzICPHCpCNbqvqCgGNZlHQH5R
 2Jj9I2IrW2VE+dS7YBzGcW30I16zc/3rbwQRv11STQ5nr7BsSyLJUdrMonlVWFuWjZyh
 uAZ0dq9ARVadSll9faR8kzsiaxPZBwte7vpSCClxnA+sJZ/G+Sn4BWKE2HEsk4YOYgzE
 TWjGNmnX/v1h/+RGyw0rpdAWOZGzPSegfTjnWyWPfwOcjH6CQfCvbgWX5R7OmcPC0zNl
 9wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fR/SUijdUJWtDRcZQQ0j2OvvyB27M09prKwAn1mE2x4=;
 b=zW/1ggI1HwGWw8w1g5C1mhSoiZbnxm/+tbyk72clKcPDRdGHqUyVrQsMAegKGCVdub
 NknrGWRrGiIst9inIigW/Jze2ltsHfKVheuY+68sKcjIi885zRFlzlxGs9nr6O71AkNi
 CVJjt8rrnRyRncAtXmt5Hf56Mt+vaxIWBTEKqkE69Ij8KNgI0/vVB9u42vqn1KQFk742
 K21gWntm5yYNDm2MJIqfMVf9h5UrCtdxALhMTC9W+0LSGdW4AKoisYhQQPa2zvO1OVqL
 t/V7nayzIeYk63gBqEL5ZAYuo+STdvbeox2m/IrfCdlZzoybD7LiL0j81DJTthJSz8K8
 Kryw==
X-Gm-Message-State: AOAM531JIVAJ97k1tDnhqN3XtH3vLRJcu03ujtVHP5PM0zKovoZvK5OW
 3rNaWAUXnOKNdmBunvjzETGFO0Vvu4wC3QQXbQQTlqZmwtI=
X-Google-Smtp-Source: ABdhPJwyB0t9UOWh/MKsc0gRBIvFjJAxTGujw/YR1pYFqr6wHwDHDKLLTnyl+Sb6Nr9c2xM4UhvGdfWiOYcj5WUCUPQ=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr891855oia.5.1634149282880;
 Wed, 13 Oct 2021 11:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211012164003.1073534-1-alexander.deucher@amd.com>
In-Reply-To: <20211012164003.1073534-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 14:21:11 -0400
Message-ID: <CADnq5_ObgJatqyLdS=4HLre26OM_KpZ_kLvcJJUDB2DAaQL20g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: fix typo in
 gfx_v10_0_update_gfx_clock_gating()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping.

On Tue, Oct 12, 2021 at 12:40 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Check was incorrectly converted to IP version checking.
>
> Fixes: 4b0ad8425498ba ("drm/amdgpu/gfx10: convert to IP version checking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 71bb3c0dc1da..8cec03949835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8238,8 +8238,9 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>                 /* ===  CGCG + CGLS === */
>                 gfx_v10_0_update_coarse_grain_clock_gating(adev, enable);
>
> -               if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 1, 10)) &&
> -                    (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(10, 1, 2)))
> +               if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 10)) ||
> +                   (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 1)) ||
> +                   (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 2)))
>                         gfx_v10_0_apply_medium_grain_clock_gating_workaround(adev);
>         } else {
>                 /* CGCG/CGLS should be disabled before MGCG/MGLS
> --
> 2.31.1
>
