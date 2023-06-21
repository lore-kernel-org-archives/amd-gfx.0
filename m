Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1518EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 09:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536C410E00C;
	Wed, 21 Jun 2023 09:14:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5498F10E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 09:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyIkJtsTmFZcovNVcYyGqXL5xBsXLxeFS4pnU6YLcpWSQUk45N0yDw3WzKga5b1O48OwFp65Mw7G3Os4MdXTa9rwLuchrCBFi5WM8qzuEw4DDLW4W4TTlxtVnBfj4tmiAZrjemQFF08uLKITOh2kfP4C7aOFY7bRlEnoPsPp9ufYm/erPV6nagB4+Yp5MegqBdGxHfLlnfzB8Ylevpzi+NoS6f3kMof0Lxgds6BtWXtHARsODanmAuZhXkHbIinyHXNaYLrjdy8hg+Ig40ihctKnzc9OdQMWb+B/r/ALrsP3E29hKsJMNferXyuYS4YTsnvfiE2YdZFIQxzB4rbr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl8iCx8FDXr87hs/Z6JyZjEnv9NSDyown2BLP20Ss/s=;
 b=Ule72w4PYxi5vqPAinZbC6olyOaM1GZtf2q6/I5TEDpIfHOXWOQ9ZpVqyRP74RQXXviOCZ1/+ls3wAfhCt7rq7DuYPEO5mCsgG8KcB5fSiZpUS4zCZWNExth4eFwVDkRD7yn+TzE7R0rUK1bOBBeNHjXzAH8SGOWGnAyXwL/OL+xSrHlY+1DHJMc41wcd/GLfrROUfHXaKnrhAhveV899y5vyJJ1vVP3gCQUrrQT/s1Qp/z8t2phb08N9ANTBn1hXsxBJuzp600/cXPDtqn7peK/b915AijDdowLAStIf8q+JLBzo6EeNPvLJvWnbmYe02hQQqij0aFkZyDu1VI37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl8iCx8FDXr87hs/Z6JyZjEnv9NSDyown2BLP20Ss/s=;
 b=SF+0auL0D4/fFaPfcwUCbxlxg8brmUUny4fG66eDZli7szNpQwz8xh0zHJEVq9AUMlBuS/TtKMBIf2tIyMiWWck2zC9wVl4JbXsgkZc837cSgs8ix+GnqbHRoGUw4/09HeHIv2R00uHd2Y7noB9KuHupII3/aTyfyunnyX0Mlbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 09:13:56 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 09:13:56 +0000
