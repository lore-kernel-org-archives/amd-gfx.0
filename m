Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F744C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 18:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DAC10E32C;
	Mon,  7 Feb 2022 18:02:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0325010E32C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 18:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko8D6sss24UDKypGrimxTwpfmSUdyBHkMNagrNDPtUoBSonxrTKZNvjsn/TSH8Z5XZMRu93CBKkWDTNoll0mSKR8wBBwKmfiVqx7+Hx/jo+vfd8OrQGQm32JEJ2Ps+FscRe751v1AjXxmj4FWwHyTFg3NiYwQt+NeRniZEVBIt5No43tx5tivvipCClshV1ww0WSEPpJ7OHbVFT1VhulNsiXMtHKtJeK5AXrPAM5ZDhfYvaQNoFFtSkqWHax0nV8yWUrvynINpJEwyld/N8E1+tYq78DA1LWNlRza7TwBYKng04wkJBjK4JBkEPMay0Zof8RgsOWS4BxF6v6PYpS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51F3rIiWWe97scRRMJUDuShh0lnuoavSboxsRepTK/k=;
 b=gooXsay3khP0gNlOb8X1zhfNC8S88pMQIMjFtloUYUJCL6mSMpkHEa9TyHSN2Z4nUpuI37iLLPZ4nTEQENKSrFdw0KjPOS7c7kt5c1zWWudQCrkdiXItTK6xyHojT0YEzpHedb4InF0mC45m6QMNKPiXkqz7p4WaNhcDqLjdlCOQ0vlaDaBNUyzhF+VlNZ+nTVTT6M/vj2/VFJzqH3FCNeeNmAiuH9NmlijiT0vyHPlPbdqSDtP5dQA5w8Mk1TmSkBBWnjSEFirFqd9T5PxZLaq3sAMZWrjUYttw2wzNbQ8Uj/k4WjqRRp4/pWj03FKRAKP1EkdGCZ1cgZV/oW5DCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51F3rIiWWe97scRRMJUDuShh0lnuoavSboxsRepTK/k=;
 b=rSC8FFUSAbEdkpbwi6BPWS2wx7sQy47rmTH+jsgN8rg3FDn4ufN091tP0p8Njf8a7neujsRcIdiumZzdv3RqmwF7lX+fXQcmf/+t4D2usXeJXQPzV+H9q+tYlIDrajtAoFVVCs1mOqxxane8eIqaLs2SokzuYQg7Wxq975ViJLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 18:02:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 18:02:01 +0000
