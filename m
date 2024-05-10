Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C1CC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 21:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB9210E3A7;
	Fri, 10 May 2024 21:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i2aHgNhi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C6210E3A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 21:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9s1pX4LZw28ySk1fzI+4lNk13qNfqxzlhwKmVsETx/PldQNpBqx7Pyd8DmqZ91IBvODX4lqNO0hOK6YWXheHFq6bivvwrYdqYyG8gTfao+73KKOY1YnNNDtObRTEwb+Ptv8E25vL5nN1BpYBrCF0LN/HkzDCBTDfvMxQbsXgdnFvYYPBmJjR+41TEKjIp5pex4o0DrWrMlYUiPLSNKv3wDZWgjcC7jeLrCdrXUuxpzOLq/NjUN82yTyIIWOwFd0g3Gqx6MpT5iMWFKowSTCzwxbrJz+Ftjfg+3oUxe59ELbJQ5GNgK573FzdjMaXFG13OoIe00mKoUZ499ykVL01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaXQT7xk7qZHeKUGBc4LvfHomxCUDJZFSlNnBohpOgM=;
 b=LgTrJkGY03IE4aau7pv+xnpavqfIXb76xFgU1NEjKQJf8HEtrgMZb6AEeP8GKIB0q6N4N2YDjG88EgQlTtfFJa2hy8Tglt9UjcHI2KfEB+FH3zsXHwd/8Q3Y7S42R4O91kF5dYDzQ9QFFOwPn2vstg4N7nShTU7ch7xPSoP5ALtKHnOyd48GBNjD/BuIuj1yXIc3RZ0r+NdAWJZYHjQWCa0v4nofbArZCcURXHD1LWgQaqHJWTQvoAMQdVUJ6WN/ySDQtgXlV/TS9YEb5m3eU2dm10S84ezAxSE7m2kKh/jMGQ/IP9j+CQIEM9dpCab4P+dgRYiv1NuCaS57bDOfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaXQT7xk7qZHeKUGBc4LvfHomxCUDJZFSlNnBohpOgM=;
 b=i2aHgNhiQ7hbFCcLasaclMgNAv9hK4glWLfH2oaDUkJoANYf7Og5boL4lWg8OFjy6SU42aVfVJ+c2ofgFAzwXuCe8Lgv4q+Wpk7lyDfDKsdQwSy2goSkiM31FzPa3Sc+1FMr3Qha7oi3fpnfynszLOtgZpnbxZ+XwEJHC8jhG9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 10 May
 2024 21:56:09 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 21:56:08 +0000
Message-ID: <f5625a4b-ca23-47b5-9203-3d1b8a2e0183@amd.com>
Date: Fri, 10 May 2024 17:56:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Check correct memory types for is_system
 variable
