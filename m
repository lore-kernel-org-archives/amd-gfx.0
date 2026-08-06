Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B72C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 14:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A049610E32C;
	Thu,  6 Aug 2026 14:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4rnZm4lf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753B010E32C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 14:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv3gdBrX/ANfzjdmSbpDMXhtmVn8WACXhLym4CEzyLxJ7V2aKX6SQwYlu5IDr2X39RE9M2O09Dgv8bN7etatO5GC4ACOnyQJhBO2uextvwdMrjL1KmkV9ps8Posj41YG3FXIoL0L4NbZHBqFKYgIQqIvSipos37I5D+HDMIp5+hlPk+XwCrt+JyhDMMDGVA+EJyQl/g8nrmwFlelePdQpib4nb8GY2Z/mupp2DTT1retVyxyBQ8Ef7qyLhIPhJjmLEJu0+vNBE7HDZTMeopGUFXyt/lxnU3OF1mdpD1h/YU/13bsRLN9a5cOlCxmSS8T0kj2B0AzuTKLlLiDGsBTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7KiafWvZnt6zA03lrqvwkFYjF+Gy3hbIpsCzu76YCo=;
 b=s5XNXgeN3YhVpS7AmjPZvV6qjWaRgJIxDnV2zHLBtogq7/fnPZlkCJW3HYoxNXl7lUf543T7pt31ERJeVeH0kwdybawEgVb4Pxfmd241oaKEeuuGkZhyXhMD424rNqQg45HmCJp1nbF3/qZVFAwq8SKergzm5y8nlimAGeOM0wZgoKmRqwxpZ5fKwRaqpJLoF0k4KMroWnFM9OenLWHF+w3QM/dyrx3MKccJq5nl2voZ3X+njfI5KhSAYSJ/2LxH9nxBiqsxmAEeSQq3K43W1icHzDTbT+UxauIWn5qTiYQi7Hhn3E2hvBAkRPyIAw2S2eevkUYZLl7Rz1Aqxfzhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7KiafWvZnt6zA03lrqvwkFYjF+Gy3hbIpsCzu76YCo=;
 b=4rnZm4lfWbm3+Z+PU2WwoydpoZHX4JxXB16k0qyytC81zPnOcZR9ZDv0D3/pMyg/I/lneO1yUkg80+I3/hNV//Oni+hDIbJVN6o0tMp45EZC2jGzgkAt0sSZRQtbxOaAyKCZNAKNWmlODFn05pWhAuQRRiEByVnhXmUotThyZTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by PH8PR12MB7025.namprd12.prod.outlook.com
 (2603:10b6:510:1bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 14:10:29 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 14:10:29 +0000
Message-ID: <7557d4ea-68db-48ef-ab2d-7b8bc8f05061@amd.com>
Date: Thu, 6 Aug 2026 10:10:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdkfd: preserve VRAM MQD across hibernation via
 unpin/repin
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Philip.Yang@amd.com, 
 Mario.Limonciello@amd.com, Srinivasan.Shanmugam@amd.com,
 Tiantian.Zhang@amd.com, Victor.Zhao@amd.com, Guoqing.Zhang@amd.com
References: <20260806062053.806535-1-shikang.fan@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260806062053.806535-1-shikang.fan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::21) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 962d5f9d-29b4-4c38-7556-08def3c47806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: o7vt8+ZxuRoZbtO8ifYaqYfHCV5e1TbHDD7it86OwRJMHrN8R+EfmAEKJSzuk4B/5KdR5iuE1kTtViF5LBCgtkQJVkU6hMbrPws/4YQaa3ZSc05WzjAeASG17g2Eyynlxjz1WLIn6R6n0/Vej/oO1DrOBz2rkw41R/xBF90z2ag0tYZd6p0lRTxQzX4hw4vmSqJUWjv1K13SBxZ2ooa6XiCFowLffomjW7qBTMAGXx/MJdj6WiTX60vXOkS5rP7HxYASVZuTx8BZYa01SQkD1/ceH39aVkO+m98I3Yqtxjd0NYaMUy/7F2y8Pbfct78i0Mo7NzLXNkworKp96KH1aVVSDWaxDHvCCls065bAy+xri39g6lQyICzvlyPf7H1UWSskzkgp52UiDOhJLbJikvy2nM8opSEytJET5l4T45mPL/pW8eQG9JZvVxElLxk/hWNEawDbyp0NpJDft+UoSBvhqx4fVeWXhJWs6AFKftLAa30CBDqWEg0YV9ynv5YWLaafpRd5x022H4YeDSwiosTjKpQ7Wu7RPEqxY+lKT+9s0c0zmWm2ODb5wld+ZKMZlRh/xDhjLFr4IAGtLfOsese5qPbXtLH0LR3S8XEhL6ACmnu75yOa3Z1j9PaEvdyEU02SzqOZIMgRc8XOo7E7atyRJhOeyHmpeRCTKAc2zYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZzR0ZrV1VEOXdaODltT3ZGekU4S1JlR1cyZ2xEWDZXc3l2cjNrTE40eWJ4?=
 =?utf-8?B?ODZLZUcrR2dHQUR0aHl1Nk1oY2I2cmxYalJCVzhwclFlTjNQWWpCTjVzM3hE?=
 =?utf-8?B?am5ES1ZrZjBIYS8rUTVUbVFiUHZUWkg2aW1uT0wyRnQzUlMrYlNlaCtzdTZC?=
 =?utf-8?B?bS9WMndkRVpHUkI0eFlicURKalJmdkErcG5vbzRiZjNkNWM3N2RLYXR6cHlQ?=
 =?utf-8?B?S0l2QmE2MWY2VVRMMnFVMEFPTEFUbVVacGlnNnZ2V2hsY25mL0JZMy8xUENj?=
 =?utf-8?B?eXZVRmZLTllSTFVvKzVwaDlWa3pQN1kzVHN1VnFudW95aWcvdDYwOG5XcmI3?=
 =?utf-8?B?WlZPVlpiRXFvZmllR1VhWkh1OUNvbEV0eHhNZmlCZ0FzU01ZdmQ4WlN2a29u?=
 =?utf-8?B?MHgrMzhUTVBrdkJiNUxzN3NrZytxcUM1WDZEZlVRUmZRYnhxMFNBb3U2TDlv?=
 =?utf-8?B?R09HQVVPbkNHbDZXMVJCMmNaQ1diTjdCQndnZncvdjFuKzZ4cmZNYzA4eFJQ?=
 =?utf-8?B?eldsbEEwU08wNlBZdllqMTRjYTJGeTBld0Z5ajQ5VFJjOTdTY1h1QTN3UDBp?=
 =?utf-8?B?VTNDWVpMMmRpWi9hWEpmbnIrcWs1Yy9IVlRsN25JVjdiSTVtcG1RMXlGSlBo?=
 =?utf-8?B?T0pBTzMzVGJGYTYvV0V0d2p5RnkrbUQ0L3RFTFAvajI3ZlBNZm5Sb2Jaa0wx?=
 =?utf-8?B?YWU3QmI4NlgyK21PWjEzclRwYmRzNjhBL3RNalJhNmdjWUVCNWxLaWdPM0hr?=
 =?utf-8?B?VjJ6WlFqN1RrSjBZZmZuOVJYbmFzM1gzeVh6WEtwK0hBT3l6T2tvQ2dHMDFo?=
 =?utf-8?B?dEdjYlErWnAzU0huUXpvWVZRQ3FoNmVubmN4bjRNbDhxWXRCVC9rNy9MM1RY?=
 =?utf-8?B?Ri9jWHhPVUt2bmIzc0hkL1piL0lBbWxXdEV4eGdBdU1heDEyL0V2K2pYQXFp?=
 =?utf-8?B?ZDVjZklEUkovUnV1WXdtVXVyY0JIc1ZXa2RUZlVTNGFuV0FRT081OVhyQUZG?=
 =?utf-8?B?bFNUMXlkUnV3K1RNVU5XUWtKY251Q3daMC9ySndhT2JCNHlZWmZwOEJJVjYv?=
 =?utf-8?B?QXdhM2E2N3lzWndrbHZpT1hNTXhtRFhTUTdWaDE2cjZqWDU2QUxhRGl2eFBS?=
 =?utf-8?B?S2hML3ltU2hDQXBPL2taNEZ3Z3JhS3pxT2JFelp5cmhmK3hrdW13QkQrL2Zu?=
 =?utf-8?B?SGZRZWg0SkNXQnQvS1JBY2tSRjNVZ2UrMFZBL2ZHcUlSNU5NeWdIMzJhcHBo?=
 =?utf-8?B?ZkRUbk5yQmhtbmlxb0ErVnU2KzZkQ2NITlo0RHpzZ2lMYlh1V1I2YUFtZ3Mv?=
 =?utf-8?B?VkVKSXFwaXk0YWYydzZVVlBMWUFZN1ljOWtDUHZFcXlrV054Sng2M1FhTVBj?=
 =?utf-8?B?NEdGenFsYlQ3Y3JOaGV4dUhmVG1kMTk1SnJ5OTJreW9USUdQclJqNDgzdTBK?=
 =?utf-8?B?dVZzSVFlUEZvWVVNSEZ4ZmtMaDNsWTN5bG1RcXFTNHFQa1J6UDVraU9HRWNB?=
 =?utf-8?B?Rjd3ODZyak5hcWt1WWw5UEpTRHFJRjhWbnNIM282S1dicmx1Qmo4MHZFdUY5?=
 =?utf-8?B?TklIQ3VoMkJrVmU5Tit2ZGZpeFhrak9zTE44WjcydjhtWXFpQ1RhT1l4Um1O?=
 =?utf-8?B?L3I0VkVxR0tUOVVleGdSRDJrdFgvOG1TVll6T01lY1kxS3Q4UzFnUDFnWWdR?=
 =?utf-8?B?NmFFSXoyeTB2Q3NQQjFmWDJqYWZjREdvdERLMldIQjlwREtDWlpwNDdkbC9G?=
 =?utf-8?B?MHZIOFlQblh4N2pxdGFnZHZUcGF6V1hFOEJvR1h4T25VcGRrc1YvVzNWSzgv?=
 =?utf-8?B?MWxNdGZBOUlGT3VhZGtKR1FqOC85WnNhUm1kVjRMYzVDZ0hPWjVsdmd1SUQw?=
 =?utf-8?B?enczMGJpa29CRWdMMjBWNUdvd1NlY1JTelorVWRONFJWZ05NNGdUZldiMHox?=
 =?utf-8?B?K1cxYU5sTjdtajBCaXRJUUl5SWFJek9NcWQwR0VLRjl3ekVMME9MSzg5cklz?=
 =?utf-8?B?ZzFtaXplSFV3NXJibEp5VGpMU1lnMEhXRUh6anRwUU40UTBNUCswQnNoTU1C?=
 =?utf-8?B?bWFqSWxHYlEyMW51Wk5RTU1GaTgxbDRRemx0NEdnVHZSeEFyV1h5OWZIei9j?=
 =?utf-8?B?L24zK0tsaUVKYzZLU0d3S3Uvc1RuMmpLT2ZmdzNTUk1SVHR5UVFCZy9PTTh0?=
 =?utf-8?B?RWh5cVRFbTBCc2d6ZVJwU1JSZ1ZvNGlEeW5VQktPT2VCUDYwUXNGSFJQR1BN?=
 =?utf-8?B?akVoVU9KdzZLbElPTExRVk1vVjQ5NXdlL1l3Q3ZTNnRwS1JxZHB2L2pGc3R6?=
 =?utf-8?B?Zk43RlpsQnVPVlJUL2czNTFaanhEUVpmVDBOaXJPOE5LeUpxNEFsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962d5f9d-29b4-4c38-7556-08def3c47806
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:10:28.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGaWyVhS57bYRgaMooroYukfso5agrUd30d61c4bKifzAPIrfCYL9JqhTOJf1a0mJjaxNnOLLOb6CMCnpiJ1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

