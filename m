Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E68CFB441
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08DE10E1CC;
	Mon,  7 Oct 2024 13:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WnlQ7omP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFF910E1CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 13:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOzF7DrNkyXlbbYWHnApy5MwODYzXZwCyT8sTKEKNdEWipdD1eeWhE+LWeWoRJIXPCUcNvTj+QUeLiYYAe6SA9amm5KfUWj0CVwgIU2OLfbjEvM78smgJfGCQ2CkJNRHHJI0LN4Dl/5j65S6ccM+//XdEarLTLA3W2WjUb8liPvL7PEEaeBsGksIZ2cBVkSWQTrNIT5BnFKiDqFuQV7TCwbVjFC+15Yck9ulVsYNecuBCUnULP2cIh7SxZF2Zxx07rllofqHk8tPFaN5g7GsBKttRd4ZiTixMBLYs4gcoSkwLXVEDaiIz8MZyU/rVdga2KIIeuC0hlM4IHUmGL6utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIG4fyDqf51QQa8GhK7UVRC5Si2CooJwcE6LvPGaF8s=;
 b=VRxjT0G0UelvRH6NpbKfvDCY6cuQHxuyALbcJba2YGv8ukMxr96yDAioV22Pscyz8Prz6xwgXTsmpRvNqx095vR71VHFWwIbs+qpdKJRPdmSTn041JvqueGU67L7g0hET5Sos6sns254X/tK8yu7cGj4urdpbTScu7KOAU12EFGZxDBd6Wld8O9NmzeXBiiDOCuuJj6XfGufu4AoxhLZ7tXqf0tp/vX3GyJVyT3m3p7hEube+uAY14axEd+ycAJYOwizqKT4TsKfyj9fiGTsDVn4wEzhBhsUC90oOD5EmQTdP308JQFemr6bZ0rtAaURof48yG8RQyoAkdHuOL10+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIG4fyDqf51QQa8GhK7UVRC5Si2CooJwcE6LvPGaF8s=;
 b=WnlQ7omP/S9Lj5BD0N84o2RC8Z56hzp5reHNq/UhlVmiIdBIHpShdd4sWlL8b9dsHhC5/rCuVKRj6UHeMzOkWWdVOsxoI3DD9YuO+NpwzPlzlQcIDPuEWNCdeFO8dIuSs5y5p+0F5qkLRPn8dznGaB+DgyrlH3Mwa449q7gaS2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:48:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:48:31 +0000
