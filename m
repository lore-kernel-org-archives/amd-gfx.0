Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790FAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B95C10E33D;
	Mon, 24 Jan 2022 16:53:51 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6FF610E33D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:53:49 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id g205so26387077oif.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 08:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9LnHQ/E9bXC2hZunDtDaXQkCKPHQbVrtu/iIfItSUqs=;
 b=Q34I6xAd/iC40Lx3pKThvnFxZQCO/OraTBead7ek8hlinkkLqlGocRKnFpk6gDqS8M
 xJD/HgUcm2g41CpEeSfO1vxzrHYFbOWM+aMeaPhx7Uhg5WlAw4exNpDW04v526cPeICE
 l26cQS07nLz0fZkQRNQuegLQtYuqwhnCC85N7V9skNcKVQOVygcxCNnsd+ZegrKVEm9Z
 lKx4cfxGDYBQRNrv54UG0unh78kgNShvJgkIvxlicZilU4VH/JG/ESit0jL+eTvFqT+O
 PYwrvg2EB4fPpO77q29dRP0MfY5Pj6MUbRylhl+4QGQLYmoIlyH0bDca8bb0TbuL0qVm
 vS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9LnHQ/E9bXC2hZunDtDaXQkCKPHQbVrtu/iIfItSUqs=;
 b=sRFP9YnUsokabzM4tLkAUVAuwr5+BUjvsvv6ZEJfoBE4UySBEV7kgS10oj/90wM4bO
 vHhzxh2k8hKIuNdqkxYOqlV09TdxwL5W26kf4HBs773ggNnhxJJmZdY2IpOhLVPSRd6L
 OOAJdJwQRXvxd6eHZmCYhOJ2p2BI3YRq6DnJSRUE7Ao9Z/vRozq9ajgKp/4asN+0ID3o
 AD+WeLa/DUdbatLbEHr77sNleRhQA8oTbLaiqR1eASOMJ1/wXhOm/ZMXwwUyOt5Nb6yA
 9Wa6OQq37OJu2VmtrBYYZbopKSftXacds9pDbBLZor14FYZuGCEaN+eXqYHhC+AOokYO
 W1Fw==
X-Gm-Message-State: AOAM531eCx9m/kmBgElwqCbvT9/YUTX906wgtjuQmd2c+/YyCQnfl3W2
 5hracI69ilU+xhgr3zEsxL67GrRsLFmcGjVSRxEa9xj7
X-Google-Smtp-Source: ABdhPJzjgnfTiSbDivwKZvz9XZwu2+lJogJZXs0vM8S8xuyacKsLKWrGaMtIu1UalG6M9ICZGsPRx/ydgWMkHZYpJgE=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr2214228oib.120.1643043229014; 
 Mon, 24 Jan 2022 08:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20220124064525.1357499-1-Victor.Zhao@amd.com>
In-Reply-To: <20220124064525.1357499-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jan 2022 11:53:38 -0500
Message-ID: <CADnq5_M0x9Y38X095Di2mYXVTVm4Pi1-w_F0gkempSYhSkfUWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add determine passthrough under arm64
To: Victor Zhao <Victor.Zhao@amd.com>
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
Cc: Emily Deng <emily.deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jan 24, 2022 at 1:45 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>
> add determine for passthrough mode under arm64 by reading
> CurrentEL register
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index c5edd84c1c12..40803aab136f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -296,6 +296,8 @@ static inline bool is_virtual_machine(void)
>  {
>  #ifdef CONFIG_X86
>         return boot_cpu_has(X86_FEATURE_HYPERVISOR);
> +#elif CONFIG_ARM64
> +       return !is_kernel_in_hyp_mode();
>  #else
>         return false;
>  #endif
> --
> 2.25.1
>
