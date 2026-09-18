Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB53AC88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 05:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309FB10E807;
	Fri, 18 Sep 2026 05:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4neBH1P";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A4A10E807
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 05:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCPEGFXVVToRnt5y4dzYsTqBOK69y/6g/yMPFOre3MzfJPyGUaHwAHdWfe3RkjpsBHYtD6sk+rOBWpZH6wDu/uYcGOtvdjcfLaoQyyOEpN96GbbBo8oNq4WCYj43vCXgaJ/2xcX3/5KYoBjyNyNSFNHRtxZoa8XTCEG9WvgenqQkjTiFsIZ9zJ2ktSQ3tdo50faQl+Hbo8RWxskyippl/FQ2G2xJDT3QGd4dnY0Grkyu3roPCSuBj1fMqojo1UQuobvQI9+jL1+2yxfyEpWTFfIQIJnB5wG4h+EeWeDeVo6l9D/w/S418NTCpMx3wG5ughsiqOGDyW6F4kDHOYdzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SUD004r/uftgQhuBf3iVWVxgjDqeMRJhcEWPG9lloE=;
 b=Sgo6ePuMPnWXdo9pz2v6oVDFDlrGKWDnw4r+/qL5dUl6BJP5cVUISmpyqJIxqKuKR4ChvwKW9d+0185Nshq4hpZ2xPon/QEd2jBXpyJcyCgeFEcFh9eNOxGDNt715AcG2zOI/CvRf9mjyItNlHO5MRbQIqOaQE52FsRDm4ca2naTSwcbF8TI6FMf3NxZfYWKYb68JFcmgoZtxOg+jZejBIzb0rxz+wcadyYIeFYv2Kmsszqw794CqDBo3DwVz1p3biW/VNP7qQ5LAXUI8CRCyFYs6FzJKXGIU9n1sncFkwOneq0jglM+CtD8JMUpHTJg4H0wmV97EVeisQ9YK4DHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SUD004r/uftgQhuBf3iVWVxgjDqeMRJhcEWPG9lloE=;
 b=C4neBH1PiB37qQpvpZqxLd4cJ+zsR9Wjk/hkO187aXqT1QO6OBjFT1yRbEIzUOkF+wBibtJKOxdWGB4mVyPU7UTzsr/ghavHRRuyvUd0txdWhd/IdtNZw/aTWYWzcBs1QA16ci0a3GqshoQBISyZWECp+3q/IU9qN/dEd4PCU6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 18 Sep
 2026 05:00:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 05:00:55 +0000