On 2026-08-06 02:20, Shikang Fan wrote:
> On gfx9 ASICs with mqd_on_vram(), a compute queue MQD lives in a pinned
> VRAM buffer object. Pinned BOs are skipped by the VRAM eviction done at S4
> suspend, so the MQD contents are lost across hibernation and the first
> submission after resume page-faults on a stale MQD.
>
> Unpin the MQD BO at suspend so the eviction migrates it into the
> hibernation image, and pin it back to VRAM on resume. The BO may return at
> a different VRAM address, so refresh the kernel mapping and cached GPU
> addresses and patch the MQD self-address via a new update_mqd_gpu_addr()
> mqd_manager op; skip eviction with a warning if that op is not implemented.
>
> v3: use unpin/repin instead of shadowing the MQD into a separate buffer.
>
> v4: drop the explicit VRAM->GTT placement at evict (a bare unpin is enough
> for the eviction pass to move the BO out of VRAM), and also repin at queue
> destroy. KFD queue restore runs late - user processes thaw before it, and
> under SR-IOV it is deferred until the VF regains full access - so once the
> VM has resumed an application can destroy a queue before its MQD BO is
> repinned, which would otherwise unpin an already-unpinned BO and touch a
> stale q->mqd.
>
> v5: drop support for no-HWS mode, and set q->mqd to NULL at eviction.
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 106 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 +++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
>   4 files changed, 160 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ea9d87450eae..a23384571193 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1257,6 +1257,99 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>   	return 0;
>   }
>   
> +/* Unpin the MQD BO at S4 suspend so it is evicted into the hibernation image;
> + * dqm_repin_mqd_bo() pins it back on resume. Gated on adev->in_s4 so runtime
> + * eviction is untouched.
> + */
> +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +	struct amdgpu_bo *bo;
> +
> +	if (!dqm->dev->adev->in_s4)
> +		return;
> +	if (!mqd_on_vram(dqm->dev->adev))
> +		return;
> +	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
> +		return;
> +	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +		return;
> +
> +	/* Without update_mqd_gpu_addr() the MQD self-address cannot be fixed up
> +	 * after a repin, so skip eviction (with a warning) instead of faulting.
> +	 */
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> +	if (!mqd_mgr->update_mqd_gpu_addr) {
> +		dev_warn_once(dqm->dev->adev->dev,
> +			      "MQD is in VRAM but update_mqd_gpu_addr is not implemented; skipping hibernation eviction\n");
> +		return;
> +	}
> +
> +	bo = q->mqd_mem_obj->mem;
> +	if (amdgpu_bo_reserve(bo, false))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +	q->mqd = NULL;
> +	q->needs_mqd_repin = true;
> +}
> +
> +/* Repin the MQD BO to VRAM and refresh the cached mapping and GPU addresses.
> + * Used both on resume and when a queue is destroyed before resume has repinned
> + * it. A no-op unless a repin is owed (needs_mqd_repin set).
> + */
> +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +	struct amdgpu_bo *bo;
> +	void *cpu_ptr;
> +	int r;
> +
> +	if (!q->needs_mqd_repin)
> +		return 0;
> +	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +		return 0;
> +
> +	bo = q->mqd_mem_obj->mem;
> +	r = amdgpu_bo_reserve(bo, false);
> +	if (r)
> +		return r;
> +	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (r) {
> +		amdgpu_bo_unreserve(bo);
> +		dev_err(dqm->dev->adev->dev,
> +			"Failed to repin MQD of queue %d to VRAM: %d\n",
> +			q->properties.queue_id, r);
> +		return r;
> +	}
> +	/* The BO may have moved; refresh the kernel mapping and gpu address. */
> +	amdgpu_bo_kunmap(bo);
> +	r = amdgpu_bo_kmap(bo, &cpu_ptr);
> +	amdgpu_bo_unreserve(bo);
> +	if (r) {
> +		dev_err(dqm->dev->adev->dev,
> +			"Failed to remap MQD of queue %d: %d\n",
> +			q->properties.queue_id, r);
> +		return r;
> +	}
> +
> +	q->mqd_mem_obj->cpu_ptr = cpu_ptr;
> +	q->mqd_mem_obj->gpu_addr = amdgpu_bo_gpu_offset(bo);
> +	q->gart_mqd_addr = q->mqd_mem_obj->gpu_addr;
> +	q->mqd = cpu_ptr;
> +
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> +			q->properties.type)];
> +	if (mqd_mgr->update_mqd_gpu_addr)
> +		mqd_mgr->update_mqd_gpu_addr(mqd_mgr, q->mqd,
> +					     q->mqd_mem_obj,
> +					     &q->properties);
> +
> +	q->needs_mqd_repin = false;
> +	return 0;
> +}
> +
>   static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   					struct qcm_process_device *qpd)
>   {
> @@ -1353,6 +1446,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   				goto out;
>   			}
>   		}
> +
> +		dqm_evict_mqd_bo(dqm, q);
>   	}
>   
>   	if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1492,6 +1587,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   		q->properties.is_active = true;
>   		increment_queue_count(dqm, &pdd->qpd, q);
>   
> +		retval = dqm_repin_mqd_bo(dqm, q);
> +		if (retval) {
> +			dev_err(dev, "Failed to repin MQD for queue %d\n",
> +				q->properties.queue_id);
> +			goto out;
> +		}
> +
>   		if (dqm->dev->kfd->shared_resources.enable_mes) {
>   			retval = add_queue_mes(dqm, q, qpd);
>   			if (retval) {
> @@ -2763,6 +2865,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   				qpd->pqm->process, q->device,
>   				-1, false, NULL, 0);
>   
> +	/* Repin the MQD BO if still evicted for hibernation, before it is freed. */
> +	dqm_repin_mqd_bo(dqm, q);
>   	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>   
>   	return retval;
> @@ -3020,6 +3124,8 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		list_del(&q->list);
>   		qpd->queue_count--;
>   		dqm_unlock(dqm);
> +		/* Repin the MQD BO if still evicted for hibernation, before free. */
> +		dqm_repin_mqd_bo(dqm, q);
>   		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>   		dqm_lock(dqm);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 59eff3389d39..38b46b696243 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -117,6 +117,14 @@ struct mqd_manager {
>   				const void *ctl_stack_src,
>   				const u32 ctl_stack_size);
>   
> +	/* Patch the MQD's cached self GPU address after the MQD BO has moved
> +	 * (e.g. repinned to a new VRAM location on hibernation resume). The MQD
> +	 * contents are otherwise preserved.
> +	 */
> +	void	(*update_mqd_gpu_addr)(struct mqd_manager *mm, void *mqd,
> +				       struct kfd_mem_obj *mqd_mem_obj,
> +				       struct queue_properties *p);
> +
>   #if defined(CONFIG_DEBUG_FS)
>   	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..b95720198e28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
>   	qp->is_active = 0;
>   }
>   
> +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
> +				struct kfd_mem_obj *mqd_mem_obj,
> +				struct queue_properties *qp)
> +{
> +	struct v9_mqd *m = get_mqd(mqd);
> +	uint64_t addr = mqd_mem_obj->gpu_addr;
> +
> +	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
> +	m->cp_mqd_base_addr_hi = upper_32_bits(addr);
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>   static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>   			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>   			struct queue_properties *q)
> @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
>   	if (mqd_on_vram(mm->dev->adev))
>   		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>   }
> +
> +static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager *mm, void *mqd,
> +				       struct kfd_mem_obj *mqd_mem_obj,
> +				       struct queue_properties *qp)
> +{
> +	struct kfd_mem_obj xcc_mqd_mem_obj;
> +	uint64_t offset = mm->mqd_stride(mm, qp);
> +	u32 num_xcc = NUM_XCC(mm->dev->xcc_mask);
> +	struct v9_mqd *m;
> +	int xcc;
> +
> +	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
> +
> +	for (xcc = 0; xcc < num_xcc; xcc++) {
> +		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
> +		m = get_mqd(mqd + offset * xcc);
> +		m->cp_mqd_base_addr_lo = lower_32_bits(xcc_mqd_mem_obj.gpu_addr);
> +		m->cp_mqd_base_addr_hi = upper_32_bits(xcc_mqd_mem_obj.gpu_addr);
> +	}
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>   static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   		   enum kfd_preempt_type type, unsigned int timeout,
>   		   uint32_t pipe_id, uint32_t queue_id)
> @@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   			mqd->get_wave_state = get_wave_state_v9_4_3;
>   			mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
>   			mqd->restore_mqd = restore_mqd_v9_4_3;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr_v9_4_3;
>   		} else {
>   			mqd->init_mqd = init_mqd;
>   			mqd->load_mqd = load_mqd;
> @@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   			mqd->get_wave_state = get_wave_state;
>   			mqd->checkpoint_mqd = checkpoint_mqd;
>   			mqd->restore_mqd = restore_mqd;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
>   		}
>   		break;
>   	case KFD_MQD_TYPE_HIQ:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2ea1cfd330a9..d8631847f0eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -638,6 +638,12 @@ struct queue {
>   	uint32_t gang_ctx_array_index;
>   
>   	struct amdgpu_bo *wptr_bo_gart;
> +
> +	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
> +	 * TTM evicts it into the hibernation image, and repinned on resume. Set
> +	 * while the BO is unpinned so the resume path knows to repin it.
> +	 */
> +	bool needs_mqd_repin;
>   };
>   
>   enum KFD_MQD_TYPE {
