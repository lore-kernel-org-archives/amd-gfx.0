Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E699109B474
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CD110E9B4;
	Tue, 31 Mar 2026 14:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsFWDnwB";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DC810E9B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdNf2AWDSqtqvKRkEetkQ6L7quKvgJxayXWkipmKC7/2SdSDViwS/ydumPatWhDCrjn7t0pQrf22trnWsyiXxfvGpriJCVetZJ6tRpNvLux6p5ZS0exGhThNxXw19Spi09f4QqGU0YjunmzryJWbNJgi8P760kNMDh4q5KvrxnLaiH3VKvauFyIjSGAXUBxtxDWVoG+GTLlhUmYr/MW4xg7zJ7/zidApGQxxA5eIhhQoIi+P/nvJ5TrD/bvtOCNGCRh4NiyZvgJLiKFTxv3jyEJ6oRcsJr5D5z4jCR6ylNZvfgMQUnDO/R0BmxFF37bMx9yDmfD2zWnBTxawHJDScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYhg31BIExIiwX9kAXPEKQOeR62iR8ipuefrHkqrTDs=;
 b=BlXh6WmN7Ow2nV9AYoEiMNKG3nV+2Zxib5cLkjWaf4rPSgJYtV4c/sW5hL9bl1iQLQ6DlqhycxTD2Wp9PhD6fi6raifQxXjA6osgLw9fbEsqy50kkmFGFcUvIqyStn+rGoPMYEGmNtM1AnpDV7RALo3HcjqbvFIrfVq8+XFHUwSKuEB/z74br9j61b+gUwH46sO7vAvZvSM/qPaAbhPfZzJd5AmcFcKoHosgT/0KiZWeOUEmbkZdFc0YQc75ZDqmcb2nz2vm1PE3IzvbX5Eky/xuny60zea+9F8we0g0RmKt2YTO+vygVdiOx32E6YsSP5UdGXbw8ESA3BZvzW+zXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYhg31BIExIiwX9kAXPEKQOeR62iR8ipuefrHkqrTDs=;
 b=MsFWDnwBgJndKLntgFWxYcia7BuO+WZD5gUhzsN/hFlpuht2aPfG/JauJzwbKUf+8W40AdhFjRgARe2DC+gi6W4SYV1doKKBMjOQO0F4Kk3K1tFLrhAgJ4ll6ptvTDjgjnF4qsh+EmFDKNE3IWyz40Tbji+lG1vy7tdjkjeOXkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 14:25:59 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9769.016; Tue, 31 Mar 2026
 14:25:58 +0000
Message-ID: <a69b2393-818a-43c8-985e-410e5bba261c@amd.com>
Date: Tue, 31 Mar 2026 10:25:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] drm/amdgpu: Create hqd info structure
To: amd-gfx@lists.freedesktop.org, alexdeucher@gmail.com
Cc: Jonathan Kim <jonathan.kim@amd.com>
References: <20260327203152.1578828-1-Amber.Lin@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20260327203152.1578828-1-Amber.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::24) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7b6000-51ff-403c-c4af-08de8f316d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: R7DkmkWoBw3aOCt+WfgBMD8V/Cy/OtB8VBDJCDt4J23RclxIheAHinF6PmOVvq7pJrsW1gSxRTNSmue19+qTzGTTaf+jIxYg5nndG27ym0n6gK5fMXpnt83dObC/Zh/z+mHuMwxrLs1rSsr2AQzVtrTEXJVYiP+Sef692Digy+WHoZqqKa0LgVfOw8/6rQJzhHMVuXNyt+FP98fhRW7jfFf7c+UXSHNCPoaGU5Tv5e7Yl7ltotnArLOhNZukd85v8U08VUJ5Z5l7tUTf8xGcfxzKsowM0f8+gzyLl4Ud+GEtgrFf+bqDn2+QVFllnLLEpsDfWtQwUDW+Rh7yIUJ+rejcaNwYL12v6VOEzRO0S2BjFwddcpfuI/Omm5yfk7vyhowWZ9CngZdSRpOWhcZMF+WDxDWFBtBcJqyWSKdjtm/7bzSfacEBU9ySOingN6ZhbEUF9JQKmu0Rjj+fY/GPQjN9j3/XStpOEuEn2MKBHwPs3zqBai/5zL0BgmUT9M/OBBpZY+fP/UFrDZZfa+lt2jgfSdJiO1SScheF9ipBXRyxI1taUApuq9pm61+3G2EC3/bfaTSxdnjjTR557RML24/8DhB2ACviiE57q0653BBnw6RziKVf2uZLhDCXBV9TQ1Dto03J55cUXQElQBxLUExXx4xgJ3XQM12izsZLaPiAi0KHa6pR0PGGzpuQq4qYufAT2NwE7bkGQtfx4UoD8Cf9OyyiJZ6X8ohXoLWCZxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29QT1JtQ2FlajRLOFJDRHY3WUxuVUFtRVNaY0JaOXhJb3Fyb3EyaHduZlM3?=
 =?utf-8?B?M1VDNGsrWFA3OG5nN1l4c01GNUI5UVJQak9HbGhJa1QxRmU1aU1Pbm4rR0dL?=
 =?utf-8?B?RHJaMENmS2NML0tXSyszdkZOWjhncEFuTllZcnliYS8wNVJoRmJIYmhVTTd5?=
 =?utf-8?B?bTZmU0FZMWJnQUIyR2JDdGY2TmlNbDg4ZERhR1dza2o1NTJiYkhkRGw5dVpT?=
 =?utf-8?B?T2VmVlVJSlgrNnM4S1JhU3lTNm0wbFRyQVorVkhmdkZVbExSQnJiaTY0VmE2?=
 =?utf-8?B?Z1dnWDV6eFlTWWhTMUh6Y1U1UlJ1QmpUcUdpS2VGMVZXTWlXQm50a2FtUnZ4?=
 =?utf-8?B?UWo3aGdYSjZTNlhqcE00L1l6NlVzTm9TQ2J0ZTZWK3JicWdwNzlCcGJJYTFL?=
 =?utf-8?B?cGxaSm1tUzdPYzFqVk51RmpDZ3dCeWhZWkFycEZoN0R1MUZaSktJNVNvRVVO?=
 =?utf-8?B?Y2lQb3dQYm1wSjFwYU8vcFA3Sk53L2Znb1pEQXUrQVRnYXh3WWc0Y3hrUWk4?=
 =?utf-8?B?WFVOSHY2aWZCVVYvK01vZTN5b3BIU1pXZm1BUEZXeitidGJZWVZZcGp5QWgy?=
 =?utf-8?B?YzdkVEFKREZHWTl0Nm4vMkM0ditpeUU1VTBCVzVKZ1ZZcnZnOS9CVHdqS0p3?=
 =?utf-8?B?Q1hTMzc3WjNOQld3a1JRb3h3a0dBMnRhb3EyRnJodkFUTEZGUU1jVVJFaDk1?=
 =?utf-8?B?OHVBMkRRMGpxa1ltM0hRRnprVXc4TVVkQlAySCsxOVI5dGJBSDdpNlk2TklS?=
 =?utf-8?B?aFhLQ1BBWG9waVhkVVhUWVNYdkRxZnRUNllMOExyaWFsZ2VMVTJBOW15bUNM?=
 =?utf-8?B?NFBsb1VzTmZwN2lJbUxxaGRsMDJ1TlNadVpHV3I0SFRVbWUvN3pUUlF0MlpC?=
 =?utf-8?B?NTl2UEIwc0JRd0s3a08xUmRxQk0wQm5ZUFlTS2ZmUkxpMnFic0VueUZNNmRQ?=
 =?utf-8?B?eHVxbkVVRXU1eTZ5QUoxMHN4bHVRODI2d0Fma2VPZXl5bWFYa2dkSVp5MDRS?=
 =?utf-8?B?OFEwY0xVaTgrM0lwcWdhQWp0dU9lNGw5a2JyRDVBMjdOdXFObXUvcFJVZ3hF?=
 =?utf-8?B?YXJFeVlNUzZ4QjRHVXorZjFrRVpZelpSZ2FxWmVTdmwwOE5rUlVRM0NmUGtX?=
 =?utf-8?B?dm9ncEVuKzBjdnRTRFhrRy9HM3pLQmRSZW53S2cwMnIrZmpJdmliTlVDV1lS?=
 =?utf-8?B?aXJFK25lL0hYd2tKUGpsaCtoSXdkTUlNR2JxRlZvWkQ3LzljNDR4SVRTNzBB?=
 =?utf-8?B?N1h1QmthTnRBLzRTK0hxbFlJM2tCVDhHSXRGWGRtMHpUNmJDeThQd1pjZWF6?=
 =?utf-8?B?OHlDMU8rR1dvcWljd2lKa1M4eXVRSmMrM2ZVV3V2M2hnVW9Bc2xjbi9tenlN?=
 =?utf-8?B?YXYwVjB0bXdjYXpPRjd2V3huR3RSYjBXem1peml2d1NYcUNIaERoYS9hcjhi?=
 =?utf-8?B?NG4zVVM0VEZ6VmpaNUIwMGFsdHBUNVdobnBENnlPaG1WUkdTMWlsMVZZVytG?=
 =?utf-8?B?RUtwZTZIaFNMbTRHbjFWS0ttVDVra0o3OWNOZWpjaXZ0M0pMMGpnYlhXdjhv?=
 =?utf-8?B?ZHpoYWV3b1hxMzg5a1dTZGNsd0ZkNjVwVllTT1J0Q1hiVHBRdkFQbzcvcXNk?=
 =?utf-8?B?WTE4NE9rOWlPeUJvQjA4VER6YVRaZGJtZzl2YVJHSmppTVdZYmhveWIxM3Ju?=
 =?utf-8?B?VzRnSWgxK2cyR2czQ2h1dkRIVXNCU0tpMmZvK0FSYXlKK2tHMW1sN0xuWURk?=
 =?utf-8?B?K2xMdFJHRHRnREFDZFoyOTRtb2NDOHhtenBhNlJZSHNpa3dGZkxBNmFCYTY4?=
 =?utf-8?B?SnVmN0RyZFRQL1pBdS9qSFlOTVQzTjdQQ25FMVNGZ1VWeDNYcUF3RWRlakl6?=
 =?utf-8?B?WlNPTStWTnlDK3FheHRYcTRsSndUd05MOTdrdnRNL25TdTlPeTVPMGRCZDFm?=
 =?utf-8?B?VkdocmsxcElJVnN1T2dkejlYSzE0ZHU4RUJLcjRuU0FyMHR5MkhkcXdGSXVx?=
 =?utf-8?B?VGp6aEUzZDJickxYRG9QQTZMUmVCaVUyOG4wNFVpWUxKMTIydWVKeWNGYXZa?=
 =?utf-8?B?T0RqRjY1UUNYaW5ySDRySG8rbDN1N0Z6MTdvbzN4R3c5aWQ0dlBxZy9lb21h?=
 =?utf-8?B?dVV1UDBua3NVd3N0czJpU0VXSDl0S3RXZ1p4Vlh4QjNZUmFUTzMrdkJBbEZD?=
 =?utf-8?B?OTcyanVwN2JoWHlDOHR1dW9hR01ORWZLWUpCZzY3ejlVYTRhc2l5eTdMM3F5?=
 =?utf-8?B?ZTgzUzdDVWJTOWJWZkJSUE5UazlMc2t1RzBwSmUwUTlDZklvek1FMU5BR1hK?=
 =?utf-8?Q?GMvWxBWTFsTDnILEpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7b6000-51ff-403c-c4af-08de8f316d61
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:25:58.6891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF4k6b1wjgrTCYtTa+ZeQO+CF6KfOhpoih2plVrg0HZjAdbAoJk/aQ3QmRuoOfqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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

