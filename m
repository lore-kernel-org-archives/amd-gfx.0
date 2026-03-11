Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EFDFD0659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B11710E3AA;
	Wed, 11 Mar 2026 08:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhXvyJWY";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493B510E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 08:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgB11GtcSpe1huRGhF2huAYeWzXauc0ZvJQCo5QcQ0odw/nevzZJYj47dn0B4zjSy/5wmwFoY8sUeNBHUTZcI1IG4YrEH//IS1kr1RHiaqp/AfpanoCcGGX9c5A1YycVttvTeHzKBcjWYkVr/N74rqfdJsl1LKEXHgUhUWCj8PXmuq59xzaDh8vi/jyqyB9P20Mu87MchS8R9W+CGGusuoKBGEllKwKKGw3qAUYmbsTwv05pzdFpKsGuqlJ0FC9P3X7HTUo2I0iGc+WhmYwZQYl0CD4RgHUNLJLwbTN+UPfqtzVM927WM/fCbzhyUO8bToAU0jYDBvh9dxt4RM9syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFtI/ukEUL+Gsb8kHOC0wTkR4Paepkkd7wzpHIMDeVk=;
 b=nzefGAuJj77by2Mj+KGbPjt28ozR91VvfmpAI2KlIq24mKJWOkqHpUHY0R3YfLPE9jbcu565xwp289cvlvKdmBpJuqMVF5DTmuCeygcf1PlK//rvdQhWK58TjhGPiB+EpGTw/xe0TTpRb5HirQh3DvVaOt7iLPSGzVHym+Rk+m0IUAcHGMb3Ou6KEi++tWVWA/Pcds+6bFT1xkvG6S9WKnIomp9UsXZbtpDqqUkOhT1vdBCMaaVxBpmqrh+YKKBMrNABY+IMuwfE/N8XuEHygV2lzURAn6PpWtEupKBbtL0n4hn3YvoXyNCiCkaUT08/mIT+Qsf20RWWiE7bVI6e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFtI/ukEUL+Gsb8kHOC0wTkR4Paepkkd7wzpHIMDeVk=;
 b=yhXvyJWYzJeDjso5VRY4L9CHOqvB3kkPgKwxrT9c/ZGVlPrjdnIVBXNGmlonk0xl7p/zex1QHuLy59d04MvJH8LsmD2dix8Kfda85B5C+Qm5439hu5cEN4hLViu+fwMOVkD3sQ+zHv2jsRT/P067RvYZfzBBItosW+KFvB5VrBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 08:51:28 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 08:51:28 +0000
Message-ID: <c9968b59-949a-4402-81cf-1e665c7af51b@amd.com>
Date: Wed, 11 Mar 2026 14:21:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu: fix amdgpu_userq_evict
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-3-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: d26b00f1-533e-470f-a364-08de7f4b6250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: TIFvZGfLEr0RMB4zZ0CJXfZuK3udwf79qquz4eG3toO4F1yrN/RKsgI6DOgnWbE6fG6+5r+1dTCMMY2vBCC9YBPv/1kbO2VaJOTxTx3a+goB9nG8cTDgmz1/5f7JfBY8mZxmCVs9PRLPb9FB3nd8UVzZlqnLWOnWxp7cnhR97Do0iiJNtPe7uEq9gwK19xM4yx4+t4XqSTseYDyGYGFFVBicZP2MJ7bfFJIFLNmrzZotO9dmJer33zyAQkI1XvnihFIZAzkNVmmHVM7dmXp2UWbSh/0DwYFxab2mT4zBXk2rsA1jy6mWM3VmEYurRaH0WyHO3K2ctoTL1Am0BOaK1iIMNa2K0Z1mufWlTyLLKpkMBMQ9jo3V5mNPiR41wEFjj4Hx/CR7mNYM5hMglK25c2ai61Rk9UZ1kZ4LrJwvVxN7nAF7qJ86LeRFrij51PY41tDQK14JG1eaDCLrcazUtnMseDEp345rtuZW8D9/rZ/4bpypzZoigrb9Yy4SKtxoKME2LaHPsTUy/OgUf5Rkwy2BRuElnGg07Z3M83jbwQ8Iom+prY7v1SVdA9TXVtCMUw4PdAGwiC3eevbEWqdsDI79e0FLTFCYwZGqx6G4NUejZzPvL+rWXJBasWWgGRf2n+QMHocdJAAfGOOxADyEEzOwSlQS2swuqB4T/KmELOc9wZoZTz6yuiZG6n6Lsor0HpMO7G+dzgGQHV2jo41Fv4by678k+JLWfobFhVgUFTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjRHOUNGU1Z6SnNuTVVHYVlTTERuYW9zUWRSVCtmRjRDZnlwdUNqWnBXZ20x?=
 =?utf-8?B?b1RJemhBYTRNZWJYTEptZEg1WUMwdk41UG5zNHBiOEdhU0ZiYWxVWUhTNEZu?=
 =?utf-8?B?YW5VSDVZUldiakI3QnNXanFZVE5kQXNRWFh2cjdMZElwaGprSmt4WmhyMnhn?=
 =?utf-8?B?UTMwcFB2RWY2dmdVQXZCQnVFYkwzNmhOR2k0VmdyNGZENTN0Syt3N2pzd2Qv?=
 =?utf-8?B?L2lld2lNUkJSNXljRWU5V1ExOVRVS0c3aHdvMTNyNWViZGthMnJhdXVtK2VQ?=
 =?utf-8?B?cnhzQkZxUHdYeVF4MGtUdXBzY1EreU0rR0YrMUU2V080UnFSR2ZSUnMvd3lq?=
 =?utf-8?B?ZHhZNkJJR2VrTkUybWxsMkk2RGc3c0lhK29mK1J6Syt4SUhnUEtuNXNEVDhQ?=
 =?utf-8?B?a29CMUJSV1ZmNDhLTTN5andmc25WbGtYNkwvSWtoeXpZc1FmelhMY3N0Qk03?=
 =?utf-8?B?QzBadzV2QlJTL3YyM091TWViOGJFcDlxU05IMkdZSjEwTEpkRkwyTzNmRDh2?=
 =?utf-8?B?aG9tVHJIOWR1TTN0U0diNHEvbU8vb0xncEhCZEFEa1NVR0NHU2NzMVlDc05i?=
 =?utf-8?B?aW1ITG1USzJzamo2bmhqRHVNaEVkK1gzNWRiVnJrMmQwRS9RYlZDeGtyR0Vh?=
 =?utf-8?B?c2VMUExHY3A4WG1ZMzZCS2l2TlM3MzdxNUVvL1h5L0duM1hZYXpEakJ2Z3FM?=
 =?utf-8?B?S3RibXVvckJQVHF1c1ZqUFhlbGV1L3k4ZmIxcFRkSzlhUG5hUUw0Z2FxbFNp?=
 =?utf-8?B?Vlkva0FiVkVNci9sbFI2UWFmRTR2N0dSZW16MGtsNmZJczRDVEZDb0Q1aWVC?=
 =?utf-8?B?cFRCYmlFemdML1psdDEvRFRqRGg2eituRmxjTitxSS9nZWpXL3ZqUVRJZHU1?=
 =?utf-8?B?cFZJdVpnamFyYU1nRGVOM1lWcElWOERnT3d2S0xzTTY5S0dkbFd2L05ESyt0?=
 =?utf-8?B?UHIyVmNiUUJTU3ZibU1QUWxZTVBsYmRHNEV2N1BqeEdqVlAvVlFsVlJYeE52?=
 =?utf-8?B?WVZvbnFIRkdUWitTdDFWQ01NSFltSnNkSml2U29UTWFwWkgyNEk5aGk3TmZO?=
 =?utf-8?B?RkZUK0pSQ25EYWJ0WlFvZm5iVTlXcEM3MktrZldxVnV0cDhZYzBWSjd0ZjZw?=
 =?utf-8?B?dDlseDY2QWFxVVcrS0tmU1hrVU5DaGJYM2JGODhMdmFEL0t4Sy9WWm9jM1N4?=
 =?utf-8?B?N2F5S3VvcithNVl0MmVmNHdLc1l2dWNiYmZpZ3p4WGJRRG1zZEl2ZnhVcHpZ?=
 =?utf-8?B?bEM2d2lGL0ZPblM2ZTN3d1M0cCtBVitEWE1xVHNBSnBGVHpZRFB6L05rZ0xw?=
 =?utf-8?B?TjJBdGQrYlphWm5GdzVYZTd5VXFyQWkzMDRlbXRxQ05PQTByUDFVVmZMVGt6?=
 =?utf-8?B?Rmc0Rmp4RDBCYUgwU0xuTkF1TVZhSjFjZEQrVWpSR2RTeVVGTXhUNTlqcU8y?=
 =?utf-8?B?UGtkSXRJV1pEaFJzcTd4WXZMYlBaRnZ2QnkrV0s5UUZvRms0L214T1hjNlJY?=
 =?utf-8?B?MUtVdHFnaGlsUDlxbnpLWktMM3Y0Z1NKMVRRYlVIS0h3eitKbjNoU1EvczJB?=
 =?utf-8?B?b1YvL2FyOUgwOUV0NmtMdlV0R3Z0UTB0YnRJV0dNM1A3dmRBV0huRTM0cVBv?=
 =?utf-8?B?dWRiM3BWUmZiQlpYeVN4dVN1V3RTdUxSTkhCQnFvTHV4RWMvaWczK05LMmsz?=
 =?utf-8?B?Z2g4Rk84OFBRMnFFYzQwZmJ5NFUxVkZsREFCeEpUSXY3SGVxMUtpUUhNZytF?=
 =?utf-8?B?L1FjOVBEV3Fxay9DZVI2V1RJNWRiSUE3Q2xIWU9aRXc2NWp6cVd5cDZHa2tT?=
 =?utf-8?B?TU5yd2c1eFBRMlJ1ZlZBSUE1WE9YMitLdFRQTllXREk1eHk3ZGJWcmMrdytj?=
 =?utf-8?B?R0J1K2h2QmNqRy9qZ0FlZFFqV2s1Qi81aEVRSDZyeU1iTmZUWkdLTVQzYTJB?=
 =?utf-8?B?V0VQbFM2ODdOTkNTZ3cxT3VYT3JNZTFnRG9Eak1xclpDMmx5MHhiY0VyaWNF?=
 =?utf-8?B?QzR0RkZEZllmTysyZlpqak5ZSm92MEpCVmVsZE9EaVd4N1psaS9xcUdzTndu?=
 =?utf-8?B?RklKWkdGbWxFRDdUQmZQNVMvNXdZQ0cxU2wyNldHb0xYOVRlZ1l3TERad3RE?=
 =?utf-8?B?UmdSVHJGcnNnZFhGb0xtd0JKZDYxQlVLSHVEaFZrYTRiRnFDUVVHdjRyNU1t?=
 =?utf-8?B?RVRpUm5BMmhWZFREdVYvWTk0YU04elMxQmU5MFl6NFFYSVV6QVJ1bHI2Q3h3?=
 =?utf-8?B?eit1SEpKcU9QWnZIUlp3Ull1STkvc3VDMnhpRDF5dlJIbGZNZm1EaC9RKzhM?=
 =?utf-8?B?ZGI1SnBIYXhyZFpRenRkeDhZN2hiTVJOUW1HNmpoZDhkS3NHMFJCUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26b00f1-533e-470f-a364-08de7f4b6250
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 08:51:28.2961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vMWzdRz++69dP0vPnqEctiF6d8gA5PJ7Xv9Lg+AsxkRzG7ZkZyoe97+FLo/aTuFZAKnUqvJ8nrjzVYCJzZNTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11-03-2026 12:43 am, Christian König wrote:
> Canceling the resume worker synchonized can deadlock because it can in
> turn wait for the eviction worker through the userq_mutex.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 65783f9584c5..85adc53eb523 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1331,13 +1331,8 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>   	/* Signal current eviction fence */
>   	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
>   
> -	if (evf_mgr->fd_closing) {
> -		cancel_delayed_work_sync(&uq_mgr->resume_work);
> -		return;
> -	}
> -
> -	/* Schedule a resume work */
> -	schedule_delayed_work(&uq_mgr->resume_work, 0);
> +	if (!evf_mgr->fd_closing)
> +		schedule_delayed_work(&uq_mgr->resume_work, 0);
>   }
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
