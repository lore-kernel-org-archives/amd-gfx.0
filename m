Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6CDC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E4361027
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42E4361027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77DA6E84A;
	Thu, 26 Aug 2021 13:05:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A494C6E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 13:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgHlvYw+49vCWl/TKqxq2DxLmjaSHm0mi6yZuyIEHl1L/7xjLjw9njbJB7zq6CsdJJ7KCGNh1EsDDymwtiyJt1657+zhg247qpgXG+0ev54BUUPH+KIlw7cX35b0WvnSqZq7u94Fj8ktKQkn6CVX5mMybwOO+3t9pidC6oXg0Ibr+qpGZb4gYknct8MmHvC+7bvnuzmGMA1Afw4+6wfEnpFQcHlboDqcD+e2TGdfPji7VvzLLGCI2ipNhUEAw5SqFWmRSg4qriu/2+6eerrlHi5UxPobSQ7/yoMNGehpldqB1Evx+Z9zfFZU8703c2hqzBUeSBg/UYqC3uviyR5WZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyIv5oc0uVC0YvNcFW+ujjWq6sms5nJt/TVs9LIOwBI=;
 b=oGvTxrQEb9CEvk7S6HleUrZaigjlc/QS2ioRZ+dbMn2xg9ipNQL8JKbE3elefY+8ZnefsofmMSYlWDzUL5kTCJQTaE+l0mrDLzQ83lgNF4YRNxFJFyfpkQJkWnsA6f5XgbgYKIrVnmbhwgiu1Ait0/5O23tEO9LxB+FcQT248Vam6RlmsWeTPHifjCFF0C7KtaSeentuX6Ho7tqI1CT3OWJYY8DrxC1XAHhyHoZm1FB4g/reWN977fr/sdOyBAAmVeiLKHTbaEPRnPam+jgA48hVE5SI1N3Qd1EQuNQVTf+uxo1XA4BHZAmSwhFMD7JZkv2J5Kl9/NMDWxhAuvjZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyIv5oc0uVC0YvNcFW+ujjWq6sms5nJt/TVs9LIOwBI=;
 b=a7vN/fVawFJWBz63GqXRCv98CNotx0hq32XlKT9D89K00fTDaSkRS8OV89hd4wuHhrFX35u2K8NsaoUZ2lTRwlQWp2EbK3egSIcV/Va5g+34rNUWxh4yG1Wgw4qH4GHfGvTprXnr5tdDJzsHL9YbkM6rK2T1g8LN3AfJOXPme/c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 12:31:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%7]) with mapi id 15.20.4457.021; Thu, 26 Aug 2021
 12:31:29 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu/vcn:set vcn encode ring priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-2-satyajit.sahu@amd.com>
 <2a818da4-dc8e-a9b6-c85e-9a6cfef8b537@amd.com>
 <82b91115-b2c8-f6bf-30bb-15da77e70d09@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <aa8797e7-175f-d5f4-969f-eacdaa23e65b@amd.com>