ping

Regards,
Amber


On 3/27/26 16:31, Amber Lin wrote:
> Create hung_queue_hqd_info structure and fill in hung queses information
> passed by MES, including queue type, pipe id, and queue id.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 17 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>   2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index f1f8bbfc31e0..436a46ba1dfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   {
>   	struct mes_detect_and_reset_queue_input input;
>   	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
> -	int r, i;
> +	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
>   
>   	if (!hung_db_num || !hung_db_array)
>   		return -EINVAL;
> @@ -471,6 +471,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   		return r;
>   	}
>   
> +	if (r && (queue_type != AMDGPU_RING_TYPE_COMPUTE)) {
> +		dev_err(adev->dev, "MES resetting queue type %d is not supported\n",
> +				queue_type);
> +		return r;
> +	}
> +
>   	*hung_db_num = 0;
>   	/* MES passes hung queues' doorbell to driver */
>   	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
> @@ -486,13 +492,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   		return r;
>   	}
>   
> -	/*
> -	 * TODO: return HQD info for MES scheduled user compute queue reset cases
> -	 * stored in hung_db_array hqd info offset to full array size
> -	 */
> -
> -	if (r)
> -		dev_err(adev->dev, "failed to reset\n");
> +	for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
> +		hung_db_array[i] = db_array[i];
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index f80e3aca9c78..2e6ae9f84db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -170,6 +170,19 @@ struct amdgpu_mes {
>   	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
>   };
>   
> +struct amdgpu_mes_hung_queue_hqd_info {
> +	union {
> +		struct {
> +			uint32_t queue_type: 3; // queue type
> +			uint32_t pipe_index: 4; // pipe index
> +			uint32_t queue_index: 8; // queue index
> +			uint32_t reserved: 17;
> +		};
> +
> +		uint32_t bit0_31;
> +	};
> +};
> +
>   struct amdgpu_mes_gang {
>   	int 				gang_id;
>   	int 				priority;

