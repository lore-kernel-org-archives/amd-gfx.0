Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C60C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 17:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBD410E5A3;
	Thu, 11 May 2023 17:52:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7AC10E599
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 17:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0BfBl/THIx3vSXQ11BgYCnqY2dFB0O30YrDRIG47l1fxGEUTNy20SfE+29Oek1TvVu4RzYFe+fWvKSv+TD4kwXTy3kji5sczgmInXs+cqN1efirIpJPzOgF7+ucgkJVeIzR8dkv6Cf3xxJh5y9WAPf38I+k6NvGMPCgnVNP8YjHTep5kWZlOZltXtxrxGqy1xiDZh12OrIELZl6kuLk60gKkwD8dka4Z4h5bd3DAGQktC9RiIgydT6792QDNx6P9SCs1TVpeefPL7xdZI3ijkDsc8NfQfpfv4hp015yOX++TdHWe1jQyg4y4GCrRwHRGfkuZtkjklmFvC029pk3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBdDQ7c53WT9GtRhNQj3Ckw2A11zIaKUbVhFxdP4Apw=;
 b=hoQpbEKoAfh7eFQUH923MOCc3S2Hyjwr7Tzs21QuvAOy74Dj1fmrimgKXpAbQceeSJNiqEQPcZo23UttWrdwxYlwvZG5OLixaJPNyTS+EWCjMCm+Bbwc4NVDswTSJ8UA58/XrVsE03WyTbmgl4lsM7EFVcit+AyznnIxfk+GtowmxmG7Bk0tp9ny3vU5jVBz0oKX7cPs/pNbUtdcRX5SYAvbjLEO5vNGz7Y94O5+6PUDi7kWzeE5hYj29a3045Y6QXkbRfVVgZoaCGNNNNIfRDG+rYYtgIOgNRHl3J0M8r7JeNGvV+IW2PQ8osMIimlj1z+tAvYhAGeW8Dp6LX4mOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBdDQ7c53WT9GtRhNQj3Ckw2A11zIaKUbVhFxdP4Apw=;
 b=WQks2ugLmDiZ++0f/aEU8wxxPvaD99RkG9RqNpCqaB8RBsD33VRxCJ2bcvVSi6lLd0pOG6dGQxoydpjYk6gAv+2Ei3a0e0ryoawzJr7TrDUFgBYFQU0B9n57Lf6hKRTPGjhPIE+iDISuZgZJrqtfdLHXbLAFUjYyQEBa741lo7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 17:52:25 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36%4]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 17:52:24 +0000
