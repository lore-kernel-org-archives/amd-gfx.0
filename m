Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA22C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593B910EE45;
	Thu, 30 Mar 2023 13:48:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF14910EE49
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YohPasHaemFzAdRD3/JVwagSwQSntfktxyakK7WTgfiySsdkMJAs1N86YbUZEp/GQYNe8Npxi7lgsJudfAqgSwQ9DnE/ZqAQ9OCghYgqekWv7gTN6kHf2Tx/VSthzYqFsocOVLsgeEtSRuIF0O3h3J9uDI8ulTaYo00zzr9dj46G+ija1doZWLn2TJYQYeHteQhpgod/AqCGzwKOTz/SXu7+sxnC1X7yWTBAEEdwhuLwzkhEhljcrghgKmrsn+8cdpPA9wXmyaCPWkAJS1oTObQDFNXtj2Hi1GiK0TW95sR3KdU++o9zxFlCs3wkmVQ7HbT/mOK6SPoQjSVDMshllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyH541QRBuk5zJs9JuzkRgNmZfyBwgBCltHSSNAX7uI=;
 b=Y1EKCSDSEkIu/863s9180k+VeuO79Zpsmk+Rr6c0DmlUmEzjNTGU22+XdSRC/exaiTgnscJxJaE9KL8sYPy8qG/v1RFNXLjV+Rlq3M4J9tlwglUV2WQwOGxky3jhfP59NTzOGITddIfXOcI+jAEBYTDZnfqVRe5HHX+MYSlwzBQpDgth1/uFPLeF0ayIH2LvPJ7dTA9VvugLGz8ge4VLxfU2vvroCtQl0V1vpRgJdg1xodZkYS559WqbpJMjYAoBLvtHw0VbExnzMNI8PyTB4LZ8VJPVVAbutkoayQ9SIhRqQllSiQT5+WxuEetOd+yzrhbx4ItVMjcVixtto77h7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyH541QRBuk5zJs9JuzkRgNmZfyBwgBCltHSSNAX7uI=;
 b=nDOBhI6AhnWhJsZvPne+23X7HiUFdokWKL2k1afwcVgbdiMpEMswkQWk0hkYTwUyqTMZWNspcOoYZd4p7ZWb2wN3sSfLJtm/cXmIow6LUx3up5M6G08G07qBsAVmDMdcou0kp5JQmScXrMv1ooLIXItvcbL2+0zAmpYSMlSR0+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:48:34 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 13:48:34 +0000
