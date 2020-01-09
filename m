Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB08C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBAA2070E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiqifoAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBAA2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DE46E384;
	Thu,  9 Jan 2020 03:34:01 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430A46E384
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 03:33:59 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id b19so1233696wmj.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 19:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J5/PXGbGjOOBuD53ohq+tkestVEZ0GMyrwLt1QRmUgY=;
 b=KiqifoAie5Yi+todRvbqPRhCSa1ZoF5fBph+7sFJR+UHIg/NtEHnzAMAYhFh0irsa3
 cQdTJkkhXPvuYQg3q5Y86hQ7VVnzU66XhSWkoktDUD10iD36JPXCS4I6Vi0heZutg/Vy
 uhKKBlnqSTnNBDs+EXtG4DqXFR+7i0rSudFndZwSTn/3CY6YKEngDlKpaaenUnbb1BYr
 UaMJ8uifURrgmiQOdsO744W3WKxvFvtSEo8Yf7qBeQ3H7SzCkEiI5ws+N2i7t5Sgceem
 aW6hOOKTk9pd72OwLQnYonwaMldjmaiJo8+xiUs0K1Kus4p+btpNEXeZciRWagrG1Zei
 zX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J5/PXGbGjOOBuD53ohq+tkestVEZ0GMyrwLt1QRmUgY=;
 b=LOatUPaIlQ/TE2xWYZwEte8FrhIACl51l431OKu3wY9W/55YzKvUC7t8Jgk+GRDEvJ
 Vq4sbOgeoT684YLRmOBRmpGYUAkalt4haY0hxoXqKXzX+mRXILSPnuvFqMU8k7rgzK8X
 4HClA0nVVEkhSHkvzd7sJhyYjyWTkioDbcF8tHgHqV3gm2zIN5GsF9r4xBqb3sS4tMkp
 Kb7h0Qp7QQ9K+Jjb9UmHcYbx/k/Z8GKBy/CIXBc9PA91QpzyuwmTpXUvtJJZ2BgOuMsK
 X+2AkNESZrz6y54VHLVIn6U/98OPzwL/zUfcU75nXsgg3Zb5QNmrCGm/u54wQt22ujt5
 ktIA==
X-Gm-Message-State: APjAAAV7SbDLRc8xW4r9Murd69BZVGD/vfkuMB+9GLnl7JuclCJm8QAr
 e0CY9qPfkZyo/Yis1/jPnVYOngxzEIHiiWgjNYI=
X-Google-Smtp-Source: APXvYqyQrO7HC7Ef+6B5iBfnsz9HZ3rQL2IGwsXJisnR3y7Yxhtvt3C+/5vGrtSQl3THj+pZwqclr02C6A5dGhAf35E=
X-Received: by 2002:a1c:486:: with SMTP id 128mr2024719wme.163.1578540837855; 
 Wed, 08 Jan 2020 19:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20200109010742.30091-1-guchun.chen@amd.com>
 <20200109010742.30091-2-guchun.chen@amd.com>
In-Reply-To: <20200109010742.30091-2-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 22:33:45 -0500
Message-ID: <CADnq5_NqC6ywGL1a55dc+pLKL4mLrwFJdO0FxpB_d2adeNQEww@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: calculate MCUMC_ADDRT0 per asic's UMC
 offset
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: Tao Zhou <Tao.Zhou1@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 John Clements <John.Clements@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 8, 2020 at 8:10 PM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Hardcoded offset is not friendly. And another benifit of this
> patch is to keep read and write access to this register be
> consistent with other similar UMC regsiters  in this file.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> index 11e924dd88ff..11428b66c74e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> @@ -30,8 +30,6 @@
>  #include "umc/umc_6_1_1_sh_mask.h"
>  #include "umc/umc_6_1_2_offset.h"
>
> -#define smnMCA_UMC0_MCUMC_ADDRT0       0x50f10
> -
>  #define UMC_6_INST_DIST                        0x40000
>
>  /*
> @@ -186,7 +184,7 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
>                                          uint32_t umc_inst)
>  {
>         uint32_t lsb, mc_umc_status_addr;
> -       uint64_t mc_umc_status, err_addr, retired_page;
> +       uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
>         struct eeprom_table_record *err_rec;
>         uint32_t channel_index = adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
>
> @@ -194,10 +192,14 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
>                 /* UMC 6_1_2 registers */
>                 mc_umc_status_addr =
>                         SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);
> +               mc_umc_addrt0 =
> +                       SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_ADDRT0_ARCT);
>         } else {
>                 /* UMC 6_1_1 registers */
>                 mc_umc_status_addr =
>                         SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);
> +               mc_umc_addrt0 =
> +                       SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_ADDRT0);
>         }
>
>         /* skip error address process if -ENOMEM */
> @@ -214,7 +216,7 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
>         if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
>             (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
>             REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
> -               err_addr = RREG64_PCIE(smnMCA_UMC0_MCUMC_ADDRT0 + umc_reg_offset * 4);
> +               err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
>
>                 /* the lowest lsb bits should be ignored */
>                 lsb = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, LSB);
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
