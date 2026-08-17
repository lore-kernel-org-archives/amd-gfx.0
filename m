Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB8BC5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 15:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6F110E883;
	Mon, 17 Aug 2026 15:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iIKZUvxU";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C15B10E261
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 15:52:21 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-385b78b4f9bso295953a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 08:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786981940; cv=none;
 d=google.com; s=arc-20260327;
 b=O7ceTS0nqTHshTBa/QQhZcrZRSXrbzzWIU4gbNkn6Xc/d3De7XaUPDbdvLCtXNLqdT
 KjtdvyL/ubUPkp0q7HN5y7KLp7cdXz7YS7J7TDjxq7k9Ex0WrVepx0vwayLC/XdHDOXa
 74o6SruM18TRi4lP/xTQNdmHQppy5t4yJeMF+eBVOIXrIl7Dkntz+eHRmtv0zwhLTR+K
 o5b0H6SAdDJJCj+u40+Yiho4pvML1CTQwpEBTkxEQ7LUY768fkBzA53iEV42ZFfFxLww
 iLssLkPqU0TgGMoQsnL73mR3YhiG+Vx/pRhIoCgA1UKuDXwdY/+FP9xa6srLS3KLhd3W
 euHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IucPUu1W2J+zIVlTIAFTCSLx0rQfqLKBJDrZj7TQaE8=;
 fh=YFqqTxdR3R9j06ZYM4qB+o3OGNiDDAN5wTvPWvcIcoo=;
 b=h4yCW/dS3qdytHVzbuXm43Wa1VjkBDlwOt2u5nEiPGdj17do8Uxj+3UQ/BeIIj9GtK
 +DhreuBrM/IwdhchmwCRgPQTGdgfLAueTYghLQMBzJ6bflKuXuJDUQyqiKPSp7KxMF28
 ZYV8GtE+sTWV00t+5enY4mteVkeqMvo8RkckIxI6L0eGI/DvZHkSakezdXgRnWYS+RQZ
 ZjiIyQ0D+gi4n9aVMvnRJMfmwJnZg2GruWEpGx7d116zv7EY1WGL8FY/s+DowxYQVjbe
 iFPH6mhmGS27zf8saMTE6jemhugm/DIzyNU2wAfL/1dcybjgHhs8z115ARekCe2/R6kP
 MX/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786981940; x=1787586740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IucPUu1W2J+zIVlTIAFTCSLx0rQfqLKBJDrZj7TQaE8=;
 b=iIKZUvxUtuf++CjlvQ/ANW4s5Z2Xfex+onM+zD5iscfRs2n5AYkg/Lp/fuUsM+lS+h
 GVuWZEQ7mKAk6GY1aKjYnW2m6NsP9Ek6BcP4h4T6k81yXJRmkuyqqPPgTw0Y/CJrd0rz
 5EBUuf1u0Oc6rIx+R+j2qJuwdiM0AMbK1LfKhre2fMoZ6j15dCsh38SubsEyPgULZ41p
 gg8gda0sSpO/ZpWSWICAUONMn3DwTS8mHcbsIVWHpTHi5iNcuYgeWUbSIr9hceXH4ud9
 Xc75XXA/S1PEKyXL7OxuBey13ynXxev9Rk0+Fhzua9oq2ThwXVkS1ZEUqTLlJZTSYx46
 WaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981940; x=1787586740;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IucPUu1W2J+zIVlTIAFTCSLx0rQfqLKBJDrZj7TQaE8=;
 b=Dva2g0cyBZV1P9xJiUxJqvgzfMCRaiihegHRVwbrzyljA2N+CA4EFXMpsAR7HKtGcG
 sGX/pUYDGnRTWmvVRpocdtt5ez33N3V89TILs0COxEg7CXJnj24UflWvOxsrPHhPTx1v
 20jBUM+5T+1B6XHeJqb0/hARrA85NeRo3YsNDl+LvMHWT5HxDtbg8qKlkjxHKbq1/M7u
 rr3F/jq8Ar/MlpueFj9kFDSw8M6h0oQ/COZtnWRw1AeRk+xNCGzN0GXAKxPC/ibVM1Qo
 3VikzPVmLyG0dq8IGH8TeMhMn11W1rkvnmPSu54c52AqRmQ23UysSOw1yYqw7Hvqn1AY
 IhZw==
