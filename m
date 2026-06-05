Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B4DCD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 12:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABE8112AF6;
	Fri,  5 Jun 2026 12:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hYNZC6F8";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C94112AF6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 12:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ/EilFyaOBGcCSk8SkNjbyg+ql9Hw0ZhbHGCkboqreHVqntLyeFley6w6Z82cbPg2euiAN+Hpc7ZUROycX/KeBmKK2yEPiQjy+Mv+VU0mcukEdR1pncbRJDVc8Hk6EHqmoO6OEOIG2E8nVKGc60bHib3hQqEkUeSteJTDMj2CEya44nNfKitzvW5bBNAEclXZjpNpDC5ZpdXguSDmaVTXBCIgFJfnX6Q8C+nvE/o5O3elR8dGFF0QoQ8xj12GqSCrVwrzVFBJjwL02+I+yxp8MaCcjBr7K/p1RyHqABKyePOYshXq3QPjj8q8lrd/qmOzrhUfftpJ/+6HYkzwk/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcpNnhXm5bPeJf4R2CsH6SXfsSycGAOu18KaE7VSq3k=;
 b=jYgJY3bcZPyfGn6PaIwm24fRilc6MXLvk9FVoVmsx73JQj31b3KdxDfMhRX7PNQYanZSvtOfmTkqPaTluq30zrphbZyyotVgleK0jAdNX1l6bLSEXOOD+OHZ3yLVgnWz5IO6iUKqL88oZNTbjyXxldMB6moZzvvK0hZXYthITKjiVJpsXXqYIJa4bSYRPBP2bGIwiNL4qYfwqTHx+NgzCkCFHF5J9VjzyHdLbKYh3N6GqByo9pb3uHkb+cR5to6xVf9A8ysOHpboMhhOHBQyuS1x7OHsDMIiYuJhzVZmDBvI2Jnlh4IPegYeVBofWGVJaqJ107iWTouDxLwPsTGv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcpNnhXm5bPeJf4R2CsH6SXfsSycGAOu18KaE7VSq3k=;
 b=hYNZC6F8syPPVmwm7Qik/0jVZUBfxlZlCeJLfrGofJX9tp2aU/u7WmS4w7zRNR5IX/4GmD5FGkhaAC8wdAgcx5j0B738G1ZTKWCvlI0VcYO5BZ2syWzVMVzEqSpB3GEvBqpqEvcYik18Jh3HOuLromZ/PKALbrVXR7Z12mUHSh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 12:39:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 12:39:39 +0000
