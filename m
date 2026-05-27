Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A103CD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 13:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE78010E7E1;
	Wed, 27 May 2026 13:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXNbYYcX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F9D10E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 13:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap1fvlLyNrEb7TmjqZyuJ4bywpIUUqsXP37kfApQBrZKTmNk60XpTD58wwPa3zK2+kMH3BMnZWjMMYDyP03p7PXIS0QwUETehfusDT0sYXmieoj5pgXxL/kezsgyHcZo24so1RRiX0hs2ItZ4Y5Rb5/mVnPU6KhCizjHGgc1FfR0g5a9fe1SD5yJBetEfVauKDqSqPIepw8CIhzx4gmrVhNsUYltidokRqBD3mEowWZ0jcGTWAAybe1uaIa/JAPcCTzLXLDm2SC1oN8Ze6AR2Gywf96oZeWhWtV9/c4y8mF94rBQXWQ4cWASOVZj2dtc0ue0D0UFmbCfhRRmdsm4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF72YI2pGdu5JDbOIcDboG0IbB8XnWZxwcHLmmTMf1g=;
 b=yLjLLByswTluarpXIPNcRDTP9LuPsTI2+Wt0BC1JHijRF8Kdb5RQXJGRvihi6q6zGnzA7khLbIhB6aPV8Ic6BeGYzrxbFR9mffAfXd6u5kP+mf4f2QdgfJdXHj5YOAgIvrtXT0KcSdHvFJkCCtxxt56jnPTwnKoIw2D3iAkG8d+Hz37VwtNvI+Zo5HqgCSMO4hrWyGlju5aCXjYiPOul/hC/CJ84SrPHFIiYssgxEaf1BweoiuKscb1jS0QXmExq5qSTOYYeznbDP/BrGNF51X/pk5hn9s6Ecm5/6dmU39d3AOijYS1IeaI5/nPAZY+NXy8lcU/PiqXKYHx5+hVOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF72YI2pGdu5JDbOIcDboG0IbB8XnWZxwcHLmmTMf1g=;
 b=LXNbYYcXSyLYTOMPYlvpRDCxVCQ3gENiNG1Sh1fJ73+b/j8LI7W2+DUXeG0xrA4k/MQmYfDA17bC1rGHITvZsm5YwQEZBPZYsJLObwZrR0eo8XhzzFcbVpODZWiDUI1+RVK5sWfcl9wo2oazlJKRIuXR1xDKne/U8PoPb3k4VEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 13:53:32 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:53:31 +0000
