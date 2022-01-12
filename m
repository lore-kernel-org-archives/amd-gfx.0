Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E1BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 07:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D54F10EFA7;
	Wed, 12 Jan 2022 07:00:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449AC10EF94
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 07:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd791PkZqyJsKtRp0YNPnf+6KASqn+WLRLxDKD46A9VpVohRkhe4eV+M/lLcQOHn494ldLFDWC6CMTIvmtoAG9ssXlD4YXPKrMODeDqzBHkgM3LkrkB4DUSBlkkfDAjKUN5XdLp5hnvv2mHbiHnihsJ+OLLucmTKp9bHdoOv0jYCRPOuRUFPw8xJy2FyGTciDzo2Kpe5FV2SkkH9sRQtbLaUFiR69DULlZXmi0IJw9RlfNM9qvN/Hnn0GuBKdTL7xNqySaC8oBHK0/fXq9K06N50oE+hTHo5vlw9WW85HJUMWcnTaZ/mZDfabYVeMAPe8pB5B8j1x0Co5lRAPzA8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI53NsO0tQJxtvYF1QKlTYKRG+UObfl2xcKCfd/jbeU=;
 b=F0hi761lLz68kGqePWS3Rb8R9xj+WnFIfhrUIaDOMpFFq4zcSasdrpgSfQA3Q0/87xghSrGPVy1dpdXsWt8/RD9t1i2JNUXKeORwmHfNDRSNCDQpAZ6nnYYTrkbyGRIa5i/mRCJvX1+Rw5sKdcTu4MblUz2XG7HxbgxqYggk5jGqKZp6NL8zpo/8x92VP41n+y+jtp5FSMg01f3zIkA24YVucl6im8l2m36QDVXVsq6/QRiDZibTpp0HTeq9eM3Xn9YQRvV1UlGvCIt+DdV4rzj4sqYJldsw23tBdNl5/ENFHV54Jcg8SicdZ3Z5fwm8ggaq2F4jAwCBCzZVl1oGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI53NsO0tQJxtvYF1QKlTYKRG+UObfl2xcKCfd/jbeU=;
 b=SUTZT+02owrDW8n/QF6q2oQZUNTydum4Ju3B+bKLYzRThHw613MyH/8ytHxwyTyKKDdKo4HkOpiwYkch4nP86YOhE1/rWzZ4v3tYcyK5y7XP/eSYZ3YXt0Tku8NU1dy9GK2tm9GL8C/HFmU42Zobrb4a007MgS1iu2VvYif8ilQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 07:00:15 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 07:00:15 +0000
