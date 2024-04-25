Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA48C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 08:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F7A411A2B7;
	Thu, 25 Apr 2024 08:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uHrub7ef";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B603E11A2B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 08:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaKFj1sL10Y1NQ1SEuYEuuvOT6Gv52ZCdz9LbwVYaFr4dRbQBM9XGq6FgD7BkScTN9RDl8mJMb2JVcT/CGRFPIbsrzrFjZ9gbysjVNNwZpowSIOuB0jZVr5rJbpBY8q4/iSFJf64pC0kfyLjD3UzHLzQylZ0Zc+ADZVaGuK2jkQJX8RQKAT4ygZ4OSN34x2pOmCcD/WZfLxPtig1WcGa533mdwUER+ApsIV/TRLrIoh+d1BBaKClz67GsHzGQiSNAFPIwqnRx0Vv6NzaKZFEJMit/61PsceCY+3Y8OivoWejo261tDUv0q9N2BfR3vWRRMfoHAf1lJ6KGvmfo7ab4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa7lSmtGh+bx3zhc2F3EzVR8iPxd8f441camwpx9TXk=;
 b=EYMGr43cnYUKpBsJSbv7V8FBjKltC74r1JJX17RCon5GUEr76FiY4z70+NVs2CQRQU5HGM1nTE0vyt6aTrxezFl4KF+jWSB2tihxWnS8NcMQasTdrJypEo6O+tNlHKueVJ3CMCQDK9luvLCJN+afmsAbvRaZ9goIuY6N6frofrDzLBTzyJqKaIimemCnm8XtshyFppXalSUHW/6NeZdinjAFDUTZWQc/2iqoK3fJb9wAloligk+GIcDo1QT5Z1Nkyf0y7Gd6f+n5sPiiVOqwYIh7sWADJ18ZGFco0nP+kOSqNsFQIKjozyXshJbUdCeH8MX73teKnbVosaxLbkRsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa7lSmtGh+bx3zhc2F3EzVR8iPxd8f441camwpx9TXk=;
 b=uHrub7efWJtKX15/wUNb38bfkflgZRyEziL0lkbBxKvof4t/iquMBeqadfkt+t9PVh8kkUixi0/lfdGZjvHrOsPcYu9z22GM+0HapkWKCoEqjGPQGXlAri0gQ3co1phnRz7Z9JJTtVQIM0NbUyKl4FiUuk9lCThqdY05kYtaXes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:45:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 08:45:26 +0000
