Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803C9C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 13:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D402BDD7;
	Mon, 18 Jul 2022 13:54:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B172BD55
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 13:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP9m+ClN3fnZz5cuOXNThoE4FnfhY98gGj7/rmeWXPQHL1TcXHRhiNmNald8RfvB2KtKlE14Zomeu82fGVxhq35p8yoro3cZobPucu8TbRPukpZR5VhdoOLO/795MRAUgA4bc5MtT37dEGaK3bDLpquiMVyLZbZuOOaMIKVtJQSiULMPddkLufb62YjoTCm28G8IFPMY+Ma+Zeq1rkmtH7ma43OmamZv3C1jI5r9M33LcOJzipbE2B5e2pz7clOQd0NxIwQDQSWzfT8Xa2vsnKqHpXsJDYZft7U0m3ywLoT1WAw/vvRJD895VLnM9U8dsPD/GVbLkpfIMrbewFv7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMwwdNW6EUZGYy+g79t27AcJTXdMwYBnjlNrE6kd87c=;
 b=f6oPlquFROZiQZwMz3SQAGKcuCQD2A3R9JOqR4Fr87hykqR9kksD3LUU3UpB3OxtQc3B+OjX5r58Whfs+8jT+9jKOd41swI2UrwbandrVyLMZ3QrC3yLi0S8TlObkoCGwjcJrFClYxqSGt2sNOzHNFB1jpaN5rSJjyAOFae2n5f4a2PVBbyIxCwlHVIXW6BkZ0V6fX8XNG5f7K7TRFtq94GHmjv/lJNZH8/ULH16PjeJ66OFHEadvKowykBdJcO4xxBIJ+73uC3oR458lD0xx46CNF4kQakkuZceI/UJbxC2DtGEVazh9WQFbOdPmOxEuA1RisqUZmFhcT56kp8K5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMwwdNW6EUZGYy+g79t27AcJTXdMwYBnjlNrE6kd87c=;
 b=zLFWznyiXY9MmUbS/bDuyon57C41INPeotzXOy0ZEcd9ygym+AtBzmm8OasMYYtI3/NOax0M/vlJtLsJT2F3rsowdzNIAc19k4WU/iDNEMn3TCh1gDnTH5WSDke3MhraE7YAgiP6gV0gz5j3L8vaL4KxR3AFWfSAy1tzSa6tnZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:207::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 13:54:20 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:54:20 +0000
Message-ID: <4f91384a-bef6-b8da-77c1-0bd5f4e7b3c1@amd.com>
Date: Mon, 18 Jul 2022 15:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Content-Language: en-US
To: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220715200410.301438-1-ruijing.dong@amd.com>
 <e2dbaab9-de5a-3180-13a8-cec2c8b0285d@amd.com>
 <7beb798d-73ba-7015-7b3d-441a5daef26f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <7beb798d-73ba-7015-7b3d-441a5daef26f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:530::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4baaa161-8858-4f76-07d0-08da68c50354
