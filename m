Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3258AC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22AA10EDCD;
	Fri, 28 Apr 2023 19:42:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85F710EDCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/FTKz+HvT38ULzYC6PC6KdE/lSMLcAdCTbOL0UqPYiXzDzl6D/oNxp3oN9GS8HkDVOW3DF1x5uZbsoBL7x9aFFRyea7vajYdGmx3PhSp4gq8OACfrBu26HY7ha1/aRwBUKudW861dfdzGpQ9aLaYGB8zdTOubRJdg6BgD0DC5r8157f7ARvnKbJol4EiR1TtEicxNg7aZ8gWtY98Bqm1WUOTc9EMSD0H5tFrgLiaKoCtHKN9SJ/bIJv2Ys7h48yEf3us9OL6CwuDjQmCJe0OgCJKuGZVEaA5vybcjtBTTbCCgbSkeooL51v5g7jaGoZQXUhyPpKv3mLdEtmcdT9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHme7+dTQuEpWOTU3Ns2PRO4X+8tRKQisl1/SmSXLKA=;
 b=Q2yPq8+SEkHD7+cGh958K9JC7CxC3v+Nvxu3bnvyCEYQ+nbKRxB5ExwE7SIkXeHIRQ+3t3+6awaSYvEs2mweZN7kn9VsQ1cxBS+Ueh7oYSDa/oey3/fC6jVyspH8ol/vfpEI3Ks8emr8jCymDC16kRbBCBSZabRKdeXacrEYKHzzJT/RMdoz+lTwxM9uC8L5ZJu8EEk9VqzT9raA2mYDlA3h+VpuKuB1Dqq1xrhFFvfOq7fufFpyka77EvSg53nE9MvhP0kOtbznSOYjBNWN4Y6SV/Udi/m8IiivR10L62zdGJkBlr+5qZaLkH89+utBOoyjN92f9DVh7ccierRGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHme7+dTQuEpWOTU3Ns2PRO4X+8tRKQisl1/SmSXLKA=;
 b=NN3wK2ndJs0hyOYhib7CeKWGmlWjoIofEDOwC5UxoqiudXnBW41jpZyaRuOWkPq78jgcCYuW+ojAd+2/YeXTU+uaTrRoMFkNuA1m4iCheLeiA+GmKFWY1JTr1nTv5TTstG3NBxDCPNvdx4w8gLApnBGCdogB1DF76kYiLoxUnaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 19:42:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 19:42:32 +0000
