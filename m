Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F1EFD874C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 12:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E35E10E3D7;
	Tue, 17 Mar 2026 12:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ynYqJQ7E";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE18010E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0h8LGJH4QePoUGreB6cvAaOUKAPn/mqV9OJDlF+Rx4eC70UVPSfxEo2LhS51tdGgZAQtoo5DDPfIakVeQ6qwUGDaHug0ua6NkCOr8DHQW8UclrKvD8zlag8d4W7kOLIlWWXctsg/AOms7woeltaH2HW5BTfkWzUueWzrcdvf0fnsSmss//1QdhicC0N7h4mxXVmcRPtaf307NmTNaJrkeCLKi0Ns0dgkovjFLXuSawuc6ampnDsFRyCOJuDi+QU04GGBfRmYY/OAQ6G58eD43mCwU7oJ6yuEZ1WGYHYIVdIfCFa1DVfuznQK58YGcuSLAM5rN9gAHM8pVvoslxfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4GLWiYu4rozlV+5324cdbbprVnRfQatWBeVmRdihk8=;
 b=ccZ68HQNEyHpShCf5pabRcNi1mdxQad1Mgf2nYGtFMOvHX83aQHw4Wq5wWd7y44CF1ioKojIEI56qxnh2yZMZRGDWM0YLUBIrKCeD3HOShjF8S0AF9TnPU4ORyKMBOJ5pKVhXZxi15PBzloFbeBY/WInB3Lp10iYSOK5AIgcI/M8J1lD7RnZ5e+GkrqlTOcwKw8fyoolGkPFTPGJ87eQnE1GlDt4aghS4QEhUMeItTHdn9+wX5x6/UMrkPNWSYZaFk9cPfWccGbSCCC5K3nA/rFuWfQWDAse3kfWBME7bcMcxOd7z0lM86kwr+ruc21I0Xf1IuU5+Srhx8ZvSmzm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4GLWiYu4rozlV+5324cdbbprVnRfQatWBeVmRdihk8=;
 b=ynYqJQ7Etj+etjuFKodOQcWYXMhGpBw+a5eSKoqGNGFAgfNXfWmurWF21I2lqJcGLvrtdgEUCN+keUANdyfwkNeOQAKOCNiv17er0CxOBhrrDfgDf59cMiKXIFsQ6yT06W6jzBNzDIvu7TBOkNP0mBL20c046TD0OQGhXxOa+6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Tue, 17 Mar
 2026 12:03:51 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 12:03:51 +0000
Content-Type: multipart/alternative;
 boundary="------------LNMpPZI6UUeaoOyspvkYmPMf"
Message-ID: <d51093a6-859b-4326-98df-750113541eec@amd.com>
Date: Tue, 17 Mar 2026 17:33:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] drm/amdgpu: WIP sync amdgpu_ttm_fill_mem only to
 kernel fences
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260317105501.21479-1-christian.koenig@amd.com>
 <20260317105501.21479-10-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260317105501.21479-10-christian.koenig@amd.com>
