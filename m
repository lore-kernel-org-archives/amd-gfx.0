Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95649C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3187A10ECA2;
	Tue, 11 Aug 2026 15:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFRS39nT";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F6E10ECA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:50:33 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so2943a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 08:50:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786463433; cv=none;
 d=google.com; s=arc-20260327;
 b=f/oPqKmUmCNAglfmYXpwmFLMMIVgzbELzYPsAiOjBFI5xCDSnLtLA4jKLa+WnSAYXK
 lhTHaXJTM9r68ikMEheLw5ooApornsguMQAiiHElyaaeqj22kW9Ixtr1Rc7mhz/p+eb0
 zuG5Eg/u7KXvymusS2oX/xKhArQinMpBHcluKGSLgVGyZGld9yW+842H7/V/BGvRrvjX
 ViJbheXEIRnAKx9ttpoPBI0z4xTp+jMqoZ6I3YUhNoylGXfok14hAkxO/M9EG5YJaEJH
 UJ/RU0kdSapiueLo5Ez0zPEQhvAteWWpcHyv3BApec7Uistrn0/hAbQDaf1Apundr99l
 5BNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mx343x8Yymex17HRyBeFj3F10F9ur7qmX0VkmHOBYNk=;
 fh=wQTCsLROhGntYTjJ9pOwApc6D3aJKK2BG5LA3vsXyvg=;
 b=qtq7ubYUolI1YV/2TQ8mmcv+g/UiRZUbns6ytJl06a42f/UNP2YME+ykKzb8rgvvDe
 1CadXHHpdBdbdYSni+kFbYnoUGIHCzxz7cezpBA+HUIoqTzsVepmaW+68Ph+yQQvFn2e
 PR171m2zKiKUx79DfRbMCR2q+dQqsAS01oWRnL343jueNZXYLfTZlM5EB3kMdFATJ6dn
 UiJJpvHkB43UwCp/dcJscO9EeW+ltEsSCTT94En5Y2ivfKtmAoc8mTp6ZActsxUs20k2
 3KCASyCxmjFDAeqc5DbY2PBOvUbLhfs4GY08BFD/5q/XKn+JVjBBFIUjWYjYmNjh2zck
 SfzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786463433; x=1787068233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mx343x8Yymex17HRyBeFj3F10F9ur7qmX0VkmHOBYNk=;
 b=YFRS39nTeoyS0TvF/n0jO49Si/brXb+6kqSmThAr4vhPX2iv/DCkz1FdPs/ysv6of5
 FCcY4JHV+3/Rzq8QyjgZeUUIMisBP/FACqtEMsVUkFLHbMaXiKbcJ9Pg5Y3DrcxP6hFi
 /wIHPs44dPHooFV5Vmke1e9tITSrFlGl5R0tjqjzw4Wj0KckW7f2iEpa8nqlJEQw8aiZ
 scjcgdCEuWbOofMUmy+LOoySF3kT7fbq47HVm7JOIQ24vp2Epo2D0FnYtvgV5Hg1hxVU
 OTsYyMgWh7PWudn0m8aKZDp4HgMKmndZQrOc82dbEKbsHBaSmZtuRe+HLsAOl25lp6dD
 drmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463433; x=1787068233;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mx343x8Yymex17HRyBeFj3F10F9ur7qmX0VkmHOBYNk=;
 b=AM5QRqMqFHUESZPPf4WSpdTR8LfGPTmNKh58bj1z3Hb4jJYgSVbb+Lo89Qr7PLsuFR
 tifx963pZPImByZVboByLL6f3akdvFTTPkBuWIz6Ucg0CWRTsiWrqJ+jt5UJ8tunOBaF
 91KxTZs72XbmgmnXEibUQ2ysUAso29Xbse+v4LFtHk3gqvDKdESltG9Hv4z6xjJcgJtO
 rx8zwDUkZoMl8p4GQtn35kPDyAEBnxMHVAGq5CeOfwWw/MEyafq5U0PgiMFsTgqidSko
 iTarCMSKeg3spCWe3G3gvh0gTCv/iAgrv/sVTLz5jMO8HJbTLTSryLgIqfr3kTt4ejoL
 v+2w==
X-Gm-Message-State: AOJu0YwofQQ5RYPPYB0TlFrlvDR/hzq+rs+c2UNTJV1eAqalrC6IvCAW
 4Dqv3qPnJZhpQuPkMB3slT31D3Cyd4Eh+Oc3vp8ZMuL21iuMlqXsBypniOjCMa1Kp1vptH3rP3G
 Xi4bgAXIoP6W1KXfQx82iDTxGVdlUeWI=
X-Gm-Gg: AR+sD12j9wXnQsoslUcGQuIwQ5GH1u+AzHRTZWOPwymxWHdPzIEj73urQAQWsDS4IoM
 G2+sBVUp6IK42vBXous+dCtvMn/hu6BXKW1twyWOZ9b/p3m2pUZYyT6h1JgmL4ZBaPHBliPSazn
 wKDlma9DIajZhcOxzy82jn2cF2uDI9YkRYxJCIDoZ4lnUm5peDXyEiA8s0z048WeMHdPBr1dyj/
 QbR7sVEk1TlVlN3lPHfLCRNeCsSUIrPkCN1q6dRi1MAKflg0BpxbvZcxI43rwY26+PnjUWHy4nq
 eFyiiS8Vf/jFq9s0Aju5md/az7yCoUx8tXuKa7SVouRfoJISqMHI8sY50Y3jN+ywcis2yDioFU7
 OXjef1sY2hLMPIoqgCl7Aq3WViCJ16Q==
X-Received: by 2002:a17:90b:2688:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-392ecb863cemr3252500a91.3.1786463432814; Tue, 11 Aug 2026
 08:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260811141431.555557-2-david.rosca@amd.com>
In-Reply-To: <20260811141431.555557-2-david.rosca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Aug 2026 11:50:21 -0400
X-Gm-Features: AUfX_mwi_TK7hFiCyfQh8MFgkU2krdTnEyQUGN7LlMM6CpWR0DFmPNY9DdrUyZA
Message-ID: <CADnq5_MstRA7A9FxtEF8JF3tWiX3GiPC=CQOBtPpBF3fuwSAjg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Bump version for userq timeline syncobj fixes
To: David Rosca <david.rosca@amd.com>
Cc: amd-gfx@lists.freedesktop.org, yogesh.mohanmarimuthu@amd.com, 
 pierre-eric.pelloux-prayer@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 11, 2026 at 10:25=E2=80=AFAM David Rosca <david.rosca@amd.com> =
wrote:
>
> Contains fix for userq waiting on timeline syncobjs and adds
> userq support for signaling timeline syncobjs.
>
> Cc: yogesh.mohanmarimuthu@amd.com
> Cc: pierre-eric.pelloux-prayer@amd.com
> Signed-off-by: David Rosca <david.rosca@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0ab380ca7e64..da36702a7468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -126,9 +126,11 @@
>   * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & A=
MDGPU_IDS_FLAGS_MODE_PT
>   * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
>   * - 3.64.0 - Userq IP support query
> + * - 3.65.0 - Add userq timeline syncobj signaling support
> + *            Fix userq waiting on timeline syncobjs
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       64
> +#define KMS_DRIVER_MINOR       65
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> --
> 2.43.0
>
