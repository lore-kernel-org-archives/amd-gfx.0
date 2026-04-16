Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E87F8A171
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 13:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216F110E8B7;
	Thu, 16 Apr 2026 13:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bn4Uu7Fu";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DADF10E1E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:07:18 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12736a0147cso609158c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 06:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776344837; cv=none;
 d=google.com; s=arc-20240605;
 b=Bb7LaNlnLxKA94cO2s55+pCiXCjzipNXrSbp0TtsIE3oIJVXkq32jGGeXnRxHfq18P
 S76d7q/uuSfJiKoBiyyb98QezRvBZ9fdND4AOhdrWgUv+jPn706MAdjcPrcFz/QzhPF8
 Q+DKA/epAVlS8gw7JrGWlr9wKyyLUdBVYYOampZfMfgVSmjYOuWwBkQWNSFp5rkh9nvO
 /VpgutQwwbEfKLwdbO1fQ3HvUIX/77jTYWE3JZOPoDaw4bIrCxcdAEiNZuCoK4eUDbpm
 DfkBaTvmAnMdTF9qSFXf4BhmlciCyn5wxuiMk9zPnH8Z26ZYO3PNtD6EFjBoiEIGisrC
 Rxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5d+UwmYh/wU9JxdrRLIeCQ1rfsH2EfTJrMUDY8rjEok=;
 fh=YfPanCJvkrg4xI4YIS9FcRUou91HmaGJlYpBN2WvcDo=;
 b=hhvgNk8mtw9AoVETIKc1zOCSKj39fZgkIySsox0E1jpULqRIV1Vgg9+9FkUob9lXdv
 /M6ZKAKQ4bHKlVZshqk2oHf4lATZMG+mfhJ5Pl10C21HJ/8hvghBymlUFzMRStgnkGb9
 8tlkIazX/R4Cix/iwMWb5p6YN7DqdFpHazDBfHqM9SNVLEast+obsDJ+A/dCqvSL9A08
 6hoVXAoObOmJhzHMZZK/UM9Eg1Q2Gc72DAVDKHHUrxL1wajiKfk1nIIWmcZv4xY4TbM/
 673PMMnxxrHNxQ5tDxIXfPWd4V+L1WYC5TLPCCcoUN6Ibb7Do7ElHc0J8oRpTmUbAQVy
 sOpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776344837; x=1776949637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5d+UwmYh/wU9JxdrRLIeCQ1rfsH2EfTJrMUDY8rjEok=;
 b=bn4Uu7FuxEf3fxrW+RaTkDGuGAFN4wkg/V2k+C47dI6IjOfgh8j6Y6ySx938WM6BOq
 +9Rdvaa6L36ROFGDV/1U96ppZnUPUQ86tTlv5k+S34vYD6osHAYa4+OEfeNDCRlYZ9FT
 5q1TqapdingAM9bvYU4nE1/IPq8yfHvkOkj36AtJ3fQmMUkR52gzhj2gg6JuIbPRGZ+x
 S9iM7Ab3rpUrf5scQWkGtxy5ODvR5dZjFr8HERWIO0SdL/U/RnSFk1r065EXEZcaC0KU
 0CXxMJ2Kszvq0FqHA3aJBMkZfR/fhCrVL0h/rn8LXWuZ1UQ+WexvP/In5T9LQUNYFpF8
 4Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776344837; x=1776949637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5d+UwmYh/wU9JxdrRLIeCQ1rfsH2EfTJrMUDY8rjEok=;
 b=pjINaZRi7dYsPOkcDZboj0ZHYHawbyHYflQbx+nkiahaGwDkVlRPW0P1WhwZ7RJMry
 jqhzmKPoRFOQI+Yk+rDXm3Yydd3FOyor8TfoYnE4aWzkPmVupn8FuGoSSHnfNMrLCaPN
 mKav51ixMY6NClgaoNkDrd9pNhUkLIGsSVutXedIiK557TbaPzHJqOMlOXrK6tOLybcM
 PjmX6yy1asp+vjecZVBHfGjI6mOmDThRpmvxHBVE0btXJcU1+oYYj5tEDUgZSFZk8mnk
 hpyUFJRI4AaXLieNUegQjMrUTgF7aluDr6wrjmjwsbjl9p4PJDTkKtBIdgI5MLyFEjRA
 Bu0g==
X-Gm-Message-State: AOJu0Yx50ALR5ewLraQtRD0edgF/jc5iRl/Xk0Mcmq+D/fOD85O31eAt
 NLeNJ1oGNtNXseQ3w/adlJMMNhIqrdyHk2vs2hy0qxWYru4n4QF0fUYORuvUZALdmLP8IHc7PT5
 do0P8QNr8D4dlq/6XHhw4c3DROdktf8A=
