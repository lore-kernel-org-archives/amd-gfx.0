Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0AEC4450B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 12:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D91810E036;
	Tue, 14 Jul 2026 12:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4STwZNaR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11AAE10E036
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 12:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL3LnuGh2nRDvfjkJ00kBBAzEbY0R5PbpVK1zDeLbbz3DS0XHnaNIRB9akL+WO1u+5M3bIhEGhePNbbYEGo8cC+MlyolAIf/nvB3OUDVvshgFhN2vkYQ+FA7QOaJQt5juVLWYhulJXx4lCxRTa9xWd5nCufW1VC9shaiE2cIaAGAFUV1MR7xMWrDe1Fzvqb6Mwexl0PgpEaDgOtrTQpdcsYPnLmjxUFcA2bWyaEDgTrKvCqFfPWkmFJEkteCvzZADyxVLQfM7ll7NXaV0YFlm/zafU3otVv7iTAhzq/RMXL4/pTE80PTCdIytFIB76E2YdaHS3hcUBpEUVxBWp94ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSVRTGFAaXAZuvEL+0eNMdR7mdv+ndeKRpaGHUk5pWI=;
 b=P8b/wLGRS40PVsyWrxbrtIn4k3bIuiN/BDF5fdJ2VftuQW8G224mfoI6LlIdweSdXHuJwWYsN24a7HY6uscvxC+g/tKmTJ2OMT1ci8Mepo2o9xpGFTKQKeNo1U1DbTF9d0fjuv+sFRvfwg6CpeYYyj72z3CV6ivM4vNXDWIXM82JoO8lf4Zs3ctIKGef1Lg5k2kPoK1I8oi83EaSqeH2FRsfkXmN6CbMaifXLpCRLQZmOPqrr8XvsHkrk7zOuc5D7KqZeODpwE3pljG78ZTGHtLA4D1A+RfpkxVw62KjnQrj/60vClsMgEfMK1fvctJncz1CoWg4WSk2zECSfrHTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSVRTGFAaXAZuvEL+0eNMdR7mdv+ndeKRpaGHUk5pWI=;
 b=4STwZNaRbwZTyzkpQmFrUC1ZXkSd2m5taQfqNwAKuDWNh0/MuuHj7PZfTPmy6tfsggAoByg9PNeSzlaqHh1cwDx6aBliAx1fpWKQG0+H2Lc9ftk6u6HJXhTUHfyiXTISDGumXuWL1GiF4nKtbnz0pfaNsFe0yGCjFuZ8AmLrZ+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 12:45:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 12:45:06 +0000
