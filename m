Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A0FD1715D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 04:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2629410E5D2;
	Tue, 22 Oct 2024 04:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIxm5TlE";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B208710E5D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 04:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udVKXaKdzTHu5tLI4wTlO1J8mR7+X44HkQMoRMHsIjVYhL8NcImuTHgKjgIZl5IsBemWdQKzjTVuUTHdLJtJ/uRaHsuNbK1I+MT/bf1tJ6+G9LBIDM1LoalORAFc/GEef5I6YERS3beUnS7K1Ib/urxwAFxY+iTGJgpjwcGuWqf3KUO6A4MGtcPmVomBmfOOxdFw3HIJk/AjxtorgO95wlVYeLKwMx9qfQvssvNoDE+dBtuiiSKHlI20h+0kR/Tfsh2KtjZZbgT44auKdSvyltXWtDLHm1/nj/bnrNHGrLtc1fEsKAK5EEFZ1e5xWv6YBvUwQTBaNh+sesq/O0dgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HqKWi476YTpu0IMS0LwyeRBJhZgkAnU1gTn2RbnFKY=;
 b=r/R62sc1ISgDGcCJWAddfquNyYZ4u4H2lMaSqB8IYOukNfapf8V8mLo8FR5h3ZbqI+76eC3wR1uvAFwD/LT2UrU04xzdhaqw3+dqdj1IlcrwcL42j/U+1OtNsP4G/pT5F3DEg2NviE9BvNUCJvy1tIAkxH7y7ZanbtAI4GocJtNbz8Fcp8YRjWeZMxoVbKHYR/3O5hJmrNY4pUueu0cou0aTwPdOoYNwTxtopMu6X//1M5JjlkiuQy904747S+SfExWXZc0PLDKdLya7rho7NeYE1CcLrPy59N+0qXb0kxhkuMM0PLZAdX67WO6p3nz/eCQuxOJfxzBY+/7uwn7oxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HqKWi476YTpu0IMS0LwyeRBJhZgkAnU1gTn2RbnFKY=;
 b=fIxm5TlE+g9p7ZtCwAq/uW/67bnZiY/AFshUbAb18jQAvBaoM0Zc7DkTpGcvHdQILNskYlHyxJrHWIdp0FZwo7oXIOWPDDFaeCEjKYd0qJsm5ZU7D4k0wAJM2qHLI4GWfn8r4emj6iRSFGoVu7GNs6guI86x5GSpiz/9LlB+jV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 04:38:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 04:38:44 +0000
