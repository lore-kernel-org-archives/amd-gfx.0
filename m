Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEB8C982DA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 05:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E9B10E30C;
	Mon, 21 Sep 2026 05:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8neV4xo";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B8110E30C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 05:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSRSanKN53VKqjEIARssF0ITweBrP7WkgG7vhhU07OGP/PtmSFGpcLy+Osy6cWVUfmy8Olyi9iAMUHNgZuecsAiS+IWE6PKrZUfKsN2sb3RHj7M/rrkK49s2VAKRZieKYUPqs8t9mK2XIXKyoN5kTELuJ/hPqTss04mQ1Xc3JCBfC5FoII/bpStUgL7LK3sMPZprV0+CAO0RQbqCFnxzJoTJsUmjuMXz+CTW8Luye8/cVYOjPedpl0lO5IEIGrjvbLJ9SfT+SSt1rJylDIcjv849ysEONpXIye1KSWS/+FO9IjtSWqeOhfQYdf6aPWMdAbX6fNmwqEAfvFm57Bo9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFgTMGGg0Cq2S6UHsWB/LnKnB3byNvAv3YKTXIVKtGE=;
 b=Gqmd43WIxGdV+kVnEf6ecLEmdqIS+vg9+Fr2rV0E47zx7NL+aVKxNKuF4LQTxNr8U1ggz2e/7UArBrqXO36KFb8JlDNk3eYkY1HJyAF8s8ljiGtB+IF3YcVsi02Ck4JDgm0tVc44zzy9BWLp2b4ukXzmQskwPbpr8dJvzUdNNqYpZM/boDuVoc1FEwasjsdcmWO84XpJFfOKFJQE4lBgLmhyPx+GhK6M5ZmVcbV7qnTfmOspSow3K1mZFd7ar4yE5ZOME/65k8rEX+cqhZ4kSItIe4ra5QrphuM8MX7Y8/rCjvfObRJjjHfI1TZgrQAr99nwFaFISTgc8098pmMWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFgTMGGg0Cq2S6UHsWB/LnKnB3byNvAv3YKTXIVKtGE=;
 b=u8neV4xoPLnGEYevmSIpYLs8V28bu9mopDF8ViRYYlhFz3uqBNvq9hx45zlaXBwBX0E6iiXq3/mwja1jncESleejH9YSCLpH/BVi1Ud/fJR3QJ7aI9zbH/wCDHjBaolHjrN4U8OcU5kj+MJs14Ln9O4RjCRB6Pl2Zf2I4CcI+rM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Mon, 21 Sep
 2026 05:53:10 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:53:10 +0000
Content-Type: multipart/alternative;
 boundary="------------zxw005Cz1sK0HvaLdr0AcRyv"
