Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79452C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 12:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1457211349E;
	Wed, 17 Apr 2024 12:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="239F9jLr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E7811349E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 12:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN7LhDu9WEndbB3VAshUuv70d2ubkOks8aZZ8L/knIID2jz7wF4BOnDt+pzjrAc37OqKAc8RHFa1MdG2qWHjiWUNVvKxh5a3dJ7m2GTRwNTiXSfJJZffaFG6IwxIQX18aKfjCwOz5Itvhbmys1cs0uk5PdDZ9zPoZIVfP9PdcLbQQqaOQxF/aAOhOn2E23h+Qi4lpnGiTAjDuyxBSgsEBuxri3hSxxrDjLC0YiUfPbRnEvBhCkXE7bR2KSE52idIcoMO4MFrB/SRishUyXGAVvFE2jkTnX9HEwWC4kgd/mzPwr158RqUJJZpN/yc6/L0JkaKQJ5R/ovQJ0828VYAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pQBERXycXuEJOm+9vCDUcau6dPWiKj3EegPYqJne10=;
 b=WuTsphhH3NuvI9pe0adr5AHiEEh4SgBcGEvP6GSayczrZV03x+/9qWrENea/x97VN8yy/Ob2kkotV0uRzBFVuXc2Me+5enaoiVDfoqjlCywt/nV9XedPL+gf0CjGdshy0pXBNbaGgFFV2V6Fes3zaZ+FXTk0sv1jrarEUMW9WxcZn0cVH+x+7wG+XqdU94zfbTs5YSi5B4GmKt8OV/w0VRNlbDmfv4GI6bkf339ltlTJtEdX5C/W5bKvJ0b4mCBIWOcEueKOevrb/yUPW9tWGOrbzGCYjHn96pJnPcTVizhBtgzTYPLrJQsAsqjPEQ4fP+gdYPIZEMrKrij1vpI/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pQBERXycXuEJOm+9vCDUcau6dPWiKj3EegPYqJne10=;
 b=239F9jLr8cqCPtE2CabXehyQNi1YZtS3NF8WOxoUlbopVKMJjE8m8d6GzMldvDQ96GwADbHpAs88wCsuDQnb+unNBpMbSsYdrrFbnWkfgJMpGIV+49eo89P0c10ra3zrUvn1oICXKlGEeJZenAqOkMfw3R6jao+Q88y5FUn9ODw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 17 Apr
 2024 12:49:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:49:35 +0000
Message-ID: <8997494d-4b4e-4522-acbe-af44a8320c3d@amd.com>
Date: Wed, 17 Apr 2024 14:49:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Jack Xiao
 <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Haijun Chang <HaiJun.Chang@amd.com>, Leo Liu <leo.liiu@amd.com>,
 Jenny Liu <jenny-jing.liu@amd.com>
