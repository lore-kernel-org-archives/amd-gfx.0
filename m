Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3548ED778AF
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 20:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98FD10E2ED;
	Fri, 23 Jan 2026 20:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpDk2XZF";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB37D10E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 20:44:24 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12336c0ae91so309456c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:44:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769201064; cv=none;
 d=google.com; s=arc-20240605;
 b=VUa6qZWYoUJuhXKIvlaIkT8oqCGZB6NZRI0U6eqyU/ZlLZdSZoQU/teDgeSaOPDU3f
 E2hYjlMdRPZyFPeAcZhq7Cxp0o146g2ev3VEwDAufE0pnIKohynkEoY7brUC7Bu+xtX5
 iWpItc8tMWzwppZxgSfLwmmTYdEKnhHPl0Dk2AzSJAuIk0WoQ884PyoCAtOJD0tnqeHk
 16z1K3ckM2RE/kqujK4YlJ6CYzXQN4tGFwhC8iOG5XTxWWNed8c1sMmxzvN9zYPbhX0V
 SK3ZW6l8x24Aj4gYXSOsLXI1fbw67STA/yGgHufJWQzoT0mRwYEYBzkiVzjznickaYwC
 enjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yYARyAaT/Nj37zYumvgBDS3dcRD4fuyoQX4+W6itDF0=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=iBOAPiFioY7nOCjkgMq3CPYrla9HlYFL45Wa1hwN8LicQosN4mKiSMpXkQN0isxAO9
 0Atbdma4K46uilrVpCGPkEV8ZfwfaZObqnocR3BrM32L0BumNPnniXG1zKhzKtjACEEw
 MDuPkZdP4AU5ms0646QADE+fzH3tisPjF5Q9PcYPxiOf4Lrz6eBMYh91uPLpQePqtzVk
 /T3vW4qaMIlB3WXJ7nTUp7Wsc1YtTwlCs5M6LCJaxF5gYYPkycslI1S/LdVf4Fh2PD6M
 KXkoBzk6GGCTWAnqXNTw7w0c0DRAv3iuz8OTM791n4KLvn+PzjhlHGyV6MkmZ+uS2lWP
 CfBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769201064; x=1769805864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYARyAaT/Nj37zYumvgBDS3dcRD4fuyoQX4+W6itDF0=;
 b=dpDk2XZFkw9jX3bl/rsUnYVnFQLplMrJwpetmwdVRtE78UTJE4VYnnHGADrRDL1Q6m
 rXXkX7O2W7cKll9i+PoJe9HpzSpMVQ5Ge8UZOT0TtD4zDdII6/Jw2+34MMDnBSAs/+9m
 Rjlc5HsR6mrCoEARHydUcuagFbTr4CDgZzPTTT2DZDvkY7stN8/yQkJX4QZood33yhW/
 ocZKNoxNKVKmUOFbum4VFPFYcmugc1SbZTjHs+6p2VWkbbrq5Q/2pqmtxgtbBafznSkH
 9xacbrHpRXL/cBbJfeHADYBJKqNZc71WbP6AiwaEm/7z5Be2JNGTmhaJ4WsyUvQrR94T
 80aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769201064; x=1769805864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yYARyAaT/Nj37zYumvgBDS3dcRD4fuyoQX4+W6itDF0=;
 b=sjgmzZyHGeicSrscgOwC0g9SuiTyJeliaghNPmNh0gnQ5KkbGa0lUqwBFAjBXg+4qE
 oRA32JBpQ6h2Dwwaa3DjKb/C24U32zdPIb+m3oyCHt3+j6SjJK5KUsvyoacYJgoCUPRY
 wSWmJFAeq9/cIi6W1vLNZybjhRRIi0sh0t0L6+8jg5YIEurEolhTMYOW3dP9HSRKSDhv
 bF2oBZfjaId1lktSrMlKQxHbXvlw/r3LFf+9fAWoRaUiS7BR3TQ9VlQZDqVjH2FbuT6L
 q1P5bWtsgu0OQ9pbAS46/QIaGhbS+DXHYBtWUIA6Vuqqoeoas1LoA9Ho8s9AstnJ8U5i
 9l/Q==
