Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A450606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ju+uSio2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC70010E35E;
	Thu, 26 Nov 2026 14:37:03 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0036D10E5EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 14:36:57 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-71adbc33515so297261eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 06:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795703817; cv=none;
 d=google.com; s=arc-20260327;
 b=L7RWjWikjK12Kup7HqFTxoY1+lOB4Q5XYmiGQou6m22CImx78Toq1kT0IkyRh0xDWC
 ZAGkfkZ+3B77jkFtI9+GkLwVl5GZaae8+yf671DSGD70hQ81ycG/LBJPiUL1cOwphpCS
 8FbIfHyaPtJRv3ndqji7doRbWAzpLDPjrQShcS2SYm6CxP1KngBFd1m0zMuo+xTkrSFU
 HliztXY3CKzK7+z5VCjcox7KlZUU6Um67bC4pj+bsiwmIgpdhDhuyRhvL//iNWulwtyf
 eOacmhs/lUiwRTNEgkdU8ePBPKiJNSNnG5LtHkfkO62QZOBWGWkR7HMCHx7RiaAfPM77
 WGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5dKR6SaAjvyBFga/l/qRzYFqdHZ2Fkzeez/7YeL59d4=;
 fh=UbzLsvi54im+l/s95vrr1GpHbdTqzi4YkBDOZKNktow=;
 b=KSKUjA7z/VFSJDwRwSfDH/N2zERkixCwVmnPR6s4qCNDss/qHBqOxJ4Us5UG1EiFzY
 e1zCVJ/TkgiZKxiVYOO0APb+lc3zPJAGTqgjk20rMbPj09voV3ycDrVGmG3thZGaD279
 +BIaCGekQRvoSUDdM1xz12NMIlN6J2rW6GN+P2819CeMtjo+yxAj+Egjt/eq4XU/5i63
 QtB5ntfqk/QGnD0YacIDOP2TZ7DOl/Uk4He8kHa8vjyCxNYfujvLJLd6vObZPGeTLqQT
 QeCXSe3x/BpBpyEr/0NhD1u6fcbIKbM5jfimV23eunTuN8carlZg4q9Dnn3XgmUm9LxO
 pCVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795703817; x=1796308617; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5dKR6SaAjvyBFga/l/qRzYFqdHZ2Fkzeez/7YeL59d4=;
 b=Ju+uSio2wlgjBflyOvn+OsE8+j2RSVy9RHFVkRW0hqpxxWXy4BTLpbYUHXN8pirp58
 dClhlrwzb0R0Hk14oGDpCMwC0e8x4mPnDRX2RfSvNqDdeJD9r5s9KimjqXkunwYDx1zC
 ur8FemvU44Uqv+0oN5g/MXA8JoE8Jk3hg1kb+uxZtY4CoTqLlmntKob0xtxYtjuxinq0
 zT+Z4hjAszVCak2AX2NHQk+AsFYZmWWbek/j3TM3GcVxf7A8hptdmkbqNQyQ0FACuhiz
 VYVKFu1gqHvZgb2P3InYmx0Zr2C3n/tXYbGv/bOu9dGt6tC2QFYCLGMcle5AsCly7tRW
 hNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703817; x=1796308617;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5dKR6SaAjvyBFga/l/qRzYFqdHZ2Fkzeez/7YeL59d4=;
 b=h9EJfBplw3SXHnEwkJCHf/bc26554mr/5wxZzAjmdzYcdDqVnS/YExhecGKTZX+M0+
 3opbCt4OxwTa+48lN+I1e/KW9r1a02rCXG9VRbm/4ioorMHuhihQyOPH4B7ENSCJgdw8
 RhVYFmusKNLuPlIdLfhuO2K2H9afk+ff/2y49auewVL06VjAAWPN3cdFFEx4M4oP+mRP
 5FJZx6kdoGFp3jO7lrESxDxW8ZNIFZ5HmeoNdIMyXv1IXob/AanwcXXEZfzIhv8h5aJu
 gmzoKQoS4A9Q/P+nXqkJ2rc/B2+fBRmid+X/ewCZpf/P2kGp5QB+Y4JWHukvQhUiV8zd
 xIgA==
X-Forwarded-Encrypted: i=1;
 AL+hErFXogb2fpieiYhMqpnPTBSJV2i8N26ac0QZKE16NZTwE/4sBeo7AgCRx1sez3bQxvSrIcCYX6fW@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/+T8bXTqhSQbbb5q3tJrE8ZxOyjDHYySTVa9V/uS/1o7m2vtPR
 xqIxuExmL2hyYTQopzcdiWZUOPlNW1gUfikuYRX6pz7NKNZhzX1+evftCNSIFowO01tKkcwCZFY
 SEdXw/OTfaDZKLlmZsgxyptce8isX/Ps=