Message-ID: <b60f0e23-a81d-4dc0-80e1-de9ed1a20eb7@amd.com>
Date: Tue, 14 Jul 2026 14:45:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/5] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714081023.3395485-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:208:23d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3c9a09-680c-4d48-bb55-08dee1a5bb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7E8TKxqZ/Fa1Az46tz6FYNW8w9r6waoS4LrDWrNfYFJfUr9nmrPnZLOLIMWPlM2WDuCt3fV1y7PZU1FLMu+nWK6CAlZWgzCjOsAc8vIdD4Upp+nqNZMxIk5vPXce98fJPzPV5Qsru1OfduRLIxTjQWU3rjZUdm1Ah4imFDweqxoZ1HRz37JDi8Z0EnVnkj/uvYH7S5pO9Vb0q43GwSfoDg+TIL2xbwSsJfYYHpaXylgGegV/C7puN/Q6Ic1UJyf7eSOXQNXtstz92WEHnAzVYXpZSzGcXJ3oInCZQpxIPrTgbIS+hZz9P5+g56uPVhrtVG0gX13xXrP0SKlR5ef+GH2Xjvg8aKfP20e69dj+YL6FM8OlgTwrt35W2y1giWypGRbrrNSiN6y3HXDGA8zdFiZX1q0fpVTBMqEwVOw0rrCtk5qm6wDkiBUVDfXxhTM5RG8ZbwCgPmapynu83ldJBWZRVjfhrZvy8XziZkxaTnEjcElzPF9SouFIkpur92CwZxsKucr9ZaVCZ+4EpIPec5uChkN9f45oGm1o+PSEdIptGp68cwzenXBGYhdjJsvI38FAMIdWuiPsaCqoq8Kt8JFSZUJ6ZygsvOizuyD/nbAN/biQqge45pMNxK2ue8yqScvhLJXKB80Mgep/LId4XvLoeZeEUc3JLZLl3cHLUuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXM5YjVDeUhZcUs4Tis0MzRYaFdKT1laWlZpSTA5Zmk1YXIzMWNjaVdaUHV6?=
 =?utf-8?B?S2VoZXlHc3M5ckJIVmFVQTFObnRRbHk4VzNLVk1RNEN3c0dUU0xweHpmMlh2?=
 =?utf-8?B?WWo1dmRERWphWU5FQ0VIa3lxWHk2ZTYyWThHWno1UTkzcGNMakNvSDQ0N05n?=
 =?utf-8?B?TjRhak9vZktMYzB1R1hzUXM5QkN2aVo1OXNXY2VsNndna0NJYmY0WjdtTEFZ?=
 =?utf-8?B?anVWS1FZdW9MYm9Ma3FYRkVMT3FuZEdzODZsdzg0cFA2L1JwRlFGNGZoZTYz?=
 =?utf-8?B?T0FoSjlkRlJRdE9BakVuTUJEYWRxS3RtSXdSREMxS1ByNjVBVTZhUDRzQjly?=
 =?utf-8?B?UklwaTZkRERzM09idWtzUE16NkRjYkJKS1pnZzZaWkZ6SEh5TTV4RW5hSXdQ?=
 =?utf-8?B?cTJhSnQ1dTFyWmxISWtKRVVSbFlKOHZldVhKa0JTZ1M0N1ZlNDB6clNqRmNI?=
 =?utf-8?B?dzhQNmhZS3c4Tm5EWnZUcUQzT3gwWXEwb0h1U28wUzhEa1kyT1VBMkhTcnZu?=
 =?utf-8?B?ZkVmSGRCcy9mdDJlanVSQnRaOU1XbEFKVnh5OW5ZT0VyZ284UmM4Vzh1Wi9I?=
 =?utf-8?B?Sk9Gc3lZTXVRQjFZZHl6bzhhMDRPd3BRb1crSTQ2UERvamdETUdqV2xMc2I1?=
 =?utf-8?B?WXRzeGRiZlhVTFkvTmxpcGFJRkk3d0M1WjBSWXJMbS9aU04ydlFoL3NaZE1z?=
 =?utf-8?B?OW5QOWphcFhWZ0tzNTJTd3lZQkZYWXUyS3FsaEtXa0dxcWZkN2FwbFpUSmp2?=
 =?utf-8?B?eWl1Wno4Z1U0TVcvbzFJaEZLakh5RDFCZGtEaTBFMUh2L0ZaakNTUXVmV1g2?=
 =?utf-8?B?ZTZjbWNMVUk1Q2RsZkRabHBmei83aVIzcmVxanYwclpldTUvcVkrdldoNSsr?=
 =?utf-8?B?clVySXJBUFMxVHhOWjV5ZFVUa2JNM2kxN0lOckpIN2Q5SVhyZUY3UDk4UXly?=
 =?utf-8?B?eHBrU3VoV3RlVXl2M3hWamN5c241dy84UGdMQzJVR3VxVjg1NWtjcjNXaDZx?=
 =?utf-8?B?NTlxV0thMFk5ZEdXYmhFeVR1T21PcXMwVGxsTlN4MDBaRncraVVmZ00zMUh5?=
 =?utf-8?B?b1FUVHgyVy9iaXdRNjYvNm05MDMrUHJUQkJSZEI0NHZoVm8rQjdMUmQ2dDJZ?=
 =?utf-8?B?OW9SWkJWdUVLeEIwZ1Z3S2NBalNpbkgvajd1SkxNSmo0UFpsUG9sWDFBZHFi?=
 =?utf-8?B?QjdadjB2S0ZGZWtXMHl3M0pocFN5ajdEd1BkY2c2WmJUWFArUSt1YmY0bXAw?=
 =?utf-8?B?UEZFRytXZDIyaVhBZVcrTkg4ZnI2RVJFUlZNWllhaHoxQVFhaFkzYTIvbzJL?=
 =?utf-8?B?N3ZWL3ZTWXJMUlJQVDJIdmJVcjNWUFM0UFRUWitVY1l1STRmeDdkenRPTzRJ?=
 =?utf-8?B?OExyc0l1eWF2NkViZWxibHJvelZveWRKdk02LzB3clc2NzE5a1Q3aXF0emZi?=
 =?utf-8?B?a3ZOT0lEMUw3aW45R1RmL09jb0VWSUJKMHIzSDFoVk03anZQQ0VnNWlEVWRB?=
 =?utf-8?B?d09wWlpJRDhRQTRaTWMzKzBxMjJqTGlIZHZXVkI2ei9sOW5KaFI3SjZlYVBa?=
 =?utf-8?B?SkhaWDhiOGhqaWhCb1NUVHR5ck9XVks5RmZpY2NpN2tib0ViOStwMzdFekZE?=
 =?utf-8?B?WElGWGZSM05WRHpiaEtTalhUSytmNnBHa3UveGhBTWVIcnZSNHdzTGU1T0pX?=
 =?utf-8?B?OWVHS0Y5dWpPL2QxZnprYUR6eXg1cGo4LzNNaGlPZTRiYW1FdHFRYUtyUTZv?=
 =?utf-8?B?TnQvOTlBSm1yRis4R0NFNWl1TEc0aG4vc2FoclVNM2pqNG5MWlNhNng3aHdz?=
 =?utf-8?B?M0IzbW1VTGI3YUJuVmd6c2h0dnU3Y1hmem5vMkt1L00yU3duc1FRMmZObWVr?=
 =?utf-8?B?SVROUGtyTzRuYUp0dDIwYzBnRUtRUndWUVVXODRiT1E4MTdrdzlScU5IUEUz?=
 =?utf-8?B?L1NlL2lyODBNZXl4WHltV0JvSVlLZ091QUtCVHhVS1luL0dGZnJUNlUvVE1Q?=
 =?utf-8?B?UDd2THBabHdlNUpBMlI1d1o0dFppbzlOZmVvR3hSd2hMMC9Zdk0ybkF6SlZa?=
 =?utf-8?B?bWttQk9JVXBLNG5Ja1BSdWN4NnR3RnRJajlHSm9HbW4xYTI2UFVHSllYd2k1?=
 =?utf-8?B?Q0MycWR1SXBKZ0tyalpPSjFMNEpBNXp1ejBCNXI3QnpPSU5PbXh5Z3M2VmFu?=
 =?utf-8?B?cllVWldkc3pCYm56M0k2NWdjcW1sU0dmbWN4d2V5cW4zSVJ5SmVIeXRGR3Qx?=
 =?utf-8?B?Um84eVNjTnJwRXRrNXhMQ1ZVMG1rcmJiUll0cUN4UEwrM3FweDVMTUlSYXAy?=
 =?utf-8?Q?9huhk+07ZyE9mGR6uO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3c9a09-680c-4d48-bb55-08dee1a5bb79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:45:06.8600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI1bqRgfgYoRLOQ23zh7e+ni00/4HSaUC2Ixw8v45OBJiM9LorItR1Tz1kITinvR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
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

On 7/14/26 10:10, Srinivasan Shanmugam wrote:
> Add the UAPI definitions for a render-node WAIT_EVENT ioctl.
> 
> WAIT_EVENT lets userspace wait for a kernel-defined event type and
> receive metadata describing the event. This provides the
> metadata-carrying half of the event interface and is kept separate from
> EVENTFD, which is used only for lightweight readiness notification.
> 
> The new UAPI supports:
> 
>  - event type selection
>  - queue-scoped or GPU-scoped event selection
>  - timeout-based waiting
>  - metadata copy to userspace
>  - single-consumer delivery of the first matching event
> 
> queue_id is the userspace USERQ queue handle identifying a queue created
> through DRM_IOCTL_AMDGPU_USERQ. It is used at the WAIT_EVENT ioctl
> boundary and returned in metadata for queue-scoped events.
> 
> Changes since v8:
> - Clarified that queue_id identifies a USERQ created through
>   DRM_IOCTL_AMDGPU_USERQ, as suggested by Alex.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 109 ++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index bbda6ffc498b..2ec57f4975cb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -61,6 +61,7 @@ extern "C" {
>  #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>  #define DRM_AMDGPU_CWSR			0x1B
>  #define DRM_AMDGPU_EVENTFD		0x1C
> +#define DRM_AMDGPU_WAIT_EVENT	0x1D
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -86,6 +87,8 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_CWSR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
>  #define DRM_IOCTL_AMDGPU_EVENTFD \
>  	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
> +#define DRM_IOCTL_AMDGPU_WAIT_EVENT \
> +	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_EVENT, struct drm_amdgpu_wait_event)
>  
>  /**
>   * DOC: memory domains
> @@ -251,6 +254,112 @@ struct drm_amdgpu_eventfd {
>  	__u32 flags;
>  };
>  
> +/**
> + * struct drm_amdgpu_wait_event_queue - queue-scoped event metadata
> + * @queue_id: userspace USERQ queue handle identifying a queue created
> + *	       through DRM_IOCTL_AMDGPU_USERQ
> + * @status: event-specific status or error code
> + * @data0: event-specific payload
> + * @data1: event-specific payload
> + */
> +struct drm_amdgpu_wait_event_queue {
> +	__u32 queue_id;
> +	__u32 status;
> +	__u64 data0;
> +	__u64 data1;
> +};
> +
> +/**
> + * struct drm_amdgpu_wait_event_memory - memory exception metadata
> + * @queue_id: userspace USERQ queue handle identifying a queue created
> + *	       through DRM_IOCTL_AMDGPU_USERQ, if applicable; otherwise 0
> + * @fault_status: device-specific fault or exception status
> + * @va: faulting virtual address if applicable
> + * @data0: event-specific payload
> + */
> +struct drm_amdgpu_wait_event_memory {
> +	__u32 queue_id;
> +	__u32 fault_status;
> +	__u64 va;
> +	__u64 data0;
> +};
> +
> +/**
> + * struct drm_amdgpu_wait_event_reset - reset metadata
> + * @queue_id: userspace USERQ queue handle identifying a queue created
> + *	       through DRM_IOCTL_AMDGPU_USERQ, if queue-scoped; otherwise 0
> + * @reset_cause: reset cause or reason code
> + * @data0: event-specific payload
> + * @data1: event-specific payload
> + */
> +struct drm_amdgpu_wait_event_reset {
> +	__u32 queue_id;
> +	__u32 reset_cause;
> +	__u64 data0;
> +	__u64 data1;
> +};
> +
> +/**
> + * struct drm_amdgpu_wait_event_scratch - scratch event metadata
> + * @queue_id: userspace USERQ queue handle identifying a queue created
> + *	       through DRM_IOCTL_AMDGPU_USERQ
> + * @error_code: scratch-related error code
> + * @requested_bytes: requested scratch size
> + * @available_bytes: available scratch size if known
> + */
> +struct drm_amdgpu_wait_event_scratch {
> +	__u32 queue_id;
> +	__u32 error_code;
> +	__u64 requested_bytes;
> +	__u64 available_bytes;
> +};
> +
> +/**
> + * struct drm_amdgpu_wait_event_data - returned event record
> + * @event_type: kernel-defined event type
> + * @queue_id: userspace USERQ queue handle identifying a queue created
> + *	       through DRM_IOCTL_AMDGPU_USERQ, or 0 for GPU-scoped events
> + * @flags: reserved, must be 0
> + * @reserved: reserved, must be 0
> + * @seqno: per-file event sequence number
> + * @u: event-specific metadata
> + */
> +struct drm_amdgpu_wait_event_data {
> +	__u32 event_type;
> +	__u32 queue_id;
> +	__u32 flags;
> +	__u32 reserved;
> +	__u64 seqno;
> +	union {
> +		struct drm_amdgpu_wait_event_queue queue;
> +		struct drm_amdgpu_wait_event_memory memory;
> +		struct drm_amdgpu_wait_event_reset reset;
> +		struct drm_amdgpu_wait_event_scratch scratch;
> +	} u;
> +};
> +
> +/**
> + * struct drm_amdgpu_wait_event - wait for a render-node event
> + * @event_type: kernel-defined event type
> + * @queue_id: userspace USERQ queue handle identifying a queue created
> + *	       through DRM_IOCTL_AMDGPU_USERQ, or 0 for GPU-scoped events
> + * @timeout_ns: relative timeout in nanoseconds; negative means wait forever

Please never ever use relative timeouts in IOCTLs!

Only absolute CLOCK_MONOTONIC based timeouts, preferable as nanoseconds cause that is the same as ktime_get() returns and easy to work with.

Apart from that looks good to me,
Christian.

> + * @out_ptr: userspace pointer to struct drm_amdgpu_wait_event_data
> + * @out_size: size of userspace output buffer
> + * @flags: must be 0
> + *
> + * Wait for the selected event and copy the first matching event record to
> + * userspace. Matching records are consumed by a single waiter.
> + */
> +struct drm_amdgpu_wait_event {
> +	__u32 event_type;
> +	__u32 queue_id;
> +	__s64 timeout_ns;
> +	__u64 out_ptr;
> +	__u32 out_size;
> +	__u32 flags;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE	0
>  /** Opcode to destroy previously created residency list */

