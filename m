Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC2BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466C110E81B;
	Thu,  9 Dec 2021 16:53:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22EDF89D56
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 12:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei4SIoURtPsh/oTd+NBM2lhURgsFSh1bmCEyXgDUptxWhzzX4ZDCJtefYnmmDdPkN884XEpr/0sti1I8Yvi6bsY5NSEhDPQYqN4LSIQnmYdGoPJX8RRQijmMP9wJebBUNfJK+9vKtwn/yOw5LpDhzsGr28mbWcsgNEWkyaSY05S2mT1ZgZKUTZ0IEdbIX/o2KlsW/0+DuLNu1VH2QbNx80diThiY3fEfOSgsYECfugFgNBEM8kRcrrHmftU8Y/FxfJ+BFihZi65QpntnRGyIG28aZCXQ3Ekxi1Ws9aBFoA1vZrPqdPjpiGeWu0MiAos5eUNZOkeQTf5zZU7hts6ZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxiivzRfL9S9Ui/fKtq3fD0TcJoZu/iEpvW457sYQuE=;
 b=ZWM1ZTJqPDzv3fKaKsWGCdBDN95DEHGg5jevjEnRnnwVDk5gqbjZVitVA1O7RLU+JPxDK4jsWKlkcBRdVXspbm3a876rwWS0f1AsdatfSUw0k7y3tkTDsgnT+QdSEZ1wv+u6PGfZZIqlDVSyKtgcmEIc3jBq+yr1E42HAaboTpC8hNK+gAZa2gVxhmcPE/Y+zLL0Jf5ZejEhFvy35nlGnBxnBlKTKzbalrmLTowlMkuoPwHG4zb8r2R89qyeex68+GimzUD5/I1P77/WAiFLIZh6rlvF88AvtKDF+t5pVVyEeUcksQGkUPUoUafiUi2ujGd2ELn0wM3MOdQJlAFE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxiivzRfL9S9Ui/fKtq3fD0TcJoZu/iEpvW457sYQuE=;
 b=NaplYou4bS5VR1hHfs0O7MpsVRr0GMlOJp2AtcwCCfrpQSYNH7ryXoOC9R+lARpqBHlkN47R2TyMzBwst3lhrkGqTDw2FqY3e+tW8jKT0+c2NUwheOy7zncJEA/0MyzwRGZdegUcq6xSYCAzdPBKwahf7og6jf9kuQeC7nnP06M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 12:05:39 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 12:05:39 +0000
