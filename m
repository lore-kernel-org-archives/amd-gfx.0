Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132851073C9C
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 11:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1D910E617;
	Wed,  8 Apr 2026 11:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f/lA17f0";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E3410E615
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 11:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGSB7t8WCjUyxpmSHk9UJDHS3hINgPz2gBsn1d/jN29+O5OvAf1fBWkPUDoIrJhYqAqz2ef18KLCFA7Uczl+cMa1pI9Li1qfgIAsE+Z7rht3YbW10pIDo/Zqom4WS9sQyM5mPvw+FeBpeJ0JVmooMhTHoRjBgwqCh4xHC7Tx7hvFf1k9/XuHRbv5pEwtLuM8CcTEyycWi7W5HKtdJayTPdvjIQXdNaoD9HooSDVMV7H6am4A2Q0hwwhD3bvl5JfPWdKNaemoO2xnbrXtG89pFPxG3jVMiSqbp8ZBqlCtjhfGkLmS/Rix6HJiK7snowl4o+cYi7n9uCeo3CaeiBtvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc9/FL5sH7IE7z2YWIUhasRmW6yonDmuHm4RKof3kLk=;
 b=wa0tdbcEAkEdYvExqKzfwz4cqHBRmT0oL89/bWgkVeXsHZn2l20uUZthKV62T0EvVIayZUbFCPS5RPoVHpUB2dBPjm1AalFSKSr39kEth4QsthHgGsK+LySC5RFUqeoqhufzbiSA4OG9YXF0hVKgp4mIuvd1G82mY48etby+1CwrZsJAhpmmmxweNE+4obv7YG49vcJZeVe6wRX0cgXfVFyT5rVGvJlJ34kI5pnDvsqLAssModz6lTbb+YwPlXMBXKdLC8GKTPVEvuyH87xlBkVsznb6fiQo/3jn/jfJruMetiZwOiY72w+QsyaNJhS8i5Nm8+DZQg4gSFYkX550Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc9/FL5sH7IE7z2YWIUhasRmW6yonDmuHm4RKof3kLk=;
 b=f/lA17f0WcZgK8BDhhdyLQ202MyCerT2Z3X7tx5fJrgyM11Dy9R3ED7tYzqB2sYw2oULyQcHIEVChfQWV7I7ZpO+PZC7SWoWuXlJ5dXWZq2WUSLzebkWfGj5kl1FH5Vj0RC3UMfumy9LRJMFoCVsvb15mJyhI0F0XiuVzmeTEpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Wed, 8 Apr 2026 11:30:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 11:30:42 +0000
