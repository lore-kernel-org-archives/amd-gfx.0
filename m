Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5ABC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 09:25:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A119610E373;
	Fri,  4 Mar 2022 09:25:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4B610E373
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 09:25:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcHxdIxcf9BO3vuth4xb5piE8XQD3dsSYIeYT4RqKXMb4b8+ZUdrnCffwY0RUXc5jcKYEPgcaBs1kDZkn4bipKsIDQm1L6G8DlPz+Hi6EKg8lCkQ5DB1mw5Dsvx7n23wBNpCiHsPQwU91sAA7YA452eF62U/YEvMIQJKSC2R2ng6ZACYc7KZcTHHKN3Pah0dLnj0JwpX5dIiggLjFYqmJfYhMgd78wwPz08iErtRwcto+ijA2GweHXXlMdl32ox6ZLU/MOem15durJP+45TGceDoQFTdurx+c/6/rZtNUwIEFmbAm7SQ9OEzTeL5l3URnMyikcrBk2bU0dSHFf96Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9SxOr2F2klxxPFOpSGdjafC6rqfidTSzOBxWYk5UsI=;
 b=CYun54RB3zmvvRXfxSiQozQRNTavZ36rkXmdMlQYZAzlZAT0kgbQpvj1csDpL79iespRhg9Qjj4NB4mm3umdLPoBl1ZX+xOcU614/aM7+HKDoJtMyUGl6KA4AhibTXoaxfrulfcDmaosL3dUzVt+VDX8QW6ve5Qv/cPyjrAIGOLaQTt8hlzJ0TwyubdQ1cp55ooohxj7O39gopfsFr/uf/gT2Lz/aZ04GwP6lVfa4QcDNyg7ZCXF/aMymv/X9jyp7ZUGFK4KONt/l34wicKDMaEFqOohXG0XYlgjjk3YSozBeMJ1fz0A+T980xJFH5r1ip/n/3cLca6ZxIMek/Lfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9SxOr2F2klxxPFOpSGdjafC6rqfidTSzOBxWYk5UsI=;
 b=01truX4c5zauJdLLsLv5fiHHJ7NstIWnpT74H0n5P4obCtl3W05iEsvPKOftr5wA9ak+iRLjojrJDe8Lf9M6YluEZ0cT86xfX3wdZ5K6LNfe9ToYBQT6y6DdpsSj81gYkNI6h/ZDMExK8BFqhkf8I7CrrKmirNyW0wqKbvqs5/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4841.namprd12.prod.outlook.com (2603:10b6:5:1ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 09:25:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 09:25:42 +0000
Message-ID: <6edf5bbd-e498-5979-9449-a824706532d3@amd.com>
Date: Fri, 4 Mar 2022 10:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220304091555.4094582-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220304091555.4094582-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0107.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23059661-e959-4f92-e6be-08d9fdc0f438
X-MS-TrafficTypeDiagnostic: DM6PR12MB4841:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4841A4D4577394BACCAFFD6E83059@DM6PR12MB4841.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vGxTGxYhwOUpD9L13WLO6is3FNfmoNDUqeknvSPtjMGiVB4jiTZdcdtguGMRq4Tkk0BSLjjQPqFUcULfXnw0zno/OphVX92MXfHaq+yu/CZ5ATr+hLhcM5gnCwtTOffo8sq0Owaaw9G0NVCJFrYFK0GmQloidjzV/0ybTyQWQhv3afk1BM8su1u027LClq+nI2Ihl6Z8Ij3wXH4kln8jq97QOWSk7HHLkku2H0Z0HtFBL0Zgsk5d0XWSCuHjgbiCnDdxpBUbhJv1iJ+DlVusQJoHq3eYm25NhWr4l++ou2ZF+b6wN+4BgIwFjajrrL2Ua/QUpTJdS7UFhEdlK6zpPhIcvQDfwBLgK5SgwJpdaDfbcZAedmKzJq4fgTzpfkRWt5bx0lL2QMe3GXU4awWTXUII1cfKbJaep8vcVq1SZz1Aaw2GTpiHfUN12d6GMNh+mWV4cGJyZKVuN8oGdiOhz95V9o7+LUPp2TvNDadr88GiQnUt0WSm7I1X6omObXSIYTwSCFWwbw1sLxhBr7C+D/gZP3O/84G6uEte3mSyI9ZCYUjyEtC1BLaLaeGUZiv2WC7DTJmn2VZhJsupNqyntjxBiibhV36GUghO99T+goGiiOP9SWO1HB0PMF5G3kG0OC8o25f1XwNdH4TrPeTOXGlXlOu0BAOJArRrzZi5hX6PUhqghUwqWnfWI0ytFXRdifcfr/PTZQ07xlGB004M9Wj3fqLQp2WK7WbfG2yKVTtPxApTXeH5QE4fKtnaB6/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(4326008)(83380400001)(2906002)(316002)(31696002)(36756003)(54906003)(6512007)(6666004)(6506007)(8936002)(38100700002)(508600001)(2616005)(5660300002)(26005)(186003)(31686004)(86362001)(66556008)(66476007)(66946007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9IeE42TTEwTnFacmlEbzY4Nk1uYlVhN3ZGR0lLRFdIM3NvdWZONW1LN0dj?=
 =?utf-8?B?eEtFTEtzbVJCOUw2WVFqU29Db0g3L040dm5oMnpmM05LVHFGR0tGWFBQRHQy?=
 =?utf-8?B?TVc4cEtsSzVVblY5blZYbEhSc2ZOY3FoL3k1QkpPYmY3YXFSNDg1bjhoZ0FI?=
 =?utf-8?B?M2Nha29FbzVPNUtVQ0tHMDROZkRZRWlVQTA2R3duM0pwZmRoNHZkSnNTQi9X?=
 =?utf-8?B?QTdwUkIvR1NGd0VodFlLMUFrL1QwZFZIbXVablBRVm1Ld0NleEMyNTcrMEIr?=
 =?utf-8?B?RlphcjZ2V3ZWc3p1NXBYU2gxOGN0K2ZnOVBzUy9vREpUaFJMRmtjUnRXWW5S?=
 =?utf-8?B?QXlOZFZ2YTFITUFVR2pmWVVoamxUdTJiQ1NVcUNRTnpmb2ZxdlFscktUN3E2?=
 =?utf-8?B?SDlTYzU0cy9WcW5aOEpLdVcxdFI3cTRJbTF3ejJaRkFKUXF3bHJsYVhaeHpy?=
 =?utf-8?B?NHplL3FGWFNpM0FaOVBKNFVaYlRTdG85VUhUNmlwb2FQc1dmZkdUZHVzK0lT?=
 =?utf-8?B?YjVJNmZVdnY4OGJ6S3FiaTNHUUdxYTdqN3VJQ1Q5QTk0Qnk2TEgwdGp2QnpW?=
 =?utf-8?B?QjJaUDRVbHJYeGZoaGc5UXZGS29yWWpMMG5HT1FxVnJMYkNZbFdSNDgxckMw?=
 =?utf-8?B?VzJTUitlUkxQV0NkLytPZGFZc21EYlJtaGJZS3dlYlBzSGVYOVp2dUw4QlVS?=
 =?utf-8?B?N2Q3SXBqUXR3UUVJOFAzY1d2ZjNDZ1ExTXdKanpvY1JWOU9vN0NyS2lKWkNV?=
 =?utf-8?B?UUltK3kwT0dsRXcvU2ZCRkorT0NNdVY0a3dtem04YnVkMVNtSkllRGZCSUZT?=
 =?utf-8?B?UmszSVJTNDk2TklXMjA3Zlg5L1ZtQWZ1c3FBeDdBL09wVG9FYThoc05oTlZz?=
 =?utf-8?B?MXpxcFZnQXIzelU4aG5WdlpsY28rR2RhQXNxeHFHek1LNmJmQnpRZ2xHRmhJ?=
 =?utf-8?B?U25iOVlDdGI1Y2JSd0tOQ3EzdEZmNTdmbGN2MVNCWDlIUTJyaGEzWElrS3ph?=
 =?utf-8?B?dFA1NjZxRDhCRWdXb2VLcVZmUlY4T0lNTnhYWG9xc29vYllxZ0FDMW0yWGJl?=
 =?utf-8?B?b0l6L3llZFUvY1l6SVFaN3NIbTNibWZxcFlxVXN4WUtFdkpPdVF4aU14b1F0?=
 =?utf-8?B?Y0VSalM1eUtQYnVmaWtNUGJ4UmtnREJ6dURJc0FTRVlqYklQN2dVM1ViMTZS?=
 =?utf-8?B?UUErRTVKcEVBMzRYYnowaVZWUU55YUN2bnBrOGJCbUtRdkNwQTVpc0huMzQ4?=
 =?utf-8?B?cGtvTS95alNFUGpUb0l2YWkvcGF1RGt3TlhmczFVQUc4TVh2NUJDUWFvTXNH?=
 =?utf-8?B?V0o5SVk5eHozV3JxM2VDa2FYMDlwVDVpNHIvb25FVlJhYXEzOHFkdlVyOUpM?=
 =?utf-8?B?aEU4K2E2QU90NDJyc2hmSG81Zm02QTJhV3hITGc4d0JsSzIxK2NEVnd2cldK?=
 =?utf-8?B?MEdoWmx5ajFyU0RpNGNPdkhuVHl3aVFpWDNxNUp5OEJDUTJ6bGIvOVAvV0dX?=
 =?utf-8?B?VENmU2hHcE9KaXBETmNHT3hCUURDMERzUjc0MmFHSFZBeFNBYTVlbDRoVmRF?=
 =?utf-8?B?a3lINGhuaDhtMjV2b1Y4NHhnZlhPTUVoaU1UdkcvWk5CNFlWUEdKL3prc3dz?=
 =?utf-8?B?TWI4QVZtc3ZjcGowd0hJdHhES2xvLytwWGFVMlgreFRIRHJvVjJtNVpmRWtz?=
 =?utf-8?B?aHFaUWZjUWkwVzZzaXBTYzVSbmxSZlE2Y0pMVFBXVWNVMzhGa3BiUTNjSThj?=
 =?utf-8?B?bWtDN3R5blNVTFlBbHk2OTRBZjFTY2RnTnllZTQ0bmNuaVNWeFpOQ3hDWmtF?=
 =?utf-8?B?OEk5WWdNdE5kWGs0dnJNNEdrbGNUVzZ0SU1DeVFId0U2S0RwV01yYjR3V0hQ?=
 =?utf-8?B?Z09qWUJ4UUN3Y0QyMyt2VGtGUll2a1JOeDR4Y0ZoUXNmNmlxeTFNMWhwUHBx?=
 =?utf-8?B?a3lpQUZVTzZCblVSWUg2RE9PVVJ2SUs2NjNVSCtqdUVTYVp4ajlnVnpsVVhO?=
 =?utf-8?B?UHFqOE41YUpTc0Z2WnE1YUtLd3lmL3JvS1RnM2ZhdldXdG9OcEYvMHdJUnFX?=
 =?utf-8?B?NGZRNUh4eURYc3o0UjFuWEJvQlNhYWdEZGwxcHg0cVhXV2FIdG5WRlpIS0ox?=
 =?utf-8?Q?jGdQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23059661-e959-4f92-e6be-08d9fdc0f438
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 09:25:42.4741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8lYS4M4+/jXKZzrbxQdo1EqaR/DdtroVkTDi+JNRaY1E/nGG4maVoDqxoqbphA/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4841
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.03.22 um 10:15 schrieb Lang Yu:
> It is a hardware issue that VCN can't handle a GTT
> backing stored TMZ buffer on Raven.
>
> Move such a TMZ buffer to VRAM domain before command
> submission.

Please don't touch the CS code with that. What you can do is to 
implement a Raven specific patch_cs_in_place callback in the vcn_v*.c file.

See amdgpu_uvd_force_into_uvd_segment() how we handle the 256MiB window 
on really old UVD blocks. You just don't need to implement the full 
parsing of the command stream (yet).

Regards,
Christian.

>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index af12256e1bd3..66345f2ce6ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -393,6 +393,24 @@ void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
>   	spin_unlock(&adev->mm_stats.lock);
>   }
>   
> +static int raven_vcn_tmz_quirks(struct amdgpu_cs_parser *p, struct amdgpu_bo *bo, uint32_t *domain)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
> +
> +	if ((adev->asic_type == CHIP_RAVEN) &&
> +	    (bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED) &&
> +	    (ring->funcs->type == AMDGPU_HW_IP_VCN_DEC ||
> +	    ring->funcs->type == AMDGPU_HW_IP_VCN_ENC ||
> +	    ring->funcs->type == AMDGPU_HW_IP_VCN_JPEG)) {
> +		if (domain)
> +			*domain = AMDGPU_GEM_DOMAIN_VRAM;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>   static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -403,6 +421,7 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   		.resv = bo->tbo.base.resv
>   	};
>   	uint32_t domain;
> +	bool need_retry = 1;
>   	int r;
>   
>   	if (bo->tbo.pin_count)
> @@ -431,6 +450,8 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   		domain = bo->allowed_domains;
>   	}
>   
> +	raven_vcn_tmz_quirks(p, bo, &domain);
> +
>   retry:
>   	amdgpu_bo_placement_from_domain(bo, domain);
>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> @@ -442,6 +463,12 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   
>   	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
>   		domain = bo->allowed_domains;
> +		if (raven_vcn_tmz_quirks(p, bo, &domain)) {
> +			if (need_retry)
> +				need_retry = 0;
> +			else
> +				return r;
> +		}
>   		goto retry;
>   	}
>   

