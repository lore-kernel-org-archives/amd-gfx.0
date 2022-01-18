Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96275C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 07:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1070E10E199;
	Tue, 18 Jan 2022 07:41:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E428F10E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 07:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSCr6859KHmb5S1+7ibfx7mR3h/jl6n1z7ONvi96aqa1KlPqPA9WMZT/cfXg7LryEzoyCDQeGmXtReoUCYjcc3utLu4Hs2cbRt4qavAiJJ/xCbQezwHR0mbPGEDW3jJCdl7NQD8a45PBD2Lk1Ahn6vbp1c8vOYXyde1jLZkVj8KskZYDIuTxUYEFNyPsJieFDtcQBzVVjtf+P+4wmVCRZGMMhW5UTpKsUFmXNyMPijTStla9LFEBM4CygwJ2YBSmP99CpYZe86U9URePXQBoOiN88hfIfn+jUDrn02DD4SstCLR4XHxnm84TrtKgqY1yWuLEVDIn29OHy9PTk0tj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mKc0SlxxHAPtsiZ88MDG9H56qRlmpro2HvRjWejnlI=;
 b=M11YAcs2sv0KvRmgNEYY56f4q6+xIgstyNW0Dzm6m9gMWPRPeQOIp8JA3qltErZjMXgTKVKngg1uBFH5JXJKFPmc9BW6PNTvG+175xfK39smgWQT8R6fqzjjPYRmeQHVYdz/7EbSCZStGb5lQ+EVS9PZHzxVspmJMIgp6LiaqBHtmPiYgKYSVLBwoyn4E3wRt4Tw3gdH5IFl/CmAQVM3RncvKaGEvn7vxVpIhH32XYenD1vhFJSYL5+lbwv/SbPD9LouFjfgWDelv7JZ8yHi5Y+K8Q4LeuvKb9IqZolftlfA1cA43g8QeZfG6Qn1Wl5xWFfq6cBkdf3h1gtxmUkOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mKc0SlxxHAPtsiZ88MDG9H56qRlmpro2HvRjWejnlI=;
 b=d/aTgdLxmSo/GjVx2Ml7MLq8NHnlrfgTFEQxqq+3IDXy0sy/N3aCHlMoFcEO+376AwstPbX9SXq0sgDtXSS4uQ5/wVISnwBrxTnAzB6l99vEKBl7h6UehSyrkqjD17L7D2CffIQXGX8rLV9pSYsE4QbecVSPVmQ2eSgRTjMjR+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 07:41:08 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 07:41:08 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix debug sdma vram access checks
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220117234347.3820493-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <03871641-f2e5-f999-ec17-df60630d36c2@amd.com>
Date: Tue, 18 Jan 2022 08:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220117234347.3820493-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0154.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 075426b7-2e03-4fc8-6efe-08d9da55e3e9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2591D52DF67109DB11912A8283589@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZ7SY52DvWueehFGkqKy5YixmUipGRVaGiQTNv+Ts3pB0vF6yf/W+dvwrYeqGSFxzpn+63FSzlAvyqUGdVcZZD483CM+xblP8T6ToNzdq0KAbbWVZp774u8Mtj6HcD2kerK1M5erCczr/sStIngRIAMNVT7QHHMlOWki/lTgb/l8RD5JB3bvzx23a0I4L8lGtHOHUyJw84VEsMOuRpMoxyG8ZC4TK22bJGPAwT4mrl2b8a+XXCoHVTdgzcwMl7GqVmS7QkUb27KCCwTjZ1tEl66Qmmmw4s+vNcWAbt6UylYcUU7YbgWRH6r6hpDcOSF9qeJzJouZXylWp1n+mphU7H5pH2/wRfrYxX5P6X6r36SP3TGyNNn6Yu4Nh1DWntoYObF2pXgkr0z7sZ+JXHbqRt58/B93jOX2qBBDdejA2hqmI6K1QczzKVHYV4uzD9cpuYFvi3ALSAuGrnqkZbCc+tmmFXFsl5eFqH+bphj00NlpTgZjEBg4nJrcvpyU8+WNQq8FE0GWc2Dn9oeMjpbCIbUmpGOLrLxsTKIesShocCdiprP/4jmghEHuqoVEihrRPp+V6sTVT2UjlHUFv4dmtySGH85rZN+F7sK/7lklfyf0hzRAMUoDzDxGoDNMVphYlH7R4n0OaMGe1f/dFa5DQXoEIlj49K5hsbT6W6303ZCluM1jumViXbmlI5kZMLTAB5tPQtiQoQ3kGMSKEPmWX0iqEgSbTnotnVu7BOZ5t4jUc60vrvurlPKqJFAa37KC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(316002)(6666004)(508600001)(31686004)(31696002)(2906002)(86362001)(36756003)(83380400001)(66946007)(2616005)(6506007)(6512007)(66556008)(66476007)(38100700002)(8936002)(6486002)(5660300002)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHg0R1BvaGV5b2k0T1E2UmZvZ0pJdnhXVjNyMzdHVnh5SnM5OGt6c2toZkMw?=
 =?utf-8?B?WXJvVTgrTlJKMUNaTnY3Vno1UDgvQTZUYlpKb2owOEYyRjN5NXN0cmEyN2sr?=
 =?utf-8?B?WnVHY1NqbTNXdWpQekxqSE1WUjBJZEpIb2ZEclVyZFdyelNXYkJ5dng2TXhP?=
 =?utf-8?B?c1VsTHE5WFRVUGZyYWVSWW15L01KWTloTitraStlV3ZBZEtBTmp5MXlIZ3pV?=
 =?utf-8?B?OVlkYS82OVdBWER2OUtlVDZsYTcvUGI5YjJOeUpTZHNDa1EvdjB3dUVGQ09z?=
 =?utf-8?B?UXVqOUNDSjBuMUVCUlFHTC8xRThQb2hsVmtTWWVlamRwK3JCVEliTkd2MXd1?=
 =?utf-8?B?R1JaU0RUZy9yVVJnTjhGUkkwQnlUeXo0ZTlsRlhTZklOaVV5Q3VDOXc2dVhY?=
 =?utf-8?B?NDEvRGs1SW5PQXFseUk3V0pUKzZVVytzb1FEWko2MWpuTlFzZHJab2s0MVhw?=
 =?utf-8?B?NFRlaWtQOUtyZy8zYWI1Z0xQMDNNM3M0SzlodHRmbU5ydE5hS01BTkRnR2Fw?=
 =?utf-8?B?c3FOd21yNXFjY250ZFdUakk1WmRDQ3JtaHE1SzJya0x2VmMyV3dnakxSbjlt?=
 =?utf-8?B?Uks4Z2Vyd0FleUg5Y3RlbmMraVRQYWkzM0IwNFYzdlBNcGlQVGszODJNQTVr?=
 =?utf-8?B?ZmQ0QXF0UzdDRW9kQzloK3krSGx5TThpSitkbS9EM0VJbVNlTDREdHB0V0Qx?=
 =?utf-8?B?Y1Z3YUFBRkdLQTl4Tkd1cE5OK0ltcVc0L01CbE1QRjBUTk5vdCtnajRGazhH?=
 =?utf-8?B?TmxuUFp5U1ZhMk9xRFgzZWFFbWJnUlZUdmNCK0EwUEFNNjNxazI0NGNRQmkr?=
 =?utf-8?B?dmwwMXBGQURPOWd5K2d4UlhEaWRiSmU4NDAzOTBXTkRLbkkrTnpVeWRGUFFa?=
 =?utf-8?B?M0g0eXE5RGlZRkUvQkZYWWpUdHYvSVE3NFg5cTlyQTMwcUJmS1ptS1hQLzIy?=
 =?utf-8?B?ZnVDblBLZ3h0ZGh3UjdOb1VqR0VhV0NxdEhJSHNSM1pmOXZqc1RyRzZSRFQr?=
 =?utf-8?B?aXFEOWhEZk1tVkMxeDl2MEw4eWc5dzk0VGFZN2JNN1QwNUFTQVRCMlhSRkZ4?=
 =?utf-8?B?SnRjN1lKVEE2SkRkNFFSbENKdjN4ZjR4VkVqQ1JYb25SY1BpNCtteXJld0hr?=
 =?utf-8?B?TU04UzAxUTJKdUcvWkNiL1hsRm5nREVYZCtNenFsNGdLbnN6ZGdrM3k1S2sz?=
 =?utf-8?B?ZzBVRmZIdkRKV1VSZzIxNFROTTdwclBXN1kvUTBWNTZ1bWV5NnlqZmY3SXRY?=
 =?utf-8?B?OGZXdGpmdmlzb2JRUklUVWNwbHlyQThPMVBPNnJ2dzJMWVJ1OE1BTER2Q2hG?=
 =?utf-8?B?aXRKWGljOC9ZNGE0Wlo4VktGSmxITmVNeUNxT1lwVDcyYVZwaHFzM3dkNVRR?=
 =?utf-8?B?ZEUwdmI4dkJ6VjNJUUx6Z3IyTU9KNEx4djJLa1FFTVBsMDY1NnAzeUJTNW5W?=
 =?utf-8?B?MzJPdmxGWXgyY1NsaVVMWGM1ejQzZWtkNmlCRDlRVDlMOGlHNkJCaUthUnBX?=
 =?utf-8?B?WERnTGkzQ004V2VTZGowRjdJdUgrQkpuUnFidWZFcmNhS2VKWGlNQVNWSmI0?=
 =?utf-8?B?NVo4MFhiUWU3Q2UwS2IrTE5WMEQzRy8ra0JORGpJaVA4MXFDLzk2SXNiK05R?=
 =?utf-8?B?L0VwNDJscUdxelY4S1JMbHZJdkM0NDFiZ0w2ZDI0UWVtaFRBUGVodC9XSHNX?=
 =?utf-8?B?Wkp6cVg0SUdQaE1XK3lGU2l1Z0FuRitwUkxOcjEvUHVRWnRyWUtMMkZ0cFJQ?=
 =?utf-8?B?eFF6dE9GTk1PN0c0S2ZqUGdQZ0p6MXdGc25sUzdmYkhlZ1J1N3kzLzRkOFQv?=
 =?utf-8?B?TVdtYUQ0QXRKNm05cEg4TTlIUFVvc2lCWmZWVEhnblV4aDQwRXVVQTJ3dzdo?=
 =?utf-8?B?UUtWNDVNQ0Eyb2V6eXJJR1NCZWF2WllpUzVBWkd4RDg0SmJMdDc4RlNiZ1FK?=
 =?utf-8?B?ZUpGMmNSeUZFM2pIdXVRMUtmTHVsY1RrSzVVbnArbUsvNXNuOU1XeGk2Y081?=
 =?utf-8?B?ak9tcExYMDNheDdTL2pYOVhmeCtZaWlPMlorOWg5TGVkeE5raU5uMDB5V1p6?=
 =?utf-8?B?L1FEMVhWNkwvR3BUSzFvYnFKSUoxK0VTVW11M0IyRkx0TmZUc3M5eEpOSjlM?=
 =?utf-8?B?ekZCQ0xsejFCQUxHdUovNFc5aUM0RXlmY0xyUjdlSTlsMllBM3N0OUp3T2Nw?=
 =?utf-8?Q?o7skicWhJ8SG3AJq9WWlfHs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075426b7-2e03-4fc8-6efe-08d9da55e3e9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 07:41:08.1843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY/bMFl/o88mmPgnmvJDqrW05/k6LlJS01VBH/mkd5u5s8uCBLbqx2RWhyJLkWup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.01.22 um 00:43 schrieb Jonathan Kim:
> drm_dev_enter returns true when accessiable so correct the error check.
>
> Source VRAM buffer is reserved by TTM but not pinned so the gpu offset
> fetch throws a warning.

Well it throws a warning because what you try to do here won't work.

>    Get the gpu offset without a check and then
> double check to make sure the source buffer hasn't fallen into a hole.
> Otherwise use MMIO access to deal with non-contiguous VRAM cases as
> usual.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6178ae7ba624..0acfd872bfef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1440,6 +1440,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	struct dma_fence *fence;
>   	uint64_t src_addr, dst_addr;
>   	unsigned int num_dw;
> +	bool vram_is_contiguous;
>   	int r, idx;
>   
>   	if (len != PAGE_SIZE)
> @@ -1448,9 +1449,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	if (!adev->mman.sdma_access_ptr)
>   		return -EACCES;
>   
> -	r = drm_dev_enter(adev_to_drm(adev), &idx);
> -	if (r)
> -		return r;
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
>   
>   	if (write)
>   		memcpy(adev->mman.sdma_access_ptr, buf, len);
> @@ -1460,7 +1460,18 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	if (r)
>   		goto out;
>   
> -	src_addr = amdgpu_bo_gpu_offset(abo);
> +	src_addr = amdgpu_bo_gpu_offset_no_check(abo);
> +	vram_is_contiguous = (adev->gmc.real_vram_size - 1 ==
> +				adev->gmc.vram_end - adev->gmc.vram_start) &&
> +				src_addr >= adev->gmc.vram_start &&
> +				src_addr + len <= adev->gmc.vram_end;

That code is utterly nonsense. What you need to do is to use the 
iterator to get the real VRAM address.

The return value of amdgpu_bo_gpu_offset() and 
amdgpu_bo_gpu_offset_no_check() is only valid for pinned contiguous buffers.

Regards,
Christian.

> +
> +	if (!vram_is_contiguous) {
> +		amdgpu_job_free(job);
> +		r = -EACCES;
> +		goto out;
> +	}
> +
>   	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
>   	if (write)
>   		swap(src_addr, dst_addr);

