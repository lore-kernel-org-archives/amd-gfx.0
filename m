Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FADF99370
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDF110E23D;
	Thu, 23 Apr 2026 11:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SuYOS01W";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B9310E23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBwp+1lQDnLBYMHxZFZNCnntQ5vVK1c1ddvvkcYUS6ygUZOOl3d9+HqWtTcHWV3t835K52fuffAZ+q7rGUflCkh2cSzsbxLoDbpO8lAp8963O/tnAx+vnKPTxFj9KzrAXmtd/QeeKImOXxNj8d+Wpeqi8/mElj+He8ppegBfWCGdozG+CClQ2IepUI9KvkOa7MoYDtB9L5ya7QHq3m135bgZUfSwrb14nGWzrnY38awkh1QqaRTBeIYoF96Tg6STVBvHt9dlsGr/x6e+hFYG7wVjls++RpC61EvHyF+s34BdWao5cXIsrdWUfGVonh9VFbhajBElVwRGTn7kumsvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVGgGp5CYjdF7+c85qmGewbUjbbM5nfUr4wK7Lvc2U8=;
 b=I8n4SgmfPxi5TRvtNu1WYC5b18LRId91l8DLQ2FsyIwLNelLeV+YURYeXaZWW0HvjrBzMe+5UBplQl2QfsdNeAavBDuGac98wE0Ecai+nI0bSP1OnMz7ySaKc9qSvn4ziUapHqVMPKcE7RXnssDy5865UJi5TttjEGA2Fe7d9Kq6feH4yyMFxSqSDujvo6alrHX+XavyFX4AgRTNJnRB+2jM6P4XEodrkZAIAuqcy66XBOn981JIuDdciq3kgpHxzeHw9worzz7aSLd82u6YpI6aAkRWLx0myutjK5TXZGB6ED84ofUlgXyUkt7/AgoZbMqn4ShZxw6XVLDd+4WaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVGgGp5CYjdF7+c85qmGewbUjbbM5nfUr4wK7Lvc2U8=;
 b=SuYOS01Wetuv/viwD8ueGDCoDd7KG995eRqB51nGrFtCWbvSL6K6AKDIyvyuVMQ2dB9sWYWu+TgXbCvCXo+s1cGWfteI+p9ZOF4SsMSWR0Q4PqSXn9BzIH665jDKv+7lAi4Y6pvU3ltW4UqeBXoyZWiN/a6JWeQAd5LvDfnE2V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 11:13:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:13:48 +0000
