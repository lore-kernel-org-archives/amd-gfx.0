Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBB0C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 17:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB9C113E97;
	Thu, 18 Apr 2024 17:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Po/aqZsx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D952E113E98
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 17:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUVCO8ZC2szPTFwefw2jyVhgdRAEGZVRuKueZJPMHm/1aCvAgM/nSxx+KrBcLAehwez/zJimw1ScNiY+X4Vef9PuucGO3nRM9+NUbLjs7DeAp+Ga0Dq2MA3TUJZ2qMYccYNVm+UhgbYxQKh6Ph9EoJP6CcwxM1pm6pZ7oNa0if8N7U93vXDANLd8cShzS/iABwlrMhPSKePaDeTKAjGos8acRMGodyop16TLhS7xRsdOMio4i07EZ9G1WzOsNAJq4HRgXhslSgTZECuCx6BKfCWBgDmxFgLXyk8V+HVeX0/R98FHV7E6crftgazBXOJTN2hiih+5aJyz/jVzngKZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjnw8kTd2+jSJUHSRh5cI/QJb10w1v709wx1Wq3D45E=;
 b=SJ+sq94e5mHX0r0F+U6wZnn9TViYE8VDLDHc2Ss6l187VIvCitcHDXG3B928E9amYbIn7iEE0U3DkTUYQDMB2VnW2k/pq+p0M7NvzDUHeR7zM9HW5tJ/OoeaVLJlCuYcexx2tD4dvD0MCY+t6mdE5k3+09mYpdyNeBLhuUxTEMXWESm15ZaTkspsWJ9CBhW+u/PudWrYfyuGfjlcqeRCLlHAe9jH3KwphlMyK4JXFJbgKcKx6xaIsD3UKejRjB4Grv37WQMIW1RGtS1EcR4DY03NGS3YkanysYqIv6irj+5Rca6tEVBHL4KrwpDzOfDdzZAupav6phyn6TBkA5Q6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjnw8kTd2+jSJUHSRh5cI/QJb10w1v709wx1Wq3D45E=;
 b=Po/aqZsxTXD8nMbo35OrVkT8siHF2WJMncTBKEErZMEMIG+2J91ineKjlxlcFllB3e/gqD0WvhLh8BIMnTYLcDweDsOKCCZyTcoAQdXAaKRfSSJakIuUuY7gsr58QNp4o3OmAh3V9kZ1Bg4qLDVWrLD9uWhiUL1poa+1enalLfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 17:54:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 17:54:08 +0000
