Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407EEFF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE34F10EB13;
	Tue, 28 Apr 2026 11:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLwsP97+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB5B10EB13
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDmveo4xCGBO0khmt0zgS2Oy4WK1v+/f8s40AXa3alcfwETxayAx2GSpyQKO9fOqYgFDxpGKrixohB+5MKmphgr4QmsMtMpEPysnjjMSsYZhtX3wGKN+iGjMQ0GpaWR+eRyh8P6Udf2ay/Cg6Cz0pr2ZGoPkQmlEg1b3Z8x/nNllz56m8kX0ss6o3VKfSltIGkvR9weDTglOjgOo0WCKEPpQmQd37x/sS5SJirxSuaT14Iiba3RsSU8OTjZFW7gpAvHShGJfqyJJ1PKsmV9wcDebIoB+mlToKdH5W+nWrlGMh1lSSIu5Gffnj+/0Fpu5oXRrXfVtyCoNB20ipV1fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu8ugt7wCNr4SK4/5SWFhUlO5ze5hRS/CZLvhQtxbqI=;
 b=CSu/YFxx7FWsTzH1TNLXlzaV+TG7fsgrEln4DLAo3BdFkqR8XK+0bJoRWFknmjP6iPMpXBxZQl1WX+qfEde1KL1Qc8JQ5ODvn7GiGZvgtZ41Knl8mJQ6sf2vKsC0hAQQd8ws6YWiEsS76MbczvuOKjIEf2X9gmOEYo0t5AJMrfwv93zHMpdD1c/nBE6gwx94xK3cwkS3jlc1RNleWBWTueP8qzerM6wNuhuWDbLWADMkUBR8+nYWuyjFE6tEdE/IaVIK1rtpbC5GpCtqLEmlP8FI2QxQQ3RzXWYw2EI7T8OcrgJ1eO0TBhGamUnK5zccQXVgj+Ju29aALja7+qwyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu8ugt7wCNr4SK4/5SWFhUlO5ze5hRS/CZLvhQtxbqI=;
 b=xLwsP97+estaxKqPenak67oxRM2yLJu1r6PWTgWdbtkDXPtphFmCnQg0gkBrz+GYe4Au/6jtuB716GZgxoZfxlAkP+CkxL+VJdMuKqcA67LpBs90p2kccGFuw/7/KAouWKtrp0PLJwfbN5NZ8ibL0PYKpStSyVw3plpY2G7bMLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 11:25:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 11:24:52 +0000
