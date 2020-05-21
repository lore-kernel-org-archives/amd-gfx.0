Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ABAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4041020748
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKq4Q4IG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4041020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7966E24D;
	Thu, 21 May 2020 14:16:51 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613BE6E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 14:16:50 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id w64so6504221wmg.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ABA71yUPgiCKzHH18HWOR721IXiIEUgsGk7LvEXLvcs=;
 b=uKq4Q4IGM5ozjEiexrxy5mpGwxO1WZYnjvwRd1Ak6uKCvavnVRh0HwdGSp3jV8kUZS
 c9NImCyIbV60RV3Uv2XVF1xpVfyog1xRh6VglY5AdPqCdVko4QxDmms/ZnGaAyj37Z07
 8lUMqx9fUu/45SE4Uo6cBF+cvIpUds4g3C5ddyUvjh0/uvc0oWIV76i2xnS/x6G3sBHV
 MbxhfS44Qw8EdS9PQeGfUekE2x1HEQ+CJ3dydH8dX27wic8w7NHTA5CIYwanRg/NjGnp
 /ZdmzNGCKkiqW7eS7uXqa5JVLv9LmfOfh6EdggQBgsUrQgBrx+/LSLv5XI9wYmFyPGJ2
 2+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ABA71yUPgiCKzHH18HWOR721IXiIEUgsGk7LvEXLvcs=;
 b=dh7JFPK+rXEQ/NibGxGJQYNTWVv831EWboeXfKDXkWaNIzpoiNyh3RLuuFas3eORjL
 v3wA7vVcDakQM1Hva9BawQEPB4Hx4JR/v2UN5gkcpoCmyXi3NMAOFrr1ADFu2vBtqOZX
 mQzq1N7eVYekVIwpGOc+dDCh+6gIoeDVVyWH1Ei61XDR4+X4UJDnCrnhnVUmPtxSVm8r
 6OMuvNaILuTr15KO78i7iuHgq/cpSatT45kDVCEhc/wqCm9Ys/DiWeowsMAFl6YW9KWP
 +32H4T3AxoL2xFFpo8wpXpnHmM1LUqATC8DY+OrlX3cPMcytK6BoxB8B/+8yI3ZF91VI
 K0fA==
X-Gm-Message-State: AOAM531Z07vIkqgbXod65Bek7k3QnIg3EN+BH4KmqVYZHAZaqLfrv8Mz
 JGGkkEe2IOTNPfnEIU7heKW+IVHx8bDaHsF9DEdx2Q==
X-Google-Smtp-Source: ABdhPJzrRPX8kZHy1OULWAs4A4NLWaWFJ/pLg0iuQ8lXkA8NmbyjxDOhrpxQqTNpRNY582VEXsWNAndapxAdzBuD8r4=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr9136652wmp.73.1590070608892; 
 Thu, 21 May 2020 07:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200519154426.1752937-1-alexander.deucher@amd.com>
In-Reply-To: <20200519154426.1752937-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 May 2020 10:16:37 -0400
Message-ID: <CADnq5_Pig-WxhqAb9tFWWRKj9Jo2_Ye-hj04XB6Udu7W=v-+PA@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu/sdma4: add renoir to powergating setup
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Tue, May 19, 2020 at 11:44 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Looks like renoir should be handled here as well.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>
> Can someone test this on renoir?
>
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 9077507b425a..a8cad03b1c42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2203,6 +2203,7 @@ static int sdma_v4_0_set_powergating_state(void *handle,
>
>         switch (adev->asic_type) {
>         case CHIP_RAVEN:
> +       case CHIP_RENOIR:
>                 sdma_v4_1_update_power_gating(adev,
>                                 state == AMD_PG_STATE_GATE ? true : false);
>                 break;
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
