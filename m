Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E108606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BfEDqD6c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD0C10E039;
	Fri, 20 Nov 2026 17:53:48 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B6F10E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 17:53:42 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-862ab66fbb5so126746a34.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795197222; cv=none;
 d=google.com; s=arc-20260327;
 b=R0Fo6iHvNID0RgqMAk0tQnptK12A1X2x1gVudLos65NVFR1ydiVRIxdbL0oGZoM69r
 w+9UHu7Wi8Pe+34ls9cSi3sYferPL0sou7ymIuQqAvLPXlxc2hnBcvLy5bj4tFM2FMlc
 o+86pdS5YzNA8fzhCCBYUaxXHF/P3GTmecB/q72ew4KGASyLWBvIWSuM5X/nYO1wdEKD
 EFFjkQXmW63zAfXr5vY9rMkuyxpp1G1q5fifhcRT67jYaBiwgiGzy8A9RX6qiYxRfEVw
 802O3Cx5JT09mXoNYk7nm+l5AHYjQ/pHSvb7VAZQ+TDx0DCGI2Uy8JS4UyuBgixLRsve
 /hYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xx/ZXri5n3jW0wndErfHqjyYQUeVDFg4PpLRe37LGb0=;
 fh=ErHMEBxDA+BhFEghEQYwZEDSO06aUV311ygiR6SOLAs=;
 b=DESX4+PxSm5SQ/YPcmTFgpjVWg0wdvw59a5g/cgZGAzHQtOih0pcf+qXC4J8lCifOl
 P17CX2TzLa+3Bpz9H2jPUZkXN543Od8H1x0F5J0x9Pthoghn5jMEBOoQq1WZAhGmsxV3
 /XMRvWahlfsiXqYuTg3RTDDYXT+pAkLbS62UQESWa2Tum2cNeGL3Q14vlmGhbYsi9o9e
 ZUkSi6fQE8b414UByGd11vvLvp0xCGn+nIotwjDMhcsQVT4lQc+mVwb4TkEbtBjblFDz
 M3a2xCE9EJqb6BeJuZu87QpHYyrfphTxjSLbaU9IwaeMPkS7alggV2lghmA5ZS40pzTs
 KsBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795197222; x=1795802022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xx/ZXri5n3jW0wndErfHqjyYQUeVDFg4PpLRe37LGb0=;
 b=BfEDqD6c5evC0EdnHHb6bWp5qDKeINe/mgdamE7gsZBnuV7CK/zkCOWnfMyDwvjVLc
 dzvgRbLYm8AiWL8dFheM/FlfVIH6LUj13EcCHwLSUBla5y+v1T2IZ1Bh5tewODndY1vP
 r9kV4WmMIPAgEKzVqWf6+4oVRxAACNpp5sF/wyYWHFIS5yUw8iKDChBzjruWY7RwHXvk
 OV4pac3FyzRj2DQSw/pRUeqn46AY9V6GuzSoWPr1tUSKMVvslRlYCQb2z3RXfFAy1k75
 KYh+KQcUE718CXGFrOGpuFm940l6WwAH46/qNu58rf+Vf42AuzDXvOQlQUxbwE9NLIWg
 hDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795197222; x=1795802022;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xx/ZXri5n3jW0wndErfHqjyYQUeVDFg4PpLRe37LGb0=;
 b=zHywBGnKjpqwmFVXb8/rH4aj3wtKWROHds15jsqXoCXbMSgRvWo8+cD+oXQkbotLOP
 D92s5HNKvU9pmiS6PJRdHuAqovLqtXCmrIYQ6BqakLkKC7TnWJ4W4/ZN5uuj/5Oud052
 KKYu9fd1whrhVv8QZvayBBE90+heHYv9yBJ+OKGsGPOXwmlvXtlGs0TtpbQacf6HPaJ/
 Ahy+G7V9mFyWu8xBrUocPwx9PpXwubjI1y7oebdk1MEEJh2xaPAN5+tJcTbSbppnZhKM
 LpxhcZRJWsfPdj9Cq5OYjx7lgp1ONxv3/uSJwHnjSTYsizaBMTYiTfsClnZlBzm/Ehy7
 nSRQ==
X-Gm-Message-State: APuU4Z8TPFFrflXw6sv84njfGcBaS46qS5FVN4bDtFkp89yz2LPcz5A8
 W5jmFOzFuWlIgPIaHO+W/lv5IX5XmqisskYHlM7fX7VfHw8VKqH4W5llXpijH7fKvFsH3Gp7ES+
 Wn/qo7xkak/AuMSNrFGsQJYATQ223IsY=