Message-ID: <93bae257-6288-4ac2-8b3a-2d2163c5babd@amd.com>
Date: Mon, 7 Oct 2024 15:48:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: move error log from ring write to
 commit
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241003082853.236479-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241003082853.236479-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: b056d70b-cb5c-43ff-ddc8-08dce6d6bb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3FEUm8weEVDR2tyU0IyVVl2KzdlL2VJZ0xDeXhWZG12WGpVSTE1bk5HQ3Fi?=
 =?utf-8?B?cnpwRzBzbjVTYW5OSzN2RmNOZ0REZzYySGJ0SFVZR3JQcWRYcXJXalE0N0JW?=
 =?utf-8?B?SzNoUU9qR1NaaE0vV2RzWGdGYjdGNUVac1JEcDMvakU3elBaSDcxOUNCWEEw?=
 =?utf-8?B?ZzBFVTkwM1gxR1JmU3JiNXNnVnh4OGZvQWxINGFBeEF2cWhvR2hMSGdDWHBL?=
 =?utf-8?B?UmJHd1R6RS81MS84UjRIa2l2ZUNlRUpFb2RueTM4VDI0RmVyWmpvdWM5QmIw?=
 =?utf-8?B?ZG5LWTFXbDVWSERtNkI4YXVacGRKS29MTCtGZDNuRnExTlltOXRHUnoyRWY2?=
 =?utf-8?B?VkcyQXArbTVmQ3Vma2RyTXZING16c2tObzB3YjZqV0N6M09nUzMwTGZJQlIr?=
 =?utf-8?B?NDh4d2Z2T0NOaDViTE9mVDlNbzgyU0puaTNqSUZxZ0xkaCtiM1JiUEQ4V0R3?=
 =?utf-8?B?RVg4b3VSYkFCZmJKOEF2TkFwVnovTFBkaGN4L2ExNDlkQ1NhOFA0cCtMN1Rs?=
 =?utf-8?B?Ti9pN0FJNk1HdloyLytXWnhWamhtc25DdTVzc09wVHN4L2NwVWV4ZDBlakpC?=
 =?utf-8?B?dkg5ZHhHa0VGc2lYN1hLdzFNcnhSTjZHYnJDQ2N3TTBOQjFLWFFNVHFsUVVW?=
 =?utf-8?B?eFpDYnQrY0paQzNxdERiVUVTNjBSZVBxdHlneW1pOGcrZUgxUWxxSWgzdmxi?=
 =?utf-8?B?S25LQmxLWWtMMVh5RzhhbFFCeFhWTk9XVDlMUVFOSDBkZlNYaWpmL0ZtWnBr?=
 =?utf-8?B?d2ZKRDl6Y2FVd1hjU29mWEhBMU1ldUlxZnRlVVV4VTQ2YWZEZ1Mva2kxTVlL?=
 =?utf-8?B?RE5POVArMmVvQW04Zm9RRVAxU0tLMG12TXNMckdzQ2VIZzJjSHRuL2JaZmFU?=
 =?utf-8?B?Y3ZzQ21FQnV2Q09RQTQ5VW9HSjVUaWdROUllN3o0enRxQVhlN0dna0xMc1BU?=
 =?utf-8?B?QTVvNEtnZHN3ZlByUWI2S0JtR0dVWUMyME9kTVdlbWlvZDRVelV5ckNLYnNq?=
 =?utf-8?B?bENmT3QwNkY4VU5WLzFQY2NQS3JUNUJ3MkU1WmwrMGlIbW5KcnBBU3pqemlO?=
 =?utf-8?B?MnhwN0xEYUVNQXk2NU9VQkVLOXpJcEJYYlJrMGZvMkdPVGIrU3JZY292bmFs?=
 =?utf-8?B?SkxFYUt1Uis5UmpXYUFna2pFTGd4U2xMMGlZcFVjQjZDTG9La2xyNXRJS3lP?=
 =?utf-8?B?SnVPOERkZU5RdUlDZ0xLZnc4RysxZ2JJaGdtM0xjNG1HMWJwYm40bHJNcXpM?=
 =?utf-8?B?Uzd4Y1JWS21tUTl1M1BsZVFOM0RBcFpaUmRvdTZKSWY3bFRRZWpNaWcvd0Nz?=
 =?utf-8?B?NERkWUJ5SmZ2b3dlNkY2VzJ2Ums5amNhYUdQV0h4ZUlQdjVoU3YwVGVVWnd0?=
 =?utf-8?B?SjVQSlFyVDIreEtlRWw1cmRuN1d5Yytmb0FFNUZWRlo5akp5WnljTFlPUHBX?=
 =?utf-8?B?YjhkNmZtVWE4VEp3b3VmaEFNOHpKNWZNNDhPem1Nd3B5VEhMcVhnK3IzR1B5?=
 =?utf-8?B?MHRSeGFpTWVoRXlaVWZPTGhucmF2MHB4d0hiRFhoSmF6MkluTXFGMmxuZlZ6?=
 =?utf-8?B?Sm5CeG9DWWNPaUpQT0FEcFgwWmVDUlo3NDVra3pLbUJmSG44aTRJMEhSUGo4?=
 =?utf-8?B?ZndVdWNTeWxnVFZrczBVdUZDVjI4aXVPMGpHamd0RWhhcEFNQkJBYXNSZlFv?=
 =?utf-8?B?ZGVPb3kxbFF3RXFQQ252Q0ZTK1R3NUx5ZDliSkVhSWJpeGUyN2k3TlF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdidHRUblpoY0N6NGhlY3g3WXIvTnRvSU9DQVR4Q2tSOHl1L2N4LysxUGJu?=
 =?utf-8?B?OWJsZmRjaW5iUnRFTDNUK25jbFJqYko5Z3d0eFFxRklZeCtNSzRBQjBCcHlu?=
 =?utf-8?B?bmRkRmpMbXhMNEdxS3MwVTNqSzZsMVBuSU9VUSsvUnUrVnFnMHRZd01scU9Q?=
 =?utf-8?B?QXdKWVdWYStQTVc5Skl2NmFFY2lJVzFaNUJITHdIYTVoc00wbGVEWEIzU2V2?=
 =?utf-8?B?VFlVeWsrZ2I2N0E5Z3dHUFRjMXg3R2RyZTJ4MktrcEZTS1NzODgrQkZSSjJq?=
 =?utf-8?B?cnhNbXBXaUJFMWo0dGo0K3p4bExJZVRMMFJtNTRyWktlY3JaaUprZm9zSUE3?=
 =?utf-8?B?elAxZmhKNUJOU2xxOTNST3hwaUJaQ3NrYmcyZk1mM0pyUzJRSHo1aHg3Q1pl?=
 =?utf-8?B?SFFLVmc2OGJiZzl5TFVSU2x2cWJJRTZnOEU4ZFZ0bTU2RHBFZWd2eWxNTHVU?=
 =?utf-8?B?TmRMbERJOEN6TGR0WDM2azRkUElTaTdtY3BsbVlvNUk5QnNLYjcvS2Z0WnFY?=
 =?utf-8?B?dllraUl5bVFWUU13KzVuNmpGTEJPV1lTTTdReVZ6a2RoMzh5V01LMmo3WUl6?=
 =?utf-8?B?ZVdaUnkxUHZUOTY0SGJZL0lyN1pKZm1VU0k2bnplK0czUmFRZUZRby9oei93?=
 =?utf-8?B?TU1yUFh0aS85Mm1ES09jelUxYVlEWUhXQ2ZQWU1JWmw1R1J5d2F5VjRPVGk4?=
 =?utf-8?B?aGgvcEpaUmd5N3dvSnZSdGZDdHdQNXZET3luVE94Zng2LzhYMk55T3FOZk82?=
 =?utf-8?B?NmhTM1g5aXE5eFFRaVVWSGRSNDdEcGU4Y21mclFJalRHakRwUzdBdTZPalRE?=
 =?utf-8?B?eVJVWmh3eDJ2aEJXQ2l0VlJOSnBHVjlRd3NLcVEwS3JnN2R0UXVxcm50dHl6?=
 =?utf-8?B?K1ExMUMvemZHWFo4SUJOY2IvRmc2ajBoTDNveGpOUjNaWnEraXBzVlQzV0lu?=
 =?utf-8?B?dGdEbHI0VFVMSkJ6aXNRVHZXWG9Ta0F5N2Vmb2xWRkdIT3pOZmZXY0ROcytG?=
 =?utf-8?B?TTBQMlZIMkZ2V2htU1ZONkhaTmV0T1dFeUlWWXhaR0ljMVg4aVBIeTV1S2NW?=
 =?utf-8?B?VDZmdjlCNzlEWU55ODEzc1FwdUZGdTNPSmYwYk9Fc2JrRENqcjlXd1NqK2dU?=
 =?utf-8?B?cDRoQXFpV3lIdXJUVEVtSjlOR0xOdkJ4Q0pOSWlzVjJ1dGRjdXdRVHgzK3cx?=
 =?utf-8?B?ZE44SUNHZUxsVjZWRkFOMHRHdDVqQzN5RDhUbnNySkJWRFpPcThKbURvdEtx?=
 =?utf-8?B?eXNrYWo0Q3JCaXlkK2w1elgzMkpuOXFSK25Sd3RvVmVGUG1ES29haTZzOXd1?=
 =?utf-8?B?bmZ1aEVEOXU0OWdjZVgraXFsUjdpTDB4QlJSMC9lRGc3dE1VWGRzZVJ5MnN5?=
 =?utf-8?B?dGUyUDNCajdaeHhKNGNOMDVuNVVBOTd3cmh4eUFHK0orS2RxbmQ3dHgzYXBC?=
 =?utf-8?B?OTdraVdnTlJFczdxK3VGUWtDZ3l2N3p4QW5RSm55M1ZxUExaUmlHOWhhQzFW?=
 =?utf-8?B?azJXRlNQNTlLNksvNUN3d1lvakZNQmJtMjA3UDRlRWtEM3ZHYm5WT21vQmkr?=
 =?utf-8?B?ZGZLWUMwbVJNZ3JDMEQrZndZeVF1SU1UUW4vMTZnZkViU2VQcHM1TDZoQ0h1?=
 =?utf-8?B?Q2QybEVPZG5nNjJqcGExOUdYOUQ2UHVvWlYza0plN3RVd1Nnaitvc3F0MXJR?=
 =?utf-8?B?SlpHV3F4QXFjNitKNUtUSndZb3VFQUNsMCs0VUZFc2I0d0d0NzNKTWZKT1ZY?=
 =?utf-8?B?bnZYZzh3RmtEdTIxTHZYbTVGdUsvQy9SR045OHp5eHhtNkFNK1I0aHYyZmd4?=
 =?utf-8?B?elR5a3ZOUUpoRXRmTXFwNUFQMmE5aDArWEVNaFh6ekVRK09zNjJHMjdkMm1Y?=
 =?utf-8?B?a3ZPOE9sZ05ubTB4WThGU2ZLMmFOanRUMmJWbnZLK0VBSElqa25LS2FmSW5n?=
 =?utf-8?B?TmpGVmwrMlh0ZStEbXU3V3J1a09IZWI0WW5EcWxvNy9LRm9KdmZGK0tPMGY3?=
 =?utf-8?B?ZFNvanRrclJWS2JMNGtRcTgxVHJubFV2ZTQ1NGVyaGNYbEZ1NVhUMnI5N2VD?=
 =?utf-8?B?Ky9tM3pWT2pHbXpqNG85ZzZDdS93U3hSMnRhMnhVOVJWbmxxUURnOGdyU0I5?=
 =?utf-8?Q?jBJYtbFE86cCJdN4+wN7yIb7q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b056d70b-cb5c-43ff-ddc8-08dce6d6bb0d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:48:31.6933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9drpIh52i56PipzQpeW4z+GHtIsPSt3jHNoXXCXzzr5ykhIGycsTgUH0JVP6CxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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