Message-ID: <9d9e4c90-13e5-4b32-a079-9a7bac3e166b@amd.com>
Date: Thu, 11 May 2023 11:52:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] drm/amd/display: formatting fixes for dcn30_hwseq.c
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
 <20230511153807.1154612-3-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230511153807.1154612-3-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:408:ee::19) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c527d8d-5130-48b4-d922-08db52487a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHNViLQHCUDb1LPdcl5mD3uPurrQxXGCfoUY7VV8QGEADUZYabrHJbfc/c2dVdsXDsmNP1pIAuz641J244IeGEjFAguOdBxMOz145bbFlsv8j0O/RDfHFRvTrpeHnyA11YZCylsBOvS3CgEcmSgbBBp2whI5NluLVHvYX0Qzv4jyc+sM8VTkhm2S6fJDLIBnWK3lbRZs7DxKXfCnN9xXdbPa83j9vo5KMqgvb07n4iJHYeu1uNzqGMhjXjg9RsS+CScqWZSrbah8x/zEDTR9UWJUq/w9z1wiQCVOUfghT5+82HQY0qNvgAdDEDrG31fLE0kpSkuomnVuZEZHEYF+O8IJ4s5hJXgC+9vFdRUfnJF6E8xONH5reV95WXL5Q64Vw8gFVJO4Nf5ceRkh+OYkwvYB/MuUDlC30Y8u8WR+kKHlkI89jqIyo7HPz9JkHs1WksOEcEeaYJPkEeKdknrLWXj7iBQwql1CfZIiohdRvFWv9zNC2jkXPxJfmjGTkl3b4You7i4zJ08fDV+ugyn/p1vepBKEzkXzZdkFpmviT5hjXsWE/P85sYt0P1Xi6f0nK6Bt+2Ivf+Kkie2CTnNAkAjnHUyr1oELvCcMSETT8vqaw3heFK+uXBMVcVelwjEFSDwd3DoysetjEPPSunCPww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(6486002)(2616005)(31696002)(86362001)(8936002)(8676002)(38100700002)(53546011)(36756003)(186003)(2906002)(5660300002)(6512007)(478600001)(6506007)(316002)(66946007)(31686004)(83380400001)(66556008)(66476007)(4326008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y043cUpHMGxxcmVBMWdFMldEMXpRZlFsQlJ0ZU1NeTRGdGpGYzVFaUVCbjd0?=
 =?utf-8?B?L3RjdHUzQTZwTGxoalFoSVV2WStzVnhnamt2citudndBMDNJZjB6dWZqdFBu?=
 =?utf-8?B?b1JadHlvVDBaM0NSNlNTZ2cvaG5Sa3Mzem9XaUgzNXBFN293NzJnZG12N2dN?=
 =?utf-8?B?QzJMNW1FaGg4NHR5dGpZTU1LOUpVWm1URzUvbU1DdUNkNCtLeE8raG51NWtx?=
 =?utf-8?B?WitaWXJXNWdSYzB1SHJuUHd0YThKd05CTWprcnFRU1A2Zld5b0pQSmEvTkVX?=
 =?utf-8?B?bkFNQmw4eThMWDZha3VjQit0akV5ZDJWbnMwWERjMzA5RlZNL2ZVbE1VYllt?=
 =?utf-8?B?V0E1VGt6cGRhN3BGYXBXS2t3M0Q3WTBYWUVNc0RlT1lmT1dUVlJiWm1wVzQw?=
 =?utf-8?B?R3NnL292TTdVRXpDRmoxV1c4WktnYlI3Y01SSGtRT2c2YkpKd25PSFdCTS8r?=
 =?utf-8?B?bEpLQ2Y3MEZTNTZkaWFwR21ycTdYMlcwak9LWkhpZTRxK3F3S2tLY0QvcE9I?=
 =?utf-8?B?OUV1R2lWV011Q3FIdG85VFZpZjhxeGZ5bHdDWitDV3FZNEpUc0FLRm45eGdK?=
 =?utf-8?B?THZVdEI0NUtlWExHVHdQQ1B6eWphYTA1MWI5ZzF6THN0NFliQ2pUbHFVUEZN?=
 =?utf-8?B?TGJLemdqMHVnUkh3VHNWako3MmswM2FiT3VEUmtNTVpxck9Mc1poanE2ai9D?=
 =?utf-8?B?dFlsVlp2MDEyOGpqa2xnNENuVkF1VmJHUUtnZk9pOSswV25rdlY5MEJGY214?=
 =?utf-8?B?bkhjTFdTS1pibjc5SEpKWHBzcDErYzFmaUhqS1kyNW1BUGp6MDRLUTBHSEJa?=
 =?utf-8?B?d0VkQktRMEI2TDBkaUU5dFg2MjBlQzM5NjR0eXNqZmcyMkUyLzllNk4vTVpt?=
 =?utf-8?B?NmkwVi9rZFVzTHRjRGE5YVRkVEtmVHgra3JpdmNlZURrR2R3TUQvVEQ2Z1Z4?=
 =?utf-8?B?RFIxU2JHNnlJeWtUMkNYMkdjYkJZcHBRc0JGcnR3R0R4ZnlyU0VKOThuQmtY?=
 =?utf-8?B?dUduUDhwaVpDSW9FdEZFOWIydEtYd0FtMDcxb3plV0k1UWZCZHVqMWhWbUcz?=
 =?utf-8?B?Q0tEVk9ZcjJwV2lkMnEzZ1ZlaHVBT3owb0JkbWZBcUlkbzNLNlE1bmRaanBl?=
 =?utf-8?B?Skc2NHNmU1Y1Q01CZFNhMStZZWxjeHZXVUsxeDFLQitRa1pCbGRrOWxOMW5q?=
 =?utf-8?B?WURDVkVRclpMZ1JjR25jbVUrYWlsQWd5WHA3NnZFbE4wV3QxSTdWZlBOTGNS?=
 =?utf-8?B?K1ZtZy9LK0svT0g2azB4b3QxVnpFN2NhakRhY1Evai96V1FqM2didWk3d2sr?=
 =?utf-8?B?NkZEVzY2dFgveXRXcElCTm5YZTFaNEE2MXV3K3hyczhMREpRbGRZTlhlTW5X?=
 =?utf-8?B?bkt1MFBGSFB6ZFBxTnJhY2FIaXVFbXozcGx1anYrdXh0ZlMzUUsxTVY2MkVi?=
 =?utf-8?B?d0NFYnZ3WENiMzBxUE9neUdxcVp1UGZRL2hWcVdpcEJ2QXVVUlZheUdZbVB1?=
 =?utf-8?B?bXNnQkN6OFRjNkkzYzg2VEVqeWNyWHF2UkVMMDYwN0J3WnVwMWNFVjl0NE54?=
 =?utf-8?B?YXVwdzlORlRyYkJQdHJRYk9iWU43ZW1PUFNaVWtrcUVMT1d5T0d3Yi9IbU1Y?=
 =?utf-8?B?UitPam1pQXIzekwyQVJnTXYrMSt6eng1Nk1xUXpDK29xem1Remw0MmpOZGdR?=
 =?utf-8?B?VnhxWlNoaGdMaE9PcWx2My91KzhaU2xZZjN6b0haQ2pLQmJXaENYb0FOV3R3?=
 =?utf-8?B?RHYxV1pGRlFxUkt6TkZtMEYvWjJKTTlJWkNmY0JWOXBUYncxRitJWkJPdEp3?=
 =?utf-8?B?OWlJWjdENW5TdTBSSHJhcjhiTC9qS0U1THhhV1dOVzNWb2QvQ09SeFhralZT?=
 =?utf-8?B?cEN6SjJoUnF2WjdVUDJzOXpJdGl5Rm1ZZDJ1UHNjRUlyRENqcEhRZU52K1ZQ?=
 =?utf-8?B?QXc3MmJzOEpIc28yTzNXVzExN3BsbGdrMWFhWWRPU0oydXBDc0Z1aTQ0L3Rs?=
 =?utf-8?B?TkNqd0tYdHA4cGhRSFJTcU1sQk1ZajBUNHR1NzdOdzVveFgrRk8rZmJqNWpl?=
 =?utf-8?B?WGlJQ3VUekNGb0ZoSHFESGZqMVA2cnIzQm5KY2tqWlkzVGdaNWhYdWpoOWx5?=
 =?utf-8?B?NXlkbWtWK0hqdlRBY1M1TC9FL0U2YUFRQ2IxWC9tNCsyUDY3ZjdXZ3FHYTRo?=
 =?utf-8?Q?xz/Y98cP8aJGg20MpNcZm4d+wlpUMZOAuE8MUTvZiIr2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c527d8d-5130-48b4-d922-08db52487a44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:52:24.7248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M8si5KQeVO4uvvA+hbp+CNQPFSZyjVfh7nv0KUZ2ONPnAsTgyTbl9ltcuDeZ3nIJdltS8qWiww0ejyCyi1Ztg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/23 09:38, Aurabindo Pillai wrote:
> Fix whitespace issues and other trivial formatting fixes
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 27 ++++++++-----------
>   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index c9ec158c5aa7..287b9a2bfde4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -90,8 +90,7 @@ bool dcn30_set_blend_lut(
>   	return result;
>   }
>   
> -static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
> -				       const struct dc_stream_state *stream)
> +static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream)
>   {
>   	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
>   	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
> @@ -106,14 +105,13 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
>   		if (stream->func_shaper->type == TF_TYPE_HWPWL) {
>   			shaper_lut = &stream->func_shaper->pwl;
>   		} else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
> -			cm_helper_translate_curve_to_hw_format(stream->func_shaper,
> -							       &dpp_base->shaper_params, true);
> +			cm_helper_translate_curve_to_hw_format(stream->func_shaper, &dpp_base->shaper_params, true);
>   			shaper_lut = &dpp_base->shaper_params;
>   		}
>   	}
>   
>   	if (stream->lut3d_func &&
> -	    stream->lut3d_func->state.bits.initialized == 1 &&
> +		stream->lut3d_func->state.bits.initialized == 1 &&
>   	    stream->lut3d_func->state.bits.rmu_idx_valid == 1) {
>   		if (stream->lut3d_func->state.bits.rmu_mux_num == 0)
>   			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu0_mux;
> @@ -121,20 +119,18 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
>   			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu1_mux;
>   		else if (stream->lut3d_func->state.bits.rmu_mux_num == 2)
>   			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu2_mux;
> +
>   		if (mpcc_id_projected != mpcc_id)
>   			BREAK_TO_DEBUGGER();
>   		/* find the reason why logical layer assigned a different
>   		 * mpcc_id into acquire_post_bldn_3dlut
>   		 */
> -		acquired_rmu = mpc->funcs->acquire_rmu(mpc, mpcc_id,
> -						       stream->lut3d_func->state.bits.rmu_mux_num);
> +		acquired_rmu = mpc->funcs->acquire_rmu(mpc, mpcc_id, stream->lut3d_func->state.bits.rmu_mux_num);
>   		if (acquired_rmu != stream->lut3d_func->state.bits.rmu_mux_num)
>   			BREAK_TO_DEBUGGER();
>   
> -		result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,
> -						   stream->lut3d_func->state.bits.rmu_mux_num);
> -		result = mpc->funcs->program_shaper(mpc, shaper_lut,
> -						    stream->lut3d_func->state.bits.rmu_mux_num);
> +		result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,stream->lut3d_func->state.bits.rmu_mux_num);
> +		result = mpc->funcs->program_shaper(mpc, shaper_lut, stream->lut3d_func->state.bits.rmu_mux_num);
>   	} else {
>   		// loop through the available mux and release the requested mpcc_id
>   		mpc->funcs->release_rmu(mpc, mpcc_id);
> @@ -208,9 +204,9 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
>   					stream->out_transfer_func,
>   					&mpc->blender_params, false))
>   				params = &mpc->blender_params;
> -			 /* there are no ROM LUTs in OUTGAM */
> -			if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> -				BREAK_TO_DEBUGGER();
> +		/* there are no ROM LUTs in OUTGAM */
> +		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> +			BREAK_TO_DEBUGGER();
>   		}
>   	}
>   
> @@ -893,8 +889,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>   	memset(&cmd, 0, sizeof(cmd));
>   	cmd.mall.header.type = DMUB_CMD__MALL;
>   	cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_DISALLOW;
> -	cmd.mall.header.payload_bytes =
> -		sizeof(cmd.mall) - sizeof(cmd.mall.header);
> +	cmd.mall.header.payload_bytes = sizeof(cmd.mall) - sizeof(cmd.mall.header);
>   
>   	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
>   

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
