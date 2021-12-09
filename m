Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16B0C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B924510FB79;
	Thu,  9 Dec 2021 16:55:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1ED10E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 16:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQVrzkAY68367y57DUiPZmWjcpr80c7AlAk4A0pFPPy6fDC7jgoebi2JzqEyvajf33MKoQ7W1oOEOLZKn8wzI/mh5WNecitdsSiv0/0oFDukTqRNukxeJcxKZR7MEnK9ZlgixI6X9CgxjS6iRvd6LP3c+CKZcTrn3rKioGt7TTY7CyNm8QnPTCb6AyD/tUUpeyyh5ZQukBSyUdpYu1ZzgqzVnfb2/I/BDkYnRyGXQstIJ00LVSKBsMEnHvm+k285RZm5y6VuoQxRjvQrX9oigrQI4+7XRIGt2VaMuRRLj79TtZ30Fsd/LmP8tAXzaI6tovh8ZdXGpqjyCanlQwGV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3gqljp42SpT8YoLseUH1twyOGkKguBt+KHwudXC4SI=;
 b=meTMLuX81fQTKpge0nrNJfbDfMdchss6NcgGgUvzxbnzW3wP0QfvkcL6/yVnTCPAZfIcJynAdwNDipm6LKWatisJT7O0BDeCjO1QVOADcgd4WqROeHE2fgHeqyd5t4+WpTvV9EC/G8yqKOWjgue4YUd0XFFPJdjjbHzYXhq+E5/sQk3K8wOyFgoTpUvyHdhmx08Vpeergo/WrqkOE30u0Bnpxb1NNuVc8vSbP/oxPyPO8RSTsrIAtY6IAcW+ZneGS1/VYNQ7RMKd2zjomAIWAjMsuKK4hqt1fHyD0EFfgvEqu4SpAYAavHJXXfKu7UvJpugVGcHQl31xHOxWgQoL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3gqljp42SpT8YoLseUH1twyOGkKguBt+KHwudXC4SI=;
 b=d2r1IIOGnzalMMT8jPxCCAyYzIehhLlr0m0oHogrA/YA92g0IcVazn/3s/I73lZy9oTew/t8amvIb9n7byGzfp3CtUoMS52I+/NDF9GySzILtRVbd80KQ29sQ0aqKcYiKuFrn4Ah3pGkH0hzxfi7IPsxZ2jDT2IZQyRyepuBqHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Thu, 9 Dec
 2021 16:15:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 16:15:12 +0000
Subject: Re: [PATCH v2 09/10] drm/amdgpu: remove unnecessary variables
To: Isabella Basso <isabbasso@riseup.net>, alexander.deucher@amd.com,
 christian.koenig@amd.com, daniel@ffwll.ch, harry.wentland@amd.com,
 Rodrigo.Siqueira@amd.com
References: <20211209154722.4018279-1-isabbasso@riseup.net>
 <20211209154722.4018279-4-isabbasso@riseup.net>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c95e1e9f-ecea-ab74-b7d5-7a05f1b1c960@amd.com>