Message-ID: <38c93185-7c06-4868-facc-2d107e60e8ea@amd.com>
Date: Thu, 30 Mar 2023 15:48:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
 <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
 <5c8ca3a9-6f6a-fa4c-0a1e-8dc72a3ea959@amd.com>
 <a6b38b89-c537-165c-d017-d1930c2ba2fa@amd.com>
 <274d9875-33dd-d9f4-ffd9-8a0b317af4d3@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <274d9875-33dd-d9f4-ffd9-8a0b317af4d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 43313cf8-6b0f-4e1d-395e-08db31257492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5Ifb8QyP/tL8jLXV5GdYhWxHK5VOncQKFU5sLqTwXS3SiZZo6eJinPc8RUeCzeUenirUW83qwSomFF1aeqkxbtVPpKkkxU34k8jdxUH1V+G3tbfxqb3Svo1VkQjPXlL/j0OSf/7ncq5/RGB4qJQI0xc8uEQmpD645fpepRpzd0JbBTcab95i+uaqvPYjQ9iyWYuXdHrTPXW/Kvnb5xgmVxPxXNT0FIICfQBgv9yFxx+ofZsKu9Lb2jevptBQ2G5DkdTWajeDosVp6sOSLnpLo4g5yKFg0i/JOoq6lfMmcyzr4gmYKyJpB9nAuO1SOlkr2m9GOCM8wvtBV9B0ADym9TPmnVg5v4eGQpzig3kijLfI84vv8yTlLvWVJzyDZqQDy1R4wmngr/0BKo9bG2Yzw6sEFO2QbETMSTAgRtL9BydV9w7eIP4iyC6C++784t9+CCKCIK9aoxoh/hy5EzP7TdoYQqGolGkoQi11JqWddcjfKZbnHPDPTPuSwNCeR5LSy1mofLFHOWw+ae/5K45sm+Ou8YfE18CVN/2RW9HQ/han2m5b/rRNvbqOAHFwzABMQETFUNi6xZqWXMf+RLNMi8KmpwvpOwIjX2/pHUtLlA4a1hZ9TSEg5VPEL7IQPhWM32BaupxdvAuea3uftyWjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(2906002)(44832011)(38100700002)(4326008)(86362001)(31696002)(36756003)(5660300002)(8936002)(41300700001)(6512007)(31686004)(316002)(110136005)(478600001)(54906003)(6486002)(6666004)(53546011)(26005)(6506007)(66476007)(8676002)(186003)(83380400001)(2616005)(66946007)(66556008)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlhYnBZeUIreDFLakdBeVBKUDlnRlpwaDAyNkZDVit3dGtpVHZlTVR0ZDJh?=
 =?utf-8?B?V01sY1J3b3puaUp1MVBoV3dRMDZzNnczTnhMak9jQzBqTVRGT1JaM20wYUFH?=
 =?utf-8?B?Zm5SejFicFRhOVdYK2hDVE5BWmhDQ2xMZU9qd216MU1KN01PY21IUTI4bUNO?=
 =?utf-8?B?dHhmOFpqVnArMEh5R3UxUWEwVnF0OWZqSlBkc3Q5K0Y2S2EwZzdGdjV1TTh0?=
 =?utf-8?B?U1dHOXVmNVpqV3ZkN3l4M1BjbFJ2bm1iOTAxTHFBNkVCNmJFK3BLTWNZaTND?=
 =?utf-8?B?Y0pYMEFZV2cySHJsOFZydEZsTWRLYVhhUW9oM1hkTHh4cmxTMW93UGVwalUx?=
 =?utf-8?B?RGJiL2hpQmdUMmt3eHkrYjhuYk9TRWFpZjFnMXBFcVFZTVBlQTNqaXA2emI2?=
 =?utf-8?B?VEp3ZXFDV0ZrK2ZDSk5jVjVSRVVnTTlpbFZzSWRSclJ4cUF2dVNHbk13a0NS?=
 =?utf-8?B?ODJlUHB6Wks2UEt3cTZjUVVlQUdvZ2pveTNjd3RzQ2ZYeGZxYmFHYWdOREdY?=
 =?utf-8?B?RVZ4Z3czOUZJem1xaSt5Z2pudjhVSWZTZkptc0FUc09UbTVGbXBmdWM2QTFm?=
 =?utf-8?B?TWxDVG9TUU0yQzVCS3N0ek4rcXB0NTlHQkNNVGVBS2VYUXpOMGxJRm5hSERp?=
 =?utf-8?B?OFVuMFBycFczcUxCL1BPYnJrZjVacDZwWVFQYlRkbFdtbkQ3Vzd6ZHVXdlY2?=
 =?utf-8?B?UEhMYWRGR2xad05reUZ2Um9uVlFGbXBrVVhmWk5sdHpieitiN3dHQUpsd01W?=
 =?utf-8?B?SS9ad25UTXRNNHRLblBtaEFVbmpJTGloWTIrTVVicnVPK3FMOXN0cXBydHdB?=
 =?utf-8?B?VlM5L1RyZG83aFNSTVRxWCtGczRXSitTQ1ZQY01KMnBLMGdUY2JLVUV0MkJP?=
 =?utf-8?B?TnMwaGlrQlU1NURXNzBybHhVUnlFMEJ3K1hidHFMMnFLRTQzcHprM2k2allI?=
 =?utf-8?B?WHZYZ3Y0RUpCY3BEaXJUQzBZOERta1RyYVdZaDduL2hYRVhINDgrRy9WZ3ZQ?=
 =?utf-8?B?Sno2WHl1SytxMGY4SlBEdlRzbi9tVUVoY1BtYkUwa2FVK3NNRGR3NW1DU0tm?=
 =?utf-8?B?ZG9LTUY4RFhDNWlvM2ZyelFaK005OXM3V1Y0RUc0U1lhNzBYZ3RyOE5UZDBK?=
 =?utf-8?B?dVpLS0dGRmhrR2w0UW16QXhjOTJTRmxYN090MGlRQkRQOS8wSXdNY0dINnJh?=
 =?utf-8?B?Y21vRUhMc2lZUkFnOUpDV3RFNUJhL0xmRFRuOGRaWkhVMU5oZHg3VDNCOVJC?=
 =?utf-8?B?QXVkbFltclBwMmg4aGlHUlVjQ1hJT1JZdTFKdnhUOTRtNDk2aThMNUFxeCs1?=
 =?utf-8?B?U1VVbE16RDY1dDB4Z0N6TjR6SWlmOEdZRUQ5TllqMzlsczhHM0pybUxhalB4?=
 =?utf-8?B?M0FGUFYzdHgrSElSZnZKR0JXSitzYisxMjdYRWpWUzVUQ3pEWkNhVmhSWUR1?=
 =?utf-8?B?aUhNd3h1Zkh4c25TUkhjTFNKTG8zL0ZJMGZaQklpaC9jSVNtVE5aMUxiL2Ew?=
 =?utf-8?B?YjByZFZIQ3l3emljZ2ZSYW1zZVRxbDZodEhGTkYzYU56VHEvTERaWnVhRXVs?=
 =?utf-8?B?b2Mvd0dTK3dvY0d1WmNldU1ZbnQ1cmJDYUpnd1N6Vm9GYUhhUVBaRHJtMFBY?=
 =?utf-8?B?V3gwSGxiSTBSY1FjYUZkQk9ESndkUWQzNkhkRktPVjkxTnJSYTdFSWxWVHhu?=
 =?utf-8?B?b2czOUwzWHpIMXEydlZQdzJoWUNyaFNneTJ4UVpmU2pweHZVL1ZDMXZoZ2RX?=
 =?utf-8?B?b3F5SXdTMHhIUnc2VEJZZ2RKMjhmajM0WVRPVU5YYnM3THY5b0lIMVpCc3lL?=
 =?utf-8?B?OTRIemZ2ZzRXOWs4WDVJYUtvQ3VxUGl4UzVyYlRvWjdXN1JUOEVKeWZFVHZY?=
 =?utf-8?B?QlhvYklNT2xsQ3U3T0daeDBGMWsxQ2xWbENsQXVuVkRDT1F3NTc2eHF2NklC?=
 =?utf-8?B?T3dkd2xXeFpjak9iM2ltNnhiQ2p4NitGaThaN2dsRG50cXlzaUFXS1NDSEUz?=
 =?utf-8?B?aWVrelZHcVJjS3ZrUkNxdHlHZlJOVG8rdzJMVU13aHYyQ0t4QnpyL3h4ZDZw?=
 =?utf-8?B?bW1XN1l2djdKdHR5enVvdUxCVFJDd1dEcyt1eGlFeCtFNWhRSmNzL0xtaytE?=
 =?utf-8?Q?NgtExpXfjv8qMFfWkR+Nv8Vvz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43313cf8-6b0f-4e1d-395e-08db31257492
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:48:34.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMJwpFetmJMEc+PDWRy+KH6t1N2Xog6NWh92oMciw7BA2QImfn38cPzrQSlUiMq3FRvGUNGyPP4JTPN76/4Hnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 15:45, Luben Tuikov wrote:
> On 2023-03-30 09:43, Shashank Sharma wrote:
>> On 30/03/2023 15:33, Luben Tuikov wrote:
>>> On 2023-03-30 07:14, Christian König wrote:
>>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>>> This patch adds changes:
>>>>> - to accommodate the new GEM domain DOORBELL
>>>>> - to accommodate the new TTM PL DOORBELL
>>>>>
>>>>> in order to manage doorbell pages as GEM object.
>>>>>
>>>>> V2: Addressed reviwe comments from Christian
>>>>>        - drop the doorbell changes for pinning/unpinning
>>>>>        - drop the doorbell changes for dma-buf map
>>>>>        - drop the doorbell changes for sgt
>>>>>        - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>>>        - add caching type for doorbell
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Generally there are no empty lines in the tag list. Perhaps remove it?
>> I would prefer to keep it, to highlight the CC parts.
> I've never seen a commit with them separated. Perhaps follow Linux custom?

