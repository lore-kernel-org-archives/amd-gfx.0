Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0DB61165
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E0DB61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A796EA78;
	Wed, 13 Oct 2021 18:21:10 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98B56EA78
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 18:21:08 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 x33-20020a9d37a4000000b0054733a85462so4829891otb.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6zabzF8Syuf4SA3leJyx4tt3KkIjTF0lHls+vbvw7qw=;
 b=ci0de0GGLyeDOJ2/4GwyNvO+eECbmQLKO5zGqkhD0njCQDDxo5Vvl+PaJFmQvkY27i
 nLiUsYjg8sl0RVxgI1p/RviY/CPkUWxDmOf1ywW0rT5QGony8pMFh1hBD982Cn7dxlr4
 VLSSwMOyLpqazCJaIHFdpFZ+DprHMghy+1CTUh3YXfh6sRvFeH36Qc2DPlxxV1Y+wEsJ
 vClcMNyt23vj2LVv/sNN1b3uCJOlJeem1xSpq3HwmT8+73oy0tFW12XMKGe3xi4pRTRK
 B3TJr9gLgec/BYm+X9SrnWlfUXNhIjIvgDhQ+GOJz5ILnH03WHD1RLQ7NlXm4tI1zmc3
 l5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6zabzF8Syuf4SA3leJyx4tt3KkIjTF0lHls+vbvw7qw=;
 b=VAyOluvF0kDm8Wl0u/pwRXwZURzDViGAbW05KfgZ9qvI+aKWgDbDqxZ/JxrBqWDYtR
 8Gwi2Zxj0nXuERX1Y8jOsTrUEMV52FELseQXKwY1OXa2RmhXixUWZ1FcF6XwJ/Y193h4
 W3PEKzlaQavNV15f9KThHqIfzJwABKAPFI2N4jAlm7hGjZ8YIJqt285XBfzwE3NDzG1p
 xugsSw+pfCJcZSRupalZNzSecOP3UhNuSOlcl3rUwQ0ynlmZW6HDLr9ZSpZyGPYL4jJz
 wY3oTTI/4l4wTNcg+5ZLRXHIflmWsmGX8rpv2JY3DVtKlAfCZ+0sox/k+BI6uFzidlcw
 Bszw==
X-Gm-Message-State: AOAM5327FzGaaZcgKnE9uq4hY20CU8F26IpVRIVOn/dQm4mbDH1uSJBr
 xHms974wztSiY8DytjV46PVsJGPl5asmWEpNsdT6ninnU+7Y8Q==
X-Google-Smtp-Source: ABdhPJxhLb7EwQZzNdNDG0cPi79MgPRyYDmuUT+rslwxGVcBqdgur8jcwb3s2MLvtXIwd1OkaWInDt8JljR2wo9pSBs=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr627788otj.299.1634149268067; 
 Wed, 13 Oct 2021 11:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
 <20211012155307.1059170-2-alexander.deucher@amd.com>
In-Reply-To: <20211012155307.1059170-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 14:20:57 -0400
Message-ID: <CADnq5_OtDxiY8NcB40GUVWH+FCTJO72hQxaow2VFgPbU9mzrCA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/swsmu: fix is_support_sw_smu() for VEGA20
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series.

On Tue, Oct 12, 2021 at 11:53 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> VEGA20 is 11.0.2, but it's handled by powerplay, not
> swsmu.
>
> Fixes: a8967967f6a554 ("drm/amdgpu/amdgpu_smu: convert to IP version checking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4ea7e90ef60d..f5bf3ab0ebad 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -455,6 +455,10 @@ static int smu_get_power_num_states(void *handle,
>
>  bool is_support_sw_smu(struct amdgpu_device *adev)
>  {
> +       /* vega20 is 11.0.2, but it's supported via the powerplay code */
> +       if (adev->asic_type == CHIP_VEGA20)
> +               return false;
> +
>         if (adev->ip_versions[MP1_HWIP][0] >= IP_VERSION(11, 0, 0))
>                 return true;
>
> --
> 2.31.1
>
