Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56619C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 19:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2322C206F7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 19:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZy/EcES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2322C206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77276E84D;
	Wed, 10 Jun 2020 19:36:59 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 406C76E84D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 19:36:59 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id t18so3637629wru.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zK9Na9bM9IaNoE4p4nOpguw7r1p99iLUMMW//x2Gu0c=;
 b=CZy/EcESP55U+vnTvyKyaWf+KdsrMo8yLlgBFIkxyURkI1TsR9rV1cBCs3ZiqVPeXj
 JQ4RZGnTAGfD/GTCPDXSDGpb+tRVYkrs+AwvoDsoRofpdSQUvktj8njNHU70+WyRWZDi
 l0K1aP7ZndaJIQAJZef9uAVh7Colw73aeLO44VFOoFkkVjHCZyomrv9sQWvzIuCMGgVZ
 id6Eui98tIKj1MKFkSCEykQbSHgaYN8aOFFOLM2UT+zRwDtDriZU16bwSWPvHYem6IvH
 9C+55LU9UzzPdbnGKgU3lxqFJgwgU2PLW5+LPYeFCQvPNj37Lj6x8iUH961zabPXtCgX
 Jq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zK9Na9bM9IaNoE4p4nOpguw7r1p99iLUMMW//x2Gu0c=;
 b=FzKTyNUceiMpbUGxDyk+cigi/L0hpYFwIPpit4Tht3Yh6lo2K5cxia7ITpn5WjoHBR
 dJMeBbJ/YrjdXrbB37wub+kWO0MaauKwJT3dhEkAAGIuO2z9/+ekyA+Q+evYO5fDX4JS
 za6o8y4ZdAlfr1Q0mT+SnIdSHg2kztg7VOvrbsluVQoh74sPgyJbrRTw5udKkSLeXcI0
 fHckLIcAdnHr9QKL/uT7Fs6NkdoiOjkcrkiHZIYJicr313bSTuaMw9Jfre1t/0TbmQxX
 mUDeT7ZYvdqBEzzUCYENy/Ef0dts0PKgUFHmtEL47Qfqg2N6XdBPfDZUbZ2v6KRIHNUn
 igcw==
X-Gm-Message-State: AOAM5304tl/U/iMYcRmAWuWBixpAmncmgATX4FKnoJv6vAQuXyw9tKv8
 Niad7BAIF+yEeRTJb4jYHKdpZHHDgncxabssWbs=
X-Google-Smtp-Source: ABdhPJzdnrAJ9XnOAge2SeI9sCnxMlkwX2bJfV3ZkxCAqaZKLwPyw3WK0bsN7RRXFvz+iWZMxi+6pa+KWG4bQr9peGs=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr5625751wrs.374.1591817817732; 
 Wed, 10 Jun 2020 12:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR12MB26194168100E5F96FF94D066E4820@DM6PR12MB2619.namprd12.prod.outlook.com>
 <20200610085653.GA5439@mwanda>
 <DM6PR12MB2619D7FBF176EEA50DB3E2AAE4830@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619D7FBF176EEA50DB3E2AAE4830@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Jun 2020 15:36:45 -0400
Message-ID: <CADnq5_MwY0Jme+K_Cdu2Gaq-P4DcHq-CzVP3BD1sE+F22z-a5w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix a buffer overflow handling the serial
 number
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ma,
 Le" <Le.Ma@amd.com>, "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 10, 2020 at 6:57 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>

Applied.  Thanks!

Alex


>
> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, June 10, 2020 4:57 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Quan, Evan <Evan.Quan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Ma, Le <Le.Ma@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Greathouse, Joseph <Joseph.Greathouse@amd.com>; amd-gfx@lists.freedesktop.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH v2] drm/amdgpu: Fix a buffer overflow handling the serial number
>
> The comments say that the serial number is a 16-digit HEX string so the
> buffer needs to be at least 17 characters to hold the NUL terminator.
>
> The other issue is that "size" returned from sprintf() is the number of
> characters before the NUL terminator so the memcpy() wasn't copying the
> terminator.  The serial number needs to be NUL terminated so that it
> doesn't lead to a read overflow in amdgpu_device_get_serial_number().
> Also it's just cleaner and faster to sprintf() directly to adev->serial[]
> instead of using a temporary buffer.
>
> Fixes: 81a16241114b ("drm/amdgpu: Add unique_id and serial_number for Arcturus v3")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Change adev->serial.  The original patch would have just moved the
> overflow until amdgpu_device_get_serial_number() is called.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 2 +-
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 135530286f34f..905cf0bac100c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -986,7 +986,7 @@ struct amdgpu_device {
>  /* Chip product information */
>  charproduct_number[16];
>  charproduct_name[32];
> -charserial[16];
> +charserial[20];
>
>  struct amdgpu_autodumpautodump;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index df7b408319f76..d58146a5fa21d 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2265,8 +2265,7 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
>  static void arcturus_get_unique_id(struct smu_context *smu)
>  {
>  struct amdgpu_device *adev = smu->adev;
> -uint32_t top32, bottom32, smu_version, size;
> -char sn[16];
> +uint32_t top32, bottom32, smu_version;
>  uint64_t id;
>
>  if (smu_get_smc_version(smu, NULL, &smu_version)) {
> @@ -2289,8 +2288,7 @@ static void arcturus_get_unique_id(struct smu_context *smu)
>  /* For Arcturus-and-later, unique_id == serial_number, so convert it to a
>   * 16-digit HEX string for convenience and backwards-compatibility
>   */
> -size = sprintf(sn, "%llx", id);
> -memcpy(adev->serial, &sn, size);
> +sprintf(adev->serial, "%llx", id);
>  }
>
>  static bool arcturus_is_baco_supported(struct smu_context *smu)
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
