Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E87606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O3JUG9d4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858301122F4;
	Thu, 29 Oct 2026 13:38:21 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB801122F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:38:07 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36a1c464349so313244eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 06:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793281086; cv=none;
 d=google.com; s=arc-20260327;
 b=TWVeIF4q0ElhpAnJDYX8VCQbRrUpblM/gSMuTAwfywdND+vEqmkTA5nsUEv8S5rri7
 zphAlRDVSU3J11NTVRlturRhl6TxHdTacOF5L6Eon8mBewRMiu+RJ4JLTwU04oqfj/sz
 5kGBFgVzi8kPb8dUlbFY+RYnM+xu9h1RqoUlNYx8CQ2CCoWgCfLpoIT1N/idN6ZzeEZG
 qEn/FjccjK4figWGjVQz8iPphl3oG0JtQGEXNiD8X3MwNMmdZpat9ErXGi7hxHLT3JtO
 0JAL/sKKhtEGQQoJi0ijRwQeL7r5JhJpPsI7bRfcy3j4meLJmt1jT5wQ5frGi9n4YmPO
 mc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GM1QRv9oK4a0y01f7JTCuJ8o7j0NGCBDrrWET3fOH5E=;
 fh=O3SVxhtq4B/tA5mcBaap42hJtOSXgcztKMGfeYgQ0is=;
 b=EqB6/lHhlrQ/+36HzY+LE67tvpFp7+1J5rsLcJksmCKzg5zubKRSGxk1AfVZQuWE9P
 oyMl7tcZaeTZRfBpX6fdYv+Ado6E8yNLG6ylerEWpGVDXV5xRWt4aurGSF+gD2wZtwXe
 DP9me+afGljIwY2GDtD713rdlT8OYwTFvsfWKWkANIJ8cyZX9pLxjgj2lt0q21ujs1mo
 RqvvOxIBC8hz+et7+3IJuB5NDvlp6HBMVixYCQBXkLKgAbqwLC+TAk4o4QGs35j/QyYH
 ZFhPAWA0DdhA3LKAyjVVTjGzLBPLCCXo9f13ATRRqVxQnS13idHT3zBMIhsTpUEQCexS
 NiQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281086; x=1793885886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GM1QRv9oK4a0y01f7JTCuJ8o7j0NGCBDrrWET3fOH5E=;
 b=O3JUG9d4r+LUwkKFbYlQKzq10jqtpCUIfYXd6HODFwEA3QVqcr8cRi+qq94U9xzWXQ
 grU3fcebfynOgbj9e8FGgmoXHzJ6Ufw8fIonc1CElNu1mFKDALVayx+vWiFjfra8wuY3
 /MuDuzVFDGlBj1iJtGQlKmPSq6w3NB//jP1YzyDC4J2x4s+3cszPogT0ghDHTCNQa4k9
 uO5Zvd3M8e2xLV39BNM3umYFYUF3fN4P1xfy67pHxD7VJtOfGBLdU023oNCYQuvRDl2w
 8tUf3zr0j4EB0ksM7rVbSYFFpmCLd71MEheLzD3fWvZV/oTF5sSdJ/ObH50z/jBpSClW
 43TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281086; x=1793885886;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GM1QRv9oK4a0y01f7JTCuJ8o7j0NGCBDrrWET3fOH5E=;
 b=Hp+uXmKstZt0M80XAZc54HXeXQzVQ/mX2YwlDvhQFCiLyEkyOTK1j3QcMsuLhnOUPa
 6I29CN5+foIMtCq7NS6qGAeYdvRBjNeY3rzAGBDeiT0BPQl5sdlmlUWMywtm8nx+vAeh
 ykVt/3+hIGUixEwknH/biPIkZMcwJpXvK+whhGz2vsbfuP0UzLJPiDimmVOleiujaPKf
 ENIFLVJmDA1wJnK0+YyFQcUaoNoGRw2LtqJr8gS7s3ekw5CUbUxYArzPB57Q3HlzpGNh
 Yt7h6zQ6+3SKkHpzk17Ze7iCcje+uWJOiyYrOvD7ZWdtzTqHaQOokPYnqPv4k6YPi2Tz
 uSWA==
