Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF29DC02199
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6591910E7D7;
	Wed,  5 Feb 2025 15:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m9WtW1j0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F8F10E1D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6u3OAgSao4/yeClvmc60bJL94VHZ9le4zYHANJ46OrLJtLdKEcHeQB6PZd8LyOAKkTi3e9NlAw1S6E2N4PGTsEpQlJM5pZTa+0VSdN/VgaFHhnbaMl09824qYZtk0+YFV2v5TYCO0gSKCHtt9z83EnWYp53XbaRjb4gX7fHR753IygjaOVMr7lvaLT7q6CBuX+z1tlOVLChBxKIUoRSFNBHKcIwxZUlxHjY5SF2fMLmDzoT+QeG3lw+Nz4M8AhgTRZH1/9z0ng52jvUNZ3lJTJxQ2g2JG5pFblrUA3gpZi5IVbQZrzJoPjwg2UBJ3oIqitjCc9655rYVHfb1EmQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJqwxOpAKJ6bu30Lpd9Hnr9IIHrolIjLSYQp8pr5DOU=;
 b=n2lsbYx/4ry4t/3BqsMM4wBRJdZAt8pa1DOcSiT2v3l0jpxdd1VWt0k6JvW0dD7BO7DbrkZruSsizZwYxT0/1Y7Ye9+rjuEc1IbORYasKEGh/olPYC7WnTJSgsoxrJ7E7PT/ZEyVhRwJ2CmwYRkrUI3xh9scxAw6NSbDpf6yVKitDApr4MF0Ixj2xalxqDt0ItyJ3HF3KNEfQVBiRJlzh2WdAxVnMnUMRaIYfQrQ+5uE+wu0WaK3FTeqanZEj1yHV0KF9PLuPb2qHEb7BtD1SG0v2sveDPM6OhEivbPPIHEsFLmlUcYKL0Jc8TX/4K3QnPSTbqj+24INGBe8s3Ovrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJqwxOpAKJ6bu30Lpd9Hnr9IIHrolIjLSYQp8pr5DOU=;
 b=m9WtW1j0taAV+Br8u6M7DWc9grgeI0/sSwZCF747/Y8BAwec11h7Y3FcYCVRWG1EZh3x0Izhn4YWViN//dIgvsFccVABCH+Tb3BdKIkY5K/YIJAk6QvjNOD/asqi1mak7loPevgbGIvgbZCI0Kjia43vwseO2vovgAMDRoaF3gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:03:02 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:03:02 +0000
Content-Type: multipart/alternative;
 boundary="------------dqEV6yDsJ5d2n50vDiLH20kt"