Message-ID: <85469afd-57c2-d1b3-b897-ac2e1a9fe745@amd.com>
Date: Fri, 28 Apr 2023 14:42:29 -0500
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
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <2d6e286d-3ba2-3510-4e24-0fe555aaa5dc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:610:5a::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 729fe738-b5ff-40f0-dc18-08db4820b52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CVuWespLBigmz1B5TvOv4oMpbZ8Q4OwrqG7QQXztCl3Ljqq2yLd97bTXslSSiR9Nrny+vh7RXKkPN82wLC3kkjs6cxN1ma0zW2QLODeklk1r+EW799UquHFI3bX7kksi5nPEJIhdahSQaxOmlyzA0p3ExEUoi0I7SUpSlpt0m4vo0TsDGbie/Eo0v2r+lm7MwiM3sDAIETawl0N1pbfLGyGruIJCRa02WvySW4TF5Ueew54t7XgykwuUesNEI0SLWLg0FovNV6OKYKQyXuieSTUkkk7REHq0uqW4pnoqzKCa1fGOpR91d0+XjhX6xuVv3rNHMNpR5V776QJBA/lGt7nN3YLD0Wzrhys0GUeNvQgk2ToZ8xyUX2KI3qmtTDBNMI/qr9CkZA+QqnvllB6gYDRGkY2Xfw7zzW20pvjYVAOoS1SlncQBI2lv5uste4UqkWWV5BGQlGwbNkW/1cc/Dc//DQ6TBz68RUtvd18HOJyJYE7gvAmBb8/ghzlOlkP3uqC6hzLTJjmXdJJl/Dmy5zB8m6byBLdYLfZ4ohmUxNInbxbZHiUFU++slvDwzdyV9xXBtgNQmXl/DOA+Rz/cmPtZAAZWX/dRewu+l1HiFYASd4exSm9eTipF+b+Ww36ZURNBCdvIy5a/rTphzOLcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(8936002)(8676002)(83380400001)(41300700001)(6506007)(26005)(6512007)(53546011)(66574015)(110136005)(2906002)(316002)(30864003)(5660300002)(44832011)(31686004)(31696002)(66946007)(66556008)(66476007)(86362001)(2616005)(38100700002)(186003)(478600001)(36756003)(6486002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRnMGkybk1YRnlxYjRZNU9RaTdSR0VnT0J4VEdWT0gxWHA1UkN5UXdQcEJB?=
 =?utf-8?B?NGlseWlBWjhKYU5WNVFoVEhycWV4V2dUeUw2MFdBRDZLbG5sa08wb0ZxUWM5?=
 =?utf-8?B?SWpJcXp0bmZqbGkzMUsrRHUzTTNicWxEUjdhdjVkOGtLUmF4YUEwaEZOL2w4?=
 =?utf-8?B?M3l0Ymw0SXpndFFoVnR4QkR2SFNkODlxeWIzcFo1MCtaZTFxTHJlRHRQaTNt?=
 =?utf-8?B?dUNoVURidVlVdVhpZ2p3S0dyTmFlVmx4cXZmUWxraWUreVNMNEphVUpSZ0pu?=
 =?utf-8?B?KzZzT1hSYnV0Nm9oZWVzeTZVYlJTQXlSTUhMMTJxdnhNdFJQS0Q4aFlKNDRD?=
 =?utf-8?B?WG9SY2pwc1pyQy9OaDQ0WmtEWk12cGlSeTAwZXVzQm9QUDhZaDlGLzRoZTJo?=
 =?utf-8?B?OFBUbXMvNDN5WFVMYko5SUdQaDYwajltSnJta3A3YXJjZGE1MDlOMEowMGhG?=
 =?utf-8?B?cE9ISm4xMjRXQmNreVo1NG9KcFVYQWpTUi8rblJpekkwQXdmQWR1QXlmbHdF?=
 =?utf-8?B?dkVyOFdjUC9TaGhrSm16MEVhWnZpL0pKUSswQmN4Uk9EK0JwWWZhcDRtNDNy?=
 =?utf-8?B?Ny9aMCs1Y3c0ZVp4TjhxUjc3K1NzbnE4TXBSeGdUN2pSaHlZOXRpa1hWNGJl?=
 =?utf-8?B?b01ZMVMvMWhLeTFaanVnUGdVVEdnNmErM2V4RklKYmNTTTlZNmtTaUNlZ29M?=
 =?utf-8?B?bUJNSG5oZW4rbTMwSGJTTUJjTnFpQjVkaENIK0FNMkV4bld6RzR0UlpKOUQx?=
 =?utf-8?B?SjJmY1pKQ3JxUVlGR0VhNGMrN1VRSTdnbFM4aWY0QkVtYVRTa2dOMWVLSnFy?=
 =?utf-8?B?dk1yZklERVRXNkVaV3pTZTBwSy94RXNGQjFjM2NORTVITmdaUGxheWMvbVdG?=
 =?utf-8?B?bWo2NFIxWWk1ZWZZQzR4SW90QklaQWxQRlN6N0p3cjNobjh5ajkveXFsbmpo?=
 =?utf-8?B?RnE0c0oxNjJJNStkVGQzZW05dXZUcVUwbGVrT1BaeGhtVFYxeTdPajJxTUpW?=
 =?utf-8?B?TXhURlA2WEhVelpubER4dmFkYXhhem5HclN1Uy9pN2xWcVZFSlQzeWtyaWpT?=
 =?utf-8?B?UE1ENjNja1ZhTHNTRXFPMHk1Z0c4Q1NINEFBYTdGNDFFYXpuMzBvNHhGU2I1?=
 =?utf-8?B?QVFuRS8rYjg0dGhZUWhDMXRUU0FSM1NmS0ZQdThRMHl5dkE3SVlURmNJV3Jt?=
 =?utf-8?B?TzV2dmdTaGxQZzBsRGVBTTAxS1NsQ3E4NmF5M2FrS3ZqaCtOZVRVN3cxRkhx?=
 =?utf-8?B?VmlEUzBMVEJOb3c4UC9ka0VnQm02bnpFUXIxZ1dXaWs0VjlDTXN3TFJCR0ps?=
 =?utf-8?B?WG1ibjBzZ3JraHZpN1FHeXArQzNvZE9MaTArUU5FdXBadWpsdzhQT2V0cS8w?=
 =?utf-8?B?bU9mamoyOXdDWkxMaVltdE1EUndGNHh5ZEZnYnlBcnFTL0laSGJ5UmpmdXh6?=
 =?utf-8?B?RlI3T0htaDNqU05teTlBRWNzL2c1VGc4WjVpOEFHdjBvL0ZHTjZmV2NOYmo0?=
 =?utf-8?B?YlVFQmJxZHJtZEE2OHE0V0V1NGtOdU80azAvMmQ2Y2NBWW1HcmtFNzJ0eWRm?=
 =?utf-8?B?dG1tQmkyUWZaQ1VVNVhXMHJzdkc5NnAxamw2alpzUWFNSXpQbk5oVEN4UVVw?=
 =?utf-8?B?NWNTdGszOXB6K1JXeG9uV1IrY3hkeWJ0YXFuNnZNK0dtNUljdFhpRXNRNWNQ?=
 =?utf-8?B?RUU1VXdyL0xHbUFaclNlYjkzb0RIVnVoaDJvU0h3cm9tcUpBSFlVbmJuWmRW?=
 =?utf-8?B?MUJCNjdraVdITHZjZWlWZjduWk9PWldrdlpHZ1lBQjdQZVhWOGRiSUIxZ3lK?=
 =?utf-8?B?QUkwalBNa1lNRktnZ2pWcGs5dHFkM2l2enZkTFNGZHVlc1JqZFlLZHVuNkRN?=
 =?utf-8?B?aWlyWDExdjlGMHhmTmZqS01hQnA2Z0VJV2RHb2s0eVduT1RxOWduVzA4dDhQ?=
 =?utf-8?B?Z1h4VVhtaTBXRnRjbUpXdnllMDJaTmM1WW42ZnRuMnBka3g1S0FTSStOU2tl?=
 =?utf-8?B?VWhqd1hadG9TT2FqY1NXalBLVVFkUERXZm1iNSt3Q0h0ZHBIVWxHUGR3SHNQ?=
 =?utf-8?B?Z3dvZE5DcEhFM0NMUU15S1NNVkNZNTJvU2pTdXQrL1RTKytYNU5XbENvbUFO?=
 =?utf-8?Q?JjCCkKbQQfiM/n4J/3dMqcyEi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729fe738-b5ff-40f0-dc18-08db4820b52f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:42:32.1076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVLT+2PErKNuiyjPtAsGuwvmEMythgA/BmfvOaQrFuhsZhvzwtkQgJv9eqAOTPNVN8m9yAtNbiP7Y1WXr+E4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
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

