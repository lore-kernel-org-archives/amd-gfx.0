Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A705AC77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 16:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD3B10E3FA;
	Fri, 28 Apr 2023 16:41:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0536010E3F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 16:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDluiS2APgvNoXI1SgP2RF0fly8UABo2uPi835jRKfrM0P4fxYEt199jZrILzUDDEXiTuv9RmHWCQpUexbO6xyXctC7ITVoS/nhK3CRlZEvGdXCdyBP4L2wKJPm0YXMKB7Wudv6SVSfGFCbsRdmvwl73pByCZ3VJuSEx7mLSIp+yk9I2sTudi+JbZcry2EIy2Sz3R11q/KETnOzSOoGULaTohWdPATqlO+B2hC4kUWMTSmmJE6c8yAwh7vv/mxAjDAS9liIfZX3ARYv54XUxw175ar7iKLpG9Txj+QC8fCWiJvuCPbRGNwevHvO4wkDP5fs23fiAS9DWWbXLJfevhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tjygnIr4T2X0Z3BH9kA0SfHCN0RH46dLp0JFvnOFCI=;
 b=VTcfObkA8Fj4F1SDe1ixxDVVJsk8kQemutkbWgLQOlc63uaHNFqEJ5MDimweZqXJM3Y5EFlOM7t9rb1eCdNYb/21FYEzrdpq63TB8rDW9ntUCBF64h6C81EgyUhW+R2qhhYUqLBNapSTx/vK+B7FIqVmr1Bsv3O/qRh6WHMOccUm0EefBurjYf/+zo767rIUMX4vJkkIr4fb0hzx5Ks1S5LwCbrQcBrooykhbVL9KVY1oygEg94cUZxn5HD8Nn+QqAr9FZj/RxBPy9usH/Nu1uUU1Pr3wksu+WfE1Qi8Uh8BQIRnPrNOUtQJ9VDQZrk7KDl3OpBNQa0W0sNTxwINvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tjygnIr4T2X0Z3BH9kA0SfHCN0RH46dLp0JFvnOFCI=;
 b=3faqKgPGhrJF7mHeRdAml9cYcvMPwbS4HeMmdFGSdFfxq0scByXyHT12IfevCPh1R+ntrBeOh7LleW9QrLoGfWuwm9GIuQmFt17f9vREYjw3bQWHM+cOUcRPrgpfrC+cdvpi549qYjcDp4ftJZLhaFse/FAGVmyGSHxxN++ttwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 16:41:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 16:41:16 +0000
