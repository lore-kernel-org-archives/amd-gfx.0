Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59EC64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 12:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D852110E3FA;
	Mon, 27 Feb 2023 12:43:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D4210E3FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 12:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtl1ss7x4nmKgnnPZ17DhtE//8thu2EbyHkqmT5KmD7dXE1PDcG6DTNI7LzGS6PQcFzcLP0lhIbTxSQ8qXjyQOvFIiMCmyuAtnKvHxaiykH8LKAuVxbIiPIme9jhHP+yOwxKUbG0l/DkUACBcb2ke3KkYcN58tBlnIks4x+HVu3HdfFy92/6lbq68LG9AHss39kDWTU6HmLJHuO7vlRtc32v0vh+3Jezd/dYpzYyy/nJod41XIuWt3l5sYdR+raPfHLS3k1o82Ew24DUFqoynh/UVROloSifx4/OhnuY635x9IIzUwY7FohB2TkGfWPiBLsvVVFCagzXoScg5vDujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86hDiKAJ2B6suAktR0Z28vNn8M886TW/d1O7YI7eYrk=;
 b=M5s8MEDYEWgBl1mE+pO2px2kFGnlpfjrE11GlZEWb1MuGg4UztHymXk5Coj1JIT6sNYRCDYWpFbl/FTdk2+iNW3gXoems/CTun3OS7nwdk0tKurbbd7CubsGJO2bEENXO/ua2MfH53QowK1GylCe0u3+SSCaClAo31KizyXCOKYbnPeGotbEW2jP7ZiRLOmuXmvaYL7v57vgxUkEnLOhkC2I4NIPLQPhF7gFe0+NOSxjDBVjX+h7+eEiWMbm5V/ZWx1jlAihj3yiEmAcuRDZGNt//zsIMoAdyvvlCNYhdwR3C+4oaxbHSYxQz1o69+FRDieObtVsTneenTk2N12HAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86hDiKAJ2B6suAktR0Z28vNn8M886TW/d1O7YI7eYrk=;
 b=b2zGWRvDYqiEwO5gh0xdKc5DnWiB6+gnn9fDzP2jpxk7o0Mhio7uuPToyrNpfDilWFWewu4O7Cw50Bc8LpMEuX9FDFZXhx/k8uEdug1MWXVg4lUjT0W+pqGsHudkT1qn7+BKrGUDqpoEjScI3lYtCZSn/uHt8gqzak+17L8ME0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 12:43:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 12:43:03 +0000
