Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219C3D5AE70
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 07:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04E610E7B3;
	Thu,  7 Nov 2024 07:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CLsOvcF1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4793010E7B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 07:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg+6W62Rda0Jz/5acIpV/Hbrpi+h68Y5393VSKLQogAVlNhOOz6vD31c3O1oSwi56rmH25xlwo3j4kon0VS2DUTVp7X+DtCncQ2zW7iC8Qeovlu1MZHjuwG+KbDgWnN29IAEogUhsZK6VOp9WerK4cNxWtBFfqEKSAY/8QQUuCv8dfxV87Qd9awuOux9KOdFyoMIdUVNGWzEnxONw2fO1+RqZaTrX+LWc+kR1ugFKpOCsJxQjBwLrmomoT1er/h+EpLzRnuw8TA4fOqBx0RIxBB6edzTHnYXzSwitqVMGltVmkhl3AT8DuFo2MhKJkloWuqctUfwQICWSan+AjZPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W29v/XbdoDSyLMJWAw3LDG6qXIqux9YbYknJn3y+v0w=;
 b=yXYZ6WFz7s+s/3RfzNFLhuRBgPbQjg7TCi/Y2lou9EPmRezgOvVgEIvrz2LOQQEo8FGCJxoZqfvSLjJDt6iV3wtYRV3tTlJGnZwugX82ViQ8mNPaPtTYHxUkeyVrxTP/nvHOvT2/X5XahZRQpBUq5qypbPI4z/QTBLWCGk88/yvAHyYYaMpV8DQqNFNW6pRU2XCeUep9JvEsTUUVZdSgp4FCukmG+2hw4qlNo4xl+/tWZMXumyp+ffX6RsgdHGLXqsT99SW2G12+RDaVxJ2p5r7ss7RUjv0J9TXXEfgPYtO+oxTrHYfb6xo2P2fiwkBl7JC8aV0gu0wV/AK1u5v8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W29v/XbdoDSyLMJWAw3LDG6qXIqux9YbYknJn3y+v0w=;
 b=CLsOvcF1cNtGCrP2oArYKY3fyCusp3nRo+nfLiFJTCmozS2K8U7YYIA0CFXIgJ4DKCZ7G4NPJEONFyAjiYNNlPMh8ioNr5F+8/KJD8HjocdCIPXtI+3gWoW5S19ypLaqPPS6F9LikxpsmPUMjbsF3E8zo8FJ+rm/lxBOshIHM4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 07:56:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 07:56:26 +0000
Message-ID: <e3eac43d-2445-4904-8cab-76429c182297@amd.com>
Date: Thu, 7 Nov 2024 13:26:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdgpu: Implement virt req_ras_err_count
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 amd-gfx@lists.freedesktop.org, zhigang.luo@amd.com, tao.zhou1@amd.com,
 hawking.zhang@amd.com
