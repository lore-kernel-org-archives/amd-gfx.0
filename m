Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AA606A32C
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jum9e3We
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C82112425;
	Thu, 19 Nov 2026 13:53:34 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20956112425
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMalrXsiVnyyKtFmdq+BqxF02b2I574PMo4K1Y3XMjrb/O2UN1BA1shrtksfpEoS67zxixKdoJxy+orpgcrtxKbTGO9TXSNBL0UV5sgzkmBlExm67SB1jAZw+7IlkHZAUmoBBGi5Sc71A7o4jMVIgwbXJlYnWlLTPmxubrHRn4O2Uv3AD8k7B2RsvuSfDxYQolWKn8a39TE+fsHSKjRSEEoMgTVjdJshQAwR4RWEQ0Kkh/p6HzmDIH82O4XwlEAOdvNS/hsZha89N0qreX0C+RELfl/YTfDdoiPCu9E/fWrwI1hAD8DEVBN+255LnXJ6mz/RCm7rXrJvSxsy0j+ZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCALy5e0ml/3FsWQUplFBRTNqacnCwdxMsA88rC78qU=;
 b=rALZRGwE2xRWdhgarCY5UC8CvDeq8vR6f94MGSJvAjSGvCl9CrGzJkJ2H+WrosDcNoVKINvY5tVdKJt9of8Wx6EU6rfyiLBIEETYJs1+IlYaihlWfRHy9Fdp+pO2gQXQ+q4M1h/yMh0II9ZtbSPCv84q4vvo5IdbPfFs48yNpgdYdUimvvI2tLsb8EKw6FtQxPh0zkVkN/2PVE0D77753QRwvyg1qFAkUsX+4+RTrSsNbs0vXKPY68AODfXqJhhdY0skC2daBVkDLshGqGKf8VYLfpBFPh2ujUgBnYbFsijHK9xTqQ/W5d6x5774XQYPQy1XjWlG1bxDSdDQP56EsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCALy5e0ml/3FsWQUplFBRTNqacnCwdxMsA88rC78qU=;
 b=Jum9e3WelDQYYbHLTuCIwHmPXnjLFcWT3e1HvSTa0hn4UHvs0emxAlwNykuEfhPhYhU4yD1lpXn+97AhNRu5qSlpL8NITXdDnicngSAL3nQW00DcyqT8J/Bx0pQA0w/Hy0qT7mu9dxA3hiSZkIiOhu25tf/7buOlM19haMMZ78I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 13:53:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:53:24 +0000
