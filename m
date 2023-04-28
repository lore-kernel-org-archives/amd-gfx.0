Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20D1C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD6110EDDD;
	Fri, 28 Apr 2023 19:51:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E4C10EDDD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn3kCcGs+5V7+Qw/ubOAIPzraD4TIW6iQrlxq0MWxwYWVEiguf2VApUmWszSqwvbrsyE09AfjVP1xrdnpQh80/0APdx9r2lOyYIUMv8iroS8a3+8/SyOSBwxB4lZRqW9/vRvJuMnyKAbo7HuPoQlheqfiRN6q0H7tJHwjjHYm5tGRwBdQqTMNxjEF1aWITfJc/NUrU9WC015AMDpRpOt/PQsPYlb9+UgWVSgM9K7dDnFMPO68ikaD8XL8djK/kMWrMVcmA7Rt1RutjEVCVm2/gMp49Vb3wnET7cJiIU8oV025HlhXbVXeYJJ6Y8dEQCFtn4URMe1pypCH/ty2xQA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIuxvqYjwYWtsU3bPTbh79DJqV6Z3bv7cQtLbIB7MXE=;
 b=Z9AvLjNxxcnKLyf1MXE+M527DQkUAZG+mG8pLovQ4Ng+hZH/UHIuGPsjPC0XOAD6sLSxU258TbWYH81urzbtXJXMQHqhWQ+dimOK56hT/LYwVlJB/5oesIpUlCMCHEjngiGXNbv5p3FewwDBD6EQ4nZ9pUwvReN2Qu385HbpNPSETVAiDby3AUUFXeFFdXNp2ArU/IFul+AflHtOtvfnCKixvTZN6z6rgUQrMVRr26aBuizTgNh1jjF6/yClEcgIfoB76/9SH+TvImybM1RoeT++nsaebGWR5vgkngZRfDUeVQBSaYPiiBlwgkjXyG2UDhopTNd/Aozw0Qv+KiTWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIuxvqYjwYWtsU3bPTbh79DJqV6Z3bv7cQtLbIB7MXE=;
 b=VYSgW1EBV+BPeP8Lvu2uR4LJ0IRh1cVcmYJDuDsjEMbQ46a5CdPL2vhUOhVk3Z+DHHaGimlNgqL4bPeUlcXaC5ijodYdkHotSCt2TFAKG/SHe6jyG/HvMohz39IYGH5VviA/ayua95oa5dF3p4wa8TJiNraGo7zPrTy1jS3dNoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 19:51:31 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9%4]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 19:51:31 +0000
