Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A03FF30955
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 12:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0576010EAE2;
	Thu,  5 Mar 2026 12:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KnFpUjFq";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F6810EAE2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 12:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYCfLblDuZil4A5RWa7up0j18xi2hW0RzwleAwhKJ0Ijtx6Su8Z9VMlDrGSNJQpKWz4U12IV6PD3TMYmChQIMvCSfiq2gozqpQVD9Q+lDIkF4celLG7BFsHgOFNco9VTgBCBhXgioOLqZd6p5qTSyngjQP9JJaxc5QAhzlCp30XMuxZwCfSndYb5lOmtD/BGZTs7m7b7ZjYk3Uk3pOY7AL0aaJTKoc60BfzXDx9Bcqa1r/eCVyWlD28qoEkQrwdQSv5WvixxWNPtCzc6YeIvRFT6+EfjTvZKoq154evHPxz376cOYlG52ZVGlukxbrF46u+hee5Y747EvheHjFUPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlnEUw1O9Kj+xZ+J4cS7ClyWtzPHGsqulHcTJNtMdRg=;
 b=OB+4lS8YCpKq1fKQgCitdGBuNLc9rqxyEbGshvG/3kB/IfIfZYZUuADY5gV9sTbjywSHAiJWLexGLaRDr71zO+2C3Q2RkUeMso9yCb0o92s61uIb7twI1lzpz0lHZA1ny4D6wX7HWhtntWaOlGeRa8RUNFhNNvmPGbXZrFySwVN+h89AnrR/pdQKpKABIWmBBet9xwX9yOv70IvdT5RUSZP19imBfyoo4LgUVrNlWXq84f+GQljXzynpMCMiH/0WoWOEqgswAg8e4WI+bDLqusfMTHXnzYxoospmZYmY5znbZbIOFy1PK+EYIZ4lHWhqVHBtWTWF7i64MCJlCL4i0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlnEUw1O9Kj+xZ+J4cS7ClyWtzPHGsqulHcTJNtMdRg=;
 b=KnFpUjFqyU1ToxCUG0nI01luVYa3uYkwlTy8HaJWyX7YBSpZJE8QL9ffLvie88mzZrJHSSABM+n7LPfPN5Z3ihNuB8VPwXkH72CKm9QiFsVFhL5qMvi+DVJP7bY5iQkan8pUDsNe55C2pr89G0rgANptd2xPwp+DWx6pdhWVUa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 12:37:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 12:37:32 +0000
