Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32846C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 11:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC0410E22E;
	Tue, 17 Jun 2025 11:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KeIKtKNP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE0E10E22E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 11:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsB/5aapBw5Ldd7gV5YZsIXJBDnVw7XM+0bRlu4YlxmNgDjGRzxFSVS7+c3isnj+bcihvbgaS6lr0H/TpetBYzRbHpGpCsULNp+fmAfiHicZ7ZdMqEPJ5GyHhmbpZmuWWUCLFQSeoDeI3JstW4eobXrlnSOwTJxYow+9bhhg171d4nYKOJMszvCArAp3o7zEq3ggD534yO5+RL4TFZ4sC+8ydfRhudqdqGRetnqPnt7ml2QuQVACEFgXMAKXySEVNEUYvaVnYik7nv0bIBMOEIBArzt7mrsnaRY0YAFLMdrjD9FsuXj5gjCSS2kLkXGIaGt+uR8lZlsSjQAwkJbPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ccoAoMAWaULitxgbjRGLYIiAyZV9g+KchXs+mCj1co=;
 b=qtQRycLF20QyyzdwVV6uMvgQo/qA/m325VMpsQFlCerLR6gj45i/LzOmvhLaiDPM0ec3t3kn0gfJcWFrRcl5s/+4G+O825sumkGluUiPSS5rWnRWn+aL/d5igMuc8KQ5Yfbyp/yHC7XX+tvOPKY1adNR7ETu1LxFh9WlH9sETXwgz/kvQDtzJmFJKeHK0OuKWR5qq0slTbb2NNYbo7dNgIT3QMnDFNrgH0c77EPsHJQiHnp/vnBONdjUbtQsYe34p+l96hlyswusl+PQiiW5w84FuGuWCSn/4j3BvEMQ5mw37yhGYAEOacDXD/fSdn+lSRkroxloqfLdZLUSBonV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ccoAoMAWaULitxgbjRGLYIiAyZV9g+KchXs+mCj1co=;
 b=KeIKtKNPX16GS6DFJM4WRW2XxVE8AI3LbvV+LAJmkC75oyy/bdZw3UsTTjeZDJsTc73raw3XGnVM2a/LFxeroU06v/mrLL5sDEeg9dsIp7faf87IzTYZJa0H/zWMO9ScOo1iOxZQDsbKqMvEt4as+QljnqJHwrd5i5zXYwhgb2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 11:49:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 17 Jun 2025
 11:49:43 +0000
Message-ID: <5c9804fb-2159-408a-b896-9542a9e7e242@amd.com>
Date: Tue, 17 Jun 2025 13:49:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/36] drm/amdgpu: remove fence slab
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-4-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250617030815.5785-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 9320f635-dadf-4a01-f9c5-08ddad950c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnY2eUV4Umt5b3AxVDM1b290bU5qcnFSdGQ1VFZNd0dSY0NEeFFKYkg3MlI2?=
 =?utf-8?B?MllkRWNhVXJMWUVmdWdjYzVhR2hOTHlHck5mdHNiUzdreXhRK0ZxWVhKVHA1?=
 =?utf-8?B?YW40dStjajE5OVMvUXZYYkFKckkyQkxyQWF1YjVvbkZ5WHQwcjB5N1dpWGF2?=
 =?utf-8?B?N1lBaU53YVpTdGVQS2doK0lEckU0enFvVmZjTjhKL2d2VWdSbUtNcDh3bGhP?=
 =?utf-8?B?aU9mdGxReEVOOGtSYzczWmtnRHMwZVFlSmNlcjgwbWNBN29zeGNIcXZyZFU2?=
 =?utf-8?B?Ulp0ZXE5cFVWVVd0NWhVZ0kxQzd2RUhUR0pBNWVYcnFhSzZraDRYS21ycno0?=
 =?utf-8?B?Zll2NXJydS92Z1lrdlFIOHJLbFQxbHBCK2NDcDhKQnh1N041eWN4VGpScEc1?=
 =?utf-8?B?OHhJcVFmVGJzYW9EY3gxUkdublI5VGF0Nm1WNnlIVVhVQ2twQVF3M1FCcVda?=
 =?utf-8?B?VnRvMmRPcVZDaFY1bk9lZFRPKzJhaGtRWmlWTEVoU3lwLzJlbXB2NHdqUER5?=
 =?utf-8?B?RlBCc0swNGdzMzZLUlBBMEhDR3hzSURWa3FmWXpTNEtNc3lIYUZobkMyRzh3?=
 =?utf-8?B?ZC9KMWtWYzgydjgrWHdmeGhsU1p5T3Q4VE1CSHIzUXF4NmJCZzBXYUFzMTY1?=
 =?utf-8?B?eEcwUmlndVdlRlRsdXlMSVJJV0pDQndNMXJpdm9NOWZrZHZuNzJwbzdQWGRQ?=
 =?utf-8?B?dXA0VS9wbnNtSzI0WEc2ZkpOLzdpUW1tSUYwWjVtQ0NNNEk0S00zZlVWYUlC?=
 =?utf-8?B?U3ZITHN1dU1RVFZ5SFRaN28vSWMxSHZzS3BXUzljdDVGQzRzRG96dWphSHE4?=
 =?utf-8?B?RmNmcGxRSE1pbi9jN2YvclVodkJhRWd3MG1zQlRZTCtuMytscjBxMXZiemZF?=
 =?utf-8?B?WmJ6WWs1UU9iM1NvdEZhelNKTGtzZ0FEVkZsL3c0KzJieUlTVVF0SElnTnA1?=
 =?utf-8?B?VU44aXNLOXNmS0RrUm0yUm5vdU1qSmpGYzViUmZBWHNYa2ZZdDlTL0tYYU1X?=
 =?utf-8?B?MDBvdVArSTJMOVg0MVhvay9uMXJmQlZOR3ZqOGVzMzRwWEMyVHZsK29ZVHFh?=
 =?utf-8?B?RE9GMXRPYVJrNW9VRFVsSkI5dHhUeU15cld2a1VRT1ZMVGRtOFl1ckszOVFI?=
 =?utf-8?B?NVN6MFhzQlpyOEZSeVcrY0E4Vk5PUHJKV0g1NGRrWHZhV1pPWWZ5NnRWUXgw?=
 =?utf-8?B?TndEVHFFazlyQjRla3FqT0tOREVyRm9MMjYwRmRYRU45Mmx4Q0N6UHFvUWhK?=
 =?utf-8?B?K25SSiszV2JmdU4vWFF5bnVhNHNvNG54ZXZlUmN6RmJTYlBoUGdZM0tKcDBa?=
 =?utf-8?B?bmVyKzQzdy9uczJsYmlmcnFOdXllUlNicGxJWEt5UGpNcTd6QkRYZStjM0ox?=
 =?utf-8?B?eURaRXZDbDE3OHRnTDQrMjduK3pzM0tVU2tPN3YwaG96Nnc3WnRmNzB3Tzl1?=
 =?utf-8?B?Z2tDbHdOWXZWWXcwLzF5NWtGeVVwVzl4eVllSTQ2RWVmc2JpSWkrL0swdU1F?=
 =?utf-8?B?REszckZnRHZ5THVvOVp2VG5HcTF5dEZWZ0Q5dkRtNjF2Q0p4K1pzWUhHQ1Ri?=
 =?utf-8?B?aXRKaG9BeTh6N0pjMjVhY1JtR3RjSjlCR1lIMkRLU2FPSlk0enpmQXUyU0hi?=
 =?utf-8?B?WlJLYWRmVWcyTHU3S0x5eDZTSWtra2FOSmt6UThXVU1COEJiaWNNZXJKTitR?=
 =?utf-8?B?SFIvTEQwa0d3MXdSajJKaDcwWXBHWU1GcXBFbUE3eVZWUmw1aUhGN2t5NGtG?=
 =?utf-8?B?czJ5M1AwR3RPdjl6RmZ1K0t3RnlMNWdnTHMyakw2a2NFZEFnK3diSUM4d0cv?=
 =?utf-8?B?Nzl1Sm1OY3RsMmQ0SUVGVURidlVrU29USVpvbE5vWnAxQWowMEFRelYxeFNY?=
 =?utf-8?B?MW5GNGRIYlYzMVFlTE41Y1dLWjRLZWxtNlBHMkdjWFppanVIODF5R2xPQWtk?=
 =?utf-8?Q?D40pfrCa2yU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZ1dmhTTUY3OC9iRGlmb0FZL2R4c0hTclhzVXZ4QWJFSTVHZ0dGQXhZUUZP?=
 =?utf-8?B?RVpiZmNndGFlaG5TemxEdmpDQS96SitHaS9yWlpIYXA4QzVZN1VNcDM5VTdn?=
 =?utf-8?B?d3I0Qy82dW9Xa0N6dTI3QklpZlM2ZGI5THBHUkd5Wnh1dXplTVVQdWZhWVBx?=
 =?utf-8?B?VXdFckFOTEcrRWoya2dnOUZYWERUTC9zT25yRCtYZTN2L2pJV3JGZENuS1Ni?=
 =?utf-8?B?cm9BK3d3SzZYd0NoRzUzTzRYSkFnYURVeDExcTNmSmdEV21Pbnp1eWhPRHlV?=
 =?utf-8?B?Wi9MaytNUXJMTlN0WFMvaGcvUSs4WCs1aExXVldKQnMxREYvM2dKd2NLa1Nx?=
 =?utf-8?B?U3ZiblpkdU42WDhuVno4ZmdqTGNvQ0lSc0lsREp5cFZNUzA3R1MyZHdTZGM3?=
 =?utf-8?B?VVFWU3drYkVFTkVxTy9oMWp2OVV1N2VwZmlRT3ArVE9sc0VFYzFnRTNQZHdw?=
 =?utf-8?B?TDFPTlRmRUJhWSthdjJwOTJSd0M0TVdSbmhmVTY0UkpValNVdmhsRVJNRDZG?=
 =?utf-8?B?a1ZBTUxzT2RzN1Y2b0E0RzZNUmw5S21ZY3ZYQXk3Rm1LVlZLS1pCUFpXOXht?=
 =?utf-8?B?L2NpWlI3bTBER1pSanMySjZiZlYvZkxqWWdGaDNGWlBraThxN0gwS1dRYmhZ?=
 =?utf-8?B?YnBKaHYwRW5qemxGRVoraHdvNDRGems5YnZTVFNUNkNpVXF5QlhVUlk0TjRt?=
 =?utf-8?B?cE1CNXYwZ3BZSlZSNXFBWTUzREdkMXc1Z29xOUxKSGdhUTV5SHR5WlA2MmU0?=
 =?utf-8?B?UUs2TktLaldnK3Rpd01ONit6Z0hXeVQ1THJ0YS9HN0RqY3NxU2RZZkt3NExH?=
 =?utf-8?B?UXFuY0hlQitqQVNVTXh5Sm5GZ3F1VVJZM3hyZVljaVhnMitGQ3Z6VXlyanNN?=
 =?utf-8?B?TmpyYkJ4Z0l5YmlVdGREZkZZWXdOSnc4aGhSSE91ZHhzdmtFZzhRMy9QZFlL?=
 =?utf-8?B?NlA4b1dYUGcvMnpOZE9kaVAxOUlncUt5RzFLY3pxcythRHo4YmhMcFBrVS9R?=
 =?utf-8?B?NGt4cFB1UkRFb1pYc0pCTyt6S2N3VWIvYnVTUFF3MzJTRi9sMHpac2pHaC9J?=
 =?utf-8?B?bGhkV0JUZjloNjE3R2t3Ynp6dUQyOHUveXRJNzJ5U0QzVWpjeG55MnRVYUhU?=
 =?utf-8?B?dy9yWHJyWG9wRitlLzcyclNRcnBqZHdrSVhZbjlQVlZuNnV2eVlFOExWcVl6?=
 =?utf-8?B?ZHQyL3JwTXZvZEFmbStoVFZ2NlVxK1BpTmZ0NkJBL1kxQTMwZUdidXYrZEt0?=
 =?utf-8?B?aXdJT0NPK1d3SXVyZmZpdGQ1WDZWV2I1bEZBVlVVeTdzU2c3Q0tFUk9ONmpX?=
 =?utf-8?B?NndTN1hoVkMvMzZNdkRUU0srS0taRXFtektsajZyd3BxSzBnR0crb1VENmpC?=
 =?utf-8?B?dUgyZHRvRWVPNmwrdjdoYUIxb1M5SnpkVVBBR0VVN1dBQ3lRVndWcmJCZDQy?=
 =?utf-8?B?VTBJU2FRQkhLblArVXJ4d01aekptTndENjJROGgxZDhyVVU4bW92QnNITjFB?=
 =?utf-8?B?Smc1azg3SEtUVDRyeVVkM09hYllwOVVZVmhFejZVOGo0eXowUFNNcEhTZ1lx?=
 =?utf-8?B?aVEzZkg4K1o3YTlwdHdoWXVkN3ljSTdvMEVrSUEvaENGRGlsejEvdjFUaXhk?=
 =?utf-8?B?dk1lNkU3a2tmQzJCZjFsODdmb29nK0RSWXhXTUpHeGFTZGo0V2VIQUVPN3ZS?=
 =?utf-8?B?SXdUanpuZFNtT2pGeU93YmM1ZlpBMWpreUhMMVFzWGp3alJmMHNTMHM4Y2VG?=
 =?utf-8?B?M3ZaN0lheVo1WXg2ZDQza1o1OS9zbEJoL0cvRzRjU3Q4R3loKzZHNE9wSnFi?=
 =?utf-8?B?aVNzelpHK25xTlg5K3dZN3Z4RFl5b3NQZTBpV0p0eG1mRXp2eGV3STIyV0Ez?=
 =?utf-8?B?SU0rZkFmWDV6amQxVGxTRkh5SnYwclhnSnpSY3U3QnB2UW5HcElTWHdJOGVH?=
 =?utf-8?B?Mm1rTnI2aHM2d2NSQ2xvN0l6K1hoaFAzSlJ1WlhqV3VBcmlRNVBIWkQvMDJF?=
 =?utf-8?B?SjN2RU5vdWN4SzNOL2ZaTXIxckxTbmlqckxFelBvemZIRzNPK1k5a3pxYjBW?=
 =?utf-8?B?Z0NCWnkwNDhPS1hhYVk4NGlxOXNyUEJSRlNMb01id05IWHRQZTU0YlQ4SGdK?=
 =?utf-8?Q?WJJOmW0PcPBh3dF0pE1CfgR5N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9320f635-dadf-4a01-f9c5-08ddad950c62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 11:49:42.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P7a0vKqtX/0zGam87sXRCBNwDvwe+R8+Z4TCuagkWuQ/WQzL50UW9S3pCveN7oy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

On 6/17/25 05:07, Alex Deucher wrote:
> Just use kmalloc for the fences in the rare case we need
> an independent fence.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This also means that we can nuke the two different fence implementations here, see amdgpu_job_fence_free().

But this patch alone is Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  3 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 21 +++------------------
>  3 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5e2f086d2c99e..534d999b1433d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -470,9 +470,6 @@ struct amdgpu_sa_manager {
>  	void				*cpu_ptr;
>  };
>  
> -int amdgpu_fence_slab_init(void);
> -void amdgpu_fence_slab_fini(void);
> -
>  /*
>   * IRQS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7f8fa69300bf4..d645fa9bdff3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3113,10 +3113,6 @@ static int __init amdgpu_init(void)
>  	if (r)
>  		goto error_sync;
>  
> -	r = amdgpu_fence_slab_init();
> -	if (r)
> -		goto error_fence;
> -
>  	r = amdgpu_userq_fence_slab_init();
>  	if (r)
>  		goto error_fence;
> @@ -3151,7 +3147,6 @@ static void __exit amdgpu_exit(void)
>  	amdgpu_unregister_atpx_handler();
>  	amdgpu_acpi_release();
>  	amdgpu_sync_fini();
> -	amdgpu_fence_slab_fini();
>  	amdgpu_userq_fence_slab_fini();
>  	mmu_notifier_synchronize();
>  	amdgpu_xcp_drv_release();
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index e88848c14491a..5555f3ae08c60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -41,21 +41,6 @@
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
>  
> -static struct kmem_cache *amdgpu_fence_slab;
> -
> -int amdgpu_fence_slab_init(void)
> -{
> -	amdgpu_fence_slab = KMEM_CACHE(amdgpu_fence, SLAB_HWCACHE_ALIGN);
> -	if (!amdgpu_fence_slab)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -void amdgpu_fence_slab_fini(void)
> -{
> -	rcu_barrier();
> -	kmem_cache_destroy(amdgpu_fence_slab);
> -}
>  /*
>   * Cast helper
>   */
> @@ -132,8 +117,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  
>  	if (!af) {
>  		/* create a separate hw fence */
> -		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
> -		if (am_fence == NULL)
> +		am_fence = kmalloc(sizeof(*am_fence), GFP_KERNEL);
> +		if (!am_fence)
>  			return -ENOMEM;
>  	} else {
>  		am_fence = af;
> @@ -806,7 +791,7 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>  	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>  
>  	/* free fence_slab if it's separated fence*/
> -	kmem_cache_free(amdgpu_fence_slab, to_amdgpu_fence(f));
> +	kfree(to_amdgpu_fence(f));
>  }
>  
>  /**

