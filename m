Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164A2CCA470
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 15:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6C710E2D0;
	Tue, 30 Sep 2025 15:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WOQV2TGz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9881810E2D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 15:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCCQkAdJ0Ckpo+Oy1VeAyF/3FfNWnyFH6alJLVuKxlvAoBdadKAhtcBg2joP7qWY5P9y6gvYY12J3986daDGI84QAQYnxoMMbQ/EqCLh9m7Rs+KRIyBMXIcj8OwJrKZFzN9W6tNykbrmG/2ZmPynp1q5onBc3AdtEarNlPsRPxYJMWnyTY+zqOFIU2IOMzs9lqija22CHVMLxLTGec6MqHl0Hc7FkcM/AgC4C8x9eHYSwicgaTg/hNOgLCBVqHqOI2ENHZ9QnljqpeuO5IFY4etGzSw+q5kmlAzr2syo8mtn5EFL+/AsjjyM8MssDrr4salH7ZEsJZ1LgyiMB8uXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+Febf59go4UXw4OXcB/XTZNopKzADh6hKswyCDRPM0=;
 b=YA4xOmp43aOHzYzttcnTreLBN8KFxrKiLzraYnoe1qHPn6LjY6SBD9k+RP9egQqdIlmy7a/EmLFAj5SZldRickYpcAR2JPYgRNfhceQL1Cf5Xh9S5eBpuAfde57KOj2q5o8FwDCbniLkbZDB0b+NXABzC61rSklgAofZ+KQwKrw6gTRr71rauYbcCwgjbc88GivHU3L99T2qh+yCEGfa1Hl0yRidk87QArySAYhxk3i3o1FUrTMJiEGZ2l7oGNgkctGz4viE1IvqqRGSA2xDq+FIclJZaFzA6JSOjfU6wAuPCepY4IBc31W9elqIicRAUdN0TtGmLKz8gdDPzktg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+Febf59go4UXw4OXcB/XTZNopKzADh6hKswyCDRPM0=;
 b=WOQV2TGzM0kV/QAKuxWMnnIewTGAJHhyTcKwlJtyQEJcvS6GSoN+TtVdpkGLRZA7oASWosaVzDuVTyc1Pr1s1GcPza/rNBtBdP+MNm0h0CCBc8RjPPGTAs+r3cpvkNXopYOSgTdbKuVn4TFn5+LjzB8G6jcUeyuc6J/NyE9Q2jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 15:48:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 15:48:23 +0000
