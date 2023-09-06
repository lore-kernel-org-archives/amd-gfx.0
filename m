Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7254BEB8FDD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 14:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5C710E1B2;
	Wed,  6 Sep 2023 14:36:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B31D10E1B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 14:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrTbUYFRN4z3s3J8aB3rEs5LvCYOhbmuJyv05DoawtFrNsSko2VgXgXfz448Bxkr5Cz+wd2e6Q4bmnW8NKH3xEx24ONKnnX0ZZq9YZcbrlQNflKvmmtsAg1daoKLGty6OU/nSzvmaaJUCQc6pt7/wYbrddyfvgkCp+gLmVirMi6EpBH6J//dLvVkyeLO97tRP+J3Gh/DC8uaMZ6OSLT2Vun8McA/xdSbCktadOEhy42mynds16vwsWyAwI0uqXrWkNPeXDnvXWjV+Co9CQWmHUVCkZC//KtXZa9sSElr23EyeQY+rvMj7L78ftnPQIKSJvLb3cY8ZPZM+LM04KEd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPO2VQBxWhlfwjHFJhj78hl2Qb6IcZIq9Nw445IKMLA=;
 b=jhtxMEPWJ+UglSbjw3hVz8Jdz54bDZ1FAYU6hPd2wPcbu7CNH0cKc0+vuzbyDFQ5padk8mQXlpPly8ncnAyvDCTwQ4+DZcTiP7hdNgSw/VmUm4r/YudvZhzuckYy5ql5rDeLgeXPtK8DWtVZR9WFyJpjCNYrdX12gKIbsp2I0PqsZ10I9lpa7AyC1iXQQeGgrcxX5WeLW4sAt/HEKXdDVgvwemWIR2xUP4bQZZNQ9mhGVbph3Rm8OpR2+Nug+/1gXuYQSzd23cdemPo/FMLb6AJlLxyHXzq6RwPImXJRmHrH/3hSJJR16pH4SdPf9b8l5HnuANMTFt+LlClNMWbKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPO2VQBxWhlfwjHFJhj78hl2Qb6IcZIq9Nw445IKMLA=;
 b=ZEDb4fBr+k7NOq0roqXZYspHLhbiJasQ2hjd0hCGcPKqPZpdCYQwuRl7X3PG2cusp0pdxsGlsI40ypmqwljqcYpHQU2abrgidDXsIAydHiceIjV38Rq9RTh86DBjZ1StfF4NztMjUJWOn7arKKNurq95xouQqOoAvfGPX9qtoX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:36:04 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:36:04 +0000
Message-ID: <e75b6e4a-d4f4-7754-e102-4d9f64e8b70b@amd.com>
Date: Wed, 6 Sep 2023 16:35:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/11] drm/amdgpu: fix and cleanup
 gmc_v7_0_flush_gpu_tlb_pasid
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-5-christian.koenig@amd.com>
 <4995b233-e9db-93a0-1ba6-60376cb5d024@amd.com>
