Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B15DCD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E24F10E83A;
	Wed, 10 Jun 2026 09:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i1nAp9uH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D4210E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO7CARIm4tOMsvcHb9Xc811dH1ng7pP1zW2EeRFhlVq3VrMox07xKcFHKtxD7oyYtuRAlyE9tNXZ0RICvTxDOYClSEFL7VY+jvQ6LHmhSeqyvCLUhdx60LW+yexo8BegFH95O4WdJQStIVThfw40xiQlVgO59/XUWYvxyeP9MRfX2N6fB2+NrZJ7ePeTMRqWK/V9KOS7qOn909EfkW5UKV2a9SMt4GBrF1CxdBF09BcMZBMd0zuLhHg4H07wV+NR9c8uGbva/zH+mLVVJn9GXZm6v9Ln/ufA28rqZSvmIB1gU+AMKCvE2VK4RiGxrR4VYD0oF11kg/7PiB6gQjJmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaxOAwjVrZRiWCi10+i4Eft6Q3Q3qqlyfSoYTwec/Zg=;
 b=WUd3n2MuwxO4pZfQOno1BVHzaTrXgYBv+QHsGC1/9iXrA64qPNywMWzJN+888fJf8a/szis4tkWAXEaQ1rnONPd8FfaY5o+IHM1Uej+g5RTa/lNruzpGqSTNNHO3BF9H+VXmGbnFIMGwy1ymjsbHo0Z7/cgf0pUqr7iN/YCWg6pns+cc/2fPh7ikiWmRPRMx6xI7dnct1E/uLhBLgjndY8N1vPqtBLc8Lax644JCZaFpEg1NJ9HxqNS16S6KHHbyZJYPnZ2pum2kBORJevbZPxzFsPkGs/9jNtnZfC0T182Sz8VgPK9GpwUaE0f73swZGyhRCKO2GslXWH3ia9muoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaxOAwjVrZRiWCi10+i4Eft6Q3Q3qqlyfSoYTwec/Zg=;
 b=i1nAp9uHfQvfdcDjch8rTBpuHK2rnwAJudNnL0i9+GPkUvLYFPRxdJgpEX/rAe2BCMokhMUMSxJZUDirmZS5cpgrGRLMyNGO5qkvKd10CQHQKzdcXSYhaYcKT+O4ft8XM+cxvajJDPnL/yYRy74cnviJCqrOVh6JXofSRfc9xpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:38:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 09:38:36 +0000
