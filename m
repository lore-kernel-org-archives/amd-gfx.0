Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27430C001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 12:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCE610E27D;
	Mon, 31 Jul 2023 12:26:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F140C10E27D
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 12:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N78lZs9wuj2mmR+cbL7AH9t+OvS02MGwzDbbUmGhehGS/zeSorVcJKz+whWIk+8crYb9FH6Su5gINY7ZyYpoUtq+HuBafAQL35Xo1Fs8UMuXant/RuPHYuExQSHUfCovEh4u/So03Il9aegDOecTZ8+rqmN6GAvPJ7MRzzdxfF6m4cgV84U6SwQnjC8z6l6nerriLo6zL81PrYioTZih+SpY2QYLSt3iJK4Zb5pG0nnpMkaXpN0AJgghe7WsKb9YkGdcsLS4JLtGQRk9v9Yo7k2PcWkEnF+BbCEZtFvXrw4NAfSSajLIeOrEL2TNWQbTPhTTm+U48UVpxUMFORyU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm+FTLg6xKme+wSEZYCmb/lyAoi604vZtO5H6QH51Tk=;
 b=jp1KVP2LkuaIolxetu1pTNfQEe6Hp3YdLSJHCoZGLWE53grvb3EIliAhuXdPydvCU5SNpKF4lm2xyFY4UmxElR98TTTI4e6OeAR9GHWv/1Xez/Iv9zhzKBZXhMgCWWy1IMuZRXw2BtP+cV+eGRshO1sSEt9taKSzPAvegeO1HFbMeyRWZKPo0sDjkGlOgkp7hAeS1wHXeGRgiBqjwwHYNp5rrEIFxiPIMXJimJRRcRnmfOPY3Sn2ahqlFvLNtLRaXZ3fDw+b4SLgntqzWyhgOQ2H2kTWrv+PRyVzUtJxovMX6Yt7kTlgeIu/pOxlnQMFwHaJQvsmjy7N2m12Y2TcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm+FTLg6xKme+wSEZYCmb/lyAoi604vZtO5H6QH51Tk=;
 b=dLUEHorptCXQ8q27CUvCypLOS5n/9o/P1jV8IhjtYlP0nCQaHlB/nFuq17i2SWSNzZ/VxCyIua3uSx6MYQFzxjU/Jy+OXGNSjfL5b/H+Gn0qeFZ7Ik27H61NeVxdR25f/A2Gn+wmFw4EMsyG+W8yr2UBw8zlfS6d2tegMaw6g7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 12:26:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 12:26:06 +0000
