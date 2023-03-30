Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97484C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF8010EEB0;
	Thu, 30 Mar 2023 14:52:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0695710EEB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/M6FX/A3qJrkG76cjNFdGXfp6XNacBXDZxvuwb+zj/4zFvkmcAxvTJyYQ0bfFs29pcp3iTRXdgbuK1w7ZRWpXQDgtUQDQ0t56D0hOSrhdbjtFq4CE58kymPrJk1WVbr9arsb9uWohBO03K/UAN0l0P3a5h58YiIbEGnFyWkmmFXJi1Q+dmHtDpj/9Tby/Uiz5eqzKiYYod6ldjG306MTth3KE3SSlja0XxYRnvhy/gr3ZGlAIfVlP95MT66FvwxXc6pRAX4HKxKRbwPjhnChKDExJkSJQucCck+XbUF8ArJZO0TLp2i+9GpDRuAJ2rpouSIw55UyjsMT+4G0FvDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOCnKGU+PoWn+uBeaEZBBa+iIHlVvHE3DaeHRgf0Hgs=;
 b=GmCdMHb6hdM3N6m/Z+uK9Fl5YcV/VIhzeVhay4Bx0IIFQc3Uwd352bVk+8FcNH3KuQuQqr0JNg8Bo+toDjtkJfM/LrKGdJsXuvKtZdiUn4dU1yrKvGNcdpM1etOd09xVoCKhV8LxeMw+qFlRZxHPZi8Urq1eC7HbcQBqGbgk9/5nAlZ/yVclTTI5O5CseZ61evSGHEcFYWOvAGxbdBHsbHIaO28KynPi2ZlMlQfsQqgoFxd3EHt7FcoGdta3u3WOopHfRFJrJKGpyJCFoO9rdI6oJBIVxoTS7iNeDsJM4VtIXIr818G76+3V5ADmYPrF6a+u883bueRD7wK64YRV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOCnKGU+PoWn+uBeaEZBBa+iIHlVvHE3DaeHRgf0Hgs=;
 b=oiy/AlLeS6PEf67CXq370iLLqZYEaoz1s6ouRGcN58k10/ddlyVu9uhkZ6yLPNF/TQb+quIPLhbOUSIafg7Ae7KLFmzbgOscCUdx3dRoJmsKxUjYGtIZjqueOke3iFlae+8/ldyT6cEs90jZnjuU2b2tdR2ECim+El1sQN8b9yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 14:52:36 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:52:36 +0000
Message-ID: <7bdc6447-bc2c-de69-154e-3cd5efcd33d0@amd.com>
Date: Thu, 30 Mar 2023 10:52:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
 <fc73c097-5ea9-2e15-f459-e9bc2bd05c95@amd.com>
 <51e57144-dde5-6bfb-45ad-0dcc79bf0cae@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
