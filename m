Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACBFFD5F99
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2925A10E59C;
	Wed,  8 Apr 2026 08:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Re0JNyAC";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0BD10E59C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SK5ITT/rQNYaxNNLSelLWalRWolTUECmJeeGgusBkdADXxzj9oHY4KwbOrFXMN2rlN/wp/LQ0+6r+gN3stuasOjjty6g0r8RBINrP2I24HJM4T4QuSlojwG/3Ffn3ItxDDi+T6ADOKJWFRiWmYkkeacwevOT1YkgQG6bTn73MDk9zR1O2r74YJCNG+H7Ib9W6DvheN+763+RaigDmooU7gF/SYexqN/mom58oT1A672EQzEciaIZUXiajzIBfXC7fiZzDAU4h48kKHn3fg5CeBBJR97LOSKL4hjgfuNXgMPNYmRkdc694yzSReaI6eWIhdHUlGhXwQYQTcPnL56RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+iGQ0dfTfs9IJ7aiS7Oy1s2tMyEAm6GPiOofQgYELE=;
 b=jhmjL2X8MVI2vsUniBzYFBuu6x512OU9G6Pp/lZtqkGrk8nCz1O4heyyROg2Eml8cgZdUGtc8Xc87z8oaKt5qSf9PDZIWwyL2xd8l0Mujxa8ywFlhoLb3kHUEcbHE8OYqILMCBLy/GWGvvi/ZHKaySJ041a1LWAjijm6hR2FpfG1uB+xFJTQ5QykO++0Av8ANwPMjrfY1hC1Re0n2PO4jaghfP7D5tIiT6MFftQ4Mqj+Ej7ggLPfSlbnG/p73FuTtowMjSY1yzyvgVMouoswWNos36xo3hhCA2QNmMFnQ2XzFzfxfODD9zF0rP/W7Ep8PUIaaopbV6dHbiZDeAkmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+iGQ0dfTfs9IJ7aiS7Oy1s2tMyEAm6GPiOofQgYELE=;
 b=Re0JNyACBtnw7Hjudda59qUkeenlPAmOj663UUTjs7J3bYbugMoStgi7pnbjo6Co/h3i2AFq2oyeC6pRcXWxI0iQRWtc1kbYwcAfv7sJ30CmRcbLqFy88KPVXrasURMEB+agJXDSpC9WfdAjgLOnxEUfZCIVswTMFzpMNo9bHXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:53:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:53:26 +0000
Message-ID: <7ed5506c-a84a-4dd8-9880-11be8432ad32@amd.com>
Date: Wed, 8 Apr 2026 10:53:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/2] drm/amdgpu/userq: avoid uneccessary locking in
 amdgpu_userq_create
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408053603.2894742-1-sunil.khatri@amd.com>
 <6e31b77d-a465-46d8-a299-1dd10c88334c@amd.com>
 <560b9f8d-aa19-4122-9b3d-2319e7ece628@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <560b9f8d-aa19-4122-9b3d-2319e7ece628@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7081cdd9-57d5-447d-eb6d-08de954c4bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: e/R5SM4yL3rJUntj38JlUEL8ryEt5bBX1AvFKJkGn7RTtEvdWEXQkzVYFaOmxMXvlX2GT/nZ3N469JIYtDN3iW5BKBfear4Ryx5duXDK87lBUZaIm+KdP532OTuvC4f8a6itL3eK8wXfmn9iid8NOHwXCXwT1z0OdV1CLtSLaHmn8PY3b5QkPTXI5QKSCZRZ6mMAeD17FurDRzuc3UHda/HUqnWlv/wgwGKVEu4Hqks0JfaaHqd7LZ248Wx9/REudVhqHD3dZjeLQZEc6h693lEN7XGrg5vE0ZahauXx3hR5O6mr2RA5w6w/aLhFaf6AqEJY8IUjN9G+8A0xKz0OBwNzVguH0dNMeOLuZWLbklGJ943hxT/tJg7zDAlUyfHckfnj0Ivu575zxfZNwy+luQZkgp1XlvX+rYUxAEevBc+H1Y4uaGaxNHuPAY/O+edcWYpHjpt1F/fQzDP+7K+I9z6gOfbKWdzn811mzuWIOTC1wMJknAn5CQMA6aqOMFQTSwmKkZjxmdNxAjkVVJXpDAc0lh8F8GgkdAP4vCUxRiN0p4BSIK8seuGH8KNn1MwdOwTWSAclc4+GQoPUySrCD7QBjhUSM/ii2gRcL2gyHaupIjdd1uCxp2eIu4uxdQk2HJ9eNk/QRRxP3vTaZnULnFI+Q2g9EP2zn/FIX+BRZN3iZaKlAzRQDx0BOeQH7ltHHiJ6j7g7JDTu1UyK0HWO6TuO6hjcaiG1dEHizEbE2G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9PU1dQRlN5VzdYRWQ0WUpOejYrMHZJZ1E4L1V2TWpIblRXZnFnc0VMVENv?=
 =?utf-8?B?R05JNzNidk5pVncydm9VV1ZNb09yTE10UVZLRVRWVzcwbWxtaTFKYXczS2ti?=
 =?utf-8?B?Sm1LZXd0VGFheklUOGp2VEx4UmI0NEgveFB3b3FKTVIrdVdDNVdOVkJDMGtv?=
 =?utf-8?B?ZGRycEw1VmNzZE9peU92NmF1d1M2U0JXOE1PZWpwbTVjT25HSFkvMGJjTFRa?=
 =?utf-8?B?TWdpSzBUWGNtaFhUeEFoeHhoTzZmcHNiQVdLUlNZdmhTZXE5Qk5CQXZaU1ZC?=
 =?utf-8?B?aGhqdFNZUnkwZHBkR3ZhK1BRd0dGdHdUd3FOWXo0cEhvampkNkt5RElWcnpy?=
 =?utf-8?B?TEtmVFNXNnh3NmVRTElJUnJzSzBNOUlseWdNaVNuaXE5K3JJYUcrL09MRyt2?=
 =?utf-8?B?aDJMSmpPekNSMEw2eTl0R3dPakdKWHhwT3d5VjB1bEZIeUQ5bUgrc3h3eXds?=
 =?utf-8?B?Y3VPUXM4OGZQMFJjZFE5cDB0cysvSmF3OFBHVVRtUUJyWUQ5RGN2b1RIRmE0?=
 =?utf-8?B?WXdGYXpxT2M1TXJsU0JrWVFkWTBsM3dnVVNqY2kwaTZ2enh1S2lUMWlibXVJ?=
 =?utf-8?B?TUc3cjJZU29JMzBLWFlXSXBIdm02RVJBVHUvc0oydzZNZDRiSjJqeE9RdXdW?=
 =?utf-8?B?blF5Z1h5TVdBRHBmd09CTG1RZ3pacmNnQVJJZUU1ZTRNRWJNUlJwc3BudXdr?=
 =?utf-8?B?VUtiYmk4aEpxdGNYUDBidERUWG50K0ViTVQzM2dvWGQ0MVMwRGc3bENuZnB5?=
 =?utf-8?B?ZFlxd2VxUTRKcWVpMU11eEpOUDdjL1kvdVVtMXBjTjdXdmVEaEdIWHIxMFJ5?=
 =?utf-8?B?NklCVTZVaFh0QkdKMlAyakl4YjZQRmpjRHVZdHRHcTM5a2ZXZzgzaXdyd1p5?=
 =?utf-8?B?YUwvZVR2SysxT0U1VlRESGZDVjYwaEpuVUJqc3Z1VFhVWDdlSG9SWkZBQTRi?=
 =?utf-8?B?TDBjLzJsNFpVZVFkam1pTDdXV25YMEdiWW1zT296VnRzUkUwdEZPMTlpbnJ6?=
 =?utf-8?B?WmZGOVBOeXVBaVh6TWwwcy9pWU9DVVZ0L2VaRlZZY3NxRXhEOEVwa0VYNUh0?=
 =?utf-8?B?TVcvRVpqZk1uSFByK3JFVEdNLzdUSlVOQ1ZNbnhURE14NnRtTmV4T2IzNlVQ?=
 =?utf-8?B?dldDUTFyWlBsVm8wZHFYNUJYSnBxZ1NXczdPbTNjYisrT1RHQjVFcGYva0kx?=
 =?utf-8?B?V3hLd25XeEFwZnRUSjRIdVplUkN2Ym1zNWFzWkFhYWZvMVpDM1MrSVlSNGZt?=
 =?utf-8?B?eDNkeW9JSTNSaVR1VVpibURsZFowSzZjdlRzWUlVTnVyUlpWSDlGYjlCMXBi?=
 =?utf-8?B?UElFeGNlMkx0Rk00akt2OWhCR2ZnVW9SOFpmVnkvTVBSM1M3UmFGbjRVUVlQ?=
 =?utf-8?B?N3dFdlp1WmxJclIvZzd4NDhYeG4xVHVvbW5NTkRBeDI2emlTSXI0RnMvdXlp?=
 =?utf-8?B?VmNxSCswVDN0QWNBZjluOEtQSmkxTkFMb3FLdlFaSHhtUmdrbnhsZnRlamRk?=
 =?utf-8?B?VkF6ck1saU9zTmdYRXcvTnROTHBoZGpHWDNudDROTDlUY1hLZDJXcUt1ZTVZ?=
 =?utf-8?B?alNJMFVZQWtaVU0ra2p2b0VZQ0Z6ZkhxTXV0bEo1WWpYNFRiY3BmMnVwVHFl?=
 =?utf-8?B?SXpKaFNDOVN4elhEWjBhejRvYkhUN1lublVocEg1OU9wQnBzR2toclBRcFVq?=
 =?utf-8?B?dWQweW8zK29tWW5adnJvYWRIUnR4LzZiVktKM1JYMkJlV2RmQ0JvVGtNRmRV?=
 =?utf-8?B?Y0dTV3M0a29Ya1NiczhkQU41NzVWWmpVU1pWYVVDY3lFOVJOek1iejBxQWhP?=
 =?utf-8?B?QU55UWc3RmFzd2ZJbDE5WEdKOHR1bkNwKytIVW9yN0s4YVJkSFRHMHNrZ0VI?=
 =?utf-8?B?RzQ4MmE2Uzd5dmFHR0VYQWplaFdXZUlUbThnM2YzdWI1WmFSMmlaK252ZXY1?=
 =?utf-8?B?OUwxeTZBZUUzZ2tPSnh4dGY2SjVtMTJqcG5XSE1Oc2ozSDB4RnJsRjhlck4w?=
 =?utf-8?B?alBOcUovWFlJamIreDlEc0VWeXIvNWlkaDd0dE8xMHd5NitNM1VrNXhNSDk5?=
 =?utf-8?B?aHd4VUhiNnREaGM2a1NEVVJCOWFZZExIOU0xYWIrc2JWck1iMmNFcEs0dFFT?=
 =?utf-8?B?MXJka2l3SVM2djkvRFdFNTNUSkFJUno0WHUvRTRYWXhDb2RmbExQanZLTXhC?=
 =?utf-8?B?czV5dEh3TFl5Z0VGYnpiK2I5dWM2R3NhSU9PdXpPWVRBR3hmbmFyb0Q0Z3lV?=
 =?utf-8?B?ZTBuODZQR1FFZHVmLzFWVjhHUXBOUEZycUN3L0UyQjFVZGg3M2diUUxnMmF2?=
 =?utf-8?Q?KvLGsrUORIKrLbIVUJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7081cdd9-57d5-447d-eb6d-08de954c4bfa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:53:25.9254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gme8tS0d6DIWDmgXW7014TYnZs3g6/EJXBCiHdTuGb0vrHg+8CpyEXQMvbt+UXUB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