Message-ID: <5029be7b-3dc9-5395-2dfd-6d3d660df295@amd.com>
Date: Thu, 9 Dec 2021 17:35:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 03/17] drm/amd/pm: do not expose power implementation
 details to display
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-3-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211203030540.1710564-3-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::14) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc89c97-9516-4a9f-eaf7-08d9bb0c3732
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40103EB042C92B2FF41FFF7A97709@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jR4IeN8ssusEUHCEI/9S2fjXHjKOzJunJGyDTaWtgRspfS9FMF9Drm2z0SsVu2w4YjKTriuwC6pXemwsYG+bwGah1sH2uN1Hl9iwqgHRbHMPJld1W3jRDkP06qLF6ekZA+OZYDRPxYO7QWMdLu8bd1NvUgqHXxHEpjsGErhsY1TOcHLlejIU+QNJCYMIm2s9zeqZ42SjspfABO5MG6vbjYPSey3D32rjpAay5oiSvFQSMGdwqerKgO60QdoL6UJAVshSVhotEiLPMBfKCK61Ovfh8IsH9G3WCoNowTYCI+tytgV7q+PbZgRucShbWpWbgDMx00w7YV0Dr4edSRUJswwE5cIX+Dj3MNeW3zBvzNxsv74CEDVPchPscfyJLdj8Iavbut03LkOkvDNhctHVoJf8ynss77KZAWDGlX6jJG6HRtZ/iJvIlehXnruLlJfhd4H9VMv80pMGNWF8/IhNkM7RrRJKrJCRHjQCWTIAoe5X5SYbcd6sNwNBeQ638Q+6txZqAvzP2ooYr/lPuNMtOU7+QQBgRUhhofIUh+NYU0x6qkGJCeFGVroHL2Q8GvTNb6ULkFcGxAa8VpjZmG/eIkLNEB/ded+Fb8dae5aobIWpfGfvqrF2EdUoLtbmPYff4rFPGJK57TOJelCo5wug4jDwwNF585U0rprOVvBAMnR5jVlDzL8Z9+a4XgupUnlUFZypmr1ZFHJpGHLlUXoLgapIf7EUwVsdqhRV+LioNyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(6506007)(53546011)(2906002)(66946007)(31696002)(508600001)(66556008)(31686004)(5660300002)(8676002)(66476007)(186003)(6486002)(8936002)(4326008)(30864003)(38100700002)(6512007)(2616005)(83380400001)(86362001)(6666004)(36756003)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lSUjA1VjFqVUFSK21xandsZXQ5eEZiWXd3bVZaNWtmYThhUXUxK3h4b3Z2?=
 =?utf-8?B?T2w0NmVPRHJ5cGNjaGhQMWVzMldSUXJNTktZTHJhMGZCNVdXQVR6YTlTUVJa?=
 =?utf-8?B?eU1Hbmorc0FkRXBDSWJqMHlXTWJya0dFSC8wME02czNtajQ0SElYYTA4SUE4?=
 =?utf-8?B?NHlGSE5vOFRWOW1malY2OHFOQ1FRT2VvTGNnblZJbnJoSHZQVWlQY2ZraUFT?=
 =?utf-8?B?M0hvUXFybXJqUnprcThZTXMyT3Z3YVVhc0lFN3l2aHpLdnRPRnZkQlR6OVEz?=
 =?utf-8?B?am9vU2ZnNzhiM0J2WjB2L21uZ2k1OEVLemhuUEg2bzNSZGliNW8xN0ZPVHFM?=
 =?utf-8?B?UTFaSWk5aHN1cGtraDhPZnRCOHJSWXU4Z2NvOVFGTkNpNkZSTUFWeC9Ydkg3?=
 =?utf-8?B?VjZUcEV1VUhpbW9MTTFXaHp1WW1JWTExYjFrcHVYSDlmOUlHa2FtaUlFT2V3?=
 =?utf-8?B?NzZPMGVUYklwS3Jxd0llS2srcnpXTjVwTDQvY0d1WnE3UHdWZGRXWVlMRlov?=
 =?utf-8?B?ZXU5ZDJicmFSTEdYTTRBMG1zN2dqZkxBT0FaaE90T1liZFpJTG9ORFRaMUZY?=
 =?utf-8?B?UW1WTkJEM01Jb3hjWlJSaWcxQmY2REpxdGU1b1FXZ2ZWNk1nUnVZd0NHRDNo?=
 =?utf-8?B?NTVyWnQzS2c5S29xZTJYSFVHNDkvNmQyWldLNlJ5UUxMQjZrY2p2VmltQnVk?=
 =?utf-8?B?UU1RQTRvak9QRkl4WnVuSzFHL3MrZ3QrUEhtcWlMZGFweDhUdWR5akV3QjVr?=
 =?utf-8?B?amhlMEhmT1dpczdVb1QrOE0vQUVveU5VZ3p4Rkl5cDBUTVNML0I4L1dqQVgr?=
 =?utf-8?B?UzZNWXdPOGxKN1lxMlV5TVVzQUJQK1ppbHBuUmlHTVQ1Z0x2N0FMOGNUQnUv?=
 =?utf-8?B?emhEaEZLS0hyb1AzZkk4MUUyT2IyS2MvMFRPeGN0RUUrc2gxdS8xeURtd0Rq?=
 =?utf-8?B?WDNCd2lnbGtSMmZ1QjA5WmhrY0RaWXorR0s4cHpQQk42dDdBRmdyVXZVMmEr?=
 =?utf-8?B?aU5iNGt3NEFucTVyT2UyL3NMdkpZNUloeUVzelBZYkdLbHR2bVVaQjFXY0RB?=
 =?utf-8?B?d1AzSjdmTEVQMkZUSERqRHE1SElya0RCb3lmV3o1eWE5K3l0K3dNN1h0cVlE?=
 =?utf-8?B?MWorT3JjZ1dDN1lzcDZtUTZZSXdjSHNUaEJDWGw0anBuS2oram5JWlY0RlZq?=
 =?utf-8?B?cWFlQW1pV2NFRmc4Sktpck5MdWZDN3ZNZHQvK3JUTjFFK1kyeTNBY1Z3anJO?=
 =?utf-8?B?YTZKb2pVeE5Cc0JJaDB5b3JOZURNOE9tOHpnVXR5eEhtNUtMcnI5RTNhMWo2?=
 =?utf-8?B?bi90ZzlrRWV4a0had1l6eWN1Z3h2WnNxNkhVU0g5b3lVZVp2dTBPQ2xiSVZi?=
 =?utf-8?B?OEgrYVNxYTZ2ODZVWE5QTWVYbjFnT1BseEVpUWxMSGg2Z09GRWNjeVg0MzFv?=
 =?utf-8?B?TUdZdFNsUmlOSVhzbkY5MkdtZWdJRWV5RUZYck5pd2pwMEI0dm5LSmxLcnRF?=
 =?utf-8?B?RHUvQUh2U3c5YjZCWklNb1AvbzlBSVNFNzBqSVZ6TU1FbEduUmsxejg4aWll?=
 =?utf-8?B?Z2xPV240ZitwUXphRzBKc1RFRVFtUXFLdnlJV1llY3hIT3YvTUo1dUhZbnFp?=
 =?utf-8?B?NXNRck1qZXpxdlZiL0pUS3oxcFRZclRpd2F3a0FQb2JIYTgxcjBrVVBkakF2?=
 =?utf-8?B?dmRoYVRaU2xiSXBWeVJlU09mUUwvUVVHaEh4cWRIV21IL0RZWE9SWXpObW4r?=
 =?utf-8?B?NVVXT3JvZUkybGhpZlZibElKV1ArRGhQeWVoRWx6K3Y0OUpWZENyMGFSQVoz?=
 =?utf-8?B?VllQNGkzTWgxSTBHdXRJVTRLNFNVL1ZxY1JUL3hSbUJlSjIvNUlLR2JYdWhU?=
 =?utf-8?B?SnVYRGQ3SFJtTGtnNmZmZFV4dG8xS3ZWU0FrbzhVZEZUejVxdEZYK25kUnRL?=
 =?utf-8?B?NjJCRTdMQ3FaUW5rQUl1alR0dC9JT2FIRkJMcURJUzZSMW8wOThWRHkvUHNF?=
 =?utf-8?B?NGJIUUQ2ZjZ4a3NBTDkrLzZXb0VMTmhzTzY4dGR4VEsrSFBzTHFlcVk5MS8v?=
 =?utf-8?B?T0VJdjFNd1FXUlBjbHJWTTV3b1JXN3FxNVBiK2tUK2lSanpkUWl4R2t0N2o4?=
 =?utf-8?Q?iJAk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc89c97-9516-4a9f-eaf7-08d9bb0c3732
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:05:39.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkPrtaG12IIEYmTlZXp08iOkQIppPHvyaNpxJ5q1kei3kvL/uce7XfzXQtl+qdmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/3/2021 8:35 AM, Evan Quan wrote:
> Display is another client of our power APIs. It's not proper to spike
> into power implementation details there.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ic897131e16473ed29d3d7586d822a55c64e6574a
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 246 +++++++-----------
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 218 ++++++++++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  38 +++
>   4 files changed, 344 insertions(+), 164 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7837e0613717..2c6c840e14a1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2136,12 +2136,8 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   
>   static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
>   {
> -	struct smu_context *smu = &adev->smu;
>   	int ret = 0;
>   
> -	if (!is_support_sw_smu(adev))
> -		return 0;
> -
>   	/* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
>   	 * on window driver dc implementation.
>   	 * For Navi1x, clock settings of dcn watermarks are fixed. the settings
> @@ -2180,7 +2176,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
>   		return 0;
>   	}
>   
> -	ret = smu_write_watermarks_table(smu);
> +	ret = amdgpu_dpm_write_watermarks_table(adev);
>   	if (ret) {
>   		DRM_ERROR("Failed to update WMTABLE!\n");
>   		return ret;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index eba270121698..46550811da00 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -99,10 +99,7 @@ bool dm_pp_apply_display_requirements(
>   			adev->pm.pm_display_cfg.displays[i].controller_id = dc_cfg->pipe_idx + 1;
>   		}
>   
> -		if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->display_configuration_change)
> -			adev->powerplay.pp_funcs->display_configuration_change(
> -				adev->powerplay.pp_handle,
> -				&adev->pm.pm_display_cfg);
> +		amdgpu_dpm_display_configuration_change(adev, &adev->pm.pm_display_cfg);
>   
>   		amdgpu_pm_compute_clocks(adev);
>   	}
> @@ -298,31 +295,25 @@ bool dm_pp_get_clock_levels_by_type(
>   		struct dm_pp_clock_levels *dc_clks)
>   {
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
>   	struct amd_pp_clocks pp_clks = { 0 };
>   	struct amd_pp_simple_clock_info validation_clks = { 0 };
>   	uint32_t i;
>   
> -	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_clock_by_type) {
> -		if (adev->powerplay.pp_funcs->get_clock_by_type(pp_handle,
> -			dc_to_pp_clock_type(clk_type), &pp_clks)) {
> -			/* Error in pplib. Provide default values. */
> -			get_default_clock_levels(clk_type, dc_clks);
> -			return true;
> -		}
> +	if (amdgpu_dpm_get_clock_by_type(adev,
> +		dc_to_pp_clock_type(clk_type), &pp_clks)) {
> +		/* Error in pplib. Provide default values. */
> +		get_default_clock_levels(clk_type, dc_clks);
> +		return true;
>   	}
>   
>   	pp_to_dc_clock_levels(&pp_clks, dc_clks, clk_type);
>   
> -	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_display_mode_validation_clocks) {
> -		if (adev->powerplay.pp_funcs->get_display_mode_validation_clocks(
> -						pp_handle, &validation_clks)) {
> -			/* Error in pplib. Provide default values. */
> -			DRM_INFO("DM_PPLIB: Warning: using default validation clocks!\n");
> -			validation_clks.engine_max_clock = 72000;
> -			validation_clks.memory_max_clock = 80000;
> -			validation_clks.level = 0;
> -		}
> +	if (amdgpu_dpm_get_display_mode_validation_clks(adev, &validation_clks)) {
> +		/* Error in pplib. Provide default values. */
> +		DRM_INFO("DM_PPLIB: Warning: using default validation clocks!\n");
> +		validation_clks.engine_max_clock = 72000;
> +		validation_clks.memory_max_clock = 80000;
> +		validation_clks.level = 0;
>   	}
>   
>   	DRM_INFO("DM_PPLIB: Validation clocks:\n");
> @@ -370,18 +361,14 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
>   	struct dm_pp_clock_levels_with_latency *clk_level_info)
>   {
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
>   	struct pp_clock_levels_with_latency pp_clks = { 0 };
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int ret;
>   
> -	if (pp_funcs && pp_funcs->get_clock_by_type_with_latency) {
> -		ret = pp_funcs->get_clock_by_type_with_latency(pp_handle,
> -						dc_to_pp_clock_type(clk_type),
> -						&pp_clks);
> -		if (ret)
> -			return false;
> -	}
> +	ret = amdgpu_dpm_get_clock_by_type_with_latency(adev,
> +					dc_to_pp_clock_type(clk_type),
> +					&pp_clks);
> +	if (ret)
> +		return false;
>   
>   	pp_to_dc_clock_levels_with_latency(&pp_clks, clk_level_info, clk_type);
>   
> @@ -394,18 +381,14 @@ bool dm_pp_get_clock_levels_by_type_with_voltage(
>   	struct dm_pp_clock_levels_with_voltage *clk_level_info)
>   {
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
>   	struct pp_clock_levels_with_voltage pp_clk_info = {0};
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int ret;
>   
> -	if (pp_funcs && pp_funcs->get_clock_by_type_with_voltage) {
> -		ret = pp_funcs->get_clock_by_type_with_voltage(pp_handle,
> -						dc_to_pp_clock_type(clk_type),
> -						&pp_clk_info);
> -		if (ret)
> -			return false;
> -	}
> +	ret = amdgpu_dpm_get_clock_by_type_with_voltage(adev,
> +					dc_to_pp_clock_type(clk_type),
> +					&pp_clk_info);
> +	if (ret)
> +		return false;
>   
>   	pp_to_dc_clock_levels_with_voltage(&pp_clk_info, clk_level_info, clk_type);
>   
> @@ -417,19 +400,16 @@ bool dm_pp_notify_wm_clock_changes(
>   	struct dm_pp_wm_sets_with_clock_ranges *wm_with_clock_ranges)
>   {
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
>   	/*
>   	 * Limit this watermark setting for Polaris for now
>   	 * TODO: expand this to other ASICs
>   	 */
> -	if ((adev->asic_type >= CHIP_POLARIS10) && (adev->asic_type <= CHIP_VEGAM)
> -	     && pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges) {
> -		if (!pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
> +	if ((adev->asic_type >= CHIP_POLARIS10) &&
> +	     (adev->asic_type <= CHIP_VEGAM) &&
> +	     !amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
>   						(void *)wm_with_clock_ranges))
>   			return true;
> -	}
>   
>   	return false;
>   }
> @@ -456,12 +436,10 @@ bool dm_pp_apply_clock_for_voltage_request(
>   	if (!pp_clock_request.clock_type)
>   		return false;
>   
> -	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->display_clock_voltage_request)
> -		ret = adev->powerplay.pp_funcs->display_clock_voltage_request(
> -			adev->powerplay.pp_handle,
> -			&pp_clock_request);
> -	if (ret)
> +	ret = amdgpu_dpm_display_clock_voltage_request(adev, &pp_clock_request);
> +	if (ret && (ret != -EOPNOTSUPP))
>   		return false;
> +
>   	return true;
>   }
>   
> @@ -471,15 +449,8 @@ bool dm_pp_get_static_clocks(
>   {
>   	struct amdgpu_device *adev = ctx->driver_context;
>   	struct amd_pp_clock_info pp_clk_info = {0};
> -	int ret = 0;
>   
> -	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_current_clocks)
> -		ret = adev->powerplay.pp_funcs->get_current_clocks(
> -			adev->powerplay.pp_handle,
> -			&pp_clk_info);
> -	else
> -		return false;
> -	if (ret)
> +	if (amdgpu_dpm_get_current_clocks(adev, &pp_clk_info))
>   		return false;
>   
>   	static_clk_info->max_clocks_state = pp_to_dc_powerlevel_state(pp_clk_info.max_clocks_state);
> @@ -494,8 +465,6 @@ static void pp_rv_set_wm_ranges(struct pp_smu *pp,
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	struct dm_pp_wm_sets_with_clock_ranges_soc15 wm_with_clock_ranges;
>   	struct dm_pp_clock_range_for_dmif_wm_set_soc15 *wm_dce_clocks = wm_with_clock_ranges.wm_dmif_clocks_ranges;
>   	struct dm_pp_clock_range_for_mcif_wm_set_soc15 *wm_soc_clocks = wm_with_clock_ranges.wm_mcif_clocks_ranges;
> @@ -536,72 +505,48 @@ static void pp_rv_set_wm_ranges(struct pp_smu *pp,
>   				ranges->writer_wm_sets[i].min_drain_clk_mhz * 1000;
>   	}
>   
> -	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
> -		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
> -							   &wm_with_clock_ranges);
> +	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
> +						    &wm_with_clock_ranges);
>   }
>   
>   static void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	if (pp_funcs && pp_funcs->notify_smu_enable_pwe)
> -		pp_funcs->notify_smu_enable_pwe(pp_handle);
> +	amdgpu_dpm_notify_smu_enable_pwe(adev);
>   }
>   
>   static void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	if (!pp_funcs || !pp_funcs->set_active_display_count)
> -		return;
> -
> -	pp_funcs->set_active_display_count(pp_handle, count);
> +	amdgpu_dpm_set_active_display_count(adev, count);
>   }
>   
>   static void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -	if (!pp_funcs || !pp_funcs->set_min_deep_sleep_dcefclk)
> -		return;
>   
> -	pp_funcs->set_min_deep_sleep_dcefclk(pp_handle, clock);
> +	amdgpu_dpm_set_min_deep_sleep_dcefclk(adev, clock);
>   }
>   
>   static void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	if (!pp_funcs || !pp_funcs->set_hard_min_dcefclk_by_freq)
> -		return;
> -
> -	pp_funcs->set_hard_min_dcefclk_by_freq(pp_handle, clock);
> +	amdgpu_dpm_set_hard_min_dcefclk_by_freq(adev, clock);
>   }
>   
>   static void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -	if (!pp_funcs || !pp_funcs->set_hard_min_fclk_by_freq)
> -		return;
>   
> -	pp_funcs->set_hard_min_fclk_by_freq(pp_handle, mhz);
> +	amdgpu_dpm_set_hard_min_fclk_by_freq(adev, mhz);
>   }
>   
>   static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
> @@ -609,11 +554,8 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
> -		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle, ranges);
> +	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev, ranges);
>   
>   	return PP_SMU_RESULT_OK;
>   }
> @@ -622,14 +564,13 @@ static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
> -	if (!pp_funcs || !pp_funcs->set_active_display_count)
> +	ret = amdgpu_dpm_set_active_display_count(adev, count);
> +	if (ret == -EOPNOTSUPP)
>   		return PP_SMU_RESULT_UNSUPPORTED;
> -
> -	/* 0: successful or smu.ppt_funcs->set_display_count = NULL;  1: fail */
> -	if (pp_funcs->set_active_display_count(pp_handle, count))
> +	else if (ret)
> +		/* 0: successful or smu.ppt_funcs->set_display_count = NULL;  1: fail */
>   		return PP_SMU_RESULT_FAIL;
>   
>   	return PP_SMU_RESULT_OK;
> @@ -640,14 +581,13 @@ pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -	if (!pp_funcs || !pp_funcs->set_min_deep_sleep_dcefclk)
> -		return PP_SMU_RESULT_UNSUPPORTED;
> +	int ret = 0;
>   
>   	/* 0: successful or smu.ppt_funcs->set_deep_sleep_dcefclk = NULL;1: fail */
> -	if (pp_funcs->set_min_deep_sleep_dcefclk(pp_handle, mhz))
> +	ret = amdgpu_dpm_set_min_deep_sleep_dcefclk(adev, mhz);
> +	if (ret == -EOPNOTSUPP)
> +		return PP_SMU_RESULT_UNSUPPORTED;
> +	else if (ret)
>   		return PP_SMU_RESULT_FAIL;
>   
>   	return PP_SMU_RESULT_OK;
> @@ -658,12 +598,8 @@ static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	struct pp_display_clock_request clock_req;
> -
> -	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
> -		return PP_SMU_RESULT_UNSUPPORTED;
> +	int ret = 0;
>   
>   	clock_req.clock_type = amd_pp_dcef_clock;
>   	clock_req.clock_freq_in_khz = mhz * 1000;
> @@ -671,7 +607,10 @@ static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
>   	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
>   	 * 1: fail
>   	 */
> -	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
> +	ret = amdgpu_dpm_display_clock_voltage_request(adev, &clock_req);
> +	if (ret == -EOPNOTSUPP)
> +		return PP_SMU_RESULT_UNSUPPORTED;
> +	else if (ret)
>   		return PP_SMU_RESULT_FAIL;
>   
>   	return PP_SMU_RESULT_OK;
> @@ -682,12 +621,8 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	struct pp_display_clock_request clock_req;
> -
> -	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
> -		return PP_SMU_RESULT_UNSUPPORTED;
> +	int ret = 0;
>   
>   	clock_req.clock_type = amd_pp_mem_clock;
>   	clock_req.clock_freq_in_khz = mhz * 1000;
> @@ -695,7 +630,10 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
>   	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
>   	 * 1: fail
>   	 */
> -	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
> +	ret = amdgpu_dpm_display_clock_voltage_request(adev, &clock_req);
> +	if (ret == -EOPNOTSUPP)
> +		return PP_SMU_RESULT_UNSUPPORTED;
> +	else if (ret)
>   		return PP_SMU_RESULT_FAIL;
>   
>   	return PP_SMU_RESULT_OK;
> @@ -706,14 +644,10 @@ static enum pp_smu_status pp_nv_set_pstate_handshake_support(
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	if (pp_funcs && pp_funcs->display_disable_memory_clock_switch) {
> -		if (pp_funcs->display_disable_memory_clock_switch(pp_handle,
> -								  !pstate_handshake_supported))
> -			return PP_SMU_RESULT_FAIL;
> -	}
> +	if (amdgpu_dpm_display_disable_memory_clock_switch(adev,
> +							  !pstate_handshake_supported))
> +		return PP_SMU_RESULT_FAIL;
>   
>   	return PP_SMU_RESULT_OK;
>   }
> @@ -723,12 +657,8 @@ static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	struct pp_display_clock_request clock_req;
> -
> -	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
> -		return PP_SMU_RESULT_UNSUPPORTED;
> +	int ret = 0;
>   
>   	switch (clock_id) {
>   	case PP_SMU_NV_DISPCLK:
> @@ -748,7 +678,10 @@ static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
>   	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
>   	 * 1: fail
>   	 */
> -	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
> +	ret = amdgpu_dpm_display_clock_voltage_request(adev, &clock_req);
> +	if (ret == -EOPNOTSUPP)
> +		return PP_SMU_RESULT_UNSUPPORTED;
> +	else if (ret)
>   		return PP_SMU_RESULT_FAIL;
>   
>   	return PP_SMU_RESULT_OK;
> @@ -759,16 +692,16 @@ static enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
> -	if (!pp_funcs || !pp_funcs->get_max_sustainable_clocks_by_dc)
> +	ret = amdgpu_dpm_get_max_sustainable_clocks_by_dc(adev,
> +							  max_clocks);
> +	if (ret == -EOPNOTSUPP)
>   		return PP_SMU_RESULT_UNSUPPORTED;
> +	else if (ret)
> +		return PP_SMU_RESULT_FAIL;
>   
> -	if (!pp_funcs->get_max_sustainable_clocks_by_dc(pp_handle, max_clocks))
> -		return PP_SMU_RESULT_OK;
> -
> -	return PP_SMU_RESULT_FAIL;
> +	return PP_SMU_RESULT_OK;
>   }
>   
>   static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
> @@ -776,18 +709,17 @@ static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
> -	if (!pp_funcs || !pp_funcs->get_uclk_dpm_states)
> +	ret = amdgpu_dpm_get_uclk_dpm_states(adev,
> +					     clock_values_in_khz,
> +					    num_states);
> +	if (ret == -EOPNOTSUPP)
>   		return PP_SMU_RESULT_UNSUPPORTED;
> +	else if (ret)
> +		return PP_SMU_RESULT_FAIL;
>   
> -	if (!pp_funcs->get_uclk_dpm_states(pp_handle,
> -					   clock_values_in_khz,
> -					   num_states))
> -		return PP_SMU_RESULT_OK;
> -
> -	return PP_SMU_RESULT_FAIL;
> +	return PP_SMU_RESULT_OK;
>   }
>   
>   static enum pp_smu_status pp_rn_get_dpm_clock_table(
> @@ -795,16 +727,15 @@ static enum pp_smu_status pp_rn_get_dpm_clock_table(
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
> -	if (!pp_funcs || !pp_funcs->get_dpm_clock_table)
> +	ret = amdgpu_dpm_get_dpm_clock_table(adev, clock_table);
> +	if (ret == -EOPNOTSUPP)
>   		return PP_SMU_RESULT_UNSUPPORTED;
> +	else if (ret)
> +		return PP_SMU_RESULT_FAIL;
>   
> -	if (!pp_funcs->get_dpm_clock_table(pp_handle, clock_table))
> -		return PP_SMU_RESULT_OK;
> -
> -	return PP_SMU_RESULT_FAIL;
> +	return PP_SMU_RESULT_OK;
>   }
>   
>   static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
> @@ -812,11 +743,8 @@ static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
>   {
>   	const struct dc_context *ctx = pp->dm;
>   	struct amdgpu_device *adev = ctx->driver_context;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
> -		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle, ranges);
> +	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev, ranges);
>   
>   	return PP_SMU_RESULT_OK;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 2c789eb5d066..3a84c3995f2d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1659,6 +1659,14 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>   	}
>   }
>   
> +int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return 0;
> +
> +	return smu_write_watermarks_table(&adev->smu);
> +}
> +
>   int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
>   			      enum smu_event_type event,
>   			      uint64_t event_arg)
> @@ -2158,3 +2166,213 @@ void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
>   
>   	amdgpu_smu_stb_debug_fs_init(adev);
>   }
> +
> +int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
> +					    const struct amd_pp_display_configuration *input)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->display_configuration_change)
> +		return 0;
> +
Same comments as in the other patch. Let the caller decide what to do 
when operation is not supported.

