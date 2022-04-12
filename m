Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936E6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 17:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C31B10E0A2;
	Tue, 12 Apr 2022 17:30:19 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A7410E0A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 17:30:17 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-e2afb80550so9572342fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CfM59jPHh4k5GATg0SmlMBnq4SajAFN2U+C8v1YBxyE=;
 b=LPhznXIiu+hkuHCiPEKPofSoNOjCr9e+vkMt0kguFaJfSXNxD3AbhA41LhFX5+6IxP
 JxYu24X4f9hsuqsADUpmdjfWuQmNC8aCAtkAyZX55B/xZiGCszQ0Wfz/UQYW9Z0k/BSj
 ZTis5xd57gV8RVRM6CrJFTzD5ifG//VQXC1fXVIVTUJQjyFgzhlStwOkFcPJqZ5UWrzY
 biPm4//DGSNmFTVX0ku5lYyG5RV7j2xvq8oJlIFvVhoVoP+gMOsNL+gMtUk7lyT/B4KD
 l48U5a+7igQrYKzIF1iuhovvRha6p2RNQv+5+RSzugzJ2Tgtn+XyHRqQD1RN10SssA8u
 h2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CfM59jPHh4k5GATg0SmlMBnq4SajAFN2U+C8v1YBxyE=;
 b=T1di9T36gSns9AAUiFp5vx7U65KUvCISVS0K3JmoVjKPfhqBg3nnBGJvynHOm8+MYK
 XXfMlQj9HP9BfKIzFrLD10z2bZ50nlndiqzBBetwYalw7fKvc3Knk0DlJGbeQAQhV0to
 2hnVkQy6bNjyRm0vUb7JgjNCLciYHUHdvZ8q0Af0Fu66iq45Lkj8FNJSpPt329JdA2MN
 hNNHbvPAgZVAs3BBarM8L5U6TpOJcI9tR9YlB21Rf6hnL+e5UIatmubaGHuChOEoCWCX
 U97JxkhI8qOwOCDJtUBv5OuKt/+9F3aovMqvW+VDhMDN+DaeMJ8R30wcy0UUirRrf5Uv
 juig==
X-Gm-Message-State: AOAM533KKw0rZDrwURYUv8+N2IHtK2Rh0S+3v8lTR1gZirzN9na/Uw7a
 YZyc8shYLdLH8phlxdR6iRBC4xRy864qmngRa/LSdM3e
X-Google-Smtp-Source: ABdhPJzMkSdvWh6Jl8QUxMRUbWpL2Vo1lyjomEdAvxA0eMyG4fwndiy+w7l9ON6MYKwfZdiDcdOhB83ILBF5eqzt6Yo=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr2697967oap.253.1649784616680; Tue, 12
 Apr 2022 10:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220412160408.128949-1-Bokun.Zhang@amd.com>
In-Reply-To: <20220412160408.128949-1-Bokun.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Apr 2022 13:30:05 -0400
Message-ID: <CADnq5_OttpWYtwSC3cne0DZTM+rN=a3Am-ex21Om4uSiME-z5A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Update PF2VF header
To: Bokun Zhang <Bokun.Zhang@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 12, 2022 at 12:04 PM Bokun Zhang <Bokun.Zhang@amd.com> wrote:
>
> - Add proper indentation in the header file
> - In the latest version of the header, there is a variable name change.
>   This should not cause any backward compatibility since the variable is
>   at the same offset in the struct.

Please split this into two patches, one to change the variable name,
one to adjust the whitespace.

Thanks,

Alex