On 4/8/26 10:36, Khatri, Sunil wrote:
> 
> On 08-04-2026 01:53 pm, Christian König wrote:
>> On 4/8/26 07:36, Sunil Khatri wrote:
>>> Reorganise code to avoid holding mutex userq_mutex while
>>> also trying to grab exec lock ww_mutex where its not needed
>>> for function amdgpu_userq_input_va_validate
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++------------
>>>  1 file changed, 15 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 3a6e7a569c78..3f502c18879a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -737,28 +737,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  		return r;
>>>  	}
>>>  
>>> -	/*
>>> -	 * There could be a situation that we are creating a new queue while
>>> -	 * the other queues under this UQ_mgr are suspended. So if there is any
>>> -	 * resume work pending, wait for it to get done.
>>> -	 *
>>> -	 * This will also make sure we have a valid eviction fence ready to be used.
>>> -	 */
>>> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>> -
>>>  	uq_funcs = adev->userq_funcs[args->in.ip_type];
>>>  	if (!uq_funcs) {
>>>  		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
>>>  			     args->in.ip_type);
>>> -		r = -EINVAL;
>>> -		goto unlock;
>>> +		return -EINVAL;
>>>  	}
>>>  
>>>  	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>>>  	if (!queue) {
>>>  		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
>>> -		r = -ENOMEM;
>>> -		goto unlock;
>>> +		return -ENOMEM;
>>>  	}
>>>  
>>>  	INIT_LIST_HEAD(&queue->userq_va_list);
>>> @@ -781,12 +770,21 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  		goto free_queue;
>>>  	}
>>>  
>>> +	/*
>>> +	 * There could be a situation that we are creating a new queue while
>>> +	 * the other queues under this UQ_mgr are suspended. So if there is any
>>> +	 * resume work pending, wait for it to get done.
>>> +	 *
>>> +	 * This will also make sure we have a valid eviction fence ready to be used.
>>> +	 */
>>> +	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>> Even that position is not correct. After grabbing the userq_mutex we can't allocate memory any more.
>>
>>> +
>>>  	/* Convert relative doorbell offset into absolute doorbell index */
>>>  	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>>>  	if (index == (uint64_t)-EINVAL) {
>>>  		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>>>  		r = -EINVAL;
>>> -		goto free_queue;
>>> +		goto unlock;
>>>  	}
>>>  
>>>  	queue->doorbell_index = index;
>>> @@ -794,7 +792,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>> So doing that here is also forbidden.
> If i am not wrong we could move this whole code including amdgpu_userq_fence_driver_alloc and above out of mutex. Does that sounds correct ?

At least of hand, yes. We only need to hold the mutex when finally talking to the HW to enable the new queue.

Regards,
Christian.

 Regards Sunil khatri
>> Regards,
>> Christian.
>>
>>>  	if (r) {
>>>  		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
>>> -		goto free_queue;
>>> +		goto unlock;
>>>  	}
>>>  
>>>  	r = uq_funcs->mqd_create(queue, &args->in);
>>> @@ -858,11 +856,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  	up_read(&adev->reset_domain->sem);
>>>  clean_fence_driver:
>>>  	amdgpu_userq_fence_driver_free(queue);
>>> -free_queue:
>>> -	kfree(queue);
>>>  unlock:
>>>  	mutex_unlock(&uq_mgr->userq_mutex);
>>> -
>>> +free_queue:
>>> +	kfree(queue);
>>>  	return r;
>>>  }
>>>  

