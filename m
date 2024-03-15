Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34714C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 10:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74E91120ED;
	Fri, 15 Mar 2024 10:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IF2g6np1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BB61120ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 10:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXNafynSCL+WQ4QtXMfzYri2VzU8apmL+F0FfrEvYT1h44uTij8TJiTVHoW0/Lu3+ozCuWWdTbXJCEs9eBJc8ZQFzH4EUzJVVBgaYaBhJ1SfkkiFbdc/CLEqY2kiTGXJu5QF2DA2aHXm5fHZtIwWlRzFHuXH/Zcnz6O6FNova2SNepa3kKoAIS29k06qI6RnPxOJqodedx8BBau2+Qp+D4OVtjsAvfpO5QANAkW9O4y2TALFUA38VZ7+HpCWQbDFUVAWZ28uzAzry4Rc50pH1fOW9gm6O+s47Epl6XdZ8aMTFIH7EOzaPH6auPnPHgXEFWvGGrxGSfmBTMb97boLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UopMe5FEhMTp3oltLVXUzG+ebceCwoalomnDuZ9gSyw=;
 b=mM5g+xG7wxUhcnA8dnasJ0bwF5CdDgSdgXpBKbEXzdtBQEd8TszkHkZGNVvYs6mZHF4KZ3ZqefwMMwRYzXGfHO+9hMS13Wp231hisj7iBhDaAvrgqFS3Gtypp+HHz53qaIWm+chlCJeDLyS5rqYaQ+KKwV8gFcRwsIwiUtpUOiLzc7ZI6fgtjbo7xzwae13odcdZMFOIv8My6nPju/AL6GtAMkZcU97ZeWWbmJBP+U3QeUV/w/W/UpzPZGTf0ACbeKe2Cy3vQYgSkwDNScmGgTckE2zpiYXWDHOAQbuS8WRaj1yvhC0AI9GkDspDJr58Nk5Mn7veFrKSN3QYQhgbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UopMe5FEhMTp3oltLVXUzG+ebceCwoalomnDuZ9gSyw=;
 b=IF2g6np1Mw8pshcL5o1PSSA/gzinO/diLfSFoDy0SyYQrgCBKkukDF0mHI+E+6bO+5Fj5yWfqc9o5C9C07B/UsC0Mv5/VEAAMZUx6PWxA2JBtvZ7IeJCOiKzkCSkJQmbKBHs0V11ZQ2lJwpNn12veXCNEjFFMUAtbbdIYmEQkv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 10:14:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 10:14:07 +0000
