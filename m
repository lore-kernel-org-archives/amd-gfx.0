Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E635C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 01:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98B82073A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 01:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvcP9DKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98B82073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F0B6E17E;
	Wed, 22 Jul 2020 01:13:20 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CBC6E12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 01:13:18 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a6so3290973wmm.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N47Wpgt3gPrfPQdyTSGckdTeYewjW+xuwIjnxTEAYOE=;
 b=jvcP9DKBnwcga/6wp3AFEinEcznS+YbK0b7l9TTxvE8oakefZHocjbEYIOMbpoFk+s
 yFIuUCFwniQeZag/QA4hVl8B9YVwqoidJYaxM1jNlyMpSur4bxWnkxZ1Prl0I+9iZx1h
 lFv5WJtXJMm3EEnGai1RCFwc1llNb/kZOJlfRDVJNJX4jqimFP2aMN69CLOsFUtb5aLl
 bqqjWyzooHMDkhkmn8wX0hX/zFSRBIjYf+xzvXiJrP3uhzz5Ab5+t4WJYKtNKkEJVQ0h
 0reUBQFqGgpt7Q7L7Qi31OLQTS9KodftL336UQNwxhxvIXE3PoIPsohttz+TiPxeTBEf
 cVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N47Wpgt3gPrfPQdyTSGckdTeYewjW+xuwIjnxTEAYOE=;
 b=Q0eHYaTQyCcn13G9r3+Rxi5h5G1tAEs8APwrYqVXVGjabthaNeaU8feHLy83ziuzJz
 AfFjrJTX5pvAaJ4ZPqg+cOIHS/n7p2O7OFXowQcPs3Wsr3ZyNu2/HjqBBzqbAfg62kdc
 5v4DPx+pItUbikFf1op40I35S8KD1WM0LnHdF4rIC/x5/1sCSBcYXu+aMXL1ak/zWiNM
 FvZvLSG9Gj7HDMfH5/PzyS1s0zULxbw0/pV4fajoy2HE3HUiJjDZfQC0rhw0nZ9SDgTW
 uz3fLBodzK/yQUJlRu2jZAQj+kfMVs5kCaWpX80fnBaXkOWLb3dopBaJkeOVVHXWueLj
 am3A==
X-Gm-Message-State: AOAM531jCVYVaXaKGXeIacMmzjNgyv5X10bdj/s1gi2/Q0nWKZWfqjjQ
 7BwgtURTjkN0NHeIJ/DmSg3kBT8xI9WKMMNYGRmu5g==
X-Google-Smtp-Source: ABdhPJwc7bRjXF4yT1d69qr63i2Drf89F6stvbE+oiEG77u6SOOqVUyY6ChKVTlGI9wxkbhDuIrrfPoNXJyfPhtsVOQ=
X-Received: by 2002:a1c:5ac3:: with SMTP id o186mr6221683wmb.39.1595380397486; 
 Tue, 21 Jul 2020 18:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
 <1595327359-120379-6-git-send-email-ray.huang@amd.com>
In-Reply-To: <1595327359-120379-6-git-send-email-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jul 2020 21:13:06 -0400
Message-ID: <CADnq5_PiQtJcjAd=GhHWA6-yKKO-BGkex1hwXXWsnhHkjaLk_A@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: won't include gc and mmhub register
 headers in GMC block
To: Huang Rui <ray.huang@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jul 21, 2020 at 6:29 AM Huang Rui <ray.huang@amd.com> wrote:
>
> All gc/mmhub register access and operation should be in gfxhub/mmhub level.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a1798ec2..19051ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -28,8 +28,6 @@
>
>  #include "hdp/hdp_5_0_0_offset.h"
>  #include "hdp/hdp_5_0_0_sh_mask.h"
> -#include "gc/gc_10_1_0_sh_mask.h"
> -#include "mmhub/mmhub_2_0_0_sh_mask.h"
>  #include "athub/athub_2_0_0_sh_mask.h"
>  #include "athub/athub_2_0_0_offset.h"
>  #include "dcn/dcn_2_0_0_offset.h"
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
