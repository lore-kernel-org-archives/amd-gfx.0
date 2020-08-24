Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA8C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9042B20738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX/pMc4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9042B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA0B6E42F;
	Mon, 24 Aug 2020 18:25:00 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C206E42F;
 Mon, 24 Aug 2020 18:24:59 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id x9so5307683wmi.2;
 Mon, 24 Aug 2020 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2hiwcUAldWOxLPE0QEt1TJzuP3uTlNIL1ayfloIyJuE=;
 b=LX/pMc4tuxueVTZUNFnEsqWcy/297seMKrnwAiVYQcKPOmF2Y1f4IIB7TaywBV7vTb
 T4cPctqVmDKBXCc31bqo8ASLY2V6Ghpdedgw9cJGO234jXsM6qPZ7KzkrDrdLlGV6lRf
 9XaQ+F2xWgJXIFDsqlITYEdx7XJbpXqUMiAsLVvFk0AbsKHHOenzgUqYydrEJvNoamgu
 AouV+TiKwhRHVUMYw4jxz9p/zq+ZPIkoCGuY15YTrtTGRlbCOtx2Oi0SXObl7R2pHkMR
 fp9fJwuph0dUIsQy4B7vo8mZzCKj5jy4hrFRvmqAV0uVp1oKZMvLLBn0IMdqUw15+1jx
 0k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2hiwcUAldWOxLPE0QEt1TJzuP3uTlNIL1ayfloIyJuE=;
 b=iwqOmBwmo9CdUmOGD8TcIwp6IJBi1vh4QEfduxlzCeilsqZi8U9VZPchgQGTgs6lvZ
 ZgbizpYZwWMnk4Gl4o5fqo7J/3ye47EJaJdiyNJ4n/DBFfiA+SeHvf6ojbOP5CCOhGjd
 rb1RKg10N0AneFVKPHYjd6I7Pf5L5F3X8QuOrydIdz5iNW7wZpmqe8m8kioFld37pK1b
 zEc01qEO+hbTaTwtXTZZq+9fW/dfxYjk5+EUkCej2nk/14xvHUb3H4nHv5oIxWS76bVl
 D7LeAa5VFfnASDazfb6BaezRMzEaWmihcD/ktDZf1njTbvbK6lb/SFSEX+KSjp7chjK6
 3Pmg==
X-Gm-Message-State: AOAM5310TAf4cF6RW2dJkmUQKVgpq4qDIeGh9fseL3HWVKqqUXrgJXQW
 dWnZL5a7NV/QEP+7VQrYomVU0ZwCFO01vAmOSpIRG4jGrtI=
X-Google-Smtp-Source: ABdhPJy2iosbPkPwCaUj/E5XZyiLNj8lBukGOpjOjIZVDCrhZKhqjF3puLnKJGIISOuatmrsNB/X/OLJWaU6nNHkUyI=
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr506433wmj.79.1598293498317;
 Mon, 24 Aug 2020 11:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200824163634.606093-1-sashal@kernel.org>
 <20200824163634.606093-49-sashal@kernel.org>
In-Reply-To: <20200824163634.606093-49-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2020 14:24:47 -0400
Message-ID: <CADnq5_POu=q3LzKc3_77QNRZwYjO83c=WFHL1uj9rTHSj7j-ow@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.7 49/54] Revert "drm/amdgpu: disable gfxoff for
 navy_flounder"
To: Sasha Levin <sashal@kernel.org>
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
Cc: Tao Zhou <tao.zhou1@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Jiansong Chen <Jiansong.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 24, 2020 at 12:37 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Jiansong Chen <Jiansong.Chen@amd.com>
>
> [ Upstream commit da2446b66b5e2c7f3ab63912c8d999810e35e8b3 ]
>
> This reverts commit 9c9b17a7d19a8e21db2e378784fff1128b46c9d3.
> Newly released sdma fw (51.52) provides a fix for the issue.
>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Support for this chip does not exist in 5.7 or any other older trees.
Please drop this.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 8ee94f4b9b20f..ff94f756978d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -681,9 +681,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
>                 if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
>                         adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>                 break;
> -       case CHIP_NAVY_FLOUNDER:
> -               adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -               break;
>         default:
>                 break;
>         }
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
