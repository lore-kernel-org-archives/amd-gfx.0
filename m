Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36602C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2B310E70F;
	Tue, 25 Apr 2023 12:34:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00B410E70A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI/QB2oRsgPv3IFoqVhfsTYweWUaE3NcSBLxD4qI0ecDt0J/YDFeAYNfjesEBFsEWIQDWvI0KKlvlXAuh0Z8H93gu8FvYVxoZNWj7kvulFYQ+C4vKFjd7I4W+OHT/6c+hmX8nv9xhsna+z1GPJwCGuNI0RjYspvLgwOavuMO2wAGnwdQfZVTChvzDI1IieWskaSQVvaZa9H4BPODBkIfSCBM+3c+//Iit3qUA9Xr0F7yCQTI80nkxisxn5mLLr4L93UPS5rKkLV+mnp4QRe+CfrgTPZCtbIh8uech4cywNiojLMpEpbouSL7+ZaCZ9lKiVUSS4fu/BqrObgr3EKS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki9hsztrGYMPgWKl1wQY6ulG5zpVR1pfOj62pKUs+sk=;
 b=Qv8hj/CZuZrZ0/dkE15/b24PHTtFkYWQurfu4xYcQksJBBINAFy3ZE3+bn8P684xFq2o79Oa4JZbVxMh0LQ+eOhIsVdRzCpBsgwat6lhFgeOpS9RxPPj3bFxNYEPfLqFWRr4mltbrMUaJ3IHXpr+KOEb28DeV9Ygq0XbtbaeSn7rFJwlas3sNgohutb6DsJVVzKQVz4lJ0rPy278FJSNtzM6Qy6y2QgNKEpgB95qQbC7pMpaPyjD2bVcnq6Z/DFBXi3qBd8vSlLP4VjbsDi78RW75qF2WWSnDjGX+ZEVoSVHj2zQEwyEkr2pc04AqcVwgb9cKoIHlDwNIJMI8hjn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki9hsztrGYMPgWKl1wQY6ulG5zpVR1pfOj62pKUs+sk=;
 b=P3/6hj8Z1XRzHIsknHKF+hzjECIM19RhvHNl3P+rvxEtc1sSYXTUKf+1fT4DClAeE5VkwJWfduYJ1W1fsoDvl0A8vfa1ydgiSAo39urnMn1Gvcdj4NVYT+zGhfaiNfPoT5DGFmmEDrR07hJVILNqhGZUxHkwgOGHU9x6kkGiMUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:34:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:34:31 +0000
