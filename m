Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BBDC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB986113B
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB986113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDE56EA8C;
	Thu, 15 Apr 2021 16:23:48 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE7A6EA8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 16:23:47 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id a21so11761400oib.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jXfRBBk0JPaYI5Z5HEgmHkynq+uw0ZW/JO/1K44osvA=;
 b=YXLg5KuFZVN4vU3sAvllAvmwTloIbA2P3M6Wir6P/9nBVGCImakgm4jSFMM8iGPlAT
 B+Z8PHp/GrR+3khPE3XVYOc+AIJvzlW3+1x6BAAsROsvaUwq+oUmWPPLAnOG4tRRKtyh
 vIPo7uJgDxwkFi9aNwq8QTItJmJcS1ZwDIHozEU7i1vVkmxTFLfu10A731xnmw7MqeTt
 OrgB34w7IGNkuRCn2D1jRc2BUevOxg0UAn061ecn1YSR+L0PxkWL8jeI8Ivzt6Yn9v/U
 l8lt7E119+61437nMOAd/kF9AFTVukzQ3R1f4INnYc4K+d6n74MUlYGBoLnTZlAiQRYC
 +bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jXfRBBk0JPaYI5Z5HEgmHkynq+uw0ZW/JO/1K44osvA=;
 b=F24vOGQ849U7ZK7yb1aTUoGvmlnzLOyBphlZF/rknU+76F7kIsYrdT+rWPl1IObLBI
 FakMM4hFomAEW3aRW9l0U6SQPGhM6ZuVadl6QRrijb/vtWGlq6K/Rtb2ek6z8r19G/Zh
 m3/mHJ+QSlbgXNVIc4mVRcIPoDL1ALtiliwUVGbkXJLxpQeMlbr1fC+59NIQtjX4ynSt
 espZ8xC7CDzThKu9mbEvhrJ16J7jD/5LBj9Ev08A6qSfH+f7WBECm58FMLOViha2m/Rv
 F8rkyDw/TytWBarHW3Kp5GSu1GlhbsmdIYAVNUpibDhYfWiLt9R59RPoqqrfQEJ0dwfx
 e+eA==
X-Gm-Message-State: AOAM532YuhRNC1nILMUda9ch1f/AJ+od+pStSUXO1HvWtYpBdxfcKrUx
 XQ5MuIeR2kffV6obCbr6QRnmPvi5xzTbtsOX7es=
X-Google-Smtp-Source: ABdhPJxOk3GIJTM4+56m3f0143Ty3G0wU5BP4zf4znCV82m7VpFkBSaw2z2SHKUjpoJm/PrRvp2MTLn+7giHxjJ1Buo=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr2983922oif.5.1618503827170; 
 Thu, 15 Apr 2021 09:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <YHaEutSVsa63kcFZ@mwanda>
In-Reply-To: <YHaEutSVsa63kcFZ@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Apr 2021 12:23:35 -0400
Message-ID: <CADnq5_PwkGzwLq_Jy_stMB4pN4ta6E5STrcMkE7HsAvg3Ln37w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix error code in smu_set_power_limit()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Kevin Wang <kevin1.wang@amd.com>, David Airlie <airlied@linux.ie>,
 Lijo Lazar <lijo.lazar@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Apr 14, 2021 at 1:59 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We should return -EINVAL instead of success if the "limit" is too high.
>
> Fixes: e098bc9612c2 ("drm/amd/pm: optimize the power related source code layout")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e0eb7ca112e2..c29d8b3131b7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2221,6 +2221,7 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
>                 dev_err(smu->adev->dev,
>                         "New power limit (%d) is over the max allowed %d\n",
>                         limit, smu->max_power_limit);
> +               ret = -EINVAL;
>                 goto out;
>         }
>
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