X-Gm-Message-State: AFq9FYLud2HwLSLfi+xHkeAEd1v0iEDidDwBwLMkfkNrgKm9Cb44gZ7f
 EbONbLu1Zpj/htHu/JbF14lyKYmhWNcelXMlV6KD3qxmi2MMu42DCmrQykdX21lrbh5KjERb6Te
 ojFKvWxKc65anflpCuDhaL1QKxNuR/ps=
X-Gm-Gg: AYBFou1oXVoMXTEjnI90jz+YeyCdEYlPMiBaATcf3T2T3ImWY/TnJG8wT5jRYhRcL+P
 CHZEDxf9Fmgzpq3KN0U3gGNr8M6lH+3AqLXruCnJyqRslF82s2Ddyzow5diH/L8QXSdZF22+7vh
 ya+9/St8jU07Q4orJBXCVZgTSF2YB2RI1G5T1dCFILgccGfWBvyxnqLHs2o3dQ6b+q1t3wy3YgU
 ORE9WID+09Zi2+xtdmX+DjfYljgeKHZ+PJWbK1e3vI5eSUJYyA9kJQ9CfN6eCpfo9q2c3g+Y3hq
 bpLbz48sWJMXxq/a1kGwpUgvG+20K5SFNV+9nuQ8Ln+N9UdQZgiMLYHpjW1mTdiuxOIvwDZn1en
 Ruqhp8lO/axVIz+gtlzxwBsLtlsJa2xsGmBv1o2qVqqTWepkaUR4BidTR/epv2VJi1LeZAK3635
 FlyMoGfFwxavqMy1Uv+g6TDng=
X-Received: by 2002:a05:701b:4213:20b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1a6cb1102c7mr11272713c88.1.1793281086275; Thu, 29 Oct 2026
 06:38:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029070403.22012-1-Jesse.Zhang@amd.com>
 <20261029070403.22012-2-Jesse.Zhang@amd.com>
In-Reply-To: <20261029070403.22012-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 09:37:53 -0400
X-Gm-Features: AclHuK-WVzXThYSV1LYR5mfrlaZ1ZQPd1Zd4zafPmMjxrxtIM2AEKCS-gDYqYVs
Message-ID: <CADnq5_Pdidewau8PYGMpvWdkuq9612VOpOgJ46GbXJ4h=pYdVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/gfx12: disallow GFXOFF while updating the
 SPM VMID
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 4:21=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> gfx_v12_0_update_spm_vmid() does a read-modify-write of RLC_SPM_MC_CNTL
> over MMIO without keeping GFX powered, unlike gfx11. When GFX is in
> GFXOFF at that point the update doesn't stick, and with the SPM VMID
> programmed on submission again, the job of a process with a reserved
> VMID can still run with the SPM writing through VMID 0.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Additionally, since the default value for this register is 0 and we
only change the vmid, we could simplify these functions and just write
the value with the updated vmid and avoid the RMW.

Alex

>
> On navi48, after a few other submissions and a VM fault on the same VM,
> a COPY_DATA of RLC_SPM_MC_CNTL from such a job reads 0 although the
> update was called for it:
>
>   $ run testcase: cs-secure-ib-compute,gem-mapping-info-high-va,reserved-=
vmid-spm-vmid
>   amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:7 pasid=
:185)
>   amdgpu 0000:03:00.0:   Faulty UTCL2 client ID: SDMA1 (0xe)
>   RLC_SPM_MC_CNTL in the job: 0x00000000
>
> With GFXOFF disallowed around the update it reads the reserved VMID 15.
>
> Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index d334fb805020..9bdd82cc202d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3963,6 +3963,7 @@ static void gfx_v12_0_update_spm_vmid(struct amdgpu=
_device *adev,
>  {
>         u32 reg, data;
>
> +       amdgpu_gfx_off_ctrl(adev, false);
>         reg =3D SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
>         if (amdgpu_sriov_is_pp_one_vf(adev))
>                 data =3D RREG32_NO_KIQ(reg);
> @@ -3976,6 +3977,7 @@ static void gfx_v12_0_update_spm_vmid(struct amdgpu=
_device *adev,
>                 WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
>         else
>                 WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static const struct amdgpu_rlc_funcs gfx_v12_0_rlc_funcs =3D {
> --
> 2.50.1
>
