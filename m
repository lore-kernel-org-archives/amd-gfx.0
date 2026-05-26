Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0388CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 11:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF2B10E4A5;
	Tue, 26 May 2026 11:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SYxjHxlt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E20F10E4A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 11:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkVt4DDF3Ryocoxt79qqg8KRFzTpwwzPRUfpGp0sJFCNxKJyeGEoYoQhUOcT2AaN4qYtQ4zgKUqivKXnUdebel9pnn7RNJWmzOTog/Kzhwe4xxtWEwNntwLTZY4WThr9U4HjQJNC2jV3ioK9YAlQaJGzr6CMKhGAutpd3P26nkm7hXN7fG+XSU61kzl+Od0A2RecxzTRpS+HzgAY1tTSm8l832yzKm7JcvKJDwVJ84k7xvrvpQjwgjt/L4tLYEFP+RFEQ9F/wqMfSTsUSwdmQxjiK3ClgmQOmtwfkiSAh6lFm3gGYAzFfKoxV2zGRitADilMeE12vlKZDvFMrbpHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUbQZyaFbm9amNU/63N9NCUqyq/VL0ROQjqo1sTw1WU=;
 b=UBxNlmTyf+1xsO4nvVfs0cUqD/CTbz6mtprRtVZGBXhO3iiyxzNE+NpK/u9PBKLGkG0qATN3WakPDivOn8bt/je5vqzhFUxS3xeZCcvwctrldd3Rx3bAy6pA2nHO9ZmWPIX45NSNu8fo13YkdEqPEVtSV407Rl9TOsRpiWIiwdp+0YYIDSFWmkXO6ryP5oUZQkIa7tsTMMU8I6iGe9y2pciRiaD6hsXiPMwcmBpJw6Nk8vnSNt25xzej1yZ2BbWTJ2tnMKxdNuDR9YhsmjoMgyLEp7DbH7VqxVX5vSFOhY+znyG3vkZR3aO0I0Yp+w0QiXx/0q3jijbq/iIsQ0ywUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUbQZyaFbm9amNU/63N9NCUqyq/VL0ROQjqo1sTw1WU=;
 b=SYxjHxlt6SG3cH/fVhrvTfqpArBFWoOnhWKgoswPtDPM+xoCuSvYYh5DcD2fPOc4leaRuHmSFVT6l56LgkSS8aGqtLnHTx9OjeCaL0j3UXCII8zhD8eg4De35S/T8qXVXbEPBNoo7ZbuTuMVDAaK9xLTgf1iyYS8xvzRgBOZkWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 11:16:55 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 11:16:55 +0000
Content-Type: multipart/alternative;
 boundary="------------ugJb7jbAchsB1u6WJJF3NmRk"
