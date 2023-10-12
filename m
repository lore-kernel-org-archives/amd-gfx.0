Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4051FCDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 15:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C529B10E4FA;
	Thu, 12 Oct 2023 15:20:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA36010E4FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 15:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyShsXUbHYjynmsQ90pYcO1bRr145sXH5fs01bbC3owH/LO8FEEOipw4CHpGRzALFNwLjEEp6LOb3SFR9h+itAmic7er6DWV6OnfOP0+hjc6D8zsQ3MZ77Qamul8bb9xOMN2J0hLTgbASDI4PofjkVWDQ28qRyxYmqUVGp/b5TBM0zwIVrzAJ4b93fFmamQO3xwm6dFDGVY/qUv8dQEmanmPwgsp0naR5JFrvnmZwvwj6UM5nADfxRTcv1YhfSUaAb5pPosvj8TvGWAUXiAie+34edzwkhZnvRYbox0Xw8MECD7UI9G8CIyApfY6IT04YOAC/+TBs6z4k22upkBwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7YlK4JaDVihKj0UUE0AkQkCCM7K4IKuRDlldzey96g=;
 b=m0VhBtYls9V10cwXWtysYzeDQrpEs49tSGUNBVyO9hYJCqWwlfbQUOPiZ5ZyPeaH7rktNH9C0UnSBmVrNmyMP1/dNLML4Y6O63raojFSkvaAT+EkkxKcCDXnD86RX4RXsyh9WqmNolgyKBLzWhNo+0T7auw12iXh+wT7NFrckJeX37k9zGIUOhvZcQtl+5qHbuhwBdn9C5698Rjumqv8aSsL+UGrNOi9OgD5k2MyoZjcqr5CdY3ZFO4ESK9RHmKSgRTZrsUDoaeD+lu/eNCKKziIEaYZoSM4AaZtSiCRBJoEPcnuOvMmDww+6JoZ/AxWwvkSSWj6kWsseWmQAPnfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7YlK4JaDVihKj0UUE0AkQkCCM7K4IKuRDlldzey96g=;
 b=YMJeviHXR5xIFnzAf5u8JkhFCHxkV5o+svc/GCzYfdFJKqzuu98m0J6ihUB7ih8E7xiXz80noAZ18///+FkoP08FL14iCKM4njYgD8V1+Mbf412Gh9qzbqZaoC6JcjN10EbgJSKbSDNbkYNVRTut5yVmJbYn11kTf8SAEod1/ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 15:20:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:20:52 +0000
