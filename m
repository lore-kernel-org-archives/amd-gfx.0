Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157DCC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A477010EE8A;
	Thu, 30 Mar 2023 14:38:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFF510EE8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxdbdimNqsWkCiC84Y7xS48uFInChz+tE3AyZ8DNarm+S3pHrlYpN4i8MXi59HAibAHEo5uyIBwf3ZrUcXX69s8jSVHEm190AEHf03lUdgVFHzo3Bg/tx7I+4wXhiP7WsU4itUUvCeeEz8PAmmKQxOl9yd9U91LDj6eqemkGJ8gFYVOqn4FC6YDD2ctDhKqr2ZWTUs89kat3LzzXZKjVVLfyXbRZhMTB3zLc50jUtMAskOBSFZJk+w3MQ52HHN4MHw6EriTGUnr7D++cXkI491wfBwmgY9XqNXTeBnUk8ORK98S6xvVqfjFcJL7k0tODxJ1fDT3lGIemTdkH5hod1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93uwY4GsVHbEXnN2W1uVA9YCqT+HGzIf1ZBFVVoM8fQ=;
 b=PtunIPrhCA7+VmmUoKHz8RrhbWEHQnh7QM2xfIF6FoU9L39wDVJky28wKVj0YnwSI4CCYGxOsD2K4WAZwk5VQvC83RMJ+qgq5wor7tbHC7bfTo2NE4v1xf0o/KwCCLkqqVrPCeiNcjudCFDq967BGgmJSQ0SfUT3SI2880DdXHAFGYLMjqfrZ8Bl0exmDGtnh67a+1uaL8Dub6YVei3CFAoAvcQ9uhKNTy4dMkJ9OOf1TlJUpQOoyRXxFH/2UaiFVC/vQmFDcpiDjqyPJjt2jU9dfgl0qmGsudJwwcUD6NrUAGwsj89/iWO/R7mATRi35pa8J8E4Neo6Hn2XHuxy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93uwY4GsVHbEXnN2W1uVA9YCqT+HGzIf1ZBFVVoM8fQ=;
 b=JuDlNmoHruV8HHMo5INy06re5h5yGm9qFT/Pr4IhlF4EFDYJSxuk9kIghap8JJ9UxInlUaVCGEFMAVDM0t537K2NwR7skXtMxj43Rz7Rp7lmu7SvxhCrYnQa0GmqVfNkTxTPBjoTfABa1H8R1CzBMNWq8dxIqeqgOw1ZaW4PoPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 14:38:42 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:38:41 +0000
Message-ID: <c6a3a088-dac5-e045-7c11-b8090745c3cc@amd.com>
Date: Thu, 30 Mar 2023 10:38:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <CADnq5_OQzuYWPP3Mr7g349+tBa6-HT25xn_o9N_MyEgG5gewLA@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_OQzuYWPP3Mr7g349+tBa6-HT25xn_o9N_MyEgG5gewLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::32) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 445fb1af-bb8a-4424-d677-08db312c74cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qqo1+pu1QHQOf886Bstf0Ujs3ORvI/IuNpU68HZZI8oQSYZYIbN0a292roS6f6wlPlKYYyg+bH7IoKzf5AQeTM5W8/45Y3dh4FPnrBRI96PMSTlfT+MNcglkaywdXjWno+oSZJrMVG2C5syhwMEUfpimx6d3mW/83DsrE8EfdHBpLgdsLMSenOSTAmQwf17NUrBoRZvaTGwLwsC8y3lsE3w34A1TwQSK42TWKZCzjphJzxSKGTIkTiDfwMBseonAkgqTo+HyANlkTjG/to7pb4UQaUkpBdg6B+hZUDzWt/C9mbXLl0j41XsNmhGNjNYGLo8eQQK45j9T2rg3hldKvcFeeLH9n6plLJACJZo0MyjYw38wErUmF8h7s9JlzG7VAHI9H/JDqJDTqmLE8uQFRMWVFJDwdpqMkpXLzquhR1gKq5noV5reB65G4Xh1/06sgWSwk7pYvoJSrkK6mRCo+03R6r/QpsFrU3ANpS4epldP/Ep9mrZTfiIkBc8Zkfp7crEK6yej7jyUVlHz6lALhJoGbLms8hI1jXl29puteUVK/DIeRlGAQXBrE6hXeUIzgsraHRJvl6OjJ9raOE+Y0Jw4ZT7ETOaRyftOmuotyvBm2WdygHVNYq1RKoia1I7i7N0Q5NZjNqNoH9xLriP5Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(54906003)(6636002)(31686004)(186003)(6486002)(31696002)(478600001)(66946007)(4326008)(316002)(110136005)(2616005)(6666004)(26005)(53546011)(6512007)(6506007)(66476007)(66556008)(8676002)(41300700001)(5660300002)(44832011)(2906002)(38100700002)(8936002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXdzQzI1OXpZUWZGZnpyNTREYURCUXJvS085MjByZHZDa0NqS1Exd2JQN3VR?=
 =?utf-8?B?dHU0T3U4Sng3alVydXR4cGJKT25IME9YNWxuVkxlSE5jNmxFbnNtVGM4aFk4?=
 =?utf-8?B?SVRSMWx4MUxrbG5oUFRYTGxSWkdIcU5jOGIrY3RqRWo2RFJ0dlpZU0hCb0Vl?=
 =?utf-8?B?dmhXMGZBSkJ6bGsyYmlYemhjeEhLT2lvdjNiNThsYmJhVVgxTSs0ckRkNFly?=
 =?utf-8?B?RU56cThNc29BVW90RDg1YXJwREFpa2kybGZIdTdmckxoZExhRUlIaGIzRTB0?=
 =?utf-8?B?N0plZVBRS1NJb2VuVUw2a2R1dW54OXNSY08yNHdLZWNIQmVTMk9MdU5oYlhy?=
 =?utf-8?B?NVBHbDhXSjVOR0xlMWYxY2VGV2YrSFhqbFpkd2wrMnFsOFFlTXFHVFNSeHRl?=
 =?utf-8?B?K0Q1Sk5nNUU2SStReTNua0VHVUhDaG56NFNYOVpSOE5zbXRyMTczbG10L1B2?=
 =?utf-8?B?dlpFblFSYUhyajhpd3BQVW84VEVQYVJ0NnNpWEVlckdaZkVuSzIwSFNSZDRI?=
 =?utf-8?B?N1NweUhubnhqZnFTOU5Jc1A5SHp5aDE0QlM4enBZOWdIc0Z0Skhwak5EMEI4?=
 =?utf-8?B?SHVPU0g1MHNub1NNYncxRnNlU3hFUXB1UUFDN1VlZTVLQUdUNE04eWNoaVYx?=
 =?utf-8?B?RzJuNGRiWVNtdUN1SFM3ZnVUNDhWbVU3dzRrcVRZcHkxU243V3ZVMk04ZGln?=
 =?utf-8?B?V3YwY3Roc0ROalhDQjdpbWRuZWwyRXRBajVqeXAxeUNPb0lNb244eWVKVy9w?=
 =?utf-8?B?NERHNVI5WUM1aFRtcDRPa010R01uUWtEWVpPUjhEV1BaenRqLzRWQWpSQUZk?=
 =?utf-8?B?YWwvenVNck9WWkR3RFFXelZvb1BoRWV5SHQwUUhHbWlRMFB5czNwd1hNakI0?=
 =?utf-8?B?cUhyd1p2aVVzVTJzQmdjR1lxaDFaZ3cyUGNTMFRkbnpEUWFWT2dLZ3hzSzNr?=
 =?utf-8?B?S3JNeW1WK3NpZUpxenBuS09lQ04xaHJPZU0weWJHQ0FhMnZVRFpPMnE2cktD?=
 =?utf-8?B?WlNqNEhZSm4wS0R5R1FSK3dHQ2tEYW5jT1JKZVBMckhXdkFtVlJDMk9WcWVP?=
 =?utf-8?B?UVMxYUxNcUFHWm1MNUpaeTA0Y1h0dnhTWkloRWpkLzJ0NHFkYmh5Vkd2T3dF?=
 =?utf-8?B?TjhYUGtFWVFwRzBVVE1sT3FwNVhjVmRYN3ZjOEpCQmdsZjZ5Ni81THlEL1RB?=
 =?utf-8?B?ZWRFcVJGSFhTZGV3VThCSTlIOGVWVk91elMwbDRIRWZRWi8yWFZLRG5vWnRs?=
 =?utf-8?B?aG9udS9DVlU5ci9La09IeHdKbXpOZ2FQNURZWTFHdEZiazZPOURpVjdMRWtj?=
 =?utf-8?B?Y2lqRXpBWVlXN2QwTVgwQ296MlZ5R2NvSmJPMUNiVVRZa0NXNjJGcFRvL1RW?=
 =?utf-8?B?NFh0dVQzeElyWTB5YVZiS3hpY3dxVmd6cFRuN0w1YitKd0dINzJRMDVlc0k4?=
 =?utf-8?B?djBwTHhXaXdoelBjNi9KTDN6QXByTThPYndlRncxQ0VLS3NWM00yVmttZHkz?=
 =?utf-8?B?eDQ3WXovTXpSS1JjZ3JtRG5YdUkzcU1GQ3ZRcWJOU3d3SlZ6anV4TUVDdTEy?=
 =?utf-8?B?MVlLSzdYcGlNL1RvQ3crLzlaRHdpSWlaREFDUWdkNVJSNkpMQzZJMUJHbkNQ?=
 =?utf-8?B?c0luMDcyTVVuby9FYVF2T0gxUVFpSzJQZlc4aFJlb3p0SmxWZDRjTitXQjRp?=
 =?utf-8?B?RG9hRzlKalErWG5YTmxuWG1TRmRya01ndFQvWDF4UkhjTGhvRWp6UkRiTE1t?=
 =?utf-8?B?aGZHUENrUCtXMGZteHBmcTNlL0F5VlZCUStsTWN5cEJyMVVodGpyZVdqMURn?=
 =?utf-8?B?NXUrQjF1Vm9NSXY0ZWI5cGRpL1pRczBkK0FrWXRsVmxXR0pOQTF5bHlTZnFG?=
 =?utf-8?B?dHJVTFNsTEludlpqYTE0S01WV3JUOTlLcTdlcW51S3Y5STc1NE4vK1hyWHNE?=
 =?utf-8?B?QTY0dEpNa3BsbFFiSWIwcXdXdVRYVGhTVjFiWm5GSFNsWTVpSG1NeGk3dU5T?=
 =?utf-8?B?WXpDbXFBRC9IRzlWWktEWi9xaFdNTWVUZTIxcmtMN1M4UkgxZ281ZE1zTUp0?=
 =?utf-8?B?MTFTTHFOWENLYXA4S1hyNjl6bGZkbXREYmdEZzQ1SkEwMVczaFhOTTRLRGl0?=
 =?utf-8?Q?eOv5+OkjxiZGGCYU8wAVBggMx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445fb1af-bb8a-4424-d677-08db312c74cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:38:41.3431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nM3qR9aQ4HzHCIib3mtabEHrOVuashtkNeGMhTZ4Jc8HENIlpquIQZYOUAjTeB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 10:28, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 11:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>>
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds helper functions to create and free doorbell
>> pages for kernel objects.
> 
> I think we can probably drop this patch.  I think it would be simpler
> to just use standard amdgpu_bos to represent them and then maybe a
> helper function to calculate the BAR offset from a doorbell bo object.

I agree.

Regards,
Luben

> 
> Alex
> 
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>  2 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index f9c3b77bf65d..6581b78fe438 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -27,6 +27,24 @@
>>  /*
>>   * GPU doorbell structures, functions & helpers
>>   */
>> +
>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>> +struct amdgpu_doorbell_obj {
>> +       struct amdgpu_bo *bo;
>> +       uint64_t gpu_addr;
>> +       uint32_t *cpu_addr;
>> +       uint32_t size;
>> +
>> +       /* First index in this object */
>> +       uint32_t start;
>> +
>> +       /* Last index in this object */
>> +       uint32_t end;
>> +
>> +       /* bitmap for dynamic doorbell allocation from this object */
>> +       unsigned long *doorbell_bitmap;
>> +};
>> +
>>  struct amdgpu_doorbell {
>>         /* doorbell mmio */
>>         resource_size_t         base;
>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>   */
>>  void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>
>> +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +                               struct amdgpu_doorbell_obj *db_obj);
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +                               struct amdgpu_doorbell_obj *db_obj);
>> +
>>  #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>  #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index 1aea92363fd3..8be15b82b545 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>         }
>>  }
>>
>> +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +                                       struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +       amdgpu_bo_free_kernel(&db_obj->bo,
>> +                             &db_obj->gpu_addr,
>> +                             (void **)&db_obj->cpu_addr);
>> +
>> +}
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +                               struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +       int r;
>> +
>> +       db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>> +
>> +       r = amdgpu_bo_create_kernel(adev,
>> +                                   db_obj->size,
>> +                                   PAGE_SIZE,
>> +                                   AMDGPU_GEM_DOMAIN_DOORBELL,
>> +                                   &db_obj->bo,
>> +                                   &db_obj->gpu_addr,
>> +                                   (void **)&db_obj->cpu_addr);
>> +
>> +       if (r) {
>> +               DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>> +               return r;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  /*
>>   * GPU doorbell aperture helpers function.
>>   */
>> --
>> 2.40.0
>>

