Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662FC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 15:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443E720675
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfruF4Ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443E720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10A06E4D4;
	Mon, 11 May 2020 15:33:23 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96386E4D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 15:33:23 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id y24so19857221wma.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nI6XvQ59EWed5qCOooiN/LplfzcdGqGFReJtn1fBlrU=;
 b=HfruF4TykJF4O5Ttmmm2+T2BZxwpczqN2zgyNDmNztI5+ZZz9JVh1pELHpgmyqvogp
 PywCBMyCrcZcpicqirez12HF0yY7SAJf40ljI1b4CNO/GDKiB35kQeCPiLphne0U03nU
 ryU9Nbf+8KRKUJWLzkPcvMVe9LhjBaVFe7IBZG2ZrAjjLOZ5PQvqmRlDtbuZxPxaoOtP
 PknFXkJLHolISLnD98qfS9u/Ptw6i/GMXLuUw35PyRHf1lbeocN+iyG/ijROnwYUm69w
 GF5bIWz1oqjoHuQLy2Zy2Fs2YRzZGuyOqR9CKIsXEsoc91ntDbIWO8uuFvY3wkLP6D7G
 jVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nI6XvQ59EWed5qCOooiN/LplfzcdGqGFReJtn1fBlrU=;
 b=ZmqEppzTWyS7Vsppte/vfYg30IQZAQG/0KI06gjdhbNdXhFKsbKGRjOkXtDsbCq3NH
 mKaxaME6Z6GziY2/0/Ww03aEVXuD1xLi6s8ALnuMGvlXbFRQmy4dsEGPmgrby6ojdO15
 rJZRvK9Zt5l615ZIDWPcSldEEpx6OG0z+XVP8h/28hemEKjY7cJvguoN/xUYBTozxokL
 76i0S3BYt3oIMRHY4aDZguh6DPdSf+MzdEFu9qzYdxkuknGfqmcQhO3r/0KLE5/wvPam
 AEwyvd8T004qPjUuEgEOOyh0ghP8gwEIG90Q+Cw5w4QdH25+B9ksFTHuKBzrovvoaTsJ
 bKTw==
X-Gm-Message-State: AGi0PuZsspvQ81IpM2i/LrZr2LAGnPuOvPHZ3EdEferZe9yCHlMB6nkV
 zC0kvmK4SCU1JFj4rXHB/FUxkEPKW6Vx1D577Yc=
X-Google-Smtp-Source: APiQypJ9Gv+kHKXJi5oR5TD21rQfGWz5Tsm2ogXsptY8y/+i2q4qTfcUHJ7ZZ8sgVDJeOcMudZqPsXq2mtA+Hkwlx5Y=
X-Received: by 2002:a1c:98c7:: with SMTP id a190mr15179630wme.56.1589211202372; 
 Mon, 11 May 2020 08:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200511102856.191037-1-tom.stdenis@amd.com>
In-Reply-To: <20200511102856.191037-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 May 2020 11:33:11 -0400
Message-ID: <CADnq5_MQ9gbn1OBU+r3hcRL2=vhd4BVjRRHyf3-Tif70BQgDmw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing GRBM bits for GFX 10.1
To: Tom St Denis <tom.stdenis@amd.com>
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

On Mon, May 11, 2020 at 6:29 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Requested bits for UMR support
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> index e7db6f9f9c86..8b0b9a2a8fed 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> @@ -5599,6 +5599,7 @@
>  #define GRBM_PWR_CNTL__ALL_REQ_EN_MASK                                                                        0x00008000L
>  //GRBM_STATUS
>  #define GRBM_STATUS__ME0PIPE0_CMDFIFO_AVAIL__SHIFT                                                            0x0
> +#define GRBM_STATUS__RSMU_RQ_PENDING__SHIFT                                                                   0x5
>  #define GRBM_STATUS__ME0PIPE0_CF_RQ_PENDING__SHIFT                                                            0x7
>  #define GRBM_STATUS__ME0PIPE0_PF_RQ_PENDING__SHIFT                                                            0x8
>  #define GRBM_STATUS__GDS_DMA_RQ_PENDING__SHIFT                                                                0x9
> @@ -5619,6 +5620,7 @@
>  #define GRBM_STATUS__CB_BUSY__SHIFT                                                                           0x1e
>  #define GRBM_STATUS__GUI_ACTIVE__SHIFT                                                                        0x1f
>  #define GRBM_STATUS__ME0PIPE0_CMDFIFO_AVAIL_MASK                                                              0x0000000FL
> +#define GRBM_STATUS__RSMU_RQ_PENDING_MASK                                                                     0x00000020L
>  #define GRBM_STATUS__ME0PIPE0_CF_RQ_PENDING_MASK                                                              0x00000080L
>  #define GRBM_STATUS__ME0PIPE0_PF_RQ_PENDING_MASK                                                              0x00000100L
>  #define GRBM_STATUS__GDS_DMA_RQ_PENDING_MASK                                                                  0x00000200L
> @@ -5832,6 +5834,7 @@
>  #define GRBM_READ_ERROR__READ_ERROR_MASK                                                                      0x80000000L
>  //GRBM_READ_ERROR2
>  #define GRBM_READ_ERROR2__READ_REQUESTER_CPF__SHIFT                                                           0x10
> +#define GRBM_READ_ERROR2__READ_REQUESTER_RSMU__SHIFT                                                          0x11
>  #define GRBM_READ_ERROR2__READ_REQUESTER_RLC__SHIFT                                                           0x12
>  #define GRBM_READ_ERROR2__READ_REQUESTER_GDS_DMA__SHIFT                                                       0x13
>  #define GRBM_READ_ERROR2__READ_REQUESTER_ME0PIPE0_CF__SHIFT                                                   0x14
> @@ -5847,6 +5850,7 @@
>  #define GRBM_READ_ERROR2__READ_REQUESTER_ME2PIPE2__SHIFT                                                      0x1e
>  #define GRBM_READ_ERROR2__READ_REQUESTER_ME2PIPE3__SHIFT                                                      0x1f
>  #define GRBM_READ_ERROR2__READ_REQUESTER_CPF_MASK                                                             0x00010000L
> +#define GRBM_READ_ERROR2__READ_REQUESTER_RSMU_MASK                                                            0x00020000L
>  #define GRBM_READ_ERROR2__READ_REQUESTER_RLC_MASK                                                             0x00040000L
>  #define GRBM_READ_ERROR2__READ_REQUESTER_GDS_DMA_MASK                                                         0x00080000L
>  #define GRBM_READ_ERROR2__READ_REQUESTER_ME0PIPE0_CF_MASK                                                     0x00100000L
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
