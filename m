Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DD8C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CFC10E910;
	Thu, 30 Jan 2025 09:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5xtioQc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E96FE10E910
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2gIXj4/aQl0V8Glq/2PqW0ViOhuFiDN9GDaLUXqkipHjVmP7CLqafN0AXpKnvq9GUqT2kS1+DcVBZYE9m52tf9AEoyuoa8/fqsOQMMX83RBqPUHMa+7pPyXoErjkoNmwPU2E8LY8QslY6iO93VPibH+veh7aAye+3zkvT3AZ3i7QkvCPks+hZ/H/LoBGtxlbDYFzlrw+Zs3qx7qbkVyPCw0MSD9jPZe2HO/4UlpvUQP7T1/noAAU0ogDyzMtMbF5il4jA1rkVSl7CF9GcXkMK+vf+hz6RaNAZBAAVZv+/lU0I+inPd9qWCvHsyf1kmp6gJ950QyFIUiYI+6vkHF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrf3xCFO4sp9pDm5FeU9kAzIyNDhNiARP/3c8UJOico=;
 b=WuZfSgKHJjHwDpJq9+53AXKkPUIIyWDdcsnBrcdBWuarncQmqEsz2Qysd0h6AtxfFV1SpelJIQpnZJ4dY2BxzCnezqeFPN6n/jyCketrXLeyCt2Fe9QSpZkhboDzB+1Gqd8lGpx5HwsTXClqrcNhty1BU69PrBlYsItNOwBrOYXZq8r+bB6mTKFo7vi+whT1PxPahRCzV7wSNq7IxpSehMVR9hCwxdjGB8JfRbjvgrBU3VRVgOqASJ0XmOpl0qB44TiADEFFw4mTxoHmzFfKGYX6VCL19ooqt9q4TyeyTfOVQgGNVkc7ZAW4f32N2lKVHUQGiXZTAYxjwehMssrw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrf3xCFO4sp9pDm5FeU9kAzIyNDhNiARP/3c8UJOico=;
 b=n5xtioQcR32m5VUCVnpBj16plyM213FGI+w5JWzjVSdQBpJ8nrrfhyidoCIbeLXw6uhj3vD86aZdeUkGxugfH2+ysG3qcZsovp2ufJI4DjSBOfXoWiouOahsuc+d13udTB8ZkivK7D+7ZfyV4dJnzaq7AdntoLcT/F+AOtgvEDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:43:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.027; Thu, 30 Jan 2025
 09:43:41 +0000
