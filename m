Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BB9CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 08:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CB410E5B0;
	Tue, 26 May 2026 08:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uPO+YNMq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB0010E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cilcrDclYPJp0rkd1f6d7hgRdZPyKxgxByytAHOWzZj1y4rSVzEvnj2l8yIq0BOFfwrtf8IdEEHRwBB5GBQD8ylCgmFNaIQPv6c+eSfrqpGz77IKrhe8XI+EXTXsqMFPR+2x6H7lpdg4FU93n6PBMEZH7pMV3ezXICTyHUEkoNxiYioqBfz7Y15NqPGlga2RM3wyNg7fuIk2sYURJtvKekM5aXQPlseoLBoEmyRiFSfZVzsyJ92lY5jIWJeDBY2o/PF+VXybVePLTQI47SCLC8J026sUAHlbOjMBqjVhDXwDaoQpEOc8Y+4zAsOJhaMWQfO1cdeBy4KEYHjVJE2Z/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+BVzCZ0A9s6DnjPi1pAO/bA+LMufCv2gchEwagg9MI=;
 b=c2rm5WhqkJ3Bxez5iIVhOoaePGqCPLKckBKHTtdBdLfcam8RnGuk/fw72wjm+wdG7H2V95tfB+rO2DMkv2xP5hn0ZQ2HWpAbUzYwNHlS25nxw4jIuolk8HuJLVpDVrI6audL+vYWVaRl56R3UsIc16Acm93WaR7R3QGFW5+eMKcMDI+hkskhu1j8hIale6ZwEE0y4pVgJr153ZwhCFmxij6WECkGwiCNGvTs1OsznVoHyDgTQPziczCSOlijpS7RrXR+erVLbFO62NVunZqlXxyWSFQhOnc1yDuK3Tb3Q64IjXUozqINdyjY/lVe3WBKwbz+MrjSSIXB2qFJOv/oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+BVzCZ0A9s6DnjPi1pAO/bA+LMufCv2gchEwagg9MI=;
 b=uPO+YNMqUPRmdglnLmUObg2bRmbN5daZbB+YhRFecM5RaQNWQBMboHtq3QJWgZ19pI+snHsM6TEnpM7VbUIxcYTumhKDxnIEgGHwb730v9yDXjzeu10smPwrgqCkE9xBgGqfY27Q/sbHPsQ8sDJ8qmEiNUuFH94BZp61+8XT/As=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Tue, 26 May 2026 08:07:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 08:07:59 +0000
