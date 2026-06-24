Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A777DCDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 07:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F327810E052;
	Wed, 24 Jun 2026 07:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gm8AT5LD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330BD10E052
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRO0Z1jdBt3UGyw0yvtpc8HTPenbnXzafSOVqGllRT2qT6HaoSmWcIKeRpVFBxESPh/t5k/dxcgrVONX3DmrzGKQijMes0Fe8YkEwSz1n451HXnSK1KT0QOQ1KX7Prkgx643etmOORMyHl2y0c8ODFJsK4mmol5sdMN4T6j+/kg3Ka9RPVg26ucEczHBs/oLcECUFEJ/yEF5bv6szXO1AubmFeHOmqdV4PhK5Piq1ow4APyvBfHScQlGCIEkwKmPRJ/hIFeUK5rZ6JinJ0VSwDiWoOc2Vd9nzMsC6cMzA5VNekIVSHTUapIawMmBmx55kwtlGQkNm5zuXnWqOcUFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOyokIuy7eXwnzI7CQRX/Bt9QWaeRQQzlo95rgxMk6Y=;
 b=rvq6QTwuulVJZiQiUeFBrcAzHXwNejZ3eJ5EoARXLXNJvUgI4zZVit88fc4iudt8HQGSgv/5jvdq/TNid7N26dcZNHxnA3R7725Vs2Gg1erNW7tWD1QasC3PH77L2R+h7KUFgZKBHoX+oFvtNCoGbla4fYF6ZNSSnmX0M1WeYEyIH/AznRl/SeXLMfL9Umexav4CxiGnREELwY9qW+bz4LRADMu/sgZiU8ovYuuQsSLaWBg/LSgMnhvBHrcPlQ9YNmRbw64PiBQC4Je4SMVwyGeOr+OPb2XR5Cx+6fwnvLOAQ4+S3qdcj3pCzNqJNX31m5ULbsaASlluXWreeVFonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOyokIuy7eXwnzI7CQRX/Bt9QWaeRQQzlo95rgxMk6Y=;
 b=gm8AT5LDiavSTPdT/0YoQl/2wu0ZG+Q43eHCb9t7J3phe+OgkuhHVzoE30Jhmxks/BCzCBIskJyHrwOxEDp5V+xbhdKhXWXKsRK28UVV+TJK2A+U5gPV1N9LwER02g+pA9x7sm3/UlJNMuOGoa6rbSUpMcDYeHUKvVCfHx7tPDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 07:14:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 07:14:10 +0000
