Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E89C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 18:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7189F10F887;
	Wed,  1 May 2024 18:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V2syZ+/m";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE0510F65B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 18:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGirB/Hav186TsYsNzgiEV4O36ewyKdJEndCGSetZPaPGnvUzl2alOMVWQNZVm2/t4gpmr6XaRNMSD+Q+ylxRjl5bme9Xnf7qkp57tSS2gEYhAa9LNioS6ZSF6UzEDGhyoHZ/yMFPEYOmopsiioEJaUacvq188OsF8tyThhxTJaMPl17F3NzWl2l3gSQd1Cufmduox/mNeQWMINSgjJ71UWmxgSznfPgBthmudmb3Pay0/Mvbv12+jAgnNWc/eto7DWLsihLkoHngXX96msKFjudiBf9tl8oEAZnmE4/Dw6HHBO9J9f73MtDXMbe4u5mA8goKUZxIs/mKhu1qL6Piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqPx7KDINUpykCUqmx3URWIpRJ7Ue7pD1Kw+Q2ZBzH4=;
 b=VvV4teQRO7AESGHlpggX3i8Ftziu5aLldArA4x5Oje0kHXZLsnpyYMLnz4GjsOlu5H8z4re7eAjJZfwrJ44P2qLeLAtRquycc2XHMRe40boFsAbKiCSQ5iKAylOJsSb7zG3Go3289+uYKhfzCaShiuXAC68v5nBc7VQj4Rg0zgJpDwru+LsNTkWt1RaXcPOY+3tJiYZ87AOwavVMAjLN6lVoqqXsG0JSwDJNLEbVczLi7BJ68U6+gnFbi8cdSuNRj1uKRyw7TqWFvBv69KQpF1udK1kxnwX3PiqwLNwFRYm/k/Tn0KRkm9hl+zCsddyRxzEAxNSNlvlak6UrjDhZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqPx7KDINUpykCUqmx3URWIpRJ7Ue7pD1Kw+Q2ZBzH4=;
 b=V2syZ+/mP5RjPGGtKsIE0h8Sp8bQrgxWCfYhoCASSb6BYn19AdAJsG8NIvV5FiYrE0meRNlSKIz8ZzWyONAEXs2Qm2GwURmtF8i/JNNbE04BSYTMRC8xgcgm4PtfEkeTbWgbH3O/G0Dfy3W0MHGsYRXmHv7n3GYfylj+wLH8MPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 18:34:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 18:34:12 +0000
