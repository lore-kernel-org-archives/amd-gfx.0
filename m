Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A17C83F11
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 06:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2930A10E1D1;
	Mon, 28 Aug 2023 06:00:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FAA410E1D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 06:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b12AguwPvBqhuaDxSEz+QKTXwIM0N0Y1rHzTh9QW3Ekvfz4VwEtPrrrIb/Oh1ENupD/gTCPuBUS6rMQGDivxK69exd7EVY17Im+U22weh+ocABjv/lJT6Lwad9ndDVz5BS5m9vstHfi8SkyUvOfYfsc1WaMe54Ih77Xu0LqBXjCdAqGfsw3GkSWbaL7ZobF1AN8X4SJZzwGokG+7I20VVB13E2U83a3PPcHm1XDsZTUdNKKH+vX2oq2sE7udo9wJ23YKIJn4YZlvG7MG+D1joVyVgL8sKQdSpxRpkfMJSAYsRqX6RjmS+P6K5ujCFPrPJhg0UlHmYkhHilyTWuwtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jwcJzrkwgXT0OrEbtwZNRZKWKUXF412kTvqgRy+V10=;
 b=Rp3fRBc7S2t+1yd0ZLfvEqitEmXOlldeuQsVfnLzwJ7cNmVoHYfnqCs15lXMKgc9CwPZQZEKK2Ld7MlDfJ3AvFvaYQsGhQYzBiubRFhIt0jlTqFR1/B7SvD0TtM5tYTz6EMrObj8xPc98nQRf0r7Wn8V9p0Ug3zwssp7U3gZBMx6htOrqppEhg5/iws9pHvydpyAam9pj4+FHjWryqGLVnh8qsEkBNzGC+vsQqD/chNzQ7F5r09Bzs36KyGtmIrpfp06OTmARMSCxlZn443gAMlJKY1FchOeeF0DFcqXeWcoq/8a7aBssQ3InMzcwNCCqKM6N/nBuZErHyiFUhE71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jwcJzrkwgXT0OrEbtwZNRZKWKUXF412kTvqgRy+V10=;
 b=SxhANVbtr5h2vxyE0m8Dp7QPIJXMQKT0+Nylb4I8cuajVt6CbRUTF/HQZ5/oKx/Iat+XIB6lFlRCTfG4f4deiIlL9CC5Hjpr6iwYWg/qhFshQJIwYqW8rq+wMhpvVP2b/CkD5s0P57Wa+jRfHhmte34z9AnNXP22NB0EknSeKzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:00:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:00:39 +0000
