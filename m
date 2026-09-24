Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE18C98311
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 10:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978D210F43C;
	Thu, 24 Sep 2026 10:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TYY2QXbF";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A496810F43C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 10:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTYqodChuyaS1MCoWtVW28AI8Dy9QmKQcnJB5E1bkqPWpfgp5bLMpVi8LhTzfoa34yHFx/lqc914r/sXSNNmZz+7/BsDWlw9OP+sJsOvCqPZTaCUkRChblEcSry9YaxKlq+ZY8QancfKBRJWoZQgfzKj6pHlebMkNanV2+9BLU1R1rjs9i30K7bXFqMae3LI7cU+HBa4Oo4+bFtSH5sUdj6wc9ktC3P27pgt2KkaQmqTez6vLs0ES7npwL3TB6npxEFDT+ZEk2oSCSmxZtLROalSPUKW2i3nNwAxU9Xy5F80bk/dOOXQM+/BrcYunmzBpcdmwpQcwJepKtKoaHA37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rmb7L9hoOvIG99cKaRjBehvwy6D6M15xW76T33k7Dk=;
 b=j5bclPQ3yGTJwSl5dLr3kURXCalDHkw1WP4UzXiYw05kQAa4XB69Xvlim3JzTE+pBhFSAj8hh3LmpTZfvuU4VmSz0edMTTmaMY//BtMmIKWNre5LPKgNbXecLYGUuFoAk0CsoOYNH29EnGAkhojlA0yWxeRW7+sQAEtYMv61eg6IZ/nv2bSKNWpRU+iRt6Rp7PQgjucD4JKE7+M1fsXp8z/7+Qu7xaC9An+kJK1gsnpXvA2L0Sf5GdOIFvlr2vOiUGUdqESjlecP+peLH8heSN2JupeRDca6JZw4F10fw4M2fCDROzi7zf7u/TorzxfZcyR/psPhujV4fnbEEJypkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rmb7L9hoOvIG99cKaRjBehvwy6D6M15xW76T33k7Dk=;
 b=TYY2QXbFgRPghWAmr00HUJB9RorMU3moxSfgfs/0KfKKYuOtisNa+gIU8fxYXr92mrxJQsPCpl236q5RoBGdLt4dthDxnAQqRev9GMXaOiQ5hdinRewvIFK7a5/gRtMN98XW7EvXcbp5KP+O80RxUgy/lhpFNxIugrohMq947JA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:19:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:19:45 +0000
