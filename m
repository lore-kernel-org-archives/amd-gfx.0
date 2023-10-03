Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C12E7AD76
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 16:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA90D10E2E6;
	Tue,  3 Oct 2023 16:31:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4DC10E2E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 16:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EROB+iUCtcuQMT9gLUeMzeIquctauYecOgr6EHQRd7B9AaW2iINxQ591pBc2pA9qV0RHmtWLzzBBO9VpydNcI8vzH4uBbGPYTbd8XyJiLY3JqFJQNG9Z/it1dYSPMTMFpIjzyzrVezPHTMIVGrErN2ZWI32KHf8/ZvyCUY54QxR/N20nao1KTG3sNZBmp9xC6YQ2y1MKwk1RIpsV+pbSPIcE7oiOpRPN99ZFmy8E5Fmaj7brxppSWIhgv4XFsnmeYv2D4FPRiICLrUL+k+J38/+0uIR1AqB94eHf8sy07DdVtTN7oQQE52v/ENq2iv/yOwPlzHKP/xlPnriAtmm1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s80gaBr1GqvvhIYlmNMFT+rwyH8JaylSYlvTLDBtlck=;
 b=BPrHLDATtBc6eTe8w3GgUwB99MpbP5SI+6PmQ9mINrYbmn6Wynlv3vjqODg9GUMv7Ymmi6kOxq3HAKf/Ev7CWlU4FIMNRxsByrhWVmEHI0lxcq6sFwQ81B2fQlaTp7KleFjPifFRNuhzV/nKbJAeOu15PuDIRNq/ozNoK1lD/9kgrpvxR7LdkwuOPod+XtDqY/AY5qWlP+SxytA7lDTcW6n99Xk7iMKHY1Vsh6GS77Bt06MU9cgFWUYCa3LZIoy6VNAEaAlgkh5rkd/WVtwUBB4X4/Rp2I0m4Y3RaNbgHcPVrrm0WTnNhSBbIKCpO6f3ndBo2JjJXATy8gK//hiM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s80gaBr1GqvvhIYlmNMFT+rwyH8JaylSYlvTLDBtlck=;
 b=ZES+NxIrSYZjdb0itjIfipCH9pcx8oUMIlANFBZLSb3/nDV8lyD3Bu+jyjEEXU4Ru/tQ7rAM5sRof2H3SOlbnSLlw4xYEC8z/dxx/JkboNqD8kYsIcMqqzKLQ52gmSqhYLwYA8qmEqPsVDKCnJUl1VRmUD5celVx9YlHuf6JMUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 3 Oct
 2023 16:31:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 16:31:45 +0000
