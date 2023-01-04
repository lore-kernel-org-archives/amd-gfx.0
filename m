Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28195C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF43C10E216;
	Wed,  4 Jan 2023 14:35:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1388510E216
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWgP/XK2mBOl4oHIWptVKqcxF8bPeDST51ncgnziqthQIlRQMbStvKF9YhbLocDHHeP//XWd+Po9bZT2CvFn4Xp/QxRtPivj8YkJeXWGHHlud3us+KDnhqWG8nugrAh6sGaB08VDQvuTaJ17geosnwPhYn882BbW3SNW69pGtAuIOLJ45TI/7h6H0h1WRtCYOh+F9L0IWWaUBXDA66yRDhZ0D3hQ4KHUrnvCajL/0YkdjaZcgvxv1Fb4xNlJRD4M2P1OKzelXZMuiYwJ13H/olOfQ/j6HO8kUH3pakt7QEYLx18no9g2pLidvOC2+I7985kAlyrMByiSDQXcCTitig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mndcDRWcMJpqb4W/FhI3ymKidDRQeC9Tm2PuKYKPbTo=;
 b=GOMHq3bCiGCkcWeNd9CJfmQDG0Q0p8o/Vh6POZ6YpQX9Y+ZGvOJ3O/+QSa+jdKKhXh948oN8yNiMYpxrtidH6EEvuSNoylp289FPXQIPNjFLdAG5r7CYw9LxTMYii0O5U8lDO8zU6dK0jymcHj3Jkgxvdn32rrt4CBU2zRVPgNqQkvddAWSKuo/LohSaHycWDMcnkUr9G+jW4qMHsdOMZHJQa8vLm2IhxaMHLg+Tu4+6+SLcGZOhJ/T8ENw48HPV1G/kuP7Cv8Y+I0PrZS5w7t7GGyrVpp6KeL65uQAYcQS9Tn5p4NhQ8Y22p+9T3yKKRtHw6JxMBj4jehjQ2bsn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mndcDRWcMJpqb4W/FhI3ymKidDRQeC9Tm2PuKYKPbTo=;
 b=W86gUXlyqC0pVb/dFrMI/kNdaL+f4ydaAnO1MR9k9zN88M2/NVCk2nOarl4vIklH6h6Q4c5HbMUt4REV0/dWHnW0gumUj1wwZ/7dNEUUJrfvgJWHrLT14nq/8iG36otEt5jepaGkDx3hZW5LGWTLPs5unYvK5CVYbJcJH/TVO+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:35:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:35:26 +0000