Message-ID: <2422c581-f610-4fb9-9142-c56ac33bbbf7@amd.com>
Date: Fri, 5 Jun 2026 14:39:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] drm/amdgpu: Add render-node EVENTFD manager core
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603163350.2678309-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 864e2361-f458-4b31-d32b-08dec2ff8278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|6133799003|22082099003|18002099003|4143699003|5023799004|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 8qz9nITnmxpb7Hvtg7uZe0KmgRyqH3uawOaKwen0+L1qRwBPyhDLeFkWtG8mKZ/jJ2F3eqfpS0IDWurqCCVTiobajj+c22tZ36fNRl00XvRdfldzt6KqfVtKD7UZAefumQpG7A4aYEaBJUsPz3E3AFozDHP7cl6mAQMgrCFZIWII7CMFrEP0+Lm7mgI1EfCkG8UVxZW2sSUvP2a6756B2AHBLfWvAcYxSYQDpKaP96h2uuLeq6S7WS/iB1+ysq9xW0MUCldtUV/6wEPLVqA3OElLQX8kwI/pa7EsEiaDIhQfagWHxe9AzCaCrJ96aOQ9HSEhLYciawDLRlcNF8ZxtUSBcR3LIyR0DXsm/28x+1xCIc6cCwHStjXZxzjHwAfqd094ltclerq7e1H0soH9kR29pkbXutHNoxp8AYsVBYURBipB2SfSQ3YAiYvcXkBLC5vHrTWfsqXlSN0sI/nd9r7ZLe5uWZIfKcGg8coGl3KYZE+6FIzPHVnEelOpXXBfLil4FXRsyS9KOoEzppnD8ajQIbSeMm3mM7W7+lefwN6L75LBhT/QUFe4UhmezyJUaIOix/xh95wDvVMxbuE+xu4MYAQ7lLmKPFwfB06NjcPvcIEhFkOopZq875J3XELJnjVGK5s/oOp5GaMvv++cOXWSDtlJyU1DwzHeFLUr4F4rAeQKZUCCyyO6Zm12Ayk6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(5023799004)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajFEMEV1ZjQ2VmJicUpNRzNOOTNDSkljblJ6N3hrZFNvbEU3VDBVOUY4Wk1q?=
 =?utf-8?B?dm5UNjZDOG5mTXlGSmcxTWs4cFZabHlieENLalN4UkdCWXJNekxoTllFTHZU?=
 =?utf-8?B?ZnpRelhtNVNDWTFia28vVkRTV05XdzBxbGhCN05YbXRROExYWXUrazVrR09H?=
 =?utf-8?B?THMwdzlIQUN0VlBmQW1odkJzTERqZGVWRmVmSkJQaHAyVEhOT0F1SjIwZ0FV?=
 =?utf-8?B?UXJCQVcxeXg1ejl1TVdPRlBkaTNWK0hQZFpIMlBzMHIreE5UOGJVZG05RDBW?=
 =?utf-8?B?U3NFVlh0YWxtUDFDRzhQa0pTVG5TRnBFRENzRzZnLzBIVlRURjF3TGdxanRu?=
 =?utf-8?B?elF1R01INC9GR2c1U1B3bGlmbDdUTHZ1amtyMGNGcWIwYmUraWUxTHZ1RWMy?=
 =?utf-8?B?QkRsZjBTc2xXeEFVeGdVNkdUYmlUVWJhWXpIYWZDeXVwdlUrUnNVQnpkak5N?=
 =?utf-8?B?S3U0cWIzbzRtWmtQSFo0M0U4MERHditaWGh4am1EQVd0QjhtUE9aOE53YzJM?=
 =?utf-8?B?VEFrWnJPVnIvemZGdXcyN1VJa3ZlWE1aWTNSY3lNVHZlUTJGd2hGRVoxTmVD?=
 =?utf-8?B?elVWVGs3SVIxYjlJNkwwMk5oRGVXY0hHQzRhOVlVNXV4UXVtUmhreWhicWFx?=
 =?utf-8?B?UE8zbE9SYlhoM2hPQ052Q1VsbVlyV3JmQy9NSk9RbUd4Z0wvcDRRVUgveGFH?=
 =?utf-8?B?MWw1b0U5cnVZYzVSVk1BUGQxR3JkRXkwbU1RZFp0eHZad0hycU9COWtwZElD?=
 =?utf-8?B?ejhteHJuVmVaWEZBTUdzdnJrQWwzOU82Yjh1VkpPTEtqMkdZeENEVWpsN1pn?=
 =?utf-8?B?SGwxYmtIOXdoZFM4RTcxcXh2czZ2djFTRmJQZERTU1ZkK3JLNWtaeER4YVV5?=
 =?utf-8?B?Tk9MTHpyQ0ZiVzJPd1FFZkVVL2tCV0txL29MR2RnRnJHL25IaTl5OGNqNUxH?=
 =?utf-8?B?NnVtSDVhUm1JK01rYngyWVRudjgyU3dYcDNaajFMSndZVWZvTDJvRXU4aGRB?=
 =?utf-8?B?S3U1TTdjM20zcTg5ZE9DNFNPbk1NY2dSK0xuRmpnTTVwS3kwVkVQZlJ6ZHhZ?=
 =?utf-8?B?UWh0dXl3UHRXOGxlVFdtTWpNQTVvU2pGVEc3cy9KNk0ySzJaWVdEWVZleUxh?=
 =?utf-8?B?dTVEZTNqMlJva2RBMHo4dFdnOUFnZ0h1dDJ3L2U2Q1drQU5seFlIVmhrM0t4?=
 =?utf-8?B?NXZsc0c2K2dpc2R0eVJZYzRpbDVCclRiRTl4dVdyK0FvNE1ZS3A2K3pwNjVZ?=
 =?utf-8?B?UkF4Q09wY3A0bFRwZXJ2YzF1czJReU5qdU5tU0o5ZDZNaktqb3g4eThwNjRm?=
 =?utf-8?B?c0pnZ2J6TXJ1NWJ0U1BCNG5WeHJEeGxZeEF2K3l3YmFWTnQyNVQ1SEVSS0hT?=
 =?utf-8?B?VENXNUdKTVlWdlFhd1dKQ09zSGNIc0lBckxTa3ZJUElVRlRkWmViNUlCT3l1?=
 =?utf-8?B?bklGekZJYjl5UGRwZFRFeDlhb1dXcW5ubzZkMEh4YUE5WjV2QU5FY0RqS211?=
 =?utf-8?B?d0JyM013YWJMOHRqd1NXOFloUHU2WE9CbEFrejJUakJLSDVNNjFFTHh5Ym1B?=
 =?utf-8?B?WWJ2TlhyZXk3cUczTnQyNXlPbUlrZnRHVEI2d0RqR0JuTVF6eGdyVUtuMVhT?=
 =?utf-8?B?WlJSbFFuUlpSbFA4WlBzS3M2aC94aXRnbXY1dHd6Mmg4Y3pkbEZqZGdPazlt?=
 =?utf-8?B?SlhDWHV6dVl0Skk5cmxtUG9YMlJLSzN4V0p0TDBqQ2Y1OG9LTlZYVVA0RjB6?=
 =?utf-8?B?QUF4TzZYUC8rRWVOb1Y3SWhrUmhwUFF6eWVmNTJpRnIydkZ6eURhVTRwTVhG?=
 =?utf-8?B?WHFuQWFzYlV4TFZBQWFsNTdhdEZwV3lxSXVxb2FtaTAxU3N0UDlzMi82Uitr?=
 =?utf-8?B?cWxOSVhWOVVoQVBtcDc0UG9uWW4vVTJTa1RmRW51Zk5DNFIvNVZzYjUxR29u?=
 =?utf-8?B?emhBMzNqcHl3UXp0ekE1NVMyNFYrMk0rM0tVYllabm94M09Xam1DOHZvcnlp?=
 =?utf-8?B?M05ja3JDKy9vWnE5UElPMU03YUdWQnp6ckEycmJncUhtcDhYT3dUMHl2Skhm?=
 =?utf-8?B?bTdqU3JFRmswaS9VWStGU1JLaWlmVmhTVVlnQ2V3ZXZhcllkRlVscnZHRkt2?=
 =?utf-8?B?YTNMblpWdlRsd240ck55RC82eUw0UVE2Vm1TV1Z0SXFnQTNTVHZVdFZFeEtW?=
 =?utf-8?B?WUVaSHEzb2xtOHFrS0hwdkpVY3NXYUVaS0tXTG1rQWtsaXJWWVBHMnNaVHBG?=
 =?utf-8?B?V3l0b1FrYUNaR1R5bUNzb2o3QmN5dGR6SVJIYjk1Smk5bFkyOGduUHpiWVQv?=
 =?utf-8?Q?ByCeE+yqhO0oI6dBQc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864e2361-f458-4b31-d32b-08dec2ff8278
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 12:39:39.7495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBKm4R/kIAApHUcDpuJRipMxL7N6l7TIjegkZbjalxSjIo93foX8IyCs6xncxvLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
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

