Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642FAE99055
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 08:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF5010E156;
	Fri, 10 Apr 2026 08:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mBIjbYSn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E724710E156
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 08:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB3D9Su638ZgiCEQdteSJbl2srF9drhxYom4D0u0mXDcKkxr0StjqP14aLBK6xeyByUpEUIWRCM0kr8JApAOsY4b1Wl0usSbuY84IBXeVIl0OcvrvBMgaNVBaJpY4IDHkl6EymPimUIgDHaYDZKmeYk1xYIr8okzX1nXwLjekoiSIhI3qLr9vgQjyDT4gQuy+QIub0tIKGtzI/lreAg7RAv65lyYL4H8MAvHOLxMpMvKTdp3jAHJq6ie5PKLyY1sF6WUk+yjw6bpmwe7DgH73vYRXT+EF2m9Yw3oWDG40LO9ewOjBymzMhc2eFTT1SlLrCurFPrtGx4ijYAJ4CCvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRMzScdxBgvxaQ+aha7RPdr0KOk+X7qR6YZg97wS6iE=;
 b=V4y+UwTf2HVML4LmENqxbNKp+yNMPxzSRrZ+zJ92ex+CIDVwz10K4WUU1/MzazARRBoXo4EidmYrWSF/rNTuvd5pcjgSEthhUsJqKPzNRKZgStuee4FKlrgZl7xILXs5GGOJwRzVbKHArriUmq0vm8Vbx3JC6d5SlH4DOwUJjQwyZPb/7gu//OEYz3j/wjcJxjibnuUD3ZcO2UgxpasPl8g2/MgKIm54IpshxE7ECs+jPODJsgPcOfuX354xrfxaRCaWhqSJjkAbZiyA9OtSHHH8VW/cqDR5DCcT8+8gVl9qRpU5JY1jLuraXQYvO2iyGwwqn3khZf9zK5S4vR4l+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRMzScdxBgvxaQ+aha7RPdr0KOk+X7qR6YZg97wS6iE=;
 b=mBIjbYSnYrFae5Wg1DAhiqU1pADdHIXTAzEOB2CQMKXAoqgXzn5M1UBUz1VGXetvnHIpe2mdDN+pc6mKrB/Ru7PcXeB6Rh0B8JQyBQ/8JJvVn+iCMbIFEb8b7SJ1yMR7HfI8lH4xTHQkDhHJAm5J/dyqdGT8CgL3d4BK783DFYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 08:47:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:46:59 +0000
Message-ID: <6808b9ef-8e3b-4ffe-8f7a-172ab45b1aeb@amd.com>
Date: Fri, 10 Apr 2026 10:46:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Clear VRAM on allocation to prevent stale
 data exposure
