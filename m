Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882ECEDE99F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 15:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370C310E875;
	Tue, 10 Sep 2024 15:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5odjr5k/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413C310E86C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 15:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkiaWwRuiosgiRoefVaa3WIp3SqXPSIxKs/+z27LMRd5GnIBPbdxNmLJdBI54AHnDsmsJQNdn0fsCsrY8mkkO7Q2IdbtGFYsrjnFLmRzeh0ct41mWRiDOyckAgm91k/MBGOVK+cFlZ8xjsCAVKB0vk994qMnvRa5gXV0Qh3+PVfqZxg3r16LFs0iYgQz2Qu0SAOgq638vG0GYtjuZHeosDkzvmJ9hgrVbkVHjthhTQ0lKjLX1jNU9dLRTCU5IzCo0BLV8Me/BAMevKDy4cmUkuDDvJ/XWDM6YXvu3yI0rY2GnxJkFDJZl43SnIZWfaGtZ45YvNQB85bkQGAXDsmPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoIMJZfjFLa8P67g97wmxMflJ8WrDuWUNlOfOkS4i08=;
 b=mp7ViCXe0fY9vmrDfFErKnjaHaxvLmrFfkTFgexab/Q1fsMPCGah+ngnhvqTKsUpPExi4eSBoYkGoCqjs4BjjVN7CDNAzqxZfvfYHDR2sLBd38T4BGJoghSIYfKPP3oD/fCVkxP9XiqtWZogNvogWZelL+PIfmKyG2216ZExc5bRJJ0MN6kpubI5miHtrPcCcOUSUrjrqGXdaiN0cIT+QAWUDa4Jd/yhV4xkVWnWin5Bw0FMb7UoqFSj/QbDjSefvCzI0IFb4WjvOkMNaLTotJXMFXTR+YwmfeClyCjFbCksXzfZKezIYgdprjTlbYg6Mmtam8ddHOkGX46gq7UXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoIMJZfjFLa8P67g97wmxMflJ8WrDuWUNlOfOkS4i08=;
 b=5odjr5k/eFRI38SqOGtvLsANKvxQ3pIVXvVcsflOU7TeY7oUhSUgZgfADb/KpBoIn4ojUNayaSmNT6kcji2tGzpW1guQv4gRqhz3+uPMo8CPcF9S+mHIqatR/2d+/EH/JTZKVmeoFLEXxnbIOoEZFJ9/6A49YEWHhQNDUiU51jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 15:47:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 15:47:21 +0000
