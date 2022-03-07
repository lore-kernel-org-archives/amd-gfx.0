Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFBBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 15:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378C210E02E;
	Mon,  7 Mar 2022 15:40:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9754110E02E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 15:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APWWcUQao9oTbMgGAD5Wn0rg+HPIpNWbdwgoXuFa8sRBGw2gWAWES57XLOgczbyap4aFJYlLbIB6YzmiqgxgW22ouVc3j+GFqOUEE5A1Y9+fLLkhYZknaKOtW+12MqPXz+s/MLycF3pYaycxqlCrElOjxxQGgGN9P28GP9GM4OSVyv7Lp6llEV83bd6E1hueWi85XsLgqpkEjwiqL0PF2PCvcMGqNjPHM71mZZNdJXzHt/A9IMRTMbw9lcXsRonue7aAOuMWkpvsRtSjURFrSq6otJuNmfzkJOdSxKHpd4QR8R+rrJwy5V/BuG6H1Sy+ibSwMY2/xNexIovclQEnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWyQhnhFyGhq3RGBTyucROX344Q2xIJnghAYyziAR8A=;
 b=hto6MUY3B4FpzKX5h9nt0r2JGNe4nlqnPS4KrByO1Ok0WDKW3M/cPVx/O2PrwrjrBv+S8QZ3I/2DXVZN+QJYO2iAGy+Edw7kxTGwHk/ONbWk6sTtKb4Sd+wiSt+PlzwhMBGBcHDMU4m9VmUM3A4wVSiVMVW5apQJhPPnzfdqntf6A5TxZFgMGEfn8yhVKsaDtQ7+k9BFFAiah6k/FdGrSKRI9RbO10VCw6Z5aw+xVTjoYVBi9vOszH4WiBJkuQh9Y/OWZfYhohEDay6JTDaRfTje/UoiwIfmCmweRTr7vq1p/fRE8E5KwPvWMLLftXSl1rfNw+CvdL4iC3sMp2iO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWyQhnhFyGhq3RGBTyucROX344Q2xIJnghAYyziAR8A=;
 b=ikTQm4N68gqbMzPq8vVOzel5D+mFgEE9V/CwLkYNEPDlz+VwQDT5t/9Pgj+vn8hzM7EmAxRXdA+htea3207tsbhLnmOSvuPok1OYodVVzvNuPklaYlUUn+5FzHe5G+rVT0bkX+ye54b94HGpdFUnk2iSAswLC1gLS8cK6qqizkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 15:40:43 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 15:40:43 +0000
Content-Type: multipart/alternative;
 boundary="------------1FdNjgwHlE5jX5DWVUlkHOBy"
