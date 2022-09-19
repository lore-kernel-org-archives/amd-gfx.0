Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F373C54EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 16:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1289010E68E;
	Mon, 19 Sep 2022 16:08:50 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58BC510E693
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 16:08:47 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-12803ac8113so56985fac.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=i+jGilU9V3DMHiF+YedFGPadmYxcUB+FOwGaQBOUByk=;
 b=RfaGRlhoNL/j2q9ywo3ox/1VXoJa/boDFeUh0BV5FDAkxKs7XFYKtss1cLGCmt4VDz
 0gIOro2hhZjPz4+gD+E6pQJ4DGLyFXgdYghWiDfy2o4N6cbVXr9UFC21mDEQPGAD/ND9
 SpG8UwWHEDfPiP5YJamzSm7cw84NU0MNA0x5r6qvtDZnHeYp5GFKAhyHEjTHrHh7P/LF
 qIXG+ZH8TSZs2BFRpqDc6gNm6cpV5a2Vc/TGVTQXMRDxGSntEWOE7qdLzFhKTWqXz29D
 9l7pyT9M4HHKHFIHL45jmh+HmhCQKwVIZfKgn6Nyb9/mLm3uNkJVVwkpuZvfe5Wjpmc0
 55dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=i+jGilU9V3DMHiF+YedFGPadmYxcUB+FOwGaQBOUByk=;
 b=L7TRhM2ZqufZPDs4bgiGYH4bsLen1i8DSwX7+ONU6LDT6h2m0sEVD8ct7uIDfW5A3R
 /PelQvY46Aojuy8oQg6funauo6K8jq09WBcUnTOF+jse2g+IROUTEJVjDdO1fJIOFU/y
 5itxeaCVH3pqP91rZVAvCR3nrF4Os69mP7f4/T3HEPIrvq20qIrbleO+VpsdATfBco5M
 etCXRd8hdjU7kcl1eTkTfsevmN9Re10fLArO+ZdeEr0v+2+9Uv3Ogm5PznfoNFgiS/aE
 EGxZk8KG17I3Exf9hDxilqzlRwM3WH+B5TokH9sb51Cf1vnbJQem3gyQ6Uav4xwCgiHS
 E4vA==
X-Gm-Message-State: ACrzQf2m5JtQcDrFDeByfbN06YCVuOX4Cs3xXLidkeqNyn9o5Bxe2rC+
 fp9mtfW/2bTxAEbI6E5SKlfT0zW9GZUJIuyH1a4=
X-Google-Smtp-Source: AMsMyM6RHJ3Fk0T6dNv4NKD/EuoPh0QKKmshJzMyYYBrovKJ6LgSQW6DDwep5r6pxVLwpGq4ZC5hbbipysj9L1BEyrc=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr10316388oam.96.1663603726483; Mon, 19
 Sep 2022 09:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220919134152.332411-1-David.Francis@amd.com>
In-Reply-To: <20220919134152.332411-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Sep 2022 12:08:35 -0400
Message-ID: <CADnq5_Oj6A+5YA8xXeJahYDauD31KsHgJkKrbyk+yUmwLGA5MA@mail.gmail.com>
Subject: Re: [v2] drm/amd: Add IMU fw version to fw version queries
To: David Francis <David.Francis@amd.com>
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
Cc: Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 19, 2022 at 9:42 AM David Francis <David.Francis@amd.com> wrote:
>
> IMU is a new firmware for GFX11.
>
> There are four means by which firmware version can be queried
> from the driver: device attributes, vf2pf, debugfs,
> and the AMDGPU_INFO_FW_VERSION option in the amdgpu info ioctl.
>
> Add IMU as an option for those four methods.
>
> V2: Added debugfs
>
> CC: Likun Gao <Likun.Gao@amd.com>
>
> Signed-off-by: David Francis <David.Francis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 13 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c   |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  1 +
>  include/uapi/drm/amdgpu_drm.h               |  2 ++
>  5 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 1369c25448dc..56753c3574b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -328,6 +328,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>                 fw_info->ver = adev->psp.cap_fw_version;
>                 fw_info->feature = adev->psp.cap_feature_version;
>                 break;
> +       case AMDGPU_INFO_FW_IMU:
> +               fw_info->ver = adev->gfx.imu_fw_version;
> +               fw_info->feature = 0;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -1488,6 +1492,15 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>                            fw_info.feature, fw_info.ver);
>         }
>
> +       /* IMU */
> +       query_fw.fw_type = AMDGPU_INFO_FW_IMU;
> +       query_fw.index = 0;
> +       ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
> +       if (ret)
> +               return ret;
> +       seq_printf(m, "IMU feature version: %u, firmware version: 0x%08x\n",
> +                  fw_info.feature, fw_info.ver);
> +
>         /* PSP SOS */
>         query_fw.fw_type = AMDGPU_INFO_FW_SOS;
>         ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 939c8614f0e3..a576a50fad25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -630,6 +630,7 @@ FW_VERSION_ATTR(rlc_srlg_fw_version, 0444, gfx.rlc_srlg_fw_version);
>  FW_VERSION_ATTR(rlc_srls_fw_version, 0444, gfx.rlc_srls_fw_version);
>  FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);
>  FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);
> +FW_VERSION_ATTR(imu_fw_version, 0444, gfx.imu_fw_version);
>  FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos.fw_version);
>  FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_context.bin_desc.fw_version);
>  FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.fw_version);
> @@ -651,7 +652,8 @@ static struct attribute *fw_attrs[] = {
>         &dev_attr_ta_ras_fw_version.attr, &dev_attr_ta_xgmi_fw_version.attr,
>         &dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
>         &dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
> -       &dev_attr_dmcu_fw_version.attr, NULL
> +       &dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
> +       NULL
>  };
>
>  static const struct attribute_group fw_attr_group = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e4af40b9a8aa..38c46f09d784 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -547,6 +547,7 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
>         POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
>         POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
>         POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
> +       POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,      adev->gfx.imu_fw_version);
>         POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
>         POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
>                             adev->psp.asd_context.bin_desc.fw_version);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index e78e4c27b62a..6c97148ca0ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -70,6 +70,7 @@ enum amd_sriov_ucode_engine_id {
>         AMD_SRIOV_UCODE_ID_RLC_SRLS,
>         AMD_SRIOV_UCODE_ID_MEC,
>         AMD_SRIOV_UCODE_ID_MEC2,
> +       AMD_SRIOV_UCODE_ID_IMU,
>         AMD_SRIOV_UCODE_ID_SOS,
>         AMD_SRIOV_UCODE_ID_ASD,
>         AMD_SRIOV_UCODE_ID_TA_RAS,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index c2c9c674a223..3e00cec47f52 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -755,6 +755,8 @@ struct drm_amdgpu_cs_chunk_data {
>         #define AMDGPU_INFO_FW_TOC              0x15
>         /* Subquery id: Query CAP firmware version */
>         #define AMDGPU_INFO_FW_CAP              0x16
> +       /* Subquery id: Query IMU firmware version */
> +       #define AMDGPU_INFO_FW_IMU              0x17
>
>  /* number of bytes moved for TTM migration */
>  #define AMDGPU_INFO_NUM_BYTES_MOVED            0x0f
> --
> 2.25.1
>