>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 101 ++++++++++----------
>  2 files changed, 51 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a2e0a81831e0..14c5ccf81e80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3725,7 +3725,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* enable PCIE atomic ops */
>         if (amdgpu_sriov_vf(adev))
>                 adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
> -                       adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
> +                       adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
>                         (PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
>         else
>                 adev->have_atomics_support =
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 7326b6c1b71c..43dc9026ef7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -1,34 +1,33 @@
>  /*
> - * Copyright 2018-2019 Advanced Micro Devices, Inc.
> + * Copyright (c) 2018-2021 Advanced Micro Devices, Inc. All rights reserved.
>   *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
>   *
>   * The above copyright notice and this permission notice shall be included in
>   * all copies or substantial portions of the Software.
>   *
>   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
>   */
>
>  #ifndef AMDGV_SRIOV_MSG__H_
>  #define AMDGV_SRIOV_MSG__H_
>
>  /* unit in kilobytes */
> -#define AMD_SRIOV_MSG_VBIOS_OFFSET              0
> -#define AMD_SRIOV_MSG_VBIOS_SIZE_KB             64
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB    AMD_SRIOV_MSG_VBIOS_SIZE_KB
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB      4
> +#define AMD_SRIOV_MSG_VBIOS_OFFSET          0
> +#define AMD_SRIOV_MSG_VBIOS_SIZE_KB         64
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
>
>  /*
>   * layout
> @@ -51,10 +50,10 @@
>   * v2 defined in amdgim
>   * v3 current
>   */
> -#define AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER                        2
> -#define AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER                        3
> +#define AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER 2
> +#define AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER 3
>
> -#define AMD_SRIOV_MSG_RESERVE_UCODE            24
> +#define AMD_SRIOV_MSG_RESERVE_UCODE 24
>
>  #define AMD_SRIOV_MSG_RESERVE_VCN_INST 4
>
> @@ -83,19 +82,19 @@ enum amd_sriov_ucode_engine_id {
>         AMD_SRIOV_UCODE_ID__MAX
>  };
>
> -#pragma pack(push, 1)  // PF2VF / VF2PF data areas are byte packed
> +#pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed
>
>  union amd_sriov_msg_feature_flags {
>         struct {
> -               uint32_t  error_log_collect  : 1;
> -               uint32_t  host_load_ucodes   : 1;
> -               uint32_t  host_flr_vramlost  : 1;
> -               uint32_t  mm_bw_management   : 1;
> -               uint32_t  pp_one_vf_mode     : 1;
> -               uint32_t  reg_indirect_acc   : 1;
> -               uint32_t  reserved           : 26;
> +               uint32_t error_log_collect : 1;
> +               uint32_t host_load_ucodes  : 1;
> +               uint32_t host_flr_vramlost : 1;
> +               uint32_t mm_bw_management  : 1;
> +               uint32_t pp_one_vf_mode    : 1;
> +               uint32_t reg_indirect_acc  : 1;
> +               uint32_t reserved          : 26;
>         } flags;
> -       uint32_t      all;
> +       uint32_t all;
>  };
>
>  union amd_sriov_reg_access_flags {
> @@ -110,10 +109,10 @@ union amd_sriov_reg_access_flags {
>
>  union amd_sriov_msg_os_info {
>         struct {
> -               uint32_t  windows            : 1;
> -               uint32_t  reserved           : 31;
> +               uint32_t windows  : 1;
> +               uint32_t reserved : 31;
>         } info;
> -       uint32_t      all;
> +       uint32_t all;
>  };
>
>  struct amd_sriov_msg_uuid_info {
> @@ -156,6 +155,7 @@ struct amd_sriov_msg_pf2vf_info_header {
>         uint32_t reserved[2];
>  };
>
> +#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (48)
>  struct amd_sriov_msg_pf2vf_info {
>         /* header contains size and version */
>         struct amd_sriov_msg_pf2vf_info_header header;
> @@ -204,10 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
>         } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>         /* UUID info */
>         struct amd_sriov_msg_uuid_info uuid_info;
> -       /* pcie atomic Ops info */
> -       uint32_t pcie_atomic_ops_enabled_flags;
> +       /* PCIE atomic ops support flag */
> +       uint32_t pcie_atomic_ops_support_flags;
>         /* reserved */
> -       uint32_t reserved[256 - 48];
> +       uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
>  };
>
>  struct amd_sriov_msg_vf2pf_info_header {
> @@ -219,12 +219,13 @@ struct amd_sriov_msg_vf2pf_info_header {
>         uint32_t reserved[2];
>  };
>
> +#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (70)
>  struct amd_sriov_msg_vf2pf_info {
>         /* header contains size and version */
>         struct amd_sriov_msg_vf2pf_info_header header;
>         uint32_t checksum;
>         /* driver version */
> -       uint8_t  driver_version[64];
> +       uint8_t driver_version[64];
>         /* driver certification, 1=WHQL, 0=None */
>         uint32_t driver_cert;
>         /* guest OS type and version */
> @@ -258,13 +259,14 @@ struct amd_sriov_msg_vf2pf_info {
>         uint32_t fb_size;
>         /* guest ucode data, each one is 1.25 Dword */
>         struct {
> -               uint8_t  id;
> +               uint8_t id;
>                 uint32_t version;
>         } ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
> +       /* dummy page addr */
>         uint64_t dummy_page_addr;
>
>         /* reserved */
> -       uint32_t reserved[256-70];
> +       uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
>  };
>
>  /* mailbox message send from guest to host  */
> @@ -276,7 +278,8 @@ enum amd_sriov_mailbox_request_message {
>         MB_REQ_MSG_REQ_GPU_RESET_ACCESS,
>         MB_REQ_MSG_REQ_GPU_INIT_DATA,
>
> -       MB_REQ_MSG_LOG_VF_ERROR       = 200,
> +       MB_REQ_MSG_LOG_VF_ERROR = 200,
> +       MB_REQ_MSG_READY_TO_RESET = 201,
>  };
>
>  /* mailbox message send from host to guest  */
> @@ -298,17 +301,15 @@ enum amd_sriov_gpu_init_data_version {
>         GPU_INIT_DATA_READY_V1 = 1,
>  };
>
> -#pragma pack(pop)      // Restore previous packing option
> +#pragma pack(pop) // Restore previous packing option
>
>  /* checksum function between host and guest */
> -unsigned int amd_sriov_msg_checksum(void *obj,
> -                               unsigned long obj_size,
> -                               unsigned int key,
> -                               unsigned int checksum);
> +unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned int key,
> +                                   unsigned int checksum);
>
>  /* assertion at compile time */
>  #ifdef __linux__
> -#define stringification(s) _stringification(s)
> +#define stringification(s)  _stringification(s)
>  #define _stringification(s) #s
>
>  _Static_assert(
> @@ -319,13 +320,11 @@ _Static_assert(
>         sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
>         "amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
>
> -_Static_assert(
> -       AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
> -       "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
> +_Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
> +              "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
>
> -_Static_assert(
> -       AMD_SRIOV_MSG_RESERVE_UCODE > AMD_SRIOV_UCODE_ID__MAX,
> -       "AMD_SRIOV_MSG_RESERVE_UCODE must be bigger than AMD_SRIOV_UCODE_ID__MAX");
> +_Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE > AMD_SRIOV_UCODE_ID__MAX,
> +              "AMD_SRIOV_MSG_RESERVE_UCODE must be bigger than AMD_SRIOV_UCODE_ID__MAX");
>
>  #undef _stringification
>  #undef stringification
> --
> 2.25.1
>