Message-ID: <59ffec90-f8c5-4759-8794-df03067a5128@amd.com>
Date: Tue, 10 Sep 2024 17:47:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: track bo memory stats at runtime
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240624140815.18085-1-Yunxiang.Li@amd.com>
 <20240624140815.18085-2-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240624140815.18085-2-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbe9149-d771-4294-66d3-08dcd1afdb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkVLRmtwTVdod0hkMjkvMzlTM1MvTXc5dUNvaU02ckVWTXJVcEdHeUZRRXBL?=
 =?utf-8?B?SHdvZjBoc1NBVXB0SDF2V0hRbDhNckt3UFZvZyt0YnB1Z0JrSjBYVWc3Y2Yx?=
 =?utf-8?B?eTN1Ny9MNDI4R0R1cDlaTE9EU1lJc3M5MzZ1L2l0dk1IZjMvYXJqMnVqeXBO?=
 =?utf-8?B?TjBVOTBURngzZE1ZMCtFeUgxbDZhWW5pWmpjYzhFb2NzRkJVeWZVdXEzRzlO?=
 =?utf-8?B?L0kyZUNya3J2UTVlYVQvMVJyYjFkK1IySTJpVXNCcDVwTVcvbUJ1clF0Tm1L?=
 =?utf-8?B?RmE4djhoUGQwTTd1c3lCUXEyYXlBTUNTTzI3RlJkZm9oODdYRkNSZHpTZkkr?=
 =?utf-8?B?V1dmWVZtNUsrcHQzVkJ3VTBhVGNQa0ZaWUZRVU5GazIwb0tEbVlybytpWlJN?=
 =?utf-8?B?MFZsUHZtSzN3b1pxK1dMeGpVV2dHR05lbmFRTHZ3WjNCZ0FjMUYzM3VlS2ZI?=
 =?utf-8?B?M0gyWWhsTXQyYy9LYm9BMlpUT2JIRDZ2TUVHNkJ3ZXQyTzR0RFJoV29hSUJr?=
 =?utf-8?B?eWI1RFFvUkNLSnJLb1NYY3dhQTRiMGhJSXdkcTdaL2p5MWZ5SnMyV2xnZEtl?=
 =?utf-8?B?Nk91WlcvSmVIdXJ1dHhKeDY0SHkwUldFamhXSUdaeFNtOVFaVGdsZE1ZUXNF?=
 =?utf-8?B?NkJSdHZaZWtKWlF4WjRkejNNNVlTQlUzMmdCSkRSMHhjL2ZValIvT2MzVjQ3?=
 =?utf-8?B?a00rRTBZeThOUzUrS2cxQ3oxTzFPTUNza2RQL0l4Y3gycVFPTkFPVi9ydzJk?=
 =?utf-8?B?WGFHUVVvTklpWGFPamxsK0RHS1o2NUVHWjViVXVzQ1JJTEZoZlF6ZTQwRkNa?=
 =?utf-8?B?M1NPajFGVEJGaHJod2J5UFl0QVc1L3R4cnQzWi8xbnlGN2M3MHBYQ1k4aDAx?=
 =?utf-8?B?b3lTRUtkVDBleDhGRzZZanZvOEVDbXJiR1Q4U2IwWVFrNEptTzhQTDVHcVd4?=
 =?utf-8?B?NkVRcm9pV3orVUVYRE1WWG04QTAvNnZqeEtqYVRMM3dJZWtueDJKby9UWllV?=
 =?utf-8?B?Szh4QmlPYUNkaXprR28wYjQveEpXMnBBMjJsNEI4bDd3RnlBRXJXUmYyZTFY?=
 =?utf-8?B?TWFtSVlPWndoYXVtNnYyMDEzZWYyY3l0ZHhJZG1vUEJ1cTVJODZmakpUaDY1?=
 =?utf-8?B?VHR2LytsWmJjWlFpMjg2ejFDYW1CR2lHbGxJNkZuSDZUdGowSXF6bmRvN243?=
 =?utf-8?B?eVNWaHZOenk4M01RenBQTmtOdWxCeE5MMnU2bXhyNWpkdlFaczJMNWQ4Rkx5?=
 =?utf-8?B?Zm1iWmNBc3Z4R0RnUW1tTGdzUUZlcHpncXZvNzY0RjRKK1BmZzEvTzZOV01L?=
 =?utf-8?B?QzZUS0xrUm5FVmJZZW9CM013emxzNDVMZ3hxbzBrc0FKR0JHeTJHUVlKdHZW?=
 =?utf-8?B?ZEFhcXFzS1N6cXJRMmtxcUV5MWVhS0xZZUc1bG9QWXpqRnRRODV0dmExeS9v?=
 =?utf-8?B?OHhMYkV1S2h6MHY0SmZGVDZJNnk3UDJkbDAwU3hucWdXYVZVYzFqanpydjZX?=
 =?utf-8?B?SEZHNUlwTUR2Yy9BK2ZBVWtLcTVaSDR5dFZpVFhpallJaTh0aWtPWC9jMlBj?=
 =?utf-8?B?Z3RiMGh3NE4xM0RQR2lhbmdPVktSczNnbU0vMTUzNGx4eGpqajJaSlAzaFl5?=
 =?utf-8?B?Ry9RT0IrL21odkJSZFkvWnNYdXd5c2YvbzJWUmc0VjZjWGc5eThjTVRtemoz?=
 =?utf-8?B?Y1ROSlFnYnVJQzFxS0t2N3BSeU1RS0N5SmhKZ0ZiZWhNN2xIelozQXg5V3Na?=
 =?utf-8?B?dzY5RlQzWXF4SGU2QWpqMlJPVmdYZElIRlh6NGtOdGtOaGRldDNNU0FXR1k2?=
 =?utf-8?B?cDA1aHJ3bm1ocG5NVWdYQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVQyMzVQYWpDSEZrbUx5dytCVmU4N2g5b1B0c2huQkVHZlNaR1lCQVVKakdw?=
 =?utf-8?B?aC9uaW4xRkU4b2pXWFpWaVB6RW1HdnFva2ZidlRFQ1RHNEhVSUtMR0ljd092?=
 =?utf-8?B?Qkx0aGJscnp1cVJzamNFSkk2dlA4QjZDTlBjcXZSYy9xM2NVL09KQXVvYjlB?=
 =?utf-8?B?b2krTUlkNTcvaXZOYTRTb0FEaWJRWUh1UHRnYmFiY3VOcnFVYStJM3FmeEFH?=
 =?utf-8?B?OEFzVHZPcjllYkFQNno5Y3l4MzNDd1lqeFlNWFdOa1dxQWpiRGszZUI5THR4?=
 =?utf-8?B?Rkh1RUZ5VXI4NUNLUDErc20xQ2VsUEI4N3dpMXZNN0wwSmdmcWpobi9SSDBF?=
 =?utf-8?B?Wm8rYjIxNGFydUJsVERwS1RWQ3FCdlBTZVVhRk9naVBobHhPSFdTWUFhaGNl?=
 =?utf-8?B?TkpWL250dHBQL0RlblYvRjAvSW1ITjZmSWlIcjViVmxML1lpUEdZdjVkQm1W?=
 =?utf-8?B?OEhpMm5hVy9rcGVMWTlocnFZQyswT3JJSm0zU0VkSXYrNlYzNnUza1VzYW1B?=
 =?utf-8?B?MjlrWjlqRmVPOG10NVV0TDRITE04d1phNmg2c1M4dnlUV1RmaVZleXg3RE1i?=
 =?utf-8?B?bmlHZHRGNVJsNk8rc0tYcGpyQ3dLWHQxaGtYQ1NGaFltZkdjT2J0Z3R2dG5o?=
 =?utf-8?B?N2xQZ09USm1VbnVESG1jNGZCY29BbDhrYnZnSnZxWG1zcEs4Zm8vRWlMSkVD?=
 =?utf-8?B?MDRTcmU2ZmNySk40c2t4Yno3bUlvcy91UzArL3N0SVROTGpxOHU5WVVMcGQ2?=
 =?utf-8?B?UVVCVjVJbnJ6aGQrWDVpNWNrdE9uLzBoWVFKM2MzbUdFdlVMUy81aVpXZC92?=
 =?utf-8?B?cGRSUCsxL3UvTWJBSVdnZUdYNWp2SVpmQlNsc05lWVRvOURvMmY0MkZmZmxl?=
 =?utf-8?B?NWJXOWYxRkM5YVhLNUw4ZElFdGxndHNhTEZldkJ3Q3J5U1MxcTlCMFM5Nnh6?=
 =?utf-8?B?a0MyREIvS0g3NE9SeFFWa05rV1l1emhRUjVMaGdhNFVGOEc2c25oOUN6R2Z0?=
 =?utf-8?B?QWxkdXdOMUdmamcvWVFRMkk4UFA3S0t6UVBCeWxzY3F5N2dOYWp3SU0rYW5I?=
 =?utf-8?B?Z0RDUEVkUHJlSDYybHJoSURYdmFMeFkzMk1SRjRMM0xWcE1FR3J5cmY3Y0NT?=
 =?utf-8?B?anphaFBOdWRYbGJQUGdXNmZNNks2MXZ0dXI2bTBHSll5OVpHRjNDbVVwTTVs?=
 =?utf-8?B?SzRyYng3d25CR2hra21JNFdwVlJtZHhGUE5KdGNNZzUvSUFnRk53Z2d5cTN4?=
 =?utf-8?B?VmpKTUlLbEFjVllpMHorbHNYTlJxTzF3MTdyWllGOEMzWWdicmZhUG9ta1dH?=
 =?utf-8?B?OWd2K29yTVI4ZHQwb3Nra2xLemVITDQ5U1RTa1NNQWpkTitncWtyVklQejVq?=
 =?utf-8?B?c2dGSmhpVkUrTEpZS2NkcWJ3dDduVXg3bkp1VWozYkJyVWI2VUtZckhCa2RW?=
 =?utf-8?B?RUh3WnNaeWptQ0w4dWtMNkdxaERsbnhhbHdIazhmUTBxTHBKbTE3YjgxaVhB?=
 =?utf-8?B?dnRNWlAzQnpFNXZrUVZKNWI4Tnh6VVlQS1NMRkE4a0s3T2tXRys0L25YcXhw?=
 =?utf-8?B?VVJwL0R0elMwQzFHS1pPMnptZnJpNEloNmF2YUtyd2VtSks3WEp2dlNRNXU5?=
 =?utf-8?B?S0dsVExJRllmN2JLSHZhcXorR1dMYldnTGE0UjdrTXdJd3Q3a2dTUHpkbUlu?=
 =?utf-8?B?YXhwK1hLRERnOXllc05KdVYyRDJSdDNvcDltankrM2QydXBIUVd2WmxVUHBn?=
 =?utf-8?B?QjFkSVdBTXRwcEFvZmpJb0dsSkJrUmVDWHB6aGpvbW5aQ3QwSC9qdDE0dXdK?=
 =?utf-8?B?cHByTkRYMGw1bGFCbCtNOHVTQzFoTGF2NkliZjRoYXdRQ3o5TnVFM3hCeCtk?=
 =?utf-8?B?cnBFaVA0Z2xTVGhaeEp0eWs2OW5GUnZSZ3gxeHlXSFBHYjFFTWx2VCt2dnFn?=
 =?utf-8?B?WVd3aHJnNHNEM2RBL3BDSGpwMlBadVNWSi9ESE9iTit5eWZDcGJUby93a3lR?=
 =?utf-8?B?VWoyQllNQ3JwOGxxTE9tZ1o1aFduaXFZTlJYRm8xM1VndkhBNStjR3NTUkY0?=
 =?utf-8?B?cUFkOTIwM016WXRxaFB0VFNtcFZ3RUcxRWx1YzVOdFZJZ2dVUWp1cW1rbFZt?=
 =?utf-8?Q?pcMypBtG1po8rRPSbld9zCyUb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe9149-d771-4294-66d3-08dcd1afdb60
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:47:21.0929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUKQOhTVNAg/DAZu42wHY6nyxuEG7OlJ0j+daWCoNzsSfFSH4Z3GLuMhEiY3VaGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

