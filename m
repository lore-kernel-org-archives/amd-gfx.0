Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081D0C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 10:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805CA10E806;
	Mon, 29 Jun 2026 10:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4V/PgT8Z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A4910E803
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 10:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHGlkhs/8nh1gZSd9hS2b0yd2VVgYIve66GqF9lYhKab+53Vn2HgbQckOizOEIKdS4BeKHmJB17R9FP//WGj5hlYs3HKBAf+0olNudomV2UDPp2DUvAksECrJ07SHVCwqb/g6RDgPEc1uHEF6UyfpLu3N/lVdYdj9UP57UlYCpeZq8adtkWuO4Yy4fIWpv5cN0rRvEcir0hw68zX0a81KabtS9CDr81Hv4xJZM0zN4+C1f6lsAmqXNO1H59J+d+oa7WLm8KNymLJ4bbcmdSJpsw+VSt7H5vHwxxgXMeexB9civ8PMKJrbISp2ZeA3IFjc0+Zoq4ZS1oqnQDbkwPdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95ib/m5wPPWeVdd3qfWIjS/jBHbQGyn/fSvcvms82W4=;
 b=fFGiFAW//5Zg5tqYWUZQ1EKfxS4rT8uTKTepp1yCb80ptGOvd/AOgvi8sWSP9w6Iyw8T9Az98I+xfDRda8pAJyM/xUfIEnUKJvliDjVLBn4dgqTtCr37IVD1soMslzfZMrMPq3XmeuoQYi5b/6QI5gp44cWg8rmvwXZbteyU1+DX5p62YFLypos0NwkckOcx0n2j039s3p2jwD+YsF+ZuayTMZZmaUEoKSupmryUzz80D1cycWZO/axeLghpv2ljKLR/LPv0wTNvbLpCgtazJ/nASKdtxAarN4CusyrIvBqWK/zwqriHlCv3xpL+xytwFCdL0QveeO3JR6C8snWVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ib/m5wPPWeVdd3qfWIjS/jBHbQGyn/fSvcvms82W4=;
 b=4V/PgT8ZvcVGkH0Rm8MU+/+z9bjnxRlqYXWkHmx+24nW5uWhhBJadNlWGAWYLb7UZ14FUZr+B4Lp6Oj+/typ3nxG0PASc2AvDJuoUigLpUueMFztI1r6BEYqYhVPwWpH9YaeVagTobrVTk4BPimJd8gX+x+4Y6AvvDeOr8FXkXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:00:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:00:59 +0000
