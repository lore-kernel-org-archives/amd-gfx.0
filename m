Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BD1D2C555
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 13:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1393310E68D;
	Tue, 22 Oct 2024 13:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmPbaA8s";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D694810E68D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 13:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3Tj5y0aoS+OE7XcjCXgYjoBYg13uMO7pOENEs3Biq1dqb5m3Qi2k86PrqIetUhys2uXxdVTUvY5TFLoEbK9oa2mvcyM1bjLa/TKw1BRMEdsrtew0iYQSzc6OjaL2lmIIqswBJlTz/wA1tFsLuPXodm6VuxTVaubOqBcPHlvnL0zBtC5YCYEMHhfoqWEqTjSqCL/D9IDIYF+YkBneiYAu+fXM3D+lj7owKptbuLlDtSV+NPvVcy4IRSBkWYic6nHKqSabAz2B1Y/nr894rmj8viKUzLpELPYU1OnEo7HH3ZgWol2VDuVOZuZBunnK8B2wRLD5zUoNRJd7IEP58AkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJIxMiUSvJjRZ5czNqtaZR2IrWf/bCf1z5BqsQ32xQo=;
 b=QZ3c0ptO5GlG1gJowbp5thg6tLF+4sUvu9AS8sMeMC7g/lXKJqz4gLhR8kC/Lvh0o2NPy72ZtysihbEWqtMJwWl8IpUqZBnvOyxTDUDqjg7fZ+lyTwfpGNP+KbcgOhf8QDhiFwTvJQphtACLziHb0oA4koNelaPi3DOMAcvEOKHj0+y1mZuoHhFprrKN0K4F8CsfhMICeP+CUwGjJzB4RQFTMrsITJulMMLaBwxUvCyN1r+n2vw5csQiGG46yC3d/dF/BVOa0bTQkQuZinnQczisnoy+Hk6YPko6ZltaEZvnSxO46j+pZAaAIk30Zo9tumERNzmHuyLQrYhokege6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJIxMiUSvJjRZ5czNqtaZR2IrWf/bCf1z5BqsQ32xQo=;
 b=XmPbaA8s7kpWhh1Th5mSCSkzufiP8Wakw95gQzg5glw0Jr6GK2+gh88YzielYVOZvjwvrxgxeVsGZ0jmCm0KdPWLd+1CYkYjL3JSMa9wCp+6wLc/NWbBGWoI87fSGnYnx97wXavlL39Y0f3xldonCTvmX+dL2sILrR1cnywBw5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:53:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:53:29 +0000
