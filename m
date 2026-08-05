Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66A0C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D78310EE8A;
	Wed,  5 Aug 2026 13:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iUYEuSm8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA3310EE79
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq9oS/EUbhFndbrDfif1K/lTU5FbYlXyDb4hRaqOa3mvFy/dmsm/XbvxoL0vjl/VF4U5qdeWlC862qQ9Ix1NNyM2zkCmmj9ZFNQ4Jmri8BgFFYOK8Sainu2PMpwVbDvo0lf7KNvlXO3JXa573xYrUjxsFQP6r5Mg9eOUq5oM06bfbiAE0OiQMzWyQZbBvDXu8CbQzwvh/+5S7kmV7Vj1JRwLgVYKKVv/6fw/ILmvuFVkwMNGlE/QrosgLRiv4Vdxm12XddZi9sSM3vIWgki6/pDVO6S32ft9s0BaR88zt7iGRb636CFR+50muZiCx0iY6AltmpfzPAWa6yxQGjlDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgu2oQDaAT1rcJ4C8cs9azCeiInd/lk/l4Kkk35/cH0=;
 b=GIJMHUem4q8omM/HgZgRvYI8SzGM/mnxBnFP8Owc/vD/VWxHheTNEmVi5/PmcnqjrjE+PTiV1Nb6JpAGPHopOffmSxIbQX+r+7a67OsMfOavegfHUr8cVIZRe5evoWXjSJralHCQu4A/tEZlxqO52w7pwLHkph8jkKyoTKY9cy+pTM7GhkSh/QN3cqitmjuoMK9GOVTIT5xUsUusyrFmPiTSW7ceGaUII86R1GmUnGBnabCcXJsc5yx6m4M45/xOCEh3LdntlGj6WUSGxgEu8HmmPcUuHH9rRbnJTTfCtcKwgU8ZZfKaY+LUbw5dYf6STJPxTBGvXl9exc0a6NIZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgu2oQDaAT1rcJ4C8cs9azCeiInd/lk/l4Kkk35/cH0=;
 b=iUYEuSm8k3EmOEC6slE3F4XIwf1AjoCbHa54bODailBitY8sqDLzmlLNZfwMJMu9n7qZ1Q3dstYCxCf9iEOemN/oYJptVKnyNQljLp0n7TTLd/p178laq/fpaLP8USZOVp+O6b1iw4uzQ85t+w2Tanuz4KVhSSYENRsncYz9LGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::987) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 13:57:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 13:57:00 +0000
