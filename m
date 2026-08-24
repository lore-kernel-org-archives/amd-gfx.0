Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4244AC5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 14:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FF910E555;
	Mon, 24 Aug 2026 14:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N3am1gMh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEAB10E40D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 14:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrhel5UTYFxVL1bMyw+5KhoxIrmgu3CIAmXm6F0zqd8YMwnsjJRZag+wA6tGQPMYbjCefyi6Si3g8qaydZ3Z6kacX5abqHKZnzkpMeAORChclxBfnZvGphN1bt4M5kxFTypGLHl3s+gp0OkefGeYr71tX5MW5Kcd4FWEdAfrdRbbzdfcWGpLNj9aT6Ejch9z61pdQIeu1X6Jbk0S9dYNtQD3lysnF1w96tqqdF10oa2cOOTN2wIj8+mh+EVBYm/1JqKsRsK69uhz0SelbYStxxaccoz7xtEzupT6N7iCsSx9z9c8txxOUxsvHfOzd24F6Lov3WH6odwWrzIeNrQtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njZbKvXW1DCIF1imqXndssfsxo2NV5nbcx/bdG2d4o8=;
 b=DtWc4bz2e/Ov0yDFRfhydGOL3P+DiEhL8ZaE6/rWfnivNrMwjYTkYsmsctgRB12RdkXPZa6LQqiCJppSGTbbmH4Mx/oYtlR2/+SOqMnLaVRunzJJKhH8RvwboGBoDW8dT6vMcuEUlDDeqxW/9XlV5vRd/JNX16/66fXpt1aKattdbuYSBB5hAGMW1h7PhosBYTG9r4R+floAaJ7TF3uwWQjg+XdUmk7OC/YPw6qctKrWnNdmI2RffASIgB2mzemT4/eeCdpiEvylMoC9VOx42x44FjnqWw+Zj+KNB0AvPagtN5ak5nTCQommnb0+PqPapVTZemKNHpetdpscxlMXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njZbKvXW1DCIF1imqXndssfsxo2NV5nbcx/bdG2d4o8=;
 b=N3am1gMhf2yjZOh51OwKDDOW6Nwn0SPs8x+wav8GtIGHEQ9w9T/mZnFGX6Nzp9d2u7Y7hEqeLPc69set7cp42oqQXmnZiJoXKUNL57U3D2ENGOGR4okX//3TW93XOihl7kmBT6x076OoRyxjeecHmAJ5Vma1/qWQ6T3U3y+6lBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:38:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 14:38:37 +0000