Message-ID: <5ec8572d-1eb3-4475-b953-2f70f5df9493@amd.com>
Date: Wed, 1 May 2024 14:34:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240430232901.2878169-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240430232901.2878169-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: f2845681-f8a1-4daa-d80b-08dc6a0d4bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUZ4bE1vOTJIbFg3N1dRMERmQnUxZEk3OUJQVDNLR0lCVnNyTzVZRitLR0F1?=
 =?utf-8?B?R00yRXB6clJGbkxhdmQ3S3FRU1VNZEkxWVVIWGhIVHpOZzhySG9DcnNDVGh6?=
 =?utf-8?B?YUZuMmlodlNoTUg1Q2tKY01oZCtpOTE1Y3laTWloTm5XSERndFVGNTZBcWN6?=
 =?utf-8?B?VHhJaStrSU1nTnNCaDN6Y2Via0Fya3MzVWpQOE8wUTBpREZLSmpQVVVsUmpF?=
 =?utf-8?B?aUJ5VnJUTzUyTStxcDVYK1FHdFdyTkMxa2dENlFZN3FrTW9YdG9QenRad2FP?=
 =?utf-8?B?WG1RWm9ESUpDQU1IVkNHMlFvcWtSUWlsMVFUR3hTaG8zUUloa2xIbjhiTzNs?=
 =?utf-8?B?TDJJOEtkV3ArNlBENGlqay92MC8vM1Jyd0FiQktGSGFIMDYvOWl0RWpRODNM?=
 =?utf-8?B?RVZBT0d6QTdBWTRKcVgwL3JHVHppMUxhV2FpYzFYTnpGVk9WREJzcGl6Vnoz?=
 =?utf-8?B?S2xneDNHb3Y1UjJ5VVNBQVE0aGR1UGxsRmZZTUNJWjR1TXc0bFI4bi9naXo3?=
 =?utf-8?B?eTF2c3kyWU10emlKUW55b1pUSUdrOS9QSk1yTyt0eERBOEhUbGE1QUdWNkxn?=
 =?utf-8?B?V2IvU1dXOEtXYWxhdU1DNU5IM3VJMXZkV3oxN2ZLVHZmeGVvbWcwSUtmM0tX?=
 =?utf-8?B?NkZjSVB4bTgrMkVxS2tnc01BbThJeHlmakp1R0MrTzY1MC9GU2hyVVdrSlRn?=
 =?utf-8?B?WXVJRW5OUEQ5N0pVNFFsRDFyUEk0akU1UU5nNVBrK2FHTXhmSXNWYW90aGhv?=
 =?utf-8?B?VFVzeWkrcStNR3hMZUFQb01JZm1IdVBhMEMwTmF4L0t5Y0RhbXhYOWQ4d3ds?=
 =?utf-8?B?dnQ5ZUVSWmVhWHdKaDY1MGlVQUlqV0FwRkhXRGFNY2FQV24zVENGb1Yvc0hv?=
 =?utf-8?B?a1VNSjBkQ1BkUHI2VFBJRWlkY3cwVURQZzFEMzJjQ1RIY1pITGFsNUMvdnBQ?=
 =?utf-8?B?RXRpejlKRVhSSjRGOWRndmp3Y0pmY0lLV21KSEU2VU1wNmRhQ0hydkRJbjZx?=
 =?utf-8?B?b3c1bXVxWDJ2Zk9SNGVCT3VUQjUyb29BQ2J1TGVkOFpiK29FY2lBSjVPSWha?=
 =?utf-8?B?cU5WV3YvQVZocjNUcVhQdUNFbTVvVURIVjFaKzQ4cGNTMmZtb0xxU3d0em1N?=
 =?utf-8?B?L25hazBPbW5yVjdEUDlRaVJEOXlxaHNJMS84a0EyemNsZHNzZlZobDA1VWVw?=
 =?utf-8?B?TEpubnNYRGFpaVBCZFcyZlpLRGg1UWlUREp0TzZlQmdiVnkzUnB5cEl1R2JH?=
 =?utf-8?B?Wms2U3JhTTFWYW1xVy8vUGRsU29mdnNCaVQ2R28xZXBJNStiTXhZUjBaeDhD?=
 =?utf-8?B?SUx6akF4SHU0Nk5tMmpPQ2pLc3ErSzNyS1Z4NUtRcG5rNkVqbW5lK0h5THRl?=
 =?utf-8?B?Q1pCcmdMeEVsT0UzRWZUUC9pSmRONFl2NjZPNjR6SFhEU1NjcXg3MmFGN3di?=
 =?utf-8?B?RWczdEdZWUt3T1NjWm43R2d0M05pdDBYVDlOd2FYTzNIYjc5cFRqSUpVeGV1?=
 =?utf-8?B?YWlPUktxS3hlRjhZUndUZVNxd25NT2pnbEVZVzRKWFJrdkwvWGhiNTk4d3cx?=
 =?utf-8?B?M1cxTklUdkc4aFhrbWlxVlNza0JQdU9hMGZsM3dqejN5Wis3dnc4akxIZ2xz?=
 =?utf-8?B?RFZTTlphWStXSnpiNG1tcjEyUmNEaUFQUXNRbzBCeE9DcFBraGpXMGtGYmU5?=
 =?utf-8?B?WlF2R0V1cDhQdDVMUG1obG9tUHUxOVJ3R0lER0t6bEhURHZzZWt0Tm53PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhuTU5MMlQreHYwSUhKcUhTV044Sk5jUUVWdlNud2RWaE13QkZSMDlwdHlv?=
 =?utf-8?B?ZFBGM1ZVdC9PWlErMU9uVmFQS2Q4VmVkVEtXUmFOOTYvMGJpb2pDUVJ2V0x0?=
 =?utf-8?B?cUN1TDhOWHJXYzlHUnhqNEgvWWx3L2ZnT2tGeXdKenpoVmxhNjB4N0pDdUNz?=
 =?utf-8?B?M3MyMm1GTVFIc0VVVVowYTRFZ2pxZit5bnJ2dDFKaUFLdC91UDJlY0sxWjJ3?=
 =?utf-8?B?VXhyc3NvTUVGMnZ5Tlk0UnU5YlZrekI1MmdhQjFFZENReFA5aWtnU1kzdDBE?=
 =?utf-8?B?aFZrUGM0U0FrcFhsbHNJbEVuNFN6QmsyRXAxVXhlYWlEZUlVVXBFYVFab0tI?=
 =?utf-8?B?QVJKVi9oTjMyMUhpN200dFZjc0RzQzF3eXhma0RBVmlwUGpJVzQyc3BVL2xp?=
 =?utf-8?B?MDRYWnNhRXVMTTdvRjdldDk1TkUxUHlkYkdjZzljRVpWbjc3QjdHeDZ2ZDlh?=
 =?utf-8?B?S1RUbDU4TnVWVmtocDZ4ZFd0TlFaekg5djFFVzliTVhwQlNaaDRmUnE5Ylln?=
 =?utf-8?B?eHBQTnp0SHBvQ0x5dkdJVUFrUkUyRVNkdGIwWHNmRWlCNzVGTzVhRyt0NWxp?=
 =?utf-8?B?Z1Q3bWZkeG1ONVp5RG02NlU1S0VhVnVPVjZmY0dqL05qZFRQeXJnUE5zVXMy?=
 =?utf-8?B?alhGRDJlaG5iOE96MWgzNy9zZzdQbUEwOFpjWU5ibExHMDc1TzI3WWF1WWNa?=
 =?utf-8?B?bFFUNXR2RFU1aWozRHd1VVc5Nm9DYzNpanpPSW5VS255N1VvbFpBRWhYRmsv?=
 =?utf-8?B?cjlpNUVQU1BsS3Z4YXN1WnM1eDJOVTdkNmo5TVExTkkxMmdYMGViZFhZQkhj?=
 =?utf-8?B?eVpSUWVZTmcwM1N2S0RDTzdtbzg0SFp5RXljQlZpK3JsampSUFVLbmxBdjFo?=
 =?utf-8?B?QVVnblhQeUNjTk9NNlZYOVBMdERkekVKbjJHdGw4SUIvRzRoYXpCTnRXdm05?=
 =?utf-8?B?V3V0RkxZTlN5TmtRS3BacXZIb1N1ZjRrOS9QQ29tdWlrWllPQXpXb2prYWdI?=
 =?utf-8?B?ZE9FOVdhOXRvanpNU01jS1RlRzRRTVZqdUNvYUpxUVB5WUI3SElaVGxpUldI?=
 =?utf-8?B?emNycllacjhSZlZlb1dkaWJ5cXAwWS9iUGFYenpDeU95SDZoSWRXVVhtU0Nt?=
 =?utf-8?B?QVp3M05GZmo5SE91N20zcVcvU2lnQ0FFTzFyWFFOUVVYQ3pFWk5kTFpsZEtw?=
 =?utf-8?B?Q3JOb2E4YmYyb2JQcGxRNDk3K01idUFHQXdGYVNPZEtEb2Ztd3dFekxVa3hi?=
 =?utf-8?B?UFphcG9wYnIrYTZDai9USE9SejIxVGtySXlzY2ZGVyt5U01GMWJya3JXYTQw?=
 =?utf-8?B?bkUwbXpNS0FUZ2owVkZrcGFuSjlWZmE5TUc3Y0hITlh5NUVZZFZzZUUzaEhW?=
 =?utf-8?B?d2JmZVVjZEoyK05SWnVIUXFjc3MwU0VVK2xPZnovRmIvbWw2dnFGSS9hVEhx?=
 =?utf-8?B?M29FQlUxU3ZXTGgydEFqdlVYbzhSTW52ci91UnV5Z1Z1Q2RmWDczd0pMV29Z?=
 =?utf-8?B?TUFsclNDcStzZXhINkcyNjF5MHZnM2t3dWdkOHA3ci83MklhM1FlVDBSRVE0?=
 =?utf-8?B?aUNxcHFyblVpbTNWMTBJSXRORlhsSUZzTGZZdGxkdHBVVGtuNis5eEJQYk5o?=
 =?utf-8?B?YWw2UDFvVWIycDVLSzdPTEJadnUycGpzN0dadGlWMnRwSVdOc0REOWRsNURQ?=
 =?utf-8?B?TFBjRXBKSlZIQVVmTnJNTmh3YThOWWd6RlFpM09tbnM0WEZ6eEFrS0hIcFM1?=
 =?utf-8?B?OXVNRVFHRkhBc3VCelBJUk9lQVhOU011R1NFZlBIMEdMd0k1RnFpZTRoYmQv?=
 =?utf-8?B?LzRNVEZ5TFlkV2tOTWg1WjhIUUVOUEc0NjQ1NUFxb29Nb1pKYStrcmN1MW1W?=
 =?utf-8?B?S3Z2bHAxMHl3SXBrdk12S0hhQ042MmZ4YitPb0laQmhCVzU0NnFWdTNoKzhP?=
 =?utf-8?B?ejZPb2tia1ZZbjFBNk9mQUVGcE0wN2VyVU5hd2hxd2k0VEkxUjNpUG1ta0hN?=
 =?utf-8?B?NXJIdmsrYzkzckM1bHVySGdBb0J0RVc5aXNHakUrSjhFSXRhZDBoVW1sV1JI?=
 =?utf-8?B?UE9uK2ZWUGd1QWtFSE1nTTFYbXVIeFVDUStSb25GUUdVZmdLY25uVVlJWnNn?=
 =?utf-8?Q?WpYd+hE+3DD1/t19wBXWL276L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2845681-f8a1-4daa-d80b-08dc6a0d4bd1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 18:34:12.0049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIUfFjW/KtjZYhmaAG9LSqnYnWos/uIK325UKE1tZwgrTDPe1f9NLnVtjsGqJiR++FZdgvLK/ddoaRdpb1QJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
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



On 2024-04-30 19:29, Ramesh Errabolu wrote:
> Analysis of code by Coverity, a static code analyser, has identified
> a resource leak in the symbol hmm_range. This leak occurs when one of
> the prior steps before it is released encounters an error.
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 386875e6eb96..dcb1d5d3f860 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	start = map_start << PAGE_SHIFT;
>   	end = (map_last + 1) << PAGE_SHIFT;
>   	for (addr = start; !r && addr < end; ) {
> -		struct hmm_range *hmm_range;
> +		struct hmm_range *hmm_range = NULL;
>   		unsigned long map_start_vma;
>   		unsigned long map_last_vma;
>   		struct vm_area_struct *vma;
> @@ -1696,7 +1696,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		svm_range_lock(prange);
> -		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
> +
> +		// Free backing memory of hmm_range if it was initialized
> +		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range)) {
>   			pr_debug("hmm update the range, need validate again\n");
>   			r = -EAGAIN;

Nack! This can now override other error codes that aren't meant to be 
overridden with -EAGAIN.

I think a better solution would be to just revserse this condition to 
ensure that amdgpu_hmm_range_get_pages_done is always called:

		if (amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
			...
			r = -EAGAIN;
		}

Regards,
   Felix

>   		}
