Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756E7C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 12:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1712E10E0E3;
	Thu, 15 May 2025 12:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HofG7D6r";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D80810E0E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 12:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCPbQudNZXh9VtPZDv6WdSwinLzuKIMwi7ybvYoMG89G/H2EBtQyKQFBvhSA8d6HAilyZhFRrBauO6APj+vVi/NpyCcqOPRGy5Fgi8dugX1WeiLHJogb5k9nA1MSF5iZnDB4TQhofwSi978OdwZcvnrt0/xcg3wbjfz130dZzzwOqy+MRnrk5b+4MWErYhwjZItBcJFn+O8+UmOnPUeP2iQ1wjdDL1OEtTJXpFbtqlC3VPsFWFhKx+dXcfhYegkPK6FOH4DRWWZx3FPO+gx7q9wa1d2mXzL6D57pO/Z0/K1+I5hhS276AxxKBv+bg+wv3wZX11yqOaNazQIZRfSi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNdrq2FmJIfuubdPtGUjHAiqP/h69kXfhNv2pRc3T2c=;
 b=DKR39NzdVWoxlu5pex7iihLIgOA/2ymHA5cn2RYDmnk3Atk6eXae44sDMrwDsfQ1I4FJQYveuP6gY0CNIPpsixcVTtGyjySi3eBeuqeejKt4ZYlTGLwUVTJD/6fHZwXkI2OF9Lr7T1YqAssIYqY4qvAEqjfpdGbmHf8EU+wNXeNRuTUe+F1/0o55RPZQAO9gQVHBeVZb7M+yprTc7Pty9gNvH7lAmGsmm3bSs9csDC+nJiF9/fnuLtL/JRvZES4Ypr9GHJmg9mQFy1WGf7Nf3CnbeQPeXmQ26/XV0DMxktdQC+bSrru63UWcqwMuJxbDzOV3VF7CwiFYev3IeGm9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNdrq2FmJIfuubdPtGUjHAiqP/h69kXfhNv2pRc3T2c=;
 b=HofG7D6rPu6Y+VCVIQGiUr+DyOCs8w19VtBEXtWcNKamdMU8OU5pjD/hJVgp/cyUgE2l0Q66lnBwzeHcMFSaB5vkOt5F6NWnCUgLY3easR0sq+ypgLi4k/zoKALqWXGVB68+G9Yz1S6sZ6rcHDRlfJz+AYe3jHSghCJg4Qx+aaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:10:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 12:10:04 +0000
