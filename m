Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CAAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 09:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D9510E46C;
	Mon, 11 Apr 2022 09:05:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CE510E46C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 09:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR5836A7E3qBD0Q7Nb4Brn8N+swi+pzicu5WIwIyNXDj+JYGfmI9oad1CTgJjuvULu4ynpLaig3ot1Qvu+jsbbJ2caVpnFp9D+zrta7MhjBNuvPdMXfak0YY6EajK2jeE8SUrJEUMkZocPhP2hN/Niul0jxJ7mQVfZQoUXxaxt2KQEUYxhU+O/6kKtVAmcQ2NLhF0Oohxf0H+j/V0Rx+XeBG4T9yzJohTTWcHmrvB8LjX48nJ6g8soXtalmLn1wD42cQO++JVtplCQixulZR6Evs3/6nLg5+BJOM+Fsc04LGIs1u3ZHgAt2z23xZ8NFrLgWn/OBvmf3L8yrAwOhXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8v5HCEXjqy1v4hwtn5xDxDUK9RXeigBHTw1UcvIdZM=;
 b=Mp+xkAJc51cCQi2nLuObI02HyLUhi8IQdHIhZsmRTKXLGgbnih9dZREVkyYkB2NgFTWbdSItLlNNwT6s2GrYr+GixrYtKFqSgUKl6mwQnqtVVO25ocXEc4ZP11l6pCLgU7Eio/MxvsXyrmPFTP55GcBd4294dmFHi2SUN2/3TyMOuRCGJYG3oG8JI6hZkuboKLVsvygWWhBQKypM+2kZ5pFjpfb4VcXjXM/8urwCZpz4C/otn2UuGD997+odityXlh/2E8+fCbhcy4WQwUStuy7Wyb6GaWVmY/kOiMYl/zezcFMwnj0NwuarQUY7TD7fSapOzOue/mvWE8F/pNJk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8v5HCEXjqy1v4hwtn5xDxDUK9RXeigBHTw1UcvIdZM=;
 b=AHsoXtXtKqKCMut684UahopKqJVJ7nfEHbEqNG+E6kf8GZ3DuxcpTLq3mtRilLs7yKwSpLXYbwOIg8gmiEbXj81xA4AhoshZujSEKVHlHx6NgbuiSzV1OonxTlMP8UlBuN4EAqrj+u74vff7uAY9ek7tz2eZfGry8lFzg7i4Jcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB5525.namprd12.prod.outlook.com (2603:10b6:a03:1df::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 09:05:36 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 09:05:36 +0000
Message-ID: <23716ed2-95a0-8f23-1f82-9d8f5b02f41e@amd.com>
Date: Mon, 11 Apr 2022 14:35:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220411074732.36486-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220411074732.36486-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a87b25d-723e-469c-900d-08da1b9a7102
X-MS-TrafficTypeDiagnostic: BY5PR12MB5525:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5525685487DBA3883AFF9E3B97EA9@BY5PR12MB5525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dm6OBlzzm7waya/EWpRGq20gjIgAmnEJaWrNd30+mWyzsOg2oYqj6EnTRG5n0rj5KoCRpgY3gZXVPMiRZQr84Mbks4fDAM/hdk9odYh3LTJArtSPMAAPwU9QIR0VbagpvCGM9fwm+RtdNtf+05lc+N4IGcp9onD9d5yQw6qNTWETj9PWU/K4GUwUgR1/1aZKrHVNnEdLh6iZyDIbmhMQ/GTKtyH5Lvz+BDI0aUTKvXgouFRh/oYdGWcyk41j0BOyTowAUbGQyQJlHE0jBfsRmrzpl1b6hHAwssd2O7CE5RCIzIZ9IGB9UkmZQMdUF7R3aAO5Y6AlH+kKbEoiGFhcbpXBe/Yt1I2BWmPDLJYHL1W6XIUiF/SOm2euocQrhWlPxIYnFT5ynHD6ra3tsPAKQe/ZsiAK0pAybqKOhpGy0dRdXcIwbdjYnRt+BeTs7G0S5p9g8dCgy6t3Xg6pj3Od/2eel/Gm0D/aq2m3OtGe7Z+tKDbbkLf3FD9zp3Xo1/f2FdZPCVImQz1l7inSlU8Ag9luPuQEArSpz98CnkFGiZBXHshddZBKPMNR1hTvhp5sSnpFgB8hiHykb/1fNdrbrCmIh9XzqDJq4psDS32hqwJsLYHrNRuma74bLau2HBfj6SxXyorAI89jng8dJj2RPheTOF5Se/SthQaVa9cnnqHHx1RUVxvjMFkcJ0tfDrjxvKAPe/lLWNh8ia74WubUycXx7uhX1hSfadmJ6bAa6byYmB6fsy1NZpFEQuJk1gS4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(53546011)(6486002)(8936002)(5660300002)(31686004)(36756003)(2906002)(6666004)(6506007)(38100700002)(316002)(83380400001)(86362001)(26005)(186003)(508600001)(8676002)(4326008)(66476007)(2616005)(66556008)(31696002)(66946007)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdRbVpLTVhUcXZlYUhWRkE4OU5Oc2pyM2RRSFNVRTdBQnB0REI3RmUwTlo4?=
 =?utf-8?B?cTU2aEFoZ0lSOE1lNDdFQUFFVHJKdWlSMkRxMFJ3akJPbzBvOC95dlRmZHIz?=
 =?utf-8?B?Y2xpTlhrRHRTMGJXc241SUhpODRsMXVHbWM0TDgraS96cWVkMEFzQTBtcEY3?=
 =?utf-8?B?VWlPREJ0M2Ruam8yN2RFRmdidTJLU3RIZU44SS90dXQ3eDAxNXlWVGp5Ynh4?=
 =?utf-8?B?WEpQUVhTeXp5QVVGL0lmOERuQXFsa3R3WGFXYWpwT2YzUXBPdmptY09FR2lW?=
 =?utf-8?B?N3dYcjFtc0NJZG5UYldxMDIrem9BMG9qZ3lNNS8xUDNiZDJKZ0RSRThvVWp1?=
 =?utf-8?B?eHJoNWUxb24xazB6dTFoanRrSUJuc3VXV3hUUGhvakFmbHpnYWcrNWZxUXZW?=
 =?utf-8?B?Yjg5Z3dWcHMyYUoxSFlXWHh0WnlCZThURTBSRXZnSXQ4bkVoSmVrZ1NRV0Nz?=
 =?utf-8?B?N3FtNDI1dTRybWN4OWRQcHFUMmNlMzVMM2dWaE1yMGhJcmtsdmVLbkpDS0FY?=
 =?utf-8?B?b1ZPYkxZVDFXWjZhK1NHMEh4cU5HMk5NOFVJOUloQW1SaEdMdm1zRXcxekpF?=
 =?utf-8?B?SG1EbndxQktraW5ORXltdkNZb2dmbzRucUtvYmZyQ0U5MU1yaXJOb0Uvay9D?=
 =?utf-8?B?TEJHN2VQSW1FZUdTYnBpMlY3MDlNejNwdDB3S2xYVStyc0ZxVWNhRVR1Z1Z6?=
 =?utf-8?B?WEM3VTJKTHZSekFDaGdpUzh0UXhidlEyVGdTSjR5NHd0TjBKTTJRbVhTak5L?=
 =?utf-8?B?cGl4QVcyUzlFVlduWkRNeEpUbE80aktKNmpVZHlTZnlvV3JUVEIyalErYXNC?=
 =?utf-8?B?QmNkV0IwQjBXNUR2NC9QWk4zOHd2ZzN1cUJqd3RSbmF6NUNxQXVrSnN4anJp?=
 =?utf-8?B?R0ZEU0wxOVBiMW1hc3dpOTA2KytJQ0QwN0lRVzhEc0dwdkVjRko0YWdwK1RX?=
 =?utf-8?B?cTM4T0FFMWZOYjB3Y2xvSFdjMGxKZUtlSEZ5NjhTeE8rWS9KOXdXY2FISDlM?=
 =?utf-8?B?TTdKV2FVWHM0djVzOWJ3aDU4VlZjTjRaZ05UUHhITk1IY0ZPY1hYTDNLbDBO?=
 =?utf-8?B?NEt4SWJQbEc2NUF1WklrUVU5a1BMOFVhNUM2UXh6cjNyNEYrMUxSdTRqUjJr?=
 =?utf-8?B?T3hDT2lJdG5mT3FkRmIzMGtPb0luZWZwZk9sckhidnFxT2xNN2wvUHF6SFZ6?=
 =?utf-8?B?eUl4QzNkN3J5bi80RDJ6bDVUQkI1TnRHUFNUTzRKYUwrbEZXYVE5bzcwTmsv?=
 =?utf-8?B?aU5vSUZjT0FVYlVtWk9NUkRDSUtBN1pxaXkyVGRYQnNBdU9KeDBvQTZ0cERE?=
 =?utf-8?B?VFBaaldIUkM4Tkd2NHQ2Ulo5OEk4UTR4TEpYdFRXUTN3SkwxUlE4RzlsZi9y?=
 =?utf-8?B?Q2NxV0xlcEFNZHorUGlqbmdOVEFoeWJOYnBxQXpHRU5NdEovZlFsakFMZll1?=
 =?utf-8?B?R2JpS0ZsV1pPU25ROS9oL24yZXQzMS9NbmszckxMRFF1QnlTUWlLZGY1RG9D?=
 =?utf-8?B?Ym5lUWlORW0rdkFTVDh4Uy9QYlc5RlJzd3V1TGxEK0ZNMnRHQTgvS1JIRi81?=
 =?utf-8?B?QkkwM3k5NGhWdXQ5VUo3eHBpSTIxb1ZlU3JRSHg1bmt5TWdqdit2TTcyL3Fk?=
 =?utf-8?B?R3RDVGt3aUhUNG1VYWp2czlHbVNBelJVWWpQSTZvTGpvb3lNKzhBRityOTZ1?=
 =?utf-8?B?SCsvZzZYVDBZMlJRZmhLU3NKNkJGN29EVStLRHJsOXVJQkdVVVFydEc5OEVu?=
 =?utf-8?B?cFdsbjBlcGFTNDFYWENobndQWTlkQTgxdVhnZWgxcGlHZlJpT2Y0dk9mM0lT?=
 =?utf-8?B?cVdieVVzaVF2ZjJic0NhaExGZTFiQXVXOUhNUEc5d1hYdnRBVVY1MWh6R01C?=
 =?utf-8?B?Vm5jMk1EdGNQckNBeUh1WERDL2tXTFJ0Q1ptMGc0N1VEVngweXJuS3hueWp5?=
 =?utf-8?B?b0tFMWFaeVNyOU1jM3NxeXVvd3ZZbnl1NXBhczQrMEtZOG5TeWV5b3NNR1Np?=
 =?utf-8?B?cFhqdDBJKzI0b1U2MEZOdEszMzhtKzlGSWpMY2V0SVZuaGhqaVdlbmVseEdw?=
 =?utf-8?B?VEpkcXZ4V2NYZitpeXBHV3Q4VEQ2Sk5OR1JnUUsyMWR6MW9DTVV2aTd1NHh4?=
 =?utf-8?B?ZFJSR0srcU12ZUlwQVBpRXRTY0RqbjRaNE11bEFKR1lxQnRpMUtvSVE5NzEw?=
 =?utf-8?B?N1hjZDBlODN0M3hBVU13S2F4WmFkVFdMYjdGa1RXUEpNSUxwL3F0bkhSN3h6?=
 =?utf-8?B?N3FkTjFOUVF3NFdqZ0VJOFdPaHl2NG5IejB1Z2d0TW14bTZBMFZMdVdQbWdW?=
 =?utf-8?B?MS9CSDRMUUNEQUR3Uk5QZVZNQ0d5VjZIa0x6R2FKUFMyWGRySldEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a87b25d-723e-469c-900d-08da1b9a7102
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 09:05:36.4534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykZOGKWRc6qieluc/NMAHp6amNFVXe2J1oAincPxI2hrK2Ya2lsC/ZqJ+Dk6JrqA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5525
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
Cc: Alexander.Deucher@amd.com, arthur.marsh@internode.on.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/11/2022 1:17 PM, Evan Quan wrote:
> By placing those unrelated code outside of adev->pm.mutex
> protections or restructuring the call flow, we can eliminate
> the deadlock issue. This comes with no real logics change.
> 
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I75de4350d9c2517aba0d6adc12e1bc69430fd800
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39 +++++++++++++++++++
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
>   4 files changed, 39 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5504d81c77b7..72e7b5d40af6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int i;
>   
>   	if (!adev->pm.dpm_enabled)
>   		return;
> @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   	if (!pp_funcs->pm_compute_clocks)
>   		return;
>   
> +	if (adev->mode_info.num_crtc)
> +		amdgpu_display_bandwidth_update(adev);
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready)
> +			amdgpu_fence_wait_empty(ring);
> +	}
> +
>   	mutex_lock(&adev->pm.mutex);
>   	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>   	mutex_unlock(&adev->pm.mutex);
> @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> +	if (adev->family == AMDGPU_FAMILY_SI) {

Bringing family specific code to this layer is not the proper fix. Need 
to specify what is the deadlock and why can't it be handled in family 
specific implementation.

Thanks,
Lijo

> +		mutex_lock(&adev->pm.mutex);
> +		if (enable) {
> +			adev->pm.dpm.uvd_active = true;
> +			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +		} else {
> +			adev->pm.dpm.uvd_active = false;
> +		}
> +		mutex_unlock(&adev->pm.mutex);
> +
> +		amdgpu_dpm_compute_clocks(adev);
> +		return;
> +	}
> +
>   	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
>   	if (ret)
>   		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> @@ -453,6 +477,21 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> +	if (adev->family == AMDGPU_FAMILY_SI) {
> +		mutex_lock(&adev->pm.mutex);
> +		if (enable) {
> +			adev->pm.dpm.vce_active = true;
> +			/* XXX select vce level based on ring/task */
> +			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +		} else {
> +			adev->pm.dpm.vce_active = false;
> +		}
> +		mutex_unlock(&adev->pm.mutex);
> +
> +		amdgpu_dpm_compute_clocks(adev);
> +		return;
> +	}
> +
>   	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
>   	if (ret)
>   		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 9613c6181c17..d3fe149d8476 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -1028,16 +1028,6 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   void amdgpu_legacy_dpm_compute_clocks(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int i = 0;
> -
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
>   
>   	amdgpu_dpm_get_active_displays(adev);
>   
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index caae54487f9c..633dab14f51c 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct amdgpu_device *adev)
>   }
>   #endif
>   
> -static int si_set_powergating_by_smu(void *handle,
> -				     uint32_t block_type,
> -				     bool gate)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	switch (block_type) {
> -	case AMD_IP_BLOCK_TYPE_UVD:
> -		if (!gate) {
> -			adev->pm.dpm.uvd_active = true;
> -			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> -		} else {
> -			adev->pm.dpm.uvd_active = false;
> -		}
> -
> -		amdgpu_legacy_dpm_compute_clocks(handle);
> -		break;
> -	case AMD_IP_BLOCK_TYPE_VCE:
> -		if (!gate) {
> -			adev->pm.dpm.vce_active = true;
> -			/* XXX select vce level based on ring/task */
> -			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> -		} else {
> -			adev->pm.dpm.vce_active = false;
> -		}
> -
> -		amdgpu_legacy_dpm_compute_clocks(handle);
> -		break;
> -	default:
> -		break;
> -	}
> -	return 0;
> -}
> -
>   static int si_set_sw_state(struct amdgpu_device *adev)
>   {
>   	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
> @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>   	.print_power_state = &si_dpm_print_power_state,
>   	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
>   	.force_performance_level = &si_dpm_force_performance_level,
> -	.set_powergating_by_smu = &si_set_powergating_by_smu,
>   	.vblank_too_short = &si_dpm_vblank_too_short,
>   	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>   	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index dbed72c1e0c6..1eb4e613b27a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void *handle)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   	struct amdgpu_device *adev = hwmgr->adev;
> -	int i = 0;
> -
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
>   
>   	if (!amdgpu_device_has_dc_support(adev)) {
>   		amdgpu_dpm_get_active_displays(adev);
> 
