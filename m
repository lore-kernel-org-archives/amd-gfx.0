Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD59DC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 13:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765EC619A0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 13:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765EC619A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038CF6E1F9;
	Fri, 26 Mar 2021 13:55:41 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFAE6E1F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 13:55:39 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 91-20020a9d08640000b0290237d9c40382so5228075oty.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ONqalVq4VUQS2wIN/tbq7ew0vuipniD3OpF9unwFkzs=;
 b=D/hMxet899VA0Uvdgv9sLFRTr82ZNvSXvvqBvqEd7ZQQ5CDF8SvIZrp7uVYixK6PvE
 7WlTBSfadWlBI9JrpOGSTt8REUVgUp6ZsEofOWsfGY3ejVsAaIvdU9k9f2nptbudzGqX
 RUs4lat1HRaeVlN/jR9yqTmJAebwUoF8Up+tOJ6neyqOZ8rVlpgxNNUpoMK2dbsE15Dn
 iuuSQ2Ne1xnLchSUgHX/YzzQ5UuU6rthd06XADadCHsH8WobrPwOILREqVlHXpQCNO+b
 RmtScfhioWiVICYQdhK4h6RLaq/BtAARiVWYKSQlu+HbupXJictH9GEKSzKzyxaWb0u3
 oWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ONqalVq4VUQS2wIN/tbq7ew0vuipniD3OpF9unwFkzs=;
 b=B5W8HQVF3FFF5JqPAyW9Q1GXuLn1ZAA5MIz61aF80bHfHeDO1bjtQQErzsP4Y0jcNr
 Q9FhUu4Ii0cm9Psc3cVOuE1hwTuOUzEG/RSpkAiMh1h8lzjmSpGPOgrHfa/WMjMStXyD
 Dxfq9AMlgyAbSm3ROI2UdvLyA55UP4Uh17XqggkUCh1LLisi4fwj+BKbotX9HjU0mpAe
 pCW6x//e2AGtyxuPFZxx09CxALU/35pUNC1QAb3aiimySWyzWj0Ym87LUBfbx+g1DcsI
 QIAt2Dl6ju9zGYPKEJL866zQt0ED0sCWCfUyBfff5sEJc7UNJlHskXfTbFr/XCjH6IWT
 Pq7A==
X-Gm-Message-State: AOAM533uotyKrgLEES5HyhPQTXCUrSm6jMnX1SmE1vw5XVKirF5pSqzy
 osgjzv2QEDZjvN3MzOApGTTBCrfKwiebtzkGMZU=
X-Google-Smtp-Source: ABdhPJzQP3abZ0aA+p5PM83SsNTi/jPNiBG7fqBrGd3Sdo59cmA6k7yi3u4HOfMWAWNCIFS3toA8VYxolsk5DyBvhvQ=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr12251728ott.132.1616766939280; 
 Fri, 26 Mar 2021 06:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210326134823.1412878-1-tom.stdenis@amd.com>
In-Reply-To: <20210326134823.1412878-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Mar 2021 09:55:28 -0400
Message-ID: <CADnq5_OhhQWmcF6Lg_3WAUN9_P2bgg2+T8Enx0qJbD9bBT1qCQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add CP_IB1_BASE_* to gc_10_3_0 headers
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

On Fri, Mar 26, 2021 at 9:49 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h   | 6 ++++++
>  .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h  | 9 +++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> index 0102487a2c5f..f21554a1c86c 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> @@ -6955,6 +6955,12 @@
>  #define mmCP_CE_IB2_BASE_HI_BASE_IDX                                                                   1
>  #define mmCP_CE_IB2_BUFSZ                                                                              0x20cb
>  #define mmCP_CE_IB2_BUFSZ_BASE_IDX                                                                     1
> +#define mmCP_IB1_BASE_LO                                                                               0x20cc
> +#define mmCP_IB1_BASE_LO_BASE_IDX                                                                      1
> +#define mmCP_IB1_BASE_HI                                                                               0x20cd
> +#define mmCP_IB1_BASE_HI_BASE_IDX                                                                      1
> +#define mmCP_IB1_BUFSZ                                                                                 0x20ce
> +#define mmCP_IB1_BUFSZ_BASE_IDX                                                                        1
>  #define mmCP_IB2_BASE_LO                                                                               0x20cf
>  #define mmCP_IB2_BASE_LO_BASE_IDX                                                                      1
>  #define mmCP_IB2_BASE_HI                                                                               0x20d0
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> index 4d2a1432c121..a827b0ff8905 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> @@ -25818,6 +25818,15 @@
>  //CP_CE_IB2_BUFSZ
>  #define CP_CE_IB2_BUFSZ__IB2_BUFSZ__SHIFT                                                                     0x0
>  #define CP_CE_IB2_BUFSZ__IB2_BUFSZ_MASK                                                                       0x000FFFFFL
> +//CP_IB1_BASE_LO
> +#define CP_IB1_BASE_LO__IB1_BASE_LO__SHIFT                                                                    0x2
> +#define CP_IB1_BASE_LO__IB1_BASE_LO_MASK                                                                      0xFFFFFFFCL
> +//CP_IB1_BASE_HI
> +#define CP_IB1_BASE_HI__IB1_BASE_HI__SHIFT                                                                    0x0
> +#define CP_IB1_BASE_HI__IB1_BASE_HI_MASK                                                                      0x0000FFFFL
> +//CP_IB1_BUFSZ
> +#define CP_IB1_BUFSZ__IB1_BUFSZ__SHIFT                                                                        0x0
> +#define CP_IB1_BUFSZ__IB1_BUFSZ_MASK                                                                          0x000FFFFFL
>  //CP_IB2_BASE_LO
>  #define CP_IB2_BASE_LO__IB2_BASE_LO__SHIFT                                                                    0x2
>  #define CP_IB2_BASE_LO__IB2_BASE_LO_MASK                                                                      0xFFFFFFFCL
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
