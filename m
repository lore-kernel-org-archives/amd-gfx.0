Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7B4C02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 08:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D2410EA3F;
	Fri,  7 Feb 2025 08:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfR88+oA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0DD10EA3F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 08:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezlSEBFArh+rvgLzATqyUVfWhEu0+Ci113/RFk69GkteWaWMMNOC+3lzn0cgpU0Eu5DBpvHyK5MWPy33EHKUdUhuvKHYDVlk61/q4MG5zwt0zY4FIR8dsQkCGIp2CDpnBwMCRXneaAoXHU5g+7L9OirFRnOQ9m8BrcBIMgW2ejN6gy/+Di3Q2SBPjUb5mdKEmR8ViSZQ8d0PvXDxNhLgaIGQNNvyEpsMspnidpVpuy7kuY3lCU988B1DWmRXQrq+qJ7U8zDL3Ym5p5k4qE3l3yr2riuEPKN3wFo9koFnh631nmtzM9A/gTDc6vPr/Yiu0ycb2W/IjKTpwcIYS9rNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8coUIpd4TOZ1Pi2y4cIWQkCyrOwSt6QFkNVr4i8mdLo=;
 b=rohrmKmH5NUmkUwqPog7Exwt5aXGt44tDC4hmd8gq+BTAHoUkRhKdie7RCZL21caxNZ5yttckv033VTD0+j8cPIBCI4yEcf7u9S9Bvejp8+wWf5TAcvmal60lwHFlboadYPe0SXWB34AFMHNzKgFOyLFUMr5skEHOyqfN/To6jEsuKCNHYpHRy3gh3ve7ey2rU0QuEUPKZbHnL/ca16m6kAq29zd7nnnHnfNBNm+Xre8JFhqj3Ag97hcuwGSIcdGILXLnP4Kh/33f0hrZ+teEyaIEh2sqR8G60tPmjgYxaXJt9iAjS3RqlYkYcfzbnUeFvV49wwvN/x+LkzVCXcZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8coUIpd4TOZ1Pi2y4cIWQkCyrOwSt6QFkNVr4i8mdLo=;
 b=cfR88+oA7kr0IxlotEzTPXFB9kwkzYyKgs2b41ofuOtbthLZmtZWoOuIDiBjuw1njAR3xDcwALBTqrY434NJHEJ6ZrJMH5EBBaFXzai0D5jDRrFh4f5aNz/yOvRU8MOenNdKNnVxLBhBxOPI4decPSB7F9bE7ZHne60alhRf8m0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 08:04:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 08:04:43 +0000
