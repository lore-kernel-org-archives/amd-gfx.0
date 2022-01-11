Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ADDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 08:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8658B11B77F;
	Tue, 11 Jan 2022 08:13:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740C111B716
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 08:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4307IU3XT6hf2gjS+NcloHLMUYZeXJ4dfZeYir0fZLJyYU/pvG4bsP133GQJOdxUeVQcOjtZecWvb/yQtafUoSO3Ao3J636bAXj7O0oubX3pAYGiQ9sDCf2I4tO+uDJAfK6m/2Si2M76xkaKvYpJD0ktJshn0oi1En8CO7RsKX58FK1xZy3+ZC+c1xL07+IGVKao4RQNTAhncd07O19qwbQLvJ0VjJIe38NDgpTfTyVnfxUKQvIlN5RSzy4GqwvnnVLdfjeM588FiJzBWrTPv0iiUGdqn+p+se4Ak9XlpOnLtxDc7SX04cQL8QVD8i7uWLPOMX+9j2DqkwamhrAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fUKWkdv9cxl4E2D/ejFjPqB8GP/S8EmYlu3LEn7On4=;
 b=cLw0nFCLGPeW6zPedSahFLinJMkapA5qwFtuv9QnH8vgUSlw8pA48ekCHEUOA+liApXX8Q1LI0mIvo5/bLeWb8m7/wPgtEg3aRVLJsdXIbZv/u4PkOAFHK8XXy8GPaNx6x/DgesjKZup4Z5LjP2moVgvTMVlye3OeOd2+Ewts8NEO2Tr3gRoocTJJOOPi2fPQa/M9eiFulpUhZly8ejqRPBf48FKUp7TZQJhSrKtjw8Q5Nt1Ja5njw+Vl2dmKcJKFdVpnOlRVSn6k0TdeeZNrKedHfUTPAC7uJkjQV/74DSfx8icRE18dpkRR7itafBLTGHHuT2uLySIbkCqrP20cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fUKWkdv9cxl4E2D/ejFjPqB8GP/S8EmYlu3LEn7On4=;
 b=MRhxsXJdxI6+XGZkBQK2u6+m18E6W5MgfhKXi6LxaQFbX+64hHexQtptE5OyqeG6zYgvjpSL1O+ZtaPhOgMnPl/ehk9SxDRzolVbOuZsq2hz3gBSOra05FWmq9+Sk1elith0/9thX2Qv53vdTVoYTVleKh6Ny65OC0HV/AuQBGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB3111.namprd12.prod.outlook.com (2603:10b6:a03:dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 08:13:48 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:13:48 +0000
Message-ID: <529cd021-7342-8efb-b1bc-266bbf0fee88@amd.com>
Date: Tue, 11 Jan 2022 13:43:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220111074729.40906-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220111074729.40906-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dab309ca-53e5-4ebf-ed68-08d9d4da4b73
X-MS-TrafficTypeDiagnostic: BYAPR12MB3111:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3111181985A842AA7428014197519@BYAPR12MB3111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5gIVbb1zDuo9xv7rY7YwCoOxjtr0KkHVdIRQIXHsDWI6SQv2cjKFDlaMuZ6J1LRsi6r9w3oHKdELaSsAVXB6mEgGVlJBZh7XtsL+D/1/QkrshOH/qamMX+sxnNBzBYmEEsj0PUrUne9Z1W8c5IykrT10raoQo3dbH6X7Kt9E3IGNRa5aNvAbRI1HnS2W6hVFZXqgvxgF3LCi4qMvqoSN8duce8G646RLQJNifugl5ChIUXNmBdmb3bQNmZs399UwK79GE/y/V4hR8bWXb3PW8uoe+eMoEMKD5IoY+mZ00bPcOu/55R0wlEVsrJuB++LwHr5FhZbCnYX4iU8tDg4cft8QZFCvTuD7yGlLn91+L+eoCxeQ1GmfjoG0rNi4qabXviSn9rO6i+xkboA/5riKkip+Hdb++hhoRBltRk6+gNQ7ECXwNwyO7rRL88MrpUgBXWyrxZWQ+O3Qn4Ci8OzAS6V8JCEqT1awYzAmgVS6AXC/ijr1WfLx5aiklwAyYiYWs8eLn+O2jx3JVeQ6OJiJUVwZicG7Tp8QVXbal6yl9SOuPEHwD7c0tuZYBGrMhWqOmLRupzbt6oXmOd2L+IJz5LwbX1oi5OJsgw/zw3n/e1jQepYg6PyhPDRtJvilArGS4Rs5R0lEYkYAf8s6nTDVxp+PPEyH6LR5TuaUKbfxj2xz9arbKg1QA9INyvX9alBYxcRJnhiAjlpwTtgvYCuWGo/V2Ffo3hWBPgxF9bToE1ijtRJRe4eUpExR2blv9cL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(2906002)(6506007)(6666004)(6512007)(8936002)(186003)(38100700002)(508600001)(8676002)(30864003)(83380400001)(66476007)(53546011)(66946007)(86362001)(66556008)(2616005)(31696002)(31686004)(4326008)(26005)(6486002)(36756003)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGlsUWNybklKTzF3M1NheTJpK1A4dXIwcDhQbzhLcFVsTTJZK203Rkx2eFdI?=
 =?utf-8?B?ckxPM2NrL0l0YTJUZjFmUHRDbGx3TGcvUXNxT3YrVnVYclJEV2xYcmtWbXJm?=
 =?utf-8?B?cjY4THI1TGFjcjQrZStIdk5QZGNodFJxSEtSOHJ3TFV0RFJSdkxjN1E1Z21r?=
 =?utf-8?B?bW5uZXI5WGVhMEM1aUNCUEZnQ0x1QzFXaVNDV2VwOU1HVGRNS2dyajBHQ1kw?=
 =?utf-8?B?SjczRERRRFcxN0ZhNndtTnQ4K2xRMU9XZmxSSGRoRElLS2duWDB1eGpCNmZo?=
 =?utf-8?B?V3pBZG5uWitjK21NWEQyRHdmT3lLVG9SWlorQkE0aFRNSGpicTJkMFlGaWhL?=
 =?utf-8?B?cS91MFloK0ZoaVordmIvQlVGSjZGcUxyVXhHT0ZPR2NHMTBRcWpoMEUwaXdS?=
 =?utf-8?B?dlk4b3U2TDA1Sm5qMXpUdDh0UUcrTGRmYVpndFhrdUx1bWlZNmZpVjg1a0tJ?=
 =?utf-8?B?emtvVHp2VjZJUEUwNG8vUE9Rbzd6c0FtZ3lmQTRkVHBJSzhEVFBUajc0U3d6?=
 =?utf-8?B?cXdTdDdBeVpHMkJIcks4YXM2dWU2eENEVlRyTXZvWGVpOWRDWlZXdGhkY2Jw?=
 =?utf-8?B?ZFBvTWhWMDVmbTFYdkVLdXZXS0xaRmI0TmNvRjEwcFgySXAyMk9JYjFGeWFM?=
 =?utf-8?B?cnNFRmRuNGlUcGRzdVNmRjBha2QxdjdZNnZkczRwd0lqTmNwczlWUVJiTDgy?=
 =?utf-8?B?d0NMRjBDWWFld3VSZ2RPeE5nY051TTZrVmRrQ3pKbm1UVHAzWHRFR3hxWit5?=
 =?utf-8?B?bzVZZ1JyUU4yT1M5b1g3QU83R0IvcTYzdGp2NEtLWk5VSUs0ditiaEVYeThD?=
 =?utf-8?B?bEZvTnBaY1RlamlHSm1JTUhwM3QybFo5TGpoQVFsVTNTdzZPVHdyZllCMnVw?=
 =?utf-8?B?dFg4WkJEeXpRWlRubmNKaUEzVU9xZUtnYVZmZ3RkaDFDUWoyTjZjMWNRVnlN?=
 =?utf-8?B?Q3ZZSHBJSGRucUhxYTJkN05BR2swSXpiUDRKOGt4ZE5nV2J5a2kxNVY0emkr?=
 =?utf-8?B?cVdBUGRpTDc1a2Z6VDJyZndYMkFrNkwrVU1ETnBadlh4Rm96NzAySDBUZUdM?=
 =?utf-8?B?eVBoVUo1V3VMWDFMbm5GSUZCNWZrVG9nZFlXSTQyT3dCSlBDcUppV0VDUzUz?=
 =?utf-8?B?SUJjcjhsd2dieVpoNG1nTlNCeWVxTGhQMTdBVFFDRUJ6Z2kvMmNTY25BSkRD?=
 =?utf-8?B?OGhJc3NRMUdTM1RDQUp2dnl1SS9xalFpZVQ0Y3pUVkhrTEFmZHlJeVA2eGtD?=
 =?utf-8?B?dkN1cm5IeGEvcWVVbGpWaFlKT1h0TkRLem9rOHVxeVk5NE1RVmRtSWdibU9I?=
 =?utf-8?B?R0YzQkk1aU1kRlhjUTJ1dFQ5ZVZHWlpsOU0zZVlQZkpUN1MyeFpEdjZzL2Jn?=
 =?utf-8?B?a0ZxWVBIWjNCTDJiWTZaaktGN0VMMWVGYnNnZXNWNHd6ZU5ZR1lXVmdsQy90?=
 =?utf-8?B?WWJVMFFIYUpYenNxWXhlMmVOenZjTjBQTTdWOWMxSHVKbmFYWHNvRzI2cGxt?=
 =?utf-8?B?OVBMRngrTG5OWTdHbDR1OXhFYS9rZCt1OStUcW9xNDIyN21CYzlRMmxHc25H?=
 =?utf-8?B?UTgzdUlsQ2dDb3NGdkN1emtoRHc1NnhKQVFFc0FRaS8zMzE3aEZBeU12TnZi?=
 =?utf-8?B?RUFxdFYyMGN1UU9qNTUzcktiU0hwVkV0WlVJdEZ4elBXYzRoZXFmekNpbm1m?=
 =?utf-8?B?UjlMZ0lib3RQMEVBUHM2U3BLYk9Wb2Y2RlR2Q3c5a0Z1U05IZmFXRXZGRTE4?=
 =?utf-8?B?c0NacUNsN2svRFhNdmNYZWd4dHNZV3duZCtKMFgrcnB0MHVSZ0ZMN0RVVmpk?=
 =?utf-8?B?SnphVURyRHc5UGlSSU9FOWdCbGpVemNJR0ZEQ3MwNWk4ZjErYW15TnFtYmFS?=
 =?utf-8?B?dE0vL3M4WkZBa1FieGtkeGJJNG9PV29QRWhGd0c2WElEeTVQd1NjVW5KVDNF?=
 =?utf-8?B?M2ZPUkRXSGpCazlkTjdjVFZSbndxYUdnb2d6K1RhVTd5VUs3TnZVRVd2a2FP?=
 =?utf-8?B?djRvSjdyWDNsc29FY0RFK3ZJcEVKYVZYbjBwTTJwMXNkREpGVjc0cC8yQmw4?=
 =?utf-8?B?Wmc5bGtsdzdqUldvSDFsdm5JcUNhNDR0RnhYTmtjdHhENFRaZkZSTHVpV3RE?=
 =?utf-8?Q?Ltz4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab309ca-53e5-4ebf-ed68-08d9d4da4b73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:13:48.6920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUVGCfobpor7bIcZBcaAa5p39YkYldvQ+Azg8TTKfEaOqje1++MsntX9cjoxWsZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3111
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
Cc: Alexander.Deucher@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/11/2022 1:17 PM, Evan Quan wrote:
> On functionality unsupported, -EOPNOTSUPP will be returned. And we rely
> on that to determine the fan attributes support.
> 
> Fixes: 801771de0331 ("drm/amd/pm: do not expose power implementation details to
> amdgpu_pm.c")
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I95e7e0beebd678a446221a72234cd356e14f0fcd
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  31 ++++-
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  21 ++--
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  10 +-
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  59 ++++-----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 115 +++++++++---------
>   6 files changed, 132 insertions(+), 108 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index a8eec91c0995..387120099493 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -315,8 +315,8 @@ struct amd_pm_funcs {
>   				void  *rps,
>   				bool  *equal);
>   /* export for sysfs */
> -	void (*set_fan_control_mode)(void *handle, u32 mode);
> -	u32 (*get_fan_control_mode)(void *handle);
> +	int (*set_fan_control_mode)(void *handle, u32 mode);
> +	int (*get_fan_control_mode)(void *handle, u32 *fan_mode);
>   	int (*set_fan_speed_pwm)(void *handle, u32 speed);
>   	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>   	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 68d2e80a673b..fe69785df403 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1030,15 +1030,20 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
>   				    uint32_t *fan_mode)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_control_mode)
>   		return -EOPNOTSUPP;
>   
> +	if (!fan_mode)
> +		return -EINVAL;
> +

