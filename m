Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D3AC282DD
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 16:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D709020661
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfrAhpuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D709020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956096E44F;
	Thu,  9 Jan 2020 16:12:53 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 371E66E44F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 16:12:52 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t14so3458014wmi.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 08:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jqwmck/q4E8JeTnnWcrwW1U7wXmThZZOkN89wr0ri0Y=;
 b=FfrAhpuOiP5liofMuBDY5KmNquejUlEAi8VOH3cBCVfDM6OHb6V22JVdapdJ13uZQi
 jz6F8niwfeN+eN0GqKWpJBUCl9EbbN6Y3PBHMBhI31yqJ4W8GosJ8E9UFfyuc+NPttoP
 RSldUs0oPI265T+7ol9yM6+05iWATOu+7TvJ+25lnZpO/fqcZ8PoPRg1i9bNWBvYknuN
 V0EZwbkvEamAUt4FImGDC/i1ix/UiVlWt2ZzMoKigkp/rT5kk3Ql0JvrPUTbKHQPW9SV
 LCXfdbCXZ6WnqoqtGGkQ2uu/Fuk5pMPGWemCQ2OyaPdRzH0ZB0VT7Pkr3MjlidjF3sLC
 uzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jqwmck/q4E8JeTnnWcrwW1U7wXmThZZOkN89wr0ri0Y=;
 b=aqCFYCOfOsV1OpZcIjZJi95ILTrT40elmA17Wspg26s2ypuI7lOjU3d5ezkphLlX35
 mb5uU4N7qK1il1KhgSNGlg3/9XAXBQfQHwQjOyAI/E/TJ2opn9/S9QvZ22i1s6stiqFS
 f5LpDNeoR6NjOf9uPPQ49/mNMOQL1z6aXKOm7E2hp8fLT3ytni5CpzPknIrMPyv/H023
 lbVJEMbHzZ32jsaEKtwPvmlaxARijdnQdj1sL3mHlQ0uYgibzHmDEb043qkdmvyLzp1h
 3ddnrjGsKuSUl9u1mg270nn1/bNVJ5Kv6DJt4799gRp3+VprN7poBVLtLz5AQbSWEtld
 MurA==
X-Gm-Message-State: APjAAAUg/HTlLw1sE4rqthvQUOueusniXZ8fz8RMSzVttoQUbR8X2253
 vboTc5CISZnoA9bVQsR+JwwHZedQx/F9cK3LIkY=
X-Google-Smtp-Source: APXvYqzQacV4KQcElnfYcso7YntjtBfCyF+L5fT1anTMclponOGoeKzNhPx2WO0wrq2ekicjOSUCgvJ8qpd8zJrG4HI=
X-Received: by 2002:a1c:486:: with SMTP id 128mr5935551wme.163.1578586370861; 
 Thu, 09 Jan 2020 08:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20200109154035.847890-1-tom.stdenis@amd.com>
 <CAAzXoRLc9CX8vJXvhcPnaoawNZCmSYMfnMYi7HvuzHXOarTxyQ@mail.gmail.com>
In-Reply-To: <CAAzXoRLc9CX8vJXvhcPnaoawNZCmSYMfnMYi7HvuzHXOarTxyQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jan 2020 11:12:36 -0500
Message-ID: <CADnq5_NzCy63HAkJN3Q3=7_7R6sgYbVFnyk+SaprLPb3YSjFcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add missing umc_6_1_2_sh_mask.h header
 file