IIRC This is not against Linux patch formatting/message body guidelines.

- Shashank

> Regards,
> Luben
>
>> - Shashank
>>
>>> Regards,
>>> Luben
>>>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
>>>>>     4 files changed, 28 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index 4e684c2afc70..0ec080e240ad 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>>>>     		c++;
>>>>>     	}
>>>>>     
>>>>> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>>>> +		places[c].fpfn = 0;
>>>>> +		places[c].lpfn = 0;
>>>>> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
>>>>> +		places[c].flags = 0;
>>>>> +		c++;
>>>>> +	}
>>>>> +
>>>>>     	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>>     		places[c].fpfn = 0;
>>>>>     		places[c].lpfn = 0;
>>>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>>>     		goto fail;
>>>>>     	}
>>>>>     
>>>>> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>>>>> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>>>     	return true;
>>>>>     
>>>>>     fail:
>>>>> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>>     	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>>     		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>>     	}
>>>>> +
>>>> Unrelated newline, probably just a leftover.
>>>>
>>>> Apart from that the patch is Reviewed-by: Christian König
>>>> <christian.koenig@amd.com>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>     }
>>>>>     
>>>>>     static const char *amdgpu_vram_names[] = {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>> index 5c4f93ee0c57..3c988cc406e4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>>>>>     		cur->node = block;
>>>>>     		break;
>>>>>     	case TTM_PL_TT:
>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>     		node = to_ttm_range_mgr_node(res)->mm_nodes;
>>>>>     		while (start >= node->size << PAGE_SHIFT)
>>>>>     			start -= node++->size << PAGE_SHIFT;
>>>>> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
>>>>>     		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
>>>>>     		break;
>>>>>     	case TTM_PL_TT:
>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>     		node = cur->node;
>>>>>     
>>>>>     		cur->node = ++node;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 55e0284b2bdd..6f61491ef3dd 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>>>>>     	case AMDGPU_PL_GDS:
>>>>>     	case AMDGPU_PL_GWS:
>>>>>     	case AMDGPU_PL_OA:
>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>     		placement->num_placement = 0;
>>>>>     		placement->num_busy_placement = 0;
>>>>>     		return;
>>>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>>>     	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>     	    old_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>     	    old_mem->mem_type == AMDGPU_PL_OA ||
>>>>> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>     	    new_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>     	    new_mem->mem_type == AMDGPU_PL_GWS ||
>>>>> -	    new_mem->mem_type == AMDGPU_PL_OA) {
>>>>> +	    new_mem->mem_type == AMDGPU_PL_OA ||
>>>>> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>>     		/* Nothing to save here */
>>>>>     		ttm_bo_move_null(bo, new_mem);
>>>>>     		goto out;
>>>>> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>>>>>     		mem->bus.offset += adev->gmc.aper_base;
>>>>>     		mem->bus.is_iomem = true;
>>>>>     		break;
>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>> +		mem->bus.offset = mem->start << PAGE_SHIFT;
>>>>> +		mem->bus.offset += adev->doorbell.base;
>>>>> +		mem->bus.is_iomem = true;
>>>>> +		mem->bus.caching = ttm_uncached;
>>>>> +		break;
>>>>>     	default:
>>>>>     		return -EINVAL;
>>>>>     	}
>>>>> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>>>>>     
>>>>>     	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>>>>>     			 &cursor);
>>>>> +
>>>>> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
>>>>> +		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
>>>>> +
>>>>>     	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>>>>>     }
>>>>>     
>>>>> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>>>>>     		flags |= AMDGPU_PTE_VALID;
>>>>>     
>>>>>     	if (mem && (mem->mem_type == TTM_PL_TT ||
>>>>> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>     		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>>     		flags |= AMDGPU_PTE_SYSTEM;
>>>>>     
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> index e2cd5894afc9..761cd6b2b942 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> @@ -33,6 +33,7 @@
>>>>>     #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>>>>>     #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>>>>>     #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>>>>> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>>>>>     
>>>>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>>>>     #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
