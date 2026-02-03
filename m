Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D58E87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 14:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EE010E680;
	Tue,  3 Feb 2026 14:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mITvSeGg";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465ED10E680
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 14:12:07 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1233ad1b4cdso222989c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 06:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770127926; cv=none;
 d=google.com; s=arc-20240605;
 b=Q+f57PWyMe/NjeRCXW9G1S1KoY9LYvQaNSA16Yxh00fiyaGjhlzHioMnqfS8VsfxPW
 HAppGHqlzE4W7ZY5xk6TndyXIjVeoUOFJrW6xPx0xIBhIxhimsbm/AfSmYJBw2wkSvFE
 mMITeE0jAoXGxpy6930u2W866n4kYvYoq+0aFx7QiYjkKNx12gVM239+DgpfZDlIuh0M
 6mTsKB+/eFelAzrd/MGLYo46EsysBh6tKnsF7cN+sBbPJccgN0MK3kPKUZ5zwb+JwyYS
 Y8+rvB/X5MF9EGquvxmR2A9ZCY4c/IkIpTXq+VEK8LbMAQj5bq0loFwuM/PpNyEsx7tT
 YmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B6O/IoEadhGkkzbcYSV3l0ncPXjrQlE60Eq2bqPK5EQ=;
 fh=03m/5XhUHPXVPwhpREfTOzPfpFPiNtfaVNFjS8GClTM=;
 b=aawOPmDrLNHEBJh91lWLbO/1kND66P82KnN93eyv5OsIiYSiFcxmkAif/ZU8MbPNaJ
 Waum2C2l+aPXCHWByNWi3aLdKOp/pyoVg65MfHGt7W74miKpz8SlupFKNxVOoVomzNrt
 n5S9rLVA0ooo5BWP8JOsXRH4Sc41Mp9UytGRzxhPPH8MMZAEBs/GvyUfgbPltj8eWbIN
 tZ3RanlCXLP8UG64DjffyEOXlvs/E1oe5ZOonZXITHy8PjDdjwJNyMDKV1Kpxt5rDDzF
 XV9y8hTqjmwRO4VJJlgjzOgss515dCg/uBYLXYJ8qeZ1EvElU0n4iZp1sikF1FhKLV5B
 ca5g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770127926; x=1770732726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6O/IoEadhGkkzbcYSV3l0ncPXjrQlE60Eq2bqPK5EQ=;
 b=mITvSeGgnRScNsXFep6LZFqNMMGY88jAi7fvm73pcv5+vqi46jJ/gElAGOzTuzwOrW
 PYqCcnz7XAdqwF3UxP0dX2NGx1UcRY2W3BcJZzmb3A0Wf1zG/QnQw1OWnOAl2aBpxquN
 tbJgbbilyLVtlN+P1ISlP8BqkHkx1Ii1nMEAb8CoAWg7crKukfzcyydS2KYPRYtQBm8J
 TBY5FuXuOm4T7g34nfdtfUiityvWcr7dn6svTSMThJSeF6SG+2ifllWUbw/77jEE9dag
 i4E8VljwXgYzBa9DbK15he5OIuKlIMKWfvDwfclIxgCOxG0qmJYFlMdAE38MS1zNp7tP
 bX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770127926; x=1770732726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6O/IoEadhGkkzbcYSV3l0ncPXjrQlE60Eq2bqPK5EQ=;
 b=iTmD4xBgOFf1S/xrVxAXc9yXaV6KwRC7eOSPQs57J0DvzfrR9nevbNdAK45/g75HdG
 1OFjsrPDAxeZ+6wSW8uj/z9fTQp9K0HY0hWdSD25UDsPSb4Jbcc4BICuKPdmbnaK/FQJ
 0WTi7IVjsDm6jgJg38Wqsttk4PtM6mPnr4IOejMCczP2m59jRwHPMRRiQVLikjJ4GMxM
 gCNRUjxtqQ1uscy1TWeqUbgJMVQUOYcSuJ0Es61/5fMLN3cdlFrxGBqL2KD+SIND8XcP
 HtjD+EUDC64RqtDvdTYueN6DbpIq4Owg6gHKWVItoGNwtQCWRe0h4zYCprpZEEi3TLL/
 T/hw==
X-Gm-Message-State: AOJu0YywYhyuHC/D2LZ3wmXdPl8y2eGIwnG2z5LDj5C37znjOSlkWnMT
 9tgZE/bgr54Pqm9vTOjZp6PGOrETTS0f8RL/POD4Sqp0i40KcqrbUEC9+A1roSWnFHo4RdYUBNE
 dRKKoZWomp8CEpAC/AJpr2wwwWI0gBJA=
X-Gm-Gg: AZuq6aKXSxwk9JXJpAae21TqcR1+sdNYhlZvu2MIffDWnp9XcyTpa5iwrGKBfpcEPXl
 /XWmMuxqBB6WD2c1g6FFu9lncGlI5L3/KiVj3nXu03rqD1NP2ZMnxPLwkxdRRUbmP9c1k9DADrO
 jTlh4KmuapIoXjHCHvkBLR8PdAs1Fiu1qMeNLqjgd4tipRlstHXmTthZJlbTRhBp2UvH8Tdg+NY
 UrelnOnNbFDC0SekKeeCw7oKngM0Xx3eZ2bbE6LgT2JwRk/tsp9UG1xTOCZky9B4cwbHsxW+bmZ
 AyHXnBg=
X-Received: by 2002:a05:7022:1e12:b0:124:94b6:2a1f with SMTP id
 a92af1059eb24-125c0ffd690mr3167941c88.3.1770127926465; Tue, 03 Feb 2026
 06:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20260202202850.992745-1-alexander.deucher@amd.com>
In-Reply-To: <20260202202850.992745-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Feb 2026 09:11:54 -0500
X-Gm-Features: AZwV_QjXGvHqtoxg9kYxiuv5vtgYUuUvTqtRnMz1Yc0mAK99uYllkaqPSbb_SCQ
Message-ID: <CADnq5_NZKaqBHNs9CHiQwwKv+PH772uGFk+cVHr2A4yDy5D92Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma6: enable per queue resets on more ASICs
To: Alex Deucher <alexander.deucher@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

+ Jesse

On Mon, Feb 2, 2026 at 3:37=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Enable on the other SDMA 6.x ASICs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 35e00ebba0300..6f4704c1b3a10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1380,6 +1380,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                         adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
>                 break;
>         default:
> +               if (!amdgpu_sriov_vf(adev) &&
> +                   !adev->debug_disable_gpu_ring_reset)
> +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
>                 break;
>         }
>
> --
> 2.52.0
>
