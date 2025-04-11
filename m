Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F237C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33FE10EBF8;
	Fri, 11 Apr 2025 15:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpOyE3Wo";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576D210EBF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlMDqrBb9FfoP2CuWhragq+oVCKV9KApb5mf4UZXiALPS1xPnSxAi/cMOh+kkoVseN3A7wPEC9SAdBdWxT+IkuQ2zCA676Hoy+dhdcSYZ48rAEjk4zbUYYE98PnAxx42uNt8I4Q51F97sCy+tw7EHnnXKPe3TkrsJbyAUiO+CKaz84PtqQCNODLR77kO/VhlXxAywBeR54W/sBagykwJfhu3QwFCsYDPyhZP/Xo8igMs3KoC5uq5kJaY+VB2NGkT4u1Z1s//QuMOGToPaHHaKYMpA1YSKvlcjbeKqUOPdXvPabLOJGlVcu7qZ+YOssnbVoxACC+eZ6exS4c7GI9CKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MzyVoV1O1rPT7gFn4S5nI31RzAg5nllP51gXHe1R7k=;
 b=seBQNYwmXNcELFT/aIiYJMQChEdaK/KfzOFntLGu7b4HwxNShuvLA2uohzWH297jN8YJ4PAbO8bWukyk7vXrDfUSnqqmgL7sv3c3UwgS2KBEO6lFqTJKLd6By02xDQdpFcqkkhYKAwgnkoVgsvL69MBZORsa+/B48PGOUcugD5Nqvdjz8ERECyRLtVge5azCPxwrqsSlVubBdQ3fnlwYXMD2U/FLHgv9x09QzgGQ/pWclrPQuPljKGC3OqXqXux9KdNP6rltyBdzGIu830YXEuo0eQzgDOPKOPR2LeJyFlgEQ4/0d4CZWH5nik6MlR33O9uYPwXvzVjIInIovidaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MzyVoV1O1rPT7gFn4S5nI31RzAg5nllP51gXHe1R7k=;
 b=wpOyE3WoheCM7ANkXNrthSURJvd8oDYrJB//+3K3e6y4RQzrc25fMJ7VjNYGkyiHMWFGGuUGs5yUHlY9kuY8j3FLGUs6QAyRJonjMqUU+bJ9E/vT6svzEoMheqU15dey4FxXasUZ/M7M5DjCmoPilpYmMXleDedLq4Okd/R4B/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 15:18:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 15:18:09 +0000
