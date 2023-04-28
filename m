Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FC6C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57ECB10EDE9;
	Fri, 28 Apr 2023 19:56:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B391010EDE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWrGa2oJh6C1CtfFv6jzT6Vr/96ms33Joya96EUVfqmL3ZPuYnUfA1oEKz5b9Vp+PkhZO5CFNwjKnvBvvfxmHQpB123+uaIIP/e13sMjRhOwVbT0C82M7XoqTlGfx4modaetVyLfB4qXwhCGIGy6DDSGHsZ5MLsY8s0zFJUNN0dQ64ubg9TT2dtFF9I2vwGslEQCMMAUD2pBdeFy47YXKrlkBLitdH16j7dMCKBzSf/ceK40bozJBZNWR6dB3SQLHsKEgrLOdjgpGe9FSt91V5iAZNTp2XfL8XFkIItjiCvs8X9n5fvW1sXChWNervoDZMSzqAQx1yMB6dmR6+TCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Beo4IgwrgatKq2uNcdg4zwamlqM0FimcjHOkCqDAFI=;
 b=f6XfOT6h2VDNRnGdc0Rd6kpxrbtgNu6G8ZlDkZrROHilzuS8VPmfnwfzleK1p437CiupBChYOtUWCM600IKRCHP5aRUSSvvklu3yFlCCjaMpyAKeBoA/R8B4HKo2REOnZD8nk0lu0QUC3rSzb6VXpECNEY6NdIhnjSIDL2x0NKubqVJ+DVN1zqNLRVMu+EbDrCqgPtIBQaSzpFzWmo3gfbT8EzOEe6IPFJksIiV0XOX62Atsq2aU+vb31juIBJI+LcAUABKD+NNfyqTsGajY7P0GHcLo1Yb9I2DHK0GXViVfyzZPMRW2So2zOg3HAr9ZwJP/hfTjP/NzOcw1LKaAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Beo4IgwrgatKq2uNcdg4zwamlqM0FimcjHOkCqDAFI=;
 b=5GQ81OxO6nZfgln6XIz3v1toByotOcsJbgfYo6xoYTTk6FWvQg5tLQeHEKMEeETB8cJ0vQlCyP5CSeVVdJh3Ooh+vgbojkof0zoKRS5DroG7QL1/fS0k/OmdMbenAu12W1M9aQuRP0oJOiWjhuzwN6PRQs7G+Mm6mXyPez74DUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 19:56:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 19:56:28 +0000
