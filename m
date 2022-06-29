Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F38C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 22:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A58D10F065;
	Wed, 29 Jun 2022 22:53:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCD410F065
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 22:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZC6GuLBULRenF9JZP8wGscwCkPFJTJT1rRUqgJySK/UC2m3tqBjFLN6DN19Aq8jk5KL+Cb1odIAEs33HM6D5ewBLNgAjknGvfYaVgtZ9zV9NsFgVjA3sSu2hDaxFTalAermWPM9s5pKJBc2WdvmSTw0/3pbfarZSL3v366FN0EX5FCWdSSt4uWp1OWtDmDYr5yN4nZJIF9ExdFG6bpaUsg0w3vt5QBSnwrRlfInW68i9ycYyPWhOQA5A3bmCKkXFueoOYS2jCM47IsU4NleO+HfqctBqxbNfLlnrt84bvzEbGJ7KGxAu+4vvEQA4xXF5CcbwMQVAl8z6uUCxmtTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIXTTjkBA1avX6zxC+wxBpC+hATJI0OoJbQwi7cCBhQ=;
 b=FlxxXONh79Y7Gu8Hegkn95GGBeh4jHyEiOOjbACK4uSc8SoImTf9T4lg3fJMLS6CbR0sYXf0EExa0B2Fh8lrV5XasySzQkk7SGKylGfNLTxWZIZNlze5xKmhivuhOq8XkAIGUw5XJK3wsTgMFPI/kuQrPBjJt+GbUOb6nQQ+orInRwL3VmpAU34yjzH2rjfLRqk+xDhTWJJB15jPFQlOsBZCUsMJYOfvnsstPlI5bt+3QYtINSoL7p9QRMkC7ZxuHL0vKtdg0QhPrcykp7N6qiMA0VpDq9CVT/rcP6QWLqBNrlw7ClE4bnD6o86rqzTXRcz2QzKbW39EBLQjBBCYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIXTTjkBA1avX6zxC+wxBpC+hATJI0OoJbQwi7cCBhQ=;
 b=AQQP7tPFHj10YGZEwseIupXiAffZ00zh3hSQkDzrmJPPfMk5bJwH0UbZDn7gpw4lapaBrqI0xQ6aoWhoqp5v5i22tOF+GiebUTodmZWutONXbf0mKWqECxBn9/b3vaZX586FGNpKAcH/NE5p7SPBYQSqKm0No/QgmWAwVmd1PpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 22:53:17 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::11d:b3f1:abd4:f4f5]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::11d:b3f1:abd4:f4f5%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 22:53:15 +0000