To: Sreekant Somasekharan <sreekant.somasekharan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240510140611.536886-1-sreekant.somasekharan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240510140611.536886-1-sreekant.somasekharan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::19) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 1942d196-05be-4488-cd6b-08dc713bffa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUR5MU1DU3cyRVdCQ1BXTlZrSktBMmFQNmcybnpJczN3Ylp5MFdsTWlCdURE?=
 =?utf-8?B?TElmdTJIWWNwbzZaTmlMM0V2S09wSkwvNjViOWRpRW9lMkVlT2pLVzd3cU45?=
 =?utf-8?B?S2F5ZjVZMzNXSXU5NWswM3BsTjhPSk5qTTZzOTh1azFHTzlMT3RGckgraHZz?=
 =?utf-8?B?cDdEQy9vUU5vNWxrZ2k2Yy9jN0wyUldYc3NncVd1bUhVZXhkcHVaU1BaaU52?=
 =?utf-8?B?WlFHMDZIRTE2NlZZZ3FCUHZ3WVhyaCtuT0tsdHllYlJZSlVwMnFKaWpNbDJH?=
 =?utf-8?B?SC8yT2F3WjIvekVEajQ4OEJ6OUxsdVdzangzUlNncmNVNjZpMkg0YTF2SzI4?=
 =?utf-8?B?dGZMZTNRVjZ3elVhTTBucXZJdTVyTU5JeXVYQ09ycVpIdGw0VE9lRnZHWnI1?=
 =?utf-8?B?TWF0OEVTbmJEYmp1T1ZVYzdFOU10S3o2Yi9HdmowUDMzWWVjMnBycVJzOC84?=
 =?utf-8?B?V1cvZ1dYUEJTdGgyTE9MUHlEYk52UlRPenVuQVdyOWg1d3dPMlBGd3dsRjVN?=
 =?utf-8?B?c2VFK2hNWnVoRjZGWW5BVlZvQTk3QXVxWjFTM2dia0kyY2tVbkZobXRmcURU?=
 =?utf-8?B?b0t6S1YrelJ4ampWU2ltdHkydEhGN0NGdXA0azZwVEJTcXpzZkdzTDJsZmdE?=
 =?utf-8?B?Mit4cTVIWldqN05TdEExZmxuTmNOeTcxOERVQ0tzS3UzNndNZmdEbHVUNnBI?=
 =?utf-8?B?U0o0TmNkNldIUkZyMlNsTkhHejNzNld0TUE2TGJ6YzI0bEF5ZEwrMFBJSkVi?=
 =?utf-8?B?VEFhK1ZGSTBBb0gxZ2FhSmR0MzhkZmE0eENwSWV6YUd3UmpiUXh3dUVueFlz?=
 =?utf-8?B?WlRUY2xpMm1YYklzOHZWeVVybTBTdVNXSGkvSGQwK1MzbVdIMm44NjRGQnZw?=
 =?utf-8?B?VnA2cXQ5Q0h2aXVJWXhRR2g5VDhFK25ZVmJMVlFZTGtkMDNlUituQkR5QUxS?=
 =?utf-8?B?Si9DVmhGcWlDM1J3Q3BlajFaL0tmSmF4MXUxbndmNlE3dCtZZEU0NjdCWG44?=
 =?utf-8?B?bkQwcHlGVkIxTEk3SUsyMUd5b0xvQmFINlBqZDVtY3BJVmFVQzlmaXkwcGIy?=
 =?utf-8?B?U1lId1NZT210T0p2UDljbmZ5Ym50OE50dWNEbktLdEpaeXhMNFgzMWMyUVRw?=
 =?utf-8?B?dVl4VEgwZm5EcHpoMyt2T2gvWWxQWkFnN01KVWZYRE1YeDZjTmF5UU5ISW9L?=
 =?utf-8?B?SUFyQXRtM2o3a1R6cGI2S3M2K1NLb0V2WE1MaS83R3loUnV0V1U5emRiVjBC?=
 =?utf-8?B?aWFrems1Q1g4emFDckRSNVJLQk8rVUlCM3FyVTdiQUlsVHZzMjM5U3RwbkdD?=
 =?utf-8?B?b1RsZzhjMEF5b2hqbVlQVUJVZFl6djRPTWhZOEJjZ3hJQ3RJMjllSjBoaDFX?=
 =?utf-8?B?dC9jMnp4Mm1wRVloVFl3a2REaFZDSHVrQ1V2bjB5TmczdkNObTBHaFdxYlRu?=
 =?utf-8?B?dmZjY3NSak03bjZ5WVRMbm9SYjZ0WkZvUE5CazF3bXU2Mms5V1QyQ1VsYUFi?=
 =?utf-8?B?R1Zuc0R2ZVZyM3pEbmJYNW1HallRYy91TUluQ2tRQ0tEemJuRzh2NGx6eElH?=
 =?utf-8?B?ekJiLzRvVkl5cWorQkg1R0F3VEJMYWxzYkZJZWJka0NEcnBCOVptMWFjL2sx?=
 =?utf-8?B?RmdJQzZwc0s0OU9ZSFF6aHoyeG5BdmtjSGhXQTN0VUJEbytDREwycGdVaWdU?=
 =?utf-8?B?UEdDMjV2em5zRHdYMjNESUs2VkdvY1Q4bzFMbjhLZ3dGOE9meHYreVpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3d3d3FtakV5dUtrUUlUV0xrbVpKNWtpNzdRZTd5S2dHS244Q2Jjbk0xd3RC?=
 =?utf-8?B?OW1BME1uL0h5ZFNndEs0TTNFMld2bnhoNlZlOHNqeVZMNkhEK0VDWWNtL01U?=
 =?utf-8?B?OERnWjRsRytvOS93T0RESXBOYzdSemlsYTJXT0hBU3dHZWdIV0d6cHlxZ0hV?=
 =?utf-8?B?Qi9Bb0RQdFEwSnFDWmZzdnlNVmVpUlYxZEJHWjBYdzZqMzZxcXdpeGsxeE5o?=
 =?utf-8?B?NUd0enFIQisrdzhhbDY0ckg4MVdSbVIwaEsxVklTOWI3TDlqWlZRYXlZKzU3?=
 =?utf-8?B?cDkxcy9rVWJ2UGJSRkdaeEVlcHJ6a2xvWWVCMlJUbjlPMHhXeDEzM1IzT1hp?=
 =?utf-8?B?bFRHT3JyWHlRUmMxbFF0a1BSK1Y4b2swcHl1N2Z1WWF0bGpPSEc3NDdVQWVy?=
 =?utf-8?B?UE5RM3p2cFZkL0U5ZWk0UEdUdXV1ZWRSVGt2NWlVU0pqV2RTaWhPaENwVCt4?=
 =?utf-8?B?a2ViTU1WSHVnMzFVS05QVURTbnBsK1lrWTd3TDZocXFuOWtZNVNiOWFTMTBB?=
 =?utf-8?B?T09vcHJ6Qlk3V2FZbGdSVG5tZzFzR2tyYzBsOWE4NUZML2VGUUNQcmZnQXl2?=
 =?utf-8?B?dnovTmt1Y0xCVmdOelRXY2tnR2lUVmRYcUtDVGkxdjViVnJVQUlha2NDNjQr?=
 =?utf-8?B?S0lyOGpQemZocmdvOEd5dkVjSmxzL2FqenptME5wczl0UXoxMW5Gb28rdmZ6?=
 =?utf-8?B?QVdIUkYwZXNRdmZVVmdnZnVDenMvQ2xNYmNQN0k0emIrM0w5UEFFYjBSTHEr?=
 =?utf-8?B?dUZ5YU1qT0dNa0UrUm00V01YZjJBK2NPeUhSTzk1SjkyNDZLZXYrd1kxSWk5?=
 =?utf-8?B?MDJ0ZytMM1NIUytscThXV1I3WW1pQ1A4RkxoT1NPT3pCand1elFreGRwMFNZ?=
 =?utf-8?B?aWlJc1Ayem93VEZobWtJRk51cFZncmtBSjlseldGL3hwWTJLOEtyM21YK2J1?=
 =?utf-8?B?Q2FQbnNybit4YjR6VDI2d1JwMXpwbVdWQjFRMDFsOGx0NVk1MTlwMzYxQlZH?=
 =?utf-8?B?ajN0YnEzWlVqNSsrUUFJRlZjY3M0QjBaRnUxTjlOMGpaVmRIVzNObU4wRnQw?=
 =?utf-8?B?Nnk1cVUwTlN6cmZqb3g1L0kzcFMzNGhxVWJpczZ1bmwzTDZRN1lvK0l1UWVZ?=
 =?utf-8?B?VkNEMVNLSXhZN1pkZkl6VmZQTnU1OTBEQWVOdUVSaEpnRmJseXJsL01RUVdY?=
 =?utf-8?B?RUFnY1dmMGtMTE02M3VPMnZtVGUwMmhrY2FVNWEweHIwdnErNE5MWWxQMmwy?=
 =?utf-8?B?TDhMSDVTb2ptSlUrSUJVckJzWm1DdWJiamEyZlgrQWFtWElGd2tNTkMrbUtX?=
 =?utf-8?B?RlRncCtvWG5TWkxMa0dUVWowVlBOdmhaRnlSWnZ1dENvWGd1UU1ncDRoM1o1?=
 =?utf-8?B?WEd5d05nU2o5alMxdGhqUG96OUF5S1dhSUgyUUdKYXR0OUNyZHloMTl5MFhr?=
 =?utf-8?B?bW9FTlZEWm1zT3c2TXFQVDZPRlZzTkQ0RjhxWURZamVXaWpuY0lwMVErL05p?=
 =?utf-8?B?cUh3R1ZEbkIyNjVFM2pGakxIcnpZckNYZCtaZlNOUTFPOWtEOUJHWHFTRWpq?=
 =?utf-8?B?MFdQTG1yL2tmWWtrajlMY2dUUkNpSGJqWjdQeWQydXhYNlV6WmJCS2Jac0dW?=
 =?utf-8?B?aUhPajFtWVR2d0tDWE1Wb3k1L3QyR002Tk10TDFPcHk1Y1htZnFPWnZUa2sr?=
 =?utf-8?B?MktVUjRoOHFhdkwxaGJVekpDQy9xRGs0WGtLUTJDSlY0NjYwYzlWRCs3RDEy?=
 =?utf-8?B?d3picTBqdlo2Z2MwdGJ1TkhhVTBGZmJIRU80Wkl4cUMvZjhnellUWHduYzFY?=
 =?utf-8?B?RVJZWTZZSGRBQURmb1haWERvN3R3UUkycmFuM1FRWUh4Y09HT1c2Qlh0K0tF?=
 =?utf-8?B?ZWh2bi9YVnd0bDNSWXJYSlYweW4xcFZyZkFyQ3FRZ28za1hQYUtDUndRZjEz?=
 =?utf-8?B?M2U5UWpmQXVpZmpJN0pBS3dQZEREUEpOMzh1MERZd3hlMnM1YTJoVkZPRmVN?=
 =?utf-8?B?eXRqajJxa2dpUDk2bW1lL3hNMzFsYnlQU2RQV1hLQWgvNGlSakxTbnhWc1hL?=
 =?utf-8?B?SC9ESkhjbFpmeklLM1hsM3NGMTUxNXJ0UnNFVjhoOTNBSngvSURGRkFCN0R3?=
 =?utf-8?Q?kfEM0l0NhsSrXT56ZbS98U9GB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1942d196-05be-4488-cd6b-08dc713bffa2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 21:56:08.7429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmKwZbvLPfxIIerysNaE0CxD/JV0SkTMB34/npCvQ4qlJ9lscf61uvDu/rXAuF64N90wH5YycytZxxBcHwf4rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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


On 2024-05-10 10:06, Sreekant Somasekharan wrote:
> To catch GPU mapping of system memory, TTM_PL_TT and AMDGPU_PL_PREEMPT
> must be checked.
>
> 'Fixes: 3b01ca1b860d ("drm/amdkfd: mark GFX12 system and peer
> GPU memory mappings as MTYPE_NC")'

I don't think that's a valid format for the Fixes tag. It should be a 
single line and no single quotes. Other than that, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index df0363ad1a51..6eb370609d01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -495,7 +495,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>   	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> -	bool is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
> +	bool is_system = (bo->tbo.resource->mem_type == TTM_PL_TT) ||
> +		(bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
>   
>   
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
