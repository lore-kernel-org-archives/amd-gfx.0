Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065EFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 12:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507D3112783;
	Thu,  7 Jul 2022 12:23:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE031125E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 12:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfnrUYDSQ1V6LgjBFmqSZfzrmGdufyo6oD3/lRxwmev1uATC8Y6tw4Xs3bNKVtT1j8P97xfxZLa4Cx285BlFlMK2m/oOYZlH1V1gBzvoN6+pLhpy1Zw/VwfTQJFgjVNjeahf2FtfayBZU2iCqiPNifaKlCqdMcUhxDuf1Qgb2fQ6KkvGA1b7/RlQC6u/fJXJbKkX4Oon17u8s389HC6jAwLLCP7XJO2blucCybJMuvTQP6EnLMPhmWCECImENRcEdfYqtDw1Cb8J/zt378Zg4rE6FD7u90cB3YSIHIirRQ7nSTJc7tyBAUtQu3BvXGGvoz3OrvirH7UevGZynonwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epQLjDz5KOWHnW8yYf13OLCXdYZDWJhB18O/QLdYboI=;
 b=NeGYOqbI+jRwuAi9vEpg6caxSfg/m2c6VnnRhUPCEmmL8WKaZHnXtps/+PXBnUB6etaZ2U6xMbAQMnnAFPGfQpvG5shgXBHkIJoXp8UWBklGLEBQPHSI7b1RJsrQowHZ/Hny5kiCno2/V3h3Pp0YEnfH5aOzcbuxTyQuKiSW3aygThRrZZW4Wg/xiukTZY4wHDX8zlYdWV3Z1WgtjRAOP+dmXWfWBqebdMgo9pIVOLnJT6SPD7iAgKHWLWul6Woy1CQfAxlROEtFKrhzW5uuhuFcJHTctTJ1JqtDQ8IyuO5MhU2YVH+x2fghYH+b2zf9WxyfQ6LSEVrI2zN6rAAX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epQLjDz5KOWHnW8yYf13OLCXdYZDWJhB18O/QLdYboI=;
 b=d7RrV9eg/932y4Tfmw/RMg66v8GpORwUJ1o7vkTJGTyQ6p0ymd2W/tV8vXqh1gIPa0cMA7jfAarZBQywt4x/trzudRsS8FatLPTLaeEOpizsYPGcJX4zw8vGauEeoY81dRkbnGLUoaMNy9EwhU8QVoZkSfsCbJA/Cl2UrmLJaZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:23:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:23:40 +0000
