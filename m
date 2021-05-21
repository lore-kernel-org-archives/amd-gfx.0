Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF62C04FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 20:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0AD613E6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 20:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0AD613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE346F90B;
	Fri, 21 May 2021 20:54:46 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F996F90B;
 Fri, 21 May 2021 20:54:46 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id t24so5379436oiw.3;
 Fri, 21 May 2021 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uBVpkrKYwYzEG/MbsagwcvAPa2TXzkAW5fICEd/F6J4=;
 b=gwdU/McDpqLHODU5UhcipIZFabkwoBhU+kuMLDC2QGUrhY8AKeKTpu8s2wzzaMN7F1
 i3VjcFphGNk+z+yxGx4fDS7jVKcyJfphTQKZx1CqQbK8ZQIwerGPrEOuR8hmjUdTjJBe
 Al3s4PMry5uObCR4JABwr7kBG84QwALl255/reBmmVviM7gXA54TXzIiarqa1sBENP87
 a1SO8uASCa/PWuaVfXY77w0AWbU1REIwXUwAOQc9azf6Vi0pARRr37aR8BlwL+sSeYnD
 HSnKwd3v36MncgNMusm9Zo2FvSpZbUnUpSQ23uHVyOVXNMHDZFCCmFqGSGPHSboZ9/v9
 /LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uBVpkrKYwYzEG/MbsagwcvAPa2TXzkAW5fICEd/F6J4=;
 b=nqWwyz+eKmEE5/ll8Rp058TbE9xcbGEmiyUnrIZDY7i3AWsA3b0T9u3VQuV3uOjNM/
 +4iPhk8zkOau5HpE/uklF1zWifbpk0W613NzvvtIU33Ube14lL0nklwlAMzH23y1WmsV
 mm4aMi3t3h/CaDmmJ/IkQLeM0MUYFz1w1WQC64wP/Vfwq6gv0eO3jVo2gPf4CRW/xG+N
 tM5GoTLifx5StuqW8ItvmXoKn3guV7MWuN2cSVrmNVEZeqEMQbZQTlQuFHwDjGOg5Fgx
 kn8EcQ3aRXma3yRdroTNB/QiTEDPQyMdVXvo1zktB2ppkuOHyzL0rBIVO4T33HPoNR3p
 LRsw==
X-Gm-Message-State: AOAM5304QkoeZIfsbkHJ7XvDQKgq+VRy1yaNKELQiXlBfJ8THN4UIPVE
 Pwp016wDj9uLXZ+w5aJRFWp2xIUgsliniEkgAAc=
X-Google-Smtp-Source: ABdhPJyeoz8sknPzbkgMhZAwDO2a8XA6OyM783Twm1WOJwvIodN5loxclbb87nQqTJSpxQB2jTThvOxsOu+ASEHfRgg=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr3327794oie.5.1621630485590; 
 Fri, 21 May 2021 13:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210521204122.762288-1-andrey.grodzovsky@amd.com>
 <20210521204122.762288-2-andrey.grodzovsky@amd.com>
In-Reply-To: <20210521204122.762288-2-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 16:54:34 -0400
Message-ID: <CADnq5_M172c=KS8Gqv8fyYyto1iq4pH9giUFqhjNnTaum6sBEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Fix crash when hot unplug in BACO.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 21, 2021 at 4:41 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Problem:
> When device goes into sleep state due to prolonged

s/sleep state/runtime suspend/

> innactivity (e.g. BACO sleep) and then hot unplugged,

inactivity

> PCI core will try to wake up the device as part of
> unplug process. Since the device is gone all HW
> programming during rpm resume fails leading
> to a bad SW state later during pci remove handling.
>
> Fix:
> Use a flag we use for PCIe error recovery to avoid
> accessing registres. This allows to succefully complete

successfully

> rpm resume sequence and finish pci remove.
>
> v2: Renamed HW access block flag
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1081
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

With the above comments fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d8db5929cdd9..b9d221fcb66d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1555,6 +1555,11 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>         if (!adev->runpm)
>                 return -EINVAL;
>
> +       /* Avoids registers access if device is physically gone */
> +       if (!pci_device_is_present(adev->pdev))
> +               adev->no_hw_access = true;
> +
> +
>         if (amdgpu_device_supports_px(drm_dev)) {
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
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
