Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2216AC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 20:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8272077D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 20:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuHWq3je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8272077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B0488D1E;
	Fri,  3 Apr 2020 20:51:29 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B705D88D1E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 20:51:28 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id m17so10067781wrw.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BvBBrbFb8XK+WFnOToSsQAGHqDeLwBEK4Mb93LtnWLE=;
 b=YuHWq3jet/ruGJ59dxf4LlqZ2FtGCt1+RQ7V4q22JUeyaDYSILv10hymWMaci+EECx
 vUgTNOXTKqb6KE8Xfe7CVXBnXUwX+QOBny6YinYGPA+3iRnhUfWy8kCpAy0+otcFbJjs
 BpTQhfpYRCprE8q1SGTsTps1xJnZwsx1VW6jUb2ZoI1sTXF+5LUnrdIvvDopT3ntI4Ui
 PlnDjMK5Ft/aCUKEgfzeUYMEMyoO+AuL8bmSIvpgZYyYpBF/E00hOogRMvIau4GC3tmO
 rl5EA72BkibJI+DviAwCz57G6IAzgcKz2Mg7MfLVk/URQraHScg2kA2pBaOqLDVusmgy
 ZoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BvBBrbFb8XK+WFnOToSsQAGHqDeLwBEK4Mb93LtnWLE=;
 b=ebEFF60Or6Gk10dvXxEoiRtrdySIub1l4kTIH5xKrffTBd6Gww1nfarnDAo2hMBMPk
 WeJeAXbL5CQ09SzJbh00vefvyWXIDTODj/cfCHrka/Ss1CAgJDWBolEh1DtqsHaxHXER
 TI/BxinVV4uhHIBYaalBZim0B+gj5Upi4JPy4i29FheMJx845q6Z55gg6TMUZgvW5lLM
 hL1Gojm5aAIPLML9lzlm80zxIsi8mx+QEoLrDKOek0AZgR6z/FqXLhhriIsRYq7hcD4U
 mJiRqy0dHmnhW/XVSFzPmmRWphe+FdtIuX9BDNviDKShf6qhoL10vWPqRYKKByZuM4ED
 uyQw==
X-Gm-Message-State: AGi0PuYjAedsRIzf/TOC9OknLLJs99VEti+t1Xhe3CZwbyeixwQonL4w
 pdUrSdCzYT6zngVfvgaThwUp5arE7fI2NQFQfC/7VQ==
X-Google-Smtp-Source: APiQypKB2luQh0EvWr6STj/umORMf5tUBZ7c/EqIAnIzKy5Ko5HzOY4djxliJF+yHWOVZVrgYv6vuXUgEeUXG+VpcbE=
X-Received: by 2002:a5d:500d:: with SMTP id e13mr1809365wrt.362.1585947087392; 
 Fri, 03 Apr 2020 13:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200403170856.7397-1-kent.russell@amd.com>
In-Reply-To: <20200403170856.7397-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2020 16:51:16 -0400
Message-ID: <CADnq5_NfjqeS0AaEom0sTMjs2cD8kzcaw3ZxXMVg8Er-f8676w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models v3
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

On Fri, Apr 3, 2020 at 1:09 PM Kent Russell <kent.russell@amd.com> wrote:
>
> There are 2 VG20 SKUs that do not have the FRU on there, and trying to read
> that will cause a hang. For now, check for the gaming SKU until a proper
> fix can be implemented. This re-enables serial number reporting for
> server cards
>
> v2: Add ASIC check
> v3: Don't default to true for pre-VG10
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index bfe4259f9508..508906177cad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -31,9 +31,27 @@
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
> +       switch (adev->asic_type) {
> +       case CHIP_VEGA20:
> +               if (strnstr(atom_ctx->vbios_version, "D360",
> +                               sizeof(atom_ctx->vbios_version)))
> +                       return false;

Most skus are separated by pci revision ids.  Maybe it would be more
reliable to check that than a vbios string?

Alex


> +               return true;
> +       case CHIP_ARCTURUS:
> +               /* There are no gaming Arcturus SKUs */
> +               return true;
> +       default:
> +               return false;
> +       }
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
