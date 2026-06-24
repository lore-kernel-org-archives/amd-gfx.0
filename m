Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514C5CDB471
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 12:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D877810EEFB;
	Wed, 24 Jun 2026 12:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TR1ry+U+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B2010EEFB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 12:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHu6sS1YZhhESLsH9pltqaDe0uPlipIMZShPmi0v8n8hB5GkiA93hY1YaggcZbtZo/XAeH0yg+HrjgwfIEkf1YVfTBCTwwe2SVPLPa25PXr7Vf9JSs8ckZdIlX8RXSwt3BLMuuDzfUpG/MkpdKhfTGgmYbCmmbB5j8p5JrsdSyjejSK0AHARawk1767nDq2mrhSClQd857BDk/Hfmhh5GDHN0olT0GvgT5qekCCtmWYbdkOPz0zo00j2SIHvKmsZy7Xuqd7t5oAGR/Njtb6RJZl2yRB1AYDkN28ZZxESOgRKVA24F8T4bR5YDrijUp096hk+lTSFNXFtvNaCPLKz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p40fsj/sJot5w2mbiudQr14M7qW58CkdEMwme53xAgk=;
 b=Ujarklw+W88ngSu7NmNtduiTOII9dp3UewdZ0OhXmVbvPFZPSWSNqtSQ2L1TpokHxyn3Dw7mnCFSsZjjcSvRZUx+KeGgj/7QFaL26M/YZBz5jXQHgaRwcMGcN2B8ZuL72BSu/9noY88YNaAfQpuRl8aynTIrtQE6S9cYy9neOqhsR8tPo8mUdR6VrwFZ0SZHe7ulrFPg03IEZG9UuSB4PRE8NPJQl4sMaJfT+BMPUkx02mWbHuVZagJad3NXOE646Y81C/rjBI/vosU+EcRXT3Fe6vMdBIcFEdz0cC/kaxeQOuJ/9brZLTeO2kT1dcR7TEdXxZTkn67uSyrYxhmK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p40fsj/sJot5w2mbiudQr14M7qW58CkdEMwme53xAgk=;
 b=TR1ry+U+1GPgdDN8JEx8Poh7GAucmRSqQmehArp1/yTm80F7YiMrqb95jeyJZ5yCC4drCnSP15V/CPvl5qfmFepLdPEWYez0DEk9ASGzXMt+dxwbaAdOx/vGT+7sWfDUEn9DR1ZVof1Cici9sQC/6Z8FHOxwFj7r2e/wHlpe7DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 12:38:07 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0113.015; Wed, 24 Jun 2026
 12:38:06 +0000
