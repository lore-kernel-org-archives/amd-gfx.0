Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1866C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1741128FB;
	Thu,  2 Jun 2022 13:44:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606E31129BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgQad9GRvKfMEMm0I4AjbebgMCWQTITvQYmYSAej209EGdAt8bxTnrvEj/nCgRV5aDU0zlvqOAF2qDgmuyHmCZolWO0xX2SsNYtF4CS8hZ/J+ORo8LCYfcv1jq1Rwk9fz8h+rlDuYkqaYaVjDKzgoAVTALT+3T7ATPv5xexGBjIQHzEFnbiRPL0WAkmzidcPMCLsSvpRXBUP9Hckfkux/VTmpiko9hbtWz47nGUPel9uxUZsqhESGuwlmH8go9hHKMR6G3JG/AqLovk0wDloGuyjwTcrZlsd9nFGVxUI92TYCP+TZDAPCwCAmephhg5ZzyaVmull6eEvNu9l8PFQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuflyyX1rwLrxuiCOwVUUBQMBTgj1hSoCr2ylqggDjI=;
 b=cXlWen14vjcujeD/TJFYwLrQJPfhuELuKnZzbmSyqbYptsc0JoHaEdRWJr2GfJTko5dwhlv3XZMaxfA7t/pxf9Rbu/iV+lFlEB/Z/WhR8AfuRFKtPH/FsWXohP8K2UzVHifq80EkrDtBcQfexKsW3r/ByvrECZu7crT1oQnhqTxy8jF92GVxl1Ws02Fb+x1t5ThAoSirbLp/vdtMFCTwxdwhV5evcCfaipb6drLeV5B/T1NdWufBqnzKN/HEDyFU+fYUSVgrzdTqFphz4RCc2nMaGPVywhWWYmDmY/G33H0Z91bgUDT9JIumf1a3l5it4P4gwneuFaozb5u996xnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuflyyX1rwLrxuiCOwVUUBQMBTgj1hSoCr2ylqggDjI=;
 b=vp6ktBgb9HwQ3a3EMawj81O2o2C98i/KFr0OiCiai8Y3gPq99BU74HTFRBRDEx51su85AyJjohGCvLbSNm3kX97oOzC0NU0UJ19yFZqmi6dAUg1aJH80bSkH9nlGnRPmV0o2objkhHSKrYlR4w5q1NfjqOKureutiFJEFGrYkuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 13:44:49 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 13:44:48 +0000