Message-ID: <582bf933-5260-5f5f-141f-8acb9bc8f4b1@amd.com>
Date: Fri, 28 Apr 2023 15:51:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
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
 <ac08c72e-ed64-09d3-1669-4f23ae0172a1@amd.com>
 <2d6e286d-3ba2-3510-4e24-0fe555aaa5dc@amd.com>
 <85469afd-57c2-d1b3-b897-ac2e1a9fe745@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <85469afd-57c2-d1b3-b897-ac2e1a9fe745@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:610:b2::17) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: c966a7d9-a90e-4cca-1cca-08db4821f66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlwMvUJgbVQ4ti8xkzVzQ7g51OH5wltufaRcKF1b0U/6DHDu0018lID3U1XqP40DY3rEMM+d2Dwl4S3r+/hERWmE7u20jzjamx/cgZveoGU8+L6RMzSA79Zh3/oSbCGeNoJROoVZM91zhh6ZHMVJoZr995tFUbaAvcGrecMf4eandlFwXDOo/3IdHz1Uyw03+YmgO+BS5q61Ef/+UQY4HjZ55bNsIBNnNoykZcbhJ4ZfkyUaNMyCujKCY+icp/yiwEefSsk//VLlhH7iKqK4SXxYv2uSQZgZFz2rw+QFkU07Oc5K9rohyX4x5hqBDwGXdycA7+FRphAgGN/leR04f/zWz/vsQfSZ96YqEQ+QoDaWQve7tBKrMuO9UxR2ytFg3L1/CpiI0fBQdcrARUkCBZ3suiw0oHTslC10zVU7Ia+UG6BOer2h1amLAXF26OWnBmx9WzpeJlxlL5dvaWP3rwCJh+olxujcwIVfooqCmPVqJ95RwMKXEax3K++8o9FBuWkaDPhhZ7ZWgM4yBc265EIsvZiaK9cFUDor+j1Ye+aA/KHfs275FKA2cObiShACbYsD2j3JyhojhJiDAAArO3c8mFkRv9YJNIEp6ZaqzXQkvVB1mahGC7sPkUzvSUduI+Y+5o6buO/s6ehI0KaYmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(316002)(26005)(6506007)(6512007)(66556008)(66476007)(31696002)(66946007)(86362001)(478600001)(66574015)(6666004)(6486002)(36756003)(83380400001)(110136005)(186003)(31686004)(2616005)(5660300002)(8936002)(8676002)(2906002)(30864003)(38100700002)(53546011)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0wraERpdDZuRkIrZk03VEpYTGFTeVB4UmNjYjBYU3p3L2dVbk4yUzMvTkxy?=
 =?utf-8?B?Ylp5QThiRGtMV3VTL29oY1JmR2QyRHZpQjhVNkQrRStyYzIyQXhXRUI1MEw0?=
 =?utf-8?B?eWlHMFVjMW1tQUpONEtOcXRSQy9sRkVUNUhzbnJIL01CSXhCc3lwZ3JxY29E?=
 =?utf-8?B?cHEwYWJxa2hHZ05jTFhYaE0wWkJzQjd4REQwaDhFRTVlQVFybGgzaDdBNTB4?=
 =?utf-8?B?ZzlpR004aCthUXRDN3ZreFhnZmx5MzRCM3J4MStOaGJ4dmF4U3FQN2VHc2ls?=
 =?utf-8?B?VVZsR2pjYUxnSE1OTjBwK1RXN3U2MHFMclFWdytDVFNuNUc4cXozQkNUMEdN?=
 =?utf-8?B?TElJMGNyYlJqUGRORTlYNU5DMGN2RDQrTjJpYzFYODRIZnVzdlB4TEFhK1Jo?=
 =?utf-8?B?S05ON093dktuakpNazg1TmlYZnczdG1yc0ZiL0JLZnpvRTZCUTBPK1V6NlV6?=
 =?utf-8?B?aXZ6S1ZnTXpHSjdFSzNKSnYvbmhCeXhMeElVOGJHaXhSVVBPYTB1NTdaZmds?=
 =?utf-8?B?Q2wwaCtOcUtPdVlidnlUWWc2eC8zcmRLT20wbjlnR2o3ZGtzTEcvajluWUR2?=
 =?utf-8?B?UDI1dUNMdDhQNkR5a25xa2h6ck1ONEtKZm1kZVFFS093Wm41bytVblg0bU1U?=
 =?utf-8?B?Vlc2clArWEh0WkZIaVhaWXpiOWQxMlh4RVQ4b3g1dzJZNDVETm1vdnkwTE92?=
 =?utf-8?B?YW12R0hEQWNWWXB4bEFVR2RwbmpJUW9wYlp5d1ZRMXlkVHZGWDRmYmJaWG5X?=
 =?utf-8?B?OUlicnNaSXRQamNlK1RUUFp2dHFZQmh1bDRjUm04R1NDeE4wbmtWcWdQOUpX?=
 =?utf-8?B?TEt3REFmZGZodWt0MHhGOEdsRXpXSnQzUmZZZ05KL0ZxYXBTUEhqaFVkS1Z2?=
 =?utf-8?B?UVJ3NlBucllWcWdlYzdWUXZETDlvbnlwczVNVHYweXplUVcyZHdNK3dXM0FK?=
 =?utf-8?B?Y1BjVnB0UkMzTE5ncUxmckFQTU9XK2NXZnJlK2ZhOE1nZ1VaTDZMRWVGSzFY?=
 =?utf-8?B?dkpLWXZOSFpPWGJZUzJveG9nN1VzR1VvZGtodGNmNTJmSGdYRzZxOG1KWGgw?=
 =?utf-8?B?NjYrREFJVFdFcStDNGJzRVMzQnhIejQxcG1yWFE5MVRQRE00cEhoMGZFSVUx?=
 =?utf-8?B?eVlFNUpQUXR0LzdCRU1ubWIzYjlGUU9DQytpYzRJTkN0RlF6ZERUeXo2bFZr?=
 =?utf-8?B?dVpNYkNOaGN6TU85Ny9pV0QrbkpkbWhYNkdOVlJXcEFhWTFCQVBxYkgxUkhi?=
 =?utf-8?B?WE1wSEZhMzl1MDNrdFJHSE9zT1FWWkgyV0ZCaGRXUG12TDgrRld0eVhWSW9v?=
 =?utf-8?B?Zkd0WWRrYzljc3pqZXRGaDlTYkZjcWd0ZWM5aVFjUzRiaTdJSVdKS1prMWRJ?=
 =?utf-8?B?aEFtRG5TL1gvQlYrQncrN1NaSUgrcXVYeWQrd0owK2xTdzRHalJsSVJsNTd3?=
 =?utf-8?B?U2hWdXRQZFF5TjBpeGpNbU1ZdGV2RU1NNGswNVFvNmxITjFDTkdrWStrNnFq?=
 =?utf-8?B?eU9nTDFpYk1RejFIL3F3MXNFWDBYVGFSRkVKWUVIUkxGQ1Z0eE5Hay9aYW1k?=
 =?utf-8?B?eHBCWHg1RHpnRGZ0SGFlTEFqZkN5cW5XZVVtWkhMajh4ZlF4QXJBSTNWdkFy?=
 =?utf-8?B?L0dXOWVGZnc1aTVnL205WmFQcWU3UHVFblBGZWZSUTcrSUlSNDFma0JOVkQ2?=
 =?utf-8?B?NE9naXlDbmJqNTVRanpod2dpd2ZTSlRMaEtQdVNCSlovSEMvRS95azhYZmpl?=
 =?utf-8?B?SW5IR3V1ZXRORk15VktDSXFncDJ4WFlSejZXNEdPY3podEZSSlgrM0Q3S3JT?=
 =?utf-8?B?b2NHMVBPZitmRlRrWlRsNWthK3ZxUjdkUGM3cWo5Z3hKTDRrVjV3SjhpSGZV?=
 =?utf-8?B?MEJJa3dDRms2S1ZuY2duS3pFVmVnL3Ftd0gxN3E1ZVBNcHV0MlNzcGw5VmJ3?=
 =?utf-8?B?dlcza0RIaXlmZVVwU1A1eERDNmt4UjNwd1ZJVm1ZZTBOMk1KbnVOQVV6ZnZU?=
 =?utf-8?B?QmhBb1BMdmloNHJ1OWdvU0JKR1lYaWRncGsyZVF2NVd1ejNURmpTQ2NSSWoz?=
 =?utf-8?B?RkZ1MitBZVhucUFqVnBwK1RyMUFITkRsQ1lZdUpKMEtDWlFMWVFqbjF6RFNL?=
 =?utf-8?Q?d84IeVFQSVY+A5scbTCB84pG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c966a7d9-a90e-4cca-1cca-08db4821f66a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:51:30.9930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/v7Dx48VedXmXZsGoDl8DoJlktbRg+BKUmeMFGUtK1EhGNoJHOgJpPRMqVLlBWz5I1QE2P80kBIghZzyVMAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
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



