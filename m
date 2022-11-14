Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1838C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 20:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8BE10E0BB;
	Mon, 14 Nov 2022 20:58:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468FF89DFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 20:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYsAsvyr4sP4ZdMJ92vcDmuGjK7Kq5xg/7M8+7bYy78HKe2wxl/ZWc6/jQ5VhEu9OQvgX0i6eSDKuTvtcb2HdUMTLLHobw+feemY4FFjMFPmWJfDZmwapnwRfgI3THdrHHzMXDMEGKAhykn4pVpBsEOuEZRrwi4Tofo1L4VAaq1CvGdsC+le8d+VkRILCdVU77io9sWE0i9asZWFDqCHhaiHp0p+iFkMxj4SiGGp+jbY2r6xt3b+mu9o8t5DYRda8Waocty4RkhRu+RW6KbGbzPDETS7bmxgBzzpY/X3ftw1gXKXssB0bF5hPnpS+W1j19Qnkm2ZAg9aPUWtFQ41Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4dezvR3mpoLApnN5IWFxW6Y+5oMJLFm2sIYiAcyguI=;
 b=ICr4Gbor/orQExVrbIHiWM4Z2pX2hEz39LIGryZKfx1xmO7MlBxlZOiEabCnf9NihdQIBgKD2LwrrO12MlJNd6aVQiCHvpj1PqRGl2JPlAUCvW4XqVVYuYT3ctwjB8ErvhMO9YgGSpdMeKKKS97YpXgIWOF2P4ffa21UgtK/uxeZlndRy2B0pUrApUI5VRzPpn/tdl34+/zAPnD4ozsvtyWQhvJir9hvJ28EAu6uB5taPeZtLS888oOHkV++enFDG34m9eA0eIKvzX9HCKOHOF7Kx75uTlRTjll6ThsFRExHe2a+MvMSzfBTABx3D58+WwT+DZUbcWMa9OKUikmYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4dezvR3mpoLApnN5IWFxW6Y+5oMJLFm2sIYiAcyguI=;
 b=YJ9ag7edLLyJDsa6h8g58t9C0Z+sEtHP3aL/ja4y2D/g3Ew344FFd4Lxgxs2MpApuNWeR5vb4HMYlO3i6myLE6SmGhUGypk6zQ8hbeRnLa8d+bJXE8Zql5w69lgY9MZVE2AJqNRTikTWJGtHj8XrWYxdT4sdnUvKU58nGkuApLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 20:58:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 20:58:38 +0000