Message-ID: <1244e269-20e1-48ee-bc35-c4ea0e27374b@amd.com>
Date: Wed, 27 May 2026 09:53:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vce: fix integer overflow in image size
To: amd-gfx@lists.freedesktop.org
References: <20260526163215.807373-1-boyuan.zhang@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20260526163215.807373-1-boyuan.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::17) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd002bd-089a-4eef-9625-08debbf75682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: AdPTWAIB74fkzRmGVWtvxf6DHVwqgZhY0P4HwaVfEE/XWwNaAepaBAUTwozpTcNi7eJ/2+flCqsHwU6XiP0B5HBZdXXVLHo0CSkniLz4OcWyLOoV0lNvI/qaLoDFp19MJehnaYLRcA1kDIKecgYWodkYA53fAF6NEXSYAVftcE6izUeqUz1iQf3a5fp4NFLmSjI64FwcUHJ0jGwc46IHTMP/TOY4XqrKvp6mMTWOMnepqfZnUXEu4qxCCavs1328c9/AG/QYH5mkwHzGOKiAV5SKYKoTdd98lmLIBh/O7drk/UJ4x1u5tpzU6+f/0Iw+Va/qjig+KoQRL1mLGrrsJo6tk01gEcqAXIgCri2/qAVufCvbqWs6e4DgiE5WPBtDZyAnM6aDPBQlMVlog9kKZvmWjENsEqmO8gv90Rj9ko2j5luxBeLc9jVsChKTyYSVnT8JlMjq1zyrgolqUpvLGVJIMfh/2b6FC/+Zz7FLTT9xGDgOvkxKv6Z3Lx73VT0CLCuFjgueNTisiS7OJ8e7T01rgeL4buoWOhJszD0ahNdgSlDkXc2QksU0Iyfu+4ATOaoBFPXBTLabQhjY0SizRUS0SEoGW35Y6W9FcRKR2PaSgEPwy7Jy/8sToZOdHiiGUg3D3fMstBpNucUnDTNudYFAR3Tf07G98nebSOtZ88SL2B1Jis7NXsz7MJssdKYq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhzcnR4dDd4S3creVh5WUVLaUljWXhjam5NMGJrY3RZZWJ3MC8yajZ1R3Fx?=
 =?utf-8?B?Y29DamNlb3V0TFVHTjVlTnpnZm0wZVRlK2JIZUZ6SFV1Wmo0cUwxeC9mcnR2?=
 =?utf-8?B?MFFRZW9Nc3hXL1NBbUVtczNZdCtSVTJ4ZVVPalk2MkxmdDVJbWEveTR2eWdu?=
 =?utf-8?B?U1Q1c213ZkU0cmpBRXhNMUlLaXdzS0pwQjArWDhjYS9JR0V5SDlvdkhrTWdH?=
 =?utf-8?B?cUZMTzJEWi8xR3kvNFlBQVV0MnVDeVl6NllFZlZyZCtueC85SzZKZHhUUWRr?=
 =?utf-8?B?YUVoa0tITVgxRFJZL2d6K3Z5YzB3MXJGRnk1QUFmVS9TK3VvTjZCUmZjR29J?=
 =?utf-8?B?S2d3cnNZbWZJajVuK05RbG10aW1MeDZBS1llVFZBNDRUM1ZWZVFucUJ0UHNX?=
 =?utf-8?B?aEVnOENrRnhxem1rd3liQWNsWDY2VEV2ODBPUkJjaXk4YzJQWnArYWs1WTA5?=
 =?utf-8?B?K200OU9xS2tBMG1SNmJUSEdZSlVhdnd3TE1TRGZzVWtyYXJBRzZDVmYycHRG?=
 =?utf-8?B?SjFFVTlVZkdTWENjVGtVTXdmMkpCd1pqcHdCaVNNTzlrU2dMZk5OY0FnWlQ5?=
 =?utf-8?B?cDRNam1MTzhJWTk2L2JEUWhnZHhadlUzZEttbVl4ZzBBZWJsdUYwcFRPbXZD?=
 =?utf-8?B?QkhCQnFOOFVKbmltaG5lcmNnZng0QjJJSytKWERjaWFTcThxbFFidDhiUmtQ?=
 =?utf-8?B?ZWoxYVhqZTlTVm5sdklvMGU1aGhNYysraE42K2RMTUttYkRDUXVTbnJSV2Vn?=
 =?utf-8?B?Vmxpc2xLRjlPRVUyR0dXZStyYWVuMHNsUkVVK0VPdmdmUzVTMEs1bG5ld2U1?=
 =?utf-8?B?ZXNCeFVIR01OK0JZUnliSUZiNXlMSW9VdXlzU01WSk5vTjkxYWJNTzBERCtm?=
 =?utf-8?B?YVoyOSs0NWwyRWNSOTBiUmpwVmpqM0FnNjRCd0tlVlhHODlDNjB6UEIrdURq?=
 =?utf-8?B?bVpNY25ueCt0QzRSTHc1VmIzWmpaajZoZWhsMmFhaEh3KzRqTWhxYnN0U3J1?=
 =?utf-8?B?RUF2WHQ2Wk1TSERqYnI3TUV6cG83NGVHc01pWlJhTzhWeGp4WFFaUk5KUE1I?=
 =?utf-8?B?ODNVeUtxaGc0aWtlVGNkTDU1QXliY1dzZVJVVXZWazNOWWFBMmpLNFdTeTBv?=
 =?utf-8?B?NGw5Rmo1NnRydGE5Rmc4azVobFBBRFRlbERESHM3Q2hHTWZSU3N5RXc4bjM0?=
 =?utf-8?B?ZlFtVzlseitjMGhlZWo0ais3Y2gwU2w2VmkxRUlmS1QwWGtwanVBc2U1NUJR?=
 =?utf-8?B?VUdBeUhEUW1mUGFEMmpSbVNRanhaVlpKbkJFcmFiNXUrbk1xNDhpbmVTaDhh?=
 =?utf-8?B?eitKamxETnplcVJ0Q2t6bHZvV2lLZENjUmxhWjRjSWlYNGFQZEI3WWNBeVo4?=
 =?utf-8?B?N0FWbmxtWXQrZWhjb3kxZ1dQeEd2bmdiT2FBZmwzejJ5NStVZUpDaEZQMkdz?=
 =?utf-8?B?N0N2UjBSQUU5SGZzdkxFZ0tGQm82ZU5PR0ZWRkVFY1l2TmlXUEs1dFhFbm9F?=
 =?utf-8?B?bjJMYi9yakJRWGgxbUZ6VDZYejRBUGwwNlNKRlpDd1NVNU02RDlTYkk5b1My?=
 =?utf-8?B?TEtFUGo0aWMwNTBWSlZ6KzE3MDc4WGYwNlplNXlneUQzbkZkWHBLY1Bnb0hY?=
 =?utf-8?B?a3UxdTdIVjhuNTNLMDNxRUdEc1paa3Fxb29nQXptMndHelV2NVFSYjZUZEZT?=
 =?utf-8?B?YW9QV1JVWHFQVGwzdFdQN1JCcHc4cW5LbVdyMUc0K3NoSTU5MzBKem0zZWZX?=
 =?utf-8?B?ZUQ0UnVLR0ZJa1hKL08rZEcwNXpxZWtVRTRvdThqeHlhclQwWHhDUnRsTFJh?=
 =?utf-8?B?R1hDZU5sbElUUjYwUy9SREZRNm5SQy9HaGVobDMza2dmWTNhVzNWZkMwWHFN?=
 =?utf-8?B?NUY0aXpWdTY5cjM3dnVzZHdmcXNJZHQrWW01M2xIYmlDL1gvRXZ2Rnd0aUNM?=
 =?utf-8?B?bU9UVlUzV250VjltcCtWS3NzbU00cmVYdUYwdWlWaU0zRHc3dFBodHJVdGhK?=
 =?utf-8?B?NjFIdGJRdERRNWJVb1JPVEtGZFAxdTU4UWtja3haTjMrRkxTZnA4WTNaWDhZ?=
 =?utf-8?B?aU9ZRlBhbm1vVlpPemVyWlMwR0FKajNoYmtoWEdLSG01UXUyZG1OWWhsaUpu?=
 =?utf-8?B?Rm1pbGE3eUthYVZ1RFp3aXRaTlpOSjMyT1dtQkc4MnozTDRwenpCeURHU1Mv?=
 =?utf-8?B?ZVcvMy8venU1UTRyMWNQZUtrZHVsUHpTTW5uaGIrZ3JDajdudW5HQVFOV2wr?=
 =?utf-8?B?QnV3UVZPaEtpdjZVZkU4dnk4Z1dzVVYrRVo5ZlZ1Sy9yS3AyVkRtOVpDVHZY?=
 =?utf-8?B?MFNnR3MwUVAxNGRYS253aGJkU1VVbzduZDlSUGF5YU5mWVppbnYrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd002bd-089a-4eef-9625-08debbf75682
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:53:31.8322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxGfeykojhtFiOolhA3aCzNGbpVFXUUyQT237GeRYEeHoOW8cofDs+flPERB31hQ1CYkY0/zW1hMtGRb1LVBJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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

