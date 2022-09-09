Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10723ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 21:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767AD10E9C7;
	Fri,  9 Sep 2022 21:09:20 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B475A10E9C6;
 Fri,  9 Sep 2022 21:09:15 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1279948d93dso7106749fac.10; 
 Fri, 09 Sep 2022 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=7jvsuFLboFap0DqFA/F94XSGxZ5vpki++gWbUl4bVvA=;
 b=Au7/wxInrHM2+FVGogak8BOmCEKU4fP6ejt+uu8CNyvGnOnKKmg3YfFDsmXi3AI3nn
 sFiyvQGDDZiiJeIz6PR2+RXiV5paMtA/B+oQlM+x1ZVRfAubnFK35jdVEiTHZypLDSk0
 NtyEkCqOeDfd/nrycdsCM0Z952j2YLpaohtOflkIMESmYI1j9VcP9fhE9kWudTqxdORH
 rd5zg8dUXyt/HMTaultDr2IQoIqPo7lWTklGtoI5uAee9UKxffbOKYJx9pJb7Nk2pJvm
 oFom7uH/LOHuKsMBc76e/XAbcnM0pB4leQN9pDtMOJLedqiT04hvNClGnjCEZMf3RmG8
 5P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=7jvsuFLboFap0DqFA/F94XSGxZ5vpki++gWbUl4bVvA=;
 b=G2QSxPpOu32a6Trrg1PRvwgeNUYgKVmVzdj/eMfcL0FV3hs0k/9Qtcs0C0ZuIRmn1b
 d+sGgG2EmlIrv13/sHHvAnOqQ5Qe+XNWt6KbflbIvzpA1DjgC7oSyodRgbqs3qcaDiYO
 XOhhUwP/Gb0VMX5qrpf3Wzd3+XvFuZvbfjxBdquG/VBIuzb7BYKSbHoaw3wx/X2JGKnH
 aCVTaCxsoKLJiq3uQWInrlTkTg3Zt0UKMqsu/zicgfdfNFIwKu8DdlKVC5btJFoRYgXW
 oR7BLLQuM05lr2iDGOwkpYd6DeTbRKki0XrFPKitoM7xqc+MqNaUd7IUv/jblQqntrRQ
 /MDw==
X-Gm-Message-State: ACgBeo0s0wZ37vAuz7AsKh0fRb8+ztL031VrfILzAHl8+ClWsD+GNBCW
 sF997FPnkqaKmZMbrFp1fiBcbSZh1Elos9A5zz0=
X-Google-Smtp-Source: AA6agR6P3Z9Yu9X16sZVcmgZ+vejDXLgEOwexym9sd9UWT7wVFeWHkLdC9YDaDu7OcRPbLdR2ANVekydwJBWMDFUgco=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr4554277oiw.96.1662757755081; Fri, 09
 Sep 2022 14:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220909195330.85888-1-jingyuwang_vip@163.com>
In-Reply-To: <20220909195330.85888-1-jingyuwang_vip@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Sep 2022 17:09:03 -0400
Message-ID: <CADnq5_P+iumnU+UPk5=HjYD7ie5Kr+dYy0j6vPTRycH-H-nBeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: remove unneeded "default n" options
To: Jingyu Wang <jingyuwang_vip@163.com>
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
Cc: airlied@linux.ie, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, arry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks,

Alex

On Fri, Sep 9, 2022 at 3:54 PM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> Remove "default n" options. If the "default" line is removed, it
> defaults to 'n'.
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  drivers/gpu/drm/amd/display/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 413d8c6d592f..6925e0280dbe 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -28,7 +28,6 @@ config DRM_AMD_DC_SI
>         bool "AMD DC support for Southern Islands ASICs"
>         depends on DRM_AMDGPU_SI
>         depends on DRM_AMD_DC
> -       default n
>         help
>           Choose this option to enable new AMD DC support for SI asics
>           by default. This includes Tahiti, Pitcairn, Cape Verde, Oland.
> @@ -43,7 +42,6 @@ config DEBUG_KERNEL_DC
>
>  config DRM_AMD_SECURE_DISPLAY
>          bool "Enable secure display support"
> -        default n
>          depends on DEBUG_FS
>          depends on DRM_AMD_DC_DCN
>          help
>
> base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
> --
> 2.34.1
>