Message-ID: <955af9cf-797c-47b6-8344-bb7e784e625c@amd.com>
Date: Tue, 26 May 2026 10:07:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: Fix amdgpu_bo_move() when old_mem and
 new_mem are both GTT
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
References: <20260525113321.17953-1-timur.kristof@gmail.com>
 <20260525113321.17953-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260525113321.17953-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:208:23d::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cbd4da-36aa-48de-01d4-08debafde6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OnJcwv4zMtBJXtovm7m9w7TgIuFP5IKawCA+rwL/mSfTj5FLO6fA8Ssy4wZwwV11PdTw/hE6Ja3lLucdED7PLSAXol2/btsmXunHoBr/qn32jkJyxgeQFVGY5zU50tZ3qa7q1dLXIRa+ptghSqObttRu+rYVoXvELnZPDF+SZd37oy6cRX1R9qVMNlOYZKiUwKjQWwTHBCN9+TeESHauk43wChZ+tuFf62ccuujUSaem1/88Kf7YBQas8A2OVtKUMxzQGbqNaIO4loSvcn/H+nz52TzvlLEbcHSQkc6PmH1kHcxoWTPBysTrXYH11y445L1VLvMOkqxlj0bO3lFO4jrMBOUNMTGtc3PWS5YouUkc6FGGhg6j1cjPmAzFECLPFOKmX+FxcNOt988FmV/bArtla4TyIx4jR+T4WWV10d8CqX1WqmYs4Ndz2zS06eZUlmB4cXNOYlYJPJyl7/5Sksi9MRQgUgSVoc1YR2kDMp58fTrq8pKgjlmdQscEKf4Xlah/cmCLnPovfvbXSAc/ZZatacMSsjfJU6qiP3ktXxvG+X/kO9KS+6jEYpBJU3+d8rZCiVfu/49es4ew1aDpYlYSzditwpSVFhJbaROcpwVznJK0EyeSu5/OscerO5dUDlxKNaaBbRhqCkGyQS8PKjcpTKOTMJPUySX1uoZA88PHnSlHRFOnr3033S/auJFP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJlVklWd0YvTU1IQmdlTTIyQitvQXlJY2I4WVljV0U1dnJERjFtUUhzZzFo?=
 =?utf-8?B?eXFvSUExVHh6V3BaY1RzcFRRY0JkZ1h1QjZQZThaaTY1cmdIU1hSWnZNek9Y?=
 =?utf-8?B?ZGtyOC9ZZVNrRWdSMmlDYnMwby9WRzhVMzhOYnNPN0Q0WnVncXJWaGRtSU52?=
 =?utf-8?B?WEJLbFNWQnplUXZ0eGFEckp3SnlSWkMzR29GbURnNkJBUlFNMzVsOVFtNzVI?=
 =?utf-8?B?bmRxbzBYb3VWbGQ4T3RmREVRTnNXVWpJMkxKbWhqSTN1ampqSENaQlB6SzVq?=
 =?utf-8?B?VmVNL1F4LzVBb2hsYlIxbEZLM3VONlcvWmlqUHNyZ0xqL040Z1lpWTZZSG1r?=
 =?utf-8?B?d3N1UVpSenJVREd3NGRRb2dXRkxDNnVWQ0tadEt2akJReFN4bkh2U0lGZ0NV?=
 =?utf-8?B?M1pxU2NMT3AxeTlEZ1pRTWVtZlVmQXYzeHhzRjRBMzdCWFRtYmVqU3plUzdT?=
 =?utf-8?B?Ry90UmtKeGdSRFFHM2FnWTBZUmR6QUJkY0JOaWVXMEhzZjBPRXpUQlhlenBt?=
 =?utf-8?B?QS9nK2Q4YkoxdjU1eFBudS95VmRrRXlGSUNtVWR5aTNKVERVSXUrTnlaRkt1?=
 =?utf-8?B?aXZCcENGTko1MU5aMzdnWGdOTzVTNDhGcXRFVnJ1bWo4SGtDRjBmMkVGYVgw?=
 =?utf-8?B?aFgwRStsTmVJQlVlbjhRQ2lqcDlHa0VHaFlZY0paTW1MVmtQQk85azNJMzJi?=
 =?utf-8?B?QkhSN3FJTVowTDdJQ2oxVjErSFVNM29QcHp4b1o2ZGRiUVd1cTdYckZlOUlI?=
 =?utf-8?B?R05kcTJHNHgzOUhyZk1IRnBKQlg2SGFvcFBMN3NrU1dNNXNHdDNNTEFyaC9p?=
 =?utf-8?B?WkdEQnpIRERIL3pMbXp2Q2FmWitTMkswNTZjbXo2V2lLOWdXeUh5RjFyMzBx?=
 =?utf-8?B?QitXSXVkM1ZDdE9sS2N4YXhkUVV2ZmNsVlp2bXIwbWdodjE3Z0Z0bnl0Zjk2?=
 =?utf-8?B?RnY2dkY3amlFSHEyUkZVSWhUMGlMZEk4dFA2UXVEOHBrR2ZydDRxM0Y0dVBj?=
 =?utf-8?B?UUR4clkrcStXN3AwSGNEWng3SEtsK2VISUx2d3dQVTRhejFkR2xoQkpOTmY0?=
 =?utf-8?B?d1p6cVpQK1Rsd0QvNEErREphUFV6VkVVcURSZit2eklMelVnbmRqRFk3SjBC?=
 =?utf-8?B?ekRKSE5xS2xtUytEQ1pXL1RnZE43ZkIzMWZvL0ZMQVFnbnBMYmV3cEZaeUZI?=
 =?utf-8?B?ejFaYmNRM05tU2NSUkZ1VjRuZ3JKWEZFSFA1eFUyTVZrcjV1ZTlFWjh2WWtQ?=
 =?utf-8?B?L3J2MjNEYUM3TTNmaGRjc1VSUmpqdEprQURTb0NHWndITVhid1ZKUHBZajJ4?=
 =?utf-8?B?M2c1RGJ1R2FWRkk1ajl6K0ZicWJCVWlVR2xwVnhNRytXTW43TzZXbjM4Uith?=
 =?utf-8?B?NHFFQnRCcldSdzVPc1Z3UXA3Q0JwYngyNWZVNytpK1g2dzl6d3VXNTBodFFG?=
 =?utf-8?B?cWFoajgrVzR5TnV5UmJEcm1HYktxZXhPR2RUdlhJT0dvalZQODhFNHR1a3Ns?=
 =?utf-8?B?cUxvdEdIUnBsM0UvMlAwMGdpL0c1ZUw1WnhaSUlzdXdUbHV3MTNTSUFCS3Jr?=
 =?utf-8?B?MDVSNnlqcnhiWGVGVGNldDExd2MvSG9GMFlOaHZZM3lkazhmZU5WamY2alpj?=
 =?utf-8?B?SFpobVZYUjRrTlBqRHR0WHQ2UzdTNG1IN3diajhwc25XTHlvd0haMUM5TENB?=
 =?utf-8?B?Wnd2S0dvdDFneU9QbHVDMFloT3g2cnNLMGFBRHRKU1dYRVlpZW9ieXR0Z1FK?=
 =?utf-8?B?N3M2YkRtUG5xZGN4anRNTFNRQ2lxR1NtU3FManRObFU5ZjVKQ0ZFcXcxNzND?=
 =?utf-8?B?b3YzT1ZSTzFXU2hZSFA3SjRVQnhzbzlSUzUxTHZrbitlaUpWdTk2NWhiVG5E?=
 =?utf-8?B?Z1BzUkFUQzlJaHNWL1lzT2kxR2R1Uk5malJHVjd3QWV0L1B6RHVsdXZmbG5m?=
 =?utf-8?B?NXQwR21DWUp1V1dER2UxaHlBVEc0VmhJNjlDU2hGeEpYL2taNmgybkRXUUJM?=
 =?utf-8?B?dTNiMDVGbzBSZ3Uwb044bC9XemZ6WEc4WmVQbGR3d0R2Qnd4a0srT3ZqWkhZ?=
 =?utf-8?B?NGkyQVBUUWNUTjBpSGJsVkppSTB4TzZSOXVuSWE4WDVTSEpqWDM0ejVsSHBL?=
 =?utf-8?B?aEVjdTBsbVVGM2l2SSt4RlA1MWhJYXdqMi9KNlJVdnlEU2dtT1lyb1JsRVZy?=
 =?utf-8?B?ZnJGNHNmS2gxV0dVNVdqSDMvRXJFYnVuaGVQcUVMcHFZcGJkcmVaMUI5ak9F?=
 =?utf-8?B?b0ErWmVsWDBld1lOSXlXR3kxdEJWWWxodE9OS0F0UTVzWEpEYVgxeno3QitS?=
 =?utf-8?Q?OFDIOtXl9mUdVVTqOn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cbd4da-36aa-48de-01d4-08debafde6aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:07:59.4870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nben8AnVM7cnglCnVGH/BZauB5LbAs33bUcguYsrFAyu+ekZWrCxftnJhCNnuolK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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

