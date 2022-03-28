Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6737DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C0110E15F;
	Mon, 28 Mar 2022 06:40:15 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA39810E15F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:40:13 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5C08A61EA1928;
 Mon, 28 Mar 2022 08:40:12 +0200 (CEST)
Message-ID: <131a6ab7-916e-cd2d-eed3-2e563efcd466@molgen.mpg.de>
Date: Mon, 28 Mar 2022 08:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/6] drm/amdgpu/vcn: Add vcn ras support
Content-Language: en-US
To: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-3-Mohammadzafar.ziya@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220328062453.4156191-3-Mohammadzafar.ziya@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: lijo.lazar@amd.com, Tao.Zhou1@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Mohammad,


Thank you for your patch.

Am 28.03.22 um 08:24 schrieb Mohammad Zafar Ziya:
> VCN block ras feature support addition
> 
> V2: default ras callback removed
> 
> Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e2fde88aaf5e..ea07974ef6f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -24,6 +24,8 @@
>   #ifndef __AMDGPU_VCN_H__
>   #define __AMDGPU_VCN_H__
>   
> +#include "amdgpu_ras.h"
> +
>   #define AMDGPU_VCN_STACK_SIZE		(128*1024)
>   #define AMDGPU_VCN_CONTEXT_SIZE 	(512*1024)
>   
> @@ -232,6 +234,10 @@ struct amdgpu_vcn_inst {
>   	struct amdgpu_vcn_fw_shared fw_shared;
>   };
>   
> +struct amdgpu_vcn_ras {
> +	struct amdgpu_ras_block_object ras_block;
> +};
> +
>   struct amdgpu_vcn {
>   	unsigned		fw_version;
>   	struct delayed_work	idle_work;
> @@ -251,6 +257,9 @@ struct amdgpu_vcn {
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,
>   		int inst_idx, struct dpg_pause_state *new_state);
> +
> +	struct ras_common_if    *ras_if;
> +	struct amdgpu_vcn_ras   *ras;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {
> @@ -339,4 +348,5 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
>   void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
>   void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
>                                      uint8_t i, struct amdgpu_vcn_inst *vcn);
> +
>   #endif

This hunk looks unrelated. Maybe remove it?


Kind regards,

Paul
