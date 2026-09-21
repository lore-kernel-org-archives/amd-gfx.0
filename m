Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3FAC982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 08:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F5310E585;
	Mon, 21 Sep 2026 08:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vSN2xEQ1";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7478010E5B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 08:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/Ez6lBAVcIec/YaemlBYDh+8IquqeO2wqDqPaiqHvEUcopHwnmtqipWQgCLXbtWir5nXhCye13JFkZZMVnPTXfByK+i64LP/3Im4V64hj8WtoY4fTkIzR2Sn4Bsn/zDJuQDGq8fc8N1ljikQ7u5nN8/ynm+xKszNyScuafW2m7VLlmSU8s25iOMkGflRj9WTKKQrLA/yusbFcdhtQUqn3T+d3Bk0XdlAKSyqAw9Xq6l/huWu01wL507t6QlqRFLEZElvjfX25xO2A0r6ry8zKC89weKqthciRwziJanLMeZRVXYW+J9NpBZ6GWWanAl/xVgVwKESoa66yu9BNVIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSs8YJ3LVyp0mlidpELO9sLS27bYJKbA3ETpBozKwRM=;
 b=GyOGi2l2eOUYOEfVQ6IPXNf/XSsIG52GzZ2FUm0LJX2Aje9zn/ZmawUwXgdlsVh/Ut2LZ4wrbMSMAQKu3W08MqUqdMtQoISVAm7hgRj5y1V3lRa9VfWE/OEYWjL0w/4zJlebxUA+ProuXIe8qJMf7bzZosbCUtBfaPi2o98yVJG0FhGYhh7dUeaM2v6YM795cZJC5510w/+83k3hJuE7ThiD6+8aYRQKyTpp/tdlpkcuWblKYGdxp8wuRrcOqAv8jKGFlHt7GcR7ASJy85z0HFIKJ926aixLyu9lByodqHoaZv+TKq2WUfQMtYlTfXUI0et0u/6bJ/o9657IZCebmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSs8YJ3LVyp0mlidpELO9sLS27bYJKbA3ETpBozKwRM=;
 b=vSN2xEQ1qX24hBK5NpBfKRC04vR7Dl/GH6IoVRWpYKyDiQTzEpPKWygnqRpp0qtodxijKFsjiJbvhlBVo9SxDZYwYAYX2M8lnMU1Q5jXfxvQUQl1xXRoCETCskXi3uojPPF6M2SCeep+8zCcejmfWeN4dktrajBPCCjOPIzON38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:36:13 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 08:36:13 +0000
Message-ID: <35c83386-8724-451e-a63f-2002f0de6502@amd.com>
Date: Mon, 21 Sep 2026 14:06:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: reserve the VM root BO around CWSR
 param validation
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com, jamesz@amd.com
References: <20260918200444.450067-1-James.Zhu@amd.com>
 <cda03a32-3f6e-4dac-b741-f562497a410e@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <cda03a32-3f6e-4dac-b741-f562497a410e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 123e43e4-4a7e-4c92-8fbb-08df17bb6533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aDmOP470HbacbNTERe19bXwlBZj1t+1FztEY7oOw/7+sJyCdIjIsYyQPOIYUU7cyZV8WAygK0J4qNCs6WgBKQQClo31bp4zi2bWlJXl/1pUhBU9i26Kou0NuFPsCcCt2tfrQzyyNkjjPHPLLc6xRFRPqgwL5TF+TYehVwWxuTt3+u5HZxSNvirLF77jsh/GQyB3Dftbr2L3txOhzpYsnvreMVo6GiMCFbf7j+84+sgCMtWYHqxudfyKT4f9VQukU2qu/zFEQ4HVhRrRpjnafUU5X9xJD0ZjQafZY+FbpeUle5l2+g4DyfjbocV08VHuGwR/AR+PyIckimy8VxBxZwvyxtElW45XI2b6Xexv8SOojDAPobLBafuxcp2ro4aV+aOzlPdOdZwW+Tub/MYTqeJ667QVmhQQX6JY3g2J9pHhBKXuef7Zw13MIora2+lGZ08GRSe6nPE8nf3LyJsGfWKRtb+4NdZ3bbc7F1XaJloisr7mkOw1y9joubeau1voK4+WQZ+d7zhizZwgcKcgI9AawwgPrcPG4/hB9m4twhiuwJoESsA4kY8M+UMM1eYYO4NGEdx6UHxxKDnjfRTW+j+17QpMtt0Db4yGixkgEGXf+RVT9L+3mCXDrFVxwUOn5aa6Il4nkO1kNYpiIGDpXWGuWfwi6irThHotIqWK/eCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTUwWjFGZUVpczNXdGpTTWZiYUNzM3dNdEtaTEZua2Z6YkVRUW5QYTM2dmdq?=
 =?utf-8?B?VEZseDZOMjlTdS90WkdEcGJZQ2JnODRhNjRvMXNHT2JpZ0FMT3YybjM5cmFG?=
 =?utf-8?B?b0tZRGRCNUdML0J6cSs3dGEveWE1dGxzcFNpemgzZm5scHplejYxaTRzY2xX?=
 =?utf-8?B?WDEveHNkMWo5UXBsN0YxbzcwWmdkQlcxd2ZHMjNIUm5RcjRsUHJXQWpjT0w5?=
 =?utf-8?B?NGJ0NGFsajVJaW9nTE1maTBtbDBObkwwK1llVW9SV2xKL0Uzd200MW51bU9B?=
 =?utf-8?B?TlVFeTZremdITkxST2dFZ3gxOHUzY29XanFjRGZJeDdIU2lnQVYxVE1WMlE2?=
 =?utf-8?B?SU5vNE4yaFBaYTRjRHIzcHpZQ0E4cDVZckRHL0EvT25jL0pPNHkzcjJjSWJa?=
 =?utf-8?B?dldCRHNXd05YU21nTGN4QkpJNXhaV0s4RFNBalBsNy83YS9yNTRVdmtCTUgv?=
 =?utf-8?B?VXd5NHBrSzFVWWljTk53c2Zsam02bnJWTUtMcHY3OGowYWtEM25hTFRtaUwy?=
 =?utf-8?B?dlV2bTlqTHNGRmVHa054dWNHVVV2Sm80UHc0bGhhUEdKYW04Y2ZmbjRyRk9z?=
 =?utf-8?B?akZtRzNZYnowUU03dFpUZUZkOFJrSVlKYnVDQ3krMS92bExuTmpQUHp6cy95?=
 =?utf-8?B?WEpRSHNkeTNWaU40aHJ2bUhCV3VSV2NBODQyQnFYcTZHSU16YjRLWE1lWk9H?=
 =?utf-8?B?WktiQ0piREo0dW5qSHg0OUgza25UbVh0WGdZMFd6L0U1QWRaNXN3dlY3Mkk2?=
 =?utf-8?B?eUFVWHVXOTQvYm5VRnJnYVJXSzB4K004OFFtQThxdzNqanpRQ0crTWhlUkVN?=
 =?utf-8?B?NWNBd0dFWXFPc3dzV3pHRHpINUVIYVNYVldaQkFzbU1lZ1NtZjY4NnY5d3Jq?=
 =?utf-8?B?bmx0RjJ5ZjlpL3dLSFpPdUsyRG9YNEV2RUwvWjRrWCtHZWNCZkVMTkNxRFY3?=
 =?utf-8?B?OElXa0FxZXFaV1FOYVB1VkVGVzljZlpyRWlNeElvTCtkazVncWRZNmR6eVJv?=
 =?utf-8?B?Y25udVJTNklvdFlKMFBoWHZHODUyM1JJcDExT1JEdWFmOHI5ZXFRQy82cnBw?=
 =?utf-8?B?RWRWdEsreFM3RWpFL2U4WVp4NGphWjliK080OERKVTNKU2pYb3hvMlorUmVK?=
 =?utf-8?B?WHZTQStzdndJYXlZY1UzbGJHK3lnNjR1SjhsQ05Bc0lqOUVDclRIeUlicnZs?=
 =?utf-8?B?SzJoV05Ca0Nrd0tLNkFWN3BBMjRqazYwTkVQWW1BVzNpK1o2Tm1iRzhSTkxv?=
 =?utf-8?B?d09pY2plOHcvOVB5WGN5Q0JZMElNcVYzLzVyVUVuNjFuKzhvUWxtcUhQTThM?=
 =?utf-8?B?U1VwTzAvc0lxZkVxYUtaUEFrWkppdEJSZjRCNTlXRmNsY2tZZjRsZENDd05r?=
 =?utf-8?B?aG14dGJZVkdxdWhPeVd2T2tsZmpzTGRMOTNRb1ZqYVd4TEdXQVdPQzFGcFZJ?=
 =?utf-8?B?RWRIREd0R2xxMWhhdEk3MGN2dEdRbk5ud2wzZWNFVzRscVJ5TjMyeGI2TGFj?=
 =?utf-8?B?eE1Lbjczc2ViYXl6cTdLc2tqZkc5K1BwVU8xWXZ1ekU0MWRJaVFDQWNjSE1h?=
 =?utf-8?B?WnYxTU9TV3NwUGxWakorSWNlRFh1Sk9NQ0ZXaTVjU0dENFAvcDMyR3FtaUdl?=
 =?utf-8?B?bGJnUkJpVGttUEZ6TDV3WGVvMENjKzA4eTEycUVSWHd3UnQ1bFlFZzI2MVdz?=
 =?utf-8?B?ZVlNejh6bG50YnZINDNkNHg4ZnAvUkRGWWRlbVBKb2pvWkV0dlVMT20rVkpT?=
 =?utf-8?B?cW5nb09ncVhkendFVXJEcUJ2VUpCUU0wVUVvZlpKWFZ0K2lHWUNseXhCUkxN?=
 =?utf-8?B?TkFzS1NJemFuQllqOEdjZkg5RWJMdWh5VDczQ2o2ZEptVEdIM0ljMnYrZDk3?=
 =?utf-8?B?TExtU1plRU1VQzhhblVuK1Zmb0Z1Rkp5NWh3cmJtL205WCt5RldXNFNPYmk4?=
 =?utf-8?B?WEpYTHlaZ0pyUmxVcHhKNEFMbHVubE12WDhGQWlQVXM2S3o5K3FJRGc3WnMr?=
 =?utf-8?B?SWJnUnh2aFNTUWF4eE9PVmhoYUFiUXBtT0tqc0xsQklHaWlOWmVycG9NZGNp?=
 =?utf-8?B?T3FDa3FyR2ZZQXJWV1J4dnprQ21ZQUhyYTVtVldUeWd6S0lJZEp4emFOZWR0?=
 =?utf-8?B?dU5yTFVjeTNGbmFQR3dIdVBJQUpmMkp3RjM0cFhrSnltSWFOWXhnUzhuOGho?=
 =?utf-8?B?SE5lb2t2RjdRMmVVTi96Yk8rUFArcEpRYUswYUYwZERPMUtzMlp3Wm5PVnlK?=
 =?utf-8?B?QndHZS9YZmRpL21iMHk5aHhSNTE0YUJ0d1hGekdjaHR6NFI0WHo5TVN6S01V?=
 =?utf-8?Q?Hkl08W5TllK8aZ4Lyt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123e43e4-4a7e-4c92-8fbb-08df17bb6533
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:36:13.6099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4sQyzyGiIJ7whWMnO4tceVCWT55yFHzBBOwyDJSqrE3G2h6CR4DPDik5sZGK0/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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



