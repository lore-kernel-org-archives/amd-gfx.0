Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B6C11F64
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A5261220
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A5261220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDF56E4FB;
	Mon, 28 Jun 2021 17:37:01 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D099E6E4FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 17:37:00 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 a5-20020a05683012c5b029046700014863so2809872otq.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DfpAfT/35iazqpZfJ7k8zE2IEAwR2HBCCwdopquV2PY=;
 b=NW2nDpSvUhtUJQaWKAb8tOylPNv/OSfxCDXqEpJW2MFw/x4QAvzxAoqkd0pUKSH/zJ
 +xuKKd/N6CiHkZozZekErWvSgXDvn46sz0aKEIHqW2d/GyfHE9fmxaKCWRGQONQ8/3ox
 kOivJ29+Y77du1KnsTv+4NIs8XQqz7ReOp7tRAbBBVX/JIzjvP4Xv+qf5MccLCl8iXWS
 OqTQJLWmVYv/z7IK6wF17OrD2Pm0xqPGOuwtSSH6UxrShdVkegXoPFvmn5GhCyxUx4KB
 bPiaP7oKzSMWSO+uMEimBnB2wvTaNZwiTtNpc4HRIfC95HXbX5FVDlQHx1ITWN9LXvG2
 Fr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfpAfT/35iazqpZfJ7k8zE2IEAwR2HBCCwdopquV2PY=;
 b=jhWaqLaV4QVOs9i66GtBK2qVlM6erAOYM+CG8gH2fTFEzV9ozQQx/eLUjEkvcNMKw+
 tbcPcL3ZRlU6/+6W6W/eY3JLioViqOyZ4FnJj/qKE5oJphW6aXtnllFC40AXHKW+zDxL
 zIz9h87bztfiD3PQ6onmeS8Ub9mSDIgFoyGJGpjKpmCXIde6Tw2jMfaGG12GFHaS55SU
 zu8RW2FFcVeoFJkwBaUUOnFFzJM4mu6Eho0ceRwwYQO7VEAaOSvc2nKIgw8qCHWfajfU
 60sPz4z63VqajD+VSI8OByh/4rZ+vbX68N0pxCWI/bBw3zsfxBBuiuSNwqVctZ5JWtV9
 5tvg==
X-Gm-Message-State: AOAM5335ONjs3N76E2JaYmTERdEed3ynFq+9Ra5eFUGsg3yhMvp79oTM
 mOQUeFGsPUSaREfXPR6HlSJSrc71PNPO/MptMu8=
X-Google-Smtp-Source: ABdhPJze8lOTPzTT+h6nKKHyAoeKIwDELHHdycu/LNDicoU62HEfVT57FIXao1BNgk6N0iymQUZu+Ea3Cu3iJmMmOUs=
X-Received: by 2002:a05:6830:4119:: with SMTP id
 w25mr658308ott.132.1624901820211; 
 Mon, 28 Jun 2021 10:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210628172546.65492-1-luben.tuikov@amd.com>
 <20210628172546.65492-3-luben.tuikov@amd.com>
In-Reply-To: <20210628172546.65492-3-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jun 2021 13:36:49 -0400
Message-ID: <CADnq5_Mv7uY1Ptsp=WpSPG+PgpLDWFQF7zSKXAoiHi3DxJxD9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/pm: Fix I2C controller port setting of Navi10
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 28, 2021 at 1:26 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Fix controller port setting of Navi10 from 1
> (incorrect) to 0 (correct).
>
> This fixes a previous rework commit which
> introduced this typo.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

For patches 2 and 3, please add a Fixes: line to id the commit these
fix.  With those added, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 205dc2e56ab199..36264b78199620 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2749,7 +2749,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>         if (!req)
>                 return -ENOMEM;
>
> -       req->I2CcontrollerPort = 1;
> +       req->I2CcontrollerPort = 0;
>         req->I2CSpeed = I2C_SPEED_FAST_400K;
>         req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
>         dir = msg[0].flags & I2C_M_RD;
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