To: Tom St Denis <tstdenis82@gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 9, 2020 at 10:59 AM Tom St Denis <tstdenis82@gmail.com> wrote:
>
> note: I have since fixed the #ifndef/#define lines for when I eventually push it out

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> On Thu, Jan 9, 2020 at 10:40 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>>
>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> ---
>>  .../include/asic_reg/umc/umc_6_1_2_sh_mask.h  | 91 +++++++++++++++++++
>>  1 file changed, 91 insertions(+)
>>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h
>>
>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h
>> new file mode 100644
>> index 000000000000..7c3c6d405259
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h
>> @@ -0,0 +1,91 @@
>> +/*
>> + * Copyright (C) 2020  Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included
>> + * in all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
>> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
>> + * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +#ifndef _umc_6_1_1_SH_MASK_HEADER
>> +#define _umc_6_1_1_SH_MASK_HEADER
>> +
>> +//UMCCH0_0_EccErrCntSel_ARCT
>> +#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntCsSel__SHIFT                                                          0x0
>> +#define UMCCH0_0_EccErrCntSel_ARCT__EccErrInt__SHIFT                                                               0xc
>> +#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntEn__SHIFT                                                             0xf
>> +#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntCsSel_MASK                                                            0x0000000FL
>> +#define UMCCH0_0_EccErrCntSel_ARCT__EccErrInt_MASK                                                                 0x00003000L
>> +#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntEn_MASK                                                               0x00008000L
>> +//UMCCH0_0_EccErrCnt_ARCT
>> +#define UMCCH0_0_EccErrCnt_ARCT__EccErrCnt__SHIFT                                                                  0x0
>> +#define UMCCH0_0_EccErrCnt_ARCT__EccErrCnt_MASK                                                                    0x0000FFFFL
>> +//MCA_UMC_UMC0_MCUMC_STATUST0_ARCT
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCode__SHIFT                                                         0x0
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCodeExt__SHIFT                                                      0x10
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV0__SHIFT                                                           0x16
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreId__SHIFT                                                         0x20
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV1__SHIFT                                                           0x26
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Scrub__SHIFT                                                             0x28
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV2__SHIFT                                                           0x29
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Poison__SHIFT                                                            0x2b
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Deferred__SHIFT                                                          0x2c
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UECC__SHIFT                                                              0x2d
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__CECC__SHIFT                                                              0x2e
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV3__SHIFT                                                           0x2f
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Transparent__SHIFT                                                       0x34
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__SyndV__SHIFT                                                             0x35
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV4__SHIFT                                                           0x36
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__TCC__SHIFT                                                               0x37
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreIdVal__SHIFT                                                      0x38
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__PCC__SHIFT                                                               0x39
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__AddrV__SHIFT                                                             0x3a
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__MiscV__SHIFT                                                             0x3b
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__En__SHIFT                                                                0x3c
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UC__SHIFT                                                                0x3d
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Overflow__SHIFT                                                          0x3e
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Val__SHIFT                                                               0x3f
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCode_MASK                                                           0x000000000000FFFFL
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCodeExt_MASK                                                        0x00000000003F0000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV0_MASK                                                             0x00000000FFC00000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreId_MASK                                                           0x0000003F00000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV1_MASK                                                             0x000000C000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Scrub_MASK                                                               0x0000010000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV2_MASK                                                             0x0000060000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Poison_MASK                                                              0x0000080000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Deferred_MASK                                                            0x0000100000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UECC_MASK                                                                0x0000200000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__CECC_MASK                                                                0x0000400000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV3_MASK                                                             0x000F800000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Transparent_MASK                                                         0x0010000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__SyndV_MASK                                                               0x0020000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV4_MASK                                                             0x0040000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__TCC_MASK                                                                 0x0080000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreIdVal_MASK                                                        0x0100000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__PCC_MASK                                                                 0x0200000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__AddrV_MASK                                                               0x0400000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__MiscV_MASK                                                               0x0800000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__En_MASK                                                                  0x1000000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UC_MASK                                                                  0x2000000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Overflow_MASK                                                            0x4000000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Val_MASK                                                                 0x8000000000000000L
>> +//MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT
>> +#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__ErrorAddr__SHIFT                                                           0x0
>> +#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__LSB__SHIFT                                                                 0x38
>> +#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__Reserved__SHIFT                                                            0x3e
>> +#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__ErrorAddr_MASK                                                             0x00FFFFFFFFFFFFFFL
>> +#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__LSB_MASK                                                                   0x3F00000000000000L
>> +#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__Reserved_MASK                                                              0xC000000000000000L
>> +
>> +#endif
>> --
>> 2.24.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
