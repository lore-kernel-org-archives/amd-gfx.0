Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77998C7EE30
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 12:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CD310E70F;
	Wed, 25 Jun 2025 12:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJ/wgOCt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F83810E70F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 12:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Famb0b7yDQ+cd7aNh/cVctCORqrIvMQcsvm1zL6Tuji7VG2WwNwSzbfojuCgv5ELk0Hv69jjYrlREoT8d/QRyJ/xY1wys+EW02Nq06lwQwnPQWkshbk3+aOkSiTpqIOe0w8kgit1GbQDriDwcjtR02GM5AiIoD/YoSgs1tyj72mzkOjJfZWOswqfXR069Y/oDy5jS/oLGCLQ61ZhKE4aA78Y1+Ah5N7wKLmptpyi2B3tO7d/7L9fli8G03KHKThyKPxp1V93mOB3OPdurA4tHq1Qxqv7bn8NqXPJCPR+iRKX0Ipb3LQHkDvHFype5VuodzTWfVHMIKsfiM8goEogIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37OeBT4AI+jzgb9uIqnAZhXoVye0+Jx+Qcphjys74lE=;
 b=FXXzyP83zgKSYm1YnC0+kVlHpphW3CziHTSKNxEYSKu7KAxw0L1s0Pd0MiMaspAI1c9PYfCUMHYoB70cG/mmQ+AC3GX8Sq8iSvpZiTpCo8/76G/PUKlaWdaqmIeFFprdz28aIjH0OxMu4P2XCrHEIUuvaZxdg5NVm1x+SWqjVz1Rnw6SqB57JPeqd+Dckga6w+Lt8T5kp4k0dqGUO4FpsWAC0EOnTgR5nTiRPoY4hpdNHGFl+mhkynP3eSOXMlPwMsusrt0J9aQdLrjOeBytgpV3KDIJZnNKTGFBxawyOxnK5n9uyG+FresBilungvBJUiZOfs4v3JxDflHtbvZD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37OeBT4AI+jzgb9uIqnAZhXoVye0+Jx+Qcphjys74lE=;
 b=sJ/wgOCtmoH8RwDkKgk30Pv5F7BOpI97uwe/4lKi4UFf27cBrtETiOt1KIY7vvA+sHpAyfOl0CyHPYjcfP42yVNNv+U/PN+rJYFsoCtUsIXerI/OXxORDzWYihc+Vx7PkwUrl+EWCCcuuISpN9oCiU/hfNUpwLTB93tKVGY5GEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.38; Wed, 25 Jun 2025 12:47:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:47:52 +0000
Message-ID: <79a51c50-6f6b-4638-a14c-ffd94e02517e@amd.com>
Date: Wed, 25 Jun 2025 14:47:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: rework gmc_v9_0_get_coherence_flags
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, rajneesh.bhardwaj@amd.com,
 felix.kuehling@amd.com, david.francis@amd.com
