Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DEBC36014
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 10:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0253110E271;
	Tue,  1 Apr 2025 10:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jckLZdmE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C63C10E271
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 10:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9lDWby0lsjzdxz9GqCfaBHvmEqhyWRgnDM49H4QYf/nuaeB9/BLiraqvguINPXa1arK+nI8EirOB8aF3MNKa7THlxF3R1w96cQsMV1/fn+cOF93ef7hMFX8uCCYBZRPr/91Z4534JPbSGlgdyKGRHc3ll6EsLf+Xdf/buN737sQe7qn2pAty7gA23gWOO/ta4/ULfDxjAj3GA5gU71ETGV0nUiNEVxl5FcdJVHQfizpRBZ/Z4C2T3maG8p34BIOZOtTTDHNupLoQyy0nxfxpRikssDlNIfOIHJp11w2oIWsylT6lOWsL4o4VGJNz5l5QhH732g01tgLzUUP3K6qDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDihMorRGitFX6WrQ7tyDlTxEY7WMJKMXP2tBUQtfvI=;
 b=vv+YubqiyZ25dXdIKZMwdQn5Ivj0jwMlR4NeBG0X3IWwnF2lgq3yx+xQX7b7whoCcuq2tMf3NHmU7ptHsYglFL+2SqevMtN0htPrZHnXIMDHvxJzub1tWrRKm7P+tLSPvUBdBDsVlKEgq0lJEuMkJ3rltcsbrN+F7SKynE0IABZ3XbcyX2sm63J5Vo6rFT0T749ZRsSjVkJ6oFBAB8cq23X4ho7GYQeH+SeyN/NaWouapJLa6IOklO1/2nM28QpYs8uA0bVo6q1UeHTMXJHPMZe0QDbL8jZzU+0QB4w+/OA9+jWdgFY7IGvevdZ9tz64r+8UmFKHZzj/ba6jAIUHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDihMorRGitFX6WrQ7tyDlTxEY7WMJKMXP2tBUQtfvI=;
 b=jckLZdmEc52/pIVuYeKznV4amEhLSb1bHA1PwUWOPK0hgNyLyeZ3dUXEbXuKegiRQInExnK4gq3kpq76N9c2YR9glvWRryVoduIDqVDhR1QQKNqj5CK+7+cSeqa5qgfXwETILNJLNprZnJylNIo//yCEMmr6XRzRLJIwi/DlqIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 10:50:26 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 10:50:26 +0000
