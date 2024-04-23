Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C2C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 19:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04711113606;
	Tue, 23 Apr 2024 19:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZcCL0qB";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F61113606
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 19:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NngWtQGFWlsRzpDRz3OT3IkfxKdC1enOkTvis816isg41Z4B+ne73XFQUN1FALu7cxYyAxzbTF4ZmtexoVsSEiRvumrxsMSYn3PRkHRvT1ZNK+7MU1xmj6N9e3NSJbiLJRYAk/idgSbBcuVYFs9y2KRR7jzKclpkYa+DygcV5XgJNYV40xZHgKPI3NWr3I6v+BKDdEhao5vC+tXygVWoHfNCHYEgEyug27neO6M4Q2RuwyFDfMjRa2yUb9Cv3Gp2LGwOIpuI/LLNhPJzSxQn6UTZFicqgjqJ6/2SNIl2Jv2uZwZZ9/LRGJSiafcTvPQN/myYdS4BCkDSVsFGhfS1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6vueaBCIdXUfLItewjOxlj5r6lmrtppU1ntG6d91x0=;
 b=Zz9H2hEFgBwvzEonEcX8N8Rcnyi0S2mbftnIv6qmVuCpyL87lrVndxg+CeBKQtEFZ2j4rp9YlgMaoOFknHy96WppUp0cSqyKPdByF1fHBCRJWhXcyKt+/2jOaZvlRd6vXcxKKBPUkfvsOrHe8Pkxdt47NWw8AeW/SaAcgLz8vfxlMvJQwRdVF3jRLkbLI3232lvdpnYkymQxhNUpt9vlJ99aWUuKK6ydCBEvkg51Y5ulOXqsXK5ldLuom13pSc0lFePE9WrlzQ34yWrBmO9FKC6ryhCvFfLs4T2beBZ4p3+N7WQrGzp8jUrIa7obyXBk/6y8s2ZaxnjLOkT+JN/Eyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6vueaBCIdXUfLItewjOxlj5r6lmrtppU1ntG6d91x0=;
 b=sZcCL0qBqVidpzKfbNHu0e2jFvKIzoeJFJSx015X3PFCBdNZcpl+Rg3qAExynhEYa+sbYmJmkJ3vp1ypbSg0XpGa/LdGeUaJT+51vmDAIJXh4+7kdQmLEqb/qGc9xDn431976QQEqOL765DYF2j95t+Id4rrgUoO47injlPinX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Tue, 23 Apr
 2024 19:33:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:33:43 +0000