Date: Thu, 9 Dec 2021 11:15:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211209154722.4018279-4-isabbasso@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 16:15:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 774340ad-697c-453f-e0bd-08d9bb2f13cf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5036:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5036A1A2FF52C0BE31D1FA3292709@BN9PR12MB5036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pUiKCK2zB/bzrVyZ2kh4XnZrg+S0rlIWUHYqRGWr64FhEYI3PCBMRcJYI5G/sYuSJQbBZv+Lsocs3WxciwwzFKkgw39/wCxJCYEPq0VrA1XtMsMGdc8JpERJ1VYyx72RXMHDTiW5xJSJm69gP+nPedC8Bl/S8YgKP9RIP4ctTmyw3YtO+33pNXGIpceuC5vUvdQU2LRHNr+bzQyzRy17oXu7uvM1GoKoBaxZYoLdF5f7QfhKNpwaIz94u+WrALP4vCLIaxs5cDBN9KJjR/2i07UPQCFP817BXDV1pyljF9mqel08UkHZeTS81xDbbO/u3kbsVXaJ06gnf11H7cEFV6nwm1yjL++sybxnXX/7L31P6SvrG2lyE+Okn3CDxaJ9I+Kbtv7CE5lUz/mQ/r8qoTrNcngu4LSxhDZS6sNsQvLESxkwBmVrzYJqSK1k/Dlt4x+xGTchUrkSCaeGh3fQk/c8dsxRv5AC/Oy4ZhjMLSVi9ZF6w3G3x+XB57AOSBX4QNSW/HNkoI5JdIWqLJsRTBC5lxgZ2fDwHgw8IQU8ZNukCirc5dlMBCN4bx7uOJHRqKiUXbVNhS+P89vYQ2EfO05f39A7yzoxPYo5pNN1K4m5uOqlOT7OhbtWkiqsnxWI3A+pNHtBckoZyTpxoKUSSjKx89VTIL2TOmaBS3CwV7z6vAfcmjc3PlmSqVI2nokrKrU/qh3By20fWRmkagW61Fa/kRxQ91oG462ydG3sZmvgDP0swE0abxWShw9DdkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(4326008)(8676002)(86362001)(83380400001)(2906002)(31696002)(31686004)(316002)(6636002)(8936002)(6486002)(66556008)(66476007)(36756003)(5660300002)(956004)(66946007)(2616005)(16576012)(44832011)(508600001)(186003)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRFb01iQWI0Y0ZZK2FkSW1Mb25la2VqMkpSRnhsc0dnanFIK3BqclF1VDdO?=
 =?utf-8?B?NmIwYnV1SlMxMUZVaU9WQy9pWFlGa3J2Z2tHcmxqY0ppUkxsZjN5eWpYUG92?=
 =?utf-8?B?aFpZK1JHTjdGRkZsdDY2TkE3eit3dk9yZG15dGVFSUNXclNOZ1QzNU85ZWhT?=
 =?utf-8?B?U2h3YWZ5cDRMZWtmUkljcEJrTUNrRnRuQzk0VzhJM0RNMTc2SE1pMWoyZ21s?=
 =?utf-8?B?TTRZa0Vtei91YWdsUUF0d0tpZFZEU21Xd1p5aGE5OFdMbTFzLzlROVFrQ25j?=
 =?utf-8?B?VCtXVHRQL3NyNXpqOGpKTnJJREY4ZFRqbnVWTTVMR1NzTURCbzgvUGltYnpB?=
 =?utf-8?B?bmNnSFVxTFVBVGNmMU9oNXpJbmFHdWxZTkRBM09WazhzNjJZUjMvdi9yaTZq?=
 =?utf-8?B?WW12bHZtbkFzMDQzZkpSN3V4cXJnSUlrUTdJRWk0bmptMTNkRVR4SStrcmhJ?=
 =?utf-8?B?Q1NMeHl2cE1Zd0NQR2g0RkJlK0RMQ2QwK3ZxMllFdG4yT2dSVzlFUkFtZzhq?=
 =?utf-8?B?N01XNnhWa2ZneTIrV0Fwd0dUSnNBUUhNbm1xdk1HTU95ckE1Qk43QkJXZlVv?=
 =?utf-8?B?cllyT1BOdTAvaDV3MFhQdHpvTnMwckNONXVHWU5oeS8xRDJJQnRqQnBqZHJq?=
 =?utf-8?B?d2JwZUE0NG5jalVPVW1iUzZrQzhaTjNUVUVNNVJpWDg2MDRqQ2VZaUpYSzE2?=
 =?utf-8?B?YzN4STNyZ201c2JIZUlnWU1VNUxsNEgzdVJLMG82MG5FOVk3U2pLOTdPQjA4?=
 =?utf-8?B?bVpZOVRuMm54eFlGRzg0bHpaTWhQSmNRMTMvR0RvOXdNM0g4dSs1SlcxS3pD?=
 =?utf-8?B?b0dhU0w0WVF4T3ZqTVVXc08zSVo1NGpaUzJ4eEF5UlJaRXVKRzZ2OU45V0Nk?=
 =?utf-8?B?TkhJTGp3dEl6QjBCbS83V1V4OHZ3R21wREtnK0M2ODRaZXlOK21ScnNLRDJW?=
 =?utf-8?B?UGkvdWlJcEV6OWl4UkIzdDU4alhNSFFXK0gzZkJCcWxROG1MZzVpQmtHUWtO?=
 =?utf-8?B?cEtPcmUrMm9VNE1sN3l0eGFsWEs3NUNrUUZWajE1WW1WbFlPOHZRYXVUNEs2?=
 =?utf-8?B?VjJhSTVlQWt4blRTV2cwOUptSmdaQWJJRjc1OEpaaXd0R1RSTjJqMjQ0dW5v?=
 =?utf-8?B?T0laY2lsS0o0aTFFRTF0VkFaTUl4Q1h2N1RZZVJ1WGhhMEJnclB6RU93MDhT?=
 =?utf-8?B?YUhrazlOVWZoTEdOakxSWFI4R2E3YXRLNjN1VUtaZndYUjNWT05oRUM1bzh5?=
 =?utf-8?B?WDRDMkZ0VWluZnVMUkJRYTAxVW5jeEdTM0crc0xudUZqdjVCT1VrdEZpcU92?=
 =?utf-8?B?S2dseUdnTXBWamtzUGppR0JzdDJwZUp3RGM1SWxnUlRod25GMmJ4SmhublhO?=
 =?utf-8?B?RitpMHZ1dDJSVVk1V3BZNFYzV0RmUGVhWXJZRU5BMkVOSGxwT3lLV1NoTmVU?=
 =?utf-8?B?UEJuT2MrY1VrTVVGc09SVVVycVlsV0lXdUNEYWQ0dkdrTEJZNzJ6ejZ0Snp4?=
 =?utf-8?B?aDk1eURzbk1nV3NpNzJSNk12NnFlUnRadHpyNERiUmtWaWFOOUExTG9ZbTJF?=
 =?utf-8?B?VXRLZDhhVHo3VCtSVFFqZ3N2djd4WkpyN2o2bTlFbHZhUnZxemxwVHlpeDdL?=
 =?utf-8?B?eEZzOTc3dWtqNzF4MzVrSUJHVnArY094Y1hBVEhaM2ZFVDIwRVQ2cjFxc0Fo?=
 =?utf-8?B?TTVhY0xTZjFIK3Rzc1p0dnB4cUQ0eEVtdEVraUZoblhEazRyV1Irbmd4eWgz?=
 =?utf-8?B?bU9kNzNkOERlSGVMTjVyUitPRDAxNGcrcjJqbWk3MUhTRTlLeDBXUDQwR3Fs?=
 =?utf-8?B?NUZzZEpTRFFFMUdDb1Z1akZrWU5XcVBRdVFaNzA5ZGxGRTlBb0xqMXVSemE2?=
 =?utf-8?B?SUcvcndleXdDc3JjSEtsdEFNZndaZ0pEcnBNM1hXVncrV0RPNE1WUTVHQjdp?=
 =?utf-8?B?M2NVZFFTRnJBTGMzMGUwbVgrZkczdDNxQnNMd3pab3crLzJtSEdKL25DZGZN?=
 =?utf-8?B?QmVwSHprSmM3ME5xS1ZVTlRRTHhIdUs3V0k5RXFoeTVoa05waitTaExSQi9y?=
 =?utf-8?B?U1FUdzMzcldyUzIwczNWaGRrRVNZQUNkMDU1M3ZkbXRoWE1LWklrZ1Z5M053?=
 =?utf-8?B?WFVmWkFHYWhKelVkT3hOOUZ6LytVM2Z5UTZCbUQwSDBDNGhpSitZd3FEalpW?=
 =?utf-8?Q?DS/lS54hbfKJfu3/9jeQzIY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774340ad-697c-453f-e0bd-08d9bb2f13cf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:15:12.3159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrdCyl4c6CQknt2bTJnfU0kjliZalgu57x0D411WbxZ+iKGZeAw54ClhPE5PopUBRbHZDLRd20px76Ucrh5v0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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
