Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E17DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608F82100A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIF3+YFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608F82100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE546EA72;
	Thu, 18 Jun 2020 04:31:28 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BD46EA72
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 04:31:27 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id j198so5775584wmj.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 21:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WJEQDCwMKH5C/eQhlK1mbwLJDtMn+iV7Gsb0NnAidRs=;
 b=aIF3+YFDcrZy0Pb6ABoWal6+B4xjRj7/j+X0CfdZuc7h9vBIsFaIKNN0oKgJMw5um+
 +YGBh8qp6zX7jOT4rzmmuuwUW+tOovbxbLlFMr6sAhKtH1zuHTByX70RrXFwJV5N7Jes
 eN/Nz3cE01nVXEmRFzQ0mT6/770Py4SSx934E+By9VZeOIKX+i+xvA4H8tPKbHO4i5E9
 C0ORavXWeYSOfnTiVi4Z9Vq9OVW4xaUjBhyPdGVVwn96y+xWQIGy1TiBHFTaohWS5uk3
 YM07avbdQxYcr2Q55IsZOjqxC16Aq7v3Sw/ieQyChqN4GwEAX0HVs2PE/PMqhhZGVLc7
 cvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WJEQDCwMKH5C/eQhlK1mbwLJDtMn+iV7Gsb0NnAidRs=;
 b=hhQ5MNc3skBgmlLrl+6kK+TQSbYnuqnhs5RwSTJB9Qebw2hQ8keIOIoLicnHegUylY
 3LVLt3XPd/g/g0CzOCZCyXQx/iInLaaUwM7VojO4NQGvQjrp4mHj7P0MYS22wWhLE5RV
 vJo3yZMiBBCTaO4s9Qmrwthbo+DKbuMgka+AGPb+HEBSq9lIzBElm5K+yvcaphdipiIS
 X/B2iM70s5Uu0ETs5x/w50BekjOoqFl7VxigijUu9lF82lSySyf98LCRFks3hoS2xtLw
 ZD81nMMeCcewvJb2dcXhvfYW8q1RYdye5O/SBjn15rexqwvsDo+Wqt7hv+Baj0gzFvvw
 uFQA==
X-Gm-Message-State: AOAM530tTE8JIJgyxfPSs2jT3j2yktq9o4X6qHWGtainD3qWXN9K0ZCE
 BrlEFG7G8CelirvPB78kyCgoN9iXgme1rzwYuE/9OQ==
X-Google-Smtp-Source: ABdhPJxk1J1dGaNGKPXitNmw6jutU/IsHwhXI3xW0FqiWhJhPO6C7OCuQPnIj/O+oKuhd7r6uuCmc1kabDbsENdAkwo=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr1948685wmy.79.1592454685856; 
 Wed, 17 Jun 2020 21:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200617220016.4844-1-sonny.jiang@amd.com>
In-Reply-To: <20200617220016.4844-1-sonny.jiang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jun 2020 00:31:14 -0400
Message-ID: <CADnq5_N4sC0R9HrnX2KSR4U=9mEaH2+7L0oW1j-yH+bQkz4W1A@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm amdgpu: SI UVD PACKET_TYPE0
To: Sonny Jiang <sonny.jiang@amd.com>
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

On Wed, Jun 17, 2020 at 6:00 PM Sonny Jiang <sonny.jiang@amd.com> wrote:
>

For the entire series, please add a patch description and your
signed-off-by.  With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/sid.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
> index 7cf12adb3915..75b5d441b628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -1646,9 +1646,10 @@
>  /*
>   * PM4
>   */
> -#define PACKET0(reg, n)        ((RADEON_PACKET_TYPE0 << 30) |                  \
> -                        (((reg) >> 2) & 0xFFFF) |                      \
> -                        ((n) & 0x3FFF) << 16)
> +#define PACKET_TYPE0    0
> +#define PACKET0(reg, n) ((PACKET_TYPE0 << 30) |                                \
> +                         ((reg) & 0xFFFF) |                            \
> +                         ((n) & 0x3FFF) << 16)
>  #define CP_PACKET2                     0x80000000
>  #define                PACKET2_PAD_SHIFT               0
>  #define                PACKET2_PAD_MASK                (0x3fffffff << 0)
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