References: <20250606125723.7822-1-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20250606125723.7822-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf393f3-4156-42a1-675f-08ddb3e67faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjFjelNQSFFDOUI5YktLTnBIdDNRMHdNMGNVTllyVDVkKzA4SzUwMVQrY2x0?=
 =?utf-8?B?OHhQU2xvdTJSWk9xYnhtWEtyTWZldjl0S3NLN2wzbmEweWpJWmM1ZENuSVhQ?=
 =?utf-8?B?M05JUkY0MC9ZMUV5emN3bWRZQUdFcENobC9ZaytwVU1pL3ZYYmpNVEJpMXdE?=
 =?utf-8?B?S2NEaGF2WThZVmxsWXJGQVp3UW5mbVVmUVZWMlFqNG9tMHJMYUJib09mZ3kr?=
 =?utf-8?B?NDMxa3I2TG9yZndNc0xmVWtkbWdSZDdTc1FxbzZyckFpenkyNHd6SjQrYnJP?=
 =?utf-8?B?VTk4eHRHV2h1MGpyU2ZOWTBONEY2WUZBZndRZjdjeEd5aXEvWVoyRW1FajVS?=
 =?utf-8?B?WlUvbk5VNnIreTVHSFYyMUxmLzl5MGJFY1NHQnRsem1kWFFTdUVManJJWXpM?=
 =?utf-8?B?UEJBTFNORVVYYmxHSTArbUljWHErbUZucVAvR2N0RkpDdmJJMDM2Mm9JNEsv?=
 =?utf-8?B?bW5halhzTVYzSURETk9Ic0NiNGx1Z2VESUxjU3puVjkwQXRoK09jZURVM0ww?=
 =?utf-8?B?MjQxVjdZTTNRQTByZEthQnJLeU55TWx5TDdwNm1obTE3VWVSaFAwRGlDSXZi?=
 =?utf-8?B?bU1HVFNqcHA2TzloNUQyeStldExpMCtWRmE2YlFGZ1pOZmVjaFJXbzFtYU96?=
 =?utf-8?B?Z1JxWkQ0VmEvQWZIWHRNcXVDdHJVUkljY1QwL1RvVGZObWtWMVRoVFkxcGFB?=
 =?utf-8?B?VWR0SXZPYWRENkdBNjk5eG8xT1RDWWxvdWFHNjduYmlaN2JEVERpOXdmZmpH?=
 =?utf-8?B?QXpTL0VRb2pybWM4d1ZZckQ4RXZsazZLSkNvN3hRVUFIWlhZQXovSzdFekQv?=
 =?utf-8?B?OXIwdy94MG4vOWVBVW1wTWNlNDMwK0lNcHQ1Q1BVaVg3MHZQeXRIZm9UUy8r?=
 =?utf-8?B?RE5lb1UyYklmMDZ6R3l4U2o3U29keXNxZm5sdnB1ZU9xYjY0ZkV3YVkvTkJG?=
 =?utf-8?B?dTVlRTlhN0JIM284dlFDckFMSXpubENVUVVETzdaNXIxMUwzMi9yZ3VIV2lE?=
 =?utf-8?B?c2h4aGRBOWViOUIwclc5eklsR2ZaNitJaWk1NWMyT051OUtmVi9rMXRWbFNU?=
 =?utf-8?B?dFpWVHlOTUt2UHNJQTVocHhoR2RzaFlQUW9DSndlWHA1eTFlRXp2aG5tVWoz?=
 =?utf-8?B?c2Z4YVFPU0ZYdVE0NTdSWnJUZkVWdXJaUnhLeDE3Vm1TQnhBcVkrdWFSZkRq?=
 =?utf-8?B?QW8vVHluRkZJa0lVZTdzb2MrNEZoVHJYL2MyUmgwRDIyKzlJd1haOFoyWFlz?=
 =?utf-8?B?WmtFTFFSQ083UWFuVC8rVXdCLzhpbTlxTnNhRlZhbEMwaENKZXZDQzJQWXVO?=
 =?utf-8?B?cXlBdnRMdFUybVNWdW05WVRzOGFUYUc3Rk1SRmkwQkxOM3hIdWVreE0zZElM?=
 =?utf-8?B?a0FodnJld2tMbnkrWndRUjZzUXZrL3JBdjdjZjZyVnFEMGwrWmdOTGx4Rkhj?=
 =?utf-8?B?dmdIQzRSVkRiS05QK242MG9HZnhnc01sWkdwb3orUWhnVk9rdzN2WFNteENL?=
 =?utf-8?B?ZjlwbjA2c2hLWWRwV3FnVVFmU1VDb2JpOERTWlBZakt4NGxVNVN6NjdXMUJL?=
 =?utf-8?B?MmMyaDJyRDU5cGRqK2w0N2pIcVkzN1lEQlMrWnkwcEFCVzYrYlovNEtzWExn?=
 =?utf-8?B?blNCcit4OHNYUXNjMmt4bmRlVXVkRHI0c3l2dDdvTHNod2RPUzhQZXRBWGlF?=
 =?utf-8?B?bUxQMGxwVzcxUWt1OWh6aFh3dXhwa3NqRlhmdkVIa3B6VHorL21SU0trb2Js?=
 =?utf-8?B?RkR2MkRzRkZJT2MrNkZ5VUpTem4vNE55NC9jYkZSa2lQZ2lRSm1nVDRjczNI?=
 =?utf-8?B?cjUxWnIvZGJMTFVFNENabUcxRENocUw1OXI2YW56M3lFUTFEVnlhdm9mVHhZ?=
 =?utf-8?B?Rm1CYjVYa2RwZlNpM3ZibjZJczdaNmFkVXFsNTNmOFZzcnIrWlV0OEp3MUJh?=
 =?utf-8?Q?Phe3iGdik0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytiK0w0SDFwWlZ6ZkoxQW1teVRBa3hkT29FSFhKWUkrVnBIRXl4WTRuMVlU?=
 =?utf-8?B?TGNJcXNWYU9wS1lMSmt5SVJCRkltWjNWQmtIWERQYktZK0ZkejVZRjlpOFhW?=
 =?utf-8?B?Y3YxRmJmSFhyQXpaSW9NeTl2YWg1cHhoSGRONTRCam81RVlJSkdmUWQ1dDNV?=
 =?utf-8?B?YldiVlJUQW41MXdjQXJTOW8vSk5lSVhrNk82ZVRvUEVYdHlwR05icjBMc1Jj?=
 =?utf-8?B?R0dEU1g1cC9YcWVXTjVQeDdJQlFxMGFkMWYyQkluRy9kV2lGOHZzNWprNTl5?=
 =?utf-8?B?R0FwdXd3dG9WTXFhdlZvbWFJVXhoci9sbXJ1N2hvUGVlalF6eEJOZVppS0xx?=
 =?utf-8?B?SjhzZVVtL2djeGsxcGlodEVlbkw2ZEs2R2dCTE0weUJKb004UTE2ZkEwL1k1?=
 =?utf-8?B?NE9xUWU0b2Q4RmpKTS9nM3ZxMmgxUEFKblZqVlZLQVM1RmlZb215RlQ1c2Fa?=
 =?utf-8?B?Q3BNTGdQTGZiT3hPWUlmWXpmbG9uZ1MyNGcyUGxjTU9BRkYrYjhiL1gyc1FG?=
 =?utf-8?B?TWd6d09FOFFwR1NRSG1GTUwrRWVsUzI1eUR0c0tXSGZMTlJpN2ZQdnpjS3VR?=
 =?utf-8?B?WjZ0alZPbzhFU0JycTgxUDBldEVqdTErbkZ5TTRpQkxxcnQ0aVhTZ2ZTYVBH?=
 =?utf-8?B?WmRZWmxlSmFXTXlYZ2YvbVZmOEVIVUlYd1FyNGZOU3lJOHVPbkRmekJ4ZjZq?=
 =?utf-8?B?eURkc2c1SFJGZ0ZpRVk1Z3M0d0RMWmdtQzVxV3JiZ1ppUnFDOGxmU3VHZ1V4?=
 =?utf-8?B?UmNQSnZQU0VYVUxnUHovNFNOYXBqRTZSWFBNVVFxbHM4aWxnZVJiUndDQnhR?=
 =?utf-8?B?UEZBcEZkSXBPYjg5dkMxQ3pzdjErMW5rK0NtM0FqVnUzUlNpS004dlNJdHI2?=
 =?utf-8?B?U2xPNTJtdjA5VjI1T24ya1NkbEV5V2pJdUc0OTRyVDB6Rmt6NEJja3hzd2l5?=
 =?utf-8?B?ell3Ym1MaWppMzQ0SHdmVkoyT1pTYzRmdnhYamMxU3JtdnlTNWR4QTVlK1FL?=
 =?utf-8?B?am5rS0pHV3czdGhqU3ZHTUtFMGtTQmxUUzNuSERBNU40U05jUUdjTEhLTjYv?=
 =?utf-8?B?WjJYOVNlT1hWNmw4WEM5NnhqMGNvMTBxRTFOYmJNcld3bmNsZGk0MUNNYmxF?=
 =?utf-8?B?MWV4eEYzWWdlM2dia0RxcmVsc29JOGM4S2t0UXVpM2U1byt1bkRveldKU0oy?=
 =?utf-8?B?MFBUWWoxOUdSd1BzY2wxMTFPL2orUllsL2FlM1lrb2F6RFFkSC9yNGtnaUZD?=
 =?utf-8?B?R3ZnMW5oNHoxSm1rc0YxQ21vQk9VbGE5YUtzY2EvN25xeUdIbnY5RnBnU3pK?=
 =?utf-8?B?bWpCa0FMMHJGRVhFTlRjT2JIUXJEcHV6bi9mN3dyQSszckZvbHY0VUpYQ3FM?=
 =?utf-8?B?aUEyeVViQVgzRTFWNWJHYnlDRmtVN05lQVNsclk2SWI5YytySXozUXhYZXBL?=
 =?utf-8?B?dVVJSjRoU29iVDM2cGp4S05ES1JuS3ZHQU5CNTFxSFpnZCsvSk0xY0VydFlG?=
 =?utf-8?B?ZUVlejJVZVFqbFljM09VOHhZQmRoK0EzSVpXUG8vcllMWmw5K3VVdUp0VVRj?=
 =?utf-8?B?NEV0c29WUVp3ZHQ5bTExMEVraHlJaWxOeG5yN0psUEZEcmlaQzdqMytxVk5E?=
 =?utf-8?B?MjZFS25md3oxYmRiY3ZwRWRaNHM2bzFPeVNzcjFpelNpYm5OTk44OHhib3d0?=
 =?utf-8?B?aUJ1aEJYWUw2dUNTRGNlWHc1MWExWUl4eFlJVzhYWGp3Uk02VTVhc2xXZXVE?=
 =?utf-8?B?Zk9DZFFNcEozc3J5R0wyRnJpbmRHakwveG9FdDdPblYxUmU5V2ZpNHRic1Zu?=
 =?utf-8?B?allYOFZFWVJlWUtiRkEzOUZDQ1VOTmZLWVhvKzlwQnFSejBkSVRNTHpDbmVt?=
 =?utf-8?B?MkQvVEExa1JDT3BDZEZyU0o5MzdHVGM0RWR0akVuckxBd3pRRU5ObWZtajRx?=
 =?utf-8?B?M212VnplQnJGengyZ3ltYkFvNDZXZmlmVm5XanV4cTY3Y0lEZ3kyUndoYTMr?=
 =?utf-8?B?VmxaVy9SQWlKTEZGMjAyREdTek9veWhjcGxrN3dNWW83bW5VOUtXY0loNUpC?=
 =?utf-8?B?TzFmeG5WVE9hSjAyK1RGN2xtVTZXWjlUT0xZdlppNFBlRlhSOWRxelR0Y0JD?=
 =?utf-8?Q?HUYgJfVkfDdq9H22Z+fgX04i9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf393f3-4156-42a1-675f-08ddb3e67faf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:47:52.6626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUNix/f1y/JfO5u9AptSctwvLSKIPCJ7DSsIfo+2d3IZPPe6L6N9vGa6uikovcoE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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

