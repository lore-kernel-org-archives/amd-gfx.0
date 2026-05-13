Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A0ECD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 15:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6743910EF2E;
	Wed, 13 May 2026 15:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YPWbtJla";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61F010EF27
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 15:59:41 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12c8c3f48deso219005c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 08:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778687981; cv=none;
 d=google.com; s=arc-20240605;
 b=TwJXPrvQ5s6qxyKnl5Myl4u3rrEF+skqDMvghDIITg4DAt8N8h3vp+ARIG+92MLWUv
 Oig6HcJ/W/kLMYsR7mGE7xTFH5s9fTEs5ByFwozLAbmQ0uyE4FL30JYhlddIPgLItO0W
 hR5YhUIJfae0PQc6p98GllxyoxLZMthmq7dKnN1L2PYFLvAS4ZRDdeUXeRyZkXaoYXCH
 NWtOLkZ8rV5vJlFJVbO1H5E3I/wAjVmL2X3l0uz141YexuvzOCmEbtYVdhJR4N6162Im
 AOwGn5grvgIzG/wF6Btko+Mc5Wi9HH8RzZEZ63wYBx+crkJc1GAzU3oTyb6LsEGn1QTr
 2FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z9535/HmXwdZvrjADVcTuYLxw8EZb54mj8ObkLgsQvo=;
 fh=RkK4X+KXPaImwer3RXwRoQtjcDeFs4Q0V1vlZBVqV7s=;
 b=BgCiqIAOdrZVBXNXo0EmjPykZoCKl+kXsticPkPhXf7UAP8npCa/iDHiqhwxnvhUsk
 cel093LPZV4x/mpzbZ4WgYlqx70yzCszF/bmTK57Pc8TBMns9GrXNMFHbGpIu72STRwL
 Wv4QyJmrY5lC+TxcvyDq1NFJUJfinp4X277tjbpvZJjdXIyRrWCqOvHqjW4OiXxTFMcw
 OioteNt/8D71Qu13XiGwsAvhTd4fl/ly8wwcgZnQYjzTcXO14Ee0HycKuL4m5klW7SZN
 xoylGPfa8Tg3cSIBQ3sN8ce0yt/+2HHQ+2oDBqINU+E4wCknmDTyAZKEqPZjJNaNMVsA
 ah5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778687981; x=1779292781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9535/HmXwdZvrjADVcTuYLxw8EZb54mj8ObkLgsQvo=;
 b=YPWbtJlaor+cJvFlKexdc/MR0mgQgypsy1Wg+Uyq+DxrN7J6TxjwREA+gF4T6SDhu3
 iccA7pqx3iaLzUiFwg8Iff5tQ4ojj+DP7DH43X0mvRI8nmkt0lSVZaf+W3a0eMzn+Lvc
 VAvnaIWTlCT16uSmBZLBNoqyHP7hvwJPQ34pMd3ntICv4uVE+hh11LlJPSbMkGWHB74/
 /zNdIHVfgzq0tYw1SFDj9rPXqNaapS/H9+lZEDzzlXEPnFpUpaa4w25tRnagmQpAQlr7
 Dx6BlSx7kscj4Q+tohiWAIHYbStrQx4AsU8Z/jB0TZt9bsygbQ9SDWWoDPn4Ad3Qg30d
 jTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778687981; x=1779292781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z9535/HmXwdZvrjADVcTuYLxw8EZb54mj8ObkLgsQvo=;
 b=Fcv9VsjMgRElnYh42ABfKRYX2Jq0A9U11BioCs/dZnMxwd9MwwzrN4+24hOQGqgf1x
 O3Lb+kVqwLAEM5qsNc3Po6d8OPmV+VpsSFuypwqN6XkrGhyh03PLEkr5M9uioox9aVA3
 O+UzdxTOrScXxi88dR0px7T6EZfxmumGGjQy+1gIWbSrl+mTYMBSJzUpDhhmpnut/6N1
 xwQnSDhmZ0IgF3YKBxzz9DSdd/nB2X3ZW4OPMogJT4DmbNSzBWk4Pohoct3Wp2KDojq0
 mimsOU8nyq9iirEtxLXftoWqMVhzB69NdZHGsfUns6PHS8jOt4JsMUQHjm7Oy6PBGx5O
 gXJQ==
