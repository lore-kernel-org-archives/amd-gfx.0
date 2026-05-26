Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A175CD5BD1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 09:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9605B10E179;
	Tue, 26 May 2026 09:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uuzYnFCR";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD22010E179
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 09:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di5NT94vwqLvXS1Rhqf43lT+GV6umJ6hc8rjtqh6tR1ItM6Qz7Wm82wyTuWmVq0cblSQ5d4faFk28SYB2pvMfesYCy54rHmGrMNGCknDb39NT5iurah93YqCgD+EfqJoioDJgQoQjTHdmaQJ8dedflCn6VsznawCxQDQT6iUHGrKaA/BZxAOESy69txuPJ/ZaaX3l5Hej+AavhmaApiPDAMnpmv/RoqYoc+LTLnImB4EX0e0HOArtaqmFGRFRi5Mo8QY6QxSQEdA+YdYDXGFiJQU5VotpgjjVkjeIthC2/qRcBVnWZDDbbRyGh/3mUoG4WBGUE6ZPdhNbsKCchcSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BOnsWY9WPCN03TC0lGetoIWn82wsHopN1cR+VTSjbI=;
 b=XY9RgqiPxYW1Ea/2T9xFeMv6feGu+pA44V/d5+yrZVLX+Do6my8XAonrtdwU2S5vNgnGHn5myzfjrS/bNHeWooFA9ZckcRw7xlYil/dn5xbU4/J8DZ8ghb3IORhnh+nHgszegx4ofnkow28OGnnZZDJPJYlnb9b0jz16Q5LBmxg05eTQaT8yxs37geuCWG2A9enU8rmSXttbmi8IChZCmUeqUVeeXzIfSFeuqlZ1Be0zm6CE04Z0l6qpFDt4OAtJ8S6NXcLZExoDF30zsyKktRuG/rITcG/8qPHg4RQ0wl3ESyGdL+bj4aGCMrxn4cuvzA6JfLxULA+SmQY8K+O43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BOnsWY9WPCN03TC0lGetoIWn82wsHopN1cR+VTSjbI=;
 b=uuzYnFCRGBh9bkAIjrtaTjzGLX0DZZ0moUcFkgW5FSrcWOvOAUz+ip/uo/vpuMLJMw6KE29IcsRTAQXm4CLPZ+RNkHbhXUFykJoz8s1DlOdxHoFoiIE2R6sU/VYTv44yVoiHTYlFeckQKLegp4qL3pA/WOA8yTp2dysshjaPkjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:31:17 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:31:17 +0000
Content-Type: multipart/alternative;
 boundary="------------0ideELL6gzORsx5pJEwDnrZE"
Message-ID: <28f20c70-978c-46a4-8531-0d4d1fbd7734@amd.com>
Date: Tue, 26 May 2026 17:31:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: implement per-process MES context
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com
References: <20260525082359.5510-1-lingshan.zhu@amd.com>
 <53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com>
 <591307db-a567-4bac-b995-1eec64a7c42d@amd.com>
 <7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com>