Message-ID: <bd98e48e-652a-8649-d2e9-f3c90d710f0c@amd.com>
Date: Tue, 25 Apr 2023 14:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 07/10] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-8-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-8-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccfcb96-37d4-4aa7-4bdf-08db45896b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwSIJnXu1PrAY778uMh/xJoAxKhUFKY7zg+8oB2PQziflx/1eWHaShswn6WOj9A7B+c3CXr9SOr+FBXkj0gwjYh7Q4HRcf+5x5leGNMkk1utLRHVPlvbwM4E9gQH7SSQ/qY8swnR1F1xj11WEtdZfVMok28rNGKGcAIEiG8DOpE/HZXF8D/aJpk53DSb3wsfwm7HbHczauqE+w4GD/A5+giz+AdeHNwx5Zri/FVn3ls+0m5I/c/W/xQYgRf8ZS2lSJaQAEUlWUf+8nQEHUqGgttwkZx33o0Uk/ESDM+5o2BYND1/GI1hUvceM6FlhxbYPe+beas44VV3hzohiVeUpZ/kop49gvhoTsVU1Tp0/YVZbd3FMgMM46khJyAaXMjuSXfIF+RBd+d3BBqmWicoWDlC4XVCzEpST+qn0ThsMuG4831pHzV65IXLePmNmvaRPPdPDxrDbhVQ32/zqmQSuy8nPfAmXUC5vqyh7Kj+LuEXwmb/mDz4GQ4jcp9mjAmCB7T5eQe2PmFHamP0nWU04+ufbEsxTxp7HGOWYcHWW2jgG+e5nAQ9Gou4296OaIxK0EH3n2m7NkXIKf0JPWpg7bLRi3MhEGXHPdy3VUS0XJ6i8O5w+CuYkX5qg8QrFap1bnycu9p6qkuCSoCg4ekGTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(83380400001)(186003)(6512007)(6506007)(2616005)(38100700002)(86362001)(31696002)(66476007)(4326008)(316002)(6486002)(36756003)(66946007)(66556008)(478600001)(6666004)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXRYQTZxRUZnN0MyaEdiTWpOVzBUb2NyK2ZSSllKbE5ua0hkWDMwci9GUm1D?=
 =?utf-8?B?WExVVlNqaFZGMnVlVjEzUFluTHc5RTFlKzdTRUIyVVhEQStTMGhKLzFpUFYy?=
 =?utf-8?B?eTlPQXVjV0JsWGMyUzU2OHBid2lOUklLcmc4dENoRVlSVGEzMXhyTDZjT0JS?=
 =?utf-8?B?VTNZWkFsbVVNdDZ1R0FiWmJ5L0pNZjU0ZlhpSkZRaHY5NXVUMDI0TDhOYlpx?=
 =?utf-8?B?S2REMjdTdStHUjAzRGt2QnFFS1dBMzNucFdWRm9CamJtV3hwTE1UTFVHdHJv?=
 =?utf-8?B?eWRvUjNNMzY4UEsxajg2M29NSnJwdTZiN0hvM2lzRE5HZkNmUFRybEtDTHZ6?=
 =?utf-8?B?U2YwRGwvaUNtenF1RmVUOUQ1ODJLNTV2Y0VxUGRSekovUHVkVEdEcDdnbHQ4?=
 =?utf-8?B?aUhOWHppa2tnTkpvVnovUlhoOU9maS9CbTZMLzhiT0dFc0d5SFNFajZvTC80?=
 =?utf-8?B?NUtvWEUveG1oZnB2UmhHb2hUSThOMFBuYVRmRlpwMXNack9NWkttRDFCWmJE?=
 =?utf-8?B?TStidlY5N1N2b2RFUjI1UCt2Y3pQT1hoMkp0OTVIcUc1NmZ6M0FpditBV3ZY?=
 =?utf-8?B?bCtCVERNYVVzc1lOMGFsUENjY1ZqbE9pZE1JdUpNVkVtTUV6VjFpWWl3cEsr?=
 =?utf-8?B?clBRUWZlYnR5eVZ6WFh1Z0U5YzdHUlZzQVI3cjNqREZGc1dlbXorUUVHRmhH?=
 =?utf-8?B?bWRORS9jZ3BsRFhlSXdvRy9aV3ptM0RscHI1YysxME9SelZsRVZEYWRDRVZ6?=
 =?utf-8?B?UDJOdncyVkowV0Y0c0FVNkNnNm9Rc1ZPS3ovZyszV1VXVklEVGxHbXYwZG1v?=
 =?utf-8?B?MmE1T1p5NlRzRy9Da2I0Ly9CN3VSb3Y4S0dFSDNVdDF4TkhDRUFEZmoxTUxW?=
 =?utf-8?B?NWVoNmorMVl0UFhIbGREYUxFSkVzWFc2TjBkUGVlZ2hBZGVham9FZUk3VFk0?=
 =?utf-8?B?RDBteFZFclQ2Q0d0eWs3V2JzcXozcFRHVzdaZ2JKUVJuUzRlcWQrdGhhWE1t?=
 =?utf-8?B?WUdWa3Bta256VzhOanMyaDBNbVRPMVQ2c2kzZnRkRElXYk13OVZvTFpYN3ZF?=
 =?utf-8?B?bEdMaTFQaEdwQXJBYm1CYVRVOFNGZWprcFEzWGlZVFR1RVhKZWx5VnlHYWls?=
 =?utf-8?B?ZjhMaFBQYUZjVjYvam5FcUNtV1R3aWhsWTZXQ0FlVllOZzFVRmpiNE5TVjk3?=
 =?utf-8?B?TTBoUU9FSWhzYndzWHFlZkVlNENlVjNnbVMrS1J6S3V2NHlCbjNXeEp5YnZW?=
 =?utf-8?B?UHZkSy94R2ZWZE1CcGpkMnlDRTFhRDlEb1ArNVR6UVREMVlxeElMUzVoUW9z?=
 =?utf-8?B?L1NrbnA0NjZyTUtlYk1JaUJ5S2dvUnNmdDFJVDlXZTU1VUZtM0NiTm1TeGZI?=
 =?utf-8?B?bHFaM01qdHdvempQQW50V3dCT3Qxa1VhbmVaL09jVUJ1S1l5K3BESzErZ3ZG?=
 =?utf-8?B?SUlraDVFZlJJb0ZCdjBsM1hIaEwxSlQzeFVZYjIrNTZVK0pVUHlnTkl3NXdp?=
 =?utf-8?B?Zit1em5iNjlpNWJWTlNxSmZGenVKbmZTMjJpbE9FbStxcDFwN3NuSzc2elJS?=
 =?utf-8?B?bi9aUlFIK0pSaWtuOVl4S3g5bTJPcWwxaFU2MzEvVTNDWU1IWEFYdGdxSnhq?=
 =?utf-8?B?dUkyZHBkZy9ReDcxc0hVVTR2UFp5ajBpelRYU25icWRuWXZsQmFZazFPc0JS?=
 =?utf-8?B?cm5uZ3dkM015K1pXV3lOTW9YUm9CWGVJSndpa04wdCtKVVJvRU5lSnBRWTdB?=
 =?utf-8?B?YTU1bGJZRkdkbDIxNnExQVZ4WEJZbUhRWitqWmFhU2lGVWRVbERjbGtQeWtD?=
 =?utf-8?B?MWhUdi8wTmxwcjhXTi9ZOXpReFhsalFSSlN0emw2Y2NhOFFldDh6dkdHYjJ3?=
 =?utf-8?B?ZDFkMVJhSm9KcVk4UVpXSjhxTTJYbmE2OEY2WitxWkFCV0VZeWg4a0dmSE1X?=
 =?utf-8?B?NUV6dXF2ZnM5M1ZFOVIzbHBaSzdnNWh3OU1MVFBXU2srankxTzFwUUtDNmoy?=
 =?utf-8?B?bGlVVy94WlYyMnZudGdCSEFCR2pNRFE4Z2s2YTlRcjcxNGs5TGI5bXdTNFdW?=
 =?utf-8?B?QTcxb25BR1pBaTVMNmtRQTQzZ0hpWmhCYzFsa3RHeTM4OE05ekdJeklvNHBt?=
 =?utf-8?B?cWNOM3cwY1J2YVJoNEg1Q1dxUmtkTkRycUMxV0p5cHRoeHp1aUo3aUx2RWQ1?=
 =?utf-8?Q?Q835ZuG5DCQmCfWNb3xbtNsmLedeWMTqu+ju6GhZ8Ud9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccfcb96-37d4-4aa7-4bdf-08db45896b58
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:34:31.8608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVA5SsZyP2VmU/40lI4QrjpiqkCGerekMkHuGISPtGgxu/kc4xBdsSRu7PzHT5n+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> This patch adds new functions to map/unmap a usermode queue into
> the FW, using the MES ring. As soon as this mapping is done, the
> queue would  be considered ready to accept the workload.
>
> V1: Addressed review comments from Alex on the RFC patch series
>      - Map/Unmap should be IP specific.
> V2:
>      Addressed review comments from Christian:
>      - Fix the wptr_mc_addr calculation (moved into another patch)
>      Addressed review comments from Alex:
>      - Do not add fptrs for map/unmap
>
> V3: Integration with doorbell manager
> V4: Rebase
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 67 ++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 86de35292f69..7a45d68091ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -31,6 +31,7 @@
>   #include "amdgpu_smu.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "amdgpu_userqueue.h"
> +#include "amdgpu_mes.h"
>   #include "imu_v11_0.h"
>   #include "soc21.h"
>   #include "nvd.h"
> @@ -6411,6 +6412,64 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
>   
> +static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
> +			     struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct mes_add_queue_input queue_input;
> +	int r;
> +
> +	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> +
> +	queue_input.process_va_start = 0;
> +	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;