Message-ID: <98519383-edeb-40cd-a4c7-c3e1c531a8fb@amd.com>
Date: Thu, 15 May 2025 14:09:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix user queue wait ioctl fence counting
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250515094414.1786372-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250515094414.1786372-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0395.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 697d0550-dd22-43bb-af98-08dd93a96ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2dqSUJSMWMvWEoxcDNQWkJUQVFnbjBnelQySnVIUWY3ZmlCNHdha3NKY1FZ?=
 =?utf-8?B?S3NBcHNqYzZYb2RPYmpnRXRvL3NTT1F2b3lCaXNvaEgzSGtSR09GSWFLaGRY?=
 =?utf-8?B?R0V6bFZGLzZPcG9vcWQrSXR4U3EvZExENTU2eGF5eFVBajlpVWMzT2RIV2ts?=
 =?utf-8?B?SFZzdGNrRmVkR2VrVmFTdUdMV0ExQ2kxbWJyL200b3dBT3Y3dXVOeW5uWjJt?=
 =?utf-8?B?dlBWd1JjUHh5b1huZExzanFXMGJpZG8wNG9CM014MExMd0JrbFYvZUUzMnhT?=
 =?utf-8?B?cDNnYjltMmZmRXpnU1hLNG9mNkc0blJPQUxuQ0dWYk1hUTVhTm1lWGMwT1Nk?=
 =?utf-8?B?eCtjREFERUY0dXI5OWptamtTOElwY2JVcXovVERDMG0vYVFNVzVsYWc5Zk45?=
 =?utf-8?B?TlR2Y1I3aVo5c0t3QWxMaTBoeGQwb0ZQVDg5MkxzTUI2M3ZQRVZxODVIQitJ?=
 =?utf-8?B?MWI2a2QvT1NLaGNkYW11WVNQSmFBRk04N3VQQm0xbWJWd3N0djBoRHIwOUFC?=
 =?utf-8?B?QkR1TDQwRWVJTWJLNjYvZEtYOStuV3M4VEtJS1ovV2x3OUw4blNlUkZoT1pq?=
 =?utf-8?B?ekUrZ0NyS2hEamNuVzJFeHF5Rk5DbGYwSSt1VjRJZHd0bkt0aldFL0MrUCsr?=
 =?utf-8?B?REorVkh6TzFIUUIwR0RaaDJzdS8yRU1jSjFDVklzazdEVUc3MFVyTXBwaUts?=
 =?utf-8?B?bUY5ZFVUSzBndVFNbmNMRmlQUUhvbXJ2cEhVdTM1WlAwTnI0THBJU2RMVWlJ?=
 =?utf-8?B?QmpsWEdLV053WVNwQ282dk41YTlHdDNJR2E5VmhzaGFVTnV6ZjdhQVpJeXFs?=
 =?utf-8?B?VG4zL1ZTUXFjNFJ2b0R4dGRxcW5rTndmbUVzcU1mTStSdEtKVGtNeVZuN2lY?=
 =?utf-8?B?aGR3V3NIRGJBT0JzWTFKQkJCSzBPbmFQRVdoL0tUQ28rVHRHQ0JZUERMSTRn?=
 =?utf-8?B?NzR6M1g5eDZrSVZaaS84bUx6elR0M0VBWUl5Ung1OXRFRWowdVVZODZ1WGR4?=
 =?utf-8?B?R053T1c0NENXM203VjlWV0VsTWhaaTczZjBjYVUxNGJFcW5BTHk0a2Jsa0t3?=
 =?utf-8?B?ZlVHOWRvMTBheGphRU5ZbHg5eFBSNkhwOGwvT2JVMHM1UUNBUVZCdi9VVGc0?=
 =?utf-8?B?L2FBeUlnWFRKVXpiLzlMelRweFY0bG05ejZLdkRyMXZhVEpnSFlJWXlsNU8v?=
 =?utf-8?B?cng4ODNkS3NBQnNqbmhnZEx6RWZnZGl1WDgxeW82RVVTdHhCcFdsK3QwNEFn?=
 =?utf-8?B?aEtXTFNxSGtHbG56c3FSL1BpU3JkY0NleXhPamVodngzUmpoMUJBa2dqS3BQ?=
 =?utf-8?B?NFFkaU9rWTh4YVhVMmplOGw0VWdqL213R1VDTFFrS2Q5REhKNThXM0F6aXFL?=
 =?utf-8?B?K2hhZVNEc3NFaFhOZXkyQ3lxdHlVSE1vVllxRFZwNVdvNWlGbG95T2FxOEVt?=
 =?utf-8?B?TDI1eC8zNldkT1l0WGlJbGdMTHBHamtPcXJQZTBQTGtweWlwVEFKYW9KMVpX?=
 =?utf-8?B?bXgxL2VkT0tpL01Cd2psaWx1K2xLSFRYdlJDclZwUFlxcnI3cGU0NXZ4Mytv?=
 =?utf-8?B?RFFkelZDMGZrVmFrYmlJV1RxeWJSOUZXVzM5bmpuQnVaR0YyUHZJb0VUUUZ0?=
 =?utf-8?B?cXExenJjZSt0Q2xUdWpLaVAvYWdMMG9QRS9RRWxHaGNldGJWVGJFa2xmNzdp?=
 =?utf-8?B?S29tZnZueCtQTzJsUDRvUEJRdTVjdkxtRWVlZWM1QzVjT1pPU0dMVDBCR3dU?=
 =?utf-8?B?N1ZoN2N6aFFGYktiQTM5NVNZZHZxK3BiTUtTQmRUdzhyK0RiL2xvclZoQU5n?=
 =?utf-8?B?UndHN3hwa1BiUUQ2eFVxWWZxN1plVm9KM2NzcVNxdFpXSVRHb29kWnRYVlRu?=
 =?utf-8?B?TTViNjRrSERXT0pyeVc3M3U4UGhjd2lYN2N2cnNLS25ScUZFU1BWZFlGK2dN?=
 =?utf-8?Q?zed9zGFhZ7A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS8zdUpvTjNlcHlmS3RlYXFzV1VpenE1SEFtdmRIeHVIQUVzQUFrZ3l1aXUw?=
 =?utf-8?B?QjNwemx3MEp3S2x6WExpQzFPeDloZksvN0xSUWpwZXluK3IyYk1ldGVTQ1dn?=
 =?utf-8?B?WDBQRkRNNUhQeGlXcXpGc3Bkd1BEUHFMNGl2T0tDd0ZTM3FUc2k3UVh1QmlQ?=
 =?utf-8?B?V1pIbm1ZQ0hPZkZTS3AzYU9iR0hVL2M5UFNHYmZVOVlOVHhNRVRBV1Q0Vk02?=
 =?utf-8?B?NnEvcWtCR1h2ajdkR2Eyb25DVmJzQStIcUkwRjBRZmFtU2lCeDFEV0VmeG9W?=
 =?utf-8?B?Smx6R1BwSDhkMGVzQjdCT1NXRTM2VGdZNUEzUE5adjZKdk9pRmcyMnVwNnU2?=
 =?utf-8?B?aXUwSFYxamdEM0RVVmN2MVBzNytRZ1JIUHlLS0JwUWpJNkxXL3ZlR2cyTXN4?=
 =?utf-8?B?RENSU3RFdUt1Mk9ER282Y0xyamlleDZ4ZzdvQkMwZVBXdTBGVXVmcGFOWFN4?=
 =?utf-8?B?T1dwbnNhMldnbWhlV2U2OFV5aEg1Z3FPZDZvcUVVbVJ4SEZra2lNUWdkWUxE?=
 =?utf-8?B?ZFZlVWNRZko4YTV4MHE0Q3JaSGhSeXZGS1l5RjdsOVB5OTZSUFAvbFhTU2pI?=
 =?utf-8?B?enBQQlRnQTVYeEdmZWR1SFFqZEVNVU0xTVY2MEtEMFprd01RSlhrTlJqN01y?=
 =?utf-8?B?ci9TZmdPbmZLOGZrNG5RUVJNdnEzajVrY2JxdjdjaDlCd1p4Q0doMDdxQ2hP?=
 =?utf-8?B?dEFPSWdSYlRMM0g1Ui9aTEowdWtncndnNDhhS3JCMXVpMjhKUmdJbUMySXBM?=
 =?utf-8?B?NTVHdG43OXBmMUFsVkFUYlVsL3BPZXAzNGJuSmY0RWpDaXJaNjJnOElSTjd3?=
 =?utf-8?B?VVgzN3R3WHpZeGh3VDAyUWtLcmJLWkg1Z0doRkRvaTFuM21ybkhHU3pBTGpX?=
 =?utf-8?B?cjJOTUJadmJkS2V6R21nb21wSXFLVTM4dW13aFR0ZkU0dk5rSkZsNjROL0sv?=
 =?utf-8?B?YjJscUlLQ2pyckhmTGdmQloxWHVZMTFiNGNCbmZuTDBWUytDeVg1QlJhdmt1?=
 =?utf-8?B?Rjdic3ZVTnlCelhNREtwcUNUY3VZaWhWaWo2S3pSb2JQUHd6R2g2UHVGYmhz?=
 =?utf-8?B?ODMyM1BWS09TS2s5c1Z0U3hYV2Fscm0xTm5aUGN1d2xGMERGTGV2YUE3U3JC?=
 =?utf-8?B?M1FRaFl5d1RQc0I3MWJVTDcvZVlyODV0alZhVDVTVFhzTW1oVnVPdCs4UzNt?=
 =?utf-8?B?Q0hGamxIc2JaUEZKTG1qaVhFSVdNUFZFUlVIWHV3NFlnTWkzQ3pyMzh4QnpK?=
 =?utf-8?B?bXRvYlp4TTNMcmUvOXc2Qmk3bkptRHRTNVp5bStEMUh3NlU1NXVnMVZkK0tV?=
 =?utf-8?B?ekxuaFhmYzB4NWRBQ2cvMUdFRTl6US85WmNtRkVQTmw0U2NLdk9HTDdxdldy?=
 =?utf-8?B?RDRvejY2U0lma1RnU0R5YUhUNVV0c0t1YmZIK0tTT0hLWDdrdW50dDBwUkVT?=
 =?utf-8?B?L0hZMXkyL0EyZHBLNm1uMXEzdFo3RHZoRVVLYjMyekRVeEFoQnQ4T1BFZUdH?=
 =?utf-8?B?L05nS1ZqYTRRR2txbzVzWXQxUHdYNkVGVEhva1hnSElzZGdFbGVPSDFSeHZx?=
 =?utf-8?B?aE1COWJjRi9YMmg5RTBCbDJVdVlWb3g2TlNQZEJRN21WV01ENG83RVJpRjlQ?=
 =?utf-8?B?MUlVT012d0gzUkp4V1E0aHltUVFOaElMbk0wb29EVmdob0ViN1BIc1V0NU11?=
 =?utf-8?B?dmZRU29mTXVUMHRJcnJjZ1RsOUs0NVZRMHFUenZWN0JuVVNTZjlXaFZDSnpN?=
 =?utf-8?B?TDViU1Q5NDVobVVYcGtKT04wRG9NNFNkUldxakxuMnB6T3hyOVkxd21GUU40?=
 =?utf-8?B?U1RHRFhVUW1JU0RlMi9tSHdCT3pKVG9mZHpXYk1CR0o1eXNOTERzNUNERVMr?=
 =?utf-8?B?WEk3TGp3UEhXNWd0YS9YS0I3dGNhTXR0VmRSN0M2ZXlKNzlPTkVLUHVXYjlX?=
 =?utf-8?B?aGNTTHlSaGZuNXZmaEYwazdkdWxKNzFPNVMrOEdmUnA1VjNFdVhGYzFNRE56?=
 =?utf-8?B?dWNySWhWN3ZpeThINlJVeXNlSmh1Vi82d3c2RWF4N2l1cFpvaXRLSmZPVWJ1?=
 =?utf-8?B?WWVNb0VJSlRFdGlJdENpV3dUZ3YyYUx0SFJFOVRtSkhtblQvcUFySXYyWmNk?=
 =?utf-8?Q?Ws0hecZIv7OkGi5eZbABtqfjD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697d0550-dd22-43bb-af98-08dd93a96ca7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:10:04.0391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAhpuF7kaj8hwtNe5hz1QsXDpqTeKYDxJ3tUoirqCCWZQLlthpmpQM3VgQFJ+bxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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

