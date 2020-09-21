Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE6C46466
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179F2216C4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6yLcsoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179F2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2878828E;
	Mon, 21 Sep 2020 19:30:58 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1547B6E532;
 Mon, 21 Sep 2020 19:30:57 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id s12so14016585wrw.11;
 Mon, 21 Sep 2020 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MG5GeuWsQTyPF2iATQLYUVJQWCXYJxETCbv2BxD/ONg=;
 b=P6yLcsoz2LpsjDOE8gTegsB2wajcD/ezKZ+8GmFofaTZyH7j7FJvN3PoFSLwbIIuf8
 x9YW0gOnctd2n/AlxOe8gcT3uOnoSu4KEyFL4fiTDUHcn1HEXrKDsvcoa+39QaVJ+LvL
 beXnLt7QYRHHlhgx9JZkOjQYHKiu7k6xfVKJ5KnixMs1D96DTLtaXlAcYWW23HAm8O+1
 rX0W9GTHZcL8x/7LfspOIjmD3+s6fJlpV8RYwPmrV0ShQLnXNY7XxgpUITNxEe1vaLDU
 lAStgGa9vWH19vvqFrwa7HHWEYrLKW9xqjFYQM63tXyz7/6SWqvkD1iTNdJXGFeneJdo
 adKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MG5GeuWsQTyPF2iATQLYUVJQWCXYJxETCbv2BxD/ONg=;
 b=HToglK1r8+dpRtV/CfEzFsCqwUEhSyFTYjHPP14Ufwos/U0EOuorchyYU1gMs21s3M
 8EusF7qfPuZKPkJsDuxQoPODSIy+rMkk4fft+CprEPhfr5BpH4wVQtQe0rHDlKtT3WQ0
 DQJ3j9R6rN7jmp/RrHXn9nEXxCl2VaYbxsSfWhKEPfP2+JU2DYefxerqu1DEwwnVBkeg
 edyE961WLpp69TdYZOeAMM3+gEt9B3HdEc8nMybtd3n1EMNCTWXcN0smI//v0qDpurj8
 4vSb5bvv3myJgzCJwpVqLdqRJ78H/lF9rrtNewAL4w3KNVWsa0aYHR8QFzQ7kkmX7Dit
 w7TA==
X-Gm-Message-State: AOAM533+4BWckUinlYjm/tPy+55CgnC9USAsjmjBV/dFL4FXOgCubYiU
 vIYjwygvMI3T8NafW4vdm/s+lW/pXRBMtkXqeB0dzXsV
X-Google-Smtp-Source: ABdhPJzpMRT+ByT30Axa4Ty74Ac4xlaFFz/Ka6NEYDah9H69c7vzyyTUyCQgjosQ+WdgTYc+fKmhSZ/tZqIjOCt5mKs=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr1391164wru.374.1600716655805; 
 Mon, 21 Sep 2020 12:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200921082430.2591201-1-liushixin2@huawei.com>
In-Reply-To: <20200921082430.2591201-1-liushixin2@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2020 15:30:44 -0400
Message-ID: <CADnq5_MjgpEeZgv3FL9f1TvQCuEvfi_xhV9=Lu5A+Q_yLBuYdQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/pm: simplify the return expression of
 smu_hw_fini
To: Liu Shixin <liushixin2@huawei.com>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Sep 21, 2020 at 9:14 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5c4b74f964fc..3612841d40dc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1214,7 +1214,6 @@ static int smu_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct smu_context *smu = &adev->smu;
> -       int ret = 0;
>
>         if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>                 return 0;
> @@ -1230,11 +1229,7 @@ static int smu_hw_fini(void *handle)
>
>         adev->pm.dpm_enabled = false;
>
> -       ret = smu_smc_hw_cleanup(smu);
> -       if (ret)
> -               return ret;
> -
> -       return 0;
> +       return smu_smc_hw_cleanup(smu);
>  }
>
>  int smu_reset(struct smu_context *smu)
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