Message-ID: <42081237-9b40-45ce-8ed6-b673f15b1431@amd.com>
Date: Thu, 24 Sep 2026 12:19:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] drm/amdgpu: remove redundant
 amdgpu_vm_bo_update() call
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
 <20260923193346.2292597-10-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923193346.2292597-10-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 476ac37c-c80b-46b2-b2ef-08df1a255a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4hBBDgiLVYKod9sNSxDBQCkN1nvO3ZT6QXA8ceTihJWrgS44wInx6ivX3HEro6ThbrDSXhx412/eTpJM6gzOQobwWqd8NJm2QwYnY/cdM0ixIaFl6gJrqDst7eTkExSVzrRrlN0gnl2SFUb78EUWKmUw7eonafWjZoWM/IjBso+olquKhb2+4uVP4Hg/F6q2tjkCGoIcIWhAgTUC1qrjExrlTRQEHzn56dEG5iiVRQDsPiUZYeF155xddY3LYEkirbm+0Yjox4Ox02nW7LwX9hNBdjnD3Iqva+9zmM/7Cuay7gNq+C9o8al4wXX7alZCbSOoEqQnZrCGjEYFqetnupvvssPUiQqubJleZwc4sVaByBTfPtdWAoOlDghCwt1XdBLzhB0uE27VYoDmJH32BHN4P4xntflukSSfD2kedWe6WeYxcty8h5Wn8g7dqVf2MIpxWfCOo4tXVACJ5N9oUpsmCkGY8z28jtganNf4qQsU5sK7nYv0LGXEhMtB42y8F058aGO2yZN2Z5WBpBz4uLB88dGKHrY264VuP+QFi7EeR/KxB78+BYO8feqTM4ipxfH5WwXOwztKHgskOUku0sWuRN3F5XXsM//tBmVnl4HybksAcGScFGGHypP8ST2s8JsjzPMQYHyVCN54yrtOsLOI+0capKsqW0TknsxTFxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDVIdWZHL1NuK0RnWTJTSzNXdnpkdlhRUUJ5ZUhNa3B3bDJDbTBJWHpmWjY5?=
 =?utf-8?B?MmR4NlQwdFNiR3dBYWVZblNrMWZBT0JqZW1uNHNrS3g3NThtd2wzUzZHQjBN?=
 =?utf-8?B?QUZmZ3FpUnVJTnZFdk5NOGZXUXhJbVdmQ1hQTzdJSld4ekNKaFB5RHlsN0w3?=
 =?utf-8?B?YXJsbG13NVpCZFpTQU5GTjVsNjZLUHFvSk1aZXhuZGVuZ1NEaStmR1ZiNjBD?=
 =?utf-8?B?N1lDcGEzYW5jSWY1OWp6VzFiMFRsTDF6Nk90TFJzL1B6VzNqZmZQSnV0UERC?=
 =?utf-8?B?SkJpRUFjVXdMcGh6dG1iUFNSVkJ1TFNhbkpYL1IybklKM2tUVEVsNXF2cDlF?=
 =?utf-8?B?TjBQcDBsdHNIVXA2N29jSXlXZ1RtOTkrQVh2NWVGRHdaem4yQjhpSWkvZHJH?=
 =?utf-8?B?blk0RnExWW8wM0dWbkc0NC9UVW9EMUFMRDNLZUpsTnZyeWNjUnZsRUI5cVUv?=
 =?utf-8?B?RTM3d21vRWdVdGZtT0ZUUDJqcXdid1JDTW5TUlZnZWlBYVdENmFFMkZVeS9p?=
 =?utf-8?B?bk40MlJNSnFGZzJjMVlldlNGbU5UU2IyNmcrZWgxZW1vb0VwRDUyVS9wTkx3?=
 =?utf-8?B?cTY4RURJMkpqSjNPR3d1R3F3emp5M29pd2RaRzN4dXo1TGpSeVRwNExzeWZk?=
 =?utf-8?B?NXZDY24xeDZPWFd6Z2svelpuMVRKNTdtUGx5ZENEY1ZmeUtia2xWOEowdXBi?=
 =?utf-8?B?UGtjbVoySmYxb01kYXhVMmk3K3ZZeTB0Sjk2R0Nhb1lEMldvbjg4UlF5MzJS?=
 =?utf-8?B?QnVoVmRLSFdsdS9EOFZqVC9rOFJVdjhBTG5zWlVaMS9yZG9NUGVmWWljT3hs?=
 =?utf-8?B?elZzM3J2N0pTQTkwQk90ZWc1ai8xZlhFcEZWcFdQcURVMmd1d3F5cCthbmxj?=
 =?utf-8?B?RzBnWUQzSkpReG92amxHWDJZbUNIWnhFVGFyNnM2a2N1RjA0U2pBalJaWXFP?=
 =?utf-8?B?VTRXOVg3UnJlNGxMVFZHaGM4SVlXS3pEUFg0enduNks5S2dta2NxQjVUcUZa?=
 =?utf-8?B?OGovbFVIODd0VGN2dEZvTi9wUVhTbTB3SzF2bmNveDNSdVZtdGNaNmt5d2M5?=
 =?utf-8?B?SUxsUXB4QUtPT1YydXNSbmNBNjZ3eENyYXJzVXUvempzaGh5MzY3WGt0MDkv?=
 =?utf-8?B?eW43d0pDNXZWWi9kZGZZKzhCZ3I3by9pbll6eHZMd2VnNVVXSk14UFZCYzcx?=
 =?utf-8?B?em9adU1FNG1MQXhXeXc3eVRPdmhxWEY4WHUwblE4aGpQTkZnQU1xeUI1eWZr?=
 =?utf-8?B?RDdPdXk4WCsrbksxODZTYm4xSXk2UVNHYVNCdjY3cHFTdTZhL0Zlc2cvbzZE?=
 =?utf-8?B?eGQ5TnVndEVvYmxQUmFDMzNoaE5pSTBBbE1NdHc4eTk1MjExNGk4ZUdic0Iw?=
 =?utf-8?B?YVVONXR6L3AwSGRtUkdmUW9oSlV6eGZCS1NBbzUyeGIvb29Ya01MT0tpLzZM?=
 =?utf-8?B?NEMvNytMTXJJZzgwRXloYVFmODNBQlpCQkZaWVFtZDh0ODhWVmFoZ3ZWRW5B?=
 =?utf-8?B?SnUyaXBTb1dvWmdZU1hmcFlxeEE2QnMzSVJYeEtlVXlaaEJBN3dkVWtHMU1p?=
 =?utf-8?B?UFFTRWtPam1YM0xBdUkzbVhiUTV0K1Njb2wxVGpZWmRIMGFhQXQyanRQdDlu?=
 =?utf-8?B?ZndTR2NvMWsrZVZqdElpTTQ0aXcvQi8ydnlLZ0VldlRkNForZjE0aWhPZHhh?=
 =?utf-8?B?cURwMnIrYnBnSjZXZVhGSzUvUGZjbDFBTGdpNndJMTRXL1RVSUV1ODEvWU5r?=
 =?utf-8?B?U2xBRXJJUW84Z1FJK0NzOXNqUld0WWo1bndZTCtBbkFRZjFiQ0JTbFd3MFNG?=
 =?utf-8?B?a0pXSUk3VkJoUEhZSXA5VnRNOFBMZjFxTjJnclJPWDg3WUdOcmlXcmYyemV1?=
 =?utf-8?B?V0VNR2FRWnVUcVR4cXk4S0l4ZXk3dWhqa2hiMkhsUGUvV2ovZHpjR25POXph?=
 =?utf-8?B?eDRWNEIzaWZWbzI2a1AvTEs0Mzg3UGxwQ09tOEN0czU4eU5NUmoxQzJyLy9Q?=
 =?utf-8?B?TVYrQ3lWQm5VZ0dpQXY2NlRJWW9iUVptVXg3dkpaaWRHV2tkNW5PdWtqV0NM?=
 =?utf-8?B?WklYVUxnQW1ENFpMSTZYYlYwbmJSTHdEZVNQS0JyaGtsZ3ZpOWZBRVdDT3dI?=
 =?utf-8?B?OGloRkRGRWpvQWk1a1RhelRZSTFLcjlVZFBabTBRUXpBL0pUcHJGS0ZnTTRY?=
 =?utf-8?B?dDB4ejBZcGJiNTFqcVBSTWFvUHJaZ0o1bFdhc2srcU9qTVM1SSsvVUJ2WEVo?=
 =?utf-8?B?M2loUWc2Zll1WFVKU3FLaEE4MzMycHpFRUNYSEJTTTJILzZOMWQ3NHN1NnIw?=
 =?utf-8?Q?jmsnYfu7Gt5Bh/6Ust?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476ac37c-c80b-46b2-b2ef-08df1a255a6f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:19:45.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfaZcq8sgbQJYQHFnP1RKGw5ZIlVQXmUqxIpLi8JEz7qR4W47uoN9BRKOi6ft1uT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

On 9/23/26 21:33, Shahyan Soltani wrote:
> This is already handled in amdgpu_cs_vm_handling()

Actually it isn't handled there yet, but we need to add this.

Otherwise the CS after a GPU reset might be broken.

Regards,
Christian.

> and calling it this
> early is unnecessary. Removing it is required to allow the vm to
> initialize without waking up sleep.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 21a225b0116a..fbf9ec7d467b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -103,13 +103,6 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		goto error;
>  	}
>  
> -	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> -	if (r) {
> -		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
> -		amdgpu_vm_bo_del(adev, *bo_va);
> -		goto error;
> -	}
> -
>  error:
>  	drm_exec_fini(&exec);
>  	return r;

