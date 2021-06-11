Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD54C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF56F608FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF56F608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A7E6F38A;
	Fri, 11 Jun 2021 17:16:37 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6726F393
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 17:16:36 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id t40so6499319oiw.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eMLzcCQhk47wk6/XkVVta3Hc/IrdfwatHKtln2LNoYo=;
 b=Y3zWWABxtl5ufs8fm3LNLUupqNshki96xfhyY6HlAWkVXQ2Oo1vKDZH2M9JTf4Hlqt
 ou94D2H3zEj4rbwi1tMA179GoeqfsRJ5Vzin9efBq9ecTeqRSXMoc55TlO0XDkmv3xsu
 bPxih8AEB+hf1xAJ/uLmG9254u2BUS1SXLZVL+2Ean+XMaKFgcSnF+GcigIhtL8dCJbw
 +/+9YDAEUoW5H+f2/tw6eH/y/vu1Gw8c8XJRL3fjfDM9XcUb3zhY4QR+xWDW4VMr5GPh
 4EGZKFwefTxOZlRa72xQ4mWPrMiS3ghB5rGJMFu99P6tWiNnZiTj8JvgJtDyvMwqYpv3
 syAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eMLzcCQhk47wk6/XkVVta3Hc/IrdfwatHKtln2LNoYo=;
 b=rEmqfNVgeQ8Au6sKvSZ4tvyF15xxxc9+Aj4yDUjyculTet/jSCRMC46LbmQ0I/C7w0
 WW4MJwrSNQrQ3ac+HQqCUDp6T/GQEy/Y4v3hnoXJb8wNWs3j8tO+OyyY0sXJSTzhO8cf
 1aYynpcxXdR0ub0K1J3lFhoZ+qVzc34ycI4wOR3o5LscM5O6StKqUkC6ZoCYyfUa4Cij
 ZMd4IWnuo0ZLy1pvjZoRZ3r+SDyABxkLMVFd7XLD2PRjMo+siL4QP/yPJC0q/jlGfoSg
 cqcQhu/Cm4Q3NcRELWR3uQib7rTUTVKrOc/6uuO1faw9fQ9f6PRxjkD6HuSt87ZxRHQk
 boGA==
X-Gm-Message-State: AOAM5317pLuAMrjCCC3lzGYPgvNoS+Y/gkQo3pLVlFt0PTdEt40zdDI1
 /m0jdjRsKojfsIOsX9+8Gab34qKOU+BsjOizK+o=
X-Google-Smtp-Source: ABdhPJxVsDI7HXLnPfFGl1gT2Vby5xUCUuXRa2hw9Od6XZ4kVcwIl9qJRMSKzXBds1auhLMBjqButvj9Wwiqa5QqtJQ=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr13579819oic.5.1623431795791; 
 Fri, 11 Jun 2021 10:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-39-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-39-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jun 2021 13:16:24 -0400
Message-ID: <CADnq5_NsmgQL6A6Q6mD4DHsKmA9dFhKLrnpHN6QQ7sLCDzQ+sQ@mail.gmail.com>
Subject: Re: [PATCH 38/40] drm/amdgpu: RAS EEPROM table is now in debugfs
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
 Xinhui Pan <xinhui.pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Add "ras_eeprom_size" file in debugfs, which