Message-ID: <38b919a3-6dd8-40ab-9972-05aba6184936@amd.com>
Date: Wed, 24 Jun 2026 18:08:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu,amdkfd: correct setting MES queue type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Geoffrey McRae <geoffrey.mcrae@amd.com>, alexander.deucher@amd.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260624032608.1135223-1-geoffrey.mcrae@amd.com>
 <20260624032608.1135223-2-geoffrey.mcrae@amd.com>
 <e8b753cf-3387-4486-a097-929cbcd18616@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <e8b753cf-3387-4486-a097-929cbcd18616@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0279.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::10) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc401a5-2cfd-4c56-334a-08ded1ed7012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|5023799004|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UD6RGqOf+ZyNCcOrypj7M1GzW8ws0VbbDKJkYnjZouJGmABBRyj8H0mmLKdwEHXgOgPoL5M55Sl5dc3YVW9sBI/tTcO8r9VBswl6VIbgi4h54lYBB3yHPUwNR+Ssl25GYe0xbcxllH9w5jKkbbnESDdL/XE/SkJn69PTwhe3uholosh3kx+lTAu4fCH2NiU5SwfLhWBZVwQyGsxYhsbBZmoPTGO3R48GSOld2VmirQB72eq5kdWT3GrX+aOJ7mRtLUioWmbi7NTJHohnXOmWVTBCSTXOo5xFIfPYyPzAgBjXx26DfuoEVXKCu0PmYeAGYyv60jZmClJ36UM94nR3L/i4n38gYwLfDIxUxQSdgDQSRgtQKcDCRmsHcz9aHKP62MfQDpqMiAti1MYpsVP8TUJNTe7w/6nn4AVcIx+3SZrxQOATXzKr20zyBXyPso8flxW6D2JZ6kbDDvm19o1HvGl1PUv1ZKXF7ob0N8/82JTsg2h2V2hEeW+QSeZFtte1auG7ZArwJ0H+bRJXoVfBRk48KfgF97GEFJrRgZgrkMBEj2zj7rTYJh/wWCkCXKdr8UzvmEQG5OFKyGjzSGib7Ev4AcGzNXn1N2YtmfCxN8b2KFAzj5LcbnZwjk0KnZ3/UvGDiarGFAIwJ+uYaiz0mzhavxK0hiCyHNiw5/x48Yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(5023799004)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZtQlROanRQQjF5bXI2SmZCQ2FDMHAyMlM0dkVqa0tZQ2tiVzlzZVNDd0dH?=
 =?utf-8?B?cy9BVnBlK1MvRVhsbmpqS0RtM1YvREk1TWc3M0ZsaU5hWGlDeGt5RTNuN2ND?=
 =?utf-8?B?ZC9PYUlIdUoyOUQrZHBNOWRQZkRPMFlqektEaldaaEcwSDYwSTZaeUdoSXpj?=
 =?utf-8?B?UmkzQzJUZWw5VFpmMjk2UjJUU3UyOU83dUV5RXNlVHJEMFNzVjlBdUx4bjFV?=
 =?utf-8?B?V0YzekNVVDdtMmk1azNCMXJXdDNoQ0dWTFpFcVd5UjdWMFI2N1dOWlBPOVNS?=
 =?utf-8?B?bkxXS01yN2FQRDJRRE9nTU1qaW44bmpOR0VxZzBMVkQrL3RkdHF4eFRjaitx?=
 =?utf-8?B?Q3Q3K3U2a0Y0dzRQb3FCNGIzWW1raVh5TmIrZmhYV25zVG1JYnFydElrL0lH?=
 =?utf-8?B?SERPWFV6RjIvZXpkRHQ2ekJibmZMblZ4Wk1GazB0MG40VTJxMzFZRmZxYjBj?=
 =?utf-8?B?UXVpUSt5VnozcW14bHJ3eFphcERuYTRQWDI1djVzQXhvbmZVTjY0UGxnRUtY?=
 =?utf-8?B?RkN4UXBSSTFIdHZuTnptemZUaHlzMWRtVjhWRm1MdnY4cWhjR0FaOHVQcXh1?=
 =?utf-8?B?a2M4OTRwdmdDY2JEbW5LeEtkdVR3T2VGSldTOHpJcDZQRUw4a2dwa1lWUDlC?=
 =?utf-8?B?R05pT0ZXYlBwektaRm1va1ZzZjl0K1loc293aGRBbyt0Y0I1bFBNWXFLblQ2?=
 =?utf-8?B?SG0vWjZWenNwUVdZWGVRWHlYOW1HR3YwQmsxU1VYdHQxbEtQTEMwd3FpY3JF?=
 =?utf-8?B?L04zSjZsdncrQWxGTlRMeFFUZ054Y2dtc3d4ekdlQ0M5N0lFaldCT0RaL0Vs?=
 =?utf-8?B?cGZ0N1VhWWtFWCtJM3Q3OW4xUjFkVkkzNkF0TzVzRW00MnAwSEdTSXJqL1Vr?=
 =?utf-8?B?WXN4OE5KSTZIN2x3VEhXaU9xRFFRSEdVT3NVM3k0enZ1SjZCVVJsTFE3NmNm?=
 =?utf-8?B?VzhEQ3E0UW8wK2dCQURQQ3pjdHBnM2duaHZBM0dzbGVjaDlmY1dlOUQ2eE9E?=
 =?utf-8?B?N1M1TjUxTE96bWZ1MkRBZ09Hc21pUG1oUWw3QzN3WERxOEpKTjRzVFg4dU9E?=
 =?utf-8?B?R3EzVGtSZ09lYmhEdXlUcHV0RnFlV3Z6bEFmeUR1OGFhK1BLSUR5N0FUVTlD?=
 =?utf-8?B?N3RrMEkwS1c3K0xqdHVBOHI4ZDZGelhjSXNsbm0vRHVxUHF6b3pzQmR6azVo?=
 =?utf-8?B?T0J3Wjk2eCs1d2RDbXlhaFVhM3J0QzhjNjF2L2pBbXhtbzdzQWlxWTVkWitB?=
 =?utf-8?B?UHpqMzFzTUdYSnNFUUQ1V0dGUndnMEJybkdya24xY1hBaHo4VVRyazNtc08w?=
 =?utf-8?B?dWdvV2VGdEdNTmhmN0FrK3MvR3Zhd0xIV2U0QWZkd2RIN0Y2WnFHM05WV3lP?=
 =?utf-8?B?dzFXNUNNdW5YKzFHV0pscHd3d205anc1MWhnTFFpWVhVZFVhSGRnWDdOZnYy?=
 =?utf-8?B?WHBPaWVpS3ZFRkliZnVpRlRRbmtZY25HVXVPVHYrU09zOWpuQmJSUWFYWlF3?=
 =?utf-8?B?cHhadEdPckZCcWUyVkF0VWJsMFd1SDFIK1hEeWl6ZWd0K2NnSEZTdHFibmFI?=
 =?utf-8?B?eS9vRXI4UmovL2JHNjNPTkZ5RmtXdmxKNkFoNHFsQjh6NUhEdCs3dHNRR3Vs?=
 =?utf-8?B?V1RHczhYdUQ0Z245S2JlSlV1WE9XMzV2QnRRMHpmaVIrM3ovb1FqeStOSjJO?=
 =?utf-8?B?aitUY2RkZE1CM2VjbFppVFlZcjhFYnE4a2Q5Kzhjb2xmZ0Q1RHJrT1B3Vndi?=
 =?utf-8?B?a3dMYWRIUlR4aFdXMmZ6NXBtN2ZzalJhN1pGMlFGUkJqOVJwbWc0aEJaVWZY?=
 =?utf-8?B?enFQOU1abDNDWlpmWlpRUkhIbmJxU2MvRGVmUDhIRW9idm5nUVBxYkxjbDh5?=
 =?utf-8?B?ZTJKdzZiMkZuaUQ3VzYva2IrMFBDSzkrdnRlSFh3VVJpbmFHY0JLSkZqUXVR?=
 =?utf-8?B?Ykp1STFRS00zYmk0b0ZqeVpQV2hvd2greUlSQ0hSSjhvUUYzcko0dHE5dzBJ?=
 =?utf-8?B?Z0g0VXBCampzUExBeFBlTTh2YlgwN08vV0dtYjhpb2tRL0ZCQ0Vrb0pvc1V6?=
 =?utf-8?B?ZkwwVzhGZzZlZ0xsQlAwdzVXWUZZak9kVHVidWY2NGhWemVOQldYREJjRVBv?=
 =?utf-8?B?QTg3eWdybHhZTVlmRVZZUTJvSjMxeEtDY3dEVnpKWENjRzdVK00rd3lua3FS?=
 =?utf-8?B?MFJQRnkyelA3Skl0akxNbGJZMDJldGdHUEpFOThrSnBib2s2VThSOHcyTjFQ?=
 =?utf-8?B?dWdjSk5UYlYydHNkN1hQUkc3aUZNckdkaEhqSzlrTXBHZTVGYi9BYmExTGJi?=
 =?utf-8?B?MjF2REQrZUY0SUhmelplQUdDdDBHZGZkR09UV1NMK3VndmoxRmRndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc401a5-2cfd-4c56-334a-08ded1ed7012
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 12:38:05.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHKLyxV09ZpEUFoow9pWC8u7PpwUV1w8IMB3r7/t+ZoTENliz3K7XqhOm5O8yehO26hQAVJloru8ZuBui1SWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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


