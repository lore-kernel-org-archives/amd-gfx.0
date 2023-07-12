Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D70EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 08:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E161C10E39C;
	Wed, 12 Jul 2023 08:03:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04A210E3BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 08:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en/6XHe0qsDTDGT/qLXF5bzpp194mIU2cE0kT8SaQkvRxdzWFS3P2Orcnv0KC1bQ+ygVUOlN0wUEOInHxxgICqoRi0t2hquVnegI3atYB+QVoZu8nO+aSm7tQqT9v/fxYXEJ3xOlWgBAHsQm9HxJqDiWZfo2lnD4915AZxqCj0iD5uTuN+r3usgKwu+tyhvpkSsyofG0gWhesPOB4AfYYKJldmqNGepFcMzChwiYthgfvf9IMcDozR9eb4F9grfsGFQnJiXF3zbA5WYD+O8KcXmg5AylKzTdj/CLbV4Yxy2pRW4Y/aVv4qZhCwvUo/3E0oPvXLlunLc939j+NyfEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9oqlsjgH5PlOnR/FSD6A8hsZRwAr/QcZdnOxzXMW84=;
 b=cHptwJuP50ANEmuDfvWJOv/nrjMvPlCL8WUxXaVCUZXVeT68pJKbG3mbaGlU2HfjgZllzKmlbsHCd0wqasSY+IM0bih+OnW49EMvLaZiC3aXwWaNcjp0TBavw4m383oy6hbuesmA6NIJY9ZJ0A70xbfYikyvUbGdFFe/mC7JR4fYBdSdLlY6KyAWWwBhGuAvAXo3uY2rlIPO9ABNxsa3HZ8ODsq9BV4PvaoQXvgJxckrknRvbD8Eq2qj8yxNy9uGYtAovxJcVaHOx0Jynu3U7u1WZeMUVQ1TiN/zCHhCBQRGHUZnMQwZp/RFtHAfHUNqjkv4JWJhFLhhKlsReBa7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9oqlsjgH5PlOnR/FSD6A8hsZRwAr/QcZdnOxzXMW84=;
 b=0O8hMrLbsWIR/Kr2Um2Wr913ZHOT8tu8XW38MYqeJ1lvqpdTGMZ0GvBdAPRorXZfl3fM5fepMZ2EOl0x8bf6QTulOEt3lSZgJPbMcDGWuulo2kxTRXj3gjoOcxFSY6yUdgN3PcGTRPMKqccYVl7bniF1ORE0pPRvx/wLVlnMdps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:03:08 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e3dd:99bb:b742:2d48]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e3dd:99bb:b742:2d48%2]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 08:03:02 +0000
Message-ID: <b3964f68-4655-faac-e0ce-64f597ad1837@amd.com>
Date: Wed, 12 Jul 2023 04:03:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA, en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20230712065821.260061-1-luben.tuikov@amd.com>
 <1dc3a6fb-3973-e6a7-519a-440fcfa5ee9f@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Rename to amdgpu_vm_tlb_seq_struct
