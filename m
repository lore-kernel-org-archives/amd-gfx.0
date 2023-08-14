Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DD1C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 13:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAE110E202;
	Mon, 14 Aug 2023 13:58:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9722610E202
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 13:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IycPYclq7ht43H5RHhNbz4W+qMHJPx3mXdY3Sqb+U+cJMDjTQLHq8/Gf15/+l6CWP4pr7NDdqG6eXTI/ZxJnJR/NLF4poUMwAZv8KbQrmcJELeGYmhOcfbduASvw0RtKyKA9l6zfpgTV+TiNOL3eLZuETQ3tCqfLxrHVDJ48fC6KPZ+ZZ1YRahoeHIyz6TUGr7PjATfye4qeDklwKZ4k/rMFq3ptgCiqW+xISfTwIxOYOerwy1Oqu9DuiqBveUoirYNAzJmM+jmP/JjDUx7eyO0mnRjSqdQ3n2GgsSAAkDd9vCiOqJBZGxxiy6/N+7CSxKxHMupiiaq7Obev5csGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmNh+YtgmwjBq6yBWtCeuYt4PNGFOClyhaIs0brV4ME=;
 b=cUMmsMU9hoBF2oaNquD80Q7wunl3xq7QUKLWzkWS86mAEv16xO86/VYt1tEYjFha+eRdti4m6et5K4iVMjsmXOLtbPftlx9RD9d3P8NZxlKMPE2nSHc6jEQk1jmm6dpVvlYo+px5XVsefvI4xDCBlgZAbsD6zyHN1fEgqKx+OZoY1MfhMMo1Kjkts/2RqGcg7D1i/Aprn08jzIt8wFTyiXVDuFxPm+R9a3ykPHP8ccmckzvsTL8swR4S6XqwvmmrUKsB7JEIxmVX4yR271F90NDB/fXJZxr2hEQR3O1Jh3O09i9F+blvcxLnlrJ7m+hbOzxwd+93Fzc9D8zt5YDxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmNh+YtgmwjBq6yBWtCeuYt4PNGFOClyhaIs0brV4ME=;
 b=Hf7e4lYFm2k4x6PmLeFX2tS2uk4hXFS5g9zP3k0mKG1rjLFTvjKB2kkNV6QVYSfYs37no86qGorPK4KftdDElAYSiKFneuF+nS9hD84lEFsQhade907w0BlcOAlayuGJqRJKbbtmi8yaF+Edr0F2JAmldL+cghb0r55zjPkKS8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 13:58:29 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 13:58:29 +0000
