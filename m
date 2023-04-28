Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB8AC7EE21
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 15:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3AD10E3F6;
	Fri, 28 Apr 2023 15:17:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9E910E3E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 15:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSkrt0BNlSG2sYd8lgpg8JrgaJQiPkpXICnsEo70GX0bbZFPjjhCnb+yktoU0sCwjKHgH5OUGpwLx8TqF+G9RRvWGCDjjEg7hYGwghClqui1h0k1uGzA6AzDdr6qBmgBYxYB5Fu/0IHZc0UksE3FSnI6P9ZHUhRN8eUCDJLunJcTz6LNKVT4X5IsfrcUC98PFKsIwT47gfAbvynS/a0FGnnTtRjFBiUQF9PwXfk4N4Avs/Gpbu7dNny4dnTHFnaiBZAGa7lOEjqtBzrCz9pcP90EXz+pqej74y0nQgp8mQfBCibXFIL9xd3yelFw0u+R67lnTD2NWy8IyUqYeDqRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnD7KwWqo9YZe4/z8ZVwndsstLwmFZlYtF+GlxbviBs=;
 b=A7RBZU8m2exv0gOMwwZsz5rulvVeWIr4PMgPbR/+Wk9Qf6IeI6SFY8Q/XO+9cu91Y+vyl5bFVJnksLgJnQ+dvrT57NNSZJKqES+vUkt/6Q6kWQbObWP0AClRPg/CG5RIRKs6Jxzxb9oAhFol6j48rW3JhYiuo1wqdZWCySuva4QvGkxNulM+vXB343hZUOrIeY9H2ZZ+ETT7KCyjMVkmB64NYNPkcQFodJy9Kvfo0olKgn6gvrTWliJHrhczcDnF4wG+8RWSn68mplMArXjjNTVivV4vzv9nEG3WQmExQA1hGqQ5PbVtR15j/DJA+jm8PTyMCv3sAWMYpv8gkqaWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnD7KwWqo9YZe4/z8ZVwndsstLwmFZlYtF+GlxbviBs=;
 b=4/0BWnLTUK+vET3vnZ4yOZSmlm7IVI/xGzSf6/xRgGKys6hXqTpc99OAKbX5HcmFxp86eMwZ3yndhIbFQG2Xffn1XNaQgL+qC0kWB5rn+wDia9HCVFSmuIuzPoVBPsaln+850xWOENPlPhSHiL9ZVFThQ879oVO03+7JFldrmvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 15:17:42 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9%4]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 15:17:42 +0000