X-ClientProxiedBy: KU3P306CA0009.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::13) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: f946145f-34c5-4481-f201-08debb0989ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|18002099003|56012099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: Y7BMragSCXpPYfIfvuIDfIYeF8+fQ9NHFabaxTbaZ/Kktq1QV1remE9ca/AjfJnfQddo9qcQ10QSRC5jl58t0n8LD+dvfm6vWGbymuy/CVS8QgfDDZJT049rJQRV1O6C7qE68r38Eiid2QnTvSb1zedonVlY2REpvSJDfP2c8i9ymtoC2+JL2/MemB/y5c747d004M9ThEUbpx5cZIa4ZXZ1mLMGr7ktGlw9Q9PrJsVSO6Az/X1fhYj5uexQ+HA0/abIEh+fVT1U8WQ0GHE/kfEOzl5MR4VK8FQ0whwU0ZUGEbd4oz17jqbCKAxZFtKor+bE8JNU6hfysS6KK08s5bysXiCkqUK3MTqTCBfjCrMuR90IRP3tPObIBYsW4O+6wvSciaTgbidC6gayCkPrBEZlV3D3J+G6cQZUDdhDlLQHU9NYOIqbmmiTO/q8m6SK9PYDFf6COsszdK4dnkR+VtnNncN3JcKmyH1uPzWH0dWfRRSmPJ12bzWqjgPSgbFRT5QmZeIvHu8BQuGItS+sxRDM3McV6UAnLCkMEHwlfUGn1wx7vtTGwGhNOLa6Ka5w9vH1H2BBTpJz5pz+/fk0RFJrh6mTRsvSQdiVRNuNjDliK7KtyTtUjRwwXE4D1OrNERU7ASQTofBRDpNRVyXY+rJCZ4IwdLps/z0lMYfIcAVikE1j0YGPfiz+2anXT0Fd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlV3U2VEU3lkajZtZWFBSzVsY1JCUjZtOElwTFh4WnRNV2VQRDF1TUYvOGh1?=
 =?utf-8?B?bDB2Ri9mRTNxcTJGZnQ2blFHZDFkelowcThENGc0dWE5cFBvVGdPME44bGI4?=
 =?utf-8?B?UExlWjJ2N2p2eXhMUXMzcXVPQVZRcjJFWlpDT3ZkMXE3TzJBdHBUUWREVy9a?=
 =?utf-8?B?bWdwcW5EN1dmV1pwaGh5dm1ickgydmRTdU5xTDZNYlk5ZmdXZzY5bTU2a1FJ?=
 =?utf-8?B?bFZCZk5IVUZBbERDMEZNeG1sSE5YV0lvbmdBZzUwYTRVNUg4c09weUdoOTlr?=
 =?utf-8?B?TS9oRlJkUVhaUGsxNzZRNkp5WTlXalF4aFo1T2RMZWtDajhuWGtHQzEyODRP?=
 =?utf-8?B?Z2dpUHdpNGZIZXdXazg1ZVFHS1p0Q2JzV0lldVgwSGpBWENCdmJmMmR4eFZP?=
 =?utf-8?B?VFdpNVlZL2UvTUgvSE9KWVZKcXNmWmtLdDFUcHFYVFdyTThiRWlaaDdiRDJh?=
 =?utf-8?B?Z0JRT0F3bkt5N0ZLUDRiM0YxU1M0cDRwTWsyYmEvNWZDTXRHKzlGQnlSTDJa?=
 =?utf-8?B?VEdoY1lrTHdzZyt0TzBXMVM0M2Rtd2cxQjlDZjBVWHhoV2tmejgxT1QvWjhp?=
 =?utf-8?B?YkI3U01mS1F5VWZ6MTdiODRDSG1xQnBacVpERlYyK1oweklwYmUzeUJGUVgr?=
 =?utf-8?B?VHVQdzBNb1BuK2xxWU9KYWluWXhLc2xiMUgrNjBsUWVGRUdCcmRKUjR5cm9w?=
 =?utf-8?B?dU9Ybmo3RmtrOW9ndXVhTWI2NHpVbzlBUnV0VnI0cDRGb1IvN2pnaFRUc00r?=
 =?utf-8?B?TTdSUEhSQjg1TzAyeWJTQUgyc2ROckk4OS9TVmVCUk90bVNjamY3ZG96RGky?=
 =?utf-8?B?TCtJakhvaVNRUnd3YUd6VHQyemJaTzcyblpoODllUUJNVzJCejhlZGZWYVlI?=
 =?utf-8?B?M3NMaUc4bzE0a2pDV2lsM1hmS05RYUk5dlk2VnJSeHBFRk1rbVlFWlM4Mkdy?=
 =?utf-8?B?MEFNaHJoellYSlVYazdOYlZUS2dqMGVOYmlpLzFwTzhUSmw3YUx3VXJPbFcv?=
 =?utf-8?B?RmJZM1dMeFVqb0NUaWlMQ2k1WTRzSXorN0xqbjdINzdEM25oYnRFUDNyek9I?=
 =?utf-8?B?dDRMTXJIeGZqaXJ3Q3E1SlRhb25NcTdhNDNIQ3hqL000TGc0endSSGtHWW1v?=
 =?utf-8?B?YnRLZlZVZklJWDllVEZqVDJxRFlJMDFIMlhOMWhwSFU5aS9kU0ZvMEU5RzF5?=
 =?utf-8?B?ZW8wanJEemY5VEhrWlk0aUFRZWdLUXoraTZjQWhnTnVPd25YNkZXVUkwc09D?=
 =?utf-8?B?bHlvQmFPRytOWVMxWUw2WTV0NTVnYTMrY0RqeTNxOFZLWnBrMVFJWitRWFN2?=
 =?utf-8?B?MHVlVHdRQ0xaeVNBYUhqTlkyVFhldndYSWY3cTlndzdjSGx3N1NmeGM4bVpF?=
 =?utf-8?B?blloSTVqZ1NNTEFsaGZIVGpITWJmdENUTzBpZG5HS1VYMjZuWUJ4T1Z4QnFj?=
 =?utf-8?B?MHQzei8rWUpwWVZaMENJUzd3b2xpbDhGSTJKS0N2aE5JSy9aV3lORFRyR1Vk?=
 =?utf-8?B?THd4NFdlL0F4UTlpVWp1TFBXeTh4SDdrZ1BMTU0rYmtkM0F6Ymo4bE5yeS9i?=
 =?utf-8?B?TEp1c3Uxa2JuOTA0Q0JuL3VlcUZvRTdDMnZxUjBEOWNPRXhRMC9GRkQ5WUtU?=
 =?utf-8?B?MzRkTEl3Sy9PWEF6VCtGaWJReHc4UzF0TFVmbVNqSkoxYUhYMitiTmRaVVFk?=
 =?utf-8?B?aVZKOHZQalhrNk55N3lLem5wU2R5WDdvTTU3OXdMbGJMcWtHRlQvVlpURjdr?=
 =?utf-8?B?bFMzT1JNOXB5Q2llanlCZEhMcTkyYkxrNVNWdXIvbzZ6QmNBazg2VHZXV2No?=
 =?utf-8?B?KzlxS2VCMm82bmNjc3JrcnlBSk51Vnp5aWxFai9IWTVPNEcvd292aUp1dUhv?=
 =?utf-8?B?Q24wWmduYzJWd2lsQnY4VWxhbmVpUnk1RE5BVklUVjFydzNzbjFZbWw0SjZl?=
 =?utf-8?B?eCsvUDFuT1pFMDBvWjVXemdUOTdoNWtzTkZpU3crL1dNZjBJT21RbUZxTGlm?=
 =?utf-8?B?QTVDNTBxdUh6TWVZcVlobGlRZlp1WnMvbWY1WTVULzBaVlIyamlqaEFrc3RY?=
 =?utf-8?B?V04vY3YxNFlES2tBeENnL3BER0gxMCt3LzIxZWtQUWN5NGExUUtxVEVSWEZp?=
 =?utf-8?B?NFIwU2dvNjg0VWtmaExiVHUvTnZId3Fvd1FGLzMwcXgxZ3I3b052NVpOSVZr?=
 =?utf-8?B?NndLNGJtL1Fjekk0TkcxV2pCZ2xoQ0xuMGtFSm83ay9oVXdyOXc5aXo3ZmRO?=
 =?utf-8?B?M2lzRzVuRFQvT2hNQUZiZG1xSC9YVzJHZXlxQStDcGpObmc5cit1YjY5eXcx?=
 =?utf-8?Q?C/yLPKbFm8qHarfwXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f946145f-34c5-4481-f201-08debb0989ce
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:31:17.5811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69SNwtUmXa6IC2I6EpQn10sp3GwgKEA8J2fkq0Kvdpd+o1EQxrflYbzWqKz/9XyFFKjYEscJAMVkSvZrJHv1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

