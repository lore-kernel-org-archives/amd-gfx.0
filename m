Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADCF1073CBA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0467A10E656;
	Wed,  8 Apr 2026 13:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s6POWSSc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D4110E64E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr4oXpNlZ8j/JzUWMN1cgYfjT8feDVEQiuPvOiIg0GzQTuTLmfuHl2IqTHcsLuSjbQ8kJrZsWRYwgL/E/gtGwGvdLWNyn6RPs3SC+mpZzzNc/6PKuDAUsuh2p7bB4UaxGImkZsfvmV9G9SDLnvS4EiUSyCwU4clm5DpewhccMNYYatnahMPw864jBwDG6M5gMAfq0jFYS4gLIvRnMWtFEif0eGEuNOalXet1/1DW6Rl5iQ+KacpNFbmdMdLvFltRCd4zSMe1RiopSbSoRJ3Cch7KfiVP0Dtd2+KhWVtoMi7FOudRr/aCFRbNvwkYKexlQOOEw0fZ9TdojfyPn5dapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5R+KAWGRIzFHNRCNPQNmb1BtpcuSKEnQqTvbVNSUrw=;
 b=xvO8Nx2bMzXkzXxxc8A1FeZW9WEDoVHVryJCllHpED2K9N9zKam98DRp/oQDHGDF+gSErqZp1nBQgBcGtbnH4cnYmgjKfTA1PayjRNRKdkQRxgSqoAHyieqVV8z2j7ko5bH+Dg6ET+E/4j5hcQvn7qtVAB4NIWpQzNnV/T9+WpDZmyI7thgowUsoFIfADspSi4DzTea60kDLgASj09/ueMGPi6wWzMebEHaCAbOrlCX04mwEyhKFDGKAr4lsqi2u1X3iLEcpjUTDklwBpVjNF3h3rK06ZgHs9wKgvPxHO9djndVZvOG7GvA+CqY0h872Bz82VKM3Wa4dio8qu5y/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5R+KAWGRIzFHNRCNPQNmb1BtpcuSKEnQqTvbVNSUrw=;
 b=s6POWSSccgp5Cfc21bcr6aavqcFBnPAVf4VyMhwdyvNZuvohAhMp9XKro6DByh7D8zNdCNjU/h/hPd6NkLoY3QvU3lopxN+2Z3Z3/TQ1mfaKXRF+VVDKtdSgEIFUasH/afwNycZDA6F1dJKFRKR3zNzRolwsRxx+a7++qf1MlIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 13:22:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 13:22:01 +0000
