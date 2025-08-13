Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFDEC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 05:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD8210E1A9;
	Wed, 13 Aug 2025 05:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DvM3vS/N";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED1D10E1A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 05:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2N3vWHmnACQkat+0RKTUzLKuC1O1Om8PXCauefy/kwwm+AiTnx8XfUbJYrd1Mb/HvC/DoeLq3XN7YETWkcYZw3wJKP2N0EBi7MlBe53yvIJ+Ha+knjljT89JRyaxl0w0/GqdSKtSrQ8mi04aNpHrpwbLURPoeqRqbOsZvPIqnofd5I4HojJ+8MkHf/f/JdQTU/+8UtdEf5E8USwoxqv93IaOX9v79J6FjVvo677sIhn5OYWJaaTigNzum0+XiRUomwzwWZ+bUcHhP+UyPR+it/Fqh4Jc1oMhX4QQxpeG6tc0tA+E5Zw5kAxQB6vNUIvpp+JLfndCh02ZtJPXb70og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x46nrAj1r0x14aeiExv92fZKiiPcODnF8reE4SPVZrU=;
 b=oUv1UR72bIzbXij3Q7BPSvPqmElIlgg9aN/8rJiuR8/JG6ERWHcw9gibYGgvBjVUGXaankJe09jlY7T+xcqJDyyqNtBIOhnWMTziYYWBdedc/mXx23/aP0VdPv6ZhvK2j3+LjIMRfxQMj0HAH9hZAQmfJqzksnVWwSVi7bXUV9PDMrmyaloGxjLv58+wvBBz7yTUDxmJ1bI73JuxnE7iaY/b8WJJzjhdIZLXjPkm0cL5W/QEp9DTfDI/uha7LF1H4Mf/L0flflr1xldyUI+3UaNnVCe4DRPRrCQevW2lHEmS06oZZp3893iwZA1dqRDbKvXZpU8gIp2NdhVCneSV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x46nrAj1r0x14aeiExv92fZKiiPcODnF8reE4SPVZrU=;
 b=DvM3vS/N7mSnjg/Ihe4KXLN+W9qExH1DYN5zvOlWhGjSRXKcKpZyaZvjAPOtNHxrkOOtylSZhAPZ/ypIFeXpuyqgEfK4CAVtjtrm4QQXnnIqer9E4zw5vzNfUnoXHcnMi29q89kS6OHSwBB3Tzdbe/qgTYzYKWdbr0AmAA75l1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 05:04:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:04:55 +0000
