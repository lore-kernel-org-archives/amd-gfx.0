Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87234C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 07:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0627F11324B;
	Wed, 17 Apr 2024 07:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dHnzf+I6";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1957C11324F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 07:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2VFhahKciazjB9+G3uQm284tnOfCZJtO7XcD3fO8nQPODMSNbKffEI4l0HvRgvWHrYq+/3d+BgeqNs82oqGAtDFkVRchCt8HGa0u+NniR8pe3XnS7mkWEYN+WTShCDCdmq1PAH6w7VUzlbqiEfGBuV5f8R9X4ubpTUpQV5HdsBirlQgB43yhdk72PYQpZEphhAaHOTGe3vf7BM+5y0+o2TM8w3wGVLZOPgWLgmkIbhRplSoTHP7RYZQ8gGXmlGHq0DcmT5Gge6GaW6UKv6N8ecw+6hSdksQs6Gw9MrxUmfoccvGz8mCZUZNt2uQRUhUoc0kI2WJ09rQYiazLU+Xeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IyYLrd/uMu7m4QCLLWdasMq0okjuVaqU4ArCutYE7o=;
 b=QxYRvpcC5o2xbnV9XSNp7nIq2IMjI8SL5NFz5xhfs9Sca2OzRULA3LbEktrIExgoZsqblajNg+s6/xHiPfxgNdtzY5v/oEwXSCmiK9WxZib4rdGVLx5g0Fny/7LHSP5O3b9iffszMI3sxIzFAsIeJtAEnpKA9Yf/E//S8p52SLdq7+p8OZ5j2pW3vxglB8oqPSUcn+XEEWXbOjy6r4hVYk8njzxEbvabJoNIaI9SFbkMMprkBNoQ6ICvBI27OJi1RzigGiRVbAD1R4lWaPfASFoUQ1foEspWANVlrN16uJZyeV2ypdLTDcCTAogjHnyD4/2evkJbc3RWxtnGyNHPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IyYLrd/uMu7m4QCLLWdasMq0okjuVaqU4ArCutYE7o=;
 b=dHnzf+I6NQK3Z0sXHqrS8BF0ydBzmtHfR3iateXPnql0MXPk/Rzved+1qFARtUGQ2ZkTwj+PGFUNvyaDH553J5pLsBXgmSbf8bnHaEV/HYAii6qw+Vdg3Qm0fkrreIvU/uJODwSYNdO4Jo5y4Gqm5Kxpayn/7Lkrz0Liy6K4ISc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 07:36:58 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 07:36:58 +0000
Message-ID: <26c0e7b8-e0a6-495f-877d-2fe522b2249b@amd.com>
Date: Wed, 17 Apr 2024 13:06:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Skip the coredump collection on reset
 during driver reload
