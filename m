Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836D2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C06B60E9B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C06B60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C086EA86;
	Fri, 29 Oct 2021 20:34:37 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BC96EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 20:34:36 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id o4so15020547oia.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ghUpE9PwpefRBcS71RkQfSdh0fW+0d3xZwHTqb0LoQ=;
 b=XtTO+ytBE0W/TTK5hOHvtv6fYxduzvVluMqrEjvsJvgbymJj9JcWYwMIokGBABzA+E
 2QLWW/kiOf/dienLyu3zTt9Vz/fvy1cuhAdbafgc2NGs1TDBCfg4LbzfJ6aHZ+K83ghg
 rtkdp7nUQv6o260mQaaSi+V53VTzU4jU20AF0+mtKMTPG3uTrEmieWA1k+7kkT5Ewg0J
 9YpRELcsX75HkeIdJk6MCgsSxyok29U6LOiJU5zixSia1i/sTbarYX/ThF831x/YUgXB
 ReU/yri/v+4A8Ta+X6JNOF6O7s4gqrvDcMPMyCAIaGUKrdL0vD0nWisO8QPfqyCcBCo+
 +axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ghUpE9PwpefRBcS71RkQfSdh0fW+0d3xZwHTqb0LoQ=;
 b=meJFXMF8J6R8b7R56PFoSH3NJdIJqKOLWbsVTYthUoe0rAZxyhXB2M6uJpSYoWUEmD
 NScLmdRnUAhglAfjN+lRg15QFP8wjpx+dLTurlhz/kZceoEr4gWuMmmrzehXuo+oSD3p
 MLLzQuwPtGW2YgW9zEpuoufAxQsUrPHMg2+Ut8xjUBW8FDiB5k02j7rJpbMnjWsudL27
 nA1FxZbAPA2t4jS/sgT1RM6mTJPvyJMdWx4xx8wyA1ys+agNRjpy6CFHKGyziKLcKkpW
 WFa4A9lagw51IklayeTsGKcxFFTLcMYcUSrFDdpucQoHiH2ECq3xEZV5GYSKcDsSIC1P
 F3Yw==
X-Gm-Message-State: AOAM533fmufgPUqSLy7+2lA1CiNmuuj9CkE8TNAvfnPrqc5kqYwRzgtO
 Abp8s0VGn0qShSSUQnWGGfCdTW/Dd4jKScfEX6uJsgtv4SA=
X-Google-Smtp-Source: ABdhPJwi7nc84fW/8t0asHm8osRSPhHhJgoFv4NQgcYUUpk5R5Wg2oAQX80mUKw6sJ6i0ztQ1nRfz7fgf0w9iTbGrMo=
X-Received: by 2002:aca:e08a:: with SMTP id x132mr9473957oig.120.1635539675900; 
 Fri, 29 Oct 2021 13:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211029203238.4486-1-mario.limonciello@amd.com>
In-Reply-To: <20211029203238.4486-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Oct 2021 16:34:24 -0400
Message-ID: <CADnq5_PYO6ikVUV4Qy=b70MRQFspd6nmQ5jJ6mFXi0pvHu+1xQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Roman Li <Roman.Li@amd.com>
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

On Fri, Oct 29, 2021 at 4:33 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21
> asics") switched over to using dmub on Renoir to fix Gitlab 1735, but this
> implied a new dependency on newer firmware which might not be met on older
> kernel versions.
>
> Since sw_init runs before hw_init, there is an opportunity to determine
> whether or not the firmware version is new to adjust the behavior.
>
> Cc: Roman.Li@amd.com
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1772
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
> Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21 asics")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6dd6262f2769..e7ff8ad4c5a7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1410,7 +1410,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>                 switch (adev->ip_versions[DCE_HWIP][0]) {
>                 case IP_VERSION(2, 1, 0):
>                         init_data.flags.gpu_vm_support = true;
> +                       if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>                                 init_data.flags.disable_dmcu = true;
> +                       else
> +                               init_data.flags.disable_dmcu = adev->dm.dmcub_fw_version > 0x01000000;
>                         break;
>                 case IP_VERSION(1, 0, 0):
>                 case IP_VERSION(1, 0, 1):
> --
> 2.25.1
>