Message-ID: <7d868afb-8f32-45f6-ab65-e83b2540475c@amd.com>
Date: Fri, 11 Apr 2025 17:18:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add NULL check for 'bo_va' in
 update_bo_mapping
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a584176-f1f0-4b6d-e8e7-08dd790c1151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDQyYXc5MFdBNkpVVzcvbHpIVlF1NWhpK1hGYUp0ZVJudTVOdDNLejJTY0t0?=
 =?utf-8?B?bnNpVXBrZEkyQ21lb3dHNzErRXpQZURyZnM5Qm45REszYVg3TnpiV0pKYUVw?=
 =?utf-8?B?dVNhWEs0a2gyVXdoODlwbEJnT241dG1qMEYzZGVOMzFMMEhYSkNDMUkyMTdE?=
 =?utf-8?B?bUpjUUtucW9BVnFSMytjSWkzR2Z5UnhkejlMWEdIeTl6dnJXcDFyWENZbzJo?=
 =?utf-8?B?blpjdHRtd014d0pGYVJROExESEUxT0FnWGMzcHorTzgzd0tVNDdVdldKZFA2?=
 =?utf-8?B?TTZxQnVaL3pqcUYrVkdTZXBBSURCUzBhaVRYalhrWk4yVTZwSFg5a2dEQnN4?=
 =?utf-8?B?K0hZdEhiMUpQdDg0RkhjOTJ4dXFHdGV5UkZqeWpRTVVlQjZXUXVLQytNLytu?=
 =?utf-8?B?aStaR1pyZWdmVHFjZ0xQTjZUWVVYWk9Ec3A2bUJYRVBhS2ZGeXFvaG1CZDd5?=
 =?utf-8?B?UmdpdEoxbktWekZnZUJXLzZWZERMRWJmMmdEZ2doR3lVQlptZEVOc3hPYUtu?=
 =?utf-8?B?SXJ4ZkxFZVRnNkttbDJabG5kZTVKcFpFcCt6VHZXSU0rbW0wR1ozU3ZpcW04?=
 =?utf-8?B?U0ZXK3dVWFlBdjM4R2MvVllrTEZRWDA3SHJlczVFeTh4alMwdzBXbU5kbS9q?=
 =?utf-8?B?R1Q3Z0FxcWNBVzkydm9IOVY5MGdhWkVkMk10SVU1Y1kzMTdUc1BtbzMrRzR4?=
 =?utf-8?B?Y1JBcDJBRWZwWU5tUlJwQjRMdGgxdDNJaVkrU1pGencyNHJpVmhEMkgwc0Jt?=
 =?utf-8?B?TGcxdk5hbFFGYmpqZ2ZGekdodkZSTVgvdUw4YjFLRU5JWDE4cThmQzYyRFE1?=
 =?utf-8?B?c1UwRzQzMFZXLzBVMnpESEI2ZklGeTdNVzY1OFFBT29uRElIWEJJZlUwUzBF?=
 =?utf-8?B?N203aVJqUnhsdVg0YWt1Njg3U1JySE02R3NEK2kvckF1cjB3MDYwekdEMXJx?=
 =?utf-8?B?VXNMQVJJK043VXg5MTBFN21Kd0RCOUI3S1VDaStTMFg3STVzZmZOaXU5MEhJ?=
 =?utf-8?B?aVpoM3NKZGE0SmFJUS9DRTVOenRQcFBsRXYyai9FNDVSYkhHMXprQ1lKdkJx?=
 =?utf-8?B?YkZEcDVVZWREdlJGQ1h2bGJmWEhmUGo5ZzErWXk3YkRoV3YwRmRaVzBSckFr?=
 =?utf-8?B?S2d5bkgwS0tZV2RMRHFtdWtWTFZ3NldmUks2bmZOc2FReVRKR0Z2SEkxdEdv?=
 =?utf-8?B?MnYvenZGOUJ5YXRpcWxyN0FyVTJlQmJGREp3UERTWG5IU2UyeGVabDFuZG8w?=
 =?utf-8?B?TzJIRGVaSEpUd2QrYk1YMkVkTUYxb1VXK2tHck90V2U2VE1OZko1TkZ0bVBa?=
 =?utf-8?B?cDE3SWRYVlIzVmE0ZlJaT0ozTTVsa2s4SEN6NlRhL01QWFhHUG45cWNFcm1s?=
 =?utf-8?B?a2V5bzJaQmJIU0diN0tsdFA1RWZxbDhJcnE2QXdUKzBUM2JWYTNEUVlUbEZU?=
 =?utf-8?B?MndFMjRadU9ZZWxDdXd5Q1hFbTlQMlBsWHFad0taQThJNEYyMGUrWXRGelQw?=
 =?utf-8?B?SHBlNFBTcS92ZjVDcm13cU12NUt5cnJSMUo5dGJjQis1YXluU292MkhndGZj?=
 =?utf-8?B?ejBmUFZWYnQ1Y2Z0aHpnWi9MdE00S3diTDEzUFZ0ajY3THpvbk1NalFhSGt2?=
 =?utf-8?B?cXNNQm1LQytra2dHaVNVc2d6b2prSzZqRVplaFAva1ZPNm5maFcrS2R1Zk5R?=
 =?utf-8?B?UFVnWVRrS29uRklQOWRpRlB2TE0xUnRGL1Q2SE80a2ZSdk1EOUdDNGVSOUJz?=
 =?utf-8?B?b3pWWnkzU1RaeFF1c01ZeE41OEcvS3IreW5CS1MzbjBVWUtxWFZ1UXE4cmtI?=
 =?utf-8?B?bno3NzRkWU5CZnF4K3ZvWldPYlVObW0yY0kyWnpHaGVtOFN3TWJ3SW4xNlk1?=
 =?utf-8?B?bUY3WC9oZnZuMzBqVnMxQW14MzZiTlFlOXJ0QVA3TXFMY2pmTUpCc2RpYWhv?=
 =?utf-8?Q?ndsI/hzYJIc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdyVWhDVERpL3g1UENZSUR4WlZvUWkraFk5ZExGQW00UmFRcndBeE93TFpq?=
 =?utf-8?B?VXdQUE5yMnl3a2k3Uys2Y3NtTHJMWjlGSHVWb1VDZmFsU1N4bFh1R3RFcjl0?=
 =?utf-8?B?RGFMYnRvTEl4d2RZSVplWW5oV2VMeHdCNTFjWGFESUMvQ09KUVRWM2F0aStr?=
 =?utf-8?B?Y2N6elpMRDVJbXFVRDNVRmlNM1V6Rm9iQ2Y4STBnSFlnRUhOZ29HRTZzRW9H?=
 =?utf-8?B?a2E2RklSZW9iRHlRM3dMR3BnUUkvZy9kbVlXNU5TdTV1cGdqRXVLM3ZBcXJm?=
 =?utf-8?B?VWdJcVFpbGp1SEZya0o5WU9EYUlDa1UvOEtVaEZ3d2tnWkJpNE1aczhBMmFR?=
 =?utf-8?B?QlFrb0VOSXQvcm91TVVqMDhjT2Zya1d4TmE1MG9Gc2JORkZ5dTdrWWJ1Tld2?=
 =?utf-8?B?NWQ3cWJhTkFHa0pUL3MrS3cxLzRDWVhUNXduQ0FMTm5Ra1hGTXJQc2Rsc2F6?=
 =?utf-8?B?NkxwQnFXQ3ZSeDZMSWlhdnNhTmZLQVR6VnIxSVBBVGhVYTBhaTUzQy9la2tV?=
 =?utf-8?B?MmJ0SXpHaW5sR0Fac3dUOWh4OThWRGNiSEpYUCtDTU1jQitZT0dmUlc4bjhJ?=
 =?utf-8?B?bEVlMmRnVjkycUsyQzRIR241ekljVURkVW4zWC85bW1Wa1NlblI0NzhnbTFT?=
 =?utf-8?B?OC9DWnJTWlE4K1RiMXBoelhCRkZTY1l0dFhISTRGUGMxOUZLUnNPck9yVFMw?=
 =?utf-8?B?Ym1hOG11MUZTRHBaRVcvcUZjdkxsMTV6N2xQSHF6NDJSdTdXbUNiQU1QVUcz?=
 =?utf-8?B?VXVndkprQ2IzWWZlWXlEZVZjT2Y5WUdjOXI3MXp3REEzclJWeFowU1Z3Z0Vv?=
 =?utf-8?B?OFN5ZFBwREVKZ2RBOXcrTThEZldoQWpUajZYYkthNStlNys5NWVSNVRUSTd2?=
 =?utf-8?B?alNoZ1Fpem4rWTI1NHlCdWlFaEtuaWtmZ0paQnpJZmR0Mm1rOGNVaXFqazhY?=
 =?utf-8?B?bXU4ZUt4YjJOR25xbllpeGIrMGxkMlpIWU1SenlFOUwwNit3U1FLVzc0ZHFm?=
 =?utf-8?B?ZVFPeXVUWjh4VWF5ZUtLSTBERjBMdkMvNDQ0dE5TWXdydWhZNWJDWHZDanF2?=
 =?utf-8?B?VXl5OXZlb3MyMmFmTW02elhKQXcxRnIzQm8rR1hjbndwRmxiYVpiN2hEK0gx?=
 =?utf-8?B?NVpQMzl3N1UwdW4wK0wyR05YWmhSUXAvWTJnYjFGQ2wwZEFyUmJUdS8zUjFv?=
 =?utf-8?B?RUZCM1BvVzQwR2R2M1UyMm1GZVVlOW1NOFkvQzl2VUwyMXRBbDB3di9zdzNI?=
 =?utf-8?B?QTJYYW1CbnlMOW4xYnoraUdNQ3AybDVkMmVjYTBiTkk1eXlXQ1BkcGoxa256?=
 =?utf-8?B?OW5nOVE4RkxzMVZSSllYeVA5ZmhGKytQOVVVZzRqYjZuTzE2SzhzRzVQV3hO?=
 =?utf-8?B?cXd1d3k3ZEdSTmszS2NWYVJEUGxFWnZCdlJTbVllay9hVkFFZDgzZzJDSzc2?=
 =?utf-8?B?SlJxdVBVYnJVRW04aFBjZ1pIOVArNjBBcnJYa3Fxazhab0Jha0N4SnpZeXVr?=
 =?utf-8?B?UEthY2dOdSs1V1h2S3lhZDY0ZUdpcndyQXF5aTFBd29ETXlPbkc1RStQaWIv?=
 =?utf-8?B?MVFsdmdlLzVJZmpXcDZBV2x2QjcvMURmVkZyRWRYNzlJRDVGM0ptVlZMOHNL?=
 =?utf-8?B?T1Y5THdHQzU5QUdhaWI1YXZKWFpORFo3ajM0d09mcWhTM1pxVzhheGxYRDdQ?=
 =?utf-8?B?MlZheXk4RjhYbTMzNUJ5bUR5SmpPZU9RLzB3NVNuNVo2SWEraUR3Wkp1d2VQ?=
 =?utf-8?B?NTl0c3dFMHNsRXFacDlHdWxaKzFXZGZ5S3JiOUlVRVVyQmlBa1d0YUVpWUx0?=
 =?utf-8?B?WXlwYmVBZjdXS0Njelh6VmRWSkhTbXQzc3B4MURHVVZJMVY2a0R0VE1TWkZZ?=
 =?utf-8?B?US9XMmxvM0pid2hZdGJ0RDVJMk5VZGtsTUdtcnozWGlrZGJic09ZU1FEWm9p?=
 =?utf-8?B?Z2xWR3QxaEdycFk5aXBWdnBxK3p2aFZzblZiVDQvZ0U3c3JTWndleTVsRWR0?=
 =?utf-8?B?OWJoZ2daZEFGQ0Z2SUZ3VSt2aGlheTZKWVdHRkQ3ZFdXcCtUb244czBmYi90?=
 =?utf-8?B?ZEdyVDBhdEdveEphQkdNM1BSRVlHdHl1YTRCRU1VRzNUQkJMTXQ1MDArMnJG?=
 =?utf-8?Q?9lU3vLiO5RbBLy0zRAecpZK+Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a584176-f1f0-4b6d-e8e7-08dd790c1151
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:18:09.6385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0dUMgCDaekBL8Q4hG6KhIJ0sfsnIxwXxQZ4IPoGcBJDwSKoeIwDMabNYglQP0eV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
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

