Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83153C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 20:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033E8D4AB4;
	Mon, 15 Aug 2022 20:48:58 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1192CD4ABD;
 Mon, 15 Aug 2022 20:48:47 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 t11-20020a05683014cb00b0063734a2a786so6188736otq.11; 
 Mon, 15 Aug 2022 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=Q7YZzg5zy6bNcVY2jRxF79+UC83JmaUvI/+TZ/8tdUU=;
 b=BtGr6YAH+McAQv+oqie8OGaJM/LJeNoC0wnHIAAgPPsUHCURZFFq4ZtHHEOZfCkTwy
 qrVKqv6R4OnltqFh0jVJjy15wouZSYVMICRCovcxHhYyZ7anlzhwvo4gWJA2rcIrrK0w
 X9xYYt1a09r5jeSYZ9ROa8b7Wllp33F8mIiKJtbOPczRNhc6G7zDxumyb197be+G/bn3
 6sAzHbY+bsBk33LutarZ4ewzKTvXvVt9HmAAHIHktC8xcxNMcJY2I2EYhW9pWVw94nIu
 DhAGh2EpI+JPmwJ51nZhaRay2+uMS+lyV91SoY76sNolfpgUlHLI0fQt/RqbQsYQJ4IF
 0cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=Q7YZzg5zy6bNcVY2jRxF79+UC83JmaUvI/+TZ/8tdUU=;
 b=1bR7QSQBQyZWYs0ycqB0yXFNgqTeRuuWGiPHKNeSj2HK8BuF8MckjBnaM48VxMH3Tx
 vLegyb9xAKn1ZYO8a2BjjVM90qcqvdZFQUmOaRXz8CflIrdD4KY9nT8JRVAoDnBM/XRy
 zKzfNGTzKyS+BWkSmVehpjeuUxCyjUsaHLeXqrRJCtmwpnFS+oJp/HFW4YvXeq+SuUoE
 1Kak231CzGnVAiMQ+Yogi5zafxhJ7p4i3vbiHo3X5O/BcdMgzWg/g90NraiXroAVWNDp
 4e5hJlToQfKVb6/MKl/JO8VOFsBCudX9r6z1wC5I132PBhTMZaqadVBYxy6mHk86JSd3
 0sZQ==
X-Gm-Message-State: ACgBeo14C3cf882uEW+0dKY/D15DLbL8+B4G9x1Ku1DUGbGje+LrK+PD
 gV31UKZ05XHV1Hvgja7O4uHYA38YCluPeOTza4A=
X-Google-Smtp-Source: AA6agR4AxpLwfS11OLIkrikL4YqYc2UykZk/chEQqqURGqAW/fKLVeujmnfvUO/aVUYqw02150ZzKLzbWVka5N/5oac=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr6666652otr.12.1660596526370; Mon, 15 Aug
 2022 13:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220815183425.14867-1-khalid.masum.92@gmail.com>
 <SJ1PR12MB6194F4ADBF5DEBB1AEEF1E5295689@SJ1PR12MB6194.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6194F4ADBF5DEBB1AEEF1E5295689@SJ1PR12MB6194.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Aug 2022 16:48:35 -0400
Message-ID: <CADnq5_NkQqLdQxeD_Za=0bsS-3BGTRPBs3iF0nnWxR2t2mJtfw@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdgpu/vcn: Return void from the
 stop_dbg_mode
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>
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
Cc: Wan Jiabing <wanjiabing@vivo.com>, Khalid Masum <khalid.masum.92@gmail.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Jiang,
 Sonny" <Sonny.Jiang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Aug 15, 2022 at 2:40 PM Dong, Ruijing <Ruijing.Dong@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> This patch is
>
> Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Khalid Masum <khalid.masum.92@gmail.com>
> Sent: Monday, August 15, 2022 2:34 PM
> To: Dong, Ruijing <Ruijing.Dong@amd.com>; amd-gfx@lists.freedesktop.org; =
dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <ai=
rlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Zhu, James <James.Zhu@amd=
.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Wan =
Jiabing <wanjiabing@vivo.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg>; Khalid Masum <khalid.masum.92@gmail.com>
> Subject: [PATCH linux-next] drm/amdgpu/vcn: Return void from the stop_dbg=
_mode
>
> There is no point in returning an int here. It only returns 0 which the c=
aller never uses. Therefore return void and remove the unnecessary assignme=
nt.
>
> Addresses-Coverity: 1504988 ("Unused value")
> Fixes: 8da1170a16e4 ("drm/amdgpu: add VCN4 ip block support")
> Suggested-by: Ruijing Dong <ruijing.dong@amd.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
> Past discussions:
> - V1 Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flore.kernel.org%2Flkml%2F20220815070056.10816-1-khalid.masum.92%40gma=
il.com%2F&amp;data=3D05%7C01%7Cruijing.dong%40amd.com%7C017222a9e81f49ea336=
f08da7eecd6c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6379618529504644=
12%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DTyXtoF2flWNqabtiJ%2BDVcR2vds=
nLZ19qr3b%2BQT2DBQA%3D&amp;reserved=3D0
>
> Changes since V1:
> - Make stop_dbg_mode return void
> - Update commit description
>
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index ca14c3ef742e..fb2d74f30448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1115,7 +1115,7 @@ static int vcn_v4_0_start(struct amdgpu_device *ade=
v)
>   *
>   * Stop VCN block with dpg mode
>   */
> -static int vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_i=
dx)
> +static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int
> +inst_idx)
>  {
>         uint32_t tmp;
>
> @@ -1133,7 +1133,6 @@ static int vcn_v4_0_stop_dpg_mode(struct amdgpu_dev=
ice *adev, int inst_idx)
>         /* disable dynamic power gating mode */
>         WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
>                 ~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
> -       return 0;
>  }
>
>  /**
> @@ -1154,7 +1153,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev=
)
>                 fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
>
>                 if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       r =3D vcn_v4_0_stop_dpg_mode(adev, i);
> +                       vcn_v4_0_stop_dpg_mode(adev, i);
>                         continue;
>                 }
>
> --
> 2.37.1
>
