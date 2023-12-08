Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C802C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 14:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E317110E072;
	Fri,  8 Dec 2023 14:38:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9D610E072
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 14:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+Dq4tB/PKUZsbrqiyhaUegCKN83Ug04GL6K77ZKVyeIU+bGkl63xhx/F+/2CBQ8aAY+rto2r3Asuw8raaYfveklvIKWo/vFp6YViwhJmYYXNvvtYT1OUL5Hls1mx+iAHqas408Bj7X6MKDQvkgueUdKdKEvRSXGAC+nYBOTqMH/cpxLAiwpLePm1BmmZxaQQcdN6B4swwgzNSnzL15W9foupY+/GBnuuKJ//tOrVtT7K80wdZ2xN/Q2z97JUneWj8IFWZC+Whp2CnkCW/fM+XWf/i/mjB0mMPIpETitK23lqmhldN9c6T/FSBCmAbpTEuRXPfFBRck+eUCgoAn8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9NPvNkJbILbDJEMmiS4kYxKsA92Ig/3O4nLWB1J+so=;
 b=a6//6jEC1RHVGCgDTvTHImk6KjTpcnrD8MfdAvCzf0HDMsdoIQlZOpo/HfFtJ44UUL6IBrwiStNm2SNbceYVSX7h6bA8Mo7iyPJWeVjWCdOQNysRB4VkNDYNy0u60YD2jNjggaKE0Cl/kmRJrGNZuewWae+WJmXSp3Pk9dL08Wru+uomejNdjC3XwVvpfUyydA6w2h1c6LEQfZ0JxhRiJE3sKTlQIC6fNo4aAGbVcQwygGyXx9TfjjlZqdRLHeh0nPLp1IK8K97m0MBB34wvXJSJ3WuHeUKs4uIN7ANn0d2dCWTXBH7PGrZff/6KJVAZP3fzBTJOp2rNemasj+SYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9NPvNkJbILbDJEMmiS4kYxKsA92Ig/3O4nLWB1J+so=;
 b=lVt98AuibeTjjpLbz8dlbg1guFjhQVpVCXphFYzkV+o/IEWQFK7h+NkOsBtoLcbWb9BgFx1L7qTGt3z5t67z2CDz/wPdOkGwHA4yItpcg075Y1zDiOXzpnyS5QOPdHb+WvYaT2LH44NgagaQk9zPtmbL2v3J8TAAY6O2MizDfa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 14:38:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 14:38:07 +0000
