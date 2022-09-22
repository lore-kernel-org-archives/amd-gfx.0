Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EF3ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 19:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A914B10E03E;
	Thu, 22 Sep 2022 19:16:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528CD10E02B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 19:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwvcWcKMlSPncGPV0XQ4LnX2F4tnKfsyDTakCKqb68rLeHUcpmBxRPbnx+z9ABD652B1twWnD/T+CtL7JBAhbjnxV9kS88jzY9hDEl2M+vBNLVKx7sBP0kCw2BMKq2Ve6Ua0+G+6Nc3ar3bLGeKCkESMhoquR8cWZkpebIsjLAVrkxi9FcO9GXW5iltA/hDR+lWHc+eeWUo6dzv0ubqT1kYXn1xFiE/e/w859eHvRq3rLEQ7K+xL/Y97Pi1PAXZ5LG6IrZkQa0SgQq6TAKkcj38thJQij5eqcAmn316GNM/AuthQwn59aXR7M6USnQDWiNwkV4Hgjt9r1BlBDiVKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y94b4521IsAqxwzOr4EvNlNDASxcOkN396b/wcy6GvI=;
 b=XAqTg70xVKKFqCd1/XnGzVJf6Dg+136uCD8nXB1wjyxDT2oUkgXYceEwsiqi6Mzc6Y7ZMV9Aea00RL+tM53t5zstenYsmlZ9d8ZjtsL5Nqd0hc6C+/fK4wIE9xi57XTM3lAxWpYUmW4kIREMziG98mLqSmgogfBWjHD+tONu1IrNcAHm9GgktRWfJBTPm1mcxossdN5nmAZV0dYvRHmoypTjDSpN5Gyf3KPbN7wgIHZGk17Yk9Vgk62jymF/zMaNrmVoG1PuHz8Kgb+4K9cO69WtymNVJGBO9v2wchkm5iPSFWnoh771PgHLTgH83UVoCliCtCIJnxM7ya5+NCW/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y94b4521IsAqxwzOr4EvNlNDASxcOkN396b/wcy6GvI=;
 b=nZmvUHmIpeMUUCcH4io6OjnzV6rAC5YxCLV274jH4cVHXZ9K4zIp4URG87BXYKNFj3v/l5Gg3F3bBOvGDTLraC2NGIBoK1eSH3rUkDEKY8S6pJx2wKOzNS60p3lNlc5cfNL1ihdUr37Hgy5o6Wo+GvPXmsvAc7sxjG5b7DTdFl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 19:16:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 19:16:31 +0000
