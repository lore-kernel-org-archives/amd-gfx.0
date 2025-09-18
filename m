Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338ABCA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FDC10E8F6;
	Thu, 18 Sep 2025 20:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lI0y0FqH";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B50310E8F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:25:42 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-269ba651d06so508105ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758227141; x=1758831941; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGQFNpJZheiZMY5yZbpPMhMSjJCU2Qh87KQ2moH0PwM=;
 b=lI0y0FqHVlKH7gCJzADfnI3v4oUzmCjKSRl0Uir5hN1XcUmC1g6BaeH+S/kUb6E7cB
 BBdKqOxXTJRe9D/jEeKiKDi5c4xlMKwj1P1PuU6f9TKbM+nTKxt9S1sFh9+6DzNp2k79
 o1wzuMETc8Yp2klWcCkMiL410N3qKNyqlunPYdiXfFWnOjVpEgo1i71em3J8WxhTBicW
 k6rp6rw35VoOiSeBZxnmfMltpWu2uzIhd0oYCKuDIh5qNCAK8IU3ICCf8ReVI9g+8C0S
 g4lwnhp4cpsgeVtuLcoNINluPf0iUjtkLOACfgFZLpZI9pqQgKZAjVq8mUYRXl89HoLg
 tJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758227141; x=1758831941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGQFNpJZheiZMY5yZbpPMhMSjJCU2Qh87KQ2moH0PwM=;
 b=mhS3Sly0DZplamx2VnFKrbojS/9rPrVTgnbpotq2AQ9JDK3k3YnkbKNUNPK5Q/hbAY
 TJXdNpWB6bExObH5XEW9snIZNlqyB78MbJXBFjmfO0duGoqQFTiE/LQnSuKrLLljU8Nk
 JFVl/BnoxRaDnHzvYj5vWjJM66r964q9ED2+eJ/OmYud/G9bH1oZJbDIAxUZWbQ4X46w
 Uetr7t/kkOpHcdzNr3wuIyZUFln8m3KIoCkdWuLeobq+52meHphYxvYoOInaA3LrQiV4
 kQfcl4kTQDlTGhBaRX+wA94OmV145YVq0Sjo8qSfCUjKrq/dQFVmCYTuReUh7Bq8v8Xc
 PbKg==
X-Gm-Message-State: AOJu0Yz/HMZvP3Eb0k6mZdCyK9OTra/i9ThPBjC7WAF9cVQjiNV1Hoqq
 dWx/WcvkkvB4VeFSOlVdd/nTMJuIoN6xTxgwyFegaxXldgItttNUFjQrmcjeHggZc5eSBO50Je2
 hPLg1qt6QH3jr0DhsMZ6aJ90syR6rUh4=
X-Gm-Gg: ASbGncssILHHf24S6omHcIkDQ9QRGpUi6ND9WUxEVGibTtQ080BLlQV2p7Lcm+n+eWh
 WhJ1n5UZ39dZL27cmnQtq0Q7P3ngK7wrU2g5KlRXs/8DSLlOkwUXcWjvnqHBWWVsFsX6PKswIOL
 8aI+V37xZijcraXj0RfX/HsJWLFqdkl61Gdpineb/UoJIqFc6/7/MvY5wVo1S+4Nhoj63TckcFW
 WK8jgI2y/JO+YlnyJRn/RLnLA==
X-Google-Smtp-Source: AGHT+IENI8yqihDL36UR1KxekgCFtuIXijEEw1mgLVmbYpr0t4lkx7ulqeAQVbHn34UF4WRIAZgiiM3u+9vliHFGsDI=
X-Received: by 2002:a17:902:f904:b0:261:500a:5742 with SMTP id
 d9443c01a7336-269ba547cc5mr4143715ad.10.1758227141494; Thu, 18 Sep 2025
 13:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
 <20250918013507.2629620-5-YiPeng.Chai@amd.com>
In-Reply-To: <20250918013507.2629620-5-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:25:29 -0400
X-Gm-Features: AS18NWBEQulXazq3LPrkr83BLyYw1SKt_fTT9OC5bRCxjm8JqRqejACNEuFG6MM
Message-ID: <CADnq5_NVYYq9Lb0_89N+-qu7vUuJ8gtoZsyjM3nUr=8aSRwrxA@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/amd/ras: Amdgpu handle ras ioctl command
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Candice.Li@amd.com, Stanley.Yang@amd.com
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