Message-ID: <4bf772cd-f66a-2dc6-4ace-81c56e3f6436@amd.com>
Date: Wed, 29 Jun 2022 18:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] drm/amdkfd: change svm range evict
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
 <20220628214315.235160-3-jinhuieric.huang@amd.com>
 <99b8907f-9aa7-7aec-4895-cc94b0b58bec@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <99b8907f-9aa7-7aec-4895-cc94b0b58bec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:207:3d::41) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f7d543a-6ebb-486c-a819-08da5a2226a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEsnuyTGkbzZlV7mIsWPryvrXh1f4JrCFzgMQSmChiyRk3vCSHhoWMZVRmktlmI7ibQ991stjo5opNb8PVQHkUWCf9xghrPNPo6XZnNQs40D2u1NEgk51/LiRhl06RBBaSH5vTHxXS3PTIHF5mEQeoLiBgr72K7cL0sMJLSLRtbk6agszI28NGEi9HtmSmM9P2umKFWPeis5fWKT72NXV5U+80MIYUJg8a1rq4kjpmbFB2qichyJy4AUqMKS/Ld/DVuq/d5LhQTz7yF0JNLlC/W0RO9GWdAhqf/FliVEqrXmI35xCF3RUUPsoVmjqhDXXv0ktFx5p1fXNrYW9CLGvEAsXnROoUjNinEA0kMNsfpJRQqVrDN5j3IKeZPMO4w+Ctcf66lehf8d1jIQeTNzwdtmO3du/NxSVzxiw6WZ341B7aR7u5pCusxZ6lPsogT0BlDRjlxv43tzr0JY9XAuYHenYUFg8d7tbaNFW3CxyGepjyQqBuF/5yrXOhIxG4O5lrG5sDeksqtZrTu7y3sapXBNgY0W+Iqr6gAlgmAYvLW6+kqs2WjGRa9KYLdDbmXcI8bS4GJ2C/ZZp0VNVrBbsTWylouSfWo4QHq5Ce8c69h9aNTC3f1IK5OuuZWbAEBZ8XURMb6QD9/wJ2QfTYrKNuH9494NbgEbpWj8h3ZZJnuytf/a1CTm6hsChKV+moxLyZtz76e5FNRIx3vZ/BLtCU/9iajVh3PsdMK+oPJiDxBDcLh2O5JGWcb/3zZ0IBBjMfJG1vM7QCzBwhWCafVZD9sXXKK4GybvzUD5L0z3H7D8QAnTYHw1nN4aykqe8+QX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(2616005)(6486002)(31696002)(186003)(8676002)(6506007)(6666004)(53546011)(41300700001)(83380400001)(6512007)(8936002)(478600001)(36756003)(5660300002)(2906002)(86362001)(66476007)(316002)(4326008)(31686004)(66556008)(66946007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lJMXdPYmlvTjE5a1c2d0l5WW5CUXBNVXE4bElIcjZ0YWMxOEVMUlNpeE5L?=
 =?utf-8?B?bGU5ZjdtWWVsVWpaRmdpSksybFFqVE5WVnVNZE13cDZZMm5xUTNiVmQvcjYx?=
 =?utf-8?B?UWxyZkYrdmpSQk1jMjIvZkZMQUFxcU5JRU5sRFl6TUZ3RDNqYm1LWFUwYzdS?=
 =?utf-8?B?K2tCeVBYUW5UTTltTEtVRWlnUDFTcXNZcXFRcmlnU21UVVNBNmY0c0s2T0cz?=
 =?utf-8?B?OHk4VXhGdTVxQUYzNTd3a0VhUVFnSldaYjVWaGlwb0wwSGxxeWttVVorN1Ez?=
 =?utf-8?B?aisrd0VCMkx2UXU0MXArS3FqRG5FS2ZaZllEV21oUHJZK0dnRWIrYjZtVE1E?=
 =?utf-8?B?UjEzTDhCRzgycWxrM3JMZ2JVQ2lzbStiV3pUMVRlMkRUV3djWjhvUytXZ3lT?=
 =?utf-8?B?bkFla2J0eEdINWEzaXhVdGZWaW40NEY5NSt5TXZyaTZKVEJHWlFWV3E3Z3FJ?=
 =?utf-8?B?SlQzMGI2Z1lhMzc4ZHpJNm05SENQL3VTTDl6U0NkZDc3R012Yk5GSFBqQzFY?=
 =?utf-8?B?Smc4MnVLN3pjeVRNU25WNFRZUlV1YXpOem5ZVnJza3ZnR1hGaDVaakV0YU9D?=
 =?utf-8?B?VVlSdnpiVzZqWTFmQXBIeld5RDEreGp2UDE1MlZpbmY0alFQMDg0cmFjbmxW?=
 =?utf-8?B?VW8wNG04SmZwb05CcVA5WjNnU3k5Tm4yb0E4NUhDTEZhSGg3RTFCbkNPMWJ1?=
 =?utf-8?B?K0Jkd1YxNU1GQmRtYmRJd2xLcEkwUDdZYmFKQ0tyZ2s2OHp3bmtFdkdUVUQ5?=
 =?utf-8?B?NUw0UWFmcnFJa2NsbmE1Lys5ZlMxc1A3eVhGQmIvWFdUN09lVE5WblEvOGpU?=
 =?utf-8?B?Q01yMmR3QzhoSmljcE9QYUlsMEZIbUZqaEpkRkQzSWsxU0ZNZnd2WTg2QTlV?=
 =?utf-8?B?bXA1RVowdnNlNHdtMjg4R3ZYN2s0dythNHJhSGVURWZHOTlSUmdFbEFaR0JX?=
 =?utf-8?B?Z1hmTHdaOEpqdjdnc25KVm00S1Y5ZiswUTVPS25FQ0JwWjRGOXk3bFgvWk4z?=
 =?utf-8?B?K2dvUkRzMVJGMHA1WFRCaHBpczI3dmtObS8wclI4TGVJWnl2OTI4VGVDcWxW?=
 =?utf-8?B?Z0JTc29QMjhtZUN4MGxwaTJYODl6REhpdUpVS3MzZDk3eVhaL1BmL2pTK3Zt?=
 =?utf-8?B?MU1OSXdVZnU1dFVSTGg4T1h0SitJRHhUdEVKUGpqK2t3N09hZzlZZnV0OTlX?=
 =?utf-8?B?QVFtYkU1blpzL0NSRlA5RGpXTEViRW1sb3ZXdHVsbFZveTQzRm4rMDh5NHJj?=
 =?utf-8?B?eHdTcy9DaWoyVnJjOVNWTWxiOGhpYllncTdLMjE3cEhsUlR3cnplQWE1aG8v?=
 =?utf-8?B?NWZTc0l0SEY3aTg0ZjRIWmY4TGZHUW5NeUxsbkFFek1nTU1IYjg5d3Z3MnF3?=
 =?utf-8?B?TmdlaVc5bHhJd2ZmeU9CTjR2OWxLbEREaEZWNWdyTVZKMHdGYU13bE1pMkd6?=
 =?utf-8?B?blFuTXkvTHViaUEzYkpUc2JEU0VCanVTSmQvRWlBL3VZYWRsTzJNSFZ2VkdB?=
 =?utf-8?B?TTVyZmREdlBtK0N5LzQ1U0VhMTczVDZzajZTYkdhay9pQkdYQ2NzeHMreVpR?=
 =?utf-8?B?dkMzNkRocHlHVnNEVW8rZlU0QWVlUWo1WS9XTHhKNmxNeTVCMEhLTnNmcVNE?=
 =?utf-8?B?Z3RObkRPcmk0ZjNLTm5TT2pNTlBLSHd6YzcyOXdycFlXQWNvNlVqelNFYU4x?=
 =?utf-8?B?R3U2NnhXYWVPM2JZRkJzZVkxUHVYVHNqTkhSY2lScklqUEwzVHFEQ3g0VW9Y?=
 =?utf-8?B?Z01SMkdBSWFCZGNPNEU2VDJpcGpTeUF0NDhONm1EMElIbUkwbWQ0Q2I1UFJ3?=
 =?utf-8?B?MnN1KzFlNnNjaXJoY0o3SUVWL1MvbXc5VHZiZVJvU2lBYXRjbGtGL01ZamZJ?=
 =?utf-8?B?dis4YzNOb0VNd0NBYi9GTFBJN2htbFJrODd6YXlwczdxMUU3NGpXeFVzL1Q3?=
 =?utf-8?B?RDVMb2NxdXdlT2tYZU5vVjV1WlBmTW03WVdMbFV0bDNFL2RJUHdNc1UwaWZV?=
 =?utf-8?B?ZjJPTGRhNlNZbUFjdTJJRUNpYXlZNGRBZkhmaFlwdDY1QlFObXJoMVhtdUw1?=
 =?utf-8?B?cWRUTXo5SUljZjcwMnkrRGVsLzJCNFZoSWsyZ1RWVm5GTVJBa0lvY1dIcTFU?=
 =?utf-8?B?VEJ4aTV3Y3FGclR5RG1zWFRaQ0tLZzRrby9JdFFVNGdyb2NWYUZQRjhPTWlx?=
 =?utf-8?Q?BeBAN7xT1FO4U1ReGA7Fh6d+OKaPHdZtxzanM0+P5NaC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7d543a-6ebb-486c-a819-08da5a2226a2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:53:15.1646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNWdkMT55rBKZ2dQLhQnN7H2irJZ1S4N53AEscnr760O0e6bYMnwie7NvMIF22379zINMLkMOw/5x6LhcwKOPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-29 18:20, Felix Kuehling wrote:
> On 2022-06-28 17:43, Eric Huang wrote:
>> Two changes:
>> 1. reducing unnecessary evict/unmap when range is not mapped to gpu.
>> 2. adding always evict when flags is set to always_mapped.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 4bf2f75f853b..76e817687ef9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1767,12 +1767,16 @@ svm_range_evict(struct svm_range *prange, 
>> struct mm_struct *mm,
>>       struct kfd_process *p;
>>       int r = 0;
>>   +    if (!prange->mapped_to_gpu)
>> +        return 0;
>
> This feels like an unrelated optimization that should be in a separate 
> patch.
>
> But I'm not sure this is correct, because it doesn't consider child 
> ranges. svm_range_unmap_from_gpus already contains this check, so 
> ranges should not be unmapped unnecessarily either way. Is there any 
> other benefit to this change that I'm missing?
I will send another patch separately that considers child ranges. The 
benefit is it will reduce unnecessary queue evicts when allocating 
context save memory, which is unmapped to gpu. It is for efficiency 
reason. On the other hand, without this optimization 
KFDCWSRTest.InterruptRestore fails with queue preemption error. I think 
the reason is the extra queue evicts make HWS too busy to preempt 
existing queues. There is one unmap_queue packet sent to HWS in current 
code, and will be three unmap_queue packets with unified memory 
allocation. So this optimization will keep only one unmap_queue as before.

Regards,
Eric
>
> Regards,
>   Felix
>
>
>> +
>>       p = container_of(svms, struct kfd_process, svms);
>>         pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 
>> 0x%lx]\n",
>>            svms, prange->start, prange->last, start, last);
>>   -    if (!p->xnack_enabled) {
>> +    if (!p->xnack_enabled ||
>> +        (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>>           int evicted_ranges;
>>             list_for_each_entry(pchild, &prange->child_list, 
>> child_list) {
>> @@ -3321,7 +3325,9 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>           if (r)
>>               goto out_unlock_range;
>>   -        if (migrated && !p->xnack_enabled) {
>> +        if (migrated && (!p->xnack_enabled ||
>> +            (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>> +            prange->mapped_to_gpu) {
>>               pr_debug("restore_work will update mappings of GPUs\n");
>>               mutex_unlock(&prange->migrate_mutex);
>>               continue;

