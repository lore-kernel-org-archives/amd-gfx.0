Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651611061B32
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 11:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0404A10EAB5;
	Tue, 31 Mar 2026 11:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qP267rTA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55CF10EAB5
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 11:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNokIXZj2sn725rotAzs9W2N96mfoWHqEq5kQ2gRcxawfLTYvlXG+nNv54gd/8ESSZhSkBWojA3ZllYGMKe5RywsRnd+lemDLBNvae9hJ3ng5RkDtRemOZ9sBEwrfSQtWhtakguUIXtPQvN43ClKw0BEwoqTyK3naLpvRy4Q/Vk/vjLXwSMLS+Mw6eZaZ7N2XqEQCASQEL3z4gPYJmmvxfwv950s4HYq7jdoFIY5q14lwuyyTWJGW3LN3UtJClOdUzShOmNbB8zbF1CctiqObgzPG6tjfBD1CzNfVbbF0klvjsFSpQnH9ypDdvLZLCgamDwjDvws2hJUpXmCmQvlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEn0OLikVSI+9JX1vCP8zOXshHEzdvWxegs3LjkUogk=;
 b=qEwYjq5jzC1dfTwpIRU0O67Zu6gVJtvMylaaI5RPISP96UyqxcBD9OgjMbF+96fJsZGToI2rapSosWD/Aj7d7TPGvGm9MwVTFsjyr1kZJwk9fiH7rTneM25SXxNnnpNKbbNXIzcxO16DCXo1lNh07VhjA1646yZfpd7xlFHDl4neOnC4+BPZeP1IJQeMOuhjDrLSH6EVTnZcqPeLKbPUzm9CTgoY80i+vQLzU0lj+Ye+M6zOh9ZPZIm961Q/UAtiz3UxWTiBhG3lgp6Wxy9VzzocJYvbBckpHGpbTV+FyhE+AekTtBbLCC7K+QlVekeaz3N5vaXa5MJ27h+o4zMIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEn0OLikVSI+9JX1vCP8zOXshHEzdvWxegs3LjkUogk=;
 b=qP267rTApWXwCW9ra7kcbkkw8caDOIrTKc8ET3h7sFzn9J7xaLcqw+8jx2NM5hNdS1UiveseqMv7kBOexWq40/gOmjnK8erOY7cSnPGk+uNCu2O3k6s5nK6MXMzOiAitHQGUc/lZEcYqLXBaNq5dlB8UJMhV6GRzlpJTHfxc/qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 11:32:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:32:12 +0000
