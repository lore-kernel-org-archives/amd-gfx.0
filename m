Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B07C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 16:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6000910E35F;
	Thu, 13 Jan 2022 16:03:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BE210E35F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 16:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOmg/nzNqOfQRExcHEv2BmpJtBVLahCV7UBjzHGIRI8pdqnSqDShF2sKn9aGf01ndfEwDVnsqPBh2GmYCFhR6H1arWOar87rw4FUQDNWumnvH5Aa5eRuZwM/uLaCid+VrVl9aaA5h1y9D83+LyMSlZ0vM+H7+tMni1ZoFzIBFSscKWZ5xlYDjxXxARYFAJW3Bqbun0wDUPVm5YAZ0mX5hXqG99abLeuPwUo7BPTTJO3VFdFvGwHHJky1+c6NQTm3P5ayiiwxntmweq7FF1awE2KbT+YO4NRjCk8PN3rWEva6T5uGJF+NDClti28DhdJxp3Y94W+7m06jh+W0lozW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogngIZ2O94g/petTyJWAUnl1RQbOcJTXOgVizvJ0oEI=;
 b=nVcEujfFvYgF04T36vcQJPa68WF6hnu4FB4XdGQg0S1KScHgU8U3NTnbWmvwWADUp2ihdU75pS8Roqct7EKSQFFELXjrRMSzsnVg4A88Ci9UMuK0T/GxzrXZ1QOC1nSWv5pyfb2ap3i8r/knwbi8TVcAqbNZWUhcse3UXnmGhtb8S31tg++Z3X5QSUei4lxOdlazcJekBWBZszY3MeH+qti9IIAVIyLLlPUuA+KH1Xs4X1d9W3qvWLmpWwT/gprA8P1Gpj2fu3+UzA6ri1RT3MuIdZZQ8PzYXZ9/KmNOy2Nzw6XBjNX79LSC3BQ8XQ9gCJM1Vmyh1sCyFKDUe1u6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogngIZ2O94g/petTyJWAUnl1RQbOcJTXOgVizvJ0oEI=;
 b=HwK3oWMpQblH6xX2P4U0XJT196IYvqd+Lx8m+ti3LpJ9KQh1FB64YxRCttnR9rPe1KpnPTAZ3BiX9vP233ZeFjlBSeXwwi2AxFMFmPBnpBCemqTns/UoLjxOvD+/m7/59+R9RiG/+QFk4UIo+lLLKc+RveolYF9RSk6BDXKnGH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB3141.namprd12.prod.outlook.com (2603:10b6:a03:da::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 16:03:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 16:03:05 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add vram check function for GMC
To: Xiaojian Du <Xiaojian.Du@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220113074526.29827-1-Xiaojian.Du@amd.com>
 <20220113074526.29827-2-Xiaojian.Du@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <df013d8e-84e1-dae3-9ab9-3460bb526f35@amd.com>
Date: Thu, 13 Jan 2022 11:03:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220113074526.29827-2-Xiaojian.Du@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed72b14e-1320-447f-3e33-08d9d6ae2f44
X-MS-TrafficTypeDiagnostic: BYAPR12MB3141:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31414E1D0B7AA6595DB622EA92539@BYAPR12MB3141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1miEnPXt/2mK5J4HePyK4qJQ5Q51RcL5sGG/nolcUyHgN7QsOuB2eR2FD/9NPqOq9iUCQ+kLsmWdGl1H8jHSWh1VHABwwF2vn2ar37dbAzyfER0xi58AWYheJQ0NmKoQrY/OXheO/ayuIbbXHz0iurTiBt8yU8LjBSbdX4xmJ8fi4DnvasOXocxfuIRFdW6763LKKRO3qS/EOZSHCl5Al2MbP2BrvSdJGWdqiTGECbudN9PEh9Knot81w29UZ3Sr3HbGtt1c1JGar1OolVu6oU+8+uskGrqC46tR+1+CYMF6q8VVAigQi/fiy9F2/1OJLU02UwsXuiB9khM1qHB45AU16Xia0vC94ff/zDPApWnwOxKCKDS9ini3qp8aw2HdhCwzMcMZvlJcrNJR5qvPy/4RuicxZE8gz0ppbtGPlyf/xu2+TxJ4RnzINAIuYHHQZVGQZAtAzAzzQIF2PwWg3wIqoGxKnqhyFUAhmzKCCiVX3lH/Ofi7Lt3TY5TizU+v/V/47LHAV8ua9/BfxA8sMYi+Yq+KJ5oYo/BVX57KpxtFAvp4fg5xw8uG+YOWjvsxXz6EA/BhRdByFb0hA3mRXwq8rtHDs3Te12nEvgxpvTwQtRQGF23DLqqoljZ3TxeFkx211rJVA8NnSmwj8muPUaWboM4HYj0E5/jetlAeuSKFpcVy4jIBY3dypkyG2YYWpKFOt83MVpcadPYSqwprbG4yEQyhIqBclBKUUpGPVPAmdkkR1x5Hrvw0yyrtx2p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2616005)(4326008)(31686004)(8936002)(31696002)(38100700002)(508600001)(8676002)(66946007)(83380400001)(66556008)(5660300002)(66476007)(6486002)(6506007)(186003)(26005)(316002)(2906002)(6512007)(44832011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRmVEVOcFNjZ05VbTFFN2VhbzhCcmVpdlV2cTJhOHhTaWhpS1lMVWZhY1JV?=
 =?utf-8?B?ZmxzZENRUnVDRFFpSW9FSUxCNnh3THJhdmU5VE8yWGZTYkVvNzNSUWhsY3VS?=
 =?utf-8?B?dHhQVVdHbHZYSW9VZVM2WVJBdFR5NjdnK0FRWEgxd0FpVmdrYmdhTzRRdGdG?=
 =?utf-8?B?OE45aUhacElCQUZvSlpQSGhDTS9zaVRNSTIxanQxbk1RSFBtaE9WdXBUYW5B?=
 =?utf-8?B?S0NhR2hxOEppSnVROTlUZkFLVnVLNVp1WTNXRG1VYm45dWxiWDlORUpYRzJl?=
 =?utf-8?B?N0VCaFFRVERoeVJmVis3M2UvU0E3MFdXRzR4ZVB4T3plOTFCN2VucnoxS2Ru?=
 =?utf-8?B?VmRrVjV5cldpODJKL3Y5SkdPcEhsOWRvc0xrdGhScFo5cnRCQi84R01ublo5?=
 =?utf-8?B?OHFXd0xyMml0TEdZaW83Q0k0YnhpZlBZOWJ1YmYxWG53L3lrOE5qdE9kTGRI?=
 =?utf-8?B?L1Y5QVg3d05EbVBRaWFuakZOcFk3bFowNU9wckpkRTBoMG12bTcxdjUzSVVI?=
 =?utf-8?B?TlpwS3dlVlUzdGtRVTh5cGVoZU1WMTJpd3FqMGpubTNFL0dpNDdSb1lSN1JZ?=
 =?utf-8?B?dVNWUlJYdTViZGViY25vTVVsYWhoWTRIVWJKekxYS09BaGgxNDJPNDdQc3Fz?=
 =?utf-8?B?bHM2SjljMkY1NDNZT01wQy9kOHBLTldrd0x4V2ZFQkxPNjh5Y0ZOSjZOQUtJ?=
 =?utf-8?B?SThpWmtRdFV6cCtuUExyWk5kaU82WlpaU3dNMFNJd1FjQ0NIMkdLK2F2bVI5?=
 =?utf-8?B?WVN1YlhTNFNkeFJqNlhaWGUyVjBMRFpPVjZtdWQ5Yy9Ra0Rtc3M1Tk82SEtY?=
 =?utf-8?B?QWlBTkNxQVA4UjJicm16TUs5RlBsTEUvK3RhZTVBUTJQZWtzZHlPeXZoWVds?=
 =?utf-8?B?TlhPb3Y2SkRqTlFCVExmYjM3NjZIMjhoSks0N1Bvemo0RlY2b2NXZlNudVVQ?=
 =?utf-8?B?czRXUWMwaXlMOWZmZDB1SlVWTG9RaUl3eGhGUy9qd3Z0b3VnalJHZy9uMWI1?=
 =?utf-8?B?QlJ1RzFpbFpZTGpETy92M1NvWk41Zmt0akpVSkpFN2FXdWczVW01TThISnRx?=
 =?utf-8?B?elZzNzFlR1hJL0pRS1JqWC84NHlwekhuSEFYYTVNbGR6WnRMVVJldEFrQUJ1?=
 =?utf-8?B?OE01Y3lkcGFLa2lrQ0dJYUtQbDBhSXo0akFEQkR2M1RaR1hJbXd1SlBkeFA2?=
 =?utf-8?B?NHk2OFhLMTF1ZjU0czdQUWV6RGN2Sk1LTzZTK2twNjhsZ3ptMHJTa3phSkVW?=
 =?utf-8?B?Tks5NWxlRGd0bmtoS210QVlTeXYrZzk2ektEWnIyVUxqdC94Z0VrYkV2YjdF?=
 =?utf-8?B?a3NlQ3R2MGpJTkt0K3lGTDJJa1l4ZVNlNk5wODd0VFhwSzY2V3NNZmZOMmtt?=
 =?utf-8?B?WTVRVS9oSEc3RlZxejluSDMrQ1VVYk5tMU9xaVQ0cjQyY2Fld01MOTYrTmUv?=
 =?utf-8?B?d2hnUm9oN3dReURTKzEzejVoL2NxWDVlYTU1MXdLN3lqWnpwRmhDdXdIeWJQ?=
 =?utf-8?B?eDh3bDJYUDIvRURFaGdXYWdhSUlVTkhHNUN6d2N0QmRFMTdxZjN4UkpRTUZx?=
 =?utf-8?B?ZmlobHdQYjdGK29OM2JDcnlPSDZrR0ExWmV6NGNwaDdkRTV0N3RtMnpDWWZt?=
 =?utf-8?B?aTQzd3h1VGZLRGR3dTZHYitRK0hKdWo2eCtvbjYxNEVhTlRCWkpDSzhHazNh?=
 =?utf-8?B?YjJtTzdyMFZGY3Z4QTIxSm1rbFlzemhQSjNPWW9xSmE5cDhiUCthN2FueVpU?=
 =?utf-8?B?WkN3STZJMThCYUwrWnFjWXdobDE4T2ErZzErNnBYdi9ONEJHSXVqRURLVHhx?=
 =?utf-8?B?MkVBS2p3cnpnaEpEWjlzV1RtSHB6ZHRPVmV5dktaV1JiQWl0Uk55RWpSOUxx?=
 =?utf-8?B?S0VUdDliK01pNlFobE5KSm52THkwME1GeWUzUk1aOWRyVW5sR1RuRUcxZFN0?=
 =?utf-8?B?UkFQK1RyOVlYT1hrcWZpZ1pZOXBSYXdzR3hvTlNCN1JtU1I1bnlUT1hDcE4x?=
 =?utf-8?B?bXVVeHQrVk94a2RveDRGeSs0SHB3bE9mYVlzRThEK29WR054d2QxOFowWUYy?=
 =?utf-8?B?TGdXeUlZWnFrTnB0T0VtVWlPcEJxazB4d0xrR0M5bCtiaHkvRE9XWmZ2RTAv?=
 =?utf-8?B?VjBNT2EzSW04R0xPME1RV01BUlIyQzcwelhmZ1lnWHlMeGVyWFhvMkxEaVQ5?=
 =?utf-8?Q?dK3IlE0d6i8JALmlSfBOb30=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed72b14e-1320-447f-3e33-08d9d6ae2f44
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:03:05.6540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShCyqjcPygz65d8MuYh6I8ApXOcIkuBuZEh5sG9f0q+rlROSpS/bhTFzL6FMa3X0epfLiGQz+s4LXa7CtURE/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3141
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-01-13 um 2:45 a.m. schrieb Xiaojian Du:
> This will add vram check function for GMC, it will cover gmc v8/9/10
>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 42 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  8 ++++-
>  5 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 83f26bca7dac..dbc0de89d7e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -833,3 +833,45 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
>  		break;
>  	}
>  }
> +
> +int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> +{
> +	int ret, size = 0x100000;
> +	uint8_t cptr[10];
> +
> +	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_VRAM,
> +				&adev->vram_bo,
> +				&adev->vram_gpu,
> +				&adev->vram_ptr);
> +	if (ret)
> +		return ret;
> +
> +	memset(adev->vram_ptr, 0x86, size);
> +	memset(cptr, 0x86, 10);
> +
> +	/**
> +	* Check the start, the mid, and the end of the memory if the content of
> +	* each byte is the pattern "0x86". If yes, we suppose the vram bo is
> +	* workable.
> +	*
> +	* Note: If check the each byte of whole 1M bo, it will cost too many
> +	* seconds, so here, we just pick up three parts for emulation.
> +	*/
> +	ret = memcmp(adev->vram_ptr, cptr, 10);
> +	if (ret)
> +		return ret;
> +
> +	ret = memcmp(adev->vram_ptr + (size / 2), cptr, 10);
> +	if (ret)
> +		return ret;
> +
> +	ret = memcmp(adev->vram_ptr + size - 10, cptr, 10);
> +	if (ret)
> +		return ret;
> +
> +	amdgpu_bo_free_kernel(&adev->vram_bo, &adev->vram_gpu,
> +			&adev->vram_ptr);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 82ec665b366c..f06af61378ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -343,4 +343,5 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
>  uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
>  uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>  uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> +int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3915ba837596..5e407c88c8d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1048,6 +1048,10 @@ static int gmc_v10_0_hw_init(void *handle)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gmc_vram_checking(adev);
> +	if (r)
> +		return r;
> +
>  	if (adev->umc.funcs && adev->umc.funcs->init_registers)
>  		adev->umc.funcs->init_registers(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9a3fc0926903..6c94a9712a3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1241,7 +1241,11 @@ static int gmc_v8_0_hw_init(void *handle)
>  	if (r)
>  		return r;
>  
> -	return r;
> +	r = amdgpu_gmc_vram_checking(adev);
> +	if (r)
> +		return r;
> +
> +	return 0;

This could simply be

    return amdgpu_gmc_vram_checking(adev);


>  }
>  
>  static int gmc_v8_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ce7d438eeabe..1ea18b4ff63f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1771,8 +1771,14 @@ static int gmc_v9_0_hw_init(void *handle)
>  		adev->umc.funcs->init_registers(adev);
>  
>  	r = gmc_v9_0_gart_enable(adev);
> +	if (r)
> +		return r;
>  
> -	return r;
> +	r = amdgpu_gmc_vram_checking(adev);
> +	if (r)
> +		return r;
> +
> +	return 0;

Same as above.

Regards,
  Felix


>  }
>  
>  /**
