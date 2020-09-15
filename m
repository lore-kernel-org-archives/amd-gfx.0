Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48430C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 19:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF75F206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 19:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pghfZgdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF75F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E7C6E8F1;
	Tue, 15 Sep 2020 19:00:16 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3836E8F1;
 Tue, 15 Sep 2020 19:00:15 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id e11so628000wme.0;
 Tue, 15 Sep 2020 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jbe6ZdGxEwcR9b8K0OVEiXqHGKm+h0uIzkdUkf9gYZY=;
 b=pghfZgdnq8jzq4Y9ctQ7O0/bHaLkehG1bO6eU160MqB/26LXMqmZ02GDPT5ezdRe5e
 MAkvtsbEUdm2eN7RMJQFwu7O7/iGzjKD6+aHT2gV0m7Co8/LxdI8dO440P3v4oKrQvDK
 AFK/P15dkXiNEjTcQ3tcbIhYgjzGMSWyR0EgGHTyt6Zap9pUqv7GYR0Y4Wo1mH7jI9YQ
 luMSDZv1mp3/KlxQOSYRPjzO2rFo5GhOpE2AyqGCWJvlS7S5wjiKCNGE2NFXiqpcumXV
 Afnhd/1SZW5/rImGmQ/PHjTwQ8TM8ITaJfrKM3DlcE08egSPLBaavcfHGEStftXi2hWi
 GEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jbe6ZdGxEwcR9b8K0OVEiXqHGKm+h0uIzkdUkf9gYZY=;
 b=VwljkxweY55ifHPV3u6YEfatzHjqZap1buNeIHQPaeOkNNCO1GsXIoV/+FChy6pvNh
 bpJ2IcencrqZN9gDjzPjFnHMj1ilPh4uHs8z+DRKTC69BX9Nh+gwll+KjPwQQB/am+5G
 V4hmqPvFcm5Wz/L0xS5fX96VH8U3NdX3Tl5xr2zEWOTRBwDaTcYikgcMcZI6/MItxDAA
 cfeba4teYOaXrVSFCdiqhWXrOaFgUtmCmL/ZGl79JMuSvmeDVmmbqCuQdBy9ptgnTiJ0
 rOy4vFK2VMIlqANqdTUni5SLRv3JmdC2ONVnENsQT5mHWEMNXQOzXtPYjv1qg5i1QxyS
 AkVg==
X-Gm-Message-State: AOAM5304YjwtCUeSRkmRpHjy6LipiYaGLk5GXUb5yMG8z4CmwDtfGxxM
 +Vw0WKZxQ5Ywd3N6cHC4/gYKOvrjIXjiHmb9e84=
X-Google-Smtp-Source: ABdhPJyljGcRfZpn6y481EWeKWChcjJq5SRsk2k7JhjzCh+4uKOhuKOaaAceyLB2dxwuOeEKhlHzqIlKZdCLg7ba1c0=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr785558wmi.79.1600196413885;
 Tue, 15 Sep 2020 12:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200908133552.105282-1-chenzhou10@huawei.com>
In-Reply-To: <20200908133552.105282-1-chenzhou10@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 15:00:03 -0400
Message-ID: <CADnq5_PfQKwGyuqtzCOUjvXdfQ8WkmeckaiqF2D5Wac+dmSG4A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Remove duplicate include
To: Chen Zhou <chenzhou10@huawei.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Sep 9, 2020 at 3:05 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index a5d750ed569e..65dc5dcd4eb8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -35,7 +35,6 @@
>  #include "dcn30_dpp.h"
>  #include "dcn10/dcn10_cm_common.h"
>  #include "dcn30_cm_common.h"
> -#include "clk_mgr.h"
>  #include "reg_helper.h"
>  #include "abm.h"
>  #include "clk_mgr.h"
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