Message-ID: <e8b753cf-3387-4486-a097-929cbcd18616@amd.com>
Date: Wed, 24 Jun 2026 09:14:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu,amdkfd: correct setting MES queue type
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, alexander.deucher@amd.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260624032608.1135223-1-geoffrey.mcrae@amd.com>
 <20260624032608.1135223-2-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260624032608.1135223-2-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d542c0c-4d2d-4cd1-7c09-08ded1c03004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: H6NwpLdEcC6xM+4j/fSp1af8VFpaEeRwoUHj+Z8PF/7sHbCxflVb77f6PfrKfSa2oordCYgLCxF9NUyON3aeRNgYUqfAp7qVedYkajPLecwtLhQStB90JLcs2RuHM7azahNiM4nLdVBqqvUk7suwtmc+xTd7p8hRy5rMqg0kRQi2QSFsj1a0hLA+K9KaEJOczG4aORtzGwmwacSVobJ6x0FvclKUjsZHminc0YPmDwGE8KGiqlkSudHEUR87Ulvy09V17JszHe5ceI5nOUetm3QBylWWsv3nmgZUoQbCu/rp1skxksUXZtguIRPAzvBcdFW9/yfQHJTdpCPIw8weC/foDOUt6w5FLKaqDQUyZ7q54Z3T6AgCi4gbCcsVjgxpWPm5Xefah/fUsh2cSJbQaYYTpWrb4N/CPOziphG8aN+H0FKU6Yxgny7umIv3PJX0hZaVw7qqZphCwS2PVyztSpmuEJRzuzFmjHrPbMH5AM18aXflePbLptyd6EZcGwmyF6YuKyw2IC6gNT3zwrpdZ5Nzymdg6cZQwz5+NEkGoU92+yJJprdSRHhsYPSoZiJUIxHNThNqoZi3wNn37sBij2a/OuRYVX2yagYCA9etCgamrkHJWEwkpwnuUwVeWkdJlyfpORDYPk2gvLrrc0GysVul9ufs1+N+WrRloh8a6f4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRWSjNUcU5Vb3ZMcytCWlVyV0U3WkdSM0pRNi9STHg3RmNhemkrYmZlMGFz?=
 =?utf-8?B?ME1jOU9DUDR1OTVuWVR4SkRzY0ZzMzBXeXA4eDdXa1NZdEw1UHNIRVhHNCtH?=
 =?utf-8?B?Zk1NQjJpd3kyYVNPcmNERHRvVTluUWRNVndSRTNmTVR4SExBUk9Jd1JNWlJB?=
 =?utf-8?B?a1k3L2VXRWZGSDRHK2tOQUNUN1BiM3U5enRWNDgrUUo1NjRBVVZsMkdZZFlJ?=
 =?utf-8?B?YVloLzYvNEcva1VKUEt3RC9yWkgvcGNUNDhSS1NUd0RDNG13Q1dwUUJyUDZD?=
 =?utf-8?B?V0pYeE5BYnNRSE9NbXV2M1lhTHFDT1M4QzdabzZ6VWdzU1hzcXNucGMzUkNw?=
 =?utf-8?B?QVordGs3RDlmbWpGcjhDbGtxRm1aa1lQMFE4dDFyeWdOQTlleDhNUnNYdXNs?=
 =?utf-8?B?S2M4dWhBZFljcmV6S05KVUxkTzdUc29UM1l0dzBnTlphK3NjdDQ3Y0NsUnAy?=
 =?utf-8?B?TmlYZ0N6dmt5cm1TYWllWjl1TWFneklxdm10UzNPVVd1T1RaQUN4bVNKQkg4?=
 =?utf-8?B?d1ZYSlJaY05CUmdDNVp4eG5MNFpDYnZtTk84bXFlWVBuT2JjdDMyZ2dYSGs5?=
 =?utf-8?B?dUgwZzR3QW8vY3NDVU9xVDJZRlg3enNDakt5UjlTblRUdUd5WEplZ1hPN2hQ?=
 =?utf-8?B?a2FJMWVHNDdKanA1NFhyMmY2aFF6Yzh5OEhZdEcrTEEvbVZFRWg3OHdZbER0?=
 =?utf-8?B?dHZ6V0d2by9hWEVTVmdkYjhWVkhVa3o4Q3pXNjRkVTFZckhhOEdSTy81NklG?=
 =?utf-8?B?SUVvQUNnenY1QTJHd0xGRUpRa2xuOXBWRmpBOEswbzAwYXR5aDFNZWNjVEEr?=
 =?utf-8?B?WXRmVTYrZENhenN4NWMxREhBaTdqdXRVeFQzRnlTamJDZUNDbFkrVHZndTBR?=
 =?utf-8?B?QXB0SjZvSjZzdWJoQjc1M01BQkRZYmNSd2VkTmJyT1c5aFcyV1U1VDFZWmFa?=
 =?utf-8?B?WXFkMDdnT05URHFDZXFMZWJ4MXlsWUFpMzVkS2xLblpYV3ZSbERZNFVNY0Uy?=
 =?utf-8?B?TGtLYllMM2lUOE5mOThlVnNETlovUTZOOCtFV2lXODRkdzd2VEFsMW9qOXha?=
 =?utf-8?B?V2s4Q2d6Y2l2K05oN05zZ0lOWVB5T1d2TkdSNkpKTWF5TTRSTityV1lZSEZr?=
 =?utf-8?B?N3BPWU9RYWt3aExyYTdGbVRiZlJUanZwWUpvTVAyc08wTnNGcW1VWkFoa2xw?=
 =?utf-8?B?M3QvNVYyUVprYk01WFZMbmdZWFowUHBJaEM4R3NUV1QzZ3M5by90a1JFZWdW?=
 =?utf-8?B?SEVrMk03MDIrYnpSa3htS2Y5c0NxdkdyTC9aTDJ0YmQ1SVQ3aXl5V3pGWVZi?=
 =?utf-8?B?ejZwbzZxWGxHc0Nyb1NiRytFaEFZVmZsZVFxVm84NE1GUEN5cUpyaSsxQVBa?=
 =?utf-8?B?T1JHVm9WZEtsRU5NWFNodTZRRi8vZEVWcUEyeFA0a0tUN3FzU285Tkgybmcx?=
 =?utf-8?B?SW5KTGlIV3dXM05yOTVrUW44cmlxRmZGUnN0R2dZVldDaDBEMklrQ2E4S2wr?=
 =?utf-8?B?anFlTkFLeGF3VnBXWGc3RTJRZWpFMlpScE1EbGtUc0R0SHU1SFBHUDZ3S3Nj?=
 =?utf-8?B?cWlJRWdMbzRGTkZ4Q1BuZEY5MGJRbU82Q2d6RE1FM2RDM2VvRWhQRHRDWmdj?=
 =?utf-8?B?YURTVU5weWJRWkNHR21lUHUzRDhGUUVEQ3d6MGkvck5SZmdZMkUrZzBjdTBq?=
 =?utf-8?B?aXRRbjFjeVZud0ZJRFVwL2hzaExLU2tQREd0TWJ6bXkyNGJ2TjRIbU5uQk0z?=
 =?utf-8?B?SGpudWV1MC9qTEp0amRGQzRreXBidzdTNFJHMXN6N2crM24rSlZ4TjVXZ2JE?=
 =?utf-8?B?QVh4NzdsVFVDRU5EWXIzWE9DNHRYNHhneWJ3bTBiUXhTcjZFNlYrdENrRHNo?=
 =?utf-8?B?YlhqRmhqWEtYbzB1Q3ZraU4rMFhSVDZyV1d3K0FFWE0yb3ExREtOUWw5aUVr?=
 =?utf-8?B?Qk1Yajd5UHI2cG5Ca1h1WW05RkpNUHJyRjdYMjdmckl4REtFTVRRblBtNklu?=
 =?utf-8?B?aFdSdFh6RVFMZVZxTjhhRVBZVUpzcUhvaFZ0Tm9nWHVFR0dDbFJDbE92eTJO?=
 =?utf-8?B?VzQ3ZG9IbUdtQmRiWmZyS3hyc0h1UEtDRExFOTBtbmZ5YklTalFUeGc0SEJF?=
 =?utf-8?B?Vk05TTNJT3dubStaeTBIZVBPaFFXYWhYTnErZVN5a2VndUJRNm9aeEp6UDls?=
 =?utf-8?B?c3JESmc0RzBDQlhMZVFvdUs5eXA3cUtLUGR5d3dYa2o3RVZKSmdkL3JWcVlG?=
 =?utf-8?B?WmRLMHZRN2k2Q0ExTEs4c2NYS3FjRWtsMlZYV0ZRaHg0dW4xNEtmUHMyenB2?=
 =?utf-8?Q?DKl2aUyTro0oqLdZYP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d542c0c-4d2d-4cd1-7c09-08ded1c03004
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:14:10.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3trDK0sQhJYjCI8XTCpf3bQfqQ2Rm5VSa7KXpI6jHGkmnmZlM2EVrijN63SdKYp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

