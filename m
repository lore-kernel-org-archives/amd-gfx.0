Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF4CF0453
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 11:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F227110E289;
	Wed,  9 Oct 2024 11:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L82tnvtM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB73910E289
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 11:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvtQfSIFmNd+rn1An2/EKl3C4As7lPihUKXeTnOCIBQb5fQFfPXG5cuEbzIMF1jxZXrAd72wp+9E+bER2fI0+0VjbadcY5OJVDqATykgP4JmG4IQVIDBSiqUGyimWpWBUPhb/urYPT094m9MtZGV9k+PZ/z7DBS3C1l+Ixf7vuQ+5ylap7mWgN5RtP6bPi7SoKtGca5SS8S1T7EXDsbZL2ZXu3NlNBebc4uOTpejNoameUuMymAjY7tW/DuOMDwr88HjsC6I59gX1E1lYTK+D5Y9tfUcVUn/g/TOAFpO5AwXmilBfpbjYSZZ71bCQDGur4XonWp4ylf55HJsQHucsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd2MDlXdkT8yo4jQUtFaxSedKJ9iSvtkMKHcJr9dUI4=;
 b=q9O2VR65+rjzhyxydHoNT/qHtUOPHmYHzqw5QkcmwfNVj7YhQ7VcHUBl0/buBePzi3P8r6jUG3fuf3R0wlr+hEdDUdX7mt2dxcGy/2kdiVxZOqQIDI6jxoeipjTGj8sO4QX3qA9atjrYRkXF6S8UfhFO58T93zGrxxWNKZtm8+r6+KVW0WpZ3Bu7p2qwUNVs1Qq0glp/pPxrOffaZ35Nq3+G6ww4Ydu3Ri+HbyvdhOgu1yp70bxdpMy8WHi2crqO0eBl8e1xbtlUp0svG5K0/3Ouq4IT3XrfOsLppFt3vlrKrWc4HGUCXHqGXOI37GhlXHlMW38770LBbQo3bfkf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd2MDlXdkT8yo4jQUtFaxSedKJ9iSvtkMKHcJr9dUI4=;
 b=L82tnvtM+bTEF9ydzRshPZwwyvHWfMxXjeE+Nd8kJJtts4JZsybpDft/40/y89/ZttXgzq2S+cwYgpWemnP16uc/Ei/WnIZC9NP8HJKu1j2w7q/W+D+dQmUlObShupDhyrP1AIFiV65oeRgRz51VkoyV5n3BtWkvaGgfeuoUD/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 11:08:41 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 11:08:41 +0000
Content-Type: multipart/alternative;
 boundary="------------pSaWbHeAqaGG4s7TnDlxGh09"