Message-ID: <c87a0195-4d04-4bb4-9b28-c2b0488c90d6@amd.com>
Date: Tue, 28 Apr 2026 13:24:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] drm/amdgpu/sdma: add SDMA usermode-queue
 doorbell pool infra
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:32b::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: a12813ae-e86c-4931-e9b4-08dea518c3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: CnJ8gpbQd8RnaHAuqK6hV99ci3/oe69nTekPiIq+F2Y50x/iOKhqwwvP6ILYl/oAAnw4spZ7wDB3m0QfGLMSKf7L3ImIYuCvE4vc12RtYZnaIWWXqIzcNANkTxHRGuBb7G78R5QKUa1T4hk3tQrGONnQ7vhJ9yHYofElZPAf5TShnCqIUFXetr6ZUpYPDn31sfAbcBbgXim0ChkJHVS2lpA6itCZEKx2YNi/fucBbAk4W/uPNJ72n5OXlCTHPIqa3hMTnJr1AvyXOaUGQvjMm79O0S+28/PYm7yIHuHKaMRfx3GpVSXL7smPL+UdBYDWSnUbEWBuWRIsp7awD4lBhiN6EUk63mbjb0v6+xwCt7iVFQcWGdjwg2JNzHCSpAfZkptRCHFMQ9/26oC6f3q6XC552tWGEqUcYo8d+gdqkpj56Cv6Tg7Bs/6j8kmZeb+ck5onG3TnK/0k5mbT08pWzzJ49atdlGsbqUHWVSnbDNhLMBAD/7AeWL1lYDffU3pszkdMrP3WTe82uTALw8MFuLCuZyrLH8WtTOC29CQWxMqrGFc9sg6YFgpwEyrCmyGg9qf/lcBSvbq0NklejUmfonCqfZ90Pck7y5UyLhtK5iiVP9BxQ/+6CKxXbSpXWeoXFQ+qq5yB8o6Y7qiPFgik9ZGlSjKds4s6P2K2irTRqooXnpImHQG+lXKcvjpDad8HDVzKuamaHuVYqc0nySKgvOSpd6k/9ep7Qsh+cbZQ8Go=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzErZDhBNkR4UWZxZVhLR29iS0N0RTZjYjFIM3ZRQWZrRUN0OGhXZElYeE9z?=
 =?utf-8?B?NHBXK1pMZ0tJRENDeDdxVjdvdWlkNUt6dUNaRFVXR0VLWldYYTR1ek1tbTF6?=
 =?utf-8?B?aXlpL1I5YnBuVzVwQjY1NFR4VjFJWU9VdE5GRVNxUG9XNWNpdlRacGVHbENP?=
 =?utf-8?B?Z3ZraC9SNDl2enFvcUhkRDBEVURtbWc1UGtGQy8ycDRFbkUxMjlYOU9kdWVD?=
 =?utf-8?B?VDFHWXNqRStBWmlZVUJsZmpyQW43aEZwcXBHWmkwUEJXelRGTFowblZFelFX?=
 =?utf-8?B?VDNlTzZ4elc3TFJZeWxVdzZvYU4xT2FTcFk4OXJTcUJ0WitYMHVhblkxRTJm?=
 =?utf-8?B?WlhUMnByZEo4SkJpSWd1aDlHdUdOYUJObGJlR1Y1VmdQa1VFekZaQ2pMNEVx?=
 =?utf-8?B?bkc4Z0JoM2MydHBic1ZDUUlNUmFmdURmeDRIQnFKNVlWZXFXa0Z5SEJ5U2pn?=
 =?utf-8?B?clRJN1I0dTIwTTFROUh0Z1lqNzFxUHdRekVzSkJMTjBCOFU0SWhQazVzdXQ2?=
 =?utf-8?B?Sk8xZkl5ZzhHcmxaMERvcUNYQ25GUVZCYmxpVEd1M0M3TGdIQmdVcjBQc2dW?=
 =?utf-8?B?ajBVUEhEcVd4ZkNpNDZ4cE0zZVgzdXRlWFEwL0NYbnViZ2ZWOXBnMnd4S0hz?=
 =?utf-8?B?TitFYzc5OGZtanBISEpKQzVwTHZlUlN6UDU2N3ZJdXl5RXliQWlOOTkrdXdy?=
 =?utf-8?B?MXNrRTlIV1JRaVQrUjZKdWMraUQ4UHhkazdjWWxGK3VrMHpFZ0ZpR3lvdnBh?=
 =?utf-8?B?MTRId3E4eFdISFZTaCtPeERaT1Fwek1tczM3L2pxb0lDY2dZNlcyYTY1Kzdw?=
 =?utf-8?B?Y3MvUCtkaU5yNmRCRElIaGZVZVlxWTlqdnFtUCtYdWhuU2U0Mm45SFVIQ3U0?=
 =?utf-8?B?dGR3OU1NY0ltd3UrS3kxS2RqNnhHSFJ6b1NtR1E1QVN5akhXRUh1OUFZTzBz?=
 =?utf-8?B?VlgzRXNqUmxsS0ppeXRac0ZZUmpOeGdQUllTY1ZIalNiMzVGK3JZL1FwMm5L?=
 =?utf-8?B?ZUdsMXJxUFlLcHlRMGw5eWFITHg0T2ZCRlJBTWFBcHRsZkxhN1dpUUJsZ3hT?=
 =?utf-8?B?cWNiMmRpdVRLOGJMVm5GZ1l0cUhKYUVMN0ZZamlaN3BLeW1BT1JET1dHV2tr?=
 =?utf-8?B?UWVQb0d5aERCb3I2TllmLzJhRzdXWXJYY0VsMXlTS3lMM0dLaDVzeFBUdTlK?=
 =?utf-8?B?NUlra21BNS9HMTltdGozSW5QQnQxWHhRK1NFeUplc3NFOUE4WU5kaXVnZG5p?=
 =?utf-8?B?T2JhbmVHN1gxYy9LOVlsdXlVZE5NSi9WYlFVT1IzQll6ZnBoSEJ6NXE2NSs3?=
 =?utf-8?B?aXpQcHdialJqYWJxN0J0S1NGN0JoUUdsVm5EMnU0TG0vWStudHBydUxaK3VJ?=
 =?utf-8?B?SHZXL254cllPOTdSdXVpS0l6c3pZQzVLRlNZMC96NXBpK3ltS1I1UE0zdzRS?=
 =?utf-8?B?R1pMeHU0aDM3MWNqeU1zQ1dJLytoNUR4dkxERXhMMi84Y09WNTZSNFlNRVM5?=
 =?utf-8?B?c1pWa1UwV2d0Sm9vSEd0VnMzRU1uWDlWYVhkQXpLYU9WeG8relNObEtjNk41?=
 =?utf-8?B?WHB1ZWw1VXlaR1FCb0x5NUJrTUxSaGdwWHRzNkxrcWtRUzE1M3Z6dGNYTlVr?=
 =?utf-8?B?MHJuVDhZcHZkdysxUzZYcFJvY25tYVJjcmNOZVlqUnZZMnU1alhZVXJYT21C?=
 =?utf-8?B?RkhvQWJaQnE0SlhjT2R0YTRlbW4yTjZ1dmJ3azRkaGpPRFNPNnNOOUVjTlNS?=
 =?utf-8?B?MGNyRE9GS2l2bjdhTkJzOVhUc3RiQUN2VUN3anJUdFNOTUtiZnNLaGpoUFRn?=
 =?utf-8?B?bEs3L3lyenpGOVFmcWdLSDUzVmpodE1LMnpwSndURkZHb3R3cXNPUnA0blhS?=
 =?utf-8?B?S1hwU2RxL3F4VTI1bzZobXNtZkxoa0RBdDBVNUhIbWZvZkxBZWlrRG9TaU1l?=
 =?utf-8?B?TFVEejhqSk9DeTlBVXgxSTUySU53eEVhUG91eDFvSTZ6SXk3TFNodHVmRS8z?=
 =?utf-8?B?dkhWd1UvUWM1YnhYZzdkcHBMMU1ENFRMMkJ6OGhFT1UvV0tlZ3BYMDVxczVV?=
 =?utf-8?B?QnBCamFoOVA0RTlCL2Jlcmg5c1drVDNWOEY2a0w2ZEdJNWJJaHdJNXBHbStu?=
 =?utf-8?B?a3NUT1NzWjNOeFZ3aUJ5UzVLak5hc0ROVXdDQWJ3ckJpTmt1djRIbGl4dXdM?=
 =?utf-8?B?c25ONWVGTDRXakMwWEoxbWN4eTVvdlFQQ1hoSk5JZjROZ2V3OVFSWkdJZWZr?=
 =?utf-8?B?SzNncEMxRlhuZjRHeDNXb3hFbXROSmZ6M3czMHh1VUkzU3ZROHRtb1psRWNP?=
 =?utf-8?Q?IWBt9SI3dxVnZIhH4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12813ae-e86c-4931-e9b4-08dea518c3ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:24:52.2455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diiedXZCxTBEsYYH6MFlPT3dwdGVhN+MfuQemKsITPS9Qf92bM1EgbZUPIA03lw2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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

On 4/28/26 11:58, Jesse Zhang wrote:
> Add a per-device qword-slot pool covering the firmware-managed NBIO
> SDMA decode window (BAR dwords [sdma_engine[0],
> sdma_engine[0] + sdma_doorbell_range * num_instances)) — the only
> range whose writes are routed to the SDMA back-end.  Kernel SDMA ring
> slots are pre-masked at init.
> 
> Exposed to userspace via a fixed mmap pgoff sentinel
> (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET, bit 56 of the offset, well above
> DRM's vma_offset_manager range so it can never collide with a real GEM
> mmap offset).

That is a pretty bad idea, we should use the approach we came up with for the MMIO BAR as well.

> amdgpu_sdma_userq_doorbell_mmap() does
> io_remap_pfn_range() straight into the SDMA decode window.

That is also a pretty big no-go. What exactly is the requirement here?

Do we need to use a global portion of the doorbell to keep the SDMA doorbells together?

If yes where the heck does that requirement comes from because that clearly goes against upstream requirements on managing the doorbells.

Regards,
Christian.

> The
> pgoff-sentinel dispatcher in amdgpu_drm_mmap() and the
> AMDGPU_INFO_USERQ_DOORBELL ioctl that hands the offset to userspace
> land in subsequent patches.  Same general pattern as KFD's
> KFD_MMAP_TYPE_* .
> 
> Slots are allocated/freed via amdgpu_sdma_userq_doorbell_alloc/free.
> The init/fini hooks land in the per-engine sdma6/sdma7 patches.
> 
> Suggested-by: Prike Liang <Prike.Liang@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 154 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  61 +++++++++
>  2 files changed, 215 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 321310ba2c08..be7e9de0630e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -22,6 +22,8 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> @@ -200,6 +202,158 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>  	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
>  }
>  
> +int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_sdma_userq_db *db;
> +	u32 base_dw, size_dw, nslots, ring_dw;
> +	int i;
> +
> +	if (!adev->userq_funcs[AMDGPU_HW_IP_DMA])
> +		return 0;
> +
> +	base_dw = adev->doorbell_index.sdma_engine[0] << 1;
> +	size_dw = adev->doorbell_index.sdma_doorbell_range *
> +		  adev->sdma.num_instances;
> +	nslots  = size_dw / 2;	/* qword slots */
> +	if (!nslots)
> +		return 0;
> +
> +	db = kzalloc(sizeof(*db), GFP_KERNEL);
> +	if (!db)
> +		return -ENOMEM;
> +
> +	db->phys_base = adev->doorbell.base +
> +			(resource_size_t)base_dw * sizeof(u32);
> +	db->size      = size_dw * sizeof(u32);
> +
> +	mutex_init(&adev->sdma.userq_db_mutex);
> +	adev->sdma.userq_db_bitmap = bitmap_zalloc(nslots, GFP_KERNEL);
> +	if (!adev->sdma.userq_db_bitmap) {
> +		kfree(db);
> +		return -ENOMEM;
> +	}
> +
> +	adev->sdma.userq_db        = db;
> +	adev->sdma.userq_db_nslots = nslots;
> +
> +	/*
> +	 * Mask out the qword slots used by the kernel SDMA rings
> +	 * (sdma_engine[i] << 1 in absolute BAR dwords ⇒ qword slot
> +	 * (sdma_engine[i] - sdma_engine[0]) within this window).
> +	 */
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		ring_dw = adev->doorbell_index.sdma_engine[i] << 1;
> +		if (ring_dw >= base_dw && ring_dw < base_dw + size_dw)
> +			set_bit((ring_dw - base_dw) / 2,
> +				adev->sdma.userq_db_bitmap);
> +	}
> +
> +	dev_info(adev->dev,
> +		 "SDMA UMQ doorbell pool: %u qword slots in BAR dword [%u, %u)\n",
> +		 nslots, base_dw, base_dw + size_dw);
> +	return 0;
> +}
> +
> +void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev)
> +{
> +	if (!adev->sdma.userq_db)
> +		return;
> +	bitmap_free(adev->sdma.userq_db_bitmap);
> +	adev->sdma.userq_db_bitmap = NULL;
> +	adev->sdma.userq_db_nslots = 0;
> +	kfree(adev->sdma.userq_db);
> +	adev->sdma.userq_db = NULL;
> +}
> +
> +/*
> + * Allocate one qword doorbell slot.  On success, *out_slot receives the
> + * slot id (also the qword index inside the userspace mmap of the window)
> + * which the caller passes back to free.
> + */
> +int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot)
> +{
> +	u32 slot;
> +
> +	if (!adev->sdma.userq_db || !adev->sdma.userq_db_nslots)
> +		return -ENODEV;
> +
> +	mutex_lock(&adev->sdma.userq_db_mutex);
> +	slot = find_first_zero_bit(adev->sdma.userq_db_bitmap,
> +				   adev->sdma.userq_db_nslots);
> +	if (slot >= adev->sdma.userq_db_nslots) {
> +		mutex_unlock(&adev->sdma.userq_db_mutex);
> +		return -ENOSPC;
> +	}
> +	set_bit(slot, adev->sdma.userq_db_bitmap);
> +	mutex_unlock(&adev->sdma.userq_db_mutex);
> +
> +	*out_slot = slot;
> +	return 0;
> +}
> +
> +void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slot)
> +{
> +	if (!adev->sdma.userq_db)
> +		return;
> +	if (slot >= adev->sdma.userq_db_nslots)
> +		return;
> +	mutex_lock(&adev->sdma.userq_db_mutex);
> +	clear_bit(slot, adev->sdma.userq_db_bitmap);
> +	mutex_unlock(&adev->sdma.userq_db_mutex);
> +}
> +
> +/*
> + * Report the fake mmap offset/size for the SDMA UMQ doorbell window.
> + *
> + * No drm_gem_object, no GEM handle.  Userspace passes the returned offset
> + * directly to mmap(drm_fd, ...); amdgpu_drm_mmap() recognises the
> + * sentinel pgoff and routes the call to amdgpu_sdma_userq_doorbell_mmap()
> + * below, which io_remap_pfn_range()s the routable SDMA doorbell BAR window.
> + *
> + * Same pattern KFD uses for KFD_MMAP_TYPE_DOORBELL — the doorbell window
> + * is unreachable from any drm_gem_object_lookup() / gem_to_amdgpu_bo()
> + * code path because it never enters the GEM object space at all.
> + */
> +int amdgpu_sdma_userq_doorbell_get_mmap(struct amdgpu_device *adev,
> +					u64 *mmap_offset, u64 *mmap_size)
> +{
> +	if (!adev->sdma.userq_db)
> +		return -ENODEV;
> +
> +	*mmap_offset = AMDGPU_USERQ_DOORBELL_MMAP_OFFSET;
> +	*mmap_size   = adev->sdma.userq_db->size;
> +	return 0;
> +}
> +
> +bool amdgpu_sdma_userq_doorbell_is_our_pgoff(unsigned long pgoff)
> +{
> +	return pgoff == (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET >> PAGE_SHIFT);
> +}
> +
> +int amdgpu_sdma_userq_doorbell_mmap(struct file *filp,
> +				    struct vm_area_struct *vma)
> +{
> +	struct drm_file *file_priv = filp->private_data;
> +	struct drm_device *dev = file_priv->minor->dev;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_sdma_userq_db *db = adev->sdma.userq_db;
> +
> +	if (!db)
> +		return -ENODEV;
> +
> +	if (vma->vm_end - vma->vm_start > round_up(db->size, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
> +			  VM_DONTDUMP | VM_PFNMAP);
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return io_remap_pfn_range(vma, vma->vm_start,
> +				  db->phys_base >> PAGE_SHIFT,
> +				  vma->vm_end - vma->vm_start,
> +				  vma->vm_page_prot);
> +}
> +
>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>  			       u32 instance, bool duplicate)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 2bf365609775..a308d5e6ee54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -146,6 +146,20 @@ struct amdgpu_sdma {
>  	bool			disable_uq;
>  	void (*get_csa_info)(struct amdgpu_device *adev,
>  			     struct amdgpu_sdma_csa_info *csa_info);
> +
> +	/*
> +	 * SDMA usermode-queue doorbell pool.  The window covers
> +	 * BAR dwords [sdma_engine[0], sdma_engine[0] +
> +	 * sdma_doorbell_range * num_instances) — the only range that NBIO
> +	 * routes to the SDMA back-end.  Each bit in the bitmap represents
> +	 * one qword slot; kernel SDMA ring slots are pre-masked at init.
> +	 * Exposed to userspace via a fixed mmap pgoff sentinel handled by
> +	 * amdgpu_drm_mmap() — see AMDGPU_USERQ_DOORBELL_MMAP_OFFSET below.
> +	 */
> +	struct amdgpu_sdma_userq_db *userq_db;
> +	struct mutex		userq_db_mutex;
> +	unsigned long		*userq_db_bitmap;
> +	u32			userq_db_nslots;	/* qword slots */
>  };
>  
>  /*
> @@ -185,6 +199,42 @@ struct amdgpu_buffer_funcs {
>  				 uint32_t byte_count);
>  };
>  
> +/*
> + * SDMA usermode-queue doorbell pool.
> + *
> + * The pool re-uses qword doorbell slots inside the firmware-managed NBIO
> + * SDMA decode window (BAR dwords [sdma_engine[0],
> + * sdma_engine[0] + sdma_doorbell_range * num_instances)) — that range is
> + * the only one whose writes are routed to the SDMA back-end.  The kernel
> + * SDMA ring slots are pre-marked so they keep working alongside any
> + * number of SDMA UMQs.
> + *
> + * Exposed to userspace via a fixed mmap pgoff sentinel
> + * (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET) handled in amdgpu_drm_mmap()'s
> + * dispatcher — same pattern KFD uses for KFD_MMAP_TYPE_DOORBELL.  No
> + * drm_gem_object, no GEM handle, no GEM consumer can ever look this
> + * up via drm_gem_object_lookup() / gem_to_amdgpu_bo().
> + */
> +
> +struct amdgpu_sdma_userq_db {
> +	resource_size_t		phys_base;	/* BAR phys addr of window start */
> +	u32			size;		/* window size in bytes */
> +};
> +
> +/*
> + * Fake mmap offsets returned to userspace for amdgpu private mmap regions.
> + *
> + * The high bits (>= bit 56) form a "type" field that amdgpu_drm_mmap()
> + * uses to dispatch to a private handler instead of drm_gem_mmap().  Lives
> + * well above DRM's vma_offset_manager range so any sentinel can never
> + * collide with a real GEM mmap offset.  Internal-only — userspace MUST
> + * get the value via AMDGPU_INFO_USERQ_DOORBELL.  Same general pattern
> + * as KFD's KFD_MMAP_TYPE_* (kfd_priv.h).
> + */
> +#define AMDGPU_USERQ_MMAP_TYPE_MASK		(0xFULL << 56)
> +#define AMDGPU_USERQ_MMAP_TYPE_SDMA_DOORBELL	(0x1ULL << 56)
> +#define AMDGPU_USERQ_DOORBELL_MMAP_OFFSET	AMDGPU_USERQ_MMAP_TYPE_SDMA_DOORBELL
> +
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>  			     bool caller_handles_kernel_queues);
>  
> @@ -205,6 +255,17 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
>  				      struct amdgpu_iv_entry *entry);
>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>  			       bool duplicate);
> +struct file;
> +struct vm_area_struct;
> +int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev);
> +void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev);
> +int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot);
> +void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slot);
> +int amdgpu_sdma_userq_doorbell_get_mmap(struct amdgpu_device *adev,
> +					u64 *mmap_offset, u64 *mmap_size);
> +bool amdgpu_sdma_userq_doorbell_is_our_pgoff(unsigned long pgoff);
> +int  amdgpu_sdma_userq_doorbell_mmap(struct file *filp,
> +				     struct vm_area_struct *vma);
>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>          bool duplicate);
>  int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);

