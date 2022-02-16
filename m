Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C08C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 15:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31BA10EA7C;
	Wed, 16 Feb 2022 15:57:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E852510EA77
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 15:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBYQRvCFrNIP+wUqooFsvwCAWLXESK3CJ/C8EZBgjjxHs67LWkk+Vk487VB/kOis+4pZqdhPWw916BdthqbUGDKVmqtrhbiEE0znry71qtv7ZuBUWlCgWra8HlU5f5fitD65BYxAwdzDMGqoyClf6b1sToJM2TEju4FNA0LVSI8HEjE2j8HzhJmPZlLqOAavfL/gXbDvfYmdvy8Dr8t1jqdmaE7gns1IIVpk2S26ulYi1ISbK/1K3hGsf/+m6Gnfn6X8qsXnlMIWheTwGuY9xebCOcCNlK/ie5HgYEBP9XZ1PQK5QM9Ih0NXh9DHBOVhOzF4DsAo/wZ595VonfjMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvWGBAF8fCbkofJT0TARnCzs+dMZE8WcGBeamYatJ6k=;
 b=RTrNyMjHlUqwPvIaZ+uL2+vLGD7wsjNqHZb5IjERcuiCpUAMJjzcaNkWUDdbPdzIX7Qt080mp7B5ee9FR1u4ZV5J8tRluxOaMModv+BiZxrNxSkMTfrtqmiqaVlzPfcFxG9WybU1iSXXrXHASvntginVmYrwh1kM3NMRl87HbfmLJWxK1JMobK89AyCpcCnhsqBEHrJ1KhUJq42AKfP2ms8SwhNqQ3JhTgGnDtP/4/mRGimAJ60lSU9wiWWuSFgvb9jfwAPvJ+9Mb0ttxd/KusExIT+/cpCRMzYrOBhygvg1h/iJd8TLWXHW7xT99jJ43/QiaxJzUc/XG+mV6Ngv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvWGBAF8fCbkofJT0TARnCzs+dMZE8WcGBeamYatJ6k=;
 b=rmY7zA2uCe59Vqi2pWoE4eFSHBEGgqOX+jpCEwURO4rG8ZEkJ1gwecbZTzgEnE6ccusOQu1J/MuyMSIfzUoiGx5yN+1sOTikbe/XO+g7TXYv+GiowKdGkeVJCm3ykwWF5jAOKS141jdy3n42s7MfGq2qptxer1nyLKR+KDzTKIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Wed, 16 Feb 2022 15:57:17 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::7535:f1b6:a4ea:1527]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::7535:f1b6:a4ea:1527%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 15:57:17 +0000