References: <20241105190429.323478-1-victor.skvortsov@amd.com>
 <20241105190429.323478-4-victor.skvortsov@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241105190429.323478-4-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad718d3-b124-4001-d01b-08dcff01ae29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWhCT1MxazJjRFl0NWd3RGtsQVhMLzAvVXBYTFJKREhhWnduNEZSZEZ6SFRi?=
 =?utf-8?B?VlJKVWNraEQvZU9Jc3JaV3QwV3ZXMm5Oa3UycnJFK091dnVDK1RMQUZYY0lL?=
 =?utf-8?B?bmFtNmI1cHRHL0l3VnE2amdBRVJOQlhGQ0F1L2g0QjBVc0QvNnc4OWpmM0d3?=
 =?utf-8?B?dzBZQm9uOHE1M2VkbldzUlZYK0p3WExhNXhtL3NpVC95NG1hdmljdnYyRWZE?=
 =?utf-8?B?THNKVThVVFZWd2wyTUxvd3ZKRTIwcW15Y2NjNG53ZXoza0wvWUExT1pBVmZF?=
 =?utf-8?B?WGwrT3JHMVdBVHNiWUUvdTBrcXNmbXBmQk5Wd0RtVzlhbmV3QVRNajMzYTVm?=
 =?utf-8?B?V3luVzdJYmVBL3lHK0VTYXA2UFhtOCs1WVNFR1d5bXgwQ01lVlV0TDI0dWYx?=
 =?utf-8?B?SVdINmQxZTZ1WW5mR0Y2cHdXbEVXYTkxeWs1M1BUbCsyTi9aTjJ6ckRXS1Jl?=
 =?utf-8?B?dnNKYlAzSEx0SGhrVHJzdkVJTGZOUTN3TXBVT3k2QW5TZVNYdkJ4aGt3Tk1L?=
 =?utf-8?B?UUJJNDhrQ0dEK25xZGh0WnlycG1wYVdpU3NzOHF4bEJYSmZlY1NPdDlZY2FJ?=
 =?utf-8?B?ZEptVzg0bFJTVStBZWs3MHVrTE5CaENEVHVFR1luY3R5Q1lJOUJiSGd2ZlNN?=
 =?utf-8?B?NDh6ZjZGc25Bc0JQeUg5VmZTZy9haFUvT2Z0WnJJUjZnUEF1ZkdHMFdTbjdZ?=
 =?utf-8?B?clpRU0pibjVJL3MybnZkdGFqZ2ROTEs5Ujh6K2tJMjdrNTd0c1BqYkRDV2tK?=
 =?utf-8?B?dGNUeVFjb0lSVU1kakFWWlFMTFVsa3F6N29TZUNSZjM3Y0VJNmJ5MG9aeDBu?=
 =?utf-8?B?U1dQbEZFY0tJdnJwMU1xUTg4dkpHNEhIM0w4QW42WjdmalUyMUdpNWtrb3VQ?=
 =?utf-8?B?a0hUL05xM0pVTTAzYkVkUlN4R2pETFBjU0JERDJxYWIzcmIzQWhYNjhxUjhQ?=
 =?utf-8?B?QytQOWhNTTQ4c20xd1F1cVhweEZjN1hscFdwUk9FTndEV0J2aTc2S3N4RUla?=
 =?utf-8?B?NU9jMVRoc1NaK2RVakRLVVN0THJQMXdocFg5R2N0bXE2VzQxZGVUdXBESE9P?=
 =?utf-8?B?V3VDSjNwRmNxVnVrSHN2UmdrbUZiYy9FQXBMamlvb1Nzc1F5eGhoOXYyNDl0?=
 =?utf-8?B?UUppTENlcFZZRWlsVnMxMzlmNEVLaTNjNTZraEVmbWFGQ1cweW9veGhZdkZF?=
 =?utf-8?B?eXRNcXY0dXRRVVNNcytlankrOW13MlZNbTJSWVoxbDVXTEllVWZoamZENUxm?=
 =?utf-8?B?RUtSUkhPM3B4clNZZzZNdVlLUGJnRURXY1U5SmY0NUx2aUhOSXU2dExmVkZD?=
 =?utf-8?B?UkdOMWN0aG0xTUwzVjBpdHdVQnQwWVlUZHkvRVA3V2owU0ZlZjB2UUoyMktC?=
 =?utf-8?B?UkxZRC8rUzNOMHV2SW1OOXFkZ1ovbng5cUlWd3owSEQzc3NEVFNtbTM1Wmoz?=
 =?utf-8?B?dFhVYTlqeWQ2QUNvZWRsamFLOTZCbXdqWnJHTFVHL0VVM2lCY3pyOHI0RzlJ?=
 =?utf-8?B?dXN5NUdwc0xNeHVmWWFPOWs0LzNVNkhkMlVqRjFYSWE4RkttNWs3UlhQL1Y1?=
 =?utf-8?B?S1diZ05ESVQ4UTFwc3VXZkczaHg3eVZsRW1pMFhkQ1JwaE02c0hTcytQU1lD?=
 =?utf-8?B?aEZqRWRpY0Y1THRjZGZnakczODZSKzl3bjdvS3F1NFAzaExQaUx2YnhhaVZz?=
 =?utf-8?B?UU54Qkh2aDhzNTBqSjRoMHp5bHA1UTMwaHZaQ0R0ZXBad0VYZk1nb28xWTgw?=
 =?utf-8?Q?KNnXOHL7B6SfiQgB2ZxUDcQCzqMCopa679vYlVy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?empJcU9rbFpmUHdyZS9aZTJFejZMaWtuYXBXRzJ6cVRKL3hTNnB4N3p6NGww?=
 =?utf-8?B?bmpEV0NrZS8rN0dCcXMzZW1OTWxGVFFrRXFNUXA1TkxTTnBZMlkxeC9RaWE2?=
 =?utf-8?B?TkFDZW5aSmxUR2I2YWw5T0VrOTlDSXJ6Nk1YY25JR0FCd2ZKNXdRUHNTVDRL?=
 =?utf-8?B?TlVTTUVkUmI5dkZYWFpCaTI4ZU9rekE4RGVqVE5rUW9BMnBEQk4rWmF0bDNF?=
 =?utf-8?B?SnNTdnhMR3BYZjhWWXR6QTZFYm1CeWx3ejArUjF6R2Y3REtmOXZsWTg1VDQr?=
 =?utf-8?B?Ylc3bW0rQXhBTUd3K3VaeVE1U0VSM0RIM3cxNEt3NE1NVXhReWNKZTVXZlN3?=
 =?utf-8?B?czVjcDV2cXJweHlpMUJseWpBQlNYYmcwRCtHMUhac2VlNzRXS3doTU9RaHBo?=
 =?utf-8?B?MHVNWU1hNmo3eG9WWDc0dlJQa2VaRXZ6SURYYWh4WFVad3BrVCtCbXNiOHRX?=
 =?utf-8?B?RmZjVDM1bDN4U1ByREZOQU95dUxpaFBHWDJVeXFUQUhrQmh3VHg3NnR2V0pE?=
 =?utf-8?B?U0VOS1M1SGZqUEhmMzZESkdoZUxJQnk0YVIrbXUySE1PZUFIZHFYQmlIdWR1?=
 =?utf-8?B?a0hRUXpMNHB6VXdiR0huRUd4TGlhTGpEbkVXMytMWEJ1THdlZVcvOU8rZmNP?=
 =?utf-8?B?cFpaa1NzOHltS1Z4TDV2Z1lKTmZpbzA4NkpnZkJFZU8ySk9TaU4vRkUwY2hB?=
 =?utf-8?B?N1pLYTI2dWE2WUJ4YWsreEpSVHovcWN1ZWova2NVOXlEMWtxVldxS3pvVnRE?=
 =?utf-8?B?cVlpMklvdmoyU20zS2ZNeXVkalMwaHROSHpwa2UwbVFqdXZuK1c4SHZRNlpG?=
 =?utf-8?B?NFRoaXNHRnBjWTRkaHl6S0R1cWVPRGVQNHE3clZjMzVNbW1OQ1NyZDBPdmxJ?=
 =?utf-8?B?Uld3a3N2blVKbFBkaVpvaFRDRlZYV09VOVlKSmRMaGJvSnBHVUQ0ZCtWdkRu?=
 =?utf-8?B?SExOakR1N3pUcjZyRUhlNjV6UHZyUjNrNGkvc0ZGL0NzMUg4V0lBczVzVndY?=
 =?utf-8?B?ODN5L3RIMS9XdmkwYVFWT2c2L2RWNFRwdXVjMnRSNTJJVXRmNklxRU8xWFRu?=
 =?utf-8?B?MTV4RFBkNzFHK2cyNmpIS3hjbUlYMWpKL2xXU0Rmd1ZRMmlyL2JKYVp4VkNU?=
 =?utf-8?B?U0k0TFFoeGZydzN5bXNVN0N0cWJvdVdCMk5FL0krVlFGRGozZjNsZE1HcVNp?=
 =?utf-8?B?aTI2VC9YU0EvN0JOT2E2aC81OEVlLzJ3WElKS2ppNTRsTmNWZ2YzVFZOWXFa?=
 =?utf-8?B?bkliOU5HZHBzaU1MVlRoR0hYY21VTFZYZlMwMzVKUWI0V1FyampLam1iZk83?=
 =?utf-8?B?eE0vem5PR1p4MW5odlRZVnFVZno1RHlOYU53YmFINmw0V2MwaVNCVktXNDJs?=
 =?utf-8?B?Mmh5ZFdEWXk5Q1I2eE9YQ2wyMnBXOTUzRFl2bFVSbkxiOGVQZnpCWmNKQmJu?=
 =?utf-8?B?RmNXdTRPcGZyTGkrN0RaMjNockxtT3dUMlJyb1dkWnJwZDVCb2FnTFhWUVVR?=
 =?utf-8?B?a2wrYzFOSmJoQ0dGZFcwMGo5L3prSHk5VDV0a0Uvclk5OUEwcjY2ODc3Rzkr?=
 =?utf-8?B?N05qbURndC9qaUZJdTAzcXZhZkU3UVdDclVIZmJHMldRLzB0b1lXa0RQNUlR?=
 =?utf-8?B?WVpGVnBjK3lDSVBxb0Mva2NIUjM5VUN5NFJ0UjkzMWdaTXoyMGFrL2RJM2xC?=
 =?utf-8?B?TzZWYzFxem5kN2dPZ1MyN05ERDdRWjJQbzcrbTc1d1FyTmhZbGRvU0owQmtY?=
 =?utf-8?B?QVlFWFVjVGJTQm0xRE5CZWN5RE1LRGx4MjAzdTNIZkpWTkFMVDJCTnlySjdX?=
 =?utf-8?B?dkFJZnpqSzE3MkhLcnRJYjNEN3AxMUpGYlJ3akxSeWdPa3lnMU5UVGROR2tq?=
 =?utf-8?B?eWtiU05sZmtkYm5jaWdERkJNTUJyYTVrb1ExTnlqM2RyYWp1NjdwWXZGN0Jk?=
 =?utf-8?B?RXRIR0VscVZMalFIUndtLzlqZjdZUDNkV2hLR0JrMG93VWJkeVN1MENDTXV6?=
 =?utf-8?B?OG9KUFVSMG9jb0drakRZaUFneHVkN3lKWmRsS3Y1OFdUQURzcWlTcjhqU21r?=
 =?utf-8?B?MUpVS0ZWSTYxY1hnNW5jemNOUzVjejFkMm9BR3B1VjZXLzZKeEZETGVLbmgr?=
 =?utf-8?Q?YpbY2S+ZcnKJCepcQ/OAb0L2G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad718d3-b124-4001-d01b-08dcff01ae29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 07:56:26.3821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqcFA91c3gdOq/J2NoxUxeMxCmddXCxHU7ZU1enWTVy0xPt2yAelBhZpctjtJZhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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



