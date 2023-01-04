Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0081C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 09:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D80D10E503;
	Wed,  4 Jan 2023 09:10:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845C910E503
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 09:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdlUxOyqW25l9nmYkdXuHyic3wvifhn6agwLVecWt/MinWdtlQYxqvHMZJb5Pkv86rJkqHyx6ZWg9PJXTHETQHtepTnSjaKV2x1kjyD6RJyGzxT1jxHC4PZX1e4fiXLB4AXz09J1fCw7sS0z5zs6KeaSaHWN4SKh8IJ5jr4p6Xj5b7ZXSfuL5q+37hbaEeTKOL1vpmGJvRSKn4bj4RbPq4K+tKQtfuGU0vytaiDySnlXXBbL5VqhrzOl0E75giJ65OOhr0kIAn6DClrR4jvgG5Dyn+AVitFZVKjDbBP5EqlgWNi6+TVP+fNe9riH70PND8no2lxmfkGrEyMLlR9CkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhsPyXuyCcaUGlgq1k+XC1enhZSDUzLdOCKgd1XzReU=;
 b=EdTl2a3t9pJpk/aQCCN24bDx2VwLqXGMbcnsEpsmeJbLayiqJE7bwAy8YjaunzkLfDBSzjVWTBXWoHBQGMm+blGkERvzliLeQXn/lKgtp0GA+mxU4eJ9DSOWKkhjwxN3zkSvSmPOhUToLHDvWHOzKQ3BQ0fWBMCGB4TuNWdoZ+ULM1U9P9RyUEU/+6bku21V9wgno4To0GaLgZDkt17pB2B+YtFjfImVcTrsAk9bPsNrrAFOP6ybyvzCLc9+mO0hce05Qr1HMnRYkwaIX0lzOAm3j99LYvfCMSS58umhlc2COmC7tQPZKXWEfspJlCeOMbCEZVk3brP4heFCBZtPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhsPyXuyCcaUGlgq1k+XC1enhZSDUzLdOCKgd1XzReU=;
 b=bzUCzombHyFSwc9tTypeLccxaBPXjql4hllI8Vp40N+KV3eN79KlfjmK01hkVfgn7VtY1fPFvp1fgmy3+plVxXqmX8DK03rWw80ajL+AfOJfklobRQIxgNVaNQcxE+nn6QMhVbebRc4LoNBzBJJEm00fWXOaJwsP/VNhZeD7F8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 09:10:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 09:10:15 +0000
