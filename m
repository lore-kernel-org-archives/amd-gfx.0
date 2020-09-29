Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A63AC4727F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 19:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B5220774
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 19:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwgtrsWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B5220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E665689EEB;
	Tue, 29 Sep 2020 19:57:41 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672D689EEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 19:57:41 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id s13so5857069wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v3icdVVx36UcKjt+L/OFJQoguoxgW1N9LHsEudTtrzY=;
 b=HwgtrsWExWc7p+QyakyKqouMWwQoejgax6jgM73IWlov8e+Mme2lWONjmUOQVwu+Gb
 nBSC8J3m58fQe11qWtXtez5xewXqF5dWYWjm3EqkvBQFV45IBPr2zKwUhkttrHBftwIC
 rZ/fvnTbYDzxio/8ijR3ATm0K9bSWDabItuv/sZiuo0LWNA3tMbZbm8waZ7UrO7EIlnF
 /dta1vHThEDA5o3svWapX8qsMj3xtZL2uIn7xaVw1inXJtOC8St9GNsP/qaX6HUvLMbg
 3WZbROLg9Ek0YNdiCtSpEHI8XpYOc0LewERZO85wMuoAKLZQRhzfZ9lmNjeIuXKda0Xe
 Q8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v3icdVVx36UcKjt+L/OFJQoguoxgW1N9LHsEudTtrzY=;
 b=aHO6Wi/Xsjf1vJZYbkDiimQFfYd81bV1xwGIvX0PgCHIvAPnDpfrGsiJYKfXngWWNJ
 i8zlGJyECdORFKdCVUEEL3k/aEHa8jfJooyvVNF/AFi9znaA2SKZnOpZObEP9Q0CRhyB
 XQ9fS+Jz1P91+BecovmxjFn62+Oqbe5lLECsj6uWmDSQYKCnN3a75GdZT+bn5Nppee5r
 Nx5QIbUnqqcSDuk6mxUG/0jRmnOHsvb+5mf7DC5/m5PaTfYKraThOvvjX5dQZ7oWwOlU
 nnOi7vla8YR+l9ghq5y4B/sC31jvX4v4Ux9KPcrXXeIJ6/RlIkAlrEyMShEZvhmImQIx
 xyFQ==
X-Gm-Message-State: AOAM533jhY09pLxeeVd/SMJmXMpCje+/wH1BXPfwZonYiLeG9EFdyNEO
 kV13r3lu38qKUAOguDuNYUetn+MPq+r+fX6o/iE=
X-Google-Smtp-Source: ABdhPJyIrkdvqOQDVLT56eRwB90itYFMVh1ulObrVtkJOrdL2O09du1eMltpCJ5dUUe97T+fjuYeWESslo9eCHXrjgE=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr6385311wmh.56.1601409459985; 
 Tue, 29 Sep 2020 12:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200929172524.24857-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200929172524.24857-1-Ramesh.Errabolu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 15:57:28 -0400
Message-ID: <CADnq5_PXFGZ6jM2pMxhjSjgfd+XG5ONBdxDJydF-PK4b6sdfng@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amd/amdgpu: Clean up header file of symbols that
 are defined to be static
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 29, 2020 at 1:25 PM Ramesh Errabolu <Ramesh.Errabolu@amd.com> wrote:
>
> [Why]
> Header file exports functions get_gpu_clock_counter(), get_cu_info() and
> select_se_sh() that are defined to be static
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> index fa5a3fbaf6ab..407472031daa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> @@ -26,9 +26,4 @@
>
>  extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
>
> -void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num);
> -
> -uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -int gfx_v9_0_get_cu_info(struct amdgpu_device *adev, struct amdgpu_cu_info *cu_info);
> -
>  #endif
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