X-Gm-Gg: AeBDieuxeGwRotKpavchPfgXZxPwT28Y/D6v2z5Ey3L8FzpUFH21WB+K+nqWiLc/jyY
 edU60+WEq8OwVjkIHCTqmTmjoDCQH0Rf+MqjJK5QkMit1fZWNlq34xQHVeMYsqd1dSS5vThp5z4
 cbW9eLtHqWQBAH5MQxELufd5OkbzalA48DC+UcLyj2eNm2I2GivE98l8ZwcCq9oaIjWjEfjHZ/J
 DyLfhkVXM6/tj/Vkqb4Igkk8jWp+iL1QBh/N0OQ8p8C3sI7msr+kk9FpZH3sUXCXSsidnhO4rVw
 oqqN/YYPhsvSdrtckSFnca02tut/VE+psOa0VA1Od8CboOau1mt4sOnkST++2JjMjN/fhA==
X-Received: by 2002:a05:7022:220c:b0:12c:33dd:fa0b with SMTP id
 a92af1059eb24-12c6590eb0amr524705c88.2.1776344837046; Thu, 16 Apr 2026
 06:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260415201325.838342-1-bing.ma@amd.com>
In-Reply-To: <20260415201325.838342-1-bing.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Apr 2026 09:07:03 -0400
X-Gm-Features: AQROBzB-muIWxR1piYH5OWPk5laVWgLlzWZMcSJNVqHSIfg-79lwoUnKBImIWHA
Message-ID: <CADnq5_NuyF=b-LG-S3YrQFM6HW8_NRRj9VWot50jzaQoX6nwcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add gc v12_1_1 ip headers v3
To: Bing Ma <bing.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 15, 2026 at 5:09=E2=80=AFPM Bing Ma <bing.ma@amd.com> wrote:
>
> Add header files for gc v12_1_1 register offsets
> and shift masks
> v2: Update gc v12_1_1 ip headers
> v3: Update gc v12_1_1 ip headers
>
> Signed-off-by: Bing Ma <Bing.Ma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../include/asic_reg/gc/gc_12_1_1_offset.h    | 149 +++++++
>  .../include/asic_reg/gc/gc_12_1_1_sh_mask.h   | 377 ++++++++++++++++++
>  2 files changed, 526 insertions(+)
>  create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_off=
set.h
>  create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_=
mask.h
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h
> new file mode 100755
> index 000000000000..f10e6168ad54
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h
> @@ -0,0 +1,149 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef _gc_12_1_1_OFFSET_HEADER
> +#define _gc_12_1_1_OFFSET_HEADER
> +
> +
> +
> +// addressBlock: aigc_grbma_grbma_grbmadec
> +// base address: 0x18000
> +#define regGRBMA_GFX_INDEX                                              =
                                0x0011
> +#define regGRBMA_GFX_INDEX_BASE_IDX                                     =
                                1
> +
> +
> +// addressBlock: aigc_grbma_grbma_perfddec
> +// base address: 0x19200
> +#define regGRBMA_PERFCOUNTER0_LO                                        =
                                0x0480
> +#define regGRBMA_PERFCOUNTER0_LO_BASE_IDX                               =
                                1
> +#define regGRBMA_PERFCOUNTER0_HI                                        =
                                0x0481
> +#define regGRBMA_PERFCOUNTER0_HI_BASE_IDX                               =
                                1
> +#define regGRBMA_PERFCOUNTER1_LO                                        =
                                0x0482
> +#define regGRBMA_PERFCOUNTER1_LO_BASE_IDX                               =
                                1
> +#define regGRBMA_PERFCOUNTER1_HI                                        =
                                0x0483
> +#define regGRBMA_PERFCOUNTER1_HI_BASE_IDX                               =
                                1
> +
> +
> +// addressBlock: aigc_grbma_grbma_perfsdec
> +// base address: 0x19300
> +#define regGRBMA_PERFCOUNTER0_SELECT                                    =
                                0x04c0
> +#define regGRBMA_PERFCOUNTER0_SELECT_BASE_IDX                           =
                                1
> +#define regGRBMA_PERFCOUNTER1_SELECT                                    =
                                0x04c1
> +#define regGRBMA_PERFCOUNTER1_SELECT_BASE_IDX                           =
                                1
> +#define regAID_PERFMON_CNTL                                             =
                                0x04c2
> +#define regAID_PERFMON_CNTL_BASE_IDX                                    =
                                1
> +
> +
> +// addressBlock: aigc_gl2x_gfx_se_perfsdec
> +// base address: 0x19300
> +#define regGL2C_PERFCOUNTER0_SELECT                                     =
                                0x04e8
> +#define regGL2C_PERFCOUNTER0_SELECT_BASE_IDX                            =
                                1
