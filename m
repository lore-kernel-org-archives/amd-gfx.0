Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1665C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 00:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F66610E243;
	Mon,  6 Nov 2023 00:52:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DAC10E243
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 00:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKtsTrdQIg0aWGia2B2KfVyj5mJp7tj+4dgYInBLIMhAOkS9JiQzyukaKRoQh2N1IeYdEoAli088sJ7TjKPJt7h9UgbADSjaWRdN66MEeeorYOatf7AUc7onUOJOb63Nbn9TTegNd+mdYbDanrjRsLe8ZlW6aOnkL0g+yYdfSesFqH8TF1BM4KsCCvH6+P+Sc5kuJanXxRc6skSs/CY5GZdx3p4hD+6AW7wtwUeB4Wfq4CzO+UiN4qVnEUj6xQsKEIsI6LgJv9Cg5xgf+YXlwGx9GOjkFFfSKy2rQ0Q+Wnla04XxaMXyGIEvfPMx2A5Z7DIgDMbI2ITUVg46gPvtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lzv+Nt2sjdYDvG/d/yp8gDYnFV6IwFHotHQ9ZuRYUI=;
 b=UzaZQJ63znNoPX09wwwQ+py0wI+AI5DbAPvNh3gCPeAc0LMYttsM2xFzRspDfLACMO1xnbPApT/fHymLIrBxL1zVDWuzyh04v7KNYo7pBlAvURp0VfAMaYFFMVt9I2YXEPwQLT3rW4ktM31KGJiU3m2r+0KzlNw7BUT5dILFlzzBeIEsXQNDlxR1HX/gkkNeFqrqEU39Syo8Yuohgowxx4alsrqfYYMXQ2JzLkUmajHim8C7P+7hApncpYJ8PiF5DGRvp9Pi9bfM9bUKDK2mFXI9IUniWCiRlTzvTBupfohF5+AbKaKT0NS4h8LB8+Nz4G23zgFBueYcqJDY7CC3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lzv+Nt2sjdYDvG/d/yp8gDYnFV6IwFHotHQ9ZuRYUI=;
 b=NBVtPN3c8MzxESageaQReDARjvS38yVlQbmal4PaUvAf0K6n6ulV4TzALaTFK1VqKxA90/VLp41TT+UUSDTeK2nMhUshU1a2JBsZxiTesmjXB27DnRkVWOXszqfW/yczVwjF/AE5KV6/IZ6UsEEvnOLLwxOqHREz6K1e18FL+yU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 00:51:58 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 00:51:58 +0000
