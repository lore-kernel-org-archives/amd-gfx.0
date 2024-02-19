Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B2C48260
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 03:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BBC10E064;
	Mon, 19 Feb 2024 03:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c+yseBWc";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92ED10E064
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 03:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGuOqsxfE9ZvPX4ZK4uFjUZBdqmQANYolNvEBh4FEbVx00Snw0E8NGxhz54cgo7he8LUjSjoXkP2CNibbponNoFP2Mex0Y6KEcJVYz8G610bILtAkRaDMf4qFm0U4n2hWXSpr630aZx9YkDDPhh6fcV+TM/mENALIDCoocIsK08VXVp9OozgWakbFcm0XWWUjmYMhSU+dcAdMFq3YSClyYGP6Yf5b06xQ+CPYblPsxKq+u3cTB2S1gKDxkEqnrYw6Ko2yEy5YYvwnbSftvRtPTdoJzEVLl5gcZtx5idh2//dN6BJ7AtdsyaxbOlzcGWTN0sx8JK9S7lb4Qx82s+dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dshn0bFFG5SF6HOsAe5nHNXLIBlzvrrE0JusrHinaSM=;
 b=ClQTBMliD349kQkbSqiPx90V5Mu2VRDL4fVKZ2VbYb9PL3vnmTI1TKu+h782Iy5ywAjLXXaX9yLdschFW0flTLI08ZLTV/8NzBAFrwAxNxcqJT+PUoBaTkQFKg3nzvz1F/8IPfz89gIblXZOOX5wgHOcblNgNRiIvooSxaAqVtj7mKQSUIsKhBeEiDPgPFPl19tgklZHsOYvZcxoO1PVmbKmy/Q5GBr/Bb2utotc2CIhwkJZk5AKxkfgfo7lG9QmhozDMizSwz917AQD58KCunoHY7UQ5HPB8Ta+QitbGoOmLmmUcBYVO8LjbUnGp530NOEo3h1c/IQu+8q/m5Ah9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dshn0bFFG5SF6HOsAe5nHNXLIBlzvrrE0JusrHinaSM=;
 b=c+yseBWcFjee7TMEJe4xe2AXa2RmvmOY6HVi1NcAd6s+8o/qEF0iRdMAh0vpcZ4NySNs1OF1S/g6aW8w9v467YXagmBPOzHmiPkf0PbIMzKsKPYWeu7l53y6qdvJQzM+b7APjjFZS3SIE//+R7uluNQcA020jJNrnpc7DtsUkok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.19; Mon, 19 Feb 2024 03:59:19 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 03:59:19 +0000
