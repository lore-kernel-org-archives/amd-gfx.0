Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECED0CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 07:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5B710E1C0;
	Wed, 13 May 2026 07:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QoCpOadU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B67D10E1C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 07:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lrnhlyl4+4nBRVCkCiQ0G2nz7qGYim9Z+XCG8+rxJxGsPMzlplJnexHn7u3HWPahCw1smTubamuIkR07VEt6/KIDYwp34IjJ/ABAEvH/Y8hSScthQoPIND0ddI3Wqc5W2ZbP8xlM9iWrq2m5Em9/jPmRCanesvo52HFsPEz+Qn0wxwCKVSEVQp257RUKbLjwIIIqpfX99fxeHovOPdqC1rHw2rCbj7jXTlGIzk8PJIUG4e+mOCi79f+1p8D/g7fpWCwwbTJxOpkpUvruIgh1clx+DQJKDJKn8kg018LEXunFmwgEH+iTl/E9MGX8PHfQfRTAyryYO9Z3dJ5ekSRdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9P7d3YWIll1eNmdIyvaHBmtQlxd6N4ZeGtEPSET6HU=;
 b=VvtJBM38/Ea7Nw8JHXA1UBcYrss3Qm/mxAFpquBsP6ys0TkCtYxwfo640IIE8PwI1mrPBtSpErnG7d7bNaWSosGLSynWfvZR/Ph2uRlCB7nZxKOgrUW/+nL9IRpUzP6KA2RgfmV43FG5ZZcnU7w84+c4S+7AHhdPM9OqOzzJIMZ+lrkYqQdMO29WYiA1AtHgSZyr69QxCO9JTK0/bxEN759otpzxch8CCZMkQp7iK6PRiqEhIRT3A7Wqnxg47Tj3n4ZVINOGQwaXY64hKq4l+wyUSIeuetofJXwYOvwK1D80YYaYlo8vlaCnusBc88MQoDjC08RFsMG+xzEEA7mhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9P7d3YWIll1eNmdIyvaHBmtQlxd6N4ZeGtEPSET6HU=;
 b=QoCpOadUbN5A0svGSHsac/zZ8Bgqw2mAjzRybhB71w0LjqAiyiNH+GJI2AULrkF8b0kYPU48zZaMBgzUDP+7rBQ+Nm9RTEe+0f8XmxAgV/EylwDNRlmYOLvJntuKg58Qf0sa4Gv1QxBt8nZlts4ZVEVvP3V5FhGpZbOu0DNIdY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:26:11 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:26:11 +0000