Message-ID: <1f68e20f-3934-b66f-48d5-cb62da7f8895@amd.com>
Date: Mon, 27 Feb 2023 13:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] drm/amdgpu: Implement a new userqueue fence driver
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
 <20230226165435.41641-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230226165435.41641-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bdfcfa-d403-40ea-ff86-08db18c02a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeAl6C9lan8ZgJ9mlnP3PPyXuD20pl44JZuCbVcuAmoksUPNdkGjDNWZ3UdYAR9ag0FRW5RvQ0/DFj+Y0+kPdJnfj+aygrqxHzWzi4nVzDIiuaodrcrbMVP280HQ9WzMs5tiErTAFYPpwm8ynpDQw746Zr+MJKVMVJIYMjGV3ketQwQMcLn8ZzwdwhXy7nmDVbY+gobFJB1iCDdIE5fEeSrrYtJmHc62n6tRdLX42CzrbIdQNKia2B9FxqkIF7oNYNaDBNhwZkpjNLw4sOKwyDoywm23JEZR2o6GAlZqfFRscieH4Msqwtyl/yvfYSFQOOJ72gpqIJ6puRFYGh6RPRiU3kq9mTMZhFEUjI81/rOuGgGzuePYH8kRnzjnSLPQ6IZCt1NyScXh+KGZ6XpLb7NQMRwEdFa6axfJAdS/iso+3xWSK08r2WhG8LBaBZaF8PMOC0ZRPAsIDx2WELj3e4p7o5rjCfgzjXeY2FSPYwbuWTsqF+BfdbTl191LOBAkuxlgTTHt3CPXZT9DlC4EdFaOo/CY8IDjajBa/oHb4hZW28yQlddlKK3/jVY2EC3uMEcSk6InhXStrDdIXC95YAJRLcfah1Pdr+faL8nvckNnfK9SYsj14w7asYSak2/VItO0CSKnbx5jB/ejGLGAB3+W0kBjGmkUl4i0Fi5zx2xi3TPOXlNxd9ofNP+o2shDD6HO8Y5puF3Yjs81/ycjMBUpmEQpdSuvO7HU5j2Xa7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(8936002)(2906002)(5660300002)(31686004)(30864003)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(316002)(66899018)(478600001)(6486002)(6666004)(26005)(186003)(6512007)(6506007)(2616005)(86362001)(36756003)(83380400001)(31696002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXpWMXJJUnplbTBWWGViVHY4NzEyYWEyeGtRT2JxQmdyTEVQS2dVOEgyelhD?=
 =?utf-8?B?M1ZSTGIvU1QxYkdlczdMem9KcTI3bjRKNnhFWCtINzVMZ283aTBNakk1NHpz?=
 =?utf-8?B?MktncStlUFRPTSsycnBwd20weFNzWE56SzRNVXIycURSODBxYVdQdSt3amRU?=
 =?utf-8?B?THVFaVQ2eSsvRFdqWHEwTVRXYmNLY3grNkpsTGVvdHpqTVRjcDlwZEpjeXlW?=
 =?utf-8?B?c3VWcnlDU3BlWUZkZ2o0TThQVnhNOWJ4bWRBVTNaY00vUzE1L0RSRG5lSW9s?=
 =?utf-8?B?MHdwSzBJS2NwUDJ3OHdUQWp1cmpFWDVFeHdYU2tFbUc4TEJTSTJIWlZDWVBO?=
 =?utf-8?B?bzVseXdONmd6ZHdaaFZvSmF2Y2RLNlVYNDFnZG80UldPQ2p5V0trYU1vclhD?=
 =?utf-8?B?UDJFWFRmWGZTdkxTZEJLUkRULzJ1YzNleXBkZnNMR1hQelBuWkJWUE5uNFA5?=
 =?utf-8?B?b1lrV2UwZk1XZkNFKzQ0OHNOMTNEeXA4NDNVb0xBU0ZNSTRkakxFcDFhdHJW?=
 =?utf-8?B?d0EwY1U1aUVBbnpuSkZmZGdVTW5NWHJmbjZZMkJGR2VOTW5zYm5BUHFKRDFy?=
 =?utf-8?B?blhBc05PcEw4bGVORFh0SXJCZUdJWUozL3dSbGJlZWZMLzJLZGg5cDJmUVAr?=
 =?utf-8?B?a1l1dUpiNFBXZEU4Q2FiVVZPTUl6dlZCbWlVNVJncWRGS1cyMEllZVVXdDZy?=
 =?utf-8?B?aWVXRk1oREw0WmlkUE1rUUd6OERHZzQ4eTR4MHdyWk5xNFNhcklia0h0V3U2?=
 =?utf-8?B?Zm5lKzdpMUdlblJEaytMYjhrVi9qMmZUSUpoaWQzeVM2ZnVmN1F6VEQ1bzFl?=
 =?utf-8?B?TTlHYjRiaFJqTEZZZk9VaVNzRkRCdzhmTktNVk5MSmY1OGRQY1dpakNYb1dS?=
 =?utf-8?B?OE5iZlYxRSsveDExK3FWaWkvdUVmMFg2N293UHNoWlJDaE02VVYwUEpQeERL?=
 =?utf-8?B?eWFGWHJydEZDalJUZkZrbU1GVTlwK09CclJJdzhYeVhwV2x3Tm1mZmNsK08x?=
 =?utf-8?B?UUR0cmVoaHBwelF4dlJaZFo2NWxMNzJMVGdBV05MQ1p2Q3JRdllmdjRoVytD?=
 =?utf-8?B?NTRTaUZRelFIV2x1QysxV1BtWHErUTNLYllwZ0VmSXhta1IyRlF0ajRWMVZt?=
 =?utf-8?B?NEdMQy9ZZ2NVZFRuZ05ERGZpOWdoNGZxOXBybzZzZ0daRmplY2JhMm1pZjdq?=
 =?utf-8?B?TnJRWE1PcHVOUkVwUUpoWFRmWUZTcW40N2xGR2dIQk5tVTVEckw2cHpLaFJG?=
 =?utf-8?B?L3REcThNeWYvWVVmUFBNdGpYWWpXQ3FYbjNXRHpNSjFFYVZYbzYxanlRYTlU?=
 =?utf-8?B?MkhVYjJNaEU5RFpHQ3dWdElzaGlqUTRmcElYNklYMUxHamlTSmg2UjlFNTR4?=
 =?utf-8?B?cUo0azhQR0FwOC9ZVlVvZy9FQlhxc2ZHMWNnL25aRk52WmdSSHNtMWVXcVBI?=
 =?utf-8?B?L1pJVWg4VzBIUCtRaVdZWUF4MHRYMThrYXhpYjVkOENmZWZJcG9LWE1OM0ZV?=
 =?utf-8?B?Y3h5ZUlZU1VhL1dPc2ZkR2JTWmQ5eFNvaXFqclRUZkxoY2VlVHZXYnBUbk5s?=
 =?utf-8?B?S3h1Nm9hNUF5aW9RdktvbVJmWmxTMlBxeW1wK0FKQ1VEVzU4Wmt5aEl2Znkv?=
 =?utf-8?B?SC9SZ2tXYkYybUQyaVNCcVk5ZUFLeTQrOE81czgwdmwwY29aZUZmaVhJclE3?=
 =?utf-8?B?OE83dTlFTG5haUlpK3BlcGZGU2VCMFdGd0E0U0VscitTVzBYZTlUbVd5YUhT?=
 =?utf-8?B?dC83Y3I0UzhPNmZyelVNY3Q4L2l4UmZQenZJQnFTRTVlWVFVWXkzZU9qemcx?=
 =?utf-8?B?VHc0NmNuZFY3aGowcHVsMzR6TzdzLzB4WE1SWjhVUnZCM0FpTVFLL0xWZU9t?=
 =?utf-8?B?SzNBUWc2Y0pYSTJyV3RwREF6dTR3SHBhS3Z3dWlFNThYbzlBMWZZVTY2d3hB?=
 =?utf-8?B?UDJJVWgxRHlCeWw1ZDBFZWhVYTJxSzNiRE4wZE91N0xpYmVyd3o1L1lhV3VM?=
 =?utf-8?B?WnN3aTJjS1RvTUp0eVNoZE1icklPVmMwcnFXTzlMYnk2TmlDc1R2b1VhRWxP?=
 =?utf-8?B?UUN5N25RYmlkc25IVjN6WlVHV3V6QXEyZ0pOaGlCYWtqbHNIT1FKaTh3U3JH?=
 =?utf-8?Q?Q5lDS4IfqP7xfAw9HuLtnEOw3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bdfcfa-d403-40ea-ff86-08db18c02a73
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:43:02.9495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijmobaXVDRlhHi5l7mJry/k409nZdPS2NPl21ounQ7gc8fHSMNAHrkiSEqdBnljh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.02.23 um 17:54 schrieb Arunpravin Paneer Selvam:
> Developed a userqueue fence driver for the userqueue process shared
> BO synchronization.
>
> Create a dma fence having write pointer as the seqno and allocate a
> seq64 memory for each user queue process and feed this memory address
> into the firmware/hardware, thus the firmware writes the read pointer
> into the given address when the process completes it execution.
> Compare wptr and rptr, if rptr >= wptr, signal the fences for the waiting
> process to consume the buffers.
>
> v2: Worked on review comments from Christian for the following
>      modifications
>
>      - Add wptr as sequence number into the fence
>      - Add a reference count for the fence driver
>      - Add dma_fence_put below the list_del as it might frees the userq fence.
>      - Trim unnecessary code in interrupt handler.
>      - Check dma fence signaled state in dma fence creation function for a
>        potential problem of hardware completing the job processing beforehand.
>      - Add necessary locks.
>      - Create a list and process all the unsignaled fences.
>      - clean up fences in destroy function.
>      - implement .enabled callback function

A few more nit picks below, but from the technical side that looks 
mostly clean.

>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 251 ++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  61 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  20 ++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>   6 files changed, 341 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index a239533a895f..ea09273b585f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -	amdgpu_ring_mux.o amdgpu_seq64.o
> +	amdgpu_ring_mux.o amdgpu_seq64.o amdgpu_userq_fence.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bd3462d0da5f..6b7ac1ebd04c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -53,6 +53,7 @@
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_reset.h"
>   #include "amdgpu_userqueue.h"
> +#include "amdgpu_userq_fence.h"
>   
>   /*
>    * KMS wrapper.
> @@ -2827,6 +2828,10 @@ static int __init amdgpu_init(void)
>   	if (r)
>   		goto error_fence;
>   
> +	r = amdgpu_userq_fence_slab_init();
> +	if (r)
> +		goto error_fence;
> +
>   	DRM_INFO("amdgpu kernel modesetting enabled.\n");
>   	amdgpu_register_atpx_handler();
>   	amdgpu_acpi_detect();
> @@ -2851,6 +2856,7 @@ static void __exit amdgpu_exit(void)
>   	amdgpu_unregister_atpx_handler();
>   	amdgpu_sync_fini();
>   	amdgpu_fence_slab_fini();
> +	amdgpu_userq_fence_slab_fini();
>   	mmu_notifier_synchronize();
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> new file mode 100644
> index 000000000000..609a7328e9a6
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
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
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +
> +#include <drm/drm_syncobj.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_userq_fence.h"
> +#include "amdgpu_userqueue.h"
> +
> +static struct kmem_cache *amdgpu_userq_fence_slab;
> +
> +int amdgpu_userq_fence_slab_init(void)
> +{
> +	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
> +						    sizeof(struct amdgpu_userq_fence),
> +						    0,
> +						    SLAB_HWCACHE_ALIGN,
> +						    NULL);
> +	if (!amdgpu_userq_fence_slab)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void amdgpu_userq_fence_slab_fini(void)
> +{
> +	rcu_barrier();
> +	kmem_cache_destroy(amdgpu_userq_fence_slab);
> +}
> +
> +static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
> +{
> +	struct amdgpu_userq_fence *__f = container_of(f, struct amdgpu_userq_fence, base);
> +
> +	if (!__f)
> +		return NULL;
> +
> +	if (__f->base.ops == &amdgpu_userq_fence_ops)
> +		return __f;
> +
> +	return NULL;
> +}
> +
> +static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
> +{
> +	return le64_to_cpu(*fence_drv->cpu_addr);
> +}
> +
> +int amdgpu_userq_fence_driver_get(struct amdgpu_device *adev,
> +				  struct amdgpu_usermode_queue *userq)

Looks like you misunderstood me a bit.

The usual naming convention in Linux for reference counted objects is 
like that:

_alloc() or similar for a function creating the object (the one which 
has the kref_init).
_get() for the function grabbing a reference.
_put() for the function releasing a reference.
_free() or _destroy() or similar for the function which is called by 
_put() to cleanup.

> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	int r;
> +
> +	fence_drv = userq->fence_drv;
> +	if (!fence_drv)
> +		return -EINVAL;
> +
> +	/* Acquire seq64 memory */
> +	r = amdgpu_seq64_get(adev, &fence_drv->gpu_addr,
> +			     &fence_drv->cpu_addr);
> +	if (r)
> +		return -ENOMEM;
> +	
> +	kref_init(&fence_drv->refcount);
> +	INIT_LIST_HEAD(&fence_drv->fences);
> +	spin_lock_init(&fence_drv->fence_list_lock);
> +
> +	fence_drv->adev = adev;
> +	fence_drv->context = dma_fence_context_alloc(1);
> +
> +	get_task_comm(fence_drv->timeline_name, current);
> +
> +	return 0;
> +}
> +
> +void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
> +					 struct amdgpu_userq_fence_driver,
> +					 refcount);
> +	struct amdgpu_device *adev = fence_drv->adev;
> +	struct amdgpu_userq_fence *fence, *tmp;
> +	struct dma_fence *f;
> +	
> +	spin_lock(&fence_drv->fence_list_lock);
> +	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
> +		f = &fence->base;
> +		
> +		if (!dma_fence_is_signaled(f)) {
> +			dma_fence_set_error(f, -ECANCELED);
> +			dma_fence_signal(f);
> +		}
> +		
> +		list_del(&fence->link);
> +		dma_fence_put(f);
> +	}
> +	
> +	WARN_ON_ONCE(!list_empty(&fence_drv->fences));
> +	spin_unlock(&fence_drv->fence_list_lock);
> +	
> +	/* Free seq64 memory */
> +	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> +	kfree(fence_drv);
> +}
> +
> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
> +{
> +	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
> +}
> +
> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
> +			      u64 seq, struct dma_fence **f)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	struct amdgpu_userq_fence *userq_fence;
> +	struct dma_fence *fence;
> +
> +	fence_drv = userq->fence_drv;
> +	if (!fence_drv)
> +		return -EINVAL;
> +
> +	userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
> +	if (!userq_fence)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&userq_fence->lock);
> +	INIT_LIST_HEAD(&userq_fence->link);
> +	fence = &userq_fence->base;
> +	userq_fence->fence_drv = fence_drv;
> +
> +	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
> +		       fence_drv->context, seq);
> +
> +	kref_get(&fence_drv->refcount);
> +
> +	spin_lock(&fence_drv->fence_list_lock);
> +	/* Check if hardware has already processed the job */
> +	if (!dma_fence_is_signaled(fence)) {
> +		dma_fence_get(fence);
> +		list_add_tail(&userq_fence->link, &fence_drv->fences);
> +		dma_fence_put(fence);
> +	}
> +	spin_unlock(&fence_drv->fence_list_lock);	