Message-ID: <13f1822b-9723-e8d9-b3c7-9fe48bdf7cb4@amd.com>
Date: Wed, 12 Jan 2022 12:29:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220111124112.52884-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220111124112.52884-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29b84d10-3cdf-44fd-e0ce-08d9d5992efd
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47583AF4A1798317B0B2CD1797529@BYAPR12MB4758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOjcjpTKlhj0UZdz+JdfShRxDdXSh0FaXa0MJUNWOarVkcqmyKkCrcdOznYG7tGD4UZcWrEPVQ1t4SENu4BGoPsMfdZD1iHProiNRm5IDrU7wKO7kRmKR6ptgoCm7L127eDQvhLH/tF+PaiafPcK0iT3xNnBmarzmTZn79dSaKEtOPzOr68HnrTnW4Lh2O3QgUlqNeUXJXJEAraAlU2t4wCy4LCb8WsmtW/f5RmH2e88yyyjpp4FGTt2lnWliaZexDvH+wjmYq63buoqnxihmSh0vjIplfrD2GW9eAKJS5zmlS3jIYn03ww+gErnYzKpuzfj1Sp4QcW5aLNZWPZ4Oa56VAd/r5OUa4St0HNzY+6ycy/1CK4KbVpwn92XrrF6h99mDO+oZf22ZAjANVQflxpr7f5MeiPM+z4KtlqmD3wx/kH09BZK57Nl/ssK6bppvTe9EUDpj8uudutUh7UHzGtLKw4ENxePIwgbwzhFFZBCrdYGYGa8mDQuH3TbCNDSQLSV3m1pYdSdiBNBBbfkyIinLs/bS16B5okjozmhjYdSgEnkZg06nSqWPojBdEf3DNFEpt+rHUkusUU7fzAJ7q1ZkkToEwFovEtT2yy13prgHYSR9yG2fwGopNt1E48z+XhwApF43MsHDFzj90mN8ctOuFClcdyJDcGuyS6T3CNGFvhfPZA3bFwq6J4zyk4PCoHeFBo52+xZXLq5jxXOEj7JJHUas0RqZO2opsLDoI0SFLsV+mhEqqEJdEFIc45R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(6506007)(38100700002)(316002)(2906002)(508600001)(30864003)(66556008)(8676002)(2616005)(5660300002)(4326008)(83380400001)(186003)(26005)(6486002)(36756003)(66476007)(8936002)(31686004)(31696002)(6512007)(86362001)(6666004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnJ1YmVmTzZFTGdSbm0zZGtscXJwbWNFckxGa0lJcnBjQW9RNk1wN2VEaDFK?=
 =?utf-8?B?Q1BaVkhwUTNsTjJEcFI1WVdGYXZDQTZ3dFAvN21SZEFaM29PVFJBZCtGTkZT?=
 =?utf-8?B?UURVRlFuS200UUhKczNEUVRoV3kyeGF0ZnQwSzhWZFF2V2lsMEdJZnoyTXBI?=
 =?utf-8?B?KzRjYnpoRFc3VVZuMllVVDZoOTZmdXdXQnlVQVkvQlVrMzJWTjcveENKS3RT?=
 =?utf-8?B?L2dibmcwQytVZWpFNU9RYTJIWVNmS3J1eTh5NFVkNE1hR1g4TGFUeW43d2oz?=
 =?utf-8?B?enNQWWJGMGkxOTN4cWZXQjNHRXhTRXpkWWpVUGp0MzRVSHNiT2VHZjM2ZWsw?=
 =?utf-8?B?VEdRRXZhQllFUHdEZjlrdlduOFdaWmk4UTljNG5iZEo3d0ZPZHpKMEZ1eTFZ?=
 =?utf-8?B?YU93UEYvNzRtRkNJOEFCY2RoeEJDZW02NEZNSXBwL1dieHhOemppUDR3T3NO?=
 =?utf-8?B?U05vRHliamsxVEJ3aVd6MW90czkweGNBQ3RpT0VLdXdYN1pQdEFQN2xGREds?=
 =?utf-8?B?Sit1RitJOXg1VW9oSnNYK3psd3d4Y0Q0eWM4K0RLb2xXM1FsTENEM0tidEIy?=
 =?utf-8?B?cHBOaWZVSjVqLzNDV2RLMEhsSEoyb1FRaUZqWFZNM25BVWxpblVhc2JTZmYv?=
 =?utf-8?B?Q2kzS2tCYnhMTlhSRE42d2FuQ0IxZzFDcmQ5RzZmWE0rK3dBSDZXVWM5Q2Jl?=
 =?utf-8?B?dEVVTlFSZjBUV3pkOGE4ZGNDOUU5M2lyUmpIZEVNK0dFWVY5d1NTT0lHaWcr?=
 =?utf-8?B?bk81NFcvaVlOQ2pZNGxua0I0ajlmaGZTR29ZbUx4UWx6VlFrUjcxT3NmZTdx?=
 =?utf-8?B?MHBORGl4MzRjWkhoQlpFVEFCQlN0WjJxdXBreVlCYXphYW5OY2p5UmdTa0VG?=
 =?utf-8?B?NEUzV3hVNHZPYjluOW51eUIxK1hDWGxTdm1IWCtaY09Kbm9KZkxjYjBsOHhw?=
 =?utf-8?B?VWdodlgvUThGbi80K2x6cVBrcEE1VHNET2szenFoY2FHUXZvR2swbGEvMzEz?=
 =?utf-8?B?T1NxenlGeWdlQlRQemR0ZjAzSlU2dWxtRXNsUllTbU9Rd3dFSE1UWVBQR01k?=
 =?utf-8?B?N0Y5WTExUjhhUW5pN3l3b25rckNmaEhtR3Q4aTNUeHRLN242RHM0K09TRnFY?=
 =?utf-8?B?TjVlbzMxZDdkVDIwczZzYkxUVXFic29NSmxROWpFVU1PZkRxTFRsYmw1ai9V?=
 =?utf-8?B?V0FTWldkL1BGd211blpoY1piZThWWWlnTEdyVVAwSmN1UkFrK2JaNERNYm9D?=
 =?utf-8?B?OFpBQW5ndTlpeTFqNGJQRERzUXFNdzJyeXFVa2pZSkEwMnZnMTNKNjBXR1J5?=
 =?utf-8?B?Nk9DR3M3dFRzRkgxTjJVZHE0ZHJPR3NoWC9MTUVpNFZYZWNNQzhrUmR1NFQz?=
 =?utf-8?B?c2cvUUc0emV3MTFrZ3F3MEs5eHVEekNYb25IalV3T2tSdjVOZ0x5SUduYS9y?=
 =?utf-8?B?bVhBZ2EvV2tGTnMrV25oLzBzNm9uWUszVlpzeHhWZ3V5Um1KZmQzL0Q2bEFN?=
 =?utf-8?B?VUZKcEtBbXU5bHcrVU9LQURwWWFLTlRhSkdnaFdHdk4zckt3UW81b0p5RVBG?=
 =?utf-8?B?ck1YZDU3ZWZWN3JuREEyRDRHWjFuUjg5MzA5UkdtZGdxbkJQMDhkVjVhTjM2?=
 =?utf-8?B?dEJzMU9BeVU2SlpsM2RjbWt5SzBENS9CS0RCSFNwcDdmUzBJTEhDeG1WRVlJ?=
 =?utf-8?B?ZUpmdFZSR2czSlNyVklEUk9xNE1aejNoUGxsbEo5K1E5THY1Q0xMWWVWUHNH?=
 =?utf-8?B?TVIzNkprZ0xkdDJxZy9UMkdFblUzYXdkb0lXbit3ZHdTQUN2Z2JnTUhQc1lX?=
 =?utf-8?B?RkJVV1V4TzRZb0FHUVNWWk5mSkJIcDY0WEMvNWE0b3hzUlc1UkVxWTRLUFBK?=
 =?utf-8?B?aUhXbzIxbHJCMzd4R3grekFWZ2lubHZLK25lYVpzdDNYU0VxNElteWU1Tnhv?=
 =?utf-8?B?UHUrbmQydS9wSlhjZm92YTdaUWRaN2R1eTNmWStTQ2VQWVdvandWaTRsTmNU?=
 =?utf-8?B?eW1jcTVOUWJGa3p4WFpRZSt1WnJzUUVJQndOS0NIZWMwSk1JMTgreEhhb0sw?=
 =?utf-8?B?Zm1oVzhsK3gwQmQrVFY0NXRZQ2JLK3ZGemZFU2lFS0M2NTBXYTJaSWFqaFMr?=
 =?utf-8?Q?pNvU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b84d10-3cdf-44fd-e0ce-08d9d5992efd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 07:00:14.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ5v7t96JKWvyvAktcQbiVAF+JoXvnN6zW5GOVJXPuI96XM3WiufjUY2auA31Ihh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
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
Cc: Alexander.Deucher@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/11/2022 6:11 PM, Evan Quan wrote:
> On functionality unsupported, -EOPNOTSUPP will be returned. And we rely
> on that to determine the fan attributes support.
> 
> Fixes: 801771de0331 ("drm/amd/pm: do not expose power implementation details to
> amdgpu_pm.c")
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Change-Id: I95e7e0beebd678a446221a72234cd356e14f0fcd
> --
> v1->v2:
>    - move the checks for invalid inputs(null pointer, U32_MAX) to the
>      layer down(Lijo)
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 +--
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  21 ++-
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  19 ++-
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  71 ++++++----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 133 ++++++++++--------
>   6 files changed, 160 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index a8eec91c0995..387120099493 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -315,8 +315,8 @@ struct amd_pm_funcs {
>   				void  *rps,
>   				bool  *equal);
>   /* export for sysfs */
> -	void (*set_fan_control_mode)(void *handle, u32 mode);
> -	u32 (*get_fan_control_mode)(void *handle);
> +	int (*set_fan_control_mode)(void *handle, u32 mode);
> +	int (*get_fan_control_mode)(void *handle, u32 *fan_mode);
>   	int (*set_fan_speed_pwm)(void *handle, u32 speed);
>   	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>   	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 68d2e80a673b..51d5d1a1717b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1030,15 +1030,17 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
>   				    uint32_t *fan_mode)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_control_mode)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
> -	*fan_mode = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle);
> +	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
> +					     fan_mode);
>   	mutex_unlock(&adev->pm.mutex);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
> @@ -1048,7 +1050,7 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_speed_pwm)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
>   	ret = pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
> @@ -1065,7 +1067,7 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_speed_pwm)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
>   	ret = pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
> @@ -1082,7 +1084,7 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_speed_rpm)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
>   	ret = pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
> @@ -1099,7 +1101,7 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_speed_rpm)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
>   	ret = pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
> @@ -1113,16 +1115,17 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
>   				    uint32_t mode)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_control_mode)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
> -	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
> -				       mode);
> +	ret = pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
> +					     mode);
>   	mutex_unlock(&adev->pm.mutex);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d3eab245e0fe..940cbe751163 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3197,7 +3197,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
>   	umode_t effective_mode = attr->mode;
> -	uint32_t speed = 0;
>   
>   	/* under multi-vf mode, the hwmon attributes are all not supported */
>   	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -3263,15 +3262,15 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* mask fan attributes if we have no bindings for this asic to expose */
> -	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> +	if (((amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
>   	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
> -	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -EOPNOTSUPP) &&
> +	    ((amdgpu_dpm_get_fan_control_mode(adev, NULL) == -EOPNOTSUPP) &&
>   	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
>   		effective_mode &= ~S_IRUGO;
>   
> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
>   	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
> -	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -EOPNOTSUPP) &&
> +	      ((amdgpu_dpm_set_fan_control_mode(adev, U32_MAX) == -EOPNOTSUPP) &&
>   	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
>   		effective_mode &= ~S_IWUSR;
>   
> @@ -3291,16 +3290,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* hide max/min values if we can't both query and manage the fan */
> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> -	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> -	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> -	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)) &&
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
> +	      (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
> +	      (amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
> +	      (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP)) &&
>   	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>   		return 0;
>   
> -	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> -	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL) &&
> +	if ((amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
> +	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP) &&
>   	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 92b987fb31d4..23ff0d812e4b 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -6619,6 +6619,9 @@ static int si_dpm_get_fan_speed_pwm(void *handle,
>   	u64 tmp64;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (!speed)
> +		return -EINVAL;
> +
>   	if (adev->pm.no_fan)
>   		return -ENOENT;
>   
> @@ -6669,10 +6672,13 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
>   	return 0;
>   }
>   
> -static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
> +static int si_dpm_set_fan_control_mode(void *handle, u32 mode)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (mode == U32_MAX)
> +		return -EINVAL;
> +
>   	if (mode) {
>   		/* stop auto-manage */
>   		if (adev->pm.dpm.fan.ucode_fan_control)
> @@ -6685,19 +6691,26 @@ static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
>   		else
>   			si_fan_ctrl_set_default_mode(adev);
>   	}
> +
> +	return 0;
>   }
>   
> -static u32 si_dpm_get_fan_control_mode(void *handle)
> +static int si_dpm_get_fan_control_mode(void *handle, u32 *fan_mode)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct si_power_info *si_pi = si_get_pi(adev);
>   	u32 tmp;
>   
> +	if (!fan_mode)
> +		return -EINVAL;
> +
>   	if (si_pi->fan_is_controlled_by_smc)
>   		return 0;
>   
>   	tmp = RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
> -	return (tmp >> FDO_PWM_MODE_SHIFT);
> +	*fan_mode = (tmp >> FDO_PWM_MODE_SHIFT);
> +
> +	return 0;
>   }
>   
>   #if 0
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 89341729744d..76c26ae368f9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -488,38 +488,43 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
>   	return pm_type;
>   }
>   
> -static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
> +static int pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return;
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
> +		return -EOPNOTSUPP;
> +
> +	if (mode == U32_MAX)
> +		return -EINVAL;
>   
> -	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
>   	hwmgr->hwmgr_func->set_fan_control_mode(hwmgr, mode);
>   	mutex_unlock(&hwmgr->smu_lock);
> +
> +	return 0;
>   }
>   
> -static uint32_t pp_dpm_get_fan_control_mode(void *handle)
> +static int pp_dpm_get_fan_control_mode(void *handle, uint32_t *fan_mode)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
> -	uint32_t mode = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return 0;
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
> +		return -EOPNOTSUPP;
> +
> +	if (!fan_mode)
> +		return -EINVAL;
>   
> -	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
> -	mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
> +	*fan_mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
>   	mutex_unlock(&hwmgr->smu_lock);
> -	return mode;
> +	return 0;
>   }
>   
>   static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
> @@ -528,12 +533,14 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
> +		return -EOPNOTSUPP;
> +
> +	if (speed == U32_MAX)
>   		return -EINVAL;
>   
> -	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
>   	mutex_unlock(&hwmgr->smu_lock);
> @@ -546,12 +553,13 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
> -	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
> +	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
> +		return -EOPNOTSUPP;
> +
> +	if (!speed)
> +		return -EINVAL;
>   
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
> @@ -565,9 +573,12 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
> +		return -EOPNOTSUPP;
> +
> +	if (!rpm)
>   		return -EINVAL;
>   
>   	mutex_lock(&hwmgr->smu_lock);
> @@ -582,12 +593,14 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
>   	int ret = 0;
>   
>   	if (!hwmgr || !hwmgr->pm_en)
> +		return -EOPNOTSUPP;
> +
> +	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
> +		return -EOPNOTSUPP;
> +
> +	if (rpm == U32_MAX)
>   		return -EINVAL;
>   
> -	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return 0;
> -	}
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
>   	mutex_unlock(&hwmgr->smu_lock);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c374c3067496..828cb932f6a9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -59,7 +59,7 @@ static int smu_handle_task(struct smu_context *smu,
>   			   bool lock_needed);
>   static int smu_reset(struct smu_context *smu);
>   static int smu_set_fan_speed_pwm(void *handle, u32 speed);
> -static int smu_set_fan_control_mode(struct smu_context *smu, int value);
> +static int smu_set_fan_control_mode(void *handle, u32 value);
>   static int smu_set_power_limit(void *handle, uint32_t limit);
>   static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
> @@ -407,7 +407,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   	if (smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_MANUAL ||
>   	    smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
>   		ret = smu_set_fan_control_mode(smu, smu->user_dpm_profile.fan_mode);
> -		if (ret) {
> +		if (ret != -EOPNOTSUPP) {
>   			smu->user_dpm_profile.fan_speed_pwm = 0;
>   			smu->user_dpm_profile.fan_speed_rpm = 0;
>   			smu->user_dpm_profile.fan_mode = AMD_FAN_CTRL_AUTO;
> @@ -416,13 +416,13 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   
>   		if (smu->user_dpm_profile.fan_speed_pwm) {
>   			ret = smu_set_fan_speed_pwm(smu, smu->user_dpm_profile.fan_speed_pwm);
> -			if (ret)
> +			if (ret != -EOPNOTSUPP)
>   				dev_err(smu->adev->dev, "Failed to set manual fan speed in pwm\n");
>   		}
>   
>   		if (smu->user_dpm_profile.fan_speed_rpm) {
>   			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
> -			if (ret)
> +			if (ret != -EOPNOTSUPP)
>   				dev_err(smu->adev->dev, "Failed to set manual fan speed in rpm\n");
>   		}
>   	}
> @@ -2218,18 +2218,22 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->set_fan_speed_rpm)
> +		return -EOPNOTSUPP;
> +
> +	if (speed == U32_MAX)
> +		return -EINVAL;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->set_fan_speed_rpm) {
> -		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> -			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
> -			smu->user_dpm_profile.fan_speed_rpm = speed;
> +	ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
> +	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
> +		smu->user_dpm_profile.fan_speed_rpm = speed;
>   
> -			/* Override custom PWM setting as they cannot co-exist */
> -			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
> -			smu->user_dpm_profile.fan_speed_pwm = 0;
> -		}
> +		/* Override custom PWM setting as they cannot co-exist */
> +		smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
> +		smu->user_dpm_profile.fan_speed_pwm = 0;
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> @@ -2562,60 +2566,65 @@ static int smu_set_power_profile_mode(void *handle,
>   }
>   
>   
> -static u32 smu_get_fan_control_mode(void *handle)
> +static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
>   {
>   	struct smu_context *smu = handle;
> -	u32 ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> -		return AMD_FAN_CTRL_NONE;
> +		return -EOPNOTSUPP;
> +
> +	if (!smu->ppt_funcs->get_fan_control_mode)
> +		return -EOPNOTSUPP;
> +
> +	if (!fan_mode)
> +		return -EINVAL;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_control_mode)
> -		ret = smu->ppt_funcs->get_fan_control_mode(smu);
> +	*fan_mode = smu->ppt_funcs->get_fan_control_mode(smu);
>   
>   	mutex_unlock(&smu->mutex);
>   
> -	return ret;
> +	return 0;
>   }
>   
> -static int smu_set_fan_control_mode(struct smu_context *smu, int value)
> +static int smu_set_fan_control_mode(void *handle, u32 value)
>   {
> +	struct smu_context *smu = handle;
>   	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> -		return  -EOPNOTSUPP;
> +		return -EOPNOTSUPP;
> +
> +	if (!smu->ppt_funcs->set_fan_control_mode)
> +		return -EOPNOTSUPP;
> +
> +	if (value == U32_MAX)
> +		return -EINVAL;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->set_fan_control_mode) {
> -		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> -			smu->user_dpm_profile.fan_mode = value;
> -	}
> +	ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
> +	if (ret)
> +		goto out;
>   
> -	mutex_unlock(&smu->mutex);
> +	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +		smu->user_dpm_profile.fan_mode = value;
>   
> -	/* reset user dpm fan speed */
> -	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
> -			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> -		smu->user_dpm_profile.fan_speed_pwm = 0;
> -		smu->user_dpm_profile.fan_speed_rpm = 0;
> -		smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
> +		/* reset user dpm fan speed */
> +		if (value != AMD_FAN_CTRL_MANUAL) {
> +			smu->user_dpm_profile.fan_speed_pwm = 0;
> +			smu->user_dpm_profile.fan_speed_rpm = 0;
> +			smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
> +		}
>   	}
>   
> -	return ret;
> -}
> -
> -static void smu_pp_set_fan_control_mode(void *handle, u32 value)
> -{
> -	struct smu_context *smu = handle;
> +out:
> +	mutex_unlock(&smu->mutex);
>   
> -	smu_set_fan_control_mode(smu, value);
> +	return ret;
>   }
>   
> -
>   static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
>   {
>   	struct smu_context *smu = handle;
> @@ -2624,10 +2633,15 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->get_fan_speed_pwm)
> +		return -EOPNOTSUPP;
> +
> +	if (!speed)
> +		return -EINVAL;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_speed_pwm)
> -		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
> +	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
>   
>   	mutex_unlock(&smu->mutex);
>   
> @@ -2642,18 +2656,22 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->set_fan_speed_pwm)
> +		return -EOPNOTSUPP;
> +
> +	if (speed == U32_MAX)
> +		return -EINVAL;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->set_fan_speed_pwm) {
> -		ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> -			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
> -			smu->user_dpm_profile.fan_speed_pwm = speed;
> +	ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
> +	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
> +		smu->user_dpm_profile.fan_speed_pwm = speed;
>   
> -			/* Override custom RPM setting as they cannot co-exist */
> -			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
> -			smu->user_dpm_profile.fan_speed_rpm = 0;
> -		}
> +		/* Override custom RPM setting as they cannot co-exist */
> +		smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
> +		smu->user_dpm_profile.fan_speed_rpm = 0;
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> @@ -2669,10 +2687,15 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +	if (!smu->ppt_funcs->get_fan_speed_rpm)
> +		return -EOPNOTSUPP;
> +
> +	if (!speed)
> +		return -EINVAL;
> +
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_speed_rpm)
> -		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
> +	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>   
>   	mutex_unlock(&smu->mutex);
>   
> @@ -3101,7 +3124,7 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   
>   static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	/* export for sysfs */
> -	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
> +	.set_fan_control_mode    = smu_set_fan_control_mode,
>   	.get_fan_control_mode    = smu_get_fan_control_mode,
>   	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
>   	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
> 
