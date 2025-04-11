Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D6BC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 13:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA5810EBB4;
	Fri, 11 Apr 2025 13:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7boEuYF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2D810EBB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 13:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRK544L/VVozXx3kMUomoSXl+Cc4+U89rDxrL6DCMTVUCYEQD/xeihvp7Hu8vXmsx44E2kmK+fWUDV9FlREf21trGq3930zn2FPs+1pkqanYYP0HeNTbfjpfnz76dBIlIdSOD0kmGK6WrFd9jKkB49XOxFg1WsPeMmKIA4AXb7pPAwtU1bL/oKw7m8LgSPaTQkt7m1FMHE9fLT43Xe5ZPClH908ohWOSYnT+zrPFeq7YU2BrlMW+7D7YGC2MhGcOO/qlgxJvGlzMyqGmO1WnCgZS0KV29EyGh2lUxI1ORi+qM4mTA6zvoU5OrAuJtQ0pMo7KuPmaIRgGoWc/SN/uLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZmtwuEsl4bfYrPvJsKI+4iw9rji0OunT5jM8S5pWB4=;
 b=E3Aj/5qTJzTPYIgVuqlcKI8i2mATpKHurjC09c2sWW+T1ytT5fkO8QVLlAXFfONp1tXQ2zuwP+G4/NM0msFu5t8bW/Ts5CnlzOlOLRExUSOvJj91W1CSzH6EO1FzO8ejTzgV7Cdhx2+B1+YhBiHLB0zU608DdfalgK4wqPC4dowLQ8jHQYyRgUmNaHm92h29ynTquDL/fsjvWytI7bkEUVp8KIezPNXLloaXg07mb3v2GKXaw3fES93eHfcYOf5eYHIATQmVgko/XN3xdZLl4xmLX0YBNiLSm1Sq1RE3nvWpWltQy/iXLB0afa5Is4qnReYm8idOJ12muyzKtjFm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZmtwuEsl4bfYrPvJsKI+4iw9rji0OunT5jM8S5pWB4=;
 b=E7boEuYF0pd6G82ZhjB9tGg0/CxplnNM1cbOHU/5eFtcatid6itZVLioXSVyLP6r0H8i1i5WVDla9fqnbmytPkxwao8av0bUhePZzLyTKJzlPNWIcBTLEKC0RBIAwMvuydFNhTQ37sinTm589rsQWMlFq6U/QzW1gS68aLRSoPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:06:53 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 13:06:53 +0000
Message-ID: <26c2724b-732e-4849-b24e-bbbc4845343c@amd.com>
Date: Fri, 11 Apr 2025 18:36:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu/userq: rework front end call sequence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
 <20250410181138.2287932-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410181138.2287932-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: d9949da9-fe4c-48f2-d075-08dd78f9baae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWFWeXgvYVJPOFNCVlZ3a0VGQlR5RTRvNmhBMWt2dk16dWV4bXlhR0I2M09F?=
 =?utf-8?B?REs2SjEwaUcyYzRyOGc2WEhIUG9qc2RzR1ZBT0Q3NjBKRzh2OVZxeWhKdUdG?=
 =?utf-8?B?QnluMW90L1VXRVlHdENibFUra01wRnNQOE5sNzA4bW9xSHRjczV4MTJmMGJi?=
 =?utf-8?B?NFlGcmo1YUVVU05jZjBCU2k2Q3V1bENTdHJibGI0a0FrY0tBVGxzRTluejFi?=
 =?utf-8?B?SEJaTXVGUVE0T253WXAwMGhDZXVLNU1HZE9zQUxndFBNc0lzblhQOThZc1FS?=
 =?utf-8?B?VldHekFtUEd5a3NRTDFEM0FWbzNpYmJxMUtpZWprTFBpc2ttbUM5LzFzcTZF?=
 =?utf-8?B?NmhuRCtpMlFpV1NMaWh3OWZ4OGJ0Q0JVbUV1V3VXcmZmSmNkRjFLTnhXbmlW?=
 =?utf-8?B?YlZLMXE0MDUrWXoxWEU4M0dUeEtBdzZUN1psNlk4ZzJWN1ozd3pvdFdLZWpp?=
 =?utf-8?B?OURaRmZWa0FoY1RXVVNGcHpEZFZrSTU0Vk1jcmpaWUZBYmNoQkxRWU1hVXl4?=
 =?utf-8?B?Z25QRjZMYVNiSG9aYm9TcWxuYXlVemFWMk9nQTNZc3dsSEJGd05NZklPQVY5?=
 =?utf-8?B?dG94QWZ1aWUwdUQyQW5DZmdObFdCekg1eGYzSHFoNmdCL2FRbGJHOGdWeU55?=
 =?utf-8?B?ZEtXU1BpWHo1NVU0dXM5MkphMG11THI3UFQ5WWtXWXd4ZTRLRXg1c0NjT1Z4?=
 =?utf-8?B?VGZQNU1TWmhMVWdmdzRRV0VpK3pyYUhrekd3ZGJzNEVqcDFid0hlYTR4U2sr?=
 =?utf-8?B?c1NBUlhMM29ScUZBS2prMzVoNy93amZxZG1hc0RSd0FwNStiYzVNcW5lNk9U?=
 =?utf-8?B?elFlbTBuOTlpNDkyOWl4RFhhTzY4MEJYUnppcDNPQllObGdGdW9tUkY5S2Zw?=
 =?utf-8?B?M2s4TytLR29jOERpU1lDcSsyZkEwL3RKTGxUakFYT0c0RGs1c2xNanMwZEV6?=
 =?utf-8?B?RVlkRG5kQktYbHpWdjZaQlhqRkdlSXlHeUV4MWZCa1J4QmF5Z2hyR25oM1FK?=
 =?utf-8?B?NnFCUGl3N2JKR3grTHFMaUQ1V0NvdW1kc3hyZU01OEFoRE5aYmFaWFFLZTMy?=
 =?utf-8?B?U3JLRFpDUWJMK0swRmMwL2tBd0R3bzJzSG9BYUY4UTBSUG1PSC9sbUZKQUFL?=
 =?utf-8?B?TnVpUUtrSS94V1BRN2JqK2ZkMGVEVGhFblJ1Wkdoc2JxOHFQeEtPTlBUcGVq?=
 =?utf-8?B?OUY5YkY0SU9qR1RUQk12SnF5NDdnTW1LWGE2NEFzRmNXajFNU1M4d1lxWFk3?=
 =?utf-8?B?M29sOUJZaVk1K2piK2NHSWZqU3ZNWFp5RXNwbFlXait6bldWbHU2VGkzKzlB?=
 =?utf-8?B?WmJ5bmZrdHJyMFdSMUUrVVVQcVJYRS8vMWdhelJtb01jSllPQzJrbEtPN2FY?=
 =?utf-8?B?aFpuQ2pmTnp0bkZ4Wnk0aG1sam9hWktGNmMxKzE3b0xMZHdRWHA2K3dRZmlW?=
 =?utf-8?B?bmhhNllMYjcrNkhoenAyWmlXQ2dGcXVHL09zU0duVzZwZUdqTEEzdWFrVzhQ?=
 =?utf-8?B?OUdBUWhXeUk3NysrUlNCekR0RzFSZ1ZwWHVxUm15a2VrckZ6VWs5Zjg4RFJB?=
 =?utf-8?B?S3Jra0taYzI3dVJIU2lacHpJZXdYM2Rsak03T1hhbzJLYWt6SmF0Y0xleWND?=
 =?utf-8?B?bWxXOWEvejNFMEFkUysvNzJJWXZBU2NrTEJxQnNQWnVCUHZkdTI2VEsvYkFZ?=
 =?utf-8?B?SXF5NzVpbS9lbnI2VE90NFY5bXlSYUE3aURLOU1WRUJVbDVCTGoybzlnT1h5?=
 =?utf-8?B?VnI2eVpkSElJeWlpd3RSQWs2UDI2dkJJTFlteGRvZGdhQ0JSNHBMMnJtL2lk?=
 =?utf-8?B?dWFuQmppeG11WGgzZyt4LzV4cHk3VGk2V3k2K3dsYTMzSjhOZVFnUENJdEdI?=
 =?utf-8?B?U0NHS2wzSUphUnhSUlAvbm81RmdCSVNEZ1hoVnlRKzhjVWluU21CUzFLR3ht?=
 =?utf-8?Q?j9eBAUz0rlQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZQUkEwdWVYdkh4WnMveXoxQnVKS2Z3cTl2MDFuNHNFSXZBalpNL0lFZndy?=
 =?utf-8?B?cWlaS01uL3VrQVg1RU1yOVhOTXVxdHFsTlNqM08rQysrN3dOenByaEphYm5q?=
 =?utf-8?B?TWxieXI1SGkvMUg1Y1JoVVd3by9tT29RcFp5dHY2aTV5OS9LS3dONWJkUzlr?=
 =?utf-8?B?VDNIb1MzQ1ZZcFUvdUQra2dqaW93SzJzRmxLQ0Vsa0NXRWVYOXlINkxkNk8z?=
 =?utf-8?B?QXhLZnZNMHpPOElLSG5tQzBHQ0JtVTYzaDBMUmx3dE0yNmNSd0pSQ1JrMWpZ?=
 =?utf-8?B?c3Y0YUgyVyt0eERYMU93VSt6di81VmlPKytYeFdCckRqcVE3bmttMlVXT0Fa?=
 =?utf-8?B?b2NMTzlmSmF5YTVvUkRoSi90d0MycXQzYXVnTCtsRmt1S1J3L2ZaUUp2dzEv?=
 =?utf-8?B?bVpvaDVyMWhVQkl2RFZBVFJzNnZqS3RCUDhmdXhQcXJ4WXJ6YmlTY3NIQUZE?=
 =?utf-8?B?dGtoZHdqM3J0SlJVRVBlRHBaUWcwWGY3UklLL1RnQVJkejhhOE1NNEtGS25t?=
 =?utf-8?B?S0cxcjc5WXRlQ0hscmJwYnEzRlJIK0hpakhveVpPY3IwdWJESW42NDlsRHYz?=
 =?utf-8?B?TWpiRk1GaDhxNm1ZUEtJNmJveW1qamo5Z1BhdGI1OXJkL1NCS3BvQlo4RzZv?=
 =?utf-8?B?NTRWQVRkcUgxeWEwMWk4dWFxYUx4VlRVdGd0THhuTnNiMDd4N3JocFBQOC9m?=
 =?utf-8?B?dnVGbzJTWTJXT2dDaDJKLy9ZWlJNUE9lM1ZremsyeXFvTGZJaE94eVhoNUVH?=
 =?utf-8?B?Tm5hNEIyWStGeXdmaFNjY002NG11cDkrTzlRUVVUZkhUcGVPNWk0blJ0RURj?=
 =?utf-8?B?TVNicVNJOW1zY0RGQ1g2bUV3ai9ZOWVoVjdsc2diOU4wNHlGSnN0OWtLL3JC?=
 =?utf-8?B?OVc5RlEvK1hHZm5OT3hzMnFwVmRBQXJQZU5YTFV3Zks2akRCdEMvTDVzeHg5?=
 =?utf-8?B?Szh1VFBlSm9lendhT3crZWJYMFcyWENTNmNmZ08zNEI1MUc0YXJoRG1aOGZW?=
 =?utf-8?B?ZzJFMld4UHI5MENzTmxldUk3TTVUVy9LTGJMa1RNa0VHTnhWOGR2UGwxb0pQ?=
 =?utf-8?B?N1BlUi83RWFXd2xqRGlrU0tBTnpiRW9Lc0srdmcyZ1JNTXV3TzFsQm1SSGFV?=
 =?utf-8?B?MkZuSnNxTHZQWHMvRm1HOW1nWGVNMW9ZSzkrMUFEY0wyYlI2UkZSYzFQWVBV?=
 =?utf-8?B?clZFZHJneUhhUEZmTzNCdlk2ZXlPSU1aUTRkTmJQanVKOTZBVXI3K1lWaTVu?=
 =?utf-8?B?K2hhQmc3bE5iRTdZTFVnV2tzeXQ1OWl1YVpvVFU5R1BVcHR0M1B5dTlzc1Zy?=
 =?utf-8?B?cXk0Z1JqenQrYXFRT0Yzak1hNzhJZXVJSHVYRkxneHJybVZNUUhkY1RXZjRD?=
 =?utf-8?B?MTNEbnF2RXZ3eDRYNVB6V3poVnk5UW5wY3ZBUmlwOHpBeWdZQ2NKU0kybWF0?=
 =?utf-8?B?SHNYZHpLeHU2dVNkUjNsQ3hRaFg5eVFyVXN3UlFZaFhkQVJwU3VQRC9pZ1E3?=
 =?utf-8?B?d2hGMlMvVVlubHRSMndWNUdiVWpIQzlxWnk0Qm80c1ZFZ2pnVmgyWWQ0dVhy?=
 =?utf-8?B?SWhhc3R1SFlhUDdSbG5XWWkrazRPNlZscVF6TXYxZStyRC9FK2Fsdks5aWJQ?=
 =?utf-8?B?STRDRUpJdUNTOVp4dXE2WitLTHdqVVlZMkNYbkh4Z3pLQU4vUUhGSnFEcnJC?=
 =?utf-8?B?bThUeDZCclVrQlNUWkNvT1NTSm43c2d6dUdqSitKUVpJOHkxdU56WS9ZNWx4?=
 =?utf-8?B?dzF3TjBsYVM4bnZNRGdIazRMdnR4QVlSSE1xWXRVbS9SVFJLRjVkNTc5R3NV?=
 =?utf-8?B?dmpueTYxM0pjUlFlV2xadmUwcFdjYUdub3FhTnlrbTljWjNWNjZ0eGx3R0Iv?=
 =?utf-8?B?d1Nwa0Y5bVRHejBPSkJLQ21Tcmh4ay91TmFRUUJWTzhySXVIYS9nS3c1NTli?=
 =?utf-8?B?c3VCeVRuSlE2V2o5VVYwZWVoOEMyeVM1ak5Eb0NzTDdSRWo0MGo3a214L2gz?=
 =?utf-8?B?V3dhY1A5Nm5jZ1Y5UkhLelJBblFiWmxudXJsRXFMeGVHZWtyOXovNFZ6UkZm?=
 =?utf-8?B?cXlUOG9xNDc4V3dJRHB2R1F5cXljMC9xOFltL3hZa2Y2TU1jK0J3b28zd3kx?=
 =?utf-8?Q?8l7Ny4plN4L+iRihTq1t6QQ29?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9949da9-fe4c-48f2-d075-08dd78f9baae
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:06:53.4418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlEpQ1hU56auVXYiBwDt13UacyvqwKK4X8Z3pboIddmcOS0qdvPppGWePMibH/bAOqMc1XK8L7JdMU5fuvZ2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/10/2025 11:41 PM, Alex Deucher wrote:
> Split out the queue map from the mqd create call and split
> out the queue unmap from the mqd destroy call.  This splits
> the queue setup and teardown with the actual enablement
> in the firmware.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 17 +++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 10 ----------
>   2 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 2be1e54b78997..c3873041ec942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -263,7 +263,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   {
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *uq_funcs;
>   	struct amdgpu_usermode_queue *queue;
> +	int r;
>   
>   	cancel_delayed_work(&uq_mgr->resume_work);
>   	mutex_lock(&uq_mgr->userq_mutex);
> @@ -274,12 +277,13 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   		mutex_unlock(&uq_mgr->userq_mutex);
>   		return -EINVAL;
>   	}
> -
> +	uq_funcs = adev->userq_funcs[queue->queue_type];
> +	r = uq_funcs->unmap(uq_mgr, queue);
>   	amdgpu_bo_unpin(queue->db_obj.obj);
>   	amdgpu_bo_unref(&queue->db_obj.obj);
>   	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>   	mutex_unlock(&uq_mgr->userq_mutex);
> -	return 0;
> +	return r;
>   }
>   
>   static int
> @@ -364,6 +368,15 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		r = -ENOMEM;
>   		goto unlock;
>   	}
> +
> +	r = uq_funcs->map(uq_mgr, queue);
> +	if (r) {
> +		DRM_ERROR("Failed to map Queue\n");
> +		uq_funcs->mqd_destroy(uq_mgr, queue);
> +		kfree(queue);
> +		goto unlock;
> +	}
> +
>   	args->out.queue_id = qid;
>   
>   unlock:
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 94fee99bd2a08..abd32415d7343 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -321,13 +321,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		goto free_ctx;
>   	}
>   
> -	/* Map userqueue into FW using MES */
> -	r = mes_userq_map(uq_mgr, queue);
> -	if (r) {
> -		DRM_ERROR("Failed to init MQD\n");
> -		goto free_ctx;
> -	}
> -
>   	return 0;
>   
>   free_ctx:
> @@ -351,9 +344,6 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   {
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   
> -	if (queue->queue_active)
> -		mes_userq_unmap(uq_mgr, queue);
> -
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>   	kfree(queue->userq_prop);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
