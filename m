Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32C3D132DE
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 15:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8512E10E2B9;
	Mon,  4 Nov 2024 15:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aqJZ4X62";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E362F10E2B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 15:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRJB1ZRFwmlBJ585HTZUqz9aOFbsxExOqHmb3DAexprim/sFCX4qe72Jaolp6hDt/DmRiPIiGAGkVVDoJbM3+fGueFE3imO9smNhNsHbodQbRZdTAXc0DXQCtHepshySVq/N53OykAxje3tVp6QlmcrzKKD3/ki+7BcTGrBf0IYMmwXljdrDMkEshfNGGB6tNNDw+PNgtIv66awuuSiErmW9NUspSAR3CD8Q0DVS3WX9Vj7djJ/cKM5Ikobtw1eKv+SgnSZu8vNE6Cq0zrkbgtSsjVYqCpqTDM/p1n2e9gYU5Oadqys4pXgzmxjL+QO3JFZiO2LTKZeTCGWO8NELuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHa/hnUsoKA22bJRvAxc16MvJvYh96qk1S5/ywzHunU=;
 b=mTZHzfjR7g7G+BmKLw/PZ1iiEB4CTXmMMaHmQNQq3ewxB7rT8cWf+yIbHkYUFRns56H8FjeEioLJ/LscP5x+/zCVEbl3OTn5MD1c5CGan1AQCrlvbaL1Q3cY6HV/v9QRPYOLgJAdgN+MHoQJc+6iMV74iiOnQouhyZDcoOwwmmK2lqN4CDctdr+8s8mnHnf5VhcXtk5qpfGLPFo3MrYm9XE9iR7IM8IjIAz5CMY3zXJSc8ACOVVIn/h6PZaI8E/f0Kdi0PrkCP+XBvAX9Sv0A1K6QFFWkx2jqiYW77Mb+yoPGMfcY+Fq9dZcgjp4qW2ifVM9dCnoUN6yihZRR9iRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHa/hnUsoKA22bJRvAxc16MvJvYh96qk1S5/ywzHunU=;
 b=aqJZ4X62rhL/FwmuLOMecqFP73pZf227Nca7jXWxjMB/1TuMfzUMVJHTl6o5tIDUm/iWk3K0iUFjgRn5ycfH4ifQYQYUlkrlYpshw62FxH7uxiLAaP3FVRhYox0YV0RB+nyuQq3ipCOJIzaJeYbmIxryVFFn8SMdgLNh/UX03jY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 15:24:56 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:24:56 +0000
Message-ID: <16d5e4dc-183c-4948-bf3f-6a9f009f3a0d@amd.com>
Date: Mon, 4 Nov 2024 20:54:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: fetch fw version from firmware header
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241104152110.1470163-1-alexander.deucher@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20241104152110.1470163-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb6ef92-07ca-4c0a-36e3-08dcfce4d63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?di9FZHVRTmtKNnp0YmVVaWxQYWVUS1VWblB2TlNiY3dUY3VZWTR5aCtRUXBM?=
 =?utf-8?B?ckxXWXUxdVlPdlRNMis4amVtMXk5ZUdXRWN2YXp5dXVBVitDNjdKdkM2b3d6?=
 =?utf-8?B?SjlKVXMvSEdsdHoySVRvUkJRRGJLWHFIL2MyTnFMdDNqTWpNcjhabUpMSjh5?=
 =?utf-8?B?TzdjdHR0a3dxLzM1aWZhQllrc2tUQ01tTThDN2VVVks3dnNBbndpQmEwWHZa?=
 =?utf-8?B?TUUySWhOOFkvQ2pIeGZaS2o2SE1uRENpRDF2OUY2WXdBSGJVTlptY0lTU2N2?=
 =?utf-8?B?UUhNU0xZSURBYlV1cVV6ZzZDRytrQWdxRWhRay9qUlREa2lxNU1tNWFSQ0tC?=
 =?utf-8?B?eG5LdWNvUTMyUGV5a08rVE9IZmJkQ3l1bzlsdGFJRWQxQm5tZnJDUDEwamNk?=
 =?utf-8?B?VUVRWkNnYyt1b0YxQXNBVmhIeFhhNWcvZEtNYSsrejJhbjBTNk16TTVHN0Jm?=
 =?utf-8?B?TkY1c1ZWOXR5R0xVTThnR2s3eUtDOERUellBT3o4SDdNcFNYVVZ2cWNoNHpu?=
 =?utf-8?B?S3lPUWU5Z1BnM28xaFpWeStWWG13cmtJYzhudkpXdVNjK1VZNlJwWGpRV1FH?=
 =?utf-8?B?elUrb3poR2dua09vaThkZFJwS09KRzdOMVU4a3pId29paEFyaG1sRHZQdWZs?=
 =?utf-8?B?ejNreTdQRmFmaWlIRlNGT2xScjBOT1B6bVExa3hqL3dwMlFEMXlOWjBKR083?=
 =?utf-8?B?SWE2TlIwOVJCSkdlbEZOa2hBZmtRaXBCZEc2eUY4OENSN3UreW1pN3F4RGhO?=
 =?utf-8?B?YzZxT2FWRGpDZXpjYkFSNFJMdUVGUFZxb1RaTjJZaTZJQTFLSU1MOWtOUERU?=
 =?utf-8?B?WldOMklKcjFkTzhyQzI0blg5akU5WjRxVmtlSGJ3Z2x1V09OZ2x0VUt2ZjhP?=
 =?utf-8?B?M3I4cWFwR0ttemZSVVU1ekRyc2lrSjlxVlZKWEliMGUzbVQwQjRMY3VySW5a?=
 =?utf-8?B?dFBlQllUeXhtQVZZTjV0bFRyZlNNUVVOTWdIWGs4L0F3alNBa2xOdWFreWtI?=
 =?utf-8?B?WUFXbk15Q2EvYllpeDdnT1p5K2ZOSVNNTmpaMFUvbC9vcUZNQzFPN3BBVk1H?=
 =?utf-8?B?ZlRzVmkrSGcxams2RnAxeDhkUXBmb0VURmNNanpCaHQ4MEMvcFBVLzBNOSt5?=
 =?utf-8?B?MnpMY2FqWERocXYyT1N2N3pVZHB0V2NvMEhlM0V2NUlYZFNkaklMdzdsYlJH?=
 =?utf-8?B?N2dQT0pNVitkUE1nT0UrbXFleEV2UnB0Z25sNnlLTjlxRVk0TTdDcUluemd4?=
 =?utf-8?B?WVVlMDk1WThYRmVXNDBmSkxVR3phU0VOaUNYd2ZFT1FMeUlvUFhBeDRPSStK?=
 =?utf-8?B?b0tYS2phQ2FqSDk1cGgwaStaNW40YzhlcFlxazNzeDJSZTg4cytPMWpSVElj?=
 =?utf-8?B?Zld2NUNyZjU4ZmZQZjBGa3AyQXZuWGxYQ1R3RjNxQTdmeE1KaWoyN3NKUGtB?=
 =?utf-8?B?YkhTTnNic01KWVNWSHhmTHVENkdvQmEvZ3dMQU9TNjhsaUlpWEljQmhoamxU?=
 =?utf-8?B?TVBEcXFrWXRTcGJteHE3bVlKSW9pYjJRTFVXdlRzMjUxMURjc3EyaUUwVE5q?=
 =?utf-8?B?azhaUC91YkVBakhUY1RTTlRwSzZvdm1Za3JBdHBSNUhWby9vV21xZVo4QmMr?=
 =?utf-8?B?SlYyTlJNWkUrZUZ3V3p0VDh3dlNva2ZsajQvTGxWZHFKZDJtNHFFMnFXTFlB?=
 =?utf-8?B?a1krZEdGNjBUZ0ZkVlcrVkltQ1hUZ3U4b1hLbW9rMzM5NVZ2WjJwRXh1UWJy?=
 =?utf-8?Q?VB1hqzEcuAcEJS+Win/KDK8Ueu8NAQD9rnvR0e2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1VtbDBNTWtkMGRtWWhhWkdDY3h2Z0RUS3Q1SnRKclJmSllvS2grV3RTbVZK?=
 =?utf-8?B?a0FnUThBODdwd0tHMlQ3dk45QlhaWFZTallWcDJ5dFRkdzRUTUxNSnBGb0oy?=
 =?utf-8?B?cXkwN3Mwb3o0bUd1bXA4T3dlK0ZyUDdkUUxQUnp4cTBaZFFRanJ2aTc3dlJJ?=
 =?utf-8?B?Q1hVcmtpTzRhWXFXbWVyTW1FZFQ1dzh2TGQyMEp4Y0plbElURHFkbW1yc1U4?=
 =?utf-8?B?ZkVVTEdHN29IRVpZK0V4UTROdU1UaDkvMmpUZmFLU2JoRE4zOEFOSlBSVEJk?=
 =?utf-8?B?KzNBWU56ZWs1V0tjZXp5VEkwUmJZTFF3cGw2d1IvTG51Zkt2enVJNHNrdXg5?=
 =?utf-8?B?eW9yaWF6ZFpENlFpU29wZmRrZ1NNcm05TThWZjVnODVLUUJJUXVtRE1UZ2g5?=
 =?utf-8?B?dWR0c2hnUDU5UC92dERxeVdUQWQzc2FXSFRCdzc2SktieWJRVStpdUpwaWlT?=
 =?utf-8?B?QWJISFdCaDVIdXFNazR3Ylk5Q0J0UFhGMXVpQ1dUY2ZwR25YeStwODNSVDJp?=
 =?utf-8?B?S0hUMlFTdXpQUmh1MUVOdXYxUHRiOEZKL0E5bzhKRm1Xb2lTYmVSc2xBZW83?=
 =?utf-8?B?REQ1Zjg5azZpTWtxeGZnaEZLRHVpV2RUekxId295dklqZHVna1lya3oxMGpJ?=
 =?utf-8?B?Rmc0bmdRaUp0OWlhdGprcUhPSzZYS0lwUThsL2dRRmxwS2p0VFZCNUZWT2dR?=
 =?utf-8?B?Nm5wVVRBTGtjWVFBdE0rQkYzK0FmSUp5UDdENHZQWTVnSCswdTk1UUZ3MGJN?=
 =?utf-8?B?bnFKL3BOdUdRelVRTzk2Vlczelo3TldIeEtVVVJOQVZXVDZsS2xlS1JSbEk4?=
 =?utf-8?B?WmdNaDJFbVN4UXYzZmdXTWNRRWpUQmdycDJ1KzRxU0d4ZlZLektvVCs3L3pR?=
 =?utf-8?B?T1V4SldyTDY2aGpEbDkxbFB5L3VsZjBsd0lReDN6dWhtZXRZU1hEekc2Lzd6?=
 =?utf-8?B?cW9peTlPTzlTV1BLZEZEL1VBcU8xZk85SzdONW5zK3ZEL3dVWENtS2RoK2F1?=
 =?utf-8?B?UXJ5Rk91ZlE5cFJkUlg3amp3OXZOTUdFRnlHTmFRMVZtZmhDR3RSTzdQVVMw?=
 =?utf-8?B?VkszR2VMOXpGZnlxNW85TnVrdUlTY1FmdkJYUE80UGJ3S3QyaXl3OUlRN2xi?=
 =?utf-8?B?L0dLREpXNUxkUTNlVWJDVnd4TDVmSkowZzR1RnVmUG5RSW1Kc3VUbUtaRStK?=
 =?utf-8?B?bTRjWW55VjZxTHM3ZHhoNkU0RHdHS2owM0Q0TmRMenBFSFBSb3VNVkp6U0Rw?=
 =?utf-8?B?cEhWS21KMHVTY212RFB5RzhpTnhRV1oyRWtkdlJoQzIxeGxnandDN0Yxd05j?=
 =?utf-8?B?RzFWUCtxUkxsQ1lXY0M5aDB0RzJnSG5tUlZ0bzl6VVowQlc1Q3M1eStFMHpQ?=
 =?utf-8?B?YlRDcDRPYzVzMVVZY0YyOUZqZzRaT3cyV21sOHJycEM2cEVUQXh0S253K1VT?=
 =?utf-8?B?U2Y0ZkNmTC8wby8rM21MZEszeFQyZUl1WHZJT0d5cTVHQno5ZGxJM2lDM3JO?=
 =?utf-8?B?b3NQc2IzRFprNUI5OG5tazF2ckh4ZkV5dDR3RDE4ZUVIUTkyZmlTVVRxb1BE?=
 =?utf-8?B?RGR4Q3lRRkYvMGQySmFYdlhqUW5oRHcxV0Q1Y2tGajBGU2h0a1dWekhLQVlT?=
 =?utf-8?B?SnZrK2pxY244cS9kTkdVSG5CTUU5bTV3T0J2WVorTnNIeXYyeUxuN0VKV04w?=
 =?utf-8?B?LzlCa2lHeGY2cW9weTBGS3htRFMwazhiT0ZmS0M0R1dkU3U0Y05mTWUzdTJs?=
 =?utf-8?B?TUpWWE1peEs1SXZUazhSUUx5SjFzNnIxWTMrZkdtQ29JT1k5Titkc3hhQnVh?=
 =?utf-8?B?U0ZwS05vakRucHpaOUc0QXRMTXdIaXI1SUJUeXh0eEwwbGNRZkR1akhsajE4?=
 =?utf-8?B?S0UxSGl2dHhDZ3gxSXV1ZXVnRVZleFVlQ3NFYVNQTDdmSktWNE44L1ZNb2RO?=
 =?utf-8?B?TnhjQmJMVHZ6bHU2WHBXRU54YlJOVFFBQTdFOWgxeXYyR042VEt6WldvVVB2?=
 =?utf-8?B?QjEzd2FTeXZydHJNaytONUFLTmV5UExsTUxHbWpqRzVlRGVXYU9KMUs2cmpq?=
 =?utf-8?B?SHpLbXlYaWRQL3hMN2FHZWdqVGl5R09XUGNGS0ZBWW80L2ZQdytkeXhSOTRF?=
 =?utf-8?Q?ITo1DWjgkR2Bm07Fgo3cv8VkY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb6ef92-07ca-4c0a-36e3-08dcfce4d63d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:24:56.0813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfYe0X8nNjwcrvmrVmTUdsZqv71D+F/RxmA8pxu1Jbgymc6YbLqcpN0lN26101IaaKhhooz165PjG45b8505lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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


