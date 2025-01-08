Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24489E7719A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 17:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C9610E900;
	Wed,  8 Jan 2025 17:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HS6/7LoB";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F2610E900
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 17:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCJL44brygSsGkwR0b6YPENck6ou0nsUG4cu7wQMO3OmC1L2np29due9+lJhB2oy+cszOsrGT0nxkLPGK8xcFOjEaD0cYpbzYoDXwoqGhdH5BYBNoRXxzKORpqTOTCh760DGXZ83OEZWsx1Q8+22rqxYZiTrkoImKlHov5l9pa3kd26r6M/nAQYb+1B+6tVq7bva779V/GebNDdc8NjrNV/XhGPO6giSO5eM8P4Fr4Mqn85uTeohsyJUG+bQFsHE38dJunuUFivW8b258JrPVdRe2rHyy764lvXgjppD2ZJNg8Y83Gz7cOgELmccWvWvkeico1s2Y7MsOAcvIoKdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfpYdsyDa4X5lUb6fpDPSYFIOU+6eF5+kui2l8J7Xtc=;
 b=IKcp1Ch0/UDz29b2WT8aNcu5A/vwZp2piMsTf3sfUmFVeiTCXl+TdPLxmpm0uPilkJwqf9c9YJeT5C6Wbbh4atfKCHWc52PlEGX315XZteUKn+sy8KYjQ6aziCOeBayqKunDqVOMZDr+rni5mILIXDJ7VPWx65rMxKabQKYjSVTnsL1AwODok4fnqhtKtVrpbWAza7r0xlC8pY5EizVpKPvnLnsXiGcAt0GPG2EOhBD0cUTkFcrkouREXwwBkWqYa+a6tyRJ2HGy5abQontEYTR2PFqJY/lpJKHi+CkkHjjhWoxnr5Ov76MHt5MVokCOeox8VeA1ZBAqV3P46iqg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfpYdsyDa4X5lUb6fpDPSYFIOU+6eF5+kui2l8J7Xtc=;
 b=HS6/7LoB1ou4y4Nte2aMJRH3HVvBqvkR/u0G0IjMvaz6slllb1lHTt9HZRD7+1Cipy9AgIG4UsLrC1e6tsj2fPyYe7V67FeY2+zzkJ0WjAnZyXwAKP/djKgKv+Vno6zxeGnqxXfx0tluBQk7qb9y2oHVBgCZmol3TlBY5E6fPt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 17:19:28 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 17:19:28 +0000