Message-ID: <203033d8-3edc-ef85-fb5d-df77315cf118@amd.com>
Date: Fri, 28 Apr 2023 11:17:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
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
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <BN9PR12MB51153ACF2B1F2028E85ADD3E926B9@BN9PR12MB5115.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::34) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c89c99-e3ce-4f71-96d7-08db47fbb661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3vsR75x93rNSG5eUFE71blmh2wpVEmLd6mi3tLTRXkZrlVW3sKjmv9/KHcK4bD8vCftd09Otv9mUysLmb6ZLCZDdpZFeg6xWN1w775WhLUudCUWuzYFZj+qWC2Shrg31LFR57LHHSUc8a7bxiYw4NNuw3MKMfNZzaYskR5hJKWzQXyCKyydWeYwjRrt1mYgREj6lJTp6KNp2i5Ct+re7gn9tyAIFwrWEmPiNPgX8Bw/eEBhWy0SxrXP526YtRGxm/FQC98tRcPzPtAldnjqMs+YX254eutUV8caKoNpdGWXP1ig2XDCXS4/8kOJoy/svr5zRKNbHLNksrWoac2tXxFih0KeMTG58BKoXa7PgaTGLh02CJi/0sniYgwxKPSyq4oJJUli3Nw0HnxrK2nNPyt9193ABGYyC3Oj8Eap2ZGg7gSVSXdShtNeTYdZZ8t/fY5kOQ4cA+SjpR/+JzfXCBW28htidcXHGcFNwDtZEqWS28EZ9wnWwIcKdBkX2mApajDwNkLWCePv5sopIMddc+rmq5Geb/LrH+CBSBd8ocI3OLRJJ3owAEgANLALC/WC+EhyjLkWRmitGYxqBeuSoX+XTTqe4cwCDjmwoBPQS0XgPW1MSUOwtai0xrxpMUkiIwfBQgH7UhGuY5dLbKqFag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(8676002)(66476007)(8936002)(5660300002)(86362001)(38100700002)(66946007)(31696002)(66556008)(41300700001)(316002)(2906002)(6666004)(36756003)(2616005)(6486002)(31686004)(26005)(53546011)(6512007)(186003)(6506007)(66574015)(110136005)(83380400001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVUd1pzdUc4QUtQUW5tL1d2ZE5ZSHkyaytVeVhmaTJhWGZPYm01cDh2cEs4?=
 =?utf-8?B?MW41VWo4T0VjSTdMWFVkS040NGxObC9wNHFUcFplNHgvYWN0UTcrcnF1bzBI?=
 =?utf-8?B?ZVlSV25ZdmpWUUs5ZjhuY3liUGJraUVwUTVXQ2pPa0YzMGtEeW5wbnhVdDYx?=
 =?utf-8?B?RVVtTE1pWVZRZ0l4eGw0N2k1Sy9Rc1VLakxudDJ5Z2o2c0dEUjNHTk5ocVFV?=
 =?utf-8?B?MHAwOGFudXZ1b08rckRMb0xGbjVkZWJBejlhNVVISUVNWDZRQkVFRTdicFRN?=
 =?utf-8?B?M0pBVDdTUTJvNTBTcXFqdlVDczNyQjRDZSs4STFIeFNpek9pMXI4SFQ0bXpO?=
 =?utf-8?B?MTZpanhMWGRXYm5teWpTb2ZTNVZzQitVTVJsQVQxK2kvNVF3Wnk4V2QxUHhC?=
 =?utf-8?B?VjdhekhUcnZQenlSUDNmdVE5SFlOS3NaaTc1R2ZvKzBBdVRia2R2enFQYWdE?=
 =?utf-8?B?L3pueENuVStxOFhVUE9XeFBjVnlPSVFLYW80VzJtdWh0YWl4aTRPQm5Ldy8v?=
 =?utf-8?B?NXVUbElMWWtCYTI2SXJyblowOWZPekRSQ1VOQjZCamhlUEZ2Y0E1MkxpZVBF?=
 =?utf-8?B?TWw2cUJxWlF1ZFM4WDFwZXdSWmZualN1N2xuSFhnNER4NU82U1U3aVpjVDZ3?=
 =?utf-8?B?M3E4UU5Pa0QrcW9MOThqV2RvMU0yeEQ4RXR5YUxTc3ZxK2xUTVBhMDh4U0xU?=
 =?utf-8?B?TXM2c1cyMVBSK3NaNXBZLzRZaUtidVh6ellHamwrdG85MkVMVDNiUnhVc2xp?=
 =?utf-8?B?RmVLc3MybkQzNDZZOGlOcnF0OU9UcmpNSlhHZnFKM3hoazZtalhXRzlFamNq?=
 =?utf-8?B?cGZmZUNrbk5zOWNnRTJCSVczeDlSVHlHalBWVk0yb1Q4OW5ham9qbU9HZk94?=
 =?utf-8?B?dWZRdnpuOUwwaXVDdStaN3FNSkxoMWJ3Y29LZmwrNXBpbjNpWmZZNWRGcHJX?=
 =?utf-8?B?QVVESGpoc0xlV0FlYmRxaURvdVhkU3MwdGR2V2h1U1lIc2JESy9ranNnOEtT?=
 =?utf-8?B?dkRabVBzeHVxZmFibmdoTTY3MVBtbkNYcnd5WXI1L0RJN3VyNnBlVnFSdEky?=
 =?utf-8?B?S2tVZFNOeHV6MFh0TVZsV0sxMEFMV1pjeWoxU2hvR29NVCtaa1FrejllU2tX?=
 =?utf-8?B?Yk5nMHYvOWtKdkE4dldVQ2JVNFdwTmdGS0J6bUV4UjVPOGpWUEdaYkZZSHdj?=
 =?utf-8?B?Z1UvUVhRUFZJMlFDRng4ck1GbFA0QlFYaWdxUmtwcVZXaDlBaHNlZjZqMVZZ?=
 =?utf-8?B?aVNHajNoVkJmV0NJTVN2Wk9yUS9lNkhrcm5vbmZ0Z3Vod3BtaVgrV0RHL2N6?=
 =?utf-8?B?UUsxR0dBdE9tekthaVNPWk9aNHVBdHZ3aXpYUmZyaWR4UnRCMytZSU9NZFRp?=
 =?utf-8?B?Zk5PTEJRYTBMa254eGtyRjdkaUtGM0pEUUZVQm0vcVU5emFmZjIzN2w3ZnNG?=
 =?utf-8?B?RlNFMlBwaEFvVkxvMTJIbkpkSExtVnM5WWtwcHl0YjFYNkhlK2RHb1h1OUZT?=
 =?utf-8?B?MUJJa01uZXZiaEl3RitoRjlWVzhSQzVKSzBRL3psVHVsRTdlRWxlSTdzVklo?=
 =?utf-8?B?RVpmWFU4Z1V5TXNjU3NRdGVuL1gwc0NzYURCLytsNzJjc1FKU1RsdGlmSHZ3?=
 =?utf-8?B?QVo4bURDVy9aM0o0RFhHbjBFR09abFhMS045aEU3dEdJeXczYWYrUW40SHpl?=
 =?utf-8?B?aHlJanhHMTV1WUtkamNEM3hXUG9ReWNDMzNmQjdCZWpHU2ZTaG41THRVSzhM?=
 =?utf-8?B?cXM2N1FtazJ1ZFZCeFV4L0VpcEVrMWRSMnNPZ0NVZ05haWgya25DVDErSlQ4?=
 =?utf-8?B?T1U5c0J6c0xxSW5lclF4dVlQaVhpS3BsWEVtSE1zNi9oS0RURE0vR3BLZG9L?=
 =?utf-8?B?VzRmWHNBcENqT3prTFBHaGJjSUxEQ2U5QkwxMUxhdG5lOUw5dFphZVpXOXhr?=
 =?utf-8?B?bDZCcENQMDZCV0ZQMTdtOGphZHRqcWpTNy80c3Axb1d6M1h4SzRnZGQ5NkRu?=
 =?utf-8?B?djZtL1dLWlg4R3Q5K1AyUTI5czBZZGRWdm16THRxNjZzSHRoZFdYRk1qeTN1?=
 =?utf-8?B?MnpVc1JGUGNSRXRQNzVjVmpBbVVaR3UwQkxNYlhLaW44Z0dXdFFHNWdNYlhP?=
 =?utf-8?Q?4Mw1lEgfoot9Yd5u8wKOd78+J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c89c99-e3ce-4f71-96d7-08db47fbb661
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 15:17:42.6813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB2QgXZnn4cg4dooJOwJ61ftkw1ZQbjKCSTafvzruRlxprdypBawCAiiJUD+OmwajFJBUlcEBQVwbCarf25+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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


On 2023-04-27 23:46, Kuehling, Felix wrote:
> [AMD Official Use Only - General]
>
> Re-mapping typically happens after evictions, before a new eviction fence gets attached. At that time the old eviction fence should be in the signaled state already, so it can't be signaled again. Therefore I would expect my patch to help with unmapping the DMABuf import, without breaking the eviction case.
>
> Are you talking about remapping with a map-to-gpu call from user mode? I think that would only be a problem if the KFD BO was unmapped and remapped multiple times. The first time it's mapped, the fresh dmabuf import should be in the SYSTEM domain, so the validation in the SYSTEM domain before GTT would be a no-op.
Yes. The case scenario I am talking about is from user mode, 
mapping->unmapping->re-mapping to the KFD GTT BO will trigger the eviction.
>
> I sort of agree that we don't really rely on the eviction fence on the DMABuf import. The reservation object is shared with the original BO. Moving the original BO triggers the eviction fence, so we don't need to trigger it again on the dmabuf import. Other than moving the original BO, I don't think we can do anything to the DMABuf import that would require an eviction for KFD use case. It is a special use case because we control both the import and the export in the same context.
I am thinking about no adding KFD eviction fence in first place of 
mapping original GTT BO, because I don't see it can be evicted in any 
cases. In theory GTT BO is mapped by user calling mmap() in system 
memory like userptr, unlike VRAM it will be not evicted by amdgpu vram 
manager. The only thing is CPU invalidation, but GTT BO doesn't register 
mmu notifier, that will be a potential problem when switching 
paged/userptr to non-paged/GTT for mes scheduler.

Regards,
Eric
>
> In the general case dmabuf imports need their eviction fences. For example when we're importing a DMABuf from somewhere else, so the eviction fence is not shared with a BO that we already control. Even then, unmapping a dmabuf from our KFD VM does not need to wait for any fences on the DMABuf.
>
> Regards,
>    Felix
>
> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Thursday, April 27, 2023 14:58
> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating preemptible DMABuf imports
>
> Hi Felix,
>
> I tested your patch on mGPU systems. It doesn't break any KFD eviction tests, because tests don't allocate DMABuf import, that doesn't trigger it's eviction fence. The only thing the patch affects is in re-mapping DMABuf imports that the eviction will still be triggered.
>
> I have an idea that we probably can remove eviction fence for GTT bo, because currently the only way to trigger the eviction fence is by calling ttm_bo_validate for CPU domain in kfd_mem_dmaunmap_dmabuf. Do you know there is other case to trigger GTT bo's eviction?
>
> Regards,
> Eric
>
> On 2023-04-26 22:21, Felix Kuehling wrote:
>> Hi Eric,
>>
>> Can you try if the attached patch fixes the problem without breaking
>> the eviction tests on a multi-GPU PCIe P2P system?
>>
>> Thanks,
>>    Felix
>>
>>
>> On 2023-04-26 13:02, Christian König wrote:
>>> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>>> On 2023-04-26 9:03, Christian König wrote:
>>>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>>>> Hi Christian,
>>>>>>
>>>>>> What do you think about Felix's explanation?
>>>>> That's unfortunately not something we can do here.
>>>>>
>>>>>> Regards,
>>>>>> Eric
>>>>>>
>>>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import bo
>>>>>>>>>> when dmaunmapping DMAbuf. The DMAbuf import bo has been set as
>>>>>>>>>> AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>>>
>>>>>>>>> I'd like to get an Acked-by from Christian as well before
>>>>>>>>> submitting this.
>>>>>>>> I have to admit that I only partially followed the internal
>>>>>>>> discussion, but in general you need a *really* good explanation
>>>>>>>> for this.
>>>>>>>>
>>>>>>>> E.g. add code comment and explain in the commit message
>>>>>>>> extensively why this is needed and why there are no alternatives.
>>>>>>> OK. I'll give it a shot:
>>>>>>>
>>>>>>>     This code path is used among other things when invalidating
>>>>>>> DMABuf
>>>>>>>     imports. These imports share a reservation object with the
>>>>>>> exported
>>>>>>>     BO. Waiting on all the fences in this reservation will trigger
>>>>>>> KFD
>>>>>>>     eviction fences unnecessarily, for example when a DMABuf
>>>>>>> import for
>>>>>>>     a DMA mapping on a secondary GPU is being unmapped explicitly.
>>>>>>> Only
>>>>>>>     moving the original exported BO requires stopping KFD user
>>>>>>> mode
>>>>>>>     queues. If the invalidation is triggered through a move
>>>>>>> notifier
>>>>>>>     from the exported BO, then moving the original BO already
>>>>>>> triggered
>>>>>>>     the eviction fence and we don't need to wait for it again on
>>>>>>> the import.
>>>>>>>
>>>>>>>     We can identify DMABuf imports in KFD for secondary GPU DMA
>>>>>>> mappings
>>>>>>>     by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>>>>     operation that ignores KFD eviction fences.
>>>>>>>
>>>>>>> How does this sound?
>>>>> To be honest like quite a bad idea. Why in the world are imported
>>>>> BOs moved from GTT to SYSTEM in the first place?
>>>> As I understand it, the way to update SG tables in  SG BOs (e.g.
>>>> userptr and dmabuf imports) is to move them back and forth between
>>>> system and GTT domains. If we left the import in the GTT domain all
>>>> the time, we would have no way to update it, e.g. after an eviction.
>>>> Currently the move to the system domain is done in the unmap code path.
>>>>
>>>> Before memory is freed, we also need to unmap it from GPUVM,
>>>> including the DMABuf imports on remote GPUs. For the above reason
>>>> that currently includes moving the import to the system domain. If
>>>> we removed that from the unmap code path, we'd need to do the move
>>>> to system somewhere else, maybe in the mapping/validation path.
>>>>
>>>>
>>>>> The only reason for this I can think of is that the DMA mappings
>>>>> become invalid for some reasons and in this case waiting for the
>>>>> KFD fence is actually the absolutely right thing to do.
>>>> In this case the reason the only reason for unmapping the memory is
>>>> that we're about to free the memory and its DMABuf imports on other
>>>> GPUs. This is coming from the application with a promise "I'm no
>>>> longer accessing the memory". We don't need to wait for fences here.
>>>> We only need to invalidate the PTEs to make sure that any further
>>>> buggy access by the application will fault.
>>> Well in this case just free the BO and it's bo_va structure. The core
>>> handling should take care of clearing all the freed up regions.
>>>
>>> As for updating the SG of a BO you indeed need to move it from GTT to
>>> SYSTEM and back, but in this case we should either indeed wait for
>>> the KFD fence since page tables in between the operation still have
>>> the old entries or we should destroy the BO and create a new one. The
>>> later would overwrite the PTEs with invalid entries first and then
>>> fill in new valid ones.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>> Regards,
>>>>>>>    Felix
>>>>>>>
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>    Felix
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct
>>>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>>>        if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>>>             old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>>>            new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>>>>>>>>> +                        ctx->interruptible);
>>>>>>>>>> +        else
>>>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>            if (r)
>>>>>>>>>>                return r;

