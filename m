Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC8AE9905B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 09:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E352910E908;
	Fri, 10 Apr 2026 09:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lljlIvlX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E13F10E8FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 09:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVgtR9cyuMDUDMNWlBKU9fwN25v3o7ndP8rQpmBfYYw/TbsK7xc1hjSkh4Ru4BE5EnvN+4rDfCpPFiiY4hMYaLZrg/ZRNm+/eKextHiuS69cmGLNs1AADj6mrf1hqkU/HzoV32kXraJbSJMe/Q3hGB+UDhrH3YrOLHXhJ3OxeFSH85CYg+PuIs7Z/+3qFh1ErLqzA/pS1jQv27UP8xp4XdT3xmdNB+Rz+2ICYOJJTSsAQhfS2WCYsRkj50RdE+Y6Qgl+XSI0YkTbtQ0Ucmw1Zuqfji4uzFdjuwxNemhXsDxGYytrEzFTlUhPwt271GcnccfbRyZmrjW95i8vMvFYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXQ6u3di9iDY5nGeatXNKkk5nhCAFKWDJiCyh2qFDQw=;
 b=YocZy+NQp6A3O80Qev9+rUxxa7x4U4xQqJ7k62cNPmK0BV+IvgPegxqYk/nSInas+2w47fWDpwLYh1oneli6GaGfZTWeXgUKdrXCQQVKsrFGbkNU7cbnPtCq3CHU83Q8DX0XD0W8Hm6mWwEWQaghdg+FAp10G1Vvl98QNr9DLw1v7sLGaPcok4hjVMR2AjRv1whZB7CGT1QKhgbV3/hLbc2krIQkjStG7qoOO7c1ppHlahcVPueQdu7AKbBZrmxD8yZJM9Jenccj9TZ4QcE9SlEeDeN74X8osi8hHVn0TisIhRXvpi/REU1p7WiI6PZZakCnWyePFji9YKll68ZLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXQ6u3di9iDY5nGeatXNKkk5nhCAFKWDJiCyh2qFDQw=;
 b=lljlIvlXgrpYDA02xRa0fFa7SZIagz/sI4akMNW/LLcEpB5WuqiNnfTQVJgzYJ8+tIzb3toAccAP35c533bfNuXe2sPrp8zOaa/dM/7dT4lwvzdGtD97MEXPW8Nf5jvdAnhrvBpiyZgcf8mSrHUqXfLpSxMajbSFW7/oUvPkY8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 09:04:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 09:04:14 +0000