On 11/4/2024 8:51 PM, Alex Deucher wrote:
> We need this prior to the firmware being loaded so fetch
> from the header.
>
> v2: fetch directly from the firmware
> v3: store both fw versions
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 83d0f731fb65..dc751bdac2cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1591,6 +1591,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>   	char ucode_prefix[30];
>   	char fw_name[50];
>   	bool need_retry = false;
> +	u32 *ucode_ptr;
>   	int r;
>   
>   	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
> @@ -1628,6 +1629,10 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>   	adev->mes.data_start_addr[pipe] =
>   		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
>   		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
> +	ucode_ptr = (u32 *)(adev->mes.fw[pipe]->data +
> +			  sizeof(union amdgpu_firmware_header));
> +	adev->mes.fw_version[pipe] =
> +		le32_to_cpu(ucode_ptr[24]) & AMDGPU_MES_VERSION_MASK;
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		int ucode, ucode_data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 45e3508f0f8e..56f36182c9ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -75,6 +75,7 @@ struct amdgpu_mes {
>   
>   	uint32_t			sched_version;
>   	uint32_t			kiq_version;
> +	uint32_t			fw_version[AMDGPU_MAX_MES_PIPES];
>   	bool                            enable_legacy_queue_map;
>   
>   	uint32_t                        total_max_queue;

This is really needed to extract MES fw version, before fw gets loaded.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