Message-ID: <88de25f9-826f-4de2-8c36-0d5b21d733b7@amd.com>
Date: Wed, 5 Aug 2026 15:56:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate GEM_CREATE domain combinations
To: Candice Li <candice.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260804095620.3899975-1-candice.li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260804095620.3899975-1-candice.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 06880163-f9e3-4733-759c-08def2f96c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yXIT6EfNoen5/a/GF5OqC74Q6XxvO7PaT19TkeTjcLpSj1cOUhW/YWmwJveo37GTo2g7T7NnLSooR0MDxJpsT15J1p8B/35EFut4Gtm5h2FB+niQTxOwGH30PIkXUyKcFXyjI8obEeSt8bZJClR4zNHBcMHfG7JdCq6AWjwzPm4Hzy0Ekef5S14fhCO30CdAYh4FA2pw7VSG/yHUcuURxwDXOvq4p3C3DHFFsWU0DZV/FN1epZfdTHsXn5yRmmPPs21rXv8nOavXVvDeutK/3djDGRLpOiGQCvShN13gZuXaAGVnSCOPy0dmiq2QGMTXUEQHy/Xjskt4JAXg+7iaaxmterMYjx4Tfa9JpjkPqGYMUtthPvVncvng5NtnOTpcOvxAT66cgS8/bodRjdG/mU/PbUWg0KCH6I1uk8TmwrGLbg/3NTtRycecALhH/zMOjGV3YJMMD/p/VbCnOMxilAJM1w7Sa/kW0Ixb4QMSyXfx5UmRIpxqm1gBFtlHnMH6mlTvVgufmK1fl5uwwqDYm590uipBuW51Tr4iy3YWWpSiARHojHBZ/sivNuDaeQAphaxdTcvv0mzvINk3BEcyOwwO2QTXlfmZYXuKOAi/hbpIvDoVtOoyIDml/n/Zk7mrEVj8vKnprvp6M/P/glrra97LiJ+aVRVkg07ktFuF4aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnFFQ25MT3F3MytGVHBzZnhCY0R0N2hYN3dLRVk2dzljd3kvTjVtVW5CK0d2?=
 =?utf-8?B?YjlBWTVaYmpJQ1RybEliVUgxaEF1bDdZOUVSWTJsbXdTdDR0QkFFWHc3aWVp?=
 =?utf-8?B?OHBCVXR0RURLVVJ6dVVNeHdLd2pBbUhnblh5Rm9KWG9UOWV6azVHV0V3UEMr?=
 =?utf-8?B?MERMOW15b0hXeWJaRlFXMVllYTdNUHc1MEkwOUNhcUhEaGVlS0ltR3Nhem1L?=
 =?utf-8?B?L01aTmpkSkd5YkE4V1o5WVlGaHErbHVjYjVMWDF4S2tZaUJoU1BMVGRMRWNV?=
 =?utf-8?B?Q0xOVUpIc1FJVmV5eXdkM1ZCSFlVTkZBSUs4Z3Bid1JScDdDeE9rbnV4a0VU?=
 =?utf-8?B?VVhPekY0eDVqWGNtOC9SUitQUUx0eWpCSnVaYU90dXYvdG04QkpIaWtGNURI?=
 =?utf-8?B?Tk1za3prUDNrNHAweHdiMmdlRkdQeFhsZ1ZBb1NrUUpqam05bENzOHd5eVpD?=
 =?utf-8?B?VEhzUWV2cEJ1VWJ1T25KL1VtR1dscFVUZTc2OCsxQWJOQ09jVzhYSGRsTGRm?=
 =?utf-8?B?UGcyVUk0U2k3L1g2RGQ3UzkxT2UzTXJGT05jK2ZjdHl6T1RnSC9DRVExakhx?=
 =?utf-8?B?Ykc0KzBrYzl2UnNYSThZVTdyRFliRTZ0bWlackN5MjFSV3JERkU5NlFFdmQ5?=
 =?utf-8?B?TzZuaVVmbHhDNCtYWnlYcGx3c0IwK0Z3aFBVajBoSTIrSC9LM1U5azJsaG81?=
 =?utf-8?B?UEpSN3VocFZKbUlYRW1ON3VsZCtnUkhrSG1BK0JXUFJSeVBNdXh1dmV1YnlR?=
 =?utf-8?B?cWE0S1BQb3hXczVYaGU0ZU01akNwY05BWTBYT2xsOHRJdEFUR0hlRUlUR0Rv?=
 =?utf-8?B?L2VKV2V6UUtRZllYTFA2bkZEOWdlaXFZdU9VKzRuMkxRM1VEVGxLZkJ6MERO?=
 =?utf-8?B?aW5WOW1oVEZGWElxMUNBYTBXN0RGbE9vdkE0d1BIQW9ZU1VSZHprOGdGQ28y?=
 =?utf-8?B?WFIyRlNqZmxPb3YwdmtaN2IzWC9yTndxMnRzZVZOTUZzUmp3ejJ5N2I1UWxK?=
 =?utf-8?B?WVovMllsNlRnQVUyMkdoL1hONnhpUjlFbnRFTkJIUXJYWmFXYi9hRmR0dVpO?=
 =?utf-8?B?REluQXpTU2hraVRVb3hSOURhN1lnOWZGWUhOZzRtdzlmSFJzSUh5S2FSSTRu?=
 =?utf-8?B?V2s5bnNtZXpwa1Q5TEp1UENIZTZoZzZ3RTcrbHpGeWRTR3RidVBKbjg0bS8x?=
 =?utf-8?B?N29FNHBOTVZFaGRTNlhYQ1VJeHNteHk0clJqcFB6TFp4QTFIcnJ5c0FEdHVk?=
 =?utf-8?B?N3Z3d1JHNCtUNFRVYUtzSTl6RWQ3bjY2a21wS3MxYVVCNGJEWEZ4Z3lxNUs2?=
 =?utf-8?B?NzBhR1l4VHlHajc0djZibXB5bjFZSEREWUNnZWd5cGg2VG02MkNhQ2ZBTFVP?=
 =?utf-8?B?TTAwcTNhN1lEUUc1ZEFvbmpQTFRyL2w5b1E0dGJjVHlKRWVQcjA0R2pvTUpL?=
 =?utf-8?B?OFVSWGRGWlk2VHdrSTh0Y2lPMWlmSVZ0VjlvQS9QRzdLdmF4MWZ6ZkhNMks4?=
 =?utf-8?B?U3k3NDRDTDFnUHcvdlNVOEZMRXJUT3IrMWVOMWtzNXRHLzgrRXFUdGtHMUNX?=
 =?utf-8?B?YjZtOXZRZlc3Ukt1VzgxZjJpazgyNmdOOEo0U2lXSjJCamZJTmRwS2FGQjBO?=
 =?utf-8?B?OXJLcXo4ankyeEdmSUdKVFJiSUV3cThTQld4UDN2aEhuQ0pLb1ozbitlR0Jv?=
 =?utf-8?B?ZEV6T0J5c1hzQnk5d2x2NkJvcTJDRmM3dkp6WUNWc3VEN1QvNUYvT0t5MG5p?=
 =?utf-8?B?TVRRblNlajhLVDgwalJyRXlIZnBFRWxhYWVZb0Y5SXd2OUtCVkhsYWxMbmFG?=
 =?utf-8?B?TGNWWVB0SWtQRzRGQlFZWGdHdEhDQXgrcUM2VmJ4eTdtS1l4cUhYM2VrcmRL?=
 =?utf-8?B?bk1KV20rNjJORThYVldzSW4za2Fzb1V2WGZvOC96Q3pQTktmZzlrVFp3SVQ3?=
 =?utf-8?B?NTBKKzZBZHdhVUxZbmZvcVpIU21zMFd5L1V2SG5scUhTeW53bkM4N3V1S3FO?=
 =?utf-8?B?U2dJUktNRWl4a3dMbGRzSnhDVmsyWUFlMWFYWVJTZGRVb0FVWWlISEdlNEZT?=
 =?utf-8?B?ZjJUaWFDR0dlU1E3SG5pN095Q3FRWmI3L1BJMTh5UEJ2SGJvR0t0VkI3ZSsr?=
 =?utf-8?B?eFYxVUd5dUYwNDNiUFNRV0IzOXlsVU5sdDM4MExZUDBHUlM4ay9zcDV4Q0Y2?=
 =?utf-8?B?VTJlb2RlWHlKT3Rqd1U3d09xQmhSUG14QkJYZXhxc0kwMWdzWXJRYUFtNndB?=
 =?utf-8?B?Z2t0b0JmZ0xTWW5BRHFxRGFKMnh0aHpmMHpZMW1rajY0SEM1cjhoS2Ntc3Yx?=
 =?utf-8?Q?toWYap0Hd1vixVPM88?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06880163-f9e3-4733-759c-08def2f96c0a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:57:00.8684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8Smfipf7E0HGbLg6rggEumKUVbEl1fXeqZaAxW4Q/Ww0q+rr+vOvCXg7vqDHwWL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
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



