Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2747CC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 07:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C648A10E7D5;
	Wed, 12 Feb 2025 07:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2+0hhwy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7570C10E7D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 07:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo+cTcw7luBOhHSuPajjgdCgGp8j45VIhX3njWG0eFUU2PtcaZJlC5Mw10FyaCL+58CMdXyyJBHC4NxvP1KSo3LuY/cZwt92g19mTxYcmg55GdG6a7/UQqrqBlsH28p/SgxyJKL6ycMf42eJYtQC44Cp3ff0fx3wBo28LbEUHW+Iey90m9ChUO28hAzk4WEDWgLuhYVuluEdzro3VWvvz2x68Wn0Bq0mZVaq5ItfO8M9mY3l0CvVBWPA6PulbO7Rss8JOCtwJPwJSPtXGTYZrtX6JlFt9SJIezQ+i/k5AGYWPIUYojHrVUQRD7mzro470884XmftczgYVWQhFIIB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8AkTDK2rDL1ZFHZ69E3WHvlOq3oRNkHjVJxkb+Xxks=;
 b=Z0Xc5w746gXtt61vhptxUPXkwJSO4g3rI7NeFOtDBzDPirh6/wLJtDfjr0+ENxBau/yZB5MfNc4HNab8lJwaHZw0mqc4GFG8zqkQQhVExZ1bEEcB2QTc5L6VCjZpGWWwVFIrq851n0lGtpgWt4cCWiFhfQ2hhcUkhS/10tgkaj7f5WgGTOJy/vXBOxstnq1sD2M0+Q9viK7WCuuxUYIInd+uRNBivntUr1PWmc9DrLJnA8zNkxLGlYqKY9O9adpGfLBSkfk/iFpkpDQSdJlFOWifWe/nAVJW5IrLi5WhwLsr0vNSQrkzMayBlCZcK0+3KeiRxYqEp7bNJHlAThEvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8AkTDK2rDL1ZFHZ69E3WHvlOq3oRNkHjVJxkb+Xxks=;
 b=I2+0hhwy6raGT/4GAIXb3pJM7D8k+RRJk23ARwNspExJv58d7DgfDqpLwQxgj6X2iU96P1QmzldZyWstb2OtXHeF3wJEXzAtHRUMpDb1r1OC0yYUCd+ZhDd6INiYnGbvDqnXKzhPANyahxS9rcGvuth25vAVqO0yt2OH0MM6j30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Wed, 12 Feb 2025 07:47:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 07:47:34 +0000
Message-ID: <d60aabcd-531d-4065-a1e5-c08bcb5c69ba@amd.com>
Date: Wed, 12 Feb 2025 13:17:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/pm: fix UVD handing in
 amdgpu_dpm_set_powergating_by_smu()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Boyuan Zhang <boyuan.zhang@amd.com>
