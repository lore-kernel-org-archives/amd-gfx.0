Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACC0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B1610E085;
	Tue, 31 May 2022 21:13:49 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873FD10E085
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:13:48 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-f2e0a41009so82941fac.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=12XZpQdC8+uvm0usWHwes1yZPDjEQcYjdr1R6xF6+TQ=;
 b=dbf7Pw9U2qk4LdFMZa9QJ+QoWPwzFd10VJb9TaThPjnocLc17Eix1WBFsmJN6q3lSv
 0aPGnd1E/Hk6D79GIt3ATD9+CHjzwPDVyxFgwUSw6iXaQZs7b0JzZbiQuON8prbeD6hS
 3/y0sJzHzzBmpCiCa54gvxbKM4zTDCFY5ZxfndLgeB7zTzAerpQQQYLM2XNXeQXDiIgN
 gEdzB1o3sS7npWrVbUhGqtrytk9huC0AJZPITPtjw2vlP1ATpUXYoCfh1LRcIFxoeHrP
 3bMq46vk3kUW14SrRh9fGFZ1/1lXje9YHvDcCKLXm+cNbgMrbXLS5xADVwOjc4gR4VFi
 fNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=12XZpQdC8+uvm0usWHwes1yZPDjEQcYjdr1R6xF6+TQ=;
 b=judBnzpz8ZGTuIuHQgCZ2VTtnWh2JzAReTADJucl4c8pGvOSbttB3LYVfgRzfLwM09
 c4fsz/QR6mSax1uyfmNqx6lMUe784JMk+VUuI5p0EdkDFp4Uhes/gyD/fbF1nOIu+C5s
 xzWDJS8kwjMnjjJTbPO3gwc4BGZnNb4ldgY/D37qZqa36EI6AlOHjWbZhvULCDLl9Lik
 D5zjfXGUWDpgu0uupU4rhCpmBZdDhZv0df1TkEI3fRsUxUokaMGTUK5wb1TwiID8SHRY
 JMqHo9clYXCpAWOu0YRqlgv8ts1e033YjbvKrS09iLnSlQ0vRCFrZSnYUldSV+rkQA0r
 AcGg==
X-Gm-Message-State: AOAM533bRxsBYkaiLiBA+CWx1PUtHunVGSWeJw4aUmF2/FcqrZaHZjrc
 sa2Tg+G5W7NyY9g/YFkGs+OGIkJjPfwj2nVOatH05vfKH0M=
X-Google-Smtp-Source: ABdhPJy4AMO6rFrZfaUYm847AQD0KFXSKrS+CXd8AMSA5HC9N6cMXT9VUhR0bWuqS2ZYgYh8B8yUM/jqEr2SjYkB8nY=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr15540054oap.253.1654031627869; Tue, 31
 May 2022 14:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-7-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-7-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:13:36 -0400
Message-ID: <CADnq5_OpVCU+KMmVwOC9+ZoEpmA6eAEWrAR75JD6UPDSwB=aCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: convert nbio_v2_3_clear_doorbell_interrupt()
 to IP version
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

On Tue, May 24, 2022 at 10:09 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Check IP version rather than asic type.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 6cd1fb2eb913..34c610b9157d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -547,7 +547,7 @@ static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
>  {
>         uint32_t reg, reg_data;
>
> -       if (adev->asic_type != CHIP_SIENNA_CICHLID)
> +       if (adev->ip_versions[NBIO_HWIP][0] != IP_VERSION(3, 3, 0))
>                 return;
>
>         reg = RREG32_SOC15(NBIO, 0, mmBIF_RB_CNTL);
> --
> 2.35.3
>
