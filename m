Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A33CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A20610EF65;
	Wed, 20 May 2026 08:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EU6u5jBd";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CBE410EF65
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgBbkMTka2DBShWLefBckPESimP6uz1AsAq+sPANC8SGRye1eES/9kGsTe/WhQRaV7p717Tgj4Yrgn+RFxHCCwgleImy/UfVod4IsyVzyHa+ETMwX/8T3C03Y22p+JRZsbzfjTR1zmj6XT7I5W7dfcgub+9krY2SwbKsfsV88mZrbQwfkZD7d4qW41F3cO9X8hMa2peLBEhdT7BYHe5Gf+NpecmpshH1z0QgsZYC+BXhGZojx6zgPxpitA9NcnwbEse6eWlfR94s/3bLA1SterfXf+QTscxDgd8v0Z0wkRrC3osCvLaV05exIUd9v0wOKCj4ZZLKf4tZ+y6MXSv36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hoh98q4qznGHb71Y4IG/6RfZ6Ee8GG+RNXMgBGfjC0=;
 b=YT+JKmd//xHur62SaY7lFXtg8G6kLyzgxr7dVjDfNDwCYb6m4vIighg6LRK82ECQWn5a26SI1TZR7sR+/nUFMEupQ59KT94ODXQ++5VMyQW3ZBwQEmWZ9qNPoEyYComXLCZsg+AmkzBdWjgG5rdXQqqnj1eUt3M0riYQMEXyw7Si6kIx4RkqPt2blUiRKGPm7qWLh+6ZbfejNT1TUyva858dYOXaLrRinju+WuYLn74WjZSFwrRN5IdSrS2Um+Rx0bIl4tDIKYtW9nz307I4yIKPIR+lmTy7hUB1Ma8rYUUUr94DTX6SKqs/po6MyuaAB9HmXegr9IP3vH5Ri7GyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hoh98q4qznGHb71Y4IG/6RfZ6Ee8GG+RNXMgBGfjC0=;
 b=EU6u5jBdNwjTyOEUkkyeujkQkFRo1l9NTxEnnbE/1QgKCGJi8jIuDYHt7VBA6GYeS8a8d0hyY7XXBxDfuu7fi71qY5nXSW+4Xhf5X44NEC4WOop0+aICsd8MuPVn0ySmA1dxc5DDfqxLAzyznq48cyb1g1h9raFc928Egjon3cM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 08:55:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 08:55:14 +0000
