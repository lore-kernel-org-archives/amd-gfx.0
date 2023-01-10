Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F18AC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE0E10E5DC;
	Tue, 10 Jan 2023 15:32:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA14510E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXztTVtm+zK+bqQ2PfWcB3u33K9gHS0uH/7M2MaqR1DC5+ybXWE2zeR03+din6knCDyCrE2W0IgO+Ewvoxmt6jlPJJKRPgkRzWVo3cVmuj4d1WgcbS3D08L+E5qrTu1cBaJQY05WZeYAgr9fzpsgYCMKzGisx3l1/sCF7bzuV7t+rQUmuTfWFRksBRNoGSzVS3IKo7jjlm0YzQeLwQK6JJOksUP8oHf7vZWySTW+T/UaN1GIZ5w0XGYqWH2IVpBdVteMIuYWevZo6ySkAiXL74E+nHoXpJder1sWUvYjOQL2GaAGA1sK8ORhBV96KTDpJJpWpWgWoGp5T0bpMya58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YpwWl4rGQBvfhNBQj4ipKSe+4dbwouNGDFj6XUqyKY=;
 b=WPSwlY1v+Mqn4jwnM3qdcYtBkjbitXDo24WFmrME2ziRSurmuks7h7K4CnObObqFXOM/j1xYJ6jnEbj7vtr9l4XqyEKRqF9nhy/zIe2g93nVnHJ1yp5oxE0TTclOCQi6LXepByRCI3ylAiJRtj5jMxEkp0lthI40Fe9fMQPCI/8ejimvgwqkLKBgDfR/XlePJ+jqSl/54Os7wThTltPcFnISjlvbQDtV9yd9QP9aJ+xNHlWCane3iltNhwSPpNjKMaNVxxkRq7G7z3/pxbpyPYyXy0o2ic449t9kAV9zIw9sIf8lcxxCCiW8g6I9VNGF/xwU7LnqnUCFDZzfm6+ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YpwWl4rGQBvfhNBQj4ipKSe+4dbwouNGDFj6XUqyKY=;
 b=n7uf6yeQGBcth4LIw3tEKPbsCd/txUGH+GJD2CrFRV20aJzkNvzTk8MyOrbGGmwRZbUT13JaEYBWFJsVtsbfK/5G3W5dk8U9pK6HWnOzOY0Lhd9uaaq77q0PLCs13Ud5u503Un2VVkLo3vI+DGIV0WB71AVmSzmssZ9Rk5J29xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:32:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:32:14 +0000
