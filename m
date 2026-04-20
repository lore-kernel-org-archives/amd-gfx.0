Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79C4F588C1
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFE710E57D;
	Mon, 20 Apr 2026 12:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cjs0CsVc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9457A10E57C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqYPmCxXBM9ONchFyFqyJ4diM3erptrLVrKC4nDy5dHgSM2GJ0XwBwvKuLwiga5YqL+LnzBWX7bt1hUMJ9sbQZteZbY9Qf23Xf0R9nbJqzUPVAZGda2Wv4FmjeFQ4coxl7Oo+ZwCxvmQjdAY0B004iwiFUYVoHMRsXyEx7SU3c4WuFGTuAmpApOWkMbEXrEkqc2HRdo8P9ods5qRS+VdL2gMyTdkTTU7qy3+DSVp/aeCw4ayXlrPjYi10tLA5EXXXC9M6nzAxysBXNpf1oUeDIO1SyaRQyCFStESxBr9k1MI28y1fR2JKQOzu2/TbD/Iln0qPNLRKmik33+ydym+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lXWTmb8x+0xyFEMTcauo6jENd+vOb+zDwOLh165rNI=;
 b=w+Zff9ct8aA4VgyF24kcW0CRTu6TCSIhw3N3BSqvn6fa9X+qtVjoZyd0D6VC3CUhInS4TAaj3U5nZn6J6kdN0Spcr0P1poRV9NE5WRfNEJC9Wx4DEbKjJ5CVUfeOa8IQw1g6ruNsyh5YWoNr0QO/UlSt9QgOFEJQn/VNgQJ6dY87MvqgD8RhNBWmB894iFPlh786sHInrw4ZVFi2YFNDEZrgNRqfq34mPUio4H77krngJp2Kjc17JWfQmv3uM3jdNLqeYdwHCjGWnKxPLbIL0RroW5TrI6zYFZRan2iRHmWcqtJ28GTcGOVIGU6JI5QrZ8H/vVCqRFs8U+SQer7UDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lXWTmb8x+0xyFEMTcauo6jENd+vOb+zDwOLh165rNI=;
 b=Cjs0CsVchGc0NRZKdu1mDPGmYDb/5P9cASlA27NV1uWSNMk9basR5mCL7TUJiuaPFVBPHpYaeQ5Rc5gbAadqMPYEoAU/PvXhxVwNlXAMq3R89xsfgLfFRQDF15YUm4Urmro2Vi/DrGHHPJvmi+9RINzvWFP2fNtzTxnA6a2/KjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:25:17 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:25:17 +0000