Message-ID: <ce773c29-5558-4274-9ead-90ec21b6f250@amd.com>
Date: Wed, 10 Jun 2026 11:38:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/9] drm/amdgpu: Add render-node EVENTFD manager core
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
 <20260610060402.2769642-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610060402.2769642-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0134a6-d1b5-488f-5242-08dec6d40baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|4143699003|56012099006|18002099003|11063799006|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: j6DJ/Q8ISZiR2Wzkcqolqs+l+Qmw7Nf89uIdruuEixGmsPRz532Pp0K4uAsjJTMie4ItFa+BTGfyBwvTSbZnGtlyMwGKBr6rEbPp4+X68cCyZ1Utvlt1kFEgC+R0S11L045IeOSQ0a530JMFYwj2CvItKdBwJqfASclDYo0A3U1urpybl383/XbDmFMdqXY81fCrZjBgQvjp0rWpAUd0Y8XXdSlojXSnfT2avgvmIIgX5ZBLB5Py69zLWje7JjfPni+8iP80i18BV0vHGet5+1GIA+a4sps5CZVTm9jlB6UfPk5ILIVxkoXUYwXXR3TWBKMgX2wFf8LJf/AGclv6sv7CvdjrNfiZ6K2Ls/8ogp1SZgo/PxJBF/ICYXo+/GCxlOH7OTVY0ZH4+85cIPmNX1Ey6WLUOhH3u5c7lAk3m9dRJ/GQxbZJ8hRZ/7A5z3TCTTjU2A1cD/VEeZEppmWXfhFUt3mJukX5a3tJZQowKwHFlaKTwiCcsPH66fymImqi4Zo26miKsARbikrKf0Afik6g/cv7UmttPMUK7aEM8ljbUXt/gky5RiFCOM7pnC+fMhpJl/yz8+5gWCJjYurB29ExerqhFwPwSAR0Cc+2mUXD8H/bUJfkzHJ77Qd3+5D6XaP9mX0HaFxtbrBTiyQj0gVGzTbn7I/vfIERDWDRq8YN7xpk19Ljyp08cjioFeXL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkpUTkt0UVVkbUJLb2hCdC9ubnhoL1MrVnQwb21BM0VTVFJxUG9qUitJeVFk?=
 =?utf-8?B?ZVEwTXl6ZzRSRmlZWVJMNW56Z0kzREJOcGtDUlM2ZDBiZXIzUE9EZG5Wd2pE?=
 =?utf-8?B?bzc0KzJFNEo3WHFMWjRyaXFleE4vR0JmVThPTm9JSVVIZkdwREU4UnNiNm1D?=
 =?utf-8?B?MnN3NzJLa3NSWlNFdFdKczRtejM5NnE5dkFxczk3Uy9EZDJ3QlV1RzVDbTZK?=
 =?utf-8?B?eS9BZUM1WlFTVlg2ei9yY25ZR1ZLQS9BY1hMOHF5eWtRVTRPUGtibkpEejFO?=
 =?utf-8?B?OVcrQVhMcTV1bGRXZU51TUpZL3UyVWhGK2F1QXovSkVENzBYWnBFUG9mclRq?=
 =?utf-8?B?UkJVVzMvNklFdlNBVWNRNnJwSXg4QTJlUTdyUmRCaFJ4MFNYdW4vQmxJTzBh?=
 =?utf-8?B?U0xueXRiMEptdm9KWVRLaUtBM0RFV004aTZNa2ZEZlhpVlg0ajBMSUxrZGpq?=
 =?utf-8?B?aHBzeEUzUFJZTGtFNENMdnZHcXIwOEtpaFFKK0diQWIxRENKTFd5djA2K2Vu?=
 =?utf-8?B?MzY4cG9MckNRZDVDbjhhcGVMKzEvRVRiQldkOElyQnp2TUR5cVdDNlhHZnhk?=
 =?utf-8?B?dU9zTGpxc1Mvclc4d2lEVmxOMVRNbkgxOUNSVjR5TEkzQ01TNnlVYkZvZkVa?=
 =?utf-8?B?U0JwS1B3UTBzbGo1eFRLaDBlREl0dmY5MjdnL2ZpZU1haVZYajh6RjVFcUNH?=
 =?utf-8?B?QWd3cEI2amMxZ1lzOEpKTlFKL0taTkIwK0ZIb1pmakZsRlNndU9HY21JM2hl?=
 =?utf-8?B?ZElQcWJURnR2NVZjZDVUWkNSamxCNWhUSE1pQXpIYTZqakhuR3MrMG5pdmda?=
 =?utf-8?B?U3lGVDhIalp6MENyYXFocVJoc1lFeVU3dVlvOG80dzVVNXNiRmhNajdLMkl4?=
 =?utf-8?B?NXNQcTNFY2FMUEhuT2d5cWY5d1dBTE9HNzkrK0pmZVA3cE9YcWFJWElGQlox?=
 =?utf-8?B?WmdFd2cyTHhOcTZHMkNHUTFQSlJ6aFhyUWcrUWcva0NPRHpZdy9wLzBVVHVK?=
 =?utf-8?B?eXIrQVY2RUxLVFZ6YWhkeVppUTFnbXRCUkVOU3ZWUlVTeXFOcmp6Vy9Nbldz?=
 =?utf-8?B?NkxjYWVrc0tkYU13cEcxVVZlaTFQbWgzZmx6dVN4WU00K0cvVW5HQlRUWjFp?=
 =?utf-8?B?eVZ5V0IveTFubmJCTkJjbFpzL3FoNkdLdk9ZaEhZYlBmeEdKWE1lYVUwR2ww?=
 =?utf-8?B?aUVRY09LSnVuZXpTemRNMGd0Nm9SOTY5Zk1EcUwrZWxIb1FpWlUwaXR4T1dm?=
 =?utf-8?B?NStvSWFENGVndnhLYTlxdjBKb2w0Rkhsc3JDUVhFdXAzUWZKTVh4OWtGL2c1?=
 =?utf-8?B?blp3cmlwanBwSjhDUnd3TGFRSVltaUN2cUtSVTZNcUZQTk00L2pJRlFOcEpt?=
 =?utf-8?B?RmM1OGFmYkk2MDVMUFZaWHBHODg3Mys0cTFrbExUMXR0YlVQOHpFUFBiTCto?=
 =?utf-8?B?VHorNndpQzFFS1JMbVB4UjlYNWcxU09PbHNDVmZCdG1wZElUd0JKUHljeUc2?=
 =?utf-8?B?di9FVGxYU1ZabThIbDBReDV5bzM3NkVyN0NCR3ZxdjVJR245TE91S1dzZS9N?=
 =?utf-8?B?bTZvNkZhRk5hNlVWUXQ2ZzlmaUVZTzIrOTZlaitwUy9nTWptRko3RHBnQnRZ?=
 =?utf-8?B?cGxVK2xwQXV0WXN0YXVWeHVHQnI0dXFLVytuN2RIY3RjTURVOUhRVGt1MEcr?=
 =?utf-8?B?ekdlT0tBL3U3YWZMRkRyb3ZNTkNWWE43M1VxTFdnMGZnazFGTEw3T0xxVjV0?=
 =?utf-8?B?Z3VuVitQSEVFK2kwY0RMcTgvRjRpMUNpakFkQ0pQNkNZbjVwZzgybjBxMXBL?=
 =?utf-8?B?OHcxRjdaM3Z3WjNaZitUMjFBdHdlUnNqV2dMRzdlb05PSWtNK1BzcVdpTnB3?=
 =?utf-8?B?TFR2dDJsa2xUUDdHR29rQVBFclJIWDBpeVcvcjA5YmlZcGJZSUYzZ29QdWla?=
 =?utf-8?B?d0NQMXE3b1lsanZXb3BsU01KbytEeVFWaSswZlRnbGJJQlNwcEFjWXN5dlNE?=
 =?utf-8?B?NlBmRU83V3o4SVMwcjRQL0VRR04yVlcwMmw3UUZJdWtMVWcxT09sdFE0bGM1?=
 =?utf-8?B?UTRvTFpCUDV0cjZGRlJaTWMzL1FsZE1HNjA3UWhrU1h2MG5Bd3RsS1hIYnNP?=
 =?utf-8?B?MzZuUmxmMm16bkozTWNSQ3cwc2dFVTVHUlA5WTBsc0hjSE9OSnNwbTZTUzJa?=
 =?utf-8?B?MkhNd2FoSFJERnZoanU2MDNyRkY3Q2FwOE5Ka0lacmFORko4Zlg4N1dHYUpC?=
 =?utf-8?B?cXA4Mm1pY3FibjR0NzB3bjVaTzEwMEhZSksrcytndCt1SkpVQzN0T2xrdmxR?=
 =?utf-8?Q?SE2J5lmNYcVL6me632?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0134a6-d1b5-488f-5242-08dec6d40baf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:38:36.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0063bsZAL2mSgumA6+k2RdKKfg+QELQs1nIXI7JTM7EdQCrz7yS5CGkzVL7ive49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
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



