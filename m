Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FADC88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 07:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261E510F240;
	Fri, 18 Sep 2026 07:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IyPjoLdD";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D050610F240
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 07:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dohCl5OhUNYTapiVgz60YaEst7R06LnXzr0aGUSbXE6JzUW2nuvOIN34n1ygUt5HwHL+XBb+fcf1NVy+EK+o3P0kbRgxFhEWy+1fHIbNSzyLL3tmBCingEBYnddqyNNt848BWxcTXDH4Bqm2aHbu+vamgcDKWPRGQTGt3I0Y/O11dRej6uxdkKR25L4VkCjPhdQgRbkk18raxbqpEi0mWXWKH8dI56pLvV694NHf6QMCTyubZEx+4uW6SHnRRJVbxDBjyHwXixShfI4FOk52Qocxge8+wQdkyeL8v8TULbkbfJqJn8r4O+rWz7o8EPfop6zHwzOcT79ENO0ms+j6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28FK43PyXKmAcPgNRBRx+XS6q9RZYHByI2I2SjRyOUo=;
 b=g3OLYDfbtj/0Fj0UjW1x5eg17km6GlT4CD/zrp6y1WXGL9reeSZp+EX6NXw6nxXySka2wlMjb/NbBz5YFvAB3YXDUs7yiYUycL78D1hf2VFo7aBVBMMwDLRsrF6N9h/sdwO42nxlwdfo4Awv3VnFEnxjdBqWYw1/PttRhVsZAFf0hFF5oMXjEkk1cTpwq3EDo7H+3rDX1gBhvB0qhLwsHhrQgHAywcWOmnvM5lnlA0wkYJ7oVCq1M0aartgHxBm/uDNyT6fVRkoVVsJcQHfvo4DvkgudYM/SEEByICZZ0d7tKh3p3a925BosovGgnzXN8470o77H8yyOPikhjHY2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28FK43PyXKmAcPgNRBRx+XS6q9RZYHByI2I2SjRyOUo=;
 b=IyPjoLdDwhIVdQYAtjP/7tP1GLmEzO7+3dcltgrfmpDXrWzCKIb9P4Unw5pRLe3JH4XFmsfSN389r9ZCWGSojOp4VZ2lHGXAmq7cVTwCZEP/Hh6qSOu4DSD1HzEeaLMRZse9EyQj5Brlq4g8gbC6EESveMHhlTU4WSCOCFlfQ64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Fri, 18 Sep
 2026 07:48:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:48:56 +0000
