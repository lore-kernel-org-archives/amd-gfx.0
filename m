Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174DCF99362
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0D510F08C;
	Thu, 23 Apr 2026 10:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqeCaRVB";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30D810F08C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW+qEZHYf6VfQw4kVlPtkqr1Z7IcxUVv2+JMBEkYsUNgQRddo4qyXYRHdNGwmi7yDQ+GlGxdeCxlyuW1lnUTFHrtyZsFqLxEe9az5h96lvcwvutNvdmyIzaRBJjk3gx4TK/w3BHyt06Q9RF84g7juH1iGbfaytuy+rrh57SH9hErXD2UmRw1hpK+xfxp+VbdoyZiwUuciS42KT7wMp6K71KoXZBxj3MQIEXTFnaQI0oQFPMRhkVE+6LCdB4V3/UUCau+PeAQvdzdHOH2cqyVB+3yrU5prlzaZcnqUqkJDDGEPILVIjRTkVBu/Ha2bchWnLTipDERLuey8NXQTbAaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDYROwIWRUwvX9dyhKvgsQTUCV2Z72XnnIJVvTPcAbo=;
 b=xBr3JmICmAtmBF27wrAKN1bQwXlQLDm3OSiLuj/tDzWD7mA/0hYDrhFKybKmh5g4KrbYub6DhHnGmrdr6ngA1zBciwY9ASSpb7DVzMUakBVrYc+S8eo62f4GM0DiDMLcOvCauK2qO8jHc88jLH6v0hSPiyAln3V3X9RE1WF1nn/zuoFRtovlo8MwnIe0Hq/S/+XPxAa3PRwu3adIDkVXaRHFe/W3y0ll6bAkfJLBF4eSgrcibrvCP5oUXppOtiUTrS+tyluwSHkKdW1x5yyZIq/GUotjgf77A0QLAdGKDO6yfik33yRXD23gMTb/MdRifyxCuo9n6oM7You+Iw1a7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDYROwIWRUwvX9dyhKvgsQTUCV2Z72XnnIJVvTPcAbo=;
 b=hqeCaRVBUSXJjPXjW6Bf3yos3h5J0iIbH5ACtqUg88T5JkfgXLoobWdoCPKiNLvvRn6X45X7gVXxMoTdolu5Ua1/EYkLUPjgQ/g+oV3BYaHzqxQMsYBSVvU+HfB4NbNjFNrsxTkk+tWk+YmeoH3AgjNN3SxT6Z4f+iuBfNczl3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:47:39 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Thu, 23 Apr 2026
 10:47:39 +0000
Message-ID: <7e950ee0-f523-4f64-b5a3-a1edf8efe452@amd.com>
Date: Thu, 23 Apr 2026 16:17:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] drm/amdgpu: WIP sync amdgpu_ttm_fill_mem only to
 kernel fences
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-11-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-11-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b48ae1-87c9-4d2e-69b8-08dea125bd52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 7HKc3hEhoBq3jHrRB/AeN4swUrGRbiOy4paFUoN9uqmO0Fh89dVMiO9VS7UCGNs6AVFKn9fOPaYEK2ENiBGhT8J+xsygobvJeigzzVqf5bjjbr8OWZU/0BPYFbmiLLSUyziUc5RpiA2aYoc6FVs3HLA+buYnzgRVvylZF9hLsy1xNmropC8RVjQRO/cwq4aK7QxfIe/djZk21HH52M8U8qLZi7iMVFdLMCnhudi0ISYenyNVTulmcgy2XCL9LxsPK0d69a12U05tGz9QSYio41GV3YHlEPWOvSfBhh11Xnrd+nf3c+jiEbAs/57duWIzyb1CHuMRQzB4d5n9UgA832JgjkqMcoaTN0HAzrTqQ4KCWy37C4vCaCo7xHk476P1vvi3FdaLK/vAzI5YkiQ6DoZ+Emhm25a0aEIOaHV34V4I4tXe31VdmABSGifyUpKBzM4e/bKJ/EXRFOA8frA/MJ56ZV99Y4o6UJCC+ka7IknBUtEEKqV83KICdTIwPNyCyi4FfMM6MuPSnm3WkIb+pZHQBnejouBY2k91svbEosczuXZJbPaAcjnaSdaw4mxIqQxWU52KMVQH9GsKvPx24z7ihMft7aX+waaphySumENjHY3+xSjY3g1cVAaV606M+Aso7DZqT8Pw0uWIQpusRxZsAvb7Ueio8P0hSfiGnBFXY1YFm1GNN/sqU6/tQnS6B2+sJ/bACd56venCl/+xmNDShn5YlxpojanVffvy5o8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emUwa3FkM3pDbkdUMHpmZEt3RzhwNEJwMzZCTHhsSXlOWXFqY21JMk9BcTE2?=
 =?utf-8?B?bnRLMSs2aFM4Wm5sR3ZtRmRWL1h4SjNZdU4rMWx2R1hlOUdIci81cC9rdnNP?=
 =?utf-8?B?a2ZLQXlWV2phQWl0UjF3RE1naXEyTVR3RkNHb1FWK1NZOGFaR293Zm5UTEF0?=
 =?utf-8?B?Q0JvTFFCMWljWWtuVWZFOFVleXlOdWNYcmowMkhMMXExaUpmWkNKL3U0UGFJ?=
 =?utf-8?B?TEhVUytXbkRKU0hpalNTMkhJMUFJOUV3bTBuSDBuSEEvSUFoSktQaHBESzBt?=
 =?utf-8?B?MSt1bEJTSk82L3pFaTBkemFneTBsQ3ozNmZRVkd0dmtpTDg5QXpON0lRalpL?=
 =?utf-8?B?a2RPckZ5eVg0S3VESFBGc1I0NWdySUUrQTlsZTNyRGlxWk8xQWJoSEZ0VlNi?=
 =?utf-8?B?dmIxd3QvNHhXcTZGa2Q3OTFFanhGTlpKZGVGYURvSnNubmlkbUlsK1RpSDll?=
 =?utf-8?B?eURVL2JFZ2NCQjBpdG0vR1JEK1dXWisvS3JyMmcvb0Ywb1RzUm9zdW8vaGt6?=
 =?utf-8?B?QjRCblptcjlJT2FuREhSTWxtWTN5QlFFbjM0RCtjdlU5bEtaMldFSEZiRlh6?=
 =?utf-8?B?VmpCc1czZk83RFBJKzRjR3hyVE8wN1R3OGtvVU1ZdkdQdEhiNDNZYktsTWEv?=
 =?utf-8?B?RC8zRDVTZVdSUEJDTW5IWWlZMW04TGRGYVk0TnowTHliS2I5eHgwS0NmTTgz?=
 =?utf-8?B?K2VIVHdlS0hQQ2c1SDJ2YWFqb0dmK1NDK0ZNcEtBRUJ2a3N6MXFUVzJzNTcx?=
 =?utf-8?B?QXJITWpYYVg3WFhwMDlkaThoSThMSGtXUXRmMnFUUGs3YXhEOWxzbEdKOWg0?=
 =?utf-8?B?emF1cXJ2ZnVUVCs4d3NzNy8xbnlwR1VwWWJkd20wUE5keXgyd1FWak52RUVL?=
 =?utf-8?B?NzE2WXI2WkNsUVM5S0lOMnlHS3JoMHZyKzUyNGV4Ukx1TFRJbkxHTCtXNVBq?=
 =?utf-8?B?aXBpV3JTaDd3SGtTanlqaGdTZ3NvekRQa0dWSG5HMER6Z1BFOTQvYUZ6b3o0?=
 =?utf-8?B?V0NVRStTZTJHRnlkaGNQUFA3V0F4U2xGQUZWbmIraHFRd3p6dmhHaDBabFBW?=
 =?utf-8?B?TVNyK3h1L3ZYN1A3Zk1CRDNmSE1CZDhDWW41c2ZjWS95NGhYdGp5Z1pVa3Za?=
 =?utf-8?B?enNpYkN0eFJTMEtxR0MwTFhLMUFjSTJBU2x3UmFDemQvNUxxSExPZy9lRGc3?=
 =?utf-8?B?Uk1TSmtCYmcxRGZHaEo3MjBWU1Q3SUREMzVmTDFEL2FtK3JEM1lHTUFXVk05?=
 =?utf-8?B?aW9RN0FSMnFjMVlyNWdJUHVCMnNMZ2dLcFVqOEZnMHNnTnBibDk0RGZWUVVr?=
 =?utf-8?B?WiszNWUrdzVkL0hRSjNPTWU1dVp4VEU5Zml6c1Q4UFVrVXV1Y0c0Q1pPYmlR?=
 =?utf-8?B?OHA4aGNNcXlzcXhIai9ZWGdBR1VBNFB4Z1lHektSbEZqODZ2dzVaWnZSOTQx?=
 =?utf-8?B?WVNNYk1ZY1pQc0xtakkrcEdNNE5qTVZyWkRUb1RPNytWKzNmNWFZUllQWGZz?=
 =?utf-8?B?ZjZiNitFcUtFeWh0Nzd2TnVlQmErdG1RbDNCcllES1BHby9QNHpCelFTK0o2?=
 =?utf-8?B?WlFaS3VBTW5ucHBkU3F5b1hLUGpUZ0xwbnhxNWd0K2NXeG5TYUlDM3BDaEpw?=
 =?utf-8?B?QUVxZ2pWSytBZ2lMZ04xWCtzTjU5QkVaRjVrdGNpTmIybWVzTlMxdERUTUJp?=
 =?utf-8?B?ak5tSStvTzBQVW1NVDY0R09nS0EzbnhaSUFJOG84QTk3SG95L0ZTVkJQS0J6?=
 =?utf-8?B?dWdLemxKMXN5ckhCdUZ4MEEzVlYzaXVnVnh2Z1Q4VWlZZ1RwSFpwYlNCYUY3?=
 =?utf-8?B?S0JyaFlsbE5acm1mdm90cHdRcWIrSk5PMjRjM1NjQjVxM1F0ZFIvWngxQmdY?=
 =?utf-8?B?WmZtQ3JvMnQ2bGl5ZXlOTDlzRDZMR2dub1VHMnRzS3JMNGl0ZE9jTXp4NUdt?=
 =?utf-8?B?WFk3SG9UYXZrVlFrNWpSS1JFMzF6dUpIcE5FSFI5WEo2c0h5TmtpWm5xeEI5?=
 =?utf-8?B?aGZXUGJmSmViS1QxUUpzYVp4QzRvK0xETHVWeDFMQjBQSDkyUzMzOGg1Mjgx?=
 =?utf-8?B?d0tHeHE5ZWFHcXYwU3J5L1FvWHZiRDczZDBFekNmanJubWJ5RDgvaTBqVlZR?=
 =?utf-8?B?L1p6S2hEVS9QTHVyekYydmJWWk05SE9FdG5RSFEwckNVOTNHNHRmK2NIdFVr?=
 =?utf-8?B?T3VQcnZKN3ZJclVnOXk1Z0wwc2RSQzdIRjJUVW5uMFFaVWsxSHUrL3l0aU1s?=
 =?utf-8?B?MHkrdEhJdXl6T1FpZGR4cmlhc1o1UHlSSlhnRXovVXg1RU1kOVdkL2cvZmV4?=
 =?utf-8?B?UXdXTWhFOHp0cnI1SUFJdjh2RGR3cENVbUlQLzRSS2lOUFFvSnM5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b48ae1-87c9-4d2e-69b8-08dea125bd52
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:47:39.6714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuR63Nf2CKac7KBsULjURcwTTT949LlRdtPlUFTOlhCfp72uiRfPYrefk1v0s+JJcalB9aps7P5u94MZew4aqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil Khatri

On 21-04-2026 06:25 pm, Christian König wrote:
> That's not even remotely correct, but should unblock testing for now.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4c7d1917d9bb..5130f77b7543 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2417,12 +2417,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
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
> @@ -2438,8 +2440,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>   	if (!resv)
>   		return 0;
>   
> -	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv,
> -						   DMA_RESV_USAGE_BOOKKEEP);
> +	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv, usage);
>   }
>   
>   int amdgpu_copy_buffer(struct amdgpu_device *adev,
> @@ -2468,9 +2469,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
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
> @@ -2513,6 +2514,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>   	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
>   	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
> +				   DMA_RESV_USAGE_KERNEL,
>   				   vm_needs_flush, &job, k_job_id);
>   	if (r)
>   		return r;