X-Gm-Message-State: AOJu0Yx3JM+0YKmitF8hvj3vPHCaS8Td+5wxR44dRRoxysmvxm8oAxry
 azAhMZFIvyOkoaTUQ2Kr6TjS2afNPFGCOv1yKPZFb4LwApTWPRz1JWZqpTDwV9C0404aVEwQyPh
 tfQn2UtL/cy4Hb0/WKJ5i+l4hHWtFspM=
X-Gm-Gg: Acq92OGkbPvEu6P1S12qMte7U1i1u4aZatxpdOTX08UWYhIRtnN9vDJDUTtR/mH3NqN
 TGI8t11cjP0KkVBLgYR4fefTq7Y0Z7jmd0WLH5EjBMyCu4JeaSoTnvpytUIPpo9eCxCFY8p8NiP
 b+jPxpY3x72BZdDYwRKrLncJUfY+INmHOPrC/+93LaZoLT4T/m3rw1jVk63K6SPFsu0mCLTn+KH
 4+h4qbL68IIGPDcAWX7bQ7IL9YNYQ1xP/dHk7FoNKzKzktICRknlv/nWKoCD9wEhiJDD1cDjlLY
 OHgtFqt6uouO/P/dc6Q/GSIiamI/IC/NKVxiYJsdvuo+rtxiaC7G/f6+fr/l5ddDk6FZBg==
X-Received: by 2002:a05:7022:251f:b0:127:332d:63e with SMTP id
 a92af1059eb24-13436aa526dmr1098805c88.5.1778687980646; Wed, 13 May 2026
 08:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260513153856.2589767-1-Sunday.Clement@amd.com>
In-Reply-To: <20260513153856.2589767-1-Sunday.Clement@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 May 2026 11:59:28 -0400
X-Gm-Features: AVHnY4KmHlVPmTbsm26i4SeB4mVpuxOF9F7cbBgKaDVSRTGs4mWhNdSQinsSmBc
Message-ID: <CADnq5_NQ3eiVFeR-mg3h4g+AAV0rXFvQAk3fuayY-Xh_ZRJBdw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix OOB memory exposure in get_wave_state()
To: Sunday Clement <Sunday.Clement@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 jonathan.kim@amd.com, Harish.Kasiviswanathan@amd.com
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

On Wed, May 13, 2026 at 11:49=E2=80=AFAM Sunday Clement <Sunday.Clement@amd=
.com> wrote:
>
> The get_wave_state() function for v9 trusts cp_hqd_cntl_stack_size and
> cp_hqd_cntl_stack_offset values read directly from the MQD, which are
> written by GPU microcode and fully attacker-controlled on the
> CRIU-restore path (via AMDKFD_IOC_RESTORE_PROCESS with H3).
>
> this leads to an unbounded copy_to_user() that can leak adjacent
> GTT/kernel memory. If offset > size, integer underflow produces a ~4 GiB
> read length, if size is set to 1 MiB against a 4 KiB allocation, we leak
> 1 MiB of adjacent kernel memory (other queues' MQDs, ring buffers, KASLR
> pointers).
>
> Fix by clamping both cp_hqd_cntl_stack_size to the actual allocated
> buffer size (q->ctl_stack_size) and cp_hqd_cntl_stack_offset to the
> clamped size before performing arithmetic and copy_to_user().
>
> This ensures we never read beyond the allocated kernel BO regardless of
> attacker-supplied MQD field values.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 7232a0117a00..b311e3918eb9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -395,9 +395,13 @@ static int get_wave_state(struct mqd_manager *mm, vo=
id *mqd,
>         if (copy_to_user(ctl_stack, &header, sizeof(header.wave_state)))
>                 return -EFAULT;
>
> -       if (copy_to_user(ctl_stack + m->cp_hqd_cntl_stack_offset,
> -                               mqd_ctl_stack + m->cp_hqd_cntl_stack_offs=
et,
> -                               *ctl_stack_used_size))
> +       u32 cntl_stack_size  =3D min_t(u32, m->cp_hqd_cntl_stack_size,   =
q->ctl_stack_size);
> +       u32 cntl_stack_offset  =3D min_t(u32, m->cp_hqd_cntl_stack_offset=
, cntl_stack_size);

Some compilers will complain if you mix code and declarations.  With that f=
ixed,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +
> +       *ctl_stack_used_size =3D cntl_stack_size - cntl_stack_offset;
> +
> +       if (copy_to_user(ctl_stack + cntl_stack_offset, mqd_ctl_stack + c=
ntl_stack_offset,
> +                                       *ctl_stack_used_size))
>                 return -EFAULT;
>
>         return 0;
> --
> 2.43.0
>