On Wed, Sep 17, 2025 at 9:36=E2=80=AFPM YiPeng Chai <YiPeng.Chai@amd.com> w=
rote:
>
> Amdgpu handle ras ioctl command.

Where is the actual IOCTL interface defined?

Alex

>
> V2:
>   Remove non-standard device information.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 363 ++++++++++++++++++
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h  |  55 +++
>  2 files changed, 418 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
>  create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/g=
pu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> new file mode 100644
> index 000000000000..195ca51a96d5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include "amdgpu.h"
> +#include "amdgpu_ras.h"
> +#include "ras_sys.h"
> +#include "amdgpu_ras_cmd.h"
> +#include "amdgpu_ras_mgr.h"
> +
> +/* inject address is 52 bits */
> +#define        RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
> +
> +#define AMDGPU_RAS_TYPE_RASCORE  0x1
> +#define AMDGPU_RAS_TYPE_AMDGPU   0x2
> +#define AMDGPU_RAS_TYPE_VF       0x3
> +
> +static int amdgpu_ras_query_interface_info(struct ras_core_context *ras_=
core,
> +                       struct ras_cmd_ioctl *cmd)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct ras_query_interface_info_rsp *output_data =3D
> +               (struct ras_query_interface_info_rsp *)cmd->output_buff_r=
aw;
> +       int ret;
> +
> +       if (cmd->input_size !=3D sizeof(struct ras_query_interface_info_r=
eq))
> +               return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
> +
> +       ret =3D ras_cmd_query_interface_info(ras_core, output_data);
> +       if (!ret) {
> +               output_data->plat_major_ver =3D 0;
> +               output_data->plat_minor_ver =3D 0;
> +
> +               output_data->interface_type =3D amdgpu_sriov_vf(adev) ?
> +                       RAS_CMD_INTERFACE_TYPE_VF : RAS_CMD_INTERFACE_TYP=
E_AMDGPU;
> +
> +               cmd->output_size =3D sizeof(struct ras_query_interface_in=
fo_rsp);
> +       }
> +
> +       return ret;
> +}
> +
> +static struct ras_core_context *ras_cmd_get_ras_core(uint64_t dev_handle=
)
> +{
> +       struct ras_core_context *ras_core;
> +
> +       if (!dev_handle || (dev_handle =3D=3D RAS_CMD_DEV_HANDLE_MAGIC))
> +               return NULL;
> +
> +       ras_core =3D (struct ras_core_context *)(dev_handle ^ RAS_CMD_DEV=
_HANDLE_MAGIC);
> +
> +       if (ras_cmd_get_dev_handle(ras_core) =3D=3D dev_handle)
> +               return ras_core;
> +
> +       return NULL;
> +}
> +
> +static int amdgpu_ras_get_devices_info(struct ras_core_context *ras_core=
,
> +                       struct ras_cmd_ioctl *cmd)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct ras_cmd_devices_info_rsp *output_data =3D
> +                       (struct ras_cmd_devices_info_rsp *)cmd->output_bu=
ff_raw;
> +       struct ras_cmd_dev_info *dev_info;
> +
> +       dev_info =3D &output_data->devs[0];
> +       dev_info->dev_handle =3D ras_cmd_get_dev_handle(ras_core);
> +       dev_info->oam_id =3D adev->smuio.funcs->get_socket_id(adev);
> +       dev_info->ecc_enabled =3D 1;
> +       dev_info->ecc_supported =3D 1;
> +
> +       output_data->dev_num =3D 1;
> +       output_data->version =3D 0;
> +       cmd->output_size =3D sizeof(struct ras_cmd_devices_info_rsp);
> +
> +       return 0;
> +}
> +
> +static int amdgpu_ras_trigger_error_prepare(struct ras_core_context *ras=
_core,
> +                       struct ras_cmd_inject_error_req *block_info)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       int ret;
> +
> +       if (block_info->block_id =3D=3D TA_RAS_BLOCK__XGMI_WAFL) {
> +               if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> +                       RAS_DEV_WARN(adev, "Failed to disallow df cstate"=
);
> +
> +               ret =3D amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_=
PLPD, XGMI_PLPD_DISALLOW);
> +               if (ret && (ret !=3D -EOPNOTSUPP))
> +                       RAS_DEV_WARN(adev, "Failed to disallow XGMI power=
 down");
> +       }
> +
> +       return 0;
> +}
> +
> +static int amdgpu_ras_trigger_error_end(struct ras_core_context *ras_cor=
e,
> +                       struct ras_cmd_inject_error_req *block_info)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       int ret;
> +
> +       if (block_info->block_id =3D=3D TA_RAS_BLOCK__XGMI_WAFL) {
> +               if (amdgpu_ras_intr_triggered())
> +                       return 0;
> +
> +               ret =3D amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_=
PLPD, XGMI_PLPD_DEFAULT);
> +               if (ret && (ret !=3D -EOPNOTSUPP))
> +                       RAS_DEV_WARN(adev, "Failed to allow XGMI power do=
wn");
> +
> +               if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
> +                       RAS_DEV_WARN(adev, "Failed to allow df cstate");
> +       }
> +
> +       return 0;
> +}
> +
> +static uint64_t local_addr_to_xgmi_global_addr(struct ras_core_context *=
ras_core,
> +                                          uint64_t addr)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct amdgpu_xgmi *xgmi =3D &adev->gmc.xgmi;
> +
> +       return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
> +}
> +
> +static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
> +                       struct ras_cmd_ioctl *cmd, void *data)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct ras_cmd_inject_error_req *req =3D
> +               (struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
> +       int ret =3D RAS_CMD__ERROR_GENERIC;
> +
> +       if (req->block_id =3D=3D RAS_BLOCK_ID__UMC) {
> +               if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)=
) {
> +                       RAS_DEV_WARN(ras_core->dev,
> +                               "RAS WARN: inject: 0x%llx has already bee=
n marked as bad!\n",
> +                               req->address);
> +                       return RAS_CMD__ERROR_ACCESS_DENIED;
> +               }
> +
> +               if ((req->address >=3D adev->gmc.mc_vram_size &&
> +                       adev->gmc.mc_vram_size) ||
> +                       (req->address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
> +                       RAS_DEV_WARN(adev, "RAS WARN: input address 0x%ll=
x is invalid.",
> +                                       req->address);
> +                       return RAS_CMD__ERROR_INVALID_INPUT_DATA;
> +               }
> +
> +               /* Calculate XGMI relative offset */
> +               if (adev->gmc.xgmi.num_physical_nodes > 1 &&
> +                       req->block_id !=3D RAS_BLOCK_ID__GFX) {
> +                       req->address =3D local_addr_to_xgmi_global_addr(r=
as_core, req->address);
> +               }
> +       }
> +
> +       amdgpu_ras_trigger_error_prepare(ras_core, req);
> +       ret =3D rascore_handle_cmd(ras_core, cmd, data);
> +       amdgpu_ras_trigger_error_end(ras_core, req);
> +       if (ret) {
> +               RAS_DEV_ERR(adev, "ras inject block %u failed %d\n", req-=
>block_id, ret);
> +               ret =3D RAS_CMD__ERROR_ACCESS_DENIED;
> +       }
> +
> +
> +       return ret;
> +}
> +
> +static int amdgpu_ras_get_ras_safe_fb_addr_ranges(struct ras_core_contex=
t *ras_core,
> +       struct ras_cmd_ioctl *cmd, void *data)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct ras_cmd_dev_handle *input_data =3D
> +                       (struct ras_cmd_dev_handle *)cmd->input_buff_raw;
> +       struct ras_cmd_ras_safe_fb_address_ranges_rsp *ranges =3D
> +                       (struct ras_cmd_ras_safe_fb_address_ranges_rsp *)=
cmd->output_buff_raw;
> +       struct amdgpu_mem_partition_info *mem_ranges;
> +       uint32_t i =3D 0;
> +
> +       if (cmd->input_size !=3D sizeof(*input_data))
> +               return RAS_CMD__ERROR_INVALID_INPUT_DATA;
> +
> +       mem_ranges =3D adev->gmc.mem_partitions;
> +       for (i =3D 0; i < adev->gmc.num_mem_partitions; i++) {
> +               ranges->range[i].start =3D mem_ranges[i].range.fpfn << AM=
DGPU_GPU_PAGE_SHIFT;
> +               ranges->range[i].size =3D mem_ranges[i].size;
> +               ranges->range[i].idx =3D i;
> +       }
> +
> +       ranges->num_ranges =3D adev->gmc.num_mem_partitions;
> +
> +       ranges->version =3D 0;
> +       cmd->output_size =3D sizeof(struct ras_cmd_ras_safe_fb_address_ra=
nges_rsp);
> +
> +       return RAS_CMD__SUCCESS;
> +}
> +
> +static int ras_translate_fb_address(struct ras_core_context *ras_core,
> +               enum ras_fb_addr_type src_type,
> +               enum ras_fb_addr_type dest_type,
> +               union ras_translate_fb_address *src_addr,
> +               union ras_translate_fb_address *dest_addr)
> +{
> +       uint64_t soc_phy_addr;
> +       int ret =3D RAS_CMD__SUCCESS;
> +
> +       /* Does not need to be queued as event as this is a SW translatio=
n */
> +       switch (src_type) {
> +       case RAS_FB_ADDR_SOC_PHY:
> +               soc_phy_addr =3D src_addr->soc_phy_addr;
> +               break;
> +       case RAS_FB_ADDR_BANK:
> +               ret =3D ras_cmd_translate_bank_to_soc_pa(ras_core,
> +                                       src_addr->bank_addr, &soc_phy_add=
r);
> +               if (ret)
> +                       return RAS_CMD__ERROR_GENERIC;
> +               break;
> +       default:
> +               return RAS_CMD__ERROR_INVALID_CMD;
> +       }
> +
> +       switch (dest_type) {
> +       case RAS_FB_ADDR_SOC_PHY:
> +               dest_addr->soc_phy_addr =3D soc_phy_addr;
> +               break;
> +       case RAS_FB_ADDR_BANK:
> +               ret =3D ras_cmd_translate_soc_pa_to_bank(ras_core,
> +                               soc_phy_addr, &dest_addr->bank_addr);
> +               if (ret)
> +                       return RAS_CMD__ERROR_GENERIC;
> +               break;
> +       default:
> +               return RAS_CMD__ERROR_INVALID_CMD;
> +       }
> +
> +       return ret;
> +}
> +
> +static int amdgpu_ras_translate_fb_address(struct ras_core_context *ras_=
core,
> +                               struct ras_cmd_ioctl *cmd, void *data)
> +{
> +       struct ras_cmd_translate_fb_address_req *req_buff =3D
> +                       (struct ras_cmd_translate_fb_address_req *)cmd->i=
nput_buff_raw;
> +       struct ras_cmd_translate_fb_address_rsp *rsp_buff =3D
> +                       (struct ras_cmd_translate_fb_address_rsp *)cmd->o=
utput_buff_raw;
> +       int ret =3D RAS_CMD__ERROR_GENERIC;
> +
> +       if (cmd->input_size !=3D sizeof(struct ras_cmd_translate_fb_addre=
ss_req))
> +               return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
> +
> +       if ((req_buff->src_addr_type >=3D RAS_FB_ADDR_UNKNOWN) ||
> +           (req_buff->dest_addr_type >=3D RAS_FB_ADDR_UNKNOWN))
> +               return RAS_CMD__ERROR_INVALID_INPUT_DATA;
> +
> +       ret =3D ras_translate_fb_address(ras_core, req_buff->src_addr_typ=
e,
> +                       req_buff->dest_addr_type, &req_buff->trans_addr, =
&rsp_buff->trans_addr);
> +       if (ret)
> +               return RAS_CMD__ERROR_GENERIC;
> +
> +       rsp_buff->version =3D 0;
> +       cmd->output_size =3D sizeof(struct ras_cmd_translate_fb_address_r=
sp);
> +
> +       return RAS_CMD__SUCCESS;
> +}
> +
> +static struct ras_cmd_func_map amdgpu_ras_cmd_maps[] =3D {
> +       {RAS_CMD__INJECT_ERROR, amdgpu_ras_inject_error},
> +       {RAS_CMD__GET_SAFE_FB_ADDRESS_RANGES, amdgpu_ras_get_ras_safe_fb_=
addr_ranges},
> +       {RAS_CMD__TRANSLATE_FB_ADDRESS, amdgpu_ras_translate_fb_address},
> +};
> +
> +int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_=
cmd_ioctl *cmd, void *data)
> +{
> +       struct ras_cmd_func_map *ras_cmd =3D NULL;
> +       int i, res;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(amdgpu_ras_cmd_maps); i++) {
> +               if (cmd->cmd_id =3D=3D amdgpu_ras_cmd_maps[i].cmd_id) {
> +                       ras_cmd =3D &amdgpu_ras_cmd_maps[i];
> +                       break;
> +               }
> +       }
> +
> +       if (ras_cmd)
> +               res =3D ras_cmd->func(ras_core, cmd, NULL);
> +       else
> +               res =3D RAS_CMD__ERROR_UKNOWN_CMD;
> +
> +       return res;
> +}
> +
> +int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
> +                       uint8_t *cmd_buf, uint32_t buf_size)
> +{
> +       struct ras_cmd_ioctl *cmd =3D (struct ras_cmd_ioctl *)cmd_buf;
> +       struct ras_core_context *cmd_core =3D NULL;
> +       struct ras_cmd_dev_handle *cmd_handle =3D NULL;
> +       int timeout =3D 60;
> +       int res;
> +
> +       cmd->cmd_res =3D RAS_CMD__ERROR_INVALID_CMD;
> +       cmd->output_size =3D 0;
> +
> +       if (!ras_core_is_enabled(ras_core))
> +               return RAS_CMD__ERROR_ACCESS_DENIED;
> +
> +       if (cmd->cmd_id =3D=3D RAS_CMD__QUERY_INTERFACE_INFO) {
> +               cmd->cmd_res =3D amdgpu_ras_query_interface_info(ras_core=
, cmd);
> +       } else if (cmd->cmd_id =3D=3D RAS_CMD__GET_DEVICES_INFO) {
> +               cmd->cmd_res =3D amdgpu_ras_get_devices_info(ras_core, cm=
d);
> +       } else {
> +               cmd_handle =3D (struct ras_cmd_dev_handle *)cmd->input_bu=
ff_raw;
> +               cmd_core =3D ras_cmd_get_ras_core(cmd_handle->dev_handle)=
;
> +               if (!cmd_core)
> +                       return RAS_CMD__ERROR_INVALID_INPUT_DATA;
> +
> +               while (ras_core_gpu_in_reset(cmd_core)) {
> +                       msleep(1000);
> +                       if (!timeout--)
> +                               return RAS_CMD__ERROR_TIMEOUT;
> +               }
> +
> +
> +               if (!ras_core_is_enabled(cmd_core))
> +                       return RAS_CMD__ERROR_ACCESS_DENIED;
> +
> +               res =3D amdgpu_ras_handle_cmd(cmd_core, cmd, NULL);
> +               if (res =3D=3D RAS_CMD__ERROR_UKNOWN_CMD)
> +                       res =3D rascore_handle_cmd(cmd_core, cmd, NULL);
> +
> +               cmd->cmd_res =3D res;
> +       }
> +
> +       if ((cmd->cmd_res =3D=3D RAS_CMD__SUCCESS) &&
> +           ((cmd->output_size + sizeof(*cmd)) > buf_size)) {
> +               RAS_INFO("Insufficient command buffer size 0x%x!\n", buf_=
size);
> +               return RAS_CMD__SUCCESS_EXEED_BUFFER;
> +       }
> +
> +       return RAS_CMD__SUCCESS;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h b/drivers/g=
pu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
> new file mode 100644
> index 000000000000..7017198f1bac
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef __AMDGPU_RAS_CMD_H__
> +#define __AMDGPU_RAS_CMD_H__
> +#include "ras.h"
> +
> +enum amdgpu_ras_cmd_id {
> +       RAS_CMD__AMDGPU_BEGIN =3D RAS_CMD_ID_AMDGPU_START,
> +       RAS_CMD__TRANSLATE_MEMORY_FD,
> +       RAS_CMD__AMDGPU_SUPPORTED_MAX =3D RAS_CMD_ID_AMDGPU_END,
> +};
> +
> +struct ras_cmd_translate_memory_fd_req {
> +       struct ras_cmd_dev_handle dev;
> +       uint32_t type;
> +       uint32_t fd;
> +       uint64_t address;
> +       uint32_t reserved[4];
> +};
> +
> +struct ras_cmd_translate_memory_fd_rsp {
> +       uint32_t version;
> +       uint32_t padding;
> +       uint64_t start;
> +       uint64_t size;
> +       uint32_t reserved[2];
> +};
> +
> +int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core,
> +               struct ras_cmd_ioctl *cmd, void *data);
> +int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
> +                       uint8_t *cmd_buf, uint32_t buf_size);
> +
> +#endif
> --
> 2.34.1
>