Message-ID: <d186f7b7-11c1-46ae-bbf7-d439ac1c4971@amd.com>
Date: Mon, 24 Aug 2026 16:38:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep the userq manager alive as long as its
 queues
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260818115753.127358-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260818115753.127358-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 442bc46f-9d7a-475a-d335-08df01ed61e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8tCo+/hIxlj1//2wfTH/Z94XBEq+uMef9cekFR1C15qOyDZd0CgL0LVFsDsn+An8uoDmu2fICvJkEAXGDCyFgFJETuz63T5H9K5gP2HTd0gNU9agYtaT+fCfZnwLYnIcbJ9LXtEm5tpNkLQ5qgue7Cw4RAe5jKhNR2/mycWVIPdUMJVSTFwB2xFVZ9REinA2RKJGccFLRveKCnvM0EaYBydwssaU9578v8fhll0IFpe/OkfRWhmcPZ3WrQ+ltC+fYROsIkZ0Ix6sHCDHmDWDT5t35DcHEIk5FpuPJ4YUIgLhh5uDJ37G7YliQFu1H+PaCp3528G3/yl8afVRetSDiuaS8dP6pQMOTiTC8629Cud6EVNOjxKVOxIWWs3NZib7Y3yrTKWw2u748WuHCcqXTH8PWIzQDHGaXQ0AjnWs4+4ezj3zT4QjiJj8Z9hsn9lrEOc7ftaWFRSyFV7dAiiOEyf6KYLnh8kxA6lRAxpERLOQCQrOT4i9Po7PkHkKcwLJZ6maItCkQCCSc/ibKSsmrPcg4EYMvKyD8ee7BbEqsqH2fJ7dlTaX4JEPlawTKd9uz5u24GXFMgzJ+IOSIQFCN/9Lw/lfzT67x31T3VyfG6kJbQ8PML3aahAr7u1pxR9sxUv6hxAmkej4ioHOpbotf99sj7M6ix75nPK0Z0SBUTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlrOEJCOTdBNWE5NTVQaitieEVpU2YxUHBGWFBsTHJhTW9kRkdza1F6VXhF?=
 =?utf-8?B?Q2FCeVJKZ1hlc0lWRnZOMzF2Tmd2MTBvYnJXS1JjK0VNdVU5cmhOMXNLNWhj?=
 =?utf-8?B?VkNIc1NPMm54M1NVSnF1N1RqUTBLUjA1cFZPK2lDYXRTdVg4Z3E3NGIzSC83?=
 =?utf-8?B?OUl4OEVOZld0QWJTTXpVZ0NUWUEyZnd3c1h6VWo4b0kyTDJCSk5ZTmRIWmRE?=
 =?utf-8?B?WVk5MEIxbkRncUJoUGhVTjc0R0F4QVQySGlaN3hPM0k4SjVJRTB6NGR5eU54?=
 =?utf-8?B?V3NaNGlTWlZQTzR0cjJnTVhBVXBpZnRodGQvaEY2MVRFNHIzbnhrY25yK3pC?=
 =?utf-8?B?OHR6QWxQSU9ad2JzL2JvR1lrOUZhK21DMU41bU1GbCswODJIWmZjdkdRTVJ2?=
 =?utf-8?B?OHdia1NGOHllakxQMEhYQXI5S0pIU2lyQTdyVTNrdXZ3ZllxS2s4YXh3Vmxh?=
 =?utf-8?B?N2JROHVnaWpDNTJXTE5Gd3NnUmpMTy83b1pDSGRybTZjczBUSlNqVEJSYVVG?=
 =?utf-8?B?QUFWNEUzY2wwMG5abnV5ZnV4R2Z2YzZhZ2dSdUJNWTFoWndJTUFkTFNLZW1n?=
 =?utf-8?B?cmVHV20vR01tNmtSbFQwQlJncDV4VldyVWVZVWtvWWdtSDhsVHNtOFJOVDVS?=
 =?utf-8?B?TlhBWUkwMjhZSUxJenpaQXc2bmp2NFRkdW9JSHhQWHdnVnltUGtZOFpTS0Fy?=
 =?utf-8?B?Y2JGbW1UeVRSbjc2MjNIUjFGSjB6eVhKbU0xRXBhYjh4WXovWFFlK3dMNWI5?=
 =?utf-8?B?ckV1aDUzWTVjY0hwRVhhWWdMOFRQRUhQUXNYNjdhZytzNEN3a0llSFgzUWUx?=
 =?utf-8?B?dEc4VE5PVFNUQ1VrSVJjMGE5aHJ1aURQRlUwVWNieHQ3OUVrc2R1cW1TZ2ov?=
 =?utf-8?B?cXYzdmxoNVlHczNmWWltS0ErUW5qbm83VnVJeUplajdVMnFnRHJ0Mlp2Wm5H?=
 =?utf-8?B?VjF1elRTUUlJbFRaN2pZNFZpeDdBQ2ZzTUkrR2llZS9seUV3QTg2WGpERjI5?=
 =?utf-8?B?TGxvWG5UK2RnVlBJcWVIbnBsWUd0YzFMQ3phaEE0RWY3N3VuU0c1aEMrK05P?=
 =?utf-8?B?ZW96NjJoOXhGemI2VllJWlZpWXZSU0doZnVoSVlHRFUrUG9KWEx4eHRyd2w1?=
 =?utf-8?B?N2xtRVkvMFdZLzBGbzFadSt2ZytZVERBWGJLMUFySEhIbFlpaXpBOXVnUmVo?=
 =?utf-8?B?YVFZU3A0Nm52bXZBczMyNFp6M0J1WVpWdDBrL2V5Nm9BZ0NvSXN0WXIzVEpP?=
 =?utf-8?B?NWM5U0RlQ1I0U1Q3TXg3VFlxdlRFVE0wOGpOQzFYMGJzWUg3TmJxeU5DVkk4?=
 =?utf-8?B?K25sVldXbUVyMjMrNGNBWlVFVTBSOXFhNlhYTXZLT3FVUzltcmhZd0RPblF5?=
 =?utf-8?B?RGh6Mk9naldEdDRyZVpGRXJxNDV2ejhZYnlkS0lUdWdCM1p3VUtKdTQ5aHhl?=
 =?utf-8?B?bEJKTHg2TzFHTHZpby9nN2t2VjY3K3BkVU9UVnZ0YlN5N1ZGMjZ4NVVmS2Zx?=
 =?utf-8?B?Q1FodEZzZTZteXF5RUd4empOOWZMYWtacExNb29YWVRTOWVUOVpmUGg3a1Ri?=
 =?utf-8?B?V2RWVXdCN2k1dndZOGRmU093bjF2WmJ5NE5hcDFDVWNzSGZzUDc2NFNBczd3?=
 =?utf-8?B?MTUvNmZtdlNvTlR1MlpsSVFhZjMvbXorQjlOYStXRUlsU0x0VWlxMWxzU3da?=
 =?utf-8?B?U3AwWTVWcGpHRHRIQzdFOEZzU3V1RTdCa3A3ZWxZUy9YeTVCSnRsSERma0s4?=
 =?utf-8?B?Z3dtVkppME5qaUNyUkt6aEowSStaRmswQjBNaEY5TlhDS2UzNEVEQ3VLV2hM?=
 =?utf-8?B?SlFXRDBZN1Qva1piUWdHVXI3UC9MQkordHBZTFl4UmFqc29IWU9TWHhTQVpr?=
 =?utf-8?B?MStDUWJLUURmTk1wNDhiMnF4Y2NvSXlKTElHckFJajBZV0p5QUN2UEljL1Fm?=
 =?utf-8?B?K2JjUUczV1VhN2FPT2lDU2F1QXN1ZlBEaFlUcVloTWlWNGxBdUpaVWFmaTBF?=
 =?utf-8?B?YS9TQ1lDNlpoZ3dLeXFpMnp2U2o2RU9TZW01Z3laaUI3VnpkZG1DUWk1OTlQ?=
 =?utf-8?B?TnJ2ak9GUW1pbS8vZnFoK3hwdUV1dXhGT05NV3BqMll1T3duNEJJaytLVkI4?=
 =?utf-8?B?Uk8rMFhITnNSdTJwSHVSV0JYTzVja01hWlFPS3cyU3gydTZvOE1SQkhoRHRZ?=
 =?utf-8?B?eXBjaGZuNXZGQjhOTTVNZTdQeExKdVlaeEtyR1ZydUVnVGZnR2JGOHEwc1ox?=
 =?utf-8?B?bytjQk5wSFFJYzZXRXpQZGJsbHVBdmlPRUxNc1VYNUlsMTUxVzU5OU8va1o0?=
 =?utf-8?Q?5Y0EjOK/s2Fchntyfx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442bc46f-9d7a-475a-d335-08df01ed61e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:38:37.2938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSVxmVio+JcypPg1brIvpZiSkgcuM+Bzr2pOt3TqTnVJijy8kL709wKiZ7WaYSvB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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