On 2023-04-28 15:42, Felix Kuehling wrote:
> On 2023-04-28 14:09, Eric Huang wrote:
>>
>> On 2023-04-28 12:41, Felix Kuehling wrote:
>>> On 2023-04-28 10:17, Eric Huang wrote:
>>>>
>>>> On 2023-04-27 23:46, Kuehling, Felix wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> Re-mapping typically happens after evictions, before a new 
>>>>> eviction fence gets attached. At that time the old eviction fence 
>>>>> should be in the signaled state already, so it can't be signaled 
>>>>> again. Therefore I would expect my patch to help with unmapping 
>>>>> the DMABuf import, without breaking the eviction case.
>>>>>
>>>>> Are you talking about remapping with a map-to-gpu call from user 
>>>>> mode? I think that would only be a problem if the KFD BO was 
>>>>> unmapped and remapped multiple times. The first time it's mapped, 
>>>>> the fresh dmabuf import should be in the SYSTEM domain, so the 
>>>>> validation in the SYSTEM domain before GTT would be a no-op.
>>>> Yes. The case scenario I am talking about is from user mode, 
>>>> mapping->unmapping->re-mapping to the KFD GTT BO will trigger the 
>>>> eviction.
>>>>>
>>>>> I sort of agree that we don't really rely on the eviction fence on 
>>>>> the DMABuf import. The reservation object is shared with the 
>>>>> original BO. Moving the original BO triggers the eviction fence, 
>>>>> so we don't need to trigger it again on the dmabuf import. Other 
>>>>> than moving the original BO, I don't think we can do anything to 
>>>>> the DMABuf import that would require an eviction for KFD use case. 
>>>>> It is a special use case because we control both the import and 
>>>>> the export in the same context.
>>>> I am thinking about no adding KFD eviction fence in first place of 
>>>> mapping original GTT BO, because I don't see it can be evicted in 
>>>> any cases.
>>>
>>> That's not an option. We're not adding an eviction fence. The 
>>> reservation object with the eviction fence is shared between the 
>>> exported BO and the imported one. That's just how DMABuf works. If 
>>> you wait for the fences on the imported BO, you are effectively 
>>> waiting for the fences on the exported BOs. And you can't remove the 
>>> eviction fence from the exported BO.
>>
>> What if the exported BO will be never evicted in reality? I 
>> understand how DMABuf works, and imported BO doesn't have eviction 
>> fence, it shares with exported BO's one if eviction happens, but I 
>> don't see the exported BO can be evicted.
>
> The exported BO can be evicted like any other BO. For example 
> KFDEvictTest is there to cause and test evictions of KFD VRAM BOs. 
> Exporting the BO does not pin it (if DMABUF_MOVE_NOTIFIER is enabled, 
> which it in the upstream kernel), so the exported BO can still be 
> evicted.