Message-ID: <f751810b-a238-406c-a03c-9ee290692ed0@amd.com>
Date: Fri, 7 Feb 2025 13:34:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 2/4] drm/amdgpu: accumulate gfx_off_entrycount in
 smu_suspend()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1738910203.git.gerry@linux.alibaba.com>
 <9253f9f4144fd2e126e6b7307c63eb75764dce21.1738910203.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9253f9f4144fd2e126e6b7307c63eb75764dce21.1738910203.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 704a2eb8-e7b3-43db-b803-08dd474e1427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1pNcDdnTDlyZjZVVTYyaVFkeUZ0M0N2Wm13ZmJFWHpwbjlTRGJBYW5rZXI3?=
 =?utf-8?B?bkp2Qkd6U0FtYW9rQ0x5Rk9aSFZZa0NKSVV5SVNHWVFRWUY5T1NzenFsNEJj?=
 =?utf-8?B?MGk4U3d3YVkzUk1LYXpCUTVTMXlFR1RVZlVrT01kZVdtSzdMdkFUcEdrSjVL?=
 =?utf-8?B?cGVCOTZXQ29kSEVhanlZeXc0TzRZMG5ubVMzL1B3OFVmUUkwWkI5UjVDdHVW?=
 =?utf-8?B?RlBSVkJrM0FiOTdDc0hnSzdobXBJbVBtS2dob2ludHg0R05TUVUreW10WjZu?=
 =?utf-8?B?SDY2ejBuVzR0Y0RRbGZOcVVRMzRuekR6UUd4dXNFNGUyOG1TQUQzN1Nabi9r?=
 =?utf-8?B?dlR4cnhTZDh4Nmx1U2VpaGlsWHFaY2h3OXlFSlA2RkdmN01JNHgzSnllbnNP?=
 =?utf-8?B?TnZuak42Vm9IZlhnSHMwbW5NdU9vMElxNzRieEtIbHA0RzV4dXFTeXd4K21w?=
 =?utf-8?B?TmtENHBHcTN2RzZkNGRhU2Q4RFg4UTlGQ1ZYc0RKdHk2VnpzemlYS3BRNGNj?=
 =?utf-8?B?VFpIaDhkcmkrMGM1VUdWWjh3aWExenBBc25RaTNJdGtPQ0hTWGdqdktFcG5z?=
 =?utf-8?B?ejRFL25qeXA1SmRFREsvM2g5UndsTzdyMU9FelBFSkpTS2JYS2haWFN5ZG0w?=
 =?utf-8?B?ODRtOTlTZmVPMS9iUURpKytLRGc3V1VtZlZ4Vm9pYklJWkNnWG5zVDYxRnlD?=
 =?utf-8?B?ZkZnRGs0b0dZWTBjSy8zdEdCbU5aeWVQUUs4ek9LM2ZmQTdHMXFMeGpqTHdn?=
 =?utf-8?B?SHU5UEo4dUcxUThzbVpYOEVwcit0czUvSldVUnZSNzJtM25vQ3A3T3BXOVJF?=
 =?utf-8?B?MHQxREVUSndXa0FWQUU2MU42RWFLYVpGYldNQTR1REg1QmpOUGNTMXRBRzZE?=
 =?utf-8?B?REFMNDA1WGJnejhPYzBqaFR3VTM3N1FGWmZvSmZwVXh3RE05WWpSbjJMMGk4?=
 =?utf-8?B?NTRZT1o3RXhiNklkTDkzNUdUTGFEQ1pnWkxqZU8xVU1xZjVoZ0N2b1RneWJx?=
 =?utf-8?B?Z3UzTDM5RUNxMDZjRmJYWTMyUDZITElWZTBlY3d1V3RoM0VBMlNnMDVKUWdV?=
 =?utf-8?B?bDJpbm5tYUFFbkNVWWNIcEtnVk5IZ3MwemRwM3laM1Q3RnUzNi9PU2YxSnkv?=
 =?utf-8?B?YnN6aGVrMzIyaWFwQ1UzRi9DU2FhS2lPMWVuOC9ndXN2bTFwM0hWZXdjUnR6?=
 =?utf-8?B?ZW5hd1ZCdHJieitKZW81UlpYd0xCRzVrWnBrbjVJUmhWU2hpL05VYjF0VnQy?=
 =?utf-8?B?MUFqQ1BEdGNDekYrSEpoRTFwK3JpZXNDUVMzaHNZd3ZQcFV2bWFlR3Iwbk5Q?=
 =?utf-8?B?NDkyWGFQS1FzRWNzMmtYOGdYcy9LMjkyMExOTjJ4MHRqOVRpVWM4Ti9Oek8w?=
 =?utf-8?B?ZFVGWjltb0RrV1lvMHhzeWhrNXo2M3BnTEExcS93T0NZczUxc2RaTGZQT0ZR?=
 =?utf-8?B?c0RzemJlT1FJUEJXN2RBMWI1MHIwZ1c1NXZpU1R0QXZvaENGODZPb3Vlb2xy?=
 =?utf-8?B?dGtGK1Q0OFVrYkwxaTVoeXdndkZXb0k0VUZRRnF5UVpDWkdNZkxCVncwVHFa?=
 =?utf-8?B?NHFWUTlPbU9sRitYU2RDMDFmQVNzWkFLODhsWXdUdDVPWmJQRlNvTzU1em1Y?=
 =?utf-8?B?cUh5eU1ncnAwb29LMTE1M2JXelJvR0IxOWphOHQxNzJUZmkxTlBrdjVkM1ky?=
 =?utf-8?B?MFZZRE9xN09UZ2hhekhOMm1xNVBhcGpDZGcyOG13QmEwcHRPemtBZDdDYXZQ?=
 =?utf-8?B?clVQa3gvQ0I4S2ZXdHZ0UFF1ZFI0UHJyc256Q2VsU2F1TzZFODFtQUhBWDdH?=
 =?utf-8?B?NHNrSXR0QU1hUmRmd25XZ1JPYU80NUE3SWxvRHFmVlRLbVg2MWNGLzUwU0xX?=
 =?utf-8?B?TDYrNjJGV25PSWh2OTlUMmo0R0o4czRNTVNiK0VsKzluMXFCM29YUWhBbFFq?=
 =?utf-8?Q?xm51VuMrhbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01lb3VjWmlIU01uUGtMWU54VmxXRGhmTkRrWXphclJSUWNxeklIZEJFd1k2?=
 =?utf-8?B?Mk96RkRhRy9LQ1BuV0FGbTlpWXUyNXcxeThZMk1FcGkyeGNGQTNqVW9LdHha?=
 =?utf-8?B?UGVYYVc1ZWRVdFZYbUEveXZYQlVzcjYzUXhiZDl2TzA0ckJYQWtPeEFMRzRi?=
 =?utf-8?B?aTZYcGwza05JdElkZ1A0MDlBUG1TYmZlb2lDRUltbFBBU2xrZFFBanFncUly?=
 =?utf-8?B?NEpvRWVCWDBIdEVvYTVjdFZvaVN0KzVVc0dBVUtLdHd1bWxZckRwQmVKMDVF?=
 =?utf-8?B?eHFMMmVoclJhRnRPZVBtb3BrYUg3RE50Z3lDdFpWNERlR3FjT1lsOGRRRVRI?=
 =?utf-8?B?cXRCWUR4akt2cS9wSW1FTzFPeHFxdG01OU5lM1VGaVRaMk50RnFiU2FuU2FZ?=
 =?utf-8?B?eFhNcjY4ekZyUGhKdG1IR1ZSL2FmS3dnNklxK1pEdG1jaHpwQ2twZHFUZ0xu?=
 =?utf-8?B?RDQ2VkdXU0E5WDFsdlpxajRiWmNScmxUMllRdmlQOU1ncUFBZGNsdUlSVllM?=
 =?utf-8?B?aVdDSzd1SGpSa2VTU3laVzlWM1BGMmoyM3YzWkdDTW9jWXN6NHNYTW94Qmcy?=
 =?utf-8?B?eXVzc0NyVkdsM3gzUXJLSDJhVlB1QWFUN0t3bXF6cThxYVdQWXBNTXhJSnpB?=
 =?utf-8?B?cGVHWWJVVkgwVTdCZllQVHp1MmkvS01mSnFYRlBhakVzOWllT0Q0UTlpTXlp?=
 =?utf-8?B?T1FkbHM5dnBXeEZVSnFjL3d0aFJsejNqT2xaMWphOFhMbnJRQzA4UGFWUENP?=
 =?utf-8?B?VzNuNWJ2ekFsSWw0ZnVpb3Q0STZ3eFAxNzZNOEpmVmYxbFpmUDA0VkRXNWs1?=
 =?utf-8?B?Nm94WmpzMXdXd1h4cVloWW5weWVHdGVNb25MbE9wek9PbHhobnQ5MSthZVdr?=
 =?utf-8?B?VDdVVjRqcVhLRVVkNC91OS9HaThtUTJVc2JoZzR3VWsxNkVSTE9ZOTBYSDN5?=
 =?utf-8?B?ZlVXSEs4b2M3NzNwOGNMaUFIamJPMy9iUmhDYldDSlcwdzhtWGpqVjEydFhS?=
 =?utf-8?B?NVp0SU94S0RtdUsrYW5aNXJ3UzE5QnBGYlVsZFFwS21MZVlmR015YkVVYWZR?=
 =?utf-8?B?MzRzNitiWTdPTDc2M08xVStETUJTeHNEM0JKRHRTSXBaL1BlM2hqeW9iRS9U?=
 =?utf-8?B?MVZ0SzA5S0VNbUFrT0dRTDRIUER5R3RNQ29GcS9jOWFUVis2U3JDSTRCR2pH?=
 =?utf-8?B?enAzdllQTDh3ZENQS1VSN203bUNXNjVMNzFxYktmeGlOQ0M2QmIvOERlK0Zv?=
 =?utf-8?B?T2s1dnRCNCtGMjh0Ni9hQndXcjFWWDNISGxEYk9qb1VFN0R6QXhYazBxbjVo?=
 =?utf-8?B?STlvdmxESWpBL3pIMzhnWHBBS3Bnc1YwZWNoNStvZ2lzMXBuK1hoYzFyV2VN?=
 =?utf-8?B?Y0dzUndvRXJUbmFpSGNHcVZzTVVtMnRsaDNURkVORkI3RzkvcFBMMU9XU3Np?=
 =?utf-8?B?b2crMitPOWR6L2ZQMU95WWhGR210SnVOeTRHT0FFUG13ZmRvSVBwY1FxYzZJ?=
 =?utf-8?B?cEpOR3FGczkzYlREakdRckxCNWRseVpBQUd4TXJ2RllIUkVSTGlGZ1VYUHpN?=
 =?utf-8?B?SjdoQTY1K3QybUVSVEF2Y3JBQ0ZYbURDU0NQRnVhYlFSRStkcUdxM0tkNnVT?=
 =?utf-8?B?aUFEL3BITFZiNmM2b2xodDNveE5FWWhwUDlwSW8wRDNxaEtMU2VCNzFsZFhh?=
 =?utf-8?B?NXFkbVpjRDlyVXFPSGJ2S0ttT1NWbHVVN3hFbkcvK0pnK2lhSGlNM1ZqUjJx?=
 =?utf-8?B?bm9XUDZrbGxNa2gvYmt0ZWF6K1Q2VVVsUGd3RFVpOWI1MWFFSE04RUcyTllo?=
 =?utf-8?B?WWFPZUJEVEtQQ3JmSXMwbW5aYmNPeWJwV09JZFNUdFIrQXl1K0dSZkYyYWEz?=
 =?utf-8?B?SFpqdlBhT2pOSVVHalVxbllsSEZERUNGcnlZSjJiTlR5ZjdJT2txZUYyd0VL?=
 =?utf-8?B?VS9TeXVUM3BSbnRNZlFkMGR6OWR5cnpYTWtHdmtQTkQxbHF6ZnduWUhzZ3ZT?=
 =?utf-8?B?enZ5c1hpUUZFaGRkVXJyZ08rVHpYYzdSQkRFWFdOWUdwTFNUbTF3THVGVm0z?=
 =?utf-8?B?Z0h1UlBqdVFxZU1sMHJETldwTWQwZ3Qxa09YU3V0OEJGdlYrTDM4V1RYNXg0?=
 =?utf-8?Q?19eGBOAgje4exQSqX9GVazBTB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704a2eb8-e7b3-43db-b803-08dd474e1427
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:04:43.1789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTctvu5KXdFL6ek1fzvbrZjXhO7jDyyXHcvvMVQ1AU7BlGP3jhWA4nMNCNvxt49B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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



On 2/7/2025 12:14 PM, Jiang Liu wrote:
> As pwfw resets entrycount when device is suspended, so we should
> accmulate the gfx_off_entrycount value instead of save the last value
> of it.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ed9dac00ebfb..70a5ab649e5f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2134,12 +2134,12 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>  	smu_set_gfx_cgpg(smu, false);
>  
>  	/*
> -	 * pwfw resets entrycount when device is suspended, so we save the
> -	 * last value to be used when we resume to keep it consistent
> +	 * pwfw resets entrycount when device is suspended, so we accumulate
> +	 * the `gfx_off_entrycount` value.
>  	 */
>  	ret = smu_get_entrycount_gfxoff(smu, &count);
>  	if (!ret)
> -		adev->gfx.gfx_off_entrycount = count;
> +		adev->gfx.gfx_off_entrycount += count;

This is slightly misleading - only Vangogh implements
get_gfx_off_entrycount and its implementation,
vangogh_get_gfxoff_entrycount, is already doing something like this -

*entrycount = value + adev->gfx.gfx_off_entrycount;

Thanks,
Lijo

>  
>  	/* clear this on suspend so it will get reprogrammed on resume */
>  	smu->workload_mask = 0;

