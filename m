Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD72E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D936F10E1BC;
	Wed,  8 Jan 2025 16:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SjJRaM9+";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5C910E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:02:41 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-216325f516fso25658785ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2025 08:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736352101; x=1736956901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9vuNiKU6g75Q95oOCgX2ZmH9JRQ5OhIXPERll0ZQAA=;
 b=SjJRaM9+VCYm7wEpQLo4b7PyjrcciakjK0idDy6gU/Fm3Za5E8QtM+OtfY+rnYqq4e
 sRdJwBjdiovSvoQ6f4UVX9PYKOOiYeXB/GzXqKxrmpEeCJD0yvNL2/JT0rf1XY0vckdn
 OOWWvT0mfnSCv4AJJkWQdcKlW0rMZTeIiCPiBSnj+tnijp+CzbE3UlretwG1QcD1dv0V
 CUYJY03+UedoT/Ol3vSp9LIh1kO2vKaOIr/SRv3ZJMSa4VflQX1vP+VbPyWirCgkDov6
 kj/DYH1AJ/QvQMT7BX+6WkdgiiqSYDx4NS6y0rqJ5xmWoZof71pNqHPt2kJ7BW2wtpCw
 lJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736352101; x=1736956901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9vuNiKU6g75Q95oOCgX2ZmH9JRQ5OhIXPERll0ZQAA=;
 b=EOtE8j3M8/9lKkRxTyNoJ6MwQj8m3bCgBiE8xT4Y+F8HE61PBVuCIyZmPC+JU0i//o
 JqfaN1bJkf49sK+RFWOXr7o8VxoiRf94QIM7x9JngAvO3t6WJsRVnkCnP7D5EZkmgbJs
 Iv0Gm3eudCZlI6oXeDGqM635Zh/av45ckeYD5ySpxKGHzDjgBCP8rro0n1G+tRA/NPrO
 QIplAm92Y0EUAp+mOSfUMhJdI5HhxocNk/+0Gtak/xQzpuJ8kpmur/PCAzGGAKeKwP6B
 Q1l5XUfRUoiI8+EzNE7AdFqN1xCgvEUiRuzG1sEqmyno+a6m7ScREN3c+Lu07TBHMT9J
 RV+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBg9OJ6udGF6R4azlSaS+pDSB7InPs0E+8f3nymKmOnhN46bvE4gAd6cSAwbDHBm7odvHR9epW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgLPUdBpoKCHIwYR5MDHu4PXIeDUu760nANHu6E1OXIleJkue9
 lW21Gjsi7mUCtD7M6saZcS0T/aWvDQIzRzautl05l+apjo5BhRRlECsM9ufCvdX0eU4oWDgOdGY
 OaPwkx7KR6qK3+vKKxEAVguPcnHz13A==
X-Gm-Gg: ASbGnct9uEzZ33hCRTcNXP3+hOlzcciuGVYhFWxaVQgNX/q/2DaB40gugri+QMNWmXD
 G0CEEcOo1WEVGKJRAP+fNvcr6Dzy059nB+cRdoA==
X-Google-Smtp-Source: AGHT+IHDsGDN1lzIwb5GgV3NA9/LWsHIii7wBaRofVTAaqNYBj654BxiglYT6+RdyG4ujVhASQjoMWrJvTzFqzSCURc=
X-Received: by 2002:a17:90b:568b:b0:2ee:6d73:7ae6 with SMTP id
 98e67ed59e1d1-2f54911d990mr1693877a91.7.1736348556868; Wed, 08 Jan 2025
 07:02:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <8571f3280f13a562be5f845c274524560b4bee1d.1736344725.git.gerry@linux.alibaba.com>
In-Reply-To: <8571f3280f13a562be5f845c274524560b4bee1d.1736344725.git.gerry@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2025 10:02:25 -0500
X-Gm-Features: AbW1kva5bHXO0ZjRAeQqA5GpbLrQcIHWqWLtgMEMaCIZiOpMdCXq7lyV9fzYxyg
Message-ID: <CADnq5_OD3fYiJTEqf95s194L+4CyNkk2q+1x7ivZY4wuWKXuHA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/13] amdgpu: wrong array index to get ip block for
 PSP
To: Jiang Liu <gerry@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, 
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, Jun.Ma2@amd.com, 
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com, 
 amd-gfx@lists.freedesktop.org
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

Applied this one.  Thanks!

Alex

On Wed, Jan 8, 2025 at 9:00=E2=80=AFAM Jiang Liu <gerry@linux.alibaba.com> =
wrote:
>
> The adev->ip_blocks array is not indexed by AMD_IP_BLOCK_TYPE_xxx,
> instead we should call amdgpu_device_ip_get_ip_block() to get the
> corresponding IP block oject.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 0b1e280ee228..25c06c6c8a2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3830,10 +3830,12 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct d=
evice *dev,
>  {
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct amdgpu_ip_block *ip_block;
>         uint32_t fw_ver;
>         int ret;
>
> -       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initializ=
ed) {
> +       ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYP=
E_PSP);
> +       if (ip_block =3D=3D NULL || !ip_block->status.late_initialized) {
>                 dev_info(adev->dev, "PSP block is not ready yet\n.");
>                 return -EBUSY;
>         }
> @@ -3862,8 +3864,10 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct d=
evice *dev,
>         struct amdgpu_bo *fw_buf_bo =3D NULL;
>         uint64_t fw_pri_mc_addr;
>         void *fw_pri_cpu_addr;
> +       struct amdgpu_ip_block *ip_block;
>
> -       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initializ=
ed) {
> +       ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYP=
E_PSP);
> +       if (ip_block =3D=3D NULL || !ip_block->status.late_initialized) {
>                 dev_err(adev->dev, "PSP block is not ready yet.");
>                 return -EBUSY;
>         }
> --
> 2.43.5
>