Message-ID: <1edbaaed-3c4b-4e39-95c2-1a763022e1ab@amd.com>
Date: Thu, 5 Mar 2026 13:37:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amdgpu: Add render-node EVENTFD manager core
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
 <20260305030726.1779794-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260305030726.1779794-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0683.namprd03.prod.outlook.com
 (2603:10b6:408:10e::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc68fb3-8259-443c-7d4e-08de7ab3f8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: QKEd5fZgUp9Ur/BqD0sK7d1b3FVyki0fy9+DQTDCW5OezO1WN++tO8rDcFwRwwSisJlqDJJyYiUpzgeN5oovFG1Sc+dWJ1SXechJ9h3NDY/CvxL11G1Zujtl/K4MP0gIvZCrD/m5CP5jex6JAMAPaIIIn+6yK0Fthdg7tDSlp8guXhSAsxEyhfIFJaLzEmasNnbeIKcbl1ZZXc9FDmyDEIraimWg04NZ0EIv6voQ0bc2Ct1pY150+Z4Nxu/9AfLU4102SKQIUUSgDXcsrKL/5z5lYKrYeP5fNZFCwsIYFbPqhALcj2EJoaL0NuF4AlVIB8XKvoo8bA3LItbTBCnOE19Zwlsm/wTVtOWiN0v3FDjSdso+hpiS0W3oLVZgJeG6PYLPM7yda1Akl79BLVYSYKYvlGv0wESidtrnvFHaLqoS9LhPtBPb3QvT10v+2dSWXyxZF1n2I4RmeXT5N5vcC8NZ0Dt6HfEC4h4VrJQIbEw+Jlx8W3YSUoosO0LWxfG8yOlRF6KxDALMMSflOJ/OfnQeaz2QpTTTezY7Uz5oPwu3IbEFch9GTnCcCSiBZ6gZYbalN9laqHPlSmOndePZixY4Nf2/myS08KjSJ7o/04ApMl92zBifd0PXkCFDQdw72ocefQdWLUhXu3aqsB+lSlXl4V7P0UEFAJMPCYRuUA0GgpIpQSgfvTLJpYwVC/grji3dZgdXBfw61ZZuU/T0CCH8/MxpQ/8Sbd+N035R7i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVRmQ2x3ckpGQWc2cDRzZkZNcEJUdWxBNFZTL1BVZGhPSVVZdkIrR2VTV1hU?=
 =?utf-8?B?Tk5QYjVaV1d1YnN5OHFqenl3My8wSE56Q1daYWhFUm1qeUpBLzVKMHZVTzZE?=
 =?utf-8?B?VS9RdHZ2c1hkMFZhVHdNTUdNS1ZmcGdmWWhXS2M4L0V2ODZHMG1zdmsvQnZZ?=
 =?utf-8?B?RmZuREdxOEJOSVcwTWthVlhTS3k3Wk0wZmxkSGUxV1ZOTXJTWFptNFZ5OGdI?=
 =?utf-8?B?dFo2L3l5bHVyZG9lRUFDekozVWpaWXo3aUF4QkZEMk55TTM5S3hkbTNERmhQ?=
 =?utf-8?B?aWJidDl0N2RLM2FMcHJzUHZnZVVEc0ZRTXJ4YkluS0VhS1hMcnhMRUs2bks5?=
 =?utf-8?B?dC9Da3NiODM4RE5mc2pZUTJiZXdMN0tWRW9Kc3pjRnF5WHVveE16ZGlKNnBQ?=
 =?utf-8?B?bVlYbjlyV1JiVExDeTlhd2lHZ0VqS3pIUkt5d01xZ1JWSzRBWDVSNExCa1F4?=
 =?utf-8?B?dG5CR0ZlOUtZcitnNUdTN25tRlQ0WGRIc1QvcDZoNWFVdFRBQmg2MU04OHhs?=
 =?utf-8?B?WVp1UEJJUzFKR0hwa01BRUkxeE00L2RoOE4rOENFVXhLQm9kczcxZXRENU8x?=
 =?utf-8?B?UkhUZUo0QlpOQnU0SmpVYUtCRzROdFc3S0NZNTNjNDhBSmRWN3NnMkVWcFI2?=
 =?utf-8?B?SG9GQllVd1Q0eklkZFpaZzNuMWR6TVB3Wi94SUNCUU1vczNHd1RHeHFLRG5T?=
 =?utf-8?B?UlZLTUVodlcxUFI2QlJQeTBJSGZtZjRJUUNscEJiUTVkOFZpQkY0NFphTmp3?=
 =?utf-8?B?SnJ3eUtjTlBOaDYwbkhGYWF1a1dsejltL3BWL0dsaU9jMkJxOE5IQzEvSnQ5?=
 =?utf-8?B?R2hmU2oxbjZHMi9sMWV1UGNzSm9IWHcxNEJmd1Y3ZURiOFlFeWpwK09pbkFT?=
 =?utf-8?B?c3ZPVy9MSmlqaktsNjBSQmEwRjlZUG51bWVmVnI3MVB4M0ZBTXEyOGpJdTVH?=
 =?utf-8?B?bXl1V1RPRHpwUFdaaEVCcWdkQ1dvc0dPY2Z2SS9KV0VSenFqUWZzRkVmOUQw?=
 =?utf-8?B?NXp5Skd1OVpJM09UV2MzcUhhUUpYdEZtbEx1dHdjclR3K085OUNRZW5DRkhJ?=
 =?utf-8?B?MnJoMXc5aU1qbk9TcVh0SmFRdXBEelBVT2xJWHFQZkNBWFB2MUVKRTJFWkc5?=
 =?utf-8?B?azRkMFRLMHd2THlsTkwyTCtvdlRmUW9hWDQ5VGdaajUvUlJrQzF4dmRlem1l?=
 =?utf-8?B?T3BQL2ZPNGM0TVlzUWkreFdJY291dTZpRTRzZHRyZUNzME14bWFvaTlxQnNS?=
 =?utf-8?B?NmpUTmtCR2V3QSthd0NuTCs4KzRHZno5VmlZWWNTcG9oRW5vTDJWaUxQWmph?=
 =?utf-8?B?Wk05NGV3cC9zMjJvbGhvbW9zWnVFWENZZWVvRTVJSnNOOWJqc3B4UkF6WWZQ?=
 =?utf-8?B?eTdmbG5FTmJ3WlMwM1liQXRhREJURUcrK3BZTjh0TktmcTJTTFo0ZUd5UnBn?=
 =?utf-8?B?NVY5WU9kTXl1K2x5UWlVb2dTMUdyNjBGRVFNUEFQZkhqdGNJQzkzMFljczBT?=
 =?utf-8?B?RkRGdzJtNHVYTWlBSGNPY0k4YWIzU3dQbVlFVXRjbmV5UEZOcTBqakFweXVC?=
 =?utf-8?B?UnBCcVNPckJDYk5DVEkzdTFnQkdwaDhMMkNKaFcveWY2OWx3THZxc2pveFZI?=
 =?utf-8?B?cGlHRmxvTDBYNHdZVWhDOEpDMjFSeHZnYzJYY2Z5b1NvcGRrT2xvU2x6YzRo?=
 =?utf-8?B?VmdGS0xvWFJ5WUJxM0RiVS9Od1BtMG4rby90OS84WGNHMHRmMllTS2JaYmNL?=
 =?utf-8?B?N3FLUWRIak1CdzNoM29zNjZSWHFUKy9OZlhlODJWTTVUZWZXdjBMWEtqRHY5?=
 =?utf-8?B?TEtBWGlXWTZzYVZRdllIL3paVFQzcXlDOUFWRUJ3TVpCRTNIY0d3U3JuUGhG?=
 =?utf-8?B?Y2NCdXZoWHkwTC9aa21aZVR6aHEwRFV5VTRSQW5WQVpETHo2RGN0MDBBaTFS?=
 =?utf-8?B?U0x3a29wNGkxbGZpb0FhOWpteHRIQ0daWkRwZTREUnN0WmNNbWkxUmJzZVlL?=
 =?utf-8?B?ZkxHRER0SUwzS1BKSitnY3poVFoyT290TUFYdWVpY0xzNnZGWnZqMnh2K2hU?=
 =?utf-8?B?TWtjVW5xWWJoZ05wcG1zSndPQUFjeW5iM2F2WXVnUGdlbHpvZkhoKzVZZnFT?=
 =?utf-8?B?L0l4VDRFNHlNVlRoV0RMRHpJSWVLWURRL0F1SHV2SWcxcFVrOTdBcGhCdDds?=
 =?utf-8?B?Q1dRc0c3bmQ3WmpWSDVwVmFROGhKUUh5RmhqNnlhWVhoSHd3WjUveGlMeXRw?=
 =?utf-8?B?RHlGRGpUNHVvbUhHNDlkOExHRFpIN1h1Mmpmc0pPZEZWZUZ4QnFxdG0rZDJQ?=
 =?utf-8?Q?nU0fq3Y67QYhl5xmHK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc68fb3-8259-443c-7d4e-08de7ab3f8b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:37:32.5197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGhnnWiJWbg6Py8Ip7YsmaEehSRyeyYxuPsbyvQy99fGt10Mg5T8l3J3shSmYN5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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

On 3/5/26 04:07, Srinivasan Shanmugam wrote:
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 279 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++++
>  3 files changed, 340 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 006d49d6b4af..30b1cf3c6cdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
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
> index 000000000000..9806ec515cfc
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -0,0 +1,279 @@
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
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +
> +#include "amdgpu_eventfd.h"
> +
> +#define AMDGPU_EVENTFD_MAX_BINDS 4096
> +
> +/*
> + * Helper: caller holds xa_lock_irqsave(&mgr->ids, flags).

It would be better if that function is called without holding a lock and also allocates the new entry.

> + *
> + * If id exists -> returns it, keeps new_id untouched (caller frees it).
> + * If id missing -> stores new_id and consumes it (sets *new_id = NULL).
> + */
> +static struct amdgpu_eventfd_id *
> +amdgpu_eventfd_get_or_create_id_locked(struct amdgpu_eventfd_mgr *mgr,
> +				       u32 event_id,
> +				       struct amdgpu_eventfd_id **new_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +

> +	id = xa_load(&mgr->ids, event_id);
> +	if (id)
> +		return id;
> +
> +	if (!*new_id)
> +		return NULL;
> +
> +	if (xa_err(__xa_store(&mgr->ids, event_id, *new_id, 

You can simplyfy this by using xa_insert(), that function returns -EBUSY when there is already an entry at the specific location.


GFP_NOWAIT)))

That is incorrect. If xa_store can't drop and retacke the lock you would need to use GFP_ATOMIC here.


> +		return NULL;
> +
> +	id = *new_id;
> +	*new_id = NULL;
> +	return id;
> +}
> +
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
> +/*
> + * mgr lifetime is tied to fpriv:
> + * - init at open
> + * - fini at postclose (after unregister / wait for ongoing IRQs if needed)
> + */
> +void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	xa_init_flags(&mgr->ids, XA_FLAGS_LOCK_IRQ);
> +	atomic_set(&mgr->bind_count, 0);
> +}
> +
> +void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	unsigned long index;
> +	struct amdgpu_eventfd_id *id;
> +
> +	/*
> +	 * Final teardown: keep xa locked while we remove ids and
> +	 * drop all eventfd references (IRQ-safe).
> +	 */

