Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE573EE4993
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 09:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0E910E2FB;
	Tue, 22 Aug 2023 09:54:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF78F10E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 09:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWgkitxA0Nj51O6H00PAFgwJ4aNI+DiPZ2/zNDXkYoxjejYxvhGNrch7dQ+oQ9w3lLkAFDVn0oZqzIjbMQB9tA8MTRSGorSo2bjoXMr3f72oSfv9h6Bs3b7v15/nyXOVRsdB0W5deXJ0KEXKU4pRXEn6n4egt+zOE/sKZI8v76ynd5tyNMQWe20SJonL/8H6vYfhNbboZe78eXYT0iWDLQvsNLsV/uTG5o1URwolEoOURkP2GYa2osytaZhZipdRcQXl5Z2vuBGKENTPkJCbwEJ3dsiYQigWOihkUuNBmY/naczbEu9xCoiqv6DyCAhcim2cf4IvESALv7QWLlbBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMdd/CjOqLRLTFJf9WtZaPyFcGS5iu4Hde0rdtL+OtE=;
 b=BopyeZ7uwmbqPP3FGobpywnFQIOd2DEnK1C3tuuQZIuBcc9GAHvT6HRacQx3nRYVTovXwYLmJ8DzTfb8E2A80L6/05nTaCtXkvuIoHLtMs/ViRCi4tsc2fhP40zS0juyfgP6ovcDAUt6eSjH/h02FwDq+w+VkZkyZEGr2yjcuBUEKVprObTxn+e0LV9Q2rPdKRuWsfjBFCXne718Ms0PIqcuriuh+mIbg0KG6yeQ42s9MTPCNhabRM5nG4BiFFNj2EnRd/q0aRUu/JZBkemkhoTh9RFE5HvIZgBeONlge3lVFNSGuwCfFIs1Ij2mxE6q7ppmcC5Ywwd/r2SFFHHYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMdd/CjOqLRLTFJf9WtZaPyFcGS5iu4Hde0rdtL+OtE=;
 b=loPpvySZvgc9xAMDcwFPrjR9ly7JfjC17SQuWg/0nsbrjzP96qjbqI/4M3a2JE+nnY1jxbNXdnsvqTLCdtTLYsqBahTJIhCbKuBxYaERzmdTGJmnL/s2FGc7YVN+n6HjxTZed7/VrVEysGJVDBCMI5VwH9z970yYzE9cPfOr9tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 09:53:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 09:53:59 +0000