> +#define regGL2C_PERFCOUNTER0_SELECT1                                    =
                                0x04e9
> +#define regGL2C_PERFCOUNTER0_SELECT1_BASE_IDX                           =
                                1
> +#define regGL2C_PERFCOUNTER1_SELECT                                     =
                                0x04ea
> +#define regGL2C_PERFCOUNTER1_SELECT_BASE_IDX                            =
                                1
> +#define regGL2C_PERFCOUNTER1_SELECT1                                    =
                                0x04eb
> +#define regGL2C_PERFCOUNTER1_SELECT1_BASE_IDX                           =
                                1
> +#define regGL2C_PERFCOUNTER2_SELECT                                     =
                                0x04ec
> +#define regGL2C_PERFCOUNTER2_SELECT_BASE_IDX                            =
                                1
> +#define regGL2C_PERFCOUNTER2_SELECT1                                    =
                                0x04ed
> +#define regGL2C_PERFCOUNTER2_SELECT1_BASE_IDX                           =
                                1
> +#define regGL2C_PERFCOUNTER3_SELECT                                     =
                                0x04ee
> +#define regGL2C_PERFCOUNTER3_SELECT_BASE_IDX                            =
                                1
> +#define regGL2C_PERFCOUNTER3_SELECT1                                    =
                                0x04ef
> +#define regGL2C_PERFCOUNTER3_SELECT1_BASE_IDX                           =
                                1
> +#define regGL2A_PERFCOUNTER0_SELECT                                     =
                                0x04f0
> +#define regGL2A_PERFCOUNTER0_SELECT_BASE_IDX                            =
                                1
> +#define regGL2A_PERFCOUNTER0_SELECT1                                    =
                                0x04f1
> +#define regGL2A_PERFCOUNTER0_SELECT1_BASE_IDX                           =
                                1
> +#define regGL2A_PERFCOUNTER1_SELECT                                     =
                                0x04f2
> +#define regGL2A_PERFCOUNTER1_SELECT_BASE_IDX                            =
                                1
> +#define regGL2A_PERFCOUNTER1_SELECT1                                    =
                                0x04f3
> +#define regGL2A_PERFCOUNTER1_SELECT1_BASE_IDX                           =
                                1
> +#define regGL2A_PERFCOUNTER2_SELECT                                     =
                                0x04f4
> +#define regGL2A_PERFCOUNTER2_SELECT_BASE_IDX                            =
                                1
> +#define regGL2A_PERFCOUNTER2_SELECT1                                    =
                                0x04f5
> +#define regGL2A_PERFCOUNTER2_SELECT1_BASE_IDX                           =
                                1
> +#define regGL2A_PERFCOUNTER3_SELECT                                     =
                                0x04f6
> +#define regGL2A_PERFCOUNTER3_SELECT_BASE_IDX                            =
                                1
> +#define regGL2A_PERFCOUNTER3_SELECT1                                    =
                                0x04f7
> +#define regGL2A_PERFCOUNTER3_SELECT1_BASE_IDX                           =
                                1
> +
> +
> +// addressBlock: aigc_gl2x_gfx_se_perfddec
> +// base address: 0x19200
> +#define regGL2C_PERFCOUNTER0_LO                                         =
                                0x04a0
> +#define regGL2C_PERFCOUNTER0_LO_BASE_IDX                                =
                                1
> +#define regGL2C_PERFCOUNTER0_HI                                         =
                                0x04a1
> +#define regGL2C_PERFCOUNTER0_HI_BASE_IDX                                =
                                1
> +#define regGL2C_PERFCOUNTER1_LO                                         =
                                0x04a2
> +#define regGL2C_PERFCOUNTER1_LO_BASE_IDX                                =
                                1
> +#define regGL2C_PERFCOUNTER1_HI                                         =
                                0x04a3
> +#define regGL2C_PERFCOUNTER1_HI_BASE_IDX                                =
                                1
> +#define regGL2C_PERFCOUNTER2_LO                                         =
                                0x04a4
> +#define regGL2C_PERFCOUNTER2_LO_BASE_IDX                                =
                                1
> +#define regGL2C_PERFCOUNTER2_HI                                         =
                                0x04a5
> +#define regGL2C_PERFCOUNTER2_HI_BASE_IDX                                =
                                1
> +#define regGL2C_PERFCOUNTER3_LO                                         =
                                0x04a6
> +#define regGL2C_PERFCOUNTER3_LO_BASE_IDX                                =
                                1
> +#define regGL2C_PERFCOUNTER3_HI                                         =
                                0x04a7
> +#define regGL2C_PERFCOUNTER3_HI_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER0_LO                                         =
                                0x04a8
> +#define regGL2A_PERFCOUNTER0_LO_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER0_HI                                         =
                                0x04a9
