Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2564ECDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 17:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E6210E040;
	Thu, 12 Oct 2023 17:48:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE5310E040
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 17:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F524lcu8NuWyPZSQBmUFjUoMKz50fS5KyBMVhN8r0dDpqKTkzOQBnOZG91qGyLumUoCDxsHIYoPlQTMZz486dANkNdZFq+4nAtWp9akS6/JAlFZyEPqbEDStYxsMGRiRf8Lhfzjf0Qhn+H/5R5EmHWNXpI1nNkJMRhN+Ju3cCr2c2XJGqpjqYYTwqmEXYeifnlLOKjLQZtcr/B1md3jYhCYc1TerEuXW8SDC0sBjbdAnjkYhkvUPkhHu15rQPSd7P0byuq0MFhiG2SoqLZzqoMVKhQHDlXnxt4ECyhqIxcga5x0MB9aH7E+kgkZT/ug+gXLmKMnVKtPdCjO0fAv3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdXj+Egtmie2LKfVi/0tVLZOkRGKb0A++09sHPakAfA=;
 b=PFYisfM5JqyGtFw/1bpK9KHqnHiOpOMx/OJqNdR+g28r/QRmgD6iP7jTpwp2AaA7wExT0vCjLMih/aSzScS4CVDX8jaD28AWIXa64ttLXh7RQIa7GiVuMtVX0vgbUrYsPtZRVAYJwy6u6qAlMAr3pmH5sr5KCN5JmlUL0skETp8z5EunNfH+mQKgk8lhe81aJRH7uyNS9klqz2FoFQgi+Bku/JxBf84FFtPXuyioCJ6wU5Awfq05m/iwlWUbWlZAuUddUofBvDZ0TSAW8rRmb09ZrddOVIk/i6G/GrSh9HODHWsV87hc2ILvOvmIF15oaacsW2aoEy6K0fZHzZzCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdXj+Egtmie2LKfVi/0tVLZOkRGKb0A++09sHPakAfA=;
 b=TgpZ5dlmQnA9DAdcViZwMpy4hb5kPRxH9dbddA5YppUTlCOUqKK/9dMODhXYVYfv+BLF45sb8Tlz+sdYy3k6BIwmt37CJY3ncRqT3bS8vqm8un+nS7RJEkpwi9KrHoUwj0jYSfWVd0ct2MxIulEtbwGfM1SkeW/lQXB54MjV/f8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 17:48:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 17:48:49 +0000