Message-ID: <7bd4a0c3-6895-d903-d24c-95de696b9068@amd.com>
Date: Mon, 14 Nov 2022 14:58:35 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: amd/amdkfd: Fix a memory limit issue
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221114184538.111848-1-jinhuieric.huang@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221114184538.111848-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:610:4d::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8474adf3-1870-481f-e939-08dac683008c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: es/yR3ZBD32kmJlHvvKk1yhdG+CIawm8VyfTc8Yf4dbkIpiWwQ+jWYLl0AZZCY4/BS60IB1sVMB7/YLr0uylz4ITrnO6MCdmGoNDn8kLLDMYZjFtW4glViix5hr1x7nPC40DauIrOHpAvagdlGFZYPvC5Zum3pYDWaRmZqcx+aUCjNLEhNGfg+AaGUDBFeCbVtcO6PKlxRMmIKQ/9XZU3u8+PC9J8n1rqLoZfh7cvSDZmA3H0ThDmcOf1IDgptmYHy3cOW+arRgH7A6Q6FoEwaSXG8gpGsXGWDbw2Seg8QIn7HGM+L1pMJxCD47DT9v0sz96OpetiBLrLk67l87oKqLOuJseQTgXK5obCysILEJ1CGMymu0afP6l2QSqH1uaryMZJpjdnVpgejRD2mfX4xxIi17v7gd1y0fXzgyMrw6iQMWjBFAOmSPxrm4fKfGAGX/QpIs7Psn0ZXRR4m/+xLm8FRYLu5nMujdv9uUFAiq2Df2WrICzFluI7Ck1gErssyprBtn1qlzIsbzm6wmrKba37c6+lmfE0Lx8tvU8WQdNsAK9Lo0l8GWuLgoCQRqF//cC0zRf2vJa91hIi4k3TJYzoF+B5iWTtDk9ZHTSY8VyeHlf+iyyekDv1mORkF7ltmu4H6LhablZ9x7GRChDhYuELKT123PabaoO58/qm//aLvGHpWlWD/yEukYDbI/sBpBR0u7zolJZpVyxMKQuznb6JYDjgOyUjyzeUhwgr/8qERAFJp5ITRY6TIk3MLuat3gTApToHAg84GYSzvjPJD3Ef1TgD6obQYPJxa/VrA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(83380400001)(186003)(2616005)(2906002)(8936002)(38100700002)(6486002)(478600001)(26005)(6666004)(6512007)(6506007)(66556008)(66476007)(5660300002)(8676002)(53546011)(4326008)(66946007)(41300700001)(316002)(31686004)(36756003)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVo2a3NSYjhGUzJrbkVLc1pMb2xoU2ZFNmRBeXROeVlHamcwRWhlMXE1MlhF?=
 =?utf-8?B?Q2krS0tJTTVWVWZldEpaVm9IWnZ5bnd1NHk0b1hsbmRFdHZLTTJDVllxTUlN?=
 =?utf-8?B?K3NUU3dHZUFFTXF1NVZZYldZcmhqZDc1RG5Ga3hVOFF5WUhBdUluMnBjZ0ww?=
 =?utf-8?B?ZUxDVWhYZ1ZRWTVIZDBGVnhjWlhPVGw5aHVMNE42d1FpWmxQQXo3MWFNa0xr?=
 =?utf-8?B?d3dxNFVVR0RmTWxpblNMdHNXc0xLWVZKZXUwTDdEb2g2djBpdmt0WGc3RWJy?=
 =?utf-8?B?cVgwdDkwRHJwT1QwYVovVW5vdHZoWHBucUxxb3VvczZPQ1NxTGQ3U3h5L3dS?=
 =?utf-8?B?QXVHaGk1aW1ockI0bkVCTllLSWdDbG4xQnlHZVQrOFF6ZFY5eGRVS2ptSTlG?=
 =?utf-8?B?dlNSUTlKMUJSeGpVby90MnhLUGR5Ymp0QnRJc2JVdmkwd3VWQVNGMCtPdFEr?=
 =?utf-8?B?NE0rVHJsMmR0b3FrTzZuZ01PMGNMMFN0LzF0OXlta0k3d2NrRytYc01PS0hM?=
 =?utf-8?B?YkFqNVB6MkxJM1d6cGYzeU5WVGVYSGtqM0JpeU5aUlZYZnJGcGw5UWJ5Ym55?=
 =?utf-8?B?OVFyaGl5OTFnNGpiZTJTdlFHeGlna2hDbmNZU3NDTndxZG5vYVhPaVVqNHpK?=
 =?utf-8?B?ODA1WnZNSnpGWjBpQ3Q0QnA0Qkk2YjhITVMvKzRObmE1TVgxSkNKa2k1bmc3?=
 =?utf-8?B?d1cyQUwycjk1cyswa2g2MW93cFllK2VKemdIbHdoZjZRT3l4R1hMZmR0U1JI?=
 =?utf-8?B?dFIvNlkxdEpuWW1mVmQ0RXNuN0krQ3FUU2RVRDR3MUlOWUUwYi9GTHY5NXB5?=
 =?utf-8?B?ZkxKTmtZNHBQeUpUY1cyU0pwcWtVTzY5NVlmMW13NjBSdnlweTgveDhNWC90?=
 =?utf-8?B?dXk5QTBQaHF3Z2ZNVWo1OUxXdS9zZ2Q3ZXE0SUE0L3RySENaOC9uRjlBWmNo?=
 =?utf-8?B?VEhKVk54NWp1SkloT0ZIblpZY3ByUWlBM1VSRnhMczZNZVdiTFNKOWVXeEhP?=
 =?utf-8?B?aWZ6alV2WFpud3hpSGpid0laSFpabUVpNERyWnNMTDk0QjVCSExjakNEQlln?=
 =?utf-8?B?YkxzMTZoVXVzMmZnZFFaaUVVaFlpMlFtWGdHVHBoN3lYR0hXd2ZRR09Oajdk?=
 =?utf-8?B?VFFSalFUeEtxR1ozVmlHSjR6cWErQ1N2WHFDZ3VqZm9HT0Ixa24wMmNSR2ow?=
 =?utf-8?B?Qnc4bHZOenJUV0xZQWg0S1hidkM0QWVVNWVPbkVPRmRWYXRTMHNHWlZjZmIx?=
 =?utf-8?B?NVJYdUNqOTVlMWtNcStmOG9QbDVsYjd5ZnpDRlVZRWt0M3ZoZ2ZjZ25BSkRn?=
 =?utf-8?B?Y1JXK21QNnZuN1djN2hCU002aWdvTDhzWk1XTkp0elFNYjkyajNudWNVcEdq?=
 =?utf-8?B?NTA1Qy9PSW83VFpsNTh0S0ttbEhianU2dGpPKzNTc2kxdS9PZUQ2aXNxT0d0?=
 =?utf-8?B?VnMzK0V5QmVuR3V5SW1QN09jSjdndjNWQzJodkp4c2NjRjhDZk9Nb3JHSXJX?=
 =?utf-8?B?NUVQQTUyVHpkekJ6bkxYL01kcDJQL1J3aFFFcnlUSjJNOFJhOERhTUNxTHoy?=
 =?utf-8?B?SndXaUFQUFpzSDhUS3FjMnN5SHNPSHJsYnlheU8rZlY0N1RnWDRqaVFlLzRx?=
 =?utf-8?B?OUJ5WHBDTG9OQTMvZm1MK1RMUU5aNmRhUitGZXpTbVp3V3pLN2grZzFPQTl1?=
 =?utf-8?B?Vk9HMTNvTVlnemhoYnRwaHN4T0RJV3RwRjYvdytTdlpDeDV3NDFOcTdnbGVp?=
 =?utf-8?B?Zk10ejFEdjVlSkRtTXV0QjhpeU9PbFg0ejNvUlhhakVLTE9ZT2E4Z1p3U01v?=
 =?utf-8?B?Q2VNQnVpZllFSEROMkJ0R2VTT1dOQ0sxSzhnZTdjMnJONU1VVklZd01VOFJM?=
 =?utf-8?B?Y0dWWEFOK2c1eDllYTlYVmNyMm05dWhrUTUweCtUYW96Y3c4US9WclJXaVF0?=
 =?utf-8?B?aDErbVZ4cC9zUXR4clRDdjFFa0IycXRtQUYreWRDUWhWMDRpaExpUDFzNkNR?=
 =?utf-8?B?RjJqZE1RcXFXYytYd3hHMStTM2xNRDdLd3dkRkwwVG5NczhFUS9TN0JXK0JD?=
 =?utf-8?B?YVZWdlVaRndpTDIrM3pIUHpHdUpFTHR5eTE1L1hYOUVqa3FGRCt3dks5Ymo2?=
 =?utf-8?Q?C88eu2LrDNDmP0Akr3ubI48RP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8474adf3-1870-481f-e939-08dac683008c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 20:58:38.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKRLyrT1SuPmysIRIvA+cUdd6BgUQwv5dMYWuDDRCPHxWU8VHD1zvXAzaAHNYXTzL0VBrLrXOKM/h3K+Ce2pCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/14/2022 12:45, Eric Huang wrote:
> It is to resolve a regression, which fails to allocate
> VRAM due to no free memory in application, the reason
> is we add check of vram_pin_size for memory limit, and
> application is pinning the memory for Peerdirect, KFD
> should not count it in memory limit. So removing
> vram_pin_size will resolve it.

Any idea when the regression was introduced?  Could you narrow it down 
to a commit?

If so, it would be great to include a "Fixes" tag so that this could 
also backport to relevant stable kernels that have the regression.

> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index db772942f7a6..fb1bb593312e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -172,9 +172,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
>   	    (adev && adev->kfd.vram_used + vram_needed >
> -	     adev->gmc.real_vram_size -
> -	     atomic64_read(&adev->vram_pin_size) -
> -	     reserved_for_pt)) {
> +	     adev->gmc.real_vram_size - reserved_for_pt)) {
>   		ret = -ENOMEM;
>   		goto release;
>   	}