> reports the maximum size allocated to the RAS
> table in EEROM, as the number of bytes and the
> number of records it could store. For instance,
>
> $cat /sys/kernel/debug/dri/0/ras/ras_eeprom_size
> 262144 bytes or 10921 records
> $_
>
> Add "ras_eeprom_table" file in debugfs, which
> dumps the RAS table stored EEPROM, in a formatted
> way. For instance,
>
> $cat ras_eeprom_table
>  Signature    Version  FirstOffs       Size   Checksum
> 0x414D4452 0x00010000 0x00000014 0x000000EC 0x000000DA
> Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage
>     0 0x00014      ue    0x00 0x00000000607608DC 0x000000000000   0x00    0x00 0x000000000000
>     1 0x0002C      ue    0x00 0x00000000607608DC 0x000000001000   0x00    0x00 0x000000000001
>     2 0x00044      ue    0x00 0x00000000607608DC 0x000000002000   0x00    0x00 0x000000000002
>     3 0x0005C      ue    0x00 0x00000000607608DC 0x000000003000   0x00    0x00 0x000000000003
>     4 0x00074      ue    0x00 0x00000000607608DC 0x000000004000   0x00    0x00 0x000000000004
>     5 0x0008C      ue    0x00 0x00000000607608DC 0x000000005000   0x00    0x00 0x000000000005
>     6 0x000A4      ue    0x00 0x00000000607608DC 0x000000006000   0x00    0x00 0x000000000006
>     7 0x000BC      ue    0x00 0x00000000607608DC 0x000000007000   0x00    0x00 0x000000000007
>     8 0x000D4      ue    0x00 0x00000000607608DD 0x000000008000   0x00    0x00 0x000000000008
> $_
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Xinhui Pan <xinhui.pan@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Seems like a useful feature.  Just a few comments below.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 241 +++++++++++++++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  10 +-
>  4 files changed, 252 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1424f2cc2076c1..d791a360a92366 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -404,9 +404,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>                 /* umc ce/ue error injection for a bad page is not allowed */
>                 if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
>                     amdgpu_ras_check_bad_page(adev, data.inject.address)) {
> -                       dev_warn(adev->dev, "RAS WARN: 0x%llx has been marked "
> -                                       "as bad before error injection!\n",
> -                                       data.inject.address);
> +                       dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
> +                                "already been marked as bad!\n",
> +                                data.inject.address);

This seems unrelated to this patch.

