Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C246103E177
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 13:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB15310E82A;
	Wed, 18 Mar 2026 13:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rN08tQsn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A2E10E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 13:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUe8DcYjciqfvOVcJJ/vy8Hn9GDmteKnbOc472wH89Zhl7NMWUe4BGd5VXpt806VMUWd2XJeaOHVJtACLyJhnxelIM1xXOQVTrD1lsvdJsQk0ZsqTFPg0ZNUxVK+NAB8at+TuLEgUFq6nwiFJOvxiUBPks+c/PRjkOkNu5NA6QxR3Aa39fkdLNow0bNchWwChsEtbYR3iJx7mwOAwduPM3ErDUyWZ3Vog8KQIUlFPLueN2dpPJhoJYPoSXvyZocd/0I5kClhd7CWYsS5OnmsfG+FnopKpSyx8Zwbz7fc9ePl5jxsPSeeB+ZLgtwpWh9XSUAgo/6SosOU8skGrIlpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwpKRfv95CFX5OMma5mF+yez8DyfeCb9vJqBaAOoeUE=;
 b=HSRFtDWx3A8VA6u2mG4+Gv8OU1CIsbvdoOcIv7YU6eZv9wOrTpz//xsRs4DfGC2sy+DiJegb0gkUKKXQiOkQkeDLdn3760xLjBFO/voQvFIw7hkYubfeDM61gYvg6U+mzYT3VvHKs7YJvJ/2zgWAAz4X+Vw543AGn35jBYmqpAF6G6si9UDMSjuW5/ldZMJFEa43QPAIxBJh1T+ePPf0q7E5cBMk1Bse9+l75I/5TXykIcVh6gF8RbfbnhPSQfaOZQ35OrjZojRmpqLSqnDaGq1RUgslM2qIkVbUByR4fVV28W3r+0BoMtopIJGXDtf1INd5bwoZXIcbEwFY1jHKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwpKRfv95CFX5OMma5mF+yez8DyfeCb9vJqBaAOoeUE=;
 b=rN08tQsn6p0m9rm4V+3WLDiLv+mdOfmqc9gZj2bSF9rf+GpKkZFxZgUKD6Kr2PKm9OepGprZ7i8DHnSqyzgEJPOW8wqRGGlO9fkR7+zP6cYn6pfBLt4FE1aOFuUnEAN3am41zl4nCAXTngsOUcIWdpU2CFDkqTvD1y09ZPoekfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:33:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 13:33:39 +0000
Message-ID: <e44e8d3e-07a6-496b-8e32-1bb5cab29245@amd.com>
Date: Wed, 18 Mar 2026 14:33:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix strsep() corrupting lockup_timeout on
 multi-GPU (v3)
To: Ruijing Dong <ruijing.dong@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com
References: <20260318133152.18900-1-ruijing.dong@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260318133152.18900-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0666.namprd03.prod.outlook.com
 (2603:10b6:408:10e::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: b2907954-66db-4313-a955-08de84f2f71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Y9CVzOyR7WfN10lKIpqy56SOrgtxZJqFF09zzTvxw6DEfsaF7S2kbmISMMo0InkhsJRAkmrr6+exkxiXDBiXuBaz5RqYBCAitKDfBPJfVv5KVmZ2qfkCWcI1nS9Masti6+tFUTKRugYdw5qVDBcUnM6B1YndZ6nZucRPYVl18zSHBnS7YmGb1/SoMWx6mVOutErg2z4yEo0+yngcb2PR5prYXpi6RQ+UmVacPAlFg1pHBtlOMAW4uxuLSEUIXVoIQRyeOvWgay/yeaBuzqe9x96vo/gwcI6rQAMTbinAT4Xttpn9VRKKNjHdNsF+v/0wYWzOodEYCjmoLFAJW+04emtC065XS+X5xUkC8edXsksDSss51npo+PHe7gPGPdkcV6NCpmd8x8Vv1IOvToSF/M9E9i5ZpQ32tOXzA+aXpLjemeGfl3gzMCnYaoR+vqiykz8/LbugmG03YpdoC9fRVawTXGw5GXS4wGACI5sL5l8sFWEW+7eqBTaqbrDDWh5IRD7L7qEZZOZ/6pnVqpIzknX7qq1duxcGzuXvwkDFHPKfgx8Qonq/g3zRIElFVWXfzVc2Ni60dNJEoFQHfZxqT0gap/qroPrSURHUM8A5R6En5YRBn9+xm0Wt2cpG6fJ6jhoagS2K6Ej2cPC/R5iV+42QReKE2YkO5hz5cu64HIo1nm4y5+BWK0dyZGBP5/3k5uyMgGgQGdkBsW+v3H04lNbEbypYY7ekf1ngpGxXOBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpPeTkydGlacnkyRStGL2hlUWExVkVnVWtlOWVlRjVNUWNMS0w3RWpNRGoz?=
 =?utf-8?B?UGhVQUxzUnBFT2R2RFh6c2Y0bEQwVHNXeFBmNWp1RE9leU9uYzdhQkdmZUhH?=
 =?utf-8?B?Q0VtWlBDWVRQc2ZEUDRSaE9wblhWSThlNWM4Q1ZiVW4zdElWY1VZSVJzbWZC?=
 =?utf-8?B?NENJYnZhWkZWcFYxdGZLS2ZXVVJmSGhHZUViN1Q2dXJTby81U0twbElYbUFY?=
 =?utf-8?B?QnBrRnFDdHhlOFNCQzYzK2RpNTFQK0pJSXhkWDBaelNZTys2U3p5dUJhRytX?=
 =?utf-8?B?SGVvNU1USG1BVUFCeVpsYU40T0U1U1BZZTcrUllVVTlFMHdidXZNbnhZWXZo?=
 =?utf-8?B?b2p2OHc4b3JJRThzNlpMSENwN05OTUVvQkRHODdWeU1MaHBKbVcva2ZERTd6?=
 =?utf-8?B?Z2xIUXREcElyVjVzdWxZMU1CZVo5ZE93cVRkS2xaSm9CeEtxeWNRSWhWYTJS?=
 =?utf-8?B?blRHdW9FR2pNL2JXb3h6d0ozdnhXdUJWUU03aTFFUFNhcjg2bjUxb1FiU1FI?=
 =?utf-8?B?WDEwOFdWWEE2WnUvK1BHWVlCUFUxK3RlYnpibHFJR092UUtJaUtPOFJJbmcx?=
 =?utf-8?B?Nm53ZTdjOXhCS2pVampncjEwcC9zdGtFSjNTR0dVWHlNMTBwK3BFR2FHQ3hT?=
 =?utf-8?B?aktiaCtTcHpBZUlOb1hTQkpodFNmZHlLWTE4dDN5VUFVYzBKSkhVbjZXWEMx?=
 =?utf-8?B?dW02a0pzZDdSU0RLc04zRnEwMFpCYWhMSGwwL3UrYWsyWk5GZmdaRktiY3dS?=
 =?utf-8?B?ekUzUkhXV0U1OU9kU2N2VHRMSmxUbEhxZVlMUXJ0MmVYSUw3ZlE1TGQ1dG9y?=
 =?utf-8?B?QnFlam9iZXErOHhqN1NwSVA4UlBQWjBrMk9Xb2JtYkRJUmRBWU1OZFZuQjAv?=
 =?utf-8?B?ZzBTYzBBeFdJR2pDQTJOYjJMSlJoT0ZkSm5SS3FYZDdGRGd1MFpkUDAwVGtu?=
 =?utf-8?B?Zjk1TTA5SE5iMW5ZbklPMEpYQmI2OU5ZZWJkVUUvOENSQTdick5yeTZUeHda?=
 =?utf-8?B?SitubVJIYmszMjdQUUhXcDFsWnFoQlFaUDNHQUM1a3J1YlNBYVpNRDdFNFdx?=
 =?utf-8?B?Q2RUTDZqQ041N0E3anliR05lSUIyNjRQbGphbTIrYVBaZWhOampOSE5HM0k2?=
 =?utf-8?B?ZStnVWJianBiNEFubXh2NkY2SDBXTkJvQ0RMSHpsSEtEVDFQbmZYdWd2T1Vi?=
 =?utf-8?B?dDNVanBXQkpqNFh1ODEzM2JuTm94NkVCdWZGTkRoY0dhVVY4aUZ6OXhRRmFY?=
 =?utf-8?B?ZzZqaUVpTHk0Ykkzc01zQjZ0cVhVYkxFZktqelVzWjM1M2d1bll4QUNDT1JS?=
 =?utf-8?B?a0JXQzZ6QnVnbnBoL2V6YVBvNXAvK3BpYzRwaVNRZ0NQNnRkOENEbFdIZFNZ?=
 =?utf-8?B?RENMaFZ2RFdkRDBXZDJiS240aW9TTUYxeG0wbEhHN1RXTlVsMExpTmpFK3cr?=
 =?utf-8?B?TVhha0tycEdkTVZHOXQrV2tFZWVhWTVEVUJvU1BjRDV4bXpMR0lxcno3MmZF?=
 =?utf-8?B?QXhnU0xVZlYrbWNDUXBPcDNINWxmdEFXVlNBeklHN2xIQ2QyWEpGeEhzMmtj?=
 =?utf-8?B?dEwvaDJMbEIxT1lBREtzSVpMUWJ0OCsrS1VPWjVlOThCdWlwNUFXbldBbzVB?=
 =?utf-8?B?Qk45VkQxSUpZVzh3cGtXWkcydnBEcENnbFZTVTc3b01ST1JQZnh3U2xBallv?=
 =?utf-8?B?ZXNTL1ZOVGh3TitOVTQ0WDhpSVRuTlF1Z1pDclgrVmdsSDJ2UXg2QlloOUNP?=
 =?utf-8?B?eDQzdTFCQUVpUHhMd0RxT1RyYkNhd0VLekRwSXZUczV0K0JGbDNFdXNralVx?=
 =?utf-8?B?MWxDaWFCWDdKOFlQelloZjVDSjYvZU1KS2lkZmNyUzJobEV3dEVaUHVrK0tS?=
 =?utf-8?B?dzR6R21WOVVxbXEzcUFzRHRIclNaQlJ1RHNtVDRhNHNGckhLQ043VW1VNGNY?=
 =?utf-8?B?WWlrUFFCN29DVS9xbG9qWUJIMGpGTUF0VEk1ZUJDRGhtTk9YZjBMK0RZRWw5?=
 =?utf-8?B?VFl5Y2pnUFIrYUhoT0JFOHA4dEV2VmhHWWlYVGVneE10UHZSTzdWS282WnBF?=
 =?utf-8?B?a25samwyaWhPdHk0TjJWaGZFOTJnc0FiQ05BRjh5RUk3UXhtbFpuZFdsT09a?=
 =?utf-8?B?aXptSFczVjFjZDVWdEY0QXVRVmIwVG1UZndtSWlpVXhNVE9PRy85bVFVQmRI?=
 =?utf-8?B?TWhPMHBaZnI0UVRzc3hYY3BWVjcyKytmTjY3L1VxeU1wSy9CY0t2bVNOdnh1?=
 =?utf-8?B?dkdrNzFmVFp4clo5UURQeWY1SjlZcVQ1TzhPTFhGZlE5S1pJdDFtSXVFUHpY?=
 =?utf-8?Q?tpwz3+7noK/KsfBaUP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2907954-66db-4313-a955-08de84f2f71b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:33:39.7568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8shlcEZhZLtf0yL1BSUMSLS6F3toSa/XtJs7i7jjOG/gwOK3S8Ve1cu0EcvArypV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

On 3/18/26 14:31, Ruijing Dong wrote:
> amdgpu_device_get_job_timeout_settings() passes a pointer directly
> to the global amdgpu_lockup_timeout[] buffer into strsep().
> strsep() destructively replaces delimiter characters with '\0'
> in-place.
> 
> On multi-GPU systems, this function is called once per device.
> When a multi-value setting like "0,0,0,-1" is used, the first
> GPU's call transforms the global buffer into "0\00\00\0-1". The
> second GPU then sees only "0" (terminated at the first '\0'),
> parses a single value, hits the single-value fallthrough
> (index == 1), and applies timeout=0 to all rings — causing
> immediate false job timeouts.
> 
> Fix this by copying into a stack-local array before calling
> strsep(), so the global module parameter buffer remains intact
> across calls. The buffer is AMDGPU_MAX_TIMEOUT_PARAM_LENGTH
> (256) bytes, which is safe for the stack.
> 
> v2: wrap commit message to 72 columns, add Assisted-by tag.
> v3: use stack array with strscpy() instead of kstrdup()/kfree()
>     to avoid unnecessary heap allocation (Christian).
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dcae77b6c272..fbe553c38583 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3498,7 +3498,8 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>  
>  static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  {
> -	char *input = amdgpu_lockup_timeout;
> +	char buf[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
> +	char *input = buf;
>  	char *timeout_setting = NULL;
>  	int index = 0;
>  	long timeout;
> @@ -3508,9 +3509,17 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
>  		adev->video_timeout = msecs_to_jiffies(2000);
>  
> -	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
> +	if (!strnlen(amdgpu_lockup_timeout, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>  		return 0;
>  
> +	/*
> +	 * strsep() destructively modifies its input by replacing delimiters
> +	 * with '\0'. Use a stack copy so the global module parameter buffer
> +	 * remains intact for multi-GPU systems where this function is called
> +	 * once per device.
> +	 */
> +	strscpy(buf, amdgpu_lockup_timeout, sizeof(buf));
> +
>  	while ((timeout_setting = strsep(&input, ",")) &&
>  	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
>  		ret = kstrtol(timeout_setting, 0, &timeout);