Message-ID: <31904c94-0233-da4f-9a13-ae51ec8491b8@amd.com>
Date: Thu, 22 Sep 2022 15:16:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Enable SA software trap.
Content-Language: en-US
To: "Belanger, David" <David.Belanger@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220922161703.916705-1-david.belanger@amd.com>
 <2943b204-2999-b6f7-1f30-bdeb85a711cb@amd.com>
 <DM6PR12MB48283F913E02A64B3E3AE4DD994E9@DM6PR12MB4828.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM6PR12MB48283F913E02A64B3E3AE4DD994E9@DM6PR12MB4828.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 0800f176-1855-492c-38cf-08da9ccef4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7CckNSBG8yZNHkvGIHpIDJu+ZPzX9WrgEla6P2wgIV2elsI9S2GMpFTSfF0y4gZmlfhk6wmH43U2sRS1pEhl6b4v+e16NAAauov8Efc1u4Rgod7iG/Z+FQBo++Tfnkik0BErCLAxpVUt2et1iNYrgiJcrD9oGNRDYA41uRlUh1zx4EgIWdWRXoGG8ct4QsSturDzZxqlR08gJEVAlgC/tD/CCbFxTICRiltlSmQV+5fvq6c4XJiNfw4mInWN2h8jcaIFfCqy2GQ+n66M+SFYDO9OObOlBfW0kvUy//2eTW21aPf0DfIXfI0/mkOHBn80M1ptgPJWDe1nU0gE4bAeE5UaE1G80mPKCjWyqsdg449Jtsf+ZvFg0BTR7XGEFLxVPPxZqnsVAa0EsfW5d2jbqXeWurkF62ek9oweHPamM7MUTMvfKdhchzK2CQ1ZKZz94KlYnFeE2cVJq0nHd9RU4Brt3zAtDRP02CJhgVTdpKf7GdhOs7kOvrV6euwplBl26zmiTgFkXcajFDI8u6yY2PlCwD1YnYELus3QRFGeypv6exuNkSjerKmuR7wicbteugxO145xpPjuMDEYOmPn/+GEvNj5Ov3x+7HvflHTos9AJLVQxaxt0c9JkCcXbtgvtplBWIzNwtoSnUr9GPQX9ybUQmXkoVhDHOD+NUR8B+B/nn69MiydNnes3e0IwoLxnKMEQDJccVAIufRCto42unO8l3XxyrvmYluc2R1qNmeIz/d4EoDulVkf2xiPUcBj1TsJ1tFleTWja11d7VoQ/3+qcf9k/bYf2QrXfKDo3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36756003)(31696002)(86362001)(31686004)(38100700002)(4326008)(5660300002)(44832011)(83380400001)(2906002)(186003)(53546011)(2616005)(26005)(6506007)(6512007)(316002)(66476007)(66556008)(8676002)(66946007)(6486002)(41300700001)(110136005)(8936002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBiRld1RGJzWjNGZkpVb1R2Z0Z5VFdDUTdNWWV0Y3ZlR2hnREdvY0UrRmpo?=
 =?utf-8?B?eXlMM3RCN0VZTWdSWTNwQld2eDdKak11UHF6SmE2RHhkMHRSUHRUUlVnN3RZ?=
 =?utf-8?B?NTAyTCtnNC9QakQrUDZtMWlHRHcwcGE5cTUxQnBEZmI1TWJITVRWaWVJSFc4?=
 =?utf-8?B?RE5QYk1FRWtDVkYzSE1pRm5TMm9tUEhSeng3UWhQUWpsUGRHRjBUKzd1Q1NO?=
 =?utf-8?B?dUNuTjViSUVzVmJ1N0FTYkY4RGdMU3RYZndnK2JTeHBYcnJGY1FlQUhmdlUr?=
 =?utf-8?B?cEdGQnlZOVRhZGJuNW83RjJsSzgwREdUbVJLTHBJbmhOSGxjMmVKY28vbUhy?=
 =?utf-8?B?M2pLR3kzaEZGRE9najkxdzFoWUU4MmhlWjZCbVU0Y1R1NmdUSHpTaHhtNmM5?=
 =?utf-8?B?V2RRRHd2aHJFQTk3UXhnbTVPRi8xVWxkR3phZ2NyUEttMDNyc3JKeWMzMTBy?=
 =?utf-8?B?eXBLSjV3KzhlVEVHcDRJOTc1VmFmK2d4TmNLNkNkYmJTb1YyVFFNdzVzbk1X?=
 =?utf-8?B?WFZQSHJ3akR5UEgrWlFkZ0tTaDRETzlTVXAzUjFvM0Q1RUdYbWErTGRYRVYx?=
 =?utf-8?B?Ykx5R1p3Z1oyemNibVcxelZKRHFHeUhZZUl2MFFkVTllYmVkZjZNeFNwMng1?=
 =?utf-8?B?Nm80RHkyb2dvZEJYdVo3VHZ1WVdlRy9PTGJSM0l3allmUjlNMzhFd2dFUmdh?=
 =?utf-8?B?dm9IL2Q3ZXhwZlhpVEExZ0VhUkNFVGFzaVloKzV4bVh3dXJUa0M0dS9Jb3cx?=
 =?utf-8?B?d3V2MVhPSm1TZlR2RklmbGJ5VmJnR1FFM2lCeUU2OFRETGpYYmczZFp3cW10?=
 =?utf-8?B?WVFsK3poYm14ZXdoZzVnd010T3kvMkhnUENEQ3hHRkFhcGFmNzNYS2lXbnZM?=
 =?utf-8?B?OEdSblFjSXVJQnBnZHJCdUZtMU95WTRPZDkwSVFjNkVzdkY1SDY0Rm03bEU4?=
 =?utf-8?B?VU5zcktIUmkycEF1VHBVVUcxdnZxQ1JEa1hCdXMvVGVuOWFGdXl6M3FIVGFn?=
 =?utf-8?B?ekhqL29VVVpqU29kN2FrUHVpT2k4VTZoQXY4WDNDMFNpSk8xWS9wMXpZZ1lJ?=
 =?utf-8?B?aU1LY1NtL2lrVGhxUmtJUFdLMFlTS1YydFN2UW1rRzFlVU96ditSdjFoZkpt?=
 =?utf-8?B?YXNJZVB2eStObkZwN0E4YTBkN1pVSXh3ZlloSTUvMkE1L2dzNlNkOXhSNDVl?=
 =?utf-8?B?L2JsdEFONDNVVHhEcDIzU2U1U2lZN3Z5eTUwT1dpVnYyL2tBQ3R6Snh5bW9P?=
 =?utf-8?B?YVBseWRIWHViOEh1NHMrRUJtVzY5Ymk4T2lwckdUR3NKb3lSM25pOWR3QW8z?=
 =?utf-8?B?eTh1WXdqd21wMmdVOVlZNkhRcytia1RiUEptZ1ZIYTVldXVOYWtVdHo1OGEr?=
 =?utf-8?B?SkFzT2c5dnBMTnlxUzBCSks1djQ5MWdVOStYeUpuclRUS3IzSzBvdDYrRzNW?=
 =?utf-8?B?UENzRTZJaFZTR0ZPN1I4SUJFaGhBbGpwS2xPQjE0bzA0MTh5dmxDcGpRN0ZC?=
 =?utf-8?B?WjlYVVhhSG50Q0Fza05kWWl6aTZzLzZDRm85aUJSWFpnbjhLbzEyaElnN2Vp?=
 =?utf-8?B?Rk9JZTdwWnhzUGU4ZlZaamx1MThYTk9SN1dHMDQyQTd4R2VkVEZGMFpRV3Zy?=
 =?utf-8?B?Qk42QzhBNWpobmxQSU5VNWlGWEhuUW43a2RKeU9BVG5JL25ldFVxK3MxaUg2?=
 =?utf-8?B?aFJ2aVExeExyUmZDN2hkamdJVU1yTEVHZmc4Nno2ekw2Z3piVGFSM1VXSC9F?=
 =?utf-8?B?aW1PYzhXdVNxT3BnTnJPcWNmRTBPdnZJYjFYSktFSFlTQ2dSWVBjRXBrRkdS?=
 =?utf-8?B?bENKNXZNZnZESFdUdzRPODFnU3lMRE9uUjRyMXFXcUxrcVo0OWNDeFo1eDh0?=
 =?utf-8?B?RTBudjhOMmNpQkZUVWRiZGc1NjU0aS8xdC9zdEwwR0JoVEZLY2F2TkRNWlBB?=
 =?utf-8?B?OHpBYWxZWjlIb1dkaVRkQTd1QlBQOUpkY0pTVzhtUStPZkRSeVNKdUZBRXFI?=
 =?utf-8?B?eWh2TmxFVHkyWVNUdmpQcDZsQ0EzS1J3c1ZnV254b1VBbUdXTS91TXY5d28v?=
 =?utf-8?B?eG9sN1dxV21Wd1N3QmJmZHJYVjdmMU45UWwwbU1CaHRPY0FXSW5MQm0zSWgw?=
 =?utf-8?Q?Uoc9h7z7A+xbqKBqINy6mMy9k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0800f176-1855-492c-38cf-08da9ccef4ad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 19:16:31.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyNS32M8JsA2xTsjvw4CY3YHdkdjJjw9j5pxz+/e983heI78sXqHGPU62oWTIroaqyHmojK4NPKrzrwICSn3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-22 um 13:57 schrieb Belanger, David:
> [AMD Official Use Only - General]
>
>
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, September 22, 2022 1:14 PM
>> To: Belanger, David <David.Belanger@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Enable SA software trap.
>>
>> Am 2022-09-22 um 12:17 schrieb David Belanger:
>>> Enables support for software trap for MES >= 4.
>>> Adapted from implementation from Jay Cornwall.
>>>
>>> v2: Add IP version check in conditions.
>>>
>>> Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
>>> Signed-off-by: David Belanger <david.belanger@amd.com>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
>>>    .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 771 +++++++++---------
>>>    .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  21 +
>>>    .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  26 +-
>>>    4 files changed, 437 insertions(+), 387 deletions(-)
>> [snip]
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
>>> index a6fcbeeb7428..4e03d19e9333 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
>>> @@ -358,13 +358,35 @@ static void event_interrupt_wq_v11(struct
>> kfd_dev *dev,
>>>    				break;
>>>    			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
>>>    				print_sq_intr_info_error(context_id0,
>> context_id1);
>>> +				sq_int_priv = REG_GET_FIELD(context_id0,
>>> +
>> 	SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
>>>    				sq_int_errtype =
>> REG_GET_FIELD(context_id0,
>> 	SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE);
>>> -				if (sq_int_errtype !=
>> SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
>>> -				    sq_int_errtype !=
>> SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
>>> +
>>> +				switch (sq_int_errtype) {
>>> +				case SQ_INTERRUPT_ERROR_TYPE_EDC_FUE:
>>> +				case SQ_INTERRUPT_ERROR_TYPE_EDC_FED:
>>>
>> 	event_interrupt_poison_consumption_v11(
>>>    							dev, pasid,
>> source_id);
>>>    					return;
>>> +				case
>> SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST:
>>> +					/*if (!(((adev->mes.sched_version &
>> AMDGPU_MES_VERSION_MASK) >= 4) &&
>>> +						  (adev-
>>> ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
>>> +						  (adev-
>>> ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3)))
>>> +						&& sq_int_priv)
>>> +
>> 	kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
>>> +
>> 	KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION),
>>> +							NULL, 0);*/
>>> +					return;
>>> +				case
>> SQ_INTERRUPT_ERROR_TYPE_MEMVIOL:
>>> +					/*if (!(((adev->mes.sched_version &
>> AMDGPU_MES_VERSION_MASK) >= 4) &&
>>> +						  (adev-
>>> ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
>>> +						  (adev-
>>> ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3)))
>>> +						&& sq_int_priv)
>>> +
>> 	kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
>>> +
>> 	KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION),
>>> +							NULL, 0);*/
>> Which branch is this for? kfd_set_dbg_ev_from_interrupt shouldn't exist on
>> the upstream branch yet. That code is still under review for upstream.
>>
> My understanding is that it is for branch amd-staging-drm-next to make its way upstream.
> The code that calls that function is commented out.  There are other pre-existing instances in that file in amd-staging-drm-next branch that are commented out also with that function.
> Please advise if I should remove it from the patch for now or keep it as commented out.

I'd prefer not to check in commented-out code to the upstream branch. 
Please work with Jon to make sure he includes this in his rocm-gdb patch 
series, where these changes belong. And you can submit them to the DKMS 
branch as a separate patch in the interim.

Thanks,
   Felix


>
> Thanks,
> David B.
>
>> Regards,
>>     Felix
>>
>>
>>> +					return;
>>>    				}
>>>    				break;
>>>    			default:
