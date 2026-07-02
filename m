Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C592C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBF110E4A0;
	Thu,  2 Jul 2026 10:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aLxITCQT";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E05010E4A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/B9dw+Lw6H66I606p7bp6KbeJHKh8s8lYS3mTMnzR+YAifu/k40wTokcV2cd+namnTJqBLFxC9ecutXU15+mjHFqEF7jfg3xPcnO+38onoibp0Y08IA13okm8AZjUutaiJk3gDjIeNVcMKefrFbUtSjtBJvf0vPnMWcHvNpRkaf+k03/aOz1N/HkXZJKJ40cSdWYNqI6A7lvP1I8pa+hoBQ+u2aXapCf/+UJ0R8ZemwUlJgdEQUMkC8Ky32ZqBj+B81clTsg/PVJrvYUGQ8BAnxZUfYiKHkQM4IYtcXyPIK292u9VO2NOS78Amfx1b00DxCR70qBtMNoSrwaO3jdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbwWKrsVReOnsXpC1nK/7n1IkzRntMjlLP2tvsuk1zs=;
 b=Kb8yeymwgQ3Rk17s3/4r4Ro83zw8l3m1t3YfwM39gN2F1V0jLEdYURBk8ZJ8nIyTAQsDuuWNql1vY1rKbscEIB/ARPOjRJPixN3Be6300fdme10NSyeYvvMhyhh1LngDyEBDEntCfHOxXOkf5qBTAwZEgtyLrDl7n8GmqIR3/quScD6IUugKTJmmbVHSYLzr+v+cQPsA4ZeAmFIgHMv2Q6mfkNmhNoBy3oHIYcYWpUAZNkNNCvSIQYXf7ST0Zq9JEOb/4HcNICwMV/NzAVCSGAgL6a051EYPPfLwnwVTTHDcADP2kx5zwoOpiQWSY8yWyKubg4M6NtyeOo+1WeelPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbwWKrsVReOnsXpC1nK/7n1IkzRntMjlLP2tvsuk1zs=;
 b=aLxITCQTH3IEx8E33bCy/HjZf+FnfKFXdKGU9sJCR4ueA2UYMPl+tmkdowEcLvEUl3FOD6IlT8Nk735tTLm2fgyMbjn+kZn03qTp/LdPXwA5nQG+KoYyLj/27XphXp2G1HXt9Ldw3S8yM8ZP7F6OHrOqT7h//yCYMAANplMbhV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:19:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:19:37 +0000
