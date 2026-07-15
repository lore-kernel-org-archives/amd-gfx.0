Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10549C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 17:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A2510E1FE;
	Wed, 15 Jul 2026 17:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JDdorIi9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E66E10E1FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 17:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itP/REuuLKKtNXLnR4TjsPLntjyDhqp/72ugkOx58dxmmLZbl+Qk+IMuF1LO4vtQxxoubL0l5IH9o9V+a5kVZM/w41saE3fRhhS978KPp+n4U7U2Wz2O7ZN4Jsh6i+XnArtMewwQj7MEiclV6nLFvMvfqCQAuT9oZdWPb5PMn+qxiClVkoNUTiH5f9+PSt57MaDDFukQHwaAwohsWkEKJXGegIEczPp2Zkovv1zjiJR6SXFkqdTY7U3woSwavLgsDXdUO136iSvRChHqtPhhfq5y34+vS7S9FPO9BqoOHJ+7uo01SgGkyrkc5zjivleKx3MHSUJGklof+kDRTlCa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee4A7irorelpCDF9hwVn41GUEp5DciQ+O1E9dcwD+j8=;
 b=pSrnZYr4VAiiKU2VES/yQGIYItRPhhThl1o6JCbXP5JYpeLiP4KdNzg5IiqWJKXqQgNUVLFtOO/NRi9BCuoMgMxQQS5e4lIpO1li8WQ9DcewzymDtCxabyDqs8SAmCmPdhq1H5saH+6nblcfaMDzXe//0XwWlD7a+9j7YACQFXDQNV2fUYz1EXXq+iwfxoCHuCMXJurodpEF1BgHauQdhr4Epy8RVJ+p8R5b4iTF5zz1gXZW9teLYy9+M2FHFz7x2ATI87kSOr/4s3HhtaO7rZfu//oBQ9Bvt15UXXKOWXccmfEemcf6MbQxxnRSxP95LBAMOGqNUnpKPU6G/jxmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee4A7irorelpCDF9hwVn41GUEp5DciQ+O1E9dcwD+j8=;
 b=JDdorIi9Cn7Q33KSAiPSLdahNTtlZUii4/tUQymJO8LrmypKG7HleOT+8vc28cJrhE3BI5LpBekFtza+nzpo+edLEHH66YFhd3fWoFtd1YJafJl8Prc8fqV0NC6hLkBN37aXzsD6p50gVJHymldpZuXQ9TCHWOz4EBzdEGMQ0qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 17:33:53 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 17:33:53 +0000
Content-Type: multipart/alternative;
 boundary="------------fWSHWqRvOLdKM2kBeNoX8fg2"
Message-ID: <24c1897f-3b0f-4160-b164-9fbced742120@amd.com>
Date: Wed, 15 Jul 2026 23:03:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: dont pin wptr bo instead use eviction fence
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260715142444.53373-1-sunil.khatri@amd.com>
 <b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com>
 <a965a413-19ea-46c0-a092-faf6f6b1de2c@amd.com>
