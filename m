Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD82C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 05:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3491710E070;
	Fri,  9 Aug 2024 05:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hVRJ+4m";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A285410E070
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 05:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apyRROC0OBztpbMjFQdBE9kt41/UNMVg/b0pRUyo23Aca0F1KRQUxxXVPc5pCohv2GJa/ngxdLjlM3iI8Q74E6lsXGu5Bxyz0fqlnyUFMYz9l0MOajDh1aRhunwaxvAKbH1KombvSQQGXT5g5tCcOENCTSpG9y/u16xc8p5t2TjrReLSBnWhTC1o2u5OtRG03rld/R1UnjSpa0N41vlSn0bNE2kg4Tp8QPbBXSoi5y6csYpwNNoSp8OlBixju2hDkUngdB/2fEz6IDR9quqqlW7Fd4HOxneSqVwhLqzpEG7j7dr+HmZp/p044fdMTWj6cKnbXR0t9yAUDcin6Yjqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMQ3zskteHe97hV5BAZQGLbeiPntW0cGDxCUfm4u+ek=;
 b=TyKGcLIx/NCHs2sAoWqgLuDSdhzqJUCnWOgTlOgnoK7LV4LWsjJphPtReXb1aVTv/T1uiOVBE52lZcNHpNaodc7SJXJ8ikWOZl/ivYNOzBS0lIFu1Lsq3gDiM6o88Z7u3uwUYyD0tsDHiEYZN63QSZJK3aG9g4+5Szw5hOzy+ncNkhbZSA4POs1mehovYVwyxdnG9k/sS2IEiOQRL9ocrRRAuvpvfadXTh3NHvQR8ZxfeywUTfKCWNtavt/0nNgmcsGLw6juT29zCanzL0scJxiWqM58itLoxoBQrJqeaKWhjZ4soZGL5hQhPUfHSjQcj8YvvhHVX9d/jx20Shc5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMQ3zskteHe97hV5BAZQGLbeiPntW0cGDxCUfm4u+ek=;
 b=5hVRJ+4mW7wYHeJCXLPVMspXCF57WWcfWQ/M5MixTWOM2vGJeWRk1bLV+1cS4qjYKejTsLgQa/rtsAF87Xo+CUOngVmRq2hRECzjRJLskBHku7PQBG8i1QH/vRwPwaX30k7y2USi3J4Tr6XBgSt75alrjJtO3+dixZjybmqJu+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.14; Fri, 9 Aug 2024 05:05:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 05:05:33 +0000