Message-ID: <2c87cde6-4968-4ba2-ade7-5c16558796ee@amd.com>
Date: Thu, 2 Jul 2026 12:19:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] drm/amdgpu/gmc12: Use AMDGPU_PTE_IS_PTE flag for
 init_pte_flags on GFX12.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-10-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-10-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 54be01fd-10ea-42fe-6785-08ded8236b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: OaxIfLUXhBaGdKCStA5RIUeTItn1Yq1fJIdjb6zJE3Hlf3YQYs7RxuRaNF7n0hsBwebGKSBH142FSy7meCGco/zP5zPR0TMal6K551FxxRepgt4jEreUF6Aak5WVs9qPjNyrQalfogefqOi5q3CmVIpP4WDcZn3+Qfg9IU14lf6nb1GwKRa5HN6AvoMcwQ7Dp6mz17nIedfL1L7dR3CiMKkTh3pigTTJaALNphqK9vIVB9yvf1tNJ0zTzAJa+YZrb5Kg6xQlwWXvkkbn3m/6gCb1Z7PnoamSi6DfOwZsl+jtIoBrbqOW82xaFhPmjhuva9tNy8D/Ia+Wqn8nyCYDb6fpwQ1ApEfRa4JljFrQSNrUxoE1aYDLoQGg+hTxH6vYZoJE/RI6WSKWFf8k2ff7OkQYMdtrmDS5fjDlYATlro1oSSwr9N4jum7xW1xEtz9O0G3nt2yJN//g30ggINLjmvCMjzKXc+A6UZI/hB8Ass8MjLyz239MoEURtVWHWrAC8mX05lMzNAnIUxgabYJuIFkEL7nvo7SsgRMowKqTVOf30VdaU69SEEIYm8od0LckKft6ISa0GxsLm3BXjptcaU+E1S1ArJ0JqsXO/alXlsF2+pWCr+6+1fFxOvouFY95374QrZwagyh3iakAbKhpSB52oRYogdtY0DZolxDex71aeTiMF9XVY1OBxApPppffqktYqgkpcVpw5dNJCSpsyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5KWGZSUFJGdytBRlhucHN0UGY2ZzFxK3pCUEdyY0V1M0c2cThlazUrYko4?=
 =?utf-8?B?K3lxMDNoMmY1RVliVkVyMEJMNTBwWW1jUXUwZXRldWNpOUwwNTdPbUxVVjJz?=
 =?utf-8?B?ZklYbFoxU0wwcThVVE5Vck1ON0l3OEhRNFNNZkFwL0NkUTNBVnRBMk52bzlo?=
 =?utf-8?B?ZXdCbi9FdGJKcU9ISXIzenJGL3h1bEY3ZXFEemJXckU2b0hyd1RoTmtpOVpB?=
 =?utf-8?B?cXlpTFo2RHRSRlpkQkVrYVVzbEZibGFvVnpNTjZQR0ZvT3NpUnYzRlhObWl1?=
 =?utf-8?B?cjZBZjNRbE1mNzZxM3c3QU9RdTYveUhXRFV4aDZHRVVWTzdrOEQvUE5tR2Jk?=
 =?utf-8?B?MUxWUzdER2Z1UjRwdS91c1JEbitHbUFGWEU4MFR4MG1lelJPUXlCZUNLbDBP?=
 =?utf-8?B?N3pyYkhyMGgwSUJZUHZ3aENMVU8raW5mNjRkbzNWdXZ1cjJnQ0JPWnEvSDBW?=
 =?utf-8?B?V08rY0ZUR1R3SUtxNWJWVGR1TTYvMXcxSEUrelhRNjlPa0QxdDdiTEdaWG5t?=
 =?utf-8?B?UTlVaVpPWERCRGhPdytkNFRWUnQzOGtQK2wzbUQxNklIWTdrNFhzTCtIeEtG?=
 =?utf-8?B?bmtvTnJtWVJJZ20zNk9yZm1yS04wV2x5Q0VKQnlTamZ5SzZXM2hKU2lDbGNI?=
 =?utf-8?B?Sm9USmF2ZzJyWkZEMWx3RGcvVzJwSlk1WFFOeEY0TWhLcGFHSGFoWkZNQWl2?=
 =?utf-8?B?L1NtZ2FtdGtqRWZlZ1lkb2tNNU05ZkJPOHVIT2ZvK2JwK2J1ZURrRXRjSUtE?=
 =?utf-8?B?WW9naUUvUVU4dXQzdUZQYnlqbTNVcDZ4NmVLb3Z6UVRIQ3dxd1phU1Z3ZTZ3?=
 =?utf-8?B?MFVHUGlzVTdEaTFlY3pKcGlQMU9aMWszQXM4U3I4MjRkM1F4eFZydDlQb3Qr?=
 =?utf-8?B?cFNsQm1aM1Vwckp2R2FVMXpRU05SQlAyN2FuZ09SUG92VitBYzhyVUZWQ2pJ?=
 =?utf-8?B?MEc3TzlMRlNJNkYxcEdNSzlQTExJOHdCb3haZnd3NUxidlNHTWpkclh1QXBN?=
 =?utf-8?B?Tlp1bitqK2xUczcyZDJUYzN3bUJlclpTUVhvcWNxUVZWSExmV2RDMEpGa3Js?=
 =?utf-8?B?dzZHanNxMm1KTXF1OVdPVjdrTkcvOXZMQ0VJSndkczhvU1BwZ0NIVGZkYzU4?=
 =?utf-8?B?MmdzNFhTV2tpdlhFMkhVcHRjL2Mzeno5TTlFL3dHQldldklHWEFoQTZJNDN4?=
 =?utf-8?B?MURvQ0xXb29Qb0xzQWdraXZNUDBtQUhOZFdtQmVrM3BibnMzbkdpVTBkcTRh?=
 =?utf-8?B?VTBYcndlKzR6SEdvdDB1VFlRRzRLWUJnUXpNZENEU0xSU1U3UFNLM0J0eE11?=
 =?utf-8?B?cU0wL0kyTEVUTngraHFmY2V0N28zVFVJNkZVWWk1bTdnbGNFTmJ5RjUvRVhI?=
 =?utf-8?B?ZmgvVVpCNWhJSjNtVUZ6QmlubDNXRWg4cVNLcmFHRTd4UXRSSVBoZ3Vhak5S?=
 =?utf-8?B?ZEJwRlZMTlZwczhxK25NVkpydWJPQkRiNVZHaXR6OEh2aHc1NTZvVy9PbVhh?=
 =?utf-8?B?dFErc0hqcFJHWnNhSGtRdXZTeVlYQTRkRVF0UllNNHovNTdUVFgrYkhzbDZs?=
 =?utf-8?B?OHJBYjdaeG1RZGhMOWlNbStuZXB6NnB1NjV5aVFRNlJCUENERzQ0T25xdTgx?=
 =?utf-8?B?d3NJWUc5TlJqMFZMUmZheHFWYzhTcjdyeE54Wm1ZbzFHRmhiVytvWDRmSjZv?=
 =?utf-8?B?WTNUT2RYNDVpa1VYZHJnOEl5R2pFVzlRNFB4Q2NrZ0NEZGRlOHJmTlBINGpZ?=
 =?utf-8?B?Q0FqSUdtWDB2cnpOUlc4OGRsZ1hSYnA0dzFhQUZxcUtnRm1td3FSeklWNSty?=
 =?utf-8?B?ckNzTHp6OTh5UzljRkdxaitURTNPM3BiUGRrNkZsQ2ZHWlZUNGg0YWo1QVNz?=
 =?utf-8?B?bDR2Q2NyVnNvQVFCc1U5bGJlVGRQSlM4UkJXV3U5eXBYV2U0d2hGOC9aTnhQ?=
 =?utf-8?B?T1ZrQVdtTmwwaTd1OXZZRzJZUmdabFZYK1puT3pXRlEvUW5Qb0ZabG90OEFI?=
 =?utf-8?B?T0w2ZG5XRFI1akkvSGs4MTNSbVQyWC9ubVhLd2sxaEV2NG95RmFzUnN0ZjIx?=
 =?utf-8?B?bkZxQ3hWQk1YSTNMbnVvb1Q5anZqRVJpSmNxYk8rQWtaeWtZTFFsTGxRUlFI?=
 =?utf-8?B?dlV4cFJkdzc3anZzdWFmWUZxYUNiRVFidTJTZGFkRjFscEZTS1RNTGdWWlN3?=
 =?utf-8?B?MWZrQ0lNU1VOSkl3T1g3MzB3aWtBOXhJalBadUsySmtxUWNVQ1lWelp6UjBY?=
 =?utf-8?B?THVYU253a1ZVSGpjZFhSc0o4K0dUY1VjYkZ5VExyUlhCeWk3L052UkQwd3NB?=
 =?utf-8?Q?AoI+V8cZVYhmF7yYRn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54be01fd-10ea-42fe-6785-08ded8236b61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:19:37.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDvlXMeH+DO7de+ZpHiHybhrINmfAPI4jVoOFwlImVdr2gVRbPBUGfnFQAQioEws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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

On 7/1/26 18:17, Timur Kristóf wrote:
> This flag seems to work around a "fault priority problem"
> and is necessary for handling faults on GFX12.
> The kernel seems unable to mitigate retry faults on GFX12
> without this flag.
> 
> For reference see:
> amdgpu_vm_pte_update_flags() that explains the problem
> svm_range_get_pte_flags() that uses the flag on GFX12
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 299fe960b99e..c210e2463a27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -644,11 +644,12 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>  		adev->gmc.xgmi.connected_to_cpu =
>  			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
>  
> +	adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
> +
>  	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>  	case IP_VERSION(12, 1, 0):
>  		gmc_v12_1_set_gmc_funcs(adev);
>  		gmc_v12_1_set_irq_funcs(adev);
> -		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
>  		break;
>  	default:
>  		gmc_v12_0_set_gmc_funcs(adev);