Message-ID: <71ccd680-0b93-4b54-9f1c-05b7a51a62e4@amd.com>
Date: Thu, 25 Apr 2024 10:45:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Modify the contiguous flags behaviour
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240425081527.3212-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240425081527.3212-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0f5733-a9bb-4f56-f1a1-08dc65040d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um9EclN6MlFxQmE4VjJwKzFQNU5wUkp4aGQ3b2RFbWFBM2Z0RHhPK0xTNDVy?=
 =?utf-8?B?b0pwZGFITmhyZ3ZqY2ltQVlqcTZhcjExY1VwNnBndVB4b1ovNTR5UG9zcjBT?=
 =?utf-8?B?dDhidXhUREE5aktSTitDVFd6N3lOZmdvRlFlYVNiR29iaFdQTHRaNm4zTC9a?=
 =?utf-8?B?bFRuL0xyeVZpaDArVTc1L3pjRjRmU05IYnpVQ2lqVFBJQ2o4YXVXb1RLTnNS?=
 =?utf-8?B?TG96TXFrUTNiZ25uZ2ZsTkI5Q0tkdEozU0xVSGl5YmpoQ0tBTVZCR2hzMWRM?=
 =?utf-8?B?Smx2VXdEcTMwOXBsa1RIbkkxSmJPRlNDV1JFS1BHTFhjaGFtcDljRkMvQzlN?=
 =?utf-8?B?VXhOMVRmYVU5MmQyOW5HZE9sUE0vbVgyRlFFcmVRZ3d3VVF6cWRscTYrckZo?=
 =?utf-8?B?dzZKNkxOVy9iTTNWMVVkSGYvNHJIRmZVZTI4MFpQZlpDKzd0L0srdzlpNlpF?=
 =?utf-8?B?aUpXb3M1UWVxMVFMeThFSkdpSHNxVzhJUXJ0OWFFQ3RybHE3VkFTVTZJT25V?=
 =?utf-8?B?MVF3ZEVHbWswaHA0V2hlYzlpR3o3MExaL0JiYWRtc09aNldEQmdDK3AyL0dK?=
 =?utf-8?B?c3JFak1IL0diWmlGMWZpZlBEeVFmZFVLbGUrZTliYVdLWk1XQUxTcDR6enhW?=
 =?utf-8?B?akxKWEdkOUhEUzRsT01qSG4xM1pmQTFxUWg3Q0pEN0RyRUR2dm02aFF0ejFv?=
 =?utf-8?B?Q1ZRODQ0WlRQTlVLYW5tNTFUUy9ncXlCcGV1cG5PVnNKVStpNFIycjN2MUFI?=
 =?utf-8?B?V3Z0MkFKSXNSa3NRR3RZd0JHSUQrTHNKVGZQeW1SWlRQTGhEeTZTcnlVRWtX?=
 =?utf-8?B?Z0I0N0orVnVuekR0eFpmamNRQVUyb05MNVA5T0JvZkYrTVdvZGI3eEs2TWJ0?=
 =?utf-8?B?MXQwb3NsT3oxMHlGdVhFRk91Z2FONnRKV3hlOTh0VEl5Y3ZVTHZoVzJVaURl?=
 =?utf-8?B?MkpZOVJhOU9GUFlYcXVTTTdsdUNKdjdTVktOQnFyNGJIZkxjcmZ1Mk02U1gv?=
 =?utf-8?B?c3pLblU0Tlg4WWphd2RrOUZ5RjF1WjQrdzkvcEozSEplcFRUWnluYkxZWjJG?=
 =?utf-8?B?SzJnV2NPZmpYNUQ3cGZSS0s5QzJSaUY5OFZSUS9jNzM5RkNwVXg2WXFkR0RJ?=
 =?utf-8?B?K2RxK1k2L3pFUFk3bHlncTRqRm5QeG9KSXJKalBYd3NzOS9GZmFRRVlHbnNq?=
 =?utf-8?B?YnBuOUFGNzBYQnJ2UUkyTTlVd3FaNzZzc2hlZ1RFbDNSZmpMNmw2cGFaN2F3?=
 =?utf-8?B?YWttU0pCbDFIaE4wRDF1Skl6T3cxZzdLd0VpdDNuNVQyWWZoamx3OXZWemdX?=
 =?utf-8?B?UUpNUVlDSVBoQngvZ0tJS1JuV1lGOWh1UzljajlZdjlPaUNTTlVHNGdZaFNB?=
 =?utf-8?B?SGs5MmEzaUNMRXhYL25JajBtVW5FRHk5VVJkSkZ3Qk5hd0dCQndROFdFSWU5?=
 =?utf-8?B?ODQydHkzSWJFczNsQkdqRW1sVDh5RHRxVjlYMHJZZm52ZWNqVmVsZEtLbk1M?=
 =?utf-8?B?M2xZaEhUSzhEVFhaVmxmSUkvTTBYZGdUU2RvdWxZSTVqK295U3RGVmVjeXFm?=
 =?utf-8?B?cFlQazJndzRocXhaRUlGcXNGL3VWeHRoQTU3cTFqcGdnNndhODFRVXJSb3g0?=
 =?utf-8?B?QVg2cVBYZk5EVlFlV0xyM21zQXZ1OTl3MFFob0hEZ2g3eDQ0cm9ZdXNIVDZj?=
 =?utf-8?B?RkVGU3ZSNTdRTExRN2NoUllMdUxkdzZTSExGc2MxRUJRNUhJTWh4VUdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1dnUmVjMTJqM0RyYm5iYUxkS3lnR09FM01tQm9CbExtamdITk11WTE3MXYv?=
 =?utf-8?B?b2pQeXB0aTNOZmhYRHFUOWtxbUt3am5TdXlFNEtpc2hRVGZkZkN4QTZMZ3pE?=
 =?utf-8?B?K0liOUM3MW9YZEhVYzA5M1JRL2tKWnlrYXFxa2tPTFhleUJkWGFjS2dackFh?=
 =?utf-8?B?ekZnbnU1bmN1ZVlFKzJ4bmFlOS9QQ1FKaUZuRGVpYUVacVlXVTBYaGt3Ukxr?=
 =?utf-8?B?dEpTRmxDNVFYZUNxQWVuSENqdmt2WWw0VDNwbHlwdDJYaDZkSnVJN0I5YlJG?=
 =?utf-8?B?QWRQY1Arek1aMmg0dkNqQWVIdlY4dW9IU3hiZEdLTzhrcVhiQVhVUUQvZVda?=
 =?utf-8?B?Y1RjS0krR3Nha096Z29zRUpycExuYWpTSUpUemZybnRwNVBsa2ZIVUNhR2w0?=
 =?utf-8?B?VC8zelFYbUtjNm84aXJPeWlFVDVPZHpHRlM1c21hVFRkVG5CWDRxRGNhRUF0?=
 =?utf-8?B?VzRRUEVLZmJlR3FYV2ZOYXA5YXMzL3FQTnJiTHdaZ1E1cXFBV0lXemVmUllK?=
 =?utf-8?B?RWpCdEQrbFVIWXhtVE96a3FnQmxMMWE4RmEwb0cvcFFSU3JRcWZNUEpIaENC?=
 =?utf-8?B?SnVuZmlMTmNJMVBNbkVyYTYzSExhem1sbVBoYWdiV3FMR1FRR3A5SFpSUXAr?=
 =?utf-8?B?V0x5YTAzb3JRaW00d3RqZFo5Zm9IZ1NGY3lhcUgzbUN1bk95QUIrbTZCaW5l?=
 =?utf-8?B?R3lteENoM2hzTjNkcWdLTkpTV0MyOEFnUXplbWdKZVBFRXpGQ216U2pVU2VC?=
 =?utf-8?B?U2JOL2N4OVNONjh2NXJHYjlraWxNM0I1MTdUYTlYcmFtbExnSkIwdWZDbXpU?=
 =?utf-8?B?d3ZNeHhlRC9VZXdreDdaQVp0NzduS29oMG5XTzJnT3JhNDFGMHZONXYrZ0dN?=
 =?utf-8?B?d2RqQ0kwT2V0TGtTUkxaWnVyZzBXSm5neEc5RHlyS1pFSFBaV1JzSnNlSyt6?=
 =?utf-8?B?aVdsR1h3QnRVU2hTZ1NYUk85RU9lSEZlK1VadmpkOTlQeTBLd2NwNzByWExi?=
 =?utf-8?B?VTR6dHd1YjExUmNVY1BmT1VOQmtKY2lvWlVLUHNPbDZjNWVhTEJUbVZ4QjBL?=
 =?utf-8?B?MVJTUXd1d09DL3h1NndVTHlmMi9laE4rQ2Z0Z3BobVE0TUZJdVdaeEpERlo3?=
 =?utf-8?B?cDJKVzJnU1RTaStscU1WTjZQdFRwU2lqNDAzWjNuRnhRdHRMdUwvOHI1eVhz?=
 =?utf-8?B?QllkVkMveWxqYmErZDZtNUZBOXJjNnFNMGsyekhJTTdKR25nWGlGRXgvaHJS?=
 =?utf-8?B?a2ZlOUEzVWphOU9YYVVVTWRsNWJvTHhSUnZuNjg0K2Qwb1VaY0pkcnd2d0xD?=
 =?utf-8?B?dHVGejIzL1lpZEVMTVpDNGJEaWdpQjhqdEZOdk43Q0U0RUtBZE9zMkRyM0pL?=
 =?utf-8?B?SWFlcE5oMkFMT0o0UnJHc2J2UzZCejhidUg5MGpScE1UVXZWdDgyQ0ErTU9o?=
 =?utf-8?B?RFRiMDFoR0pHcklsZGljdmx3anZoSzNUL0hTZ3FUTlFHdW9oV2kxT216TGlF?=
 =?utf-8?B?UFRReUZETXJZTm9oczZaTFpjSjBYYy9jbmRCNWE5UTQ1aS9rNXpKQWF1MGh2?=
 =?utf-8?B?c1ZLSFRzRndyTXYwN2pvTEl6VE41dkhjVDcwYlhHcytpK2hyMmd5OWIrMVdL?=
 =?utf-8?B?NXIyTGlSVFd1b3ZQMTJvdFJ5cjhBQ3A3MVZaa3A0WDMzNG9LWVgrRUJ4RWND?=
 =?utf-8?B?WU9sek95OWdsVERQdkgvQ0pjanNuNWVEbzk2TURGcDFoZU5kMkFNM1oxYms4?=
 =?utf-8?B?SHhtelRiM1JoUGc4alFrQ2s1dmNoZTlsV0VsWVF3clF2TU9XeTExTU5RaDVo?=
 =?utf-8?B?aUJ6SHh6eWRPUWlyUXZzcHpaYks3endaeWh0aVBxTmNqVnBqbWYrRG1UbzNk?=
 =?utf-8?B?bTJCVVdVUVVqd1hOQUlENVVmOTJ4bE5jUGV6NDVFY0xyWE5naXNpZUt3USt6?=
 =?utf-8?B?Yy9PZHZIeCsrR2hlRS9neDFzUkZOMEh4eFE5Uk8wdmFGUUFPTWpHdUpzdHJ5?=
 =?utf-8?B?WEtuaVoyRFVWY3EvUGVaL3FUanB0U2I5bTN1WkVnZGNrQU9oaXJ1UGtrMmtm?=
 =?utf-8?B?dmRpRkt0eXlha0JCTkIyZm1OaVU0R0o2UkVUZVZjMkNIeTI4YThlbUI3ZXlt?=
 =?utf-8?Q?bfPEYAiqNjVMl0m4rFJIgRu7m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0f5733-a9bb-4f56-f1a1-08dc65040d90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:45:26.4032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a00uEls99m7s7hR5OXvMnwMNraWvJrOVmXPH0cJh5m0SHR+pOPnwn827ZFd1NSUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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