On 21-Sep-26 11:23 AM, SRINIVASAN SHANMUGAM wrote:
> 
> On 9/19/2026 1:34 AM, James Zhu wrote:
>> amdgpu_userq_input_trap_params_validate() ends up in
>> amdgpu_userq_input_va_validate(), which walks the VM mapping tree and
>> updates bo_va->userq_va_mapped, so it requires the caller to hold the
>> vm->root.bo reservation. The CWSR branch of mes_userq_mqd_create() called
>> it without that reservation, tripping the dma_resv_assert_held() on every
>> compute queue creation when trap handling is enabled:
>>
>>   WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:232 at
>>   amdgpu_userq_input_va_validate+0xb9/0xd0 [amdgpu]
>>   Call Trace:
>>    mes_userq_mqd_create+0x49c/0x9e0 [amdgpu]
>>    amdgpu_userq_ioctl+0x935/0x1070 [amdgpu]
>>    drm_ioctl_kernel+0xb3/0x110 [drm]
>>
>> Bracket the call with amdgpu_bo_reserve()/amdgpu_bo_unreserve() like the
>> other input VA validations in the same function.
>>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 2150973b947d..16aa22b25098 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -508,7 +508,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   			trap_params.ctx_save_area_address =
>>   				compute_mqd->ctx_save_area_va;
>>   			trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>> +
>> +			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
>> +			if (r) {
>> +				kfree(compute_mqd);
>> +				goto free_mqd;
>> +			}
>>   			r = amdgpu_userq_input_trap_params_validate(queue, &trap_params);
>> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>>   			if (r) {
>>   				kfree(compute_mqd);
>>   				goto free_mqd;
> 
> The CWSR VA validation accesses shared VM mapping information, so the VM 
> root BO needs to be reserved while doing this. This change adds the 
> missing reservation and avoids the warning during compute queue creation.
> 
> Could we also add the corresponding |Fixes:| tag?
> 
> |Fixes: 7ca9abf4ac38 ("drm/amdgpu: Add user save area params to mqd input")|

That change happened later
	85653fe2e52e drm/amdgpu/userq: hold root bo lock in caller of 
input_va_validate

But the user save area patch was not available in drm-next that time and 
probably that's how it missed.

Thanks,
Lijo


> 
> Separately, the repeated |vm->root.bo| reserve/unreserve operations in | 
> mes_userq_mqd_create()| could be considered for a follow-up cleanup.
> 
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 

