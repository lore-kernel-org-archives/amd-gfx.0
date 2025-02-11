Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB317C0219B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 23:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6645110E768;
	Tue, 11 Feb 2025 23:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQSrwOR9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED53310E768
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 23:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgwtiM6CxuybaJLRoEJY1JL2nPq+9p9jHwLfW9poIP+7tdHVwVTEWtQw/gNNrdeu+GkYiYc/Pp07oaKmEuSaaDusRZPT8l0hyCtgK26hPM6yvQBydis5J7NmneMBL4Vb5DQHHJ3oEb4Zw9M3yGrlrs9+YPN2Nu0dCz78Ac5PBTJcGFWMxrGQy+/fLI+XYgjqj48XLf+DcxKPUYI0CijdqeXbtKPioPpHAS3nzA/5PPJ8hL1vqaahcvyp+vOnSwFnRQGkKLummwZDbrk+v5skL5vN4MIFcqJx+gGJxE8PkPviP5k0IeFraQXxEcPuIzM2LIGWJVWo9/+mx4/ZBO4sEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ftLQBCIxyR/Xu6RtUmnKy3oBeUx7sPj+S0DZ6UPZlI=;
 b=zHlzMSxCkTC/f4NUkfwEpz1hFlwj/mvijs8DKYzqv9Hg6pwZiFlsr+5u31ersGip5FQjGhIjNV/bQ3zJNF1QtvcKJNbMhFN9gCzX4IuAkmmfZfeZGs7gBQzAjEl/4yJ2xK+32y4ABp4si5evPRoqY24N6J6oP+CWYuxDJEHo+x2LWXsuh9ak+mXpMBCMrTqtdUSAiyjnoOnVeovKoL+q+2sY/eCXA+dLo8c8tRW0yUc8vqX6XMs/sfQcP6TBeA+mEe9urUWYc5rd5Yi76hbMIBz+RMrJFtPjAPY2xfYCnfDYQZL7KvVHN2G4cWqieVz7O+FlNL3iihb6daQnW1G+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ftLQBCIxyR/Xu6RtUmnKy3oBeUx7sPj+S0DZ6UPZlI=;
 b=PQSrwOR97mgZ/EjM9Aa33UTBpY98ray7RXryDIQ/BU8GUQ1W3A2OmpaUEwl2rkwaUlTjvfCCYZK52NudyZv5eGRK/Rspj3KSLboUvTDVJQIAUMs7WP9N5dCrlzEtG8uvtPIPtyRU9Z6ZvwnYFDyCQOHJpYaCG8KOZ4FKgEDh/Q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 23:21:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 23:21:43 +0000