Message-ID: <d4109744-6f08-450e-a45c-3fdd30b2afce@amd.com>
Date: Tue, 30 Sep 2025 10:48:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250926210331.17401-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250926210331.17401-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:d3::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cf1044-0403-4653-70cf-08de0038c952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWNGNkRBUTNxZU1VSUE1N0hWdnB6Y0owYnpaV1dwRUE4TGRod2krYzA3LzlQ?=
 =?utf-8?B?a3ZxY2JrSlBHajAwbkpQWXNOV0VzR0lDNkp4NFJPUUZQUFhoNmptaDlyK3d4?=
 =?utf-8?B?eG9qKzRKVVMzR2JpdjJiNEZYRGlVNGdxUEJnamszSlppcDB5Z1ViakJNV1ZM?=
 =?utf-8?B?MjFmSGVHamZtTnBFOGhHM3NBRzcveS94bmdDbWN4bGwvZk9aTWxoOXF4TW1K?=
 =?utf-8?B?TjN1VnRoQVFsUmM0QTYwNDA1V08za1VRRTBDYUJKZ005Y1N2N2FGZmJ5MTVN?=
 =?utf-8?B?YUwra1FtTjN2UWtLeUFCNFo4dmxkZzBPcy9ubUpwODVpNXFkb21mMHZmUHlJ?=
 =?utf-8?B?M0oycDMvTjlxSmoyVXFkWlNSMWRGWDZKVnc4RUptQkpudHluUmxBR0wvVlFG?=
 =?utf-8?B?UWVpOUtPOHZMbndyTXc1SDF5dHBNTy9JZTNNYlJuREgrTmUzL0hqUUM4MFpV?=
 =?utf-8?B?aHdPdWVwOXh3STN2OXRRbGxwSmFvOGtoRnlRT0o0MXg1dzQ1eWc1RmJuSU5l?=
 =?utf-8?B?d2dtR2NCazBZbjBid24zOUhxbDN6dHh4QUlLeWsxU2NCU0hTVjRLV21yME8w?=
 =?utf-8?B?MG9UbnJiM01KNnpiNGNmdzVQbk1KTllOZ1VOa1ZvZ0FkR25YL3ZZd0dYbWhN?=
 =?utf-8?B?WEc2T0VUMlZrZk5lWkVRNGI1UGRvY2pub1RSRlNvRU5IVUYrODNpUm4vU3Jv?=
 =?utf-8?B?bFVZWjFCSmVRNTJEaUQ1UUJsblZCc3BBYU9oaGtRUXNqd2xGenFDd1pSTndo?=
 =?utf-8?B?aFc3SjJSb0dhRTR2TUl3VDQ2TW5xNndaVmZSZzh2RzFDS3BIQ2NRNEplTlox?=
 =?utf-8?B?MlEzQWk2SGlNdkg0MXkyRUdWaUtPdWFLNHl1dnRQM1l6Sy9HbTBrZDhLTEQv?=
 =?utf-8?B?WDVpdEhTc2V0bE02eXY0RGlYT0VscE96emtnK1BsZS9mZFMxYnhFVTRMa1dE?=
 =?utf-8?B?RFRuNE1sSmRWTmpkVnRibUl2UXBadndRVTJ4NGY3WkFCRlNzSVVoYy91cmhC?=
 =?utf-8?B?UDI4UzQ3ZERpajcxV1FLODNab1Baby9SUnlXckxUMDM4c3JyUUtOSFd4NmJY?=
 =?utf-8?B?YkxTSGJIVkxZNUowcjV4UTc5Y0NIN3BVanhhMmp5b09HOFlFV2NhcWF3K1Vw?=
 =?utf-8?B?Tkd3bGNvVGZDa0hlSWFFMDh0RlFsNnl1dTdMM1hsbWpxamhtRFl4ek0wckpK?=
 =?utf-8?B?cXg2WEhncVJMYWhteUJRSVFSTm1HcFRtM0h2N0pqcG9xMGc5bUdOdURjZ0Uv?=
 =?utf-8?B?cEhIc2hqa0thYkpjVUowRlE4WGwxT1dpUWhaRUdielEwOGZHOGI4aE14WEpJ?=
 =?utf-8?B?aDdWQkhvWE4xTnEvMGZSUTFtVmNubzdXMDJlQmtvNHRhYm1aVjJubkpuMTdI?=
 =?utf-8?B?NWovSjIva21YSUZub0ZoY3k2cmRJdTE0V3d0OWQ1NjhnWFFvMVl0MzB0SXhK?=
 =?utf-8?B?MlFyTXZyR0J3NTBFZ2c1WFlRMEVyUEN1bklFZTdSbStpV3FjUXJhQXR1dGJ3?=
 =?utf-8?B?TFU1Y2tIZXFxbnNwcEVBY2lFNldScU0yNWRiME1wTS9BK2NwWVN6V3N0elFt?=
 =?utf-8?B?Y3pDRFVBcmdxYURCMXV2MmdrL3k5M1EyeWN2UlJBZGZHektBVU05eHl2R2VI?=
 =?utf-8?B?eFJZK1phL0o4S3JmeDlTbG5oQldoY1l6bUE0MXVMWTdsdVpQUTYrWlhJV3VN?=
 =?utf-8?B?bjFSZm5wK05DSk0zZ0FrUlIrSjQrQjIycFNhMGRsc1E2aTlGNUcrRENwYjc2?=
 =?utf-8?B?SlV3ZEVPeHJzWlNZRDh2TFNqSldhR2dheGNiVFhYa2xQZGdLQ3N0bXBaR0dS?=
 =?utf-8?B?bW84anhUWHp6dDlZZ3loTEsrOU1NYkRqTVRQT0JLcDAza2ExeHRlK2htdzVI?=
 =?utf-8?B?OFYvM1IwMjltZnNiNzg4cFhRb1RWaGpFTFJDY0t0QUI1SzgwQU5mcG9ETDFa?=
 =?utf-8?Q?D5cuHLC/S+aNNzqzPYvhFDai+q1WWem6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFzM3BpUFFqb08zdDNQVmRYRFRKMHQvY1h3MktyeUZjUjFJdmFHNTc5eEdv?=
 =?utf-8?B?dmhyRzUyaVRlb1FQdHcyMlhGNGhZalNOQTlxNEdieE1TNlA3VXd0Q0Zkc1NS?=
 =?utf-8?B?cHMzWjM4WVZkZHZRSGdCTHByaXJ4bTBiZkZhakdKV0x0eXV0RjV4VXU3a25p?=
 =?utf-8?B?bkJFNGk4VFJ4WjZpdU9URjlJMzN3ZlNoT2RIcWVFaEtGTHlMRlpMSnlsczB2?=
 =?utf-8?B?eUlHWWZkUkZBZFRnckw2RmtxMEZkWjllM005NUZDZVJ6VVVjQ2ZDeUluaDFk?=
 =?utf-8?B?bGhGL0YyclBhdkg4SDhLaThxYjVIQkQvUjZISWdQT0k5LzdtTENIL3JRTjlh?=
 =?utf-8?B?ZmkzbnB6REFtODQ0RTFOUmhCUmpNcWtRRWVUN2JQcXB0UmsxRGc5M1R1TWlY?=
 =?utf-8?B?S0xlUmxEeVVsVHZNdXZ3VmNzZTQ0ampNNHplcW1IVm5IZVlJaHl6R0M2WXBH?=
 =?utf-8?B?QjJSRnN3a0h1YVVRd3hRaGs4NVJ1UksrV2lha1RvQytuQloyRTNSdmFmSkVE?=
 =?utf-8?B?NXNjQUVyNzlJRjFwRHdWRDFGQzF4aktJYjlxSmhka3psbEVuczFxNU13VWpF?=
 =?utf-8?B?bG9PVU1zci9yMTNxSCtNSWdtNlMwMW5pcjcxMWVVVFdpRjRQOXBtNjRGVDZz?=
 =?utf-8?B?Q2grRmtuZFNNbkRCd1BITDIySHFaZGRMRktNMEQwS0xXcU5qZE5MZTlRYytm?=
 =?utf-8?B?R0IwbndJMUFCL1E1YTZJT050QTlMVEJ0L0ZYNTZRVkpaNXBsMU1wSHc2bTlK?=
 =?utf-8?B?SXVPU0VUdm54Tm40U0lseWxSSWpiRE1ZSVlTWmptdnpDRVhxZVg3d21MaU5r?=
 =?utf-8?B?eE9keVRTVU9jM1lSTnRwd09YKzBuS0pTL09xZlg4R0FwTGlhSlN3Y2xjVGgw?=
 =?utf-8?B?WkxuRmZNZ1FaQ2pRcGwyUlNwUWhTTFNpNEZ1eFhUcGFaajZIa3RnUlI2Nm40?=
 =?utf-8?B?aUVvY3FKbGdIN3luZTUvOU4wYUNLUnk0UE5yWTJDNDI2RjFQRTh6TnByT044?=
 =?utf-8?B?TVkxb3I4eTN4R0xCaWdjejM0Yi96S2srUkgySFdKamFZZmZ0ZDJZcE1GbUY4?=
 =?utf-8?B?aFhDeHBzcHhZWUF4N0xoaUZOUUpuM0RHSWlFcUdHOVYvcllVazM1eW9rdEp5?=
 =?utf-8?B?NWdPNDZmMExQUlErSHk0ejlGNVpvVFQxdVVZM0lkc0YwK0luTW1UZGtVVHd6?=
 =?utf-8?B?eGRCekxOMXFpVUFqM3o2cHhrNFlNSVQxaTRwZncrZ3VERGxlRkVQOHNwMXpO?=
 =?utf-8?B?N002bi8xVGJDVUpIaXcyQ0pmcFZvdXI4UEV2SDNKZ2ZRSDNFdVlCTzN6Tlpn?=
 =?utf-8?B?dEE4eUkzdjRoTExsUEptRjdhMmZUMFc3bUQ0NFhMNjRzUDRXSmF0TGJRQ2lZ?=
 =?utf-8?B?Y1pjVWZOUGVuTE9YVGpYUFUxdFIxYVhtdXBIRnc2Y0lGbTRBcnhhd0xMVnRh?=
 =?utf-8?B?Vi9ZTDhHWm5lUWY1bjNzWUNQbFF2SVhPUG45VU9jMjBrcENzUHVjaG5ZaytD?=
 =?utf-8?B?RDJZaHplKzhkdDEyL01lMjFrWlg4REw0TjVEV28wWVlOZFZzZkRHL2cwem1N?=
 =?utf-8?B?eXhnU3ZRRDI4SzNWN1QzQmk2S3ZMZEdGN0dkQTA2WHpNT240d1V0LzJuMU95?=
 =?utf-8?B?RWVId2RJY3FGY0JpUkNTMHdKeUZIYmRuWHBMR2hRWUhzdG4wemRVbUZLdTRM?=
 =?utf-8?B?Z20veVB3K0VGMVNObkhmQXdjNkZFYUJDbHUwQ2tOc0syVUM3Mkx5RzBXTGhx?=
 =?utf-8?B?NVRzMlhpaUxMSm5SdVRzTFhzNjVSY21Fb1hFUUxvVUxzNjYrUWdGK3FzTXUr?=
 =?utf-8?B?T3FNdkxwYWd6ejRSV3hwVkplZ2M0M0FoKzkrczZXV0t0L2xZMW1EakZqL0FL?=
 =?utf-8?B?RGp3S2VUbGU1R3grMi9yTy9kZndCUEZWWXNOb1RnK0tUc3RtOTI2cGFaMmVw?=
 =?utf-8?B?NldkTUFqa1ZNZ3hTTlVmOUplbWlscTEwUnZJTy84SCtMaUladXlRSFBLK0Rx?=
 =?utf-8?B?cFNyMXdQL1dXTGpmbFdOa1M0NUd0RWxXYnlXeEJKc2VxVC80WE0wS21kL0Nl?=
 =?utf-8?B?elA5ZCtJRXVJMUdDTzR3aW45bnpxalZiaVZGbDBBVEF4SXFJUXhnalIzR0gv?=
 =?utf-8?Q?aqffez2kHO367XyK00RK5qXfn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cf1044-0403-4653-70cf-08de0038c952
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 15:48:23.0935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHx4brLOXwWdEMtWbSqt7hE0j0gHrkpyRwzuz6gxG9/De8G9D4q9ohxdHkcqdqmW4Or+3uEP5tAgH3N2oUo7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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



On 9/26/2025 4:03 PM, Philip Yang wrote:
> zone_device_page_init uses set_page_count to set vram page refcount to
> 1, there is race if step 2 happens between step 1 and 3.
> 
> 1. CPU page fault handler get vram page, migrate the vram page to
> system page
> 2. GPU page fault migrate to the vram page, set page refcount to 1
> 3. CPU page fault handler put vram page, the vram page refcount is
> 0 and reduce the vram_bo refcount
> 4. vram_bo refcount is 1 off because the vram page is still used.
> 
> Afterwards, this causes use-after-free bug and page refcount warning.
> 
> zone_device_page_init should not use in page migration, change to
> get_page fix the race bug.
> 
> Add WARN_ONCE to report this issue early because the refcount bug is
> hard to investigate.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d10c6673f4de..15ab2db4af1d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
>   	page = pfn_to_page(pfn);
>   	svm_range_bo_ref(prange->svm_bo);
>   	page->zone_device_data = prange->svm_bo;
> -	zone_device_page_init(page);
> +	get_page(page);
> +	lock_page(page);
>   }
>   
>   static void
> @@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (mpages) {
>   		prange->actual_loc = best_loc;
>   		prange->vram_pages += mpages;
> +		/*
> +		 * To guarent we hold correct page refcount for all prange vram
guarantee> +		 * pages and svm_bo refcount.
> +		 * After prange migrated to VRAM, each vram page refcount hold
> +		 * one svm_bo refcount, and vram node hold one refcount.
> +		 * After page migrated to system memory, vram page refcount
> +		 * reduced to 0, svm_migrate_page_free reduce svm_bo refcount.
> +		 * svm_range_vram_node_free will free the svm_bo.
> +		 */
> +		WARN_ONCE(prange->vram_pages == kref_read(&prange->svm_bo->kref),
> +			  "svm_bo refcount leaking\n");
>   	} else if (!prange->actual_loc) {
>   		/* if no page migrated and all pages from prange are at
>   		 * sys ram drop svm_bo got from svm_range_vram_node_new

