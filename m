Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AAE108B8E9
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 10:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF1310EAB6;
	Fri, 20 Mar 2026 10:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0j66Q4u";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5425110EAB6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/mEZm08xV06nrBEFUiag5ER+8FL25jcopPCZL/npJLaN0hX3av1rtKrMPPzmC8LJAJCLCAe5mzkyv+9FNbiaBbSRHiBEbhVdjJZ8rusTNpABYM5cJd6ihIU8l5sEAPuMRNuSCuK9uNViJbp37tS39ZyYXkGjFYPR3TudKgfp5twS86ddrCO2LxVMJyApZ3H0q+y1jEqhPKKZsyqbXXHkDhBhDCCnf8YyOcYncAhZDNMYol1rLdhR0LC5CPnihM59gUAibVgsmADFlNb9+PdQUD8ock6b1/VfSTusGJuyAOPcuNGsBqgK7g1czsWZRdoBnsd5RcZt30mOFw0MfnZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LxogCBIzW8hQie6aFyxkwTUaaYkcoWR0e1oXoopFcQ=;
 b=gmHExgDjLuz0Pkv3uQCd9nWxKHQ4D6uTBWyrtsfrUp78EMgfEtLbA5wbS3mEnN+eQMzIJp3DIIqNZbJOeQ/aYjlWnR+OX1SRcSOgQ42nFRfuy2SjUNu6ptXkQjnKTwmxTnXCJglRrYCL9mGLeb5qmCFnHhF76Jba1yzDeX6bbiIcaWyV1D3xiijmWe0ptFPmHFSJbweVNHeMU2BfERa+uLbR6SD2dzZs04xy6LmyzBSmnuqDHHeXbA+0jGsSjynurGiesezleEkk5+Vvm1dq3WfpOwMQHsAoCRIAd/P+9/8Z/ORYm1JN6ue9+8tA/gyeBH/8L8yQfScbMlVLhs+APQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LxogCBIzW8hQie6aFyxkwTUaaYkcoWR0e1oXoopFcQ=;
 b=A0j66Q4uKYaI/CIpa4/bWm97NPr/4jrssV1BkSCaTA/Ue8pODjElGZHvh9/x21mhDVuGDL8+ld9QE67uKakz/mgp2ORdsJKHqB76GOlTOOEEBExmHrzCzzKvC7FSWfXofI/2S38xR12qpZevBBqO+8mZ7DNpjYhYV1yOMNJ2yrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 10:32:12 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:32:12 +0000
