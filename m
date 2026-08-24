Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3C9C5DF9B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 13:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B60910E400;
	Mon, 24 Aug 2026 13:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M22CWJPS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD6510E400
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 13:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPMemdJrgulohM9DA0rA57pDYAbmpxq/x6CH0ZT/xaLjcIv4+81PdKOQsvUf+HOIXo5Mao5WpgHgjAq0ihUdO1ObK69g0S84+nDdHJj9GXSjtUxFRHluR77t8A9y4oF5Y9QU6IlHrKeEOogrYmJ67lsADiIp5TnB4aYtmlhRqriXPFM+CRAV+b6Ig9znbL0H6NXs2PwAD0ooMMe6qEZ0JqFmYVha9aFj385pCwj5hN4yKBvTFxJJARDHwW5BaCREU8mXeKtw1Zn+DCOnfRxixvI5IjNa5aKmuXu0p9L1iaXGfm5WMgHJGYn6Y6KqrknJt6+KpfdAx38vDkEy1S/U4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mypja0S9aooA4Q1RQAccwq9mY0MXQGAapej31Xyzb2M=;
 b=m/Vdil/0n2ZVPkgyVFW2BcReSbz/nmGnc366PnUdVo4+m7ii2YJ91LSxgQxkHpawqYzG8y+G5UlGO7s6EG41uaianAgP2IW/0jVvTkus1Fsx0A5bY94gEfUBvwQ475M5GftaYNfF4Xpkp6VZNEk67/Azffa9XWyZW+Z/plOPGqbow7zq3GWKZQH0QSJ0bszHKfbDZsDlSRC0nPsDsvtYn2ZLV4L7h6kcRcwI7SWCUnITeDDf7CYqdnYJLqt+3TRB4Yz5v0T5xquFi5JQ+jMgBv+kwrLTOhUX6HTD+YkKxZzwf/7KwlnvKDpJoJG0ADfwUTV6rcF/8DF5kd47ThK+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mypja0S9aooA4Q1RQAccwq9mY0MXQGAapej31Xyzb2M=;
 b=M22CWJPSr/9bMD0VlbZa4un/paEOvPPlspCsd8p0coyUAYVJ8tnT4jn5TI+qxJOZHnewFTdTIamkP8onWuT3wBiqNYBOM+BQ+w3qNPvFvpaY5jzW4/daDBf10Cg5kEoK3rJ7Wth+KJsAcsnuuS7vouxl1jgqwSi0c2bY0/+Vrtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 13:28:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 13:28:22 +0000
