Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1207BE75458
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 18:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A510210E00F;
	Tue,  3 Oct 2023 18:07:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23C310E00F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 18:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atAF/etASegpNfaSmgXjknCuku4pqyFhtMId0JqL4+4ZhNytiJDKC4VaQzW1XwoFKkQrupOolZd0/kMwjS59xz+p8YVtpUlRPXkVhm0JcSz5fQbztXnzQ95kLMwqV7wCEv6oN4GockAqn6ttKiQvyskiDYjEsIjQtX9bEj2B/SeVShP/YT/8yW3NS69XZ9SOUKqfhY5OCO+NvzdTELg8NiO3vDDgmxu22VEJEAhrLr+0gUqe68lMRPNjXYRCa/4PM/npLmh/dOO+VdwBKCh+/q4o0qG0gxMxyj2bk9e2Wuvot2D2LDlpITMfmThv8HsU+AOXfyzX2iCeblWcs0oIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5kmlTLkZixpNRYPx6kJ4elkdNZ2BrG6hJGqXatgiMs=;
 b=L0d0lIehKVPAAaTNqpts7Q3tFhBISRoWkWfzFIE1MY08yd6rV8Km42lakHbarUARuOPnvIwYDslc43CvWs9FmPEfKQlI+ZDA739Kh/oyURNFHBfPaOpxSZAzVWBjkOLKqhuoKjyYZPNyo+ijoW7DTxPYBKl5zHZh22pzPAzKuqQygl2QGotxvB/EodVB+sHhGC+bE7etXHfwC9ladfHNWFUh4yFEsdmyaTdWD63GZLx2GZbVNS+4fsiJjJK6ar5Jgi44ebzsbOAL+NI6eVWFxz75/C3VCejqzaXxBT/i2Q77q24ruJZGdISd3BNe9kuFFzxdQFl2nZ7MLXeH8w0c0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5kmlTLkZixpNRYPx6kJ4elkdNZ2BrG6hJGqXatgiMs=;
 b=Pv2udX1v2OFYwaJkNAE6uLw3lmE2xa7eEd0+6zAa+lbpXipZS0M9dpVecmNstPxnCunxXNx/m/xb8UPItQHs6w/2ZFVgLN0AOIU6mydnaE4wwjSkjbUOk1FGVzmzD+NoON41S2CRqqlkEvKjM5bMVaiHQvvfsF0sDlMZF/s2jiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 18:07:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 18:07:09 +0000