>                         break;
>                 }
>
> @@ -1301,6 +1301,12 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
>                            &con->bad_page_cnt_threshold);
>         debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_enabled);
>         debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
> +       debugfs_create_file("ras_eeprom_size", S_IRUGO, dir, adev,
> +                           &amdgpu_ras_debugfs_eeprom_size_ops);
> +       con->de_ras_eeprom_table = debugfs_create_file("ras_eeprom_table",
> +                                                      S_IRUGO, dir, adev,
> +                                                      &amdgpu_ras_debugfs_eeprom_table_ops);
> +       amdgpu_ras_debugfs_set_ret_size(&con->eeprom_control);
>
>         /*
>          * After one uncorrectable error happens, usually GPU recovery will
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 256cea5d34f2b6..283afd791db107 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -318,6 +318,7 @@ struct amdgpu_ras {
>         /* sysfs */
>         struct device_attribute features_attr;
>         struct bin_attribute badpages_attr;
> +       struct dentry *de_ras_eeprom_table;
>         /* block array */
>         struct ras_manager *objs;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index dc4a845a32404c..677e379f5fb5e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -27,6 +27,8 @@
>  #include <linux/bits.h>
>  #include "atom.h"
>  #include "amdgpu_eeprom.h"
> +#include <linux/debugfs.h>
> +#include <linux/uaccess.h>
>
>  #define EEPROM_I2C_MADDR_VEGA20         0x0
>  #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
> @@ -70,6 +72,13 @@
>  #define RAS_OFFSET_TO_INDEX(_C, _O) (((_O) - \
>                                       (_C)->ras_record_offset) / RAS_TABLE_RECORD_SIZE)
>
> +/* Given a 0-based relative record index, 0, 1, 2, ..., etc., off
> + * of "fri", return the absolute record index off of the end of
> + * the table header.
> + */
> +#define RAS_RI_TO_AI(_C, _I) (((_I) + (_C)->ras_fri) % \
> +                             (_C)->ras_max_record_count)
> +
>  #define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
>                                   RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
>
> @@ -77,13 +86,10 @@
>
>  static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
>  {
> -       if ((adev->asic_type == CHIP_VEGA20) ||
> -           (adev->asic_type == CHIP_ARCTURUS) ||
> -           (adev->asic_type == CHIP_SIENNA_CICHLID) ||
> -           (adev->asic_type == CHIP_ALDEBARAN))
> -               return true;
> -
> -       return false;
> +       return  adev->asic_type == CHIP_VEGA20 ||
> +               adev->asic_type == CHIP_ARCTURUS ||
> +               adev->asic_type == CHIP_SIENNA_CICHLID ||
> +               adev->asic_type == CHIP_ALDEBARAN;

Unrelated whitespace change.

>  }
>
>  static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
> @@ -258,6 +264,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
>         control->ras_num_recs = 0;
>         control->ras_fri = 0;
>
> +       amdgpu_ras_debugfs_set_ret_size(control);
> +
>         mutex_unlock(&control->ras_tbl_mutex);
>
>         return res;
> @@ -591,6 +599,8 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>         res = amdgpu_ras_eeprom_append_table(control, record, num);
>         if (!res)
>                 res = amdgpu_ras_eeprom_update_header(control);
> +       if (!res)
> +               amdgpu_ras_debugfs_set_ret_size(control);
>
>         mutex_unlock(&control->ras_tbl_mutex);
>         return res;
> @@ -734,6 +744,223 @@ inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
>         return RAS_MAX_RECORD_COUNT;
>  }
>
> +static ssize_t
> +amdgpu_ras_debugfs_eeprom_size_read(struct file *f, char __user *buf,
> +                                   size_t size, loff_t *pos)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +       struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
> +       u8 data[50];
> +       int res;
> +
> +       if (!size)
> +               return size;
> +
> +       if (!ras || !control) {
> +               res = snprintf(data, sizeof(data), "Not supported\n");
> +       } else {
> +               res = snprintf(data, sizeof(data), "%d bytes or %d records\n",
> +                              RAS_TBL_SIZE_BYTES, control->ras_max_record_count);
> +       }
> +
> +       if (*pos >= res)
> +               return 0;
> +
> +       res -= *pos;
> +       res = min_t(size_t, res, size);
> +
> +       if (copy_to_user(buf, &data[*pos], res))
> +               return -EINVAL;
> +
> +       *pos += res;
> +
> +       return res;
> +}
> +
> +const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops = {
> +       .owner = THIS_MODULE,
> +       .read = amdgpu_ras_debugfs_eeprom_size_read,
> +       .write = NULL,
> +       .llseek = default_llseek,
> +};
> +
> +static const char *tbl_hdr_str = " Signature    Version  FirstOffs       Size   Checksum\n";
> +static const char *tbl_hdr_fmt = "0x%08X 0x%08X 0x%08X 0x%08X 0x%08X\n";
> +#define tbl_hdr_fmt_size (5 * (2+8) + 4 + 1)
> +static const char *rec_hdr_str = "Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage\n";
> +static const char *rec_hdr_fmt = "%5d 0x%05X %7s    0x%02X 0x%016llX 0x%012llX   0x%02X    0x%02X 0x%012llX\n";
> +#define rec_hdr_fmt_size (5 + 1 + 7 + 1 + 7 + 1 + 7 + 1 + 18 + 1 + 14 + 1 + 6 + 1 + 7 + 1 + 14 + 1)
> +
> +static const char *record_err_type_str[AMDGPU_RAS_EEPROM_ERR_COUNT] = {
> +       "ignore",
> +       "re",
> +       "ue",
> +};
> +
> +static loff_t amdgpu_ras_debugfs_table_size(struct amdgpu_ras_eeprom_control *control)
> +{
> +       return strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
> +               strlen(rec_hdr_str) + rec_hdr_fmt_size * control->ras_num_recs;
> +}
> +
> +void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control)
> +{
> +       struct amdgpu_ras *ras = container_of(control, struct amdgpu_ras,
> +                                             eeprom_control);
> +       struct dentry *de = ras->de_ras_eeprom_table;
> +
> +       if (de)
> +               d_inode(de)->i_size = amdgpu_ras_debugfs_table_size(control);
> +}
> +
> +static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
> +                                            size_t size, loff_t *pos)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +       struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
> +       const size_t orig_size = size;
> +       int res = -EINVAL;
> +       size_t data_len;
> +
> +       mutex_lock(&control->ras_tbl_mutex);
> +
> +       /* We want *pos - data_len > 0, which means there's
> +        * bytes to be printed from data.
> +        */
> +       data_len = strlen(tbl_hdr_str);
> +       if (*pos < data_len) {
> +               data_len -= *pos;
> +               data_len = min_t(size_t, data_len, size);
> +               if (copy_to_user(buf, &tbl_hdr_str[*pos], data_len))
> +                       goto Out;
> +               buf += data_len;
> +               size -= data_len;
> +               *pos += data_len;
> +       }
> +
> +       data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size;
> +       if (*pos < data_len && size > 0) {
> +               u8 data[tbl_hdr_fmt_size + 1];
> +               loff_t lpos;
> +
> +               snprintf(data, sizeof(data), tbl_hdr_fmt,
> +                        control->tbl_hdr.header,
> +                        control->tbl_hdr.version,
> +                        control->tbl_hdr.first_rec_offset,
> +                        control->tbl_hdr.tbl_size,
> +                        control->tbl_hdr.checksum);
> +
> +               data_len -= *pos;
> +               data_len = min_t(size_t, data_len, size);
> +               lpos = *pos - strlen(tbl_hdr_str);
> +               if (copy_to_user(buf, &data[lpos], data_len))
> +                       goto Out;
> +               buf += data_len;
> +               size -= data_len;
> +               *pos += data_len;
> +       }
> +
> +       data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size + strlen(rec_hdr_str);
> +       if (*pos < data_len && size > 0) {
> +               loff_t lpos;
> +
> +               data_len -= *pos;
> +               data_len = min_t(size_t, data_len, size);
> +               lpos = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size;
> +               if (copy_to_user(buf, &rec_hdr_str[lpos], data_len))
> +                       goto Out;
> +               buf += data_len;
> +               size -= data_len;
> +               *pos += data_len;
> +       }
> +
> +       data_len = amdgpu_ras_debugfs_table_size(control);
> +       if (*pos < data_len && size > 0) {
> +               u8 dare[RAS_TABLE_RECORD_SIZE];
> +               u8 data[rec_hdr_fmt_size + 1];
> +               /* Find the starting record index
> +                */
> +               int s = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
> +                        strlen(rec_hdr_str)) / rec_hdr_fmt_size;
> +               int r = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
> +                        strlen(rec_hdr_str)) % rec_hdr_fmt_size;
> +               struct eeprom_table_record record;
> +
> +               for ( ; size > 0 && s < control->ras_num_recs; s++) {
> +                       u32 ai = RAS_RI_TO_AI(control, s);
> +                       /* Read a single record
> +                        */
> +                       res = __amdgpu_ras_eeprom_read(control, dare, ai, 1);
> +                       if (res)
> +                               goto Out;
> +                       __decode_table_record_from_buf(control, &record, dare);
> +                       snprintf(data, sizeof(data), rec_hdr_fmt,
> +                                s,
> +                                RAS_INDEX_TO_OFFSET(control, ai),
> +                                record_err_type_str[record.err_type],
> +                                record.bank,
> +                                record.ts,
> +                                record.offset,
> +                                record.mem_channel,
> +                                record.mcumc_id,
> +                                record.retired_page);
> +
> +                       data_len = min_t(size_t, rec_hdr_fmt_size - r, size);
> +                       if (copy_to_user(buf, &data[r], data_len))
> +                               return -EINVAL;
> +                       buf += data_len;
> +                       size -= data_len;
> +                       *pos += data_len;
> +                       r = 0;
> +               }
> +       }
> +       res = 0;
> +Out:
> +       mutex_unlock(&control->ras_tbl_mutex);
> +       return res < 0 ? res : orig_size - size;
> +}
> +
> +static ssize_t
> +amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
> +                                    size_t size, loff_t *pos)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +       struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
> +       u8 data[81];
> +       int res;
> +
> +       if (!size)
> +               return size;
> +
> +       if (!ras || !control) {
> +               res = snprintf(data, sizeof(data), "Not supported\n");
> +               if (*pos >= res)
> +                       return 0;
> +
> +               res -= *pos;
> +               res = min_t(size_t, res, size);
> +
> +               if (copy_to_user(buf, &data[*pos], res))
> +                       return -EINVAL;
> +
> +               *pos += res;
> +
> +               return res;
> +       } else {
> +               return amdgpu_ras_debugfs_table_read(f, buf, size, pos);
> +       }
> +}
> +
> +const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops = {
> +       .owner = THIS_MODULE,
> +       .read = amdgpu_ras_debugfs_eeprom_table_read,
> +       .write = NULL,
> +       .llseek = default_llseek,
> +};
> +
>  /**
>   * __verify_ras_table_checksum -- verify the RAS EEPROM table checksum
>   * @control: pointer to control structure
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index edb0195ea2eb8c..430e08ab3313a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -29,9 +29,10 @@
>  struct amdgpu_device;
>
>  enum amdgpu_ras_eeprom_err_type {
> -       AMDGPU_RAS_EEPROM_ERR_PLACE_HOLDER,
> +       AMDGPU_RAS_EEPROM_ERR_NA,
>         AMDGPU_RAS_EEPROM_ERR_RECOVERABLE,
> -       AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE
> +       AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE,
> +       AMDGPU_RAS_EEPROM_ERR_COUNT,
>  };
>
>  struct amdgpu_ras_eeprom_table_header {
> @@ -121,4 +122,9 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>
>  inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
>
> +void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
> +
> +extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
> +extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
> +
>  #endif // _AMDGPU_RAS_EEPROM_H
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