Am 24.06.24 um 16:08 schrieb Yunxiang Li:
> Before, every time fdinfo is queried we try to lock all the BOs in the
> VM and calculate memory usage from scratch. This works okay if the
> fdinfo is rarely read and the VMs don't have a ton of BOs. If either of
> these conditions is not true, we get a massive performance hit.
>
> In this new revision, we track the BOs as they change state. This way
> when the fdinfo is queried we only need to take the status lock and copy
> out the usage stats with minimal impact to the runtime performance.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  15 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  21 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 183 +++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  32 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
>   8 files changed, 185 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ec888fc6ead8..397cb0f83811 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1166,7 +1166,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   			if (!bo)
>   				continue;
>   
> -			amdgpu_vm_bo_invalidate(adev, bo, false);
> +			amdgpu_vm_bo_invalidate(bo, NULL, false);
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 8e81a83d37d8..87fc3f37a1eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -190,6 +190,13 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>   	}
>   }
>   
> +static void amdgpu_dma_buf_release(struct dma_buf *buf)
> +{
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(buf->priv);
> +	amdgpu_vm_bo_handle_shared(bo, true);
> +	drm_gem_dmabuf_release(buf);
> +}
> +
>   /**
>    * amdgpu_dma_buf_begin_cpu_access - &dma_buf_ops.begin_cpu_access implementation
>    * @dma_buf: Shared DMA buffer
> @@ -237,7 +244,7 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
>   	.unpin = amdgpu_dma_buf_unpin,
>   	.map_dma_buf = amdgpu_dma_buf_map,
>   	.unmap_dma_buf = amdgpu_dma_buf_unmap,
> -	.release = drm_gem_dmabuf_release,
> +	.release = amdgpu_dma_buf_release,
>   	.begin_cpu_access = amdgpu_dma_buf_begin_cpu_access,
>   	.mmap = drm_gem_dmabuf_mmap,
>   	.vmap = drm_gem_dmabuf_vmap,
> @@ -265,8 +272,10 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>   		return ERR_PTR(-EPERM);
>   
>   	buf = drm_gem_prime_export(gobj, flags);
> -	if (!IS_ERR(buf))
> +	if (!IS_ERR(buf)) {
>   		buf->ops = &amdgpu_dmabuf_ops;
> +		amdgpu_vm_bo_handle_shared(bo, false);
> +	}
>   
>   	return buf;
>   }
> @@ -345,7 +354,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
>   	/* FIXME: This should be after the "if", but needs a fix to make sure
>   	 * DMABuf imports are initialized in the right VM list.
>   	 */
> -	amdgpu_vm_bo_invalidate(adev, bo, false);
> +	amdgpu_vm_bo_invalidate(bo, NULL, false);
>   	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>   		return;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 1f22b4208729..1cd28fc1dcf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -843,7 +843,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			struct drm_file *filp)
>   {
> -	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct drm_amdgpu_gem_op *args = data;
>   	struct drm_gem_object *gobj;
>   	struct amdgpu_vm_bo_base *base;
> @@ -903,7 +902,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>   
>   		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
> -			amdgpu_vm_bo_invalidate(adev, robj, true);
> +			amdgpu_vm_bo_invalidate(robj, NULL, true);
>   
>   		amdgpu_bo_unreserve(robj);
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index bcf25c7e85e0..469bb600bcaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -37,6 +37,7 @@
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_cache.h>
>   #include "amdgpu.h"
> +#include "amdgpu_vm.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
>   
> @@ -1258,7 +1259,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   			   bool evict,
>   			   struct ttm_resource *new_mem)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct ttm_resource *old_mem = bo->resource;
>   	struct amdgpu_bo *abo;
>   
> @@ -1266,7 +1266,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   		return;
>   
>   	abo = ttm_to_amdgpu_bo(bo);
> -	amdgpu_vm_bo_invalidate(adev, abo, evict);
> +	amdgpu_vm_bo_invalidate(abo, new_mem, evict);
>   
>   	amdgpu_bo_kunmap(abo);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 218919fc13ec..c65463f66cb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -135,27 +135,6 @@ struct amdgpu_bo_vm {
>   	struct amdgpu_vm_bo_base        entries[];
>   };
>   
> -struct amdgpu_mem_stats {
> -	/* current VRAM usage */
> -	uint64_t vram;
> -	/* current shared VRAM usage */
> -	uint64_t vram_shared;
> -	/* current GTT usage */
> -	uint64_t gtt;
> -	/* current shared GTT usage */
> -	uint64_t gtt_shared;
> -	/* current system memory usage */
> -	uint64_t cpu;
> -	/* current shared system memory usage */
> -	uint64_t cpu_shared;
> -	/* sum of evicted buffers */
> -	uint64_t evicted_vram;
> -	/* how much userspace asked for */
> -	uint64_t requested_vram;
> -	/* how much userspace asked for */
> -	uint64_t requested_gtt;
> -};
> -
>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>   {
>   	return container_of(tbo, struct amdgpu_bo, tbo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..8dd239912bb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -36,6 +36,7 @@
>   #include <drm/ttm/ttm_tt.h>
>   #include <drm/drm_exec.h>
>   #include "amdgpu.h"
> +#include "amdgpu_vm.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_gmc.h"
> @@ -310,6 +311,111 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   	spin_unlock(&vm->status_lock);
>   }
>   
> +static void amdgpu_vm_stats_update_shared(struct amdgpu_vm_bo_base *base,
> +				      bool unshare)
> +{
> +	struct amdgpu_vm *vm = base->vm;
> +	struct amdgpu_bo *bo = base->bo;
> +	struct amdgpu_mem_stats *stats;
> +	uint64_t size;
> +
> +	if (!vm || !bo)
> +		return;
> +
> +	spin_lock(&vm->status_lock);
> +	stats = &vm->stats;
> +	size = amdgpu_bo_size(bo);
> +	switch (bo->tbo.resource->mem_type) {
> +	case TTM_PL_VRAM:
> +		stats->vram_shared += unshare ? -size : size;
> +		break;
> +	case TTM_PL_TT:
> +		stats->gtt_shared += unshare ? -size : size;
> +		break;
> +	case TTM_PL_SYSTEM:
> +	default:
> +		stats->cpu_shared += unshare ? -size : size;
> +		break;
> +	}
> +	spin_unlock(&vm->status_lock);
> +}
> +
> +void amdgpu_vm_stats_update(struct amdgpu_vm_bo_base *base,
> +			    struct ttm_resource *new_mem,
> +			    struct ttm_resource *old_mem)
> +{
> +	struct amdgpu_vm *vm = base->vm;
> +	struct amdgpu_bo *bo = base->bo;
> +	struct amdgpu_mem_stats *stats;
> +	uint64_t size;
> +	bool shared;
> +
> +	if (!vm || !bo || (!new_mem && !old_mem))
> +		return;
> +	spin_lock(&vm->status_lock);
> +
> +	stats = &vm->stats;
> +	size = amdgpu_bo_size(bo);
> +	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
> +
> +	if (old_mem) {
> +		switch (old_mem->mem_type) {
> +		case TTM_PL_VRAM:
> +			stats->vram -= size;
> +			if (shared)
> +				stats->vram_shared -= size;
> +			break;
> +		case TTM_PL_TT:
> +			stats->gtt -= size;
> +			if (shared)
> +				stats->gtt_shared -= size;
> +			break;
> +		case TTM_PL_SYSTEM:
> +		default:
> +			stats->cpu -= size;
> +			if (shared)
> +				stats->cpu_shared -= size;
> +			break;
> +		}
> +	}
> +	if (new_mem) {
> +		switch (new_mem->mem_type) {
> +		case TTM_PL_VRAM:
> +			stats->vram += size;
> +			if (shared)
> +				stats->vram_shared += size;
> +			break;
> +		case TTM_PL_TT:
> +			stats->gtt += size;
> +			if (shared)
> +				stats->gtt_shared += size;
> +			break;
> +		case TTM_PL_SYSTEM:
> +		default:
> +			stats->cpu += size;
> +			if (shared)
> +				stats->cpu_shared += size;
> +			break;
> +		}
> +	}
> +	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
> +		if (!old_mem)
> +			stats->requested_vram += size;
> +		else if (old_mem->mem_type != TTM_PL_VRAM)
> +			stats->evicted_vram -= size;
> +		if (!new_mem)
> +			stats->requested_vram -= size;
> +		else if (new_mem->mem_type != TTM_PL_VRAM)
> +			stats->evicted_vram += size;
> +	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
> +		if (!old_mem)
> +			stats->requested_gtt += size;
> +		if (!new_mem)
> +			stats->requested_gtt -= size;
> +	}
> +	spin_unlock(&vm->status_lock);
> +}
> +
>   /**
>    * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
>    *
> @@ -332,6 +438,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   		return;
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
> +	amdgpu_vm_stats_update(base, bo->tbo.resource, NULL);
>   
>   	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>   		return;
> @@ -1088,51 +1195,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> -static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
> -				    struct amdgpu_mem_stats *stats)
> -{
> -	struct amdgpu_vm *vm = bo_va->base.vm;
> -	struct amdgpu_bo *bo = bo_va->base.bo;
> -
> -	if (!bo)
> -		return;
> -
> -	/*
> -	 * For now ignore BOs which are currently locked and potentially
> -	 * changing their location.
> -	 */
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
> -	    !dma_resv_trylock(bo->tbo.base.resv))
> -		return;
> -
> -	amdgpu_bo_get_memory(bo, stats);
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> -		dma_resv_unlock(bo->tbo.base.resv);
> -}
> -
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats *stats)
>   {
> -	struct amdgpu_bo_va *bo_va, *tmp;
> -
>   	spin_lock(&vm->status_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +	*stats = vm->stats;
>   	spin_unlock(&vm->status_lock);
>   }
>   
> @@ -2043,6 +2110,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   			if (*base != &bo_va->base)
>   				continue;
>   
> +			amdgpu_vm_stats_update(*base, NULL, bo->tbo.resource);
>   			*base = bo_va->base.next;
>   			break;
>   		}
> @@ -2108,17 +2176,37 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   	return true;
>   }
>   
> +/**
> + * amdgpu_vm_bo_handle_shared - called when bo gets shared/unshared
> + *
> + * @bo: amdgpu buffer object
> + * @unshare: bo got unshared
> + *
> + * For now the only thing this does is to update the per VM stats
> + */
> +void amdgpu_vm_bo_handle_shared(struct amdgpu_bo *bo, bool unshare)
> +{
> +
> +	struct amdgpu_vm_bo_base *bo_base;
> +
> +	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
> +		bo = bo->parent;
> +
> +	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next)
> +		amdgpu_vm_stats_update_shared(bo_base, unshare);
> +}
> +
>   /**
>    * amdgpu_vm_bo_invalidate - mark the bo as invalid
>    *
> - * @adev: amdgpu_device pointer
>    * @bo: amdgpu buffer object
> + * @new_mem: the new placement of the BO move, NULL if just invalidate
>    * @evicted: is the BO evicted
>    *
>    * Mark @bo as invalid.
>    */
> -void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
> -			     struct amdgpu_bo *bo, bool evicted)
> +void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
> +			     bool evicted)
>   {
>   	struct amdgpu_vm_bo_base *bo_base;
>   
> @@ -2129,6 +2217,9 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> +		if (new_mem)
> +			amdgpu_vm_stats_update(bo_base, new_mem, bo->tbo.resource);
> +

Ok that looks extremely ugly. Please just add a separate function and 
call that from the TTM move function.

>   		if (evicted && amdgpu_vm_is_bo_always_valid(vm, bo)) {
>   			amdgpu_vm_bo_evicted(bo_base);
>   			continue;
> @@ -2640,6 +2731,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		}
>   	}
>   
> +	if (memchr_inv(&vm->stats, 0, sizeof(vm->stats)))

