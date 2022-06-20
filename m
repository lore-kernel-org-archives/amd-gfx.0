Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E08DC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 14:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C512F10E348;
	Mon, 20 Jun 2022 14:53:59 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4163D10E348
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 14:53:58 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-3178acf2a92so69031647b3.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7+K+e/qLd7m32gGzCmEuaoOlFDmL72/RGwu3SrIGWj4=;
 b=bLdUqmfYg6tNnVIk33vU9zZSLkGFni671fc7g43EuJoslJ3bQvwlbHQWIJO54F5SVk
 uIVtBkMaIiUyAYY2Dtd2BzmNEDrkEBix2L2OORHLKA7qwnAYxdbRXh3kN5ITyn6NqfMt
 WqFYrQYE502GGZph1d+mgNyrPXTdLw7z3G1R1knfsdwsAaGEGZQHXRSUe9cNgnyf3SrR
 TrHoCOPaSOV9DVKNUo6+wERv/BGPRB+pcOXqLG4Jn6ZLpwMQpESrAaLZ8KpM43uT6kyP
 xVgkh02m2ezZef++ObY9Q8FzvXMdAWgAp02Xg+dtcQNJ8Htk9rjvRz90ExVkoUzP5ya5
 6Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7+K+e/qLd7m32gGzCmEuaoOlFDmL72/RGwu3SrIGWj4=;
 b=JWEgxI0616r449p0HQ+2DWLcAcKCI0iiZ+uyW6lkwIwuXZ4qMpXb5lBNWF8KoTAk1R
 AakqMieEaIAE+SRDkITw3Qx4eQk9U9tgSVspsaoNElRBEwUnI/8MO2zac/ZFszKQbPPG
 WYX7vNH51NBvIvAENufRbbU4wq5O5sE/UohqKDR7OwqFmGTzV4uYbYXMNGR4njnjo2Y/
 9G5VEebXgxcW0fKFJg+poKpaRrbCo6Zm1NvqUs+1OZ5sg7103XZ4Sctag+XmUX0/XqQ2
 P4VfpkOPEMW3ks4p89ZEhXUSOOyoSFqWkFUFc1WHD/rxWlH+qbpK1MqDAIxgtCbKjvTZ
 cLVw==
X-Gm-Message-State: AJIora/glqDsRh4brXbZs9/pNytsB7p+G1kDrmSKCMygpYLoXUT1MGtk
 QnNDYUnuarrRdg4UJVycUkrsTIUhzwK3Ci5GeBY=
X-Google-Smtp-Source: AGRyM1sHx39q2qtWOE6S31Gvcw0hs2OvaKunKTMraYaJdhelpr9+klu4IaqNntwQ2cZ9gh9QYeFQLzUJ6sDzsbtJf9k=
X-Received: by 2002:a05:690c:58d:b0:317:dd62:f6d9 with SMTP id
 bo13-20020a05690c058d00b00317dd62f6d9mr3758609ywb.78.1655736837433; Mon, 20
 Jun 2022 07:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220616211238.669152-1-alexander.deucher@amd.com>
In-Reply-To: <20220616211238.669152-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jun 2022 10:53:46 -0400
Message-ID: <CADnq5_MEwLZEw8MAYyrGvQyBvPRRu50bNWTSSyiUExSvpp7hyw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix adev variable used in
 amdgpu_device_gpu_recover()
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

Alex

On Thu, Jun 16, 2022 at 5:12 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Use the correct adev variable for the drm_fb_helper in
> amdgpu_device_gpu_recover().  Noticed by inspection.
>
> Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2b92281dd0c1..eacecc672a4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5186,7 +5186,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                  */
>                 amdgpu_unregister_gpu_instance(tmp_adev);
>
> -               drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
> +               drm_fb_helper_set_suspend_unlocked(adev_to_drm(tmp_adev)->fb_helper, true);
>
>                 /* disable ras on ALL IPs */
>                 if (!need_emergency_restart &&
> --
> 2.35.3
>
