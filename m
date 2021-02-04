Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0469C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 16:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CD964DEE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 16:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CD964DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37A56E0FB;
	Thu,  4 Feb 2021 16:17:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9284D6E0FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 16:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EczrNnFcqd5PCafLiYeyHn6Z8cJDKb0/+Q8ObdpnueB/WJAnB3Ex4ZLdEkIASAv5V/tceH2KUA9cnhiWgohqf3+RIcl72KioGbP3c7UC8HrvlKXJXrXNyVYixkjzXGc9wggvY4pb8dVaCD+DLfuIALObMIpncdjPpg7noqWfCL1UdA7a81AgA+xbWJoIp48KsnMQ57okXEwnfwYcjwDbeDXTkMdpEcCxvamn1/2K3an1dY/N4oAvpMPws0VaJEKbbtDA/vX8dah2EJ9TLei8B46erc30dYvNQ7QuoH3WqYSXwp4sias/QPxfxcVWIUMRU456fJBmkjsZMyJnj+nUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2s02DI6G/FHyzlDzJOpeEKAMNN4rMolfipytZd5JIQ=;
 b=laBN8YzTklyoMzVk4Z9OZTmPpkg/NF+RINZ11nhaTIuF9AmhDgB97Y8yk/ojRF95EcS4UnejBQw13JWC0M3EXPWJoqE6rDUNRRg3kcZAQDzKBfat+E68pLJA2U2/BCClB0t7VS540mRKAJddRg1IA/0POJ4D0nuLmI5lQM75F58UO3U3IA4gUeA4a0L8Sm8EnWi4RNwsHPPmRqBOlpg5FBgz/hCyeHFSy8SlM5Y4JutKa8r1ajUDqxDw6yoGLz+Di0baOFIP7PKl3rIlJyqQLQPhiKey30r0bwbCArRdM7dK3prK4ifRuFLk8e04RwKYNK4fdRF1jm4IuVHNEob5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2s02DI6G/FHyzlDzJOpeEKAMNN4rMolfipytZd5JIQ=;
 b=kcV/TGDyIc70iYdBQdbV5S7pegcX9+TByNW1cvOtu5DReESsb03hdbKwtvoX3FXbwDmb5u3m4KyPxdLyvyUHTraDGOzHb0lL7a1F543KCRQpthPlLidNsoHy+s1A8VBav+U+zCgYDO39qmsDxKmd0P4dQipPf+Ugk/1WW23UdNk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3911.namprd12.prod.outlook.com (2603:10b6:610:2f::12)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 4 Feb
 2021 16:17:33 +0000