To: Amir Shetaia <Amir.Shetaia@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20260409141918.1317087-1-Amir.Shetaia@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409141918.1317087-1-Amir.Shetaia@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: c9350df6-632a-4789-cae1-08de96ddbab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: yNovAwbIsLje76OiA5mNBnpYh80ZMsshAsVozbFQlaAB/2igjHIeQDhoPUKILSe4lAMNM9XZSkaF9TBb5OhlBJZgZtTp6WWS+Kos3tNf3yNXegYRcc6KDjR24nMlwLyPtEfloOMkks6+tSNDz035+ig6FfL/tsZLpO8rbEO7IK2VTbBnQNd0lu1r+4/mRAk5cbl/o6A+AeNcUUrhfov2jkW9s7LIbnihy2AgTkm4BdkeR3ObHdJBZGbrMlBuB4stOK5ase45mb08FYERy4WMhD3uFyeurIazfa8ACnyVdAlcakC0yIFewgQIKAzgRH45W24tCgsKGDn1bWhgAEownb7cIc2j/RknCectvCnktweSk49ywOSUIpgn6pwyjjv4BNnaLEKiRh7MAwuQMVzoS4i/psHUEjxE4UO8oX98d+I6kv1HDHvv1IjTKax5aVLvQetD3owUUrDaC+psMfGkwCJ/hSvURJrtuKKtKcnp6fzP77gCqMW+bSErE82+0mqVKJUOvOON1aOvtuKO4Dp1goXZftTnQDsXkfF7ZD4b1BlbRNXNNficQuSnp/RA41pkfLGv5RzP5fwCpnFTAPCB99NTHzP1ul7LCMRZ+mg2tskbn+S+5x1gGc0JFPM/gcYZvC4/qgQV9Xc/GrfRJS49ghn9Bv4VXt+ZK0SsQbP/vZwD2enGjvea8WE2284mlCkJLXfSCdhfEzYXl91UQ2XNsI2bJ8GyXydknS/JgXIj/VU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHh2OGZac0o5V3RScTJqYmxrbzFRM3NseGw0ckJabUxJRGF4QUFaRVQzQ2h4?=
 =?utf-8?B?ZVgxdlFwM2xGY1BFc1VtaEJ2MCtmRVVaQjJwUnA0bWpmMEJzOHIrWGxLQVhs?=
 =?utf-8?B?UnlHWDlPdkJMRlhEOXE1Rk5ES0pkaEZQVDlxSzdWckp3Sm9iTTBZM1lzeExU?=
 =?utf-8?B?LzdrQkJjSHBzdnBOQXBkSVc1bEIrSzd5NlZDWk50aXJjS2ltODZmMS9MRkFX?=
 =?utf-8?B?YjNRUGhhWHdqbnZpcDJNRW9xQ1R1TjBSem9qeUhXQ1Mzd2lJWGFjc0s5aDJN?=
 =?utf-8?B?N3EwaXBUd2dSS0doQ1FHK0dLak55UlhQQ05TaDNobGJuWUtJTFhkcEkyZkl2?=
 =?utf-8?B?MS9xNkk5T0JpbENIMkM3VjFndjV5eUh2dGpDT2VpZDA4SzlSVENQQjFBVDR6?=
 =?utf-8?B?UUtWUWFjSy9DZnFBTTgzVUNrbzJXT1lGYnpKSkhlUVhTTUxOQmFlQVdhUDdH?=
 =?utf-8?B?emJSZ2xNa0ZrNjljZHZ4V1pRVUJZY3pDTUtNM0lxNjRoOE5nV1pja2tiNEtY?=
 =?utf-8?B?R1NHckFheEJ6ajgrRkIxRDhjWE9wVVZ2YTlub0RoL1d1RXp0Nk42NjdBZlA1?=
 =?utf-8?B?Nm1yM3A2VHMzNEJzOGxwNXdudzlUazRtVmswQmpaZGFySmkyVWd0ak5aWjJK?=
 =?utf-8?B?bWx3aHF3NnpSQTl6U2lGVCtkU2hMTmZVWDI4RHk1a2cyTlY3QiszL1MwMTZ6?=
 =?utf-8?B?czRFSitUeC9aWFlramJ5OXZ6NTVDRDVOSUF3YUp5c1dLOS9vZlY3WHJBM1BS?=
 =?utf-8?B?ck9rdUlHSXRtWkdHamZUSkhkU00rZDFRaGJJWk52elJZNUpVZ0lQUVBEb2hV?=
 =?utf-8?B?QUNibVB2dG9YK0pQeEN4TGF5azgzakIwY3ByN1pRaHVhWWxtamdickFDQm03?=
 =?utf-8?B?a2ZKMFBZS3BuaFoydWVrOG1JRXdYUCsrQ2RiY3ZFWTJWMktPT2NWTTlJTS8v?=
 =?utf-8?B?NDkzY3lCRXNURnNTb3pzUWU5VitoeWJhcnpBTHl4d05yY1BGc2I2UXVpbkRt?=
 =?utf-8?B?RW5jdGdDM2lSbVpCbkx0NzQ1NnNSNHozZzB1MTdjanU4c2V4cStHY3BPbFll?=
 =?utf-8?B?Uk1DN084REZ3YmFpMTRnRkdXWEhPeFJER2hyb3pwWjhyTCsxL01ZYnM5bUQ0?=
 =?utf-8?B?bDhQY2J1NFFGNnhTWi9QcEdSVGVhZm02cENrUEFaT290eEVyU1kwbnZTSWIx?=
 =?utf-8?B?cHNCS3EzVlA1dmlQNnZVcnhkYXF1aC9zZmlCeDlGMU1CMHQ5K3JRRktPTzVO?=
 =?utf-8?B?N3EzWWhPOWc2TUtua2JuTU13aHk4c2l4QVljS1dVV0VVdlhHVzc2SlFjaVZk?=
 =?utf-8?B?SVB5ZU50Y2k2c3FSaHFjTllmOFRQMWNZak01ZzA0Mmo4dnlEaXBBMlptbXhn?=
 =?utf-8?B?SEs4bWFlUXc2dlpvbGJJYzhLVVNzak1lR0dDY2JVZ1hTcUplTDI3NzJycVJC?=
 =?utf-8?B?NDRHS3VsUDhpc3ZCZjNyVHpqbXRPSHlYV3IwNDNURWg4L2dpdStGU09yQXZI?=
 =?utf-8?B?QXo4cTN1cUpFa21pM1N4UEpFR2NZdUJGRW84Sk92TzdrUHNmU0JpazN4anhB?=
 =?utf-8?B?dHZGV0FWdC9PbU5xemRNdTMvV2d1L1FSNWd6b0xqQ3ZpS1o1VGpyRStoMG1l?=
 =?utf-8?B?TXVsRkRvQmpxUU5xQjNLWDdpOUo0R21ROGpXaVJPcElLTkxqQVNBQ0xPQ2lq?=
 =?utf-8?B?Y0FKWVdyK0lvVGhIQWtKT2dRd3daYUdTQ09UYVpHOGRsdHN2K1VvdFd1ZGIw?=
 =?utf-8?B?MmpFcS9pbEFYOEFYL3ROMkpPTG5LWStnNFhhNGlPT1h2aHJpc3NiVnFqYzNk?=
 =?utf-8?B?WklpNzNyR2VDYUtlQWtsdkVva0lYMXpsSCsxMEhIZW8vdDQwYndTREdYTGhy?=
 =?utf-8?B?Vkd0Zk1sclBtdnBtWS9XT3U1RHB2WWNIT3RNQ1UrcG1USjhTaDNoMHJKNHhL?=
 =?utf-8?B?cllUWXJiWVhJMVJHWFVqbS9hbU1NZ1dRL1JGQ3JlRnNwZDZiS2Z5MjAzOGFp?=
 =?utf-8?B?SE5YS1VRcUYvZzBoSDEwZFlJbEdTQmhWSnN1QjFpVDhwUkdBbTh4cC91ZTkw?=
 =?utf-8?B?WGE0ZUU0UitoSHdCUTZ3VlBJcmVHOTdyMVh4RGk4UkUvcVU5U3RoaFVIdGNF?=
 =?utf-8?B?ZS9oTC85NnBNTDVIL1JDK0lORjlDeUhYRDRwVTNSWVlJN3I3ZUZid1dhMlJS?=
 =?utf-8?B?dlpOczUzMkNQUFhqTi9yQXppY2h3SGFBNlduc1Vvckp4cGtDNzlTbXJFMzRt?=
 =?utf-8?B?ZWRNaUFBQlh0amNjK2pxN2lWdEFwQi9OREt6MFBmQzY3eE1FTTNsRTN1dmkw?=
 =?utf-8?Q?QW3w4cwmr8GL8M+hHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9350df6-632a-4789-cae1-08de96ddbab5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:46:59.8703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aoP/R9NWNUaxaiWaceOUPVytKD7wejMwWjXqq9zH+t1yL0jZRqqWPj/VcEvGUAY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

On 4/9/26 16:19, Amir Shetaia wrote:
> KFD VRAM allocations only set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE
> (clear on free) but not AMDGPU_GEM_CREATE_VRAM_CLEARED (clear on
> create). This means freshly allocated VRAM BOs contain stale data
> from prior use, which is observable by GPU compute kernels.
> 
> The GEM ioctl path unconditionally sets VRAM_CLEARED, but the KFD
> path was missing this flag.
> 
> This causes data corruption in applications that depend on
> VMM-allocated memory being zero-initialized, such as RCCL P2P
> transport where stale data in ptrExchange/head/tail fields leads
> to HSA_STATUS_ERROR_MEMORY_FAULT crashes.
> 
> Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8a869fe41acd..7c01492e69dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1735,7 +1735,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>  			alloc_flags = 0;
>  		} else {
> -			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> +			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
> +				AMDGPU_GEM_CREATE_VRAM_CLEARED;
>  			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>  			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
>  

