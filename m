Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0438C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 13:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569F964F10
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 13:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569F964F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5FA46E07B;
	Thu,  4 Feb 2021 13:38:04 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7456E07B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 13:38:03 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id y199so1701580oia.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 05:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s/tmISbzv2R76TuPIVJY7IODXZ3yBkl0a0jPPEbsSyQ=;
 b=M3LZxQvH/F4XlJMJ0oeSTDINfXhcX6+Q7JQK+9bis+qlqdLZELvo7iztUBVFG8QdmY
 Q7Abs44W7oYvluuA+3JxPAszYDZPQR6/tESLEMT+2DedM1NgQilsNS3hTGuJ3Ie0r9bS
 IluHwozMeqw2YCpewnvapNI7O4BIsjcSPja4luEr44VzJFs4aH5dLEFY1fH7NIyxyOig
 Bim2C9Q2purYXbKXPNe7hIIRLR16DzrktuH7H0OwHUu7NOPLN9xJiHhk3Bdcnodk3hFV
 3kYAk39u3pu5po3795fIo8M23nWcPNL8fBtJZXz33xxhaaiokMNDc1YXw4q3TyIJpMHj
 rwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s/tmISbzv2R76TuPIVJY7IODXZ3yBkl0a0jPPEbsSyQ=;
 b=F5Y2nGTZHjCvBLmEN62PyADNdQLRPiK5i16DPa+G213Q09ywmupe2E2OZJsoZlnYPS
 X/xUtgNtZ+M/Yl43RkB7gU3ZgwH6izbl0LFDueakrCt1GZk0B5xF7oYFOWtcH1Y1r+uO
 6Rq9Fa6WOkqatPoNku4xhZ/yndxEetq0QpfYIysRlSFdWNTG4iGob2fcMnBaJrDHhhNW
 cnaRxKXqE+61sgNVEHnSeTYbeHE1h9o2xTARk0WbddiVyBcwDGxPshX2WRVtGGzO/7Ej
 hyGfB6T9qAaBfsYSB9nw4NWB5Ul47W9MFGqmsqYMzJspLtv9e9UJMba6CFOm8z/+1oCC
 pdAA==
X-Gm-Message-State: AOAM532I6CkZ0LqDikQ1QGKpc2Vk5+A8DO2xGXyZozb/4Rws4b5QH/OB
 QS/WLJPtNRXkRDncOLdEyi469f8D2WHt+MOUSqM=
X-Google-Smtp-Source: ABdhPJytSBvUWX23SCOG2g17OmdhWxk6jVx5YtXbmQlkqWo8QRK5L55Nlqp2uBEv5wP8L0dpo80v7fuAZaec4n/VYtg=
X-Received: by 2002:aca:f5d1:: with SMTP id t200mr5040210oih.123.1612445882366; 
 Thu, 04 Feb 2021 05:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20210202061555.5731-1-Wayne.Lin@amd.com>
In-Reply-To: <20210202061555.5731-1-Wayne.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Feb 2021 08:37:51 -0500
Message-ID: <CADnq5_P=q6u7j4RMW4jerZsJi2iLa2wCcfQYxtOFoygSJm07jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add otg vertical IRQ Source
To: Wayne Lin <Wayne.Lin@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Feb 2, 2021 at 1:17 AM Wayne Lin <Wayne.Lin@amd.com> wrote:
>
> [Why & How]
> In order to get appropriate timing for registers which
> read/write is vertical line sensitive, add new IRQ source variable.
> This interrupt is triggered by specific vertical line,
>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ece1b41a31f9..3777f18fb1d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -852,6 +852,7 @@ struct amdgpu_device {
>         /* For pre-DCE11. DCE11 and later are in "struct amdgpu_device->dm" */
>         struct work_struct              hotplug_work;
>         struct amdgpu_irq_src           crtc_irq;
> +       struct amdgpu_irq_src           vline0_irq;
>         struct amdgpu_irq_src           vupdate_irq;
>         struct amdgpu_irq_src           pageflip_irq;
>         struct amdgpu_irq_src           hpd_irq;
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
