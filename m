Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7798C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 19:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AD210E034;
	Tue, 19 Apr 2022 19:59:48 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138F510E034
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 19:59:47 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-e5e8523fcbso7149000fac.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w7V/R5aqGEL5lA+qPqhrRRb3+qSsT4RaJbhumZr8H2U=;
 b=UUrdImrQlzXoR5pcqu1eZWTzEfL9AnwPQWHOmHbX8mU39kMRi+DJ6N1B2d8F+Ok8aS
 uYot2zgbRjuEd502iBQ21PI3X36gtx4Ox5yphigwlSjMDz3/O0Z3yQeHt7jdAvi7Um+X
 g4Wj+usZ3Te4LxiJM7j1aZVBMTzO81x0Nbx92XjKto36y85g9FbmzMqSlrKSeg0rrUXp
 Jgt/C2ZOR5libEv/38hlw9U2wd9Fwp2BCDHPZC7S0eCYh6+0Z/wXj8JI9qU0A7+qOK8O
 VuCSsAUzBpPazPk5oXPYBm24INkqEo5jh9k1UnEOC6PXesipxFzW9Kb9bqnekp1XSqOi
 l+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w7V/R5aqGEL5lA+qPqhrRRb3+qSsT4RaJbhumZr8H2U=;
 b=giHvkrRj0TGXlCzqbSBhKAyCYS0DWBLeSniC7CIcgBzEC9FgNBS9w83nBjqF/lvJPd
 sn8a+/iSuMANjxObmJj1hGH/T8dGB337VLbtK6TZf/EcFDWFkHLjNJesoRaOl1mKUMJS
 ApaGHUJp17AxfHAgrHaGsLaUJcqlyszQ/YEcLzi+VYL6NheTfeJbWuFt3N8vGzmtdA3K
 FXgXLtK7KdpIZkzKmAP3d6P+jbxnSOce2CoopLwJ1H2PU2s/PZwly7OgLSG7MYQA6GqS
 q/mlHMUdHBX/TjjkzhrrEJ4eKAdF0kby9kdbRX/YyKc5yIlFZRy5K/d91kw1sgAcQL0U
 luRw==
X-Gm-Message-State: AOAM533qhOVh+6/Mka9r4dVteIemIYei6KqW85X1AeEPxYXWLvDV5Zci
 Ku912liC0zkhSikVJdM0XAtAJ0/bDl7u2271Zzn+JBUC
X-Google-Smtp-Source: ABdhPJxfqR9SzKz9wX1JocJVe1dZNGZbUPMaE0sAlzHIuVscsh55caCYUCYVFyKmpaAnymyk37rn/GhxdwpJsE4djes=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr109126oap.253.1650398386351; Tue, 19 Apr
 2022 12:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220419193751.1856508-1-shiwei.wong@amd.com>
In-Reply-To: <20220419193751.1856508-1-shiwei.wong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Apr 2022 15:59:35 -0400
Message-ID: <CADnq5_P=a8kn2R8PEy+A+8ZMx56iLoLD50k-h2C28mim-VAUqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Execute IP's hw_fini when hw_init failed
To: Alice Wong <shiwei.wong@amd.com>
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

On Tue, Apr 19, 2022 at 3:38 PM Alice Wong <shiwei.wong@amd.com> wrote:
>
> amdgpu_device_ip_hw_init_phase1 and amdgpu_device_ip_hw_init_phase2
> call IP blocks' respective hw_fini when hw_init failed.

I don't think we should call hw_fini() if hw_init() failed.  If there
are things that are not properly cleaned up in hw_init() fail cases,
those should be fixed in the relevant hw_init callbacks.

Alex

>
> BUG:SWDEV-332449
> Signed-off-by: Alice Wong <shiwei.wong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ec38517ab33f..3abe647bbd2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2281,6 +2281,7 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>                         if (r) {
>                                 DRM_ERROR("hw_init of IP block <%s> failed %d\n",
>                                           adev->ip_blocks[i].version->funcs->name, r);
> +                               adev->ip_blocks[i].version->funcs->hw_fini(adev);
>                                 return r;
>                         }
>                         adev->ip_blocks[i].status.hw = true;
> @@ -2303,6 +2304,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
>                 if (r) {
>                         DRM_ERROR("hw_init of IP block <%s> failed %d\n",
>                                   adev->ip_blocks[i].version->funcs->name, r);
> +                       adev->ip_blocks[i].version->funcs->hw_fini(adev);
>                         return r;
>                 }
>                 adev->ip_blocks[i].status.hw = true;
> --
> 2.25.1
>
