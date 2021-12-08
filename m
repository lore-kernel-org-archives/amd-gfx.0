Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E611C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 15:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37E76EC8E;
	Wed,  8 Dec 2021 15:09:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B25E6EE44
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 15:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRdXX1oFOH1iZvl0rADl/8RJ3OSfjw9Wtyoxp+sQcDiTr3souwFzHOyZ1KW7Lvy58ZS74yJ0UC3aUFu2JcfDmnOIR+QsVIuWdP2isbn63JdB2jp8Noj5WNV99nh2Ylh4tmuGm9cr7dd4h1s8A5BFK1IGnv6YiMB+9Oj3a1xPGp8FKihRrkPrkWMZt1V9XAjhXhF6CsU7Ar6KXu7vfCNOEwFJ9zHpTzzc/+ydjxc+SdhY9C3m3gmhNMkA+452VxkJMJ5hGfKl1x4WVJQi5HwgmlcZIwC7degBtYX+Dq6L8kjGdhaMX7dAP+hRDM32N6BATuD3IofVovmRcDRcVGh5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gNfaZGUgGhFI2NbUWGk0jhcooCD5YW0ZLehdr13qlI=;
 b=KH6RNuyVrV4UY0SnIaTt1Gfp22LBktKlZnB4h655fPNzTkb0sd7cBI9hhfhqGUgjt297KO7DCBs58bhMUR4QRN75IZOqDcDJPps4+oHjt/CRtpI06rPqWZYjznloJpzEgd+jt9C6ED+uHQ2DrnmwyTIJaQINKsK7oN/evJUkDrUxUQxstTZDDq+G0GG7fCtPyss7ywY7PsqY50V3+J0nPy779V/O1qtexGf0gAIaB4pk1XbdXW5nvPiGoJgtA9zBCV/ReI5Gw3ORWWKDUdZF92ytOGUZ6pG8tQpEVX32nClQAkZ8Epqmae4mqv6AyzLq518mkjXaBj5QXbVShSm0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gNfaZGUgGhFI2NbUWGk0jhcooCD5YW0ZLehdr13qlI=;
 b=FLeetoK8poqdVVuZ+ATEYck4WXVdiPjnxLWE0DNGLrO4U4sIGlnfNNdackYwOia5ibzkxNZ4kZpTpEtiUsilv+aNoWgYrQ2mBQ4JvgDGIy2TNC18svzsSAW9bKWwHhCxz+aQEv28WFmA8lu0Bf+lu6ZotXEu7vd/CBa+0bH0zoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3360.namprd12.prod.outlook.com (2603:10b6:208:c7::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 15:08:57 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.011; Wed, 8 Dec 2021
 15:08:57 +0000
Subject: Re: [PATCH 09/10] drm/amdgpu: remove unnecessary variables
To: Isabella Basso <isabbasso@riseup.net>, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, Felix.Kuehling@amd.com
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-10-isabbasso@riseup.net>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <41d935b9-2072-1c4d-5b6a-6f1242e8c051@amd.com>
Date: Wed, 8 Dec 2021 10:08:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211208012529.372478-10-isabbasso@riseup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:610:77::13) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fd5f157-5147-43e7-c402-08d9ba5ca7ee
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33609F3B15F0EFE4AF74E7E6986F9@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acUk+tgWUm/sajHKqIj6fiSO/nhfc/ZeJ+Mrh2B2Y2AF9NQOHaFkYWgJ1jtffRmkyuh6owhrB9v4udFdJChheDvjBlk6mb62m0DMeAfeYiW5quJNQ8c2hVpnK5mpayhrlWljD6BCdCAd9STdXkTLqpHYMhGjhbumEnYpAGwakmRu1CgO5/CH7Mmjtw8tPE8qGFyhfuumNbX3V1HqtPD7LQF73KKc2wkjG/8OUPI+f5GCMDeEbdxPemljouFRxrZMsZe2IoAbL7EUCMVyg+0QftqvJF9KB+y+zvOiZYDFuUUOmLIK1KKFn++6IFslWok3VTFyXIp3IVXIujqwbdfI7AdtwO4OuZZ9uVdkWHGMkArhQjKtq5WtX59goR3rNLVv3vN1NZaPiBWXqdq4PYmggfCDKp6VGKQfGa/LjuGr9u/Tne2srROWHRhxUyW0VKwSlcJSPUtGt+O8OsL5TqwgHlsmA8QwoIdU/vzg052sJnNsK7BxJDxcbwhGaViKc6cGh7v/9eTkTd8v6YYpKjhuNwrPjVwkIYiLNU3t/KjDvzg30NJf6QGmy+B7g4Fz8xgADZyQdowSptzqONvw8zV9qLGxO42elT4gjsWv2lqVHH6L09whBiK1+qnAt0/ohjAtj/fuAPNJHKRj9YT1WOeniowFYvLzAJVYJUFL/MgOhPQ2gezcJmYarMxPNofP/ToLtlPEEyiFu3Z2QE3fH+oAlgt7CgScrGu+Hms6zwwRYEY91rA9kXH0DnfVKO533d0Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(4326008)(38100700002)(110136005)(36756003)(6666004)(8936002)(316002)(31686004)(2616005)(6636002)(2906002)(8676002)(31696002)(66556008)(5660300002)(66476007)(6486002)(6506007)(83380400001)(53546011)(6512007)(66946007)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3dJdU92Rmp1WnRXbzM3R1NHY1Nzc2p5NTJONk5uRzhDbDVvQWZUVndvRWxU?=
 =?utf-8?B?UXJiaE1MVnMrL09MY1JQZlRBNkFXUHN3ZWlGSGpjRXVhVXVUeUt0WDhpNWhY?=
 =?utf-8?B?ekRrdk0vUm56WjFqNHVwRVRVRXdaMFJ5cjN1a1B3Q1ZPRmR6ZFpsalJyeGJw?=
 =?utf-8?B?Q0RvTFpSdWY3U0tBWWJsM1Y5Sy9BZEhGVHFiSnBROGZQVC93UDZ3K3llMTYz?=
 =?utf-8?B?N0VObEtqcGpvTk4yNW5iRzNRQzJFSEs1M2NSc2Y5dzNXT1kvSk9lVGpmRHFa?=
 =?utf-8?B?Y1RjVlhkSXRVQWhOakpoSzM4TjJ3YnNWRmRUd0RlRGZCYWJsNWdIWG80UHo2?=
 =?utf-8?B?YzlRTitHaThINUQxcDdCczlZVVlCZEZoanhQRVdvNFo2cTVMUFpMcU1tSmU3?=
 =?utf-8?B?Z2hzMEx2RnJCVS8zY2pzaGpiT2JxcUxQZ0xFTEt0VHdERE1laXFvOGR3KzAy?=
 =?utf-8?B?V3RmcWZPUXU3K1Y1dTRGUmNWYTVCOStCVmJYV2dQdWhpanUyNHBVUElzYUtC?=
 =?utf-8?B?VnZjVFFmRnpBMkZHeXdGYmRtQjcxbGIzbnNXN3BLQjdCVkhDMVUzN0NMWmFJ?=
 =?utf-8?B?Mll1S2JrZjgxMEFZVTN6OTg2TmZmZk94WUV5OFFhRVI2eWFLWU52eGVnVmlj?=
 =?utf-8?B?alh3OGZwQUJmVGhXTENZZUVtQ2FDZVl1ZWFqbysvV2drQTdIcjM0cHBsNVNn?=
 =?utf-8?B?VjFRNElLNjZpTzlRdDBnT0VDY3E4RzYzaWZoQmNFbmFlQkhuRUZkTXpIency?=
 =?utf-8?B?Qm9rWGNBR1U5b0FwWkFZNjFuaUZ0em9UNzRqMkpCSkR6ZUUvSi95SmxNSGFn?=
 =?utf-8?B?QWhMSW5lQjlLTXVwcTVERmhqbGhhdXcyNDRXeGlKek9LNHlQZEFaSXl3SGYz?=
 =?utf-8?B?THVKY1YxeWN2enhVcGRJVlBvL0t3dlVydlhCYlJ4dXkxeTh2RU9wTXovSjA5?=
 =?utf-8?B?aUpMMzFoeUd5NjJxWFI4NmxmcXFtVFZ0Z3JQS092S0cxVkhQSUdzTEp4REdS?=
 =?utf-8?B?S0Qrb3JxeTdhTXh3aTlsUE9IZjloVjRTQ2VuZWp1ZTRsOUNVNXlHL3AwbHN3?=
 =?utf-8?B?Qjd2RTNwYlMxd3VUWDJqTW53dmVLUVRpZ3hUM1FNQlNWSGZCUlh3a2JVSHZ0?=
 =?utf-8?B?NFVseTNPRUpwTnZLYUtVcFMvRFU4S1Zsak9Td3Z2WjVpSWROalNUSTk3andP?=
 =?utf-8?B?YXl6U0llYlV6T1ZVM2J0S0NiNTVlbmhRVTQ5ZElYcFpXcDF2NU1UQ3h3K1Av?=
 =?utf-8?B?WHg3UjB1ZHNmdGpvR0NQeTZOS2NBbnVtNlI1Z3pJQ0t5cnJpUG5RZXlPdjVt?=
 =?utf-8?B?b2treVdkRVRXeVA2SHBmRFRhM0tGWWFrdStHdEJmV2crcHZyUWhidXQ2MmVO?=
 =?utf-8?B?WHJacXc1dXBHVGxBM05ER2pxdHRQYzh1RmFWcU10c0ZqcjlNSkVZcm1RYnNj?=
 =?utf-8?B?ZDVxbktkTEFhUFAwRmtFUldoZ0JVdHUwVnVWTHFTWWlubW9LM2FydG9oeXZt?=
 =?utf-8?B?WTBaZGEzNlJmaU05emxyVWtScVYzbVV5ZE0xZHpMN2x0Nk94eWZYY01oY0V2?=
 =?utf-8?B?Y3RMZmNKWU4rNzAwVFB4TXF6MW1vQWlPZXF4aThHMGJRaG5abVNFTWJyd0J3?=
 =?utf-8?B?NzhaNzRZTXBidFV0N3VzL3BxSC8wRmM1bW00TjFFaVRCdzZxY0NHdzZ5eitN?=
 =?utf-8?B?SHJtcFNaS3hxSEVvYzlUcEpHdis3eFAwMkpjMG9FN05hNmZZSzM4dlJ4ZWVO?=
 =?utf-8?B?cFIwSXYvNm5GbDRjUyszMzV6TVNjMTdSVU1DWkY2RXl0eFRJMGVTRDVBdGhP?=
 =?utf-8?B?L080Q3NzNVhycVpPcWVwYTc0RHNmaStHMEk2QUUzZXd5OG9wRmVnYXF1TzRp?=
 =?utf-8?B?KzJybGc2VGRJVHRlRHpYdUcwWDNZYk1BUVdXQU5zZ3MxTkp2czg5NHpKdU9N?=
 =?utf-8?B?cmUyTjU2MWpUYlc5TUlsOW5aeVpYeTAyUGRTZkJBa1dVRklLRXBUOUZLMTVn?=
 =?utf-8?B?MGpualYyZkRJWURjRDFnbVRMUkZETnZ6a2Z2dTJUZlZhVW52N3JidFFvKy9Q?=
 =?utf-8?B?ODdXWWk5MVN6QTZWSmFwQTZiYzFnbG9pMkZaT1FyR1drZHJHclRPeXlsWGhl?=
 =?utf-8?B?c0pqNjZLWm1zYkdlelZFZjVkMTN3NzJaVFhUcVN4UWlQaERLR0Q0NVNFcnBW?=
 =?utf-8?B?VGlRbk9wUGttd2ZEMFI2c1hlcU5sWnY1cW5xZnd0c2c4MFVxSllITHIxZEdB?=
 =?utf-8?Q?1dnfFKnmHisJcIllkUsLO+LKc4R+ffhuyv2UZfWV4Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd5f157-5147-43e7-c402-08d9ba5ca7ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:08:56.9504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbm3LDZeSZHPHmr6O6fB6uz7p0SRN8++uviSFmtvr+0OEzKafSFSjRUa/33Q62T8eZRHqrMMyFhhBlu7PXdoiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
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
Cc: ~lkcamp/patches@lists.sr.ht, Rodrigo.Siqueira@amd.com, daniel@ffwll.ch,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-07 8:25 p.m., Isabella Basso wrote:
> This fixes the warnings below:
> 
>   In function 'svm_range_map_to_gpu':
>   warning: variable 'bo_va' set but not used [-Wunused-but-set-variable]
>   1172 |         struct amdgpu_bo_va bo_va;
>        |                             ^~~~~
>   ...
>   In function 'dcn201_update_clocks':
>   warning: variable 'enter_display_off' set but not used [-Wunused-but-set-variable]
>   132 |         bool enter_display_off = false;
>       |              ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c                          | 3 +--
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 4 ----
>   2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 82cb45e30197..08b2130afa4c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1169,7 +1169,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
>   		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
>   {
> -	struct amdgpu_bo_va bo_va;
>   	bool table_freed = false;
>   	uint64_t pte_flags;
>   	unsigned long last_start;
> @@ -1183,7 +1182,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		 last_start, last_start + npages - 1, readonly);
>   
>   	if (prange->svm_bo && prange->ttm_res)
> -		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
> +		amdgpu_xgmi_same_hive(adev, bo_adev);
>   
>   	for (i = offset; i < offset + npages; i++) {
>   		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> index f7f46b886162..2ea813a56edf 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -128,7 +128,6 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
>   	int display_count;
>   	bool update_dppclk = false;
>   	bool update_dispclk = false;
> -	bool enter_display_off = false;
>   	bool dpp_clock_lowered = false;
>   	bool force_reset = false;
>   	bool p_state_change_support;
> @@ -146,9 +145,6 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
>   
>   	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);

I suspect we can safely drop `display_count` variable.

Thanks
Siqueira

>   
> -	if (display_count == 0)
> -		enter_display_off = true;
> -
>   	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz))
>   		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
>   
> 