Message-ID: <2d9c6e34-f99c-42db-b8d7-9f4a48345283@amd.com>
Date: Wed, 13 Aug 2025 10:34:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 2/3] drm/amd/pm: Add VCN reset support for SMU v13.0.6
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
References: <20250813040851.3435890-1-Jesse.Zhang@amd.com>
 <20250813040851.3435890-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250813040851.3435890-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::8) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 95388645-a2db-4c51-5c7a-08ddda26f0a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlFvR3FpSGJ0YTRnUitrdHl6S0RtV2tnUE1kejJOZEhQREo3ejhVbHdSU091?=
 =?utf-8?B?VHFzSDRvd1ZLNTVOQkhVMElmdnNxYXFiMzhCdzNwTHJaTlJVcGtZM2tldVQx?=
 =?utf-8?B?UzlEM0RzMFRCNmJuWEY3SzBveXpqaTF3WC9LWjJMOHBSd291YU9KTFZ3MFM2?=
 =?utf-8?B?TlQxVUlOZThReDRiV2NQSFZPTXRjaTlhRWFFVUpjSU1tUEtwN0t1ZGpTM3hH?=
 =?utf-8?B?OE0ycmZrT3pSZWhwZFAyUEU4NHVJbFBIeTA5USs5dzF3c1pkZUtMcVdnZlJU?=
 =?utf-8?B?akxDUnh1TTZQc1NURTlqZUp0VGVIbFFEZ2pVNU83S1JlazNpejl2eVZxbjYw?=
 =?utf-8?B?OFpidUFIWnZHcnRNNzNJb2UrcGdXZnhWejFrQlNmN1lKTkp5YU9BNkFLT1Bx?=
 =?utf-8?B?QmVxcmYxWk0wRjk0UytTdE92b0hxTnA5WENLWEM2bC82bjM1YmlVSjc3cHV5?=
 =?utf-8?B?N0J2VFJTQ1Y2R29DVFl1aGk1UWdaMHNnazd2ZzlUTVFqUlhiN3BMWTdvYlFG?=
 =?utf-8?B?aEpGYTdCK0djeGhXekpQaDA1bEtRMDNCTUNRKzlMRU5XcEcwQ251TTlVUGFC?=
 =?utf-8?B?bzN3K3EzNWg2TjJNZ1FWeFdiaXRXK2FSNnB0L1ZIeWRvTDlzc0ZDc293djQy?=
 =?utf-8?B?bFhTUDlDekcyNzlNbURLSjJmYW82WVVLcUw0SENUVi83YXVVTEpUbUEzVXhF?=
 =?utf-8?B?endOVEJBV3ExcWcwOTZxdE1VOGFyL1BlTm13dGx2Yjg0ZWt3bGVRUnhkMXZL?=
 =?utf-8?B?L3JjYmVuckJkVjRtNzZsUXRtbzZiQmpPclEyb2dHN0VHUVljd29xNzNrUkhB?=
 =?utf-8?B?c25MdjAyelVFaFFDYUlMU2ZIQ1FaWmk3UGxjTXN0YVZOQi9UQ2NhMkdnTmU5?=
 =?utf-8?B?SGRHdmwzbWJvdU1mNHFnUmpvenMzVys4MjJIcnNhSENET2Q2b2t2VmFCSS9I?=
 =?utf-8?B?T3I3Q01TT25ZZ3RyOUVYOGt2UDAvbDVOcmUxQ1k0aHRER0tSZzRXMHFXN09O?=
 =?utf-8?B?M1lwTXNRdXdRZlZ1TmhBVUZGbVVrOXpjNHlMZXVmVHBCeFQvQlhDZXpoU0sw?=
 =?utf-8?B?VHdyd2VwNXZyL2hOSlV3ckFRZFI4cDdzMWV5ZmV0OFZScGhZZzlnczRYZ0w5?=
 =?utf-8?B?M1E4b2h1VnZVYUIvV0g5dmdpT3g1SjBJbmxhMTJyUHBzdUVhM2RNdnJGWjdv?=
 =?utf-8?B?aEp5Rm9xT2JZNjJOampxM3lWclgwd25vQnEySzdDbHJ0VC9ONzIxTFBWK2Z3?=
 =?utf-8?B?ci94aUxXMStyV1ZwZEs4MmkrVHJxMkorazVteElnT0hFcEZXRjJLOGJHNjB2?=
 =?utf-8?B?TjhlaDlJZzdraGhqbnlnbVJxZ2NKSG5mejg4THlYVmFhMlkwMlgwNE80d1Vn?=
 =?utf-8?B?RmlSUGl6bENObEJyekZzM2VxWEliYkZmYWNIQit6K1p5RjhVcE1qRjJNYjZi?=
 =?utf-8?B?anNRU2RucVNwSGtxOGxJdENXS1Exbk44ZGorbWhodkFjNEFJcTI0Y3krb0JT?=
 =?utf-8?B?K3E0Rjh0dDIwMUFTRUp6Y0ZHMGk2TjNQbVFtVmRCRkx4ckdBYmdGUFhKNWxz?=
 =?utf-8?B?dWJYWjI4YkR5dXlnR2dET0pSb3NLQWNBWVlvdHlabGVyRW1haGljVWxIVExk?=
 =?utf-8?B?aXYvU25Cb2I1enBjSEx0ZTdkd2lFY2ZyVUZKcTE4eTZua2F2ajhHQzdoM3FD?=
 =?utf-8?B?SFVyaVcrUXgyaTdaNzExSnJJbjQwZHhhZ3R6RE5vbFFhNnhzbWpkcCt0QlNS?=
 =?utf-8?B?Qnd2OGhXcWtvOFZSaEY5WjN5WFlKRStJQ0w5UHNibjRDaW03MmZ6RnAyM0Vt?=
 =?utf-8?B?bm44V1V5eGFiTVFXa1VFSWtBdFBJcVVSZzZqZ0VTMzc4NWpDdXVWZGpRRW1Q?=
 =?utf-8?B?dFRUdDFKNnFrS3hic0RUc0hkZ3E1U29ieFlXSVpmb28rVjY1YnJORDQxR2JI?=
 =?utf-8?Q?9T5OtLgBGaQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjlhWXM2OEVGWEV3am8ybHNoZUU4NVN1Qk9reTVnWEUzNG1KakJSbDFWa05k?=
 =?utf-8?B?SE1sQ0MrRzJ4d01QL1JaRkVzTFlqTTNFbXpLNkNQTzlYT0E1SnR4ZVdmb3cv?=
 =?utf-8?B?WXQraTMrbHEyUTQrN1Y5WkFOaE1PVEd5WUJOYXBRZlRwT21odExvbldhM0E1?=
 =?utf-8?B?b29LakswdjdsTHUvVk5FR0dwb2JhSGNWeTZ2V3Jxb0RqN2xyY3pQWHNyQ1Va?=
 =?utf-8?B?NWRkNU1rdE9SenoxZXUvbVBKdkE2VE5RNnJESC8yZjdWam1tT293Z3FRcDhv?=
 =?utf-8?B?Qm5lazMrS1hsQ3BxUHErZnphMWxUOTkvRUpMOStvK0h0bVk4dFhJZ1RZeUhY?=
 =?utf-8?B?cUo2RklJOTM0OWN4VldDZ3lQOWdDS2k1YkhkOGN3VXlpUG4xQ3NFTk01ZE1p?=
 =?utf-8?B?V0ZKRGxhTkJHcGszVnVFUzZPVmJDa1lHQS9Qek1qSlBZS2NRZHBNQVdEa3lQ?=
 =?utf-8?B?NDI5WmVYZEU0YVZBZlFtMWhDaUthZm41dVZZQzh1NVJuMmRxellNYUdpN3lB?=
 =?utf-8?B?NXMzUmpXM1BwbXBtL0RveU1LVVF2UThndWw5RmRuUFpJczk3RnhVdFFsOHJq?=
 =?utf-8?B?MnBBdHhUQ0ZTcGNScjEvVVdVNzByakVzZFVWYlZVcGJHK243ek9xeGdzR0hZ?=
 =?utf-8?B?MGRORXJKUGwzY0xWVmV3OWN3WE9MOHZGSkdNeWxheW5Za0ZKUHVmc2wrak5p?=
 =?utf-8?B?enNyMkN2T2RLMHpXQmhuMmowWFlzTEl4NDN3NFhPbFg2N0JJSGtkaEsyZ0RQ?=
 =?utf-8?B?SU1UM2FMRmtPSGNKcEVCMDJ0cUdVeXR5SHRyQksrbzRxcVkvYldiRFZaVktM?=
 =?utf-8?B?TjN5YytvUGpMTXpJbGNFYVM2Y3ZyS3JxcWppRXpEOTkycGo5TzQxYlJXMzcy?=
 =?utf-8?B?SEZ2K05mRndUY3c1azZ0bHlsYlhtejFMUmVWbU1pQmpPcU5XeGNkVzlKbmIw?=
 =?utf-8?B?TTJ1dkErZS84cE40RmRvc3NocVVZUXgrQ1YyeW9DWkU4UVdXbkttWCsxUHJH?=
 =?utf-8?B?Sm1HZlVRSkNKUFMvYmJsaHkyRXBJV3lwc3drWGlkWmZ1eXA3VUZrZ3pkL3lX?=
 =?utf-8?B?NUJrUzA4RjlZNTJnOHMwQXc5Tlgra1dGVm5wNXRaQndjbFpaQU5PN2pwaUl6?=
 =?utf-8?B?dlVWdklJOW5RMlB6SWMyTFExMS81VlJOallNRW1NbEExMVIyYmp0WE5STWZD?=
 =?utf-8?B?dGpCYVlRN2Q0dEN3dUNPRnFPU2N6Qm9FRm1TeVhscjQyeUs0VXFqNjZZK0oy?=
 =?utf-8?B?OW9pQ3NYQkx4VTNGOTZNaEt5a2Y0Z0x4ajZBM2kvajZtV2ZWaityOFYwZWR3?=
 =?utf-8?B?alZNQ2xURUVLQitncVlVV3dNMVg1TGlGOXJrYTlLbGMrcTdSM1Y3N1Y0cDgy?=
 =?utf-8?B?ZytNV1BhK2hsQjhTQUhDcW0vMFN0RlFZMVZUdE1oV1ZZbEZiQkppUmZON3Zl?=
 =?utf-8?B?dC8vSTZrYWxwbnA0TS9kRldVYzBMd0VsdjAzUCtKZ1lQc05aN1M1d3l5Nlpi?=
 =?utf-8?B?cDIwZzBTY1B6SHd5Vi9PYjhua1cxSWxablBaTEh6MjR5TjdXK3NyTEZoR1BI?=
 =?utf-8?B?QUphVGxiczhTM1hCMVY5a091dzBGMDFaeFRFRm1hR0x5MFJ1S1RtT2tIM29s?=
 =?utf-8?B?SGw3Smk1Uk16SkFkRExiKzlZRzNpS2FLNEFFeWd5Vk5RTTRGamtVRlpBQkFi?=
 =?utf-8?B?SUhUOURZZWg2MU5yUXExUW1Sa0VzRVR2bG01ZXY1enMwcklxUGowNXJkdm10?=
 =?utf-8?B?NmVwMHBrNnVsQmhKdW1LK1NweHBSRDFrcC9VSDNWL2J2OGxtd2ZqS1RRTUFH?=
 =?utf-8?B?b2Y1YVQveXdOUFVwVGRERUQ0VjlwZGkwdzlkMmh6ekE0QStKbWNnbzlWeHRm?=
 =?utf-8?B?aVRWV1BFejh2ck0xTlVKNGsvbDVFcDVuT3BnVVRBbGJQSng2VUdGdithTDJP?=
 =?utf-8?B?c1JGZTZ4a2tKU0xnNXVESjhBZGU0QVJYeWY1UGZ6ZHpRSE1BRVRjNldxSERm?=
 =?utf-8?B?dUpJdGFvd1ZQcWZzY3pYbFlFMjZ4OC9KRkRtN3ZOYjVEM0JMaUdOY0hvQUZN?=
 =?utf-8?B?OEMyWmV2VVhERmFBaVRHNjFWOTg5ZEVLVExPREFsSW83dEJBR09YN2hFOEJF?=
 =?utf-8?Q?klzDKF9uslhhz2MRja3e2Cqct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95388645-a2db-4c51-5c7a-08ddda26f0a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:04:55.0334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hs8f9sEordaHJA7nF/J1mNsweoUupVkiqv7dX0Z7xjAl8oe/he2UuwbgnllG6Wf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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