On 5/15/25 11:44, Jesse Zhang wrote:
> The original change "drm/amdgpu: promote the implicit sync to the dependent read fences"
> (commit 714bbbf20a72) modified fence synchronization to use DMA_RESV_USAGE_READ
> instead of DMA_RESV_USAGE_BOOKKEEP. However, the user queue wait ioctl wasn't fully
> updated to account for this change, leading to potential synchronization issues.

NAK, that is superfluous.

BOOKKEEP fence should never be included here.

Regards,
Christian.

> 
> This commit fixes the fence counting logic to properly account for both:
> 1. READ/WRITE fences (for normal synchronization)
> 2. BOOKKEEP fences (for eviction synchronization)
> 
> The change ensures:
> - All relevant fences are properly counted before allocation
> 
> Fixes: 714bbbf20a72 ("drm/amdgpu: promote the implicit sync to the dependent read fences")
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 029cb24c28b3..8c754474882f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -735,10 +735,18 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		for (i = 0; i < num_read_bo_handles; i++) {
>  			struct dma_resv_iter resv_cursor;
>  			struct dma_fence *fence;
> -
> +			/*
> +			 * We must count both READ/WRITE and BOOKKEEP fences since:
> +			 * - BOOKKEEP fences are used for eviction synchronization
> +			 * - The wait operation needs to synchronize with all fence types
> +			 */
>  			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>  						DMA_RESV_USAGE_READ, fence)
>  				num_fences++;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +						DMA_RESV_USAGE_BOOKKEEP, fence)
> +				num_fences++;
>  		}
>  
>  		for (i = 0; i < num_write_bo_handles; i++) {
> @@ -748,6 +756,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>  						DMA_RESV_USAGE_WRITE, fence)
>  				num_fences++;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +						DMA_RESV_USAGE_BOOKKEEP, fence)
> +				num_fences++;
>  		}
>  
>  		/*

