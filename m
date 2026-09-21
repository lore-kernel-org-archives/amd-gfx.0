Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEA3C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 03:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F94110E1A5;
	Mon, 21 Sep 2026 03:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R/pMkPPz";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC8E10E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 03:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hapIB3Nl6AlTHNo0VdS3OpnLwHIk2D+mZ0cuMPf9RHVFUMU4maqwhA5FKWQBc6V+ASbydJShijaTDQCyu67+zOGzHyl3jjAZjj2pALL5i74JXJnzLV3G3pL1rWO4Xr4tX729LaU1bboIWH0RqLm5FjczQk8x2nF0HFYwv4nnImwwL/876WPUWbZG/4ZZ/T3e2P471hfi+SJ6jU1/Ax5Dha/nxjsk4FJUQ4oYdx4xmrOR6FQnZ0BTNJiSZfQNrRka63yi8WoTLqPFXzux3zn12sB8BDDLDE70zZebdqP0XzuZG4KDcZVCjg1vrKIG+8gAinJpTihMTGuMTQomVY6Bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNvTqHQtHyq/Gn/mRdVyhrxDPO/tIlMGWR7BgLhVdHo=;
 b=HPz/pWXLNTO0GIrA8z6AnVOXUJfoYBXbZ9/XnOCivsiSeC/WvCSnU2BTbpV0fFHhbUk7HtAzWl5233Xu5+DHhMXq+qavMi0D8k/m84ahW/zHRXjZpLNfNja4iy+RhneaKStbUSJeD7Fydi6GfbzRIc2mbIH1K04rZ4YytBj74trFkb3vi1GHnGZznrFkX8fZXLzJFDq2epTJv1GegpJCdPhnKAKNik/CX0LADcxZlqpKoJ/Q1deOdwGvfiyTyWkQd0t3RTVswIiKOXrdvvnOXS3oSplI3zL0USWoV91pogVeY4AgRVAD6ZwpLlHeRYLtRyL5uP54X6ewVhJM9R3HoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNvTqHQtHyq/Gn/mRdVyhrxDPO/tIlMGWR7BgLhVdHo=;
 b=R/pMkPPzc5+JWu75AiKbrDx9XaGlS0cRhoTNBD/lY3a3pebhlt4fFypRwrm+yITzrPyAJFyFnPMaqIOjwoww77+vt731dh5N+QL6k+6jygxBZh7tF8HyE0YswIRjkU1PrVAmieVnKk0AmcIX59VNPqb8guKyA0r1xZ6qaFTDsO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 03:41:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 03:41:32 +0000
Message-ID: <215c24c0-529f-40a5-8e23-fd83aa6a991f@amd.com>
Date: Mon, 21 Sep 2026 09:11:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use offset macros for sdma v7.1
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Le.Ma@amd.com,
 Asad.Kamal@amd.com, YuBiao.Wang@amd.com
