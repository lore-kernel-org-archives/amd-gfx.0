Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBFBC3DA61
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1380D10E00E;
	Thu, 18 Jul 2024 21:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKV5yJ+m";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD45E10E00E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E39KEioTiijh1T5QaA9uqd92DfqKbw643+HtWjm4JCoW3FgVKax1Q1jpNjZnssMzxESLWbLgTHlYzOD2yF+s1Tp8eNv7C4Rk/4445ReWj54a7sude1chj2bwvRoIyPghBoeBsqavTWc1dqb+eBb2Jbp+Z40QhXXO92SHi73G7v0OILf7F7g7mbitRzYhv2km97+ZGfbPuyHt8PhCyAOPOnIueUJ8vz2aRRcekjbC/Y51lYqqyHwWMAS+Z6KkRoexE22dm8E86EYHfO3MAcpEnmLOy8n//N8SgaiIpa20f+WOdQvQ9iZzuZlajTfnX7po02oaz2pNUoUlLBha05PIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC2fZLLiKGns0h2os7UUoLIwv2RxBJXs2lGVJ+ofu7Q=;
 b=WbbAIuniXn41/lNUFai6JgBgh7t+MaUfub6fpn3d6dPOj7eZFEEZhyKLp+EgLmyvw8CQ1Ec+VylA8LcjtBprJiqxVzUYn6TyMsiIPDof3H8VFZ1JbHFjamicMPMRlr06qf+2BXgZwM5v0HQNCxzVxjuCdJFow8ZmY4I5IXy9++RfxMTLPg/otdu76HyaYofJgDl3RW2oL9NDzbK1kZ3Lhf4db1B0eR+E2WKNbbweO7rHdKNKbMNlfiswuWZeNIJCe+OZf8R1rTeyhJzZ98gLWYn4rO15rFW1tYSRnB6sfvUNCCLY2ef21Z/dVGFV+Cf9iTVah/3M66GHe9mpAFU+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC2fZLLiKGns0h2os7UUoLIwv2RxBJXs2lGVJ+ofu7Q=;
 b=tKV5yJ+mYunFtjM6PphJy8I/siosePby4wn9BZMF8Zaqix4SzAdUJTFD3h3YfC8AaBe3X8czFr/2V+wVZdwU7zUWY/1dH9benndngSb1KZL51CA3kS+XiAySr1bm90Bu1019A+B8266uAbiushXKtCLyCbUpc0cf9v8YlBzPWx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 18 Jul
 2024 21:12:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 21:12:10 +0000
