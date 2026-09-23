Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A77C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDFF10F186;
	Wed, 23 Sep 2026 19:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uz4IUjcn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F3610F177
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxGtbJl6owWNQ6kPO0Jr9wSI4SlQlxxwbHVl/LKNL54Il9MUGF+Poyq3FXqr+8ITfh3sLOhbwkum4g1P4cPUAxMfjoPT0L0T4m9yXg/YDIvE7DodWVKHfZFQjeG3DWgiwNElUcQ/ZKD2rJUU64s+DrLAgFxm7yEajOI4MlUIzRgJjnb5koJQcdZHTGtCyMYClnM51N/GP/mfDKg1abix3/m6I/XjsdlbzJ7y8XCEqPvqeZ5JgFXwGQznCuaTAApqrWWVrahl45sKfgLF5G6WLxuccIhCNItk0i1EAvHNHBIyX06Bf5Cg+3WOKAQR88w3qwOB70peMgrwkAyYAl/P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQvvetlG0feCf0bDJtXRIEBeEA5J+sXLA+SoEA7g3iA=;
 b=ZsaU5/P8xV8bIZNQQR7CLoH2B2b/0EVRsbHcJkb78ag7BNcnEMtVKLwIZCTWWcwKvks5o8D6436SdoBPeEYdS66aY31nWTO0cMm6z3JUmXWSUrtFXdcIG3Gxx5/2rzrvG5FDJL5fQIWXy0OTX0Vz4WFtWjhV2vUfk/5X6MKQgS4YP/oJZ3blz2RW8+C4jgJYt5Ho+Cy5StO8LC+Pzzga9aL5cPeZsh06c2cqTyq2u72VsXUUih5X6hMiWPzGEtocuOGfvMIwQMNVcOF8KvhB8suK2YlZrIQLsbwgPwIPSovjWAhk7VWTkEh39FfI3v1We0xf8oDjlBiQ6D8aQEEGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQvvetlG0feCf0bDJtXRIEBeEA5J+sXLA+SoEA7g3iA=;
 b=uz4IUjcnevnGpoF4UwaiDHCbT3c1ijHirR94mMZIvIken+CmIQuBBa20sdB0gTiC5n7I6tA5tCIkcIkcf8RvpHaPvVFIx0G7D4b3vRWQ2Qk9Ta6/PpE5dKupDaDkZOroWA6gqnY5UuQpsNcktJQGyQtg0QrwXH3p7kCcP+8XDZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:59:26 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:59:26 +0000