Message-ID: <96c90859-77c0-b22c-c3f9-9526e0eabac5@amd.com>
Date: Fri, 28 Apr 2023 14:56:26 -0500
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
 <ac08c72e-ed64-09d3-1669-4f23ae0172a1@amd.com>
 <2d6e286d-3ba2-3510-4e24-0fe555aaa5dc@amd.com>
 <85469afd-57c2-d1b3-b897-ac2e1a9fe745@amd.com>
 <582bf933-5260-5f5f-141f-8acb9bc8f4b1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <582bf933-5260-5f5f-141f-8acb9bc8f4b1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:76::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: de8795d9-6926-409a-dc10-08db4822a7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3dGuuN0/JO0OID+gh74e9SaSj4g5Pf1k2vHYZDN8QA8X89IBIYxyhxW+vMqua8P2+45YcHhSSJNRB1gfX7cwOfeNOVMaa4yWDst+Hpvhxu/4poLJLV8DgByz5N8pUf7pcuImcEpF6wHWu+KgSoYKfiO1OX2eeHYUnkBpk8Zaj/V2y3kYb0otDEh27mk7e8k5TrZctOGOYVF0uCNdHEEnQHj7BYoO7TO8jYX8jFb+8uaeKV7pdFQPjDi3NfoHQNltEDItjid+sd+uzCRJgNLXreN0ltBragE5Qok7w+auhpSxjsbbCVu2PCpbjJNvy8il7h05NfoU8WDaZ/rS6OVLOQ7bVyITK5CMuDfbIdgkeXa9RTVRvL3780tAvcibpto2nYRwVr4PAkkGQ3fjguAtdg+gX6wEO6kgowmwUT0hpCOZMiNGi6LkXt9iz83Iau/lP/Sd5FXLzN05jwAUULkTMyMkIxp+0WpmGTOFH+a0+e6F6xnxsQHuPy3zaUN6eHnAlCUrVsa8ThxsmafUN8RIodn0j7gB0b3PcpMU95umEj+G706AqEe8j5Vwp+RlgEge+vUKIsQHqLizFhc/33ydqnN3LqvUc3R5HrSXmANZFt7jy/4jNiSPqmivTOnpX0S8/GdiDWC0W4PvJ1mR1hS2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(478600001)(31686004)(6486002)(110136005)(30864003)(66556008)(8936002)(8676002)(2906002)(66946007)(66476007)(5660300002)(26005)(186003)(6506007)(6512007)(53546011)(66574015)(316002)(2616005)(41300700001)(83380400001)(36756003)(38100700002)(86362001)(44832011)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXR2YXBGMi84RTA2cG4zeTdrTFl5TVF6ZWpoNWJwd2tHV0xsbllodjdHRDJN?=
 =?utf-8?B?UkF1aDZOYVlJL3VYdFJKNGRRV3gyTzVMeStwSTRzeDlDMHJmamNnV1JrUTR0?=
 =?utf-8?B?Nk9UbnRSNGdhbTlkWVF3TTlzeFdjMGtmOEVQeHlIYkhWVjRVTW1sTTlMNjl4?=
 =?utf-8?B?TnF1MXpyVVh4cXV0eUc5RzNTeE9hRTV3dmlqN3l6NXh6K3hCVXBFc1ZQWHda?=
 =?utf-8?B?SStJWStrMWlXR1g5VWdQUHUzSEw1ajlMZVBJYzdkalAyenZIODNMTnROcFhX?=
 =?utf-8?B?aTk3QnhFc0NZcFY3UWQ0d3UxL0lBQW5NMUt0ajJUY3JQVE0waUViazZNOFc1?=
 =?utf-8?B?bHFvTFlGZ2c4RkpRNVRyWG9PN3puOThTbTRiRWl5b1lQSzVtOTcyNXZBMkFS?=
 =?utf-8?B?TGtnZm5remxVOUp4cVZxQ1dtOGxFUEJxV1JCU3pzSkw3QzBoakR3ZHVraEVD?=
 =?utf-8?B?UGl1MFZ6VVU5THFudFJYckZ5SXN2YitCejhSZFJ0SnNGbkZVUksrcHJsMjBl?=
 =?utf-8?B?ZTZ4d0I2MGdoVWQ1eVhubCtIVjdqb2x1MGg1WUN1QmdqSFNpWjZ3b3NMcDR5?=
 =?utf-8?B?ZGluNEFpemtiRFhjazl2MDM4bTNOZkVLRTJuMlRtTTVEUUtCMmhNWGk4Mzdm?=
 =?utf-8?B?WnQ1bks3ZFpOY2hieFU1TUtWclplZVljUEhQKzh1bFZpWFBzYVpuWjV1OVFk?=
 =?utf-8?B?aG84Q29aczlBbEdEbnNyY3pFcHZ1ZWQ3Z2htNFgraU9zMTk1eWFXeUt5clc2?=
 =?utf-8?B?bmpoTzVXSncyUmxvS1ZJNzMwcjBRL2NjLzVhVFB6S0dWd1Y1RFR2Qm5JMHdH?=
 =?utf-8?B?cW1WdTJCMDlYaFkzMzJwUlVIT3ZwMzVOUXJUUGZaWisyQnVxWjRrYm5JQ1RX?=
 =?utf-8?B?RHpqUFRrVWpwaWlVdTJRSXVDSGZsdkExUDQzdk1kYzdjRlRRRklUNzZYZGN2?=
 =?utf-8?B?RjRlQjZDcjhTOUxjT3JpenJCbGpzSkVOdytOWjNFQ1VqUmhiSGxrYmJuWTVq?=
 =?utf-8?B?M3I4MmZQcEFidTJXcVVmdWZLYmpJMDFpOVlGd3lhYVR6TzZrc3k2ai80QVBr?=
 =?utf-8?B?VWYwa2xUcVp2alo1TzU5NXJycmZlc0ZIK3VZaHJoREhESmRuSE1hdmNET1pE?=
 =?utf-8?B?MEJOd0c2UkxYS0pxK2NURzFibi9oYyt2eFFjQU9GcmFiL2J0bXkxdEZnZUJL?=
 =?utf-8?B?R29NdlBhNm94eHJWZkZSbDFlVU9rV3FqL05CMGxLdnZNSk9JMmxHWTJ1enk3?=
 =?utf-8?B?VTc5YUpNNHFvOW5LbTZ3c1AwOGg4ZWJrVFJDcWdmQllHcjFHRzkyZkM0eGRN?=
 =?utf-8?B?cllOV2EycmdiNDhxZ3lXL1o1aERZL1YvWHJmMFBZMDVuaTZiNG5jSmxadVFK?=
 =?utf-8?B?UkFWVmVZSnU3OGFydE5UYnpSV0xTbFRnSjN3WXVDVlU4ejNCSHJXM2g1S2Ni?=
 =?utf-8?B?YzlQb3dkeDkzUUN4TDBhbDkyeVFGQ0wzUU4rUTVDdXVvVnBiV1lwQnZ5cnZu?=
 =?utf-8?B?OUk0cDRqbU9PdmN0L2NMNWxEZ2FKWXkxUGwyTHVjMUZNaktwL2l0cjloWStq?=
 =?utf-8?B?RGRrZWpJM08rV2N5MCtWZVVyNWlRdEc2N2JOL1hoVkQra1daQThSTlc4YmxC?=
 =?utf-8?B?T1JVUm9WZkljZXduZ0R2Yk14b0JNRU9VQzRqSml4bnk0TkF5b0VLSGYva1lN?=
 =?utf-8?B?Y3lWc0srWGlMaGM1V241L0ZhL2xTM3hrZUhVamVIOU93L3pmR0VINEVqTURt?=
 =?utf-8?B?SUc3OHF3RTFVNUxQZVVVcG1wNkZjQmMxWUR2cm1xcTdvT3VwaHZCTVlpbzY0?=
 =?utf-8?B?N3lKNDRpeVFjbm9COERlNVZlYnUvOW9ta1FJVFpKVVpreDlNQTRScFAxaVdP?=
 =?utf-8?B?U1hkQit4b0pudlNJUVBqV09YRGkwakhRS0V4RWhMaWwraXlBY1pzeUNGdEdD?=
 =?utf-8?B?Y2NOV1pnQ1VqaEk2YnkwS3FuM1Z4b29oa0NSYllpNjNSRk5tNDlXNjlQYmZk?=
 =?utf-8?B?NHpWOUxuR3pXWDZSQUVvaThWYjJWZldqK1E1ZGJHMXJtcVl3b2ZVUGxwSmtL?=
 =?utf-8?B?eGU0OThDb1ZFWW05Si9lbzZaZWt4R0JOKys0MXdOZkF1Mm5oUERKTkthWkNv?=
 =?utf-8?Q?oQBuYUKZqhK82ju2tn4d0O3ye?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8795d9-6926-409a-dc10-08db4822a7d5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:56:28.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO/Dl3dgF+aQDZ1QjCHnp+b+kpH3/ZgxAkjMewzk2qEbT+EEXXqRgSdH0RvST1yWIMBjCR3Tw78QMdq+0ASdbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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

On 2023-04-28 14:51, Eric Huang wrote:
>
>
> On 2023-04-28 15:42, Felix Kuehling wrote:
>> On 2023-04-28 14:09, Eric Huang wrote:
>>>
>>> On 2023-04-28 12:41, Felix Kuehling wrote:
>>>> On 2023-04-28 10:17, Eric Huang wrote:
>>>>>
>>>>> On 2023-04-27 23:46, Kuehling, Felix wrote:
>>>>>> [AMD Official Use Only - General]
>>>>>>
>>>>>> Re-mapping typically happens after evictions, before a new 
>>>>>> eviction fence gets attached. At that time the old eviction fence 
>>>>>> should be in the signaled state already, so it can't be signaled 
>>>>>> again. Therefore I would expect my patch to help with unmapping 
>>>>>> the DMABuf import, without breaking the eviction case.
>>>>>>
>>>>>> Are you talking about remapping with a map-to-gpu call from user 
>>>>>> mode? I think that would only be a problem if the KFD BO was 
>>>>>> unmapped and remapped multiple times. The first time it's mapped, 
>>>>>> the fresh dmabuf import should be in the SYSTEM domain, so the 
>>>>>> validation in the SYSTEM domain before GTT would be a no-op.
>>>>> Yes. The case scenario I am talking about is from user mode, 
>>>>> mapping->unmapping->re-mapping to the KFD GTT BO will trigger the 
>>>>> eviction.
>>>>>>
>>>>>> I sort of agree that we don't really rely on the eviction fence 
>>>>>> on the DMABuf import. The reservation object is shared with the 
>>>>>> original BO. Moving the original BO triggers the eviction fence, 
>>>>>> so we don't need to trigger it again on the dmabuf import. Other 
>>>>>> than moving the original BO, I don't think we can do anything to 
>>>>>> the DMABuf import that would require an eviction for KFD use 
>>>>>> case. It is a special use case because we control both the import 
>>>>>> and the export in the same context.
>>>>> I am thinking about no adding KFD eviction fence in first place of 
>>>>> mapping original GTT BO, because I don't see it can be evicted in 
>>>>> any cases.
>>>>
>>>> That's not an option. We're not adding an eviction fence. The 
>>>> reservation object with the eviction fence is shared between the 
>>>> exported BO and the imported one. That's just how DMABuf works. If 
>>>> you wait for the fences on the imported BO, you are effectively 
>>>> waiting for the fences on the exported BOs. And you can't remove 
>>>> the eviction fence from the exported BO.
>>>
>>> What if the exported BO will be never evicted in reality? I 
>>> understand how DMABuf works, and imported BO doesn't have eviction 
>>> fence, it shares with exported BO's one if eviction happens, but I 
>>> don't see the exported BO can be evicted.
>>
>> The exported BO can be evicted like any other BO. For example 
>> KFDEvictTest is there to cause and test evictions of KFD VRAM BOs. 
>> Exporting the BO does not pin it (if DMABUF_MOVE_NOTIFIER is enabled, 
>> which it in the upstream kernel), so the exported BO can still be 
>> evicted.
>
> Yes. KFD VRAM BO can be evicted, but DMABuf 's original exported BO is 
> non-paged/GTT BO. Can GTT BO be evicted? It should be like 
> paged/userptr that doesn't have KFD eviction fence.