Message-ID: <6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com>
Date: Mon, 7 Mar 2022 10:40:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/10] drm/amdgpu: add gang submit backend
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-10-christian.koenig@amd.com>
 <9bf49ccf-09a9-15d5-5591-ee2164c07f3c@amd.com>
 <5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com>
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4c4ae1-dee9-4be2-3843-08da0050d715
X-MS-TrafficTypeDiagnostic: SN6PR12MB2782:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2782E1A3D15E46B0F0A0D23FEA089@SN6PR12MB2782.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSyHlnlGyGBcaVE5mkVkTu2ZD08fyjArXFHhevKFJUwjqZrOmN7PdqSb0AhuIoUDHufPFOs437NZjbHGS4nTOLWSn/yzUROgIdMxARx3X278pDCL9tGGPOXmWU58NEN9m1PFwA9auAC2RIerBIOEtnJHgOXsOyfZY/rPkpiEvolqDKXKWu/WBjH2G/OJ5MhO5spzgAbfPpK7xAlhYT2EbA/LmE79Udnr/u8t+8bevZDTwAHkqjJMqRofTRXrDplhRvVJ4noT8ufL/+KrswNezjSBvR6tqhi3NwMVoPV4Du7ix8Bw4wsoqqAqvqjMEuGGlJ8Wd4Q5e/ZO1/h8861fTiDa30LSRaxzmBEVpVxJtUoietSNS7Kmzk4kgINHquz0SS4tUOETVIr9jxEhaCajoAzwovXha7GxeOHee7FVqmkacICca/qdyheZcC6thSnlA82BlJqHs3gnFqfnDmPbA1tvNxxeTiG5Fpmr+igd/Y+dL6WMHnYYZeesLcEN6aFtk70ORP0ZWsMEwqLLDa/EhUI+BoJtxmn+vOBGlEZw/5liu2J9zqpbjaOVPAeq4RF3tNJEldjjE150OktetycRcZkxyd4H1t5FrGvriYAWkqnnKJqy3GQfK+bGu+G2EnJkcP2snNO928HZsWnF8hDbGeT+k5xWCvpIdGOZCKl8eTtHdwJ1TP0qMuHNSaNniKDVZfUtt9vgbza5sUHFBDqB6G6KOuGe+0VhxVI5+rzFrA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6506007)(33964004)(36756003)(38100700002)(2616005)(31686004)(2906002)(83380400001)(5660300002)(66556008)(316002)(66946007)(6512007)(8936002)(44832011)(66574015)(30864003)(31696002)(6486002)(6636002)(86362001)(186003)(8676002)(4326008)(66476007)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW9EaUVSYkZqbkFZcjhVSTFkd1FGa1RXNzZqQnJWQVNXUlp6ZUlVcDNsQ25L?=
 =?utf-8?B?R2Zta2RodmxIVVYwR3pZay83dkM2OFQzNllkQ1dGVXRrRys3OUU2MjA2cGMx?=
 =?utf-8?B?blZ2dDRORWxpWEQxOHBkcXJ5N3BjcXg5UWdjSElWZEVhVUJuWHI0dXRGcjl2?=
 =?utf-8?B?aFNEM3llTitGWTlFSVExNEdvbDRRNHJ3bWI4YVdnUFJ6NytsYVJUazE5ajVt?=
 =?utf-8?B?N09ZRXlJN2lpbkoxMS82K0I4V1h2VE5peldKLzhLRDYvdmFZNFlFcHhFakdl?=
 =?utf-8?B?U3ZtM1Bwc3N5SHpWWGloZUhrRmhKSW9TZUVPUVlmblFPRTZmNDh6MVNZd1o2?=
 =?utf-8?B?NHVhU210d2U0UjlTTEpCZXcyZjJRNFdacjZoZjJOTDVXY3ZkMUxvbEh1NnFa?=
 =?utf-8?B?akZhVS92NFp0bnVueEFwcGp2NDFwalAwVVRhRFBGL0laOUVJdmc0YWhINmc5?=
 =?utf-8?B?UEtFckZlTWtBenVBelJ1ZEhmZTRJczd0bktMWS9kckJ3a01neHkxZXB5WjZ2?=
 =?utf-8?B?c0RMcFRmUTJUaDhSV0lLRjIwenlLTjd3N3oyYm5JZGJ1OENnUWtuZGFlbGM5?=
 =?utf-8?B?NHd6cWtSOStuSlQ1QVdxY2toNVVlTFRUVmlqOTdEcXZLY1NRSVNWb3VMK1Y2?=
 =?utf-8?B?SktpQ0FzWnBicnpCNFRNZFF3QnY3ZWQwZG5jU1gzVUtabC9HbUVxL3lRUVZw?=
 =?utf-8?B?aVkyY3JyK0wrSVpHZGJwbTBEUkVFRUo1NC9ZZVd6emRKNVhwS3BiRWZnYUVk?=
 =?utf-8?B?c282M0tSclpZOGpNSXlqRVFxUkdxZy9uRjF5VkR4Qnl1bVBJYmJ0cDg1Q3gr?=
 =?utf-8?B?ZDY1V2ZzYjlVM2lubWQ2WlFicS8zRVQxZkRoUWV2MWtvcU5lRGE5T3BkUm1s?=
 =?utf-8?B?UFQ5SGg3UFhFcmJSRk1VV0ZuZzUzYWd0NGZ5SnpzV1FvQXJkd2pFNzFsM0kz?=
 =?utf-8?B?alpUOVpoWm9BU1UyZGFuSldvYXovRkNXMi81OHpFUmlOZk05UlYvemhMSEU2?=
 =?utf-8?B?UXZaRThEcUszU2JzSDAyWnB2QmFxWE13RVc0K2NHTXQyMlhOSW9uTytTT09i?=
 =?utf-8?B?WFJzZStXYnIxYzl4YStZMXVjWm1hUTJnNzRoYmJka0dsYzNMWkNQYWNJVno4?=
 =?utf-8?B?NkZKTERSODYvY0xHM1V0UmZNRGExKzB3Z1U2T0FTWXMyS0p3T09rOWNrdXBy?=
 =?utf-8?B?MzR2S2lFUVhtbVV3cWx1RjhkRkhsaWVMOUxMajBCb3U5a1g0K1hjQ1B6OFNi?=
 =?utf-8?B?ZjBEQ0R3NEZTR0dpSkJ2RHIwT1ROQmFYODZQb3dDbEkxaXVHWGp0Uk9BR3Mx?=
 =?utf-8?B?QXNENXNLNWZzaUlncmNCUy8wL1p6L2pqUWM4cFZRRm5QRGZCa2JlZFdTb1dX?=
 =?utf-8?B?NnZLQVZtQ1hPZ3B3VnBUeis2REFwTW1iZUw1bmdqVithVnZWZkt3SFdoYzIz?=
 =?utf-8?B?a3JEZ0NONm4vZVVsTFFiL2g4MklYTXJpdkJIZ2ExcE4wWForSGdjS0tNWXQ0?=
 =?utf-8?B?TGhCbU5FZVVEMDZOREk0NS9IRWlGZnAvT0pCMWF2L0ZIeUhVRVEwaDNZclZC?=
 =?utf-8?B?SnlTYWJHai8xZGpxbjZUenFiMVJqNnEzR3BLRFE2MjBlakw1NVVzbERucnF0?=
 =?utf-8?B?UWRoTTVUQ3IvNk51T2xmaDZzVzZjY3ppanRTNzJvVFBXR1pWV1NYY0pFcjMr?=
 =?utf-8?B?Q3JkMVBrRGZoMzhHamtlRGFPZjdIZElYTXdLUTBpNWJTeWdCdkZKZVBHWDJX?=
 =?utf-8?B?MEJ2a1Z4akhueHAvL1RTR2o3THA5ZGVKQzl6MmtSWDIyMDQ1WC9Fcm9Hc2Ez?=
 =?utf-8?B?VFo1WXVLVFJzdWpEeVVOdzNGUFVDK2syMGx5dENGOTVuYTVVS3A4a1ZDL2g4?=
 =?utf-8?B?L2d3bEtzKzdPS29VYjJScm9haTFnWlB6ZER1S3lrV2dYeS8yc3lXVS9pajQ2?=
 =?utf-8?B?UWhmWjU2elhRTGxIWjBCTkl2aGJFVzJMa2o0V0ppWTZkazFJOEdvVjM4Mi8z?=
 =?utf-8?B?dmRYb0ZyNjZ2Z3pkTUR2bFJUZnFuMUUyWkR5VHNYQUFVS0E2eFNwVzVReC9I?=
 =?utf-8?B?NmpOSW12ZCtwc3JhV2tMblY0OGo4aWxxSnBsekJoVU1FVFNhbFNEMTYyQW9v?=
 =?utf-8?B?Sk16ck9ER3hZQmtXT1V1N0U2VFp5Qy9HbzBLaUNpMzIrQnRLQzRreklnSUJp?=
 =?utf-8?B?V3pSd1d1Sm5acnMrMUhqWnJIOHlpdVRUakNac2xpVmgzMjhtTDFjWGlnRVN6?=
 =?utf-8?Q?co16VHZwygtd+fE8kquD+ttFb7b9rzuUhsDk0qm1gU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4c4ae1-dee9-4be2-3843-08da0050d715
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 15:40:43.7221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMkghma5VE1XL7vfCZsShwo0qp03QdSrbULgL+8/9bYvm2EQ1p3EsvLrTsgVgGykZ0yd1l3euMYZazRUxYjViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------1FdNjgwHlE5jX5DWVUlkHOBy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-03-05 13:40, Christian König wrote:
> Am 04.03.22 um 18:10 schrieb Andrey Grodzovsky:
>>
>> On 2022-03-03 03:23, Christian König wrote:
>>> Allows submitting jobs as gang which needs to run on multiple
>>> engines at the same time.
>>>
>>> Basic idea is that we have a global gang submit fence representing 
>>> when the
>>> gang leader is finally pushed to run on the hardware last.
>>>
>>> Jobs submitted as gang are never re-submitted in case of a GPU reset 
>>> since this
>>> won't work and will just deadlock the hardware immediately again.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 
>>> ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 ++++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
>>>   4 files changed, 66 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 7f447ed7a67f..a664d43d7502 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -852,6 +852,7 @@ struct amdgpu_device {
>>>       u64                fence_context;
>>>       unsigned            num_rings;
>>>       struct amdgpu_ring        *rings[AMDGPU_MAX_RINGS];
>>> +    struct dma_fence __rcu        *gang_submit;
>>>       bool                ib_pool_ready;
>>>       struct amdgpu_sa_manager ib_pools[AMDGPU_IB_POOL_MAX];
>>>       struct amdgpu_sched 
>>> gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
>>> @@ -1233,6 +1234,8 @@ void amdgpu_device_invalidate_hdp(struct 
>>> amdgpu_device *adev,
>>>           struct amdgpu_ring *ring);
>>>     void amdgpu_device_halt(struct amdgpu_device *adev);
>>> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device 
>>> *adev,
>>> +                        struct dma_fence *gang);
>>>     /* atpx handler */
>>>   #if defined(CONFIG_VGA_SWITCHEROO)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index d78141e2c509..a116b8c08827 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3512,6 +3512,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>       adev->gmc.gart_size = 512 * 1024 * 1024;
>>>       adev->accel_working = false;
>>>       adev->num_rings = 0;
>>> +    RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>>>       adev->mman.buffer_funcs = NULL;
>>>       adev->mman.buffer_funcs_ring = NULL;
>>>       adev->vm_manager.vm_pte_funcs = NULL;
>>> @@ -3989,6 +3990,7 @@ void amdgpu_device_fini_sw(struct 
>>> amdgpu_device *adev)
>>>       release_firmware(adev->firmware.gpu_info_fw);
>>>       adev->firmware.gpu_info_fw = NULL;
>>>       adev->accel_working = false;
>>> + dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
>>>         amdgpu_reset_fini(adev);
>>>   @@ -5744,3 +5746,35 @@ void amdgpu_device_halt(struct 
>>> amdgpu_device *adev)
>>>       pci_disable_device(pdev);
>>>       pci_wait_for_pending_transaction(pdev);
>>>   }
>>> +
>>> +/**
>>> + * amdgpu_device_switch_gang - switch to a new gang
>>> + * @adev: amdgpu_device pointer
>>> + * @gang: the gang to switch to
>>> + *
>>> + * Try to switch to a new gang or return a reference to the current 
>>> gang if that
>>> + * isn't possible.
>>> + * Returns: Either NULL if we switched correctly or a reference to 
>>> the existing
>>> + * gang.
>>> + */
>>> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device 
>>> *adev,
>>> +                        struct dma_fence *gang)
>>> +{
>>> +    struct dma_fence *old = NULL;
>>> +
>>> +    do {
>>> +        dma_fence_put(old);
>>> +        old = dma_fence_get_rcu_safe(&adev->gang_submit);
>>> +
>>> +        if (old == gang)
>>> +            break;
>>> +
>>> +        if (!dma_fence_is_signaled(old))
>>> +            return old;
>>> +
>>> +    } while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
>>> +             old, gang) != old);
>>> +
>>> +    dma_fence_put(old);
>>> +    return NULL;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index e07ceae36a5c..059e11c7898c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -169,11 +169,29 @@ static void amdgpu_job_free_cb(struct 
>>> drm_sched_job *s_job)
>>>           kfree(job);
>>>   }
>>>   +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>>> +                struct amdgpu_job *leader)
>>> +{
>>> +    struct dma_fence *fence = &leader->base.s_fence->scheduled;
>>> +
>>> +    WARN_ON(job->gang_submit);
>>> +
>>> +    /*
>>> +     * Don't add a reference when we are the gang leader to avoid 
>>> circle
>>> +     * dependency.
>>> +     */
>>> +    if (job != leader)
>>> +        dma_fence_get(fence);
>>> +    job->gang_submit = fence;
>>> +}
>>> +
>>>   void amdgpu_job_free(struct amdgpu_job *job)
>>>   {
>>>       amdgpu_job_free_resources(job);
>>>       amdgpu_sync_free(&job->sync);
>>>       amdgpu_sync_free(&job->sched_sync);
>>> +    if (job->gang_submit != &job->base.s_fence->scheduled)
>>> +        dma_fence_put(job->gang_submit);
>>>         /* only put the hw fence if has embedded fence */
>>>       if (job->hw_fence.ops != NULL)
>>> @@ -247,12 +265,16 @@ static struct dma_fence 
>>> *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>>>           fence = amdgpu_sync_get_fence(&job->sync);
>>>       }
>>>   +    if (!fence && !job->gang_submit)
>>> +        fence = amdgpu_device_switch_gang(ring->adev, 
>>> job->gang_submit);
>>> +
>>
>>
>> Why job->gang_submit should be NULL in the check above ? Don't you 
>> want to switch to an actual new gang fence here ?
>> Jobs that don't have gang_submit fence set are not gang jobs anyway 
>> and we don't care for this dependency
>> for them right ?
>
> Well exactly that's the point. That a job is not part of a gang submit 
> is signaled by setting the pointer to NULL.