On 2023-04-28 14:09, Eric Huang wrote:
>
> On 2023-04-28 12:41, Felix Kuehling wrote:
>> On 2023-04-28 10:17, Eric Huang wrote:
>>>
>>> On 2023-04-27 23:46, Kuehling, Felix wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>> Re-mapping typically happens after evictions, before a new eviction 
>>>> fence gets attached. At that time the old eviction fence should be 
>>>> in the signaled state already, so it can't be signaled again. 
>>>> Therefore I would expect my patch to help with unmapping the DMABuf 
>>>> import, without breaking the eviction case.
>>>>
>>>> Are you talking about remapping with a map-to-gpu call from user 
>>>> mode? I think that would only be a problem if the KFD BO was 
>>>> unmapped and remapped multiple times. The first time it's mapped, 
>>>> the fresh dmabuf import should be in the SYSTEM domain, so the 
>>>> validation in the SYSTEM domain before GTT would be a no-op.
>>> Yes. The case scenario I am talking about is from user mode, 
>>> mapping->unmapping->re-mapping to the KFD GTT BO will trigger the 
>>> eviction.
>>>>
>>>> I sort of agree that we don't really rely on the eviction fence on 
>>>> the DMABuf import. The reservation object is shared with the 
>>>> original BO. Moving the original BO triggers the eviction fence, so 
>>>> we don't need to trigger it again on the dmabuf import. Other than 
>>>> moving the original BO, I don't think we can do anything to the 
>>>> DMABuf import that would require an eviction for KFD use case. It 
>>>> is a special use case because we control both the import and the 
>>>> export in the same context.
>>> I am thinking about no adding KFD eviction fence in first place of 
>>> mapping original GTT BO, because I don't see it can be evicted in 
>>> any cases.
>>
>> That's not an option. We're not adding an eviction fence. The 
>> reservation object with the eviction fence is shared between the 
>> exported BO and the imported one. That's just how DMABuf works. If 
>> you wait for the fences on the imported BO, you are effectively 
>> waiting for the fences on the exported BOs. And you can't remove the 
>> eviction fence from the exported BO.
>
> What if the exported BO will be never evicted in reality? I understand 
> how DMABuf works, and imported BO doesn't have eviction fence, it 
> shares with exported BO's one if eviction happens, but I don't see the 
> exported BO can be evicted.

