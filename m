Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCABDCD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 08:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67C610E6BB;
	Wed,  4 Sep 2024 08:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AqxGkvpQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E09610E6BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 08:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmYMCK4cf8vjh4BpvNHlp3Qdao0WW1vgwOiJNKsgX0Tc8gFPDMSkYS3AV7dkBL2LSdnbpc2+yi8G051vGggJTl0Fw0CD+cbufbG5o3sD6iurh1mDFIKpEY3BIvHEATJMdVs8Vc2q+e0koYBUCq55Lc7UZD5EfmKFgK1sbsmX4eT+B286kLQWLm8UNqp07oZ82WWx3dwIWr3qFjMBruMcG6Z9QcDWEdmdGhb4Bv7LkWPZYghcBp6F0W7IeHnWm7HCtLGYGffXOMkrVmsNpCBXQ3vB3wTXXclJZwAG23l6tB+0A63XK3pmdb4TEomxbbXh+vBZVazhlxdPQUbXP+Iyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHJxrm3dwWFvrl7eXNBC9KFPdKeimDvCJKs9bqn3UMc=;
 b=gdaGiqut69oyZzeXZSDyHlVRAK+llJY+RqsByBKHLJF99l1R4lgzTwUwoB12q7+NdBXLDzP4QU+5oB297uoDfPf6GGLPnEjLl3oQnb+qb1Oz4/NHT0srbP+ft3tzRvR2Ud70OSxQLhxlpqESaikNOr1JgGtz7PlGkgrAVFrlXT6B1qFF+Khk3t4Kdi9Xgk2zYp4lW2sCRfV6OSV9GYvgnz+qvDfbbAKHc/YSXWZpNYFlcccb5AW8hJ7Gz0cUjTzm03zHhHTFHVNOV1gEoGgdPkYSxf415kb9e9tjaU5Lt4TVYQt/hDKulu3McUhloInEtXCudnJdIIX3+Zwo6itrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHJxrm3dwWFvrl7eXNBC9KFPdKeimDvCJKs9bqn3UMc=;
 b=AqxGkvpQylCE87sRr1FEEQpJh8pj+oHQi8ZChzQhmAKXLo0xQ2oiM0ojOIZL/Scgz9Q3BzJfjEp5XLaJ4eftHNizvzeYcg+ccC1IMOFXvihZWiP4Ol+5MR0+NcyFVLG+C+/JkSLt5Aw3IeNgjiRbVKbNmraQhnlDVD4vnXtvK7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Wed, 4 Sep
 2024 08:05:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:05:27 +0000
