Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5698DC54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 14:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F3A10E203;
	Fri, 31 Jul 2026 14:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9VEmWma";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BB710E203
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 14:05:30 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so114632a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 07:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785506730; cv=none;
 d=google.com; s=arc-20260327;
 b=jX8zXumCYmJMemuTy5nE519ipxepgKgmPhr/I04aGdSDubU53uOPn+xs0xujLFOxyf
 p1pqYLT5OoJwTsKYnyllYuKOrrgjwGIjQ17QxjrpFA/x0BAAbDRB2j44liNwDXAXLzkb
 b7NQBXAqtPkuuVj9dLczGdI3shM87dCJwsrcccI3LRKQdAwwL/RPHTodBHGUZ22EZ0jJ
 2SYbnH5nuBtSl0QoZngRuJT11t2Ta2OrATBPs8z1+xKMwl4FtJdYGRPTI5KdIYR9aaZ6
 Qdh2io2ji3NlJk4xiaiHK3V+mln4uGcBMBUO1bvajnq/gaqzkbm0/xZkH5fYhjDRlvDC
 OUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xFWM5LqU+9wqdcjQj8AWWwSIomfFnbWnch1gXLRGQkA=;
 fh=/tu72ylnJ0kCzCU6hvKKHktTogYml1it2vtbmy8I+WM=;
 b=lr2kWWX4g7G1b9IbChN0ub9+1kirKTIXEmyHaHNVqQuFVxQHdqiQYIBp2962RE0fU9
 5Pu9pn6+MaEwF8777djV0RzZIriq9wDMUZH5jm+UzXExZo+Zv7ITujw60dMGMAS/g7ib
 YD35Oxd1z89LoM0s1xk/eqvnsb85NS86XbMWtgRbd5/WWC35UAPb7wkNEb0mH0YbEggz
 gX8wN5HEpe44NTuSN4hnwC0ENXfS5U3ntLUrH0YarXSq/HJ3b95KH69XBYptcjKNkaOX
 wO1vYLxKABURH3QoBNHIzEX/qfMpUxSu0VJo4AsqLhLsflOcLC4EHgOj0mjFoc4YFKqn
 wLLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785506730; x=1786111530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xFWM5LqU+9wqdcjQj8AWWwSIomfFnbWnch1gXLRGQkA=;
 b=S9VEmWma/E06JYN3nGtkMJyudMw8lftqNlwbXwYytms+z6OtQlCI9Sfi2InALgE0l1
 PhWEcCUALCaKOb7CLeU+29/j3dUKgd5uIhH1j1KbMMU8DtoGuugzpXEONuuP6wxSPiPk
 dsG7M8Qmx8hCIIqPq0SEda0TZFIECH6V9jOIRoOlGlHwucE9MaJKlmGqLFIQpEY0PhbY
 aZhMuWnjqPguu7KRclP0PmmyjZyWSRb+DQYiSkY16bfX1jfeTqF6EhyY6xp9Q28kzYj3
 IwOZofkmJQzNNEsvJBHmA490CB93UNLK5DJh8vjpgoKxQSLSn9Q3JnmkJQkDxr02ZsXz
 fQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785506730; x=1786111530;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFWM5LqU+9wqdcjQj8AWWwSIomfFnbWnch1gXLRGQkA=;
 b=PiwE6wzEDbk7nQe0hCT1zpzPWbwXBHupG/GlAWvsYtBlCEP8T5WRVKKh3eWt9szLyx
 84rzBDr28ItIEctiYvLyarraqjKKZEztobjG9AU8kyfDPtlmtcgcbaqZzMIBG0fQDEbz
 8J3RmReL/jlDf6++d6/HjCP8jTXMlhpKRqo6ql7hgRNjK7zE6hthJsUbmVuHqc59zTbW
 BJ0JdR/WAtiXICs4P/MoQTmjBrE2VarqTrjaDB50eGeWzXPS6UBAWZqWsoWvcDQW+nNR
 SRz6rt6sBqLtvTqVqVS8K4DBiP2vvNLppf5mrF+01/z8GGvy1Dg9vavs8/6Elw4NWwAu
 9psQ==
X-Gm-Message-State: AOJu0YwWndjDxYHe8bwC/NDbLJe/z6kQr48q54vv0E3vJa9/iGNsz3xa
 CKpDudUqnToiSzMS2w9NZO1AvzQSk/3i0xn14zd6bFOw6whToP33XRD1swMajOa5rZHhTQFszwv
 /bayzEi8sybD0eZlYhBMF6bfKbEsqqcIN6A==
X-Gm-Gg: AR+sD10gsbahauXLW3q/ymRVwtMXcD6hTPZS5h+9NQ+bM2u+x7JU3qtSKTtxtwZfY/z
 BaEAaA+3GyAVcth5dmy2g7ZBBXCYHJr9eIN35TJQiUAtRFmMZV9g6gA+esGLQK4trSb6J0eIoDq
 t9ol1d7ptAoWo4U7SjCVvv3jJ6S0FQIz8MQNEpw4r3Z5zmuZw96+3Ft5wuaWSGurHT0HbSKbx9N
 BwSyjbZRYFQR7//4Iq7cTdD3dAFnrRlhbNvXnIiV9Of6197CymtNsPgOEotYJ7Wz0gjMWx7Udoz
 1r4MltSjv7sc/TZ7/Uzu2QNbWPjMV7gmMtmGZyXIMSGfDoeU6uT+LRs+sILHTZrEZrzBpC0V0rq
 o5jlzxOrIC4+aAOIiqKj9VcnotM8QP/hbjruKGfXdpQ==
X-Received: by 2002:a17:90b:58c3:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-38fbc4c673dmr71177a91.2.1785506730252; Fri, 31 Jul 2026
 07:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260728153930.1531949-1-alexander.deucher@amd.com>
In-Reply-To: <20260728153930.1531949-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Jul 2026 10:05:16 -0400
X-Gm-Features: AUfX_mwiPjYJIqu3hHXxIPm2A8ceJEi2XX4W5EoNkrLARbBLcDzC-dabFm1Zeew
Message-ID: <CADnq5_N3oqFeYwaV6nO_wxU+7K=4ymM=yLHZCy1e03FxMQy2Jw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun Liu <shaoyun.liu@amd.com>
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

Ping?

On Tue, Jul 28, 2026 at 11:48=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Check for mmhub0 rather than mmhub1.  Looks like a copy
> paste typo.
>
> Fixes: d0c989a0aad3 ("drm/amd/amdgpu : Use the MES INV_TLBS API for tlb i=
nvalidation on gfx12_1")
> Cc: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_1.c
> index 855cd29cbffaa..54a5e64f53b3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -396,7 +396,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>
>                 if (all_hub) {
>                         /* invalidate mm_hub */
> -                       if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)=
) {
> +                       if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)=
) {
>                                 input.hub_id =3D AMDGPU_MMHUB0(0);
>                                 adev->mes.funcs->invalidate_tlbs_pasid(&a=
dev->mes, &input);
>                         }
> --
> 2.55.0
>