Content-Language: en-US
In-Reply-To: <a965a413-19ea-46c0-a092-faf6f6b1de2c@amd.com>
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7782:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cffda64-5228-4897-5d3c-08dee2973d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|5023799004|8096899003|4143699003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: vzjlFhEVlETW/0okh3V0EUYhONZcJFKm+xgm4dCd+Yf3iWVZnU6ZCPOkkTQpZIuv0xn8kPHY6aO/oejtiXa08zBqhrJnILA59rQl2ITauO4GZaB9EhIHn3l/sACiPnBicqnYERjRnPHiALO2WqCAIejIodkFbE0DVzjT4Qx2dnglvibXQGV/qn4hVmw5SB6cBSawRK5tI57Mz/ppPbXCBk+fRI2SNVNBIWvSA5FfS8JT5ubCyl9KD8JczR/GeDfZ3kEzcnwTLU/NBhjXIaR2DeH1l02FKTliauloVnHz9NBkq05fJNrrt83X9KfTVG3Z64RQI/VMesqP9fDPfdySObvE/LWJQeRBr6z31BegHkzvTn3UArCqwjbSAc+lui4Xr5XUzT/8TEj6vHEXuw3Y+PlIgw1nB70Q5vvBkfPPGXE704G+QYR9NdCoeD6Eq6j1jDFcI+YRNwmALxRxHCTvd45651y+896VpO6eI1/5MpRe7PKFTG2OzfXxX1WxRxufmD49rGTSo+hcSMp7E50opeTdHiIRnbJbT26b2sX7MuG2bshgkRAATtyEtj6wD+TOOLWWtfTmN1z4VS31V2+kDs5dWLn6qnZSHLA/7rSELhfYy+gfT86gblWDIwO750VPqN3LVhfKzWJwvvc8XiCyff2tyJrtlRBC7eqQ7/tMWVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(5023799004)(8096899003)(4143699003)(6133799003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGluZVU5WmYyWjQxN2U1SmVVKy9oWFYybjNqS3gycVovbzV4b3NqbzBrYnFE?=
 =?utf-8?B?ZHlyWVVVVGM3ZXYwbnF5Z1lMMlRsbTcrK1pRQ01SMi9IN1NnT2Npdk5DRTJQ?=
 =?utf-8?B?ZC9KRjQ3ZXFTYStIdUFCNjFhQjFCcDBsSktIUEQrNSswbXRSdXgwM2Z3Nk92?=
 =?utf-8?B?aFdOdnJ1eXBrN0QyUko4ZDI2N2xlajlGQ2RFdXRKbzZhTWlDYlZraU1iaGl1?=
 =?utf-8?B?VXpWRzRKQXNkZ0hWQlE0VGNQbnNvanVFK3Noa3MvM3pmOUViQWU0WHRLZGFV?=
 =?utf-8?B?NUc2Vm1lMXJCM3dhZncxOHpXczhkM2VEM1FBS3ROa1dFV044NG5xMkdyMy80?=
 =?utf-8?B?bE9qM2JrZjA3ZTZSWDYrS2FxNXZkejBzNWJ2NlZXTitjZm5BaUFMdXlqVmlQ?=
 =?utf-8?B?ZDZyVjRrN1VtT0dxblAzQXRVNHJ4enBrVkVSRHBHUERVN0hZeDJUcy8wV0Jv?=
 =?utf-8?B?Y0xla2lVWVYrM2hWYVU1RlhaSGdyMmVlazJuVUk1MTVBTlVHeGZFRlBiMGl2?=
 =?utf-8?B?SVk5NlBKbG5FaVIweXc2MXozZG5ONFpqeS9nU3h0YXlYTm5RazU2ZExWVzNh?=
 =?utf-8?B?bWthQkxlSVY4aVJrckZhVGhVWHhQVzVHbU9hbVdyM29XZGVxbVNIVGIza21w?=
 =?utf-8?B?NXJKUGptTk9venJCQ3E3OFJaendjZm03OW91UW9rckNYcW9oVXBtdHhJU0dq?=
 =?utf-8?B?bzFDVkgyd2lpUjRINEg1dzliUE1VS1E4V0RncTBVTENYSVNjWk1UVUN2MDVn?=
 =?utf-8?B?ZmpYSlRRaFR5OHNCVTIvQk8ySmh0U0o4ejhQbTk0YVZheTliaXFnY21iUVVO?=
 =?utf-8?B?QU9xalJFK3Y3Y2R3QW5VZU00WUMxMmZIeUdUYmROVkQ2ak1XanFtamg1VElt?=
 =?utf-8?B?ZVRGS1N4akc1cjkxb0Z0VzhrckJWU3dockRmcmN0aVE3R21HbldQd2M1dmlH?=
 =?utf-8?B?cGlwaDI5UUNOZEZpTEdCUnNSWlpNWHpXMTk2SytHc2UrTDNIelFSN1pmTnV2?=
 =?utf-8?B?aDJyOUQ2bG56TTFLVVhsVXFGdEtMb0lqdHJGVDlwenNRSnBUU3FXRzM1QU44?=
 =?utf-8?B?MWp2UTJKc3JxOTdTRTBvdEN0MHpJckZtTENwekVUQzZLdEVhSGRjSkN6czZU?=
 =?utf-8?B?ejRjUmF4dU5DNzN6NlI2QXlKRXRTdkY2bTNBUVlQYnREU1FodXRKMEF5QnJq?=
 =?utf-8?B?eHdYRzZsNVRBQVh1a2tyZ1ZlSG15M3FkZCsxNEQvWDM5Ymp3UFlzejlwc3pH?=
 =?utf-8?B?UGJmRUVKT2xzdlFFeE5Mc1JCN3VlWk9URHQ0bkNzb3krdHNyR2tEZWM5SDJY?=
 =?utf-8?B?STNLaGlTNFA2RmZ1RTBhOCtoMWUrQ09jNnVlVlkyanRFVFQyR0UzQ0lzdnh6?=
 =?utf-8?B?TU5TdXM3aUpyZDErSktLQ05ncThHMmU0T1ppSHVkOFpDQUs4M285MXJseVVo?=
 =?utf-8?B?bmk3dFFEcjloYlozMExKWG1MVXQ5Q0t2SXlFNDk3L3UxMW9PNWVLTWpqVmxv?=
 =?utf-8?B?aG1UWXVFd2pNVlFDNFRQUmpVOUFEWk1kVitMRnRnaERPcTUzRW4zUWNCTTh2?=
 =?utf-8?B?MmlzMVNNUGxyRFVkLzNnRkM1ZkNNSTNNK2psanMwa0ZQNjdaaEtPeHNMOTM3?=
 =?utf-8?B?SVJGOGtEYXM0NFllYjlMK0JpaGpZalpheHd4SEw4bndjMUJabHlmZCtZWjBs?=
 =?utf-8?B?UThZZk44cURQekVXZEE3OTV6MDNuMDRtR0hyTlV5MkkrUU5kS2E1VUtpRTZs?=
 =?utf-8?B?UHdHVTZaNGFyR3kwZEpYQTl2ZkxId0pxMnFibGtMRHVVL2FEby9GNnFIb2JQ?=
 =?utf-8?B?ODRST1lyRnFkUU1FMEU1VTJIcjVNYVpLVHpDNVgvZ1Y0SGhwZGx5Mjl2R0Vy?=
 =?utf-8?B?Ly9saXhLbWdBMWxmbFJ4WTlKeG1zRm8ya0tUeFU4YUVZZXhTQmNweEY2T0pE?=
 =?utf-8?B?MHF4RlN5a0xlTElCL21GRjJneTZaLzFXdnBOdWlPMVZwMFQyL01mUk4xNHND?=
 =?utf-8?B?VURoTU16L3RZRXg2dWlncWY2eHArU0JhZ2c4cHAxemJMMjlJYWJVcjFEdVpx?=
 =?utf-8?B?RWwxT3grTmZFR2V0UzYvZk5aWUlhek1pSTd6aVRyWURzeStZRTZQNXBwTFVR?=
 =?utf-8?B?N2lLdFU0VklLK1haYmQ4cmcxbzRrVmxIZ3NEYk5ORHFobkVaUHlVb1RyVCtU?=
 =?utf-8?B?b2ZQc1oxdW5hN1g1bndoeHlvS1V6QnBvK1orM0hPVHRML0R6eVJ5Q3dwd0Qw?=
 =?utf-8?B?dERsbG1vQzFYVmQ2aGtzSk5NV1NCTTI2UldWUFBOeUFuQVdmVk1VSVhwRVBO?=
 =?utf-8?B?ZC9MMS9qd2NBV1FMb3RMTnhSTWZDVEVCRlhrVnhlY3NZSjJJajdkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cffda64-5228-4897-5d3c-08dee2973d38
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 17:33:53.2044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePZmuwCAh4vL9G3GBmHbWTPpfeS6nZboQM4paZYBtfBo1xwdmRHFWe9uRwZqYIxiyWcIS6o/dTspGdG3gyBGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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

--------------fWSHWqRvOLdKM2kBeNoX8fg2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 15-07-2026 09:31 pm, Khatri, Sunil wrote:
>
>
> On 15-07-2026 08:30 pm, Christian König wrote:
>> On 7/15/26 16:24, Sunil Khatri wrote:
>>> Instead of pinning the wptr bo attach the eviction fence to
>>> the bo to make sure it remains valid all the time.
>>>
>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 34 ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 ++++-------
>>>   2 files changed, 39 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 911fb325c70c..e1eb689710c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -936,6 +936,29 @@ static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
>>>   	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>   }
>>>   
>>> +static int amdgpu_userq_validate_wptr_bo(struct drm_exec *exec,
>>> +					 struct amdgpu_usermode_queue *queue)
>>> +{
>>> +	struct amdgpu_bo *bo = queue->wptr_obj.obj;
>>> +	int ret;
>>> +
>>> +	if (!bo)
>>> +		return -EINVAL;
>>> +
>>> +	ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
>>> +				   TTM_NUM_MOVE_FENCES + 1);
>>> +	if (unlikely(ret))
>>> +		return ret;
>> The WPTR BO should already be locked and prepared with fence slots by the caller, doing that here again can cause problems.
>>
>>> +
>>> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(bo);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   /* Handle all BOs on the invalidated list, validate them and update the PTs */
>>>   static int
>>>   amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>>> @@ -988,6 +1011,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>>>   	struct amdgpu_vm *vm = &fpriv->vm;
>>>   	unsigned long key, tmp_key;
>>>   	struct amdgpu_bo_va *bo_va;
>>> +	struct amdgpu_usermode_queue *queue;
>>>   	struct amdgpu_bo *bo;
>>>   	struct drm_exec exec;
>>>   	struct xarray xa;
>>> @@ -1094,6 +1118,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>>>   	if (ret)
>>>   		goto unlock_all;
>>>   
>>> +	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
>>> +		ret = amdgpu_userq_validate_wptr_bo(&exec, queue);
>>> +		if (unlikely(ret)) {
>>> +			drm_file_err(uq_mgr->file,
>>> +				     "failed to validate wptr bo on resume, qid=%lu ret=%d\n",
>>> +				     tmp_key, ret);
>>> +			goto unlock_all;
>>> +		}
>>> +	}
>>> +
>>>   	/*
>>>   	 * We need to wait for all VM updates to finish before restarting the
>>>   	 * queues. Using the idle list like that is now ok since everything is
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 19c3cb61929c..ab8baaa83e60 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -71,27 +71,23 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>>>   		ret = -EINVAL;
>>>   		goto fail_map;
>>>   	}
>>> -
>>> -	/* TODO use eviction fence instead of pinning. */
>>> -	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>>> +	/* Keep WPTR BO under eviction-fence control instead of pinning. */
>>> +	ret = amdgpu_evf_mgr_attach_fence(&uq_mgr_to_fpriv(uq_mgr)->evf_mgr, wptr_obj->obj);
>> The eviction fence should already be attached to the WPTR BO when it is part of the VM.
> Sorry i dint understand. From amdgpu_userq_create, sequence is like 
> this uq_funcs->mqd_create(queue, &args->in) -> 
> mes_userq_create_wptr_mapping (This is where eviction fence is attached)
>
> after mqd_create we are checking if the ev fence is signalled or not 
> and based on that we are again going ahead to attach new ev fence if 
> signaled to all bos.
>
>
>> The problem is more that the function is called at the completely wrong time. See amdgpu_userq_create():
> You mean to say mqd create is called at wrong place ?
>> And BTW why do we have the abstraction of uq_funcs? That doesn't seem to make sense.
>
> I also need to check that.
>
Yes, we are having the abstraction layer for uq_functions but not really 
needed. I feel the reason here is to not contaminate userqueues code 
with mes layer code that's all. Since this is written by @alex, i would 
like him to comment on this.

Regards
Sunil Khatri
>
> Regards
> Sunil Khatri
>
>> Regards,
>> Christian.
>>
>>>   	if (ret) {
>>> -		DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
>>> +		DRM_ERROR("Failed to attach eviction fence to wptr bo. ret %d\n", ret);
>>>   		goto fail_map;
>>>   	}
>>>   
>>>   	ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
>>>   	if (ret) {
>>> -		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>>> -		goto fail_alloc_gart;
>>> +		DRM_ERROR("Failed to bind wptr bo to GART. ret %d\n", ret);
>>> +		goto fail_map;
>>>   	}
>>>   
>>>   	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
>>>   
>>>   	drm_exec_fini(&exec);
>>>   	return 0;
>>> -
>>> -fail_alloc_gart:
>>> -	amdgpu_bo_unpin(wptr_obj->obj);
>>>   fail_map:
>>>   	amdgpu_bo_unref(&wptr_obj->obj);
>>>   fail_lock:
>>> @@ -520,9 +516,6 @@ static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>>>   	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
>>>   			      &queue->mqd.cpu_ptr);
>>>   
>>> -	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
>>> -	amdgpu_bo_unpin(queue->wptr_obj.obj);
>>> -	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>>>   	amdgpu_bo_unref(&queue->wptr_obj.obj);
>>>   }
>>>   
--------------fWSHWqRvOLdKM2kBeNoX8fg2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 15-07-2026 09:31 pm, Khatri, Sunil
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a965a413-19ea-46c0-a092-faf6f6b1de2c@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 15-07-2026 08:30 pm, Christian
        König wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
        <pre wrap="" class="moz-quote-pre">On 7/15/26 16:24, Sunil Khatri wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Instead of pinning the wptr bo attach the eviction fence to
the bo to make sure it remains valid all the time.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com" moz-do-not-send="true">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 34 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 ++++-------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 911fb325c70c..e1eb689710c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -936,6 +936,29 @@ static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
 	return ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);
 }
 
+static int amdgpu_userq_validate_wptr_bo(struct drm_exec *exec,
+					 struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_bo *bo = queue-&gt;wptr_obj.obj;
+	int ret;
+
+	if (!bo)
+		return -EINVAL;
+
+	ret = drm_exec_prepare_obj(exec, &amp;bo-&gt;tbo.base,
+				   TTM_NUM_MOVE_FENCES + 1);
+	if (unlikely(ret))
+		return ret;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">The WPTR BO should already be locked and prepared with fence slots by the caller, doing that here again can cause problems.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">+
+	ret = amdgpu_ttm_alloc_gart(&amp;bo-&gt;tbo);
+	if (ret)
+		return ret;
+
+	queue-&gt;wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(bo);
+
+	return 0;
+}
+
 /* Handle all BOs on the invalidated list, validate them and update the PTs */
 static int
 amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
@@ -988,6 +1011,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
 	unsigned long key, tmp_key;
 	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
 	struct xarray xa;
@@ -1094,6 +1118,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	xa_for_each(&amp;uq_mgr-&gt;userq_xa, tmp_key, queue) {
+		ret = amdgpu_userq_validate_wptr_bo(&amp;exec, queue);
+		if (unlikely(ret)) {
+			drm_file_err(uq_mgr-&gt;file,
+				     &quot;failed to validate wptr bo on resume, qid=%lu ret=%d\n&quot;,
+				     tmp_key, ret);
+			goto unlock_all;
+		}
+	}
+
 	/*
 	 * We need to wait for all VM updates to finish before restarting the
 	 * queues. Using the idle list like that is now ok since everything is
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 19c3cb61929c..ab8baaa83e60 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -71,27 +71,23 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		ret = -EINVAL;
 		goto fail_map;
 	}
-
-	/* TODO use eviction fence instead of pinning. */
-	ret = amdgpu_bo_pin(wptr_obj-&gt;obj, AMDGPU_GEM_DOMAIN_GTT);
+	/* Keep WPTR BO under eviction-fence control instead of pinning. */
+	ret = amdgpu_evf_mgr_attach_fence(&amp;uq_mgr_to_fpriv(uq_mgr)-&gt;evf_mgr, wptr_obj-&gt;obj);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">The eviction fence should already be attached to the WPTR BO when it is part of the VM.</pre>
      </blockquote>
      Sorry i dint understand. From&nbsp;&nbsp;<span style="white-space: pre-wrap">amdgpu_userq_create, sequence is like this