Message-ID: <1cfc8103-43c4-4e9d-9b2d-628e3fb16c0f@amd.com>
Date: Thu, 18 Apr 2024 13:54:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
To: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240417195334.3718659-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240417195334.3718659-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 308704e0-4959-4c06-be51-08dc5fd08b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY4gDuNuQWpgADSpKyljKL9yv1mGJ657HSxw0PUEE66Z04PyCW8HogNLS+k+v/iww74xpPtLiLmBHJ3X+PKtt+XyImyTef6wV1MW6GHkTMcpmLKPQL1MbWbYa1GnR4zSAknoC2MWIg7QU2ZmZK43+Vkt0gg4yG5A98T7We/UCnN9z9oLHK4SsxKrXudRnHqsNynohcSW0CSznL/uxy/gn3+2P1M27PcpH1HpaXOd9cn9uecaIkjCrQIw3Kv7qQWHn50k6tRJo5N1n/ZTjMoOMETfWvJzy+NNzEQ9uFTFM/WL1SSARdmWj5mXGGnIF6Xao5chfoNP8DWfJhuxU2ID0wOsoh03YhlYyIf2EMn4gC7ZSNj0I6sbXUaftG/DHLiaTOg6uoXgjC+iVIbBnDPWr6My5xYKX3i+wBL1B5vnsb867ksnEp8OfCxgSE31deODEbZ3jnhRDLNsD/fusfbSrvtiNWw30WBtVD2pNcn0WdgzNGsUTOIiAcPur+hamnonFGUNQwKGBsmJcxZAKANt/RNqYgj+JH2S+muNzLjnSW3pHWerECFLMMQWUSeXh0gIgyQi2Vx9TPlD3tZAZT0aWi/Twku0jLcr0xr4SCoARwhPzpo+Bq8xJ5rJ6rIAJvVn2Ez63/KxdS6+fJVkZjQyi5+mOCHvI9MAFsMb/YRAoWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXViYjQwK1plemNKRkpwRmJNSzhHWElIUkdObmphazJxQVJ4Z29neU9DMjc4?=
 =?utf-8?B?emR5b29XWGplYzNrNDJ2LzR1cnh2T0RFUFVOOVdSWTBQOVg3YXVMNzJuUkJh?=
 =?utf-8?B?dUhWZHNhSE9qdytZeHBBZm1XL05NK1IwK0pqYmpVamdYREFvaGloc2k5d2Nm?=
 =?utf-8?B?ODdiT1FSVXVNdmIzK0Fnd0tRWURSdGNwZG9MYnZkMjdYd2RYWW1HTG9Sb2pO?=
 =?utf-8?B?VXg4aHFCMzhnNXBBOWduZ0xWV0pEdVJvZVR2VG0wd2lwMXRwVnhPRXRNdGZT?=
 =?utf-8?B?N0hpeWxDc2o4d1FXMTZaQ1lqVk1oSUFXdkhSREVUWWZlelFwdXgxSzVsNlJO?=
 =?utf-8?B?OGJ5ekRWVHdJN0RzelJvSVRydUdwSTQvYWR3N2xsZ2J4ZXZKbk1oRFdnT1lo?=
 =?utf-8?B?Q2wwMnlCNGpwSFVjWnowamtvVUMxcjJ3cnFwWXNPT0t4Q1ZLYU45YldYYkd0?=
 =?utf-8?B?ZGRkWVByVGg5QVd6KzhQM0JZQWdIRzdnelZxaTduWUVuYlV4bnFidW1VNWd3?=
 =?utf-8?B?VjVYaCtmNTIzazhNNEdOVHhDeElSMFhDUDNXS29XZWVhNlFZUlQ4V1VYd2pI?=
 =?utf-8?B?TTZiNWtORUpuazIzSkZWcHJsZnMxYUMzbHo2aHh0bXZOMDA5M2Z4TUJRWGp5?=
 =?utf-8?B?dU03a2FtWUUrNXBIbXpmOGRQSnNSSHZFNWdVY0NwYllwbm5vTlpyTllqZ281?=
 =?utf-8?B?eEFtM1NXTzViOEZXaG1taTAxczEya2N4bHU5S0FiaUp5cHlmV1RiK0lTMURL?=
 =?utf-8?B?SXVKZ2RPNWJzNzdJVnZJS2lUakRIYUg0SUpqMXE3YTc1TFFqRGJUK0gzNG5M?=
 =?utf-8?B?bHkyc0tsVGU4TkRuVEUwbXJ6bWsxTEs5aUcvTlJhSlRVbG4xVnhzUEJKVWRL?=
 =?utf-8?B?bUZaZWMvR3B6MmdZTUlId3hsaVBkOWNWMTc2YUNWV2FDMnYxMkQ4VnY2Nldt?=
 =?utf-8?B?R1cwMjRsZzhCN3gydzNXMDJrM3pqdDVrc2JVNFdWNjFqMHpCdzh4cnRrSmxs?=
 =?utf-8?B?YnJrUy85Y1lqSWowNld0cWhvcTc1SHgySFFXQ0xhUDFMRGVxb2ttOWMxelJL?=
 =?utf-8?B?TkRack4xVDBvekdUeDZpT2JsWTN4Qm1wZURQZ1FkaFJzVjh6OE9aK2REdysx?=
 =?utf-8?B?MWw1enVMM2JWS0luZkNJWTBleGd2ZVVxVllHakxkZVBxTkNPaXRMcTU4S3Zm?=
 =?utf-8?B?cHhZL2pQcXNTN0w4d3UxeStPWjJXVzlEN3ZzU0RrelI3WUkwb0VHL3JDSzdO?=
 =?utf-8?B?ZlN6eTJGQnJyZDFKUkROWVh6K3dmN1RZQVVYKzNCZnd0RVVQWC9NVkp3dGc0?=
 =?utf-8?B?SmtoMkpvZy9kWU8rTHU2Q1dsd0d5THRKaVBaVWZ2UUZwcXlWRmNVREZyUjV5?=
 =?utf-8?B?Y1RoT256eExiaUtSYzh3aGZ3Wmx1TjZUcjlIbzNoUWhFblNBdllIRWlDQ3lz?=
 =?utf-8?B?QklRTzhFODl4K08vVXh1YkMyS2lXZnpKUS9QTkNzTVkvVEJoZmZnaDBDV1VO?=
 =?utf-8?B?QjJLcERCaTgrS2FpRkNleFEvNi9MME1wbFhzTDVXQ2pySVQ0bWpmaGRQVkNF?=
 =?utf-8?B?cDlQelptdEpuV25xWjNvNDFRWUNRQTA4S0s1eG5qZW1uMHVKSVd5Q0M5aTlV?=
 =?utf-8?B?Qzd5dkJpUkhsaDhWNGdiaTA2MWNGMGpuYWVEYUkvMkRGMkZBVnY2UmMxeGhD?=
 =?utf-8?B?MFkxZTJZT0Jueno5dzZaaUtpQ3phdVZxSXFReENDOVhoUzFPUW8yNS9KeXJF?=
 =?utf-8?B?Qmk2RlN3L3JNREwxT0NUK0F2WUpsd3p2NWtScXFCNnhKTnFONC96OHRpUUVW?=
 =?utf-8?B?aWdpTEloU2tTVjhTa3c1ejJ4UUZDWXowc1N3TjJkVEF0SHpvUnZOaUplYUI0?=
 =?utf-8?B?K0JJODN5NC9xZndSODZiZTNmRHFqSXNpWHhPWjFNU2l0ZUdIcnNHZGx0WkFV?=
 =?utf-8?B?bGFjRmRmZ2hiMDBvU3BMZjdnUEd4UkJLdVBHV3pxNXAydHhLNG45NGNyb2ls?=
 =?utf-8?B?RWpzU043ZUM3VWtkRHNkSWpsalJxYjVUY2VJbTk1NUV6K0NaZm1iTmNnMVhI?=
 =?utf-8?B?Z1NibXNiU2pDeE5QRVZFNFVhV3NBZ21ocUtpMUlXTWd6ODU3YmUyRUo1dW1M?=
 =?utf-8?Q?yZgZzx1AdSfwXsqqu7ET3s6DW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308704e0-4959-4c06-be51-08dc5fd08b5c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:54:08.0135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uaakPAvTpTP2pqufyKxIlML9ZGe4J+9GNgfZfZEHBGDq9wmZD519IZK29lrkP3a3Qo+iMTIpE0WO9u/0tN4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410
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


