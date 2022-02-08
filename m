Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328D9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 14:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9A410E256;
	Tue,  8 Feb 2022 14:18:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419BC10E256
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 14:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSxu/ofS7TNHXZS9w60v3UJcDo+uWRmSVhYxF7a0eUrH0AfXXGmAjRgKCu4izbS5jJAMANShAKHKMR89Hq0A6nXgmTJBwHq0aJp5p2ODZMpB5cL/TbIppemeJCOLV7d7qoMRyEtw2HnS/7PRSKwHR0sq+bkm8eSJPfBOR+VO2kPuI6hhLgoLzuNDFchSZXqvvbBl6z+3tT7eg1WAwNYTpKy33jDnl4CHtgxNOsYi0pfVv1KPZo+95EVcbCd1QPT5oYepncA8KLCwfRSEBVOgFWJTL9wM1h/G8oTtYUOF1r7TGHlwwg05Fr5MiHkt/+nORHpSJKHsfqBTy66rvDUkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1KayohJUmzLMQZ92W+3jhzPT/Wy0GfUQkGv1Mq/oMw=;
 b=dLgBWEErF+vbR5KQ0p+BQu5iGO3s2J7mu/laXhhm18ywG/XGykou2//Kjpw19QLtTDUHV+yiwxtt3fMl+AY726XQ7JosdqzEKog6fWVlbMMHHNDmTAG3mT/9T8gjrvesIaajhdKIRu5r/23KRcphuddq8QB83BptF2fpxUg3liYicRhpbOolOr3b8Wfy3jyGVNC71xuy879zfEXj5D62Cp+ZiO1nyM9YHZWteJgNno3XyJQNOZ4heKx2Y2eOen5HI/klwiuVjTazRjoY+and8+VYDkhxOasxLSIkxifqdC/qslqdjgP2I6IIgI2lSdzcm230VqbJdIfk3/qVL3ljfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1KayohJUmzLMQZ92W+3jhzPT/Wy0GfUQkGv1Mq/oMw=;
 b=FJZb1t8/0YYrTEi6K1sDPRK7wiYz4NMKLPz3B5tNwSmZrTFHVJ6y2MlR7eMeGFzTaE6Ebzme0najKFOcVH3MJrtkSmHzKMwFJv/YSwLFinTyK1nNK61ty7I+AuJNEKIdoitfFXsJUH40Lbf3YN/13Oc4dW/IdEtwkeOC6FuYiTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BYAPR12MB4984.namprd12.prod.outlook.com (2603:10b6:a03:105::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 14:18:15 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 14:18:14 +0000
Message-ID: <e92cd376-2cf3-f7ed-3dee-a39f0f5c7cbc@amd.com>
Date: Tue, 8 Feb 2022 15:18:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <385688f4-2165-ba58-8928-5774a44044e7@amd.com>
 <e700ecfd-1935-7545-f962-b6decd4377c5@amd.com>
 <52c555ab-ec80-bcfc-5811-270b3b23c5c8@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <52c555ab-ec80-bcfc-5811-270b3b23c5c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::41) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4054521d-2606-4fac-1516-08d9eb0dd847
X-MS-TrafficTypeDiagnostic: BYAPR12MB4984:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB49841BBF19210CFE6D87607EF22D9@BYAPR12MB4984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXn2bGTnrjnVacxJKZY67XDMh6eb+Qtq7fwJW1XUD+3WDGbXR9uiFy/wP0j+iXGolySWDMU/fdfFOWabFaF7W43fJcTNAzfhs7287QOMqaVuOBkCfTqPiYM1IpsxfDlPcgh8wJ0GqJH2MJMa/pfmfgF9EcblpSmzsHANYzbq2IiytApP5DJIe31ycVSnP3UobaaMhl1SBHKJaJFbT0NR2wVgrGz9h7fEE7aNjgbGUpjPCuEEbjvwbxUcvL7q4t6aSERvM3btTaT3hgA+OqdlKSJIWDT209UFASdjSK56NK7uoACpNBjU98Gkxh9AxlsoeC8hpRByz6dR6gMsyY8jBes85j4R+ahOwD3IPmDiJGG4Uy3t1BXGywqfr7J2616xZubqZXZFlWectDqwa9BTj/5VXDlohzkh6/fmWhSgI1MBuqoPS37UR8QBLbGRmNz96WojicSvEpWHydMZiDoE0tDKLzQoliwbBu6wuVeYJuO6hhzJe+z2Vyyn8+lsA+JKZv6r3OdjJuz/oojiGUXXli5ez9WvJMP3NWhWYZcAHJAqkQhovMhwTBUoiIsRFu1dfzzsoa/Rv/wlIlskUKKq0apQO+xTWFSm7aZplK22HAd5qYPTOwgGjJHu0kmhwyRidvX0VIcgDdo6yNvZ5j7bkYMgr3JTY20pwsFLQiM1PP1x2+Bk+QdmHvicOre4DCj7HEDcTC+qvyGrNsWfT5XcssY5+cPQiCIuNFEYM3txBqOwrgmleiIoQUXUAylFALZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(86362001)(38100700002)(6666004)(8936002)(5660300002)(6512007)(6506007)(53546011)(316002)(110136005)(6486002)(4326008)(66476007)(66556008)(8676002)(66946007)(508600001)(31686004)(186003)(26005)(83380400001)(36756003)(2906002)(66574015)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ynk0YmxsenlCUU95MGEzUlRDSGp5L004S2JvU1VEZ1M4dUVpbnp6aUNUeURs?=
 =?utf-8?B?Yy9lWi9PTUVHWnBLWXlzTUoyOEplalpiVDUrdjVOcnRMWHdZR1lLRExmUkND?=
 =?utf-8?B?VGpONEtkYXJBN2tFUXFINTROODRhdnFpSE5ZeWgrQ0VOU0xiUi9Sc3ZWZE95?=
 =?utf-8?B?M2UrWUJxdkNJeWZNbDJOMW5OelZ4V0JtYUNCbVlBNmhQWFh2c3o1OGRiMWIy?=
 =?utf-8?B?R3IwN3Y5bXVydFdrZVU5YldWc2Ezak9SUDFOZjZkT0doN1hsTkI5VWFtUWhE?=
 =?utf-8?B?Zmdmcm5kK0FyVStiQXhuTjMycUsyZWN3NzArSUpYUnJrNGo4SHNWWWpDZjFt?=
 =?utf-8?B?UlhvNC84Y2xNVmFidTlDNG9oa0daSHZKWnRJOXprV0xXekg5OWViOXZOUTh1?=
 =?utf-8?B?TDFUM1FSYW9FVDJiVzk4ZlVhUEFoblhHM0JpZ3Erem53emdaRE4zcTZ6QTBn?=
 =?utf-8?B?N1ZqWEsxNHNJRnF5ZHRJa2J4eTNYbzhsNFljL0M0RklnSTNEMUF6Y1N2bkFP?=
 =?utf-8?B?dWZkWHR1aDFYeFNIa3BRRDR4ejlOMkhYb2tSZ2wrOG44alpaZGF4SXVTNllw?=
 =?utf-8?B?RXMwTGZGRlYreFpUR0pVMFZaWWljdW9QYjdQcXZlcHFmcjhpVFpvemJVK1VF?=
 =?utf-8?B?WlpYVnNIR0dSbWFlQWRaRkdNOHk5Yk1HZ0JucWpwT1Y3YWVQemRTckFuMDdW?=
 =?utf-8?B?MUtFcFh4bUwrWXJSdWRUUC9LbWw2akZlWkl4QzFvTEJSbysrSXNJN3JBYWZZ?=
 =?utf-8?B?aDBteERYU05JQWxBMFRRdE1XeG1Kb0o5aDZQUmxtL2N6RG9iQUhBZWM0clN2?=
 =?utf-8?B?aEk5LzV6MkR1TURibEk1U0NyMHNQbUEyYzFIV1NiYkxyd24vUmg1QVFnNlIw?=
 =?utf-8?B?aXJiVlFXTy9iZlkvTjA4VStuaDdFQm1jVjFIYzRxRm9pTWZQTmR6RGc2OFRO?=
 =?utf-8?B?OGI0Mitic2NpYWxlL0JvekhYQ09ZaVd3S3Brb1BneXFyRklTT1V4eTk1Rk5K?=
 =?utf-8?B?YlRTU1k3U24ydUNnNlpaeTJUTlpLeXBZYmlQZm5SVHBrQ251R2JPSjlFbFRX?=
 =?utf-8?B?NHZ0UXVEK1VnNEp6bWhkcm1tTWFEK3lKdmxXcDQra25JVldOekR2NU8wWmpU?=
 =?utf-8?B?RExrN0FaKzdtQWJqdk1BRkNUWTBBa1A3Mk5WMkVQZG5oeWdRYVgzaTRWM0wx?=
 =?utf-8?B?MW9DT3ZVRlFWdXY4UjdZakV2ZTVyM0ZIeFBFUXkzaStTOHFlRWlEY2lZVW54?=
 =?utf-8?B?RCttNml6ZGlaZzNMVzZMVkVuems3RWw5Z1p0RFI0TTV3MmJmRGw2Y1UvUTAv?=
 =?utf-8?B?eW8rK2QwNmNrZ093UWNURXhEU1FSVExOeEtkZjFVWXFTSmE0VlpmaXlySXk0?=
 =?utf-8?B?dGhxVG8zUGZXck5sWnQ5UVRpWHZ0MzkyQnVzOWNKZmhaeThXWVc0MFkrTDky?=
 =?utf-8?B?ckVtZE5QeHZCd0lFZ3IxeUlBUGhyNWFGTVYrUHk5Z2VwZU9ubVY4UCs1S0dn?=
 =?utf-8?B?ZnVNbUc0MXFxenJDQXoxZEluOTNPcGVhMGR3VXRXa0hBR0UzUk9zNHBLRm1L?=
 =?utf-8?B?SDZTM05XazNxdkdYWnBZc1U5TzUrSEpDdHk1K0hVVDFyQWdldUpCQzM4dFpl?=
 =?utf-8?B?MG9iT0FPTVN6WGx0YWhjcWU5ejcraUJyNjFLZ2Q2OXFxbCtNS0g2VnVTV1FN?=
 =?utf-8?B?RlZ4bTQva29nOGI2aWxoRmRLbVMwYWJNNTRGZEVwWCtycVM5WHNXTVZ6ek93?=
 =?utf-8?B?cDFFdmJMMjJxYjBwandWekM0Z09CSVg3Qm5SeHBwVFQ5NkhYeE1lMGVZL3Q5?=
 =?utf-8?B?SUFKVVUxOVlSMndFcWFkbXBBY0tLVjQ5R09uTUJ0N2t5cEhIYkQ5SVRZYzc0?=
 =?utf-8?B?dlFncTBVaHBSOWVNaFQ3SU1iM3JEZWlOWG5rU3NDVmo3bDJnZnB2VXRPbVFn?=
 =?utf-8?B?UHFkc2czYjl4M3BWdFpGaVB3QitYL3JIZ21XZjFxeEI4UkxQRE1XeUowNkxa?=
 =?utf-8?B?SnVLVTBieFl4aUZ6TmlMZnhiNEpSWThSTFNObUNxU1FPdnFHbk0yS1MyKzc3?=
 =?utf-8?B?N1M0MGFndFFFSk40SDVRNTk2aWN4WHlMLzlNK2liZUsyUHpBNWdHMGJOVUVn?=
 =?utf-8?B?TmFBenY4YVR2aDVMcW0xZmowUFUvblJORE1SUTlDd242SzRqdXRIT2wxZEV4?=
 =?utf-8?Q?arbDvE3n2XB/mE9HKMkZM0Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4054521d-2606-4fac-1516-08d9eb0dd847
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:18:14.7462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw+YlXK2VavCef/zQvYHGDYrZjgtDi0IR3xcfavbVk7GUpF9wmpOZRdcLBT3qDi3RYbZLTwQqprnhZSie65VyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4984
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/8/2022 2:39 PM, Somalapuram, Amaranath wrote:
> 
> 
> On 2/8/2022 4:43 PM, Sharma, Shashank wrote:
>> I thought we spoke and agreed about:
>> - Not doing dynamic memory allocation during a reset call,
> as there is a redesign debugfs call will happen during the application 
> initialization and not during reset.
>> - Not doing string operations, but just dumping register values by index.
> I think your referring to the second patch which happens during reset 
> and no string operation in second patch.