Message-ID: <fbac9baf-b3f6-43de-ae35-2088d800c12d@amd.com>
Date: Fri, 10 Apr 2026 11:04:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Clear VRAM for all user mode allocations
To: Amir Shetaia <Amir.Shetaia@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20260409150315.1441442-1-Amir.Shetaia@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409150315.1441442-1-Amir.Shetaia@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: be2c8572-e092-4907-6a2b-08de96e02346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6RhHBGZgsMaqsonFiodk9R1DhfFlyzJyfVGnp+rwIUnU2Hg9JRC8iluFEuQ7ks+wPvGmP/6JoZ+TSPvejzoEIT/f2SQ8SHFQGcIMsj94Q6OpVDl72bTSMhFsOZj2k8Zs6Fypsxhc0NZ8O6cGMBLPPNH3NxwV22xo5Gvv9nkB9rS6Yk3wMbhWDSDQ7BDg+iRlh30kzLJnO5g6L5JEbnaDi1seCdK+UPXHX++OFUp82GjejtMB2L10jLTNV4Z8ksM4pS/PoteYvubj5G3pJ2c+CfxyBeZuJwotGpCXitaTnomgAqTwEHvrXq7taglwobyaAnXeEOm+KLWKNyjJxQoGp29lWz2g1iwtD37sSgGtyjppwMCnosYPJZrej6pKC5p4aHsIScT7rXzky3eIKbhXYpJL66QU3At8RLqi5wok9BP/XJSdiH+da/f8REyB6z+tIyKYvBxudH03hR5ry+Z6pyHh8WIumXZmXqKbEg1ffmnQalr5iCeIddF4ShxDQb9CGh+EPGq1IiczfHT+DzBKQTgChf2PKO6zfJ8UhhR1PRaoNUryLzzOLOhGpEqquVtYjR15kI9zl6uyX3yVbSID+WhjEwViMVlnNMaUyRepcuESeuDaqXDHpIR5ehOFm+tuouqeWrdwCUB6rTU3Rk4C7gAwRGSAoquBcsTAjAKVdHTgc0QLP5WosEMtad0VVmkdbn53R16F5+pwhZwnCvev4z6fpGe8qjxLZbNPmT6dZaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9uSjcxd0p3VGc0Yzc4SXBJTmFqUDl1dEhDRGJERTJQYk5JbUZoWk51dERH?=
 =?utf-8?B?SndhTExINXFwVS8rSDdkZmRUWGlGSEhQQktHbEI1d3VYejV3dGFwWkx5VG0z?=
 =?utf-8?B?L3lOdUU4UFRyeTZLTHdoOEhUWnZSaEJhTzZjdWF5YlNWUTRZbVROUWVPVWF5?=
 =?utf-8?B?Y1p0ZnFrcUlsYlR3YzQvTXg3d2VZTXM1dWF4ZmhRc0FhQk5nOEY2c2Rob0wz?=
 =?utf-8?B?anlvaGF3RmxhSWppcE1UOWRsUEZFemc0dTU0T0djdmVoQTZCQW1EVmk4YTZ5?=
 =?utf-8?B?dXpjMmRYUTZ4VWlDdTdwbXhhRGNld0V0QnQ3ekM2aEEzVnZUMWpPR01RNFVs?=
 =?utf-8?B?OFdtcGNLaEZUTHJsUVJ2ZEtoaHR1T2lienJSc1RBbm5IRUpSN1FnSHR0Z0Q5?=
 =?utf-8?B?WlB2ajdhYUxsMTIvamFIa3pvZ3R2NFhCOXRoWmRkNSs3N3hqTzJDaGtiWDlh?=
 =?utf-8?B?S0t0RFBaOEdrZVEvOE52NlA2RVMvWThwRk9TZWhLNmpMdjFJNVlHWjFpN2sy?=
 =?utf-8?B?YTZvMlU2YlFRcnEwcFd5KzJoOEZqYnY0R2RITlNwbTlLSmJFK0VyL3NaU0VS?=
 =?utf-8?B?WjZ3VEdwSlk4RUN2UVdqTmJORjk1RGdHU3d2bmx4UWhlTnd6QlA3eC9VdkJG?=
 =?utf-8?B?Z1E4ZmNOZkd5NU9sK2M5Uk02V1ZFdmVoa0V6dlhGT2ozdDVibTJJRlNKb1Zk?=
 =?utf-8?B?QU9jSWF0ZjZEMFE0bStlSjE4eVpuWGQ5bUZtSE11R0R2WTRvTFBpNnBWV05S?=
 =?utf-8?B?bU8raHF3bG5RdDM2MXdEWmtMMi9rL3UrMEg4Y09VQ3d6cTdLSnBrQ2NZMmRs?=
 =?utf-8?B?ekZEYU9ETHl5NWVNQmVRdkswVEY5c2xPL0JZWHgxcnM4SkZYYnRrdlBIZkZS?=
 =?utf-8?B?cVQ4OVc2NHFqNktGemtYa0ZjdkJ4NURsdVc0RE9QUXVadHBaVnNqUnNDT0E5?=
 =?utf-8?B?MHNVWU4vaWVWWkFZTjlKbzNiU3l3Q0FjSk1XMk1RK0xheTB4anBFYjFNVGdS?=
 =?utf-8?B?RWdldEVNeG1ETHg2aUg1Z0VyZHYxajhrTW9TNWpDa0lqZ29xblltYklldDlF?=
 =?utf-8?B?RFZZMzdvSXpjMi9Wak1lTXBRYVphbXZISjQ5ejZYYllGTEZQNDJReGhKMGo2?=
 =?utf-8?B?NkIwd3BPTVNtOEZZNGFzMkdOMzJ3b2I1MEl4cDNNdlY0T2FqQnc1TDR3dnJ0?=
 =?utf-8?B?ajJkSXNtVE1WOVVsS2g4emJPTGhjblhTSGR2ZmtvdTlqSVJodTVLOGdKRm4x?=
 =?utf-8?B?eWgxc1lnTlhhRVJ0QUxoeFduVjRmbURxNDMyZ0ZrMkF2WDR6b1dXdHBLRUJm?=
 =?utf-8?B?NmorYXFQRTdQcWlMVXJlZ2VETW5tNnRrT0V0d3JSZWNzR1hqTTYycVhKcGNC?=
 =?utf-8?B?WC96U2lYTllrbFRQS0hoOVV4M1VRbW1WY212dGxxTmtobC9MM3ZYU3lpYks1?=
 =?utf-8?B?VmNtTXFoOGIrU2VKRnQ2MUtZWEZYR0xkbWVMcVFRYmwxMSs2ZkZ5c2R4dEQ5?=
 =?utf-8?B?Y3EwVW9WTEQwNHZYS0NlUCtVMXc1ZVZxRG15VkJSQXBtaXJZL0hvSi9DL2NF?=
 =?utf-8?B?VTFJaU55cDE5NzdLQ1JPa3RwVGRkWEE0Q0pMSXFZRmcxMlAzZmlncVFONmZr?=
 =?utf-8?B?TE1UVW56aDBMWDZLSGp2VXBMOFVpWFhiM1paRjBPVDJrMUc3ZnVYb3J2dEMr?=
 =?utf-8?B?SXJzTHl0N3pTd3dTTU41ZklRLzhrYlhxcXA5cTZ1QldpdlNIVWpBN1VIZ09u?=
 =?utf-8?B?TmxDdk9iWGJQNlZrci9NRUxXREowYU82ZEFvOUtrTVBiU0J6SEVRLzRTRGNG?=
 =?utf-8?B?akVRNWJtbS9NYlNheHFLZFhVRURBNE94UU9CTit5WmU3SnJwbjVUWEtCdWgw?=
 =?utf-8?B?eDl1MlFxWHBEbElCYU5MYTJhWHhkZGtBR2prdW1yMThRRzJkaU8yaWlNWnA4?=
 =?utf-8?B?SnNjL0MvYXdWVFArYnhXcDRyRHJYRkNFckNpL3ZKUmJKUzdxS2ltZURpZDJI?=
 =?utf-8?B?TEV1MWtwdFRndlhnbUovMzJkMThieUdKOUJFNWdRVVNNOGdkYzRyY0VNMEJI?=
 =?utf-8?B?OUtJNk9RUmx2TDNsb2cwQ3l1dXM2dE0vRzZFeXZuYm1RQU1uMmlUUUZDMHB5?=
 =?utf-8?B?WjhxSnpZaEJ3bjVLdFRCSzgyd0tGQWsxWnpIeHhZYnIxOTdQOVZyZjk5bHR1?=
 =?utf-8?B?V1J0SnEwblhkSzF4NkZFbURpcWkxMW5IalcxUHVoUVZhb2JQeE9SVVNNRktF?=
 =?utf-8?B?QTZpRVdmL21Sd2pYV0w2N1l3VVFVRS85TVdJTEVkN0xtMmJpUGsrSDYvSlRM?=
 =?utf-8?Q?4gA1D/UyYRbxchvCHz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2c8572-e092-4907-6a2b-08de96e02346
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:04:14.3743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okBHXVbrHErIth6tKsqnsUoYBKhGvCoLNa4UXo7t4ehetV1VEyivhhne28JS8LzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757
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



On 4/9/26 17:03, Amir Shetaia wrote:
> amdgpu_gem_object_create() sets AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE
> but not AMDGPU_GEM_CREATE_VRAM_CLEARED. While the GEM ioctl adds
> VRAM_CLEARED separately, other callers such as KFD do not, leaving
> freshly allocated VRAM with stale data observable by user mode.
> 
> This causes crashes in applications that expect zero-initialized
> VRAM, such as RCCL P2P transport where stale page table remnants
> corrupt protocol handshake fields.
> 
> Add AMDGPU_GEM_CREATE_VRAM_CLEARED alongside VRAM_WIPE_ON_RELEASE
> in amdgpu_gem_object_create() to cover all user mode VRAM paths.
> 
> Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b0ba2bdaf43a..c704bc53946c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -175,7 +175,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>  
>  	memset(&bp, 0, sizeof(bp));
>  	*obj = NULL;
> -	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> +	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
> +		 AMDGPU_GEM_CREATE_VRAM_CLEARED;

Clear NAK.

This is intentionally not done here so that we are able to create a dumb buffer for the boot up console before all IP blocks are initialized.

It is already set for all other userspace GEM allocations. See functions amdgpu_mode_dumb_create() and amdgpu_gem_create_ioctl().

Regards,
Christian.

>  
>  	bp.size = size;
>  	bp.byte_align = alignment;

