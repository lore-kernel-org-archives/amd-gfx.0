Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67050C3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 19:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F7A10EB7E;
	Fri, 16 May 2025 19:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xiw2RgS/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B02310EB7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 19:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrELn2tPEvdzIBx3TCAOmRG1TPSsr1cNudSglJB4Sv+CGzF5mdEOmnGVrPCa1A14P+QcJVlI/OwrJ9qpVo6f8ZURQjnvJ5LtMeKtCvTveDm9r4OMNgh3aULRxcz/SeBcurDd1oHgxqloYYTISo4QE32rX+MBPkpHX0unpVf3PDSHesbwoHnNPNNHKBDr4IxLl2vW76X5vnCG9e2nG5sUmHMYKh7GexBJMfyTgPGlVCsL8ibgP/V5lbwlM5TPK1P5b8QN7hPHioNZNVVEyjMZyhqr7M5BCT9yg+RgmoNpUAmaE7ZA0gLyvTyxDzq2la9wZOG3stdsAZbbOHmzsuBc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyCsf+jjJewWGmCzn7c80UM5na24Vj8G1U4x/sSxx4Y=;
 b=UYR3izT0a06cwwo4aOhx92yPk1QjnyHiD3xkPMKW9rdYvH2aYYenJMV8EbYd6C3e/RCtoJ5f4cr3bcOR5zAK0CLRK+pF3VCGCUhee2vx6U2my9o7OjvJfRqREzB3ubeGUQnOz//ScsCTKq6xFhGN1GV4iRXGw975+oYJ8SGyRPSFmSCuLPij7pHebCDw6vnFg6T0Zmj7ySU3C1jWj1mb3Q8jo06o2GzY+Olh1vSuMQt/xWV6h6TFnZnmdXeY3eUhr4h7m0MHh5VQuP8CZm+0sLLgi9/2Hte1HNfdZ9VzYlKh8Pt3QQVmQGCPI8n8MbCxh3qKJWkSLXNIWEI6WEBPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyCsf+jjJewWGmCzn7c80UM5na24Vj8G1U4x/sSxx4Y=;
 b=Xiw2RgS/LwUomY6VvAococPCzmuQKA9kAhxoUDbKMa5Eu5C3npSYtKHNzhxx1VYdfNx7vEi6YNQRmYcMh14RK743C3M3KAChwv5Od4AJSx7wHb7znoRxiuNUfGmzpwJcAM4cdrjRaaC6gRCGdxQbJi/Ty6EQ189RXHm7uw2fvhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 19:42:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 19:42:57 +0000
Message-ID: <05d8be92-4779-46a6-b8f1-71e71c33a258@amd.com>
Date: Fri, 16 May 2025 14:42:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250515221656.1516157-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250515221656.1516157-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c7e5e2-618b-42be-fb8c-08dd94b1dbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzl2cSs5enlIYy9YTlRRZzBLLytDNDFzSEEzUjBKRjU2RmYvMEFqMGhvcGwz?=
 =?utf-8?B?MjhwYVlOSWRPU2FPWjVtMjhRdUNOeGF5dU51THgzRmd2ejBuWnZVelgrS0hu?=
 =?utf-8?B?b1huTFRkOUs3TlBOdEN0ZW1UK0ZJeWRmTWhxbko2S2w4aVFFOWJGSkFzVmN6?=
 =?utf-8?B?SzhCVFUybVc3Zi90S0dFcmtCUFBRYjJ5ZU1oSlNkVW5Sb3A5SnBxMllNeThu?=
 =?utf-8?B?SEpibldIWjRWNThhaHJMbWJPVndFN1pKU2tWdGs3Nnh0eE8vMzVFWTc2Smsv?=
 =?utf-8?B?QUFCazVEck1LcjNOUVQ2UThyMHNMTnlSc2FLWXlUOVQwNk9EQXlLSk85QnhY?=
 =?utf-8?B?bFZ3aFNxekFTRFozOFFlUWF5SmlNVDNrWXpMTmt5bVp4c29KdXBJT01SQ0Nk?=
 =?utf-8?B?NStzNWRYaWplWHYrbi93ay9McGxBejExMXlnNlRZU2JnMVpKaDdieVBQd2kx?=
 =?utf-8?B?eHM1L2lCdDN4QnljMUFjci9rSTBoZHJsSUR1Q3pmZXl3SThZUFhXRDdYaWIw?=
 =?utf-8?B?NzV2T1czQXVzSWRteldrZmlMSUZhSUpmOEZkeEFBK1Z2QVNNYlVUa0VSQlRk?=
 =?utf-8?B?QmhLYWVEK0tTRW1URTdkQ2kyeS9wSWNPbDIrUTlZbDgwcUU5U1ZLQXhQSzlN?=
 =?utf-8?B?WDB6NTZaOWduakh5bTBBRy9MQkxKT0dLNzNqSFpvV3RkNVFjb1l6ZGk5Zkt2?=
 =?utf-8?B?bDlzbmYvVXF4NjlkZzFHcFdPZThIbXR3YXhEK1NZU3M2TC9mWE5ucU5KRWRn?=
 =?utf-8?B?VGxva013S2YyNWsvaythY3FiMkZDM2hrNFhMVjRGbHRIY3ZUNEQ0dlJQM0p0?=
 =?utf-8?B?T3VLRHdEVHNtbVp1Tk9rNldVWmxtQ3lyaVdvNWp2NlNqQ3FKeGgyVDBEa0ZQ?=
 =?utf-8?B?SFVuOVlzajlDcGpmSzlMbVRSTXFBU2k2TUNHY0hjWnhpbnZxbFVYbnBDUlJF?=
 =?utf-8?B?Zk44dnRrZS9HL3p5ZUkwMjltZnR1U1R6L1BhUnA0bWVLd2pKdzNuajB6Mzcx?=
 =?utf-8?B?WDlkN3diajcvS0xUb0ZaaGxmMnVtTTd0Zm9pdG5qdE54VmxGQnZYWnRqcUFz?=
 =?utf-8?B?REh1UXBXY1RnVlI1bHpPamFvbmxvMHUrcnRnc0E2UHZENGdWZ2xueDJlZi8z?=
 =?utf-8?B?aFp3dm84enNPc3dHV0tmU1EyRnZvOGZLaExkbjlGaHc4M2YybWRVT0wrTGtC?=
 =?utf-8?B?eXptRXZvN013cndyRFJ4NE14WnNVSWpWd2Z2SDZ0OTZ6NGNCdmtuRkJVbG1D?=
 =?utf-8?B?bDBud1AzbVZtSU04VEk4VERuWVFGQlNXSWg0djFVL3oxNEI5djFjNUc2SU9p?=
 =?utf-8?B?b0xuTHI1dVN4cmN0QzE5WURFSXhKQXdxWVdnbUhNYkhUS3Z2eVE1Z1ZIU3pa?=
 =?utf-8?B?T1pMV0VvOFZnQlRFa3h6N2JvVDlMN0o5WFJtVjZySThlb2RDY3B2K2lmQTNy?=
 =?utf-8?B?MGFQODNMVjYwVFY3cnZUTDdOYXdMQlhnL0lINkU2SEt0Y0VYaWZyUlQ3WSta?=
 =?utf-8?B?KzNhWlVycFdsaUc3OXc2cHBGajByblJwTEtlQVJCcWdDVGdVbEs0Z0lMd1FM?=
 =?utf-8?B?SFU2bVA2OWlEdG03SEhYOEh4ckxLMGZUeDZLRDQrS0FUTmp1b3k5b1k2L0xr?=
 =?utf-8?B?Q01vSFRHTkJCOFJkQ0NHZ1QvV0kxV1NoTGZMR0V2eHhDVDVIbm8rMytPN1Za?=
 =?utf-8?B?clpkRXlVQWo3TkFMYzF4K3lzQ2NnU1ZhUHV0N1ZkMXhhVkVkOW9hckpPbVZh?=
 =?utf-8?B?K1hQeHVMQXI5dHJYSWpMNXJwUG1uMFYxa3NwdFZMSlFJN0E5a2FBWnp5YUY4?=
 =?utf-8?B?V3RVVHlLekpIN2JmaXRldVV0TEx1WEp6OEgzSVNqSTFUWVgrZGYvRGpSQm1X?=
 =?utf-8?B?TFlYRFhaYkpZRlZWeUJxeVlNaTVZK3pGSFdMalVyNjZMOExPTjJ4WW5NdHhr?=
 =?utf-8?Q?i3FSY3MJD1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZ4eldna2VlK0plekx2QXZ2LzJrNXBTRld6a2czalAwVWVCczFsRVh3alZZ?=
 =?utf-8?B?ZUUzdjZ6QUc0ekxRbEJOczdsUkhndEtVYWVoVUNtd0NqdUZuM0hBZnFuZmIx?=
 =?utf-8?B?V0J0OXhuOUc3aXIzaG96SUFKc2lYR1BqSngxdVhvbG40U1I2UGtQaDJyWjRs?=
 =?utf-8?B?THFiZnI1emRWaXNwejhLSFJtNHNBWVZzVFo5clNJSFJsOXZwUGhYNkIzaW94?=
 =?utf-8?B?MThNYlovaHNRUjBXZGxXZmpNeXVPaWxYSjJTNWlQejA5a3hWNkp2Kzc2NFNL?=
 =?utf-8?B?ajFwaFpNQmljZXIzbUJMUDBsSENMeW4vYzFaY0pCeEpWc1FCZkhUZmRTY2VW?=
 =?utf-8?B?dGo5Y3RmNitrVWNJbkp5eWlma1JvQjZtb2JRdlF1VnpYdGp0NVZrbHVzcnQy?=
 =?utf-8?B?VVdsR3pPVVJpYlZpQ09YRmxHUzcxZEtZOVdLbEltS25WR1Z1cTc1eEhTajZL?=
 =?utf-8?B?b2NWQ041Qi9qbGdjVVVFN2QwZGZQZ0dSZWwxYTl6eFlwb2pDZE4wc2Vodjl2?=
 =?utf-8?B?eGpPNUEyMUl4bEtiMElzVSsyOGhNN21DR1dDV3B2cWZLYnBGQVN5TUxBTXhu?=
 =?utf-8?B?eDJraHZSYWZtVlRwdGN0VkdTbmNhekJCaGMwUkpOblBJbWYrRTVQeG81Rm5j?=
 =?utf-8?B?c2sxbUVPSkt0Y2VOdXlmSFV5NnFDL0RaMUtxRFdxR0lIRkYwenNVclV4RHNP?=
 =?utf-8?B?L01PMDFiZWlRbTBwZXhuK2hKeTBuRHEwYUlvcXFkYTNiTDE4cGh3SWtWeTRU?=
 =?utf-8?B?ZDl2aFlIbFhrUks4L0x6VkRPdW0zcW1INTFyZE5HRGVHN2NHUUx0YmkwS2dx?=
 =?utf-8?B?ZnJMYjZseWNRdXlCWG9CVyt6THZIVzJ3SEV2czJBYUMxQ3MvdjkrbUduenV4?=
 =?utf-8?B?T3hSOWtEVWxzUktJZGE0ZW5KM3d6eDluazBIOXlZNlVLVVIwcUdzR1lELzNM?=
 =?utf-8?B?WkNPNmJ3cnZGVkxrVVhqSW1PNEVMZ2ljTVdlRmpHZjFNR0MvTEtSN3VPdEcy?=
 =?utf-8?B?Znl3L1hSM1EzNG5hdFFNSnlRMndlYnNqZTJuNTdZS0dhbjFzSEZqcWxBeDNl?=
 =?utf-8?B?R1BPSHJOamZ0NHRVWmFPK2UvN0ZCQmpYcG5sakJCMVNlMlYwSG9tQ2JrS3NL?=
 =?utf-8?B?L3ZoeVRMSC92blRjNXA2U252N1Ywczd3V2hKa01NWUEwdSs0RUhBVHRtZHpz?=
 =?utf-8?B?Y0M3NXA1TDhlV0NRekdtZ251VjdtQnhNa1pVL1pnOXRkTmx4S3RKd24zZzEz?=
 =?utf-8?B?QkpxcVhPK3JhNEdPdGlYdHN1Q1pwTUx3MmxVU1RkamtDNXljbW5TZ25sZ25W?=
 =?utf-8?B?aXFrcDI0MDNYRThhbFpiVnJzSEE2NWdqTWQ0emd4b3FiNDVkSEhiS0o2K0Jj?=
 =?utf-8?B?ekREMndMUUhWRmFZQ0xmVEFxVkFjamdRWktXTHhoTzNvOHZsRG9DNEhSdjlZ?=
 =?utf-8?B?UjRualUrbm9VUHlTSkJQTGM1S25BMm1GYXo0T1VOMkw3TmU1R1VoN0diajU5?=
 =?utf-8?B?REJXNkI1RjU0eEF4ZlFRSWQzRDF1b1R2djB2bnN5cVROakN1N09wSStDOEta?=
 =?utf-8?B?RXIzQlBKcnU4S29iUFRZMERQckU0WE9CTGhoVDJyQk5nUWhwditQZ3RvU3pG?=
 =?utf-8?B?S2tYNVQ5RFhsT2xqeEtpcm1XdUp1Z2poK0ZwdytZQUlyY1Q4M2tqZVJoY0sx?=
 =?utf-8?B?dWlnQllWYVh6S0xuNHJwQ0NKN3g5RzVqUXpIMUFDZUh5Sy9XaHpYenk0WUMy?=
 =?utf-8?B?Wm9pSU05THdLRG1XZWUvYlRuNG4rYzExUHJMM1JPd3pUam9wSjh4eE5PV09x?=
 =?utf-8?B?a1BTMGdlNTVwMUluYS9TNkZUSEFHcU9hSHNrb2hBVUxxQVp2UFRmYSsxNU15?=
 =?utf-8?B?Y3JpU2NIVjhaSWVyZ3VCdklNbjlNWHV2WlVudTVzMjVqUGFuWTZqbTQweGJH?=
 =?utf-8?B?czhGNVpsZEVjdWR3SGRMZS9NQ2tCaGtqc3NGaVpwdUhDaFV4cUovYk9qaUpW?=
 =?utf-8?B?cXBLRFBQdWdjeGJhN2dOY2NuZEk3YzVuVUlUQ0I0RzZiRDJjbjBNclVTMTNl?=
 =?utf-8?B?Q3FWc293QkJsUHRpbFZKTDB2UndrdGhvb2VCMTlDQ2Zvb2c2UEdQTFVLd3BJ?=
 =?utf-8?Q?FIMEY/EDcK1o4ZxznXl5LOFCY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c7e5e2-618b-42be-fb8c-08dd94b1dbd4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:42:57.7285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnGNr0hEB+DLiGSFeL+NVD61hJiHEL6ynDzttxQTHtID48HYgta0YhNGo6XQ0uIULzf9h0+eD9XT/dCm1vTiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

On 5/15/2025 5:16 PM, Pratap Nirujogi wrote:
> ISP is a child device to GFX, and its device specific information
> is not available in ACPI. Adding the 2 GPIO resources required for
> ISP_v4_1_1 in amdgpu_isp driver.
> 
> - GPIO 0 to allow sensor driver to enable and disable sensor module.
> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
> Changes v1 -> v2:
> 
> * Use fixed "isp_dev_hid[ACPI_ID_LEN]" instead of allocating using devm_kzalloc()
> * Instead of "pointer to pointer" use "pointer to array" type arg in amdgpu_acpi_get_isp4_dev_hid()
> * Include error code in the debug statement
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
>   3 files changed, 62 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cc26cf1bd843..2aa7e89a190e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1657,10 +1657,12 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>   #else
>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>   static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
> +static int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]) { }
>   #endif
>   
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index b7f8f2ff143d..c39d3a09cd04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1551,4 +1551,33 @@ void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
>   		adev->in_s3 = true;
>   }
>   
> +static const struct acpi_device_id isp_sensor_ids[] = {
> +	{ "OMNI5C10" },
> +	{ }
> +};
> +
> +static int isp_match_acpi_device_ids(struct device *dev, const void *data)
> +{
> +	return acpi_match_device(data, dev) ? 1 : 0;
> +}
> +
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
> +{
> +	struct acpi_device *acpi_pdev;
> +	struct device *pdev;
> +
> +	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
> +			       isp_match_acpi_device_ids);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	acpi_pdev = ACPI_COMPANION(pdev);
> +	if (acpi_pdev)
> +		strscpy(*hid, acpi_device_hid(acpi_pdev));
> +
> +	put_device(pdev);
> +
> +	return 0;
> +}
> +
>   #endif /* CONFIG_SUSPEND */
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 69dd92f6e86d..574880d67009 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -25,6 +25,7 @@
>    *
>    */
>   
> +#include <linux/gpio/machine.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -39,15 +40,45 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>   	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>   };
>   
> +static struct gpiod_lookup_table isp_gpio_table = {
> +	.dev_id = "amd_isp_capture",
> +	.table = {
> +		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
> +	.dev_id = "i2c-ov05c10",
> +	.table = {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	struct amdgpu_device *adev = isp->adev;
>   	int idx, int_idx, num_res, r;
> +	u8 isp_dev_hid[ACPI_ID_LEN];

I don't think this is going to happen in practice, but because this 
isn't initialized you have a case that the ACPI_COMPANION() isn't found 
and thus amdgpu_acpi_get_isp4_dev_hid() returns 0 and there is garbage 
in isp_dev_hid.

I think it's best for amdgpu_acpi_get_isp4_dev_hid() to check acpi_pdev 
for being NULL and return -ENODEV to avoid this risk or isp_dev_hid to 
be initialized to NULL.

>   	u64 isp_base;
>   
>   	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>   		return -EINVAL;
>   
> +	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
> +	if (r) {
> +		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
> +		/* allow GPU init to progress */
> +		return 0;
> +	}
> +
> +	/* add GPIO resources required for OMNI5C10 sensor */
> +	if (!strcmp("OMNI5C10", isp_dev_hid)) {
> +		gpiod_add_lookup_table(&isp_gpio_table);
> +		gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +	}
> +
>   	isp_base = adev->rmmio_base;
>   
>   	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);

