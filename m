Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0951CC021AA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 03:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F0110E368;
	Thu, 20 Feb 2025 03:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hiZ+un8X";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA7010E368
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 03:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6vXrq4kpgN8c82NvMmX7TGKxV9oHaFVZxKpRjAD+03HCZOWKtyvQ1fPdSXyjBBb2MeTg7gFxZpRODImKfQsggleXBEinbWGc/MU2ib4Ookzspr6d3rM99hn37qnO3TCYyBmh8MtS0GaMn56EBgYcRqvrSxi8TQve2wgd/aq7E+IJBOjH5FUr3duVPwmvNjm80fc4pDcSeaXP+N68SxOcr+6ws98ssoxr6vaiEvf+b5Efgf8W8Kaq3BKrZT6WXO/E8hpRIkDfRJT55rwu+1FhSkwsJBLT3HI8W0b/kpk5nJww7shY2K+i3eLF209jFdlWffjFUbAKZnZO95Jq/AXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGJIASUdahXHNuq5IV/zDBp6ur/6tb0NRAM87Rfqz/E=;
 b=u2p0wviqdEILRvOfQaIgRdMJQrPgUMSIpiEs6q4ebsbjqK9LTuoMAZomCxrIl3aNFsMdvW6FFVQgsFxArG5j31iZvYwRAUGJQy2EAHeQuT4cnk1IkPCtvvzrIT1dBZ3/SsaLynXtEtl982AT1So0goPlG1Gh0ZkwIcKapPO7WWPTa8EfdTLIxgrjros1bx2tF4bokGBFT2ezkvXBKNKEUkl6WLDsHXXJAt3IYiHQhXWnKS/H4a55JOJXBaGL6tOWjCeGpTUnMEbUZpe5pW19XGkBtXQA7422fd7MgrHRr7d0ToZz5MLyQwVTWmh+whSt85/ukCvdrasGUcw/GNlM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGJIASUdahXHNuq5IV/zDBp6ur/6tb0NRAM87Rfqz/E=;
 b=hiZ+un8XvxGPwkRQXxaXNp9eH6gEg8SPsNs2ufS5HBrhY9wDHkdhJMr6bWO3AiVLYsMA3wPp+9jwU5Ue/oHwZ4AU56mH8bvXL+XkrAuf8tO+dMolqxqs74WDjoavi+UxxZPEmw6D3jFSJx9p3JLjOJMyKvq0joR0mcnZMsDaGXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 03:11:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:11:44 +0000
