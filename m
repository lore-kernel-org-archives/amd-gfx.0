Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3EBC636D6
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 15:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B60710E149;
	Mon,  6 Feb 2023 15:31:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2D610E410
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 15:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJI6aE8yG7CVccoUerwHhUJiHu/gtP8NP7LztBkYJK60CVazxByNd8cfVoZx0x5nMvQVTmgEUpTPmgH7tipu99FvcaOQUe18XjyNB6LhaDB2s1zX6y3LciJHGFBfijkFUjd6M3sZQ9U8B5cf5rcxIn1N9yKcykHbmrRNc3RfFKX7RRtUOuG/6Nk6b30wl8P2ht5b5uVybR6pBvS66UIF+oaT3X8QNoNftG3z46QiarKkzUq0Ld29XixyosEBgpyTXFVYxkdMTMYlS5IvQiXx9yrdWMPpqBZWEQ9A336rJ0hRGREaTW+nYckpSsaweLMhLItER6rTjbLE/5oSoF+aCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRAX0a6p3O2CCZ9VccGH360GSJ/NOWnJK9NkzFKPju0=;
 b=HE3FZ7mBVBT5+U17ZZoSGvXZOIOS6dGBavXHXwcyHuORLOwY8vUaWwwUvGWzjzPNXEzYil+aZOHmibJ4xPIPNihKF9u79N/4DR6TnwoRbXq6S2e424iIsFoetwDWImsbYpzhzwHvvbbyg5IZvR4y3dVWFObnn6i0hhMH8317Fwf2mA/9gB87Svlp5E5dMoAVUfYBuXWC4KLaiRmE3MaL4OkFuNLSAhBx1QJIeKVBB4dROCIm1lNp0ap4ruNrhFOVWxTwxWGo5EDEsd2x7aK882rVnV3yxQv340K2B/Na8iqpt8/TZ38YOwlv4a7PdNATeL/GzyL1U82tzdc6N+XY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRAX0a6p3O2CCZ9VccGH360GSJ/NOWnJK9NkzFKPju0=;
 b=N1ZHp6tDxgqKLr453hneFpVugOqICaqgK0z7wpaYXn22o9O8yBZkyd5RMdES0YsW2UH4uPt4fW/tu5jXwGkVnLJNe+k22BbjysoUOXFFewsUHC0oby8RFyz1t4IQMVq8fXZDsKpS5B0eoann9WvoeDW7+X3al/g2TFrMYHKXHUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 15:31:23 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 15:31:23 +0000
Message-ID: <6db2455c-74af-9e13-104d-885735b485ec@amd.com>
Date: Mon, 6 Feb 2023 16:31:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/13] drm/amdgpu: add UAPI for allocating doorbell memory
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-2-shashank.sharma@amd.com>
 <d494db26-ab52-d21a-7ca9-d07fed34397a@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <d494db26-ab52-d21a-7ca9-d07fed34397a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 41029f40-f9f2-4bb8-b853-08db085733d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzdybV5NlJjuL+bpZUW+//fF9NPPHUurZ9GlLAgyUUtWrkaLBehJlxGIPi5p4mJExokli20E1AXeZAPysPyNJWYRKmiMmGWdeoTmje28KyiCMnTja1B3EqauMxOI08qFTaS3dfTrQ0P8SqV+/7p4PqI7JK4Qc35s62iNSzdsvzOQmn25+5JFZTovk6o6LTxmIjtZkH6CHRU2PVpSa8SOo6HAOCrkXLgVaqmFcQtBAH2Tm4TRGlWPhm3Gu+GdzNYKa2MKcvy+Jj6YOg5FirGBiLbC9EbHRwJwXwlLPWuuJXF/BYK7R7/sy283mRzRH5j5HehDeKtnMdgt4BnO0u3OtUmi61L5tomTc674uaHy5f+0CQDpwW0CDn9x8Z/DoGNIk04Yoxwep1td99QvRyqpMrYjfo13G7cO1SRC7NzFAGzLEi5WKnlmpftWsHeDxAQDUyxP2DdETv9BzbcLWGMXiKwtw1Y6rRKxuTOoo/NsJ6NsKMqAS/2bF9L95S3oKNRGyQ/OGh87dpUjpUjs5MAN4WM4rQMDKBpyKtoeYAF9rrUQ8fcbwIALZvl5HcIw9El2J+vC3vt+gC1YI8XP2hdnSGIpioHeJczYn1TgtKQBMxTxCI+BcSO3jAalTPPS35FY/CyPW8fdB29N4pLhdap2ipUhyHxuW7IrphZvW/7nTjF4jV0RSGnsH4mDfBypEfKDmxTghDgngkynrbI6S2pxCzReBt9BNDqeGKBCXicYQoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(44832011)(36756003)(5660300002)(2906002)(6486002)(478600001)(83380400001)(186003)(8936002)(6666004)(26005)(6506007)(6512007)(53546011)(2616005)(66574015)(66946007)(66556008)(41300700001)(4326008)(316002)(8676002)(38100700002)(86362001)(66476007)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBhUlZHTG02T3J4cFA4RmZXbTBRQWdkSmpCQkw1YldrclN6Z3IwbGFkSWsr?=
 =?utf-8?B?bTFseFo0bXV2akFNc2FCTWVEMWNGOU1ocXRRMlh6NVpvUEJLUXhqYVhHNlJY?=
 =?utf-8?B?VTM0d0VpODNXSHowZXpZUXBjTkxraGpVbjVpZWluRzVrS1QySjltcUEwc29Q?=
 =?utf-8?B?WkoyNnpsREdXVHRmL1BMSzFGODlvMGZ6T01jZDdndTM4bjZ5YkpIaHBXbGk0?=
 =?utf-8?B?anY2YkVDa0NNVkdJMXlFckpWRm1xSUpFNUhORVdzRVpDQzlYZHRtNzJYcXVi?=
 =?utf-8?B?V25vYk9taG5SL0JleVZJRkNwelVzN1F4TmQ5QzAzaWdxYjFtR3VGQnF2U1dn?=
 =?utf-8?B?NENmbmRSbkZ0NzZaSWhja0NtRU9raWhpNGlhb3pjNHg5QmlldmduQTdUSlNm?=
 =?utf-8?B?WU5JRXpjalhBbzFwczFIUGNGS2ZMUXpUS0JBaHRUeElkOXUwVVZjb09Qbjky?=
 =?utf-8?B?czh6WHVSMWJqd3FlWFRDYURicUFIYUMyL1lLcTVWK3lvS0hsZFFxcHZHRmJ2?=
 =?utf-8?B?RzNFYXNKcTk4OUNIejZpWjVsVTE3Vi9YUzUzZk51Z2kzaUxXOUFCUGg1dElO?=
 =?utf-8?B?UXRoWmR0TUhyN1o3WWFTeEF1cGhueXBlcWowSUF2ZVIyOEJsdXRkZWdqbGV1?=
 =?utf-8?B?cHpOM2lUY3IxWmc4Z1pTUFlXQ1BCaWFFWmplaDF4Y2QyWTlXS2ltSHNKUkRq?=
 =?utf-8?B?U09qaFhEVlhvQ093dVZIR1JRK3drOHQ4dTFKZSsrVVhlcUlZZ1I1cjdUcGdF?=
 =?utf-8?B?M3FqNzRSL2JNVi9HMzVPMk00M2VkNWpWQkphYkozNWdtejN5VlVkVHRxQ2FE?=
 =?utf-8?B?YnBBcVE2dXJoSkJ0eE9DczEvZkw0NXNMM3R6RnVVUWFnWUFnUTBNNWFPZ3pZ?=
 =?utf-8?B?bnEzNkdSQWlRVUxGZFBGKzNpZ1lDcEhIdFlKd0pHc0Y3RXI3RE5PZ0FWZWxV?=
 =?utf-8?B?VEIreURveE8rWUlPOXhPNlNMR1BodEdXQ2tlaUp6TGNkWmExczVrV2xsRWFy?=
 =?utf-8?B?dkNzT2NabE5STzBKamtETlBlazVKTFZlejcxeWtORUxpeTlER1N6VGE2M3VV?=
 =?utf-8?B?WVc0T0xZT1JSV0JMNFdvUWdTWmVwQWRuUGtZR2VDU2J4c3RxeURhanBMTFNP?=
 =?utf-8?B?S0F3a3B4bWc5TEJ1c3hWSnk0YTI0NzRjZjBIZ1lta1RLK05FbFB1ZTJTZUVp?=
 =?utf-8?B?Rk9SU1k3bEw3blFzNjRFNWNUcUZtOWlvQ2phSmhjM2RLZ3pFYkxhR3Z6L0dG?=
 =?utf-8?B?a3owWUlJcHQ2Z2VkN2pIblRVQ0Y1YjB5YlZYcUNXLzN5TENyR1JmUlZHQkdp?=
 =?utf-8?B?TnlzUFJqK1ovU3BqQ0I4ay80THdIeExVc1dXNGdYa1pVdjhJT1J5MVNDajc1?=
 =?utf-8?B?b1UxdG5sTjdtUHkxc3FJR2h4NUlYMEFOZ2QyQWI1UDNHTGNaOThhVzNZaWFp?=
 =?utf-8?B?M2tnNzZxSHQxc2ZReXRENStPcWpnNDkyUjljZFRBVlN5a1ZYcHlqYVRYcVlq?=
 =?utf-8?B?bGhFcHcyM3d3UWNidWJ1UG4zNkk0VDNPcEhqYUlIS2tUaXNMZCtwTEh3MkVO?=
 =?utf-8?B?V3VHeDhJVW5lTlBUM0s4V2xHQjFOK1IzQ0hUbkNhVDMvaFhoS1NaM0syaXdQ?=
 =?utf-8?B?cm8xZXk1NXIrcHBvN205bktOY1RUV01aZjFSSmJrV3V6eVV5OHppcHpaTXNP?=
 =?utf-8?B?a3hWa3VWS2JVcTlWdTZhaWY5SzdRS24vaml5M29kVDNJcTNXUXJVVnlSZXIw?=
 =?utf-8?B?dDhBWU4yd2U0R2tDSnQ1UjZsWm1wV1RhYXo5N2xoYmUxVnZIV3JDc1RtRVA5?=
 =?utf-8?B?c2cyTHE1NDcyTWdJOXN5OHJhd01ueE5yTGlzSnN5OEF3TlZiVmFVOXV4WStz?=
 =?utf-8?B?ZERwaWlDdmtrdytvckZoV1BTYkljWjNiQ0RTdThGUURlQWFtK2h0OFdLQXpO?=
 =?utf-8?B?Z20rN3dEdjREd2hVdERVSVJpQTJndnRzOEh1ZndJRVVQVXp0QkxWTXQyUHhu?=
 =?utf-8?B?S1NPeUpnbUcvL1J3TzVzM1M2MEdibkMvSjV4UzRHdGhDcFRBU1RIWUxMWWdY?=
 =?utf-8?B?QXZSbFY5SzVFcTloOWlKNmpLblhzTmZjYkhyQUJ0Rk5MTUg1aDVkdVcwV0ky?=
 =?utf-8?Q?nGBOahEUjQKPLYuyh15DLd63V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41029f40-f9f2-4bb8-b853-08db085733d1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 15:31:23.2144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyyjrNPo5OCDk9gqCYsKG5OP1poKCDCP/rG+Muw8eRDdLiyWzMele6/rQRjd9mCNacSVTLjF5tUhKDje97sZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