Message-ID: <844bb7b6-4fc2-4057-995c-7133a599816e@amd.com>
Date: Wed, 5 Feb 2025 10:03:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/44] drm/amdgpu/vcn4.0: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-17-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-17-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::10) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 255a2804-7369-4ea1-3965-08dd45f62fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2pTL25ZeVJpcUhZOUJveUVDTyt5R1V0VUlCcVhidjBhVjJyMzJwMWVUbmcx?=
 =?utf-8?B?alBoNVp4ckhheG9uY1NGSytWdno0OG1TMmw3MkpXMU1RQTdMVk5wQ2RCMGVx?=
 =?utf-8?B?cGJYZWlCRFdKcW92UWtlTVdxSGJvWWdMR2FhZnVtQmNRY0xHNDJwUVQ0VjBo?=
 =?utf-8?B?YjFKS2RISy8xdXRWZVZRMkRXWVB1NEtRR0RobHUzcHovQnJSTTdMUXRWdkVQ?=
 =?utf-8?B?T0F6L2FadmFQUTY4Z2kzN3VUYWkyanY5Q1JhMFVmalMvTmh1NENLTDFiclli?=
 =?utf-8?B?R2xnV2xDanIvZlNnYzNxb0FjeE5sdVZjMnRSelFOaGFLVUxaWHdmUm9meGFV?=
 =?utf-8?B?V09qR0FsVjh0ZDJtdkJIS2kwbUFOMWlPMFV5alY1Nm9Xa3JSU3pPZHcvNEhS?=
 =?utf-8?B?eGo2dWxndnd4MVA1bTdFcTNuRjlMVjVHaDJac0x3NlV2SlBIWXdTQ1hBeWsr?=
 =?utf-8?B?emVtY09NbWV0RU5SckZYNm15bldHZG5lcDc0L3FsbFdmNGU4RnJUaDJYM04v?=
 =?utf-8?B?cU92cENFZVVoNndNVVI3Ymx6c3JweFhJUDBkMzViODZQd0VQMVNvSmU1VHky?=
 =?utf-8?B?REZTRjJGRHhNVzAvN3BBQkUwWklJV3ZwMjFNT0xIOFdETlZFYzUyWUdQbmxC?=
 =?utf-8?B?VUtKVWh2SXVtWHNnem1YWDVHMFE3YUIzWGhZeVpzaWJkbXVMckFiSGYwVGlt?=
 =?utf-8?B?cklZSVVPdFFJMWZZQStZWHZZMmI3R3RKWWZMYmQrcFJHR2haMzY4cDFuQ1Vj?=
 =?utf-8?B?NWNyWm1MMlpldWZKMCtLeEJmcW8xZDlUVG8wbXp6UDI1VG0zTW9RVjBKMFk4?=
 =?utf-8?B?Y3lLRng5Mkt1a3l1SzgxemhrUTNZaTVPazEvcDcyd0l1dFg2R0pUMm15d0Q4?=
 =?utf-8?B?dFgvVmFhQ0NxMU12UUlobnU4Z3BhQUVCRk1vOTcvT0pEMFBpVGQrNG9kSEI3?=
 =?utf-8?B?bVNPY2x5UjVaSXVtNTlUcG1GSXJPbWU0bHVza3MyRGwxSDE5ck5xY0k2dlli?=
 =?utf-8?B?byt3bjdJOFk0Rlo2N01FVGk1emV4eVZEbzgyeEZablhJYzdYNHJOWkRRNW5F?=
 =?utf-8?B?NFZWR1YrNE1lWXYrM3U3SzB4ZTZPVXBZUi9jL0JrWnQ4bEFobkdoSTdkWVVn?=
 =?utf-8?B?UEd2Y3h3OGU3cEhFQ1ZSVUtTWjJZVXZVbGxuVCs2ckhoTEJmcGdIaHJQUml5?=
 =?utf-8?B?WnBlVXNzVGIxaEJoMEVMb3hSaVlLTTJtelAxb3U2MzR1U0RiUGxOUCtXS0hl?=
 =?utf-8?B?NUp1VEo5b0RSZ2lGR3N6YkUraHh5dzlETXYzUnFVK3BWQkhSSWx5NW82T3pi?=
 =?utf-8?B?V2lOL3ZwU2NmY1pMS2grQkx2anY0UzZITHNacm5VWWw3RTJDYVRxZ1k1QkJY?=
 =?utf-8?B?MjdSNG16d1RHUnpPWTJSSUY4TVVNUVdWMmhiZytrTHZ6VWRQbDRuSGhJSzZV?=
 =?utf-8?B?SUtvalh6ekNNTjJJT1lXcG5DLzhnK0ZHTkczblpQdTlkOXNpaGtBU1FHM1cx?=
 =?utf-8?B?QjBXRmFVaFltRVA0N2RwWVFnWVpyVGRWWHF1dmREeDlHVXU3SnpoYVRXTG9t?=
 =?utf-8?B?TTRhbHJDbnZpNjE4UWk1VXNlQWx5bEVCUVU5QmtBOHJ6ejRpdDBUSitoR1lT?=
 =?utf-8?B?bjhMWjhuamRnSEhHNjBGd24yRUxDbnJsTGpRbS9TSmlUc2RJbTdnVS9yaFJl?=
 =?utf-8?B?N1V6VDFHUHJhU3pwNEpCYUErRitkb0diU0NBdmkzZTcrcUNLS3FnZkg0Sm0r?=
 =?utf-8?B?Q0JLd01XVlVibFVlbnpGZmV6TGttOFV1Qk13SkRtM0ZzUHorLzN5aGRzb0N5?=
 =?utf-8?B?dFY2ZUdzOHoyWWdHV2lOeHRybzRSUFh0MTFSckNMdDh2N095NENpS1p5Rndw?=
 =?utf-8?Q?9IlxYTaifKWao?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJNTDJMK1hMTGU4N0V4Yjc0K3pwSnpnTTcyT1BFQUFud2JFazFmcWNXSHNy?=
 =?utf-8?B?aEJkS0lDQXg2OXRRT01QdTVIZVNrQzlCVE5lTFR1Wk5YQk01YThOemczRlI2?=
 =?utf-8?B?YXQxMWEwUlZHOWIrNmZDMThiSFpwT1BMUXR5Mm1sdkJNbXZwYXlwTkloUVZq?=
 =?utf-8?B?SGU0RmRLRlFwMGFwZU0vcGlWMkxPTjJRWUpnUG5Lekw4NUtHOFR4TVRnYkNa?=
 =?utf-8?B?dGJxNGZiRWwyZ09RNDk3STlOYWpWVlRNckpWY0FweE8zLzRQd21GQWFpWEl1?=
 =?utf-8?B?T1MzOXBweGMwZDh1RisvQnlkZms0Mk45eXJ6d05RSG9YRzQ4ZFBSK3REckxj?=
 =?utf-8?B?S1BOc2EzQ0lJZHUwTnI3Ti9tMTNpaU8rZ09SVE1OWTljb090QVNZSFIwcXcv?=
 =?utf-8?B?b1pSVi9VSHgzb3ZvcUJVNEo4K2NGUWJaSzdYOWwydFYyK1pGeElNdU5yR3I5?=
 =?utf-8?B?VHBSZ2hzOW80cUlvUmRFTEZFY0tBSmZuUTBGT1pRNzlsK2lMWk83clZDa1pj?=
 =?utf-8?B?R291Z0hQSndlTk4yZXU4TVZWZXdoK1hWV0ludDZ1NWd6azJIeXROek0vcmdL?=
 =?utf-8?B?dnpxNXhPUlU2R3RtdnJRb01qWlFZemtLM1VUL2c5K29tWjVNNmU5YlBkL2FI?=
 =?utf-8?B?aGV6OVZZc3JpQXhUQ0ovRy94T0J0QW55Z3pmd0NOZC9OMjJPbVFpem5rSTUy?=
 =?utf-8?B?d2EyZW5WOURJNzNFZTJGN3pHSFU0UXVXQURHMlNXeENFNDNMOVZocS9wVTVU?=
 =?utf-8?B?SlEvVlJ0RjFObjRGc3kvb3dCNDUya2VsRkQ3MmsxNHRaRnBlT1RKaHZibVJi?=
 =?utf-8?B?Qk5CSlVhUlN6QTBpQjFLQkZEam1nc2lMWWFiOFN0a0NJSlBUR3NSVkNYRXky?=
 =?utf-8?B?WVltSEdCMWN5Zm1zZ1dkUll1azI0ZzFyUmk1Z0dxRGlPczZLRVJ2eWtGK0dF?=
 =?utf-8?B?VjExMTF4NmRhY2t4SkYyWk1vL2FyTVNQWHAxSzU2bTVWRWJtOTRvWGM4NHIv?=
 =?utf-8?B?NkFxcEMvYmU4aUZ0SkdvTEx5NFcwNnFCb2Z5UnBQTFUyMHRISzBBZkVseTNq?=
 =?utf-8?B?Zjd4V2lrWFVuWHdSYmRRYktaamRuYi8xcmlMY0hGL2RQSjJWendZQktmZnk1?=
 =?utf-8?B?OCtSOG42KzV6LzhFcnFIbUw1Tm5ZMjB5eXhoSGJhQTVYRC8wbmZlOXBGeUpq?=
 =?utf-8?B?YW4vaXUyRUp1NHJ5ZmdIYmZRY0JWR0F5TjkyRm5RQ1FKVlUwNk96K2wwZlRt?=
 =?utf-8?B?bHk5VDVmaG13MlpXdHo2TjF6dEpZaEc3TXdvT3I5VFNOZXRvekVHNVU5VlYy?=
 =?utf-8?B?L3FiclRKcGpQTTdlcTJPMFdKZWx6cEtFTy9wNHBtK0p4TDh2VnRxb2ZOSXJJ?=
 =?utf-8?B?MDZ6Q0YrYmVWWUx0M2lsU1VtZnN1TXhxOWRRVEJ0QU1WZTBlOEZoTHY0c3px?=
 =?utf-8?B?WDBJaXZCcDNPY0cyUTJRMjkxbTVZOFpVaVoycWFOTzVtUU9KWGR6QXJGVUdr?=
 =?utf-8?B?UllKVTc2K1Qxd0o4RzBpRmRRWk9tbnJLT3IzTDR3aWk4bllUVi9ZQ0ZvbWt6?=
 =?utf-8?B?M3J0TmdNak1zeGlUVkVGcHV5L3JZeWMwSTFRemhnSW53NC8wSHRiU002NlJR?=
 =?utf-8?B?R1hZUVZGMU9DK0RYK0gyVXN6ajJjRVRpeDZWUFZLckNLQVc4TXlIdlc4aHA3?=
 =?utf-8?B?NS9PYlBWemh5em8vVzArNFlVeXVGTmx1MkpqS1NkYVB6U0xRaFRqUUoxUlZP?=
 =?utf-8?B?djhYYk5mcmViYU9lczQvbkRLYjNqbEVpR1JoN1FTdDl6SjRkT052eGZXelFP?=
 =?utf-8?B?S1l5bWFIZm40YTg3dW1icG5FSE5CM1liclBJbnlZem1qcHdFUHJSNC9rcjJM?=
 =?utf-8?B?NVVpMlREbVg4UE9oUjBQb09jMkFWZURac0doRFI3SUZGS2lEbUpDRWZvOXRF?=
 =?utf-8?B?NXpPSXhNMlNmTnFLcU4wMmZEYTlNTGJEbC9kZTJqcElsanlsaGhhY2dGbXp0?=
 =?utf-8?B?VDRrOG9xM29OZys5TURRbm16NktxNDNrU2xPSklKMTdSRWVPeEU0b1ZLOFpF?=
 =?utf-8?B?OVB5Z2lXNDBaclFhUkZjbVdscDVNWGJTcDZ5WHV1VDBGbDBJTTlwUzREd2RN?=
 =?utf-8?Q?UFzoGdjW3g9geqT9iYbyXpTYx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255a2804-7369-4ea1-3965-08dd45f62fe9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:03:02.6397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWF42E4Ds9XBGo1B/02XyMtu+TNkJfedK3bSiyJodHDXhrT5olTySUgDxTArilex/xUveR7DG98QFFhJkzSzrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