Message-ID: <2c38545e-abf1-4acd-9175-b6a86807e582@amd.com>
Date: Mon, 24 Aug 2026 15:28:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: lock and validate wptr BOs before
 reading their GPU offset on restore
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20260817070538.2490815-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260817070538.2490815-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e712e0-77ff-4e52-30ac-08df01e39137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|6133799003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9HDP32PQQspypfyzglWYuB4C5d05F1b5OBhlW9VJ01bOwUsjTL8DTeBtB5l3NJsLyA/6pXzFLAlw3SEXPofurM3tsPooqDUMSLvBJ2DCf/4u+fuhgN8GoVBQ6pHklGgIoV72DbEKQwTAo9blXvla+SexYxHxEtg6In1E5qcK2pSbp0C5ghkeE3bRwemsE6Ai0PbCCx9K4Gk5jfr+Q5SFR35Cu8n+q5dnImeGodrB5x87CbN5ttUVvMhnXCqSIBj8bYlmlgh1N4lsK55BE4fVkxIGzU+Dbl036kKqFe05CnKta7Z2qbW9a86YNkmi+qIMp65xLAOTLuyfsp5R100rQbQ+QKeKJaXYqbZ8Y8UKogGWmBI2lJZ2Jh86SYPw5r8udqbGhidsJ5xDelq6ZC/iuC+FEAg1ASnQkBa6pIeHC42BPW0HJi8RAKwqzAo5WdH8clKH07S2k5zeORSp5PDwqRyo5skBFuovgnhkOFLiVYLbm90WUEi5mleQkYu+T05Vp7VOPKseWvZ9XPfx9sAQrm4ZkWRbx/RGeFcrZRhsE/OnQL8lqCT63ANQyUn4vnyiIRyrBC9LQM5EDPzD1E/9lTrTBvNpUnOgUCV91DWcYuRTVAKo7J2F8UQpXASzqEe0TZGj9n7sd8BgHPh+PRLOXi1Bzdnu+6ZMRkMHVd7q+Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFFQ3lLdHNYTDZxSGxUZjZVWGpYTkNXNFNlQjJScHlDQUVFNlc5ems2b3pi?=
 =?utf-8?B?cVZMdSt4cTFEczJtZ3lnUHloK0plem82S005TWh4UjlOdURrT1FZN3BsNXR5?=
 =?utf-8?B?RkMxYk93bFdHckNtK0VPK1gwaFlBdUJRT2duVytpQ0M5eEJjR1J6N1RhREtn?=
 =?utf-8?B?amRoZk4vTFlRZjBOUUtHY3QxcHJBaWgvUWorUVZLSTJnc2lhSmJYRlRmenJD?=
 =?utf-8?B?NWFZNERmdWdDNUdrQmt3NG9ScmJLK2lSVHo2TTlvejcwbGoxbUt5MVRFcWta?=
 =?utf-8?B?QkFUdGJWcnJVWnJUcGdsd29kZC9jTGVjZ05DTW00aHhyczJ0Y2FIT1dkUXFh?=
 =?utf-8?B?NXlTM3haME9QT0Y0alBKRTJ2MzBUZ3NjcDBBZlMrVmFOa2o0Z2s4aGRYS0py?=
 =?utf-8?B?Sm5sTUNjbzhUc1RHWGZoZnVGdHZMNXo4Q3FMdWw2UENoRUFPUUlHWEIzSEox?=
 =?utf-8?B?VEo2UHVJRGV0N1UvbXhLM0dyUzRQSTM5REJrVUZNSVB6aDdJN0NmRXoySU4w?=
 =?utf-8?B?YnhhN0FlaWxXUkV6ZGxVWTJPWC9WN21KTm8yblNYZ2dFSmxGQ2RsTDBIUTJl?=
 =?utf-8?B?Qyt1Z3hXMlVudUF5bDFibHlQNnBzRlJNV3M0bHFTS2tuYlJYaytzbHVYZmFq?=
 =?utf-8?B?M3BOS00xWEd6UUlrRTdBdnEvMVFUSEJZWUVvejNyUXo1dnZkaW9BcUl4bnN1?=
 =?utf-8?B?UWl0QnE5NmdTZUZKOHlrVGEwNDllbzRkY01XRkRDSm1Uc2Y3RVp3bnJ2VzJn?=
 =?utf-8?B?U2Rpbk10OGJ2ZFhSRWhiUFBsTm4wVHpOUmRlQllNdno1bXk4R2RzMGthZU1G?=
 =?utf-8?B?dkFqekphMkhkeTQySEo4bXQ0czY4QmxoaVBVeG1MNm5rMEZiaEQvMk5DVkhw?=
 =?utf-8?B?RjF2ai93OTM3WTIycEduRTBJRzhmcytncVdrNmdRMGFFKy9JQlFMbmo0THJr?=
 =?utf-8?B?UmIrMTQvQTBEcDNFQUdRa2hsb3pJL0V4Q21yVHNLb2kvdkdwOUVtdDFqeU11?=
 =?utf-8?B?Y0V2VWg0Z2pRaTh1RUdrUjByLzI2UHkxcFdoL0xxZk9qVEZybXltNWdKR3ZP?=
 =?utf-8?B?YXdsenJDMWRUTWRvbnZrWXZETkplcnM4V3NDanJOb2JiM1dsU3RiUkdtdlo1?=
 =?utf-8?B?WG5scVZ0dHNhMWlMMCtiTjEzMkkvYU4wZVhFdEF2V1pJYndabHFKZnZuVHR3?=
 =?utf-8?B?MmNPU0NiSlpyS2V5K1pLWlNpWEhiYm9RZjVaSzZEYzBTL3hwckMzWDl1QjlJ?=
 =?utf-8?B?Zk1NSmsrZXplSzRSQkpHQXhlczE1d25VZ1g4MGFPa2ZYMU5nYk0yN2lzS3U2?=
 =?utf-8?B?N25LV3JJK3JIMUI2ZXE1OURLRlRqdmcxdGJ5YUQ4VXk4a0p3dGNFZlhXQmV5?=
 =?utf-8?B?WHNxM0NjNzVNV1JvM3lhQlJJZTRtYmtKVFZUK0ptTmJHbEJhZkFZRzhBTU1x?=
 =?utf-8?B?TTRGN1JHeVdJa0t2N0F6ZXZwSnp0U3RUM0pKUlp3d0pIRTVpQkRaWTNNV2VL?=
 =?utf-8?B?SzZOQjlYWWI5R29HWnZXMWFENFBYSWVGbmw0cW1xUFZMNnZyMlFTYjFpRzZm?=
 =?utf-8?B?cG9scWVDcmlxRzdMWGpZa0UrRFdvSmNGZlNVSFI1UUFGRnlvVTE3QS82bUc2?=
 =?utf-8?B?Rk9PQlllYXJ3U09NVGNIZjdpNC8vay9TRE9nS05xb2VvZ1l0bGg2Z0Y2OUNT?=
 =?utf-8?B?QzkwUHc3QTZDWXlkdmdCc1l1N25CeC9HeDR6WmpkUGZ5N2ZyazZoaU5rVEx3?=
 =?utf-8?B?WWNVTUpGYk1SV04wcjJUSVkrVGd6Z21jUDJwV203eWVCOGVQOVJzS05lWGhM?=
 =?utf-8?B?SEs4NnVtUFZ2REk4UUVJbmx3NW5hby9JajZEUllWRGxWSHp5Q2huQ3JVRFpZ?=
 =?utf-8?B?Y2pWUDQzc0VQUmFFbHZoVGcyVzRkVkRiQU14VDdobWR1L1RrcGZGb1RjYi9W?=
 =?utf-8?B?VDF2QkVFcmFNbHdWM3I5UnBHc3dFTnIxb215UDZpa3JYcGl6RldaMEdhTjRK?=
 =?utf-8?B?N2FSUHFKMmJWSEpaR3p4VU0zbEJIT3VDTCtnRTZvR0xJeVNiYzMrNmtDK0R1?=
 =?utf-8?B?Zzl6aGV0amYrSml3eUNIc2dld0ovbmtsMjh1OHpMS3BCWmlqakU4QVZwRzhL?=
 =?utf-8?B?YklkRmpUamtIYUlRcHBsYWc0VUNEb3B1ZGQvVFo2UzRpdGprWERMS0VVV1FI?=
 =?utf-8?B?cjBNMVlraTh3eUl3RjNaOHBhY3NRVElRc1RnM0t5TlZyaUg1UldGZ1U3dnp5?=
 =?utf-8?B?T3kyNWlPWmM5RDlIY0ExbmV2SmR6RlpvYkFyQ2llRlFHWEkvd0pzNGFHbTVp?=
 =?utf-8?Q?c//RzyZN57Ev/Uk+FS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e712e0-77ff-4e52-30ac-08df01e39137
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:28:22.0042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN/XmgXouvGit9X2WIecz1R0mq9a51AM7A1Oim1to7EDRranGQAUxleHcvgWnPvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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