--------------0ideELL6gzORsx5pJEwDnrZE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/2026 4:46 PM, Christian König wrote:

> On 5/26/26 09:54, Zhu, Lingshan wrote:
>> On 5/26/2026 3:02 AM, Christian König wrote:
>>
>>> On 5/25/26 10:23, Zhu Lingshan wrote:
>>>> MES process context is a process-level page
>>>> where process specific context is saved for
>>>> MES scheduler.
>>>>
>>>> However, current user-queue code path assigns
>>>> fw_obj of a queue to MES process_context_addr
>>>> when adding the queue to MES.
>>>>
>>>> This means every new queue from the same process
>>>> would replace the previous process context address
>>>> with that queue's fw_obj address.
>>>> What's worse is, when user space frees a queue,
>>>> its fw_obj will be freed as well, causing MES
>>>> working on a NULL page pointer.
>>>>
>>>> This issue leads to inconsistency and crash
>>>> in the scheduler.
>>>>
>>>> This commit allocates a process-level page for
>>>> MES process contexts for a process other than queue-level
>>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  5 +++
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
>>>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++------
>>>>  3 files changed, 42 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> index 38e310a8694d..0c4d6f80616e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -1225,6 +1225,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>  	 */
>>>>  	cancel_work_sync(&userq_mgr->reset_work);
>>>>  
>>>> +	if (userq_mgr->proc_ctx_obj.obj)
>>> Please drop that check it is unecessary.
>> sure, I can drop this in V2.
>>
>>>> +		amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
>>>> +				      &userq_mgr->proc_ctx_obj.gpu_addr,
>>>> +				      &userq_mgr->proc_ctx_obj.cpu_ptr);
>>>> +
>>>>  	mutex_destroy(&userq_mgr->userq_mutex);
>>>>  }
>>>>  
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> index 28cfc6682333..fe85234e58b3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> @@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
>>>>  	struct amdgpu_device		*adev;
>>>>  	struct delayed_work		resume_work;
>>>>  	struct drm_file			*file;
>>>> +	struct amdgpu_userq_obj		proc_ctx_obj;
>>>>  
>>>>  	/**
>>>>  	 * @reset_work:
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> index e9189f07c6dc..3022025bc2ec 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> @@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>>>>  	queue_input.gang_quantum = 10000;
>>>>  	queue_input.paging = false;
>>>>  
>>>> -	queue_input.process_context_addr = ctx->gpu_addr;
>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>> +	queue_input.process_context_addr = uq_mgr->proc_ctx_obj.gpu_addr;
>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>  	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>  	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
>>>>  
>>>> @@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>>>>  
>>>>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>>  	queue_input.doorbell_offset = queue->doorbell_index;
>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>  
>>>>  	amdgpu_mes_lock(&adev->mes);
>>>>  	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>>> @@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>>>>  	int r, size;
>>>>  
>>>> -	/*
>>>> -	 * The FW expects at least one page space allocated for
>>>> -	 * process ctx and gang ctx each. Create an object
>>>> -	 * for the same.
>>>> -	 */
>>>> -	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
>>>> +	/* The FW expects at least one page space allocated for gang ctx. */
>>>> +	size = AMDGPU_USERQ_GANG_CTX_SZ;
>>>>  	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
>>>>  				    AMDGPU_GEM_DOMAIN_GTT,
>>>>  				    &ctx->obj, &ctx->gpu_addr,
>>>> @@ -257,6 +253,27 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>>>>  	return r;
>>>>  }
>>>>  
>>>> +static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +	int r = 0;
>>>> +
>>>> +	mutex_lock(&uq_mgr->userq_mutex);
>>> Clear NAK. We can't allocate anything while holding that lock.
>>>
>>> Please add a different lock to protected the buffer or just oportunistically allocate it with CMPXCHG().
>> I will introduce a different lock in V2.
>>
>>>> +	if (!uq_mgr->proc_ctx_obj.obj) {
>>> Please drop that check, amdgpu_bo_create_kernel() should already take care of that.
>> I think we still need this check, because although amdgpu_bo_create_kernel() checks (!*bo_ptr), but:
>> 1) it does not immediately return if bo_ptr is valid. It only skips re-creating the bo,
>> it still calls amdgpu_bo_reserve(), amdgpu_bo_pin(), amdgpu_ttm_alloc_gart(), and amdgpu_bo_kmap()
>> on every invocation.
>>
>> 2) it calls memset() unconditionally on every invocation.
>>
>> So I think this check is still necessary, and another thing, do you think
>> amdgpu_bo_create_kernel() should immediately return if *bo_ptr is not NULL?
>> It looks like this deserve a fix.
> Good point, IIRC we added this handling to make it easier to re-create kernel buffers after suspend/resume.
>
> I'm not sure if any code path is actually still using this since we found that for a lot of use cases you need to keep the FW buffers at the same location even after suspend/resume.

