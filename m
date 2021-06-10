Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB01C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD5F6100A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD5F6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC916EDEB;
	Thu, 10 Jun 2021 21:06:18 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E819E6EDEB
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:06:17 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id h9so3597789oih.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c+rbEd82nkWjSUOXRzg7xcGkpR4rtzc15HqOrxnwEmI=;
 b=r9zs+6Q+Sd+CQ8xZyMbpBXRNInotZ8aEZRmZ+Z5trTIq+Hg8vmFwJEDVVmo0Grcjjg
 OCxI3GCRjgz9uvRbH0WYr7WDsv5w6AE7bHa8ZU1g4zkAIP0pecI727m5PGLRIxHkLDL+
 V0rqW/Vd0eReo8YXsTyrh/DLdgiyXiQkehVk/5FrnB4IBpqYXyz+b9eCAj3P1uQHUdNY
 AtlZ7DqW+uVCa/il7uki2m0QOw8mIXHBleekQXnKBr+MaD2q68erh5oflpW7n6Xz+h6a
 n9+GJiKVt2I6em2FjMkTPZtpN07DVpde+MoC3T2Xzg8eVniUEvBK3kl3lFyfTkystufD
 aYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c+rbEd82nkWjSUOXRzg7xcGkpR4rtzc15HqOrxnwEmI=;
 b=liDG9abirNf5gi6qCg84nUbtPH4u9aE9CP6GY2LD/TlovQNHdsPqflDTXXsKLL506f
 1+rdACYnlGSWmb+B4hkwGOvklrELA5uNzc1zQlqhmDegFnCJblErxfUREYq+hOp5GWIW
 hF9Zm+r5MiecQp9pw5PWRlG30uehDXn59UjPaqxkg1UBZMczwbUlIgnINID8p+qsRpt8
 WtezXU7MkddX+rl+yigbFh+1Qmry4lyy+DwUEj7Vvvp092ACpg24sezW6Gybbz274ZEL
 RcBUWtwfxwip1z+b7W3tsqI40o9vs/PKxYS89HReBQnQFsD1ABDODvBh47hO/hcg7E5I
 xOgQ==
X-Gm-Message-State: AOAM533rZhfYcCPpTIAv5ZO/tUQpd3Kptvt6xSKBvmMOMNnxeQBipmvj
 dIPEEFvqmtc7i5mKjhFdfG2hiB42eTGTwqOs9kjR9Om+UTs=
X-Google-Smtp-Source: ABdhPJzKHkK6fFrv32/QNYeFewYyKeVH55QhlrjErKEYqW/+y9TlUaZmFIPgPBI5NFcwlfl3q0HBPxNxJ4HbmYO9uWY=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr10843916oic.5.1623359177395; 
 Thu, 10 Jun 2021 14:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-29-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-29-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:06:06 -0400
Message-ID: <CADnq5_MfcOfgD6FaTuL_wAXmFU3zipTEE-tz7a1iA_ju=JN5qw@mail.gmail.com>
Subject: Re: [PATCH 28/40] drm/amdgpu: EEPROM: add explicit read and write
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Add explicit amdgpu_eeprom_read() and
> amdgpu_eeprom_write() for clarity.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h     | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c |  5 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
>  3 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
> index 417472be2712e6..966b434f0de2b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
> @@ -29,4 +29,20 @@
>  int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>                        u8 *eeprom_buf, u16 bytes, bool read);
>
> +static inline int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
> +                                    u32 eeprom_addr, u8 *eeprom_buf,
> +                                    u16 bytes)
> +{
> +       return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
> +                                 true);
> +}
> +
> +static inline int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
> +                                     u32 eeprom_addr, u8 *eeprom_buf,
> +                                     u16 bytes)
> +{
> +       return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
> +                                 false);
> +}
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 69b9559f840ac3..7709caeb233d67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -66,7 +66,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
>  {
>         int ret, size;
>
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr, buff, 1, true);
> +       ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr, buff, 1);
>         if (ret < 1) {
>                 DRM_WARN("FRU: Failed to get size field");
>                 return ret;
> @@ -77,8 +77,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
>          */
>         size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
>
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr + 1, buff, size,
> -                                true);
> +       ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr + 1, buff, size);
>         if (ret < 1) {
>                 DRM_WARN("FRU: Failed to get data field");
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 550a31953d2da1..17cea35275e46c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -151,9 +151,9 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>
>         /* i2c may be unstable in gpu reset */
>         down_read(&adev->reset_sem);
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
> -                                control->i2c_address + RAS_HDR_START,
> -                                buff, RAS_TABLE_HEADER_SIZE, false);
> +       ret = amdgpu_eeprom_write(&adev->pm.smu_i2c,
> +                                 control->i2c_address + RAS_HDR_START,
> +                                 buff, RAS_TABLE_HEADER_SIZE);
>         up_read(&adev->reset_sem);
>
>         if (ret < 1)
> @@ -298,9 +298,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>         mutex_init(&control->tbl_mutex);
>
>         /* Read/Create table header from EEPROM address 0 */
> -       ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
> +       ret = amdgpu_eeprom_read(&adev->pm.smu_i2c,
>                                  control->i2c_address + RAS_HDR_START,
> -                                buff, RAS_TABLE_HEADER_SIZE, true);
> +                                buff, RAS_TABLE_HEADER_SIZE);
>         if (ret < 1) {
>                 DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
>                 return ret;
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
