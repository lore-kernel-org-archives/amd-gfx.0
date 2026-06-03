Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329F1CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 14:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBEB10FEF2;
	Wed,  3 Jun 2026 14:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECEzVuk6";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664D810FEF2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 14:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl1k2L9vlGjs6LXmyuQuMmHvUSCHJlk9uql7MaAoKMMhNFGWCUZFPxJ/2f8k+TdJif2jqK1cxJnyUBNo7yG8c6VfNJJ+wwoBgSK3+eZp7H27Fu6p+AQE5oG2mhA0j4eJ92KmwSBD4hMooPsKMRTGbzUjGt/+GyJbk1PBGEo0cKcQYGq2/FvzdW04XnzKzciv/XUpELiVIGI8VZvnBSBHS5Pgka4caP9fIx/R8ixHkyVsbFUxHhDHyYkrcnjzAbMTJ6ncXAQYgkb8eKor3lauzagHjUFw/6JS1Ct9xkWSfJD7DS4I9bw9krX9PKkTW1vIed+QEycubj7mwD9Z5vVQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdJlW6u6o04oJaj+1Yy/fmNApAwMh8yRNvhsuvtcjIM=;
 b=OT8882CdSos2Hmy9tdm2u0oSr8eqhLhs/9RXdiWi1jMENKHTxMtVL43uen4FwtboWGyjH4XCBxN3DiHzC5Pa8uqAOw997rl9bXmkpTd7YRKYpuSQT7AcPEn7Mo0vN5bAEokkvufminu8Myl9WECe0qaENBbHmA3F4txS1LWduvWXmghpyjzCn5gbOuVMyYEpMfsLLI8tRXh7DeCXir+DDeE3idc/7ZkQVk32YYw4LTm0RaQtdz5O6L9ZAFANCS8rjwYWl8xEUOqe2MixvTGUk4thfDZDqPzVYTHF7AgP88kBej5VJygPK35sC1F6z0DHT/2ArFZ1TlU3WZY3YuDfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdJlW6u6o04oJaj+1Yy/fmNApAwMh8yRNvhsuvtcjIM=;
 b=ECEzVuk6ohuC4xPDXGh7gIy6b3H8GHIeeKZmDMPOWRj7B/MXXKhoSLlEO+9jiuBUVnVcgykoo/QfpARjWKTsjsCcy9YWLHQWmEasJverVKi8LK4xBOwVwssdFq2I0dQhUD0RO/PmHZCWTpwaqSFVwN1BKcAEiR9+v6NBt0vihJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:20:18 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:20:18 +0000