Message-ID: <e037d829-7266-4b8e-b9e1-51381c76cce2@amd.com>
Date: Wed, 13 May 2026 12:56:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove va cursors for all mappings
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512193045.1279817-1-sunil.khatri@amd.com>
 <07bb4f58-47cf-4ca2-9ff6-d59d69d43715@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <07bb4f58-47cf-4ca2-9ff6-d59d69d43715@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::10) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: de34c0bd-8c03-4a90-c14a-08deb0c0e848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R/4ulrHuZOjx0FSFvQZLV1m9N8WrwCLizJ2ROp8oLhYaVSMJ3ivxaoPaNhxns12C+GvZUP/kW8MgPSqFLWYGPDO4WII9o1t51SetzOk632Jp/bWVwia1ArAMeZftuHnqRpUQuIvJC32+mSnSab+ScqhlBfKXXQLkIo1KVm2t0uZXlt399/CIYTnAGC8AQKI8OL8rBjrffK+kZFxJXadkMSHqQMDtwaumrCi501FjOxAeMvaCDRq7ESq2WO+PXVhxlgB8tEEOE2e7rkhnjNkkovxyqBz6zjO9+HhcOcScYHkyu/+PvoigF/mQfgx1EO290zrmJndU2QTdK3k6dhrJ0IOHdgMrO5k3ywp8G8ndWRlwXilhHnK0pk+A0+Da5eM7w8/fOIye4ugpx0+qBLOFw6fzbOpV0WCK8Uh90FP0Xho9L1QWeYVmqGq8k0rmnfa67rYbrL03ddc7PxFkBnkqJcUdaIojPjrYXwTKIy48Yw4RTR/CTten6t0umXtsOhjFlfSp3proaRq50HFR7dXPkaiMpj8UiaPBeJSe5KVSezUwxNm35AFCEFlFrUV9zVEjJ/Xe0FbZ8zOhm21tT3toiDOCyff5nXzt/GXJ5/MlaKloEtNkFOTYFJynsWIzGDr9lJyc1jsPdeMW3xe9Kryqvgl9+FiNQ6265V9Uwn7sf3s465KUeAoDmH7UJLh+HIBb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWN0UUgzUTJUMnhzTm9qR0NkZWNSS2k3YllZZWQydHYrb1ludExPYUcvTjgy?=
 =?utf-8?B?RzRkQmIvVStVNkFPUURueTJNd3RYeUNiYWs1SG9YWEc4Sm1kemZ0eHpwVEF4?=
 =?utf-8?B?VFF0L0VPZWlZY2h4UjZ0VWZSVk9JcExRV0dDcUxRUTM2QmV4dXlwQ1BJaW5v?=
 =?utf-8?B?TnJCTEJpU0tqTmxHRzBTYmxzc2ZQR0E3OHpPTGtvQXlhQWVLZlFPM1JQTnZ0?=
 =?utf-8?B?eWRiM1VTTlFheGFvRDU4TndEekdtQ05LOXZBaFYyenovbm9wYWVKQzJQblha?=
 =?utf-8?B?MmRkV2ZTTG94YURhclNFaFlsY2lVSFEyS1dreTV0ajlzbTdQNEdSOU1zQ3pq?=
 =?utf-8?B?Z1dRZlErK0ZvZVZTY2diejJiQlRyOFZBZlBFWnFHUlR2V1Mxdmk5enJrZkdY?=
 =?utf-8?B?V2ZjZFlMR05OaUl0TlN1cmt5YkJUTWhxeVBwS3A1L3VWVVQvN082clhUUlph?=
 =?utf-8?B?MEVVR3JwMy9iSXkrek93RzhTcTJaRW10ZWFjN09QQjAybGk4TmZEdVh3N3pB?=
 =?utf-8?B?elVnMEtmTW01OU1yN3lsU2d3dzREYVEwZDFLT0tWbm9xenRvcUE4NWNKUXpp?=
 =?utf-8?B?NWJRR2UxM0pBSXgrSWJqWSttSHlKNnFTL2txQWtROFNicFpVZHpQUkFjdGpH?=
 =?utf-8?B?Z3I3MTRrUXd2RkZ3eTdsM0F0cGxtMlVNL0xBa1kvZ09LTDFQaHhmSWVWRy96?=
 =?utf-8?B?L3o0bEFCU2EwVnBXNERIeGZnQjR4eG8wT3hkMUl0d3p2SWFqTHo1aTVkUTRj?=
 =?utf-8?B?TmlPdjRYaEhUeG92L2MreWExdjczMm5mRkRZTWtsRWR1TVp2NS82ZDY3M092?=
 =?utf-8?B?ZlpLMWJzU3pqSXFENzVIWFE3eVM4SU9EOXRmOVlvY3k4R3BBZXljSDNEbkhT?=
 =?utf-8?B?SzFPcTVLL0p0TWtXdHlxcitPY2tZeGtLYjc0MzIvTWt5N2M4QTZ5UVJZZllE?=
 =?utf-8?B?YzB4UjF6THVpWTBhTEkxbUV0UExxeFNWM3lvUkl5NlZuemYrdEkrdlJKRnRB?=
 =?utf-8?B?UXhXMjhqS3F6cldoYkJjQktJZWRLNk5wSkdEU0hxbDN1Vld0U0d2ZFFNUkFW?=
 =?utf-8?B?U3BJQ3NOZHhzbC8zMVVydHJzUENlWmFXS2x0bnZQRXR1RmI4aStBY3FsZ2s5?=
 =?utf-8?B?VWROTXVzc3J6NEZJUnpWR09LWm8zcGlQbjZBcHQyMU10NVh6ME50Ym54SEJQ?=
 =?utf-8?B?OFFsckZsMzVZeFdPTVlELzR4WjFPWkN6ditobDhlNmRNTFBWNHdsYUdOUi9W?=
 =?utf-8?B?NG5Pb2xrNkhCaHNBT3d5WVJGQ25xWXVkUGI1bGJFanQwbHdwSERFOEVoVXp2?=
 =?utf-8?B?YWRjVFNJUG5xN2VTTlZLUUxSSXQ3TDBGMEw1eWM3b1BGUFpqU2FubHJXTWp4?=
 =?utf-8?B?WXNNU0dzcFhodEx4cXA4OWlEaS9kVE1FZVp2M2ZzbG4xNWJRVnpEQjUxQnJF?=
 =?utf-8?B?U2x3RWg4WWJUNWVZZkZ5ZW95b3M2aWUxdSt1VnFjSG9DditXQUx5d0JLekho?=
 =?utf-8?B?ZUFPMFVnWnE2WGRib2g0Rk51bXVqRGRKMTZNWTdmVGo3SUJzWGRXNDVhTUJt?=
 =?utf-8?B?Y240eHp0dTNvUlJYOFBBME5VT20rK0E0ZXl2UE9RT3BOOVRvemFzZHp6aWMv?=
 =?utf-8?B?SExJaThOcHZuT3JielYvM3VHSm8wTUF5UnpOblpxYW5lR2k4R0NNTDh5RnlQ?=
 =?utf-8?B?dURweW54MFQ0S2x1Ujk0N2JEdVJ4RGI4Rm1jWUlZZkRiZ1RBYU9xL1E1ME1W?=
 =?utf-8?B?b1ZPOHdIZlVUUEwyeFZaWVVTL0wzeGJUOC85ZUIzektGV1l2S2VKUnBmc013?=
 =?utf-8?B?enJhdlZaeEFSeXA4Z0cxTjdWTmhZOEFOZXE1TDY1c2FmVG1RNDZaMHk2ajZ6?=
 =?utf-8?B?VE1TNHhqZjdhRm4zT3V6b3JjaW45dG5DWE45THdMdWdVVDFVRjFZQmZzSnp0?=
 =?utf-8?B?MnFhWDJsOCtnL1NnSUFTNEg4cHVBWUJoRGJQSHZHZ2xxby9vRWVvTnJUeklI?=
 =?utf-8?B?VWlrSXk3SXk4L2tFNkFodkE0N2hlM0lUditBRE0xQlJpRjZ0NGhjNnlNSFRs?=
 =?utf-8?B?cGVHRzZwTGZRRHdPdGlSekdJRWxzN0JaekpKeUhaVVRPZkM5RFZhdXI2OEdX?=
 =?utf-8?B?SkxEU0ZaY1JadGpyaTNQUGZ1ZVRtYmJjZW0vbTQ0WTRBa0dmYVRLV21WcXdN?=
 =?utf-8?B?STYrK21MNWJjQ0ZHR0g4anc0WHJVMys3RG5xNmRvUkFmRytLNVo5a2dCSFhI?=
 =?utf-8?B?ejFjS0gzUnlkdEJ1QWlreWIrdnA1VUR2VmNoSSszLzZUbWY5RVVKSnZXM0tL?=
 =?utf-8?B?S3BIalJoaFVNSDQ5ZDdOTE9sTVBVN3g0bWV0YWdqZGU5VWFlRU1vQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de34c0bd-8c03-4a90-c14a-08deb0c0e848
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:26:11.4828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltv7tZM6OOxuGVxKJGgY9+0JIPjMbi5TIPYbGksyVKlkj/LKizYBJBgUQNbLwRx0KLm/poN15UIcPZIKbj2JjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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


