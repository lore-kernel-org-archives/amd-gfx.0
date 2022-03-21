Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1457CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 09:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77C310E35A;
	Mon, 21 Mar 2022 09:33:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F86710E35A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 09:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGvzrSLrC4dAyGhUFocrly7xeSFnuUn0HctjYQmqQ1ji+HjAq07m6gD52XQwCmUaF5fGRoSa3C/Vv3pDXDi2LtNWYw7bqqMmyH3SqDDcdZczPg25X9MqiYBwuZfiwj9dDINaOkgVHrDKtgoCKjAXRXdPor1vWtcYzgoPXSWbtJEDVG5f6lllDQSTr/5OBpks31sFHoEeNRQ93kKEOcrQO9xiudr4kT4nsRGn/vt6Eyx+XtKLFvUAJsVSO5UbzfHrRlPAVe+b29MbQJX7ym0dcosU5sYkznKVK3uzq0o5Z5olEc2TnhED2EIeWUEAg1ZrDoC1JUlo4Q1d1XlPQsdT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc90ArLUZZ/xdStbxu3FTaHoAZdoNZIPA2mOL4RRaJc=;
 b=PM7gZEc1Cu4Mkri+S/avvkH8kvU6RX6J+14XXHaQ7fILCrk8ryqDyB9ydhtXhdZh0GqPX3iNLwPRvIN29o+jQR4vusu9NTEe8rZwEjNlf44Fn3XauM68tPuQpBusRR+a5ikJHkvSlDu/FHMLLFlZz+V+/cStQXyj5ANJ2IaDXNV8j5bp6HQPDlXY/gK4sCdHFLDNdHblgy1c17pblCtr69RiDdX1t6U0PY69ofMKJvGQCNyA4kWhWJrpRopL3ZVcfprZV7vSr6pWxWvS88owe1Xct0mtvXYzi0jtGnAA5H02h3veInTGjU6gU4xrooUcPeGgxluNsLCs07fmA8Gj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc90ArLUZZ/xdStbxu3FTaHoAZdoNZIPA2mOL4RRaJc=;
 b=EvQzqJP9nyCycdnBKUGhS0w9Bt797NVCC3k/6Rbj27PiCPtuWnEPP2mibNf6v3+eOp0DpgDTB12EsV9YGOxETPiN16wpRwqI0aWBybiG5bb5m6CoHPdmDAy00YJTjLMqgsenzfWKFCjSBtaN35tp0RHeWr6fyx/nfPCXVxwzIc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 09:33:05 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 09:33:05 +0000