> +#define regGL2A_PERFCOUNTER0_HI_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER1_LO                                         =
                                0x04aa
> +#define regGL2A_PERFCOUNTER1_LO_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER1_HI                                         =
                                0x04ab
> +#define regGL2A_PERFCOUNTER1_HI_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER2_LO                                         =
                                0x04ac
> +#define regGL2A_PERFCOUNTER2_LO_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER2_HI                                         =
                                0x04ad
> +#define regGL2A_PERFCOUNTER2_HI_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER3_LO                                         =
                                0x04ae
> +#define regGL2A_PERFCOUNTER3_LO_BASE_IDX                                =
                                1
> +#define regGL2A_PERFCOUNTER3_HI                                         =
                                0x04af
> +#define regGL2A_PERFCOUNTER3_HI_BASE_IDX                                =
                                1
> +
> +
> +// addressBlock: aigc_gfx_gcea_se_gfx_se_perfsdec
> +// base address: 0x19320
> +#define regGC_EA_SE_PERFCOUNTER0_SELECT                                 =
                                0x04c8
> +#define regGC_EA_SE_PERFCOUNTER0_SELECT_BASE_IDX                        =
                                1
> +#define regGC_EA_SE_PERFCOUNTER0_SELECT1                                =
                                0x04c9
> +#define regGC_EA_SE_PERFCOUNTER0_SELECT1_BASE_IDX                       =
                                1
> +#define regGC_EA_SE_PERFCOUNTER1_SELECT                                 =
                                0x04ca
> +#define regGC_EA_SE_PERFCOUNTER1_SELECT_BASE_IDX                        =
                                1
> +
> +
> +// addressBlock: aigc_gfx_gcea_se_gfx_se_perfddec
> +// base address: 0x19240
> +#define regGC_EA_SE_PERFCOUNTER0_LO                                     =
                                0x0490
> +#define regGC_EA_SE_PERFCOUNTER0_LO_BASE_IDX                            =
                                1
> +#define regGC_EA_SE_PERFCOUNTER0_HI                                     =
                                0x0491
> +#define regGC_EA_SE_PERFCOUNTER0_HI_BASE_IDX                            =
                                1
> +#define regGC_EA_SE_PERFCOUNTER1_LO                                     =
                                0x0492
> +#define regGC_EA_SE_PERFCOUNTER1_LO_BASE_IDX                            =
                                1
> +#define regGC_EA_SE_PERFCOUNTER1_HI                                     =
                                0x0493
> +#define regGC_EA_SE_PERFCOUNTER1_HI_BASE_IDX                            =
                                1
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h
> new file mode 100755
> index 000000000000..8d09c8150a53
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h
> @@ -0,0 +1,377 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef _gc_12_1_1_SH_MASK_HEADER
> +#define _gc_12_1_1_SH_MASK_HEADER
> +
> +
> +// addressBlock: aigc_grbma_grbma_grbmadec
> +//GRBMA_GFX_INDEX
> +#define GRBMA_GFX_INDEX__INSTANCE_INDEX__SHIFT                          =
                                      0x0
> +#define GRBMA_GFX_INDEX__SA_INDEX__SHIFT                                =
                                      0x8
> +#define GRBMA_GFX_INDEX__SE_INDEX__SHIFT                                =
                                      0x10
> +#define GRBMA_GFX_INDEX__SA_BROADCAST_WRITES__SHIFT                     =
                                      0x1d
> +#define GRBMA_GFX_INDEX__INSTANCE_BROADCAST_WRITES__SHIFT               =
                                      0x1e
> +#define GRBMA_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT                     =
                                      0x1f
> +#define GRBMA_GFX_INDEX__INSTANCE_INDEX_MASK                            =
                                      0x0000007FL
> +#define GRBMA_GFX_INDEX__SA_INDEX_MASK                                  =
                                      0x00000300L
> +#define GRBMA_GFX_INDEX__SE_INDEX_MASK                                  =
                                      0x000F0000L
> +#define GRBMA_GFX_INDEX__SA_BROADCAST_WRITES_MASK                       =
                                      0x20000000L
> +#define GRBMA_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK                 =
                                      0x40000000L
> +#define GRBMA_GFX_INDEX__SE_BROADCAST_WRITES_MASK                       =
                                      0x80000000L
> +
> +
> +// addressBlock: aigc_grbma_grbma_perfddec
> +//GRBMA_PERFCOUNTER0_LO
> +#define GRBMA_PERFCOUNTER0_LO__PERFCOUNTER_LO__SHIFT                    =
                                      0x0
> +#define GRBMA_PERFCOUNTER0_LO__PERFCOUNTER_LO_MASK                      =
                                      0xFFFFFFFFL