Message-ID: <1060fd24-b91e-4079-bb01-194f90842001@amd.com>
Date: Mon, 20 Apr 2026 14:25:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu/vce1: Check if VRAM address is lower than
 GART.
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-6-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121044.155030-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 147a22f4-165d-4141-2e1d-08de9ed7e1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 3ERH1DzsevGhzoQvKx8Z1irzGCD8BhQjMxMOUv8OIp4FUftLjzbmYoD/EVRqnjvYRZhvPfvySlJNJk0Vf09PJLLgRVulL9jTBtutXAAMbKGenTAB71P5xfxn8faXJd886t5dz6up+WhmOT4tN918RcwXC0c93cSC03QMXwD4q8J2Nkrs4/ClUaWYtxA2DKnZV4KqejqDtD7d/MilmEegy/LsKvsEE4Cp9aEQ13VbLbUserKf2fR/w8+qkZEZGcna3xk2sPlS9r25eTh+xTnYZUn6gejlBWfGY6QZ2WrKNyWh5eCXaFj2uBvex6pQ9S9v2C5rRG7fjRQVGB3TbDepgyji2xtoqTPlWCU9PHkCGEfKZf/XMK8luOVs8Q64Efqdg3DiVoT48EMdxCyy5Fn0RxLjcmO8g0th+t9wmMG426j/OQxlSK6mQ0quX10cn2TLrBde89eNcNug5he5yOy9NlQwT/d49rImk1SMbRCGVP6P1Bk80wIcmvjHp1J/gpw7gz7V19JawOBFhIsRdqL8cIU2GtfcALVaRn/uzgK4UgDy95AfvFU1Au2VVlCOvpkuSkpy2GtssdaLwh6Bb8ARf/dTxa5idpYlMbM2snI4lHQviyojLk6EkbfOUvfmM4y2XIFMD3jfnK/IkdXNikJp8JGlAl+WMSnRq1Z23elt8In4K3Z6k/kRSr5RolPZLYffmFbpcl1hH5jaem9ixfXzJhdvN2lQHeYVxPgbu1RD8lU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFA2bDBlSytLQ0hIb3hyc29oMFF4amRYN1BWZDdFUjQ0dDNnNU5RWVRyQ2pM?=
 =?utf-8?B?MmNhRHcrQXZIdmU0eUg2bWhSRGwzNk96VTVFT2p4VjMzSWg5L3did1ZZa3RH?=
 =?utf-8?B?VXV5RzlvUGRHbGVkTjlaeGJDTTlIMlRMVGZCaWlLYnMzYUx5ZEFLK0RTZyta?=
 =?utf-8?B?RzRib0M2OTVRcm9pRkc4QmpPRi9zZjdXRnV5R0pnODQyNTNMaFBJS3RvZWl4?=
 =?utf-8?B?TmtjMjlUUmdoNHZmaXNRejk4a3hQVWhqRGZDNnRUY0ZvcHJpRytWazhLR0JF?=
 =?utf-8?B?WWVtdTZFME13aHVkLzdWWm9JRE5xeWdhMFZ2UCtKUDl0OW8ydTcvd3FhY3Vr?=
 =?utf-8?B?R3JiRm9MRm9UWUpUckxpRG9GVjJJYkdCemkwTXZ0eC9xK1BadWNtYkUyWUIr?=
 =?utf-8?B?bUlEWFFBM01SRE9tazFKelAxbm1qcWQzMTZuS3BNYzg3VTVWdm1qRitXeHZG?=
 =?utf-8?B?ZEl4M0pKQUNNUElrTC92NzYxa2h6S2JiMWVjVmNiWWNTTVhGWkJCOXQrSGl6?=
 =?utf-8?B?dEFnUTlsMWt0TFlTc3pNWXk4WmFLbUhiS1d3M2lRSytqaC94ODJaYmk0YjZa?=
 =?utf-8?B?K1FRR21iNFNrbXBLU2FueDhMSlNxa3crN2JDQVB6bEx0NHo5ZXV3WlhBUjRl?=
 =?utf-8?B?M1dYWm9vMnZHRmY5c1NPd0s3VFBib0FLbzF5ZVNvZGFjOUs3SkFCZEhuOWxV?=
 =?utf-8?B?bFM4ZXdQenhLK3pFOTd3b0lDaDVzd0p1WVQ0dzhNNXdPUWNucG93ZnlmaFNF?=
 =?utf-8?B?QWlGdnZrbldiSGpKY2RpaHZFem45cmpTZWY1eHNlOEZOcXgxelVmWkE1UXZN?=
 =?utf-8?B?Y084cFVvY01jN0NRcGNmeEorZ3VaVmFqWlliaE1iZ3U5bUdaQUlrZi9EeURW?=
 =?utf-8?B?VUdmZzhLR21YKzQ2Skl2ODFKOEE5NTJva2xCMXRENmpwNzZ6NDFwZ2J4L1Vq?=
 =?utf-8?B?RW52TkNyY2lEWTcwTjJHT3hHWm1IN05hQUhVQVdoeHdjQ0NWQjNVRW5yZ0JQ?=
 =?utf-8?B?UHZmbWZEK0VEMTlSZFRuWHlsQm5zbjEyckViT3NzU1RKZFloei9jRmZzdXdX?=
 =?utf-8?B?WWhyWjJ3cmMwQVc5MkdUNGg2RzNsLzBoZUZrcHVwYW9tMDNaRWRhYlNScENq?=
 =?utf-8?B?WWx5N0lEdXBFRXZobkM0OUVRclZmM2Jzb3BqVjJhSHo5VE00SjVCTGhIVStu?=
 =?utf-8?B?dDd1Um9pOEdMc3BobklIYktSWlpRWjdIMEJlNGo5T3hxdVBjcE1RMm9WOGZX?=
 =?utf-8?B?T2x1V0FCbXRXekpueGdNSldvYzJuTktwWnlmek1naHFsUDVqd1ZPUlJlWmZO?=
 =?utf-8?B?V3UrcGI3TEJvcHIyVjFwaFM0aXphb2JzNUgrQ1hMZWNMQWU4SmJBR216RUtQ?=
 =?utf-8?B?Ym5JVUsrT3lBYTlsR0M0cnlWZHQwRE9jWDlBdkVkK3NXUnhabnY4OGwwc01I?=
 =?utf-8?B?VHdtb0dlS3dxeW5hTTdHbno1dEF0a1BlYUpENy9DcWIxendNRk1WeGdLc0Zm?=
 =?utf-8?B?K3V6ZVlJRmt2UDBRYjdqV3oxRStWQkhvOWt1RFJ3TVJRRkp4RVBPUElzangw?=
 =?utf-8?B?U0duTVFmR0RtQTF0WnY1SHFjdTVSeWgyN0NhMU1HVHhqZnFzVlM0b3IxRy9L?=
 =?utf-8?B?S0NZcDdub0QzblRDWFlzYnJKTlU1dGhUaVdiWFlkZm5Ja1k1TVFWZ0dVMDA0?=
 =?utf-8?B?OStJWVdLUUJwRlEzeXc2TlpDOGx0RkpPampXdEYwbGFDU3V5NVQwQlExZkNh?=
 =?utf-8?B?NEJvU0FIL3pwYmpvajAwZFZ6TlN3UUZsMG1teW5Mb2l2OGpuSnovd29TK1VM?=
 =?utf-8?B?V1YwVVdaMWhVSS9nNVlLZis2OHlOcmFJWmV5TGR0NGlWZ08rNGpWUjZxdnFP?=
 =?utf-8?B?SitlTmpzdW5VMmpiUGgvRjE2SWl3UmcxSWhsVGxJTzE3TTdGNER1NTQ4WXdv?=
 =?utf-8?B?Ky82MDBtNkxUek1hYzgyRWE1K3ZPeG03cWpubXJ0ZC9ndldEOHBxK05LWC96?=
 =?utf-8?B?MFExaDBxSzVibmgrMEdheEtob0ZuUkFJVlNHYUNXNG16eFdMRzhFd1MxMEc4?=
 =?utf-8?B?VWFkZm81bWlIK0FCSThKRGJudndZMEdCR3hGTzdadmsxbmZKL2RCeG16cVJt?=
 =?utf-8?B?MEovenZoS05aL0FrQ2xRaXA2dm4wOFE1Y3dDYVBxMmswTS8yTXgwTEt5K1J6?=
 =?utf-8?B?T2ZqK1ZYQWxHT3VzWEM1djc4bXFPRVhjY2JlMHRyVVg0Tll4VEZEbm90MkJu?=
 =?utf-8?B?eGhhWW9mckJoYmZIM1dtMk9GS2Fjc05vQnFUczhWa0MyWnFaNGRiK1hZT015?=
 =?utf-8?Q?iP05Qkg0m5aSZNOE5X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147a22f4-165d-4141-2e1d-08de9ed7e1bc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:25:17.7223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52fBBwhcFttTN32dXB3EubYU5BDhfmB+Jc1F4b97DU0cb3UvJoWsE7GFBrf80YY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781
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

On 4/20/26 14:10, Timur Kristóf wrote:
> Previously, I had assumed this was not possible
> so it was OK to not handle it, but now we got a report
> from a user who has a board that is configured this way.
> 
> When the VCPU BO is already located in a low 32-bit address
> in VRAM (eg. when VRAM is mapped to the low address space),
> don't do the workaround.
> 
> Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 35caef5a8102e..b7b6096c1a1fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -538,6 +538,9 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  	u64 vce_gart_start_offs;
>  	int r;
>  
> +	if (adev->gmc.vram_start < adev->gmc.gart_start)
> +		return amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr ? 0 : -EINVAL;
> +
>  	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
>  					 &adev->vce.gart_node, num_pages, 0,
>  					 DRM_MM_INSERT_LOW);