Message-ID: <8e182f9b-0906-47cd-bf29-42f770265749@amd.com>
Date: Wed, 9 Oct 2024 16:38:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable enforce_isolation sysfs node on VFs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Amber Lin <Amber.Lin@amd.com>
References: <20241008200542.3891752-1-alexander.deucher@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20241008200542.3891752-1-alexander.deucher@amd.com>
X-ClientProxiedBy: PN0PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::23) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdc4785-e061-4a5c-c775-08dce852bb95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVpReElGd25BSHRJQzE2TlY3Z0x4SW16TW1hZzVYaWN3WHFKZ3IzdHFpZW1G?=
 =?utf-8?B?cjFvU0NQcUNnZFU5UUhTbTQ4MjZIZUQwUzhGam9Jb1JNWkJOVkZlYVBKcFVW?=
 =?utf-8?B?OFdnSlpNN0pqQnJ5TjVpMDdGQkdvNExFSXJwRFU1OUJEbWw5alNqOU96dDJM?=
 =?utf-8?B?c0Q1MlFCM3JDOUFqSkJtcENyY1ZwOHRReHpmdnpRM2FPcHhYbnFzU0lLQmpQ?=
 =?utf-8?B?VERESjBpbjVtZjgvNnRjZE9FVnJSWVNMYnlESFFjcjZGNFZiaTcrb1dOaUVp?=
 =?utf-8?B?Q3ZINWkxWTdGZzlpem5yWHM1T1BPSzhNREJDMzVINnZNSWxYblV6WDgxZVlt?=
 =?utf-8?B?MUlHRm1GRERXS0oxVGh6NWZlamVXWC9EeEo1NWtWTmhqM3ZmNHFsT0ZUSFBE?=
 =?utf-8?B?bkMxM1gzUEpEbWhFZTgvaG84OTdnbXRaTU4zaGhRV3VGaHB6Q1FZUForN2JP?=
 =?utf-8?B?TXZwbzNJenUyd2o3dTlMamtQK2tPYXBha2I2OElTTXhRc2RMYmxpclZPcWpp?=
 =?utf-8?B?eEl4elhjancxWFAxbnlwZk5ORkdUT1ZKOEtwNmR5NlZqUDJtTWtGMjNuNm0z?=
 =?utf-8?B?eTBaOU9tNHVEa3crZy9jZ0xORmMrQ2JLSnJhWHFnYkFvUFRBMldWVVB3ejFu?=
 =?utf-8?B?MVJtbVRUYlZpWVVCcUFDaDh2akhLVisvSjIyN2ZtVGZZR3ppeWVwL0N1azNr?=
 =?utf-8?B?MHhsaFZrSkFGZURlS1NvVlpxNTJTYjcyRDZQNDl2TmhiU3gyRWlZSE53QjJS?=
 =?utf-8?B?cGttWDMxeDdyRVd0UG5lZzhLeFQ4QlMvWW5nNU5sZm9Ib2JOZWNzemlaelFh?=
 =?utf-8?B?QXc4TnphNWRNNW90a0I1UHk4cXVYYVJSdFVTYWdDdStCODhWVXJlMEp6UVY0?=
 =?utf-8?B?K2xKZCtNVlFQMG15U3lTdDNCWk02ektCVUdiUG9NU0JMNDFZaWRBVjJOTlNL?=
 =?utf-8?B?RWkveUtIdXBJeE9MV09MRGR0ZDRRZ0d1VXFLbHBXT0dZR1pINGhOQUlnRzZq?=
 =?utf-8?B?NjFqZU1OUmpDeC92ZXBUcFk5ZnEwcTV5V1U3aEpWd0tmTloxcW10bjUybzZZ?=
 =?utf-8?B?ZG5nUjdDSU1ZYmQxUXdJSjl2Mnk3Q1RKTGp2RitqTUZZbExNejZRMzJLajJW?=
 =?utf-8?B?S3dxMmYxdDFCcjlsZ1RoV3hZUkNaRG54MmJPSjBXdVpUS2cwanc3ZzBnRkdo?=
 =?utf-8?B?R3NqSEgrd1MycVBEd21vRVoxUnNHYXdJVzgwMktvankzdGo3czdFL0xZbHJu?=
 =?utf-8?B?cjkwdFBkbERxQ2w0a01wR1Z6bFFTcVVaY3kzWE51V3VkRlF3cGpoQW1sUzk3?=
 =?utf-8?B?NlV6NGQ4V0FleStsUlg3cnRCS0lRZVBOR2djVVgxVHZxT3pVNVJwaDRRUWYx?=
 =?utf-8?B?WENWZWxrU1FlVGVmeG45YkQyd3FES0tWclIyVnFybzJCZFA0VTNYTVJtNWE1?=
 =?utf-8?B?Y0pnRjVGTjFvcEgxWWdpT1dQYndCeUxlamFSNFFhMzFKNDJnTkJ4b3pJZGtN?=
 =?utf-8?B?SVBQbmpmRlVJU3N3RjBTTk1yT1BROXR4cjVham1kdkxsVFJFUloycVJmME5W?=
 =?utf-8?B?UldJeVlhYzM4Y2RTQ2x4RmhBOHZiaGxHQXMvd29vdEdmeHdpM014VEMvUHpJ?=
 =?utf-8?B?c1FnU2duU2p5OTN6ZFE4SVZuVWwxUVkrWkFtSVg3UitPZkZLKzlqa2FYYXMx?=
 =?utf-8?B?RkdTa1BoQk5ESGJXdWxReGg3SzZKeWhNa2k3bDlDRS83SXpoQTZSaWdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJmTmpNV3VMZ2tTUm9LZjNTNlk5b2xTRjhtVXBsdzE3UXBnR2J0UWNPNW15?=
 =?utf-8?B?RUdRSzZHNGg2dHJ4N3E1L0VNUnhzRFFLQjZZWDB1VkhNbVhzdU5FTWhtemhJ?=
 =?utf-8?B?QjdwbFM5dnNPK0I4SjNTZjc2cEMrTlYrYkIvNUhXZDNqRE5FNHVkMUtiKzc0?=
 =?utf-8?B?bEhNUmQraVFXMkVIQWNPbjNuN0F1UXVUbnFOYnVPMTVzM2hKYTdFT2lsUGk0?=
 =?utf-8?B?VEl5c1hKZ0dwa29UQ2JZelVTbktVd0ZydUQxOFdWM1QxMmluV0pwMk9IemVy?=
 =?utf-8?B?Z1NxR01JbDdYY2htbE4vcEpWQ2xnTHRYVTRqQUJJUDNrNjJJMHFJUGFxQUta?=
 =?utf-8?B?Y29meFJ0QjhWSTRva2tLRE1MUlFqV29PN05kNTBRb1MyeEJaTktDT2lGcnlV?=
 =?utf-8?B?WVVwUUhCNDI4YmhpOWlmc0xkUVpGSktsTTJKbnJySFZHbHlsekdHM2x4azJr?=
 =?utf-8?B?bGNRY2lOOTlMOC9ud1hFQlZLSGQwdHozTHFsckNIT1hoVTAzaFZ2WUUwbGYr?=
 =?utf-8?B?bGF6V0R2SStJUDR2WnZsK2RSLzlXbEdTbWhjY1dWSWVZQ3IzSWZHLy92MzY2?=
 =?utf-8?B?QURGVFZkSVVtNFJ6SHREMDRFL0s1MnE2ai9mTFREd3BzUjNVSEJnVTl6MEEr?=
 =?utf-8?B?QXl4MW5QNkFLN3BqaU5Dd1lOdTRZbHlxcllGMHB1THBCZGNGUFpmc3JYNjRk?=
 =?utf-8?B?aTR4dUd6Tm81MGFDdk1RVTEwa2lRb2xRS1ZpNGdpb1VseGZ0dytjTHJXdnVS?=
 =?utf-8?B?Sm1ESGZqeTFYOGFvV0ZHdnlvNkMveitNeFlxTlBiajF1QlZvTE56RUw5TWdG?=
 =?utf-8?B?OEN6cDRmREFCZTg0bGo1RklGZjBQSFhPNlY1VGIrRVNFQ2ZjWWU5M1F4U1Rq?=
 =?utf-8?B?SERyV3Q5a0JlN0RITlQrVXpKVEdHNVM3akk4ZDhhcU5iaTI3TSt4a2ZucmV0?=
 =?utf-8?B?cDA5cVBVT3piV3ovSlV0cG1NSU1ybXJYdVU5S1JueDZXalF1ZGkwZEZvdjJj?=
 =?utf-8?B?dHhDcHJoUFI3SElQQytoNkorbmI4b2ZMR3YwU005Z0RlNG92a1pqYithTCtW?=
 =?utf-8?B?Z0ROUWc5VlZ2S1FHSEI1TjRVa0gvRzhQencyREZ1WGFDYksybVliZkFWbXk3?=
 =?utf-8?B?VkhJTFZ3RGF6cjNFeHp1M1c4MzZsdTF6dThYU2owUnkvMVdKdXZmSEd1eUNR?=
 =?utf-8?B?cHJzb29pZ2poSnJWT25SQ2dBZDlVc1VDcnduQjFIOXN5eWxGeE4xTVlXODBR?=
 =?utf-8?B?ZWh2YWtqOUxkSWk5TWF3SXJzejVVNDlXeXlIZTJhSXFYQVU5eU12VkgrUXlO?=
 =?utf-8?B?aFBKbDZtQXQ3dkphRUhGZUMreS9uaFczMzQzV0puZHVpeDVzcHNWMzlqd24v?=
 =?utf-8?B?UGVRZ1Z4VnovdEpoNk5Cc3ZXZXlacG00UzhMdUR2eDJZcXlvQU9yQVlXR3dC?=
 =?utf-8?B?MGowMU5CV3FHbmpIeHdlOTZyKzRtQUlOTU1NTXNHdmlTVTk0eXlHa3lUZ2tq?=
 =?utf-8?B?dGdzTGFnMjR1b2MvUU40clVxdHpNTnNoc1lmSm9RYUlBK1hFZG5jSEg3RFBX?=
 =?utf-8?B?aUNOQXZMblQya0Nva1NWRVhNazFMU0FFK2Y2TmdUSzVBWUZpeU1NMk1YWDlt?=
 =?utf-8?B?dEJDQTloUWdwN2NVdU1WdGRJVTdrUUt1cWVEMHNMaWxQMDBpQmVrMmRtTEJq?=
 =?utf-8?B?c3g5N3BqQ1oya1pCSUg1NjNOUXNOYjlFUXk1aW1RM3hJRGh2WE1yZXEzZTRp?=
 =?utf-8?B?eFcwRmV4eUhGYUpveCt6eEgxcVlRcjhNbEluSHN5Q3BvNk5rU3NnMmNBWXNm?=
 =?utf-8?B?SENLVXVZSmRUb1lWMG92ckU2clpxWTRXenl4L2hJR05GOVpwRzhOSVFlTTBF?=
 =?utf-8?B?R1hhR2J4MUx6bnBJWmdJaXRPUXdmZzVCa0tLeGh1TEpSV0dhWmt5NWFvV3gw?=
 =?utf-8?B?RUVPVWFCV2t4S25TV0lpd1FMZEdzTDNkL0dEZUNUWVFoanlVOEFTbTY4KzZY?=
 =?utf-8?B?NExpMk5BY1pZTHRTRmk4UjNaMWc5QWo5NGNLd2U1ZTZhbHhCZEhuU2poWE5O?=
 =?utf-8?B?V1ZETzVCZE1SNm9ZSGhRcXBBdG5NeWVHdWNHUGVFSFl2bDF3K2VKcnMrSWRE?=
 =?utf-8?Q?2CJpO/nMgHK/nZKEV7FrQbfu4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdc4785-e061-4a5c-c775-08dce852bb95
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:08:41.4610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRBs4ZP0MD73UQ/lUDDhOpFJ+pUq1Csf1xZgHDuo33C1QPOVr3PO9N4xQFr4OUKb801tOOvDle451q9ltPdrUQ==
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