Message-ID: <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
Date: Fri, 8 Dec 2023 15:38:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
 <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d2ab70-f78e-452e-7ffb-08dbf7fb4b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBCkMMXIHgNi7o0Qi+ROJZehJg5MY+9lEb/2PKQrxRWsZp2Qv1M8ol3P5M/zuDlSVXwG1QQ57tRcMXuYXOL5Qnn7Kz1tNrf7TLIKbVZpDismjDUNd/n7q225yY51P53Aqj+KTS+ypnGVWzUAdF8Yc9dla/5W4HBD6m1lCFEeSUi6SlceWHVfDIotKgM8uwaL820AQD1GXrjtiB9Bms/qhLWTaxdEsXO0g+to2a5hHNETxP158IzZIE+HqIsJTx40CbPnjCXeskFe0zg8yIHvJOpEFYpM33zA0nfaZl4/OwPwT/gDjjKOrROMztp/ocBs1qsJrxnQi4ZtdNxZvRh8Ulv1OSMASyxyHfaXDhCFKMQYWtgUsmVKBG0jqWuibtXiGhQHnz1P5n30yMUyOYfYi/Z5jcJqKbCYggyiW377qPqi0YD/vffQM8W1AXNPhqbOq/hlsCnxbJ3iqhndIoop64q19MEd7J5sjxgF6cckDV/411YMQ9cvsK534LId/3AGTWrP7fLMt9KOfIwGfyTVcF5IUSc+DGJqjyMnAbihG0JhGo47/6hTvjIW2DDOYZ9qHYTEtX+fCQ2XWNhlGkrgY4dPJsLNql3q0qR647kd9q5jQbcgWRGIuWdp9ouenXcghGFRh3zfAVFLUjWrvQBG2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(54906003)(66946007)(66476007)(66556008)(316002)(2906002)(83380400001)(86362001)(6512007)(2616005)(31696002)(36756003)(26005)(6666004)(8676002)(478600001)(8936002)(4326008)(38100700002)(966005)(6486002)(53546011)(6506007)(41300700001)(31686004)(66574015)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ZnQnluVW10Yjg0SHo4NUpQbXdTMFZzS0k4S2dqOWlnUDhxekM3bzdaajcx?=
 =?utf-8?B?NDc0VUx6Y2lLS3RaelB6bWxPTEFkZzQzeHZFTlkwRkx0eHBFOVVoakVZQ0Vn?=
 =?utf-8?B?S1lzM2Y1aEdDUTRPWEhhc0NXRmhlUjA0MS9EOERZNlA4M2RGZzkxdXFEMEsy?=
 =?utf-8?B?OTl6eDl6NjNBS1FhSGVRQzdMS1FrZ1ZsTFdtSXhtYUs3MzZWS2xXbm5TRWE1?=
 =?utf-8?B?a28xNTVtTUxUTW5rMEIzdnB5amV6T3pvWUdYVmtOVjBtK3RKUTBYeEU1aFIr?=
 =?utf-8?B?bldjakFVL3pkdWdmTXUvY3d1Vk1qYlprVi8wOEdKaXgvSHNaNHVpbUpDS0Y0?=
 =?utf-8?B?WTluNzlrUkcrbTNTdEZjMDFseGlCbjFwTk9JTWpKN0tRbHZ0YThwdHpYSDdh?=
 =?utf-8?B?K282OHpRZEVkaWF4TXVSNFR2TXRtdm5qY3d2S2MyM1NNOHROdTBDcWhFS0dT?=
 =?utf-8?B?T2V5UkRnVW9KMjFjWndTSktBaWlncUdTRGtBRWdRR0ZVMXlVbVZKZlRHQ1Br?=
 =?utf-8?B?VFFGS0haK3dKNU5SS2swYm00eVU4Ym9uY04wbUFvUlQ2MUkzUWNTeGUzRFNm?=
 =?utf-8?B?dFJmYzNMQmtjOTJhZG1DSDg0Vk9iRTNOY1psZ1E4cjVmMHYyWXFQQWtyS2c4?=
 =?utf-8?B?bTVqZnVMN0pJS2JpL0ZPWmsrV3hYVDJ6N3ZNK2RwcjZ0YjJZN05OSFFtZGxQ?=
 =?utf-8?B?YXU1aXprdUxOUVd5WHE5bmxnMUNOLzkweGVjLytOYkVpU3BZRkJEWU1Ya28r?=
 =?utf-8?B?SFczTlkvcFY0TVBYcjRFMXZZN0R2dHdVdkdKUmV6SEdaRkQybHAxaWFQTmpi?=
 =?utf-8?B?cGZsekN3T2l3aWlwRzlsd3hTNTZvT25PSVRVTXZIN1BMcXA3ckdmSmxXNjIw?=
 =?utf-8?B?ZkxOZlpuSUFySWtYWDRZRk14R1FyTUw1SzdiVUY2RmZGeU9Kcko0d0NBYVlG?=
 =?utf-8?B?c0pKb01qQm1TQk5SbTI1VUZqV3VhSVNPaG9FY0UzcnZlWmtJQm9kaWd3N2Vi?=
 =?utf-8?B?NFg4RnBBZnlnUFhPalFSRU4vWjFNT3M5NjZMazVIYkZ4WkFORC9KdWFrUFcz?=
 =?utf-8?B?bkJsMWVNUlh2SERVNEVzYXRXaVFiY01RYUVPVWNHNkdwVUJPS3R1RXE2S0pP?=
 =?utf-8?B?OVBBbjgyME9VaEJEVjMzUXF0ZzB2bnJ2OEF2VTdEcEV6Ujg4SDR5TS94RjZB?=
 =?utf-8?B?b1ZVUHJlc3dpR2pDM1lSSVdrN3U3cVp5ckVVeDZMMDZwYlYybDdkaEg2UUdT?=
 =?utf-8?B?T040OXNIMCtUSFVNMEtURVJrUkJkbjQ1S3l0L1RJZUcxM0hrazJnUHNzbEdo?=
 =?utf-8?B?UmhJTkhuZXhuRzlCM2VETXg3ZHNiUjlxOTVkTno2NWpsODZoT1dpVEk3RzFk?=
 =?utf-8?B?RmRpekpHWHJiZnAwbFoyUFhuRlRaWnZuQ0tMSkgwS0N0ZjVoMGh5b2hLd3Zr?=
 =?utf-8?B?Z3ZpdHJTY1VPMnN0VXlpcmsvZGhvMGZRVkFXVmREUE55VWxVWlZDc3FrbWcv?=
 =?utf-8?B?elhEenBoVWVjRmIvcFN0M3p0TWlIcjJTaUJsanBKMFRFay9yVE9pUVdOblVX?=
 =?utf-8?B?UGdrWUQ1d0dXQ0hPQmk4M3AwQ1hReU5ycnVyM1p1eWc4UzV3N2c1UG9pcHdL?=
 =?utf-8?B?UlJLaHVEU3dBKyswOEZyeDV5eU9PZ2JWZEtSMFVMZG1RTUNMTlBFcXFQK2Qz?=
 =?utf-8?B?MkNNQWtiSFpkb2t1ZHRHeWZ6SjhBSytoUUhaNEd1TW9EbGdSeTc2OGliUFA2?=
 =?utf-8?B?L3dxeFNJN1RYRENzMHI1MmpUcVVNZlBrSmx6ZExPeWFKeGxrT21rMUVFVmc4?=
 =?utf-8?B?ckFUYXJyck10MUlFT3h2K3dnbm9RS1ByQU5tNEFmQjF1bzN3U1hxSXJ3cTA2?=
 =?utf-8?B?UGNQZTJiOFlreG94YW5ORUQreVpBTlhpcTBCbklrbTZqcDVFdGRIV2JOcWpM?=
 =?utf-8?B?VXpMeDBweFFuMmV3eGVta0J4YUNiWkZjOWwzaktidWRYM0FFSngwaDd2cUM3?=
 =?utf-8?B?bkp3aXVTV1dXOFRWN1UyTzYyRWRETlc5TFNzSVhSYTFyek9USVZsTURSZUJr?=
 =?utf-8?B?eDFIUDF3RUQ3WXFHSmlreVJSN3dWWHRtWHd1d291dkdmMVloS0hnYWFSeDEy?=
 =?utf-8?Q?/ANQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d2ab70-f78e-452e-7ffb-08dbf7fb4b0f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 14:38:07.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UfdCm16Eqz3cGoqwOQJXFJM2+PIRFIuf9EePqXwW3PVQE278vSJRL4wRc2A5vNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Marek Olsak <Marek.Olsak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.12.23 um 12:43 schrieb Friedrich Vock:
> On 08.12.23 10:51, Christian König wrote:
>> Well longer story short Alex and I have been digging up the
>> documentation for this and as far as we can tell this isn't correct.
> Huh. I initially talked to Marek about this, adding him in Cc.

Yeah, from the userspace side all you need to do is to set the bit as 
far as I can tell.

>>
>> You need to do quite a bit more before you can turn on this feature.
>> What userspace side do you refer to?
> I was referring to the Mesa merge request I made
> (https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462).
> If/When you have more details about what else needs to be done, feel
> free to let me know.

For example from the hardware specification explicitly states that the 
kernel driver should make sure that only one app/queue is using this at 
the same time. That might work for now since we should only have a 
single compute priority queue, but we are not 100% sure yet.

Apart from that the hardware documentation only says that it's a nice to 
have feature and when we pinged firmware engineers to get more 
information they didn't know the feature immediately either.

That is usually a strong indicator that stuff was implemented in the 
hardware, but not fully completed and tested by the firmware team and 
validation team.

Alex and I need to confirm that this feature actually works the way it 
should and that it's validated/stable/read for production use.

Regards,
Christian.

> I'm happy to expand this to add the rest of what's needed as well.
>
> Thanks,
> Friedrich
>
>>
>> Regards,
>> Christian.
>>
>> Am 08.12.23 um 09:19 schrieb Friedrich Vock:
>>> Friendly ping on this one.
>>> Userspace side got merged, so would be great to land this patch too :)
>>>
>>> On 02.12.23 01:17, Friedrich Vock wrote:
>>>> This improves latency if the GPU is already busy with other work.
>>>> This is useful for VR compositors that submit highly latency-sensitive
>>>> compositing work on high-priority compute queues while the GPU is busy
>>>> rendering the next frame.
>>>>
>>>> Userspace merge request:
>>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
>>>>
>>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
>>>>   4 files changed, 11 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 9505dc8f9d69..4b923a156c4e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
>>>>       uint64_t eop_gpu_addr;
>>>>       uint32_t hqd_pipe_priority;
>>>>       uint32_t hqd_queue_priority;
>>>> +    bool allow_tunneling;
>>>>       bool hqd_active;
>>>>   };
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index 231d49132a56..4d98e8879be8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct
>>>> amdgpu_ring *ring,
>>>>                       struct amdgpu_mqd_prop *prop)
>>>>   {
>>>>       struct amdgpu_device *adev = ring->adev;
>>>> +    bool is_high_prio_compute = ring->funcs->type ==
>>>> AMDGPU_RING_TYPE_COMPUTE &&
>>>> + amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
>>>> +    bool is_high_prio_gfx = ring->funcs->type ==
>>>> AMDGPU_RING_TYPE_GFX &&
>>>> + amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);
>>>>
>>>>       memset(prop, 0, sizeof(*prop));
>>>>
>>>> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct
>>>> amdgpu_ring *ring,
>>>>        */
>>>>       prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
>>>>
>>>> -    if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
>>>> -         amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
>>>> -        (ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
>>>> -         amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
>>>> +    prop->allow_tunneling = is_high_prio_compute;
>>>> +    if (is_high_prio_compute || is_high_prio_gfx) {
>>>>           prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
>>>>           prop->hqd_queue_priority = 
>>>> AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> index c8a3bf01743f..73f6d7e72c73 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct
>>>> amdgpu_device *adev, void *m,
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>>>>   #endif
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
>>>> -    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>>>> +                prop->allow_tunneling);
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>>>>       mqd->cp_hqd_pq_control = tmp;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index c659ef0f47ce..bdcf96df69e6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct
>>>> amdgpu_device *adev, void *m,
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>>>>                   (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
>>>> -    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>>>> +                prop->allow_tunneling);
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>>>>       tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>>>>       mqd->cp_hqd_pq_control = tmp;
>>>> -- 
>>>> 2.43.0
>>>>
>>