In-Reply-To: <1dc3a6fb-3973-e6a7-519a-440fcfa5ee9f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::27) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CO6PR12MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 778e1d0c-7a3f-42f3-a73d-08db82ae6a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGIL2IyPdIc7kOdPTEYSdhYzPKFBMfvi545dzZ2AfwqcfE5UKxL2QtbYr2wdVGBtyzDrwj3HKpotjakeuFjeyhWTl88SsdpsyaOQTyXTg88lvAiINEYoAyhoSMIeEcBU3/L1sFZkHrYc2UALXqF6T4PrmG5NNyiHYvDZYXsMA4HUsfBqmJsi1KqsJX6zOdlQNLtRSw1swBcleZdmZkzNZ1SizkT5r3GuveB1jdv+7PUguCQoPPZ2oR3JYul80SXZHaDwPybeBBCySI7Kr9sP//UqXS73CWz7VMqpi0cNRX/naWAfsfBzLeiM1jYAsUJHzngT07UcDzvtwOGmXksiLLzrkO5nmKhpGeiuD5qdKjMhDBl3MxGgbl8d2hemQ1OQwxkRlyEEywHgQR2SzC0LpeN4ucNFGcWGVuiTdsp+T0FQUXw+Nclq9RrviIbWfM9DV8kgPBPPdjl2Vx/VuTFmNh5FVsfSFqK1PfGSZahhqR1yykH0froCgcw04m7dwgRybK5tTyVEk2WVIztyicK7ZjPADipzHvxAeOPOSN3f1i0TIwGEb8mI3FZfmUWAzKt9anME2b1/1/p4aE1pCoz7IPxAQIhsNwcWQRPgQGPrNZpTA+1koErTO3TWhDR6xxzmkz0q8Z0pOwoGQDxnNBBnsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(2906002)(66574015)(2616005)(86362001)(31696002)(38100700002)(36756003)(83380400001)(316002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(41300700001)(53546011)(6506007)(54906003)(110136005)(478600001)(6512007)(31686004)(6486002)(966005)(44832011)(8676002)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkFFRUJTd0U4VEhnenlHT0dsMTN5WXQzRU9KcHQvaHZGYmwvWlFzS3RUUDcx?=
 =?utf-8?B?My91b3AzMFhJNHVJTkVYZGtBRWYrZ2xuci9jM2ovZ1NQZmJYSyt2UWlpZWgy?=
 =?utf-8?B?R2xGZW1FekhGWEo0anJwMVR3K2RGUndSc2dpL2hnSDRySndpZnFucTIxZEFR?=
 =?utf-8?B?NW9mOVZPdUhLcjRCU0tCSGJKeWh5ZTdVV05HMU96L2dOeUZnVnVCeU1oQlRD?=
 =?utf-8?B?M0VJY21iOEUvdlJQTXUxdTltSVhVK2gzanpFVzJsZC8rUDZBTEZNZ0Y2ejJI?=
 =?utf-8?B?ZVF4YWVuL0crcWVNNjVzaVNtZ0FHZEtxcmpsOUtlVGp4WDdZM3ZBQ3V0Wjc1?=
 =?utf-8?B?dnU3ZDZxYlRsM0NaVlU1Nll4TlMrbnNlbWR2cUs5SERpU3VxVHRwTnpaSU9y?=
 =?utf-8?B?c2lSemFnTkxKc2hkRUxEaC9UVSs0cG40aVZieE9sS2lQKzhEREhtZFVRY2No?=
 =?utf-8?B?V3oxdWlrMVNaN1UrbDc4ZE5vcVVQUlhFOE9LZFdRY3h3amJoWjdCNi9rcnlq?=
 =?utf-8?B?QXdxRkx6WGNQRktSWWlLVFBOT1Y1MTZGZVR4dGt6eXRsaHBIUjFiSzJlM083?=
 =?utf-8?B?OVNGNWp5clp3Qk5JSGV4YXlCdEMzdmJwU1FlemFQa1VoN2p2TitheHFSQzJM?=
 =?utf-8?B?QzVLZkVmbzJUdVhyamVGTnBrc2lLZWVHaEttWE13aUpDU1YxejFYSEpZTGVJ?=
 =?utf-8?B?cWQyM1FFZzBJR0FaOXBXQU5UeFFBNHRIZ2I3MmZFWmJ5V3ZzZ1VyS1pzSGNG?=
 =?utf-8?B?dU5iQzViVWtHbHd5dk9WV1FJRjZ3bXl6aWR6blRpcW15dGJGK2VWRllESk0z?=
 =?utf-8?B?TGNjZ2xGcjNTWTNqQk1Tc2dUcVNxR3ZXcDhqaFkzTTRhKzFnWXc0QWE5SGlw?=
 =?utf-8?B?dVN0eUZmWHhhNVpwR3kveGpxWC9NV3U3K1FtWGJ2Sm1RNkJuNEw4TmJPVDBL?=
 =?utf-8?B?bGc2eldLUVp0eGNrb1VyUllFbW91SmsweHhMWW1SSEtScTkrdzdZQkRtY2xD?=
 =?utf-8?B?UDVtTTNEQVhZZkhKaHVzNDlFUVoxYmJNa0t4SlgyRnNXMC9NTXBaUVBkMTgr?=
 =?utf-8?B?T3M5Wi9FTGw0K1pvM2JGWjFORmp5S3V5NVpwZndtTTN1TVVNUlBYbytweHRr?=
 =?utf-8?B?VzVDejNvTk9aaVdyRWhQbGNKMllEbUFTS3JYbGlkb04xemQrQnJ6b0J4Y014?=
 =?utf-8?B?L2NLamhUNVV0dnNqb3FtcW8rV1VXc05DWXI1M3Z5bG83bTBUSk5MaUwxN2pK?=
 =?utf-8?B?M1ROcjkzOGtMMkdMQ0dQd2w2OHRjOVF2NWowMlo3NnlaNENKbUpsTXR3UWhh?=
 =?utf-8?B?T09sOWs2VlhIZFp1TTJBeUlmdmd2V1QxdDZpUDRGTUVNRkovakVvVzdUYm4w?=
 =?utf-8?B?WVJJYUl6NkkwYzRLeHp0NG05Zlh1a0pubHg3dnNaNDdjdWFQRHJaOVNPdHZ1?=
 =?utf-8?B?Tnl6clVVVWdPSVQ2Titjd2NvQTF3aHZlOWRmK3UzczUvbk9sd0JCYlFHZjVL?=
 =?utf-8?B?blFMZ2lpRHZqTUxXU0VxdXVwUjU0dXJuaG1uS3E0Y2FZbUJMalFqZ0VaSWU5?=
 =?utf-8?B?QTQvN0lsaGQzb0lucnR3bnJ1bFZNaXM2QjJaNGxHaC9wMThGNUtDSkwydity?=
 =?utf-8?B?YytqMFNIZFFzWXRQSGpPUFhTNHZlTEJRVWxTUHU3QWtVdXlvTjQ5a1VnNnds?=
 =?utf-8?B?TDJYR2w0clprU0Q1TnZNMko0QkUzbXR0Y29vaHg4ZEErMEk4QlpiOVpiSFZ5?=
 =?utf-8?B?TjZQbk5wOG96N3lwWWdWWHBsbjdvZGpIQitJRFU5THpPMi9pWHRvTUxha05E?=
 =?utf-8?B?TXQrZzRxMXhHVFhNanFwUkMzQXhRdUwvNStsUGxNZkJtc21OK3M3M3Q4MDd2?=
 =?utf-8?B?dXZod2paeHRoYnVhcUJYTHJ5TE93MjQ1Ry9yVVlXbDkyczhoN1AxTzFGNXFC?=
 =?utf-8?B?N1JPT3hBRTVBQ1AwWFhUeEtXcFRVUFFMT0Q4OXNISzJSQ2lKRER1NXdoR0g3?=
 =?utf-8?B?WkY5ajBOc2doaCtlMU9qNkUvLzJzM0Nud2RVbWljQkNqa1cyaGNpZExKWW43?=
 =?utf-8?B?NDhOK2puclNicDJwY0tPUUtQN1N4RTVwM012VmdrQWlKakhPZXNEaDgvR0li?=
 =?utf-8?Q?ilhq/RAGQMVsV+hwEAmZkod3M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778e1d0c-7a3f-42f3-a73d-08db82ae6a85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:03:02.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqoHBOPtYA1xgLecDqKSXhJHpWNouGMWK5IOc73Q5dhOqca2Pnd3wTmJEzB/wR9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-07-12 03:57, Christian König wrote:
> Am 12.07.23 um 08:58 schrieb Luben Tuikov:
>> Rename struct amdgpu_vm_tlb_seq_cb {...} to struct amdgpu_vm_tlb_seq_struct
>> {...}, so as to not conflict with documentation processing tools. Of course, C
>> has no problem with this.
> 
> Hui? What exactly is duplicated here? Is the structure defined in 
> different files with a different meaning?

The same name is used for the function and for the structure.

struct amdgpu_vm_tlb_seq_cb {...}

and

static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
				 struct dma_fence_cb *cb)

C has no problem with this, but document processing tools do,
and in general it doesn't seem like a good practice to have
the same name for both.

Regards,
Luben

> 
> Christian.
> 
>>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Link: https://lore.kernel.org/r/b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 92a84e7b0db85b..32adc31c093d84 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -111,9 +111,9 @@ struct amdgpu_prt_cb {
>>   };
>>   
>>   /**
>> - * struct amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
>> + * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
>>    */
>> -struct amdgpu_vm_tlb_seq_cb {
>> +struct amdgpu_vm_tlb_seq_struct {
>>   	/**
>>   	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
>>   	 */
>> @@ -833,7 +833,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>   static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>>   				 struct dma_fence_cb *cb)
>>   {
>> -	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>   
>>   	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>>   	atomic64_inc(&tlb_cb->vm->tlb_seq);
>> @@ -871,7 +871,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			   struct dma_fence **fence)
>>   {
>>   	struct amdgpu_vm_update_params params;
>> -	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>   	struct amdgpu_res_cursor cursor;
>>   	enum amdgpu_sync_mode sync_mode;
>>   	int r, idx;
>>
>> base-commit: 50db2d96b49b7d6cdb12e71e4204cf7180d3bab5
> 