Message-ID: <9c6f3c11-0782-47f3-ba7e-eb6d8ba66d31@amd.com>
Date: Wed, 8 Jan 2025 11:19:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/13] drm/amdgpu: add a flag to track ras debugfs
 creation status
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <014a704e91787b123203d568256861000a7fe558.1736344725.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <014a704e91787b123203d568256861000a7fe558.1736344725.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::17) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 566e2230-37bf-4f50-a3d9-08dd30089b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFZ3QUpzaUJOSFlJUFdzeDNTMkM1dFYzTmt0QzR4N3ZzSzFlSDNka3BRdWln?=
 =?utf-8?B?TWpmaTFPNHN4Y2Qrc0ZRdXB4aFVRTmZlNnM1T1NFbit1RnpqcDNENGV0ei9Z?=
 =?utf-8?B?NXlZLy9RcEsxcGVqa2tEbTQ5MGE5TGU4Z3pNeHJ3bnNKVms2U2l1SWhyZW96?=
 =?utf-8?B?NEI5b0pqem56d3gvRDJOTFFQQjF6TmpEQlMvQWtldWk2RlhSVnNLMFNWcjg3?=
 =?utf-8?B?bUhXdWl1THZ0U2ZaYWoyZm1Oc0VQMkpVYU5WZGdUSzVERFU4UG9PaFNqYzdv?=
 =?utf-8?B?U3Z6Z2UxclBpQXV4Tk9Jc2RzMnM1ZmU5RlRsaEJIT1lrQzNscjlyRTgxaWlV?=
 =?utf-8?B?dko5aWtQZzJnM3VwNjF3Vis5OWltNWcyWnRqVGxEM0phaW8zYWw0TVZqV1JD?=
 =?utf-8?B?UzNqTFJzMnhMVUNKR3VOWFJPWHdDeEVGd0owVUUzT3lTOUhHdUtacDQwbzEr?=
 =?utf-8?B?NE9WNFhpVEorTVNlcDVVUUFkdXREeG5tb3pMczRNaTJHUlk5L1FhTTdxVW5R?=
 =?utf-8?B?MXVSTXFzL2ttb1ljbFBkVUJhdFBMYmcyMDBmMDdydEZvQzFzeVBMNGhla3Nj?=
 =?utf-8?B?Z1Z6VC9zWjJkN2JkQzhCbk1pbFF3V092RGFKRGtiOW1IanovN2RKRjFpLzVr?=
 =?utf-8?B?Tk43bWNoYWttVWlsYVd2aUlxdmNCVHBKUlhXTG13Ym00NXM0ZW5IT1IxTEtw?=
 =?utf-8?B?NmFCcjEzM0JXM1lQbFNlWm5CVmpiM3NUalFuVU9zc21vRUt3UTUyZ2xrcjNV?=
 =?utf-8?B?c2FhSVhINm5MdkdHQUE4RkJ1bEZWSDQwRGFoRkhBS29zTlhHRmRWS3JzN01D?=
 =?utf-8?B?QklGK1lhaG5PWjJtd2ljZTNob01HRmVYMVhyR1VBS3J1V1MwZDNBQ2dPQWFC?=
 =?utf-8?B?eWpaNGJJUnhTNXo5M3VwSGdKaGVFQis0VXBhQ20zK1lTSTVFSWRCR1lvakky?=
 =?utf-8?B?VGd5RkpId3BXNnFBZlY5bGpHdHNqT251ZURtc3c0VkhORzNML0l2MjduNkpU?=
 =?utf-8?B?V3RmZHhrM3pYb2ZyZWpqYWtZVGtyaWZoblpTYzBiKzdUS0xhRHIwaWVmVlZt?=
 =?utf-8?B?YUk4RGFIUkJyWlpxTUpsNktTKy9xMXZJRzNyM3BGZ3ByUWJvdUlhay9OOUV4?=
 =?utf-8?B?TlNvZjJuMTM1NnlBWit3N0VtcGhxdDI0eTJ6aHJKOU01czhqeDA4eXMxcTZN?=
 =?utf-8?B?NG12dTRkNmQ5WW55SHd0WG1mOXBVcFI5SmJxc1BkNVcxblNJMVJ3OEQxWjAw?=
 =?utf-8?B?dHlGanFtYWcxaGpDL3hYK1BxWXpVR05ob2RUM1kyZGRnL094Z0ZRdjhSZXNG?=
 =?utf-8?B?ZnVUL1NNY3VDVGRJdGFTYUxSLzM5TmNISDlJS0FHYjFnVkZwK3k1TExRZ0dl?=
 =?utf-8?B?TnFjaEJqWU5uK2kvWGhwd1dUREtMcCsyT0NWU01RWVdteW5PaW5NNjFTRmsy?=
 =?utf-8?B?SUtPY25KYjYzRkhRT1hoWDVBSzNkRjlzeW8xbXZHTjNwRVVPYU1OZkw5NFRa?=
 =?utf-8?B?YVhqY1cxM3BSa0ovMElWemgzSnl5RHhFdzYvdFFEODMwMW1LZ2Q0TzU1NExR?=
 =?utf-8?B?RVdtQzJMeVVYblFKdzAzUGk1NzNTZWJxNEsya2tkUGszWERNN291U0xlNE5y?=
 =?utf-8?B?aEQ5MXNoRlVOTnVKZCtHK3hVRDNxQjlvSWRqYU5VY3JObmRyOFZMcC85Zm84?=
 =?utf-8?B?RFl1ZlgxR1JjLzhvM01lN25LUnhVYVVCUUtIUHlJTVkyTHRoNUtkcUhLNFFH?=
 =?utf-8?B?S2FQUWhpTUQrU3pOVDJhYnpWaVJQVVYyaUI3c0dGOUt5cmRXUlFyR1ZKd2h6?=
 =?utf-8?B?UmpXbGRzdGdwUG5MMFBWUEFMeDBNalB6akdYbDNKSEpVTUhndVFFTVMwdFdq?=
 =?utf-8?B?N1pnWHlBTXZNbm96MzVrdmVJSXFmREFISmVpZyt2emlpNllReVEyK09lSzRF?=
 =?utf-8?Q?w7nqVECxAgk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVA5Z1ptRGxrVTE3bjQzc3F2bEJRMDJvT3JvUURNV1lMcThLQmc2RjUzVEg0?=
 =?utf-8?B?ZVpMbnh0RGVraUNkK0YzWm15STFLVFAxeXFFalRUNVk1dmFGemhHSmdoUWVU?=
 =?utf-8?B?UkZ0bDVMeHVVVCsvaU5mdERkT24rNU40LzZ3UVhnL29McU16R29xdHFHYlNM?=
 =?utf-8?B?TVpEcDQzL3piNjM2SmtlaVUvSWJoREdNWHBRUjNCbDgyalhEUmRhOWFVWWtE?=
 =?utf-8?B?M1ZKcFNNUitNRkdIMUxNNjlTanlkc3NaS2Y0ZGd5ZTNKUTF5RkluZndUVmVx?=
 =?utf-8?B?Wmk5S0xQU0dpdVZyMVI0QmJidzJHZEFPWTYyVHZFWUYvbE0vODY3ckF1aVFP?=
 =?utf-8?B?YkRKUFhrdUxQWlhYcTFvTnNiTUZGUEhyRm44UnVkSXBaSDBVOW1hK1NnelNu?=
 =?utf-8?B?TWNsUXJoZk9VRnZxNnpERTJTOTI1NmN3NGdZdHRLT1gvemdOcnBCb3VycWtG?=
 =?utf-8?B?SkEwUGNaZG9ndXZwQ2VVVU14RXkxYkJRZUpyZldiakdYWU1NVXFNUElvVUpn?=
 =?utf-8?B?TlRybXc4b1kzRHp0WWFlTnlPRmR1ZS9jR2Y4VC9CUXRtMSt6Nms0N1ZIbHc3?=
 =?utf-8?B?TjltZTRNVmN4eXIyZGdjeitaRFVSQy9MTUxGTjBrRHRnQ2VLZUR2cG1FaHJM?=
 =?utf-8?B?allzakdqS2xlRXZDZ3ZyTENnbnhseWpnUDJQMzg5YzBoaldEdENlakg4OTJn?=
 =?utf-8?B?VmxoYUtOVnFuZTNYQ3d3cmk5MUw5Q0Z4V0JzdWduUUhhaVR1bTh0YjFUQlRv?=
 =?utf-8?B?OEtiQjFhTEVuWUZyTWpBeXNjUWNlMkpsbUVkd254NXkrMjRXaHVBeUtyakZP?=
 =?utf-8?B?K2tkVndzOU9VNElsMlVXb2pmY3N3MFRBaTBDaDQ3Snd2Q2dkSWIrMnhwVnVE?=
 =?utf-8?B?OVNoQ3paMWVSOVVOZGl1RDBYZDlPdDE4d1JOckxyTUJMcTkxdmlvSVBwaExT?=
 =?utf-8?B?M0xJVjFGd2hNOFF1amFCY0xISTB0SXM2UEMzbDFJUjE2R3p5cCtoZDF5czh0?=
 =?utf-8?B?bExvWU55VUxPMWJwa1ZGTGtzNlhURTJUV3F5MGhBNlJPU0d2YTN5TDBvTHJ2?=
 =?utf-8?B?MjNTVkxISGs3TWFQMFNEREpPMC9wYXkwVEpiY053OVJCY0pUMituWml5c0tk?=
 =?utf-8?B?S083T3ZjcTR4VXh2YnFXbmNsbEt4TXpZK0hzMlYwVHdkbkVwLzBNVFlzczRn?=
 =?utf-8?B?TVY2bjJSL3ZEcC8zMWRxVks2YmZjSk1hdUN4OWFReVVWc0tvZ1BuMzdDczZl?=
 =?utf-8?B?TEhsZnVwN3ZRdTFzZ21iTWpsU1h5bkI1enNXUE5YYVpCU1pJN1k0ck9JYkkw?=
 =?utf-8?B?Yy9XbGpvbEdZZkluRzIvajV4MHEvdEZVZ3NEWk9Nc1NhUVloSE50YTRsRnY5?=
 =?utf-8?B?a2QwYTVVclloUm01K01RRnQwWHFDZzJHbnlUWkNHRWZJTmcwMnJxV01sVDQ4?=
 =?utf-8?B?L1BWY2NML1Z1WEFCYlhQRHdpZmVGQi8zRGJBOUdRQWwweTNuckNNTUVJdFRS?=
 =?utf-8?B?TXhKWEJ2WXB1NmtvbDFrU2ZNWFVycU9JU3EydlYvOHFVOFdhRVlvY1FJU1pJ?=
 =?utf-8?B?YUlhNW1wTXI5dnYxN3gyeDFzbTBGTERuVEdqN1AwUnRQZ2hKMG9LVTRSaTBE?=
 =?utf-8?B?MmZCZVA4R0pnQ3k0NVIwUzRrWE5maDU2ckZ1YmgyU3ErcEx0Vm5Vc01DM1kv?=
 =?utf-8?B?MnRFQ3JVd21NUk1ZVlpraW1nN3hralMwWCtramtVNmFvVDZkVVBacElQdGJC?=
 =?utf-8?B?bktlMEdKQXR0TU1OSHJGd21rWTVYMlBsMCtLN2RKdDQwQ1hzbEVYMC92OEVM?=
 =?utf-8?B?enZITkVUcHJUTDNJdy9SSW9EeFdueGMvNlBCMkxmeUhIT0cwQWE3MHZuMTlW?=
 =?utf-8?B?NFIzbDZnZ3RCdEMwMUQvMnhyRngzU2JINWVCYjFJYnF1TUtYYUJJQXR1N2Nv?=
 =?utf-8?B?bExkeWk1cVpUVnVESGdFZWhVY2w5bzVrZEtyVU50dnZ4cHpDdXpoRWlXK093?=
 =?utf-8?B?VkU5T1B6WUR3L3FvczBDUlJjMm00cHZZb1ptdVVsVHlOWExFbkhHZTVKVmtZ?=
 =?utf-8?B?dlZHWWdaT0xGL2NVWlhpc0VMZ2Z5MEZHem1iY0RRMEJWbWZJeTZYdjNtSE9V?=
 =?utf-8?Q?bmPFIYaa8LFlmtwXlzEfxhI1Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566e2230-37bf-4f50-a3d9-08dd30089b97
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 17:19:28.6281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otGT6NLg01ohkAb++lKaxUjqEROOcEy3ZunePxjltddcUONpZ3VOY+fs9ynYMFfy8N1dof+C6ZzTnGFRyEmtYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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

