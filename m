Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153BEC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 08:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9072C10F4ED;
	Wed, 17 Apr 2024 08:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhfzEmYZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D8F10F4ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 08:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csA7WDkxWsSFl8KP40UJHnQzOfoTJyJNAyR/t61xZpsGilUVitl1lExUGPC0IHT65GMYVA00blxSM09vCklIzDE8GDbdXCp68A9xhB+14NaTA0yW8Yj530wPXzSkYxZXsZ+fSdlSU6SIhixqc4Qfk0uD+oOk9LwjYYKqVGNvbR1FGLy3kC/l6Xw0sQnhm4iJIiUkLFlhe1sASC4+9RwbrmSC2qbLPNvLjdl46vFRBMpC3y1j6NbjBRDmkNAoYv2OuuFoKETNESTcyqw04E72QV6/PlG47WQCP432Rg8ytHsteQiiumTfqMpIDdtdyWafV2ZxsnhKiUX/Pl+6AIiK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXygFrx2APOvXZaghIUCj7QAaFYNZH7Fhye2LlwEqWY=;
 b=XIG+5++iGDQdjN+aht6eFDplXSQnGQp4lvZu67hKSogLlt/iJJ0ufX/X2IRjBjKlTRHjJ6UkhyKDJGNF9BgNDLas6k9SOEhQyQ4juXOlZplgyt6RNGQldVB47VljPxxwT4pDMOmZXDpOjuJcx4bx4W5YOMNCwrAtVGr8gsbNoqlsOj4DU/UauKf7dlOTK7tZ3jjTttIrXtkE5kUt2C+ED23YpZTq+s6LxDpOeG6LmNIgoSI2cEQnAp2HJbrpARypzBHYaX+0DE9rDaTKSfkQJhC2uSiD61bWvqQdO+NAqiQsxO1Rq1hUvmtqJkI2/r0wqF5h7E0cEegXyyGMOHxdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXygFrx2APOvXZaghIUCj7QAaFYNZH7Fhye2LlwEqWY=;
 b=yhfzEmYZ6HyaEtPc3IQ2Hy3CD2c7QIHaTqMnc148NBOf2SrmFJZH7CSfuDPKRd4FbhhUEZBJkEaicb5fBqQljmZaWN9Oglh28vnCTmK2xK5OriU/JmxisVW/JTxA2mYWz8i89Swgv6ujZ+QHQSZRCmtmo2/8blo55iWWaf6GRbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 08:45:23 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 08:45:23 +0000
Message-ID: <75237de6-635f-4a08-96e5-492882b2eb33@amd.com>
Date: Wed, 17 Apr 2024 10:45:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] drm/amdgpu: add support of gfx10 register dump
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240417081844.111259-1-sunil.khatri@amd.com>
 <20240417081844.111259-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240417081844.111259-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db57029-560b-490f-3e03-08dc5ebab84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RptHh5XfVROxs/g5tCLllkJqRRJCqbyuCITctd/E3HT82fpISdd7bj7nb/s9dyWLzjCXzKJj7SjKYxJUh46sI/1CBjlhg3MD20UXRQqkLqWs5ZHmLSqXHCOy59bJSSzWqDbh7Bn0NAyR18H0BbteyvEF71gRc2SXJ9b9suKDkOud6meNqgGe8O+GrDzcLRCzA7zoE5wAXieWUXbidz1FOApys89eLhdkRbtMxbofC3vog+d5ZxVCIJslPPJhTFPs+6uQ1TsjieU7s60FBgUVA4/iXVOjx8XB2fq52xWIafZoIdig+/MGAKyobwAKsziFh08CoLwCZfexvr/8wYJMpXNws4FdAaxFfejyMekaBE/9MJYCpzWpcmbFq85CGUQLBQepouVF4fwN39yo26hmXbMlx8cfsjfDj32no0Ovv0u4jmMCPdD1BUe/fxPhMLVOYJ15xbHr0V5giO1mAPoPXfs+JjQLdFVZqC/Sd4d9gjtwYd3Dt52JcPKJOWmC3wGiDFLmB/ZLnFZaCNzsbJrzv6yhnXLti3XPXNpH6/2n2bNAPHZkviGtkAnWCVPFo8aL+WsUDfAqyreLApm5Q4l6Du9MOqIJ42W/iJz17WuN2KI1PPuxXdLKUb77BRAbJ38zsovgiGxcB0us8fNhCMe7Cu5eKXotmkwwHnbeUNsnQ1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REk0UjBJZVovdVhCb24vd29PZmRDMFpFOGhFMVZSelZuTXNoakxLQnhJUGFq?=
 =?utf-8?B?ejdSOExwSEhnLzViSEhkQW9QN3dGanFPQmhLRDczM0MvMXMzOTFZQUwxMkpV?=
 =?utf-8?B?YlpCRHVvc2h5T2dTTU5Vd2hmVjkzOTY1VzIxeGxhaEd6OXlDRWxuRU9JcVUy?=
 =?utf-8?B?WTgwYU8yNnhLQnlxVzhnMFJIcmVIRWM2QWJWaXF1YWlPMkpkQk5MSmprRUxD?=
 =?utf-8?B?ZGMvd2hkeGR2TlZjOVlwWWFsSmp6bVU5T2hWUk5GNE1LMXEzTXUxbkV3cGUx?=
 =?utf-8?B?Nld5ZEQ5YVl0RXFCUTVLUm1MQkRjcHpYbzlrSUR6L0NKMHFFcUVXcndTRHR2?=
 =?utf-8?B?KzNOclNRU1Vmc25oYWVMQXRmbGFRc2s4RmJrWjZzNDBIemxJa3Evb2NhWEdG?=
 =?utf-8?B?eXJwOGZzUHozOGE0U2VrNk9nREY3QXlLcHVFRkppbU1jczc3UlQ3OGtNRDJS?=
 =?utf-8?B?TUpZY2lVWTRNYXZxWUlMR0Urck51WFNMUnVSc3kvV09BUUR2RUN4a0dLbzg5?=
 =?utf-8?B?S3A2b3pjdmMwcVpiUGtVWTg4UXRNNnN2d1lKNjJ0U1NqSGZIM1lZTVZrS3Fp?=
 =?utf-8?B?SzFvUFU5RGV6ZFdrOTFzNGprZVovdUh6em9WbG9lbDdkYjRUSlFCOWxvRkRN?=
 =?utf-8?B?cU9NZ1pPNFB3emxpQ3FmUG92R0I4TDA0ZDRESUZjQUdvMHhSWjRqeFVnWWw3?=
 =?utf-8?B?cWE5ZW8wVWMvSjVKckpHcW00Uk9FVVphQktEQzBaS3dJdFhIRXQrRTZ6eUpK?=
 =?utf-8?B?QlRMQzIwc09NZnBybUZJM2FTK2xPaXlqc21xNFdhZzNTamRYcm83WE5uWEhn?=
 =?utf-8?B?d3NYK1F2OEdPaURTOTNpZnlWT28vMnlVcERjUTRNUFUzemNaN2lOUUxWck85?=
 =?utf-8?B?UDhyUGVxVFRxVmUxNVIvVldQc3Q3eFhiVnVXVW5VK3hndlpoL0VyVG5vRjZC?=
 =?utf-8?B?cktSOFRYamlsNnpmYWxrd0twQjdlb0Z2bjJ4L0lKa1VTUFhJRHVYK3dUTWo0?=
 =?utf-8?B?U3RHSlJJdWdIK3JSdTQ5dzgxMjVFb2lZTDJkYmtESmozUHRkVW1neHZKS1d2?=
 =?utf-8?B?bHc2WmRYTms5b2JiaDAzR2hYK00wVkVoSEw0cmVzaGdzOXEzRlorOWFZV1gx?=
 =?utf-8?B?ZWtZQ080bFN1VEFhNHFrYXhRS0pmVzJrNWZjWjFlNVcwR3VxRi9Pck4rK3Ir?=
 =?utf-8?B?cUZLcGV1RUVUenlsMVVvTGFWWHNQVGZOVFlXVEZvQUJwWGFzNTIrQm4ybVo2?=
 =?utf-8?B?T0plT2l3RHNVaW55UFlsSjRXWFhPWjR4SWc2V2h3ZHNBQUxSczNHRDc4MEJV?=
 =?utf-8?B?Y3c3L3hoNmhvUjJ4RjZzZE5RRzU0MDJuWEx1OGRvcTdnQ1J3Mk11aVBYNUp1?=
 =?utf-8?B?VldrSmFJWGhwaFFlREF6cERlalFOZ0pmTXJOb2IzcnFLS1B2anFXaE9JUlJo?=
 =?utf-8?B?ZjNXcjJSck5ZbXpHbmZxK1JHRUFpVUVxVTJmbUZBUlBQUkp6T3Y1UDRMbTYr?=
 =?utf-8?B?ZlpvTUEwR0hLMXJNUHN1NHVDZFROTmJ6VnJYY2NtK0VBWmRIQ3l4NG1XaXdm?=
 =?utf-8?B?UVZFZXFpSTlaRWI1b05JWnY0Rk8wVDFic2ZEMG15dGVoRWt0d01ValljRjNL?=
 =?utf-8?B?TXB2dTN1KzBicnRKZkgrNjcrUVpUQXZqRGU3cldOVk5Jd2J0SmZ5bXRSOE05?=
 =?utf-8?B?OXJ5RjVZdnYxNmUzMGVoUHZYTGFTT0psemxzdEJDUVBIdzE3MVdMRjEvUGNM?=
 =?utf-8?B?Sy95aUQ0OFB3UG9lcElaVDYwSm95ajFMWElwOTU5YmRpNmVOSjdFU0Zla0Rk?=
 =?utf-8?B?bUZNSVZ6WkN3blNhanBoUnVIMVVnRFY2R1FoL2FwNXp3cDVWTjRXV1U5cXBa?=
 =?utf-8?B?L0p4WE1rRmhRdnlPNjlWMFFkTGxtN1AwNitpRUNvSlMvTXB1RUxvTDZURGQy?=
 =?utf-8?B?SWNmVlV5RjE5SXova0hFNE9SZ3pjd1F0NmVYV0ZsdEQ4VWJaa0x0c3lKUDRB?=
 =?utf-8?B?cWRwbkg4NTVSeEpMRkJYYUVxVkhENGRIdEduRUN0OS9YYVRpVmpMc3E0MFVM?=
 =?utf-8?B?MU1zZ1h5M1hGZkNtdVRWMFFRUUdlc0g3bFIwdFJkQzZnYjZKWHR3V1FiWktB?=
 =?utf-8?Q?X0pSRyc3GWswx+A1me8TN1ZD+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db57029-560b-490f-3e03-08dc5ebab84d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:45:23.2068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59v6mPUTo3f547YujMBFK+76sQqnQqvOUe1Sy53MK5TAEjZxskdciLuid9l91Ccx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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



Am 17.04.24 um 10:18 schrieb Sunil Khatri:
> Adding gfx10 gc registers to be used for register
> dump via devcoredump during a gpu reset.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 130 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/soc15.h            |   2 +
>   .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>   5 files changed, 155 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e0d7f4ee7e16..210af65a744c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -139,6 +139,14 @@ enum amdgpu_ss {
>   	AMDGPU_SS_DRV_UNLOAD
>   };
>   
> +struct amdgpu_hwip_reg_entry {
> +	u32	hwip;
> +	u32	inst;
> +	u32	seg;
> +	u32	reg_offset;

> +	char	reg_name[50];

Make that a const char *. Otherwise it bloats up the final binary 
because the compiler has to add zeros at the end.

> +};
> +
>   struct amdgpu_watchdog_timer {
>   	bool timeout_fatal_disable;
>   	uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 04a86dff71e6..64f197bbc866 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>   	uint32_t			num_xcc_per_xcp;
>   	struct mutex			partition_mutex;
>   	bool				mcbp; /* mid command buffer preemption */
> +
> +	/* IP reg dump */
> +	uint32_t			*ip_dump;
> +	uint32_t			reg_count;
>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index a0bc4196ff8b..4a54161f4837 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>   
> +static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] = {
> +	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS3),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT2),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT2),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HPD_STATUS0),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS_2),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL0_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL0_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmSQG_UTCL0_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL0_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_CNTL),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_3),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_4),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_GPM_STAT_2),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SPP_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_A),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_B),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
> +	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST)
> +};
> +
>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
> @@ -4490,6 +4583,22 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   			     hw_prio, NULL);
>   }
>   
> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
> +{
> +	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
> +	uint32_t *ptr;
> +
> +	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	if (ptr == NULL) {
> +		DRM_ERROR("Failed to allocate memory for IP Dump\n");
> +		adev->gfx.ip_dump = NULL;
> +		adev->gfx.reg_count = 0;
> +	} else {
> +		adev->gfx.ip_dump = ptr;
> +		adev->gfx.reg_count = reg_count;
> +	}
> +}
> +
>   static int gfx_v10_0_sw_init(void *handle)
>   {
>   	int i, j, k, r, ring_id = 0;
> @@ -4642,6 +4751,8 @@ static int gfx_v10_0_sw_init(void *handle)
>   
>   	gfx_v10_0_gpu_early_init(adev);
>   
> +	gfx_v10_0_alloc_dump_mem(adev);
> +
>   	return 0;
>   }
>   
> @@ -4694,6 +4805,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>   
>   	gfx_v10_0_free_microcode(adev);
>   
> +	kfree(adev->gfx.ip_dump);
> +
>   	return 0;
>   }
>   
> @@ -9154,6 +9267,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>   }
>   
> +static void gfx_v10_ip_dump(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	uint32_t i;
> +	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
> +
> +	if (!adev->gfx.ip_dump)
> +		return;
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	for (i = 0; i < reg_count; i++)
> +		adev->gfx.ip_dump[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
> +	amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>   	.name = "gfx_v10_0",
>   	.early_init = gfx_v10_0_early_init,
> @@ -9170,7 +9298,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>   	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
>   	.set_powergating_state = gfx_v10_0_set_powergating_state,
>   	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
> -	.dump_ip_state = NULL,
> +	.dump_ip_state = gfx_v10_ip_dump,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
> index 1444b7765e4b..282584a48be0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
> @@ -88,6 +88,8 @@ struct soc15_ras_field_entry {
>   };
>   
>   #define SOC15_REG_ENTRY(ip, inst, reg)	ip##_HWIP, inst, reg##_BASE_IDX, reg
> +#define SOC15_REG_ENTRY_STR(ip, inst, reg) \
> +	{ ip##_HWIP, inst, reg##_BASE_IDX, reg, #reg }

Mhm, do you still get the warning that we should use ()?

In general named initializers would be better. E.g. something like this

{
     .hwip = (ip##_HWIP),
     .inst = (inst),
...
}

But you need to give the parameters unique names for that. "inst" for 
example won't work like this.

Apart from this looks good to me,
Christian.

>   
>   #define SOC15_REG_ENTRY_OFFSET(entry)	(adev->reg_offset[entry.hwip][entry.inst][entry.seg] + entry.reg_offset)
>   
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> index 4908044f7409..4c8e7fdb6976 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> @@ -4830,6 +4830,8 @@
>   #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
>   #define mmGB_EDC_MODE                                                                                  0x1e1e
>   #define mmGB_EDC_MODE_BASE_IDX                                                                         0
> +#define mmCP_DEBUG                                                                                     0x1e1f
> +#define mmCP_DEBUG_BASE_IDX                                                                            0
>   #define mmCP_FETCHER_SOURCE                                                                            0x1e22
>   #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
>   #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
> @@ -7778,6 +7780,8 @@
>   #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
>   #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
>   #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
>   #define mmCP_MES_GP0_LO                                                                                0x2843
>   #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
>   #define mmCP_MES_GP0_HI                                                                                0x2844
> @@ -9332,10 +9336,16 @@
>   #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
>   #define mmRLC_LB_CNTR_1                                                                                0x4c1c
>   #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
> +#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
>   #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
>   #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
>   #define mmRLC_PG_DELAY_2                                                                               0x4c1f
>   #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
> +#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
> +#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
>   #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
>   #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
>   #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
> @@ -9720,6 +9730,8 @@
>   #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
>   #define mmRLC_LB_CNTR_2                                                                                0x4de7
>   #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
> +#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
>   #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2

