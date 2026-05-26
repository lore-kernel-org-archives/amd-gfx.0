Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283CBCD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED8410E0F0;
	Tue, 26 May 2026 07:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nkXryJcp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADAC10E0F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCCqe65scleK2sAXN228PDT2kBWTzYdRGEm/s6pTLGdUl/8XQx3AD1W5NspjP4A4TU6LL7EhYJdy8bujsSiGAV93fdOBjMO1TDFEpcNCk6fNBqsCmb9KhFWBzSGCHPOFHV/Czv8WMocjV7oqxVZ1D8qRtjLA9BWWC66HC1a1Nxp/86+w8fKgs5ebx4Sqr+Lz9ugyZUz6RCl3JCr7VL2OIHb5jifjQlOMtrJC80lvk5eWpmY+AmOMTZ+r+t4J2nGMiLjI/6nfKRjEraeuDNJXheKoAXt9p7JLdZsUHHYQpGK9cGHavRDywWYrBTLaif2iCncMFx5Ov6mDZdONc1JHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfi/DCBjCorJPmAhJdpG5mq6FHtVRD/IAvMaQmXIVAg=;
 b=SAAAbKoQHInSadJSYphhPnVv9DfyO3i/L6/XyGuzIhaWfGktbONvngxmiCWz24qikSSj3xcPd1PiekkkRgUK1e003JOZAAgzuEBh8/ZI5Gphc0oUsV6n+W+L+3nIiPsSwtqWnBrsK09piRJ/i1wfUMRu1CuF2YtrAJXO0wZWLO5Sren1BEAIVGqARTV31rywnI2r3VON4cnwKsfQ0gRvoCAibV2s+QedhxEuqGZ5eiBltDmCu0BUeXhWU1hhjPT7uIKniPO8H3zsow5EE7C84/e+2RlYQQClUIGW2hEiykBotMjeqhXsPHdL0Fn2U1NINu4sUkP52GEHETF0Q5pkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfi/DCBjCorJPmAhJdpG5mq6FHtVRD/IAvMaQmXIVAg=;
 b=nkXryJcptBPyXAeTYQC8qo5M+AHep7UGFdo/QG1KWI6POJ6tVzdc0KG6D7+4MHii4YY1IfPEpYKtGSf98k5BZgy58/4qrHGfwiYxkyT00oOTDb664S22lOwY1tnAcniTDWIJyJljcJi5lzYMPGTTZgC55GtYj4EtswtXreo39fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:54:51 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 07:54:51 +0000
Content-Type: multipart/alternative;
 boundary="------------83o3wpKNwqf1ce021C8R4rkR"
Message-ID: <591307db-a567-4bac-b995-1eec64a7c42d@amd.com>
Date: Tue, 26 May 2026 15:54:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: implement per-process MES context
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com
References: <20260525082359.5510-1-lingshan.zhu@amd.com>
 <53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com>
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ea23fb-6d29-410c-efd2-08debafc1093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|4143699003|11063799006|18002099003|56012099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: 5cXYQrm6/yNjcozi0QfvGi0cbCQnjhovhX3RpK8lrHy9UEDIsTPYa1f8/m5KZXs7glplR8yKedRkQC5rUSWoQqMdc7bsCJ+uspalxfDG2Rhk80BjKzxfxdsNnCcyfRP+Ww6LHRn+MxIkpCsqaosYKTLPfNEP3QtALodO5Q6Am0ZTLoBljqrxYUnauJPHFJn9M7YKTp36fdLNkKm37NHfeDrswKc5AN7gAUJZMtsM8Bc/E+04ftm4HHW7oEe63zyvzMN61S8/+VZLmLffKD1zyknXpI5hqy2afhPYqKYcVUaxTgvXrenVEU1WOoOnRuV71vfr4wjpC4McBbnSQBUhSmDuUxmhW6I5pGnwCnIXFsIwyKEkf5Da/iW29b8KGg/lcfPwVSMb20WlEULUb5NNARH4OF2MW1Es/8c0CtvDRh5jQ7SQxkR/xc9u9rod/maD7ehne7rdCc9lc401Q28jB7HbaCTuKFOL9/JgnuXX/dK4Z78QKURGU5AU5rl3yHa2oT2DAuLdpfY45IXXGng+baROfWdHO5TWjDVk8ddL9aEm1ljzgJVYPVZKr65nrdNcAACLsM138gNyFzcqCv5Rrmrs0EK7TBMtQ0acE9mBJfDsHewzqoH+EF4mKz8MX9h3zBcB6adjgg9LbsG1osTsd44L6WGt/ob29jVZGPClcapy3wuHJl5hoXhV5TpyWven
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(11063799006)(18002099003)(56012099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vzk1aU1lTFBVdFZ1MlRwaUlLT3ZITUpXNWt4anU1c0x6Q1dHWGZiRmlJcUJw?=
 =?utf-8?B?dm1vVlFPQXFTeGdEVXJyVXR1MUUvMnQ2emdJOHlxSm1qY1BCczZlbnFNNHhE?=
 =?utf-8?B?TG1GTm5NZVp6a3ZrZ3MrcjJXVzVKRUdzVDlWZW5ocWZZMWdoNkxBMlVwOGhp?=
 =?utf-8?B?cWlHdDE0VlAvOXhEb0xyVHBKMDhycmxYTHR6T1ZCeDRaMkdlMC92U2lLMHF0?=
 =?utf-8?B?WTd4bWtYMmhwd3Jnb1NFZjNtWExFdEpBeXVvQlAyMGlWUnY3VlhvN3JhQ0w2?=
 =?utf-8?B?ejB5ZCtkT1hKUEdBeC9hNWpaSDFQWGZLZUdxWWhIZjdndFhVNEdhVlhFWGdo?=
 =?utf-8?B?ZEVsbVFmRzV0UTNlZXIvd2lQYUxCREovU01IUGc0OExnSzBjcVIrcHZtRnY4?=
 =?utf-8?B?TFR1dlBCTjRjYVdjcmdKY2NzY2JBeTZCRXRPRkRoUW95OFBoOHF0QTd0U0gv?=
 =?utf-8?B?QzRiMjBCVGJTaVJkMTZ3dk9IT09KUm9JYVF5WU9TaENSNzJQK1lab0dEeGJm?=
 =?utf-8?B?dUowbUFBK2ZPbXdESkx0TG9rOXhPUU1OOWc3RTNOOGp0aHVpdTZDUWVIMy8w?=
 =?utf-8?B?ZEc5eExKRUVEZndCaTdrUkllTXM3UklKU21kRm1XNlZ5Qk1ZOEJXbHBudUc2?=
 =?utf-8?B?SjA1VE1oeSsyRGwva1FySHJoNzI1eENMSU5sTU91aS9vb1BVcjBMYmVxNjZF?=
 =?utf-8?B?U2tReUhLZFFwTldlT3hlOFExM3N5Z3JyRWhWd1B6Mkp0UGp5WVJ2emtrMzZ2?=
 =?utf-8?B?enByUlJDc0pZeVZQK1g1dTkyOU1KVWVLY2p5V3JjTUZ3UEwvVGkxMkhmcDJm?=
 =?utf-8?B?anB0M3NKUGQxdFl2OGk0UlJZYTBERHhmUGFmUGRlbXc0K1RMTTB2aGptWnM1?=
 =?utf-8?B?REhmaFpQOW03WG9CcTE2RkJwVEswenkyQmt2WXByUEpNczU4blR3aWZFNmZ3?=
 =?utf-8?B?YTNFRUw4VHhtU3NrODA4cnB6Y1RSNTR5b1RKNUJtSWdXZGJORFRjMzN0MmhL?=
 =?utf-8?B?YU5tK25OV2ZmdDRKeVlqSGpzOEdxTkxVa2pOSjA3SWFmOEM5K2xJeWZNRDAw?=
 =?utf-8?B?MUZablVvZ3hzRkJNTE5Gb21hUFg0cVh4WFB1UlNicTZjc0lxRWw1NXByTndC?=
 =?utf-8?B?ZVMwV0ZKbVAvUmhtNll4YTVhSk9EQ29NSXBaMnJmMWVrS3J0VGtxN1lsN2Fq?=
 =?utf-8?B?SEsrZ1ppUTJRSGdKanBBSzhXZVpKUHFlOWkxU3dtd24zVVBpWm93L0dMUUhQ?=
 =?utf-8?B?T0JzOFRERXpVdXJqZmYvbUN4c0tsb3BxR3pjcUMyeEtJTUgxRmtHUDZidWRJ?=
 =?utf-8?B?UDJEa1VHdlVVMGZucDl0QzRvS05nV1VnSFBTY001N3l3dlprWktDY2pBaDFa?=
 =?utf-8?B?Q1pZb0dKcENqbnYrQms2bExYZ3p2aXdTME9tWTlXTWcyZzBNVXZ1ZmZLMTV5?=
 =?utf-8?B?Mms0ejNGc2lnb0pieEw4N3BnaXVDMk9JY05XSWY1eVVMTVNwa01VQUhna2Iw?=
 =?utf-8?B?Vno0dmx1OHpzR1BPRXdhOFVBcm1uWExQNmp5ajJpbjdYS1QrYTAyRHV6UUtD?=
 =?utf-8?B?b1QvdTFQWnFiekhWRVJEZFBBdEJSa2ZZalVabklMWVQrVllVblJSbEczUWxu?=
 =?utf-8?B?b0NGcC9RYWhHSndzcHJGVUU4b3JuWUNLTVd5NlNQajJnSi9HOXgvRmdRK1lK?=
 =?utf-8?B?blJqMncwM0N6eGJwSStjdFE2S3ZtQWJDSkJyOHIycGFuWEJLWWlnRXlKN01Z?=
 =?utf-8?B?UGxDQmtoeDBSbHl5eXZzTmdYd09WZ3gvcFJQV254OW9hYjFzbTF2MEgrVUo0?=
 =?utf-8?B?SDh3VWZnc2pWWHNrTWRkWWhRdnY4NkszSkJNOFVUS3Jnem9nQkRWamc3UktL?=
 =?utf-8?B?c1h5QW81SUw2S25VZC81akkxTThYV3dkb3VNREtVOFhJUnFCQWFxVUpMZ2xo?=
 =?utf-8?B?VERyYmsxL0oxTVFFSm1XRThWWnRqMVYxak9GMHJLZ0V2TU5mclBMNjZNelhI?=
 =?utf-8?B?SHNvbURqeHo1TW44cGZoOU95cDhramVrU3FLd1JGWHM2Zmg3bFdiNTdsWWxY?=
 =?utf-8?B?aCtiQnBXaFc5NWlQNzFpZGtvZzZBcXE4VnNnOXJpZkZLamF6RU1UK1ZtYyt3?=
 =?utf-8?B?SllNTFVsNDcvVzdaWmlqOVpLWWRyRm9UaWlPQ0M4UFRkN3JEcTE2aGpJRDli?=
 =?utf-8?B?YmIxSGJYc2tnZjJOajM0WVpDbXNseGNmb2d1OGZjbWhTdUZUd0JXZGZJZHZn?=
 =?utf-8?B?eXdYd012MUdxYSs0NlorcDFlY0ZnNG5CcTJYbTBTcmlwY0NHSXJIU0Zzd2JT?=
 =?utf-8?Q?3pGZ0ZwhOmgDB9Kxrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea23fb-6d29-410c-efd2-08debafc1093
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:54:50.9426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAkxQ9Qs5tTcfAzCWfspkumpbK+yFWwZzP16NAdrxIDNkgLfX16RRCDoNIV56+k9TPDSvOqaaEzJlbQfEfAM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810
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

--------------83o3wpKNwqf1ce021C8R4rkR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/2026 3:02 AM, Christian König wrote:

>
> On 5/25/26 10:23, Zhu Lingshan wrote:
>> MES process context is a process-level page
>> where process specific context is saved for
>> MES scheduler.
>>
>> However, current user-queue code path assigns
>> fw_obj of a queue to MES process_context_addr
>> when adding the queue to MES.
>>
>> This means every new queue from the same process
>> would replace the previous process context address
>> with that queue's fw_obj address.
>> What's worse is, when user space frees a queue,
>> its fw_obj will be freed as well, causing MES
>> working on a NULL page pointer.
>>
>> This issue leads to inconsistency and crash
>> in the scheduler.
>>
>> This commit allocates a process-level page for
>> MES process contexts for a process other than queue-level
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  5 +++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++------
>>  3 files changed, 42 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 38e310a8694d..0c4d6f80616e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1225,6 +1225,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>  	 */
>>  	cancel_work_sync(&userq_mgr->reset_work);
>>  
>> +	if (userq_mgr->proc_ctx_obj.obj)
> Please drop that check it is unecessary.

sure, I can drop this in V2.

>
>> +		amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
>> +				      &userq_mgr->proc_ctx_obj.gpu_addr,
>> +				      &userq_mgr->proc_ctx_obj.cpu_ptr);
>> +
>>  	mutex_destroy(&userq_mgr->userq_mutex);
>>  }
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 28cfc6682333..fe85234e58b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
>>  	struct amdgpu_device		*adev;
>>  	struct delayed_work		resume_work;
>>  	struct drm_file			*file;
>> +	struct amdgpu_userq_obj		proc_ctx_obj;
>>  
>>  	/**
>>  	 * @reset_work:
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index e9189f07c6dc..3022025bc2ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>>  	queue_input.gang_quantum = 10000;
>>  	queue_input.paging = false;
>>  
>> -	queue_input.process_context_addr = ctx->gpu_addr;
>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>> +	queue_input.process_context_addr = uq_mgr->proc_ctx_obj.gpu_addr;
>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>  	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>  	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
>>  
>> @@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>>  
>>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>  	queue_input.doorbell_offset = queue->doorbell_index;
>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>  
>>  	amdgpu_mes_lock(&adev->mes);
>>  	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>> @@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>>  	int r, size;
>>  
>> -	/*
>> -	 * The FW expects at least one page space allocated for
>> -	 * process ctx and gang ctx each. Create an object
>> -	 * for the same.
>> -	 */
>> -	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
>> +	/* The FW expects at least one page space allocated for gang ctx. */
>> +	size = AMDGPU_USERQ_GANG_CTX_SZ;
>>  	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
>>  				    AMDGPU_GEM_DOMAIN_GTT,
>>  				    &ctx->obj, &ctx->gpu_addr,
>> @@ -257,6 +253,27 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>>  	return r;
>>  }
>>  
>> +static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +	int r = 0;
>> +
>> +	mutex_lock(&uq_mgr->userq_mutex);
> Clear NAK. We can't allocate anything while holding that lock.
>
> Please add a different lock to protected the buffer or just oportunistically allocate it with CMPXCHG().

I will introduce a different lock in V2.

>
>> +	if (!uq_mgr->proc_ctx_obj.obj) {
> Please drop that check, amdgpu_bo_create_kernel() should already take care of that.

I think we still need this check, because although amdgpu_bo_create_kernel() checks (!*bo_ptr), but:
1) it does not immediately return if bo_ptr is valid. It only skips re-creating the bo,
it still calls amdgpu_bo_reserve(), amdgpu_bo_pin(), amdgpu_ttm_alloc_gart(), and amdgpu_bo_kmap()
on every invocation.

2) it calls memset() unconditionally on every invocation.

So I think this check is still necessary, and another thing, do you think
amdgpu_bo_create_kernel() should immediately return if *bo_ptr is not NULL?
It looks like this deserve a fix.

Thanks
Lingshan

>
> Regards,
> Christian.
>
>> +		r = amdgpu_bo_create_kernel(uq_mgr->adev, AMDGPU_USERQ_PROC_CTX_SZ,
>> +					    0, AMDGPU_GEM_DOMAIN_GTT,
>> +					    &uq_mgr->proc_ctx_obj.obj,
>> +					    &uq_mgr->proc_ctx_obj.gpu_addr,
>> +					    &uq_mgr->proc_ctx_obj.cpu_ptr);
>> +
>> +		if (!r)
>> +			memset(uq_mgr->proc_ctx_obj.cpu_ptr, 0, AMDGPU_USERQ_PROC_CTX_SZ);
>> +	}
>> +
>> +	mutex_unlock(&uq_mgr->userq_mutex);
>> +
>> +	return r;
>> +}
>> +
>>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>  				struct drm_amdgpu_userq_in *args_in)
>>  {
>> @@ -429,7 +446,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>  		goto free_mqd;
>>  	}
>>  
>> -	/* Create BO for FW operations */
>> +	/* Create per-process MES process context BO */
>> +	r = mes_userq_create_proc_ctx_space(uq_mgr);
>> +	if (r) {
>> +		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
>> +		goto free_mqd;
>> +	}
>> +
>> +	/* Create BO of a gang for FW operations */
>>  	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
>>  	if (r) {
>>  		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> @@ -492,7 +516,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
>>  	*fence_ptr = 0;
>>  
>>  	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>  	queue_input.suspend_fence_addr = fence_gpu_addr;
>>  	queue_input.suspend_fence_value = 1;
>>  	amdgpu_mes_lock(&adev->mes);
>> @@ -529,7 +553,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
>>  		return 0;
>>  
>>  	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>  
>>  	amdgpu_mes_lock(&adev->mes);
>>  	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
--------------83o3wpKNwqf1ce021C8R4rkR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 5/26/2026 3:02 AM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 5/25/26 10:23, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">MES process context is a process-level page
where process specific context is saved for
MES scheduler.

However, current user-queue code path assigns
fw_obj of a queue to MES process_context_addr
when adding the queue to MES.

This means every new queue from the same process
would replace the previous process context address
with that queue's fw_obj address.
What's worse is, when user space frees a queue,
its fw_obj will be freed as well, causing MES
working on a NULL page pointer.

This issue leads to inconsistency and crash
in the scheduler.

This commit allocates a process-level page for
MES process contexts for a process other than queue-level

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++------
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 38e310a8694d..0c4d6f80616e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1225,6 +1225,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	 */
 	cancel_work_sync(&amp;userq_mgr-&gt;reset_work);
 
+	if (userq_mgr-&gt;proc_ctx_obj.obj)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please drop that check it is unecessary.</pre>
    </blockquote>
    <pre><font face="monospace">sure, I can drop this in V2.</font></pre>
    <blockquote type="cite" cite="mid:53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		amdgpu_bo_free_kernel(&amp;userq_mgr-&gt;proc_ctx_obj.obj,
+				      &amp;userq_mgr-&gt;proc_ctx_obj.gpu_addr,
+				      &amp;userq_mgr-&gt;proc_ctx_obj.cpu_ptr);
+
 	mutex_destroy(&amp;userq_mgr-&gt;userq_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 28cfc6682333..fe85234e58b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	struct amdgpu_userq_obj		proc_ctx_obj;
 
 	/**
 	 * @reset_work:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e9189f07c6dc..3022025bc2ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.gang_quantum = 10000;
 	queue_input.paging = false;
 
-	queue_input.process_context_addr = ctx-&gt;gpu_addr;
-	queue_input.gang_context_addr = ctx-&gt;gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.process_context_addr = uq_mgr-&gt;proc_ctx_obj.gpu_addr;
+	queue_input.gang_context_addr = ctx-&gt;gpu_addr;
 	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
 	queue_input.gang_global_priority_level = convert_to_mes_priority(queue-&gt;priority);
 
@@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 
 	memset(&amp;queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = queue-&gt;doorbell_index;
-	queue_input.gang_context_addr = ctx-&gt;gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx-&gt;gpu_addr;
 
 	amdgpu_mes_lock(&amp;adev-&gt;mes);
 	r = adev-&gt;mes.funcs-&gt;remove_hw_queue(&amp;adev-&gt;mes, &amp;queue_input);
@@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_userq_obj *ctx = &amp;queue-&gt;fw_obj;
 	int r, size;
 
-	/*
-	 * The FW expects at least one page space allocated for
-	 * process ctx and gang ctx each. Create an object
-	 * for the same.
-	 */
-	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
+	/* The FW expects at least one page space allocated for gang ctx. */
+	size = AMDGPU_USERQ_GANG_CTX_SZ;
 	r = amdgpu_bo_create_kernel(uq_mgr-&gt;adev, size, 0,
 				    AMDGPU_GEM_DOMAIN_GTT,
 				    &amp;ctx-&gt;obj, &amp;ctx-&gt;gpu_addr,
@@ -257,6 +253,27 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
+{
+	int r = 0;
+
+	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Clear NAK. We can't allocate anything while holding that lock.

Please add a different lock to protected the buffer or just oportunistically allocate it with CMPXCHG().</pre>
    </blockquote>
    <pre>I will introduce a different lock in V2.</pre>
    <blockquote type="cite" cite="mid:53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	if (!uq_mgr-&gt;proc_ctx_obj.obj) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please drop that check, amdgpu_bo_create_kernel() should already take care of that.</pre>
    </blockquote>
    <pre>I think we still need this check, because although amdgpu_bo_create_kernel() checks (!*bo_ptr), but:
1) it does not immediately return if bo_ptr is valid. It only skips re-creating the bo,
it still calls amdgpu_bo_reserve(), amdgpu_bo_pin(), amdgpu_ttm_alloc_gart(), and amdgpu_bo_kmap()
on every invocation.

2) it calls memset() unconditionally on every invocation.

So I think this check is still necessary, and another thing, do you think
amdgpu_bo_create_kernel() should immediately return if *bo_ptr is not NULL?
It looks like this deserve a fix.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		r = amdgpu_bo_create_kernel(uq_mgr-&gt;adev, AMDGPU_USERQ_PROC_CTX_SZ,
+					    0, AMDGPU_GEM_DOMAIN_GTT,
+					    &amp;uq_mgr-&gt;proc_ctx_obj.obj,
+					    &amp;uq_mgr-&gt;proc_ctx_obj.gpu_addr,
+					    &amp;uq_mgr-&gt;proc_ctx_obj.cpu_ptr);
+
+		if (!r)
+			memset(uq_mgr-&gt;proc_ctx_obj.cpu_ptr, 0, AMDGPU_USERQ_PROC_CTX_SZ);
+	}
+
+	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				struct drm_amdgpu_userq_in *args_in)
 {
@@ -429,7 +446,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		goto free_mqd;
 	}
 