Message-ID: <ef3f8c72-4547-b145-948b-328838dc1748@amd.com>
Date: Wed, 16 Feb 2022 10:57:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 6/6] drm/amdgpu/discovery: Add sw DM function for 3.1.6 DCE
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220215214447.2234978-1-alexander.deucher@amd.com>
 <20220215214447.2234978-5-alexander.deucher@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20220215214447.2234978-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:610:e6::30) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c216cb2-bbc7-44c9-d12c-08d9f16501a8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52481FA78128429C207FAC7282359@DM4PR12MB5248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nihXDEllU7YMy+7JzqMyepjmxzlE5Po1OK3aouy00/erslgoLK+J5Ei/nIbEYZrObjLCnSlSa1DRxFQVSd+jJvm+bR7LabuJXzlzgnM3IkA+a/e7a5wHWQPJxGDlAqPJby6x+8IeebTz0ux3RUKaHBl+sK9iLNvwJcROI5VJZMeE5ZNedwLdAMtg9pPKOIL+0HwlQMs+8EP/lj1WS7KoGcc8UYxsikNxVqdwckTq7YSNVsLFSjMfTM7vBjKHBWws+mB6QwJBUfil5CQcD4FenF9Uw6oaaoMFN9g4UcUvW367aQJ8L4xhZpW+nAMWNpPXy0EZTK7piP/rtpWoD7finVfvS3OprFKrDZJvHer6AfZxzhkzsvlBjTzmbGDL7QtKf02NrKR/Kir2QCaahC9vR42THp/zdDrTskV3Pbz99/++xAL22MqspieHLKXPxmjMkjcrRVUH9iIoLqEHVfwiqlxFv4+f3onJuft4UrFvCZfkNZt1dUhubTMwr4mevPrcnTqFKol2Ay7zks73Xei5Dwbj/mfFIiYQPUZYwQNiAAVO5oM9GDAoTADy1ciKRDuLKs1TR2ZCRTCDbKTFJWdcMpFlOzVbeGPHD3P0d+NeAMDobHClU/yYdkYyo+/T0gPwJreANeutM4c9fj3Mk/j2ikNihpODkd+8xgE3zvf8KBRaq2im/6xBocBWOKWA+NYo+mEWpqxtG0MkKGjylPSAUpNWb2waZv7mHxuz3Pv4bZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66946007)(6512007)(26005)(316002)(66556008)(186003)(66476007)(53546011)(8676002)(2616005)(83380400001)(86362001)(4326008)(38100700002)(31696002)(2906002)(5660300002)(36756003)(6486002)(31686004)(6506007)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FYREUxMnF3elNGeHJwbng1ak1kUkdhMGJVYlpEenZrbVNBRWZUZzZDYkNZ?=
 =?utf-8?B?cDRVVFJhRUJIenZ3U3ZwSVFBZFZKekRaQTNhOTZHUTVoeXEybkhLYTdFd3M0?=
 =?utf-8?B?NSs5MEh0ckhuTmhjUmhsSTRWQkN4SXJJOXRmdFp5R2hybXdQNWk5VmlPUEgw?=
 =?utf-8?B?NnVHMW9TazRuM1Bma0w0R2dJMkZRY1BrMG9UbUF0VEVFNDBsZk9lVml6L3Iy?=
 =?utf-8?B?RVBGaVhsTENYQVh2MWtqSW8zYmxxVjhCZlJROSt1bXJiL1NPWFFWSk5QeGVW?=
 =?utf-8?B?eWNLTkJNWFlxN3dKNTRJam1GbUwrcmhnc0pPUC9JaFFRM1JWN0lPVFFPcCtk?=
 =?utf-8?B?MnRvV21lL3BNSWZtdVQyYUsrb0lIbEthOWpNd2hyYzYzSG1heDJ5eGpzeEJJ?=
 =?utf-8?B?bmdOZlZzaXJnU0ZXM3NFUnlDNWlDaElhZlFZYlhTSW5vZHUrOVdmNDllZEhl?=
 =?utf-8?B?VUw1djhLZDhBT0k5aC9WVlo5dnZVNFBjQWV0MmFEKzM0Y3ZpY25KcG9nU2N2?=
 =?utf-8?B?WHVJTnNMOWp2MWNiMzNFNXhWb2ZvMzU0ZzIwcmgvMUhxUXlseElyUitDazZz?=
 =?utf-8?B?ck9DeTludStic1h0RVR6OW1CUDIyNWx3M2xDZ0Y4aDBCS2xydXFmMmo3QWZP?=
 =?utf-8?B?dWxXR2NjM2tDL1A3Uy9keHNyWjcrbldhRGkwbm11WHBXNDBicUl3b2NNTkgw?=
 =?utf-8?B?K0d0c0tCTzFURmVNN0VCTFEzU0pka0lrdjBRNXppaXQzRTZybGlZN1B2c252?=
 =?utf-8?B?RUFjSVlPMTg3c2NjR1paWFZ0Ny9MTys3Rno1MDRoYjNYNmFKWDVkTnd3K1NJ?=
 =?utf-8?B?MzZ2amkrTEtjajhWTy9oY2x3bjRaUjJTRG93VkZSMkcvM0M3M2lxNitPb2hK?=
 =?utf-8?B?ZWVabWJWdjN4amI2aG9IemxyeEMrNTVrZjlJVlFaNnc5SFpvZkRlM3Y0NHBv?=
 =?utf-8?B?alprWTZxZG9iUzU5dGl1ejVEM1YzWmVZS29KanlNMVVtZm94T29XdzNRbmZF?=
 =?utf-8?B?R0t4NmVrR2ZsQmdTQmhuOHQrWGt0QUtnRW50ZXUrdjRlTThwUU5iejh0Z0FI?=
 =?utf-8?B?Z202R3oxb2M4RjZLSmNJcWFkZmtCK1JRcWhlNGFFb3Q0ZzJVTzBxc21rcU1E?=
 =?utf-8?B?c0JBanNiL21VZUswT2NxTUlGcWNkQUp2QnYySitUYkxqTjV2cnJSUklDUEYr?=
 =?utf-8?B?ZUtkRGVaOXFiREJDanl6SnhGODVnR2cyR3hQbmt1V1lPN1EzRnpZZGptM3N4?=
 =?utf-8?B?eEtLSUg4emMwQkZKZzI5bndwL091ZllGc1p1U1BrV29mL1dOYTIzYVl0Qjk2?=
 =?utf-8?B?dFduRmNIczcxNGZmczdYNjhYTVZxOGphOW5lNEJRVnNLK1d1N2tpc0tYRkIr?=
 =?utf-8?B?aXU3OGduN1dVZW5NcmVycVlzNXhSMURybCtkeStGT29pNnhweE4wcndOMXFD?=
 =?utf-8?B?QTdnczVvYzM4OFhyUlZ5Uy9ySXBRdDJHR2ZKZjU3S1lHcVRIWUVLVFJyN2RI?=
 =?utf-8?B?NVpSVCsyRHMyOXRiS1N2dFNVMW56dkg4RGxYOVlqQVY1MnM2cW9hbU84d1Iy?=
 =?utf-8?B?UlVwOFgxdGdYd20rZnBSUGV6QmZVY1Nwekd0elNEUjBQVGJwbWZaOSsyZnJD?=
 =?utf-8?B?ZDlWSGJlOEI2UkUwNmJVaFppeWtOdlhKLzNHK1R4aCtrSlRpQTdSOC8wWmVy?=
 =?utf-8?B?WGNkaktaWUIwQnRaTHM2czdKQkt4LzdkY1Q3WkJiZk9aQkcxR3AybmFYVGJ0?=
 =?utf-8?B?UFBqOHpMZHcrOTZRV0J6TkorWkhCNDFYMUlBcDV6RC80dU81cjVnRVRpRS9U?=
 =?utf-8?B?ZHhXb2Z4akd3bThXa0o0TDYrL0xLVjNkZUhHbUZ2Vy9MQjhwUEx3cStjTVV2?=
 =?utf-8?B?S3N0VVlMZTR1ZUxLM1JIR1hKNmxVbERIUUZFQ3RVVVV3UDhldkw2aDFwU1pW?=
 =?utf-8?B?cVF1T21IYytwNFloZ3duMTcyWE1uMkRSMzc0UnJTcmdmSnF1azRSaGJEMitC?=
 =?utf-8?B?bE9pSWt5T05uUnhBN2x0RzN1cEE3ZHhYQlB3bUtlRzJiUWJQaUZmOVVCQzFZ?=
 =?utf-8?B?aUEyZUw0V0xTeXExQWNjMHBuNHZNV1djN3JFVUJHMzA1OWdrS0xXZ2c2QnJM?=
 =?utf-8?Q?81zI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c216cb2-bbc7-44c9-d12c-08d9f16501a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:57:17.2418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyUpaspvTNqAna9OTfgapzPH63mToFzTX0cxQllDQAjSJyLCyYiWnyruonaTaJFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
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
Cc: Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-02-15 16:44, Alex Deucher wrote:
> From: Prike Liang <Prike.Liang@amd.com>
> 
> Add 3.1.6 DCE IP and assign relevant sw DM function for the new DCE.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index babc0ab3208e..8fa3cf8dad48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1366,6 +1366,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 0, 1):
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 1, 3):
> +		case IP_VERSION(3, 1, 6):
>   			amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
>   		default:
