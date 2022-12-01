Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F49C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 00:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462CA10E50F;
	Thu,  1 Dec 2022 00:02:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6251010E502
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 00:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd7jZ1mejMpCP0eh119xzBj1LR3uOrd9ZtfAG15RkID+hxx0Kky5t2a56/4dIG1XNeQhfyrfCAjSYJG0CFR+Z8Q74W+xBJkKLbP7KWPwwyyI9v3aWuAvGVVsR0vic8iYUKX90Q6iGyvrQ/hYPui/XJ2ADrr6hgdbb6IoaSxS9RDhyS2Tr4Bj00qUGxStCEi7PGu9illb/QNz6CAn0JxXqWJw1GKKlYuNC6aJCG8eZ8G6YH7bGKxFm/RqrhxE0Z/gzOVpmG2gtli3EMPsJjt27rvTSiBjkjOGL6lEY3LS+EwInKdZw4WXKigNEzDW97sLHcGO/CRyiRJLPDlEFNu/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJGh64FH8m5AnYpfUTComBjyR1/TT6D380S1mz6zOcE=;
 b=h7JSNhuHpozHpzyAuoLEFlRsE08H8v5EuDdYDyqJL4rknJVlUePzCZ+MNHNUFAmrW+q+NxNI2nZaTpsV8G8EeevMLV5ddmLCtabrz23Rth1GPXSM7roEw0ZR8N3jjaTpNgxkxLaLnCsdE4rGx2KFUtY3wIz/ZC0eppR2ttIP6jHTxW1a88MhoeSZ44LaArFlUsrpzvSpfmF/WVP6TT+GszBNTg+AxvN4w/WfUWrpAirP4kjIm+dNWZBtbPlMTpPPB/wlGhNZqOoW/JWhjMr8oJkEAmfX5raaqrPtAvH00okAuzy4LFPResjFjSU9MUdgxS+8U+0rfGNwhDjqvpW9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJGh64FH8m5AnYpfUTComBjyR1/TT6D380S1mz6zOcE=;
 b=aTYqWR56y2MeyUrEEsVZK6PShGdKtug/KY2QzbcixyVZgWlqmVTWMaBRZGqhlsTJGqGzIUaHwqIcqN1vaVVJvnKSN8XKDqMmhMifMtEnXQidPnfJlQZoKLhu2UkQQpmfB7ALZVt/BXZMPJlvLg7kZXj3rjC/xShLBy84vZ+jeDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:02:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:02:40 +0000
