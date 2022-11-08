Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F62BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 15:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB99C10E483;
	Tue,  8 Nov 2022 15:36:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E089B10E48B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 15:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwr8yo6BnpQgCwc9cOi9FF1FB3xGvWtgcwHlvX5eJbD2KOkWCUoPJUrRgP36V9prR0QqmhUXunlqndJxgS2c7IojGZyRoyXTuc6BulBFTNaPklhLxNZgSrS/f5A3VFwVJoVEQ+18AMuK7Oy6lrh2DKtHBwTk9A3iJs6FYfDFLeZLclj9r+EZ39GBgqwIgJs91+X1DrfyJxu9JQjU99Nwj182rvV80LZMZccTeROJLnNl2rQMNe/TPKnEff7JAxoUdOlsVGQpRLLMnR3k09rSL92dEdRuM4DqSaFQP3NkiWwwqJav6Cb6iCrptnCIpEI5uYtwyMAoAG88MmQ+8APTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI3SrC9CtIsndELunWMt4Br8/DTyyxtGDiDwTMfJH1w=;
 b=Cc7Nuj0Sx02jWWAa78RuetvglWiOt513kSieZpSSB7xF1Rk+NMm7Lr8JkBGE+wcNYzB+bvz19YccIKQJpun1MMFnPJnY+XnxL7QdzPcjY7nxVw3IPaIMaMF3ODncXUcvuGtcHjjVrUHrrrx92YIczp6zTB4KE1i0f96MoU71n16afHWL/3FZjb3XQ6Cfxr/S3DXj0cu3/kCqSHQNDRzhp0mV8w0nVXYxaU1DiEF31yHlATTkBz+AKc9Esm0n3Gprxj3sosGPzPj+VQiEo2ysFTYrIl37HraJWQxcTIA0h2riKr+G2v8pEd7R4fjQTWADp98IvKELb2/pzLb14xAnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI3SrC9CtIsndELunWMt4Br8/DTyyxtGDiDwTMfJH1w=;
 b=c3iGINcKWx7Qf7lpVTngnJc3oFp1UUU3SqAH9c5Zls4j/GxwAMiBUTmxQFQbjW9wg3JRT6Lc1UCMZG7uE4XEbm8SPk2A5E/L54Wjbu61yyvRcxBsUNpao5ObSYUQCx+vCE6ZdYZad4LBV3gL65ib7IxHWaV9yDq3Dul0EgQ/+7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 15:36:50 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 15:36:50 +0000