Message-ID: <0a47c4cd-b8b5-498e-8185-2f4270e2514d@amd.com>
Date: Mon, 6 Nov 2023 08:51:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Move some functions to smu_v13_0.c as generic
 code
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
References: <20231103082113.3038890-1-Jun.Ma2@amd.com>
 <PH7PR12MB5997321C7E66526CF227B3CB82A5A@PH7PR12MB5997.namprd12.prod.outlook.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <PH7PR12MB5997321C7E66526CF227B3CB82A5A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CO6PR12MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a14ae3-1e15-4ecb-81c7-08dbde6294ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wotA9P3e7ByhFVAEn91xiWJWRMNCuLqs+/yz/ZvMolrnE/OOcGUQ8pmYQfKeyEnjAYFSpA2BoF390qJYnrDx5dpoulV+HlUY7G1vuqSIUoa4syHAx+JxAEy0vNW5MDEdoeIqb7oxHtPfIwYDhwtZAm9APfbPl1fvQVaGOpV+nPzIsL73H/rKFPXtNo4wfaN9xyl+2ySVTvbBo82GkuoahcDdQtuczL35WOCqE2AOxyNdVU/PFlXwh9ugMixq/qWWSyXtAMDwpQwFsfZ+/6uXhNFS5npcOZ9lQNHate++i1ahqcmPZBSWfuZ78Ov8hgr6/FBXUlVckRS8bCwOZ145OGvCLV+J9rmHlRfulUnhHlTJ3FBpHYwotLqEF3AcdTHi9++lIAb3OXNIDk2A9kZ3CpQn5D+MmlnnvwmwExipoTPJ5H194No4WU7oD8MRiGoEko49HM8F9T67+YTRl+OMgGzPVAnq31RjG0wg88b61pPpLQfQTOXBveG+P2NJS84YblD819oahZRi4NboaLuawhg+fiKnp30uLWj+Y8Ief6iDGAwZ32zxXFuqKo01TnwfUR5k9ByiYYXt8CRA5EmDn3sc3MFQRi0T+nHLzRnptLaVQncbhRfQmcAstHJbU+JsuH//57AXIATX3roHCuUpJqB+2wjbdt1x9xQYyj3iFjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(53546011)(6506007)(2616005)(6512007)(6486002)(478600001)(83380400001)(26005)(2906002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(6636002)(316002)(110136005)(4326008)(8676002)(8936002)(38100700002)(36756003)(31696002)(31686004)(41533002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2JmN3JDQW5PODNYaldpM3R6VjVRcXJyY1NDNGR6czFwaDhnUUIwMy9yOXg4?=
 =?utf-8?B?VlJsYk5tN2FoTE5TU1VyOC81RFRPNDNpSDdqYmRlQ253TU0rUC8zaXY2SkFr?=
 =?utf-8?B?cmVLWGZmdHFETUJEa2hyb0E5a0dsZDhTSmloVFJCV2FSVm1PcjE3N2cxLzEz?=
 =?utf-8?B?T1FDZVRnNzM3SHJ3Sld2dWgyeWVJWDRIenkzcS8xWHJlU0dmQ08yYmc2YmRY?=
 =?utf-8?B?ZTJFZi9QQ0VRWmNvUENUUlJXWnQ4WUZnQTdyNW1xdHh6TloxN0FGSnEyaUpC?=
 =?utf-8?B?UXl5REkrZXlkSURtS3dwdk1wMldtZE1VdjN5YjdDOUZ2YzZ2cDc0eWhhQTUx?=
 =?utf-8?B?VVhzYmxlL2pkUExYTEJqcHVPb0tIcFk3V09OMW1weHNWL3R1R2xiU1ZKcWV6?=
 =?utf-8?B?NzBQdGxWd2NhRjBmandURTB0cmg4d2g0VktzaWF0RzB0VGt0YTh5SUI1cjhL?=
 =?utf-8?B?akNRR0kwZk9Xczl4Uk1tSkxrMi8xZU9UMW5XYTNtdTNxWmREb2ZMbWErVXNN?=
 =?utf-8?B?bWh4aU52Sm1RcEM5ZVZZVGtnelM4VERidFRuaHpEMjBZMVF1eTVhUkFqajRm?=
 =?utf-8?B?N0gyU1RlNFpQWVhKSHhnQmdHNjRmTmJoT1NxK0RMdnBxTUFuVjlYNXN6eFVE?=
 =?utf-8?B?TTU3eGtObHpnOE91TjA0K1BCc1pyMHd1RzNRMjdUNzAyOEZtditsbnJKRmEx?=
 =?utf-8?B?U3FEQ3E5NXY3bUtxa1FDSFFLQ29Lc1VLWXhLdVNtZUthQVlEaTJZT0NXTlNy?=
 =?utf-8?B?OWIyQStLSk1tSEt4QnkydzY4TTIxeExkT2YrRmN0WDJPSmU3NTF1ZmZmRkkx?=
 =?utf-8?B?YXBxVUN6T0tTTHVwUkRuclV6MkNXakxoY2NSekxOTlAwT25yQjdaRmpHWE5y?=
 =?utf-8?B?a2JIM2gvbmtaWWtqNk9qN2pnRlArVWIzODhTOVplMm5pMHFadlFGYXM1VHN1?=
 =?utf-8?B?WTZWUVV5K0xoWjREamZjRTFuM1dUMVFZT2FMeWFiT3Q0RExyWlhzdzFxR2RH?=
 =?utf-8?B?RjNTUnpkRUdSM0FvS2FmSzNlN09QcW1BTmhISzdScmxmSEFxTEFCMlNQMS9x?=
 =?utf-8?B?OVpkWk1Xa0EydzY4UGZtbjNaMDJhNDRMdTJCdUdLVDBSd3pMSnExSGpocnkx?=
 =?utf-8?B?WTltZkxIcGczelpDQm9iVmZFR1NVQWpFR3E3UnNkQjlUSklGYTVUNWpsNU5J?=
 =?utf-8?B?U2ZEa0pOSWFGOFprQW9uVGk3ZU1xOGMxZUpHYmpWd0syTHBVcmNxa2hBSUVl?=
 =?utf-8?B?Rlo2WTVTdDdjZ0xCSzhNWldBVjg5dHMxa2NOQy9VUWt4MU1vREwxS3kwS0p2?=
 =?utf-8?B?UysvUk53NEdkV1psZ0p2cjBlUlRTbFd0NUxLMkN4OERhTlcvcTdhTGpQVEho?=
 =?utf-8?B?bjc3eHlDcGsxUEUrRjJENU5uSlNMbUwySTJ1b0tKSEFYNEw2dkdEbzFaMDJI?=
 =?utf-8?B?TVJlYTFicVN2YVpyTURqQ2x1VEpydEwrem1vQ1FpUkpWSWpUMHE0QWF4T0x5?=
 =?utf-8?B?cXI4YkZkZktzOVNjdzdvcWNRQngwRUJ5d3I3emNET0tHVWppeXFJVlZPd3lv?=
 =?utf-8?B?cUZIcjZNbVpVUXhKTHYreERtaElqNjhuUG1nM04zWCs2UDFsQmgvM3R1ZEp3?=
 =?utf-8?B?SU9yVjJTZjZTWmNNbXRYU240VFZBTmQxN1pPeXMyUmM1WU1ZZDdrcE5zVHF5?=
 =?utf-8?B?WWJveW1PNWFkRUxTMWF1S3VkTzlzaWk4NHZ0bDdPNHltbDh6bzk2eVBNZWhJ?=
 =?utf-8?B?L2srQUoxdjlxNWJnQmNhR2Z0SUg4N3F6N0dlSytvblJqTjNDSDBKK1VyTndk?=
 =?utf-8?B?VFBlSHVKMzZQZ2tLRVIvR2pnOHVLbFJxMlEvcDRkdFJ5VU9VLzRKL2U2TDVl?=
 =?utf-8?B?UUl1c0FJR1VydE9HZjJ6dWRtemZkZWNLdHREM2dtL2dsWitTcUNmWGdSZUUw?=
 =?utf-8?B?Qk9NZEIxSXROdjUzeXQxRG5hVlJQZTZGcHNxNXVqYmkrd1MrV1ZXNjN4b25P?=
 =?utf-8?B?a25oajdYZkJmdVpkVzl1WWx3QU5YSkhYbUExVzRsaXJaL3l5ODF5MUhoaVdE?=
 =?utf-8?B?ek5vSlpzc09YWWtKeGhiVWQ2Z0djVVVpRVdJSUxLRHRKSWR2YWtTYUNxL3pi?=
 =?utf-8?Q?34yagP6Umrjx1hkZ86P54Z5zZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a14ae3-1e15-4ecb-81c7-08dbde6294ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 00:51:58.6800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Asppx3qaPYI29SSNyWD5ze0G7si1RRjJgYhsXwP9c/wxxK1abdF7boymcYfOF4n9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks, will fix it in the next version.