Pls see my comment in the end.

>> NACK !
>>
>> - Shashank
>>
>> Amar,
>> Apart from the long comment,there are a few more bugs in the patch, 
>> which I have mentioned here inline. Please check them out.
>>
>> - Shashank
>>
>> On 2/8/2022 9:18 AM, Christian König wrote:
>>> Am 08.02.22 um 09:16 schrieb Somalapuram Amaranath:
>>>> List of register to be populated for dump collection during the GPU 
>>>> reset.
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 
>>>> +++++++++++++++++++++
>>>>   2 files changed, 63 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index b85b67a88a3d..78fa46f959c5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>>>>       struct amdgpu_reset_control     *reset_cntl;
>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>> +
>>>> +    /* reset dump register */
>>>> +    long            reset_dump_reg_list[128];
>>>
>>> I don't have time for a full review, but using long here certainly 
>>> makes no sense.
>>>
>>> long is either 32bit or 64bit depending on the CPU architecture.
>>>
>>> Regards,
>>> Christian.
>>>
> will change uint32_t.
>>>>   };
>>>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>>>> *ddev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 164d6a9e9fbb..dad268e8a81a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char *reg_offset;
>>>> +    int i, r, len;
>>>> +
>>>> +    reg_offset = kmalloc(2048, GFP_KERNEL);