On 8/13/2025 9:38 AM, Jesse.Zhang wrote:
> This commit implements VCN reset capability for SMU v13.0.6 with the following changes:
> 
> 1. Added new PPSMC message ID (0x5B) for VCN reset in SMU firmware interface
> 2. Extended SMU capabilities to include VCN_RESET support
> 3. Implemented VCN reset support check:
>    - Added smu_v13_0_6_reset_vcn_is_supported() function
> 4. Updated SMU v13.0.6 PPT functions to include VCN reset operations
> 
> v2: clean up debug info (Alex)
> v3: remove unsupported message and split smu v13.0.6 changes to a separate patch (Lijo)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  4 ++--
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 ++++++++++++++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> index 41f268313613..63a088ef7169 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> @@ -94,9 +94,9 @@
>  #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
>  #define PPSMC_MSG_SetThrottlingPolicy               0x44
>  #define PPSMC_MSG_ResetSDMA                         0x4D
> -#define PPSMC_MSG_ResetVCN                          0x4E
>  #define PPSMC_MSG_GetStaticMetricsTable             0x59
> -#define PPSMC_Message_Count                         0x5A
> +#define PPSMC_MSG_ResetVCN                          0x5B
> +#define PPSMC_Message_Count                         0x5C
>  
>  //PPSMC Reset Types for driver msg argument
>  #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 3b4bd7a34d04..db3dd5d5c26f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -436,6 +436,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
>  	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
>  	    ((pgm == 4) && (fw_ver >= 0x4557000)))
>  		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
> +
> +	if ((pgm == 4) && (fw_ver >= 0x04557100))
> +		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>  }
>  
>  static void smu_v13_0_x_init_caps(struct smu_context *smu)
> @@ -3200,6 +3203,16 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>  	return ret;
>  }
>  
> +static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
> +{
> +	bool ret = true;
> +
> +	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET)))

This may be simiplified as
	return smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET));

Thanks,
Lijo

> +		ret = false;
> +
> +	return ret;
> +}
> +
>  static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
>  {
>  	int ret = 0;
> @@ -3888,6 +3901,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>  	.reset_sdma = smu_v13_0_6_reset_sdma,
>  	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
>  	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
> +	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
>  };
>  
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index f39dbfdd7a2f..bcb8246c0804 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
>  	SMU_CAP(RMA_MSG),
>  	SMU_CAP(ACA_SYND),
>  	SMU_CAP(SDMA_RESET),
> +	SMU_CAP(VCN_RESET),
>  	SMU_CAP(STATIC_METRICS),
>  	SMU_CAP(HST_LIMIT_METRICS),
>  	SMU_CAP(BOARD_VOLTAGE),