Message-ID: <e4c2a31b-0834-4929-ab43-d29dc5e63505@amd.com>
Date: Wed, 23 Sep 2026 14:59:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm/si: Fix updating clock limits on AC/DC
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
References: <20260923120354.1027996-1-timur.kristof@gmail.com>
 <20260923120354.1027996-2-timur.kristof@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923120354.1027996-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:5a::22) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: bbce47a3-ac78-4142-0d6b-08df19ad2b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: l9f9Cht+5N8PZTd6BvoC4Vlpo65KualW+b0k+ln36SFCgVxwkELR5+yIHEvwIKb840+RmqmSTI9Y6gMVIO0Bgbq2wVtcTSznV17lJRV9MgHWeD+xY/12RZ8NpJ8cDSn2IhzV2Jj8Fgwlq+tn8iDBre0mfGgFMTBF9rPS7w9XFCds6E0f0lDsZfeERhWl9ULB9ltuz94TUTgyRFEYH2FoiPIxW7IdJBPog+i/6Hx8LOzAlruSP2+qwgzafLjW+b1oK1i7VTq5+fsfKv9Owb6eOz/iOA5Nzv3fU3y2RolDzlMGrlV7luxzaJL4rmuCyJ2fNtowsRC8R2W63t4cxBg/2NkmsAfOfWNQUBbb4JzHtGOszgcH9VK+Vs2iEYTgW9RnVI/iUWrnPCnldVo37gN1InnQ0XX0sUYUqjb6r/CzsaZSloy0cLV7mT41UdQCNQFiA3aMm+SX9mCGDPRak9u1x0ftva1AbQs0SkRZqJ2rLT9D0saoHYR2f5GCioZIeFfF9KEiCROow2Qmb8Fo6MZEzsAX992FMK92Hye96f2kZ0Hn6QmbAq3QWC3duESwIxntgN4e9AQW2HGpn2OBY1qAzGDW4Z3rgINeEBCyotwzvfiG4MoMLrV/teS2xz8Dc6y+RrqEFZy+KofjKkniaoC+iH1882mvv99+WervtQpsB/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3B6N09oOURYRFhQUFV1QkVvREE0WnNVaW9xRlNaSjFZSWVCbzNHcmlXMUNr?=
 =?utf-8?B?UVkvZSs1UHRTanFZcmhhUlB4Nkt5NE1UaTRKWFlQMU9UVFhNTnllQXk1aWk5?=
 =?utf-8?B?d1hSSkhoMk9LblY4UU9oc2FaNFJOSFJKU0tzektXaDIxY2tQRmpUNUg1b2ZK?=
 =?utf-8?B?SG5lNm51dXhXamJwODFsbTVrOWtIOEtsMWZyaUlqTVhJQXhKQm5LK0xleTY5?=
 =?utf-8?B?dGtjakxid3Zremx0WWJUZEpDMnRoS2F2M3pqcVhvVnp3RklCVGo0MUlXWEJm?=
 =?utf-8?B?eWl0bVVnRXNpc1dzL04wWXBYakpKSURWbXpTZ1Y3dkxqMmpaQlpvYUFmMkt3?=
 =?utf-8?B?QlN6R05Rc2hsaEc0ZG8zeGhaL0MyNUw0bmhyTFRRQk5QVU55bFAxeVRaYlk2?=
 =?utf-8?B?Q3p0MTUrSGp6Q1Zvai85M1ZCTHZwcXhycDFCMHZlZEQ4a1BRbjlqUVloNzN3?=
 =?utf-8?B?bjVGSDVHRGVCdmgvRU9sM1NHSG91NXV0djNpYURsNmdqVTBCSUM5MVUwSVJC?=
 =?utf-8?B?c2N0a2ptYjVHNXVXeGNrcWR3ZzI4andjdWFhRWNrZnU2NjRtOHZpYUNremd6?=
 =?utf-8?B?TjV2Nm40NUxuMEpEZ0xZeXpaVmdhbXphRmtsQkVJOFVaSVA0Z3lYMEUyL2FJ?=
 =?utf-8?B?d1N1Z0lqeWxONGg1Y0NZYnBPd2RnOW9yMzlrelJaZnNyOG9XYXN4SlR0czdx?=
 =?utf-8?B?eFFsbDZUYXJYc293WTFtZXltdEoyZ010bGhpNjQyMUNId0cxNmpReVNpeGdS?=
 =?utf-8?B?ZnR3SFIzbFc3d3BkY0xGZTZuWlJUY2hGWUlLNmZzKzZsclZvdk8wZEo0RWJr?=
 =?utf-8?B?ajFLWE5aNWxjajZOc1I2SHpWT25PejNHZ3ZDWVBhLzhRS3MydWNQWG5GNjVU?=
 =?utf-8?B?bUhFSnU2TlFoZWVqbnBodi9WYURlVFowOVAyMUxzR0F3T1lZUnd1aVI0TGtQ?=
 =?utf-8?B?Wlplc3diVVlBQTYrTFBabS95Y0s5ZFdKaHZXblZabkZhMTYyQmdqK29sQld0?=
 =?utf-8?B?UVpyM01yN1lHMkVWeGtkREMvbkpVWXBkUzlTM0tlUEloejVSZU1DeWIzcnJ4?=
 =?utf-8?B?MHUzYytjQ1ZCVGo3b0RqQ1FVT3FBbWhQMWhhVGVOdndyUWF6UFV3eHlzbDNE?=
 =?utf-8?B?c28wcGxJais4bEFHVU1OeEd2REhNTnZrUTJCY0hielJRZGFqWDNUWW5aOXBN?=
 =?utf-8?B?cUFtVzFGRXEyN3FNck1kUHhtN1U0NzJlQjlOV2VMdk5zN0lQLzdLUlIzQm9O?=
 =?utf-8?B?UC91bElSd1BvYTFmNGlmTStKOVNUQjFPZlcwS052SHVKRGZNeGhiWEhtR3U5?=
 =?utf-8?B?UnZ5TDBQOURDVUxvejRmaFVWUWNzdWRTc2RtYTJVdmQ4OGpWcXorZVN3em80?=
 =?utf-8?B?SHFldmJPSnJMbmgrYUF6RUNpVk9iL3NtclZiL0t1UU1jNmZDRE1oNHhJeGpy?=
 =?utf-8?B?VW1mMFVLN2ZEZkRneXBVMUE0dTJFMG1DbUNxYTVKa25sTWVnamROZzE2L1or?=
 =?utf-8?B?aFRBeGtmMkxObjZ0VU5hd2RnODRJdklac0N1NGVSTCtsQXg1RGtQVWZKTGZo?=
 =?utf-8?B?aStqVWpoRmZ5b3h2anlEVHhsZ1l4UkEzbzhhdS9JNkt4R3c0akpLVnMweDFh?=
 =?utf-8?B?emkxVFc2SVZxakdCTWNXS3dSOFlEWjM5R0dVMFNhSS8yYnJDZmpxYWZmdmFE?=
 =?utf-8?B?V3BPWG9jS2dYb0ZFSkNQanA0Vit4Sk40QzN4cEY4dlZlYy9nSnpMQ2c0alV1?=
 =?utf-8?B?OStVTjREUWdWUUh3bXpVM0ZralNrUFZOYzEzeUtUS0pySEozb1VJS01iTnJW?=
 =?utf-8?B?WDN1dHdUaHp3QnF1M1ZqN2ljd1ZVc2lnYS85eGlINjloVGNnclArdDJWTnBl?=
 =?utf-8?B?Z3A0dnlrQjJkNmJrMmtreERpdUVkL2FMWEs2emQ3cDBrVGQzd3NucElHYW5Q?=
 =?utf-8?B?SWFxQVAvbUEwZWpzeFJtVlpjUDBTWThIQ2FSZ3VhaFlwM05tVUpWM3dUdUhT?=
 =?utf-8?B?QTRMZFBseUFRUzlCQkczRmc4WHZWWkVFNEFjemsvc3o4cUdEYVh5MS83Wjdx?=
 =?utf-8?B?ekovWHluY2JjdHIyRm1nUjRzQXVpcksyVFprd2lLN0NHaEs4RUFzb2pDVUVi?=
 =?utf-8?B?TUxyNzdlZDFBRlQ0L2llQytxVEVTclNiRmlDMjdUME11cmgxb2NFTGtyYTBo?=
 =?utf-8?B?WVdrNWRQbDEyVmZMN1Q3RmI5dVlVV2Zwb2VwSzhxV05tK0drVVFMa25Da2pP?=
 =?utf-8?B?YWFHcTJzeDIvTlltUUdPb2FjeDB1WFRvUTlWci9aRjMyaHVKSERIMnJWaFll?=
 =?utf-8?B?Ty9mSEtEMnQvUVR6OGJZemppb1pDb1I3U0d2WE1id2VoVittMFNiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbce47a3-ac78-4142-0d6b-08df19ad2b71
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:59:26.0571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzZ/4M4aDb6BejSKwR0tdQCIQCM57aQnQgXKsDJ6r5l7uKQlF+8ezNXJsOR4GkPCc/OzoyBnf14d2/nxX/tLkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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