On 5/25/26 13:33, Timur Kristóf wrote:
> The UVD code relies on GTT to GTT moves in order to ensure
> that its BOs don't cross 256M segments.
> 
> Fixes: bfe5e585b44f ("drm/ttm: move last binding into the drivers.")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6c6ab4dd6ea9..f80371bc74d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -515,6 +515,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>  
>  	if (new_mem->mem_type == TTM_PL_TT ||
>  	    new_mem->mem_type == AMDGPU_PL_PREEMPT) {
> +		if (old_mem && (old_mem->mem_type == TTM_PL_TT ||
> +				old_mem->mem_type == AMDGPU_PL_PREEMPT)) {
> +			r = ttm_bo_wait_ctx(bo, ctx);
> +			if (r)
> +				return r;
> +
> +			amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
> +		}
> +
>  		r = amdgpu_ttm_backend_bind(bo->bdev, bo->ttm, new_mem);
>  		if (r)
>  			return r;
> @@ -549,6 +558,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>  		ttm_bo_assign_mem(bo, new_mem);
>  		return 0;
>  	}
> +	if ((old_mem->mem_type == TTM_PL_TT ||
> +	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
> +	    (new_mem->mem_type == TTM_PL_TT ||
> +	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
> +		amdgpu_bo_move_notify(bo, evict, new_mem);
> +		ttm_resource_free(bo, &bo->resource);
> +		ttm_bo_assign_mem(bo, new_mem);
> +		return 0;
> +	}
>  
>  	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>  	    old_mem->mem_type == AMDGPU_PL_GWS ||