Date: Thu, 26 Aug 2021 18:01:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <82b91115-b2c8-f6bf-30bb-15da77e70d09@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR01CA0097.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 12:31:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb4b3eb-0227-4f19-8e8e-08d9688d6d80
X-MS-TrafficTypeDiagnostic: DM4PR12MB5069:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5069B92DCB034C18BC7444E2F2C79@DM4PR12MB5069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ob/qmYYM31xiksI6SjsLtkDhC3YZm4yRB3Ka+uYViITAGbvkR7AzsnlITyIia1zXGQ6Y5Xr3rw74S16BDTPMiSaTK0exyvHndcAbpBWlOdvwpFPGZdJxcP92sJGPSe/VIKlkqTIglfDrHyzfecflTbRkWUboMkSk3aHavjnRkvn1AmAxQuU5x3wTr9kVrdDeuGVQdRlkJsH7iq3VEUBBsUn9gV4E2b+1/inePMCHvuLUB2Vtwb+62VTMJzkjRPmBU/IEuzcyuHlMUwOpRL1Q0VGod2ut+SwEwyJAIEd/OPd4nWreKel3a1BGsKQR1mYiiSvfcpY5adqF47b+BNP9/Q7OczWdS7DEI28fEByWDGqYK6o9bWXaLkCWwaWG7XdAWpio02WHf3mCfCAYAj9NyNbRG1tPAe3pmqxbyapBRpXaohmcQGsKXe2T/V0NELAx99PSUMqbeZ3lM7lDXSnzIR9kSlM4G8yBTR1tOHRZOds7Zv1TBR/4T4gq+czd86FEgz+B/A9xGQAtbt7/IyGMIjhLyx/4CqchDjOGX5PgnBZABts3d/kPqVZSJUUATaE8Dz2riBESk3IQh83vFbAJGEgSb959NiaRVJPkMTcjSvDp6CFOA41kVCdD27/5Z5jSUxK2rHaJhCZ/ZK2vSZbJcQpw72BEu2qUwMweW1S7+giyUvYSC49cnewQ5oXJn1dGAw1cjspm4zgQnCEQ2j7k/8nzeSOsB4v9jbxWSIPyukg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(2616005)(8936002)(31686004)(316002)(2906002)(956004)(38100700002)(8676002)(6486002)(36756003)(31696002)(508600001)(66556008)(5660300002)(66574015)(1006002)(6666004)(83380400001)(4326008)(26005)(53546011)(16576012)(86362001)(186003)(55236004)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhWSXdsalV1L1R1WjM5RUIrZU4vK2lhY056b0tyVU1vaGx2bGxsVk54SVBv?=
 =?utf-8?B?KzRuQ25xcnZBVm52eDh4Y0MrYWdaYXNwY0M1U1ZiNEdycnV2MVhoekkyZEw0?=
 =?utf-8?B?bzVRVUIvek0wYWNwSzFmRUpiZGJySlpoellIYWpIVjZmMldEVkl0REtzZVJk?=
 =?utf-8?B?TURId3I3b29icG5sNG5yQTJyTXk2Yld4dENhVm9lNzRnRXRJUlRrMzh0Mk5X?=
 =?utf-8?B?Q1NXcm9oVGVjY2pLQmR1aTJSL2xKV2lVMUwwVGhuVm1GUEtIR2xVZFhDdGsy?=
 =?utf-8?B?L1RvcmtjMXMrNFA1YnI4OVhNS2RwVWhMdXR2OXpON1JYanVmQmtsbVdyK29a?=
 =?utf-8?B?dlRYajNURzI2VERZV3lncUIrNnEycCsxYjNEODk3dTIyOXBxeUZuOFVWOGp1?=
 =?utf-8?B?aS9TWUVxalFqbkVyWDQ1ZExFRG1hYTFpK2IzNlJiZmRFRDUyRWVTVjhiQy9w?=
 =?utf-8?B?ZnVEVXQzY2oxakRPeGVSUmJCbVhGRlRsbDd2MUVMZ0FLb0JzYkxSREhGYkMy?=
 =?utf-8?B?VTRhT2d0ckJMYVZhYWV4VGg1TUkxb0JxN05uVElkMTJLVkJTM1FpdVBnRkMr?=
 =?utf-8?B?Y1lhOTdsS2dDbEdSUXFvVnhRYzd6N0xrazhxWmRIWmFQZ2Q2RHRVbWVtcVBx?=
 =?utf-8?B?bFREc2Fxd3paZVVlSGhxY01wZUo2TXFRajN3VGhEajFJbnI3a1o4NkEvN1A2?=
 =?utf-8?B?QmplajR0VjQzNFg4Z1B0MllybDV0UEtJNGdwbklDWGtCWDFuL2tkZGVpWHJm?=
 =?utf-8?B?eTBBbGJVS05ZWmI5Q0laVHN2b1BiMy85azZGZGRMRUF0V1BOd3dkWHZybmRy?=
 =?utf-8?B?TlpnMk5XOHR6SXA3K014Q3pnU2sxemRUWXdSWTJHZ2FXRFVERXdCMmxIdFE5?=
 =?utf-8?B?SmNTT3l4cFpHYVBsLzdaYzRhOUFwVHU2UzlkU1V2VUx4c3VDZnZxTC9Ibk8w?=
 =?utf-8?B?d3JBNlhaQ2ZYRy8yTEdsYzVENEU2RExNWlFIRGNGVkVlL0hYWU9jSzNMVmpY?=
 =?utf-8?B?cVNSQXVsZVEva0dOcHVCaC9EOThnTkJ3UkpTUm1za1dJTnJjOEhSNXEwbVN6?=
 =?utf-8?B?VERhZU8wWTU2UVRkdkdjV0F4UHB3c3hpWlJYSkJ2SVFSQUFKbUtRS0pURUxy?=
 =?utf-8?B?MjdiUVF0eUZCY1Q3ZUV6RHBJRXpWdnNtZTAyUDBNdlFQRHZBZkJKSFFSZStB?=
 =?utf-8?B?WWY1emtoNUJ0aXJzak1vZU1nMnVsQkNvRHRpWUx5YUxsbjQrcVpUTmdYU3NQ?=
 =?utf-8?B?YTZ6RzgwaEp4TkM5bmpDc0pPYUJBRG1iVS9rUk1hd2NSa1lZaSswbWxHSTJk?=
 =?utf-8?B?bWVxVWgxQ25zaFQ3eGpGcTFWZjZlKzFWUTRaMHdlZ0l1TXp1U2FoN1N5cUxt?=
 =?utf-8?B?aWxabFFJdFAxTmxOaWhZY2tOMDJqMjE4Vllyam1lNVhhOHRIWkJObU5RSnBN?=
 =?utf-8?B?WXZNT1RWelczVFQxenBRTkV6dVM0ZHc3emJlbVJUQkd1VTRnd1FaazVQUldT?=
 =?utf-8?B?cm9CU253SmVJZDJGNEtERTY1aXU4WHAyczkweTIxcUFmeTRrb0NMNHdJUTV2?=
 =?utf-8?B?M3NYTGV1M1IyamR5Z0krYnR1TXE1bExKa0Z1NnlBQmpQcnhKZlAvUGsreVE5?=
 =?utf-8?B?SUdSSlYySlVJaHNYU2kxQjFuL0xLRWFMd3VTM0cyUVBRV0lraWtlSU1wNmEy?=
 =?utf-8?B?aTQ3ei9GZE55bG1WTEE1cUlNem9GRkJyWjhUelR0czhPY3JWOU02dndXc0hn?=
 =?utf-8?Q?HsvLa/WK/fO42fetkAmSGn3km9AuvkxRXbK9qXM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb4b3eb-0227-4f19-8e8e-08d9688d6d80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:31:28.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRe87K7TCfu4OQ25JMOHA5RT1NDYSTuZo9JPkryyULrylfZ7gs1ruA5tLdFb5nkvLJVpTeD0LvjBSTDb5iP5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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



