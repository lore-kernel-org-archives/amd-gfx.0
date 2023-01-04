Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DDDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4726710E44F;
	Wed,  4 Jan 2023 14:41:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134D310E220
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPC7MGPKuDGiE1GSrhHBvK1fm3PQflVfzRYMPUZFPf39N/yEhUbut7WyL9VoAjX2QT7bztTGQUUi5YH9g6FdrnWST9UictgrtEcvTjH+8YZxgPgoTxgWI5x87aAOEl/JZ4fAYv75VwiEoGaBOzQ9kNwc9dikgr8B6v6TdWFNe9xbb9s8CUtxu0LRUOoL5OxMVY+apT0ZbpZjPB3cVu48QAhG2C+h8GtfiE/bSWHLmGehWFVZE2iV/oNmUyTZNkkSA2N9ty4XMIjHN5gAfsM0fcC0dEmUHGGDZ5w8lsV/JNw2sy2YUzkixF74tJnJjr3pnYSFm9xgS2crgTP6OukQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKx/lyhJbPoHl0S9krzwDBQaUcpX2pmeitjkr52iIBM=;
 b=cP0G3dePuBEVBkfWiZekbyD27u4QEQIdRZiVRjtonSe9Egi1mSrVgxznERubbatxtsinGLUIYITCejoRz9q2ltDnNUHRrtetfexGCHo2E5nL3bx9iv026oOjX10AAcJAV4b43Waez1FbgHIzgN1LU1wDO0GTJXPdeEBC49yvBkDJJkZduJipC3kdFamAgNywOzN1lV1kC0agq0KlSteXJ6kmY1JQkmSsdRq7Fv64d0/W6wkn4Dp5eouazQcm3oiVbFba9n0OExf+O+4TzXnguhDS4fk/Y0fudqUOB1f8OAkK94AInCOAQy/lG87ywnB2uI5s3m+vqFbR4/qNhTVwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKx/lyhJbPoHl0S9krzwDBQaUcpX2pmeitjkr52iIBM=;
 b=jLUaYRFkUpDojLf7Yi/+86tVAD33kY50tmYUq65D/NcNyzTWqBfURbCMcx87n+85krDaKKifx0YGsRz7GY/sIT/WYBcYHLUh3POi2B+L+0S3dXqKGRDKrLxFD7R0tTjepLwcaVwiuYqd1LKAlPzb8XUhh/JRzgWWRrsOj1mwZPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:41:38 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:41:38 +0000