--------------dqEV6yDsJ5d2n50vDiLH20kt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 116 +++++++++++++++-----------
>   1 file changed, 67 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 1200815b3eee8..3d70e2cc81982 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -449,13 +449,14 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_mc_resume - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   
> @@ -509,14 +510,16 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
>   /**
>    * vcn_v4_0_mc_resume_dpg_mode - memory controller programming for dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Let the VCN memory controller know it's offsets with dpg mode
>    */
> -static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
> @@ -616,13 +619,14 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   /**
>    * vcn_v4_0_disable_static_power_gating - disable VCN static power gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Disable static power gating for VCN block
>    */
> -static void vcn_v4_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data = 0;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -681,13 +685,14 @@ static void vcn_v4_0_disable_static_power_gating(struct amdgpu_device *adev, int
>   /**
>    * vcn_v4_0_enable_static_power_gating - enable VCN static power gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Enable static power gating for VCN block
>    */
> -static void vcn_v4_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -736,13 +741,14 @@ static void vcn_v4_0_enable_static_power_gating(struct amdgpu_device *adev, int
>   /**
>    * vcn_v4_0_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v4_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -847,16 +853,18 @@ static void vcn_v4_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
>   /**
>    * vcn_v4_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    * @sram_sel: sram select
> - * @inst_idx: instance number index
>    * @indirect: indirectly write sram
>    *
>    * Disable clock gating for VCN block with dpg mode
>    */
> -static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
> -      int inst_idx, uint8_t indirect)
> +static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +						   uint8_t sram_sel,
> +						   uint8_t indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -904,13 +912,14 @@ static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, u
>   /**
>    * vcn_v4_0_enable_clock_gating - enable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -960,9 +969,11 @@ static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
>   	WREG32_SOC15(VCN, inst, regUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
> +static void vcn_v4_0_enable_ras(struct amdgpu_vcn_inst *vinst,
>   				bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t tmp;
>   
>   	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> @@ -985,14 +996,15 @@ static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
>   /**
>    * vcn_v4_0_start_dpg_mode - VCN start with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Start VCN block with dpg mode
>    */
> -static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> @@ -1010,7 +1022,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
>   
>   	/* enable clock gating */
> -	vcn_v4_0_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
> +	vcn_v4_0_disable_clock_gating_dpg_mode(vinst, 0, indirect);
>   
>   	/* enable VCPU clock */
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -1058,7 +1070,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
>   
> -	vcn_v4_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
> +	vcn_v4_0_mc_resume_dpg_mode(vinst, indirect);
>   
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
> @@ -1070,7 +1082,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
>   		VCN, inst_idx, regUVD_LMI_CTRL2), tmp, 0, indirect);
>   
> -	vcn_v4_0_enable_ras(adev, inst_idx, indirect);
> +	vcn_v4_0_enable_ras(vinst, indirect);
>   
>   	/* enable master interrupt */
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
> @@ -1114,13 +1126,14 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   /**
>    * vcn_v4_0_start - VCN start
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to start
> + * @vinst: VCN instance
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
> +static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> @@ -1135,17 +1148,17 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
> +		return vcn_v4_0_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable VCN power gating */
> -	vcn_v4_0_disable_static_power_gating(adev, i);
> +	vcn_v4_0_disable_static_power_gating(vinst);
>   
>   	/* set VCN status busy */
>   	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>   	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
>   
>   	/*SW clock gating */
> -	vcn_v4_0_disable_clock_gating(adev, i);
> +	vcn_v4_0_disable_clock_gating(vinst);
>   
>   	/* enable VCPU clock */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> @@ -1198,7 +1211,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
>   		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>   
> -	vcn_v4_0_mc_resume(adev, i);
> +	vcn_v4_0_mc_resume(vinst);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> @@ -1541,13 +1554,14 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
>   /**
>    * vcn_v4_0_stop_dpg_mode - VCN stop with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    *
>    * Stop VCN block with dpg mode
>    */
> -static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> @@ -1571,13 +1585,14 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   /**
>    * vcn_v4_0_stop - VCN stop
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to stop
> + * @vinst: VCN instance
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
> +static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
>   	int r = 0;
> @@ -1589,7 +1604,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
>   	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v4_0_stop_dpg_mode(adev, i);
> +		vcn_v4_0_stop_dpg_mode(vinst);
>   		return 0;
>   	}
>   
> @@ -1642,10 +1657,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
>   
>   	/* apply HW clock gating */
> -	vcn_v4_0_enable_clock_gating(adev, i);
> +	vcn_v4_0_enable_clock_gating(vinst);
>   
>   	/* enable VCN power gating */
> -	vcn_v4_0_enable_static_power_gating(adev, i);
> +	vcn_v4_0_enable_static_power_gating(vinst);
>   
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_vcn(adev, false, i);
> @@ -2044,15 +2059,17 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	int i;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
> +
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
>   		if (enable) {
>   			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
>   				return -EBUSY;
> -			vcn_v4_0_enable_clock_gating(adev, i);
> +			vcn_v4_0_enable_clock_gating(vinst);
>   		} else {
> -			vcn_v4_0_disable_clock_gating(adev, i);
> +			vcn_v4_0_disable_clock_gating(vinst);
>   		}
>   	}
>   
> @@ -2064,6 +2081,7 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   					       int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   	int ret = 0;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> @@ -2079,9 +2097,9 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_stop(adev, i);
> +		ret = vcn_v4_0_stop(vinst);
>   	else
> -		ret = vcn_v4_0_start(adev, i);
> +		ret = vcn_v4_0_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[i].cur_state = state;
--------------dqEV6yDsJ5d2n50vDiLH20kt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-17-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-17-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 116 +++++++++++++++-----------
 1 file changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1200815b3eee8..3d70e2cc81982 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -449,13 +449,14 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -509,14 +510,16 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 	hdr = (const struct common_firmware_header *)adev-&gt;vcn.inst[inst_idx].fw-&gt;data;