On 13-05-2026 12:51 pm, Christian König wrote:
> On 5/12/26 21:30, Sunil Khatri wrote:
>> va_cursor struct needs to be cleaned even if the mapping
>> has been removed already.
>>
>> Also simplify it by make it a void function as return value
>> check isn't needed as its called during tear down.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> That patch here is Reviewed-by: Christian König <christian.koenig@amd.com> for now since it is clearly fixing an issue.
>
> But of hand the userq_va_cursor design looks like it could be improved.
>
> First of all bo_va->userq_va_mapped shouldn't be an atomic, but rather just a flag/boolean.
>
> Then second we should never set this flag back to false since it can be that multiple queues refer the same buffer.
>
> Not sure if we should fix those issues in that patch here or just commit this patch alone.
I can get this patch in and work on the issues that you highlighted in 
subsequent patches.

Regards
Sunil khatri
>
> Thanks,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index f62163917f70..e325c7a350f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -303,13 +303,14 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>>   static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
>>   					    struct amdgpu_userq_va_cursor *va_cursor)
>>   {
>> -	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
>> +	if (mapping)
>> +		atomic_set(&mapping->bo_va->userq_va_mapped, 0);
>>   	list_del(&va_cursor->list);
>>   	kfree(va_cursor);
>>   }
>>   
>> -static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>> -						struct amdgpu_usermode_queue *queue)
>> +static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>> +						 struct amdgpu_usermode_queue *queue)
>>   {
>>   	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>>   	struct amdgpu_bo_va_mapping *mapping;
>> @@ -319,15 +320,11 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>>   
>>   	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>>   		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
>> -		if (!mapping) {
>> -			return -EINVAL;
>> -		}
>> -		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>> -			queue, va_cursor->gpu_addr);
>> +		if (mapping)
>> +			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>> +				queue, va_cursor->gpu_addr);
>>   		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>>   	}
>> -
>> -	return 0;
>>   }
>>   
>>   static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