Message-ID: <38e4d463-9595-02f4-d79f-bb165e2eaa38@amd.com>
Date: Wed, 4 Jan 2023 15:41:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
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
 <b4a601d4-4d08-fea7-5eaa-772194fd6b1a@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <b4a601d4-4d08-fea7-5eaa-772194fd6b1a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b6a940-3adc-4ebe-79e7-08daee61c8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ES/WIqsH8C8+T4naly2ynTBq8JrgImbiED21adX9kdsUSSK3oSofrbYrhCKVLhdpKHWHp4dgOGOxnTR2dYOVEcp0hqNgcV7jJp85afQ+Kv9ksOJhMPzKP05WIbZ7jTAhQ0kE7YNg0Tl5fmTDXhgiuencQ4co0Z4FNnZEX05gnJlBImpIXKV8PVLJ4MDowsr7A5JhniY9NxEtni2D+ER5guvi+ZPuIMEeioMD73EGVCYy95+hbTskNppZo/37Nj4VI/xoMBNDZBRoT/ROFmBQ9t31rtVTmcrvCgbezI+uLO+fi+V60qAsqayNYYfuHOpTTou2YPaAM5+9Oo3xtRwZq8AsGgkMBLTBtfU1HC7MqodnhTjW3tY4PpEVJcaEFWzkj4NByp3MSL9+5XpJYwCZCvY4mScvMqrXhuA+BoKS3eLq2r/GCkKdZw5K24YIq2GZB1xces/vonHfDwF+JAlqUzSj99lxS7O2c1iQLQQSc9wXrYNAMBL/cyG7Vhred+riAJDiRXNnaB0J/dadeR3YLXSoOAcZ93NNopItSQu304o6mSkm0GlW8qaxyoX6KjE8XF0naArRXjWiN5krjmfOgngsLY+l3BxY5wdFiPziekLuraI+iagW2cnZ07PaKx/TNpu2SL1P7egO6JuZorkTt3BplMmZfiQER6AMwkIbcxDruSCn5LQvpcuefdgGau66jc8PLTr0zq6EobYNfJhKeWy/rAisZUW/qohEQ0fseLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(6506007)(53546011)(26005)(110136005)(36756003)(478600001)(6666004)(86362001)(38100700002)(31696002)(6512007)(2616005)(186003)(6486002)(66574015)(83380400001)(5660300002)(44832011)(31686004)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SitlY1hNZVk2RkpDTUtpbHpCWkZad2g3ZGlQWFVrSGlEYjZ3ZVViVW1jVlZn?=
 =?utf-8?B?b2F2M1pwOEZVeDl1bWVHT1VZZlJCK1RlTlVaV3ZLQ0VPZEFJVmo4VHRMb2hM?=
 =?utf-8?B?MkJCTzhqdHdVNG9LMjFjZnVMd0g0V1RSOFdGdWRzK3JwczE1Y0RkQk1WYWk3?=
 =?utf-8?B?b1BVQXByVExNaFVYZkpXNzdiTWM2M3VQcmU5Z3NvREEreW5pNXc4MVRFTkNt?=
 =?utf-8?B?R2dlTTdoUTFSeUlzekpFY1NOa0NDdjI4S216WVM0SFIweEZNb09MdHFtNGpp?=
 =?utf-8?B?QjBDaXJ3M002TEdqTlJtajU4bHBMTXhNY29jcVZXeHFUSkJZbmVyZGZBVHc3?=
 =?utf-8?B?Q0ZKVHBCdmgrN0RvOXIybnN4M3ZVeDk2a0JhZzAwV0lDUHRrMUs1a1cxZ2FJ?=
 =?utf-8?B?MjZoR2tsemN1VkZvcVlxdWVCekVXejBBYjZYeWZqREhTY2xXRzlLVEtESjVI?=
 =?utf-8?B?eVM1SWNFRlZueEZnVW1DNUdpT1p4MGlDVlRSZ2hXNm1WMDhzSXpkQzcrc2Nl?=
 =?utf-8?B?Ym5iT2loM2xrb1plOXhOclpySk1QeUc4ZTFjcjM3ZUFRUlNCTTVoNFJHc1RN?=
 =?utf-8?B?SlVOS0F0MmJBd3hTM3RtakpnajYrQ2NsNkFJZm1najRVaGxyQlZweEpHb2gz?=
 =?utf-8?B?L24zc2NUTG5HY2lVaUdDcmtzZmwrYUhGQVN0bzNsZHpGd3JXYlBMam93MHk5?=
 =?utf-8?B?N2piRTlYdFBpSWVmVUFld2JsdmdVVnJGZy85b2NucEl2UjExVWYvbkhkeVlC?=
 =?utf-8?B?N1dHRExjSUN6TTRrUEd2ZVgrbU5NUUt3SzZtK0dSMW5FUjVnTkRSQ0tNMmpI?=
 =?utf-8?B?alBsQXBiNllubVlGdVNQSC84YnlZLzF3TWZqcm5TOVcyeFhsRTBBZDhTWEF3?=
 =?utf-8?B?OE1uYkFMSFhTbG1qajQzc01sMDcrZTJScnFoTFdRbTR0OVV3NisrN2FIeWhU?=
 =?utf-8?B?c2twVDVUb1hRRUN2dXdRZ2w1TlBLb0VvV3F6S3hjWE9UMGk2bjdRSFNMbks4?=
 =?utf-8?B?Q3k5OEo1UG5laGp2dHYvVFhDS0xDVnp3QTlHRjBqcGFqOTVvUERaT0NWVU9V?=
 =?utf-8?B?Z2tzR2UzYmJ1Z0grWUhnOTlodkFnd20vR3FiRkpEK2xIcGtuckYxL0dIYmdv?=
 =?utf-8?B?dnZCb1Fpck5zclV4RkdHcVVYa0pkRHgvYlhEQWxXbU1FU3M4VlBreWlWN3RY?=
 =?utf-8?B?WGlKMis4Rk0wSmRQVUk0YkNtcG13UG52RmpJUmord1ZiLzRsTmJFSUlKOGYw?=
 =?utf-8?B?am1HWjBDNUNZSThtRTZrNkZWai9EU2Y5QUFhdlArZkU3bGVsaTQyZlhxTU5D?=
 =?utf-8?B?dDYvMVVvRFFUQWtBQ0YvOUs2OEw3cmFjL2pIaXhqZ2tEOG5KVldOekgvSmo3?=
 =?utf-8?B?ZS9QZTIvMHNnZ1JMeVVOVU9hTEsySDZQNWhpMmk3TUFMblc3MGgweDdwQzBV?=
 =?utf-8?B?ZnVQMi9CVTVEVk5rbHFIUXhBRXo3eHppdEpBbytHYmpib1d3ZFNKQkN1dVFB?=
 =?utf-8?B?dFdwQ2pBY21BWU9rUklYd0dCQUdtZ3Q4S0FkYlFvYmtycENpdVg3Vzh2OVB2?=
 =?utf-8?B?Rkx2MUtyaWtDNm91Wnl0bTBoQmNwNjVRNHVWVVhsNURGQjVlOVhKSEFlWkZr?=
 =?utf-8?B?akIwYW94S2krSGxEZjJFWFF4Y2k0YzhwK3gzWTJVVWlxWmF0ZXVTTVZOMUF4?=
 =?utf-8?B?UjlQVXVkWmNLZjBBYVBzRVV6ZS9MMGl0TXVBUURrSTV6OUZKamtlbFJZa2R1?=
 =?utf-8?B?TDRXWENoR2FiU3dNMUhLTnpySk80Wlo5K0ppVFN5cUNTcFRWUHBVRG5zMi8r?=
 =?utf-8?B?aldkRGFqSDYyZW5tMzBuUkwxWm9vbXJJeHFvdFljZlZQTjFQTTNST09wN0hY?=
 =?utf-8?B?V1J5c2F2U0NiaUpWSmpXb1BlRVF1ZjZLZnUvL0hOa2U3OEM3OGdVQTN4ZVRi?=
 =?utf-8?B?ZXZ0WGNqRUo0cnllVVcxT0thS2s4MmlpRFFnaE5RUUluMDNhY3NocG9OOTZt?=
 =?utf-8?B?Y3JjR3Rha2lFM1dhMUhyQTE1NzFTQWd1RHFkY0I1MjhIMmlnb0phbzB0eFRn?=
 =?utf-8?B?TUJzdXV6bW9RdjJvT0Uwd29Dc1N1VG9qOWlvTkt1QTVpaHdvNEQvTGxSRUlI?=
 =?utf-8?Q?5RnNBvSdmR8l5ZrBtoHtm8x7M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6a940-3adc-4ebe-79e7-08daee61c8f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 14:41:37.9837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVz/R31pZqmamXDwEjDEo6jWTjnyUFRllYzdffbrxVyt0G4D3zBs9OZ88HaVelvqttLl8jEXlF0iQmvimp0r8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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


