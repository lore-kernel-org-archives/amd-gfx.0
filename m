Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30374CD8CAA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 11:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3A310E263;
	Tue,  9 Jun 2026 11:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWCQ9IOU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7186A10E263
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 11:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWj1mnlV4xCXNXfJapRWfitmIVQ+aVQ9c+mMX6VBUBuKKcWuawWv3W4lca8Uab1SOxPEW1al9TqG0JIg/G3TZU0pq3aDMStd71nTU7dYnSpEpejbIlAXr2xEt0VePOnNS/pFljxOJCuIg+a9BoIOQDKvFcUZeHOEZeCpcg0Fk/WKToMQJRmqM+MHW2dtkVtmvxsQuG3q/g9OPoJ8ECrE52UyY5ZJo44TSzUqEauipjTxcB+Ku3va3VXJarekK2Gkm3+GvmYqZbAEEgNffzNgjG0IlYFDsS8xDfJhtqt/JB8WsVsG2SbaQK3MR7UGwOjzGyox4p6byjl4+iy7Qmovnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCoLOyDy9GsW3j8YquLzBMRmeZOENUATf4CnXLZcnmE=;
 b=DJqiiM0LxLLRgmhg77zSY4nG1dQ+qM6V8nFzLET7t2wOYpNAezHEsjipK/zntd+L98n9z3xUYw6PwXLpIIahxFBEIusX58Ge4lRWDEVxJxI3Dmd4Dv8TmfLPkDQY3Z3vR388g5lySPkYASUwYmm18M2NAKgOhnnrc4ODv9VrrIydbNjUX27A0T2gMqDha1JEtVBW6u5JUBSIW58ONA7EoX0eUZmQUmY3/apWo73ALLK9+h1M3utuSCq+0SrSZECthCyYyxkOazCO+GLSrJidX1rO/Ny/Y5FF3sPbDCzKcEAkNsDh0I5etSI4cTVY+GwPEgklnzYr7oSKO4ezgSsJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCoLOyDy9GsW3j8YquLzBMRmeZOENUATf4CnXLZcnmE=;
 b=NWCQ9IOUQI7Bt5S4m2BETCGgNbUDQg3nL56YObS5dkwQ7QhycLkpaBuobTAxj6jDLF5g4D74/ftU/Qgx1Ft+JKojdSooEK6peWHV4F0TLv9b+UCcWjURUqr6eKMxerdvWXrOUpsOs3Kbe6LLpbbvgHMLNWb1fYciOGpwiiycXK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 9 Jun 2026
 11:02:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 11:02:20 +0000
Message-ID: <ae826fca-a1eb-4719-822e-8f5609f0b732@amd.com>
Date: Tue, 9 Jun 2026 13:02:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] drm/amdgpu: include amdgpu_uid.h only where
 needed
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-10-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-10-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: b59b3302-dbcf-4c43-b2c2-08dec61693da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: yRlIxt0hO6L4TPpmk9XPJvlK6FZ7kRAg2fwP9otVhBPhN2ql7YI1YPg6ONu+/DYPSQfiVqtP4EbzMIyKEQrJTO7x0i45pD3tHNMdlijkh6pKV/V9og63LJ7vHl0SQVLVJnifrw0E7lLpJn5//epOFQSTXUhYkg5inuxkGSK4dbjHhnO/O7MfW7IzClLk2dD6k6iXFW1wwQVQwbmGNdr15Odl76PDG2KqW1mUYjxcQfnNBLgjs63Fv77O+BwqWUP/bhW16Cx0mqeeBFaUJuACA1+PEMPLYPx2unYkEW8JVZM6KYadzVSQp1cZFUZbEubYN9cuhjkWbGu9uhwpmY8lTF50ikYO9KoIDDo1nMarfTJDQ2wua4TSrGyRErrWBJn8ujeYYmwMCdXwVBAiPDEVdiklYdeoBhQ2pMWPCuf3oycQYuQOxUaUduegAPhjcx6plqnU1c4oZGmyohVH1yLMbDGQ/bxg1ETaTwwU6vTUVhd44fIuMnoNPkecNZKhDVQlz0C9WIMgP4mwvNu/FGLxVKwh4w/CFgG07fdK2OZpn2wrf5OZniOtVau1eAv9xLSCglC17zCam2aUhveWCs3UbKz0/0yZ6cukds6Rk2UU4r1D+rh5eZSf8ymv/0EOohoWrwUD+29JOWTD0B8MRLN8bhSPcKVgJ/0jjaMGXZNqw8p1WBMPLWjv5b5U7g7Fovqu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXV2Q1lYSnhnQll1ZVE4UVFubTVHVmlOTkdyN0Z3M3JpUHlGcHQ3Y1RjM1pt?=
 =?utf-8?B?ODBDZUwrU0RiRFpuejNnTytUTnhWNm50QW12c3JlZCtGSzNSZzZ4dnF3ZVlP?=
 =?utf-8?B?NFA1L1BDVnpHZXJ3YUp5S0c3MTJVbFNOQ1RXRzk5dnlzaUYwVXcvZWtaNCtr?=
 =?utf-8?B?cHdXWDFHOWlxWjdvNEZTRCtWOTZxNEZQU29icW8ySXpWOURBK2NsVFkxa3Vy?=
 =?utf-8?B?cW1DUmkwOXBtcDcwY2hMWDkwclhyN1lZSUdjU0pQMDBuMXhVcnBXVzYxbEtJ?=
 =?utf-8?B?Q01ydEtDaFZkUGNlcGlOVCtHT29zalFSYVppNUlKZGFiS3ovUWhRMDJDWFRL?=
 =?utf-8?B?Z1RYdzVGNzhKcFBlalFVOHdmZHZNbDNPQ0RSTDZidkl2MDYwRlFXQkszZXpB?=
 =?utf-8?B?emVLSHNONWp3L0E0ZUt3UFdvYklLOVB2Q2thSnhjOUluNHVvM1Q0dTQ0MHJK?=
 =?utf-8?B?ZDFsTWRkS1VCd1FYQ2E1aXdYT3laR2JUMG1KZE9QU2RWSnAreUdaQnFnMWdq?=
 =?utf-8?B?THJ0ampqOEtNNzBaYXIwbzRtZmpTVS8yUFFVMWhxZ2VSdzdNcVAwUHQ3RExW?=
 =?utf-8?B?M3JleHBrQUtxc3ZLTUpISDFXTU1INmdVb1VqVWxrNFIvVFFnUkhNaG1oQ3BZ?=
 =?utf-8?B?c3ZJRzNmNEhaNzJCTmo3cENtNlRkMmV0V0NZVnhkc1dUc1dVVzZuWVlyUVNh?=
 =?utf-8?B?R1VzTlZTWGRyZ1Zkb0Voajg4OG5GRFc5YXFDUzEwa2dlZ1drRlZxTmd6Qit4?=
 =?utf-8?B?OGN5RjJiTGw1WlhLbEpGamRhdmMydnc4UUtJYmFydlRNUnl5c0VCeHZrVlNj?=
 =?utf-8?B?MitXTDFkZ2U5UG00TWF4ME1yS1FKR3lxQ3dDQk1sU1duei8wTG5oZ0NwSDR1?=
 =?utf-8?B?REw4UjVFNGVtTUpKaGNyYXQ4MkVLZXZncElDWjdUUFlJNk53cmJ4dk1JL3JU?=
 =?utf-8?B?RUxjaGRCdDdnd29XcGh3elZGOWliTElyaytDVzRQcE1DYTREczlKSDNhZjVt?=
 =?utf-8?B?MVdBYmlCMDlSZmo1d2pkNnlWMjZoeC9VQ2paWTgxNGsrdzFXZXFDYWJpWUVI?=
 =?utf-8?B?R0hINnpsQzQ4NWQzRkZ0NmFYdnBiYXVWcVdhMGxQRC9pYTFpOWdEMElqK1BU?=
 =?utf-8?B?aXpFa3VBVitrZkJBZkY2VjZRTXVjM2Q3akFGc2tGWWg0ejdoN0JNWWNoOW5w?=
 =?utf-8?B?dEhJb09CRm9YektaTDNGRXQ3TysyYW5YMUN4NmRFa2ZDVktQcVZRVkM2bG5S?=
 =?utf-8?B?MnI3SC9aakVablFlVzlzb2V0K2RXTENhc012eTB5VGRoK2VLNnNxZEpOSWhY?=
 =?utf-8?B?NVBEU2NUcTN1dEhweGYrTlhzNjlJdFZmcFFQLzF2QTlyeWZycU9VeXhhVWdF?=
 =?utf-8?B?Y1V4ckE0SVJ6eHB1QkU2dW5pOEtGcmVuWUtFWUxFQ25vTzdKOFBOemtseTky?=
 =?utf-8?B?aWJsVTZEMGliSTNNQS81dUN3bkVhTGs2ZmRmYldJOTJIOERKUGE0Z2RqQTUw?=
 =?utf-8?B?L3h4SWExU09qVTVyZUZTdnBReW4yblJUcEcrSGRsQWp6K0JwQ2VPS0V0dG5W?=
 =?utf-8?B?Vy8vS0J4SUhhTXQzK0ZjOGJYZUdyUkRjcis0Qi8xc2RPUk85WEpLMENUMmxq?=
 =?utf-8?B?WDRITCsyRENycGtvenFITEdTSkRBUEROd3EvYjRHZjliaytjM1ZUdStmL2dS?=
 =?utf-8?B?eGw5N2pKUEU1MUNLdS9CaWZ2UjRqaHA3YWVUQzBtWDRBOFRKTWVQZWQxZWpN?=
 =?utf-8?B?NnVYL1JZZGFRR2JmWWZlVlY3YTlOeUdCVG5EbTJkRytEK3JDNTNSOUlGTHRw?=
 =?utf-8?B?NnpOY2lLZ01hNlFreUppZDExKzRDWkwvczcyTUx0UjdiRFJCVDBhMXZpRDVK?=
 =?utf-8?B?bzJKaFM1allEN1BhTnNWckZDSFJESnQ3c01OMXJRdTFuWDBYdE9DZ1J3U0h4?=
 =?utf-8?B?dkhuZ3B2dk8xeUxJelVzNjVXYUdFREJBbjRjbEVKQ1RhWHlqTlcwS1pqeWFZ?=
 =?utf-8?B?cVdiRHNTZWdIbEZERDQ5WVZBdmp3em5kc0V6SDNjZnYvRkdrSWdTYlI4Mmgx?=
 =?utf-8?B?Mk1uTG03azVCb1ZKZC90ZWN6NjBTWXIwZ0U5Q0YzWVlCNUdLU1BiNVFSNDV2?=
 =?utf-8?B?YUVXYkREZlNNcVdkVU1IYmROTnc1WWZyWUNVd1pJMlJIT0VDNFEvYjRaMWNW?=
 =?utf-8?B?RkkvN3REeXpQWDF2dTUxYzRwZkZsUjVUc1ArTDM2ejBROE9sQSs4emRuSzJE?=
 =?utf-8?B?NG96VnZFQ1BhZU5tVlV4bVJoT1g2ejI0MTJybWsxdnpzamRNd01IOFV5bXBh?=
 =?utf-8?Q?HgksSAbxZ4+QvpUhsq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59b3302-dbcf-4c43-b2c2-08dec61693da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:02:20.7311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91eW0YeufepVccEBnuOR1FaxdMTYTjoOSh5yXXTBnRGI0tRmKLMC4+OqNhvyKcA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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

On 6/8/26 21:47, Shahyan Soltani wrote:
> Remove #include "amdgpu_uid.h" from amdgpu.h and add a foward declaration
> of struct amdgpu_uid.
> 
> Add #include "amdgpu_uid.h" into files amdgpu_device.c, amdgpu_xcp.c,
> smu_v13_0_12_ppt.c, smu_v13_0_6_ppt.c, and smu_v15_0_8_ppt.c.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Looks good to me at first glance, but I'm not so familiar with that stuff so Alex or somebody else needs to take a look.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c            | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c               | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 1 +
>  6 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a29987567a0b..06e61d66dcf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -117,7 +117,6 @@
>  #include "amdgpu_acpi.h"
>  #include "amdgpu_mqd.h"
>  #include "amdgpu_init_level.h"
> -#include "amdgpu_uid.h"
>  #include "amdgpu_video_codecs.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
> @@ -329,6 +328,7 @@ struct amdgpu_hive_info;
>  struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
> +struct amdgpu_uid;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 602e7eb1cc5c..20b67897d7ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -78,6 +78,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> +#include "amdgpu_uid.h"
>  
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 389f69c7d5c3..2c990a1800d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -23,6 +23,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_drv.h"
> +#include "amdgpu_uid.h"
>  
>  #include <drm/drm_drv.h>
>  #include "../amdxcp/amdgpu_xcp_drv.h"
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 7193e3e4946a..edb0a23fb77a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -35,6 +35,7 @@
>  #include <linux/pci.h>
>  #include "smu_cmn.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_uid.h"
>  
>  #undef MP1_Public
>  #undef smnMP1_FIRMWARE_FLAGS
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ce520f43ab94..799ef8dbe66c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -50,6 +50,7 @@
>  #include "mp/mp_13_0_6_offset.h"
>  #include "mp/mp_13_0_6_sh_mask.h"
>  #include "umc_v12_0.h"
> +#include "amdgpu_uid.h"
>  
>  #undef MP1_Public
>  #undef smnMP1_FIRMWARE_FLAGS
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index 2105a1d7bb34..c241fe5f2e09 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -36,6 +36,7 @@
>  #include "mp/mp_15_0_8_sh_mask.h"
>  #include "smu_v15_0.h"
>  #include "amdgpu_fru_eeprom.h"
> +#include "amdgpu_uid.h"
>  
>  #undef MP1_Public
>  