Message-ID: <b4a601d4-4d08-fea7-5eaa-772194fd6b1a@amd.com>
Date: Wed, 4 Jan 2023 09:35:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yadav, Arvind" <arvyadav@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
 <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
 <a168df59-8cd3-0262-473a-c4b5f63dc491@amd.com>
 <ced7bb3b-6de2-145c-ccfd-1143529f0990@amd.com>
 <8b00b4b7-640d-4a85-b98f-8fd2a277bea5@amd.com>
 <393ab51d-c4bc-07d4-7502-884d188a61d6@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <393ab51d-c4bc-07d4-7502-884d188a61d6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 55910a26-411a-4915-af85-08daee60eb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/f1++A7p3e6CmXW2sFIjlaPUATqqF9r5Z1ZwKyxsT8VZpYBV7gXG2HVu3MqQmFos95zPSo9lRNv4KDP8IFxs02gslYvswwkS6VU+P1a27oDEykaNu8mxhYOjk4IQZPy2+QMiKXphW0mFBza6DzRbVXpaQ6z4M9F0D6nUNysPrrvdEMdiY8di5qTyFKI3QwItNUZ5h1KvM3KSRNsPWJzB6bVbS9z78ZzVXv+CqgV+nGgLCAOQILbyg6xckVMRJsjTrZmH/qMZITRScSVjuy+MqSMSTEFQsdIeT9BWqiQ436ykwXj3V3oqZh5To9PvxYWPD2ygZhVT/pHPgUeKFsbPQrHGKhbMtZVeJFkCkCng6un1thavhnBxfKreoZWRM7Vkw3V/gGqibA4pTaM62o7A+rKhz02hnuJSHwELnHpDOjtZ9di8f7cKTa794FPay2TdNDZeHMGSdtImCleYEgtkMQ5PDNup3sNFLibA1PDt1F3B/mfmsp2Czfxx0JQTyGiPmAS46pVaXooaOKRHF+3MeoRpBgbx1moDKE4ey29GlBzsJT35dqrjw/jCSoSaNv83Nc6A+tM7uxexVki+Wmh+2amZz+1WRi+4bLa0Xj35nI7FByvuWLA2IZKf1fjrRgnugysox7Yrk0ZdgjXK57iFVk8injilorgkPwKxoylaP5Lr260qAoP+jAQShx98b6FamhtiQ5UK7ojqHDdOnBDou7NFASQIQMC4vbnOZNmYAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(2616005)(6486002)(316002)(186003)(26005)(6512007)(478600001)(36756003)(86362001)(6506007)(31696002)(53546011)(110136005)(31686004)(66574015)(6666004)(41300700001)(8936002)(44832011)(2906002)(5660300002)(66476007)(4326008)(83380400001)(66556008)(8676002)(38100700002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFrZmJMeVlZejlORy92U2xldUFyMm43K2pzWmNpeWhNcTdSQmVvMFpJMGVo?=
 =?utf-8?B?N3NpYW5NQ3dmUzB6aG5NbW1BSEFCWUxpNXF6TVpra0REM1pSanhQR0htTHN1?=
 =?utf-8?B?ZWV3TnBDZVBPMUI4dFR5bUpnREx1ZlNQWklzV1BpbTFhanlPTm9oaFhIWVpZ?=
 =?utf-8?B?eEwwVUNLcUpmU2lvUE1nOFRJTllyWDdhVmp1OWhNTE4yR0ZQd05RVTFteS9O?=
 =?utf-8?B?dEMzbnV5TC8zTmZFMnFqa3hUb1ZveHNpQWZiNTlURitabHpsY2tNQnZ4V0pP?=
 =?utf-8?B?cVNYalliY2g3TlhnalI1NkpnWHpjK1E4bGVRVFdVUE02eFlpMEtsM3Vvd2ZD?=
 =?utf-8?B?USszWUVSZlVNc3ZITGlET1NMaXFiWlo3QmdscVpsWTlJNEVFYXdVRllDOURl?=
 =?utf-8?B?eFBXekRYSlhXNERsdWxpYUd4bjI3VVdWbS85UE1hK0Q3ejIzZUt3aVZEYzdE?=
 =?utf-8?B?cmI4ZVUwSms5THowNFdXM053YUdFTlBNQmZwOXZxQnBsVStLNW1KVUpadEEv?=
 =?utf-8?B?THovRXhuOGIrNW1XUnRRWW9uYU5sbXZRUTJRbldxTzRVM0FvSXg0cUpOOTho?=
 =?utf-8?B?TVB3MXg5ZDZGSTlrVHRyRWJ6UXM4aXRHdnhRUi85dXBoT3VZcWlGODUzRXpF?=
 =?utf-8?B?NlQ3d2RReW15UDI2ZUdyZW1qWjhvNjBWSWhxWkYyTzQ3R3d1SVVCbHFrQ2gw?=
 =?utf-8?B?OVlHcUhoZGhLeEJQQUtRbEtuNjRuS2tka0ZZTHpXbk5SUS90djE5SU51Qmpu?=
 =?utf-8?B?WHE4bGw1bVA3WlRQeTZ6VWhWaGlraUxzSyt6NUY4SkJiMUxRN0w5TkpmTmY5?=
 =?utf-8?B?WlVMNUc4ZXdDMEs2QWEzU0dJczRhZmlzZWMybkY1dGxRVmE5UTErUmlpa1Zu?=
 =?utf-8?B?Q1FRYll1dCtkcE5MUHM3WG11VmNTdnk5ckphaHBwWTVWc0dPMFcwbjZpbEdE?=
 =?utf-8?B?UEtBZ2NPdGN4Rm82aHNnc0U1UkZycWNpYWhMbHZWUnNHeDBtWXhFSTk1Z2Fh?=
 =?utf-8?B?aHBhZlJsWUlQamFieFJtVTBqRU1IYm1RREN1cVFoSFd2MGJrdnpCeXdvcTZH?=
 =?utf-8?B?clUveCtkY1k1RHRMR0RNSFRDQjVoUlJlc0RKNDlBclo1MW94Ri9rNmRrd2NM?=
 =?utf-8?B?SUtyM09uSEgxNWZodzNOV1cvVVlwSm1qa0RrNFU1SzYxS2dZMzIxalhRcCtT?=
 =?utf-8?B?YWk1dXJMUHlUcGpBVi9xVnFXUUlkMFNmSm03NG4rdDNiVDF0Z2l6RlE2ZnBS?=
 =?utf-8?B?ZXlZUm1KS2h5UFN3Qm9KdHZadWtrMzRGUVNoTDA5N2dIUUJtUVpXeWVsY04z?=
 =?utf-8?B?YjRTODdwU3dPWE16N2g5QjhaQWQ4OFNiZDRoYkdrdHRYYkRXc2NvMjJZS0Q4?=
 =?utf-8?B?L0pnbGR5cWx2Y3dqOTF5allxWWFXSlhpd3FERmJpbG1LTWVWQ3d0anhPN0tL?=
 =?utf-8?B?eGpxalJUWTBMbFZHS2V0U3l4RHE4UEhLOXpNai9jY2ZxTUhrd2FZVEF1K0lu?=
 =?utf-8?B?REZTWVoxUzkvNm4wdHBQQmhwenRnSUxqSGlSR0hqcEYvaEZhQjgxckhRYWlU?=
 =?utf-8?B?WkNoR0RKVDV1Rmtqd0w4bWRtRlY4emZXWW5oNTV4MnBBMENJY20zNXNmVGFw?=
 =?utf-8?B?eEhabmhGRzRlVVhNS3FiQ2d5T2xZUzdLSC80eSs3blROUnJUdkhIeHZINisx?=
 =?utf-8?B?MFd5TXE3TlJCdlJaWUxYQzRTSE1SYlpPS09aWnRORkxrNE84UzNJaXVJOGt6?=
 =?utf-8?B?K1F1UzNhT2VwSjJFcW4wVm9tQmdDREEwcFMxUno0THFkU3pIWDYzNllJSHFX?=
 =?utf-8?B?VklnZzRETnJyWHB2aTVOUVJBS0tnWTlGN0xlTlgvNGwwVlZ4Y2dUbUhjTFNQ?=
 =?utf-8?B?NlFUV1JNSEdSblBQbmtHWkVWclJTenhuYlJwVlVTRmx4NUt1UkN6RlUvWVlo?=
 =?utf-8?B?WTJhNkZxcDhIdDZoQThRZXFaYWVxbE1BaWJINmxzbkpkYjNONEVTdFRoYUxr?=
 =?utf-8?B?M2JYcEk4QTU2empkZzJWdmErendwWExPYk1mRzNWR1BwcFRldzNBUWFXNUR1?=
 =?utf-8?B?d2VMRXEySzAyaUVCZ0RxM1F2MU9GbENkOHYzZkREekxWazZGVDRYUnM5WjU1?=
 =?utf-8?Q?36k3FDcoznTWisL91gsO/W6A3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55910a26-411a-4915-af85-08daee60eb3f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 14:35:25.9310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWrPbqLkOuxacTgoBvRwNqY6hlOM0rll3TpFh14xuZRetlfWSSqG4Oz9doO7apTiDGpJ2+tdwpnxJC1iI9mb2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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

Am 2023-01-04 um 04:23 schrieb Shashank Sharma:
>
> On 04/01/2023 10:17, Christian König wrote:
>> Am 04.01.23 um 10:13 schrieb Shashank Sharma:
>>>
>>> On 04/01/2023 10:10, Christian König wrote:
>>>> Am 04.01.23 um 07:21 schrieb Yadav, Arvind:
>>>>>
>>>>> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
>>>>>> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>>>>>>> /*MQD struct for usermode Queue*/
>>>>>>>>> +struct amdgpu_usermode_queue_mqd
>>>>>>>> This is specific to GC 11.  Every IP and version will have its 
>>>>>>>> own MQD
>>>>>>>> format.  That should live in the IP specific code, not the generic
>>>>>>>> code.  We already have the generic MQD parameters that we need 
>>>>>>>> from
>>>>>>>> the userq IOCTL.
>>>>>>>
>>>>>>> Noted, we can separate out the generic parameters from gen 
>>>>>>> specific parameter, and will try to wrap it around the generic 
>>>>>>> structure.
>>>>>>>
>>>>>>> - Shashank
>>>>>>
>>>>>> Is there a reason why you can't use "struct v11_compute_mqd" from 
>>>>>> v11_structs.h?
>>>>>
>>>>> Hi Felix,
>>>>>
>>>>> Yes,  V11_compute_mqd does not have these below member which is 
>>>>> needed for usermode queue.
>>>>>
>>>>>     uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>>>     uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>>>     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>>>>>     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>>>>>     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>>>     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>>>     uint32_t shadow_initialized; // offset: 6  (0x6)
>>>>>     uint32_t ib_vmid; // offset: 7  (0x7)
>>>>>
>>>>> So we had to add new MQD structs.
>>>>
>>>> Would it make more sense to update the existing MQD structures than 
>>>> adding new ones?
>>>>
>>> Imo, It might be a bit complicated in the bring-up state, but we can 
>>> take a note of converting this structure into a union of two, or may 
>>> be renaming it into a superset structure.
>>
>> Union? Does that mean we have stuff which is individual for both 
>> versions of the struct?
> So far it seems like Gfx MQD structure is a superset of two, but we 
> have not compared them neck-to-neck yet, hence I feel like we can 
> defer this task for sometime (but add into to-do list).

v11_gfx_mqd has these fields reserved. Updating the definition with the 
fields you need should not be a problem. v11_gfx_mqd is already used in 
gfx_v11_0.c.

The firmware shouldn't care much whether a queue is a kernel mode queue 
or a user mode queue. The MQD layout should be the same. So having two 
different structure definitions in two different places doesn't make 
sense. I don't think it's wise to leave this for cleanup later. That 
would only cause churn and ultimately more work than doing the right 
thing in the first place.

Regards,
   Felix



>>
>> BTW: Could we drop the "// offset:" stuff? This could cause problems 
>> with automated checkers.
>
> Sure, we will do it.
>
> - Shashank
>
>>
>> Christian.
>>
>>>
>>> - Shashank
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> thanks
>>>>>
>>>>> ~arvind
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>
>>
