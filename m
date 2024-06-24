Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2398C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 06:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D72ED10E358;
	Mon, 24 Jun 2024 06:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kC6AVif6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEFF10E358
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 06:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9hXQRwobbwy7n4j4YfpzYpAp74dIA0HLlv3RiWDcf8Xi7+tGlnng/nRMGOtFwLEI3oTO2A+aBgzCNPn0/hCE+GglAWWFOjihcKmMu2mg1eOmvkFUxlY3fGj9SlXXime5uVk2KAOklB3fEMixT2bx3D4yxkzKQqzbzAZJAKhkkouF1yHnKzzdLwSVcfQsvc2yIMJ69ol1Ez2t0lMeHBUrpOFYitSmItaDbi8C+NfRkmIyHRByQ5Jfhwylr2vxx8m67iNIyzKaPZ9+EHA/K5f/i5EDRgxkHfCQMZOFp3OZ7homgncim23Sa4Qwr9j5vzz5Yfs9iBzxhlNSIURQN8fXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTgdgQ/oKndEbahkMNL1yIAr7R9nBceyXnXi9ZB8Rgc=;
 b=WLYqnziXO+DhEXcrIpc6pXmFbzpMMU8jF/kGcm4PjZlCUdKXsYVHYqNwD+pidSyYXQB+k2yqO1pxOs+6PspqvZPvOQJq3V2vce+z9Ietp3UfnHPJzGjvhQ8Assb5Mgp1K15TxCrlKnBQiD7BHzBoQG3Q5H7JowlAiRnCTBFo3vO0EIEAFGj/DwAlLisWy0I4Fhl+VpbzIoVERPzwl1i+zwNp5MkcN5YX6T5lWtiAraWs8RK1qCRkE4oPoVLWdNSsHni/cVFssbqwNF1yxZ4rkiHiI9shxpIOcMK4eH1jEglBW8nrUv1qCb5sGLIHgMeLqchxQhaV09PE19EwYCFYWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTgdgQ/oKndEbahkMNL1yIAr7R9nBceyXnXi9ZB8Rgc=;
 b=kC6AVif6KTUkAIXtRi7a/159UzBQ6AqPQBzeoP9jTVlEjaK6pU1JSP5xpvdy0tvvX9ASNpOXay/3SbUQv8y1m8IPXL5M2aU4oSQ2pYQk/gwctYYD5fKSks76ca+YHclGekvDgOGx8e629SKpXu0tQmIW9nVm487w+4J0CZ0ZIn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:35:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 06:35:06 +0000