Message-ID: <ac08c72e-ed64-09d3-1669-4f23ae0172a1@amd.com>
Date: Fri, 28 Apr 2023 11:41:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
 <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
 <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
 <8b8d22bd-0eff-2f81-9267-07c4c4d058d1@amd.com>
 <04b2fcfc-90d8-5398-9ccf-58dfd178d73b@amd.com>
 <19238e6c-86db-6a00-ea83-e69b7384eeba@amd.com>
 <008e334c-d62a-bca7-6465-3cccea7f0c17@amd.com>
 <56d9dd1c-2028-76ca-3f74-d37ad1733264@amd.com>
 <BN9PR12MB51153ACF2B1F2028E85ADD3E926B9@BN9PR12MB5115.namprd12.prod.outlook.com>
 <203033d8-3edc-ef85-fb5d-df77315cf118@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <203033d8-3edc-ef85-fb5d-df77315cf118@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 983f7e61-cfd6-4a4f-7ed5-08db480762e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dafj3nXRWON4bHmPp0A2S2RzDanuah6Q6lEZY0te5MrGxOoQejF5dLgIJC75MHf6k1Kna0zNOKAaL4IFXCofFcyMq6Y7boGLGVYz38KF4zOpSL4oed/TK8ohTgBeaBTYZm6kKUVG536A9AxjhYA5BlyC1o/gBcLOQ+Oh84fmd50d/XFaPnD1Pkp6R2BasgVTjCUBCgfaaySpvCAKRXb0xwnZTqRwUqI3jk18j3PiuKiVXHMXU+4QEXmtodnOlTqsotruVXHBTAGhkncZK3CMAw8asFUkpe3vigbMfap/1WhpdHU4vJ5hdogDQ3IGbQOjglm2F9U4XjInQIyNnFhyhSDZOlR4L+ZRmxdT5mxK7LtFOQ/VanK4/T+AfzLFpWS91rWPX3HksFGDuyvYVwP6fK2AhkPwS2pKel9ykQOcWh314qAqilGzEgqmcGymTzvSobReOiR93IekzsDks8E5LjlrgfptGyiax9E8ArxyFq7QQJL95422ipvgsjhP/tpk/BnHQoQGHF4zcqLVf94WHBwY4d4tJbLVqjjW0uxKZ+vqhgFbPC3k4ZKrwbIj5t0WZojLTc5h0pX6fG9cLbZwBaQafhEWVg9SdEx+XBCP8ga4/KdwSOHmp4x++Lioha9ZCu8fZ5Y0c4BWsV9jfehtZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(2616005)(31696002)(86362001)(66476007)(66946007)(66556008)(478600001)(36756003)(6486002)(186003)(38100700002)(6512007)(53546011)(6506007)(26005)(110136005)(66574015)(8676002)(8936002)(41300700001)(83380400001)(44832011)(5660300002)(31686004)(316002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXI3WnpodlRUOTdaK3BYRHV3U1RRUmNVaEk4T0piN2xqQTFLNHRGcm8yTW1s?=
 =?utf-8?B?N1Y1UlBHN09BWnFKMU1veFhiN3pYNlBRd2NHYkJhQ050bTF3TFErQWp6VG85?=
 =?utf-8?B?Q3VwV0Fkc056NkxMczcxZHNCSkZlVk9WOTJpOVZZdmNjVGpRdFdZbVRJMjY3?=
 =?utf-8?B?S3VZMGYrNzNGR3IzUFAzeDR1TWcvanJGY3M2cUFwZ3ViOVdwdi9CemE4SzM2?=
 =?utf-8?B?K0lPN2ZZdkdORVg1V2N6Sm9sZDJZOUVmQThLMHRhTXBhVU1QbFNyM2dyL05V?=
 =?utf-8?B?VGQzQzZZKy9rNWIyaXpyd1ZLeUhRVG8yaWxJbUxHdFFpUE5aQ29NNG0zazBH?=
 =?utf-8?B?TDdibzVFUVNsOUN0MDBPdWQ0cXlYMlRHaFhrREJSNHp6S3l1b1Q0Unc0N09M?=
 =?utf-8?B?REpxK0RBOURVS21FdGpxTW5pcVQwUWdaclFYRkxEOUVrSDZuanZFb2NYS0x4?=
 =?utf-8?B?cVl1UUsvK1ZKMWZxUEFQRmFLZlZoWHpYUGhDRm81d2R5cGF2Tjc4NUF4eVVB?=
 =?utf-8?B?eEh3SUhJYkhvTGdORnZlZk1hNVdGdlYyUUJLZjNCek1QU3RqQ2MzVWllcHFn?=
 =?utf-8?B?RlRqUUJDYmEzL1I1YXByclV4bzkwcEdKK0FtcFoxdkVhWkpSeEJHMEhKbzFM?=
 =?utf-8?B?anNLTmNPTUFTLzQzek1xbWtMU2tGeXFRZmx2VXJyKzYrTVJ6NVEzTkVoZ1hY?=
 =?utf-8?B?Z0hWcExQNUpSanI5VWRWL2RrQzZBV0FSNlNVVk14MWdqajUvWUVianhRZDhZ?=
 =?utf-8?B?TEg2ZWlFV2VVZWVRYXZyWHVPcGhZR1I5U3E5QmZmWDBSNkR1NW1jRkVRczEv?=
 =?utf-8?B?MXQ4bENKRmZVRWlPK1RxRkRzbW5XVWhoQ1NpMDdHMnFXVHhWOGk5cUVmcDBD?=
 =?utf-8?B?YzBsUUh4cmRYQXlIRFRhaVM4MW02OWFGNmI2UW9BR3NqVDU5TlFiQWpvZHhw?=
 =?utf-8?B?NkZPcmhxa01MQzhyNVlsWDVVV1hkam9wVGxrSE84bUhWY1RyTWxHL0xpc2JU?=
 =?utf-8?B?dmFseXRIY1hwRjgwbXova3RsNGt3MXNPVURnVUI2cVUvM1F4U2FnQml1Qzk1?=
 =?utf-8?B?RXJpeDZhU3A5Yjl5aUU3ZWphVjhBbnVmbE9zRENEZHRaWTJNVktnNlpsM3RJ?=
 =?utf-8?B?bG9sRXhjM3hOWnI0NDBod29iWkt6NkZBUytzUzNNZDBiMElFWkYwcmF3czZy?=
 =?utf-8?B?YjhhTDRjSlh4ZElFWVVzOStzZEtaa3lOVS82d29jSXFobWoxMVhwc1o5aWR6?=
 =?utf-8?B?Y1gxNWJQQlRicEtodmJiazV4MzlqaXdDNnoxby95S3hQcEJlbzUrNmpmRVl1?=
 =?utf-8?B?bTVNZ3RqSHpuWlphNnliQ1BxTDcvNGtjREhKRnVKZmorMHp0eWNvWEI5SGh2?=
 =?utf-8?B?V1JnN1hSZ1p5Mk5TZHNmK05oTnpoSGFHTGpVWEwzcWlweGhYREx6Tmg5cjU3?=
 =?utf-8?B?UktvZmRFTEJxR0U5elh3cVBFaFdoTTZ4RGliaFp6dzZnWDlPYU1TelhtVVJJ?=
 =?utf-8?B?N2Z1UkZYTzQybnIra1diNFJkN0drN1o4dUN6QXRMMkN2bDhxbS84OXAxdExL?=
 =?utf-8?B?dEg4dG0xeUVuaWRtYnJJL0VIZVR5VnpoMW1VMi9BMjJzK3ZKd25IaHp1MXhi?=
 =?utf-8?B?ZUZjU2krdjQwSDBtRGNSSE85ZTZyeU1QYTVxNllyZnRHWDlQWTBKVFBQN0FH?=
 =?utf-8?B?M2xFeldBRXZWaUlISDFMUGZDc0pWYkFKTUZMeHdENXVRRFo4OVZTeXJaVDBT?=
 =?utf-8?B?MkMraG1MdTU4SHlRbWNrNnhQa284Z3JvbDdZYWNuMkNwQ2J4RmplT2NEbUhj?=
 =?utf-8?B?cThPaUpFNFpGZlNIV2lDRDJQVWhKK1pwL0FtaTIrc1BkclFuNUdQYm1RSWZx?=
 =?utf-8?B?T1VPZGFNOVJkc1BzRXlVS0V0N2QrN0dtZ3B1N1dRTUZ0MndZbzU0OXBrVGZ4?=
 =?utf-8?B?RklEby94Q09vcXN0WER5UVJCUENQU09rRG95ekgvQnNxK1ErMzFseWUwL1Ay?=
 =?utf-8?B?b0FiUWFXMlVKcmtPMlovRVdLUlUxYmhQdXFxbjg1ZEF1VDBxS0FEd2RFdmN0?=
 =?utf-8?B?YXFRNHlobDZDdVpMWVBhUWdSbGw4TE9ubXBCSkV5OGpmN3MvT0xPLzU4bnhj?=
 =?utf-8?Q?I5Lg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983f7e61-cfd6-4a4f-7ed5-08db480762e8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 16:41:16.6021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJyA2fAmdFCsqH7CruMwnIv3wig5W+BjU28aRHZ4OWQfVjRX1b4+6lpZYkKU+fl6ig9uJZNA9BqFOsCV44HViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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

On 2023-04-28 10:17, Eric Huang wrote:
>
> On 2023-04-27 23:46, Kuehling, Felix wrote:
>> [AMD Official Use Only - General]
>>
>> Re-mapping typically happens after evictions, before a new eviction 
>> fence gets attached. At that time the old eviction fence should be in 
>> the signaled state already, so it can't be signaled again. Therefore 
>> I would expect my patch to help with unmapping the DMABuf import, 
>> without breaking the eviction case.
>>
>> Are you talking about remapping with a map-to-gpu call from user 
>> mode? I think that would only be a problem if the KFD BO was unmapped 
>> and remapped multiple times. The first time it's mapped, the fresh 
>> dmabuf import should be in the SYSTEM domain, so the validation in 
>> the SYSTEM domain before GTT would be a no-op.
> Yes. The case scenario I am talking about is from user mode, 
> mapping->unmapping->re-mapping to the KFD GTT BO will trigger the 
> eviction.
>>
>> I sort of agree that we don't really rely on the eviction fence on 
>> the DMABuf import. The reservation object is shared with the original 
>> BO. Moving the original BO triggers the eviction fence, so we don't 
>> need to trigger it again on the dmabuf import. Other than moving the 
>> original BO, I don't think we can do anything to the DMABuf import 
>> that would require an eviction for KFD use case. It is a special use 
>> case because we control both the import and the export in the same 
>> context.
> I am thinking about no adding KFD eviction fence in first place of 
> mapping original GTT BO, because I don't see it can be evicted in any 
> cases.

That's not an option. We're not adding an eviction fence. The 
reservation object with the eviction fence is shared between the 
exported BO and the imported one. That's just how DMABuf works. If you 
wait for the fences on the imported BO, you are effectively waiting for 
the fences on the exported BOs. And you can't remove the eviction fence 
from the exported BO.

Regards,
   Felix


> In theory GTT BO is mapped by user calling mmap() in system memory 
> like userptr, unlike VRAM it will be not evicted by amdgpu vram 
> manager. The only thing is CPU invalidation, but GTT BO doesn't 
> register mmu notifier, that will be a potential problem when switching 
> paged/userptr to non-paged/GTT for mes scheduler.
>
> Regards,
> Eric
>>
>> In the general case dmabuf imports need their eviction fences. For 
>> example when we're importing a DMABuf from somewhere else, so the 
>> eviction fence is not shared with a BO that we already control. Even 
>> then, unmapping a dmabuf from our KFD VM does not need to wait for 
>> any fences on the DMABuf.
>>
>> Regards,
>>    Felix
>>
>> -----Original Message-----
>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>> Sent: Thursday, April 27, 2023 14:58
>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; Christian König 
>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences 
>> invalidating preemptible DMABuf imports
>>
>> Hi Felix,
>>
>> I tested your patch on mGPU systems. It doesn't break any KFD 
>> eviction tests, because tests don't allocate DMABuf import, that 
>> doesn't trigger it's eviction fence. The only thing the patch affects 
>> is in re-mapping DMABuf imports that the eviction will still be 
>> triggered.
>>
>> I have an idea that we probably can remove eviction fence for GTT bo, 
>> because currently the only way to trigger the eviction fence is by 
>> calling ttm_bo_validate for CPU domain in kfd_mem_dmaunmap_dmabuf. Do 
>> you know there is other case to trigger GTT bo's eviction?
>>
>> Regards,
>> Eric
>>
>> On 2023-04-26 22:21, Felix Kuehling wrote:
>>> Hi Eric,
>>>
>>> Can you try if the attached patch fixes the problem without breaking
>>> the eviction tests on a multi-GPU PCIe P2P system?
>>>
>>> Thanks,
>>>    Felix
>>>
>>>
>>> On 2023-04-26 13:02, Christian König wrote:
>>>> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>>>> On 2023-04-26 9:03, Christian König wrote:
>>>>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>>>>> Hi Christian,
>>>>>>>
>>>>>>> What do you think about Felix's explanation?
>>>>>> That's unfortunately not something we can do here.
>>>>>>
>>>>>>> Regards,
>>>>>>> Eric
>>>>>>>
>>>>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import bo
>>>>>>>>>>> when dmaunmapping DMAbuf. The DMAbuf import bo has been set as
>>>>>>>>>>> AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>>>>
>>>>>>>>>> I'd like to get an Acked-by from Christian as well before
>>>>>>>>>> submitting this.
>>>>>>>>> I have to admit that I only partially followed the internal
>>>>>>>>> discussion, but in general you need a *really* good explanation
>>>>>>>>> for this.
>>>>>>>>>
>>>>>>>>> E.g. add code comment and explain in the commit message
>>>>>>>>> extensively why this is needed and why there are no alternatives.
>>>>>>>> OK. I'll give it a shot:
>>>>>>>>
>>>>>>>>     This code path is used among other things when invalidating
>>>>>>>> DMABuf
>>>>>>>>     imports. These imports share a reservation object with the
>>>>>>>> exported
>>>>>>>>     BO. Waiting on all the fences in this reservation will trigger
>>>>>>>> KFD
>>>>>>>>     eviction fences unnecessarily, for example when a DMABuf
>>>>>>>> import for
>>>>>>>>     a DMA mapping on a secondary GPU is being unmapped explicitly.
>>>>>>>> Only
>>>>>>>>     moving the original exported BO requires stopping KFD user
>>>>>>>> mode
>>>>>>>>     queues. If the invalidation is triggered through a move
>>>>>>>> notifier
>>>>>>>>     from the exported BO, then moving the original BO already
>>>>>>>> triggered
>>>>>>>>     the eviction fence and we don't need to wait for it again on
>>>>>>>> the import.
>>>>>>>>
>>>>>>>>     We can identify DMABuf imports in KFD for secondary GPU DMA
>>>>>>>> mappings
>>>>>>>>     by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>>>>>     operation that ignores KFD eviction fences.
>>>>>>>>
>>>>>>>> How does this sound?
>>>>>> To be honest like quite a bad idea. Why in the world are imported
>>>>>> BOs moved from GTT to SYSTEM in the first place?
>>>>> As I understand it, the way to update SG tables in  SG BOs (e.g.
>>>>> userptr and dmabuf imports) is to move them back and forth between
>>>>> system and GTT domains. If we left the import in the GTT domain all
>>>>> the time, we would have no way to update it, e.g. after an eviction.
>>>>> Currently the move to the system domain is done in the unmap code 
>>>>> path.
>>>>>
>>>>> Before memory is freed, we also need to unmap it from GPUVM,
>>>>> including the DMABuf imports on remote GPUs. For the above reason
>>>>> that currently includes moving the import to the system domain. If
>>>>> we removed that from the unmap code path, we'd need to do the move
>>>>> to system somewhere else, maybe in the mapping/validation path.
>>>>>
>>>>>
>>>>>> The only reason for this I can think of is that the DMA mappings
>>>>>> become invalid for some reasons and in this case waiting for the
>>>>>> KFD fence is actually the absolutely right thing to do.
>>>>> In this case the reason the only reason for unmapping the memory is
>>>>> that we're about to free the memory and its DMABuf imports on other
>>>>> GPUs. This is coming from the application with a promise "I'm no
>>>>> longer accessing the memory". We don't need to wait for fences here.
>>>>> We only need to invalidate the PTEs to make sure that any further
>>>>> buggy access by the application will fault.
>>>> Well in this case just free the BO and it's bo_va structure. The core
>>>> handling should take care of clearing all the freed up regions.
>>>>
>>>> As for updating the SG of a BO you indeed need to move it from GTT to
>>>> SYSTEM and back, but in this case we should either indeed wait for
>>>> the KFD fence since page tables in between the operation still have
>>>> the old entries or we should destroy the BO and create a new one. The
>>>> later would overwrite the PTEs with invalid entries first and then
>>>> fill in new valid ones.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>> Regards,
>>>>>>>>    Felix
>>>>>>>>
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>>    Felix
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct
>>>>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>>>>        if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>>>>             old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>>>>            new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>>>>> + AMDGPU_FENCE_OWNER_KFD,
>>>>>>>>>>> + ctx->interruptible);
>>>>>>>>>>> +        else
>>>>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>            if (r)
>>>>>>>>>>>                return r;
>