Message-ID: <db4d886f-7310-42a8-a480-5b4c4c99e4de@amd.com>
Date: Mon, 29 Jun 2026 12:00:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: remove gfx sysfs files on device unbind
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260627043801.1025055-1-geoffrey.mcrae@amd.com>
 <20260627055720.1543432-1-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260627055720.1543432-1-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 943685de-3df2-4ec1-a7f3-08ded5c551b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: n9USJQQkjJFqPGjG0hnYvIzA84Qg+imnfnZDFHd0He9LU6jlaBZq4wdpMQbyxTICjTI4UjKb6CMQreodlwTMOBgjn2ALG6bK+yM9id8tIi2xNQ1ePGFt7HmmZTqeYXklEEoML1A9Q0pkyqnMU4dj8oYjZN4xzH4D4pdxazW91nsB1Rnq/jMAfXSiNAv3okfA+QOax8H/U5gXTWEi2Yvfin0WlDhBiRbdH87FSRhWGhs/D4pjhdp0pyCSYWhx5zQ4oj2s8xuL0rrKaF5DkYxyI5tcgIcMaCV2hhQkEMW7n8u2PDwL6AR9o4NIcPY6Wg+8ib5Q80rgI0oYbHr5zcuJuSzplUd8iUMUuw5ZBKnRhz+fOOQyjLSC2vBc7HV6h4T8j8YNFPzl97L3mpMW4XAngqEprIBxsUw4ibg5I6y6DIwWkPF56pVmmqnCurKaSbCr8Ax/MFi+WaSeyo22ua0BgXnRm+tPUqW57LH7gkt8+OcK1TtFwCMVUS4iCMHcbrnqQObt7FWsOphr84Wrnc+FkQbOqJmqBpvLIY1FejqAgEIO97bZkrwN5N8tK2Jt+6WTLLduGd/XgfKpWjsjqq1ybrGZWbCf1tAR0A2wiGm/CjD2CkzNHSHfOFzkIZUxqitLH40UGc+ufHJt3jMQ5ZZ0LVjUbIqAmBA33TnWLFbD70s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFnRkdPYTF1dFBWdXlYS2xsQlExQnM3aHRhelNuVjd1YVRFTTVpQkN5dENj?=
 =?utf-8?B?K3dRdmJjNjBLNlgzckZ1MXY3NEp3bmN0ZnBpVzRoWkgrYjBOd2txMHFvQUE5?=
 =?utf-8?B?UUZVVHFRY3J1V202V0gyeWRiYXlOeUh6bmlWN3NDNW9HM2R4SHArcDVlNUFB?=
 =?utf-8?B?SHhrQUhmYk9ydnNUcGFROFl5SWxCZk9KZWxHcFdTZkhjbktrelFOcWhBL3Nl?=
 =?utf-8?B?eXpldnRiWkxMZHNDQkhhaDBLQXZ1UmQ0YkJMQ3JRekZDcmRpaEtha0MxdCtr?=
 =?utf-8?B?d295UG81REh1bDFoU1V1Mm5hRVFFYWhCMTNpdXlrejVPdWQrWFZCSmFpeDIy?=
 =?utf-8?B?RDR1QVRGQjAxNWJvQkppbFpUSHVOVGhMVTliVjNPYkljL1B5eUtUZnJIRTJK?=
 =?utf-8?B?Wmc0cEQrRlJRQXo3WHFIK3Ara21UNjlCMkZsZlhmU0Ryamo5dCsyTmwyNXp0?=
 =?utf-8?B?N0VxOE04NnpjVUEyNzR3b01TQ3B5djM2MDZqcksvMUZkYXVXZU5UQldiK3Nv?=
 =?utf-8?B?M1RoMUdWRjJFR21SRC9RUTlYRzByYUZjZGc5dXZXc21JUlNoZ3BFZ0RFT1Zl?=
 =?utf-8?B?TjRVOERnc1lSdm5vQ0Qrc2FwY0xqdTFsb0phK3M4Y2k5aEF6YzRON0tzNlI3?=
 =?utf-8?B?OHlKbGtJa2ZObzU3akJaYWtwNXdzRU5SZCtBTmZtSlc5SlgzWnprM1NnR1Fa?=
 =?utf-8?B?Mm9LTzZReWdMelpMVTNRK2N4ZjFOUENuOVd3dFJiVkRTUStCMFpxQndSMUpD?=
 =?utf-8?B?NG5KREJNYk1ZS3FGOVhBK2dQVXdlYml5bitvK0lMcUwvbzJEdXFjUTFQOGl0?=
 =?utf-8?B?TmVEQWJUaklmNWMyMHpFVTAxZThud3F3VHk4K3hGdHBobUNVQmUzVFJ4MUZ0?=
 =?utf-8?B?RWV2UlFBWGszVm9xemplWGp3WmdlQXlDVVBSNWI1d2FjMTF1ZEFOYy9ESklF?=
 =?utf-8?B?ZmMyeHN4MUdhOWpIakRnUXlhLzFubll1MDRGMWhhcllsdmF2QlQvd0lUaDJM?=
 =?utf-8?B?elFHcStvdVhCcVJHYjlvOEJObFoxbXFjSDlETmxJd2dsZmpibVMxVy85Z3Z5?=
 =?utf-8?B?MzlSKzdXQlJWM0laVmRFckxWUG1uSjdUSWw2ZVcyWjlzOHZmcllma1MrdHcv?=
 =?utf-8?B?ZnlzeVpGWHc1UjNOcTgwV0l2NTAwNHhiM0RhaHRvdklQWk5kRjZUSWxkMlVq?=
 =?utf-8?B?eWZNZDRzNmRiRVZUNG5pbUpEQWsrcG1YQ0dsbXZiUjFMbVluVkhWZ29id1Bo?=
 =?utf-8?B?SjJXdFQrdHFOcUowMG96TTdGeURWWUxJK2RZSVBKaTZYVUpCd29kNktjK3Uy?=
 =?utf-8?B?Q2JFSHVHbERvZEZXRnVIaGJRSGl2YjdiNFJmOFcxTjY2dzRlbG94ZUFWRkJG?=
 =?utf-8?B?dS9nUWE4MjQydTdCL1hobVBob3lMUUN5L3R5Z3FPREFBOUROMGIwK0o1Mk1w?=
 =?utf-8?B?Q09XTWRhYWVxMjlEUGdBZW1BNllOWGNhK1RZOGFoSnBOMXpZRk9LT3liQmJW?=
 =?utf-8?B?V1l2Mmh1Qm0rZDJzL0xsZVpoTUxZalFBNnFPZWxBOHlaNkY5b3ZsWkIxS0RZ?=
 =?utf-8?B?NUNQbm1rSXVITzgyb1A1NTFkb0FkVjhKVklSZHhFbVlpUm9wNFdhazcvakJx?=
 =?utf-8?B?b1JqL21UK0piS3c2dVFjaWhBK0NjQ3A4ZTJZZzVWbExrR2JHV2NHL1BrNndM?=
 =?utf-8?B?TTFTWVluKzJtRU5LZit3SEtKbVBodThpbXBXWEdYZmdqR1FzMGkxWGlvRHYw?=
 =?utf-8?B?dTRlSDF6VWgrclk2eUUzdWw5UDYxWUY1VWdyVERNQWhmL3NPQlRPNzBoM1dI?=
 =?utf-8?B?OHhHVHFVTnpvWXdQUmNGVS9vZnhtVFlNUCsxYXlmWWhNdkE3RlBIaVJkUHht?=
 =?utf-8?B?elJseUhUeWFBODNsTFFqaUJFSGJKVTV0akZKOWtxdXNqTldLdi84Mm9xS2xp?=
 =?utf-8?B?ZVdiRDFwTFRjcVkxZ1RvVHUxSVQ4RzVYSHluOUdEZVF5UmJSMlVDSW15ZE5m?=
 =?utf-8?B?dnI1K1c5aFU3V0FVeVBWNi83djNiKzBERUVsaG11L3VMOEtlT1ZuKzRENmNZ?=
 =?utf-8?B?NkhmbmRTNGtvRXYxVmNVckZQV1k5T3cwS3FjUTdoSmpGQy85NUVBN1dtZ3NL?=
 =?utf-8?B?SlMzY0NwQm90K1R3U2VuSjdnQXMwd1I2d2hacmlOOTZOYUd2MG9kcTY1a0tV?=
 =?utf-8?B?YlByQnl5WEQySlBieVg0ZG15N3NjTHlMbVBLVDJOU1VwcCtvVWZtRjBsbGpQ?=
 =?utf-8?B?MytIMFNBVXdySmE0akVXTkdHUDJ6cTFjQVQ3a3JWMFBuRmZsWEhzMlhyRC90?=
 =?utf-8?Q?Rajc52Du0cD4bFKa1X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943685de-3df2-4ec1-a7f3-08ded5c551b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:00:59.1638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njFtfBvmCDF51T6gEpc6ZIVt9rdG+tj8/Qr8UR3aSmhlPpw52Q50IclEBVDtm3Po
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
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

