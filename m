Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6F7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 06:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3344C1128CC;
	Thu, 23 Jun 2022 06:31:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246851128CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 06:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVzBt69liHK9r4R/QthPtVFWpxtZ11uN77B+n4ydZ4ssvLf/d70b2nWNWrrQqBVASW07goHpM8mdWY+Yl+aYq5rf9PzhDFNy43l8hrutmPQWoqnyCh9Dstkug6mOEqfdA7ASBKT6IG0Mx1tk+zuCWG3rYR5Ed1R6ouXsNJz5y+0jEOnDufLb/E/GOXCkVcNY6X98S/olFtes0xTETwrBbRgcFCT5/SB/jMds1mAYYWB88kVm2SWSXvDXX9LAi3EioW4Zjv3mvaNXM9qXLepp1gx06AgMYHmMOpM21Q6ehS5Op1iATHpN31KSd0/TRJwHrgvF8S1NpOGV1phl81diiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMJcDlFDCoQcdG721b6cRiLS8I7jbz/+UQeNcxeMP84=;
 b=HHcUfo0gLonsD6z2XMXLp9vbbk6hu0ZWeO7FWp9g9DDgnBkFO+5lVZEVFh1g8psRbC8xJsHH1eFRb+lNQL2H+K0mJImhffdIvIkLFEuhuQWnTpIkFZ59EB7wtRadyrHV0gQK7qwRem1KaKAdIDV9t9Nj/wmMtUv95wufT4YkwljcCm5qTh/QofCG538RrFqOaks7GtDMqT7w+mHJxATVyZXf4kKHYGWyk+rDmGNWgightvDC3/46peUxjYiqtbwC0hElkeeXyh0N45i0+YrmncO4BvFmESdZW9x6HKOH1dmEI8cKWG8OGZ5803vtGtjsMMJBlB4xdlVYv8DEk7lWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMJcDlFDCoQcdG721b6cRiLS8I7jbz/+UQeNcxeMP84=;
 b=4rvSj6Ilrn3QvA51xMQkYhj87ZHUM81iE0gkVePSlAvp9BcM6CjjgdgGlx237LNPjH3+2mndlLWnV7pPkM+Hyj6+bbQZNVt9bQMC4hZP1nodlW9xwLggWGw3moa6CiuLIGDb5heMQoRPLXb8uJA/o4k9rkFLGfqCXi8jKvZr9mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR1201MB0194.namprd12.prod.outlook.com (2603:10b6:405:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 06:31:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 06:31:26 +0000
Message-ID: <5bac2303-49e5-34b1-3955-3527f6d7ea11@amd.com>
Date: Thu, 23 Jun 2022 08:31:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdgpu: Protect the validate list with a mutex
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220623042512.13815-1-luben.tuikov@amd.com>
 <20220623043944.29880-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220623043944.29880-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1168ff4d-dba0-4f90-b1d0-08da54e1ff84
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0194:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01940E1F4CC8597455F991A483B59@BN6PR1201MB0194.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXF/jD6ZlOeVi5ZCZh4ehuNs88x0/aHp6dfXn3ywL6mIkHvvW/4WCFYNhXgPC69O4rn+OU0CiKjANM27BJtodlpI4DPMAERLIDhdd40UH5Lask5CpEYLTJU2jCtp6U+imgWQfKkHW1+ngMf8ttFp4EptkTtZS+t7ezsxzvI/pSbXdq1Zy8hz/BRdU4xx3WEjoyp5i8KVN2HykZyfFFhpSeSfIqi98Bn4QlQ2Kmxtxp+oP73GVxnt58xgV6TmlbKEmaxrsYkp7F/tYovqj3nilc7aAljiWCfXDiOj8DFzGGzVdwDIcAX+lqRSmqyyON9Bas4sHubkxjsXrnZqr0rAwFdECFFONvplMnTgx7hlyrCIvJ5mEdESoK3TSbiLL9CKHQ49dK8Q+u26f/9f2vWmukkn7ZqwJQ8N5kiBuJY8c+970+xIaHKxYlP5XVuEAbqxgJwDNttRmqs0xO262QzWlPEAYocDX0ZJ0ZrFkKKJQbPKatXmAt3/EDLwPoTqipDp0KID3W82mcDCMMt+hz4XHR3i+NrmUsm5OGUZUKoTpeYQAeGIVi+tly8z4Zu3iSJ1uZLvc1Uxe1hNFQusiRjfR1X284dkoZl7/Z9KAI2kXOkCmn7EKGJo3k8yVGiCksbeD3kXNVUKWRps0JOV57fMKJxE4L+HKQHxGlYbWeC+7D9EpF/laOFxpLsDlVorJshs+K3011/hDEMxX75KfO8ZC+mw6Gq0+HM4a091ARtkRqna4WL6fanFbofNlsx5tr6V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(15650500001)(31696002)(86362001)(83380400001)(66574015)(2616005)(4326008)(66946007)(66556008)(8676002)(66476007)(186003)(38100700002)(8936002)(5660300002)(26005)(2906002)(6512007)(6506007)(316002)(31686004)(54906003)(478600001)(36756003)(6486002)(966005)(6666004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1IRzhnSjh1YjUvQjhITVVUaEhLQU8rL2swVG0yZlNhRjhNckNoQmVKWnRm?=
 =?utf-8?B?aGRkeEJBWXZpNTlBYi9VTmdJbFRxdFEyOGNhZHROZzJLd21nZGVtTkNZQXdH?=
 =?utf-8?B?VUZOSlJacElRemtScnZ2ZVNSdU1jU2dyNFVzVlpEVmtnUm9NVkxmY3pvTHlt?=
 =?utf-8?B?d3E1dlJMUUI5OG1wYXVETXNGU09iZmNvY3pheFR2cW5CNUo2L0tnanhzdmVI?=
 =?utf-8?B?QnAvR1NkMzFvYnc5djV5T0J3azA4Z2pydFN6U3hCeUNZei9Pb1pFam5MRkdO?=
 =?utf-8?B?NVRSRW83cDJpVlJVaTV2VW43d0tSdEhoR0duRmo3UzRHT1RKTkpYRVhRTml2?=
 =?utf-8?B?aHZBZnQ4Tmc3TG5ZckxlQS82dTUwZXpCcTFhUkVlRVVpQ1QyTGNhV1lVdyts?=
 =?utf-8?B?dTFMYVJFUGJDWjIxVjZLN2FuUDRCWkZic2JGeVQremZDckpBYTVkVGFlQWNy?=
 =?utf-8?B?WVhxRzlQb090SVVuYVNpRkZGVXpxSGhLQk5ETmxJWExCV3FOem50ZEtLckNk?=
 =?utf-8?B?MC9HMXMwUGV5SkVHbkpFOWpvZUJ2WjZvbTBrRkFoOGk2RjU5UnJvazZmZ0gr?=
 =?utf-8?B?WFFqWjErTlRTcFc0SzV5Ri9HbkJLTkZ4SGIvV2NGODVaYXEyd2lMNlBnMHpM?=
 =?utf-8?B?S3pacFNLSzRvbW96VnZ2S09IZ1hvZTYyb3Qwc0tpUVhBamsyMkcrSmNjZzRk?=
 =?utf-8?B?Z1Q0aS9GTHFxNkZvM0lTWXFqQ1diR2lnWkN0M1pBMHRSUUhFVWlJbUtBV3lD?=
 =?utf-8?B?Uzgwd29LNWh0NnhYdDFxdjJJK0c4MEprdUF4Tm45WGsybTA4QVczdWRkVHhN?=
 =?utf-8?B?a0RuSFpZNmhPak4wcmsyQVA3cE1JaUs1OE9nbkdFWTk4aUszRlRPUmdma3Qw?=
 =?utf-8?B?RTVLeDNsQS9UM3RkOGd3aHVWbHYrd1dreEoxVEdKK0M2NHRnRmthUVMvTDZj?=
 =?utf-8?B?Qk55cENhalNnTFFRL3J3NWZudVJpQWJpbm80ajVMcUxVeTlMaVBIK3NkOVpG?=
 =?utf-8?B?WEVNbk16am9jdG5xRHNLUzhyUzlFNDRncTlaMUJNK293cGpaWlJ2RDJkQmZk?=
 =?utf-8?B?SE0wZGovTTB5UFZjN3VmSUZxY0FzT1RTcEh1dGZoZDVITGNCcmt4ZndGQS9D?=
 =?utf-8?B?bEJ0bWxqSVQ1VGNDQVVKWU00Q2kxcUlka1FramEzcGlFK2lTazlsSmxqdWRo?=
 =?utf-8?B?cHFheWpNTkRCWlloVVVTUVh6OUxXcXVGdVpuQ01nR3RrUTdFcitNYjVMY3hF?=
 =?utf-8?B?QXk5bEcxZjF0dUZNZmhFRUticmZhNjJTUjZoTEpYclNpL1ZTcU43STNuSzlG?=
 =?utf-8?B?ZlhHSnNTdS9UQlVEbVBxSGhydENaaXQzQU1JWWhJWThBMjlEWko0QjFXY3dY?=
 =?utf-8?B?YllXSW9CQXB5cUxLRE9ZRTdRcm1rVHREYnV1alkyUzhYbU1jNmYrdjBQVEZz?=
 =?utf-8?B?TVZrVGlEOTlKU1FGczBKVlVCYkZyRVNwaTZ1NHhEdTZHTWdYTmwwU2wwVlRq?=
 =?utf-8?B?NmcrZEZnK01rcjhOK0RCVjYwYmRtaWMzWGpqWG8wbTkrTkgySGZ6WlJaOGpT?=
 =?utf-8?B?SE1SQXFJMWtvWWdDbk1VektiamJOK2JQTGM0aVIxN2xmTUlSejluNDE0cXk4?=
 =?utf-8?B?N0tFblMrVzJBRUVxd3NKT2ViL29OL3dlOFY0UWUreVBNeXBaejR3M2FReTFR?=
 =?utf-8?B?WDR4Q3IveDhlOXljNlJheklWc2EySFdHaFpMaVhPa2txRE5jVHdhVlZzejdG?=
 =?utf-8?B?dTcxcmxJVjcxMldwLzRyOFRlYjB2UzZmc0dadHFvL050bVBRajJoZURmMnM0?=
 =?utf-8?B?Nm82Q0hhRDYzcktDWEFrSDMzaXVDUEZ6R05jN2V0TDlCNU4zOFcydFdqYWVC?=
 =?utf-8?B?dEZJdmJsdlJ6Q3RJc2pFMnFmaGNqV0xRd3d1UlQ4VHhoRXVMZzEybFFCQ1Nm?=
 =?utf-8?B?ZXBTUlRhRHBLYXlhTGJXV2lISDhFcGdjb2pLSnk5WFliZkhqM1RSYzFqd2dj?=
 =?utf-8?B?VXlSNnBKeGlVNmtJcGxESHdIaFJmaW5TL2psYllRemRvWXpyVXZtUllDMXdm?=
 =?utf-8?B?ZVhZZnNNVHcvUWVZM2RPRnpxOU1QUU14a0xsZlN2M2I2UjZJT0owZUErWFpW?=
 =?utf-8?B?L0QxdXZDbWJia21GZzA3MzRaYU1QRmY3QlNJdm5GaEtYaVdzL28yNVVUT2M1?=
 =?utf-8?B?YytSaHl2N3VXNmpmY0gwd0VIcnArN1h0N2VtcXJBbUNRaGNzS3JmblRzRWll?=
 =?utf-8?B?dUh1ZTRYeVY4UTcvR0VzS09USGVOM2hhTWJNb25RTHlnTmtnR0R2QTg2Rmtv?=
 =?utf-8?B?dlNVSVBJdkhxM2dGZXlQQVp0UFVkaDR0UGwybVExMFc1RVZ2ZTVYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1168ff4d-dba0-4f90-b1d0-08da54e1ff84
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 06:31:25.9951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYOmv4elWNuiHec/GEBP0PCzWqhNMW1D0H86ECXxxAJ5d0AhXwmjxG31wGJPtSCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0194
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The mutex must be added to the bo_list structure, not the parser structure.

The parser is only a temporary structure we allocate for the current thread.

Regards,
Christian.

Am 23.06.22 um 06:39 schrieb Luben Tuikov:
> Protect the parser's validate list with a mutex in order to avoid buffer
> object corruption as recorded in the link below.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 30 ++++++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  4 ++++
>   2 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 36ac1f1d11e6b4..0be0bf17c05420 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -498,6 +498,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	struct amdgpu_bo *oa;
>   	int r;
>   
> +	mutex_init(&p->mutex_validated);
>   	INIT_LIST_HEAD(&p->validated);
>   
>   	/* p->bo_list could already be assigned if AMDGPU_CHUNK_ID_BO_HANDLES is present */
> @@ -521,13 +522,15 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	amdgpu_bo_list_for_each_entry(e, p->bo_list)
>   		e->tv.num_shared = 2;
>   
> -	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
> -
>   	INIT_LIST_HEAD(&duplicates);
> +
> +	mutex_lock(&p->mutex_validated);
> +	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
>   	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
>   
>   	if (p->uf_entry.tv.bo && !ttm_to_amdgpu_bo(p->uf_entry.tv.bo)->parent)
>   		list_add(&p->uf_entry.tv.head, &p->validated);
> +	mutex_unlock(&p->mutex_validated);
>   
>   	/* Get userptr backing pages. If pages are updated after registered
>   	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
> @@ -563,8 +566,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		e->user_invalidated = userpage_invalidated;
>   	}
>   
> +	mutex_lock(&p->mutex_validated);
>   	r = ttm_eu_reserve_buffers(&p->ticket, &p->validated, true,
>   				   &duplicates);
> +	mutex_unlock(&p->mutex_validated);
> +
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)
>   			DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
> @@ -607,11 +613,15 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		goto error_validate;
>   	}
>   
> +	mutex_lock(&p->mutex_validated);
>   	r = amdgpu_cs_list_validate(p, &duplicates);
> -	if (r)
> +	if (r) {
> +		mutex_unlock(&p->mutex_validated);
>   		goto error_validate;
> +	}
>   
>   	r = amdgpu_cs_list_validate(p, &p->validated);
> +	mutex_unlock(&p->mutex_validated);
>   	if (r)
>   		goto error_validate;
>   
> @@ -648,7 +658,9 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   			dma_fence_chain_free(e->chain);
>   			e->chain = NULL;
>   		}
> +		mutex_lock(&p->mutex_validated);
>   		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
> +		mutex_unlock(&p->mutex_validated);
>   	}
>   
>   out_free_user_pages:
> @@ -670,8 +682,9 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>   	struct amdgpu_bo_list_entry *e;
> -	int r;
> +	int r = 0;
>   
> +	mutex_lock(&p->mutex_validated);
>   	list_for_each_entry(e, &p->validated, tv.head) {
>   		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>   		struct dma_resv *resv = bo->tbo.base.resv;
> @@ -682,9 +695,10 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
>   				     &fpriv->vm);
>   		if (r)
> -			return r;
> +			break;
>   	}
> -	return 0;
> +	mutex_unlock(&p->mutex_validated);
> +	return r;
>   }
>   
>   /**
> @@ -709,8 +723,10 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
>   			e->chain = NULL;
>   		}
>   
> +		mutex_lock(&parser->mutex_validated);
>   		ttm_eu_backoff_reservation(&parser->ticket,
>   					   &parser->validated);
> +		mutex_unlock(&parser->mutex_validated);
>   	}
>   
>   	for (i = 0; i < parser->num_post_deps; i++) {
> @@ -1307,7 +1323,9 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   		e->chain = NULL;
>   	}
>   
> +	mutex_lock(&p->mutex_validated);
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> +	mutex_unlock(&p->mutex_validated);
>   	mutex_unlock(&p->adev->notifier_lock);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> index 30ecc4917f811d..284d1c03d65d0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -59,6 +59,10 @@ struct amdgpu_cs_parser {
>   	struct amdgpu_bo_list		*bo_list;
>   	struct amdgpu_mn		*mn;
>   	struct amdgpu_bo_list_entry	vm_pd;
> +
> +	/* Protect access to list "valided" below.
> +	 */
> +	struct mutex                    mutex_validated;
>   	struct list_head		validated;
>   	struct dma_fence		*fence;
>   	uint64_t			bytes_moved_threshold;
>
> base-commit: ab7e60938be74e21c723223e7eb96cac7b441e5e

