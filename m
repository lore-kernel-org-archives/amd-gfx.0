Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E27C6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 07:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB62210EA53;
	Thu, 22 Sep 2022 07:19:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C2310E5B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 07:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulia/JDnAFfVBmu9MBkhuE9A4qnweTzFv4P+25u7wNGYNPYHw46XwsyRSyaoGL7ZklTdyeU3ocQulT+wHpu7BWBcdH7eaM3aZ7vpKsyVCI34o9vZ8RMiGIGgCUQIXC47HVVBO3hcDINkSoM5Xq/rAiYnb4LB2yiAQdodTZG46vlKGE4FegozpthFBvZLWpx3Au3Ifp9dq27OsWjnS5YPqeN+LT3lyu/fx+0kutcS/KYAihhsGFpnLUQ1FAHpPI0Bzw1ZBBB+WDBNaOzDc+8wJiyKdAGOV3MAMm9K1CajXXl47Aj3Y83lUIksqRrWUM0x6JyB2gy9M+koxdqT8LBaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6gACdBntHaV7nrkTaJB4gp95dhHEK2fIx9BeVgO+4c=;
 b=kv6wD1DUJ0HwIGI+8QfclJGP2LhcfwyGs1uVWk4knE8fGdqCLXVPDI0SC+BhdOqTGJZgCB41GPVvsVFGSUvQ07GB+7+cF+lx3N0SZaXBP/I+f9iewN5wONbyAhJQi0W/YL+Z7M5Hu56NeAwGENnYwGwZp0Y50JCD6GvvLFIn6auCnIFtkDMKl2+h6dv37xocZMGHRZE91Nyngxq5j3Loh1S2TG3Q0Z4gTYw8JMDt3zh3nssImfUKpwVlwwTCUxTJad0t9GB59wThhZeYCUguzWlj381mNlSY724u9DKf9Mk1qxK2VnAvkh4OpA1ZT/d+2ZigTVAb/eFMSYOrYCDERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6gACdBntHaV7nrkTaJB4gp95dhHEK2fIx9BeVgO+4c=;
 b=mXslTTNBCxXWBTp8Gw2VSkZILqxMeiV2Tm+pEeNmVA/ZskovOtN4FIyL4N2xuN2KK36t7f4Uml5ZA5y6LuMpwnMQ1YhrczP70w1FURJXDTmGGiL1tHRsb4ijOrMuoLhbEME5HUt5f+lKqhA9PtLy+LiEkZ1G2EBwmd6Xfdaxiv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 07:19:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 07:19:12 +0000
Message-ID: <22bacb5d-6bd1-8c26-71fe-567952f09b11@amd.com>
Date: Thu, 22 Sep 2022 09:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous
 pages under xen dom0
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220922071133.927436-1-shane.xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220922071133.927436-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0d1b9b-bc36-4d80-5294-08da9c6abf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jRFa8KdIaF7ToqzhiItay6aHV6hLdFqsfEAfAe5qx5DlFDe7WnCGCLGgSBQSrXg8dm1nhOxC7U8lDVUa79qT6gqtFzEl0fyXg0eNCZsutwN5v69sdDxeq/31pacnLKQwvYhlUycuasvr2TfnNMF3zU0OrFYA9MsCxav6lOB9ucfv6S9XVqGx4MlKmonNLQrylm1XCiJd6wP7vazZUoA6a9dHzTULCp34BBmMJHYIwETM0rnjDKU0GkWCJCVEgCxXIKsKvVtJj69Wt6OpSknpMDZki14iPGxMfxyYn3nzQndkvJt5YssYEIOHLHUOEl9vefnhSOIH5EGRL88lgLNYjB7+8Dfk2gHmfPTIn/4l7ryJZYaytCLdoXmPy55GjwQmL4oVmuC+1BN2O/dO0uqIWYdN+vrsnzm4vSsCd8Vh2Ywv/eY+3qeJ0qlf5hoWRUd4Dhv9jpi+DK8uRTunPISELBjKyTFmyIXUVtLnVpkiCAh5AKJAyWQ8EWho4EwMzzR4chsVHnJPiB5eALouAqtLdDoDwG1yakgVxv5CCL7HqCpRS4o8dabvk1e+OEoJgJBADLMk9LybxEzjuQFPpvZvyvYDPrpy1UBEmtqqiePwaLD+/UApAr5jO4fyM+gBYIeDAwuJw3gS0w5JjzOAhsbimp4Jw27nawrZw6spAXbSZuouodnV487qWirgjiTH5O3f6PcKixFn+vOxidlUGSLRwoW+sUtwUXdVes16b4NKngZBd2sWw/luB4Wp9Tb8BUqZixhrTsRaZOWaUWt/SM7eoO6kCAEx6sxeHZMN8gj2Oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(31686004)(478600001)(6486002)(6666004)(41300700001)(66946007)(66556008)(83380400001)(8676002)(66476007)(186003)(316002)(38100700002)(2906002)(26005)(6512007)(86362001)(5660300002)(8936002)(2616005)(6506007)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzY5U1R0UXhVcm5Xc2V4QzAzcXdIZHB0bEl3cm95OUh3OHR4RXBOL01rdUZx?=
 =?utf-8?B?L2J3K1B6UmtQQnJCTzNUaHNaY0pDeTY2WGxHL1RJSk1rZ3BmMXZaOWhKQVlq?=
 =?utf-8?B?SUpnT3gxNjZtMjZidmtJbWM0ZUFTSk1LYW1OZWtnZUFhaFI5Tm9jL3h0UGlR?=
 =?utf-8?B?ZThXQVVKT0duZ3BTNzB2THZKV0lsTmNVVlo3ck5ESStCd0lSR0pMbjlaZkJL?=
 =?utf-8?B?UnEzVndXNWZwN2QrV3JySUlDRjJwR2YvOUxSaVBaaWd2clNBTGFWN2VscGth?=
 =?utf-8?B?MWptZ1lUbmtTUEFocEtUczVtMVVUVEtGQ3dhYjdHWTBRVlloRGpXL0dXZG5w?=
 =?utf-8?B?dUNjVmtDbENBbjlxalJxWWR2cFJ2cUlva2RUT0liUHYxZWUyU0cyaHBBems3?=
 =?utf-8?B?YTR3RnFpMzUxWld4UDY5SXJYMFFLUzc1VHR6SVNPU3ZaQ2x3K0E1T2FPTE1I?=
 =?utf-8?B?TTVxSWt6THVBSDl4bGczK1FXUGQ0U1cxeHBja09sbW91Unh4Vms4Zm00dDh6?=
 =?utf-8?B?dkdYUmxjV2d3QitEMXdyUkllZm9CUlp3MVBNSm81cGNMUlpJTTBjVnYreXJz?=
 =?utf-8?B?cU8rYnlYTDlSMDNXc0E4SFlpd1p1YXNVTzRpdEVRTVErc1pXazNsNVFLQWZs?=
 =?utf-8?B?cjNLZGlUNyszdUtuSXdUZmVadGRIVDdMTzdaVG5WR1laMWNMdkt5a0lFVjRh?=
 =?utf-8?B?dnQ1bU5jOThOM3huWGwxSnhIR3BGbGUyZVBLRTJhRndZdlFIS09haGVLQ1pj?=
 =?utf-8?B?N3lEcmJ6aTJZeWpUSW53RmZKOEJwbUptRkhyTmgwcEQ5RDNDRzhvVkI4cURQ?=
 =?utf-8?B?NjdxSERoNElFVE9SUUJ6K2VoendIc3BtT1hKL0t6L3NFbjAyWVJsbTdVVTkz?=
 =?utf-8?B?OU5JZkwwbjJ4clRZK0p4aFpONnViR2x1TVMzMEpXT0twTEVwRzdEYVBZamh0?=
 =?utf-8?B?VGJGbExETzFuQ005MktaVUorZGhjNEJVV0pBZGk1VDlNN05kSlM2TlMwdmVV?=
 =?utf-8?B?MDdPcWEyZlprY1RLb3Q0MDFSc3krSnozdENzQ0Z5dGNEcFE1T2VNcytybUpP?=
 =?utf-8?B?YXI1b3NYYStjZWlFekdHS3lxN0toeS9nMkJmNStXa0hYdTBTdG5uWXF1YmdP?=
 =?utf-8?B?MzEvSHl2WWRhbHRCNG5nRUNpWFFqNWZaVXc5SlJsendnZzRaUHk4MWhkVHpJ?=
 =?utf-8?B?djJINEN2Q2dsSElnbFQwQmNLNFRhWHdSTWdMWm8vQ3QvWFpHWk9saGdnZlNF?=
 =?utf-8?B?b1BweVZONy9wdzR6MUNwTkQxU1dub3lvVmhTZmdvU2c2UHNRWENpc2pYS1U3?=
 =?utf-8?B?WVhVU2MwdlRONmxHWk1nUjA1Z2s2SW5LcEFOSU4raFRmSmZaU2lseE9pMmJr?=
 =?utf-8?B?eW1xdTM5K2tqR3pCT0dOQ20rVEVKWHZmQVlYRi9EQm5Nb0hMeC81R1BXOTZY?=
 =?utf-8?B?UnJ1TzE4b3JBZlUzZDRkV3BDODVKU21jUWcyTTV1TDhuWEtYMXUvbEZWd0dz?=
 =?utf-8?B?RkRaZTRpZUp2TU92eHgyU1dzOWRNRFNURFBDUGc0ZEVyNEpDUHF2MVh1T0tm?=
 =?utf-8?B?andoWkJiWmMzazd6Y0Y2c1RmV3hNLzFKMEVkd0VqZ29xMDdVTjlTUW5DNzFk?=
 =?utf-8?B?d2F5S0FDTE1hQUFJa3NBa3huQTIrWmNNVXhkT0drTXdZKzZOVkhGeE9mT0li?=
 =?utf-8?B?WmlGQjNSNFpJaWpzT3dXbmRhV1lXMDZMQitNK09pRFV3dTZnd1FQdEwraFdQ?=
 =?utf-8?B?UW95YittZk1LVXFuR1lWalRuNlBmSGJUSElpSTdkUnJxei9CdisvTWd6eGFM?=
 =?utf-8?B?bit4WmY5VEVmdWt2Wm52RWREUzhiS2cxMWJwYnVzZUNQTmtUVjhXWDMwTkMz?=
 =?utf-8?B?K3RWb2xCelp0MmdmSXh0dzZRNkorZlBqWnNpdWJjMkcwMDlPdi9QVFVSZk9M?=
 =?utf-8?B?OWFldFo4OFZuK0lZVHlsVU40V3ltY0xrVWVqZWNQMXZES0JmM3MwbldQQk1L?=
 =?utf-8?B?NXdlc0V5V0lHTzFXSjRIRDFreE1NL2w0K290OWVsZEZ5ZndQZ2J3enhKUndQ?=
 =?utf-8?B?VUNQd1B0M3FjQUhTY0VINGxJZjJkZkJwRlc3UnQ5cnl6eEdOeEhJOC9HYU1T?=
 =?utf-8?Q?YcbLwi8+yCTg8cTU81Erh7Vg8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0d1b9b-bc36-4d80-5294-08da9c6abf8e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 07:19:12.3556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiDV1sSq/Qvj2arqZVcM9aCGtkF6InpUFL4z3ZaxGLikiNB1YmNfnMQLJj6aryxj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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

