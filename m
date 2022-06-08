Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE19C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 19:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE76E113486;
	Wed,  8 Jun 2022 19:39:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21614113486
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 19:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4ev7/2pQ3NQSbg2z5LRSyUb7lhKBWf8DN95QSuH8p0191t69AwtnpFtaSL8Y8XWXD9HArhLofSMd+KpWyK9NsNhN7/mt/aP4XMoJXgBTkrjbv9Y560FnQtyOPBTmdPhJgZEAnyoQMjKoyBtyFz6WPauiaasU3Zhxe0fIJTOX17nKTi53DV048ZJ5N86VNz1xFTSwn97A+2Bp+oOA14dMNRuprKLMHSZJBXPse9iO6nclzFICYMgWmdQOgZSjVEnVU7ZsDd2jCZDqtlWaDoflbAvKl3/6fQB9HB/Fwtny9lnjkWB5Kwcppwum7er6MLprXxrocWOB+pWKuGqjGAhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0AfNKiOz/T7V1sc/1yqrjM+YfJ13k1bhu9lX/rHF3k=;
 b=CLlGDjQMIbxCi9v3Z50Cm6OkfG3g4aH8UEBbMDPaZpABuijjt1zdIvTyUuZ/1KQAt0uD+Q9W55hnFW0k5KDQPNiy/hDck9SBGqn7MMEClID3xMC7XtpMUpJOQabId7pQp8Bh0mAlhgO+MxUbkWXp11quojZz+pw+xILKLtZZpfnWJMa6Ve0VW/yLSF5hJGyGpzbCX5Cd7iW9eZnXv9TrGiUfGRwDrPpduBQbTVsQkchY10FBxKtg3j7TQblECd6ZG4J9mEU/f9a52HhlOPzBfVvA2dR5fuMs5J/SuF6uzK917IwfN6ubVI/p2lFGV0oVbokqBbpjAftlnFUPD3OWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0AfNKiOz/T7V1sc/1yqrjM+YfJ13k1bhu9lX/rHF3k=;
 b=fM3V1x1kZHSgxv+fX/l5+BnLGrEt3S4g8r+9OraxRng0clhItPP5btthzDhxKkpqub49ex97lCIwhVx1dKQ1kFV8Axu0+FIc+dtg/TMYyekXPuipXE/3/m3SS7jjLijOvHPm4aSSZaITG6o+0tnNnuQ0EEZ9DYrWh7jc8LOmn5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 19:39:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 19:39:37 +0000
Message-ID: <954e9aa2-835b-397a-299c-c98bb60b764f@amd.com>
Date: Wed, 8 Jun 2022 15:39:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map
 count goes to zero
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20220608115110.1798650-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220608115110.1798650-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:208:23b::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7fd0a4b-a19f-414c-7d15-08da49869f60
X-MS-TrafficTypeDiagnostic: DM6PR12MB2828:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28280CB752B08DD4B72E589792A49@DM6PR12MB2828.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40Zmv/EQGe3uBC3qDHo5QPzf1alTY2yVJOixbe+SceQQglNAqG6QyTMeGdFjva+QPfxp2s9qsudIcKY7tI7H8nycK/dK7l8F6bP83rYdKBYMUwf7NLNKHhh9UeOhPuKcsPXKfsc09IumbDL0IMihfjag+RCxWK0CGp8TcFmQsxIc5fUfnmGKmPIz8Y9yumJnlAOk+g5Sy0t/NAYojd59K4xbnUZqN8bWnxzp6JJhcV9h2+sXgOLYD24tPgYM87sEiSeQ8rYJSiIdnk5NPH8aV29FJ/1zst8K2KMhVpHIf2wfH4Hwvb7Eyy/8uxIkO/WlMs2bYO99ocg8BZxl08lsLj6CnQgSDy4yfQ0RsG5QKGshSuFDKDVY5jal/cJ7wLY3KGQ5foya5WR6pqSucPv83HqpTcTV9i+LMeyWCPZRO0r7ftMSJm4rdwLHRWOKMbUydNAFuNz66zZCj0DwuNZ4jdg1oLJ9abf9KCvuKKYU7dBQoZrCIkMs0bOoE/KQdCUwz5Fr+3AfQghY5NEehv8neupUwQQSD0cH2Ni+UzbhJw8Tyzpb7rqrbJd+vHPbToA7ECaJmQaWGr1IJCnXF9PVdt4JKgjHnR4ZQLi9ZOY69cj8zG8d3a+F3IP25DkXpOq7dVrkhjpRyPQ6MXQsdvmeW4/uYZ2sCuUQptSc8FTPqLfTTFw5QTbDxqvB0NSdL6C8gz7T5RJmqa99HvDmUDTyqOvN9DRQMGqXMW9sgBonz28wTPfBiUgakGX+isYyA5go
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(53546011)(66946007)(6512007)(36756003)(31686004)(6862004)(31696002)(8676002)(86362001)(8936002)(6506007)(66476007)(44832011)(316002)(83380400001)(6486002)(38100700002)(2906002)(5660300002)(36916002)(37006003)(2616005)(6636002)(508600001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpTYzI2UDJ6cGpoRHZRZjkvcm5Ld1Q0SmRzdE9aZkhTUElmSElvZTFrWFZG?=
 =?utf-8?B?UWVVcFFpNWNLUXV2UEZqZFRPUnhQUjNpaXA4dWs0TXJ4TFlxLzl2MkxPdVFY?=
 =?utf-8?B?bmNtU3Q0QTlZdUtacC9RcVRjQVdFMWQvb0VoanFpSXI2cVZ5aWVrQnpLbnkz?=
 =?utf-8?B?UHhHak40R2U1OC80V01DeWc4cGNiekVZT05aL2gzRDJXTzdsSjhOSVVVL1Aw?=
 =?utf-8?B?M3lXVjhLQkt0dTBDSGZIWkRKOWFLY1dJLzU2Wm9FOEl4WGFxQTMva2JWMXZM?=
 =?utf-8?B?eC9YeU9ySVllNVFBclRaVmxxc3FlOURTOFNmT3dlcmFOZ0FuRnhNS0NDM1I0?=
 =?utf-8?B?Z1NOZGc3Skp2TjAybit0b3FHbHNMTk5sL0daOVN0K29KR250Z3AyZmZpZ3ln?=
 =?utf-8?B?OEhic3RBOFprSDVqQnF1M1JUbXRPOVM4UDZ0aUIwT2dEbFVLcDF1MDhISkNN?=
 =?utf-8?B?RytibXdYaUJrVmpUdlY3ZVphQWdnTlZKRUJlSnRNZjdYSWRTWHJpb2FoM2lm?=
 =?utf-8?B?c1JESDhGMTBGZE5obXFaeWpvWmVlb3htRVJOUm1kL3dycHZ0ZGNPN1lENjlT?=
 =?utf-8?B?aHd2NStKRHF4Ni9GWFJwQnpmZWNTTnVZZGw5cW5DS1JiUjJXVFBBRVVSRW9Y?=
 =?utf-8?B?Z0RQRENCZkdUZ1BzK2VTamxUVGwzekJ0MWlrcU1yd1RhWVRzZnloSFpwN0M4?=
 =?utf-8?B?QUJDLzRBa2JwejlIMkRsRCt4NkZuNjBSSVd6S2w5RExuTWFlaCtHZzhZYlp5?=
 =?utf-8?B?UzJFZ1dEcmU4dmkyL1F3emZvUXJxYkdrdlFxVFFKTTRTcUV3VWUrdlpPcVRL?=
 =?utf-8?B?aWRzZnRHblBnbC9ieW40QXltNVZvOEtoZ2NWSGw5bDVxNHhrbU9BcTNDMmdV?=
 =?utf-8?B?UjJFeU9rT3RuYzA5WlpSeFhWVFJlSE5wN3l3T0VmdU0zeTNYR05iQ1pnU2Rn?=
 =?utf-8?B?Q1VLaG9oOG0xSDZBTkhLNmRXcXg3TWtseU9ZM2dWR3pTUGhkOEpNaDBxOTNM?=
 =?utf-8?B?V2VNaEE1ZEhPeTZ2bDVUU0NZVnJtaTBGc3JPdkJFZVlUcHA1T2MreEc0RHdR?=
 =?utf-8?B?OWJmTFh4NlFOUWNGclJCN0Jwb3A2ZjJEcWp1TUdIa1l6R3Y1WTl3ZkUwT1F6?=
 =?utf-8?B?YzkyNXArZ29CZE5ocVU1QnlVUmJSeFc2eGtuUXdaTGxjTUsydHkyOEVBMEFH?=
 =?utf-8?B?N3RhL3BhbmR2NE8wMTd5OTNDT0NjSm05QkY5VjhLUTgxYmV0U0hkb3RwSTdt?=
 =?utf-8?B?RXFSUGpNNm9OZ2JkY1h1RFkrVkh2QmpSRkcrNHlncVkzT1FqM0hzanhlZkI1?=
 =?utf-8?B?Yk1tQ1BDL0IvUmhqbEhKZWV6VFl5U05aRVJFR2pRN2pRMFN2SFFuQ1E0ZUNJ?=
 =?utf-8?B?U0hGd3FpdkpkSmtvWEpyZzMxTk5NWkE2SDc3ZVZRQUcvY3JCS3JlNUs2dGll?=
 =?utf-8?B?cEFMTWJGYlk5SnpyRU1qeVp6NlRVaDFiN3VxWWpSb0ZVQ05MbW04TEh4V2M4?=
 =?utf-8?B?U2hQV2pKaE9HdlIwcVlSalJ4WnZJMUNjTzlwYXNuZXBFVTJxaVNMdnFhTk5O?=
 =?utf-8?B?ZExnclpMQ3pQVTVGSVVhQ0tlUWloZ1M2ZDJ0QWI3SHdaRFF0MndhclZReDJB?=
 =?utf-8?B?Smt6RG54dHJIQWJkWVc4U21kNTlZTWVUSTRBL2pPVU9vZ0FWa25iMEJmbEdk?=
 =?utf-8?B?S1ZWT2U0aVhTaTdLQkRVNi94ajN1L2V1cTdMRFF2V2phNUU0cXFJSzAvTDdJ?=
 =?utf-8?B?SE9YR2pJU0hxWDl4ZmgxdTQ3SHJaTVBlcC9HR3VoZGhJcGtuU1h5VDVPaWpU?=
 =?utf-8?B?Qm9Qd09vbEJiKzdEWFRuZ2hHL3FCbTFKYkJLNUlKeXM3K2ZMemNYWEVKZUFT?=
 =?utf-8?B?M3lJZ2x6U3JsNDV5QXd1T3FzRlhtQnJJSzBwdjdRQmNQTWttejFGcmgxL0pE?=
 =?utf-8?B?NURmQWhmVjNqNDlCQVBKaWtLdUJ0ZmpwQ2dwUVljdHR5SFFxam5zamlHWEJ0?=
 =?utf-8?B?YWpjamsrMXpQbEIrSEQyNHBiYjV5b1R2Rmhsa1RBaG1DUXROa255K2FaU3VB?=
 =?utf-8?B?WmZYTnprZGo0QUV1QzgveU56OWk1VjBnVG1uQkNtNXZFUjI3SjMzVnpKNGdZ?=
 =?utf-8?B?S2dycUFxZGdYaW9YOHRCT2tyK09mY3lRWVRCMFRQMlJMaDNORldac3B1UVdv?=
 =?utf-8?B?WU9UaUk4bm9lMjFaaTFKR01TZkJVUkphaGwwcDQwTDBWV0FpY1NpOURpTjli?=
 =?utf-8?B?YVRqQWQ0WEFDaVlDcXlqMnZLamorZlVtZ2hOZU44WEJjUTZtUjVkVG85dXNW?=
 =?utf-8?B?SThFcm5BTk9JeEF0azNGRnB6MTFHc1JoTFFRY05aR2xOS1JWTWpZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fd0a4b-a19f-414c-7d15-08da49869f60
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 19:39:37.5473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLVJNXtM/hJayr59DtAcyo5oCXX9o4PCiRPSoVI8mfod5S3ccxIgk7/2q9U0Zy+SicLr0S1QaEyV5ueBgJjfhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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


On 2022-06-08 07:51, Ramesh Errabolu wrote:
> In existing code MMIO and DOORBELL BOs are unpinned without ensuring the
> condition that their map count has reached zero. Unpinning without checking
> this constraint could lead to an error while BO is being freed. The patch
> fixes this issue.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a1de900ba677..e5dc94b745b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1832,13 +1832,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   	mutex_lock(&mem->lock);
>   
> -	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
> -	if (mem->alloc_flags &
> -	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> -	}
> -
>   	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>   	is_imported = mem->is_imported;
>   	mutex_unlock(&mem->lock);
> @@ -1855,7 +1848,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	/* Make sure restore workers don't access the BO any more */
>   	bo_list_entry = &mem->validate_list;
>   	mutex_lock(&process_info->lock);
> -	list_del(&bo_list_entry->head);
> +	list_del_init(&bo_list_entry->head);

Is this an unrelated fix? What is this needed for? I vaguely remember 
discussing this before, but can't remember the reason.

Regards,
   Felix


>   	mutex_unlock(&process_info->lock);
>   
>   	/* No more MMU notifiers */
> @@ -1880,6 +1873,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   	ret = unreserve_bo_and_vms(&ctx, false, false);
>   
> +	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> +
>   	/* Free the sync object */
>   	amdgpu_sync_free(&mem->sync);
>   