@@ -616,13 +619,14 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 /**
  * vcn_v4_0_disable_static_power_gating - disable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable static power gating for VCN block
  */
-static void vcn_v4_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data = 0;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -681,13 +685,14 @@ static void vcn_v4_0_disable_static_power_gating(struct amdgpu_device *adev, int
 /**
  * vcn_v4_0_enable_static_power_gating - enable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable static power gating for VCN block
  */
-static void vcn_v4_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -736,13 +741,14 @@ static void vcn_v4_0_enable_static_power_gating(struct amdgpu_device *adev, int
 /**
  * vcn_v4_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v4_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
@@ -847,16 +853,18 @@ static void vcn_v4_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-      int inst_idx, uint8_t indirect)
+static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						   uint8_t sram_sel,
+						   uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 
 	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
@@ -904,13 +912,14 @@ static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, u
 /**
  * vcn_v4_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
@@ -960,9 +969,11 @@ static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, regUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
+static void vcn_v4_0_enable_ras(struct amdgpu_vcn_inst *vinst,
 				bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t tmp;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -985,14 +996,15 @@ static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
 /**
  * vcn_v4_0_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -1010,7 +1022,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev-&gt;vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev-&gt;vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v4_0_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v4_0_disable_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1058,7 +1070,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v4_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v4_0_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -1070,7 +1082,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_LMI_CTRL2), tmp, 0, indirect);
 
-	vcn_v4_0_enable_ras(adev, inst_idx, indirect);
+	vcn_v4_0_enable_ras(vinst, indirect);
 
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
@@ -1114,13 +1126,14 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 /**
  * vcn_v4_0_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -1135,17 +1148,17 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_start_dpg_mode(adev, i, adev-&gt;vcn.inst[i].indirect_sram);
+		return vcn_v4_0_start_dpg_mode(vinst, adev-&gt;vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v4_0_disable_static_power_gating(adev, i);
+	vcn_v4_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
 
 	/*SW clock gating */
-	vcn_v4_0_disable_clock_gating(adev, i);
+	vcn_v4_0_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
@@ -1198,7 +1211,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
 		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v4_0_mc_resume(adev, i);
+	vcn_v4_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
@@ -1541,13 +1554,14 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 /**
  * vcn_v4_0_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -1571,13 +1585,14 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
@@ -1589,7 +1604,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
 	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v4_0_stop_dpg_mode(adev, i);
+		vcn_v4_0_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1642,10 +1657,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v4_0_enable_clock_gating(adev, i);
+	vcn_v4_0_enable_clock_gating(vinst);
 
 	/* enable VCN power gating */
-	vcn_v4_0_enable_static_power_gating(adev, i);
+	vcn_v4_0_enable_static_power_gating(vinst);
 
 	if (adev-&gt;pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -2044,15 +2059,17 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
+
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v4_0_enable_clock_gating(adev, i);
+			vcn_v4_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v4_0_disable_clock_gating(adev, i);
+			vcn_v4_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -2064,6 +2081,7 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2079,9 +2097,9 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_stop(adev, i);
+		ret = vcn_v4_0_stop(vinst);
 	else
-		ret = vcn_v4_0_start(adev, i);
+		ret = vcn_v4_0_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[i].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------dqEV6yDsJ5d2n50vDiLH20kt--
