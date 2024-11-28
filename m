Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9C9D6D25F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 03:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BCEC10E463;
	Thu, 28 Nov 2024 03:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8vJlKUS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F72110E463
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 03:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLELHG8mVsUIx2Sjd0BxOXkED7TebaZ4dD+Tpkk++6L9v6pTleKpyVPftdyOhjsEu5zF/tEOEAg0h75dvbzXGGXF/CdJPAptKJbKpR/X2CDeLfU9Cp8vMslmwF6TO014ZpZZfeMawk31mVY3LTKGNVVnJoeCgOPv14f+5QOoIekkKoDZDgOKbd5oq+7yoBv9C3tU1YfFij/ViRFEA/ygTsXK5TeodKxTz0fvFoh21fZnAr7q2aERwzRqHjzuGY8964zXHQRB2RHyak0IpieM+Bm6rJI84uhUsIWpjkO0qYhaByA0h0xLvLpfujQHTLh85joNrMpApogVeOs83240AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMchQHxKzhTlyA0/LfUXjpxOT83BN0cofHYrb4/X/ec=;
 b=swO8pxiTAOroz88PLfozP/8f1AtR6TvPLwDTEMjtkrQL7yWwwcJvP7vcX52TF/81hnzi0a7fYj4ls5dXQOPUJXMVOYspEOiz3bp7Vxwlqfr50Z27GmVtPzRJlSxVDwAlXx9UbLbkIhPkBw9+bLKrYC7/abJcP9qkGlgrqGOM5vFP9/RNRZX4h4UwF4N7Pe7gybD27tuszaNivMOHhlP/ihiZopvN5gu/r8zysavhK04E2eGyhSARlbc72UMzAQTArg/h5EgBUWHKRZPFU/gcWes+xnkzIJSULfO7k31KQKjRQCPm+JPM4XuatdbenEdeX9j2I67lzgjHehu5XLOURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMchQHxKzhTlyA0/LfUXjpxOT83BN0cofHYrb4/X/ec=;
 b=V8vJlKUSaV3f2NTjWlRcE+7mpEAGheQJgces9MGibmu08CMbo/KsB0P6CquJQ5ylwK+kVn1r5/7Ltpoht7ulUP4EDNnUL5vxPC2QJ8DhOLKQPeeM8ugqbaUyFNuEABE4MDgLPEKc1mAmIw0lbcyH/VmAbL1ON7eB+XpCbefiTWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Thu, 28 Nov 2024 03:45:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 03:45:38 +0000