On 6/3/26 18:33, Srinivasan Shanmugam wrote:
> Introduce a per-drm_file eventfd manager to support render-node event
> subscriptions.
> 
> The manager is implemented in amdgpu_eventfd.[ch] and is owned by the
> drm_file (amdgpu_fpriv). It maps event_id -> eventfd_id object, where
> each eventfd_id can have multiple eventfds bound (fan-out).
> 
> The design is IRQ-safe for signaling: IRQ path takes the xarray lock
> (irqsave) and signals eventfds while still holding the lock.
> 
> This patch only adds the core manager
> 
> v4:
> - Use eventfd_ctx pointer as binding identity instead of fd number
> - Make duplicate (event_id, ctx) binds idempotent
> - Replace mgr lock with atomic bind limit
> - Add helper for xa get-or-create event_id
> 
> v5:
> - Rework event_id get/create helper so it is callable without
>   holding xa lock
> - Move event_id allocation into the helper and use xa_insert()
>   for insertion
> - Drop GFP_NOWAIT usage in xa insertion path
> - Allocate eventfd entry only after ctx/id prerequisites
>   are satisfied
> - Simplify fini path by removing per-entry __xa_erase() and
>   relying on xa_destroy()
> - Keep duplicate (event_id, ctx) binds idempotent
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 386 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
>  3 files changed, 447 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ee3574797bc2..dd5a6fc5cbc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -71,7 +71,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
> -	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
> +	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> +	amdgpu_eventfd.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> new file mode 100644
> index 000000000000..0b0c9268aedc
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -0,0 +1,386 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + *
> + * This module provides a simple event notification mechanism for render-node
> + * clients using Linux eventfd objects.
> + *
> + * Userspace can bind an eventfd to a userspace-defined event_id. When the
> + * driver signals that event_id, all eventfds bound to it are notified.
> + *
> + * This mechanism is intended to support lightweight GPU event notifications
> + * (for example, user queue EOP events) without polling from userspace.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +
> +#include "amdgpu_eventfd.h"
> +
> +#define AMDGPU_EVENTFD_MAX_BINDS 4096
> +
> +/**
> + * amdgpu_eventfd_id_alloc - allocate an event id container
> + * @event_id: userspace-defined event identifier
> + *
> + * Each event_id represents a notification category. Multiple eventfds can
> + * be bound to the same event_id.
> + *
> + * This function allocates the container which stores the list of eventfds
> + * associated with that event_id.
> + *
> + * Return:
> + * Pointer to the newly allocated structure or NULL on failure.
> + */
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return NULL;
> +
> +	id->event_id = event_id;
> +	INIT_HLIST_HEAD(&id->entries);
> +	id->n_entries = 0;
> +	return id;
> +}
> +
> +/**
> + * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + *
> + * This helper returns the container associated with the given event_id.
> + * If it does not exist, it will create one.
> + *
> + * The function is designed to be callable without holding any locks.
> + * Memory allocation is done outside the xarray lock to avoid blocking
> + * inside critical sections.
> + *
> + * Return:
> + * Pointer to the event_id structure or NULL on failure.
> + */
> +static struct amdgpu_eventfd_id *
> +amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_id *new_id;
> +	unsigned long flags;
> +	int r;
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	id = xa_load(&mgr->ids, event_id);
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +	if (id)
> +		return id;
> +
> +	new_id = amdgpu_eventfd_id_alloc(event_id);
> +	if (!new_id)
> +		return NULL;
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	/* Re-check after taking the lock in case another thread inserted it. */
> +	id = xa_load(&mgr->ids, event_id);
> +	if (id) {
> +		xa_unlock_irqrestore(&mgr->ids, flags);
> +		kfree(new_id);
> +		return id;
> +	}
> +
> +	/*
> +	 * xa_insert() returns -EBUSY if an entry already exists.
> +	 * Since we are in irqsave context here, use GFP_ATOMIC.
> +	 */
> +	r = xa_insert(&mgr->ids, event_id, new_id, GFP_ATOMIC);