References: <20240417113025.2886905-1-horace.chen@amd.com>
 <20240417113025.2886905-3-horace.chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240417113025.2886905-3-horace.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: c60a9fa7-9f46-44da-5526-08dc5edcd5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76woQVJAnAATjY9yFQJD81ochqSuhRK4JewyvXtQZVaVdVPwm9ZxUTuWjHIbVf9zXxW5/2/50H1yXOQOB16W28ZvHblp2AuHeNEEVgWKh+7aFIKxai3a7RdFxu8O2fFT7pfAY0d8G/J69oS63EBOyNmo24205AjU8et1etnhOM4vshcyxlYfY38+9Muq1DEUbf3pdnZDYy9UkpxKL07gIcNDeWhM6WEBHm5W4mYBXnLVWUT8WNLzYK/+bL3ACfHbKqfC743pLVmE6aXhb4bPnk5q8g3Ksd3Aoef6UYCzEg/b1IHhUSm0tRIWyeupglP2NHqspS71ECboTUA3IQ50yo49XweFpATrdIpgXG6SprzbykSJ7tEGvkYoEVCIIMTZ+vnrVdhR3Zs26tiUmBJPmSqfN4thADYDCTqyxi9+n8IbKcJ7hfvuUWIDKvg/H3Bks90CYXc6Ou4NjmuMWXeMaNGvcZ6n+NWH22R+w8knmF9lAdNnk/C4zACGQZpL/54pwh6Xq8VgsPYuhUiQToVtHQyRCeIOiI657KC31viAAxDApGnQTAaM4quDy+XNwURuugk99UeWTqBjvkcv6N2kJ+BmEHhcdqZZwjB08eU+UUWLZNZPN0DMiv0Wbw9jWiir147HNHp094bu5dfHPoUbfJRei27ZGpE5V4YxBBq6vUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJPa2pMbkFJaFliM3p3VlpsUTlxUXR3Q0Y2bTQvWkxoV1FTRXFUVUdVVHpv?=
 =?utf-8?B?Q0NWblI0b3VGZkF1WHpOL3NtM0p6dzdlTVZFUWIvcGdyTC9oZnhQaDhwMi9i?=
 =?utf-8?B?QUY1VmtOTmk2Y1FzbERMNWh0SUI0RGF1dTlUZDBzd285UFJZMG0yYndBUmZV?=
 =?utf-8?B?T3pweUpnZm91SmxsNy9vbkxobXZKVDBybWdST1lTVEJWd3NmcmZGNXhmbVhS?=
 =?utf-8?B?Q1ZhM29HNVFma0tWZ1pUdU4xZjN3cWJnYzlJZ2h1dFhrM0lFdUxmYS9DZnRa?=
 =?utf-8?B?WURZbFdxMnFBVWxkb2JRSG5oRzVROCs3a2VsdnR2MHVEVUdXSlVuZjVkYnpv?=
 =?utf-8?B?SDhoaG9GNTVHb3JuUmR0MWhSMVB2ZzlFclVmS28vTktIa3FsNTVqaFNCMG0z?=
 =?utf-8?B?K3ZPQ3lMMmFlT1NkSi9YTmNncXBWa0VTRTVNUmdRbUF4OVd1QmFTVWJtVWlE?=
 =?utf-8?B?UVd6dXRKdzdqUnh2NVlYK2FtVld1ZWxPaXRDbGlwOFBmTWw0a3FPc2NiZ3pB?=
 =?utf-8?B?OVhkVXZvc1NmV1VuODd4eEJTMTlIbVhldXdwaTlUWDhObzF6R3FpdzZJb1Nt?=
 =?utf-8?B?bGJINndVbHZJVkVGL0R4c2lPajE4RVVEdkpEK09LSEVXS3I1OXg2YkNaWmht?=
 =?utf-8?B?V05HOFhhRWx3QlVhY01Oc1pNMUVMNXVnVHVPSmsxdU56bHdWUDN0SkhxZm1t?=
 =?utf-8?B?NzRqQkVGRU5ESlpnN3pTK1FMbkQwVkkzK1BNSFl1QTVzTEVTWUFIOUhIQk1i?=
 =?utf-8?B?TUkwZ3pTOGtWMmw1YzVrcFpFM1lENE9lUU5kOUh4UFBvYk9DdFExYTFpb0Np?=
 =?utf-8?B?d1NobnNURXJWUWc5VlFqdUw2VFB2K2VES2NTZkVJQ01jV0xiM0xmbDZMQWtO?=
 =?utf-8?B?aU1DbysvL0g0d2ZkOHFYTXE5VllOQmlrQU5UbjE4b3NwdDh2eXhiWS9BL2JO?=
 =?utf-8?B?Y2VlenZIWXJ3M2Yxb1g4VEFwS2VGZVp5dmNYNzQwS1J3WTI2Nm1pakFubTQ2?=
 =?utf-8?B?QnBRM0Fia3B4TGszUjV5VGx1M0o3RjhiMFplMFZ1WkhyaWN3b0JkTTBhMzY1?=
 =?utf-8?B?V2ZRZVV4VVJwZGU2Z0dXUG1BRGRGemdBZnRaZlNMSXExL25uaFZRbXRDWkFn?=
 =?utf-8?B?Uk9jWEpDYXRub0RDbU0zOFZEbS92TzJndnRaM2FxR3RKL3hjNk1GTFdkL1Aw?=
 =?utf-8?B?QkV4bFg5YU1ka2V5L21QdzBOcS9adzVDMTdYT1BPWnJZeXk2UmwrV0xaSDZw?=
 =?utf-8?B?RDFEb2ZjdXkveUw2cW9aVzlwWUtSbjJPMThxRGRyblhMaUR4TjQ2Q3NIbkZz?=
 =?utf-8?B?c2lsUzFYeFVQMmtVZXRnTEIvY1J4Wm5NcWhpaGR4dlUza2ZJK3FCQ0lTYWdw?=
 =?utf-8?B?dlRqbFJRTzZUU1JLK3ZMK09OTXo0Um9GU3NzdnpJazJxdlBwMDMzRHhRbmVm?=
 =?utf-8?B?REYya3EvNGtvZHNZaEFsdFVqWWpnMUFDNlJSYU9SSXl6YVZvWElnczhSY3BW?=
 =?utf-8?B?N2dtMEt4L0M3UmtpY3BWNUg3TXJoZi8vTlZiSXhLUi8zSUJLaUg4bU1xVmVt?=
 =?utf-8?B?RENVcTMzdFNQLzNIYkNydExST25LSy92VnhIODI5Vk5iMkIvUVhKdTRZTFA1?=
 =?utf-8?B?YnJBMzJLQ2E1VVJZVmNKbmhmR0ZRdWRLclBVcklMVFZwcVdSR0hWcVJscGda?=
 =?utf-8?B?UkU3Q2EzeGkvWXNJb1ZaeWlKQkFwN0pmY2FnVndWZENPaFpCNUlKQzhqbWlN?=
 =?utf-8?B?SkFKQ3ZIY1FnUWhKUm1zSlV4Nm4zMW94Vjc4Ri9PZzZ1T0JuWStFMzJqSjdC?=
 =?utf-8?B?end6ZFRXTnlpbkpFbHI3WURudjhweDl5R04zNk03QWZIc2h6VHRQdjNaTTBo?=
 =?utf-8?B?VUJKTHVMUml5Z1duRWZBUENPa3hNVmMwQzdQMzJYREluZVZFandjUlo5ODNm?=
 =?utf-8?B?dFBYdFRrYXZxQXlXdFBDRUhaTEpWZ3RLY0VITXkvN1VQYXQrSlh6TnpFcEJI?=
 =?utf-8?B?WnBVMjlBcjl1cXJHNFNGUE4vMnZkNmVqNFZSUU81eHluM054d1VKSTZaNkhh?=
 =?utf-8?B?K0dDRmhlVHIrU0c3NTdqS0swNmttd2hpT0srYjVSUTQ4cURZOWkxVElOVEJB?=
 =?utf-8?Q?bBfY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60a9fa7-9f46-44da-5526-08dc5edcd5f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:49:35.7204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsFcGBbGuLm6qa4bsDWef9NZrIGaA7KlIx95D13IanvL+FTiC05WLkWHjJps9pJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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