Message-ID: <24b881b8-6bb4-4438-b329-6aa2b7938918@amd.com>
Date: Thu, 18 Jul 2024 17:12:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] KFD user queue validation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240718210558.26340-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0080.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: e575384f-6260-4656-1727-08dca76e49da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEZQdDRib2EyWndQaXI2bFdOUmRXQXV0cWZhdGk1bHBQUlVqTXZvai9ZYm9Z?=
 =?utf-8?B?eDJzZGhxUUxZUDBRTUlVNjI1aUl6NmpMVmdNQVVQRnViMi84eWpRSnhuMldM?=
 =?utf-8?B?bVpSc2EvQWw5RG52VnM1WFlzWGFFNmV1M1lPclJNRjVvbHZ2ZCtXaUFOK0VZ?=
 =?utf-8?B?cmdKZXlhVkQ4V1NDVEFxQWVjclRuVzMzTmpyZlBwSmVHQ1Fxd2JFcjFkeXUv?=
 =?utf-8?B?TlVFQnRoaUFrU3hGSy8zN1RMNkVEK3kxZUJjZGw4TzBPQWI2OEs3dU9odVUz?=
 =?utf-8?B?VUpvMVZjdXVDeGFPQ2RvRnltejlIVXpaR3oxc3dTNE5tc3IxMk1HdG0vZ2wv?=
 =?utf-8?B?MmVlVWNCTUhMQUdKcGJablJBdEhPRGluKzhFRFRvNklpVEU3a3FMSW1nSXZl?=
 =?utf-8?B?K2NxQmJjd0Q2bG0vT2MyRUxtaWIvQUhQTU9UN2VHMUZmcnRDSjgwczNhMXVo?=
 =?utf-8?B?OThNd1hWOHA1OWpoQkVidmNWeG5ncjhMRTczY1hteE5lNUpCaUxsN0pKU2VN?=
 =?utf-8?B?Rkx2ck9VR2NNcTlYK0h5dlRyY1dCK1RON2lLNHN4MlF6S29ubTB1SVJmK0Fi?=
 =?utf-8?B?Yy9HS280alRqeDFpWUhkTkZpYWY2Y2tuK1NlU20vdUpmdzV5TkdWTkF3S2Fu?=
 =?utf-8?B?SjNLaUVKeXJxODdnZ1NNNDJhdzBOcExZb0tkRHp0YzF2Y3ZKeTMrUHBlZFBz?=
 =?utf-8?B?Zk0rbm1McHhHRElxNW1hQitEa2Z3Mm9EaHAzcnVmbzdtZzNYTVV6MVBkMW9z?=
 =?utf-8?B?YjVvQW5IU05RVENzTnV2ekRNU3JoUkFRSTBJR0ppa3RGOHVBTEZLZEs4VW15?=
 =?utf-8?B?VENBOXY3eTcvNDVXZC92Rk5BOHlsK2t6L01vSmF5NnVRRDhNRWU2Q1RFWjBB?=
 =?utf-8?B?WCs2U20zL0UzN2ZMSEFBWFlkazJkTnFnaWFNQmlxT1hXT2hSMFNTbmgvTnVu?=
 =?utf-8?B?eHFqYXVsR3BwcmFSTzlzMk4vb051TFZMY2tiVkNnSFZjVktMN0w4cEFMb1R0?=
 =?utf-8?B?MU9nK3Y2aVZONFVmL1QraWF3ejJRSS92SE5SYitvQjc2Tkg1QWNlQnFOTU96?=
 =?utf-8?B?RlVnK3JvMm8zNGhuSDRodEJHMVlFSXkrK0xyeHlMUWRZM0RVZ3h4cnJtZGlo?=
 =?utf-8?B?ZkhPRkgxS3BpYjNCWlZJSDJkcmZTcGVtZlhQSlIvL1dEZ0wvOWt2elE1dGdF?=
 =?utf-8?B?TUR5YlNwS0lKMnkvbmlyditCeTlwOC96T2U1QnR0dU9ZWHlLbmk2dWdoTW9p?=
 =?utf-8?B?Zkx3cnR1U1ZDRk5Cc1d4cDZxaDQ5OERyYkt6RUh5TjRJSnl6VXdpd3o1R1lF?=
 =?utf-8?B?YmphaFNGeE52MmR3RXFZOFgzYmtIc0NpbDh3eC9kaktOcmFYTS9GSFhZSzFx?=
 =?utf-8?B?YU54MmtFTXFkT21NUGhHNzRTci84OTRPUWhOLzFDMWFyUjFTdGIrcXJnaDBj?=
 =?utf-8?B?cEVqUkszQlBCTUJqbEpNbThKQU9FSVp3WUZsNmtYZ1lXQlFxRTF3RXhrWW83?=
 =?utf-8?B?U2xhR29nWVJFckl6aWhDMWt4RTRtQldhS0xIdkhCT0dxQkpSbnNxZWdvN1A1?=
 =?utf-8?B?OUxPa3ZrMnJhcWMvYVZFSEhVU2ZTb2NDOWxOT0R6V1dVaGlaNWJ6bEpsSlVn?=
 =?utf-8?B?dWdoKzF2NzM4aG9DaUlzUTc2U240MkxSYS81NUxSbHlTTHdvajdwUUs3UHFN?=
 =?utf-8?B?b1JhNkdaREk1YjdQY2U3YTYwMXU0bTk4KzdpZDAzd3UxeitWa0I2MHB6SjRP?=
 =?utf-8?B?L2hVOGtJOTVmZUxnTGNaSHdIc0Y4YXEvK3A3S0ZieTRyZEkwd1RCMEN2Q0pZ?=
 =?utf-8?B?TVAvbzRrVXZRNWVnWHJOQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9ldFJiT1lkUlFoQ1liVmFmMGJyOEZucWplbXloMTN1ZGpQeFZuU2c0Nndh?=
 =?utf-8?B?UFpEUVNOWTQyS3NlSW1xYk5kYVFQb0RwT0NjUGtWOFAxWVMwYWkvdVY5aWR5?=
 =?utf-8?B?YjBoR055YzRWcFNHckxCZjZyQjVSellkaE5DUzJ2Z0hJSTFodFhtdVJ5Wk1V?=
 =?utf-8?B?QUxUMDJhaExadi8wUVcrYkVzZHdyeERua1lKWExwZzNjZWFNL2RvaWhuZkZI?=
 =?utf-8?B?K3BlbDljVXNnQml5aDlVQThmRTV3NkJFTFdtUUVZanlaNkh2UG9aZXh1WGRL?=
 =?utf-8?B?RlM0dS9zS1FHMEJvRmw1djhxbk42b1pPSmx1Rk55VXA3RUdkTklCQndydko0?=
 =?utf-8?B?emh6eE5YakhEK1BDL2R3QmRyb21IOVNwVkpZN1NhVnl4cXFDTUg3L0YrZUI5?=
 =?utf-8?B?eDQ2eHg1OTZaVlNDSGhmcUZIY3lVVHNWYk42WE1zRHdKY1gvWlU2OFMvZGdL?=
 =?utf-8?B?RUJOUjdkbklvZTFTTkFrVmY3MFplMnUwcEowai9xSUh1dmhxY1JpUmVYWDF2?=
 =?utf-8?B?U245TERPMGMxWFUrTFl6Mm5nckhoQ2tXTDNkYW1ndThLNE8zSEdIRTcveWcz?=
 =?utf-8?B?UHJ6QVh6cHRLZnRGWDNWbUVDNnF6SUZQeDI3ZldmaGlrdURhVG9CcVVmT2VU?=
 =?utf-8?B?b0VodUtsOXhhd1laZlBnMFJEeUY4emROQmp2VUdXcGxtMWlLYkFlTE9jcmJ4?=
 =?utf-8?B?bWRXUHR1ZERiZkF0eFhkcWlEYXRsa1ZrL3dBOFErazJCRVFid1RBODQwWjJI?=
 =?utf-8?B?YTBYeTRmWlpXaVJkV3A0L2xaVFhEL2F5NzlvSnVXUDA0ckljZzBaaDZtRUw2?=
 =?utf-8?B?UDRQdjRuMnBjQ1pWekU2WDJ1T0xrNHE1YTZoeW9hRWEwVFZaVUwrV1NvK1RF?=
 =?utf-8?B?Qm8xL3UrbTIwUnBPci85SHVSdnJLM0tsT1lvMDhLcW02WDNkNHEzZFc2ZHVm?=
 =?utf-8?B?UU9aWTdCdUNnL0tjZkMwb0tWQitvZ2F1RE5BT0RVdWF1U0YrWmtRVE9PU1dG?=
 =?utf-8?B?cW5VaDBaK0g3eTB4dmFtQ3UwWldJeldJRG44aDI3T3picVBoMlpmenkxdkJT?=
 =?utf-8?B?RzRzS3FKSEY5VFdZb3c2OVF6MlJwYnhqUXJzSDZicUJWTGZlQmtsbkR5RERW?=
 =?utf-8?B?TlpUeHUvdnJWS09MeGF5SGFFc3VaRVVvY0swWGdGbm5kcnFGLzhjNFp6TWUv?=
 =?utf-8?B?cU9ObVhMbWQzK2hrcnZ1OUc2VEZuTStxSkFyWmNJYTg1cEdhdURjMUFSNFp4?=
 =?utf-8?B?ZWc1ZDVvSUw5NkxXU0hoVitGbkNRZG1NMVlyN1QxM1FrSHpSM0FCR3hnbmVR?=
 =?utf-8?B?ZzJsaGV4cE84UzNWUG1WYTZheXk1dDhyMWxNa1ZKN3lwQUEwSUhxRTc3R2d4?=
 =?utf-8?B?YjVCM0hPVDF2bEtNQ2tHQ1ZKbW9xOEJ0Slpma0xTd3NUWFFSSGhOc0JIZkYr?=
 =?utf-8?B?SWwrTEszazBQSU9TeThLR1M2Y0szK28zS3JOc2RmbGFCRllTTDE4N1daMTJK?=
 =?utf-8?B?RVYzaWlzOFJwc3JlTjBPYVhOd0dqcEFubDJKV2Q1a0FMQjdxaUFsT254U09E?=
 =?utf-8?B?NlhVQVUycHZWK3BOUUdJUTR5eTR0MGU5Wk9rYUtUMnZXNG1Mb1B1VmNORCsw?=
 =?utf-8?B?SCtpcnhSUmhSK2pmNmJNVjhGayt2dGZOcldSemxNVW92djVKY2JlMWFSVTdt?=
 =?utf-8?B?K0VGV25EL3hmeXBFa2wydldHNzZzelhKYmhxZUFsQmxFSjNBRm92em95Y1Vw?=
 =?utf-8?B?dmk5czl1YVM2N2RJb1Y0L3ZjTkRYWlhoQk5TQzBOUVhLdnNxdFJ4UHdkck9s?=
 =?utf-8?B?U3BPcDBHclBuZXJzTWRmTnlwcnRXQ3pDdkFHZGk0SUl1REw5WWVQRmwyb1dF?=
 =?utf-8?B?d05QdTVVNFVYWEJ5aWhtc0lrZGo0aXI2NVM4N0VXZzRoSnl6YW51SkRoOThv?=
 =?utf-8?B?RWNxRkdXczBCZmowb054WER0RU91aFVEalNrenZSSWhFZ1hUblR0eXQxOUxp?=
 =?utf-8?B?bFZsbUdhMExlRXgweFI0NkdyeWdESTBETlZDRUsyWlZRbzM0QXE3K3NPQlpr?=
 =?utf-8?B?dTA0Q2gxZ2J0TDY2MWdoYVJVcnFxeEY1SXFiQnhhNEs1SERhM0hTWkY5UHR3?=
 =?utf-8?Q?2nwlu+u0BG9rK7HObGoJXVO4n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e575384f-6260-4656-1727-08dca76e49da
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:12:10.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpe4oEDjFukONUQRE81p2UIHeuSuiZcPTIM6KmIDaYqeBzY+aa4LhBPKeoJy4u5CVmm4sUtWXaU4CR9/+UMggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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


