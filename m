Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B643C44512
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 06:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CD310E2E2;
	Thu, 16 Jul 2026 06:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kg6/1bXE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45B810E2E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 06:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPm1rGp0D4UnK1mbwOSopdNpu5H5w/uGJQaYLUegiCOylvjGjP/bl/Ndv1SMeRWPoiauc07XXycWf7QsmbwlFGN/iEBDmcFMdfhRRmjFxb1ZvZPXXi6JBuQaDLqB5uS2lnZTT8zeLevXsH/M/Mo2S960jNRXSt+SCnQxSr9taOVD3uiOpZDZfsUMWQY0BBsHRvZKXvBc39H8Lv9FyTDZZLQC0OFgHSFsF5L9zfRuef1MW1kA27heeZIhIiPa0rTRBzpCUa3NUVAAMu+ucs6abn6+88UMOXk7gnIRX4hax49WPOGVO1uBoVTCsxwpusa7EiOEd55R+BqygG7MNLSl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLmp86BNqLNMZsj0JtCm0s79qRq0EQSwz9wdrssDsy0=;
 b=alHlCG3WqsPXBXJOeU1Ozb17NCn+WiSTk28m8Mq5KJwFtt+gPZmhbz8gcnI9Dqfjsv4b5966xG0K603+qq+FRQOW9xnPuinONK/bPyI3+mA4YUuorI0t6JICNUkuPQoGyyzqpq2yLDkZi1VSiYy3TyQ7na6bTbJ1aeHpTI87Pl69qE9c8NFhr4JK3RXF/J1vymGqAvSJjyagr3Q+pKgVp8QaBHtRZPmMqXczXQBbzp7Pb+6Gr/KFwopF+gWMJtEvKsLOa6865RGVTxasVAdOQ7avnnr9AUtU6Bz0ZEUC+bfvuNRt+dvvaBQsdasiXnQ5HmfOJaYSc4XF5p/ktqTKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLmp86BNqLNMZsj0JtCm0s79qRq0EQSwz9wdrssDsy0=;
 b=Kg6/1bXEfgQBLYosSoEcKT5ZTx+2VVhLLT6PSbXtShHC/Rok0u9DrZvpp9D/dItvkzOU3wxzrY6aeADZN3rY6Tjn1shBlS1KivH6aJNf6ZVgiG14dIXTGcWIExQudpsO69oXgIdEZ7CqBpQgdjakL/XPN2Kn23fBLjxC34Nzeng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 06:43:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:43:19 +0000
Message-ID: <8fc6f308-ced0-4398-be16-db8133188dd1@amd.com>
Date: Thu, 16 Jul 2026 08:43:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/5] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
 <20260715142542.3475265-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260715142542.3475265-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:52c::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee65fe7-35fa-4a44-3516-08dee30585f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|22082099003|56012099006|5023799004|11063799006|6133799003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: o01GpYlKKbL1WMYcw5D0IBTFmWtWMno4tuKEFRwZA6OWlnNlxt3QAqdP5yYtBRxaVExx/ZFwN6uFZb604SDqR/ZafDcL6Y+N9SvgK+0/UpVMjwZUojGDRG/ZqRmjqHYj4CL5ms/TcnEEhSFrrUvHdkjU0NDA4S3lhIhqdAEgBOUa2gDrk4sLs3tTgSP+Iu2tX5yphkJX6mk3jg5uGgbbLy2i/2WkJfpohx+IOZ4KNfX4yw7Pl9cV91P+eSi69m2jiZVDPpqZyGMaHmwGeKMsPUnafBQ/6enli1L5pXNAZdfQWgDUZbImiriqZ8MPcbbSNUW7T6OiJY2XY8TZ3mkYv6a09tX3SPYTjS/nGiF79XsdxqOWPDcmnpUXdDyvqF2hnrJZx4bFedfSvgXWikGM6nCj6vBedxutIse/pcsABlDqPv741+BxwODQoGFt5tWgb73Tv9ng/7HY/3j5tHRcghXLke5mnVHZgaSVnCEgvlKEmPdYDgVm+bzBEyjtRRPr30TGa4UdeKugCv3NFmmM464e7Nxn01rViGUwMeb2/hR0jc0te2Yvf995JWPbKZmGaAFty/IH81PtShxJ/lTV+aLVWyBeP4yrS7UMlgwp//x/J8K5VnyddKvnutlsFqgMcI1ddm45ozEWiSQABZedtQVf3s2/T3nZR1oL3o3+taE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNyUnNHMyt2Nm83S2dFampwVEU3U1doUEZOODVMUUhSdnNpMTI2ZHNTNkpU?=
 =?utf-8?B?cWxOdU1vd3dBMTU0Q3llRGhmRTJESk0vWUJSOTlIZ2VhYnJ6eEE5WUMrMUp2?=
 =?utf-8?B?elB1SDNudUJWVUxzQWZENEZXTXRLN0NLOVhGUXVDdHNnS2Q0MmJiclppZFlN?=
 =?utf-8?B?dHoyR3pxMEdHYmpvR1I2TlQ4bm5VcjVjdndZeFNYUHZENnlKd1BzRWNVNCtJ?=
 =?utf-8?B?cUxabTZZcERyS2E2b01CWTB3ZEpCblpCdDNIUXY2S08xOStERExXOTh0Y0E2?=
 =?utf-8?B?T1g3cXV0cDZYUWdyZ0ZTZStlNi9VNzdyaXRHdFFXTmhnTWdEelBSSTAwOXBi?=
 =?utf-8?B?SUhhMlRoZzVGWjRuYS9vdUF6VkNNd3M2VVlFY091MlpTQnJxZDA3MXdDbFp6?=
 =?utf-8?B?alhhWGpLbG53RExPNDJyeUZBYXhFNklpbGt1OHFPWVAyeERaUXpabEhvSE9Y?=
 =?utf-8?B?aUJxTGE1ejlYMXg2Szhja3B5WjRZdXdzenZLa3hHYjQ3YUxPeG4xcWVhYlh2?=
 =?utf-8?B?dVRqRUkxN1QwRFkyRFBNNlJSR0tzb0dXbzl2N2YrZHllV1VyMnh2STUwYktk?=
 =?utf-8?B?a3VrSFd1Uk9KR09lQkwzUkFqZTRmMFN6OXJUemdVY0RmdndGZWo5OTh1cnFm?=
 =?utf-8?B?ZCtRQlFNT1llbENPM1pkN2gyMDVPVFV1ajhhWGN4V1Z3cVp3YmY3RUNsa3kr?=
 =?utf-8?B?TDVSWkRXMEtKQXo3SXlkazRza0daMGM1eXV2blU2ajY1bThsQ2RvT08yclB2?=
 =?utf-8?B?c0R6SEVnbnBJOGZoNXhITWN4L1UyL1RDd1RGNEdtazNyRTJ3SXVadHoyZHE3?=
 =?utf-8?B?d3F5SHZkMHVrYkxHYTdYWUNaUitTaDkzVm9zSERGcjBZWWN5TlVLYkdvVEI4?=
 =?utf-8?B?RUxIL3VmOHJ2VGJJM2V0YW4rYVJNYkJmV2NkdzlnWXQ1RklQV1Vjd2xVL2pF?=
 =?utf-8?B?OXY4QngrSCtZQXpoZGNtOU05eVNDOUpUTkIwZVVVUC9zOWNOZklPaWhOZ3Rm?=
 =?utf-8?B?ZTdMNjlUeHQzK0dVRkludFM1UXh5TDE2eGNYcmZCclJjQ0NkSmw3MUtsOU4r?=
 =?utf-8?B?OEtHMjBha2hoR2tIdWxlOXFyNmdLWFdxUDBSNG9XRTEvRk80Mmg3RWpwK2NC?=
 =?utf-8?B?NHg2ckhib1pyQ3Y0N1UrVU1RMTQ5Sk9ocmJYaVMxcUx4Q3ZCYWZTSDQxS3Ax?=
 =?utf-8?B?T0RUeFQ5WGRUQjlRaGQ5QUFDUzl4b3hoYlcxaCtJdVlzTG4vZnNHSWw0a25x?=
 =?utf-8?B?OGgweWxrVjl6c0ZSeEI2WG9YVDBONzFuWUZDKzczaEtWdUJ4RXN5Z0tmeEM0?=
 =?utf-8?B?TVlqcnFUOEVwV3pyTmt3MXJxRWJnTzkxS1RtNkZIMXhHZWhjLzNyRU1SdzBT?=
 =?utf-8?B?ZXVFZ3BDMzFKZHdTQkNzQ216WEtZTTVoRklOSitDN1lHZjhaK2RUa0NjRnNN?=
 =?utf-8?B?ek9maDd3RTZaVHRpd3ZjcVZpN1BvRFBaelBRbmtVOXRIajFvNktPR3J6aUVM?=
 =?utf-8?B?R1hJWWNZd3R5amhEcjJ6UVZIblRXN1MrSXpVWmk2RTllUFQ2N0FNZmNGUkZM?=
 =?utf-8?B?QWFId01xaEo3eVZqNGxBRldzZ1I2Y0tqOG51UXRYRFdaeElONlgxWkM2VTRG?=
 =?utf-8?B?U3pPbzEvRHFtOXZUSW96WHFhN3lHSWZ5c0NBTUJWb3Q4YnFjeWN0dHBXQmx2?=
 =?utf-8?B?b2lKYW1lNmlTNi90YkFrNnBQd3lGWTYza1V4MWVLeHRTTTRRby9XNXpQYTB2?=
 =?utf-8?B?Ykh1aTRqNlZwL1R5dWx6YVVHZERwS3R4NnhtcjhhQk0zWFZBRDJFVXE4SnZq?=
 =?utf-8?B?WUxyRkZNenV3ZEJZM2JiV2VMYWt6Ny8wd1RoZERZaXhjVXNUYkdLdlY5emZH?=
 =?utf-8?B?Wkx4RkVhRy9MeUM1c0NxNXZBdis0UmpKMzdmVndPMnNoaDEvRGVMYkxSMTJQ?=
 =?utf-8?B?eDlkU3JsV0JqV1VoQUlrT3EzTVc4UHQvQXFDa01ZdUp1WXE3clpGSXBTTUFH?=
 =?utf-8?B?aVZwQXRhamlvdS9VdEEvcFV1by90bENzU3FQU25kSndSWVdyaTNjZW5sUHhS?=
 =?utf-8?B?Yy9GaHB2bHNCNVpib3FDdnh5Y0NjVGRLWjZMWkpveDZmbHZpVnBUM1k2OEs4?=
 =?utf-8?B?N1B4MFM5U2F2QjIzMHR3dlhjSEcxaHBEa3FMUEpTMTNVdEMveC9FQkhsWUNn?=
 =?utf-8?B?NGo1MXVNdE9aeU9mMC81eWRIcFZkYUswT2lqUWV2TVJXbjRaNVpzOHJVTHhw?=
 =?utf-8?B?N1ArRUdEQVFOamZDMWFJZEZPUGNlWEhWNHI4MzZibFJ4TnZpN25ZaTRpZWtZ?=
 =?utf-8?Q?ycGL+5evb0qUGYSkPi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee65fe7-35fa-4a44-3516-08dee30585f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:43:19.6824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSMOklb0ojuIjwNS7r1susgNaL2FqKgb+cQwQnJt1/9Qe+ZcLjz0OOAdVF6xzfyy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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