Message-ID: <3f1b9712-841e-4a2f-984b-a27ccd1d7200@amd.com>
Date: Tue, 26 May 2026 19:16:48 +0800
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
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fb4642-dd17-4e08-47fa-08debb184b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|4143699003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: vgz7ksjqfU3Z82j3nWUZQ10sytnn4vHxNrJRA2pr5GzeT8c7XcSM/VwKinqPX13T6LeM2mz762VJeWNkdzYq0haAflv+9bAJ15Yr1M2pvjusqC9M/m/dNS/m7gI/4/aNQ8l52nKDVHX2mMc8HPV7QAA4TKOzhwDFCnMes8bf36mXcnqcg7+ycSvyFkh/AiXUPftcxxlTqxCkhuC1+7Gj2Ub/GQr+aLjce15UEUljJs9uL0VRsU/U4zrygI48EU7+eMlIWOYKT9g0Fr/muaYPy8iHGHMa5wvJGkJMenKmN21fCI5Z6z4klR4BOWQEhZ4I1NSD0vurAuFTqLNm5TQjZRqR8pbr68xZgd5e1yRrnn4zPmfGb5FPmo5iz/FjMX1qgO7OwStFwm5YRgFI7UPV/VcJchWQvXZc3wLddfXcbpz7vGNhy+EpxEEC0WjYbTGIOPxOiUovvEMxDKMjO3Tvsj2OCOkKsdKb9oITyTsp03lIumy8LaVQZaY30eWXOwoCbGVQ9pceuR2eWzWpCXepfqCmcp8IJ1/M/cE8w0R6J2KoMy1kF6CTe1j/eVVM8qI17XiizcJV6w50W8Dc95I5Y2TSobOywJC+G9zKH3DE0L5qD6nm3HNkDlBMdYDHxStyoJlBquiVDmRf/sHk1jTcjg8zFu+chVf2AWe/qZHs3JvDaLFMKnc+WBTWiHANHmiI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(4143699003)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWE4c2lMWityUGdCVE9jTVVCSVRndHYrNVZ6SzRMQnFEQmxSaXQyd3ZVc25j?=
 =?utf-8?B?RVRMYlZuWWx3bmc4MDhMVndYSnJTK05xNXZ5Z1BRZzJyQ1hvQm1aekVoVTg2?=
 =?utf-8?B?S056VHFPSWV5MWlKWS9acm12bDVPTnB1bnFOUTlrQ0ZrVm4wVXFLc2NvMkEw?=
 =?utf-8?B?MTk1Y3lkNTUwZGRibkUvdVdlNmViN3l3bEtaamJuekhsZkVtVG5SdEVwK2pO?=
 =?utf-8?B?SVpjRXI1SngyVjQ3WSszaExmek9KWnozWksyc0lBWGV1dmJHUmx1TTNTYXVH?=
 =?utf-8?B?Ty9FYzhRK2x5Y0hqMEptWHdZOUNqSThHS0VpTjVXeWpieTIzVmpqZmNwa3B3?=
 =?utf-8?B?Qlh5VWE1WnJPblkxVGZxb3VnRTkzUG81SG8yVW1iQkhqRlBjS2xPWVVhMFBU?=
 =?utf-8?B?R2UxckxrWDF0N1BtLzV0S0pSTi9OWEMxQmJTUTR3Qnc4RXBBbTliRHVORXJM?=
 =?utf-8?B?U0lucHZBTlFKdjMzSGZKaGI1NmVia2tPMVRTbkk1U2R4SjUvcDlJVjFxL21I?=
 =?utf-8?B?Z0N6YjhibzJMVnVUTENCcVI2bDdObEtteTVWSHlzNDVjVW9QTUdLWFIxU1Jz?=
 =?utf-8?B?Z2xOUzA2czlrbEJtRVc4dXhhYXQ1L0VyK3NxOXhjTE1JalppbUFRNC9kdkht?=
 =?utf-8?B?YUIzeVRlYlpHVUo0ZldIblZKR0Nnb3NxY3VOaG00ZkM3dkVEaFRJaGdGOGZr?=
 =?utf-8?B?WVpNYU1JYU9CNlhidi84MmlJNUZNdFY1TzhyS2xwRlhNUnVlWW1GZVhUT1dG?=
 =?utf-8?B?YzVlUDA0Y3ZSMTNsdWRac3VDK2toMnBIN29kRHhPWTRPaUwwTWtHUU56ZDhk?=
 =?utf-8?B?N0lkQm1iaHdtUkZCZFROSmMyU25DcU9uN0NwNEdtU2YrS2JTaXZmcm1WZlhZ?=
 =?utf-8?B?czMvNFRiM3RBWFJhRnBFOVRjd0FIekpQL3hQNlZnbTdNYzRqZFRwRitlbWJH?=
 =?utf-8?B?ejRqZmQxUzZtT1B4SEpNN2h4Nm1LWHRRUUd1TjYvZk00L0pCamVLVzlTQTh6?=
 =?utf-8?B?TWxrMk13RFgzb3Y5TkI5NWhCKzd4NkI3UzNEdXpRRGtlZGo0YngwZnoyMjZ5?=
 =?utf-8?B?ZWxyVWZGc1VJaVhESnBqL2N2bXUxcnhIZDVVQXBNWE1oaVEvY21XclNNTisy?=
 =?utf-8?B?dFRUQTVvQXpRZGdZeGRmM1pEM2s0MHgvWko5KzFwOU43NTVEQndRSDQyNjdx?=
 =?utf-8?B?YkMzZUM5d01MajVwZkE1am1sQXFxeDFjdzQvZmhxWENTclp4VWtJeEFheTdk?=
 =?utf-8?B?ZGNRTmREay8vYWtvZ1l0ODdiVzc0MTNKUm9BSlczUkxpSS9Sb24yb1BDMTli?=
 =?utf-8?B?YjRkL2EzN3ZFMjFqQWk4M2pNcTNMVDJadDRmV1lWZUREaHdtKy9TejE2b05q?=
 =?utf-8?B?dDNCaVpxbUFkaEI2NE53T1ZFNlZHcWVxUTFRNUE1dTN0c2hvOFYzR3QzdXZH?=
 =?utf-8?B?Zk9vL0lYUHRoY0x5YytYNEVGZXczYXNPMlllakloMU9LdzR2ZTl5b3VPOVMw?=
 =?utf-8?B?YVpQalFDek1GN3g2REYrK1M1b2pOYjlyWm52TGV5elRuV2tXWlpuZTZTb0k5?=
 =?utf-8?B?NS9oQ3dJOCt0SXZzKzZwMnFJcUtjYm9IVWVkVnBNdW9BTUNnTnBGZVNaQ1hM?=
 =?utf-8?B?L0F5ZGhpMWtoYkJKR2YzekkrT3l5TFd6azlCUGpKTDNJbGZrQnpLNGJkZEVt?=
 =?utf-8?B?bTlSdWMrL3dLY1haeDdnOHZEV2d3T2UvZlUrRjREaU5iOGErT0tvM3dMd1d0?=
 =?utf-8?B?Vmk2emU5RGgrZWh4RGtxUTZqei9wM3JSdkwzTmkvaWEyeTVPcnRGaWlvV2RR?=
 =?utf-8?B?VGh2MUtxbjRoRE9KUzZOcHdKTjdiejJsS29Kc014QWFsSFZ2L0hxdDVwSjda?=
 =?utf-8?B?dXJJWFZDdEpENXY2RGp1N1BJT0F6Tk5PS2JpOXZTR1Zsb0o2VDQ0R2R2Rnlo?=
 =?utf-8?B?VFdwaVF6cEZ5TnFwL09iSGY5a1RHaGZOVzFYaEFFY0VuRDJDOWVrWUM0Qmd5?=
 =?utf-8?B?QzNxeEs4akx4c1E2K2xjMzlVaEZZQmdGQVNKVzkxNW10ZDFadGg2TFkvODZL?=
 =?utf-8?B?OVhNa0RjU0VUZ1Fod3RqRk9CZzJwbnltRHR1Q0F1U1lKMy8vd0lPaStqVTBy?=
 =?utf-8?B?cW95SHcwbzRvY09jRXN6bHVXa1p5bUtnN1hnUjZxdWN5ZWNwRnBkZjV3OHF2?=
 =?utf-8?B?d2tmcmZQa1ZHT3hWbXBBSVNSZWhvaHhZRDY4ZVl1bDdXUDZoTEJxR1BYcEta?=
 =?utf-8?B?eXIraXJ4MTBqVTNBekVrZThDMUl1UTcxczJQci9kVkN3cmJtUWM4U0Z3RzFS?=
 =?utf-8?B?UnR4M0gyUWt3cnJFanJCaTRnYjl6eVYxMk5IbUF1eXd6MkJFUU1zdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fb4642-dd17-4e08-47fa-08debb184b30
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:16:54.9636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjqqHH8lnOdYRfVTd0ys0/CoulFaUmZ/6WbQfgzdK1dHtFzzmI78aGmRHCuBM8IdaiDQybjKvI4T+4CY1j4x1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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