> +//GRBMA_PERFCOUNTER0_HI
> +#define GRBMA_PERFCOUNTER0_HI__PERFCOUNTER_HI__SHIFT                    =
                                      0x0
> +#define GRBMA_PERFCOUNTER0_HI__PERFCOUNTER_HI_MASK                      =
                                      0xFFFFFFFFL
> +//GRBMA_PERFCOUNTER1_LO
> +#define GRBMA_PERFCOUNTER1_LO__PERFCOUNTER_LO__SHIFT                    =
                                      0x0
> +#define GRBMA_PERFCOUNTER1_LO__PERFCOUNTER_LO_MASK                      =
                                      0xFFFFFFFFL
> +//GRBMA_PERFCOUNTER1_HI
> +#define GRBMA_PERFCOUNTER1_HI__PERFCOUNTER_HI__SHIFT                    =
                                      0x0
> +#define GRBMA_PERFCOUNTER1_HI__PERFCOUNTER_HI_MASK                      =
                                      0xFFFFFFFFL
> +
> +
> +// addressBlock: aigc_grbma_grbma_perfsdec
> +//GRBMA_PERFCOUNTER0_SELECT
> +#define GRBMA_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                      =
                                      0x0
> +#define GRBMA_PERFCOUNTER0_SELECT__GL1CC_BUSY_USER_DEFINED_MASK__SHIFT  =
                                      0x6
> +#define GRBMA_PERFCOUNTER0_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK__SHIFT =
                                      0x7
> +#define GRBMA_PERFCOUNTER0_SELECT__PMR_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x8
> +#define GRBMA_PERFCOUNTER0_SELECT__SC_CLEAN_USER_DEFINED_MASK__SHIFT    =
                                      0x9
> +#define GRBMA_PERFCOUNTER0_SELECT__WGS_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0xa
> +#define GRBMA_PERFCOUNTER0_SELECT__DB_CLEAN_USER_DEFINED_MASK__SHIFT    =
                                      0xb
> +#define GRBMA_PERFCOUNTER0_SELECT__CB_CLEAN_USER_DEFINED_MASK__SHIFT    =
                                      0xc
> +#define GRBMA_PERFCOUNTER0_SELECT__TA_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0xd
> +#define GRBMA_PERFCOUNTER0_SELECT__SX_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0xe
> +#define GRBMA_PERFCOUNTER0_SELECT__GL2C_BUSY_USER_DEFINED_MASK__SHIFT   =
                                      0xf
> +#define GRBMA_PERFCOUNTER0_SELECT__SPI_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x10
> +#define GRBMA_PERFCOUNTER0_SELECT__XCAC_BUSY_USER_DEFINED_MASK__SHIFT   =
                                      0x11
> +#define GRBMA_PERFCOUNTER0_SELECT__PA_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x12
> +#define GRBMA_PERFCOUNTER0_SELECT__GL2A_BUSY_USER_DEFINED_MASK__SHIFT   =
                                      0x13
> +#define GRBMA_PERFCOUNTER0_SELECT__DB_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x14
> +#define GRBMA_PERFCOUNTER0_SELECT__CB_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x15
> +#define GRBMA_PERFCOUNTER0_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK__SHIFT=
                                      0x17
> +#define GRBMA_PERFCOUNTER0_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK__SHIF=
T                                     0x18
> +#define GRBMA_PERFCOUNTER0_SELECT__BCI_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x19
> +#define GRBMA_PERFCOUNTER0_SELECT__RLC_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x1a
> +#define GRBMA_PERFCOUNTER0_SELECT__TCP_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x1b
> +#define GRBMA_PERFCOUNTER0_SELECT__GE_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x1c
> +#define GRBMA_PERFCOUNTER0_SELECT__UTCL1_BUSY_USER_DEFINED_MASK__SHIFT  =
                                      0x1d
> +#define GRBMA_PERFCOUNTER0_SELECT__EA_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x1e
> +#define GRBMA_PERFCOUNTER0_SELECT__PERF_SEL_MASK                        =
                                      0x0000003FL
> +#define GRBMA_PERFCOUNTER0_SELECT__GL1CC_BUSY_USER_DEFINED_MASK_MASK    =
                                      0x00000040L
> +#define GRBMA_PERFCOUNTER0_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK_MASK   =
                                      0x00000080L
> +#define GRBMA_PERFCOUNTER0_SELECT__PMR_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x00000100L
> +#define GRBMA_PERFCOUNTER0_SELECT__SC_CLEAN_USER_DEFINED_MASK_MASK      =
                                      0x00000200L
> +#define GRBMA_PERFCOUNTER0_SELECT__WGS_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x00000400L
> +#define GRBMA_PERFCOUNTER0_SELECT__DB_CLEAN_USER_DEFINED_MASK_MASK      =
                                      0x00000800L
