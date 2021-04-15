Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DEEC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DBD61073
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DBD61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFDD6EA81;
	Thu, 15 Apr 2021 16:20:30 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1A26EA7F;
 Thu, 15 Apr 2021 16:20:28 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 t140-20020a4a3e920000b02901e5c1add773so4263521oot.1; 
 Thu, 15 Apr 2021 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4wy9+FSYsHBNYRRKB8rjo0Aurqevxrj+BEYYslbcwfQ=;
 b=cBcAin6sml73IfOxqihWogeWPV+X/rC4KvlNxcRfdFy3+vfft12MtwmdPItF0gvDXe
 5DulcxJe8LzdfYVHy3xPIXtjqyEhs1EjzWnY5dJVf1ALw0jhKPGHF44LXveEBpVaQb9j
 nxNhNW+IVe4x0/ngrTkjzjbJQ3UrwOJlP/iavPuKafuK+g7cS77VXCjNeBkndEn8lfgH
 fiiy+MF008A0ShNEKPD9lthEkDj+tTjzyS4tw5fwLEPo8XrIJM90vK/CXQDjvo/58AoJ
 lLtEVEm3st1DTgV7nXBSmNzut4IStBQvg/cHzqXK62fzbUekA7uS8nwrNsg9GCx7sLkd
 n5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4wy9+FSYsHBNYRRKB8rjo0Aurqevxrj+BEYYslbcwfQ=;
 b=OhNgxPS5I9eWj9ISxLUIBODLbPygFt2Uji9P4y0DB5M2JJU3WuX+OyHcGfpCq5BvBE
 IwNBOrw0fLnLxUsHK4VhrQYugFnzGSG4sFqgdRaRVE5meMSplCcxThoIFl+OCsahm+sQ
 RNl5d6pb+QoQeNuYXFYDULhZHF2+WpbGEQAxNkEh7Ga4p2evRHLny0DWlefMlS8SDLK5
 soF3oxDtNbXeevoLDrO8OcQuCLrCIVW2YUwluNJe3+jZytn7MNza1oAn3FZomJblKKdq
 8T80ZLFY4tlpJnZdycTeONEPCKQjg/XX1WM85CAkxoVnEfvlZ6NYe0BVqsvk+3rWXF+4
 vB8A==
X-Gm-Message-State: AOAM532Dkr1+1OjGyYbgtbJoFpl4VRDEVEoFkuPBCGRD9bpxvufD/ekR
 xusD8o6VwB8yh796G7wvDVXJSuNq9WuLt7a184A=
X-Google-Smtp-Source: ABdhPJxS3N09Snz488dSxKq8qMJh5tRsGiKdDxpn2eYSpvVMwBt2NmG+/+tHw6cbDHAW8x2kFyAY7enUtwmSLN0amYg=
X-Received: by 2002:a4a:2410:: with SMTP id m16mr3241288oof.90.1618503628040; 
 Thu, 15 Apr 2021 09:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <1618284379-28126-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1618284379-28126-1-git-send-email-tiantao6@hisilicon.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Apr 2021 12:20:16 -0400
Message-ID: <CADnq5_M-236qN22kyypzVDvOj0RnFLegqoiTkSFuquqe6o0JYg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/cik: remove set but not used variables
To: Tian Tao <tiantao6@hisilicon.com>
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
Cc: Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 12, 2021 at 11:26 PM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The value of pipe_id and queue_id  are not used under certain
> circumstances, so just delete.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/cik.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index 8b7a4f7..42a8afa 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -7948,8 +7948,6 @@ int cik_irq_process(struct radeon_device *rdev)
>                         DRM_ERROR("Illegal register access in command stream\n");
>                         /* XXX check the bitfield order! */
>                         me_id = (ring_id & 0x60) >> 5;
> -                       pipe_id = (ring_id & 0x18) >> 3;
> -                       queue_id = (ring_id & 0x7) >> 0;
>                         switch (me_id) {
>                         case 0:
>                                 /* This results in a full GPU reset, but all we need to do is soft
> @@ -7971,8 +7969,6 @@ int cik_irq_process(struct radeon_device *rdev)
>                         DRM_ERROR("Illegal instruction in command stream\n");
>                         /* XXX check the bitfield order! */
>                         me_id = (ring_id & 0x60) >> 5;
> -                       pipe_id = (ring_id & 0x18) >> 3;
> -                       queue_id = (ring_id & 0x7) >> 0;
>                         switch (me_id) {
>                         case 0:
>                                 /* This results in a full GPU reset, but all we need to do is soft
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
