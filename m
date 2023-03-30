Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F45C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C924210EEB9;
	Thu, 30 Mar 2023 14:59:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D3310EEB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpEM9eg//2jakdpFer/P0ZzMrLJoCI/Gjlh4337RGLQqp5ruzaK5g44Om/mkY+10zWb2y2BFHjzmEtyBjGyH7YDQW6hk9xAwtouR/4fuGo6P+b3zZAZjThb0CZ2+M0zTvzkwICTyTDlaSGruu44vqC8D9eyjJ5QmX5Y8HyZEcrZBh/rE7xOOs7D+x7ca0gWf5EKal0XHWPHdUne9O8RCsMquYuhHJZ3iSevfcVVKYmhhzlwsO/5/jb0xTqyCCljGstrQudzXwLVjT+CZPCyw5XfinRRN0Ndf1qYmvrf+6NRxOEtno8W4CwOFTGMu44lbO4BiL1K5awU/2+gbF8JdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgDsNW9AYrhsJWomLS2Skd+PV42672LHWvhu0tvrnYk=;
 b=I93zHP1WuS7tSvpJnLsqKmHGVSUjudxrBs27vtpJjLJuTffZ9rf50DnpZ1SJgfvQrXFIi45JyIBPVxdWNLZUzi5/kE8cdZjGJwwv5boWEimNAZj4gRgrVO0XOW1CVs3VpkAfTvwpBuUjTnSqbLxkQA8euxhqBAwKFzQXz8AK612QMKljsu4QxFEgdV5fbKxj9PGdAeBu8hH2MJpbhG1a2mVlvKOLRjZ6iZPg645ys2RDBsnGfzqDAL+snblmzfWCTQogX7MNpnahFJv8GhKg1wo3eFpDv1A4p7Ho28HDMp3mxI1oXNoaTWTjOrh/1nP0pnOQ8Y+iCq9Qt9gSp5N0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgDsNW9AYrhsJWomLS2Skd+PV42672LHWvhu0tvrnYk=;
 b=JjUGUQwuS84ZOh0pg6NCxThaxQxO4y1F+JB+DwkZsQ6hihfBRyHi2wXqzN7CZfGnw3hmY9ehe+WLpra3H3jbk2A7bU/1rLsVYdhY3acVstxoUjsVpfSjEhmeaFqkmnkPFMzN+OH9fSSWt+rqvtnhoAk9hs+aUc93BqPt3jGZaro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 14:59:23 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:59:23 +0000
Message-ID: <e256850e-8392-ce27-5aa3-fa5bb485be71@amd.com>
Date: Thu, 30 Mar 2023 10:59:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
 <fc73c097-5ea9-2e15-f459-e9bc2bd05c95@amd.com>
 <51e57144-dde5-6bfb-45ad-0dcc79bf0cae@amd.com>
 <e41c9db6-8633-e7b6-e1e8-c5bd6d607975@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