Message-ID: <9fe99ecb-0099-4913-9290-3832633eb8a2@amd.com>
Date: Thu, 30 Jan 2025 15:13:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable the attributes for vb flashing
To: Mangesh Gadre <Mangesh.Gadre@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Cc: Shiwu Zhang <shiwu.zhang@amd.com>
References: <20250130073759.2219240-1-Mangesh.Gadre@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250130073759.2219240-1-Mangesh.Gadre@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 7992e5ff-63bb-4ebe-d67e-08dd41129448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTltaUZlaWN2b3NWaFkrUWFKeE5PaXo2NXRqZVdaajZkUncvRHdnREhSK2h2?=
 =?utf-8?B?NmJyT1E2SlBYR0JadjJVUWcxMkc1YXRKRFRoTmtTcnJyV1dYWlljTHFna0Ez?=
 =?utf-8?B?S1FqZklheFhuWUtXZjFsM0d5OGcya3dmbmI0cFh0elZyYVRuMG1HWU5kNXBC?=
 =?utf-8?B?dVhPNlQxR2dFemhneWxqdDJwRWdQNjgraUo2S2l4SGtRTERzYklNTTVHQ0hJ?=
 =?utf-8?B?WkdMTmZFUGhKNUFxTXVnclRMSUZtVXlBK2ltbGZJODdYMTUzbnptMWZ6VjNw?=
 =?utf-8?B?aThoZzYvUnhlTHQ3UzBOY2tUTEg0cXpWY0dGaVJ4L1dQbFFMT2htb0p4Z1A4?=
 =?utf-8?B?clJpRmNvSFE2c0VuZGl3M3pPK2drd1NUSFN6MUJZNU54UThyM1N3ZVpnWnV3?=
 =?utf-8?B?aDY5UXgxR1dvWkx5NUFzZXlNZmhsekFDVWdYQy90bWdnOERyanRNWS91NDU5?=
 =?utf-8?B?eUNFY1VaL1dBeWxkTG1tWWF2SUlyajlEVThyaFNNUllvNHhFRFFCa1kwdkpH?=
 =?utf-8?B?UkhzR1lMYU1RNkw4bW1tTW9KVzNFU0RGY0wreTM3dnhLSGJuc0JYK2VlMjY0?=
 =?utf-8?B?MzUzTkhZMjlLanBFVHpKcytWbjF2b3VBS0pZb01kQ1k1ZXFRTUFNbXhtM1R4?=
 =?utf-8?B?T3FPbkw0M0w1amtXdys2RFdkQ3hHRnVnZnpXZ3FIazVDUW9WSUFHUFl5VW0x?=
 =?utf-8?B?VHNYTTF6dGNBbExNQmlXWGFhMjR3UEw0WXVudWEvU0swa24xbGRYYzBaTzl1?=
 =?utf-8?B?bzJtdVowT1lsWUVxREtXd0toRGVLMTI3eHRqWUl0Vms0UURBOGxiVjlGc2Zk?=
 =?utf-8?B?bTNQa2tCZVFsZHdObXBOYms2S3J3TFlKKzJiVjBMblArZFJWS2cyRy92VSsv?=
 =?utf-8?B?UEVVaDVFOGxhVTgvWmQvbnhuNDZpeXNDNkx1R3VreUNJTHJvbUhVOTZ3M1Bq?=
 =?utf-8?B?eUFZOEN2L0laUmpqMEpaQ1M0QVFHZGRGOFFQS3VLU2E3b05XYnhiZy8xcHB1?=
 =?utf-8?B?Y0ptQk81bGdCcWZNODhXU0VNbEhLdXZadkVQLzRJZlNEZzRWZzlWME9aQnN1?=
 =?utf-8?B?aUxTS3l0WStBZ3NvclVvQm5VeTFFUW5UYmhnK041Q0dDa3NQUHB4STZhUlg0?=
 =?utf-8?B?SU51K3FwM2o1cmxKa3hxMW9zUy9vbktWZHpHcWFuL01hQTM1a09kMXUxeExz?=
 =?utf-8?B?SkhTcGR3cUFxd0t5VG50bmhUWENHYlQzSmpKbXZZM0ZsT2JxK0llaStibzZK?=
 =?utf-8?B?TnlOYzFKOU45ZFczcVY1b0phSktZNzJ4YnFDMjRwdTVxQVFSam1KaW84cllC?=
 =?utf-8?B?S245RkIzVzBkR1grNno3b2N6Y0ZIQkJ3T2U0c09oK3JuRGhUdDREemFqcFRv?=
 =?utf-8?B?UlM0NEdNQ0s3RTVkSFUzU0xheVdZS3Z4WGhkY3ZYc2NnakJUYTVTRDBpVFk2?=
 =?utf-8?B?SjB0YjRiM1BRaHIzN0VxbjQxWDJDZzd1STFXKzBTUVowT3NYc3JpSGhpMy8r?=
 =?utf-8?B?dnpqdzlIcWtDOTZ1cDI3WnNYemRwUzllNllwS3pYUUt6YTc1dEc2Q0N5aUwx?=
 =?utf-8?B?NkMzaGYvbUlSWWVDR3FIRC9zUXphRVc3OXpMN3kzMFk1VVZCcDJqbThHV3FT?=
 =?utf-8?B?M0xwTUdtTlpMa0ZyRUNNOHRmSkJzZEJhM2cyd09tdER1RW9TeWFWVGMxc1VN?=
 =?utf-8?B?YlI3NlZCSjE2UWVkMFVuMWtKWG5JK2RDb0RqMkRZY3FTaUQwL1MwSVNsaGZk?=
 =?utf-8?B?UkxTa2tpOUluRGJnMjM5STNBbjc0Q2syRDY5N1BtQlpJNGFsUkNiZSt3THp4?=
 =?utf-8?B?dXUvblJ0N25xeWM3d0dNQWJTZ1VFc3liaTVSOXpjY3V2WVVjV3oxS0RhK1A4?=
 =?utf-8?Q?PyHJFF0Sc4+uh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hycnhTbHhZM0JTSCtiR1NaVVFjVFd2ZFJ3Znc0MHVjVEMyWit5VHltODho?=
 =?utf-8?B?T1hYNmFwbmk5c1VyRmFrR29GbTBiRTNCNHVpclVNSWVqZDhQVmk3L3NIOGhx?=
 =?utf-8?B?bXMvbkdnM1BuVlpmNXhHUitMbklpYUFFQ2RJSGM2Wm5zaEdwZGZ4QThBcnEv?=
 =?utf-8?B?SEVZbXZEb0xyeEdCVDVheWErNGpoa01GbElZVExLd3I1czVVTkZHVkZWdVlP?=
 =?utf-8?B?ZmZZL25SczhwYUpsU1N6L00wUGJnUStoQTBJL00yWmpuRW9WcnRDSVJmVzBq?=
 =?utf-8?B?bkp3TU9jbXZya2NHNkJsOFZCbmRWemVMZ3JmS01vdXFwZFJLVVVobW5RSytt?=
 =?utf-8?B?L1QvTWNhNGRvcm5xTEZaTGRqMWozdUN6a2t3dEQwbk80WjZuUXRlU0txTlZW?=
 =?utf-8?B?bjZVOWMvdzAvcDhxUGhraVJIV2xOVE9qTDY2dGhqYmFPbzNqYmIvZy9BVzZ6?=
 =?utf-8?B?ZEhWeDRhS2FSbnNqRGI5TGJNekc4dEpzNkxyUWkvYmZMWE1UamlwN2p4akVR?=
 =?utf-8?B?UmN6Q3R4MGNyMWZxbmdFVUhBeWttRzRwL2R4MDNjU3BPU0p3cDZRQ0Zzc242?=
 =?utf-8?B?dHdySDdjYURmYzdJd1hiZnQwNFFGM0QvVExYanJROTFTTDJxai9UZFg3Z0Fv?=
 =?utf-8?B?U2VTYnFNbFQ1dnFtbkJubm1YVktBSDYwSWt3MDNqd01XSDFGc3hqWHVDVTht?=
 =?utf-8?B?T2ZxdEJBSk5FSktOSGgwL29iSUplWUZBdUlJRUV5NW41MTJNZXNlOFZjWCtW?=
 =?utf-8?B?djRMYUZvQzJnMDVzSFIxandUVDM0QStlblIwUkpPRjkvb3dpRjBCOGNtOU1m?=
 =?utf-8?B?NlVhMnVKNTZsNi8xNlUxbTQzQjhBVTB4Vnh0NDg3WlBFMFlVdjRZeUVrSWJm?=
 =?utf-8?B?Y2pRaW9zZmxvL1BHU2VlR0FwTGsyMjArYWtoTWxVVGJlTVQxbTdMZWo2Smho?=
 =?utf-8?B?T0pOUUppVjhzc3hoN3ZRM2dTM0lWejUrYU5zNmxrVDlYV2ptRVR1Tnd4SlEy?=
 =?utf-8?B?THA2eVFJVDZ2cEN4czNnNXBSeDlLcGpPTERxWkdXS0VHazMrMTN3bE5VU3pR?=
 =?utf-8?B?TlphRXV1ZUV0YnNuRUJvS3VTQ0R2ZS92MHFBMGpFbkFXSm15SUFmMmE3MGxh?=
 =?utf-8?B?YSt1Q2lXZ2VPU0Z2YmRseHNLZlRpNEprUm02dlFPbnpRaXFlU09rSTRZRUND?=
 =?utf-8?B?OENvbGswNjVKTmZjUisrM29uam1jc2dHN3k0V2x4M2dXdXhkbnkyK1gwWk8y?=
 =?utf-8?B?ZHM4VHJFM0puQ3I1dnlBeGk0WkpxQm9YWW9EcFlWUEVRbmt5RjNHSGIwc01u?=
 =?utf-8?B?dlNlcHlBYitMZHFHOVhnMThlb1MrRnErYzdZSFlkN3NZQXJYeFp1ZWwvNXg2?=
 =?utf-8?B?bjRsang2cGF0WkV3b0JrMlpYODlaU1FUdFFuakdQVm1iUWduaG9vRXVOZU5l?=
 =?utf-8?B?MzFFc0dXTzZLYzA3dkgrOCtDMU9BTXgrSWFSNjU5ZjBUZDVuNEhIbjFhajd2?=
 =?utf-8?B?MFpDeFhoM3A2bUR3Rll3UVpMZzNUNVZ2RUpRVlRDWDM3ZVRuUHJydTRlTlV4?=
 =?utf-8?B?VmpSK1Fpc0MrelFUZGp4d2xHcWIvdSt3UldIZC96Y0xTaUhRS0FnN3dHbmJD?=
 =?utf-8?B?WWhOSzQ2WUYrOWsrUDFuMjd4dFl3MVZXYlJNMTBVZllNcytIU1FlaDJjQldQ?=
 =?utf-8?B?T1BBNEtmMVY1SWRwZ1cra2tHdGxaOXNZY01meXZsdDVQYXo3d1F4VDdOUjRE?=
 =?utf-8?B?UmtVQnFwekRmM1R4NENqWmFHZCs4ZTN4UGlKSjBhM0hHZzhtK2JOYkZSc0ta?=
 =?utf-8?B?blJDZG45SXNrd2FLUTF1VmVYUURRS2NVVVZhRTlVUzArblJJbkdldW9aSWZx?=
 =?utf-8?B?LzBBYkxUN0EyV2xKdHJpSlBWdnUzNDBkTUZXMWFnOEN1a0lkTFBmKzE4S2dt?=
 =?utf-8?B?a09SRUV3Y3l0ZmRzZ21kZ2NvcFhUYSs4N2xNMkpFUHc1bFRmY1FuN2VpM1R4?=
 =?utf-8?B?dzdPOUJsdnJlYTZQNi92MWdTRk5NbExUQ3RCWTVlZ0VMalFkS25aSU1JcDZk?=
 =?utf-8?B?UGdoZFBScDhCZHJROGFLckFkdlR1akN2cG9NeE04YjFEZ0hXc1owaUtOMEhO?=
 =?utf-8?Q?FmhzZ3UeBiQQi6kCxXXG5mb6D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7992e5ff-63bb-4ebe-d67e-08dd41129448
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:43:41.3188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLW4TMzxpolMhwUpSE/YFWMy1V5D+cOIpFsuuV4cEzGzz6LUOsavxJv5sHwFntbd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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



On 1/30/2025 1:07 PM, Mangesh Gadre wrote:
> From: Shiwu Zhang <shiwu.zhang@amd.com>
> 
> Make psp_vbflash_status and psp_vbflash available in sysfs
> 

Suggest to keep subject like

	Enable IFWI update support with PSPv13.0.12

With that,
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 4c794e8ca7bd..b531adfb4f57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -208,11 +208,15 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
>  		psp->boot_time_tmr = false;
>  		fallthrough;
>  	case IP_VERSION(13, 0, 6):
> -	case IP_VERSION(13, 0, 12):
>  	case IP_VERSION(13, 0, 14):
>  		psp_v13_0_set_psp_funcs(psp);
>  		psp->autoload_supported = false;
>  		break;
> +	case IP_VERSION(13, 0, 12):
> +		psp_v13_0_set_psp_funcs(psp);
> +		psp->autoload_supported = false;
> +		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
> +		break;
>  	case IP_VERSION(13, 0, 1):
>  	case IP_VERSION(13, 0, 3):
>  	case IP_VERSION(13, 0, 5):