Message-ID: <882fc4fe-f95b-441c-8780-bd42e8cc7747@amd.com>
Date: Tue, 22 Oct 2024 10:08:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use SPX as default in partition config
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Asad.Kamal@amd.com
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Hao Zhou <hao.zhou@amd.com>
References: <20241014091911.3036389-1-lijo.lazar@amd.com>
 <a4287c13-6006-4739-a2f3-8c14cd085f05@amd.com>
 <d19b821d-4768-4338-98d1-40950956cbf4@amd.com>
 <aede46ee-7a80-4ae0-a179-2244153ece42@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <aede46ee-7a80-4ae0-a179-2244153ece42@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0051.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 01df00d2-e8ca-459a-57ec-08dcf25368f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a294SGVDbU51M0VucEVpNEtuazRrSGJlZVJpUjBQdGZaMU9Sd3JsSHRtZ3BE?=
 =?utf-8?B?REdhRDA4TXc1cGhBcWF0VHdZZ3lFM3lyZVpwRjUzQ0VMWjBtVkpVYmU0MlJh?=
 =?utf-8?B?cjdsMTJiNjVuY0hjekIyWDFwZXhRWmlVVFlLZGRRY0h0VVdqQWlvb3JJTGxZ?=
 =?utf-8?B?NHJZN2RVM1MxaElMWjU1ait3dkY1VTRxZWljbVJ2TFVyTG1ZYU1GVHNIQ1dJ?=
 =?utf-8?B?ejY1dndoR1ViOGQwR3VrVGhzRHdLMXBpeEthSWxJV1daYnhRZktueGhqUUlV?=
 =?utf-8?B?TGJ6N1ZyY0htRmR4ZmZtSFphS3cwci9JSTM3YUl6RXgwN0RvNTI2S2dic2xj?=
 =?utf-8?B?SDNRb0RwNUJPQ2FlTitPR1ZWekY3UFUzeTNRYjhqeHBoQUpXY0EwVGxiaDJZ?=
 =?utf-8?B?eUUvcWxGUk9JMmlIOFI3dVd0akVDbG95bUU4R2FpcUtmSjhoeU90YSs0QXpu?=
 =?utf-8?B?ckRLVFU1TndxS2cxbHdlOEFhWjdtNERMOHFXTktnNEJNSTB0Mm1ncTU4Lzd3?=
 =?utf-8?B?RVYzemdua3ZYOTRCWGY2bkVsUGhNWXI3TzVTSGRhWGhJRFhZQ3NyNVpReVor?=
 =?utf-8?B?dDY3MU9BcWlmMyt0bWJncnRUdjZZZTlZZkdYQW9zU1VGb0hnd3NCamp3cGxD?=
 =?utf-8?B?VjZReDVyVncyVGZpZlBjN3RDRWY2Sk1xMXAyZUdGYUNFeW8xMkN3SVEyUXhj?=
 =?utf-8?B?M0Z2MWhYNUtZV0luRjFJd25kOU9sa05oRktsQ0dsZ0x6WjFGVTR2MW9EOWZ5?=
 =?utf-8?B?TVYxVmI5QXAxN1hlSlRrYnkzdUw5MTNNMCtTMEQ2UEFJZExqSEMvRkpiUHNv?=
 =?utf-8?B?WHdNaVJQYTNZaE5nUDV2OFVLVERNZGZycytPMzRtYktmbGI5Wk9KY0ZHYUdu?=
 =?utf-8?B?bjFsR0U5OTJORW04YVI3WTNUWk1nZENrdWFYVFN1Uzc2TUZaL2wrRHdxNVdp?=
 =?utf-8?B?TTA5WVZGbFpWUk5zZjN6TnV6L1ZycFFPdVF6Y0lLZTROZUsyMVdMZFhBd0s1?=
 =?utf-8?B?bFNDWDB4bUlENFBoTkNOc3Zmc2N1V3RZMmRTRjIwQUw1VEhhNzd3THN2d2ZH?=
 =?utf-8?B?NUlkOUs2MFJJTllwamRiWm1XdTZpUk1HZFZDWldOaytEbzU1U1F2M2laUDJS?=
 =?utf-8?B?NkRKeFJrSCtCMmtvT2loQnVINjhpVGhpQ1RvZnBJalowdHdrbGg5K1dvZk1Q?=
 =?utf-8?B?Yld5OFg2d284SkM0Q3RlM2lOQjhkMWJkemNDVXFSWWVjK3RYdU9KMUtEVGVt?=
 =?utf-8?B?bTVKckl0UDdNMUQ4bjZrM3Ftd202N1pEaFpCM0R1OGdKZnNMK3NyOGRkRnB0?=
 =?utf-8?B?UGp1eVJsZEYvdC9BWnhNbzJrdktjWEhTRkxMdm4zMzVMY0ViWGUyR0hjZkFK?=
 =?utf-8?B?NDZjV3RockV5UWh5SWNwajJZY01veE1mbGhsRkUvREtOTUNmbDBBQklyUlFN?=
 =?utf-8?B?NVh3aFVFN2gxNkhyemxxT0M3OU90NDJLZ3IzcC9sMXJDV0lBMnE5YmFLdXFU?=
 =?utf-8?B?V1FRV3dXTXdvQUlXOTdoNjBQT1dkeTJBeVc3THVtQmRha0ZzQnR5SXc0UGhO?=
 =?utf-8?B?WEl3VHdUT1Zna21lM1Q2MUt1UGE4NU95cTAxNC8rYXVPSmFHSzVxL3gzdGo2?=
 =?utf-8?B?OXk5MllvVzYybU5qZktpOVozWlZkSWl4cXM4QXZDUTJMVWJqVjlXaTRwYnIv?=
 =?utf-8?B?bFA1OFdjTzhkSW4zeWd0QVhWL0wzTnkrS1N6RGw5YnNnWGNNRnlaREVHNEd6?=
 =?utf-8?Q?ZxfxJxcl/9YvRDJdvrK1tePNwhoEjqLMGacKnzp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVBM1NRZmRJZTEzajJESnpSc1hwWS96UE1BbnNPTmN4R05FNVVSZkY2R0Ry?=
 =?utf-8?B?N2NJYUtQOWRtNXNhVzNyVXBXYWszZmNDcjVTQVFxQU9MdGpHN1FLN1JDV1NU?=
 =?utf-8?B?Vk9xNzJuTVlqN3A2SzdnV1JUVmlEanpLd1EyeXhwd2xxdzlOR2NMMUJ6RjFp?=
 =?utf-8?B?cHMzRzM1RjFpQ3AwQlZmclRnMDdmTjBLbmVGd0RETHBPU1hTUFpuUWR4RVc2?=
 =?utf-8?B?ZkwzNUU3MXNsUElOY0pONWFIKzJ6SWV2eVhQdDBqc1RrR2NVMjFJcWdvTFFM?=
 =?utf-8?B?WXgxSHhTVXVqMDVRRktBL2lTM3pVY2VBUzBuS2JsdGdseFJNbXhEbTNETWVK?=
 =?utf-8?B?R1VpaWc1U0h4cWlIODhVdXFZNnl6VjdWZmFIanpkTmtUbVRZdTBPWHMvd1I2?=
 =?utf-8?B?cmhaYjR0TFZhL3VCeWR5K24rWTZHN0VGTFlZWkN1Nkd0aC9kK1B3TUNEQnZl?=
 =?utf-8?B?Z0xtcEVCczQxYi9yeUF6cjZmMWNmQ1V2ZTRaVjNnR1hxQU9XWHBrYS9xZlZB?=
 =?utf-8?B?c29GNWI4dldOWXA2VityTWo4OGlKZ2xpc1QzdUpOM0hmYkF3Y3FpeUgxU01o?=
 =?utf-8?B?dzZXWTJQQTd4c1ZTQi9yVjdkWGVFdElkUHhMU0xKSjJiR29ETk1wQ2lGSmtT?=
 =?utf-8?B?QjRZTS9PSFVUWTJUSGd0eDFSMHBBV0lWWFVkb0NWdUVLUDZ6N1NnSUxpOGZj?=
 =?utf-8?B?MnI5cld4aFZhcWdqNE1UTHcrSmVhM0pxTS93SWlLWnU1MUFSbk9GOWZ4c0NO?=
 =?utf-8?B?MjVNWkNteWk4NkZLR0JwZkNuei84WGFteHpFK0ZKRHFwdzJERzh1ZHpJTlBh?=
 =?utf-8?B?ejNOYVhYS0RRSlR0MTdqTmxDMmpsTmtNSTRncHZXVlUzTGxROGROajlId2Fx?=
 =?utf-8?B?TWNqYjdyV0tidENIRWFReGtvb1FjWndDZUF0dDBkS1F6aEtrYmNlZUlHcVBR?=
 =?utf-8?B?c3F0YXVtSFpJVzIxb2U5M091R1FvTWxEQk1wM1pmZVBZVkRTOGVJNERUYTJp?=
 =?utf-8?B?SnZiQUhRM2Zmclp6Q0dTVC9lRDdXWEk4UkhQUFJnMlZGVERGd0xkVXRDREtI?=
 =?utf-8?B?YW1JNlVYbkxlSkNpcldHU29VRFRybUJwWjVhb3h5LzV2QlBJeEpJUUVVbTFQ?=
 =?utf-8?B?bjRyRGM4OEhoZVR5Y09xNnhzTDJyNFlpczVzWW1US3FGQ09va0VZUDg2bXZD?=
 =?utf-8?B?NEYvODFMaTUrcDUwejdlZXRRRndPeXZQTU42bDdHSUN1T3B6MVB5eW5YZGZV?=
 =?utf-8?B?ZkppbytUZS9NR05rT3BoYm14a0FNZ0JUQjd0dHRoLytCdGJRbG53N3BtR1pt?=
 =?utf-8?B?RXVzQ285d2xERlRIQzczTDd4czByVTl5dU12dEpsdU9qWG13SmkzTVJnVVJp?=
 =?utf-8?B?MElneXhMaVBseUZ0OVhtcW8zYmVrdnV6dlVpczkwN1VvaDJtMUhuNlRQZFgv?=
 =?utf-8?B?cHpTSDZCaERGRms2MGszSE51WkgzeEhUVVZJUGR5bWkrT1UvMzlxSFlUUlho?=
 =?utf-8?B?VHMzSE9wMzFlYVpsdWFSaVJiMjdnZE9tSGdPaXlNcVdiM1ltSU81bDZvbHJD?=
 =?utf-8?B?OUQ2UG95QnkrbHNFYnJwakhmU2pUZkFlQWRScTN6QjV3aTRzdmFMa1UzVTZR?=
 =?utf-8?B?T3d1MVB3ZUhWbkJvU1Q5UFIwSGdoWEJNbDlPQ3pTeHpvbDFPWUt0VjNLaHM1?=
 =?utf-8?B?a1Z3U0kzeHdEMm5zN2pqeXVJVjdwREU0ZTNOVTdhTWJtMis3OHI1ckZxZXdx?=
 =?utf-8?B?b3BzZmFQU2hvK1B0YzZIQ3pkS3RpSXpvSTNYbGovNlkzNlhpTURUV053cW1j?=
 =?utf-8?B?dU82V09VT1NQRlVYU0s2L0NBU0NYWDY3ZUFhMmxDbWxMVGFrWWY5REREUGJT?=
 =?utf-8?B?Znk4MFMzM0E2Yi9NQnk1MzhBNHhad3dCMFA2OVk4SnZJZjRpWit3U1BzVzZZ?=
 =?utf-8?B?WHpERWZuREw1dDlnWVUxR054bUpHODJMZTd0cnNZT0tXRStXanZSMTcxaGhT?=
 =?utf-8?B?MFdDLytLMUgrRVpRbDFHRXhZTXhPR002eUdVN0JpbTdRSjd2SGJKNXJISHl2?=
 =?utf-8?B?Q2Fqd0VSTXQxSUI2Z0RHK1VIMys5Z0ZDSWMyREJFYTBSMmZGUnVvVnBMZ09J?=
 =?utf-8?Q?xjig/KmTYRp81jr72pceJ3paC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01df00d2-e8ca-459a-57ec-08dcf25368f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 04:38:44.0846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+sc+65Z/nlffihB3sijvhpTNd3UzTQR3xM5km+Pen6n+nZ+H29AB3eZQE9jA3GY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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