--------------ugJb7jbAchsB1u6WJJF3NmRk
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
>
> Anyway just add an if and comment why it is necessary.
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

oops, I missed this comment.

amdgpu_bo_create_reserved() sets the struct amdgpu_bo_param all zero by
memset(&bp, 0, sizeof(bp)), and amdgpu_bo_create() kvzalloc a struct amdgpu_bo.
However I think we need to set the BO all zero, just like what mes_userq_create_ctx_space() does.

Thanks
Lingshan  

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
--------------ugJb7jbAchsB1u6WJJF3NmRk
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

I'm not sure if any code path is actually still using this since we found that for a lot of use cases you need to keep the FW buffers at the same location even after suspend/resume.

Anyway just add an if and comment why it is necessary.


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
When amdgpu_bo_create_kernel() does that the memset here can probably be dropped.</pre>
    </blockquote>
    <pre>oops, I missed this comment.

amdgpu_bo_create_reserved() sets the struct amdgpu_bo_param all zero by
memset(&amp;bp, 0, sizeof(bp)), and amdgpu_bo_create() kvzalloc a struct amdgpu_bo.
However I think we need to set the BO all zero, just like what mes_userq_create_ctx_space() does.

Thanks
Lingshan  </pre>
    <blockquote type="cite" cite="mid:7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com">
      <pre wrap="" class="moz-quote-pre">

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

--------------ugJb7jbAchsB1u6WJJF3NmRk--