Message-ID: <835d132d-47a9-42ae-e484-9ac51b7f828d@amd.com>
Date: Mon, 14 Aug 2023 09:58:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of
 drm resource
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230811202337.1867891-1-James.Zhu@amd.com>
 <20230811210627.1888328-1-James.Zhu@amd.com>
 <BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com>
 <1f81e70b-2469-6042-8d97-d150e67dc9c7@amd.com>
 <4733316f-a964-8c13-ea56-67e2f5582ab2@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <4733316f-a964-8c13-ea56-67e2f5582ab2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::22) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 70549989-1ab9-495c-6029-08db9cce89bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WW6j4dHQ9c5CKvBM8zzO89qRrdiDWIQskmBox6Y598Ge2rightOraF625lk5vuZIVQ36d+Tt/cZCc82eZUaGX01cG7PZ0x2SI2skLBj/8O7Wy3KwCRST+TXFvNIYGFNe4QuCFENAz+SaovY59ohILNaU7i2CCHQFjoIbKkH0ss8fmQThG64GWnmyFtC6+sW0NUHilTRbEXdCm2tnqlXBiHr3mIfpPndmmzv+G138zpZoPZJE6kPCO9ZhZzloK6z9/qpBpMk+fsaYmUVAJrOaGbS59zhC4zWyZHXjrmahhYHOzV6YUEDamlZL9fraInazDgsE9eWwWMtscij6dVlfm/uWGhjUcOWTneRFV8fdKWtts5M1AnRDFUVDVnJa5lbpETQrWfC3klbkO4B7aKPBDaBtYsx5rit3FxM6tRNFL8jC1Xk1BeDHeF9LlAKg70hTwabLOkHjY9W61wrscqwnuSh+jZ0lIzfbSdl/jjTsS9PoNwVzIkKxbXMopaxdcx3vQEeXDkU26m8uHMnJF0vsr+uc6sebRuVuzsQML2JdNYwrLFsV95jdlRGB2lk57YrLzj4UDqhzMIcIIxl9owspw2g8Cp8vJ8qUXBaKfFYM9P19HXnYjPxtfdowRSC6eFKZCwDembyWKqGB+zlnE+hJXk5++s8h94r4Es8MdaNMzVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(186006)(1800799006)(2906002)(41300700001)(5660300002)(4326008)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(36756003)(83380400001)(6506007)(53546011)(26005)(2616005)(66574015)(31686004)(31696002)(38100700002)(54906003)(478600001)(110136005)(36916002)(6486002)(6512007)(6666004)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dZZExSK2k0K0FtdXVDQlQvNVQ0dHIySmRTV1B2VmQ1RmVTVDhUNjRFczI0?=
 =?utf-8?B?bDdpUXV1elBOcFRxelhvSjZMb0doa2Q0TElrWjBMTjR4QlJMbzRzUWg5Z0pL?=
 =?utf-8?B?K2YrRmJjN0lUc2ZMeUhET0NKOGtxTzVwVCtuTC9raktSRnBidktjdnRHeTB1?=
 =?utf-8?B?MDZpODNnamVRLzcvY2taVUR4V3ROd0xsdTRLMkUrcXdZcEZBYnZYVnFqODkw?=
 =?utf-8?B?RDI1UnVUVUE0VVNmVkdGd2NVS21jMjhyMXBLNENESnA1THBJKzE4ODFFVlhl?=
 =?utf-8?B?Y3d2OGEzL1ZySCtUaUU1Z0UvM2JobEs3UUNzNWVmdXZNYzFaOCt3c1lEbVkv?=
 =?utf-8?B?cEJ0R0ZMREk3Y0pyL1ppV3dkVjYzRFdZVVN0RGg3QUlhZll2ejBvMkZlM0pY?=
 =?utf-8?B?dng5MFNPRzRqZkp2eDI3QjZobzdQQXpXUE0zeWdWRFVDRFFYVDlVOWVoUURK?=
 =?utf-8?B?Vk5PTXJORlp4Q0EvdG1pMmgxTHQ4d2dwcVZUM3d2R0hKZk1LZ01IMGJxREJQ?=
 =?utf-8?B?THVET0drM1kzTjBRUzhnOVh3MytBdzJ0TWpXbTNxUWl4MzBkQVUzaGsxTE1r?=
 =?utf-8?B?bURySEd5dGt3Q0pPbStCNWZBSVMrUWllQ25OTVRmRXpjUlVBTkxhRUVCQ1Av?=
 =?utf-8?B?LzBjNEtmV0xObllmdHZncFF5RFJmNUlGTWk1dHdXc0ZjRzQrRm5YbjAybmRX?=
 =?utf-8?B?SkhnR3doMk1MNmxCYUZyODdSSTRkekErMTJRcDd1L0Fsanhtb2FsVmtMODRP?=
 =?utf-8?B?a0EybTFuT0VkKytCZlNlQ005NnlFSlZFNFpmSzBGWXo0VnJ3SUY1bXBlbEJt?=
 =?utf-8?B?bkNOZHo3VzVVRU94Wm5sZTI4amZ6ay9zZXp5SC8rTTdWMHFBMTcweEUvdnMv?=
 =?utf-8?B?SC9pZHd4eVMzWUtrNlB5WmRuUUM1dU1BVnhqaUVZSGFYRFBqUTB4NDdqeTFN?=
 =?utf-8?B?TDVBcUw2eDdEOGlvMmJKZHViU2l0SE1HdDBCN2NES2c4Y2hOTUxGdG83RlZG?=
 =?utf-8?B?eGNzaUVBbU9DSkMyQjhQTmpHRTh3M0wvYlZRQzFadll6WDB3SDlpVHNsUWRx?=
 =?utf-8?B?L294aUxlblZXSEVMNUtjck9EZmd3MzFXbkIvbGtDYS9Nd25wdHBjSStuQUdB?=
 =?utf-8?B?eXowZXludzl5MVRYR2g5NDZRRmxyVmErM1c0dy9BaloyTGcySzJBbFNNZWhM?=
 =?utf-8?B?MUNRQVhtdzNPZXdzVC85VmdWSzVGdHhlWiszUk12ejY4a0ViNzlUYVlzZjQr?=
 =?utf-8?B?cDdLY2V2U0tBNExNbys4aTZtMUpyOXV5WHl2a2t5VEk5cGNpN2hXY256MURo?=
 =?utf-8?B?Qk9Ec21ROFlsYnFhZFcxT2lWdzlLY2h2S1c1eGpuOEtNVGZSWkgxZlVYQWFu?=
 =?utf-8?B?MDViNXdYZGdpYXZMVFhpRUJ2Um1mbXdMVXVmdmlQWDhnNEVFZThtVmVTc3g0?=
 =?utf-8?B?N2NLSURlN2RjaDRiMWZFSlJ6S3NIRFFiY2wyV0I2VDhmUThWcEQwVGJvQmp1?=
 =?utf-8?B?TXczSDNlVURwZnhJVko5OGlIaUF4dmpQRzRpVStwaFlmUzJwOXdQbHhod2NB?=
 =?utf-8?B?QTFpS0doeURPTkZ5V1o4cWtMakNuODFaZVNkZTRmUnA1M0ZNNUdsbXRNTExi?=
 =?utf-8?B?ZFVPV3BNWWdJUlA4aC9MaWVrYW9RSjdRNVAxWkRNWHRMUzdiZHliMy9ZbzFK?=
 =?utf-8?B?WVA1Z2VpTTlKQVptQ3VSMVNXbmZRSTZTRXFYL2JhK0hCMEd0c0lTYUFkd1d2?=
 =?utf-8?B?UEZmOE1DQVM2cFM5OHI4SWkyV0x3Ky9DSVRMM0J0NFVLNHZFeS80alBZcXRY?=
 =?utf-8?B?dXJYRVNNa3FBWFc5YXlXVUJLY2hpUWN6RWFLZ2ZEOENUWlNqc1ZwNnkvZDNT?=
 =?utf-8?B?bjJyRmFlbzRBSEZlSjJiSnRaZlcrYlJzQXBQQTQvcmpnQmNQRUNLNVpTNTUy?=
 =?utf-8?B?bk9mcEdmT1l2RWUrYXd4bmRVYUpMN1lXdm0rWGJFNDFpWnJ0eVV4TEFSdDUv?=
 =?utf-8?B?dC9KWVRGSlRySjZEdm81bUd4K0xhWHZhOHl2eUk3bnNoYjBxRHlvSlFzZ0xU?=
 =?utf-8?B?eW9WNEt5cm9MYk03MzBhSjZiVDE1bmFieXV5dXFVOUlGSzBXTU5RWHZHQjRm?=
 =?utf-8?Q?eOKaZ59f6F8qqafrgYEwyD5PG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70549989-1ab9-495c-6029-08db9cce89bb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 13:58:29.3504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jw6tz86R3fhX+tk3d9FgW0tadKF0M0jnURsa+PB9nieKaXRcmg9TUFUjoEOdQ3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-12 13:00, Lazar, Lijo wrote:
>
>
> On 8/12/2023 6:14 PM, James Zhu wrote:
>>
>> On 2023-08-11 21:39, Lazar, Lijo wrote:
>>>
>>> [AMD Official Use Only - General]
>>>
>>>
>>> A dynamic partition switch could happen later.  The switch could 
>>> still be successful in terms of hardware,
>> [JZ] Only ignore render node assignment, and remove visibility in 
>> user space, xcp continues to be generated as usual. so switch should 
>> work as usual
>
> Switch is not useful for the user unless the apps can make use of the 
> render nodes. A 'success' from hardware perspective doesn't turn out 
> to be a 'success' for users eventually to make use of the extra 
> partition.
[JZ] Yes, After switch, app can use the render nodes (no more than 64 
nodes in one system), Like 8P MI300X CPX mode,  with no external VGA 
device,all 64 nodes can be used. with one  external VGA device, 63 nodes 
can be used.
>
>>> and hence gives a false feeling of success even if there are no 
>>> render nodes available for any app to make use of the partition.
>> [JZ] from driver prospective, the switch is real success, treat the 
>> last one harvested in user space.. there is warning in kernel log, 
>> and final solution for more than 64 nodes is on-going
>
> The render nodes are allocated during driver load and the message will 
> go unnoticed. We could still allow the switch, but the message should 
> be there during a partition switch like 'only x/y (x out of y nodes) 
> are usable'. The worst case is - only 1 out of N meaning no benefit - 
> and in that case user may switch back to normal mode to make use of 
> full compute power.
>
>>>
>>> Also, a kfd node is not expected to have a valid xcp pointer on 
>>> devices without partition.
>> [JZ] won't affect xcp pointer, only ddev.
>>> This access could break then gpu->xcp->ddev.
>> [JZ] added skip when ddev==NULL
>
> What I meant is xcp in kfd node could be NULL on SOCs like NV series. 
> There should be a check for xcp before accessing ddev -
> https://elixir.bootlin.com/linux/v6.5-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_device.c#L794 
>
[JZ] So it is potential bug before this patch. then we need review 
current code to add all necessary xcp check.
>
> Thanks,
> Lijo
>
>>>
>>> Thanks,
>>> Lijo
>>> ------------------------------------------------------------------------ 
>>>
>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>>> James Zhu <James.Zhu@amd.com>
>>> *Sent:* Saturday, August 12, 2023 2:36:27 AM
>>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *Cc:* Lin, Amber <Amber.Lin@amd.com>; Zhu, James 
>>> <James.Zhu@amd.com>; Kasiviswanathan, Harish 
>>> <Harish.Kasiviswanathan@amd.com>; Koenig, Christian 
>>> <Christian.Koenig@amd.com>
>>> *Subject:* [PATCH v3] drm/amdgpu: skip xcp drm device allocation 
>>> when out of drm resource
>>> Return 0 when drm device alloc failed with -ENOSPC in
>>> order to  allow amdgpu drive loading. But the xcp without
>>> drm device node assigned won't be visiable in user space.
>>> This helps amdgpu driver loading on system which has more
>>> than 64 nodes, the current limitation.
>>>
>>> The proposal to add more drm nodes is discussed in public,
>>> which will support up to 2^20 nodes totally.
>>> kernel drm:
>>> https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/ 
>>>
>>> libdrm:
>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> Acked-by: Christian König <christian.koenig@amd.com>
>>>
>>> -v2: added warning message
>>> -v3: use dev_warn
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
>>>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
>>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> index 9c9cca129498..565a1fa436d4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> @@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct 
>>> amdgpu_device *adev)
>>>
>>>          for (i = 1; i < MAX_XCP; i++) {
>>>                  ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
>>> -               if (ret)
>>> +               if (ret == -ENOSPC) {
>>> +                       dev_warn(adev->dev,
>>> +                       "Skip xcp node #%d when out of drm node 
>>> resource.", i);
>>> +                       return 0;
>>> +               } else if (ret) {
>>>                          return ret;
>>> +               }
>>>
>>>                  /* Redirect all IOCTLs to the primary device */
>>>                  adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
>>> @@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device 
>>> *adev,
>>>                  return 0;
>>>
>>>          for (i = 1; i < MAX_XCP; i++) {
>>> +               if (!adev->xcp_mgr->xcp[i].ddev)
>>> +                       break;
>>> +
>>>                  ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, 
>>> ent->driver_data);
>>>                  if (ret)
>>>                          return ret;
>>> @@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device 
>>> *adev)
>>>                  return;
>>>
>>>          for (i = 1; i < MAX_XCP; i++) {
>>> +               if (!adev->xcp_mgr->xcp[i].ddev)
>>> +                       break;
>>> +
>>>                  p_ddev = adev->xcp_mgr->xcp[i].ddev;
>>>                  drm_dev_unplug(p_ddev);
>>>                  p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index 3b0749390388..310df98ba46a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node 
>>> *gpu)
>>>          int i;
>>>          const char *asic_name = 
>>> amdgpu_asic_name[gpu->adev->asic_type];
>>>
>>> +
>>>          gpu_id = kfd_generate_gpu_id(gpu);
>>> -       pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>>> +       if (!gpu->xcp->ddev) {
>>> +               dev_warn(gpu->adev->dev,
>>> +               "Won't add GPU (ID: 0x%x) to topology since it has 
>>> no drm node assigned.",
>>> +               gpu_id);
>>> +               return 0;
>>> +       } else {
>>> +               pr_debug("Adding new GPU (ID: 0x%x) to topology\n", 
>>> gpu_id);
>>> +       }
>>>
>>>          /* Check to see if this gpu device exists in the 
>>> topology_device_list.
>>>           * If so, assign the gpu to that device,
>>> -- 
>>> 2.34.1
>>>