On 04/01/2023 15:35, Felix Kuehling wrote:
> Am 2023-01-04 um 04:23 schrieb Shashank Sharma:
>>
>> On 04/01/2023 10:17, Christian König wrote:
>>> Am 04.01.23 um 10:13 schrieb Shashank Sharma:
>>>>
>>>> On 04/01/2023 10:10, Christian König wrote:
>>>>> Am 04.01.23 um 07:21 schrieb Yadav, Arvind:
>>>>>>
>>>>>> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
>>>>>>> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>>>>>>>> /*MQD struct for usermode Queue*/
>>>>>>>>>> +struct amdgpu_usermode_queue_mqd
>>>>>>>>> This is specific to GC 11.  Every IP and version will have its 
>>>>>>>>> own MQD
>>>>>>>>> format.  That should live in the IP specific code, not the 
>>>>>>>>> generic
>>>>>>>>> code.  We already have the generic MQD parameters that we need 
>>>>>>>>> from
>>>>>>>>> the userq IOCTL.
>>>>>>>>
>>>>>>>> Noted, we can separate out the generic parameters from gen 
>>>>>>>> specific parameter, and will try to wrap it around the generic 
>>>>>>>> structure.
>>>>>>>>
>>>>>>>> - Shashank
>>>>>>>
>>>>>>> Is there a reason why you can't use "struct v11_compute_mqd" 
>>>>>>> from v11_structs.h?
>>>>>>
>>>>>> Hi Felix,
>>>>>>
>>>>>> Yes,  V11_compute_mqd does not have these below member which is 
>>>>>> needed for usermode queue.
>>>>>>
>>>>>>     uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>>>>     uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>>>>     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>>>>>>     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>>>>>>     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>>>>     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>>>>     uint32_t shadow_initialized; // offset: 6  (0x6)
>>>>>>     uint32_t ib_vmid; // offset: 7  (0x7)
>>>>>>
>>>>>> So we had to add new MQD structs.
>>>>>
>>>>> Would it make more sense to update the existing MQD structures 
>>>>> than adding new ones?
>>>>>
>>>> Imo, It might be a bit complicated in the bring-up state, but we 
>>>> can take a note of converting this structure into a union of two, 
>>>> or may be renaming it into a superset structure.
>>>
>>> Union? Does that mean we have stuff which is individual for both 
>>> versions of the struct?
>> So far it seems like Gfx MQD structure is a superset of two, but we 
>> have not compared them neck-to-neck yet, hence I feel like we can 
>> defer this task for sometime (but add into to-do list).
>
> v11_gfx_mqd has these fields reserved. Updating the definition with 
> the fields you need should not be a problem. v11_gfx_mqd is already 
> used in gfx_v11_0.c.
>
> The firmware shouldn't care much whether a queue is a kernel mode 
> queue or a user mode queue. The MQD layout should be the same. So 
> having two different structure definitions in two different places 
> doesn't make sense. I don't think it's wise to leave this for cleanup 
> later. That would only cause churn and ultimately more work than doing 
> the right thing in the first place.
>
> Regards,
>   Felix
>
Hey Felix, noted, we will try to reuse this same structure.

- Shashank

>
>
>>>
>>> BTW: Could we drop the "// offset:" stuff? This could cause problems 
>>> with automated checkers.
>>
>> Sure, we will do it.
>>
>> - Shashank
>>
>>>
>>> Christian.
>>>
>>>>
>>>> - Shashank
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> thanks
>>>>>>
>>>>>> ~arvind
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>
>>>