Message-ID: <4016ac35-e33b-64de-fb15-826240044d12@amd.com>
Date: Wed, 21 Jun 2023 11:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 06/12] drm/amdgpu: create kernel doorbell pages
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-7-shashank.sharma@amd.com>
 <a794a151-dec5-436e-fd92-c9e49b3c744e@amd.com>
 <37bae5be-b806-31c6-28f2-28c31b414dc6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <37bae5be-b806-31c6-28f2-28c31b414dc6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 963a9f0a-b831-4287-2798-08db7237d74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Weaqh/UZgQeNSSVobZ/+nWj44bxdGLs1tJNUnqOVSlUCUrdg8fSOoI0Ov5+TO8Alkxxmg96PKPpD40PVO0eea6ftsJHfiiGqzSSWvAkzG1hoNfVR1gqucfRuJK650xfRkz1J8nVJDWC1YXCOboAnnpF8E32QdFvYVWWsvVuyuvgpDdpno59xdqBU6lTSRyFyJVnpI9HAn0yyeZhcoF9PeT8wCq2ydPIaJagelQvoz9ysATQRxbwGu3AVcA7LuzS6/PJbQAupy31vlQ68ArevVFNoJCkx1KA0UzSF8phna7KOgkbih1s/EUwMFQaU+mBVGTqm1nDTr9GNew/p9oRauXiZ2lPS47TA3mMX6Eh1gImTe4v2rI6oOYqBIBrRUe2JTa3Emxf3ddTmZr04+K14fhgfXyXMPDCfLQ7MSLIvEgy+gX+p429tHspCRTVt1bYzuLOajToOLDGwIY0wRDU2ZmjGyy8n+LmFuhl9b2xQabzlYiWFZvcw9riqCcYbDkSXJvc18Sv7tl+USNz2N6cKZDtQkrBrgm4wzLEMC9ifHQJC9GiWJk394PRSlo7jHE3BiOe2nTd+x0DsDeUO6Nh57kKPVtMoMLsI2cCC/1AK9hdzcUc/sfvtrFXNyvbNEC/ODzcX9gX2DXoCZsyhzwdSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(478600001)(5660300002)(66476007)(2906002)(4326008)(66556008)(31686004)(316002)(41300700001)(66946007)(53546011)(6666004)(6486002)(6506007)(8676002)(8936002)(6512007)(186003)(83380400001)(2616005)(66574015)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTloZHV3dkgxSXpNdkc0TTJWbTBUWHJ2Q1VONzFPZ2ZxSG0zV0FFZXZGb3Fr?=
 =?utf-8?B?TWtqMDVzMFB3T3VCemRwenRQejVLN3h4aXJ0K3pScGVBZGsxN3JaN3NwV3I1?=
 =?utf-8?B?QytaWkFmMTQ3WjJkSFpoTnVNQ2JGN2xQZ1hnaCt5YkdYeVRwRnk5b1YydHlS?=
 =?utf-8?B?Tit4Q3o1TkFvOE1pb29ZMjB5UTdXcmQzaXJaZWU5NXVVQ1E0KzdOQmtSalZj?=
 =?utf-8?B?TG02K2R0cEQ2c3FuUFNHelhjaDZlUW45dGlPTmFQWlZCdDVkY1NUZllvU2g3?=
 =?utf-8?B?ZEQ1S1JwWXY3SHNCdFFQYXJVWDlWNk11MHZDbndUWWtWeFRwTERIeVBHRHlT?=
 =?utf-8?B?OFdwWjlzNEJjVmZINXJGTkFXOUozenVkYkhOeHI3ZVdyU3M4bm9WMzhBTEdj?=
 =?utf-8?B?WmNpWnBMNFhpdmhjdTByUjQ1TFFyejJOcmJHaThPRXplVVBZZjlWY2dFZFMv?=
 =?utf-8?B?dkIwbkpIM3lEdjlhdGdpSUtuVGVYSlYvcGNJSkMyVGdzOEpNZnQ0WEJzYnBW?=
 =?utf-8?B?aEVjNUdRSzgxb0ZSM1lHWVVvTE93R2Z4TGpVR29VbXVsc3JWK2NFNzlXTWcy?=
 =?utf-8?B?OVFpV2c5MnNMWHhQZE4yZDZXZlMwczBCM1BGSFlaK1FYMDU1VTZha2doU1R3?=
 =?utf-8?B?bVNyUnhwKzA5aTJkMWhnL2JaZVZVNVNRR0V0aEl3TGtROHRRSjVTZ1czbmkx?=
 =?utf-8?B?V3NpVWVsS3NrVThLa2dKbExtNWRiOHY4YlA0MmV5bUR5eGdsMjNySlllb252?=
 =?utf-8?B?YkhQZGw5eFZ1QzE4V3JwRVZCN2w1TjI4ZXpzR0s4eGVTbi9OeWlabEFGTEFB?=
 =?utf-8?B?bEl0c3h1UUxJb1lLWVNmdVJRTUxXQko5STVRZlZtUG9KT2tFa3RXYjVxRFdS?=
 =?utf-8?B?TXN0eE4zM2syRytlNGc2MWNqYU40elRWOVBvdHhCRnhlcE1qUmFWeEJVeTZa?=
 =?utf-8?B?Nm1wZVRkYUVxSEUrMVFYc3M0bENpYXpMZjhtNTdDTU96a2lCbXI5UWliTkpN?=
 =?utf-8?B?WXdkV0FuQnNNbitNUkJ4YTVXS2pJOUV2MTFiS2dla3UybnN5dVE3RlFtakph?=
 =?utf-8?B?N2I4eGxRa051WWNoY0tjZCtnYzZiUlR4RmZqakJ2bmc2NWFLNnVGbXR3WjZk?=
 =?utf-8?B?RDhBSXNQcXo2UTdxRDZUQ3NQRmxsL3c5dmpqWU40b0hld0hNZlFMYm42cWhj?=
 =?utf-8?B?VDdyRE1zdE1qV2Z6aW9WMkR1TWxJNy8rK29NNE1tRUVjeTY5cUx5Q3o4QkV4?=
 =?utf-8?B?N1RoVWVyTHQvUjg2T1QzZWZKazh1aER4Ynh5cDhwRjBJNExIK1IvcTFxRnZ4?=
 =?utf-8?B?Mk9STXc1OEhZMkFpUForMGNhWVBsR0xNclN6SDhvbTRwVUNFS0NSeElOU0xZ?=
 =?utf-8?B?R3VMSldRN2dJRjJUWTRwS1g1dkxKWUgwc0NMeU5BQ1JIRE5JQ3EwYm81Y2tn?=
 =?utf-8?B?MXRXWWd1L0RxT1FmSXAwQUVTOXVHYlZvTm1GLzFYb0JWaWpLd09PNnJBTHpi?=
 =?utf-8?B?R29RSERicmo0K2taeDROeUtiQkVpalV3Mk1ubk0xZmZCY1FvWjdycndPalFo?=
 =?utf-8?B?Njg1TGVqY3pZcENpbW1NMlZoTWdHUHlrUmdyREpiS0ZLVFJwNEhCTklzODlF?=
 =?utf-8?B?Qko2WjNJMEhCaXVpL0hrL3JDanM3cDRSL05oWDRTcFlOb2VTUGdOakJQYTQ0?=
 =?utf-8?B?dXd2UHZYSEpKdGlRSTdUZFZ1VUcrcng1VUcrVUF5WTVkNDNpSWcyVlVVN1Vi?=
 =?utf-8?B?NTNrWXcwQ2N4Qm9SUG1tbCtDZXVDTWV2OTE4VHFHdGE0ZWJSN0dGN2lWaVIw?=
 =?utf-8?B?dkNJZ3EzYnNFQzEyMlhRSTY3cEovUTZIeE90ZnlZNEltMTFrMnRVd3EwT1dM?=
 =?utf-8?B?eFF4dm4vQ29rVXRxamdxRDQ5UDU3ekNNcDJQVzBGV1RxSjhTU2xId2NBWWxH?=
 =?utf-8?B?R2M0bEliY0IzazB5bmdHWFNORjA4b05FcXQ0N251cEFIaFdQNVhiUkg4NjVs?=
 =?utf-8?B?MHdoR0I1VDhnckpnd2V5Wk85aGpUTy9NdFBGV0VhQ0owNHV5a1ZRK3FqZmpQ?=
 =?utf-8?B?a1JxVFd3NGFtRy9yaEFpNExrVDFPME5rM0doRzUxN3ZFZW41NkNNWnBGeUNX?=
 =?utf-8?B?YnJYVHpCUnBCdE91OHY4YXZaYisxbDg2c2QwbExkdm5YS2VoT094VXZ4NnRj?=
 =?utf-8?Q?zl5i7fL4fCgc7MFUJsvMHcTdb09GasLUGjv1u3K7tHrR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963a9f0a-b831-4287-2798-08db7237d74f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 09:13:56.5334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lugd3rHWz0gvcxlkzMJBe/SkDANi/PA858FabAyw1PKCLCMuc4ADwJaf0T4GTQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 21.06.23 um 11:10 schrieb Shashank Sharma:
> Hey Christian,
>
> On 21/06/2023 10:32, Christian König wrote:
>> Am 20.06.23 um 19:16 schrieb Shashank Sharma:
>>> This patch:
>>> - creates a doorbell page for graphics driver usages.
>>> - adds a few new varlables in adev->doorbell structure to
>>>    keep track of kernel's doorbell-bo.
>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>    kernel-doorbell-bo's cpu address.
>>>
>>> V2: - Create doorbell BO directly, no wrappe functions (Alex)
>>>      - no additional doorbell structure (Alex, Christian)
>>>      - Use doorbell_cpu_ptr, remove ioremap (Christian, Alex)
>>>      - Allocate one extra page of doorbells for MES (Alex)
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  8 ++-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 56 
>>> ++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>   4 files changed, 60 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> index 783e2b8b086c..002899edb9d7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> @@ -31,10 +31,15 @@ struct amdgpu_doorbell {
>>>       /* doorbell mmio */
>>>       resource_size_t        base;
>>>       resource_size_t        size;
>>> -    u32 __iomem        *ptr;
>>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>>       u32 num_kernel_doorbells;
>>> +
>>> +    /* Kernel doorbells */
>>> +    struct amdgpu_bo *kernel_doorbells;
>>> +
>>> +    /* For CPU access of doorbells */
>>> +    uint32_t *cpu_addr;
>>>   };
>>>     /* Reserved doorbells for amdgpu (including multimedia).
>>> @@ -311,6 +316,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>>> *adev, u32 index, u64 v);
>>>    */
>>>   int amdgpu_doorbell_init(struct amdgpu_device *adev);
>>>   void amdgpu_doorbell_fini(struct amdgpu_device *adev);
>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>> *adev);
>>>     #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> index eb113e38f5e9..118f4bed32fd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> @@ -39,7 +39,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device 
>>> *adev, u32 index)
>>>           return 0;
>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>> -        return readl(adev->doorbell.ptr + index);
>>> +        return readl(adev->doorbell.cpu_addr + index);
>>>         DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>       return 0;
>>> @@ -61,7 +61,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>>> *adev, u32 index, u32 v)
>>>           return;
>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>> -        writel(v, adev->doorbell.ptr + index);
>>> +        writel(v, adev->doorbell.cpu_addr + index);
>>>       else
>>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>   }
>>> @@ -81,7 +81,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device 
>>> *adev, u32 index)
>>>           return 0;
>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>> -        return atomic64_read((atomic64_t *)(adev->doorbell.ptr + 
>>> index));
>>> +        return atomic64_read((atomic64_t *)(adev->doorbell.cpu_addr 
>>> + index));
>>>         DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>       return 0;
>>> @@ -103,11 +103,47 @@ void amdgpu_mm_wdoorbell64(struct 
>>> amdgpu_device *adev, u32 index, u64 v)
>>>           return;
>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>> -        atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>> +        atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + 
>>> index), v);
>>>       else
>>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>   }
>>>   +/**
>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>> doorbells for graphics
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Creates doorbells for graphics driver usages.
>>> + * returns 0 on success, error otherwise.
>>> + */
>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>> *adev)
>>> +{
>>> +    int r;
>>> +    int size;
>>> +
>>> +    /* Reserve first num_kernel_doorbells (page-aligned) for kernel 
>>> ops */
>>> +    size = ALIGN(adev->doorbell.num_kernel_doorbells * sizeof(u32), 
>>> PAGE_SIZE);
>>> +
>>> +    /* Allocate an extra page for MES kernel usages (ring test) */
>>> +    adev->mes.db_start_dw_offset = size / sizeof(u32);
>>> +    size += PAGE_SIZE;
>>
>> This is initialized but not used, so I suspect it will temporary 
>> break the MES test? Or is the MES just implicitly using the correct 
>> offset somehow?
>
> I am not sure if I understand this comment properly, can you please 
> elaborate ?
>
> If you are talking about 'size', its just used below while creating 
> the doorbell BO.
>
> If you mean adev->mes.db_start_dw_offset, its being used in 
> amdgpu_mes_kernel_doorbell_get/free and amdgpu_mes_doorbell_init

I was talking about adev->mes.db_start_dw_offset. But using this in 
amdgpu_mes_kernel_doorbell_get/free comes in a later patch, doesn't it? 
If yes, doesn't that break the MES test?

Christian.

>
> So both of the variables are being used.
>
> - Shashank
>
>>
>> Apart from that it looks good to me,
>> Christian.
>>
>>> +
>>> +    r = amdgpu_bo_create_kernel(adev,
>>> +                    size,
>>> +                    PAGE_SIZE,
>>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>>> +                    &adev->doorbell.kernel_doorbells,
>>> +                    NULL,
>>> +                    (void **)&adev->doorbell.cpu_addr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * GPU doorbell aperture helpers function.
>>>    */
>>> @@ -127,7 +163,6 @@ int amdgpu_doorbell_init(struct amdgpu_device 
>>> *adev)
>>>           adev->doorbell.base = 0;
>>>           adev->doorbell.size = 0;
>>>           adev->doorbell.num_kernel_doorbells = 0;
>>> -        adev->doorbell.ptr = NULL;
>>>           return 0;
>>>       }
>>>   @@ -156,12 +191,6 @@ int amdgpu_doorbell_init(struct amdgpu_device 
>>> *adev)
>>>       if (adev->asic_type >= CHIP_VEGA10)
>>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>> -                     adev->doorbell.num_kernel_doorbells *
>>> -                     sizeof(u32));
>>> -    if (adev->doorbell.ptr == NULL)
>>> -        return -ENOMEM;
>>> -
>>>       return 0;
>>>   }
>>>   @@ -174,6 +203,7 @@ int amdgpu_doorbell_init(struct amdgpu_device 
>>> *adev)
>>>    */
>>>   void amdgpu_doorbell_fini(struct amdgpu_device *adev)
>>>   {
>>> -    iounmap(adev->doorbell.ptr);
>>> -    adev->doorbell.ptr = NULL;
>>> + amdgpu_bo_free_kernel(&adev->doorbell.kernel_doorbells,
>>> +                  NULL,
>>> +                  (void **)&adev->doorbell.cpu_addr);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> index 547ec35691fa..a403418d5eac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> @@ -128,6 +128,9 @@ struct amdgpu_mes {
>>>       int                             (*kiq_hw_init)(struct 
>>> amdgpu_device *adev);
>>>       int                             (*kiq_hw_fini)(struct 
>>> amdgpu_device *adev);
>>>   +    /* MES doorbells */
>>> +    uint32_t            db_start_dw_offset;
>>> +
>>>       /* ip specific functions */
>>>       const struct amdgpu_mes_funcs   *funcs;
>>>   };
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 6d1587bbda52..c48e97646541 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1854,6 +1854,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>           return r;
>>>       }
>>>   +    /* Create a boorbell page for kernel usages */
>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to initialize kernel doorbells.\n");
>>> +        return r;
>>> +    }
>>> +
>>>       /* Initialize preemptible memory pool */
>>>       r = amdgpu_preempt_mgr_init(adev);
>>>       if (r) {
>>

