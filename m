Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C495C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 15:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4F310E6F9;
	Wed, 12 Jan 2022 15:12:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA6210E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 15:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOnZGAOOvNlmy8F0mIrVlOCWEy0AgUWLe8cc/SY+WUaywU3i9SMWVDnXGV/IjAGqiYbICBzY5ggXH8TZcBfYp2AIrgPOpRkTRj/ALxAGs14y9wwAD+/LquyuCh3jRIjjTxlPpp73hIdYEolpHH8kGSYUCiFgpojcmKK+9j4Yxm6Oyagl49GTeEsfiVMw3bUK9oTr+4NWacCk+T9nf+EEFobLDrKjgH5sWR2A7oGMUsjjBHZwXe4vYokSEGF+2yJBDIGSHelBntWDwjZrAd2FvitLapAw2l7CpfH96MVqfiZGSpxTTApFWOaqhp3r+1JeMwNUqvZ86v+cGt4kecSsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osFZDE8Y+cH2wXiOHlnlOtlZprqE6L6/8oxkzDuFswU=;
 b=fFG13vrzyCfiGgRMEGz/l/u7FLtuco5/R+PSb9bTeScabxzZU/2ZOlHZi3rIENMbgnYkZauEa/Qs83xmcY/IzHUEDSKaBVGVuwh8XoOF73J0g3LiskYw4rBGkMN7kfXxMmrUL/9H2yHoNGlNqCVCCOhNzSCub43kP+zTfImH+gBxWRUfhFVBApq9eWDYTi2wUg7KMrRWGoFmSY8KoMtLoLhUtXGRLAihrjwzMW9ZnPj1KyXlWmA9dsmMs3I1anZcE1Yq8YllydltRXjkqzbnGm61gZBJsC0dhfQM094hES0ELzS5BT2oKBjD479rwknFOw0Gr7eI/KQQW30Vk0xhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osFZDE8Y+cH2wXiOHlnlOtlZprqE6L6/8oxkzDuFswU=;
 b=dmgfhlCuair/abbuBR0riuxnLZONdH3YIjPY+OREbGZXzkawjhMrV25Dw+/70/zZbcPBAfFJAFKYlOHyvsfWggAlKA5+e+5zYaeMwAfxmTv5xQU6AFO8d/AAqhgIeuCHoEDIt4FkMXXrcrRN6qPvxQkuy8OijXOtH3Nbb0FnEqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MN2PR12MB3408.namprd12.prod.outlook.com
 (2603:10b6:208:cd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 15:12:45 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 15:12:45 +0000
Subject: Re: [PATCH] drm/amdgpu: improve debug VRAM access performance using
 sdma
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220104191211.1707514-1-jonathan.kim@amd.com>
 <ba169e67-329b-6ff4-a0c4-e11779f032e5@amd.com>
 <DM6PR12MB31631B4FF1C6F80EC5B3F58685529@DM6PR12MB3163.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <08f4a6e7-9084-def3-43a7-bfb19c5e649d@amd.com>
Date: Wed, 12 Jan 2022 16:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM6PR12MB31631B4FF1C6F80EC5B3F58685529@DM6PR12MB3163.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR1001CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::24) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e55dd9f0-3797-4130-676a-08d9d5ddfcbc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3408:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB340848FC5F8F74572A65936C83529@MN2PR12MB3408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qu0XubWf4aQCZ8LP0Ie4AmXcwJurIMELFkIZXU/mepDiHWAs/pKLMhHHNRfk2TNGs8BPgT4fAr6WKCx0FJ3yJXwAs4b6foMQ2P4v6OSm5TjInV55GnMUuo5WDXf8lsx+HMt9bDDGkWm64oSks8pj6m1YEhZxCHf/Ql1grOxnMQTlABauWFlLfhRrDn2qtxX3Gq0vpTvlJbjJ5eSGXXzDsuEk+7Kd7A1+7dtJomvl6I5OEaLQeWB7cNwmgh8Ps4fiodZ+zxDwhJhtiB6hZg6CHIqTGdzZA0DB8EHTB+GwcUrlhFZZnk7bX4jv8Yn9WTyGH/NFxJ4lX/FbKzFk3H1m+feX84zziSLIYFJnmvbkCqyDNITfB+k2PFWMIB68y77Flrl8+b0ua8DUoSKv0JzGv0S7011h932jCE6bbkNlqJtUDr8jHNlx3e9ly3660J76KkkuC5xW65FeV6Z1tV0lj5lWvnFjm6LmFpp0Akay38uzIToYMehgeVoCWTyxG8j9qAVUXaqSU62f/c4VrDDEzVHdoZceD2eYQKZKrDih8ndaCLoJ5bWfbW9zNEnWjN9ugd6OKn1wAFCEwY9qfeomOa0Gt6eN8lm+APluTgUOWiPtUtsuVZiNH/WHlftJS6/Hv9ph3vPkw4IcCcHA0VbAYNuMc+LHpEHzVaJQbdUzmDFtHs5o3JJgN4bC5chH81CJeEtXw5H3TcKR7U6DbOkPJsg+zBBuLVCikwxrf9/Hg0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(186003)(66946007)(8676002)(6512007)(36756003)(38100700002)(31686004)(316002)(2616005)(86362001)(83380400001)(508600001)(110136005)(6506007)(6666004)(66476007)(2906002)(8936002)(66556008)(53546011)(6486002)(31696002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnV1cTNPWGp3TndRMUR1UUU4aXd0c1VJUk5lNVJ2ODZsYmtwYnJRLzl6SUcv?=
 =?utf-8?B?cUcrVUQ4aDZBTUlkQVY5VS9URCtSNVNNQ1dnTFMvTnBMc25SQllQaUViSW1F?=
 =?utf-8?B?R0NhL2J3MlRYQUdhaHJSVUlTREZHbFNWNXNOMHU1YWJ0dzRIaVQrQit3d0Vh?=
 =?utf-8?B?NEVGZUV1QTNIUEhYYi8xZ0EvQmVVVTVaaFZOSGkxS0xncG1BREVPVUNVNmtu?=
 =?utf-8?B?VVA2VTRBRXNjWDN0TXNaU3VHYzVORXZWL2ZlOFVhYmxOTmVzRWRHREpPRjkr?=
 =?utf-8?B?dTV1NU1pdm9Pays0eU9UU1NGSEVFYytqRWZuekw1LzJ6MXB0cmxldmdIN21q?=
 =?utf-8?B?bWhSbXFlWGNEcTg1dHRNMDhxaVhibzZiNUwrdlJNVzhJSklFMXBhQTdsVEVq?=
 =?utf-8?B?S2NiRTFzN1NMRzJZYUszQXRlOTZPamhnQzJNelpjQWo0N2tHZllhZXBaMVAv?=
 =?utf-8?B?TklxdXBVS2J4cWRaQzBBdjliVXpWMndzVmJNTVFCQ1Jrc3B1WnplUWVsYnVR?=
 =?utf-8?B?QjF2eFpMcW11aGpGRXJSMzRUbENabjczMUIrTjQ4RTRoaXlnMzM4cFpIbHVX?=
 =?utf-8?B?OVE5bllVZXB0ZmRGREJpWGg4VnlNd2Y3cWt0Uk9lWWJLbXVWcE82SmhmSjYv?=
 =?utf-8?B?RkJyZm1jZmVTejNxY01mZ25UdUxiVlFYRWt4RHVPd1llQjRDYktrajM2dDJJ?=
 =?utf-8?B?TmhmL2gwNThqbWF0ZVI0S3FMcE9NVXF1TUdZQW9weVUzbmlRUTh5MDRJQ2hI?=
 =?utf-8?B?N3RMRjNpK2EzRFE5UFBwOFoxdGxWMUZpbUZldDNadXNqcVg5bjlCZkFhQkVs?=
 =?utf-8?B?WTkrRE5rSURrdHdFVE9yQjF6UThkdTdSUmF0bFVEakxJRGhybGZqUi8rMGFB?=
 =?utf-8?B?UGt3UEZJdExDT2lDTXhnVHJUZVNkTHhjY2dJTU4wK3JmM01OSzhTQmNhQzND?=
 =?utf-8?B?WE9kTlpDTDVWU3RlS2hFbnlidERzQlhvaFE0UW9Xc0xBZ0k2SCt5Mk10S3Zw?=
 =?utf-8?B?a1FsQndxZUFKMVJjR1BOY1N2TVpUK1V0dlV3MEZYSlhTdlkvZEJNdnVYVGRq?=
 =?utf-8?B?RFpEM3ZXVUZyOWdRMmxSUFJ3dU91TU5EZWNLYnBEaWhnWGJuTW05SkdqeVE4?=
 =?utf-8?B?bUxhQ3MzMHNyODJLUWRIUGxRNDczRFJENllxZkJ3b0ZnREh5Zis5MTdONFFr?=
 =?utf-8?B?bzFXQ0tUNVl2eVVGVVlrQ1l0MDlhSy9WazhjbGhWYThreS9BaDF5U3dXTllh?=
 =?utf-8?B?Mm8xVnVhTkU5cys2ODFYNE1FcHdtK0ZCS2hlNGZvQ3pJTEgzTVNwVE5jVU9O?=
 =?utf-8?B?ZGhQZXNBLzN0ci9kUUhPemFEYStueWE5ejhWRitObEN3b1BNRXR3TWNWVjIv?=
 =?utf-8?B?U1lzdUhqemtCRlY4Qkd4WjA4OE9NbE1NLzFBa3g4Q3RURGk0Y1hpZ2ZBNXh2?=
 =?utf-8?B?dWFnTDA1NFNrc3BtUjJUaEhLcEZmYS9zcTFiWndDWU83RFB6T0pnOWhUeStz?=
 =?utf-8?B?NUxmMjNDWnltVFpEdE51dTlMMzgwa3ZtSnovdFBtaVp1VzFTaitjeXlhdnBJ?=
 =?utf-8?B?dUN0WUJEZFdKczBCZ09CSGR6cnY5RWcwTENGNDYzUkcwMjNFOG1MbnFlSWhj?=
 =?utf-8?B?Y1ZVckg5dDVSWjJNRXJ0WFVGUGJPS3dEVitneW9Bcm8vdDBRWDRIejJMelI2?=
 =?utf-8?B?TTVDNFR1WTVKR3RJMit0NWttRFhpcEk4NWhBTEF5b0VWbUNXUk1ieTV4M0Zk?=
 =?utf-8?B?K2VMb1hzMzhrR3YrK2Q4MzI4VUJYbDBmb3pSUjJMdmZDTVhWVHYxSFlrLy9I?=
 =?utf-8?B?bWQrUS9SaGtsckpYQkJ1cU90dmlXcStMa3liMXpxMkFnR0xkcm05WVlPNU1s?=
 =?utf-8?B?ZnlITlpaWTE1S0dCNHdYWERIQWpkYWxxTGRzeFA2RjErdXB0aVdocStsSk5I?=
 =?utf-8?B?bnM5Z2tSZUpQWUc0WXNtai8wWFBYbkw4VzFoMmlYeVEwY1VsNDRsY3BuMTVO?=
 =?utf-8?B?OGVmQ3hZaGgxc1d0eDNXV01idUVzeFpJRTYwQ05XRUxRcTJ1bHlhNTBrQ01Q?=
 =?utf-8?B?WGlIaUJXUjR3cSt2Rjk2RHU5N09YVUxrZ2ZVUTlyMGxnQm53bnJzSVZEK3NJ?=
 =?utf-8?B?MmhwaCtjWGJZeHVVaVh0b01mMWhRYzBiNzBtMWFTQjV6YVZKaTBSb1h3ZVVO?=
 =?utf-8?Q?ZtJS1dAuHKTRCuGGmNU7K4Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55dd9f0-3797-4130-676a-08d9d5ddfcbc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 15:12:45.7298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0/DJWMZOjcVG4iMd8Kunw/KtYi86haBQLBJ17bzsyHi5iu2zn6uhuA7bNLrl2B5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3408
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, that's basically my fault.

I haven't even worked myself through all the mails which piled up during 
the xmas break :(

Christian.

Am 12.01.22 um 15:21 schrieb Kim, Jonathan:
> [Public]
>
> Thanks Christian.  I've already merged based on Felix's review.
> I'll send your suggested cleanup for review out soon.
>
> Jon
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: January 12, 2022 2:33 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: improve debug VRAM access
>> performance using sdma
>>
>> Am 04.01.22 um 20:12 schrieb Jonathan Kim:
>>> For better performance during VRAM access for debugged processes, do
>>> read/write copies over SDMA.
>>>
>>> In order to fulfill post mortem debugging on a broken device, fallback
>>> to stable MMIO access when gpu recovery is disabled or when job
>>> submission time outs are set to max.  Failed SDMA access should
>>> automatically fall back to MMIO access.
>>>
>>> Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
>>> page-table updates and TLB flushes on access.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78
>> +++++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  5 +-
>>>    2 files changed, 82 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 367abed1d6e6..512df4c09772 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -48,6 +48,7 @@
>>>    #include <drm/ttm/ttm_range_manager.h>
>>>
>>>    #include <drm/amdgpu_drm.h>
>>> +#include <drm/drm_drv.h>
>>>
>>>    #include "amdgpu.h"
>>>    #include "amdgpu_object.h"
>>> @@ -1429,6 +1430,70 @@ static void
>> amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
>>>      }
>>>    }
>>>
>>> +static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object
>> *bo,
>>> +                                   unsigned long offset, void *buf, int
>> len, int write) {
>>> +   struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>>> +   struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>>> +   struct amdgpu_job *job;
>>> +   struct dma_fence *fence;
>>> +   uint64_t src_addr, dst_addr;
>>> +   unsigned int num_dw;
>>> +   int r, idx;
>>> +
>>> +   if (len != PAGE_SIZE)
>>> +           return -EINVAL;
>>> +
>>> +   if (!adev->mman.sdma_access_ptr)
>>> +           return -EACCES;
>>> +
>>> +   r = drm_dev_enter(adev_to_drm(adev), &idx);
>>> +   if (r)
>>> +           return r;
>>> +
>>> +   if (write)
>>> +           memcpy(adev->mman.sdma_access_ptr, buf, len);
>>> +
>>> +   num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>> +   r = amdgpu_job_alloc_with_ib(adev, num_dw * 4,
>> AMDGPU_IB_POOL_DELAYED, &job);
>>> +   if (r)
>>> +           goto out;
>>> +
>>> +   src_addr = write ? amdgpu_bo_gpu_offset(adev-
>>> mman.sdma_access_bo) :
>>> +                   amdgpu_bo_gpu_offset(abo);
>>> +   dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
>>> +                   amdgpu_bo_gpu_offset(adev-
>>> mman.sdma_access_bo);
>> I suggest to write this as
>>
>> src_addr = a;
>> dst_addr = b;
>> if (write)
>>       swap(src_addr, dst_addr);
>>
>> This way we are not duplicating getting the different offsets.
>>
>>> +   amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
>>> +PAGE_SIZE, false);
>>> +
>>> +   amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job-
>>> ibs[0]);
>>> +   WARN_ON(job->ibs[0].length_dw > num_dw);
>>> +
>>> +   r = amdgpu_job_submit(job, &adev->mman.entity,
>> AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>>> +   if (r) {
>>> +           amdgpu_job_free(job);
>>> +           goto out;
>>> +   }
>>> +
>>> +   if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
>>> +           r = -ETIMEDOUT;
>>> +   dma_fence_put(fence);
>>> +
>>> +   if (!(r || write))
>>> +           memcpy(buf, adev->mman.sdma_access_ptr, len);
>>> +out:
>>> +   drm_dev_exit(idx);
>>> +   return r;
>>> +}
>>> +
>>> +static inline bool amdgpu_ttm_allow_post_mortem_debug(struct
>>> +amdgpu_device *adev) {
>>> +   return amdgpu_gpu_recovery == 0 ||
>>> +           adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>>> +           adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>>> +           adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>>> +           adev->video_timeout == MAX_SCHEDULE_TIMEOUT; }
>> This should probably be inside amdgpu_device.c
>>
>>> +
>>>    /**
>>>     * amdgpu_ttm_access_memory - Read or Write memory that backs a
>> buffer object.
>>>     *
>>> @@ -1453,6 +1518,10 @@ static int amdgpu_ttm_access_memory(struct
>> ttm_buffer_object *bo,
>>>      if (bo->resource->mem_type != TTM_PL_VRAM)
>>>              return -EIO;
>>>
>>> +   if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
>>> +                   !amdgpu_ttm_access_memory_sdma(bo, offset,
>> buf, len, write))
>>> +           return len;
>>> +
>>>      amdgpu_res_first(bo->resource, offset, len, &cursor);
>>>      while (cursor.remaining) {
>>>              size_t count, size = cursor.size;
>>> @@ -1793,6 +1862,12 @@ int amdgpu_ttm_init(struct amdgpu_device
>> *adev)
>>>              return r;
>>>      }
>>>
>>> +   if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>>> +                           AMDGPU_GEM_DOMAIN_GTT,
>>> +                           &adev->mman.sdma_access_bo, NULL,
>>> +                           adev->mman.sdma_access_ptr))
>>> +           DRM_WARN("Debug VRAM access will use slowpath MM
>> access\n");
>>> +
>>>      return 0;
>>>    }
>>>
>>> @@ -1823,6 +1898,9 @@ void amdgpu_ttm_fini(struct amdgpu_device
>> *adev)
>>>      ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>>>      ttm_device_fini(&adev->mman.bdev);
>>>      adev->mman.initialized = false;
>>> +   if (adev->mman.sdma_access_ptr)
>> You can drop that if. Free functions can usually take a NULL pointer.
>>
>> Apart from those nit picks looks good to me as well.
>>
>> Regards,
>> Christian.
>>
>>> +           amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo,
>> NULL,
>>> +                                   &adev->mman.sdma_access_ptr);
>>>      DRM_INFO("amdgpu: ttm finalized\n");
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 91a087f9dc7c..b0116c4a768f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -98,6 +98,10 @@ struct amdgpu_mman {
>>>      u64             fw_vram_usage_size;
>>>      struct amdgpu_bo        *fw_vram_usage_reserved_bo;
>>>      void            *fw_vram_usage_va;
>>> +
>>> +   /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>> +   struct amdgpu_bo        *sdma_access_bo;
>>> +   void                    *sdma_access_ptr;
>>>    };
>>>
>>>    struct amdgpu_copy_mem {
>>> @@ -193,5 +197,4 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct
>> amdgpu_device *adev, struct ttm_tt *ttm,
>>>    int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int
>>> mem_type);
>>>
>>>    void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>>> -
>>>    #endif

