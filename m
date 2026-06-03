Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B91CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 04:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F037E10F820;
	Wed,  3 Jun 2026 04:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oe6JWE6s";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C291C10F820
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 04:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T41pLwe1E+x6kai4U5p8vGdOsYqQdGfD9kJxOeVzbAJGsO31f+/RYluUa6lxzHF7gG1ji95w8qo+Wr06V2dIH+J3XpH4MmfZ1vjUou5xwrh4b914oVWxdNijKpZ9BTo2iSOoCOH0+enxVlL9CPZ26u+a8wQMCZbEHsNfIYvdQ2fIWfW7c1I2YvpXpSV/hmovnSde4Z9GWz25cUMhXl+v2mNg8qLMJvkk8nL3n8Wz6jk9gPTZbrqTlpin/LU24BvsZtXYGZAvAkS0+IGLYt6ScFRNk/pQJH0hOvBk6673+TURRaG8Tx8iLJYgQuUVy3GPM+pop9y70X6DALDUp/DzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7YwUkz6B+wSI1N5DMKLo0aUsR52PNdkmX86/cxCFlY=;
 b=EwOd9uWi7ur1roZ+5rTKWjcTG5co9a2MCG82D6TG6453zTFWP6LCtmGFL3jqC/Gtpvgu5JzS74tkQ5pj0r96n/wrJXmMYr7u2fg/F3Wxt9Hqw+1cC2J21mS42eOF6YRGbQvuH85h0ly5f7oZjaWhvLsvFjn4O2m3REEMhCP93iiAxoNr9Kq5fC7jUNYCy/04JMwh6KHGOXcJOzFhNg8FFZ1aWteoU73+d02mCRlsRviGJjYx4Y+XVEmH9D2l++u/sD2IB4SKqlviB8HQvaFdglGOXVtxLfToTUYL0KwY7DCPSXioRXqAHlxpry3S7jOjz2Yap0/Jconicc8g+bYEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7YwUkz6B+wSI1N5DMKLo0aUsR52PNdkmX86/cxCFlY=;
 b=Oe6JWE6sRzH77NHhVe847C+4rPFV08xCW/G2BUVsmUk3S/jpaolj/xJ91vzPC9iDu0kbZYmyQk2IOFukLXC0WavxSoHWQL4j3h7nS4uk/igjXWvLlaeV4zFz1oBJLmpZqTvEVl3Bvt/ni8j+Qk5AXZIL8qvInjdrUMTzcnJffww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:59:02 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:59:02 +0000
