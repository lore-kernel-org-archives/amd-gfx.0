Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0623CC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A17E6186A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A17E6186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196AF6E7D7;
	Tue, 11 May 2021 18:14:11 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518B06E7D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 18:14:10 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 n32-20020a9d1ea30000b02902a53d6ad4bdso18296864otn.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jaanpAyMedwfF2+D/baNZMzCDgJnzl/81Zgqdshq3hY=;
 b=DNpBvg/WYCDkD1gr+sKSXSR6sjEMUI7PagUZ9mtNOsb+2Vn6OArSlxceVg901BdLb6
 GmFkZja6SXEI03+ZaHfiWu6cC7DxPq6YiwTGEcZSPk7PbVb7NLcUr6pJh0nc4adew0lv
 hzhjTqpHy13yJHt/dy6HRS+pSsolYG5dlKhZ9HJq0O9YZhzvoaYFqeLIym2J6KmXOOwy
 oJws3iRNckJ9CarnCQdU8YLYaOzvLNhH42oUbfPKNSFha7Aa2NOcyJuBjh3Ld5SDODVj
 boX8foYdDvi5mFFWMMfuHWdYGpukR3qOo5Q55yu23GHzEjCHsngosa2o8xZIBL31DdUv
 GUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jaanpAyMedwfF2+D/baNZMzCDgJnzl/81Zgqdshq3hY=;
 b=kayIhPaVun3jrj/r5+VItuhnWzQPfo91J+lYWIwq+bGsmHwk6JHKibIW+11yl+gMk9
 j713D8ERfNbmcgFuLZKlfZSGNv+vPI9mJUr0aPcNPmlRV/JpGihKbIDORmWoYxVAgS07
 dVDPyk/pVpM/YNAnN//BhXe8pVRLVu9RnwCZoBfXsKhBVbdRrb1SGDb38yjKbUJvHhsn
 76DTkle0veiAc1eokecA/opiBLOwGJ9cUqDEJA9CIVpw1v2dknJ09jhMjER750zxYZeH
 wT5JpXc9VHnW2QydushUf62sJIEwGPH15Om4VRGYmbK9QMKLd80XPaLfvt2OINSft0tX
 ASqg==
X-Gm-Message-State: AOAM533eJd3VfmKveIgVgHEYhmLzN6ZgCAg40Oznt+grKN+I1l9zy2wY
 cDxTHSOAOdgmlOzgrczXMki2yqP3x5mCRLERMfA=
X-Google-Smtp-Source: ABdhPJzlAhXI9unyCfFf5VLA46a5tPqMpValjh1XvYCojmEy3k3gtUJAL2Fji1wS8w/9eXijABV38psTB5eLzEx2/n8=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr11449399otl.132.1620756849675; 
 Tue, 11 May 2021 11:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210511182516.3e9071bc@my.bristol.ac.uk>
In-Reply-To: <20210511182516.3e9071bc@my.bristol.ac.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 May 2021 14:13:58 -0400
Message-ID: <CADnq5_OvLO=EUAAB4NW53UVmB5TA2Z=Q3xfmGSPogYOrGeUk1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix uninitialized return value
To: ts8060 <ts8060@my.bristol.ac.uk>
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
 Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 11, 2021 at 1:25 PM ts8060 <ts8060@my.bristol.ac.uk> wrote:
>
> The amdgpu_display_suspend_helper() function uses an uninitialized
> variable as its return value, causing a failure to suspend/resume on a
> Radeon R7 240/340 GPU, with the following error in dmesg:
> [drm:amdgpu_device_ip_suspend_phase1 [amdgpu]] *ERROR* suspend of IP block <dce_v6_0> failed 118489088
>
> Initialize the variable to 0.
>
> Signed-off-by: Tim Saunders <ts8060@my.bristol.ac.uk>

Already fixed here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b12ee6f426e5e36396501a58f3a1af5b92a7e06

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 8a1fb8b6606e..27626d8a0647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1544,7 +1544,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
>         struct drm_crtc *crtc;
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
> -       int r;
> +       int r = 0;
>
>         /* turn off display hw */
>         drm_modeset_lock_all(dev);
> --
> 2.31.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