Message-ID: <9fe949ae-83c1-42e3-b723-26d9d30837b4@amd.com>
Date: Tue, 11 Feb 2025 18:21:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix pasid value leak
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: chengjun.yao@amd.com
References: <20250211225424.384523-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250211225424.384523-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: f728c581-99bb-4f00-3470-08dd4af2d854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlljZEZwRG5va3VYS2FCWk5xWWJBUGxLZVhNR3Q3cWtCL2NnL2FnMXMwQlJB?=
 =?utf-8?B?d09NeEZlZmNQdFNPLy9jcTVlY3FvNHliYlR4RUF1RjNQWWxrSTE3Z1lFTGI1?=
 =?utf-8?B?NGhxeWtwWnpXVTVXcjVnNFQ0OC9PbmRLZ3ZpdW50d2U5eVFMVkVWNndxZDBT?=
 =?utf-8?B?bUp2VnI3SXloTDdMZk41dVVidzU0bTFBRjQ1WVZhQWdVNEhXbGdMUGRCUmxJ?=
 =?utf-8?B?dkh1Qk11VGlidThhU1lnbklBcGxhSjJvU1drWkhMOFRJM0NWTjRlL2hFSE5m?=
 =?utf-8?B?RHprQWVPRHg1aG16U2dsWjZsL2x4RTczcWE1akx0bi9YR0V2d01veGtRY1FV?=
 =?utf-8?B?a3VNaSt3VHhWanJnTDhxK3F5ODFtRlhDekFCUENYMXBObUQyQ20zRWVGMjB1?=
 =?utf-8?B?NFRpQW16YUh3c2VHNEN0cllSNk9mUHhHK3F0TVpLNDFPRktzTDVudmR4V3Mz?=
 =?utf-8?B?UDlWNWN3N0w2b0NSYmtGMW9uTllMRkRWeXpnZ1AwYkhsaG1yc25yT2FPM3hI?=
 =?utf-8?B?Z1VoTTZCNU1sTHR6WkdCek9iMWpDVnpvd242VDVWYlk1NERvUy9nVjc1VnB2?=
 =?utf-8?B?VTIxaEZpRENlSHZ0bWlqOUNvSWxKRXh1bVV3cXV4RGxndSs1SkpVU2RqUlJl?=
 =?utf-8?B?S1dUbnFkODN1ajJsbmtGdk9NV0Y2cU1KME9ENEkzU2hQZUhtT0Y2ejQ3enBD?=
 =?utf-8?B?UjZTNmVzY3cyVHJBUGttem1DZVBkTDVQL2JoVTdJV3VPOTVnQ0lzVFFqNW9Q?=
 =?utf-8?B?OEZhYjlhMGlNOFZvRk9YV3FCb3FpSE9zdFhWbkMvVW01d3hDNmtQblFRTzly?=
 =?utf-8?B?ZThyOGFSNkJFZW1yVUJyM1Y2VXVnWDZpRzFWdXVhL3VnRE9MdzFWb3pOdzNy?=
 =?utf-8?B?SG5MSTJ0YnJHNVhjemhONERCVGpMdEVOYWxyd2RzcjlxazVpd1NRb3ltcmhw?=
 =?utf-8?B?Y2FOajNrOXhweVBFTFNLSW5hcG9QMW45eG0wdStHSWFSTGVaS1ZZZUI5a0lP?=
 =?utf-8?B?WFRBb0VWeGlkSTR5M01RdlByN3h5WlorWk9hZEgvZ2FaNlhaVTkya210OEh6?=
 =?utf-8?B?V1ZXMUZ4TndWUCtTMzVtQWVZRUJJL1dxS1lOekExSGtNM0d0OVdsWnE1UFVo?=
 =?utf-8?B?OTYrODcvZys0RjZtblBweUxqUXJEZDNOZkV1Wm9CbHpoWktBYzNSNkdiOExV?=
 =?utf-8?B?R0hhMzByYll1RUFCcXNIYTMvV1BzT3pENlNCS1hJWklCWHJET1ErK0l4cklz?=
 =?utf-8?B?UURpZkFMbE1aNUc1MDNWRTRGMGFwZEVYTXhqT0U5VzZQSDBZdlJ4VFkySktT?=
 =?utf-8?B?a05qZHhwY05qUWhMdm1CMHRjTkVYYmx6K1ltNldhb0QyR3h6UHdJeFR1dEt6?=
 =?utf-8?B?cHNENUwvaElwMjhVWmhycUlyT3dxUjF4RkZLTTNleHZiVnVIeXkvTWpUNXRN?=
 =?utf-8?B?QkVsekMxZnVvZmxSRUc1YkFZS1JSS1RwZS9pVkRWbG53anQvemN2Y2x1dWNJ?=
 =?utf-8?B?c1dLMHlBREsxeUMzdHhRSkhkWUlBSmFXUk9YNXFRdVFRVUJzMFBaN29lZUZm?=
 =?utf-8?B?WWZkbDAzUUpuK1BleFI3Q3U2VXBsbHd0N3FxRWZZSzRjckRva0ZpZXlWYVdR?=
 =?utf-8?B?a2pWQmFpTUNNckFjOFV1bC9kRk8xYlRlcTZDYlJ1endlSWhGVjlscU82S3VH?=
 =?utf-8?B?T1Y4WVExOFZ4Z0xCMW8xODAwWEg5VStmclpZbWhhU3I5cGxnWldpSWNjdzd5?=
 =?utf-8?B?NVBzZDFCRU4xME9ZZTcwQ1RlcmFyd3k3bjNSbklqS3Y4RmhGRUk1OXhEK3hk?=
 =?utf-8?B?UGx4SnRUS3dVWDdaTnc0Ymdnbnd6dklGL1pHRE5MNnh4am1sM1RGenlwR053?=
 =?utf-8?Q?gE6Yf28nuyyAV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZiQ2huOHNHNDg2QmJqM3ZkemNBKzdpVWZxNHBUTDV4bnFQZ3dRVWRJSVJh?=
 =?utf-8?B?TTI5MTlvQXhuUENuMHNydDV1eGV5bXdDMlRMcFV4dXFzQUZvWUY5a3BnWEx6?=
 =?utf-8?B?dTNPemNJU2pCUDV1S1NyWS9YVW1XVXdlQTVQV29HRWFDVkNaVHFTYS84Zngz?=
 =?utf-8?B?WkpOQjkyNTJEL3RteFYyMGxvVlgwT2ZKNGg4Q1Yvd1MzWENyY2puUzlHL3Bu?=
 =?utf-8?B?dTU1aWtza1oxOThHWXI1YW9sUGxIc3k4b21aTHR2RXZJMW90N1k4VGVVeUQw?=
 =?utf-8?B?dEhyT3pPTjNsSG1qdEVVNi9Rc1d1K2MxVnlCNm9nRWJCUkZsVGcyL003OC8z?=
 =?utf-8?B?VlBzbFBRZk5qTXRVV29rc0Z3RVRsbVhnaEJLTTBiVzVJODJjemlWUFlDT09a?=
 =?utf-8?B?d25neUFpcjB5VFdBa0x3amtXQ2I5SFdZNmh1dU53UXVnTGNNTXdtWlA0M3FB?=
 =?utf-8?B?M1Qva3poeEIzdmpiS1dzMitxeHV1NW9wU0w4R3ZVMFRDb2FYT0RkUGYxZkFX?=
 =?utf-8?B?MTZlM015WjgwUzUxZWZDYjNRZlhwaVMxTm5nOTdwKzZXN3o1UWtDME00UjJw?=
 =?utf-8?B?aFVwaUtFbHRNYXg5R2NIMUJoNVJPbzJyczJXQVBMMGRWUWlSSkZaSHZlQ2I2?=
 =?utf-8?B?NmRxRnl5RGt1ME9sM2R0ZDBTSUtRamtpU2FYeldNTG9YeFcydFM5S0JSc1VQ?=
 =?utf-8?B?bFJycTNuRXZ0cWhQSTN6bEVmK0hKMmQwL2dHc2lSZ0wzVEI2cFRBMzFBdllM?=
 =?utf-8?B?dHJQOFVrcVVwSW1XYjByQTNvdDEvR1NsdklMblZtRlZQWFBwdGZlQ3NZSjhZ?=
 =?utf-8?B?bFNUK3ZFM1haSlVwZ3pNaERtMFkzT3VIZ3ZqT21kSGRYS0cwVk5uekcyWmtp?=
 =?utf-8?B?NlJSbVl3dDFSMldXV1hEQ2pqSEZWWVlTOGFiNFJEVENyYkVzTHNZOW55QndU?=
 =?utf-8?B?Uy8zZzF0U0lGQ0Y3TXVWR1VFTk9RTGk1ZEZPb0dFYUcwOHowZUZVSFliamR1?=
 =?utf-8?B?YytEbDM2QktJS2IzZkpDbFIwc2FWUGxjaytLRnlSKzJid1ZJVHUxR2FpVVc4?=
 =?utf-8?B?aXMzSFMzZzdQZ2cyS0lCc3VYZURId0t0SVBZNnNnMVRjVTViOHdUaFZqbE9U?=
 =?utf-8?B?ZHdqeXpTUkZpeWpoYXNGRy8xcFo2b0owV3Y4bUtJOGcyaFB6NjA4UVIvWTNS?=
 =?utf-8?B?T2lXaThpZjVrbXlhaCtJV1ZSZ2lXZGpKQWlCQWsyMDJIa2hUaGh4RGh5eUVl?=
 =?utf-8?B?V2pEbVlRZENvQlY0UmRISGdoc3VIa2xwWHYzTmMyT2t6UVV1MzhBWUhkMGM4?=
 =?utf-8?B?SHhqd2wyTGFrQVluUmNSVnJJZnBxNlh5QUVlTTlmRGt6dXFreUc1RGFvTmNh?=
 =?utf-8?B?NHZUWEUrMW9hV0VVb2ZxVWFHeklBOEQ2RVBSUVMzNVhuSlhQODNjS1R5dUMx?=
 =?utf-8?B?enArTjRxeFB0cTQ3Rkx4cDBMMXpOck8yNS8rYWlEdXRPVXM0V09ETHBMVjkx?=
 =?utf-8?B?bW1qMGN1QldYOHBaUkhEN1ppMU5CUFhVWWhLbUdlb2llVlBLZjJJNVZyclVG?=
 =?utf-8?B?WEUyY2E2S3p0eldvTGdLV295ZFhKV0NEeU1qeGp1NUhGOHMrMDhkcnNkZzds?=
 =?utf-8?B?a0ZFenJCQ285WXFrN0pTZ0RRd2J4Q0N4enlLa3hUTFFhV2U3TUJqdjFtajY5?=
 =?utf-8?B?elE4M1UzTU55bkxJREVKUFZwT1hQZmI2cC9yVTAzRVY3UFhFSlZYeEx1YW1a?=
 =?utf-8?B?bytxU212dVJmWExvVnJaaVhSaUV1WEFMclBTYm5YOHcvUGRvQStxVFRINFdv?=
 =?utf-8?B?S1Jad3ZxUkJYbUFJUks3SGNhbUcrTGhoRkpCUlZtNWpYanhFczg0djgxRmkw?=
 =?utf-8?B?cGJxcnR4YWEvVnZ5ZXpyYk53WDcrbTBXNFBrTmpEMzM5Vy9pNFphZ2RjSFRI?=
 =?utf-8?B?d3dxWGVHNkdQRE9ENU03alJ3TTkxQ3pFeWl5dHdHYTd4ckhaQS9PWGQ5d0xP?=
 =?utf-8?B?SERTWC9MdEMvY04vZ2Frd2NBSk41Qjd2Rm41SkVHZ3NXRUI4ditlYXU0dG9y?=
 =?utf-8?B?M1hiZk1rdnFWdHR6THAvdVI4UWFvTlBXa1EvME9nVjZBUGQvNTdqeC9BL25T?=
 =?utf-8?Q?3a50COI1K50g4fIm9hUnrUQRu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f728c581-99bb-4f00-3470-08dd4af2d854
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:21:43.0109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmj9B8Z5X5YPIUHHUjDbpMg+EzMTQxDgkxFqVjUpTzDRwy2CVWPZp5ApSV/S1NTSF/Opvb/dlgmh8516NM/3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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