Message-ID: <a060ac78-2565-4dec-1573-1ee0645603a5@amd.com>
Date: Tue, 22 Aug 2023 11:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Use READ_ONCE() when reading the values in
 'sdma_v4_4_2_ring_get_rptr'
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230804054641.3250542-1-srinivasan.shanmugam@amd.com>
 <8210ebe4-b637-5aaf-c548-b2a4be718f98@amd.com>
 <e438e5fc-6088-3d45-f651-0ffa27af3ba1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <e438e5fc-6088-3d45-f651-0ffa27af3ba1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdcf83a-492d-468e-8661-08dba2f5b4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sH0V4cGElCg95d4kRMi6yI9Gn2+5A03h9NwKB91GI1eXEmD15kIFFujpQd1UZAs1ZJKHfo9hmw5qWYaFios1sagOnGm7txnJbxXa1crRzlAMrtHlfkHuG2R4uKnkQCm12zWkH1A56enAuJLrzFnJwTTakny4zDTCB0gWwCVVJveMGCUFjDyD5uXnq2qPR/VRb4rwDPEA6f+ypH3AtF7Mn3GeKVopa5pc0GSHGYcsTDaExqsWOoJrxA+54xvm6sxFpKUJDX3HZdkj7bZ+ruxtssBcpd8mOv9X0JvAsks+PqmsjA1ayYJNpYRBKN/wLiHe53ERqRcbsJ919sInuIuqQ4fuWqJ+kjC+62M1cLP/Y7JGlIXnqiI6vm+OmCpN5kcldFw+Se7HZvLW/RWKpTCTPOYslQnwRWRI3pU3UN/xbnbgjLy69VBoEs9qAMgBDoPj0/4PZ3b5mwsPy2IZDFfovrRY0xdpp35GD/5U2f3UaqCWInguZnYA6nHVJS5pjbyqDSejzAdNd0ooUH4vTo2Kij+ZcdKuPMwIhW5+UkpVIHWAahpVsFxTksA3vW8ApJi20ovNDOECGlDT2JP/CUZBsYiVfsyLohRTiTygQbLBrobE5ALAPa3GQI7axYWj/08vDrYeCmmuw/UP0ew53R2wjP82lDkOJ1cNmIpbXI14TAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(66574015)(53546011)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(6636002)(54906003)(66556008)(66476007)(110136005)(966005)(478600001)(6666004)(36756003)(41300700001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZqY1puSG1URFNrSStPV1NFL212YXhSbUFoL3ZaTXR2OERHelcwMjlsNStX?=
 =?utf-8?B?YjYyZnVWaENqcmxYcU1HUW9PMVY0WURDL2g3TkhEcUtxYWtnWFBJcHFPcE1t?=
 =?utf-8?B?bGxFWDJjVWtyeUJsazJEWGkrTTg3Zi96dC9wbU5CbjZpODgrVzF2MFQ0RlhS?=
 =?utf-8?B?TmcyejduZFpUMW51NThqc0wvRFNSRStkSUJQZnIyNkJVaERXcTQvUkpKb011?=
 =?utf-8?B?MDBmNDY4ajR0RTRxVnhZTDNYOTAzMHRwS2tRNXZSTzV4bkhSYnRaeUZSRkJv?=
 =?utf-8?B?UEJNZGRjSHpRV2xVOUJxeWhhTFR6V3RpYTFRQ25XYk0zSHQ2WTQxaWw1NlNS?=
 =?utf-8?B?NDNxSFVGV2hGYjZ2TG5qaHQvbWRZMzJ1eUdJN1VId28yZzJDQ0kvK3NDVytl?=
 =?utf-8?B?WGVtQ09rZ2ZpWmF2MHY4RXhzaEptby9uR2c4elNPTExLV1k0OGJKUU44bFdr?=
 =?utf-8?B?WXZnR3laYk9FYkp3ZHlwdkgwMk4yUWZ4RjdmY0FWVjlCSk9JRkdwSG9iKzBD?=
 =?utf-8?B?MklKWjg3anI5Z0lvVm96T25RYzY3dE9Qa1RBcXZLNlZRVkk2NEphaGxJaGtm?=
 =?utf-8?B?VGFEWExaS0hXRjR5S3NycHFZajZkTzZiWDFrc0RkZHdLRXdGNHlVYVpkZWpE?=
 =?utf-8?B?Uk83K3BHdnFFa0ZURjduRmFWZ08zRVQ3UDQ3L2xkMS8xdHVVc1JGdjgxS1hx?=
 =?utf-8?B?T01SejBHOVpnNDZQZ2t2NjY3OVVyNUZ2c0xmMzJjbXgyYng4bHhrQ09yQ2lH?=
 =?utf-8?B?TGVteE11aGZmTlFJSW5xYjRmUXcwcDhTWllFTU10Yll1aEpaZTh3dzFqN00w?=
 =?utf-8?B?NXFNRm1pbjY5dHd1WDJrdStlcWFaTGpMVXBOVHhRSUdtOUxzRnFJUk03U1lF?=
 =?utf-8?B?am1XczNmU2JJbTcvSDFLalB1d0VWZ3hLZ2s5b2RzZjBCTmVyaE92OFF0UDhU?=
 =?utf-8?B?NXJVazgrMGZia3pHNGZSNTR5Nk5tVmVrdnZpSDRPbUlyWkNqNUJxc05sWklp?=
 =?utf-8?B?ZWZva1QrZ25lVUxqUzFMcEVHM3BBeU56c0RFT2VhNkZMNTgwZ2VoVHFWTE5H?=
 =?utf-8?B?dkU2S3FZMGpZZ0ZhMU9nLy9OWGVaejVxcncyQW9EenZxQUhpWEpKa1hpQkNZ?=
 =?utf-8?B?NDZpSVN6emVCZHJzY2t5Z0cvenpXVXhYYnZhUHdFbWxUTUE0ZlUyQ3FzZVh6?=
 =?utf-8?B?S0Q0cHFaY0VhNVZtZU81dFN6b0Mxdmw3TGJrSEswTWROdWtydW1KM2lQZkFm?=
 =?utf-8?B?RTBsbThiL0JkQy9mYTdpd2xMVFNqaDkxdDF6NFRSY2wydGVtWW55N2xTQXBr?=
 =?utf-8?B?SzlhcEZCWHNIQk1PU29sM2pwWDM3cmo1TzZQWEZ2MDBKdERCTjBjUEpvNENz?=
 =?utf-8?B?VFBrb0ZpenJLMHVXSEliZG9FN29CQ2UzbDQ4VkdXOThMbGdjUzlvMXdDNWo2?=
 =?utf-8?B?WHhEUlJ1Y2VMc0NwMnV3aDdtWlh0Z29odEF2Zm9qTXFmWm9mWUg0dyt6U0NQ?=
 =?utf-8?B?ZGhVVUUvREU3cFlqcHdobzE1dm10Y05ua2E3dmJHTDd4Uk5na1F2ejNNSmE4?=
 =?utf-8?B?VS9jMXc2UFVJZzBiaUtaYjl3eVUrWkpXUy9Idjg3UkoyZFhLczlQeFJXNGFL?=
 =?utf-8?B?MmxPbjhCQUhkWVp0TFFTS3dFbU5HUWExeEUyVkhMeUNlQkN2VzJrYzB5TG5Q?=
 =?utf-8?B?SldiSHFLekUwZlhXei93Tkh5S0todExodXYyTDBOU2JzVkJBRldURnZBZ3Fu?=
 =?utf-8?B?R0NVclVoeVVjUExOQi9IY05WeTY1TzZXSW9rNFpoWEdBWTloV3NINS9jRjli?=
 =?utf-8?B?eXZVL2wzeWg3d2tQdnFwQmF2T044Ulg5TnEySDRxWDNvVEt3aW1keGhBWnd2?=
 =?utf-8?B?Wkw3UXB1K2c5Rll2aEZGMnNRTWIveWNCZDduc21LZ2c4V2FsOTlwaXB6Y2Ux?=
 =?utf-8?B?QTA4RHRlMW1oOWx2bzhaclhOekNINHM2cXV1SXpYNDB5QjZnZTI0SlYyZUcr?=
 =?utf-8?B?d0ZiZEM5b1owd2FXSmF1Y3VxRVl3NmpwcW8rTVJlcDVkK1VrQWorTU5NNTN4?=
 =?utf-8?B?VC85Nk0wRWNVaThIOTV0aVg4RHE4cjc4L1NPbS95cVVIVWpuWUpQd1JxaWlN?=
 =?utf-8?Q?2P5YbsL6ToUoNcuYvytgUppfL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdcf83a-492d-468e-8661-08dba2f5b4b9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 09:53:58.7949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9+jjEFuUUEmRB5WOkT8zMLnACEhboMbtAQLsGR4XOTUddB/bpK29qYZ6zhte8P1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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
Cc: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes, that's a very good idea as well. Going to keep that link around if 
anybody asks why we do this.

Christian.

Am 21.08.23 um 22:49 schrieb Felix Kuehling:
> Would it make sense to include a link to a better explanation of the 
> underlying issue? E.g. https://lwn.net/Articles/624126/?
>
> Regards,
>   Felix
>
>
> On 2023-08-21 07:23, Christian König wrote:
>> Am 04.08.23 um 07:46 schrieb Srinivasan Shanmugam:
>>> Instead of declaring pointers use READ_ONCE(), when accessing those
>>> values to make sure that the compiler doesn't voilate any cache
>>> coherences
>>
>> That commit message is a bit confusing and not 100% technically correct.
>>
>> The compiler is not causing any cache coherency issues, but 
>> potentially re-ordering things or reading the value multiple times.
>>
>> Just write something like "Use READ_ONCE() instead of declaring the 
>> pointer volatile.". The background explanation would exceed the 
>> information suitable for a commit message anyway.
>>
>> Apart from that looks good to me,
>> Christian.
>>
>>>
>>> Cc: Guchun Chen <guchun.chen@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
>>> Cc: Le Ma <le.ma@amd.com>
>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index f413898dda37..267c1b7b8dcd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -154,13 +154,13 @@ static int sdma_v4_4_2_init_microcode(struct 
>>> amdgpu_device *adev)
>>>    */
>>>   static uint64_t sdma_v4_4_2_ring_get_rptr(struct amdgpu_ring *ring)
>>>   {
>>> -    u64 *rptr;
>>> +    u64 rptr;
>>>         /* XXX check if swapping is necessary on BE */
>>> -    rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
>>> +    rptr = READ_ONCE(*((u64 *)&ring->adev->wb.wb[ring->rptr_offs]));
>>>   -    DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
>>> -    return ((*rptr) >> 2);
>>> +    DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
>>> +    return rptr >> 2;
>>>   }
>>>     /**
>>