> +	xa_lock_irq(&mgr->ids);

That is only necessary if the we didn't waited on IRQs before, but I think we should do exactly that in the next patch set.

> +	xa_for_each(&mgr->ids, index, id) {
> +		struct amdgpu_eventfd_entry *e;
> +		struct hlist_node *tmp;
> +


> +		__xa_erase(&mgr->ids, index);

That is superflous, xa_destroy() takes case of removing all entries and is much faster.

> +
> +		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +			hlist_del(&e->hnode);
> +			id->n_entries--;
> +			eventfd_ctx_put(e->ctx);
> +			kfree(e);
> +		}
> +
> +		kfree(id);
> +	}
> +	xa_unlock_irq(&mgr->ids);
> +
> +	xa_destroy(&mgr->ids);
> +}
> +
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +{
> +	struct amdgpu_eventfd_id *id, *new_id = NULL;
> +	struct amdgpu_eventfd_entry *e = NULL;
> +	struct eventfd_ctx *ctx;
> +	unsigned long flags;
> +	bool found = false;
> +	int r;
> +
> +	if (!mgr || !event_id || eventfd < 0)
> +		return -EINVAL;
> +
> +	/* Enforce total bind limit (atomic, no mgr lock). */
> +	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
> +		atomic_dec(&mgr->bind_count);
> +		return -ENOSPC;
> +	}
> +
> +	/*
> +	 * Allocate objects first (can sleep). Take references later.
> +	 * new_id is cheap even if unused.
> +	 */
> +	new_id = amdgpu_eventfd_id_alloc(event_id);