Message-ID: <c88173ac-85a1-4110-9ac9-1b1b570d0960@amd.com>
Date: Tue, 22 Oct 2024 19:23:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: handle default profile on on devices without
 fullscreen 3D
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>
References: <20241022135043.2638637-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241022135043.2638637-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::24) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: f86eb5f1-f2ea-4cc7-870f-08dcf2a0e893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWdFcW8xYTFpalFIeWlNa2ZyKzZOM2F0K1dlYlFmLzRadGI0TWRBTk5kQjdI?=
 =?utf-8?B?V2sxeXhmSlp6SUZpVnAzY2w5bTdiNlhaSTRUZVR1cXBIRlBiSlFkZDhxSm93?=
 =?utf-8?B?cVc0c1pUSGhMa0xPSzF0cUJRV21heGJpWFEzVmVZYURwSVFzRzEwT0c1V3dt?=
 =?utf-8?B?ZDZwaUx1WWVUSWNEVUNDdUxaZG9uWFBhN2RLSG51emV2UzBlcEN0Y0NuVW43?=
 =?utf-8?B?TGJ1R0djU2xlYVdmVEdVM0MvQkx2S0xmN0xuZ1JHT0lkR3cvbytxVG85N2JT?=
 =?utf-8?B?RCtkaEJSNlY1M1BhMWltWTBtcFlmWDJ2RFlYRmI5REVHalBzVWhuQjZWazFM?=
 =?utf-8?B?UlMvQ2dUNW1wQzFpQ1gvWHJxMExLa0lERkZGOXNBVFpacjdmNU1iemdsRStK?=
 =?utf-8?B?RGpjSGJiZXdjYWFab3BhNlprNUltNTFTRHlDckZucm9ndVZlcE5uWlRuSm1J?=
 =?utf-8?B?L1dvM0VhczNmVk5zNSsvYm9YQ0pFZmFVTXFyK2NiZGVJbTVIY0NTVlFFMHZG?=
 =?utf-8?B?VUZ0b1VZRldsOVVnd2dpSUNHYlVKMlV5RE45MVIrR1F1QzVPRElwNVk2bUFm?=
 =?utf-8?B?SHFKTnVTUHlOYW9RbkFGSnBJazNQWDZxbXlHc0dnMTIzU1pLaVZvNElScTNS?=
 =?utf-8?B?VHZMVjhmK0U5T3lNV1RiMzBkOG5RNjdmRlVMcVpaQ0JJRHlFMitmNGZML09t?=
 =?utf-8?B?VVVZTElNek5HV1gzMjdrNFc5RjdDZmhaZ2hMOWdoY2dFUGFMRUp0azlVVUly?=
 =?utf-8?B?Y08wc0pXVkZCQno1aWJFK2IwRnBnNm1jdW9nZFVPTTd4bnJrU0FCTSt0MkpC?=
 =?utf-8?B?QWdrUlRLVFEwSE5KeHNOTFpVbU1XWENLVzE2L1pjeXBCdGh5MEk4VlpveExy?=
 =?utf-8?B?d1h5UDlCY1BUQ1NMbVpielB5bEJHckxtcEIvWTc4VlNFUm5yVTJxbFhPRWRl?=
 =?utf-8?B?alpvR0pISlAvN0ZqUzVzUVJIUWFPN3VPQ0JoSWxraHlaTnNpR2pHT3Jrbmhy?=
 =?utf-8?B?aDVzVHdYUlNUeTFNK0lKTE5BalVSWFJRVDhRL0pRUGlkVTR1S3lGalhyYUxl?=
 =?utf-8?B?UXJJeGdwYjVrVEJjM21JRjJGVUhxZGZ1TnJremtSZ212QXB6c2daKzB4NDRC?=
 =?utf-8?B?ak9Nb0h3VUpOQ3NvQ1M1YTNGaVNvZXJnb3FYZC9HZi9xbmZoN2srYWNBNTN3?=
 =?utf-8?B?UDUwM0FzUnZWdXhEdmtPV1hHME1uOGdKK1NUWHdVWEZWUHcyWlNML2FQZEc4?=
 =?utf-8?B?NkRwVVFTM3hSbksydGw3MmNOdzNTSXZtTDJiSGFlZFlCTjRxSmtHbVdmZHc1?=
 =?utf-8?B?RS9rV1QxUDdNdStuVE5WVHlhR28wWkhYS3Q5RkZhakkzOEdmdTEzS1RiR05a?=
 =?utf-8?B?ZlRmMEtoUW1HNVhQMXRzN281a01MYTFaaVkycUsxdjRFOTlPMnhSVTlBQmVU?=
 =?utf-8?B?WC85NWt5SnM0UlcyNSswTXY0cy9sajlYUzlReFlDakVLS3JLcXpuYUpQUXlV?=
 =?utf-8?B?N2dCYkkwNGFGUUpjZFNUcHhSNE82NS9PdnltK3RIazBZbHJKaWo0QUlsOENJ?=
 =?utf-8?B?WlYxbDBmejdEWUEzQmFDZkVaYjBuM0cweW9IOTkwN3ZxMVJQbmp2WTlqWEhN?=
 =?utf-8?B?RVQ4RG9SWkwvYXMxelQwRFhmR1FXN3QyQ3dGeWJxcE0vNlExaUJEb3d6Wmtv?=
 =?utf-8?B?OWZPYUc3UkFuUzVwZlBJR0EyY3V3cjhQRHFqb3FwWGZxTkp1WFhqTUVjS3lK?=
 =?utf-8?Q?JVUpynLJ3zSz7FjZgVvfg6QJ+wdrAntI6oXiI+V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlE4YXliOHFreUwyVjJVb1JUbGUrRW9jZ0c2b3FyUmpWMUhNTFh6L2NxczVL?=
 =?utf-8?B?eGNGeUluZnU0MllhbTFtL3RUMUx0bFB3ZGRPVHNLRHpkNElKK0tNbkN3d1lM?=
 =?utf-8?B?eHlxeTUrL0UzdDdxU1ZyTUlVcE05VnI2QzBGS05HSlF3bldsa0dUT1BxQU1R?=
 =?utf-8?B?aDh3Tlp2dDdIZnRmNnNxNGxPZ0RScTM4eVNCWU9ZYTYxUTBmc3hITzdCcHJy?=
 =?utf-8?B?VS8rY0FQUU1iL2I1WjNlNUhTcGNncHdLa0dna3EvNEZoU1NtblB4QllNVVdC?=
 =?utf-8?B?NERUeFluM0lIQkpxcFo4cXlMcnZnN3lya0gwaXUrb1FFUmRVRmZHdEtodXk0?=
 =?utf-8?B?MlJmQnpyNVVhUUIzbnNKZjRkdnRpcmttVWZvSDhFb3ROVWJ6dm5MM05SV0t3?=
 =?utf-8?B?QkdkVWpnNHVQUFMrc1gvUmdVR0ZOZlpVMlpkd3BTREptcVNGcjk3UXp5ZURi?=
 =?utf-8?B?aHhXRGg4dkxSMjRpa2lnbXZxdEpKRVR0eUxwSXY3N2dyaCt0NG9TZ2dDUlJC?=
 =?utf-8?B?SlhJUWVaQ042RWxMVTgzekEyN2NjTGk2UUNvOFREMVJRZDlObk54QlRzOURZ?=
 =?utf-8?B?UTV4T2NjSmlNcXN5YkpYbytLbnlJcW9MK1dKbEF2Vmp2NjlKWXpCdVRNQ29x?=
 =?utf-8?B?dVpUcFhDYm1CdGczRE9qSlpLbDBoQ1NOZXN2cnJwaWJzMW1Va0VadDR3Nk1S?=
 =?utf-8?B?S0xQTFpUYUtXbjlMSVg3TlQ0cGlLUC9sb3N6dk8wZDhiWGEyL0I5MHFMU3Ju?=
 =?utf-8?B?Z1d5elE2UkxacWRnVEE4aDZBbFJRRStCTy9yU3UyYktNc0tFMkV2OUM2MC9Y?=
 =?utf-8?B?N1JLalBuSzBPaFBpOFB5T1k2RGFJeUJ4RzQxSGpDeUJQeHFxZzNqZnM4aXJX?=
 =?utf-8?B?d3FDSEJwdmdiS2VCWDlmTWdlR25uelpFd1N6TUdUeXJpd3dRYUtjRDU4K2ZS?=
 =?utf-8?B?YVZicCtwUklzUXE2L09iT1RqS2RhdG9lRkRFeXRhT2VVQlh5MmdyS0UxOFY2?=
 =?utf-8?B?QlhlYlpHL1dZRkJjV1FKL3JzKzYvdzlUakwweGRwUm9KWnBsc1RHR3Y3dHRR?=
 =?utf-8?B?Y1V5cVB0SWhqVTJzbXRTbFBqZnBtb1FKR1JURmJVT1B5bVFvcDVYanJNT0xt?=
 =?utf-8?B?Wno0R2FzWm41WmpEOWM2NjFVQWdaVW9ETVBpNHh5NVBDYXl3OVAzTXp6YUxS?=
 =?utf-8?B?QVAwNXZmWnR0Z2p0emJxbXlzZ3JTS3UxTzBLT3lobG1MejllOURnUWJRc3d2?=
 =?utf-8?B?NHRVcEFZbnVubXE1cExyTU9zMExNc202T3k3cmFBYjRXaHVGaDhQTlZZUm5o?=
 =?utf-8?B?REJ5Z3NrOElKK29Takh4ZGJQMXZqNTVLQ28vNVRTazkrdndRWE1Obk5LbmRL?=
 =?utf-8?B?bURKRUplaGp5S3BlMzZoRlhGVVJ4NS9oVHpxZkU4WnpFRURPYkd1UmY3Q0hD?=
 =?utf-8?B?SzZRM205WEtiRWduQWtJUGtlK2ZuK3B0N1pHTjNLcmpBVzlnYnFMNloxMGRh?=
 =?utf-8?B?ZFl4Y2RMeEpQWHB5VENtVTJ5OGlzd3pLcUFvTHFFVndZM0lTM0ZYRzVUbzAw?=
 =?utf-8?B?WlRJS0hXaFZWbHFyY1RKRlZ0RmFDYzhNUllmdm9LcVdJbGI2WmNpT1R6SDY3?=
 =?utf-8?B?OUFjbFovUGtZMzgzSDBGbWY3RVQvSDkxSURzZnFaZkRuTmZDVWpZOTV3NTlj?=
 =?utf-8?B?dnB3dmRTWDZ5ZHNHbVdoNkJxYzlYMlkrZG9IQjZaa2NWeElxQ1pWbGFyUnRG?=
 =?utf-8?B?TXZoZCtEOHV0M21OdUE3a0tqbTdJVkJhSUFsb3BwZDJZV0ExSHJoOHRRaTR3?=
 =?utf-8?B?UjAyU3AvMllCL3RwQzJsR2pTRTROL0U2ZTNYVDN6SWZIWkpkY2ltVGM3MkQv?=
 =?utf-8?B?TmUvTC9hUm5NcXV1enJaeFVrUjZEOTkrbEprTFk3VjFMcGpmOFErWUVhK1VX?=
 =?utf-8?B?UFpNblZjZEpkdEVUcTRSVVlERFYxa1N5eG0vRTM0MDN1R2JURHl4eStkTVp4?=
 =?utf-8?B?UkE0dUYrQWM3cmFmYUhwcXlvREFwbjdYbUwxNTYvVndhWHcyRVk3d0JQSkhj?=
 =?utf-8?B?eDZRU1NCMGtWdEd3NEVRSDBNeG1VUGNFeTBvMHNkZllBQnRLdkp0UmFkVml2?=
 =?utf-8?Q?jgHjO3t3rZgiWMytTIrdQsSNQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86eb5f1-f2ea-4cc7-870f-08dcf2a0e893
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:53:29.4020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AafEFf4eDfU4YMog2lDbFyoLMUBixhSs8K83L8XMGMn0/30byDGuRrchMYMsivGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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



On 10/22/2024 7:20 PM, Alex Deucher wrote:
> Some devices do not support fullscreen 3D.
> 
> v2: Make the check generic.
> 
> Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index accc96a03bd9..8d4aee4e2287 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1236,6 +1236,14 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
>  	}
>  }
>  
> +static bool smu_is_workload_profile_available(struct smu_context *smu,
> +					      u32 profile)
> +{
> +	if (profile >= PP_SMC_POWER_PROFILE_COUNT)
> +		return false;
> +	return smu->workload_map && smu->workload_map[profile].valid_mapping;
> +}
> +
>  static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1267,7 +1275,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>  
> -	if (smu->is_apu)
> +	if (smu->is_apu ||
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>  	else
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
