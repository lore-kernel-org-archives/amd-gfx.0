Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921ECC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 13:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF73207BB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 13:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F482HQme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF73207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C076E0AF;
	Thu, 23 Jul 2020 13:59:16 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E63F6E0AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 13:59:16 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f18so5291485wml.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ut8ldyFNzQBac7WM6tv/vWO4pxfvESQz+WjQ155j8UQ=;
 b=F482HQmeKvQy1uNm+VDCzSdplY5Yztdzs4m0JgyaOpn6PY92gsmHhaXfmK/3+uSksV
 g0QSIycKRMku0g8tQMkB46A3zGBKMe4IaAcJOzlbWxaU5BOEor/++DcRd8wElz3hTxb8
 VedZgfQOGI6HjwePyl6ZdKwELe0BAW1g03j6NrpKtGkVsExX3PnJbdtsnxuJAdieLMuf
 PYkL8RXw0NODL5nNPqCkRQHIUjvyRuvpO3rU8MVdHUiGCkFmC1YEsEbdrtZQGBhh9h14
 DmvuCS6z0Q0Hs6JrhaL/Z79MjthcDBjNDiBe1MGSo1LPsz5bP/XVVLi3FDsA7GM1wxu3
 Pa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ut8ldyFNzQBac7WM6tv/vWO4pxfvESQz+WjQ155j8UQ=;
 b=IcWa8Y2DcBQT4hB0iUqjX2vefjoATfMqQpCVoGtt1/84noP7I0bEcPYlBHCnh5soXV
 NfNJ9qCrIa5Kckf7uaP013eB0xDGOCV6GdMYgpxwS5XUNWTC+2VayS91ubYoPc2h2xkc
 SepqG52Fg5Kzu9HeFBfCV/Xx/LM/jEVEBE7u4hyYhAkMwjuv+XoP0KA/REM15i93KAyZ
 mOnDBkdX6fqFEG59/XRRfquTZ3/gALXWQ6rXyq84EchX+lImhDBpRs6GeKBO/C3dR8LT
 cmALDzGpv0INqoT4nroNgzR+RairIcObvJfD/qKp+Ie+WbUFezeU1WgCjCKdd4ub5J5U
 jPCA==
X-Gm-Message-State: AOAM533pyhlyH24NmV/a05RkExVEAxFsGemwlPe5THnDlMgs+mZW/lzH
 8nbzHry+ZRF8RQFNbJp6mGCMtcyJctYQNOEfwrQdXQ==
X-Google-Smtp-Source: ABdhPJy2Z8U3h0YvgeJbnZ/T2GQdv486+TTbHUywp8BKnbDCh+T/uSC+yveLI0geqYjee9Q0Mjuw0L8rQsRxDoSkdMg=
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr4207913wml.70.1595512755183; 
 Thu, 23 Jul 2020 06:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200710145047.52383-1-nirmoy.das@amd.com>
 <DM6PR12MB2619AD3F3A4ACB3221558162E47E0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619AD3F3A4ACB3221558162E47E0@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jul 2020 09:59:04 -0400
Message-ID: <CADnq5_P6Za6B3SStz-REdyDdarOtPPw7qTHdRGFn_14gohnkgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can you check and make sure this doesn't break polaris or some other generation?

Alex

On Wed, Jul 15, 2020 at 1:12 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Acked-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: Nirmoy Das <nirmoy.aiemd@gmail.com>
> Sent: Friday, July 10, 2020 10:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
> Subject: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
>
> For passthrough device,  we do baco reset after 1st vm boot so
> if we disable SMU on 1st VM shutdown baco reset will fail for
> 2nd vm boot.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d1adbc45d37b..07be61ce969a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1178,7 +1178,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>   * unfortunately we can't detect certain
>   * hypervisors so just do this all the time.
>   */
> -adev->mp1_state = PP_MP1_STATE_UNLOAD;
> +if (!amdgpu_passthrough(adev))
> +adev->mp1_state = PP_MP1_STATE_UNLOAD;
>  amdgpu_device_ip_suspend(adev);
>  adev->mp1_state = PP_MP1_STATE_NONE;
>  }
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