Message-ID: <acb9660b-75de-4c88-a98c-4e4408cd986a@amd.com>
Date: Wed, 8 Apr 2026 15:21:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix kerneldoc for
 amdgpu_userq_ensure_ev_fence
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408125512.3976369-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408125512.3976369-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0020.namprd15.prod.outlook.com
 (2603:10b6:207:17::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: f13ead5a-3ecb-4ff5-a426-08de9571d1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ZefN5TtZMt7lQVC75PABhUrBxSMpdr2CfKU/VUN3hNDs9GxKHOJ4tkzP1ARStaFhhKJeJFsEhGH1y8OsO8FMdaWDtKSC0LRs6i2lft9czPcVBboE1zYXU1yWVeU/UyYo6eYfg3DDS2O0/EZqQzrEq0H2ME3Sc41orGHTcdTsmQU+d0a205VcMSUgJpvhWqpbXhpmnbCW8qfh/XblQej0x/uowuEaNyEOoj9RLs8uPiPUdF4ug2Cr7hiOTRPTFFaabgO9U3mSWQgKFZTwtx4S1DJyb7k3euQ+6/uIOYAMECfRIpFA6BlVNK/ku1G9W7QwL+4xXHsqDzjneYtbQA1YBO8jY7kxLN3rbWIyoJHrtEqQYDUXBVskZX/ZDvWOPOuEFoQZUO0mqnwIkbNko5Xu9T4PcPDlgVslpy3XDfZecWmde59qnA7Gw1jLxDpvWzhgNNb/w8Qado4tOYvy5FpyNwnaJIE1QU2njUm1cTNsY+2TQTtfsQoHAiLwq1wZ2eYa6fWyiezVbq8UzQwzr2TygKlTOOB3GJuhypdp4vRmgphvUlFj1x0R40oW0Acw4fWe/BF/bX94Q4aabjY8PE0YWAVA9N6KRurRpR8Jyuo56qm4DxixOr6Fgsm59vG9NNAny9BG3Urt/iWbwxrZ/OBIHIeedgZt9grOX7Yu+9LpVdzHQGCrJ2otO/H1CIem/MsuouiC19+K1KrAWqgjyB56Qugf0rDsKL7jW1AMO6VJQ5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHJ5aHFGaW5CRUxvMm85YWJjN2N4ZGJvUDFub3pLK2JjR0xmeGNCN3hwTExq?=
 =?utf-8?B?SCtjMFV1WEdadGJGeUpOYlkyK3NRVmlJcS9SR29pL2Q0cUgrYkdJQXRGVGpF?=
 =?utf-8?B?Ymd0WnpVK0Q2TlExViszeVJBM0NwaFpxRHkwUEpvdTBvRGFkVnlLallnNlZM?=
 =?utf-8?B?WXM0Zy9ZRTFVV2xEQ25wOU4vT2p3MGRUK1lsRjUyS1FiekxoMXpHSFl0YWZP?=
 =?utf-8?B?VThJS3lMOHlmOERrbE5jczhzWmgxbVc0czNuVk5aSWFLNHRneWNxSmhwdDMz?=
 =?utf-8?B?bHJUejlxdFU4Njdjb2x4Y04wTmJ6cThtVk10blh6WnlNbW9wQzltWlNNb2Fq?=
 =?utf-8?B?UWtlQjI2UGh6eG5OUFF6UWxJUWFPcTIvUGxIdXNCZDVXeHNZNmJkNkFMbjIv?=
 =?utf-8?B?UUhUL1hNeXBHU2hybk44clAxcDJmYjd0MWw4RFM5WmFvbktxbjk5bnprOS8z?=
 =?utf-8?B?ZVZ3cTlCbitpZFd4OFRKam5GSHFSQVNKaXgyNDdaRkxtdkhqRXM3VUY1MXFD?=
 =?utf-8?B?NE1KMVZVWTRpQ0xSb3daQ0x1eGpWaks2RytxWmczTUJYZURVdlRkZi9mQUhK?=
 =?utf-8?B?SHVLdGtmWmFnbW1aSy8wWlNmUk1LRnhjZHRudzc3MFZiRmRrREJ0a3J1NWF0?=
 =?utf-8?B?NUZJQlFPb2F6RWsrM0tRYTA2LzRtZHZ0TDRTV3FpdHRCLzNlb1g5Qm1GRFVT?=
 =?utf-8?B?MGVqSktDS05semNrZ3JLcXkyQkFxT0JrUms3cVo1M01BcWc3R0EwN1VMSVVz?=
 =?utf-8?B?ZkcrS3ZDZnY0czZzM1gxY2txaW00a1E0UlNXcjJUQXRkaDBUV1dYajN0Qzhi?=
 =?utf-8?B?bkRJUFB5T25xZ3Z5bHJKMTVwM3B2QnJIQWR2TDNyN3NPa3ZZcDZxZ0NiaTk5?=
 =?utf-8?B?VW1OVVVjdXFGQkZsQ0pzSWxDdXZFUXBneWtVSjlhWFV5Uk15a3E4QWJUR0w4?=
 =?utf-8?B?OCswZVpsRkRGWW9aMm94eVlQSFh3dWsyUGxxUW02L00xQWhIamptRzgyMmRy?=
 =?utf-8?B?TTg0OWxNdFVOWFdMbVlrZXpTdGl3MmorbGRiY3lmOXpRQnVXbEx0TXVYS2x5?=
 =?utf-8?B?R2E1WDlPWUVmdnRjRmw4ZVdLaC9aUnpaaStZYUlTYnM3aTkrcHdOUkQ4bWtB?=
 =?utf-8?B?WVVhUkFlcWNQOEdVeFRjQ05vam9wVGNhK3Joekp5clVZMk12SUdYbUhqbHVK?=
 =?utf-8?B?anJtQm9vcCtkdzRhaW9KWTdOSjM2ZlR0QWdTT3pZcWNVQTNkOXBadmRULzdv?=
 =?utf-8?B?Y1ZvZmFvOW9YQld6R1diUlV0OXdETnpKV0hpNkdMNnRaNkdBenpTSnUreitC?=
 =?utf-8?B?VkE0cWQ2dXB1Uk5odlFsS05CdTBXTFZBQmV6dFNRYVNCK0NvNUp1THZycmZ0?=
 =?utf-8?B?YUpaTUJIWkRTVXNTdXlJMzJGeDVRWnBQSlk5dEVhZ3VWcFFVeGRZOW9zZDg3?=
 =?utf-8?B?eUNORmJjWnB3TjlKckZpaXNWaTJEV2NaRy9nUFV2SjVsZUdNUTk5VkRIdFFN?=
 =?utf-8?B?eTgwVHN5QXlOZXFZSllXczJoNG9CY2dtQjkwUDBMY1p6bHU3Z0NjNG5MSVQ1?=
 =?utf-8?B?RTUrZnREVDljRnRxcnpJZUkxNTJUME5VZkFNaEVVQU1lTlZFdGhqdGEzdzI0?=
 =?utf-8?B?aHZQRzdDTjlRWVQwRHM0YTdpeHVLSUZ4dFBnTy8zbGljSWtURmd2dG5nMHg1?=
 =?utf-8?B?RHV5UVVnUUhCRUFra0hab2hVeVBkU2didFkwVStPQjlqcTFLNXhYMlV2cEJj?=
 =?utf-8?B?SlBGbWoyTFZjUzE3Z0RCQ25KeTB5c29XUVhReXdHTmhxcHgxSGVONkZXVUZz?=
 =?utf-8?B?dEp3bFY3QzhsUHdBVVlvWkthZGNQREFjUG5mb3BHMXcyUURJaTczTjd3YzY3?=
 =?utf-8?B?enQ5dXFDL21YOFhuSi90QlZxcmtUV1N1VXBUcGtRb1FGNC80R0s4Nk1FMzZa?=
 =?utf-8?B?azlJbUlXK2VUWXY2Kzk3S1hTRCsvazNRaUxvRytabGh4aG96dHZvZUVmMVl3?=
 =?utf-8?B?elZ2RHJ6UlpIY3lVQ05jNHFGVkJicXljOGF4RFNpTU9iY05LVjFZRHFNcmNq?=
 =?utf-8?B?WXZtdjNiYjNsTmRZb3dBQ1dBMGRpalYzTzllLzMzS2tPRHVZbW9sRFZudWl2?=
 =?utf-8?B?Z2hHWXZrTnNaQnZlT2VhdnZHWHdLSXZHbXE1aFRxYXk4K3dFVjVWdDZid0xS?=
 =?utf-8?B?ZjNVcDJFME5MUVVvcUNMYlU5NjRuZ3VHS2REZU1VTy8wejdIK29iSXNMZWhY?=
 =?utf-8?B?YWpTMVVnMisxZ2grUkRyTm9RdVZkWVdLbWRMeVJ3YlBNRC9MZTFvWTFMNkJ1?=
 =?utf-8?Q?ucIDBKfdkeqE6E8npn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13ead5a-3ecb-4ff5-a426-08de9571d1b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:22:01.6500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd30kvJVAke1urbmqnMdiE6qzbI8hgwwlcnd2pQob6ofcbeaZI46ZDY60wOiXkoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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

On 4/8/26 14:55, Sunil Khatri wrote:
> Move the comment for the caller to the definition for
> amdgpu_userq_ensure_ev_fence in kerneldoc format.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ae973c611972..9f7a08a6b018 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -460,6 +460,15 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	up_read(&adev->reset_domain->sem);
>  }
>  
> +/**
> + * amdgpu_userq_ensure_ev_fence - ensure a valid, unsignaled eviction fence exists
> + * @uq_mgr: the usermode queue manager for this process
> + * @evf_mgr: the eviction fence manager to check and rearm
> + *
> + * Ensures that a valid and not yet signaled eviction fence is attached to the
> + * usermode queue before any queue operations proceed. If it is signalled, then
> + * rearm a new eviction fence.
> + */
>  void
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			     struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -786,13 +795,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto clean_mapping;
>  	}
>  
> -	/*
> -	 * There could be a situation that we are creating a new queue while
> -	 * the other queues under this UQ_mgr are suspended. So if there is any
> -	 * resume work pending, wait for it to get done.
> -	 *
> -	 * This will also make sure we have a valid eviction fence ready to be used.
> -	 */
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	r = uq_funcs->mqd_create(queue, &args->in);

