Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6EDC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 13:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6391120CA;
	Thu, 14 Jul 2022 13:26:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A3E1120CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 13:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl2k8cZiq+/Jf7ykny+vYzEHL/Kp/b/g5Bf4/egTRTBB/q0tHhFmvORTzBKnGCXgWNPIEVxep34hJXa+whWI/HJPTo2QNUr4zzpxFfJddEkLT7gynpIiAsxhmFX44gUJCdpJkrKPzHh81I2mWkVY8eE3S7TdQJMgwm777zmO6VBb565pHy17Z3Vc19dtQ58HNW07rkLXlhg5gjPvvIkSRvQYQ60nDoZZwzf3nezZa32/ZcKpVLSnmzhP0lh0eu1drzWul7tTjB415InYdW93Hwzz0jHfGeJ+VIylsVtxAVzj90779w+SD+isSHqxckCgKaCQJhoajcUEFQFGGLjsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FODAs0PZlQQAedqC+4MerM3ZfHlO3ghBmwcpniNtc4=;
 b=IZ+NAekMXC+vXqu/RR0If1372izHqLSQahGdiJT/2CAv3EHbDPQT2Is9TfeSycGGwXJU8DsIjSu7h7hoHxRPAZInzSCr3Fltrl4wyQ+t00MIblUlGxteoMynT0vLjv3Xwd9VsxLWwAiRUouHsCYYQiIt3kw8+nKnkgD0wrjIYxbmISXHBQRAjtOSIS7zADQaWXAaUCbbNftk3OB0ufkCtlPw7rx9CsX0I4j6c/LSehjWj4OeOxBplhzeGm1xWvQBLY0Syz3bjrYLRKHY2Hou5/dQwMGutqJP7aXKHL3t3pRisICztXgX54yxSbcgvzTHPgTExU/OaGGVODpyx0i0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FODAs0PZlQQAedqC+4MerM3ZfHlO3ghBmwcpniNtc4=;
 b=0jOLVLHkEsdDm1V0bmkzVcR3PnR+UjmtJcc5C1Fu9fIDUEYuiXyXsLIr/cAJnrWMAx2OYCmie48eW4qo9xse1B2G6g9OktRMV3T7YshBo3ZksSbpTFCETCSopcD7ffqDf+g/l54xM325zhPzsj5niynOBN/+/Xo4tbDfcEK2wEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 13:25:56 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::a1d8:6a71:213b:6e14]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::a1d8:6a71:213b:6e14%9]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 13:25:56 +0000
Content-Type: multipart/alternative;
 boundary="------------kGDTDzhow8gQ8gN1ZubxxMqQ"
Message-ID: <7d898173-d881-ff28-2750-9dd1a9ca084c@amd.com>
Date: Thu, 14 Jul 2022 18:55:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] drm/amdgpu: reapply "fix start calculation in
 amdgpu_vram_mgr_new""
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220714132315.587217-1-christian.koenig@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20220714132315.587217-1-christian.koenig@amd.com>
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 212a2517-b249-4a82-e4ac-08da659c624e
X-MS-TrafficTypeDiagnostic: IA1PR12MB6284:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9w56puVmTY/ggHLmjgFWJR6yzRyG6aPrIm0bEdXOFffcUZgwryK0fbIC7HNCxMlx43nzvHxCGka3EnHPYAbfXwTxGnLlYBq5Cs/xat7gS6WuytowOjFpsP6FDl5+Hs/iyn+ahZy+c7tFvvGRHoF/AHIGhPsaPQJ12pcoPDPjLdcuzb5LOy+6dy1xrFafAKGA6GYSkSqAI8w450TZDZPib7jbx8LpngjJe+rU/gmyeOQTib2l+PdG0aHvy8e7S2BO9DjELlxAE5XeN9qMnZ1gK2mt0fjzVLoWdbCXdFS/sZI4kxp0OLCVcjYlGKmuYIAsohviVj18ral5SENVmdeQn2p9ZgoQFlHQ84537dhfsJOAk3GowYzGmaSNIFow2yXYw9md3MQ9A+y7gwzjbJcKnYzMMPUNrLvFWXQIWhb2OYn5qq3LiBToiFLrNYs+82jgKX37jhXEBaxaNaV3YEqogkEhdFypJy1p/YwZFC2ZkEi8I4k5ysNb0juR2mstXdAUG8UauGjZUJ+k/BkXURXr0kaOd/r0uiWe/3MlAhI8X30YRuiOfAU2SzHi+X0hQn5PkmYdahoU4dIArrL8pJnuVdbcQz57XTdcG8bolWp7JupN2C4/wMSYj+vjBzDVV0CvP3u9UaOsRy29JOKoAK+pDhphjan0Ls6UPeHk7AbY7Trx3r3JTYxir7TttBQ3bf6WkA9M4o/M0Jy/aUFoptlw4MU23zG4D44Ps/pgrgus/hPRuRnE3yiOSE4pWsupIUgtVIVG8XsScFCiG+uYKnRzU+eevR4Ffg3s+y/3/Qq1wTdlUKJk7DWNFuTsE25impvfxj57+qrwN2IDPVWvACfMCwzSLw1pbN5JVH0ROtO4oL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(83380400001)(86362001)(66476007)(31686004)(186003)(31696002)(66556008)(66946007)(8676002)(38100700002)(36756003)(316002)(26005)(4326008)(2616005)(5660300002)(6486002)(53546011)(33964004)(6512007)(8936002)(41300700001)(6666004)(6506007)(478600001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25zbzJNK2Vwb1RBQ20zNDhhQlFsQkxtdzJGRWlMTGlqanRCWXAzV2hXekZL?=
 =?utf-8?B?ejh0Y3lxWkxiVTNJbmxYajBUYnNCZzRsUGlySEFvRlJPRkl6KzIycmFzU0NV?=
 =?utf-8?B?dEpjR3Q1SkNBUHo2WlBqOGtuUTRMMXRxcVNxTERrK1ozQ0JKZHZ0a1BQc2VM?=
 =?utf-8?B?R2lWOXhaRXZ0OExFc2ZkcjhuemJZR2p3V0hTR3cvTE9pLzN2Ym1mTnZ6a2k3?=
 =?utf-8?B?MUdmMjNVbzNPMEVQNW1mSEEwb09URk9mUktSdk42U3ZLTjM2d3dweFdzbWhC?=
 =?utf-8?B?MnhScCtLakpJVlRINGc5OUVHenIxZWxKUEs0dHBOUkp3UlNnTUdDbHdWNmkx?=
 =?utf-8?B?Z0hSRjJUZkJjYzRmdWZsMW1wQ2V6blhSanhZaGtXMCtyT2hOK0dCUjUrSGlp?=
 =?utf-8?B?dk5aVlduaUFUOXdOckYrN096U1FQeTdnMS9tUlpxd0tvSnZ1bVJUNStpUDlh?=
 =?utf-8?B?Sm1jTXBpazRoY29iUnBxbEhBSjFrNGF1UVVNNWxYaWJ6VkdMWjhwYng0Q2JD?=
 =?utf-8?B?VkJpcUx5TGZtVld4d0hHRm53ODVjNFZCNzc0dURrQkxzWXkrRXR3Ym5sak01?=
 =?utf-8?B?U3JUVFdXQkkvakcydTZOUGpPSFJtN29EeWFhS3F0Vnl6bTZMQ0RxUDZ1K1lD?=
 =?utf-8?B?aEF6WENncHdsSnBpNERzaEUwTnlBNFhEdTVNeURwVW9kTi9rLzg4dVFmV0Z4?=
 =?utf-8?B?QnNrSkVMMFQzTjZmZnU2enBucFIvVHJCdm1GYWFOcjVjQjJyeUVXOWRUVUdV?=
 =?utf-8?B?YXRoRlJWRU9DcFM1aGN5b2tzd1Jwc1JtamlXTnR3ckRKYmJhTWxrOXNvVExi?=
 =?utf-8?B?Nk1WR25hSVE0Mk8ydTU3TmVYU3JnU0N2eURub0QvalphcTRJVUFkaFJMeGs1?=
 =?utf-8?B?NC84SVJSemNuQlkwRUhJMDBER3p5bllhcHQ5YmhyYzhnangzSjgxS081NTdH?=
 =?utf-8?B?YjR0dEJESEV2enp1UitYa3F1N2JHOHJnRzJ6UVNGT0ora2xkcnBYcFVrNUJs?=
 =?utf-8?B?dWkvMGxaSTZRbmx5Rld3ckRNQklVMHMvV2xGQW5jdzkzTVJ1alFWK29lUCtS?=
 =?utf-8?B?YW0wS0p6SlFDaklXekovRHZkaFRhMkhYVlE1MDBVSHY4RUxrQ3pKSVJvYnhM?=
 =?utf-8?B?WWJGVmNGOVpUT2R2MW5uMmV0bkc4bWtVUjl5YXcvMG5PWHphOXRxSmlVUExk?=
 =?utf-8?B?VmdGcmNEdW5zZ2lmN0ZIM1NHaWNBZmhQZmRVUHY1bmZ6Y2JDb1NvNmFxSzZj?=
 =?utf-8?B?NUszTDNKd2dZYVZzMENUVzBZT0pRNHhDaFZ0TW1iVDdtanFkT095Y1ZDcE5w?=
 =?utf-8?B?OExlckJ2ZjFOV2ZBQlFLdnp2VVZGS01uTTR6bld5blBNVmRuOUNVSmtBVXpP?=
 =?utf-8?B?cDdDdVNyT2prc2p1aHZ5amtqWDdlRzdlRWcvako3REFDYzRiS0k3cStLOE5a?=
 =?utf-8?B?R1cwQlM4MGtIOVFVaDhveDdQYWJObFZMSEVKZ1VnQXJVM0hWQWNwRkVHU3Yv?=
 =?utf-8?B?cVorR0tmZXZ1bEYvSWNsRlJnbDNPQ3AxYTR4bkNIbXFkY0FRR3RIOE40TEcy?=
 =?utf-8?B?ZUFucmc0OS9Zc245SzQxbWNveTJieU5QaTNTT0xNbHIzY1h4R0s0c2V6RmtY?=
 =?utf-8?B?ZkNpbXVKSVJoenBGd25lY05YVk5RdUtoTGVZTStzU3QzdUJHUEttTU9aTVdN?=
 =?utf-8?B?cnpOdEtERmZuM3UxTFUydFhydkhnUVBsQitvK05FTEhQNEtvRmprZ0ZGaHZs?=
 =?utf-8?B?NkhpOXphWXFEQzZMNmZhTi80QUdOTWJCMVNiV1RiNHhUTHNjejd6WFN0ZkhM?=
 =?utf-8?B?bVpjYlpXcUVpZ3hwUXE0aVl4Mm1uQ0RsSDhlNFFKNEZXV2t1TjNsVHpmK2sw?=
 =?utf-8?B?UEFNZE13bFZ0a05CT2Z4SXg1S28rcWdSeU5JbUlqWEZNOTl1QllCVGhya3hG?=
 =?utf-8?B?VERRSm5xWWx0NDRtdGhwdEhFMTZNZllvazh5MzlPRE0raGFqQTZzOHUzZmhw?=
 =?utf-8?B?VlhSeWtIaUx2cUh0d05idWU3UFAzSXVOc3ZPcUoyUTZRRFBRN3N0S1BYSWt0?=
 =?utf-8?B?RzczQUhLcE81OEN5ckwyS3ltZWZ6aUJzOVg5ZEJXVVVpbkptbUNUMWFWTmZG?=
 =?utf-8?Q?1IRneT3YzMK5h/ez5RgJ5ssc3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a2517-b249-4a82-e4ac-08da659c624e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 13:25:56.7643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL031utTWZFGoiGJcacLvGMAwdepjG7K+s9rHE1UxKF6sPhcho2zdqwx4JC6EjbcpD+M6Ak6aKgtHYJrgv59GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------kGDTDzhow8gQ8gN1ZubxxMqQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

I verified the patch.

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Regards,
Arun

On 7/14/2022 6:53 PM, Christian König wrote:
> This re-applys commit 5e3f1e7729ec7a99e145e9d8ed58963d86cdfb98.
>
> The original problem this was reverted for was found and the correct fix
> will be merged to drm-misc-next-fixes.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-------
>   1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 49e4092f447f..51d9d3a4456c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   			list_splice_tail(trim_list, &vres->blocks);
>   	}
>   
> -	list_for_each_entry(block, &vres->blocks, link)
> -		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
> +	vres->base.start = 0;
> +	list_for_each_entry(block, &vres->blocks, link) {
> +		unsigned long start;
>   
> -	block = amdgpu_vram_mgr_first_block(&vres->blocks);
> -	if (!block) {
> -		r = -EINVAL;
> -		goto error_fini;
> -	}
> +		start = amdgpu_vram_mgr_block_start(block) +
> +			amdgpu_vram_mgr_block_size(block);
> +		start >>= PAGE_SHIFT;
>   
> -	vres->base.start = amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
> +		if (start > vres->base.num_pages)
> +			start -= vres->base.num_pages;
> +		else
> +			start = 0;
> +		vres->base.start = max(vres->base.start, start);
> +
> +		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
> +	}
>   
>   	if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>   		vres->base.placement |= TTM_PL_FLAG_CONTIGUOUS;