Message-ID: <c3a26467-4a00-4fd3-923e-f8df7a87ae3a@amd.com>
Date: Fri, 9 Aug 2024 10:35:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Disable dpm_enabled flag while VF is in reset
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 amd-gfx@lists.freedesktop.org, zhigang.luo@amd.com
References: <20240808172653.56503-1-victor.skvortsov@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240808172653.56503-1-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4f7777-9d36-482f-e5cb-08dcb830e608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THNYMEV3TGNnUUFPeWZ2aFhpMVQ5dEpYbjNQSlpUMWwwY0RYY0xpNmRybEZx?=
 =?utf-8?B?QmZyZEQza2RPUTJGaHlzMjJnc254YVd0dldyVHJhSDY5UWVJd0RFWk1vNko3?=
 =?utf-8?B?VHB4NWhYZVpvSmwxd1lrN1ZTWmlEY3B4RXAvMzR5WFhWWXpEUmtUVktsT3hJ?=
 =?utf-8?B?dnd6bFNLNGZ6K1F0NE5IYXo0NWxEZTZOeVpyWHZnTkNMOEF4a3VLZHRBancr?=
 =?utf-8?B?czBDSngyYUI2TlJCL3JsbE9QZlRoTjhEeFBSV2lQNSt4UGtBaHFUUWpZSXNr?=
 =?utf-8?B?UHBZSUVXQ1NPeFQxR1c3NWxkMGlaWGhUSmhyU28vSVFoekJuL3ZWZHRaa0Fy?=
 =?utf-8?B?Nlh4NkR0R1NyYWpXQmtUeHkxYjJ6dkdYZG4wZUVZOTh5V1oraG9DdWVEVzNO?=
 =?utf-8?B?R0llMWdBWWluMWl1TUo2N2dSNlRHRWZ6cEdVNTMxTW1HbUc2a1hqZnlDVkxn?=
 =?utf-8?B?Sm5Zd2JBQitJbUNibWdmZWFVTzFSeTVqK3VYeTZwckhCK3IraXhiZGZvNWMr?=
 =?utf-8?B?RGZobHN1UGNFTGZyTE5rNVZvNlVlcklXUDZyWFZSTFBGeEZIVzREL0hBT1JJ?=
 =?utf-8?B?YTBFSWZhcVdWd2M3MVVLOS9BQmcwSUFDamhFOHlTUXhYSkgrWmNKVWpRM01k?=
 =?utf-8?B?aUQvR25UdytOUGVzTmUvVC9OK3poUEVVQXRmZmN6aDhBVDdIWldHOGNoc1pX?=
 =?utf-8?B?QXFYSlpuS3h2V3gvR0YxSGRISFVCbVhXdGx6bnVuSVY0bTVJOFpQcGUvbWxq?=
 =?utf-8?B?R3k2QjlhYmJQdFJ3aTJmTXhoQXVXb2x3N1FsamdjSU01MVdzcnRuY3hkRjZo?=
 =?utf-8?B?SFhWcnphR25qOUdPdTVwOWlzcjBLVzhjdGlLZi9pYTkyNnNybjhWblpvTXpv?=
 =?utf-8?B?V1dpcSt4SFd4ZndUVjZRbHlDYU1kYWNhSHdVcWdRbTlDU3RpaEsrVVE0cHJM?=
 =?utf-8?B?SGh6VjB3MEJaRDc0UGN1NHhpdWUxaFdHWUVWM29iakV4QllkN0kwUHgxUC9x?=
 =?utf-8?B?QUR4R1JkTXdqYXpwK3Vmd0pWQ0ZQVWl5Snk5WGMzUDNQK3FhUmFRdy9QSUx4?=
 =?utf-8?B?R1hiTXZvKzdKZ2NodE01MlR5Nk9UU3hEczRzemRRODMwTnA2aWhRTWlSQ2Fn?=
 =?utf-8?B?emphRG5BYU1VK0h0SDJqMnpkMXJBbCtBczVUMG1yWHZ0UFlyZHNrcVd4Nytj?=
 =?utf-8?B?RW1LczY0bm5xUDFQZGJDZ1g3OHNOWER3WUU1TTlyalJSMkp4K0JEa1BESC80?=
 =?utf-8?B?YjB1dmRyQ3h1am1wUkZXQzIxeE1xNjFsVnh4RTVnWHMvQitkRWlyTWU5bVdm?=
 =?utf-8?B?emVONzdhM3pTSXZnNzByektUVFlGRnVWcXNtdE53a0tNUDRVV1hYbmxPY0JB?=
 =?utf-8?B?WUpDNlVXMW1BSDc2ZFhXNmxOTkxQQ2t4TVVZdGpYZUxaUEUyK09TS3J0c2M5?=
 =?utf-8?B?Tjk4U3JoVG56UjBha2JwcjJQTjgzdlU1RjEvOVAwOVBkcW5IVVAwMk9uQW5W?=
 =?utf-8?B?aFBzcGJUUzJLY2JYaW5JL0J3QWFkZjlUbTNiVTljS2E0RXhZdnBGMzE4ZnNJ?=
 =?utf-8?B?bUtZQ0VTM0lYVStZc0l2bHg3UnBhamlsMlJzSHU3bndaeFNyb3haL2R5aDlC?=
 =?utf-8?B?Z3VpRndxelZwNjAxL1ZTMjJINC9GakxmZW1naTVFNlRaN243U0l5UythcFRk?=
 =?utf-8?B?U1dDa3VqNklBTzU5eUQwbVZMT1pGNUY0SHNsVmpLTkJFSDY3MitxVjAzZ0M0?=
 =?utf-8?B?NVMwSXNYVzNpek5jUFZHck8yMitBam40RVVaaVRQeC8xMzNYWGNOc1NBUDZZ?=
 =?utf-8?B?eCtEMUhBWG54dld1eHU3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFibDB2Rjl4R0ZCY2JQUFZNVGp1cktrL3RtT2hwK0k5YWRRMmt1akxHT2RH?=
 =?utf-8?B?RGFKQzMxVEZaTmlWNVlaUXFqWTdWMkFiK2hGK1JqMnBvbXJ2NkZocyswQWww?=
 =?utf-8?B?YjNYWFB4bU9mbjlqVHFLd0p3Wk8vdHZWU2tXRWdxRDM0emhCVVdpdUZrOTF1?=
 =?utf-8?B?ckJId2J3QUcvNHRodmp6Tm5zL2lEb0dTbkJBY0hoelRzeTNPdzd4UHhIRlhn?=
 =?utf-8?B?dUZkSldxNjN4dFVxK1pZUHpYUHJnZzhIN3VXQ050aVM4NGNETFFnOFNyK0Q0?=
 =?utf-8?B?RlZ1SnpEOURXek9mdzViY3cxT1JCdVRiUWxXdUwyL2E5TklBVjJnOTZTNHc0?=
 =?utf-8?B?WUxGdjRhbHVGWDZVZmJDZWNzbklKVDdQQ3MxVDRVL3VFRHJwVUZDWlFodWlJ?=
 =?utf-8?B?bkFUSmZYM29oYmY5VEVCSzg1T1hOR0wxMFpVMkRzRis4QW9YR0VjNGpNV2Nh?=
 =?utf-8?B?NW1Od0tmQUxqa0NZcG9Vc2xGdUhZclltS3FtK1FJNkk3aVlQSS84R1VmU3F0?=
 =?utf-8?B?OWdKWlJGZm53dlUwbU9nNklwRnVHOGNGclJMV29DcDQ3bkpIRW9lNmp0SFR6?=
 =?utf-8?B?VVpkQkt0T29jL2E4dzhCSGpvcVlVSEUxc2VLbXRLZUxJaTM1RFZtczBMdGdM?=
 =?utf-8?B?c2d0Zm5WMHhJN1pzd0RuUFdpNGM1V1NHdDJaMzFzc0dBZGwzSC9iMGJEZWls?=
 =?utf-8?B?eUxwMFd6b0NtYkUrMWJtM3BGMmZDeVZjSGt3RDI5YjdWcVRmNjd6bFpSTlRk?=
 =?utf-8?B?TTQxLzh1MnlES3FUYTJ5d1hKVmFlcGdvU2FWdmhMa3BJNUZKY3AvTG1uOWhl?=
 =?utf-8?B?YnhaTjc3YWF3WjZiZlBsbitWZDJFM2VmV2F0ZlJvNXZEQ0ZkTlpLOFUzUkl3?=
 =?utf-8?B?UmViVUdzN0JGMkVXMkw5K0ZVSUovcEY5Mm42NkVDczM5NVJvWFZTV0k2cncy?=
 =?utf-8?B?SFJFR0s4WTdqVFVzWVdGajRNTXZFcEMrODBlYXRlNzlFTFVyTWszaFVHV1U0?=
 =?utf-8?B?dERoY0NDZE5PdHlDUkpnTmNjMkR5N1ZkdWNxdVhoQmxZN29YUFZBZDJIeTQx?=
 =?utf-8?B?dHZoVTlXcnBxSDdHcjBaVXZvTXBueHlROHVxMkZJdHNiNFRFUTJGWEl5ZVNV?=
 =?utf-8?B?a2YwU1QyaEtEaDljdHFyLzRpWnk5T004bzgxMnJNS2dwa2Vxc3Jzek1TUmZS?=
 =?utf-8?B?RHZ2dm5XTVJuMGhnenRQcHdvZkJKcTljRUtnUkRkS1hqT2RjTlg1d05uS3RQ?=
 =?utf-8?B?QTVjT2xJRWlXdkN6d3lXRmpOVExjNXVCUFhsanBja0lxZDg2cG9DUXFybXJL?=
 =?utf-8?B?NHdRVnIwMW9wekhkOHhzY2FlV3J6UEdpVzQ5d2hwb0dWYTBqVFZjY0VRSkRO?=
 =?utf-8?B?dExPU3JleEY5TWFsbllteThmMnlVeWtEWG9SSEFuZjI2WmZ2dm0wYnFCK0RB?=
 =?utf-8?B?U0s1TC9uTDY0ZzZLbnRpVWVYZXFOZWRxNWVYNW94WWdrS3VmQzBWUHE3ZFpQ?=
 =?utf-8?B?enFRYnRTRWtsNUQ1VXJOaTM0V3F2SEVaRHRiSXBIam90V2ZkVktKUnhJT2No?=
 =?utf-8?B?cVUxUDBKMnorWjBnSUMxN2hQS3puNDFycHgrN3VlWEZiMzZ6NUNLNmxrVE1o?=
 =?utf-8?B?RTlHQzNHT1dTZklDOSsxSU5TMklrSHpSc1puUXFaU29JYnZmQ2RQOEVndGta?=
 =?utf-8?B?Mm96cnpFT3pieEZmaVkycGprODRkbUViL2Y1UnJGMzl1ejY4cjU4cG9kSmJ0?=
 =?utf-8?B?aXV4REhwMU9ZSk40RHZRSUVwL3RVNm16SFl3RjRVRFdDSVJTZWVKeFRXQ3g0?=
 =?utf-8?B?eGtvWVcycnVXcHJTcUVUc1ZXU2VCYyt6eTU4b1VBOFgveGk3TklzUEo2M21N?=
 =?utf-8?B?Wmp0RDZRaVVaVHBHMFNsNjBnTVdOa2xVS1ZFaXdqTmN6R1lDZ1F0NWhRTnIx?=
 =?utf-8?B?ejdWTmJRUktSenpEV3FhZDgxb0NJclRUOURSajhPbWg1MW0rM2pYd01NbHpt?=
 =?utf-8?B?M1BaYnJuVUZ0R05CZWtwV2pHMVJmb0NGTW9wNTdBN1BSY1RVbUJGWUFvUCtT?=
 =?utf-8?B?ZitYY1k2RVJwWW52N1pJTVA1akJidXp6RTVPQ0ZNTHBldG5LSEprak5DWUJP?=
 =?utf-8?Q?7Q7hDn4d6mD0PItgJOF2abaxl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4f7777-9d36-482f-e5cb-08dcb830e608
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:05:33.8717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sKVBVnB7Lr0Pf7FFYzTpRW8wmKXYZsQda+Db0iqg9GpEotXkzzEb9V6MipX572q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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



