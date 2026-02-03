Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97886E8782D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 13:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD99B10E656;
	Tue,  3 Feb 2026 13:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UP6Mu34d";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03DC10E32D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 13:43:17 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b703e04984so460735eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 05:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770126197; cv=none;
 d=google.com; s=arc-20240605;
 b=WrZlERTD5oObMZxjcdJJ5yf/CBUhKdtIhdDFNDL+s/oJb+P6+a7C1bZlERQA636gH6
 TPBnna7lJ6HQIBhxoVbQhi0EyXVi95i1WdbOilBmvxjOP87LOkccRyj6UPb9wf61PJDL
 zaJIdT4qWNxsczBUT6skhKJGLuLVxWcQI2Tpvc731cB2zQqy19BYq1mbW+saCm29DLHi
 4dwzirw8qV5fc0b5o0i2Ace29VIV/LtxGuKQqxH6AfWwifBP5wOel5BZLtaMZcYPwSzp
 2d2I7czbJZeebqAsz7Xnr61cFJ6pwmF1hDhOudqneV8zhfuDw5NaS1KRdW0WaXlJBpwQ
 ExDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wv/3+JBsz7vPGNvm63ePy9AZiQ8US3XCBOfeRrjQ6PQ=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=BadBkrznAFVXmSb/JSp38oYi1lFsU47IjN8TOZ/b97Z9nrMPHcqxIMOzmfVl1laffG
 NIr8rbXRgMs0biDed8G1zwFDZ/lP85y7Fp2IOv+ByZaQs3yJng++IpZknA1baGqgGOAo
 hQSfVCSQg517KbALUpSJDJFgK+wnIb3FVG5oh8l6cKS1IMzb8yeEgOUTFOUeHc84tfRM
 /vbjtIv/xuG/s3IDqaZ3DAaJMpgFcjs8zUInUL+45pB+gwx9QMCSQfz7xFtmvRWMQvrc
 8KIsW8CmRFQ6G8lPbz5JUcS3+jcYWtu7TTHMu2c61CX8J+tzDHKSmYzViZIxPWXLBq1d
 nq0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770126197; x=1770730997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wv/3+JBsz7vPGNvm63ePy9AZiQ8US3XCBOfeRrjQ6PQ=;
 b=UP6Mu34dOLw2uUv2MX+fDr0tT8EVPVOpuYfi2k+Qfu8IauLk8XYmxuQj7BEwdk9Y0R
 68I1rH4oy4tBPi93puVnNVyKToHBXEHn89Pb+NivPhUdxEKRsFL2h2vnO6OSbhtf2N4A
 zrOJBHMnSSOelWSQVXW62N+7NcqEEbUhmcSD+Xb4dgfMAI7yAacUaaSJV97jWjWBAqup
 jvf/9Cbi9khskHFZFdHQcyKUOMuXyUxfEQoQ3j36JDLB/wI6BPrJXUeuz0YThS8WzAQb
 NgeIq22jIjOne7/sAxQUcIXrD16oyGYar/zWYPBZwCaMlmBZYr+tNaoGvxEiYfTqu6Ed
 74bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770126197; x=1770730997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wv/3+JBsz7vPGNvm63ePy9AZiQ8US3XCBOfeRrjQ6PQ=;
 b=OYhzxgBy6Tfdj4YPff4JWbRzGm3FVfpnBqx426cg7wheXWExKr/Mp16qJK5HJa61kn
 U7IrzG0cUABsX5aWtYNlUpcyWem3WKaw6LQ6icmAhI0biOvcBwVZSlltGNBEkg10kbwq
 voG+ESh5HzPcxxM0dbkFGhv2Cqpmoeyi2wxm8ca31SJR9SfK0jnpCcpkHB22YBAMmB/G
 IA0mKEnwypC/2KW+Z3X+CPfG9Z02NWNIsheH8sLb2GNP0IXlW2bM61OGlv/XWYhR9nkJ
 wTt6NjQmpA/HUhGTRJ2gykmOiZrZB2GfpVQ+Aw13eZj37zdQijMmoqecpDQlhAyACRap
 S57w==
