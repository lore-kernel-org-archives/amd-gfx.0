Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D21C433EA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 19:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC2E206D9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 19:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQrwcBpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC2E206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD326E844;
	Tue, 14 Jul 2020 19:40:33 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F166E844
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 19:40:32 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k6so24378553wrn.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I7UPtgO+t7hZ1NgCxVLX+NFzVHzej2t9sbRIIKONvAY=;
 b=gQrwcBpXX7parNXBz1MQusbjZ+rnm/ToZblKM9A6HvCBDmumvZ5rbhAY6w3BghWQxA
 daBV059rdNPCbBtH31hi0/VwEykYlyQSkKQjfurmVZC4KbF8bagrvOXPkp2VYprkDi5d
 7nl6F+UWtPEmS/bfmUT/tFsNT5BK+vd7ov42vGMFVjpD42EWUgk8Sm+gRupcmf3WAQGo
 2140hvwTA+7dm7CiTkn3yKYkfQj28gCqfLIpz3zKO2aGWgsmfEB+p9TEpmRZtrjdjy73
 f09XQEx1g9DxwN7a3HUSUGHzG/TUAQogjOv7iJ8kaCXnXML4NuJi1xN/cRyPSuFcZBcl
 3RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I7UPtgO+t7hZ1NgCxVLX+NFzVHzej2t9sbRIIKONvAY=;
 b=IiYYkCmXHQnn/izmXO1ocQGKZUl45ma+N5SLbeMWzI00ulDtLf/JWvDBGDtrBfElnU
 OgR+3abVA2EhWbkjXiZgwiVEy2xdOF7gizcPQhTCilLuMQ2hDNZCXAy1+xXN/7i+iTMW
 Y+UxnvFGOEfGEBeIOfgzjfEZ9d/6fd4HbdhjOUZIWMN8fyPHTNZUBZsSQlgg9snwWq6J
 m/T7euHK2vlu4Lqq0tfR0wohOFcq3iY1R7mPPx3l8Xt6JqjLlA2cj6pm1p9x1XhKSY8M
 NToNi6FVlngMMCtbiBgkJyOIhan/1sxYuwd7zEpBn8EHFQU7b926rCwJmuUziwxhW19N
 IUow==
X-Gm-Message-State: AOAM531q6aak/UwrfCBQWMMNOH+ZIsGwkTQfD7fxsRKZZJLm/yXBRF/f
 mdto4CNwA9LYWMteLV1KebeihlsbjPy/TsWij8lxNA==
X-Google-Smtp-Source: ABdhPJwqNEdOZAMR/+UfFf1UvvVsIke7HY0AvOqDIkWtbda3HSOE99sTVgJtpR9hFYH+hZFSh3OHPH55yN0krWa5k44=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr7518735wrl.362.1594755631287; 
 Tue, 14 Jul 2020 12:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200714191629.28563-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200714191629.28563-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2020 15:40:19 -0400
Message-ID: <CADnq5_O7QEJ3hSqidhVjSMQCsFCBYPkaosDDsJhrm33s-ekYtA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: load ta firmware for sienna cichlid
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
 John Clements <john.clements@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 14, 2020 at 3:16 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> call psp_int_ta_microcode() to parse the ta firmware.
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 423386272920..798bc7b2db39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -173,6 +173,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>                 }
>                 break;
>         case CHIP_SIENNA_CICHLID:
> +               err = psp_init_ta_microcode(&adev->psp, chip_name);
> +               if (err)
> +                       return err;
>                 break;
>         default:
>                 BUG();
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
