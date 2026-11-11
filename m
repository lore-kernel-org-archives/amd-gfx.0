Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C4606A324
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F2MsOQzh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E077C10FC69;
	Wed, 11 Nov 2026 16:36:24 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A0810FC85
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:36:18 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36dc4797082so103223eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 08:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794414978; cv=none;
 d=google.com; s=arc-20260327;
 b=pwOh8WUz7LWmOFPJ6D/O1Ic32Z9VaaRJWQqDuoLmlN1kdaeQKLyg0vCtQhryY7o2UL
 VMn+vBNJiD0GUJMdqfMY6aaBTI4M1W/FFXU7ZqyntjWPBsb3U0eI3tTyqCkina5tymz2
 b9Enou4KnPIE772srkNLnAugNJ3cSI0fitcATk+6gwFSbYss9mrKGF1xpKc4ty6DtqoR
 EF5B0kA+DyDXc/aG5LtbnPWmNVSy646rttFNF7UTGifeTEJqyuUIBmpFG6VVr9JxiJm6
 K2d5yn9+OqHOGCNIcIZ1QN8bJ2dNsg3UKvlGofgoyYXUMmlqHn8hW4nFlSzaks09VzwT
 Jo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rii2pBwnuI2lntVcwEuArsZ4V6Lz/RZtRogeQ1tXXaw=;
 fh=34o6HRZfg4mVNFG8m3TZG9D91r26CMVAuVKBA4HjbQg=;
 b=GCzvZePU+JzzStbdcphwehrmhL/bLjwwQCyjvBzXpnKEuUUAjgwQD7g4fZQlr47uu9
 zknBAXVMtU68c0hjgWaPc190iZ1WJirD7iZT22V/8efpSVxhzVlN1tAZgu3m/ERSX1Do
 o8VIANlIgsGHDqnyT0wRhIpz43Ys/MgS01AgJtn2yjlHS2/L1DvzFzJLWGfQBEymS8fx
 hCkiU+DGt8BlZZf0FffZEEFpmnDiJJa3JHjmFnfeH4tS3ToiIrZb+mjuqpXQs1Xephir
 UP3A/KhkVtoBuG21E2x9wFVtiz2dMncgC87Cf9w2jID5rnBmO5l8HuTAEtcb4GrGMYP2
 PFfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794414978; x=1795019778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rii2pBwnuI2lntVcwEuArsZ4V6Lz/RZtRogeQ1tXXaw=;
 b=F2MsOQzhXFCdpVQ3zEOUtsB7WBjjeRz++41A1YsGK5hMilue+9pRsNxiGWMjmKwGki
 p2P8bFPdjmpPfR/3SlT6xzlQWb6QYj3VIYk5FDVgD51Zruz/ZpPQBEm2vrzp5Q4oUIXm
 46u5Fhln+2dPQoMci9pjcBOUKg9xZQRd6t8k7hybecbDSHKfxQXZrumyzgNl8sF7hz12
 vxJtaK8YlYfbNLtKMpNjXVjMOPok1bChD4SwDdeAAIDLhH9XeVemTYEbvUup3ehZGj2v
 LEO/hBT8zyHFMifpoRGAJX0wm/n4Nb4nCArEsG0INRwH643ReBLJnwoNX7A2XgwGzhxt
 96KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794414978; x=1795019778;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rii2pBwnuI2lntVcwEuArsZ4V6Lz/RZtRogeQ1tXXaw=;
 b=Od8u0HyAwSVrG3wikp8poQWHm9NoMHg5ulxYxf4EZGqgLWzlXfm4Xvy8itOnYJztOY
 3ZRvfG8dLVQ3PewTAfh1GB/7pITZmVhvC7ju7MKMG8i4/bqXSsb+zF3PHYND3YUOhEsL
 j5YeIcDlRWJT41OWUZJC0DRgsn4TQL6APYMRbuHJIzq3C+VVmEPFm5PQQxFQltGUj0Wd
 y8q1IAL5Q6443q9HfHbgncWreihVcFOR467xpkh6zMXzVPtXD5hC7pdPWuomyvIdsAm/
 U9LZmoEwrigS3yl0uLiy4jve48WdZ/qDiGltISVhtb/m6tXmnzzlVQZ+Q+Cwp1MCYMQC
 qgag==