It would be better if GFP_ATOMIC is avoided. See the documentation on xas_insert() how to avoid this.

> +	if (r == -EBUSY)
> +		id = xa_load(&mgr->ids, event_id);
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	if (r == -EBUSY) {
> +		kfree(new_id);
> +		return id;
> +	}
> +
> +	if (r) {
> +		kfree(new_id);
> +		return NULL;
> +	}
> +
> +	return new_id;
> +}
> +
> +/**
> + * amdgpu_eventfd_mgr_init - initialize eventfd manager
> + * @mgr: manager instance
> + *
> + * Each DRM file (amdgpu_fpriv) owns one eventfd manager.
> + *
> + * The manager stores mappings:
> + *
> + *   event_id -> list of eventfds
> + *
> + * The xarray provides efficient lookup of event_id containers.
> + */
> +void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	xa_init_flags(&mgr->ids, XA_FLAGS_LOCK_IRQ);
> +	atomic_set(&mgr->bind_count, 0);
> +}
> +
> +/**
> + * amdgpu_eventfd_mgr_fini - destroy eventfd manager
> + * @mgr: manager instance
> + *
> + * Frees all registered eventfd bindings.
> + *
> + * The caller is expected to ensure that no IRQ-side signaling can occur
> + * after this function begins. This typically happens during drm_file
> + * teardown.
> + */
> +void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	unsigned long index;
> +	struct amdgpu_eventfd_id *id;
> +
> +	/*
> +	 * Expected teardown ordering: caller ensures no further IRQ-side
> +	 * signaling can race with this before fini() is called.
> +	 */
> +	xa_lock(&mgr->ids);
> +	xa_for_each(&mgr->ids, index, id) {
> +		struct amdgpu_eventfd_entry *e;
> +		struct hlist_node *tmp;
> +
> +		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +			hlist_del(&e->hnode);
> +			eventfd_ctx_put(e->ctx);
> +			kfree(e);
> +		}
> +
> +		kfree(id);
> +	}
> +	xa_unlock(&mgr->ids);
> +
> +	xa_destroy(&mgr->ids);
> +}
> +
> +/**
> + * amdgpu_eventfd_bind - bind eventfd to an event_id
> + * @mgr: eventfd manager
> + * @event_id: userspace event identifier
> + * @eventfd: eventfd file descriptor
> + *
> + * This function allows userspace to subscribe to notifications for a
> + * specific event_id.
> + *
> + * Multiple eventfds can be bound to the same event_id.
> + *
> + * Duplicate bindings of the same eventfd are treated as success and do
> + * not create additional entries.
> + *
> + * Return:
> + * 0 on success, negative error code on failure.
> + */
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e, *it;
> +	struct eventfd_ctx *ctx;
> +	unsigned long flags;
> +	bool dup = false;
> +
> +	if (!mgr || !event_id || eventfd < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Enforce total bind limit without a separate manager lock.
> +	 * For duplicate binds, we decrement back before returning success.
> +	 */
> +	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
> +		atomic_dec(&mgr->bind_count);
> +		return -ENOSPC;
> +	}
> +
> +	ctx = eventfd_ctx_fdget(eventfd);
> +	if (IS_ERR(ctx)) {
> +		atomic_dec(&mgr->bind_count);
> +		return PTR_ERR(ctx);
> +	}
> +
> +	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
> +	if (!id) {
> +		eventfd_ctx_put(ctx);
> +		atomic_dec(&mgr->bind_count);
> +		return -ENOMEM;
> +	}
> +
> +	/* check for duplicate binding */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	hlist_for_each_entry(it, &id->entries, hnode) {
> +		if (it->ctx == ctx) {
> +			dup = true;
> +			break;
> +		}
> +	}
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	if (dup) {
> +		eventfd_ctx_put(ctx);
> +		atomic_dec(&mgr->bind_count);
> +		return 0;
> +	}
> +
> +	/* Allocate entry only after ctx/id prerequisites are satisfied. */
> +	e = kzalloc(sizeof(*e), GFP_KERNEL);
> +	if (!e) {
> +		eventfd_ctx_put(ctx);
> +		atomic_dec(&mgr->bind_count);
> +		return -ENOMEM;
> +	}
> +	e->ctx = ctx;
> +
> +	/*
> +	 * Re-check duplicate under lock to close the race with another bind()
> +	 * for the same (event_id, ctx).
> +	 */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	hlist_for_each_entry(it, &id->entries, hnode) {
> +		if (it->ctx == ctx) {
> +			dup = true;
> +			break;
> +		}
> +	}
> +
> +	if (!dup) {
> +		hlist_add_head(&e->hnode, &id->entries);
> +		id->n_entries++;
> +		e = NULL; /* consumed */
> +	}
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	if (dup) {
> +		eventfd_ctx_put(ctx);
> +		kfree(e);
> +		atomic_dec(&mgr->bind_count);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_eventfd_unbind - remove eventfd binding
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + * @eventfd: eventfd file descriptor
> + *
> + * Removes an existing binding between an event_id and an eventfd.
> + *
> + * Return:
> + * 0 if removed, -ENOENT if binding does not exist.
> + */
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e;
> +	struct hlist_node *tmp;
> +	struct eventfd_ctx *ctx;
> +	unsigned long flags;
> +	bool removed = false;
> +
> +	if (!mgr || !event_id || eventfd < 0)
> +		return -EINVAL;
> +
> +	ctx = eventfd_ctx_fdget(eventfd);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	id = xa_load(&mgr->ids, event_id);
> +	if (!id)
> +		goto out_unlock;
> +
> +	hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +		if (e->ctx == ctx) {

You could short cut, e.g. use if (e->ctx != ctx) con tinue instead.

Apart from those nit picks looks good to me.

Regards,
Christian.

> +			hlist_del(&e->hnode);
> +			id->n_entries--;
> +			removed = true;
> +
> +			eventfd_ctx_put(e->ctx);
> +			kfree(e);
> +
> +			atomic_dec(&mgr->bind_count);
> +
> +			if (!id->n_entries) {
> +				__xa_erase(&mgr->ids, event_id);
> +				kfree(id);
> +			}
> +			break;
> +		}
> +	}
> +
> +out_unlock:
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +	eventfd_ctx_put(ctx);
> +
> +	return removed ? 0 : -ENOENT;
> +}
> +
> +/**
> + * amdgpu_eventfd_signal - notify all eventfds bound to event_id
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + *
> + * This function is typically called from interrupt context.
> + *
> + * All eventfds registered for the given event_id will be signaled.
> + * Userspace processes waiting on those eventfds will wake up.
> + */
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e;
> +	unsigned long flags;
> +
> +	if (!mgr || !event_id)
> +		return;
> +
> +	/*
> +	 * IRQ-safe signaling path: keep xarray lock held while iterating and
> +	 * signaling. eventfd_signal() is IRQ-safe.
> +	 */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	id = xa_load(&mgr->ids, event_id);
> +	if (id) {
> +		hlist_for_each_entry(e, &id->entries, hnode)
> +			eventfd_signal(e->ctx);
> +	}
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> new file mode 100644
> index 000000000000..248afb1f2f14
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + */
> +
> +#ifndef __AMDGPU_EVENTFD_H__
> +#define __AMDGPU_EVENTFD_H__
> +
> +#include <linux/eventfd.h>
> +#include <linux/xarray.h>
> +#include <linux/atomic.h>
> +
> +struct amdgpu_eventfd_entry {
> +	struct eventfd_ctx *ctx;
> +	struct hlist_node hnode;
> +};
> +
> +struct amdgpu_eventfd_id {
> +	u32 event_id;
> +	struct hlist_head entries;
> +	u32 n_entries;
> +};
> +
> +struct amdgpu_eventfd_mgr {
> +	struct xarray ids;          /* event_id -> struct amdgpu_eventfd_id* */
> +	atomic_t bind_count;        /* total binds across all event_ids */
> +};
> +
> +void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
> +void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
> +
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
> +
> +#endif /* __AMDGPU_EVENTFD_H__ */

