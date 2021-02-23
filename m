Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844FAC433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1AB64DF3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1AB64DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81D56E9E5;
	Tue, 23 Feb 2021 16:02:38 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083816E9E3;
 Tue, 23 Feb 2021 16:02:38 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id o3so8365544oic.8;
 Tue, 23 Feb 2021 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0nFz5QhW8arftbgT3SWdBqbURvYJyjSvDbhJ1gX4x0g=;
 b=sz6ezuyCXhfV/E1P7Z3gnV1MOYt49cCtFkxa3maFn7AL5HNGvbjxsfadhRHEmk8JYm
 D0gw1Xrya+1uKg8Jy6aXEbl2j56hAuQRnZlDGYB2yIcSyIqdkcmut7iLapSn9Mq70/cn
 uuzyPXlRUW7St3AmQLFS8udta7spyQGw4Ddqu1Rgj8B9ZYZEhCvLmkGHEWwqvqrzD+AY
 R8L14GujAQKJRmWaYPxu6xShaRS79JONObXiPSrYi0VFUSx2wvSJhWUnCBgmlyRhbm3u
 ko74yCKzxSTkfjjDpQcZ1eiWH9C7gGJo+BAwWU7WYLIRY5b0klifDu9M5voefGhCGJbP
 ZzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0nFz5QhW8arftbgT3SWdBqbURvYJyjSvDbhJ1gX4x0g=;
 b=VrP+8eht0blq3iBWBtCSkXG5SsCGQdC7TCRNSqnU0W6qMS+erBC1fEdkazmEAQFXak
 jS5lrmreAzqnV9F+YSRBfTdxv2feo4quVcUzMidced7+wMvuMQXXeMlQY3NivWAJuHUZ
 9k8v8bxelUoSl8mobH/7weS/JjKvYd9mI3m6XHGFbAOd2eTtFZL4UEmmdjZWkTatJ9JW
 lZkMO23M1fPgIByxfb2YcirMXBJfkS3OUKnoU6Ckvz/Z6YmfkRBoE+qxUjxtW8YYJTCb
 I4YyakyNB/YRcwg/pIjQnOdbt/OgkgvJcLsoZtGhBsbrS+cVH6881KRijN4rVwbp8Iei
 /eJw==
X-Gm-Message-State: AOAM533B/MR6T5peqbb/+ggaa48k/rOJdg0HIYHh2whyKnodMSYR3jY/
 hl87g97kl3imsVgzxL1ebJGvm7c8UcedkICiK8o=
X-Google-Smtp-Source: ABdhPJxmRs41X61fR0MbTZ0+qV+vk94HD/0G9VbbyJscORKHNJlkHtV/VBwBeaoaIb+Fll1VtcrRc/Ph2wjvDoJOj0g=
X-Received: by 2002:aca:f485:: with SMTP id s127mr7051770oih.120.1614096157412; 
 Tue, 23 Feb 2021 08:02:37 -0800 (PST)
MIME-Version: 1.0
References: <1614060797-124965-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614060797-124965-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Feb 2021 11:02:26 -0500
Message-ID: <CADnq5_O24kGLYBLN6Zzv-n_NNUhXkGs-vkWEnW2FYH3-GT9=Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was already fixed by a patch from Yang Li <yang.lee@linux.alibaba.com>.

Alex

On Tue, Feb 23, 2021 at 1:13 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:8260:16-21: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 94cd5dd..323473d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8253,8 +8253,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         hdcp_update_display(
>                                 adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
>                                 new_con_state->hdcp_content_type,
> -                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED ? true
> -                                                                                                        : false);
> +                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
>         }
>  #endif
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