On 1/8/2025 07:59, Jiang Liu wrote:
> Add a flag to track ras debugfs creation status, to avoid possible
> incorrect reference count management for ras block object  in function
> amdgpu_ras_aca_is_supported().

Rather than taking a marker position, why not just check for
obj->fs_data.debugfs_name to be non NULL in amdgpu_ras_fs_fini()?

> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 32941f29507c..2ef7d3102be3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -378,7 +378,7 @@ enum amdgpu_marker {
>   	AMDGPU_MARKER_IRQ6		= 6,
>   	AMDGPU_MARKER_IRQ7		= 7,
>   	AMDGPU_MARKER_IRQ_MAX		= 47,
> -	AMDGPU_MARKER_DEBUGFS		= 63,
> +	AMDGPU_MARKER_RAS_DEBUGFS	= 63,

Any particular reason you jumped to 63 in this patch and then counted 
down in the next one?  IE why not throw it at 48 (and then 49 for next one)?

>   };
>   
>   #define AMDGPU_MARKER_INDEX_IRQ(idx)		(AMDGPU_MARKER_INDEX_IRQ0 + (idx))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6d52e22691f7..efd72b07a185 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1996,7 +1996,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
>   {
>   	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
>   
> -	if (!obj || !dir)
> +	if (!obj || !dir ||
> +	    amdgpu_ras_test_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS))
>   		return;
>   
>   	get_obj(obj);
> @@ -2007,6 +2008,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
>   
>   	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
>   			    obj, &amdgpu_ras_debugfs_ops);
> +
> +	amdgpu_ras_set_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS);
>   }
>   
>   static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
> @@ -2134,7 +2137,9 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
>   	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>   		list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
>   			ip_obj = amdgpu_ras_find_obj(adev, &con_obj->head);
> -			if (ip_obj)
> +			if (ip_obj &&
> +			    amdgpu_ras_test_and_clear_marker(adev, &ip_obj->head,
> +			    				     AMDGPU_MARKER_RAS_DEBUGFS))
>   				put_obj(ip_obj);
>   		}
>   	}

