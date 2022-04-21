Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42A3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 17:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560FC10E44B;
	Thu, 21 Apr 2022 17:07:27 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4666C10E44B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 17:07:26 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id r85so6272604oie.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Brtxk4BN8osmeZ8VDpunDYIjJrToxFrwE6MnByANWR0=;
 b=JNAWiA60vw8L0f1dkB9Jx28MUMeb3PwJF6uhf9imf5/oKEk3ANrHp7VJiWSbPuXjg/
 Fk25lmGBfLUCLeTzR872Drqc4JmOaug2SYWwYoky7SBxzt77RrBb7Z3gMiddgoeVoyFu
 Bnuy6Qc2bZiNsPV3SmZy1fOfea3XUXP1BHFV0ERTs/tdsHCAxa+rfgAAtBOTIdq1egU9
 jBlLuSdXF/CwkXbABBs3/Ma1tbOLwaPRtomKJTzkG6ZsM+LKxSSfST9SNULzzGn0cb/q
 iZ3hBM5jPpxn0VeIxTLvf8lMOpF6ygxSJXV+dlVE14JiNSLd4wUndOWkRNDRbyXsmDZn
 1Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Brtxk4BN8osmeZ8VDpunDYIjJrToxFrwE6MnByANWR0=;
 b=cpC+HiiKNujVujOnU+5EQHJvmJnsCtdVCztg7COMbkeZ+lKgOsreXlT2tthfAjogU5
 rzOkE1Cpaw4656cidXDBG+knjvG9WMzrv0qy5cG5CccRxKt0ZgBezrK8XRPlfxy7HXyH
 qkoQHpNdBI60WM3sQxYLgQiBTvXbaU2af2H0OR0wx87yAdcdV636jXaHWVxYJb1mM7cl
 +BmdDFOPK4YV3umPmjwGGbKrMZRLnZIHTl5ZN++qlo0Bw/hWP1sj7cD3CqG9YsS7DoNl
 DLk8CgoXwoSOrmcTaage1cOqHN0vApy+VFPQ0cauAUS6dYWCWpxpnzf3x3lUSJruEqME
 /PRw==
X-Gm-Message-State: AOAM530F7RC6ByUuAWRDXc4V/MV6ADgdRfTolTzelt+o2Eg/sV4W8EGp
 Gde1YapVutm4INHxcDUzZC9aE7EsXaPA/34D7xZkLRYa
X-Google-Smtp-Source: ABdhPJzJqWo2OHTTVoT61TCq0LS31HCntqKzalNz+ltkLGpKXZi6Lo1rSz24K/GVlvon1ga7QXv+u8CGYiu+QVVbTR0=
X-Received: by 2002:aca:3d88:0:b0:321:141:ce0b with SMTP id
 k130-20020aca3d88000000b003210141ce0bmr4449741oia.200.1650560845425; Thu, 21
 Apr 2022 10:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220420224723.275053-1-Bokun.Zhang@amd.com>
In-Reply-To: <20220420224723.275053-1-Bokun.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Apr 2022 13:07:13 -0400
Message-ID: <CADnq5_NeiGaxBdKHtxPm01Osj+inwSJBJOvQe+YDHXr8hM3-NQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] drm/amd/amdgpu: Properly indent PF2VF header
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

On Wed, Apr 20, 2022 at 6:47 PM Bokun Zhang <Bokun.Zhang@amd.com> wrote:
>
> - Clean up the identation in the header file
>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 70 ++++++++++-----------
>  1 file changed, 34 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 059be32638ac..65433cbb00c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -24,10 +24,10 @@
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
> @@ -50,10 +50,10 @@
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
> @@ -82,19 +82,19 @@ enum amd_sriov_ucode_engine_id {
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
> @@ -109,10 +109,10 @@ union amd_sriov_reg_access_flags {
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
> @@ -203,7 +203,7 @@ struct amd_sriov_msg_pf2vf_info {
>         } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>         /* UUID info */
>         struct amd_sriov_msg_uuid_info uuid_info;
> -       /* pcie atomic Ops info */
> +       /* PCIE atomic ops support flag */
>         uint32_t pcie_atomic_ops_enabled_flags;
>         /* reserved */
>         uint32_t reserved[256 - 48];
> @@ -223,7 +223,7 @@ struct amd_sriov_msg_vf2pf_info {
>         struct amd_sriov_msg_vf2pf_info_header header;
>         uint32_t checksum;
>         /* driver version */
> -       uint8_t  driver_version[64];
> +       uint8_t driver_version[64];
>         /* driver certification, 1=WHQL, 0=None */
>         uint32_t driver_cert;
>         /* guest OS type and version */
> @@ -257,13 +257,14 @@ struct amd_sriov_msg_vf2pf_info {
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
> +       uint32_t reserved[256 - 70];
>  };
>
>  /* mailbox message send from guest to host  */
> @@ -275,7 +276,8 @@ enum amd_sriov_mailbox_request_message {
>         MB_REQ_MSG_REQ_GPU_RESET_ACCESS,
>         MB_REQ_MSG_REQ_GPU_INIT_DATA,
>
> -       MB_REQ_MSG_LOG_VF_ERROR       = 200,
> +       MB_REQ_MSG_LOG_VF_ERROR = 200,
> +       MB_REQ_MSG_READY_TO_RESET = 201,

This addition should be in patch 3.  With that fixed, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>  };
>
>  /* mailbox message send from host to guest  */
> @@ -297,17 +299,15 @@ enum amd_sriov_gpu_init_data_version {
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
> @@ -318,13 +318,11 @@ _Static_assert(
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