On 8/4/26 11:56, Candice Li wrote:
> AMDGPU_GEM_CREATE checked domain bits against AMDGPU_GEM_DOMAIN_MASK,
> but did not validate domain combinations. Userspace could combine
> CPU|GTT|VRAM with DOORBELL, GDS, GWS, or OA, making
> amdgpu_bo_placement_from_domain() exceed AMDGPU_BO_MAX_PLACEMENTS and
> hit BUG_ON().
> 
> Allow combinations only within CPU/GTT/VRAM, and require non-CPU/GTT/
> VRAM domains to be specified one at a time. Return -EINVAL for invalid
> combinations in amdgpu_gem_create_ioctl().
> 
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6a0699746fbcd6..8fd0a63af4a135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -397,6 +397,25 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.vm_ops = &amdgpu_gem_vm_ops,
>  };
>  
> +static bool amdgpu_gem_domain_valid(u32 domains)

Name that amdgpu_gem_are_domains_valid(), apart from that looks good to me.

Regards,
Christian.

> +{
> +	u32 normal = AMDGPU_GEM_DOMAIN_CPU |
> +		     AMDGPU_GEM_DOMAIN_GTT |
> +		     AMDGPU_GEM_DOMAIN_VRAM;
> +	/* Treat all non CPU/GTT/VRAM domains as special domains. */
> +	u32 special = AMDGPU_GEM_DOMAIN_MASK & ~normal;
> +	u32 normal_mask = domains & normal;
> +	u32 special_mask = domains & special;
> +
> +	if (!special_mask)
> +		return true;
> +
> +	if (normal_mask)
> +		return false;
> +
> +	return !(special_mask & (special_mask - 1));
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -421,6 +440,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	/* reject invalid gem domains */
>  	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>  		return -EINVAL;
> +	if (!amdgpu_gem_domain_valid(args->in.domains))
> +		return -EINVAL;
>  
>  	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
>  		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");