Message-ID: <cda03a32-3f6e-4dac-b741-f562497a410e@amd.com>
Date: Mon, 21 Sep 2026 11:23:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: reserve the VM root BO around CWSR
 param validation
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com, jamesz@amd.com
References: <20260918200444.450067-1-James.Zhu@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20260918200444.450067-1-James.Zhu@amd.com>
X-ClientProxiedBy: MA5PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::6) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b0b690-cc9b-4d81-fc39-08df17a49dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|10067099003|22082099003|8096899003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uAfFXsm+98AFSDJbC3o7LYH9kU06iEWK+cSxlKLJWXwZjD5xe2a3m5V4rB6zB4TPbVNbi4Tomwi7+EKhVxuYQFhTUjTwdBo8E3TO9QoKYwsHGDJHF+DhnR1Dj5MFQPBIGDoIg4eNf71FcK9t9ttZshVCqbiib6VOsPxteasLycw+gjyC8v/eFrU6dW5HHVykqPVVquDZzCKn1yGYAjB4v/8TWU6o6oWl4UZTv5Vx9NHqy3JL5k3Wj0V2fqS26aT+/TO7Hug+uPM/N7UU4EiNyHbD1Zw5EGnWE3VXecC5Itl+SAzUFMrrGdr0TnkgzkBf7SKhTxjtwZsAObKEqtqAyEaXHnyvwui60qM2iPp2L3dEwLgzgoDjbTXEiStxmdoLWxvmw9PWjUC1SB4Jm/FmB4q+92QEM4N7m4+b20A7sTLPI8D8YcKljDKnkz3PyKd9Atc28Y21hVXvs8Fni0KABznbCNm7/OjRBmzHZLuOfp+B5R755RM/DMdN2q3XeWcJMb51bRdB6HaGJr7SMKUpSgwRpb/aeFT+95++C2S0TbmBNytLSOe3bY39vZNzfW9DyB8YzcBEc+C6WCPWxTYsCcf6BY0ddF0lovRDU+aTEurRDeuQvaLFDdNWYRp02Toc3fSJzp6xHmdcKamaT7a6dObXhXYx4aIQz1mcZd5OoAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(10067099003)(22082099003)(8096899003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVcxcnpIWXF6M1UrSlZUNVYrb0ozZkdxZnN0TjgzL3hjNWhIcm1jMmJyL0Jn?=
 =?utf-8?B?T1QxRy9lQjhHd1duclZrTzVWSmRWTm4vWGdaU3U0Q0JSMjBGNmhNRXM1ZU9J?=
 =?utf-8?B?ck1NM1BnbWc4T0F2Zy9RTHB4cmJ0RW8vTkh6YUlkeG9MNVJpS09wUEFRS0JN?=
 =?utf-8?B?REY2S0szaFFLandSUG1uYmhQZk5uZGp5VU9OUm5PTWxkeHBJcjJwRU4zVSsw?=
 =?utf-8?B?SVo5TU5vd1lzeHhJOHpZQkJYQm9BOTN2c0JVYXlXbkdLKzAzQ1NFaXlQSFV0?=
 =?utf-8?B?OXNRMjhWa0pPdUF4T3hFQnVXZlFxSFhrampFV2lUSStPTGU4bFRaN1FoYnc3?=
 =?utf-8?B?ZFlQVXUwekZVNlltdlFhemwxRXVibXpBYVNKNTk2YzhFZHBPZDJtblF2YTI0?=
 =?utf-8?B?ajQ1ZG1aYzN0S3RxQzBEVTBaa1l1YlQvUDRibjAzR0JYV2p5RFdMY0xQalNO?=
 =?utf-8?B?Nm01aEZFaklrdGNKcUxSN1l2bWwwRzJhcnpjcklzVWozd0IrSGY4ZTZDRS8r?=
 =?utf-8?B?Tk5zcDFBazl2UVc4d1kvQmVESGlrdExLM2gzSjZIVk54M0Z5WmFwMHBnQ1Vq?=
 =?utf-8?B?bmVWMVdBZUR3cm9XaUg2RmFRS2k5c0tFVEl6RUlGeWtKSEtrU2R0MElGNDNH?=
 =?utf-8?B?UW5XOGhYVnA1MDNNUFc4L2ROK2NXNVlRakJvclN0WTB3UFh3bFhrSDlHbDdj?=
 =?utf-8?B?aTc2bHBxazVYTm9lbTBDbTkwMGgxR0l6Nk1yS1ViRlJnWGlXTk95bHB1S2lz?=
 =?utf-8?B?b1EycEZMNzY4M3BRck4vL2NtTW1XZmxuZ3pnTzI0d0FnVUNzMVFva1ZaV2lm?=
 =?utf-8?B?R3hkUytIaTk1enpLMU1MMUg0dWdsR2dsT0x1QTdyeW1BeTZUMlJLYXlVdlVN?=
 =?utf-8?B?M0dwbUhYYi95Y2tZOFN3ckg0bmJ2R01yS1BzNUFLdGgrd2g3UjQyUG9McFhn?=
 =?utf-8?B?SmtmNjEzWjhVWXZTN0dpRi9lblIwellYK25ibDBpM1B6S1RsOVpWMUJ2bkRV?=
 =?utf-8?B?NEVCL0psYXpvemIvMjBzT2JXTjgzeWZVOWtRWGFjY1J2b3ZGNnpQZjlXMlZy?=
 =?utf-8?B?bmUyVDRHcGRkdEdVZ2RQQkxwRVJ5b3dvamFCck9kMkl1QitBc2pHeWRGY3Zv?=
 =?utf-8?B?YkcvVlArT3VmRlNRSGVneFdLWVBxcnU4ZTlKS0k5Y2dpNmxNcmRpaUJtMEpt?=
 =?utf-8?B?eUJpQTUyQjhNcGkwdHFBRXhPdDdISHJFMVB2MU5tQmRrVlRFc2VxL3ZqRlFu?=
 =?utf-8?B?bHdXTyt4alRGeFM2cy9TandLV0pXcSt5QmJCeHFmNzkxcmNQU3RzSHJPSjBL?=
 =?utf-8?B?SkozbEYrT1ZqRTloRk9KNUJGb003TjREMEdOL2p0b0IzMEs1aVQ2dm4vTm4y?=
 =?utf-8?B?RUxhOS8zcU9pMXU2NkhsNDk4MFp2VW92YkRwUkRuWDRPODByRDZtTC9OQnE0?=
 =?utf-8?B?NDczTmtaSGtlZ1BVZUswOVV3amsrZVdoV0xwdlZVZHcwTkNOZmFZb2ZiSndP?=
 =?utf-8?B?NDRlelF2Y2YzVXlEOHplaDFOZk9XdGp2bDFGR3VweFFSRzFFc3lWc2ZTaW85?=
 =?utf-8?B?aTlXVzdnRDRoL09JK1dxRk05T0xkR2Nya2tHVXM0cEZmZkZXaXR4QUM3VGVa?=
 =?utf-8?B?aWEvMCtadndpYnZZS25FNzhPTFpmRm04d1I1a1JRbEJNNTBTUFdDVzN6bXg5?=
 =?utf-8?B?UjVWVjUyK3I4Mks2RVNQWTJRWjRtR0Q4d2tIbzVUMmxTVGJ5Ky85aHczR3Zk?=
 =?utf-8?B?RnNDa25RdnVqVU94bXFTQlBjVkIzK1ZYWXRzRW1PWmtodTZtYjNaWHMyZGxp?=
 =?utf-8?B?WGxuSjljZ1ptdHFXMmN0SXUxUmNxeW5vTTQyalgrRUcwVFhhUmZScXpkMXBS?=
 =?utf-8?B?V0dXU0hSRS9KQjFMQ1FpRG9EMkx6NUs2OVRjSllqcVRqMDVZSWY0dDBvbE5K?=
 =?utf-8?B?Nlc4YVd1VUhXT1duOExSZkJ6cFFWWlI5T1dRdU9DM0JKSFRiSHU2K2tXamdj?=
 =?utf-8?B?bHl0WUhpT1RIMmorUHlQVEwxWGNjclNpbXp1S1NNaXJBb1A5Mkx2N3VHZFZF?=
 =?utf-8?B?eEVQVE14S3hnWXUrSlgzR1g0RUJTOG8xeVpPSWhKUGw2WHNwRjBpVUEwVDNT?=
 =?utf-8?B?TXVvK0NnT3MrZTV4UW9xenVERkdRL1hYWnhBNWRVN1YxL0dxNi9MalFnYVNa?=
 =?utf-8?B?OGhhcmRLRkJVdWxjTXZmaW9VTGxaa2xHK3VYSDg1cEVkVVFBaUZsLzVsbXRO?=
 =?utf-8?B?NmtudUZOOXdOTk5aUUdISGZmUHBvblVqM29NSXhBOFhYL3ZxNWhUWFFMMzdn?=
 =?utf-8?Q?6XgbpWm8eMyQ2el86Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b0b690-cc9b-4d81-fc39-08df17a49dca
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:53:10.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tISnZFiUjNYI99c/cSiiFPtJvBlNUrUJkhTaN0qd92YJjg1zg8zo5ngPcErEyvHQpAMgrH4JjtEMKIrYqszCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
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

--------------zxw005Cz1sK0HvaLdr0AcRyv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/19/2026 1:34 AM, James Zhu wrote:
> amdgpu_userq_input_trap_params_validate() ends up in
> amdgpu_userq_input_va_validate(), which walks the VM mapping tree and
> updates bo_va->userq_va_mapped, so it requires the caller to hold the
> vm->root.bo reservation. The CWSR branch of mes_userq_mqd_create() called
> it without that reservation, tripping the dma_resv_assert_held() on every
> compute queue creation when trap handling is enabled:
>
>   WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:232 at
>   amdgpu_userq_input_va_validate+0xb9/0xd0 [amdgpu]
>   Call Trace:
>    mes_userq_mqd_create+0x49c/0x9e0 [amdgpu]
>    amdgpu_userq_ioctl+0x935/0x1070 [amdgpu]
>    drm_ioctl_kernel+0xb3/0x110 [drm]
>
> Bracket the call with amdgpu_bo_reserve()/amdgpu_bo_unreserve() like the
> other input VA validations in the same function.
>
> Signed-off-by: James Zhu<James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 2150973b947d..16aa22b25098 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -508,7 +508,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   			trap_params.ctx_save_area_address =
>   				compute_mqd->ctx_save_area_va;
>   			trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
> +
> +			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +			if (r) {
> +				kfree(compute_mqd);
> +				goto free_mqd;
> +			}
>   			r = amdgpu_userq_input_trap_params_validate(queue, &trap_params);
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>   			if (r) {
>   				kfree(compute_mqd);
>   				goto free_mqd;

The CWSR VA validation accesses shared VM mapping information, so the VM 
root BO needs to be reserved while doing this. This change adds the 
missing reservation and avoids the warning during compute queue creation.

Could we also add the corresponding |Fixes:| tag?

|Fixes: 7ca9abf4ac38 ("drm/amdgpu: Add user save area params to mqd input")|

Separately, the repeated |vm->root.bo| reserve/unreserve operations in 
|mes_userq_mqd_create()| could be considered for a follow-up cleanup.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

--------------zxw005Cz1sK0HvaLdr0AcRyv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/19/2026 1:34 AM, James Zhu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260918200444.450067-1-James.Zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">amdgpu_userq_input_trap_params_validate() ends up in
amdgpu_userq_input_va_validate(), which walks the VM mapping tree and
updates bo_va-&gt;userq_va_mapped, so it requires the caller to hold the
vm-&gt;root.bo reservation. The CWSR branch of mes_userq_mqd_create() called
it without that reservation, tripping the dma_resv_assert_held() on every
compute queue creation when trap handling is enabled:

 WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:232 at
 amdgpu_userq_input_va_validate+0xb9/0xd0 [amdgpu]
 Call Trace:
  mes_userq_mqd_create+0x49c/0x9e0 [amdgpu]
  amdgpu_userq_ioctl+0x935/0x1070 [amdgpu]
  drm_ioctl_kernel+0xb3/0x110 [drm]

Bracket the call with amdgpu_bo_reserve()/amdgpu_bo_unreserve() like the
other input VA validations in the same function.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2150973b947d..16aa22b25098 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -508,7 +508,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			trap_params.ctx_save_area_address =
 				compute_mqd-&gt;ctx_save_area_va;
 			trap_params.cwsr_sz = compute_mqd-&gt;ctx_save_area_size;
+
+			r = amdgpu_bo_reserve(queue-&gt;vm-&gt;root.bo, false);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
 			r = amdgpu_userq_input_trap_params_validate(queue, &amp;trap_params);
+			amdgpu_bo_unreserve(queue-&gt;vm-&gt;root.bo);
 			if (r) {
 				kfree(compute_mqd);
 				goto free_mqd;</pre>
    </blockquote>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
        <p>The CWSR VA validation accesses shared VM mapping
          information, so the VM root BO needs to be reserved while
          doing this. This change adds the missing reservation and
          avoids the warning during compute queue creation.</p>
        <p>Could we also add the corresponding <code>Fixes:</code> tag?</p>
        <p><code>Fixes: 7ca9abf4ac38 (&quot;drm/amdgpu: Add user save area
            params to mqd input&quot;)</code></p>
        <p>Separately, the repeated <code>vm-&gt;root.bo</code>
          reserve/unreserve operations in <code>mes_userq_mqd_create()</code>
          could be considered for a follow-up cleanup.</p>
        <p>Reviewed-by: Srinivasan Shanmugam
          <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></p>
      </div>
    </p>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style></p>
    <blockquote type="cite" cite="mid:20260918200444.450067-1-James.Zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------zxw005Cz1sK0HvaLdr0AcRyv--