On 11/6/2024 12:34 AM, Victor Skvortsov wrote:
> Enable RAS late init  if VF RAS Telemetry is supported.
> 
> When enabled, the VF can use this interface to query total
> RAS error counts from the host.
> 
> The VF FB access may abruptly end due to a fatal error,
> therefore the VF must cache and sanitize the input.
> 
> The Host allows 15 Telemetry messages every 60 seconds, afterwhich
> the host will ignore any more in-coming telemetry messages. The VF will
> rate limit its msg calling to once every 5 seconds (12 times in 60 seconds).
> While the VF is rate limited, it will continue to report the last
> good cached data.
> 
> v2: Flip generate report & update statistics order for VF
> 
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  72 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  15 +++
>  7 files changed, 231 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 383bbee87df5..c22a9925cba7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4235,7 +4235,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	 * for throttling interrupt) = 60 seconds.
>  	 */
>  	ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1);
> +	ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);
> +
>  	ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON_RELEASE);
> +	ratelimit_set_flags(&adev->virt.ras_telemetry_rs, RATELIMIT_MSG_ON_RELEASE);
>  
>  	/* Registers mapping */
>  	/* TODO: block userspace mapping of io register */
> @@ -5185,6 +5188,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
>  	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
>  		amdgpu_ras_resume(adev);
> +
> +	amdgpu_virt_ras_telemetry_post_reset(adev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8cc4b146bdc..8c9fcfb7f22e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -885,6 +885,9 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>  		if (r)
>  			return r;
>  
> +		if (amdgpu_sriov_vf(adev))
> +			return r;
> +
>  		if (adev->gfx.cp_ecc_error_irq.funcs) {
>  			r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
>  			if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 89d87dc17ac1..a8b4f4178e5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1214,6 +1214,42 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
>  	}
>  }
>  
> +static void amdgpu_ras_virt_error_generate_report(struct amdgpu_device *adev,
> +						  struct ras_query_if *query_if,
> +						  struct ras_err_data *err_data,
> +						  struct ras_query_context *qctx)
> +{
> +	unsigned long new_ue, new_ce, new_de;
> +	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &query_if->head);
> +	const char *blk_name = get_ras_block_str(&query_if->head);
> +	u64 event_id = qctx->event_id;
> +
> +	new_ce = err_data->ce_count - obj->err_data.ce_count;
> +	new_ue = err_data->ue_count - obj->err_data.ue_count;
> +	new_de = err_data->de_count - obj->err_data.de_count;
> +
> +	if (new_ce) {
> +		RAS_EVENT_LOG(adev, event_id, "%lu correctable hardware errors "
> +			      "detected in %s block\n",
> +			      new_ce,
> +			      blk_name);
> +	}
> +
> +	if (new_ue) {
> +		RAS_EVENT_LOG(adev, event_id, "%lu uncorrectable hardware errors "
> +			      "detected in %s block\n",
> +			      new_ue,
> +			      blk_name);
> +	}
> +
> +	if (new_de) {
> +		RAS_EVENT_LOG(adev, event_id, "%lu deferred hardware errors "
> +			      "detected in %s block\n",
> +			      new_de,
> +			      blk_name);
> +	}
> +}
> +
>  static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, struct ras_err_data *err_data)
>  {
>  	struct ras_err_node *err_node;
> @@ -1237,6 +1273,15 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
>  	}
>  }
>  
> +static void amdgpu_ras_mgr_virt_error_data_statistics_update(struct ras_manager *obj,
> +							     struct ras_err_data *err_data)
> +{
> +	/* Host reports absolute counts */
> +	obj->err_data.ue_count = err_data->ue_count;
> +	obj->err_data.ce_count = err_data->ce_count;
> +	obj->err_data.de_count = err_data->de_count;
> +}
> +
>  static struct ras_manager *get_ras_manager(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
>  {
>  	struct ras_common_if head;
> @@ -1323,7 +1368,9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
>  	if (error_query_mode == AMDGPU_RAS_INVALID_ERROR_QUERY)
>  		return -EINVAL;
>  
> -	if (error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
> +	if (error_query_mode == AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY) {
> +		return amdgpu_virt_req_ras_err_count(adev, blk, err_data);
> +	} else if (error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
>  		if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
>  			amdgpu_ras_get_ecc_info(adev, err_data);
>  		} else {
> @@ -1405,14 +1452,22 @@ static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
>  	if (ret)
>  		goto out_fini_err_data;
>  
> -	amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
> +	if (error_query_mode != AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY) {
> +		amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
> +		amdgpu_ras_error_generate_report(adev, info, &err_data, &qctx);
> +	} else {
> +		/* Host provides absolute error counts. First generate the report
> +		 * using the previous VF internal count against new host count.
> +		 * Then Update VF internal count.
> +		 */
> +		amdgpu_ras_virt_error_generate_report(adev, info, &err_data, &qctx);
> +		amdgpu_ras_mgr_virt_error_data_statistics_update(obj, &err_data);
> +	}
>  
>  	info->ue_count = obj->err_data.ue_count;
>  	info->ce_count = obj->err_data.ce_count;
>  	info->de_count = obj->err_data.de_count;
>  
> -	amdgpu_ras_error_generate_report(adev, info, &err_data, &qctx);
> -
>  out_fini_err_data:
>  	amdgpu_ras_error_data_fini(&err_data);
>  
> @@ -3929,7 +3984,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>  	}
>  
>  	/* Guest side doesn't need init ras feature */
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
>  		return 0;
>  
>  	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> @@ -4396,11 +4451,14 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
>  		return false;
>  	}
>  
> -	if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs && mca_funcs->mca_set_debug_mode))
> +	if (amdgpu_sriov_vf(adev)) {
> +		*error_query_mode = AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY;
> +	} else if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs && mca_funcs->mca_set_debug_mode)) {
>  		*error_query_mode =
>  			(con->is_aca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
> -	else
> +	} else {
>  		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
> +	}
>  
>  	return true;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 871b2d6278e0..6db772ecfee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -365,6 +365,7 @@ enum amdgpu_ras_error_query_mode {
>  	AMDGPU_RAS_INVALID_ERROR_QUERY		= 0,
>  	AMDGPU_RAS_DIRECT_ERROR_QUERY		= 1,
>  	AMDGPU_RAS_FIRMWARE_ERROR_QUERY		= 2,
> +	AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY	= 3,
>  };
>  
>  /* ras error status reisger fields */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index bb7b9b2eaac1..896f3609b0ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -318,6 +318,9 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>  	if (r)
>  		return r;
>  
> +	if (amdgpu_sriov_vf(adev))
> +		return r;
> +
>  	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
>  		r = amdgpu_irq_get(adev, &adev->gmc.ecc_irq, 0);
>  		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 53297c40f09c..b1e584e4ef13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -524,6 +524,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  		adev->unique_id =
>  			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
>  		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
> +		adev->virt.ras_telemetry_en_caps.all =
> +			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
>  		break;
>  	default:
>  		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
> @@ -704,6 +706,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>  			adev->virt.fw_reserve.p_vf2pf =
>  				(struct amd_sriov_msg_vf2pf_info_header *)
>  				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.ras_telemetry =
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));