Message-ID: <9a2ecbb9-21dd-842b-2787-7c50930acfc3@amd.com>
Date: Mon, 21 Mar 2022 10:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/7] drm/amdgpu: rework TLB flushing
Content-Language: en-US
To: philip yang <yangp@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
References: <20220317135044.2099-1-christian.koenig@amd.com>
 <20220317135044.2099-4-christian.koenig@amd.com>
 <3e23d276-d9fd-b9c2-cf23-572f4ede51a0@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <3e23d276-d9fd-b9c2-cf23-572f4ede51a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::46) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1ee19c-8505-4ff6-a293-08da0b1dcd4b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3902:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3902B9983653F0DAC88C6EFA83169@MN2PR12MB3902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7p8+AAXCnFHfLbuqZrXTkHOVqgsWZrUL56NbFl1XldEI+S81v6EBuZevamZQfovD4kRrvJtGtxBANsV8Ut6cqqgQZTSltF3u9nnpMx/ZvnbskwJWO4Et+Jn6S9DHKJz59DMYETdrnZR8LzWXX95hFEuWHk0iyD7IWVa+w4Vf6tRxnDSnadyNGJin3icgHTJFoAeP09mKKFj3OcRH/rsYFihjuead3KZwMHaLkAHLLy+9WKfZxyv3xvks+cbb41kF8mhAlbF4+QrdSEXh2FqmLjAAgX4hmLY677rpV/dXFiRgs3pnYVEaRxST3QQxwrLMxPQbGHg2RH8wmyyON6POjqXfdbAOKKd5FcLsOwfN0mq7Jf40eNbXdfTW2CrjhGFETYZWm4e8Ck3xQsn8g6EN0k9DoH1g9yVF/Ih92XHvcYiyYMJ5i8y36APlef/TDPkMHRqWq/OUskpdivBKw01ppZB3aQJDa+3NaT+qXl7Qt/oiZVVJX5CkPJjA0zKk76XgcJry90wAdzRpd0JQifHi+0zqMqUaRIJ6WedvtTmv5kkWiyYVEU+fs8G6P7LkdcbjqhMcI7UssHlGagk5K8aysO6SBZnznrmaDCC13yIj//uY78b45bquu3TcM9OqA72H0Pbux7noTSG1wW5OF+tmR1bQgt2LAHZcoPqhgVGCr9wOPBGT+RFi8fQyAvfwWscUY735AFQdOBBug0B7PreEe2AfHYQAL+prFXjTibbBZS4aueRUD8h0sYbIIeEeKih
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66574015)(2906002)(2616005)(8936002)(66476007)(66556008)(8676002)(66946007)(53546011)(508600001)(186003)(31686004)(36756003)(6512007)(6506007)(6666004)(316002)(6636002)(38100700002)(31696002)(86362001)(6486002)(5660300002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5jdGJvMFE3alVudjJuSFhKMlhhOXpheGxaZ3pkcGVRdUQ1WU1RWUxnYVNT?=
 =?utf-8?B?cWVuZXgwMjVxYWVSeDZ1YnF5WEFySjc5MnVXQnMwZVdQRkM5d21ROGIrbjYx?=
 =?utf-8?B?dENLMGsrRG5OdUZFU3FJeldMWTdCYy80UnlBdGxJZ2pJRTJJaGpjcFFLM1dh?=
 =?utf-8?B?OURsdWV5Q1o2d3BnUzRKRUlQMlhPME5pekN4SVkrZ2dOYkJMWTBQRFdYUzNF?=
 =?utf-8?B?QWM0QlVYb21CVFdHNXVidTVXeGlYQXBOb2MzWm5VMWV0Y3FUR29vOGpUNG9G?=
 =?utf-8?B?S21QMXFpMHE3bk1iMEc1NDhNbFBabm04bHUwNGFrNkhXdFdDRTZSV2lRcHdH?=
 =?utf-8?B?NWhhZFU3RDhuWWMwVVA2RTBOZG8vSUd0bjZmMnBQN2ZibTQ4aXcxczgwRzM4?=
 =?utf-8?B?OTNhekVZc0t0M012TklSZ3pzeU1zRXV2bGhITWROY2ZuREEvZktKNVB4NkJV?=
 =?utf-8?B?U0VnUFlKOElCYlZTQ1RCemFmQ1FrU281aVJCcnZOTWQzNXhoY25jYUhFbHNI?=
 =?utf-8?B?eFFEZVNFWHJOK2Y5VlpMNEtMbDRMeWhBenlodTg2UThMRXRwVzJJSWowTjAw?=
 =?utf-8?B?Z243SENwYm5vUlpqaUxUWFJzbFdpWmd3cXR6ZnlGUHp6c2hPY3l0NSsxU2Zt?=
 =?utf-8?B?QTZyN2VnQW0wb1pFc0lsSDByZnI1dzFxTVJuMkZ1VHVBTXozMWMxbk1jQ1Zl?=
 =?utf-8?B?UHNCZThYZDEyY3orODYwdnpaLzhESk10Z0ZXY2ovQ3kraDd1V3ArSXNMNUth?=
 =?utf-8?B?S0FYSjBsdkF1QzdsYzhqZzI5V0g1NjhydVBXNWhiV0svQ3dKdXluSHpJWDR4?=
 =?utf-8?B?NnFoaUgrMCtpcDBuUmlyMGZFc1grZSt3WXVHemk1Z3d3UlE3Y09OdzVicjcv?=
 =?utf-8?B?QmlGUTdZQTdGWDRRYTFORVFpdGUzODFPbEJoNnJNLzBsZk5hMmpqVDdBZ004?=
 =?utf-8?B?TGgwT1puSFFmWmUxbEo0aEdtYkl2a2tSSlNQdDYxRGNhOGsvV3pmTHB6K3k1?=
 =?utf-8?B?Qk9sTVEvREUzNW1uOGhsVGFFWFJiYVBvMnUvckFTRUsrMTEyUkV0S0RwWDh2?=
 =?utf-8?B?Tkp1c3BMTm95SThSaWlsdmgxT3IydUUyMVMrU0ZRcjluZ2JsZmlnaTNKaVhI?=
 =?utf-8?B?STUrdmtlR2hObEhDdCswRWhpbEZpSERJL3QzOVRwY0xWemZQK1lDSldRczlm?=
 =?utf-8?B?NExZeldWYTArS2hMZzdFcU9tSGw5UW0yakdLaTFHQ3J4UFBxQW1XdG9XQjdm?=
 =?utf-8?B?dk1CYkJMcXBKOXlXemRKcERuaXp3RGFXSFZFTDVqN1BVMWV1ckpsbUgxR3VY?=
 =?utf-8?B?VUV3VVYza1Zrb0liekFud0tPWU45RzB5blRWZFpaMlBLVWl0d01pVUVjcFNM?=
 =?utf-8?B?MXNFdUtmaVpDOGNlOGN3OU5QSEdGR1E1cVNvck42b1d4NzMyenpoRGFCdllL?=
 =?utf-8?B?REwrVmVXMnZYMW13d0VFb0pid2lWTWFjblNpM1pHejFzOUx2Zm8rMkZOL3hX?=
 =?utf-8?B?OGdpcUZybk5KaGpod3FQTGFJL2xaaitzci9hUk5jb0JBZ0Y0bUdkbHcyaFVj?=
 =?utf-8?B?aWRMZVJySm5zaEhndWEybFF4NE9CYzhpMW5kd05DVjR6Mm5oWFF0SHhQQW1U?=
 =?utf-8?B?cGMwYjV1OGtxSVZ2bmY4V2FxMkc3VUJ3blltYlVJODZSZzVYdVdKQ2Mvell4?=
 =?utf-8?B?eEtyMDlXa3Rnblc1Z0JCZ0Y2c2NYdkpFYTQ5NitlM1RrM0I0bWZpWlNrM2pY?=
 =?utf-8?B?VEg1eXMvbnJZSmU3c2dpUDFjbnlIbStWNGhRNDVJQldVNWloSEFibDdIK21s?=
 =?utf-8?B?LzFFbzF1dEprWnlxVk8vckJocFZmRFRMRVdIekRYc0tkS2lVNjJvZDRRL3NX?=
 =?utf-8?B?RjJZYXBwVjhUUWFrakE2eXVFWldhQlpOeFNQdllJQ3o1WFlWa09kWUpudkpP?=
 =?utf-8?B?ckRSNllVQm1FWHVyVzNiTFdTY01oWjgvVFdzQnpjRWFBR3lRdkNMZ1MxVlNj?=
 =?utf-8?B?d0FScWxvMVJPNXRaSkEvVTB2Wlo4VFVzdG40a0tsV1J4OU9iNmd1WDM2Zkor?=
 =?utf-8?Q?GHqSiv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1ee19c-8505-4ff6-a293-08da0b1dcd4b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 09:33:05.4308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nax8V6vHh5kRHzafYhr/AU74M/YMH1R9STKtGvEtzsU2alRJEjWN/uwh4g+K+Lgf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
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

Am 18.03.22 um 16:45 schrieb philip yang:
>
> On 2022-03-17 9:50 a.m., Christian König wrote:
>
>> [SNIP]
>> @@ -890,9 +929,20 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>   
>>   	r = vm->update_funcs->commit(&params, fence);
>>   
>> +	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
>> +		tlb_cb->vm = vm;
>> +		if (!*fence || dma_fence_add_callback(*fence, &tlb_cb->cb,
>> +						      amdgpu_vm_tlb_seq_cb))
>> +			amdgpu_vm_tlb_seq_cb(*fence, &tlb_cb->cb);
>> +		tlb_cb = NULL;
>> +	}
>> +
>
> Should move fence_add_callback before calling vm->update_funcs->commit?
>

