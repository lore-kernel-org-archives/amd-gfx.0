Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A74C54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 19:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD2D20704
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 19:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knNPV9b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD2D20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28D46E9B8;
	Thu, 23 Apr 2020 19:31:16 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8576E096;
 Thu, 23 Apr 2020 19:31:15 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id h2so7746653wmb.4;
 Thu, 23 Apr 2020 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fgAZVOCSIveiuqGce1ll+R4dfIKogGqfZA6esAftSZo=;
 b=knNPV9b5pYpSRUOTLC+KLsUlCy9+s8M/aHaNwAEEc+coAm0Zro7GGhhs0Mf18UjMCk
 Jy3Kt7savdetdbXCxj3EuD0rloEFKCjOo35vvYb6xP/E59wRwRRjFHwuna3XNXp4CoXc
 /nrSqm2IgnEsTlOOXi7K87G+2ccTLb0x2Vt+GnzLU8eRdKLrLtssOb9jyLLol5JzKz3j
 5HogzgY3hb85+VCO8EuFrXJdw+E30xtlAudgmmM/r9dJ8C3lBzojgYhs6mZT61ZGk7Lt
 upjp+TdAjLC9w/XqRZ1a1qKeIG4q/YDKILPqf0VnI6/TP64WAXOcy+hqvijN0zeNHD9k
 Q+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fgAZVOCSIveiuqGce1ll+R4dfIKogGqfZA6esAftSZo=;
 b=YclBX2undpnZ6gcBW1V+HV7rFrXj0EnerEsrVfD14UtUAcSpVoObkwIqY1fHEawxOz
 sRfsSOgpWrT1kQTPDETr2/7lZe6bAxNRnBLtQEA6roU6YPJHIp1ADUFi2GTfcb/6QsFE
 PZbTDgWjJqmDajNH0aTQzUnZ4GdJdhsZSq+wSimuc1Wr21POMs+OIfZnr6ZFublfdRu2
 YPXKVGGgx4k92lolNs5R6gP5byKI022sUVqykLJlcONhSQ2JPcKxIiwOguj83B06xbR4
 zgmzTekqZQfIBi6itkkuGjJ9dmeYB6zXD+VQOBt4zjTyzEEOGiDAr13Tna2/v4lpyuWQ
 nA4w==
X-Gm-Message-State: AGi0PuYeQwjVmqRf/PZjMh7Rlxucj/KEAbuF4OcPKslCHf0iZzfYzZYj
 DqchZTBRcNiDkabOOPgQOm1Szcyi9XeDUuZaotI=
X-Google-Smtp-Source: APiQypJ6GT/p5QCtXDyj6Nc/UccKUVDP9vSEuI76TETHj+tm3Tp7yVKfb2mtdWEzWQCVuoW/zENlmPdp16iR0w6s3pw=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr5917826wmb.56.1587670274438; 
 Thu, 23 Apr 2020 12:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200423141728.19949-1-colin.king@canonical.com>
In-Reply-To: <20200423141728.19949-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Apr 2020 15:31:02 -0400
Message-ID: <CADnq5_NWZaUeBz8ZyWF_+LFc3=NXiQYJqbj4cMsyBReASCbcEQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant assignment to
 variable ret
To: Colin King <colin.king@canonical.com>
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
Cc: David Zhou <David1.Zhou@amd.com>, Leo Li <sunpeng.li@amd.com>,
 kernel-janitors@vger.kernel.org, Wenjing Liu <wenjing.liu@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 23, 2020 at 10:18 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index d5b306384d79..9ef9e50a34fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4231,7 +4231,7 @@ void dpcd_set_source_specific_data(struct dc_link *link)
>  {
>         const uint32_t post_oui_delay = 30; // 30ms
>         uint8_t dspc = 0;
> -       enum dc_status ret = DC_ERROR_UNEXPECTED;
> +       enum dc_status ret;
>
>         ret = core_link_read_dpcd(link, DP_DOWN_STREAM_PORT_COUNT, &dspc,
>                                   sizeof(dspc));
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