Message-ID: <bd75a651-0220-4c94-bb49-fd93efdbd3d8@amd.com>
Date: Thu, 20 Feb 2025 08:41:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250219162802.61564-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250219162802.61564-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: df04e667-36f3-4b95-4bbb-08dd515c4dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFY5VFdvNkhCV0JaZVpPM01WYVZDMnBNNjhmVXJjeitqQ01IVFY4bVV6YWVy?=
 =?utf-8?B?a3k4OVl0c3RteUwvUmlUY1BkSy9WbldJbGlxTzh4R1k5V2FiN1RiaC9QdmRh?=
 =?utf-8?B?bGpNQnMvSnhIZ2tpcXlrQzErUHR1UXFFWlJPQ204cTg0YXk3NmJtaWpUNlVj?=
 =?utf-8?B?TFRNMThHTFRPdS9OdXhQWEpZRVc5QnE1TGsxYTFyODlYS2ZRblRnNkgrTlRU?=
 =?utf-8?B?NS81di9XbVh0YVFMWkZmUk9kQXBmVGRKYU1oVnRTMkYxbE9rMVVqMnBZcEgw?=
 =?utf-8?B?RU9IRDh6WlJLd0trcUVaOVM0SWpBcjZmYmFib3lKUURIUFczS1BkNURtZmNq?=
 =?utf-8?B?aXVpODBwd1ZIcFJTck9TcG40TmJiT2huTngvcmhBZWY1ZWozYTZzOXFHMnVY?=
 =?utf-8?B?MDhwK3pSdWNHdjlFU0F5Rm1RWTlhQkMxcmpIZHpvNlo0OWNFSTZsQ0tKUk1a?=
 =?utf-8?B?OFNmVmM1MTZIcEJWK1pFMHlHTDljVVU0VGsrR2dXM1hBdlhIM2tjMmRnTHF0?=
 =?utf-8?B?VHlnM25EWnRraWxvLzZyVml2dEdiVzM5a0szenVPcnBDSzczMXMxU1lyV2I5?=
 =?utf-8?B?WDk2RXpsdWRuUVF3WWFFZlRKMFdKOTdBdTBIdHpRNWMzSDF4ZDVmbnpHMWx2?=
 =?utf-8?B?dHB5ZGZFN2o0dlVyMTdRaUtmU3dQMnFoejgvMGRrR3g3UE9IN3k2RlQxeGZL?=
 =?utf-8?B?RklSQTVEdlIwY3p5NWpwZkNzLzRpV1dTWEdrbUc3Ly9UN0I1TU4xU2lBUTlO?=
 =?utf-8?B?c1dmSmNIK2gyUkVHbUxyQS9LVVBXdEM5VzA0TXR5Y3lmRjZCRmdMdjh2Y2JS?=
 =?utf-8?B?V2g4ajJHa0xwd2hKcG5jQy8xbjR1ODBuSEJTTU0rL0Q4WVVwR1NKVjFRUE5D?=
 =?utf-8?B?REVEMnJud255NlcweUUwM3NxL0ljSGpzUVg1a1VjQlplMC91dUhiOERQMVBQ?=
 =?utf-8?B?SlRZUzhnUnRWYkV0a05MVHZNc0twUTdySVhkTjBRenBaSGZkcVl3andYTDli?=
 =?utf-8?B?YWFUMnhrcTlxbWErT0NObzYwUXA2d3lsaFFQT2dwUkRnc0F4NUdyWFBHcm9T?=
 =?utf-8?B?OG03ajZId0R1b0JwYTFhdG1RMHBRaTRLWlJvaUdXaDBKL0xzS0hNQjhld1Q3?=
 =?utf-8?B?K2ZjbzlnaTF5ZnY5WjBDUmszVDdtQmF1RmlEdWk1N0NuVGk3TjJZMjkveUNB?=
 =?utf-8?B?Vmk3cVBGRjZ1Zm9nTDd5WlBlRVlYRFRTMFpiMDE5ZXYxdmlXb1hFUGxHdXF2?=
 =?utf-8?B?RmFKVkpKUzNQOFgxTXRDUk5MZzYzaGRCT1N3OVdpSXBjQ2Z4STNWQ1JBMkFV?=
 =?utf-8?B?SG8ySTQ4WTFPZXNTQ0xZTjd2MmR6d3FnM2tpVjRsWlNmVm1qaUtqZnZJejhU?=
 =?utf-8?B?QVdHcGVHQWdsNXRuMkI3Qk5aaHJXR05OMVo5QnVsd2RGd2J2UFVGRHgwRzZF?=
 =?utf-8?B?dWxRR1VKbldDMXRlWkFOSllPSjE4dlVILzdlRU1uaDJ2R2d4VDk0OWc4a3E1?=
 =?utf-8?B?SEF4VDgrK1JNVEFCR1RMbS9ZTTh5MVBtMkFuRktQYXp6aXQyMTYzckJJRGZY?=
 =?utf-8?B?MWFhZ1kwaGJsUDlDd1lzdlFoYlgwOENzVElYcHNoekZyV01EY1Z6Q1Z5K1Ja?=
 =?utf-8?B?QWx0eWpNRXV3SlVId0pEZzJHSGlxQWhlbHlydEREQWp5bmZIanJybzhYQ01J?=
 =?utf-8?B?cHBSZ2ZsK0k1MVlGc05ETkNvMmcvZmpkVVdhbmdMekVnQUt0YkVSb0JBQ3pF?=
 =?utf-8?B?VldUazE3WGptRTAxL2UyYmt6NWpIZ3IweElQTTNmYStpdndOWEZDZ00yMFRr?=
 =?utf-8?B?cndqYkNVaU9kTnFURXZVUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdJc1A1OFFBazRseHRnQ2dUcy9OcXJtbzExSXVXWkpBemwvalpXRzZUSjhz?=
 =?utf-8?B?ZXhLcDg0UHk3SmZpcGF5Ym1uRTVTR2JkQWtIZGJPa3BwL2dOKzZHYnprd3N0?=
 =?utf-8?B?a3B3RXhDVlV1V01vanpnZ1ZpdnNMdmpoSXBOOWk1VVdGbDNnaTdOaWlyWDRn?=
 =?utf-8?B?Tkw1d3NxZThHcGtVUmZ2THBDUVZGcmVxaEFZN25uMHBPd1hjdjF0MkUraUNR?=
 =?utf-8?B?eVZUVWZ4eHE1Y3NYcERMY1lQTS9Jd1JnT0k3WDZoSlM2N0NPanVVamF6ZTIw?=
 =?utf-8?B?VWM0Uzl1UGhiQ1FFb0JFUVhJU2ZLMXJtRXlSVFpIRXo3aXFUdUg4ZmhlY3JX?=
 =?utf-8?B?Sm9Hc3JLZzVoZ0h0NzZLMHhrZ0RzQ1Q4eU56YlhuTGVGRDM5VW9FSk1TK0p0?=
 =?utf-8?B?Q1dkVm9OOUNXOVNXUndiK2I2NHAyblNWQ0Y4RWpzLzhEdU45OFNPZXIzem1z?=
 =?utf-8?B?cnJ5TndqTENrSmJNS1J3dzBkUHM2MmdoaFNadkhsRzR2LzdGSXJyWDBHMmdz?=
 =?utf-8?B?Z0QvK0dnNFF0S0hZRWVuVnF5ZGpZcWVveUt2NWpublVnYkVUR3lpM3U3dUVt?=
 =?utf-8?B?OVMrNWVWcWtleFVMcjdjenJ5UTRwL2ppejI3VnJZVEJmMmdWdEFRczA4aGhp?=
 =?utf-8?B?cEFZaUJlQ3VyV2liaU9ZMU55cUJFVlMvdjN0QnI2emM5Q3VRWHFGVlZFeWh5?=
 =?utf-8?B?ZC82U2MxNDdzb3hLZC93cjVKdmFUR0JQbVVKWHhieklRNTZUUXQ0YmF0NFo4?=
 =?utf-8?B?d21NNU9aRFBVcE1IWERVQjN3bDlObjNWajFtL1BBRG5nUGw4WFZ6QXhmOEw0?=
 =?utf-8?B?c0pUVXA2UkpidjZCNHFiZ1E4Y1NpRzJQb3VXdFhrNmVQbnZ4M2FwYnBOU3BW?=
 =?utf-8?B?eGFMaHhDN2FFNC9XanFvMElnS3RBSVlHb3BwOFBtU3VLaDkyUHNJUHNJT3Rq?=
 =?utf-8?B?cTdoT0g2N24rTWs1ZmxlN29Ybkc2VEh2NmluNmtTeUNtOU9BOGErS2lGeDFT?=
 =?utf-8?B?bjFSUWVHS3RCUWlDTTFxdXRqcG1mTEozUCtjZVluMGpFbnBtNlZtcGpVTFpC?=
 =?utf-8?B?UHhpZEpGRHh5Z2FEcjI5R09OTytOZUZOM1VsTkNWZ1B0Y1FEMWpIYlM2Vnc2?=
 =?utf-8?B?WVR1UVkrNkJMbHl2OTBac052eUtOaUhtVW0vRU1BWnZjejBoRHh0cHprRUMr?=
 =?utf-8?B?UHM3bkQ3dTNMc1ZLNWcycFlUNFYxNGd6V2NFVmllV0Nza2QxVkZ0VGFQeXJa?=
 =?utf-8?B?dGRvRlVHMnlqYUxHeXlNc2lyV0oyeEw5em9MVlUxaXpLdGxHT1lFODNQVkw0?=
 =?utf-8?B?b1grMzl2K1Jzc3lTbGhXTnFOSm5KaForbGpPMElTZUhYdXd2LzM2MUk2ZUx3?=
 =?utf-8?B?ci9RQ3BNb2YyUUVSNWN0TWpWMW5WeE1CN0JZVHlvZmJOY1hON29QWmZ4N0hh?=
 =?utf-8?B?RHN5YmlvOU1RdEZaNm5YbHNiSTBCWXBaWkIzZGljTFlMMHdPYzE4K0VwUnUw?=
 =?utf-8?B?QXBIRTVJY0x4UkxpSlhqUy8xN2dRZEpmQWVCNG43RVdhR2c0ZytHNzlHb3Uy?=
 =?utf-8?B?aWh5SWluTm1udENQaWtieWVBRERBbjFxMEM1LzlLK1p2ZnNiWlVGeWN2THRu?=
 =?utf-8?B?bkczQThVZ1VHYUQ0RmdVT1VWOUZKZGw0ZkhBVTlJZmpMMHRMVnE1YTdtUk94?=
 =?utf-8?B?WjNvK2JjN3dOR0xxeUUrMGMrem1zWnpnWnVodVBNR04zV1ZtbGZiMHE3cEtt?=
 =?utf-8?B?bVd5N3hncHZEbFdWRnMwWHR6cmQwTVd5K2d0Y1JQTjVtVUtwcmVhR0V5c3ps?=
 =?utf-8?B?MjVCcVBqdTBSY2ZjcENLM3hUK0Vua2dOOVpIZWZDRnVJU0pUWkVNcU1ENGhq?=
 =?utf-8?B?dTR4bnpaUmNTN1BRRXdVemFwaTVVelJlK29adHBzZGRPTklEMno3SzVBS1N6?=
 =?utf-8?B?TnNNOFpiNGRHMEhvRzYwTlR2cFhpd08rbEc2OStoUmNPbm55RUF4c0pheUJt?=
 =?utf-8?B?c0tiYWhYUWFlbUl0cEEzbStSbU1UdHAxZGsxWEphdHM2ayt3T3dmcVNWZFIw?=
 =?utf-8?B?Z1RkU0ViMG45Njlidm4rMS9ISHVQb2NDMHdXSCtpRFhWdmJNMFIwWGdmWGcr?=
 =?utf-8?Q?M+NqjtXvxx/IgnG/82O1INosK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df04e667-36f3-4b95-4bbb-08dd515c4dcb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:11:44.4168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i43kobPAwGPGbRgf14uFiatEe+bmI9fpyu2/ausvt+ucgKkjLgc+Et4+oTCh1FL6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
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



On 2/19/2025 9:58 PM, Alex Deucher wrote:
> There was a quirk added to add a workaround for a Sapphire
> RX 5600 XT Pulse that didn't allow BAR resizing.  However,
> the quirk caused a regression with runtim pm on Dell laptops
> using those chips, rather than narrowing the scope of the
> resizing quirk, add a quirk to prevent amdgpu from resizing
> the BAR on those Dell platforms unless runtime pm is disabled.
> 
> v2: update commit message, add runpm check
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ec71f146fa93..cae6dcb95a131 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1662,6 +1662,13 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> +	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
> +	if ((amdgpu_runtime_pm != 0) &&
> +	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
> +	    adev->pdev->device == 0x731f &&
> +	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
> +		return 0;
> +
>  	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
>  	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
>  		DRM_WARN("System can't access extended configuration space, please check!!\n");