References: <20260918042012.1788773-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260918042012.1788773-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0214.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: f07831ea-4a2b-4d57-5901-08df17923a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5ApusdrsmrawexUC1+YGLtw/r9ox8+YkXkxQfV0NfGNWK9u6ruXw/enY2QM116hyor+4Tcq6SVqKMnwNxwaOxo+refebZYvXxjmEiJv7q2SxD+8YCU4/rWSWDeMiYEP+Smal6r4IlzLMvLBVyn9oWY/qsmwisexQ470CbSB42kiRQ2o69NkjW9Aq4pDyqKdDwmjIgg3YhlALieCgKR7mgMXtvn2lCIe00UTEWRH+ShLyBhYbW0XEFqSLcCCBPKBjYqwHIA2M5cQpa/rNLYi3Ol4MayVrRLhcpvoYCKwM+NvTFTR36pcM7KVHKhD/8AWRCwis8BvYScJL3bvShY7I6p0g56QgDyedeuS4bI8RstFKdYA6cd129uoQggmzWlF6som8CcFP6cwgT+zpjLuYvFc24DhNnbjHSQTpGasrGzcceLCefKdacpmXhhEcFlsRbYwc9dvVyx35Sf0IC4IzHD42IDL2qdGZ87/xNQvOvy9lX+YgDs/QPFlCv/jDBTdA+EQX47UwMTk+LP7hii1SFORdVTgenFseQMrJrbN8wmQTBJsXRZPw4Vtr6Jbb0L69ZSItvT9RQfhIiie3esMjkLxrnm7PrfO7YXRTQO1HF3Tf69zcQtCZkIkOR1lO1sPedCZn29p3lGRttDT9zk+ufj6Ns7eXjvwYQHwGiJNC2Xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdiOVN5WkxCbUhPQWxUZ1pLMVZkMWJGekZxbURUTUR4TS9OVVY4VE1nUEly?=
 =?utf-8?B?Q1Nkek8vWlc5K1MvbzlDMmdMQ3VjcjNUa3plSFpuRkNRLzFKOEkwVUtKTjVS?=
 =?utf-8?B?WGExN3pxcHhVWDQrUDg1U2tjekw4U1ltMVBPMHQ5NTdTdkZDNG1PbnVRTUJZ?=
 =?utf-8?B?OVQvc003czU1RE5MZEVYNUZjTzRkdUphL1JCWkMzTkZNeXJSRlZ4N0VNMVdL?=
 =?utf-8?B?aWlTcWduenI0aUE2QVFrVUNyM0oyOHBwMlhxbVRkaFgxWmhTTld3Njh2NUNu?=
 =?utf-8?B?UzcvcmpqRzduS2RYTk5GejJxdmNHazJrUFBUOFVnTGxvWnpFckhoMUdpWFVP?=
 =?utf-8?B?ZW1rd3lWM2pQWEVYM3UzZnJFK3JpeUpiSVdMem9NakVrOW5ueTYrcnREQmxp?=
 =?utf-8?B?MjkxYU1IMGJSTSs0Z2pBUklJUHBqeDl6YlhBemNuamNvOXdCeUV1aC9sQlF0?=
 =?utf-8?B?T1ZYVWx5N2tSY3BQTmJGZkc0WEhuUURJMkcvYlNEOTdTdkoyQWdJL3JxRURs?=
 =?utf-8?B?cU5teFFWMHhielpNZ013dWxLVVl5MDhvZlFjYjNoTE8zWFJFT0E3aHp3TXlu?=
 =?utf-8?B?MkhwR0N1aTladGZsK0tWZ3NUZXdGa215ZHJLNWhkSHZUbkZtVDB1NFloc2tn?=
 =?utf-8?B?TDZXWGJYZUdBRUFEc3crRGxxd3BUNXVkUno3QlFVbnBaN3JBeFV6ZVNYS1hz?=
 =?utf-8?B?VzhCYlVyODdpWUdCM3JYeWhxOHkvUEdtVHIxWVdoaWV1bERyRGsyREVja1o3?=
 =?utf-8?B?T0duOG42Yk1Fbm8rbUJNcFVVWndKdXJ5ZnNZeS9pUkpOeld6QXRpTzU4dnZO?=
 =?utf-8?B?eDdrU1hDZXRKbGdFWlZ5Q3lzNG5xZExkWXVGV3NZZ1J1RDVIUTlISEJObExj?=
 =?utf-8?B?WkF6YkJKNDhmTTlGK2JrdU5DcFptdHoxMFlhQUxjTnNROEcybXZ5bngrYXlT?=
 =?utf-8?B?UmRNUlE3RTVaWlNhd2JzblhpYWpNa1FOSGpUYnFoaGRBRk14eTZxcFl2NTdU?=
 =?utf-8?B?Y3BZalJLbDUxclNMMlluS3lkM0U2Z2FHRHZFVXJKODFyZFBEWUhkdGNJdWlQ?=
 =?utf-8?B?ME1IZGJoUGRmRXlacFJIRHVNUVVuTXJJWXRnNXBiaUdyTEkxaDVKSkVzWnhG?=
 =?utf-8?B?SWhVMldIdjlxOXVFMDRhOWhPNDJqQkFhM3FvUDJadXp2ZVh6alJTZU9KcnpB?=
 =?utf-8?B?VnBNV3BHTnNMK3JyaFczUDQxbTNkMDhTeVNkbUFDSms0Yktqb2IwTjEwc3ZL?=
 =?utf-8?B?MHovcVAvNkJkMWhSUTRoME1XVlorak8yUWVoaWJlMnMxZG5wbkdtZGQ2WDhS?=
 =?utf-8?B?OXFDN1FRdnhnT05kQlJjdWtjeEZpTHlQNytmTEh4Y0tjNWFZc0EwNlFUZWc1?=
 =?utf-8?B?Z0grRDI1SElibHM0dmwxcXlrZ29pRFdsdlduS0E0dkMzMzEwZHhpUjlMMHFT?=
 =?utf-8?B?Y0hNTXQvSTVqOWlGRHNabGt4VmNQQStrZ3c3b3RGM1RuMXpjWnc3aldXcXJw?=
 =?utf-8?B?anJMRndUYUUzN3RUUUVhZE9jdWR1aXBNcG5ZQldkVjBZL29IK2c5ZGV0YUdT?=
 =?utf-8?B?R3R0VXZXKzMxaGdkOC9mMjFrN3FBM3oydVI4a09UWkhzeVJ1MXdhU21hZTFO?=
 =?utf-8?B?aGZLTk1MWnkyQWd2MXAwSWxwU2c1YmZ0WWFKR3dsQjRRb0J5YTNydGpTRjBo?=
 =?utf-8?B?UTh2elBHSzBMNHh0V2xmSStucVA1UkVNTERLQTFjTDhHOUNsWFZmb08xZTRQ?=
 =?utf-8?B?Zk9oeXVvdnl3cVQvUkNZRGhNN1I4cTdEWVpNTG1VOFprZElWd0gvYUVIdlpx?=
 =?utf-8?B?elBwbDRJNGRvQXNBY0RsRFFwYzR4Rm9CK3BuT291b1pVa0hUN1R4a1ZwVlIw?=
 =?utf-8?B?aFdMMDZxNkRQWCsxTy9PM2pHcDFTUDlPYmJxc1FxTWhCUERXcStHT0IwR2NW?=
 =?utf-8?B?RVpXRVZham54d21Rb1FtclppYWNiUXJDMDF3RWpRNnRpcUgxK0VvQWJURzdZ?=
 =?utf-8?B?WnZMRGJSYmFhQml6ZVpLbHFOWndQK0dnZnhsNTFsRTJkSWlmL2k3eFZMWkJY?=
 =?utf-8?B?U2JHTTd0cys2dEw0L3Q3cTFaY3VOS0ZaaHJrclVCZXY5YWpudXgrMklYL0Rt?=
 =?utf-8?B?ZG02dGFwVVpUZmdNTERzZEFiQjErcnhxNFJ4TTVqcDVaU3IwOVFsS1FGUXFq?=
 =?utf-8?B?U1BmeUJDNnVsZ2NYVS9LT3o4VG9QbnZ4M1JFNTJmLzdkL0ExTi90cjl1Wm1K?=
 =?utf-8?B?UHRJYlUwRGNiWTVyTUtUcnJadCtKK2RjaTlQSnpSQWlDWk5GNVhhRGpZdXUz?=
 =?utf-8?Q?3Zyo3HfqaUfqX4gESU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07831ea-4a2b-4d57-5901-08df17923a3e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 03:41:32.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImCQw6+C64pLFQFcuENXvK2mJfXpIFxOQB+j+MeRxfmLxHI7Jjb0jkZYUKryhnXU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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