On 10/22/2024 12:55 AM, Felix Kuehling wrote:
> 
> 
> On 2024-10-21 10:07, Lazar, Lijo wrote:
>>
>>
>> On 10/19/2024 12:46 AM, Felix Kuehling wrote:
>>>
>>> On 2024-10-14 05:19, Lijo Lazar wrote:
>>>> In certain cases - ex: when a reset is required on initialization - XCP
>>>> manager won't have a valid partition mode. In such cases, use SPX as the
>>>> default selected mode for which partition configuration details are
>>>> populated.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> Reported-by: Hao Zhou <hao.zhou@amd.com>
>>>>
>>>> Fixes: c7de57033d9b ("drm/amdgpu: Add sysfs nodes to get xcp details")
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 10 +++++++---
>>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> index 111bf897e72e..83a16918ea76 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> @@ -606,7 +606,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct
>>>> amdgpu_device *adev)
>>>>   {
>>>>       struct amdgpu_xcp_res_details *xcp_res;
>>>>       struct amdgpu_xcp_cfg *xcp_cfg;
>>>> -    int i, r, j, rid;
>>>> +    int i, r, j, rid, mode;
>>>>         if (!adev->xcp_mgr)
>>>>           return;
>>>> @@ -625,11 +625,15 @@ void amdgpu_xcp_cfg_sysfs_init(struct
>>>> amdgpu_device *adev)
>>>>       if (r)
>>>>           goto err1;
>>>>   -    r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr,
>>>> xcp_cfg->xcp_mgr->mode, xcp_cfg);
>>>> +    mode = (xcp_cfg->xcp_mgr->mode ==
>>>> +        AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
>>>> +               AMDGPU_SPX_PARTITION_MODE :
>>>> +               xcp_cfg->xcp_mgr->mode;
>>>
>>> Shouldn't this depend on the memory partition mode as well? You must
>>> have at least as many compute partitions as memory partitions because
>>> each compute partition can only use a single memory partition.
>>
>> This is not dependent on the current/active compute partition mode. It
>> is to show the configuration (number of xccs, vcns, shared etc.)
>> supported for a partition mode. SPX is the default partition mode at
>> boot up. That is used as the default mode.
>>
>> It's not a strict one-to-one, a compute partition may use other memory
>> partitions also non-coherently.
> 
> I agree it's not 1:1. Multiple compute partitions can share a single memory partition. But there is no way for a compute partition to use multiple memory partitions, at least with compute APIs. Each partition exposes only one VRAM heap. Therefore I think the memory partition mode should influence the default compute partition mode. E.g. SPX can only work in NPS1 mode.
> 

There are cases like one node/partition can transfer data to/fro other
nodes' memory (similar to multi GPU cases). I am not sure if you
consider that as a 'usage'.

Anyway, in this case, memory partition is not considered. xcp_config is
an option which allows to select the partition mode for which the
configuration is shown (this is independent of the current memory
partition mode). This patch makes it such that the default selected one
on driver load is SPX which is the default system boot mode. The way to
achieve SPX may include a memory partition switch based on the current
memory partition mode, but that is not the consideration of this patch.

Thanks,
Lijo

> Regards,
>   Felix
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +    r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
>>>>       if (r)
>>>>           goto err1;
>>>>   -    xcp_cfg->mode = xcp_cfg->xcp_mgr->mode;
>>>> +    xcp_cfg->mode = mode;
>>>>       for (i = 0; i < xcp_cfg->num_res; i++) {
>>>>           xcp_res = &xcp_cfg->xcp_res[i];
>>>>           rid = xcp_res->id;