Message-ID: <c0f733fb-8b33-4791-946e-ade43b03ccb1@amd.com>
Date: Wed, 4 Sep 2024 10:05:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix a call trace when unload amdgpu driver
To: Asher Song <Asher.Song@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com
References: <20240904080420.559277-1-Asher.Song@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240904080420.559277-1-Asher.Song@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bf6670-5258-42fb-29ad-08dcccb855eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1Q4cGdnSEdJU2Q1MUdrRHFPbGhVYXJJS2xDaXRaMDRFTGcxekY0U0RSb0VR?=
 =?utf-8?B?Q1hENGFsdkFPWGJpeVlKUjVYWFJQbUV6RjVxMnBhamFnUk9qellUOEV5QXMv?=
 =?utf-8?B?M1RGS1JpYWlCZnFHZFFLVG5CU21UaTNvQ0ZuZnozd0JBaCs4MHJYbFlNN2Zl?=
 =?utf-8?B?T0FLeWJYRjdTQytPU2EzTys5YjFWUlpSSmU1a3E2cWNUWWhsTUJUOTR6blNk?=
 =?utf-8?B?SVFuMkYzVEgweTZzeXk3T1VNc1JENW5mM3lyWjFlbThlaFo4aHBidmV2SmJG?=
 =?utf-8?B?Q2lUUDdqUzcyQmJjVzloaEN5bC95N005eVg1ZXRHT0VCZUdESHJZOVJpb0lO?=
 =?utf-8?B?RXlxQWxZV0lybjNidDZxY3E3WkZacVN3UFRaeThkRDBpMTNHbGVaWkU2MUJo?=
 =?utf-8?B?WFdWQU8vRnIwbVNEUmplQUJ3MnhxQ0RIRXR5VURNU3FwY0lPTGZmV0dhV2o0?=
 =?utf-8?B?QzRiaFk1czF0QUoxN1RjVzlobEVMcUora2xBUDE1TktHUG1OVTRRUGg2blFH?=
 =?utf-8?B?UTR4VFhqWWpvVk9DeVBsdE10L1YzcUMxSzQvZm9aRk15VXlNSFlvMjlBd200?=
 =?utf-8?B?WVhTMXdHUEc5M2ZJbUxrZkFtM3R5bk1CS1p0b0ZBNHljd3p6RjJtcGR2ZFFL?=
 =?utf-8?B?TDd4UDE1b2gyM1F1WmVqc0diLzZXaVpSWkFuMkdhVTF3Z24wK2VmVytkdGNE?=
 =?utf-8?B?THJmZ1QrdkRCZ0lMdE1TM1o0VHdRV3pFdFJlK2x6RG9acFRNc1hYSDlIVGo0?=
 =?utf-8?B?ei9ydk9TOW05WkUwYkFJeFFEM0tJRXorMVFtT1VuTldxbGwvcm9PUWN3VWN6?=
 =?utf-8?B?WjRiUEhQci90cytCSlpzNFllSFZPMUI2MUxtM2JVSDRJQ0hPbVNsQkJHS3dh?=
 =?utf-8?B?OUhOVFJ3SThYQ2tkOEFKTlkyS0ZsVzFZTFQ1VTEvYnFnUDNYTzZRcmZHMVRp?=
 =?utf-8?B?d0crSTFiM25CQkdoWjRWbGRaKzliVkpabGNuOVlTZEhhNmQ2b1VCeW03ejRM?=
 =?utf-8?B?UzBQYnZ1OWtsL0s0bUYybDBhUUU3VXdMMFVOUDlEVXhOcm41Tm1hS0VzUWQy?=
 =?utf-8?B?SU1JMS9QR3RRVjNORWpaVEg5VTR2YmVScHlNdUNBT3N6aE1QZnQ3TFNYWnNu?=
 =?utf-8?B?ZVJvV3N1VmdDTDZiZ1grQlgyc2I1aUNlVzlDOE5oOTZDeVZpdUhmZzZIbUh5?=
 =?utf-8?B?d1A3dlFqZGhJbFcrKzVEejdGQWE0cHIvd3I5eUVvZDJRNUhvcFlGamVpZFM0?=
 =?utf-8?B?amRNTkkvdGJzc3FkeVZGWFA4VS9jWEtMRzBQdm15ZWpIci8vazFndFBqYSt6?=
 =?utf-8?B?d2pianBXc3R5dTJ5ZlZzN0t3MEdGdzB0TTg1bHVBZW8raUZNL3RJWmtmL2Mz?=
 =?utf-8?B?amkrY1pEaXV6aDVsakNHMHIwbXc0b0d1Q1Z6UUFheFMyWjNnZnp4L1BpM2xH?=
 =?utf-8?B?MXhlWXpsL0RVbU1odkNRd1ZnV1d1Ny8xaHl1UExKck9tZmxDMnBUdVR4QW1X?=
 =?utf-8?B?Y1pNVjNUUDNiZkpPOXVpSDVtRCtOOVh6c3VXMEVtYzlIYXFQSlJjV054dW9C?=
 =?utf-8?B?V3pGb0JNMkEvaXNWaG04UDI1ek9nN2RhbEhYN2txNXNpZ0hLMnExVzNzb3ZW?=
 =?utf-8?B?STdKOGovT3NzTTNLWURBZ0RsMGNPVmQyVUprV2M5N2ZxKzliZ0hDeG02VXJG?=
 =?utf-8?B?cEpiSVhOZnBwMXhCay9TM0c2M0N0djlqcGlJdk1nL0piOGdiWjhJMmJSUitm?=
 =?utf-8?B?LzdScHhGWVhqdVd4aDZ5amJ2cUpmd0NoRmhWTmVweVdiNHhiaGlyUllHL0ZS?=
 =?utf-8?B?aGVrYzJNZXlmU2FyRzJRUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEZhVmRJNEFiWGJhb1gyM2ljVUVTQ1pTcWl2QnlsNndmcmp3Rlhlc0tiVXBM?=
 =?utf-8?B?YlRyVHJiQ0xsclZsSlVDaEJLMjN6RzhSRnliUXpSa0xBbzMydXZKdVpvdVQx?=
 =?utf-8?B?RGx6VVdkNW5meHJHSmhqM0pEbzdtaTF4NzN1KzZyYkdNUWdlUUhZL3dWRlRx?=
 =?utf-8?B?VnNKQTlDamJRbnFzNUFkUC9iQm11aDBkRVhuT2Z5SzN4c1MvSHkzbFJQaUF4?=
 =?utf-8?B?VUJsVDVZajU5Vm1NUW0vTUJRUFJtbXNNRGJGS2hZSFRFZHhQaG50NjA5SCtw?=
 =?utf-8?B?R09xdHlraU5Sc3FCTHlRKzFQQjRIRmJRUXFUenhyZDZNSVRtOWhyL2hwNjh1?=
 =?utf-8?B?OVBjc3dETC9hUlBSLzdtUHlRdklneDBnSDZKNzRvbE80VzdTK3pORWJyUFh5?=
 =?utf-8?B?aW0xMjlDUHhIbFFqU0pvV3F2NzM2ZnhWanNieWVnSUNNQjhWQUhUcnZOeXJ2?=
 =?utf-8?B?S0dmWEFucmNGbzdMemMrTUxoYjB2WUhhaG9qL0lNc29vUE56Y0djWW9iN05B?=
 =?utf-8?B?YWQ2TDhuRk9Od1dWN1NMZWVTeWlGdlhUY1Mxc3QwQ0tLS0s0THNXcmo5M1p6?=
 =?utf-8?B?Y3VtUFdMbmt1KzBpcHdUK3BnUkdzbXpLa0tBVDMvMXlyQUUvNzlpOG42ekFX?=
 =?utf-8?B?b0dBWUxvYUphWTQ2ZSt6dWx6dXV6R1JUVzB0bXIyY09PMkxZT0N5MDBhSlBm?=
 =?utf-8?B?L0d5a1hmS09IR1hZRWdjUmJDck5XRHdscjZtS2NUY1lWallXVTFQQmVaR0JS?=
 =?utf-8?B?T2c0N25pTEJtT1FwM1U0N1VvR0oxNUViSVBsSndWMDF4RmNraHFMTWo1bWpa?=
 =?utf-8?B?bWpnMUFPR0VCUHhpUXBQOFFaYXEva3R0d2RxazVab1hUeHArdkVTMGMxTkxa?=
 =?utf-8?B?SHplV25mbTgxbVNMRzM3Q1R3RzVnOXZxN1N2Tk9MajhJRk1ZbXZyNlZHQXZ4?=
 =?utf-8?B?ODN5K0p6OG0xTHlLcWYxMkxPWnlobm9UUHY1ck10UHBDSTNJUjBMZE8wVUg1?=
 =?utf-8?B?UGMzVmhXNzNyRHVvRGl6aVNrOWt2Rkd0T3J4Rm51NXBhbHJVV3E2bjJIVDFU?=
 =?utf-8?B?aDVqUmFVRFlNRHZsKy9SN1BpYzlzcmIwcEhSU1RoUWRmcU1XS3BhRURjY2Rw?=
 =?utf-8?B?Qzg3MDU3eUZ3UW8wWmQxMzUzd1ZRT1lnNVJLTlZVTmVhbnhhYllaaWZ4SjFJ?=
 =?utf-8?B?SlN0NlMwMXJ5WTI3TzJBV2xOSStSRXBFREo3THJVdFFlVHlVb2xMdGF4VEpz?=
 =?utf-8?B?bzNHeTUxYzM2ZVhGdkM3elViUWtJUWJKSXIxeGpSN1JmNnZTeFdkcUJCMDll?=
 =?utf-8?B?azFJN1NzbHpYZlVNNUVrdlAyM0FwdklnTUZBNUwzS29WL2xMbm5KMG5wK2Rx?=
 =?utf-8?B?VUZZT2RBZDhWeUJpMjhndW9YWVowSm56MkVrR3pnMjBjTmo1TVlZZ0h0aTl0?=
 =?utf-8?B?WnE2OWVhMEUwNkExajdMTWxSWUxONnd1NTRvUG5aT3lvb25Xakl2d2NYMjNX?=
 =?utf-8?B?eWZuRmlPeGJWeStoL3NqczRDdzBheG1qSmRuZlFKYnc2WXJPQS94TG4rNVR6?=
 =?utf-8?B?RzdEaU1tajVFdnVDVXl5d3h3VjlBeTFhMDdqL0VMSnZsMFlsMFpRdFhpQ1Vk?=
 =?utf-8?B?VnhsNHBHWXhkVVA1SzFNaXpHcjhrWFBqNlhoMVlxZm5LM1FlUHE0TklSbFkr?=
 =?utf-8?B?RGM4WHBMakx3ZUoxL1pvSmp0OVdzSTl0UHkzOUFYNlMxK3Y5WGRYMU1jdjBn?=
 =?utf-8?B?MHAvOVNoMGNPMGRWOXRpT1pLOXBQc2Rmc2hNM2I1VjNzWlc3RDVXcWt3QnRo?=
 =?utf-8?B?YXgydS9VS0crUHd1SnhBNFB5N2I1ckI5SUsrb2ZSSVNSNnBDaCswS2YzVE8z?=
 =?utf-8?B?eDRibTM1NzVKQzkrdGNkRTdad2cvUUoycURicjZETVB0TUxoVGNxRHAzTitM?=
 =?utf-8?B?SXREOUtiM1E0NlBEMmU5QmFqc2dLUkV0TmFlQm4rWFZ3SFQrUWhwbDg1dDE5?=
 =?utf-8?B?L0tsYzBsRy9ReE5oRzNyMjQ3OCtvbS8rZEZxMWVVbEo2SHRzR2JySjlOdW8y?=
 =?utf-8?B?Ukhoc0R5QVc4MTNtSklkNWdTb0pRNGlDd05POUxybkMxRkZIMll4MkxINnBk?=
 =?utf-8?Q?fYy2XgNa0TlO9Y6NvuzZlEgIj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bf6670-5258-42fb-29ad-08dcccb855eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:05:26.9660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tojG7QbWtHD2jbVC/FwxWxcwB7bFP2fY9eT+QTX1/nlRCO8OkHutTbhLGbRKiHeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
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

Am 04.09.24 um 10:04 schrieb Asher Song:
> In some APUs, the bo type of GART page table is ttm_bo_type_sg.
> Those type BOs is released by bo->delayed_delete which is added in ttm_device->wq, not released immediately.
>
> To make sure all the ttm_resource is released before ttm_resource_manager is finilized, drain the workqueue in ttm_device.
>
> v2: move drain_workqueue to amdgpu_ttm.c
>
> Fixes:d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Asher Song <Asher.Song@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5c938ff0bf48..cbac21df5c47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2461,6 +2461,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   		drm_dev_exit(idx);
>   	}
>   
> +	drain_workqueue(adev->mman.bdev.wq);
>   	amdgpu_direct_gma_fini(adev);
>   	amdgpu_vram_mgr_fini(adev);
>   	amdgpu_gtt_mgr_fini(adev);