Message-ID: <72a7fcb1-1ae6-40ee-823b-299bd5eb98dc@amd.com>
Date: Tue, 3 Oct 2023 11:31:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amd: Move evict resources suspend step to
 prepare()
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231002224449.95565-1-mario.limonciello@amd.com>
 <20231002224449.95565-3-mario.limonciello@amd.com>
 <BL1PR12MB51448F08D484175DE8D4C8BDF7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BL1PR12MB51448F08D484175DE8D4C8BDF7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa7b746-e479-4653-5aad-08dbc42e3b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrtWLxbPFCDKFKl3m1zRq5thKx5/OCKqtpRZ362KqzhBLeKd9g48USdttsguoV4D4RIeTLgN3tU35I9qS/Z7BdCblkjscQ+JxokXVpan/ip2iBm93u7apu3fK9/9HZvRxYoHj/NDFdMG0NgwqYlh+b4zMZgwf8RWVUfvdeMPzYSRTE+y1lrXh4FrLd2Y7r7CTRALsGa23PiUcOIHg1F3tYUQJieUrVyIHW0sMtodwdWkNq8Gsy3POtRU8UVwyLlBABY782gQGQlvOhAfMe4LbGcCtBAR9+735Qh8rFG9U13dNRrYcIRHAiKg+4kLlVPf/TaNbd83yG8tLWdABcpVq//gpdiIC08qQMCV6hYM+WSlvD+lFGecI29/x64mwZuo0ZfTYYi3PPw6dketSfMa36MHjIQmlf1PtYz3Qw1i4XyMeIRgTygwabgqFWh2Iz38GGhu2XmG/oC8F/RUcMdaAeRgvDIKq2riKlvQc5cWfUcbm04PeaeTBQAY4DYftLLoahAOi56uNlXksvA2kmQnTxe2dX2QN5uJZ3Fu0uWM5/n/nAL8HvQt0AOC3lG40Pv3PaIJzajPCyJLP5PXQePFmI/h8v4njVMuZXw2ej2Wft5Fhg6VaOOOH7ZFg8Ggnj/K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(15650500001)(110136005)(31686004)(53546011)(6486002)(966005)(2616005)(478600001)(31696002)(38100700002)(8676002)(86362001)(66556008)(66476007)(41300700001)(83380400001)(44832011)(6512007)(8936002)(2906002)(26005)(36756003)(6506007)(5660300002)(4326008)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFQ1bzRZV3JKMXFOZkd1R2dDbzZ6L0Q2d21XV3I5SUpwY1hycEtNMmxQMGVW?=
 =?utf-8?B?NWlOZWFraEJOTTBCWmVLenNjWEU2RFUzT1llRi96UjhoaVlLZGQzQlZObE1O?=
 =?utf-8?B?bXdWaVUraXBHWEZJSWt4dnFKZ0V4TnVRNkU3aTVUNnJodjMzS0c5dTRYek5t?=
 =?utf-8?B?N1k4TnZ4Umx5Yk5xSVJPVkJNVFFyQzJwaDRPTVc3ZGFuMmhDbnlZVklPUUVB?=
 =?utf-8?B?TXZDWFRISDBDSUxnNk1yMlh0Sk4xd0N2czQ1dVN1UEllNXBrYWZtNURYV0ow?=
 =?utf-8?B?RGdBMktIRXZGSkhRSzlwYmR0NGxwL2wrQkRJYjYzeDF6YWwwa1czaVZZOThR?=
 =?utf-8?B?dmNWeFJZMW9qL0U3NEtlSzF4Z0todmtKTGFNeU55dnc4R2RsYzNQcFlNQ1hh?=
 =?utf-8?B?bjhheTJwTHNUYkcvRFRQdWdPNFVzSmxGNkFIOTJlM2Q0Z3NyZnUvSEdoTHlJ?=
 =?utf-8?B?NTljNWg3Yzc5TlMrQmJHTkVkd2tNaklvSEpsNER0SWtJOVdDRGxQTU02ajY3?=
 =?utf-8?B?SXpKeWNXZ2JPL1FJV000VXlxVFdURGRsMFNTcWpMUk1lT3p5aG81L0FveGR3?=
 =?utf-8?B?QzZFaVBZdVR0M0gvRDcwRW9wbVNFUjRKcU4zZ1Nxck1DVmJMZFA4TTNiOWtS?=
 =?utf-8?B?VVJrdFZjb0Z6SmVZSXhBK29VUGFwTlpSTTcwcG5zRG9MSG1BN1dvRlZ3QTgw?=
 =?utf-8?B?WnVzTVRBRHZBb1d2d0RWM21wL1paWlpxM3hYV0JjTW9zVXErNlBzUXRMdFZq?=
 =?utf-8?B?aENxWWQzUVZaNXU3dk1id0ZENHpRVVVyRzBMcEVzZFpqUFhSdDBodVZGNFJI?=
 =?utf-8?B?SFhTM3pUcEVmZzZ3MG9iSGdsclk5ZTUzVWV3WnMvN0dXa1VnUlIzNUYrUFRh?=
 =?utf-8?B?VVloVFYyRmVINmxOaGNBOUxocjE0WFJqdVBqVzczZ0l6QXZ6MkdZblAwN1Ry?=
 =?utf-8?B?cmk4b0RKNVNMNGtnSXZSdUJ3VUJTUjY5YXVpSDRlS04rWitFeWlqUEJJS0hu?=
 =?utf-8?B?QXdoZGU5M09jVEg1MTZ0M2JHN3lkcGxyM1dCdVR0NG5FTWhlMkZrMUNsSmNE?=
 =?utf-8?B?bWZyNTBLbjVzeWN4N3FqNUU0STVOU1JjdHRESk1sYjlNV0pmODNaQ0xib0xV?=
 =?utf-8?B?S05qVUpxUnJ3UmhzSWUxUVFFRk5zdFdaNGpYTTREMVVTbkNldzIxTlFEWU52?=
 =?utf-8?B?dmdhYlZmMWtTT09FZDZyYTZwK0VrNE1zbVhLRDRuS2hzc1pqd1l5WkgwOFlC?=
 =?utf-8?B?U0JQTWpqdHJSRTVSWFp3d1V3T09RanBJWll5T0tTdG1mUDJOZVFmaFQyTWxl?=
 =?utf-8?B?WVJ1MHY1UmtTYWpObzl3V1MySFJoSGhkc0NJZTdTajhqNGJ3VXVWQUJDRmFP?=
 =?utf-8?B?MU04RDBHR0p0S3Q0MzBzUmcxVjVHd3o0N29ZbmxCcjNkMjRIRFJuQjAxMXgv?=
 =?utf-8?B?NmcvSE5BRFdQTGpVT20zc0JzUDhvTTlxNHUvaHF1a0orZFJiMjlGUzJVQWNy?=
 =?utf-8?B?YmljNitiTUZqWitHMlNkN05jQW1EdXkrVjM5Zjh1dFRlRTZZdXBHQzNOckJG?=
 =?utf-8?B?QXc3VEs2bFpOZHVlYnlTNitRdGdUeWdPVHlqVjgxd1Y1MWcrenBtanBjT3Ju?=
 =?utf-8?B?T29KenNjcFJtMTJ1RWhRWGEwVFh5V01GMmJ6ZHZLOFhoVGdqNjZlRDVrelAw?=
 =?utf-8?B?RVlBdEd1UDgyNXM1NnZ1YnpJKzAxSWdZeFdOM0twQmtqeHBPMWx1aSs2WVNk?=
 =?utf-8?B?Y0gxVHpDVUVxR2V1S3RBK0RBUVlaSHV4d0I4VDBlTzVwYmdFRVN3VXk0VzR3?=
 =?utf-8?B?ay9jbjNoZEk1QTk2MU5oK1E1TUN6MktsUkNPc25JcHdiQ2x3K0ROcnF5Zytm?=
 =?utf-8?B?RGZUNmdWR3ZvUmZKYzEzcU9BanlLTEl0c3l3TW04d2dVQ0lRMXBnaGNvNDBI?=
 =?utf-8?B?aG1SY2RqSWRwOEdVNEx6Qm9qMDRDVG13aUloNkJhTFcwWUp4dGFiamQ4T0l5?=
 =?utf-8?B?cW9Oa09MNHBSL0gvaDZ2QjVENTBZa0wrSjJaUlJmT3JrNE9sTkNqZEl1Q2VU?=
 =?utf-8?B?cFdXYkQzQnRwQ2RBL0o2OWFKbzN6OVI1aFpFYjhYby9HZUJpa1M2VmRxYkwx?=
 =?utf-8?Q?wjh0vSXrQS2pq2Tx2jGGYXLYM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa7b746-e479-4653-5aad-08dbc42e3b96
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:31:45.3112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kRcmiogFVwDImupqlIBsmAdLxY/6HHWSqwV07htj/MQGO1U31Ze5zlHn7f8aLVUacHrQb7zwQQS3GXIWvcYyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/3/2023 07:58, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>> Limonciello
>> Sent: Monday, October 2, 2023 6:45 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Subject: [PATCH v2 2/3] drm/amd: Move evict resources suspend step to
>> prepare()
>>
>> If the system is under high memory pressure, the resources may need to be
>> evicted into swap instead.  If the storage backing for swap is offlined during
>> the suspend() step then such a call may fail.
>>
>> So instead move this step into prepare(), while leaving all other steps that put
>> the GPU into a low power state in suspend().
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index c41d69e7a8f5..bb0e753fb6f8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4276,6 +4276,11 @@ int amdgpu_device_prepare(struct drm_device
>> *dev)
>>        if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>                return 0;
>>
>> +     /* Evict the majority of BOs before grabbing the full access */
>> +     r = amdgpu_device_evict_resources(adev);
>> +     if (r)
>> +             return r;
>> +
>>        return 0;
>>   }
>>
>> @@ -4297,13 +4302,6 @@ int amdgpu_device_suspend(struct drm_device
>> *dev, bool fbcon)
>>        if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>                return 0;
>>
>> -     adev->in_suspend = true;
> 
> This shouldn't be dropped.
> 

Thanks - that was a mistake when I was rebasing it.  I'll respin with a fix.

> Alex
> 
>> -
>> -     /* Evict the majority of BOs before grabbing the full access */
>> -     r = amdgpu_device_evict_resources(adev);
>> -     if (r)
>> -             return r;
>> -
>>        if (amdgpu_sriov_vf(adev)) {
>>                amdgpu_virt_fini_data_exchange(adev);
>>                r = amdgpu_virt_request_full_gpu(adev, false);
>> --
>> 2.34.1
> 