Message-ID: <9b808afd-8daa-40e2-a4c9-365ef4bd63cd@amd.com>
Date: Fri, 15 Mar 2024 15:43:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, Asher.Song@amd.com, alexander.deucher@amd.com
References: <20240315091607.1070927-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240315091607.1070927-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: cf63ceeb-a01a-48b9-7ee3-08dc44d8a60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPyTSemWhM6QQxxS8xZrfdtTlxWRLproc1mNQ5DYSn6ruyajmWnx3ziBZMyZ9S3qlV6N71fch/31HPGb1cNOGm1hJ8dQlZ7SiIh6qh2KhhiWDKWJoKA7+ZBsHT3eMQeQ6TKwlGCdClRPuF4pxV3pWFIYSaou9joqaUNgWgwOAMfQWxio00wvZABliXfi+ntwzgfGvvWhTTdlN+aPQeqN5CuI0bHYh8qWkXNfJ0K++xL1zOq9cwJZenXcTi6eB2Tks0MRo92R9OWHPKbTHqjXEU1J3JOYpuOPXmA0U9pWMUvsHpl752KBqiLqfj/BARig2XkDwXGuRvcB5Rt7SOKHKyKn+ZlWcGIPq/BDB7f2iCztfpgq3fccvfRWUzCLD4XwOIbkwBt0+S6yT1tBY3ZkD7V/GC1IUuoWY/NqZ+LjXoZWXulavp3PbNphGu1izfIr/oIQbhMfcKLiByqgFIFBz1D+u5y4/eDYLnqYUmIvoSjsUph6pfN3DzIXU3gktk7GosBSobJx8hVlo3Gu+Cv43h6aob6bh5nYcqNV7p3fzOQT5zqqSJvfuMFCyQsiKrDo+pv6j2Eu8BGVi/yOIOmD7xC2Qu6iaiQyHH3f1N+pgOrvCOXqlqurn+GHeMM8y0Mt19bLYl5n2zh1xcNRGlmn3RLLC5Pp8A7yKWwDEZ1JVCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lRR0JKRnN4V1Y3TGlhUk5SeFBDZ0hmS3R3Sm1nMkEwcGhoL05Wd1hiY2dt?=
 =?utf-8?B?WUtWZ1EvaHo2Qmh0ODRVa25GZyt2V2cxY0l6QWJpeEQ4cm5ldWZDZUw5ckF6?=
 =?utf-8?B?V2V6bDlwNllGMG9jelNtcUJXd3ZRamdXUXh2VkNBK3VaUWd5RVgwcVJvZXFo?=
 =?utf-8?B?MjVVY1V2WGlvbUFZOS9ORmhPL2xnSEZuRmpQZ2JsUEY1ZGNnazNBQlpVL05m?=
 =?utf-8?B?ZFFlREVpQTVGSXlMZHBTQXI4K2VtVjFSWnJVTllIQUtTMHgzNWZucXZKZ1pN?=
 =?utf-8?B?Zjc0RERJc1pZWWpkVzhlYmhSUGRtUTNtWjRNaTZLL1A5eDV3SFIxUDZ0WXpJ?=
 =?utf-8?B?MFRlbW9MbGhHc3pwMjVjL0pGVHJ1NFRScG5qUm1Uby9DV2NJc0V3TGhLSUVt?=
 =?utf-8?B?Ukd6aTc0cEYwVGFDSWNrVXRKVDlTKzFEY0k4d1AzQk1pM09aeWloa2ZUaGZH?=
 =?utf-8?B?U2pkTTd6S0FJSVc2MHB4M3NMd3VNblRERk1wOHQvVjFFeVVjczlKUURWV3My?=
 =?utf-8?B?UjROZzZvOVowaUhiSUtnTHZveW4rUmdBTVUvUmFKQ1Y1OFhpTnNsczlMUkRX?=
 =?utf-8?B?OVNndk9QOFZHMElCUWlwTEQwdnU1ZS9zbWpMa1paQkN3OGhSMzhaQmxuU3lO?=
 =?utf-8?B?eWdrVmQzWTdEUGtpTFR0R2t3WVBVUDVjeXNqNU9rQ1VNb3JaMitTL01BclZ4?=
 =?utf-8?B?NjNWTFh3Uy9MZmM5Y2NBU3pMZXFEN3oydkZ2aHNZV0VnSDZJaGFKcmw0ZDA3?=
 =?utf-8?B?UUw5MGFJMWdPZ0s5YVNxUXJLQXRKY1JyUTZOZkFVNHBOSFhzYWZxM2o0MThs?=
 =?utf-8?B?NCtiRUZYbDNUV2ZXYXBCNFlXaFVLY3krUzRaUDlpajVOMjVyQTJ4ZDl2eDdr?=
 =?utf-8?B?aVlGK2FScXM3REREaUNtMElwVHV4N3paVmIzaFRWN0luUzd6YmNXaFh5c1NU?=
 =?utf-8?B?dGdpSllpY3U4YmQ5czVlSU9RYmpwd0FWaG16NjdiR2tZZkdrWHVld0o3OGly?=
 =?utf-8?B?OFVoR281ampsaFZYRWYvN1FXWktySjVHTXBldmxTaWpVQUF5UzVEK0laQkJK?=
 =?utf-8?B?SzdpK1Nla1FJUWJKZmY3T05JUjZpYmZKM2cvdmREb3hpVGFJYVJkMjNoRXhH?=
 =?utf-8?B?Q3dRQVEwTG1TMFN1VHpldzR4bTNLaXhpWXZWYXFiVE1NaWxWUXA4RzM3S1U3?=
 =?utf-8?B?aWJaRW9aYkFiejFBWjZoRHEwOXBrWDA5VWR4ZTU1YndRQXpISy9KdlpJTlM4?=
 =?utf-8?B?YUZiRnNGQ1Y5cis0ZEgydFoycVZLaVVkV2xxdUJ5L1lTdHNrRURXYVZGVmVk?=
 =?utf-8?B?K2FSZkZVS3Q4SDF1bEw5THdBaDNYNjlMM0FmNG1OOHBQVktDRjVWUGtDWlRR?=
 =?utf-8?B?cHNaNVNmNVNwK3ZLbnhMaHN6VDh5MU85MVlmbFNJdEhuc2RnZlVmS1VxOTRN?=
 =?utf-8?B?ZC83QmM0bFBFbWRCMmhyMklPSC8yUkNyT2RiY3pDYVplRU1ZUUJDMW03VmU4?=
 =?utf-8?B?RzJNYk11Z0VSK3lScUxsSDBXWnVNT1p0amF3bHd2am9VK2dEWGJxcS9LM0Mw?=
 =?utf-8?B?TmswUzFXTm81RThQd0loNzl1bjhBTTZQWFlSRUJKVS9tdEVoejVySkh4aUxw?=
 =?utf-8?B?NjY2WERBRm1jdXNEcVJ1SVVtT3hpeTN2N1daSjBlanV0aWJaUEY1b0MxLzli?=
 =?utf-8?B?TFFIb1VRUE9xdXU2cmU4SXRvN2g1WkQ2dGRGQjdGZWFUc1Q4NWtqdUwweExJ?=
 =?utf-8?B?YlErMkVaam9KaDlNZVlxWEpia1hJSVh3YUZGcWQ0UVZvNkVFSTVzZlBRU3lU?=
 =?utf-8?B?UEhyOFVYRTVFQlY3cTFUTEVTRXFOWkkycFBCTldEdU95b3N4cVYwbHVUcmxR?=
 =?utf-8?B?V1duMTN2WHZNRHlTU3FRVHp1Q0thZHZnT2R6ZmVlNkpCRVBaaUVTRXZmK0tt?=
 =?utf-8?B?c0hyb2xxM20yT0daYytHWXRDSks5TUlLOUJoK0xEN3BDSEdTR3EvMUdRWHJn?=
 =?utf-8?B?NVJFcFNBYWJKVXdYNzBqUEhrVjRnZXJtOW82emZLdjJsTDhYeUtYMkNaRFU2?=
 =?utf-8?B?MTlYK2hqbVNPY3UrNzlrMUQ4U2JVWkRWZnh4L3dXdDdGaHZzdjJqRGVjZ1lv?=
 =?utf-8?Q?u/AOXk+j76EHYX357uQz8l3Uc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf63ceeb-a01a-48b9-7ee3-08dc44d8a60b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:14:07.3194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2e3bc0RKpvD62m+l/o5iaxijw0vo4YXuysQMmEi3cy2s6gsXMVKsh/D/WA8i2U8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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



