Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5742AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 08:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087D510E49B;
	Tue, 15 Mar 2022 08:25:32 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA9010E4A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 08:25:30 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae8f9.dynamic.kabel-deutschland.de
 [95.90.232.249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CE48061EA1928;
 Tue, 15 Mar 2022 09:25:28 +0100 (CET)
Message-ID: <74fdfd78-1c2a-57e6-c97b-6cc166ab4f62@molgen.mpg.de>
Date: Tue, 15 Mar 2022 09:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 01/12] drm/amd/display: Add I2C escape to support query
 device exist.
Content-Language: en-US
To: Agustin Gutierrez <agustin.gutierrez@amd.com>, JinZe Xu <JinZe.Xu@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
 <20220310222045.664867-2-agustin.gutierrez@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220310222045.664867-2-agustin.gutierrez@amd.com>
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Augustin,


Am 10.03.22 um 23:20 schrieb Agustin Gutierrez:
> From: "JinZe.Xu" <JinZe.Xu@amd.com>

Please remove the dot/period and use Jin Ze Xu.

Also please remove the dot/period at the end of the git commit message 
summary.

> [How]
> 1. Search OEM I2C info from BIOS and compare with input parameter.
> 2. If BIOS doesn't record it, just try to read one byte.

Please describe the problem in more detail.

> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
> Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>

Ditto.

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c     | 13 ++++++++++
>   drivers/gpu/drm/amd/display/dc/dc_link.h     |  5 ++++
>   drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c | 26 ++++++++++++++++++++
>   drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h |  6 +++++
>   4 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 01b5996fa3aa..f6e19efea756 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3363,6 +3363,19 @@ bool dc_is_dmcu_initialized(struct dc *dc)
>   	return false;
>   }
>   
> +bool dc_is_oem_i2c_device_present(
> +	struct dc *dc,
> +	size_t slave_address)
> +{
> +	if (dc->res_pool->oem_device)
> +		return dce_i2c_oem_device_present(
> +			dc->res_pool,
> +			dc->res_pool->oem_device,
> +			slave_address);
> +
> +	return false;
> +}
> +
>   bool dc_submit_i2c(
>   		struct dc *dc,
>   		uint32_t link_index,
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index 78e66e4bab5a..aa818bf840eb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -466,6 +466,11 @@ const struct dc_link_settings *dc_link_get_link_cap(
>   void dc_link_overwrite_extended_receiver_cap(
>   		struct dc_link *link);
>   
> +bool dc_is_oem_i2c_device_present(
> +	struct dc *dc,
> +	size_t slave_address
> +);
> +
>   bool dc_submit_i2c(
>   		struct dc *dc,
>   		uint32_t link_index,
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
> index dd41736bb5c4..f5cd2392fc5f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
> @@ -25,6 +25,32 @@
>   #include "dce_i2c.h"
>   #include "reg_helper.h"
>   
> +bool dce_i2c_oem_device_present(
> +	struct resource_pool *pool,
> +	struct ddc_service *ddc,
> +	size_t slave_address
> +)
> +{
> +	struct dc *dc = ddc->ctx->dc;
> +	struct dc_bios *dcb = dc->ctx->dc_bios;
> +	struct graphics_object_id id = {0};
> +	struct graphics_object_i2c_info i2c_info;
> +
> +	if (!dc->ctx->dc_bios->fw_info.oem_i2c_present)
> +		return false;
> +
> +	id.id = dc->ctx->dc_bios->fw_info.oem_i2c_obj_id;
> +	id.enum_id = 0;
> +	id.type = OBJECT_TYPE_GENERIC;
> +	if (dcb->funcs->get_i2c_info(dcb, id, &i2c_info) != BP_RESULT_OK)
> +		return false;
> +
> +	if (i2c_info.i2c_slave_address != slave_address)
> +		return false;
> +
> +	return true;
> +}
> +
>   bool dce_i2c_submit_command(
>   	struct resource_pool *pool,
>   	struct ddc *ddc,
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h
> index a171c5cd8439..535fd58de450 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h
> @@ -30,6 +30,12 @@
>   #include "dce_i2c_hw.h"
>   #include "dce_i2c_sw.h"
>   
> +bool dce_i2c_oem_device_present(
> +	struct resource_pool *pool,
> +	struct ddc_service *ddc,
> +	size_t slave_address
> +);
> +
>   bool dce_i2c_submit_command(
>   	struct resource_pool *pool,
>   	struct ddc *ddc,