</span>uq_funcs-&gt;mqd_create(queue, &amp;args-&gt;in) -&gt;&nbsp;<span style="white-space: pre-wrap">mes_userq_create_wptr_mapping (This is where eviction fence is attached)

</span>
      <p><span style="white-space: pre-wrap">after mqd_create we are checking if the ev fence is signalled or not and based on that we are again going ahead to attach new ev fence if signaled to all bos.</span></p>
      <p><br>
      </p>
      <p><span style="white-space: pre-wrap"></span></p>
      <span style="white-space: pre-wrap">
</span>
      <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
        <pre wrap="" class="moz-quote-pre">The problem is more that the function is called at the completely wrong time. See amdgpu_userq_create():</pre>
      </blockquote>
      You mean to say mqd create is called at wrong place ?&nbsp;
      <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
        <pre wrap="" class="moz-quote-pre">And BTW why do we have the abstraction of uq_funcs? That doesn't seem to make sense.</pre>
      </blockquote>
      <p>I also need to check that.</p>
    </blockquote>
    Yes, we are having the abstraction layer for uq_functions but not
    really needed. I feel the reason here is to not contaminate
    userqueues code with mes layer code that's all. Since this is
    written by @alex, i would like him to comment on this.<br>
    <br>
    Regards<br>
    Sunil Khatri
    <blockquote type="cite" cite="mid:a965a413-19ea-46c0-a092-faf6f6b1de2c@amd.com">
      <p>Regards<br>
        Sunil Khatri</p>
      <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
        <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre"> 	if (ret) {