On 8/17/26 09:05, Jesse Zhang wrote:
> On resume, amdgpu_userq_vm_validate_and_restore_queue() updates each queue's
> wptr GPU address via amdgpu_bo_gpu_offset().
> 
> WPTR BOs are VM-mapped, but each BO has its own reservation object and is not
> implicitly covered by the VM validation path here. This can leave offset reads
> without proper BO locking/placement state and trigger WARN_ONs.
>   ------------[ cut here ]------------
>   WARNING: amdgpu_object.c:1486 at amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu], CPU#3: kworker/3:1/116
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu]
>   Call Trace:
>    <TASK>
>    amdgpu_userq_vm_validate_and_restore_queue+0x629/0x960 [amdgpu]
>    amdgpu_userq_restore_worker+0xa6/0x180 [amdgpu]
>    process_scheduled_works+0xa6/0x460
>    worker_thread+0x13c/0x290
>    kthread+0xfb/0x140
>    ret_from_fork+0x1b6/0x2b0
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: amdgpu_object.c:1485 at amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu], CPU#2: kworker/2:1/127
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu]
> 
> Add each queue's WPTR BO to the drm_exec ww context and validate it to its
> allowed placement before the later offset update.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 17cc48d87c4d..ab8fc14a235b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1054,6 +1054,30 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto unlock_all;
> +
> +		/*
> +		 * WPTR BOs are VM-mapped, but each BO has its own reservation
> +		 * object. Lock them into this drm_exec ww context so the later
> +		 * amdgpu_bo_gpu_offset() reads are done with the BO resv locked.
> +		 */
> +		xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
> +			struct ttm_operation_ctx wptr_ctx = { false, false };
> +
> +			bo = queue->wptr_obj.obj;
> +			if (!bo)
> +				continue;
> +
> +			ret = drm_exec_prepare_obj(&exec, &bo->tbo.base,
> +						   TTM_NUM_MOVE_FENCES + 1);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unlock_all;
> +
> +			amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &wptr_ctx);
> +			if (unlikely(ret))
> +				goto unlock_all;
> +		}

Mhm, something is very wrong here and that is clearly not the right solution.

At this point all BOs which are part of the VM should already be locked and validated and that include the WPTR BOs.

So you are just working around a bug somewhere else.

Regards,
Christian.

>  	}
>  
>  	if (invalidated) {

