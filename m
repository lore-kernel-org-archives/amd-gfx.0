Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D35C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 19:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62B860D07
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 19:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C62B860D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1D389E9B;
	Tue, 12 Oct 2021 19:41:49 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B0189E9B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 19:41:48 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id n64so750198oih.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W42CSeWE9XEzYSfq2nEFL+VJ+Fa8bWMcXqst5FzLBBk=;
 b=LuAR85NoUsKVEc+ynnKEZ+KBKwYpjUZzubPMvms+3IQVMPcyPuRbB27UYGHDLa9xs+
 oh8QRRoW3rpk+WlXwlvHei/1HV4WCv7WMZ72NANjRg/qlWYFr3t1c/0wcchdDf6cUNs9
 aueNrJCjVUQhNzda/M7vZ3AGer2dRucxYwLz5OptQpHBp+Jn1JWT2RtJMCkKRNkVUjKH
 wfAU3H6H2aUyYLPyaNTBP2wpYJr6E/+vlLFqMyvGfT9li18v2fsRdLzerCe62+6rHh6E
 Lu6mFnCHKIPAc/SGiBJMA4ei0TFBRG8uXHvMzw2zIhRW5wDyPuRLgqqL/Jg4XeYV8T0S
 o+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W42CSeWE9XEzYSfq2nEFL+VJ+Fa8bWMcXqst5FzLBBk=;
 b=0z9lrGNp1IoYovZ8SjI/lyYwgDUWiIcKEgkTtl37feGhhqm/mhkf6EdZphF2FplYH4
 z2BcO6NzATJmypbKwwSjcrmnQrSt/dY3rWReR0qnjkM5V5bIlTzs10GdSz6R2Piyh86u
 SWue9GYywS3TXVH3BcqdohHmFY61Tzxk8wrgQ+lOWON1Hc+wx+BrnOQ3beuc2mhYqlvm
 C7us/UXtpZ9ORX2Qq33/fRH82wCHMRsyzMXlswenz7Fk34EW7U8+SXAkjDLjGXdkdNKM
 iIh87W0ztpXRoN5D+GPUGeeBC07ycEftSGWXcteo+Q+irPwJtsVzh3B1OgDM5d1CYfZd
 tFCQ==
X-Gm-Message-State: AOAM531NKV22EBppOyBu+0Jertn4fENFoLxjHGXPe78yd21NTcVlcCUZ
 trhkKINTTlHOiI9Bu6bHoKMAG1jf0Vvz9Disg0QhYjoamkQ=
X-Google-Smtp-Source: ABdhPJypKaj4TazYuz6RAcXfS5z2e5Amzm7dcvr+UtIDSE6WtX1D9Z6QTWNlGwZwtD/L+n5bBtZuZFiSbaqULEILum4=
X-Received: by 2002:aca:4587:: with SMTP id s129mr5004339oia.5.1634067707869; 
 Tue, 12 Oct 2021 12:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211012061605.809634-1-lang.yu@amd.com>
In-Reply-To: <20211012061605.809634-1-lang.yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Oct 2021 15:41:36 -0400
Message-ID: <CADnq5_PPkGYkYGxQ7gXhZexGmbCEO44-YziW9R47HaCxpvb64Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable display for cyan skillfish
To: Lang Yu <lang.yu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
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

On Tue, Oct 12, 2021 at 2:16 AM Lang Yu <lang.yu@amd.com> wrote:
>
> Display support for cyan skillfish is ready now. Enable it!
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Whoops. this is my mistake.  I lost the display enablement when the IP
discovery patches and the cyan skillfish display patches crossed.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 2bebd2ce6474..4228c7964175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -736,6 +736,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>                 case IP_VERSION(1, 0, 1):
>                 case IP_VERSION(2, 0, 2):
>                 case IP_VERSION(2, 0, 0):
> +               case IP_VERSION(2, 0, 3):
>                 case IP_VERSION(2, 1, 0):
>                 case IP_VERSION(3, 0, 0):
>                 case IP_VERSION(3, 0, 2):
> @@ -745,8 +746,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>                 case IP_VERSION(3, 1, 3):
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
>                         break;
> -               case IP_VERSION(2, 0, 3):
> -                       break;
>                 default:
>                         return -EINVAL;
>                 }
> --
> 2.25.1
>
