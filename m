Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6045C021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 05:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D8610E8C0;
	Thu, 20 Feb 2025 05:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L3IuZfQL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3367B10E8C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 05:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8JlggDPsoZHF6tRH40nMX8Dia7FqwqPNhtq4PXgQsHes/tgBFXMSbi8epym4G8+2uvWbJLoNt00bsvu7WoPLRQwxqdKE34HrBeX7o8Tn0DJRsW7V3z01kpich7dtUlCEOqTXQF+dYJxnz/XRstifNyYb4MmmbyzFf0tVkhkZf+48aGMLb9mlPWdrst22A4Ez1IKsAgXe820xNO6+ZkqZlfjWEjDM/sD/5YcJ7c6TvqyrsJi6Hx6ADtpaeSMDVztNA7mcNw6gtbmmQKUaBQO2P3wrxM9b1wgCLpnsPpdWqz5FPrhL2PjuracFbIqZZFAlNGbKHX/FVSJmvhXBKsZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mkEyovSf5gFWl6Ro0KHNNxQcn4AlXvLMI0IA8/+i90=;
 b=ixJk4JHjPRtktd1xej4IE7j68FeREe9j6/RRKGSg2efdewAYoUJNcbnVabHkUh3Not1VVfOyjcV+3k2AordXupVS66XI5a6aEHy3H2s2J8auomF8JaCX2dy7Q/k87h4e258qctZgEwxkJAU+na/CqKGPC3fmsQSxvuK4LPBSKkvFLt6kLPVnOPmK3j/xXg+U2C1C/KaQbAd88MJZ/2YrV2M0R28YgDp0SRLQhLt2t3Ys9cYBvR6hROo7eCEjJqLCi4YVrvZbVZQA0f39XZ+l9+4ypr/3L6zvtWB70ILa9towuMPj9Pvv4oBYwTUfPc1cWVTsImgYtWYPWSjvvQZYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mkEyovSf5gFWl6Ro0KHNNxQcn4AlXvLMI0IA8/+i90=;
 b=L3IuZfQL97zhLG3aJz9OfcgVgXPuPEBfutxV9t1mHogGKE2wGL0dO3opn38KYc5taBr4IriyECb9MGiInrg1/tODCfYDgzk9/uPyjWHO/y7kZCnL2+jDwR2gwtrabAn2zuPTMeFksgVHi/BCGF+hmgCHhDJXdIKq1w6jB9MBzec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 05:41:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 05:41:29 +0000
Message-ID: <ebab1f3e-2f87-49e8-9801-6477febc09ba@amd.com>
Date: Thu, 20 Feb 2025 11:11:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250219090509.3559015-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250219090509.3559015-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b57b82-ef5c-4c41-6d52-08dd5171398d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWZYMmhQUWh2Z0tKdG9YTmFVVnFJSHNsRFJBTGlHczJrcnM3MklxQ1FSNWFL?=
 =?utf-8?B?QkRpN1d4R0tKV2UzZGNBTDJaWG9MLzBha2dxRzd0czVqVUw0VFU1eHVHUEZN?=
 =?utf-8?B?cXZUbVdla1VkZ0drekM4U1FjVEJWRERuRlZEWXpuZDhzVVpuZFlxU2RiYkFx?=
 =?utf-8?B?Y0VCRm02MUU0bDZhVXhjK1MyZ09jZEJEc1dBaldZT2pSUm9nOFRieklpbUNT?=
 =?utf-8?B?aktxSXozeXRGbDRSOEpyWmREQ0ZmYjc1Z0YxT1Nqb09EWE5tRzVuOXFJc0tD?=
 =?utf-8?B?VTVxT1pERnhsczcxL3FqdnVGTXFFbFNnM1pUb3MvTzBySHkxLzFlcFViVDRh?=
 =?utf-8?B?K1BzNExxZzBjSHJ3S1dCc0ovVndPWk14Z0d4M2xFMHdqTDZ2SGRreWYwNUxh?=
 =?utf-8?B?Q2g5R1NWOXhjNmdFWUVGY0RuT1VHa21RVTRtTTdrQmp5VmVqeGNoNlVPT0p6?=
 =?utf-8?B?SzJTNE01dFpINi9SWXpRQVgxRG9laTlITk5ockw0d3JDY0ZXQ2xxUGwxUnE3?=
 =?utf-8?B?ZzEyaGlGcFd4NzRkVG5Od1RlbHh1b1pJMUVXTGU3WWFYdGdISmM3c0Vud3Mx?=
 =?utf-8?B?MW9sNDRYeU95anhnbEJCVkVML1lUNEx4UkxoL1BmSU14bm5HSVYxM2hkQ0hM?=
 =?utf-8?B?WGYwck05Q0NseEQzSkxrU0hqN2dNTWQwOUJ1UTQ4NndidFl3d3hIem1GaU5n?=
 =?utf-8?B?czJCdmFSVXRCV1ExSVdBVUp0VnlORTh5WDZvUC9SNzJ4a3hmOTkvK2kvN0F5?=
 =?utf-8?B?QkgwYldDSXdNc1BSSndheG45ZmNENm1heklsL0NqdVJ4cVB1aEJzcEwzd0NY?=
 =?utf-8?B?Sm1zVVFkck5uT1Zmc2dQRzhkc21TZWp4MDg4aUhpM05SNU10SS9Vb1lkVW5I?=
 =?utf-8?B?bHNvcmlnTTVWTHFNQ1lzMlZtRmw4UGNJWStaUXdzT2F3RFZ3TCtVMnBxRmZZ?=
 =?utf-8?B?ZmI3bEVHTUx6OHhQVXpBKzFOVkVQcE0xZXUzcWdKdjBkaHlUYzhLd2RBMVBU?=
 =?utf-8?B?cHJqbWpucWNGM1VOalhxdGtoemFlZFNSMWtZRkkycE9kTE4zN2tyU2pzUG55?=
 =?utf-8?B?Ylk5aHFWS0ZXWXE3emU3bHpqREtnbjlDN1BmTytvVEdHblNFdXdxQTRaZ2hj?=
 =?utf-8?B?MGl5Q0M1S2xPY3o4WERUNTVQWG1CL0NraGM1bER4bkFzeGFSVmRiNno1dTRD?=
 =?utf-8?B?dGVFNlFlTHZLU051RFZMblN3MmhSdUNhekUvQUptTVFWSmdqeVlvVE1MU1k0?=
 =?utf-8?B?YTBwbEdvZ0tPTjZqaUtFeEl3VjhwQnp4TjRLQThnenJ1SWk5c0tXeG9yYzBa?=
 =?utf-8?B?Qlk2YlBPRGpORDlPdmF2SGJ4ZjN3bUhTRzZFMkV6WDJTenpzeExNYlcrNEVn?=
 =?utf-8?B?YlRyRmh4ekVVMWlpN1BIU1RSN1VGcFFQOWVrR1JBc3kzeU4wT3NnbXF2Kzlx?=
 =?utf-8?B?SkVHQ2I1aWVxYUxiTDkyZWxHdkZMRXF6Tys5SXFZOTlqelNZSDNaM0N1RkRO?=
 =?utf-8?B?RFV3YTQySmdtOC82R25nUzQvNHlkY0J2SlFKeUxZV0krUlZJVWVpSUMzcUxa?=
 =?utf-8?B?a0NOd3A3dHcyQUtZR1NnOVBFb2hNYlgzNnhOeU1FWXhnbU9DWGo5RTAvRW4w?=
 =?utf-8?B?eGJoYitka3Y3YWJrbWE3TTE1VldUcjBIb2RHOXBOY3Jhc0FqbTBwZ2t0Mm9l?=
 =?utf-8?B?NG9tbHlLODV4U1I2T0NLMm4yYVZPaHE5OHF4RGQ0M3VVYms3aXNsMk9PcUxk?=
 =?utf-8?B?cmtHSUMxa1MyTkN4N244L2ZJNEdiUFZmN0NBZHNJWW5IeHJsVXZDeCtOZnRv?=
 =?utf-8?B?QlJPYW8vOTZHc1NPVVJzSzdIWmlhWDFpbVpHUGdBeW13cFM1N0xCRG5IUXZk?=
 =?utf-8?Q?CBW3kPE/43Ywk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3Eyd2wxR21vRmxrTUltTkMyc000Mldoclc0aERmMWU4K0IvS1Nxa2J2TUVu?=
 =?utf-8?B?OTZYdk8yS3g0eGZ5dlVQRVZJTGpUQTFKcllGVzBGeDZZVlBhY0RsYWxCVzBN?=
 =?utf-8?B?K0h0NVNXZVlqZ2swd0V6TWlPTHQ5Y1hWZTZVWlhYWDN0Wm96SXBUSEtiSkJN?=
 =?utf-8?B?QzkwZGdSWmt5ZDNXSFJhVzVHbHYyN0QwVkM1V3VKM1pQYlhST0xJYzBXeStK?=
 =?utf-8?B?YzFvWXQwTUFxOHJlM0R5Tm1hMS81ZXVXSko2ZXlyZkFMMVNnaHFPbjA2dTdI?=
 =?utf-8?B?YTRLdm11VEQ5TzE0YUtyaGs3Y1o2aHVjWW9SWUxzekg0QTZIQlNjWU5Iemx5?=
 =?utf-8?B?eWdjS3BBRWFNZkRhRmNFUkdGTGZBZGRoZnV4eXhCbEZFS2RPaUhnTWgvdERT?=
 =?utf-8?B?WVJFVzV1ZEJFL1FoMFFWQ2tzMmxac2pHTE5mUmE0K1NuMEt4RlNDQjhXdDZX?=
 =?utf-8?B?NUZRaEMyWmZkWGpPRm9XeUMrZkhKT1AycFFVSkZwVWU2UGRVUU11SFRLczdl?=
 =?utf-8?B?QXROOUkzdm1lVjRRSk8yYUNiT0F0cW9WQWlnTW1mSkdDK1BzakZJeWtxSE5U?=
 =?utf-8?B?aERSZEFEYWVieDFDUCtOS0VUWlFsQk5sNklnek56MVM1OFNlazlEMzgzelFj?=
 =?utf-8?B?N205bkpVOUFrcHFNa1UwNjJTMjg5YjhLL3RQTkYxOHpNMHdJVFFkQW5hdENT?=
 =?utf-8?B?VWxSakVFOVFiTExuK25CTkZmeGRVVnJ2NTVYdE9QM0F6MGUzUWptRjFabGFN?=
 =?utf-8?B?R1BMZFZlNmRIcW1MWk9pL3JscmcwZkZ3MlhFczdBbC9peDgvK1g1dHdBblZO?=
 =?utf-8?B?bnQyY3gvVGp0UEl3d3lXb0ExbTJuc295RytwL1dmdWdGNk03U1JIbEFBeUpH?=
 =?utf-8?B?L2ZNcHFEb0k1YTZRWmdmV3lqeGIza3FCd2tJMWMyWjNUVVhHeFNuWDN3c3Jo?=
 =?utf-8?B?c2t2dGJydDIwemFJWkFlbVhtemtES1hta2t5SStlQWlnUmhJelRDbTB2WHBv?=
 =?utf-8?B?Zi93NUxaY2JmaTZzMGVpZzNVUDM5YVBUZHZrSm5EaVI3MUJySVZ3bDlidFo3?=
 =?utf-8?B?WGVnSUppQzRqSWdEYjF3VzNEc0Z3ZlV4ek5pSlk4L2JuS0dVSkQvYWFtZ1B3?=
 =?utf-8?B?Q0YxeVlmY2JpeFRycTMySmVSTDBPOWFUZW1SZjdZK1ZJR3VBanpVY09hU1BN?=
 =?utf-8?B?WUFHQ0J1Y0ovYTlTQS9FcERXcVIyR3BLN1RQQW9BaSt3U0crbHA2UUZRQUQ3?=
 =?utf-8?B?VG5ZeTFtQ1h2SVQydU1idHQ3S2taYm9HajU5YmdBeHB4TWlvNmJvWmEwdlZC?=
 =?utf-8?B?T0Nmd1puTHBmaVVCKzBTUTREbkp2WXQxVkRFdkZoWEZXNm82aHB3a3hjY2tj?=
 =?utf-8?B?M1VxcHcyYi9lKzlJSis0c1JrTzFyaE9wTGs1REo1enlpZ242bXcxL1RRa2xF?=
 =?utf-8?B?TW43V210UjkrSmZzdFRQVHNjdEtJTzliQlpsL0xtUndVMGpkQW4wZG5URldp?=
 =?utf-8?B?TzRsajJobktwMjZNMXdsMUFPSUk2ZDRBdTBSblovNXB2WXBCeVRhZllnblBo?=
 =?utf-8?B?SzVudlFnL0JRWXZOcmRHeXdZOCtYc0VMV3luc1Rnb09FcXF4TCsxbFNEUjZ4?=
 =?utf-8?B?Q0IyRml0ZEc1RjhGWWJGQTNWdnpsQ2RKVU8ySUMvN1k5cFo0a281eGZ4NklL?=
 =?utf-8?B?OU55Uk1NNUJoaE9JMTZIK3hyNk5WbmZMZ2lsWTJ3aG1jamVENkFuMnhSTmow?=
 =?utf-8?B?d0lnOExrcmQxb2ZwdlFxdFhDc0RZQThlTHRGYW9FcnBYR05ORDhESEhWSjZ3?=
 =?utf-8?B?cEtMWDAxS0dXK2NuT0Q0enRSdm4wNjRuSHBtd0RIQzhxTDVaUm1yU2hCeVV2?=
 =?utf-8?B?UnBzQ3hObVFBc2tRSVYrczVOZnNrOEphNzlxQUpPMEpKbFBqQmNvU0ZvbURt?=
 =?utf-8?B?SkdnNXNSYnQyMTJOcHlySW5JbWw4cmJUQUJVSURXQkZVYnU4YVFwckF5QW92?=
 =?utf-8?B?dWo4a0ZXYlluMHl0OGxrVkRKdkRnOEFPRjBhTUhLUE8xdU5rSDY5eUVNbzkx?=
 =?utf-8?B?MHkwUnFUSmV0d1psTEFTL3A5SzZ2YjRLaGdVcGY3VGZhbE1YaGZSWG9HcmJN?=
 =?utf-8?Q?l7QgIoK9S11cIZft+IP8J7B1Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b57b82-ef5c-4c41-6d52-08dd5171398d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:41:29.8891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GbZFQz2ZPKTJe7P7BvoPJ1IlPNvhiAKQmTkca7KQwXacaQmAZgjfKv4XQHmWnaB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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



On 2/19/2025 2:35 PM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
> 
> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>   allocating a separate engine. This change ensures efficient resource management and
>   avoids the issue of insufficient VM invalidation engines.
> 
> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>   during TLB flush operations. This improves the stability and reliability of the driver,
>   especially in multi-threaded environments.
> 
> V3: replace the sdma ring check with a function `amdgpu_sdma_is_shared_inv_eng`
>  to Check if a ring is an SDMA ring that shares a VM invalidation engine
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 ++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cb914ce82eb5..8ccc3fb34940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -601,8 +601,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +	if(amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
> +		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
> +		 * Shared VM invalid engine with sdma gfx ring.
> +		 */
> +		ring->vm_inv_eng = inv_eng - 1;

This kind of logic has an implicit assumption that SDMA IP does
something like

for each inst
	init sdma ring
	init page ring

If the IP does something like init page ring/init sdma ring or init sdma
ring of all instances followed by init page ring of all instances, this
doesn't work.

The other thing is this is not readable. There is no clear way to know
what this thing is really doing. That is why it's better to explicitly
express what the logic is doing so that it's maintainable in future.

Thanks,
Lijo

> +	} else {
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> +	}
>  
>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8de214a8ba6d..159ebd9ee62f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -503,6 +503,24 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
> +/**
> +* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
> +* @adev: Pointer to the AMDGPU device structure
> +* @ring: Pointer to the ring structure to check
> +*
> +* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
> +* It returns true if the ring is such an SDMA ring, false otherwise.
> +*/
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring)
> +{
> +	int i = ring->me;
> +
> +	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
> +		return false;
> +
> +	return (ring == &adev->sdma.instance[i].ring);
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 7effc2673466..da3ec6655be7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2aa87fdf715f..2599da8677da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  	 * to WA the Issue
>  	 */
>  
> +	spin_lock(&adev->gmc.invalidate_lock);
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>  	if (use_semaphore)
>  		/* a read return value of 1 means semaphore acuqire */
> @@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
>  				      hub->eng_distance * eng, 0);
>  
> +	spin_unlock(&adev->gmc.invalidate_lock);
>  	return pd_addr;
>  }
>  