On 6/24/26 05:26, Geoffrey McRae wrote:
> MES ADD_QUEUE programs the firmware with the queue type from the driver
> input, but MES REMOVE_QUEUE leaves queue_type at the zero-initialized
> value.  Zero decodes as GFX in the MES REMOVE_QUEUE packet.
> 
> That means removing a KFD compute queue can be submitted to MES as a GFX
> queue.  In a debug-trap suspend/remove sequence this can leave MES
> looking for the doorbell in the wrong queue class and the REMOVE_QUEUE
> command may never complete.  The observed failing packet removed
> doorbell 0x1002 with queue_type=GFX even though the corresponding
> ADD_QUEUE for the same doorbell was queue_type=COMPUTE.
> 
> Populate REMOVE_QUEUE.queue_type the same way ADD_QUEUE does.
> 
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>

Of hand looks correct to me, but Sunil can you take a look as well.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c            | 1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                | 2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c                | 3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
>  6 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 5255360353f4..dbedb1e47c3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -274,6 +274,7 @@ struct mes_remove_queue_input {
>  	uint32_t        xcc_id;
>  	uint32_t	doorbell_offset;
>  	uint64_t	gang_context_addr;
> +	uint32_t	queue_type;
>  	bool		remove_queue_after_reset;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 5ad8dd18dc67..f0f12c81dd5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -170,6 +170,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>  	queue_input.doorbell_offset = queue->doorbell_index;
>  	queue_input.gang_context_addr = ctx->gpu_addr;
> +	queue_input.queue_type = queue->queue_type;
>  
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 9e27d01cbfa3..76e6769cf7ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -383,6 +383,8 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
>  
>  	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
>  	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
> +	mes_remove_queue_pkt.queue_type =
> +		convert_to_mes_queue_type(input->queue_type);
>  
>  	if (mes_rev >= 0x60)
>  		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 20f4fd57b1da..1b0c649d97a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -371,6 +371,8 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
>  
>  	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
>  	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
> +	mes_remove_queue_pkt.queue_type =
> +		convert_to_mes_queue_type(input->queue_type);
>  
>  	if (mes_rev >= 0x5a)
>  		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 8007a6e69305..c449efa70b60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -362,6 +362,8 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
>  
>  	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
>  	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
> +	mes_remove_queue_pkt.queue_type =
> +		convert_to_mes_queue_type(input->queue_type);
>  
>  	return mes_v12_1_submit_pkt_and_poll_completion(mes,
>  			xcc_id, AMDGPU_MES_SCHED_PIPE,
> @@ -2270,6 +2272,7 @@ static int mes_v12_1_test_queue(struct amdgpu_device *adev, int xcc_id,
>  	remove_queue.xcc_id = xcc_id;
>  	remove_queue.doorbell_offset = doorbell_idx;
>  	remove_queue.gang_context_addr = add_queue.gang_context_addr;
> +	remove_queue.queue_type = queue_type;
>  	r = mes_v12_1_remove_hw_queue(&adev->mes, &remove_queue);
>  
>  error:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 9f28974f25b4..74cdaa8636c9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -299,6 +299,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>  	queue_input.doorbell_offset = q->properties.doorbell_off;
>  	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
> +	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
>  	queue_input.remove_queue_after_reset = flush_mes_queue;
>  	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>  
> @@ -467,6 +468,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>  	queue_input.doorbell_offset = q->properties.doorbell_off;
>  	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
> +	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
>  	queue_input.remove_queue_after_reset = false;
>  	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>  	/* pass the known bad queue info to the reset function */

