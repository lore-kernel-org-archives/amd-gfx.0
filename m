Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE53EC77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 18:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6814910E098;
	Mon, 29 May 2023 18:59:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DEA710E098
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 18:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT4q0jVFFdEmsWvrbe7xVmToIsE8cb2AO3EphYGuqbS60VOXGUoUBCe3nSCdLDN1+FAr5x1HfWm3eZKFcvAR2Dc7c1Vt7aCEVfq+hbpCmZki1gdI8W85nIqpY2DeQsQXou0+SJ570wjzJEB7kDHy6GWCLKIGOmeeWX4K9vaqYftBpSn/3K74gC0N3X6oSTs3FTYa1vRQIrgkomuaQTP3myXtHsDui0cQ8U9ORVhjL79exMRLkj+2Pj965Qz81d/d935ydDELUOsaxDkkzBFOgTlqXlewiCcg9HHYUvJog8Q44QqPv4JaM3Xx40Q1pT8Z60gCAtxVI6RcuCsOVWcRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxsjDvS8bIIPYUf56x9MQ/umP1D4tmkdbWaN4gvjCEI=;
 b=m4cP85fzVDPTX2nx6jCYfA2LGzaBvRjtT1VOgPKF1fL+KbAJMvCGp2aKyCM/29ud2smP3zLpFkeP1ugEraCfQ+OftjpoNkhRO0VnnwWMjdm+gtLOsWa3DNJPH0KjbjuI5hClNPdXg4hJoHbW22K3C7X3rWJCdczuzQJ0RL6IzBLttvM31ATFKbRhkscnHpYFk6pfkWBizQaYne48bhlW1hLxy29BHkcBfgjcImSslUe9/8LaDb1rX3QUkbHOWScv4Fx4jXMWPYyD73y8/VT+MA5qLv+FBnxTGi9jLoSNg+EB8mLzR+uAakN7mkQ4/bIm+Elbh/qjZB0fcNDNJH/jOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxsjDvS8bIIPYUf56x9MQ/umP1D4tmkdbWaN4gvjCEI=;
 b=GLcbAueDfdjciWvlisra6dpzfn2jEaHkdTwNjAUn0hCRVKJhhKNEo+RmzrGkVWtFZlQ8UzkbuKeQyxssl28vxsyqkwo/nOCqgRCGxIVOFoQoDmxyv2Fyg661rbOQsrMpkAvhk4gMCBeAHHCSh8rSP2XPxYwpQet5A+Vin6b2bFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 18:59:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 18:59:46 +0000