> +#define GRBMA_PERFCOUNTER0_SELECT__CB_CLEAN_USER_DEFINED_MASK_MASK      =
                                      0x00001000L
> +#define GRBMA_PERFCOUNTER0_SELECT__TA_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00002000L
> +#define GRBMA_PERFCOUNTER0_SELECT__SX_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00004000L
> +#define GRBMA_PERFCOUNTER0_SELECT__GL2C_BUSY_USER_DEFINED_MASK_MASK     =
                                      0x00008000L
> +#define GRBMA_PERFCOUNTER0_SELECT__SPI_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x00010000L
> +#define GRBMA_PERFCOUNTER0_SELECT__XCAC_BUSY_USER_DEFINED_MASK_MASK     =
                                      0x00020000L
> +#define GRBMA_PERFCOUNTER0_SELECT__PA_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00040000L
> +#define GRBMA_PERFCOUNTER0_SELECT__GL2A_BUSY_USER_DEFINED_MASK_MASK     =
                                      0x00080000L
> +#define GRBMA_PERFCOUNTER0_SELECT__DB_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00100000L
> +#define GRBMA_PERFCOUNTER0_SELECT__CB_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00200000L
> +#define GRBMA_PERFCOUNTER0_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK_MASK  =
                                      0x00800000L
> +#define GRBMA_PERFCOUNTER0_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK_MASK =
                                      0x01000000L
> +#define GRBMA_PERFCOUNTER0_SELECT__BCI_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x02000000L
> +#define GRBMA_PERFCOUNTER0_SELECT__RLC_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x04000000L
> +#define GRBMA_PERFCOUNTER0_SELECT__TCP_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x08000000L
> +#define GRBMA_PERFCOUNTER0_SELECT__GE_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x10000000L
> +#define GRBMA_PERFCOUNTER0_SELECT__UTCL1_BUSY_USER_DEFINED_MASK_MASK    =
                                      0x20000000L
> +#define GRBMA_PERFCOUNTER0_SELECT__EA_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x40000000L
> +//GRBMA_PERFCOUNTER1_SELECT
> +#define GRBMA_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                      =
                                      0x0
> +#define GRBMA_PERFCOUNTER1_SELECT__GL1CC_BUSY_USER_DEFINED_MASK__SHIFT  =
                                      0x6
> +#define GRBMA_PERFCOUNTER1_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK__SHIFT =
                                      0x7
> +#define GRBMA_PERFCOUNTER1_SELECT__PMR_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x8
> +#define GRBMA_PERFCOUNTER1_SELECT__SC_CLEAN_USER_DEFINED_MASK__SHIFT    =
                                      0x9
> +#define GRBMA_PERFCOUNTER1_SELECT__WGS_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0xa
> +#define GRBMA_PERFCOUNTER1_SELECT__DB_CLEAN_USER_DEFINED_MASK__SHIFT    =
                                      0xb
> +#define GRBMA_PERFCOUNTER1_SELECT__CB_CLEAN_USER_DEFINED_MASK__SHIFT    =
                                      0xc
> +#define GRBMA_PERFCOUNTER1_SELECT__TA_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0xd
> +#define GRBMA_PERFCOUNTER1_SELECT__SX_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0xe
> +#define GRBMA_PERFCOUNTER1_SELECT__GL2C_BUSY_USER_DEFINED_MASK__SHIFT   =
                                      0xf
> +#define GRBMA_PERFCOUNTER1_SELECT__SPI_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x10
> +#define GRBMA_PERFCOUNTER1_SELECT__XCAC_BUSY_USER_DEFINED_MASK__SHIFT   =
                                      0x11
> +#define GRBMA_PERFCOUNTER1_SELECT__PA_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x12
> +#define GRBMA_PERFCOUNTER1_SELECT__GL2A_BUSY_USER_DEFINED_MASK__SHIFT   =
                                      0x13
> +#define GRBMA_PERFCOUNTER1_SELECT__DB_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x14
> +#define GRBMA_PERFCOUNTER1_SELECT__CB_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x15
> +#define GRBMA_PERFCOUNTER1_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK__SHIFT=
                                      0x17
> +#define GRBMA_PERFCOUNTER1_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK__SHIF=
T                                     0x18
> +#define GRBMA_PERFCOUNTER1_SELECT__BCI_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x19
> +#define GRBMA_PERFCOUNTER1_SELECT__RLC_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x1a
> +#define GRBMA_PERFCOUNTER1_SELECT__TCP_BUSY_USER_DEFINED_MASK__SHIFT    =
                                      0x1b
> +#define GRBMA_PERFCOUNTER1_SELECT__GE_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x1c
> +#define GRBMA_PERFCOUNTER1_SELECT__UTCL1_BUSY_USER_DEFINED_MASK__SHIFT  =
                                      0x1d