Message-ID: <df210147-9c58-adef-7f7d-b055ebf861ff@amd.com>
Date: Mon, 7 Feb 2022 13:01:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] drm/amdkfd: Consolidate MQD manager functions
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220204234513.11714-1-mukul.joshi@amd.com>
 <20220204234513.11714-3-mukul.joshi@amd.com>
 <68544466-9816-e94d-2506-19a378b38a9d@amd.com>
 <DM5PR12MB178612B34A80D84B71AC955DEE2C9@DM5PR12MB1786.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM5PR12MB178612B34A80D84B71AC955DEE2C9@DM5PR12MB1786.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00873dfd-f834-4b27-8660-08d9ea63f0a9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5365:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5365622B5BF0F411C6878DD9922C9@BN9PR12MB5365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzLxzRgq3VowFID7zzTyA0i8h56QgwBmzOOMu6oY+Qc2pvNeHyvO9SMJoOkvsBe5D5/cgSfMg2pm/Kb19rOV1MbtJ205vDVCRrGDb/wAf9gG8jCB9h6qV+vrPc+ppVMmZmo8kbqQBH6LId6Fy8/RJz5vgzoCD3bt33qqFswpknEb8Q8z4OuX75PEvO66uYI6VGMTlpjyu0OL/rFmMiJ5yEaryIvJ4sJViB7kSLPXs9hrOtMJUPYihlYQhPFYjYdpCGCFTAjRpO8Dab8A/+u6m5Us69WHg5mF3/8C4z/ql025fB7YB63Tp9sUp2zJu6UMiKLQFFrQtUlQkqYhT6YGB64YJJ8kQ042N4AU/W6qfSF2qF0vZp0bx6DDX9AUdDJEnvqerho73c5oxx95JR/2Qc21bOKVrgseCsaQYBOXhGiTRTjEsXzzXmr3xLl3C3lDtXiaRXbu6WgrM+RkRWwVy5FdLo09Me19FH0GUwe0V6h0YzFoPUyZEl4U/bjVutkxNjcGfPVfnzMzDve7M1NdG03YspLbm5ogxVSINUbwGqgw/h3M1ikHagYikNhtCswMr5086aDHsNjDP1FndMd8TkzEPYKtB3C7F9H4D3Vr6k9vnnc5l/yby9mcKfLCbJyQjGzAlv8IxHLk36W+z3mbcKdbcavQ7j/yXIqaTb+H35vjaEWejbCU/A/e9UyW+jRQrxzeT/HL6DNV9hrYxbKavS+VybU4e9twW/Ws6Ue/v5Af0/Jc7I9G4I2uRv2S0wkX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6512007)(31696002)(6506007)(110136005)(86362001)(26005)(186003)(38100700002)(2616005)(53546011)(5660300002)(66476007)(66556008)(66946007)(2906002)(36756003)(44832011)(6486002)(508600001)(31686004)(8936002)(30864003)(8676002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1GMnU4Mk1Ga09RT2diVm93QXJSUm44MFA1U1ZWNFptb0hiWWdtajgvQko2?=
 =?utf-8?B?VHNCeUFNWk8raHpWVjN2d0tLajlTcUlYbFNvVkhSQkVRMjdEbUVvY0J4UUI1?=
 =?utf-8?B?RU1pWDZnWm05T0JXYWV0R1JyQ0pVSFZGcU1tcjRWdG1aTXJFRzVHQUQrOTdz?=
 =?utf-8?B?WG9MeXJaSEhJRFdHMzdtbERTeGJxTUtSWWdHeDZpQnVMRzRYakdOZjRva2Iv?=
 =?utf-8?B?SG01MzVrSmFpZjRuaE5lQS93K2d3OFlLdUxMeTJZcFJPaGhBOVRwR1ROMXlC?=
 =?utf-8?B?UDdGUEpVYjBVbllhNE1GV3hlVFdYRlZYN0hHbmhUVmdWL1ltQ1dIYm9QaWR4?=
 =?utf-8?B?VG9lclZicVFNVGlSdzVla2FqTjlqS1pHM1hXWENEblMwbk9uQWZMQVF6K0dK?=
 =?utf-8?B?YVdRdGd3M3M4NldyeXN1aTNXR0prUkxNeGpCNTRDaUV3V2NPa2RtQlZSTHh3?=
 =?utf-8?B?NmdVRm5kbVQ4TlUxZS9NbG1idS9RMndwTDhkSDU5VzNNRXpHcjN3RWFBeit2?=
 =?utf-8?B?YUhUNEphOGpqbkFZWjErZGlwcExyR1pqMTgwOFpvYStMQ05yUFVTZXBEZUNp?=
 =?utf-8?B?QkpjbGM0K01JZmlvLzkrVWExOU1SR2IwaEhBa2NUMG42M3NNbFIyL29ma2NQ?=
 =?utf-8?B?d2JaUml1WDNnZ0RKUHVDZlRVbkVjT3pFbDFFQ3ZBQm5SaTNjVm9IbzBNTHRP?=
 =?utf-8?B?WkJEMnA4Z2lIQk1XenFpTjNzbGh3dHBmRU92d0FneS9vV1dKYkxYZ1piUU1z?=
 =?utf-8?B?bm1HeDlFaUZwUit4ZTVIV3BEL2puTzdKZk9HbEh3eDd3VFhRMSt2amMwUjg3?=
 =?utf-8?B?YmE5bTFUaXZHKzRFR0YzaUZ3OE1nN2xPODBUelB2RTkzZTU0NTBPYmZOL2pt?=
 =?utf-8?B?NFpBaU9BN1Z2K092RmIvNUgvUzJSL25jcDlzYXpUR2NyMkE0VTFQaUFYc1hB?=
 =?utf-8?B?MUkxMG1ZSEdXVGN1NnhuRmh4ZzJTWFByR0U0bjhmdlNHQy9jMURNSDQ5bFVt?=
 =?utf-8?B?c0MrYU9SdmxTZkZ6VWlWaEphVG9oR0k3NVZNSlM5REFkL0lVMTlxZ0ZwU01N?=
 =?utf-8?B?UFR1KzJHZGxlOGxtYUpzdEtWNWNJaEhiUVFxVjNMZVYvZjVsdVY3UG1qTDhj?=
 =?utf-8?B?bXlPYWpPOWc3dnB6RC8yam1Gd2hVRHJyRlRraGtnS2c4REI4YTFIWUpodDFp?=
 =?utf-8?B?UlFDQUoyRjVrTWtHU2psM3hzZnU5aEN5VU1McTlURkJ3L21ibkxxNnZJQkJr?=
 =?utf-8?B?R1dxVTIzTVpPNDJIUEpwTUpmR3hhTmh4bExPU1BLTVZXVHFoZVNaTUh0VSt2?=
 =?utf-8?B?Q3g4MS8xKytDR21qUXB1T29jUHFCZ1QwVndFN3luNDhydXMxdkZaVHVXc0dp?=
 =?utf-8?B?dk1mVUpJVit6L0VrRjlsNld0VjN3M3dubnV1eVRCQ3ZHTUJiOU42RU44YUdY?=
 =?utf-8?B?VThTUFZvV0lNZjZSRUNrMC9OQitBUm45VmhNczFzWGpwaHJrWjk2dHNCUlRk?=
 =?utf-8?B?ekVCK01HOWNhS3ZWS0tNZTBsUlliVHJFbjlkWXg0aU9TWUtieVptWHVEME1k?=
 =?utf-8?B?N3ZpckljYVFwZndVa1JZMmw3ZW5jT3lXUERXZktzZk8rOGd2S1RMOWQ3SHI0?=
 =?utf-8?B?U0x0NXJKUmhTT1ZLMEpCbzVmcEpaYmU4d2piV2pObEcyREJ6bExHQmllYXdV?=
 =?utf-8?B?YUNaZURkVGZWczRDNlYzL3NYQ1QzOWw0eWZxeUhMc2dkd1c0Zi9VTTBZWDl4?=
 =?utf-8?B?Q2pHbVkxZjU1Nmx3TjZlR29kbHc4R1cveWdGaVdMcUFjVTBUcVM4VVQ1Zlhv?=
 =?utf-8?B?YXpzZTlmdHNvSHdLR0xNbXZ3Z0JHTCtkWS9HT0dKS3VNM25BTVRpWGRCQkFI?=
 =?utf-8?B?NkJLM0huUk14ZHZGb1ByU2VFUUxvYU96elQvVWJOd0VjWnZIbzZkS1NLbXA1?=
 =?utf-8?B?WkZhNS9uOHV4VnRtVnNHeUZjS2RvWXZ1NEQwOW5WNFlKMGZaZkwyYytQM2RM?=
 =?utf-8?B?Wk5LM01helJrUi93QUxoZmVRRk41eG5DZWFMNFp6QWlVcjdxVlp4NHBOY0Rs?=
 =?utf-8?B?MmhTeStkYU12SXlPVDFkalEvWE1hMFFmODRnTEpZVDhnZkxadVZmbHlnMWZv?=
 =?utf-8?B?TXdVdUNxNVA3anI4THhtWFR2YTduQS9Ub3YwTVVlZmNEWFZXbkdaaXNFSFVZ?=
 =?utf-8?Q?yrXWTQkOFDKnW77/JPQaF+c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00873dfd-f834-4b27-8660-08d9ea63f0a9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 18:02:01.1033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qKNm88SMlJ2sGNUWAIQ+ULU6mjl4tkxa/cv5lvojCB4ghzCcMPwK4Zv1Doqiwo6nLu/Teryg9h8L6cbByJi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
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


Am 2022-02-07 um 12:50 schrieb Joshi, Mukul:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Monday, February 7, 2022 10:43 AM
>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 3/3] drm/amdkfd: Consolidate MQD manager functions
>>
>>
>> Am 2022-02-04 um 18:45 schrieb Mukul Joshi:
>>> A few MQD manager functions are duplicated for all versions of MQD
>>> manager. Remove this duplication by moving the common functions into
>>> kfd_mqd_manager.c file.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 63
>> +++++++++++++++++
>>>    drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  | 27 ++++++++
>>>    .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 54 ---------------
>>>    .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 61 -----------------
>>>    .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 68 -------------------
>>>    .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 53 ---------------
>>>    6 files changed, 90 insertions(+), 236 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> index e2825ad4d699..f4a6af98db2d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> @@ -173,3 +173,66 @@ void mqd_symmetrically_map_cu_mask(struct
>> mqd_manager *mm,
>>>    		}
>>>    	}
>>>    }
>>> +
>>> +int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>>> +		     uint32_t pipe_id, uint32_t queue_id,
>>> +		     struct queue_properties *p, struct mm_struct *mms)
>> Since these functions are no longer static, they should get an appropriate name
>> prefix to avoid future namespace collisions. Just a kfd_ prefix will do.
>>
>> I think there are existing functions in this file that could use the same treatment
>> (in a separate patch).
>>
>>
>>> +{
>>> +	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd,
>> pipe_id,
>>> +					      queue_id, p->doorbell_off);
>>> +}
>>> +
>>> +int destroy_mqd(struct mqd_manager *mm, void *mqd,
>>> +		enum kfd_preempt_type type, unsigned int timeout,
>>> +		uint32_t pipe_id,uint32_t queue_id)
>> This function is only applicable to CP queues. Therefore I'd give it a
>> more specific name, e.g. kfd_destroy_cp_mqd. Similar for the other
>> non-SDMA functions below.
>>
> We define destroy_hqd for HIQ (and DIQ ) also. Same for free_mqd and other functions.
> I guess that’s why we have _sdma for SDMA queues, and the rest use a generic name.
> Maybe leaving it without '_cp' is better here. What do you think?