GTT BOs could be evicted if we're out of GTT space, though that's very 
unlikely. We usually use GTT BOs for things that need to be mapped in 
kernel mode (e.g. signal pages), which means they are pinned and they 
won't be evicted.

But the same DMABuf attachment mechanism is also used for VRAM, which 
can be evicted. We need a common solution that will prevent unnecessary 
evictions with VRAM mapped on PCIe P2P multi-GPU systems.

Regards,
   Felix


>
> Regards,
> Eric
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Eric
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> In theory GTT BO is mapped by user calling mmap() in system memory 
>>>>> like userptr, unlike VRAM it will be not evicted by amdgpu vram 
>>>>> manager. The only thing is CPU invalidation, but GTT BO doesn't 
>>>>> register mmu notifier, that will be a potential problem when 
>>>>> switching paged/userptr to non-paged/GTT for mes scheduler.
>>>>>
>>>>> Regards,
>>>>> Eric
>>>>>>
>>>>>> In the general case dmabuf imports need their eviction fences. 
>>>>>> For example when we're importing a DMABuf from somewhere else, so 
>>>>>> the eviction fence is not shared with a BO that we already 
>>>>>> control. Even then, unmapping a dmabuf from our KFD VM does not 
>>>>>> need to wait for any fences on the DMABuf.
>>>>>>
>>>>>> Regards,
>>>>>>    Felix
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>>>>>> Sent: Thursday, April 27, 2023 14:58
>>>>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian 
>>>>>> <Christian.Koenig@amd.com>; Christian König 
>>>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>>>> Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences 
>>>>>> invalidating preemptible DMABuf imports
>>>>>>
>>>>>> Hi Felix,
>>>>>>
>>>>>> I tested your patch on mGPU systems. It doesn't break any KFD 
>>>>>> eviction tests, because tests don't allocate DMABuf import, that 
>>>>>> doesn't trigger it's eviction fence. The only thing the patch 
>>>>>> affects is in re-mapping DMABuf imports that the eviction will 
>>>>>> still be triggered.
>>>>>>
>>>>>> I have an idea that we probably can remove eviction fence for GTT 
>>>>>> bo, because currently the only way to trigger the eviction fence 
>>>>>> is by calling ttm_bo_validate for CPU domain in 
>>>>>> kfd_mem_dmaunmap_dmabuf. Do you know there is other case to 
>>>>>> trigger GTT bo's eviction?
>>>>>>
>>>>>> Regards,
>>>>>> Eric
>>>>>>
>>>>>> On 2023-04-26 22:21, Felix Kuehling wrote:
>>>>>>> Hi Eric,
>>>>>>>
>>>>>>> Can you try if the attached patch fixes the problem without 
>>>>>>> breaking
>>>>>>> the eviction tests on a multi-GPU PCIe P2P system?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>    Felix
>>>>>>>
>>>>>>>
>>>>>>> On 2023-04-26 13:02, Christian König wrote:
>>>>>>>> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>>>>>>>> On 2023-04-26 9:03, Christian König wrote:
>>>>>>>>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>>>>>>>>> Hi Christian,
>>>>>>>>>>>
>>>>>>>>>>> What do you think about Felix's explanation?
>>>>>>>>>> That's unfortunately not something we can do here.
>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Eric
>>>>>>>>>>>
>>>>>>>>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>>>>>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>>>>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>>>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf 
>>>>>>>>>>>>>>> import bo
>>>>>>>>>>>>>>> when dmaunmapping DMAbuf. The DMAbuf import bo has been 
>>>>>>>>>>>>>>> set as
>>>>>>>>>>>>>>> AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'd like to get an Acked-by from Christian as well before
>>>>>>>>>>>>>> submitting this.
>>>>>>>>>>>>> I have to admit that I only partially followed the internal
>>>>>>>>>>>>> discussion, but in general you need a *really* good 
>>>>>>>>>>>>> explanation
>>>>>>>>>>>>> for this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> E.g. add code comment and explain in the commit message
>>>>>>>>>>>>> extensively why this is needed and why there are no 
>>>>>>>>>>>>> alternatives.
>>>>>>>>>>>> OK. I'll give it a shot:
>>>>>>>>>>>>
>>>>>>>>>>>>     This code path is used among other things when 
>>>>>>>>>>>> invalidating
>>>>>>>>>>>> DMABuf
>>>>>>>>>>>>     imports. These imports share a reservation object with the
>>>>>>>>>>>> exported
>>>>>>>>>>>>     BO. Waiting on all the fences in this reservation will 
>>>>>>>>>>>> trigger
>>>>>>>>>>>> KFD
>>>>>>>>>>>>     eviction fences unnecessarily, for example when a DMABuf
>>>>>>>>>>>> import for
>>>>>>>>>>>>     a DMA mapping on a secondary GPU is being unmapped 
>>>>>>>>>>>> explicitly.
>>>>>>>>>>>> Only
>>>>>>>>>>>>     moving the original exported BO requires stopping KFD user
>>>>>>>>>>>> mode
>>>>>>>>>>>>     queues. If the invalidation is triggered through a move
>>>>>>>>>>>> notifier
>>>>>>>>>>>>     from the exported BO, then moving the original BO already
>>>>>>>>>>>> triggered
>>>>>>>>>>>>     the eviction fence and we don't need to wait for it 
>>>>>>>>>>>> again on
>>>>>>>>>>>> the import.
>>>>>>>>>>>>
>>>>>>>>>>>>     We can identify DMABuf imports in KFD for secondary GPU 
>>>>>>>>>>>> DMA
>>>>>>>>>>>> mappings
>>>>>>>>>>>>     by the mem_type AMDGPU_PL_PREEMPT. In this case, use a 
>>>>>>>>>>>> wait
>>>>>>>>>>>>     operation that ignores KFD eviction fences.
>>>>>>>>>>>>
>>>>>>>>>>>> How does this sound?
>>>>>>>>>> To be honest like quite a bad idea. Why in the world are 
>>>>>>>>>> imported
>>>>>>>>>> BOs moved from GTT to SYSTEM in the first place?
>>>>>>>>> As I understand it, the way to update SG tables in SG BOs (e.g.
>>>>>>>>> userptr and dmabuf imports) is to move them back and forth 
>>>>>>>>> between
>>>>>>>>> system and GTT domains. If we left the import in the GTT 
>>>>>>>>> domain all
>>>>>>>>> the time, we would have no way to update it, e.g. after an 
>>>>>>>>> eviction.
>>>>>>>>> Currently the move to the system domain is done in the unmap 
>>>>>>>>> code path.
>>>>>>>>>
>>>>>>>>> Before memory is freed, we also need to unmap it from GPUVM,
>>>>>>>>> including the DMABuf imports on remote GPUs. For the above reason
>>>>>>>>> that currently includes moving the import to the system 
>>>>>>>>> domain. If
>>>>>>>>> we removed that from the unmap code path, we'd need to do the 
>>>>>>>>> move
>>>>>>>>> to system somewhere else, maybe in the mapping/validation path.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> The only reason for this I can think of is that the DMA mappings
>>>>>>>>>> become invalid for some reasons and in this case waiting for the
>>>>>>>>>> KFD fence is actually the absolutely right thing to do.
>>>>>>>>> In this case the reason the only reason for unmapping the 
>>>>>>>>> memory is
>>>>>>>>> that we're about to free the memory and its DMABuf imports on 
>>>>>>>>> other
>>>>>>>>> GPUs. This is coming from the application with a promise "I'm no
>>>>>>>>> longer accessing the memory". We don't need to wait for fences 
>>>>>>>>> here.
>>>>>>>>> We only need to invalidate the PTEs to make sure that any further
>>>>>>>>> buggy access by the application will fault.
>>>>>>>> Well in this case just free the BO and it's bo_va structure. 
>>>>>>>> The core
>>>>>>>> handling should take care of clearing all the freed up regions.
>>>>>>>>
>>>>>>>> As for updating the SG of a BO you indeed need to move it from 
>>>>>>>> GTT to
>>>>>>>> SYSTEM and back, but in this case we should either indeed wait for
>>>>>>>> the KFD fence since page tables in between the operation still 
>>>>>>>> have
>>>>>>>> the old entries or we should destroy the BO and create a new 
>>>>>>>> one. The
>>>>>>>> later would overwrite the PTEs with invalid entries first and then
>>>>>>>> fill in new valid ones.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>    Felix
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>>    Felix
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>    Felix
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct
>>>>>>>>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>>>>>>>>        if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>>>>>>>>             old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>>>>>>>>            new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>>>>>>>>> + AMDGPU_FENCE_OWNER_KFD,
>>>>>>>>>>>>>>> + ctx->interruptible);
>>>>>>>>>>>>>>> +        else
>>>>>>>>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>>>>>            if (r)
>>>>>>>>>>>>>>>                return r;
>>>>>
>>>
>