-		DRM_ERROR(&quot;Failed to pin wptr bo. ret %d\n&quot;, ret);
+		DRM_ERROR(&quot;Failed to attach eviction fence to wptr bo. ret %d\n&quot;, ret);
 		goto fail_map;
 	}
 
 	ret = amdgpu_ttm_alloc_gart(&amp;wptr_obj-&gt;obj-&gt;tbo);
 	if (ret) {
-		DRM_ERROR(&quot;Failed to bind bo to GART. ret %d\n&quot;, ret);
-		goto fail_alloc_gart;
+		DRM_ERROR(&quot;Failed to bind wptr bo to GART. ret %d\n&quot;, ret);
+		goto fail_map;
 	}
 
 	queue-&gt;wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj-&gt;obj);
 
 	drm_exec_fini(&amp;exec);
 	return 0;
-
-fail_alloc_gart:
-	amdgpu_bo_unpin(wptr_obj-&gt;obj);
 fail_map:
 	amdgpu_bo_unref(&amp;wptr_obj-&gt;obj);
 fail_lock:
@@ -520,9 +516,6 @@ static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 	amdgpu_bo_free_kernel(&amp;queue-&gt;mqd.obj, &amp;queue-&gt;mqd.gpu_addr,
 			      &amp;queue-&gt;mqd.cpu_ptr);
 
-	amdgpu_bo_reserve(queue-&gt;wptr_obj.obj, true);
-	amdgpu_bo_unpin(queue-&gt;wptr_obj.obj);
-	amdgpu_bo_unreserve(queue-&gt;wptr_obj.obj);
 	amdgpu_bo_unref(&amp;queue-&gt;wptr_obj.obj);
 }
 
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------fWSHWqRvOLdKM2kBeNoX8fg2--