X-Gm-Gg: AZFdTZcVtiZjcJnyUAhRjC9yH2auitZyQCrkUpaT5Ys01IXWRZphvsPvAcqTMiokFuC
 7gcTT4C1UKQYsfhhXIjQJJOGUlpzpP8l5nvmOSepGCd45e1WdWGfvrbZDsQR4E2Ixrw4OlY+v1E
 mrK7eoVLvdMCrDEL/IMku8PsksoVPMx7xbL2+eGi62LuhDqesnhQRbOinVk1o7YfAkBd0UDzB5p
 4fSD2Sq74YIanQx3AN9L6DxtSxzrofbL7juvBxakQm6BCszM425owfvOHArkx86rO/JgM8mT1qz
 3kGi3nkVxPt7deqoOmey74lSHnE9HR1PHsd96Tg9fu7nTNlmHggjwp8JMsBDySKforlX+aml9lJ
 rakXNRyFDvo/mmHq5RjcE2ZiwjGcjeXpySZ+mhnoXdXfIRmYFdHmGl1IhrnRghxJVYN8exwgEmU
 teVjVWW9exRn9xghdie+OvWnMw/UB3KvS1QKoSuCMhfoYHeHx0MvYwAVTJkPY=
X-Received: by 2002:a05:6820:840d:b0:71a:ee8a:5d26 with SMTP id
 006d021491bc7-71b3903669fmr19195255eaf.0.1795703817066; Thu, 26 Nov 2026
 06:36:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125161417.214372-1-abo@medichon.fr>
In-Reply-To: <20261125161417.214372-1-abo@medichon.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Nov 2026 09:36:44 -0500
X-Gm-Features: Aa3M54qanSdj8YZ53xFK7M30MaY5tEw79s5YfcO3LIsENd6mWry9QcyK5izEnXA
Message-ID: <CADnq5_NVGfSaMQDobTqaDdXJ5FsjdRfsRivh8MkAidecwjbVPg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix function parameter documentation warnings
To: Arnaud Bonnet <abo@medichon.fr>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Nov 26, 2026 at 3:46=E2=80=AFAM Arnaud Bonnet <abo@medichon.fr> wro=
te:
>
> Fixes several kernel doc warnings not deserving of their own patches.
>
> In file sdma_v4_4_2.c:
> Commit 0518c66cf841 ("drm/amdgpu/sdma: Fix executing duplicate commands
> after recovery on SDMA v4.4.2") removes the restore boolean parameter
> from sdma_v4_4_2_page_resume() without removing it from the
> documentation, leading to the following warning:
>
>         Warning: drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:758 Excess
>         function parameter 'restore' description in
>         'sdma_v4_4_2_page_resume'
>
> Remove the restore parameter from the parameter list.
>
> In files jpeg_v5_0_2.c and vcn_v5_0_2.c:
> Functions jpeg_v5_0_2_start_sriov and vcn_v5_0_2_start_sriov take the
> struct amdgpu_device but do not add it to the documentation block,
> leading to the following warnings:
>
>         Warning: drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c:433 function
>         parameter 'adev' not described in 'jpeg_v5_0_2_start_sriov'
>         Warning: drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c:724 function
>         parameter 'adev' not described in 'vcn_v5_0_2_start_sriov'
>
> Add the standard amdgpu_device pointer parameter description to both
> functions.
>
> Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 1 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_2.c
> index af1feba68dc3..a1a319a00b1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -429,6 +429,8 @@ static void jpeg_v5_0_2_init_jrbc(struct amdgpu_ring =
*ring)
>
>  /**
>   * jpeg_v5_0_2_start_sriov - start JPEG block under SRIOV env
> + *
> + * @adev: amdgpu_device pointer
>   */
>  static int jpeg_v5_0_2_start_sriov(struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index b99fbad2ea01..6135c6bf54ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -750,7 +750,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_devi=
ce *adev, unsigned int i)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
> - * @restore: boolean to say restore needed or not
>   *
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_2.c
> index 2f4aed8cd1ea..c8bb6ecd5bff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -719,6 +719,8 @@ static int vcn_v5_0_2_start_dpg_mode(struct amdgpu_vc=
n_inst *vinst,
>
>  /**
>   * vcn_v5_0_2_start_sriov - VCN start under SRIOV env
> + *
> + * @adev: amdgpu_device pointer
>   */
>
>  static int vcn_v5_0_2_start_sriov(struct amdgpu_device *adev)
> --
> 2.53.0
>
