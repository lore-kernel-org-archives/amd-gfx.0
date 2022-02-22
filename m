Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE46C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 17:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7947F10E87B;
	Tue, 22 Feb 2022 17:00:33 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE8110E884
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 17:00:31 +0000 (UTC)
Received: by mail-vs1-xe2d.google.com with SMTP id i27so214753vsr.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6sP1NK5riMIw3zNvreRDIrU/33vAWANNYBoQxmshl2M=;
 b=U3khCcgraSsVCE1+vKH99n4PWILXdlertJHvYVgNjgPaTW4Fk4bGNB+M2vNCzIVnq6
 fv7r/jkB6RQBF3BwUBX6GfYibxj4GzlK39HBr9/5aAhhYHDujjYPsUbR5YK6H5muiq9V
 sKfv9W/JaJsKmRlKO/uoCELS709TrRYptv8VPzP7FemSqAYYaezIay6AaMb8i4gHofYj
 tj18I8Qe6OY/B0XndxYAIwA7l5Neq9M3KKlFtdQxsyLGte0Dk3C7YH6pDKYHnHxb2Rve
 8GDyfluvDEMq7qbSi8is5lIuL2wWnKJ3L3/kfB4mO7JS53dPCjMKqawedzhyQgIQQFFf
 ITrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6sP1NK5riMIw3zNvreRDIrU/33vAWANNYBoQxmshl2M=;
 b=nXYVUM9oWCkd9Qy4ThoA80vzu4vWSp8aZBs1hehCAeyUuodeqswLhLMrCGzlOYWyBm
 kCZa9hAHkPkBNIYyYVjcUQeWuVzXKHlrvM0s15/RWZxBkw/VBBHicp5qNwj8gtxKm6oy
 FywCg88IOThas1HuGzWS6hA6MMcEwTlxPE64ojk8qq5afTfvm53nUYbAhONs3RQG8pMg
 VG1ZfW4GtG6JjxtWZGfpJfaGjXadVvP7Z04ig+wNtvISR5slqS4LkWNsQ2PzwLU8y4BB
 b6xURql1Ap5YBrA1ULyj5WotQ+LgzzQp8Ri3066ve9bIWOsLZZ0Z+UnP86PzU+D4X2iV
 GRHw==
X-Gm-Message-State: AOAM530YXr+PdaX+HTyilBvCkymcVHcBXqEs+JwDHXUyg53rirdfu4bS
 kjyigTelksb7R5NgUZsg5N3KxA02qeLz9/qdvsk=
X-Google-Smtp-Source: ABdhPJy+vKCYUrE6fxKb0GN7U5PZkG+udo9DoYis94toXoUIJR9oZ4W1xJW430Aml8E96saZdR5HgrGitlucEIrxmtQ=
X-Received: by 2002:a67:db0c:0:b0:31c:2859:2ff2 with SMTP id
 z12-20020a67db0c000000b0031c28592ff2mr5490084vsj.29.1645549230612; Tue, 22
 Feb 2022 09:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20220222150731.16954-1-guchun.chen@amd.com>
In-Reply-To: <20220222150731.16954-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Feb 2022 12:00:19 -0500
Message-ID: <CADnq5_PRn-G0FC46Wh-8HJs=EL+hLNfYz=NNC-PGKosDrPXrsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 xinhui pan <xinhui.pan@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 22, 2022 at 10:07 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Due to faulty VBIOS out there, harvest bit setting is not
> consistently correct especially for display IP. So far,
> it's hard to work out a solution on all the legacy Navi1x
> ASICs in a short time, so to avoid regression, limit harvest
> bit read on several ASICs. Will revisit later once VBIOS has
> corrected it in long term.
>

Looks like it may be incorrect for VCN as well.  Double check that.

Alex


> Fixes: b3f4ea887d5f("drm/amdgpu: read harvest bit per IP data on legacy GPUs")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 11255290f117..2e0ff1ace6fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1129,12 +1129,20 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>          * so read harvest bit per IP data structure to set
>          * harvest configuration.
>          */
> -       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0))
> -               amdgpu_discovery_read_harvest_bit_per_ip(adev,
> -                                                       &vcn_harvest_count);
> -       else
> +       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0)) {
> +               if ((adev->pdev->device == 0x731E &&
> +                       (adev->pdev->revision == 0xC6 ||
> +                        adev->pdev->revision == 0xC7)) ||
> +                       (adev->pdev->device == 0x7340 &&
> +                        adev->pdev->revision == 0xC9) ||
> +                       (adev->pdev->device == 0x7360 &&
> +                        adev->pdev->revision == 0xC7))
> +                       amdgpu_discovery_read_harvest_bit_per_ip(adev,
> +                               &vcn_harvest_count);
> +       } else {
>                 amdgpu_disocvery_read_from_harvest_table(adev,
> -                                                       &vcn_harvest_count);
> +                       &vcn_harvest_count);
> +       }
>
>         amdgpu_discovery_harvest_config_quirk(adev);
>
> --
> 2.17.1
>