On 8/26/2021 5:54 PM, Christian König wrote:
> 
> 
> Am 26.08.21 um 13:32 schrieb Sharma, Shashank:
>> Hi Satyajit,
>>
>> On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
>>> There are multiple rings available in VCN encode. Map each ring
>>> to different priority.
>>>
>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  9 +++++++++
>>>   2 files changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 6780df0fb265..ce40e7a3ce05 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout)
>>>         return r;
>>>   }
>>> +
>>> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index)
>>> +{
>>> +    switch(index) {
>>> +    case 0:
>>
>> As discussed in the previous patches, its far better to have MACROS or 
>> enums instead of having 0/1/2 cases. As a matter of fact, we can 
>> always call it RING_0 RING_1 and so on.
> 
> I strongly disagree. Adding macros or enums just to have names for the 
> numbered rings doesn't gives you any advantage at all. That's just extra 
> loc.
> 

Honestly, when I just see case '0', its a magic number for me, and is 
making code less readable, harder for review, and even harder to debug. 
RING_0 tells me that we are mapping a ring to a priority, and clarifies 
the intention.

- Shashank

> We could use the ring pointers to identify a ring instead, but using the 
> switch here which is then used inside the init loop is perfectly fine.
> 
> Regards,
> Christian.
> 
>>
>>
>> If this is being done just for the traditional reasons, we can have a 
>> separate patch to replace it across the driver as well.
>>
>> - Shashank
>>
>>
>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>> +    case 1:
>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>> +    case 2:
>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>> +    default:
>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>> +    }
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> index d74c62b49795..938ee73dfbfc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>>>       VCN_UNIFIED_RING,
>>>   };
>>>   +enum vcn_enc_ring_priority {
>>> +    AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
>>> +    AMDGPU_VCN_ENC_PRIO_HIGH,
>>> +    AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
>>> +    AMDGPU_VCN_ENC_PRIO_MAX
>>> +};
>>> +
>>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>>> @@ -308,4 +315,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout);
>>>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
>>> timeout);
>>>   +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index);
>>> +
>>>   #endif
>>>
> 
