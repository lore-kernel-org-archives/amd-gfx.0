Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85321C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6E610E9BC;
	Thu, 10 Apr 2025 13:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gu2gM8gX";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E1010E9BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 13:31:56 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22792ef6215so953055ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744291916; x=1744896716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQ359FHz+0CrQHBY+MOOnQbDtjAFDsovWhefDRLWpyQ=;
 b=gu2gM8gXMhNJJHxApjSqp4R/phve5C8Er97Xn1PEw/LFGSCUDhsb1m+/Yx+xqVdZGi
 OPdoRRhN4U2PjYt7T4fCJSNXYd47x5mKX/2+UTWRXA1IEjyqb+6OomU7QAzJ0m9JjUSr
 FgwzD6paxVMEYag5h6ZIe4bFXdcOKbLlf6gVE6fQbgbRSSAVmEf24c9O0FIuzstZylVS
 5pGtZ9/9KOg5VC1NnXFlN1FYO5t6DGP4xcSEcJEPdiTFyZY68UITcV1bcaWYgEgbz1kF
 c85fKqHdUCOB9uSKzMnCQWUEgOF31VBtnf9n9fltdF6tQGMN0IeuQv6C5kVwPHes9xFi
 7Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744291916; x=1744896716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQ359FHz+0CrQHBY+MOOnQbDtjAFDsovWhefDRLWpyQ=;
 b=Ye/YGqzS+DJ4tIzxaZkIH+d178xnxEV/Ht0EGV9GU3EkP4UZnyhCtR+1XACPrQQpg7
 p3lfioFBG8+icesrA+9i2N+7yLkb3IA1l/B0geWJwZ6ThmQqZpPfyBXt8Gm32gESlsKb
 UlygtWR4eh8VpiMOui0QTiTUkmCgGOGUJ9zt/CSd3uTH/EvYNX5SG1Gbp1ZH1kZgd2Gg
 LoIhH9G/eaApELphGiLXwUVMqaES15ZBh7Je5p6KnwXsdCmNd1OW2abXI3LO2fn4YVoh
 XS970FuDXH5Y1lJTpXNoKt6EQ+cnJ4O32uzHdaUs8Y3P7kmtvH3k2NOCi3dhu47KWjfA
 Yvlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe82Oce6V1jjt00BOiJjSrF+2XisobRtA6bJpVFPehlM+Ly2cwiJPlk8+gXprwo8kKAAE4tehv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAvvcK1IsQ8DG/spYe9EyAXgujeytr9KmFit2c4rRSH4JgQcXE
 ev3UxqNV7ohCpcOfh/YE7urAbrGbKCZX4xKgUhl4QRdlvlAkiq+EcJnJ2WkIDt7kmQT6RfqbGOK
 MetM3ef7xzE15VhdT1mw50cSiQmY=
X-Gm-Gg: ASbGncutyeiUu4OS2pJStb7t4Lp8hWCjS4JSVeuKMfY2vV2n+22CuV52iSjsH7fkbdj
 mC8Dq8SacK1ZyXhAht37lWn4c972Vgoe+IOO23EU70P9IoWkMMDWaSX8+RCI5zPnrKWaLehCNt5
 ER9ulCRpKYzvADF0qzZd/n64CgWzQmgRQ5
X-Google-Smtp-Source: AGHT+IF8k78obe709guebjRWiWgzCTvSrEn5Auu8l6JcD0XKKFE+ZA9Pcm9I+NK5aGcITcjTqg9wOQfWnH8yqtEjmXA=
X-Received: by 2002:a17:902:f70f:b0:21f:519:6bc6 with SMTP id
 d9443c01a7336-22ac2a20fc5mr39959805ad.9.1744291915617; Thu, 10 Apr 2025
 06:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250410112917.13725-1-Arvind.Yadav@amd.com>
 <20250410112917.13725-2-Arvind.Yadav@amd.com>
In-Reply-To: <20250410112917.13725-2-Arvind.Yadav@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Apr 2025 09:31:43 -0400
X-Gm-Features: ATxdqUFTHqaXlWPwZEg8UfexPu5xH-KeDdp0J_qTMjy_w1cAnfFzA3eOfF649_0
Message-ID: <CADnq5_MGxCYfWBQspJTeUkmNj0X=jtneh1jz6AJZNDAB03Dh5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add fw minimum version check for usermode
 queue
To: Arvind Yadav <Arvind.Yadav@amd.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com, 
 shashank.sharma@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Apr 10, 2025 at 7:48=E2=80=AFAM Arvind Yadav <Arvind.Yadav@amd.com>=
 wrote:
>
> This patch is load usermode queue based on FW support for gfx12.
> CP Ucode FW Vesion: [PFP =3D 2840, ME =3D 2780, MEC =3D 2600, MES =3D 123=
]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 3d87e445270e..c31c96fc13f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -69,6 +69,10 @@
>  #define regCP_HQD_PERSISTENT_STATE_DEFAULT                              =
          0x0be05501
>  #define regCP_HQD_IB_CONTROL_DEFAULT                                    =
          0x00300000
>
> +#define GFX12_ME_FW_MIN_VERSION                                         =
               0x00000adc
> +#define GFX12_PFP_FW_MIN_VERSION                                        =
       0x00000b18
> +#define GFX12_MEC_FW_MIN_VERSION                                        =
       0x00000bea
> +#define GFX12_MES_FW_MIN_VERSION                                        =
       0x0000007b
>
>  MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
> @@ -1383,6 +1387,15 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_=
device *adev)
>         }
>  }
>
> +static bool gfx_v12_0_is_userq_supported(struct amdgpu_device *adev)
> +{
> +       return (adev->gfx.me_fw_version >=3D GFX12_ME_FW_MIN_VERSION &&
> +               adev->gfx.pfp_fw_version >=3D GFX12_PFP_FW_MIN_VERSION &&
> +               adev->gfx.mec_fw_version >=3D GFX12_MEC_FW_MIN_VERSION &&
> +               adev->mes.fw_version[0] >=3D GFX12_MES_FW_MIN_VERSION);
> +}
> +
> +
>  static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         int i, j, k, r, ring_id =3D 0;
> @@ -1418,7 +1431,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         case IP_VERSION(12, 0, 1):
>  #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>                 /* add firmware version checks here */
> -               if (0) {
> +               if (gfx_v12_0_is_userq_supported(adev)) {

I would just check the firmware versions directly here rather than
adding a helper function.  The fw versions will be different for other
GFX11 chips.  Also no need to define macros for the versions for the
same reasons.  there will likely be different versions for each gfx11
IP version.

Alex

>                         adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
>                         adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
>                 }
> --
> 2.34.1
>