On 6/27/26 07:57, Geoffrey McRae wrote:
> Fix more sysfs file duplication errors when reinitializing the device:
> 
>   sysfs: cannot create duplicate filename '.../enforce_isolation'
>   sysfs: cannot create duplicate filename '.../sdma_reset_mask'
>   sysfs: cannot create duplicate filename '.../vcn_reset_mask'
>   sysfs: cannot create duplicate filename '.../jpeg_reset_mask'
>   sysfs: cannot create duplicate filename '.../vpe_reset_mask'
>   sysfs: cannot create duplicate filename '.../current_memory_partition'
>   sysfs: cannot create duplicate filename '.../available_memory_partition'
> 
> Fix this by:
>   - improve amdgpu_gfx_sysfs_init error unwinding so partially-created
>     gfx sysfs files are removed on registration failure.
>   - added adev->gfx.sysfs_registered tracking so gfx sysfs cleanup is
>     idempotent when harware teardown runs before the existing software
>     teardown cleanup path.
>   - calling amdgpu_gfx_sysfs_fini, amdgpu_sdma_sysfs_reset_mask_fini,
>     amdgpu_vcn_sysfs_reset_mask_fini, amdgpu_jpeg_sysfs_reset_mask_fini,
>     amdgpu_vpe_sysfs_reset_mask_fini and amdgpu_gmc_sysfs_fini from
>     amdgpu_device_sys_interface_fini
> 
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>

