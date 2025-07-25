Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB382C87FCF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 18:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402BE10E220;
	Fri, 25 Jul 2025 18:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pd7RjO02";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5016F10E096
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 18:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQvveYgvwmFxhclNdkZerCTDT6bDNuckcqlPkDEH/I7tFw8u/9ZzTm9P0MonaNEmCi75ZeefjiHo2rtb5Y66kmrga66VI1JEADhVye3X8lDPr8pKqhx11cQuOsGGhBkh2VC1dUDhJzwACb1LvxW5moiCDF1VZAXE89tfyK8iBO4DvH7477weokAHU+cuZUJGce6wLkdmrOyspNYQu+iFgEa4wrTDTvbQjRnxzXriR+sFHdKAMOrteiovJvlpwSflXXA34uthaI/355nWuhLSt5csGF8IyDHA+FmEyOpS/pgQcpYRtfmTOMVtZQxrLTwFECoUrXJmUwLV5tKZOoyh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTZ6QOCqLAVNAitcyIOxqk8DQigleyMxzfZNRjWk6x0=;
 b=lP4b0/FnXC25ot0VnYw1RgVS0vv81WsJXHTr3uFO7xMt/Ahs8crQuxLfheTaoDl+moasuMwTEgbEFXrJhwzmjzuNMCMCq5Azowj4bhHFOpjpaa6zQNLhRPcUafEFzwhDsNgnoJR2S9xClzLHpu2eqxXckbuD9DB7Tpu+2Cujr6TzBiHBWGbwGazk0m+7N8rfMqy+x1ZKy1hRUoQigKqKe7zGxgztUpYbL8qd1WRd2qYdlU/pSkHAwJ/4yRwCQQG2lg47VUHQUyY/5K951eCkXDQCyofntUQFPweDrizMswgok/kQSxsI3OLojp3UXTnOPgQzqBL2Feg1hrtIbJBB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTZ6QOCqLAVNAitcyIOxqk8DQigleyMxzfZNRjWk6x0=;
 b=Pd7RjO02Hc+aGVTJtiebpDTqYvnn2XVG6W5XPLPmUbrKeMPKszggHyd8UxUQfpMqk6vgdavO/rsW4BGc3f6BT461Z1c060lOVeD6MxNEkyHm0Z3+FI3ICzgP6cxIpw3C6hN4Jp+izxOeOi/cjxVhfUqx2U4ZCpCptf+jrGoMkOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 25 Jul
 2025 18:29:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 18:29:53 +0000