On 2024-07-18 17:05, Philip Yang wrote:
> This patch series do additional queue buffers validation in the queue
> creation IOCTLS, fail the queue creation if buffers not mapped on the GPU
> with the expected size.
> 
> Ensure queue buffers residency by tracking the GPUVM virtual addresses
> for queue buffers to return error if the user tries to free and unmap them
> when the qeueu is active, or evict the queue if SVM memory is unmapped and
> freed from CPU.
> 
> Patch 1-2 is prepration work and general fix.
> 
> v2:
>  - patch 3/9, keep wptr_bo_gart in struct queue

The series is
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> 
> Philip Yang (9):
>   drm/amdkfd: kfd_bo_mapped_dev support partition
>   drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer
>   drm/amdkfd: Refactor queue wptr_bo GART mapping
>   drm/amdkfd: Validate user queue buffers
>   drm/amdkfd: Ensure user queue buffers residency
>   drm/amdkfd: Validate user queue svm memory residency
>   drm/amdkfd: Validate user queue update
>   drm/amdkfd: Store queue cwsr area size to node properties
>   drm/amdkfd: Validate queue cwsr area and eop buffer size
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  14 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   6 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  24 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   6 +
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  61 +---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  19 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  79 +++-
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 336 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  12 +
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   4 +
>  16 files changed, 489 insertions(+), 91 deletions(-)
> 
