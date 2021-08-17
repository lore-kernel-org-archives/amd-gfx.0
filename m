Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8BBC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 16:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9218F60EE5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 16:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9218F60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01166E1F2;
	Tue, 17 Aug 2021 16:02:20 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5676E1F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 16:02:14 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 c19-20020a9d6153000000b0051829acbfc7so10586817otk.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q/AcYGNvPN0wDD4LP/5GoUVhLw8rDEgf6NFeIC+rEMw=;
 b=qgbWcpcKGzZDM3FL8tv9aZRn8JNJG1m58JOJhrEeqagPrarVWKMp8oLZZQgmi7XSIW
 fuaN9IiaVUzI3zj65yw9Id/0R4HuirSkc15QNT1sl6TOaV9xOOR5ekWfk+F6+4/jqlc+
 b61GC8t1cR0AOchoswnj8sCj5ZfwEKi/PYyZfZXP9RhPygF4lYW0y1Y+iQKOR81UMLI+
 hIYUkuLpsu33f1tGIDb/D2E6vDRJdoNB4nCn4St5YCxd+Retdchzs4hYQ+7b4LuZ6blm
 icdAyWfLw5d6wAlhK59hGIJd86K3S1KJ3B5hwmt1xaZKVd52tbJsDr7LFPti4+kPNRCB
 1Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q/AcYGNvPN0wDD4LP/5GoUVhLw8rDEgf6NFeIC+rEMw=;
 b=SEtaVoKIKl2BB6gW+cRrIQxqHh+9x6asPZlRKrDLzoHXTe+ZjKXh4Wzd0LYwZkekke
 u6MPQj4TSJl1Fi5LoPyAwt20f3Cy8J/0XP5MaQEpBkiJvOhIRtgw0AFTfj43RXlvHiAl
 KBUKfwXW2gW9lgdrEkEajDeD654/B2QhIT4Wzp+XVivS+njqSZhkv7qhXMMEFtuFLHea
 X0HrhVGu7CPrwHwx0FTMX7/dBQdUGcLdQwcWgODIQ2iJAtLoDzSO6YOhUlFnPT4EZvmq
 6k6patnxRnqmIwVEPh0GJS5dnGbm0uELOmTAf/EXdQrUuvnFrOQkMmCEfrMT0aZRzxn3
 Twfg==
X-Gm-Message-State: AOAM531d9e3XvBx6M+jwjkJ6hbrw1DmxmeiljddhfwGbVM7Nz6MjqwhE
 /nY7WepiiHtU0D8PIrk79uqvBcaqLCbR0vc1fas=
X-Google-Smtp-Source: ABdhPJxUrHaeTZwHDpnyhZjYpVwUGVI9QSq9Wunjkf+FJo0QJ67lSTjeOkskATCQNoSs05zQg5SbiZXj58UVAPkkQ00=
X-Received: by 2002:a9d:5a15:: with SMTP id v21mr3329195oth.132.1629216132948; 
 Tue, 17 Aug 2021 09:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <1629174614-2218-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1629174614-2218-1-git-send-email-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Aug 2021 12:02:02 -0400
Message-ID: <CADnq5_OucuSDVxFMF0P+0KD_hV1PXOyZwY2HJoApjBf7mZkR5A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: increase max xgmi physical node for aldebaran
To: Hawking Zhang <Hawking.Zhang@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Aug 17, 2021 at 12:30 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> aldebaran supports up to 16 xgmi physical nodes.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: John Clements <john.clements@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
> index 8fca72e..497b86c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
> @@ -75,9 +75,8 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
>                 max_physical_node_id     = 7;
>                 break;
>         case CHIP_ALDEBARAN:
> -               /* just using duplicates for Aldebaran support, revisit later */
> -               max_num_physical_nodes   = 8;
> -               max_physical_node_id     = 7;
> +               max_num_physical_nodes   = 16;
> +               max_physical_node_id     = 15;
>                 break;
>         default:
>                 return -EINVAL;
> --
> 2.7.4
>