> +#define GRBMA_PERFCOUNTER1_SELECT__EA_BUSY_USER_DEFINED_MASK__SHIFT     =
                                      0x1e
> +#define GRBMA_PERFCOUNTER1_SELECT__PERF_SEL_MASK                        =
                                      0x0000003FL
> +#define GRBMA_PERFCOUNTER1_SELECT__GL1CC_BUSY_USER_DEFINED_MASK_MASK    =
                                      0x00000040L
> +#define GRBMA_PERFCOUNTER1_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK_MASK   =
                                      0x00000080L
> +#define GRBMA_PERFCOUNTER1_SELECT__PMR_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x00000100L
> +#define GRBMA_PERFCOUNTER1_SELECT__SC_CLEAN_USER_DEFINED_MASK_MASK      =
                                      0x00000200L
> +#define GRBMA_PERFCOUNTER1_SELECT__WGS_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x00000400L
> +#define GRBMA_PERFCOUNTER1_SELECT__DB_CLEAN_USER_DEFINED_MASK_MASK      =
                                      0x00000800L
> +#define GRBMA_PERFCOUNTER1_SELECT__CB_CLEAN_USER_DEFINED_MASK_MASK      =
                                      0x00001000L
> +#define GRBMA_PERFCOUNTER1_SELECT__TA_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00002000L
> +#define GRBMA_PERFCOUNTER1_SELECT__SX_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00004000L
> +#define GRBMA_PERFCOUNTER1_SELECT__GL2C_BUSY_USER_DEFINED_MASK_MASK     =
                                      0x00008000L
> +#define GRBMA_PERFCOUNTER1_SELECT__SPI_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x00010000L
> +#define GRBMA_PERFCOUNTER1_SELECT__XCAC_BUSY_USER_DEFINED_MASK_MASK     =
                                      0x00020000L
> +#define GRBMA_PERFCOUNTER1_SELECT__PA_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00040000L
> +#define GRBMA_PERFCOUNTER1_SELECT__GL2A_BUSY_USER_DEFINED_MASK_MASK     =
                                      0x00080000L
> +#define GRBMA_PERFCOUNTER1_SELECT__DB_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00100000L
> +#define GRBMA_PERFCOUNTER1_SELECT__CB_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x00200000L
> +#define GRBMA_PERFCOUNTER1_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK_MASK  =
                                      0x00800000L
> +#define GRBMA_PERFCOUNTER1_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK_MASK =
                                      0x01000000L
> +#define GRBMA_PERFCOUNTER1_SELECT__BCI_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x02000000L
> +#define GRBMA_PERFCOUNTER1_SELECT__RLC_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x04000000L
> +#define GRBMA_PERFCOUNTER1_SELECT__TCP_BUSY_USER_DEFINED_MASK_MASK      =
                                      0x08000000L
> +#define GRBMA_PERFCOUNTER1_SELECT__GE_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x10000000L
> +#define GRBMA_PERFCOUNTER1_SELECT__UTCL1_BUSY_USER_DEFINED_MASK_MASK    =
                                      0x20000000L
> +#define GRBMA_PERFCOUNTER1_SELECT__EA_BUSY_USER_DEFINED_MASK_MASK       =
                                      0x40000000L
> +//AID_PERFMON_CNTL
> +#define AID_PERFMON_CNTL__PERFMON_STATE__SHIFT                          =
                                      0x0
> +#define AID_PERFMON_CNTL__SPM_PERFMON_STATE__SHIFT                      =
                                      0x4
> +#define AID_PERFMON_CNTL__PERFMON_ENABLE_MODE__SHIFT                    =
                                      0x8
> +#define AID_PERFMON_CNTL__PERFMON_SAMPLE_ENABLE__SHIFT                  =
                                      0xa
> +#define AID_PERFMON_CNTL__PERFMON_STATE_MASK                            =
                                      0x0000000FL
> +#define AID_PERFMON_CNTL__SPM_PERFMON_STATE_MASK                        =
                                      0x000000F0L
> +#define AID_PERFMON_CNTL__PERFMON_ENABLE_MODE_MASK                      =
                                      0x00000300L
> +#define AID_PERFMON_CNTL__PERFMON_SAMPLE_ENABLE_MASK                    =
                                      0x00000400L