Alex can you take a look at this?

In general the coding seems correct, but Greg usually insists that we use the managed sysfs functions which remove stuff automatically on driver unbind.

But if I'm not completely mistaken that doesn't work here because the device structure is not released before all userspace refs drop.

If the device is re-created before that happens we run into the error above.

Regards,
Christian.
 

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 32 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  2 ++
>  3 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 70d07ca187a3..c0a22d2411f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3674,6 +3674,14 @@ static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
>  
>  static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
>  {
> +	amdgpu_gfx_sysfs_fini(adev);
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
> +	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +	amdgpu_vpe_sysfs_reset_mask_fini(adev);
> +	if (amdgpu_is_multi_aid(adev))
> +		amdgpu_gmc_sysfs_fini(adev);
> +
>  	if (adev->pm.sysfs_initialized)
>  		amdgpu_pm_sysfs_fini(adev);
>  	if (adev->ucode_sysfs_en)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 982b41606d48..ab37c4a9f415 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2175,6 +2175,8 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> +	adev->gfx.sysfs_registered = false;
> +
>  	r = amdgpu_gfx_sysfs_xcp_init(adev);
>  	if (r) {
>  		dev_err(adev->dev, "failed to create xcp sysfs files");
> @@ -2182,23 +2184,39 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>  	}
>  
>  	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> -	if (r)
> +	if (r) {
>  		dev_err(adev->dev, "failed to create isolation sysfs files");
> +		goto err_isolation_shader;
> +	}
>  
>  	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> -	if (r)
> +	if (r) {
>  		dev_err(adev->dev, "failed to create reset mask sysfs files");
> +		goto err_reset_mask;
> +	}
>  
> +	adev->gfx.sysfs_registered = true;
> +
> +	return 0;
> +
> +err_reset_mask:
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +err_isolation_shader:
> +	amdgpu_gfx_sysfs_xcp_fini(adev);
>  	return r;
>  }
>  
>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>  {
> -	if (adev->dev->kobj.sd) {
> -		amdgpu_gfx_sysfs_xcp_fini(adev);
> -		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> -		amdgpu_gfx_sysfs_reset_mask_fini(adev);
> -	}
> +	if (!adev->gfx.sysfs_registered)
> +		return;
> +
> +	amdgpu_gfx_sysfs_xcp_fini(adev);
> +	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +
> +	adev->gfx.sysfs_registered = false;
>  }
>  
>  static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index aefd4f03b443..df7ce026bfa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -477,6 +477,8 @@ struct amdgpu_gfx {
>  	struct amdgpu_irq_src		rlc_poison_irq;
>  	struct sq_work			sq_work;
>  
> +	bool				sysfs_registered;
> +
>  	/* gfx status */
>  	uint32_t			gfx_current_status;
>  	/* ce ram size*/