Cc: ~lkcamp/patches@lists.sr.ht, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-12-09 um 10:47 a.m. schrieb Isabella Basso:
> This fixes the warnings below, and also drops the display_count
> variable, as it's unused.
>
>  In function 'svm_range_map_to_gpu':
>  warning: variable 'bo_va' set but not used [-Wunused-but-set-variable]
>  1172 |         struct amdgpu_bo_va bo_va;
>       |                             ^~~~~
>  ...
>  In function 'dcn201_update_clocks':
>  warning: variable 'enter_display_off' set but not used [-Wunused-but-set-variable]
>  132 |         bool enter_display_off = false;
>      |              ^~~~~~~~~~~~~~~~~
>
> Changes since v1:
> - As suggested by Rodrigo Siqueira:
>   1. Drop display_count variable.
> - As suggested by Felix Kuehling:
>   1. Remove block surrounding amdgpu_xgmi_same_hive.
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>

The kfd_svm.c portion is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thank you!


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c                       | 4 ----
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c | 7 +------
>  2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 82cb45e30197..835f202dc23d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1169,7 +1169,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
>  		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
>  {
> -	struct amdgpu_bo_va bo_va;
>  	bool table_freed = false;
>  	uint64_t pte_flags;
>  	unsigned long last_start;
> @@ -1182,9 +1181,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
>  		 last_start, last_start + npages - 1, readonly);
>  
> -	if (prange->svm_bo && prange->ttm_res)
> -		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
> -
>  	for (i = offset; i < offset + npages; i++) {
>  		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
>  		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> index 8c20a0fb1e4f..fbdd0a92d146 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -90,10 +90,8 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
>  	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>  	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
>  	struct dc *dc = clk_mgr_base->ctx->dc;
> -	int display_count;
>  	bool update_dppclk = false;
>  	bool update_dispclk = false;
> -	bool enter_display_off = false;
>  	bool dpp_clock_lowered = false;
>  	bool force_reset = false;
>  	bool p_state_change_support;
> @@ -109,10 +107,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
>  		dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
>  	}
>  
> -	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
> -
> -	if (display_count == 0)
> -		enter_display_off = true;
> +	clk_mgr_helper_get_active_display_cnt(dc, context);
>  
>  	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz))
>  		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