X-Gm-Message-State: AOJu0YwrZ/ryHbMDBIjHMu8yyMgfoDsAXU6HnYbB0373lVFzaAc6hr5L
 ymIX+y7x/bDrOeU+F8cnYgl/FRDwV5W/V8Or5RsbGWx5nsQjMIHZCjaWRqy8RzCaN0UVdWxSDx1
 iUzX6tgviMK8BaCh+DNjo4f/LBJExufY=
X-Gm-Gg: AZuq6aLbfhcYSaq0n9qU3YJogdSQsH9aOa9YH3LPzGR5Cs+7pknKYMeN6lK9FvdgHY3
 GW09Aw3VlV780M/ZqofycYgpazCg+VWlygMj8TzthcsDKji2ubBFMOWPAs2eIA8GElUwZEagmR9
 Qyun8TQfwyhMoq5eBPyd48MoFSPxSsOV9RQenNFCfOz8MsOt5rwuN17opFIhQJCZHUqFeRXgR0n
 O/1FbopNFyHy0If9Uan4GaLxdK27BbU86ElHrGP/APiHfEvpsu3Ah9CQZjoMKwPtepyA5C0Fs79
 lzIHPBU=
X-Received: by 2002:a05:7022:2513:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-125c1003410mr3546230c88.4.1770126196759; Tue, 03 Feb 2026
 05:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20260203085706.450079-1-Jesse.Zhang@amd.com>
 <20260203085706.450079-3-Jesse.Zhang@amd.com>
In-Reply-To: <20260203085706.450079-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Feb 2026 08:43:05 -0500
X-Gm-Features: AZwV_Qi5pS1UW1B1VaqFQeiglIjwvqPGDHgQwqHCQ30zfFHt73EQuL4zZHcuOl0
Message-ID: <CADnq5_OxS6_LmZTNS41TzDz8kJA6QkdZpmWMvynA93hNceR9sg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/sdma_v5_0: Update per-queue reset fw
 version checks for 5.0.x ASICs
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Feb 3, 2026 at 5:07=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Tune SDMA 5.0.x per-queue reset firmware version thresholds for specific =
ASICs:
> 5.0.0: Require fw >=3D24
> 5.0.2: Adjust fw threshold to >=3D30
> 5.0.1: Add new check with fw >=3D38
>
> Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index d72bd3adfccf..72492692f680 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1432,17 +1432,32 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].r=
ing);
>         switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
>         case IP_VERSION(5, 0, 0):
> +               if ((adev->sdma.instance[0].fw_version >=3D 24) &&
> +                    !amdgpu_sriov_vf(adev) &&
> +                    !adev->debug_disable_gpu_ring_reset)
> +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> +                       break;
> +       case IP_VERSION(5, 0, 1):
> +               if ((adev->sdma.instance[0].fw_version >=3D 38) &&
> +                    !amdgpu_sriov_vf(adev) &&
> +                    !adev->debug_disable_gpu_ring_reset)
> +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> +                       break;
>         case IP_VERSION(5, 0, 2):
> +               if ((adev->sdma.instance[0].fw_version >=3D 30) &&
> +                    !amdgpu_sriov_vf(adev) &&
> +                    !adev->debug_disable_gpu_ring_reset)
> +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> +                       break;
>         case IP_VERSION(5, 0, 5):
>                 if ((adev->sdma.instance[0].fw_version >=3D 35) &&
> -                   !amdgpu_sriov_vf(adev) &&
> -                   !adev->debug_disable_gpu_ring_reset)
> +                    !amdgpu_sriov_vf(adev) &&
> +                    !adev->debug_disable_gpu_ring_reset)
>                         adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> -               break;
> +                       break;
>         default:
>                 break;
>         }
> -
>         /* Allocate memory for SDMA IP Dump buffer */
>         ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
>         if (ptr)
> --
> 2.49.0
>