On 8/18/26 13:57, Zhu Lingshan wrote:
> The userq manager is embedded in fpriv, so any code
> paths trigger kfree(fpriv) would destroy the userq_mgr,
> even some of its queues are still alive,
> resuting in userq->userq_mgr use-after-free issues.
> 
> This commit fixes this problem by introduce a new
> counter refs representing for the number of its queues,
> and only free the userq_manager when refs == 0

Well the userqueues are kept alive as long as there are IOCTLs using it.

And and IOCTL in turn keeps a reference on the file and so the fpriv which contains the userq manager.

So that here doesn't make any sense at all.

If there is still an userq alive when the userq manager is destroyed we should probably call BUG(), cause that mean a major reference count issue in a core kernel component.

Regards,
Christian.

> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 19 ++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 24adad7be251..434384b53b85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -533,6 +533,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  	return r;
>  }
>  
> +static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	atomic_inc(&uq_mgr->refs);
> +}
> +
> +static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	if (atomic_dec_and_test(&uq_mgr->refs))
> +		wake_up(&uq_mgr->refs_wq);
> +}
> +
>  static int
>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>  {
> @@ -594,6 +605,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>  	r = amdgpu_userq_destroy(uq_mgr, queue);
>  	if (r)
>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
> +
> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>  }
>  
>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> @@ -677,6 +690,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>  				fpriv->xcp_id : 0;
>  	queue->userq_mgr = uq_mgr;
> +	amdgpu_userq_mgr_inc_refs(uq_mgr);
>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>  			  amdgpu_userq_hang_detect_work);
>  
> @@ -789,6 +803,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  free_queue:
>  	trace_amdgpu_userq_create_end(queue, r);
>  	kfree(queue);
> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>  err_pm_runtime:
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  	return r;
> @@ -1277,6 +1292,8 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  {
>  	mutex_init(&userq_mgr->userq_mutex);
>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
> +	atomic_set(&userq_mgr->refs, 0);
> +	init_waitqueue_head(&userq_mgr->refs_wq);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
>  	userq_mgr->proc_ctx_allocated = false;
> @@ -1326,6 +1343,16 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  		amdgpu_userq_put(queue);
>  	}
>  
> +	/*
> +	 * userq_mgr is embedded in struct amdgpu_fpriv and get
> +	 * freed when kfree(fpriv). This wait_evet() blocks
> +	 * amdgpu_userq_mgr_fini() which is drm_release path,
> +	 * so keep userq_mgr alive while any queues holding it.
> +	 *
> +	 * This prevents queue->userq_mgr use-after-free issues.
> +	 */
> +	wait_event(userq_mgr->refs_wq, !atomic_read(&userq_mgr->refs));
> +
>  	xa_destroy(&userq_mgr->userq_xa);
>  
>  	/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 6412a7f7b6ef..7141383ea2ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -24,6 +24,8 @@
>  
>  #ifndef AMDGPU_USERQ_H_
>  #define AMDGPU_USERQ_H_
> +#include <linux/wait.h>
> +
>  #include "amdgpu_eviction_fence.h"
>  
>  #define AMDGPU_MAX_USERQ_COUNT 512
> @@ -126,6 +128,23 @@ struct amdgpu_userq_mgr {
>  	 */
>  	struct xarray			userq_xa;
>  	struct mutex			userq_mutex;
> +
> +	/**
> +	 * @refs:
> +	 *
> +	 * Each queue increase this counter when join this manager,
> +	 * and decreash this counter when leave this manager.
> +	 */
> +	atomic_t			refs;
> +
> +	/**
> +	 * @refs_wq:
> +	 *
> +	 * Waited on by amdgpu_userq_mgr_fini() until @refs drops to zero.
> +	 * This wait prevents userq->userq_mgr UAF
> +	 */
> +	wait_queue_head_t		refs_wq;
> +
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
>  	struct drm_file			*file;

