Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C4FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4A510EE5B;
	Thu, 30 Mar 2023 14:04:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566B810EE5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXgbZB7b/APyzUTR+8XAhbXX3SrJMXmnc1rlwI5T63omJGpTcmpXFaGQUrtnuKZ/jXS3zMyevA4dTfKhCJvbQcdMdTDAoYkZ+g66sv8v7DlyiuuGyiZD/P8Ycg4fNeKR+epifdDJa8clWnSmbRS/RGqyFXWFzf9ndwZdIFB9nFm9bBB8V0haD5BG/7xLGBR9e9LuawmC08+uI5uw98AlpuH+5x18onMDvRbcZy8oWmhe+h8hNwkM4BKpN/Eir2+xsty/XFLg6itvHXCbS054h8pji/Hvox/GJCNMT159+CeKPQamzXxVTPdTarzk147hN1lP+qYHZ2v3WO5upWTFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZixYpMyteeOxGWCAgqYOqLJU1OGYB70TC8AAReMtTrc=;
 b=ZGacoR+AP2lAsU22iX+uqigCIdLv56mRPqwRFGVtAPZ0sEwfC/lR0YsbPQRWucjV/kOPUG1o9ODnmuPF5np8zMYDJlA2g4QoPvnG7lwQDkNlKWN+WY2Ev0PUuzEYLatnimOxMUckoBNNqFqLxo2R5Eii0SCi3KqsoV3qldJdKX/S179X4ZwoVau85JFr5gKhpFDRZusn2Emwu+foZslQ2UXFJzX8anlR4vCSJuQ4lRFPzdd+NDKU3XMgbcz2f1PePDSKPRLDN2Dilr8yNOxqH7klDTfaFcD92MBMRoCy96qs1PoksTJoAN/3McESvJQldVB0vx1vhfK2kiLlHmcpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZixYpMyteeOxGWCAgqYOqLJU1OGYB70TC8AAReMtTrc=;
 b=GU8id73AJI76IlVRJMANd3IOE1lPLPppiZgIFrw7xoYnSzqFVVqqlwaq65yxqkA7ywY8OL66jsq9OBrRZW4qeBIkKZcbIdC1t0uaGdE1EpzkSjlwv0FLqr5Uj454ZD8A+u2zuVVKy9bbrooQ7OPwoQhyoMDdM9ZIBlXlAzGRba4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 14:04:22 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:04:22 +0000