Message-ID: <b040c027-0b22-d94f-23ef-3bfd8cac5ec1@amd.com>
Date: Tue, 10 Jan 2023 10:32:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230105192825.138353-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230105192825.138353-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 255b7eec-a5bf-4436-868f-08daf31fd950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7PDMu1aQRStf3oS3ggTCcj8CSt0bGqDAGTvknfCnyV4YL5IEIVsIxDOY/HE5k2IcThd6mswN6Eenmgh3ZPhj2AnJUQgYJUKl5sfJVDS835ZIJBH884z5msJuBwfAWxaQJg7koQYnrTFgZaYNQJdgZdLm0q92bMfNu2KRArGK9CEX5MPNI0ps4zrhf8WSxWC+fHnWII6PPC8KB3KeO0n8D3+aItxticohyi4X97Xv0rOgtXRq4JiPWVwptKVakPqlj0AfwavM5glYeYdgRsysQZpXgFRJPGTOik/4/CsLPPOZQ8+zrtHdMCSGXW5e0C791pdu+4VJsr+dpSmK4lXSyByJPMp+x/LUOpH80n5ovdbkAs3CI5Tp/8hvlnoVNmYYWR60PO8r6MsiILIwnSwzH3NvI1uEkS6viLUjLjOE6bQOCN/vqhjp5+h8qyrdoSP7LAwBCiMSh/4+5CT4ZptWLNpbD3BC1y5RYuMsM+t5HnyPHAaDvJAWvJpNZwVy11qBHMv8yXju70Ns9GAeH2MYpMHW42PKOaFVSxc0iDXyv773rgUHRC3Qc+xLYfk1NKm8tlw3AsY17mq48Io0cBgNwzikfhvYdNG8HP3vSw2dX04jYDXGVZ4d+kcxCCOpO8a91wKhSkMcskvRT8So45gL5ghMEb9LE2XHLxQPUAmsRbBgPSWcEVlQraJvtPmGRA5omPfwl1sYznlZ7/sb5WVa353TPpQd7ukH9Qy2XFen48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(316002)(8936002)(5660300002)(66556008)(66946007)(8676002)(41300700001)(66476007)(36756003)(2616005)(38100700002)(83380400001)(86362001)(31696002)(6666004)(6506007)(26005)(186003)(6512007)(6486002)(478600001)(31686004)(2906002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29pUUIxMlFhcGRpSXI3RDh2SDRHRlVCSFdTNVNVMGJlTXpMUEwvYWFmNjAz?=
 =?utf-8?B?bDREMVFNZFp6c3U3eEtHN3ltYlYranpFb29VZmh6N3FyU1hiYlZyZytHZEZx?=
 =?utf-8?B?Tmlvb1dpTHdva2Z6clR5Z3dnS091WlBDUTljVExDS254ajBadTIvM3JuR0w2?=
 =?utf-8?B?TE9LdytOS2gvRUFTWGJiWE53MnEvVHREV0ZIK2RFQ1VBcjZTZ2R6ZS82REcx?=
 =?utf-8?B?Q0hpYkswUXpLY00vSHEwSFlkMStEYW9GYkpEaUUrV1VSZkpTS0doc2trV3kw?=
 =?utf-8?B?ejVjS2graklTNXRZRTNWM0grak5jWWFWWS85QUVvNnZRUUovMjE3M1dDSkE0?=
 =?utf-8?B?TUFqbEZtSEh3VGJ4NElzWFEyTWdxVURUWnI0SEhkRk5lM1BueTIzNy9YME5X?=
 =?utf-8?B?eW5LZ0o5UXBTc0NERWY1RGRqQUVsNTJEbXBQU0VUQzNta2ZpYXA0T3EyZGtL?=
 =?utf-8?B?dWMweHZZaEQvUUVybWJrcENaa05VSDdwZG1BaDJWNTVCakZaZ3R2U245Q1Vw?=
 =?utf-8?B?VHJkNllqUGdMVzFjZXlvdFFmUFdkamVhTVg0VUZRT0hRTElzVzZNbnZnakdj?=
 =?utf-8?B?QS9SZzJ6YmluSGI2WHNpWG5HRmltczRTWjc5ZnJNTmJSdTBiZXNSZG9uRzdM?=
 =?utf-8?B?TzJ0ckpiOUpkZjljeEk0ZjZlWHEzYi9KWFFyaHBWaVhiYUVHKzRDdlRFWWMv?=
 =?utf-8?B?SnYreUdySUZoM3loaFpHRmUrMHAwUVZjL3dZQWZTdlhnM3dyNFJYNnlTMTNn?=
 =?utf-8?B?WHpMdm5ma2xaYkUxdzdnZ3lKaExKK296TUlRcDA0WVNQRllHN2VFa2VLYUJL?=
 =?utf-8?B?UElNb0RXOWlNdVZFelNlazUxZnpTaHFld3pmbXFpL2hzTFFrSHFjay9jcngr?=
 =?utf-8?B?QS9EczRzd20xOXRwNWRVTjBObjBUdDdKbXBqdDhIYXpDUysxZmIxQUlTUy9i?=
 =?utf-8?B?Q25WUkJIc2lMVW1JUmtTbkU0Z0xMZG1CRHBBZElLb3ZLZnhTalJqUWhIMXdw?=
 =?utf-8?B?dFVsQUhIN3hMMCs2emFKaCtoT1oydlN6ZC90aHpLbllvdEhRNmVnd3VCZkNQ?=
 =?utf-8?B?ciswM3VNeEJjK0t2UDJ5amx3SzFPUFpoemtXWUpvMmVpVkp5S3grOVlza3lG?=
 =?utf-8?B?WTZlZmJmWXpOcGxtTVVieDRLY3o1ZFpWTmlSOHBUSXZWM09mcnNHTnczYUpF?=
 =?utf-8?B?aStmdTA1em9zUjFKVkVpdXVLdjd0bGs1ZEJjb3YwR3BrWnd2cjZONXE2OE1s?=
 =?utf-8?B?aFgzR1dWSlRoWUplckx1Y2ZWRy9ON3cxaklpRUpzNHg4ZUNUNDM0d1ZrdWpV?=
 =?utf-8?B?TmtNVisvRWFMcWlRZG9zYjROWGl3bXBhVmt3NExHSVNRU1VkcVdES1NEV0Uv?=
 =?utf-8?B?WURwdlJsTnVTc0tMVXY4Q0owTGVGckE1VDl4Vm13Wm5UbTBydmxERFJkdlhY?=
 =?utf-8?B?R1lSNUpWVGhVRzZSMWt0TUMwR2V3TndBWFEyTktzV1JxZk5XMlIydU40TG4y?=
 =?utf-8?B?clZ3bER6dytmejY4NktTRFNPVEErTElkMlNGOXNSZFlVL2lXcStPK2ZVYXdt?=
 =?utf-8?B?U21TTkI2alFYaDlTaWhKUU5tK0pLWkpVVEtjSkIyMVFYTEhkQXJVVExOc2lh?=
 =?utf-8?B?ejFmMnloQ3IwRmtOdWMxdmNzYUl6R3VxeTVrWGovZzdtMnZBU2N2NC9Id0NV?=
 =?utf-8?B?SzRMbnJzTmM5dnVERXRkd3EvY3dwMGMzQkg5K25mSkFsYkE1Tk5XU05nTXAv?=
 =?utf-8?B?dmx0cVRHK3RLdTh2Si9ldk1SMVpyR0RuUlpqTFZYQVp4NGdzQXFYc1UwLzRM?=
 =?utf-8?B?UFNjSFgxc2tuUUdyQU1relpqRlZoTFNNdlFwWmNNOUNpSXBBOEltQ3VwU1h4?=
 =?utf-8?B?THpwQkNqcW5JNENlUFFwaUdIeE54Nk5aSUxJN2VkT041TE5leEhlMm8rcElV?=
 =?utf-8?B?d0VXRUhSdmp1QzFWYW55b3ZJSnJJaXRTMDR4cmp2MjVtVE9uSUlKamRaRnZZ?=
 =?utf-8?B?V05lV1NiT0xaNG9ZQW8xeFpMWFVWZ013U29nVUhuMS9BSmIwVDZPRlExMnlF?=
 =?utf-8?B?b0ZyQlBIdUNaVjE2L0c3d3Fzc2pma2ExbXhTQVN5VnJXY2NTZVVzMzVMbnVj?=
 =?utf-8?Q?hQstkhl+o0LzxJbrQCgM1OkJu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b7eec-a5bf-4436-868f-08daf31fd950
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:32:14.3115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: impRa0iDUP+YTRUO+TsQ5shtU8T0nQTB1pZGQJ2U1GGEKFZSNEDkuVayqyiA+A1ry3XfwuZpigb5IHZTXC8LwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

Am 2023-01-05 um 14:28 schrieb Eric Huang:
> The point bo->kfd_bo is NULL for queue's write pointer BO
> when creating queue on mGPU. To avoid using the pointer
> fixes the error.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 9885735f1a30..d4c29e9edf34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2179,7 +2179,7 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_b
>   	}
>   
>   	amdgpu_amdkfd_remove_eviction_fence(
> -		bo, bo->kfd_bo->process_info->eviction_fence);
> +		bo, bo->vm_bo->vm->process_info->eviction_fence);
>   
>   	amdgpu_bo_unreserve(bo);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6013f498ea1e..55c2dc48e567 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -231,7 +231,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>   
>   	if (q->wptr_bo) {
> -		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
> +		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
>   		queue_input.wptr_mc_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
>   	}
>   
