Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8524D1CDCA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 09:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B16810E10F;
	Tue, 22 Oct 2024 09:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egx9yYq4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DF510E651
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 09:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y89JqBYLJbrXR3nhhYKYCU0+O5+mS6UTnpRZXM/xDiUubA5wKFjKvxml3QsEuw7mExhCj0UfjPDM/CwXUQINq+U/hgTgty9VCX9NJinmgHKQ4AvLAOz78zIdcHHN9gVPTyx26nhae2Vi9Cp6rZ+9Komcs5WnWbYzMdO2L8Vv9s8+a0xZwhL9qXBH4bRBHJHmHhQKUx4M2DLsALYAfV43NZqqSYA0mzJvGqdSND5OIsbYo3Tzs23uz6/goV8rRVuTZcDmFIQ1ZZecuORQvhTeh6rwT4FKxe1VcuOE4x8m8niTuCN6VUKpKnWy7Gxr4Brr2gHd5aGj+Gb5OBho3AQW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9l56R1JK1MFdH5l/idcesasseK/J+2btBMi5PIP//A=;
 b=JYt59xTTlBC8MHUNvrw8pRYDNnatMVVCMsDWALM9dnWby20hW7FrE/Pb2Q16yogXto0hqonux8v610xFXUg9fcekTXSItlLa5w3FhgDKpimwBeDa9PdJEtwDM3WhaQuy0N7cGd253RqHrGJKa77Ye8hHwXVmNCw77yrDGalEuzwHWbQMt4pg763nWnlq2DiS2y+0OhFgKeN2ttP38r6aj8Kz7Lb4ti433YY4ugaXPeTh15yFRRkGLL801IXtaipLo/RQmT53S30V5om07nyMXRrcJxM8VyC13K+0WLjSEB7rVROXCi1nu95YtqP/CG/tjS2RL684NIe80OPrgqWepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9l56R1JK1MFdH5l/idcesasseK/J+2btBMi5PIP//A=;
 b=egx9yYq4yqBPOmeRkHqU0FMlivcZ4Uaa4/GRX9AwLHBBLM9GBjgLkVJpYWlksfI4Tyb2WFH+lI2Nw9u7DAoIUmGJdMo/nK5ZEpXCZ1z/KhOh3yFByOfM/NYVzquz/XkfMyTbo+sfGKGnYT9iyj6cyth7gC/wSfs2lCP75FNqJHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 09:52:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 09:52:33 +0000
Message-ID: <fa32e594-cfed-4854-b271-60db35c47bb9@amd.com>
Date: Tue, 22 Oct 2024 11:52:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241022075909.2530386-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241022075909.2530386-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d9b350-bead-4f42-ce97-08dcf27f405a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUtPcE5GcGp0TWI2SnhDZTRoUW54UEFtQ09aTnVEUUhFRFJKMFBJWHJFSElU?=
 =?utf-8?B?MHZCL0VkVHFxanpYc2hXL2JRUWhidy9NSkgxbVIwdHMzYnJxVUtFUzQ5QmRS?=
 =?utf-8?B?aDJpNk1aQ2Z2d3FucUNTSU5ybFJnaGQxUVR0YlVEOWxvdE1kdWU1SEg5YVFx?=
 =?utf-8?B?QTBUSXVIRmt5VGhXWlB1bStPRk9aVEVBLzE0T1dXSWlrN09lYzFZai9iWGlS?=
 =?utf-8?B?ZS92Z0lpcTJiZTRlK0FjNWo4ZE0wTkY4TjZxUllxMi9GMm5SRlpEZzFlckx6?=
 =?utf-8?B?U3ZzcG9iMGpPODRJd2Yxa0Mzd1FQSm52RXpYR253MlZyMlA2YzNxVWJIbGpB?=
 =?utf-8?B?a1RkelFGZUNCT3IycUdodTVRc0VzQnEvcmM0K2VZWGM1eVM3emhKWGhMa1Nl?=
 =?utf-8?B?dVNrUFZpVG9yOWhFWGh3RERHYlRzbXpJQi8zTXRxRUJheFFCRTd4cWtXWFRs?=
 =?utf-8?B?ZWhxalFhMlFtWTdER0ZNRjFiTTBUNU9MMnJLeHk3a2FCU0R3NXBZRktFcUpm?=
 =?utf-8?B?MGpGUHQ2eHZ4bDYvTWlVeXVwYSt6dXExNnZrN2lySVFDTkRsdlk5UWxRS2lz?=
 =?utf-8?B?UmJGemhPajhHQU5rdEh2VFhoNEV3dDF1RWVaQzFFNUFmc3ZzRWFqSnRzeFBF?=
 =?utf-8?B?VlQvK1Q0Wm5uaUVmTHpFZ1VDNWpkL3RrZFlzWFlCSmdMOER3TkxZWDg4M0R4?=
 =?utf-8?B?QjNBNTZXbVNHUERBazBoeFJmZURDTTBweTRwYjlqRFRuQXk0YXdsRStLZmJH?=
 =?utf-8?B?TkFOR0NqNURVNHJPK0RpckxkdzNhTi91dlYvWmM1elFvMFhkb1F2Q213QUNJ?=
 =?utf-8?B?ejRDMHVIYXkzbnNmYmFMNG5zQ1lONTlpNUlOcS9lbW92SEpleEpyTHVkUVI0?=
 =?utf-8?B?WHA5MTBibWMzdmkvL2JhYm91SjdxdXBkWkxYbDVFdy83TVVYdmNEaW9RWkhS?=
 =?utf-8?B?MnRiYm4rUlFzVWVIK05pMnVLU0lnNXoyWFM3RHBvZFl0USt2WWhSUTdtSTZy?=
 =?utf-8?B?eEVwaWdSMXpFeUhpUHBTZmNpWXBwSCtJT3pGOGM2L2hiUFBBQ2VGOU1Nclh4?=
 =?utf-8?B?bDJhSUYxQVRpdHdNYmJrRG9ReS9nZWUyc3gwL1lCUzZzdW9VQ25hN1ZyTlB6?=
 =?utf-8?B?UC9yMWpHcGpwUlpTa0J5VlN3aEM4M0hZTUJNdDFYd0Z4Tm9GMFVXeFVhSy9O?=
 =?utf-8?B?Q0dKK0NDc2JaS0p0TU1TY3ZVYW9FWThOY0hkUW1MMTVhbEkvWWVUWS9wL25I?=
 =?utf-8?B?RHhtaERZcTVtZ0p4Tms1NHRpZHBpVmt4MjhvSlk1NTNiN1I3NjFUdFluVTFv?=
 =?utf-8?B?TDVwK24yYWk1bDVzOHNXaUVQTDRTQkEzMTJiYkVoUjRmc2Jxbmk5OWp5VWVx?=
 =?utf-8?B?TFdISlJHMjdXekp4NitscUhEUlpYdzV2citwQytkVlJjTmtNamFqcWhjeUQ2?=
 =?utf-8?B?WWt1MnBBMkdQbkxtaXM2eVpJamg2aStodU1ocU5zZjBHaVpOWE4zSTR2R0Nx?=
 =?utf-8?B?K1ZTc3RmQjB2L3p2NFhQay9KWFRkZkNPaGRxaDExT2ZJZldnVEgzNTl4dWN6?=
 =?utf-8?B?MU1ZVE82N1c0Y0g2WC9BMHU4eWdSdEp6dld6ckYvT1k4TVJKemVndUZTbEdM?=
 =?utf-8?B?WEJXdEhUTEFJUGpRUUVGZHh3WWx0S0d3ZlJ5TWEvT3RUc2krdVFPT29JNnlY?=
 =?utf-8?B?b3k4MENFYkt5T2RHUUYxMW9oSjhKaHdVRGlmcEMzc0VLRk5RMFYvZzBHRXJ1?=
 =?utf-8?Q?4DVAk7WQPMSvsfCMr5AbNdKLITvWgCe8a77cvzm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFvNUcvZ3E1VHhaa1BycUlzd3FGeGN2ZjB1ZVFWM09hMEFyeFZpMWdTWU9K?=
 =?utf-8?B?Y3hkRUFFK0ZqUkxBdVcvdXVSSUJYR0VDRDdqb1J5dCtRcWZCLzV3SnVhUDQ0?=
 =?utf-8?B?dkw5R0drMWM1ZCtSWWVCRG5GVytDN0FxU1VTZ2UxWEgzRXpXZEtxaUU5QTdV?=
 =?utf-8?B?UXpZTUxBdGU5MnFVdVVHaUVHQThNU09TZzhRclZ6WUs4bG1lZUdCdER5YzJD?=
 =?utf-8?B?STZoS3RzZXR1cVhUWWEzc1A4aStNeHFjMWE2ZmlBNE5RZ2xMR1lDNjdHM1Bo?=
 =?utf-8?B?TWRaYmcyWjlkWUtoWVFjc3hSNXBaNkpMSEYwcHVPaXVSTTVjVUVkNTlpUG1S?=
 =?utf-8?B?RDZNaU5GSi9DdXJvM3lsb3gzcjBNbTBRV0JFb0lVcTBPNnlPUUpQQ1llejFN?=
 =?utf-8?B?WHJsZG1URHdhZVVIbUw0TEpkdkI2aHZBSnJsTWZjN2IvdmRhRGF2VGlzOVln?=
 =?utf-8?B?RG1aakxkdmJEREJmbm91eWt4eS9xNnJ3aXR1Rjg5U0QxdnRScnZwT1BFQ05P?=
 =?utf-8?B?Uk8rWkdpaTF6dGduakxtTFlqYTZFOXlQbnB1UkQrSkJDdlRvWndnUG9zMUZT?=
 =?utf-8?B?bjAzOHJMU1dLNFBnQkVjYTd1UzdOREhWMkxKYnJVU2xsNzNnSFBoQ0JGZ2Rs?=
 =?utf-8?B?ZHEzRUlodXZ4dFV5MU1LTm11aThlZWEvL1orVG0ySE5pYTJxUGwwTzBHenFE?=
 =?utf-8?B?SEtCRkdXNERkMFNRQi9zVUJaVFZqODVsRVVHMUhJaUZCekRCYXZnbHdRcE1q?=
 =?utf-8?B?MVpxRDNrWnN0M0tOQlZtbWxzNDkxU1J3endkZ1BwTTVEcEk0L1Vub0l3UGRM?=
 =?utf-8?B?dExseEU4K1BYNE1LVG9vQy8rSnVDZTcwVWpGTFlOVDhJNGFWbTREQ2tuSitY?=
 =?utf-8?B?ZE1KaE0yb000aWpNVVc5dW5DY0RkYlVSbmZkd1VPbDN0U1NhRHN2Y3pCc21O?=
 =?utf-8?B?S3diVnE1UDVRTmVvWkRqNE53ZzB2NU1CRmVQYlN3Vy9oUlgzU1UwckdJUnRk?=
 =?utf-8?B?SU1pdSs2YjdhMDQxZkxOQ3VabEZad3RDRFZOdVRwekNaZk12YTk3TGNacnVh?=
 =?utf-8?B?Q2JYSWkxOTM4NUUyK2VrRGg2UHYvREFmTkpGZUluRGNoSjZBbmRFQmxVM2Vk?=
 =?utf-8?B?N0dtS1BIYk5UVWoxc29kN0w1dUYweEdyeWFPa2wvQStsdk9uY3Z0bURqNGRF?=
 =?utf-8?B?WlVGaExTSzZWSG9IakZCOVMxT2dNTG12aXk5TzlWRHRldEFQSGZkMWVKR2Nx?=
 =?utf-8?B?cXF6bnFOVDZwMDNLYnc1UC85bWhrT0JCQlgyUXJNZ0t1eDRSc0pKMTdLdDdB?=
 =?utf-8?B?ZWdsRTNFcmd2WkNpOXkzSVdyblJoSVFWekFPUkRhWmY2Wnk5b2haVzlvWmxY?=
 =?utf-8?B?SXVqdE9WOWNIVkh3MjBta3RFbFVoSUk5REd2VmZiaGorbG5Xc0ZFdW9zL0pP?=
 =?utf-8?B?aVJBUFVFbWVpQTUvZGNTS3hOZURIYzRoUkg0OHdDb3VZb2czVXE2UUNJd2o3?=
 =?utf-8?B?cUUrNzNIZ1dPSGZTenBMQnFhWDUzVnEwZmFzNGtLNVQ0SmpOL1paUDdpS0Ex?=
 =?utf-8?B?QjBXY2lGaXozSkFNR1A1bFozWFRuMmtSKzVYZ2RkblRSUmhoWkpYdFBlWE9T?=
 =?utf-8?B?Z0lsNE03V3l3Z0FVUVJvQW5UK2l5cHY3bzlPU3VTamxBK3BPTXFhL1B1Y1g4?=
 =?utf-8?B?Ym5XWXNCTXRPdW56TTU4TWhnaUIxQ0FsVjFvU2RLZWVPaXhlQVpWb0J4cDh0?=
 =?utf-8?B?QkpPMkRROE5WVnhnRXozRTF6bzdtem1QSHZzcUpxN2I4Y3FLeTRza3o3MXoz?=
 =?utf-8?B?SUR2S0UxQXA5Q0xUWk9hdmN1LzgvbW5zRlBUNGhpOGQrSUdlYWZhelMvYVhB?=
 =?utf-8?B?Vnl2ZThhL0R4ZHRrbmtVU3BqUGhsaHdWZ0VOcWhrbFJHdlV5TlV6alhPU1Q0?=
 =?utf-8?B?RVk2TFJZYVFBbCs0cG5VWE9Mb3pIc2RyZlZkcWVmOFR5Q2RUTHl4L3NaRm93?=
 =?utf-8?B?akJSVk4yZThuOE1EMkpEZHkyUERJWldUUk5PeDNNQVpNOXZCUS8rWVZid2FR?=
 =?utf-8?B?dmlaemUxYWtweTVDZkJxc2piS2NHRGRQNnphWkxQUUdhZzRRbWE2bGk5VExW?=
 =?utf-8?Q?M9pFG82pHuEUWfV4SEBkBuXAB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d9b350-bead-4f42-ce97-08dcf27f405a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 09:52:33.7356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CN+bSxEFSJKRWR5kt/F/wvqICBq7xSSJlit7RZl3CXT/h8/m7tIx8fykcy+ouEw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

Am 22.10.24 um 09:59 schrieb Jesse.zhang@amd.com:
> Add two sysfs interfaces for gfx and compute:
> gfx_reset_mask
> compute_reset_mask
>
> These interfaces are read-only and show the resets supported by the IP.
> For example, full adapter reset (mode1/mode2/BACO/etc),
> soft reset, queue reset, and pipe reset.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by:Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   6 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 122 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |   6 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   5 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   5 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |   5 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |   5 +
>   8 files changed, 156 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..0dd475c30267 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
>   #define AMDGPU_RESET_VCE			(1 << 13)
>   #define AMDGPU_RESET_VCE1			(1 << 14)
>   
> +/* reset mask */
> +#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset, mode1/mode2/BACO/etc. */
> +#define AMDGPU_RESET_TYPE_SOFT_RESET (1 << 1) /* IP level soft reset */
> +#define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
> +#define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */

The general approach looks good to me, but I would really prefer that 
the sysfs node returns a text string instead of some flags. E.g. 
"soft,queue,pipe,full" etc...

That's easier to extend should we at some point get something more 
complex and we don't need any specialized knowledge to decode it.

Regards,
Christian.

> +
>   /* max cursor sizes (in pixels) */
>   #define CIK_CURSOR_WIDTH 128
>   #define CIK_CURSOR_HEIGHT 128
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e96984c53e72..b4706355ece8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1588,6 +1588,94 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>   	return count;
>   }
>   
> +static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;
> +	struct amdgpu_ring *ring = &adev->gfx.gfx_ring[0];
> +
> +	if (!adev || !ring)
> +		return -ENODEV;
> +
> +	if (amdgpu_device_should_recover_gpu(adev))
> +		size |= AMDGPU_RESET_TYPE_FULL;
> +
> +	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
> +			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
> +		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
> +
> +	if (amdgpu_gpu_recovery && ring->funcs->reset) {
> +                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +                case IP_VERSION(9, 2, 2): //reven2
> +                case IP_VERSION(9, 3, 0): //renior
> +                case IP_VERSION(9, 4, 0): //vega20
> +                case IP_VERSION(10, 1, 0): //navi10
> +                case IP_VERSION(10, 1, 1): //navi12
> +                case IP_VERSION(10, 1, 2): //navi13
> +                        /* Skip flag setting because some cases
> +                         * are not supported by current firmware.
> +                         */
> +                        break;
> +
> +                default:
> +                        size |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +                        break;
> +		}
> +        }
> +
> +	size = sysfs_emit_at(buf, 0, "%lu\n", size);
> +	return size;
> +}
> +
> +static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;
> +	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
> +
> +	if (!adev || !ring)
> +		return -ENODEV;
> +
> +	if (amdgpu_device_should_recover_gpu(adev))
> +		size |= AMDGPU_RESET_TYPE_FULL;
> +
> +	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
> +			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
> +		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
> +
> +	if (amdgpu_gpu_recovery && ring->funcs->reset) {
> +                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +                case IP_VERSION(9, 2, 2): //reven2
> +                case IP_VERSION(9, 3, 0): //renior
> +                case IP_VERSION(9, 4, 0): //vega20
> +                case IP_VERSION(10, 1, 0): //navi10
> +                case IP_VERSION(10, 1, 1): //navi12
> +                case IP_VERSION(10, 1, 2): //navi13
> +                        /* Skip flag setting because some test cases
> +                         * are not supported by current firmware.
> +                         */
> +                        break;
> +
> +                default:
> +                        size |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +                        break;
> +		}
> +        }
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +			adev->gfx.mec_fw_version >= 0x0000009b)
> +		size |= AMDGPU_RESET_TYPE_PER_PIPE;
> +
> +	size = sysfs_emit_at(buf, 0, "%lu\n", size);
> +	return size;
> +}
> +
>   static DEVICE_ATTR(run_cleaner_shader, 0200,
>   		   NULL, amdgpu_gfx_set_run_cleaner_shader);
>   
> @@ -1602,6 +1690,12 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>   static DEVICE_ATTR(available_compute_partition, 0444,
>   		   amdgpu_gfx_get_available_compute_partition, NULL);
>   
> +static DEVICE_ATTR(gfx_reset_mask, 0444,
> +		   amdgpu_gfx_get_gfx_reset_mask, NULL);
> +
> +static DEVICE_ATTR(compute_reset_mask, 0444,
> +		   amdgpu_gfx_get_compute_reset_mask, NULL);
> +
>   int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> @@ -1702,6 +1796,34 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>   			    cleaner_shader_size);
>   }
>   
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
> +{
> +	int r = 0;
> +
> +	if (adev->gfx.num_gfx_rings) {
> +		r = device_create_file(adev->dev, &dev_attr_gfx_reset_mask);
> +		if (r)
> +			return r;
> +	}
> +
> +	if (adev->gfx.num_compute_rings) {
> +		r = device_create_file(adev->dev, &dev_attr_compute_reset_mask);
> +		if (r)
> +			return r;
> +	}
> +
> +	return r;
> +}
> +
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
> +{
> +	if (adev->gfx.num_gfx_rings)
> +		device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
> +
> +	if (adev->gfx.num_compute_rings)
> +		device_remove_file(adev->dev, &dev_attr_compute_reset_mask);
> +}
> +
>   /**
>    * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
>    * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..0cf2151b3cf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>   void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>   void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>   
>   static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9da95b25e158..2baa76095232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4856,6 +4856,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>   	if (r)
>   		return r;
> +
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -4908,6 +4913,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v10_0_free_microcode(adev);
>   	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..32d14b9cc6e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1721,6 +1721,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -1783,6 +1787,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	gfx_v11_0_free_microcode(adev);
>   
>   	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..925b7ca49b2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1470,6 +1470,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -1530,6 +1534,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	gfx_v12_0_free_microcode(adev);
>   
>   	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b4c4b9916289..0de199c1cfdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2394,6 +2394,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -2432,6 +2436,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	gfx_v9_0_free_microcode(adev);
>   
>   	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..87cfd77e2fb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1175,6 +1175,10 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -1200,6 +1204,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   	gfx_v9_4_3_free_microcode(adev);
>   	amdgpu_gfx_sysfs_fini(adev);
>   	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);

