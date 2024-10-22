Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC90D1715E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 04:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633EC10E18C;
	Tue, 22 Oct 2024 04:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YIt1tWZA";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A953210E18C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 04:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9KCxCSkz3ECFdW6OXe/GyB9nWRJuy+/HBaZBZpmV8tB8T6+24nEjJENzwoP2fPdXllMo+PDfFAZaKr+NlQOGalWVb4SbvA7ZBbv4igi/6aeimTvqm68gAktSiVtB+6IMOuxanalZTs9zDAFX7dcWOYvwtjcIssxwd9qDIeAzC//M9ESgjIp0HZYqA0RhfZq7J2lL8JRPrqMZm3j+ELC62i9et+ZTw2FfNM2yI0UPGW3rlpO57M7Q8mrNoLpLznpiWxBuch1pEztv0UGIw/SMUjMEAuNOBgdwgKBo7D6WL6vk0+y+uUwOsEplpySegaX1nrpCM5G4qDlXLz8Y2BJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55c5OuGZ6W7Ifymg66mF7vp5NXzsx7w4QvJTUwg4pfY=;
 b=bC1yNtZrSVUKYBgpXsMvImDp+B9VO5NDLF4jSIECoBL2zyMpiC4ZWmU+M+QCpmtho+QH2mKSHh9CBT+gkyIubgdsPLkwoCY9mK/sX+GhXEPoVICunw/42Ug4FvADI6SUUrPjuWpmgsOlGirMnvxPnMaFXmokAWHpsg7lNFfMVMH491cFoywSweGJBlFpyzj8kP3huvHLrTMOGbQuLZgl0yi04aVj5YOfZpNq+4bNnQZUGQvXz7guq6oMPzm66+gd+R8VntaKDuAu2leQz6er5bCLjNbSl9ANNm2BS9PmHNSz7A57UcYY28PbAiS2avOtz4VEFL3Y8resgxB2JftwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55c5OuGZ6W7Ifymg66mF7vp5NXzsx7w4QvJTUwg4pfY=;
 b=YIt1tWZA8G+SrD1yY4BoFLSkkiUJ0daWqRR4PCqeL+7Zka0XJuggAsiN+a8MYGkqXxMZAsRzB7Cd8uTAgzhT8HVrISmdRVaXnJilk/9eIcZc1KNFQEd4UViRwZaRO708aPopgYLiX33g0FFBcEskQK1OOiNcIRdsuJluJ2srRS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Tue, 22 Oct
 2024 04:20:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 04:20:11 +0000