--------------kGDTDzhow8gQ8gN1ZubxxMqQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Christian,<br>
    <br>
    I verified the patch.<br>
    <br>
    Reviewed-by:
    Arunpravin Paneer Selvam &lt;<a href="mailto:Arunpravin.PaneerSelvam@amd.com" class="moz-txt-link-freetext">Arunpravin.PaneerSelvam@amd.com</a>&gt;<br>
    <br>
    Regards,<br>
    Arun<br>
    <br>
    <div class="moz-cite-prefix">On 7/14/2022 6:53 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220714132315.587217-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">This re-applys commit 5e3f1e7729ec7a99e145e9d8ed58963d86cdfb98.

The original problem this was reverted for was found and the correct fix
will be merged to drm-misc-next-fixes.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 49e4092f447f..51d9d3a4456c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 			list_splice_tail(trim_list, &amp;vres-&gt;blocks);
 	}
 
-	list_for_each_entry(block, &amp;vres-&gt;blocks, link)
-		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+	vres-&gt;base.start = 0;
+	list_for_each_entry(block, &amp;vres-&gt;blocks, link) {
+		unsigned long start;
 
-	block = amdgpu_vram_mgr_first_block(&amp;vres-&gt;blocks);
-	if (!block) {
-		r = -EINVAL;
-		goto error_fini;
-	}
+		start = amdgpu_vram_mgr_block_start(block) +
+			amdgpu_vram_mgr_block_size(block);
+		start &gt;&gt;= PAGE_SHIFT;
 
-	vres-&gt;base.start = amdgpu_vram_mgr_block_start(block) &gt;&gt; PAGE_SHIFT;
+		if (start &gt; vres-&gt;base.num_pages)
+			start -= vres-&gt;base.num_pages;
+		else
+			start = 0;
+		vres-&gt;base.start = max(vres-&gt;base.start, start);
+
+		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+	}
 
 	if (amdgpu_is_vram_mgr_blocks_contiguous(&amp;vres-&gt;blocks))
 		vres-&gt;base.placement |= TTM_PL_FLAG_CONTIGUOUS;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------kGDTDzhow8gQ8gN1ZubxxMqQ--