Message-ID: <e3d8f18f-3512-3678-1ef8-5d920aa2ff99@amd.com>
Date: Tue, 8 Nov 2022 10:36:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Remove redundant I2C EEPROM address
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221107172253.155475-1-luben.tuikov@amd.com>
 <CADnq5_OwEcfa6+Ggcv203X2iDTTVpquuT6R-zSpbeob6OX-9qw@mail.gmail.com>
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_OwEcfa6+Ggcv203X2iDTTVpquuT6R-zSpbeob6OX-9qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::33) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a22934-d636-4b7a-06ec-08dac19f0e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CGlhKdtTMwwR3gvCvUzWU4HSt+VQYsORkq3qwDiRY0exnG/BlLkbN7XOG1e5ra8cid4sgjV8L3AIFb59SvR56osLyEa1AqLXfpMqo/VuxyNlCiGGO06RHoAOEZEa/PetdwnBJwkUwQgfXgK/a1NGmxz+6A+p0BaXQ3veoYBfMehg2Q5lOOn8Eq6Eg51oL5Zkzp0vOG7OLlwtEm5LI00I+no5YPcPaBqL9z/XTxB2tIjBPRtZjECoIuzkLhqIlpX35/92UcM97wBhFjr8qtkHTYAmCJ01TaqfwvAMFhpiXqQsKUiyW+RkRE1fW/Tkn5Ldge33b4DxrWqfmwphOx5IhUyihgH/m6Lg3KKxkx0z4ejJrmy/WFoSCYy14lFdmWiFpVtuulVAKslSCk8V1WPkyuJ5W8kRfoTlOSecWcdXjhhdJfWyOgE1A6R8ATyUNyzGC/HyxrPP0axhrO8JjUYilW3eMfXtSA6XGzGKEYKTPpraiNj4oI5QXwqG9Wbik4CVT3IDuheq9mX21BnD1ThSd/ZhDtAwAYIukU5JZ4FVkh4+hjyFC1bMbYuP7JW4ljKrKx9jct4gcVoPoemwZZ0cmmzYyzM93s+iFJYV2yyJYvl4bN9ADqzb9O77g+wMsXcX97zvsO3eRyoT45wtsQaueXZct/sq70U/u28xW4anWclv87SkrryTK6qlcr5Hvp/n4BhY+I4y8VwPz/V5pJudhxNeREIJiKS4jBShg0L3QJpalTER/RYJq5ZXyHQ+Dj1vhmGzduW4CNWNJAhijJE5U+8KVmGu0kSg7Njwm03xbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(36756003)(31686004)(38100700002)(86362001)(478600001)(6486002)(41300700001)(83380400001)(31696002)(186003)(6512007)(26005)(44832011)(6506007)(4326008)(8936002)(2906002)(5660300002)(66556008)(66476007)(54906003)(66946007)(6916009)(2616005)(8676002)(53546011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFpoZVNaZFlYRksyNkZyekw1bmZtOE1mYnJ3L2JFVUNHQ1lLSm5wblh6SDRW?=
 =?utf-8?B?bGM3VlpCendzcURkUy96bnB5ZVVMMnRCcWdKY2ZnYUhhN29wYVAwQlEwVWFY?=
 =?utf-8?B?c29YV0dwaGkyQ2xVRXkrUTh1QXExVGZsV21SSERBMHZkTzFMM1NIQy9nclF5?=
 =?utf-8?B?WVRmbU1icWltYUZxQ0cvZGNTajM4clg4Sjh4RU5od0UxZ3Bua01ocmJ6WDBs?=
 =?utf-8?B?Qy9xRzhYZ1AwbjBHdWh4Y1FoNDFYb0FWQ3lhd3JlV1hyMGxXNkZ0S3VPVmxw?=
 =?utf-8?B?ekNwVWZndUJBYUdUMGp3MzNTNkVma0VVWFhCLzF6SjlqZm9Cbms0cFp1LzJE?=
 =?utf-8?B?dW5hWkxTUmlnUGRLSVg2RG5EVk9oRVMvVnF3cHlkc0M4NG9XRnMyU3luTG1U?=
 =?utf-8?B?c2lHeFpXY0lnMWxWV0xoZ1VTUnVRNXY5SjUxekN6SW5VUWZkM0N2RzAvcngr?=
 =?utf-8?B?eXlIRWQ1UC81K3hCekpqNGhrMUg5R1BSN283ekxUUGVhMVF6QXZ1cDgrOUVQ?=
 =?utf-8?B?L1NraGs0MjlGT3B6WTVSQ0tQeEJHTHZ4ZlowS3VjWklDUnRqUjFlU0d3NVRz?=
 =?utf-8?B?TGdiWUZYMUtVNUtqVkxtTUZtSDcyamkxcXA0VE93ZWNLSmJkRnhzYlpsUVlh?=
 =?utf-8?B?WVNydVlIcFRMQitoVnlHd3cwSWRGTEVMTjArVGQvTjNZUVY5ejdpMzJWTTdw?=
 =?utf-8?B?VDcxbkNVRGpBTHczQ0lYUTFDQ1ZDUGRPRGtJRUF4WVhia2czZ3B2YkdKRGl3?=
 =?utf-8?B?YzRoS1BtdHBidUVHajIvQmlYRkhOdXJRRHRpK2RxMjk4YzMyWjNodm5yb3U1?=
 =?utf-8?B?S29rL2tpUnpUenR1dEVwT0t1MTRZUXFKa1JwQTJQSXZUUXA0NlhnZ0VxS200?=
 =?utf-8?B?cGdtQWgvRGRXS3duTDYwOUUwK2JXdkJKdWUzZ0ZOV0huTElpZndOTnZyV1ZV?=
 =?utf-8?B?L1hMWG9vNXBBSXZuTWFJbjlRQzdPM0RsOVZRZkljSzVNQ0JoVklycjh2Zko0?=
 =?utf-8?B?aXRJcDdtU0RPSlNFNlpYdG5LRkxhNzZoRWU4NGx2MnB6bHI0eUVWWVE4alFv?=
 =?utf-8?B?ZEcvTCsveDA4dDd1RHdhN0JDeFplTXQ4NGxzYVNlNVY0T08vc2IvNTN2REJB?=
 =?utf-8?B?RDZFaGpocjJpNGdpS3NSQXlRTjhtbzNPVDVrR3AvakNwQjRaQzdrek1UUDVX?=
 =?utf-8?B?eUVSY25lNFJldTVCVG85VTdoODNNVXdJTnhUMWltZVFoY2hXUHRmUzFXNjJs?=
 =?utf-8?B?MEtvQ3NxcUdhNHZoWExXcWdXYlExTFRZd2R0UXVWbGFxemMvL3pPSEs3aGtW?=
 =?utf-8?B?eWpUQUltY1Q3d2Uyall5M3p4SlFGUkVYR3NaY1VFcFlaS09tQkJhTDdxV0tC?=
 =?utf-8?B?dE1BUlplRmZ5V243M2hUU0FBYkJFUDlKT3VyenZMOCtJRnlmUHNLZnB3c0hG?=
 =?utf-8?B?OStscFhoSHhzak1yNGtqMmlQQ0JmWmo5cjdIb3EzZW5zRFVvdUo1RVEzSEhS?=
 =?utf-8?B?b2FWckZBVjBMNHNjM3FvRFVtL1R4SWMyblRwOVdnWldSNlVuVDFxTlNZTGR3?=
 =?utf-8?B?Z3crM1N3OWJ2bW9sTGdvRFBlcnlYbUpzYVRmZ1MyaFpOYng2TlkyVGNGK1ZY?=
 =?utf-8?B?MlJOeFc4cnVJU2x3d0l2TmJoV1pDR2dvSmJIellSS1hoMHF2NFpWMmRZRFFJ?=
 =?utf-8?B?K1pTQmdYeENZZVJLaXpVQmY1VG91TGcvbUpBVUpMT3FENzlUS29oNXU3Vjgw?=
 =?utf-8?B?Ri9sQVVsS2NvR0ZPMXZxL3RLOWRudFZNNEFlWHhHaXFKZzdMazlJbW4vc3o2?=
 =?utf-8?B?WG1WZUpEYzg1dVBzdHpEa1JKU1dVbnFDWHBxdWtzdk1WSHJCVzJIRzQyR3JU?=
 =?utf-8?B?azVIazI3bUU4RkdQMW1QYmlPajJVdzU0d054elJPU0pzVWdEVEVUMHVzbWVW?=
 =?utf-8?B?S0NwV3prbnRPVWJ3WW9MVkQxS1R3VDBma3RyMElzY1JkaDV6K1RydUw3bkpK?=
 =?utf-8?B?cGc4cGRGMlRVSnVITEhUbVV2MjZCSm8wS0NVVGY2VlZvektEdk9vZ0NXZGZa?=
 =?utf-8?B?T0hoODNTd2NzVTM1aFNVVUtlMVBxYkNMbVBoS1Vrdi80bTBqZzU3SmkyeDJw?=
 =?utf-8?Q?542LlLUyJWcevRUrlQKy/Xsgn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a22934-d636-4b7a-06ec-08dac19f0e0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 15:36:50.7513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kRnjR9BHyTT7245Qe2SOHgGO/BhAh8AOUexnqGZf3/dV2OUBT51hf/ugb519FoD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-08 09:31, Alex Deucher wrote:
> On Mon, Nov 7, 2022 at 12:23 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> Remove redundant EEPROM_I2C_MADDR_54H address, since we already have it
>> represented (ARCTURUS), and since we don't include the I2C device type
>> identifier in EEPROM memory addresses, i.e. that high up in the device
>> abstraction--we only use EEPROM memory addresses, as memory is continuously
>> represented by EEPROM device(s) on the I2C bus.
>>
>> Add a comment describing what these memory addresses are, how they come
>> about and how they're usually extracted from the device address byte.
>>
>> Cc: Candice Li <candice.li@amd.com>
>> Cc: Tao Zhou <tao.zhou1@amd.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Fixes: 367a1ebddde5d0 ("drm/amdgpu: Add EEPROM I2C address support for ip discovery")
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  2 ++
>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 ++++++++++++++++---
>>  2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> index 4d9eb0137f8c43..d6c4293829aab1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> @@ -79,6 +79,8 @@
>>   * That is, for an I2C EEPROM driver everything is controlled by
>>   * the "eeprom_addr".
>>   *
>> + * See also top of amdgpu_ras_eeprom.c.
>> + *
>>   * P.S. If you need to write, lock and read the Identification Page,
>>   * (M24M02-DR device only, which we do not use), change the "7" to
>>   * "0xF" in the macro below, and let the client set bit 20 to 1 in
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index 7268ae65c140c1..1bb92a64f24afc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -33,12 +33,30 @@
>>
>>  #include "amdgpu_reset.h"
>>
>> +/* These are memory addresses as would be seen by one or more EEPROM
>> + * chips strung on the I2C bus, usually by manipulating pins 1-3 of a
>> + * set of EEPROM devices. They form a continuous memory space.
>> + *
>> + * The I2C device address includes the device type identifier, 1010b,
>> + * which is a reserved value and indicates that this is an I2C EEPROM
>> + * device. It also includes the top 3 bits of the 19 bit EEPROM memory
>> + * address, namely bits 18, 17, and 16. This makes up the 7 bit
>> + * address sent on the I2C bus with bit 0 being the direction bit,
>> + * which is not represented here, and sent by the hardware directly.
>> + *
>> + * For instance,
>> + *   50h = 1010000b => device type identifier 1010b, bits 18:16 = 000b, address 0.
>> + *   54h = 1010100b => --"--, bits 18:16 = 100b, address 40000h.
>> + *   56h = 1010110b => --"--, bits 18:16 = 110b, address 60000h.
>> + * Depending on the size of the I2C EEPROM device(s), bits 18:16 may
>> + * address memory in a device or a device on the I2C bus, depending on
>> + * the status of pins 1-3. See top of amdgpu_eeprom.c.
>> + */
>>  #define EEPROM_I2C_MADDR_VEGA20         0x0
>>  #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
>>  #define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
>>  #define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
>>  #define EEPROM_I2C_MADDR_ALDEBARAN      0x0
> 
> As a follow on patch maybe we can clean up the rest of these
> duplicates?  And rather than using the asic type, maybe just switch to
> the define to a more descriptive name?  E.g.,
> #define EEPROM_I2C_MADDR_0H       0x00000
> #define EEPROM_I2C_MADDR_4H       0x40000
> #define EEPROM_I2C_MADDR_6H       0x60000
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 

I sent a patch doing exactly that 22 minutes after sending this one.
Kent already reviewed that patch. Check your inbox, you're CC-ed on this and
that one.

Regards,
Luben


>> -#define EEPROM_I2C_MADDR_54H            (0x54UL << 16)
>>
>>  /*
>>   * The 2 macros bellow represent the actual size in bytes that
>> @@ -130,7 +148,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
>>         switch (adev->ip_versions[MP1_HWIP][0]) {
>>         case IP_VERSION(13, 0, 0):
>>         case IP_VERSION(13, 0, 10):
>> -               control->i2c_address = EEPROM_I2C_MADDR_54H;
>> +               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
>>                 return true;
>>         default:
>>                 return false;
>> @@ -185,7 +203,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>>
>>         switch (adev->ip_versions[MP1_HWIP][0]) {
>>         case IP_VERSION(13, 0, 0):
>> -               control->i2c_address = EEPROM_I2C_MADDR_54H;
>> +               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
>>                 break;
>>
>>         default:
>>
>> base-commit: 03b61a92efbaf17ac3d9f82ae81aa4cf8ed40608
>> --
>> 2.38.1
>>