> +
> +
> +// addressBlock: aigc_gl2x_gfx_se_perfsdec
> +//GL2C_PERFCOUNTER0_SELECT
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2C_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2C_PERFCOUNTER0_SELECT1
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +//GL2C_PERFCOUNTER1_SELECT
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2C_PERFCOUNTER1_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER1_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2C_PERFCOUNTER1_SELECT1
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +//GL2C_PERFCOUNTER2_SELECT
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2C_PERFCOUNTER2_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER2_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2C_PERFCOUNTER2_SELECT1
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +//GL2C_PERFCOUNTER3_SELECT
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2C_PERFCOUNTER3_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER3_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2C_PERFCOUNTER3_SELECT1
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER0_SELECT
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2A_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER0_SELECT1
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER1_SELECT
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2A_PERFCOUNTER1_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER1_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER1_SELECT1
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER2_SELECT
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2A_PERFCOUNTER2_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER2_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER2_SELECT1
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER3_SELECT
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL__SHIFT                       =
                                      0x0
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL1__SHIFT                      =
                                      0xa
> +#define GL2A_PERFCOUNTER3_SELECT__CNTR_MODE__SHIFT                      =
                                      0x14
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE1__SHIFT                     =
                                      0x18
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE__SHIFT                      =
                                      0x1c
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL_MASK                         =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL1_MASK                        =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER3_SELECT__CNTR_MODE_MASK                        =
                                      0x00F00000L
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE1_MASK                       =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE_MASK                        =
                                      0xF0000000L
> +//GL2A_PERFCOUNTER3_SELECT1
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL2__SHIFT                     =
                                      0x0
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL3__SHIFT                     =
                                      0xa
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE3__SHIFT                    =
                                      0x18
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE2__SHIFT                    =
                                      0x1c
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL2_MASK                       =
                                      0x000003FFL
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL3_MASK                       =
                                      0x000FFC00L
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE3_MASK                      =
                                      0x0F000000L
> +#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE2_MASK                      =
                                      0xF0000000L
> +
> +
> +// addressBlock: aigc_gfx_gcea_se_gfx_se_perfsdec
> +//GC_EA_SE_PERFCOUNTER0_SELECT
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                   =
                                      0x0
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                  =
                                      0xa
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                  =
                                      0x14
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                 =
                                      0x18
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                  =
                                      0x1c
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL_MASK                     =
                                      0x000003FFL
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                    =
                                      0x000FFC00L
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                    =
                                      0x00F00000L
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                   =
                                      0x0F000000L
> +#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE_MASK                    =
                                      0xF0000000L
> +//GC_EA_SE_PERFCOUNTER0_SELECT1
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                 =
                                      0x0
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                 =
                                      0xa
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                =
                                      0x18
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                =
                                      0x1c
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                   =
                                      0x000003FFL
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                   =
                                      0x000FFC00L
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                  =
                                      0x0F000000L
> +#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                  =
                                      0xF0000000L
> +//GC_EA_SE_PERFCOUNTER1_SELECT
> +#define GC_EA_SE_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                   =
                                      0x0
> +#define GC_EA_SE_PERFCOUNTER1_SELECT__COUNTER_MODE__SHIFT               =
                                      0x1c
> +#define GC_EA_SE_PERFCOUNTER1_SELECT__PERF_SEL_MASK                     =
                                      0x000003FFL
> +#define GC_EA_SE_PERFCOUNTER1_SELECT__COUNTER_MODE_MASK                 =
                                      0xF0000000L
> +
> +
> +// addressBlock: aigc_gfx_gcea_se_gfx_se_perfddec
> +//GC_EA_SE_PERFCOUNTER0_LO
> +#define GC_EA_SE_PERFCOUNTER0_LO__PERFCOUNTER_LO__SHIFT                 =
                                      0x0
> +#define GC_EA_SE_PERFCOUNTER0_LO__PERFCOUNTER_LO_MASK                   =
                                      0xFFFFFFFFL
> +//GC_EA_SE_PERFCOUNTER0_HI
> +#define GC_EA_SE_PERFCOUNTER0_HI__PERFCOUNTER_HI__SHIFT                 =
                                      0x0
> +#define GC_EA_SE_PERFCOUNTER0_HI__PERFCOUNTER_HI_MASK                   =
                                      0xFFFFFFFFL
> +//GC_EA_SE_PERFCOUNTER1_LO
> +#define GC_EA_SE_PERFCOUNTER1_LO__PERFCOUNTER_LO__SHIFT                 =
                                      0x0
> +#define GC_EA_SE_PERFCOUNTER1_LO__PERFCOUNTER_LO_MASK                   =
                                      0xFFFFFFFFL
> +//GC_EA_SE_PERFCOUNTER1_HI
> +#define GC_EA_SE_PERFCOUNTER1_HI__PERFCOUNTER_HI__SHIFT                 =
                                      0x0
> +#define GC_EA_SE_PERFCOUNTER1_HI__PERFCOUNTER_HI_MASK                   =
                                      0xFFFFFFFFL
> +
> +#endif
> --
> 2.34.1
>