Message-ID: <508fac40-c387-47fe-aab0-d9bfadaa670e@amd.com>
Date: Wed, 20 May 2026 10:55:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/userq: clean amdgpu_userq_destroy_object
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520025258.1866776-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520025258.1866776-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5e337-731d-496d-292e-08deb64d81b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: s2mTCTZF7R9+wrqvtyGVm8vbFM9ZcMNqiP+6gfMlddtt9o8BUmvlksPceAKFY8uOvfod4L7yUik3M8pqnaFTgboCKTdPjANnZi3YvnoClPxuECQxdqtYLZqqaNf7/knxTy6Lt4w3+vZ6guJL6hggMRlpr20HGdDWm5wUc7DuZ2qW15XIksNAav26rAeUGZhvP4XCdhyLoWD6CIxKW+O+t1Uj+EHIQJfnlcaZXjYi/hGgvETEUA6JU2fp67/lXFOpv6ye+HhY9v/MOFS0fY0OWg1q4OtUwKBJqWmYuLsJ8s//nu0OaO1H6JjkwwK5wxVA8dEdsky3qVEeGrFwrONaftBoWV2I4KTplzeVEc98i1xZdGDIDmtCwHvIkLmb2YM2CKyCu2d7dJXTS8/+D6ug0ICapRajjL/2jo0JJp/YsOeJmNHkWd6oqzbR0mByI6aOVhyHdbqStqA98sJ8ALRKuedsj20ehrms0RZKlZRRSB66VZ9gFSlXFCaMi2YnrNPhp3+Z7fkH0jvS2og7IUmS0zOLLpgJOuy9vgFxzyRPxMvudKjp6suT48HQ3bi2+U1zynSx42hxCqJFrtkGjI1lMMT6QuaBwnzMQYmWyHJIAFXB6yhQ8weUOxKXf6zMWKiDqWyYO4xl9jX7CQil34L2hFadwcW54JSqT/yTZchQFgoYRHvUb4J4eeMomJPPhjER
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aExwRGl4QWE2NklPV2xHRktQTHZIUkdTNy9LaysyK0lzaUw2aG1CSFNzaW0w?=
 =?utf-8?B?eGN6SW5xanBSYitMNFVFY3hwcU96TzRiVHA3TG5aczFXTS9jNmNwNXFRcG1v?=
 =?utf-8?B?ODNXZTYvc3IzUURaa1BQQVBKZ1c2dGl4bHdZQzJNbUV1UEI4YkRWZnc3Rk42?=
 =?utf-8?B?WFkvZVA5Rnp1alVWQzVXaUozUzl6SUxYSTR1WTVWemMwMlA4WmlwM3V2VS9V?=
 =?utf-8?B?SmxNcmpOOXEwK3hOeXRGS0I2Ri9Fb0ZlcFFVbzlDVTVCM1l1ZDJXaEphQnlB?=
 =?utf-8?B?ODlEWk1hcXZ0aW1sRUxrWHlZMHNPT2djeml1aGtFOVQxZ0t0MUVESkVJV3ZT?=
 =?utf-8?B?RGZVQkF3KzZIQkQ0ZXZDNlhia2Nsc3RzYnZSUW5IbzkwVjNCQXBGZTlaRzF3?=
 =?utf-8?B?RS80YnFpdHZiRDZvTUY1RUM1UjF5ZzlKc1NhTFo5VFlkWXZ4NjRVTGRzU0ND?=
 =?utf-8?B?UG9JRWNySndNWUpzM0NSTGFPU0NPV1YwVndBTEhoZ0xJZUlTeVBkeVBGN0F5?=
 =?utf-8?B?TS9RdHJoQUhsQTR5VzVVUlVhSHlSMVNlMXhRbmt1RU9iMTBnVFI3SmJaMzlH?=
 =?utf-8?B?TUJ0Uk5jamNOb0JKdExiZzVtNkgwMjRKSitNUmtDTGVzamVWRHdiRk9VVTly?=
 =?utf-8?B?cm9sRlAwQnNLR1F5VmYwb0Q0TWplMm9uZWpEMzlxY1RVTmdjN3FaNU1Wb0xN?=
 =?utf-8?B?TlpQaUZwakZ4Wjk5N1R6aGk1YldLcS9TeVVjcUJmYlc1dy8rb1dFV1RQcElv?=
 =?utf-8?B?cG53UUtDdEE4R1k0bVBCb1hkTDUzdWd4VEJ5enF4Wmppbi9qYmtHcVFWVlh6?=
 =?utf-8?B?U1VaMnNPM2NycUg4K2FyaDcwMjc4cHBNOWNBRjlzbjhBRWlPUDR5MG8xTUtJ?=
 =?utf-8?B?WnJ2OUFxSy8zc2JzeFh2V0Z0VS9RS0I2ZHY5WEVGOTMzMTV0MG5FSXEyWUhw?=
 =?utf-8?B?TkFYUVF4UklkUFdtNzk4dWRWWnJ3dFhDOW9tK2c2UGZWeEkzbHl0R0o3MExt?=
 =?utf-8?B?ejhEWEtqVDd6bVdhUzBWZmR6a25wcXdNSVo0ZjFtYkNtd0JRQlI1Smh0cmRt?=
 =?utf-8?B?RU9wVC8wbVRjLzBGdW1XSi9nc21KQnlpbnp6OW5aa0lwM3JRdnhLekpFYzJP?=
 =?utf-8?B?SnFhQlhTbUZvMG9ialZiVFcxbXpIMlpxdTU2eHFKNEVRZVdVb2xKc3RXOEFB?=
 =?utf-8?B?TjU2UWVnZWtDMmIzdDRTaTV5OHFCOVkraE0wdnBocGdCdXl1bndQYTB1Wng2?=
 =?utf-8?B?NE5uOVpOLzVLMkt4eUM2cm5UNnB3OHFUbEpkbWU3WHpvWi9tMncxSlgraE9z?=
 =?utf-8?B?M0lTWlZZeFdSUDczTHNLc0lBR0JMdnBGbkJmQU4rZlZZWTJCZDQ0NG5aemxm?=
 =?utf-8?B?eE84Y0wvNmk3dTd3clFwWUhMWlBGQjNPL1MwdGJra0I2dE1uQ0w0aS9UbTZJ?=
 =?utf-8?B?a3A0QlNhNkFIQnNwSm1ZbDZheDJoY0F0YmhnUk1OQzhLaUZQWUtSbnlWR0lB?=
 =?utf-8?B?NThwbXV6alpvdnZ4TkpiRXZ4S2FCYVhDWFNVeDF2cTRvQ2Q1RHdGaFhzRDZF?=
 =?utf-8?B?clYySlVFa21XZXlKa0xQT1hqbXc0R0lWaVB0VUs3ZG41UzV0TDdLMlgrYUhW?=
 =?utf-8?B?WjNCWTlWSnRJUk0vS0ZZbHdTQTc1LzFzQ0lJU00vNHFDenNhaUdqTHJxOWNO?=
 =?utf-8?B?RnA4K2dqcnV3dzZEZ3cwanFCZ1FnbUo3RUpWeEM3WXh3bXFvb0ozWGVuTTBF?=
 =?utf-8?B?U3h4eFNxVGdsRDMxZGcyYWxyZFpPb2dWNmI4NW9lZ3FyN2xnVjdlRlhGOHV6?=
 =?utf-8?B?RGtPMk9mN0pDd01WQm82TElkTU9VNVRxejZOV0RjbGJpU1RYV3NINEZWeGdC?=
 =?utf-8?B?MmVUbU9WWlBmUXJyOEhyS05QNmFzWFJsUk01VFE0eFRiRkZPazltbUdzYW03?=
 =?utf-8?B?RTBOc2Y2VUhQeElNa3JBcitOZ1dyNWRBWmR0SkVqelJpTlZGOTBnakNLYzBX?=
 =?utf-8?B?eXFNcWRONGI5TjVhQ0dJeEVJamFEcFRMRVlYRmlHb2p5RzFNTGZxOS9FaU53?=
 =?utf-8?B?UU9Gc0RtdEIvNUl1Mi91K3pDV05ES3MxVzFrc3k5M1ZjQU5WTzRzTHkrRmRa?=
 =?utf-8?B?NTVpa2lNWTFMK1RhTncyZ1dtUCsrcis2QnZEOWtxWHFrZHh4NXJoRGk1Nm9v?=
 =?utf-8?B?MG9MTGprOWlqSnc4bEttdEtJOUgxUDVCenVGSSsweFNaTHZTVzJRS3BGNzhL?=
 =?utf-8?B?bm5yWWZNUDczZVJYd0hHTmJub05GY05sd2xZOUtCL2NNQmZpa0x4Sk9MNElj?=
 =?utf-8?Q?MxaZyqnGnmZiBS2e5+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5e337-731d-496d-292e-08deb64d81b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:55:14.0490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMqXIy2R70m7P79+xkm6a3Prh2IqlbJQLUJo5ylWSVC3HVZKheznM2qYjCkcLqit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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

