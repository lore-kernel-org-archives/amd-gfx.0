Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE41C388F9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 14:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD7124182
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 14:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lcgl8Reh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD7124182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBD36F585;
	Thu, 22 Oct 2020 14:13:53 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D667A6F581
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 14:13:51 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id q5so2441668wmq.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=enF/NQ78UlHZi0kpjlRMqO+lesxBNMFNnWEi966YlwU=;
 b=lcgl8RehFALlBvKW+2WEqI6hL3DQCvnayUx386YFYdIACL6eZdDekWSge6wl0xau/P
 OurS80PGFdE+uCz2ywydsXe1KEcW2OKxZnMZUyxNDMbbrQ0IMr0SI/JTRmyVAXaE9J1O
 hmmezb9rcO1k/LRCAp+BJe5NUZwtKmz2hdtkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=enF/NQ78UlHZi0kpjlRMqO+lesxBNMFNnWEi966YlwU=;
 b=Z3yzlFuwd1aXw8OqngtKHZyTriGH9gWzskxz7qFzdLIrr42XxmC3yRHXG+JwzZnp7K
 q/joI76nc14qQDpkUPNyxyRwT45mXjrOx6O2bYesDgebhcAnTYJZiq0+EVnOKqSIYDpd
 TxKPswe5kYz6n5lFBAout5wmnZApaaptHbD0Ugu/Dsn4YBR7HbxDohehT/6HkpQ+e6cv
 mJpChuhih366jx5x2qAsvCBlbhumYqLQloAa1684sDhvOSwo0g2x1l8EEhyI0kNuPlHP
 Xpr9KnK/cDBW6QVdIv4GFv8QJbFRt0GyBkr0jsjpVw6iZ3bVfLNodzbehal6FTpjRLXT
 w7QA==
X-Gm-Message-State: AOAM530e/8b34NzT3CpJ1og7bG7xBh+AIMy/H1YRSI2Uj+d7KDu7maqI
 vNJ16IF70UOpACENWp10FVYmAQ==
X-Google-Smtp-Source: ABdhPJwHYDGIRoRMV1tiPrqE+G8DvABiHKwtdx9svGn7vK4QZAvd1J5pyjsiQ/shrV+Vnd5qklpZ6Q==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2863073wma.95.1603376030491;
 Thu, 22 Oct 2020 07:13:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y4sm3726390wmj.2.2020.10.22.07.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 07:13:49 -0700 (PDT)
Date: Thu, 22 Oct 2020 16:13:47 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: Re: [Outreachy kernel][PATCH 0/5] drm/amdgpu: Replace snprintf()
 with sysfs_emit
Message-ID: <20201022141347.GZ401619@phenom.ffwll.local>
Mail-Followup-To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
 dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@linux.ie, melissa.srw@gmail.com,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <cover.1603371258.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1603371258.git.sylphrenadin@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
 outreachy-kernel@googlegroups.com, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 22, 2020 at 07:07:50PM +0530, Sumera Priyadarsini wrote:
> Using snprintf() for show() methods holds the risk of buffer overrun
> as snprintf() does not know the PAGE_SIZE maximum of the temporary
> buffer used to output sysfs content.
> 
> This patchset is a series of Coccinelle cleanups across the staging
> directory to convert snprintf with scnprintf in the relevant files.

I think you need to edit your template here since this is now drivers/gpu,
not staging :-)
-Daniel

> 
> Sumera Priyadarsini (5):
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
