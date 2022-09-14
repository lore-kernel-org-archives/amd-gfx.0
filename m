Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71F1C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 13:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CF310E91D;
	Wed, 14 Sep 2022 13:50:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9CF10E91D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 13:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9g5r3PdZOAoGU8OCDb6/R8WAY05jUCQZM9CQNg/CPDAPM4N3Oq/iPx+DvO1sMnge4lhqk0Sa/P84xs5en/UL+wnBXyI3U3OAU4HtHuVeoxCmrS2ynzRzwIdUUBW3ojfLiWpXjI303st1pGVPUJxpimwV1gZflaEF0wKBRwdm+g545YfdGpJIdKdtKVPkG4ZxNV7l93VONhGiNPjFui3URqQRfdjcYxQVbIY3cn8wuzxyPEOystvniBex9J4Ahsu1D7+8Fr+8w4TqBT/9JmJ/CMgXt8oH1jO5Xa6pBWY72QqtVDdzcUkIHkAfLMRqYhNkHeSCTcAgbEltAUiA2UVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys7YgcEmDrY4Tq5npBrumHBO8nP8z7Jjo8pcBJgr2uw=;
 b=GSL6QarTUVNgmW0uGqi8pdzDF/UDHa683nH65oCtwVS4lEA/hFNr2XPOc9fvUwATd3ZxseS+UYnAnRyEtahTgpNvnkCIfchFtIXTEm6/vfCuajWeENG9Q77uj2MN7PkDNMrbAqO7e8OpcRd18UT+UR5o1S27eEtEfApu6FkdyxTKv1Mrzj071vEH7NU75GpvmlWowY1UmQU4Z8H3quupu0XHHbzZLDYK15yCS8fHrolGcwv/rZjiSBS+F4AgtsHkhtkrgbh/k/HVD2aQTxQ1vPw6SXKE7GsfSZr1aHYEsvGCM/5sBvJKKH9RH4ZyoIn59NW7mqKw06PkTV6y8IXutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys7YgcEmDrY4Tq5npBrumHBO8nP8z7Jjo8pcBJgr2uw=;
 b=JJ6I11Q3theIF5i2bL+mP0KMqOkMcXZTJYAv5IJP9XcmLS+3WX9JaGCiQIJazO8K4OJCNINAZaJpoc2feLu8Ep15rWpn/a7hxAOT+xYK7MhA79X+nDIFWghF1c+rDdlt/i59shVF4/DggTLsZbrmzo9s3IRDDy8U1QLf5JxYgL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 13:50:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 13:50:21 +0000