Could be that this is wrong. What is that value used for?

> +	queue_input.process_quantum = 100000; /* 10ms */
> +	queue_input.gang_quantum = 10000; /* 1ms */
> +	queue_input.paging = false;
> +
> +	queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
> +	queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
> +	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +
> +	queue_input.process_id = queue->vm->pasid;
> +	queue_input.queue_type = queue->queue_type;
> +	queue_input.mqd_addr = queue->mqd.gpu_addr;
> +	queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
> +	queue_input.queue_size = queue->userq_prop.queue_size >> 2;
> +	queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
> +	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);

You need to implement some mechanism to keep those page tables and all 
resources in place.

Christian.

> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r) {
> +		DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
> +		return r;
> +	}
> +
> +	DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
> +	return 0;
> +}
> +
> +static void gfx_v11_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +				struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct mes_remove_queue_input queue_input;
> +	int r;
> +
> +	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +	queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
> +	queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r)
> +		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> +}
> +
>   static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>   					struct amdgpu_usermode_queue *queue)
>   {
> @@ -6507,6 +6566,13 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>   
>   	gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>   	amdgpu_bo_unreserve(mqd->obj);
> +
> +	/* Map the queue in HW using MES ring */
> +	r = gfx_v11_userq_map(uq_mgr, queue);
> +	if (r) {
> +		DRM_ERROR("Failed to map userqueue (%d)\n", r);
> +		goto free_ctx;
> +	}
>   	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>   	return 0;
>   
> @@ -6523,6 +6589,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>   {
>   	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>   
> +	gfx_v11_userq_unmap(uq_mgr, queue);
>   	gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>   	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>   }

