Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67E606A32F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0YMO8cA6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE81911240A;
	Thu, 19 Nov 2026 13:41:34 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1455211240A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzisbaer7emFODf3RjpqPOj7m5DE2L4J+wbj18S78Ew/GZSDj6mVmmjnUVoVNKFznpah4qk2tBli1IbxnbSUyO0Er1o7FmbF2wMt2o/H4kczW3d+aV0DiNKTDkQFk6N2vy5g/MLioNjOZrpmqiTJtFNB1gffS6xP64cX+amKsnOHJ8xz3DOB+49yR2++dZMDdzZ+/dlYzzaeXh/MhEG/ZsSMrGIqSVYQtDQq22/lrEB+0LTXmNmPTl1kYaoSeYI9uCCQ4JMtVEOmJJg4YZ+Za6vqwY6yS5RnzEzTwnuvZBHWT/NyP7kQ0xhbdSoNHsYSLVjMlj2DBflIfd5TuLVo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLmFkmtKwgCTNkDqwckMq6DHxam+GbQYfnzZl4sWVmg=;
 b=rT/qV6wNl/23zxNzLqS8X82/S6TXDNw4TawANGWZ8KHkOzhZrgwmVOJBhdUL//x5NlYaJI2VPELTFoS3CLaptFlkWmyD6eAawYurw2MTklX1IPfaFH1bq+kNkPpy2vmNUdHdUXTcl1ZQSmcDsnheeR2Ir42QHLi/szwY61LdxK4TwR+L7g2/V6MGAb+/iwbFkoN0fONw7MRDjQusOm34ObtFyrT21y79PX6w63HZqLb6j4O+3ZlQ6SDTuct8/RPQXE/RwmbCRJC8oS8zsVT7/uSMp7f1HxEJhtaY4Se5TLQtsS4DY4w+ciY/zkOw1mlkbmR3huw+u46UXyNm5HIHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLmFkmtKwgCTNkDqwckMq6DHxam+GbQYfnzZl4sWVmg=;
 b=0YMO8cA63fh1XojKvbMB/8r7DgTEIZ47k0j/sMn7jWjXCzcBvOr29SnJL2f1AadvKlrdCHPVp7MxC8hhnciBoGxM4l+X0m6t+hlU5CqvxovwhgA1JU15sRNnFsstAvmX+ziouhyYF+Qs3JYZY2IeyfKM8BVsRICUvTAkNpBsziE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 13:41:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:41:25 +0000