> +	/* Release the fence driver reference */
> +	amdgpu_userq_fence_driver_put(fence_drv);

Hui? That doesn't make much sense. We should keep the reference as long 
as the fence exists or at least as long as it isn't signaled (the later 
is probably better, but tricky to get right).

> +
> +	*f = fence;
> +
> +	return 0;
> +}
> +
> +bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver *fence_drv)

Maybe name that function amdgpu_userq_fence_driver_process() and move 
that up a bit to group together the functions dealing with the 
fence_driver and the functions dealing with the fence.

> +{
> +	struct amdgpu_userq_fence *userq_fence, *tmp;
> +	struct dma_fence *fence;
> +	u64 rptr;
> +
> +	if (!fence_drv)
> +		return false;
> +
> +	rptr = amdgpu_userq_fence_read(fence_drv);
> +
> +	spin_lock(&fence_drv->fence_list_lock);
> +	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
> +		fence = &userq_fence->base;
> +
> +		if (rptr >= fence->seqno) {
> +			dma_fence_signal(fence);
> +			list_del(&userq_fence->link);
> +
> +			dma_fence_put(fence);
> +		} else {
> +			break;
> +		}
> +	}
> +	spin_unlock(&fence_drv->fence_list_lock);
> +
> +	return true;

BTW: What's the return value good for? Could we drop that?

Regards,
Christian.

> +}
> +
> +static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
> +{
> +	return "amdgpu_userqueue_fence";
> +}
> +
> +static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
> +
> +	return fence->fence_drv->timeline_name;
> +}
> +
> +static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
> +{
> +	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
> +	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
> +	u64 rptr, wptr;
> +
> +	rptr = amdgpu_userq_fence_read(fence_drv);
> +	wptr = fence->base.seqno;
> +
> +	if (rptr >= wptr)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void amdgpu_userq_fence_free(struct rcu_head *rcu)
> +{
> +	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> +
> +	kmem_cache_free(amdgpu_userq_fence_slab, to_amdgpu_userq_fence(f));
> +}
> +
> +static void amdgpu_userq_fence_release(struct dma_fence *f)
> +{
> +	call_rcu(&f->rcu, amdgpu_userq_fence_free);
> +}
> +
> +static const struct dma_fence_ops amdgpu_userq_fence_ops = {
> +	.use_64bit_seqno = true,
> +	.get_driver_name = amdgpu_userq_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
> +	.signaled = amdgpu_userq_fence_signaled,
> +	.release = amdgpu_userq_fence_release,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> new file mode 100644
> index 000000000000..230dd54b4cd3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
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
> +#ifndef __AMDGPU_USERQ_FENCE_H__
> +#define __AMDGPU_USERQ_FENCE_H__
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_userq_fence {
> +	struct dma_fence base;
> +	/* userq fence lock */
> +	spinlock_t lock;
> +	struct list_head link;
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +};
> +
> +struct amdgpu_userq_fence_driver {
> +	struct kref refcount;
> +	u64 gpu_addr;
> +	u64 *cpu_addr;
> +	u64 context;
> +	/* fence list lock */
> +	spinlock_t fence_list_lock;
> +	struct list_head fences;
> +	struct amdgpu_device *adev;
> +	char timeline_name[TASK_COMM_LEN];
> +};
> +
> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
> +
> +int amdgpu_userq_fence_slab_init(void);
> +void amdgpu_userq_fence_slab_fini(void);
> +int amdgpu_userq_fence_driver_get(struct amdgpu_device *adev, struct amdgpu_usermode_queue *userq);
> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
> +			      u64 seq, struct dma_fence **f);
> +bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver *fence_drv);
> +void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 2f1aba1e9792..d4317b0f6487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -23,6 +23,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
> +#include "amdgpu_userq_fence.h"
>   
>   #define AMDGPU_USERQ_DOORBELL_INDEX (AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START + 4)
>   
> @@ -264,6 +265,8 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>       struct amdgpu_vm *vm = &fpriv->vm;
>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>       struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
> +    struct amdgpu_userq_fence_driver *fence_drv;
> +    struct amdgpu_device *adev = uq_mgr->adev;
>   
>       pasid = vm->pasid;
>       if (vm->pasid < 0) {
> @@ -280,6 +283,19 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>           return -ENOMEM;
>       }
>   
> +    fence_drv = kzalloc(sizeof(struct amdgpu_userq_fence_driver), GFP_KERNEL);
> +    if (!fence_drv) {
> +	    DRM_ERROR("Failed to allocate memory for fence driver\n");
> +	    return -ENOMEM;
> +    }
> +
> +    queue->fence_drv = fence_drv;
> +    r = amdgpu_userq_fence_driver_get(adev, queue);
> +    if (r) {
> +	    DRM_ERROR("Failed to get fence driver\n");
> +	    goto free_fence_drv;
> +    }
> +
>       queue->vm = vm;
>       queue->pasid = pasid;
>       queue->wptr_gpu_addr = mqd_in->wptr_va;
> @@ -339,6 +355,9 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>   free_qid:
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>   
> +free_fence_drv:
> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
> +
>   free_queue:
>       mutex_unlock(&uq_mgr->userq_mutex);
>       kfree(queue);
> @@ -363,6 +382,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>       list_del(&queue->userq_node);
> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
>       mutex_unlock(&uq_mgr->userq_mutex);
>       kfree(queue);
>   }
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index bda27583b58c..cf7264df8c46 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -73,6 +73,8 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_vm    	*vm;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct list_head 	userq_node;
> +
> +	struct amdgpu_userq_fence_driver *fence_drv;
>   };
>   
>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);

