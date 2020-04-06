Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9436C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BD9206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lam/1grr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BD9206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFD86E0E4;
	Mon,  6 Apr 2020 18:46:36 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36666E0E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 18:46:34 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id g3so759097wrx.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=388T3NwWgOT/KpUPiUzaRRcNGATTN/hIO/oSvDWa34g=;
 b=Lam/1grrGnDaydLRW5F+WL9wK7v4cR1g2F1LBDABbJSrCTd1zPi3xKcxhncr0H+BHm
 XISTSD2G00ILDwbxqlJmWl6XvXIK5HORKoU5TVzBU+y0edjINqazAxA/KCYkLqsXK6HE
 qwS/lPMgzitTmcdJu+K4co4DysU8aQaVJocoYGxStLBHJ3NtNJ7rWCc2gNZCqHgzZcGC
 QSkNiyBC8HAdJnmIZjEdYZ0+40tckPTVyamjYic14MqfQfpxYu+QqVHApGsWczjvsxnR
 97LDnSdFf1FkeTNFymLqyKDsJBJAA+I7cg5KUOroHQCsiNq1TT/hEGUDgZc5lXN253fV
 i+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=388T3NwWgOT/KpUPiUzaRRcNGATTN/hIO/oSvDWa34g=;
 b=lBGwBQCF0UoDL5xl+KRPP29DCQSDVycU5AgeHcpXrmlT//H065mkpmSXdKSiVWB7zY
 R/9ouEbue+H09J8BquqyWayQczYzU2I78z/KYbO6o8GOmvCizU9kI2hE2rQ9JwzMDPjD
 nH4bv5h4sSFqK9IN9+jNu8HQEkui8VQp5TfOwlQb61py//cjPzK+wSCpr9BNAmSqhhg3
 +qFqnfiINPejp6oEe5kEdQGRFKDA/kZDLkRbek1BwnbXvRl6lZG/ydJSLT8glgJhexQH
 vFcX4y0Jnxz/INp05C9sRqlirH5BGYAEzmhI/Im1dqmFzH5SE4GnoM6D3bAEZ0QgJ1XM
 0ckQ==
X-Gm-Message-State: AGi0Pubv6wmuhyWr+kHjxuQCD0Qe7jVgZdXYDf4HXO5xsEtPoXCVcEWh
 6Hwas5pWOHmHpeJC8LSbcOYFKs3LYd6+p8gL/vONHA==
X-Google-Smtp-Source: APiQypLOxg3kpmE63F4LEJeNqvA29W9P/0cALTuRImUqH70qBwlI00kHaMq3fJuhZztnXjkZvlo3ZTiGT9RFlR0GJiU=
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr620820wrt.362.1586198793309; 
 Mon, 06 Apr 2020 11:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <1586194947-13405-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1586194947-13405-1-git-send-email-Oak.Zeng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Apr 2020 14:46:21 -0400
Message-ID: <CADnq5_Pxhy9sjxEPZp3gTsVhEcYL7DbrRJ1ATMk21Wq4wcQ+Cg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Print UTCL2 client ID on a gpuvm fault
To: Oak Zeng <Oak.Zeng@amd.com>
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

On Mon, Apr 6, 2020 at 1:42 PM Oak Zeng <Oak.Zeng@amd.com> wrote:
>
> UTCL2 client ID is useful information to get which
> UTCL2 client caused the gpuvm fault. Print it out
> for debug purpose
>
> Change-Id: I733d0127b0ee53aa788f194cefa53cbb55b49c11
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 78d769e..94a6096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -170,6 +170,9 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>                         dev_err(adev->dev,
>                                 "GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>                                 status);
> +                       dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> +                               REG_GET_FIELD(status,
> +                               GCVM_L2_PROTECTION_FAULT_STATUS, CID));
>                         dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>                                 REG_GET_FIELD(status,
>                                 GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 8606f87..fecdbc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -362,6 +362,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>                         dev_err(adev->dev,
>                                 "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>                                 status);
> +                       dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> +                               REG_GET_FIELD(status,
> +                               VM_L2_PROTECTION_FAULT_STATUS, CID));
>                         dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>                                 REG_GET_FIELD(status,
>                                 VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