Yes. KFD VRAM BO can be evicted, but DMABuf 's original exported BO is 
non-paged/GTT BO. Can GTT BO be evicted? It should be like paged/userptr 
that doesn't have KFD eviction fence.

Regards,
Eric

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Eric
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> In theory GTT BO is mapped by user calling mmap() in system memory 
>>>> like userptr, unlike VRAM it will be not evicted by amdgpu vram 
>>>> manager. The only thing is CPU invalidation, but GTT BO doesn't 
>>>> register mmu notifier, that will be a potential problem when 
>>>> switching paged/userptr to non-paged/GTT for mes scheduler.
>>>>
>>>> Regards,
>>>> Eric
>>>>>
>>>>> In the general case dmabuf imports need their eviction fences. For 
>>>>> example when we're importing a DMABuf from somewhere else, so the 
>>>>> eviction fence is not shared with a BO that we already control. 
>>>>> Even then, unmapping a dmabuf from our KFD VM does not need to 
>>>>> wait for any fences on the DMABuf.
>>>>>
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>> -----Original Message-----
>>>>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>>>>> Sent: Thursday, April 27, 2023 14:58
>>>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian 
>>>>> <Christian.Koenig@amd.com>; Christian König 
>>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>>> Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences 
>>>>> invalidating preemptible DMABuf imports
>>>>>
>>>>> Hi Felix,
>>>>>
>>>>> I tested your patch on mGPU systems. It doesn't break any KFD 
>>>>> eviction tests, because tests don't allocate DMABuf import, that 
>>>>> doesn't trigger it's eviction fence. The only thing the patch 
>>>>> affects is in re-mapping DMABuf imports that the eviction will 
>>>>> still be triggered.
>>>>>
>>>>> I have an idea that we probably can remove eviction fence for GTT 
>>>>> bo, because currently the only way to trigger the eviction fence 
>>>>> is by calling ttm_bo_validate for CPU domain in 
>>>>> kfd_mem_dmaunmap_dmabuf. Do you know there is other case to 
>>>>> trigger GTT bo's eviction?
>>>>>
>>>>> Regards,
>>>>> Eric
>>>>>
>>>>> On 2023-04-26 22:21, Felix Kuehling wrote:
>>>>>> Hi Eric,
>>>>>>
>>>>>> Can you try if the attached patch fixes the problem without breaking
>>>>>> the eviction tests on a multi-GPU PCIe P2P system?
>>>>>>
>>>>>> Thanks,
>>>>>>    Felix
>>>>>>
>>>>>>
>>>>>> On 2023-04-26 13:02, Christian König wrote:
>>>>>>> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>>>>>>> On 2023-04-26 9:03, Christian König wrote:
>>>>>>>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>>>>>>>> Hi Christian,
>>>>>>>>>>
>>>>>>>>>> What do you think about Felix's explanation?
>>>>>>>>> That's unfortunately not something we can do here.
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Eric
>>>>>>>>>>
>>>>>>>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>>>>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>>>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import bo
>>>>>>>>>>>>>> when dmaunmapping DMAbuf. The DMAbuf import bo has been 
>>>>>>>>>>>>>> set as
>>>>>>>>>>>>>> AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'd like to get an Acked-by from Christian as well before
>>>>>>>>>>>>> submitting this.
>>>>>>>>>>>> I have to admit that I only partially followed the internal
>>>>>>>>>>>> discussion, but in general you need a *really* good 
>>>>>>>>>>>> explanation
>>>>>>>>>>>> for this.
>>>>>>>>>>>>
>>>>>>>>>>>> E.g. add code comment and explain in the commit message
>>>>>>>>>>>> extensively why this is needed and why there are no 
>>>>>>>>>>>> alternatives.
>>>>>>>>>>> OK. I'll give it a shot:
>>>>>>>>>>>
>>>>>>>>>>>     This code path is used among other things when invalidating
>>>>>>>>>>> DMABuf
>>>>>>>>>>>     imports. These imports share a reservation object with the
>>>>>>>>>>> exported
>>>>>>>>>>>     BO. Waiting on all the fences in this reservation will 
>>>>>>>>>>> trigger
>>>>>>>>>>> KFD
>>>>>>>>>>>     eviction fences unnecessarily, for example when a DMABuf
>>>>>>>>>>> import for
>>>>>>>>>>>     a DMA mapping on a secondary GPU is being unmapped 
>>>>>>>>>>> explicitly.
>>>>>>>>>>> Only
>>>>>>>>>>>     moving the original exported BO requires stopping KFD user
>>>>>>>>>>> mode
>>>>>>>>>>>     queues. If the invalidation is triggered through a move
>>>>>>>>>>> notifier
>>>>>>>>>>>     from the exported BO, then moving the original BO already
>>>>>>>>>>> triggered
>>>>>>>>>>>     the eviction fence and we don't need to wait for it 
>>>>>>>>>>> again on
>>>>>>>>>>> the import.
>>>>>>>>>>>
>>>>>>>>>>>     We can identify DMABuf imports in KFD for secondary GPU DMA
>>>>>>>>>>> mappings
>>>>>>>>>>>     by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>>>>>>>>     operation that ignores KFD eviction fences.
>>>>>>>>>>>
>>>>>>>>>>> How does this sound?
>>>>>>>>> To be honest like quite a bad idea. Why in the world are imported
>>>>>>>>> BOs moved from GTT to SYSTEM in the first place?
>>>>>>>> As I understand it, the way to update SG tables in SG BOs (e.g.
>>>>>>>> userptr and dmabuf imports) is to move them back and forth between
>>>>>>>> system and GTT domains. If we left the import in the GTT domain 
>>>>>>>> all
>>>>>>>> the time, we would have no way to update it, e.g. after an 
>>>>>>>> eviction.
>>>>>>>> Currently the move to the system domain is done in the unmap 
>>>>>>>> code path.
>>>>>>>>
>>>>>>>> Before memory is freed, we also need to unmap it from GPUVM,
>>>>>>>> including the DMABuf imports on remote GPUs. For the above reason
>>>>>>>> that currently includes moving the import to the system domain. If
>>>>>>>> we removed that from the unmap code path, we'd need to do the move
>>>>>>>> to system somewhere else, maybe in the mapping/validation path.
>>>>>>>>
>>>>>>>>
>>>>>>>>> The only reason for this I can think of is that the DMA mappings
>>>>>>>>> become invalid for some reasons and in this case waiting for the
>>>>>>>>> KFD fence is actually the absolutely right thing to do.
>>>>>>>> In this case the reason the only reason for unmapping the 
>>>>>>>> memory is
>>>>>>>> that we're about to free the memory and its DMABuf imports on 
>>>>>>>> other
>>>>>>>> GPUs. This is coming from the application with a promise "I'm no
>>>>>>>> longer accessing the memory". We don't need to wait for fences 
>>>>>>>> here.
>>>>>>>> We only need to invalidate the PTEs to make sure that any further
>>>>>>>> buggy access by the application will fault.
>>>>>>> Well in this case just free the BO and it's bo_va structure. The 
>>>>>>> core
>>>>>>> handling should take care of clearing all the freed up regions.
>>>>>>>
>>>>>>> As for updating the SG of a BO you indeed need to move it from 
>>>>>>> GTT to
>>>>>>> SYSTEM and back, but in this case we should either indeed wait for
>>>>>>> the KFD fence since page tables in between the operation still have
>>>>>>> the old entries or we should destroy the BO and create a new 
>>>>>>> one. The
>>>>>>> later would overwrite the PTEs with invalid entries first and then
>>>>>>> fill in new valid ones.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Regards,
>>>>>>>>    Felix
>>>>>>>>
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>>    Felix
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>> Christian.
>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>    Felix
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct
>>>>>>>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>>>>>>>        if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>>>>>>>             old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>>>>>>>            new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>>>>>>>> + AMDGPU_FENCE_OWNER_KFD,
>>>>>>>>>>>>>> + ctx->interruptible);
>>>>>>>>>>>>>> +        else
>>>>>>>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>>>>            if (r)
>>>>>>>>>>>>>>                return r;
>>>>
>>

