Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3A8C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 16:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB9064E31
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB9064E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938FC6EB35;
	Wed,  3 Feb 2021 16:16:08 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637DA6EB35
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 16:16:07 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id i30so382712ota.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Feb 2021 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ypa2MSBco7D3XrwXKEHLLnZOCplt4H4KAZNivA0X4FA=;
 b=h7YqDb5NhH4Ecb7XbQTSVlSKTLGG2+KxO9c7lgnwnGs68Llwirs6c/FNNTx+ISq6fO
 f/39K8/uCa9fjVqG/Ag8+2XtCOeEHG10JoShCdxt+wi24KzoHejoDL+N+snWmbhcKvvN
 2aBSfwu+CfElc9Qk4j1uo/0fJeazjx6k1MVlKLUNChs2XwkPjReW7iTfNVdui+sNpSqZ
 KlTNRza4EFyAXxk2Zw71/BeLevzXizmBlKe1zr/DZbv+S90tvzSsXKq8zw4k08NDs45y
 tDJbE+BCSqQAXnLS5kJBr2UtDHjdrixDpfH9hPX3AMumMEPMgZ5GVEBHKJF5n5hVUgTh
 wW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ypa2MSBco7D3XrwXKEHLLnZOCplt4H4KAZNivA0X4FA=;
 b=Cx2SxMUQQOt2du0hBkI+aOOYpYkoEae4OfxZulFucvAu0xxU70VsPeoET0I4/P/KGG
 SPVWmCX6IwiaeHTJjkP7Ut4258es1/isedJLe6DrIep6Yb2PukHK6GVVAWfGrsoujOzQ
 ofeubjtyBrljcptyOdDes4tWn/kG6Q4N1HvKc/XvuDUnwcKifqewW/oiPs+1hEe+R0SM
 sfyM2uhyMUXqqM871yVZOXDjks4GU5ehZxDfWiDwYhSczkYco3MUF9zQYFrXIUF8dz+q
 aZsvsH/JHfoCiAHZo3Xq4gDplktmnA5SstqE/T8KED9IoZAykBgo3Gqp7T5fi2m6mcMQ
 jiuA==
X-Gm-Message-State: AOAM533QOY6Q2sraaHrSeZLTKkhAVyz3CeVUPmVxHpUmJdD5ngT9AHe/
 ue/H9iDj3YHw3ZSREIWs5V3CD1IzFi/Qhy8tY4o=
X-Google-Smtp-Source: ABdhPJw7Ol/pf4HOmaWgCBGqw0mJFYU6xd1zbsQOdxQlk8hdvclKZv9tdW7O2SstD/fd/Sd+F4HKmjiOEP9h6R890Aw=
X-Received: by 2002:a05:6830:92:: with SMTP id
 a18mr2567188oto.23.1612368966756; 
 Wed, 03 Feb 2021 08:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20210203082514.28303-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210203082514.28303-1-Xiaomeng.Hou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Feb 2021 11:15:55 -0500
Message-ID: <CADnq5_MO4yy6H7imSUR5evNh_SBuzeV21LXy=YsaFH9Fw_digA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: update the smu v11.5 smc header for
 vangogh
To: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
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
 Kevin Wang <Kevin1.Wang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 3, 2021 at 3:26 AM Xiaomeng Hou <Xiaomeng.Hou@amd.com> wrote:
>
> Add PP messages for reading/setting Fast PPT and Slow PPT limit.
>
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/inc/smu_types.h       | 4 ++++
>  drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h | 6 +++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> index 68c87d4b1ce3..aa4822202587 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -210,6 +210,10 @@
>         __SMU_DUMMY_MAP(DisallowGpo),                    \
>         __SMU_DUMMY_MAP(Enable2ndUSB20Port),             \
>         __SMU_DUMMY_MAP(RequestActiveWgp),               \
> +       __SMU_DUMMY_MAP(SetFastPPTLimit),                \
> +       __SMU_DUMMY_MAP(SetSlowPPTLimit),                \
> +       __SMU_DUMMY_MAP(GetFastPPTLimit),                \
> +       __SMU_DUMMY_MAP(GetSlowPPTLimit),                \
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> index 55d7892e4e0e..fe130a497d6c 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> @@ -104,7 +104,11 @@
>  #define PPSMC_MSG_DramLogSetDramBufferSize             0x46
>  #define PPSMC_MSG_RequestActiveWgp                     0x47
>  #define PPSMC_MSG_QueryActiveWgp                       0x48
> -#define PPSMC_Message_Count                            0x49
> +#define PPSMC_MSG_SetFastPPTLimit                      0x49
> +#define PPSMC_MSG_SetSlowPPTLimit                      0x4A
> +#define PPSMC_MSG_GetFastPPTLimit                      0x4B
> +#define PPSMC_MSG_GetSlowPPTLimit                      0x4C
> +#define PPSMC_Message_Count                            0x4D
>
>  //Argument for PPSMC_MSG_GfxDeviceDriverReset
>  enum {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
