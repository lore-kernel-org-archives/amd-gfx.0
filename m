Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB7606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v2vm8qJw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A5910EA2D;
	Fri,  6 Nov 2026 20:04:06 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA06810EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 20:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo87wI6v5q9iHu2TUeo4s2jnykywcNCv4sABlDK53NJE2ZnYU/qYW7bPY2XMTAV73bMf1yo+/Aolh3CPye2L5o6TPh4/9GRLJOBnY+tTNigcfGxRoB9p7I32kfLs7EZI8iUSRX0AIS4SNTALzZqfayABD0cSKnNd+2p9iXKGTmi31u0SxJ4spuSpIqyxL+AhKv6It4pgjSZtNF/aF2Dsbz1IDk4ykTRn/zqzxKBOk37ZFZQ+Qi/ylDnWnbIl97cnciuM2oKLjpOf0O0JaM72sdgNyy4itnrHUwh/SXP4JzN5GNfyyNtF6Nv6kPW/UlhWIg4u+UGj5TiSN7ntugN4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjWnmHyRjBizo3F3MeBo74bnN3NZ+ixeeVJbjkEhbGg=;
 b=x/5V/uGKpl3e0Lb3pP2a3j7G3O00Ta+Z76ZqCD5ubOHKSbGrurdYOPM4xe2j4ZA7n/UKmShKL+4LQCmQgJmMJR4ocAFIsylxLMaZg5T558mM4zYYf/T4RhpUr5bh5yzrK0pAA92VbWMczbjagsAlJFWFow2CkxJfriaWXOi7+HiNhIOLD5cdwiRW1YAZB6qFGzAPMmtdrWllkBaRoSn1qpsyPZFtCQi2+KGoFjykX0fNPzoe6U8+/tpyM+IgS6xo4ugou5vJFhEtqwkA0dRM+IQZjIFScmWRnn9S7w1cYJE3G2RB52e/dmKFmTrqnTtuhZfngF/O6jC2LhUcO67Yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjWnmHyRjBizo3F3MeBo74bnN3NZ+ixeeVJbjkEhbGg=;
 b=v2vm8qJwaPinjryvPMz0SvYOkGu7NlkAJL3+tt0xuZOaUq0iirwwP5Qak6e05grOOXHc2o/h0mdCn6zkdil+20zXTn6pxEHkB963DZqpR0X8oV4sgOUX0oqOKhlIJ2G4gp1D7hITnwIlTkmWU4FHKdhIchdgc5m6t8jRQyivckU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 20:03:55 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 20:03:54 +0000
Message-ID: <60d3ba67-880d-47a9-b71e-8c96d3085991@amd.com>
Date: Fri, 6 Nov 2026 15:03:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
 <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::14) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: f551bb1a-d700-45e3-40ca-08df3c4115aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|261028144727099003|261102123227099003|56012099006|261026140227099003|261026121527099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: avYrIqdZ0MEaxshus+gptOLzr9Ht+34iG8Q7wVxhJg4kLZncloWHCz+mAA2HJP9iiDj5v6VfOUaLXPwjuUGhNikjW6W5/36sz6T8Z8uPqARlsSzXR5KYCESN0ZQg8b9/fGUV6GU1bTnJpETvvo6W/VbRpVDpE2os9WNrtbbIS9M3mvBSYRdB0UJcsVaIRaOEBJ1v6y7UY7mW1auhXHqS+NXvh6RR9gJBVEBIMNuiiZ8opluRJGPwcsB6XEy+fqCxKveui7kt99lbUs679h0OGiEgVHJXO1JW7kqOi5AHRbHtOKs8muNhgTiBkejL/ZwOZv5nkKvCAlbYduoGfMFDYsFdkpxuRRpSO0eqvUj4y/8D8PqU1CT5dSd9ngYw65cSk5hYoDf1viYrohf6KbXhnHksZL7wlEHrygr7KaoJN+O/aS0psTiUzmX6ZI2Qq1S9fB/9iAF785+ErxddbCqYxGPAt85cogtm0rBoTBOHXeyYG6gThwaI6ElIFTUiusuzAD7H9avN0kjt3YgkWvNRbbyv2Ut5wMZjRAU/C/BzNKi1+I9QUCzW/W4HqObIb8POuUSAI8u5nKCORbWjSi8WvE5czSUmw4geEsbwnqbJ6dsHQUT1qmTUEouuLZqjZipA9LSk6xbrjZo/Ns3EabDUskyFXsCWQdYjzJ09f9v0gkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVET1ZVc2F3NTBCaVR6MFVYelFMcWY2dDMzdHNRaWVTTEZaVHV5ZHUzM1Rj?=
 =?utf-8?B?ZGNRRW0wT0dESmp1Ym45V3hRRVdsUTVMS0pZNzZvbDE4S2ZaNjFOWWEySngv?=
 =?utf-8?B?MmNselZ0N2tpTjF4U0NCaVVyWTNwVE5keFlIaitCNDBCWVhCM1ViN0tUZkk3?=
 =?utf-8?B?amRXbndqTWovamV0VTRRL3hIMW9raXd3cTR1UGw4S1Jyb3o2aXRIVEVCOFpP?=
 =?utf-8?B?YitNNzNrcHpLV3Nra1c2R2dPRnRFczVKakNBTytJL2FNNUlMcmF5VFpSdi8y?=
 =?utf-8?B?KzBZWWdOK2VYN0JqWnVUcDI4TnRNSzQ4UVZEQk5LZysvNDB2b3pXWnNvL280?=
 =?utf-8?B?bkMyUytvS3ZubENZVWNIZFU4UHZIRy9TbHFWMDFEa0IvVlFwejlremRsTWIx?=
 =?utf-8?B?dDZIakUwcTVzcjVSVU5VNi9DaGx3b3VTZlMreTdFRk1VWVdPVGlwai9pNVli?=
 =?utf-8?B?UDhaZ24yRENtVkhBWUdob3JFc0RqTWlvZmZSLzAxcnlORk9RdTZ2QnVBV1ox?=
 =?utf-8?B?MzJsODZjNFhVUTRNTUdFdWhuTWFUQVZNeTJJdXc2VHBHWXpKZW5MWHZpQS9Y?=
 =?utf-8?B?dUxzcXQrNmNRR3JZM3ZiV3AyZ3hsUVhZK0paNWZrOEVFYVR5SXVyWG1LMDUv?=
 =?utf-8?B?UGFqdFBoNUl3eTlZcVAvUE9oS25QN0lTUHAvQkJPcHV4dkoyRmRud3hFaFIz?=
 =?utf-8?B?d2pyUVA2TnArNHBVWmhCaEJPclpSYkM3VGd1d21sOUpGVUs4STVZWXpyd1pH?=
 =?utf-8?B?ZmFCOUxkMThjeEhzL25CZ1dZbDkzRkdkMllQVXM0TmtvMTdSR2lKRWdaRE1F?=
 =?utf-8?B?QVpVdGZESG5COG5RUXVEb2c2aHI1SjZuZThXdUR3d1lZREtZZDVYODFhVGVX?=
 =?utf-8?B?enoza2xPRVBoV0xJajVJa0pZSi8xTk5KTkFXaEZxS0owdjdPVnltLzdMK081?=
 =?utf-8?B?Zm8zWmllTlZMbjZtdHoyb29DMm5ESHpIZytmVlhWdW02K0o2U1lyR0RrYXpC?=
 =?utf-8?B?dW1Zb0taMm8xRDZGSU9LOW1OUzJmV2hsaFViYlR5ckMzQSswZHRLQ0JQSnlM?=
 =?utf-8?B?ZWNwRzN1eHZZRElFUUtIS3ZyOTFHWDk0MFQ2c1RZYzd4N2YyUTRJdFBLV21S?=
 =?utf-8?B?UHVSS280TmpSVEFhR21VUG05bm5sdWdEQ05GN3M5ZmY1Wit2TTBFc0dIeEhH?=
 =?utf-8?B?Ti9uSDh4QXJIbXlrOTVmeCtCa3haM3pHYjNuV2hwSzNRa3ZKaitMS0xla1Zl?=
 =?utf-8?B?dHZBM29EbDR3SnhQWWtyTkdsQWl0Tm9EY0I1ZUtLSi82K3hMVjJwaXBwWW9Q?=
 =?utf-8?B?VHJiTlFBblNBak1Bckt5aDhVd0RQTDlrdEpUU1hZVDJtQzFJakd5UDZGd3l4?=
 =?utf-8?B?enhJODRMVTluNDBkL1VSNmJzQkUzZEt0OUUzbVAzOG9EMGFQNVJxTjNJS3B1?=
 =?utf-8?B?bUEzUmVDY1RvNW1JVkQ1aENoZncwb3h1dzhRTUp4OG45NHRYR1JJaVpWWGdm?=
 =?utf-8?B?WUF1b3ZBeWdWZzlGQ1FvYlllZ3dOUUJNWjJnbXhISmtpT2RaS3NjY2cwTFlw?=
 =?utf-8?B?YVFWdTU5ekhWT2VvQk12NmNDNExoM1Q2YzBxUDFSZ3FWS0E1UDl4Y0w0YVZz?=
 =?utf-8?B?YlJ2V3hOWWhIbFpRWTZhZ0dhZ200Mm40OElOUXNUM1FHeTVhSVZBRFhCMlVy?=
 =?utf-8?B?amphM3o1SEtBT2NaUEU5enNmeUhCc25ncEY2QkRmbVJvOGs4aXJTNEo5RUlj?=
 =?utf-8?B?UWlFWVJXSHg2WGE3ZlZSVlJaNmtQWU1zR0tMcm80VmdFNjkwSFJPNUVFemtj?=
 =?utf-8?B?S3FZbFBWSWZBU0R2VHl5TElKU0R4d2JUU1BqeHZ0MzloS1RPZEVkamp3Z3Fm?=
 =?utf-8?B?dENhM3p6Q0c5L1AvTkVwMTlCTWxHRnZLOVErd3V5T0pUMytxOC94Uk5oWE0r?=
 =?utf-8?B?K0lzSGJkbjNIRmxlaWs1WFY0Kyt1NEs5b01sYnJFdG9BdVV4QnRUQjNYU282?=
 =?utf-8?B?ZTd0TzY3bU9sUDd6WDBXT3pCMFB3RmJ1bytndTFnUmIxZHNnaEJiVDVMbkRQ?=
 =?utf-8?B?N2d4djc2bnpCeXBHbVllZzQ1eEtqRnczczFGbnJJT3lPNW14eWo0T3NUaHg2?=
 =?utf-8?B?ZmtYQ1MxODFwL0JOckFRaWhGU1V6cnBRcHRzdE51OGUweHFVSUVQTHUzUWxV?=
 =?utf-8?B?bE5VVVcvc1NEaGxjRXNoS09VTmRzZ3NsN1FyaW1TYi9zQm5OUVFCcUJ0VkZM?=
 =?utf-8?B?bXZab0VBN00zb2ZpbnVhQk1nQmdGVDFwenFJd1g2STFCVTRQWi9kMlpUMTQ1?=
 =?utf-8?B?QTR5T1BqbkVxNVB5aEdCU0FzaTFJOWtBc3hheVNNRlR2ekI1L0ZPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f551bb1a-d700-45e3-40ca-08df3c4115aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:03:54.6616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC0QFsbt8hEck7r/br0bAJ0eUpoElm/9uq4FAIxarHA3KwrpOyOtdy+jjH72FQAJBL/xTmXx4ubLBilrLy5JMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-06 03:55, Christian König wrote:
> On 11/5/26 22:00, Benjamin Cheng wrote:
>> In the happy path, the job gets freed when the job is submitted.
>> However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
>> would leak the job.
> Yeah that was already brought up upstream as well, but that here is the wrong approach to fixing this.
>
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> came up with a few patches on the public mailing list to tackle this as well.
>
> Essentially we need to commit PTE updates before we allocate any new PT, background is not only that allocating PTs can fail but also that we need to drop the lock for this and that can make the PTEs we already constructed in the SDMA IB invalid.


I gave this some more thought. I think these two fixes are still needed.

If we commit the PTE updates before allocating PTs, the pt_alloc could still fail and we would run into the same leak/use-after-free that we do now.

I think we need to both commit the PTE updates before allocating and have these two fixes?

Best,

Ben

> I wanted to get that fixed for weeks but couldn't find time for it. Can you guys together look into that?
>
> Thanks in advance,
> Christian.
>
>> Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 2ba33212d507..f6cb2b5854dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  
>>  		tmp = start + num_entries;
>>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>> -		if (r)
>> +		if (r) {
>> +			if (params.job)
>> +				amdgpu_job_free(params.job);
>>  			goto error_free;
>> +		}
>>  
>>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>>  		start = tmp;
