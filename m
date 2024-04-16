Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3462C04FF6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6880710F077;
	Tue, 16 Apr 2024 12:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hEhfP8UY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A571510F077
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 12:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsjJ9sE7OiQ/181W2eKOMlSt6GRTVRONgDuzCtl50c3qeM81ZI0rJrS4OZTdefcaJ+Lr4a+hH57x1fVaR6pRG4n+/PaYUWz7wAVPsAd6Kdl4c08JKUzN2tKg9PzfUVVTZ8b+6bbWrszP0xemos2z2zVTQhccoqb8I5jzg0t25fFgNnXmIFYaEHXpTVAGUgy9R96J2ZKQ7m/q3wnvhyrkanm+AON99ta4H3eON8b69yLCP51ThhYRdl4mzWdAUiGrj4m5cvg3b8SzD9/hsKtMk+cnaFS2naDcU/WPWNc+hR1MpgInpvZZKuj5qZdVSu97ViB6LZdf9lDEKBoZxrBBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN+AngNp9GfFCm9NeQ02YMDwyAKTjaVXheW03an+uSg=;
 b=bdWC8JrPqOcCfILmXVNg+MsQFuerNjvQek8YMPU4uSR6IXol70anlZ0m0nXX2+TIAK+nrPOc2O6MsmsYHDZgfbqNe/+wbFTM6ObjrSuc0o6flcH+eHMyvWVVqyPbIQyo9Ss81WKExRY4pBNsn/BtnADOD2++GOUl2HGeujdD5f4Cx3JanMiOsfkvVLO2GCLxQ32uNvBL/bz1leFDUhEUkP0gc2s/wstTOtBpVvpv6dApLtPG15ZAmgljNMeRKZ7Pa1R4ViJRkG7aVkMs6A/vMDH1ttDyopgy74RtZ8vCGY+PZNkndl8HbEbTRVpP2J79MNhSQVLfY/A6InUuI7pF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN+AngNp9GfFCm9NeQ02YMDwyAKTjaVXheW03an+uSg=;
 b=hEhfP8UYA9RVjzkpTa8LMIg2TLrTyqKlH353xN1SQA2S2wcCjVrvsjxsBs6m+HzlgpfR+NCN713A0V4Mb3wwnFUPrDSv9pDiOiitDiAUboSecqTg1vhpCSRea54zq9yyMACXM9oA4C5BbTbG4N510T2mtDO4yrRu+K5zbEMGjgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:17:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:17:46 +0000
Message-ID: <7e532341-cf37-42c9-97e3-41d10e7871e5@amd.com>
Date: Tue, 16 Apr 2024 14:17:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear seq64 memory on free
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
 <662576a5-4597-4a3e-bead-4b80852eb19c@gmail.com>
 <5383bac8-c097-4975-8022-181d1d2f0877@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5383bac8-c097-4975-8022-181d1d2f0877@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0295.eurprd07.prod.outlook.com
 (2603:10a6:800:130::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb843b1-c252-4928-81ab-08dc5e0f39b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usEJYPkpMGiFjthTqE2sqFE17bzrKdHDWGjTXp4p8o2QhG2kzNHM7YwwhKQMMAPd1OA6gd4xHz1wurhkL5d2bCzyT5u2EGA22/FwGAGRxIjcynWKScEiyaYLcUW06Ah0nambO30II1c7IJJPFVVeV4TWMf54nt3d3QN6ZzrI2NdxNptETfREXgPwBVL4RHWJPxpLuXBiuD/SMGI/CBAFUPVmea3Xzyn2rPZ+7+rAbr5ZRTRMndkEe8YK+DX0YqvnjgzWAGSng1GlePGqMsnXaiU6hA+HgTktfwVN41kwxArAFpMoC6ohb40HoVZBTOF5xzjgrCxSYp+U1OHPBDIHgUpwbKA8qxCMvrqrPVGoai9Xwzee+Lk1eZby15gi+yBq4EIVcXSa7QUbHEfb3+pw5e2e/8EUhEdvqYQ0nrbFWzSRVNjX+oCbDFlgzHqcTOiDBhLtV7Szd0CJt7zKefvQt5+mchHoy+AJXMKXGn40X7QDEXI42+L/Vs4/99S4XGMy9XHMwryABVpN3qjp5IW+MZOtHoZNl3T2U6NSy9g2uE0NclBnC2J+v8wxtKT2Jmnmy12VXIg227jg/B/m3XdNA9aTUhL+gEQGo+/0YmmFfSjMX/Gen2KKNNP0aadkUnfbso9MXlKzl3o0Yhu2kkl3MEjyaVUCFNCruD6qL5tfKyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRZbzF3ZXlBZUt2Vm5Qa3VBelNDZnc1b2Z3bnV6Z0Z1QTROckZKeVFITitW?=
 =?utf-8?B?SEJMdEMzWWlLSS9rYlRiRUc1bEM5NW1kTHZKenVnN2gyam9aVVg1ZHhGQ3Jj?=
 =?utf-8?B?eWduL3dSb0luMHljZ0x3SGRvbnNJZWFHZTZWMkJ0cTJiaW12dW9obGlJNXE2?=
 =?utf-8?B?MDgwRjdSaGMvUkdJc21ra0FlTHB4MHgybmEvT0dWeExPZkorQXJwTmtONUhC?=
 =?utf-8?B?UXpRVkNQNDlIaHhQQ1kxRExDb0NHZlVSMHlzRk5MRnd4cG9vZFhjd2JGelND?=
 =?utf-8?B?TjlFdWRPY05jaXp3SitlNVNVNWt1dG9yV0RHYmhDUzlPL3ZnZm1aRGp5MFhC?=
 =?utf-8?B?R2lLckw1WEcwbTd3QXE5YW9WQnhEQlJMRXYyNE1hNVpKSFk5K0U1YTFGaUF6?=
 =?utf-8?B?Z3RtMW1WeVJMeFZiejc2RGlIak9WRHp5U2ZVWjg4elJ5dDhld0pxMGM5alJY?=
 =?utf-8?B?Z0JSbmxYUVBUbUlFQWV2SGl6aUdGOEFMZllKbDZSTWVTRUJlOExBSzBXL2VR?=
 =?utf-8?B?YkhKS211cVlsZWFVMDI3YkY1dXFLQnZvU0thYjk3V3kvMGgzU0JaaWRaV3hV?=
 =?utf-8?B?eVFCM3VXZVJzYklRUXAzbDE0amdWS2ZycHIrZDJuK3FqTStJZTJYLy9tN2xt?=
 =?utf-8?B?a3I3V3ZKdW9DWnJtWGc4ckwzNGszbkpoTnlEZVIvMlFqWVVpRERjL0lCallo?=
 =?utf-8?B?a0VlVGpOMEhaNFJsRlluem1IRXVHSXAzOGJIMk1QQmMzbHdjeUI1a0dtOVF6?=
 =?utf-8?B?WWV4ZUhINnFDME9lUmREN25YYUtsRXlwU2lYY0NnZE00SEpTSmFEc1lGVlRk?=
 =?utf-8?B?ZVZDUXZWbjR2eDhFQjNmU2xuZUh2b0JsaEFPNExDSk1mYXNkUlRrOG8vbFJo?=
 =?utf-8?B?YTE5R1d5eEJoZXNzT3lqZ0tEcHQ1OWhNK21rZjVCOW1IVTF3TVg0ME1DQjN6?=
 =?utf-8?B?R1paNE9KL3hVZlVPUXk5bXlFUGFScExLb0xENTNpby9uY1gvK2NVUkNuS3lo?=
 =?utf-8?B?MXJpb1A3YWc1RHByeGc3UzRjZERXRjhzT3gwazA5MHZWeHZsZkFhZmYwT1pq?=
 =?utf-8?B?b2l4cFUyWHJqL0s1SHNNa29YSUdFbjI2ZmdMTnRmU2xva2pFNVZjNUJkeDI3?=
 =?utf-8?B?K1RIaitNUTFYY3M3dXVLdk5XY2N5Y2JyNzVncHFYOHV4K0JOV210L2tGY2Va?=
 =?utf-8?B?WkZ2Z1ZPdDZvbTQrWVR0dHAzTVBGazNxZ0ZsZm0xSno0MVJ4Syt0dlJ2eGxW?=
 =?utf-8?B?YkJ1QnBLWUx6aHlmMURneXlkODB3T1J0WTZVVnl4c1dtM2g1TnNEUFVNZURz?=
 =?utf-8?B?ZTUydkdTeGRXRmFadjBVdHZpUTJnMis2Q3d3dmkzZjU0VUQzbTV3N0dtbHgz?=
 =?utf-8?B?S2tLeVlPbG1hT1RHWjZ2bTIwdDllSzhwd05uQXNDWFRVSndkY1NJY24wd2Qy?=
 =?utf-8?B?MG5pUXVuRER0L3JCTlAvK085VGY4YXF1OVpleVdnU1JoOHhTZ2V3TEM5R3o0?=
 =?utf-8?B?NHpQYkU2ak9TSkxzaEsycmdPSHBhNEhBNFp2ZnhLOFJaMzg2YlE5WGR5Nk5F?=
 =?utf-8?B?N2FuMGJmM085NXZmRFNlQStEeTRPd2xJaVdJcXhBVEJZbnV2c3ZXazVKSFNk?=
 =?utf-8?B?RERnNVpJeWxYZWtwNjROMzVsSmd5NVFCVXBZL0NqV3pMaDZWRlpYR2luVnhH?=
 =?utf-8?B?Y3BDY28wZzdTM2VBUEQwZklKSlhPZ0dUN3hPRlBMNlF4YXgrVWtlM1IxeUhE?=
 =?utf-8?B?c0JBS0FSd1dNUHMvemFZT3gwNUpzYTJjVlBCWTF0cTNNKzlTR3RmanFYak10?=
 =?utf-8?B?MXlNK3EvNjlZd0YyWWYvRVQzdkw5UUkwTkZQR3p3MTFDZUpxeG5peTIzQTE4?=
 =?utf-8?B?OXdNMEpvZlNOZFZQemVDNTlDckhMcmhhR095UmZWdENQcWRqQ2cyTnl4YmlO?=
 =?utf-8?B?UnZOcnM4UWdkcEhxQVc4QTNWWkdkR0JiNFNxQzZqUjFJbmFTWThHaUowcXdL?=
 =?utf-8?B?bkFHSkZ6c2lOSjlROWRKc2JIK2cyWGFra2FOVlZmdGRzdW5pTG1kYnM3R283?=
 =?utf-8?B?SFZwYUk4dFJ2ZzZOS3dSaWZaelJ5RnFDeW1hcmhZb0V1UDBseS9tMFNLSXNk?=
 =?utf-8?Q?paTYtnpXR+hYESMbN3drbbu7T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb843b1-c252-4928-81ab-08dc5e0f39b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:17:46.7657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egvvNsByCqqnHR11xkhtQvs2njhUXJ4+UJHyjh/ce7Ju5CFXOFlJl8F26XzRSNA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

Am 16.04.24 um 14:16 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
> On 4/16/2024 2:35 PM, Christian König wrote:
>> Am 15.04.24 um 20:48 schrieb Arunpravin Paneer Selvam:
>>> We should clear the memory on free. Otherwise,
>>> there is a chance that we will access the previous
>>> application data and this would leads to an abnormal
>>> behaviour in the current application.
>>
>> Mhm, I would strongly expect that we initialize the seq number after 
>> allocation.
>>
>> It could be that we also have situations were the correct start value 
>> is 0xffffffff or something like that instead.
>>
>> Why does this matter?
> when the user queue A's u64 address (fence address) is allocated to 
> the newly created user queue B, we see a problem.
> User queue B calls the signal IOCTL which creates a new fence having 
> the wptr as the seq number, in
> amdgpu_userq_fence_create function we have a check where we are 
> comparing the rptr and wptr value (rptr >= wptr).
> since the rptr value is read from the u64 address which has the user 
> queue A's wptr data, this rptr >= wptr condition
> gets satisfied and we are dropping the reference before the actual 
> command gets processed in the hardware.
> If we clear this u64 value on free, we dont see this problem.

Yeah, but that doesn't belongs into the seq64 handling.

Instead the code which allocates the seq64 during userqueue created 
needs to clear it to 0.

Regards,
Christian.

>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> index 4b9afc4df031..9613992c9804 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> @@ -189,10 +189,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device 
>>> *adev, u64 *va, u64 **cpu_addr)
>>>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>>>   {
>>>       unsigned long bit_pos;
>>> +    u64 *cpu_addr;
>>>         bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
>>> -    if (bit_pos < adev->seq64.num_sem)
>>> +    if (bit_pos < adev->seq64.num_sem) {
>>> +        cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>>> +        memset(cpu_addr, 0, sizeof(u64));
>>>           __clear_bit(bit_pos, adev->seq64.used);
>>> +    }
>>>   }
>>>     /**
>>
>

