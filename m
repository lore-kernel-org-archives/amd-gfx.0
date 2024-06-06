Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B97C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 17:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC9D10EA41;
	Thu,  6 Jun 2024 17:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A1sj0TiD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A1910EA41
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 17:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9NanY1Lv33Gi+G48DzjL0XBZ/NnMX77z3Ji5pXZc8rernwNNcZ2fWjgpbJgWSUqxWBXrETB07gwo0wms1swa0yU1IA9/d9XP3y37d2j6GfYBgU4hpDRqOKpswzmOMMJS40Gi93n8c31wezM4I0V20WGUKgfaskS7EcidDvRrjUjt+fDjrkWGx4VuPOFpdCl/37IAQ/HCgQ8laTPihvwvpG+tiRqrV2jaD0K4SJCASRaTox99ErNQ4AvslUBhJp0Zt81cs5//EI2DPxgjvG4RMJ+HyGBXcj92rOXXOSG1HD7XYIYGeP9EbHknuWtPx6hLpaoUkm0utcwNlUoYlGbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkndxhFhjBc1AjHykr+I51/9Wmmzr6Fc762wgnFS7vM=;
 b=em82PvexrtNT9TqzFH1HyQvpUypPpQELgH+z6Mm1sbr+ObpY+kYSb1kLAFWhyqTCnUuv0DnJj2+yejyUGGqHYgHEZ3KfiLFNAM50YRZBrbdOoXv5M2xgTJJDgHRfK9CTCoR18FB/AewEt9xvMNetStSo8Agux0jDvbs/myBO3g97rZzPpVGQRldFG6A10tfMj5xRCg33aACu0VbB9crPhWpxKQoDECrReEfQtZO87uHAi8wEztv1/Ud0DYiE69PeHvOBf7jgR+1VHemO2CsWpbqjwHlCC3Sv3gNFJvQ3jPQ9ni9iX949iX+QHUyW8nE5+fHgjra3fDQaWXIwaqnYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkndxhFhjBc1AjHykr+I51/9Wmmzr6Fc762wgnFS7vM=;
 b=A1sj0TiDCUkHvKBqrECv0gHYPu3G7y/5NLGj4tBw92y/12pd0dVA36EHQBwmB+EAxnj+Liby5H9CO5FdJBayAgBmr6vz5n3kUw+qCKSmdKwt1bOX4nKLSZBY0jtoUfZqnS7jvSdyrHKOsnp5EQn/Q/WHUSFMb9i+SiX3aJVgQmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Thu, 6 Jun 2024 17:32:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 17:32:12 +0000