> +	e = kzalloc(sizeof(*e), GFP_KERNEL);
Only allocate that after all the pre-requisites have been checked. E.g. if ctx, id etc... have been allocated.


> +	if (!e) {
> +		r = -ENOMEM;
> +		goto err_dec_limit;
> +	}
> +
> +	ctx = eventfd_ctx_fdget(eventfd);
> +	if (IS_ERR(ctx)) {
> +		r = PTR_ERR(ctx);
> +		goto err_free_entry;
> +	}
> +	e->ctx = ctx;
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +

> +	id = amdgpu_eventfd_get_or_create_id_locked(mgr, event_id, &new_id);

Move all the functionality of this into amdgpu_eventfd_id_alloc(). It is not problematic that we drop and take the lock multiple times as far as I see.

Regards,
Christian.

> +	if (!id) {
> +		xa_unlock_irqrestore(&mgr->ids, flags);
> +		r = -ENOMEM;
> +		goto err_put_ctx_free_newid;
> +	}
> +
> +	/* Duplicate bind policy: idempotent no-op. Compare ctx pointers. */
> +	{
> +		struct amdgpu_eventfd_entry *it;
> +
> +		hlist_for_each_entry(it, &id->entries, hnode) {
> +			if (it->ctx == ctx) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			hlist_add_head(&e->hnode, &id->entries);
> +			id->n_entries++;
> +		}
> +	}
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	/* If event_id already existed, drop unused allocation. */
> +	kfree(new_id);
> +
> +	if (found) {
> +		/* Drop the new reference + entry; keep existing binding. */
> +		eventfd_ctx_put(ctx);
> +		kfree(e);
> +		atomic_dec(&mgr->bind_count);
> +	}
> +
> +	return 0;
> +
> +err_put_ctx_free_newid:
> +	kfree(new_id);
> +	eventfd_ctx_put(ctx);
> +err_free_entry:
> +	kfree(e);
> +err_dec_limit:
> +	atomic_dec(&mgr->bind_count);
> +	return r;
> +}
> +
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
> +			hlist_del(&e->hnode);
> +			id->n_entries--;
> +			removed = true;
> +
> +			eventfd_ctx_put(e->ctx);
> +			kfree(e);
> +
> +			atomic_dec(&mgr->bind_count);
> +
> +			if (id->n_entries == 0) {
> +				__xa_erase(&mgr->ids, event_id);
> +				kfree(id);
> +			}
> +			break;
> +		}
> +	}
> +
> +out_unlock:
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	/* Drop the temporary ref from fdget */
> +	eventfd_ctx_put(ctx);
> +
> +	return removed ? 0 : -ENOENT;
> +}
> +
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
> +	 * IRQ-safe: keep xa locked while signaling.
> +	 * eventfd_signal(ctx) is IRQ-safe.
> +	 */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	id = xa_load(&mgr->ids, event_id);
> +	if (!id) {
> +		xa_unlock_irqrestore(&mgr->ids, flags);
> +		return;
> +	}
> +
> +	hlist_for_each_entry(e, &id->entries, hnode)
> +		eventfd_signal(e->ctx);
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +}
> \ No newline at end of file
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

