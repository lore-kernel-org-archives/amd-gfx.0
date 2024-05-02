Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD6C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 13:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD26710E135;
	Thu,  2 May 2024 13:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="03AnjU4J";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8971110E135
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 13:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1+RaVWIH9zeFZKG6o7jI8wXni5/o6n2KDukM4i9JOzK5T8CWtdXCHCwMWycuOuQCWogZmln/G4cDvsaO9z1ZgR/qsmVoRAOdogYa6eiNI0unW6sXjRwReWteOHOCJPVJ7qUXGALG1nxrgdCBdi/cVPb/RZ3RyRYEO1CJEi33WlxPbViJTN6obgALwICQo1DQpKsvikK/n9mQ5vgaEdr2V6AT/O6moV6BN6JjqLI/POJUjvRzrwU6ElZMuGo6/rMCzSZOr4X/xavhsASTnz3NPDyCooPYtIgMFgpRW7pQeyI+XNNn7DnlWJOzpKZ3oely+xRWm8v2LArdMJhNag7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPyIoapcBnmbWykBKX39rfV0d/yWAZwHOLi8lzp6QQc=;
 b=L36huzPwG46Hmfdr9WBJUncvTzf3VaAq1kojXmfu8aLdex7Dd3KiuYBn2f4Z+tRmEgpuLQ1Qywij/BpdDQk0By/ReryCR5FTemD4K+fEzuchqsxMdXT/r3+y3ZFvGaw1BpWmgvas0Ko17DpbU5IPAO5Y1mcPE01dtIrJtL+H+T4SelrtqsBLiGH/ymRAbcRdKLDDGzqjfU5PRQBDIabFReUoEVkQ9Qc9pOrz81U9KeoAVp2zYLmlnJTcWVbX1oTEkB6JxLFssGjZ8Hwp96py3Hv1uLjjyyS5SCtmsiA+7TF7P2getC6S8ZZO16f33y3ZkyE6NrEASCOTn8FtIUU/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPyIoapcBnmbWykBKX39rfV0d/yWAZwHOLi8lzp6QQc=;
 b=03AnjU4JN6nHykQXc0JXRtApW6uhOE/S4OQSv9yG1JjUOy/fg9XarS34QIBQJ85ULPuT8/qHAyl9keMwnbnHeiZGE3o22Dr9BnUfKEbHCQMSiR5fGZ2yhgh1Jpxp6KJdbNrOosItcJasRFcDuBH7E/4lLWjYLwGOa1RQQgmaTtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 13:32:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 13:32:37 +0000