Message-ID: <befb06a4-a970-4251-b195-50c0cb375b25@amd.com>
Date: Thu, 12 Oct 2023 11:20:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Find bo_va before create it when map bo into compute VM
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231011233630.32205-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231011233630.32205-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6fabda-4f63-48bc-0880-08dbcb36d2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH10SD6ycIyw37UpdtIuHalsVGKMURVISAP99wfoymclXULPnEDi798OikKi56RPpPHSZteinaHzcGEltk3VFehaN77At6ONTG6QsM6Udwt6H6U3BLRh5XjLE4mGdS3U+zG8OK0VE6Wv4VN9NuidpONpkiuTalc+W9YAMtP60nbpkRqO5hbKLnP1mqSrrHYn+NYRObKgDPRQCy6e6CXn7J6T0LLpNer0LVTPiG+aYc0nVhFkfmu8hK51ydlJZ16vdBEsgdoJ+jln7N6LcFPhXGHeJuCLJRJ/EOguD7rGxV8+8ID8xwQWpeciFf0W/oSa7RxtVxa7IrdRl6izT0unXG5FuQMvra3zTyeL0AG0G5cP2GvobrbeaKjjzNcbu3l4uZVXTLZULBBwwRy/nLfguFYLyUmzH3/g/Q6cz5z5Pbr4V9/VRSgCw7WmTkYZ8npSlv/mue1gIZDZ3K3zSlz7zkJ8FwVWRTo4cDSMI+3LZWGf1RhegnmqK3W8/NZ/2El6ojsEtVq8OtVRysyFGu0lWa7IL/aklB+7R21Xwq+a7vhEpHwvsHKAXO57/BYTFFARj5J4mIF/lGNiLax0hpV65ynEq/FUhXHVgWebY5iEAp5iDG4Ir//eL87Ep6n8Pq+ccbhnPrVO1EyT9TnAqPICZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(54906003)(66574015)(36756003)(5660300002)(31696002)(478600001)(6486002)(86362001)(53546011)(6512007)(6666004)(6506007)(38100700002)(66946007)(41300700001)(66476007)(66556008)(8936002)(316002)(4001150100001)(4326008)(44832011)(2906002)(8676002)(2616005)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhvOEh4T1pNMHRydXhRT2lzZ2VvU1VDb1doemFSLzRaOU9XTGI5bTM4ZDYx?=
 =?utf-8?B?TEgwRDZ4TGlDQ0VTa1lPYWhRTFR5MW8zRnovYlJvNnYwcUlTTWlzVGpFRXZC?=
 =?utf-8?B?cFF4VWJKd3ZQcDhHaGQvdVBOL1FXZGZXSWQrdGY4RUhOZ2ExNjFyM1RSS1o4?=
 =?utf-8?B?bFJVenJQQWkvYjhCVDhrWGp3TE9FaHNmajZxakl0UmZEV1Y4UUFiUklJSzNS?=
 =?utf-8?B?QVpDQzZjQTNhOTdTR2pLck9PMXVKM0tIMURscXFWNlJiRnUycW4rMVhwM2FZ?=
 =?utf-8?B?UVhCVEtUeHA0UmJqbVFJMFBsZEtRVW1zYTRERjdFbGRhdHMzUnZJOHdqTWYz?=
 =?utf-8?B?QVlvWnZteGs2dnY0TklVaVlHcnEzWVp5QnM2TjJOcld2bCszckpQdVdIdVd4?=
 =?utf-8?B?RHRYSENGY281YmhseHdseVRnaUsxb0w5Um1lUVdOMU4yS09sM3I5cmZYelJG?=
 =?utf-8?B?Q0ZQRmV1QldYSEdqT1ZVTUxoWnhzVkszM1IyUVg2b0xSK21SNi9pSUVuazRa?=
 =?utf-8?B?dDdsQkxBb01VeFl6RDlLNkgzM3dELzVjRTAyelVFVkgwc01hd0UrdE1rS1BH?=
 =?utf-8?B?eXdtOHBaMThjb3grYnRvUmlRZUNKNXFBQUdGMUVZVUh6VVZOaW9TaER6M1d2?=
 =?utf-8?B?WkhZdkd0SkM5dUhmb3Z5dDMvbFlKOTdCaitqZkRIQjRGb2JKYm1CWGtPUlBy?=
 =?utf-8?B?WjUwY3NibFV4R0xDbEFhOGRxSExnVUpsYzdva1FhcUhGWC8zVjBCcW5nNlox?=
 =?utf-8?B?RjZGcXVJSmRISUFTMTRGTFJ0SGh0WjNWWGNiNU9yTzloQ3VsaktiaWhjY1Vu?=
 =?utf-8?B?M0VaVG85amhFSkExQmFxWExTcmRKaFhROVFuRUdkS1J3U0kwakdqQm1wSVNR?=
 =?utf-8?B?UlVTZ3F6LzNaSTJOYlNiQzVLUE02ZGlHVzJVY084cEEwV2MzK0paNEpWR0Fa?=
 =?utf-8?B?VktISVZObVV4a2E0ZW0rT0xwandiejd3YVJaMmdIQzV3RFBKQXJVSnFMcG9k?=
 =?utf-8?B?QzdlZG5adHlCVnJ1aXNJQVM0R09MWUQyejZrdG4zRXU0TEVNQzMvcFRZVTh2?=
 =?utf-8?B?WnNjNVFXb2NEKzhGWTBROHpnVlZnbURPRmY4MTVscWxuRmovT05sak1MSzBr?=
 =?utf-8?B?K0g4OUE3MDZaMDhzRW9OckRJdUpiMVVpbzEveEEyY29zUmR4c2lySG9vLzFJ?=
 =?utf-8?B?cEQ3blY3anpwSGkzQm1kVW0zSDJ6cmo3bUhmZWtQcTR4bW1TcFJyQVF3bEMy?=
 =?utf-8?B?U3JQOCtSMlpIMkpSSmtBQTk2NlhQUWs4UlllRGdmRWR4R01TMzRjUzBSRHp1?=
 =?utf-8?B?eDhTbVF5c2ZVMDNVekFENGprenNLY1k4NHMzVDFMMW11ZWJPdDdpbWFFa1NG?=
 =?utf-8?B?NzVYeURjTUE4dWFpb0FSZWJ6UVBkY1FMQVBXK1ZhNTRtRm5FUmVkYktHMW81?=
 =?utf-8?B?UE5hLzRXVVh2RGNFOU9kSllsSXEyZGFDam9idFFJdmVLKzNXbUpmZWhSOVNZ?=
 =?utf-8?B?NnQyeTMyWkozQTdEWFY1SGhPTENuV1d6WFUySytFbEthaFRIRlkwS1FMeVdH?=
 =?utf-8?B?SVJEMVQyRk9hcUtIS2h6bGpmVzhPeGZrWVhPdDg0YzQwZ2VEV1kwTEE1Wjdk?=
 =?utf-8?B?SWlqZWQ3T2ZmUDF4Q3dSMy9FRmgvMzkvRUtrYkxYWUovV2RpQzJodEl1U2JG?=
 =?utf-8?B?QkRSWlduVkVHZFY3S3NBWWoxQXI4S05VYi8vaU4zWFozT0RFNmFsTHJDU0lW?=
 =?utf-8?B?am1lYlFpc2VVMWdPOHhxMWozblVlcHdNcFNaMlE5ZWo0MlJ3NlNzYTlZcmJE?=
 =?utf-8?B?a00xM1FRbG14N3hadW1KOFdRdHhJNVEyWHFwV0k0aHQyL3YwazRNV2c4OGdl?=
 =?utf-8?B?Nko5ZDBQcVhSNU80YTBESXZBN2xwMFdCR2NkWG02aVRORk1LME8weS8zbG0y?=
 =?utf-8?B?YWJ3cDBadkx3RXhzaENwenpDMVJHWU04djZYL0lvcHFCZkpNMmNpTHA1dHNy?=
 =?utf-8?B?S3hjNGUvMUdjMmRWU0orRHNrbCsrZmJHU0ZIUGZrbEVRZ1RtT1AwS3Q4WkpT?=
 =?utf-8?B?cDJQS2VQaWJHN0FGY3pkN2VPRmxPc0dLWHVJRXZRMzJMNTdsN1BCSmxQWGdJ?=
 =?utf-8?Q?uLf5vqNAjgRpBNb1aMdT6D/ZH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6fabda-4f63-48bc-0880-08dbcb36d2b0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:20:52.7552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwxbQlaXlpHhu7RFq8fQ2tHdKAwUrHjdBsRS8HJ0kS5HGJbXG/oEdQeN6BFJrJCz4dWd5T2m37Yroy8HqxqnIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-11 19:36, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>