Content-Language: en-US
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com
References: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::17) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1aa0e8-fc06-41df-8414-08dc5eb129d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttivyPwdnbmwBFNOCOpj66UXEUJ3pq6ERMmirvqiUQbGyjLih2IA2b1RhPOvknVrlrgbIhsLSYMWAba2P+SMTpg8o9YodyJ27BeZcpkkZYjRqh/PureBREOQkzsDKANInj2QihpvgbkvZDrM6ZS3/Ay1yp55bbiQXtpofUX4AAbjN4BikJPRNuEjEE98TVe0RNlUdp01f4z2ZKQ7Wg9+N9ZjgR79qi72VWAlzQfRtFrIjFpvOCAQtk3cBqBABNixF+eDexeXN5Igqo5xgH+CyceMnuxABhkruQCovErCKoJ9gZAF3o/hGZKsAAgIrp5RKLmQJkmGKVMLTvHokkI/gwGWvhyR8cVQB4BWdubhjmtW5HT6ktrDnBrOnN4mZntkAPeWhMUpZD9Jc9wkM5QbJ4vp6otEp3t08P+IX25Amio2WZzccTyK28tIk4sINUJuDZ+x0VRQR/KDzAwbkwQ4MJqiGm3HJYEDK0ZFvdDlt5RC6uSVP3+adIRtcuAMuIsIdhHqLLiVCOtQ7py2di/LAtc1A+cfUckI3aNhDKUDTN7/zvzHjzpGv+HBiYZIhuDZU+gooEK0DF/zLCZ9tbVW/TTj5zWGpkLAsygpuAqTblb5TV2eN10Y5vWdnPzq5uojBeFivummtu5bEB+/8MKcsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akw4eDZyVjJBSFpwamxZTUViS2V5UTlsSGNRNDlKRHVIY0FWZ2QxSjl2V0J4?=
 =?utf-8?B?b05WQ05kUm54Ni9qL2Z1SGJrZWR6SjBmNVJIbXI5UVdWNmpwN3JqZDFvaHNJ?=
 =?utf-8?B?aVJDK0hWQWpkaTBpUUNrdTM5SkFiZnY2QlQ4ZGM4aVhGak5OSGplTHVCV0Vx?=
 =?utf-8?B?dEtIckVVSDBrNko5VmFlVjdRMUhIU0pIVFJBOGZldVVtRERESzJIbTRySHFD?=
 =?utf-8?B?ZEQ5bzNTZmtHcnk1SjZUbTRCNEVhUWhuYkNZNDMxSGtGckczbEs0cTdzdU1x?=
 =?utf-8?B?VUxMeHhSWE00bGY1b3hCYmRwRU8vQkhxeXJwaHgrK1JwY0o3WmY2NGNMTVQv?=
 =?utf-8?B?dTFZaSs4N29lZFVaTG9xZmtvNDBRUEpDOVpkQml0VzVuWHdWcWdiU1MwQ1VB?=
 =?utf-8?B?WERyNGw5dEk3anFZSW1YOWxyQTdVZVlOb1NJenByZXpyaW9nUkxBRXlNNzd1?=
 =?utf-8?B?MGdWNEdNcDFDMEI2cTZZNUhBamxNb3hXbTVPMUJsUVl5Q2ZDMW1hSFVCR3hF?=
 =?utf-8?B?cHgvbHE0YkF1WW9pd1ZEK0s0Tnhwby8yUnNLWVVIUFVnNHpaMGU3N1pWN2M0?=
 =?utf-8?B?dURCMktybkVoZG5OeERzWTAxMytMWTlVNnltUjBUSy9rU1N2Y0xXamhtVEo5?=
 =?utf-8?B?YlRLRk9nTVNKU25uWUhHUmRpS0RNQ0dubFVaWDFnbVZORGFST3ZmKzhsZ1dk?=
 =?utf-8?B?anVmc2srelhNRWpSZW94WWJYcnVXMnNyRE5QQXFFWkUvNUpiQmRXZ1ZhdzFV?=
 =?utf-8?B?dDNKYWRWY1l3eW12Z0NrY2xueHRCQ1FkdHVocERRWmFFNnRHUVl6UDRPdmFl?=
 =?utf-8?B?RDRlYWtwVVpXUUxYenA5MkYxdjRiL051U1B3ZUkwNklWRElFWDJyYlgxQXcw?=
 =?utf-8?B?azFlUlFBNXcwZ3NrMTlML3dSQWNBbjlDZkJJQlhFdUdrT3hOQnY4Znl3M1BY?=
 =?utf-8?B?R2o0RlZiWkMwVTN4L05nNXp6MTlEK28yTnI2RTd6cFI0bkFIQkorT0FBMzN3?=
 =?utf-8?B?Sml6Vjc3akFkUkt4S241bVFGZWpBQTVYTW81b0N6Wmk3L2g4Ty80dXdETnNw?=
 =?utf-8?B?WHFiK3RYVzBmQWI1UEFiaDU4VlZqR2xoUjJlaXZMKzllUCtJd3BFcXF2eVhk?=
 =?utf-8?B?MEJTVGRZRlV0ZHprSDlLeDBLNFhLeHQrenBOM2xZZG9ZSVFTTlAxQlo0MFNq?=
 =?utf-8?B?V1Jjb21LTlB4dGlUZitSYUVZWjRwUS9tZ1U3WjZHb0tjU214ZVE2enZVMkt6?=
 =?utf-8?B?WDkxMk1QTVoyd2w3SjFSWUFLYVNwSHFrZzJ1VWNQVmo0MTZ4cVZURzQzUU1L?=
 =?utf-8?B?VHd2aEMxcE9oeGQ4bnkraEdKK3B4ajdrNmU3SWhsRWlaTEthRHNnWlZUU29J?=
 =?utf-8?B?YW9SYnpRWXdHUnFLMEFQWno0SU5aTUpiVVV5akVYK2ljQXJiYjQzQjdsbnlS?=
 =?utf-8?B?a0FxcElWZVN5NE42bW1TNExJSVRhZ1gyT3NNUnRndUc4N2JjWHhTODVhSWdY?=
 =?utf-8?B?R0lkb1NMTXZmMmZ3aklITEVyeU1nNTVlMy9ELzBvck1IVkJ0UDlIY1FNY2JW?=
 =?utf-8?B?QUthaHpHNkFHU0NTKzZjOHgrSnI2L2F1S1p1bHY5UlB0MmtPVmFHazNLanVN?=
 =?utf-8?B?Ylpld3o0WGVURUZHcHE0WHVEd0FUZWxYMUM4d0t0M0V5YnduM3ZzU25Pc3My?=
 =?utf-8?B?U2wrV3Z4YVdIQVRpYlN2WkVnek5CYTJpaEQ2eXVjNmZZNm1PNm1hWklYTS9x?=
 =?utf-8?B?dmVLQ3dEb1hJTEFQUjF5UlI5cURuUnBFZVEvQlV4dnFnb0wxV3Vuei9DNTJj?=
 =?utf-8?B?OUIwV3JjbnJpdkJPeE5Sd2dDYWpBRk94UEdoaUZTWVA0blUxdmNwc3RsSWFQ?=
 =?utf-8?B?UXVXZ0ZkVG1xVGMyWGowM01vWHRUTzl0NnB6LzNjbXV5WVh6NmZVc1FsejBS?=
 =?utf-8?B?UHM3UlZ0YkgvaStrZXVrQVdMbDVTK0gxMTFkY3RRbFJxWDVOcWZjd25nQnVQ?=
 =?utf-8?B?eit6UkVDM041SnNYZjczeW42VWhPYitWTWlzc3FDeFF1Sm15YVZTL3ROUVVh?=
 =?utf-8?B?UGptNWdQOXNMNGRmN21nakMxZXRGam9IaTNzb1VVaFlZRWJYK21GYm14MnE4?=
 =?utf-8?Q?P6HgcTHiE3CCkJriN05FW5+an?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1aa0e8-fc06-41df-8414-08dc5eb129d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:36:58.7573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvUJ1ZFEQ9ECCPdM7aYq6kQo7boYdCT6fzP8NFhE4dGqGLn95RLaUq3IJsL17H6qM65VXtfAuQPLC4aHxLW1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