Please either drop that or compare each memory stat variable separately. 
Byte by byte compares are really frowned upon.

Apart from that looks rather good to me,
Christian.

> +		dev_err(adev->dev, "VM memory stats is non-zero when fini\n");
> +	else
> +		dev_dbg(adev->dev, "VM memory stats is zero when fini\n");
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 046949c4b695..13e1ec4deb05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -42,7 +42,27 @@ struct amdgpu_bo_va;
>   struct amdgpu_job;
>   struct amdgpu_bo_list_entry;
>   struct amdgpu_bo_vm;
> -struct amdgpu_mem_stats;
> +
> +struct amdgpu_mem_stats {
> +	/* current VRAM usage */
> +	uint64_t vram;
> +	/* current shared VRAM usage */
> +	uint64_t vram_shared;
> +	/* current GTT usage */
> +	uint64_t gtt;
> +	/* current shared GTT usage */
> +	uint64_t gtt_shared;
> +	/* current system memory usage */
> +	uint64_t cpu;
> +	/* current shared system memory usage */
> +	uint64_t cpu_shared;
> +	/* sum of evicted buffers */
> +	uint64_t evicted_vram;
> +	/* how much userspace asked for */
> +	uint64_t requested_vram;
> +	/* how much userspace asked for */
> +	uint64_t requested_gtt;
> +};
>   
>   /*
>    * GPUVM handling
> @@ -336,6 +356,8 @@ struct amdgpu_vm {
>   	/* Lock to protect vm_bo add/del/move on all lists of vm */
>   	spinlock_t		status_lock;
>   
> +	struct amdgpu_mem_stats stats;
> +
>   	/* Per-VM and PT BOs who needs a validation */
>   	struct list_head	evicted;
>   
> @@ -514,8 +536,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
> -void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
> -			     struct amdgpu_bo *bo, bool evicted);
> +void amdgpu_vm_stats_update(struct amdgpu_vm_bo_base *base,
> +			    struct ttm_resource *new_mem,
> +			    struct ttm_resource *old_mem);
> +void amdgpu_vm_bo_handle_shared(struct amdgpu_bo *bo, bool unshare);
> +void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
> +			     bool evicted);
>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>   				       struct amdgpu_bo *bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index e39d6e7643bf..841a575cb18d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -586,6 +586,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	if (!entry->bo)
>   		return;
>   
> +	amdgpu_vm_stats_update(entry, NULL, entry->bo->tbo.resource);
>   	entry->bo->vm_bo = NULL;
>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	if (shadow) {