Since you are the author of this updated patch, you should also add your 
Signed-off-by below.


>
> This is needed to correctly handle BOs imported into compute VM from gfx.
> Both kfd and gfx should use same bo_va when map the Bos into same VM, otherwise
> we may trigger kernel general protection when iterate mappings from bo_va.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reviewed-By: Xiaogang Chen <Xiaogang.Chen@amd.com>
> Tested-By: Xiaogang Chen <Xiaogang.Chen@amd.com>

You lost any mention of reference counting from the commit headline and 
description. I think that's still an important concept that should be 
mentioned. I'd change the headline to something like this:

drm/amdgpu: Correctly use bo_va->ref_count in compute VMs

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a15e59abe70a..c1ec93cc50ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -832,6 +832,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	uint64_t va = mem->va;
>   	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
>   	struct amdgpu_bo *bo[2] = {NULL, NULL};
> +	struct amdgpu_bo_va *bo_va;
>   	bool same_hive = false;
>   	int i, ret;
>   
> @@ -919,7 +920,13 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			pr_debug("Unable to reserve BO during memory attach");
>   			goto unwind;
>   		}
> -		attachment[i]->bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
> +		bo_va = amdgpu_vm_bo_find(vm, bo[i]);
> +		if (!bo_va)
> +			bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
> +		else
> +			++bo_va->ref_count;
> +		attachment[i]->bo_va = bo_va;
> +
>   		amdgpu_bo_unreserve(bo[i]);
>   		if (unlikely(!attachment[i]->bo_va)) {
>   			ret = -ENOMEM;
> @@ -943,7 +950,8 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			continue;
>   		if (attachment[i]->bo_va) {
>   			amdgpu_bo_reserve(bo[i], true);
> -			amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
> +			if (--attachment[i]->bo_va->ref_count == 0)
> +				amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
>   			amdgpu_bo_unreserve(bo[i]);
>   			list_del(&attachment[i]->list);
>   		}