X-ClientProxiedBy: MA5PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4c8144-f0bb-46f8-7c39-08de841d40e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: S+s8wfbIX7XGq7o0U4PBTbONyCibcMqRDIU/+RtVnxIYtmv2CRf+GuaIAA8k93KSuuaobCEOPGpvNVwUFiXr688GiHULKrm9mSkHQ+piycFUPqZV7cSmZBOH8Bx3EW/VfLE89euCJDwEpOxwFkguD9HHUODb6OlWmiesm+k9XIaQHFUg1RU1JXffAeUcQz0RMun87g5lLJbJSaol9VLuyjFuOT1JTvjlXrJgLt8MQw6WMB2IkmhWOlUcPthxBtNJSAEDpwReRjjQ6Bi3xcRzdfhEb4K+bBHhBKQ8Ps8UzFA2d45GmroyeRrxgiWWm/bTpSbdG2J4LjxdvATpFDH7rbT2LB19JKW0d/O5ebiS9S6utvMF/vTgnxswAGqYC8bQxowQXeEpyKaskIluUTQVhLId/Q1tT7U8jcAdDJGPT1alLW7Q+UbIch1EwQ2vnqdhvLZoGtsZbetxJXAxANBcsj4QptcDg8hsMZa4rAvUjunuu8/t5jydBXuLAWUCfHeebbkuqEBbAxncmmUc7N9D2jZ9mWaBUi60umgkqHkhFiGJosKge5dCjifiZ8Y5HAFNDa11KgDCnE71xwJx66P8LjUsvZc5nend4C0VHkqsJLPWDelcMt881FJctFuDLdVA3lrzHj4/rwr8xIHEivcRSs3qouGVC696lVfa7DUUG61iLVuNEIcxAQrp8qKiBj6aMEMs4Al/HhPLiWJlqBVyckP9lfAfCb6S53A6xZsQRAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThYZkV2S0JCWHFRVlpUdmFKYjdVMUtUdDBRcGQrNXNqVHdjUmt2NWlHTmMr?=
 =?utf-8?B?dHU4TjVKSGRNSEp6L0ZiK3g3ZkJlc25FODNkTXZiQ2d1NzIwdEl2bUt2dWRS?=
 =?utf-8?B?QmRKSVF2dThUd1l4OS9SRHlDMXZRV1MweXk2MUplTlV1dGVPbWI2ZFBJUUx1?=
 =?utf-8?B?bFRyRlF1U2JiK0tnbThXUENxMldOVjgyL21aalhCYzg0SmwvamtFWGRMTWZE?=
 =?utf-8?B?MDlGRzBTVWt6aEwrQmg1OHcyb2EyQWVrbndsZDN3SFBmSDZFOTNtYW11bU9B?=
 =?utf-8?B?QkpjRjN0TExreGE0NG9xTzFvbUtPbjU5MjV5UGh5dzRmU0xOTlQrbGlLcFM0?=
 =?utf-8?B?R2VUNU1DRDFiMnI2czR3cjk5Z2lLVzcvT3NibmozYUZmcWZaTDVQRk5rS0JE?=
 =?utf-8?B?NlFFZWF4RjVsNXpZaUVUTmZId2RReVF5cXN4djJGMDA1SDRaY0VaQzFqUDJU?=
 =?utf-8?B?bCtsNUx0T25IVGowSS8zY1Y0V0JEWkNNUDhEV2h5cVJ2WDhhNFNsSHQxVTdD?=
 =?utf-8?B?WDRDRDdqKzlUQVVQTytnTWpHVXZUVkM4REJWY1hGZ093OTllbWhlV1pVaW9s?=
 =?utf-8?B?aVhaWTE2bW9HZk9uUkdTWUUydDFUOHRjN2lyQ0ZoelFoZStaVkdZNncvQ1cv?=
 =?utf-8?B?YXB0bHZVWW91WWg1Wk9aU0o5cXVUeTBoSnFhdFZoZW9EKzEvMWVzc1ZBWEJn?=
 =?utf-8?B?b016R2lJTnlsaGtERytnT2hXdjNnUGROdWp4WjBLa1VxNnBCcStETXRSRDFQ?=
 =?utf-8?B?dDVqQUxCZlBrSTA2SmxFeGc0YXVMVlBnWDVqa0tpbmluaUx3NXBmbUhtY1pL?=
 =?utf-8?B?SFIwbDg1eHh0RHZ6SlhucGdRSUkyZlBJUnhqYTBOZ01zM1dWZzBwZEwwSWgr?=
 =?utf-8?B?Wmk1U2J4RTQ2VkxYKzRrdkdZNW1lRkNpbnd0QWZjN0J1OXJFQzFlbTZmZ0hV?=
 =?utf-8?B?QzZscEpIUnd6Q3dVOVNkTUNDSXQweDRqRWpuUnFpWlhQRTJpZHV3VWcvRzhC?=
 =?utf-8?B?c2NyZUdwa3JOalJVVFVlS0FSaS9qUHIwNGdSUkJ0cktselJVTDBJYWY0cEYy?=
 =?utf-8?B?RENaNnVUaVRFeEZObVpXSWZSRGdmYi9XQk5RT1lEVm9wdDhaYWlwdDFLNzB6?=
 =?utf-8?B?ekc4Zk0ydUlyNk9WSTQzY2NZK1dnVFh2Z0NPMjg5V0Yrdy8xOTFnWTQ2azRz?=
 =?utf-8?B?alpRUVdpRlJ5bVdGMjJqNzY5K2tuUHBKYkMvVWYxZWNVVzFLeUJHQ05uNDcz?=
 =?utf-8?B?eDRFMW8xa2txRkxRM0pudjBYQzhaRGh0blZ1WHRXS1BqTEE2VkgrekdIMUlu?=
 =?utf-8?B?Q25PbTlNTHBXck94TzY3djViUTdsQnNZRkoyb21NeWo5OVB2OXdjbFg4KzFM?=
 =?utf-8?B?dEVvZmltKzl3ZDU3Y1YxRG5IVjNGbzN4eTcrR1JYRkY0Qi81Q1A4SXdLVUtq?=
 =?utf-8?B?ZkhTdDRxZ2N6ZGhKRGRlaE8rai9OQXlxbVFleHY1Y1VVTGhKRlRtYjR3eStv?=
 =?utf-8?B?K1JrYXpVQ01jN0ZUT2lpYndhWnJIUm5BNllrbEVEN2x5SEk4dHZqYWtNeEcx?=
 =?utf-8?B?T2szeGlIaHdGWjlPWWdyYXY4UnRpaDJUZFRWOUVNL05YYnI4bkRsMEFtNWJv?=
 =?utf-8?B?VFBWS1U3M3RGeWdLdndUZkFhNm5JN3JUeHBoZXB1ckF3Y1BNQ1RVODJMd0R6?=
 =?utf-8?B?ODIrU0hWWm5HWDNiS0JEZmhhL0hhWlNieHNWNUtxb0luMlh3ekdGSW9YUVZ0?=
 =?utf-8?B?YWc0aFNxTEM3U2lhUXp5MHdmOFdlTk4raGRVUE1sQzBxbGZ5QVk0N0xjOEZL?=
 =?utf-8?B?UEtnVDhhT1NkazVBS2dPcjc4Qkp3NlowSXB6RE1MRDQ4MXlkTlc2QVBmckVF?=
 =?utf-8?B?enlyK3ZkRVdMbVpHUjRYbkFsVnZ5V3NqTTVOYkZwR2liRjRsS3VRQkFWZDhT?=
 =?utf-8?B?TzkzNjVDWjRpNXBEWUxwTTBGbjI5K0xNQkhvRWc4VGRlM2dNL1o3L2ZxYXhE?=
 =?utf-8?B?RDA5SElxL2RJWDl5NjNwZG53Z3hYdngwSEllN0U0eVF5ZnZUVThMWHJTdC84?=
 =?utf-8?B?WkJMdi9HWXRvQ0tCQjVJWnpsRFhabFBzV3FuNjRhMEtoS1dwUEpRVVdsMW5i?=
 =?utf-8?B?eTUyd09PTTJDMTIyZjVZU0R4eXpCTnVCcnI4YXBIcHhDOWo3dUc1NE9rM3BG?=
 =?utf-8?B?YzR3ckFBM3A3ODI0YTgvRVU5OFhvLzVHTEt4QUZxL3pBY1pGWDJiQ09CZlh4?=
 =?utf-8?B?RFlUSTZIdFlUSThTcW5Ic2NiaVNlSms1U2YwbUtpVmtkRnJrczJpNzRYRVQr?=
 =?utf-8?B?ZXdSRFlUK1M3d3F4U09JN2VYUWMvSHJSR2M2S3FteWhKS05xRzVLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4c8144-f0bb-46f8-7c39-08de841d40e4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:03:51.1877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EejcIcyaX9gaSYYRB37TSdi1cZx+woCOnE+xXg6fQQv6y48MYOv9G3avLCmcpiJ3tLSo0zuuxDWg19k6J7y7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