On 3/15/2024 2:46 PM, Le Ma wrote:
> To fix the entity rq NULL issue. This setting has been moved to upper level.
> 

Need to call amdgpu_ttm_set_buffer_funcs_status(adev, true/false) in
mode-2 reset handlers as well.

Thanks,
Lijo

> Fixes b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level")
> 
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index eaa4f5f49949..589a734982a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -431,16 +431,11 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
>  	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>  	u32 doorbell_offset, doorbell;
>  	u32 rb_cntl, ib_cntl;
> -	int i, unset = 0;
> +	int i;
>  
>  	for_each_inst(i, inst_mask) {
>  		sdma[i] = &adev->sdma.instance[i].ring;
>  
> -		if ((adev->mman.buffer_funcs_ring == sdma[i]) && unset != 1) {
> -			amdgpu_ttm_set_buffer_funcs_status(adev, false);
> -			unset = 1;
> -		}
> -
>  		rb_cntl = RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
>  		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL, RB_ENABLE, 0);
>  		WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
> @@ -490,17 +485,10 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
>  	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>  	u32 rb_cntl, ib_cntl;
>  	int i;
> -	bool unset = false;
>  
>  	for_each_inst(i, inst_mask) {
>  		sdma[i] = &adev->sdma.instance[i].page;
>  
> -		if ((adev->mman.buffer_funcs_ring == sdma[i]) &&
> -			(!unset)) {
> -			amdgpu_ttm_set_buffer_funcs_status(adev, false);
> -			unset = true;
> -		}
> -
>  		rb_cntl = RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
>  		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL,
>  					RB_ENABLE, 0);
> @@ -950,13 +938,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  			r = amdgpu_ring_test_helper(page);
>  			if (r)
>  				return r;
> -
> -			if (adev->mman.buffer_funcs_ring == page)
> -				amdgpu_ttm_set_buffer_funcs_status(adev, true);
>  		}
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>  	}
>  
>  	return r;
