Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99444C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 08:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D21810E111;
	Tue, 12 Dec 2023 08:43:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE4910E111
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 08:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikvjMr/jrbtOAAJGdnVaeK7n7yPw+Q162koNO/AYiRFwg9AZlo6gRiBW8H+do9NmNtvZ+w30JS9N7+isY6Qj+oBQa+EQvB7OPCVVTYRjIUT6uLJZKtEEpf5FIIffw0zkxA2gRL9r9my9W44pFtN4apyPZJI1mlfz+ezgcsxyP1TIgh75oc3gkYD6M5OlHr/+r7Gwq9M2DGJEy+4E9DK7tFhinyXx8CeZJ1Ycq+O0HUsYe88dYURIdIuMe+1B3XYPr3+wKsoyBGZKgOMIQ4YHGi8R2z93bdDPqbV7Ld/kErL0EMgqr2tUprTgUuHZEvSV4QTqYJBS+XtwC69f84KRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AraUHPmGW16eaEPVJUrepEpmONq7o5Yb/TrFjaie/W0=;
 b=CTGlR9KdQ+cFsTE8xDTmpl67+BUxpnFC98u2LcCD32G434D4PTWVBgw0FJR1CzuW4FUczqhxNi/s4LmFV8cNZISdk3+4LyaXPEe7pRH5MLkVJbPHP8+pU190VSLNNLLQ6rF3HuloiFnQ5YkDeegc8UABYPbUOSaUTu2+o4OCSTK9z4WK5Uspa3Kulxu0sSIr/i74kMTze0r4BOvhcIB4V1X19kitC5CejTo5dMDWuOcu2qYmeTrJSJD0UwXIAKAkMWL7VRxqNvxhgw+Tt4Bg4k93wLHnvBPy1XOp1NBH7DnJhQb3m9IuBkbH6ka4DkErMMsdSzuL9lCFHz/9feJR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AraUHPmGW16eaEPVJUrepEpmONq7o5Yb/TrFjaie/W0=;
 b=Mym5ecLWOuub7PPS7kWNUKZhCCFv+d6K2gu8vlEHYLdUTRE3oEu58F90sWExl3wTPUwODztxT4X0fd4dOZchzo16dkPYIJuIArVuznCfjtaIxTlj+CjNECdwR4gHTZPT2m3ECrhs3BKWn1/RQ5JDe+OoOXtchDAPslfOh19oDew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:43:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 08:43:13 +0000
Message-ID: <dba9e984-bb15-4978-b096-30f023519a1b@amd.com>
Date: Tue, 12 Dec 2023 09:43:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: make an improvement on
 amdgpu_hmm_range_get_pages
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231208230105.733781-1-James.Zhu@amd.com>
 <20231208230105.733781-2-James.Zhu@amd.com>
 <a7821e98-8066-4870-b41d-a57e7f04a2f5@amd.com>
 <952aa532-e82c-4e5a-8edd-1ebbf5c79ce3@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <952aa532-e82c-4e5a-8edd-1ebbf5c79ce3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7afcae-ec12-4376-d7af-08dbfaee6007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jymfS21JLeTt69RH+sDP6LpiV5Vzl/Ua+FTSni1xn/EeJdpvloRYn7XbAZ0AyNxlpjtQPVz2Fz/K+0FE/B3g+3Np9eD50s/M3uBr8goUNJp7KnUMbm9OkSYOw9UXwXkLP4JjZ6FYpklPqSlf2GMa/c7P0MkjpMYyyq8g5+o9It6wVIBLVfUTVDL1mAztCa8cyJbYl628glHN3+XgjdWgTcVHmvqBelnDXs2CSh9g5K66/euSdthWI0lD3SRXKIw0NiylR6Wyk10XvxqsGJ77Q7IY0M5zpT4c4KWP0ZqiSocpf7KA4BBslN/saCWfj7m3d1oYjtE0JXECRSEu3thskpsJ3UaGajHe0ceIc/UeesD5BS2vvo52esm3vMeiz2EJsbpN9c039KwzHEE4B62LSvhnOz13u6o3e3GUy8qszaL+GMMa3GYqmSIvB8383okjUuc7x1vlhlBVTDAbLycV4wDM0tIVXm+ERc9m6FR3Im1+TTB4KuGbChgA+SSUZ0WErkSgzVbRdl87nmpQt1ZX5GHFX4uorkUm29Q4QbnDVmoDYNuFzEQQEA55kE5xyTHB62MB5Wsd3eabDM9OhTEA2+62AT/76w/SuASvFXLnBQZLv60qf+e71i1nvMT8NLqNgh9W/3DMcTN4a+qYlNVIG74id2k4XBoYpKrXZH2A7AJlU1ZNMQ7qgZOZFt0Sm3R9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(478600001)(966005)(6486002)(86362001)(316002)(36756003)(31696002)(66556008)(66476007)(66946007)(110136005)(26005)(2616005)(66574015)(83380400001)(53546011)(6506007)(6512007)(38100700002)(6666004)(41300700001)(4326008)(8676002)(8936002)(5660300002)(31686004)(4001150100001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZncU50dVoxdW4xckxUZlFyV29sS2cvU1hFNzF0T3BGWk5WVmxFcjN2Z3Zr?=
 =?utf-8?B?NU1NS280d2w2aGJ5bDFYRzQxMXRRY292aXdjTnIzYzI2aDVGUUlCTGJoUmh0?=
 =?utf-8?B?dDR3MEJPYnE4YWJ0OVg4RFVoaHpnZUJyam5rdGpCOFN2RDdXS0xGNVBHTE11?=
 =?utf-8?B?NEp0TEVzWGxsdHZrWG11RzBwalowRTRTei90d3UwTDNtbXJRTDgxWWtiZGZP?=
 =?utf-8?B?S28vMWxjdXJpMnZOOTEvNTJuVjJSUXhxYWlnOG50VWU5bndWS3VVdUVzeHBp?=
 =?utf-8?B?eElLekhBMnhvcTRJME9WY0dSMUFUUWRFRzJyUEgwOG44S2JCd1BkVWFCUUhC?=
 =?utf-8?B?UEhJK1dSa0gyT2pGQTdidDhxV09Db3pZR1VtTmNrblFaRVNmQlRlOTYrSEFy?=
 =?utf-8?B?ais5Z1Qxa3JJOS93TzA0ZmNuUHVidHBBL2ovN3g1K1JMblY3TjRhT1UrY1A4?=
 =?utf-8?B?NXc1ZGFwTk1rY0t2Zmg2N3pmMEtNcEJ5VGxMSmN4VlpIeEdkbnFwZThYcFZa?=
 =?utf-8?B?VjlibVk1RmlmbS9YZ2hWejI3WHhQdXJBNkQ4akpIK1Bvdzc1R0xlRmFhNzVq?=
 =?utf-8?B?UVF6bWppYXhlcnQzdWtaMFJ1eDVrUFppdkFsTVVRM01yN1pBWkxBdHFtUi9q?=
 =?utf-8?B?WGZEMzBqWGpOY1Z2NURoNXpzMDZpTDdUL2Y3akFaYy80bHVkT1RITFVoQ0dC?=
 =?utf-8?B?Z3MrajFnang3amFOd3c1UUJqci95Z3NpNE51NGVMYndtaTZvNnlmZXBMQ3ht?=
 =?utf-8?B?d2xvdXdiM205em15RmVObmxkZlZLVmcydlAzSkhWMHRXQ2xGeko1QkhTVitx?=
 =?utf-8?B?Z0NPNUR1TlU5Tnl0bzVWMVAzYUk5YUYwTGNCUU5LOGN1dm91Q1pXVU5OYW04?=
 =?utf-8?B?blk1a3Z0NTVVWE1MSFRXRW5zTi85NzJ5NFpRb3hRcHFITFJqUWVFL2ozbnd0?=
 =?utf-8?B?WVI3QS9rY2Q5ZXR6Zko1bmRPUHZNd3FXeTR6WGF6MTc5Wk1FeFRXUjJkMEQv?=
 =?utf-8?B?dXFCTmdkeHFlcithZ25JYWRHWU1aR094cWJrQjhqL3BOb05uR0RWZjgzYjlC?=
 =?utf-8?B?Z3JVR2hFKytEM2dTakh6R0tDd2xXZE5zY0pROFM5bDAzR2dzSVArWEM3bXV3?=
 =?utf-8?B?eEJESUwrMDhGck1mcEFkNTJLSDhIYXRWTVBKU3JhWk1SNFVOTDdFOXdIQ08w?=
 =?utf-8?B?Y2FBcmxtclJXUzZGMjMydDM0TjNPa21vU0lzdTFWTkJrNkRJalJMcXczSVlp?=
 =?utf-8?B?TWludGZadVlZTDlreGhnVXI0WEYvL0FmbnA5b2JweTV3U0F6eWgzY1phaE9s?=
 =?utf-8?B?MXR3ZlNzT29rOEd4cmovdlhhZG9CSHpmaUt5eEJIZHR6MGNtVFIzUHdsS1gx?=
 =?utf-8?B?Y3N3YlBhT01xS2c4ZkxFcTVqbUh4MnpJd0tLcHBmVGhFWlZIWFFHTk13YmFH?=
 =?utf-8?B?YVZPUmVLOVRTa2lLWGlPVFVnOHZ5RG92U1NkWE1YeXVhUndxcW5PWERDdkR4?=
 =?utf-8?B?ajQxSmU2WWFlVTZJQ3M0aktLb05TRW1mUFdHTXZwZWhpMUp3U2Y2YWpBNnhF?=
 =?utf-8?B?bE4wUjhrSHN3THNzTjhXUjVGY0c2VkNCWExoQ3drYlpzNG8velROcDB2dlN2?=
 =?utf-8?B?QjdxaWJVYlZrMSs5ektRZklqSG1HL0VHOVowaG1jM0FEWEo5aklCOTNoWlRM?=
 =?utf-8?B?V3cxcUljTmgwTmZWdzNGbW1ZOG1IeUUyNS9DOVlwMGtrNmRodGhhSDlEMTg3?=
 =?utf-8?B?OEFwYWpXbGhaVE1RQmFWVnUweUEwNjM4RHc4YTNjSDJOSTEyUkFXdll1Tno2?=
 =?utf-8?B?YXBkbG0zSmRCRnhKL3oxdGRxS3RZa2pEZnpraGJEeXBscjJvVmZIUHYxQnQ1?=
 =?utf-8?B?UC80T1hhQ1FkeVVwWnNVMHlLa2NoQ0t2Wis5V1d2Vm1rYzlmSXJBanJnellD?=
 =?utf-8?B?eHpSRkpMNUNmaGJjWnhKMzBXMDJRTUhVTjhBUzFBL0xTSWcwb3BhUzdTRkc4?=
 =?utf-8?B?QUtyNmRHSWRsRXdDa05aLzNSdkZPQk1sQ2tWODR6WkM3dVZCQTVEejV2Vm1u?=
 =?utf-8?B?UVlLbDVnN2J1eUVabEJWRUVZcDJ6L3k2QlBmYkVSbWhwMHducWdRUkQ3VHQ3?=
 =?utf-8?Q?J9Ng=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7afcae-ec12-4376-d7af-08dbfaee6007
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:43:12.7295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p1K0uCcDeqOB/1ma72BKpapwEPLzehSAnHXYIMWWT+Iyvd59Pt2+mtxzE8gPUwC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Cc: Philip.Yang@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.12.23 um 00:43 schrieb Felix Kuehling:
>
> On 2023-12-11 05:38, Christian König wrote:
>> Am 09.12.23 um 00:01 schrieb James Zhu:
>>> Needn't do schedule for each hmm_range_fault, and use cond_resched
>>> to replace schedule.
>>
>> cond_resched() is usually NAKed upstream since it is a NO-OP in most 
>> situations.
>
> That's weird, because https://docs.kernel.org/RCU/stallwarn.html 
> specifically recommends it to resolve RCU stall warnings. I previously 
> told James to use that instead of schedule().

I haven't followed the full discussion and rational about that either, 
could be that the documentation is outdated.

The latest RFC to remove cond_resched() and explaining the background 
can be found here: https://lwn.net/Articles/950581/

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> IIRC there was even a patch set to completely remove it.
>>
>> Christian.
>>
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index b24eb5821fd1..c77c4eceea46 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -199,6 +199,7 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>           hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>>>           r = hmm_range_fault(hmm_range);
>>>           if (unlikely(r)) {
>>> +            cond_resched();
>>>               /*
>>>                * FIXME: This timeout should encompass the retry from
>>>                * mmu_interval_read_retry() as well.
>>> @@ -212,7 +213,6 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>               break;
>>>           hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
>>>           hmm_range->start = hmm_range->end;
>>> -        schedule();
>>>       } while (hmm_range->end < end);
>>>         hmm_range->start = start;
>>