X-Gm-Message-State: AOJu0YyuPYZJkn1S4KaQrmuhveFNv7ZFeHEVxcrYxiLrBkZn//kZeN2C
 HqouTnVI6gH1K4+PaO0LFOGjWSCszumgTSf+BIETUuSBBDChME4wPST0ZWSETbyl3ptEp/inUxP
 romBCkGAzJ9cJdoFeQJs+lQGUsHJ4DJM=
X-Gm-Gg: AZuq6aLL7052ZeiHaavkEWAut1gYSBE68E4a6tEM8uEtuMBBPujfvirZi1kgdBHeRKh
 cO8un0SyMXlJfs5f+KKX9PtwkYcwmEGOl1MbSVFNd3XqKD3aLDyLWmaYZxe10eWloessPtsOGgc
 01/TAgQTefWeLacdRWTT4iTxajrwZ4Cdux5gdrD9UV+HZiVBZjBEr1H+w/5kzUXR/hj71tIrEBz
 WIo07hbuJJs3cjakefQS7ZPfavmCLu8mYt5u+TGl0cOYfM/xf0v+87GwB2dh4CxiXkXFk3R
X-Received: by 2002:a05:7022:2529:b0:123:34e8:aea0 with SMTP id
 a92af1059eb24-1247dbb1084mr1097540c88.1.1769201063573; Fri, 23 Jan 2026
 12:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-5-lijo.lazar@amd.com>
In-Reply-To: <20260122104118.1682154-5-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 15:44:11 -0500
X-Gm-Features: AZwV_Qj0beb3bruJvxAr26__xsccKHu7G324NDgcyo5xevmi_iDrIRo1eXSsyas
Message-ID: <CADnq5_N4SwVA_RXjPqQVV2ERsnOjCzGKXGfS-2xaHShNxee8=A@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] drm/amdgpu: Add user save area params validation
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Thu, Jan 22, 2026 at 5:52=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add an interface to validate user provided save area parameters. Address
> validation is not done and expected to be done outside.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 44 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 11 ++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> index 80020fd33ce6..32d9398cd1d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -64,6 +64,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amd=
gpu_device *adev)
>         return true;
>  }
>
> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc=
)
> +{
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return 0;
> +
> +       return num_xcc *
> +              (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_m=
em_sz);

These could overflow if userspace passes in especially large values.

Alex

> +}
> +
>  static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
>                                          struct amdgpu_cwsr_info *cwsr_in=
fo)
>  {
> @@ -425,6 +434,41 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>         return r;
>  }
>
> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_cwsr_params *cwsr_params,
> +                               int num_xcc)
> +{
> +       struct amdgpu_cwsr_info *cwsr_info =3D adev->cwsr_info;
> +
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return -EOPNOTSUPP;
> +
> +       if (!cwsr_params)
> +               return -EINVAL;
> +
> +       /*
> +        * Only control stack and save area size details checked. Address=
 validation needs to be
> +        * carried out separately.
> +        */
> +       if (cwsr_params->ctl_stack_sz !=3D
> +           (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
> +               dev_dbg(adev->dev,
> +                       "queue ctl stack size 0x%x not equal to node ctl =
stack size 0x%x\n",
> +                       cwsr_params->ctl_stack_sz,
> +                       num_xcc * cwsr_info->xcc_ctl_stack_sz);
> +               return -EINVAL;
> +       }
> +
> +       if (cwsr_params->cwsr_sz < (cwsr_info->xcc_cwsr_sz * num_xcc)) {
> +               dev_dbg(adev->dev,
> +                       "queue cwsr size 0x%x not equal to node cwsr size=
 0x%x\n",
> +                       cwsr_params->cwsr_sz, num_xcc * cwsr_info->xcc_cw=
sr_sz);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                       struct amdgpu_cwsr_trap_obj **trap_obj)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.h
> index 3c80d057bbed..96b03a8ed99b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
>         uint32_t xcc_cwsr_sz;
>  };
>
> +struct amdgpu_cwsr_params {
> +       uint64_t ctx_save_area_address;
> +       /* cwsr size info */
> +       uint32_t ctl_stack_sz;
> +       uint32_t cwsr_sz;
> +};
> +
>  int amdgpu_cwsr_init(struct amdgpu_device *adev);
>  void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>
> @@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu=
_device *adev)
>         return adev->cwsr_info !=3D NULL;
>  }
>
> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc=
);
> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_cwsr_params *cwsr_params,
> +                               int num_xcc);
>  #endif
> --
> 2.49.0
>