On 9/23/26 07:03, Timur Kristóf wrote:
> Assume that the AC limits are the maximum of all power states,
> and the DC limits are the maximum of battery power states.
> This shouldn't make any difference in practice, but is
> cleaner and more robust against bogus information in the VBIOS.
> 
> Fixes: e6c5d36756e7 ("drm/amd/pm/si: Fix updating clock limits from power states")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 36 +++++++++++-----------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index d090dcada1b4..f186aae9984d 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7238,6 +7238,19 @@ static void si_parse_pplib_non_clock_info(struct amdgpu_device *adev,
>   		adev->pm.dpm.uvd_ps = rps;
>   }
>   
> +static void si_update_limits(struct amdgpu_clock_and_voltage_limits *limits,
> +			     struct rv7xx_pl *pl)
> +{
> +	if (pl->sclk > limits->sclk)
> +		limits->sclk = pl->sclk;
> +	if (pl->mclk > limits->mclk)
> +		limits->mclk = pl->mclk;
> +	if (pl->vddc > limits->vddc)
> +		limits->vddc = pl->vddc;
> +	if (pl->vddci > limits->vddci)
> +		limits->vddci = pl->vddci;
> +}
> +
>   static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
>   				      struct amdgpu_ps *rps, int index,
>   				      union pplib_clock_info *clock_info)
> @@ -7246,7 +7259,6 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
>   	struct evergreen_power_info *eg_pi = evergreen_get_pi(adev);
>   	struct si_power_info *si_pi = si_get_pi(adev);
>   	struct  si_ps *ps = si_get_ps(rps);
> -	struct amdgpu_clock_and_voltage_limits *limits;
>   	u16 leakage_voltage;
>   	struct rv7xx_pl *pl = &ps->performance_levels[index];
>   	int ret;
> @@ -7311,26 +7323,14 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
>   	 * VBIOS can contain conflicting values between:
>   	 * - the maximum allowed clocks and voltages on AC or DC
>   	 * - the clocks and voltages in power states on AC or DC
> +	 *
> +	 * Assume that the AC limits are the maximum of all power states,
> +	 * and the DC limits are the maximum of battery power states.
>   	 */
> +	si_update_limits(&adev->pm.dpm.dyn_state.max_clock_voltage_on_ac, pl);
>   	if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
> -	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE)
> -		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
> -	else if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
>   		 ATOM_PPLIB_CLASSIFICATION_UI_BATTERY)
> -		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_dc;
> -	else
> -		limits = NULL;
> -
> -	if (limits) {
> -		if (pl->sclk > limits->sclk)
> -			limits->sclk = pl->sclk;
> -		if (pl->mclk > limits->mclk)
> -			limits->mclk = pl->mclk;
> -		if (pl->vddc > limits->vddc)
> -			limits->vddc = pl->vddc;
> -		if (pl->vddci > limits->vddci)
> -			limits->vddci = pl->vddci;
> -	}
> +		si_update_limits(&adev->pm.dpm.dyn_state.max_clock_voltage_on_dc, pl);
>   }
>   
>   union pplib_power_state {

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
I'll queue this up.