Message-ID: <d722b10e-4cc2-56eb-5fb4-664994d8217a@amd.com>
Date: Thu, 7 Jul 2022 08:23:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: Fix new dmub notification enabling in DM
Content-Language: en-US
To: Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707082329.936987-1-stylon.wang@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220707082329.936987-1-stylon.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d10cd96-8780-4600-d87f-08da6013860f
X-MS-TrafficTypeDiagnostic: LV2PR12MB5822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzhzX0M5MrLjoPJVscD0cZHEOVfBPlKLfa9ZdFt5zFrzc043xve9z2osYCYK9Max63Fli3uwy4eY9FB7OPDxx8c5gsCGjpb9mgvmQ4yrXfOPmKxqbtyPnLdur+PWmQzcLTuC4KTiuZoY+A1Nl5RB6GvDve8aS6MTeBKo2JB3YBkTAXq/OJyxykYNa0KhN1PmoCro9jUBvERshqziBmQv8sPmsToWeDhxlBpZ+CN346ecF7nSctouYILl1MYmBYHzoYkgFjpKmlrGWsMZWh0pfN3laRqdqwbT/1sn83lksjfAlqtnHXWXb/DHdMMSx+c2o9P65h+JU/GOGXl0Y+bpM4bC/R13E5y6oXOksgl7bcS32z+bkPxj2pAo+nUhSbbbHZDc+Wk00SxWgjf0BHQx5Ie8ZovVq6Ihug4Y3vGxdrhXof9CWvsxM7KKaySGk5mXwAmvCzXF+v1yzi4dBW4umQDVR3aEoQYwk6uvNDtdRefvjExORv3ThfD7pQfF4fh4F1oXK7NbEQ/Z4FN+Gwza4hlPA9FTGZlE6eyUE+Lull0U+e8g+00pxIlf6oWrnRKndIAbhs4Izvbzsrw+4Tp7/4Of2f6BTxu7OQd5wkQnVKvLbMHcWRC5TxDH2BQIwc98nKytXI7SJbTcET4nguipW5pAs9NRTq/btaxtkNtDQ4mD7mtypcsn9AcBwXjhFybXpbbWQFrq8A4uPP8z3r79tMc78X+3BRGdwrC+TaKEMWDik9734kLWP8uzVgJf7S+uPCfdhloh8kunww8QB9bc7LZfbp3AjId9LkMw+/WL+W2ol1cCFtwyTmmKwytQZmrALxyuZLe33ruMZXZ6URXdiDFbXc+NtKro9nVx+NlKuwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(31686004)(6512007)(26005)(83380400001)(53546011)(6506007)(5660300002)(8936002)(316002)(41300700001)(6486002)(44832011)(6666004)(31696002)(478600001)(38100700002)(86362001)(8676002)(36756003)(66476007)(66556008)(186003)(4326008)(2906002)(15650500001)(66946007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZRVUdEekQ0ekVLOHRkcW52RittRkZsZkdLYmVqMnY0K1E5Tk1lYUdQcDVz?=
 =?utf-8?B?cmpVRHNEWGVqYkxYNUdCUkxkM2VWRXA2UEM4RWZHT3BmN2F3ZjRBT2E2d2JW?=
 =?utf-8?B?TG00UnVJNjd2d0d3YkQ0cDdSbmJLcEtrdFVzQmNyNTJTZHQ3L2l3amZkQkhh?=
 =?utf-8?B?bmtXNDZmR0d0NzBuYlRFZlA0dDU0K2l0OFpvMmVjdjBQNU9vQUVOUHFmRE1V?=
 =?utf-8?B?N01VbTBhS09NM0oyOWRRdWl3ekNFUHVadFlWOWFEaEViZjBZTFYyTm1IclpF?=
 =?utf-8?B?UFFFd2xTbjhFTEZCakRlRVVZUWRlbEI1aU0yaHVIL3FURWM0MHgwa3lJWjBD?=
 =?utf-8?B?eXpjcUpoRit2cDFMbVdJV1NDMElZS0ZraUNjK2hrUlU4dzB6TjhVMmsvbkwr?=
 =?utf-8?B?blk1Y00xUmd4V3drSDNoOERKOEMzT1oxYndIRkRvdW5DWG1lc3ZxL3N3YnhN?=
 =?utf-8?B?N1krSVNyWG5PaGttUzFzY3Z5SXpnK2wwV3djSWYvWmJsM2JVazMvcDlmMUNr?=
 =?utf-8?B?L3dxOHlsTGRnSVViT1NSOEVMZUNlRFd2NFhPcjNqVUk1b3BRUUFMTWNJWGJl?=
 =?utf-8?B?T0w4SGJnTHZtR3pQUk1mR2RIUU5OQzZRSG11d04yOTBoUm9USlM5UXJKOFc4?=
 =?utf-8?B?bVlQVStXZWJiUVVPMkQxWUxuU2VxU3FmUXMwZXFUWEpOWk9NRkI4Y24rZ05C?=
 =?utf-8?B?ejlhUHlHaDBHYlJpZkFUU1FsZnFNY2NyM2VreXpGZDhBaEZpN3A5TUFCdTZK?=
 =?utf-8?B?V0pjaVhQRFN3b0dqank0d29pWXY3Y2ppcmVaR0IwU1h5TldUMS9iUzMxTjdw?=
 =?utf-8?B?UzlOclRSaGFHNGVTME4ydzRGaE0xd1c4RVh6djFLZUE0d0VxMDlkd1RZZ1Vn?=
 =?utf-8?B?MGt5UzF6c2lMQnhEUm9rQjFaUHhPNTZBSFdFcXdqOVZXSUdJYSt5WUREdCtF?=
 =?utf-8?B?YlpkS091NzJUZnQxdjVLL1JqaGROVXFqekt5a09vV2ZjVkMzaXhvRzUwYlJx?=
 =?utf-8?B?SkpQblpNVzBTSDJVS3QyeXo1dDZyN3Q4dzRqck4rVTFHcGJuVHVzSS92VVNM?=
 =?utf-8?B?RENac0E4NHI3UjNGaDJTYVJpOXlSa3ZjTUhkdndoY2Y4WDFjaXVXdEFBRWdS?=
 =?utf-8?B?MEUrbVlyOUtpd1cvbmtrN2RrR3dzVGZWK1NEcTRMdU1sQ00rLzRFcmgzVnRM?=
 =?utf-8?B?RHV6MXgvT1M0b1lrNzFZT3BJQmhGRmNoWEVQL3NnbHExZkJCdEVSejVWczFY?=
 =?utf-8?B?bkF4NHZ1VjlPUUF3WTJBK2JOWDZDZUt3TEJyeEpyRFRjU0lwUVdNN2NIWm9u?=
 =?utf-8?B?V1BBNUVvS3RnR21vNTh6TnViTVA3VWY0UllLVVZ6SEl5S2hNbjh5d29GcmtC?=
 =?utf-8?B?U0wxMmd2cGlMdjUxUHNpNFArN0F4Sml2NlJxM2RYQzFnTVNoZE9hcTlIOUVK?=
 =?utf-8?B?WTRoSkhEVHFaMUh6Y0IwanE1WG1HcWdndUdvSjh6eTVYa1RUV1RmRVlvTStr?=
 =?utf-8?B?NDg4WkJTRW9RRklkOHhSZ2h5QnZBeHo2UTRJbks5clZmZnU3WGcrdVgwRWdC?=
 =?utf-8?B?U2dhZVFESEp2amdMbUZQd3ZIZ1p2Z1kzOVl5a0xNWG1GaDZDSTFCVmNMQ0xv?=
 =?utf-8?B?d1NEVU9nc09CR0JUVkd1d3UxMTI4WXBURm9wak5iOUVJZ09nSXVrc0QwSFdt?=
 =?utf-8?B?MjdEM2FHdW5sV0U3bytCdmJIR0pLSWpFeTNMaVowZWdVZ29lMzd0OVhsNDJn?=
 =?utf-8?B?UU1pQll6WjZRVllqSXFwNVB2L1Z4QlArdlp1OHJoejBXUWVucjNNWEFBeDho?=
 =?utf-8?B?WWp2NDBDdWpZM0VxczUzVFBjSjJnRzVRdWtOR2pyVnZiYlNXU09kdkFtMUNy?=
 =?utf-8?B?Nk5DNzU3eTFHeG1DdmZLQ3VoZTRubnlhMVpNTHpFYlR4aTQ3R3R1VzFqRFE3?=
 =?utf-8?B?Zit5L2JXeWxPSUQ4KzBaZUpJdENNL2w4UDdGLzJ0VkF1WWN3RDJCT1dzT3Ni?=
 =?utf-8?B?RWZKSU56N0V5ZGlzSG8rMU0xbUtyMXZrb2JzYUNiQWt1MjBoWndHTkFRNHIx?=
 =?utf-8?B?VkRIcDljM0J1aG1VY0MyZ3E2bFp2MXpSQkxHclBlK0NIYzVRY2tGaEpZRFR4?=
 =?utf-8?Q?+gTLZ3wONtsIDVTrgw6Ugb/Vn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d10cd96-8780-4600-d87f-08da6013860f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:23:39.8208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSvXdggeiY1gl9SPLq3w6tKqPSgXTpC3pftQQJjT7EbFd6sziBc/kj3lJW64SV4BfeyR1bVuD4Zk1+hGviBDEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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
Cc: Sunpeng.Li@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-07 04:23, Stylon Wang wrote:
> [Why]
> Changes from "Fix for dmub outbox notification enable" need to land
> in DM or DMUB outbox notification would be disabled.
> 
> [How]
> Enable outbox notification only after interrupt are enabled and IRQ
> handlers registered. Any pending notification will be sent by DMUB
> once outbox notification is enabled.
> 
> Fixes: ed7208706448 (“drm/amd/display: Fix for dmub outbox notification enable”)
> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Acked-by: Solomon Chiu <solomon.chiu@amd.com>
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++++++------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index eb5efb4aa2ba..de1c139ae279 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1617,7 +1617,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>  	adev->dm.crc_rd_wrk = amdgpu_dm_crtc_secure_display_create_work();
>  #endif
> -	if (dc_enable_dmub_notifications(adev->dm.dc)) {
> +	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
>  		init_completion(&adev->dm.dmub_aux_transfer_done);
>  		adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
>  		if (!adev->dm.dmub_notify) {
> @@ -1653,6 +1653,13 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  		goto error;
>  	}
>  
> +	/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
> +	 * It is expected that DMUB will resend any pending notifications at this point, for
> +	 * example HPD from DPIA.
> +	 */
> +	if (dc_is_dmub_outbox_supported(adev->dm.dc))
> +		dc_enable_dmub_outbox(adev->dm.dc);
> +
>  	/* create fake encoders for MST */
>  	dm_dp_create_fake_mst_encoders(adev);
>  
> @@ -2625,9 +2632,6 @@ static int dm_resume(void *handle)
>  		 */
>  		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
>  
> -		if (dc_enable_dmub_notifications(adev->dm.dc))
> -			amdgpu_dm_outbox_init(adev);
> -
>  		r = dm_dmub_hw_init(adev);
>  		if (r)
>  			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> @@ -2645,6 +2649,11 @@ static int dm_resume(void *handle)
>  			}
>  		}
>  
> +		if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
> +			amdgpu_dm_outbox_init(adev);
> +			dc_enable_dmub_outbox(adev->dm.dc);
> +		}
> +
>  		WARN_ON(!dc_commit_state(dm->dc, dc_state));
>  
>  		dm_gpureset_commit_state(dm->cached_dc_state, dm);
> @@ -2666,13 +2675,15 @@ static int dm_resume(void *handle)
>  	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
>  	dc_resource_state_construct(dm->dc, dm_state->context);
>  
> -	/* Re-enable outbox interrupts for DPIA. */
> -	if (dc_enable_dmub_notifications(adev->dm.dc))
> -		amdgpu_dm_outbox_init(adev);
> -
>  	/* Before powering on DC we need to re-initialize DMUB. */
>  	dm_dmub_hw_resume(adev);
>  
> +	/* Re-enable outbox interrupts for DPIA. */
> +	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
> +		amdgpu_dm_outbox_init(adev);
> +		dc_enable_dmub_outbox(adev->dm.dc);
> +	}
> +
>  	/* power on hardware */
>  	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>  