pp_funcs most likely will be there for smu/powerplay subsystem. I think 
the checks should be at one layer down - smu_get_fan_control_mode() and 
pp_dpm_get_fan_control_mode()

First one will check if ppt func is implemented and second one will 
check if hwmgr func is implemented for the specific ASIC.

Thanks,
Lijo

>   	mutex_lock(&adev->pm.mutex);
> -	*fan_mode = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle);
> +	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
> +					     fan_mode);
>   	mutex_unlock(&adev->pm.mutex);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
> @@ -1048,6 +1053,9 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_speed_pwm)
> +		return -EOPNOTSUPP;
> +
> +	if (speed == U32_MAX)
>   		return -EINVAL;
>   
>   	mutex_lock(&adev->pm.mutex);
> @@ -1065,6 +1073,9 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_speed_pwm)
> +		return -EOPNOTSUPP;
> +
> +	if (!speed)
>   		return -EINVAL;
>   
>   	mutex_lock(&adev->pm.mutex);
> @@ -1082,6 +1093,9 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_speed_rpm)
> +		return -EOPNOTSUPP;
> +
> +	if (!speed)
>   		return -EINVAL;
>   
>   	mutex_lock(&adev->pm.mutex);
> @@ -1099,6 +1113,9 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_speed_rpm)
> +		return -EOPNOTSUPP;
> +
> +	if (speed == U32_MAX)
>   		return -EINVAL;
>   
>   	mutex_lock(&adev->pm.mutex);
> @@ -1113,16 +1130,20 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
>   				    uint32_t mode)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_control_mode)
>   		return -EOPNOTSUPP;
>   
> +	if (mode == U32_MAX)
> +		return -EINVAL;
> +
>   	mutex_lock(&adev->pm.mutex);
> -	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
> -				       mode);
> +	ret = pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
> +					     mode);
>   	mutex_unlock(&adev->pm.mutex);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d3eab245e0fe..940cbe751163 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3197,7 +3197,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
>   	umode_t effective_mode = attr->mode;
> -	uint32_t speed = 0;
>   
>   	/* under multi-vf mode, the hwmon attributes are all not supported */
>   	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -3263,15 +3262,15 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* mask fan attributes if we have no bindings for this asic to expose */
> -	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> +	if (((amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
>   	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
> -	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -EOPNOTSUPP) &&
> +	    ((amdgpu_dpm_get_fan_control_mode(adev, NULL) == -EOPNOTSUPP) &&
>   	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
>   		effective_mode &= ~S_IRUGO;
>   
> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
>   	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
> -	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -EOPNOTSUPP) &&
> +	      ((amdgpu_dpm_set_fan_control_mode(adev, U32_MAX) == -EOPNOTSUPP) &&
>   	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
>   		effective_mode &= ~S_IWUSR;
>   
> @@ -3291,16 +3290,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* hide max/min values if we can't both query and manage the fan */
> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> -	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> -	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> -	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)) &&
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
> +	      (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
> +	      (amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
> +	      (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP)) &&
>   	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>   		return 0;
>   
> -	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> -	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL) &&
> +	if ((amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
> +	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP) &&
>   	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 92b987fb31d4..7677d3a21f8c 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -6669,7 +6669,7 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
>   	return 0;
>   }
>   
> -static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
> +static int si_dpm_set_fan_control_mode(void *handle, u32 mode)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> @@ -6685,9 +6685,11 @@ static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
>   		else
>   			si_fan_ctrl_set_default_mode(adev);
>   	}
> +
> +	return 0;
>   }
>   
> -static u32 si_dpm_get_fan_control_mode(void *handle)
> +static int si_dpm_get_fan_control_mode(void *handle, u32 *fan_mode)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct si_power_info *si_pi = si_get_pi(adev);
> @@ -6697,7 +6699,9 @@ static u32 si_dpm_get_fan_control_mode(void *handle)
>   		return 0;
>   
>   	tmp = RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
> -	return (tmp >> FDO_PWM_MODE_SHIFT);
> +	*fan_mode = (tmp >> FDO_PWM_MODE_SHIFT);
> +
> +	return 0;
>   }
>   
>   #if 0
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 89341729744d..57bc9405d6a9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -488,38 +488,37 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
>   	return pm_type;
>   }
>   
> -static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
> +static int pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return;
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
> +		return -EOPNOTSUPP;
>   
> -	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
>   	hwmgr->hwmgr_func->set_fan_control_mode(hwmgr, mode);
>   	mutex_unlock(&hwmgr->smu_lock);
> +
> +	return 0;
>   }
>   
> -static uint32_t pp_dpm_get_fan_control_mode(void *handle)
> +static int pp_dpm_get_fan_control_mode(void *handle, uint32_t *fan_mode)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
> -	uint32_t mode = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return 0;
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
> +		return -EOPNOTSUPP;
>   
> -	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
> -	mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
> +	*fan_mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
>   	mutex_unlock(&hwmgr->smu_lock);
> -	return mode;
> +	return 0;
>   }
>   
>   static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
> @@ -528,12 +527,11 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
> +		return -EOPNOTSUPP;
>   
> -	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
>   	mutex_unlock(&hwmgr->smu_lock);
> @@ -546,12 +544,10 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
> -	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
> +	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
> @@ -565,10 +561,10 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
> @@ -582,12 +578,11 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
> +		return -EOPNOTSUPP;
>   
> -	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
>   	mutex_unlock(&hwmgr->smu_lock);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c374c3067496..474f1f04cc96 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -59,7 +59,7 @@ static int smu_handle_task(struct smu_context *smu,
>   			   bool lock_needed);
>   static int smu_reset(struct smu_context *smu);
>   static int smu_set_fan_speed_pwm(void *handle, u32 speed);
> -static int smu_set_fan_control_mode(struct smu_context *smu, int value);
> +static int smu_set_fan_control_mode(void *handle, u32 value);
>   static int smu_set_power_limit(void *handle, uint32_t limit);
>   static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
> @@ -407,7 +407,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   	if (smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_MANUAL ||
>   	    smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
>   		ret = smu_set_fan_control_mode(smu, smu->user_dpm_profile.fan_mode);
> -		if (ret) {
> +		if (ret != -EOPNOTSUPP) {
>   			smu->user_dpm_profile.fan_speed_pwm = 0;
>   			smu->user_dpm_profile.fan_speed_rpm = 0;
>   			smu->user_dpm_profile.fan_mode = AMD_FAN_CTRL_AUTO;
> @@ -416,13 +416,13 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   
>   		if (smu->user_dpm_profile.fan_speed_pwm) {
>   			ret = smu_set_fan_speed_pwm(smu, smu->user_dpm_profile.fan_speed_pwm);
> -			if (ret)
> +			if (ret != -EOPNOTSUPP)
>   				dev_err(smu->adev->dev, "Failed to set manual fan speed in pwm\n");
>   		}
>   
>   		if (smu->user_dpm_profile.fan_speed_rpm) {
>   			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
> -			if (ret)
> +			if (ret != -EOPNOTSUPP)
>   				dev_err(smu->adev->dev, "Failed to set manual fan speed in rpm\n");
>   		}
>   	}
> @@ -2218,18 +2218,19 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->set_fan_speed_rpm)
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->set_fan_speed_rpm) {
> -		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> -			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
> -			smu->user_dpm_profile.fan_speed_rpm = speed;
> +	ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
> +	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
> +		smu->user_dpm_profile.fan_speed_rpm = speed;
>   
> -			/* Override custom PWM setting as they cannot co-exist */
> -			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
> -			smu->user_dpm_profile.fan_speed_pwm = 0;
> -		}
> +		/* Override custom PWM setting as they cannot co-exist */
> +		smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
> +		smu->user_dpm_profile.fan_speed_pwm = 0;
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> @@ -2562,60 +2563,59 @@ static int smu_set_power_profile_mode(void *handle,
>   }
>   
>   
> -static u32 smu_get_fan_control_mode(void *handle)
> +static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
>   {
>   	struct smu_context *smu = handle;
> -	u32 ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> -		return AMD_FAN_CTRL_NONE;
> +		return -EOPNOTSUPP;
> +
> +	if (!smu->ppt_funcs->get_fan_control_mode)
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_control_mode)
> -		ret = smu->ppt_funcs->get_fan_control_mode(smu);
> +	*fan_mode = smu->ppt_funcs->get_fan_control_mode(smu);
>   
>   	mutex_unlock(&smu->mutex);
>   
> -	return ret;
> +	return 0;
>   }
>   
> -static int smu_set_fan_control_mode(struct smu_context *smu, int value)
> +static int smu_set_fan_control_mode(void *handle, u32 value)
>   {
> +	struct smu_context *smu = handle;
>   	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> -		return  -EOPNOTSUPP;
> +		return -EOPNOTSUPP;
> +
> +	if (!smu->ppt_funcs->set_fan_control_mode)
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->set_fan_control_mode) {
> -		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> -			smu->user_dpm_profile.fan_mode = value;
> -	}
> +	ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
> +	if (ret)
> +		goto out;
>   
> -	mutex_unlock(&smu->mutex);
> +	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +		smu->user_dpm_profile.fan_mode = value;
>   
> -	/* reset user dpm fan speed */
> -	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
> -			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> -		smu->user_dpm_profile.fan_speed_pwm = 0;
> -		smu->user_dpm_profile.fan_speed_rpm = 0;
> -		smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
> +		/* reset user dpm fan speed */
> +		if (value != AMD_FAN_CTRL_MANUAL) {
> +			smu->user_dpm_profile.fan_speed_pwm = 0;
> +			smu->user_dpm_profile.fan_speed_rpm = 0;
> +			smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
> +		}
>   	}
>   
> -	return ret;
> -}
> -
> -static void smu_pp_set_fan_control_mode(void *handle, u32 value)
> -{
> -	struct smu_context *smu = handle;
> +out:
> +	mutex_unlock(&smu->mutex);
>   
> -	smu_set_fan_control_mode(smu, value);
> +	return ret;
>   }
>   
> -
>   static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
>   {
>   	struct smu_context *smu = handle;
> @@ -2624,10 +2624,12 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->get_fan_speed_pwm)
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_speed_pwm)
> -		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
> +	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
>   
>   	mutex_unlock(&smu->mutex);
>   
> @@ -2642,18 +2644,19 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->set_fan_speed_pwm)
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->set_fan_speed_pwm) {
> -		ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> -			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
> -			smu->user_dpm_profile.fan_speed_pwm = speed;
> +	ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
> +	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
> +		smu->user_dpm_profile.fan_speed_pwm = speed;
>   
> -			/* Override custom RPM setting as they cannot co-exist */
> -			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
> -			smu->user_dpm_profile.fan_speed_rpm = 0;
> -		}
> +		/* Override custom RPM setting as they cannot co-exist */
> +		smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
> +		smu->user_dpm_profile.fan_speed_rpm = 0;
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> @@ -2669,10 +2672,12 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->get_fan_speed_rpm)
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_speed_rpm)
> -		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
> +	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>   
>   	mutex_unlock(&smu->mutex);
>   
> @@ -3101,7 +3106,7 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   
>   static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	/* export for sysfs */
> -	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
> +	.set_fan_control_mode    = smu_set_fan_control_mode,
>   	.get_fan_control_mode    = smu_get_fan_control_mode,
>   	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
>   	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
> 