Message-ID: <eea096cd-f0c9-4c2d-90fc-ad6feccd15c1@amd.com>
Date: Wed, 3 Jun 2026 10:28:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260602181825.730068-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260602181825.730068-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9c8329-cd87-4101-b6cc-08dec12cd491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: eIit9eShANy3AC77eUyBjPC/5ZufCvzsyJJLr8cyaAUA6yEFgwlT/LqWA0hbYs+Tqecrb5SP51T4s3KYr8JK5XG4TMlQhnF9G6xtODyD0RXnCG0aUTVfsXyIrKcRi9VOczDqQVW282g0Amt5l8gfnbO8SQ53vptlC0u1mvxO6/QvxkMiCgqjXp94o7GKbFvlYEgPVI6RRfEp8eWf/AhUWau8yNLhbP/qjaA+lZnVNGzU9SJIKQrxF6B5gPnAggcduTi46vjetNU2JkF7Bf5boFbbyZvJG3W53/RWmm4raQ00/xmyeNrHkXNNkPel+vQC+1o8VGY9VgwMu0HhZ9FpHsWt2v9gVi64UumuWMlMc6pUFh9TCXt9HGwx1z92RPEBJ/E9saxJcVghi15wUgq19LzkxS2jxu537ndARUb+KAb+inLOPegmDeit38rnfgF4+LAZHjezakH7+PVod7v6p6FedF0yxGrfMRA8SIZQBKM1jRxLJERmU0hysQ3WAIKDP741vntB3IoFt3yFTCRoX2XzZw5a6Y9EDFRrAXb/F2K4ZSAAyREkiwOe/BIUBSk18UDfgW20ZEj+SSQCKHIxKf9dGAYy/7IUUcj+/WT7wfQPY9A2/SDeWjxuGvCou8uZK1A66bVVgID7hzgg9jGzbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1hNT2JJR0JtajlEeTBaaFc1cVFRdm4vcFY0NzZURU00R3RhYW9ZbVRaTy9z?=
 =?utf-8?B?QzJkaGI5cVV1YWl1T1dQWjJBTEJKdk1yYmlLNE5ZVHV4eklhUG1Fc25SU0NW?=
 =?utf-8?B?WCtKOUVCdTZjRHQ1Y3g5Q3IrYU9jeHRCU21oK3JPZmgxd0pqcWxkaEJFbjFp?=
 =?utf-8?B?TlJablBjRWlFRm84RXlSbnZUeGkyZGNLNkJnZUsrd20veXdIRFAzYTBpc1hZ?=
 =?utf-8?B?Q1Z0bElaODNvN3FCNXBaTU1JNkczMkdOTWdHaEREWTNQd1hSN09idHNYeWlH?=
 =?utf-8?B?SmdTUU5GZnBPQ1F0a0d5Mks2d1JDSXZxMHNNZDNpWFdyVzBFamVtSWw1Qlhs?=
 =?utf-8?B?RFFNVTdYYm5WWmViV0tmYmhyb2R5WlRINWFOcmxNTWsrWUt2REtHeXJoZm12?=
 =?utf-8?B?d0NMc1VlRms2cnJIaVVhSytuZHAvV3JOcWZ5VjJlNGV6RUREMXZmcCtvamRk?=
 =?utf-8?B?a3NnV0JCUkxwb2ZVN1F0elN5emhGa1pqZmFCWXhNeVpoS2RMZDZCWjJWWjAw?=
 =?utf-8?B?bi92RDJKS293SnNqeURmWldaMmw0ZXNVcExQU2tUT0VwbnlzaUplQjZHU2lx?=
 =?utf-8?B?ekZKdXQ3cG1meGRUQ05CZGd2QUhYc2xBWU1MU2RNV1lHYVBBbTliVGRuS2JN?=
 =?utf-8?B?c0JxNVNxbXpyNFcxTTduWXlRbEVzMjBRMy91cHhzNVZCNzBhMlFaRzhWRnIx?=
 =?utf-8?B?c0orcHQ3R3RaMlJrbGR6dWErdXdFZG96L0tacnRSVGV4a2JHZDBmbG91azMz?=
 =?utf-8?B?ZDNDbXo0aUZPY2ViZlFvVUt2cHlFNXZCNWw0M0E1ejBFZTZlVG01Y3dtdURE?=
 =?utf-8?B?bkVzU2Q1NUxMcU83UXJKbUFJTWszYzFZMkZRQ2lENDB5ckRhcENBQ1BKdFov?=
 =?utf-8?B?SU5MbDVIV2M1c2ZLdTRqc3B5NXZKRnRwSEhpdGVWY0Fpak1qU1YvMzRtK1kv?=
 =?utf-8?B?N05hSFFQVjJTWEpTd0F0VVR5aWpJWE5DSUp5dUprK3c1bzYvdytBZnpFTHgv?=
 =?utf-8?B?VW9QcGczSzBTRVNyRUpLa2t4cFIrSEU0dVowUnZGVis5RGpSWmtLOUpobHhh?=
 =?utf-8?B?QUpNL3ZCeDZjejhzc2RQWWZ2ckowQWl0d2NqYW1NcXlXaXJQRXlFVms5YmRD?=
 =?utf-8?B?Skc0WTAwMDVnNzh0WFlCVXpxTTUrWUZkVTBzS1VkdCtHdkJZbEtjdERIQTNs?=
 =?utf-8?B?UHZRcDhveUN6R0NtUWVEWTcvT3FFUzFwZTc2QWgySHRNRXczQ2VMeHhSR29p?=
 =?utf-8?B?NmRWL0p3Q01HNTFQV0laM2J0L3BIMmdKYmI2WTZQUnVVNTUxOTBzS1MvblZS?=
 =?utf-8?B?YnVGd3orVnVrN0ZFZzdQWG1nS3RIczJER3hFc0FQNjFLR2lMdU02d2hrZ1U0?=
 =?utf-8?B?UXRIRjVDNG96RUhoeDc1OWl3clE1RVN5cjVIVlhYaFhIdDBIVU9TZ3l1bWlS?=
 =?utf-8?B?LzkyRXdIVzByV1o0TXh2YmRZdzdCV0FWY0pIbGloak5xYUc1M0dNbHg4L3I4?=
 =?utf-8?B?dEtVYXFFOUtzUmM1NThmTHN6MEQvQmVyMWRvS0drQTVUUGNHT0t5RDE0WFlu?=
 =?utf-8?B?cTZMdXlwdGpPcXFVQ29tT3grMEk0Yko1QW1lYzNodjFVQ1c4YTRjVGF3V1N1?=
 =?utf-8?B?RU42aE9GYTBVMFdqd3ZlU2IwdzlZZ3ptL2d2R2V3RnY3VXNoY3dzRW9XMEZP?=
 =?utf-8?B?UlRPbHZwV0dreitTa29XNGtTaURFLzFWOEZpVVd6enYyeDZNVGZrVTkzTDU0?=
 =?utf-8?B?d1EzUFBUclFMd2R0TStNZXVJQUlIcDM0aE9NbUg2YlJnY01PUGVGWmc5M0hw?=
 =?utf-8?B?MGhOZGwzZTRleEhoY1RKY2JzdlhRUjVOVUkwWE1od1QvS1ZhbVBYVnlaWkd6?=
 =?utf-8?B?a3RJTllteEZFcDBiektNeWVVNmVUQk90a21JcDY5NkFBWkEyZDJSeDZMR3BL?=
 =?utf-8?B?Uks5WDlLQ0FyOFkyR1REdjZBSzJoZmd5ejJXckNmaE5ZdVZHb2ZMN3Y0em11?=
 =?utf-8?B?Q1VyaFcvWFFoRWJoOVVwUEc4aTFuUDZxelZXNlNuQ0dWYXB2UU93Nnd0b3ZG?=
 =?utf-8?B?WU9lY3ZiSGpNcENPU3BzY2JNMDAwMlFvZy9WQ1FLbXRINnZvWjdQMzR2VS9M?=
 =?utf-8?B?UWppNXhadHg1bG5pejRHOXJTYmZ6d1BoUmNEdUNLZThEdmVGQUZxVThnY3dX?=
 =?utf-8?B?OThnOEJmNnloQmFQY0tBNGJWOUZ5SWRlWmdEZkRnNEpDUHE2NEh2M2tFcVlI?=
 =?utf-8?B?K1hqSTNQOEdydXJ6UUhrU3FacUhqZTJITXRjclNuSDFJYXJWMW1SUHNPaWRF?=
 =?utf-8?B?dmpEUTNUbDRtVE1ldVlrUlJGbk9uZzZWaHQwR3lzYkoyODV1R2l3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9c8329-cd87-4101-b6cc-08dec12cd491
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 04:59:02.5793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJt1Dic9R2YDULqM1Dk3C18SIYhXJOddQjLI8psJ3c1Kg52w/kQsWV9Mt3mchOjf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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