Message-ID: <db85737d-9489-453f-85c2-dbd740a98904@amd.com>
Date: Tue, 22 Oct 2024 00:20:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Explicitly specify data type amdkfd_process_info
 in related functions
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241015035150.1477582-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241015035150.1477582-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 245afbe4-98c7-48a1-d1c9-08dcf250d200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFRIN1VnWkgyeWIva0JoQ05sck5SRTJGSC9SdWJTM1doSUhDbTNuc0hyT1c3?=
 =?utf-8?B?K1Qva29ITG9tODFSaGRxSWYxZ24xR1R2SUJlSnJkUGR2Z0JadDU5cHlXUVpO?=
 =?utf-8?B?Y1cyZGYxU1A3bDRIaEVDemdja0Z0V2VNeElGaFM1a2FMQ0YwZm5oQ1hiYk1R?=
 =?utf-8?B?VXFBNFNIVEpCb0ZBa2s1TU1YdVMwbDJEWUEwWXRkMG8rZVlVdWlOWGpLTEVj?=
 =?utf-8?B?MkZCZENCYS8xTkpkVk53dDg4aG9ZVlFPTVdyZGpseHhvM085V2RJbU5WWFFt?=
 =?utf-8?B?QVI4ZFhqTnVya2NrVTFERXFZYjhPVWU4MG9MQ2RXRnBOZHVCb3BWZHFzL1hl?=
 =?utf-8?B?bXA3cmJtckxsZ2dnTjV6d3hGdGNFR0pMZ3hHcnI4S1RjaTZNV2cwNURyeDVa?=
 =?utf-8?B?T3JzanNuVW5RNE12SmRnOEp4RnBCRnYvdFFVYUdJcm5jY3k1b2JnYkI2Sksx?=
 =?utf-8?B?VEJ4ZC9tdXFUd2VMTTVldTFzdTlEVmRhaUl0UHdIYU41NFJoRFZyNkk5ZUpr?=
 =?utf-8?B?K1FRcllLb3RFTHJPc0RRazVNUnB6dHlJNFZ1RldlTG9adVhPenNpK0YrUllq?=
 =?utf-8?B?M1djcURTSE1VVk90QmJxcUhSb1NwV3Z2NU0xVUVGZ1QwdDF2d2RCZXdBSE54?=
 =?utf-8?B?Qk5Wejd2WHZKNURYalhHSk95NFk1OVJ1UW4xa1c3Y2U0ekhDcWVuc1J5OEd3?=
 =?utf-8?B?NXNseFY3RGorTnN3SmdIUDN6dUEzTDFOYUZZK2ZYL09MUEpJZzRySzhpblhD?=
 =?utf-8?B?dXBjR2pSVlVtN1lNZGNYbXEvVlhNS2IxRlpxZWoweUVrMzVCYVl6bW9EQTlU?=
 =?utf-8?B?VHpjemlsUWNxdWVrb2ZyWFhiNVRZZnVObHZZdi9nOWllb09CMFF0VUVxNzJG?=
 =?utf-8?B?WFZvMGxvNnEwRmgxdnJieHNJcmtaK1RnUStINUowSUh2YS9paysxL0p6SGJl?=
 =?utf-8?B?OEpSVFp3SCtpNTBVc0g3eE45a2pLWmg4RFNwOXlEWWFOTGo2aW5qMm1ubGc5?=
 =?utf-8?B?Q1BBSGFER2czQVplbDQ3RVI1cHpLOVp1ai9sSGltRVM4MzRzNnpFb3gxTmZR?=
 =?utf-8?B?Y29EbnFqOWtLN05leHV1dFRneW1abEpWbWQvcWtJVkxmWU5tb0xHaWoySjNH?=
 =?utf-8?B?aW1lTG9vYkpUT2xvcHpGcGNVNllUYVpGSkR5dEVxUURicDZhZFlTczdrYkhh?=
 =?utf-8?B?VjM0MXAwVEI4cGUvdGY0Q01ubmZNRVdLKzhRM2xZbGI5ZXp3TjBQZkg5KzND?=
 =?utf-8?B?Rzh3N1h0TVE3cDFtMzFjMXhZdVdGRjh2N0RyNmpZMmYxdzBSTkIvWjRXWjF5?=
 =?utf-8?B?UDhMa0htY2FvRWlnN0k0UDdDSkZhd28wUUNUQjJ0UmVpRFdGc0szRnRPNm9Y?=
 =?utf-8?B?MVp1dWk1d1pqVGRaS25sU29XWXhkS3JNZ2o5aXh5QklEMHNIMG9XdVhCK24r?=
 =?utf-8?B?WWRydGRJVnFkelNNa3J4N3UwUnJQUzBFWnpaOVVVeWU2RmxMcnltd1FydWdL?=
 =?utf-8?B?b0xycGhLUWhIQ2l1UUd3NUF4bjNDRDV2RWp1Tlh2eG8wamxJR1BHKzJrd0VN?=
 =?utf-8?B?VHo2RCs4Ulg5OTE2bEFKOGNGZTl6ck5pU2d6UlRHcWVMVmN3cm5JRERiMUV2?=
 =?utf-8?B?LzBKMkJ0czJaekN2TVNxVFF1aWtwV2ZQdHFhTTVsNkdIdlAxVUpLQjc3U1Ex?=
 =?utf-8?B?bFRIb245R1YvVlhod2lwc3dBTXhLbEZxZFhrNmVQY1Q5K013NTVuMEFvYk11?=
 =?utf-8?Q?kbw37gGxFkS+LRK+GW+/9J5DNJtGoQPVossvfeC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTNiZkxRc29DTTVVaWlGMzhZQXpGZDFQdW1YMFgwU1hPSGRFYkVvbkJsY1Jp?=
 =?utf-8?B?RDNGd01sWjZ3R3V0Y3h0b1NubVpCSzdrbVF4cGlqMEdyUHF2VGttRGlZV3lD?=
 =?utf-8?B?c1RDM0RmcDBWK3AzMTQ1NDlzN1hTUGM1cEQ4OWZuc2R4dmtPc0REMkIrdjE2?=
 =?utf-8?B?Vlo2bTI1Y3pjR0haV285OUpGcTVWVmVad25UQXZWams5SjIxWG9yYzRoZVpj?=
 =?utf-8?B?Y29PQjdUdGFjT1VSYlg0WFh4UHB2aVZvZUh6YTk4V0FZcVU2VUhvcGl6eHBy?=
 =?utf-8?B?TURYa01ML1FtK04vNUtSSWJpUjlSdHZORzZYaGJydVl5RmN1UmNoSWFab3R1?=
 =?utf-8?B?NzJyc3h2MytoQU1xNjRjL1VBeEZCOXJUOTZEdzZGMmlscUlBNk5vUHMzTzky?=
 =?utf-8?B?NXVualR4MHJTaUQ3K0ZwZVJKRHFBa0FLY3RnaWdWdlN6RUpacmdCblZZRnRh?=
 =?utf-8?B?ZkJlQ2x6ODlFbE54MXI1empITUJzOTBORTlUZDIydWpocEVyWURYM0RNLzFO?=
 =?utf-8?B?R01pQXpxLzdzZjhlbkYxVWlyTlRrWmJXdXpROEZ6UEVTbDFIM2hWRjdFTlVZ?=
 =?utf-8?B?RldhbHg2RlBSR2hKaWVhYjhMaUV6Z1RwaFpTN3FqaWVCaTBuZC82MkJPWDZG?=
 =?utf-8?B?MXJYS2RXUldKNThRZDFXTlpEQ0pTK1U4cUhveWViTUc0Q3AxZlhoeU1GS3Z1?=
 =?utf-8?B?QnpXMFFldGVPWWpLUDhmY2wxZGdDY2ZPd05jRjJ0VnRKaE0xWkJFQTh5Z0U5?=
 =?utf-8?B?MHJVVkJLaU9rNUVoK1paYWxWSEJuQStzanQrTHBTb2xDQUlLdjZCQjJIUUY0?=
 =?utf-8?B?MkRqZVZVTUlrUlNQUUZBVzg5Z0tVV1V2VDZjQzFIUkx6QmxlOWxlL0Z4Y2xt?=
 =?utf-8?B?NmMwcU1hN2lzS1ptYmUrVnNibHROdU1xd0pkblpSb0pic09NYms1cWlNWDNq?=
 =?utf-8?B?MnFNRU9XeVFlKzA3RkxQYTBDQm1LUnFhdzFpcWNnK0RpNFcza0dpMWFkSEhF?=
 =?utf-8?B?ZmFZa3hMbjFyRGx2R3RuQjhsVGIvSGVvZjNaTnV3aTBndldBamFidmp6QnUr?=
 =?utf-8?B?ZU1lVmw2MnpFa1VlSXRnc1h4RmRyOG9rL2dWcER6Q0FsUndEdTJZR0dreldD?=
 =?utf-8?B?ZnFrdkpjMmRmeXVLMFZ0UDBlTnpaU2NjaC9oQVordGFDODE5NDlGK2dsSy92?=
 =?utf-8?B?eEtKS1ZlbXZwWkhIL3piVDFBazU4TnlTajBrVVYrcXd6SVVWNW9rZVVZdFhr?=
 =?utf-8?B?bFhnS1IvditUcnhkQ3JCS0FNVnc0L0pwOG5hZHVkRllNQkJJZkt0cTl5ck1h?=
 =?utf-8?B?MTR2UjB5R3pwYVh4L2JsNzhEem1sS3J6cHlnY0tSbXZ1VmhlY0daUnZaZDhE?=
 =?utf-8?B?RDhsZFpNS0hVeFRHcEtJam5CekhsdCtiaEswNnpLcGFjTkxHelhYZTUwSjBz?=
 =?utf-8?B?TmQzZ2M0aDk5NE5UdWlnb1h5MldUR0R5ejBlTzN5Um5uTGVXaEJYRmRyVDk2?=
 =?utf-8?B?amh2MEh3WGtTSG5UbmR2eERPNHBiZXJWdGFWWThXK3NBZnJpZm9jaU5YcDhp?=
 =?utf-8?B?SEtpa1RnanJucGJMZzVaM1Z3UGZXek4yWTY2OVpJZ1oxM2ZjK1hHSGFqZGxN?=
 =?utf-8?B?NkROdzhiZE1iQWp3RE5CVFJhY2dqU1Z1YjV4amxGRzBJR1hOTnlsL2xaL0VF?=
 =?utf-8?B?bHZlMnJFVzNEUSthYlA4Z3hzMkFYek41K2YzcjNtMTRhWWRkUHFpRU9kMWRy?=
 =?utf-8?B?dDk5ZHc3NW15S2V4TmVYYVNCVEJrYjhMYWtEeld0OWVHZGxhSWlVdEpud1VR?=
 =?utf-8?B?N1EzOENyNy9WVmdub04zYTE3Z2JCSzlZcUNsQ3BWckRqTGgyMUxRKzl4SitS?=
 =?utf-8?B?VUlGTmpVVldST3lTQkkyNlNqYWhsdXRRRzkxUHJ0c0VLUHBudDlGVHlDSmJw?=
 =?utf-8?B?Zm16MENUY2V1TnBydTNUTmpaY0pWQUUydUtWcVBHVUNibDFZbTFkVys0SkIx?=
 =?utf-8?B?OXJaMHhIZzBjT3ZNdnRlMzlzVnhmOWUwMUtST2RrTDVORGkwY0ZXcDRKYjVD?=
 =?utf-8?B?eExaR0tYNnBPc3ZsZTlRRTRyUWJGM3dLaHREbXhTdG5RTmNtaDg1Nm03TWdt?=
 =?utf-8?Q?8r6zgBI2soOZIdmQIpOYjWveV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245afbe4-98c7-48a1-d1c9-08dcf250d200
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 04:20:11.6086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlHhMaUvTvPFCo1XrI3vykY7rLhzVnxgBs4qelOGGCob7n9GPOgVdN4FvJFCzVAj1dlXN3q+nIXt4/UtytCSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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