Regards,
Ma Jun

On 11/3/2023 9:31 PM, Wang, Yang(Kevin) wrote:
> 
> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com> 
> Sent: Friday, November 3, 2023 4:21 PM
> To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH] drm/amd/pm: Move some functions to smu_v13_0.c as generic code
> 
> Use generic functions and remove the duplicate code
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 38 ++++++++++++++-----
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 36 +-----------------  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 36 +-----------------
>  3 files changed, 32 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 281c3cb707a5..1f42befcc213 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2282,22 +2282,40 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
>  
>  int smu_v13_0_baco_enter(struct smu_context *smu)  {
> -	int ret = 0;
> -
> -	ret = smu_v13_0_baco_set_state(smu,
> -				       SMU_BACO_STATE_ENTER);
> -	if (ret)
> -		return ret;
> +	struct smu_baco_context *smu_baco = &smu->smu_baco;
> +	struct amdgpu_device *adev = smu->adev;
> +	int ret;
>  
> -	msleep(10);
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
> +		return smu_v13_0_baco_set_armd3_sequence(smu,
> +				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
> +					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
> [kevin]:
> 
> Miss {} here?
> 
> Best Regards,
> Kevin
> +	else {
> +		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
> +		if (!ret)
> +			msleep(10);
> [kevin]:
> Please use usleep_range() function instead of msleep() to keep the same coding style.
> 
> -	return ret;
> +		return ret;
> +	}
>  }
>  
>  int smu_v13_0_baco_exit(struct smu_context *smu)  {
> -	return smu_v13_0_baco_set_state(smu,
> -					SMU_BACO_STATE_EXIT);
> +	struct amdgpu_device *adev = smu->adev;
> +	int ret;
> +
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
> +		/* Wait for PMFW handling for the Dstate change */
> +		usleep_range(10000, 11000);
> +		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
> +	} else {
> +		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
> +	}
> +
> +	if (!ret)
> +		adev->gfx.is_poweron = false;
> +
> +	return ret;
>  }
>  
>  int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 4d3076fe37a1..d715ca2ec121 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2586,38 +2586,6 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  					       NULL);
>  }
>  
> -static int smu_v13_0_0_baco_enter(struct smu_context *smu) -{
> -	struct smu_baco_context *smu_baco = &smu->smu_baco;
> -	struct amdgpu_device *adev = smu->adev;
> -
> -	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
> -		return smu_v13_0_baco_set_armd3_sequence(smu,
> -				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
> -					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
> -	else
> -		return smu_v13_0_baco_enter(smu);
> -}
> -
> -static int smu_v13_0_0_baco_exit(struct smu_context *smu) -{
> -	struct amdgpu_device *adev = smu->adev;
> -	int ret;
> -
> -	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
> -		/* Wait for PMFW handling for the Dstate change */
> -		usleep_range(10000, 11000);
> -		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
> -	} else {
> -		ret = smu_v13_0_baco_exit(smu);
> -	}
> -
> -	if (!ret)
> -		adev->gfx.is_poweron = false;
> -
> -	return ret;
> -}
> -
>  static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)  {
>  	struct amdgpu_device *adev = smu->adev; @@ -3064,8 +3032,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>  	.baco_is_support = smu_v13_0_baco_is_support,
>  	.baco_get_state = smu_v13_0_baco_get_state,
>  	.baco_set_state = smu_v13_0_baco_set_state,
> -	.baco_enter = smu_v13_0_0_baco_enter,
> -	.baco_exit = smu_v13_0_0_baco_exit,
> +	.baco_enter = smu_v13_0_baco_enter,
> +	.baco_exit = smu_v13_0_baco_exit,
>  	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
>  	.mode1_reset = smu_v13_0_0_mode1_reset,
>  	.mode2_reset = smu_v13_0_0_mode2_reset, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 81eafed76045..f5596f031d00 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2515,38 +2515,6 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
>  	return ret;
>  }
>  
> -static int smu_v13_0_7_baco_enter(struct smu_context *smu) -{
> -	struct smu_baco_context *smu_baco = &smu->smu_baco;
> -	struct amdgpu_device *adev = smu->adev;
> -
> -	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
> -		return smu_v13_0_baco_set_armd3_sequence(smu,
> -				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
> -					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
> -	else
> -		return smu_v13_0_baco_enter(smu);
> -}
> -
> -static int smu_v13_0_7_baco_exit(struct smu_context *smu) -{
> -	struct amdgpu_device *adev = smu->adev;
> -	int ret;
> -
> -	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
> -		/* Wait for PMFW handling for the Dstate change */
> -		usleep_range(10000, 11000);
> -		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
> -	} else {
> -		ret = smu_v13_0_baco_exit(smu);
> -	}
> -
> -	if (!ret)
> -		adev->gfx.is_poweron = false;
> -
> -	return ret;
> -}
> -
>  static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)  {
>  	struct amdgpu_device *adev = smu->adev; @@ -2628,8 +2596,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
>  	.baco_is_support = smu_v13_0_baco_is_support,
>  	.baco_get_state = smu_v13_0_baco_get_state,
>  	.baco_set_state = smu_v13_0_baco_set_state,
> -	.baco_enter = smu_v13_0_7_baco_enter,
> -	.baco_exit = smu_v13_0_7_baco_exit,
> +	.baco_enter = smu_v13_0_baco_enter,
> +	.baco_exit = smu_v13_0_baco_exit,
>  	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
>  	.mode1_reset = smu_v13_0_mode1_reset,
>  	.set_mp1_state = smu_v13_0_7_set_mp1_state,
> --
> 2.34.1
> 