On 02-Jun-26 11:48 PM, Asad Kamal wrote:
> amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow arbitrary
> MMIO read/write via RREG32/WREG32 without checking security_locked_down().
> On kernel_lockdown=integrity systems this bypasses the same restrictions
> as /dev/mem and PCI config space sysfs.
> 
> Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
> debugfs handler that performs direct register access
> 
> v2: Use consistent check as per previous check to use
> LOCKDOWN_DEBUGFS(Lijo)
> 

I didn't mean to apply LOCKDOWN_DEBUGFS. Debugfs is locked down 
internally for all writes in LOCKDOWN_DEBUGFS.

https://github.com/torvalds/linux/blob/master/fs/debugfs/file.c#L267

So this patch may not help much for files opened for write operations -

https://patchwork.freedesktop.org/patch/728769/?series=167435&rev=1

Intention of the comment was to decide between 
LOCKDOWN_PCI_ACCESS/LOCKDOWN_MMIOTRACE or something related to device 
access and use it consistently.

Thanks,
Lijo

> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 28 +++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0ce6e2e4342c..c554afa0963d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -26,6 +26,7 @@
>   #include <linux/kthread.h>
>   #include <linux/pci.h>
>   #include <linux/uaccess.h>
> +#include <linux/security.h>
>   #include <linux/pm_runtime.h>
>   
>   #include "amdgpu.h"
> @@ -86,6 +87,9 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>   			((*pos & (1ULL << 62)) && (*pos & (1ULL << 61))))
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	/* are we reading registers for which a PG lock is necessary? */
>   	pm_pg_lock = (*pos >> 23) & 1;
>   
> @@ -237,6 +241,9 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>   	if (size & 0x3 || offset & 0x3)
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (r < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -402,6 +409,9 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
>   	if (size > 4096 || size & 0x3 || *pos & 0x3)
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (r < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -521,6 +531,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>   	if (size & 0x3 || *pos & 0x3)
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (r < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -635,6 +648,9 @@ static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user *buf,
>   	if (size & 0x7 || *pos & 0x7)
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (r < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -746,6 +762,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>   	if (!adev->reg.didt.rreg)
>   		return -EOPNOTSUPP;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (r < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -863,6 +882,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>   	if (size & 0x3 || *pos & 0x3)
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (r < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -1156,6 +1178,9 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>   	if (size & 3 || *pos & 3)
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	/* decode offset */
>   	offset = (*pos & GENMASK_ULL(6, 0));
>   	se = (*pos & GENMASK_ULL(14, 7)) >> 7;
> @@ -1247,6 +1272,9 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>   	if (size > 4096 || size & 3 || *pos & 3)
>   		return -EINVAL;
>   
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
>   	/* decode offset */
>   	offset = (*pos & GENMASK_ULL(11, 0)) >> 2;
>   	se = (*pos & GENMASK_ULL(19, 12)) >> 12;