On 2026-05-26 12:32, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Fix a security vulnerability where malicious VCE command streams
> with oversized dimensions (e.g. 65536×65536) cause 32-bit integer
> overflow, wrapping the calculated buffer size to 0. This bypasses
> validation and allows GPU firmware to perform out-of-bound memory
> access.
>
> The fix uses 64-bit arithmetic to detect overflow and rejects
> invalid dimensions before they reach the hardware.
> V2: remove redundant check
> V3: modify max height value
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index efdebd9c0a1f..bf7184dc7c7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -877,9 +877,21 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
>  				goto out;
>  			}
>  
> -			*size = amdgpu_ib_get_value(ib, idx + 8) *
> -				amdgpu_ib_get_value(ib, idx + 10) *
> -				8 * 3 / 2;
> +			uint32_t width = amdgpu_ib_get_value(ib, idx + 8);
> +			uint32_t height = amdgpu_ib_get_value(ib, idx + 10);
> +			uint64_t size64;
> +
> +			if (width == 0 || height == 0 ||
> +			    width > 4096 || height > 2304) {
> +				DRM_ERROR("invalid VCE image size: %ux%u\n",
> +					  width, height);
> +				r = -EINVAL;
> +				goto out;
> +			}
> +
> +			size64 = (uint64_t)width * (uint64_t)height * 12ULL;
There is no need for size64 since width * height * 12 is now guaranteed to never overflow.
> +			*size = (uint32_t)size64;
> +
>  			break;
>  
>  		case 0x04000001: /* config extension */
