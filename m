Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A66ECD997
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9117510E123;
	Thu,  5 Feb 2026 21:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AsMNcR78";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FE110E121
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:41:58 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124a7216c9cso155953c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770327717; cv=none;
 d=google.com; s=arc-20240605;
 b=cxHLi5s5NgEwb+6TdaMbgsgngpXJgfXqZsMPaVo7ajMHBLwX3azBuZJrwzV5barAKj
 LEKFJQNKFAzGfrDTLexbh75/C5CuG4zTTMzfoHKmcTrzTLrnjMVv1RZGrW8vGMzx1afL
 4cv9dfiBxs3iFgx/8VReR6v+K/rBKuhdwqUCJsTF+DbqfsFFVDoiXgigTI27U8P4Qkjm
 zzmwje8tUxATG5MTrGZGtTGDWsNC723QPYYGUotpjxTEBANQoStUf1dF+uCfSo3g6v8M
 OZ5WKKN93kaboz71PhIe79aR//eb+iUFNHmmXxzhU6ohk/P4+IhiTtOr234c3nyL/Mnx
 WDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2HMvwmXokJVopHwAFdi/vAPMt+y/x31YgL+KA5pw8x0=;
 fh=2bXaSIMuijWSOy2F188XCUffzpJMKEqHmLCUVWoQwd4=;
 b=TgJOsNzNVaoeijuQJKNqhhLIgLxrBVAq9Usu97E9ukfYcf3GZcPDN/tj6W1TI05AB2
 S+X2FPqWS6NAJHbOeNJCoDkylTRAQ5NDlFWJGs9ZnMWqENPNyOh62R04lb/4xzGcm79U
 DL+5n41RXYuixyjJoguSMJJYpjFE3QvQsof/qGx+GBjJmWvY7edYluQjwww8w8ZHGGOE
 5K6VHplG+7pe+Wz282e8uKFzaM4XqSEwu1EalKdsBhokRzLNMa4owS6DabWlP2ZB+R9/
 zfCeBVGkeQR83pH2XJ/FxnuHaN5Wwdfp3IYYdligjApK4FQVU4VS4H6ZrJxVpqI3MlPQ
 wCBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770327717; x=1770932517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HMvwmXokJVopHwAFdi/vAPMt+y/x31YgL+KA5pw8x0=;
 b=AsMNcR78mpddm7Yg38GZubm8ft06gcJ3t8p3tWRTOWYp4cYw/F7suK8bY6/LLNxGbc
 YhImiW9/8uJXw+lMriteZZPYS3A8+mRlkMC1lymWJZSHTxpnkFeD5Lx+9mb+xbQtTeCa
 k3KrM6is+RLlVRTne2Vb0enn64Z2gYKZpgY4I7ccdg+8vZK+LJfdfwVCDCG4ChSObsrs
 p+3TZ3JaOux3upNcLRRALmO4ow39NnTOJ6shnWfXmz10r9XZb/UiPTC8E/NZOhIx1K/A
 EqfblgmwZjpDmhs6rG8D0ZzbWqAacRKIMZtXFLkRBL1PIprX76moc+mdLdV7Q5ylDgOw
 WRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327717; x=1770932517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2HMvwmXokJVopHwAFdi/vAPMt+y/x31YgL+KA5pw8x0=;
 b=XPyTGjVZrbDTm/UUfPDK2R+1fbvwU2SutNPwzj2Exu9R1g+bUKaWAUsavtMewdWEOi
 8Ry2PcfQ5FdkMQ8cYJ1MyD54y6kkz6HrtsAGgMVhWvYyLPp7NUc6JXR3HwMrd4FHspem
 D+Tn5yL+FK8HLtVkKwpdh6VPuCQ0bsSXxTUCbwQ6ecmjwAFaEn7szWVAyibgtpJvqv5x
 UpK0v6euEd7F8/hTgkm5OOp53N5LiUqcYCJ73Gs/MUV+Ir0lyqPG1WgMoIob0LPSoVCf
 n0SeNZw1YoWxshBlbCBUE5eEKd+jAK3Q81zGs13uspcB7ZQe2sPn5S1JUruUad/sOlzd
 VT1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlB7Vwxd8njJqVRrBMe+c309zzPxiGm6bw46EXK1KohEyYPJoKULxiYETdvwKwlTitrv6hpMxm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCsJk+VlZZBtuBoZC+/3hzgPadC7PdV+lX/SdrrblW9XGUZGw4
 hJoI+Gz+ANwf4eeMVgyRn3q8p7d+pZABXLIVpTuG73FSKm46+3kX3q0P+fN8chD/0dNXRi8GoB0
 0WhZzS/J+LKJB8tDV92rYnuTNwFukVro=
