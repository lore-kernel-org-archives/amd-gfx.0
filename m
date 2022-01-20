Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE49EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 16:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7697610E7B0;
	Thu, 20 Jan 2022 16:50:43 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2718910E7A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 16:50:42 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id q186so9711520oih.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7dwkOrKixbQJK1hJ0RmpTlfats3RHKeKQitC1e87jnk=;
 b=nI+PMb/mhYua5bSUg0zghiXLnBtmcadMkV2kG/QsKEqR7S9JFC5g0Wjc4YDBAek4oB
 oW/0iBoX6x//KDaAB5xVL0Iu0QEYxiQ88Cjz68A7J46NLycuYOkQXBM3mrJhNMIhJLSP
 wyhRYoxDNfmYFqVOxV72wW8DwkcATd8r5NSHmt/UI4ie78MnDVvgJ3hpwJEfBJxZXNCG
 JS/0T0SatlhQcYLTvvtvvSzPdjRi3Z3JoxP8k6vlJ3OZT39KEBPpVO9frsSCNMCrikjS
 YyWNMxPNZWftvhzRj3MwQwCmMZ+t6KC5TNtCK0kWVqtW2qli8UpbNby42zOAkwIYbv6j
 pUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7dwkOrKixbQJK1hJ0RmpTlfats3RHKeKQitC1e87jnk=;
 b=R2XGRh4AtvKE1lvRmV3L4a3EvHwy9F7bgORmipfOI4T02zlYCcOAJCxK2z5W+r5EBh
 r9OrE7uSEtiE+NF5yh2R0LFEvhCIsB9uAMFKpgT7PQIw8+SVOYu5+4935xFojTW8WP9H
 JFoa0cS01nv1ml4TX77EyOq3Sv3Swyml2WXtf4BDPprItLS/hZiokD6HJNhmLE62Her+
 OJMS4nWH+6AXcx88HcidGsOXIAFwlQDZCWcEsaXTijNO4YsS9FjaSKVAh+jySW4rq0zA
 6nlwjqL4ehtB3tTwbsXKrzxeHONEAyiytrAF1t7MD13452VRzbhoh+M+h780C4H9gt8v
 mMRw==
X-Gm-Message-State: AOAM5310p15kbC3NOf24P0erM6QpGqHyP9iODlkaWdek5C4A9uB/Pfkr
 gc9Za9/vTPUG8r9b+OAO9A2kO3UU2B4Gf3y0agY=
X-Google-Smtp-Source: ABdhPJxumTIGKevWUha+xqgV2cRCf383Xo3Kn7PNjE//Zv8nlXfpUg20U7N3IFrVGZ/kr75AtAhJZyNnDBa/n7tqBjk=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr8297344oib.120.1642697441365; 
 Thu, 20 Jan 2022 08:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20220120154851.22223-1-shaoyun.liu@amd.com>
In-Reply-To: <20220120154851.22223-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jan 2022 11:50:30 -0500
Message-ID: <CADnq5_NkuthTyhDWS+2u6AV-FZkgmFJjTmHmoho3SXhk-ibvsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Disable FRU EEPROM access for SRIOV
To: shaoyunl <shaoyun.liu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 20, 2022 at 10:49 AM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> VF acces the EEPROM is blocked by security policy, we might need other way
> to get SKUs info for VF
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 2a786e788627..0548e279cc9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -40,6 +40,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
>          */
>         struct atom_context *atom_ctx = adev->mode_info.atom_context;
>
> +       /* The i2c access is blocked on VF
> +        * TODO: Need other way to get the info
> +        */
> +       if (amdgpu_sriov_vf(adev)
> +               return false;
> +
>         /* VBIOS is of the format ###-DXXXYY-##. For SKU identification,
>          * we can use just the "DXXX" portion. If there were more models, we
>          * could convert the 3 characters to a hex integer and use a switch
> --
> 2.17.1
>