In-Reply-To: <51e57144-dde5-6bfb-45ad-0dcc79bf0cae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::33) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dda298-ef96-44c3-4f7e-08db312e667e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWdeN0Qmko1eFg04VMavlNW1qOYNOkJsl0Kly56RsdrJ7BsdItlTzECOzZxV6IMbaVb6yt+yWzVGaTZVG6SqZnmT1HjRV8IZF6Q/UXO8P8uYEBV4BWRtKobkfviNAR3VPGk7jswJWaX4YkSs/cQ/mTX6+cz3NdXcp9gSBVwD+ZLR4kkFEP0E+Kxp6oa1a5HbwsvPAyvbCmGC/5fTnIgrFO41T3amNUOfo1qTRuH6KNSWdKcbKKD1WC4PIweIlllotMZqmN9+cIBGr2fzQSPcMws9NU0qouapC9A2Wom/VH+u8y2lhjyRMaiUzf/CGmI9i3uLhw4eZdCfmIbM0/DcJrsFnCZu3D2s/nHiONBDIogBxMw4I7DFF3PtIKEktgQHdGKe3X4wqTNqd3X7NG0Fj1P+QkkEkkukQ186TYa9VxaYE2i0BHz+Fg2ovGqmVYqtB8FG+H8c9aBdJxTcxD5q8+Yr17W6fFj6asRa+WWYj8jm0mQdGNW2grAISiNREPF6/mGBz8mi+WCpgjd8RYYk/Z9IIPh+DPBASFwQBrRCbsSzzTPWcHkXBAnzCI9FGZJTvDCbNbrpAKEtDlRLdrT2op+FXMTdvvYMN17/MvnkncYULooglMdzaVT/6SKmioOEUrfNfVE+L8X2LS6j8fZwMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(31686004)(2906002)(2616005)(41300700001)(316002)(83380400001)(44832011)(66556008)(6666004)(110136005)(8936002)(36756003)(6486002)(54906003)(8676002)(4326008)(66476007)(478600001)(66946007)(86362001)(31696002)(53546011)(6506007)(6512007)(66574015)(5660300002)(26005)(186003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlpZ01LVHJVTUdIc3hUOG92K2lSQi9ra09BZXJ2K0xXS2RFVUpkeEJhSmxr?=
 =?utf-8?B?OEhhbXc2SWt2QndsSlhhT1ZHZ1ZsckZkbXRrWEtqY0pyT3JTcFBiYk95LzN5?=
 =?utf-8?B?cjVDTzJWMjEwc2ZxRHZ6UnZCQTNSRjNrNmlpTFRQQXQ1bWsyK3ZTN1NVRFN6?=
 =?utf-8?B?cWhXOWJ0WnZXbHUrS3h2eVpZaGVLRHRNUEgwcDFNZjlDMm1qQTFZclJud0Mz?=
 =?utf-8?B?dC96d1BXeENrdFlsNlpvNEtIVEF4L2lQTWNYd2RKd25OQVhEZjhreGFzVWU5?=
 =?utf-8?B?WGwxM3ZaZm5pU0FTV2xqNDlmQXUyd2k4UUIzTk9kYWNHWGxyOHBMQ2s3RFRQ?=
 =?utf-8?B?NDh1THowTnFOWGhXZXlEN0lNVkFwQTA2dHRaOE05N2ZFMGRuWDMvMGU5NTNy?=
 =?utf-8?B?SDNSY3BRQ0FIRUlxOEErdHh0ODQxaTc3bmNlOXlDTzNGTytRck5sWTBCSzNm?=
 =?utf-8?B?MWtDcGxVbVBmaThwWXFoc3hwcXFJWlJZSTZMYUZ4bkVKaElkUXVNMzZRUVRo?=
 =?utf-8?B?MDFFdXlkZExWbllPN1BLVC9IRWEwY0piMTVlRVRETndUazB3YTFMSERtQVNM?=
 =?utf-8?B?LzZENU05akRiSDB1bVprRUxTQVpJR2RacWkrVE1uMXc4UlpwbWdVSW1SUjJU?=
 =?utf-8?B?bGRISG5sd3ZCTjlYcTQwZjlRNXZCSzNlaVV5ZFVYRklENzJtOWpwNjliOTFl?=
 =?utf-8?B?eEQyVlh5TGI1WFRlNEoza0phMWQ0K3ZvVkc0U2c2WG1TYy9YYVRFSG9LdUF4?=
 =?utf-8?B?eU1kVnZLS0FEOEdLWkpmK2tIN2JhSkRzRUhnVXM0R25PMWlOT29zSFVPazZv?=
 =?utf-8?B?K0owK2RJb0UvaWltNkJNdzhJQ0tRRm0wbWh4MXJzcTBzRWd4KytPSXhsano2?=
 =?utf-8?B?Zzd3dCtiM2VrWnNwOEIzQnhIOGhiS3lQbmNPY1R4b1BYLy9xY2NXcmNpMEp2?=
 =?utf-8?B?WlN0M2FqYzIrbXI3allKR2liLzE2OWNEQVRlTk9JRFZiSGg3M05UdlhuR3NL?=
 =?utf-8?B?RTh6T1grKytqeEIvTkpxMVNBcmVVMmhJemNpR2pvenhuWVpCa1lVVjQzSElx?=
 =?utf-8?B?TnN6djZKcnNUVlZMOXNSb3RXVVNPc2NGajBEUmMwOXdYaThsR3hCajlmWDlQ?=
 =?utf-8?B?Uk0vL0ttMTVWZ1g3Nm8xbEI2ZjM1d1Mrdno5ZTVnZHZEbVRidGhaVnZRZ0xU?=
 =?utf-8?B?S3NQUis1TzVsNlUxOExiQ25RVEkvUStScHg3UGNRMGpsWFgvZXVYeWMzQnc0?=
 =?utf-8?B?OEZzb1VMOGFQS0NpOHVFdmtUKytCK3ltVXJNYTU2MGRmMlgzU0VuZ2U3QlYv?=
 =?utf-8?B?R003UUxrUENlUzM0dW9OelQwdnhDak5rSUxZS2pIak1qOTFkNjd5RFV5TTBr?=
 =?utf-8?B?d0d4VGVUUS9iVThJRlhraWd6VXhlbDJpaXJjYVFuV3RUUnp2OHFNRTZhb2JG?=
 =?utf-8?B?aDBFMFFieEJMRVFuZEFRQWxHY00xa0RkMHpNVEZmY3J0NnM3cXVZNzdJbS9n?=
 =?utf-8?B?aDIvVTk4d0VKRlZaUEFwNlJnWnI5aUtzcWsxNysxQXhlTDkwRHBYeHJJVXlm?=
 =?utf-8?B?dkcxWUp3Q3p1TGQ4UTY0bWRxTytnVTh4TjRtTmhMRDQvZkJhY2wwQ2dSUkhP?=
 =?utf-8?B?eE1VaDR0bW11Wld6dzM4MGV1MmJPbzEzY0xwMmx1NU1xd1lBSlhKV3dCSXVJ?=
 =?utf-8?B?NndTT3hKNFhkVnpyZWVsdE85QTNta3d1dXBpQkgxQW1xNjYrVXVMVWEwbUpv?=
 =?utf-8?B?cmxhZTREelBFOVVnYzBHUkFFVHdxZlRQcWxUSWJRdnJoT0J1SzNzNkpwcVBu?=
 =?utf-8?B?bHB2NnB6emovVlRwejFKTWNXK08zRG5kdHc4dDNhbU5QNDByOUhmckxYWjBq?=
 =?utf-8?B?SzRaeGYyUjh2eldIN2xmTHI4L3BxeWVnUDltY2R6dnlad3V0MW5LM0I1d09C?=
 =?utf-8?B?MXJBdVVCVzBsWVE3OHRFaHZWK1huZ28rT1FuUHh0dGdLb1hBeVdCRFNEdVhX?=
 =?utf-8?B?SVp3Rk1zcWNZc3JDQTBjMFV0NEpCL2dOQlE5RHo1NXU2T2h0SG9EK0FxOTVZ?=
 =?utf-8?B?bDVMdnBaVFpGQ3F0OWNna3dsTnFjODNJeXA3RTR6eG1ncVIxTmU4Q1R1bzVj?=
 =?utf-8?Q?Ih+yICMMhan26aKSIhCwxMScJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dda298-ef96-44c3-4f7e-08db312e667e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:52:36.2541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOYA36dnz7oSIQsvaUadxicZF6sCpbb3SDzt6BgszfyH6+sNkKbme2Rikf0OtJBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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

On 2023-03-30 10:49, Christian König wrote:
> Am 30.03.23 um 16:40 schrieb Shashank Sharma:
>>
>> On 30/03/2023 16:24, Luben Tuikov wrote:
>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>
>>>> This patch:
>>>> - creates a doorbell page for graphics driver usages.
>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>    kernel-doorbell-bo's cpu address.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 
>>>> +++++++++++++++----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>   3 files changed, 57 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> index 6581b78fe438..10a9bb10e974 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>       /* doorbell mmio */
>>>>       resource_size_t        base;
>>>>       resource_size_t        size;
>>>> -    u32 __iomem        *ptr;
>>>> +    u32    __iomem        *ptr;
>>>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>>>       u32 num_kernel_doorbells;
>>>> +
>>>> +    /* For kernel doorbell pages */
>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>   };
>>> Here's an example where it could be confusing what the difference is
>>> between "struct amdgpu_doorbell" and "struct amdgpu_doobell_obj".
>>> As the comment to the struct doorbell_obj declarations says
>>> in patch 7,
>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>> +struct amdgpu_doorbell_obj {
>>
>> What is the confusion ? This is the object which is holding doorbell 
>> page. There could be 2 type of
>>
>> doorbell pages, kernel and process, this is a kernel one.
>>
>>> Perhaps we should call it "struct amdgpu_doorbell_bo", since
>>> it does contain amdgpu_bo's, which are doorbell's bos.
>>
>> This is not a buffer object (memory), this is doorbell object, so 
>> calling it bo would be wrong.
> 
> I think what Luben means is that in object orient programming this here 
> would be the class. The object is then the actual instantiation of that.

Yes, absolutely exactly what Christian said.

Regards,
Luben

> 
> But I have some real doubts that this is the right approach in the first 
> place.
> 
> Regards,
> Christian.
> 
>>
>> - Shashank
>>
>>>
>>> Regards,
>>> Luben
>>>
>>>>     /* Reserved doorbells for amdgpu (including multimedia).
>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct 
>>>> amdgpu_device *adev,
>>>>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>                   struct amdgpu_doorbell_obj *db_obj);
>>>>   +/**
>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>> doorbells for graphics
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Creates doorbells for graphics driver
>>>> + *
>>>> + * returns 0 on success, error otherwise.
>>>> + */
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>> *adev);
>>>> +
>>>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct 
>>>> amdgpu_device *adev,
>>>>       return 0;
>>>>   }
>>>>   +/**
>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>> doorbells for graphics
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Creates doorbells for graphics driver
>>>> + *
>>>> + * returns 0 on success, error otherwise.
>>>> + */
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>> *adev)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells = 
>>>> &adev->doorbell.kernel_doorbells;
>>>> +
>>>> +    kernel_doorbells->doorbell_bitmap = 
>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>> +                              GFP_KERNEL);
>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * 
>>>> sizeof(u32);
>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>> +    if (r) {
>>>> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /*
>>>>    * GPU doorbell aperture helpers function.
>>>>    */
>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct 
>>>> amdgpu_device *adev)
>>>>           adev->doorbell.base = 0;
>>>>           adev->doorbell.size = 0;
>>>>           adev->doorbell.num_kernel_doorbells = 0;
>>>> -        adev->doorbell.ptr = NULL;
>>>>           return 0;
>>>>       }
>>>>   @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct 
>>>> amdgpu_device *adev)
>>>>       if (adev->asic_type >= CHIP_VEGA10)
>>>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>> -                     adev->doorbell.num_kernel_doorbells *
>>>> -                     sizeof(u32));
>>>> -    if (adev->doorbell.ptr == NULL)
>>>> -        return -ENOMEM;
>>>> -
>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base, 
>>>> adev->doorbell.size);
>>>>       return 0;
>>>>   }
>>>>   @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct 
>>>> amdgpu_device *adev)
>>>>    */
>>>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>   {
>>>> -    iounmap(adev->doorbell.ptr);
>>>> -    adev->doorbell.ptr = NULL;
>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>> +    amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 203d77a20507..75c6852845c4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>           return r;
>>>>       }
>>>>   +    /* Create a boorbell page for kernel usages */
>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>> +        return r;
>>>> +    }
>>>> +
>>>>       /* Initialize preemptible memory pool */
>>>>       r = amdgpu_preempt_mgr_init(adev);
>>>>       if (r) {
> 