<Ping>

On 18-Sep-26 9:50 AM, Lijo Lazar wrote:
> Use WREG32_SOC15_OFFSET/RREG32_SOC15_OFFSET macros for register accesses
> of SDMA instances within a XCD. Those macros take instance arg which
> is helpful in SRIOV accesses to identify the XCC through which access
> can be routed. Use build time assert to make sure only register offsets
> from the mapped segments are accessed.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 313 ++++++++++++++++---------
>   1 file changed, 201 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index 50058118235f..3155a5c655bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -46,9 +46,9 @@
>   
>   MODULE_FIRMWARE("amdgpu/sdma_7_1_0.bin");
>   
> -#define SDMA1_REG_OFFSET 0x600
> -#define SDMA0_SDMA_IDX_0_END 0x450
> -#define SDMA1_HYP_DEC_REG_OFFSET 0x30
> +/* per-instance stride is the SDMA0 to SDMA1 delta of the owning address block */
> +#define SDMA1_DEC_REG_OFFSET (regSDMA1_SDMA_DEC_START - regSDMA0_SDMA_DEC_START)
> +#define SDMA1_HYP_DEC_REG_OFFSET (regSDMA1_SDMA_VM_CTX_LO - regSDMA0_SDMA_VM_CTX_LO)
>   
>   static const struct amdgpu_hwip_reg_entry sdma_reg_list_7_1[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_SDMA_STATUS_REG),
> @@ -114,26 +114,27 @@ static void sdma_v7_1_set_irq_funcs(struct amdgpu_device *adev);
>   static int sdma_v7_1_inst_start(struct amdgpu_device *adev,
>   				uint32_t inst_mask);
>   
> -static u32 sdma_v7_1_get_reg_offset(struct amdgpu_device *adev, u32 instance, u32 internal_offset)
> +/* per-instance stride of each SDMA address block, indexed by register BASE_IDX */
> +static const u32 sdma_v7_1_inst_stride[] = {
> +	SDMA1_DEC_REG_OFFSET,
> +	SDMA1_HYP_DEC_REG_OFFSET,
> +};
> +
> +/*
> + * Offset from an SDMA0 register to the same register of SDMA instance
> + * within its own XCC, i.e. SDMA0 to SDMA1 register address delta.
> + */
> +static u32 sdma_v7_1_inst_offset(struct amdgpu_device *adev, u32 instance,
> +				 u32 base_idx)
>   {
> -	u32 base;
> -	u32 dev_inst = GET_INST(SDMA0, instance);
> -	int xcc_id = adev->sdma.instance[instance].xcc_id;
> -	int xcc_inst = dev_inst % adev->sdma.num_inst_per_xcc;
> -
> -	if (internal_offset >= SDMA0_SDMA_IDX_0_END) {
> -		base = adev->reg_offset[GC_HWIP][xcc_id][1];
> -		if (xcc_inst != 0)
> -			internal_offset += SDMA1_HYP_DEC_REG_OFFSET * xcc_inst;
> -	} else {
> -		base = adev->reg_offset[GC_HWIP][xcc_id][0];
> -		if (xcc_inst != 0)
> -			internal_offset += SDMA1_REG_OFFSET * xcc_inst;
> -	}
> +	u32 xcc_inst = GET_INST(SDMA0, instance) % adev->sdma.num_inst_per_xcc;
>   
> -	return base + internal_offset;
> +	return xcc_inst * sdma_v7_1_inst_stride[base_idx];
>   }
>   
> +#define SDMA_INST_OFFSET(i, reg) \
> +	(BUILD_BUG_ON_ZERO(ARRAY_SIZE(sdma_v7_1_inst_stride) <= reg##_BASE_IDX) + \
> +	 sdma_v7_1_inst_offset(adev, (i), reg##_BASE_IDX))
>   static unsigned sdma_v7_1_ring_init_cond_exec(struct amdgpu_ring *ring,
>   					      uint64_t addr)
>   {
> @@ -199,6 +200,7 @@ static uint64_t sdma_v7_1_ring_get_wptr(struct amdgpu_ring *ring)
>   static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	u32 xcc_id = adev->sdma.instance[ring->me].xcc_id;
>   
>   	DRM_DEBUG("Setting write pointer\n");
>   
> @@ -224,14 +226,12 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)
>   			  lower_32_bits(ring->wptr << 2),
>   			  ring->me,
>   			  upper_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev,
> -							     ring->me,
> -							     regSDMA0_SDMA_QUEUE0_RB_WPTR),
> -				lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev,
> -							     ring->me,
> -							     regSDMA0_SDMA_QUEUE0_RB_WPTR_HI),
> -				upper_32_bits(ring->wptr << 2));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR,
> +				    SDMA_INST_OFFSET(ring->me, regSDMA0_SDMA_QUEUE0_RB_WPTR),
> +				    lower_32_bits(ring->wptr << 2));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI,
> +				    SDMA_INST_OFFSET(ring->me, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI),
> +				    upper_32_bits(ring->wptr << 2));
>   	}
>   }
>   
> @@ -367,15 +367,22 @@ static void sdma_v7_1_inst_gfx_stop(struct amdgpu_device *adev,
>   				    uint32_t inst_mask)
>   {
>   	u32 rb_cntl, ib_cntl;
> +	u32 xcc_id;
>   	int i;
>   
>   	for_each_inst(i, inst_mask) {
> -		rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL));
> +		xcc_id = adev->sdma.instance[i].xcc_id;
> +
> +		rb_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
> +					      SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_CNTL));
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_ENABLE, 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
> -		ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_IB_CNTL));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
> +		ib_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB_CNTL,
> +					      SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_IB_CNTL));
>   		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_ENABLE, 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_IB_CNTL), ib_cntl);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_IB_CNTL), ib_cntl);
>   	}
>   }
>   
> @@ -405,11 +412,14 @@ static void sdma_v7_1_inst_rlc_stop(struct amdgpu_device *adev,
>   static void sdma_v7_1_inst_ctx_switch_enable(struct amdgpu_device *adev,
>   					     bool enable, uint32_t inst_mask)
>   {
> +	u32 xcc_id;
>   	int i;
>   
>   	for_each_inst(i, inst_mask) {
> -		WREG32_SOC15_IP(GC,
> -			sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_UTCL1_TIMEOUT), 0x80);
> +		xcc_id = adev->sdma.instance[i].xcc_id;
> +
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_TIMEOUT,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_TIMEOUT), 0x80);
>   	}
>   }
>   
> @@ -426,6 +436,7 @@ static void sdma_v7_1_inst_enable(struct amdgpu_device *adev,
>   				  bool enable, uint32_t inst_mask)
>   {
>   	u32 mcu_cntl;
> +	u32 xcc_id;
>   	int i;
>   
>   	if (!enable) {
> @@ -437,9 +448,13 @@ static void sdma_v7_1_inst_enable(struct amdgpu_device *adev,
>   		return;
>   
>   	for_each_inst(i, inst_mask) {
> -		mcu_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL));
> +		xcc_id = adev->sdma.instance[i].xcc_id;
> +
> +		mcu_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
> +					       SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL));
>   		mcu_cntl = REG_SET_FIELD(mcu_cntl, SDMA0_SDMA_MCU_CNTL, HALT, enable ? 0 : 1);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL), mcu_cntl);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL), mcu_cntl);
>   	}
>   }
>   
> @@ -462,13 +477,15 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>   	u32 doorbell_offset;
>   	u32 temp;
>   	u64 wptr_gpu_addr;
> +	u32 xcc_id = adev->sdma.instance[i].xcc_id;
>   	int r;
>   
>   	ring = &adev->sdma.instance[i].ring;
>   
>   	/* Set ring buffer size in dwords */
>   	rb_bufsz = order_base_2(ring->ring_size / 4);
> -	rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL));
> +	rb_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
> +				      SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_CNTL));
>   	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
>   #ifdef __BIG_ENDIAN
>   	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
> @@ -476,32 +493,49 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>   				RPTR_WRITEBACK_SWAP_ENABLE, 1);
>   #endif
>   	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_PRIV, 1);
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
>   
>   	/* Initialize the ring buffer's read and write pointers */
>   	if (restore) {
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPTR),
> +				    lower_32_bits(ring->wptr << 2));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR_HI,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPTR_HI),
> +				    upper_32_bits(ring->wptr << 2));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR),
> +				    lower_32_bits(ring->wptr << 2));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI),
> +				    upper_32_bits(ring->wptr << 2));
>   	} else {
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_RPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_RPTR_HI), 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI), 0);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPTR), 0);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR_HI,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPTR_HI), 0);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR), 0);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI), 0);
>   	}
>   	/* setup the wptr shadow polling */
>   	wptr_gpu_addr = ring->wptr_gpu_addr;
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_ADDR_LO),
> -	       lower_32_bits(wptr_gpu_addr));
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_ADDR_HI),
> -	       upper_32_bits(wptr_gpu_addr));
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_ADDR_LO,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_ADDR_LO),
> +			    lower_32_bits(wptr_gpu_addr));
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_ADDR_HI,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_ADDR_HI),
> +			    upper_32_bits(wptr_gpu_addr));
>   
>   	/* set the wb address whether it's enabled or not */
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_HI),
> -	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_LO),
> -	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_HI,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_HI),
> +			    upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_LO,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_LO),
> +			    lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
>   
>   	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
>   	if (amdgpu_sriov_vf(adev))
> @@ -511,22 +545,32 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>   
>   	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, MCU_WPTR_POLL_ENABLE, 1);
>   
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_BASE,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_BASE_HI,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_BASE_HI),
> +			    ring->gpu_addr >> 40);
>   
>   	if (!restore)
>   		ring->wptr = 0;
>   
>   	/* before programing wptr to a less value, need set minor_ptr_update first */
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDATE), 1);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDATE,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDATE), 1);
>   
>   	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR),
> +				    lower_32_bits(ring->wptr) << 2);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPTR_HI),
> +				    upper_32_bits(ring->wptr) << 2);
>   	}
>   
> -	doorbell = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_DOORBELL));
> -	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSET));
> +	doorbell = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_DOORBELL,
> +				       SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_DOORBELL));
> +	doorbell_offset = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSET,
> +					      SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSET));
>   
>   	if (ring->use_doorbell) {
>   		doorbell = REG_SET_FIELD(doorbell, SDMA0_SDMA_QUEUE0_DOORBELL, ENABLE, 1);
> @@ -535,8 +579,11 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>   	} else {
>   		doorbell = REG_SET_FIELD(doorbell, SDMA0_SDMA_QUEUE0_DOORBELL, ENABLE, 0);
>   	}
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_DOORBELL), doorbell);
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_DOORBELL,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_DOORBELL), doorbell);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSET,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSET),
> +			    doorbell_offset);
>   
>   	if (i == 0)
>   		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
> @@ -547,53 +594,66 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>   		sdma_v7_1_ring_set_wptr(ring);
>   
>   	/* set minor_ptr_update to 0 after wptr programed */
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDATE), 0);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDATE,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDATE), 0);
>   
>   	/* Set up sdma hang watchdog */
> -	temp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_WATCHDOG_CNTL));
> +	temp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_WATCHDOG_CNTL,
> +				   SDMA_INST_OFFSET(i, regSDMA0_SDMA_WATCHDOG_CNTL));
>   	/* Disable sdma hang watchdog, need revist this when issue resolved.
>   	Once issue resoved, the QUEUE_HANG_COUNT should be set to max(adev->usec_timeout/100000,1)
>   	*/
>   	temp = REG_SET_FIELD(temp, SDMA0_SDMA_WATCHDOG_CNTL, QUEUE_HANG_COUNT, 0);
>   	temp = REG_SET_FIELD(temp, SDMA0_SDMA_WATCHDOG_CNTL, CMD_TIMEOUT_COUNT, 0);
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_WATCHDOG_CNTL), temp);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_WATCHDOG_CNTL,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_WATCHDOG_CNTL), temp);
>   
>   	dev_dbg(adev->dev, "Disable SDMA Hang WatchDog, regSDMA0_SDMA_WATCHDOG_CNTL = %d\n",
> -		RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_WATCHDOG_CNTL)));
> +		RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_WATCHDOG_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_WATCHDOG_CNTL)));
>   
>   	/* Set up RESP_MODE to non-copy addresses */
> -	temp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_UTCL1_CNTL));
> +	temp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_CNTL,
> +				   SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_CNTL));
>   	temp = REG_SET_FIELD(temp, SDMA0_SDMA_UTCL1_CNTL, RESP_MODE, 3);
>   	temp = REG_SET_FIELD(temp, SDMA0_SDMA_UTCL1_CNTL, REDO_DELAY, 9);
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_UTCL1_CNTL), temp);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_CNTL,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_CNTL), temp);
>   
>   	/* program default cache read and write policy */
> -	temp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_UTCL1_PAGE));
> +	temp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_PAGE,
> +				   SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_PAGE));
>   	/* clean read policy and write policy bits */
>   	temp &= 0xFF0FFF;
>   	temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
>   		 (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_UTCL1_PAGE), temp);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_PAGE,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_PAGE), temp);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		/* unhalt engine */
> -		temp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL));
> +		temp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
> +					   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL));
>   		temp = REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, HALT, 0);
>   		temp = REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, RESET, 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL), temp);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL), temp);
>   	}
>   
>   	/* enable DMA RB */
>   	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_ENABLE, 1);
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
>   
> -	ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_IB_CNTL));
> +	ib_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB_CNTL,
> +				      SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_IB_CNTL));
>   	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_ENABLE, 1);
>   #ifdef __BIG_ENDIAN
>   	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
>   #endif
>   	/* enable DMA IBs */
> -	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_IB_CNTL), ib_cntl);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB_CNTL,
> +			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_IB_CNTL), ib_cntl);
>   	ring->sched.ready = true;
>   
>   	if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> @@ -675,6 +735,7 @@ static int sdma_v7_1_inst_load_microcode(struct amdgpu_device *adev,
>   	const __le32 *fw_data;
>   	u32 fw_size;
>   	uint32_t tmp, sdma_status, ic_op_cntl;
> +	u32 xcc_id;
>   	int i, r, j;
>   
>   	/* halt the MEs */
> @@ -692,6 +753,8 @@ static int sdma_v7_1_inst_load_microcode(struct amdgpu_device *adev,
>   	fw_size = le32_to_cpu(hdr->ucode_size_bytes);
>   
>   	for_each_inst(i, inst_mask) {
> +		xcc_id = adev->sdma.instance[i].xcc_id;
> +
>   		r = amdgpu_bo_create_reserved(adev, fw_size,
>   					      PAGE_SIZE,
>   					      AMDGPU_GEM_DOMAIN_VRAM,
> @@ -708,25 +771,31 @@ static int sdma_v7_1_inst_load_microcode(struct amdgpu_device *adev,
>   		amdgpu_bo_kunmap(adev->sdma.instance[i].sdma_fw_obj);
>   		amdgpu_bo_unreserve(adev->sdma.instance[i].sdma_fw_obj);
>   
> -		tmp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_IC_CNTL));
> +		tmp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_CNTL,
> +					  SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_CNTL));
>   		tmp = REG_SET_FIELD(tmp, SDMA0_SDMA_IC_CNTL, GPA, 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_IC_CNTL), tmp);
> -
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_IC_BASE_LO),
> -			lower_32_bits(adev->sdma.instance[i].sdma_fw_gpu_addr));
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_IC_BASE_HI),
> -			upper_32_bits(adev->sdma.instance[i].sdma_fw_gpu_addr));
> -
> -		tmp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_IC_OP_CNTL));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_CNTL), tmp);
> +
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_BASE_LO,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_BASE_LO),
> +				    lower_32_bits(adev->sdma.instance[i].sdma_fw_gpu_addr));
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_BASE_HI,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_BASE_HI),
> +				    upper_32_bits(adev->sdma.instance[i].sdma_fw_gpu_addr));
> +
> +		tmp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_OP_CNTL,
> +					  SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_OP_CNTL));
>   		tmp = REG_SET_FIELD(tmp, SDMA0_SDMA_IC_OP_CNTL, PRIME_ICACHE, 1);
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_IC_OP_CNTL), tmp);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_OP_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_OP_CNTL), tmp);
>   
>   		/* Wait for sdma ucode init complete */
>   		for (j = 0; j < adev->usec_timeout; j++) {
> -			ic_op_cntl = RREG32_SOC15_IP(GC,
> -					sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_IC_OP_CNTL));
> -			sdma_status = RREG32_SOC15_IP(GC,
> -					sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_STATUS_REG));
> +			ic_op_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_OP_CNTL,
> +							 SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_OP_CNTL));
> +			sdma_status = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_STATUS_REG,
> +							  SDMA_INST_OFFSET(i, regSDMA0_SDMA_STATUS_REG));
>   			if ((REG_GET_FIELD(ic_op_cntl, SDMA0_SDMA_IC_OP_CNTL, ICACHE_PRIMED) == 1) &&
>   			    (REG_GET_FIELD(sdma_status, SDMA0_SDMA_STATUS_REG, UCODE_INIT_DONE) == 1))
>   				break;
> @@ -746,6 +815,7 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	uint32_t inst_mask;
> +	u32 xcc_id;
>   	u32 tmp;
>   	int i;
>   
> @@ -753,15 +823,22 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
>   	sdma_v7_1_inst_gfx_stop(adev, inst_mask);
>   
>   	for_each_inst(i, inst_mask) {
> -		//tmp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FREEZE));
> +		xcc_id = adev->sdma.instance[i].xcc_id;
> +
> +		//tmp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FREEZE,
> +		//			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_FREEZE));
>   		//tmp |= SDMA0_SDMA_FREEZE__FREEZE_MASK;
> -		//WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FREEZE), tmp);
> -		tmp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL));
> +		//WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FREEZE,
> +		//		      SDMA_INST_OFFSET(i, regSDMA0_SDMA_FREEZE), tmp);
> +		tmp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
> +					  SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL));
>   		tmp |= SDMA0_SDMA_MCU_CNTL__HALT_MASK;
>   		tmp |= SDMA0_SDMA_MCU_CNTL__RESET_MASK;
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL), tmp);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL), tmp);
>   
> -		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_PREEMPT), 0);
> +		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMPT,
> +				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_PREEMPT), 0);
>   
>   		udelay(100);
>   
> @@ -857,6 +934,7 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
>   			      struct amdgpu_mqd_prop *prop)
>   {
>   	struct v12_1_sdma_mqd *m = mqd;
> +	u32 xcc_id = adev->sdma.instance[0].xcc_id;
>   	uint64_t wb_gpu_addr;
>   
>   	m->sdmax_queuen_rb_cntl =
> @@ -876,8 +954,8 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
>   	m->sdmax_queuen_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
>   	m->sdmax_queuen_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
>   
> -	m->sdmax_queuen_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, 0,
> -							regSDMA0_SDMA_QUEUE0_IB_CNTL));
> +	m->sdmax_queuen_ib_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB_CNTL,
> +						    SDMA_INST_OFFSET(0, regSDMA0_SDMA_QUEUE0_IB_CNTL));
>   
>   	m->sdmax_queuen_doorbell_offset =
>   		prop->doorbell_index << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
> @@ -1380,13 +1458,18 @@ static int sdma_v7_1_sw_fini(struct amdgpu_ip_block *ip_block)
>   static void sdma_v7_1_rb_cmd_switch(struct amdgpu_device *adev,
>   				    uint32_t inst_mask)
>   {
> +	u32 xcc_id;
>   	int i, fe_cntl;
> -	
> +
>   	if (adev->sdma.sdma_debug) {
>   		for_each_inst(i, inst_mask) {
> -			fe_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FE_CNTL0));
> +			xcc_id = adev->sdma.instance[i].xcc_id;
> +
> +			fe_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FE_CNTL0,
> +						      SDMA_INST_OFFSET(i, regSDMA0_SDMA_FE_CNTL0));
>   			fe_cntl &= 0x7fffffff;
> -			WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FE_CNTL0), fe_cntl);
> +			WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FE_CNTL0,
> +					    SDMA_INST_OFFSET(i, regSDMA0_SDMA_FE_CNTL0), fe_cntl);
>   		}
>   	}
>   }
> @@ -1442,8 +1525,10 @@ static int sdma_v7_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   
>   	for (i = 0; i < adev->usec_timeout; i++) {
>   		for (j = 0; j < adev->sdma.num_instances; j++) {
> -			sdma[j] = RREG32(sdma_v7_1_get_reg_offset(adev,
> -						j, regSDMA0_SDMA_STATUS_REG));
> +			u32 xcc_id = adev->sdma.instance[j].xcc_id;
> +
> +			sdma[j] = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_STATUS_REG,
> +					SDMA_INST_OFFSET(j, regSDMA0_SDMA_STATUS_REG));
>   			if (!(sdma[j] & SDMA0_SDMA_STATUS_REG__IDLE_MASK))
>   				break;
>   		}
> @@ -1459,11 +1544,10 @@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
>   	int i, r = 0;
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 index = 0;
> -	u64 sdma_gfx_preempt;
> +	u32 xcc_id;
>   
>   	amdgpu_sdma_get_index_from_ring(ring, &index);
> -	sdma_gfx_preempt =
> -		sdma_v7_1_get_reg_offset(adev, index, regSDMA0_SDMA_QUEUE0_PREEMPT);
> +	xcc_id = adev->sdma.instance[index].xcc_id;
>   
>   	/* assert preemption condition */
>   	amdgpu_ring_set_preempt_cond_exec(ring, false);
> @@ -1480,7 +1564,8 @@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
>   	amdgpu_ring_commit(ring);
>   
>   	/* assert IB preemption */
> -	WREG32(sdma_gfx_preempt, 1);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMPT,
> +			    SDMA_INST_OFFSET(index, regSDMA0_SDMA_QUEUE0_PREEMPT), 1);
>   
>   	/* poll the trailing fence */
>   	for (i = 0; i < adev->usec_timeout; i++) {
> @@ -1496,7 +1581,8 @@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
>   	}
>   
>   	/* deassert IB preemption */
> -	WREG32(sdma_gfx_preempt, 0);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMPT,
> +			    SDMA_INST_OFFSET(index, regSDMA0_SDMA_QUEUE0_PREEMPT), 0);
>   
>   	/* deassert the preemption condition */
>   	amdgpu_ring_set_preempt_cond_exec(ring, true);
> @@ -1508,14 +1594,15 @@ static int sdma_v7_1_set_trap_irq_state(struct amdgpu_device *adev,
>   					unsigned type,
>   					enum amdgpu_interrupt_state state)
>   {
> +	u32 xcc_id = adev->sdma.instance[type].xcc_id;
>   	u32 sdma_cntl;
>   
> -	u32 reg_offset = sdma_v7_1_get_reg_offset(adev, type, regSDMA0_SDMA_CNTL);
> -
> -	sdma_cntl = RREG32(reg_offset);
> +	sdma_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_CNTL,
> +					SDMA_INST_OFFSET(type, regSDMA0_SDMA_CNTL));
>   	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_SDMA_CNTL, TRAP_ENABLE,
>   		       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> -	WREG32(reg_offset, sdma_cntl);
> +	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_CNTL,
> +			    SDMA_INST_OFFSET(type, regSDMA0_SDMA_CNTL), sdma_cntl);
>   
>   	return 0;
>   }
> @@ -1620,11 +1707,13 @@ static void sdma_v7_1_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   
>   	amdgpu_gfx_off_ctrl(adev, false);
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		u32 xcc_id = adev->sdma.instance[i].xcc_id;
> +
>   		instance_offset = i * reg_count;
>   		for (j = 0; j < reg_count; j++)
>   			adev->sdma.ip_dump[instance_offset + j] =
> -				RREG32(sdma_v7_1_get_reg_offset(adev, i,
> -				       sdma_reg_list_7_1[j].reg_offset));
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(sdma_reg_list_7_1[j], xcc_id) +
> +				       sdma_v7_1_inst_offset(adev, i, sdma_reg_list_7_1[j].seg));
>   	}
>   	amdgpu_gfx_off_ctrl(adev, true);
>   }