Message-ID: <a8cb1cfb-bdc9-4e56-8a11-bbe8f311fe6f@amd.com>
Date: Thu, 28 Nov 2024 09:15:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Use the correct wptr size
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, mukul.joshi@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20241118053434.3382003-1-lijo.lazar@amd.com>
 <7fb86a69-aa43-41fc-90e9-4750c84a3a89@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <7fb86a69-aa43-41fc-90e9-4750c84a3a89@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 82abccd7-6eea-46da-e764-08dd0f5f1f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1lrNTNWa2NiQmROT3ZZRk9LcFZhQUFCRkdRUEN2d1hhWWZmd2pkS1VtTlcz?=
 =?utf-8?B?WjBlSVkvNXVzVTIrUElRTHZHSjRwS0JGajJoQkY3YjdkYjRmbnFDVGlwYzlC?=
 =?utf-8?B?Nmd5VXlCZ3RCMXdFbCtsakJNRzA3dHQxWktrZ0NEUlBZZ05DM0dYR2xmVFRr?=
 =?utf-8?B?L3FSUFhxUTVrL0xxblpPdVhXeStKRThySTBKNjRJWkYzVEtPMXpBVmJkMFdk?=
 =?utf-8?B?Rk9mMklEU0lCYzVNT3VGeVRFMk1IV2dSemlmMjA0SElKWjZtU2ZDWDJobFh2?=
 =?utf-8?B?L2o0U0orU0N3Ui9WbmViMGNpWllHOGdPajIyUCtzSXk5MVdmalBPcTY4SUZp?=
 =?utf-8?B?VldrUnpyejRFMWxTQjJoWFVLM1dCNUt1bUpaSU92RUtRakZKUXkxKzRlWVNw?=
 =?utf-8?B?emRpb3d4d3U0aHdGMkN2TnJ2MGZnMGVqNFF6VTVLTHVCWFdoQWZHbzRWTlRu?=
 =?utf-8?B?bUs1eW5LTWhMbWFGcGJBNkhwUTZCcFVaNFB5SGFORU8zRU0xRHRFMWMrSHp3?=
 =?utf-8?B?SzlUTjlHNFAwOEFyMWxpbmE0cm1UVGU5NHFKc1Y2VHEvcXJnVDN6WGNUT2xm?=
 =?utf-8?B?V0lheW9qYXZVaEJZQ0pJd3NxNnEzRHUzMnNlREp6RDUxamcvNG5HZXhkMG9U?=
 =?utf-8?B?K0JoT000N0pjblZ5eER6eWROOEJXMWQyV0pEYXU3TzBwTzRkalZwM21xVjgz?=
 =?utf-8?B?V1Z1dm51YnFwWjZ0YTVQMFlJMlJJRW10TVp5Y0Q3ZndyOUZaaVlIZm8xU1lj?=
 =?utf-8?B?NGhMeFhTYlYyM3pweHdoZ2hMd3VnM1crRFhLTU03SXpVYU5SNDJpcnVQbm1D?=
 =?utf-8?B?ckEzUjNUeU82RWQyNXY2aU5qTWlXaWU4RGQ5empVeExKaCtiK2dZTDl3SHZw?=
 =?utf-8?B?NFVPQzRhVUQrWjhFSEhpZHFKQWRIL0w5QXFPSEN2UDdoMHdmaFJpYjFwSlkr?=
 =?utf-8?B?Y09JVzZwc1RkWWxReEZhbXZSWVpTTkg3ZUljQUx4ODdHUnBRbWRQNHNGZjlR?=
 =?utf-8?B?Mm1uWHp0THNVMFpXWS92Z2szWmdiVTNYUGNOeVJjZFZ4MjFDRzZGTEp1MzZI?=
 =?utf-8?B?Mk9UbkpvRG9OQVdMeFR4c2tOYlJTdUNmcHNRV0NxTk9IS1gza3E4bWhTR0c2?=
 =?utf-8?B?dm9EaVVXN25PMi9ZbC9kTC9vQStoVGZZTVEzdHRlemdoM3YvSHlzeTJ0bUw1?=
 =?utf-8?B?c2theCszT1RzVnVERWxCdnhZOURFZnAxWUtyS0JRU3JOWnhWRWk1WktucFpw?=
 =?utf-8?B?UWUyNHhWWko2U1lyQ2pvbDZMVzBHdW42U3cwWGoxcTIvaXFOM2F0YUhMV2l2?=
 =?utf-8?B?L3VuNGZFN04wUlZUY2d6UTU5blZDZEl1eWJNT2ZqdXNiZ2VGaElHVlFQdnJs?=
 =?utf-8?B?Slo1MkxTTUtrOXVTYnM1VkVnSXErVVZTNkppYlJqUVorL20wbUFpMUsyOERw?=
 =?utf-8?B?T3JtYlB6dVJ2bGp4dytsY0JSWlhhQWtJY0VBaDNuTmNmdnQ5eHpMUlVRRmMx?=
 =?utf-8?B?cE5wQjRsck9HVVlVQlpOQWhSNit0ejN5eHkxaE13RVF3VUhGeEROU2doNDFP?=
 =?utf-8?B?SXNQUWZoRE5qWENDZzJxM2dGMUtKbWg3cGtmMG1zaUVFTzZScFEzSWMveTNq?=
 =?utf-8?B?Z3BBR3BEaDJ2MFpmZ3ZsbnNIcHJZN2JtTk5Cck8xYmYvaU40NlZKS1Q1VG55?=
 =?utf-8?B?VXlBNFZ1K25pdjJBWkVEVTBLL05LM1Fzc29YbG5VM2cyMWdxaStReDBNUktV?=
 =?utf-8?B?aDN1VFZYUmRsOGs5UGpwQkU2d3RGZk1GdG44ZnNneVJPbE9OOWRLTEdUVjNC?=
 =?utf-8?B?Wk12ZWJnZWxvQ3VLMXB1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk1MSUU2c3FBU2lrSmlVSXc3MWdsL3g5N3cyRzdpcTJ4a1VqcDJtc0NhcGpy?=
 =?utf-8?B?U0JmMU4vNENUUCtrSTVCMmZHRFFRM3JmazVneU80d1U4ZDZiekVsb1hYVXFu?=
 =?utf-8?B?Yzc5bU9zQlZTWlc3R3U2N2lMNGNDcGMyOHRINUZpN3BRUWp0U3VueU1Zd25r?=
 =?utf-8?B?Y3JFTTRiWWwxaENKemZVUVBYL0M4bUdCM0VZZElIenJ2b1hybjdWOXdVRzVO?=
 =?utf-8?B?TmMzbkJoYlZzeUt1R1ZiOHR6Y3lPMEsyZ25MYjgxZThtRmRyeGszRmJIZ2Fv?=
 =?utf-8?B?bmFsQk9yWDZ1enFWemR3eU9rSU9zQU00amE5UkxJY2RKZGthdnZVY1lLUXhE?=
 =?utf-8?B?QlBpd1JMMFFKaTllb2xkWGw2RzBQWG9GZEpiRXZVZFphbTM5RWtWTzFPOG9i?=
 =?utf-8?B?MzZsYkFFRWdXR0FPOUxveHFsVThYOFlyRE9EdzNjVU1nRlQxRUhkc3ZaWjRh?=
 =?utf-8?B?NU5CckFzeUNTUnR6WUlhcWdvWVRnZG1talQvYlN2UXFCbHV0aGRlMFNGaC9Z?=
 =?utf-8?B?bnd1ZVZ6SnNJbUt2MHJNNk5uUlN2czlTSTR6VUdZTEQ3N3VJWU43eDBQR1Ez?=
 =?utf-8?B?Y2pSQW1XSmJZUTUxaWxEUlFRTy9uUUNHRUpKV2NSNTE1YkthWnY1WE9QOUtC?=
 =?utf-8?B?NzVreFUvQVNZRmZWNWdSdHdvTUEyc2psNjhaSS94enVyWUs3TUc5ZWNzRTR0?=
 =?utf-8?B?c0xwSy9WMnl6bXRwTlhOZGh5cU1iM1MyK3FyME1CNVBpU0xDNk52YzFBR2FT?=
 =?utf-8?B?akcxUmRhRXpOVUIya1dPRkZEVml1SE1VRUZNYjBaQ0c1aWlhTU9BeVZiS0Fx?=
 =?utf-8?B?YmlPek1oSUphSlQyQ1ZMYVllc3hNT2N1d0szZVpzNmZLMkg1Mi83L0tMbVlq?=
 =?utf-8?B?V3c3aVlkOFp5YVcwZ2dLV0I0MUhZQXVsdjdoOWdTR0tkWm9ZYkhGNU5rVzIx?=
 =?utf-8?B?N095Um5kaGNqWXk2U05NOEc4NnBVcGNDakEzeFY0TEN6MGtDWDZZNjdnVWpj?=
 =?utf-8?B?U3JFMlJUeWpBKzZiRXdSUG1QU1diTWVnS2xQZFFnSHF1WUhmRldZYkxwQlZV?=
 =?utf-8?B?QkNIM25SaVBBNU04dmpIRjVpdXdnT0tITHM2cTMxUGt4V29VQ2RhVnZoU1hr?=
 =?utf-8?B?dGQ3aGhxOVpzRGRhOCtyT20vY2VlMi8zTGlOc2pZTUZjMittZTlFbEZad3Ez?=
 =?utf-8?B?dmt6TmV5MGMrcTFNQitJNEFqVXZhWmdWTm95cmVpcGYxbE9sUUZuTFBkTWVN?=
 =?utf-8?B?REk1WmY2K1dlbEwzTVFhY3V3OVA3OGxSOGx4Q0FGaGovQytZUWZrbWJaYmVa?=
 =?utf-8?B?dllFQWxZK1ExYk9iQkMzeFYwTVNVa2JoSjJpeXlIMzNDQ3BRanMxTUNPVUcz?=
 =?utf-8?B?dXJWanpRUnZjVkxqcDExK0pKMjk5Q3Bzam9lOHQyS0lhcytlb2ZnOVRUTmty?=
 =?utf-8?B?SnEzVU43Q2ZqRG1YcGdEWTlhYkNkS2xmd2JyS1o1L2ZJa0pXMWRPTXJRT1I3?=
 =?utf-8?B?dTVGeVp2ZjZBV3BqME0yYXFuY0dpUmVXUklzaEc1TS9mc0tBcUFZaVJ5QW9u?=
 =?utf-8?B?R0FwTklRdGlwMzNRSkI5Wk5MU0tNa29Ja3Z5UndpODVueWRqZHI0TU1MTVFk?=
 =?utf-8?B?S2tqK0kxUy92Z29uVE5HRU1xY3YyT2lOT1RtMllHWGdVODAyNTlQRE15c3J4?=
 =?utf-8?B?eWFQZEl3dERMRTZLMFVNUEluS29JUFlpSFlOZGwwYWFwNUJBZWp2OUZYdXZ6?=
 =?utf-8?B?cVNpTU9DMyt5MldRK1Q2enl2cEEyR3NCR3RrSitiQTNTSnFwMGUzTm1IeVN4?=
 =?utf-8?B?VS9sTk9yTWR1WGhLNGMxRk5iR0xqZGZUbVFQM2VtWVhPMWFsSGYybnhVWVBk?=
 =?utf-8?B?cEdKSFRFb0tJMTdvak5ZNDhaWTBuOWM5TmNpenJjeXZ2QS9Fd0Jodi9ZM1M3?=
 =?utf-8?B?Y2NFR0llWFFlL0J3QWQ5VW00aUxXMS9JckR0a3IyaGlKWXlPZE1HZUJJNmRN?=
 =?utf-8?B?TTh0L21iUXg3TlVra3FGcTNRdGw1S3RPcms5d3RoSDhmVVFDQVIyN3FoK2Yv?=
 =?utf-8?B?Q2lGNFg2cTFZZW1aRjlwTm1pWXJ2MTRNWnpBUDl3ZHV3anJoM0FIR0l2RHIw?=
 =?utf-8?Q?KYPMX1LBmq5kcGKoiH1XQbylO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82abccd7-6eea-46da-e764-08dd0f5f1f9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 03:45:38.6640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv3MIgp/N+CLck8qpeChGWgl8oIWaLL3oxbgKxDjg/dwgGirtMp0VFu9q7CwBw6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
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