Message-ID: <5cc3f24a-5fad-49b7-8978-f6d11abca294@amd.com>
Date: Wed, 3 Jun 2026 19:50:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20260603114459.938031-1-asad.kamal@amd.com>
 <DS0PR12MB7993177B829CF9CCE0BA7DFEF7132@DS0PR12MB7993.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS0PR12MB7993177B829CF9CCE0BA7DFEF7132@DS0PR12MB7993.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: d62922bc-cc51-436f-2688-08dec17b3cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: k/v07gkzuhLdDbJNoSqrhLTu63hPGD5QXnAs2ALwVJ/psT4uonfINRXNmcZXpdiFfTWdNHaylF+WMhA1Dy8oXG2Ew3y07ApXy/x6Gh5JQURn3mA4cIDK7HcR9FbYTqmnn/VkE3SW3jKoXWQHgHWPUkZVTt5EFxoL9wFdBTtmJr2ZmLKfVgIT6sfJrgCerANNt0N7vVlNAj/q1gD0wjTUmcWHLIJoBU05GIuEulGoD8J//Anq6QhuQyG1XZujWFDxbmurW2ChoNSKaBU7qH0Eg9WmfDRYSkwT/b3Mo6KJC+xOGcISbGpFyJ3DKhOnGj7Dej/l2NfpGNEDdPfuLJtFHwLGJ/TvbZ3ogJycaiLontYLuOPmIpdOCeWfsrDbVQD2CNUQdFj+pFi5ayF1EK9b0E6BzSaQw9u3HeAgGyWLuNGAHdAYzxzRJ//wQX7vU4Bv9BP4da5jW0T3hi4ewO493BuhqkATVfCy6AalWyfSTBNwEbyEGmtBp2HOxgVLOfec5OA363i/3hoWbulOWi9BaqheGcqvmmggiZSWj8IJ6dGvwdQ3XOJRLJ9fSnNem9hG7vbBy9bhzaY/xLNpi0wJLGzpuQqCGV3pR8VgG+XzCXTmkOQjgH0uVInu8Bd+6g76NHdLCwZ2t0F9HNNPb3ANXhIcu5ugUVoATRwaLacWkvgJnCGAX2BQXHSn8vfhqBh+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJ0TkhzV1NtUUoxNmpjYkorRUQyM2szRklDamVrOG5ablY4dG5YcWdrSXRq?=
 =?utf-8?B?QkJoUkU1Y2xBWjRNbzBJNDcvNmdmUmlWV3R4WU5FRS9XUVpuMmJqalkxcnFR?=
 =?utf-8?B?emFQSkJqVktWQ29yQTZiZFFHTWJNSnZDT29lWWtkeWVPd3NWd21FeWEzOHVX?=
 =?utf-8?B?MGlVOWpSZ210RDNOejNQUFhIZnF0cTY4cm1veDRPNW9uVThQR2YyOXI3TWJ0?=
 =?utf-8?B?N2VTMHhmVHJqRVhWYlFDdnZreEMxTWVqcVUyaWhJRGNnQXRQbVBqSHNCQ0U0?=
 =?utf-8?B?cEJRN21FbjR5dncyZEZ3M0VrWnVxMWdsWUh4YitwbEI2cG9vWmI5QXlmQ2Z6?=
 =?utf-8?B?QitWeUJaSGFnTWZsSUtJNFJHSEQvem1SOWN4RnBxaC9wcWkzaktSSDBRSUtV?=
 =?utf-8?B?aTJBNlhZOHZ6Qy8wYTByQ09nbHVHMUZOQThkWTRqajVxVXMrUTlOeEViZ0lu?=
 =?utf-8?B?a0gvY2I4ZVFXbGNxUmxJOWhYSUx5TmUvdWcrVE9CdkJ5cEtubWJINTRpUE14?=
 =?utf-8?B?R1RRT3krYUpsRTFOVHJ1dFNZQkVJMWtkUGVUL3RBUUxRQVJOUExUbGo4anNX?=
 =?utf-8?B?QzFuL0hWOU9TSDc3dmlzTjlPUjdFRy84bWwxUnFRNmgrdmlQR09WVWhBMDdK?=
 =?utf-8?B?cEtyYytBWGIxNUtRa2FwUnBVR3luZDIvRXNDTW9vTVorV1p0THBQQzQydEwx?=
 =?utf-8?B?c21xRTBRYUFqOFJlMkdJUnk0dmNwQjdhYVpaTW52THhtKzl5MzdFMmp3WWRs?=
 =?utf-8?B?SVlzcDJhbmE4THFnOVFYeEF6Wjg2MUhjVGlxbEtPUElodXlSWE9uMGM2UTRT?=
 =?utf-8?B?d0FUYncrR1VkbDBUWk1HTnp5Rm4xeW50THNtOXA2bGEvdnBRU1RncTZUWG9E?=
 =?utf-8?B?alZSeHNJcDI1cFhPeThhdzlqU0k5aVpQUy8vYW5LcXVVZVB5SDhvMmRkeWJ2?=
 =?utf-8?B?OGdBUXpseDMrV1d2VzdCWEMySHh2ekZYa0hOMXNCTVNNN3RTdjIrQzBYMUhJ?=
 =?utf-8?B?cHQ4TGszanpWYytCTjF5d2poblMvcnJ5dVEzZjV4eUN1clc2MGFlZzBxUmI0?=
 =?utf-8?B?QWpPejE3eDlvQkQxeFpSMkg3TzNLVWsra3Nla0RJK2g4Z3NtTDhtaFRNSkdP?=
 =?utf-8?B?OW5GZTNTVERkdUdIalpoWm94WHEya3U0MzFqNlkwL04vL1VuU1o2RVRxT01o?=
 =?utf-8?B?cmZ1ZlBZL2hkTW10bFREaklFVjNJc0NPN2NQY3V5aUhJNXl1UlN0QmJKendL?=
 =?utf-8?B?cWExRGZnN0ZxTml4OWZpZHNSQ0dwcG9UOU1mUlZCdlM1bVhiaXdnL09GcE1M?=
 =?utf-8?B?OVhwUUc0WG5sVm4zaDJuajZmcHFkQVVORFJXUkVPa3d6eXNHcUxHWHRES0Fu?=
 =?utf-8?B?SjM3ZDJ2M2F0TnljNmVnYVFWa2tNZ0E1clpUM01IbHJ3dTFkdFFwRmQ5Uk9H?=
 =?utf-8?B?SEZFTk5kaExXdFJMTXRmRm5GMEZSdHVmMWZrNXU4SG1IL2htZlBId09NMENs?=
 =?utf-8?B?cnhvUU56ZTl0SCtFd3FnaDk4K1ZTUkN1bzQyY25kUThvN3I3OFhjeVVHWmR1?=
 =?utf-8?B?NU5XeTBZakFDc0tTQ2dGUTd5eEFKemE2YUpyL2JJaTZKRDRsVjZ5OTZTL0VY?=
 =?utf-8?B?cnloN1NKWGdoN2U1dXo2MzQxSEI3ZmZJUW5LK0Q1SUxHQ3ptdWpUazl5dUpn?=
 =?utf-8?B?VElJKzhDZHMyMlhId21JSzZabnl5ZXRPRzNPeHZQVGkwU3AxdlpKSndRODV6?=
 =?utf-8?B?dWFIa1pPVkJMNmJiOHlNU0VXRWNzMnN5TGxDaElXWG01NnJCWXFyS21tSEhr?=
 =?utf-8?B?eWZYWFE0SzJzdGdOMDhRcHA0TEtaN0x1ODRVNC9xQkVWK3FMNnFoRENjM1VK?=
 =?utf-8?B?Y2YvYUttWFlVVlNQQkxGSm91VjlJYThPb0VERGlHSnVyYzA4eTg0T1FvVHVH?=
 =?utf-8?B?MjFocElzZXZQVCtJMGZOVEpyNGpySWhKa2h3SEJXdjA1OEJhcWVuK1dEY0J2?=
 =?utf-8?B?ZGtYbE5GK1BPQkdFVUljVng1MHBzUFV5NHpwZCtyT2xJb1RBMXVvY29mSXNM?=
 =?utf-8?B?LzVGczVwYlBsRmVUUXd6YnpFdXo0K0pTVmllY0ZLN2FhUTh6RFd1S2pzQjF1?=
 =?utf-8?B?RG1jK0VqU29ZZndwb1V3V29GT1hLWHladFpsMzNPcXozNFp2aFRwT2lPejlR?=
 =?utf-8?B?aXYyNDhXZVU5enlkT09JWFcwakg4amYySlk5Z2g1Zi9MR2cvVWkzaHEzaXI2?=
 =?utf-8?B?ajJqd2krclYwdEk0Zms2dkVEVU4wVDc3NVozVVUvbzcyQXFCWEprOVZnNG9R?=
 =?utf-8?B?UEQydzEzRjdiUFZvVFMvb0tCd2FpY2NBc1N0L1JuTjJ4dG1EMDFOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62922bc-cc51-436f-2688-08dec17b3cc9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:20:18.0360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8ivw/MtOCBquNwFa8UEKdinWfVLpr+awbmBG1jzlNnForRfWLEDeV9W7F9lzVv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
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