No, absolutely not.  vm->update_funcs->commit is what provides the fence 
to add a callback here in the first place.

> With this fixed, patches 5-7 are Reviewed-by: Philip 
> Yang<Philip.Yang@amd.com>
>
> Need another patch to fix svm_range_map_to_gpu, remove local variable 
> table_freed and call kfd_flush_tlb after waiting for update fence done.
>

I think I've already tackled that in the follow up patches, but I'm not 
100% sure I've did it right. Please take a close look at this.

Regards,
Christian.

>>   	if (table_freed)
>>   		*table_freed = *table_freed || params.table_freed;
>>   
>> +error_free:
>> +	kfree(tlb_cb);
>> +
>>   error_unlock:
>>   	amdgpu_vm_eviction_unlock(vm);
>>   	drm_dev_exit(idx);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 1731681914f5..38a1eab1ff74 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -284,6 +284,9 @@ struct amdgpu_vm {
>>   	struct drm_sched_entity	immediate;
>>   	struct drm_sched_entity	delayed;
>>   
>> +	/* Last finished delayed update */
>> +	atomic64_t		tlb_seq;
>> +
>>   	/* Last unlocked submission to the scheduler entities */
>>   	struct dma_fence	*last_unlocked;
>>   
>> @@ -478,4 +481,16 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>>   #endif
>>   
>> +/**
>> + * amdgpu_vm_tlb_seq - return tlb flush sequence number
>> + * @vm: the amdgpu_vm structure to query
>> + *
>> + * Returns the tlb flush sequence number which indicates that the VM TLBs needs
>> + * to be invalidated whenever the sequence number change.
>> + */
>> +static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>> +{
>> +	return atomic64_read(&vm->tlb_seq);
>> +}
>> +
>>   #endif