Message-ID: <aaff221e-d61e-f2b0-bbff-c8208e067ca6@amd.com>
Date: Mon, 28 Aug 2023 08:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amd: Simplify the size check funciton
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20230825052204.1315534-1-Jun.Ma2@amd.com>
 <1c44f172-99b4-3981-a646-48d2b18ba149@amd.com>
 <b3df28b7-286b-7e5d-f6a3-ab144846247d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b3df28b7-286b-7e5d-f6a3-ab144846247d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd52292-891b-4513-576a-08dba78c1b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61ElKxuKdvnUWOksgvqU6GpjGhUuGHSZid7k1CRH2DCqqLhVqDZO952M+VX97l6KpvaF1gA7xGO87aMX9X32kalKWFNRh7T/B8jUCvGju31ZHdbsQPEQGzj3YjNT1NgDnP+uYwdE0pK8DSPhoZrg5ZxA4LabT7RfsnSwUV5mJW3wTGtnPkTC2GaP8kII/x5EHMgj9FsjMuyGOYzDZHpBJ/g0oFAsVZXVWI2boPshPLWMFMKSyfHmjMWLVw8cH7HuNhMBTMKal0aw+142bx7/i+EOn98PE/yLkCaks3Qy73YKKJqZTcx26zf58ueeGpmkx92YjOHShY2M4CpWGA6/Med7eVwNshm4yeU4BQGVYMvIUoprTmbFr3e51i8eyjfXG1NjWH+HrM4KRkuGTU3+Ccfe57T3xlo1I2TCmvgFkoiV3VcH8bH1naLcQAS2QuiC4Gpu3FB7H1VRE67uii0ieReULjxKPSfpNG/AR0lxYsBNxlEotUf+FVyeOueyIsmePqIqfoWoN0Rr2BIdkGxtBfp+ofyeJ8J9aBu1Z6t9smT8NsDGz+fNraJ3/vj48cIjKw8bUIOjsiT29BSm7jrdhem8uNyQIXtdbZgWffHSd/jQmkXz6WfriE9sipVt6N4DnM2+k315Cs9lL6V/u+aJYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(186009)(1800799009)(451199024)(31686004)(6506007)(6486002)(6512007)(6666004)(36756003)(86362001)(38100700002)(31696002)(2616005)(2906002)(26005)(53546011)(478600001)(83380400001)(41300700001)(66556008)(110136005)(66946007)(66574015)(8936002)(5660300002)(8676002)(6636002)(316002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpxcDlDbjhHQmhKeHVrT3JhSnREWkZzZlB4UjIwQVlzVVFUeXJuOEpoYzhM?=
 =?utf-8?B?TkdUREd1UStCZXFadU13R0xIY0dlVUJheW41WHFNRlZNUUd6cHdxNnBDb2dm?=
 =?utf-8?B?YkYyb0k0ZmdwNitKT1Vucmtjb0ppRitNSHc2M3BKY3d0Z2Z0K0owaW1TazlH?=
 =?utf-8?B?Yzh2OTZ4SWo0TUp0eDNyM2lsRHlSeGpHeWJoanV3YTYxVTdSaFpkdTR0aElU?=
 =?utf-8?B?UWxmOU5xVFdPWnc0OE4xcjN3UlF0Y25EcjJWZWpybzNtQWRndkIyWmR4bjN2?=
 =?utf-8?B?MDRVK3EzV3FNRUhpemZkbnFsUnVPbjhNRTdwaDBWM3A2WkJkTkVsN212NGxr?=
 =?utf-8?B?dGlYWUxQblJYaVpuVlZnckxtdGtUZUI5cnFiY2dkTldVaVpkdzNWc1FKTEZY?=
 =?utf-8?B?RFJoUDBOSmY0a2FkTzUyUTVhVlRHY3BMYmMwaHFrTk4yTXJ5RHlEUHlFczg4?=
 =?utf-8?B?LzJ0R29DMGwyTTVpWjl2WkFqbU1KdExsQVB0SGlYZ1dJTElOSDNmRkxpdGt0?=
 =?utf-8?B?NjY0a3dsdFN4QmRENjQ2eEZlektZRFdyTXByY0daekRnTURWc1pOOEZZUENJ?=
 =?utf-8?B?VE1sdzI2ZDJhZHZVMXZyZE5Tb2NXOVdZd1A2S2s1bXNsRDFjb2V6Q25GMGpv?=
 =?utf-8?B?aWJIK096QmU4a0FvNzZPV1VmS1JFMVBNNzRUa29QWGgzeDRQZlNTMlNUeW9Q?=
 =?utf-8?B?eGd2akNOOGZwUVRObTR2Y1NjYWtCbStXdDg4dzJsWjNQdUFoRWQzYi9HL2ZE?=
 =?utf-8?B?U2RXOU9hNytSOHVodnRaZlZlNTN6dVJSNWVuVVFjbEc3T2RkaEpMUXhXZGVJ?=
 =?utf-8?B?TmdWMTlZbjFPZW40amVnRGpPMG1NMDN2Mi9TTjdCdzlURlFlVEZwRjdDM0Vx?=
 =?utf-8?B?eTgzRmNEM2lTNkRzZitHVWpUOUpoVFk1L0dyZTYxKy9IaWN5M0JMU20vdkpo?=
 =?utf-8?B?c1gwWjhiays2RlNEVXpGMktTK3h0MU9EaUtkZ2RjOUxmcnBidHZNTHVWdXJy?=
 =?utf-8?B?K3BlZVVsNVpoS0piUkZvUGFJUlRUZUtqOEs3bE4rQm5mWnB4OTN6dSt5Q0pY?=
 =?utf-8?B?eWdEVEJGWmdRSjRDRGdicUxEbEN1Y2pPTTErelpBYS8xU3dlc094NWFhdmhw?=
 =?utf-8?B?eStZd2JraFh6U2ptbnFQVStWMUtEN2hWaHlRYkFRNjBwVkdVOFl6bXcxR0FD?=
 =?utf-8?B?MDA4QngxQkJHVE1aSXdMVlR6dGorR21icUdRMTFoNTRzVkJ0UXV3Tm83OXc0?=
 =?utf-8?B?WE56VDIrYXQ3czF2dDFySGJ0TzZNYU9BVndqWURwM2YzS3YwU3h3M0h4U0pL?=
 =?utf-8?B?cklqOGdVZDgwNGovbStxT2hRK3lFMjRKR3k1WktQVWJmNStqRnQwWlVncUp3?=
 =?utf-8?B?KytsbEI0N0ZpalVDdWhLUWNkR2pFbndPLzh1cGYxSlRPSmhVcDJidkc5S1hP?=
 =?utf-8?B?NWxvRzN4N0VJMllBNEc4UFNxbjFCbktuRDFrSnlPMlRMM3p5ZzdKV2pUbDA0?=
 =?utf-8?B?WjI3bUtzVUVzcVpodk83Y2N5d1NnM0pUU1R5NjlhUmE5WXhvb3VGeHFBZGx5?=
 =?utf-8?B?bVlieWc2cmhOdlRvZUhmQ0ROYU0rNElFZmttUUtKVVZKSTQ3WFVVSkRHYjRG?=
 =?utf-8?B?UTg5L2k5a3Z2V3A3bFdMQW1mRWp3bWV3K0ZVYy9nZyt1NkZrK2NtbytTWkd5?=
 =?utf-8?B?WGhOM1QwU2JvTEthVmhyV25CK2wrVVVBYmptOW91aHExcU0yL3IvdGYrTHhT?=
 =?utf-8?B?K3hvdzVpdHFjSDM0VG5DcXhLTGw1MmNNYVdTWDd0aWNaTUdjbFRiUjFHcEpH?=
 =?utf-8?B?Rm5QejRxUldhUGZUQmROSmsyc1JLSmdueUZKRGl2TEg5Q25PYmhuUUFHUU1Q?=
 =?utf-8?B?WE1ZSEJUU0FBeVhaMjF5OFJFNVErU29oWEEveHRHOHRVOUpiem5OeGNnbWRS?=
 =?utf-8?B?QzNwRi83UWZKdHQ1T1l4SHlpNXlwd2dKWXRTakxnVUMzbjJMWkRKYXpOYllv?=
 =?utf-8?B?RHh6NHBRM0s4UER1cS9XWERMNWdKdlFxZ1pObDNkazBMbWlCQmY5ZHpzYUVy?=
 =?utf-8?B?dE5wcWhkcms0bzZFV2xGSmhuODdIdzBKc1UvN2xUVTdLTkh2L3JyUjVGMTkz?=
 =?utf-8?Q?GCiZpsjkEXYGCaPUzcXEhYrwV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd52292-891b-4513-576a-08dba78c1b2b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:00:39.7645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOKd5sT67+MkVk8VXfv1YK5fCn81JxkQsCq28CpcfaTmKcXriB9Yeap29ChbUjH2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

Am 28.08.23 um 07:09 schrieb Ma, Jun:
> Hi Christian,
>
> On 8/25/2023 4:08 PM, Christian König wrote:
>>
>> Am 25.08.23 um 07:22 schrieb Ma Jun:
>>> Simplify the code logic of size check function amdgpu_bo_validate_size
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 +++++++++-------------
>>>    1 file changed, 11 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 807ea74ece25..4c95db954a76 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -480,7 +480,7 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>>>    		*cpu_addr = NULL;
>>>    }
>>>    
>>> -/* Validate bo size is bit bigger then the request domain */
>>> +/* Validate bo size is bit bigger than the request domain */
>>>    static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>    					  unsigned long size, u32 domain)
>>>    {
>>> @@ -490,29 +490,23 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>    	 * If GTT is part of requested domains the check must succeed to
>>>    	 * allow fall back to GTT.
>>>    	 */
>>> -	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>> +	if (domain & AMDGPU_GEM_DOMAIN_GTT)
>>>    		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> -
>>> -		if (man && size < man->size)
>>> -			return true;
>>> -		else if (!man)
>>> -			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
>>> -		goto fail;
>>> -	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>>> +	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>>>    		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>>> +	else
>>> +		return true;
>>>    
>>> -		if (man && size < man->size)
>>> -			return true;
>>> -		goto fail;
>>> +	if (!man) {
>>> +		WARN_ON_ONCE("Mem mananger of mem domain %d is uninitialized", domain);
>>> +		return false;
>>>    	}
>> That change here is not correct. It's perfectly valid for userspace to
>> request VRAM even if VRAM isn't initialized.
>>
>> Only the GTT manager is mandatory. That's why the code previously looked
>> like it does.
>>
> Thanks for your explanation.
> How about changing the code to the following?
>
> +       if (!man) {
> +               if (domain & AMDGPU_GEM_DOMAIN_GTT)
> +                       WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
> +               return false;
>          }

Of hand that looks like it should work, but I need to see the full patch.

Regards,
Christian.

>
> Regards,
> Ma Jun
>
>> regards,
>> Christian.
>>
>>>    
>>>    	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
>>> -	return true;
>>> +	if (size < man->size)
>>> +		return true;
>>>    
>>> -fail:
>>> -	if (man)
>>> -		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
>>> -			  man->size);
>>> +	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
>>>    	return false;
>>>    }
>>>    