Hey Christian,

On 06/02/2023 12:19, Christian König wrote:
> Am 03.02.23 um 20:08 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index 4038abe8505a..fd1c65d78ded 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -94,6 +94,9 @@ extern "C" {
>>    *
>>    * %AMDGPU_GEM_DOMAIN_OA    Ordered append, used by 3D or Compute 
>> engines
>>    * for appending data.
>> + *
>> + * %AMDGPU_GEM_DOMAIN_DOORBELL    Doorbell memory. It is an MMIO 
>> region for
>> + * signalling user mode queues.
>
> Drop "memory" from the sentence. The key point of doorbells is that 
> they are *not* memory :)
>
> Apart from that looks good to me,
> Christian.


Noted.

- Shashank

>
>>    */
>>   #define AMDGPU_GEM_DOMAIN_CPU        0x1
>>   #define AMDGPU_GEM_DOMAIN_GTT        0x2
>> @@ -101,12 +104,14 @@ extern "C" {
>>   #define AMDGPU_GEM_DOMAIN_GDS        0x8
>>   #define AMDGPU_GEM_DOMAIN_GWS        0x10
>>   #define AMDGPU_GEM_DOMAIN_OA        0x20
>> +#define AMDGPU_GEM_DOMAIN_DOORBELL    0x40
>>   #define AMDGPU_GEM_DOMAIN_MASK        (AMDGPU_GEM_DOMAIN_CPU | \
>>                        AMDGPU_GEM_DOMAIN_GTT | \
>>                        AMDGPU_GEM_DOMAIN_VRAM | \
>>                        AMDGPU_GEM_DOMAIN_GDS | \
>>                        AMDGPU_GEM_DOMAIN_GWS | \
>> -                     AMDGPU_GEM_DOMAIN_OA)
>> +                     AMDGPU_GEM_DOMAIN_OA | \
>> +                     AMDGPU_GEM_DOMAIN_DOORBELL)
>>     /* Flag that CPU access will be required for the case of VRAM 
>> domain */
>>   #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED    (1 << 0)
>