Am 03.10.24 um 10:28 schrieb Sunil Khatri:
> Move the error message from ring write as an optimization
> to avoid printing that message on every write instead
> print once during commit if it exceeds write the allocated
> size i.e ring->count_dw.
>
> Also we do not want to log the error message in between a
> ring write and complete the write as its mostly not harmful
> as it will overwrite stale data only as GPU read from ring
> is faster than CPU write to ring.
>
> This reduces the size of amdgpu.ko module by around
> 600 Kb as write is very often used function and hence
> the print.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 690976665cf6..05b3480ecec7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -141,6 +141,9 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   {
>   	uint32_t count;
>   
> +	if (ring->count_dw <= 0)
> +		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
> +

Oh, I missed this on the first review a count_dw of 0 is actually ok 
since that means we have written exactly as much dw as estimated.

Regards,
Christian.

>   	/* We pad to match fetch size */
>   	count = ring->funcs->align_mask + 1 -
>   		(ring->wptr & ring->funcs->align_mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index f93f51002201..af8824e8da49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -377,8 +377,6 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>   
>   static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
>   {
> -	if (ring->count_dw <= 0)
> -		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
>   	ring->ring[ring->wptr++ & ring->buf_mask] = v;
>   	ring->wptr &= ring->ptr_mask;
>   	ring->count_dw--;