Message-ID: <a38b2db3-dfcd-4fbd-8b52-a261375e3543@amd.com>
Date: Thu, 19 Nov 2026 14:53:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] drm/amdkfd: reserve TTM move fences
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261118190735.1863676-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118190735.1863676-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edfb3d3-aba8-428e-d53b-08df46447abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261026140227099003|4143699003|56012099006|11063799006|261021123027099003|261021121427099003|261022105027099003|261028144727099003|261102123227099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: LSvcoMYKymn7leb2GPSIonl1ShD/AB47lwGEOD9fvrHGM73SYQ9mMklozULGCmifJR0uuwhKUYCVrRhUQh/ThJnfKjVrrQmkVnLciTr+MY5sQQ1rS+V8Oa5Oj1tYtb6XlU93CaCq95PhOmcULdJI81yf1mRHvGcai0B1Z8fFvHl7mZ+BJR7AxIXdaImVmdst5GqyT5peZ5HQ95udBWeohWne11USSSgM+C/t6QnRh03wzbHdj29Jv9gMIx2y+aAtrNQB7UZT3VIVlnKHdYGsvGiScM7ToQSVnTWcBJvT0MmFINJ1C5goFQ+0h04dQuXIY9D+ygjhjCltJm+sJRVg3fANPF21xZRAMGaxVP0UuAnd4+lvcKdRtEF/JWoEEwj2Qdyb43IqfebskMJ3Z3/n+Z8j6mr2eQN9NS4Vo7rVLrbF8+87AR8TWuEgwrozYveuwlIuCruyhZmn9tC4xwpZ/w03GN/zSr0DjHKkujca1zflMoRokY7lR2Q72dh/7hmgrp12NAvm6CF/LYJPbSTY8VxZ1boegVVr7LTfPOr3zskh/W5LlrR9Zyi4L9TA4QgylqgKu928JO8fzju55wRx/1kV/tBD+s6kd76aoxz0JfFqvKTs3ycJUD1JxDJ58TkSnFrh9qeKRziEzOutZpDgr8JzGoH012VClyG7+//f26s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261026140227099003)(4143699003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a29rN2E0RGJwSjlsRThqYzNXUklQR2Q3THh6eTFpbHo2a3VWWGNWSmVHck16?=
 =?utf-8?B?ZjNPUnV0dmtJRVF2aVQzQkt4S2FGWjhnQTNYVUNKT3lYQ3hWN1doRExKV1NP?=
 =?utf-8?B?cDBSSnN1SDN1d2ZvWGpvSC9ka0FqYkVmSE1uRG92YkhuaEUwNzg0VFdobDRP?=
 =?utf-8?B?UkxkemNXeHVGSmpRemtFU0lVd0NqZG1EUFNaQkhFaUhlZmgxODdHUlFFd1JY?=
 =?utf-8?B?ZUUwRVFPb0dyajhwTzdSRms0NHQ2Q1V3dUxYektJNDc5eWZOL1ZYSHMxbVha?=
 =?utf-8?B?eUxwbTZLckoraG9MY2FPUW55MDd5eUk2dU5iVEN4SEgrNm1odmQyK0JPK1lm?=
 =?utf-8?B?UUFNYmM0OWhra3NQYlRsa2xzV0RYTTQ5d2FEaVoxNkQvOXh2Z3ZKUnVjckNI?=
 =?utf-8?B?SmxXck5KaHZML2FpTEtMcTVEeFlyNTNVQTdiWFlkWURmZkZZQndWR1h6YkRx?=
 =?utf-8?B?VkRzbzZ5cmcvenM5UG9VZlpDaENpVnVLcDFpL0RtUjlydTFxRmR2YjY2NDAz?=
 =?utf-8?B?aEZpdnIvWHNGU1pQWEVldUVLaGFEVDJTRHo2ZVNlQllBUFc2U2tiWDhzeENN?=
 =?utf-8?B?N1hlU2VJb2JjZ21PM21sWEFrTG5pSU9DS1hPd2NneVMydFJNallSZjJvMVVH?=
 =?utf-8?B?SHc2V1lMdHhaL1BSME5BbnFGT1phd2ZqQmRuUHRPZ2hBNi9teWdUclg1SlBa?=
 =?utf-8?B?VFVLclQ4UG9POFJ5TE5MamdsNnZQbFplSUZvUkgwdHdFWmFkdlVGanI1cWE1?=
 =?utf-8?B?Yll0ellEU2QyeVFMRzNOTlZlVDJQb0lBRlFZVnF6OHFtN0xmYmQzQkFQMmZG?=
 =?utf-8?B?eXE4R2R4RTBCeXdTN0lSUDdYVW1RSWZKYmZuSlhzTVFjOXRTVkV4bllqRmIv?=
 =?utf-8?B?U0RCS09jdTYyQVlCckIzTzhkOFhML0ttSThjUi9IN3VyR2NjQWZNQUpwelRv?=
 =?utf-8?B?RHlMOURnaEdtczlEMVg0SkRXYXFPMzlmZDAvQ2Z3N1l2TTh1MXFveGd4cnps?=
 =?utf-8?B?enhZWnBCSldWcXUzQVpERVU3M0FtWGo3dzIrTzZIYTU5T1dIYlpSYXJJajFD?=
 =?utf-8?B?dHM3SXgyYnFsZTBLY1ZuZmxsakpKdnh3Q01EMTdINWw5Ny9uNS9xMVluS0p0?=
 =?utf-8?B?ZlUxU2NtVjJ3QkJoYTl4RDFsaEZpaXFUNnBUbmJZWUJSUXhOT2VYWnlHK1dF?=
 =?utf-8?B?YTAzU0lMV3F3R2xDcHBDVzRpTTlHaHFKajlpV0ZsaTdyOUE0K285cVFOMEpm?=
 =?utf-8?B?UmtwV3E2SmtJaU41dExNdUkwQW55UVErOUxJLzVmQmxxbWhRSUNjaDhjWkNK?=
 =?utf-8?B?eGtYTytPTEI2ZTh4S05PQ3R4NTVKenRqWGJRYU51NEFLTExLZWpKTmluTnpx?=
 =?utf-8?B?dlFaNHpHYmR6WlAwNzFQRFltbXNaV3RWMVhpQWJsemVqTVpySzBCSDJ2MUty?=
 =?utf-8?B?L2t5elFacEp6RlhZeHpFelRmYUdiNHdhZ0tISlZ4VGdzVldTM2krUWs5eUU0?=
 =?utf-8?B?aEdtblNDNlJ4WmhlVS8xUGkrR1IwNkFGblQvKzhoNVpid1c1dnl2SmlhTVEx?=
 =?utf-8?B?K1RMSFl1WTJBaW9rd0FZUTRDbmpOdjJqdGwvWUNWalRwYlBnMFViV3FFcWdo?=
 =?utf-8?B?SVZCbXRlU2VNRDJVUVUvOExUOWVpckFTV3NyWVUyY0ZiQmhVWXZlTmQwT3JZ?=
 =?utf-8?B?aUExQkptZ3QzOXphR0p3amgrN3k2dHlqVzI4K0ptOWJ5QTZJdXNibXJaLzZq?=
 =?utf-8?B?MkplNWlhREVmbk9mUEhZUGVRcmx1WjhSVTc2VnFhMXc5TVVNTUxoQS9Sd29l?=
 =?utf-8?B?TVVKOWRxTEp5Q0YvUEdleGRzU2IvL0l1MXVyZmR2VTU4Y2xhM3lLTXNYY294?=
 =?utf-8?B?N1RSaXdRRlh6a2VaOHVKYSs3eUxGelBlWWFWR3BlYW4ySEdrY25sRlprRmxH?=
 =?utf-8?B?WG11dS90c2NIT21OWnV6VVAyMm01VitZbkpqK25RWkVhaDNKRHdiTFhPbjNZ?=
 =?utf-8?B?UGQvbmdIMmV1RHh1ZmcwcGc0ZE9WbFJTQmhKKzZmQlZjVGtkZFM5SGNqNFBL?=
 =?utf-8?B?MDlGanJvUUduR1NIZDlZeWNvc2pkeDRzSUpOV3RDRCtDQTFtSHM5aHhUak52?=
 =?utf-8?B?MzlUSUQ0RnVJYWRCUmMwWnA1YnljWE9DUlRrd1FBS2g3QStJT2tyRld0b0F0?=
 =?utf-8?B?djdiSFkyKzRrZ1k0N3JHZW1rMS9wZDNVZnBoelk2T2ptQXJybFpPMzFIZFNx?=
 =?utf-8?B?M1gybjhGbzJNVS9pUnZrR0VrSytUakZneUc5ZjRmdHpOUmFKWGtxamxyZDdx?=
 =?utf-8?Q?N32IzH0q/UuNn9FLZw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edfb3d3-aba8-428e-d53b-08df46447abd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:53:24.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORnufLmSSgW9K/VFaJkBe3Cs4mSXguczNhj3A209hTfWelDwm6+wv2X1EF1HZnt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

On 11/18/26 20:07, Benjamin Cheng wrote:
> Validation of the BO can add up to TTM_NUM_MOVE_FENCES, so we should fix
> that.
> 
> Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f060b206c255..a6616447abc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -3009,7 +3009,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  			struct drm_gem_object *gobj;
>  
>  			gobj = &mem->bo->tbo.base;
> -			ret = drm_exec_prepare_obj(&exec, gobj, 1);
> +			ret = drm_exec_prepare_obj(&exec, gobj,
> +						   TTM_NUM_MOVE_FENCES + 1);
>  			drm_exec_retry_on_contention(&exec);
>  			if (unlikely(ret)) {
>  				pr_err("drm_exec_prepare_obj failed, ret: %d\n", ret);