Message-ID: <037c9e48-ca53-0f3c-edd2-de58b43e96a8@amd.com>
Date: Wed, 14 Sep 2022 15:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix the lpfn checking condition in drm buddy
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
References: <20220914125331.2467162-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220914125331.2467162-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0630.eurprd06.prod.outlook.com
 (2603:10a6:20b:46e::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d2e1c3-838b-43fd-0880-08da96581085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYfbBp9nLdEWRKe2iW4IRHiykAtgXqsT6VOkMb07CsqpiIoEjw0AuVdfPgqucsT7iyRDRMmKXa7bHjfjVhqxwUhtuwllcc8Alj0NZl1+rO4vrZCNn0IdguZ8cV03XpFHeiiLT5qoZRG2EfKqDbiQFE0dIos2+U3rpLYb4u2MTFbx2snrn4g2wS3gSdZLyxx4fAnQmGPxgDC6TtYPybfJ7cTrgD/G8A5VYFhmLahzT2WysQZdBRjrs+j+KDJbAPcYUQXnTF/RWXEX3+ePelbJn9fteCUQYWv2KEc3brF5/SPcTmjKU7h2+WdaPreLxxglFLRfB1VhAvfVii7NWPzQ2oV/A43mqnyjVS6Byd4zFC6ef2CAYCYPHCPbkN6EtZCCTxVG6KGaut2duWDoaeKGlTTTtUP3wdcy0rZ/ChRrtaXDEiYetnOsDfZ86qHeWvBFxOuQdpK7/TF6dnmSqofiWRe5Fz1FocDQKlDOTP4sl6K986m1NHN8SZa4XSseWHnxtLZ1o5ciryBBeZ8U7Bv25xwZtsP9+6BA349YWrII3GzZVPV9Z2Doi2A+E8MOFMZh8fCd5Zx0YzhxQzt+i2aT9TMdnecrQ022P/PCdnyQ18H9f/a7DRnFL8i/oP74/CTjU6F2896V624kbeQC5LOgL5r7Xizen5REzbADIOkqQ6+asxU73ItOO37WNestgrszn0O0TA/eq+AmvAum/mt0HbpPzOyM/WurdxJ+jOuilRz/YhDg6dDwyemENxxOmGu0tjdy/zUru/q5jUi4kw+Wqo1wwd2bOoG+3zBpMRAL2CQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(6512007)(8936002)(38100700002)(316002)(31686004)(8676002)(6636002)(66476007)(6506007)(66574015)(66556008)(186003)(83380400001)(66946007)(31696002)(4326008)(6666004)(36756003)(2616005)(86362001)(6486002)(478600001)(2906002)(41300700001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtxSnhVUVhKaHNyVnYrQ2ZtazNheWxkMENZNVB4dVBHOVk1VlNKUjdTaTF2?=
 =?utf-8?B?ZWJ3S2VLa0VhQjVHTXhRSndpMm5FNE44M0VYQWVjcFhjdlgrbzFBUEJreVZr?=
 =?utf-8?B?dmxYWEh5K0tIWW1MWHV5ZkdOYU1RVlVBWjFsb2ZTNllkZUxqM1pldGZDK2Jn?=
 =?utf-8?B?SjhQbkVHT3Nwd0xuQ1NMcHRxeHU2eVExVEw5ZW94SXZMcHdwS21qT1hhaUR1?=
 =?utf-8?B?aDV3dHg4cjdRc3ZRMCtONnRZS3MrNXpxakRLekU2OFpacmZ1Z04rT3BPcHF5?=
 =?utf-8?B?YmxIZ2FocXU4L1B4cDBmc3RkVnp3UHFHV2dHdisvRnZiWUNmdXRZWkUzYXBu?=
 =?utf-8?B?bW1SMTQvK1FWZ2E0dTJ2K3ZLdDRobkU1VHRNMlRQejlMcUpSMWJ3THdKRGRT?=
 =?utf-8?B?bnczNWZEYmozeUZabWJZZVRZTDRkWjVnbmFzR05waFJCdXE1U0RTSUl3NDdU?=
 =?utf-8?B?SzlyN3Y4eWNxVUhQYXM3UWZaQzh1R29FTytIRkFrTXVHZXIveHlmUElqZ1Zq?=
 =?utf-8?B?c01WR3plWkUwVkd6SmkxbWdFNEt1cWE3QllEcTdyaThNejBXanlubFRwOXRY?=
 =?utf-8?B?cGxwd2toVHFKRXg1dVB5bzcvNXlweUxmSWw0ZzhibEtIc1ZKZXZobTM4Y2hG?=
 =?utf-8?B?bk1aNy9DT0FFVEo0Y3NYSWQ3MXpjNk9Xa2x3cXlqRExpc2szT0QweXAzYmxQ?=
 =?utf-8?B?eHA0MndjSk42TFMrUmt2V1FxM3F3SUF1dTdEV3YyZ0JxdmJkNWlObWVrOHpL?=
 =?utf-8?B?WmxQcUV2cWFtOWNQZDdnZ0l0QmRqb0FFRm90UmFsSG9xd2xYZElGaGdhTStF?=
 =?utf-8?B?SU0valorUU1iMmFTN2NBNkhrUEZYY0hnanFlRjRGM1c2eEZ6UFBkZlBVSDF2?=
 =?utf-8?B?TXVNV2s5TUo3L3ZyNEJ5cXBWK0t1YytQQWlmdEtDTms1RWVUWElrczk0N2xi?=
 =?utf-8?B?aFpHZW1zeURMY0ZMRTk1OUdFNEs5alFSMmhTMzdOYnFYMy9lM25oTWtIUlNZ?=
 =?utf-8?B?NDFGaHJRZlkrZXRnYWFDNXkwdU1hdTU0aDNHU3pZWUxRbFlWbXRBQ0Y5ZUUw?=
 =?utf-8?B?SVdlVjFYbWJmMmxKaVl1R0VtKzBWdXV6cElNVUltRk1kTG9BYVp3MExJRjh6?=
 =?utf-8?B?MUdxb0hUOThyZ1pQU3I4Tzk0Q0FFVS9NNjhHaDhJLzczb0VBSUVwTW1rRHd0?=
 =?utf-8?B?cmpLYnZXVjVnek5xNnZ2MC9NbVlERFpWNGpZRCtMcFhsOXZrbVE3d0hXQUw1?=
 =?utf-8?B?SjNzQTF6OEhzY3lwUFR1MnNMWlpObGtDMm5FNm5HVEVUVENESXZJc2FHWHA4?=
 =?utf-8?B?WVUwZGhueitjSG4xVHA5ZnBWUGlNNVJXMUxvYlBwN3B3OGxmTk4wdzJiZlVq?=
 =?utf-8?B?eFdkNThhd2FPb0xPOXhQQWpOTEI3akdmL1kzN2VxQ3puSHRycERZb21meHpV?=
 =?utf-8?B?RWxKS29yTnlPanBWMkFuSlVnUjdoVndUUU5OVlpQWXdkTWlYRlRxUmFDTW1R?=
 =?utf-8?B?RThQOVhTS0JLV2VSRU1TVDZjRGVQa3pwSVVIOVZMeWZmZFRzMzhtc2J6aVdk?=
 =?utf-8?B?dEhINUZtN0NnVERjMW9hMDBXenRSTTFHRjZoMmtxMEdubU1zYldQK3llTGRN?=
 =?utf-8?B?aExEOUJsVnFhNzEwOHlmSkl6akJPOXJlbkVzMDFsZlRZZzJielZ6NVNmTmFk?=
 =?utf-8?B?bDljWjhJd04rNnQ3UExtVENlQmRlUGpJekxPRHlZM0sxK3QvY1l3TFdWQ1o5?=
 =?utf-8?B?UXVWYTY4S3VZRERCSmhzUWRzOXlzSXdlZnF6SmJXVTlDSkxta0cvSDd6d2tJ?=
 =?utf-8?B?R1RZZ3FHQVdMT1FYNWhLdlRDRTRqYXp1eDdmazZBcW4rRm1RRVRqaTk4ZHVw?=
 =?utf-8?B?VmY5M2RyRXBIdVdKdVRyRmg5U0owYUpOT1ZPUlA4dmh3Qk9nMVVneWlSTXBK?=
 =?utf-8?B?cUFWOGNBQ1o5cmFVZG5IZkxWTk9qd0tXdjZpN0dTcnl1MUQxanA1ajJhWnpq?=
 =?utf-8?B?Nkt3aDQ4WWl0c3pJV1RGaUxYWXdzODdZekpYNTBLSEZnaVJTVWRSNjVoOXJY?=
 =?utf-8?B?UGc5SFZNK3RSVE1yL2pHaHNjTDNWckpweU9KK000YnZScGlUL1RXN0h3anpp?=
 =?utf-8?B?aURqQkFxcC9tUUcwVkFpTkFqU3lrMHJtT1BDeUNleWh4QmpObW5Qc0drTmRR?=
 =?utf-8?Q?mS5ivzrSJLz7hN2rkOxX59jG59u+bE5Aguo8w2AzuNA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d2e1c3-838b-43fd-0880-08da96581085
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 13:50:20.8069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bam7gVjI8GwGHZ40tyDBKCm+d3BkWnz5zQw1dhyQVE8rnrbdUn0iTox3ctAqk1og
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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
Cc: alexander.deucher@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.09.22 um 14:53 schrieb Ma Jun:
> Because the value of man->size is changed during suspend/resume process,
> use mgr->mm.size instead of man->size here for lpfn checking.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 48e3dc28b156..0b598b510bd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -441,7 +441,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (place->flags & TTM_PL_FLAG_TOPDOWN)
>   		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>   
> -	if (fpfn || lpfn != man->size)
> +	if (fpfn || lpfn != mgr->mm.size)
>   		/* Allocate blocks in desired range */
>   		vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
>   