--------------pSaWbHeAqaGG4s7TnDlxGh09
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/9/2024 1:35 AM, Alex Deucher wrote:
> It should be enabled on both bare metal and VFs.
>
> Fixes: e189be9b2e38 ("drm/amdgpu: Add enforce_isolation sysfs attribute")
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> Cc: Amber Lin<Amber.Lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2fe75c920a73..ae692d0591ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1625,11 +1625,9 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
> -		if (r)
> -			return r;
> -	}
> +	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
> +	if (r)
> +		return r;
>   
>   	r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
>   	if (r)
> @@ -1640,8 +1638,7 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>   
>   void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>   {
> -	if (!amdgpu_sriov_vf(adev))
> -		device_remove_file(adev->dev, &dev_attr_enforce_isolation);
> +	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
>   	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>   }
>   
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
--------------pSaWbHeAqaGG4s7TnDlxGh09
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/9/2024 1:35 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241008200542.3891752-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">It should be enabled on both bare metal and VFs.

Fixes: e189be9b2e38 (&quot;drm/amdgpu: Add enforce_isolation sysfs attribute&quot;)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
Cc: Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2fe75c920a73..ae692d0591ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1625,11 +1625,9 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		r = device_create_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
-		if (r)
-			return r;
-	}
+	r = device_create_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
+	if (r)
+		return r;
 
 	r = device_create_file(adev-&gt;dev, &amp;dev_attr_run_cleaner_shader);
 	if (r)
@@ -1640,8 +1638,7 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_sriov_vf(adev))
-		device_remove_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
+	device_remove_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
 	device_remove_file(adev-&gt;dev, &amp;dev_attr_run_cleaner_shader);
 }
 </pre>
    </blockquote>
    <span style="color: rgb(51, 51, 51); font-family: &quot;Source Code Pro&quot;, &quot;Courier New&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Reviewed-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></span>
    <blockquote type="cite" cite="mid:20241008200542.3891752-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------pSaWbHeAqaGG4s7TnDlxGh09--
