Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F715CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 13:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F409810E105;
	Wed, 20 May 2026 13:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0n6eqM5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B366010E105
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 13:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFDX/fzGP1zA3SJZVGoROGBbqWGtc8nk5uMCgdjdhpUdLYhQEu7hJQmF1ir+DDH0HY1oh1yQnPLvAjK0aqOQMVE710zLgqsW8hQV4s5j3b4fMhzG5paPmGN0r7ibcOhzpvDSlKEqWXsd+PQZUL0O5ORHR2RpHyE5UMmmikt/tUsjRDq4A3O7ME77dfmRPA4+3X/JyuDkgPXIvz4Yveqe8GK04I4xkCJOB0nz05bp5LUhuDzCfdrFI4Jmq83AUxKJyj91jWHnlo8arQcafBGdyYr4XAzlj65rKUeKJ9P/PgIcDqY3yEtbZgW0oDZhAmHi8gvfprqAfm5gKJ3uPPGf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oCz7awvtfOeffEiteefcFDcorke21dNmHR34gwYoWI=;
 b=jiwBu1yE3MeqZCVqblhHoCB8ex0NYBgjOPdv7rJ711J4wq3WWKFVRkHWNzq2lWEsHEZZqh86cTm3q+HoC+IlZgCAMzZ/bVw4jG1SRFI5OSdCJJ2jhinRLhs9LGg/LI5QE8Xd/zs9C0+NEVjp7xWuNC/gf1fm4X/RoJ1t38S+WDAR6BgoT4+JxvPuAJFM1EbxzJizoT6PcimieNedo/KRAh5PgQmZIt8JZlGR7UwyS4b4dqgXKZ+RhMZxTE0jIntc2hvH1ZqX76UyGCBdxwylwA2fMJ90aspYWXlE7fnF4WMy1opFRYjcrM++3VfXieaOAHxioPd8/DW0mKXPFN89yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oCz7awvtfOeffEiteefcFDcorke21dNmHR34gwYoWI=;
 b=d0n6eqM5hTNyT/XF9oavVRE0bHmguSm0erLe89D9F94qFaXtTowFVNL5YW30R2b+NXd8BwYL6IpKvNE1fGCg4OlkNefX+S40qI2vPoQRDfWZd6PM9s2py2QXTtfkb947ZetfWLVow1viGOws761psLy3hjK+A22n3+GM70p4lEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 13:26:20 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 13:26:20 +0000