Message-ID: <b8d15aac-1761-4ba9-81c0-bbf8ab43c0ff@amd.com>
Date: Thu, 12 Oct 2023 13:48:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Correctly use bo_va->ref_count in compute
 VMs
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231012163402.24058-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231012163402.24058-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 214c33a6-6709-48c8-41cb-08dbcb4b7dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BE3CY3AtZfmCp+jIBHszLKL90pK02VRcxJVB2nEKvLyV4LMhuOMsk7/pjxEaEr+0WbPnVoAg/J3X7tV/l/b6FtOZuYKd609Ntj6hSUJI2tUssKqUkHz07KV8eb41dzS+4a9Wbjt7YYCy5ucm1Fe0mEMYCrWtbOjQ76MPaarC4Y1Cq/dy8Yh2b0rFDkxK99+aM8rGMGgyMFUikXeLaunAhHNJl8ThNQGvp0bdUtqSMaUg/5PKXuNiEtekvGIwv50utrG62PiLvXK8IRTGxcBMFj8fBPnZBW0yox9zaYDAGPjpnyvAW1Jb/I9z3VdoXI2rOxHUT0/9okLSJoXocxBERLfJoImuKWKlYvEUYzFpKBQID5DJehNwewMPDC7NVFEpgqHUfV5WMdnrDLOJ+l8pNjakS9H42VGLJhITaHDtudMUD9BKRr4hPa73ZFsvp1HgdOmdLgYgxgf1JU56KGUUfHQ5QjM4jGP8VAl5tv53/eU704M3BSq4SpJ9w+hIFwnAYIm2vj3LWYuzoFsm2os6C7NRIro0iqxC3xoxr7w/iHIAJBEdKKt0QdZT3PvRHWE4INJ3xG9iYup+TPvazekW+ALA49/PJWMfrXmpgWjOK3dCOVcw61EovT9Nm2X1kf3pVSW6IYCYt2SbSYMQrXhDcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66574015)(4326008)(26005)(8936002)(8676002)(38100700002)(31696002)(2906002)(86362001)(4001150100001)(36756003)(41300700001)(44832011)(83380400001)(5660300002)(6512007)(6666004)(53546011)(6506007)(6486002)(478600001)(31686004)(316002)(54906003)(66946007)(66476007)(66556008)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hXZWxaaUZOb01ldUo0YU40UFJEZnRtTnBsdEZVdXVQLzF3YmJ3ZWdneHps?=
 =?utf-8?B?V1RCZW5KQ3dScHFNZ3ZieXhyTjh3YUFOUGl5MnZkaWRJVGtSbEd5Z3hEWW5t?=
 =?utf-8?B?VEpFVFR2VGl1WHgxZ3pFZDFlVjUyVkdyaEc3amIxSTRtV2RvblpxQm5MVTh3?=
 =?utf-8?B?ZENRWlN3dUtrb29ZT2dCTzhlTFZJVGsrUElyVUZpTFBRTWNzeU9nNXRta1hG?=
 =?utf-8?B?N0tBMTlseHpJWnlWcTgydUZxa2cwcG5PSVp2cEtVY1huRlRkS2l3cXdIRTJU?=
 =?utf-8?B?MFVaOHJXZkxvdzNXS1RyTnVMOUFJSTlYL2RpUUxVSm5DOUIwdnBPMWpJWEIr?=
 =?utf-8?B?TnlsTHFRZlpHWUVTK1NhZ2xjQ2hPMFcwb3BZbmo2bzc4NWx1RUJVNmhpQjlN?=
 =?utf-8?B?UFQxRWhZYjNJNkR3SUpqK2JBc2JvN3R4ME1BbmFXdFFjaTFzSjJ0aC9zYXBq?=
 =?utf-8?B?NlJoN1hScGxUMVozc0VkWTBTQmpaN1VGRnd3Sys0NWFoZmQ1cm1mV1pZVmtx?=
 =?utf-8?B?d1lsNnNMVG1tQnRGbTFlWk1mQmFvUCtNT0lGVU9zTFp0VlY1VGpkN0VsVFRr?=
 =?utf-8?B?ZDdCVVd3eU5hRW5OQXNvUXlZQWF4NUdsb1YwK0phZEVhN29nRVc3bzNEcUtt?=
 =?utf-8?B?UzhrNmZNV1B4Y3RER2V6SndpYzVQdEVEZEk5Y1owQWxDRm95Rzd1VHFoUGVi?=
 =?utf-8?B?Si9teCtKWk5Jd21rQ3RTMDQ5QmRyaU9EOU9GNERabGFTbXdWZzk2M3QzM2hQ?=
 =?utf-8?B?QXRBUkt4a3MrWFFDQlhYZ09JL3Q4WnNmZXpVeU50U2JrUTUrTzk2bWxJSHM2?=
 =?utf-8?B?MlRkemJiejg2UVd6M0lHWkNGWFIvWTVOdmpocU92WlMwRWUyN1hJaXg2anFp?=
 =?utf-8?B?NUZnRFk2UUtPQXVuVlJnQnQxaWZjckdVRzlVRmUwdVRlVG9ielYzeFo5UGY0?=
 =?utf-8?B?ZDIyK085QzNtUnJ4ODRibS81UDFqdk8rd1ZFVFhoODc0NzNSTU9jTzRVNWRq?=
 =?utf-8?B?UkVha3MzMGRNbndKSFVkTnJlVTZzcUx2T29jQWg0dnVCRjBaYlRhc0kyMUNr?=
 =?utf-8?B?d2dtcU1GRFVac1M4c3NsZ25SUS9VbmpyRWhITis0T05CakRQMUVRaFBGSlV6?=
 =?utf-8?B?Q3FNNU9sUjlYMHlwSVd3dlRWU3Rhd2w4Smw5YnExS2NlczVrQkhWS2VsS3R2?=
 =?utf-8?B?ZW9ORFZRSk16NFhCTGNoeDZpZDlnQkVYLzBuNzVDNVBvdXc5c09TWHJ5aUhv?=
 =?utf-8?B?MnE3U3lUMGVkL3VlUVBVSVB1dFh2bDY1NzZ0b001NGVQc292ZTBuUzUvZ1J3?=
 =?utf-8?B?RDNVZlBZL3A1eWJCQWEvWHlXTjJCSXZna2JxVXRDa2Y3WTJuT3JINGpVbURI?=
 =?utf-8?B?RWthZnN0Q3dwUFRmOUVBNTdzR3ZOOXpqMFpCSk1lTkpDRUppWUFENk5hdTdv?=
 =?utf-8?B?WUdjN0ZERDg2SW1qMll6N1ZGWGxRNTI5NVFMKy9KUG9lT2xvVW4xVnRHR2dz?=
 =?utf-8?B?ZjJNZTdYeG1IYVduTEIrbmFpYzMrdzBkaTE2VXlROGxSZTZSRTU3Zm9VaThp?=
 =?utf-8?B?bWhZdjZ3dG5MemtBSjhYcHlHYWJxTU1rMUlCdVhIR1lydW85b0VNNUpGdkhI?=
 =?utf-8?B?eHlLc2F6YXFlWkduNUJuZm9tQ0QreUQ1QnUxNHhXdGNWd0MyWVpuOTJzY3RP?=
 =?utf-8?B?MEl1N3ljcStQQzFzMVRXbi9IZXp5a2ZwS0VvTVBOczQ2QXZYY2VMU0ozejRq?=
 =?utf-8?B?Nmt0Tm1TcW1rOTAvOHFzTERmTDF6cm1QWkIzQUFzT093Q2NLSTBGSVJzWmpZ?=
 =?utf-8?B?T0hzekVWck1Jc2JxWGI4SHpxbGxqQnY5djhMTzdiL3pHN2JpWjZ2QzR4dlNV?=
 =?utf-8?B?NzZ2akRIRnVMblMvVysxNDlyMU1lcm5adGZqUkk2WGxEdVBnaXhXZFU3QnlP?=
 =?utf-8?B?WmkwaS90SHBpLzFmZjI4cFhBcUQ3Yzl5QzF3WHNpc0tENjZEZWV2MUZjNGpQ?=
 =?utf-8?B?cCtLSlBnZEZUanRDTXRxM2M5OE9FSUh1SkVreHVWbVVsVC9ZZXh4OEFJN0Fu?=
 =?utf-8?B?U2RObks5Y3A3TWdWTVdTTDZ4a1R5RTZDdXEvQU4wamUxcW5BSVM2UXVNeWZ0?=
 =?utf-8?Q?qeqtWyY52JS65OeEuW3KoSXEH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214c33a6-6709-48c8-41cb-08dbcb4b7dd7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 17:48:49.8612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNTRsPjx7NQm3ADUhfoK7pNG9zhbe5tyL/6EJyB423R974ZTo932Ys3K+dd+cwJ3VBzwfRLnvi+7rbSiV1242A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
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

On 2023-10-12 12:34, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> This is needed to correctly handle BOs imported into compute VM from gfx.
> Both kfd and gfx should use same bo_va and set bo_va->ref_count correctly
> when map the Bos into same VM, otherwise we may trigger kernel general
> protection when iterate mappings over bo_va's valids or invalids list.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Tested-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

Not sure if it makes sense to add my Reviewed-by, given that I mostly 
wrote this patch. But feel free to submit this to the branch.

Thanks,
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