On 2025-02-11 17:54, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> Curret kfd does not allocate pasid values, instead uses pasid value for each
> vm from graphic driver. So should not prevent graphic driver from releasing
> pasid values since the values are allocated by graphic driver, not kfd driver
> anymore. This patch does not stop graphic driver release pasid values.
> 
> Fixes: 77b5e447427c(drm/amdkfd: Have kfd driver use same PASID values from
> graphic driver)
> 
> Signed-off-by: Xiaogang Chen xiaogang.chen@amd.com
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 --
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 -------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 14 -------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 +--
>  5 files changed, 1 insertion(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 092dbd8bec97..236b73e283e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -304,8 +304,6 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					struct amdgpu_vm *avm,
>  					void **process_info,
>  					struct dma_fence **ef);
> -void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
> -					void *drm_priv);
>  uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
>  size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>  					uint8_t xcp_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 60062c10b083..ea3f7ee18923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1586,27 +1586,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>  	}
>  }
>  
> -void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
> -					    void *drm_priv)
> -{
> -	struct amdgpu_vm *avm;
> -
> -	if (WARN_ON(!adev || !drm_priv))
> -		return;
> -
> -	avm = drm_priv_to_vm(drm_priv);
> -
> -	pr_debug("Releasing process vm %p\n", avm);
> -
> -	/* The original pasid of amdgpu vm has already been
> -	 * released during making a amdgpu vm to a compute vm
> -	 * The current pasid is managed by kfd and will be
> -	 * released on kfd process destroy. Set amdgpu pasid
> -	 * to 0 to avoid duplicate release.
> -	 */
> -	amdgpu_vm_release_compute(adev, avm);
> -}
> -
>  uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>  {
>  	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 48b2c0b3b315..ef4fe2df8398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2578,20 +2578,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	return r;
>  }
>  
> -/**
> - * amdgpu_vm_release_compute - release a compute vm
> - * @adev: amdgpu_device pointer
> - * @vm: a vm turned into compute vm by calling amdgpu_vm_make_compute
> - *
> - * This is a correspondant of amdgpu_vm_make_compute. It decouples compute
> - * pasid from vm. Compute should stop use of vm after this call.
> - */
> -void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> -{
> -	amdgpu_vm_set_pasid(adev, vm, 0);
> -	vm->is_compute_context = false;
> -}
> -
>  /**
>   * amdgpu_vm_fini - tear down a vm instance
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 160889e5e64d..daa2f9b33620 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -484,7 +484,6 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> -void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>  		      unsigned int num_fences);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index c75373fd6ef1..cc5907e96ded 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1059,8 +1059,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>  		kfd_process_device_destroy_ib_mem(pdd);
>  
>  		if (pdd->drm_file) {
> -			amdgpu_amdkfd_gpuvm_release_process_vm(
> -					pdd->dev->adev, pdd->drm_priv);
> +			drm_priv_to_vm(pdd->drm_priv)->is_compute_context = false;

Setting is_compute_context to false is unnecessary because this code runs after the user mode process has terminated. The fput call just below will cause the destruction of the VM. It also feels like a layering violation. So just remove this line.

Other than that, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

>  			fput(pdd->drm_file);
>  		}
>  