Message-ID: <25fa1025-17f1-4d33-9855-043ecd2f6e12@amd.com>
Date: Mon, 19 Feb 2024 09:29:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add UTCL2 RAS poison query for gfx 9.4.3
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240218065604.313544-1-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240218065604.313544-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: c1432d42-1b18-4f11-53b7-08dc30ff25a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkzuAZfVFzZZkSA9MNRJollYigSYxadvT8pm2hswTz+k7NdKt2e8uGICosPSyDEG2cXTB9fSbQdxsKPxi4CWS8GgNR0PjH8CE5HUfRh0mxKbBBzfeME185dMzZvNwq7n9ZX7mh0+FZj6A/pQjhLQiPa9UXEgwItIvmOIBwsYf8NNLfzZo3w72yysaLrRlf1uVpsYqf26ajWCp6U70n75eba9/kG+7oOW5yC7JKisYh/7CgdObbo6dpJXFAWyjiA1fMVaddRwW0UNyV1NuR7tkB2ZCPADZZf9gvIFr2i4Ebwkj6rlQKpJQH39wooGCiWtCDYgeraEIVIfXLF9AKQPyNPd9Tb6m/ngSngQJRK3IgmHVh9oGl1yFTtr+hIDj3XHvmmL6vQrEaPvSZsouj7ZXkiitkBXAPM3CZGcjg5F3pSsL+yk42TvPz0QXtcDnH0iOoXTOy5a/yPcTI0kmTDDsjBTkHcUpgHPBW7Q+9c12BTrj7phn6zFN2JJFzni9A+q8bxx+hbwy0pqItxgISbuiN0Kpdm6fxttMtLapqMOP8Qz1iTDGeDWjDPdeBmW5R4C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6666004)(6512007)(6486002)(478600001)(31686004)(41300700001)(2906002)(8936002)(5660300002)(8676002)(316002)(6506007)(53546011)(66556008)(66476007)(66946007)(2616005)(83380400001)(86362001)(31696002)(26005)(38100700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBmVDdyKzg4clVqMVVTbzg0WHVzcnJZQllzcFV1L2I2RTNrQXFibnVubm1F?=
 =?utf-8?B?S1ZLeTc5UUpYdjF3dUVHUTFWQzNjcXdzOVo1R0NRM0ZrTklvQXl0RUJIWUx1?=
 =?utf-8?B?Y3FISCs1SVROdExucTRYYURGb1lhd3JBaTVaSE16RFFlWHc3eVdPRm1MYVY2?=
 =?utf-8?B?NjJDRXZjMWpsRVd6anN2ZmZDVFNEM2FFZ2xrSEtPenNMQWJleWhJLzRHZnp6?=
 =?utf-8?B?WS85c2FVVzhQa1E1YWlOd0ROMElSN0lJcXU1UzFCc2lDQlVNOVFsdnFaa29O?=
 =?utf-8?B?M1YvTUJGQWswdG9UZ05XR1pINHVOcklacTd3bHRNZytGNjBlRmxuQ0paWFZx?=
 =?utf-8?B?b01FKzdqd0Q2YVR4VzVWVVo3aVhmS3VscHRqQ20xT2lRdi9PTkhqamxoV0Ns?=
 =?utf-8?B?RzZGaFhUK0lnTk1JRDRnY2NuY2VBM1Rib2tXblpmS3NRSEZhYzhualBrcEpI?=
 =?utf-8?B?VDYzdW1FVi9EMFhNRmE3Qk83UU8vWkdjSFV0VjJKZENQMXE2Nko5Q0xaVWx5?=
 =?utf-8?B?NVFoUUIyNVY0TmhUVGF3L2FQQ1pERjVrMzBsYUtJbmlXQ3g5d0JuM3M1Tms3?=
 =?utf-8?B?Mlhhd1E5OHNwNDc5RHBvdGM4QjlvR0p0RW4vaHpFdWlXeXhkR2dpSXpad3p2?=
 =?utf-8?B?UzAwK1ZTaFRvMHBuV2JwTS9TQzJlYVhvZnE0R3BuZGFKWE5CNWVEMXZMZ0x6?=
 =?utf-8?B?WHlyYVdQdnYweUUzSkxTY0ZHUHFHWEJwc1NvVmo1dnhZT1lwYUFkTHdYZ3cv?=
 =?utf-8?B?cnJqNW0xaU12N3Z2elBJZm4zdjlja2I3STBVODlIQkVzZzFOQ0JmQ2VOUGpN?=
 =?utf-8?B?V2dTL3dLRU1Nbk1ZL3JLa28yMUo5N0wvT20vTWtGRVpxaXZiUEtTcjYyd0hh?=
 =?utf-8?B?S3h6UUhMSzVGYzl4QnFSWGJWZ0k4NGhmSVFwWGovc2d0b2ZNR3pCRkJFZGtB?=
 =?utf-8?B?MUtycFhNSEVxN2c5a0hCTU04RHZKTW4yamQ1bXVuZFF2NWFmRzBEN2N0L2Zi?=
 =?utf-8?B?emhiZnEvNnZHb0hsZUdhczl1WmxSZStnanM0cGRLUkFwTU9DVGhUZ1FiUlZV?=
 =?utf-8?B?dUJuWjdmQ2JsV3EzQjYrWlNCcjZieFQ0T3R6Y0N2QjB0UWFKbzRSczdSOU5R?=
 =?utf-8?B?YU96eUZSeDE0MnA4eDJocTdaekNOUVBEeWtLb0wwR3hwcXg2bjJWMzAwaTY2?=
 =?utf-8?B?T1oxblNLakt6d2xORGdyZ3NpazRxQkFjK0hoRmlyeTd2K3lVQTFEaGdMd0ln?=
 =?utf-8?B?Q1ZEZzJSSEVPbDNDYWUxanN4L05ZdHQyQWlHOXFNRFdMRnpOVWt2Szl3akl5?=
 =?utf-8?B?VXZRTE9PYTI5NWVzUDVXRUx4cnFOUHJYaGRlcGtTRktHOGREczNIQmIxbWFX?=
 =?utf-8?B?SGl2QmNKZkd0NFBMSEUzK1U4ZlNJcWRjMmZFY1VFUkZqOWxtZGFYeTdad1JO?=
 =?utf-8?B?MU9wU2xiclFobS9aa0ZETnJ6anZzVkpuY3BjOEpRQ0NvSkIvWXZuVjRlWjU4?=
 =?utf-8?B?bWViWkI1d0hNY3JHWTREYVNyUkFSMkZlOVJsd1U5MnFqUUxiTTFzVzJtVS9B?=
 =?utf-8?B?SnIwN09URGlJV1ByeG1QT1VGZW5CeWtqVmRmKzBFUnRHclVsb2Y5OW53ODg2?=
 =?utf-8?B?b0htbnZtRVNTblM1cXJIeGkzekRFaTRyMnJkZk10NWRLdGxXako1c1pRSW10?=
 =?utf-8?B?VmFxRW1zZmVzNzQxcDJwMU8wRmlGWDB2TTJjenpEMnExRVZjQ2VKbTdLWitR?=
 =?utf-8?B?Q2lqQlVyTkx0VFpqcjlhazlNaXZ3Ym5vOW9FVml1NENuejl6N295VDdXUWZF?=
 =?utf-8?B?NVlkU1hTQTV1SHEvcHJZdDE4Y3BVS2pobE9lMUZIUEpXSmpkMUtTdmxrOG83?=
 =?utf-8?B?MzRyeC9IaXd2UDBWVHRBc3pGTlpvVVBaQkxrSXNXZVBLYzNPT1RaemIvNTVH?=
 =?utf-8?B?TmdjcTFnOFVjZjFoeTFRaHJUS0VMMEd3T0g0dUZuZ2J4ZkJhM3N1Y1R1cEtm?=
 =?utf-8?B?K2hTNHJFZjVmWVQvYzh0M2hwWkRMRWovalBjUXFBMXFVeEFnS3RNVmtRMkYx?=
 =?utf-8?B?U2lTcFZrNWZWdTczTW9NaGxWemR5dTIvbDVHMkNsMjMxcTZLRUY2V2J5eVFD?=
 =?utf-8?Q?hSp7Pe4eCHNoilm9hefoSIMBM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1432d42-1b18-4f11-53b7-08dc30ff25a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 03:59:19.0000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcZM7fyDKA/4K5CaBN7H3PRJp+gTczIwR9Zk1pcJauaSoeBASe5cH4zmA4TM2a39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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



On 2/18/2024 12:26 PM, Tao Zhou wrote:
> Add help function to query and reset RAS UTCL2 poison status.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index aace4594a603..de04006f8db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4329,10 +4329,24 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
>  	return r;
>  }
>  
> +static bool gfx_v9_4_3_query_uctl2_poison_status(struct amdgpu_device *adev)
> +{
> +	u32 status = 0;
> +	struct amdgpu_vmhub *hub;
> +
> +	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];

This only take care of the first instance. What about others?

Thanks,
Lijo
> +	status = RREG32(hub->vm_l2_pro_fault_status);
> +	/* reset page fault status */
> +	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
> +
> +	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
> +}
> +
>  struct amdgpu_gfx_ras gfx_v9_4_3_ras = {
>  	.ras_block = {
>  		.hw_ops = &gfx_v9_4_3_ras_ops,
>  		.ras_late_init = &gfx_v9_4_3_ras_late_init,
>  	},
>  	.enable_watchdog_timer = &gfx_v9_4_3_enable_watchdog_timer,
> +	.query_utcl2_poison_status = &gfx_v9_4_3_query_uctl2_poison_status,
>  };
