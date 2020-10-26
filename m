Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DB7C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389FC2463C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H5NnUFVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389FC2463C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B356EA0A;
	Mon, 26 Oct 2020 13:58:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6E06EA0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 13:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMTSaDtMJzL5EytDDsWUj0jt0v6MDvrNlkq/MwiY5uqlrZ0Jhhc3meay613bc7r3KC/KstKgBhcc53otU7P/WXZNfiiluBCzz5i4RJa3yGpwRyTqtC5/N1jyZc7YjckQ7eDuXYFcidxIHxUSKXMG/Wzs0IwPLiZQWmtU8ZAaZpdpZYle33J5OjWgZ58K4X3h+VIkPKqVG3vVDBVZQAM1wJjJfTf/VGrXrhE4WCbFHKJABBW9Up3C9Kja8f5Lazw7mw4Bgy2piqps429NAGCg0pFmQgl1mX/UT9OhxueDw6B6S2Bp/DX0YbKz5dnWF1fzHHcNoQkeCuxRlxosBxI+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq2XJUIAQZsJmOSrl0vSxm6sFBd7ZqSzFiAVOtpa32A=;
 b=HFqXr+d8vlDdakF7TbPzwZxPtA3rg65npRdyt5A6e/kuP3T3XJU10EZyhttL5UnvO4PJMzciKbwT91cHgLhXE6mCnxGNrTu6bca4krk9H7ou8JnKWFYIhARUN4h01ZfM0gpQmJGYmaySMYxKVfumHDnl7ZA/Voul7i8bpJMTotvjc1NLw8v5JboG8QfkgpQh4kSXXxnEfnhfJJthiYbme1+ZZ8acxUwvLISqw7kTTxz4A3nhARu8TIefZs8GrEBy6rPYf+GnaoE9IMMBNUAnqWJFoz7O2AAs+NBJgd9x7pv5Gq4NZT3y8HXOiuWHS85iSrP9//ga0zBjY8xPVox7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq2XJUIAQZsJmOSrl0vSxm6sFBd7ZqSzFiAVOtpa32A=;
 b=H5NnUFVPBLPKlObGIADG2Z9PJMvuU6qo8phkeyC97GMrgg6q7+h1rth9vdacKEjhR/sd4hdotcgh0hyo7OJL3RsCLlG1RfrpNPgTkrXTgD4ZDe2kCtfFgKzqe1tIZ/vXyTIFHq0hzD/kT2HkKe7Y+jrEmtm30snj3a/Sobkd12Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 13:58:23 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 13:58:23 +0000
Subject: Re: [PATCH v3 07/11] drm/amd/display: Refactor surface tiling setup.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
 <20201021233130.874615-8-bas@basnieuwenhuizen.nl>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <50e4b87a-cbdb-fa82-b749-122bc35d28c1@amd.com>
Date: Mon, 26 Oct 2020 09:58:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201021233130.874615-8-bas@basnieuwenhuizen.nl>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 13:58:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed14ec86-81ad-4fa6-b0fa-08d879b73423
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB43066F24F50C5622FE586997EC190@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+0MiruLHMe/TIUoMEBIKtMPA1dOl8v9cthxMeLcILcIJPknjZDrlkPnGF7wID+RyS7wNDH43yr+kpHsV3znRG9qWCqfs7R+4iJjzY/JaMXFR+tHkxjcXlzstk+n7SMN6XWuJuUqS2L+B8nc2fdG+RnPuqePr/6Y2nPh5mhSt1QOEGqwA9t6g9xQAlxHu0nu15qBWOpgZ5HNx5zRcFwPLRvDqK8Z8q9pHFXdOy9ONmA57H+wKLgQj2Yp4gNQHhqLjcTyhFDQGQ6wwOu4+iKX6NME+9DThWtZb4jYOWaqXnhS7E/A7bDS8TtUW/RQhERfcXgfCyplqUUU8EhiAzQdWxHzTSw1ndOS3cJdpV+KDdqDoRoblvnis3fRRYAsI0LuHRR31onDWk7jmfcLONTBzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(186003)(36756003)(4001150100001)(26005)(66556008)(16576012)(66946007)(5660300002)(16526019)(86362001)(316002)(66476007)(4326008)(52116002)(30864003)(31696002)(956004)(2616005)(6666004)(53546011)(478600001)(2906002)(8676002)(8936002)(83380400001)(6486002)(31686004)(21314003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0tMLLj+a5jSwbGtuKGS0iGu+6sY8HZp9T8lwvNJQ77sftcqK3AR0v6YDrnqodbG3Anu+BIPmVqL3UIDOhhZDuMVydIg9jX5VJo5wcnQ5SaqS8Kl/0g384bUdc9ZPyLBSo5VCPTnMfRie/26Z7840wRvtBxK3fzXN6babFECNefHouvwJoLB5rHyqFRfDUQgotUI5fj8EntuDtbwKU0Ve6+XYeCcvqgSiA8CiPBTE78i97KoHevnucXxhAup/ngNs6zlIJrssDjCo03kTdcaS50qTY3LD9cXQ+JansgF1t10VD8iuXEvc7TFclZUsx4eS9tQeC2IsRERrfuf5ZJzFFY8DfP29NpSeMDhyjbarBUYxXysLE+LNrGP2wY9DkVTQAD5ptsiI5IupyPoQiYaxcAgPTydLwmV45QNMInGfkPj8AZbdi18QZmSxudESXOUtzbucC91tAhBk+4gGV9oErFMtq5hsyuNGu3QcmEwzXg2QkngeHKUWxzCKP2wi3bgiz0dmlrfZKlC+Xd6dLJnY3cTfrBt/7tfh5LV9Qz/BnFXweXsHTgRJ+wSwSjSRgAyOdFb6Yqnk8yOA6poioc2heohqCNGv/879dAwVeEUXeqMq4NOyyio3oHWJs2nvbLMuO0+gzV5RYoXs6+prUlpXUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed14ec86-81ad-4fa6-b0fa-08d879b73423
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 13:58:23.4794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUJe2FQoY+k4BqGAQlCIwVkgEa3jpMBpvJNbIX3wpOMYxGyMRVMC6kYjTDpVWO2vzOk+IQvYR6eZQGhou/3MYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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
Cc: alexdeucher@gmail.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 maraeo@gmail.com, daniel@ffwll.ch
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-21 7:31 p.m., Bas Nieuwenhuizen wrote:
> Prepare for inserting modifiers based configuration, while sharing
> a bunch of DCC validation & initializing the device-based configuration.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 222 ++++++++++--------
>   1 file changed, 119 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5a0efaefbd7f..479c886816d9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3839,46 +3839,86 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
>   	return 0;
>   }
>   
> -static inline uint64_t get_dcc_address(uint64_t address, uint64_t tiling_flags)
> +static void
> +fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
> +				 uint64_t tiling_flags)
>   {
> -	uint32_t offset = AMDGPU_TILING_GET(tiling_flags, DCC_OFFSET_256B);
> +	/* Fill GFX8 params */
> +	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
> +		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
> +
> +		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
> +		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
> +		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
> +		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
> +		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
> +
> +		/* XXX fix me for VI */
> +		tiling_info->gfx8.num_banks = num_banks;
> +		tiling_info->gfx8.array_mode =
> +				DC_ARRAY_2D_TILED_THIN1;
> +		tiling_info->gfx8.tile_split = tile_split;
> +		tiling_info->gfx8.bank_width = bankw;
> +		tiling_info->gfx8.bank_height = bankh;
> +		tiling_info->gfx8.tile_aspect = mtaspect;
> +		tiling_info->gfx8.tile_mode =
> +				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
> +	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
> +			== DC_ARRAY_1D_TILED_THIN1) {
> +		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
> +	}
>   
> -	return offset ? (address + offset * 256) : 0;
> +	tiling_info->gfx8.pipe_config =
> +			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
> +}
> +
> +static void
> +fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
> +				  union dc_tiling_info *tiling_info)
> +{
> +	tiling_info->gfx9.num_pipes =
> +		adev->gfx.config.gb_addr_config_fields.num_pipes;
> +	tiling_info->gfx9.num_banks =
> +		adev->gfx.config.gb_addr_config_fields.num_banks;
> +	tiling_info->gfx9.pipe_interleave =
> +		adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
> +	tiling_info->gfx9.num_shader_engines =
> +		adev->gfx.config.gb_addr_config_fields.num_se;
> +	tiling_info->gfx9.max_compressed_frags =
> +		adev->gfx.config.gb_addr_config_fields.max_compress_frags;
> +	tiling_info->gfx9.num_rb_per_se =
> +		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
> +	tiling_info->gfx9.shaderEnable = 1;
> +#ifdef CONFIG_DRM_AMD_DC_DCN3_0
> +	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> +	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
> +	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
> +	    adev->asic_type == CHIP_VANGOGH)
> +		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
> +#endif
>   }
>   
>   static int
> -fill_plane_dcc_attributes(struct amdgpu_device *adev,
> -			  const struct amdgpu_framebuffer *afb,
> -			  const enum surface_pixel_format format,
> -			  const enum dc_rotation_angle rotation,
> -			  const struct plane_size *plane_size,
> -			  const union dc_tiling_info *tiling_info,
> -			  const uint64_t info,
> -			  struct dc_plane_dcc_param *dcc,
> -			  struct dc_plane_address *address,
> -			  bool force_disable_dcc)
> +validate_dcc(struct amdgpu_device *adev,
> +	     const enum surface_pixel_format format,
> +	     const enum dc_rotation_angle rotation,
> +	     const union dc_tiling_info *tiling_info,
> +	     const struct dc_plane_dcc_param *dcc,
> +	     const struct dc_plane_address *address,
> +	     const struct plane_size *plane_size)
>   {
>   	struct dc *dc = adev->dm.dc;
>   	struct dc_dcc_surface_param input;
>   	struct dc_surface_dcc_cap output;
> -	uint64_t plane_address = afb->address + afb->base.offsets[0];
> -	uint32_t offset = AMDGPU_TILING_GET(info, DCC_OFFSET_256B);
> -	uint32_t i64b = AMDGPU_TILING_GET(info, DCC_INDEPENDENT_64B) != 0;
> -	uint64_t dcc_address;
>   
>   	memset(&input, 0, sizeof(input));
>   	memset(&output, 0, sizeof(output));
>   
> -	if (force_disable_dcc)
> +	if (!dcc->enable)
>   		return 0;
>   
> -	if (!offset)
> -		return 0;
> -
> -	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
> -		return -EINVAL;
> -
> -	if (!dc->cap_funcs.get_dcc_compression_cap)
> +	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
> +	    !dc->cap_funcs.get_dcc_compression_cap)
>   		return -EINVAL;
>   
>   	input.format = format;
> @@ -3897,17 +3937,60 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
>   	if (!output.capable)
>   		return -EINVAL;
>   
> -	if (i64b == 0 && output.grph.rgb.independent_64b_blks != 0)
> +	if (dcc->independent_64b_blks == 0 &&
> +	    output.grph.rgb.independent_64b_blks != 0)
>   		return -EINVAL;
>   
> +	return 0;
> +}
> +
> +static void
> +fill_dcc_params_from_flags(const struct amdgpu_framebuffer *afb,
> +			   struct dc_plane_dcc_param *dcc,
> +			   struct dc_plane_address *address,
> +			   const uint64_t flags, bool force_disable_dcc)
> +{
> +	uint64_t dcc_address;
> +	uint64_t plane_address = afb->address + afb->base.offsets[0];
> +	uint32_t offset = AMDGPU_TILING_GET(flags, DCC_OFFSET_256B);
> +	uint32_t i64b = AMDGPU_TILING_GET(flags, DCC_INDEPENDENT_64B) != 0;
> +
> +	if (!offset || force_disable_dcc)
> +		return;
> +
>   	dcc->enable = 1;
> -	dcc->meta_pitch =
> -		AMDGPU_TILING_GET(info, DCC_PITCH_MAX) + 1;
> +	dcc->meta_pitch = AMDGPU_TILING_GET(flags, DCC_PITCH_MAX) + 1;
>   	dcc->independent_64b_blks = i64b;
>   
> -	dcc_address = get_dcc_address(plane_address, info);
> +	dcc_address = plane_address + (uint64_t)offset * 256;
>   	address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
>   	address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
> +}
> +
> +
> +static int
> +fill_gfx9_plane_attributes_from_flags(struct amdgpu_device *adev,
> +				      const struct amdgpu_framebuffer *afb,
> +				      const enum surface_pixel_format format,
> +				      const enum dc_rotation_angle rotation,
> +				      const struct plane_size *plane_size,
> +				      union dc_tiling_info *tiling_info,
> +				      struct dc_plane_dcc_param *dcc,
> +				      struct dc_plane_address *address,
> +				      uint64_t tiling_flags,
> +				      bool force_disable_dcc)
> +{
> +	int ret;
> +
> +	fill_gfx9_tiling_info_from_device(adev, tiling_info);
> +
> +	tiling_info->gfx9.swizzle =
> +		AMDGPU_TILING_GET(tiling_flags, SWIZZLE_MODE);
> +
> +	fill_dcc_params_from_flags(afb, dcc, address, tiling_flags, force_disable_dcc);
> +	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
> +	if (ret)
> +		return ret;
>   
>   	return 0;
>   }
> @@ -3979,82 +4062,15 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>   			upper_32_bits(chroma_addr);
>   	}
>   
> -	/* Fill GFX8 params */
> -	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
> -		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
> -
> -		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
> -		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
> -		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
> -		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
> -		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
> -
> -		/* XXX fix me for VI */
> -		tiling_info->gfx8.num_banks = num_banks;
> -		tiling_info->gfx8.array_mode =
> -				DC_ARRAY_2D_TILED_THIN1;
> -		tiling_info->gfx8.tile_split = tile_split;
> -		tiling_info->gfx8.bank_width = bankw;
> -		tiling_info->gfx8.bank_height = bankh;
> -		tiling_info->gfx8.tile_aspect = mtaspect;
> -		tiling_info->gfx8.tile_mode =
> -				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
> -	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
> -			== DC_ARRAY_1D_TILED_THIN1) {
> -		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
> -	}
> -
> -	tiling_info->gfx8.pipe_config =
> -			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
> -
> -	if (adev->asic_type == CHIP_VEGA10 ||
> -	    adev->asic_type == CHIP_VEGA12 ||
> -	    adev->asic_type == CHIP_VEGA20 ||
> -	    adev->asic_type == CHIP_NAVI10 ||
> -	    adev->asic_type == CHIP_NAVI14 ||
> -	    adev->asic_type == CHIP_NAVI12 ||
> -#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
> -		adev->asic_type == CHIP_SIENNA_CICHLID ||
> -		adev->asic_type == CHIP_NAVY_FLOUNDER ||
> -#endif
> -#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
> -		adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
> -#endif
> -#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
> -		adev->asic_type == CHIP_VANGOGH ||
> -#endif
> -	    adev->asic_type == CHIP_RENOIR ||
> -	    adev->asic_type == CHIP_RAVEN) {
> -		/* Fill GFX9 params */
> -		tiling_info->gfx9.num_pipes =
> -			adev->gfx.config.gb_addr_config_fields.num_pipes;
> -		tiling_info->gfx9.num_banks =
> -			adev->gfx.config.gb_addr_config_fields.num_banks;
> -		tiling_info->gfx9.pipe_interleave =
> -			adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
> -		tiling_info->gfx9.num_shader_engines =
> -			adev->gfx.config.gb_addr_config_fields.num_se;
> -		tiling_info->gfx9.max_compressed_frags =
> -			adev->gfx.config.gb_addr_config_fields.max_compress_frags;
> -		tiling_info->gfx9.num_rb_per_se =
> -			adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
> -		tiling_info->gfx9.swizzle =
> -			AMDGPU_TILING_GET(tiling_flags, SWIZZLE_MODE);
> -		tiling_info->gfx9.shaderEnable = 1;
> -
> -#ifdef CONFIG_DRM_AMD_DC_DCN3_0
> -		if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -		    adev->asic_type == CHIP_NAVY_FLOUNDER ||
> -		    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
> -		    adev->asic_type == CHIP_VANGOGH)
> -			tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
> -#endif
> -		ret = fill_plane_dcc_attributes(adev, afb, format, rotation,
> -						plane_size, tiling_info,
> -						tiling_flags, dcc, address,
> -						force_disable_dcc);
> +	if (adev->family >= AMDGPU_FAMILY_AI) {
> +		ret = fill_gfx9_plane_attributes_from_flags(adev, afb, format, rotation,
> +							    plane_size, tiling_info, dcc,
> +							    address, tiling_flags,
> +							    force_disable_dcc);
>   		if (ret)
>   			return ret;
> +	} else {
> +		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
>   	}
>   
>   	return 0;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