Message-ID: <0b8999ec-7bd3-930f-1fc7-80826d155d41@amd.com>
Date: Thu, 2 Jun 2022 19:14:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602132029.6225-1-Philip.Yang@amd.com>
 <60a9c99f-5a19-fd31-d4f5-ccf81717e3e2@amd.com>
 <cf5e5888-3857-9e23-e202-1e274ba690d4@amd.com>
 <912af5b5-219d-b104-76fc-52b3c9e89979@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <912af5b5-219d-b104-76fc-52b3c9e89979@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eb319de-868f-4c20-29bf-08da449e0fa5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5292:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5292A16BB3EA851E7BA314A897DE9@BN9PR12MB5292.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSQw0ZE3uOlhWXUJdpj4gsJJFV1ZQDbYFswmuNa+55XMpM14lz32t78hsY889qmNGs0LMgbo/IJlAqzgYYzTB5mjHPU984+ugT839l/08s12HBXnZQHvXEqTCJYqcb/hoeNyoze0Sui3zZUXGW3mpJwWiBg3TrK8D5WfguM2Uzxofvy+8Yo0lrob8B+IQD0TzFTSmVVa3P1mgAoQUwToSEARR3ktbkrcVrsRxHPAxzhC6k46urLZR631PdLf7nksoGVuDrU2fwLQaCH1CznNgs9ryWeh41Nbo+HkglxQAvn8a0ytm4D8Ah1HCwAaWuy9fDxjUJYLC+WUj6oe61M9/R1o0BRXPhN3eJydl8ksHo+0EUaU5JMwkasgxe+emGPMnBO/e3QqG5w71565aB4H7RaIMEX8+wBTKtN2qL2PJF5SWLyzKn5BJ6jKf2XzegC1zcGxqO8x+BZZycX6SOMJLwJkDGBDLaEO9yyqR34LMgkq45hinmC2eLmP0U9Sggh8PCPcCaw2wcz64KfN3pLzk2pHXX7xY6ws4SZKSL363sad6MUSx/yj/iKWt1lhNWgx5CdZjjKsxtWR7M7FRZplHnciQrauZyjsFgzwRC0/rohdETYTJaLtuHPHfNRGQDqtRiGDAeU1RsyQnELKzHBjupSNmyF472CuLISa0Fl2BG7D8jqBCZCWuKPaItLBd6QhW4GzC+aNh1feQlBL5dK84xeWJtrUHFo13wAAFfzsKWR+sKQ6sEIXPWjhcUUgkAtU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(53546011)(508600001)(8676002)(2906002)(15650500001)(66946007)(66476007)(316002)(66556008)(110136005)(2616005)(6512007)(5660300002)(26005)(8936002)(36756003)(31696002)(86362001)(31686004)(83380400001)(186003)(38100700002)(6666004)(6506007)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1hSTZ4SkhHQndIcDh0L0lOV0wvS0FtRUsra1d0c0VtM2NKNUlCbHpjTytX?=
 =?utf-8?B?Q2t6cmh3dWlNdVBhME95dTZtZ1dBYkdValR4QnFNNHZGekU5YmhGYUVlZFZ0?=
 =?utf-8?B?UXNsSFRJb2ZzK09sRSt1aitsU3NDQ0pxOUFJZHBiL0VZRXdvZjI1OWV2eE5a?=
 =?utf-8?B?ZHJlME9WbWpNaEpvSG0vQTUzTWIvNDdGam9Xd3RGOWJCWEd2TkJsVkZpYXdq?=
 =?utf-8?B?SXBsWlZsaGhTVXl3N0tKY05jUjhhU0VxVkkrREZRNTJNL1cvY0t1eVJjQXFh?=
 =?utf-8?B?dE5WV2wyR3o5U3R5QU9BUlU4Tnpxd1BNNFRTV2xVZXQxeTlDS0drbEJ5Rm01?=
 =?utf-8?B?VHRRNDNLQzhia3JaNE5zTHk4WEozdnpJVWFtUTdSc0xZODRJdDZkNG5QMkxr?=
 =?utf-8?B?dmFpSEJ6a01yUUR5RDZxZm1jSDVReVRMUXV0WVg0aHhacjNoSkJaTFdtczNW?=
 =?utf-8?B?aUVScHRVbHM4dlhUNjRxSXF1UENhK04xbnVOQmpGaFR1Ykl0NDNaMmFrdHE1?=
 =?utf-8?B?OHhTbXNER1BYejc0VGtoZzMxa0FqK3REWVJybUpxUSt5bzZROGxwdm81M2FM?=
 =?utf-8?B?eWRpRHNNU1N1NXdhcEtaR0N2TWFFWHdNZkVpWE15RDVXeGYyd0Z1eG9aMVBJ?=
 =?utf-8?B?dVo0SGZPNUxjYjNqN3ZkOVB5NTdsMUNGRUdhb1BlZlRQOFIwVDVDYmF5ZEJr?=
 =?utf-8?B?WmE1Um5JODdvZFhXZkREdTFTU1BkZHRzeFR1RGd1d1VKWkNmQzBDdWM4SnVQ?=
 =?utf-8?B?YWJmY1BreDYrcENmZWNnSGx1VU1CQ0xoRU9sd1h6d2c5TDlXdWY3bDdodTZE?=
 =?utf-8?B?eTE3QmhNeWhjeElhdFdqdXZyNXBOMUdtOVYwc2VuRjIyUFFxZXdXSnBCZm1L?=
 =?utf-8?B?d0hQbUV0V2NaZ2kwekNSdmhYV2x2cG1TQ3g1WDZ6N2hhSFVFRFpDQUpCOWpw?=
 =?utf-8?B?L0R5WTMyU05KVEdUSVV3TEIzVnIrRkEzanBqdnlDVE03UndIZnJIY2lDTCtM?=
 =?utf-8?B?WFJOTDlRTENzMUpiNXVTTXJxR2p6ck1iY0FuQWJSY0ZHVEZGTzQ1YnN5OHM0?=
 =?utf-8?B?K1Z2QlFyZDdTSWFqbytUdi9zcHZiUGFSd05rWEdVU1h2cGZvTkNPMU5FTzZh?=
 =?utf-8?B?akVQSTlVMTQwdTNKaCt6elowcHdUSGFENUtOMTJWTzhjTldpWnBzcGRrMFZH?=
 =?utf-8?B?Y0xyOUJKZVl4SVcwUzNCVWtpQVM0bFJNOHhrTU1EZmZ2SCtxSURGRGZLRTJG?=
 =?utf-8?B?SXg5UHR3ZlNsODljMmRJR25sL1VDMmdXWnlPQUVhdThPSGpsc0hBYXFHajc1?=
 =?utf-8?B?VWJRVUVPTlNmaTl1Yll3NWkvM2J6eTNvYkFPd1NFN01JMjlnMWYybkFoS0xr?=
 =?utf-8?B?d2RXMC9QQTBGL1ROaGt6VmY2WXJTU3ZmL3FxQ3VBUmRDck9uL0ZiT0pEY1M0?=
 =?utf-8?B?d1grQ3hFdnFUZC9iSmJ6dDk5VHVncDd2T3FUNXJhUFZGbkpTSnJEYnhTOWdo?=
 =?utf-8?B?THdOTE5TK2NLWDBFRG1XSC92S1lydGkya1dNZldFaHZQaWV1dVBTNU5LVFRm?=
 =?utf-8?B?cGVyd2VtTFFlcXZlb1g3Y0FoWG5LWUx2aE14Z3BTSUFGT3BMeWJxYjFQbnJ6?=
 =?utf-8?B?aUN5SW1LdlpxUmpJczFvQVBNSzc5TlZkMVl3bXh3TG9LRmhCMHN0a1ppVXBJ?=
 =?utf-8?B?Vk5OcERiYkFzYWtFYktnc1dpV3FaNHp5Y3NvVEt4b3dIRnc0YW9TbWtLN1dT?=
 =?utf-8?B?UkFNcFpFcEFsSWkxRDB3OGpmaDlwVnUrSVkwTExPSXFPRnZBemYxQ1l1MGgx?=
 =?utf-8?B?LzNhVk5DQXZTbDBuREJFR2FCMGhlTUVhYTFiN01hMG5QbG9VTmZiOWVYaS93?=
 =?utf-8?B?MDJFbVNUL2g0VkxuTlJrejVGN1d1SjJEMlJRQWFpNTU4L0lGQzY4aXNMbW4y?=
 =?utf-8?B?enlxNjU3MlFmQysyR3BUNDF3aituZnNaL1pnVzlCR1I5aGlKNUw3L1BJYU1u?=
 =?utf-8?B?SzJLSzM2VE93V2FqYzRiK09xVVVLKytlN2FBTVhnRkU5NlA1Q1VjYjh3WVNs?=
 =?utf-8?B?aW9ZSGQvM3RYMUg2cE0rWkJ4RUFRZ1JqcFZocDhtQU4yM0lOL3ZvK0Q3dHdy?=
 =?utf-8?B?Umh1V1FUVElZV3JEaU9ubkE4L09IYUVpZTlUZnRLWk5MMXhkR0FFblpSTUhW?=
 =?utf-8?B?blFmaFQyOXpZdEcvdUZ0YnplQ0d3L1FnTzcvTkhHTHhIcVQraUhMdGRrbFM0?=
 =?utf-8?B?TnZOOVQwbWw0RGZCN3pON05NNzl2blNzWkdEUEx1RUdlWnRoeWlkazhmVWNB?=
 =?utf-8?B?MVpJQnZyMXRVMXFyRnNWNkozQ1dGUloxUnVacitrdjljbWtlNkF2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb319de-868f-4c20-29bf-08da449e0fa5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:44:48.7631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1osAhiT87C0DaVEjXgWjV41iganEPNuGkX+Hbjok54dnOGD3nEBTLuYkygemUWGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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