On 5/20/26 04:52, Sunil Khatri wrote:
> amdgpu_userq_destroy_object does not use userq_mgr
> reference and hence cleaning that up.

As far as I can see the whole amdgpu_userq_create_object() and amdgpu_userq_destroy_object() functions do the exact same thing as amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel().

So it looks like the two functions are completely superflous to begin with.

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +--
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 10 ++++------
>  3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 798998d65e17..0607b7078518 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -526,8 +526,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  	return r;
>  }
>  
> -void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> -				 struct amdgpu_userq_obj *userq_obj)
> +void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj)
>  {
>  	amdgpu_bo_kunmap(userq_obj->obj);
>  	amdgpu_bo_unpin(userq_obj->obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 033b8a0de6b1..fe89e35b0d85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -155,8 +155,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  			       struct amdgpu_userq_obj *userq_obj,
>  			       int size);
>  
> -void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> -				 struct amdgpu_userq_obj *userq_obj);
> +void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj);
>  
>  void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 2d95203ec58e..69b36ebfe7ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -432,10 +432,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	return 0;
>  
>  free_ctx:
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	amdgpu_userq_destroy_object(&queue->fw_obj);
>  
>  free_mqd:
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
> +	amdgpu_userq_destroy_object(&queue->mqd);
>  
>  free_props:
>  	kfree(userq_props);
> @@ -445,11 +445,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>  {
> -	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> -
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	amdgpu_userq_destroy_object(&queue->fw_obj);
>  	kfree(queue->userq_prop);
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
> +	amdgpu_userq_destroy_object(&queue->mqd);
>  }
>  
>  static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)