In-Reply-To: <e41c9db6-8633-e7b6-e1e8-c5bd6d607975@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL0PR12MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e174dd-5d40-44df-5ec5-08db312f595f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2mJj2YD+eDRaTlnTO7acFMRw7KnzZED8humIW5mSTV1ogNuN/z/IZNKN5ET8NIhbC8Z+mFJT1YLzcdHdPbkOTYzZZURRF3PjNupNCjWAOdPQ15It/4xgLJcGhkPLvVjh6UBSS5SqEpXywpFERU5M8Ns26e3UWWdfiDS7WJ36zaDV67FN2m3c0KlFKMUXup4vgmZs6dBnKzb/q3VvyPpWdxGOIM6J9ly7C0rkxVmdf9Qc70mmw9Vf4fu1jjx759w3NrvtncUN1UOMzORBQ30DgW41nyLJe9iZ6hACGt/rVm2uvTDDe9sMqCqpV5H0Lckr58t0pmWSyfgXSO54mceTKx6bnFyHzSMvZn4oM+irbaeeFfCH0GTFI2Xc6hLAx/3C5koRBPnms9XnlMUGKKBLjpL9CkPCXvLZmnIGYtZ+kna5Xsg4yWP4JGCezRMd7zqN0NCm9TvgUT/luZSI3O5aUQrVM9ZWeUcFc2QlufVce0Ib2fdOfKrlBCuN30C+PojJeQ/Qa+YDf82lui35wIIEfyzQvGOvA5abhjr4+GbR42ZuRLCO/CO+xSnCfF109lMJxaY1LpFLCZU9PQBOycKY6kVXflReU4696dhzziQddCZp2OwAJB/5jRpyJDUytK4vdQCo9Jc38c2PhiCcbESvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(66946007)(66556008)(186003)(66476007)(31696002)(478600001)(4326008)(86362001)(8676002)(110136005)(54906003)(316002)(6666004)(53546011)(26005)(6512007)(6506007)(44832011)(38100700002)(36756003)(5660300002)(83380400001)(6486002)(2906002)(66574015)(31686004)(8936002)(41300700001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRTcWkrUkttc2VXTEJjeisrQUhuUERVSHVQek5wMzRLWmlnMlBEUWhCcWN4?=
 =?utf-8?B?cFZwL2JHMGRZSTEvVXM3WHRIeWNZbmljcWxiQ2Y1WUdHMVFWSjZvUmF6cXhs?=
 =?utf-8?B?YVBzMVVkSXl2ZFVrSFduK1NCUmdQSitIK1NWNlR6d0NoL1M3dHJsdG9ObVJo?=
 =?utf-8?B?RzRuVllmODFnWkU1blBkQ29HdVJ0TUZlV0ZBSnNrVXErUnkwQTV6b2VXRUll?=
 =?utf-8?B?bG5OcXFFZlBGSTNHd2xKWENHRzkyRjVXRElLT21KaGQ1MG13UTNXeEJiUzI0?=
 =?utf-8?B?a3BNWmpUZGpDaWI1UlcvQVZTSjdpeVI2bVB1STlOaFN3cGhWWDEranNoRGJ0?=
 =?utf-8?B?RFlyNDF6SkV6a1JzN3lvRU44eUtvT3pxcmhtemt0TzAwS1ZvZVB1U0ZaVFM2?=
 =?utf-8?B?Wm1wOWZSRjJ0RDdwbmxBWS9TWHgyU0hRbGpWdVE4c3NYU2VKWnBITmtFNHJ2?=
 =?utf-8?B?b0UxbDhsKzl6cjNneWs0SWRFRUs2dTJFWkpTdUlMZmRqR1ZtQllqck9JWXdh?=
 =?utf-8?B?TVY5RG01ZUJnVDRSV3RIazB3M0hwd3NOd0Uyb0hnalpiKzJJbWpicmFWM0Q4?=
 =?utf-8?B?d0wrTkphYy9yaG1CQnNzUHo3a04yR01nTkh3aEFmUXJJNFdOUlhTdjN4VU0r?=
 =?utf-8?B?SW1PZlF0ZjBDcmJmSWxzZE8yZXBuWFdvWWViL2FuNG9qMmtueWZiN2xhbms0?=
 =?utf-8?B?dTVNVDZpM0JKS2srNFJCNXYzMTlWTHc5VE1saTdTcVdlZGo4MExvNkRaUTg5?=
 =?utf-8?B?ck4rUy9JZ21xemc5MHVUc3YvYlZhMFRnQ2x3NE92UFNTdTN6ZWdHLzArYnBT?=
 =?utf-8?B?czFMNnA3TFRDV0lscHc4K1lCR0Exdzd3a3AvS3FJSjhES1NmY1FnbGRUM2Rk?=
 =?utf-8?B?d082UWFRQ0c5ZGNYS21xVWVyWGRvMmsvMWtCbVVLbStwUFFxbDZuanIwMXVn?=
 =?utf-8?B?Y2hSdkZmVU5iYStJaDJsUUQ4bzVrTFNpZDY1eTRrZUNzV3hBTnpTU1k4RXFl?=
 =?utf-8?B?aUdIbzRxZkpHZmN3czRzV3JJTHFlRmMrbWl4SXRYa2tNUFhjcEx1TExkY09W?=
 =?utf-8?B?eUltZzZ5UWMvbnQ4TFFmMk5mcnpGN3R5b2pLOUZQM1NpZWNJRFpxSDJCY2Vw?=
 =?utf-8?B?VDY0ZjFNUzVGWmVha0lUKzN3Qi9DMWU2S25IMUh1OE9MRUJGYW1WRXVqcWxq?=
 =?utf-8?B?amZLcW1KWUoxY1NtODNzN0t5ak1Sbk9xVmZ4SWY5SkpKQkh0cmt0cWxwMW5t?=
 =?utf-8?B?cDE3M0lab1RZYVVoZW56d0czTEFLb1dJTXlqUCtZNC9oZVhxc2RSWkZEOUFa?=
 =?utf-8?B?WFVjN1JwdFhhWjBKbkRicHpYd2JiVm1yRnNLalFrWkpZajdpZHBlSUJTY3J1?=
 =?utf-8?B?bFJzVHh4UmxPRnQrRzQ4TitVYzEybGtoQm8wOGVGS3piRU81ZEpPeEN2T0sw?=
 =?utf-8?B?cEVIekdOVXJKcVNkTGM0aXNCVlpUQ3IxWGw0QitKOHpmZUliMjRVQXhCbXll?=
 =?utf-8?B?RW10a0tIRnJhM1pVWU9MMGhkNlJPRUROU01aZSt6YktQY3g0bk4vNTNwaVRa?=
 =?utf-8?B?elJZc2ZNb0ZEMmRVcXBjZEtCSmIvcnZ0NzJjWGlrQ1RNOUJtZGdrZk92MDE2?=
 =?utf-8?B?dGl4UlhsSEN3Z1U4OXUwMjhMLzRMS1BIOTJIU0xkUFNkOGluMzNia1haUFR3?=
 =?utf-8?B?WFR2ck5QTHIxMXhhWEcwOVo4d2hnRGcvV1RXWE1TcCtMSGhRS211T080Zjcr?=
 =?utf-8?B?UlQxVXVHTURmL3NBWGFlTDcxenVGMVpuZXRtb3JXZDlKVlhiTU1KdTNvbEhn?=
 =?utf-8?B?eWdzQmk4aDM5ZjZIQ1AyK2lXNUNaQ0JNOHcvclQ0STF0WW5UcHJuamhacHBl?=
 =?utf-8?B?dWdmZ3VpUDlZUVZ1RkJBRG5NZFowbGpJVVEvelBMYStaVDJyTlJ4QjIwRzM2?=
 =?utf-8?B?SitZOFJaUndnVzd1akwyK2dldDNQNnliNktIUnYydFFONU1IUDNlWjBObUVu?=
 =?utf-8?B?WUFqSnFkaWhWZjRUd3NaQUNRMzJJNXk2VllTVkVKMUYwY3U5OHRDOWVpV3BB?=
 =?utf-8?B?ZVdpQWhRak1QOGprNTJQa0g0WmlmYi96czhoODIySi93WWdjb1VSZDhYcXpu?=
 =?utf-8?Q?h0QhsE+8AlUi4zaGa7f4wFoTd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e174dd-5d40-44df-5ec5-08db312f595f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:59:23.7380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6TDUQHFidit6Xe81JcTkAanl4UI6xcMGl/aG6Lf2KZ6RUUkXaqIzuDtNjepkrbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 10:53, Shashank Sharma wrote:
> 
> On 30/03/2023 16:49, Christian König wrote:
>> Am 30.03.23 um 16:40 schrieb Shashank Sharma:
>>>
>>> On 30/03/2023 16:24, Luben Tuikov wrote:
>>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>
>>>>> This patch:
>>>>> - creates a doorbell page for graphics driver usages.
>>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>>    kernel-doorbell-bo's cpu address.
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 
>>>>> +++++++++++++++----
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>>   3 files changed, 57 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> index 6581b78fe438..10a9bb10e974 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>>       /* doorbell mmio */
>>>>>       resource_size_t        base;
>>>>>       resource_size_t        size;
>>>>> -    u32 __iomem        *ptr;
>>>>> +    u32    __iomem        *ptr;
>>>>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>>>>       u32 num_kernel_doorbells;
>>>>> +
>>>>> +    /* For kernel doorbell pages */
>>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>>   };
>>>> Here's an example where it could be confusing what the difference is
>>>> between "struct amdgpu_doorbell" and "struct amdgpu_doobell_obj".
>>>> As the comment to the struct doorbell_obj declarations says
>>>> in patch 7,
>>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>>> +struct amdgpu_doorbell_obj {
>>>
>>> What is the confusion ? This is the object which is holding doorbell 
>>> page. There could be 2 type of
>>>
>>> doorbell pages, kernel and process, this is a kernel one.
>>>
>>>> Perhaps we should call it "struct amdgpu_doorbell_bo", since
>>>> it does contain amdgpu_bo's, which are doorbell's bos.
>>>
>>> This is not a buffer object (memory), this is doorbell object, so 
>>> calling it bo would be wrong.
>>
>> I think what Luben means is that in object orient programming this 
>> here would be the class. The object is then the actual instantiation 
>> of that.
>>
> Why should we even bother about OOPs terminology in kernel C code ? I 
> think we are spending too much time in something not worth.

Because you're using "object" incorrectly. Especially for people with
vast programming experience, this creates confusion. Please don't use
"obj" in the name of a structure. Perhaps use "bo" or "page" or something
which it really _is_. But don't mix OOP terminology in non-OOP code. We
have people who program both sides of the isle and this creates confusion.

Let's use structure names which really describe what something is. This would
help very much new people reading the code in the future, to form mental
concepts and better understand the code.

Regards,
Luben

> 
> 
>> But I have some real doubts that this is the right approach in the 
>> first place.
> 
> 
> I would like to discuss and understand more on this technical aspect. 
> Can you please have a look at the whole series and check how we have
> 
> handled the existing doorbell clients (KFD, MES), and if you feel the 
> same, we should talk more on this ?
> 
> - Shashank
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> - Shashank
>>>
>>>>
>>>> Regards,
>>>> Luben
>>>>
>>>>>     /* Reserved doorbells for amdgpu (including multimedia).
>>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct 
>>>>> amdgpu_device *adev,
>>>>>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>                   struct amdgpu_doorbell_obj *db_obj);
>>>>>   +/**
>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>>> doorbells for graphics
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * Creates doorbells for graphics driver
>>>>> + *
>>>>> + * returns 0 on success, error otherwise.
>>>>> + */
>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>>> *adev);
>>>>> +
>>>>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), 
>>>>> (v))
>>>>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct 
>>>>> amdgpu_device *adev,
>>>>>       return 0;
>>>>>   }
>>>>>   +/**
>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>>> doorbells for graphics
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * Creates doorbells for graphics driver
>>>>> + *
>>>>> + * returns 0 on success, error otherwise.
>>>>> + */
>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>>> *adev)
>>>>> +{
>>>>> +    int r;
>>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells = 
>>>>> &adev->doorbell.kernel_doorbells;
>>>>> +
>>>>> +    kernel_doorbells->doorbell_bitmap = 
>>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>>> +                              GFP_KERNEL);
>>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +
>>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * 
>>>>> sizeof(u32);
>>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>>> +    if (r) {
>>>>> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", 
>>>>> r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * GPU doorbell aperture helpers function.
>>>>>    */
>>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct 
>>>>> amdgpu_device *adev)
>>>>>           adev->doorbell.base = 0;
>>>>>           adev->doorbell.size = 0;
>>>>>           adev->doorbell.num_kernel_doorbells = 0;
>>>>> -        adev->doorbell.ptr = NULL;
>>>>>           return 0;
>>>>>       }
>>>>>   @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct 
>>>>> amdgpu_device *adev)
>>>>>       if (adev->asic_type >= CHIP_VEGA10)
>>>>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>>>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>> -                     adev->doorbell.num_kernel_doorbells *
>>>>> -                     sizeof(u32));
>>>>> -    if (adev->doorbell.ptr == NULL)
>>>>> -        return -ENOMEM;
>>>>> -
>>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base, 
>>>>> adev->doorbell.size);
>>>>>       return 0;
>>>>>   }
>>>>>   @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct 
>>>>> amdgpu_device *adev)
>>>>>    */
>>>>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>>   {
>>>>> -    iounmap(adev->doorbell.ptr);
>>>>> -    adev->doorbell.ptr = NULL;
>>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>>> +    amdgpu_doorbell_free_page(adev, 
>>>>> &adev->doorbell.kernel_doorbells);
>>>>>   }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 203d77a20507..75c6852845c4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>>           return r;
>>>>>       }
>>>>>   +    /* Create a boorbell page for kernel usages */
>>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>>       /* Initialize preemptible memory pool */
>>>>>       r = amdgpu_preempt_mgr_init(adev);
>>>>>       if (r) {
>>