Message-ID: <70d4eadb-e6a5-0f9e-f59b-ec906c812af6@amd.com>
Date: Mon, 29 May 2023 14:59:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix create_dmamap_sg_bo kdoc warnings
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230527165946.1536728-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230527165946.1536728-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2caf920c-a753-45ac-3d91-08db6076deb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdFe2iej2zWLdg38F43+dO21PNczcdjuZWQicCjkoP4fZzKB16q9CBAhZgBeAE/TSD6cF2wimNA4nif3EdAlN/WBLX6EoQ5EJln7yQ7YBIbKC7BocUhlYyTqEeYPb8PHOUSHBX2RyCVS+uJY6CvtH4HK7dsuE/IYwNKXGxT56drAL4s2Y2OqNAXfSJJd4AzfIINLJA0WgP6ygGoCD23TmtpXrlVnfxPbfA4uj/z+Xcl9KTEaaTG1F5In7mfr3pn8EnH5QuCryd2Lur0Y0qVNccPAI41Apy3L9bdiAaHF8l4lEt9GEZWafgGnQLoGpgfvLse107u8A5Cm8pjl11wv+dRaCvmVW4jAOSoUE/ixsTcIJmJm0YD813GzPjiM3g0Dw4CecMpveo9/2/SmRTCKx9e8Fdbevg04dCRyPvaJBHH4Q/duI/6fQb6N2CiUsSx+CAvwzzI6ArU7TBB0BrK4GPW2wQEZdOdB6TEfQcF13ENc7jknwPctvc4JqCm8yzKvr1zHMP48xgylcBjAOzRayxRFoP+watQ8om2PbjhmruMZo8tG6R0V37lWqr7v4l06YthtVF4IBtRqhgXbqoIW8Zc+BHIL9b2fNZFyASRgk5yBgxPU9tLv1uF3PeB2jpvfZa/s++WkZPwv5OPZkCtqJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(66574015)(83380400001)(5660300002)(316002)(66476007)(66556008)(66946007)(4326008)(6636002)(31696002)(36756003)(8676002)(8936002)(6486002)(41300700001)(38100700002)(36916002)(86362001)(110136005)(2906002)(2616005)(53546011)(6506007)(6512007)(186003)(31686004)(44832011)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm96dUVwNHZpUTlDTXNXUmhCZkRmczlEay82N29JcHZIUnVyZkxxZlpHMmxi?=
 =?utf-8?B?TU5WbVZIWGwzUFJJSWdMWUZCU0wzMkEvMnB3WjgyWFBrc1RsTFZ4eXdmdWN4?=
 =?utf-8?B?aEo2cGF4Z1NtdFVtbFRwSEFBcVAxSVMrNmJoVWJUeWJCSnBGMzVpYlNoVUM1?=
 =?utf-8?B?QjZhOFFvcFVVdWpscWNLcGVZeEQ5cmdpUEFQSWVyZk9uSS91VHZGbTNtcWJ4?=
 =?utf-8?B?ZTU4Smoxa3FpZ0Vsb2FmSytkVGw3S2tKRTYwUW1Qc3A1amgwUWh5VC9XY29l?=
 =?utf-8?B?R3pUUXhvempackUxWklWVFpSbjV5ekorQnZpVFZpTWlsMDlxaHpUaGFIRzNI?=
 =?utf-8?B?YUJteEp0ak9BTWhVZUFQS3B2M1Zsbnk3NjZIWmVoTVdvUGNaTlpKelV0RHpX?=
 =?utf-8?B?WFFBTmFTMkpTdXNMcGpwVHhpaW55aHM4VmFKbzQzeUl1MkVvcFdEdHdrbmRw?=
 =?utf-8?B?cXF3ZFpOQWlKLy9qSXE1OVlBd09rblV4YkdJMHJVc1dpRGQvODh1dnVLdHJR?=
 =?utf-8?B?bklBYUgvODZiU2xoV1FtVkUwUzl4dUJKTWRPVmMzQlA5VDF1VVdjZm5wMUpY?=
 =?utf-8?B?SXRmUjFZcWFnS3dBV2VpSTFkRlZhNHdYRXJLMnFtaUxUckdVb2V1YnM4Q09E?=
 =?utf-8?B?UEpQdmhwMldpQnRTbENSckZPbmVQd1NJZGNWQjlURXExTWNMUjBhT2JhVU5G?=
 =?utf-8?B?MmY3ZnRwazBlT3p1UFBpdEV6bGwxeW5IZHBENlJSdytIc0R0WTBpSDJJVXhQ?=
 =?utf-8?B?Y2ZxeFhSeERWQkdVeHZacFBoUHVER2lZWVUwOGdJQ2hiMHVtdlZkaTBnVldQ?=
 =?utf-8?B?QTVVZ1d1ZHEvOEk3b1gycStSTGlDYis5M1o0ZnozT1d4OGJQL3lDK2xqTEwz?=
 =?utf-8?B?aUhjN0F5MGdzd1UvREgvOEFWR2VNOUxRTjN0b2grU0c1UFNwU3NOSmI5by9Y?=
 =?utf-8?B?cHkweDVBeUt3SUZFcHdQTWhqSnhBZlpNYjlhbjNEM2lQYTh4cDROcWdyeWZr?=
 =?utf-8?B?a0xid2lPWFJYaXNtWUNLZTZIWXNDc05HbWRid0ZxZWFFT1ZKZytOSERqc05Q?=
 =?utf-8?B?dHpoQWd3UHpUL3FBbnBXTDhlZlExM3RMdWs4bWNiS0dlZkVEQXpDNmtRSS9x?=
 =?utf-8?B?UW9NVEwzbGVFVzJPc016OWhIR0NUWHlQL0lrblVMKzVMOHM5TGwrVGJybkli?=
 =?utf-8?B?SXRSczlYRFFodGcveU1Cb0N3bUx5bHVSU00xY3ZwZEZualp6Q1MwZElZYzV4?=
 =?utf-8?B?Y2YwQ0x3M25jK3EzZmtMT1ZYVTBPYVJFclVRZFhYalFaYTlTYlQzSTJQaEhH?=
 =?utf-8?B?QlY5WWtHYXFxMlpMTklPS0JnKzczaE5TNFZBa3BraDJIM2dHNVczR0J0VlQw?=
 =?utf-8?B?dmFUU0xEcTh2QzhoS3JwK2RrVEJ3dDF1Y2lGL0U2Wmc1bmxHSkZDNGZMcERL?=
 =?utf-8?B?Y2N4M0Z3akhCUzdEMWJYa3Z6RGdyK0NpU25pQzQySW9MeElBWFBTRHN5b3Vy?=
 =?utf-8?B?Q1QycFRTT1QyMmhKS2lEbndTVjIyNnNJSS8xUS9XdFZPNXl4anNaNnBkS0R3?=
 =?utf-8?B?QndiWnNyUjlYQTY1Q2NZb1MzWjdRUXE0SGdQRjBaQVJLS0xPUTQzNEkrUlM3?=
 =?utf-8?B?VGNCQmpEZUpKeWtZcngzZXZoOXpBaWNGVkgxUTM3WTQySUh2RlQyMDQ4bnVm?=
 =?utf-8?B?NEFhUG5xOTE3Zjg0UUN4YTMrNjlHM0hVd2lCRElIWjlEa082WGo2cU42Zmg4?=
 =?utf-8?B?Ymk3UEtIK3R3SFVrRk5maTMyR3Q1dGhGTisrYW1lbFkwYlNuait1N0ZYTGFi?=
 =?utf-8?B?YnBFUEt0cmE4enEycUdGMnBjb1pvaWtqdG80Kzd3NlVTRVZIOEIwTy9ibUM0?=
 =?utf-8?B?RkF2N1ZmL2R3L1h0emNSTGVqTUY0R2owN2pRUEdVb1FIdUl2Y08yRWFudVV0?=
 =?utf-8?B?M2ZMVUlsaVhVSWFvUU80S05ZcWFUa0ZDZE5FdDk5b2hEbDhnVjZmZndCR2Jv?=
 =?utf-8?B?OWl3ZlBDK2lyS0ZnR3N3V3lzYXNTQjhneitnM3p2eUJYd09FTW9wL0F1RDVr?=
 =?utf-8?B?aUszK1dsYXkrSUxFUFJVbW4zZG5ZYnVEekQ3Zk5acHk3UHRKcHpNQWNqcjVp?=
 =?utf-8?Q?6+DpB1VRAbX1T6ynLz5jX1BGV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caf920c-a753-45ac-3d91-08db6076deb1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 18:59:46.3782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQLMpkCj/k3/Z5nwYrpH5ZGbfoId5fdGT7y+b04jsiQQWzsJg8nO6LrWpr0ybYy1GfRo+oEGRZDbCCpglGiOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-05-27 12:59, Srinivasan Shanmugam wrote:
> Fix the following gcc with W=1:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:292: warning: Cannot understand  * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index fa4057da0d7f..4540d0964801 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -288,7 +288,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	kfree(bo->kfd_bo);
>   }
>   
> -/**
> +/*
>    * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information

This was obviously meant to be a kdoc comment that is just badly 
formatted. Can you fix the format instead to make it valid?

Thanks,
   Felix


>    * about USERPTR or DOOREBELL or MMIO BO.
>    * @adev: Device for which dmamap BO is being created