Message-ID: <935937d7-86df-490c-80bb-a88eefa4675b@amd.com>
Date: Fri, 18 Sep 2026 09:48:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] drm/amdgpu: use pm_runtime_resume_and_get for ctx
 ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-3-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917195812.72917-3-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0436.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c56285-a101-4b63-b1f5-08df15594abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +t6/E4WjdGS8WWQgk8onqffEmOdVsUs6dPpJKtnSJaoAisC/Ck/jcrBTr0n0yVMDfoUKOqGmksUOZ8ndRS4op/n+zBGzvbhXZX5grdN4vGsewv9Kaucnuj29smAbmxyxC5+jKi/DW+u/z3sImpWXcaK3mj3blHMfjjcq5uAaJbyAbHAidaWDunlN+VefAZ+4L59o2iYw63CpE5NrVZEdRcNeF1PcVxskmPl6YzGm2SZORuI6H6Pg9rANfkatcDWX9FxKl3WDvTjTRMB8xSnHaMBcl0ZIDrS5vYWrsJ8i6AuhHgUUy+VEAaP6X1MqgeCMQjLeUpKE745Y/XmJV3Riq2NRRM8jKxh7O+OzOnqZuynSZNroYw1qGv5O7xXHW6DleC32osY8qcxkcLI0J58+ANEM0KuLcyNan8nfrkLr4XODQyduwAxt9MFbLWdMn98WwLx6lV02jNYbGB23YRngYF+swM3C/VmRlLTXwTScvXLiglwfAIFqPbZyiexPXQI3fGJs8dhwmF/sL7CFqVMsik+dysztYsgxLZf8FawmAgdPZf9bpjNQPL5V3wyvULX7lP/MjM0GkSHFmVSSLhgp7GvvjNxj9bKGcN42gYv8FqpIyVpRRuakD4gYnNB2TXnW5BKcaY0n1ATNlhh7bTDvP/X8g46VQhoW2+pjpEbn/tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2x4bTRKY3lTMm50UFVhMzl2Z055aGZiVnJZZkJiRlVkKzFLZmJhenpmMkc1?=
 =?utf-8?B?QVFyVmd4T1I0YnN3anlDUFVUcE9QRldDOVcycEN1KzR2VVMzUUc1SWdRem9k?=
 =?utf-8?B?TlU4V1ZOcnVpejJjaThvSHMrTzNqZDFXR0t6T2d3L1NKV2F2UDdEalIrTlZv?=
 =?utf-8?B?RG1uUEZmeEpmb0lBWDZNbXUvMXB0eWZlUUVSQmU3NDVMYmFVSHhaTHlIdWRY?=
 =?utf-8?B?NUk1ODJFU25MZmZHZHVIZnhoc0dXWUkrM3dYYzY1SjhBR3VQcjFXRGtPME5Z?=
 =?utf-8?B?QnhKRVhFU2JIYWFoN28yOVRYdWIzeVoxdGEwSnAxbm93SThEU0RGdG1ZdmNU?=
 =?utf-8?B?Q1lUUHhhZkV4b2dleVdCbUZmRWFoK242Szh2UE9wd3FjNWNmZEU4ZzBQSnM2?=
 =?utf-8?B?aWJKOGM0NzFoQ2ZtTy9NcUdIM2VCWS8yQkVtcXVZTzVCemFtZ25PbVVtMUIv?=
 =?utf-8?B?OWVhNFdKdFlSdnIrYVY4Y0lZM1U2UHBmL0tCc2ZaSmtpakVuUHdjSnVWMGZw?=
 =?utf-8?B?QUJ3ZkpzRzhuLzFId25DczZ6am9CRlB1a0hpL2tuTU9KVnFOVWR5NDZET2dQ?=
 =?utf-8?B?K1NRTS9uc2U0UVZsOVhzcVJSTklCM0NyaDNjV2hSdWxMRG9jbzBrUzRsaEIy?=
 =?utf-8?B?b3dFN1JsbitRaFI2ZWtGc1FHeWFrbCtwK1JNTGZNbTBoTExRb3dYQWZ1S0tU?=
 =?utf-8?B?TE4vOC9MbGxXMnY1YUUxYmI3UVRSQnF1RXVwR2czb3Q0VXlDZTFQSmtuRU1n?=
 =?utf-8?B?dnliOStVTTYxeXZDam5IcUJYQnNFTTdtTG5CSzhqbmt4OFRhZWxOQzRzUjFW?=
 =?utf-8?B?S1JBY1VPVXEzd0Y2c1pOMEtLODlDNXZJUHJvRHJHTWI3Yi9iUHdPdWlnRmQv?=
 =?utf-8?B?am1UYnRMN3Vha2F2L3ZRRXdYbXI4Zm1Yc2lvL21sOG5rc2Z0MzUzbFZOMVJV?=
 =?utf-8?B?R1dlbUFPTForcXFUNkpwdGtVWnB6VU55aGRGQ0krZ3hsWUtGek5BaGxWenJy?=
 =?utf-8?B?Y0VnQkI0ZFRlR3VFSHJlUThPanZQOTlhcklXZEVwaXhCWEJLV1RIT2VJWFlv?=
 =?utf-8?B?OUpwYktQT0VMb1hoKzVVOW1qTTVUNE9DRngrMmlQeWp4UjFINjdVTmxCUUp2?=
 =?utf-8?B?bXVYNVIzQ3lnWm4yQnIwUTVpQUhIWXc0c0twSU5rVjk2Z0FUSDZMR1RRMWVq?=
 =?utf-8?B?WWZCMENMUG5HU0J6bHpYbUM5MExUcXhCMjIyT2xnMTNkS0k0UldMV1FTSHox?=
 =?utf-8?B?QVgzeVJoa1orbUdxR1pvd2F3RlNyMlM2R2ZMMUlyeTRWYisxNWVoa2QyMGYv?=
 =?utf-8?B?TmsrbmlaTTBKWFBIbjIxR005UU9seEFycEd6OFV5ekd4SHliVDRVRlhhajNJ?=
 =?utf-8?B?NkVyY21tdmJsSmFlMEx6MXM2dlZjVjUyWnhIL2hJdTJnOTZoZDFZRlhsaUZv?=
 =?utf-8?B?aVg5WGp3aGhlSER0MW9DeldoV3BySUpLWkZ4VTJoWGlnd1NOSWFscFVpRTdD?=
 =?utf-8?B?QWRIMnlYRFJJSGcrTUhYYTYzTG9XYnArZ3BpVFA0bzBVc1lmSm5ZRnd6SDQ5?=
 =?utf-8?B?SE1YU01LdFA1TGhSOW9nczU2eGtVY3hsaTh6UENtV3o2NmJXeUI2NFVtQ0Fj?=
 =?utf-8?B?anVXN3dkZVhaSENEY3FFK0ZCdHpiazFhZ3ZlZkFKcDRxb0p4UXJSUmMyK2xW?=
 =?utf-8?B?SkxUcEVCaXRQR3p0MXJqSTlCTUdwcjcvRElDWDNScU56ZlFjeHhLYWNGdndP?=
 =?utf-8?B?Y0ZGaUdTMGl0MkZUanlmMHdVMHdhbDg5cVZZamd3bkdwVUlGQmhObldzMDZo?=
 =?utf-8?B?RVBKN3Q2SGhaN0xXYVFJRlA0alg1SllySjJ5UTNRZFZycGpNbGxGWHBkSk9V?=
 =?utf-8?B?TGU5SldwU2JzTnVQS3ZSUDNWc0MzbnJvV1E5cWN3VlU0cDZBNWxjVVVmSXBP?=
 =?utf-8?B?dys2RVp0RkdRZ1MwbFpMK0liRDlCWUdLV2xJL0R0SDRua0RIYlF2SmtkN1JJ?=
 =?utf-8?B?Z0d6ZmI3czR0bm9qSTlWdENrNHRCMy9RY3Q0cGFaenkrS1VmMkZZSHk1Y2dy?=
 =?utf-8?B?Q1RBNmU0WUx4MFJOQ0lRbEdjb0xvZFBlZ1FwVFVtcFBVK0dESnREd3Zocm5w?=
 =?utf-8?B?M2s0eDFOUDFocGhMTlFOelFvTlJobFBHMUtOU0dkcHpyQWFRRGFHUUs3R1gr?=
 =?utf-8?B?RHIxbWVuV09XeEVuL2NHV21xWkY5NDFBdGFreTM3UVFFaHppL0IwSDk3Rm9i?=
 =?utf-8?B?eEVFWWFqR2RJYmdibkRQeWs0aWk2QTMwSmRXUXNYUWJUMU9YNnVyVU9pNnJZ?=
 =?utf-8?Q?3eTv3Yq3nOkpvtrC6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c56285-a101-4b63-b1f5-08df15594abf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:48:56.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02txpnvtqE5uaui6hSV3pTVtNcG+sIuchasJkj5hWXprsrFgowH8GZjPi/4yDAaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273
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

On 9/17/26 21:58, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Only amdgpu_ctx_stable_pstate communicates with the hw.

Nit: Typo in the commit message, the function name is amdgpu_ctx_set_stable_pstate().

Christian.

> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index b15ed4a534f1..a87f26139496 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -28,6 +28,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_ras.h"
>  #include <linux/nospec.h>
> +#include <linux/pm_runtime.h>
>  
>  #define to_amdgpu_ctx_entity(e)	\
>  	container_of((e), struct amdgpu_ctx_entity, entity)
> @@ -643,10 +644,15 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>  	 * context id.
>  	 */
>  
> -	if (set)
> +	if (set) {
> +		r = pm_runtime_resume_and_get(adev->dev);
> +		if (r < 0)
> +			return r;
>  		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
> -	else
> +		pm_runtime_put_autosuspend(adev->dev);
> +	} else {
>  		*stable_pstate = amdgpu_get_stable_pstate(adev);
> +	}
>  
>  	amdgpu_ctx_put(ctx);
>  	return r;