Message-ID: <1d4ee550-9bd2-4112-8eb8-94284f3c6d7e@amd.com>
Date: Thu, 6 Jun 2024 23:02:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer in amdgpu_reset_get_desc
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240606154300.100140-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240606154300.100140-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: ae239995-6385-4799-5203-08dc864e9942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dCszOEV1a2RTWWRGRVA4R1F6MStxSEVTV2pTOFc0ODU0MGlIM1BUSDMwOWxh?=
 =?utf-8?B?c01lbDUxMXo1Qm9yR2VNbElpRC9hUXMwZTRuMzB5SW82U0MvTEhjcmp0OXRF?=
 =?utf-8?B?Q29ra0p5THErd214TUVQUytDd3kvK2JMTmxzYTFxcmcyZ1Y1SWVUbUtxQ0Jv?=
 =?utf-8?B?VXlQRVpXUFFSNkhCMjFwaEJqV3JPMGFIeVBDZWg5UG1RcGtPK0VoTHJSNG5a?=
 =?utf-8?B?OTVOYXZXUG00K3pTT3Z1amRkTmRtWVRTMjhHeXVuczBKSkd4ZjVzYVZlRkJa?=
 =?utf-8?B?VVgwaHd5aXRlbUI3WUVJQXM0eXlvZm9naEpqV21JMTRRMjFYZlhCdU91OUpn?=
 =?utf-8?B?cnU2LzFkQTVkbmppaVNYeWlaUHhrWXBMMWc4eGNQTGxFTWt6ek1YalM1UEJ2?=
 =?utf-8?B?OEdPbXZvVkRjMU0wQjFWTGxYQ1NaNmFYVWVkWTk1Zy9JWkMwa1hWR2t1TE1V?=
 =?utf-8?B?U1J2T0J5bnVQekJjaFBNelhSSUxDQXo4U3k1SnhyUWhOaUVUcWxuMjRXWFhM?=
 =?utf-8?B?Uy9KL2F1Qkxmc0FJc1NicVJ3RWwzZXVWSURHd1FjeVhUT2pXdmZka2thcmc5?=
 =?utf-8?B?SDhsWE1NUWZXVjR2bFNsa2tQeFhqRVZYcjNKZFNabXJFcHRqQ0ZINUltc0ox?=
 =?utf-8?B?bHN3T3hrblJNQmliZlNhRDdnL0V0WVhPOHAyWmdwc2RwejhyVGQ5YmxYR0Zv?=
 =?utf-8?B?TXhxcjRVWkNYZ3JMOHRiS05mcWlSd2Mxd1M4cEVRd0d4MUxoeFNSVHNYRHBB?=
 =?utf-8?B?aGdTSzY5eXQyT0JKLzZsRGdoTGVDb3A3Z0NWSFpvaEtTbjhXYzJLVUxhb0Rm?=
 =?utf-8?B?SlVDYXowR0dHRWRMU0kwc3ZuYVFQMmdwcWczL1Z5dzFoQUUxWUtHZTZVSnFO?=
 =?utf-8?B?Uy82NUhSRnRFOVJ3VWY3ZWdBZkZuUGdpU0xNYzlHaUUwelcvM0JkSGtnSFQ3?=
 =?utf-8?B?eG9DeVpRM1cwc2FzNnRFenV4ZWN5N2hOSHIxdGxldHlhS1NaelRzQm1xOEJa?=
 =?utf-8?B?bEpDSmpRTWc5SVF2NHhFN0RhMkpodjQ4V29xaE9OaWFKRWk0M3VyRWFscUJ3?=
 =?utf-8?B?alkwelFlaXk1OHB6TjVMbU9sZWhLUzhGUlVLVEFTaDIrdlUrdDF3NklCdjNF?=
 =?utf-8?B?dlhsTm03R0VNZ0ltNFRxTHlwaUFrLzFoaXZ2QmV3ZXZBcFFZMkk3eXErVmdB?=
 =?utf-8?B?ZzVMaHg5MHZ3QzNFSGFFVlU1Q3hNNEVuNTZyNHI4ckowYmJRcHJCZ3dnR2FJ?=
 =?utf-8?B?SUsweWZBK0I4NThYTmZleVlDVWR0c2VHT0RhRGo4azd0S0xtbkI4WDhHSlZI?=
 =?utf-8?B?TWRIZWNVSFN6bndRVnB5ZlhES0hLcU5HbHk0VThsbUMySVhHQTRka0xCenNN?=
 =?utf-8?B?Nml4ZzJBYitJWEx6WHBiREFWL0ZCanZjY1g1eTRORTMvaXhzSkdCNUtOS25w?=
 =?utf-8?B?dHR1WkFyWGJSRjBVVElEQlNDNWNVWHdiMmVqUVRTUGMwVzVlemlObzZXOHB3?=
 =?utf-8?B?ZmVZTWIvb0hlUzRLTEJKWkx4MGVybGthZEx0SGRkY2UzN0JMU0JkR0Z0UmJI?=
 =?utf-8?B?RTZ5UnNWdHAwRXhqcHpuaHpxYUpwOVM4by9UcWhZSXNFWTJIakh2Rk8yWUR2?=
 =?utf-8?B?WE5WNUxYZDV4SG5yd015cWtVV3hkcGJJVnJhRUh4SWhNcks3SUpWY1ZEeEdB?=
 =?utf-8?B?NUlMcG9LN0kwS3ZicytMTDVrZTE1WW5iMkFMb1VGaHBwVnBsT1pMeWhWalI1?=
 =?utf-8?Q?g3X7kECnOvst42o0/knILE5z/SORz10C10Jxeo9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRUamcyRXAxN0kzY09ESEZCbitMcXBHa29TWG5URklHVHR1cmZzMVNhU1lY?=
 =?utf-8?B?U0pyWXZ5SHlvRzRzSDFVSzB3TGNqaWRRMGdheVA0eGp3SEtQbmJLTGxxbzlj?=
 =?utf-8?B?TlUyTkZYaDNjbkRvU3FtMXhONEJPTFlyQ2g2U093T045TjBMQWk3aDhhd0pQ?=
 =?utf-8?B?ekROWlluRDhFUWgyWDM1T1I2TTdQUGNKSGJpbGNGeFFtY3gxckl0VVVDMnoy?=
 =?utf-8?B?eVBXdmFFa25jYlhHSTE1ZG5iY09xK3ZSbWE5SDMvYWJRZXcxUENYSUdRbTZ4?=
 =?utf-8?B?VElmVGhGOGpZU0VXY2V6bVEyTUpqa3N2cktQU0diOUozQWlCSStKNUNUeEsz?=
 =?utf-8?B?bzkvRllKeGhHOTBYY1l1Z0FTT1dVSEFOQXlONStYSi80L0hpVHhXRUxHbkxL?=
 =?utf-8?B?cGJ2T0lUc29lZS8zQnY2MldQcnppQ2Z0THdyS2RPeTZob05kQUNZMEpTRkxw?=
 =?utf-8?B?WHcyL3lJSjFwZ1VsUWlRY3NUUTZIWU80N3piR3JWcHJsRWRZZHFDZTZQck01?=
 =?utf-8?B?OXVGYUlFaTNPb1psL2FsUEVWTDdCUzBKbjd3Q3pMVEdDNG5NbUZORUJVMmdm?=
 =?utf-8?B?YVp4WlpldmFsUWxrdUdod3Z1clBTdVNnZ004bmdLMS9uRTJ6d1FSY3Y2RnRU?=
 =?utf-8?B?TWpsRXlkWHhGckVEdFl1RERiMnlxV3dtOUh4NWxJOWhxUnZELzF1Z0RFSFds?=
 =?utf-8?B?bDk2VVVaSU56TFphTjhLSkJrUHZsR3hzbXVqSGlmeDVqZU4ycE1LNVJQVURS?=
 =?utf-8?B?dGZCSzhaWUwyR0xXK0drVkZWN2VadGp4OURKRkZpTWJhQWllNTJPSDc3NnJn?=
 =?utf-8?B?RVRLbSt6UWxlaGlLbTVpY1U2UmlrY3B6ZFVlekxrM29ob1YyQWh0Y2NmQ1BC?=
 =?utf-8?B?SytWNjg2T2ZnK2t4dmg2bi9SMXdlT3dDZzM4SXlHSVJiM3JYV0dYYm9sTEYy?=
 =?utf-8?B?bHkxUk5BYko1Zzh4WlBwbGhENVhnR2FQVXZLTlZQbVdtQmdRVktRUzVkVFZB?=
 =?utf-8?B?ZFZrTER0K1h1VWVzWnM4Y0t1cm0xd3J6cnZPaEwyVHVpVHEwQVlqejZyWElw?=
 =?utf-8?B?NWx4Zy9MbGJua0dHZXFBUUY3YzNFYnRWbmw4ZVpBSHBGUzE5Q3NHS1JMMGtX?=
 =?utf-8?B?T2l4em5zMi9YeDhWbHhNSm1hb0JoRkdLeXl0RTMwbTV4N1FYa0VCWnpEWUVG?=
 =?utf-8?B?T2VIVC81aC9tYlRIRVc0NlhYRzFnb1RGV09RMi95MVZTTldQMjhZYm8xYkhs?=
 =?utf-8?B?YXZ6ZnFNeGFoOXR4UjE1ZEc2ME8wd3NqbWl5eWRiUS9ZR0k5ZUFSN2pyT0x6?=
 =?utf-8?B?VXhjTTVMS25VWUxoNmw2VlQrNkJ6a0p2cUJrWVVDWWNqa3FlNERVcHp0RXNZ?=
 =?utf-8?B?SzJpRXpScW1RN1FHWFN4aktYOTdpcVpaeGdqQ3E0ZWgyM3ZhL0JpV3RJOHJJ?=
 =?utf-8?B?MndaZ1lNcXQ3MGg2SmlLU1JVUFEwRmFhMkJxbEtOTEd2YU5RWFRNYURCR0tQ?=
 =?utf-8?B?TXVpU0Njekg5VmNHVTU5NWJzeFFPNlBqY0k3aFN2NHRNeVRtRXpGWTN4dnNj?=
 =?utf-8?B?dEpNYkF1WTBtMEs3QzZVLzJ5TTVCRy9nKzAyTndhdmVTVnhmaXA3TjRmUmJ0?=
 =?utf-8?B?VGJyQUw2L2JYUzBXODVBNWFidFhyK0ZEd0FpaW5TcEZBa0hxTTV2LzF2Ujkz?=
 =?utf-8?B?TFNoTkhINW8vaWtReWNoRllEekwyR0pNTk85dW9RcVVHditWSWRsb0tCTjZC?=
 =?utf-8?B?U0MwNzY4WkdYNnRBRFNWbXFqSGw0L2hCaVJ6ZXZLQ3BFNXg0VkV4L3JYVlpZ?=
 =?utf-8?B?RUN4Y2sxNUVYWWJva1U5UkFDWEFzMDRtWUwxelF2OThVSlJyK1RIUVFaWkhl?=
 =?utf-8?B?bHZIQlo3Q2I5bTZTdzdvbjN1NGg0ZlNha3RDWDBJQkluUVdMTnJVZkh4UEwx?=
 =?utf-8?B?SjdlOXBxZFJlN3V3VU5jMjRxcDMwY2xQUzh0cjkxaHZ3YVZvbHZzSkdOcnR3?=
 =?utf-8?B?ZGxUU0RZQzhMYzFsMkxXTUkwNVAxU21XMzZlQi8zS0ZWWG1CbXBCR25zbnA4?=
 =?utf-8?B?ZFNZOFlhdGxGZm1TZXdiZTJBaXlEZjNJc0ZYQ1ZKbkhVdWc0azlLaDNWQVVE?=
 =?utf-8?Q?kYCIbbQJRiXn2+5+RwbW5KbgO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae239995-6385-4799-5203-08dc864e9942
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 17:32:11.9975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HEE1kLPaL0vRcp87RXX5Ug8/+LLcGZITUIUZVQIe05a4+VEmuimjdqmqQHV1qDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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



On 6/6/2024 9:13 PM, Eric Huang wrote:
> amdgpu_job_ring may return NULL, which causes kernel NULL
> pointer error, using another way to print ring name instead
> of ring->name.
> 
> Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 9deb41d61e8d..66c1a868c0e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -164,16 +164,14 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
>  void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
>  			   size_t len)
>  {
> -	struct amdgpu_ring *ring;
> -
>  	if (!buf || !len)
>  		return;
>  
>  	switch (rst_ctxt->src) {
>  	case AMDGPU_RESET_SRC_JOB:
>  		if (rst_ctxt->job) {
> -			ring = amdgpu_job_ring(rst_ctxt->job);
> -			snprintf(buf, len, "job hang on ring:%s", ring->name);
> +			snprintf(buf, len, "job hang on ring:%s",
> +				 rst_ctxt->job->base.sched->name);
>  		} else {
>  			strscpy(buf, "job hang", len);
>  		}
