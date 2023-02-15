Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8A3C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 22:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DC410EC63;
	Wed, 15 Feb 2023 22:18:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F4010EC68
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 22:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMbpjaJ/3qeDqBRCZoJzBRX8UGCDvppGlsnHZeW4CnOi/sQLrLVinevXSzXQtXloc6qBCn6nucTkKKFvWkD8dU1p1SVOU2oW4TFrKx9GlofNR6WJ2HvH2tpoxXrOpwTBP4GwQ11tP1t0uGA4cImTDPseoIQ7140WM8izzHDjbINL+evmnkCxlreDbUZEGPObhtHOGKCkB8P3s79g9SKEZNgDkwK5WOz60zArbomp8NXzfBATX00OTxskp8J3Qiy6+z+gZBIWmIpe6kD64jvF4XceV0/BAHqzifrofhX1E9dVtW9f9tmuyNvQMDPP4L0nZ9lZ+Kncy+yKkRos8t3A4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41076B327dzv5D0uktbnFJn5RI2yr+Q8SvRMEkdxhTs=;
 b=K5ppO+OwX16g21YLcJFsYJtK8VXZehEA1MUj++LP6F8vc26XYQpA6SS8IQ20N7RM8L9nfGsE+kKEoP5zIuvZeajtC7v5AOUU7klI/vqsqxyaKd4Q/zyYMN9RSkWq6CDZ3PSuMQUcvkbeWaDX78QYPIwwinm4cNW3iqoijTzlSzWV9J+w9kt+ihz51n/lQ3YJjkBrotNPHZa19dkKgk88euNTukS1IDSfrOJMHUjYBrnUecWY1HBo5fB/eOhmxuZXJin4qLdYzESxU0U6iPBqJaqDKFytl0ivDwsSAz61uoStr7eIzTU9tgVTlr+40tP9lxXROPcA6xdY8K2Z6lC37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41076B327dzv5D0uktbnFJn5RI2yr+Q8SvRMEkdxhTs=;
 b=3eXjbDvP6r2y5KBIdDg8BZsDEXSO21fI5l6mqBY260yQAGZOP4/rny/4WVJ+HM9czUc8BCgztgaAKtQgYBB2wQNf3dMNPic+rYFdkJwnX5whPtDELZe5dBb5erbJHS6ofk4YjBW9+o2buOV2U3y5xN3hxDQx1P5/TdQd6DWOLxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Wed, 15 Feb
 2023 22:18:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%5]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 22:18:38 +0000
