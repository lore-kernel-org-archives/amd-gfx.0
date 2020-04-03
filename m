Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28DC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B28B206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0LgrT0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B28B206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81876E15F;
	Fri,  3 Apr 2020 16:36:29 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030466E15F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:36:29 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id g3so6978105wrx.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vRK7D6XRv4qzF88vfUoq8jXuhP4RkRq2ayitougv+xM=;
 b=h0LgrT0ML/+Z8k4GI6u296BnA9OD7zzm5s5dZd22rmFb68BtCjtUpFFiFnCKB0ZkC6
 zEd8YReNl4/f8rVH7/Q1GCEXHG2fiGS4mQrtBVTswr2J6RndbsIfBndFx3LpBjPac8aC
 cjmwWVg8IfX4lvUfm6Q9EdXeY405R7nIK1fmfBdf6Ipx4FinLrOZgV7eQSjaKQVYV0nq
 DkyRPGgtRG1EGIH9Ax5gF0lMUseEyRzuBO/oKL5rj0kYk4BW8PC8udkP0OlxSBPhz4+f
 Fwu+uAy4v0g4qaMV7Bj7uccUsGqjAnxdpXUzM9CGoGQsCYVHMfMSxG8zPdlHiZ0T4P5N
 6bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vRK7D6XRv4qzF88vfUoq8jXuhP4RkRq2ayitougv+xM=;
 b=NCAizyExr4kTrY6dHzrmEXEiZ6tnvKpfVNUMMOnHmseRd9W7PcztknYUUstqGxpSw6
 eBMOOs+26w+bIbvYnMX0O/2zIPCFWz2gRUGjh8EuF/vlx5N1uBUuG9a8BdLP3aoqOVAP
 CWJi2uY7n/JMIj1heudnACRLQ8EcmfcQI3I6cicMlv0//TqanoggLKJrRqHmt8YvPPwy
 YtwFkyxRoqAGvIpGUX/tpC93Lzj+f03cK1gmtb+Et+u1pYZ1KQPa4/9D1VzJgyDg8qh4
 jAZUlNmd76wjKJ9lwmqpYBA3xS5RqwO/vT/x5tCawt9aYxYVxxB56TZ8uflRlrSLdm17
 tG4Q==
X-Gm-Message-State: AGi0Pub/2SFk++76D1bEKj9dK95aJwZLQ2UVWG7YnAoDnf2WQGJSR1Dt
 EqlV4RjZWsOqe9jWKDuuAdJuf2Wl+Qdn6Wu+rHw=
X-Google-Smtp-Source: APiQypKBh4u6mJ6lcWT4KmiZ5bAzYYqMxNcHpBmd/7rR+nLC1s23uqRm9Vyxwio3xfZzVjS4BpJcQKUmTq87ya5f4DI=
X-Received: by 2002:a5d:45d1:: with SMTP id b17mr9827888wrs.111.1585931787674; 
 Fri, 03 Apr 2020 09:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200403163035.19177-1-kent.russell@amd.com>
In-Reply-To: <20200403163035.19177-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2020 12:36:16 -0400
Message-ID: <CADnq5_MXO7sGC4ThC=5xxxvOUTEo3c1d5h-zipQrC9UPaYg+kg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models
To: Kent Russell <kent.russell@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 3, 2020 at 12:30 PM Kent Russell <kent.russell@amd.com> wrote:
>
> There are 2 VG20 SKUs that do not have the FRU on there, and trying to read
> that will cause a hang. For now, check for the gaming SKU until a proper
> fix can be implemented. This re-enables serial number reporting for
> server cards
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index bfe4259f9508..9582469a70cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -31,9 +31,21 @@
>
>  bool is_fru_eeprom_supported(struct amdgpu_device *adev)
>  {
> -       /* TODO: Resolve supported ASIC type */
> +       struct atom_context *atom_ctx = adev->mode_info.atom_context;
>
> -       return false;
> +       if (!atom_ctx)
> +               return false;
> +
> +       /* TODO: Gaming SKUs don't have the FRU EEPROM.
> +        * Use this to address hangs on modprobe on gaming SKUs
> +        * until a proper solution can be implemented
> +        */
> +       if (adev->asic_type == CHIP_VEGA20)
> +               if (strnstr(atom_ctx->vbios_version, "D360",
> +                               sizeof(atom_ctx->vbios_version)))
> +                       return false;
> +
> +       return true;

I think you want to default to false and only return true if it's a
vega20 and it's the right vbios version otherwise we'll try to fetch
the info on all asics.

Alex

>  }
>
>  int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
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
