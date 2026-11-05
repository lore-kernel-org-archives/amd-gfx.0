Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC50606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Sy7xPJt2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6200710E8EF;
	Thu,  5 Nov 2026 03:49:32 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A06910E8EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foJ99VpFLNmV3BAD3vRQwlnNXmTQihDUHC0M+s/Bp230ZLSKA9cINsl0uhbjAwOO6TSfUBQjG88HpeFzRjEYbhd7SnUc22uecxIneolg43XrslogrpDCO/dEpw8ivBXX8MmFZm00LPdtVRp9L6VUXvrm4xxrYon8a/juBX+tZxiTjo7pSvVFwao5kUA7XCeP3Ls5nEY6doNVPD78AKRO03rqvp+eDtrE+zUlqg3OlHUlltOsj1LU9MzF4P/Rc6ZQmeb41u7LeOENOnNPB5luNvy4Q2WRXQ4ywWhDcxDq7EcSE6w2/5W+hE20bZLrSgsWeK4vBJZpF3tBys9CcJMtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMdpQ102RZcvXZ6zJmQfT+sI2iFm5axmpKDMJb6Icxc=;
 b=R0+adBsoIISAl+Xud//a4uoUL9TtQ29wRgdjtU+gNrZWtHvNTOgBSUMphtgMHPSVQ3BndhiaJQx26KxUxdR3jO0mzp+niHS5NhkryjOk3/kwHEIJQNboMzc+KMnAWXSooG3UOtXq5pASPTTufPH6llHYkOaXY0Zp/ccO0RQ7rGRIbBG2bQAcVeWdXKl5vk+N/iLXl6Mr5XgPpHGJ2TkFlXDYV1r/Ku3zO3WmIjd81ThTzmJHZYQGiAwOj2Yd1xnjHQZjnhgY4VGdf0jis80LIGGnK+510D1mH/iSZvN6AHbEiyaPjSIoz7mKYXXImtwRxdI19qJtnPp1iajqVekspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMdpQ102RZcvXZ6zJmQfT+sI2iFm5axmpKDMJb6Icxc=;
 b=Sy7xPJt2X93+QIdIzrUjNWKIjk+Equbm3N/pcxjvSV/EHBfQLmixpFbal3KSw/K+Nby+qKH7JF4BYIvfs5AeOpEnx05kDUnc6SffjtusW9adbV4GZK4gQE6W6zUpooljqbo9koOJB0ZmlfZAvgpfiDy970ThrCLEvONHuQI8XiY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV8PR12MB9618.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 03:49:22 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 03:49:22 +0000