On 8/8/2024 10:56 PM, Victor Skvortsov wrote:
> VFs do not perform HW fini/suspend in FLR, so the dpm_enabled
> is incorrectly kept enabled. Add interface to disable it in
> virt_pre_reset call.
> 
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 10 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  8 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  1 +
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 +++++++++++++++++++
>  5 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 730dae77570c..1be5699f4190 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5288,10 +5288,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  	if (reset_context->reset_req_dev == adev)
>  		job = reset_context->job;
>  
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* stop the data exchange thread */
> -		amdgpu_virt_fini_data_exchange(adev);
> -	}
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_virt_pre_reset(adev);
>  
>  	amdgpu_fence_driver_isr_toggle(adev, true);
>  
> @@ -5561,6 +5559,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>  
>  static void amdgpu_device_set_mp1_state(struct amdgpu_device *adev)
>  {
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->mp1_state = PP_MP1_STATE_FLR;
> +		return;
> +	}

Better remove this change. If at all this state need to be persisted
through out the reset, handle it only through amdgpu_dpm_set_mp1_state.
For now, I don't see a reason to store this state, we only need this
state as a trigger for the action associated with this.
>  
>  	switch (amdgpu_asic_reset_method(adev)) {
>  	case AMD_RESET_METHOD_MODE1:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 111c380f929b..456a685c3975 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_dpm.h"
>  #include "vi.h"
>  #include "soc15.h"
>  #include "nv.h"
> @@ -849,6 +850,13 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>  	return mode;
>  }
>  
> +void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
> +{
> +	/* stop the data exchange thread */
> +	amdgpu_virt_fini_data_exchange(adev);
> +	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
> +}
> +
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev)
>  {
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index b42a8854dca0..b650a2032c42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -376,6 +376,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>  		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
>  bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
>  			uint32_t ucode_id);
> +void amdgpu_virt_pre_reset(struct amdgpu_device *adev);
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev);
>  bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev);
>  bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 4b20e2274313..19a48d98830a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -218,6 +218,7 @@ enum pp_mp1_state {
>  	PP_MP1_STATE_SHUTDOWN,
>  	PP_MP1_STATE_UNLOAD,
>  	PP_MP1_STATE_RESET,
> +	PP_MP1_STATE_FLR,
>  };
>  
>  enum pp_df_cstate {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 78c3f94bb3ff..b85478b1eaa7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2638,6 +2638,26 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
>  	return ret;
>  }
>  
> +static int smu_v13_0_6_set_mp1_state(struct smu_context *smu,
> +				enum pp_mp1_state mp1_state)
> +{
> +	int ret =0;
> +
> +	switch (mp1_state) {
> +	case PP_MP1_STATE_FLR:
> +		/* VF lost access to SMU */
> +		smu->adev->pm.dpm_enabled = false;
> +		ret = 0;
> +		break;
> +	default:
> +		/* Ignore others */
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}

Should this be made generic for all SOCs - i.e., handle it
amdgpu_dpm_set_mp1_state() itself? The logic remains the same - turn off
dpm flag during VF reset.

Thanks,
Lijo

> +
> +
>  static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
>  {
>  	struct smu_context *smu = adev->powerplay.pp_handle;
> @@ -3283,6 +3303,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>  	.i2c_fini = smu_v13_0_6_i2c_control_fini,
>  	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
>  	.send_rma_reason = smu_v13_0_6_send_rma_reason,
> +	.set_mp1_state = smu_v13_0_6_set_mp1_state,
>  };
>  
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