Yes, after suspend/resume, it is every reasonable to expect the FW buffer still at the same location.
But on a second thought, I think it does not need to re-create kernel buffers,
because it is a suspend/resume, just like taking a nap,
the BO is not destroyed during this suspend/resume routine,
so I think it can simply keep using the original BO, no need to re-create.

>
> Anyway just add an if and comment why it is necessary.

sure, I will keep this if, and leave a comment explaining why.

Thanks
Lingshan

>
>
>> Thanks
>> Lingshan
>>
>>> Regards,
>>> Christian.
>>>
>>>> +		r = amdgpu_bo_create_kernel(uq_mgr->adev, AMDGPU_USERQ_PROC_CTX_SZ,
>>>> +					    0, AMDGPU_GEM_DOMAIN_GTT,
>>>> +					    &uq_mgr->proc_ctx_obj.obj,
>>>> +					    &uq_mgr->proc_ctx_obj.gpu_addr,
>>>> +					    &uq_mgr->proc_ctx_obj.cpu_ptr);
>>>> +
>>>> +		if (!r)
>>>> +			memset(uq_mgr->proc_ctx_obj.cpu_ptr, 0, AMDGPU_USERQ_PROC_CTX_SZ);
> When amdgpu_bo_create_kernel() does that the memset here can probably be dropped.
>
> Regards,
> Christian.
>
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&uq_mgr->userq_mutex);
>>>> +
>>>> +	return r;
>>>> +}
>>>> +
>>>>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>>>  				struct drm_amdgpu_userq_in *args_in)
>>>>  {
>>>> @@ -429,7 +446,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>>>  		goto free_mqd;
>>>>  	}
>>>>  
>>>> -	/* Create BO for FW operations */
>>>> +	/* Create per-process MES process context BO */
>>>> +	r = mes_userq_create_proc_ctx_space(uq_mgr);
>>>> +	if (r) {
>>>> +		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
>>>> +		goto free_mqd;
>>>> +	}
>>>> +
>>>> +	/* Create BO of a gang for FW operations */
>>>>  	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
>>>>  	if (r) {
>>>>  		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>> @@ -492,7 +516,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
>>>>  	*fence_ptr = 0;
>>>>  
>>>>  	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>  	queue_input.suspend_fence_addr = fence_gpu_addr;
>>>>  	queue_input.suspend_fence_value = 1;
>>>>  	amdgpu_mes_lock(&adev->mes);
>>>> @@ -529,7 +553,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
>>>>  		return 0;
>>>>  
>>>>  	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>  
>>>>  	amdgpu_mes_lock(&adev->mes);
>>>>  	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
--------------0ideELL6gzORsx5pJEwDnrZE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 5/26/2026 4:46 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com">
      <pre wrap="" class="moz-quote-pre">On 5/26/26 09:54, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 5/26/2026 3:02 AM, Christian König wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 5/25/26 10:23, Zhu Lingshan wrote:
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
          <pre wrap="" class="moz-quote-pre">Please drop that check it is unecessary.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
sure, I can drop this in V2.

</pre>
        <blockquote type="cite">
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
          <pre wrap="" class="moz-quote-pre">Clear NAK. We can't allocate anything while holding that lock.

Please add a different lock to protected the buffer or just oportunistically allocate it with CMPXCHG().
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I will introduce a different lock in V2.

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+	if (!uq_mgr-&gt;proc_ctx_obj.obj) {
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Please drop that check, amdgpu_bo_create_kernel() should already take care of that.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I think we still need this check, because although amdgpu_bo_create_kernel() checks (!*bo_ptr), but:
1) it does not immediately return if bo_ptr is valid. It only skips re-creating the bo,
it still calls amdgpu_bo_reserve(), amdgpu_bo_pin(), amdgpu_ttm_alloc_gart(), and amdgpu_bo_kmap()
on every invocation.

2) it calls memset() unconditionally on every invocation.

So I think this check is still necessary, and another thing, do you think
amdgpu_bo_create_kernel() should immediately return if *bo_ptr is not NULL?
It looks like this deserve a fix.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Good point, IIRC we added this handling to make it easier to re-create kernel buffers after suspend/resume.

I'm not sure if any code path is actually still using this since we found that for a lot of use cases you need to keep the FW buffers at the same location even after suspend/resume.</pre>
    </blockquote>
    <pre>Yes, after suspend/resume, it is every reasonable to expect the FW buffer still at the same location.
But on a second thought, I think it does not need to re-create kernel buffers,
because it is a suspend/resume, just like taking a nap,
the BO is not destroyed during this suspend/resume routine,
so I think it can simply keep using the original BO, no need to re-create.</pre>
    <blockquote type="cite" cite="mid:7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com">
      <pre wrap="" class="moz-quote-pre">

Anyway just add an if and comment why it is necessary.</pre>
    </blockquote>
    <pre>sure, I will keep this if, and leave a comment explaining why.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com">
      <pre wrap="" class="moz-quote-pre">


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks
Lingshan

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Regards,
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
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
When amdgpu_bo_create_kernel() does that the memset here can probably be dropped.

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+	}
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
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------0ideELL6gzORsx5pJEwDnrZE--