Message-ID: <c06ff453-5249-47e5-a13d-5275793226fc@amd.com>
Date: Fri, 20 Mar 2026 16:02:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: harden discovery TMR buffer allocation
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260320095737.238247-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260320095737.238247-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0247.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7c7c83-d31c-4e0a-36f8-08de866bf26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: LPMJVQVO4OYSpnS14RcKmSDiYtwShj982vknoUlQscES9g+DZnXXd9PitkhM1bqBxNSAncm44ZdsDnwUWYDwzp+j194udQvvqjsB1lmJA4m0QLN1t8gaO557kUhkXR4GPrjxasYchIyW+VPrkk+sc7/l8zpLd7XyIjNPtMF/3vHf6q34P0HHr+pDr/+aaTAafb8Ywkzs+DR7JW+BBmiz46IAzmRznT6LNQusctwz9uE8ZFEBcgHZ+MgE1B2zE+d7+Uyb2WojVxQcsc+V9/y07RcQBg5ZXNVYWy/xbBhbtUM8H8CjrrJupvfR6RyujT2ZTfajXwfgbm8DTh8S+XRJ1TDkq6KGB8C+NhtjibCSKs463cFWp/xKfgU8adXFBaQk/M3HYAXz/bcc9EENk/ZRfRSIbJvrHMfZjgDd62icr9SnnhknSlBbbxaYSW4spDtW0THAle/PQtTtCKXT7qPqYfCvI+BdvNEeVFlqZBRSDsKPdCl4F5nX9Fsdi+KKRV27EJu9xfhbCt/dMbzo7p0cZHU8BQXjoJY7V3ei9SxC6u5Qo4+bV3Lh3CTAZiZ4kSWG7ClbiwPD30BtYN4mH/2DBJOX0QXI3Ni7zpHabrAPY+Iw2zJqEG4J1CyIVn0AyQDlOIxWP3E6cbb8HPhUXZGQDxBs+HqemxT28o9woqF9VQnAUrCB/Gl/vtCfkodwKeSQWs/wJcxYaV6fubhDlCfADZiOu4te5SuywZGvRqLN8A0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlXcVEySXBmaWJlaUJVSUFTbjNaS0FWVHFmbEVKT0hydFpEajNTZ1pKZEtL?=
 =?utf-8?B?dnJudy9uaS9wVDNyN1RhTWs2aUdVbkphdVJiR0dYa2loVTgxVXNMNjlTYm1L?=
 =?utf-8?B?ZHFhUnpiaEpMajJlL0FmTWJzRGZ6NzhER3Z3M01qMU1qN3BEa0Jsb29rLzJq?=
 =?utf-8?B?Z2pJeGs3bkxsOHRMZkRrcTBzU2Z2VHFKTWt5SWg3RzFoaUZzdWZpR2RyTGla?=
 =?utf-8?B?RlhuYXlPNnYweFlqekhkQjNZWlRyTUl6SGw0ZlQwZUxOYkNVdFUwMVAwTmNw?=
 =?utf-8?B?SE9YY29ldVoyRWpFdWJ1eFQ0Q0xoRFkva1BSR04vUHQ4dGZjOHp5RG9JWXFH?=
 =?utf-8?B?OVMvMGkzTE1JUVVKdG1TUlNoWkcwd0hQeFFmY3NpSUFYclhBTHk2eGZPM2c2?=
 =?utf-8?B?TzdPWUVsVlNxWjgzc2hWZzFFbk5XTTU4dm1ZNHZOZDl3Tk03NHFpSkM1TUVl?=
 =?utf-8?B?NThTcHpGZDV5Nk5xd3M5VmlLWjUzNnF0WUx1aDc5UkwzM1JtZWx1cEpDOVF1?=
 =?utf-8?B?SENjOWRERERxcXRBMThYd21RNHNwa2ZjL1AyWHBDNWNtcCtLMFMxQ0hEZXp1?=
 =?utf-8?B?MmFMSW9hMWsrU3F5aDl1cVZUalRWbDdDM0Q5bWJPSzlYVlhiY2MvaG54K2Va?=
 =?utf-8?B?Z3hiZXhyMUx1bHd1MVBjTjJoR1ludHNIZDBSSi9vU2JVM3ZsUkR5RjFxazBh?=
 =?utf-8?B?dlowU1JheTdoZTlra2FHNDN4ZlhoNXdvUG13eEhCbFFJVEd5VW9mUFBaQUVv?=
 =?utf-8?B?Nlo5ckZnTm94ZVUySG5yeER6SGlGWnNocnNUOElvRGZZbFp0NytFaTFiU3Vj?=
 =?utf-8?B?Q3R0QnQyWUxkVEZkRDF1V2NGaHUwbkhEWDE0Y1d2T1Q4OWRJbDF4dFlWSHJq?=
 =?utf-8?B?b3R6T09DQzNBd1paVFE1d1FBWlVZRU5XYmE4SmZQaW9FZUNzWUl5NkhHWU4r?=
 =?utf-8?B?bFY5cmxqVnBVVkdVRysxYXVMZmZ0TVVFbzl0YU5pb3JKSnFtOU1FSWhIaHJi?=
 =?utf-8?B?RXk4dkp1bnJqQ3JmckJTTUE0S2djeG5mY3U3UDdHenlYVHNCdXdidU12TDBD?=
 =?utf-8?B?UENETlEvSy9hdVVNOEgwZVJxYWVzeG44TWxHZVczRHVZbzJVTDUweVRrb3dV?=
 =?utf-8?B?L0JCcXFrNHlVYlVzam5abUJHdmVBZ2VYWjlTb0Ftb1VJN0dpME9SY3d3Y1lE?=
 =?utf-8?B?RTFya1RWSWdVMk95R3Fvc3E4dXh2eVBKb2ZGREhNbG5wWlY3VEpwMkRxWVl1?=
 =?utf-8?B?aG5HK3c4MGR3aCtneTVucFU4U2E1bnNoMGZmWUJmT2FRY09hOW5RNXNUQldG?=
 =?utf-8?B?c1lSY2V0MnhnMGNxNUhMYks2RkpSeDJITlNzTFN4N1M0a3pMUnNKZ0E2bUtV?=
 =?utf-8?B?QnkxVU5vajNML1FMZC8zUEs1ZU1HQnhMWjJOVkN4dGNSTEZxR0ZQcXc2Vndx?=
 =?utf-8?B?cGMvdmNkVXdoOWh1dnBtTnhsZU4zMllsYkxiQlcvZG84MGw0L0VNUEpZT0o3?=
 =?utf-8?B?a3lmdE4zb1JZVjkwUjk5UjA5T0c4R0VhZW1UbXJwa1FqZkNsMFlYK3FwUnls?=
 =?utf-8?B?Z3U5Z0FCZG4yUnZuR3k3VUhqUEdvRlNpanlBYWZIVVRHZERvV3ZMbzl2V3FF?=
 =?utf-8?B?RmhST3B3WnFGbkhBWE15aUJZTE9sRExFS3pKd1dJaG5PajZ3OFBERGRlTjhH?=
 =?utf-8?B?SlJ4dXJrMmJ6Q0lzc2lDRU5KUWYxZ3JnTFBIOWM2QXdOMExXNUcvTXU4cHJX?=
 =?utf-8?B?ck5YVm5sd0J6R1lBS2ZwS09JREdreVZJZWNibjRlWW5YZ0NNQnI4ZWxwZ3hH?=
 =?utf-8?B?WHUyM3BWdGZBR2FmNjRIYUhvYUk0OEFyK0RZczNneDBJVXBzekhKbmRKUGNk?=
 =?utf-8?B?UUJSVVJmckNJLzN6ZnJxOEVtTWpnT3Vmbk9MaWtwTTRwTGFiaWZ0MzZMRmFI?=
 =?utf-8?B?VmY0U1MxT1hOdWo5blFhQmk4MlRZOWQvV3hoUlJ5dER2dFRiQnNFWld5LzVE?=
 =?utf-8?B?cUJPSHBSbjZvWFJ3d2xTUjZqblRQaWFBYXN2NkFpN1F6eENMVURtUzRqSnBW?=
 =?utf-8?B?UTI0YVFndFlBazN1K3YyNmVhTVRzVlNrVGNKbHh4alIyK1llbDRlYTlrSE9i?=
 =?utf-8?B?V0UyeXVvaFpsb2ZiTDkrd3MrcHJWQmNCdE5ER2tNMlRVWEpBVThISkIwTDJL?=
 =?utf-8?B?RmF6cUU5SVhQYnN4UDR3ekR5WWQvOStMamlZUDl4ekRna05nZTBwaHVCd01n?=
 =?utf-8?B?cUdUYVpDL2IvU2VSZ3FmUlZOT29FNVRGNGlLdk9JSUtoWWtSbU94T0k3TUwx?=
 =?utf-8?B?REpGU0FpSjVtK3ZObUZQNW5MWEk3cWtWbDIzS3RMYWJRYnhQdiszdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7c7c83-d31c-4e0a-36f8-08de866bf26b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:32:12.3731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z1s/+h1AiKvHNFW1vPsUbMGOqphwkAZEZu4OXvmhZY+ZnqbVhZH02osYGOoLJS8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
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



On 20-Mar-26 3:25 PM, Jesse.Zhang wrote:
> Some platforms report an invalidly large IP discovery TMR size, which leads
> amdgpu_discovery_init() to attempt a large kmalloc allocation and trigger
> page allocator warnings/failures during probe.
> 
> Observed log excerpt:
>    WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x29e/0x340
>    ...
>    ___kmalloc_large_node+0xf2/0x130
>    __kmalloc_noprof+0x442/0x6b0
>    amdgpu_discovery_init+0x161/0xa00 [amdgpu]
>   Fatal error during GPU init
>   probe with driver amdgpu failed with error -12

This looks like a different issue. Do you have a trace of which path it 
takes and the value seen?

Thanks,
Lijo

> 
> Fix by:
> - validating discovery size and falling back to DISCOVERY_TMR_SIZE when
>    size is zero or out of expected range;
> - using kvzalloc() for discovery buffer allocation to avoid high-order
>    contiguous-page allocation failures;
> - using kvfree() on all release paths.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 5a4e63e1ad93..a6b49378c495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -329,7 +329,20 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
>   		}
>   	}
>   out:
> -	adev->discovery.bin = kzalloc(adev->discovery.size, GFP_KERNEL);
> +	if (!adev->discovery.size || adev->discovery.size > DISCOVERY_TMR_SIZE) {
> +		dev_warn(adev->dev,
> +			 "invalid discovery size 0x%x, fallback to default 0x%x\n",
> +			 adev->discovery.size, DISCOVERY_TMR_SIZE);
> +		/*
> +		 * Some platforms may expose garbage TMR size through scratch/ACPI.
> +		 * Fall back to legacy layout in VRAM when available.
> +		 */
> +		if (!*is_tmr_in_sysmem && vram_size)
> +			adev->discovery.offset = (vram_size << 20) - DISCOVERY_TMR_OFFSET;
> +		adev->discovery.size = DISCOVERY_TMR_SIZE;
> +	}
> +
> +	adev->discovery.bin = kvzalloc(adev->discovery.size, GFP_KERNEL);
>   	if (!adev->discovery.bin)
>   		return -ENOMEM;
>   	adev->discovery.debugfs_blob.data = adev->discovery.bin;
> @@ -694,7 +707,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   	return 0;
>   
>   out:
> -	kfree(adev->discovery.bin);
> +	kvfree(adev->discovery.bin);
>   	adev->discovery.bin = NULL;
>   	if ((amdgpu_discovery != 2) &&
>   	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
> @@ -707,7 +720,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
>   void amdgpu_discovery_fini(struct amdgpu_device *adev)
>   {
>   	amdgpu_discovery_sysfs_fini(adev);
> -	kfree(adev->discovery.bin);
> +	kvfree(adev->discovery.bin);
>   	adev->discovery.bin = NULL;
>   }
>   

