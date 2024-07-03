Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497E3C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 09:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBADA10E312;
	Wed,  3 Jul 2024 09:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Ry+YeI7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C3F10E312
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 09:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs+OLjQSH51rxCOaiaMj745ZXy42jzt/mQk3edg94O5/amjjLwVlDrlLrTehaEfCbexAV42lO8m+UZqlBwJFidWN5EmWUST/qdiXFzfKc0NIEsJfvtRU1pgCNqJ5mKZzwm6cfFIJgv5BS+oVZcTQ6iQhTPxkpwN2Eeu2TXhFPTe+cobOnnzA0sbbpk284UsBMXPcpYBnRx6I4A0OnAgcKbFd8X1qVwAk1HoUAWRBsfYwLfiMZrtJyMBuQ9Voc7v7FxZdMafEJ0c72TK2feCgJgw6xhVhgnxi1x1vZzE1zfAQg8qQKLzCanM7SIJgbGgeG/xPeRrFYtepOALMkrUBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a288N5nPAvgB6jH/KqJN+Ofxv0aucmqL9JT5rP67urw=;
 b=nNr6Hni0dQiwd5HC6nRDv/DC5WIQGL+0/j4qJMoU1yw9GBhg7JYJZsQskJilvE9fqc0+uQgTcDGeZfOj/26VsTyjZQVtn4XCzO75EjslBtRnHxtsi8xNIE38TUHj5tR0zdcxHHNgfAqxTbmDpXwjRbSg266KSIoC77ig9ifVHebprs7JBply1SOhPg1nv59L7882Ib8kl75o8z4ZoL5XnfUr23P2h2zu+j3k1xwb/y2kydv9aJQJWE3E5dIFedsMw1u96So5VJcttNEU75P+hfYFrg9mNl5ORHhvHO1aWxiaUWHpxeACrPf+Uffb0I8A393/c6G6+LHkFyGBbK36Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a288N5nPAvgB6jH/KqJN+Ofxv0aucmqL9JT5rP67urw=;
 b=1Ry+YeI70X+D2OGkOHibfZ1ExzpoyT7dWOje0LiO2N6Bc0UAKD/j8BaJtdDVJMEpVwiptI2o+dTDDBPVFOIdHRdoPajMN9ZiGMbbN6R25DY3vrj37So9IuE7q5nld14zRdRMVmbrW6nCtq7OIHF6go7+ryGOmFLwtNm0Mn5G8k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 09:25:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 09:25:44 +0000