Message-ID: <af699f76-bcf0-4cbe-a308-97188b809e64@amd.com>
Date: Tue, 1 Apr 2025 16:20:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: revert "always sync the GFX pipe on ctx
 switch"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250331130152.2342-1-christian.koenig@amd.com>
 <20250331130152.2342-2-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250331130152.2342-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4897b5-fe5e-474d-4ea9-08dd710b02c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXJkUDNMdGhSb2J5bUUwQWt2NFlzWEsvWVk2M3dJd29GdjhKN3NmL2tnamxp?=
 =?utf-8?B?bkRvSHp6THRpVGZ0YTNhYUxmY3NURUdFSElRUEt1aHd5VkVrQlFJY0tkbEkr?=
 =?utf-8?B?TldaQTF2d251MnlsblI5bHh3RXhyWEkxeVphbVVoVFdvaDJkUE1IVGZKZlZH?=
 =?utf-8?B?a3NSWU1DVFozbjQzZUxZSFFqbnRkVVEwL0d0WjFhQy8vKzBsMUY0ZFFZdXh5?=
 =?utf-8?B?c21vMnlCQXZ6azZsME9KUG9EcENWc2Urc0NiZS9XSWFEeFFiWkVxYlRqcDBy?=
 =?utf-8?B?WUs3aUNYVGJmbWZQMDhWc2N0dHhnNHY2TzBmTm9Cb3dUdS96TWFpVElFT2Rz?=
 =?utf-8?B?NEZNZlJnS0ZkMXZ2d3lKOVRTVHpBQ290V1VTS1h0b1lVNHpIemlVUHJGaDlD?=
 =?utf-8?B?M2t5R2pDaktrVmc2Wll3TkxZZlZTeDNSb0Eza0NhNnRmM29BV2x0Y0VkcmhV?=
 =?utf-8?B?QTVYaVdrV2NtMVZ6Z3NHcTNNOTc5ckVLSXFkNDRqYUZkVDBkR1BJdEsxZEdF?=
 =?utf-8?B?c0lza0ZIZU5YamdDU1R2eFRZQjdPMytXaGV4bWVvQ0xxcFhuTlJzNkFGMlZt?=
 =?utf-8?B?d0YvU0ExL1pFSlg1TllKZlUzekhremZKdklIVUhYd3pLWERyaHkyUFQ2NExt?=
 =?utf-8?B?ZThPSzhoSDF5SWttcnRITlhRa0o0Uis2QjBFd214UXJsaVQ2Q05US3JHTFkx?=
 =?utf-8?B?YVZRZFVNN3JsSUMzOHZ1Mi9kc2x3V1RYY2I0anNkQkRra0NsWEM0K3A0MUYz?=
 =?utf-8?B?UGdYQVcwcUVRYVFvYTFtdUYrdmhkTGNGSTR1N25tQVlrdUs1Nm93dlNCdTll?=
 =?utf-8?B?QnhzS1J5QVdxb0o1SmljR3ljUnhUajRoc21SdU5UOGloai9zYktweGhkNHRV?=
 =?utf-8?B?ZDFYanpLdGNuWVJGcVZIcEhzTkZDYVZhT29WV2xxdjJWZFdMTHE2UENzSFBZ?=
 =?utf-8?B?K2VjelhYaGw4dk1qZEViQkJnUWdDcytVSXpxZ0prZzFhZE5KbEY3QjBCbVZk?=
 =?utf-8?B?ZVBLeFVZZ21yemZLQmc5VjZZNVdqeWZtY2haTSs4TzNuYW14b0xaU096YmhB?=
 =?utf-8?B?Y21DcnQwaW4xODRFMjNhdi9OMWJNam5DQ1lJWGt1U29OS1RLZ3Bmay9PY05X?=
 =?utf-8?B?c0dRNzd6QWRnSVNrczFmaHYyRmJvcEdHdUtZM3YrL3MrVXpLNmZET05XL2E3?=
 =?utf-8?B?dk5LdlpQalQyK3Nab0RhUStid0RVaEE3QVM5RmlqMnlkcllwSHhwbFc2N2NH?=
 =?utf-8?B?TzUyWXVCTWRwdjFWRjZRa0ZOeXdYZW9oWHJFUzgzMHJZYUVndktKVjE0bTk4?=
 =?utf-8?B?UVE5RjFYcFUvTmw2UmFieHlJbkxESjIwV3hKOVJjRkhReXlIS00zRzlFbzBw?=
 =?utf-8?B?aDd2ZUxDOUR3aUR3anV3OVNkdmE3TjhYMldsa084cHQ2WmRPMHAxbHBkL1Z0?=
 =?utf-8?B?a095WjZteTYyeHZQSTBuenFNRVRSQnBFNDJiVDJvQXJGWUJsQU1qbU1COEFw?=
 =?utf-8?B?QSs1RkFPbk9PWlRiYkpteDVKTHhQZ1ZNTmh2MVN2ZVFlVnU2bGVPV1Z4TFJS?=
 =?utf-8?B?OGVyMFo3K2k5M1k2azAvMXQrSFg2cXNIU0M5dmpoMUN2YXROeitLRkJHc2tU?=
 =?utf-8?B?WlV3Z2RFSVhEaFhOWFdTWnFEUWZVajZLZnc5dW5KcXQzd0NCaVJlbjJUV295?=
 =?utf-8?B?ek0yR2ZJZnJNaFBMTDA3TEhiYlNiNEFybjJPN05oNGhLZ1RtdjZJcjQxUE9Z?=
 =?utf-8?B?U3hZcjQ3NVRkMXVGRVpGWXgzYWw5QVdsK3IwZk5MZFAxWGl2aVFkZjR6OE1X?=
 =?utf-8?B?dFNSeW90Rlc5YTg4UkpVMk1QSys5aFVSekNkWFo3K2hXUk9GckZDc2lQWjBS?=
 =?utf-8?B?VllMeTdPa3MyYXZaTElnclVXUlhtblRaaitYcTViMm4rdk9VSmNXaDJ2Z2tp?=
 =?utf-8?Q?gRkkeLJujqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhvYi9hM3RMU2FyUGVnMndsY3pWK2FOY0Y4MlpPcTl2NTg4cElzS3Vxbkox?=
 =?utf-8?B?UnQ5T01ycXFicEo4Y1FUSWpSQ09TWmd4RytlUTI5NUFGaVhWOG1YWUJITEFs?=
 =?utf-8?B?MVFKbXVGZVdaUGFZM01wNGMyMTZRT283TWRodnA2QnI2djVFbmp4WUFZME1T?=
 =?utf-8?B?cHc5emFDYTN1cUJveFJITjZYT1ZzYkVpN0lGa2NWcFpldmFEMG01WkdTL1dt?=
 =?utf-8?B?bWxmaWc4WWtFOEl1N1dDV25BTHMxY0pDM2RXTnZJTk5oVkZoTDQ5SUt4cjRU?=
 =?utf-8?B?SnFaMVBNbDhULzdxb2p4eTk2bTBqU24vY3JMbW5ycTNNcVc1WE1Ub2tDYzRM?=
 =?utf-8?B?YmxDLzMzQ0NNY2V3Qm9jbU5aVlZiWEFYLzZtbks4WHkvY1p5L2d3Nkl1ZndL?=
 =?utf-8?B?OTdiSlUvK1ZkOWVrc1lzYWRwVU05QzBWbzVjMm5XaG9TbDh6L0NxSXQrbHU2?=
 =?utf-8?B?Ky9pZExzQWFJVXREZm4veENhVjhOZlkvMmJkVWlDL0IxOWVGaDBnSUdxQ25O?=
 =?utf-8?B?TDN4cEhKWWVTSUl6dkU0Rk1KTGluS1B4NzllME9CZzlWR0ViTVZxRktOMjVQ?=
 =?utf-8?B?TXNlRGE3ajVyM3Q4azJEQ2wvWDVSVWhSS2tqdDhYTnlBajBKdHFPS0t3cEds?=
 =?utf-8?B?anhzekk1OVFBWjNkdmhuU3Y3a3Fxd3ZEdXZqdHczeURieHN2U1hwRjh0SURL?=
 =?utf-8?B?MjNoS2VoOXRML2NZZWRIclFQZ0haNmpEek5KdGV2TmhLTy84ZzdPSUEzeFpQ?=
 =?utf-8?B?a1U4RVVrMXI5SSsyU3kzQ05kWWhxdTBTak1NSU9LYTd1VWsvcHlPdjVFSDdZ?=
 =?utf-8?B?eWQxelA5ZFJHWHRYb0xZMGVVZDF4MGc3Qk5IcGtyd1BZWnNTdFNrQTFqWUxC?=
 =?utf-8?B?RThWQmZJWm5oai9nNGRmSlpyRHhpSjJmTGhxclpwdGdZQ3Z5dUovSUdvODNL?=
 =?utf-8?B?Q056NVpiczQzbG9NWVFGejBsMlE4ZFVyY1MxVjdKMkYwejBjRlJaOUdQbndX?=
 =?utf-8?B?eTZ0UzZYdTlvSmFnSHF1THAyTHBER0NtcnRoTkx3eE0rN296YnVzRzJKNWJG?=
 =?utf-8?B?RFpCU3h4L2hMaXNFV2ZwM2UraGF6eWlubmZHVzhCWUlUSW12NG9SWnh6R3pp?=
 =?utf-8?B?amxUZ1NuUmltNFB0VlM0MTBGZktTL1MrVFhWZHlQVEFtYWVMMFYzbENNTEkv?=
 =?utf-8?B?dHMvMXVGZG9OS01pYksxcnVFTUhBcDFIK3pYOHh3NkNnOFNrcU9tYnJ6WVQy?=
 =?utf-8?B?eGpBTFgrbGVtekRJclFsTVZpMTAvOURuZWxVZ3JFOUVxOFZMT3Q5VE5YMHlG?=
 =?utf-8?B?RFZCWlBBT1Y1Ny9PU3BabkwrcUFPdUJGVWNSK1hmY05XWGYxRkIwTmdNOUVZ?=
 =?utf-8?B?WlR4Zy95aGhnRWJZYnRLUHFJckJobVlLckpmTnRwUVpVUUl1OFpqd2FKTThP?=
 =?utf-8?B?MDROVE5iUjExK2VNNWFTU2hXOERYN2gyN2ZNVmVrTU82VUlrSjhtWS9SRWFq?=
 =?utf-8?B?ZlJGcVhmbDVrN1pMdWtoTmR5ME9OZ1dQQTFyZ0p0V0d4RnU2VTkwYjB5WGw4?=
 =?utf-8?B?ZXVaMWpzR2NJS2tuR2dSNWFrNWZ2SGtEeUZCWUV2RWhTeHdJbWdSYndLeG82?=
 =?utf-8?B?a2FFUnExQ1ladWI3ZFNxTFFINmY0a2k0cTA4ckZYZDh5ZytPOER5Q2RySXF2?=
 =?utf-8?B?d0c0NkpValp2UlNZVGtITUdQU1Z3TTYrdXlBN3Fic3NtdUM3TXRGNFNielR5?=
 =?utf-8?B?Q3R6WDhiRks2TWhuMkFnRlY3WkdDRGVJYWZNSFUrNDBGNFJocmNLaXUyZy9l?=
 =?utf-8?B?ZURjb1NFSW5CK1JTSVNENFVvMVRJczhXZHhJS3hjcFJJYTdMSEw0KzYyMWxs?=
 =?utf-8?B?cnZ2ZzJCUzErczVOdTM3RFNGVGhtR0Fzcy9PLzMvVGZhNUVYKzZsNDFzUjhO?=
 =?utf-8?B?NnoxUlhOdVpJRjRQeFR2ZklBN2R4Ynhoamw4SW9WRzd5TWE5bUluY0xsSEZu?=
 =?utf-8?B?L0RTZk82RFREY2tPM3JHRC9CalEzMlhFM0J1OEpHc0pDbU5mYmhpRndnandv?=
 =?utf-8?B?UEtxdDNzU2NkNVJOWkUrUUFFVW5zYjU0RXNDaUtCVUtpYVRaYnZCT2psZ1NO?=
 =?utf-8?Q?PPB+1B2Rk4Z+uKGJ4UnC+ys7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4897b5-fe5e-474d-4ea9-08dd710b02c4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 10:50:26.5434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxsi0I2TzeHybjOoJ/NLawKhLwCoCsCtuOCoBCwt6upSM+mhJqtHCeoxIdUjPIJNY4kmwvpuojadYAhnFPPBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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


