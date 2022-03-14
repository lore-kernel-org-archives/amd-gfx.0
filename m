Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 09:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D7F10EA1A;
	Mon, 14 Mar 2022 09:43:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DC710EA1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 09:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQAkRmatvp5TjqBl88qi0L+4alOS4jS6U4Rz4vzZit9L1HmqyMp12uZXJYQf+hiElSnT4Hr3HaPBspD2CzF8ZoJOK8i82IjoOjHHyE2zTdcFP9mGStcojBbooQWCHD9ttu7UmV+Y6hz6o7CuiloEAYijRMYIDR9j3yf49ytIV5a6UhcPA3RnrLd1CIMTCLl3Xgxm0h4TnGqOJJYz7KlK0A2KaNIiSovXOSaHLU2fjCFrNFL3QmCrwuih7seoTolEDBwdvza1lamgiWi10T90JIvvOkLJOYe5N5gNTWcj6s3xHjkKxRMBh1w/fS1iZgMxa0X8bgMeByzl7KjkHELBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdEGR/dC268kTWUmiDzCMIlB8QO1zLeH4+d86+kEBsQ=;
 b=XXoYJ+oWloTb7+4Ri28uBNultqkvpdLu5HkDqsepQuc71OEG9+5ZDq/jjc3oc2dguB4+0k4HiDkJMCL9Ii9wTDF1108RqAuwGlkh56WPtR0jfbSNpAHhGqXuxo0YySmhSMF7b4Njoc3Hr5SYfcnbOMuzYHByeZP8k8Pdmz/mn9k2TGp45WcGwH324Voe4jbgscXZzl9QXfiFjIjlZ5egLSEwfatmdaigwVyY0DA9krYwcNTgSUKcbzHTk2ak4CuEEBvBGMrqHI5zJQPrwe94M6cIjuOvpwG5RMLkyIYOtrUa704aD0t+LZufpReZ8oU+WYFgHU/iz6XUyLG2jD7kfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdEGR/dC268kTWUmiDzCMIlB8QO1zLeH4+d86+kEBsQ=;
 b=YmW9N1EJteeamr6hq3pXXfUrIXvs2OrsKEvBq9DHxko8+OZ6yRI7FCOl3lHfae7oi01RjjFmzZ+sYMpmqy7ly1ZbNhJ4tLWWZdduTmKx0Hti8Xxoygew/ZLpHUBWkb/2jzzht1tXzc5Cxd/caQVNKqB8jouPKbTr/GB3559AHws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB3036.namprd12.prod.outlook.com (2603:10b6:5:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 09:43:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 09:43:46 +0000
Message-ID: <5ddd921e-1345-526c-2fbe-3662fd8a05f0@amd.com>
Date: Mon, 14 Mar 2022 15:13:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] drm/amdgpu: add utcl2 RAS poison functions for
 Aldebaran
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-2-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220314070326.21828-2-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24dc52ec-7e5c-4e8f-69ea-08da059f228d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3036:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30360D9B5411B3ADE8EED3CF970F9@DM6PR12MB3036.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bko6HdMQZ+jBtifDeZTa1CoyU3X8nKNb/oGI8wmNdqmip/P+VrJT+GDR2dINBGorGcq5P82ZVs9UqYRQeLE/kSbRi91qG9vRiXRmm9+lZnQCPaJearKyunA2NjjfbXSTMia00JtXTNo75tt7eesGCx1C8UQ6PXzWglGieWHaj+3630NCrK6NYChFN+jP/gkbnwQIu48jfcNp5b9Ubk0y4A9rsR+yGq0biHKoFjcqbaoHIAxekyKsTY64rtb4AQINuXV9DPa26u6MdSkShvs9/ls4HTE6kpJBQQmGgWs63LQlaE/Yjxdo1PQIrpnihdewetPllY9EGrA67oGb/i+Y6X4HNkLuzBrlFNt4KKM3A/2bkR5DbdgjlEZZh1RghDjH51iPyrHDAif+mmoJqW0E3Yo7+FQ0KNqsrjB8VIkLWxe6j58hZLq5TyblPPH58um1pKfasaUGgQjgTFw27HjNXOP40vPkq8GkQTtpwpy0ByosrDZWVW+go0+Hc/fJQNXBYLJLrtIazTqv8O6zFv1q3kEEgdr26GO5hrUpdKKPgivh7dwZezsh0ces7qeg0VI2WdDkn5er3RVmkjAEtRaebInMo8VYNWkrMSWThUTDLj+qLE2M+0zeYvsICXhSH0YL4zLZwG1LqHqKC7Q7KYSY1WS3KuzHe2ee2/Qkj3ixVvMSonsB5Ju2wQnif2Pj2O0jCLEs/EZGulbo7VxU9fKMCR0xhxeTmOtGGy867o1EpBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(66946007)(66556008)(66476007)(8676002)(5660300002)(83380400001)(316002)(31686004)(8936002)(6636002)(2616005)(6512007)(86362001)(6666004)(26005)(186003)(508600001)(53546011)(6486002)(31696002)(2906002)(6506007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xWSk9pQXVYMVE3czA0N1RlQmlOcFZ6alJyZmtxRW90QVQzMUtRWTQvejE3?=
 =?utf-8?B?cXkyRlBEN3RhT3p5cVczaklsbDFuUlpmeFMrd2UycHdDZUFOME4rQmtvTWhK?=
 =?utf-8?B?eVJOc25mWGhUWm01a051ckZQM29CMzJUSmU4SWthaWRvK3UrYTFTb1JvK1Y1?=
 =?utf-8?B?VjBDZ3V0b2I1b3NiNEtxQ3pXdHUvYVZ0QnNyM2NLMWtjUE0rZjhSR1M0YkVY?=
 =?utf-8?B?cEtCQ3cvZTI1Y2VLV3ZDVHdhbXpSMmlQYyt2aW51d1ZnSStCRmp2MlJsclBN?=
 =?utf-8?B?VzRDQlY1MEMwdjc2dXVGU2t6Wi9kNU5TcHBXZUtRUzQreWFaOVdIL0QwQ0NG?=
 =?utf-8?B?eDR1M1hjSEtaZUVmUVFySVR0dHhHbTBNSXNFSmVhUGxINXNRSnJTU1FKaW1k?=
 =?utf-8?B?QldNSTV2a0JCbCtXU1UwLzhQZWJ3b0Fnb2s4cy9ublRhaHpIc3NxU2RyRlFr?=
 =?utf-8?B?RnZvamtXRUhQZGVDM3ZVN1phVjV0REhrUStoU2lHV05VMkFFUlQrM1U5dVFH?=
 =?utf-8?B?TEpmQm5VbVpBQW1OSmJYdjRhcmlsTzB4bmp1L1RlTWFldjd6YURQRWQ2azhw?=
 =?utf-8?B?MExmUm4xUVpFdmlSUWE5RWpXbWs1b3AxeEZTeVpWaWNQcWpwSUQvTDhZV0tn?=
 =?utf-8?B?NURqSll2YTlkc0trZS9FM1A4UmhUNlZyL051Q2RGM2ZPM1c4Ry9kTWFvWDUz?=
 =?utf-8?B?N09sRlBJWjNoaDdMS2FFSHI0aEpuazFVcmh3aWhRMGZSbUlDYWYzdndCSnBO?=
 =?utf-8?B?VzVBU3BhUGx2YVNhMXdrSVZEdjA4Tjl3aW84eW8xcWoyc1pMWERuWEFFTFJ0?=
 =?utf-8?B?VnJDSVl1Z0J1dlhlN3BvSWdIYyswTC9KcFFoTjBzRHJLSzFWZ29OZVFiS1Qv?=
 =?utf-8?B?YW9kMVVXS2lFL1loVjNxdVVWWkVPQ1lNQ0ppOSt4cEgrNHFERmU5Qm8vcXRW?=
 =?utf-8?B?TUxhUVJTdERyVXFiSHN3YXZUV3FETURMYUJwTHRUaTEwTnJjTllpNTJJM1JC?=
 =?utf-8?B?VjJpMXZ1VDZJcG1VT2VwTnJtVUpnYmNaVzVTaWVuQ3VZNUd0ZmkwOU5NRTB1?=
 =?utf-8?B?UHAwcVhCRy9jaytNcldMQ2NKU3JyemhBWXhVSWFvSzR4YlBKQ2dIcUptMWFE?=
 =?utf-8?B?UEhHKzkyVFFmMU5Ta1g4aW5mVTRwdVVIeUpTNFhJQTZRZ216UnQybkM4ZzlZ?=
 =?utf-8?B?MnZXd1h1VDM2Y1d6VCtzMzByQzVBdlVENUF5Qm9iYmpkTUhFbmdoRGVhZHJr?=
 =?utf-8?B?UWc2ZnZLTUpCd0RCeUprYjlsZ21sbUx3aVF2N3ZBYnJsNFpiaGFtQXlqZ2lD?=
 =?utf-8?B?d2hDWkRHNFVHWThjaDZQcmVGUWg2UXh4S0hxWVkzWWFFc0VnY0RhMXJ6M01w?=
 =?utf-8?B?QUp0Rk5RcERNRlpWRDJxbzN0TmFrRzVnL1pZeStyZXdJUU92L0RaM0hpMFMr?=
 =?utf-8?B?OXBKaTNRdEhZRXM5MDd0WWZJNnJGY0VzRzZJbHA3QTBuVUdnM1hkUSs1aHNF?=
 =?utf-8?B?Z2ZQMHRrYmNkRUYyWlRzYXpyd0FSU2pBTFB3Q2NCZXRCMUpta21QcW1jRDlq?=
 =?utf-8?B?MlpNNmRqeEk5OEpXMTk4ZTRQSTZIdVJpd0VmZWxjVG1NUXloekovK0lmSWJl?=
 =?utf-8?B?cGxVTWdqc3U1b0tQeUJ0Wk8yajVBREhvYkQweFlrdzhrS3pWS1p3TEN4YXBn?=
 =?utf-8?B?N0g3bE9tdTQzbkxEdDBaSTk5Vlo1c3dnZ1M1N0ZGTjBET0REdGt4S2lGK3ZR?=
 =?utf-8?B?em01QkNpUzBnS3JlMUJMaGRmUnEzaVZvcE9XZC9ra3p1TS9qV3QzRkdwQnlm?=
 =?utf-8?B?UE9Cb0FIeDArUU9HbkxNelpBTkcycGJnTWxrb25EMnVHeDA5bG1mRmtNQXFs?=
 =?utf-8?B?VmR1SHJ3MWRGeklBN29HeTdIenpBS2xBdUN4Zk5rdFdPNlNsalpxcVpPdUpu?=
 =?utf-8?Q?06y2PMUgs0ObTSLoaiPBzp/TCbj5FAP2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dc52ec-7e5c-4e8f-69ea-08da059f228d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 09:43:46.8040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr8YLutQOB+JK9XK1STJDv+KCPjAVGmCQEnZBm3zl6dG4EIYen7AmIZJETmX2WXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3036
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



On 3/14/2022 12:33 PM, Tao Zhou wrote:
> Add help functions to check and clear RAS utcl2 poison status.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 28 ++++++++++++++++++-
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index c8935d718207..ebd7d36d099b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -23,6 +23,30 @@
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_amdkfd_arcturus.h"
>   #include "amdgpu_amdkfd_gfx_v9.h"
> +#include "soc15.h"
> +#include "gc/gc_9_4_2_sh_mask.h"
> +
> +static bool kgd_aldebaran_is_ras_utcl2_poison(struct amdgpu_device *adev,
> +			uint16_t client_id)
> +{
> +	uint32_t status = 0;
> +	struct amdgpu_vmhub *hub;
> +
> +	if (client_id != SOC15_IH_CLIENTID_UTCL2)
> +		return false;
> +

Status check is not related to interrupt. Is IH client id needed here?

Thanks,
Lijo

> +	hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> +	status = RREG32(hub->vm_l2_pro_fault_status);
> +	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
> +}
> +
> +static void kgd_aldebaran_utcl2_fault_clear(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> +
> +	hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> +	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
> +}
>   
>   const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
> @@ -41,5 +65,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.get_atc_vmid_pasid_mapping_info =
>   				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
> -	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
> +	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
> +	.is_ras_utcl2_poison = kgd_aldebaran_is_ras_utcl2_poison,
> +	.utcl2_fault_clear = kgd_aldebaran_utcl2_fault_clear
>   };
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 2f60cf35a444..78400479193e 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -291,6 +291,9 @@ struct kfd2kgd_calls {
>   			int *wave_cnt, int *max_waves_per_cu);
>   	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
>   			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
> +	bool (*is_ras_utcl2_poison)(struct amdgpu_device *adev,
> +			uint16_t client_id);
> +	void (*utcl2_fault_clear)(struct amdgpu_device *adev);
>   };
>   
>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
> 
