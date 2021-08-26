Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7450EC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 19:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368C860F4C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 19:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 368C860F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A5F6E8B0;
	Thu, 26 Aug 2021 19:56:26 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0D46E8AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 19:56:25 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 k12-20020a056830150c00b0051abe7f680bso5052638otp.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dvr8yPluZ2BaAkxsXAIWFWi/UnYY42/+hgOkjJtEAes=;
 b=Zbmur83591Yd4gKElQFMVkKaZMn+cotjNH+LvBMgyNe7oeabEWBhzo9vxBnLDnaWqG
 KuXoDVf/w7ZNLgK+QNGY4bR0WqG0Z58AL13CcaevcUWGUTgg/J5izPzZF/c4TKe9T6IU
 L6Gjv47d4waqc1Ar96phz2dvOCHtBC1rndK6fIKaKMnX9LmldFmei+flI5DboXgN8bOn
 2+wn9m1WRC5M5j1m3hXxd0dlY6mgWay2dy1E4EylvXZ+RITk2vwi+wx4n7G4zVSU0Jkq
 WhOoORuc/lcJgeSl5abOzrNNrfo/X9yjVXdSsdv6o5upgFC8L2Ct4IBrq+230Z7iyYiF
 jXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dvr8yPluZ2BaAkxsXAIWFWi/UnYY42/+hgOkjJtEAes=;
 b=IVd2qsjdRjZcYZXhEeTlhyb3P9IzhYvt6XqYvKprPVkz+YSU/ea8GTKDidQ3ZgG60J
 xsXk1jyMplDqzbQ20+wPAYM4OzB1uqKpjToj5gG8aZr77ghi3U+IySqpVUOasgQz9KJs
 8jYYd7RR2Xjp9wLMzKxOKl2Alnvs21GFNn7PGTyUc8nJP7o7sSDBJj+7uSYEigvKUKmx
 /32xAWR2MlDVDsNAQCyeodo3xRFejTukF+V3aDL5qGJm7A4AYg0y960vElCih8XxR02q
 zMMinUM8i3QYIcxi68UAXx1n6uGDrWMncJw0DuUN699hVuySgsP3zVlIZzjEyIqdqbFu
 gMVA==
X-Gm-Message-State: AOAM531K7v+sK8ldRrY8F3F777RFpQ8MzLBRmY7lqFy6ZdJ9tyLZio+F
 a7H80h1NSV8nJ6XsUqJ5UAlDzEybw1lFjq1xjtjbrCsk
X-Google-Smtp-Source: ABdhPJwWFMAjVemCNz/TquwFP91xsK0XPU2EY1JiykAuy8Or6S9z1CedVfGCicK2V0CvlM7paSYtLmxZJNl2e3sYgHI=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr4629618otf.311.1630007784571; 
 Thu, 26 Aug 2021 12:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210825181812.4359-1-luben.tuikov@amd.com>
 <20210825181812.4359-2-luben.tuikov@amd.com>
In-Reply-To: <20210825181812.4359-2-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Aug 2021 15:56:13 -0400
Message-ID: <CADnq5_NhVBVunrPTQO1JFRZd82BiAm2=edfrew83GVuLg9y0QA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Process any VBIOS RAS EEPROM address
To: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 John Clements <john.clements@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Aug 25, 2021 at 2:32 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> We can now process any RAS EEPROM address from
> VBIOS. Generalize so as to compute the top three
> bits of the 19-bit EEPROM address, from any byte
> returned as the "i2c address" from VBIOS.
>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 194590252bb952..dc44c946a2442a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -114,21 +114,22 @@ static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
>  static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>                                   struct amdgpu_ras_eeprom_control *control)
>  {
> +       u8 i2c_addr;
> +
>         if (!control)
>                 return false;
>
> -       control->i2c_address = 0;
> -
> -       if (amdgpu_atomfirmware_ras_rom_addr(adev, (uint8_t*)&control->i2c_address))
> -       {
> -               if (control->i2c_address == 0xA0)
> -                       control->i2c_address = 0;
> -               else if (control->i2c_address == 0xA8)
> -                       control->i2c_address = 0x40000;
> -               else {
> -                       dev_warn(adev->dev, "RAS EEPROM I2C address not supported");
> -                       return false;
> -               }
> +       if (amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
> +               /* The address given by VBIOS is an 8-bit, wire-format
> +                * address, i.e. the most significant byte.
> +                *
> +                * Normalize it to a 19-bit EEPROM address. Remove the
> +                * device type identifier and make it a 7-bit address;
> +                * then make it a 19-bit EEPROM address. See top of
> +                * amdgpu_eeprom.c.
> +                */
> +               i2c_addr = (i2c_addr & 0x0F) >> 1;
> +               control->i2c_address = ((u32) i2c_addr) << 16;
>
>                 return true;
>         }
> --
> 2.32.0
>