Message-ID: <edfcf107-e361-403a-b53c-9acfdeb9d0f7@amd.com>
Date: Wed, 8 Apr 2026 13:30:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/userq: avoid uneccessary locking in
 amdgpu_userq_create
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408093828.3532876-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408093828.3532876-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f83acc-6862-4502-2af3-08de956244cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: u6TXF4IlRNLNrv328cS45fCZKfqFIQTPraU2Kij5xDQbtAgsySgY9Nh7QMMPs2QuQZhWSzI0fcFC+CCL/sqN2dKi934b9/aZww2jhJjEIZcLSDHqd8PuNzwaX7yqz1P2NerKXJ482Am/GdFbNDmm2aUZSlqcZ9cz2HL3fOH85gRr85UebpR/NlVF2+MhsXPVC2tpV6mHi0pqOiQ/xIKydb5AAhngpDYlpdYxqNBPTC+svz+DmQnzAicnryraHY38H62kJ+eC2RoHT46pkjtxVXy2DtSIfaGjJQEQ9QzWP3aKdfBvcUpwjiw47AaHDV/YFC2YIT4Y5z6xAhHk99K2blfcQDn1ZBAt+OZF1dVZWPwJ6t4tPCaqWjVR9JrQU1Qocxxz0YStWV91XPVt3mXh1sAMOAsbRp+BGtP4VFdQ8hUE/rWjc0c1UaFUjW4PPNA+ID6oHAelM18kO1m+3FxBg81AIeeYQhdYDpL01RVVOjFTldrr3oma7uq8tEPeAUTu3B5RsA6vB0WVZA1xrTHChp+2x6+uJ6adCKjJjP5Zooi2OkZUQcgcE9Np9D1vWriQ7pu/D+4Dd6IfIcc3dh1rmvDEcdKmqYm9V/XE9AAZEGHYid7pOYPiShwsAV7mCpIaHM73yCLpGxCAX2yZBuCr1nwZ7EewVcOeRfuUfqRHG7OuWiHSVbRIjZVZkcerK0HY4kWRDc+5OrYhWvOU8/Sx3eKQEXL0izKWlOzWUQ0VCvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxqRHFJblROWk54Rm15NEc0SjRCQVlkWURySmxqVGt2VU1id1ZxL0c4eVkv?=
 =?utf-8?B?Q3U2a1VGR05TdHduVnJ3VUV4d2J5RmM0Nm9oeFo3K0tLMldGM1I0dXhOcEZx?=
 =?utf-8?B?REpvaEhiTElFVHpnNUxqUzhpVU5XdkJkSDVXMzdYU3JOdzJSM3F0VlV5dVpH?=
 =?utf-8?B?NnRsMkxmWTFaeW9idTZNMG91ME5ucGpreXBJR1Z0Rnp2ZXVDZllKREsycTBH?=
 =?utf-8?B?Z1JUZmd5cXpUakQ5a09rT0dibVdGc2JUVHo5RG1GcW1vWXloaDJxNkZRMjY4?=
 =?utf-8?B?RGxncDlkL2dxVVk1dHhyVDNDeG5ldHdQV2NXZ3VqK3krTGJzeitGMXJyblhZ?=
 =?utf-8?B?bWtZWFk1RDVuQ01SdmFaa05nNXZ4RksrUFdKSUpIczkxTXVleG5pd3lOYmxq?=
 =?utf-8?B?MjgzOG54WDUwcHVpNWtYYjU1cmFma2RFM0hmeHB4bklpVW9sQkh5UFgxK0RG?=
 =?utf-8?B?NVc0Q1pHUnowb2l6ZHlXMjRra2pnZ0VhN2p5cUxtMlpSb09Na3JuNWFWN25y?=
 =?utf-8?B?NGRpMjNJeFNwTWtIOThVOWxCektiZk51QjZ2VmJoN3g3U1VWK25DVjNpS0dy?=
 =?utf-8?B?K290ajFmeXMzcitJMVlnVldCQWRHcHpzTUZpTTVCZWJ6YWkwTzMxQXR4UXp5?=
 =?utf-8?B?U1F4Z2diZ1JvMHVTNlBqUDgvdkxCcXN3OGtPQUpiOFFlVHBhd3BXalc1VHJW?=
 =?utf-8?B?Q3UyYzd0bEJheFJCRW5hQXN3SjVDVVUwdjFIM1dPY2hocktSUkNuTExBQjUy?=
 =?utf-8?B?OUNDR1ZMNDhHTUpqUHpieXl0MTAwUUFjUkRaU0VNRTNBTzRLdzhkWldZdDVD?=
 =?utf-8?B?OGxTZEdadkZmeTgrVmpvaHhFaGU2U1RwSXN6V0N2Uk01MVlvQlgrbm1rbCtq?=
 =?utf-8?B?OTRyLzN1TWMwTkxFVEUvVGZXN2hFS1B0TXJZNDRMbXE3eHFMRG0yNHh2UjZh?=
 =?utf-8?B?aTFLd2tVQ2szajV0Sm9QVHd2UHB2WmJ1U1FhV2ppZmdpMlZWcVZCKzRqV0t1?=
 =?utf-8?B?eWxqMHV2a1kvL2RieHNtNG5sMFlFa2ZEa0lGTjBxOEtHZTV2aVg4RXl4YWhG?=
 =?utf-8?B?VlVUQi9pdXZMaU55OVFPcjhWR0ozZUh3eDY0amJ3dzhpSXBCNU5sU3VmN0tJ?=
 =?utf-8?B?eG9iOWpMb1g1R2Y5UlhNNitlVG9jTkpnbDA2ZWE4VXptT1lKalB0SjJEWmxO?=
 =?utf-8?B?V2VMRnJLTE11M2U1M3FaN2pMbStqWmZNaHU0TG9QOVBoYXhubUJiVVc0NlNG?=
 =?utf-8?B?d3B0ZzdSNEJqclF3aEJDc1g0a2VRNStWMEdMUFQyNFpjRy9ubi9iS2EzOEFX?=
 =?utf-8?B?d1o2TXFqN1RXWnR0Y093WnJNTS9LQlY4SlV4eDJyNXVOdlZGWkszTmt4dFVI?=
 =?utf-8?B?bkZBS3k0Vm9DOGM3UTFocndib0Y5dXZsRWkwTWUraXhaUkJLS1VKa1R0Z210?=
 =?utf-8?B?bUlCODVleEVzYUFrTEo4cEt5Zms1aDc4RWdNa3FScWN2QnNnOUo3bXlGOE1S?=
 =?utf-8?B?L2RJd1J5bEdsZitpNUhySlRvelplbGR2QUZNb1kzaG9nWjluSkdoTkJpUU50?=
 =?utf-8?B?c0h6R2hDS3cxRmVBRm00Y2NzSmdOUDlHNThUcEZQV2t2dDZqMElaL3NwQzBU?=
 =?utf-8?B?WUFVZnZQajJwTm05WkxrNU91MEh2cFFsUTVraXBFWFhtTXBNaEhRRk1tMVdP?=
 =?utf-8?B?REdyWDg0OC9zTmhlS0Y5OFZoRk10S0d5b1pTb1N2akhyellacXpGZ00wUmgy?=
 =?utf-8?B?NVhjaTFBRGJUU3FPTUhYU2JDUWFINkhvU1dUeW9VVmNKc1FQMEwrcVFsaFNz?=
 =?utf-8?B?bEsxa1A0QTJCRzhzQXV3T0QrUXRsMFlGRGZLSm1mY3pGNWVybGIyY3NnMkdr?=
 =?utf-8?B?alZYS2pySHZrOFlzaDgwR2d6RmMvSTJ4MXRDaHRudlBNVENrTWxXblczMHZv?=
 =?utf-8?B?Q2orS3dQdCtaYXJaWTN2d2JDTHRUYTcvNjJIK0VlWCsydkNwQ08ybXdLSGM1?=
 =?utf-8?B?bHJQSStvU3I2WVN1VGJkeE4zNlYyL29jTHdoaU5NVE1tT2hQVHZGZmpnNXc4?=
 =?utf-8?B?aTFJTDFod056VkVvM1dUVjVoVVFsOUxOZkMrSC9ib0VDQnBHREtnQnVZNnZJ?=
 =?utf-8?B?bnA2akZQVWJ1aU9YSldGbW14ZUlzRklZODE2ZWhCMGEvS0JJeHpCMHBNRkQr?=
 =?utf-8?B?VnlkVGprZlYyeXlaUHRIa29Kd2MrdWZxYy92azV4VUZCWFl3c2Jxb1V5ZDRh?=
 =?utf-8?B?eEpsb01CNEl6a1FlN0xiQytPU1cyUzAzYXlERksrOUdjeHNNQWZDendodjJa?=
 =?utf-8?Q?mSl+HnKj6bW+Uph4O9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f83acc-6862-4502-2af3-08de956244cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:30:42.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuM3IrmtxSuaQqcwwhGrEM3vUCwdc0/wHS9DYudOjnbYxuDAZZNUbYwCWyMuuWAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
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