Message-ID: <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
Date: Thu, 30 Mar 2023 16:04:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BN9PR12MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 382d53f0-0057-4903-03a4-08db3127a997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80Vn+iQSsuX3oxNy4g0HZqARL8XeFJraca1nmSQKQg3wD4GAMO+7iVWFTM8FcO66cGxZ/gEGkpLy+482VG8VYVzkQHqYwxbK4QeJBD/aYVVg91YhIAX8bIQ8jXKVXDTS6TaHcmE6I91gc0LclNGC+i7ChxZ4+5qDh2P2cHackawWLhd+SAbxdZqYsgSLLO5EQvNOXYNMn45XO0WagCkv/ITP2LeiKbtfHr191pvulqITiNij4cQN/nqkYhZ3R58RrD6BAZgg/pI05UvhLNkmay/m4xzFIHm5DYcMg/99pDQdjE1JzekJAj4Ucm+yfTBCg5xuQ1JOks+cMS0gaVXhj0vLo7uAbgm9PO6xKK8Yr0LByAaHJmhjk4wOtNJ/MVDs7Vxf4eVSYSUbHE2VQoRBb8jAEj3ILpE4DPuv1MRKLYCnBBX/sbspq3+5qVqYFjef1HfdGaixxmIBvrf/HpX+WjgWqhrve4fnxjQoIcCynmot+U1SF3u2UWR6iag/1emxM8UiCMbccVZRrnkJv38kQZAu79T2Oo7z0FXQzQ48reE/itFKC/wjoZ5gy7Ju09Lv2OFaFUnAuUNw58LXDMz/qF0V3V0zeN9p5fXo1CYmr/IUiSMSrsnICG1Z1O0/hopRW2F7yfItaG7wi9maDLlhvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(316002)(6486002)(38100700002)(66946007)(6666004)(6512007)(53546011)(66556008)(54906003)(26005)(2616005)(6506007)(44832011)(2906002)(478600001)(186003)(5660300002)(86362001)(31696002)(36756003)(41300700001)(8936002)(66476007)(8676002)(4326008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZLZTV6ZUl5elllc29qdEhnd2dQUHVFbHROSng0QVZMMWJsR21hb0ZXSDdP?=
 =?utf-8?B?dFF1M3dKZzFXcDlJU1lESmNCUS9KcXUrRUFJRVM3RlJPZ2xiWTZGUm5tU3hH?=
 =?utf-8?B?RGZZL1J3UjEyZUJDT1pKNnozNG5XUEZ4QlJYczN6Zmxod21ETVlnRkw0ZWFF?=
 =?utf-8?B?Y1lyM3pLOVdzb0NQZkxpdHRpZEw0TWZ6eWhvTFlNWVBEOXNoOUc3NHR3RzdX?=
 =?utf-8?B?UkFQNGU2blluR0dQYjR2bUxUbnFEdWZ3cG1iMG5yam1IQ0dndGpYY3Z3aldl?=
 =?utf-8?B?bkZZQ0JaMGpVWVd1U3Q3VnJucEpQS20ySStrYm84c2JQU0lPR1hjWktzM1BR?=
 =?utf-8?B?citBTGtpOTAzdGJXallVODlwOUlycmh3b3NDcjRwL291K3RsQnh1bUMxdlVU?=
 =?utf-8?B?NDVRMlh4OWN4M21WRGdQL0VONVdMd25BQzVEd3NkRGZobDhmUkJBRzEvbUs2?=
 =?utf-8?B?QjNSalRKbUVZZnloK2wyTGFhcnQyamZPT0R1aE5KZXFCRW1TRmhJdjVDM1RX?=
 =?utf-8?B?dmFLdjRYV292UklBdmZQeFY0VDVXY3N6R1lmNE42UFMvOWVRWW1JZi9raE51?=
 =?utf-8?B?UjNjd0Joaml4YUxTUVFsQVo3Z2s1SFZLRHdDVnl3d1VXRjF3bEVndDE2NU1z?=
 =?utf-8?B?bkRSbWtmSDVaY04rWXJROE01QllPZlhNM0VoL3gyenZ1YjFCUXBMNS95UmhB?=
 =?utf-8?B?bkhKRE1zRWtFTU05Qzl1R0lIOWtCb3c0dEZBUzdjSFVGaVFHZWlRMkMyTUs5?=
 =?utf-8?B?QmlxcUI2VlZ2M01yaURTYnZpWTFJbkU3L0cvWWFabFNabjJqWUNRdkdDclp3?=
 =?utf-8?B?eFpacFI1OXpadDVCdmI5ZlRxczVZbjdVTXNYN2Z2Nm1xN1hCY3daQ3FsblpK?=
 =?utf-8?B?bnlEMERDSkZTUG1nVnR5eGJXSDBDeFZwek1QZHJkdEJrOGZZTVVxaTNvL1p1?=
 =?utf-8?B?dEw3S2xremNyOHRvanpVN2Nob0phamhTcEdRMXpFQnZtSVZ6ck9Na3QzUjh1?=
 =?utf-8?B?dzJZdHQxTkhUVXhCSTBDSUM4L05jWnlhb2hDMHZYNWR5WTFSaUQvcFJWZGxD?=
 =?utf-8?B?cXpScVA5RHd1U3FmMkptck1JR2MxQjJVRWJuTkNxT056Mk5VaGtyTkZ6RzdV?=
 =?utf-8?B?Zlo2dkF4UGVucW5NU3NFczl2dHJSTitBczcxVmVLTEVic1Y3cXVCc3lYdVhU?=
 =?utf-8?B?RXBFNXUyUWJkeUxtQ0Jtb3J2dm1XMHlycTFLVER4NElreW9ienlPVXhBbG5X?=
 =?utf-8?B?RmdSdTlnOGxJOHNHcUIyMGVtT2M5NWFyY0V3QVQ2MWkvSDNjV2VGOWdBWlls?=
 =?utf-8?B?NkRqTW5tL1ZtWm1TRWpFUmN2cUVMZU9iOWh0SGN6dXYxU0Z1ajJLQWtpcStl?=
 =?utf-8?B?emQycFlVbDNnU1ZJZkVJZGJqVDJVaFF2T0ZlaXdXN3pDdkZWQVFYWjQ1d3Y1?=
 =?utf-8?B?VUluNXh1c3FVczJRM05IRHdJenYxMXRNb2kra2lKcElqMUkwblVDRG1CWUVt?=
 =?utf-8?B?Yng0czNzcmk1cE4ySHZ6SDlweEk1eGRGbmJEb3dxV003NXhVc2dGU3lrUGJG?=
 =?utf-8?B?TjN6VDJEbjZoK01zMmJCWjM4SDRoQ0oyTWM0SnVHRTFEWDcxNnBTU3VReWpM?=
 =?utf-8?B?aDloTGsxZEZDaHF2QlY0aWJWY05tRGhIZDFiMkM0ejJXLzhBSWV2N2VSY0RL?=
 =?utf-8?B?ZDgvR1lFR1gzSHpjQ3FHNW15eUFoY0ZYdmpXK0ZxWDcwTnF5VzdKZzdZb1du?=
 =?utf-8?B?ZkNtZTRvaGcycENGUWJHMVhqQlFYc0s0K2ZST1pKYTdTNVhlZVdXMDhnY09i?=
 =?utf-8?B?bXNvaWVUR1RqM2lJKzMzTklTcFNsV1FLdG5kSkVabWU0Zkg3OTlPQ1JnN0lZ?=
 =?utf-8?B?dldIekxZVGR2WUN4ZVloLzNoYmErTFk1UU1KbW1hbWV2SjhJUE1qam1xSTA2?=
 =?utf-8?B?bjh4TFcxL0htajZnN3l4N2xHN3c1QTJjVzFweDJtTmFuYUlMRnRObUsyTVJh?=
 =?utf-8?B?Q3VKZ3ZRWXFlcUlvMTR0T0lUNDVnMDRYUVBmYWxBT1pGWXA4MUJ6a3JpVlRv?=
 =?utf-8?B?Q2hhTmtGYnhPRFpQTGtwVUFpdHlFVTFoeTJRMngxNzk0SzhLbzVhVk0rZVh5?=
 =?utf-8?Q?HrSoZXvR6qSzf9ZfRZ/UNUbJK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382d53f0-0057-4903-03a4-08db3127a997
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:04:22.3391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sepzdDxPGjnXwNDwcRL/U/EHI5UXmE5JZpikHPmKQnQQ9KIUA7C52a0jIKMnrTZ+HwLGXxfmS99cHHZWFPm5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 15:42, Luben Tuikov wrote:
> On 2023-03-29 11:47, Shashank Sharma wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds helper functions to create and free doorbell
>> pages for kernel objects.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>   2 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index f9c3b77bf65d..6581b78fe438 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -27,6 +27,24 @@
>>   /*
>>    * GPU doorbell structures, functions & helpers
>>    */
>> +
>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>> +struct amdgpu_doorbell_obj {
> In the comment you say "Structure to hold ...";
> it is a C structure, but then in the name of a function we see "obj".
> (Object is something which is defined like in memory, i.e. it exists, not
> something which is only declared.)
> This is just a declaration of a structure, not an object per se.
> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".

It is similar to struct amdgpu buffer object (struct amdgpu_bo), and 
many more existing structure.

- Shashank

> Then in the definition, you can call it an object/objects, if you'd like,
> like "struct amdgpu_doorbell *doorb_object[];" then you can say
> "db = doorb_object[i]";
>
> Regards,
> Luben
>
>> +	struct amdgpu_bo *bo;
>> +	uint64_t gpu_addr;
>> +	uint32_t *cpu_addr;
>> +	uint32_t size;
>> +
>> +	/* First index in this object */
>> +	uint32_t start;
>> +
>> +	/* Last index in this object */
>> +	uint32_t end;
>> +
>> +	/* bitmap for dynamic doorbell allocation from this object */
>> +	unsigned long *doorbell_bitmap;
>> +};
>> +
>>   struct amdgpu_doorbell {
>>   	/* doorbell mmio */
>>   	resource_size_t		base;
>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>    */
>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>   
>> +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +				struct amdgpu_doorbell_obj *db_obj);
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +				struct amdgpu_doorbell_obj *db_obj);
>> +
>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index 1aea92363fd3..8be15b82b545 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +					struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +	amdgpu_bo_free_kernel(&db_obj->bo,
>> +			      &db_obj->gpu_addr,
>> +			      (void **)&db_obj->cpu_addr);
>> +
>> +}
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +				struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +	int r;
>> +
>> +	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>> +
>> +	r = amdgpu_bo_create_kernel(adev,
>> +				    db_obj->size,
>> +				    PAGE_SIZE,
>> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
>> +				    &db_obj->bo,
>> +				    &db_obj->gpu_addr,
>> +				    (void **)&db_obj->cpu_addr);
>> +
>> +	if (r) {
>> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>> +		return r;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * GPU doorbell aperture helpers function.
>>    */