Shouldn't it check if it's telemetry capable before this assignment?

Overall, it feels like it would be better to have a ras manager/ras
control block under virt which maintains

	count_cache
	ras_telemetry_rs
	req_ras_err_count
	ras_telemetry_en_caps

It gets initialized only if ras capability and ras telemetry capability
is detected - amdgpu_virt_ras_init and then go from there. Also, makes
it easier for read, if all starts like amdgpu_virt_ras

	amdgpu_virt_req_ras_err_count => amdgpu_virt_ras_req_err_count
	amdgpu_virt_cache_host_ => amdgpu_virt_ras_cache_host_errors

and so forth.

>  		} else if (adev->mman.drv_vram_usage_va) {
>  			adev->virt.fw_reserve.p_pf2vf =
>  				(struct amd_sriov_msg_pf2vf_info_header *)
> @@ -711,6 +715,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>  			adev->virt.fw_reserve.p_vf2pf =
>  				(struct amd_sriov_msg_vf2pf_info_header *)
>  				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.ras_telemetry =
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
>  		}
>  
>  		amdgpu_virt_read_pf2vf_data(adev);
> @@ -1197,3 +1203,135 @@ bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev)
>  
>  	return true;
>  }
> +
> +static inline enum amd_sriov_ras_telemetry_gpu_block
> +amdgpu_ras_block_to_sriov(struct amdgpu_device *adev, enum amdgpu_ras_block block) {
> +	switch (block) {
> +	case AMDGPU_RAS_BLOCK__UMC:
> +		return RAS_TELEMETRY_GPU_BLOCK_UMC;
> +	case AMDGPU_RAS_BLOCK__SDMA:
> +		return RAS_TELEMETRY_GPU_BLOCK_SDMA;
> +	case AMDGPU_RAS_BLOCK__GFX:
> +		return RAS_TELEMETRY_GPU_BLOCK_GFX;
> +	case AMDGPU_RAS_BLOCK__MMHUB:
> +		return RAS_TELEMETRY_GPU_BLOCK_MMHUB;
> +	case AMDGPU_RAS_BLOCK__ATHUB:
> +		return RAS_TELEMETRY_GPU_BLOCK_ATHUB;
> +	case AMDGPU_RAS_BLOCK__PCIE_BIF:
> +		return RAS_TELEMETRY_GPU_BLOCK_PCIE_BIF;
> +	case AMDGPU_RAS_BLOCK__HDP:
> +		return RAS_TELEMETRY_GPU_BLOCK_HDP;
> +	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
> +		return RAS_TELEMETRY_GPU_BLOCK_XGMI_WAFL;
> +	case AMDGPU_RAS_BLOCK__DF:
> +		return RAS_TELEMETRY_GPU_BLOCK_DF;
> +	case AMDGPU_RAS_BLOCK__SMN:
> +		return RAS_TELEMETRY_GPU_BLOCK_SMN;
> +	case AMDGPU_RAS_BLOCK__SEM:
> +		return RAS_TELEMETRY_GPU_BLOCK_SEM;
> +	case AMDGPU_RAS_BLOCK__MP0:
> +		return RAS_TELEMETRY_GPU_BLOCK_MP0;
> +	case AMDGPU_RAS_BLOCK__MP1:
> +		return RAS_TELEMETRY_GPU_BLOCK_MP1;
> +	case AMDGPU_RAS_BLOCK__FUSE:
> +		return RAS_TELEMETRY_GPU_BLOCK_FUSE;
> +	case AMDGPU_RAS_BLOCK__MCA:
> +		return RAS_TELEMETRY_GPU_BLOCK_MCA;
> +	case AMDGPU_RAS_BLOCK__VCN:
> +		return RAS_TELEMETRY_GPU_BLOCK_VCN;
> +	case AMDGPU_RAS_BLOCK__JPEG:
> +		return RAS_TELEMETRY_GPU_BLOCK_JPEG;
> +	case AMDGPU_RAS_BLOCK__IH:
> +		return RAS_TELEMETRY_GPU_BLOCK_IH;
> +	case AMDGPU_RAS_BLOCK__MPIO:
> +		return RAS_TELEMETRY_GPU_BLOCK_MPIO;
> +	default:
> +		dev_err(adev->dev, "Unsupported SRIOV RAS telemetry block 0x%x\n", block);
> +		return RAS_TELEMETRY_GPU_BLOCK_COUNT;
> +	}
> +}
> +
> +static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
> +					       struct amdsriov_ras_telemetry *host_telemetry)
> +{
> +	struct amd_sriov_ras_telemetry_error_count *tmp = { 0 };
> +	uint32_t checksum, used_size, tmp_check;
> +
> +	checksum = host_telemetry->header.checksum;
> +	used_size = host_telemetry->header.used_size;
> +
> +	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +		return 0;
> +
> +	tmp = kmalloc(used_size, GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	memcpy(tmp, &host_telemetry->body.error_count, used_size);
> +
> +	tmp_check = amd_sriov_msg_checksum(tmp, used_size, 0, 0);
> +	if (checksum != amd_sriov_msg_checksum(tmp, used_size, 0, 0))
> +		goto out;
> +
> +	/* Copy sanitized data to guest cache */
> +	memcpy(&adev->virt.count_cache, tmp, sizeof(adev->virt.count_cache));
> +out:
> +	kfree(tmp);
> +
> +	return 0;
> +}
> +
> +static int amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bool force_update)
> +{
> +	struct amdgpu_virt *virt = &adev->virt;
> +
> +	/* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich, the Host
> +	 * will ignore incoming guest messages. Ratelimit the guest messages to
> +	 * prevent guest self DOS.
> +	 */
> +	if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
> +		if (!virt->ops->req_ras_err_count(adev))
> +			amdgpu_virt_cache_host_error_counts(adev,
> +				adev->virt.fw_reserve.ras_telemetry);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Bypass ACA interface and query ECC counts directly from host */
> +int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
> +				  struct ras_err_data *err_data)
> +{
> +	int ret;
> +	enum amd_sriov_ras_telemetry_gpu_block sriov_block;
> +
> +	sriov_block = amdgpu_ras_block_to_sriov(adev, block);
> +
> +	if (sriov_block >= RAS_TELEMETRY_GPU_BLOCK_COUNT ||
> +	    !amdgpu_sriov_ras_telemetry_block_en(adev, sriov_block))
> +		return -EOPNOTSUPP;
> +
> +	/* Host Access may be lost during reset, just return last cached data. */
> +	if (down_read_trylock(&adev->reset_domain->sem)) {
> +		amdgpu_virt_req_ras_err_count_internal(adev, false);
> +		up_read(&adev->reset_domain->sem);
> +	}
> +
> +	err_data->ue_count = adev->virt.count_cache.block[sriov_block].ue_count;
> +	err_data->ce_count = adev->virt.count_cache.block[sriov_block].ce_count;
> +	err_data->de_count = adev->virt.count_cache.block[sriov_block].de_count;
> +
> +	return 0;
> +}
> +
> +int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)
> +{
> +	unsigned long ue_count, ce_count;
> +
> +	if (amdgpu_sriov_ras_telemetry_en(adev)) {
> +		amdgpu_virt_req_ras_err_count_internal(adev, true);
> +		amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, NULL);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index f0ff84add692..5381b8d596e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -104,6 +104,7 @@ struct amdgpu_virt_ops {
>  struct amdgpu_virt_fw_reserve {
>  	struct amd_sriov_msg_pf2vf_info_header *p_pf2vf;
>  	struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
> +	void *ras_telemetry;
>  	unsigned int checksum_key;
>  };
>  
> @@ -138,6 +139,7 @@ enum AMDGIM_FEATURE_FLAG {
>  	/* MES info */
>  	AMDGIM_FEATURE_MES_INFO_ENABLE = (1 << 8),
>  	AMDGIM_FEATURE_RAS_CAPS = (1 << 9),
> +	AMDGIM_FEATURE_RAS_TELEMETRY = (1 << 10),
>  };
>  
>  enum AMDGIM_REG_ACCESS_FLAG {
> @@ -280,6 +282,10 @@ struct amdgpu_virt {
>  	struct mutex rlcg_reg_lock;
>  
>  	union amd_sriov_ras_caps ras_en_caps;
> +	union amd_sriov_ras_caps ras_telemetry_en_caps;
> +
> +	struct ratelimit_state ras_telemetry_rs;
> +	struct amd_sriov_ras_telemetry_error_count count_cache;
>  };
>  
>  struct amdgpu_video_codec_info;
> @@ -327,6 +333,12 @@ struct amdgpu_video_codec_info;
>  #define amdgpu_sriov_ras_caps_en(adev) \
>  ((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_CAPS)
>  
> +#define amdgpu_sriov_ras_telemetry_en(adev) \
> +(((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_TELEMETRY) && (adev)->virt.fw_reserve.ras_telemetry)
> +

As a matter of coding style/easier read,  would be good if you could
maintain gim_feature checks at one place. Now it's mixed across.

Thanks,
Lijo

> +#define amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
> +(amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_caps.all & BIT(sriov_blk))
> +
>  static inline bool is_virtual_machine(void)
>  {
>  #if defined(CONFIG_X86)
> @@ -391,4 +403,7 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
>  					  bool write, u32 *rlcg_flag);
>  u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
>  bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
> +int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
> +				  struct ras_err_data *err_data);
> +int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
>  #endif