Message-ID: <a168df59-8cd3-0262-473a-c4b5f63dc491@amd.com>
Date: Wed, 4 Jan 2023 10:10:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
To: "Yadav, Arvind" <arvyadav@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
 <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: d80be9c7-8233-4acb-19c0-08daee337e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPWW5MTIU8mfoZl6SbjC92OeZU620h8J80v3K+tSEwv75Gfqa5RreUFu37ptL5IzGXKc81oIuHMkbcFaDiKabJe6gTwhf/0FqCWGuzKhO0zPsd2+lQ9DpheL4sWtznz7Kp65+GEhbPVz1fciizWbsg/SlFaHGSVKY26wmxdD1erWlIACs+X3MerBcuxRzxjKwlnaJ04MUkhQ55ph1ldZNKrj+cv+hQrjsQans6mbY66FRqNlzjMWxb/mymbzcQq7m68xD+PdRlbZ7RXRCiuFvgISyuxqqgjVn66gxHVdGKFvpGznJNDf2uq4FfpaoXA+P7FI0JLYwj5rcX6SY9RZJelkEaVOSwYTwddQyV2jijDOuXjXIk+5AOJTF1xjMFVWrVLv7gStvF/JlkTvjDf1eKog0NgTE5HW5OJYe4SOrvvKer65XGztD/GAAOFUelQQohw24DbvD4X20Fge9JGNk9A2TwQ0Aaz5Am9tdj/QEOzGMtdnSOHo9eZFjNeXMyGDIzGtrcg1TWaRx/nYys2dJp6ZgHfgV+ilzvrcbZHHClQ3y234GkCS3aqB+xK9DkZOUItKrvvdlHpbkZ1EoiMj2NiiXbEguzjD0JoHoBaju0Gm69zN3KYF7snH5rUwIF0V7BbRk+wzIwj5jxGygLfUUVGBOWtWkzGZXTqwTrjyiWj/Lixx1A1o01wC8cQx4jSpZZivwR7xW+4Tj/x/xUSp2t/fCtqXTxtBHWhEjkMX5Bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(6666004)(6506007)(53546011)(83380400001)(36756003)(478600001)(110136005)(31696002)(86362001)(38100700002)(6512007)(26005)(186003)(6486002)(2616005)(5660300002)(31686004)(8676002)(4326008)(66556008)(66946007)(66476007)(8936002)(41300700001)(316002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGFaMTVYd0s1b0EvUkVxNW5KQkFZSkVocGFQdmY3bkc3bmZrTERWWGMzTEJY?=
 =?utf-8?B?Mjdvb0xlRGRkU01GMHFMWlNJRUxsVDJZVTZxcng5VCszbnRoUk9zUVZJTzEv?=
 =?utf-8?B?allROUV6SWNFenRXQ1NWU25Lc01SN2NlU1ZJSFp6SXJmZlRxam9IeGJmeDUv?=
 =?utf-8?B?K21IcnRaNzcwaXFvMjk1SHZCclpYQmVLa0liWlNZRUo0aUxEQ09xR3VoRWhD?=
 =?utf-8?B?Qlk1QWdNRVVsVlpCVWg1OHEyOW1tVjV5UzZ2MHdzcVRENmFOUGNhZEMvM1hX?=
 =?utf-8?B?OTZjai9KNjZJQUFkZEJhNXFQZ3VsSWViN0RsZllvUDBNWlVhNEQ3TkprbjAz?=
 =?utf-8?B?UjZmOCtmd2VJUVYrTW0rdGpCaGZrazk1MjZJRCtHb1dCaHN0SXFqdDFKdVNk?=
 =?utf-8?B?cVdPNW5kZEpXWUNYUVhrYnlOVFh3TUJ6RW80bDlKRkxWR3l2MWw5UE9VcWNS?=
 =?utf-8?B?dEpPQ1ZZazdjM0ZvNlorbWZVQ3hla2ZXeFNXUWN5T3lXN1RvNnFpSkJJWEVI?=
 =?utf-8?B?U2pMUmQ4eGpVS2QrdnR3dFp5Ym1XdWFvU0J3N0hPekYydzFXV1dicG5vdHhS?=
 =?utf-8?B?OWhuaVhGWS9YWGtwamRZR1gxYzNud2ZaVjVIV1NLRGllaFgweHY2N3dQOWJH?=
 =?utf-8?B?cFdkS3VQcnc2QU10YUoyMUp0Y3pjNjcyVWRkQmJSNndNb2NGV2cwenZlcDUz?=
 =?utf-8?B?WTFwRkk2UElLUk5TNitXWmlWQXI3aW1vWDQ2dTh3MTZDdU5Qd3VCck11VHVH?=
 =?utf-8?B?S3pZZjVWcjN4Q3J0YXVHdkgrN1FkaWF4VlQwSlBWa1JpNU4rS2lEM1gvemda?=
 =?utf-8?B?eW14N3hBeTZVcEVHRUREQXlnci9hb2R4OHluTWUzZFh2clk3bzFYQVBjQlNo?=
 =?utf-8?B?QUcxWDlXMkdsOWc1c0dwQ05KZHVpMVNwOFRrYmxOUncvYzRkdFhxZXRkQ0hI?=
 =?utf-8?B?cmVnbUQvR0kwMXg1UVZFMFQwRUF2d20yRklXZ052dklRaG5LS2pMLzRNaUJR?=
 =?utf-8?B?Ri9UZ3Q5SzhQQ3VMd1RrT1VuV1lkc2l2R3RVWldjNUFXeGU2cVFLdTFhQVY2?=
 =?utf-8?B?VDNjQWNOeWRhUTNLMG0xdHhpaUhLN0JWaTI2K0F2WWtweG5SYmRxR254V1Na?=
 =?utf-8?B?WFZuU3FKajd3UTN6M0NaZFlsSTFGNzJEWERXdVRvUnBZYkRJRnlyQmdlMVdP?=
 =?utf-8?B?UTdwcnk2QmJ2bHY3TDRrRCtkcWZtS0ZiTmY4dGo3ZnRBZ3U2ZmpReS91b2hJ?=
 =?utf-8?B?ZU1KNTlwdEk2NmhOZXMwM3JXRFIrM1F3TEYyT1RYKzVtV013MlRNU3VyVmhG?=
 =?utf-8?B?SEg0allZTk5lUWg0aWFvL2U3Y09UbUtXRmkxeFlKQy9LYWJZd1UvZUFyZ2Ry?=
 =?utf-8?B?cFFXbkdBc3NreUlRdGpmYjRrS1pMVVNlbzFXRWVNVVp2eWc4Nkd5YmdJSGdT?=
 =?utf-8?B?VGdkZEZNQkVJNVlpQ2xXNUJaY2NSUnByOElQUTh1dWtONFNoRW9ZdUJBbmM4?=
 =?utf-8?B?ajMwRzJRTnJIYTd4YVp2UXNOcWVzOTh4L0FSZVhhSnJLUjFQajVOQzlYVzVU?=
 =?utf-8?B?WVl1OVB2cnErRDVMajBpMHM0V0JLZFpiOXRmazdjQk55c3JzYzdoREtyNnkw?=
 =?utf-8?B?b2pCelhJdGJVb0VRRXVuT2ZhaTdFOCthb0xRNmh1M0lWcHZVY0RTYm5vRlZN?=
 =?utf-8?B?NU1Bb2Q5amc1RThyMDBoWXFyL0JGUnJIU0FGRGhVZ3dGd0twQTUrbFcwaHpn?=
 =?utf-8?B?cE5IY1pQWmdtdEE1MGs5MTNBWjdudldxYThqWnljVWZEYTJQQ0NUejhRUVc1?=
 =?utf-8?B?Y2lRUnhac3dFNkM1NDlZRnVsM2VUQVNaYnZBbnI1V2dJa1Z4dnVSbGl4VXVn?=
 =?utf-8?B?R3M1SVNsd0gxaTNpT3NBbkJUb1JGWjhlajdHZzgyYVdDWWZHbklpODQwYmZx?=
 =?utf-8?B?YzA4dU9INXd3TkVTZm9SVnA1NjBiNlpzTFFBTHVqa09qVFZtRThManBoTnUw?=
 =?utf-8?B?MmIyeHdTSjNwb0N5S1Y2Z0p2WGlOaXI4TVhqMHV4NmdiMmlMSHVTZTcyRXA0?=
 =?utf-8?B?SG1Fd1VUZS9aRHhUYld6QThib3V0enMyMzFGQ0RkekdGM1l6RXFQUGs5ZmZi?=
 =?utf-8?Q?BRvCDUBQJFEZz0P2ujSrJzVKd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80be9c7-8233-4acb-19c0-08daee337e10
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 09:10:15.4729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Wk4lsoOu10QivlToK/x08V7wc1quRZL/DWA4N8t6R3+FisUNQpuWIhwOfw7GH+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 arvind.yadav@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.01.23 um 07:21 schrieb Yadav, Arvind:
>
> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
>> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>>> /*MQD struct for usermode Queue*/
>>>>> +struct amdgpu_usermode_queue_mqd
>>>> This is specific to GC 11.  Every IP and version will have its own MQD
>>>> format.  That should live in the IP specific code, not the generic
>>>> code.  We already have the generic MQD parameters that we need from
>>>> the userq IOCTL.
>>>
>>> Noted, we can separate out the generic parameters from gen specific 
>>> parameter, and will try to wrap it around the generic structure.
>>>
>>> - Shashank
>>
>> Is there a reason why you can't use "struct v11_compute_mqd" from 
>> v11_structs.h?
>
> Hi Felix,
>
> Yes,  V11_compute_mqd does not have these below member which is needed 
> for usermode queue.
>
>     uint32_t shadow_base_lo; // offset: 0  (0x0)
>     uint32_t shadow_base_hi; // offset: 1  (0x1)
>     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>     uint32_t shadow_initialized; // offset: 6  (0x6)
>     uint32_t ib_vmid; // offset: 7  (0x7)
>
> So we had to add new MQD structs.

Would it make more sense to update the existing MQD structures than 
adding new ones?

Regards,
Christian.

>
> thanks
>
> ~arvind
>
>>
>> Regards,
>>   Felix
>>