> +	return pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
> +						      input);
> +}
> +
> +int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
> +				 enum amd_pp_clock_type type,
> +				 struct amd_pp_clocks *clocks)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_clock_by_type)
> +		return 0;
> +
> +	return pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
> +					   type,
> +					   clocks);
> +}
> +
> +int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
> +						struct amd_pp_simple_clock_info *clocks)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_display_mode_validation_clocks)
> +		return 0;
> +
> +	return pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
> +							    clocks);
> +}
> +
> +int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
> +					      enum amd_pp_clock_type type,
> +					      struct pp_clock_levels_with_latency *clocks)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_clock_by_type_with_latency)
> +		return 0;
> +
> +	return pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
> +							type,
> +							clocks);
> +}
> +
> +int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
> +					      enum amd_pp_clock_type type,
> +					      struct pp_clock_levels_with_voltage *clocks)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_clock_by_type_with_voltage)
> +		return 0;
> +
> +	return pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
> +							type,
> +							clocks);
> +}
> +
> +int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
> +					       void *clock_ranges)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_watermarks_for_clocks_ranges)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
> +							  clock_ranges);
> +}
> +
> +int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
> +					     struct pp_display_clock_request *clock)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->display_clock_voltage_request)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
> +						       clock);
> +}
> +
> +int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
> +				  struct amd_pp_clock_info *clocks)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_current_clocks)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
> +					    clocks);
> +}
> +
> +void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->notify_smu_enable_pwe)
> +		return;
> +