Message-ID: <1c199b0a-451c-be81-a0b1-b7bc144c40ce@amd.com>
Date: Tue, 3 Oct 2023 14:07:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] drm/amdgpu: Use ttm_pages_limit to override vram
 reporting
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231002202117.2690645-1-rajneesh.bhardwaj@amd.com>
 <20231002202117.2690645-2-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231002202117.2690645-2-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4b58d9-559b-4de6-2745-08dbc43b8f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzEP4IrsWnh9hbvaSAbSB+fWz77yyhtZQBgJ+ncVXwyU89thLFUknivVzBrlt7siCr7qOAx+lqbRVFcf46xi1tPGkJRnEOaxXVATlbhEgqmWBjfPxdIY0l5a2E+j+NX7TEa1RfYfn3GItCDEqvPyODyIqJFTDcct4t3ux3vI2bvs2VXjF+V5HQQKbRroDe3NX3iiKdRYKIHyghCK19Cd+A/Ptk/Q/MwjMV3Or+dyxAWAIfOLvS4ZThQmfMe9ddUieamBismQDCkO9Q+b3VA+GQBtTNqDwpx/efflYZRi/JnSrapMoBzyRVE6o4ZiYp5XsEfMjMMKt7PvOPHweIcTDDRVLFbTjkqdt9VPheUmW2RVukrB9b/gxbgH+K8XvKwJ9qeucUqMu8XfxWDaGNKJZw1wB3mRICRpidgrBNtUAMoVpB7LXZG35POnSZGqf1yxBNshj6B7Yr48BXdyQuNomv/xMz2pFPZpZeEaqDscPWdhglU3xA9o+93PVeFcPOewyAEmWMVqU7M1+WxiksC17KAuhnTYuLMfIj5Amk+ZECT5f/bjtq500wfmuMddNmre+plgB0sBCd/xNL87NyJGpyUAvXY2UZu9DULWsduoqzBd6p+M7Rp7fnaTV52b+HKxiGcb9Q+BTdBrNFwdqZUQSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(36756003)(86362001)(31696002)(66946007)(66556008)(38100700002)(316002)(36916002)(2616005)(41300700001)(53546011)(6486002)(66476007)(6512007)(26005)(8936002)(8676002)(4326008)(478600001)(6506007)(31686004)(5660300002)(83380400001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U212L1BxTy9TdVVLakNhYnJ1azc2aFlnZVYrWHRUbndDVDBqakdPNUJHSGsv?=
 =?utf-8?B?OHJncXE4YmlkSVd1M21yMERFSDBaQ0dCdkhKOW9PVUpUcXZaY0tXMjc4OXl3?=
 =?utf-8?B?YmRvcWxBc1dWZnNRblZVUVdaWXlxbVhZaEUvYUZhdnhNMWYydkNCanpvNk4x?=
 =?utf-8?B?eFY4cEwvVnd3dmhmaWxjTUFiVHlPV1RiYitVeWo1NGZqZy9mZ3hFUVFNekFE?=
 =?utf-8?B?WlRBU29RQnVaN2RTUXoyTEdmWWFFZVBiNzh1YkRUczhDRm1OY2NaVFg3OGxh?=
 =?utf-8?B?Z3A5NklTem1yRjQvbko1bmE5WWpiaVRja2hvay9BVHZjOUI0bUZTZkhUandD?=
 =?utf-8?B?NTk1ZUhUUTR5cVhSZzV4bWpaV21kMEJkZ1gwT2dtK3oySmZsbXdlNGZuVmJu?=
 =?utf-8?B?SEhFU1VFVGNHM2lvUWNCVjJLcmVoejhqTGZSblhoWXVvVTZoclBDaW5TTDU1?=
 =?utf-8?B?b3Y3UEdWZmdWc1pXVUpoME9lUFhGdGcvWkJDSW9pYlhuZk9wY3BZRWtMYmpH?=
 =?utf-8?B?YkM1OWdrTEJCK3JlMFhYdll0bUxkV25kUW0xQXExNEt6SERnTDR3UVdmbkRw?=
 =?utf-8?B?eCswcWlXRy9hU2hERTFDVnJwNjBYd2E4YWdNbklSOEdzN08reUNvUndJUmNF?=
 =?utf-8?B?OUNLc1JMd2plNncvUVp3TTRNdmxyMGhBS3gxZy9EL0JWdEJsZmtKeU5uNTRV?=
 =?utf-8?B?eXNqNDZSVHBNbVdiUTNQWlR3c3d0ZVZWNklZdGRrVmdmRDhQbVpDTzRMQ25B?=
 =?utf-8?B?YVhxZ1krQzlSS1JDUjZkckJTK0ZYL2RudVE1RlRtRTQ0OExHKzh2a24yY3ZW?=
 =?utf-8?B?akdEQ0E2cXpENFMyWml1WlRRN1RZV0VFL0lTakJBYXh1SmZpbEN1Y3kyNFR1?=
 =?utf-8?B?czQ2S0tzM3E3L2I1UWhKS2t1QVV6T2syMS9HWEpyUERIbm1RUUVEN2lmR0pm?=
 =?utf-8?B?eTdDM09UR1U2K1dtcm5PcmNyWjBjeHFXSldET0k5VzVYMjcyZCtXVTZiOFR6?=
 =?utf-8?B?TFNITjFMM2x3dTEvMFBDbFFkRWFOM25FZ2VqZEtmbS9oQ0xWZDlJRXp6b3N4?=
 =?utf-8?B?VUtiZU84ajByZ1hWdXUzQU9mSGVlVGs5ajdUdnVrRG16VERqeHFERzBaNVJE?=
 =?utf-8?B?NzdpSHl3Q0RTUGVINElKcmZqNGViWmRMb2FkSVhoNFhtZENXMmtSK1NicnNx?=
 =?utf-8?B?ZFRMU2ppNnc2TEhRZ0MwQTFESXBiOXNmSzVJMkpJa2VIdWkzNUxkYzlTRWJ1?=
 =?utf-8?B?bmFjNHNTMHRxbHV3amFvd3pRYW1mb3ZmTlZhNm1CWDdJYnVoQlpUNTNFc1p4?=
 =?utf-8?B?SUwrRmFoWlAvclBvc05qVEd4NEQwQ0d1N2UwUTB5dG1WZnV2dVVSb2k3Q1ZZ?=
 =?utf-8?B?S1BPSWtWY1pIUnJEWk0vbUZ5VTJGWThXMnRDSEQ0Z0tPQWtnejI1RUIrZ3Vy?=
 =?utf-8?B?NVhUeS9yQ1F2QVhUMW5ZSmZOSGNCdDhENXk3dzduS05ySldmYnUraFZoS3F2?=
 =?utf-8?B?ZDZoSGxUdUw0NnB1cmUxV25aNFJBQ09yVzZ3MXpTbmo5enduKzFkMDhzdXA5?=
 =?utf-8?B?Nk9HRWlkckZQWHdnVm0wNUdDcU5Oc2M4WTZ4VGI2SC9tT3h0eUVsVHpPaEtN?=
 =?utf-8?B?VURKK0hKVmFMT0FiV1ducyt2UmpKcU5Vb1VyQjJMazF5ZVo0bFFBTS8xNjJH?=
 =?utf-8?B?dXBUY3Q1Qlh4RHFvL0tWbDZuUHI2ZUVCSFdhZkR3Uy84emlKN3lsMlgrUW9E?=
 =?utf-8?B?UXVqRTJudjJTNWd6SFZrenpYWVpBbWdhcytwazJGaWFVSEpZOXZXQUtITlhD?=
 =?utf-8?B?dDhndTVJNnRuYjRGRWRwRXc1c0g5MlZ5d3doNlZnN25FMkswTGIrT1JTajhL?=
 =?utf-8?B?QkQyT3ZhQ3dOQng3Y2UzbzRiZzEyVEp4TDVhK3QrRTBmblNDV2xBZWY2S0Zh?=
 =?utf-8?B?aWdrV2hTZE9IaUtsSnlBZU5UZlFnemVTMTZhSE9jR2VDTE0vbFBINm1jVDBJ?=
 =?utf-8?B?ZUhXdmRLQXozbk1yc1FMSnJabUdDcGhzbWppajB6ZUJoWkl5NWxYSXplWG5k?=
 =?utf-8?B?YkJxKzFxakVGYTBPNy9RTWx1Yk81N2Zyc3hjc3Y5K3RyK0FFcmZkNUlIOXJj?=
 =?utf-8?Q?XjMsBCiwtovJdzGNsPBbfOGLX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4b58d9-559b-4de6-2745-08dbc43b8f42
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:07:09.0165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFHSqy1oUHuzwS3LbuQyWwCG2HWSfScJTIn4FORzDhY3s0IVosI82kT9aDq9rTdvRRREh9U0MHH82nxsfKNMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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
Cc: philip.yang@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-10-02 16:21, Rajneesh Bhardwaj wrote:
> On GFXIP9.4.3 APU, allow the memory reporting as per the ttm pages
> limit in NPS1 mode.
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 17 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 +--------
>   2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 38b5457baded..131e150d8a93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -28,6 +28,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_dma_buf.h"
> +#include <drm/ttm/ttm_tt.h>
>   #include <linux/module.h>
>   #include <linux/dma-buf.h>
>   #include "amdgpu_xgmi.h"
> @@ -806,10 +807,24 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
>   u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
>   {
>   	u64 tmp;
> +	int num_nodes;
>   	s8 mem_id = KFD_XCP_MEM_ID(adev, xcp_id);
>   
>   	if (adev->gmc.num_mem_partitions && xcp_id >= 0 && mem_id >= 0) {
> -		tmp = adev->gmc.mem_partitions[mem_id].size;
> +		if (adev->gmc.is_app_apu && adev->gmc.num_mem_partitions == 1) {
> +			num_nodes = num_online_nodes();
> +			/* In NPS1 mode, we should restrict the vram reporting
> +			 * tied to the ttm_pages_limit which is 1/2 of the system
> +			 * memory. For other partition modes, the HBM is uniformly
> +			 * divided already per numa node reported. If user wants to
> +			 * go beyond the default ttm limit and maximize the ROCm
> +			 * allocations, they can go up to max ttm and sysmem limits.
> +			 */
> +
> +			tmp = (ttm_tt_pages_limit() << PAGE_SHIFT) / num_nodes;

I don't know why you need a local variable for num_nodes. Just divide by 
num_online_nodes(). Other than that, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +		} else {
> +			tmp = adev->gmc.mem_partitions[mem_id].size;
> +		}
>   		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
>   		return ALIGN_DOWN(tmp, PAGE_SIZE);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 268ee533e7c1..b090cd42f81f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1896,15 +1896,14 @@ static void
>   gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
>   			      struct amdgpu_mem_partition_info *mem_ranges)
>   {
> -	int num_ranges = 0, ret, mem_groups;
>   	struct amdgpu_numa_info numa_info;
>   	int node_ids[MAX_MEM_RANGES];
> +	int num_ranges = 0, ret;
>   	int num_xcc, xcc_id;
>   	uint32_t xcc_mask;
>   
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>   	xcc_mask = (1U << num_xcc) - 1;
> -	mem_groups = hweight32(adev->aid_mask);
>   
>   	for_each_inst(xcc_id, xcc_mask)	{
>   		ret = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
> @@ -1929,12 +1928,6 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
>   	}
>   
>   	adev->gmc.num_mem_partitions = num_ranges;
> -
> -	/* If there is only partition, don't use entire size */
> -	if (adev->gmc.num_mem_partitions == 1) {
> -		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
> -		do_div(mem_ranges[0].size, mem_groups);
> -	}
>   }
>   
>   static void