On 6/10/26 08:03, Srinivasan Shanmugam wrote:
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
> v10: (per Christian)
> - Avoid GFP_ATOMIC in the event_id insertion path while holding the
>   xarray lock.
> - Use the recommended xarray insertion pattern to allocate memory
>   outside the xarray lock.
> - Simplify the eventfd unbind loop for readability.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 385 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
>  3 files changed, 446 insertions(+), 1 deletion(-)
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
> index 000000000000..3a6e08a3d0c1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -0,0 +1,385 @@
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
> + * without polling from userspace.
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
> +	XA_STATE(xas, &mgr->ids, event_id);
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
> +	/*
> +	 * Allocate xarray memory outside the lock if needed.
> +	 * This avoids using GFP_ATOMIC while holding the lock.
> +	 */
> +	do {
> +		xas_lock_irqsave(&xas, flags);
> +
> +		id = xas_load(&xas);
> +		if (id) {
> +			xas_unlock_irqrestore(&xas, flags);
> +			kfree(new_id);
> +			return id;
> +		}
> +
> +		xas_store(&xas, new_id);
> +		r = xas_error(&xas);
> +
> +		xas_unlock_irqrestore(&xas, flags);
> +	} while (xas_nomem(&xas, GFP_KERNEL));
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

This one.

> +	}
> +
> +	/* Allocate entry only after ctx/id prerequisites are satisfied. */
> +	e = kzalloc(sizeof(*e), GFP_KERNEL);
> +	if (!e) {
> +		eventfd_ctx_put(ctx);
> +		atomic_dec(&mgr->bind_count);
> +		return -ENOMEM;

This one.


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

And that one here look like goto style error handling would be better.

Apart from that nit pick, looks good to me.

Christian.

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
> +		if (e->ctx != ctx)
> +			continue;
> +
> +		hlist_del(&e->hnode);
> +		id->n_entries--;
> +		removed = true;
> +
> +		eventfd_ctx_put(e->ctx);
> +		kfree(e);
> +
> +		atomic_dec(&mgr->bind_count);
> +
> +		if (!id->n_entries) {
> +			__xa_erase(&mgr->ids, event_id);
> +			kfree(id);
> +		}
> +
> +		break;
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
> +	 * This can run from IRQ context. Keep the lock while walking the list
> +	 * so entries cannot disappear during signaling.
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
> +}
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