Message-ID: <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
Date: Mon, 24 Jun 2024 12:04:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop kiq access while in reset
To: Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240624063109.655690-1-Vignesh.Chander@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240624063109.655690-1-Vignesh.Chander@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: f5cd8d36-0449-4716-069a-08dc9417c97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG15Q2hjVWwzLzBiblU2bEVsYkcrSXhhVVpxaERQSFRlSzdGaWlYNlBLWmR6?=
 =?utf-8?B?QTlpZmlyTENUdUVrbDBrMnY1Y3JXdWppVXlabmkyZXYwcWZrVmlPZXQ2cmRj?=
 =?utf-8?B?NHpIRDhTODNiNW1IQ3AwYWx6andhMHBoY3R6dnYrMENTUVNtVWNtbXlvbXBL?=
 =?utf-8?B?OUpHQzJ3eHdqWEI2UU0zTUR5Mit3UDNkeGNqbEJpWFNuMDVqR3JTUEs5N3Zs?=
 =?utf-8?B?SDhzdnBFcDQ4MWJWVjFOR1Mxb3NjYlBCdzBIVVN0L1p2UzBrSE5kMHJ4R3RJ?=
 =?utf-8?B?aGVsNDZYK3BKQlJiMFZOMnZ2MytOQmdKK0RVeHBLSm95ZWo5cW1ETjFhaEVO?=
 =?utf-8?B?Qkp4NmFkVStxSGpmMENFaXdJZTd5dnMxK21nQnBWK0JQWVZYdmp2Zmp3dGU1?=
 =?utf-8?B?Mm51bkVycnJ4ajZXR0I4bUZDc0RVMlFPbFJRdWxWbmRjRGorLzVWUmFmQWdW?=
 =?utf-8?B?d3J0RUNjU2FCQ2N3R3ZIQVF6ZlVldmZOckpuaFpwcWpFeGwvOGl5UTEyd0Fl?=
 =?utf-8?B?djM4TUQ2SnFoRjZJUGtZK2FiVWFhclpzTXFkN2ozSTNkOVBmWXREWkhZTlZj?=
 =?utf-8?B?Wlo5MDFpVjdObmpiTE9NK3RidGxPcFFwT2Y4RE9JMHpUZlNCWG1jbXJ1UzZj?=
 =?utf-8?B?OVhmWGErK0ZWQnB5dUYwa3RuOG8zeThYZU43dVFMK0hZcFRNL3hhOGZHRHND?=
 =?utf-8?B?am1NMFJxdHpFem9Zc3J0R2plTXAxRzA2MXFtTG5uVnIrSytHcjh5TTMva3R5?=
 =?utf-8?B?YisyTkoxd3l1ZkxpcnpvWmtsM3hoNFFTUVFoZzhxd2todnhhTVI4NFIwQ0JY?=
 =?utf-8?B?S0tLUkd2VjFsQVpwOXRZYUpWVUppVm9XaXhTUFBzd2loL3g1Z2Z0NVhCTXlv?=
 =?utf-8?B?VVhtdFpVOGw0Y2N4aWtKcm1rQ3lIbW9DdkZhbStwaytIMjRSRVg2Y3J2WXFM?=
 =?utf-8?B?VjQwUkdlcHBScG1uRFBwbEV2OHIvdk1aa3Y4dFYvc2lGWG1MWW5tcEp0Q0R6?=
 =?utf-8?B?Sk5sK1JPS09aNlR2TzAvODZjR29xS3NhL1FWYkI1bFIzclArWUFsRjJwa0Ni?=
 =?utf-8?B?TWtGOWRMZ280dHpveC9FS3NJUURJSWlYdzk3ckgxM3hJKzdsTDhBK2ZSbHBT?=
 =?utf-8?B?TThwVWJWcWdnUDZraHlmb0ZPUjFkay83d2xaU0tOa3gxeGhwam1MYzRqM1py?=
 =?utf-8?B?Tk1Kd2RndHlhbFBaOWxUa2VKZWQyWFZuemFhOWNMVUhtT2orTXl5NU9lNXBQ?=
 =?utf-8?B?dTcrME56YlBETVJuVVJrcU9kYzVKSEZTb2M2OGhJSk1aZ1R4aUZIdXRTdjUy?=
 =?utf-8?B?My8yNE9mcmdUMEhFSE4vaXdJZzRvOUF1d2RQTk90bEoxNHcyVkxFS1Z2dlpr?=
 =?utf-8?B?UXFubDVuVk1rSC9NN2JOWGpVUFJPc21LNzRxTGFPU29GWjlqWGQxaHZSUElG?=
 =?utf-8?B?ZW9SdlcxZFlRYzVGMVRzejZZdGNGS3lKb3lxSTVxanBFbzRGcUNveHVXelpD?=
 =?utf-8?B?TVVLOS9IdHRaRndkTzE0OFlXZm9YdmlMR1IzSklQS0JiaWZ1NCtkNmx3Zi9i?=
 =?utf-8?B?SU9hNFpoOHMyR3Q3RUZia1ppTDQ2dElxTmdJcHlKczlIcmg5dVVwMEpDcUk4?=
 =?utf-8?B?aXp2VERZOTRJZE5ueE9LV25oOTJja1Z0aDhDK09YclZKOGhGK29PbjgxZHBV?=
 =?utf-8?B?SkFFZituUk0yTnF5SDF2dHd4OFZQYzNMNWpUNVFTNWRhUC9yQUg5WDIyTm91?=
 =?utf-8?Q?GSNrFkvAVQnnlmJCXl20svkQzdIzfhceVXwU9om?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHptNmVkVk13dGhZOGptWUN5Vld6c2EwNC8wYStSQWFqQnhSUm9SSng3bStR?=
 =?utf-8?B?RzBtWVJCSTFSYTFpSVlVeHlVeDV3VWl4K25rNDAvUzdnclJaV0sxTm13RE8x?=
 =?utf-8?B?a0JuWUlNdjAyRTN5YzFObk44KzVkdzZpaXpXQ3dqdkVJWEpOb01nSDdjWXp5?=
 =?utf-8?B?TW5jdUJSUHh0VS9RTzBvR2lOR1ljWlU2N0FiYURId3Brd1J6bHVvRHVSMnND?=
 =?utf-8?B?MDVxcWM3UFBkaVNnVDJoMXkxZEhRV3lDOHFNbDJsdEhieW9GdVVFTkNpSFJN?=
 =?utf-8?B?QW5tMjZzTDJLYWhNWVRHWkhGS3l2U1A0N2sreldHSlgwQWVZL1gxb1ZhQTZr?=
 =?utf-8?B?dXlwbzBiOXl5T3l1Nm9JQXg3MHNDaG41UzBSK0VDVE1yQ1c1T2RGQ0RaeFN5?=
 =?utf-8?B?a012ZHZ4WUE4RGI2bTNTN3pma0tWcjZYYXJyVmVuVmRiZTVqVDhTcXhwdUx3?=
 =?utf-8?B?bFZjTWxxbkVPcFlXTE1UVWdKL0lsV1V4ZmtoMkxOWStTMVgvaE9HZzFvMkZm?=
 =?utf-8?B?VFluak5wMWkweU1ZRStaU3RPVVV2cW5EY0tjNCtxWS9FbXl0MG5ScDdiTktI?=
 =?utf-8?B?Tm81OWZWcTFEdjR0UU43azNkZ2xRdzdCTDRBM21iSnBSaGREUDhMTG1vYlhM?=
 =?utf-8?B?b0hPTGtGSkhwVEozeGVlSHM1N1V0ODM0eE91MFdDMHZNSk9sZy9TTUdzcU9M?=
 =?utf-8?B?ckh1N2FXYW1BakdybUlnazZvT0llUmtzcE15a0x2T0wzN002c3JrcWREZE5m?=
 =?utf-8?B?cUxqN3U1VWFCeXRsbkpnTWlvelNobk9HenlKNFpQc1RDM1R4OE41ckNtL3hD?=
 =?utf-8?B?dFdwWnFFdDNLTUFBSGN3VjhqVEJVemw5RCs2SmdQRHlaMDRtdHg2bzdseERu?=
 =?utf-8?B?bFJ3dmNwRDlkc3NFbHJRZGk3OHIyZUIrT20vMjIyRS9VRENoY2laRkl0QnlB?=
 =?utf-8?B?dzYxb0hCZUFVQTg3S0syZmRacmswemdHaGU1MGNsa3ZEckM3eXU4U1FVZFVB?=
 =?utf-8?B?aTM0QnoyR2lrQXBIdlYzcWhMUHpRb2Y1WTZRZTVIcGszRFFDblAvTWdhNC9S?=
 =?utf-8?B?blRVWDhENzcvM0JZOVIzQmdMNVF2WU9ZbC9aODdia3JkQnBaRkp1T1BLdXR3?=
 =?utf-8?B?UTlmV0o1S3drWHRncDZhZTdZK0l0Yk4raEhUWXZLNXltcE1wdHZqbDgxSWdR?=
 =?utf-8?B?aUdHQWJybzhuTlQzeTgwUWcrQ3BTa3V5TnZjdW9vdExqWDB6US9EekFnVnB1?=
 =?utf-8?B?QlpRMWhWUEpqT0xqVzZvQlM4YWEyUEZibXhRekdtYWZva1hYN2F0dHJQQTNr?=
 =?utf-8?B?V1hnVjBiQTF0Yjk4b0FuY2ZrTElLUHIxTDdHL1lCa3NWaWR6OFk5RHp1NUhy?=
 =?utf-8?B?TFlVdEZQWDdKYVdQTWRJSzVqcW1VRVBqRnlkck8yWGlWNjFwSXRLQ3Q5M1BT?=
 =?utf-8?B?Rlk2V1hTQlZQVll1M1ArbkxORnJzQ21sU3dMUjMzOVA4dldaS3pMY1VidVNS?=
 =?utf-8?B?d2s0eEp4NFdBRitoT3J4WjBiclk1U2JzNzQ3Qmtwc3NSL3p0ODdlOWtQQWdz?=
 =?utf-8?B?dFZXc2paTFN2Ri94U3pQTHpkNDE4WStrUlhjWG1jR1NnTXlEZFQxLzR0Q1cw?=
 =?utf-8?B?SHMvYlVraG1WRnQrOHBpZmJvUlNOOU5CaWRhTk5WeEg2bTZPZm1OdnZlSDUw?=
 =?utf-8?B?LzIyb1duLzRaTFN0cHNHZmlUQjBLUEluUmhnY29QUm5NN0kxaXZFWmZDZ25W?=
 =?utf-8?B?VCtMamgzRFZVWldaUHUzOWRsczhBTDFaSXkwS3IzMGo1NUFjWVI3SEhPdkFF?=
 =?utf-8?B?MlgrbGcvZ2pTLzRDblpwODRiUmFVN01jSng2U2NpOENGWGFmT0FQcFZNRDl3?=
 =?utf-8?B?R3d3dVFQOVBORkJ3TTM2M3hOc1U1Sm5SQWpValhYRk5MU01LNzBJTGR3QlZO?=
 =?utf-8?B?aUh2UHZLaG9oNUtOTzM1d3lDcDEzUlFUaUlKS3dIZTBjVDdmNEIwbGYrNTNY?=
 =?utf-8?B?cmJHcWw4a2N2cDB5bHdpamR1Zk95S0pINkg2clpSY0pESUF2Q2JtbDNZOEdt?=
 =?utf-8?B?a2VEWDBHTmRDOHBKcU9POTJ4R0NiYzVRNnY3VkIwVHRYNjd3c1cza29vUUk0?=
 =?utf-8?Q?xPK4iCbG4nDxQzOL6QBWb4ycg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cd8d36-0449-4716-069a-08dc9417c97c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:35:06.8870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fKYgtuSEGGU0Fv58y4dBMs6OAworPEvdC/HDKiA1LeL6ZRMS5dW7S/T1A+hsAD4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
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