Primarily @Felix gentle ping. This is a prerequisite to Davids work.

Regards,
Christian.

On 06.06.25 14:57, Christian König wrote:
> Avoid using the mapping here.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e691cc61ef6e..cad014c3bbf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -30,6 +30,7 @@
>  #include "gmc_v9_0.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "amdgpu_gem.h"
> +#include "amdgpu_dma_buf.h"
>  
>  #include "gc/gc_9_0_sh_mask.h"
>  #include "dce/dce_12_0_offset.h"
> @@ -1131,8 +1132,8 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>  }
>  
>  static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
> +					 struct amdgpu_vm *vm,
>  					 struct amdgpu_bo *bo,
> -					 struct amdgpu_bo_va_mapping *mapping,
>  					 uint64_t *flags)
>  {
>  	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -1142,7 +1143,6 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>  				     AMDGPU_GEM_CREATE_EXT_COHERENT);
>  	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
>  	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
> -	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
>  	unsigned int mtype_local, mtype;
>  	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>  	bool snoop = false;
> @@ -1172,7 +1172,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>  					mtype = MTYPE_UC;
>  				else
>  					mtype = MTYPE_NC;
> -				if (mapping->bo_va->is_xgmi)
> +				if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo))
>  					snoop = true;
>  			}
>  		} else {
> @@ -1264,7 +1264,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>  	}
>  
>  	if ((*flags & AMDGPU_PTE_VALID) && bo)
> -		gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
> +		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
> +					     flags);
>  }
>  
>  static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,

