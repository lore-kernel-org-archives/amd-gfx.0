Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7A7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 08:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9168110E6C0;
	Tue, 15 Mar 2022 08:43:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B329D10E6CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 08:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY+3HJgHIVwqhnt08fHDCImng0D4h2zNj2Tm8zbZPIxx+XwV/sncYW0VyZwrjVAX89r/vm86AAey1FYCYqGLa07p0gDiAHTi6T8lGAWTjBmLC0av4KDSLpDl+M2XvH4M5vskicNc0rHq3u4TUev8nt+US+vYcHx8+9OiSbEsHsRyzBM4Fi9ugYlLg422jSx+q+AQY7+Rz8PStBxKx4VQG9e6JIvaN1wO9eZ3u21yXxSDCNJE3zK5cIW09mAVGzILsOZisoACXKuneZPK+EitgkJX3i9K4ngW9S8nunZXRmnl00YqqdcDNq2kRbmh32HFNdgnCvEdYzQKNRKpIg8f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUPpxng1WRWeATAAmQZAo5pyHwynqg8VMpGi2x9XO1I=;
 b=Imgm351lrqqXbBymOGYG9iwbRiU8Ap5BLDdN/G9BHtRELqQJt9dfT6mxS1zvDCTMAdAkrZh4I8+uLd3AqJGllv6I03fA1jMPGHOg5hfM5uqv74aqIRhrTG7kKQ27daWUeeEQDUTZ8eye1eG5DuYfQkMVNBIg+Cd9C2tUHhJBfc/6OHS0Ftq8BzHR5AtAjO61qw1SpvnwGBbBJy+vj6s/iA9x2b+Ykn1KZ22c6/45MaY/cn6CTDFZZg4v1MDm56iSQ5VtyWVICbM7Htk4l28eAk1Fn6eqlzY92hyIu9u+F0YMFw7ZJtY6kZE8smDyfr6oygN2kXrT/uDgY85Pcq1oMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUPpxng1WRWeATAAmQZAo5pyHwynqg8VMpGi2x9XO1I=;
 b=2G1+0raaQQ84vuOE5gv92je3DuNJuS5SMJvoTWpty/VPVRrJUUM0MX5/AsyWfcszTcnxTfxCs3tA5/qwro2tbG3jobpVzeCCvUg/gD7ie3ECzOlWwCAmOkm9nBxGAeHOwJCWqW5G4iFXi6e0U8kP8osbnNm9/w0zTWetYR1YslY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 08:43:06 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 08:43:06 +0000