Message-ID: <c3636f79-c6d9-4fdc-a9b6-e5ca0576394a@amd.com>
Date: Thu, 19 Nov 2026 14:41:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-7-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-7-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:408:eb::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eebe5e8-c399-422b-dc68-08df4642ce34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|4143699003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|56012099006|261022105027099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /5Iobyzt6xsndMIOrOuyfm6j2eZe5olJMuCibD9t7yP6XxM4RL8cnj1Mtyd46bLzj8+FyUe9d29FHNq/OgANYM3l955OqrtL8SNd8ZKjtm4aAtanyxWi/vvpdTQ1DgpqQfXZQPUwRGV2yDPdCdW+UOod1O1zuCFna5Q0HQsFb6ZAJhTYs1f8mzw5bisK3/Db1iRKcdylEvgapEpQKkXm7Qfd0KmyuF9BrHR19lBTr+kAuUufiAJx9x96yQqY6TmyxQtFuebmavPQfeIgojk3qdAhyqIH0mRLmLn2bKpH8uV8B2Tew5NxgtEuYFnd0tEbqW/qL8wmWTwPmUQWGQDxpKyfvK8yu2EZcfE+BvkzZdWlVU0o5k3Q4VbG7vU/W2wvJ54WIDdrQ6lggaPCFDx5+JTerEjxo2wPriH+CoM39/DUK5KzJWLKS/7pCpsBsDlFAcwNhd0AhtLkP9nQYU6ilbt87+vyDCIaWywArjkpOEbR30kGAhzt4g30UdHEsrqRvf/DQdrOMWuCfi45en73nBkF/DjNOzLOlEAgJb61yB+iTGzf/xcXDbv8B0/PzCr5q0F6FzQE0TYglJ292W0NV4gI6UpkljRkdF+mGlsVmt9mBMIgJ6HdG/NqFrJquhkgJLrMXszVaa+7cRinJlEFBY/MjkAR6rjTI6YpTDJq1FA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(56012099006)(261022105027099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWc4aUQ1aTJaVGx3ekFXV0xDUmRFRVhrNW1ZV0w5RFdLaWNQSGE5amtNaHZU?=
 =?utf-8?B?YUVQTmlBVWVIMzVVU0xYOXV6MmlQaHl6NG9teHNoMWc0K2xGVHR1dWRqTk5t?=
 =?utf-8?B?OUgrR2VGWVpRMGVSZW92UUw1dFMvVDhvdzFObyt3akRjcHh0WHo2MUMzeEJn?=
 =?utf-8?B?dmpyWVVMWnpHNG45d1hJMGIrYXI3aEk3TVZlblQ0ME84NWxFU29MRXUzbTZK?=
 =?utf-8?B?VmM2dndoZEFXdVdWd0o4OG1CMmNYMno2Qi9OTEEzSXZyd0hrVUFyaEU3cFpw?=
 =?utf-8?B?VlE0T1MvZVpxdlVSUDhKbWVQcURzc01jem9RNEh4ODlPR25LcWVaVktFZmhH?=
 =?utf-8?B?TDRyZFRsRDl1dlRCYzZ5RXhrNWVKWG5WTDd6QVFOcERWbjVBai8xdDBadVhN?=
 =?utf-8?B?amZPVlJLb0ppc1lUdzd4UjRMbERJUi9wb2YyUzd2VjBGcEQ1Tmc5WUlvU3Js?=
 =?utf-8?B?NzBpcW1qbk9FMHljRGpDNW52dXVWc1FHMzE0d1JQZ1VvWXZwY0dvRzZYVTVT?=
 =?utf-8?B?OVJiU3FqTDAvejZTNDZ3dXJHcE1IWVJXS2RvZk1lYXF6dTJUbzFjTnRCME5s?=
 =?utf-8?B?Z3B0UWxRdVBMUkJ3Y1c2ODYvT3FURDdZNlJLNEpGZ2JiMHdQQ1B0aUtPeXhB?=
 =?utf-8?B?S3ZsdmJZU2FWYUFGem9CYXBwZmdDY3lqV051ajFPSVBCNENTM25iRkExUFhE?=
 =?utf-8?B?MzRDSFhyK1ZBbTFUUk1oK2VSQXpkZ0I3S0Y4aTBreTJjbldhU0s5NjFGWVBW?=
 =?utf-8?B?QWpsbTRGZHZZTzY5RUJ2cnZXa210M0xxMXprVXVyVVFNZXZ1dUlNT1RkRVBv?=
 =?utf-8?B?NDZMTHN3OEVMd3c1WkhXdzY3MlRFazF3cXowdTZ2dWdyUmdzNnN2L0ZLMmhj?=
 =?utf-8?B?ZEZ5ZzhNeEduZjQ1UGxyQjRhZWxaMTNWdlNoaGlDL3VvV3B2Q0VsNWI5RW94?=
 =?utf-8?B?bFBOWnBaUGlPdjNZR1FsaklaSi8rQi9IMG5xRExkaUlnTG1GTVlUc0xpZEpC?=
 =?utf-8?B?LzNwUWRsZW1MekFmTGZiMkV5OGRaYUN1bHBxT2xPbFBmcmNFNHBDaGt3QXNm?=
 =?utf-8?B?REtib3pOcTBQWXNlekdWT1IrOEpndkhKck5CbVdkTkJabDYyVE1qU0RwaFRl?=
 =?utf-8?B?RExtenQ0RkR6RVhoUGFEQU1JYlloTHovV0s3Ulh0QVVpVmE1ZXlSZXZybTlW?=
 =?utf-8?B?QjVzcTR5VUx5ZWIxUFlLcnBlL3dKRTU2cjRYUkJ3all2ZGF5WTlrZEk4QTZT?=
 =?utf-8?B?THdQd29xK2k2eUhCU3ZPb1l6anNmR3I0WjIzeGI3ekxUbDd3RVYxK0dVb2t3?=
 =?utf-8?B?TFlvRWhiR3MzL29DOFRycEFOSnVKL096bFJ3eS9nTEpOZkRuSzA5akN5UEho?=
 =?utf-8?B?bW5rWkRlSFpRRGNKU2lkUHB4cWRyMVNVdTNuZWVKWXpvT3dRUHRsMEdFdHE3?=
 =?utf-8?B?cUUyem42K0J6VUJwYW9taEFPd3RSWmxpOGlXWmhLenExdi9OaEkyOWdKVmk0?=
 =?utf-8?B?U0ZsT0g5YzhyVVJtL015NmxSaEdYNTZVOU1ReFZNZW5XcDV3cHNvRVVPdVpH?=
 =?utf-8?B?dzhvWVo5emJkdEpGVWtsejc0Z0xRYWRFRHJFbEtQanZldjVwWUdMUWo4Z01a?=
 =?utf-8?B?Y0hJVkd4andUWVFDL2hBWGlRT0xRVjlKd3FrVlp1Y0VhMmhiTTJ2NjVPc1JX?=
 =?utf-8?B?amg1NzJScUxQT1VpRjRDYnplVStMcmY0UjU4RkVSeWdzUit1MUhBdDhZbmlN?=
 =?utf-8?B?QlRBMnBCRDlmSldzaFFqbTZzaGFuN0laUkR3VTFCbTFGeXBMbWY0ZXhkSDNv?=
 =?utf-8?B?WUI2K1FwMVc2MlAyVEFDaDlNdktieDhQZzBPV3VBc3VPSmFUYVd2MmZXTFJx?=
 =?utf-8?B?ZVA0aGluellIYXJaaFFMNGhKZ3NzMExIS25xT2d6UWlFKzAvdmozdFVGYkd3?=
 =?utf-8?B?WFVpcVpaVkJKSHlYcTVWWmZ4MENZbmJzZnFqZklnMWpXcFRNaStJaHNXTTlh?=
 =?utf-8?B?NGdFb0tjVnRCNWJZakFXb3BXbWtsaVRNOEZhZzNkNkt1NTJYK3RuUW80TTcv?=
 =?utf-8?B?b29YVGowU2tmSnErcHVTY1QwM3N6bURsNmhLSnRtdzdSUWlCbkFMQkdIU1Rs?=
 =?utf-8?B?akU4T3d4eFlab2wwRi85NEhLcmRVdWRvcHZDdVI5dVQxKyszbTB2T1czamha?=
 =?utf-8?B?d0NFL3hSOFB0TnhQTFdNREJSanVTRk5PcmFIT3FXOHJyVitFQzkxVUNtK0k2?=
 =?utf-8?B?SFo5YTFQbDZEcGtaVCtIZklwUjhGZ1B4d3ZhMXdMdVRJK1BZV095Q3NIV1Ns?=
 =?utf-8?Q?clrvIlK1NC0VIHbA2D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eebe5e8-c399-422b-dc68-08df4642ce34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:41:25.3550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+nQkCF31hdISOqIVBB/0WS5+fJrPaZlHcpqh5L7f8b9OzrKGtGaHqLysxnCHnuf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 19:52, Benjamin Cheng wrote:
> Switch to stop using this deprecated helper.
> 
> The original could be incorrect under certain circumstances, since the
> amdgpu_bo_fence only reserves one slot, and at the time of calling the
> SDMA commit and TLB flush fences were not added yet (the reserve_fences
> is not additive). In addition this allows us to switch to use BOOKKEEP
> usage.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index daf0e75d0bb1..2a8abc9684b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1216,7 +1216,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>  		struct dma_fence *tmp = dma_fence_get_stub();
>  
> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
> +				   DMA_RESV_USAGE_BOOKKEEP);
>  		swap(vm->last_unlocked, tmp);
>  		dma_fence_put(tmp);
>  	}