These void funcs also need to have valid return value and if operation 
is not supported, let the caller know. Implementation in a particular 
context vs when refactored into standalone APIs need not be the same.

Thanks,
Lijo

> +	pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
> +}
> +
> +int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
> +					uint32_t count)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_active_display_count)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
> +						  count);
> +}
> +
> +int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
> +					  uint32_t clock)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_min_deep_sleep_dcefclk)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
> +						    clock);
> +}
> +
> +void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
> +					     uint32_t clock)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
> +		return;
> +
> +	pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
> +					       clock);
> +}
> +
> +void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
> +					  uint32_t clock)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_hard_min_fclk_by_freq)
> +		return;
> +
> +	pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
> +					    clock);
> +}
> +
> +int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
> +						   bool disable_memory_clock_switch)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->display_disable_memory_clock_switch)
> +		return 0;
> +
> +	return pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
> +							     disable_memory_clock_switch);
> +}
> +
> +int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
> +						struct pp_smu_nv_clock_table *max_clocks)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
> +							  max_clocks);
> +}
> +
> +enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
> +						  unsigned int *clock_values_in_khz,
> +						  unsigned int *num_states)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_uclk_dpm_states)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
> +					     clock_values_in_khz,
> +					     num_states);
> +}
> +
> +int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
> +				   struct dpm_clocks *clock_table)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_dpm_clock_table)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
> +					     clock_table);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 039c40b1d0cb..fea203a79cb4 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -500,6 +500,7 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>   				        enum pp_clock_type type,
>   				        uint32_t min,
>   				        uint32_t max);
> +int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev);
>   int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
>   		       uint64_t event_arg);
>   int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
> @@ -578,4 +579,41 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>   			    size_t size);
>   int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
>   void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
> +int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
> +					    const struct amd_pp_display_configuration *input);
> +int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
> +				 enum amd_pp_clock_type type,
> +				 struct amd_pp_clocks *clocks);
> +int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
> +						struct amd_pp_simple_clock_info *clocks);
> +int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
> +					      enum amd_pp_clock_type type,
> +					      struct pp_clock_levels_with_latency *clocks);
> +int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
> +					      enum amd_pp_clock_type type,
> +					      struct pp_clock_levels_with_voltage *clocks);
> +int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
> +					       void *clock_ranges);
> +int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
> +					     struct pp_display_clock_request *clock);
> +int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
> +				  struct amd_pp_clock_info *clocks);
> +void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev);
> +int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
> +					uint32_t count);
> +int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
> +					  uint32_t clock);
> +void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
> +					     uint32_t clock);
> +void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
> +					  uint32_t clock);
> +int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
> +						   bool disable_memory_clock_switch);
> +int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
> +						struct pp_smu_nv_clock_table *max_clocks);
> +enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
> +						  unsigned int *clock_values_in_khz,
> +						  unsigned int *num_states);
> +int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
> +				   struct dpm_clocks *clock_table);
>   #endif
> 