X-Gm-Gg: AYBFou28ghw0CNhOldm/T6z9UNoxp9yf9ivdG8qkiZQRMeNecUXpWnp0UrZiL/8M6we
 iCzWK+ApNf1jNS2miTv20qMDPCVBtoadCJxW82zzbWyIqhQF+SNQ4H3Ze/noVFPitdcoIXfUkrq
 ccFNMesFqhrJUFYlK3S4+LfuEf2TpfyAqcr3/Svlnydbs8G58uhfBLJuutiux27Q02ebMYzwM23
 K9J3tsKA/zSRvQrra3BSpzCyPkQ1IePBi9JpLuXdc2oWC2F//bNPwh+FY0k31vmDwUqRJ9KRvEx
 6HhO4x2LDxbF1PDIh3IDu5H7W/XJL8bWaGjiaZ7I1AUGtYQRH6ARTWgc055yVOYB53FifICer29
 pVkQIXm1hXtkdqrXj2IrTH5wQLJstAtQ18G2YfmAZvVGXnycrQzKZ8O01UbT3IHjtiHSw1fxQZJ
 jqjinRDXw6zmAXgcTtckmxdmcLNslOqlpwdxpRlEo/wmc2no6WWA4aiqJ/v8Q=
X-Received: by 2002:a05:6808:151f:b0:571:a186:d6c8 with SMTP id
 5614622812f47-57a06506db4mr6780641b6e.1.1795197221624; Fri, 20 Nov 2026
 09:53:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120052932.24761-1-chih-wei.chien@amd.com>
In-Reply-To: <20261120052932.24761-1-chih-wei.chien@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Nov 2026 12:53:30 -0500
X-Gm-Features: Aa3M54pPklz3t92vZevp8z7okzE6VGKfK1vAKtbRx-17JXIHcI4J9naOW7GZECs
Message-ID: <CADnq5_MNYQsgpvovQahmhrFJyOOC1JX4a=cuk9B=3PS0WEHniw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vpe: align with reg read permission
To: Caden Chien <chih-wei.chien@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Frank.Min@amd.com, Tong.Liu01@amd.com, Solomon.Chiu@amd.com
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 12:36=E2=80=AFAM Caden Chien <chih-wei.chien@amd.co=
m> wrote:
>
> As register VPEC_F32_CNTL could be unreadable, we hardcode the default
> value instead of reading it.
>
> Signed-off-by: Caden Chien <chih-wei.chien@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> ---
>  drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c | 4 +++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vpe_v2_0.c
> index c92c5fc59aeb..dd5efc121e4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> @@ -34,6 +34,7 @@ MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
>  MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>
>  #define VPE_THREAD1_UCODE_OFFSET       0x8000
> +#define regVPEC_F32_CNTL_DEFAULT       0x08084001
>
>  static uint32_t vpe_v2_0_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t=
 inst, uint32_t offset)
>  {
> @@ -80,7 +81,7 @@ static int vpe_v2_0_load_microcode(struct amdgpu_vpe *v=
pe)
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>
>                 f32_offset =3D vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNT=
L);
> -               f32_cntl =3D RREG32(f32_offset);
> +               f32_cntl =3D regVPEC_F32_CNTL_DEFAULT;
>                 f32_cntl =3D REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT,=
 0);
>                 f32_cntl =3D REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_R=
ESET, 0);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vpe_v3_0.c
> index 9077ae138d2a..ca3b27e76251 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
> @@ -34,6 +34,7 @@ MODULE_FIRMWARE("amdgpu/vpe_3_0_0.bin");
>  MODULE_FIRMWARE("amdgpu/vpe_3_0_1.bin");
>
>  #define VPE_THREAD1_UCODE_OFFSET       0x8000
> +#define regVPEC_F32_CNTL_DEFAULT       0x08084001
>
>  static uint32_t vpe_v3_0_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t=
 inst, uint32_t offset)
>  {
> @@ -80,7 +81,7 @@ static int vpe_v3_0_load_microcode(struct amdgpu_vpe *v=
pe)
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>
>                 f32_offset =3D vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNT=
L);
> -               f32_cntl =3D RREG32(f32_offset);
> +               f32_cntl =3D regVPEC_F32_CNTL_DEFAULT;
>                 f32_cntl =3D REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT,=
 0);
>                 f32_cntl =3D REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_R=
ESET, 0);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/=
amdgpu/vpe_v6_1.c
> index 45876883bbf3..c758f7385fac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
> @@ -61,6 +61,8 @@ MODULE_FIRMWARE("amdgpu/vpe_6_1_3.bin");
>  #define regVPEC_PUB_DUMMY2_6_1_1                                        =
        0x004c
>  #define regVPEC_PUB_DUMMY2_6_1_1_BASE_IDX                               =
        0
>
> +#define regVPEC_F32_CNTL_DEFAULT                                        =
        0x08084001
> +
>  static uint32_t vpe_v6_1_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t=
 inst, uint32_t offset)
>  {
>         uint32_t base;
> @@ -159,7 +161,7 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe =
*vpe)
>                 uint32_t f32_offset, f32_cntl;
>
>                 f32_offset =3D vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNT=
L);
> -               f32_cntl =3D RREG32(f32_offset);
> +               f32_cntl =3D regVPEC_F32_CNTL_DEFAULT;
>                 f32_cntl =3D REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT,=
 0);
>                 f32_cntl =3D REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_R=
ESET, 0);
>
> --
> 2.56.0
>
