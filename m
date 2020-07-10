Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0FC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 19:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4692075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBrekTWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4692075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB956ECDF;
	Fri, 10 Jul 2020 19:08:01 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219F96ECDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 19:08:01 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id w3so6907498wmi.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ro1qfaUunjqkfLkD9d2ogw2TroJWZFxwklvT7GVLBu8=;
 b=tBrekTWUnxxfYWja5DMKuSpChz4y58e2Afttm+Onqq/bZIiPE1sWUumg+PqOTK6OLd
 /WQFYvRJlQ7L8+WT6O4mwqwKXq/tNIcennO9kbBqkD4qIeshWquW0smYk9RmknB6KEVh
 zM0UyWDnjwlACkmxvYiFqm3s64rpJ92HfCxIdZJKaDj9AbqbXNzIgIPC09Rg4Ammlvzh
 xRFkY7x17CBD+8TnMJmP5ks/xr9iUfDfmDozTJ5eHJR9PD2Pwu5M0YNxMXjRRTa38G4C
 mRf2Ks24kuw/Y8I/mWmkF6j4HrMm0yqK0lfil029soKrNesawcplqql9AtsaK/je/P9M
 esUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ro1qfaUunjqkfLkD9d2ogw2TroJWZFxwklvT7GVLBu8=;
 b=ezeU1vr/L6IMM1bWPA4Kg5ulGT3KM7Ppi4iq9GJf6ARlAnNfmPATSVYLQ+njADi6W3
 /ZgCjTQ31o9bJ0m2Go0J9+xQ/jmKRHjRiadw6jP7hjEEpe2MGjhYLbcZGWMcSBKRrH40
 xEg5b4mdEhDwLKbZsa85Dw8WRWk7xslsdP8RRjU7b2zJyAWYy8V6g+A4pQFB1zk+14qb
 bcKR4LAxy9vAyZ1XbHceNev8Ldf/bcPm4NkwKNHe1/SRFHsLi8hsF7oVfBpG7HFoIFvp
 9s9YwGyNYDTnRAY1y3ktYsNzyLBg1EOVfTS/pi8zmqRQZFcOoC019WQFdZfqG2l5UlC9
 KCnw==
X-Gm-Message-State: AOAM532QgKoBnKpknzC2zD6Yp4vtIPKNb0y9wNzBJ4tpK/bE9yoPQ3nM
 s0CnkawxOAynsTJiH4oMBk5jzjVMDSsoWekfu2c8cQ3K
X-Google-Smtp-Source: ABdhPJysWDVw2vnK+zcgmtGG8q3A5wpjeZNcmL8RX19AP4zi9yprvbURNHEDboWetur/2jRDS+lHLrFn5PCaYvkg5Uc=
X-Received: by 2002:a1c:de07:: with SMTP id v7mr6628679wmg.56.1594408079762;
 Fri, 10 Jul 2020 12:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200710175103.10238-1-nirmoy.das@amd.com>
In-Reply-To: <20200710175103.10238-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2020 15:07:48 -0400
Message-ID: <CADnq5_OaRDV-EQxyz2UkOnLKYXxFFyLp7P7HQXAexUWY2BQijA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove leftover comment
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
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
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 10, 2020 at 1:49 PM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>
> Fixes: 394e9a14c63d58e0f (drm/amdgpu: Need to set the baco cap before baco reset)

hmmm, this whole thing probably needs to be sorted a bit.
394e9a14c63d58e0f only added the baco cap check for vega10, so we
don't do it for other vega parts.  I think we ultimately need to
adjust the logic in soc15_need_reset_on_init() and
nv_need_reset_on_init() to check if the SMU is running rather than the
psp (is the SMU is running the PSP should be as well since the PSP is
required to set up the SMU).  Then for the reset at init time, we can
either force mode1 reset (which avoids needing to check of the board
supports BACO), or we need to check the BACO straps and use the
current reset logic.

Alex

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8c739b285915..59c974630991 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -986,9 +986,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
>  {
>         u32 sol_reg;
>
> -       /* Just return false for soc15 GPUs.  Reset does not seem to
> -        * be necessary.
> -        */
>         if (!amdgpu_passthrough(adev))
>                 return false;
>
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
