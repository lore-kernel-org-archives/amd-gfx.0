Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39207C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 12:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B895E10E29A;
	Fri, 18 Mar 2022 12:31:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E29010E29A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 12:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPBKFgFKd3unZ4qYTY4qmZzMNpHPkb7l1pjw3f3LEYS2v5GYW8HT/+9E7KSNoReIsujjDS/6+CT0WoLgjrp/pOKOCPAIQ9l2VKsT1H18I5q8gTYEE5nLrxHOZ3zSelBBaaBJ4RFATKGx1MOGtrcY2g4jmHrlIKaSLFBiFw/ZZGBEkBJpe3VaJJ96O/Jh8/CmBuEyi68BlV6ttuhpvYMaIyFO0nTP8le1rBCAl9Zr8qmLm98fJr8A4rNe7uYLh4qX7AV90bnb3aRWehBu1pm0nnfTpAt/3zMeX7xVFJKh1NmS9Ep+jgdDgOZfYf+QfnahDLMFuesghQ2SYQ5wZDdjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsDimbhjxMwzt90RL9BRbwkDALami/ekkY8YwLW2rsg=;
 b=Rf9IvrtB/zign9+3tIHkfSoh9uboTI20bJr48AO2N4LydEB4+fMsk7yIND/ZzHPlC9IkUsyyq67V5EwMKzx2XGuqBq+ORU69mul0TasXUGf0z/uYhQqB6LVA/n6W2VVv8fjFitVVvXJcUyi3kFv00lBSZEL+HaaZOMKAuyACnX0mHMN5FOqSW8DKUmIAor8cXIQzuOKHEojq5KCEVuP+w0vyEfD30y/SGAX6oRITbMSRhvynwoFhVC5PB9zQJrQNq1yKz6IoW0lkt68oKlHnImDffEdGHpm9QG0HYaIqY7pIvJVNt+XvjZGMWWT+AT3jss6Hd06lBR96lsZIqCXULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsDimbhjxMwzt90RL9BRbwkDALami/ekkY8YwLW2rsg=;
 b=Qay+R41C28lxobCFxP133EabDd5BH0gyNh7Lx2IXUrFaeDilT3nEirgWVjMkMTOeo6WSsgEuZVnyHtaE5rVcqGHQAS/PAPs2rnBxuQYf97v4wUsvI6a1FNmjvLgu0pxyZTDWJf3hHE45iKxAt6vNl5N0Q3bqSUgtJEKrq4oEF+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4837.namprd12.prod.outlook.com (2603:10b6:610:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 12:31:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 12:31:49 +0000
Message-ID: <487eec9e-49e7-8d98-4d60-321de83448ac@amd.com>
Date: Fri, 18 Mar 2022 13:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: radeon ring 0 test failed on arm64
Content-Language: en-US
To: Peter Geis <pgwipeout@gmail.com>
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
 <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
 <ece56cf6-5ef2-6bd4-8e62-7828adca9844@rock-chips.com>
 <CAMdYzYoTz7rbs7pMDTcDzVPVaaP97BkUeMOM0Ab5FVSqOQRgxg@mail.gmail.com>
 <7652b236-238c-4e8a-f1c5-e3b7f7f71be6@rock-chips.com>
 <cd95435c-7ad5-6126-26f6-76a62f6f85fb@amd.com>
 <CAMdYzYo0Qk9U+m8-NfYnJT8vvN=Q1wm6eNGnd-RKoMn-qQ+gXQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAMdYzYo0Qk9U+m8-NfYnJT8vvN=Q1wm6eNGnd-RKoMn-qQ+gXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR05CA0043.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1bc818d-58d4-4eef-7f47-08da08db45b8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4837:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4837B9669F61B398B8D3CE2083139@CH2PR12MB4837.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiRd7gsfnXTFCNJbkkNWhD9Gv1JOZadJlepPx+hBALPWNO+KLgyGdzXpj+nH0i3NXSM3lnIHyJJcevgGAaTurr/c7xaccMDSfAXUfbKVy3s4OU4H1VS5+U2zd6qzh/uX/sW5btjUmMLKYE+uLklCsQwlRLBJrzAiHfxt7Ry6iIe7I70Ago/huQ8mtJpOr0NvpAjteoBPM8+xDLn7lFBZaQjy/H6tIguqfO3eTLWE1H47rJXKwnXtDkxNUVNjUh5R5vln8GioSD+Gk+BO9m8gceeZrItwUESJOpaRfT1pck6a1xwsDRdHsd0vdFaow+09Q1AmoCRMpxKkON2U+/zhlJJ9lDUfovsEwtu8G0b4SAExaSy5qcucX1YGmn9Nme2kCjRSsR/+n+PhPWcIUECNH3g5z89urOmh3JbEn8J/+HGYj6yV9X9Yt1uTru507cOkazy0mjI1LaExL1COP23HN+uTPTkscSL24xB3Ceu1Qo7X6kN8wDPyYr+F8pyXpNJGnrYJNNzdEuWpLLaEYMUvM4awF/AOrzXxLaqvxKeErXyxBrDzZOr/j3QI1vttrGJ/HkSuZrk24nc9EPlRQVRDoRj/pJnHDwJR1uDIgJUgV7H5pUrf5XOHjw57ap4UaK990Ddkoa9ajn/2DLn5aJJhnazfiUAwQh+SQ/rcW/Os2lleXstju15ooHwc8oyvUSgjS9XZcnQhadxKoVUTtyMlAX9Ghm4g7y9q7pU6Temz75CgTz2BoqPypx9eBCF0BcAYg8V5HxDmYSfvX1H5Q5hI1E3ftCfFqgv8aJEZRBHGN2hZYSiEaLPV6uI61tGzA5ptuaS4vikmnVVDQ0C3t6+ecHe0RPsHGZnS6ZX2nUXtSyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(83380400001)(186003)(38100700002)(8936002)(5660300002)(30864003)(86362001)(4326008)(66946007)(2906002)(6666004)(45080400002)(508600001)(66556008)(53546011)(2616005)(6506007)(6512007)(316002)(31686004)(966005)(6486002)(54906003)(6916009)(36756003)(31696002)(66476007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtqUDZoSkFtU1h0cDBjZ1hpY0lqV3pCcEJ1QkxWYXd2MUMxT0RXOHVzR1NX?=
 =?utf-8?B?bkRoYitiZWduSi9HZ1F5NmJXZGNGVnNFTkFSWHpWeHVMdmJLS3JpOTJpUTRT?=
 =?utf-8?B?SG5Bc3dlbjJiZUlhUXFHa1lzeXJpeXFORHZObHlIak1jL3Y0SGt4bTZFQ3lH?=
 =?utf-8?B?VURLVURTRE5DZGhxSCszRDRDeGF6OW1ac0s5alVyUUl3NDIrQXlMZHladXp1?=
 =?utf-8?B?alI4NUZRNUdQVWcyaXlnNkN6NEdJOWczUDRVMUVxMDY2aU1lNThmcWMvcGpB?=
 =?utf-8?B?RE5mQ0ZTTjJVcTd4ZFFQNVVmRWRBNEp4YkJ1UmxkYW5lNHdmdThiY0NHbDV4?=
 =?utf-8?B?eFRXZlZUcXNOUGE5ZkdTR3VvcUF6U3dmWDdyQ2VOQWRBY3Z4RVhPczdreDVE?=
 =?utf-8?B?a2JFam5BZFRMVEhwVFV2YmdkeWFCZElyUFc3SnNNTnBwbExUaVJyTkNvK21h?=
 =?utf-8?B?TGsrajJYdmZqY3l3RlFKb1dBT1QrUmJVdWxkRUk0V3ZROTJZWVhPVnh3cEhN?=
 =?utf-8?B?aFRvc0MxdlBBeTYrWUVyUXpCZlZkaUIyK3F1ZlZodlFNNSticDBycGtYRnNp?=
 =?utf-8?B?d3pzNy9mRDMrSlZsRktYeWFMbjRSYXBLd0ViVzkycm56bVhqVEdkM2YrSjcv?=
 =?utf-8?B?T2tCaWk3ZXB6bjBML2xCLzFZWmVQQ1JTQzUzWDFtcTc5ODVnMjNKZzBadTk2?=
 =?utf-8?B?dnpNOWd3UVExTDdGSVFOSFhBZGhuZngzV3NoTUQrdWw2SEJTQjJHTkZDb0Z0?=
 =?utf-8?B?SWVnQmxnL085a0dJMFBhc1UreS9CUWd2amo2ZC8vejhjcGc4blNidmxieXRQ?=
 =?utf-8?B?Vlc2d2U4a25EZUVCRU1xVHBvU0QwcWtSa0VFZTlCVTJBMWNzQm0zYVRqR3Vs?=
 =?utf-8?B?ZVlyNFVWUDdIcExDMUVtVzFrUzFqUGFWc1RYMDA3SzBtc2dud1MrSlhjSW9x?=
 =?utf-8?B?amxENUZvVmNPM1BMZUZWUVpHb1Z6SVRlNmJ6aDFaaXQ5WmUvQTlLODRWMjNu?=
 =?utf-8?B?RGdFWTZGdzNTY0VCK2dRYVZSbDA4RHh2SHN1UkExZ3pNUHVyb2VkTE9SalRp?=
 =?utf-8?B?eHRhcXJtTkh3aS9DZWlHT1hKajNKajIvYnE4RnErdGNaZmJxOC8zZS8waFE2?=
 =?utf-8?B?RXVJWExRSG8vcG43MGg3WjJzbWc2VUJMNkdiNUx6b3drNkl5QnV5MnB5eFdL?=
 =?utf-8?B?ODRTNUU3OVpVSTVqYmZtQVhjZktsbndLUFBIR0RNVC9sYVlMc29IUEMxeE1V?=
 =?utf-8?B?c2tUd0crRlBqeXF2N292UnJ6M2dKeFo2YjNxZmFQVGRQN3RzK2FBcVVqMThG?=
 =?utf-8?B?bkhqQTRubkViZnhCS3VheGcrazVUU1M0b29abi9ULytsQ1BwcGROZWl0UTRY?=
 =?utf-8?B?WUROcEhvWUVSTnlSOGdvQlNNaGh2WXh2VnpXSm1yL3ZjNWxTbGcyUGJuZEMw?=
 =?utf-8?B?ZTlCMVFtY1hFV0s3OFZCdVV5STlWaXBzNmJROTB6eEo5NDE1ZUdoWHFjVDZH?=
 =?utf-8?B?QnJmeGtFeUNKVEhWQ0JPZmRaRXI4SytFQ2pnUlVQdllwK2JRR01GTlhYQ004?=
 =?utf-8?B?MU1PU2UzcUNpbFpneWI3clBwYXRSNGNDcEQ5aEtENmNPK0t0L3hUL0hFc1Vk?=
 =?utf-8?B?NGc0WGkxRXFTNGpVWTNaTWttWk9vYWl5YzJhOG9FcXB1ZDhiU2IwYi9yMjVK?=
 =?utf-8?B?U25QYmdSMnZ4dHlwUFdVbnJCOERORDhyUVNVSW4vMlFNM1BRZlpoQlltY2pE?=
 =?utf-8?B?MXVtNk5HTDBkQllzcUxsbkpsQ1RnVkc4aWFVMmJ3Vm8vU2xzbVhUdG9ZWFV4?=
 =?utf-8?B?SHp4MUtRdVRoMEZiUDdEdDJsTlo0UEhRcFlpVGduanUvV0M1dmUyTk9XN1kz?=
 =?utf-8?B?OUdVQlR2ZXRWREZlTDJ0R3NXOTY5blVpdzhSbmh5S0RlWk9TUVRMYnoxQzdu?=
 =?utf-8?B?Z0hKREpaZW5QV3dOTmJ0TkorWWd4cGtHQitLVmdYOWw0TW10dXM4R2NwbWx2?=
 =?utf-8?B?SmZGMVIyS2ZURzZDdDlINk55YlVBRDdnYzU4OVE1YXdveWtnVXU3Z093NDRW?=
 =?utf-8?Q?wP+7U0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc818d-58d4-4eef-7f47-08da08db45b8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 12:31:49.1144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqP4FkvPMXiuEUjFlf1Wb2gCLk4ODL7D+FRuhdo2OuwqsjzPhAylQYuX/qNgC0qP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4837
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
Cc: Tao Huang <huangtao@rock-chips.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.03.22 um 12:24 schrieb Peter Geis:
> On Fri, Mar 18, 2022 at 4:35 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>>
>> Am 18.03.22 um 08:51 schrieb Kever Yang:
>>
>>
>> On 2022/3/17 20:19, Peter Geis wrote:
>>
>> On Wed, Mar 16, 2022 at 11:08 PM Kever Yang <kever.yang@rock-chips.com> wrote:
>>
>> Hi Peter,
>>
>> On 2022/3/17 08:14, Peter Geis wrote:
>>
>> Good Evening,
>>
>> I apologize for raising this email chain from the dead, but there have
>> been some developments that have introduced even more questions.
>> I've looped the Rockchip mailing list into this too, as this affects
>> rk356x, and likely the upcoming rk3588 if [1] is to be believed.
>>
>> TLDR for those not familiar: It seems the rk356x series (and possibly
>> the rk3588) were built without any outer coherent cache.
>> This means (unless Rockchip wants to clarify here) devices such as the
>> ITS and PCIe cannot utilize cache snooping.
>> This is based on the results of the email chain [2].
>>
>> The new circumstances are as follows:
>> The RPi CM4 Adventure Team as I've taken to calling them has been
>> attempting to get a dGPU working with the very broken Broadcom
>> controller in the RPi CM4.
>> Recently they acquired a SoQuartz rk3566 module which is pin
>> compatible with the CM4, and have taken to trying it out as well.
>>
>> This is how I got involved.
>> It seems they found a trivial way to force the Radeon R600 driver to
>> use Non-Cached memory for everything.
>> This single line change, combined with using memset_io instead of
>> memset, allows the ring tests to pass and the card probes successfully
>> (minus the DMA limitations of the rk356x due to the 32 bit
>> interconnect).
>> I discovered using this method that we start having unaligned io
>> memory access faults (bus errors) when running glmark2-drm (running
>> glmark2 directly was impossible, as both X and Wayland crashed too
>> early).
>> I traced this to using what I thought at the time was an unsafe memcpy
>> in the mesa stack.
>> Rewriting this function to force aligned writes solved the problem and
>> allows glmark2-drm to run to completion.
>> With some extensive debugging, I found about half a dozen memcpy
>> functions in mesa that if forced to be aligned would allow Wayland to
>> start, but with hilarious display corruption (see [3]. [4]).
>> The CM4 team is convinced this is an issue with memcpy in glibc, but
>> I'm not convinced it's that simple.
>>
>> On my two hour drive in to work this morning, I got to thinking.
>> If this was an memcpy fault, this would be universally broken on arm64
>> which is obviously not the case.
>> So I started thinking, what is different here than with systems known to work:
>> 1. No IOMMU for the PCIe controller.
>> 2. The Outer Cache Issue.
>>
>> Robin:
>> My questions for you, since you're the smartest person I know about
>> arm64 memory management:
>> Could cache snooping permit unaligned accesses to IO to be safe?
>> Or
>> Is it the lack of an IOMMU that's causing the ali gnment faults to become fatal?
>> Or
>> Am I insane here?
>>
>> Rockchip:
>> Please update on the status for the Outer Cache errata for ITS services.
>>
>> Our SoC design team has double check with ARM GIC/ITS IP team for many
>> times, and the GITS_CBASER
>> of GIC600 IP does not support hardware bind or config to a fix value, so
>> they insist this is an IP
>> limitation instead of a SoC bug, software should take  care of it :(
>> I will check again if we can provide errata for this issue.
>>
>> Thanks. This is necessary as the mbi-alias provides an imperfect
>> implementation of the ITS and causes certain PCIe cards (eg x520 Intel
>> 10G NIC) to misbehave.
>>
>> Please provide an answer to the errata of the PCIe controller, in
>> regard to cache snooping and buffering, for both the rk356x and the
>> upcoming rk3588.
>>
>>
>> Sorry, what is this?
>>
>> Part of the ITS bug is it expects to be cache coherent with the CPU
>> cluster by design.
>> Due to the rk356x being implemented without an outer accessible cache,
>> the ITS and other devices that require cache coherency (PCIe for
>> example) crash in fun ways.
>>
>> Then this is still the ITS issue, not PCIe issue.
>> PCIe is a peripheral bus controller like USB and other device, the driver should maintain the "cache coherency" if there is any, and there is no requirement for hardware cache coherency between PCIe and CPU.
> Kever,
>
> These issues are one and the same.

Well, that's not correct. You are still mixing two things up here:

1. The memory accesses from the device to the system memory must be 
coherent with the CPU cache. E.g. we root complex must snoop the CPU cache.
     That's a requirement of the PCIe spec. If you don't get that right 
a whole bunch of PCIe devices won't work correctly.

2. The memory accesses from the CPU to the devices PCIe BAR can be 
unaligned. E.g. a 64bit read can be aligned on a 32bit address.
     That is a requirement of the graphics stack. Other devices still 
might work fine without that.

Regards,
Christian.

> Certain hardware blocks *require* cache coherency as part of their design.
> All of the *interesting* things PCIe can do stem from it.
>
> When I saw you bumped the available window to the PCIe controller to
> 1GB I was really excited, because that meant we could finally support
> devices that used these interesting features.
> However, without cache coherency, having more than a 256MB window is a
> waste, as any card that can take advantage of it *requires* coherency.
> The same thing goes for a resizable BAR.
> EP mode is the same, having the ability to connect one CPU to another
> CPU over a PCIe bus loses the advantages when you don't have
> coherency.
> At that point, you might as well toss in a 2.5GB ethernet port and
> just use that instead.
>
>>
>> Well then I suggest to re-read the PCIe specification.
>>
>> Cache coherency is defined as mandatory there. Non-cache coherency is an optional feature.
>>
>> See section 2.2.6.5 in the PCIe 2.0 specification for a good example.
>>
>> Regards,
>> Christian.
>>
>>
>> We didn't see any transfer error on rk356x PCIe till now, we can take a look if it's easy to reproduce.
> It's easy to reproduce, just try to use any card that has a
> significantly large enough BAR to warrant requiring coherency.
> dGPUs are the most readily accessible device, but High Performance
> Computing Acceleration devices and high power FPGAs also would work.
> Was the resizable bar tested at all internally either?
> Any current device that could use that requires coherency.
> And like above, EP mode without coherency is a waste at best, and
> unpleasant at worst.
>
> Very Respectfully,
> Peter
>
>> Thanks,
>> - Kever
>>
>>
>> This means that rk356x cannot implement a specification compliant ITS or PCIe.
>> >From the rk3588 source dump it appears it was produced without an
>> outer accessible cache, which means if true it also will be unable to
>> use any PCIe cards that implement cache coherency as part of their
>> design.
>>
>>
>> Thanks,
>> - Kever
>>
>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FJeffyCN%2Fmirrors%2Fcommit%2F0b985f29304dcb9d644174edacb67298e8049d4f&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C618d68406abf46aceb1708da08d1f61e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831995714063605%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=et3jUQ1Y2QaR56qTjl4LJ1vGurPwK8HfLosebUIV9bc%3D&amp;reserved=0
>> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F871rbdt4tu.wl-maz%40kernel.org%2FT%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C618d68406abf46aceb1708da08d1f61e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831995714063605%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UrGSye7MpCUO9tppCCmgSGlNa6X0otJ8tkcOb2PXjA8%3D&amp;reserved=0
>> [3] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953414755970850816%2Funknown.png&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C618d68406abf46aceb1708da08d1f61e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831995714063605%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=agZjpl0LvSf4Jo3SoETVkW72uN0WiHb%2FYUA7V7c0G88%3D&amp;reserved=0
>> [4] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953424952042852422%2Funknown.png&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C618d68406abf46aceb1708da08d1f61e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831995714063605%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=tuBS9UfMegc1bc7U98zpsfQ1vUKsVmpscmNKpkn%2BHmk%3D&amp;reserved=0
>>
>> Thank you everyone for your time.
>>
>> Very Respectfully,
>> Peter Geis
>>
>> On Wed, May 26, 2021 at 7:21 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>
>> Hi Robin,
>>
>> Am 26.05.21 um 12:59 schrieb Robin Murphy:
>>
>> On 2021-05-26 10:42, Christian König wrote:
>>
>> Hi Robin,
>>
>> Am 25.05.21 um 22:09 schrieb Robin Murphy:
>>
>> On 2021-05-25 14:05, Alex Deucher wrote:
>>
>> On Tue, May 25, 2021 at 8:56 AM Peter Geis <pgwipeout@gmail.com>
>> wrote:
>>
>> On Tue, May 25, 2021 at 8:47 AM Alex Deucher
>> <alexdeucher@gmail.com> wrote:
>>
>> On Tue, May 25, 2021 at 8:42 AM Peter Geis <pgwipeout@gmail.com>
>> wrote:
>>
>> Good Evening,
>>
>> I am stress testing the pcie controller on the rk3566-quartz64
>> prototype SBC.
>> This device has 1GB available at <0x3 0x00000000> for the PCIe
>> controller, which makes a dGPU theoretically possible.
>> While attempting to light off a HD7570 card I manage to get a
>> modeset
>> console, but ring0 test fails and disables acceleration.
>>
>> Note, we do not have UEFI, so all PCIe setup is from the Linux
>> kernel.
>> Any insight you can provide would be much appreciated.
>>
>> Does your platform support PCIe cache coherency with the CPU?  I.e.,
>> does the CPU allow cache snoops from PCIe devices?  That is required
>> for the driver to operate.
>>
>> Ah, most likely not.
>> This issue has come up already as the GIC isn't permitted to snoop on
>> the CPUs, so I doubt the PCIe controller can either.
>>
>> Is there no way to work around this or is it dead in the water?
>>
>> It's required by the pcie spec.  You could potentially work around it
>> if you can allocate uncached memory for DMA, but I don't think that is
>> possible currently.  Ideally we'd figure out some way to detect if a
>> particular platform supports cache snooping or not as well.
>>
>> There's device_get_dma_attr(), although I don't think it will work
>> currently for PCI devices without an OF or ACPI node - we could
>> perhaps do with a PCI-specific wrapper which can walk up and defer
>> to the host bridge's firmware description as necessary.
>>
>> The common DMA ops *do* correctly keep track of per-device coherency
>> internally, but drivers aren't supposed to be poking at that
>> information directly.
>>
>> That sounds like you underestimate the problem. ARM has unfortunately
>> made the coherency for PCI an optional IP.
>>
>> Sorry to be that guy, but I'm involved a lot internally with our
>> system IP and interconnect, and I probably understand the situation
>> better than 99% of the community ;)
>>
>> I need to apologize, didn't realized who was answering :)
>>
>> It just sounded to me that you wanted to suggest to the end user that
>> this is fixable in software and I really wanted to avoid even more
>> customers coming around asking how to do this.
>>
>> For the record, the SBSA specification (the closet thing we have to a
>> "system architecture") does require that PCIe is integrated in an
>> I/O-coherent manner, but we don't have any control over what people do
>> in embedded applications (note that we don't make PCIe IP at all, and
>> there is plenty of 3rd-party interconnect IP).
>>
>> So basically it is not the fault of the ARM IP-core, but people are just
>> stitching together PCIe interconnect IP with a core where it is not
>> supposed to be used with.
>>
>> Do I get that correctly? That's an interesting puzzle piece in the picture.
>>
>> So we are talking about a hardware limitation which potentially can't
>> be fixed without replacing the hardware.
>>
>> You expressed interest in "some way to detect if a particular platform
>> supports cache snooping or not", by which I assumed you meant a
>> software method for the amdgpu/radeon drivers to call, rather than,
>> say, a website that driver maintainers can look up SoC names on. I'm
>> saying that that API already exists (just may need a bit more work).
>> Note that it is emphatically not a platform-level thing since
>> coherency can and does vary per device within a system.
>>
>> Well, I think this is not something an individual driver should mess
>> with. What the driver should do is just express that it needs coherent
>> access to all of system memory and if that is not possible fail to load
>> with a warning why it is not possible.
>>
>> I wasn't suggesting that Linux could somehow make coherency magically
>> work when the signals don't physically exist in the interconnect - I
>> was assuming you'd merely want to do something like throw a big
>> warning and taint the kernel to help triage bug reports. Some drivers
>> like ahci_qoriq and panfrost simply need to know so they can program
>> their device to emit the appropriate memory attributes either way, and
>> rely on the DMA API to hide the rest of the difference, but if you
>> want to treat non-coherent use as unsupported because it would require
>> too invasive changes that's fine by me.
>>
>> Yes exactly that please. I mean not sure how panfrost is doing it, but
>> at least the Vulkan userspace API specification requires devices to have
>> coherent access to system memory.
>>
>> So even if I would want to do this it is simply not possible because the
>> application doesn't tell the driver which memory is accessed by the
>> device and which by the CPU.
>>
>> Christian.
>>
>> Robin.
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-rockchip&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C618d68406abf46aceb1708da08d1f61e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831995714063605%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=gyKyym%2BH%2F9u%2FfBP953N97x%2BOJBt9EaR2aPivWITwlPo%3D&amp;reserved=0
>>
>>