Message-ID: <1298d67d-bd43-6e9b-79e2-b2f19bbe5be7@amd.com>
Date: Tue, 15 Mar 2022 14:12:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Content-Language: en-US
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
 <0480be6a-3bf1-d120-8923-06819d7479bd@amd.com>
 <DM5PR12MB1770C04DED1C0A8C7EB6DA9CB0109@DM5PR12MB1770.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB1770C04DED1C0A8C7EB6DA9CB0109@DM5PR12MB1770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::24) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d3caadb-083f-41f9-967b-08da065fd324
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45649D14958404A3451CE1E097109@DM6PR12MB4564.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rd/9ZaAMkjjxgI0Q6k1WqqpL+67xexj6kLdjaWKVOFKxf+xJynEc3EOZIaAS2hJ+Di5h0e7mueGZ5VMP/aoFHAKDNV1yO4Sy8pIncp1NTLXBVddZs2QPBdj9GKMAe7Xkvx8fl43mRsDejdCsuOKWAw0+BSESqenh+jmdbiVc/OIuOpeCXR2avOOCISIYCEQjMH1rcWwdhn0p+dkM3g201KoOjCL6V1kpCV7Kl+LDtDmsGZUPcR3L8FYAIuFATujisYpSLm6tRo/d3KRiLFgieN8c58lgGfD9dXWn09TteFsFUA0X1dtHT3IbTPkXSUFFXjHIzADz6QgU1peXDvSZskUBbJuz3nR3Jxui/sa2jTBYTZsHxVr14P5YnibihOH6Yg9ncAdfe0CRcYuuGXOK160H4I7kbHZKjYJ/sQSPTnYCRbZFEvF9AQvjSBJOftzgmnp5Tmnz3v7BwroZHpzCBymPli/W2Z2P/8lISXes+UqjAvJRL6aVGx1wXwWfoxlqK00ggy84MPuuRF+8zzIoqX9e5JEySzG+7KNe+W9fTb4+nqdf3rO7kSkp8zuIjT0cf5FVApNyy5P2dP0qSUBKsK+mE1XRxdu5XOMdUhIWGIi7rXGmT+G7rE7NvYjzUkOZIjFAsEu2pjWj+HxxXnLtIakjE6QRObdpzqQ9jtIPzgIR3LKyWjPfObhBp+pEPHG6egKsOUdF6fmcI1gcto3xlpDVstiyMbz9caBhm9HZdCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6506007)(110136005)(6486002)(83380400001)(6666004)(31686004)(508600001)(5660300002)(53546011)(6512007)(316002)(26005)(2906002)(36756003)(2616005)(66556008)(66946007)(66476007)(8936002)(6636002)(86362001)(38100700002)(186003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNXUXRvRzhWaU9GOHVPTVRXcG1zZCtSMzN0UXdiOERpUW1Pb2o5TXRnNm9P?=
 =?utf-8?B?TWFhb2tzZFhadTB5RlhuejVpMThMNDY2eU56bFlhamZOeVprV0JCMHZPckla?=
 =?utf-8?B?ZmNYWHJlaGZVcUFlRjNRNEFNdklLM3BRYUxVWmNZMUtVbGovYmswWGZ6VEpP?=
 =?utf-8?B?S0FUZkVtUjJLZk0yeXVPS3M1TzJrSk1JaERRRDlzWmQvTHNpdDdEUkFiTzJz?=
 =?utf-8?B?aVRGSWdQS3JHZkxFeURMdEFMbTU2ZXZYNDZ2UEY4eURqTVgyMGJ3ejlMZ0JF?=
 =?utf-8?B?amttbllZN24xaEZXOUxCSEx6VEsxRTF1S3hldVBpRFJDQkVDdHlMblIxUzh3?=
 =?utf-8?B?N0xNNlhBdDNRVUx5V3dkU3lVVTdzRGMxQURWblY4WGYxRXJoNElEc0RwS2Nu?=
 =?utf-8?B?SDl0bGl4U2JzM1FJTmh0VWllL1NSaWl3cFo1SHFLTWdSSVRjTWFZWUtoN0JL?=
 =?utf-8?B?TmdpUzZyRExkb3p5TUJyT0FMNjFvMm9kbVJSUnJpNzgxanB2enNxOXZCMC9U?=
 =?utf-8?B?c3hYOHdnVjZJOWgybStwdzBuOTFCeW1va1o5OXhlOUgrUnJVTThJSWVwNEZq?=
 =?utf-8?B?WnlrVjJRV3RVMTY4eTMzM01rTXkxRkFJcnBVL3k4c0FZL2xRYm1sQXVHSEsv?=
 =?utf-8?B?ZkREVEQwMXM0WkRtT0s4K2dBZnRrakd4czg3T1JOVDZ3aGdIem8rZHd2VFdt?=
 =?utf-8?B?YW9ZL0grZDlqRFJQcFNCdWlHTUwwdnJEMkR1eUFZWUhZbGk4SVViOGhyWnVy?=
 =?utf-8?B?bE1BQ3pINFVvMHJBSjN5V3hFRUVuR1RsTCs1M2xjWFRFdVZ6MFlHWUE5b3Ju?=
 =?utf-8?B?QUNrQjd1S1EwZTh2V1dHM0t3cEtQZTV1R2FGa3Q5STBTY2NxUVBPQStMSjNW?=
 =?utf-8?B?Q01GemhtNEJwYW51azlBUWppSldrcjkrdHFIZmFuWElkNkF1eHFLWHlkVmUr?=
 =?utf-8?B?Q1hYYWk0MktUZDc1N0l1OUtWTmI4NzN5M1l0ZlBvckJabDVFd2ZOais0aDBQ?=
 =?utf-8?B?L3NkMlVVaDFFUXR6Skx6MWp6M0hyVWVxYStHVDBpSXN5TnNJZVZJc2VLYUlV?=
 =?utf-8?B?QTBqeWJCczBaenFwNmNVYTMyd1ZyWmxST1JpcDhNeTBMWElXRFlhRndSN0dr?=
 =?utf-8?B?a2Rma3BPck5Mdnl1a1Y3aERybHB6bS9GNHEvYVVvU0svYURCV2c1L3JDeEcw?=
 =?utf-8?B?QkNKcEx3aFBpWUZZbDF6ampzS0ErT0UyRlJwTTRvRFErUER4VWdSUWZxQUdh?=
 =?utf-8?B?bnRpRVFvSTR1SkdydGd6dFdGM3lTSmZKN0p0bmZKY09KdkNTcXAwUVVxbzU5?=
 =?utf-8?B?Ymw1S0dldFluZjhYK1RrUnROYTZZbi9SQmJPajMwVjBJK3pPLzVxSzd0akV2?=
 =?utf-8?B?L2ZVWmdqMmxhVFh3S0l5cFVMOW0vS0dSRjFHNnRrMWYvL21adDdOektIQkFG?=
 =?utf-8?B?ZkJ2UTduaDlZRTQ4LzVwWUFncjN2ZjEvMlJ5dEhUTTl3T1lUS2hsbGp3dVph?=
 =?utf-8?B?NFBVMnFtUk5CTzUvVmhpS3Yrb3JJU2VqWG5PcG1GZ2J0R21UR3hqTWlFY293?=
 =?utf-8?B?eU1TdkI5YkMvMmxnUk1OUzlWTEtmVUlSaWpyckZOc1QxNzJYK05LQjh2MVFE?=
 =?utf-8?B?b05yY2tEdURaSkZwVmplUGxUeHc5TndPYXlVVVR4NVNUb2JBdHBiaGwzTkd2?=
 =?utf-8?B?QkZTWnlnclVVMlJNZU14b2lMbUNpaW9uZGcza1VBTitYeUhpNzA5THFaNkdL?=
 =?utf-8?B?U0swamdCUHhNK0lCOHFuS01ESGxYcFFrWThoanRQRzk2MkpjbG5DeXZHY2lV?=
 =?utf-8?B?S1ZNbnM1ZWVkWlZ1c0VnRnZ4SEI2eUV0ZHd3aDUxMkVQRU1RQ0VrTHlibTEx?=
 =?utf-8?B?bXdQNVJjemxHeVlFN3ZmREtZOHNEVGZObzBRK2xFbjZLQzJGZmtXQkh2OE90?=
 =?utf-8?Q?UDy7JTn7vONrqwjbyr631k5GO3r2IFvh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3caadb-083f-41f9-967b-08da065fd324
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 08:43:06.3833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIjHSNn7bwLSKjP8v/YWsMB98emuvsx0one2bU4ta1H3u1678LiGXHj5OlOIpcc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
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



On 3/15/2022 1:22 PM, Zhou1, Tao wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, March 14, 2022 5:52 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
>> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
>> Subject: Re: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
>> utcl2
>>
>>
>>
>> On 3/14/2022 12:33 PM, Tao Zhou wrote:
>>> Do RAS page retirement and use gpu reset as fallback in utcl2 fault
>>> handler.
>>>
>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 ++++++++++++++++---
>>>    1 file changed, 20 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> index f7def0bf0730..3991f71d865b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> @@ -93,11 +93,12 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>>>    static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>>>    				const uint32_t *ih_ring_entry)
>>>    {
>>> -	uint16_t source_id, pasid;
>>> +	uint16_t source_id, client_id, pasid;
>>>    	int ret = -EINVAL;
>>>    	struct kfd_process *p;
>>>
>>>    	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
>>> +	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
>>>    	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>>>
>>>    	p = kfd_lookup_process_by_pasid(pasid);
>>> @@ -110,6 +111,7 @@ static void
>> event_interrupt_poison_consumption(struct kfd_dev *dev,
>>>    		return;
>>>    	}
>>>
>>> +	pr_debug("RAS poison consumption handling\n");
>>
>> dev is available through kfd_dev.
> 
> [Tao] not sure of your meaning here.

I meant use dev_dbg here after fetching dev pointer through kfd_dev.

> 
>>
>>>    	atomic_set(&p->poison, 1);
>>>    	kfd_unref_process(p);
>>>
>>> @@ -119,10 +121,14 @@ static void
>> event_interrupt_poison_consumption(struct kfd_dev *dev,
>>>    		break;
>>>    	case SOC15_INTSRC_SDMA_ECC:
>>>    	default:
>>> +		if (client_id == SOC15_IH_CLIENTID_UTCL2)
>>> +			ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
>>
>> Since this doesn't logically belong to the switch condition, better to keep it
>> outside of switch.
> 
> [Tao] will add source id definition for it.
> 
>>
>>>    		break;
>>>    	}
>>>
>>> -	kfd_signal_poison_consumed_event(dev, pasid);
>>> +	/* utcl2 page fault has its own vm fault event */
>>> +	if (client_id != SOC15_IH_CLIENTID_UTCL2)
>>> +		kfd_signal_poison_consumed_event(dev, pasid);
>>>
>>>    	/* resetting queue passes, do page retirement without gpu reset
>>>    	 * resetting queue fails, fallback to gpu reset solution @@ -314,7
>>> +320,18 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>>>    		info.prot_write = ring_id & 0x20;
>>>
>>>    		kfd_smi_event_update_vmfault(dev, pasid);
>>> -		kfd_dqm_evict_pasid(dev->dqm, pasid);
>>> +
>>> +		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
>>> +		    dev->kfd2kgd->is_ras_utcl2_poison &&
>>> +		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
>>> +			event_interrupt_poison_consumption(dev,
>> ih_ring_entry);
>>> +
>> Is it expected that no other interrupt would come until this FED error is cleared?
>> Otherwise subsequent ones could also be treated as poison.
> 
> [Tao] OK, I'll clear it after checking FED status.
> 
>>
>> Basically, whether to do this or not?
>> 	1) Clear FED
>> 	2) Handle poison consumption
> 
> [Tao] I think we need to clear status register, otherwise the error status is always there.
> 

Patch sequence is
	1) Handle poison consumption
	2) Clear FED.

I was asking whether to reverse it. You already clarified it above.

Thanks,
Lijo

>>
>>
>> Thanks,
>> Lijo
>>
>>> +			if (dev->kfd2kgd->utcl2_fault_clear)
>>> +				dev->kfd2kgd->utcl2_fault_clear(dev->adev);
>>> +		}
>>> +		else
>>> +			kfd_dqm_evict_pasid(dev->dqm, pasid);
>>> +
>>>    		kfd_signal_vm_fault_event(dev, pasid, &info);
>>>    	}
>>>    }
>>>