Message-ID: <46fd3add-e02e-9a88-f672-3ef09da1aced@amd.com>
Date: Wed, 15 Feb 2023 17:18:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Xiao, Shane" <shane.xiao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20230214111851.2525197-1-shane.xiao@amd.com>
 <ca40db72-6c04-e3cd-38f9-3254f37c850a@amd.com>
 <DM4PR12MB526136D00F81419EEFCE47579DA29@DM4PR12MB5261.namprd12.prod.outlook.com>
 <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
 <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
 <62ca76cc-a553-21c2-9538-03cefb7b02ac@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <62ca76cc-a553-21c2-9538-03cefb7b02ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: faf837a9-1ed2-4a6b-fcd4-08db0fa295f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hhjnlk/QETSpGjkbjTmkLDU3+7I+fxB6F+J//kq82dru43pBluVOZME0+OgkiCusiJlwlreWsti3iB1uq84cr8cHk1OGCCu+shLnkbzy6e25p+TOF/lmYOkaflRJSmBqUz/todyIdEDz4lCf+PzevyitDbgL3Jdkl5m5uqv85JmaCtzm0eK+vWVybNak/btnIvDJSskC9UQmUdTDDn/57lD9mM59waeXWI2AWMsDhQzy0xpIWhtUCnTdUEJ/ODZd6yJWKvo5QtZc4IxAxiBcG6fL4H2m3myYkaa67Q6L8Nst4Ba3FED40eXlrcveoAdFgK73F9f0deCE1Op415wjDULm8dXfXZqoY6DoMiW7J/pB/Ci2IGCVjeQOj0/fjx8jfBg+2JpMM2BXPnXwWMDTmJ70tRwBZd+467UO0Cr1DBxcg6mq0rt1EG1DGoShl1IRDYr1AF4DWF3aDatnhgEU6o4+NpL1oz5lFQa9M2cQpCQhm5lHvroeJge7gqhZ9hNzwbCZ1+jUo3GhBOm99nlhi122UvWipwvc9YzPT5bxpCxlBT4vc4ReYAfo9eF3xOyTw4FH9kHAdgR+7jgG0UCUIUOfvBLjp7mXZmgMufRikSaIC+f0EMiag9NtzZK6E4XV8aVRJPW1C5VRPhsW+FKh/3mBib+q6QYa+64ogx9AjvE1svMSkg2pb00HS8o81klsGB+RywXw8mKOlTUcSvlVxc2fhgWS4Y/7g67KAFnR3SA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199018)(6636002)(38100700002)(6486002)(6512007)(83380400001)(66574015)(36756003)(26005)(53546011)(478600001)(6506007)(2616005)(6666004)(186003)(31686004)(44832011)(66556008)(66946007)(8936002)(86362001)(5660300002)(66476007)(41300700001)(31696002)(316002)(110136005)(8676002)(2906002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1pWcjdYQ1R0V05vNVY4RjNlNGxvclBWc21hSEJaWVdWYkVOdTVoRHFzL2pz?=
 =?utf-8?B?YW5XS3J6UzNYVTVNdnhRVmhNbEQ5OW1ZMFlFcStpbHFaNnJjSUVpekZBazk1?=
 =?utf-8?B?eHNYTi9WdThYa1FvRWZFWUNzeEsrYUYvNitBeTlac0VpSUlDM2kvKzZJaU5y?=
 =?utf-8?B?UEx3UFYyTUZLdjFRQmsrbFczOG9DTk1sQ0plL0FPU3VTcHVKdUw4UUgwOHBn?=
 =?utf-8?B?MmFoOUUzOXJCY2lWUUVDcjl6QWU0Y2ZURU9RZkxIRVlWQ3hjSlNnOEVYdnJN?=
 =?utf-8?B?eWcrVWt2Z2oxQVpQbFRQVUlzMDM5KytvNXM3ZFNDUWNDZVNuVHc1bE5GY1BX?=
 =?utf-8?B?aEpQV2V6aGwzM2RIVW95QUgxSVJ0T2pXb2pzOVNxU2Y5MHd6ZmMxQmI1R2w1?=
 =?utf-8?B?SmlUcTVMUlVyTDQxWk5CZFpHeUF1TDFVRGNWMnpPMjlKR2owUnpmTU9Pdm1L?=
 =?utf-8?B?V0dYbDlzOEJEczRmbStuWnptNENkUytCTkVWc0JYSjhRYUhINW9LR1JqSkVH?=
 =?utf-8?B?TEE2eGp0WUNmT3U5YVFzaUQvOXBuOEo2Tm5QQk5MbU1uMUNYQk54ckVjRGtS?=
 =?utf-8?B?M2ZIV2QxNUxtMS9mSUovU3VwN1lCbXFjRkozemdpdHNyK2IzclFQVUVndWMx?=
 =?utf-8?B?aE1FMGNyajBUM3A1eU9vK2xNUnlOMEErcnRjTm9zeCtvOGZqOG53dGNsVnVj?=
 =?utf-8?B?dk1Jd1dZdXBGdWJsdWRMU1VqLzNOc0Q0QU9WTE4wNU1DVmR0Mjc3T2ZRMkQ1?=
 =?utf-8?B?dUlERWE2U2xpMXIxVndLUjE4K0gzRTdMVk9EUUptVXhUYVE0aElYK29FWlpI?=
 =?utf-8?B?dG5vMUlzdkZKMUFFTUliWmFXdlJPU2tZS09tbXVlbDRseTI2aytLRml4Nzk0?=
 =?utf-8?B?dkMxc3l2SmRKR0cza1M5OXZHSnJ1ZHViRlJWN200clJ5aWk1bWJEK1JvQTJw?=
 =?utf-8?B?YkQxWmVwa1cvdkllV1JkTUErSTBYV3cwaW5pQzhzWjR3TzZBajlzZ1BjeFNh?=
 =?utf-8?B?Vnk4Yko2UFUyOXJmM0p2NFRySkU4VHBzSTJQUzBJS1VPK3JJSkhrUGVIU2d5?=
 =?utf-8?B?V2dLVy9nanBaUjZtcGhCWG9mRlVpbzBCZ2Uxc0lsYkloU1BuZFdaR1k2QTJs?=
 =?utf-8?B?RGJnRXhrRWw0SzhtZFhJd1BVS05aQVJHSWNCL0RNNk5hd3YycW1mbEZ2WU5W?=
 =?utf-8?B?UmRGZTFGeThtdEhldm03bHc0Q1BoL05TS3dySVFoSnhjSm94MjFoekg3R3pv?=
 =?utf-8?B?c3hEbmVzTnczclgrbkYvenYrbWtkbzB5c3pMbUpWbzZOWWVMWldibDlTRzZJ?=
 =?utf-8?B?N0FLMVh6R0o5TmRlRlUwUUkyZ0VCR3d3Z21TK0hYQm5HczdXbnhUZzJCdDJO?=
 =?utf-8?B?SG1qdzI3Tm1mc2NBY1JWanlFN2p4V3VySm8zYng3bzl5dnpsU2FETndZNFB4?=
 =?utf-8?B?RERPSjFPL1NObys4UW5DRWYzM0ZpTk9BV01DUmdNQURJVXVZQXZOY1NnRnlP?=
 =?utf-8?B?RTdVZnA0bk5IZmtXSE5NejFuaE41Ykovd0FsUXplVjF2ZUpmSUIzYXV2Mlh6?=
 =?utf-8?B?dXI4MUtOSGVMR3phVjloanVIOFVlRzFlTWQxK3dPTGM0UEZuZFJpb0FzQk4y?=
 =?utf-8?B?ajA5U0UxYVBiTjZHeGZaenVsVVRuNFpiaDJmcW55MHBjdEZaMURDdDdNamY4?=
 =?utf-8?B?Z1pnd0dyTlRNbXVCdnlIYzkxbTVnTzBOb2lpQnJUS2VIVmRPcXprRXNDeitk?=
 =?utf-8?B?OGRXelVRSENjZFdIaEZIQitaNWxCTnFXN1oxb25ONVZEeWhEZWR3QW9FUGxw?=
 =?utf-8?B?czlVTFZwYUVaOHdoSXJpemJGTEhoMFByYTB1T3pGNC9OaDVKQXRGZElURmpa?=
 =?utf-8?B?K0FoUlpmbDFYclRaMWVkSWUxWS9Gc2hQbGNCd3lQQ1hmRE5KZFVlVFFTdy9J?=
 =?utf-8?B?V1VjRG5IS2ZXLzB4cVlXQWhMblViTTFQV21tNlc4c3ByNERTZVBnK1lDSWRn?=
 =?utf-8?B?ZFUzSGs3ZUROUWRNRnpRRzVPcExPWHNQaFB6dDZJM2o2SEZZeTJLNlVETS9T?=
 =?utf-8?B?ditlelM0N1JzWkhqRFBwck9DblBKQmpkOUNMQzZHRCt0R3hGY1FscHM1clpv?=
 =?utf-8?Q?pEa561TV7AjhIj8FLC0YaXHAS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf837a9-1ed2-4a6b-fcd4-08db0fa295f5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 22:18:38.0289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fgb2bC/K6q9xt7avuUUnfqOz1SDkF4bE/PKHnlQ2IezHz5amGh0QtxhlTvkLxO0Hut88/9DcDhoErGPVQfYzEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2023-02-15 um 05:44 schrieb Christian König:
> Am 15.02.23 um 03:51 schrieb Xiao, Shane:
>> For public review
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Wednesday, February 15, 2023 3:02 AM
>>> To: Xiao, Shane <shane.xiao@amd.com>; Paneer Selvam, Arunpravin
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when 
>>> using
>>> drm buddy
>>>
>>> Am 14.02.23 um 15:53 schrieb Xiao, Shane:
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Tuesday, February 14, 2023 8:41 PM
>>>>> To: Xiao, Shane <shane.xiao@amd.com>; brahma_sw_dev
>>>>> <brahma_sw_dev@amd.com>
>>>>> Cc: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when
>>>>> using drm buddy
>>>>>
>>>>> Am 14.02.23 um 12:18 schrieb Shane Xiao:
>>>>>> Since the VRAM manager changed from drm mm to drm buddy. It's not
>>>>>> necessary to allocate 2MB aligned VRAM for more than 2MB unaligned
>>>>>> size, and then do trim. This method improves the allocation
>>>>>> efficiency and reduces memory fragmentation.
>>>>> Well that is a trade off.
>>>>>
>>>>> Allocating the BO as one contiguous chunk and then trimming is
>>>>> beneficial because if we then later need it contiguous we don't need
>>>>> to re-allocate and copy. This can be needed to display something for
>>> example.
>> Hi Christian,
>>
>> This case means that you allocate BO that is unnecessary to be 
>> continuous at first time,
>> and latter the BO should be continuous. I'm not familiar with 
>> display. Could you give me
>> a few more specific examples ?
>
> On most generations DCE/DCN hardware needs the buffer contiguous to be 
> able to scanout from it.
>
> Only newer APUs can use S/G to scanout from system memory pages.
>
>>>> Yes, I agree that one contiguous chunk may get beneficial sometimes.
>>>> But as far as I know, you cannot guarantee that amdgpu_vram_mgr_new
>>> can get one contiguous chunk  if you don't set TTM_PL_FLAG_CONTIGUOUS
>>> flags.
>>>> For example, if you want to allocate 4M+4K BO, it will allocate one 
>>>> 4M block
>>> + one 2M block which is unnecessary to be continuous, then 2M block 
>>> will be
>>> trimmed.
>>>
>>> Oh, that's indeed not something which should happen. Sounds more like a
>>> bug fix then.
>> Yes, I think this case should not be happened.
>> Actually, I'm not sure that why the allocated BO should be aligned 
>> with pages_per_block, which is set to 2MB by default.
>> Does this help improve performance when allocating 2M or above BO?
>>  From my point of view, the TLB may be one of reason of this. But I'm 
>> not sure about this.
>
> Yes, we try to use allocations which are as contiguous as much as 
> possible for better TLB usage.
>
> Especially for some compute use cases this can make a >20% performance 
> difference.
We actually found that >2MB virtual address alignment was hurting 
performance due to cache line aliasing. So we can't take advantage of 
 >2MB pages in our page tables.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Best Regards,
>> Shane
>>
>>>>> On the other hand I completely agree allocating big and then trimming
>>>>> creates more fragmentation than necessary.
>>>>>
>>>>> Do you have some test case which can show the difference?
>>>> I have use rocrtst to show the difference.
>>>> The attachment is shown that after applying this patch, the order < 
>>>> 9 total
>>> vram size decrease from 99MB to 43MB.
>>>> And the latter has more higher order block memory.
>>> Arun can you take a look? That problem here sounds important.
>>>
>>> Thanks,
>>> Christian.
>>>
>>>>> BTW: No need to discuss that on the internal mailing list, please use
>>>>> the public one instead.
>>>>>
>>>> I will send it to public. Thank you for your remind.
>>>>
>>>> Best Regards,
>>>> Shane
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>> index 75c80c557b6e..3fea58f9427c 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>> @@ -453,7 +453,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>> ttm_resource_manager *man,
>>>>>>             /* Limit maximum size to 2GiB due to SG table 
>>>>>> limitations */
>>>>>>             size = min(remaining_size, 2ULL << 30);
>>>>>>
>>>>>> -        if (size >= (u64)pages_per_block << PAGE_SHIFT)
>>>>>> +        if (!(size % ((u64)pages_per_block << PAGE_SHIFT)))
>>>>>>                 min_block_size = (u64)pages_per_block <<
>>>>> PAGE_SHIFT;
>>>>>>             cur_size = size;
>