X-Gm-Gg: AZuq6aLym45yTD+Y1+k58wH3osdQO4LITe8dvZ/mMqcGSU4m1meROsikOChyfdnpMF/
 1iI6fnMzQDwxD3FVmVB5liTb1XRPAmfP/c75vlWHdkPJ+biHfVWaeuQZq63Y9GWY2P5zdQWjZgO
 iBVyCelc4rI3SHIAaNxnE7vSGxxQyy4aFm8YBmfGV+cOYe/ZlpXSw1sLuVvhw1mBi42rqOcYIKk
 WpWGed23PFP7+5q8b7HZDmGaateNiG7h63cT2vLYsl51i2Ku/lwCEOYoWQPe9RhIXGr32M+
X-Received: by 2002:a05:7022:7a6:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-12703fede1amr146668c88.7.1770327717294; Thu, 05 Feb 2026
 13:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-8-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-8-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:41:45 -0500
X-Gm-Features: AZwV_QhM1n1zWnb-f3yUiqjFH4WR0zqYL9N1_7BxFiIG-ZqdtLkTfUIU93gro9U
Message-ID: <CADnq5_N40TLTqtHMRNTzZfv-AEnmu1Sj1i+aLAyxY+w26DQRww@mail.gmail.com>
Subject: Re: [PATCH 08/22] drm/amdgpu: add sysfs for Peak Tops Limiter (PTL)
To: Perry Yuan <perry.yuan@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 yifan1.zhang@amd.com
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