The exported BO can be evicted like any other BO. For example 
KFDEvictTest is there to cause and test evictions of KFD VRAM BOs. 
Exporting the BO does not pin it (if DMABUF_MOVE_NOTIFIER is enabled, 
which it in the upstream kernel), so the exported BO can still be evicted.

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
>>> In theory GTT BO is mapped by user calling mmap() in system memory 
>>> like userptr, unlike VRAM it will be not evicted by amdgpu vram 
>>> manager. The only thing is CPU invalidation, but GTT BO doesn't 
>>> register mmu notifier, that will be a potential problem when 
>>> switching paged/userptr to non-paged/GTT for mes scheduler.
>>>
>>> Regards,
>>> Eric
>>>>
>>>> In the general case dmabuf imports need their eviction fences. For 
>>>> example when we're importing a DMABuf from somewhere else, so the 
>>>> eviction fence is not shared with a BO that we already control. 
>>>> Even then, unmapping a dmabuf from our KFD VM does not need to wait 
>>>> for any fences on the DMABuf.
>>>>
>>>> Regards,
>>>>    Felix
>>>>
>>>> -----Original Message-----
>>>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>>>> Sent: Thursday, April 27, 2023 14:58
>>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian 
>>>> <Christian.Koenig@amd.com>; Christian König 
>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences 
>>>> invalidating preemptible DMABuf imports
>>>>
>>>> Hi Felix,
>>>>
>>>> I tested your patch on mGPU systems. It doesn't break any KFD 
>>>> eviction tests, because tests don't allocate DMABuf import, that 
>>>> doesn't trigger it's eviction fence. The only thing the patch 
>>>> affects is in re-mapping DMABuf imports that the eviction will 
>>>> still be triggered.
>>>>
>>>> I have an idea that we probably can remove eviction fence for GTT 
>>>> bo, because currently the only way to trigger the eviction fence is 
>>>> by calling ttm_bo_validate for CPU domain in 
>>>> kfd_mem_dmaunmap_dmabuf. Do you know there is other case to trigger 
>>>> GTT bo's eviction?
>>>>
>>>> Regards,
>>>> Eric
>>>>
>>>> On 2023-04-26 22:21, Felix Kuehling wrote:
>>>>> Hi Eric,
>>>>>
>>>>> Can you try if the attached patch fixes the problem without breaking
>>>>> the eviction tests on a multi-GPU PCIe P2P system?
>>>>>
>>>>> Thanks,
>>>>>    Felix
>>>>>
>>>>>
>>>>> On 2023-04-26 13:02, Christian König wrote:
>>>>>> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>>>>>> On 2023-04-26 9:03, Christian König wrote:
>>>>>>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>>>>>>> Hi Christian,
>>>>>>>>>
>>>>>>>>> What do you think about Felix's explanation?
>>>>>>>> That's unfortunately not something we can do here.
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Eric
>>>>>>>>>
>>>>>>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>>>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import bo
>>>>>>>>>>>>> when dmaunmapping DMAbuf. The DMAbuf import bo has been 
>>>>>>>>>>>>> set as
>>>>>>>>>>>>> AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>>>>>>
>>>>>>>>>>>> I'd like to get an Acked-by from Christian as well before
>>>>>>>>>>>> submitting this.
>>>>>>>>>>> I have to admit that I only partially followed the internal
>>>>>>>>>>> discussion, but in general you need a *really* good explanation
>>>>>>>>>>> for this.
>>>>>>>>>>>
>>>>>>>>>>> E.g. add code comment and explain in the commit message
>>>>>>>>>>> extensively why this is needed and why there are no 
>>>>>>>>>>> alternatives.
>>>>>>>>>> OK. I'll give it a shot:
>>>>>>>>>>
>>>>>>>>>>     This code path is used among other things when invalidating
>>>>>>>>>> DMABuf
>>>>>>>>>>     imports. These imports share a reservation object with the
>>>>>>>>>> exported
>>>>>>>>>>     BO. Waiting on all the fences in this reservation will 
>>>>>>>>>> trigger
>>>>>>>>>> KFD
>>>>>>>>>>     eviction fences unnecessarily, for example when a DMABuf
>>>>>>>>>> import for
>>>>>>>>>>     a DMA mapping on a secondary GPU is being unmapped 
>>>>>>>>>> explicitly.
>>>>>>>>>> Only
>>>>>>>>>>     moving the original exported BO requires stopping KFD user
>>>>>>>>>> mode
>>>>>>>>>>     queues. If the invalidation is triggered through a move
>>>>>>>>>> notifier
>>>>>>>>>>     from the exported BO, then moving the original BO already
>>>>>>>>>> triggered
>>>>>>>>>>     the eviction fence and we don't need to wait for it again on
>>>>>>>>>> the import.
>>>>>>>>>>
>>>>>>>>>>     We can identify DMABuf imports in KFD for secondary GPU DMA
>>>>>>>>>> mappings
>>>>>>>>>>     by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>>>>>>>     operation that ignores KFD eviction fences.
>>>>>>>>>>
>>>>>>>>>> How does this sound?
>>>>>>>> To be honest like quite a bad idea. Why in the world are imported
>>>>>>>> BOs moved from GTT to SYSTEM in the first place?
>>>>>>> As I understand it, the way to update SG tables in  SG BOs (e.g.
>>>>>>> userptr and dmabuf imports) is to move them back and forth between
>>>>>>> system and GTT domains. If we left the import in the GTT domain all
>>>>>>> the time, we would have no way to update it, e.g. after an 
>>>>>>> eviction.
>>>>>>> Currently the move to the system domain is done in the unmap 
>>>>>>> code path.
>>>>>>>
>>>>>>> Before memory is freed, we also need to unmap it from GPUVM,
>>>>>>> including the DMABuf imports on remote GPUs. For the above reason
>>>>>>> that currently includes moving the import to the system domain. If
>>>>>>> we removed that from the unmap code path, we'd need to do the move
>>>>>>> to system somewhere else, maybe in the mapping/validation path.
>>>>>>>
>>>>>>>
>>>>>>>> The only reason for this I can think of is that the DMA mappings
>>>>>>>> become invalid for some reasons and in this case waiting for the
>>>>>>>> KFD fence is actually the absolutely right thing to do.
>>>>>>> In this case the reason the only reason for unmapping the memory is
>>>>>>> that we're about to free the memory and its DMABuf imports on other
>>>>>>> GPUs. This is coming from the application with a promise "I'm no
>>>>>>> longer accessing the memory". We don't need to wait for fences 
>>>>>>> here.
>>>>>>> We only need to invalidate the PTEs to make sure that any further
>>>>>>> buggy access by the application will fault.
>>>>>> Well in this case just free the BO and it's bo_va structure. The 
>>>>>> core
>>>>>> handling should take care of clearing all the freed up regions.
>>>>>>
>>>>>> As for updating the SG of a BO you indeed need to move it from 
>>>>>> GTT to
>>>>>> SYSTEM and back, but in this case we should either indeed wait for
>>>>>> the KFD fence since page tables in between the operation still have
>>>>>> the old entries or we should destroy the BO and create a new one. 
>>>>>> The
>>>>>> later would overwrite the PTEs with invalid entries first and then
>>>>>> fill in new valid ones.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Regards,
>>>>>>>    Felix
>>>>>>>
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>>    Felix
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>    Felix
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct
>>>>>>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>>>>>>        if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>>>>>>             old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>>>>>>            new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>>>>>>> + AMDGPU_FENCE_OWNER_KFD,
>>>>>>>>>>>>> + ctx->interruptible);
>>>>>>>>>>>>> +        else
>>>>>>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>>>            if (r)
>>>>>>>>>>>>>                return r;
>>>
>