Am 11.04.25 um 17:00 schrieb Srinivasan Shanmugam:
> This change adds a check to ensure that 'bo_va' is not null before
> dereferencing it. If 'bo_va' is null, the function returns early,
> preventing any potential crashes or undefined behavior
>
> Fixes the below:
> 	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
> 	error: we previously assumed 'bo_va' could be null (see line 124)
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     115 static void
>     116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>     117                              struct amdgpu_bo_va *bo_va,
>     118                              uint32_t operation,
>     119                              uint64_t point,
>     120                              struct dma_fence *fence,
>     121                              struct drm_syncobj *syncobj,
>     122                              struct dma_fence_chain *chain)
>     123 {
>     124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
>                                   ^^^^^^^^^^ If bo_va is NULL then bo is also NULL
>
> 	...
>     135         case AMDGPU_VA_OP_REPLACE:
>     136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
>                             ^^
>
>     137                         last_update = vm->last_update;
>     138                 else
> --> 139                         last_update = bo_va->last_pt_update;
>                                               ^^^^^ This pointer is dereferenced without being checked.
>
>     140                 break;
>
> Fixes: 16856d135622 ("drm/amdgpu: update userqueue BOs and PDs")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index c1d8cee7894b..247fbd014b7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -134,8 +134,10 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>  	case AMDGPU_VA_OP_REPLACE:
>  		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
>  			last_update = vm->last_update;
> -		else
> +		else if (bo_va)
>  			last_update = bo_va->last_pt_update;
> +		else
> +			return;

That warning is a false positive. The bo_va is only NULL on clear operations.

I think the whole switch/case here is superfluous. What we should do instead is update the fence in amdgpu_gem_va_update_vm() instead:

        if (operation == AMDGPU_VA_OP_MAP ||
            operation == AMDGPU_VA_OP_REPLACE) {
                r = amdgpu_vm_bo_update(adev, bo_va, false);
                if (r)
                        goto error;
E.g. here.

        }

Regards,
Christian.

>  		break;
>  	case AMDGPU_VA_OP_UNMAP:
>  	case AMDGPU_VA_OP_CLEAR:

