Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BAFC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 19:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBEA10E5D5;
	Mon, 24 Apr 2023 19:11:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758D210E5D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 19:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbp49zsjyzkyhY9/oimOPPPBwn4KuSMDrisP2FwLvl49mynaWnmQRXQ6k624chZSU0JNS8cFq1hL36MACLj420eDfENgdd4V69OCjrp6CcjL9DFglaZMZYgAzzvBjN6p5xG6viFKPdZx0sR/mtsYwtKr4EEqHtbMtPyCft52pABPKpi77a0xPeIDrplQm7u6XQJhSZZ3UgcnTOeXOSokMYTf6sGC1REkimC3URJklqyJD0qnLXDTBeVCEbGoxWikabaDCued54iQo5txukNn/JK2v9gESIxO35p0BjmGJ1FSRFnSQ34GathpQBst6mZ8/vZmlgHdIcKmtv9PnY5Xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSGx+ooROooBnpJIxa4zqe2TV+9uPEmh2a8YA5KJtas=;
 b=LmzIVIvbLZ9eucaTHRHpBtyk4aa//n9SQLQ+icBFOD48KJoiRWpadaVId8InM0q9lGBnZLgZrC59j0N0TMdont5twE/1QYoWgtZYZlIl662FzxkXRzBb0LJ+4GuJvf4ZslTsDOGkUO1MHkyCiJsQyRO2GZhyJmGxW4g4hOgRHc/a0mXrrvPThj8i4nujO1EYwhfxINnLHxMzTkp7d1c2Xv6oM9vRjzBM+BAqbhVz+2tHZ7HF2OCAgh2hWdAGv6g8JR6wCrVE4XyYmFnljh6tfhKNnPL2jHD36uFRnVaZewK6mpJRIjx+WBekep4smTFplVNNQikB033n8fhTAreV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSGx+ooROooBnpJIxa4zqe2TV+9uPEmh2a8YA5KJtas=;
 b=FpV0v7s0QUq6F+gM67k+sn5bmuL7Bna/W82Trw4Q0Rpi1Ie27iVD77GttGOxFg9msXv8n7azlFv7jzW5cXCoQO42fu9KQWk2oba+jmnvq8aDj79vOPjS8soHewLUnkhGMx/SEj5uc52GMEB8VjbYHHgun33oyLYnAIP0sqRZ4Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.28; Mon, 24 Apr
 2023 19:11:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 19:11:26 +0000
