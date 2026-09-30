Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B97ACA5FBA
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 10:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E869A10E5AD;
	Wed, 30 Sep 2026 10:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKOP3ywX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8841F10E5AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 10:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dugv04acDICmzVDOr0fNpLUqaTHP/HEzA8EWfv+6r3wpkWEEJeRT5DUO/56gMM8GpxOcTGFvYo931YeTsN301g/wWQrKYqR6BVhJ+1HVzjy6zSu+wq+D8ueu8wCku4DEA7a9/2QV0kAdOYOX68F9RQVcgpFBA2OmuaZkmpkYQ31RwGX1ytlO7AwSAgJjeeoPM+uMSuCjQrX1zrqtzL7D7bS+cDwNQfLx3b0cNbpVXsOShlfup1RCCh1zLzQk38mZvvrccKZv33X76yTigoC4Q7jGT3WTcVZ1Qq98sCFww9Hyfs/ci8cav6ZApmoLFrcH5pckcxAHBdarsngZgWp05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFmk2X3YrhtK2MB9wQm5WnJgn/hNBOsmQOam3vrOHmc=;
 b=JjS0PaD9ZGkf26gIe1r1oagG3jAy037/X0/AuEK7b6mXluca4XT6x+OAop9wcbOeBeqFZP8YSJv+L3R2pZz1vPexz5J/aS6Nb17PaVl2twO/erqldRcIeeR96rtuR7WPuVe5nP2A6XLJt+qAQmMPN2hVZic+ikNlq3i3+DB2qgkmcPfPs74x4drLcLpK4MNHPS4MuMNTI5vlWkKi1WB6CQssyGD5ijc6WUDMFwyz4JX2rFQQIFwpbiNGgykAsFV6jZgPyyMPRK1vONJH7Pjio3cKjzdbjumK5YVQa1g1IjHfMhznbGjopeC+TMtEBNgVWIEJp/ihh+SG/Snif6n+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFmk2X3YrhtK2MB9wQm5WnJgn/hNBOsmQOam3vrOHmc=;
 b=WKOP3ywXGASgBRoEwi8STCyIO1ZPlFE9Di2xcRoNNQ4VJPe1Br9AZ5hlHSeuu8yGQnYMmQwiwaESMi+1Dx9w9HawJ7SbqgjUPSXhsU2NATqYr4Wq7QZNVGQQUWyr54OwxapsecfYCFi/F17tPG2hUwSZkWhDgYivSH1JPfJjFR0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 10:24:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 10:24:34 +0000
Message-ID: <56aebc88-13d2-4571-b59f-ea286622b2b7@amd.com>
Date: Wed, 30 Sep 2026 12:24:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] drm/amdgpu/userq: only accept doorbell BOs as
 queue doorbell
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20260930093912.177219-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930093912.177219-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: c926d055-9517-4e1e-fd04-08df1edd05a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lwiHmRBreKyZxAGLaTntKly6InWoHWKK896nB1XBvY7No+0Gge+MqI79WYaQD4aXK7gWWuI02sHCHsVEf8NsgR5NqteVRQx6mdWN0wbRa1VR+cZdUEGS/5Jw00cNObyxnWEenDcFHQBYCCccEAFfJedfhBp/rICyiSfp0x+/eCzWbr1Xcq9ffXXPHAornPuWhGAcppjBVSXQV+Xu7/8W8P6/sJaekOKBve0L5AMrPlrUP3PVnFJ1XD6T5Xfquvh+NvNIdeHi012Qp2kz8EDx+Kw8jLYAfl0YPuoiV6EV+VHrlwoUXTGy1E8r0fSvMtbL/SWnisYnTbkla3Yp2JPIXT+a4H65HlIDwEJKj1706k89PCDg0ussKsPYSRRaCN4k4iQOv6ESdRH7uHzMMuu7ifCiKmntwqLi6kowZtRA7hoqfBdV3S66jAYfSKCvWoHj/XFgH5to09SG+A2PCaTj6PQ3DoSrdZ34rAr80Ojg5+deOMmjxW29UQlSTpXNVGLoT9KSiByh6gkJ99/BVdckH4/70wQsPszH3QMjFXvJfUXgoo/9l4Gb4lrzW7GqT6oV5xvUDGEbsBPVmCy1OtDBfO9+BqsvrPIZWJS726/Gb0tTDJB2ssEUHz8YzsDymfWNOnSFa7Dbqx2DMkjRgjwRiLMAf4HNNJlUI4LczqElPMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFIUGRSbm5yckh0TDQyVjZoejZwQldvSFdvdUdhQTRqNVFEcXVhRGFTeisy?=
 =?utf-8?B?SHcxd09DcGpvT3phUFJhaEE1dnBNSXJLZkVnaUQyYnQ3MVFYd3dwbmNiNFlt?=
 =?utf-8?B?WXdmalk2dUtacHRPSDlFZit1QWt2a1E3NVpwdUpWOEFMa2d0WWFneDR2TDhK?=
 =?utf-8?B?dW5KWnVvVGxuOXI4RFZjMjQ3UE43djdqT3VnS3lwR1YvRFhUNW4xWUIrUSsr?=
 =?utf-8?B?REp1NGVFMURJbVV1QW95ZmNWdjBkWXpSZ3pnbWRJUzdsbmowYjUvSlRLWlpP?=
 =?utf-8?B?SWx5UDFIT2h0SXI0OW84UEVXdnBIZVFCdDFlbFEzZ1JDUUtVbnBaczBIaW1T?=
 =?utf-8?B?Y3p1dG9SUDhoT29qb1ZFVm9sTGdqbzNUZUFvMElQekZUVFZ0QU5lM1VwNzl6?=
 =?utf-8?B?MkJ2WVErOGRvaG9YMGQrUzhjdDB1Mm9qaDFXY2xFeU1NUHZoRTMwazR2RVFK?=
 =?utf-8?B?WVdMQnE5Y2xBWGd4OUxJekVtdUFMbjh6UkhsRVBJUGVKZUcyT3R1TFFNSU9U?=
 =?utf-8?B?VDNBKzE4VnJBVlJKYnYydXhEeHRhOTBXbkNSa1ZvOExhWjZZV2xVZkIxK3M3?=
 =?utf-8?B?eElNYVBydTZnVWJ6YkxoTzZqcU1qdk9tYzFlRHZwck0wNHdJZXhLQmt1bTZO?=
 =?utf-8?B?Q2M2MFR5SG0zdGY3TmhWcVBLU1NMV3pJU1RVb294QjBLUHZBUVBOajBOS3d0?=
 =?utf-8?B?TzVJM2VoY0t1QjdnLzhtRjArYjZWbS83Q1NhSXRlblRkRUNuTGEwR0U2T3oy?=
 =?utf-8?B?aTlYZFBGVmkyRjQ4QzdQRSsrdUtCb1FaVVRlczl6Wnc1R3B3OC9kWFBGTEwy?=
 =?utf-8?B?UFV5N1hZRXZEZ2MrZ09UalhWaTcwZWdtTVM1MElzTEVFRlZTcjBqbUdjakxv?=
 =?utf-8?B?alpZV2piM1VWQUg1TVNoODdCRWw1cmUxQ0VTSE1BODNqcUR1VzRTMFZzcDVH?=
 =?utf-8?B?d3Zqd25yWElCV1dxbUdyTm9NS1AxUkVlVmZ5TkV4VmpHdFdKamttbUlWTmcv?=
 =?utf-8?B?MnVRZGF5QmNkNVRLRklMVkZQbHROZFc0NVpPeDNTdXp1UTNCakkwa1RKL05o?=
 =?utf-8?B?ckF2eW1GZzNvV2hkZ2ZOdGVncTR2L0RTdHZ2UDJPeVhuOWxScVNnY0FFd1JD?=
 =?utf-8?B?eVZGSVVTbDJDT2JqYjhxMWthSEhqSFBrWDJRVEFPemkxNU9QWnY1TEs2S1hz?=
 =?utf-8?B?UkF5ODNCZVFNREdtbGU2aWhVM3hRanlqb2ZoL0pNczQwYUVESnVQQW5yWWps?=
 =?utf-8?B?b2FwSlFyZWYzNmpCNVBaekdMb2lTWUlyWTVTU0wrWkt1T283UkQ0djNVbEgx?=
 =?utf-8?B?YkJyRzB2NEdNR0d4cWtsanJZaXg4Y3g2VEo3VFY3STJ5YVZDM2U3NmRjeStr?=
 =?utf-8?B?VnozeCsvTldXMm1vZjRlT1ZtRFlKbWxPNTZzQVBWdUZ6RGFBT1lobWQvV2d0?=
 =?utf-8?B?Wlh5RURGc1dsb0RMbCtMZno2NlF4eWM4YUUxNGxsSXlvZTJYQ2xXc294ckZm?=
 =?utf-8?B?OXJTQ3hsM0p1STlwb3o0Ymt5dThwWHBtVnBpUUg3RE1sT3NnNVFPd0dockJp?=
 =?utf-8?B?WlBNRTVTQmFEN0xuc3VhUlRzcmlyQy83UzVvSEFxbHRScTM2UXNycTZOVlZS?=
 =?utf-8?B?b3JWM1ZDWVUwbElwNXc5NllmdWNjUm5wZDdIRXg1SlJpSkVTZ2NrK2Z2WWVt?=
 =?utf-8?B?ZzN0WWVHQXQ0dkhDWmxDK21jOXBZcjA5RXFOQzFmQTN2SkdrbkhZZEorMnJL?=
 =?utf-8?B?MTY1cXRndnNDdThxQkpJK3VjZUtHK2Z4M0Y3RFpyd0cxVkFzNVQzRUJRWVEr?=
 =?utf-8?B?LzBNbGEvWWF0VnhrQ1A1OTJaWFpOVnBmT281Y0JkYWY3MVhZV01rYWVPenBw?=
 =?utf-8?B?UElNd0oyWjZuK1ZRNVFyWjBuVDNTV0JLazdPYmRCMlFPczhvMmFKaUhDb0U1?=
 =?utf-8?B?OTJFRlVzeGpFeWVKaWRtNVp6ZW0wSTdOSHIwSlpMV1lUVXM3NDNaRGcvNXJG?=
 =?utf-8?B?UjdIZzVJQUlXVmphNmdhQ3gyNzh6UlBrTDVHR2xBQzZFcCtINHJ1M3h2ZlI2?=
 =?utf-8?B?NTgyYkpVZzArRmtORlVnRC9NVWhPeElTSVg3eXVkMSs3S0NucWxRdHltcUlI?=
 =?utf-8?B?a01PVm85OEVBekJvUm5ndzY0WG1uTldyUXJJc3pUeUtCTTV6S2RGaVFid3l2?=
 =?utf-8?B?akNmdjNXVitPeWJHRVF1NndKN05UYmJIcWRjOVlkbTJnYnk4KzZONGtqQkJK?=
 =?utf-8?B?UzFHRWFRVXRmOVcyWmxUZjgzRXg1U0pFN1VKdUJJRGpDV0VuNnlVZU93MUZ5?=
 =?utf-8?Q?fffGCMe7UOtC3LF/Z4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c926d055-9517-4e1e-fd04-08df1edd05a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:24:34.2373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BElDSpVxgzN1Pp44n6BuK0ohDUNPCahpdzV33PcfyQBbJWS8UjzfPpHZVEuVfBpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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

On 9/30/26 11:38, Jesse Zhang wrote:
> amdgpu_userq_get_doorbell_index() pins any BO passed as doorbell_handle
> into the doorbell domain. For a regular BO, TTM moves it with
> ttm_bo_move_null() and its contents are lost. Since an importer on the
> same device gets the exporter's GEM object, a client can do this to a
> buffer another client shared with it.
> 
> Reject BOs that were not created in the doorbell domain.
> 
> v2: drop the error message, use a local abo variable (Christian)
> 
> Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 89e03d3a930c..5a922f283743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -469,6 +469,7 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  	u64 doorbell_index;
>  	struct drm_gem_object *gobj;
>  	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
> +	struct amdgpu_bo *abo;
>  	int r, db_size;
>  
>  	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
> @@ -477,7 +478,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  		return -EINVAL;
>  	}
>  
> -	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
> +	/*
> +	 * Pinning a regular BO into the doorbell domain would discard its
> +	 * contents, possibly those of a buffer shared by another client.
> +	 */
> +	abo = gem_to_amdgpu_bo(gobj);
> +	if (!(abo->preferred_domains & AMDGPU_GEM_DOMAIN_DOORBELL)) {
> +		drm_gem_object_put(gobj);
> +		return -EINVAL;
> +	}
> +
> +	db_obj->obj = amdgpu_bo_ref(abo);
>  	drm_gem_object_put(gobj);
>  
>  	r = amdgpu_bo_reserve(db_obj->obj, true);