References: <20250210233132.583035-1-alexander.deucher@amd.com>
 <20250210233132.583035-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250210233132.583035-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: a837cd32-815d-454c-9878-08dd4b398305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTVEcmNFUmdLMk1STUYvdGJsNStBZWlKODRPZDc3akx5RTNSSEU5NkRJbzQw?=
 =?utf-8?B?Tkd3TG9pSUJwek16a00xMVN3L3gwOGFkVXRtK3pjS2FSZ1piSGY3d0VlcW1X?=
 =?utf-8?B?a3FFbkswVGpqRC9rQ2htaWx3UC80aGtnQnlCSVJTWU1SZlZjOFk1cWpxc1R6?=
 =?utf-8?B?ZjZvS3llcndmeExxbVNmVnJxa05uSy9aRnZyY0lSSEVzeVphckZXYmtFRzFN?=
 =?utf-8?B?NXMrcEJCeHpnZytEQUk1WjZISGJQbEhvZjlja0tUTXlERUxzdk1XbjZHWlVW?=
 =?utf-8?B?ZWlGbElRdGoyOFcwTXgxc2hKcndSbEZXNnRQbGd6eU05aXNyNkdIazZhQndE?=
 =?utf-8?B?cW93SUJsY1lJbk9nQmRKYzdRRndIN0VDNzVQMDl2bklCdHp5ek1DRk5VNFZr?=
 =?utf-8?B?eCtsa3NOWStlcVA3Zk41aTA2d3UrK2FTT0txWXZkdW5BdXlNazBoK21VRnpD?=
 =?utf-8?B?OFRuWE9zaUFvTUZTenF2ODZHdHk0c2ZLdk8rT05OaHpNb3JjdWJudUtuYlhz?=
 =?utf-8?B?Zk9PMEw1bXdHM0pQOS9ha0pOcDRQbEdmNTZXRkk5enJRN2dyNEJDK2dzbUxo?=
 =?utf-8?B?cCtlYUt1aU5ITEV6UXl2dzhjVW1WK3JlcWNqSit6UkgxWDVxUE5YMG9lSUN3?=
 =?utf-8?B?di8yZ3AyVWh4cEpRZ3pyQlJMMi9SQ2FzT1ZCSXdxTWk2SzNGcjRaeUZtcmFx?=
 =?utf-8?B?VjBrbm9KY0V0Q2p3MWUydXB2QWRIQVZ5MGxTWitlMkE0NTV4TlZDbDBqWHl4?=
 =?utf-8?B?b09ncTBCZ0ZpbHd0VGxISEd6QTdIYlB0Zng1WU4yS1k3aFRBSHJFQW9Zb09Y?=
 =?utf-8?B?aWFNRHcwendocDI0TEczTTRuaUhjbWZqTk0vRm5tMmd5T0dxN2RWQVlyN1J1?=
 =?utf-8?B?LzBvQ1JEQnJCKzdNdDJ1RjVFdll5OHpJbXQ0bEprUzNHc2tDdlBFdUlBWlBz?=
 =?utf-8?B?NTdOeGd0Z093WmE4MjhUM2lMck01bVZPRWQyREhkVDgzOFNqdisrTXFPYThV?=
 =?utf-8?B?YWNnYWl0L29jUW9zQ2M4UHI3NUx3MnhqOEZObnR6OWp6Q3NXaVVUVmIra28w?=
 =?utf-8?B?SVFKeFRSS0syMllYL1hQR0FvZ3Z1ZjF6TGZYcTI1c1VydmJhdkNRM2tSR2lX?=
 =?utf-8?B?THpKakVOaEhKVnRSVk5pbXY2aDZNdi9oc2pCWlNaQ3NWczlYU3FIaVlNTm1V?=
 =?utf-8?B?T2g5V0ZZUm5BRGZHZ2VnZFZiQTJGNXJiQXY5Q0lUZXBSVFlmaG4vWmc3Vngr?=
 =?utf-8?B?d2w0TFIzWmZnNnUzUXV6Zm9NMncvT1k0TDAyTWhVSXJud0p1eFVyTVp0TUg5?=
 =?utf-8?B?clpZWnh4cDFDNHB3K1NsZlZOM3dCOWVZc3cwTVFhYTZVYWd0c1RnYVJ1NC9y?=
 =?utf-8?B?VkVzd0puYWxrbDNDUVg3aXdzWHVzc2hwQmVpbjF5Vy9ZRFdmNm0wL0U1eURq?=
 =?utf-8?B?UXBiY1NEKzBzbDVrdXorYkViQmNoYXNVUE8zZVVFSUs5c0J3YmprenlzbkVt?=
 =?utf-8?B?Sm5yaTkzaURVNWR4dDBvR2NLdWlBeTFFZE9kR1JvRXpBWC85MHJlbjQzWTdt?=
 =?utf-8?B?WE51L0F1QitQV0ZMYlJqaDlkdEF0a0VWNlVUR2VwQnVIS2U4UU1KNFAxTUN4?=
 =?utf-8?B?Y2h1dTFrNnN1ZUQrMjBGcmZjQkoxajlrOUNaSzU4SWYyQzk4UThkTFh0RUQw?=
 =?utf-8?B?OFBrWnZWaTRwNjNUdW5FRSthMUlxNGkzWmhaaERNckxwR1dwb29KRlhMTGx0?=
 =?utf-8?B?d0VwUkl6bE1PNzJ6MFQ4RkJzV1hNVjZGTHlkSDRmNHlSNmJzbnhWd3VtdGtB?=
 =?utf-8?B?R0tiUGpLdTJ3djRTcUxKdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Z3QWFwQjBZV3NzdlRvcTh1YjB0cncyaTdSSTVEOW1majE2MEcvSVc5NTAz?=
 =?utf-8?B?VUFGbDBNUFVNbk1UVjNEeVFERGcrWE54eWdvOE4rU3JMT2s4b2lpTEliRWNN?=
 =?utf-8?B?UGI2dmVTWm9kaHlhYyt5WkZ3UlYzR29KZXhNZWNWMGxvTGxVODN0TlFZcGkx?=
 =?utf-8?B?Kzg4VVd5NkRoRkJzZDlsalZEa01tUlFVcSs3bERBcE1aT29NOUo5N3BxTWtt?=
 =?utf-8?B?bCtCd0dqL2M0b09UNGRISktBVVNxTGNIQTlHVEx0SFRBbldxQW8wM1NaTjA4?=
 =?utf-8?B?MUlzbUtseGMwOEdhVlg1TkNhbGFOd3pUbW5SQ3pGbnpRU3NFNEVsdVpiemF0?=
 =?utf-8?B?N0F6TlFxQTNCTGNGUDBWNFh3M1g5b3FjeEdEY2hJSGxrcGJFWDZraHRMOG13?=
 =?utf-8?B?RXFXS2VCK052UUtDTnQ4ZElnRzBOUXhzM3BUb3RDQjZhUUp5TVVxU1pOMGxT?=
 =?utf-8?B?SmRsdVE4Nm5rNHA0WTRadjZpbUVVRFprODJWRjhwQnYvNEsxd3J3RXFtNWlZ?=
 =?utf-8?B?WE81U3ZiS2RTdW1GaEd5dHBNbXB4RUVNeUc2NGVsRjg5UEdIeUhnWUlCSkFL?=
 =?utf-8?B?OUlDYmpYWkEvYk5UWnlxMVFrZmFXYzlvZ3hFTnhsbElQKzFQUXhkdmdmWG5M?=
 =?utf-8?B?cXFtenlWcFp3NHFmcmtzN2lYNmM3MllQTkljdzgzMlJFZVd5YmxaNmhqdjFK?=
 =?utf-8?B?eWNzWEVITFlXMnErSlQxNlY0azVtMTVBcHI4c1pYcG9hQzNodFJMcnl3a1J5?=
 =?utf-8?B?Yi9lYnh0QjVkclRjSjhlcWw4Z09EaXNZTHQ4TFdueUY5VWRnTXg0bzBqRXRB?=
 =?utf-8?B?dm5JQ2JBQThrNlVOWjMxNlNuMGJrenhpS3A3L2RmSVdGVTlENlAyQmhUOTBD?=
 =?utf-8?B?QmI3SnhFVUV4STNIRStKN0lIS0xRUVJZazFpelFhTXRZR1BNYWU4dDNncWF3?=
 =?utf-8?B?ZXJDTzJmR3U5WC9vcGVvRUVkbkc4ZjV6cjdTQzcrMjdlNGNSZmxvQTgzMm1Q?=
 =?utf-8?B?OGs1ZXNsSSsrbS9lZ3ViUEs1ZHZZZTR5K3ZmaEl1eElqNENOQXhHQnZESS9Q?=
 =?utf-8?B?Y1p6Njk4cXhGekowY0tSNFFJSkt4dTI4VlFrbHlTdU1yODJ4UHd0bXJ3S3Rm?=
 =?utf-8?B?NHAyNnNSd25kT3V1bWFIRVorNU4xUXhCdkoyQ2hWS0thNDdpVmk0a2R2NVc5?=
 =?utf-8?B?RDdUTFl3NjRhbDRRTUtGM3kxM3BVY0JBS3F3ZmtZTWV3NXhXNlNQVzdlOTJS?=
 =?utf-8?B?SnN4QWtOc2MzaHJRWjdsV0E3azlYRE13K3EwVDV6Q0F1dDVDaGU1ZE5aY2VV?=
 =?utf-8?B?bzR1RGlEUjZYMG9FTjR2RFhxR0pwQmUyMzhyTXFqbzFjb1BHVWxDMDRuNkt1?=
 =?utf-8?B?K01ZdEhOTHlkbVNQUkkwOEovdVdvZDZWUE5rSHVudHUxMEl4UEpydWQzWGNQ?=
 =?utf-8?B?VGhRZ0tIc0E1eW1LaGNMcFRIeGlNQmVjL2VuYUVIejN1anB4Z1RTODF6bHkx?=
 =?utf-8?B?S3RRR3MzZURFaEhSckUwcEdHZ3NrbklwWE9WUlRkSWpGSVNTYmJVc1dnRHJP?=
 =?utf-8?B?Mll2c0dXNlVMRDlBb25ja1hQQ2gvUHRkdmMzZUc1YnFtbm9qaDlOeUl5U2Zi?=
 =?utf-8?B?Z0pDelkwRVY5YXJwUjJJaXFLbUFmdEYyejlkSWpoWkJWREY2MWE3OU55dURi?=
 =?utf-8?B?OS8zWW16Z2dCZmtkdm1hTlVGaExkMlR6NlYrellpYjN3aE9mcEVkWi9PTDRY?=
 =?utf-8?B?UGxwSEFhRmx5M0VuTDhBbGZQS3pxbDlFN3FSdk4xTFh4dlJZb3F3eUNmaVJT?=
 =?utf-8?B?Si9SdXFnRnc2SEVOYlpnK0xYcnl2Q3NMYmovRVg4c1M5SXFPZ0xacWJBdUM3?=
 =?utf-8?B?ZUw5eUFPSkN4S2VDMWRKRUVpdks3Z1VzZHpZWkZkdGJtcFRYKzQ5SlhscnNm?=
 =?utf-8?B?THZnTlFuWm5YL0pVMy8vREYzVVJHTUlBeWVHRWVVN2hrT0FwbVNKbXA4eGUr?=
 =?utf-8?B?YmM1RUoxd1RJbVpVaUdOaFhHTGdJNWR2SU5iQmRraE9NWkt0TjlUejRJMjRI?=
 =?utf-8?B?VEJUZ1ZsY25FUGs1RDBUakdqOVJIemRDMURIWDdMYXlBMVpzclRsdlFVN1lN?=
 =?utf-8?Q?zYOX37OEYcqaYEAEvn/xIEbGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a837cd32-815d-454c-9878-08dd4b398305
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:47:34.7836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVBJih5WmTYPDDQx/7rPpxoTA/NqQdY/0YqwkaUA6otwZAEzNCke3D8BYbGHdR1/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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



On 2/11/2025 5:01 AM, Alex Deucher wrote:
> UVD and VCN were split into separate dpm helpers in commit
> ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
> but the check at the top was still included UVD from an earlier
> version of the patch.  Fix the check.

This description is not clear -'earlier version of the patch'. I see UVD
check is introduced by the same patch.

> 
> Fixes: ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3959
> Link: https://lists.freedesktop.org/archives/amd-gfx/2025-February/119827.html
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Cc: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 6a9e26905edfc..7a22aef6e59c3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -78,7 +78,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>  	int ret = 0;
>  	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>  	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
> -	bool is_vcn = (block_type == AMD_IP_BLOCK_TYPE_UVD || block_type == AMD_IP_BLOCK_TYPE_VCN);
> +	bool is_vcn = block_type == AMD_IP_BLOCK_TYPE_VCN;
>  
>  	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
>  			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {

