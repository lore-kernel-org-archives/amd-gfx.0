Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AD8C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 07:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444A110E388;
	Tue, 25 Mar 2025 07:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vb0DZD8I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD9410E388
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 07:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUASB0MppnxhhUXlpMV2ug97TwJuLdIlbk+UAX6Zds3pZGkjJbumTMFqOTNkEjUhVDhqUB0I8TQkQpBprw7xwgLYD8EBJGmgJZNkRuFixH6zJUWKtAj71dG5Ss/2CXvkF8b3NJpr0Baxaq0HdCPr0B/GHfIlKWmucRIZATmuinH8xj6VrhKGDrA0AY8H/pOaGpcWmkrmei+P2+X6xUGaSJTDdwMvs0z/WVyoiwso40HV+pQ0rP/QxfK2Gk6W93EEkv9SbxExwvme6lquoJqO6mnhZy//Z7DiKy0/NllGeqGStgF2yPR0l+IXh0Uy1fKhpFY1RalKJbXiki4xtVbICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNtpaj7Qad+UUFNdEPHComoaBHXJH7pqaD5ZyVTsNOs=;
 b=S9GLsziRIy3IIFTbjPpE6KnqEQWnYqIhIAAR5jwAsX3erap1U5THHsSwK/GBad7KvjYrCmw4O4LANwLV/EUveDxlZ3kCfHEwN6jBvf57B+Q+KMNH3kDEKAYpxSNpxQXxCuhizK5KOI+s6XSimERtDIa7Pzkh1m9lrSoWud8crH0dbdekciZCN+xpKHD2mmbSoDj8tzHmgXcI4Sg7/7tlBJHEsqcKc45pv8kJS141NacD+5oSo/FS3MQJKYdICacigztUeYXTHTurIxc3ByefeX+pyaFnal/Qaa4jeKglFqgqGFWqBFuVtsUA/EPXyDiMYz5jLl+DfJOwdchDmYrCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNtpaj7Qad+UUFNdEPHComoaBHXJH7pqaD5ZyVTsNOs=;
 b=vb0DZD8IR7uOKloee56tAJM61APSUFRvTsqWPVxCU5dvhsk8udglCLpulOvLT6JPKviiewKz5wpIINyPvwgBw1F+BrhBqirxQKyzqYfS/2ShoN4ylLHeDCO5L8gal53ic0B6TadLGeKNeL4qNlN+cXGQ2A+m7AdEexHd76rV0pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:36:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:36:48 +0000
Message-ID: <4bbb6c6f-75f9-466c-8ba4-8d1e492699c0@amd.com>
Date: Tue, 25 Mar 2025 13:06:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA"
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20250325071505.312404-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250325071505.312404-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::34) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 064051c8-031c-4524-8740-08dd6b6fcca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1dRK05nZ0tMU0h0L0wxNy9Kc0FydjZnQ2NCZU9pK3VjQUo4aGxabTRPVjcv?=
 =?utf-8?B?ck1pcXlNNStOSmg3NFhZb2ZJSG0zd0JkM2RRZWZXNVp2d1RENnBxY284VWNR?=
 =?utf-8?B?U1g5Y0dxOTVrOFU3S1EwR09sRCtQbXN6STZOUU9rZWFSUVhyaUREcWdTOWVO?=
 =?utf-8?B?WDdOVUFjem1IckJPb213emZUVjR6M29BWEFEMmVjeHF2cHV0OG1VWTZDSXo2?=
 =?utf-8?B?Ylg3THJHRVVnQUxVZWE4QlpnTEZaK2paYitMeW9jUURyU0huZkxhbWZCUEti?=
 =?utf-8?B?UUJRdXlnSGl6RlcyUkxVVjBGcWN4SVNNdkU0SWR5ZU42cmEwa3ArYk9KVkJz?=
 =?utf-8?B?Y25hR3NZbmNiaUFYeHRoT0JaQ29XQ2QrbWxYQU02OFkwKzdPYSs0L3lTYU16?=
 =?utf-8?B?V0VpWHhET1ZDWWk3OEhtS1p4MFVHMVlTZ1E2amZNdjhCU3hNMGp4TXI4SHdm?=
 =?utf-8?B?Y203ZzZYK1pKZk1vUEQ5NkRGWitzcXVJOFAxUHU4NW9zbWV1TWhWZ3pSaytQ?=
 =?utf-8?B?aGticGJEQSt1ZjBMT2RkUUhDVkFCQkJINEhVSC9ieGxocEZCS1JoOWZYZ0lO?=
 =?utf-8?B?WEVPejdmcDkwaTM1U1VIVFRtZE4rTjJnMXVwQzA0bnZVM0UwRFpXVnJjeCsy?=
 =?utf-8?B?dUpKYU9CVS9xeXFRaEM4L0hDQTZ4ejVpWmVkU1diN0xJTlc4aldOYytvK3p3?=
 =?utf-8?B?Uk1vQm9ReTVYZCtBWTRaTEx1TDJCSmUrM1FmWTZlNTlYN3h3YnJRQXd6a0s3?=
 =?utf-8?B?N1pRY00xZHBqU3hIVnptNk5La1RuZ3d4L2NBVWthQ3ZXN3JGV3NCR2NTYmdH?=
 =?utf-8?B?ZUhMZW5TUWYxTElnZVkvQ01Wd3l3Uk5yNWFMeFJvUWtTWTdSRTMvQjVSVWxX?=
 =?utf-8?B?TFJ0WnJBMmp1a1RnMFExTk9DRVc0NWxKRll5ME9VdEpFVGw3aEZLZ3pWYWNT?=
 =?utf-8?B?Mzg3NEtPQlVXYzJjWnhTU1dtWlhTbzJFS29hWTliQ1dDNkdmc1R0SWtHK0RM?=
 =?utf-8?B?WENwWUxZR3ViWldUcDFNUXNVRUtjL3JMcGVYOWZuMG9tSlptQTFuNGVOMDYy?=
 =?utf-8?B?TGVRZElpTWwzdGxycXduSGtXZWJSdzB6NVdkOW1Nenk2MDZaWHRyeUVRdmVR?=
 =?utf-8?B?NkVkeXpQMFEzb3FSSE1OWCtaaUtuMUlhMGdMY21DbTBCbWhEcnFMZGtnaWNu?=
 =?utf-8?B?azM0eTZWSUc5Rzd1YkdWWGo5aWRXeTdDYTBkcCtCbkpZczVDMmRMcnEySlZV?=
 =?utf-8?B?MFBvWnRBKytsVlU4bTI5c2dmQ3NIZEZEZnBNV2xxeFJqVFlqMVM2cHI1SWw0?=
 =?utf-8?B?NFBXWVcxNE9wNkpqK2N3OVh0YWpaanp4SUdPVmJlQ25SVGJ4a3lReXNXbXM1?=
 =?utf-8?B?WWViRGh6YzQzRnRoUGhNYTVTbVNxMG5vNVAzL2swc3Rwc0EyR0RoYjVSclRu?=
 =?utf-8?B?L2wxdHd4SGJKV0hiSlZKUmRlb2d3aFRwOW5GeUVuRlhwajRUb1ZQU0FheWJT?=
 =?utf-8?B?cGRudERxRmdzWmdpZnZ0SG5QWUxkWjI1NFJXSlk1Y1BPZ29FU0pidU94eFRV?=
 =?utf-8?B?andRSHE1NDk5WGdtbk8yVC9lVm8vTzlKcWVMcENCRklvZyt2U3RseDNDNU54?=
 =?utf-8?B?VGQxTDJsNVZZcjg0Mjd3SEREZTdLSkl6V0M5eE9JalE4S0NQUXBvajgxdXl3?=
 =?utf-8?B?T2pqY3hTUU4wOGp4QXh5NFhZMmtIV0wyQ3dKU2xuVGppSUE2MWFqR1JLaGVr?=
 =?utf-8?B?engyay9nckMrT0hMUlJEM0gzZTR2NTBsd0dwcmpvU1U5ekgvc2JCYVBDcEpE?=
 =?utf-8?B?YXBBWHIyclN4R21lNmNGWTIxZGRqQXNzT0lDSjJOQkQ3M3NNc3FreVdrelVt?=
 =?utf-8?Q?14NQYrTIcLc6f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFRR2xSR3hJTS9COGVyTlBoalgzMTM1SUMydFEzaUZwTlVFelVvanpyeFI3?=
 =?utf-8?B?Tks0NENmM2wveUdhdHFGbmNvenBxT0FhcFhEaXFmN2JjY05PcHJSY3grOElB?=
 =?utf-8?B?SlhjS28yWllUekFnZmFPL081ZlA0NWVmM05SNGEyeUErMUFQVThXVUtGUytj?=
 =?utf-8?B?b3JLY1pwc0VvWGRpREpnYzY3NVJkRFUxRWFmWktQMFVvemw0OWc4U1pQOUVq?=
 =?utf-8?B?ZE1EOUtUQ2d1TnJDbVpmWEtqYlBxZjh4Q3Z2MnZDbGxLYmE0azN4QjRlSEVr?=
 =?utf-8?B?V0ROQVVDRDhMSDBWTU45bDl6UzNkWFY4YThXNFkzMG41Y1lVZXg2OXIveFRT?=
 =?utf-8?B?TVBhL1RDdy95eHNrZC9NcTBvZXNtem1yQWhzWTY3SXErZ1JSeXM2cXEyNXR0?=
 =?utf-8?B?MFNDNTB0WEl6cXd3OEx5YStVZHZ1L29haTJuOUdWMDZpNDd5VkxYU0ZlRENJ?=
 =?utf-8?B?anIxM1kvYklzNmlWNlhOV1dPMXBIOERKeDI3Vk94NUM1dTNIQit1QzBUc2g1?=
 =?utf-8?B?Sm90RVlWTThnVlZ6Z3RvWVQzVER0bldHVHV6TEhlZmF1b01aWmlZL3huNVhj?=
 =?utf-8?B?UGd6Z09malZ1TWs1Z25XUFFuSVhlNCthWm13VmYveVpnSXNlUjFqdUtxZE1X?=
 =?utf-8?B?YzlmRzM2R2pJZEpENnBaU3o1aE1ER0JaUGhKZ1NXS0lHQWZSVVQ3ckxiWjAv?=
 =?utf-8?B?Niswc2JQQmgvUTNTVlQ3aUY5b1A4L1hER3A1N05Wcis4VzkzUklOWWlKaUlX?=
 =?utf-8?B?LzFtYVA0bHd5Y1lpcGh2TTUvbW9QZW1QU3A0MEZRTU1Yek04V05MV2c2TzdC?=
 =?utf-8?B?OEMvNTdBSmlqNFBmRmdydXlmenQ5eHBwU1drSXlhUi9LT0crVUFpWmxNd2NL?=
 =?utf-8?B?TWIvR0ZPYTQ5cnpiVmpNK3BmSTNIWWY0NGlQOUdTSWtsMDhGWk51R2dDZVlo?=
 =?utf-8?B?TXFQd2t5Zm45TVVPbDNPZmZYejdYWGN3R1NjSFVrRTZ3VnkwUEJUWUhuaGtH?=
 =?utf-8?B?ZVZjY2lvYWllZFRrbzkvREFtWlVlTUY1bmtxSk5UWlhBblI1OVlobForK0ZP?=
 =?utf-8?B?WWhvVnB4N2ROS1c5cjN3bFZ4d2pQNGtxNHlZRHNJdzNYYWJkSVVXQ04yVVc4?=
 =?utf-8?B?NmFtNVNzTUkzWlJkQzU3cE9Rc2JCSDBncDhIeFJJS3p1L3l5RytWN2RwWWhr?=
 =?utf-8?B?Lzd3bkdSY1lTWnhrOVBoVkZrTkliMklyY1lkZ290TjUzSUs3S1FBcnVvTTRZ?=
 =?utf-8?B?MmZ4VVROMkdsUjBMbi96VHhZTkhQRk51clhleHpKUTlPWlozMHA4TXloeWZT?=
 =?utf-8?B?WGlJMzlhRGxmekozT2wrb3JaRTdZanNtOXMwUjdzZ2hFdE9xL2VTaE4wSGZQ?=
 =?utf-8?B?UFpIT05mcVQrN2R6a1VSb3pWbCsreWFVSU5xUEg0cDFEcHdqSEdKTG9HMENV?=
 =?utf-8?B?Q0NaUVZPU1A2MW1mVTdod1AvN2JxSjRPeEZ4WlFWeG51S3E4eTRlYXEwaWZv?=
 =?utf-8?B?RWdCQm1xZVRWUEljaVI0VG9CUGlzamU2dm5Bb3E0YnA1clBJaksrNzMwemR3?=
 =?utf-8?B?MUVqNlVMSmp0SFYxbWpOV1JyRG5iQndkMGRRMXRCM2ZWdGJKN2hUN2JjWm1O?=
 =?utf-8?B?V0s2M21tL0ttcUJHZDNPMDhuQ1YxRGJFRkYrQ0NiWjUrUnJUNWR2ZVNKWDlE?=
 =?utf-8?B?ZkZFbXVsN2ZTeTZkMituSzR5Ly9xZy9CdVV2L3NUS01ZRnliVE1TcEtSRGdJ?=
 =?utf-8?B?Y0dnZUtIZ2FuVDJPSlQ4OHFld1VrY3E0UzlBM296eDdhMk4va3IwWjUzZkM1?=
 =?utf-8?B?aE9SVGUzdmg2N1MrMjRMNGdneGhWY3lreVpVWGFsTnBOM09EcUVsT1lEOVNr?=
 =?utf-8?B?WXRPTHIvWnhsQXFlZUthRndpTW1MNXdOZUxvNXpQTTk5ZGxNYjRIaFZGZFcz?=
 =?utf-8?B?N0dNeGIyZThNREFuS3Jhb3lWYjd0MnBCMzYzeUtya0VBOTNML3o3ZEk2dTNW?=
 =?utf-8?B?dE1BUzVzUGRYOWhoRnFSK2pLS1lDeEEzcWJHbzF4Ujdpa0l0QWhjUmRxWHBn?=
 =?utf-8?B?OVkzY3FaeWtYTDFTV2FRYXVRMjBNZXEzNzJ3OHpvZjZPZjJEWVIwRzdjRHAw?=
 =?utf-8?Q?Awc0T8V1CMlfWIK4mjZ2CFdgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064051c8-031c-4524-8740-08dd6b6fcca9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:36:47.9155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srnJBPoKko9dSNvo5hxAtNwzqm3Hay1qzDDr11OfVBgtekY2uhpjauEYWs1f9Cx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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



On 3/25/2025 12:45 PM, Jesse.zhang@amd.com wrote:
> This temporarily  reverts commit 47cad92043909928d7260b77e7a996a0ae043f8c.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 ++++---------------
>  .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 70 -----------------
>  2 files changed, 14 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index dc94d58d33a6..ea2d8f28b126 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -31,7 +31,6 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
> -#include "gc/gc_9_0_sh_mask.h"
>  
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1291,71 +1290,21 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>  			       seq, 0xffffffff, 4);
>  }
>  
> -/*
> - * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
> - * @vmid: The VMID to invalidate
> - * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
> - *
> - * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
> - * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
> - * L2 PDEs) are invalidated.
> - */
> -static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
> -						uint32_t flush_type)
> -{
> -	u32 req = 0;
> -
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> -			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
> -	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> -			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
>  
> -	return req;
> -}
> -
> -/*
> - * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
> - * @ring: The SDMA ring
> - * @vmid: The VMID to flush
> - * @pd_addr: The page directory address
> +/**
> + * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
>   *
> - * This function emits the necessary register writes and waits to perform a VM flush for the
> - * specified VMID. It updates the PTB address registers and issues a VM invalidation request
> - * using the specified VM invalidation engine.
> + * @ring: amdgpu_ring pointer
> + * @vmid: vmid number to use
> + * @pd_addr: address
> + *
> + * Update the page table base and flush the VM TLB
> + * using sDMA.
>   */
>  static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
> -					    unsigned int vmid, uint64_t pd_addr)
> +					 unsigned vmid, uint64_t pd_addr)
>  {
> -	struct amdgpu_device *adev = ring->adev;
> -	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
> -	unsigned int eng = ring->vm_inv_eng;
> -	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
> -
> -	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> -				(hub->ctx_addr_distance * vmid),
> -				lower_32_bits(pd_addr));
> -
> -	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> -				(hub->ctx_addr_distance * vmid),
> -				upper_32_bits(pd_addr));
> -	/*
> -	 * Construct and emit the VM invalidation packet
> -	 */
> -	amdgpu_ring_write(ring,
> -		SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
> -		SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
> -		SDMA_PKT_VM_INVALIDATION_HEADER_XCC0_ENG_ID(0x1f) |
> -		SDMA_PKT_VM_INVALIDATION_HEADER_XCC1_ENG_ID(0x1f) |
> -		SDMA_PKT_VM_INVALIDATION_HEADER_MMHUB_ENG_ID(eng));
> -	amdgpu_ring_write(ring, SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(req));
> -	amdgpu_ring_write(ring, 0);
> -	amdgpu_ring_write(ring, SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(BIT(vmid)));
> +	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>  }
>  
>  static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
> @@ -2177,7 +2126,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		4 + 2 * 3 +
> +		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> +		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> @@ -2209,7 +2159,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		4 + 2 * 3 +
> +		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> +		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> index 3ca8a417c6d8..8de4ccce5e38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> @@ -64,9 +64,6 @@
>  #define HEADER_BARRIER  5
>  #define SDMA_OP_AQL_COPY  0
>  #define SDMA_OP_AQL_BARRIER_OR  0
> -/* vm invalidation is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
> -#define SDMA_OP_VM_INVALIDATE 8
> -#define SDMA_SUBOP_VM_INVALIDATE 4
>  
>  /*define for op field*/
>  #define SDMA_PKT_HEADER_op_offset 0
> @@ -3334,72 +3331,5 @@
>  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift  0
>  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETION_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift)
>  
> -/*
> -** Definitions for SDMA_PKT_VM_INVALIDATION packet
> -*/
> -
> -/*define for HEADER word*/
> -/*define for op field*/
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_op_offset 0
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_op_mask   0x000000FF
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_op_shift  0
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_OP(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_op_shift)
> -
> -/*define for sub_op field*/
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_offset 0
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask   0x000000FF
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift  8
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift)
> -
> -/*define for xcc0_eng_id field*/
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_offset 0
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_mask   0x0000001F
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_shift  16
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_XCC0_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_shift)
> -
> -/*define for xcc1_eng_id field*/
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_offset 0
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_mask   0x0000001F
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_shift  21
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_XCC1_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_shift)
> -
> -/*define for mmhub_eng_id field*/
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_offset 0
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_mask   0x0000001F
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_shift  26
> -#define SDMA_PKT_VM_INVALIDATION_HEADER_MMHUB_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_shift)
> -
> -/*define for INVALIDATEREQ word*/
> -/*define for invalidatereq field*/
> -#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_offset 1
> -#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask   0xFFFFFFFF
> -#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift  0
> -#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(x) ((x & SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask) << SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift)
> -
> -/*define for ADDRESSRANGELO word*/
> -/*define for addressrangelo field*/
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_offset 2
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask   0xFFFFFFFF
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift  0
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_ADDRESSRANGELO(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift)
> -
> -/*define for ADDRESSRANGEHI word*/
> -/*define for invalidateack field*/
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_offset 3
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask   0x0000FFFF
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift  0
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift)
> -
> -/*define for addressrangehi field*/
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_offset 3
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask   0x0000001F
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift  16
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift)
> -
> -/*define for reserved field*/
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_offset 3
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask   0x000001FF
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift  23
> -#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_RESERVED(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift)
>  
>  #endif /* __SDMA_PKT_OPEN_H_ */