I still think calling out the queue type in the function name makes 
sense, if the function is not applicable to all queue types. In some 
cases there is overlap. For example HIQ and DIQ would use 
destroy_hqd_cp. But HIQ uses free_mqd_hiq_sdma.

I guess it still leaves some ambiguity because CP is used as superset of 
CP, HIQ and DIQ in some cases, but only CP compute queues in others. If 
you want, you could use "CP" to mean the superset and "compute" for CP 
compute queues only.

Regards,
   Felix


>
> Regards,
> Mukul
>
>> Regards,
>>     Felix
>>
>>
>>> +{
>>> +	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type,
>> timeout,
>>> +						pipe_id, queue_id);
>>> +}
>>> +
>>> +void free_mqd(struct mqd_manager *mm, void *mqd,
>>> +	      struct kfd_mem_obj *mqd_mem_obj)
>>> +{
>>> +	if (mqd_mem_obj->gtt_mem) {
>>> +		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev,
>> mqd_mem_obj->gtt_mem);
>>> +		kfree(mqd_mem_obj);
>>> +	} else {
>>> +		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
>>> +	}
>>> +}
>>> +
>>> +bool is_occupied(struct mqd_manager *mm, void *mqd,
>>> +		 uint64_t queue_address, uint32_t pipe_id,
>>> +		 uint32_t queue_id)
>>> +{
>>> +	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev,
>> queue_address,
>>> +						pipe_id, queue_id);
>>> +}
>>> +
>>> +int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> +		  uint32_t pipe_id, uint32_t queue_id,
>>> +		  struct queue_properties *p, struct mm_struct *mms)
>>> +{
>>> +	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
>>> +						(uint32_t __user *)p-
>>> write_ptr,
>>> +						mms);
>>> +}
>>> +
>>> +/*
>>> + * preempt type here is ignored because there is only one way
>>> + * to preempt sdma queue
>>> + */
>>> +int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> +		     enum kfd_preempt_type type,
>>> +		     unsigned int timeout, uint32_t pipe_id,
>>> +		     uint32_t queue_id)
>>> +{
>>> +	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd,
>> timeout);
>>> +}
>>> +
>>> +bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
>>> +		      uint64_t queue_address, uint32_t pipe_id,
>>> +		      uint32_t queue_id)
>>> +{
>>> +	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev,
>> mqd);
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
>>> index 23486a23df84..76f20637b938 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
>>> @@ -136,4 +136,31 @@ void mqd_symmetrically_map_cu_mask(struct
>> mqd_manager *mm,
>>>    		const uint32_t *cu_mask, uint32_t cu_mask_count,
>>>    		uint32_t *se_mask);
>>>
>>> +int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>>> +		uint32_t pipe_id, uint32_t queue_id,
>>> +		struct queue_properties *p, struct mm_struct *mms);
>>> +
>>> +int destroy_mqd(struct mqd_manager *mm, void *mqd,
>>> +		enum kfd_preempt_type type, unsigned int timeout,
>>> +		uint32_t pipe_id,uint32_t queue_id);
>>> +
>>> +void free_mqd(struct mqd_manager *mm, void *mqd,
>>> +		struct kfd_mem_obj *mqd_mem_obj);
>>> +
>>> +bool is_occupied(struct mqd_manager *mm, void *mqd,
>>> +		 uint64_t queue_address, uint32_t pipe_id,
>>> +		 uint32_t queue_id);
>>> +
>>> +int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> +		uint32_t pipe_id, uint32_t queue_id,
>>> +		struct queue_properties *p, struct mm_struct *mms);
>>> +
>>> +int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> +		enum kfd_preempt_type type,unsigned int timeout,
>>> +		uint32_t pipe_id, uint32_t queue_id);
>>> +
>>> +bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
>>> +		uint64_t queue_address, uint32_t pipe_id,
>>> +		uint32_t queue_id);
>>> +
>>>    #endif /* KFD_MQD_MANAGER_H_ */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
>>> index 96e3303fa27c..81b6b3d5f2e7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
>>> @@ -156,13 +156,6 @@ static void init_mqd_sdma(struct mqd_manager
>> *mm, void **mqd,
>>>    	mm->update_mqd(mm, m, q, NULL);
>>>    }
>>>
>>> -static void free_mqd(struct mqd_manager *mm, void *mqd,
>>> -			struct kfd_mem_obj *mqd_mem_obj)
>>> -{
>>> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
>>> -}
>>> -
>>> -
>>>    static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
>>>    		    uint32_t queue_id, struct queue_properties *p,
>>>    		    struct mm_struct *mms)
>>> @@ -176,15 +169,6 @@ static int load_mqd(struct mqd_manager *mm, void
>> *mqd, uint32_t pipe_id,
>>>    					  wptr_shift, wptr_mask, mms);
>>>    }
>>>
>>> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -			 uint32_t pipe_id, uint32_t queue_id,
>>> -			 struct queue_properties *p, struct mm_struct *mms)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
>>> -					       (uint32_t __user *)p->write_ptr,
>>> -					       mms);
>>> -}
>>> -
>>>    static void __update_mqd(struct mqd_manager *mm, void *mqd,
>>>    			struct queue_properties *q, struct mqd_update_info
>> *minfo,
>>>    			unsigned int atc_bit)
>>> @@ -271,15 +255,6 @@ static void update_mqd_sdma(struct mqd_manager
>> *mm, void *mqd,
>>>    	q->is_active = QUEUE_IS_ACTIVE(*q);
>>>    }
>>>
>>> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
>>> -			enum kfd_preempt_type type,
>>> -			unsigned int timeout, uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type,
>> timeout,
>>> -					pipe_id, queue_id);
>>> -}
>>> -
>>>    static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void
>> *mqd_dst, void *ctl_stack_dst)
>>>    {
>>>    	struct cik_mqd *m;
>>> @@ -351,35 +326,6 @@ static void restore_mqd_sdma(struct mqd_manager
>> *mm, void **mqd,
>>>    	qp->is_active = 0;
>>>    }
>>>
>>> -/*
>>> - * preempt type here is ignored because there is only one way
>>> - * to preempt sdma queue
>>> - */
>>> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -				enum kfd_preempt_type type,
>>> -				unsigned int timeout, uint32_t pipe_id,
>>> -				uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd,
>> timeout);
>>> -}
>>> -
>>> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
>>> -			uint64_t queue_address,	uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -
>>> -	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev,
>> queue_address,
>>> -					pipe_id, queue_id);
>>> -
>>> -}
>>> -
>>> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
>>> -			uint64_t queue_address,	uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev,
>> mqd);
>>> -}
>>> -
>>>    /*
>>>     * HIQ MQD Implementation, concrete implementation for HIQ MQD
>> implementation.
>>>     * The HIQ queue in Kaveri is using the same MQD structure as all the user
>> mode
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> index 0cc8679c24fa..8324757a1cf5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> @@ -154,14 +154,6 @@ static int load_mqd(struct mqd_manager *mm, void
>> *mqd,
>>>    	return r;
>>>    }
>>>
>>> -static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>>> -			    uint32_t pipe_id, uint32_t queue_id,
>>> -			    struct queue_properties *p, struct mm_struct *mms)
>>> -{
>>> -	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd,
>> pipe_id,
>>> -					      queue_id, p->doorbell_off);
>>> -}
>>> -
>>>    static void update_mqd(struct mqd_manager *mm, void *mqd,
>>>    			struct queue_properties *q,
>>>    			struct mqd_update_info *minfo)
>>> @@ -233,31 +225,6 @@ static uint32_t read_doorbell_id(void *mqd)
>>>    	return m->queue_doorbell_id0;
>>>    }
>>>
>>> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
>>> -		       enum kfd_preempt_type type,
>>> -		       unsigned int timeout, uint32_t pipe_id,
>>> -		       uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_destroy
>>> -		(mm->dev->adev, mqd, type, timeout,
>>> -		 pipe_id, queue_id);
>>> -}
>>> -
>>> -static void free_mqd(struct mqd_manager *mm, void *mqd,
>>> -			struct kfd_mem_obj *mqd_mem_obj)
>>> -{
>>> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
>>> -}
>>> -
>>> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
>>> -			uint64_t queue_address,	uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_is_occupied(
>>> -		mm->dev->adev, queue_address,
>>> -		pipe_id, queue_id);
>>> -}
>>> -
>>>    static int get_wave_state(struct mqd_manager *mm, void *mqd,
>>>    			  void __user *ctl_stack,
>>>    			  u32 *ctl_stack_used_size,
>>> @@ -352,15 +319,6 @@ static void init_mqd_sdma(struct mqd_manager
>> *mm, void **mqd,
>>>    	mm->update_mqd(mm, m, q, NULL);
>>>    }
>>>
>>> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -		uint32_t pipe_id, uint32_t queue_id,
>>> -		struct queue_properties *p, struct mm_struct *mms)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
>>> -					       (uint32_t __user *)p->write_ptr,
>>> -					       mms);
>>> -}
>>> -
>>>    #define SDMA_RLC_DUMMY_DEFAULT 0xf
>>>
>>>    static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> @@ -390,25 +348,6 @@ static void update_mqd_sdma(struct mqd_manager
>> *mm, void *mqd,
>>>    	q->is_active = QUEUE_IS_ACTIVE(*q);
>>>    }
>>>
>>> -/*
>>> - *  * preempt type here is ignored because there is only one way
>>> - *  * to preempt sdma queue
>>> - */
>>> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -		enum kfd_preempt_type type,
>>> -		unsigned int timeout, uint32_t pipe_id,
>>> -		uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd,
>> timeout);
>>> -}
>>> -
>>> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
>>> -		uint64_t queue_address, uint32_t pipe_id,
>>> -		uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev,
>> mqd);
>>> -}
>>> -
>>>    static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>>>    				void *mqd,
>>>    				void *mqd_dst,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index 87da4329dbf2..007886b2961e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -204,14 +204,6 @@ static int load_mqd(struct mqd_manager *mm, void
>> *mqd,
>>>    					  wptr_shift, 0, mms);
>>>    }
>>>
>>> -static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>>> -			    uint32_t pipe_id, uint32_t queue_id,
>>> -			    struct queue_properties *p, struct mm_struct *mms)
>>> -{
>>> -	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd,
>> pipe_id,
>>> -					      queue_id, p->doorbell_off);
>>> -}
>>> -
>>>    static void update_mqd(struct mqd_manager *mm, void *mqd,
>>>    			struct queue_properties *q,
>>>    			struct mqd_update_info *minfo)
>>> @@ -285,38 +277,6 @@ static uint32_t read_doorbell_id(void *mqd)
>>>    	return m->queue_doorbell_id0;
>>>    }
>>>
>>> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
>>> -			enum kfd_preempt_type type,
>>> -			unsigned int timeout, uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_destroy
>>> -		(mm->dev->adev, mqd, type, timeout,
>>> -		pipe_id, queue_id);
>>> -}
>>> -
>>> -static void free_mqd(struct mqd_manager *mm, void *mqd,
>>> -			struct kfd_mem_obj *mqd_mem_obj)
>>> -{
>>> -	struct kfd_dev *kfd = mm->dev;
>>> -
>>> -	if (mqd_mem_obj->gtt_mem) {
>>> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, mqd_mem_obj-
>>> gtt_mem);
>>> -		kfree(mqd_mem_obj);
>>> -	} else {
>>> -		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
>>> -	}
>>> -}
>>> -
>>> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
>>> -			uint64_t queue_address,	uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_is_occupied(
>>> -		mm->dev->adev, queue_address,
>>> -		pipe_id, queue_id);
>>> -}
>>> -
>>>    static int get_wave_state(struct mqd_manager *mm, void *mqd,
>>>    			  void __user *ctl_stack,
>>>    			  u32 *ctl_stack_used_size,
>>> @@ -422,15 +382,6 @@ static void init_mqd_sdma(struct mqd_manager
>> *mm, void **mqd,
>>>    	mm->update_mqd(mm, m, q, NULL);
>>>    }
>>>
>>> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -		uint32_t pipe_id, uint32_t queue_id,
>>> -		struct queue_properties *p, struct mm_struct *mms)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
>>> -					       (uint32_t __user *)p->write_ptr,
>>> -					       mms);
>>> -}
>>> -
>>>    #define SDMA_RLC_DUMMY_DEFAULT 0xf
>>>
>>>    static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> @@ -460,25 +411,6 @@ static void update_mqd_sdma(struct mqd_manager
>> *mm, void *mqd,
>>>    	q->is_active = QUEUE_IS_ACTIVE(*q);
>>>    }
>>>
>>> -/*
>>> - *  * preempt type here is ignored because there is only one way
>>> - *  * to preempt sdma queue
>>> - */
>>> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -		enum kfd_preempt_type type,
>>> -		unsigned int timeout, uint32_t pipe_id,
>>> -		uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd,
>> timeout);
>>> -}
>>> -
>>> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
>>> -		uint64_t queue_address, uint32_t pipe_id,
>>> -		uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev,
>> mqd);
>>> -}
>>> -
>>>    static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>>>    				void *mqd,
>>>    				void *mqd_dst,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
>>> index 137b208135a0..c0405bbe8e36 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
>>> @@ -259,31 +259,6 @@ static void update_mqd_tonga(struct mqd_manager
>> *mm, void *mqd,
>>>    	__update_mqd(mm, mqd, q, minfo, MTYPE_UC, 0);
>>>    }
>>>
>>> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
>>> -			enum kfd_preempt_type type,
>>> -			unsigned int timeout, uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_destroy
>>> -		(mm->dev->adev, mqd, type, timeout,
>>> -		pipe_id, queue_id);
>>> -}
>>> -
>>> -static void free_mqd(struct mqd_manager *mm, void *mqd,
>>> -			struct kfd_mem_obj *mqd_mem_obj)
>>> -{
>>> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
>>> -}
>>> -
>>> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
>>> -			uint64_t queue_address,	uint32_t pipe_id,
>>> -			uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_is_occupied(
>>> -		mm->dev->adev, queue_address,
>>> -		pipe_id, queue_id);
>>> -}
>>> -
>>>    static int get_wave_state(struct mqd_manager *mm, void *mqd,
>>>    			  void __user *ctl_stack,
>>>    			  u32 *ctl_stack_used_size,
>>> @@ -385,15 +360,6 @@ static void init_mqd_sdma(struct mqd_manager
>> *mm, void **mqd,
>>>    	mm->update_mqd(mm, m, q, NULL);
>>>    }
>>>
>>> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -		uint32_t pipe_id, uint32_t queue_id,
>>> -		struct queue_properties *p, struct mm_struct *mms)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
>>> -					       (uint32_t __user *)p->write_ptr,
>>> -					       mms);
>>> -}
>>> -
>>>    static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>>    			struct queue_properties *q,
>>>    			struct mqd_update_info *minfo)
>>> @@ -422,25 +388,6 @@ static void update_mqd_sdma(struct mqd_manager
>> *mm, void *mqd,
>>>    	q->is_active = QUEUE_IS_ACTIVE(*q);
>>>    }
>>>
>>> -/*
>>> - *  * preempt type here is ignored because there is only one way
>>> - *  * to preempt sdma queue
>>> - */
>>> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
>>> -		enum kfd_preempt_type type,
>>> -		unsigned int timeout, uint32_t pipe_id,
>>> -		uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd,
>> timeout);
>>> -}
>>> -
>>> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
>>> -		uint64_t queue_address, uint32_t pipe_id,
>>> -		uint32_t queue_id)
>>> -{
>>> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev,
>> mqd);
>>> -}
>>> -
>>>    static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>>>    				void *mqd,
>>>    				void *mqd_dst,