On 7/15/26 16:25, Srinivasan Shanmugam wrote:
> Add the per-file WAIT_EVENT manager and lifetime plumbing used to store
> and retrieve event records for render-node clients.
> 
> The manager maintains a list of pending WAIT_EVENT records, supports
> blocking waits from userspace, copies the first matching event record to
> userspace, and enforces single-consumer semantics by removing records
> once they are consumed.
> 
> Register the WAIT_EVENT ioctl so render-node clients can access the
> per-file WAIT_EVENT manager.
> 
> For queue-scoped events, queue_id is resolved to the corresponding
> usermode queue object at the ioctl boundary. Pending records are matched
> internally using queue pointer equality, while queue_id remains a
> userspace identifier used only at the UAPI boundary and returned in
> event metadata.
> 
> WAIT_EVENT now uses an absolute CLOCK_MONOTONIC deadline for timeout
> handling. The remaining timeout is recomputed after each wakeup so that
> interrupted or spurious wakeups continue to honor the original userspace
> deadline.
> 
> Pending WAIT_EVENT records hold queue references while queued. Those
> references are released when records are consumed, explicitly removed,
> or destroyed during manager teardown.
> 
> Embed the WAIT_EVENT manager in amdgpu_fpriv and tie its lifetime to
> drm_file. During teardown, the manager is marked dead before pending
> records are detached and blocked waiters are awakened, preventing new
> records from being queued while shutdown is in progress.
> 
> The USERQ manager is torn down before the embedded WAIT_EVENT manager is
> finalized, so queues are removed from the producer lookup paths before
> the manager can go out of scope. This existing teardown ordering
> provides the lifetime guarantee for WAIT_EVENT producers without
> requiring an additional manager reference.
> 
> Changes since v9:
> - Switch WAIT_EVENT timeout handling to an absolute CLOCK_MONOTONIC
>   deadline, as suggested by Christian.
> - Recompute the remaining timeout after each wakeup.
> - Simplify queue reference cleanup using unconditional
>   amdgpu_userq_put().
> - Clarify that queue pointers are used internally for event matching,
>   while queue_id remains a userspace-only identifier.
> - Improve kerneldoc describing manager state, event matching, and
>   teardown ordering.
> - Document the existing teardown ordering that guarantees the embedded
>   WAIT_EVENT manager remains valid while USERQ producers are active.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 427 ++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    | 101 +++++
>  6 files changed, 538 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index b7897f98436c..c4cee6a6bc64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o
> +	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o amdgpu_wait_event.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4f42888e2647..91f1dc737aee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -104,6 +104,7 @@
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_mca.h"
>  #include "amdgpu_eventfd.h"
> +#include "amdgpu_wait_event.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_lockdep.h"
>  #include "amdgpu_cper.h"
> @@ -427,13 +428,15 @@ struct amdgpu_fpriv {
>  	uint32_t		xcp_id;
>  
>  	struct amdgpu_eventfd_mgr	eventfd_mgr;
> +	struct amdgpu_wait_event_mgr	wait_event_mgr;
>  };
>  
>  struct drm_device;
>  struct drm_file;
>  
>  int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
> -
> +int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv);
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e90cf67c1cd8..b738a1bdf9d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3097,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index ccc9c3f8aba7..72bea83d7408 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1681,6 +1681,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	}
>  
>  	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
> +	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
>  
>  	pasid = amdgpu_pasid_alloc(16);
>  	if (pasid < 0) {
> @@ -1754,6 +1755,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (pasid)
>  		amdgpu_pasid_free(pasid);
>  
> +	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
>  	kfree(fpriv);
>  
>  out_suspend:
> @@ -1784,8 +1786,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (!fpriv)
>  		return;
>  
> -	/* Drop all subscriptions before fpriv goes away. */
> +	/* Drop eventfd subscriptions and pending wait-event records. */
>  	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
> +	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
>  
>  	pm_runtime_get_sync(dev->dev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
> new file mode 100644
> index 000000000000..db612106fb12
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: MIT
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
> +#include <linux/jiffies.h>
> +#include <linux/sched/signal.h>
> +#include <linux/slab.h>
> +#include <linux/timekeeping.h>
> +#include <linux/uaccess.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_userq_internal.h"
> +#include "amdgpu_wait_event.h"
> +
> +/**
> + * amdgpu_wait_event_deadline_to_jiffies - calculate remaining wait time
> + * @deadline_ns: absolute CLOCK_MONOTONIC deadline in nanoseconds
> + *
> + * Convert an absolute CLOCK_MONOTONIC deadline into the remaining number
> + * of jiffies. A negative deadline requests an indefinite wait.
> + *
> + * The caller recalculates the remaining time after every wakeup so that
> + * spurious wakeups do not extend the userspace deadline.
> + *
> + * Return:
> + * Remaining wait time in jiffies, zero if the deadline has expired, or
> + * MAX_SCHEDULE_TIMEOUT for an indefinite wait.
> + */
> +static long
> +amdgpu_wait_event_deadline_to_jiffies(__s64 deadline_ns)
> +{
> +	u64 remaining_ns;
> +	u64 now_ns;
> +	u64 timeout;
> +
> +	if (deadline_ns < 0)
> +		return MAX_SCHEDULE_TIMEOUT;

Usually absolute timeouts are unsigned values.

> +
> +	now_ns = ktime_get_ns();
> +	if ((u64)deadline_ns <= now_ns)
> +		return 0;
> +
> +	remaining_ns = (u64)deadline_ns - now_ns;
> +	timeout = nsecs_to_jiffies(remaining_ns);
> +
> +	/*
> +	 * Reserve MAX_SCHEDULE_TIMEOUT for the explicit indefinite-wait
> +	 * case above.
> +	 */
> +	if (timeout >= MAX_SCHEDULE_TIMEOUT)
> +		return MAX_SCHEDULE_TIMEOUT - 1;

I think that can be dropped.

> +
> +	/*
> +	 * A future deadline shorter than one jiffy must still wait for at
> +	 * least one scheduler tick.
> +	 */

A timeout of 0 should usually mean check event and return. Is there any reson for this?

Regards,
Christian.

> +	return timeout ?: 1;
> +}
> +
> +/**
> + * amdgpu_wait_event_valid_type - validate a WAIT_EVENT event type
> + * @event_type: kernel-defined AMDGPU event type
> + *
> + * Return:
> + * True when @event_type is supported by the WAIT_EVENT UAPI.
> + */
> +static bool amdgpu_wait_event_valid_type(u32 event_type)
> +{
> +	switch (event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +	case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * amdgpu_wait_event_record_free - release a pending event record
> + * @rec: record to release
> + *
> + * Drop the queue reference owned by the record and free the record.
> + */
> +static void
> +amdgpu_wait_event_record_free(struct amdgpu_wait_event_record *rec)
> +{
> +	if (!rec)
> +		return;
> +
> +	amdgpu_userq_put(rec->queue);
> +	kfree(rec);
> +}
> +
> +/**
> + * amdgpu_wait_event_match - test whether a record matches a wait request
> + * @args: WAIT_EVENT request
> + * @queue: resolved queue for a queue-scoped request, or NULL
> + * @rec: pending event record
> + *
> + * Queue-scoped records are matched using queue pointer equality.
> + * queue_id is used only at the UAPI boundary and as returned metadata.
> + *
> + * Return:
> + * True when @rec matches the requested event type and queue scope.
> + */
> +static bool
> +amdgpu_wait_event_match(const struct drm_amdgpu_wait_event *args,
> +			struct amdgpu_usermode_queue *queue,
> +			const struct amdgpu_wait_event_record *rec)
> +{
> +	if (rec->data.event_type != args->event_type)
> +		return false;
> +
> +	/*
> +	 * Queue pointers are the internal matching key. queue_id is used
> +	 * only at the UAPI boundary and as returned event metadata.
> +	 */
> +	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type))
> +		return rec->queue == queue;
> +
> +	return !queue;
> +}
> +
> +/**
> + * amdgpu_wait_event_has_match - check for a matching pending record
> + * @mgr: per-file WAIT_EVENT manager
> + * @args: WAIT_EVENT request
> + * @queue: resolved queue for a queue-scoped request, or NULL
> + *
> + * This helper is used as the waitqueue condition. It does not remove the
> + * matching record.
> + *
> + * Return:
> + * True when a matching record is pending.
> + */
> +static bool
> +amdgpu_wait_event_has_match(struct amdgpu_wait_event_mgr *mgr,
> +			    const struct drm_amdgpu_wait_event *args,
> +			    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_wait_event_record *rec;
> +	unsigned long flags;
> +	bool found = false;
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	list_for_each_entry(rec, &mgr->pending, node) {
> +		if (amdgpu_wait_event_match(args, queue, rec)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	return found;
> +}
> +
> +/**
> + * amdgpu_wait_event_pop_match - remove the first matching record
> + * @mgr: per-file WAIT_EVENT manager
> + * @args: WAIT_EVENT request
> + * @queue: resolved queue for a queue-scoped request, or NULL
> + *
> + * Remove and return the first pending record matching the requested event.
> + * Removal provides single-consumer delivery.
> + *
> + * Return:
> + * Matching record, or NULL when no matching record is pending.
> + */
> +static struct amdgpu_wait_event_record *
> +amdgpu_wait_event_pop_match(struct amdgpu_wait_event_mgr *mgr,
> +			    const struct drm_amdgpu_wait_event *args,
> +			    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_wait_event_record *rec, *tmp, *found = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
> +		if (!amdgpu_wait_event_match(args, queue, rec))
> +			continue;
> +
> +		list_del(&rec->node);
> +		found = rec;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	return found;
> +}
> +
> +/**
> + * amdgpu_wait_event_get_queue - resolve the requested queue scope
> + * @fpriv: AMDGPU per-file private data
> + * @args: WAIT_EVENT request
> + * @queue: returned queue reference
> + *
> + * Validate the requested event type and resolve queue_id for queue-scoped
> + * events. Device-scoped events require queue_id to be zero.
> + *
> + * The caller owns the returned queue reference and must release it with
> + * amdgpu_userq_put().
> + *
> + * Return:
> + * Zero on success or a negative error code.
> + */
> +static int
> +amdgpu_wait_event_get_queue(struct amdgpu_fpriv *fpriv,
> +			    const struct drm_amdgpu_wait_event *args,
> +			    struct amdgpu_usermode_queue **queue)
> +{
> +	*queue = NULL;
> +
> +	if (!amdgpu_wait_event_valid_type(args->event_type))
> +		return -EINVAL;
> +
> +	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type)) {
> +		if (!args->queue_id)
> +			return -EINVAL;
> +
> +		*queue = amdgpu_userq_get(&fpriv->userq_mgr, args->queue_id);
> +		if (!*queue)
> +			return -ENOENT;
> +
> +		return 0;
> +	}
> +
> +	if (args->queue_id)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_wait_event_mgr_init - initialize a per-file WAIT_EVENT manager
> + * @mgr: manager to initialize
> + *
> + * Initialize the pending-record list, waitqueue, sequence counter and
> + * shutdown state.
> + */
> +void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
> +{
> +	spin_lock_init(&mgr->lock);
> +	init_waitqueue_head(&mgr->wq);
> +	INIT_LIST_HEAD(&mgr->pending);
> +	atomic64_set(&mgr->seqno, 0);
> +	mgr->dead = false;
> +}
> +
> +/**
> + * amdgpu_wait_event_mgr_fini - finalize a per-file WAIT_EVENT manager
> + * @mgr: manager to finalize
> + *
> + * Stop new records from being published, detach all pending records,
> + * release their queue references and wake blocked waiters.
> + *
> + * The manager is embedded in amdgpu_fpriv. The USERQ manager is torn down
> + * before drm_file postclose invokes this function. Queue teardown removes
> + * queues from producer lookup paths and drains queue work, ensuring that
> + * USERQ producers have stopped before @mgr goes out of scope.
> + */
> +void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr)
> +{
> +	struct amdgpu_wait_event_record *rec, *tmp;
> +	unsigned long flags;
> +	LIST_HEAD(removed);
> +
> +	/*
> +	 * Prevent new records from being published before detaching pending
> +	 * records and waking blocked waiters.
> +	 */
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	mgr->dead = true;
> +	list_splice_init(&mgr->pending, &removed);
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	list_for_each_entry_safe(rec, tmp, &removed, node) {
> +		list_del(&rec->node);
> +		amdgpu_wait_event_record_free(rec);
> +	}
> +
> +	wake_up_interruptible_all(&mgr->wq);
> +}
> +
> +/**
> + * amdgpu_wait_event_remove_queue - remove pending records for a queue
> + * @mgr: per-file WAIT_EVENT manager
> + * @queue: queue being removed
> + *
> + * Detach all pending records associated with @queue while holding the
> + * manager lock. Queue references are released after the lock is dropped.
> + */
> +void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
> +				    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_wait_event_record *rec, *tmp;
> +	unsigned long flags;
> +	LIST_HEAD(removed);
> +
> +	if (!mgr || !queue)
> +		return;
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
> +		if (rec->queue != queue)
> +			continue;
> +
> +		list_move_tail(&rec->node, &removed);
> +	}
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	list_for_each_entry_safe(rec, tmp, &removed, node) {
> +		list_del(&rec->node);
> +		amdgpu_wait_event_record_free(rec);
> +	}
> +
> +	wake_up_interruptible_all(&mgr->wq);
> +}
> +
> +/**
> + * amdgpu_wait_event_drm_ioctl - wait for an AMDGPU render-node event
> + * @dev: DRM device
> + * @data: struct drm_amdgpu_wait_event request
> + * @file_priv: DRM file issuing the request
> + *
> + * Resolve the request scope, consume the first matching pending record and
> + * copy its metadata to userspace.
> + *
> + * deadline_ns is an absolute CLOCK_MONOTONIC deadline. The remaining wait
> + * interval is recomputed from the original deadline after every wakeup so
> + * that spurious wakeups cannot extend the requested deadline.
> + *
> + * Return:
> + * Zero on success or a negative error code.
> + */
> +int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv)
> +{
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_amdgpu_wait_event *args = data;
> +	struct amdgpu_usermode_queue *queue = NULL;
> +	struct amdgpu_wait_event_mgr *mgr;
> +	struct amdgpu_wait_event_record *rec;
> +	long remaining;
> +	int ret;
> +
> +	if (!fpriv)
> +		return -EINVAL;
> +
> +	if (args->flags || !args->event_type || !args->out_ptr)
> +		return -EINVAL;
> +
> +	if (args->out_size < sizeof(struct drm_amdgpu_wait_event_data))
> +		return -EINVAL;
> +
> +	ret = amdgpu_wait_event_get_queue(fpriv, args, &queue);
> +	if (ret)
> +		return ret;
> +
> +	mgr = &fpriv->wait_event_mgr;
> +
> +	for (;;) {
> +		rec = amdgpu_wait_event_pop_match(mgr, args, queue);
> +		if (rec)
> +			break;
> +
> +		if (READ_ONCE(mgr->dead)) {
> +			ret = -EIO;
> +			goto out_put_queue;
> +		}
> +
> +		if (signal_pending(current)) {
> +			ret = -ERESTARTSYS;
> +			goto out_put_queue;
> +		}
> +
> +		remaining = amdgpu_wait_event_deadline_to_jiffies(args->deadline_ns);
> +		if (!remaining) {
> +			ret = -ETIME;
> +			goto out_put_queue;
> +		}
> +
> +		remaining = wait_event_interruptible_timeout(mgr->wq,
> +							     READ_ONCE(mgr->dead) ||
> +							     amdgpu_wait_event_has_match(mgr, args, queue),
> +							     remaining);
> +		if (remaining < 0) {
> +			ret = remaining;
> +			goto out_put_queue;
> +		}
> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
> +			 sizeof(rec->data)))
> +		ret = -EFAULT;
> +	else
> +		ret = 0;
> +
> +	amdgpu_wait_event_record_free(rec);
> +
> +out_put_queue:
> +	amdgpu_userq_put(queue);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> new file mode 100644
> index 000000000000..9da68eb6c9b0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: MIT */
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
> +#ifndef __AMDGPU_WAIT_EVENT_H__
> +#define __AMDGPU_WAIT_EVENT_H__
> +
> +#include <linux/atomic.h>
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait.h>
> +
> +#include <drm/drm_device.h>
> +#include <drm/drm_file.h>
> +
> +#include <uapi/drm/amdgpu_drm.h>
> +
> +struct amdgpu_usermode_queue;
> +
> +/**
> + * struct amdgpu_wait_event_record - pending WAIT_EVENT record
> + * @node: link in the manager's pending-record list
> + * @queue: referenced queue for queue-scoped events, or NULL
> + * @data: event metadata returned to userspace
> + */
> +struct amdgpu_wait_event_record {
> +	struct list_head node;
> +	struct amdgpu_usermode_queue *queue;
> +	struct drm_amdgpu_wait_event_data data;
> +};
> +
> +/**
> + * struct amdgpu_wait_event_mgr - per-file WAIT_EVENT manager
> + * @lock: protects @pending and @dead
> + * @wq: waitqueue used by blocked WAIT_EVENT ioctls
> + * @pending: pending event records
> + * @seqno: per-file monotonically increasing event sequence number
> + * @dead: prevents new records from being queued during teardown
> + */
> +struct amdgpu_wait_event_mgr {
> +	/* Protects @pending and @dead. */
> +	spinlock_t lock;
> +	wait_queue_head_t wq;
> +	struct list_head pending;
> +	atomic64_t seqno;
> +	bool dead;
> +};
> +
> +void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
> +void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
> +
> +void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
> +				    struct amdgpu_usermode_queue *queue);
> +
> +void amdgpu_wait_event_add(struct amdgpu_wait_event_mgr *mgr,
> +			   u32 event_type,
> +			   struct amdgpu_usermode_queue *queue);
> +
> +int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv);
> +
> +/**
> + * amdgpu_wait_event_type_is_queue_scoped - test event queue scope
> + * @event_type: kernel-defined AMDGPU event type
> + *
> + * Return:
> + * True when @event_type requires a USERQ queue handle.
> + */
> +static inline bool amdgpu_wait_event_type_is_queue_scoped(u32 event_type)
> +{
> +	switch (event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +#endif /* __AMDGPU_WAIT_EVENT_H__ */

