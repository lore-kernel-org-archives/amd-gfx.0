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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C9C48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E0B613DD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E0B613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904A56EDF8;
	Thu, 10 Jun 2021 21:11:13 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A5F6EDF8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:11:13 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id t40so3595028oiw.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eahcO4PbtSHLsnM/rYcD+QgUDNeYUmND285tZYxzmjc=;
 b=rFP5y+RDyZ08tldNWHlmsG76G2+vCtf/yWHOnqRbSj22niO2OGICqE0cc9R7TWuMAm
 J7yllsE0xq5QuJdd42Zsl1y9+7IZV7ljk7qyaPMxAcIWKgp0YUUhtf/cJepRkHp7lC5y
 sCuucHCP8eggBXr5M1/8AOQgxjvtKIGvi9AssG72W+7WFhq/ArdfEmbdEBqdrs9toGGF
 PMWEGo9+bJ8ylwgSTZCJxOJSx3npCVbiYf/E9HHLrzGYaLwmxUe/3RHaOHbErZ0oPCBT
 8Lb3hx0KIxY8h7P2C3pPfxGxYQgb8xXScihmvoGA5S2BdgI1JvWQuj1ZkNDeqd6LM2SU
 znEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eahcO4PbtSHLsnM/rYcD+QgUDNeYUmND285tZYxzmjc=;
 b=jQyFBgQNGebTinOpP2i+b7R8KV6HYq3wqWUJYb01ND6wrmupOwAVibSWe5AGpAtk3f
 fOR7L9zy4nVqGoZv7uP4L8u4+NQufGLJ2d1CFbhxgDSiFcACIg4TdAq1RF6ljD0wB5HY
 /ER9Dv8EceDEd0peMglV3UJGKc4wPLuK8+vVNhG2q/UvVTUevs7glTa66iFd+e923gc1
 0OMrA7jdjSzfOGFqfLPkFD5HiE7azRn6bxp/mCB8zwxZNmc+hy2KMuf17cGTgLYJMPVY
 BjFMUBN6OemsDvQiw7S7lEPfrYIGUpGBF93Ou2vmtsehTO8S9xhep4PKla5SZKiH9QRB
 B0/A==
X-Gm-Message-State: AOAM532OmVOqBn3FYXdahIab/b5EP+UexZyzaeW6Iu9rk2E8GfbnXHeR
 4UcdVSVIKc4hk4ooy2y/SX2kHnRpgt4sAaJRwvs=
X-Google-Smtp-Source: ABdhPJxRunI8UUQBaRZA28WMy8Ns3rSJwgvIY0AoNO8+5CFmXAltvHerQTUkgpkYAS20TzLExduVGOZsEzOQmTbGkzU=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr10855249oic.5.1623359472544; 
 Thu, 10 Jun 2021 14:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-33-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-33-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:11:01 -0400
Message-ID: <CADnq5_P+7ioe-ZY+AnaNxy7fLnqxk0ffY0qgk4CTRpg=sdEJWQ@mail.gmail.com>
Subject: Re: [PATCH 32/40] drm/amdgpu: Return result fix in RAS
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

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> The low level EEPROM write method, doesn't return
> 1, but the number of bytes written. Thus do not
> compare to 1, instead, compare to greater than 0
> for success.
>
> Other cleanup: if the lower layers returned
> -errno, then return that, as opposed to
> overwriting the error code with one-fits-all
> -EINVAL. For instance, some return -EAGAIN.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 22 +++++++++++--------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  3 +--
>  4 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index a5a87affedabf1..a4815af111ed12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -105,8 +105,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>         int r;
>         u16 len;
>
> -       r = 0;
> -       for ( ; buf_size > 0;
> +       for (r = 0; buf_size > 0;
>               buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
>                 /* Set the EEPROM address we want to write to/read from.
>                  */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e3ad081eddd40b..66c96c65e7eeb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -355,8 +355,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>   *     to see which blocks support RAS on a particular asic.
>   *
>   */
> -static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *buf,
> -               size_t size, loff_t *pos)
> +static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
> +                                            const char __user *buf,
> +                                            size_t size, loff_t *pos)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>         struct ras_debug_if data;
> @@ -370,7 +371,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
>
>         ret = amdgpu_ras_debugfs_ctrl_parse_data(f, buf, size, pos, &data);
>         if (ret)
> -               return -EINVAL;
> +               return ret;
>
>         if (data.op == 3) {
>                 ret = amdgpu_reserve_page_direct(adev, data.inject.address);
> @@ -439,21 +440,24 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
>   * will reset EEPROM table to 0 entries.
>   *
>   */
> -static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f, const char __user *buf,
> -               size_t size, loff_t *pos)
> +static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f,
> +                                              const char __user *buf,
> +                                              size_t size, loff_t *pos)
>  {
>         struct amdgpu_device *adev =
>                 (struct amdgpu_device *)file_inode(f)->i_private;
>         int ret;
>
>         ret = amdgpu_ras_eeprom_reset_table(
> -                       &(amdgpu_ras_get_context(adev)->eeprom_control));
> +               &(amdgpu_ras_get_context(adev)->eeprom_control));
>
> -       if (ret == 1) {
> +       if (ret > 0) {
> +               /* Something was written to EEPROM.
> +                */
>                 amdgpu_ras_get_context(adev)->flags = RAS_DEFAULT_FLAGS;
>                 return size;
>         } else {
> -               return -EIO;
> +               return ret;
>         }
>  }
>
> @@ -1991,7 +1995,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>         kfree(*data);
>         con->eh_data = NULL;
>  out:
> -       dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
> +       dev_warn(adev->dev, "Failed to initialize ras recovery! (%d)\n", ret);
>
>         /*
>          * Except error threshold exceeding case, other failure cases in this
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 17cea35275e46c..dc48c556398039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -335,7 +335,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>                 ret = amdgpu_ras_eeprom_reset_table(control);
>         }
>
> -       return ret == 1 ? 0 : -EIO;
> +       return ret > 0 ? 0 : -EIO;
>  }
>
>  static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index 65035256756679..7f48ee020bc03e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -222,7 +222,7 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
>                                        u32 numbytes, u32 i2c_flag)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
> -       uint32_t bytes_sent, reg, ret = 0;
> +       u32 bytes_sent, reg, ret = I2C_OK;
>         unsigned long  timeout_counter;
>
>         bytes_sent = 0;
> @@ -290,7 +290,6 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
>         }
>
>         ret = smu_v11_0_i2c_poll_tx_status(control);
> -
>  Err:
>         /* Any error, no point in proceeding */
>         if (ret != I2C_OK) {
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