Message-ID: <9e3d781c-46d4-4731-9700-de29c1abac21@amd.com>
Date: Thu, 2 May 2024 19:02:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Check tbo resource pointer
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240502133116.37630-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240502133116.37630-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 29213305-9877-47b8-0a31-08dc6aac54a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3hlcGNhdFJhOHBOcHFMRlBHRUFjL09TcFRoa1NCMDg4SjYxdkp1bWovWG1w?=
 =?utf-8?B?YS9WbS9wbkdraC9Sb3J0TmdWTU1hdExaQUVkaEUzbXJ0ZTZwZitJOEx2WFV1?=
 =?utf-8?B?SWVncUxHVDVhVGRjSUJISWhPbnE3OWFlL3RROU0zK2NTVjZRYzNMN2JZTVRT?=
 =?utf-8?B?WEk2K3hQS05BdVllblF3Z25jMllLTHBleFRwWVlXZ1lGQU95ZXRMYWVPU0JU?=
 =?utf-8?B?UE1jck02Z2dSdDA4SjBVbkNxTEdFTDA5RzBEai9ZRm1SclFxK0JWUStFcHZT?=
 =?utf-8?B?T3hpWGZEVmNEdTJVdzU1Vlk2OFcrYUM2R2E3enZTVjhTQ1RVMXZlNHZFZDJ3?=
 =?utf-8?B?QWM5WFpVVVR4UG15U2duaVdraEZ5ckR3VTlyN1NYWFhxYXU5N2pEQ1NWUUtv?=
 =?utf-8?B?TVg1MWcyMEJlbjlKdXVmK0ZmWWdLZklHc0xwNjZOczlxM2M1b0ZvNlJRNFZw?=
 =?utf-8?B?V1djRUdZaXRtdWlEbm5ZK3VmRHNweUxEMFBSblJmVzNvQk1zK1B3bTdvaEhB?=
 =?utf-8?B?ZDY4bnlGMU9YTmtCQkdjUk9EbnBtT1VZRHNQWW9xNDNBa29yVlZISE4wRkpn?=
 =?utf-8?B?ZkVUT0hTaVkvaUZEMHlsZFpXWXdWU3cvUTZoSVBmaWh0d24wekxwWHVpb0Vu?=
 =?utf-8?B?cVc4ZnBoMVB5ZTMvbjdQeTIzZGxoVm1rVFFmbXNqRGhxSDZkamcrUC9Pd2lh?=
 =?utf-8?B?N1BZSGY1UzNWN2JtRGttR09nN0xiSGxGaXY0TDF6QU5yOWRtSjB2Z1VpNlBP?=
 =?utf-8?B?cmx4dFI1V2lPWFNNa2xHYXdXTFF0WGpLV0YvaytjWlVHN0VMWnpZUjQ2ekQ4?=
 =?utf-8?B?R0FKMjhmZDVzaUlWSHNvNS93a1ZQRmdkZHlWMzk2ayswTTVSZ3o4dUk1RlVB?=
 =?utf-8?B?Z3Q3Y2kzenl0UHdQTFM1eHBldzBIeGlCYnc4UEdDR1Fld3NTcWRvV3dGc3pM?=
 =?utf-8?B?U1NERHNmZ0xhcVhiM2tKWGpPTVFVa1REb1pyMlYxMjJHcUdZMWQxOEZVbjdo?=
 =?utf-8?B?aGMrM2Ixb3Q4YTk3YndPQXE5alhtSWd5S2ZYTkVHR3dYNE5EUXpyNjB6TC9C?=
 =?utf-8?B?U0hsNk5ZLzFqcGJsQUExakROcnYzSzNsY3cra0RLdGtmanlkQ2htLzJZNVpN?=
 =?utf-8?B?d0RjWC9hc3M5cUU3YlplNTQ2Y2N4VTdoQlR0SDVTUFkvSVVGaWpFY3JXY1pL?=
 =?utf-8?B?RGhkN0ZYWms2WmdmTFlndWhLWE16a2hFOEwyRC9QS2dOK2FMemViYUU5NXZk?=
 =?utf-8?B?Zk5BVmtqdTV2QWZZOXRIemJPamtzdis3SHFQU0RLeUR5YnZzQmo3dk1YZXA5?=
 =?utf-8?B?OGFRL0FCRjk2MEZSU2JHMHZLQnZ6UUc2TXlPWEt6cFNpSWxWSzIxcWZNdVdV?=
 =?utf-8?B?U0NGTmxGN2dxUk4wWUJyQWpZcDRSdzk1R1g0U2R1RG5SL0NpbTRBeFRUMHNy?=
 =?utf-8?B?blYxYU1CZ250TVUySHJaa2ZZVWF2Y0dvNTRxb0JzSDREZ0RhR3ZiK0w4ckpV?=
 =?utf-8?B?MzQra2JzYjkzUmNaWGUxdXUyUG1DdjlvUjFxRHFuYVlUL29lNGtQWStkNnlR?=
 =?utf-8?B?MjdzdlFMMmJqK1BodTlPc1hVaXlSSFVxTFFYZlFkem9YUXQrZTJUY3Q2aSti?=
 =?utf-8?B?aTVuV0hlQWVBNzM4a0RJMjhNK0Q3dmkxSDBWV2g1QVpDbEFZckdBL3BBSTRl?=
 =?utf-8?B?dmNPV2daMnJha0ZwR2xyWnJkbENuZHpLKzh0UXZBZEs4T3NmdzRuTVF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEUvcVRhT1ptM04wTDVybTVEZjZ6MlFRc1BHNUFxMVRYMisyd0F2MkphSExs?=
 =?utf-8?B?ZlhyWGhiRE9ZSmozb0xDd0swUzZhaWxHcEUxRHFiWTFjYkd2MUZiZmFoUzNF?=
 =?utf-8?B?SWd3U2tCNXY5Zkl3NUNnNlY5NzM2YmdnS0h1R201TytQZlUxdVBzdGZVVFRi?=
 =?utf-8?B?aTF2VmxsemYyV3RmSGpHNG9tbnNDVGxiMVgzcTUrTW1PSko0QXYyblYwK0dS?=
 =?utf-8?B?RWoyOTU4d2dncnF5ZW5oMkdZWmNtVkFqOGFYOTU5SlVDNkZ4LzZuYjRPMmgz?=
 =?utf-8?B?bFdOZGFPdUdIZ0xzYzVjb1JTdW45K1dXdTNBcGFNWXplM3N1T1RZU1diSGJG?=
 =?utf-8?B?SC9BZTZJQWExTGxLQ2tQOVh1c0N0ZTNxWjgrQjIzZVFpSTlYN2VIdys5TXcz?=
 =?utf-8?B?Nzl0Wi9nNmt2bVdqY1ZMZ0xHdWZKdFcvN285elpHYjlRN3Fwc2pkOXcyclBa?=
 =?utf-8?B?bVZMNlVlbmgvcE9lcVpCdjFIajNKMkpOdTBldUtiZGx3SUltY0Z2NEd5N1Jz?=
 =?utf-8?B?dUdMd1RIeVhBZlNSamd5bW9zUVorVnlGTzg1NWw1TlBTQXZRWlpOM25OUFYy?=
 =?utf-8?B?ZWRZVVAxTmNiQWlNeG84ajN2NHJvUWVFTEkzcHFlZFMxeExGU21tN29ZUndR?=
 =?utf-8?B?dHBaNCtCRXJLWVpBRUlaYitwKy91bEpaY0o5WlZ1RXhueExqQlRTS2p4cWl2?=
 =?utf-8?B?UDl0QXZNMTNHMzFSWFQ2OTE0MUQ3QTlQUlhMOEtNemtZdXBPUEJlclRwRndC?=
 =?utf-8?B?RSt0TnJyWWF2d1pWM0hMMVBJZGd3UEUreUtsa1RHaXRzc0Z3TUpGdzJzbFJt?=
 =?utf-8?B?a1gyaGtCU0EzTVFiU1FKRkEvanVYWHUzejFCWDRFVkxaVHRpUXpMQnBUdVR3?=
 =?utf-8?B?LzVMUVRjZDQvdTlnV2xBYTNEUzBtbll6RFV2TndqSVRUMHYwT1BaVmo2REZq?=
 =?utf-8?B?QjVHdVplRlFhRUE2bmZ3a2UrVFZ1cG9JS2pqSENrcXNPY3hTbGhiVkxuR21t?=
 =?utf-8?B?NVUycWZobjJPNE1VdG9vaHMxdFlXVkY3WDFXTHFRNXJxVzFMOC9OQy9BZElD?=
 =?utf-8?B?bVNQMi83S2hObTFYYU9NN0NrUXE5bUhQMFBIK05CT0dHeVdsSXUra2UwV3dk?=
 =?utf-8?B?aEpleWZOdVpQNDh5YXk1cjVQbWJLTHE0clB3QkJ3cE1pZlZ0N2F4MHdxREw3?=
 =?utf-8?B?OHNNQzRBWWpDZExSUDdFTzcvUExNLzI0VUI2QWhYT1VHdkJLQklhVXd4azNQ?=
 =?utf-8?B?SDBUaG9UbDZZNC9rWXYxSkViSllkdmJDc1g2S1dXbGhoMFIwSVMyTkt5QlJ0?=
 =?utf-8?B?U2NnSm9xbUhBSUcyN0ZEa2FCVTVFRmpseHdpZFdSV0xwUzU4LytCVVcrZHo2?=
 =?utf-8?B?dVNra0pQeGkxZlI4WjNvVkx3eTVkeEV0TVhjaE9mSDdQQ1N3WldRaVRqTkw0?=
 =?utf-8?B?TVM3b0l2cWxYZko0WHRhQ0tmblZiVmo2UWFBaFZTeTlEbWYrUEZXcUxwOC9m?=
 =?utf-8?B?KzY2T2E3WTFtb1g2V2pPYStRbkNiYnU1TE85a0R2aW9SUER3eVFURmh1UWR0?=
 =?utf-8?B?dmVVTmwvSFY1UnZxSm50Qi92alYwU29aNm9sVWpZbXk4OGc5bFRwcXlNVXFV?=
 =?utf-8?B?bzJVcUFkVlhTUkVrbDZnZEd5WGFrK0NaTlp0KzArVnF4SU1XbE44RU1KSEtW?=
 =?utf-8?B?OGJ6MEpRQUNNNlA4ZWhISVVsYUpsZkxodkdSVWV6RGYxMzZ5Y0o0U0hSTkdt?=
 =?utf-8?B?RXZWdE9wa2hLYU44RmdqNDhVQmV6Y1ZLbEQ1K2dOb2VncVZaNjlFajVuR3Zr?=
 =?utf-8?B?bysvcjNpTzA4L1lOWDNYTXRud2pvT25xeWw1TFBMdW9jUG0yYkZKMVRONTcx?=
 =?utf-8?B?N0tYK3BvWjNVV3JISU92OXFsaUNkZElsR2Y2YkdiZmVMVXdJSWJaSitPeXlJ?=
 =?utf-8?B?YTBhU1VQcGsrNnhqMVcwditIenJUUUlKRmQrMmZRVDRJUTRaazBKNElEM3l1?=
 =?utf-8?B?bVBEUEQxS0FodVNFSDRhRVdPVXJjbXNmdEJqSUJuajhyN21ROU5MWlNUV2sw?=
 =?utf-8?B?SjZ2VE90VWNEdnVuckZSY3VYSkNrYVhzNnNmdjgzQ0VFck5scjZ6Y2tVeDFz?=
 =?utf-8?Q?FGvpNN0rrEB9B4ilxfuE5M8bN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29213305-9877-47b8-0a31-08dc6aac54a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:32:37.0399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkiXN1aBZvJs9dx1RPkgcLHqrlT94YMCCgvRSzRjj7PCJvbV0bjEOrl0WIeuddi7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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



On 5/2/2024 7:01 PM, Asad Kamal wrote:
> Validate tbo resource pointer, skip if NULL
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a6e3d13a454..77f6fd50002a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5012,7 +5012,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>  		shadow = vmbo->shadow;
>  
>  		/* No need to recover an evicted BO */
> -		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
> +		if (!shadow->tbo.resource ||
> +		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
>  		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
>  		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
>  			continue;