On 11/28/2024 5:43 AM, Felix Kuehling wrote:
> 
> On 2024-11-18 00:34, Lijo Lazar wrote:
>> Write pointer could be 32-bit or 64-bit. Use the correct size during
>> initialization.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/
>> gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> index 4843dcb9a5f7..d6037577c532 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> @@ -125,7 +125,7 @@ static bool kq_initialize(struct kernel_queue *kq,
>> struct kfd_node *dev,
>>         memset(kq->pq_kernel_addr, 0, queue_size);
>>       memset(kq->rptr_kernel, 0, sizeof(*kq->rptr_kernel));
>> -    memset(kq->wptr_kernel, 0, sizeof(*kq->wptr_kernel));
>> +    memset(kq->wptr_kernel, 0, dev->kfd->device_info.doorbell_size);
> 
> It would be safer and cleaner to just initialize kq->wptr64_kernel,
> which is always 64 bit and aliases kq->wptr_kernel.
> 

It's done this way because of aliasing. The size requested is
doorbell_size which could be 4 or 8 bytes.

By safer, do you mean to have an if..else check in case the aliasing is
taken out?

Thanks,
Lijo

> Regards,
>   Felix
> 
> 
> 
>>         prop.queue_size = queue_size;
>>       prop.is_interop = false;