Message-ID: <4c35a516-a473-4ef0-b63f-e12d4328c209@amd.com>
Date: Wed, 20 May 2026 18:56:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/userq: move mqd_destroy to later stage to
 keep core obj valid
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520121019.2581398-1-sunil.khatri@amd.com>
 <20260520121019.2581398-2-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260520121019.2581398-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0176.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::17) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b1575d-6e9c-4282-51a3-08deb673614e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TsvXWHyzuzC15C8DE4qm7ss2EgMlsjtGSp05NUW+94A2cIk+4/KVafwUGQ2cZgeUWCtG6F3WBY5myhiueCgIkDtfoptxW3pTLDspfdLxE4YJ+W86loTua1QtRFdOUvymzHvI2wV8EV+bGbPeMzZkSnPMJxR9a/e4yVyWK+00hA+zCmqrval8g/Jw8eUcT11DwbJf79rpxgixdpBxgpHrguLFyboCIdMMvZoQhQ9DPzcbwAjR4zKkFCgvQuJnkh+p6GYWRajOUP3W6cVpjf5oDSn01OP0lPyry/MeuHPNabDIEC6fz4UB+bhcrVLlB5tqHj7s1kIrWTCY6MApLfpQ89+/Jqx9AFBKCU4B2Zm3TBfktX9eoguIOQFNj/nk6jZT4ax2O90A2/hB3dxX8Snfe3VeHA54TEzG264b4JWE4tHgBjIGQ4CSDWcqpd7hXCdAnHmAl+Grwk7Aes7Q1C3pT7EYBfsJpg4BLDNhKe/YGLN91A6j9Vk+TK6vCLdRj4a31Vuf1LwgxBxqWLrn2VOSx4BnmJu22+/fykoPJE1A5lrgKDG2uFmGis092ycc1uhpaH32g3wap64NprK8Gj2q2poCWb7H/EByPFqVrWZ1e7K8lei+qWyqiJR9dMRhCWNYAfq0B2MPt+fTyB0hsYg/RhCJC7w2ZvM0TspbgwgQGcQgMuQrCUZRIq4YemCeQvFY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak9UZDRqWXJvOFRvclhCWldORG51MjlTOUZCdC9uTVlyQU5OVW1sN0dmbjN0?=
 =?utf-8?B?TkVPQlZLak81K09pZDFmK0lCb054dU04ZElhSTBMRUNqSFg4Wk9GZ1NnK2lm?=
 =?utf-8?B?ZGFVRFdrY0NQWmJNdlNwMFpycmY2TWV6b1NmaWJrWlh3aUpER0VNS2Myb2hO?=
 =?utf-8?B?dC9zQVhNRzBEVGgyMjROZ3lUcE50MmRGK3JOdVp4aFg2bll3NVBKRVlES0Zr?=
 =?utf-8?B?bUlwakxIMmtIQnBrMnRPWUxEN2N4UVh6SWFwTFdLRTBYdUl5azg2N3lLMUtY?=
 =?utf-8?B?N3ZFU1VCWTVGRzg4M21hdHgvU253OHlBdmVvL0FUYVVTc0w3ZmQ1VnJnQk1m?=
 =?utf-8?B?bWg1ajBWbzlENDRlNWlXeHVXMTZ0ekI2Z1lLcCtscFFJVUNSdFdnOUNTajhH?=
 =?utf-8?B?dld1RHJOY3lLaWFReFNpdmJ2VEduS3lCWXJRTUQ1MytuUGt6eHlYNDdYV2oz?=
 =?utf-8?B?R1g0U2IzcnFJTzhCRVNNL3RvUHh3anFoa28ydUsrSndNMDFtMjJETzMzWGpD?=
 =?utf-8?B?V0FyMkRuNWttZi9QMEpnQXBxTGgrb0Q5VVdWZHFETHlnKy9ZWVVVNDVVbnFL?=
 =?utf-8?B?U2JuVkRoN2NNazNHeCszVkYwUndadXMwNGw0Qm13OGJZZ3poWmpBRk1yMThx?=
 =?utf-8?B?Z3g0SW0yNnlXSWk2N1JRQWVxRUpQbGJwOWJTa1lrdXpQVmd5bGJWVWRKYmJH?=
 =?utf-8?B?a1daODdZSjdQWlZHaTZLN1Y2TkJoL1B5QlJwMitsN2dJNGttam8zVjYra2ZF?=
 =?utf-8?B?TTJiR3NRVHBESVQ5MlhwVXJnSmFWdnVrSkVxbFdOSEwyN3BvQ3Yxd1R4U2RV?=
 =?utf-8?B?UmRieVJtZ25JTE5WVEhWd0xBaURyRUVUSEUrb2ZaMFdMSWlWVmNibUxCd2lH?=
 =?utf-8?B?c0w5TjV0YVZKS0xkR3VJamhEWThLVGtLTEljUjNZNDdZdDQ1bGZMQ1JJdWFR?=
 =?utf-8?B?VG9udUZBZHRRRHRaTnhBNEFTNTZIUENkZWptV0p0cjBKY1JDWlFRdWJUY0kz?=
 =?utf-8?B?V3dUMHNVY1BPWldTYWlnLzI2T1pBMndySmlSSExESmo3NzBUbWM1d1QydXF4?=
 =?utf-8?B?YXNRTDlTdHRLbUEydGI5SXJoNjVpYUpOOGNpa01KclExaVZ0UGViZDZVdVBy?=
 =?utf-8?B?K3pkRE1wVUtvRk1SRzg5emovS2kxK2lNOFNWRXVzQmxYNnFvcjZYNW52d3Bh?=
 =?utf-8?B?NThZaFlLc3pacmFDUWd1UlpETVJQaTF4Uyt1bzFEakZ6OFFIdDB0MHNDbjZI?=
 =?utf-8?B?VjBGU044aUhYaTlvaVFuMHNUUlVEUWpYNDIraStQMGNYaVZjMnRFM1p3ZHAx?=
 =?utf-8?B?WU9xY09neFBjbnF1Tko2RENrNkhhb1V5bTI5Y1NIMlhwRGFHK3hQTE9ZNWhw?=
 =?utf-8?B?bmd5eVpOUjkxT0FQRmZ1Y25yZTNOVm1Cd3FtUVNwejd0M1JZZzMzSDI5MnhL?=
 =?utf-8?B?SitQbld4U0pRZWdBNU1aQjhSZW43aXdpeDlQb0Y4NThXY2NWN2tzcCtpeWNp?=
 =?utf-8?B?cExDNHBqZi8rdzlJc0hxeXpuNnBUQXN5RU5nSEh5TW1YWjZtNU1UN2xmQnBC?=
 =?utf-8?B?K3ZzZlR6eU1tTWYrNkdaaUFlZ0JzZzgxK3c2eVdvU2FSeG0zS2RGRURJVVg3?=
 =?utf-8?B?STVEeng0eEN0U3NFVTBVeWNSWSszTlY5dWFiaVNQbkFIaFQ5cThxcHgyeW9K?=
 =?utf-8?B?SjNBL2RaZ2hoZWg0ZnkvOWFtcGtUNkw0Q3dsMGJxQmpZWUVqUGxYTFRobGMv?=
 =?utf-8?B?SHJSdCtjRjB4empBQTFHM0Rxd1llM20zUnRqcXlFTjBSQXpwTWVycUlJNURx?=
 =?utf-8?B?UGtrc1gxM081QXoyVTJkS0RaTzVKQkI4TGFtUnNPQ1VsZVFRUWUyNklEd3pm?=
 =?utf-8?B?ekxYeCthZ2p3WlEvZWxQcFQ3QW1DV2d4Qk5kQk5KVWRDK2FxbFhHU3FhL0xP?=
 =?utf-8?B?YlU1dlp4bFFDWVRicysrKzVoNFpJT2lOYWFxNDAvSlc5STZ4WVUyVXBVMVYy?=
 =?utf-8?B?NndySS9IaFZ2VlpSWjRrMUxkc1R4NGZiaGEzbkVpM3Y0OW9KTFVNaVBReVV3?=
 =?utf-8?B?d3p3UkVvR1lqVGc3RVB1NmNQZ1VpbXFFbUdNT1picmxRNEpFQVNpcFR2UURD?=
 =?utf-8?B?WFZhYlVDZ3RSQ1RMVWFlTVl3VjZEeWNkOTVsQnZ0TFMyVFF4YjQ0OWpQU2oy?=
 =?utf-8?B?eXRLbUpaNHN2SFlNUTIvby9Bdkk1VzZ2THNpbG5BTmlrRzM1aTVWSk00bHNz?=
 =?utf-8?B?SjIxY3d4WnkwcnRiUjZqS3E4ZXdrU3A1d3h3aE1EbHJXZ0oyYmtpMDRNckpK?=
 =?utf-8?B?dUdkRnJkaHMvcWZBZjA3aUZVSVJhTHVjdXJhczcrWGZnV0tWVlV2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b1575d-6e9c-4282-51a3-08deb673614e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:26:20.6391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKo4Oe1PpTi8ComMAqkEgAvFxTc/NOOdJk1yai3sQ9gVqBSMggG5TVF5er6GtSrgRRhBPVs6SrU0eI8K59FAOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
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

Ping! Just in case this isnt delivered in the mail.

On 20-05-2026 05:40 pm, Sunil Khatri wrote:
> mqd_destroy cleans up the queue core objects like mqd and fw_object
> which are needed for any pending fence to signal properly.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index eaaffcdd6960..8cc3c8e7e166 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -417,12 +417,10 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>   {
>   	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>   	struct amdgpu_device *adev = uq_mgr->adev;
> -	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>   
>   	/* Wait for mode-1 reset to complete */
>   	down_read(&adev->reset_domain->sem);
>   
> -	uq_funcs->mqd_destroy(queue);
>   	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>   	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>   	amdgpu_userq_fence_driver_free(queue);
> @@ -543,6 +541,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>   	struct amdgpu_vm *vm = &fpriv->vm;
> +	const struct amdgpu_userq_funcs *uq_funcs;
>   
>   	int r = 0;
>   
> @@ -567,6 +566,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	list_del(&queue->userq_va_list);
>   	queue->userq_mgr = NULL;
> +	uq_funcs = adev->userq_funcs[queue->queue_type];
> +	uq_funcs->mqd_destroy(queue);
>   
>   	amdgpu_bo_reserve(queue->db_obj.obj, true);
>   	amdgpu_bo_unpin(queue->db_obj.obj);