On 4/8/26 11:38, Sunil Khatri wrote:
> Reorganise code to avoid holding mutex userq_mutex while
> also trying to grab exec lock ww_mutex where its not needed
> for function amdgpu_userq_input_va_validate
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 28 ++++++++++-------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3a6e7a569c78..c19d993fe8c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -737,28 +737,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		return r;
>  	}
>  
> -	/*
> -	 * There could be a situation that we are creating a new queue while
> -	 * the other queues under this UQ_mgr are suspended. So if there is any
> -	 * resume work pending, wait for it to get done.
> -	 *
> -	 * This will also make sure we have a valid eviction fence ready to be used.
> -	 */
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> -
>  	uq_funcs = adev->userq_funcs[args->in.ip_type];
>  	if (!uq_funcs) {
>  		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
>  			     args->in.ip_type);
> -		r = -EINVAL;
> -		goto unlock;
> +		return -EINVAL;
>  	}
>  
>  	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>  	if (!queue) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
> -		r = -ENOMEM;
> -		goto unlock;
> +		return -ENOMEM;
>  	}
>  
>  	INIT_LIST_HEAD(&queue->userq_va_list);
> @@ -797,6 +786,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto free_queue;
>  	}
>  
> +	/*
> +	 * There could be a situation that we are creating a new queue while
> +	 * the other queues under this UQ_mgr are suspended. So if there is any
> +	 * resume work pending, wait for it to get done.
> +	 *
> +	 * This will also make sure we have a valid eviction fence ready to be used.
> +	 */
> +	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +
>  	r = uq_funcs->mqd_create(queue, &args->in);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> @@ -858,11 +856,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	up_read(&adev->reset_domain->sem);
>  clean_fence_driver:
>  	amdgpu_userq_fence_driver_free(queue);
> +	mutex_unlock(&uq_mgr->userq_mutex);
>  free_queue:
>  	kfree(queue);
> -unlock:
> -	mutex_unlock(&uq_mgr->userq_mutex);
> -
>  	return r;
>  }
>  

