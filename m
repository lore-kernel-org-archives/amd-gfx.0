Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 17:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D190860EB4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 17:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D190860EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EFC6ECC8;
	Mon, 13 Sep 2021 17:48:58 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C856ECC8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 17:48:57 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id w19so15098079oik.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NiBhfHMm+nww8J2rpqTMa3+iV//oWo1NRyE2HvO936s=;
 b=EeZLSxRtX4sp2+UOhX+sNhBuA+V6Qs0+agwzACgcZ+dIDsLeiA+KZQoRwuOnn5RjUj
 wkB+dnWvJHbc+pCnjdZXdqvlZ8p20R7uuo4NnCZtFUrHxCmN3OSYCc8Gl0uLFBTrjq71
 3l35kLxKFeKpeSSJnZclIsFWfwCBynRDqNK1Haz0v46nNcWwCpaiCzO12hcqfnFzzm1K
 /xzZI+PHNzg5mP8uS6yZUgo+mIkRx9DcZn9+Q9j0OHsuGgIQ6qcjsHElPKUb+yC0tldT
 qRnJ2VlH9+Oax2lwoqqNWSfBJZnR7YeRMnTH2WMDaItV8/qqVEYAVc8Fjq9HOk6Agk2/
 pVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NiBhfHMm+nww8J2rpqTMa3+iV//oWo1NRyE2HvO936s=;
 b=pP4/oOn7qOPWk4RDFwMfgYi3YT14Ft7jgitE88p1SV+nOAe8zBo1hywwSMZ1p7l2nV
 j4sXzz+5TbFjTTcN/O4LgE1HfxZs0dsi+wEzUcYY9kAd8SPamV3O41cOfxerLsbM7uQf
 iLbeDmW5HYdNwCh+StLU86pEUraoWMjol/CIzHc3i4bviCsX3Dhd2ZB4ga8bQiuEtVPf
 BdvE2gCTSwWCwXp0abWwmhPc8onJO9DZiLKCsg0vFSzYZUzD8YFdNKJ4ud0v0vkK+X+C
 P8scViEqfiH9Laq7ypL57tBBaVIvyb4jVw/E3gHJD/v9ye8ke00kXaeiUSJdXhAlLA28
 DudQ==
X-Gm-Message-State: AOAM533vH9ZvKUpMO8bmWb1bFzjRyjmS1eNREtJqtKDPcw5/9hROWH2P
 ofn0RnBx897H+zWgfWtXzgGlGpjqhE3ax+aHbWBcYseK
X-Google-Smtp-Source: ABdhPJxSkfEz8mfgGSa2ZssrS9m3c/ZMx84NrvzgO9V2NBpByaQMM06OuFVVH28y96y/HYrFYhO9NeCYUE2CSfRMAKY=
X-Received: by 2002:aca:706:: with SMTP id 6mr7585370oih.5.1631555336420; Mon,
 13 Sep 2021 10:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210913172751.2008689-1-Anson.Jacob@amd.com>
In-Reply-To: <20210913172751.2008689-1-Anson.Jacob@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Sep 2021 13:48:45 -0400
Message-ID: <CADnq5_Mnn5nYFVSPZoqw5m3XemP=+_CgTK_aGf=Cny0=cyedhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove ununsed variable from
 amdgpu_ib_pool_init
To: Anson Jacob <Anson.Jacob@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Sep 13, 2021 at 1:28 PM Anson Jacob <Anson.Jacob@amd.com> wrote:
>
> Remove unused variable 'size'.
>
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 9274f32c3661..bc1297dcdf97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -300,7 +300,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   */
>  int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>  {
> -       unsigned size;
>         int r, i;
>
>         if (adev->ib_pool_ready)
> --
> 2.25.1
>