devcoredump is used to debug gpu hangs/resets. So in normal process when 
there is a hang due to ring timeout or page fault we are doing a hard 
reset as soft reset fail in those cases. How are we making sure that the 
devcoredump is triggered in those cases and captured?

Regards
Sunil Khatri

On 4/17/2024 9:43 AM, Ahmad Rehman wrote:
> In passthrough environment, the driver triggers the mode-1 reset on
> reload. The reset causes the core dump collection which is delayed task
> and prevents driver from unloading until it is completed. Since we do
> not need to collect data on "reset on reload" case, we can skip core
> dump collection.
>
> v2: Use the same flag to avoid calling amdgpu_reset_reg_dumps as well.
>
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>   3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1b2e177bc2d6..c718982cffa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5357,7 +5357,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   	/* Try reset handler method first */
>   	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>   				    reset_list);
> -	amdgpu_reset_reg_dumps(tmp_adev);
> +	
> +	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
> +		amdgpu_reset_reg_dumps(tmp_adev);
>   
>   	reset_context->reset_device_list = device_list_handle;
>   	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
> @@ -5430,7 +5432,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   
>   				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>   
> -				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
> +				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
> +					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
>   
>   				if (vram_lost) {
>   					DRM_INFO("VRAM is lost due to GPU reset!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6ea893ad9a36..c512f70b8272 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2481,6 +2481,7 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>   
>   	/* Use a common context, just need to make sure full reset is done */
>   	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
> +	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>   	r = amdgpu_do_asic_reset(&device_list, &reset_context);
>   
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 66125d43cf21..b11d190ece53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
>   
>   	AMDGPU_NEED_FULL_RESET = 0,
>   	AMDGPU_SKIP_HW_RESET = 1,
> +	AMDGPU_SKIP_COREDUMP = 2,
>   };
>   
>   struct amdgpu_reset_context {