Am 22.09.22 um 09:11 schrieb Shane Xiao:
> [Why]
> sg_alloc_table_from_pages alloc too large continuous PFN pages under xen dom0.

Well that sentence doesn't make much sense. Why should the resulting sg 
table be to large? For what to large?

Regards,
Christian.

> However, xen should check continuous MFN pages in range_straddles_page_boundary.
> When range_straddles_page_boundary return false, some cases fall back into
> swiotlb process and the continuous allocable page is not enough.
>
> [How]
> In fact, xen swiotlb set max_segment default value as UINT_MAX and
> xen_swiotlb_init_early already change the value to PAGE_SIZE under xen dom0.
> However amdgpu driver doesn't use the value, which may cause issue such
> as swiotlb buffer full. Add amd_sg_segment_size according to iommu setting,
> the details are as follows:
> 	iommu setting		|	amd_sg_segment_size
> -------------------------------------------------------------------------------
> 	iommu=on		|	UINT_MAX
>      iommu=off && swiotlb on	|	IO_TLB_DEFAULT_SIZE(64M)
> 	xen_swiotlb on		|	PAGE_SIZE(4K)
> -------------------------------------------------------------------------------
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 134575a3893c..d081fcd22d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -80,6 +80,23 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
>   				  false, size_in_page);
>   }
>   
> +static inline unsigned int amdgpu_sg_segment_size(void)
> +{
> +	unsigned int size = swiotlb_max_segment();
> +
> +	/* size=0 when amd iommu enabled */
> +	if (size == 0)
> +		size = UINT_MAX;
> +
> +	size = rounddown(size, PAGE_SIZE);
> +	/* swiotlb_max_segment_size can return 1 byte when it means one page. */
> +	if (size < PAGE_SIZE)
> +		size = PAGE_SIZE;
> +
> +	return size;
> +}
> +
> +
>   /**
>    * amdgpu_evict_flags - Compute placement flags
>    *
> @@ -760,9 +777,10 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
>   	int r;
>   
>   	/* Allocate an SG array and squash pages into it */
> -	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
> -				      (u64)ttm->num_pages << PAGE_SHIFT,
> +	r = sg_alloc_table_from_pages_segment(ttm->sg, ttm->pages, ttm->num_pages, 0,
> +				      (u64)ttm->num_pages << PAGE_SHIFT, amdgpu_sg_segment_size(),
>   				      GFP_KERNEL);
> +
>   	if (r)
>   		goto release_sg;
>   