-	/* Create BO for FW operations */
+	/* Create per-process MES process context BO */
+	r = mes_userq_create_proc_ctx_space(uq_mgr);
+	if (r) {
+		DRM_ERROR(&quot;Failed to allocate MES process context space bo, error: %d\n&quot;, r);
+		goto free_mqd;
+	}
+
+	/* Create BO of a gang for FW operations */
 	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
 	if (r) {
 		DRM_ERROR(&quot;Failed to allocate BO for userqueue (%d)&quot;, r);
@@ -492,7 +516,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
 	*fence_ptr = 0;
 
 	memset(&amp;queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
-	queue_input.gang_context_addr = ctx-&gt;gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx-&gt;gpu_addr;
 	queue_input.suspend_fence_addr = fence_gpu_addr;
 	queue_input.suspend_fence_value = 1;
 	amdgpu_mes_lock(&amp;adev-&gt;mes);
@@ -529,7 +553,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 		return 0;
 
 	memset(&amp;queue_input, 0x0, sizeof(struct mes_resume_gang_input));
-	queue_input.gang_context_addr = ctx-&gt;gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx-&gt;gpu_addr;
 
 	amdgpu_mes_lock(&amp;adev-&gt;mes);
 	r = adev-&gt;mes.funcs-&gt;resume_gang(&amp;adev-&gt;mes, &amp;queue_input);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------83o3wpKNwqf1ce021C8R4rkR--