No dispute on this


>
> If we don't check for NULL here we would just crash.


But you go into the 'if clause' if job->gang_submit is equal to NULL, i 
would expect to see here
if (!fence &&*job->gang_submit*) because you want to switch to an actual 
new gang (not to NULL)

Andrey


>
> Christian.
>
>>
>> Andrey
>>
>>
>>>       return fence;
>>>   }
>>>     static struct dma_fence *amdgpu_job_run(struct drm_sched_job 
>>> *sched_job)
>>>   {
>>>       struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
>>> +    struct amdgpu_device *adev = ring->adev;
>>>       struct dma_fence *fence = NULL, *finished;
>>>       struct amdgpu_job *job;
>>>       int r = 0;
>>> @@ -264,8 +286,10 @@ static struct dma_fence *amdgpu_job_run(struct 
>>> drm_sched_job *sched_job)
>>>         trace_amdgpu_sched_run_job(job);
>>>   -    if (job->vram_lost_counter != 
>>> atomic_read(&ring->adev->vram_lost_counter))
>>> -        dma_fence_set_error(finished, -ECANCELED);/* skip IB as 
>>> well if VRAM lost */
>>> +    /* Skip job if VRAM is lost and never resubmit gangs */
>>> +    if (job->vram_lost_counter != 
>>> atomic_read(&adev->vram_lost_counter) ||
>>> +        (job->job_run_counter && job->gang_submit))
>>> +        dma_fence_set_error(finished, -ECANCELED);
>>>         if (finished->error < 0) {
>>>           DRM_INFO("Skip scheduling IBs!\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index 0bab8fe0d419..615328130615 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -51,6 +51,7 @@ struct amdgpu_job {
>>>       struct amdgpu_sync    sched_sync;
>>>       struct dma_fence    hw_fence;
>>>       struct dma_fence    *external_hw_fence;
>>> +    struct dma_fence    *gang_submit;
>>>       uint32_t        preamble_status;
>>>       uint32_t                preemption_status;
>>>       bool                    vm_needs_flush;
>>> @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device 
>>> *adev, unsigned size,
>>>   void amdgpu_job_set_resources(struct amdgpu_job *job, struct 
>>> amdgpu_bo *gds,
>>>                     struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>>>   void amdgpu_job_free_resources(struct amdgpu_job *job);
>>> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>>> +                struct amdgpu_job *leader);
>>>   void amdgpu_job_free(struct amdgpu_job *job);
>>>   int amdgpu_job_submit(struct amdgpu_job *job, struct 
>>> drm_sched_entity *entity,
>>>                 void *owner, struct dma_fence **f);
>
--------------1FdNjgwHlE5jX5DWVUlkHOBy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-05 13:40, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com">Am
      04.03.22 um 18:10 schrieb Andrey Grodzovsky:
      <br>
      <blockquote type="cite">
        <br>
        On 2022-03-03 03:23, Christian König wrote:
        <br>
        <blockquote type="cite">Allows submitting jobs as gang which
          needs to run on multiple
          <br>
          engines at the same time.
          <br>
          <br>
          Basic idea is that we have a global gang submit fence
          representing when the
          <br>
          gang leader is finally pushed to run on the hardware last.
          <br>
          <br>
          Jobs submitted as gang are never re-submitted in case of a GPU
          reset since this
          <br>
          won't work and will just deadlock the hardware immediately
          again.
          <br>
          <br>
          Signed-off-by: Christian König
          <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34
          ++++++++++++++++++++++
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp; | 28
          ++++++++++++++++--
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++
          <br>
          &nbsp; 4 files changed, 66 insertions(+), 2 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          index 7f447ed7a67f..a664d43d7502 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          @@ -852,6 +852,7 @@ struct amdgpu_device {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence_context;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_rings;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rings[AMDGPU_MAX_RINGS];
          <br>
          +&nbsp;&nbsp;&nbsp; struct dma_fence __rcu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gang_submit;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_pool_ready;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sa_manager&nbsp;&nbsp;&nbsp;
          ib_pools[AMDGPU_IB_POOL_MAX];
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sched
          gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
          <br>
          @@ -1233,6 +1234,8 @@ void amdgpu_device_invalidate_hdp(struct
          amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring);
          <br>
          &nbsp; &nbsp; void amdgpu_device_halt(struct amdgpu_device *adev);
          <br>
          +struct dma_fence *amdgpu_device_switch_gang(struct
          amdgpu_device *adev,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *gang);
          <br>
          &nbsp; &nbsp; /* atpx handler */
          <br>
          &nbsp; #if defined(CONFIG_VGA_SWITCHEROO)
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          <br>
          index d78141e2c509..a116b8c08827 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          <br>
          @@ -3512,6 +3512,7 @@ int amdgpu_device_init(struct
          amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.gart_size = 512 * 1024 * 1024;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working = false;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;num_rings = 0;
          <br>
          +&nbsp;&nbsp;&nbsp; RCU_INIT_POINTER(adev-&gt;gang_submit,
          dma_fence_get_stub());
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.buffer_funcs = NULL;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.buffer_funcs_ring = NULL;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_pte_funcs = NULL;
          <br>
          @@ -3989,6 +3990,7 @@ void amdgpu_device_fini_sw(struct
          amdgpu_device *adev)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;firmware.gpu_info_fw);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.gpu_info_fw = NULL;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working = false;
          <br>
          +
          dma_fence_put(rcu_dereference_protected(adev-&gt;gang_submit,
          true));
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_fini(adev);
          <br>
          &nbsp; @@ -5744,3 +5746,35 @@ void amdgpu_device_halt(struct
          amdgpu_device *adev)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_disable_device(pdev);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_wait_for_pending_transaction(pdev);
          <br>
          &nbsp; }
          <br>
          +
          <br>
          +/**
          <br>
          + * amdgpu_device_switch_gang - switch to a new gang
          <br>
          + * @adev: amdgpu_device pointer
          <br>
          + * @gang: the gang to switch to
          <br>
          + *
          <br>
          + * Try to switch to a new gang or return a reference to the
          current gang if that
          <br>
          + * isn't possible.
          <br>
          + * Returns: Either NULL if we switched correctly or a
          reference to the existing
          <br>
          + * gang.
          <br>
          + */
          <br>
          +struct dma_fence *amdgpu_device_switch_gang(struct
          amdgpu_device *adev,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *gang)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp; struct dma_fence *old = NULL;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; do {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(old);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old =
          dma_fence_get_rcu_safe(&amp;adev-&gt;gang_submit);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old == gang)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dma_fence_is_signaled(old))
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return old;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; } while (cmpxchg((struct dma_fence __force
          **)&amp;adev-&gt;gang_submit,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old, gang) != old);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; dma_fence_put(old);
          <br>
          +&nbsp;&nbsp;&nbsp; return NULL;
          <br>
          +}
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
          <br>
          index e07ceae36a5c..059e11c7898c 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
          <br>
          @@ -169,11 +169,29 @@ static void amdgpu_job_free_cb(struct
          drm_sched_job *s_job)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(job);
          <br>
          &nbsp; }
          <br>
          &nbsp; +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *leader)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp; struct dma_fence *fence =
          &amp;leader-&gt;base.s_fence-&gt;scheduled;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;gang_submit);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; /*
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * Don't add a reference when we are the gang leader to
          avoid circle
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * dependency.
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          +&nbsp;&nbsp;&nbsp; if (job != leader)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_get(fence);
          <br>
          +&nbsp;&nbsp;&nbsp; job-&gt;gang_submit = fence;
          <br>
          +}
          <br>
          +
          <br>
          &nbsp; void amdgpu_job_free(struct amdgpu_job *job)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_job_free_resources(job);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_free(&amp;job-&gt;sync);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_free(&amp;job-&gt;sched_sync);
          <br>
          +&nbsp;&nbsp;&nbsp; if (job-&gt;gang_submit !=
          &amp;job-&gt;base.s_fence-&gt;scheduled)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(job-&gt;gang_submit);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only put the hw fence if has embedded fence */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hw_fence.ops != NULL)
          <br>
          @@ -247,12 +265,16 @@ static struct dma_fence
          *amdgpu_job_dependency(struct drm_sched_job *sched_job,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence = amdgpu_sync_get_fence(&amp;job-&gt;sync);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; if (!fence &amp;&amp; !job-&gt;gang_submit)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence = amdgpu_device_switch_gang(ring-&gt;adev,
          job-&gt;gang_submit);
          <br>
          +
          <br>
        </blockquote>
        <br>
        <br>
        Why job-&gt;gang_submit should be NULL in the check above ?
        Don't you want to switch to an actual new gang fence here ?
        <br>
        Jobs that don't have gang_submit fence set are not gang jobs
        anyway and we don't care for this dependency
        <br>
        for them right ?
        <br>
      </blockquote>
      <br>
      Well exactly that's the point. That a job is not part of a gang
      submit is signaled by setting the pointer to NULL.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>No dispute on this</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com">
      <br>
      If we don't check for NULL here we would just crash.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>But you go into the 'if clause' if job-&gt;gang_submit is equal
      to NULL, i would expect to see here<br>
      if (!fence &amp;&amp;<b> job-&gt;gang_submit</b>) because you want
      to switch to an actual new gang (not to NULL)<br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com">
      <br>
      Christian.
      <br>
    </blockquote>
    <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com">
      <br>
      <blockquote type="cite">
        <br>
        Andrey
        <br>
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return fence;
          <br>
          &nbsp; }
          <br>
          &nbsp; &nbsp; static struct dma_fence *amdgpu_job_run(struct
          drm_sched_job *sched_job)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
          to_amdgpu_ring(sched_job-&gt;sched);
          <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = ring-&gt;adev;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence = NULL, *finished;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
          <br>
          @@ -264,8 +286,10 @@ static struct dma_fence
          *amdgpu_job_run(struct drm_sched_job *sched_job)
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_sched_run_job(job);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; if (job-&gt;vram_lost_counter !=
          atomic_read(&amp;ring-&gt;adev-&gt;vram_lost_counter))
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(finished, -ECANCELED);/* skip IB
          as well if VRAM lost */
          <br>
          +&nbsp;&nbsp;&nbsp; /* Skip job if VRAM is lost and never resubmit gangs */
          <br>
          +&nbsp;&nbsp;&nbsp; if (job-&gt;vram_lost_counter !=
          atomic_read(&amp;adev-&gt;vram_lost_counter) ||
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (job-&gt;job_run_counter &amp;&amp;
          job-&gt;gang_submit))
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(finished, -ECANCELED);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (finished-&gt;error &lt; 0) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;Skip scheduling IBs!\n&quot;);
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
          <br>
          index 0bab8fe0d419..615328130615 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
          <br>
          @@ -51,6 +51,7 @@ struct amdgpu_job {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sync&nbsp;&nbsp;&nbsp; sched_sync;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; hw_fence;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *external_hw_fence;
          <br>
          +&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *gang_submit;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preamble_status;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preemption_status;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_needs_flush;
          <br>
          @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct
          amdgpu_device *adev, unsigned size,
          <br>
          &nbsp; void amdgpu_job_set_resources(struct amdgpu_job *job, struct
          amdgpu_bo *gds,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *gws, struct amdgpu_bo
          *oa);
          <br>
          &nbsp; void amdgpu_job_free_resources(struct amdgpu_job *job);
          <br>
          +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *leader);
          <br>
          &nbsp; void amdgpu_job_free(struct amdgpu_job *job);
          <br>
          &nbsp; int amdgpu_job_submit(struct amdgpu_job *job, struct
          drm_sched_entity *entity,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner, struct dma_fence **f);
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------1FdNjgwHlE5jX5DWVUlkHOBy--