Am 17.04.24 um 13:30 schrieb Horace Chen:
> The MES firmware expects synchronous operation with the
> driver.  For this to work asynchronously, each caller
> would need to provide its own fence location and sequence
> number.

Well that's certainly not correct. The seqno takes care that we can wait 
async for the submission to complete.

So clear NAK for that patch here.

Regards,
Christian.

>
> For now, add a mutex lock to serialize the MES submission.
> For SR-IOV long-wait case, break the long-wait to separated
> part to prevent this wait from impacting reset sequence.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 18 ++++++++++++++----
>   3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 78e4f88f5134..8896be95b2c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -137,6 +137,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	spin_lock_init(&adev->mes.queue_id_lock);
>   	spin_lock_init(&adev->mes.ring_lock);
>   	mutex_init(&adev->mes.mutex_hidden);
> +	mutex_init(&adev->mes.submission_lock);
>   
>   	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>   	adev->mes.vmid_mask_mmhub = 0xffffff00;
> @@ -221,6 +222,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	idr_destroy(&adev->mes.queue_id_idr);
>   	ida_destroy(&adev->mes.doorbell_ida);
>   	mutex_destroy(&adev->mes.mutex_hidden);
> +	mutex_destroy(&adev->mes.submission_lock);
>   	return r;
>   }
>   
> @@ -240,6 +242,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>   	idr_destroy(&adev->mes.queue_id_idr);
>   	ida_destroy(&adev->mes.doorbell_ida);
>   	mutex_destroy(&adev->mes.mutex_hidden);
> +	mutex_destroy(&adev->mes.submission_lock);
>   }
>   
>   static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 6b3e1844eac5..90af935cc889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -85,6 +85,7 @@ struct amdgpu_mes {
>   
>   	struct amdgpu_ring              ring;
>   	spinlock_t                      ring_lock;
> +	struct mutex                    submission_lock;
>   
>   	const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index e40d00afd4f5..0a609a5b8835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -162,6 +162,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	struct amdgpu_ring *ring = &mes->ring;
>   	unsigned long flags;
>   	signed long timeout = adev->usec_timeout;
> +	signed long retry_count = 1;
>   	const char *op_str, *misc_op_str;
>   
>   	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
> @@ -169,15 +170,19 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   
>   	if (amdgpu_emu_mode) {
>   		timeout *= 100;
> -	} else if (amdgpu_sriov_vf(adev)) {
> +	}
> +
> +	if (amdgpu_sriov_vf(adev) && timeout > 0) {
>   		/* Worst case in sriov where all other 15 VF timeout, each VF needs about 600ms */
> -		timeout = 15 * 600 * 1000;
> +		retry_count = (15 * 600 * 1000) / timeout;
>   	}
>   	BUG_ON(size % 4 != 0);
>   
> +	mutex_lock(&mes->submission_lock);
>   	spin_lock_irqsave(&mes->ring_lock, flags);
>   	if (amdgpu_ring_alloc(ring, ndw)) {
>   		spin_unlock_irqrestore(&mes->ring_lock, flags);
> +		mutex_unlock(&mes->submission_lock);
>   		return -ENOMEM;
>   	}
>   
> @@ -199,8 +204,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	else
>   		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
>   
> -	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
> -		      timeout);
> +	do {
> +		r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
> +				timeout);
> +		retry_count--;
> +	} while (retry_count > 0 && !amdgpu_in_reset(adev));
> +
> +	mutex_unlock(&mes->submission_lock);
>   	if (r < 1) {
>   
>   		if (misc_op_str)