Message-ID: <845454a8-ee23-48b0-9a5d-5fd98d353b82@amd.com>
Date: Fri, 25 Jul 2025 14:29:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect mask used in gfx12
To: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
References: <20250725165303.187520-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250725165303.187520-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f0521b-af03-4561-068e-08ddcba93fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nks0YkZXZjFUYW5INjhTQ3JqS1JFcTVsSDQzL05wbnVHUDJYTitjT0pWVHNz?=
 =?utf-8?B?NTdCY3hlemJZbWdLSVRnQk5ZWDk1TmJjYmZPeERLSU9HYnY1R3FMR2VvaHYy?=
 =?utf-8?B?M1dqWG5vOWI5aUo4cTlONlZ5cjhMUWZoM3ZBTWhGalE1ejMrcFVlWmU0Sld5?=
 =?utf-8?B?TDlvUXk3OFpUNUFwRFAvVnpsWUFqYnNUMzdtZUFwc3VYL1lMN09laEY5NFpl?=
 =?utf-8?B?RjV6aUJJK1c3Uzc5d2dsS2FNSFNGbE9xYm9CZmtBTkhnT3hLbDU0aWFVRG5G?=
 =?utf-8?B?bzdwSDNXMXBrSXMxWE9lT0U1a0xoK1ZFVyttVkwxYm53bzdlMU9SMkRZWVVK?=
 =?utf-8?B?cWJNYTNpSGhBbzNON1VtMmpDNTNsZVF3amxoeDM5Y2dSMWl6N3lRdkd3bHhy?=
 =?utf-8?B?eklXK25qNThtY0xxZk96S2N0RmhNUG1wV3c3K1hyd3RYWHNuY2tJZVQyZkxt?=
 =?utf-8?B?MEtENDRITWp4NmdNOGlNelhQbnd5K3VxNEp0U1hpMTU2SzVLQ3crQllWanhJ?=
 =?utf-8?B?YkYzUEFaMTBBemxHWmZVd2I5SmVkWG90UlZnb3RUNURFSS9BVGZ3eFBNSTNO?=
 =?utf-8?B?Vm8rYVBSVW9QN2ZBM2ZaMHp0bzNLTGFUVkJFVysyTEgraFkxNE51MDgwL2NB?=
 =?utf-8?B?ZXZNa0trNE5jdmRCbEprQWxrdDYxTHZHVFZxR2VUUENRMUNFaXJheFNzUmNr?=
 =?utf-8?B?dCtxZG5MMXhQZXYzMUJnSkloYTZJUEg5Z09pUTdId3hPVzcwR2Y0VFJFdUZK?=
 =?utf-8?B?OUNtVHNNVDJuWXNWODVoZTloNVN6RGR0NWsrWWlTZllhVkxCTGx5YlNiTUNq?=
 =?utf-8?B?NFk0bmMyQjNpU0R4K1ZPU3NvOXNFNzhLUWdndGR5NjRHVGpnOFdKbisvdGxL?=
 =?utf-8?B?czAyMm9ZQUNsVnZaSFZNOVRTUG1VSFgvUEp4ZzJlazNKbXp0bFp3c3ZtZ2lW?=
 =?utf-8?B?b01uOFdxSmlQZ25GNmh3YmNHOTdCNFhBMC85dVJRT2N0OVVHbkxBK2RtM05V?=
 =?utf-8?B?d3N3RXBHSEJ2QWlScHRDZy9sQVJzWXFBZVpabmtrK2hQVVdTWG1lUVViT08z?=
 =?utf-8?B?emhwQlBYY21QOEhNWVp4TW1MY3FCbEpDY3Q3VyttdjNvb0tiMzNDUElybHVo?=
 =?utf-8?B?Nm1mOU9QeXoxL3lEbmdmRURYaDBIcUJrZ2RvSEQ3RHJyL0VCTEVHcnAvdEVW?=
 =?utf-8?B?S3VHTkh0b3dxMy82K05PaS9aWi9hcVVFVEtXNE5KZVNWaVlTV2RSaGpsNzhU?=
 =?utf-8?B?YnhCMG1DTEVTVDl4cG1TWEp2M0VZVU1yMXB4OEVWNXFUbUtZRXl5b0pwemJl?=
 =?utf-8?B?NVBmNmt2cEw2clJ5WEpRNFloZGQ3NGVrdlBSS2xGRUtOeFdtdFp3M3RJbXU5?=
 =?utf-8?B?dEl0UTZVZ2VxSGkrZUV1c0g3R1lzR2FYd2lyVXJpRHB5M2UvU1FtSzlTUDFM?=
 =?utf-8?B?K29sNk85UXpwVHNjRVR4T0l0Y1FYTE1WZ2lySmU1WWFpTEY1SHg2TTZJUnFn?=
 =?utf-8?B?YTJycTI5Z29yL2poY21CZUFwUFR2VkF2TFZpWXZpcmFrUlloU09yMWVweXFx?=
 =?utf-8?B?d1piTXNjQjlXNXpJbFNha2NxWFI4Wm0wUnFQRk1JYWJMQXE4RlozM1BVV09M?=
 =?utf-8?B?Mkd2K1JtZ2hnRWQvbUZnQVd1eWZLVk5VUkMvbS9oQ3VaMVZ0NHJFd0c5ODhU?=
 =?utf-8?B?WnpmL2tUUEgxZVA3MXJERkRCS1VVeE1zb1FUVnJ4ZkpBeDdGaDNhNW43anV4?=
 =?utf-8?B?eDFNN2gyWFpuRWV5V3pLamZtNk44Njc3MWR1M0RIRzBGbG94MXJCUnRjTTNZ?=
 =?utf-8?B?NGIxUzd6bjRXcXFENXEwaWZERTJnUlZKZERPNUl1clBXSkpxMEdxTTVRSkJE?=
 =?utf-8?B?VzlqaVBRZlFCUmhTUlRaekhYVW5Kc2xNRGVrUGdDS1p6Y2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lpNXdGdC8xSks4ZEdHMHorR3lkUW45d09TaUw3aWNkcTVoYlFRN2hyMFNJ?=
 =?utf-8?B?ckRYN0MyY2tlank4NHdtV3VyMFIxQ21YOU9IM3d2eDN0b2FtNWVlcGFiSHVo?=
 =?utf-8?B?ZktmT2xlbUtVL2cyNFMzQ2hxUGdiaEJaTGxlMFFXNytvZit0TVgzdEdJTnUv?=
 =?utf-8?B?TUY0SGsvNnRZdjd0RS9URDIrVy9Td2R2RXdPNE1jU2hDUlVhTTYya3NzMEw3?=
 =?utf-8?B?Sk11VW5rRWNvNWs3aHdoYUZydjhyNVRXYzJCN25oNFNyMTc3VDNuVzQzbld4?=
 =?utf-8?B?TitscmJROFlaUUkwRzVUVm9mRnN4LzdwaHYxU3BnaDRoamJtMFhMd3JwNTlC?=
 =?utf-8?B?N2dUOU1yM29vNFJDdkwvYVVZWjdTTER5bkp2VXhmTlhpTWNYUFpqeFphY2RT?=
 =?utf-8?B?RVVVMXJyd2dUV2o0WVZCcDY3NnRGZ1RBcFAreWJFaUV4UnhoYVZHQ29qUzZv?=
 =?utf-8?B?ZzZDM1dVNGtVblowTVNpMWNET0dLYnVnSjdleFJjcDdFTFlKT014YUkvOEd1?=
 =?utf-8?B?OWNoOTBYRmtqYS8rcU90T2hXYzdZUUwrUHFZdG5TVmo4VEZwNUJQRXNncjg3?=
 =?utf-8?B?OHFiNkV3VURqM2NjNmtUUk5iRjJNS29YM1pkM0xGRWdMYmd3cFZOYm9GMStU?=
 =?utf-8?B?cjdFOEhkbSs1ajFxZDVCRkpwdHM0Zmxhc2RGWnV2eFZybWgwNk1nbDdUVDNI?=
 =?utf-8?B?SVM2RXR0endQU2N0UVNuaXdHbHRIdmhxdHBJQVFWSkpRZUVmK0gvRE00TTBR?=
 =?utf-8?B?L2llck5vUE5YQWdlR1oyTDFxMlNUZWd6ckRSN09UZjVNSTNpUTR1R2pUdnhK?=
 =?utf-8?B?My95ZzJ5STNObXB4N2xkVHZKWllRTCtIWFRlUlBRMEtLQ0cwZWZDZ1NIZGty?=
 =?utf-8?B?Z2QwdC9IOStxa2wvOWh4RUJDT29zakRuYUh5NTAwTzZtNEIrTWRxVzZxMHZk?=
 =?utf-8?B?MW12YU5VRDhoN0tmRW15WWs3Y1lHa0tQa2hQTktKRm5BbkRya0xUVjd4TDE2?=
 =?utf-8?B?WmpySTlZZEorRDRDNGxKYlRyODU4Uzd3QzRwVmsrekdDai9ocXgxRUtEeEVQ?=
 =?utf-8?B?cUlEZnFHNTZ3TjUxL254NEtzZ0NHc2w2NjVNcDYzRUlQdVFoamlidTB1cVhi?=
 =?utf-8?B?SnUrWGdMRTNjL2hKUVpCVjMxSDRFUm8xMTdadGdHdkRXUC82YnBGTkdpcUt6?=
 =?utf-8?B?QlNKR0lPT0huWnpIT0pvNEhZVEMrOUhEVTJhcm1BQU9mbHlLekhqcndDM3Vj?=
 =?utf-8?B?d29KdE9xVFQwc3QxTWpnQmMvOFRRV2NzMWg1Ky9zL0ZtQmFZSDI2bHNDNTd1?=
 =?utf-8?B?ZmN6c0RySWZpQkpzSmwwNUxQYkowMmNyOWlXTlJhZE5UT1hiaG9JVVFZck5w?=
 =?utf-8?B?bHpIN1BQYVZhQ3BVRC9TN29zQWUrMHhEWFU1VW9SVVFQUGczaUZ4eDZ4Nmw0?=
 =?utf-8?B?cGV1bFkrcitPWFNVMFhNbXZtWGJId2FZemViQytMTVBYdkdkYklyTlZEVEg3?=
 =?utf-8?B?M2ZyaStKMHh4OWx3ZkkrdTgyR2FxbnBmd0dJMUtnUU82MTUvL05naFc0Z1Qv?=
 =?utf-8?B?b1RkbW9Id2tNS0NXcFVldk5vT2ZYeUlaalQrcU9QWThLc3pHN2lJRXZjM2lY?=
 =?utf-8?B?UDExbGlkb2RVYXFWUzl3cTN5UmdMMXpTamJpeVZqVXJBTHJVd0h5SkhmZ2Rk?=
 =?utf-8?B?eU1qOWxIeEtheWdnYnptVnpVdjJRZWNBWnc4a0RZTGdvYVdYaVVGRjE4WjZ5?=
 =?utf-8?B?d2lyaU16cGl5aTZWdTczc29UZUJiTzU5RVQxRllSSHdvUUJCQ2p3YXBlR05h?=
 =?utf-8?B?VG1ReHZ4WWZncC8wSHcyL3JwemRKTkRmeDRmeFVET0FvVzhzODZIQzlYdXZT?=
 =?utf-8?B?akNhcGswZDFjTXNHNlBZczVlbXc3RnZRKzJ3RXpYcDVLZXdMSEc3N244MVdn?=
 =?utf-8?B?cE1CclVIcTMySEZRdjJ2d3ZyeTJsUnhka1ZUaVdaTHhuR2U0Q2RkM0ZoazN3?=
 =?utf-8?B?Um9uNUMxaDVCVUZxb1JMQ3JEUkwzanNBbUd3OWhzTDg3WkN5OHo1NHhlZVBq?=
 =?utf-8?B?T2pXZkhsbTVPaGlaVVcreTFhRWNBUCtQS2hpVjFSVFdTZG0xNUQ2eWt3TE9l?=
 =?utf-8?Q?0x8+Z076/D4mkJ2z2agp5VeNQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f0521b-af03-4561-068e-08ddcba93fb9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:29:53.7091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I40/DcPBlI39vsFAEUYn3wy6p69zgKlE4WAiy2JdbtTgARMkvnV3zDPHmIugx3kcVPQ9uE461bj845nBz+Jfww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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

On 2025-07-25 12:53, Harish Kasiviswanathan wrote:
> NV10 mask used for gfx12. Fix it.
>
> Fixes: b8c76c59987a ("drm/amdgpu: rework how PTE flags are generated
> v3")
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index fb3fb31724a8..6260243012c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -517,7 +517,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>  			       AMDGPU_GEM_CREATE_EXT_COHERENT |
>  			       AMDGPU_GEM_CREATE_UNCACHED))
> -		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);

Thanks for spotting this. But I'm not sure if this is sufficient. The original code here looked like this:

    if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
        *flags |= AMDGPU_PTE_DCC;

    if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
        *flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);

The updated code still ignores AMDGPU_GEM_CREATE_GFX12_DCC. Given the symptoms (grey screen after suspend), the DCC flag seems relevant.

Christian's patch also changed the mtype for COHERENT and EXT_COHERENT memory allocations. Are we sure those should use MTYPE_UC on GFX12. I believe there was a workaround on GFX12 that required MTYPE_NC for most cases.

Regards,
  Felix


>  }
>  
>  static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