Message-ID: <777226d3-1e39-493f-9d4a-42fa3f949ce2@amd.com>
Date: Tue, 23 Apr 2024 15:33:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM memory accounting
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240423185650.1496279-1-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240423185650.1496279-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c94322-e7d4-449a-b1f9-08dc63cc496d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVJtMnRwMHFHZWMwV2J3N3I2QjZvSVVSUHlZN2g4TDlNeHAycUpHNy9hV2J3?=
 =?utf-8?B?bFJrRi9iN2tpSFRKSEVBR3FPZ2VWMDN1aWNaUHdzck5aajJUQi9iWCtjMUdX?=
 =?utf-8?B?TEtsbTAwaHlpMkRVMFJaRXRHclBvZGQvNUVPaXIxbzNWSjVzeGJTL2NwNnU0?=
 =?utf-8?B?NlpQcFZsZUMxZGhJa2lnT0h4QllrTkF5TnZ2S0Z2RVc2anpxWHFsSnR6cEJl?=
 =?utf-8?B?dXpZNXNsd1hYM0JpblpDQjFEd2IwVktraW8zY3RrM3V2bVQwZ210RG9vTk5E?=
 =?utf-8?B?MnVva1BEVjlKaUVmSzI1VmliTnozR1UyRW52ZmlNdG5Ya3dMUlBZRi90MWt0?=
 =?utf-8?B?VmZHTUN2cXpadGY1Rkp0U1Z4QStIU3dsbWc2alQ1OGRveWo5WkNDbnpuTXF4?=
 =?utf-8?B?YWdsTHBJdmtBOXZJSUZyMnRnV2oyakJWcitZbU83SE55eHdUREZRVTZmNEVp?=
 =?utf-8?B?TU5VaVBTQXpiZG1jQ21qdWJzamxiSHlmbHo4UjhBNGdMMFRINnNVY1I3ZExk?=
 =?utf-8?B?dHpvQnd6VFlJVmh0OFZXcTJkWjVxUDlKTGU0cVRLSzFFbDJBMi9TM2xsbGpP?=
 =?utf-8?B?VDhWdlFPL0lpWTRhQ1JEOGZFQmZxT1RTNmNNTHhIWjJURVVuMzJYeTAvQTNq?=
 =?utf-8?B?Znhxa1V2bGwwRjFkQ0RNZnZGRk0vQVAzazh3OFNlWDFTUWZ5VUkxQU9zOXVU?=
 =?utf-8?B?eU5jUVloWDRha0lENExJT3RwWG1VVEd1Y2JGekZuVStvS3BQbG42cXFXY3ZD?=
 =?utf-8?B?aE9qdTMyTGxPTmZUMFN3NmlCb0haam5nWTJWYktUNWEwa05VeU1adnpCbzhW?=
 =?utf-8?B?N092SHN4U1ZIZ2Z1dTVObW54alB6emVZRjFjOFhsMmNMVXRka3duaW94eEJ0?=
 =?utf-8?B?ZnpnYmVqY3pQZnZjNUhKbjVYYUhpOFVJbXRLN2k3VjhRcVR1Y0NERWcwQ3JJ?=
 =?utf-8?B?RHpoeGwwTkdwTW5IUkMyd0xhYjUzY20rR2o1SjFQaGt0R2cza0dFUXlZSDU0?=
 =?utf-8?B?bnl5TXVpamNCTHVMeXNlYXRUN2t5dFJVWnIzU3UzeURkMTNuWnUvbGkvMENo?=
 =?utf-8?B?eTZHakMyOFNMUEFIcU0yRi9wWHpiNjJYb042ZUJJd21NQ0VZU1VwUG8rR3FP?=
 =?utf-8?B?cWVsdGdUaGgySW11YXlwYUFtNm9HRGx4OXNRcEZJN2MyUVZkcnZSMjJBbGRL?=
 =?utf-8?B?d3hqL0ViczZZd1JubXBEQVBLTW1ybXhUN3NURjRJN2d5ZXhrNWt4YUNtWHJX?=
 =?utf-8?B?enVBVk5wQlJDRDhGK0g5akQ3L21sMjVIaFRyN2ZVY1J0K2FLc3RXa3FsaEh2?=
 =?utf-8?B?L2VqMzl6YWtkZWJQajQwZHFsb3ZhOTJheTArdzZXYU1UQzRmTCtMK0U2QklX?=
 =?utf-8?B?d0R0VzBTZE9WVTUrYnFyNkU2c0RWVjR4R285d1ozRUsraWhJSUEzYUsrRXYv?=
 =?utf-8?B?azA4Mk1JazNNWENCcENuVWgvalRObG5mZWtDUVZXRUxqcHV5cmZBWTlvbldB?=
 =?utf-8?B?bzdTTWp0ZXpyZE5QTkxNY3FwYkpaL2ZVWEYyN1J1RnJkc1BZbWQ3RTZ2Y1JZ?=
 =?utf-8?B?cTl1N2NwaUFzWk11R1J1YmNqMkJsWi9LdkFTaHdoeXN4YkRibENJeVEvbzVT?=
 =?utf-8?B?YXJvRHFTRE9TMjUwZGVHZy8xSlVGQk0valFEa21MMDdtRkc1RHJ0YWV1QkJC?=
 =?utf-8?B?L1FZNG9aeEJ6clBla3o3NUJ0RE5OZ04zUEs5TkZQa2pybUo4YndhU3B3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjJIcnFxR0NvUjlaQ3ZMdEwwc1lNK0tNenRjaXFKTWZEUVpKdVJ5cHVraVo3?=
 =?utf-8?B?VzZPUFBiZnpXLy8zMThlbkN5Z1oxN0ZQNzlRRFdNbEpkdnNpOUVSMVJCVzhK?=
 =?utf-8?B?dXhVV25iSWVqTVFkWGUzK2xvcUtmRExuL0ZLY0cyUDBqZWY5SnhoaXliV1Iz?=
 =?utf-8?B?dW0zaEZRb20yWlllWlBmbGFCYW10KzV2T3FqYUZNNVErbmxnM0FQMHcrbjdT?=
 =?utf-8?B?OCtvd1pwTFhRR1JSL2t3VlM1NTExYXJMaTNEZ1lmcVJsUVFQTkw4TW9vZVZJ?=
 =?utf-8?B?WjJGaERocHZTVHdaRktCNUlzY0NWcHp3TGlrRHVaQ1VQYlFRd25sNTRNUkRx?=
 =?utf-8?B?cTZRb0dJbDRiZWVpbmJib2ViS0JscXoyRVg4T0ZWaEJ4OSswenYwNys4eG9X?=
 =?utf-8?B?SHcyazNETUZsOG9XeTFFaXZVWUl0UUt0VUlBUmVwa1I3ZEhtN3dEeGJnYVZz?=
 =?utf-8?B?cVU2d1NmdE5JdUI3SCtMbjlZNVdKMGpTU25zMjVvQ2l0czUwUzNLYnBoL2Np?=
 =?utf-8?B?Z3BWUG1Pcm1lbjNqcHBsVVkvU3lINXc3dVQ2ZDFaVklzSnRxMWFGdHRFSlBK?=
 =?utf-8?B?a2hCVDUzNTVIQTNnekRJdlZ4UEIveFZITVJ2bHExU08rRitTeGMrSkFCQklU?=
 =?utf-8?B?Y3Z0bUQ4ZDgxRzNrVGp3SFlpMitCbEprVjFPendXcWdOcTJWTWUvT0Rrb3dT?=
 =?utf-8?B?U3Y0TmRLM0lXWmU0WVZsVXFtY1Y1aUNIUVJDVEtHODBaSTJuK096Z1QvYzNz?=
 =?utf-8?B?dUR3R2FabC8wM1FVRmFiamtkZ2ZmL0ZJQlJjQTRUbUtMZ041SGIycmttR3VG?=
 =?utf-8?B?UnNvYmVqaXpYaUlmNEUzOVB2WkdwUlhpaEZESlR4c1lmLzFhVGtaRTRoZllO?=
 =?utf-8?B?THZJS3pDUmhMOHRVZ3R5VDF2OC9FQUJIL2Rpb1duSUtVVE1LYXlweVhBbEJS?=
 =?utf-8?B?UGVPeGd5TG1yaDVnUjBXL2lsRGFSZWV1S2Q5bG5nQUJLL0hYT2dqSXl3Yzky?=
 =?utf-8?B?dDFDZjJUM0V0dVR2OFlIMU5rZ091RlhIbm1SNlBEVk5IRkNiOWJsNVNBL3px?=
 =?utf-8?B?aEpuNkthMVNFMlhnRXNENStlVHorc1V6bkxxY0ZwdEVIUS9nU3dMOHV4K1Zt?=
 =?utf-8?B?TEtZNUlCQ3pNS1hhTy90eWtJcWZwWkdOeVR6MHVpb1BEbDJBZm1HdGcva1FM?=
 =?utf-8?B?WTloSmN4QmZwR0dxcUZSQVpZRDJsaUFMWHhBK2ZzRlVvcHBFUVNHMnI3OXNw?=
 =?utf-8?B?Y0E4YXA3clViNjQvRnJOQUZ0NlpHSUxpeUdJanRYZm4xS1ZJWHRXSWcySWor?=
 =?utf-8?B?Zk41MUMwOGUvSzAzSGdFT2U3OFZ6aDJwUDlEV1JaZkVYR0dkYWVXeUVPQWJV?=
 =?utf-8?B?MzE5Y29nWk13bjNPeEZ6OTJJU0E5OFAyQ2JLMW1aSnIvVVVrTGllQkNFU2sr?=
 =?utf-8?B?YW56ckhQQjIrcTkrQ2d3a3ZaVDRiVkovN0dXNzh5d3p3dXF4UU5ISDlhTjA2?=
 =?utf-8?B?MEQvUjU5RWY0cEp5SzRsaU5qVXBuTXRyQnN4UFNsMFdBTkRETnBnT3BrY25x?=
 =?utf-8?B?MkpOa3VIYS9xZkVyWHUzc0xZWTk3NkEwMEh0K1FwbGdUZFhVM2lNZGlhUmxu?=
 =?utf-8?B?MW1NTnphaHlPb2tNWnFPZHVaRlFwU1JOQTlyN3YwMEs5eVZUVGNIaG5hMlgz?=
 =?utf-8?B?b3BobC9LalBVbUFoWk5xWHU0Z3phUmN0b3ltQk9nV2JUUXpZbDg1elZmQTNS?=
 =?utf-8?B?dldTb3k4K09CZnc1aE15VHR3R2xLZk1BWnhrLzBvNTZubkdVS21Bd2lSLzVU?=
 =?utf-8?B?Q2s1d0E3aWdZV3ptaFoySnY0WndBMzhCRjVFRlFsYnNlZTlpNHlkSVA0NVll?=
 =?utf-8?B?Zi8yTXlmaFJNemJyV1pVTXJQUTRqcE5kUm1FTlh2MTVaQVJmMnZxSDk4MGs3?=
 =?utf-8?B?clhMN3c1cE1rdmtFaFhqNzNROTZGaEhWU0JQYmd6SEw1TzRrNHdSRXZrMWdS?=
 =?utf-8?B?ZFJ4cVdiSE5PVkhRczZVU0tRbEZUSEZsVzBESFo3YVp6WE94MG5ma0ppMytN?=
 =?utf-8?B?SXA3Q2VKaExxNDBuMlpka1VoeW1HSnJkTFdKb3g3L1Y0YkFXaTZQWTF3S3NB?=
 =?utf-8?Q?fDFYrW+jRvVoYsUBGwyLGcbsL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c94322-e7d4-449a-b1f9-08dc63cc496d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:33:43.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyrECeWFVPxMGlUG1NpgIbzGx9YYmo9Nbva9zqDMRkS6lQ5SQOOs3KuHs0HKhsvpZNBN39ARPKVoKIK2vHUfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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

On 2024-04-23 14:56, Mukul Joshi wrote:
> Subtract the VRAM pinned memory when checking for available memory
> in amdgpu_amdkfd_reserve_mem_limit function since that memory is not
> available for use.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 101a2836480d..f672205243e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -220,7 +220,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
>   	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
> -	     vram_size - reserved_for_pt)) {
> +	     vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_size))) {
>   		ret = -ENOMEM;
>   		goto release;
>   	}