We also want to understand how does the value 2048 came into picture, 
probably a macro which calculates the size preprocessing time will work 
better.

#define #define N_REGS_DUMP_GPU_RESET 10
#define BUFFER_SZ(N_REGS_DUMP_GPU_RESET * (sizeof uint64_t) + 1)

This first macro can be used later for the loop count for registers as well.

>>>> +    memset(reg_offset,  0, 2048);
>>>> +    for (i = 0; adev->reset_dump_reg_list[i] != 0; i++)
>>
>> This loop termination condition is incorrect, why are we running the 
>> loop until adev->reset_dump_reg_list[i] != 0 ?
>>
>> What if I have 10 registers to dump, but my 4th register value is 0 ? 
>> It will break the loop at 4 and we will not get all values.
>>
> agreed, i try to avoid one more variable in adev

Not by the cost of logic of course :).

Now you can run this loop here.

for (i = 0; i < N_REGS...; i++) {
	register_value_copy_here;
}

>>>> +        sprintf(reg_offset + strlen(reg_offset), "0x%lx ", 
>>>> adev->reset_dump_reg_list[i]);
>>>> +

>>>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>>>> +    len = strlen(reg_offset);
>>>> +
>>>> +    if (*pos >=  len)
>>>> +        return 0;
>>>> +
>>>> +    r = copy_to_user(buf, reg_offset, len);
>>>> +    *pos += len - r;
>>>> +    kfree(reg_offset);
>>
>> Also, why are we doing a dynamic memory allocation for reg_offest ? We 
>> can simply use adev->reset_dump_reg_list[i] isnt't it ?
>>
>> simply
>> for (i=0; i<num_of_regs;i++) {
>>     copy_to_user(buf, adev->reg_list[i], sizeof(uint64_t));
>> }
>>
>> Or without even a loop, simply:
>> copy_to_user(buf, &adev->reg_list, num_regs * sizeof(uint64_t));
>>
>> - Shashank
> 
> it will not be in user readable format for debugfs, (if non readable is 
> acceptable I will change this)
> 

We are just adding 0x in front of the reg value, so honestly I don't see 
a huge improvement in the user readability, but if you still want to do 
the dynamic allocation of memory, add the register offset or name as 
well, I mean then it should read like:

0x1234 = 0xABCD
0x1238 = 0xFFFF

- Shashank

>> +
>>>>
>>>> +    return len - r;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file 
>>>> *f, const char __user *buf,
>>>> +        size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char *reg_offset, *reg;
>>>> +    int ret, i = 0;
>>>> +
>>>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>>>> +    memset(reg_offset,  0, size);
>>>> +    ret = copy_from_user(reg_offset, buf, size);
>>>> +
>>
>> We are not allowing user to write into the list, so this whole 
>> function can just be a NOOP.
>>
>> - Shashank
> User only update the list of reg offsets on init, there is no predefined 
> reg offset from kernel code.
>>
>>>> +    if (ret)
>>>> +        return -EFAULT;
>>>> +
>>>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>>>> +        ret  = kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
>>>> +        if (ret)
>>>> +            return -EINVAL;
>>>> +        i++;
>>>> +    }
>>>> +
>>>> +    kfree(reg_offset);
>>>> +
>>>> +    return size;
>>>> +}
>>>> +
>>>> +static const struct file_operations amdgpu_reset_dump_register_list 
>>>> = {
>>>> +    .owner = THIS_MODULE,
>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>> +    .llseek = default_llseek
>>>> +};
>>>> +
>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>   {
>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>> @@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>> root, adev,
>>>> +                &amdgpu_reset_dump_register_list);
>>>>       adev->debugfs_vbios_blob.data = adev->bios;
>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>