X-Gm-Message-State: AOJu0Yw9UlYPx5NUTnUWPXt2kkqYeBpwH+Y8ZOLuiNGKGwEx2HksqbVX
 gG33K/mDgXsblK8U0h9gl3tSwNzkjqUWCEurBS0/m5P9Rt0Z5xd9IfxE4kB4vKCJx8eqns6OjDe
 TOEkoBbdwJFQgPEvXHWDVEAcWWnUaNyMuSQ==
X-Gm-Gg: AR+sD10frtyrj7m5avIY0q1IaVbWJ/1idRLY1MpnKgZ/f1Nwcvgy+yKwgykAmdi1rhF
 mdzfzIZmWSnJGH4ekVS11Jz6SXm8IaZbIKr79FpND5W1YrdJ+2tnGf7m7M8LmdYtvRogpFZ4pC1
 oHxR3I7UcsEc6DlUKyLjwtCnx7Ucfkw74lhs2Y3HFjYCjAdeTd1dKfK8nh3ATtGx70Fzc94VVBb
 dd352hdHzJTwKk7xWMD3T4MkI1yOIaWMugMuhLu8/BlB8NFVLzjdzFUJP4nhsqMLK2mZGQHs4QV
 oeyrpmlH7R8a+cXIjqM1TMjqUYkuVJEN8MzB9HwKz0SsyuJdT6TXP6AquzrHa4QIeHsvIFkckEU
 oWOAVai5oM0rjanmEUITOnu0Hocyi1N/xNOJFtXlZQYo=
X-Received: by 2002:a17:90b:4c87:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-3933b7d1d85mr18765658a91.1.1786981940451; Mon, 17 Aug 2026
 08:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR12MB8600EE73548498C578990CF49FDC2@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600EE73548498C578990CF49FDC2@SA1PR12MB8600.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 11:52:07 -0400
X-Gm-Features: AcwNN1WgrTce_6V2_S6DdZTuZY_mOwpuxGAKNxyX-QQXQktsam3XEWNz2joT_qY
Message-ID: <CADnq5_M3K3G=ugc_mSAq0dE8TJA=1cZHgZvfjPS+Jj5aaQcxXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix integer overflow in queue ring buffer
 size calculation
To: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Wed, Aug 12, 2026 at 11:55=E2=80=AFAM Marioukhine, Vladimir
<Vladimir.Marioukhine@amd.com> wrote:
>
> AMD General
>
>
> queue_size and metadata_queue_size are u64 fields copied directly from
>
> user-supplied ring_size and metadata_ring_size ioctl arguments. When
>
> both are set to 0x8000000000000000 (2^63), their sum overflows to zero
>
> in kfd_queue_acquire_buffers(), causing kfd_queue_buffer_get() to skip
>
> the BO size validation and accept any GPU buffer object regardless of
>
> its actual size. The resulting queue is misconfigured: the kernel
>
> validates only a 4 KB backing GPU buffer while the hardware is
>
> programmed using a ring size derived from the much larger user-controlled
>
> value, potentially resulting in GPU MMU faults and GPU reset.
>
>
>
> Use check_add_overflow() to detect the overflow at the arithmetic site
>
> and return -EINVAL if it occurs.
>
>
>
> Fixes: c51bb53d5c68 ("drm/amdkfd: Add metadata ring buffer for compute")
>
> Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
>
> ---
>
> drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 +++++++++---
>
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
>
> index 25954c2c2d91..52cc022dea36 100644
>
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>
> @@ -250,9 +250,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_dev=
ice *pdd, struct queue_prope
>
>                             /* metadata_queue_size not supported on GFX7/=
GFX8 */
>
>                             expected_queue_size =3D
>
>                                           PAGE_ALIGN(properties->queue_si=
ze / 2);
>
> -             else
>
> -                           expected_queue_size =3D
>
> -                                          PAGE_ALIGN(properties->queue_s=
ize + properties->metadata_queue_size);
>
> +            else {

Both sides of the else should be converted to {} if one side is per
kernel coding style.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> +                          u64 total_size;
>
> +
>
> +                          if (check_add_overflow(properties->queue_size,
>
> +                                                              properties=
->metadata_queue_size,
>
> +                                                              &total_siz=
e))
>
> +                                         return -EINVAL;
>
> +                          expected_queue_size =3D PAGE_ALIGN(total_size)=
;
>
> +            }
>
>               vm =3D drm_priv_to_vm(pdd->drm_priv);
>
>              err =3D amdgpu_bo_reserve(vm->root.bo, false);
>
>