Message-ID: <20e41c6f-811e-459e-aa33-2e864f04ab87@amd.com>
Date: Tue, 31 Mar 2026 13:32:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
To: YuanShang <YuanShang.Mao@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip Yang <yangp@amd.com>
References: <20260326103656.487304-1-YuanShang.Mao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326103656.487304-1-YuanShang.Mao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 1953ae64-b4a7-413e-d8b3-08de8f192717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: nBUIg7FPyG6gftKXewJjv+OpL4SlC/48Q5Cu3g+Fnf6JmEZOxWtTjrtl635y6egPN2fULliXKwHjYXdHywk719HBUdtxZDSQWDr2uhUg7mTPWmu61gtCI+J1v7uykRClsZvvVRie/aD9tWSUbxmqFAYy23nLCPFV3AG3NwdHAPbHLe4aPg1qSXngFFmHzxV1YeUJ3l9lrz1YuQHZIR/aOQwA3xK/UcvJXs2nFLFT2MZcc5zSE01S/6JYnbFx0iQgwshC+MGrltezi+vuT9lfvRl2Ir353b8OsvSCxsNym/nNt99fYp+RnWN19jdzc257NDLjYaQW9bMleUd2bZgYGtbcb5rmvAMmTNZt/SqIqmRk9jIetseM/ZvAyjCK+meCEyo2bkIsSIBA3AXaC8ncawnmw2qtVoaS8tx7JYn63zHeQSphTskQ0Q8cP33UgJkocupL4bP2F9wRT5QcEneeaSUwmr/56Wmz1MDZ9N3Lsmy5kq8TzwvVaxMgoMRfRsNQQl2FLjpJ4PHms/1GwI9jBZpBdw/83qeVd9Gtecz/OFRp7w3HHx8qPzw3P+YTsY5E7Cc64LyW8QntmoKCLSDoXdvf3JY1IvZCKMeq35Tqe3+vgylUxuuL8VXupLa/QDdBg+xoMd2TMoSt1QofPDjzSZnI0TJtVeoZqDjZFrcZ404ZG9dNvKo5EaM+CqhtwAq2/zrcJPwg5MqSzKIWHUlKwn0/w8IGfi3mHElq6GOeu0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlkcXBYVUVHU1dUQkhDcXdSRkdVbGZTNUpGa1FNaVd6RWx4eUR6VllvWkxR?=
 =?utf-8?B?ZW8vanpDdzB1UjhrY2pGN3lNRDhCbTBOa2JLcXpiT0Q5ZlpzMk1oOEIyM3pO?=
 =?utf-8?B?bm5BV01UdDN1SUQ5NEtNRDdiR1RQSzRnN1FGei9pZG5GVzhRNjhuUVRPVUs4?=
 =?utf-8?B?WmNqa2dlQUpleld0Mklsc3Q1SmR4Z2Y3UHh3eDg3OHlCM1F1L0lmUlNUdEtt?=
 =?utf-8?B?NkhnbC9LL0JkL2NVWEFUYlJ0TU5qT0JERlFFYkN2dGF2TmVYai9PN0lOeEdu?=
 =?utf-8?B?SzZMa1o5WWw0UEdBcDlFWHpyUFlNakc5ZURCcnVsVG40UjNHdE1IYjgzREpC?=
 =?utf-8?B?aEpuUkFNTTE1MjkvTGNrTGFxMHpBRlVVaElyVmFRT3J3OHJkTFc3ZlNFTkNF?=
 =?utf-8?B?aUdVMzJ5aDVzYjM3cmtjemJOSm0wR3NvYkU5S25LYkt2RHpSYlZzMmtFVXZZ?=
 =?utf-8?B?eHdHSmtEVnFTVDhmelpCRzFmMHBxUklDOTdyZ1FhNzlBOGo2b1hBT2JWWUtC?=
 =?utf-8?B?NmM1ZFhNUnRnekpQRFo3ME5ERWtMNWorZDdxNUxRSGs2Rmxab2VaOGFtNURo?=
 =?utf-8?B?Y25ianlXR2s2cnZWcU56VTdIMnJsaGxoSFlNQ1hqYUkrKytJbEtZTkRxbFhZ?=
 =?utf-8?B?bFZ3RStJaWJ0ZFJRUGR4VWdJN2d3c1Fnd2pSM1BhTjVjZGIzSnJzMys2MEhv?=
 =?utf-8?B?U2JFd3pBMzVqTmtXZ2dkZ1hSZzNSWDdTZk80ZnpTVlIzb2U2VlpyRkVZVlJB?=
 =?utf-8?B?NzVtNkNEc1dLVEhveU5GZFdLN2VTQWVzL0VXUGdDVzdMcC9iUkw1ZUJEY0dC?=
 =?utf-8?B?RE9zMi9hVndlRURWaG1XSEt0VEpVVVhyajFOUllySlVSaWdQdWxmTkErQ2tH?=
 =?utf-8?B?RW9TeTdOc0h6akpCME82azViTzFCbVZIbVNYWUZ0ZzVHN1NUbmVWbEZLazNV?=
 =?utf-8?B?dms0NmgzdkpoRWt3cEd5OG9JaE9RRDVOcGpUdjRQTC8zNXQ5bmVXdG83dlds?=
 =?utf-8?B?TnJxMnpRanEzblhINHQrS2pFQkZwcjE2MEhaTGRjMktjQmovYUQ1VXNQemIx?=
 =?utf-8?B?dUZTSi9FNVRuWkdPY1kyRmxEL2w0UjFOdURST3JvdkI4cWNLVHBES2JoUmJZ?=
 =?utf-8?B?ZHVXWGlqbVZ2a0dWSC9iZVBvcFRtMW81c3pGVXZKRzNZVFdOd2RaeXVwQ0s3?=
 =?utf-8?B?U2hKdDBUY3dvVVd2MlBkNHJVakJiMElGc0hGZ25FUzQ1aFJNQmpVSFJXTWt3?=
 =?utf-8?B?UDl1UlhaZTNNVGozb09ybG1OZFFsOEFoR2w1TWtvQzJDZU5ybnA4M3p3alU5?=
 =?utf-8?B?Y1ZsS0wvZmhYY0xxMytYejUzSVVQcEVCbFE4aEE3SjRpZlNDWTZZZDVxWXNw?=
 =?utf-8?B?NkxCUk9zb0NCVklvUFdjVlNudmJEOExwak1XTzd0VTBReDJSOHMxZDR5aldW?=
 =?utf-8?B?ZUNncDJBRXFaSEZvZXJWRzlZd3BXRmkrajRUdUJ2TTZPRDExbEpMc2dKK0RW?=
 =?utf-8?B?c09vSmplYkUwVndlYlozd1grK0lTRG1oMVoxdFJ1a1JqeUxaZ2I4NzBIeGRU?=
 =?utf-8?B?VndFQVRBeUFMd2VObXY2SkFRYlFieWJpSXI0TkdjdlBrbXVtK0FuTUl4OUFl?=
 =?utf-8?B?b0d1VFBqM1hvS2tXdkZLZ3JpVElSY0REZEFHb1NGY1c3d2o2dEI3ekNSbnox?=
 =?utf-8?B?aUpvVmhjMHdKQnREWkZ6cHdtaTlYbDVIRmh0cHVPeVNEVlJuRklvQ3ozQ0lj?=
 =?utf-8?B?YXJrODFONWNqVmUwSENYY0J4VW9LVGEveHdIdUdTWUVqdjlSTUxuNGVoOHlm?=
 =?utf-8?B?enhsVHBpN241b0FEdXBEOGNvR3cvbi9jK0hneUMyQThac0RMU2EyTVRTVkhl?=
 =?utf-8?B?RzFoUUNDbmxvYTAvOXd5U3E0VitRTDFFSXowWXFUQWFwdTVHZ2hFTDFTZ3R6?=
 =?utf-8?B?VWFjUHQ3VDVvMjU2SWJBR09rMG14UmEwSkVHZUVUVURrbmNydDkveW9DdzN3?=
 =?utf-8?B?VVFLb3lITXFLcDhKZG95WCtiVVJvVkJYWklmMTIwT20xRVRxa2U1R1BVcWxp?=
 =?utf-8?B?WUJud3Nqb21NYUw3V2orclpwZm1rU05ubTF1eDZHR0ZRMnZaVWkzbzhIeitT?=
 =?utf-8?B?VlQyekMyWG03Y3hBa2RwWlVEK3lub2doakthaHZPakZGY05DcUk0VFV0aXBy?=
 =?utf-8?B?bjNpMUhaZFVBc0NvNzNxanJ2V0ZEVkxNK1ZDa2Y1QkpNUXhSUE83M01BYkRh?=
 =?utf-8?B?ZEhYdUVVNWIyeWkza0N4V1ZyZ0NyZlMycHBrRGVwUnRxT2ZrWHBXMVcwWVdq?=
 =?utf-8?Q?IBuLocDXhN8HUXB2H3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1953ae64-b4a7-413e-d8b3-08de8f192717
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:32:12.8188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrTPLp/800ovA+Zfwa9U4jLfAyYemtkxwXRZxuL6bIO+QahkX4NS10YTHOkuF/yW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
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

On 3/26/26 11:36, YuanShang wrote:
> Don't map or unmap svm range to gpu if vm is not ready for updates.
> 
> Why: DRM entity may already be killed when the svm worker try to
> update gpu vm.
> 
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>

Looks correct to me, but I think somebody else already added those checks.

@Philip is that correct? If not please help reviewing the patch.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 8167fe642341..7f905a7805fa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1366,6 +1366,12 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, last,
>  		gpu_start, gpu_end);
> +
> +	if (!amdgpu_vm_ready(vm)) {
> +		pr_debug("VM not ready, canceling unmap\n");
> +		return -EINVAL;
> +	}
> +
>  	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
>  				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>  				      fence);
> @@ -1443,6 +1449,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>  	pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
>  		 last_start, last_start + npages - 1, readonly);
>  
> +	if (!amdgpu_vm_ready(vm)) {
> +		pr_debug("VM not ready, canceling map\n");
> +		return -EINVAL;
> +	}
> +
>  	for (i = offset; i < offset + npages; i++) {
>  		uint64_t gpu_start;
>  		uint64_t gpu_end;