Message-ID: <ac04f565-8336-fff6-e93b-a3021613558e@amd.com>
Date: Mon, 24 Apr 2023 21:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230418065443.878721-1-shane.xiao@amd.com>
 <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
 <DM4PR12MB5261E710B9A6F7BA6BF52F009D679@DM4PR12MB5261.namprd12.prod.outlook.com>
 <DM4PR12MB52615C85D3EA998E157686AD9D679@DM4PR12MB5261.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB52615C85D3EA998E157686AD9D679@DM4PR12MB5261.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a91baf-533d-4b6b-865c-08db44f7b309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1ZB9keyhK9MgdCxR0tXB93/YrEjE9m0UjN9reOBkY2zRsAKPbFGTPI+srOyXnqWvGwHAPheXRiJnQIRssHExu6iGCXxoXPNv5Gj+ETakSlVjGq+2FLjHWzUOnBkBhght7eLlF4sP9iJh3CrN4wYHcHk5IpJDooCDh/ukRYtFRXN1x1wQS9xQ9AlWQtF6jJTvp1iNBz7zQQHd7FDTsIM+lK8mqF/MY1FJhQuDSOyDPhX6oMK+D5s6K0jProwYM2cliJ6Lr4x2CTck3GS1LDIU2pKH0ACw6yq3aaZC9guKhq4twRjaV7VcytJO2+qU8HeifIKdCKVxeik7UMi4atQcU/SPumsnNQ+M0kVj/viBj650wgoRAm/XO7ZfygAaUNYXFNUJ2RyCX+HmOcgwADWm+aG2rL1+iksdQS5DgeCFAOj0Xh+k9Sr69Jef/HNfh0TH93nmtFZnhzqAPf1diWX0jI+W9UrAru+u4gIk8jUeYNarLN7QOlb3qdwPzAx+FhtMlhxgGdjQO1VPNf0i1iYWg3BxB0OdTSqpXX64Ih7KFElqzU1ASqmWsqmGidUC2l1xmYYKVhyHFQ+/9bSSsAXg47IbA1GNskW/PmS67BMrRnT6OhHgE5I/ZXj/FpfN8eSKvlM+1oEj8ZJFZYlRCM3NTJd6QiSPWBTJDrGs0+cDfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(6636002)(66946007)(4326008)(66556008)(66476007)(31696002)(478600001)(83380400001)(186003)(53546011)(6512007)(6506007)(6666004)(2616005)(86362001)(6486002)(36756003)(110136005)(54906003)(8936002)(5660300002)(41300700001)(921005)(2906002)(31686004)(38100700002)(316002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01nNEtud1FzMVcrTWVUWXUxaDFmSUpkaEU0OGw1MUN0V05yVVdyUVBJNmRl?=
 =?utf-8?B?c0QvKzVHVWQ1NzFZSVZiTXhqR2xUbzVEVEV6K29wYkMvTkpRb3l3VnluUTd4?=
 =?utf-8?B?UkNueDUwV0k2KzdOd0FUVHhES0ZsQjkzTkE1TU1KclFWOGJueW1CZ1VjSjl3?=
 =?utf-8?B?SVdoeG1kS2RwbGx4V1lhZjZid3NRQldoc2tGNStEUUJqTnQ3Z2Qzbitjc1ox?=
 =?utf-8?B?TWtIZ0wxZHRKaHhjanNralBEa3NmdyttdU80VzJ6RFJ3azV3UE5laHh5RWI5?=
 =?utf-8?B?RUtmRmhEeGtoZEZoY2I2YTBPT09ZbzRvcXRKWWl0Zk1NWkduL1lQOXArbjNY?=
 =?utf-8?B?bFVFcnYvQ1dmVHpuS2t5NE9kSEpqNmxoMTB4Zk9kaEg2NDNvRnRaY1FvSGMz?=
 =?utf-8?B?OWs3VVJIN0drMDlEYWRCRWdKWEZjR2ViVzAzSTQ4b1VNdWVST2JTOFVxSkda?=
 =?utf-8?B?S2RJajBzNWM2TGFhTVV4REFPbUtmcmgxK25DSWRrSFpyMll1QUJDWlRmdmZQ?=
 =?utf-8?B?aDQwSnI2TnpOeG9YMkFYSTF3UjFkQWNmRDhkblBidVZBSXJ6Zk9ibnlPOThQ?=
 =?utf-8?B?UjRZTWtZKzFXQ3Zib3ZPYmV0K2Y4RnFadWd3bW5qMEEvM3N6S2JXZnpEZmZD?=
 =?utf-8?B?aXRLL3hxNXJvUWJEVTQ1azVXVUNyL2lEdGMxdTN6djVVb2hKeGFlb2JQMkxU?=
 =?utf-8?B?c0xiY1ZuOTQwVlVTR3UyejBKUklVOUNMaHZHc0tvRzNGeURoRUFOa2l2dkJ5?=
 =?utf-8?B?YkpBdTF1dkhhUExRRmpDYkVLUzJUb1JrcWNNd3FHdFNLVlFMZzlJZWp5N3dQ?=
 =?utf-8?B?ZHo1ejBVWHhQK0pURzlpbWg0RFF3VmpTOEoxQ2pCSHZGTFhDdG9GVThQSVUz?=
 =?utf-8?B?Sk5jVE40MU1MNGI0RElkVzJKVU5hQ1VtUmtCNFdmelg3WTcrQWFmaHRaZzBM?=
 =?utf-8?B?WkY3YWJyRDVRUDBRVFpYYThYeVpPdHFTelFTNWVHZ0hNMmtUeWlqTFdySHk0?=
 =?utf-8?B?OUc0TExhSXAzQmdQV0ZJNUNIbS9UR216YzZBaFJlR1htcUllcGpNOWpkeWJD?=
 =?utf-8?B?Wk91UTQzQUJHZDY5UTMzOHVhb1k0TktQaU5jMlNHVmhQeW1lUVNjS1kvV3Bk?=
 =?utf-8?B?UmprYnhiZ2ZzUzlRZzU1NUY0a0JHdnN4WFU1bHRKZk9zbUZHNHZObkh6bDlI?=
 =?utf-8?B?Y1o1aUxCbTdJa3cyaGd5elpwdXQxZWwvbk5VR3JrL1dzS1NmV0hlKzNGMnhX?=
 =?utf-8?B?QVhYUHp4Rlc5UkRHT2J0MVZFcnJRVmpOdkFwWmRqWnYwalExd0EyQ20xSm5W?=
 =?utf-8?B?UE1sWFJZUWx4WjdQNUo4OUZYZHdDVUdQSDJVUlFiME12dHZhUVpDVlZraW4r?=
 =?utf-8?B?a0NlaFUxQmJBVE1GSURJU2h4QzVvQjVmQitzMU9TWlZjaGtyL3diUnkyMllz?=
 =?utf-8?B?U094UVEvTmhMTGVuVkh3T1cxV3crTlVXRXc4SUoyYm1xYXhlWEZHekw3cHFm?=
 =?utf-8?B?cHoyRmhWTktnWERudDZqaS80Vm1reEh0WG8xMjhQL2c1elJmUjkyc0FnckVH?=
 =?utf-8?B?UW1zUjYrWGJhOGhlV0xyd0hnYmtLMU4xMzBHd3RwSCtuZnI5a1QyNlZIWlNI?=
 =?utf-8?B?L05sNnpHZjdyMWIxbWo3WWtWR3V4U1g3WnA5S2xmZGVnVlNKQzJBMFNzRXdT?=
 =?utf-8?B?NUdPTmVXY3cyandsNGkrVkRVWnR1L3JuYWJIcFh2QTVtZktGcHZEeDBmc2th?=
 =?utf-8?B?RWVtMVBJMzlzMG1maGdsb1VaVVhKdW5zSVJmZ2xIQXNKQzdjRVBNdWllWlpM?=
 =?utf-8?B?U1d2NGhidXorSVA2MDJNUE9DMkhoU3hhU3daTUlNbFJUS2pkdDZ6ekRwR05B?=
 =?utf-8?B?YWptL1BBaXBKU25MZjhsZXppQlJ2ZWdvMUR3ZWNHeHVIVHV2SzlwTlp5aUhF?=
 =?utf-8?B?NE9temJyV21nRW5CV2EvSUxzQjYvN0ZhbXRZdEpQa05tUDBFY3hSeHIwMmpC?=
 =?utf-8?B?aGYra3hvcDlBNWZZZ2tFeXFwN0tVWkRKZDlsTmh4Z29RN0FqbWM4N09IWFZk?=
 =?utf-8?B?eXBMZVRoaXFpK1g2VG5iRWs5VVd6YWd5VDJMZThzYUpCRmlNandtRml4NEdF?=
 =?utf-8?B?a3prR3lLUzVJZUJhVnBIMmdjeVAxNkVqakJFQTI3NHBTZVJZY3gxZTVDcmNv?=
 =?utf-8?Q?Ptw1bDrac+mZrkTMF/K9iX7G0ugJEFwsNvxtQJ+bb3h5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a91baf-533d-4b6b-865c-08db44f7b309
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:11:25.7906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b61pvkqSNulTs2fllYeDiG0HbKDG/r3JhpYlh25/paEnrRSrAj9bFgd4QRHkW5PI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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
Cc: "Hou, Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 16:06 schrieb Xiao, Shane:
> [AMD Official Use Only - General]
>> -----Original Message-----
>> From: Xiao, Shane
>> Sent: Monday, April 24, 2023 6:31 PM
>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; amd-
>> gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron
>> <Aaron.Liu@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
>> successfully
>>
>> [AMD Official Use Only - General]
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Monday, April 24, 2023 5:07 PM
>>> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>>> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron
>>> <Aaron.Liu@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if resize
>>> BAR successfully
>>>
>>> Am 18.04.23 um 08:54 schrieb Shane Xiao:
>>>> [Why]
>>>> The selfring doorbell aperture will change when we resize FB BAR
>>>> successfully during gmc sw init, we should reorder the sequence of
>>>> enabling doorbell selfring aperture.
>>> That's a good catch.
>>>
>>>> [How]
>>>> Move enable_doorbell_selfring_aperture from *_common_hw_init to
>>>> *_common_late_init.
>>> But that sounds like a bad idea. Instead the full call to
>>> nv_enable_doorbell_aperture() should be moved around.
>> Hi Christian,
>>
>> Yes,  I get your idea. But as far as I can understand that, the gfx hw init will use
>> doorbell.
>> If so, we cannot enable doorbell after gfx hw init.
> We have come up with two ways to resolve the issue.
>
> 1) Separate enable_doorbell_aperture and enable_doorbell_selfring_aperture. However,  the enable_doorbell_selfring_aperture
> should be moved in *_common_ip_funcs->late_init.

I'm not an expert for this part of the driver, but of hand that sounds 
like the right way of doing it.

Alex any objections?

Regards,
Christian.

> 2) The full call can be moved to gmc hw init.  But it seems strange to move nbio configuration into gmc hw init.
>
> If neither of the above methods is suitable, could you please give us some advice on this issue?
>
> Best Regards,
> Shane
>
>> Best Regards,
>> Shane
>>
>>> Regards,
>>> Christian.
>>>
>>>> This fixes the potential issue that GPU ring its own doorbell when
>>>> this device is in translated mode with iommu is on.
>>>>
>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
>>>> Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/nv.c    | 4 +++-
>>>>    drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-
>>>>    drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
>>>>    3 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c index 47420b403871..f4c85634a4c8
>>>> 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -535,7 +535,8 @@ static void nv_enable_doorbell_aperture(struct
>>> amdgpu_device *adev,
>>>>    					bool enable)
>>>>    {
>>>>    	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
>>>> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
>>>> +	if (!enable)
>>>> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>> false);
>>>>    }
>>>>
>>>>    const struct amdgpu_ip_block_version nv_common_ip_block = @@
>>>> -999,6
>>>> +1000,7 @@ static int nv_common_late_init(void *handle)
>>>>    		}
>>>>    	}
>>>>
>>>> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>>>>    	return 0;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> index bc5dd80f10c1..0202de79a389 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> @@ -623,7 +623,8 @@ static void
>>>> soc15_enable_doorbell_aperture(struct
>>> amdgpu_device *adev,
>>>>    					   bool enable)
>>>>    {
>>>>    	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
>>>> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
>>>> +	if (!enable)
>>>> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>> false);
>>>>    }
>>>>
>>>>    const struct amdgpu_ip_block_version vega10_common_ip_block = @@
>>>> -1125,6 +1126,7 @@ static int soc15_common_late_init(void *handle)
>>>>    	if (amdgpu_sriov_vf(adev))
>>>>    		xgpu_ai_mailbox_get_irq(adev);
>>>>
>>>> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>>>>    	return 0;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>> index 514bfc705d5a..cd4619085d67 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>> @@ -454,7 +454,8 @@ static void
>>>> soc21_enable_doorbell_aperture(struct
>>> amdgpu_device *adev,
>>>>    					bool enable)
>>>>    {
>>>>    	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
>>>> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
>>>> +	if (!enable)
>>>> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>> false);
>>>>    }
>>>>
>>>>    const struct amdgpu_ip_block_version soc21_common_ip_block = @@
>>>> -764,6 +765,7 @@ static int soc21_common_late_init(void *handle)
>>>>    			amdgpu_irq_get(adev, &adev-
>>>> nbio.ras_err_event_athub_irq, 0);
>>>>    	}
>>>>
>>>> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>>>>    	return 0;
>>>>    }
>>>>