On 6/2/2022 7:06 PM, Christian König wrote:
> Am 02.06.22 um 15:26 schrieb Lazar, Lijo:
>>
>>
>> On 6/2/2022 6:54 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 6/2/2022 6:50 PM, Philip Yang wrote:
>>>> Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
>>>> but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
>>>> the page table, which commonly happens when memory is mapped for the
>>>> first time.
>>>>
>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 9596c22fded6..1ea204218903 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>>> *adev,
>>>>   {
>>>>       struct amdgpu_vm_update_params params;
>>>>       struct amdgpu_vm_bo_base *entry;
>>>> +    bool flush_tlb_needed = false;
>>>>       int r, idx;
>>>>       if (list_empty(&vm->relocated))
>>>> @@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>>> *adev,
>>>>           goto error;
>>>>       list_for_each_entry(entry, &vm->relocated, vm_status) {
>>>> +        /* vm_flush_needed after updating moved PDEs */
>>>> +        flush_tlb_needed |= entry->moved;
>>>
>>> That is a strange thing to do for a bool variable. Why not just 
>>> assign it?
>>>
>>
>> Hmm.. In a loop, perhaps you meant logical OR?
> 
> Well IIRC C doesn't have a logical or assignment operator "||=", so "|=" 
> is used instead which also gets the job done.
> 

var = var || value;  also will work.

BTW, v1 of this patch was incrementing vm->tlb_seq for every entry 
moved. This one increments only once. So is this vm->tlb_seq required 
only to be a bool?

Thanks,
Lijo

> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Thanks,
>>> Lijo
>>>
>>>> +
>>>>           r = amdgpu_vm_pde_update(&params, entry);
>>>>           if (r)
>>>>               goto error;
>>>> @@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>>> *adev,
>>>>       if (r)
>>>>           goto error;
>>>> -    /* vm_flush_needed after updating PDEs */
>>>> -    atomic64_inc(&vm->tlb_seq);
>>>> +    if (flush_tlb_needed)
>>>> +        atomic64_inc(&vm->tlb_seq);
>>>>       while (!list_empty(&vm->relocated)) {
>>>>           entry = list_first_entry(&vm->relocated,
>>>>
> 