Message-ID: <04f954fd-bf4a-4677-ab0f-69b7a3edafc4@amd.com>
Date: Fri, 18 Sep 2026 10:30:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260916053722.601067-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d13ee80-cc19-4f92-b491-08df1541d1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|18002099003|56012099006|11063799006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: eHgea3uBEEfmENQg3PtFel5ywpstKFJCVS60pNxrwr//OQTew/keXApUfMHVsMHuL4P1miU5DpsZMX2Kx/wf2xRXJtIpuCF/Voky5zhLDW+E25SXSSn8FMVE1Kwo41A0TNwkhafz1UpCdwhPf6kMsuetB9ukZNlxWF4LEMAoI7BORumLkG9ppYRc/Xmrm2HSVgFTUCxaH+1WyZKzKXcIMZWG9XX526a/nV9BAaeSRVlmVnI2zx00RyxU07QgaAf79Tm/pL+QJbtgkwPQVsA0DAQ7QzdntwcNbCnFhyVkQGtSYzPfqNp07ZLtbAUYI0jkbB131ToC2imKJbj6fQMcMKPyFA+DPcj/1BttNomwSVzcrhkV7n2Zs2crw82PkAD40vO3JXT3AmDekROI0502WsUmQtYmgJ1UbTUzD0zKJIQtyDVM0qCBuTWwFtqZJHQ2A62jHXeOIqUnQrawAYKWCCr0Vl+iKmxvI6yhzgbkRIIXXDvY4VjsSx3OF8rPJ+7160tHgRKaw3Kf0vLbaOEytJJjtTlOZ0VMSyssVLUNybk+qwftB0sa8Et5mVO3X9/3BcagrD0Xjd+NaPXhLbAqbcjDGV1Uf7qSzrevICeo3a6u2U0gyBusevXV8NscPMYFEWW6x2o52OqnXN2a8tyz051KaCZR2/oF4riwQmV/97s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhpYVpVbTVjRTFiQ1JuWW5Ga2NaSEw0eVRicjNGcGVoVkRteGFMb0VTOFRQ?=
 =?utf-8?B?YjMrL0Yrd0tKVTBvMXk2UUdVdUR6UUtNMkUya3NFM1dzeHdQQjVpU2VBbURr?=
 =?utf-8?B?RXhwdXNRWUNGTEZpeXkxY0ZVbUlRWHRvYWZOZ0didlJSYXRoNjZyKzJuMlNz?=
 =?utf-8?B?OGVlMFhOTEdHeXAxdmRjaWRjd1VHdWpoR2ZhWkd4Ymg4Z1VsUHROYXlteGlB?=
 =?utf-8?B?ZDdFYW4vT2srMXVYNmFkNXJvM1lxeTdPTmdFbVpXRXk5SnZDMzRHeWVlVFQ2?=
 =?utf-8?B?UCtkMUFOU3I0M2RFRndhTVlkaEEzWVZaK0xRK1A4VTdJc1B1WkExbnA2RCs5?=
 =?utf-8?B?OSt3WjRTYzRCRVdQdEpvQWJpRG81WVdsc0NUQUhpN0J6bzE3bzBHdG9jR3kw?=
 =?utf-8?B?MGIzSlA1TmF2NUtNbU9BZnhyeEZIK2pTaXF1dmVhaGpVUWVZbVNHWGhzcy9u?=
 =?utf-8?B?RGFsSFQ1SytRV0lQaVZ6SUpJT1NFcDE3QVRJTjk0RW1YeWFaNnFoSjZWeTI3?=
 =?utf-8?B?QWhnZ1FyUlMwQzNEdXJOV2hCeHhZY2ZwOTJWOWpNK3d1am44b2JmTVJHNy9n?=
 =?utf-8?B?bndoNXk1RU9rRWdYWVBVdGtsMXU2cDFiUWZ2SWx4NUtBUk1QbFRicG9pRlVn?=
 =?utf-8?B?NGQ4SnA4UjNYMUpuM2k1cENNQ3QxWXpUbzAxckRLbWZLWk9jQTYvOW5BZzZk?=
 =?utf-8?B?QThHMUgxT1FVRkg1R3pOcVRsQ1psOTRkL2VUWEFFbW5FZWJNMTZ2TkJKV1Ju?=
 =?utf-8?B?MklBdWNkL0hudnNxTVpiTVZQYzVnVmN4QS9MZEk5NjF5dHdhZ1RoaXZtMnNo?=
 =?utf-8?B?UnM4TlZOd1RpMUVBQlJxd3F5VEFJVnBpYlg4Qk1OaUZkR2pZUTI2QktyemFw?=
 =?utf-8?B?S2I0Qm1mNXV0eEV3VWVYdFo2SUJ0S0lqb0VhaFVxV1RwT1ZVTHVEQVIvZ3NY?=
 =?utf-8?B?ZTVFYlFicUZJQXYrVUpLT09jM21tQ0laYzdCN3RwN1JCU1VEanJNcVdxaU5l?=
 =?utf-8?B?VnQwdElLcEZSMkpxeitUNFQ1SzBkNE8xUEhhZVg5RFBXdjFZSm1oNEtic05R?=
 =?utf-8?B?WkdxcTVwcUYyOVhvRFZ6Wkw1OGNuMStWOEoyYi9KTGF2WVZUbC9oaDBmVmw0?=
 =?utf-8?B?aEp5clJRUjJYOFo4cXNsY2lSK25YY25GU2xKK1lFcGJwcEwzMnNNeTlrc3Yy?=
 =?utf-8?B?R21GU3AwMnpmMWRoWk9CaVJjMzhpWXQrdndudUUyNlc1dGVpVkNiNTFxTEN4?=
 =?utf-8?B?N2Q4ZmFhK2IrMHZ5N3owcmN4d1h6b1dBdktjQXZLMlE5ZG1WdnJZN0h6SFky?=
 =?utf-8?B?L0xTcmo2K055bWdMeGo3QVZ2TzRGaFZEc3ZYbksxVlNxdWVOU0pyVlpBb0ll?=
 =?utf-8?B?K2ZuVkE4Yi9VYlBvZjdMd29ZK05aWWl2eW8rRE5oUXdYZ3E4UWR2VWQrVFk3?=
 =?utf-8?B?d3AwUzk3Q3BTeHgvbDE0elZtc1RQTG81VDJ2UTNneUh5RUFqM3BlTHVPTE5R?=
 =?utf-8?B?RmI3OGdXS3NBU0N0YXNlaDF5VzZXcE5nNEk3NmZYaFJJOHc1R2c2VlVFMmNO?=
 =?utf-8?B?QnRKMWhMbUVqUjA1TitmRStEclVwWmw2bnlabHpTdEM2RVB4aXJaOUZUektj?=
 =?utf-8?B?d3dKY3BpN1lUYk04WGtCVXBnZXN5dDRoL3RTbkxmY2tKckk3VlluZ0lLdThj?=
 =?utf-8?B?T0FuKys4bWc0bmFkWC9hL0l3N25IV0VEK1BwL1p4bWYzWmY2cHZRL1dBRUlT?=
 =?utf-8?B?aldYQlBXbHlWcVBZSTBwaTg5U2x3Rm9uSXRmZnI2SDIrM1NEb29YaVNuSkFJ?=
 =?utf-8?B?ZzBXZnh2a01MVktrNlFibFVNOWJJTXhnTXFsakN4ZUdSbFRWSWpVd3RrdCtI?=
 =?utf-8?B?YUxGNkphZXo4WlZYc0h2WnM4ajBaR2ZHWnk5YU9VeGFSbDdIK3UrMVQxdzRL?=
 =?utf-8?B?dnFkTHRhdENPOEV4SFNlZmcwOEg5TFFXd2NINGI0bjJYczRjNTdmSDJMZDBv?=
 =?utf-8?B?VWpyc3ZKS3l2TnM2T0NVdU04bjRpOCtkZWJCK2tVTUFZUXB3K3hHRlpBamxm?=
 =?utf-8?B?SmFTRXVJNmJKazl3L2RMVUlHK1ArbERlZnFwNUlVbXhSN05nSFBjN3BYV1Bn?=
 =?utf-8?B?TjhtYjI4Z1ErN3Z3QWhhMGphbk8yRnMxMFBQbm0zK1gra3N4Q0V4a2FQMjNs?=
 =?utf-8?B?UWRNWDd3SDFOeUd3TjlTUnZiYTl2R3pPRS8vNnVITzZyNEhMK0dHbnk1Tm5W?=
 =?utf-8?B?dTlwOEk5b3RzaHA2K0ExeVNXS05tR0N2SmV4Rmt1d3dVVll4aW51bm9DcDdl?=
 =?utf-8?Q?j6Bjr5f9FBfhJgEJkP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d13ee80-cc19-4f92-b491-08df1541d1dc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:00:54.9260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmqrvi2wHCuskzRYcz8zNSSFgB7rwZn2o9BgdgWZalyAlPb22u2QrEaWoXGqOzrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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