--------------LNMpPZI6UUeaoOyspvkYmPMf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Acked-by: Sunil Khatri <sunil.khatri@amd.com>


On 17-03-2026 04:25 pm, Christian König wrote:
> That's not even remotely correct, but should unblock testing for now.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 714fd8d12ca5..69f52a078022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2428,12 +2428,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>   				  struct amdgpu_ttm_buffer_entity *entity,
>   				  unsigned int num_dw,
>   				  struct dma_resv *resv,
> +				  enum dma_resv_usage usage,
>   				  bool vm_needs_flush,
>   				  struct amdgpu_job **job,
>   				  u64 k_job_id)
>   {
>   	enum amdgpu_ib_pool_type pool = AMDGPU_IB_POOL_DELAYED;
>   	int r;
> +
>   	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4, pool, job, k_job_id);
> @@ -2449,8 +2451,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>   	if (!resv)
>   		return 0;
>   
> -	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv,
> -						   DMA_RESV_USAGE_BOOKKEEP);
> +	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv, usage);
>   }
>   
>   int amdgpu_copy_buffer(struct amdgpu_device *adev,
> @@ -2479,9 +2480,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>   	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
>   	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
> -	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
> -				   resv, vm_needs_flush, &job,
> -				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
> +	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
> +				   DMA_RESV_USAGE_BOOKKEEP, vm_needs_flush,
> +				   &job, AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
>   	if (r)
>   		goto error_free;
>   
> @@ -2524,6 +2525,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>   	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
>   	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
> +				   DMA_RESV_USAGE_KERNEL,
>   				   vm_needs_flush, &job, k_job_id);
>   	if (r)
>   		return r;
--------------LNMpPZI6UUeaoOyspvkYmPMf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Acked-by:
      Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 17-03-2026 04:25 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260317105501.21479-10-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">That's not even remotely correct, but should unblock testing for now.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 714fd8d12ca5..69f52a078022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2428,12 +2428,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 				  struct amdgpu_ttm_buffer_entity *entity,
 				  unsigned int num_dw,
 				  struct dma_resv *resv,
+				  enum dma_resv_usage usage,
 				  bool vm_needs_flush,
 				  struct amdgpu_job **job,
 				  u64 k_job_id)
 {
 	enum amdgpu_ib_pool_type pool = AMDGPU_IB_POOL_DELAYED;
 	int r;
+
 	r = amdgpu_job_alloc_with_ib(adev, &amp;entity-&gt;base,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, pool, job, k_job_id);
@@ -2449,8 +2451,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 	if (!resv)
 		return 0;
 
-	return drm_sched_job_add_resv_dependencies(&amp;(*job)-&gt;base, resv,
-						   DMA_RESV_USAGE_BOOKKEEP);
+	return drm_sched_job_add_resv_dependencies(&amp;(*job)-&gt;base, resv, usage);
 }
 
 int amdgpu_copy_buffer(struct amdgpu_device *adev,
@@ -2479,9 +2480,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
 	max_bytes = adev-&gt;mman.buffer_funcs-&gt;copy_max_bytes;
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
-	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
-				   resv, vm_needs_flush, &amp;job,
-				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
+	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   DMA_RESV_USAGE_BOOKKEEP, vm_needs_flush,
+				   &amp;job, AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
 	if (r)
 		goto error_free;
 
@@ -2524,6 +2525,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev-&gt;mman.buffer_funcs-&gt;fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   DMA_RESV_USAGE_KERNEL,
 				   vm_needs_flush, &amp;job, k_job_id);
 	if (r)
 		return r;
</pre>
    </blockquote>
  </body>
</html>

--------------LNMpPZI6UUeaoOyspvkYmPMf--