Am 25.04.24 um 10:15 schrieb Arunpravin Paneer Selvam:
> Now we have two flags for contiguous VRAM buffer allocation.
> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
> buffer's placement function.
>
> This patch will change the default behaviour of the two flags.
>
> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
> - This means contiguous is not mandatory.
> - we will try to allocate the contiguous buffer. Say if the
>    allocation fails, we fallback to allocate the individual pages.
>
> When we setTTM_PL_FLAG_CONTIGUOUS
> - This means contiguous allocation is mandatory.
> - we are setting this in amdgpu_bo_pin_restricted() before bo validation
>    and check this flag in the vram manager file.
> - if this is set, we should allocate the buffer pages contiguously.
>    the allocation fails, we return -ENOSPC.
>
> v2:
>    - keep the mem_flags and bo->flags check as is(Christian)
>    - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
>      amdgpu_bo_pin_restricted function placement range iteration
>      loop(Christian)
>    - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
>      (Christian)
>    - Keep the kernel BO allocation as is(Christain)
>    - If BO pin vram allocation failed, we need to return -ENOSPC as
>      RDMA cannot work with scattered VRAM pages(Philip)
>
> v3(Christian):
>    - keep contiguous flag handling outside of pages_per_block
>      calculation
>    - remove the hacky implementation in contiguous flag error
>      handling code
>
> v4(Christian):
>    - use any variable and return value for non-contiguous
>      fallback
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 ++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 ++++++++++++++------
>   2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 492aebc44e51..c594d2a5978e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -154,8 +154,10 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		else
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
> -		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
> +		if (abo->tbo.type == ttm_bo_type_kernel &&
> +		    flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>   			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +
>   		c++;
>   	}
>   
> @@ -965,6 +967,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   		if (!bo->placements[i].lpfn ||
>   		    (lpfn && lpfn < bo->placements[i].lpfn))
>   			bo->placements[i].lpfn = lpfn;
> +
> +		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
> +		    bo->placements[i].mem_type == TTM_PL_VRAM)
> +			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>   	}
>   
>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index e494f5bf136a..6c30eceec896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -469,7 +469,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (tbo->type != ttm_bo_type_kernel)
>   		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
> +	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>   		pages_per_block = ~0ul;
>   	} else {
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -478,7 +478,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   		/* default to 2MB */
>   		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>   #endif
> -		pages_per_block = max_t(uint32_t, pages_per_block,
> +		pages_per_block = max_t(u32, pages_per_block,
>   					tbo->page_alignment);
>   	}
>   
> @@ -499,7 +499,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (place->flags & TTM_PL_FLAG_TOPDOWN)
>   		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
> +	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>   		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>   
>   	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CLEARED)
> @@ -518,21 +518,31 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   		else
>   			min_block_size = mgr->default_page_size;
>   
> -		BUG_ON(min_block_size < mm->chunk_size);
> -
>   		/* Limit maximum size to 2GiB due to SG table limitations */
>   		size = min(remaining_size, 2ULL << 30);
>   
>   		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
> -				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
> +		    !(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
>   			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
>   
> +		BUG_ON(min_block_size < mm->chunk_size);
> +
>   		r = drm_buddy_alloc_blocks(mm, fpfn,
>   					   lpfn,
>   					   size,
>   					   min_block_size,
>   					   &vres->blocks,
>   					   vres->flags);
> +
> +		if (unlikely(r == -ENOSPC) && pages_per_block == ~0ul &&
> +		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
> +			vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
> +			pages_per_block = max_t(u32, 2UL << (20UL - PAGE_SHIFT),
> +						tbo->page_alignment);
> +
> +			continue;
> +		}
> +
>   		if (unlikely(r))
>   			goto error_free_blocks;
>   