On 6/24/2024 12:01 PM, Vignesh Chander wrote:
> correctly handle the case when trylock fails when gpu is
> about to be reset by dropping the request instead of using mmio
> 
> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++----------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a7ce8280b17ce7..3cfd24699d691d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>  
>  	if ((reg * 4) < adev->rmmio_size) {
>  		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> -		    amdgpu_sriov_runtime(adev) &&
> -		    down_read_trylock(&adev->reset_domain->sem)) {
> -			ret = amdgpu_kiq_rreg(adev, reg, 0);
> -			up_read(&adev->reset_domain->sem);
> +		    amdgpu_sriov_runtime(adev) {
> +			if (down_read_trylock(&adev->reset_domain->sem)) {
> +				ret = amdgpu_kiq_rreg(adev, reg, 0);
> +				up_read(&adev->reset_domain->sem);
> +			}
>  		} else {
>  			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>  		}
> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
>  							 &rlcg_flag)) {
>  			ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, GET_INST(GC, xcc_id));
>  		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> -		    amdgpu_sriov_runtime(adev) &&
> -		    down_read_trylock(&adev->reset_domain->sem)) {
> -			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
> -			up_read(&adev->reset_domain->sem);
> +		    amdgpu_sriov_runtime(adev) {
> +			if (down_read_trylock(&adev->reset_domain->sem)) {
> +				ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
> +				up_read(&adev->reset_domain->sem);
> +			}
>  		} else {
>  			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>  		}
> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>  
>  	if ((reg * 4) < adev->rmmio_size) {
>  		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> -		    amdgpu_sriov_runtime(adev) &&
> -		    down_read_trylock(&adev->reset_domain->sem)) {
> -			amdgpu_kiq_wreg(adev, reg, v, 0);
> -			up_read(&adev->reset_domain->sem);
> +		    amdgpu_sriov_runtime(adev) {
> +			if (down_read_trylock(&adev->reset_domain->sem)) {
> +				amdgpu_kiq_wreg(adev, reg, v, 0);
> +				up_read(&adev->reset_domain->sem);
> +			}
>  		} else {
>  			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>  		}
> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
>  							 &rlcg_flag)) {
>  			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, GET_INST(GC, xcc_id));
>  		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> -		    amdgpu_sriov_runtime(adev) &&
> -		    down_read_trylock(&adev->reset_domain->sem)) {
> -			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
> -			up_read(&adev->reset_domain->sem);
> -		} else {
> +		    amdgpu_sriov_runtime(adev) {
> +			if (down_read_trylock(&adev->reset_domain->sem)) {
> +				amdgpu_kiq_wreg(adev, reg, v, xcc_id);
> +				up_read(&adev->reset_domain->sem);
> +			}
> +		    } else {
>  			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>  		}
>  	} else {