X-MS-TrafficTypeDiagnostic: MW4PR12MB6900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lZH5KDx9f3Ld1xyrRhDJsPkat8t1tvE1Yhn13CxmxS3bq5jh+2WRC45folm0V6bkeEY0XYdjTd29zGMfuEZuHXe0XaqV/97TOrN5ft1A18jl44Ug+7geqma00JEC35ppCuEdRNhPyxfr8uQM/bxt7H4PDA+/7/NKz+AFeXbgdAA7fyJ4/hKt44qQfvrs+o/FnIs6NWv5K4PGfQ14HNXR+ughnMc5OWHuVmCiX2//hdTKxGp9A4wY3ZvDa5MVRy2VSqmxF9nV0o9gmsWGbmIAfQxPNp78lQwU6XVAFA8puJQyVXfGkgdwDX1UHZidUAnmh94+/2UM1+1BjEsBhTyX19RC3h6k5Ma45pEF2hBJBZHHIAZo+ye2Xb+kvvrFJQXNsWHD6tv/AMd+ORPycTYe20HWqiXzvy7ds4dw0RuxAXxD/pEliYUizHJlPeduOSQ42ZhF9ifsyOR3smwNAhiPQYm/cUDUK1zqcj5OcRGxbZTn1dsmviB0krWDhLsBBHwJI3jTI3o5d5KuCweaLhxWmTMUC9DeWKCymZpPRu++ctp/KduURZnf49XMKXjNCECcZUxvJL3DH1HWPtu9nRDu8p+kYKlZ/Uswrj2fOQDwpqLnmfnRgWPbrvoWMpXgwL5za/qqSHxyo+sE5q5YCL5+TAiey9gUEEOUiNP+yDwmuIq7WPGszI9vnUxYTI/TPbeRDzwENRLcrivspoEtOr/UijZlW7tiGvLUkt2gtboTFYBFMdaINr7NBVxgRojzgTDagufY3WlogP+RCp2R579+7Qrfif1gTZjIPoQxF7zPks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(5660300002)(41300700001)(31696002)(53546011)(6506007)(478600001)(6512007)(6666004)(316002)(110136005)(6486002)(86362001)(966005)(38100700002)(36756003)(66556008)(66946007)(83380400001)(66574015)(2906002)(8936002)(4326008)(66476007)(186003)(31686004)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enQ4Ym5vVk5QdHdnbXVCVkJPZWExSkpzZFRYcmNYWlZzNU1wVkMxWVpTc1Q5?=
 =?utf-8?B?WXR1WVdmUHdIMExyRy91VjlPZTJDY3dOS2tMUUxMZXlwT2trSUVjdk1SZDRn?=
 =?utf-8?B?d1RvZ1dWSkk4a3ZFK20vU3ZYNk5Yblo2czVCejNvZlhiNGorUW9ERVdFRXlS?=
 =?utf-8?B?OE1yRDNmQ0s5N08zOHFRWnpqbGhaZ2pjbFR2V0hJZ2lCc2wxTEMrbk84d1Zu?=
 =?utf-8?B?SExLckN5QmtqanFEVFBWNnIzQi9VeVJkek1icVM2bkF3QkVRSysvdDBoQzVO?=
 =?utf-8?B?S3JmU0JHUXVVSnNmNUhrb3MyeENBTS9pVkEzSVBXd3NORmVkc0dEMUFaRUx2?=
 =?utf-8?B?dzBpeEprUkVtbXBiY3paNGd6MXJTRGJyVjVYdktid2V2NzVuUm5Dd241YlhE?=
 =?utf-8?B?RmFYM2toK2VER3JWVnBkQnpka3k2SVJ0QS9WN0lVWmtCa2NqSkVLWDVVMms4?=
 =?utf-8?B?bFhDMFIwZmZSazdMVktBcDFsVkpscEcwdEFFb3R2WWVhbWdUVm1zQnRxVUpz?=
 =?utf-8?B?VitDczc5N2lnTzE0aDFhRDV2ekc2REF2Z0dIL3NTL041UkpSdlR6WSs4ZDVy?=
 =?utf-8?B?Y2d0REo1alQ5aGl3WFhrN0hsNEVLKzBlOXg0REwrK0hRZHZvRWJWblhBWlBq?=
 =?utf-8?B?dytRUUlwMkpPdUFwNHlLNEp3V0pVeTcvSUNSNFdXREdvQ1dkbnU5RENvS2Zo?=
 =?utf-8?B?NnNjMGtWQ3U4UGVqa0xzVDNKL2xRT2dpVTYrVERKbGI1dGZ2Vmd6eS9Za3hW?=
 =?utf-8?B?Z3lFOGtIeGRvRis5Q3ZQbDNYZGs1ZEtkVmY1cWt4Q3Z2YkMvOVJlWmdpcGRv?=
 =?utf-8?B?NVBxVGJ6RHVDcWpIa056T2hacnlPK0w1SW5CdGhYYUZKcWJnaWtodlliSGx2?=
 =?utf-8?B?SjBSMVNoa3FYU3V0bjBTSm93VlllclpWNVVtWnlaRHNxYjFhTzViYlU2cmE4?=
 =?utf-8?B?ZGlGVjBwNWtzM085ZVdnVUlraytyZlBjY0EyYTEvbTNaMnpVWCtjbkMzeGV3?=
 =?utf-8?B?Z3diWVJKdXNPTVBDa0IrMUlmejArZkxDRkcyeW9QcVlRMmE4WmQzK2hRZEcv?=
 =?utf-8?B?eFdCN2ZtcjNGNnczY09wWHQ2aE1NdkhwYm4yd1ptMVdoeFJudGhTa1BnSlR5?=
 =?utf-8?B?SXZtNDk1RDRaZXVPNTd1ZFBMOWN6alBoREN5aFZDMjNYWU9kd3JQS2tQbHdp?=
 =?utf-8?B?bTBzZXMyUkZ2eTJPcFJsWTZGbEg3VWIxZVNkblpmdHFBYkloZUg3TFZiMU1Z?=
 =?utf-8?B?cEhTZFUvVXl5elRid1AyQlgycGFtaUJZNm80T0lWMTRwTDFrZVVtTVcvelFF?=
 =?utf-8?B?VlhHQ005MFgyTDYvRWNCNStWblBXbXQ0N240NEE5UnE1Y1dyQ2dEWW9jZm9K?=
 =?utf-8?B?UE54eTJoNnQ3UWhRb0p4cEFoc3JPOWliTU1JK3ZHVzRlYmJKOWp1SjBaQ2wx?=
 =?utf-8?B?d2hoTGh3akNsdk5raXBQeUYrWGtFZGkzYnVHZEg5UGIzVTlJRGFxaGlzczFx?=
 =?utf-8?B?TG5Kd1BIR3N4KzlaSXRTLy83MnZ5Tzh3Z0Y1dGh5MHdiY2RCOXM0aUhvY1kx?=
 =?utf-8?B?aDA3TFN1NHZRS3Q0aVlBSmd1NWh5cDBnMjIvMktWaWFpeEpFWVRSb2JuRkRv?=
 =?utf-8?B?anFZYjVFeG5INm5raXJBbnUxTkJIVFdHR0ttL3RFSkRRRGVPUmh1eFJZOEhl?=
 =?utf-8?B?NGdtdjdmNkhIYldMdFpuUWJFWVlnakRaZWw5UUlsNGtwYjlZZ0I3d1huQ3VU?=
 =?utf-8?B?UklWMnVOV0ZBSWREa0t4bjRpcVp1S1daTHcxZ3kyNmJXY2JZejdISTc1M2Qv?=
 =?utf-8?B?c2tVdmVDV2FTUkJSRnRxT0VHa2NYMlo4cnAyNkJFUTVITnoyTTNNOW9xb0k2?=
 =?utf-8?B?MHhsU0NQVG5samZjejdlVFozR3lzaEZQQURXUHlTT3Z0ci9GTFhxWVhxVlJY?=
 =?utf-8?B?M0VMdjR1Y2NZTXRobnFleURsdGNuTEt2dFc0dkFYNldIY2xibkt4Vmw4dUlm?=
 =?utf-8?B?UWZSUTArZ2JuMmFpRVJKYkYwbVNqaE1ZV2pVUXhhMXh6MW02N01MV3EycEE0?=
 =?utf-8?B?bzIxUkJGblFTa2NxRGxMYjVDUENkb2p6N0VlQ0svM3g0dGdHOFk5Q2V3YjRy?=
 =?utf-8?B?czdBOFZRSzdvR0M0bjNTQzQrbHNQLzNEdWcxTGJ6S2hMN21xY3Bkb1JEU0Z0?=
 =?utf-8?Q?wLStxr+iuF8XW3u761HElKIkkHDWh4dR6DOzAsNmLxjp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baaa161-8858-4f76-07d0-08da68c50354
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:54:20.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZOsNavMgWsD/Mikxkj2XPZWXQOyn8Y1feb/XdKyFBbDqWidCJdMEKmzpf7KPZEt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.07.22 um 15:48 schrieb Leo Liu:
>
> On 2022-07-18 02:57, Christian König wrote:
>> Am 15.07.22 um 22:04 schrieb Ruijing Dong:
>>>  From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
>>> both encoding and decoding jobs, it re-uses the same
>>> queue number of AMDGPU_HW_IP_VCN_ENC.
>>>
>>> link: 
>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits
>>>
>>> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
>>> ---
>>>   include/uapi/drm/amdgpu_drm.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>> b/include/uapi/drm/amdgpu_drm.h
>>> index 18d3246d636e..e268cd3cdb12 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -560,6 +560,12 @@ struct drm_amdgpu_gem_va {
>>>   #define AMDGPU_HW_IP_UVD_ENC      5
>>>   #define AMDGPU_HW_IP_VCN_DEC      6
>>>   #define AMDGPU_HW_IP_VCN_ENC      7
>>> +/**
>>
>> Please don't use "/**" here, that is badly formated for a kerneldoc 
>> comment.
>>
>>> + * From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
>>> + * both encoding and decoding jobs, it re-uses the same
>>> + * queue number of AMDGPU_HW_IP_VCN_ENC.
>>> + */
>>> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
>>
>> I'm still in doubt that adding another define with the same value as 
>> AMDGPU_HW_IP_VCN_ENC is a good idea.
>
> Hi Christian,
>
> From VCN4, there is no VCN dec and enc ring type any more, the 
> decode/encode will go through the unified queue, so using 
> AMDGPU_HW_IP_VCN_ENC is no longer accurate . Keeping 
> AMDGPU_HW_IP_VCN_ENC type is for legacy HW, and the new 
> AMDGPU_HW_IP_VCN_UNIFIED just happen to use the same HW ring as legacy 
> encode ring, so reuse the value, and that is the whole idea.

Yeah, I understand your reasoning I just don't see it this way.

What happened is that the encode ring was extended with decode 
functionality. In other words we still use the same format for encoding, 
we just added another one for decoding as well.

Renaming the enum and adding AMDGPU_HW_IP_VCN_UNIFIED suggests that this 
is something completely new, which is not the case here. The encoding 
commands stay the same, don't they?

So to sum it up my suggestion is to stick with AMDGPU_HW_IP_VCN_ENC and 
just document on the definition that this is used for both encode as 
well as decode starting with VCN4.

Regards,
Christian.

>
> Thanks,
>
> Leo
>
>
>>
>>
>> Instead we should just add the comment to AMDGPU_HW_IP_VCN_ENC.
>>
>> Regards,
>> Christian.
>>
>>>   #define AMDGPU_HW_IP_VCN_JPEG     8
>>>   #define AMDGPU_HW_IP_NUM          9
>>