Message-ID: <ff4a0738-abab-a873-a21d-053c3889d8f8@amd.com>
Date: Wed, 30 Nov 2022 19:02:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 21/29] drm/amdkfd: add debug wave launch mode operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-21-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-21-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:610:4e::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa11819-5148-4d5d-90ce-08dad32f5c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wq0LRfSvZy5CtlCRnM8VlFs8mBSSiPB99joFYGOMJv8USAyfSjXLGbgzB+BeZ5q6kPEFPiOVMnOqPJYvjT2AS58P26QFGXUaM5PCiLMKZGsjnOdprtC+YxH3yDWuEgBwiEfwhcgML97BC9tipOSK/KJz9ZWhmYIQGW8RINDiKEvutwu0GIPSpnU/lfj6blLVFsEnPdOuMesoshpQWf//sl+Ldi/YtDIuoaB8ePzWCmfA2Dom29FclWb3jDJLf4G3sN6LgNOKS0+GqUIKFyjO4LP3XIDERiuNY4zdQrfvmf3ZmvtBcw/tU0BE6EL3KKy1r/UWQc8Q7zrfneatiFa8G+PWRA+a+PQSOIUe46UeIMgfSUx8GY3tYFaqpWpZpv94crMbZ4R9J47WeEgmTpDEMbsgSO4i/y0zgirJB6ZuwcriIczlknQBvWORHPvpCjD2+7yI2qgXs2TiGqhiPT/+H7deiS2/aGnGMOGACDO+aKWorjGuZTsiuanxub3BgCQbd+X+AZa7EDjP8/4hs4z6EhOKYhvGzsN1DjivdH8voopHF86BdH/vd8khDxmF27ivunL8XW2gaDtv1bSPlufKFtorQQGUdvpoADEM5uB+ylUt737SYudkWo1fKJzdGxEM8G1FLeipAoJoiQUEWzyYI5VNDhIa79DlHeAwH1s/sxHN/SD4VEM6fQu4mCctzKnB1rn932hvljVsQuDHCziXDvgHRI44dd1bnT2NiV3x7GI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(8936002)(36916002)(5660300002)(186003)(36756003)(66476007)(41300700001)(66556008)(316002)(8676002)(38100700002)(86362001)(83380400001)(6486002)(6512007)(2616005)(26005)(66946007)(478600001)(31696002)(53546011)(6506007)(2906002)(4001150100001)(31686004)(44832011)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZPeEJ1VEI0eW1MUXdJaHpUbWRwQlMyVmV6UDZXRHZKV1J3SXBHV0kvaUlQ?=
 =?utf-8?B?aVRwNVdrcjRPY0dHTlBQQXlCcXEySTVHbGNVMFRSc3MyTEJFYjlYZTVhbnUx?=
 =?utf-8?B?ZUphWGs2L296NXg0MzZrVkd5RzVjOXJ5V2tQK1p4RlptWEY1QUtWMEdaR0gy?=
 =?utf-8?B?bnBGV1I5YzBlOWNVQXllV1VmTXJJV0hyM1RLVnFTenFwS3Z2cWNONmFuVnBy?=
 =?utf-8?B?dWV5VEdmUHFDbmdtLzFtYXRNR1RTRFdDMmJmeDlNNE1Vd1p0eTFPZ2ZrOXJQ?=
 =?utf-8?B?dkRpaGg5cXBlWUlaRjNXU3AwT1E2K1BuR1FTNEZwdnlMUzZiaVBOaFBWekcr?=
 =?utf-8?B?RCtKa2N3a2c3VkIrSW0ydE1VMHRreHVXOG5ZTkN6ZUJtRU1VN2hHN1lnMXQ4?=
 =?utf-8?B?bXlRTEpXMmJkL2lFeVM3RU5pSUhxYk55b01scjBucWMrU1NSVU5ncDkvanhC?=
 =?utf-8?B?RS9HeC9CbGlEVDROaGF1S29Sa2czQjdLMDdnZ3ZOSGhqcFhQYUxveXNic25I?=
 =?utf-8?B?NFRObjY0RWpTQXZkWmwvSGQ5WjU1ZXpmRzd3N244NVVJdjlHQzJ0bnNLb1Vn?=
 =?utf-8?B?OXpCc3ZSWTJqQjBzVE9UOU1Mb1k2T1BjZTlPVTZ6cHZMTmxJOGpvOGVWek53?=
 =?utf-8?B?d0ZMRjMyYXI5VUdEMHZPVWczdi81dEFEcDd3STFNM2JWbzlnUFY5dE9ET1lv?=
 =?utf-8?B?UTE5N2ZLbHVEUGNMZncyRUJZSE0ydWRJKzU0bVhYaW9VVFF5b0xtcExNN01r?=
 =?utf-8?B?ekJGaVNhV0tRZ1o5RU9acTZoR000VUhqV2dDS0dPZ1ZaTUxmUDVsTGt5YzZn?=
 =?utf-8?B?OGZKZDF2L3I4QXA0WGpwREJZZnpxSHBNSkJhQXd2TkFRVUl6S2dBU3IxZDFK?=
 =?utf-8?B?cks1SUZQVkUyTE50cFZPVTBqM1VHd2FYL2hQR3FDVG0rb01aREdoYjh0aXN4?=
 =?utf-8?B?dmpTVkJ3c3J2VmtURWxNL3ZiTUM3S1Bja3lvMEUwSXA5dkM1MWtmQjlUNmY4?=
 =?utf-8?B?NzZkay9yRkNOZ3NQcEJDVlNHanFadDJiUDNJRGFGa2pMc2VmdER2c0tpY1Fy?=
 =?utf-8?B?a3JYWmlLVEI1MzVlRk9PK1lEZ01lUkdBZjFMSzZQQ0VNUHVmZklzNUZta2p5?=
 =?utf-8?B?eG9jLzRLOE14V0krR1YyT1JUU3EzNEdlZ3A0TzA0d0YvSGhNbHNFa2toTDVG?=
 =?utf-8?B?WEp4QkZlK3NaVHRKeDFSUStIUkZlTVlzMExDQXZHeXdCblZtc3NFbzBsUlJJ?=
 =?utf-8?B?T1Z5aUx6NFFJSWdzNk5tVzI2cTZrcEdDTnk5amVtY0puNWk0SlIwUmJlYzQ3?=
 =?utf-8?B?ZEpvNS8vV0JEUVFOdWpwcjM4RHIyTzRvaDRFMVpIYUpRZXNpVHZjeittQUVM?=
 =?utf-8?B?YkVyeWFxN29DM1NETnJXUWRJcnJaLzRPRDF1cVJnNk9WVXdPclJUOHRacG85?=
 =?utf-8?B?ajU3MHd4cjd0RGFPSldEb0xxZytJRFc5b011enpCb0YwMnRTWXMyV1Q5QkpE?=
 =?utf-8?B?WHo3cHpGMUx2a1NtWnZpNzlYUEpYbk1nL1AvZnFLYUlpOVZ6aHFPSjZIeU42?=
 =?utf-8?B?VU9jOXl1dXoxQnhSblhtMGppMmJkQUZnU3p4UG5NZ3ZsK0RWZVhGSUlCRU9E?=
 =?utf-8?B?VXkyTlBsR3liUUNVSXhnUVBHRCtZa29oQUN4ekU4K1l4ejhNeDZYSEc2aHZW?=
 =?utf-8?B?WTRjOHVhaVNtTms3L21RM0pzR0s0VXVUY0FOOXJoaUMxQms3QndCZVhPeW1s?=
 =?utf-8?B?bGY5Y08wTWNLQ0t6VWQ2cHIrVkpBSWRyckVmZ1RCQkxzMGxnQ1Y1elZaSFR2?=
 =?utf-8?B?TVFiOFVIWUdNVjVDZ2JlMnBIYVpKMG9EUFN4aFNOdzJoM21jV0dLT2x6dGlD?=
 =?utf-8?B?alFjbnJybnVEa3Q5aU9EWWIxbUY0M0hxL29IWjhDQko2YUlCYmJWT1g0SS9p?=
 =?utf-8?B?eURIQ29TWEtuTE5XRW8zWkJJQ2l2cFUzeGxkV2FKNUpJOHBSRktZeG83UGhH?=
 =?utf-8?B?LzdHVm5BUjJGOTBKNDZGUExXeDZPWHVVbDVPVlIwVzVBZ3ZrVy8vWnNUOEhG?=
 =?utf-8?B?R3RLVDFrVE9XeTRBRU1MYVUxcHVkY25RS0o3eGpMRUFxT2thQ0kxNUFEYWJT?=
 =?utf-8?Q?yQvkoi3CLKH76oCbcwZ1p4E7K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa11819-5148-4d5d-90ce-08dad32f5c94
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:02:39.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: All1mhytcEWATBAez4xVVyNpEJKbBPJTcQqwWBgZSFQz7JzKb1BlIkqw5EyoeAKDZ54PIvhjoO4lwzMZK9+fdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Allow the debugger to set wave behaviour on to either normally operate,
> halt at launch, trap on every instruction, terminate immediately or
> stall on allocation.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 18 ++++++++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  1 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 27 +++++++++++++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  3 ++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  3 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 34 +++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 27 ++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  5 ++-
>   10 files changed, 119 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index a5003f6f05bf..91c7fdee883e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -99,6 +99,23 @@ static uint32_t kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device
>   	return data;
>   }
>   
> +static uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
> +					uint8_t wave_launch_mode,
> +					uint32_t vmid)
> +{
> +	uint32_t data = 0;
> +	bool is_stall_mode = wave_launch_mode == KFD_DBG_TRAP_WAVE_LAUNCH_MODE_HALT;
> +
> +	if (is_stall_mode)
> +		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, STALL_VMID,
> +									1);
> +	else
> +		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, LAUNCH_MODE,
> +							wave_launch_mode);
> +
> +	return data;
> +}
> +
>   const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -120,6 +137,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
>   	.validate_trap_override_request = kgd_aldebaran_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
> +	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index b3682758184f..10470f4a4eaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -399,6 +399,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
>   	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
> +	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 32a6e5fbeacd..66a83e6fb9e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -854,6 +854,32 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
> +					uint8_t wave_launch_mode,
> +					uint32_t vmid)
> +{
> +	uint32_t data = 0;
> +	bool is_stall_mode = wave_launch_mode == KFD_DBG_TRAP_WAVE_LAUNCH_MODE_STALL;
> +	bool is_mode_set = wave_launch_mode && !is_stall_mode;
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
> +
> +	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
> +			VMID_MASK, is_mode_set ? 1 << vmid : 0);
> +	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
> +			MODE, is_mode_set ? wave_launch_mode : 0);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL2), data);
> +
> +	if (!is_stall_mode)
> +		kgd_gfx_v10_set_wave_launch_stall(adev, vmid, false);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}
> +
>   /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
>    * The values read are:
>    *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> @@ -941,6 +967,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
>   	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
> +	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
>   	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
>   	.program_trap_handler_settings = program_trap_handler_settings,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 85c929fc2926..34c04a2bb83b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -36,6 +36,9 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   					     uint32_t trap_mask_request,
>   					     uint32_t *trap_mask_prev,
>   					     uint32_t kfd_dbg_trap_cntl_prev);
> +uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
> +					 uint8_t wave_launch_mode,
> +					 uint32_t vmid);
>   void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
>   void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t wait_times,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index ae3ead207df4..8627c5458973 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -675,6 +675,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
>   	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
>   	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
>   	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
> -	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override
> +	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
> +	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode
>   
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index cb0044bbfae5..3bba7ca21926 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -777,6 +777,39 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
> +					uint8_t wave_launch_mode,
> +					uint32_t vmid)
> +{
> +	uint32_t data = 0;
> +	bool is_stall_mode = wave_launch_mode ==
> +				KFD_DBG_TRAP_WAVE_LAUNCH_MODE_STALL;
> +	bool is_mode_set = wave_launch_mode && !is_stall_mode;
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> +
> +	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
> +		VMID_MASK, is_mode_set ? 1 << vmid : 0);
> +	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
> +		MODE, is_mode_set ? wave_launch_mode : 0);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL2), data);
> +
> +	/* Although Pre-GFX9.4.1 stalls globally, the per-VMID stall for
> +	 * GFX9.4.1 effectively does the same thing as global STALL_RA as
> +	 * all other VMID allocations are back logged by the stalled VMID.
> +	 *
> +	 * Use with caution.
> +	 */