On 24-06-2026 12:44 pm, Christian König wrote:
> On 6/24/26 05:26, Geoffrey McRae wrote:
>> MES ADD_QUEUE programs the firmware with the queue type from the driver
>> input, but MES REMOVE_QUEUE leaves queue_type at the zero-initialized
>> value.  Zero decodes as GFX in the MES REMOVE_QUEUE packet.
>>
>> That means removing a KFD compute queue can be submitted to MES as a GFX
>> queue.  In a debug-trap suspend/remove sequence this can leave MES
>> looking for the doorbell in the wrong queue class and the REMOVE_QUEUE
>> command may never complete.  The observed failing packet removed
>> doorbell 0x1002 with queue_type=GFX even though the corresponding
>> ADD_QUEUE for the same doorbell was queue_type=COMPUTE.
>>
>> Populate REMOVE_QUEUE.queue_type the same way ADD_QUEUE does.
>>
>> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
> Of hand looks correct to me, but Sunil can you take a look as well.

To me it looks that MES firmware does not care during an remove queue 
pkt to have queue type as it seems to be doing it based on 
doorbell_offset. But the original MESAPI__REMOVE_QUEUE does have a field and

of queue type which is used for legacy queues but not for userqueues. I 
think even if it does not use the queue type to remove queue there is 
nothing wrong in setting up the queue type.