On 2024-10-14 23:51, Zhu Lingshan wrote:
> This commit specifies data type struct amdkfd_process_info
> rather than general void* in ralted functions.

Several interfaces in amdgpu_amdkfd.h use void * as opaque pointers, e.g. process_info, mem_obj, drm_priv. The reasons are partly historical because KFD used to be in its own kernel module. That said, there is nothing fundamentally wrong with opaque pointers when the upper layers doesn't need to see the contents in the objects returned by the lower layer.

It makes me wonder, though, why you're singling out just process_info? Are you proposing to change more interfaces to eliminate opaque pointers?

Regards,
  Felix

> 
> kfd_process->kgd_process_info is initialized
> in init_kfd_vm() by such code:
> 
> static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>                        struct dma_fence **ef) {
>         struct amdkfd_process_info *info = NULL;
> 
>         if (!*process_info) {
>                 info = kzalloc(sizeof(*info), GFP_KERNEL);
> 
>         *process_info = info;
> }
> 
> That means kfd_process->kgd_process_info is type
> struct amdkfd_process_info, therefore we should avoid using void*
> 
> Using a specified data type other than void* can help improve
> readability. There are other benifits like: type safety,
> avoid casting and better compling chekings.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 31 ++++++++-----------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>  3 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f9d119448442..c1346b8c9ab7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -239,8 +239,8 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>  				void **mem_obj);
>  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem);
> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem);
>  uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>  				      enum kgd_engine_type type);
>  void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
> @@ -299,7 +299,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>  				     struct amdgpu_vm *avm, u32 pasid);
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					struct amdgpu_vm *avm,
> -					void **process_info,
> +					struct amdkfd_process_info **process_info,
>  					struct dma_fence **ef);
>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>  					void *drm_priv);
> @@ -348,8 +348,8 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
>  
>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
>  bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
> -void amdgpu_amdkfd_block_mmu_notifications(void *p);
> -int amdgpu_amdkfd_criu_resume(void *p);
> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo);
> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo);
>  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ce5ca304dba9..2a1ee17e44a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1376,7 +1376,7 @@ static int process_update_pds(struct amdkfd_process_info *process_info,
>  	return 0;
>  }
>  
> -static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
> +static int init_kfd_vm(struct amdgpu_vm *vm, struct amdkfd_process_info **process_info,
>  		       struct dma_fence **ef)
>  {
>  	struct amdkfd_process_info *info = NULL;
> @@ -1552,7 +1552,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>  
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					   struct amdgpu_vm *avm,
> -					   void **process_info,
> +					   struct amdkfd_process_info **process_info,
>  					   struct dma_fence **ef)
>  {
>  	int ret;
> @@ -1639,19 +1639,16 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>  	return avm->pd_phys_addr;
>  }
>  
> -void amdgpu_amdkfd_block_mmu_notifications(void *p)
> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo)
>  {
> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
> -
>  	mutex_lock(&pinfo->lock);
>  	WRITE_ONCE(pinfo->block_mmu_notifications, true);
>  	mutex_unlock(&pinfo->lock);
>  }
>  
> -int amdgpu_amdkfd_criu_resume(void *p)
> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo)
>  {
>  	int ret = 0;
> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>  
>  	mutex_lock(&pinfo->lock);
>  	pr_debug("scheduling work\n");
> @@ -3093,13 +3090,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  	return ret;
>  }
>  
> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem)
> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem)
>  {
> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>  	struct amdgpu_bo *gws_bo = (struct amdgpu_bo *)gws;
>  	int ret;
>  
> -	if (!info || !gws)
> +	if (!pinfo || !gws)
>  		return -EINVAL;
>  
>  	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> @@ -3110,8 +3106,8 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  	INIT_LIST_HEAD(&(*mem)->attachments);
>  	(*mem)->bo = amdgpu_bo_ref(gws_bo);
>  	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
> -	(*mem)->process_info = process_info;
> -	add_kgd_mem_to_kfd_bo_list(*mem, process_info, false);
> +	(*mem)->process_info = pinfo;
> +	add_kgd_mem_to_kfd_bo_list(*mem, pinfo, false);
>  	amdgpu_sync_create(&(*mem)->sync);
>  
>  
> @@ -3136,7 +3132,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  	if (ret)
>  		goto reserve_shared_fail;
>  	dma_resv_add_fence(gws_bo->tbo.base.resv,
> -			   &process_info->eviction_fence->base,
> +			   &pinfo->eviction_fence->base,
>  			   DMA_RESV_USAGE_BOOKKEEP);
>  	amdgpu_bo_unreserve(gws_bo);
>  	mutex_unlock(&(*mem)->process_info->lock);
> @@ -3149,7 +3145,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  bo_reservation_failure:
>  	mutex_unlock(&(*mem)->process_info->lock);
>  	amdgpu_sync_free(&(*mem)->sync);
> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
> +	remove_kgd_mem_from_kfd_bo_list(*mem, pinfo);
>  	amdgpu_bo_unref(&gws_bo);
>  	mutex_destroy(&(*mem)->lock);
>  	kfree(*mem);
> @@ -3157,17 +3153,16 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  	return ret;
>  }
>  
> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem)
>  {
>  	int ret;
> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>  	struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>  	struct amdgpu_bo *gws_bo = kgd_mem->bo;
>  
>  	/* Remove BO from process's validate list so restore worker won't touch
>  	 * it anymore
>  	 */
> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
> +	remove_kgd_mem_from_kfd_bo_list(kgd_mem, pinfo);
>  
>  	ret = amdgpu_bo_reserve(gws_bo, false);
>  	if (unlikely(ret)) {
> @@ -3176,7 +3171,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>  		return ret;
>  	}
>  	amdgpu_amdkfd_remove_eviction_fence(gws_bo,
> -			process_info->eviction_fence);
> +			pinfo->eviction_fence);
>  	amdgpu_bo_unreserve(gws_bo);
>  	amdgpu_sync_free(&kgd_mem->sync);
>  	amdgpu_bo_unref(&gws_bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d6530febabad..b0426a1235b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -934,7 +934,7 @@ struct kfd_process {
>  	bool signal_event_limit_reached;
>  
>  	/* Information used for memory eviction */
> -	void *kgd_process_info;
> +	struct amdkfd_process_info *kgd_process_info;>  	/* Eviction fence that is attached to all the BOs of this process. The
>  	 * fence will be triggered during eviction and new one will be created
>  	 * during restore