In-Reply-To: <4995b233-e9db-93a0-1ba6-60376cb5d024@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e86f1e5-bf85-453c-dc68-08dbaee69911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/FTYQXuv2kRGSj8M6w9YiNZcY4VXEQQrHNlSm5xmTcxXY1pkn/tuSNVg9BqPSAGtPQdX2Vgegkr4uadttTu747m+Gl2+45tpIcQo7w9GGKac7F2uwxcyvrVZ3syyDDaIaQgHYZHUm7Elz/ZclHEzIbpr5gpLSXDfqzn0EqLlHcXFB6shFj09wolFQmhHCvkd0xiS95S11FOd8JxGzkJWBlo5mprQxlGLcJOty7QduMkfl1C+MCmKL+i2V7ZrLlNZR1Jn6GfafcM2VEdQ6IGUsfnu1X4foJIgRcCXL47DJOYTklW4jtst+2dOApP0wV/smdfSmnlAIf9HK25Anhii14hDVtoXgIArMJYv5DTrhBEnXNnGtswgLx90gZ5W24pV90a3zOKGZooWamJXMKj/ecIIQiu3s6h3qWS6a8bzNOU6/ZT6VD2Z2hzCmF3nO7zeAkD+9NkpJCdNkA5ynUD7g+AXl2MRFHsRQTlxJ46hMonklCZizETJtxZDAo3Rw6e/hlM05hD8N+I0byFt/FgSzl7eNgctpNskBqrYjuDD9lEnFlZJ7229k2m7O9S/agXokOnY2BpR/g2E55jcGiy9vWR7zqQBaFljJjMqwnBMVzHGJvc17ZYZEozbOyiXL/BqWKneY4r7Fc5WeVGLwppHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(26005)(6666004)(31696002)(478600001)(86362001)(66574015)(83380400001)(38100700002)(2616005)(53546011)(6512007)(6486002)(6506007)(66946007)(8676002)(66556008)(2906002)(316002)(66476007)(36756003)(8936002)(31686004)(5660300002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFh0M0RQZ2NxdVMrUUpCQkdkQ2MxZ3MvNUNFYldnbGVwQ3pGbmZnY3NpK2FK?=
 =?utf-8?B?Zlc2a3BoWjRhRmRqYnFGU1FCeGdhMS9tYmRwa0lWajFibkxFa0RPdUVtazJS?=
 =?utf-8?B?T2RPVk9paEZqeGY3MGJtUkRldkR2Njg1MmcrL2FNNUNOdzcvL01VYlFQN1JT?=
 =?utf-8?B?WFhSMU4xVVdHMk9ONnMxR0dUMnJ5RlIvdXUyZHFzQlFPeGM5WGpYRlBzTlA3?=
 =?utf-8?B?b1M2WnZzWCs2WTBiSkl2OW5CTWw5ZEliVEtXbXpFMFZ1MjhGT1ZTdkMrejM5?=
 =?utf-8?B?S2pQN3R3Njc3WXRpNi9WRTdlK01wclI4a2lWSFIyVVNwOWFqbDRSNXQzdFZE?=
 =?utf-8?B?bTBJc2hRU2NDVGNmaU9uamlUK0l6aldLZTlPVDFzMEwrU0VxeWVBcjU1TlVt?=
 =?utf-8?B?U29OdjBoNWJkN1oyRHZGdWpvdmo1dUFRYmIzcTRMZXdZYlhueE5weVpua0g5?=
 =?utf-8?B?TUJLYmhIQXA5Y2FTTFJvS3VoWkE2VjU2SlZOamZnZEE4YjhwbnMxcDAyN3gv?=
 =?utf-8?B?MUErQ1F3cVFmQ1p5U3lCQi9hTFVJSTVYV3FDKzdpeXovd0NKYngxOWkxVVpq?=
 =?utf-8?B?ZkQ3OGNuSUhoQVZKcCt5d0hXOFJoeGVqcEZ0QWVLWmV3Nmd1OVhhT3p2OU5n?=
 =?utf-8?B?ZHliTTVhMDFSVXd1aTlwdkg2QnJCZ0kzeC9MR1lMamJPc05yQ2kxdE5uOGFx?=
 =?utf-8?B?ZkNBOEYyMnQ4VGFNdXJMVHBJUWJkZGtQZWlPU25PMktaRUJhaGtlbjJqd01h?=
 =?utf-8?B?MHNicnN4Qm9KcldDWWowNS9nK0RrVW9vd055TUZtOTM0TGdJWmRQSUMyREtX?=
 =?utf-8?B?M08vOFRtdnBVdE5SdVYxUGNXejRuL0JVNTNpSzdhWkVzaU9LOXNwN3p4Z0lH?=
 =?utf-8?B?cERWc29tdkFzbVoyNC9ER3RKbi9CVHJERHpXL3ZJT3ZHUXdUUE1LbytldnBJ?=
 =?utf-8?B?aWZXSy9ZZUQrOUpYUmVPa3VSdTRnR094eFQ1bWpHc1dvNS9wZkJJcnJOOTM4?=
 =?utf-8?B?QnhsZTBIeEV0K1pwZWZCQnFlMzUyQjdVb1RYZmovZnFnQU84T2VKM0JTdUxN?=
 =?utf-8?B?WkpRNU1qWEd4VDVacGlFcXhnRUxHR3VYK2tuUjJjOUU2R3BvQ1NxVGpteWU3?=
 =?utf-8?B?dXFvdFExUDdjV2JYcEJ0RU45NlJtb0ljQ1VIR28vRmROdElwNUFjNkRodWZY?=
 =?utf-8?B?NkJSc3VoVGhQU1ZVZWN0UUwvMXZ1V2JleFRkNDJpSllyYXZUcnNBOXZaL3gr?=
 =?utf-8?B?bDlLbC9MTGhUemJIaGZOWHdwdFN6TXZTSDFkTW5kTjJiUFdTRDgzOWFhVmVM?=
 =?utf-8?B?Z1Qzc3loeWxrc2FiZGxXdkNJZnlXYjNFazRncUliN2dCTE5yYW9qODJlRDBC?=
 =?utf-8?B?Qlptd1h6SWwzSzl1VEYwZVZ6UXYvVW1NTXpUdHoxa2wzTTF5dUNZYmxuSGF6?=
 =?utf-8?B?UjhBdVJoM0hncjk1cFlmcmltaDkxdTFzclNhcWpmOEZaQU5mbUN2RFhuWTND?=
 =?utf-8?B?L1M5SWdDOG4zOTR4YXE1TGZFRm5Ic2xkSGlRL2FTSW0vRWU4bzBJc3hDMUpR?=
 =?utf-8?B?eGRiOUVTRjFTeWt1MVpsaW9oYUR6Q3VGT2tmVUcxejYyNmhkaHhNbi9UVHJ6?=
 =?utf-8?B?VndRRkVEajBUQmQ2Qk9hSTVSOEFNWmlBMWJmY3FlSVNGdFRHZ01GRFpkMGNL?=
 =?utf-8?B?OE1aYmtBYXRDempzSVlON0Y0dWJWZTU0SWtJcnRLRzg2R213ZlRhTHZvcXFH?=
 =?utf-8?B?TFl1S3RqSThrclBwcXdoZVdpU3NCU2hNQTBQU2VvdW85c0dUbDY2ZUJUYmEx?=
 =?utf-8?B?Y2dLelM5K0dFbzB5YW9UMXRqRXYzWWZFc2NiNmZWSWMxN0cvb1IvazJRTGZk?=
 =?utf-8?B?VEVzQUdoR3pJWHNQeFdCR0lQTW5oZGJTM0RTWFJ4TXJSWTF2RkNqV014R24x?=
 =?utf-8?B?Y3FRWmVYS3JKNmNYdnFCcnJyOUdFUURQNGo5dFZCY0hsamwrK0QrN2FjbGMv?=
 =?utf-8?B?eFZGMWhwTWRBTWw4UWc5RFB4M05VVWFOVVdNRzM0azBEOTlmTHU0UWtuSzkv?=
 =?utf-8?B?em1SanNJSVlCdmpZdEw4SEhRWnR1U1pEUjArVUZKUzJJN2U5Q04vL1MzbXdh?=
 =?utf-8?Q?Bgh894p5caxAdo8UMLJicI+9q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e86f1e5-bf85-453c-dc68-08dbaee69911
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:36:04.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNpTcw4XmZeFA+fsAmGy9GN1tNinjHcej52IySK0mG9n3v3ejgbaSiw4/+bhEM4pwauGyT0SK+ZDKEmt8TuqPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
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


On 06/09/2023 16:25, Shashank Sharma wrote:
>
> On 05/09/2023 08:04, Christian König wrote:
>> Testing for reset is pointless since the reset can start right after the
>> test. Grab the reset semaphore instead.
>>
>> The same PASID can be used by more than once VMID, build a mask of VMIDs
>> to reset instead of just restting the first one.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index 6a6929ac2748..9e19a752f94b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -33,6 +33,7 @@
>>   #include "amdgpu_ucode.h"
>>   #include "amdgpu_amdkfd.h"
>>   #include "amdgpu_gem.h"
>> +#include "amdgpu_reset.h"
>>     #include "bif/bif_4_1_d.h"
>>   #include "bif/bif_4_1_sh_mask.h"
>> @@ -426,23 +427,23 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct 
>> amdgpu_device *adev,
>>                       uint16_t pasid, uint32_t flush_type,
>>                       bool all_hub, uint32_t inst)
>>   {
>> +    u32 mask = 0x0;
>>       int vmid;
>> -    unsigned int tmp;
>>   -    if (amdgpu_in_reset(adev))
>> -        return -EIO;
>> +    if(!down_read_trylock(&adev->reset_domain->sem))
>> +        return 0;
>>         for (vmid = 1; vmid < 16; vmid++) {
>> +        u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>>   -        tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>>           if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
>> -            (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
>> -            WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
>> -            RREG32(mmVM_INVALIDATE_RESPONSE);
>> -            break;
>> -        }
>> +            (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid)
>> +            mask |= 1 << vmid;
>
> I am a bit concerned here about the change in code, in the previous 
> code we were writing the 'first match out of 16' of tmp and of mask 
> and programming the registers with (1 << vmid), whereas in new code 
> set we are writing the 'last match out of 16' of vmid. Is that 
> intentional or expected ?
>
With last, I mean all matching bits until last :)
> - Shashank
>
>>       }
>>   +    WREG32(mmVM_INVALIDATE_REQUEST, mask);
>> +    RREG32(mmVM_INVALIDATE_RESPONSE);
>> +    up_read(&adev->reset_domain->sem);
>>       return 0;
>>   }