This is potentially problematic. Discussing this with the debugger team, 
it turned out that they're not actually using stall mode. So we should 
remove it from the code and the API.

Other than that, this patch looks good to me.

Regards,
   Felix


> +	if (!is_stall_mode)
> +		kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}
> +
>   /* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
>    * The values read are:
>    *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> @@ -1047,6 +1080,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
>   	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
>   	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
> +	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 47cff392b434..2a2ab42037e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -67,6 +67,9 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
>   int kgd_gfx_v9_validate_trap_override_request(struct amdgpu_device *adev,
>   					     uint32_t trap_override,
>   					     uint32_t *trap_mask_supported);
> +uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
> +					uint8_t wave_launch_mode,
> +					uint32_t vmid);
>   uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   					     uint32_t vmid,
>   					     uint32_t trap_override,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1f0ee2413b13..63665279ce4d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2899,6 +2899,9 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				&args->launch_override.support_request_mask);
>   		break;
>   	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
> +		r = kfd_dbg_trap_set_wave_launch_mode(target,
> +				args->launch_mode.launch_mode);
> +		break;
>   	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
>   	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
>   	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 8add359d1cb9..210851f2cdb3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -239,8 +239,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   {
>   	int i, count = 0;
>   
> -	if (!unwind)
> +	if (!unwind) {
>   		cancel_work_sync(&target->debug_event_workarea);
> +		kfd_dbg_trap_set_wave_launch_mode(target, 0);
> +	}
>   
>   	for (i = 0; i < target->n_pdds; i++) {
>   		struct kfd_process_device *pdd = target->pdds[i];
> @@ -507,6 +509,29 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
>   	return r;
>   }
>   
> +int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
> +					uint8_t wave_launch_mode)
> +{
> +	int r = 0, i;
> +
> +	for (i = 0; i < target->n_pdds; i++) {
> +		struct kfd_process_device *pdd = target->pdds[i];
> +
> +		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> +		pdd->spi_dbg_launch_mode = pdd->dev->kfd2kgd->set_wave_launch_mode(
> +				pdd->dev->adev,
> +				wave_launch_mode,
> +				pdd->dev->vm_info.last_vmid_kfd);
> +		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> +
> +		r = debug_refresh_runlist(pdd->dev->dqm);
> +		if (r)
> +			break;
> +	}
> +
> +	return r;
> +}
> +
>   void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   					uint64_t exception_set_mask)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index b54a50a5d310..ca3ab1f01985 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -25,9 +25,6 @@
>   
>   #include "kfd_priv.h"
>   
> -void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
> -					uint32_t vmid,
> -					bool stall);
>   void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
>   int kfd_dbg_trap_activate(struct kfd_process *target);
>   bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
> @@ -51,6 +48,8 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
>   					uint32_t trap_mask_request,
>   					uint32_t *trap_mask_prev,
>   					uint32_t *trap_mask_supported);
> +int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
> +					uint8_t wave_launch_mode);
>   
>   int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   					unsigned int dev_id,