On 16-Sep-26 11:07 AM, Srinivasan Shanmugam wrote:
> User-queue VMIDs receive their trap register state from MES/KIQ at queue
> creation. Kernel-managed VMIDs do not; program them here.
> 
> Add program_kernel_trap_tba_tma() to each gfxhub generation and call it
> from setup_vmid_config(). No vmhub callback is introduced: the operation
> is generation-specific and belongs in each gfxhub's own setup path.
> 
> Both TBA and TMA addresses are GPU virtual addresses taken from the
> common trap mapping established at vm_init. TRAP_EN is safe to set at
> this point: any GPUVM assigned to a kernel-managed VMID already has a
> valid trap mapping before it can execute work.
> 
> TBA is the shared device-level ISA BO mapped into each VM at
> AMDGPU_VA_RESERVED_TRAP_START. TMA starts at offset 0x1800 from the same
> base, matching KFD_CWSR_TMA_OFFSET so both KFD and render-node VMs use
> the same per-VM buffer layout.
> 
> The helper is named program_kernel_trap_tba_tma() because it selects
> each kernel-managed VMID and writes its TBA/TMA registers; it does not
> configure the VMIDs themselves.
> 
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  9 +++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 35 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 35 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 39 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 35 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 35 ++++++++++++++++++
>   7 files changed, 188 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 3313bc099cf4..d17f54ccadb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -38,10 +38,6 @@
>   
>   extern int cwsr_enable;
>   
> -#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
> -
>   #define SGPR_SIZE_PER_CU 0x4000
>   #define LDS_SIZE_PER_CU 0x10000
>   #define HWREG_SIZE_PER_CU 0x1000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 2d855433308a..5769c5acb5c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -26,6 +26,15 @@
>   #include <linux/types.h>
>   #include <linux/iosys-map.h>
>   
> +/*
> + * TBA occupies one page plus 2 KiB (0x1800). TMA starts at that offset.
> + * Matches KFD_CWSR_TMA_OFFSET so both KFD and render-node paths share
> + * the same per-VM buffer layout.
> + */
> +#define AMDGPU_TRAP_TBA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE + 2048)  /* 0x1800 */
> +#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_OFFSET   (AMDGPU_TRAP_TBA_MAX_SIZE)     /* 0x1800 */
> +

This doesn't work after the split to a separate tma bo. A new bo mapping 
has to be at AMDGPU_PAGE_SIZE aligned offset. There is some check like 
that in the mapping API is what I recall.

>   struct amdgpu_bo;
>   struct amdgpu_bo_va;
>   struct amdgpu_device;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index 652eea6eae4a..687268e23344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>   #include "gfxhub_v11_5_0.h"
>   
>   #include "gc/gc_11_5_0_offset.h"
> @@ -290,6 +291,37 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
>   
>   }
>   
> +static void
> +gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
> +	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */

Better to get it through a helper like amdgpu_trap_get_l1_addr(tba, 
tma). The layout needs to stay within amdgpu_trap.

Thanks,
Lijo

> +	int vmid;
> +
> +	if (!amdgpu_trap_is_enabled(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     upper_32_bits(tba_addr >> 8) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8));
> +	}
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>   static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -337,6 +369,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_enabled(adev))
> +		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
>   }
>   
>   static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> index 6cbf837d50dd..b521a6c6eaf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>   #include "gfxhub_v12_0.h"
>   
>   #include "gc/gc_12_0_0_offset.h"
> @@ -295,6 +296,37 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
>   
>   }
>   
> +static void
> +gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
> +	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
> +	int vmid;
> +
> +	if (!amdgpu_trap_is_enabled(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     upper_32_bits(tba_addr >> 8) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8));
> +	}
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>   static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -342,6 +374,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_enabled(adev))
> +		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
>   }
>   
>   static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index 4c2fd1e6616e..ac52ccda713d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -21,6 +21,7 @@
>    *
>    */
>   #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>   #include "amdgpu_xcp.h"
>   #include "gfxhub_v12_1.h"
>   
> @@ -406,6 +407,41 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
>   	}
>   }
>   
> +static void
> +gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
> +	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
> +	int xcc, vmid;
> +
> +	if (!amdgpu_trap_is_enabled(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for_each_inst(xcc, adev->gfx.xcc_mask) {
> +		for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, xcc);
> +			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_LO,
> +				     lower_32_bits(tba_addr >> 8));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_HI,
> +				     upper_32_bits(tba_addr >> 8) |
> +				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_LO,
> +				     lower_32_bits(tma_addr >> 8));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_HI,
> +				     upper_32_bits(tma_addr >> 8));
> +		}
> +	}
> +	/* Reset the VMID selector on every XCC instance. */
> +	for_each_inst(xcc, adev->gfx.xcc_mask)
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>   static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>   					       uint32_t xcc_mask)
>   {
> @@ -468,6 +504,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>   
>   		hub->vm_cntx_cntl = tmp;
>   	}
> +
> +	if (amdgpu_trap_is_enabled(adev))
> +		gfxhub_v12_1_program_kernel_trap_tba_tma(adev);
>   }
>   
>   static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 9ea593e2c719..ba2d5d719474 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>   #include "gfxhub_v2_0.h"
>   
>   #include "gc/gc_10_1_0_offset.h"
> @@ -280,6 +281,37 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
>   
>   }
>   
> +static void
> +gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
> +	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
> +	int vmid;
> +
> +	if (!amdgpu_trap_is_enabled(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +			     upper_32_bits(tba_addr >> 8) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8));
> +	}
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>   static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -327,6 +359,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_enabled(adev))
> +		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
>   }
>   
>   static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 9e6a6e13dec0..204a8817df30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>   #include "gfxhub_v3_0.h"
>   
>   #include "gc/gc_11_0_0_offset.h"
> @@ -287,6 +288,37 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
>   
>   }
>   
> +static void
> +gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
> +	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
> +	int vmid;
> +
> +	if (!amdgpu_trap_is_enabled(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     upper_32_bits(tba_addr >> 8) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8));
> +	}
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>   static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -334,6 +366,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_enabled(adev))
> +		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
>   }
>   
>   static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)