Message-ID: <fc1bce6e-f6a0-d0f7-5e59-5a19c4938732@amd.com>
Date: Mon, 31 Jul 2023 07:26:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] drm/amdgpu: Move vram, gtt & flash defines to amdgpu_
 ttm & _psp.h
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
 <20230728042726.2679963-1-srinivasan.shanmugam@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230728042726.2679963-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbeccf8-6a3c-422d-d97c-08db91c15067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ifHi5CrMCP5etk1B7HDe9DoGk4vud5Kn41OkMGfJ9ffAetTDizcHAnAtoVCO3iebvWVPTsJImRIaPgLC9d3xHo+Hw/wGTBwIDD+Rg/eXf5SCImPPk/xz0rZXP6rjOPAJjHEMvM1Mk2WQR14/jIa4WzxKLsGNVfDlM4+m7bQtaQzKSqZO4wCI3Ias2aVz1GGsz9sEz9GttGyYxvaabcF/PKVGFsEtvNID7Jk2XehpjHVYSAn2uVoGz8fnGMz3cQqOzpauXiISsiqb+sP8XU63djr1m3wxNHcZomCqVajFkBT5CCSifr42/mxoTz6DZBWkURk1XruCpRES4HdnzhhJLBdxzUB1y+pdCU/K2zhK0RqGWur54crf73j2RV1xgV5ZKRuwoWonx+5kZwQzm3PGGXrHF2+fMkUCx2SkSw9NmFkjWYV2BgPHf4LqLuj3EKjiJzLqB5vI3RSoMGU1EbYO+D5bpMNGMclfupFb7bxMuMfT6a4kKBqe+qcRsku4G3gkNFKxJV4JD2qvJsiRb4IyrtbCXX0EyCj0MXsz/WGCd4hfkUrn7Fq7yrLSms1njDRBo+KX5yJJsRQ9PtOSO3LDdwj9Jyw9IJ7W/Rce1y+JXM2Iz1mx4hqR+Vywt+EssLH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(478600001)(6486002)(6506007)(53546011)(6512007)(966005)(6636002)(4326008)(66476007)(66556008)(110136005)(66946007)(186003)(38100700002)(2616005)(31686004)(316002)(8676002)(8936002)(41300700001)(2906002)(86362001)(31696002)(44832011)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZklGZGlmcE5TanpLSE9paTVYdDQ4cjRzYUxIMXRjQ1pFa2kydEZFRFFwQ2w4?=
 =?utf-8?B?dEJJYVNmUlp5ZDA3bXo5dDRtTExQRXI4c3B1VVNyVDEzeko0SHl5RFFtSFBX?=
 =?utf-8?B?QUV4eGJvQmliMjlEb0VJbUhwa042VjFDeFU3eXpTTGVzek14blpJT05temF0?=
 =?utf-8?B?aVFCLzBoRCtrZHBLY25ZWlJwYmRjaW12cVpXWHlXQ0Jmc1BWdDVJeE9uaWVy?=
 =?utf-8?B?MHVWaW5QaWhiTFRzVXdhS24zSmdicGwzYkw5Rlg1WFYrZjNYUDhpSWNKakh0?=
 =?utf-8?B?U2I2OThJSE8wR2tPZ3VMUTBUTjBSMTdIUFNXM1JEdzFnOU91dFk4Y0szSXpx?=
 =?utf-8?B?dlJkUFdYVkM3bDVRNTZGTXZIZ2VNODU2ak9sbDJUZlVGZEl5UEY4dEJTMGto?=
 =?utf-8?B?QnhUVnJWYmhOM3VCNFp6R05lc1g0OVpaL1pRNGtidHJicS96ck9QM1JkdWYz?=
 =?utf-8?B?dWxHRzZpZjNrS2ZwN1JDMmFoME13YTRWbnlDRG9nSVJDMFJkYXdRS2lNZUZv?=
 =?utf-8?B?M2lTdk9jUmRlcGJnVVV1Q0x0UHZIR0ZSMW9mMzhxQWxncE1kSW00Mkd5SElx?=
 =?utf-8?B?dFdkM1FTV0k2Ri9SREdzbzVaSVhhSDUxUXdBekVPVElNUVpxbzZPQlpKK29s?=
 =?utf-8?B?Um5RMitGQTNHWFJzc2xmb1hJQzFoMmlTNWduenZhU21vV2lXVm53TTdNZENn?=
 =?utf-8?B?cGZCSlpOVlZDQVlldzU1ZGxqVDdCdUJLc2U0ZlZKVlNKVzhvNlpURkNhekVx?=
 =?utf-8?B?dG13Q1ZmelltdUhFSHFmdllUMTk2ZjlwL2JKRVRUM1VyWTI5SWtRclBSQ0dI?=
 =?utf-8?B?OGorQ1JRVmVUa3l1dUNZYzl6d0habm1rdFFHWkNPTit3OUlLaHoxZ0ZsMzZl?=
 =?utf-8?B?UUMrWjlVbmVZazlEM05RRlZ1N1g0cktaenQ1UlhXaDRXeXJxU2VQNit5TjZo?=
 =?utf-8?B?MjRRd0EzZXA4M0lsS3I5OThFUStoZWVWWFRpT3JwSjVwa0pXcEF0MENkZkhY?=
 =?utf-8?B?QnNxZTRDMU5iLzRXT0c0SkZ0RWZUNG1JOVFrcDAzV1NIMUZKaWp6S1RjYjhC?=
 =?utf-8?B?dUplVnpzRlM5VHRVeEViRlp5TUxxRHlvRGZjZlVKQVY2SUFqQU5yWEs1NUhF?=
 =?utf-8?B?QTBGNXY0dHE1L3ZPWXVkUUpFWjFIM2U3bHdzdHQ5Qk9RVzBJYVpkUlRuZWZW?=
 =?utf-8?B?ekFOMU02RUlpUzIzUGlTTW1lOHdMZG4rOEdHejIrL3BWVVJaZW44bHNGNkpo?=
 =?utf-8?B?Sk14Yms5OGRoTTBTMTA1Tmg2MmFIdXYyZzJ3STFhL3RqVWdBSTRTM2lTa0ZD?=
 =?utf-8?B?K0x6aytYTW1DYkFnOTdDeUVld0dMY2c4V28yOExYOWpnbnRrTzNCV1g1Q1h4?=
 =?utf-8?B?QTBTbUp1cVM4Z0dZSjNjM2FaZE5xYk8rTDFlaHh3UU5ReDl0T2JQK25BbXBx?=
 =?utf-8?B?QlFYdzJRVVc5K0lzbFp5S1k5VlFDNWJiRGdCZjhCeUpUMXR5M0dua3ZobFYr?=
 =?utf-8?B?bjlEa3cxU0hTTzhDUjRraXVMTjFHek4zZFBGK3Rycll1MHpaTlg1MDVxZ0JY?=
 =?utf-8?B?bUhOMjROa1NaaEZIeUFFei92aDRsT3pjem1paHRnM3pOcFNBdTIycnFpRFhj?=
 =?utf-8?B?TWZpWDFlMlFZNU5uL0ZYbUdsM3d1YmtDRVE1aVNaZGl2Rml5UEIvVUNLeGND?=
 =?utf-8?B?WC80R1FkY3pCYXdJZUdMc2gxZDk0NzNrd08vTmY4QzFnUmN0ek1HMHJVanV1?=
 =?utf-8?B?ZFBEMlRrSTNOaUliMlhOYlltU1IveHJuWlNnQmFmTGxIRWJqNktNZ1lSUk96?=
 =?utf-8?B?clZjZ0NGc0ZlUkR4S25hNERtZ1pKTFdTVlk3VWVEaUVORXBTdlBCOVJGTW00?=
 =?utf-8?B?U2dOTkhncjIyNXkzQ25tN2dMQUNBTWVIdDNWc0FzeDFtbGRLREFHMDR0MWRZ?=
 =?utf-8?B?WGkyRXhqa1N0VzRhcmVWQUxaRERPeVpGK2grVktPVHpYUlVkbnhpSjhBWFVI?=
 =?utf-8?B?Qk0yY0N2eFdyQXMxbzRCZmhEOStrZ2NYeVRiNXdRMDFDZDM1OHFqSkpTQkZD?=
 =?utf-8?B?emkzQlFQaXp3eVFuaVo1cUZmaGZoS0MzdWVBUmFGZjJEOGQ3cUVpQmx1MThx?=
 =?utf-8?B?a09DK2wwendCeUkwaTkvTHo5VkM1Z3lGdVVHNSs5bFl1dVI5WGFmNThoM1c0?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbeccf8-6a3c-422d-d97c-08db91c15067
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:26:06.8455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Afks3799gRS8IMNPrOi1wSbKm7zS0+f5tM6bZxLPVd2BAVUGhfx9JgbOvT22ZMf289+skJC72j10TKLr+2DVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/27/23 23:27, Srinivasan Shanmugam wrote:
> As amdgpu.h is getting decomposed, move vram and gtt extern defines into
> amdgpu_ttm.h & flash extern to amdgpu_psp.h
> 
> 'Fixes: 35488e44ed48 ("drm/amdgpu: Move externs to amdgpu.h file from
> amdgpu_drv.c")'
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> v2:
> 
>     1. As a prerequisite, sorted the inludes in other patch
>        https://patchwork.freedesktop.org/patch/549850/ | drm/amdgpu: Sort the includes in amdgpu/amdgpu_drv.c (Mario)
>     2. Include _psp.h, & moved vram & gtt extern defines into appropriate
>        places (Mario)
>     
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 +++
>   3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 90faaf1eadcd..0fec81d6a7df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -45,6 +45,7 @@
>   #include "amdgpu_drv.h"
>   #include "amdgpu_fdinfo.h"
>   #include "amdgpu_irq.h"
> +#include "amdgpu_psp.h"
>   #include "amdgpu_ras.h"
>   #include "amdgpu_reset.h"
>   #include "amdgpu_sched.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index c3203de4a007..e8cbfacb5ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -39,6 +39,8 @@
>   #define PSP_TMR_ALIGNMENT	0x100000
>   #define PSP_FW_NAME_LEN		0x24
>   
> +extern const struct attribute_group amdgpu_flash_attr_group;
> +
>   enum psp_shared_mem_size {
>   	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
>   	PSP_XGMI_SHARED_MEM_SIZE			= 0x4000,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6d0d66e40db9..96732897f87a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -39,6 +39,9 @@
>   
>   #define AMDGPU_POISON	0xd0bed0be
>   
> +extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> +extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> +
>   struct hmm_range;
>   
>   struct amdgpu_gtt_mgr {