Message-ID: <1fd41183-0c1f-4290-9215-30b046958b4d@amd.com>
Date: Wed, 4 Nov 2026 22:49:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/amdkfd: Acquire cwsr buffer during CRIU resume
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261104204923.4011440-1-David.Francis@amd.com>
 <20261104204923.4011440-2-David.Francis@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261104204923.4011440-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::23) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 25eadcf8-1c19-4436-ba63-08df3aefc6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|4143699003|11063799006|18002099003|22082099003|261102123227099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: YPSb9VL+GM6d75gXAfVl8AMXcnfYHbubm64GlDDxCd+XNNVYQpUVEntoUkbekvD0Om/zeSUmHfChhkJBGQruDps4jFSLtsOjF5/cXEQR6ZtZ0+DHAs0HpxA+/yijnGKe6UTwnAapGiL1OpaiI77nw8c/oLSPooBPNIf4KHQmrJaAesulF5aXNt7zM4VUzIw4l7sL3N2RJD68ekpaZu06b5H3rDbHk+LaJ1/afzLxyGhvHdikJhbLvpNwqgrIKdb2x2zOPh5qtk1gvbRrdd68X15sKuANwbB5dmdMSQeN/8+3IFuWVgJz1rnbzINr6mv5q4+WP8dXzq0oZJgtfGb0o35BYA3APthoeLnBISzIXJDWMU44J46uNwaf+UVPF2ozoJn5EYXh3QAc8t16DqO9t+hXmYkR4uVHMSvhB6msNWQ5catlDgF3CuTrJFplJRNbsqykmC5PPjdMNrxWTyX6YDEFcC/fYnlgk9KByuzJz6g2+LY481+rnJSEUiC3FrlFuHLjc0/YTONVzqLLWWY+RPimmD3KIkjVYjr/uSdhq2Vuk/kKzJcO/N2gshxDot+7ot49h8W8Dk9dcidWjK/SbOUCvrH5L4o0RkcPCY+w3ScR1kWz7XRd7fwvB9TyFirvPqccuygNqDo/LZN+8K0n2+8iqC7myA5ItDr8H2Ff+uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(4143699003)(11063799006)(18002099003)(22082099003)(261102123227099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdZbXFYRjRKRUk0MkI4K3Y5Nk5pOElpYWtDZUNrS2w3cDc0OTFVaS9FY0Vh?=
 =?utf-8?B?VTcxSDUvVllkNmJqMENjNnZPUGhtQXJtNGsvd3A3NUtvYXlVSWdrbHF5OXBU?=
 =?utf-8?B?dGFWbWRLNE5YWkRMelFoY0c2ZllsVDdRS0ZLYzdJR0JTWkZCQ3ovU21QS0Zo?=
 =?utf-8?B?MFRrUEdZK2MyWWVGdUtIOVJGOC93Ny91My83cnRlbVdpWnExZmdrR2N4Tlpr?=
 =?utf-8?B?TVRES1ZnczlTdEU2UGJYNXRhcitWd0FsY21uT0Ftam1EVEw4elVsNGVnZmlE?=
 =?utf-8?B?bWE1VzRhOGRvdk41TUxpWGtvR2thTjEzY0wrcGtQYlFkZTlONUMxaUVFUW8w?=
 =?utf-8?B?UzRmTzhaMWVHNWt0aithQTc3M1VObnFPbjdHVEN6dG4wa0VqdExDK0Q1Q2RO?=
 =?utf-8?B?SDIrdktnakE4QWtxcnBKOGV3MlJFeTRlNWFaTUlZUXFxRlAyVDEyWmp2NHNr?=
 =?utf-8?B?N2ZXSEVQcGVJcUU2c2xKb3NlcjlKdllzUzRUdjEybDNESEYzK005dVh4dGhl?=
 =?utf-8?B?MkJwdGtoNWNoOUZuc0RoazB1WWdoZHdLeXRoa3ZSRVFMZnIvaWk1Z0x6OXhE?=
 =?utf-8?B?K09waDdISGN1SmFMbjgybFdSV2RSMjN0eThyMWo1VkZ4WlRVYmlLZWpNd3BR?=
 =?utf-8?B?eWVZOEdJeEo2RkZoVTBDY1VGb0xDdFA3b1lGcVlBaHhDY1h6bFFPMDV6ZTZa?=
 =?utf-8?B?bFJSbUsxb210T2NJZU5sMEdkQ2YreWthcXhNdytjTE4zOFY3c3BTU3R1cHl0?=
 =?utf-8?B?bU1uaUthdUxpaXFUZmNReHNoYU9jVEFyNTNxclhRVU1vTWFnNnJjdUZXUkJD?=
 =?utf-8?B?YmY5K1kyWDd4OG1SV1gwS1lrQjZxQzVpblU4dmJzbUNKSDREdGtmM05kRXdO?=
 =?utf-8?B?eCtKc0kzdFkzckg3QTk3WDhuZnB1SHBQZHJLTWx6Sm0yakNvSWpxVWprTFBF?=
 =?utf-8?B?QndYZmFpdVBxUmt5TWliU3NnUFFIditpMTBXNStUV2RmVXpxNjZxUUJmSktq?=
 =?utf-8?B?UjFQclBaSTNlZnNTZ3pMNm9LRkxuaGdsdFFnUmI4U3lOeVU4Nkk5eHpXMTdG?=
 =?utf-8?B?WUVwZHovS1lkalQ3UXJveCtHM2RESklxZnp2NnpUQ25VRlQ4UTNxeGc3QVFZ?=
 =?utf-8?B?MjlkeXQ2cm5hd01zYUNpR0s0WFpyRGU4aGQ2YVQrSWZvUjdXbXNQa1dNcEFL?=
 =?utf-8?B?QVV2TnJRREFHYk14UXBiQ2JMK2w3N2ZNVmJKUnd0aCs3RVVNVnJzeGpLWEty?=
 =?utf-8?B?Q0gwaUwyOHozbHlFS2p6U1piNGVYQk5Hek55eGNFeXNIazE1cUsycnNFbFM4?=
 =?utf-8?B?YUdMQWRldnpxb3ZSWU5pZk9sUmNJRDNZTmp5TCt2dzRnanozSVhaVExIK05m?=
 =?utf-8?B?aTNQRVFhb3c1dW13UXhKNVZZUEh4TWU5OGtuZTJkcTFRMUtBQWxwUFZQRkQ3?=
 =?utf-8?B?cUMrazBiRWtidTZrblRuZTVvTjErOEZXY2gxMC9LbUo5ZXJBZXpDYVROMllj?=
 =?utf-8?B?eE9USlRQamNHN2Q4N3pvcGw2WnB2L2ZoQzM3ZUVjZThSeG5WYjVGRHVaMjhY?=
 =?utf-8?B?TTE0UUlWSDc1ZVJHd0ROZ0hTdDZUNGMvcy9MQ0JXMDFOTWhKOHNXci9aNFdZ?=
 =?utf-8?B?a3ltNWZQU3pPL1BwV1lWQ0RQWWtGLzRQQUtTaTZGNC9EM1V0cGFuOUp0NXVV?=
 =?utf-8?B?MkdFekV3dGV0ZTNEMXBvbFBBN0VEM3BjMEJsV2N0QW11K2YxS01WWTJDdXo4?=
 =?utf-8?B?Y245eGVqby9jZ3p4c3NBRWlvbnpCRHJLbERyakEyWXdZbjB3eDQ5S2VaRXNB?=
 =?utf-8?B?TFdtZWRDV2FuOTVhTHE3VkJiL1M3OEQyMXpWbkZCdml1OXNFaDJYd1AvUlZ1?=
 =?utf-8?B?SSsyNVBkb3FBbEtjazA3Vm53SnFLTTVHbzQvdWgzZjhXWkMzTDFiclVtVkdL?=
 =?utf-8?B?K2NtbnFVdlJEWGUwMGlZU1NuN2V4d3l5cFNicDU3OWFQY0VqVzVROVBJUjdy?=
 =?utf-8?B?Z3Z5bW9JbjQ4OGoxUElyYmdZaTRadVdxMUtiKzhWRzM4cUVEZndFR0p3NVNK?=
 =?utf-8?B?WDhIaHN4cmMrSjAzRy9qU0RwRkFPT3YzSWhTMFRRc1hNMjk5T1pRcVR5bVM1?=
 =?utf-8?B?Wm8yR2cwWE1QZ3llY1Z4OGswTlZCcnlkWWJzdndMVzJZMkozQjBWQmNGTERY?=
 =?utf-8?B?UU9jRGxuQUI2Umc5VGtnKy94bDJQTENGbFZYanJtRTVWZkNDWXdXbmZMV2FF?=
 =?utf-8?B?YlRPMUV2MXNkNTV6N0NFRlp5R0ExeGlyRE1IeFRZdlJDclU3K2xtL05nZ3h3?=
 =?utf-8?B?MXYycjZNNFVLT09LYVhFZ1c3ZDdzWG02UG5KbEszRmJSY3R1bGRXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25eadcf8-1c19-4436-ba63-08df3aefc6f3
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:49:22.0980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itI6qoUMq175A7/QresZaSVyMaWBjOqlIsfxgvwePOS7IXescC+BRVlRKyPXRxDC2iPB8sZW27Kbk4sDghuXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-04 15:49, David Francis wrote:
> In normal kfd queue create, a reference to the cwsr svm range
> is acquired so that this buffer is not freed from underneath the
> queue. We weren't doing that.
>
> After svm ranges are restored in RESUME phase of CRIU, go through
> all the queues and acquire a reference to the cwsr.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 32 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  4 +--
>   4 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cae3767aec567..b13aca2fc89cc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2861,6 +2861,8 @@ static int criu_resume(struct file *filep,
>   		goto exit;
>   	}
>   
> +	kfd_criu_resume_queues(target);
> +
>   	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
>   	if (ret)
>   		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 5f27ea7752349..05b24ca26b11c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1371,6 +1371,8 @@ int kfd_criu_restore_event(struct file *devkfd,
>   			   uint8_t __user *user_priv_data,
>   			   uint64_t *priv_data_offset,
>   			   uint64_t max_priv_data_size);
> +
> +int kfd_criu_resume_queues(struct kfd_process *p);
>   /* CRIU - End */
>   
>   /* Queue Context Management */
> @@ -1387,6 +1389,7 @@ void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
>   int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
>   			   struct queue_properties *properties);
>   void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size);
>   
>   struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   		struct kfd_node *dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 5741ed95c3817..b68e884b1c37a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1124,6 +1124,38 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   	return ret;
>   }
>   
> +int kfd_criu_resume_queues(struct kfd_process *p)
> +{
> +	int ret, i;
> +	u64 total_cwsr_size;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		struct kfd_topology_device *topo_dev;
> +		struct queue *q;
> +
> +		topo_dev = kfd_topology_device_by_id(pdd->dev->id);
> +
> +		list_for_each_entry(q, &pdd->qpd.queues_list, list) {
> +			total_cwsr_size = q->properties.ctx_save_restore_area_size +
> +					  topo_dev->node_props.debug_memory_size;
> +			if (check_mul_overflow(total_cwsr_size,
> +					       NUM_XCC(pdd->dev->xcc_mask),
> +					       &total_cwsr_size))
> +				return -EINVAL;
> +			total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
> +
> +			ret = kfd_queue_buffer_svm_get(pdd, q->properties.ctx_save_restore_area_address,
> +						       total_cwsr_size);
> +			if (ret)
> +				return ret;
> +		}
> +
> +	}
> +
> +	return 0;
> +}
> +
>   int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
>   				  unsigned int qid,
>   				  uint32_t *mqd_size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 9dcf0134f35bc..cd41b10e08731 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -88,7 +88,7 @@ void uninit_queue(struct queue *q)
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>   
> -static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
>   {
>   	struct kfd_process *p = pdd->process;
>   	struct list_head update_list;
> @@ -182,7 +182,7 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
>   }
>   #else
>   
> -static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
>   {
>   	return -EINVAL;
>   }