Message-ID: <918275d8-788a-421e-b791-3d9537dbcead@amd.com>
Date: Wed, 3 Jul 2024 11:25:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: : Fix the null pointer dereference for
 amdgpu_device_switch_gang
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Tim.Huang@amd.com, jesse.zhang@amd.com
Cc: alexander.deucher@amd.com
References: <20240703090144.11241-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240703090144.11241-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1fd794-6765-4ae4-495f-08dc9b421d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d240Sit6aVB4WnFUUElxYzFNdzdEWTRXS1V3c2h0TGVVYVhQeHNXN2tpT04r?=
 =?utf-8?B?R01rSWNJNVFwWXJETTAvbWpYQ2xKdjRIUFhBZUc1V3RwekZKTzNEVnNkZTJN?=
 =?utf-8?B?bHB6RHpNbEZSV1M4TmJUbHRQeW5vM3RsLzYxU0FQTHBwejQ0R3hHTlB4dURF?=
 =?utf-8?B?VWpQQ2VUSk9DeW9KNzhsT1FOSTNEc0ZRcmJIYkF3azc3cmpYRjg3Q0RIUzRP?=
 =?utf-8?B?OVVHOTBOVU5ZdjR1emI4MjRGRWZ6S0dVYmswOTk0L0FBVml3UGY4L1dkYzNo?=
 =?utf-8?B?YUprR3dvd0krUEtRSFozWENMd3dpSDV0cnp1UGQ5bUNkeXVCZjJmWDJuSjhI?=
 =?utf-8?B?cnRaV25ldnNKTFl0VGZMWGMvYnBZUkZDekE5cG1QRXRGdjFvd0ZzYlZHa2hq?=
 =?utf-8?B?c2VBWE1ZUUY4TnJuREZBSVFxWWhDdFZDRWE5K096WkxTNVd0cGc2bS9JdThZ?=
 =?utf-8?B?bkhuOHpWMlJrUlBVL2NETVRKSG5hbkJYSTk0b001OVRCendDV3dZNDVnUTFt?=
 =?utf-8?B?ajk0cHY0ZmVZYndyc2E3cjh4RGVDWUxsYTJtVGNUMnhFN05GUDQzQ2M1STN2?=
 =?utf-8?B?T1dPbDFGVDkwKzZiTVdpSm8zalhBZnVUV011aXNQUU5oeVBZRU4rNEVuY2Jk?=
 =?utf-8?B?bnlkdmUyeFd0ZWJ6RTVKV3l3NkpIS3ZOdk1xYnpVOGRBU29COVVPYVpqZjJx?=
 =?utf-8?B?YXBSdTltWGVIWnZCZHdreU44V0dEajBaM1ZaZjdRS1dHR0lDbGRCTDRoOXIr?=
 =?utf-8?B?bldHOUZiRkRDKytzRmpFckcrUzE1d1lEcEpMbjFaTk1zbWFhLzF2M0czaEx2?=
 =?utf-8?B?ZGpHcmVwWnJXMFpJRXNVTGdhSFliMFROWnRxK3J6cjlyeFc5eVBELzN1eVh2?=
 =?utf-8?B?Rno2ZGxQd09Lbmc0WEZkaVJqcEdDNTRrOVM3dXZ3TlA4UXR1bTJscFVIUVl4?=
 =?utf-8?B?UEUyUGtEOWQzbmVxa0lXWjJoQTFYMTNEazlvbkQxV0drdDdJMG1ablovWC9w?=
 =?utf-8?B?M3ArZTY5TnozRUJJaEU3S2tnRS9DSSsrNy9kVjdKQzZ3aStBOGVhYklSVnlS?=
 =?utf-8?B?TVdNWmlFVFF3bnlELys5RjgwQm9leC9nMlhsOENqdENYdE56b04ySDBnK3Ri?=
 =?utf-8?B?L1lWZlJPQjB2TlRvQVJ5TXRpZ1RZcG1ZU2tYZm1obzdyUGNjSXB3UEZaUnBy?=
 =?utf-8?B?cnI1UjZZWlVCWVQ0cTJvV0tLTU10Sko1RDl6TFNlOWlKMForUTBWMkVHSjZp?=
 =?utf-8?B?NUpLUGFPUDRiL3BpWEs4RHBMWW5iRk00cm1zbDZEQ05mQXJERVVhVHEvNjVM?=
 =?utf-8?B?aFkrbDhJck1aTUZNS3hTVTM1cWNHWDlPMCtkTHo5ZmdBejBkU2drWUNnUTJo?=
 =?utf-8?B?R1pleTBESVIyMUUxbEJJRW9zK2VodXN1YmdsUmVINzBLQ2cxeXRhbzFIMHJs?=
 =?utf-8?B?b0JBZm5PUkRrTkFMaUFNck5NVmQ4RHRrbThJaDJBRTZuVTZPRU5GZVpjaDhU?=
 =?utf-8?B?VjF5M2hjZnU3anhpdXNlenR5cWhsZzYrVUJ2aTI1OENzVkluNUkvU25LVlJk?=
 =?utf-8?B?VmFJSFFHejYvV0d3cUFmNGVwU0JQaHlqUHd1akl0OCtMMHp2RURtTmtUSUli?=
 =?utf-8?B?S0MvT1p4WlhzSk5nbjVmNTJHZVkrZ2JpTGI3anZ0bCtRUU8wSWM5QzZPNkxp?=
 =?utf-8?B?UlAwZllFcWxoUWFCaDZQRXBaY2dXa3NGV0hRZFY3UkgrNWNaSU9ic3FPOE56?=
 =?utf-8?B?d2VDSTE5NzBCdGQyRUxOZTV2L1c2L0owSkVCSG1YR201MTNuZWhaaUpXNkRa?=
 =?utf-8?B?dVRhZlc5NXMyWW9TL3N5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0JPRnRzN3hQaW5KakE5VVBqckR0NFhVOGRud0srUUZyeGtJOUF4TC9xUXNZ?=
 =?utf-8?B?UTZlTmZTNE1XZU5wcEUrNThaRDNiQk5TNDJRM2FTNWJkU0RzRWE4NmErRk5M?=
 =?utf-8?B?Z0xocm9TajJrb0JJdFVnYTZqYms4S0ZTdHlwQ2QraGs2Rk96bDByN1NiUzZy?=
 =?utf-8?B?cXM3M29wYUYwVTh0ZEZxbG0zSmFMM3pPayswbjQrN2hKQkQyNkNJTGFlMU1k?=
 =?utf-8?B?bHhNRVdOU3U3VmlCRlRGRUthTmpiSEMzdjJVV0NUYlhibWd6ZVNYSnMvU1VH?=
 =?utf-8?B?NytGT2FKMnhTbDZuWHgwbzhYSkVoSXRRNFZzeC9QcE45UWUveFhHTitrSzRx?=
 =?utf-8?B?OFRxM1lYYURFczBHRzE2cklidWN0OFFaLzlnZURSbGNFUzhjb1dSSlNxWUJj?=
 =?utf-8?B?M085ZWxtVUtETllSZlQ2WTdETDdlR3FKQ29oQWxBcko5Wmplb3pscHpTd2JW?=
 =?utf-8?B?Z1JIVUE2VVdIZDQ4Q1kwTVpncU80dTMxMGcyalUyblVqbTM4ZElndDlBSHdi?=
 =?utf-8?B?d3A1NXkvNVZZY2NSUEFPdXgrcUR5Mm4rQXdxTVUraE40bmV1c0ZFR1gxN0Jx?=
 =?utf-8?B?VXdpZDg1UTBQWGU1N1dZNGdRb3AyNjlhOTNsMFNMckJyOWkyazdEOUJLOFhn?=
 =?utf-8?B?OURXZjhrT2VoaVlvZkQybjFkL0R4YzRQaGRZd2xFbjNrSytwOGo2SXFKTVhR?=
 =?utf-8?B?SGhPaEpQVnRsTVdHaUtWMnhYM2FiMDVNYWs1bzJlTjllRXovalZxWHRLSURL?=
 =?utf-8?B?WjZwR0VscmhBNTZ0SGE2WkNyditqVWVrK3YvQWJPZDhCdkgxa0dLQ0VkVUtU?=
 =?utf-8?B?aGVURURrV0tQZTlQSU1CUHlkc2o2MWRPRkx4UUo0SFZqNjJ5bkU1NHNKTHlx?=
 =?utf-8?B?YjJTN0lySzA5WEZSdisvNHA3S0t3d2NLZmh6N2FPZXFpMU1iOFZhSlE0a2Fw?=
 =?utf-8?B?ekZTWVJKREtLWGhIMFJFY0dtSng4QXRDendPMEhNS0ZtcGFsTDhMcDVoOU5D?=
 =?utf-8?B?YWI5R3VtSlNTWi9FUHNOY0FSWUJ6QkdObXkzWTA3UG95bzF0bncwZ1VlanFX?=
 =?utf-8?B?WUpXWUJGUnVTbjRpTGVJRk44eFYydkdUQXFCN3h6RStJWSt0MG9BSEc1Tysr?=
 =?utf-8?B?T3ExRUZrb1F0cnJHUUY4N20vRUFmckZ2ZkNpOHFXcTVJWlVoTm0yVXJvdElD?=
 =?utf-8?B?MWRuNFlhUDA0b1c4WkxxWnIxVlk1bDBFdWlZTUdWZjRuQlpXdTVidU5SRVN6?=
 =?utf-8?B?NzB4NzV2UWN4OG9xbER5VktlRzd5dTU4Y0lQOElxZEJUdTVRK3RLUW8zMWl4?=
 =?utf-8?B?eGhLRkFKRmt0aDQ3b2xDWDZhN0dJeDJwc3VLOWxrMERsaWdhT3pnMS92bnpP?=
 =?utf-8?B?MTFZWDllTFNYNWtENnVwK2srNmFTdm5GTi9FZ2xob0l5cGZscjd1a2oybnNv?=
 =?utf-8?B?Nnh5VFVLMWgrSmp4NmEzOW14dlJJbEV3dkN2MUV6NlJiYkVoWkRQdzdRSnQv?=
 =?utf-8?B?Z3B4U2xKa0J3NmhWWjRWelFTRnJ4M2hBY2JOYXU0ZThSME9obWNyTnNFYU1a?=
 =?utf-8?B?NFdsNjdzNWg0YkRjcnNqMlA0T3Zrc0JSWW5tSXVrU1hQaDlQdk44TE4rbEZ6?=
 =?utf-8?B?ZitGaTJraDA0TS9IM29ITkRRY0hsMzYvVDdtOWkxVXVJcVFTdzZJY1JvZGVu?=
 =?utf-8?B?dCtubnNhMldEYlhRZmtjMkJUVWZrTzdFUjJ5R3RBdVpvTkJ1OUFEbVdEVTI3?=
 =?utf-8?B?N29lZVNHbDkxaVNYc2VVbDF5ZEg0MUEzdU56bzNzRnJ4bzNiT0txY1k1WDI2?=
 =?utf-8?B?US84ODkyV2F4NFhlUVRjVTZKREZQd2lvY3NnYlJjZUxSSkw4REFNY1ludE1k?=
 =?utf-8?B?UGZyT2thOXpmSTE3cVdlalcxMWU5Rkw0UmxHVVh5ZURCL3lRL09uek41SENZ?=
 =?utf-8?B?eTFHMHB5c20wOXVBSlpFYmhicENLUm9YT3ZZVkZJN0UrV01XM2tWcFJxbVFn?=
 =?utf-8?B?SUd3RFprZ3FDY2svNGVIMUlBVFNSMWxxbHRBL1A5UWlsdUxhLzdkZXdVYmxy?=
 =?utf-8?B?YitqVVBKMXZQRWpzT1Nyek1wbjQ5Vm1BcklkeVgxazVjSkFJa1Iyc0Q5Z0dy?=
 =?utf-8?Q?zdUBKsPl1XuYboWX1zOfeR848?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1fd794-6765-4ae4-495f-08dc9b421d74
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:25:44.6859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crTWKUzXK9ZKkKF9lDUo/nUXZIyxvceX7WyEr1OF8cZPoIha0PYHPHV4E3bvTWfZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
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

Am 03.07.24 um 11:01 schrieb Bob Zhou:
> To avoid null pointer dereference reported by Coverity,
> so add null pointer check for the return of amdgpu_device_get_gang().

NAK, that's complete nonsense in the first place.

The pointer is guaranteed to be never NULL or otherwise the logic would 
have crashed long before.

Regards,
Christian.

>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bcacf2e35eba..c1d82c346daa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6569,7 +6569,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>   		if (old == gang)
>   			break;
>   
> -		if (!dma_fence_is_signaled(old))
> +		if (!old || !dma_fence_is_signaled(old))
>   			return old;
>   
>   	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,