Message-ID: <a53289fb-f62d-468b-b428-f3f6e9fbd45f@amd.com>
Date: Thu, 23 Apr 2026 13:13:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu/vce1: Stop using amdgpu_vce_resume
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-8-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260423011614.309180-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: f88862d0-cd4b-4f50-ada2-08dea129646d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: QHfjhWftZ/zeU83d/a6AeUthX5rx4fwJtJ5m8mbIBr521fEfF+vJbE8GKhFQ/kExHid0OWtE7rGYHDi7Iz6vpoafdMzwB1gzYLrfdw7twadGAlXV0c9t2gyqh1wu4gCzSVGA0tQ1U7HSxCeCtYyyTclFT/WfFPdeI8T9Kh/g9V739GFf2YUuTytoK0hLYHmhvEU2j3yvYejdHzGKR+wTSxgTylGFTJp6F4zXRbPV3f7HaQjc8Uibf3QgUE6PCQCgTo0SqwQEs1rlKb/NTyaSZ6vw8hs0VXF0xzAl0Unql4MIEWcdL5o8/LtJP4AytG+/kMZgaGJU8T9iByX8/jeK0K8/TM9a4h4Cx3vCN/083y6P1NSANGsmQd5/ZH9jEp5r/LL/Dfu7NWjfaVd5VDR+jRp0SQYhJ4n2V3I9I1dWGlIiIV6xpqssdKuqk1xxlgP7DcagFPVWaLY5DAi6d0L1l9kml5t/9FhJGrfYVPP4mx4uG2NrpWYwdrQPL8954pJlyzG+DO0gDh813p6PayvwMzO5LtbBOtz9F84YqSP7qwHEpyPaLOHNSuIg6KyGTq0tor6VmvNpKBDjjWluZuZ5bMFglpdLSy/lic19smlaGh7gQuSEyrBRol1q07o0BT091b0SVyFpV7zPTXSwRYFsDR6WvUkZMxNVlGGoWj+al/9te9a+MEb1xGAZwiW5uVTO2jKtfL2F98Uxpji7XYhWNf/4uEjLVGyS2caLjTyYPyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FrallDV0VZKzM2cEVIQ2N3OFRINVJXSllPdTBIL1crS2JGZ2E0bHZ4OEV1?=
 =?utf-8?B?KzJOV0FxMXdaZnRmQitFOHdaSEFJSXRQdWVRMyt1ejlTWU5RVU1WQmgyRTJ1?=
 =?utf-8?B?cDQ2dnpVRmZ3OVAvNTZudk9xSmlDWE5vZnZqQVZuaVNMaXJsMjEreEZsR2xa?=
 =?utf-8?B?dmVrb1JtdXFuK0JFczVURHBUTkR0YXNXVGtiMjJMODlaWjRCazhyYUd6L09h?=
 =?utf-8?B?RFhqcmI3NDJ5OFoxaXZnUUdJK3JWbnZZOVBJQjhoM085a3F1YzlVUEpiS1Rz?=
 =?utf-8?B?MlJsUWdlczZpVlh2Sk13TlB4VmdoUkFNeG1CbjBWamx2RmxuVTYvOXh5bG5H?=
 =?utf-8?B?NEFzUVE4TnpsQ0dQNGhYN1B0T0ZRSEJIMG1LRnNoWnBtWjRwOFNsNFNyKzRs?=
 =?utf-8?B?OHJDcTJkSHl4TWJkOENyd3QzNVZPRVJYd2krNXFUY2dVK3oxTjlvUTVWYStr?=
 =?utf-8?B?UFVuZFR0ajVMTXYrTGw0T3RkcjJvT0kwWTdwTWNpTkY4TXBqNnVjWHJxSkly?=
 =?utf-8?B?V3p1aXo1OEVidWplNFp2L2hZb1dVRkhmeHFpRjJjblRYekhXUHVvb1VQNVE4?=
 =?utf-8?B?bjJTQjR5dXh1TEYvZ1BtOFlEOFRCTUJGK2tiRXNYVFVxMlpSdlZpQ2pNVWdE?=
 =?utf-8?B?MjE0elk0UElNN01pQXdDVk1odDl5RVQweXdJQXVtamVzdE9xSzV0VkovRmht?=
 =?utf-8?B?L2NnekFLajlKejRIa2lyMWJvMkpCc29zdWtVT25KVXhHaWorSFdBSXVkYnBp?=
 =?utf-8?B?UTlTa0NkVlg2c1NlTCt1ZnN4aE1CVkczUDVGMGpiQ1pTTGozVzJDOVJUSTQw?=
 =?utf-8?B?ZDR6UWFMemtTeXBxLzRyTGIrMjJXNStRWUhtUnhzVm01TG9QdHA2L1p5ZDdl?=
 =?utf-8?B?c2sxb3lZVFl6Zm8ySlE5amhWY3czYVdHK1QyVjFYbWZ6UjhXRGNVZFU0Z0tm?=
 =?utf-8?B?c1BnaDZqeUhKVXIzdlFuRk4vWEZFOFlvb3FNMXB4djVkU0pwTEsxUWV0Q3ZG?=
 =?utf-8?B?azJSWG1kNmxySTNxSEFFRi9ySTA5dlFaWGp2djdCY29vbW5NaHJYNlYvY2kv?=
 =?utf-8?B?M1c5OHUrdGZDN0s0MDRYcWZlL1pTLzZGUDZPQk5kcWpmUHdoYWQza2Z3Y3c5?=
 =?utf-8?B?SUNZYmkxT2xnQUhER2J0YzRINkE1dFh2Ym9McmtZWjdqT3UwMXpaQ2dINTRr?=
 =?utf-8?B?REdEcmJybDF6NUVNM2lDZ1JiQlRVLzRoU3c0QmIzY1liejJhS1JCcGNlVndy?=
 =?utf-8?B?QUNFVTA0dlQraE5OQTV4cHc4R1pPUDdaUTVWdHlwb1Fyb1ljUG53TDc0OE1C?=
 =?utf-8?B?T0VrN1ZnVi9BdmxDL2c2SnhTMG9vRTVVT3d1cUQzUUlQMzVRWnB1UGE1eGJl?=
 =?utf-8?B?OURIK0hyOGFNYUlVTG5ZSENFc3huUE9NcGVIbzRaSUF4ckJBVmdXejNYcTUz?=
 =?utf-8?B?VU9ObEcyc0VnL3JPZ3JkQUhUS0hWUVh5MHQ4NHpqZ1B5SHlyK1gvRE4xdi9K?=
 =?utf-8?B?bnNadnRzdDVobkxSdDJVcW05b1I1YUZaSWpodFltS3F0K01JSWo1alpEdFY3?=
 =?utf-8?B?SFdhblcyVGNpMTFYZk5mOTVZZnZIR0syYWpYbmpLNW5rb28vUDFZc083WnE3?=
 =?utf-8?B?SkhMM1dOdUJFUmlEYkJCRU92bTJ0dWhicmh3Nkx6Zm5ERmU5UHN3MkZ5VTcv?=
 =?utf-8?B?S09rV3pKVkZXNGVnWjZiVW5yMzhabXVtTEdFK1I3WjM0azc2ejN1b3FrMVVB?=
 =?utf-8?B?TTZuaTE4a0RTYzZFd3VrN05FU0Q0ZUZKTTVrRjVsSzE4Z0ZTNi84endCcWpU?=
 =?utf-8?B?eWJKejJBakxZK2U2Wk8zVUJnMnJJZVJ3NHQvb2xCMldMNS9oUmd1R3RBM2dn?=
 =?utf-8?B?bGpCK1hSTmZIeDdReGpYY2RtQklNREc0cHJ4OXlOaDhpQ2JIcFdmWFNSNHdU?=
 =?utf-8?B?dlNPM1pBSDZtUnBjZk1zL3lTamNjaDViY2lzT01EUFBtODdFYVR3YTMrcWxq?=
 =?utf-8?B?eGRPQzllWVhTL2hwT2VKdWwyTzZDUkFxZHlmbE5pYm5uVEZVNEg3R05GRmZT?=
 =?utf-8?B?cWFhMHhGeHYra3NvSDAvc0lWWnVPSmFzZENIdWpwNzZTTnppbCtacVBHK0Vt?=
 =?utf-8?B?Q0s3ejZtTFFUTDdjaGpNTXo1S3FtUUpZUHNaTHJCSmdkS1ZxK24rK0NXa25F?=
 =?utf-8?B?UzhUeUhOKzYrRFRSM2NXVkZWdzNiclJXblJhWGVRYko2SC9FL2RXbVJ3eWtR?=
 =?utf-8?B?UGVSa1F3WjZWYTV4bjVQYmphMjBaelVKWE9oK2pkZlNKMTlRdzZDWHNqbmFG?=
 =?utf-8?Q?OA3AhT57wpJUrnQDqG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88862d0-cd4b-4f50-ada2-08dea129646d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:13:48.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afL8VYhDUrGhssk33CQNRv48IWAy3EXvnfOYfqwB4Fo2bVJqoeT2rdL3yVI3U2uI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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