Received: from CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::9f9:6e16:bcbf:79a0]) by CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::9f9:6e16:bcbf:79a0%3]) with mapi id 15.20.3805.027; Thu, 4 Feb 2021
 16:17:33 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: enable wave limit on non high prio cs
 pipes
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210203171132.121236-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <61775992-be78-b799-4bac-293f8a33308d@amd.com>
Date: Thu, 4 Feb 2021 17:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210203171132.121236-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.105.8]
X-ClientProxiedBy: AM3PR07CA0057.eurprd07.prod.outlook.com
 (2603:10a6:207:4::15) To CH2PR12MB3911.namprd12.prod.outlook.com
 (2603:10b6:610:2f::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.105.8) by
 AM3PR07CA0057.eurprd07.prod.outlook.com (2603:10a6:207:4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.16 via Frontend Transport; Thu, 4 Feb 2021 16:17:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e69ba81-0ade-4f36-e8fa-08d8c9286093
X-MS-TrafficTypeDiagnostic: CH2PR12MB4294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4294ED9B1321B37C884A3F408BB39@CH2PR12MB4294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lThXu92Nqqx7s5MtvI4Uwt/UeDfb+GXWL16Rnv2VlYm08gDg9bQtD7DfmCpmiXw3h7sFqN72FAn4jA8a/PWplY2TTYwplpLYkxLQeXywsZ5DzpzBsP/7xG1nGWLk1U4bN2NYhydicGYPO9qgXmR1FpiF8YHpWFXZwQsnFaWzniqcxMEqFZl7op6NIvbrvBENW8MKnrI1CBE3kYGK6sAPcZNlm034zfafAvWC8dMf5fhB9bKt7hzOCotF9g/+63xu0dIdcSKvtDdDXGFGI++cmR8pjGE0QCDyj+imYLrKJswsdVX63LakJb/fmz32j7W201uokgVPDQ+Nh/5Y6/pTTESDG2jLq/V+bD1tdn9IwIYMwwrDYxMSDrhJpZFI34WUZCb7OlidHbMeOiKa216HpN4hxppFO4mG6z+7w0alDCSIcLIxMN+fJpkZU24QGUNIaGfHjmXJLLkM4m1wFJq3ereDeRxq8LDaCcp4ToyK852vvFtpA1jfKhuOiqXf2aFy4aPl9bcZn6bulLGTHwABjQL6ZPXB9RpStl/hoahyBdK3tXf2O3Kk1F3eaY3vrjaiSv07UixKb52W7+OwEriUgIEYBugnl+8pYpSyVfXgwMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3911.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(8676002)(2906002)(5660300002)(16526019)(6486002)(52116002)(36756003)(956004)(53546011)(316002)(478600001)(66476007)(16576012)(6666004)(31686004)(4326008)(31696002)(2616005)(26005)(186003)(66556008)(8936002)(66946007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WFRXWTJjREx6UDV5Y3lTT1ZOTTR3aXUyZys5c2l4N2hOMXhlQVFDME9VM3Iz?=
 =?utf-8?B?UzBKYVA0bTN2QXRaUDdNeEw5NkFtY05FQzlwSm5pMzZraEJKd05FY3hXb1BH?=
 =?utf-8?B?aVk1cDNuOUZYNG8vNWkxSG9EQzhHdVVsc1E1SzJhaG5BVytURFlQYSs4NGM3?=
 =?utf-8?B?dFg0ak9mcXV3aDhmOHJsSkxQaW54OThhM01OazgrYVArbFh2bEd1MnhDZ0lJ?=
 =?utf-8?B?WlFMd0FqT2hFRXplR2F2aUlBd1B0b2trbURaekY3eEpDa2xZMGRGa1hkZmVa?=
 =?utf-8?B?c2ZycHZrcWZSSzBIeDBLZ0oxaWtuZEVQb0VhZ2hqUW9TNkdoeDlTZ2pjOEw2?=
 =?utf-8?B?a2VjRHY5c2NCTHUwMmpJTVJhWFBIQXV4TDZvK3Z0SHJwaVVhOWlYR2xnY204?=
 =?utf-8?B?ei9iTEFndzVoMVY5dXI5dksvM1hkaUVLVGFZL1RPeldyTnVCQTByczVnRHNo?=
 =?utf-8?B?S2NRWXJzdTl2K2E4ZTlOSWtUbWZ1UTdCa2U3cVJxaU1ILzdSN2JaY3JBcUdk?=
 =?utf-8?B?cVlqL1ptek8xK0Z3VlJEZ0RZT0tlYUw4dnljMnpHMU9TNHlLdzgxTHJiNE1G?=
 =?utf-8?B?MXQzVG9hNzZoM2lLeTN4Uy85aDZId29JT1MwQ0tsRVlINTdVcmRjZGpIek9r?=
 =?utf-8?B?V2VxS2xITVIzaWdzV0pHWW45alBrbU9nN3k4Vmsyc2JSRitVdW1Kc29TOXpv?=
 =?utf-8?B?cG5kallhazZ6Sm1LQ2piaUNlRTF0WW8wam5xazhIL2c4RnZESmlwQ1VKM0R1?=
 =?utf-8?B?K3Q4YTJLMzFhV0JkQ2lyQVpVV1UxRW00bXlET2JTUUNBUlVrTDFFNzlzbnhU?=
 =?utf-8?B?eDFRTjFlWnR5cjZ1bWU4VGJwRmZIbWxKeVBHbi8zbFJ6QU5wQ1BHeHlYaE1x?=
 =?utf-8?B?cVpFdzNmZ0RCTXJWeGtucGdkUFZPSjZZV3RGSUdTalptVWN5VFAybHBVczZp?=
 =?utf-8?B?QlZtZzBJdmY1ZjBZY3pFMHBMMnNVTTUvZDdmeUh6OTROcTNkaXkwRkdpUGFQ?=
 =?utf-8?B?NisxVmRqMGhlR2sveFBFdERaS21uQ2JHV3JqaEIwQzh4QmM3M2ducDYzVVRZ?=
 =?utf-8?B?ZDZsRTRPeDRFckRRdjRlUEZNL0JObU9NL0ExSGdpd2tWUlh4QzAyZTBUVzZ3?=
 =?utf-8?B?MnNGTm9NMVR6UVVUd3VSRnhDM2RIdmlIK3NJMlcrMkhLNVIycERBYjU3RTNJ?=
 =?utf-8?B?VU9KbEpjZmNBTGJxSkhHQUYzMHJ3Y2duVHZZVFdTUndNWk91UUtUbmZReklv?=
 =?utf-8?B?aW5pdlNid0hUcG1CNjRnSHo3QkN2WmtZempoU3hObzlNR0sxa2ovSXV1Q212?=
 =?utf-8?B?ZTZzeWlSRDZHS3hGcmw5TjhRQ0tVVExmR3dWOVlOVWRUQ1ZPQVI3TWUwTjc0?=
 =?utf-8?B?QS9ySE9LWEoyY3VYOU91MXpWTlVQZTdwRm15WDZobmdTY3I4MmFWS1ZWRk9h?=
 =?utf-8?B?T2FCTjYxaEQ1VEorWWJua203dElVTXhyOCtTNlpwZ1Z2QWFrUEFJTThtV2ZD?=
 =?utf-8?B?TVNqbHlWNmozenhQWlUyMi9FREgzS1JFMG9lUDdad2FpZ0NsM0xPTzJkN2Vi?=
 =?utf-8?B?aUJDVWdXU3ZtamR6S0RGT3RpemF4TnQybG1zWFlCQVRwbWtFMksyUk8vcThk?=
 =?utf-8?B?c0V0MGxrRzJtdVMxcnpnbGpDS2p5Vk9EYXhibERaVWJWb2p6RnJUM2hKcG9T?=
 =?utf-8?B?b0Y3RVNYNHBiWk5sZVhmeVVQc2xFckxNVUtCUEcyYW1IM0xSZVpwTGNvMDQy?=
 =?utf-8?Q?EHlh1uzylyNREb8Dsce2iw/RHBOnYsvtR3zP3H1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e69ba81-0ade-4f36-e8fa-08d8c9286093
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3911.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 16:17:33.1314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVFKZY7lAqmi2cdA2g2YmSNtI9GrpOk06++a9dmv7bIQY6J0UctEYk/Fx8ZnL4XHBZOwKjDrsqFOaYJAUHaPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping.

On 2/3/21 6:11 PM, Nirmoy Das wrote:
> To achieve the best QoS for high priority compute jobs it is
> required to limit waves on other compute pipes as well.
> This patch will set min value in non high priority
> mmSPI_WCL_PIPE_PERCENT_CS[0-3] registers to minimize the
> impact of normal/low priority compute jobs over high priority
> compute jobs.
>
> v2: use adev->gfx.mec.num_pipe_per_mec instead of hardcoding 4.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 50 ++++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 +++++++++++++++++++++++-
>   2 files changed, 94 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index bdfd29a22b3d..84d2eaa38101 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6846,10 +6846,45 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
>   }
>
> +
> +/* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
> +#define mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT	0x0000007f
> +static void gfx_v8_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
> +					uint32_t pipe, bool enable)
> +{
> +	uint32_t val;
> +	uint32_t wcl_cs_reg;
> +
> +	val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT;
> +
> +	switch (pipe) {
> +	case 0:
> +		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS0;
> +		break;
> +	case 1:
> +		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS1;
> +		break;
> +	case 2:
> +		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS2;
> +		break;
> +	case 3:
> +		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS3;
> +		break;
> +	default:
> +		DRM_DEBUG("invalid pipe %d\n", pipe);
> +		return;
> +	}
> +
> +	amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
> +
> +}
> +
>   #define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT	0x07ffffff
>   static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	uint32_t val;
> +	int i;
>
>   	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
>   	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
> @@ -6857,6 +6892,18 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>   	 */
>   	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
>   	amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
> +
> +	/* Restrict waves for normal/low priority compute queues as well
> +	 * to get best QoS for high priority compute jobs.
> +	 *
> +	 * amdgpu controls only 1st ME(0-3 CS pipes).
> +	 */
> +	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
> +		if (i != ring->pipe)
> +			gfx_v8_0_emit_wave_limit_cs(ring, i, enable);
> +
> +	}
> +
>   }
>
>   static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
> @@ -6943,7 +6990,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>   		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
>   		7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
>   		7 + /* gfx_v8_0_emit_mem_sync_compute */
> -		5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +		5 + /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +		15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
>   	.emit_ib_size =	7, /* gfx_v8_0_ring_emit_ib_compute */
>   	.emit_ib = gfx_v8_0_ring_emit_ib_compute,
>   	.emit_fence = gfx_v8_0_ring_emit_fence_compute,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 027997e95e46..65db88bb6cbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -6668,10 +6668,42 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
>   }
>
> +static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
> +					uint32_t pipe, bool enable)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t val;
> +	uint32_t wcl_cs_reg;
> +
> +	/* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
> +	val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS0_DEFAULT;
> +
> +	switch (pipe) {
> +	case 0:
> +		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS0);
> +		break;
> +	case 1:
> +		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS1);
> +		break;
> +	case 2:
> +		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS2);
> +		break;
> +	case 3:
> +		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS3);
> +		break;
> +	default:
> +		DRM_DEBUG("invalid pipe %d\n", pipe);
> +		return;
> +	}
> +
> +	amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
> +
> +}
>   static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t val;
> +	int i;
>
>
>   	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
> @@ -6682,6 +6714,17 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>   	amdgpu_ring_emit_wreg(ring,
>   			      SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
>   			      val);
> +
> +	/* Restrict waves for normal/low priority compute queues as well
> +	 * to get best QoS for high priority compute jobs.
> +	 *
> +	 * amdgpu controls only 1st ME(0-3 CS pipes).
> +	 */
> +	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
> +		if (i != ring->pipe)
> +			gfx_v9_0_emit_wave_limit_cs(ring, i, enable);
> +
> +	}
>   }
>
>   static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
> @@ -6774,7 +6817,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   		2 + /* gfx_v9_0_ring_emit_vm_flush */
>   		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
>   		7 + /* gfx_v9_0_emit_mem_sync */
> -		5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +		15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
>   	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
>   	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
>   	.emit_fence = gfx_v9_0_ring_emit_fence,
> --
> 2.30.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