Thanks, Tom.


The patch looks good to me -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Hi Alex/Hawking,

Any concerns on shutting down the interfaces in lockdown mode?

Thanks,
Lijo


On 03-Jun-26 5:59 PM, StDenis, Tom wrote:
> HI Asad,
> 
> This should be fine for umr.  UMR detects when the lockdown mode isn't "none" and warns the user that the tool might not work.
> 
> So the net effect of this patch is the debugfs files are just not created at all?  That'll likely cause umr discovery to fail (after it prints he warning) which is still fine.
> 
> Tom
> 
> 
> ________________________________________
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Wednesday, June 3, 2026 07:44
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo; Zhang, Hawking; Ma, Le; Zhang, Morris; Deucher, Alexander; Wang, Yang(Kevin); Kamal, Asad; StDenis, Tom
> Subject: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
> 
> amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow
> arbitrary MMIO read/write via RREG32/WREG32 without checking
> security_locked_down(). On kernel_lockdown=integrity systems
> this bypasses the same restrictions as /dev/mem and PCI config
> space sysfs.
> 
> Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
> debugfs handler that performs direct register access.
> 
> v2: Use consistent check as per previous check to use
> LOCKDOWN_DEBUGFS(Lijo)
> 
> v3: Do not create any entry from amdgpu_debugfs_regs_init() if
> LOCKDOWN_PCI_ACCESS is active and log once. (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0ce6e2e4342c..5c4d4ff001ea 100644
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
> @@ -1739,6 +1740,12 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>          struct dentry *ent, *root = minor->debugfs_root;
>          unsigned int i;
> 
> +       if (security_locked_down(LOCKDOWN_PCI_ACCESS)) {
> +               drm_info(adev_to_drm(adev),
> +                        "amdgpu: HW debugfs nodes disabled (kernel lockdown)\n");
> +               return 0;
> +       }
> +
>          for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
>                  ent = debugfs_create_file(debugfs_regs_names[i],
>                                            S_IFREG | 0400, root,
> --
> 2.46.0
> 