On 4/23/26 03:16, Timur Kristóf wrote:
> The VCE1 firmware works slightly differently and is already
> loaded by vce_v1_0_load_fw(). It doesn't actually need to
> call amdgpu_vce_resume().
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index c8e7297fd7ca3..db8cc97a72d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -178,7 +178,7 @@ static void vce_v1_0_init_cg(struct amdgpu_device *adev)
>  }
>  
>  /**
> - * vce_v1_0_load_fw_signature - load firmware signature into VCPU BO
> + * vce_v1_0_load_fw() - load firmware signature into VCPU BO
>   *
>   * @adev: amdgpu_device pointer
>   *
> @@ -186,7 +186,7 @@ static void vce_v1_0_init_cg(struct amdgpu_device *adev)
>   * This function finds the signature appropriate for the current
>   * ASIC and writes that into the VCPU BO.
>   */
> -static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
> +static int vce_v1_0_load_fw(struct amdgpu_device *adev)
>  {
>  	const struct common_firmware_header *hdr;
>  	struct vce_v1_0_fw_signature *sign;
> @@ -232,6 +232,8 @@ static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> +	memset_io(&cpu_addr[0], 0, amdgpu_bo_size(adev->vce.vcpu_bo));
> +
>  	cpu_addr += (256 - 64) / 4;
>  	memcpy_toio(&cpu_addr[0], &sign->val[i].nonce[0], 16);
>  	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
> @@ -592,10 +594,7 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	r = amdgpu_vce_resume(adev);
> -	if (r)
> -		return r;
> -	r = vce_v1_0_load_fw_signature(adev);
> +	r = vce_v1_0_load_fw(adev);
>  	if (r)
>  		return r;
>  	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
> @@ -714,10 +713,7 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> -	r = amdgpu_vce_resume(adev);
> -	if (r)
> -		return r;
> -	r = vce_v1_0_load_fw_signature(adev);
> +	r = vce_v1_0_load_fw(adev);
>  	if (r)
>  		return r;
>  	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);

