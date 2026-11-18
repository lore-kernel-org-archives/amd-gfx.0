Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D223606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IxlU7SUX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0708110EBC4;
	Wed, 18 Nov 2026 08:23:32 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36F510EBC4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 08:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdNf4M8rBLDVNTt+u5XkSrAZqMf40eG1HEzAOj+GwkSFfY4kMF8xU2I4D5GzcXLSH/4OihhP3Keyg7g7Qsw8pTkDjwGnv4KmoUL3XnShiJ7RNbirjoKNx3skxXb4VmIzWwE7Q3LPJeT1BwL88iNum+kprMPo7qsJAjcTxwDxnB7l2lNBoil1/uh3ek+XhxJYQZp+DiTipurmIt/XXbJLl76Xfq3gAVZn4U1m+vYG3VMN+ZWj8aY+ROPIE3WjDrGefibxj9W8R0Sy5+w/UcLFTAAWQTExoBAL58BeaAOTCEeGk7hvsYAp6pNEzFgcBl9Y78rEN8XDTe6dQN2Ba23puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUY9ZHC9o30Vk3x7/W6Qe2fduH9aFzOz/AJEJ91UfH8=;
 b=w9XYC9AjDICB63Gg9ZHcwNFYk8ZDqgjqdAD+M+nK2ynTAmsG9GXpoYaz10lbI7WjiI4bru5XeqX+aKI2TTsXRuOt6dqg2MyYR8+y9zZiX6fruOZqa11GmHdyQW1mNb25DDaZUCvX1FOBer254xrcDo3AFts7MUWkAlkBw8nHYbFoxXAvg+CsBlP7f5PpXSTgAGReb5T5VK7UtQkdWeVZLALpGsUNMnHwvkM9u9rdglQ84QbACae2GVbkSEnUQADok4nSYFBPDgUcaYWqkb0um+zbMVvL+nqDIzvC3XlljpLhlk7rRn1TYu9+xJPt+tgjMjPlz2rsU3JnK01sEJZcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUY9ZHC9o30Vk3x7/W6Qe2fduH9aFzOz/AJEJ91UfH8=;
 b=IxlU7SUX6lqRsUX6dqbZawpSw4tYBYlPO3AatAe7jGhxuAMCw4v73eblmZce8iydK27QPPMFHgqYjSnRqoMXwsEgpwnzS+gLYeFnOY4wZ5hw5lzXJOMqG+IFdJsxeUyoiSnHoZXBOYwnftHNMtfdah+x8WxTizlyVs1UyLqbPRA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 08:22:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 08:22:03 +0000
Message-ID: <3a727e33-4bd7-4116-bcc6-c7d4067286f4@amd.com>
Date: Wed, 18 Nov 2026 09:21:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] drm/amdgpu: track internal completion of SDMA
 VM updates
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
 <MW3PR12MB4572710157BE03F990183FC09E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB4572710157BE03F990183FC09E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f657956-b514-45da-f2dd-08df454d064e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261022113327099003|261026121527099003|10067099003|5023799004|4143699003|11063799006|56012099006|22082099003|18002099003|261009223027099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 30COE+Q8JmRKEuhy4bJV3my4cjXERBKZwcZKMTu92cJjYeJwolrhT3Ld4NnJvujeFBVSmOpeHr2tcrSVggpt50CXgOT+VOVcUJV3vtKXzCoWM1YzC4rrv0Gyf/VRkm5c/m4brIFeCq1rmuELdmopiYSmQ7c73RvNAi0+5ViTVEQg6gRZL4gOilr78gYu9BIFndd3HC+S16atcpJw3PiNaHVAWN4Kv/1EtmT+zQncN9kzItZVUOCZ/p6k9NXBOJh92sDe8PEfnXUbVSoDVQ7luV291INkj8uORK+QzB1YMrFqiTnbIKsU5agncC36kKS0Baq8/sx8jspELGxsxlkcOoKaIHxYxfDRKZWNOOHKe8+x3Dv0S/j4066WOQJPCL8zazQfjWZczbuG4Uj1Tl8+hsbB+yDB/Ifbhq1LXyRdeIgTdDfn23yUITbnaV8oeHAWWdVhH6VUwHAxNSzzsPCHXgq0p7IPMA3xieoeqcXZnuhLQWc+dvbsW5i7vacuWh0bQ5zCqD4wAog1xWstfNq1gKSpFlYNWRKKZE6WK+OI4pqROesDfrzvvptbCndQN6nUbufqLxYBJy7gxM8Q0adX1pFarsXvUDQuGbcblA7ZTqZCPVa+B/dGjEG1G7Xqb3zrjckCr+PlLML24UKpPeTSMWpOSVp4xk/ABTE2kGlK/1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261022113327099003)(261026121527099003)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(261009223027099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkE5ZEJQQnRIeVcraHBTYlgzc0FtdXA5UlJMR01HRm1sdHlZQVV5dFZ5czVH?=
 =?utf-8?B?VDhwSkRKRFE1dnRlSG1ZRnZlUEJxZlZHS3l2NGNRb1VWSkxEaWx2cjFVUGYz?=
 =?utf-8?B?dkJKVUcrVnc3eE9nd3A5RlMvd1FaTzZiM1d1ODU0azZSY3RYRnRYbmlZamFU?=
 =?utf-8?B?TWY3S2J1cTc2TTJPNDNQVG56QnUvNlpXQTQ3cExOYWliTUZ5bHFFYkpoanBk?=
 =?utf-8?B?a3NPMlZyNm9ML29BemRvWXh2b1VCeWJBOE5XeFVFK0xiaGtVOFZxdnBaUEs0?=
 =?utf-8?B?cVRDK1F1ajROQWU4V25zK3dyS21lUDJHdy9kcEhib1d3M2NQM3RjSEN6djhm?=
 =?utf-8?B?MHRkckdHS2xkUUxXVFhXd2tMdnZWNHY0VWtrcTdMMUhRZjY0c1lsQnA2Y0pH?=
 =?utf-8?B?QUdNUmVlRnBQUjRnU1VIRVM2OXRGWWNoNjV6T09pTHhVbU9jY3prMEM5VUEv?=
 =?utf-8?B?RXVWaUp4NDZYdEFzbGpEVE8yUXhJam92UnBFdHZ0Q2NDcmdhcURXYVZlRHFk?=
 =?utf-8?B?OFJhaXA4QTNNV0ppVGlPNHNsUFIyYys2V3BodVBPRHphbG9TLysxRnZBUXNp?=
 =?utf-8?B?ZzlPdThqNSs3em81ZXc0clZyeitFWTk3a1Exei9haU9JVzZMaGdZUWpiWHdY?=
 =?utf-8?B?VzJDbGJIc1N4d2JCMml2dEN1bjVDSElUMVVDblZna0tsc2J5OFdidXFDbFlq?=
 =?utf-8?B?MVI4OFFtK3NBTWdtL3lUai8wYzk0UjNnYk9JcTBESWpVUnozdHRJazBlMDVu?=
 =?utf-8?B?S0h0dllkSFRNcEU3THdTZk1kc1Mwa1dCdGgwYkNBL2Vjd2M2SFo0Z2xLREJZ?=
 =?utf-8?B?c1MvdXlHWlpFUDl6VkE4UkovVnN0ZHpScFRWSUVabFJqQ0JxMWw5MEYxcGNN?=
 =?utf-8?B?WE10ekdZTk40WSswQmlWd0lKUE8vWXA0OW5RU2dhUGxVeklRZVU1TmpOOXlw?=
 =?utf-8?B?K1daWDFhYVdaSUUrVkt4N2Y4KytiU1lxeXdvaHRLaktMRndIUlc3WG1IZ0cr?=
 =?utf-8?B?UnZCNlVMV2c4cDZhL2hoZ01qcVMwaW9vNmtheTcrdjBrNmE5a1UxVWFJNSto?=
 =?utf-8?B?NXkyc1pBa1V6TVBjRlUyVDg4WStpT3VvQlpmeVRsT2NCWDd3YzFuRi9jQlND?=
 =?utf-8?B?VUxnTmVrbUkvMTFPVkEyaGVGZjgxbUNIcUdQOWVXZG02WkwrOXg2SUdrV0lw?=
 =?utf-8?B?Yi9xRG5obXdLYWl5VElBUGxOSmE0MXpsOHcrSUVkQklUbjNhYnNUTVdPRmZC?=
 =?utf-8?B?SWsxN2N4clQyOE9kOWFkSVVTaFZVamZlQTNWWmdIZlJmaklCaEZURmJPOERX?=
 =?utf-8?B?ZmVYLzNUZk4xWjZwc1p6OSt1MWxCSzRGY0M1V2p6cWtmUUxiNkVheG9YSjda?=
 =?utf-8?B?NVNiNkVPT3JFUktUUU5GM01iSUYzM1FNY2o4azJYSnNJMkNqbTcyY21xUnFG?=
 =?utf-8?B?TDJWY2I2RWNvdGhIeVRRV096eHhqMy8zLzgwU1VMVm11TDZkaUFBeUJTSDBH?=
 =?utf-8?B?SUVVaVZ6ZXdVQnhDY1lyU0Y5UnpqVTk3dHJyWnBTc2c0cHlaamlFNFFtRXlQ?=
 =?utf-8?B?NERMUlhuN29vMDhiMmhOTEo2bjhxNldackxOTjRQSSs5aTExQnplN1FUaGpn?=
 =?utf-8?B?WithZWQ3YXVCMmU1aE9tei85YVlEaDFLdmx3NjRDanNSd0FDdGtJMklMYVVK?=
 =?utf-8?B?QWdXL3JmQXFqRGpkdFJwYXY1cHBmY2xRN3ZialF5OWlIcFU2S00rYTYrczk5?=
 =?utf-8?B?MytlbTlDOE1WeTNaSTQrck0wZFZ4UGdQakl5NGJhMU8wLzZPWXBNTWFjY0Iz?=
 =?utf-8?B?LzN5aURkNUtERTN6ZnkrNE9oNFlEQnlVS1BxT1UxMUhMd2JYZGFnZnFOOFFO?=
 =?utf-8?B?R3M2QkpNZS9xTWxOMFNsYnVIZVB2ZG1wOGhQS2c5QTB4SGdkNTZ5ejBKQTdF?=
 =?utf-8?B?OFlhY3FyRDA1aGNpS1JuazNFeGdyeE9Pa1hUcExySktDZW4xd0dDM3NOUktP?=
 =?utf-8?B?MHIvbDgyZkswQlhuSitBcW5yTnBzT0FJTG5IaDZkMnBmanNEQUNveENvQS9j?=
 =?utf-8?B?Yy9CSzh1UGpOcS9qN3I4TkhRS2pXbEhrVytuN01NNnZqM0hBRnlIS2MreUU4?=
 =?utf-8?B?SnFWSytkZjhwbzRyOHIyTXYwTjFDamNuZzlXNzkybG80NnlTYTArK2RIdVQr?=
 =?utf-8?B?RWJ3bzBVZmFVcGhEMXI3cVh6T3Q4NHpydm1Wb096TWlOcmxxQ0Fyek9ITkRs?=
 =?utf-8?B?WjFBeVFuRzZwMXVPSC80MXByUEtVTWtycGFiZ1NqVTNjb1I4aTlybmJpTmVP?=
 =?utf-8?Q?huHRNF06mmfMWLsg+L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f657956-b514-45da-f2dd-08df454d064e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:22:03.2443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRfmsHFt5Aj3wDBdMCQKndS7SwGXvT+AI9Grf/VvtnNTctxfojDg+h8NrvYOQgy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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



On 11/17/26 12:39, Mu, Zihao wrote:
> From: Zihao Mu <zmu@amd.com>
> 
> Retain the latest SDMA finished fence independently of the optional
> public output. A prefix can be submitted before PT allocation fails,
> leaving no final job to replace the caller's older output fence. TLB
> finalization must still wait for that submitted prefix.
> 
> Every phase of a range and its nested PT clear preserves immediate,
> so sdma_alloc_job() selects the same VM scheduler entity throughout.
> The entity keeps its engine while work is unfinished, and submissions
> execute in order there. amdgpu_job_submit() returns the scheduler's
> finished fence. Thus the last submitted finished fence covers the
> prefix, clear and resumed phase; no cross-entity ordering is assumed.
> 
> The context owns last_update. On submission, put the old reference and
> get the new finished fence. Missing/empty commits keep the previous
> completion. A nested clear transfers its reference to the outer context
> by swapping outputs, then puts the displaced reference at exit. Range,
> PDE and standalone-clear owners put their private reference at teardown;
> TLB finalization obtains its own reference before that put.
> 
> Keep the public !immediate output and DONT_PIPELINE policy unchanged.
> Track completion before adding partial-range finalization, so the
> latter can order its TLB work even after replacement allocation fails.
> 
> Signed-off-by: Zihao Mu <zmu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 10 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  8 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 12 +++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     |  2 ++
>  4 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7199cec1f95..3b4df22c5ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -658,7 +658,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		bo_base->moved = true;
>  
>  		if (vm->generation != new_vm_generation) {
> -			r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false);
> +			r = amdgpu_vm_pt_clear(adev, vm,
> +					       to_amdgpu_bo_vm(bo_base->bo),
> +					       false, NULL);
>  			if (r)
>  				return r;
>  		}
> @@ -1079,6 +1081,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  		amdgpu_vm_bo_idle(entry);
>  
>  error:
> +	dma_fence_put(params.last_update);
>  	drm_dev_exit(idx);
>  	return r;
>  }
> @@ -1282,7 +1285,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->update_funcs->commit(&params, fence);
>  
>  	if (params.needs_flush) {
> -		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
> +		amdgpu_vm_tlb_flush(&params, params.last_update, tlb_cb);
>  		tlb_cb = NULL;
>  	}
>  
> @@ -1290,6 +1293,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  error_free:
>  	kfree(tlb_cb);
> +	dma_fence_put(params.last_update);
>  	amdgpu_vm_end_critical(&params);
>  	drm_dev_exit(idx);
>  	return r;
> @@ -2706,7 +2710,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto error_free_root;
>  
> -	r = amdgpu_vm_pt_clear(adev, vm, root, false);
> +	r = amdgpu_vm_pt_clear(adev, vm, root, false, NULL);
>  	if (r)
>  		goto error_free_root;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index ea52be053d8..9bd71f4d5b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -82,6 +82,11 @@ struct amdgpu_vm_update_params {
>  	 */
>  	u64 k_job_id;
>  
> +	/**
> +	 * @last_update: owned reference to the last SDMA completion fence
> +	 */
> +	struct dma_fence *last_update;
> +
>  	/**
>  	 * @num_dw_left: number of dw left for the IB
>  	 */
> @@ -121,7 +126,8 @@ struct amdgpu_vm_update_funcs {
>  };
>  
>  int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		       struct amdgpu_bo_vm *vmbo, bool immediate);
> +		       struct amdgpu_bo_vm *vmbo, bool immediate,
> +		       struct dma_fence **last_update);
>  int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
>  			int32_t xcp_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 0ff2d06bf53..7b7a576d95f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -353,6 +353,7 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
>   * @vm: VM to clear BO from
>   * @vmbo: BO to clear
>   * @immediate: use an immediate update
> + * @last_update: optional output for the internal clear completion fence
>   *
>   * Root PD needs to be reserved when calling this.
>   *
> @@ -360,7 +361,8 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
>   * 0 on success, errno otherwise.
>   */
>  int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		       struct amdgpu_bo_vm *vmbo, bool immediate)
> +		       struct amdgpu_bo_vm *vmbo, bool immediate,
> +		       struct dma_fence **last_update)
>  {
>  	unsigned int level = adev->vm_manager.root_level;
>  	struct ttm_operation_ctx ctx = { true, false };
> @@ -390,11 +392,11 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>  		return -ENODEV;
>  
> +	memset(&params, 0, sizeof(params));
>  	r = vm->update_funcs->map_table(vmbo);
>  	if (r)
>  		goto exit;
>  
> -	memset(&params, 0, sizeof(params));
>  	params.adev = adev;
>  	params.vm = vm;
>  	params.immediate = immediate;
> @@ -429,6 +431,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	vm->update_funcs->commit(&params, &vm->last_update);
>  exit:
> +	if (last_update && params.last_update)
> +		swap(*last_update, params.last_update);
> +	dma_fence_put(params.last_update);
>  	drm_dev_exit(idx);
>  	return r;
>  }
> @@ -545,7 +550,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  	 */
>  	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
>  	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
> -	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
> +	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate,
> +			       &p->last_update);

The code you work on here is outdated, I'm about to remove immediate updates from amdgpu_vm_pt_clear() and only give the parameters to that function as well.

Apart from that the patch looks good to me.

Regards,
Christian.

>  	if (r) {
>  		/* The entry points to the PT now, 
So what take it out again */
>  		amdgpu_vm_pt_free(entry);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 38ca2d78b38..d2d9a16a7ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -130,6 +130,8 @@ static void amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>  	WARN_ON(ib->length_dw > p->num_dw_left);
>  	f = amdgpu_job_submit(p->job);
>  	p->job = NULL;
> +	dma_fence_put(p->last_update);
> +	p->last_update = dma_fence_get(f);
>  
>  	if (p->unlocked) {
>  		struct dma_fence *tmp = dma_fence_get(f);