X-Gm-Message-State: APuU4Z/nIJX+eymuTZ9ucvfcPnoh8081zGJBPtn5I/Y1mOqr9FauAVJF
 0d9z2yOxoF29WXCftYZZ/J/8OBdML3SpUFWKxxSVCJ8hHaPc2svoQRBmc6N2hu/Nffabqecb5GO
 XC8XHzlFAkcGkmnTD1pM7b5SNzXCrdvI=
X-Gm-Gg: AYBFou1cFIJbwj55fhMzMX9AU7qYGNVv/TdcrY1bBMcy7LyYpPWBYLOUoiLvvhYlAsC
 uJLkzDcuLzTEEIv9OyTzlMlmxjA5B+yDtApfOYy/R1BJVOVKiXO3cuAqMkK1gCrWzbKhIg2cKR+
 VTIp4rxxXmnF5zEK2Fpg0j13TQddvKzcgHIMYVCOGph6FW0rQqgcxGT8Fo5kU8aZ7+bgVBCqem1
 q8Q6HhN/VwG3Me30FV07Nt6Jn+ssOlIZoLxeWtnltdWj3UsR0PeTeIfuHbttKe7MYLNS0Gmae5E
 2RruWiGGxAXVusmoNpWWULp3k2z4wEZmWw7tWPMHsLEvin5JWqHZYFW2Ps8qkdGdD1QK8nfrcvG
 hwBge/V1Gl4z/tmJOu/H7VSh8Vyq18LwAsczetmkqG8RVsDblv1WYIIurVPoPPpcYCX4CqyL4bZ
 0z4XFmMeAE1r1zVBkzygr7rCFMFtiny+1p+h4a6mpAychyXx/CsqjY2Oe75b0=
X-Received: by 2002:a05:701b:42c7:20b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b3c0151554mr4497497c88.0.1794414977726; Wed, 11 Nov 2026
 08:36:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106005319.17428-1-w.woj@thundermail.com>
In-Reply-To: <20261106005319.17428-1-w.woj@thundermail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 11:36:04 -0500
X-Gm-Features: AclHuK9r7dntpX32eQ_EvIQm-E8gDHgffx9Dqi7fjFQKcxAg7b12edfEvogzdss
Message-ID: <CADnq5_MU=CgRSw6XX2FTNrwudatBWVCXOdWAbo04QR_aFgUyuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable fence interrupts before KFD init
To: William WOJCIECHOWSKI <w.woj@thundermail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Fri, Nov 6, 2026 at 4:36=E2=80=AFAM William WOJCIECHOWSKI
<w.woj@thundermail.com> wrote:
>
> On Navi 1x, GART TLB flushes go through SDMA once the buffer funcs are
> enabled, and amdgpu_gmc_flush_gpu_tlb() waits for the job to finish.
> KFD init does two GART allocations, so it waits twice, but the fence
> interrupts are only enabled after amdgpu_device_ip_init() returns. Both
> waits end on the fallback timer:
>
>   amdgpu 0000:0c:00.0: Fence fallback timer expired on ring sdma0
>
> That's about 1 s lost on every boot.
>
> Enable the fence interrupts right after the buffer funcs, before KFD
> init, like amdgpu_device_ip_resume() already does.
>
> Signed-off-by: William WOJCIECHOWSKI <w.woj@thundermail.com>
> ---
>
> Notes:
>     Tested on an RX 5700 XT (Navi 10) with Debian's 7.2.12 and 7.2.15
>     kernels: both messages are gone and the probe is about 1 s faster.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4b0e282b2..ce979a1bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2545,6 +2545,11 @@ static int amdgpu_device_ip_init(struct amdgpu_dev=
ice *adev)
>         if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
>                 amdgpu_ttm_enable_buffer_funcs(adev);
>
> +       /* KFD init flushes the GART TLB through SDMA on Navi 1x and wait=
s
> +        * for it, so the fence interrupts must already be enabled.
> +        */
> +       amdgpu_fence_driver_hw_init(adev);
> +
>         /* Don't init kfd if whole hive need to be reset during init */
>         if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
>                 amdgpu_amdkfd_device_init(adev);
> @@ -4135,8 +4140,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 goto release_ras_con;
>         }
>
> -       amdgpu_fence_driver_hw_init(adev);
> -
>         dev_info(adev->dev,
>                 "SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n=
",
>                         adev->gfx.config.max_shader_engines,
> --
> 2.55.0
