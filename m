Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21E606A323
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3zKGyt2O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF83E10F437;
	Mon, 16 Nov 2026 20:16:34 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0A210F437
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 20:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+6/B0MuqZ+k5KFYx/phz7VdlQqyFzPKqChb8SDzKWz1hW/iwwav68GUG4SjJKAzaS6CG4QJvy0x/yOnopSTjR1e6KYyRgvZ2cox+BmLQ7jXnZ8fGuzEq+nXWylL2TJ81Q6zGDQl2mAaVBWxlqY8IWV3k3HGgulDU6/658y2PLet0kJB9qkyj5lkMtigKPRNZaE9KPT/5XSLcleZgOdH6kwg+xtZyQqnLIiOhDFs3pvjpKw3J9xahz+V+mTLYiCbtGijZ4Q8jh7/dAGYOgW+oWOCl4cBICb++KkYbVM3rmYtzv2d26JWB/hueiCF4/xeUgj/EJmPN9Dxr++3k9exRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlWlHxmEHG1lktUkGtPe4spTfBU8PE3UYzLdOTYqavM=;
 b=W6DuWDBkQ+gcdypeD8dr9ywaAtOwventFGOKJ4Ry/uwCGn/c5aPUmON9NBCkYzgU5hOI/+W5MJ4IdrGXLikIdSFda5CNXI5RgkeH0yUiYh0iHYEuzH/eZQqdTZGDFpBrrIahQM0EQMGe0I3UNuxmvngE0oY34+SEAv76Ih7l0y8GlC1n/Y2wtSmRel2l+yilM0vAZx73yBq/vKI0gKyCs4umDaechIYeZ+vtPsAfFAgGhRWgw4pVIEg4g8xDPmj01LXJNLPI8n7MNaS9Xr/O8cewwPyTJFXbkwMkdhqDgCzF3pTtx4FhFdVxxzfasst7/kXRRDd8eOQG37D84rdbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlWlHxmEHG1lktUkGtPe4spTfBU8PE3UYzLdOTYqavM=;
 b=3zKGyt2O/Rks6Tkjk2JdG362TknbCb68WJ1TMAsX5G/IIeLVSEGG2aPAfy3RdiWJi9Qt4Wxvs7N4sbFf6q27Yf8EBOEtUgCn3nW4UevaKstg9AoZeubT4D+lN9Y5uWzAIL3/zR8NbL3jrGzJZ8U/uQlLDOf4rvbtE+M5wok2YYE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:13:21 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:13:17 +0000
Message-ID: <0666ff8f-113a-429f-9540-d34b16795e1d@amd.com>
Date: Mon, 16 Nov 2026 15:13:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
 <20261116165713.1945549-5-alexander.deucher@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20261116165713.1945549-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::28) To DSVPR12MB449095.namprd12.prod.outlook.com
 (2603:10b6:8:4fe::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB449095:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: d55e1f2c-af81-4352-bc8d-08df441e0d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|56012099006|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|10067099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rbRiTzck0GSIS/4h367Bb+J58n8KOd3xGJP8/Bvx7WIQX4wtwKhrXejwjLRuyr0Ge4q2f1bYqqv9Ndzt2qSv3skkMYlHALRgcA66bCXjjRPeeXSj6Dbaa8ALJqupLEFnK1xvN757CRPCN+QQlA3OWYcBcGeIzJilcId+KO2xFRCs0CiI109RjLq0XqnVXLGfJKRld9FZtGclnLZrGCUiCTtdLdfMSz1bBIennfqXirQbU9oB4B8G1/kkY+632YoOuuu6uAMGR6f5SrxV2sf0wFh5Pkki5ShQL9XIG8mAwz9yxPbnTpU9SJDwfezxy038VAw5q2ud73/N1x5yo0zt3EZ/89kkhXsThckwIQV18B60g8Xe7X34ipzoTRKPGlo+rLA7CPvXmN+Fbl+pCKjFzSJ72Xb/FMXfNNPtNnYQPyj6vx2KTq/Jde/zJM0A+pzn2M62yGxG6b7MObb2WJLLrKPIbQM5WzNPqu0mWbQQQHb+LJ++ULsVD/0+ZF9NLdMtI3FEb+ctheGh4hvjugZdiAOueNYoU/3BoJ1RET/uomQDiCvkXC7PC4ggd5drbwNjyKpSkdqaLCcinkCJFdum6lwRAG4FPDhs1m8Ce7+Dm3/EkjyhJsA2F9OG3uuXdUzKS5oIxoE6I3AfjIUtr+vGAOF1nD/cECTXTiZyAhKeBwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3JnNWdaWllIbGdzakpyOTVUNUE4WTYrbHl6Q1o0VDJzTCtibnE0T2w3TWF1?=
 =?utf-8?B?MlpzalViakR0YnFlWGRXTGwwb1RaMG5pVnVpNXlNMHdIUG9JUmhuYjU2bnBS?=
 =?utf-8?B?ZXpIaVRMdVRrMkkzdmhhNHlFTFY4K0RFanFsWWVWelJZbSs0VFdPYjFjUFA2?=
 =?utf-8?B?V1RPd2dIaGhTWk41QldOZWpvRDh5SDQrYXRCcXpwOWRGRTNlYldqZFNGaDl2?=
 =?utf-8?B?dnkyc21qRmNaSi9uTjdmcnAyQzZkNU0vdVdYYU5EOXRSYXdGUVFycE12ejNK?=
 =?utf-8?B?VU40NnNva1lWTmo0QmdiMWJQNklFN2UzM0JKUVNkaGNiWWpqdWNodlEvZWJS?=
 =?utf-8?B?ejIwdE13VkIybnVyb2F5OGU0LzdMMFlPMW5ZYllvODB1SWY0amNsOGJCYis3?=
 =?utf-8?B?UUNHZzlpODY4c3NJbW1YTUtvb3dUclN4SzBxd2p2d2JCeldqTG9weXRNMW1u?=
 =?utf-8?B?UnVCUkVIMlc5UmFTMmptWjUwckRKL3BZQ1lTTVUzM3pacGRQYlJNd0JsQVkx?=
 =?utf-8?B?cFBFa3RGQnNDaDRyMXJkbzVqRUdwZllySGNERXQzWURJNkJOWEkyeWdDckkr?=
 =?utf-8?B?OVNIZHVpaEtUSkZWOFRqRVlGTG1zdEV4a2xEOUs5SGtqendwV1N3dGNrRzhW?=
 =?utf-8?B?cUhLS0VCVGVucjR2YVg5N1ZRWUxhb1lFNmhSV3EySHNKQkdwUkxSSm1mS0Q0?=
 =?utf-8?B?RngwKzRLcEQxS1FMSnY0Wm52TTNNTmVSVHk2a3ZZejZxaVN2YU9abGgwamFN?=
 =?utf-8?B?V04wZzVRVkUwZGkzWmpENWZMUnpLUTJHZGkvb0ZYM2s1SXVUNVFXaXJpSm5Y?=
 =?utf-8?B?RjFxYTlzM2JVU0NpVGZINUl4UlZkQ21zYjJvTnoyUG12SVAvMERiUUdBblp3?=
 =?utf-8?B?QlM2ckhNaG1DTHdtcVRPSnRlb2JpRGVrUmVXcWRrKy9TbHNaYmlsRzdMUExQ?=
 =?utf-8?B?N29HNDRCZUp3aTB2eEM4cmZxM050aFRraDMwU2JTYUtCcUpvVzVUUHYzK3Ny?=
 =?utf-8?B?M1ZyVEtYRVNiaDFZb3lFdVJUOG1qU0k3NDcwcjA0VDdZdHJUTDQrY3lURi9J?=
 =?utf-8?B?WTBVeVh0TEZCaWJGYm9Wei9BQWRzeUlEQ0xJVTdzTlZDRXZGanNQdTNxVmdu?=
 =?utf-8?B?NFA3Vk1pODJhanJVbkM4QStKQ21kSG1vUFcyVUtHTnJWVW1zcDFqeGpVd1gw?=
 =?utf-8?B?bFMyMUdOMEQ2MVRxQy9CaUp4dUdIWGdpS1hjNXJEOVIyNmxLbG1QVEtqN0E2?=
 =?utf-8?B?OGdXNDJxbzdWdDc2NXBTZUhJZmRvcVMyZzNveUVCUk0zdjFmTmJ4MzBIbm9q?=
 =?utf-8?B?UjJGcTR4NjVUU00rZ21lY2dtQlF6dzI0bVhlaTdWMmVPUHdHVHpnemNIOWV6?=
 =?utf-8?B?Mkp0bFZqcEo2aTdOUG5OS2JNbEdPM0lsMHQ2UXFzM1pDZnFnSUplNE9XM2hz?=
 =?utf-8?B?ZkpBbG9ycU5ZZ0xXNlREaWZ1Y2ppQ1JVaFdUNHBETU5yMU0xUXhuRXJ4TUg2?=
 =?utf-8?B?SUxpdUMwNURRZklaRGRDRThjbm0wazF1aXI5b0pnSGpYbEo0cUhzd0ZiRE53?=
 =?utf-8?B?eXZGcllzd2Y0L1Rhd0tTb3BuQ3RkQVhhLzdGUXJ0SFpySDRGTC9Ydk50cElk?=
 =?utf-8?B?V1VGQkhSTTBzMmV4Z1RaYVJXYzh3MThRZ1VNYzlRZllDRFFPSmM3MnJrZDVX?=
 =?utf-8?B?UDFmUkZMSmpzWDJhM2dEUytvVUhIRndOZmF4cGdFWlh4S3pnT2UzTHlrZlV5?=
 =?utf-8?B?U1k5dDU3aGplWVVBR3JOcWUzWGgvR3pxT1pobXc4N01ybkJReExoR0c5RFEy?=
 =?utf-8?B?d3BWdnZZYW5IWWp0VUhQMHdNclR5KzhnU0gxYmtqdWNqcDQzYUdSWEp2NitB?=
 =?utf-8?B?eVNXeTliYVhlQmtFRnk4UUlSMWNtMGRDN05rZHUxeE1KRDE5SjdzZitXMlBT?=
 =?utf-8?B?Z05Lazc5M3N0cU9tbDhFR3NydnBHYTRLeVRmRFFJeWpTV0wwVmx1NGh5MWF4?=
 =?utf-8?B?dHpnU2xoUWRaVkNhbmpzTGN6ZTNnZ0Frc3pYWWg2SEpHV1BiK3lLdk5QZHZ1?=
 =?utf-8?B?ZThvN2dia2xYaDBQSEZZOUFwTEtHeExyZ3FidU8zekgvMUc2bWE4WUdoMGli?=
 =?utf-8?B?YjJHM0Jzak9TYUNqNjNEaElveHQ5QWJQb1BKck9CbGh1TDRJUGEvRS9Mc1lN?=
 =?utf-8?B?d25NTHZJdTZDNUlFT3BtKzlwcU1MakdpdVNjWnZXaVowb1RJRGhPOW9XM3Nj?=
 =?utf-8?B?WDRLOEJVY3V2dGZRTDNoamdGcFpQc0I5WDIzcDdGT3Vkb3JZVktFY0lLRm41?=
 =?utf-8?B?M0lmZy9DOXdKSVQyYmlqcEFVNGUrc0x1c0hoc1BEcGFUOVlPcTFjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55e1f2c-af81-4352-bc8d-08df441e0d78
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:13:17.7183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNLUAPjFchmw8jE6FzCNIinaI0NokCH/cmcXxCnMHcgpNP83enCj9+GJuFzRo/sw615FLg58R/+vR4ZY8hYjQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

On 2026-11-16 11:57, Alex Deucher wrote:
> Not emitting the spm update via the ring causes CI flakiness on
> gfx11.  Add back the SPM ring emission, but skip the MMIO path
> if ring is specified.  Do this for all chips with gfxoff.
>
> v2: drop ring code in gfx 12.1.  We aren't supporting KCQs on 12.1
> so the code is not used.
> v3: emit via the ring for all chips with gfxoff
> v4: skip MMIO writes when ring is non-NULL, fix ib emit size
>
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Fixes: 2fb5a4572c76 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 16 ++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 17 ++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 18 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 10 +++++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 17 +++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  7 +++++--
>  10 files changed, 91 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index f98a7c6797b3c..ae028eeacaed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -121,6 +121,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		       struct dma_fence **f)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> +	bool emit_spm_needed = adev->gfx.rlc.funcs &&
> +		adev->gfx.rlc.funcs->update_spm_vmid &&
> +		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
>  	struct amdgpu_ib *ib;
>  	struct dma_fence *tmp = NULL;
>  	struct amdgpu_fence *af;
> @@ -209,6 +213,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (need_pipe_sync)
>  		amdgpu_ring_emit_pipeline_sync(ring);
>  
> +	if (emit_spm_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring,
> +						     adev->vm_manager.spm_vmid);
> +
>  	if (emit_gds_needed)
>  		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>  					    job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index e38a8ea02c520..2ae2c1d0f702b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -292,7 +292,7 @@ struct amdgpu_rlc_funcs {
>  	void (*reset)(struct amdgpu_device *adev);
>  	void (*start)(struct amdgpu_device *adev);
>  	void (*update_spm_vmid)(struct amdgpu_device *adev, int xcc_id,
> -			unsigned int vmid);
> +			struct amdgpu_ring *ring, unsigned vmid);
>  	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7683e8a0a4380..b28dd5eaf1bbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8187,8 +8187,18 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> -{
> +		struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	if (ring) {
> +		if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
> +		    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> +			u32 reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
> +			u32 data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +			amdgpu_ring_emit_wreg(ring, reg, data);
> +		}
> +		return;
> +	}
> +
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
>  	gfx_v10_0_update_spm_vmid_internal(adev, vmid);
> @@ -9692,6 +9702,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>  	.get_wptr = gfx_v10_0_ring_get_wptr_gfx,
>  	.set_wptr = gfx_v10_0_ring_set_wptr_gfx,
>  	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 + /* update_spm_vmid */
>  		5 + /* COND_EXEC */
>  		7 + /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> @@ -9749,6 +9760,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>  	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
>  	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
>  	.emit_frame_size =
> +		5 + /* update_spm_vmid */
>  		20 + /* gfx_v10_0_ring_emit_gds_switch */
>  		7 + /* gfx_v10_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..c0e74e12cd15d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>  static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> +				      struct amdgpu_ring *ring,
>  				      unsigned int vmid);
>  static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
>  static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> @@ -2606,7 +2607,7 @@ static int gfx_v11_0_rlc_resume(struct amdgpu_device *adev)
>  	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
>  	 * once it runs, also after a GPU reset or a resume.
>  	 */
> -	gfx_v11_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +	gfx_v11_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -5615,12 +5616,22 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 reg, pre_data, data;
>  
> -	amdgpu_gfx_off_ctrl(adev, false);
>  	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> +
> +	if (ring) {
> +	    if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
> +		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> +		    data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +		    amdgpu_ring_emit_wreg(ring, reg, data);
> +	    }
> +	    return;
> +	}
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
>  	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
>  		pre_data = RREG32_NO_KIQ(reg);
>  	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index df2fb09bbcd86..0c212b9a56398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -287,6 +287,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>  static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> +				      struct amdgpu_ring *ring,
>  				      unsigned int vmid);
>  static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
>  static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> @@ -2158,7 +2159,7 @@ static int gfx_v12_0_rlc_resume(struct amdgpu_device *adev)
>  	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
>  	 * once it runs, also after a GPU reset or a resume.
>  	 */
> -	gfx_v12_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +	gfx_v12_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -3978,12 +3979,23 @@ static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
>  
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> +				      struct amdgpu_ring *ring,
>  				      unsigned vmid)
>  {
>  	u32 reg, data;
>  
> -	amdgpu_gfx_off_ctrl(adev, false);
>  	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> +
> +	if (ring) {
> +		if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
> +		    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> +			data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +			amdgpu_ring_emit_wreg(ring, reg, data);
> +		}
> +		return;
> +	}
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
>  	if (amdgpu_sriov_is_pp_one_vf(adev))
>  		data = RREG32_NO_KIQ(reg);
>  	else
> @@ -5322,6 +5334,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
>  	.get_wptr = gfx_v12_0_ring_get_wptr_gfx,
>  	.set_wptr = gfx_v12_0_ring_set_wptr_gfx,
>  	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 + /* update_spm_vmid */
>  		5 + /* COND_EXEC */
>  		7 + /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> @@ -5369,6 +5382,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
>  	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
>  	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
>  	.emit_frame_size =
> +		5 + /* update_spm_vmid */
>  		7 + /* gfx_v12_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
>  		7 + /* gfx_v12_0_ring_emit_pipeline_sync */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 1f57d0fa2c044..227942e87cc8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -217,7 +217,7 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
>  static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>  	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -				      unsigned int vmid);
> +				      struct amdgpu_ring *ring, unsigned vmid);
>  
>  static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  				   int mem_space, int opt, uint32_t addr0,
> @@ -1866,7 +1866,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>  	int r;
>  
>  	/* init spm vmid with 0xf */
> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, adev->vm_manager.spm_vmid);
> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  		gfx_v12_1_xcc_init_csb(adev, xcc_id);
> @@ -2945,10 +2945,14 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
>  
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> -				      unsigned int vmid)
> +				      struct amdgpu_ring *ring,
> +				      unsigned vmid)
>  {
>  	u32 reg, data;
>  
> +	if (ring)
> +		return;
> +
>  	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
>  	if (amdgpu_sriov_is_pp_one_vf(adev))
>  		data = RREG32_NO_KIQ(reg);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 58135757190c8..3c9e478d5f6e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3477,16 +3477,19 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
>  
>  static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 data;
>  
> +	if (ring)
> +		return;
> +
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
>  	data = RREG32(mmRLC_SPM_VMID);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index df935827b002a..e818280139791 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4084,7 +4084,8 @@ static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
> +
>  	return 0;
>  }
>  
> @@ -5483,10 +5484,13 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
>  }
>  
>  static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 data;
>  
> +	if (ring)
> +		return;
> +
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
>  	if (amdgpu_sriov_is_pp_one_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2e2673a6dbbf5..be45c10b6f579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5227,8 +5227,18 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> -{
> +		struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	if (ring) {
> +		if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
> +		    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> +			u32 reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
> +			u32 data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +			amdgpu_ring_emit_wreg(ring, reg, data);
> +		}
> +		return;
> +	}
> +
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
>  	gfx_v9_0_update_spm_vmid_internal(adev, vmid);
> @@ -7548,6 +7558,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.get_wptr = gfx_v9_0_ring_get_wptr_gfx,
>  	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
>  	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 + /* update_spm_vmid */
>  		5 +  /* COND_EXEC */
>  		13 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> @@ -7604,6 +7615,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
>  	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
>  	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
>  	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 + /* update_spm_vmid */
>  		5 +  /* COND_EXEC */
>  		13 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> @@ -7663,6 +7675,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
>  	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
>  	.emit_frame_size =
> +		5 + /* update_spm_vmid */
>  		20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 151336e6094f7..f28ffe8a5ac55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1586,7 +1586,7 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -1609,10 +1609,13 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -					      int inst, unsigned int vmid)
> +					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	u32 reg, pre_data, data;
>  
> +	if (ring)
> +		return;
> +
>  	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);
>  	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
>  		pre_data = RREG32_NO_KIQ(reg);