Looks good to me. Just validate well that MES handles this gracefully 
and there are no surprises from the FW.

Series Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil Khatri

>
> Thanks,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c            | 1 +
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c                | 3 +++
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
>>   6 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 5255360353f4..dbedb1e47c3f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -274,6 +274,7 @@ struct mes_remove_queue_input {
>>   	uint32_t        xcc_id;
>>   	uint32_t	doorbell_offset;
>>   	uint64_t	gang_context_addr;
>> +	uint32_t	queue_type;
>>   	bool		remove_queue_after_reset;
>>   };
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 5ad8dd18dc67..f0f12c81dd5d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -170,6 +170,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>   	queue_input.doorbell_offset = queue->doorbell_index;
>>   	queue_input.gang_context_addr = ctx->gpu_addr;
>> +	queue_input.queue_type = queue->queue_type;
>>   
>>   	amdgpu_mes_lock(&adev->mes);
>>   	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 9e27d01cbfa3..76e6769cf7ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -383,6 +383,8 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
>>   
>>   	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
>>   	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
>> +	mes_remove_queue_pkt.queue_type =
>> +		convert_to_mes_queue_type(input->queue_type);
>>   
>>   	if (mes_rev >= 0x60)
>>   		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> index 20f4fd57b1da..1b0c649d97a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> @@ -371,6 +371,8 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
>>   
>>   	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
>>   	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
>> +	mes_remove_queue_pkt.queue_type =
>> +		convert_to_mes_queue_type(input->queue_type);
>>   
>>   	if (mes_rev >= 0x5a)
>>   		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> index 8007a6e69305..c449efa70b60 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> @@ -362,6 +362,8 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
>>   
>>   	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
>>   	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
>> +	mes_remove_queue_pkt.queue_type =
>> +		convert_to_mes_queue_type(input->queue_type);
>>   
>>   	return mes_v12_1_submit_pkt_and_poll_completion(mes,
>>   			xcc_id, AMDGPU_MES_SCHED_PIPE,
>> @@ -2270,6 +2272,7 @@ static int mes_v12_1_test_queue(struct amdgpu_device *adev, int xcc_id,
>>   	remove_queue.xcc_id = xcc_id;
>>   	remove_queue.doorbell_offset = doorbell_idx;
>>   	remove_queue.gang_context_addr = add_queue.gang_context_addr;
>> +	remove_queue.queue_type = queue_type;
>>   	r = mes_v12_1_remove_hw_queue(&adev->mes, &remove_queue);
>>   
>>   error:
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 9f28974f25b4..74cdaa8636c9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -299,6 +299,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>   	queue_input.doorbell_offset = q->properties.doorbell_off;
>>   	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
>> +	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
>>   	queue_input.remove_queue_after_reset = flush_mes_queue;
>>   	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>>   
>> @@ -467,6 +468,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>   	queue_input.doorbell_offset = q->properties.doorbell_off;
>>   	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
>> +	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
>>   	queue_input.remove_queue_after_reset = false;
>>   	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>>   	/* pass the known bad queue info to the reset function */