On Thu, Feb 5, 2026 at 2:02=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wrot=
e:
>
> Add per-GPU sysfs files under /sys/class/drm/cardX/device/ptl to
> control the Peak Tops Limiter (PTL) feature. Exposes ptl_enable
> (enable/disable PTL), ptl_format (set/query preferred formats),
> and ptl_supported_formats (list supported formats)
>
> Example usage
> -------------
> Query PTL status:
>     `cat /sys/class/drm/card1/device/ptl/ptl_enable`
>
> Enable PTL:
>     `sudo bash -c "echo 1 > /sys/class/drm/card1/device/ptl/ptl_enable"`
>
> Disable PTL:
>     `sudo bash -c "echo 0 > /sys/class/drm/card1/device/ptl/ptl_enable"`
>
> Set PTL preferred formats:
>     `sudo bash -c "echo I8,F32 > /sys/class/drm/card1/device/ptl/ptl_form=
at"`
>
> Query supported formats:
>     `cat /sys/class/drm/card1/device/ptl/ptl_supported_formats`
>
> v3 changes:
>  * move N/A to previous format in format show(Alex)
>  * fix format check for format store(Alex)
>  * drop the ptl declarations into amdgpu_ptl.h(Alex)
>
> v2 changes:
>  * add usage commands in commit info (Alex)
>  * move amdgpu_ptl_fmt into kgd_kfd_interface.h (Alex)
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 168 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |   3 +
>  3 files changed, 172 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 95d26f086d54..d88da1beb532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3146,6 +3146,7 @@ static const struct attribute_group *amdgpu_sysfs_g=
roups[] =3D {
>         &amdgpu_vram_mgr_attr_group,
>         &amdgpu_gtt_mgr_attr_group,
>         &amdgpu_flash_attr_group,
> +       &amdgpu_ptl_attr_group,
>         NULL,
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 2fbc3f95fedd..9cb30f3e21be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -52,6 +52,15 @@ static int psp_load_smu_fw(struct psp_context *psp);
>  static int psp_rap_terminate(struct psp_context *psp);
>  static int psp_securedisplay_terminate(struct psp_context *psp);
>
> +static const char * const amdgpu_ptl_fmt_str[] =3D {
> +       [AMDGPU_PTL_FMT_I8]      =3D "I8",
> +       [AMDGPU_PTL_FMT_F16]     =3D "F16",
> +       [AMDGPU_PTL_FMT_BF16]    =3D "BF16",
> +       [AMDGPU_PTL_FMT_F32]     =3D "F32",
> +       [AMDGPU_PTL_FMT_F64]     =3D "F64",
> +       [AMDGPU_PTL_FMT_INVALID] =3D "INVALID",
> +};
> +
>  static int psp_ring_init(struct psp_context *psp,
>                          enum psp_ring_type ring_type)
>  {
> @@ -1277,6 +1286,140 @@ int psp_performance_monitor_hw(struct psp_context=
 *psp, u32 req_code,
>         return ret;
>  }
>
> +static enum amdgpu_ptl_fmt str_to_ptl_fmt(const char *str)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < AMDGPU_PTL_FMT_INVALID; ++i) {
> +               if (!strcmp(str, amdgpu_ptl_fmt_str[i]))
> +                       return (enum amdgpu_ptl_fmt)i;
> +       }
> +
> +       return AMDGPU_PTL_FMT_INVALID;
> +}
> +
> +static ssize_t ptl_supported_formats_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       ssize_t len =3D 0;
> +
> +       for (int i =3D 0; i < AMDGPU_PTL_FMT_INVALID; ++i) {
> +               len +=3D sysfs_emit_at(buf, len, "%s%s",
> +                               amdgpu_ptl_fmt_str[i],
> +                               (i < AMDGPU_PTL_FMT_INVALID - 1) ? "," : =
"\n");
> +       }
> +
> +       return len;
> +}
> +
> +static ssize_t ptl_enable_store(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct psp_context *psp =3D &adev->psp;
> +       bool enable, cur_enabled;
> +       uint32_t ptl_state, fmt1, fmt2;
> +       int ret;
> +
> +       if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1"))

"enable"

> +               enable =3D true;
> +       else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0"))

"disable"

Alex

> +               enable =3D false;
> +       else
> +               return -EINVAL;
> +
> +       fmt1 =3D psp->ptl_fmt1;
> +       fmt2 =3D psp->ptl_fmt2;
> +       ptl_state =3D enable ? 1 : 0;
> +
> +       cur_enabled =3D READ_ONCE(psp->ptl_enabled);
> +       if (cur_enabled =3D=3D enable)
> +               return count;
> +
> +       ret =3D psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &pt=
l_state, &fmt1, &fmt2);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to set PTL err =3D %d\n", ret)=
;
> +               return ret;
> +       }
> +
> +       return count;
> +}
> +
> +static ssize_t ptl_enable_show(struct device *dev, struct device_attribu=
te *attr, char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct psp_context *psp =3D &adev->psp;
> +
> +       return sysfs_emit(buf, "%s\n", psp->ptl_enabled ? "enabled" : "di=
sabled");
> +}
> +
> +static ssize_t ptl_format_store(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct psp_context *psp =3D &adev->psp;
> +       char fmt1_str[8], fmt2_str[8];
> +       enum amdgpu_ptl_fmt fmt1_enum, fmt2_enum;
> +       uint32_t ptl_state, fmt1, fmt2;
> +       int ret;
> +
> +       /* Only allow format update when PTL is enabled */
> +       if (!psp->ptl_enabled)
> +               return -EPERM;
> +
> +       /* Parse input, expecting "FMT1,FMT2" */
> +       if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) !=3D 2)
> +               return -EINVAL;
> +
> +       fmt1_enum =3D str_to_ptl_fmt(fmt1_str);
> +       fmt2_enum =3D str_to_ptl_fmt(fmt2_str);
> +
> +       if (fmt1_enum >=3D AMDGPU_PTL_FMT_INVALID ||
> +                       fmt2_enum >=3D AMDGPU_PTL_FMT_INVALID ||
> +                       fmt1_enum =3D=3D fmt2_enum)
> +               return -EINVAL;
> +
> +       ptl_state =3D psp->ptl_enabled;
> +       fmt1 =3D fmt1_enum;
> +       fmt2 =3D fmt2_enum;
> +       ret =3D psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &pt=
l_state, &fmt1, &fmt2);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to update PTL err =3D %d\n", r=
et);
> +               return ret;
> +       }
> +
> +       return count;
> +}
> +
> +static ssize_t ptl_format_show(struct device *dev, struct device_attribu=
te *attr, char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct psp_context *psp =3D &adev->psp;
> +
> +       return sysfs_emit(buf, "%s,%s\n",
> +                       amdgpu_ptl_fmt_str[psp->ptl_fmt1],
> +                       amdgpu_ptl_fmt_str[psp->ptl_fmt2]);
> +}
> +
> +static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attrib=
ute *attr, int idx)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +       /* Only show PTL sysfs files if PTL hardware is supported */
> +       if (!adev->psp.ptl_hw_supported)
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
>  int psp_spatial_partition(struct psp_context *psp, int mode)
>  {
>         struct psp_gfx_cmd_resp *cmd;
> @@ -4271,6 +4414,31 @@ void psp_copy_fw(struct psp_context *psp, uint8_t =
*start_addr, uint32_t bin_size
>  static DEVICE_ATTR(usbc_pd_fw, 0644,
>                    psp_usbc_pd_fw_sysfs_read,
>                    psp_usbc_pd_fw_sysfs_write);
> +/**
> + * DOC: PTL sysfs attributes
> + * These sysfs files under /sys/class/drm/cardX/device/ptl allow users t=
o enable or disable
> + * the Peak Tops Limiter (PTL), configure preferred PTL data formats, an=
d query supported
> + * formats for each GPU.
> + */
> +static DEVICE_ATTR(ptl_enable, 0644,
> +                       ptl_enable_show, ptl_enable_store);
> +static DEVICE_ATTR(ptl_format, 0644,
> +                       ptl_format_show, ptl_format_store);
> +static DEVICE_ATTR(ptl_supported_formats, 0444,
> +                       ptl_supported_formats_show, NULL);
> +
> +static struct attribute *ptl_attrs[] =3D {
> +       &dev_attr_ptl_enable.attr,
> +       &dev_attr_ptl_format.attr,
> +       &dev_attr_ptl_supported_formats.attr,
> +       NULL,
> +};
> +
> +const struct attribute_group amdgpu_ptl_attr_group =3D {
> +       .name =3D "ptl",
> +       .attrs =3D ptl_attrs,
> +       .is_visible =3D amdgpu_ptl_is_visible,
> +};
>
>  int is_psp_fw_valid(struct psp_bin_desc bin)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 47c8becbf710..0a2f8d33a0ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -63,6 +63,7 @@
>  #define MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
>
>  extern const struct attribute_group amdgpu_flash_attr_group;
> +extern const struct attribute_group amdgpu_ptl_attr_group;
>
>  enum psp_shared_mem_size {
>         PSP_ASD_SHARED_MEM_SIZE                         =3D 0x0,
> @@ -660,5 +661,7 @@ int amdgpu_psp_get_fw_type(struct amdgpu_firmware_inf=
o *ucode,
>
>  int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
>                                u32 *ptl_state, u32 *fmt1, u32 *fmt2);
> +int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
> +void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
>
>  #endif
> --
> 2.34.1
>