On 3/31/2025 6:31 PM, Christian König wrote:
> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936.
>
> Turned out that this has some negative consequences for some workloads.
> Instead check if the cleaner shader should run directly.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b3..5eab1c1a380c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -191,8 +191,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	need_ctx_switch = ring->current_ctx != fence_ctx;
>   	if (ring->funcs->emit_pipeline_sync && job &&
>   	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
> -
> +	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
Should we need to, do this context switch, only on SRIOV cases 
"amdgpu_sriov_vf(adev)" or even in normal BM use cases also?
> +	     amdgpu_vm_need_pipeline_sync(ring, job))) {
>   		need_pipe_sync = true;
>   
>   		if (tmp)
If yes, could we split this patch into two 1. Actuall revert 2. below 
part is new changes?
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b5ddfcbbc9fc..5f0f9e4beea9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -689,7 +689,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		patch = amdgpu_ring_init_cond_exec(ring,
>   						   ring->cond_exe_gpu_addr);
>   
> -	if (need_pipe_sync)
> +	if (need_pipe_sync || cleaner_shader_needed)

Here now, this pipe line synchronization was usually meant for GPU jobs? 
and not for client level switching? may I kno please, why it was OR'ed  
for even "cleaner_shader_needed"? Is that do we have any usecases like 
where we don't need pipeline sync in between jobs but we need to emit 
pipeline sync only when "cleaner_shader_needed"  (ie., wrt new 
enforce_isolation feature)? - but even though in this 
"new_enforce_isolation feature" case - we would be skipping the GPU jobs 
level pipe line synchronization within a client? and do we forsee any 
synchronization/disruption issues in between jobs within a same client 
wrt new enforce_ioslation feature?

Best regards,

Srini

>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
>   	if (cleaner_shader_needed)