On 2024-04-17 15:53, Alex Deucher wrote:
> Makes it easier to review the logs when there are MES
> errors.
>
> v2: use dbg for emitted, add helpers for fetching strings
> v3: fix missing commas (Harish)
>
> Reviewed by Shaoyun.liu <Shaoyun.liu@amd.com> (v2)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++--
>   1 file changed, 74 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 81833395324a0..414b7beff397f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -100,18 +100,72 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_funcs = {
>   	.insert_nop = amdgpu_ring_insert_nop,
>   };
>   
> +static const char *mes_v11_0_opcodes[] = {
> +	"MES_SCH_API_SET_HW_RSRC",
> +	"MES_SCH_API_SET_SCHEDULING_CONFIG",
> +	"MES_SCH_API_ADD_QUEUE",
> +	"MES_SCH_API_REMOVE_QUEUE",
> +	"MES_SCH_API_PERFORM_YIELD",
> +	"MES_SCH_API_SET_GANG_PRIORITY_LEVEL",
> +	"MES_SCH_API_SUSPEND",
> +	"MES_SCH_API_RESUME",
> +	"MES_SCH_API_RESET",
> +	"MES_SCH_API_SET_LOG_BUFFER",
> +	"MES_SCH_API_CHANGE_GANG_PRORITY",
> +	"MES_SCH_API_QUERY_SCHEDULER_STATUS",
> +	"MES_SCH_API_PROGRAM_GDS",
> +	"MES_SCH_API_SET_DEBUG_VMID",
> +	"MES_SCH_API_MISC",
> +	"MES_SCH_API_UPDATE_ROOT_PAGE_TABLE",
> +	"MES_SCH_API_AMD_LOG",

Maybe drop the prefixes. They don't add any information value and only 
bloat the log messages and module binary size. Other than that, the patch is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> +};
> +
> +static const char *mes_v11_0_misc_opcodes[] = {
> +	"MESAPI_MISC__WRITE_REG",
> +	"MESAPI_MISC__INV_GART",
> +	"MESAPI_MISC__QUERY_STATUS",
> +	"MESAPI_MISC__READ_REG",
> +	"MESAPI_MISC__WAIT_REG_MEM",
> +	"MESAPI_MISC__SET_SHADER_DEBUGGER",
> +};
> +
> +static const char *mes_v11_0_get_op_string(union MESAPI__MISC *x_pkt)
> +{
> +	const char *op_str = NULL;
> +
> +	if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
> +		op_str = mes_v11_0_opcodes[x_pkt->header.opcode];
> +
> +	return op_str;
> +}
> +
> +static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
> +{
> +	const char *op_str = NULL;
> +
> +	if ((x_pkt->header.opcode == MES_SCH_API_MISC) &&
> +	    (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes)))
> +		op_str = mes_v11_0_misc_opcodes[x_pkt->opcode];
> +
> +	return op_str;
> +}
> +
>   static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   						    void *pkt, int size,
>   						    int api_status_off)
>   {
>   	int ndw = size / 4;
>   	signed long r;
> -	union MESAPI__ADD_QUEUE *x_pkt = pkt;
> +	union MESAPI__MISC *x_pkt = pkt;
>   	struct MES_API_STATUS *api_status;
>   	struct amdgpu_device *adev = mes->adev;
>   	struct amdgpu_ring *ring = &mes->ring;
>   	unsigned long flags;
>   	signed long timeout = 3000000; /* 3000 ms */
> +	const char *op_str, *misc_op_str;
> +
> +	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
> +		return -EINVAL;
>   
>   	if (amdgpu_emu_mode) {
>   		timeout *= 100;
> @@ -135,13 +189,29 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	amdgpu_ring_commit(ring);
>   	spin_unlock_irqrestore(&mes->ring_lock, flags);
>   
> -	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
> +	op_str = mes_v11_0_get_op_string(x_pkt);
> +	misc_op_str = mes_v11_0_get_misc_op_string(x_pkt);
> +
> +	if (misc_op_str)
> +		dev_dbg(adev->dev, "MES msg=%s (%s) was emitted\n", op_str, misc_op_str);
> +	else if (op_str)
> +		dev_dbg(adev->dev, "MES msg=%s was emitted\n", op_str);
> +	else
> +		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
>   
>   	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>   		      timeout);
>   	if (r < 1) {
> -		DRM_ERROR("MES failed to response msg=%d\n",
> -			  x_pkt->header.opcode);
> +
> +		if (misc_op_str)
> +			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
> +				op_str, misc_op_str);
> +		else if (op_str)
> +			dev_err(adev->dev, "MES failed to respond to msg=%s\n",
> +				op_str);
> +		else
> +			dev_err(adev->dev, "MES failed to respond to msg=%d\n",
> +				x_pkt->header.opcode);
>   
>   		while (halt_if_hws_hang)
>   			schedule();
